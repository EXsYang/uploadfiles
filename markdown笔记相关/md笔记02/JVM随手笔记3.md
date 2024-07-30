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





# 3 `java -cp xx.jar xx.xx.xx.XX` 启动命令

`java -jar xx.jar`命令启动的jar包启动类是已经确定好的(即约定好的)。

而 `java -cp xx.jar xx.xx.xx.XX` 启动命令，则是自己指定一个启动类！

指定xx.jar包中具体的某一个类来启动jar包程序。

如：`java -cp sa-jdi.jar sun.jvm.hotspot.`



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



# 4 虚方法表

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



# 5 