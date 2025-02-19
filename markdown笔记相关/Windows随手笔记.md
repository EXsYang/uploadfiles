# 1 在 Windows 系统中，如果你想关闭特定的进程，如 ID 为 20104 的 `GCUseTest` 进程，你可以使用命令行工具来实现。





![image-20240703120534110](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240703120534110.png)



在 Windows 系统中，如果你想关闭特定的进程，如 ID 为 20104 的 `GCUseTest` 进程，你可以使用命令行工具来实现。下面是具体步骤：

### 使用命令提示符

1. **打开命令提示符**：

   - 可以通过在搜索栏输入 `cmd` 或 `命令提示符` 并点击结果打开它。

2. **使用 `taskkill` 命令**：

   - 在命令提示符中输入以下命令来终止进程：

   ```bash
   taskkill /PID 20104 /F
   ```

   - 这里 `/PID` 表示指定进程ID，`/F` 表示强制终止进程。



在`taskkill`命令中，`/IM`参数代表"Image Name"，用于指定进程的名称（通常是可执行文件的名称，例如`notepad.exe`）。

完整的使用说明如下：

- `/IM <Image Name>`: 按进程的名称来杀死进程。

例如：
```shell
taskkill /IM notepad.exe
```
这个命令将杀死所有名称为`notepad.exe`的进程。

为了方便，以下是几个常见的`taskkill`命令示例：

1. 按进程ID杀死进程：
   ```shell
   taskkill /PID 1234
   ```

2. 按进程名称杀死进程：
   ```shell
   taskkill /IM notepad.exe
   ```

3. 强制结束进程（即使进程没有响应）：
   ```shell
   taskkill /F /PID 1234
   ```

4. 强制按名称结束进程：
   ```shell
   taskkill /F /IM notepad.exe
   ```

这样你可以更灵活地控制和管理Windows系统中的进程。

### 使用 PowerShell

1. **打开 PowerShell**：

   - 可以在开始菜单搜索 `PowerShell`，然后选择“以管理员身份运行”。

2. **执行停止进程命令**：

   - 在 PowerShell 中输入以下命令：

   ```powershell
   Stop-Process -Id 20104 -Force
   ```

   - `-Id` 指定进程 ID，`-Force` 用于强制停止进程。

### 检查进程是否已关闭

完成上述任一操作后，你可以再次使用 `jps` 命令或通过任务管理器检查进程是否已经被成功终止。在命令提示符中输入 `jps` 可以查看当前运行的 Java 进程列表，确认 `20104` 是否还在列表中。

这些方法可以帮助你管理和终止在 Windows 系统上运行的进程。如果你不确定某个进程的功能或它属于哪个应用，最好在终止前做一些调查，避免关闭关键系统进程可能导致的问题。



# 2 磁盘是如何保存数据的？机械硬盘和固态硬盘

磁盘是计算机中用于存储数据的一种硬件设备，包括机械硬盘（HDD）和固态硬盘（SSD）两种主要类型。它们的数据存储方式各有特点：

### 机械硬盘（HDD）

机械硬盘利用旋转的磁盘和磁头来读写数据。其工作原理如下：

1. **磁盘结构**：HDD 由一个或多个扁平的圆形盘片组成，这些盘片被称为磁盘或磁质盘片，表面涂有磁性材料。
2. **读写操作**：盘片在高速旋转时，磁头悬浮在盘片表面上的微小距离处。当数据被写入硬盘时，磁头会改变盘片表面的磁性方向来表示数据位（0或1）。
3. **数据访问**：当读取数据时，磁头检测通过其下方旋转的盘片上的磁性状态的变化来解读数据。
4. **旋转速度**：磁盘的旋转速度（通常称为转速），常见的转速有5400 RPM（每分钟转数）和7200 RPM等，这直接影响了硬盘的读写速度。

### 固态硬盘（SSD）

固态硬盘不包含移动部件，而是使用闪存技术（通常是 NAND 闪存）存储数据。其工作原理如下：

1. **存储单元**：SSD 使用一种称为闪存的非易失性内存芯片来存储数据，数据即使在断电后也依然保存。
2. **读写机制**：数据以电子方式快速写入和读取，存储在闪存单元中，这些单元可以快速访问，从而大大提高读写速度。
3. **耐用性和速度**：由于没有机械部件，SSD 的响应时间和耐用性远优于 HDD。它们能够承受更多的振动和冲击，且发热量和噪音较低。
4. **数据组织**：数据通常以块的形式存储在 NAND 闪存中，且数据的读写对整个块的影响较大（即写入新数据前通常需要先擦除整个块）。

### 比较

- **速度**：SSD 通常提供比 HDD 更高的数据传输速度和更低的访问延迟。
- **成本**：HDD 在成本上通常比 SSD 更具优势，尤其是在高容量存储需求上。
- **耐用性**：SSD 没有机械部件，因此更抗震动和跌落。
- **容量**：虽然 SSD 的最大容量正在增长，但是高容量的 HDD 在市场上仍然比较普遍且价格更加经济。

因此，选择 HDD 或 SSD 通常取决于具体应用的性能需求、存储容量和预算。



# 3 传统硬盘/机械硬盘是直接覆盖数据？SSD不可以直接覆盖吗？需要先清空再写入？ 

是的，固态硬盘（SSD）和机械硬盘（HDD）在数据写入和擦除方面的机制存在显著差异，这些差异主要源于它们的物理构造和工作原理。

### 机械硬盘的数据写入：

机械硬盘使用磁头在磁盘表面读写数据。数据直接写入到磁盘的指定位置，这个过程可以通过磁头改变磁盘表面某个区域的磁性状态来完成。如果需要更新已存储的信息，机械硬盘可以直接覆盖旧数据，不需要任何预先擦除步骤。这是因为磁头能够直接改变任何特定区域的磁性方向，从而更新存储在那里的数据。

### 固态硬盘的数据写入和擦除：

固态硬盘使用 NAND 闪存存储数据，这种存储介质的物理属性决定了其写入和擦除行为：

1. **写入限制**：NAND 闪存的一个单元（通常包含多个页，每页可以存储一定量的数据）在写入新数据前必须处于“擦除”状态。这是因为写入操作实际上是在置位（设置1或0）这些存储单元的过程，而这些单元一旦被置位，就不能简单地反转它们的状态来表示新数据。

2. **擦除操作**：在闪存中，擦除是按块进行的（一个块包含多个页）。整个块中的所有单元都必须被擦除，即设置为一个基线状态（通常是二进制的“1”），然后才能进行新的写入。这意味着，即使只改变一个字节，整个块的数据通常也需要被读出、修改后在内存中保存，然后整块擦除后重新写入。

### 为什么 SSD 不能直接覆盖数据？

由于 NAND 闪存单元在写入数据之前必须先擦除，SSD 不能像机械硬盘那样直接覆盖旧数据。如果尝试直接覆盖，那么写入操作将失败，因为已置位的单元无法简单地重写。因此，SSD 控制器管理一个复杂的映射系统和磨损均衡算法，以最大化每个块的使用寿命并保持高性能。

这种基于块的擦除和写入策略，加上对磨损均衡的需求，是 SSD 在提供更高速度和可靠性的同时，也需要复杂控制逻辑的原因之一。



# 4 光盘属于是？机器硬盘？它写入数据的机制和机械硬盘类似吗？否

光盘，包括 CD、DVD 和蓝光光盘等，是一种光学存储媒体，与机械硬盘（HDD）和固态硬盘（SSD）有本质的不同。光盘使用激光技术来读取和写入数据，与机械硬盘利用磁头读写磁盘上磁性材料的机制相比，其工作原理有很大差异。

### 光盘的工作原理：

1. **数据存储**：
   - 数据在光盘上是通过在盘面上形成微小的凹坑（pits）和平坦区域（lands）来存储的。这些凹坑和平坦区域的排列模式编码了存储的信息。

2. **写入数据（可记录和可重写光盘）**：
   - **可记录光盘（如 CD-R 或 DVD-R）**：使用激光将数据永久烧录到有色染料层上，激光的热效应改变染料层的反射特性，从而形成可读的凹坑模式。
   - **可重写光盘（如 CD-RW 或 DVD-RW）**：使用特殊的合金层代替染料层，该合金层可以在不同的温度下改变其晶体结构（从有序结构变为无序结构，或反之），因此可以通过激光加热来多次擦除和重写数据。

3. **读取数据**：
   - 读取数据时，光盘驱动器中的低功率激光照射到盘面上，光线反射回传感器。凹坑和平坦区域的反射光差异被用来解码存储的数据。

### 与机械硬盘的比较：

- **存储机制**：机械硬盘通过改变盘片表面的磁性来存储数据，而光盘是通过物理形式（凹坑和平坦区域）来存储光学反射差异的数据。
- **写入和擦除**：机械硬盘可以在不需先前擦除的情况下覆盖数据，而可重写光盘在写入新数据前通常需要先擦除旧数据，尽管这是通过物理加热而非磁性变化来完成的。
- **移动部件**：机械硬盘有旋转的磁盘和移动的读写头，而光盘驱动器虽然有旋转的盘片和移动的激光读取装置，但它们的工作原理基于光学而非磁学。

总体来说，光盘是一种非常不同的存储技术，它使用光学而非磁学或电子方式来存储和访问数据，适用于数据的长期存储和分发，如音乐、视频和软件安装介质。



# 5 从文件资源管理器右键属性进入系统面板



### 从文件资源管理器`此电脑`-空白处右键选择属性进入系统面板

![image-20240705225029516](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240705225029516.png)



![](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240705225029516.png)



# 6 常用的windows系统变量有哪些？

在Windows系统中，有许多常用的环境变量，这些变量可以帮助你快速访问系统的不同部分。这里列举一些常见的Windows环境变量：

1. **%APPDATA%** - 指向当前用户的应用数据文件夹，通常是 `C:\Users\<用户名>\AppData\Roaming`。

2. **%LOCALAPPDATA%** - 指向本地（非漫游）应用数据文件夹，通常是 `C:\Users\<用户名>\AppData\Local`。

3. **%PROGRAMFILES%** - 指向程序文件夹，通常是 `C:\Program Files`，在64位系统中用于存放64位程序。

4. **%PROGRAMFILES(x86)%** - 在64位系统中，这个变量指向32位程序的安装位置，通常是 `C:\Program Files (x86)`。

5. **%USERPROFILE%** - 指向当前用户的主目录，通常是 `C:\Users\<用户名>`。

6. **%HOMEPATH%** - 你提到的这个变量，它返回当前用户的主目录相对于驱动器的路径，例如 `\Users\<用户名>`。

7. **%TEMP%** 和 **%TMP%** - 指向当前用户的临时文件目录。

8. **%SYSTEMROOT%** 或 **%windir%** - 指向Windows的安装目录，通常是 `C:\Windows`。

9. **%PATH%** - 系统搜索可执行文件的路径列表。

10. **%COMSPEC%** - 指向命令解释器可执行文件（通常是cmd.exe）的路径。

这些环境变量可以在命令提示符、PowerShell或者文件资源管理器的地址栏中使用，非常方便快捷地访问系统的各个部分。



## 如何使用？例如：idea快捷定位存放插件的目录

在Windows系统中，你可以使用以下的系统环境变量来快速访问IntelliJ IDEA的插件目录。打开文件资源管理器，然后在地址栏输入以下内容：

```
%APPDATA%\JetBrains\IntelliJ IDEA<版本号>\plugins
```

请替换`<版本号>`部分为你的具体IDEA版本，例如如果你使用的是2024.1版本，那么地址将是：

```
%APPDATA%\JetBrains\IntelliJ IDEA 2024.1\plugins
```

这样，你就可以直接访问到当前用户的IDEA插件目录了。如果你想访问所有用户的插件目录，那么你需要去程序的安装路径查找，通常这个不通过环境变量访问。





# 7 cmd命令行技巧

## 7.1 `cls` 清屏指令



# 8 在 Windows 的 MINGW64 环境下，需要使用 Windows 特定的命令来查找和杀死进程。

![image-20240731100817994](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240731100817994.png)

看起来你在尝试使用 `ps` 命令来查找使用端口的进程时遇到了问题。在 Windows 的 MINGW64 环境下，可能需要使用 Windows 特定的命令来查找和杀死进程。

你可以使用以下 Windows 特定的命令来查找和停止占用端口的进程：

### 查找占用端口的进程

1. 使用 `netstat` 命令来查找占用特定端口的进程ID（PID）：
   ```shell
   netstat -ano | findstr :3658
   ```
   这将显示占用端口3658的进程的PID。

### 杀死占用端口的进程

2. 使用 `taskkill` 命令来杀死进程：
   ```shell
   taskkill /PID <PID> /F
   ```
   将 `<PID>` 替换为从 `netstat` 命令中获取的进程ID。

### 完整操作步骤示例

1. 查找占用端口3658的进程：
   ```shell
   netstat -ano | findstr :3658
   ```
   输出示例：
   ```
   TCP    0.0.0.0:3658           0.0.0.0:0              LISTENING       7952
   ```

2. 杀死占用端口的进程：
   ```shell
   taskkill /PID 7952 /F
   ```



![image-20240731101624991](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240731101624991.png)

通过这些步骤，你可以查找到并终止占用端口的进程，从而解决端口冲突问题。



### win11重置网络

~~~
netsh winsock reset
~~~



![image-20250209081729631](https://tgimgbed.999190.xyz/file/1739060261235_image-20250209081729631.png)



# 9 Windows 的 MINGW64 环境和 Linux 环境的不同之处



#### MINGW64 环境简介

Minimalist  /ˈmɪnɪməlɪst/ 极简主义者. 极简抽象艺术的，极简抽象风格的；最低必须限度的

MINGW64 (Minimalist GNU for Windows) 是一个软件开发环境，旨在提供一套轻量级的GNU工具集，用于在Windows平台上编译和运行程序。它与MSYS2（一个包含了MINGW64工具链的独立项目）一起使用，提供类似于Linux的命令行体验。Git for Windows通常包含Git Bash，这是一个基于MINGW64的命令行界面，提供了一些基本的Linux命令。

#### 主要区别

1. **底层操作系统**
   - **Linux**：基于Linux内核，是一个完整的操作系统，拥有自己的文件系统、进程管理、网络堆栈等。
   - **MINGW64**：运行在Windows操作系统上，只是一个模拟Linux环境的工具集，依赖于Windows的内核和系统服务。

2. **命令兼容性**
   - **Linux**：几乎所有的Linux命令行工具都可以使用，包括系统级命令和服务管理工具。
   - **MINGW64**：提供了一部分GNU工具的移植版本，并不包含所有的Linux命令，一些复杂的命令可能无法正常工作或行为不同。

3. **文件系统**
   - **Linux**：使用如ext4、btrfs等文件系统，有自己的一套目录结构（如 `/etc`, `/usr`, `/var` 等）。
   - **MINGW64**：运行在Windows的NTFS文件系统上，目录结构也与Windows兼容（如 `C:\Program Files`, `C:\Windows` 等）。

4. **进程管理**
   - **Linux**：使用 `ps`, `top`, `kill` 等命令管理进程，可以直接与Linux内核进行交互。
   - **MINGW64**：虽然提供了 `ps` 等类似命令，但这些命令是经过适配的，实际上仍然依赖于Windows的进程管理机制（如 `tasklist`, `taskkill`）。

5. **包管理**
   - **Linux**：使用包管理器（如 `apt`, `yum`, `pacman` 等）来安装和管理软件包。
   - **MINGW64**：使用MSYS2提供的 `pacman` 来安装和管理基于MINGW的包，但这些包是为Windows环境定制的。

6. **系统服务**
   - **Linux**：可以管理和配置系统服务（如 `systemd`, `init.d` 等）。
   - **MINGW64**：无法直接管理Windows的系统服务，需要使用Windows的服务管理工具（如 `sc`, `services.msc`）。

### 实际应用中的例子

#### 查找并终止进程

- **在Linux中**：
  ```bash
  ps -aux | grep <process_name>
  kill -9 <PID>
  ```

- **在MINGW64中**：
  ```bash
  netstat -ano | grep :<port>
  taskkill //PID <PID> //F
  ```

#### 包管理

- **在Linux中**：
  ```bash
  sudo apt update
  sudo apt install <package_name>
  ```

- **在MINGW64中**：
  ```bash
  pacman -Sy
  pacman -S <package_name>
  ```

### 总结
虽然MINGW64为Windows用户提供了一个类似于Linux的命令行环境，但它并不能完全替代Linux。许多系统级操作仍然需要使用Windows特定的命令和工具。了解这些差异可以帮助你在需要使用系统命令时选择正确的方法和工具。



# 10 Windows PowerShell 中文乱码问题

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
   # 设置控制台输出编码为 UTF-8
   [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
   
   # 设置控制台输入编码为 UTF-8
   $OutputEncoding = [System.Text.Encoding]::UTF8
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



# 11 如何在windows下，将bat文件设置定时运行？

在 Windows 下，你可以使用任务计划程序（Task Scheduler）来设置定时运行 .bat 文件。以下是详细步骤：

### 步骤

打开任务计划程序：

按下 Win + R 键，输入 taskschd.msc，然后按下回车键，打开任务计划程序。

\2. 创建基本任务：

在任务计划程序窗口中，点击右侧的“创建基本任务”。

输入任务的名称和描述，然后点击“下一步”。

设置触发器：

选择任务的触发时间，比如每天、每周、每月等，然后点击“下一步”。

根据选择的触发器，设置具体的时间和日期，然后点击“下一步”。

设置操作：

选择“启动程序”，然后点击“下一步”。

在“程序/脚本”框中，点击“浏览”按钮，选择你要运行的 .bat 文件。

完成任务：

检查所有设置是否正确，然后点击“完成”。

### 代码示例

假设你有一个简单的 .bat 文件，内容如下：

@echo off

echo Hello, World!

pause

### 任务计划程序的好处

自动化：可以自动在指定时间运行任务，无需手动干预。

灵活性：可以设置多种触发条件，如系统启动、用户登录等。

可靠性：任务计划程序是 Windows 系统自带的工具，稳定可靠。

 

# 12 cmd命令行查看网络设置



命令一：**ipconfig /all**   	查看主机[网卡配置](https://so.csdn.net/so/search?q=网卡配置&spm=1001.2101.3001.7020)详细信息。

命令二：route

命令三：arp

命令四：**netstat**

命令五：tracert

命令六：nslookup

命令七：**ping**



~~~sh

用法:
    ipconfig [/allcompartments] [/? | /all |
                                 /renew [adapter] | /release [adapter] |
                                 /renew6 [adapter] | /release6 [adapter] |
                                 /flushdns | /displaydns | /registerdns |
                                 /showclassid adapter |
                                 /setclassid adapter [classid] |
                                 /showclassid6 adapter |
                                 /setclassid6 adapter [classid] ]

其中
    adapter             连接名称
                       (允许使用通配符 * 和 ?，参见示例)

    选项:
       /?               显示此帮助消息
       /all             显示完整配置信息。
       /release         释放指定适配器的 IPv4 地址。
       /release6        释放指定适配器的 IPv6 地址。
       /renew           更新指定适配器的 IPv4 地址。
       /renew6          更新指定适配器的 IPv6 地址。
       /flushdns        清除 DNS 解析程序缓存。
       /registerdns     刷新所有 DHCP 租用并重新注册 DNS 名称
       /displaydns      显示 DNS 解析程序缓存的内容。
       /showclassid     显示适配器允许的所有 DHCP 类 ID。
       /setclassid      修改 DHCP 类 ID。
       /showclassid6    显示适配器允许的所有 IPv6 DHCP 类 ID。
       /setclassid6     修改 IPv6 DHCP 类 ID。


默认情况下，仅显示绑定到 TCP/IP 的每个适配器的 IP 地址、子网掩码和
默认网关。

对于 Release 和 Renew，如果未指定适配器名称，则会释放或更新所有绑定
到 TCP/IP 的适配器的 IP 地址租用。

对于 Setclassid 和 Setclassid6，如果未指定 ClassId，则会删除 ClassId。

示例:
    > ipconfig                       ... 显示信息
    > ipconfig /all                  ... 显示详细信息
    > ipconfig /renew                ... 更新所有适配器
    > ipconfig /renew EL*            ... 更新所有名称以 EL 开头
                                         的连接
    > ipconfig /release *Con*        ... 释放所有匹配的连接，
                                         例如“有线以太网连接 1”或
                                             “有线以太网连接 2”
    > ipconfig /allcompartments      ... 显示有关所有隔离舱的
                                         信息
    > ipconfig /allcompartments /all ... 显示有关所有隔离舱的
                                         详细信息
#可以直接连起来使用，不用空格（但可读性不好）
C:\Users\xxx>ipconfig/all
#用空格（可读性好）
C:\Users\xxx>ipconfig /all
~~~





# 13 windows修改定时任务步骤(github自动每天推送脚本)



调查运行窗口输入：

~~~
taskschd.msc
~~~

![image-20241210203539288](https://tgimgbed.999190.xyz/file/1733834161157_image-20241210203539288.png)



![image-20241210203914102](https://tgimgbed.999190.xyz/file/1733834374965_image-20241210203914102.png)

![image-20241210203934370](https://tgimgbed.999190.xyz/file/1733834400495_image-20241210203934370.png)



附脚本：

~~~bash
@echo off
setlocal enabledelayedexpansion
chcp 65001

:: 设置Git环境变量
set "GIT_PATH=D:\Java_developer_tools\Git\Git"
set "PATH=%PATH%;%GIT_PATH%\cmd;%GIT_PATH%\bin;%GIT_PATH%\mingw64\bin"

:: 设置日志文件路径和计数器文件路径
set "LOG_FILE=%~dp0git_auto_commit_log.txt"
set "COUNTER_FILE=%~dp0log_counter.txt"

:: 初始化或读取计数器
if not exist "!COUNTER_FILE!" (
    echo 0 > "!COUNTER_FILE!"
)
set /p COUNTER=<"!COUNTER_FILE!"
set /a COUNTER+=1

:: 如果计数达到180次，重置日志文件
if !COUNTER! GEQ 180 (
    echo 日志计数达到180次，重置日志文件...
    set COUNTER=1
    if exist "!LOG_FILE!" (
        :: 创建备份文件（可选）
        copy "!LOG_FILE!" "!LOG_FILE!.bak" >nul
        del "!LOG_FILE!"
    )
)

:: 保存新的计数
echo !COUNTER! > "!COUNTER_FILE!"

:: 初始化或追加到日志文件
if !COUNTER! EQU 1 (
    echo 新日志周期开始 - %date% %time% > "!LOG_FILE!"
) else (
    echo. >> "!LOG_FILE!"
    echo 第 !COUNTER! 次提交 - %date% %time% >> "!LOG_FILE!"
)
echo -------------------------------- >> "!LOG_FILE!"

:: 验证Git是否可用
where git >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo Git命令不可用，正在检查环境... >> "!LOG_FILE!"
    if exist "%GIT_PATH%\cmd\git.exe" (
        echo 找到Git执行文件，正在设置环境变量... >> "!LOG_FILE!"
        set "PATH=%PATH%;%GIT_PATH%\cmd;%GIT_PATH%\bin;%GIT_PATH%\mingw64\bin"
    ) else (
        echo 错误：未找到Git执行文件，请检查安装路径：%GIT_PATH% >> "!LOG_FILE!"
        pause
        exit /b 1
    )
)

:: 定义需要检查的Git仓库目录
set REPOSITORIES="D:\Java_developer_tools\uploadfiles" "D:\Java_developer_tools\mycode"

:: 遍历每个Git仓库目录
for %%d in (%REPOSITORIES%) do (
    echo 正在检查Git仓库: %%d
    echo 正在检查Git仓库: %%d >> "!LOG_FILE!"
    
    if not exist "%%d" (
        echo 警告：目录 %%d 不存在 >> "!LOG_FILE!"
        echo 警告：目录 %%d 不存在
        continue
    )

    pushd %%d
    
    :: 检查是否是Git仓库
    if not exist ".git" (
        echo 警告：%%d 不是Git仓库 >> "!LOG_FILE!"
        echo 警告：%%d 不是Git仓库
        popd
        continue
    )

    :: 检查是否有文件变动
    git status --porcelain > temp_status.txt 2>nul
    if %ERRORLEVEL% NEQ 0 (
        echo Git命令执行失败，请检查权限或Git配置 >> "!LOG_FILE!"
        echo Git命令执行失败，请检查权限或Git配置
        del temp_status.txt 2>nul
        popd
        continue
    )

    findstr /r /c:"^ M" /c:"^??" temp_status.txt > nul
    if !ERRORLEVEL! EQU 1 (
        echo No changes in "%%d", no commit needed. >> "!LOG_FILE!"
        echo No changes in "%%d", no commit needed.
    ) else (
        echo 检测到变更，正在提交... >> "!LOG_FILE!"
        echo 检测到变更，正在提交...
        
        git add . >> "!LOG_FILE!" 2>&1
        git commit -m "自动提交 #!COUNTER!: %date% %time%" >> "!LOG_FILE!" 2>&1
        git push >> "!LOG_FILE!" 2>&1
        
        if !ERRORLEVEL! EQU 0 (
            echo 成功推送更改 >> "!LOG_FILE!"
            echo 成功推送更改
        ) else (
            echo 推送失败，请检查网络或远程仓库配置 >> "!LOG_FILE!"
            echo 推送失败，请检查网络或远程仓库配置
        )
    )
    
    :: 删除临时状态文件
    del temp_status.txt 2>nul
    popd
)

echo 所有仓库处理完成。（第 !COUNTER! 次运行） >> "!LOG_FILE!"
echo 所有仓库处理完成。（第 !COUNTER! 次运行）
echo 详细日志请查看: !LOG_FILE!
pause
~~~



# 14 Windows系统本身就自带了很多提效的小工具

### 高效操作,用好这些自带神器 ![:wrench:](https://tgimgbed.999190.xyz/file/1735341080265_wrench.png)

其实Windows系统本身就自带了很多提效的小工具,善加利用能让你的操作更高效。

- 快捷键"Win + ."快速打开emoji表情面板
- "Win + V"打开方便好用的云剪贴板
- "Win + Shift + S"随时随地截图,支持矩形、任意形状、窗口截图
- "Win + G"打开Xbox游戏栏,轻松录制屏幕
- "Win + Tab"进入时间线视图,管理多个虚拟桌面
- "Win + 数字键"快速打开或切换任务栏固定的程序







# 15 装机必备,这些软件值得一试 ![:gem:](https://tgimgbed.999190.xyz/file/1735341134070_gem.png)

除了系统自带工具,这些第三方软件也是装机必备,推荐你尝试:

- 压缩/解压: Bandizip、7-Zip
- 看图: 2345看图王、Honeyview
- 播放器: PotPlayer、VLC
- 下载器: IDM、FDM
- 输入法: 搜狗拼音、微软必应输入法
- 浏览器: Chrome、新版Edge
- 安全防护: 火绒、Windows Defender
- 清理优化: Dism++、CCleaner
- 磁盘分析工具: SpaceSniffer

它们都是同类软件中的佼佼者,而且大多免费好用,满足你日常使用的各种需求。还有很多像Listary、Ditto、Snipaste这样的效率软件,大家可以根据需求尝试。总之用好工具,事半功倍。

选择靠谱的云存储服务,如OneDrive





# 16 关闭WPS打开图片的方法



用WPS自带的配置工具取消勾选打开图片的复选框就可以了，不用担心死灰复燃

直接搜在win搜索栏中搜配置工具

![image-20241229014748904](https://tgimgbed.999190.xyz/file/1735408079319_image-20241229014748904.png)



进入高级选项

![image-20241229015207770](https://tgimgbed.999190.xyz/file/1735408333860_image-20241229015207770.png)



取消勾选图片文件

![image-20241229015145991](https://tgimgbed.999190.xyz/file/1735408313448_image-20241229015145991.png)





# 17 [查找您的 Windows 10 、11 激活密钥，以及（OEM 数字许可证密钥）](https://www.freedidi.com/13758.html)



1、CMD命令终端下以管理员身份输入命令：

~~~
wmic path softwareLicensingService get OA3xOriginalProductKey
~~~



如果你通过上方的命令运行后没有看到密钥，那是因为你用的是OEM数字许可证密钥，这种情况请使用下面的第2种方法来获取密钥。

2、注册表下：计算机\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform

找到 BackupProductKeyDefault，在其后面就能找到你的激活密钥

 

![image-20241229020713452](https://tgimgbed.999190.xyz/file/1735409242718_image-20241229020713452.png)



 

3、Windows 10 /11 KMS激活方式

**注意：以管理员身份运行CMD，然后依次输入下面的命令即可**、

~~~
slmgr /ipk 这里填写你的OEM密钥

slmgr /skms kms.loli.best

slmgr /ato

slmgr /xpr
~~~



  

OEM激活密钥可以去微软官方免费获取 【**[点击前往](https://learn.microsoft.com/zh-cn/windows-server/get-started/kms-client-activation-keys?tabs=server2022%2Cwindows10ltsc%2Cversion1803%2Cwindows81)**】



# 18 下载Chrome

https://www.google.com/chrome/index.html





# 19 Win10 激活

首先访问激活教程网站： https://massgrave.dev/



~~~
irm https://get.activated.win | iex
~~~



![image-20241229065659239](https://tgimgbed.999190.xyz/file/1735427226006_1735426623124_image-20241229065659239.png)



![image-20241229065641635](https://tgimgbed.999190.xyz/file/1735427227416_1735426612743_image-20241229065641635.png)

~~~
Checking OS Info                        [Windows 10 专业版 | 19045.3803 | AMD64]
Checking Internet Connection            [Connected]
Initiating Diagnostic Tests...
Checking WPA Registry Count             [24]

Installing Generic Product Key          [VK7JG-NPHTM-C97JM-9MPGT-3V66T] [Successful]
Changing Windows Region To USA          [Successful]
Generating GenuineTicket.xml            [Successful]
Done.
Converted license Microsoft.Windows.48.X19-98841_8wekyb3d8bbwe and stored at C:\ProgramData\Microsoft\Windows\ClipSvc\Install\Migration\ade72f16-a55a-496f-a964-4f3f37e925c0.xml.
Successfully converted 1 licenses from genuine authorization tickets on disk.
Done.

Activating...

Windows 10 专业版 is permanently activated with a digital license.

Restoring Windows Region                [Successful]

Press any key to Go back...


~~~



![image-20241229070127723](https://tgimgbed.999190.xyz/file/1735427233957_1735426893807_image-20241229070127723.png)

~~~
slmgr.vbs -xpr
~~~





![image-20241229070101212](https://tgimgbed.999190.xyz/file/1735427228374_1735426867350_image-20241229070101212.png)





# 20 进入开机自动启动文件夹有几种方法



进入开机自动启动文件夹有几种方法，具体取决于你想访问的是当前用户的启动文件夹还是所有用户的启动文件夹。

**方法一：使用运行命令 (推荐且通用)**

这是最快捷且通用的方法，适用于所有较新的 Windows 版本（包括 Windows 10 和 Windows 11）。

1. 

2. **按下 Win + R 键** 打开“运行”对话框。

3. **输入以下命令之一，然后按 Enter 键或点击“确定”：**

   - 
   - **当前用户启动文件夹：**  shell:startup
   - **所有用户启动文件夹：** shell:common startup

   **解释:**

   - 
   - shell:startup 会打开当前登录用户的启动文件夹。只有当前用户登录时，里面的程序才会启动。
   - shell:common startup 会打开所有用户的启动文件夹。无论哪个用户登录，里面的程序都会启动。

**方法二：使用文件资源管理器地址栏 (适用于所有 Windows 版本)**

1. 

2. **打开文件资源管理器** (可以通过点击任务栏上的文件夹图标或按下 Win + E 键)。

3. **在地址栏中输入以下路径之一，然后按 Enter 键：**

   - 
   - **当前用户启动文件夹：**
     %APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup
   - **所有用户启动文件夹：**
     %ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup

   **解释:**

   - 
   - %APPDATA% 是一个环境变量，代表当前用户的应用程序数据文件夹的路径。
   - %ProgramData% 是一个环境变量，代表所有用户的应用程序数据文件夹的路径。

**方法三：通过开始菜单 (可能不适用于所有版本，且不太直接)**

1. 

2. **按下 Win 键** 打开开始菜单。

3. **找到你想要添加到启动项的程序的快捷方式。**

4. **右键点击该快捷方式。**

5. **选择“更多”或类似选项 (如果存在)。**

6. **选择“打开文件位置”。** 这会打开包含该程序快捷方式的文件夹，你可能需要向上导航到“启动”文件夹。

   **注意：** 并非所有程序的快捷方式都在开始菜单的根目录。你可能需要在“所有应用”列表中查找。这种方法主要用于将现有程序的快捷方式添加到启动文件夹，而不是直接打开启动文件夹。

**总结：**

- 
- **最推荐的方法是使用“运行”命令 (shell:startup 或 shell:common startup)，因为它简单快捷且通用。**
- 使用文件资源管理器地址栏也是一种可靠的方法，尤其当你需要直接输入路径时。
- 通过开始菜单的方法不太直接，更适合用于添加启动项。

**选择哪个文件夹取决于你的需求：**

- 
- **如果你只想让程序在你自己的账户登录时启动，使用当前用户的启动文件夹 (shell:startup 或 %APPDATA%...)。**
- **如果你想让程序在任何用户登录这台计算机时都启动，使用所有用户的启动文件夹 (shell:common startup 或 %ProgramData%...)。**

了解这两种启动文件夹的区别很重要，以避免不必要的程序在你不希望它们启动的时候运行。







# 21 win10如何优化开机速度，我同台电脑装了两个同版本的win10,一个开机90s,一个开机15s,如何优化？

你的情况很有意思，同一台电脑装了两个相同版本的Win10，开机速度差异如此之大，说明其中一个系统的配置或后台运行着大量不必要的程序和服务。 你可以尝试以下步骤来优化开机速度慢的那个Win10系统（90秒启动的）：

**1. 分析启动时间:**

- **使用任务管理器查看启动项影响:**
  - 
  - 按下 Ctrl + Shift + Esc 打开任务管理器。
  - 切换到 “启动” 选项卡。
  - 查看 “启动影响” 列，它可以帮助你了解哪些程序在启动时占用资源较多。
  - **禁用不需要的启动项：** 仔细检查列表，禁用那些你不需要在开机时自动启动的应用程序。例如，一些更新程序、不常用的软件等。  **注意：不要禁用你不知道是什么的程序，以免影响系统正常运行。**

**2. 管理启动服务:**

- **打开“服务”窗口:**
  - 
  - 按下 Win + R 键，输入 services.msc，然后按回车。
  - 在“服务”窗口中，你会看到系统中运行的各种服务。
-  系统配置-服务取消不必要服务勾选
  - 按下 Win + R 键，输入msconfig

![image-20241230062153431](https://tgimgbed.999190.xyz/file/1735510916868_image-20241230062153431.png)
