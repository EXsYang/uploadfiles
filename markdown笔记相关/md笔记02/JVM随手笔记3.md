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













