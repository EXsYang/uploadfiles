# 说明：这是在学习尚硅谷JVM精讲 OOM案例和性能调优时的笔记



# 1 `.hprof` dump 文件默认情况下不会覆盖同名文件，GC 日志文件默认情况下会覆盖同名文件

你提到的两种文件，`.hprof` dump 文件和 GC 日志文件，在 JVM 的默认行为中确实有所不同。

### .hprof Dump 文件
`.hprof` 是 Java 的堆转储文件，用于捕获某个时间点的堆内存状态。默认情况下，JVM 在生成 `.hprof` 文件时，如果文件名相同，通常会避免覆盖原有文件。这可以通过在文件名中包含时间戳或其他唯一标识符来实现。例如，使用 `-XX:+HeapDumpOnOutOfMemoryError` 选项时，生成的文件名通常会包含时间戳，以避免覆盖。

如果你希望明确设置堆转储文件的名称，可以使用 `-XX:HeapDumpPath=<path>` 参数指定路径和文件名。

### GC 日志文件
GC 日志文件用于记录 JVM 垃圾回收活动的详细信息。默认情况下，JVM 可能会覆盖具有相同名称的 GC 日志文件。这意味着，如果你使用相同的文件名配置 GC 日志，新的 GC 日志会覆盖之前的日志。

不过，你可以通过以下方式来避免覆盖：

1. **添加时间戳**：
   通过在 GC 日志文件名中包含时间戳，可以避免覆盖。例如，使用 `%t` 或 `%p` 占位符：
   ```bash
   -Xloggc:/path/to/gc-%t.log
   ```
   `%t` 会被替换为时间戳，`%p` 会被替换为进程ID。

2. **使用文件轮转**：
   通过 `-XX:+UseGCLogFileRotation` 选项可以启用 GC 日志文件轮转，结合 `-XX:NumberOfGCLogFiles=<n>` 和 `-XX:GCLogFileSize=<size>` 选项，JVM 会生成多个日志文件，并在日志文件达到指定大小后自动轮转。
   ```bash
   -Xloggc:/path/to/gc.log -XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=10 -XX:GCLogFileSize=10M
   ```
   这会生成多个日志文件，每个文件最大为10MB，总共10个文件轮转。

### 总结
- `.hprof` dump 文件默认情况下不会覆盖同名文件，通常会生成带有时间戳或唯一标识符的文件名。
- GC 日志文件默认情况下会覆盖同名文件，但可以通过配置文件名包含时间戳或启用日志轮转来避免覆盖。

根据你的需求，适当地配置 JVM 参数可以确保你获取所需的日志和转储文件，而不丢失重要信息。如果你有更多具体问题或需要详细配置示例，请告诉我！



# 2 Linux 操作系统有 32 位和 64 位两种版本。

## 具体来说：

### 32 位和 64 位操作系统的区别

1. **地址空间**：
   - **32 位操作系统**：最多支持 4GB 的物理内存，因为 32 位系统的地址空间是 2^32 = 4GB。
   - **64 位操作系统**：理论上支持更大的物理内存，可以达到 2^64 字节，实际支持的内存量取决于具体的硬件和操作系统实现。

2. **数据处理能力**：
   - **32 位处理器**：一次最多可以处理 32 位的数据。
   - **64 位处理器**：一次最多可以处理 64 位的数据，这意味着更高的性能和更快的数据处理能力。

3. **软件兼容性**：
   - **32 位系统**：只能运行 32 位的应用程序。
   - **64 位系统**：通常可以运行 32 位和 64 位的应用程序（通过兼容性层）。

### 检查 Linux 系统是 32 位还是 64 位

你可以通过以下命令来检查你的 Linux 系统是 32 位还是 64 位：

1. **检查系统架构**：

   ```bash
   uname -m
   ```

   输出结果：

   - `x86_64`：表示 64 位系统。
   - `i386`、`i686`：表示 32 位系统。

   ![image-20240726181528757](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240726181528757.png)

2. **检查处理器信息**：

   ```bash
   lscpu
   ```

   在输出中查看 `Architecture` 字段：

   - `x86_64`：表示 64 位系统。
   - `i386`、`i686`：表示 32 位系统。

3. **查看系统信息**：

   ```bash
   getconf LONG_BIT
   ```

   输出结果：

   - `64`：表示 64 位系统。
   - `32`：表示 32 位系统。

### 示例

以下是一些示例输出：

```bash
$ uname -m
x86_64

$ lscpu
Architecture:          x86_64
...

$ getconf LONG_BIT
64
```

以上输出结果表明系统是 64 位的。

### 总结

Linux 操作系统有 32 位和 64 位两种版本。可以通过 `uname -m`、`lscpu` 或 `getconf LONG_BIT` 等命令来检查当前系统是 32 位还是 64 位。64 位系统可以处理更大的内存和更高效的数据处理，因此在现代计算环境中更为常见。



# 3 Windows64位32G内存操作系统上,在jdk8默认情况下堆大小为508M



默认情况下jdk8分配的堆空间的大小为:  127 + 21 + 21 + 339 = 508M 【6:1:1】



~~~bash
yangda@F2 MINGW64 /d/Java_developer_tools/mycode/jvm/JVMdachang (main)
$ jmap -heap 8384
Attaching to process ID 8384, please wait...
Debugger attached successfully.
Server compiler detected.
JVM version is 25.201-b09

using thread-local object allocation.
Parallel GC with 8 thread(s)

Heap Configuration:
   MinHeapFreeRatio         = 0
   MaxHeapFreeRatio         = 100
   MaxHeapSize              = 8497659904 (8104.0MB)
   NewSize                  = 177209344 (169.0MB)
   MaxNewSize               = 2832203776 (2701.0MB)
   OldSize                  = 355467264 (339.0MB)
   NewRatio                 = 2
   SurvivorRatio            = 8
   MetaspaceSize            = 21807104 (20.796875MB)
   CompressedClassSpaceSize = 1073741824 (1024.0MB)
   MaxMetaspaceSize         = 17592186044415 MB
   G1HeapRegionSize         = 0 (0.0MB)

Heap Usage:
PS Young Generation
Eden Space:
   capacity = 133169152 (127.0MB)
   used     = 10653592 (10.160057067871094MB)
   free     = 122515560 (116.8399429321289MB)
   8.00004493533157% used
From Space:
   capacity = 22020096 (21.0MB)
   used     = 0 (0.0MB)
   free     = 22020096 (21.0MB)
   0.0% used
To Space:
   capacity = 22020096 (21.0MB)
   used     = 0 (0.0MB)
   free     = 22020096 (21.0MB)
   0.0% used
PS Old Generation
   capacity = 355467264 (339.0MB)
   used     = 0 (0.0MB)
   free     = 355467264 (339.0MB)
   0.0% used

3151 interned Strings occupying 258840 bytes.


~~~



### 查看默认堆空间设置

你可以使用以下命令来查看 JVM 启动时的默认堆空间设置：

```
java -XX:+PrintFlagsFinal -version | grep -i "heapsize"
```

这将列出 JVM 的所有默认堆大小设置，包括初始堆大小（`InitialHeapSize`）和最大堆大小（`MaxHeapSize`）。



~~~bash
/mycode/jvm/JVMdachang (main) $ java -XX:+PrintFlagsFinal -version | grep -i "heapsize"

    uintx ErgoHeapSizeLimit                         = 0                                   {product}
    uintx HeapSizePerGCThread                       = 87241520                            {product}
    uintx InitialHeapSize                          := 532676608                           {product}
    uintx LargePageHeapSizeThreshold                = 134217728                           {product}
    uintx MaxHeapSize                              := 4202692608                          {product}
java version "1.8.0_201"
Java(TM) SE Runtime Environment (build 1.8.0_201-b09)
Java HotSpot(TM) 64-Bit Server VM (build 25.201-b09, mixed mode)
~~~

根据输出结果：

```plaintext
    uintx ErgoHeapSizeLimit                         = 0                                   {product}
    uintx HeapSizePerGCThread                       = 87241520                            {product}
    uintx InitialHeapSize                          := 532676608                           {product}
    uintx LargePageHeapSizeThreshold                = 134217728                           {product}
    uintx MaxHeapSize                              := 4202692608                          {product}
```

这些是 JVM 默认配置的堆大小设置：

- **InitialHeapSize**：`532676608` 字节（约 508 MB）
- **MaxHeapSize**：`4202692608` 字节（约 4 GB）

### 解释

- **InitialHeapSize (初始堆大小)**：启动时分配的堆空间大小，约为 508 MB。
- **MaxHeapSize (最大堆大小)**：JVM 能够使用的最大堆空间大小，约为 4 GB。

### 你的系统信息

- 物理内存：32 GB
- JVM 版本：1.8.0_201

### 默认堆大小的计算依据

JVM 默认堆大小的计算通常基于以下标准：

- 初始堆大小（`InitialHeapSize`）：通常设置为物理内存的 1/64，但不超过一定的上限。
- 最大堆大小（`MaxHeapSize`）：通常设置为物理内存的 1/4，但有一个上限，具体数值视系统和 JVM 版本而定。

在你的系统上，JVM 计算的初始堆大小和最大堆大小如下：

- **初始堆大小**：约 508 MB
- **最大堆大小**：约 4 GB

### 如何调整堆大小

如果需要调整堆大小，可以在启动 Java 应用程序时通过 `-Xms` 和 `-Xmx` 参数来指定。例如：

```bash
java -Xms1g -Xmx8g -jar your-application.jar
```

以上命令将初始堆大小设置为 1 GB，最大堆大小设置为 8 GB。

通过调整这些参数，你可以根据应用程序的需求优化内存使用。







### 确认 JVM 堆空间设置

要确认你的 JVM 堆空间设置，可以运行以下命令并检查输出：

```
java -XX:+PrintFlagsFinal -version | grep -Ei "InitialHeapSize|MaxHeapSize"
```

例如，在我的系统上，输出可能如下所示：

```
uintx InitialHeapSize                          := 268435456       {product}
uintx MaxHeapSize                              := 4294967296      {product}
```

### 如何解释结果

- **InitialHeapSize**：初始堆大小。通常为物理内存的 1/64。
- **MaxHeapSize**：最大堆大小。通常为物理内存的 1/4，但有上限。

根据你的结果，如果默认堆空间大小为 508MB，那么你的 JVM 可能使用了一些自适应的策略来确定合适的堆大小。堆空间大小可以通过 `-Xms` 和 `-Xmx` 参数来调整。例如：

```
java -Xms512m -Xmx4g -jar your-application.jar
```

这样可以设置初始堆空间大小为 512MB，最大堆空间大小为 4GB。

通过这种方式，你可以更好地管理你的 Java 应用程序的内存使用情况。



# 4 为什么我的32 GB内存的计算机上的 JVM 初始堆大小是 508 MB，最大堆大小是 4 GB？而不是 512 MB和8G?

### 注意：默认jdk8 JVM 使用 Parallel垃圾回收器



**默认情况下，JVM 的初始堆大小通常设置为物理内存的 1/64，最大堆大小的默认值通常设置为物理内存的 1/4。**

你的计算机具有 32 GB 物理内存，根据默认的 JVM 内存分配策略，初始堆大小和最大堆大小的具体数值可能受到多个因素的影响，包括操作系统、JVM 实现和版本等。以下是对这些因素的更详细解释：

### 初始堆大小计算

**默认情况下，JVM 的初始堆大小通常设置为物理内存的 1/64。**但具体数值也可能受到 JVM 内部策略和操作系统的限制。即使有一个大致的默认值，实际计算过程中 JVM 可能会根据不同的硬件和软件环境调整这个数值。

对于 32 GB 的物理内存，物理内存的 1/64 应该是：

 512  MB

### 具体值为 508 MB 的原因

你的 JVM 初始堆大小显示为 532676608 字节，即约 508 MB。这一数值略低于理论计算的 512 MB，可能是因为 JVM 内部对内存分配进行了一些调整或优化，以确保在各种环境下的稳定运行。

### 最大堆大小计算

**最大堆大小的默认值通常设置为物理内存的 1/4**，但在某些情况下可能会被操作系统或 JVM 实现的其他限制调整。

对于 32 GB 的物理内存，物理内存的 1/4 应该是：

8GB

但是，实际显示为约 4 GB（4202692608 字节）。这可能是由于以下原因之一：

1. **操作系统限制**：某些操作系统在内存管理上可能对单个进程的内存使用量施加了限制。
2. **JVM 实现策略**：JVM 可能基于其内部策略，设置了一个合理的默认最大堆大小上限，以防止应用程序占用过多的内存资源。
3. **32 位和 64 位 JVM 的差异**：虽然你使用的是 64 位 JVM，但某些情况下，JVM 可能基于兼容性或稳定性考虑，设置了较低的默认最大堆大小。

### 验证和调整堆大小

如果需要验证和调整 JVM 的堆大小，你可以使用 `-Xms` 和 `-Xmx` 参数。例如：

```bash
java -Xms1g -Xmx8g -jar your-application.jar
```

这将显式设置初始堆大小为 1 GB，最大堆大小为 8 GB，避免默认策略的限制。

### 总结

- **初始堆大小**：尽管理论上 32 GB 内存的 1/64 应该是 512 MB，JVM 内部的调整和优化可能导致实际数值为 508 MB。
- **最大堆大小**：默认最大堆大小为 4 GB（而不是理论上的 8 GB），可能是操作系统限制或 JVM 实现策略导致的。

这些默认值旨在提供合理的内存管理策略，以确保 JVM 和应用程序在不同环境下的稳定运行。



# 5 如果使用CMS垃圾回收器则：初始堆大小为 508 MB，最大堆大小为 8 GB。



你的 JVM 正在使用 CMS 垃圾回收器，并且默认禁用了自适应大小调整策略。

初始堆大小为 508 MB，最大堆大小为 8 GB。



# 6 JVM调优案例4，使用`top`命令监视JVM死锁时CPU标高的情况。

#### `top`命令基本语法

- 命令：`top [选项]`

- 案例 4：监视JVM死锁时CPU标高的情况。JVM调优案例4
  - 执行命令 `top -Hp PID`

`-H` 和 `-p` 选项分别用于显示线程信息和指定特定进程的 PID。

结合使用 `-H` 和 `-p` 选项，`top -Hp PID` 命令将**显示指定进程的所有线程**的详细信息。即显示该进程相关联的所有线程的详细信息。

![image-20240728210059937](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240728210059937.png)



## xxx大厂问题排查过程：

...省略;
4、ps aux | grep java  查看到当前java进程使用cpu、内存、磁盘的情况获取使用量异常的进程
5、top -Hp 进程pid  检查当前使用异常线程的pid
6、把线程pid变为16进制如 31695 - 》 7bcf  然后得到0x7bcf
7、jstack 进程的pid | grep -A20  0x7bcf  得到相关进程的代码

说明：`grep -A20 0x7bcf`，这里将管道命令`|`前面的输出结果，从前面指令得到的结果中过滤得到的含有十六进制的PID的字符串"0x7bcf"的那一行，同时往后打印20行(-A30就是往后打印30行)，并直接输出在控制台。



# 7 tomcat启动后在Linux下对应的进程



![image-20240728214125139](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240728214125139.png)



# 8 jmeter压测工具聚合报告百分比的含义



![image-20240728225002620](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240728225002620.png)



# 9 吞吐量和暂停时间(延迟时间)



![image-20240728224727082](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240728224727082.png)



![image-20240728224732737](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240728224732737.png)



GC垃圾回收器的性能指标中的吞吐量和暂停时间/延迟时间，与JMeter中显示的吞吐量确实是不同的概念。我们可以分别解释这两个概念。

### GC垃圾回收器的性能指标

#### 吞吐量
在垃圾回收（GC）上下文中，**吞吐量**是指运行用户代码的时间与总运行时间（用户代码时间 + GC时间）之比。例如，如果你的应用程序在10秒内运行，其中2秒用于GC，那么吞吐量就是80%（8/10）。GC吞吐量的目的是最小化GC对应用程序性能的影响，使应用程序能够尽可能多地运行用户代码。

#### 暂停时间（延迟时间）
**暂停时间**是指执行垃圾收集时，应用程序的工作线程被暂停的时间。这通常是影响应用程序响应时间的关键因素，特别是在低延迟应用中。减少GC的暂停时间可以提高应用程序的响应速度，使其更具实时性。

#### 其他指标
- **收集频率**：GC操作发生的频率。
- **内存占用**：Java堆区所占的内存大小。
- **快速**：一个对象从诞生到被回收经历的时间。

### JMeter中的性能指标

#### 吞吐量
在JMeter中，**吞吐量**是指服务器每秒处理的请求数量。它表示的是应用程序在特定负载下的性能。例如，吞吐量是1000请求/秒，表示服务器每秒能够处理1000个请求。这与GC的吞吐量概念不同，JMeter关注的是整个系统的处理能力，而GC吞吐量关注的是在垃圾收集过程中运行用户代码的效率。

#### 响应时间
JMeter中的**响应时间**是指从请求发出到接收到响应所花费的时间。这包括网络延迟、服务器处理时间等。与GC的暂停时间不同，JMeter的响应时间是面向用户体验的关键指标。

### 结论

- **GC吞吐量**和**JMeter吞吐量**是不同的概念：前者关注的是垃圾回收期间运行用户代码的时间比例，而后者关注的是服务器处理请求的能力。
- **GC暂停时间**和**JMeter响应时间**也不同：前者关注的是垃圾回收对应用程序的影响，后者关注的是用户请求的整体响应时间。

这两个工具和指标分别用于不同的上下文，但它们的最终目标都是优化应用程序性能，提供更好的用户体验。



# 10 日均百万订单中："每11分钟发生一次MinorGC" 说的是收集频率。



![image-20240728225705157](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240728225705157.png)



"每11分钟发生一次MinorGC" 这个说法是针对 **收集频率** 这个指标来说的。每11分钟一次MinorGC是可以接收的。

### 收集频率

**收集频率** 指的是垃圾收集（GC）操作发生的频率。在这个上下文中，每11分钟发生一次MinorGC描述的是垃圾收集的频率。收集频率是一个重要的性能指标，因为频繁的GC操作可能会导致更多的暂停时间，从而影响应用程序的性能。

### 相关性能指标

- **吞吐量**：虽然每11分钟发生一次MinorGC直接描述的是收集频率，但GC频率也间接影响吞吐量。较高的GC频率可能会降低运行用户代码的时间，从而影响吞吐量。
- **暂停时间**：频繁的GC操作会导致更多的暂停时间，因此GC频率也会影响暂停时间。每11分钟发生一次MinorGC意味着在GC发生时，应用程序的工作线程会被暂停，尽管MinorGC的暂停时间通常较短。

### 总结

每11分钟发生一次MinorGC主要描述的是 **收集频率** 这个指标，但它也会对吞吐量和暂停时间产生影响。频繁的GC操作可能会影响应用程序的整体性能，因此了解和优化GC频率是性能调优的重要部分。



![image-20240728225822263](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240728225822263.png)



---



# 00

# 00

# 00

# 00

# 00 黑马程序员JVM笔记如下：

# 1 `jar -xvf xx.jar` 解压jar包的指令



![image-20240729185811986](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240729185811986.png)



![image-20240729190007298](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240729190007298.png)



![image-20240729190349759](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240729190349759.png)





# 2 arthas 命令

## 2.1 `dump` 已加载类的 bytecode 到特定目录



将运行中的程序的.class字节码文件保存到指定目录



### 参数说明

|              参数名称 | 参数说明                                   |
| --------------------: | :----------------------------------------- |
|       *class-pattern* | 类名表达式匹配                             |
|                `[c:]` | 类所属 ClassLoader 的 hashcode             |
| `[classLoaderClass:]` | 指定执行表达式的 ClassLoader 的 class name |
|                `[d:]` | 设置类文件的目标目录                       |
|                   [E] | 开启正则表达式匹配，默认为通配符匹配       |

### 使用参考



```bash
$ dump java.lang.String
 HASHCODE  CLASSLOADER  LOCATION
 null                   /Users/admin/logs/arthas/classdump/java/lang/String.class
Affect(row-cnt:1) cost in 119 ms.
```



```bash
$ dump demo.*
 HASHCODE  CLASSLOADER                                    LOCATION
 3d4eac69  +-sun.misc.Launcher$AppClassLoader@3d4eac69    /Users/admin/logs/arthas/classdump/sun.misc.Launcher$AppClassLoader-3d4eac69/demo/MathGame.class
             +-sun.misc.Launcher$ExtClassLoader@66350f69
Affect(row-cnt:1) cost in 39 ms.
```



指定要保存的目录 `-d /tmp/output`

```bash
$ dump -d /tmp/output java.lang.String
 HASHCODE  CLASSLOADER  LOCATION
 null                   /tmp/output/java/lang/String.class
Affect(row-cnt:1) cost in 138 ms.
```









## 2.2 `jad`反编译指定已加载类的源码

`jad` 命令将 JVM 中实际运行的 class 的 byte code 反编译成 java 代码，便于你理解业务逻辑；如需批量下载指定包的目录的 class 字节码可以参考 [dump](https://arthas.aliyun.com/doc/dump.html)。



`jad` 命令将 JVM 中实际运行的 class 的 byte code 反编译成 java 代码，便于你理解业务逻辑；如需批量下载指定包的目录的 class 字节码可以参考 [dump](https://arthas.aliyun.com/doc/dump.html)。

- 在 Arthas Console 上，反编译出来的源码是带语法高亮的，阅读更方便
- 当然，反编译出来的 java 代码可能会存在语法错误，但不影响你进行阅读理解

### [#](https://arthas.aliyun.com/doc/jad.html#参数说明)参数说明

|              参数名称 | 参数说明                                   |
| --------------------: | :----------------------------------------- |
|       *class-pattern* | 类名表达式匹配                             |
|                `[c:]` | 类所属 ClassLoader 的 hashcode             |
| `[classLoaderClass:]` | 指定执行表达式的 ClassLoader 的 class name |
|                   [E] | 开启正则表达式匹配，默认为通配符匹配       |

### [#](https://arthas.aliyun.com/doc/jad.html#使用参考)使用参考

### [#](https://arthas.aliyun.com/doc/jad.html#反编译java-lang-string)反编译`java.lang.String`



```java
$ jad java.lang.String

ClassLoader:

Location:


        /*
         * Decompiled with CFR.
         */
        package java.lang;

        import java.io.ObjectStreamField;
        import java.io.Serializable;
...
        public final class String
        implements Serializable,
        Comparable<String>,
        CharSequence {
            private final char[] value;
            private int hash;
            private static final long serialVersionUID = -6849794470754667710L;
            private static final ObjectStreamField[] serialPersistentFields = new ObjectStreamField[0];
            public static final Comparator<String> CASE_INSENSITIVE_ORDER = new CaseInsensitiveComparator();
...
            public String(byte[] byArray, int n, int n2, Charset charset) {
/*460*/         if (charset == null) {
                    throw new NullPointerException("charset");
                }
/*462*/         String.checkBounds(byArray, n, n2);
/*463*/         this.value = StringCoding.decode(charset, byArray, n, n2);
            }
...
```

### [#](https://arthas.aliyun.com/doc/jad.html#反编译时只显示源代码)反编译时只显示源代码

默认情况下，反编译结果里会带有`ClassLoader`信息，通过`--source-only`选项，可以只打印源代码。方便和[mc](https://arthas.aliyun.com/doc/mc.html)/[retransform](https://arthas.aliyun.com/doc/retransform.html)命令结合使用。



```java
$ jad --source-only demo.MathGame
/*
 * Decompiled with CFR 0_132.
 */
package demo;

import java.io.PrintStream;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import java.util.concurrent.TimeUnit;

public class MathGame {
    private static Random random = new Random();
    public int illegalArgumentCount = 0;
...
```



## 2.3 `classloader`指令



> 提示
>
> 查看 classloader 的继承树，urls，类加载信息



`classloader` 命令将 JVM 中所有的 classloader 的信息统计出来，并可以展示继承树，urls 等。

可以让指定的 classloader 去 getResources，打印出所有查找到的 resources 的 url。对于`ResourceNotFoundException`比较有用。

### [#](https://arthas.aliyun.com/doc/classloader.html#参数说明)参数说明

|              参数名称 | 参数说明                                   |
| --------------------: | :----------------------------------------- |
|                   [l] | 按类加载实例进行统计                       |
|                   [t] | 打印所有 ClassLoader 的继承树              |
|                   [a] | 列出所有 ClassLoader 加载的类，请谨慎使用  |
|                `[c:]` | ClassLoader 的 hashcode                    |
| `[classLoaderClass:]` | 指定执行表达式的 ClassLoader 的 class name |
|             `[c: r:]` | 用 ClassLoader 去查找 resource             |
|          `[c: load:]` | 用 ClassLoader 去加载指定的类              |

### [#](https://arthas.aliyun.com/doc/classloader.html#使用参考)使用参考

![image-20240731091612362](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240731091612362.png)

常用指令：

`classloader -l` **按类加载实例进行统计。**该指令也可以查看类加载器的hash码

`classloader -c hashcode`可以**查看 URLClassLoader 实际的 urls**(即加载的路径，即加载了哪些jar包)。

在Windows下推荐使用`Windows PowerShell`操作Arthas

![image-20240731112437278](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240731112437278.png)

![image-20240731111005249](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240731111005249.png)





### 按类加载实例查看统计信息



```bash
$ classloader -l
 name                                                loadedCount  hash      parent
 BootstrapClassLoader                                1861         null      null
 com.taobao.arthas.agent.ArthasClassloader@68b31f0a  2115         68b31f0a  sun.misc.Launcher$ExtClassLoader@66350f69
 sun.misc.Launcher$AppClassLoader@3d4eac69           4            3d4eac69  sun.misc.Launcher$ExtClassLoader@66350f69
 sun.misc.Launcher$ExtClassLoader@66350f69           1            66350f69  null
Affect(row-cnt:4) cost in 2 ms.
```

### [#](https://arthas.aliyun.com/doc/classloader.html#查看-classloader-的继承树)查看 ClassLoader 的继承树



```bash
$ classloader -t
+-BootstrapClassLoader
+-sun.misc.Launcher$ExtClassLoader@66350f69
  +-com.taobao.arthas.agent.ArthasClassloader@68b31f0a
  +-sun.misc.Launcher$AppClassLoader@3d4eac69
Affect(row-cnt:4) cost in 3 ms.
```

### [#](https://arthas.aliyun.com/doc/classloader.html#查看-urlclassloader-实际的-urls)查看 URLClassLoader 实际的 urls

```bash
$ classloader -c 3d4eac69
file:/private/tmp/math-game.jar
file:/Users/hengyunabc/.arthas/lib/3.0.5/arthas/arthas-agent.jar

Affect(row-cnt:9) cost in 3 ms.
```

*注意* hashcode 是变化的，需要先查看当前的 ClassLoader 信息，提取对应 ClassLoader 的 hashcode。

对于只有唯一实例的 ClassLoader 可以通过 class name 指定，使用起来更加方便：



```bash
$ classloader --classLoaderClass sun.misc.Launcher$AppClassLoader
file:/private/tmp/math-game.jar
file:/Users/hengyunabc/.arthas/lib/3.0.5/arthas/arthas-agent.jar

Affect(row-cnt:9) cost in 3 ms.
```













## 2.4 `dashboard`指令

> 提示
>
> 当前系统的实时数据面板，按 ctrl+c 退出。



当运行在 Ali-tomcat 时，会显示当前 tomcat 的实时信息，如 HTTP 请求的 qps, rt, 错误数, 线程池信息等等。

### [#](https://arthas.aliyun.com/doc/dashboard.html#参数说明)参数说明

| 参数名称 | 参数说明                                 |
| -------: | :--------------------------------------- |
|     [i:] | 刷新实时数据的时间间隔 (ms)，默认 5000ms |
|     [n:] | 刷新实时数据的次数                       |

### [#](https://arthas.aliyun.com/doc/dashboard.html#使用参考)使用参考



```text
$ dashboard
ID   NAME                           GROUP           PRIORITY   STATE     %CPU      DELTA_TIME TIME      INTERRUPTE DAEMON
-1   C2 CompilerThread0             -               -1         -         1.55      0.077      0:8.684   false      true
53   Timer-for-arthas-dashboard-07b system          5          RUNNABLE  0.08      0.004      0:0.004   false      true
22   scheduling-1                   main            5          TIMED_WAI 0.06      0.003      0:0.287   false      false
-1   C1 CompilerThread0             -               -1         -         0.06      0.003      0:2.171   false      true
-1   VM Periodic Task Thread        -               -1         -         0.03      0.001      0:0.092   false      true
49   arthas-NettyHttpTelnetBootstra system          5          RUNNABLE  0.02      0.001      0:0.156   false      true
16   Catalina-utility-1             main            1          TIMED_WAI 0.0       0.000      0:0.029   false      false
-1   G1 Young RemSet Sampling       -               -1         -         0.0       0.000      0:0.019   false      true
17   Catalina-utility-2             main            1          WAITING   0.0       0.000      0:0.025   false      false
34   http-nio-8080-ClientPoller     main            5          RUNNABLE  0.0       0.000      0:0.016   false      true
23   http-nio-8080-BlockPoller      main            5          RUNNABLE  0.0       0.000      0:0.011   false      true
-1   VM Thread                      -               -1         -         0.0       0.000      0:0.032   false      true
-1   Service Thread                 -               -1         -         0.0       0.000      0:0.006   false      true
-1   GC Thread#5                    -               -1         -         0.0       0.000      0:0.043   false      true
Memory                     used     total    max      usage    GC
heap                       36M      70M      4096M    0.90%    gc.g1_young_generation.count   12
g1_eden_space              6M       18M      -1       33.33%                                  86
g1_old_gen                 30M      50M      4096M    0.74%    gc.g1_old_generation.count     0
g1_survivor_space          491K     2048K    -1       24.01%   gc.g1_old_generation.time(ms)  0
nonheap                    66M      69M      -1       96.56%
codeheap_'non-nmethods'    1M       2M       5M       22.39%
metaspace                  46M      47M      -1       98.01%
Runtime
os.name                                                        Mac OS X
os.version                                                     10.15.4
java.version                                                   15
java.home                                                      /Library/Java/JavaVirtualMachines/jdk-15.jdk/Contents/Home
systemload.average                                             10.68
processors                                                     8
uptime                                                         272s
```

### [#](https://arthas.aliyun.com/doc/dashboard.html#数据说明)数据说明

- ID: Java 级别的线程 ID，注意这个 ID 不能跟 jstack 中的 nativeID 一一对应。
- NAME: 线程名
- GROUP: 线程组名
- PRIORITY: 线程优先级, 1~10 之间的数字，越大表示优先级越高
- STATE: 线程的状态
- CPU%: 线程的 cpu 使用率。比如采样间隔 1000ms，某个线程的增量 cpu 时间为 100ms，则 cpu 使用率=100/1000=10%
- DELTA_TIME: 上次采样之后线程运行增量 CPU 时间，数据格式为`秒`
- TIME: 线程运行总 CPU 时间，数据格式为`分:秒`
- INTERRUPTED: 线程当前的中断位状态
- DAEMON: 是否是 daemon 线程

### [#](https://arthas.aliyun.com/doc/dashboard.html#jvm-内部线程)JVM 内部线程

Java 8 之后支持获取 JVM 内部线程 CPU 时间，这些线程只有名称和 CPU 时间，没有 ID 及状态等信息（显示 ID 为-1）。 通过内部线程可以观测到 JVM 活动，如 GC、JIT 编译等占用 CPU 情况，方便了解 JVM 整体运行状况。

- 当 JVM 堆(heap)/元数据(metaspace)空间不足或 OOM 时，可以看到 GC 线程的 CPU 占用率明显高于其他的线程。
- 当执行`trace/watch/tt/redefine`等命令后，可以看到 JIT 线程活动变得更频繁。因为 JVM 热更新 class 字节码时清除了此 class 相关的 JIT 编译结果，需要重新编译。

JVM 内部线程包括下面几种：

- JIT 编译线程: 如 `C1 CompilerThread0`, `C2 CompilerThread0`
- GC 线程: 如`GC Thread0`, `G1 Young RemSet Sampling`
- 其它内部线程: 如`VM Periodic Task Thread`, `VM Thread`, `Service Thread`

### [#](https://arthas.aliyun.com/doc/dashboard.html#截图展示)截图展示

![dashboard](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/dashboard.png)

processors在arthas里指的是 CPU 的核心数。这些核心可以是物理核心，也可以是通过超线程技术提供的逻辑核心。

```text
processors                                                     8
```



## 2.5 `sc`指令

> 提示
>
> 查看 JVM 已加载的类信息

“Search-Class” 的简写，这个命令能搜索出所有已经加载到 JVM 中的 Class 信息，这个命令支持的参数有 `[d]`、`[E]`、`[f]` 和 `[x:]`。

```
* 在arthas中使用`sc -d java.lang.String`指令查看，
* 会发现class-loader那一行什么也不显示，即为启动类加载器加载的
*
* `sc`指令的[d]选项，输出当前类的详细信息，
* 包括这个类所加载的原始文件来源、类的声明、加载的 ClassLoader 等详细信息。
* 如果一个类被多个 ClassLoader 所加载，则会出现多次
```



![image-20240731095019470](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240731095019470.png)



在 Arthas 的 `sc` 指令中，通配符匹配指的是使用通配符（例如 `*` 和 `?`）来匹配类名或类名的一部分。以下是一些常用的通配符及其含义：

1. `*`（星号）：匹配零个或多个字符。例如：
   - `com.example.*` 匹配 `com.example` 包下的所有类。
   - `com.*.MyClass` 匹配 `com` 包下的所有子包中的 `MyClass` 类。

2. `?`（问号）：匹配单个字符。例如：
   - `com.example.MyCl?ss` 匹配 `com.example` 包下的 `MyClass` 和 `MyClxss` 等类。

### 示例

1. 匹配 `com.example` 包下的所有类：
   ```shell
   sc -d com.example.*
   ```

2. 匹配 `com.example` 包下名称为 `MyClass` 的类：
   ```shell
   sc -d com.example.MyClass
   ```

3. 匹配 `com.example` 包下所有名称以 `Service` 结尾的类：
   ```shell
   sc -d com.example.*Service
   ```

### 使用正则表达式

如果你使用 `-e` 参数，则可以启用正则表达式匹配。这时你可以使用更强大的正则表达式语法来匹配类名。例如：

1. 匹配 `com.example` 包下所有以 `Service` 结尾的类：
   ```shell
   sc -d -e com\.example\..*Service
   ```

2. 匹配 `com.example` 包下所有类：
   ```shell
   sc -d -e com\.example\..*
   ```

通过理解和使用这些通配符和正则表达式，你可以更精确地定位和操作目标类。

## 2.6 `mc`指令

> 提示
>
> Memory Compiler/内存编译器，编译`.java`文件生成`.class`。



```bash
mc /tmp/Test.java
```

可以通过`-c`参数指定 classloader：



```bash
mc -c 327a647b /tmp/Test.java
```

也可以通过`--classLoaderClass`参数指定 ClassLoader：



```bash
$ mc --classLoaderClass org.springframework.boot.loader.LaunchedURLClassLoader /tmp/UserController.java -d /tmp
Memory compiler output:
/tmp/com/example/demo/arthas/user/UserController.class
Affect(row-cnt:1) cost in 346 ms
```

可以通过`-d`命令指定输出目录：



```bash
mc -d /tmp/output /tmp/ClassA.java /tmp/ClassB.java
```

编译生成`.class`文件之后，可以结合[retransform](https://arthas.aliyun.com/doc/retransform.html)命令实现热更新代码。

注意

注意，mc 命令有可能失败。如果编译失败可以在本地编译好`.class`文件，再上传到服务器。具体参考[retransform](https://arthas.aliyun.com/doc/retransform.html)命令说明。



### 例子

假设 `Test` 类由类加载器 `327a647b` 加载：

```bash
mc -c 327a647b /tmp/Test.java
```

在这个命令中，`-c 327a647b` 参数指定了类加载器的标识符，确保 `mc` 指令使用正确的类加载器来加载重新编译的类。

### 类加载器的获取

在实际操作中，你可以通过以下方式获取类加载器的标识符：

1. **通过 Arthas 的 `sc` 命令**：

   - **使用 `sc` 命令查看类的详细信息，包括类加载器信息。**例如：

     ```bash
     sc -d com.example.Test
     ```

     这条命令会显示 `Test` 类的详细信息，包括加载它的类加载器的标识符。

2. **通过日志或调试信息**：

   - 在某些情况下，类加载器的信息可能会在应用的日志或调试信息中出现，可以通过这些途径获取类加载器标识符。

### 总结

在使用 Arthas 的 `mc` 指令进行类热替换时，指定类加载器是为了确保重新编译的类被正确加载。由于 Java 中类加载器的唯一性和复杂性，不同的类加载器加载的类是不同的，如果不指定类加载器，可能会导致找不到指定类的错误。因此，通过 `-c` 参数指定正确的类加载器，可以确保 `mc` 指令成功加载重新编译的类。











# 3  Arthas遇到的问题

## 3.1 Arthas使用`quit`退出，再次连接其他进程会出现问题。建议使用stop退出！



使用 quit退出arthas再次连接会报以下错误信息。

~~~shell
yangda@F2 MINGW64 /d/Java_developer_tools/mycode/jvm/heimaJVM (main)
$ java -jar arthas-boot.jar
[INFO] JAVA_HOME: C:\jdk\jdk1.8\jre
[INFO] arthas-boot version: 3.6.7
[INFO] Found existing java process, please choose one and input the serial number of the process, eg : 1. Then hit ENTER.
* [1]: 7796 hsdb.HsdbDemo
  [2]: 17724 org.jetbrains.jps.cmdline.Launcher
  [3]: 3788
1
[INFO] arthas home: C:\Users\yangd\.arthas\lib\3.7.2\arthas
[INFO] Try to attach process 7796
[INFO] Attach process 7796 success.
[INFO] arthas-client connect 127.0.0.1 3658
  ,---.  ,------. ,--------.,--.  ,--.  ,---.   ,---.
 /  O  \ |  .--. ''--.  .--'|  '--'  | /  O  \ '   .-'
|  .-.  ||  '--'.'   |  |   |  .--.  ||  .-.  |`.  `-.
|  | |  ||  |\  \    |  |   |  |  |  ||  | |  |.-'    |
`--' `--'`--' '--'   `--'   `--'  `--'`--' `--'`-----'

wiki       https://arthas.aliyun.com/doc
tutorials  https://arthas.aliyun.com/doc/arthas-tutorials.html
version    3.7.2
main_class
pid        7796
time       2024-07-31 10:32:22

[arthas@7796]$ quit
quit

yangda@F2 MINGW64 /d/Java_developer_tools/mycode/jvm/heimaJVM (main)
$ java -jar arthas-boot.jar
[INFO] JAVA_HOME: C:\jdk\jdk1.8\jre
[INFO] arthas-boot version: 3.6.7
[INFO] Process 7796 already using port 3658
[INFO] Process 7796 already using port 8563
[INFO] Found existing java process, please choose one and input the serial number of the process, eg : 1. Then hit ENTER.
* [1]: 7796 hsdb.HsdbDemo
  [2]: 17724 org.jetbrains.jps.cmdline.Launcher
  [3]: 3788
1
[INFO] arthas home: C:\Users\yangd\.arthas\lib\3.7.2\arthas
[INFO] The target process already listen port 3658, skip attach.
[INFO] arthas-client connect 127.0.0.1 3658
  ,---.  ,------. ,--------.,--.  ,--.  ,---.   ,---.
 /  O  \ |  .--. ''--.  .--'|  '--'  | /  O  \ '   .-'
|  .-.  ||  '--'.'   |  |   |  .--.  ||  .-.  |`.  `-.
|  | |  ||  |\  \    |  |   |  |  |  ||  | |  |.-'    |
`--' `--'`--' '--'   `--'   `--'  `--'`--' `--'`-----'

wiki       https://arthas.aliyun.com/doc
tutorials  https://arthas.aliyun.com/doc/arthas-tutorials.html
version    3.7.2
main_class
pid        7796
time       2024-07-31 10:32:22

[arthas@7796]$ quit
quit

yangda@F2 MINGW64 /d/Java_developer_tools/mycode/jvm/heimaJVM (main)
$ java -jar arthas-boot.jar
[INFO] JAVA_HOME: C:\jdk\jdk1.8\jre
[INFO] arthas-boot version: 3.6.7
[INFO] Process 7796 already using port 3658
[INFO] Process 7796 already using port 8563
[INFO] Found existing java process, please choose one and input the serial number of the process, eg : 1. Then hit ENTER.
* [1]: 7796 hsdb.HsdbDemo
  [2]: 4260 arthas.BootstrapClassLoaderDemo
  [3]: 8932 org.jetbrains.jps.cmdline.Launcher
  [4]: 3788
2
[ERROR] The telnet port 3658 is used by process 7796 instead of target process 4260, you will connect to an unexpected process.
[ERROR] 1. Try to restart arthas-boot, select process 7796, shutdown it first with running the 'stop' command.
[ERROR] 2. Or try to stop the existing arthas instance: java -jar arthas-client.jar 127.0.0.1 3658 -c "stop"
[ERROR] 3. Or try to use different telnet port, for example: java -jar arthas-boot.jar --telnet-port 9998 --http-port -1

yangda@F2 MINGW64 /d/Java_developer_tools/mycode/jvm/heimaJVM (main)

~~~

这个报错信息是因为Arthas已经在端口3658上运行了一个进程，并且你试图连接到另一个进程时，该端口仍然被占用。具体的错误信息说明了原因：你试图连接的目标进程（7796）不能使用端口3658，因为它已经被另一个进程（7952）占用。



**验证端口是否释放**：

- 在Git Bash或Windows命令行中运行：

  ```
  netstat -ano | grep :3658
  ```

  或

  ```
  netstat -ano | findstr :3658
  ```

  确认端口3658未被占用。





### 3658端口被占用的原因

端口3658通常被Arthas用于Telnet连接，这是Arthas用于与客户端通信的默认端口。当你启动Arthas时，它会在该端口上启动一个Telnet服务器，以便你可以通过命令行与Arthas进行交互。如果你在没有正确停止Arthas的情况下退出，它会继续在该端口上运行，这就是为什么你看到端口3658被占用。

### 3658端口的作用

- **Telnet连接**：Arthas使用3658端口作为Telnet服务器端口，允许你通过命令行与Arthas进行交互。你可以发送命令并接收Arthas的输出。
- **管理进程**：通过Telnet连接，你可以管理Java进程，执行各种诊断和调试任务。

### 解决端口被占用的方法

如果端口3658被占用，你可以选择以下几种方法解决：

1. **正确停止Arthas**：

   - 使用`stop`命令停止Arthas，这样会释放端口3658。

2. **使用不同的端口**：

   - 启动Arthas时指定不同的Telnet端口，例如9998。

   ```shell
   java -jar arthas-boot.jar --telnet-port 9998 --http-port -1
   ```

3. **手动杀死占用端口的进程**：

   - 使用`netstat`查找占用端口的进程ID，然后使用`taskkill`命令终止该进程。

### 操作步骤

#### 1. 正确停止Arthas

1. 启动Arthas并选择进程：

   ```shell
   java -jar arthas-boot.jar
   ```

   选择正在运行的进程，例如：

   ```shell
   * [1]: 7952 arthas.BootstrapClassLoaderDemo
   1
   ```

2. 使用`stop`命令停止Arthas：

   ```shell
   stop
   ```

#### 2. 使用不同的端口

1. 启动Arthas时指定不同的Telnet端口：

   ```shell
   java -jar arthas-boot.jar --telnet-port 9998 --http-port -1
   ```

#### 3. 手动杀死占用端口的进程

1. 使用`netstat`查找占用端口的进程ID：

   ```shell
   netstat -ano | findstr :3658
   ```

2. 使用`taskkill`命令终止该进程：

   ```shell
   taskkill /PID <PID> /F
   ```

### 详细操作步骤

1. **停止已有的Arthas实例**

   运行`arthas-boot`并选择进程7952：

   ```shell
   java -jar arthas-boot.jar
   ```

   在提示符下输入`1`，选择进程7952：

   ```shell
   * [1]: 7952 arthas.BootstrapClassLoaderDemo
     [2]: 7796 hsdb.HsdbDemo
     [3]: 17724 org.jetbrains.jps.cmdline.Launcher
     [4]: 3788
   1
   ```

   使用`stop`命令停止Arthas服务器：

   ```shell
   stop
   ```

2. **验证端口是否释放**

   在Git Bash或Windows命令行中运行：

   ```shell
   netstat -ano | findstr :3658
   ```

   确认端口3658未被占用。

3. **重新启动Arthas并选择目标进程**

   运行`arthas-boot`并选择新的目标进程：

   ```shell
   java -jar arthas-boot.jar
   ```

4. **使用不同的端口（如果需要）**

   如果端口仍然被占用，可以使用不同的Telnet端口启动Arthas：

   ```shell
   java -jar arthas-boot.jar --telnet-port 9998 --http-port -1
   ```

通过这些步骤，你可以确保Arthas服务器正确停止，并避免端口冲突。如果再次连接时，选择正确的进程以启动新的Arthas会话。

## 3.2 通过正确使用`stop`命令，你可以避免端口冲突，确保Arthas正常工作，并能够连接到新的目标进程。

通过你的描述和提供的日志信息，可以看出以下现象和规律：

1. **成功连接到HsdbDemo进程**：
   - 当你第一次运行`arthas-boot`并选择连接到进程`HsdbDemo`时，连接成功，Arthas在端口3658上监听。
   - 使用`quit`命令退出会话，但Arthas实例仍然运行，并继续监听端口3658。

2. **尝试连接到其他进程失败**：
   - 再次运行`arthas-boot`并尝试连接到其他进程（如`BootstrapClassLoaderDemo`），系统提示端口3658已被进程`HsdbDemo`占用，导致连接失败。

3. **再次连接到HsdbDemo成功**：
   - 再次运行`arthas-boot`并选择连接到进程`HsdbDemo`时，连接成功，Arthas继续使用端口3658。

### 现象总结

- **规律1**：当你使用`quit`命令退出Arthas会话后，Arthas实例仍然在后台运行，并继续占用端口3658。
- **规律2**：只要端口3658被占用，尝试连接到其他进程（非`HsdbDemo`）都会失败，因为Arthas实例仍然监听在该端口。
- **规律3**：再次连接到`HsdbDemo`时，由于Arthas实例已经在监听，因此可以成功连接。

### 原因分析

- **Arthas实例未完全停止**：`quit`命令只是退出当前的Arthas会话，但并没有完全停止Arthas实例。这导致端口3658继续被占用。
- **端口冲突**：由于端口3658已经被占用，当你尝试连接到其他进程时，无法重新使用该端口，导致连接失败。

### 解决方案

要解决这个问题，你需要确保在退出Arthas时完全停止Arthas实例。以下是详细步骤：

1. **使用`stop`命令完全停止Arthas实例**：

   - 启动Arthas并选择当前使用端口的进程（如`HsdbDemo`）。

   - 在Arthas会话中使用`stop`命令，而不是`quit`命令：

     ```shell
     stop
     ```

   - 这将完全停止Arthas实例，并释放端口3658。

2. **验证端口是否被释放**：

   - 使用`netstat`命令检查端口3658是否被释放：

     ```shell
     netstat -ano | findstr :3658
     ```

   - 如果没有输出，说明端口已经被释放。

3. **重新启动Arthas并选择目标进程**：

   - 运行`arthas-boot`并选择新的目标进程（如`BootstrapClassLoaderDemo`）：

     ```shell
     java -jar arthas-boot.jar
     ```

     选择新的目标进程，例如4260：

     ```shell
     * [1]: 7796 hsdb.HsdbDemo
       [2]: 4260 arthas.BootstrapClassLoaderDemo
       [3]: 8932 org.jetbrains.jps.cmdline.Launcher
       [4]: 3788
     2
     ```

### 总结

- **问题根本原因**：`quit`命令没有完全停止Arthas实例，导致端口3658继续被占用。
- **解决方法**：使用`stop`命令完全停止Arthas实例，确保端口被释放，然后重新启动Arthas并连接到新的目标进程。
- **验证步骤**：通过`netstat`命令确认端口是否被释放，确保Arthas实例正确停止。

通过正确使用`stop`命令，你可以避免端口冲突，确保Arthas正常工作，并能够连接到新的目标进程。

### 3.2.1 测试quit指令导致的报错问题的核心log记录

以下是你提供的log记录的核心部分，这些记录展示了Arthas实例在使用`quit`命令退出后仍然占用端口3658的情况，以及尝试连接到新进程时的错误信息。

#### 成功连接到HsdbDemo进程

```shell
$ java -jar arthas-boot.jar
[INFO] JAVA_HOME: C:\jdk\jdk1.8\jre
[INFO] arthas-boot version: 3.6.7
[INFO] Found existing java process, please choose one and input the serial number of the process, eg : 1. Then hit ENTER.
* [1]: 7796 hsdb.HsdbDemo
  [2]: 17724 org.jetbrains.jps.cmdline.Launcher
  [3]: 3788
1
[INFO] arthas home: C:\Users\yangd\.arthas\lib\3.7.2\arthas
[INFO] Try to attach process 7796
[INFO] Attach process 7796 success.
[INFO] arthas-client connect 127.0.0.1 3658
  ,---.  ,------. ,--------.,--.  ,--.  ,---.   ,---.
 /  O  \ |  .--. ''--.  .--'|  '--'  | /  O  \ '   .-'
|  .-.  ||  '--'.'   |  |   |  .--.  ||  .-.  |`.  `-.
|  | |  ||  |\  \    |  |   |  |  |  ||  | |  |.-'    |
`--' `--'`--' '--'   `--'   `--'  `--'`--' `--'`-----'
wiki       https://arthas.aliyun.com/doc
tutorials  https://arthas.aliyun.com/doc/arthas-tutorials.html
version    3.7.2
main_class
pid        7796
time       2024-07-31 10:32:22
```

#### 使用`quit`命令退出会话

```shell
[arthas@7796]$ quit
quit
```

#### 尝试连接到新进程失败

```shell
$ java -jar arthas-boot.jar
[INFO] JAVA_HOME: C:\jdk\jdk1.8\jre
[INFO] arthas-boot version: 3.6.7
[INFO] Process 7796 already using port 3658
[INFO] Process 7796 already using port 8563
[INFO] Found existing java process, please choose one and input the serial number of the process, eg : 1. Then hit ENTER.
* [1]: 7796 hsdb.HsdbDemo
  [2]: 4260 arthas.BootstrapClassLoaderDemo
  [3]: 8932 org.jetbrains.jps.cmdline.Launcher
  [4]: 3788
2
[ERROR] The telnet port 3658 is used by process 7796 instead of target process 4260, you will connect to an unexpected process.
[ERROR] 1. Try to restart arthas-boot, select process 7796, shutdown it first with running the 'stop' command.
[ERROR] 2. Or try to stop the existing arthas instance: java -jar arthas-client.jar 127.0.0.1 3658 -c "stop"
[ERROR] 3. Or try to use different telnet port, for example: java -jar arthas-boot.jar --telnet-port 9998 --http-port -1
```

#### 再次连接到HsdbDemo成功

```shell
$ java -jar arthas-boot.jar
[INFO] JAVA_HOME: C:\jdk\jdk1.8\jre
[INFO] arthas-boot version: 3.6.7
[INFO] Process 7796 already using port 3658
[INFO] Process 7796 already using port 8563
[INFO] Found existing java process, please choose one and input the serial number of the process, eg : 1. Then hit ENTER.
* [1]: 7796 hsdb.HsdbDemo
  [2]: 17724 org.jetbrains.jps.cmdline.Launcher
  [3]: 3788
1
[INFO] arthas home: C:\Users\yangd\.arthas\lib\3.7.2\arthas
[INFO] The target process already listen port 3658, skip attach.
[INFO] arthas-client connect 127.0.0.1 3658
  ,---.  ,------. ,--------.,--.  ,--.  ,---.   ,---.
 /  O  \ |  .--. ''--.  .--'|  '--'  | /  O  \ '   .-'
|  .-.  ||  '--'.'   |  |   |  .--.  ||  .-.  |`.  `-.
|  | |  ||  |\  \    |  |   |  |  |  ||  | |  |.-'    |
`--' `--'`--' '--'   `--'   `--'  `--'`--' `--'`-----'
wiki       https://arthas.aliyun.com/doc
tutorials  https://arthas.aliyun.com/doc/arthas-tutorials.html
version    3.7.2
main_class
pid        7796
time       2024-07-31 10:32:22
```

### 总结

通过上述日志记录，我们可以得出以下结论：

- **现象**：使用`quit`命令退出Arthas会话后，实例继续运行，占用端口3658。尝试连接新进程时，Arthas无法重新使用该端口，导致连接失败。
- **解决方法**：使用`stop`命令而不是`quit`命令，确保Arthas实例完全停止，端口3658被释放。
- **结论**：为了避免端口冲突和连接失败问题，建议在退出Arthas时使用`stop`命令，而不是`quit`命令。

通过以上分析和总结，可以明确使用`stop`命令的重要性，从而确保Arthas实例正确停止，避免端口占用问题。









# 4 `java -cp xx.jar xx.xx.xx.XX` 启动命令

`java -jar xx.jar`命令启动的jar包启动类是已经确定好的(即约定好的)。

而 `java -cp xx.jar xx.xx.xx.XX` 启动命令，则是自己指定一个启动类！

指定xx.jar包中具体的某一个类来启动jar包程序。

如：`java -cp sa-jdi.jar sun.jvm.hotspot.HSDB`



![image-20240729193524928](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240729193524928.png)

以下是这两种启动命令的详细解释：

### `java -jar xx.jar`
这个命令用于运行一个可执行的JAR文件。JAR文件中的启动类是预先在JAR的 `META-INF/MANIFEST.MF` 文件中指定好的。具体来说，`MANIFEST.MF` 文件中会有一行 `Main-Class` ，指示JVM要执行哪个类的 `main` 方法。示例如下：

```
Manifest-Version: 1.0
Main-Class: com.example.Main
```

在这种情况下，当你执行 `java -jar xx.jar` 时，JVM 会找到 `META-INF/MANIFEST.MF` 文件中的 `Main-Class` ，并运行该类的 `main` 方法。

### `java -cp xx.jar xx.xx.xx.XX`
这个命令允许你手动指定要运行的类。 `-cp` 选项（或 `-classpath`）用于指定JAR文件或目录作为类路径，然后你可以指定要运行的类（包含包名）。例如：

```shell
java -cp xx.jar com.example.Main
```

在这种情况下，JVM不会去查找 `META-INF/MANIFEST.MF` 文件中的 `Main-Class` 。相反，它会直接运行你在命令行中指定的类 `com.example.Main` 的 `main` 方法。

### 总结
- **`java -jar xx.jar`**：启动类在JAR的 `META-INF/MANIFEST.MF` 文件中指定，不能在命令行中覆盖。
- **`java -cp xx.jar xx.xx.xx.XX`**：可以在命令行中指定要运行的类，灵活性更高。

这两种启动方式在不同的场景下各有优劣：
- 使用 `-jar` 更简单直观，适用于已经打包好并指定了启动类的JAR文件。
- 使用 `-cp` 更灵活，适用于需要手动指定或测试不同启动类的情况。



# 5 虚方法表

字节码中的虚方法表（Virtual Method Table，简称VMT或vtable）是Java中的一个数据结构，用于支持运行时的多态性和动态方法分派。具体来说，它是每个类的一个数组或表格，用于保存该类的所有虚方法（即可以被子类重写的方法）的地址。

### 虚方法表的结构和作用

#### 结构
每个类都有自己的虚方法表，虚方法表包含该类及其所有父类中可被重写的实例方法的指针。这些指针指向实际的方法实现。在Java中，虚方法表的存在和使用是由JVM（Java Virtual Machine）来管理的，并不是直接在Java代码中可见。

#### 作用
虚方法表的主要作用是支持运行时的动态方法分派。动态方法分派是在运行时根据对象的实际类型来决定调用哪个具体的实现方法。Java使用虚方法表来实现这一点，确保了方法调用的效率。

### 虚方法表的工作原理
1. **类加载时创建虚方法表**：当一个类被加载时，JVM会为该类创建虚方法表。这个表包含该类及其所有父类中的所有虚方法的地址。
   
2. **方法调用时查找虚方法表**：当调用一个方法时，JVM会检查该方法是否是一个虚方法。如果是虚方法，JVM会通过对象的类型信息找到相应的虚方法表，并从表中获取到实际的方法实现地址。

3. **动态分派**：通过虚方法表，JVM可以在运行时动态地分派方法调用到实际的实现方法。这确保了多态性的正确实现，即使在继承链上有多个类重写了同一个方法。

### 例子
假设有以下类结构：

```java
class Parent {
    void sayHello() {
        System.out.println("Hello from Parent");
    }
}

class Child extends Parent {
    @Override
    void sayHello() {
        System.out.println("Hello from Child");
    }
}
```

在这个例子中，`sayHello` 方法是一个虚方法。JVM在加载 `Parent` 类时，会创建一个包含 `sayHello` 方法地址的虚方法表。然后在加载 `Child` 类时，会创建一个新的虚方法表，这个表包含 `Child` 类中 `sayHello` 方法的地址。这样，当调用 `Child` 对象的 `sayHello` 方法时，JVM会通过虚方法表找到 `Child` 类的实现，并调用该实现。

### 总结
虚方法表是JVM用于实现动态方法分派和多态性的重要机制。它通过在运行时查找方法实现，确保了方法调用的动态性和灵活性。这种机制在Java中是透明的，开发者不需要直接与虚方法表交互，但它是理解Java多态性和方法调用的重要概念。



## 4.1 虚方法表的作用

虚方法表（Virtual Method Table，简称vtable）在面向对象编程中，尤其是在Java中，扮演着非常重要的角色。它的主要作用包括：

### 1. 实现动态方法分派（多态性）
虚方法表是实现动态方法分派（即多态性）的关键机制。在面向对象编程中，多态性允许子类对象在父类对象的上下文中被使用，并且调用的方法在运行时被确定。这种能力使得代码更加灵活和可扩展。

例如，当一个父类引用指向一个子类对象时，通过虚方法表可以调用子类的方法实现，而不是父类的方法实现：

```java
Parent obj = new Child();
obj.sayHello(); // 调用的是Child类的sayHello方法，而不是Parent类的sayHello方法
```

### 2. 提高方法调用的效率
虚方法表使得方法调用更高效。通过虚方法表，方法调用可以通过索引快速找到实际的方法实现地址，而不是每次调用时都进行复杂的查找操作。这个表在类加载时建立并固定，从而在运行时减少了方法查找的开销。

### 3. 支持继承和方法重写
在面向对象编程中，子类可以继承父类的方法，并对其进行重写。虚方法表支持这种继承关系，并确保子类的重写方法在运行时被正确调用。每个类都有一个虚方法表，包含了类及其父类中所有虚方法的地址。当子类重写父类的方法时，子类的虚方法表会更新为子类方法的地址。

### 4. 确保接口实现的正确性
在Java中，接口方法也是通过虚方法表来实现的。一个类实现了一个接口，就必须实现该接口中的所有方法。虚方法表保证了在调用接口方法时，实际执行的是实现类中的方法。

### 5. 支持抽象类和抽象方法
抽象类中可以包含抽象方法，这些方法没有具体实现，必须由子类提供实现。虚方法表确保了当调用这些方法时，能够找到子类提供的具体实现。

### 总结
虚方法表的主要作用可以概括为以下几点：
- **实现多态性**：支持运行时的动态方法分派。
- **提高效率**：通过索引快速找到方法实现地址，减少查找开销。
- **支持继承和方法重写**：确保子类重写方法在运行时被正确调用。
- **保证接口实现**：确保接口方法在实现类中被正确执行。
- **支持抽象类和抽象方法**：确保抽象方法在子类中被实现。

虚方法表是JVM在背后实现这些面向对象特性的关键数据结构，使得Java程序能够高效、正确地执行动态方法调用。

## 4.2 虚方法表通过索引直接访问方法实现，提高了动态方法调用的效率举例

虚方法表通过使用索引直接找到方法实现地址，大大提高了方法调用的效率。以下是一个详细的解释和示例，说明虚方法表如何工作以及如何提高效率的。

### 虚方法表工作原理示例

#### 类和方法定义

假设我们有一个简单的类继承结构：

```java
class Parent {
    void sayHello() {
        System.out.println("Hello from Parent");
    }
}

class Child extends Parent {
    @Override
    void sayHello() {
        System.out.println("Hello from Child");
    }

    void sayGoodbye() {
        System.out.println("Goodbye from Child");
    }
}
```

#### 虚方法表结构

当这些类被加载时，JVM会为每个类创建虚方法表。虚方法表包含该类的所有虚方法的地址。

对于`Parent`类，其虚方法表可能如下所示：

| 索引 | 方法            |
| ---- | --------------- |
| 0    | Parent.sayHello |

对于`Child`类，由于重写了`sayHello`方法并新增了`sayGoodbye`方法，其虚方法表如下：

| 索引 | 方法             |
| ---- | ---------------- |
| 0    | Child.sayHello   |
| 1    | Child.sayGoodbye |

#### 方法调用过程

当我们在运行时调用方法时，例如：

```java
Parent obj = new Child();
obj.sayHello();
```

JVM会执行以下步骤：

1. **确定对象的实际类型**：在这个例子中，`obj`的实际类型是`Child`。
2. **查找虚方法表**：JVM通过对象的类型找到`Child`类的虚方法表。
3. **使用索引查找方法实现**：`sayHello`方法在虚方法表中的索引是0，因此JVM通过索引0直接找到`Child.sayHello`方法的实现。
4. **调用方法**：执行找到的方法实现。

#### 提高效率的原因

通过使用虚方法表，JVM避免了在继承层次结构中逐层查找方法实现的复杂过程。相反，它使用索引直接访问方法实现，类似于数组查找。这大大减少了方法调用的时间开销。

### 示例代码

以下是一个简单的代码示例，展示了方法调用如何使用虚方法表提高效率：

```java
class Parent {
    void sayHello() {
        System.out.println("Hello from Parent");
    }
}

class Child extends Parent {
    @Override
    void sayHello() {
        System.out.println("Hello from Child");
    }

    void sayGoodbye() {
        System.out.println("Goodbye from Child");
    }
}

public class Main {
    public static void main(String[] args) {
        Parent obj = new Child();
        obj.sayHello(); // 调用的是Child类的sayHello方法
    }
}
```

在运行时，调用`obj.sayHello()`时，JVM会：

1. 通过`obj`的实际类型`Child`找到其虚方法表。
2. 通过索引0找到`Child.sayHello`方法的地址。
3. 直接调用`Child.sayHello`方法。

### 结论

虚方法表通过索引直接访问方法实现，提高了动态方法调用的效率。这种机制避免了在继承层次结构中逐层查找方法实现的复杂过程，从而减少了运行时的开销。这也是为什么虚方法表在面向对象编程语言中是实现多态性的重要机制。



# 6 自定义类的加载器

~~~
我是说我这个自定义类的加载器，在加载类时，都没有写解析的那段判断代码， 如何才能确保后面会执行解析操作呢？这样写是不是导致代码没有解析阶段？毕竟没有写 if (resolve) {
                resolveClass(c);
            }，这里java是如何处理的？
~~~



在自定义类的加载器时，可以不用写解析判断代码，JVM也会保证解析的顺利执行。

你提出的问题是关于在自定义类加载器中，如果没有显式调用`resolveClass`方法，Java虚拟机如何确保类的解析阶段会在后续某个时间点被执行。让我们详细讨论这个过程。

### 自定义类加载器示例

你的自定义类加载器主要负责读取字节码并定义类，而没有显式地进行解析（resolve）操作：

```java
@Override
protected Class<?> findClass(String className) throws ClassNotFoundException {
    BufferedInputStream bis = null;
    ByteArrayOutputStream baos = null;
    try {
        // 获取字节码文件的完整路径
        String fileName = byteCodePath + className + ".class";
        // 获取一个输入流
        bis = new BufferedInputStream(new FileInputStream(fileName));
        // 获取一个输出流
        baos = new ByteArrayOutputStream();
        // 具体读入数据并写出的过程
        int len;
        byte[] data = new byte[1024];
        while ((len = bis.read(data)) != -1) {
            baos.write(data, 0, len);
        }
        // 获取内存中的完整的字节数组的数据
        byte[] byteCodes = baos.toByteArray();
        // 调用defineClass()，将字节数组的数据转换为Class的实例
        Class<?> clazz = defineClass(null, byteCodes, 0, byteCodes.length);
                    // 到这里自定义类的加载器的逻辑就结束了，即不写if (resolve) { resolveClass(c); }这段代码也可以正常完成类的加载工作。
            // 并没有像ClassLoader类源码中的loadClass()方法一样，书写判断是否在类的加载阶段判断是否执行解析操作。
            /**
             * 解析阶段的执行
             * 在Java类加载机制中，解析阶段是类加载过程中的一个重要环节，
             * 它会将类的符号引用转换为直接引用。
             * 尽管在自定义类加载器中没有显式调用resolveClass，
             * 但Java虚拟机会在第一次使用该类时自动触发解析过程。
             *
             * 解析阶段的自动触发
             * 当类的符号引用（如静态字段、静态方法等）被首次使用时，Java虚拟机会确保该类已经被解析。
             * 在这些情况下，Java虚拟机会检查该类是否已经解析。如果没有，则会自动触发解析阶段。
             * 这意味着，即使在自定义类加载器中没有显式调用resolveClass，在实际使用类时，Java虚拟机会确保解析阶段被执行。
             * 
             * 总结
             * 自定义类加载器：在自定义类加载器中，如果没有显式调用resolveClass，解析阶段不会在加载时立即执行。
             * 解析的自动触发：Java虚拟机在第一次使用类时（如访问静态字段、调用静态方法或创建类实例），会自动触发解析阶段。
             * 安全性和正确性：无论是否在加载时显式调用resolveClass，Java虚拟机都会确保类在使用前已经完成解析阶段，从而保证程序的安全性和正确性。
             * 通过这些机制，Java虚拟机能够确保即使在自定义类加载器中没有显式调用resolveClass，类的解析阶段也会在适当的时候自动进行。
             */
        return clazz;
    } catch (IOException e) {
        e.printStackTrace();
    } finally {
        try {
            if (baos != null) baos.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        try {
            if (bis != null) bis.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    return null;
}
```

### 解析阶段的执行

在Java类加载机制中，解析阶段是类加载过程中的一个重要环节，它会将类的符号引用转换为直接引用。尽管在自定义类加载器中没有显式调用`resolveClass`，但Java虚拟机会在第一次使用该类时自动触发解析过程。

### 解析阶段的自动触发

当类的符号引用（如静态字段、静态方法等）被首次使用时，Java虚拟机会确保该类已经被解析。以下是几种典型的触发解析的情况：

1. **访问静态字段**：
   ```java
   MyClass.myStaticField;
   ```

2. **调用静态方法**：
   ```java
   MyClass.myStaticMethod();
   ```

3. **创建类实例**：
   ```java
   new MyClass();
   ```

在这些情况下，Java虚拟机会检查该类是否已经解析。如果没有，则会自动触发解析阶段。这意味着，即使在自定义类加载器中没有显式调用`resolveClass`，在实际使用类时，Java虚拟机会确保解析阶段被执行。

### 实验示例

下面是一个使用自定义类加载器的示例，演示解析阶段的自动触发：

```java
public class CustomClassLoaderTest {
    public static void main(String[] args) throws Exception {
        MyClassLoader classLoader = new MyClassLoader("path/to/bytecodes/");
        Class<?> clazz = classLoader.loadClass("com.example.MyClass");
        
        // 在这里没有显式调用resolveClass
        // 但在首次使用类时，解析会自动触发
        
        // 触发解析：访问静态字段
        Field field = clazz.getField("myStaticField");
        System.out.println(field.get(null));
        
        // 触发解析：调用静态方法
        Method method = clazz.getMethod("myStaticMethod");
        method.invoke(null);
    }
}
```

### 总结

1. **自定义类加载器**：在自定义类加载器中，如果没有显式调用`resolveClass`，解析阶段不会在加载时立即执行。
2. **解析的自动触发**：Java虚拟机在第一次使用类时（如访问静态字段、调用静态方法或创建类实例），会自动触发解析阶段。
3. **安全性和正确性**：无论是否在加载时显式调用`resolveClass`，Java虚拟机都会确保类在使用前已经完成解析阶段，从而保证程序的安全性和正确性。

通过这些机制，Java虚拟机能够确保即使在自定义类加载器中没有显式调用`resolveClass`，类的解析阶段也会在适当的时候自动进行。



# 7 **OSGi** 是 **Open Services Gateway Initiative** 的缩写。OSGi 是一个动态模块化系统

**JDK 本身没有使用过 OSGi。**OSGi 是一种模块化系统和服务平台，主要用于 Java，但它并不是 JDK 的一部分。

**OSGi** 是 **Open Services Gateway Initiative** 的缩写。OSGi 是一个动态模块化系统，它为 Java 应用程序提供了一个组件模型，使开发者可以将应用程序分解成多个模块（称为捆绑包，bundles），这些模块可以在运行时独立安装、启动、停止、更新和卸载。

OSGi 的主要特点和优势包括：

1. **动态模块化**：允许模块在运行时动态地加载和卸载，从而使得应用程序可以灵活地进行更新和维护。
2. **服务导向**：OSGi 提供了服务注册和发现的机制，使得模块之间可以通过服务进行通信，而不需要直接依赖。
3. **版本控制**：支持模块的版本控制，允许同一个模块的不同版本共存，以解决版本冲突问题。
4. **隔离和封装**：每个模块有自己的类加载器，实现了类和资源的隔离，增强了应用程序的安全性和稳定性。

OSGi 被广泛应用于企业级应用、嵌入式系统和其他需要动态模块化和服务管理的场景。例如，Apache Karaf 和 Eclipse IDE 都是基于 OSGi 技术的。

总结来说，虽然 JDK 没有使用 OSGi，但 OSGi 作为一种独立的模块化系统，为许多 Java 应用程序提供了强大的模块化和动态管理功能。





**Jigsaw**	拼图；竖锯；拼图玩具	/ˈdʒɪɡsɔː/



**JDK 现在使用的是 Jigsaw 模块系统，而不是 OSGi。**Jigsaw 项目在 JDK 9 中引入了模块系统，以替代传统的 monolithic JAR 文件结构。这种模块系统使得 Java 平台和应用程序可以更好地组织代码，并提供更强的封装和模块化支持。

Jigsaw 模块系统的主要特点包括：

1. **模块定义**：使用 `module-info.java` 文件定义模块及其依赖关系。
2. **强封装**：模块只能访问明确导出的包，从而提高了代码的封装性和安全性。
3. **可靠配置**：模块系统在编译时和运行时都能检测模块依赖关系和版本冲突。
4. **改进的性能**：模块系统减少了类加载的开销，提高了启动性能和运行效率。

尽管 OSGi 也是一种模块化系统，并且在许多企业级应用中被广泛使用，但 JDK 自身并没有直接使用 OSGi，而是通过 Jigsaw 项目引入了原生的模块化支持。



# 8 使用Arthas实现热部署机制



![image-20240801181138313](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240801181138313.png)





- `jad` 命令将 JVM 中实际运行的 class 的 byte code 反编译成 java 代码，便于你理解业务逻辑；如需批量下载指定包的目录的 class 字节码可以参考 [dump](https://arthas.aliyun.com/doc/dump.html)。

默认情况下，反编译结果里会带有`ClassLoader`信息，通过`--source-only`选项，可以只打印源代码。方便和[mc](https://arthas.aliyun.com/doc/mc.html)/[retransform](https://arthas.aliyun.com/doc/retransform.html)命令结合使用。

```java
 jad --source-only demo.MathGame
```



- `mc` 命令, Memory Compiler/内存编译器，编译`.java`文件生成`.class`。

可以通过`-c`参数指定 classloader：

```bash
mc -c 327a647b /tmp/Test.java
```

可以通过`-d`命令指定输出目录：

```bash
mc -d /tmp/output /tmp/ClassA.java /tmp/ClassB.java
```

编译生成`.class`文件之后，可以结合[retransform](https://arthas.aliyun.com/doc/retransform.html)命令实现热更新代码。

注意

注意，mc 命令有可能失败。如果编译失败可以在本地编译好`.class`文件，再上传到服务器。具体参考[retransform](https://arthas.aliyun.com/doc/retransform.html)命令说明。





- `retransform`命令，加载外部的`.class`文件，retransform jvm 已加载的类。







# 9 在 Java 中，使用 Arthas 的 `retransform` 进行类的 retransformation（重新转换）时，有一些重要的限制需要注意。以下是这些限制及其解释：

### 1. 不能增加字段和方法
使用Arthas 的 `retransform` 对类进行重新转换时，不能增加新的字段（fields）和方法（methods）。这意味着只能对现有的方法进行修改，而不能添加新的成员变量或新方法。这是因为 JVM 在加载类时已经分配了内存结构，并且新增字段和方法会改变类的内存布局，可能导致内存访问错误和 JVM 崩溃。

### 2. 正在运行的方法不能立即生效
如果一个方法正在运行中，重新转换后的代码不会立即生效，只有当方法重新被调用时，新的代码才会生效。具体来说，如果一个方法正在执行，它所对应的字节码已经加载到 JVM 中，直到方法执行完毕退出，再次调用该方法时，JVM 才会使用重新转换后的字节码。

### 示例代码解释

```java
public class MathGame {
    public static void main(String[] args) throws InterruptedException {
        MathGame game = new MathGame();
        while (true) {
            game.run();
            TimeUnit.SECONDS.sleep(1);
            // 这个不生效，因为代码一直跑在 while里
            System.out.println("in loop");
        }
    }

    public void run() throws InterruptedException {
        // 这个生效，因为run()函数每次都可以完整结束
        System.out.println("call run()");
        try {
            int number = random.nextInt();
            List<Integer> primeFactors = primeFactors(number);
            print(number, primeFactors);

        } catch (Exception e) {
            System.out.println(String.format("illegalArgumentCount:%3d, ", illegalArgumentCount) + e.getMessage());
        }
    }
}
```

### 代码详细解释

1. **`main` 方法中的 `while` 循环**

```java
while (true) {
    game.run();
    TimeUnit.SECONDS.sleep(1);
    // 这个不生效，因为代码一直跑在 while里
    System.out.println("in loop");
}
```

- `while` 循环中的 `System.out.println("in loop");` 不会立即生效，因为 `while` 循环一直在运行，即使进行了类的重新转换，这段代码也不会重新被编译和执行。(即旧的死循环中的代码一直在运行，不会得到更新，因为一直再跑旧的死循环中的代码)
- 只有当整个 `while` 循环体结束后再次进入循环时，新的字节码才会生效，但在无限循环中，这段代码永远不会退出，所以不会生效。

2. **`run` 方法**

```java
public void run() throws InterruptedException {
    // 这个生效，因为run()函数每次都可以完整结束
    System.out.println("call run()");
    try {
        int number = random.nextInt();
        List<Integer> primeFactors = primeFactors(number);
        print(number, primeFactors);

    } catch (Exception e) {
        System.out.println(String.format("illegalArgumentCount:%3d, ", illegalArgumentCount) + e.getMessage());
    }
}
```

- `run` 方法中的 `System.out.println("call run()");` 会生效，因为 `run` 方法每次调用都会完整结束。当 `run` 方法结束后，再次调用 `run` 时，重新转换的代码会生效。

### 总结

在使用 Java Instrumentation API 进行类的重新转换时，需要注意以下几点：

- **不能增加字段和方法**：只能修改现有的方法。
- **正在运行的方法不能立即生效**：只有当方法重新调用时，新的字节码才会生效。

在示例代码中，`main` 方法中的 `while` 循环代码因为不会退出，所以重新转换的代码不会生效，而 `run` 方法中的代码因为每次调用都会完整结束，所以会生效。







# 10 在使用Arthas指令`mc -c 327a647b /tmp/Test.java`时，为什么需要指定类的加载器？才能加载成功？否则会出现许多找不到指定的类的提示？

在使用 Arthas 的 `mc`（`mc` 是 `Memory Compiler` 的缩写）指令进行类热替换时，指定类加载器是至关重要的。以下是原因及详细解释：

### 类加载器的作用

Java 中的类加载器（ClassLoader）负责加载类文件到 JVM 中。在复杂的应用程序中，通常会有多个类加载器，每个类加载器加载不同的类集合。类加载器的设计允许在不同的上下文中加载同名类，使得类的命名空间更加灵活。

### 为什么需要指定类加载器

1. **类加载器的唯一性**：
   - 在 Java 中，同一个类名可以由不同的类加载器加载，形成不同的类定义。每个类加载器加载的类是唯一的，JVM 将由不同类加载器加载的类视为不同的类。

2. **准确定位目标类**：
   - 当你使用 Arthas 的 `mc` 指令对一个类进行重新编译和加载时，需要确保该类被正确的类加载器加载。如果不指定类加载器，Arthas 可能会使用错误的类加载器进行加载，从而导致找不到指定的类。

### 问题分析

当你不指定类加载器时，`mc` 指令会使用默认的系统类加载器或当前线程的上下文类加载器。如果目标类不是由这些类加载器加载的，`mc` 就无法找到该类，从而出现找不到指定类的错误提示。

例如，在一个复杂的应用环境中（如 Spring、Tomcat 等），应用可能会使用多个自定义类加载器来隔离不同模块或组件。如果你要重新编译和加载一个由自定义类加载器加载的类，必须指定正确的类加载器，否则会出现找不到类的情况。

### 例子

假设 `Test` 类由类加载器 `327a647b` 加载：

```bash
mc -c 327a647b /tmp/Test.java
```

在这个命令中，`-c 327a647b` 参数指定了类加载器的标识符，确保 `mc` 指令使用正确的类加载器来加载重新编译的类。

### 类加载器的获取

在实际操作中，你可以通过以下方式获取类加载器的标识符：

1. **通过 Arthas 的 `sc` 命令**：
   
   - **使用 `sc` 命令查看类的详细信息，包括类加载器信息。**例如：
     
     ```bash
     sc -d com.example.Test
     ```
     这条命令会显示 `Test` 类的详细信息，包括加载它的类加载器的标识符。
   
2. **通过日志或调试信息**：
   - 在某些情况下，类加载器的信息可能会在应用的日志或调试信息中出现，可以通过这些途径获取类加载器标识符。

### 总结

在使用 Arthas 的 `mc` 指令进行类热替换时，指定类加载器是为了确保重新编译的类被正确加载。由于 Java 中类加载器的唯一性和复杂性，不同的类加载器加载的类是不同的，如果不指定类加载器，可能会导致找不到指定类的错误。因此，通过 `-c` 参数指定正确的类加载器，可以确保 `mc` 指令成功加载重新编译的类。





类的重新加载和替换现有的类定义通常是通过 `retransform` 这样的指令完成的。`mc`（Memory Compiler）指令的主要工作是将 .java 文件编译为 .class 文件。下面是一个更清晰的解释：

### `mc` 和 `retransform` 的角色区分

1. **`mc`（Memory Compiler）指令**：
   - 主要用于编译 .java 源文件并生成 .class 字节码文件。
   - 这个过程中，`mc` 需要使用正确的类加载器来查找和加载编译过程中所需的类（如依赖类、父类、接口等），但它本身不负责将新的类定义加载到 JVM 中。

2. **`retransform` 指令**：
   - 主要用于在运行时重新转换（retransform）和重新定义（redefine）类。
   - 通过这个指令，可以将新的类定义加载到 JVM 中，以替换现有的类定义。

### 为什么 `mc` 需要指定类加载器

尽管 `mc` 主要用于编译源码，但在以下情况下需要指定类加载器：

1. **查找依赖类**：编译过程中，`mc` 需要查找源文件中引用的其他类（如父类、接口、方法参数类型等）。如果这些类由自定义类加载器加载，则需要指定正确的类加载器，以确保编译过程中能找到这些依赖类。

2. **编译环境一致性**：在复杂的应用中，不同模块可能使用不同的类加载器。如果不指定类加载器，可能会导致编译环境与运行时环境不一致，从而引发类加载错误。

### 实际操作流程

1. **使用 `mc` 编译源文件**：
   ```bash
   mc -c 327a647b /tmp/Test.java
   ```
   这一步确保 `Test.java` 被正确编译，并生成 `Test.class` 文件。在编译过程中，指定的类加载器 `327a647b` 会被用来查找编译过程中所需的依赖类。

2. **使用 `retransform` 重新转换类**：
   一旦 `Test.class` 文件生成，可以使用 `retransform` 指令将新的类定义加载到 JVM 中，以替换现有的类定义。例如：
   ```bash
   retransform Test
   ```
   这一步将新的 `Test` 类定义加载到 JVM 中，实际执行重新转换和替换操作。

### 示例

假设你有一个 `MathGame` 类，并希望在运行时修改这个类：

1. **编译 `MathGame.java`**：
   ```bash
   mc -c 327a647b /tmp/MathGame.java
   ```
   这一步确保 `MathGame.java` 被正确编译，并生成 `MathGame.class` 文件。

2. **重新转换 `MathGame` 类**：
   ```bash
   retransform MathGame
   ```
   这一步将新的 `MathGame` 类定义加载到 JVM 中。

### 总结

- `mc` 指令用于编译 .java 文件，需要指定类加载器以确保编译过程中能正确查找依赖类。
- 类的重新转换和加载新定义通常是 `retransform` 指令的工作。
- 指定类加载器是为了确保编译和加载过程中的一致性，避免在复杂应用环境中出现类加载错误。





# 11 在Windows上使用Arthas的jad指令反编译某个运行着的项目中的某个.class类的方法

具体类的位置是：

~~~
D:\Java_developer_tools\mycode\jvm\JVMDemo1\springboot-classfile\target\classes\com\itheima\springbootclassfile\controller\UserController.class
~~~

具体的业务测试代码如下：

~~~java
package com.itheima.springbootclassfile.controller;

import com.itheima.springbootclassfile.common.UserType;
import com.itheima.springbootclassfile.pojo.vo.UserVO;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/user")
public class UserController {

    //企业中代码一般通过调用service从数据库查,本案例简化代码
    // http://localhost:8080/user/1001/1
    // D:\Java_developer_tools\mycode\jvm\JVMDemo1\springboot-classfile\target\classes\com\itheima\springbootclassfile\controller\UserController.class
    @GetMapping("/{type}/{id}")
    public UserVO user(@PathVariable("type") Integer type, @PathVariable("id") Integer id) {
        //前边有一大堆逻辑，巴拉巴拉
        // 如果用户的type是 1001 则会进入到下面这行代码
        // 但是这里使用的是 == 引用数据类型做等等比较为false!
        // 即如果传入的type是非1002(普通用户),也会看到VIP用户的内容！
        if (type == UserType.REGULAR.getType()) {
            // if(type.equals(UserType.REGULAR.getType())){
            return new UserVO(id, "普通用户无权限查看");
        }

        return new UserVO(id, "这是尊贵的收费用户才能看的秘密!");
    }
}

~~~



使用 Arthas 的 `jad` 命令可以反编译 Java 类文件。以下是使用 `jad` 命令反编译特定类文件的步骤。

### 步骤

1. **启动 Arthas**：
   - 在你的 JVM 应用程序中嵌入 Arthas，或者通过命令行启动 Arthas 以连接到正在运行的 JVM 应用程序。
   - 例如，假设你的 Spring Boot 应用程序已经在运行，运行以下命令来启动 Arthas：
     ```sh
     java -jar arthas-boot.jar
     ```

2. **选择目标进程**：
   - 在启动 Arthas 后，它会列出当前运行的所有 Java 进程。选择目标应用程序的 PID（进程 ID）。
     ```
     * [1] 3284 com.example.MyApplication
       [2] 5678 another.JavaProcess
     ```
   - 输入目标应用程序的编号（例如，输入 `1` 选择 PID 为 3284 的进程）。

3. **查找并反编译类文件**：
   - 使用 `sc` 命令查找加载的类：
     ```sh
     sc -d com.itheima.springbootclassfile.controller.UserController
     ```
   - 查找到具体的类加载器后，使用 `jad` 命令反编译类文件：
     ```sh
     jad com.itheima.springbootclassfile.controller.UserController
     ```

### 示例步骤

1. **启动 Arthas 并连接到目标 JVM 进程**：
   ```sh
   java -jar arthas-boot.jar
   ```
   选择正确的 JVM 进程（例如，输入 `1`）。

2. **查找类的具体加载器**：
   ```sh
   sc -d com.itheima.springbootclassfile.controller.UserController
   ```
   这将显示加载 `UserController` 类的类加载器及其详细信息。

3. **使用 `jad` 命令反编译类文件**：
   ```sh
   jad com.itheima.springbootclassfile.controller.UserController
   ```
   这将反编译并显示 `UserController` 类的源代码。

### 注意事项

- 确保你的 JVM 应用程序正在运行并且 Arthas 可以连接到该进程。
- 确保目标类文件已经被 JVM 加载，否则 `sc` 命令可能无法找到该类。

通过这些步骤，你可以使用 Arthas 的 `jad` 命令反编译特定的类文件，并查看其源代码。

## 11.1 arthas连接上就不用指定盘符了，而是使用项目的相对路径就行

是的，当使用 Arthas 连接到正在运行的 JVM 进程时，你不需要指定磁盘驱动器的绝对路径。**Arthas 操作的是 JVM 进程内存中的类，所以你只需提供类的完全限定名，而不需要考虑文件系统的路径。**

### 操作步骤详解

1. **启动 Arthas 并连接到目标 JVM 进程**：
   ```sh
   java -jar arthas-boot.jar
   ```
   启动 Arthas 后，选择需要连接的 JVM 进程。假设列表中显示的进程如下：
   ```
   * [1] 3284 com.example.MyApplication
     [2] 5678 another.JavaProcess
   ```
   你可以通过输入数字选择相应的进程，例如输入 `1` 选择 PID 为 3284 的进程。

2. **查找目标类**：
   使用 `sc`（Search Class）命令查找 JVM 中已加载的类：
   ```sh
   sc -d com.itheima.springbootclassfile.controller.UserController
   ```
   这将显示 `UserController` 类的详细信息，包括类加载器信息。

3. **反编译目标类**：
   使用 `jad`（Java Decompiler）命令反编译目标类：
   ```sh
   jad com.itheima.springbootclassfile.controller.UserController
   ```
   这将反编译 `UserController` 类，并在控制台显示反编译后的源代码。

### 示例操作

假设你的项目结构如下，并且目标类是 `UserController`：
```
D:\Java_developer_tools\mycode\jvm\JVMDemo1\springboot-classfile\target\classes\com\itheima\springbootclassfile\controller\UserController.class
```

当你启动并连接到 JVM 进程后，只需要提供类的完全限定名（即包名+类名）即可。

1. **启动 Arthas 并连接到 JVM 进程**：
   ```sh
   java -jar arthas-boot.jar
   ```
   选择对应的 JVM 进程。

2. **查找类信息**：
   ```sh
   sc -d com.itheima.springbootclassfile.controller.UserController
   ```
   这将列出所有已加载的 `UserController` 类的信息。

3. **反编译类**：

   ```sh
   jad com.itheima.springbootclassfile.controller.UserController
   ```
   这将反编译并显示 `UserController` 类的源代码。

4. **反编译时只显示源代码**：

   ```sh
   jad --source-only com.itheima.springbootclassfile.controller.UserController
   ```

   这将反编译并显示 `UserController` 类的源代码。

**反编译时只显示源代码并写入到指定文件**：

```sh
jad --source-only com.itheima.springbootclassfile.controller.UserController > D:\\aatest\\arthas_jad\\UserController.java
```

注意: 在Windows环境下需要使用双反斜杠才能保存至目标目录中！在Linux环境下则可以使用单正斜杠`/`即可

### 总结

在使用 Arthas 进行类操作时，你只需要知道类的完全限定名（如 `com.itheima.springbootclassfile.controller.UserController`），而不需要知道或指定类文件在磁盘上的物理路径。Arthas 通过连接到 JVM 进程，直接在内存中操作这些类。





# 12 使用arthas进行热部署





当你启动并连接到 JVM 进程后，只需要提供类的完全限定名（即包名+类名）即可。

1. **启动 Arthas 并连接到 JVM 进程**：

   ```sh
   java -jar arthas-boot.jar
   ```

   选择对应的 JVM 进程。

2. **查找类信息**：

   ```sh
   sc -d com.itheima.springbootclassfile.controller.UserController
   ```

   这将列出所有已加载的 `UserController` 类的信息。

3. **反编译类**：

   ```sh
   jad com.itheima.springbootclassfile.controller.UserController
   ```

   这将反编译并显示 `UserController` 类的源代码。

4. **反编译时只显示源代码**：

   ```sh
   jad --source-only com.itheima.springbootclassfile.controller.UserController
   ```

   这将反编译并显示 `UserController` 类的源代码。

   

1. **反编译时只显示源代码并写入到指定文件**：

   ```sh
   jad --source-only com.itheima.springbootclassfile.controller.UserController > D:\\aatest\\arthas_jad\\UserController.java
   ```

   注意: 在Windows环境下需要使用双反斜杠才能保存至目标目录中！在Linux环境下则可以使用单正斜杠`/`即可

   ![image-20240801234357992](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240801234357992.png)



热替换的步骤：

![image-20240802001302021](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240802001302021.png)



**通过 Arthas 的 `sc` 命令**：

- **使用 `sc` 命令查看类的详细信息，包括类加载器信息。**例如：

     ~~~
     sc -d com.itheima.springbootclassfile.controller.UserController
     ~~~

![image-20240802001804732](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240802001804732.png)



假设 `Test` 类由类加载器 `18b4aac2` 加载（Linux下的指令）：

```bash
mc -c 18b4aac2 /tmp/Test.java
```

在这个命令中，`-c 18b4aac2` 参数指定了类加载器的标识符，确保 `mc` 指令使用正确的类加载器来加载重新编译的类。

Windows下的 `mc` 指令使用（错误示例，但是在Windows下并没有像Linux执行类似操作时报错`符号找不到`）：

~~~
mc D:\\aatest\\arthas_jad\\UserController.java        #需要使用`-c`指定类的加载器hashcode才可以编译成功
~~~

Windows下的 `mc` 指令使用（正确示例）：

~~~
mc -c 18b4aac2 D:\\aatest\\arthas_jad\\UserController.java
~~~

**如果是在Linux环境下不指定类的加载器的hashcode,会报错`找不到很多的类`**

![image-20240802002628547](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240802002628547.png)

![image-20240802002726391](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240802002726391.png)



**`-d`参数指定编译后的.class文件的输出目录**

~~~
mc -c 18b4aac2 D:\\aatest\\arthas_jad\\UserController.java -d D:\\aatest\\arthas_jad\\
~~~



使用`retransform`指令，进行热加载/热部署

~~~
retransform D:\\aatest\\arthas_jad\\com\\itheima\\springbootclassfile\\controller\\UserController.class
~~~

热部署成功再次使用jad查看当前运行的程序中的类是否被替换掉了

~~~sh
jad --source-only com.itheima.springbootclassfile.controller.UserController
~~~

![image-20240802003918321](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240802003918321.png)

发现热部署成功！

## 注意：程序/进程重新启动后,这样使用Arthas热部署的代码就失效了！因为重新启动程序会重新加载原来项目中没有实时修改过的类。retransform指令只是将最新的.class文件信息更新到了内存中，重启后更新的信息就丢失了。

如果想要永久修改，可以将发布后的项目的jar包中的.class文件替换掉。

![image-20240802004324397](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240802004324397.png)



### 总结

## 所以Arthas的热部署只是一个应急手段，正常的修复bug流程还是需要将你的程序重新进行编译、打包并部署到服务器上去修复这个bug!

在使用 Arthas 进行类操作时，你只需要知道类的完全限定名（如 `com.itheima.springbootclassfile.controller.UserController`），而不需要知道或指定类文件在磁盘上的物理路径。Arthas 通过连接到 JVM 进程，直接在内存中操作这些类。



# 13 Windows PowerShell 中文乱码问题

![image-20240801231754005](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240801231754005.png)



在 Windows PowerShell 中，中文字符显示乱码通常是由于编码设置不正确引起的。要解决这个问题，可以按照以下步骤操作：

### 设置 PowerShell 的编码

1. **设置 PowerShell 控制台的编码为 UTF-8**：

   - 在 PowerShell 中运行以下命令，将控制台输出的编码设置为 UTF-8：

     ```powershell
     [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
     ```

2. **更改 PowerShell 使用的字体**：

   - 在 PowerShell 控制台窗口的标题栏上右键点击，选择 “属性”。
   - 在 “字体” 选项卡中，选择支持中文显示的字体，如 “Consolas” 或 “等宽字体（等宽宋体）”。

3. **确保文件编码为 UTF-8**：

   - 如果你的源文件包含中文字符，确保这些文件的编码是 UTF-8。在大多数文本编辑器中都可以设置文件编码。例如，在 Visual Studio Code 中，可以通过点击右下角的编码信息并选择 “UTF-8” 来更改文件编码。

4. **设置 PowerShell 配置文件（可选）**：

   - 你可以将上述编码设置添加到 PowerShell 配置文件中，以便每次启动 PowerShell 时都自动应用这些设置。

   - 打开 PowerShell 配置文件（如果不存在，可以创建一个）：

     ```powershell
     notepad $PROFILE
     ```

   - 在打开的文件中添加以下内容并保存：

     ```powershell
     # 设置控制台输出编码为 UTF-8
     [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
     
     # 设置控制台输入编码为 UTF-8
     $OutputEncoding = [System.Text.Encoding]::UTF8
     ```

### 示例操作

1. **设置控制台输出编码**：

   ```powershell
   [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
   ```

2. **检查文件编码**：

   - 确保包含中文字符的源文件（如 Java 文件）使用的是 UTF-8 编码。

3. **配置文件自动设置**（可选）：

   - 编辑 PowerShell 配置文件：

     ```powershell
     notepad $PROFILE
     ```

   - 添加以下内容：

     ```powershell
     [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
     ```

### 验证

完成以上步骤后，可以重新运行 Arthas 的 `jad` 命令，验证中文字符是否正确显示。

### 注意

- 如果你使用的是 PowerShell Core（`pwsh`），同样适用上述方法。
- 确保你的 PowerShell 控制台能够正确显示其他 UTF-8 编码的中文内容，以验证编码设置是否生效。

通过这些步骤，应该可以解决 PowerShell 中的中文乱码问题，确保正确显示中文字符。



## 10.1 PowerShell 配置文件设置

PowerShell 配置文件是一个特定名称的脚本文件，通常名为 `Microsoft.PowerShell_profile.ps1`。这个文件的后缀是 `.ps1`，它是 PowerShell 脚本文件的标准扩展名。

### 创建和编辑 PowerShell 配置文件

1. **查看当前 PowerShell 配置文件路径**：
   在 PowerShell 中运行以下命令来查看当前用户的 PowerShell 配置文件路径：

   ```powershell
   $PROFILE
   ```

   ![image-20240802010600772](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240802010600772.png)

2. **创建或编辑配置文件**：
   使用以下命令打开配置文件。如果文件不存在，命令会自动创建它：

   ```powershell
   notepad $PROFILE
   ```

   或者，你可以使用其他文本编辑器，如 VSCode：

   ```powershell
   code $PROFILE
   ```

   或者直接创建对应的目录结构

   `C:\Users\yangd\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1`

   并在文件中添加配置内容：`[Console]::OutputEncoding = [System.Text.Encoding]::UTF8`

3. **在配置文件中添加内容**：
   在打开的配置文件中添加你需要的配置。例如，要设置 PowerShell 控制台的编码为 UTF-8，可以添加以下内容：

   ```powershell
   [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
   ```

4. **保存并关闭编辑器**：
   保存你在配置文件中所做的更改并关闭编辑器。

### 示例操作

1. **打开 PowerShell 配置文件**：

   ```powershell
   notepad $PROFILE
   ```

2. **在配置文件中添加内容**：

   ```powershell
   [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
   ```

3. **保存并关闭**：

### 验证配置文件是否生效

重新启动 PowerShell 或者运行以下命令重新加载配置文件，以确保配置文件中的设置生效：

```powershell
. $PROFILE
```

通过这些步骤，你可以创建和编辑 PowerShell 配置文件，并在其中添加自定义设置，以便每次启动 PowerShell 时自动应用这些配置。



## 如果重启后报错如下：

![image-20240802011352101](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240802011352101.png)

## 则需要：

这是因为你的 PowerShell 执行策略设置为禁止运行脚本。要允许运行脚本，你需要更改 PowerShell 的执行策略。可以按照以下步骤操作：

### 修改 PowerShell 执行策略

1. **打开 PowerShell**：
   以管理员身份打开 PowerShell（右键点击 PowerShell 图标，选择“以管理员身份运行”）。

2. **查看当前执行策略**：
   运行以下命令查看当前执行策略：

   ```powershell
   Get-ExecutionPolicy			#默认是返回Restricted，受限制的权限。
   ```

3. **设置执行策略为 `RemoteSigned` 或 `Unrestricted`**：**Restricted(受限制的)**
   为了允许运行本地脚本，可以将执行策略设置为 `RemoteSigned`（允许本地脚本运行，要求远程脚本有签名）或 `Unrestricted`（允许所有脚本运行）：

   ```powershell
   Set-ExecutionPolicy RemoteSigned
   ```

   或者：

   ```powershell
   Set-ExecutionPolicy Unrestricted
   ```

4. **确认更改**：
   在提示时，输入 `Y` 确认更改。

### 示例操作

1. **以管理员身份打开 PowerShell**。

2. **设置执行策略为 `RemoteSigned`**：

   ```powershell
   Set-ExecutionPolicy RemoteSigned
   ```

   确认更改：

   ```plaintext
   Execution Policy Change
   The execution policy helps protect you from scripts that you do not trust. Changing the execution policy might expose
   you to the security risks described in the about_Execution_Policies help topic at
   https:/go.microsoft.com/fwlink/?LinkID=135170. Do you want to change the execution policy?
   [Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "N"): Y
   ```

3. **再次运行配置文件**：
   关闭并重新打开 PowerShell，然后运行以下命令重新加载配置文件：

   ```powershell
   . $PROFILE
   ```

### 恢复默认执行策略（可选）

如果你希望在设置完成后恢复默认的执行策略，可以将执行策略设置回默认的 `Restricted`：

```powershell
Set-ExecutionPolicy Restricted
```

通过以上步骤，你应该能够解决执行策略的问题，并允许 PowerShell 加载和运行你的配置文件。



# 14 `top`指令详细解释

b站直达地址：

https://www.bilibili.com/video/BV1r94y1b7eS?p=42&vd_source=5b09ee9382c8983b40a6600e7faeb262



![image-20240811191130175](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240811191130175.png)



这张图片展示了一个Linux系统下的`top`命令的输出，它用于监控系统的进程和性能情况。以下是每一行的详细分析：

### 第一行：总体系统信息

- **09:02:51**：当前系统时间。
- **up 4 min**：系统已经启动并运行了4分钟。
- **2 users**：当前有2个用户登录到系统。
- **load average: 0.02, 0.10, 0.06**：系统在过去1分钟、5分钟和15分钟内的平均负载。负载值越接近CPU核心数，表示系统负载越大。

### 第二行：进程信息

- **Tasks: 100 total**：系统中总共有100个任务（进程）。
- **1 running**：当前有1个正在运行的任务。
- **53 sleeping**：53个任务处于睡眠状态（等待资源或事件）。
- **0 stopped**：没有被停止的任务。
- **0 zombie**：没有僵尸进程（已终止但未被回收的进程）。

### 第三行：CPU状态

- **%Cpu(s): 0.5 us**：用户空间占用了0.5%的CPU时间。
- **0.8 sy**：系统空间占用了0.8%的CPU时间。
- **0.0 ni**：用户进程通过`nice`命令调整优先级后占用的CPU时间为0%。
- **98.7 id**：CPU有98.7%的时间处于空闲状态。
- **0.0 wa**：CPU等待I/O操作完成的时间为0%。
- **0.0 hi**：硬件中断占用的时间为0%。
- **0.0 si**：软件中断占用的时间为0%。
- **0.0 st**：虚拟化系统中其他操作系统偷取的CPU时间为0%。

### 第四行：内存使用情况

- **KiB Mem: 3948748 total**：总共有3948748 KiB的物理内存。
- **3280784 free**：空闲的内存有3280784 KiB。
- **124472 used**：已经使用的内存有124472 KiB。
- **543492 buff/cache**：用于缓存和缓冲的内存有543492 KiB。

### 第五行：交换区使用情况

- **KiB Swap: 0 total**：没有配置交换区（swap）。
- **0 free**：空闲的交换区为0 KiB。
- **0 used**：已经使用的交换区为0 KiB。
- **3669840 avail Mem**：总共可用的内存有3669840 KiB。

### 进程表（以下内容按列逐行解释）

- **PID**：进程的ID。
- **USER**：启动进程的用户。
- **PR**：进程的优先级（数值越低优先级越高）。
- **NI**：进程的`nice`值（负数表示优先级高，正数表示优先级低）。
- **VIRT**：进程使用的虚拟内存总量（包括代码、数据、共享库等）。一般这个值不用太过关注。
- **RES**：进程使用的物理内存量（驻留内存）。`RES`减去`SHR`就是进程实际占用的物理内存。
- **SHR**：进程使用的共享内存量，通常用于进程间共享的库和其他共享资源。
- **S**：进程状态（`S`表示睡眠，`R`表示运行，`Z`表示僵尸等）。
- **%CPU**：进程使用的CPU百分比。
- **%MEM**：进程使用的物理内存占总内存的百分比。
- **TIME+**：进程自启动以来消耗的CPU时间。
- **COMMAND**：启动进程的命令名称。

例如：

- **1741 root**：PID为1741的进程由`root`用户启动，优先级为10，`nice`值为-10，虚拟内存使用量为60140 KiB，物理内存使用量为21156 KiB，进程状态为`S`（睡眠），使用了1.0%的CPU时间，使用了0.5%的物理内存，总共消耗了1.56秒的CPU时间，进程名称是`AliYunDun`。

通过这些信息，你可以详细了解系统的资源使用情况及每个进程的运行状态。



# 15 