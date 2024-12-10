# 0 

分享一个只用一个邮箱无限bp Cursor 的方法，有钱的话还是直接支持吧。 原理很简单，就是 Cursor 注册的话就送 15 天的会员体验，换个邮箱继续 15 天。 不停换邮箱会比较麻烦，但 Gmail 支持无限别名。可以只用一个邮箱，无限bp。 重点来了，格式是你的邮箱账号+别名。例如我的邮箱是 mygmail@gmail.com，你可以用 mygmail+cursor1@gmail.com 和 mygmail+cursor2@gmail.com 来注册Cursor，以此类推。 Cursor 会把这些识别为不同的邮箱，但是这些邮箱都会发送邮件到 mygmail@gmail.com，从而实现不停白嫖。注意：其中的加号也是一部分。 希望大家切用且珍惜，有能力的直接充值 Cursor。

> ***原理是：使用邮箱别名！\*** *如Gmail中别名是可以在「 + 」号之后填写任意字符。如：user+001@gmail.com、user+002@gmail.com。*
>
> *另一种方式，使用「 . 」 号，如：u.s.e.r@gmail.com、 u.ser@gmail.com。 可以多个点号或者单个点号。都会发送到user@gmail.com主邮箱。*

可以看作同一个邮箱 给后二者别名邮箱发邮件 第一个主邮箱也可以收到 那么除了Gmail之外。**也就是user@gmail.com可以收到下面别名邮箱的邮件信息。** 从而做到了**无限别名**邮箱！





亲测可以使用[2925邮箱 846](https://www.2925.com/)进行多次别名注册cursor来白嫖cursor专业版的15天试用期，到期之后退出登录在重新注册就可以了。这个软件特色是虽然是写代码的助手，它可以正常聊天！话不多说，上图

# 1 Cursor setting - 提示词设置 Rules for AI

安装位置：

C:\Users\用户\AppData\Local\Programs\cursor\

~~~
Always respond in 中文.

You are an AI coding instructor designed to assist and guide me as I learn to code. Your primary goal is to help me learn programming concepts, best practices, and problem-solving skills while writing code. Always assume I'm a beginner with limited programming knowledge.

Follow these guidelines in all interactions:

1. Explain concepts thoroughly but in simple terms, avoiding jargon when possible.
2. When introducing new terms, provide clear definitions and examples.
3. Break down complex problems into smaller, manageable steps.
4. Encourage good coding practices and explain why they are important.
5. Use examples and analogies to illustrate programming concepts.
6. Be patient and supportive, understanding that learning to code can be challenging.
7. Praise correct implementations and gently correct mistakes.
8. When correcting errors, explain why the error occurred and how to fix it.
9. Suggest resources for further learning when appropriate.
10. Encourage questions and seek clarification.
11. Foster problem-solving skills by guiding me to find solutions rather than always providing direct answers.
12. Adapt your teaching style to my pace and learning preferences.
13. Provide code snippets to illustrate concepts, but always explain the code line by line.
14. Use Chinese comments in the code to help document what is happening.

Address the my questions thoroughly, keeping in mind the guidelines above. If the question is unclear or lacks context, ask me for clarification.

Review the code and provide feedback. If there are errors or areas for improvement, explain them clearly and suggest corrections. If the code is correct, offer praise and explain why it's a good implementation.

Structure your responses as follows:

Format your response as markdown
Answer my question
Code review and feedback
Suggestions for further learning or practice
Remember, your goal is not just to help me write correct code, but to help me understand the underlying principles and develop my programming skills. Always strive to be clear, patient, and encouraging in your responses.

~~~





# 2 中文乱码问题



# 2 Java编码问题解决方案笔记

## 一、问题现象



我在编码时使用了D:\Java_developer_tools\mycode\DataStructures\DataStructures\src\main\java\com\atguigu\sparsearray>javac -encoding UTF-8
 SparseArray.java
编码成功，没有报错，但是直接使用 javac  SparseArray.java却报错了，为什么？我这里都是在cmd窗口进行的



### 1. CMD编译报错

~~~bash
javac SparseArray.java
# 错误: 编码GBK的不可映射字符
~~~

让我解释一下这个现象：

### 原因解释：

当你使用 javac SparseArray.java 而不指定编码时：

javac 编译器会使用操作系统的默认编码（在中文 Windows 上是 GBK）

而你的源文件是用 UTF-8 编码保存的

所以当 javac 用 GBK 编码去读取 UTF-8 编码的文件时，就会出现不可映射字符的错误

### 具体分析：

~~~bash
# 这个命令成功，因为明确告诉编译器源文件是 UTF-8 编码
javac -encoding UTF-8 SparseArray.java

# 这个命令失败，因为编译器使用系统默认的 GBK 编码去读取 UTF-8 文件
javac SparseArray.java
~~~

### 建议：

始终使用 UTF-8 编码保存源文件

编译时明确指定编码参数

考虑使用构建工具（如 Maven）来管理项目，它会自动处理编码问题

在 IDE 中设置默认编码为 UTF-8

### 补充知识：

Java 源文件编码和运行时编码是两个不同的概念

编译时的编码（-encoding 参数）是告诉编译器如何读取源文件

运行时的编码（-Dfile.encoding 参数）是告诉 JVM 如何处理字符串



### 3. 类运行路径问题

~~~bash
java SparseArray.class
# 错误: 找不到或无法加载主类 SparseArray.class
~~~



## 二、解决方案

### 1. 编译时编码问题

~~~bash
# 正确的编译命令
javac -encoding UTF-8 SparseArray.java

# 设置环境变量
JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF-8

# 创建编译脚本（compile.bat）
@echo off
javac -encoding UTF-8 %*
~~~



---

### 2. PowerShell(Cursor)运行时中文乱码

~~~bash
ԭʼĶάİ~~ # 原始的二维数组显示乱码
~~~



这是因为Cursor的Terminal（PowerShell）和Windows的CMD使用了不同的默认编码设置。

### 原因解释：

Windows CMD (命令提示符) 默认使用GBK/GB2312编码

PowerShell（Cursor使用的终端）默认使用UTF-16LE编码

你的Java程序输出使用的是GBK编码



### 2. 运行时终端编码问题

解决方案：

#### 在PowerShell中设置编码（临时解决）：

~~~bash
# 临时解决
[Console]::OutputEncoding = [System.Text.Encoding]::GetEncoding("GBK")

# 永久解决（在PowerShell配置文件中添加）
notepad $PROFILE
[Console]::OutputEncoding = [System.Text.Encoding]::GetEncoding("GBK")
~~~



#### Java代码设置

~~~
// 在Java代码中设置输出编码
System.setOut(new PrintStream(System.out, true, "GBK"));
~~~



### 3. 类运行路径问题

~~~bash
# 方式1：在classes目录下运行
cd target/classes
java com.atguigu.sparsearray.SparseArray

# 方式2：指定classpath运行
java -cp target/classes com.atguigu.sparsearray.SparseArray
~~~

## 三、最佳实践建议

### 1. 项目编码规范

源文件统一使用UTF-8编码保存

IDE设置默认编码为UTF-8

使用Maven等构建工具管理项目

### 2. 编译运行规范

编译时始终指定编码参数

运行时注意包路径

正确设置classpath

### 3. 开发环境配置

统一使用UTF-8编码

考虑使用Windows Terminal

IDE中配置文件编码为UTF-8

## 四、相关知识点

### 1. 编码概念

源文件编码

编译时编码

运行时编码

### 2. Windows终端特点

**CMD：默认GBK编码**

**PowerShell：默认UTF-16LE编码**

### 3. Java编码参数

-encoding：编译时源文件编码

-Dfile.encoding：运行时字符编码

## 五、注意事项

不同终端可能需要不同的编码设置

\2. 编译和运行时的编码是两个独立的概念

项目中应保持编码的一致性

建议使用构建工具来自动化管理这些问题

## 六、常用命令速查

~~~bash
# 编译命令
javac -encoding UTF-8 SparseArray.java

# 运行命令
java -cp target/classes com.atguigu.sparsearray.SparseArray

# PowerShell编码设置
[Console]::OutputEncoding = [System.Text.Encoding]::GetEncoding("GBK")
~~~





# 3 [【2024-12-09】最新解决Cursor试用账号机器被封锁（附成品软件一键修改）](https://linux.do/t/topic/287438)

最近我也无缘无故出现了下面的提示

```md
Too many free trial accounts used on this machine. Please upgrade to pro. We have this limit in place to prevent abuse. Please let us know if you believe this is a mistake.
```

仔细研究了一下论坛开源脚本和大佬们的只言片语，用只学几天的go，写了一个小脚本，核心就是修改三个参数`macMachineId`、`machineId`、`devDeviceId`之后立马设置`只读`即可。

### 手动重置

1. 完全关闭Cursor

2. 找到storage.json文件：

   - Windows: `%APPDATA%\Cursor\User\globalStorage\storage.json`
   - MacOS: `~/Library/Application Support/Cursor/User/globalStorage/storage.json`
   - Linux: `~/.config/Cursor/User/globalStorage/storage.json`

3. 修改文件为可写（如果需要）：

   - Windows: 右键 → 属性 → 取消勾选"只读"
   - MacOS/Linux: `chmod 666 storage.json`

4. 编辑文件，替换以下字段为新的随机值：

   ```json
   {
     "telemetry.macMachineId": "生成64位十六进制",
     "telemetry.machineId": "生成64位十六进制",
     "telemetry.devDeviceId": "生成UUID格式"
   }
   ```

   - 十六进制值：使用64个字符(0-9, a-f)
   - UUID格式：类似 “xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx”

5. 将文件设为只读：

   - Windows: 右键 → 属性 → 勾选"只读"
   - MacOS/Linux: `chmod 444 storage.json`

6. 重启Cursor

### ![:warning:](https://tgimgbed.999190.xyz/file/1733737109725_warning.png) 注意事项

1. 使用本工具需要您自行承担风险
2. 建议在重要数据做好备份后使用
3. 本工具仅用于学习研究,请勿用于商业用途

开源如下：
[yuaotian/go-cursor-help: 解决Cursor在免费订阅期间出现以下提示的问题: Too many free trial accounts used on this machine. Please upgrade to pro. We have this limit in place to prevent abuse. Please let us know if you believe this is a mistake.](https://github.com/yuaotian/go-cursor-help)

------

![img](https://iconce.com/api/v1?type=text&w=600&h=35&value=Let's do it without Linux.| 👮‍♂️老实交代：你是来划水的🏊    还是来摸鱼的🐟&animate=true&fillType=Linear&primaryColor=%23DD1818&secondaryColor=%23380202&angle=45&radialGlare=false&radius=8&strokeSize=0&strokeColor=%23FFFFFF&strokeOpacity=100&color=%23FFFFFF&size=16&family=cursiveLet%27s%20do%20it%20without%20Linux.|%20👮%E2%80%8D♂%EF%B8%8F老实交代：你是来划水的🏊%20%20%20%20还是来摸鱼的🐟&PC=U316&FORM=CHROMN)





# 4 突破免费试用封锁



~~~sh
@echo off
setlocal EnableDelayedExpansion

:: 生成新的UUID和随机字符串
for /f %%i in ('powershell -Command "[guid]::NewGuid().ToString().ToLower()"') do set new_machine_id=%%i
for /f %%i in ('powershell -Command "[guid]::NewGuid().ToString().ToLower()"') do set new_dev_device_id=%%i
for /f %%i in ('powershell -Command "-join ((0..31)|%%{(48..57)+(97..102)|Get-Random|%%{[char]$_}})"') do set new_mac_machine_id=%%i

:: 设置Cursor配置文件路径
set "cursor_path=%APPDATA%\Cursor"
set "storage_path=%cursor_path%\User\globalStorage\storage.json"

:: 写入新的machine id
echo !new_machine_id! > "%cursor_path%\machineid"

:: 使用PowerShell更新storage.json文件
powershell -Command ^
    "$content = Get-Content '%storage_path%' -Raw; ^
     $content = $content -replace '""telemetry.devDeviceId"": "".*""', '""telemetry.devDeviceId"": ""%new_dev_device_id%""'; ^
     $content = $content -replace '""telemetry.macMachineId"": "".*""', '""telemetry.macMachineId"": ""%new_mac_machine_id%""'; ^
     $content | Set-Content '%storage_path%'"

echo "Cursor本地数据重置完成！"
~~~



