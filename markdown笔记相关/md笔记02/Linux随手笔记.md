# Linux命令学习

`cd` 是 "change directory" 的缩写，这是一个常用的命令行命令

`reboot`重启Linux



![image-20240115152508430](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240115152508430.png)

![image-20240115152514028](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240115152514028.png)

# Vim指令



## 小技巧：

### 1.ALT + R 可以让 Xshell7 变成半透明的

![image-20240115160941562](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240115160941562.png)



---



`clear` 清屏

**`		`**

## 1 vi 和 vim 快捷键

### 1.1 快捷键使用练习

`:wq`  在命令行模式下的写入并退出 即write + quit

1.  **拷贝**当前行**` yy`** , 拷贝当前行向下的 5 行 5yy，并粘贴（输入 p）, 在**一般模式**下,

2.  **删除**当前行 **`dd`** , 删除当前行向下的 5 行 5dd, 在**一般模式**下,



3. **剪切**

   ~~~
    在 `vim` 编辑器中，**剪切**操作通常使用 "删除" 命令来完成，因为在 `vim` 中删除文本时，文本会被放入剪贴板（寄存器），从而可以通过粘贴命令来恢复。以下是一些常用的 `vim` 剪切命令：
   
   1. **剪切光标所在的整行**:
      - 按 `dd` 剪切当前行。
   2. **剪切指定数量的行**（例如剪切3行）:
      - 输入 `3dd`（这里的3是行数，可以替换为任何数字）。
   3. **剪切光标所在位置到行尾的内容**:
      - 按 `d$` 或 `D`。
   4. **剪切光标所在位置到行首的内容**:
      - 按 `d^`。
   5. **剪切光标所在字符**:
      - 按 `x`。
   6. **剪切光标所在位置到指定字符之间的内容**（例如剪切到下一个字符'e'）:
      - 输入 `dte`（这里的'e'可以是任何字符，`t` 表示 "到……之前"）。
   
   剪切后的内容可以通过 `p` 命令粘贴到光标之后或通过 `P` 命令粘贴到光标之前。记住，在 `vim` 中，剪切实际上是一种 "删除" 操作，它会将删除的内容存储在剪贴板中，供之后粘贴使用。
   ~~~

4. 在文件中**查找**某个单词 [**命令行下** **/关键字** ， 回车 查找 , 输入 **`n`** 就是查找下一个 大写的 **`N`**查找**上一个**]

**命令行下**输入 **`:nohl`** 或**`:nohlsearch`**然后按回车。这会立即**取消当前的搜索**高亮，直到你进行下一次搜索。`nohlsearch` 是 `nohighlightsearch` 的缩写，意为“不高亮搜索”。

5. 设置文件的**行号**，取消文件的行号.[**命令行下** **`: set nu `**和**` :set nonu`** ]

6. 编辑 /etc/profile 文件，在**一般模式**下, 使用快捷键到该文档的最末行[G]和最首行[gg]

7. 在一个文件中输入 "hello" ,在**一般模式**下, 然后又**撤销**这个动作 **`u`**

要执行**反撤销**，即重新应用刚才撤销的操作，你可以使用以下两种方法之一：

- **Ctrl+R**：在在**一般模式**下，按下 `Ctrl` 键和 `R` 键可以反撤销最近的操作。

- **`:redo` 命令**：另一种方式是在命令模式下输入 `:redo` 命令，然后按回车。这个命令同样执行反撤销操作。

8. 编辑 /etc/profile 文件，在一般模式下, 并将光标移动到 , 输入 20,再输入 shift+g



## 2 关机 & 重启命令

### 2.2 基本介绍

1. `shutdown –h now`: 立即进行关机

2. `shutdown -h 1`  "hello, 1 分钟后会关机了": 1 分钟后关机，并显示消息

   单独写一个`shutdown`等价于`shutdown -h 1`

3. `shutdown –r now`: 现在重新启动计算机      这里的`-r`代表的就是reboot，即重启

4. `halt`:  立即关机，作用和上面一样。`shutdown –h now`

5. `reboot`: 现在重新启动计算机  等价于 `shutdown –r now`

6. `sync`: 把内存的数据同步到磁盘。

7. `init 0`:运行级别0，立即关机 

8. `init 6`:运行级别6，立即重启

###  注意细节

1. 不管是重启系统还是关闭系统，首先要运行 `sync` 命令，把内存中的数据写到磁盘中。
2. 目前的 `shutdown`/`reboot`/`halt` 等命令在关机前均已经执行了 `sync`。

> **老韩提醒**: 小心驶得万年船。



## 3 用户登录和注销&切换用户

### 3.1 帐号登录基本介绍

1. **避免使用 root 帐号登录**：
   
   - 登录时尽量少用 root 帐号登录，因为它是系统管理员，拥有最大的权限，避免操作失误。建议使用普通用户登录，然后通过 `su - 用户名` 命令切换到系统管理员身份。注意杠`-`后面有一个空格
   - 只有使用`su - 用户名`切换用户登录后，`logout`指令才有效
   - 直接使用`su`,默认切换为root用户，但是此时`logout`指令无效
   
   ~~~
   [tom@hspEdu01 ~]$ su - root #注意空格
   密码：
   上一次登录：一 1月 15 18:31:57 CST 2024pts/0 上
   [root@hspEdu01 ~]# cd /root
   [root@hspEdu01 ~]# logout
   [tom@hspEdu01 ~]$ logout
   
   Connection closed.
   ~~~
   
   
   
   tom用户登录后默认是在 **/home/tom** 文件夹
   
   - **`pwd`**	查看当前是在哪个目录
   
   
   
   ![image-20240115210411150](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240115210411150.png)



![image-20240115215347091](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240115215347091.png)



## 



## 3.2 注销用户

- 在提示符下输入 `logout` 即可注销用户。



**为什么只有使用`su - 用户名`切换用户登录后，`logout`指令才有效，直接使用`su`,默认切换为root用户，但是此时`logout`指令无效？**

**GPT：**

在 Unix 和类 Unix 系统中，`logout` 指令的有效性取决于当前 shell 的类型 —— 是登录 shell 还是非登录 shell。这与使用 `su` 或 `su -` 命令切换用户的方式有关：

1. **`su - 用户名` 或 `su -`**:
   - 这个命令切换到目标用户并启动一个新的登录 shell。在登录 shell 中，可以使用 `logout` 命令退出登录。因为登录 shell 通常是在用户登录到系统时，比如通过终端或SSH登录时创建的，所以 `logout` 命令在这种情况下是有效的。
2. **`su`**:
   - 使用 `su` 命令切换用户时，它不会启动新的登录 shell，而是在当前 shell 中切换用户身份。这意味着 `su` 命令创建的是非登录 shell。在非登录 shell 中，`logout` 命令通常不可用，因为它是用于结束登录会话的。在这种情况下，应该使用 `exit` 命令来退出 shell。

因此，当你使用 `su -` 切换用户时，因为它启动了一个新的登录 shell，你可以使用 `logout` 命令来退出。但如果你只用 `su`，则创建的是非登录 shell，此时应使用 `exit` 命令来退出。

### 3.2.1 使用细节

1. **`logout` 命令的适用环境**：
   - `logout` 注销指令在图形运行级别下无效，在运行级别 3 下有效。

`logout` 命令通常在文本模式的登录会话中使用，比如在通过 SSH 登录到服务器或在本地机器上使用文本终端时。在这些情况下，你可以使用 `logout` 命令来结束你的会话。

在图形界面（通常是运行级别 5）中，用户通常不通过 `logout` 命令来结束会话。而是使用图形界面提供的注销选项来结束会话，比如点击注销按钮。

所以，`logout` 命令适用于非图形的运行级别（如运行级别 3），在这些级别中，用户通常通过文本终端进行交互。而在图形运行级别（如运行级别 5）下，通常使用图形界面的注销机制而不是 `logout` 命令。



1. **运行级别概念**：
   - 运行级别这个概念将在后面介绍。

## 3.3 切换用户

1.  `su - 用户名`（或 `su -`）
2.   `su`



在 Linux 和类 Unix 系统中，使用 `su - 用户名` 与直接使用 `su` 的主要区别在于用户环境和加载的配置文件：

1. **`su - 用户名`（或 `su -`）**:
   - 这个命令用于切换到指定用户，并且启动一个新的登录shell。它会加载用户的完整环境，包括设置环境变量、运行登录脚本等。这意味着它会切换到用户的家目录并加载用户的 `.bash_profile`、`.bashrc` 等配置文件。
   - 如果不指定用户名（只用 `su -`），则默认切换到超级用户（root）。这是一种更安全的方式来获得超级用户权限，因为它避免了在普通用户的环境中运行root用户的命令。
2. **`su`**:
   - 使用 `su` 命令时，会切换到指定用户，但不会启动新的登录shell。这意味着保留当前的环境设置，不会加载目标用户的环境变量或运行其登录脚本。
   - 如果不指定用户名（只用 `su`），则默认切换到超级用户（root），但保持在当前用户的环境中。这可能导致一些预期之外的行为，因为 root 用户可能需要不同的环境设置。

总的来说，`su -` 提供了一个更干净、与目标用户环境一致的方式来切换用户，特别是当切换到具有不同环境设置的用户时（如从普通用户切换到root）。而 `su` 仅改变用户身份，但保持当前的环境设置。





~~~
[C:\~]$ 

Connecting to 192.168.2.129:22...
Connection established.
To escape to local shell, press 'Ctrl+Alt+]'.

Last login: Mon Jan 15 18:26:04 2024 from 192.168.2.1
[tom@hspEdu01 ~]$ su
密码：
[root@hspEdu01 tom]# cd /root
[root@hspEdu01 ~]# ls
anaconda-ks.cfg       公共  图片  音乐
Hello.java            模板  文档  桌面
initial-setup-ks.cfg  视频  下载
[root@hspEdu01 ~]# logout
bash: logout: 不是登录shell: 使用 `exit'
[root@hspEdu01 ~]# exit
exit
[tom@hspEdu01 ~]$ logout

Connection closed.

Disconnected from remote host(192.168.2.129[hspedu100]) at 18:32:30.

Type `help' to learn how to use Xshell prompt.
[C:\~]$ 

Connecting to 192.168.2.129:22...
Connection established.
To escape to local shell, press 'Ctrl+Alt+]'.

Last login: Mon Jan 15 18:31:52 2024 from 192.168.2.1
[tom@hspEdu01 ~]$ su - root
密码：
上一次登录：一 1月 15 18:31:57 CST 2024pts/0 上
[root@hspEdu01 ~]# cd /root
[root@hspEdu01 ~]# logout
[tom@hspEdu01 ~]$ logout

Connection closed.

Disconnected from remote host(192.168.2.129[hspedu100]) at 18:33:49.

Type `help' to learn how to use Xshell prompt.

~~~



## 4 添加用户

### 4.1 基本语法

```bash
useradd 用户名
```

常用选项：

1. **-c**：用于添加用户账户的描述（通常是用户的全名）。
   - 例如：`useradd -c "John Doe" johndoe`
2. **-d**：指定用户的家目录。如果不使用此选项，将创建一个默认的家目录。
   - 例如：`useradd -d /home/johndoe johndoe`
3. **-e**：设置账户的到期日期。日期格式通常为 YYYY-MM-DD。
   - 例如：`useradd -e 2024-12-31 johndoe`
4. **-g**：指定用户的初始登录组（主组）。
   - 例如：`useradd -g users johndoe`
5. **-G**：指定用户的附加组。
   - 例如：`useradd -G wheel,developers johndoe`
6. **-m**：创建用户的家目录。如果没有指定 `-m` 选项，可能不会自动创建家目录。
   - 例如：`useradd -m johndoe`
7. **-M**：不创建用户的家目录，即使系统设置中指定了创建家目录。
8. **-n**：不创建与用户同名的群组。
9. **-p**：为账户指定密码。通常，这个密码需要是加密过的形式。
   - 例如：`useradd -p [加密密码] johndoe`
10. **-r**：创建一个系统账户。系统账户通常用于运行服务和应用程序。
11. **-s**：指定用户的登录shell。
    - 例如：`useradd -s /bin/bash johndoe`
12. **-u**：指定用户的唯一用户ID（UID）。
    - 例如：`useradd -u 1005 johndoe`

这些选项可以结合使用以满足特定的需求。例如，可以同时设置用户的家目录、登录shell和主组。在使用 `useradd` 指令时，最好根据实际情况和系统的用户管理政策来选择合适的选项。





### 4.2 应用案例

- **案例 1**: 添加一个用户 milan，默认该用户的家目录在 `/home/milan`

### 4.3 细节说明

1. 当创建用户成功后，会自动创建和用户同名的家目录。
2. 也可以通过 `useradd -d 指定目录 新的用户名`，给新创建的用户指定家目录。





## 5 指定/修改密码

### 5.1 基本语法

```
passwd 用户名
```

**注意：这里修改密码时一定要带上用户名，否则修改的是当前登录用户的密码**

### 5.2 应用案例

- 给 milan 指定密码：`passwd milan`

补充，显示当前用户所在的目录：`pwd`

## 6 删除用户

### 6.1 基本语法

```
userdel 用户名
```

### 6.2 应用案例

1. 删除用户 milan，但是要保留家目录：`userdel milan`
2. 删除用户以及用户主目录，比如 tom：`userdel -r tom`





如果有用户正在使用mycentos 就删除不了

~~~
[root@hspEdu01 mycentos]# userdel -r mycentos 
userdel: user mycentos is currently used by process 8188
~~~



`userdel -r mycentos` 命令试图删除名为 `mycentos` 的用户，并且 `-r` 选项指示同时删除用户的家目录和邮件箱。

但是，如果用户 `mycentos` 正在运行进程（在你的例子中是进程 8188），则 `userdel` 命令将无法删除该用户，并显示错误消息：

```
vbnetCopy code
userdel: user mycentos is currently used by process 8188
```

这个安全机制是为了防止正在运行的进程失去其拥有者，这可能会导致数据丢失或系统不稳定。

如果你确实需要删除该用户，你可以采取以下步骤：

1. **确定并终止相关进程**：
   - 首先确认进程 8188 是什么，可以使用 `ps` 命令查看该进程的详细信息。
   - 如果确定进程可以安全终止，可以使用 `kill` 命令来终止它。
2. **确保用户没有登录**：
   - 确认用户 `mycentos` 没有在任何终端、GUI 或网络服务中登录。你可以使用 `who` 或 `w` 命令查看当前登录的用户。
3. **再次尝试删除用户**：
   - 在终止了相关进程并确保用户没有登录后，你可以再次尝试使用 `userdel -r mycentos` 来删除用户。

请注意，强行删除正在运行进程的用户可能会对系统稳定性和数据完整性造成影响，所以在进行这些操作前需要谨慎考虑。

### 6.3 细节说明

- 是否保留家目录的讨论? 一般情况下，我们建议保留。




以下是你提供的信息整理为Markdown格式的文档：

### 6.4 查询用户信息指令: id 用户名

**基本语法**:`id 用户名`

**应用实例**

**案例**：请查询 root 信息

`id root`

**细节说明**

- 当用户不存在时，返回无此用户



### 6.5 切换用户: su - 切换用户名

**介绍**

在操作 Linux 中，如果当前用户的权限不够，可以通过 su - 指令，切换到高权限用户，比如 root

**基本语法**:`su - 切换用户名`

`su - root`

**应用实例**

创建一个用户 jack，指定密码，然后切换到 jack

 **细节说明**

1) 从权限高的用户切换到权限低的用户，不需要输入密码，反之需要。
2) 当需要返回到原来用户时，使用 exit/logout 指令

### 6.6 查看当前用户/登录用户 whoami/ who am I

## 

## 7 新增组

**指令**: `groupadd 组名`



## 8 删除组

**指令 (基本语法)**: `groupdel 组名`

 

### 8.1 案例演示

1. 增加用户时直接加上组
2. **指令 (基本语法)**: `useradd –g 用户组 用户名`
3. 增加一个用户 zwj，直接将他指定到 wudang
4. `groupadd wudang`
5. `useradd -g wudang zwj`

### 8.2 修改用户的组

**指令 (基本语法)**: `usermod –g 新用户组 用户名`

#### 案例演示

- 创建一个组 mojiao
- 把 zwj 放入到 mojiao
- **指令**: `usermod -g mojiao zwj`



在 Linux 和类 Unix 系统中，`usermod` 命令用于修改用户账户的设置。命令 `usermod -g mojiao zwj` 中的各个部分具有以下含义：

- `usermod`：这是 “user modification” 的缩写，意为“用户修改”。它是用来修改系统上现有用户属性的命令。
- `-g`：这个选项是 `--gid` 或 “group ID” 的缩写。它用于设置或更改用户的主要（初始）群组。



## 9 运行级别



指定运行级别

### 9.1.1基本介绍

运行级别说明：

0 ：关机

1 ：单用户【找回丢失密码】

2：多用户状态没有网络服务

3：**多用户状态有网络服务**

4：系统未使用保留给用户

5：图形界面

6：系统重启

常用运行级别是 3 和 5 ，也可以指定默认运行级别， 后面演示

### 9.1.2应用实例

命令：`init [0123456] `应用案例： 通过 init 来切换不同的运行级别，比如动 5-3 ， 然后关机。

**`init 5`**

### 9.1.3CentOS7 后运行级别说明

在 centos7 以前， /etc/inittab 文件中 . 

进行了简化 ，如下:

**multi-user.target**: analogous to runlevel 3

**graphical.target**: analogous to runlevel 5

\# To view current default target, run: 

**systemctl get-default**

\# To set a default target, run:

**systemctl set-default TARGET.target**



`systemctl` 是 `system control` 的缩写

![image-20240115232423772](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240115232423772.png)



1. **`init 5`**:
   - 这个命令用于切换系统到运行级别 5，这通常是图形用户界面模式。
   - 在传统的 SysV init 系统中，`init 5` 将立即改变当前运行级别到 5。这个命令不依赖于你当前处于哪个运行级别，它可以从任何运行级别切换到运行级别 5。
2. **`systemctl set-default graphical.target`**:
   - 这个命令是 systemd 系统管理器的一部分，用于设置系统的默认目标（target）。`graphical.target` 是多用户图形界面目标，相当于传统 SysV init 系统的运行级别 5。
   - 该命令并不会立即改变当前运行的级别或启动图形界面，而是设置系统在下一次启动时默认进入的目标。这意味着无论你当前处于哪个运行级别，都可以运行这个命令，它会在下次启动时生效。

1. **`logout`**:
   - 这个命令用于结束当前用户的登录会话。它通常在命令行界面中使用。
   - `logout` 命令与系统的运行级别无关，它只与当前用户的会话有关。当你在终端会话中执行 `logout` 时，它会结束当前会话，不管系统处于哪个运行级别。

总结来说，`init 5` 可以在任何运行级别下执行，并且会立即改变系统的运行级别。`systemctl set-default graphical.target` 设置的是系统下次启动时的默认目标，不依赖于当前的运行级别。`logout` 是用于结束当前用户会话的命令，与系统运行级别无关。

`logout` 命令通常在文本模式的登录会话中使用，比如在通过 SSH 登录到服务器或在本地机器上使用文本终端时。在这些情况下，你可以使用 `logout` 命令来结束你的会话。

**在图形界面（通常是运行级别 5）中，用户通常不通过 `logout` 命令来结束会话**。**即类似于logout` 注销指令在图形运行级别下无效，在运行级别 3 下有效。**而是使用图形界面提供的注销选项来结束会话，比如点击注销按钮。

所以，`logout` 命令适用于非图形的运行级别（如运行级别 3），在这些级别中，用户通常通过文本终端进行交互。而在图形运行级别（如运行级别 5）下，通常使用图形界面的注销机制而不是 `logout` 命令。





## 10 文件目录指令

### pwd指令

基本语法：`pwd`

功能描述：显示当前工作目录的绝对路径

应用实例：案例：显示当前工作目录的绝对路径

### ls指令

基本语法：`ls [选项] [目录或是文件]`

常用选项：

- `-a`：显示当前目录所有的文件和目录，e包括隐藏的。

- `-l`：以列表的方式显示信息

应用实例：

```
案例：查看当前目录的所有内容信息
ls -al
```



~~~
案例： 将/home目录下的文件列表，写入到/home/info.txt【如果info.txt没有，会创建】
ls -l /home > /home/info.txt
~~~

**补充：**`ls -lh`

- `-l` 选项告诉 `ls` 以长列表格式显示目录内容，包括文件的权限、所有者、大小和最后修改时间。
- `-h` 选项是 “human-readable”，它的作用是使文件大小易于阅读，例如以 KB、MB 或 GB 代替字节数。

当组合使用 `-lh` 选项时，`ls -lh` 命令会以易于阅读的长列表格式显示目录内容。



![image-20240117202632505](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240117202632505.png)





---

### ll 指令



`ll` 不是一个独立的命令，而是 `ls -l` 命令的一个别名，通常在很多 Unix/Linux 发行版中默认配置。它用于列出当前目录下的文件和目录的详细信息，包括文件权限、链接数、所有者、群组、文件大小、时间戳和文件名。

### 基本语法和输出格式：

命令：

```
bashCopy code
ll
```

输出格式解释：

- **文件类型和权限**: 显示为一个字符串（如 `-rwxr-xr-x`），表示文件的类型（文件、目录、链接等）和它的访问权限（读、写、执行）。
- **链接数**: 文件或目录的硬链接数量。
- **所有者**: 文件或目录的所有者用户名。
- **群组**: 文件或目录的所属群组名。
- **文件大小**: 文件的大小（通常以字节为单位）。
- **时间戳**: 文件或目录最后一次被修改的时间。
- **文件名**: 文件或目录的名称。

### 示例：

假设你有一个名为 `sample.txt` 的文件，执行 `ll` 命令可能会产生类似以下的输出：

```
bashCopy code
-rw-r--r-- 1 user group 2048 Jan 17 10:00 sample.txt
```

这表示 `sample.txt` 是一个普通文件，所有者（user）有读写权限，同组的其他用户（group）只有读权限，其他用户也只有读权限。文件大小为 2048 字节，最后修改时间是 1 月 17 日上午 10:00。

如果你在终端中没有得到 `ll` 命令的预期结果，可能需要检查你的 shell 配置文件（如 `.bashrc` 或 `.bash_profile`）来确认 `ll` 是否已经被定义为 `ls -l` 的别名。





### `cd` 指令

1. 如果当前在`/home`目录下，要进入`tom`目录 ，直接使用 `cd tom` 即可，而不是使用 `cd /tom`。

   ![image-20240116164456916](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240116164456916.png)

   `cd ~` 或者 `cd` ：回到自己的家目录, 比如你是root，`cd ~` 到 `/root`。

   `cd ..`：回到当前目录的上一级目录。

### mkdir指令

`mkdir` 是 "make directories" 的缩写，它的中文意思是“创建目录”。

`-p` 选项是 `--parents` 的缩写，用于创建多级目录。如果指定的目录已经存在，`-p` 选项会防止 `mkdir` 显示错误信息。如果目录不存在，`-p` 会创建必要的父目录。

命令 `mkdir -p /home/tom` 的具体用法是创建一个名为 `tom` 的目录，位于 `/home` 目录下。如果 `/home` 目录下没有 `tom` 目录，那么 `mkdir` 会创建它。如果在 `/home` 下已经存在 `tom` 目录，`-p` 选项会让 `mkdir` 命令不显示任何错误信息。如果路径中包含的任何父目录不存在，例如 `/home` 不存在，`-p` 选项也会确保创建它们



- `mkdir`指令用于创建目录
- 基本格式：`mkdir [选项] 目录的名称`
- 常用选项
  - `-p`：创建多级目录

### 应用实例
- 实例1: 创建一个目录 `/home/dog`

  `mkdir /home/dog`

- 实例2: 创建多级目录 `/home/animal/tiger`

  `mkdir -p /home/animal/tiger`

### rmdir指令

- `rmdir`指令用于删除空目录
- 基本格式
  - `rmdir [选项] 要删除的空目录`



`rmdir` 和 `rm` 是两个不同的 UNIX/Linux 命令，它们都用于删除文件和目录，但有一些关键的区别：

1. **`rmdir`**:
   - `rmdir` 命令用于删除空目录。如果目录不是空的（即包含文件或其他目录），则 `rmdir` 不会删除它，并且通常会显示一条错误消息。
   - rmdir的常用选项包括：
     - `-p` 或 `--parents`：当子目录被删除后导致父目录变为空时，连同父目录一起删除。例如，`rmdir -p a/b/c` 将删除目录 `c`、`b` 和 `a`（前提是在删除 `c` 后 `b` 和 `a` 变为空）。
     - `--ignore-fail-on-non-empty`：即使要删除的目录非空也忽略错误。
2. **`rm`**:
   - `rm` 命令用于删除文件或目录。它比 `rmdir` 更强大，因为它可以删除非空目录及其内容，但也因此更危险。
   - `rm`的常用选项包括：
     - `-r`, `-R`, `--recursive`：递归地删除目录和其内容。
     - `-f`, `--force`：强制删除，忽略不存在的文件，不给出提示。
     - `-i`：交互模式，在删除前询问用户确认。

总结来说，`rmdir` 更适合删除空目录，它的操作相对更安全，因为它不允许删除非空目录。而 `rm`（尤其是配合 `-r` 选项）可以用来删除文件和目录，但使用时需要格外小心，因为它可以删除大量的文件和目录而不给出警告。

`rm` 命令可以用来删除空目录，但你需要使用 `-d` 或 `--dir` 选项。这样，`rm` 就能够删除空目录，其功能类似于 `rmdir`。但是，`rm` 最常用于删除文件或使用 `-r`/`-R`（递归）选项删除非空目录及其内容。

例如：

- 要用 `rm` 删除空目录，你可以执行 `rm -d empty_directory`。
- 如果目录非空，你需要使用 `-r`（或 `-R`，两者作用相同）选项，如 `rm -r directory`。

总之，虽然 `rm` 可以用 `-d` 选项删除空目录，`rmdir` 通常在删除空目录时更常用，因为它的行为更为安全和直观（只删除空目录）。而 `rm` 通常用于删除文件或非空目录（使用 `-r` 选项）。





应用实例：

- 实例: 删除一个目录 `/home/dog`

  rmdir /home/dog

使用警告:

- `rmdir` 删除的必须是空目录，如果里面有文件或其他子目录将失败。
- 提示：如果需要删除非空目录，需要使用 `rm -rf` 命令删除非空目录
- 举例：`rm -rf /home/animal`



解释：`rm` 是 `remove` 的缩写，而 `-rf` 是两个选项的组合，分别是 `-r` 和 `-f`。

- `-r` 或 `-R` 代表 “recursive”，用于递归删除指定目录下的所有子目录和文件。

- `-f` 代表 “force”，用来强制删除文件或目录，不提示任何确认信息。
- **recursive	**adj.递归的;循环的	英/rɪˈkɜːsɪv/美/rɪˈkɜːrsɪv/

### touch 指令

`touch` 指令创建空文件

基本语法 : `touch` 文件名称

应用实例

案例: 在/home 目录下 ， 创建一个空文件 hello.txt

**touch** 	触摸;接触;美/tʌtʃ/ 



### cp指令

`cp` 是一个常用的Linux命令，用于复制文件或目录。

**基本语法:**

- 复制单个文件到另一个目录：

  ```
  cp 源文件路径 目标目录路径
  ```

  例如，将文件 `example.txt` 复制到 `/home/user/` 目录下：

  ```
  cp example.txt /home/user/
  ```

- 复制目录（包括其中的所有文件和子目录）：

  ```
  cp -r 源目录路径 目标目录路径
  ```

  例如，将目录 `/files` 及其全部内容复制到 `/backup` 目录下：

  ```
  cp -r /files /backup
  ```


要**复制文件到当前目录**，你可以使用 `.` 表示当前目录。下面是具体的命令用法：

```
cp 源文件路径 .
```

**选项:**

- `-r` 或 `-R`：递归复制，用于复制目录及其子目录。
- `-i`：在覆盖文件之前提示用户确认。
- `-v`：详细输出，显示复制过程的详细信息。



[root@hspEdu01 opt]# cp /home/bbb/* /opt
[root@hspEdu01 opt]# ls
hello2.txt  hello.txt  rh  VMwareTools-10.3.10-13959562.tar.gz  vmware-tools-distrib  浴衣.jpg



~~~shell
[root@hspEdu01 home]# cp /home/hello.txt /home/bbb/
[root@hspEdu01 home]# ls
bbb  hello.txt  jack  milan  test  tom  zwj
[root@hspEdu01 home]# cd bbb
[root@hspEdu01 bbb]# ls
hello.txt
[root@hspEdu01 bbb]# touch hello2.txt
[root@hspEdu01 bbb]# ls
hello2.txt  hello.txt
[root@hspEdu01 bbb]# cp /home/bbb /opt
cp: 略过目录"/home/bbb"
[root@hspEdu01 bbb]# cd /opt
[root@hspEdu01 opt]# ls
rh  VMwareTools-10.3.10-13959562.tar.gz  vmware-tools-distrib  浴衣.jpg
[root@hspEdu01 opt]# ^C
[root@hspEdu01 opt]# cp /home/bbb/ /opt
cp: 略过目录"/home/bbb/"
[root@hspEdu01 opt]# cp -r /home/bbb/ /opt
[root@hspEdu01 opt]# ls
bbb  rh  VMwareTools-10.3.10-13959562.tar.gz  vmware-tools-distrib  浴衣.jpg
[root@hspEdu01 opt]# cd bbb
[root@hspEdu01 bbb]# ls
hello2.txt  hello.txt
[root@hspEdu01 bbb]# pwd
/opt/bbb
[root@hspEdu01 bbb]# cd ..
[root@hspEdu01 opt]# ls
bbb  rh  VMwareTools-10.3.10-13959562.tar.gz  vmware-tools-distrib  浴衣.jpg
[root@hspEdu01 opt]# rm -rf bbb
[root@hspEdu01 opt]# ls
rh  VMwareTools-10.3.10-13959562.tar.gz  vmware-tools-distrib  浴衣.jpg
[root@hspEdu01 opt]# cp /home/bbb/ /opt
cp: 略过目录"/home/bbb/"
[root@hspEdu01 opt]# cp /home/bbb/* /opt
[root@hspEdu01 opt]# ls
hello2.txt  hello.txt  rh  VMwareTools-10.3.10-13959562.tar.gz  vmware-tools-distrib  浴衣.jpg
~~~

从您提供的命令和输出来看，您已经尝试了几种不同的 `cp` 命令形式来复制文件和目录。以下是您的尝试以及每个命令的结果的总结：

1. **复制单个文件到目录中**:

   ```
   bashCopy code
   cp /home/hello.txt /home/bbb/
   ```

   这个命令成功地将单个文件 `hello.txt` 从 `/home` 目录复制到了 `/home/bbb/` 目录中。

2. **尝试直接复制目录（失败）**:

   ```
   bashCopy code
   cp /home/bbb /opt
   ```

   这个命令没有成功，因为没有使用 `-r`（递归）选项，`cp` 默认不会复制目录。

3. **尝试直接复制目录并添加斜杠（失败）**:

   ```
   bashCopy code
   cp /home/bbb/ /opt
   ```

   这个命令也没有成功，因为同样没有使用 `-r` 选项，单纯添加斜杠并不能改变结果。

4. **递归复制整个目录**:

   ```
   bashCopy code
   cp -r /home/bbb/ /opt
   ```

   使用 `-r` 选项后，这个命令成功地将 `/home/bbb/` 目录以及其所有内容复制到了 `/opt` 目录下，创建了 `/opt/bbb/`。

5. **删除目录**:

   ```
   bashCopy code
   rm -rf bbb
   ```

   这个命令成功地递归删除了 `/opt/bbb` 目录及其所有内容。

6. **递归复制目录内容到另一个目录中**:

   ```
   bashCopy code
   cp /home/bbb/* /opt
   ```

   最后，这个命令使用了通配符 `*` 来复制 `/home/bbb` 内的所有文件到

`/opt` 目录。由于通配符匹配了 `/home/bbb` 下的所有文件（不包括隐藏文件和子目录），这个命令成功地将这些文件复制到了 `/opt` 目录，不再创建 `bbb` 子目录。

总结来说，您的实验结果展示了：

- `cp` 不带 `-r` 选项时无法复制目录。
- `cp -r` 能够递归复制目录及其内容。
- 添加斜杠 `/` 在源目录后不影响递归复制行为。
- 使用通配符 `*`（例如 `/home/bbb/*`）可以复制目录内的所有文件到另一个目录，而不复制目录本身



~~~shell
[root@hspEdu01 home]# ls
hello.txt  jack  milan  test  tom  zwj
[root@hspEdu01 home]# cp /home/hello.txt /home/bbb/
cp: 无法创建普通文件"/home/bbb/": 不是目录
[root@hspEdu01 home]# mkdir bbb
[root@hspEdu01 home]# ls
bbb  hello.txt  jack  milan  test  tom  zwj
[root@hspEdu01 home]# cp /home/hello.txt /home/bbb/
[root@hspEdu01 home]# ls
bbb  hello.txt  jack  milan  test  tom  zwj
[root@hspEdu01 home]# cd bbb
[root@hspEdu01 bbb]# ls
hello.txt
cp 不带 -r 时可以复制文件，一个(cp /home/hello.txt /home/bbb/)或者多个(cp /home/bbb/* /opt)
~~~



~~~
[root@hspEdu01 bbb]# ls
hello2.txt  hello.txt
[root@hspEdu01 bbb]# cp /home/bbb /opt
cp: 略过目录"/home/bbb"
[root@hspEdu01 opt]# cp /home/bbb/ /opt
cp: 略过目录"/home/bbb/"
复制目录需要使用-r
~~~

**使用细节**

强制覆盖不提示的方法：\cp 

 `\cp -r /home/bbb /opt`

~~~shell
[root@hspEdu01 opt]# ls
rh  VMwareTools-10.3.10-13959562.tar.gz  vmware-tools-distrib  浴衣.jpg
[root@hspEdu01 opt]# cp -rf /home/bbb /opt
[root@hspEdu01 opt]# ls
bbb  rh  VMwareTools-10.3.10-13959562.tar.gz  vmware-tools-distrib  浴衣.jpg
[root@hspEdu01 opt]# cp -rf /home/bbb /opt
cp：是否覆盖"/opt/bbb/hello2.txt"？ 
cp：是否覆盖"/opt/bbb/hello.txt"？ 
[root@hspEdu01 opt]# \cp -r /home/bbb /opt

~~~



### rm指令



~~~shell
[root@hspEdu01 opt]# ls
hello2.txt  hello.txt  rh  VMwareTools-10.3.10-13959562.tar.gz  vmware-tools-distrib  浴衣.jpg
[root@hspEdu01 opt]# ^C
[root@hspEdu01 opt]# rm hello*.txt
rm：是否删除普通空文件 "hello2.txt"？y
rm：是否删除普通空文件 "hello.txt"？y
[root@hspEdu01 opt]# ls
rh  VMwareTools-10.3.10-13959562.tar.gz  vmware-tools-distrib  浴衣.jpg
[root@hspEdu01 opt]# cp /home/bbb/* /opt
[root@hspEdu01 opt]# ls
hello2.txt  hello.txt  rh  VMwareTools-10.3.10-13959562.tar.gz  vmware-tools-distrib  浴衣.jpg
[root@hspEdu01 opt]# \rm hello*.txt
[root@hspEdu01 opt]# ls
rh  VMwareTools-10.3.10-13959562.tar.gz  vmware-tools-distrib  浴衣.jpg

 \rm hello*.txt 加上反斜杠后可以不提示
~~~

默认删除文件会提示是否删除，带上`-f`就不再提示了

`cp` 指令复制一个文件夹时，会提示是否要覆盖，带上`\cp`就不提示了

~~~
[root@hspEdu01 opt]# ls
bbb  rh  VMwareTools-10.3.10-13959562.tar.gz  vmware-tools-distrib  浴衣.jpg
[root@hspEdu01 opt]# \rm -r bbb
[root@hspEdu01 opt]# ls
rh  VMwareTools-10.3.10-13959562.tar.gz  vmware-tools-distrib  浴衣.jpg
[root@hspEdu01 opt]# \cp -r /home/bbb /opt
[root@hspEdu01 opt]# ls
bbb  rh  VMwareTools-10.3.10-13959562.tar.gz  vmware-tools-distrib  浴衣.jpg
[root@hspEdu01 opt]# rm -rf bbb
[root@hspEdu01 opt]# ls
rh  VMwareTools-10.3.10-13959562.tar.gz  vmware-tools-distrib  浴衣.jpg

使用\rm -r bbb 和 rm -rf bbb效果相同
~~~

**删除多个文件不提示 ，使用`\rm -r bbb` 和 `rm -rf bbb`效果相同**

~~~
[root@hspEdu01 opt]# ls
bbb  rh  VMwareTools-10.3.10-13959562.tar.gz  vmware-tools-distrib  浴衣.jpg
[root@hspEdu01 opt]# cp -r /home/bbb /opt
cp：是否覆盖"/opt/bbb/hello2.txt"？ y
cp：是否覆盖"/opt/bbb/hello.txt"？ y
[root@hspEdu01 opt]# 
[root@hspEdu01 opt]# cp -rf /home/bbb /opt
cp：是否覆盖"/opt/bbb/hello2.txt"？ y
cp：是否覆盖"/opt/bbb/hello.txt"？ y
[root@hspEdu01 opt]# \cp -r /home/bbb /opt
[root@hspEdu01 opt]# ls
bbb  rh  VMwareTools-10.3.10-13959562.tar.gz  vmware-tools-distrib  浴衣.jpg

复制文件夹不提示只可以使用 \cp -r /home/bbb /opt，不可以使用cp -rf /home/bbb /opt
因为cp -rf /home/bbb /opt 还是会有提示
~~~

**复制文件夹不提示只可以使用 \cp -r /home/bbb /opt，不可以使用cp -rf /home/bbb /opt**
**因为cp -rf /home/bbb /opt 还是会有提示**





### mv 指令：移动文件与目录或重命名



**基本语法:**

- 重命名文件：`mv oldNameFile newNameFile`
- 移动文件：`mv /temp/movefile /targetFolder`
- 移动目录：`mv /opt/bbb /home/`



`mv` 命令用于移动文件或重命名文件。它是 "move" 的缩写。这个命令可以用于两种主要的情景：

1. **移动文件或目录**：当用于移动文件或目录时，`mv` 命令将指定的源文件或目录移动到目标位置。例如，`mv source.txt /target/directory/` 会将 `source.txt` 文件移动到 `/target/directory/` 目录。
2. **重命名文件或目录**：当目标位置与源文件或目录在同一个目录下时，`mv` 命令实际上是对文件或目录进行重命名。例如，`mv oldname.txt newname.txt` 会将 `oldname.txt` 文件重命名为 `newname.txt`。

`mv` 命令的基本语法如下：

```
mv [options] source destination
```

- `source`：要移动或重命名的文件或目录的名称。
- `destination`：目标位置或新名称。

此外，`mv` 命令还有一些常用选项，例如：

- `-i`（interactive）：在覆盖文件之前提示用户确认。
- `-n`（no-clobber）：防止已存在的文件被覆盖。
- `-v`（verbose）：显示详细的过程信息。

`mv` 命令是Linux和Unix系统中常用的文件操作命令之一，用于管理文件和目录的组织结构。

**应用实例:**

1. 将 `/home/cat.txt` 文件重命名为 `pig.txt`。
2. 将 `/home/pig.txt` 文件移动到 `/root` 目录下。
3. 将整个目录 `/opt/bbb` 移动到 `/home` 下。

------

### cat 指令：查看文件内容(显示内容到控制台)

**基本语法:**

- `cat [选项] 文件`  默认会显示文件所有内容到控制台

**常用选项:**

- `-n`：显示行号。

**应用实例:**

- 查看 `/etc/profile` 文件内容，并显示行号：`cat -n /etc/profile | more`。
- `cat /etc/profile > /home/myprofile` 将/home目录下的文件列表，写入到/home/info.txt【如果info.txt没有，会创建】


以下是一些关于Linux `cat`命令的例子：

1. 显示文件内容：

   ```
   bashCopy code
   cat file1.txt
   ```

   这个命令会显示`file1.txt`文件的内容。

2. 合并多个文件：

   ```
   bashCopy code
   cat file1.txt file2.txt
   ```

   这个命令会将`file1.txt`和`file2.txt`文件的内容合并后显示。

3. 将内容写入新文件：

   ```
   bashCopy code
   cat file1.txt > file2.txt
   ```

   这个命令会将`file1.txt`的内容写入到`file2.txt`中。如果`file2.txt`不存在，它会被创建；如果已存在，其原有内容会被覆盖。

4. 将内容追加到现有文件：

   ```
   bashCopy code
   cat file1.txt >> file2.txt
   ```

   这个命令会将`file1.txt`的内容追加到`file2.txt`的末尾。如果`file2.txt`不存在，它会被创建。

这些示例展示了`cat`命令的基本用法，包括显示文件内容、合并文件以及创建和修改文件

------

### more 指令：分页显示文本文件内容(显示内容到控制台)

**基本语法:**

- `more 文件`

退出方式：按 `ctrl+c` 或者 `q`





**应用实例:**

- 使用 `more` 查看 `/etc/profile` 文件。



注意细节：

1.在 `more` 命令中，返回上一屏的功能是有限的。通常情况下，`more` 不支持向上翻页。一旦你翻过一页，就不能回到上一页。这是 `more` 命令的一个局限性。



2.当more作为管道命令时，`cat  /opt/杂文.txt | more`,在打开的文件中使用`:f`,显示不出文件名

![image-20240117175121996](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240117175121996.png)



[root@hspEdu01 home]# more /opt/杂文.txt  #直接使用more ，而不是作为管道命令使用，再`:f`可以显示文件名，

![image-20240117174751397](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240117174751397.png)

使用 `more filename` 而不是 `cat filename | more`。





------

### less 指令：分屏查看文件内容(不显示内容到控制台)

**基本语法:**

- `less 文件`

**应用实例:**

- 使用 `less` 查看大文件 `/opt/杂文.txt`：`less /opt/杂文.txt`。



使用 `less 文件`打开文件后，输入 `-N` 再回车，可以显示行号，输入`-n`,取消行号显示

或者使用 `less -N /etc/profile` 可以显示行号，







------

### echo 指令：输出内容到控制台

**基本语法:**

- `echo [选项] [输出内容]`

**应用实例:**

- 输出环境变量 `$HOSTNAME`：`echo $HOSTNAME`。
- 输出 "hello, world!"：`echo "hello, world!"`。

- `echo "hello,mydate5" > /home/mydate.txt  ` , 写入内容到文件(覆盖)

- `echo "hello,mydate5" >> /home/mydate.txt  ` , 写入内容到文件(追加)

------

### head 指令：显示文件开头内容

**基本语法:**

- `head -n 数字 文件`

**应用实例:**

- 查看 `/etc/profile` 的前 5 行代码：`head -n 5 /etc/profile`。

------

### tail 指令：显示文件尾部内容

**基本语法:**

- `tail 文件`：查看文件尾 10 行内容。
- `tail -n 数字 文件`：查看文件尾指定行数内容。
- `tail -f 文件`：实时追踪文档更新。

**应用实例:**

- 查看 `/etc/profile` 最后 5 行代码：`tail -n 5 /etc/profile`。
- 实时监控 `mydate.txt`：`tail -f /home/mydate.txt`。

------

### > 和 >> 指令：输出重定向与追加

**基本语法:**

- `ls -l > 文件`：将列表内容覆盖写入文件。
- `ls -al >> 文件`：将列表内容追加到文件末尾。
- `cat 文件1 > 文件2`：将文件1内容覆盖到文件2。
- `echo "内容" >> 文件`：追加内容到文件。

**应用实例:**

- 将 `/home` 目录下的文件列表写入到 `/home/info.txt` 中（覆盖写入）：`ls -l /home > /home/info.txt`。
- 将当前日历信息追加到 `/home/mycal` 文件中：`cal >> /home/mycal`。

---

### cal 显示当前日历信息

`cal` 是 "calendar"（日历）的缩写

**基本语法:**

- `cal`：显示当前月份的日历。
- `cal 12 2024`：显示指定年份（如2024年）12月的日历。
- `cal 2024`：显示整个指定年份（如2024年）的日历。



![image-20240117190720215](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240117190720215.png)

**应用实例:**

- 将当前日历信息追加到 `/home/mycal` 文件中：`cal >> /home/mycal`。

---



### ln 指令：创建软链接（符号链接）

**基本语法:**

- `ln -s [原文件或目录] [软链接名]`

**功能描述：**

- 创建一个指向原文件或目录的软链接（符号链接），类似于 Windows 系统中的快捷方式。软链接包含了原文件或目录的路径信息。

**应用实例:**

**创建软链接：**

在 `/home` 目录下创建一个软链接 `myroot`，指向 `/root` 目录：

~~~
ln -s /root /home/myroot
~~~

**删除软链接：**

删除之前创建的软链接 `myroot`：

~~~
rm /home/myroot
~~~

![image-20240117193812353](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240117193812353.png)



**细节说明:**

- 软链接实际上是一个特殊的文件，包含了对其目标文件或目录的引用路径。
- 当通过软链接访问目标时，系统会自动解析这个路径，让用户感觉就像是直接操作目标文件或目录。
- 使用 `pwd` 命令查看当前工作目录时，如果你当前在一个软链接所指向的目录中，`pwd` 命令显示的是软链接所在的目录，而不是软链接指向的原始路径。要看到实际的物理路径，可以使用 `pwd -P`。

~~~
[root@hspEdu01 ~]# cd /home/myroot/
[root@hspEdu01 myroot]# pwd
/home/myroot
[root@hspEdu01 myroot]# pwd -P
/root
~~~

软链接在文件系统中非常有用，尤其是在需要引用复杂路径或跨文件系统时。由于软链接实质上是一个文本文件，即使它指向的原始文件被删除，软链接本身还是会保留下来，只是变成了一个指向不存在内容的链接。

**同一个文件可以创建多个不同的硬链接吗**?

是的，同一个文件可以创建多个不同的硬链接。每个硬链接都直接指向文件的 inode（文件在文件系统中的低层标识），并且在操作系统的角度看来，这些硬链接与原始文件没有区别。它们都是平等的，文件系统不区分哪一个是原始文件，哪些是硬链接，因为它们都直接指向同一个 inode。

这意味着你可以在文件系统的不同位置创建多个硬链接，所有这些链接都代表文件的同一个版本。如果通过任何一个硬链接修改了文件的内容，所有的链接都会反映这些更改，因为它们实际上指向同一个数据。

需要注意的是，硬链接有以下限制：

1. 不能跨文件系统：硬链接只能在同一个文件系统中创建，因为它们直接指向物理存储中的 inode。
2. 不能链接到目录：为了防止可能产生的循环引用，大多数 Unix/Linux 系统不允许对目录创建硬链接。但是，`.` 和 `..` 是每个目录自动拥有的硬链接，分别指向目录本身和父目录。

![image-20240117192836108](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240117192836108.png)

创建硬链接的语法如下：

```
bashCopy code
ln source_file link_name
```

这会创建 `source_file` 的一个硬链接，名为 `link_name`。



---

`history` 是一个在大多数 Unix/Linux 系统中用于查看和操作命令历史记录的命令。它非常有用，可以帮助用户回顾他们之前执行过的命令。

------

### history 指令：查看和操作命令历史

**基本语法:**

- `history`：显示已经执行过的历史命令。

**功能描述：**

- 查看已经执行过的历史命令。

1. **查看最近的特定数量的命令**：

   - 命令：`history 10`
   - 功能描述：显示最近执行的10条命令。

   示例：

   ```
   history 10
   ```

2. **执行历史列表中特定编号的命令**：

   - 命令：`!5`
   - 功能描述：执行历史列表中编号为5的命令。

   示例：

   ```
   !5
   ```

**细节说明:**

- `history` 命令存储了一个用户在当前会话中执行的命令列表。这个列表通常保存在用户主目录下的一个隐藏文件中，例如 `.bash_history`（对于 Bash shell）。
- 你可以使用上下箭头键来浏览之前的命令。
- `history` 命令对于重复复杂的命令或者修正错误命令非常有用。

通过使用 `history` 命令，你可以有效地浏览、复用或编辑之前执行过的命令，从而提高工作效率。



---

## 11. 时间日期类指令

### 11.1 date 指令 - 显示当前日期

**基本语法:**

- `date`：显示当前时间。
- `date +%Y`：显示当前年份。
- `date +%m`：显示当前月份。
- `date +%d`：显示当前日的日期。
- `date "+%Y-%m-%d %H:%M:%S"`：显示当前的年、月、日、时、分、秒。

**应用实例:**

1. 显示当前时间信息：

   ```
   bashCopy code
   date
   ```

2. 显示当前时间年月日：

   ```
   bashCopy code
   date "+%Y-%m-%d"
   ```

3. 显示当前时间年月日时分秒：

   ```
   bashCopy code
   date "+%Y-%m-%d %H:%M:%S"
   ```

### 11.2 date 指令 - 设置日期

**基本语法:**

- `date -s 字符串时间`

**应用实例:**

1. 设置系统当前时间，例如设置成2020-11-03 20:02:10：

   ```
   bashCopy code
   date -s "2020-11-03 20:02:10"
   ```



**注意细节：修改时间会导致连接中断，解决方法是重启虚拟机Linux系统，使得时间变为当前时间**

![image-20240117204208278](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240117204208278.png)

是的，修改系统时间可能会导致当前的网络连接断开，特别是当你使用的是基于时间的安全协议（如 SSL/TLS）时。这些协议依赖于系统时间来验证证书的有效性，如果时间被设置到过去或未来，那么当前的证书可能会被视为无效。

此外，如果你是通过某些管理工具或者远程终端连接到服务器的，这些工具可能会监控系统时间的变化，并在检测到异常时断开连接以保护会话安全。这是因为时间跳变可能是安全攻击的一个标志，例如重放攻击。

在使用 `date -s` 命令更改系统时间后，如果你是通过 SSH 或其他远程工具连接的，你可能需要重新建立连接。确保在进行此类操作时，你有权限并且了解可能的后果，包括服务中断的风险。如果是生产服务器，最好在维护时间窗口内，并且在监督下进行时间更改。



### 11.3 cal 指令 - 查看日历

**基本语法:**

- `cal [选项]`：不加选项时，默认显示本月日历。

**应用实例:**

1. 显示当前日历：

   ```
   bashCopy code
   cal
   ```

2. 显示2020年日历：

   ```
   bashCopy code
   cal 2020
   ```



------



## 12. 系统管理与维护



###  12.1 `find` 命令

`find` 命令用于从指定目录向下递归地遍历其各个子目录，将满足条件的文件或目录显示出来。

**基本语法：**

```
plaintextCopy code
find [搜索范围] [选项]
```

**应用实例：**

- 案例1: 查找 `/home` 目录下名为 `hello.txt` 的文件:

  ```
  plaintextCopy code
  find /home -name hello.txt
  ```

- 案例2: 查找 `/opt` 目录下属于用户 `nobody` 的文件:

  ```
  plaintextCopy code
  find /opt -user nobody
  ```

- 案例3: 查找整个系统中大小超过200M的文件:

  ```
  plaintextCopy code
  find / -size +200M
  ```

------

###  12.2 `locate` 命令

`locate` 命令用于快速定位文件路径，利用事先建立的文件名和路径数据库来实现快速定位。

**基本语法：**

```
plaintextCopy code
locate [搜索文件]
```

**特别说明：**

在第一次使用 `locate` 前，需要使用 `updatedb` 命令创建数据库。

**应用实例：**

- 案例: 快速定位 `hello.txt` 文件所在的目录:

  ```
  plaintextCopy code
  locate hello.txt
  ```



**which 指令**，可以查看某个指令在哪个目录下，比如 ls 指令在哪个目录

**which ls**



------

### 12.3 `grep` 命令 和 管道符号 `|`

`grep` 命令用于文本搜索，管道符号 `|` 用于将一个命令的输出作为另一个命令的输入。

`grep` 是一个缩写，全称为 "Global Regular Expression Print"。在中文中，它可以译为“全局正则表达式打印”。

**用法**： `grep` 命令在 Linux 和 Unix 系统中用于文本搜索。它会在文件或者来自标准输入的数据中搜索匹配给定模式的行，并默认输出这些匹配的行。`grep` 非常强大，因为它支持正则表达式，这使得它可以进行复杂的模式匹配。

**基本语法**：

```
bashCopy code
grep [选项] 模式 [文件...]
grep [选项] 查找内容 源文件
```

- **选项**：`grep` 命令提供多种选项，用于改变其行为。比如 `-i` 表示忽略大小写，`-n` 表示显示匹配行的行号等。
- **模式**：是您要匹配的文本。可以是一个字符串或者复杂的正则表达式。
- **文件**：指定要搜索的文件名。如果没有指定文件名，`grep` 会从标准输入读取数据。

**常用例子**：

1. **搜索指定文件中的文本**：

   ```
   bashCopy code
   grep 'search_text' filename
   ```

   这会在 `filename` 文件中搜索 `search_text` 并打印所有包含该文本的行。

2. **不区分大小写地搜索**：

   ```
   bashCopy code
   grep -i 'search_text' filename
   ```

   使用 `-i` 选项可以使搜索不区分大小写。

3. **显示匹配行的行号**：

   ```
   bashCopy code
   grep -n 'search_text' filename
   ```

   使用 `-n` 选项可以在输出中包含每个匹配行的行号。

`grep` 是文本处理中极为重要的工具，其功能非常强大，支持多种复杂的搜索模式。



**应用实例：**

- 案例: 查找 `hello.txt` 文件中包含 "yes" 的行，并显示行号。可以用以下两种方式：
  - 写法1: `cat /home/hello.txt | grep "yes"`
  - 写法2: `grep -n "yes" /home/hello.txt`

 ![image-20240117222031718](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240117222031718.png)



grep -ni "yes" /home/hello.txt




在 `grep` 命令中使用正则表达式可以大大增强搜索的能力，使你能够匹配更复杂的模式。以下是一些使用正则表达式的基本方式和例子：

1. **基本匹配**：直接将正则表达式放入命令中。

   ```
   bashCopy code
   grep 'pattern' filename
   ```

2. **使用特殊字符**：

   - `^` 表示行的开始。例如，`grep '^pattern' filename` 将匹配所有以 `pattern` 开始的行。
   - `$` 表示行的结束。例如，`grep 'pattern$' filename` 将匹配所有以 `pattern` 结束的行。
   - `.` 匹配任意单个字符。
   - `*` 匹配前一个字符0次或多次。

3. **字符类**：

   - 使用 `[]` 来匹配字符集合中的任一字符。例如，`grep '[aA]pple' filename` 会匹配 'apple' 和 'Apple'。

4. **使用扩展正则表达式**：

   - `grep` 默认使用基本正则表达式 (BRE)。为了使用扩展正则表达式 (ERE)，可以使用 `grep -E` 或 `egrep`（这两者在现代系统中通常是等价的）。
   - 在扩展正则表达式中，你可以使用 `+`、`?`、`|` 和 `()` 等特殊字符。
     - `+` 表示匹配前一个字符一次或多次。例如：`grep -E 'a+' filename` 匹配一个或多个 'a'。
     - `?` 表示匹配前一个字符零次或一次。
     - `|` 表示“或”操作。例如：`grep -E 'cat|dog' filename` 将匹配 'cat' 或 'dog'。
     - `()` 用于分组。例如：`grep -E '(cat|dog) house' filename` 将匹配 'cat house' 或 'dog house'。

5. **转义字符**：

   - 如果你想匹配特殊字符本身，比如 `.`，你需要用 `\` 来转义，如 `grep '\.' filename` 将匹配包含点的行。

这只是正则表达式的入门介绍。正则表达式非常强大和灵活，可用于实现复杂的文本匹配和处理。

关于引号的使用：都可以，这里建议正则使用单引号 

![image-20240117225417459](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240117225417459.png)



解释：在 `grep` 命令中使用正则表达式时，是否使用引号取决于你的正则表达式中是否含有特殊字符，以及你的shell环境如何处理这些特殊字符。

1. **单引号** (`'`)：当你的模式中包含shell特殊字符时（例如 `$`, `*`, `!` 等），单引号非常有用。单引号会告诉shell对引号内的所有字符按字面意义解释，不进行任何特殊处理。这意味着shell不会解释或展开引号内的任何字符，这通常是处理包含shell特殊字符的正则表达式的安全方式。
2. **双引号** (`"`)：如果你的正则表达式中需要展开shell变量，那么你应该使用双引号。双引号会让shell解释引号内的特殊字符，例如 `$`（变量引用）和 ```（命令替换）。
3. **无引号**：如果你的正则表达式中既没有包含shell特殊字符，也不需要展开变量或命令，那么可以不使用引号。

在你提供的截图中，使用单引号、双引号或不使用引号似乎都得到了相同的结果。这是因为所使用的模式 `^y` 在这里并不包含任何shell会特别处理的字符，所以三种方法在这种情况下都有效。但是，最好的实践是使用单引号，以避免shell对特殊字符的意外解释，特别是当你的模式变得更复杂时。

---

## 13. 压缩和解压类

### 13.1 gzip/gunzip 指令

**功能描述:**

- `gzip`：用于压缩文件，只能将文件压缩为 `*.gz` 文件。
- `gunzip`：用于解压缩文件。

**基本语法:**

- 压缩：`gzip 文件名`
- 解压缩：`gunzip 文件名.gz`

**应用实例:**

1. 使用 `gzip` 压缩 `/home` 下的 `hello.txt` 文件：

   ```
   arduinoCopy code
   gzip /home/hello.txt
   ```

2. 使用 `gunzip` 解压 `/home` 下的 `hello.txt.gz` 文件：

   ```
   arduinoCopy code
   gunzip /home/hello.txt.gz
   ```

#### **注意：关于压缩/解压到指定位置的说明**

1. `gzip` 命令本身不直接提供一个选项来指定压缩文件的目标目录。它**默认会在当前工作目录中创建 `.gz` 文件。**如果你想要将文件压缩到不同的目录，你需要在压缩后将文件移动到指定的目录，或者在压缩前先更改到那个目录中。

例如，如果你想压缩 `/home/user/file.txt` 并将压缩后的文件放入 `/other/dir` 目录，你可以：

```
bashCopy codegzip /home/user/file.txt
mv /home/user/file.txt.gz /other/dir/
```

或者，你可以先更改到目标目录，然后指定文件的绝对路径或相对路径来压缩它：

```
cd /other/dir
gzip /home/user/file.txt
```

这会创建 `/other/dir/file.txt.gz`。



2. **对于 `gunzip`，解压缩的文件默认会出现在 `.gz` 文件所在的同一目录中。**如果你想将文件解压到不同的目录，可以：

```
bashCopy code
gunzip -c /path/to/file.gz > /target/directory/file
```

这里的 `-c` 选项告诉 `gunzip` 将解压的数据写到标准输出，然后使用重定向 `>` 将输出写入目标目录下的文件。

### 13.2 zip/unzip 指令

**zip/unzip 可以指定压缩和解压的目录**。

**功能描述:**

- `zip`：用于压缩文件和目录。

基本语法：**`zip -r [输出压缩文件名] [要压缩的文件或目录]`**

- `unzip`：用于解压缩文件。

**常用选项:**

- `zip`：`-r` 递归压缩，即压缩目录。
- `unzip`：`-d<目录>` 指定解压后文件的存放目录。

**应用实例:**

1. 将 `/home` 下的所有文件/文件夹压缩成 `myhome.zip`：

   ```
   zip -r myhome.zip /home/
   这个命令意味着创建一个名为 myhome.zip 的压缩文件，其中包含 /home/ 目录及其子目录下的所有文件和目录。
   
   如果你将它们的位置颠倒，像这样：
   zip -r /home/ myhome.zip
   zip 会尝试创建一个名为 /home/ 的压缩文件，并将名为 myhome.zip 的文件或目录添加到压缩文件中，这显然是不正确的，因为 /home/ 是一个目录，不是一个文件名。
   
   所以，正确的命令格式应该是：
   zip -r [输出压缩文件名] [要压缩的文件或目录]
   确保你遵循这个格式来避免任何错误。
   ```

2. 将 `myhome.zip` 解压到 `/opt/tmp` 目录下：

   ```
   bashCopy codemkdir /opt/tmp
   unzip -d /opt/tmp /home/myhome.zip
   ```



#### **注意：关于zip/unzip 压缩/解压到指定位置的说明**

对于 `zip` 和 `unzip` 命令，你可以更直接地指定压缩文件或解压文件到特定的目录。

#### zip

使用 `zip` 命令时，如果你想将文件或目录压缩到特定的目录，你可以在命令中指定完整的路径作为压缩文件的名字。

例如，将 `/home/user/data/` 目录下所有文件压缩到 `/other/dir/data.zip`：

```
bashCopy code
zip -r /other/dir/data.zip /home/user/data/
```

#### unzip 

**`unzip` 命令在解压时会创建指定的目标文件夹（如果它不存在的话）**

使用 `unzip` 命令时，你可以通过 `-d` 选项指定解压缩的目标目录。

例如，将 `data.zip` 解压到 `/other/dir`：

```
bashCopy code
unzip data.zip -d /other/dir
```

如果 `data.zip` 文件位于不同的目录，需要提供其完整的路径，或者先切换到包含 `data.zip` 的目录下再执行 `unzip` 命令。

这些命令提供了灵活性，使你能够控制压缩文件的存放位置以及从压缩文件中提取出的文件应该放在哪里。




在 `unzip` 命令中，`-d` 选项后面应该紧跟着你想要解压缩文件的目标目录。关于该选项的位置，通常来说，它可以放在命令行中的任意位置，只要它的参数（目标目录路径）紧随其后即可。

所以，这两个命令都是有效的：

```
bashCopy code
unzip data.zip -d /other/dir
```

和

```
bashCopy code
unzip -d /other/dir data.zip
```

都会将 `data.zip` 文件解压到 `/other/dir` 目录中。

命令行参数的顺序在大多数情况下是灵活的，只要确保选项（如 `-d`）的参数（在这个例子中是目标目录）正确无误地紧跟在选项后面即可。不过，某些命令可能对参数的顺序有特定要求，因此查看命令的帮助文档总是一个好习惯。对于 `unzip` 命令，可以通过 `man unzip` 或 `unzip --help` 查看更多信息和用法。

### 13.3 tar 指令

`tar` 命令**可以指定压缩和解压的目录**。这是如何操作的：

### 压缩时指定目录

当你压缩文件或目录时，你可以直接在命令中指定要压缩的文件或目录的路径。例如：

```
tar -zcvf archive.tar.gz /path/to/directory
```

这将把 `/path/to/directory` 目录（及其所有内容）压缩到 `archive.tar.gz` 文件中。

### 解压时指定目录

**`-zxvf` 解压的是`.tar.gz`**

**`-xvf` 解压的是`.tar`,解压`.tar`不需要`-z`选项**

解压时，你可以使用 `-C` 选项指定解压缩后的文件应该放置的目录。例如：

```
tar -zxvf archive.tar.gz -C /target/directory
```

这将把 `archive.tar.gz` 文件中的内容解压到 `/target/directory`。如果该目录不存在，`tar` 命令将尝试创建它。

### 注意

- 当创建压缩文件时，`tar` 本身不会创建新的目录来放置生成的压缩文件。你需要确保指定的目标路径（压缩文件的存放位置）是存在的。
- 当解压文件时，`-C` 选项指定的目标目录必须存在，或者 `tar` 必须有权限创建它。
- 在提供路径时，最好使用绝对路径，以避免相对路径引起的混淆。

---



**压缩：`tar -zcvf`**

**解压： `tar -zxvf`**



---



**功能描述:**

- `tar`：用于打包目录，压缩后的文件格式为 `.tar.gz`。

**基本语法:**

- `tar [选项] XXX.tar.gz` 打包的内容

**选项解释：**

- `-t`：告诉 `tar` 列出归档文件中的内容。
- `-z`：表示归档文件是用 **gzip** 压缩的，需要先解压。配合`-c`或`-x`使用 ，会生成/解压**.gz**后缀的文件
- `-v`：表示在处理时显示详细信息。
- `-f`：后跟归档文件的名称。


在 `tar` 命令中，`-c` 和 `-x` 选项的作用如下：

- `-c`（创建）
  - 用于创建一个新的归档文件。
  - 将一个或多个文件或目录添加到新的归档中。
  - 常与 `-f` 选项结合使用来指定新归档文件的名称。
- `-x`（提取）
  - 用于从归档文件中提取文件。
  - 将归档文件中的内容恢复到文件系统中。
  - 通常与 `-f` 选项一起使用来指定要解压的归档文件的名称。



**应用实例:**

1. 将 `/home/pig.txt` 和 `/home/cat.txt` 压缩成 `pc.tar.gz`：

   ```
   arduinoCopy code
   tar -zcvf pc.tar.gz /home/pig.txt /home/cat.txt
   ```

2. 将 `/home` 的文件夹压缩成 `myhome.tar.gz`：

   ```
   arduinoCopy code
   tar -zcvf myhome.tar.gz /home/
   ```

3. 将 `pc.tar.gz` 解压到当前目录：

   ```
   Copy code
   tar -zxvf pc.tar.gz
   ```

4. 将 `myhome.tar.gz` 解压到 `/opt/tmp2` 目录下：

   ```
   bashCopy codemkdir /opt/tmp2
   tar -zxvf /home/myhome.tar.gz -C /opt/tmp2
   ```



#### 打包成.tar文件和查看 tar 归档但不解压

1.将多个文件打包成.tar文件

~~~
tar -cf mydata.tar mydate.txt mydate2.txt


在这个例子中，-c 选项告诉 tar 创建一个新的归档文件，-f 后面跟着的 mydata.tar 是新创建的归档文件的名称，最后是要打包的文件列表。
[root@hspEdu01 home]# ls
jack  milan  mycal  mydate2.txt mydate.txt 
[root@hspEdu01 home]# tar -cf mydata.tar mydate.txt mydate2.txt
[root@hspEdu01 home]# ls
jack  milan  mycal  mydate2.txt mydate.txt mydata.tar

~~~



2.查看 tar 归档的内容,这将列出 mydata.tar 归档中的文件，而不会解包它们。

~~~
查看 tar 归档的内容,这将列出 mydata.tar 归档中的文件，而不会解包它们。

[root@hspEdu01 home]# tar -tvf mydata.tar 
-rw-r--r-- root/root        30 2024-01-17 17:14 mydate.txt
-rw-r--r-- root/root        16 2024-01-17 17:18 mydate2.txt

~~~



#### 测试时出现的问题说明：

YOU

-z 指示tar命令在创建归档文件之后，要用gzip对其进行压缩。 为什么可以和-x 一起使用？到底是解压还是压缩？



ChatGPT

在 `tar` 命令中，`-z` 选项是用来指定 `tar` 需要调用 `gzip` 程序来压缩或解压缩文件。这个选项根据它是与 `-c` (创建)选项一起使用还是与 `-x` (提取)选项一起使用，其含义会有所不同：

- 当 `-z` 与 `-c` 一起使用时，它指示 `tar` 在创建归档文件之后，要用 `gzip` 对其进行压缩。例如：

  ```
  bashCopy code
  tar -czvf archive.tar.gz /path/to/directory
  ```

  这条命令创建了一个包含 `/path/to/directory` 的归档文件，并且使用 `gzip` 将其压缩为 `archive.tar.gz`。

- 当 `-z` 与 `-x` 一起使用时，它指示 `tar` 在提取归档文件之前，先用 `gzip` 将其解压缩。例如：

  ```
  bashCopy code
  tar -xzvf archive.tar.gz
  ```

  这条命令将 `archive.tar.gz` 文件解压缩，并且提取其中的内容。

所以 `-z` 选项的作用是根据上下文来确定的，与 `-c` 一起使用时是压缩，与 `-x` 一起使用时是解压缩。这就是为什么它可以和 `-x` 一起使用：它告诉 `tar` 程序归档文件是用 `gzip` 压缩的，所以在提取文件之前需要先进行解压缩。







You

tar -t 是什么选项？

GPT

在 `tar` 命令中，`-t` 选项用于列出归档文件（比如 `.tar` 或 `.tar.gz` 文件）中的内容，而不实际提取这些文件。这个选项通常用于检查一个归档文件中包含哪些文件和目录，而不必解开整个归档。

例如，如果你有一个名为 `archive.tar.gz` 的归档文件，并且想查看它包含哪些文件，可以使用以下命令：

```
bashCopy code
tar -tzvf archive.tar.gz
```

这里的选项解释如下：

- `-t`：告诉 `tar` 列出归档文件中的内容。
- `-z`：表示归档文件是用 gzip 压缩的，需要先解压。配合`-c`或`-x`使用
- `-v`：表示在处理时显示详细信息。
- `-f`：后跟归档文件的名称。

这个命令会显示 `archive.tar.gz` 中所有文件和目录的列表，包括它们的文件大小、权限、所有者等信息，但不会实际提取这些文件到当前目录。



注意是用大写`-C`指定解压目标目录

` tar -zxvf /opt/hm.tar.gz -C /home/`

~~~
[root@hspEdu01 home]# ls
info.txt  jack  milan  mycal  mydate2.txt  mydate.txt  myhome.zip  test  tom  zwj
[root@hspEdu01 home]# tar -zxvf /opt/hm.tar.gz -c /home
tar: 您不能指定超过一个"-Acdtrux"或是"--test-label"外的选项
请用“tar --help”或“tar --usage”获得更多信息。
[root@hspEdu01 home]# tar -zxvf /opt/hm.tar.gz -c /home/
tar: 您不能指定超过一个"-Acdtrux"或是"--test-label"外的选项
请用“tar --help”或“tar --usage”获得更多信息。
[root@hspEdu01 home]# tar -zxvf /opt/hm.tar.gz -C /home/
hello.txt
mydate3.txt
[root@hspEdu01 home]# ls
hello.txt  info.txt  jack  milan  mycal  mydate2.txt  mydate3.txt  mydate.txt  myhome.zip  test  tom  zwj

~~~



![image-20240118013914615](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240118013914615.png)

注意是用大写C指定解压目标目录

报错发生是因为 `-c`（创建新归档）和 `-x`（提取文件）选项不能同时使用。正确的提取命令不应包含 `-c` 选项，并且 `-C` 选项用于指定解压目标目录。



---

###  `zip`/`unzip` 命令和 `tar` 命令在压缩和解压时是否可以创建目录总结

下面是关于 `zip`/`unzip` 命令和 `tar` 命令在压缩和解压时对于不存在目录的处理方式的简要列表：

### `zip`/`unzip`

- **zip（压缩）**
  - **不能** 创建不存在的目标目录。
  - 需要提前确保压缩文件的存放路径已存在。
- **unzip（解压）**
  - **可以** 创建不存在的目标目录。
  - 使用 `-d` 选项指定的解压目标目录会被创建，如果它不存在的话。

### `tar` -zcvf / `tar` -zxvf

- **tar -zcvf（压缩）**
  - **不能** 创建不存在的目标目录。
  - 创建的压缩文件（如 `.tar.gz`）必须存放在已存在的目录中。
  - 以下是脚本相关部分的描述，以及执行该脚本时控制台的输出和原因：
  
    **脚本命令：**
    ```bash
    tar -zcvf $DATETIME.tar.gz ${DATETIME}
    ```
  
    **控制台输出：**
    ```
    2024-01-29_221604/
    2024-01-29_221604/2024-01-29_221604.sql.gz
    ```
  
    **问题描述：**
    执行备份脚本时，控制台输出了上述两行。这些输出是 `tar` 命令在归档文件时由于 `-v`（verbose，详细）选项而产生的。这个选项使得 `tar` 列出了所有正在添加到压缩归档 `.tar.gz` 文件中的文件和目录的名称。
  
    **要点：**
    如果您不希望看到这样的详细输出，应从 `tar` 命令中移除 `-v` 选项。这样，`tar` 命令会静默执行，只在发生错误时向控制台输出信息。
  
    **修正后的脚本命令（移除 `-v` 选项）：**
    ```bash
    tar -zcf $DATETIME.tar.gz ${DATETIME}
    ```
  
    **预期的控制台输出：**
    移除 `-v` 选项后，在执行上述命令时，不应该有任何输出显示到控制台，除非发生错误。这会使得脚本的输出更加清晰，只显示重要的信息或错误消息。
  
    这样的修正可以减少日志的冗余，特别是在自动化脚本运行时，您可能更希望只记录关键步骤和潜在的错误。





- **tar -zxvf（解压）**
  - **可以** 创建不存在的目标目录。
  - 使用 `-C` 选项指定的解压目标目录会被创建，如果它不存在的话。

总结：在压缩时，无论是 `zip` 还是 `tar -zcvf`，都不能创建不存在的目标目录。在解压时，`unzip` 和 `tar -zxvf` 都可以创建不存在的目标目录。



### `gzip`/`gunzip`

- **gzip（压缩）**

  - **不能** 创建不存在的目标目录。
  - 压缩文件将在原始文件的同一目录中创建，除非通过移动操作改变其位置。

- **gunzip（解压）**

  - **不能** 创建不存在的目标目录。

  - 解压的文件将在原始 `.gz` 文件的同一目录中创建，除非使用管道操作将输出重定向到另一个目录。

    如：

总结：`gzip` 和 `gunzip` 都不会创建不存在的目录。它们在当前目录操作，或者在通过命令行操作指定的特定目录中操作。



---

## 

##  14 组管理和权限管理

**文件和目录的所有权及权限管理**

### 14.1 文件所有者管理

#### 14.1.1 查看文件的所有者

- **指令**: `ls –ahl`
- 应用实例:
  - 运行指令后，可以查看文件的详细信息，包括文件的所有者和权限。

#### 14.1.2 修改文件所有者

- **指令**: `chown 用户名 文件名`

- 应用实例:

  - 使用 root 用户创建一个文件 apple.txt ，然后将其所有者修改成 tom：

    ```
    bashCopy code
    chown tom apple.txt
    ```

### 14.2 组的创建

#### 14.2.1 基本指令

- **指令**: `groupadd 组名`

#### 14.2.2 应用实例

- 创建一个组 monster：

  ```
  Copy code
  groupadd monster
  ```

- 创建一个用户 fox，并将其加入到 monster 组中：

  ```
  Copy code
  useradd -g monster fox
  ```

### 14.3 文件/目录所在组

#### 14.3.1 查看文件/目录所在组

- **指令**: `ls –ahl`
- 应用实例:
  - 使用用户 fox 创建一个文件，然后检查该文件属于哪个组。

#### 14.3.2 修改文件/目录所在的组

- **指令**: `chgrp 组名 文件名`



以下是`chgrp`命令的一些常用选项：

- `-c`, `--changes`：类似于`-v`，但只在发生更改时报告。
- `-f`, `--silent`, `--quiet`：不显示错误消息，即使是关于不存在的文件。
- `-v`, `--verbose`：详细模式，显示指令执行过程。
- `--no-dereference`：仅当目标是符号链接时，修改符号链接的组，而不是引用的文件。
- `-R`, `--recursive`：递归地更改指定目录及其内容（包括子目录和文件）的组。
- `--reference=RFILE`：把指定文件/目录的组改成与RFILE文件/目录相同的组。
- `--help`：显示帮助信息并退出。
- `--version`：显示版本信息并退出。

例如，如果您要将当前目录下的 `file.txt` 文件的群组更改为 `users` 组，您会使用以下命令：

```
bashCopy code
chgrp users file.txt
```

如果您想递归地更改 `mydir` 目录及其所有子目录和文件的群组为 `users` 组，您可以使用：

```
bashCopy code
chgrp -R users mydir
```

请记得，更改文件或目录的群组，您需要有足够的权限，或者您需要是`root`用户或使用`sudo`。





- 应用实例:

  - 使用 root 用户创建文件 orange.txt ，查看这个文件当前属于哪个组，然后将文件的所在组改为 fruit 组：

    ```
    bashCopy codegroupadd fruit
    touch orange.txt
    ls -l orange.txt // 查看所在组，假设为 root 组
    chgrp fruit orange.txt
    ```





### 14.4 改变用户所在组

#### 14.4.1 改变用户所在组的指令

- **指令**: `usermod –g 新组名 用户名`
- **特别说明**: 用户需要有权限进入新的初始目录。

#### 14.4.2 应用实例

- 将用户 zwj 从其原始组修改到 wudang 组：

  ```
  Copy code
  usermod -g wudang zwj
  ```

![image-20240119175508071](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240119175508071.png)





### 14.5 权限的基本介绍

#### 14.5.1 文件权限说明

- 示例: 

  ```
  ls -l
  ```

   命令输出的权限表示

  - ```
    -rwxrw-r--
    ```

     表示文件权限，其中：

    - 第 0 位确定文件类型 (d, -, l, c, b)
    - 第 1-3 位确定所有者（User）权限
    - 第 4-6 位确定所属组（Group）权限
    - 第 7-9 位确定其他用户（Other）权限

### 14.6 rwx 权限详解

#### 14.6.1 rwx 作用到文件

- `[r]` 代表可读（read）
- `[w]` 代表可写（write）
- `[x]` 代表可执行（execute）

#### 14.6.2 rwx 作用到目录

- `[r]` 代表可读取目录内容
- `[w]` 代表可修改目录内容
- `[x]` 代表可进入目录



对文件夹/目录 rwx 的细节讨论和测试!!!

x: 表示可以进入到该目录, 比如 cd

r: 表示可以 ls , 将目录的内容显示

w: 表示可以在该目录，删除或者创建文件

细化

目录的权限位 `rwx` 代表以下含义：

- **r (读取权限)**：这个权限决定了用户是否可以列出目录内容。如果设置了读取权限（r），用户可以使用 `ls` 或 `ll` 命令来查看该目录下的文件和子目录列表。
- **w (写入权限)**：这个权限决定了用户是否可以在目录内创建或删除文件或子目录，也就是说，它控制了对目录内容的修改。如果设置了写入权限（w），用户可以在该目录中添加或删除文件及子目录。
- **x (执行权限)**：对于目录来说，执行权限（x）决定了用户是否可以进入（或称之为“遍历”）该目录。在命令行中，这通常意味着用户可以使用 `cd` 命令进入该目录。没有执行权限，用户将无法进入目录内部，即使他们知道目录内的文件名，也无法直接访问这些文件。





用户 `bj`，属于 `yg` 组，遇到以下权限设置：

```
[bj@hspEdu01 home]$ id bj
uid=1013(bj) gid=1013(yg) 组=1013(yg)

[bj@hspEdu01 wk]$ ls -ld /home/wk
drwx--x---. 5 wk    yg       4096 1月  20 19:15 wk

[bj@hspEdu01 wk]$ ls -l /home/wk/monkey.java
-rw-rw-r--. 1 wk yg 12 1月  20 19:15 monkey.java
```

问：用户 `bj` 在这种权限设置下能否进入 `/home/wk` 目录，并能否读写 `monkey.java` 文件？

答：
`bj` 是 `yg` 组的成员，并且他想要访问 `wk` 用户的家目录 `/home/wk` 及其中的文件 `monkey.java`。我们来梳理下这个场景的权限设置和 `bj` 用户能做的操作。

1. 目录 `/home/wk` 的权限设置为 `drwx--x---`：
   - `wk`（所有者）有读取、写入和执行权限。
   - `yg`（所属组）成员只有执行权限。
   - 其他用户没有任何权限。
2. 文件 `/home/wk/monkey.java` 的权限设置为 `-rw-rw-r--`：
   - `wk`（所有者）有读取和写入权限。
   - `yg`（所属组）成员有读取和写入权限。
   - 其他用户只有读取权限。

**梳理后的问题**：

- 由于 `bj` 是 `yg` 组的成员，他可以执行 `cd /home/wk` 进入 `wk` 的家目录。尽管 `bj` 没有列出目录内容的权限（因为缺少读取权限），他仍然可以访问目录本身（因为有执行权限）。
- `bj` 不能使用 `ls` 命令在 `/home/wk` 目录中列出文件，因为他没有读取权限。
- `bj` 可以直接访问和操作 `/home/wk/monkey.java` 文件，因为他知道文件的确切路径，并且作为所属组成员，对该文件有读取和写入权限。

如果 `bj` 尝试执行如 `vim /home/wk/monkey.java` 来编辑文件，他将能够成功打开文件。但如果他尝试使用 `ls /home/wk/` 来查看目录内容，则会失败，因为他没有读取（`r`）权限。







### 14.7 文件及目录权限实际案例

在 Linux 系统中，`ls -l` 命令显示的文件和目录列表包含了许多重要信息。每行的信息表示单个文件或目录的属性。以下是对 `-rwxrw-r-- 1 root root 1213 Feb 2 09:39 abc` 这行信息的详细解析：

1. **文件权限 (`-rwxrw-r--`):**
   - 第一个字符代表文件类型。常见的类型包括：
     - `-`：普通文件
     - `d`：目录
     - `l`：链接
     - `c`：字符设备文件
     - `b`：块设备文件                     **block**	块	美/blɑːk/
   - 接下来的字符分为三组，每组三个字符，代表不同用户类别的权限：
     - 第一组（`rwx`）：文件拥有者的权限。这里是读（`r`）、写（`w`）、执行（`x`）。
     - 第二组（`rw-`）：与文件拥有者同一用户组的其他用户的权限。这里是读（`r`）、写（`w`），没有执行（`-`）权限。
     - 第三组（`r--`）：其他用户的权限。这里是读（`r`），没有写（`w`）和执行（`x`）权限。
2. **硬链接数或子目录数 (1)：**
   - 对于文件，这个数字表示硬链接的数量。
   - 对于目录，这个数字通常表示子目录的数量加上 2（包括 `.` 当前目录和 `..` 父目录的链接）。
3. **文件所有者和所属组（`root root`）：**
   - 第一个 `root` 代表文件的所有者。
   - 第二个 `root` 代表文件所属的用户组。
4. **文件大小（1213 字节）：**
   - 表示文件的大小。这里是 1213 字节。
   - 如果是目录，则通常显示为 4096 字节，代表该目录在磁盘上所占用的空间大小。
5. **最后修改时间（`Feb 2 09:39`）：**
   - 文件最后一次被修改的日期和时间。
6. **文件名（`abc`）：**
   - 文件或目录的名称。

权限也可以用数字表示（r=4, w=2, x=1），因此 `rwx` 可以表示为 7 (4+2+1)，`rw-` 表示为 6 (4+2)，`r--` 表示为 4 (4)。这种数字表示法通常用在 `chmod` 命令中，来改变文件或目录的权限。例如，`chmod 755 abc` 会将 `abc` 文件的权限设置为 `rwxr-xr-x`。



#### 14.7.1 对于**硬链接数或子目录数 (1)：**的解释

比如 `drwxr-xr-x. 3 root root 4096 1月 19 17:59 bbb`，这里的数字表示的是该目录的**硬链接**数量，而不是它里面的文件或子目录数量。

这里的每个部分意味着：

1. `drwxr-xr-x.` - 这是文件权限。`d` 表示这是一个目录。接下来的字符表示所有者（root）、组（root 组的成员）和其他用户对该目录的权限。这里，所有者有读、写和执行权限，组成员和其他用户有读和执行权限。
2. `3` - 这是该目录的硬链接数。对于目录来说，这个数字包括了两个特殊的条目：`.`（指向目录本身）和 `..`（指向父目录），加上目录内的所有子目录（每个子目录都有一个 `..` 条目，指向这个目录）。但是，这个数字不包括目录内的普通文件或子目录里的文件/目录。
3. `root` - 文件的所有者。
4. `root` - 文件所属的组。
5. `4096` - 文件大小（字节）。对于目录，这个数字通常是存储目录信息所需要的空间大小。
6. `1月 19 17:59` - 文件最后修改时间。
7. `bbb` - 文件或目录的名称。

在你执行 `touch hh.txt` 命令创建新文件后，`bbb` 目录的内容确实发生了变化，但是硬链接数没有改变，因为你添加的是文件而不是子目录。如果你添加的是子目录，那么 `bbb` 目录的硬链接数会增加，因为子目录会包含一个指向父目录 `bbb` 的 `..` 条目。





You

如果添加了一个新的子目录，这个子目录中默认有两个硬链接..和. 这里的硬链接'.'也是硬链接啊，不计入其中吗



ChatGPT

ChatGPT

在 Unix-like 系统中，每个目录都有两个特殊的硬链接：`.` 和 `..`。`.` 指向目录本身，而 `..` 指向父目录。这两个硬链接是默认存在的，并且它们的存在是为了文件系统的导航结构。

当你查看一个目录的硬链接数量时：

- `.` 指向该目录本身，但是它不会增加硬链接计数，因为它被认为是目录存在的一部分。
- `..` 在父目录中作为一个条目存在。每个子目录都会在它的父目录的硬链接计数上增加 1。这是因为每个子目录都有一个 `..` 条目，指回父目录。

所以，当你在一个目录中创建一个新的子目录时：

1. 子目录本身会有两个硬链接：`.` 和 `..`。
2. 父目录的硬链接计数会增加，因为子目录的 `..` 实际上是父目录的一个额外的硬链接。

对于普通文件，它们默认只有一个硬链接，就是它们的名字。当你为文件创建额外的硬链接时，文件的硬链接计数会增加，但是目录的行为有所不同，正如上面解释的那样。

#####  



### 14.7 文件和目录的权限管理

#### 14.7.1 修改权限使用 chmod 命令

- **基本说明**：`chmod` 是 "change mode" 的缩写。通过 `chmod` 指令，可以修改文件或目录的权限。

#### 权限变更方法

#### **符号表示法更改权限**

- `u`：所有者

- `g`：所属组

- `o`：其他人

- `a`：所有用户

- 示例：

  - `chmod u=rwx,g=rx,o=x 文件名`：设定所有者有全部权限，组有读和执行权限，其他人有执行权限。
  - `chmod o+w 文件名`：给其他人写权限。
  - `chmod g+r+w+x 文件名`: 给同组/所属组用户增加多个权限
  - `chmod +x aa.txt` :当只写了一个`+x` ,是给所有用户添加`x`权限

  ~~~
  [mycentos@hspEdu01 t1]$ ll
  总用量 4
  -rwxrw-r--. 1 mycentos mycentos 7 1月  20 20:12 aa.txt
  [mycentos@hspEdu01 t1]$ chmod +x aa.txt 
  [mycentos@hspEdu01 t1]$ ll
  总用量 4
  -rwxrwxr-x. 1 mycentos mycentos 7 1月  20 20:12 aa.txt
  
  ~~~

  

  - `chmod a-x 文件名`：移除所有用户的执行权限。

    

- **案例演示**：

  1. `chmod u=rwx,g=rx,o=rx 文件名`：给所有者读写执行权限，组读执行权限，其他人读权限。

  `chmod u=rwx,g=rx,o=rx 文件名`这种形式，会覆盖u/g/o的其他权限，变成等号=右边的权限

  ~~~
  
  
  [jack@hspEdu01 home]$ cd jack
  [jack@hspEdu01 ~]$ ll
  总用量 4
  -rw-rw-r--. 1 jack police 35 1月  20 16:56 hello.txt
  [jack@hspEdu01 ~]$ chmod o=w hello.txt 
  [jack@hspEdu01 ~]$ ll
  总用量 4
  -rw-rw--w-. 1 jack police 35 1月  20 16:56 hello.txt
  [jack@hspEdu01 ~]$ chmod o=r hello.txt 
  ~~~

  

  1. `chmod u-x,g+w 文件名`：移除所有者的执行权限，给组增加写权限。
  2. `chmod a+r 文件名`：给所有用户增加读权限。

#### 数字表示法更改权限

- **数字权限对应**：

  - `r` (读) = 4
  - `w` (写) = 2
  - `x` (执行) = 1
  - 示例：
    - `chmod 751 文件名`：所有者有全部权限(7)，组有读和执行权限(5)，其他人有执行权限(1)。

- **案例演示**：

  - 将` /home/abc.txt`文件权限修改为所有者读写执行，组读执行，其他人执行：

    ```
    chmod 755 /home/abc.txt
    ```



注意细节：

- `jack` 用户可以修改 `/home/jack` 目录的权限。
- 除非有特殊配置，`jack` 用户通常无法修改同组其他用户 `/home/jerry` 目录的权限，这通常需要 `root` 权限。

默认同组用户的文件夹权限如下：

~~~shell
drwx------. 5 xh    bandit   4096 1月  19 23:21 xh
drwx------. 3 xq    bandit   4096 1月  19 23:17 xq
~~~





#### 14.7.2 修改文件所有者使用 chown 命令

- **基本语法**：
  - `chown 新所有者 文件或目录`：更改文件或目录的所有者。
  - `chown 新所有者:新组 文件或目录`：同时更改所有者和组。
- **案例演示**：
  1. `chown tom /home/abc.txt`：将 `/home/abc.txt` 文件的所有者改为 tom。
  2. `chown -R tom /home/test`：将 `/home/test` 目录及其子目录和文件的所有者改为 tom。

#### 14.7.3 修改文件所在组使用 chgrp 命令

- **基本介绍**：
  - `chgrp 新组 文件或目录`：更改文件或目录所在的组。
- **案例演示**：
  - `chgrp shaolin /home/abc.txt`：将 `/home/abc.txt` 文件的组改为 shaolin。
  - `chgrp -R shaolin /home/test`：将 `/home/test` 目录及其子目录和文件的组都改为 shaolin。

#### 14.7.4 最佳实践案例 - “警察和土匪”游戏

- 设置：
  - 创建组 `police` 和 `bandit`。
  - 创建用户 jack 和 jerry，分配至 `police` 组；xh 和 xq 分配至 `bandit` 组。
  - jack 创建文件 `jack.txt`，设置权限允许自己读写，本组读，其他组无权限。
  - jack 修改文件权限，允许其他组读，本组读写。
  - xh 转投 `police` 组，测试读写权限。

**课后练习** 

- 练习目标：
  1. 创建两个组 `sx`（神仙）和 `yg`（妖怪）。
  2. 创建用户唐僧，悟空，八戒，沙僧，分别分配到相应组。
  3. 悟空创建文件 `monkey.java`，设置适当权限。
  4. 八戒修改 `monkey.java` 文件，沙僧更改组并尝试修改文件。

**课后练习2** 

- 操作步骤：
  1. 创建用户 mycentos，并设置密码。
  2. 用 mycentos 登录，创建目录结构 `test/t11/t1`。
  3. 在 `t1` 目录下创建并编辑文件 `aa`。
  4. 修改 `aa` 的权限，执行文件并查看效果。
  5. 清理创建的用户和目录。



#### 14.8 执行bash脚本



改变aa的权限为可执行文件[可以将当前日期追加到一个文件]，运行该文件./aa,这个问题我不会，你可以为我解释吗

ChatGPT

这个问题描述了一个多步骤的过程，其中包括修改文件的权限、将其变为可执行文件，以及执行该文件以将当前日期追加到另一个文件。下面是步骤和解释：

1. **修改文件权限**: 你需要使用 `chmod` 命令来修改文件 `aa` 的权限，使其成为可执行文件。这可以通过添加执行权限给所有用户（所有者、组、其他用户）来实现。

   ```
   bashCopy code
   chmod +x aa
   ```

2. **编写脚本**: 假设文件 `aa` 是一个脚本文件，你需要确保它包含合适的代码来实现所需的功能。在这个情况下，你要将当前日期追加到一个文件。如果 `aa` 是一个 bash 脚本，它可能看起来像这样：

   ```
   bashCopy code#!/bin/bash
   date >> somefile.txt
   ```

   这里，`date` 命令会输出当前日期和时间，`>>` 是一个重定向操作符，它会将 `date` 命令的输出追加到 `somefile.txt` 文件的末尾。

3. **执行文件**: 一旦 `aa` 文件具有执行权限，并且包含了上述的脚本内容，你就可以通过下面的命令来运行它：

   ```
   bashCopy code
   ./aa
   ```

   这个命令将执行当前目录下名为 `aa` 的脚本。由于使用了 `./`，这表明 `aa` 脚本位于当前工作目录中。

请注意，要成功执行这些步骤，你需要有足够的权限来修改 `aa` 文件的权限，并且确保你的系统中有 bash 或相应的 shell 环境来执行脚本。此外，`somefile.txt` 是脚本将日期追加进去的文件，需要确保你对该文件也有写入权限。



You

bash脚本是什么意思？是Linux脚本？



ChatGPT

ChatGPT

Bash 脚本是一种在 Unix 和 Linux 系统上常用的脚本语言。Bash 是 "Bourne Again SHell" 的缩写，是 "Bourne shell" 的一个增强版，后者是 Unix 系统上的传统 shell。Bash 融合了多种其他 shell 的特性，如 Korn shell (ksh) 和 C shell (csh)，并且成为了大多数 Linux 发行版的默认命令行界面。

Bash 脚本允许你编写一系列命令，这些命令将按顺序执行，这就为自动化任务和复杂的工作流程提供了一种有效的方法。一个 Bash 脚本文件通常包含一个特定的脚本头（称为 shebang），它告诉系统使用 Bash 解释器来执行文件中的命令：

```
bashCopy code
#!/bin/bash
```

这一行应该位于脚本文件的第一行。之后，你可以编写任何合法的 Bash 命令，就像你在命令行中输入的那样。当你运行脚本时，Shell 会逐行读取并执行这些命令。

例如，一个简单的 Bash 脚本可以是这样的：

```
bashCopy code#!/bin/bash

echo "Hello, World!"
date
```

这个脚本会先打印 "Hello, World!"，然后输出当前的日期和时间。

要运行一个 Bash 脚本，你需要先给它执行权限，然后才能通过 `./script_name` 来执行它，其中 `script_name` 是你的脚本文件名。如果你没有给脚本执行权限，你可以通过调用 Bash 来执行它：

```
bashCopy code
bash script_name
```

在 Linux 系统中，Bash 脚本是一个强大的工具，用于编写自动化脚本、管理系统任务、进行批量文件操作等等。



You

aa 这个执行脚本可以有后缀名吗？比如.txt



ChatGPT

ChatGPT

在 Linux 系统中，文件的可执行性并不依赖于文件的扩展名，而是依赖于文件的权限。这意味着，即使一个脚本文件有一个通常与文本文件相关联的 `.txt` 扩展名，只要该文件具有执行权限（通过 `chmod` 命令设置），它仍然可以作为一个脚本执行。

例如，假设有一个名为 `aa.txt` 的文件，它包含了有效的 Bash 脚本代码，并且在文件的第一行包含了 shebang（`#!/bin/bash`）。你可以通过以下命令给它设置执行权限：

```
bashCopy code
chmod +x aa.txt
```

然后，你可以像执行没有扩展名的脚本一样执行这个文件：

```
bashCopy code
./aa.txt
```

系统将根据 shebang 行来确定使用哪个解释器执行脚本，不管文件的扩展名是什么。

需要注意的是，在某些情况下，使用非标准扩展名（如 `.txt` 用于脚本）可能会导致混淆，因为扩展名通常用于表示文件内容的类型。因此，最佳实践是对于 Bash 脚本使用 `.sh` 扩展名，对于文本文件使用 `.txt` 扩展名，以便更清晰地表明文件的预期用途。但技术上来说，扩展名并不阻碍文件的执行。







You

如何知道是否可以执行脚本呢？要去看/bin/bash 是否有bash吗



ChatGPT

ChatGPT

要知道一个脚本是否可以执行，你可以通过以下几个步骤来判断：

1. **查看执行权限**: 使用 `ls -l` 命令来查看文件的权限。如果文件有执行权限（表示为 `x`），它通常就可以执行。例如：

   ```
   bashCopy code
   -rwxr-xr-x 1 user group 28 Sep 10 10:00 script.sh
   ```

   在这个例子中，`rwx` 表示所有者有读、写和执行权限，`r-x` 表示组成员有读和执行权限，`r-x` 表示其他用户有读和执行权限。

2. **检查 shebang**: 查看脚本文件的第一行，通常是 shebang（`#!/bin/bash` 或者其他的 shell 解释器路径），这告诉系统用哪个解释器来执行这个脚本。例如：

   ```
   bashCopy code
   #!/bin/bash
   ```

   如果 shebang 指定的解释器路径存在且正确，脚本应当能够执行。

3. **确认解释器存在**: 你可以通过检查 `/bin/bash` 来确认 Bash 解释器是否存在。使用 `which` 命令可以帮助你确定：

   ```
   bashCopy code
   which bash
   ```

   这将返回 Bash 解释器的路径，通常是 `/bin/bash`。

4. **尝试执行脚本**: 直接尝试执行脚本也是一个好方法。如果脚本没有执行权限，你会收到一个 "Permission denied" 的错误。如果脚本的 shebang 错误或指定的解释器不存在，你会收到一个 "Command not found" 或类似的错误。

   ```
   bashCopy code
   ./script.sh
   ```

   或者如果脚本没有执行权限，你可以通过调用解释器来执行：

   ```
   bashCopy code
   bash script.sh
   ```

总之，要执行一个脚本，你需要确保：

- 脚本文件有执行权限。
- 脚本的 shebang 指向了一个有效的解释器路径。
- 你有权限执行该脚本（如果是在系统级别的目录下，可能需要 root 权限）。

如果所有条件都满足，你应该可以执行该脚本。



第一个bash脚本  一般是.sh结尾，

 ~~~shell
 Last login: Sat Jan 20 20:10:27 2024 from 192.168.2.1
 [mycentos@hspEdu01 ~]$ ll
 总用量 4
 drwxrwxr-x. 3 mycentos mycentos 4096 1月  20 20:11 test
 [mycentos@hspEdu01 ~]$ cd test/
 [mycentos@hspEdu01 test]$ cd t11
 [mycentos@hspEdu01 t11]$ cd t1
 [mycentos@hspEdu01 t1]$ ll
 总用量 4
 -rwxrwxr-x. 1 mycentos mycentos 7 1月  20 20:12 aa.sh
 [mycentos@hspEdu01 t1]$ vim aa.sh 
 [mycentos@hspEdu01 t1]$ ./aa.sh 
 总用量 12
 drwxrwxr-x. 2 mycentos mycentos 4096 1月  20 21:04 .
 drwxrwxr-x. 3 mycentos mycentos 4096 1月  20 20:11 ..
 -rwxrwxr-x. 1 mycentos mycentos   19 1月  20 21:04 aa.sh
 [mycentos@hspEdu01 t1]$ vim aa.sh 
 [mycentos@hspEdu01 t1]$ ./aa.sh 
 [mycentos@hspEdu01 t1]$ ll
 总用量 8
 -rwxrwxr-x. 1 mycentos mycentos 55 1月  20 21:06 aa.sh
 -rw-rw-r--. 1 mycentos mycentos 43 1月  20 21:06 date.txt
 [mycentos@hspEdu01 t1]$ cat date.txt 
 2024年 01月 20日 星期六 21:06:25 CST
 [mycentos@hspEdu01 t1]$ cat aa.sh 
 #!/bin/bash
 date > /home/mycentos/test/t11/t1/date.txt
 [mycentos@hspEdu01 t1]$ 
 
 ~~~



1. **运行Bash脚本**：   - 通常情况下，你可以使用命令 `./aa.sh` 来运行名为 `aa.sh` 的Bash脚本，前提是这个脚本具有可执行权限。如果没有可执行权限，你需要首先通过命令 `chmod +x aa.sh` 给予执行权限。   - 另外，你也可以通过直接调用 Bash 来执行脚本，如：`bash aa.sh`。这种方式不需要脚本文件具有执行权限。

2. **Bash脚本的扩展名**：   - Bash 脚本通常以 `.sh` 结尾，但这不是强制性的。Bash 能够执行任何具有正确的 `#!` (shebang) 行的脚本，不论其扩展名如何。   - `.sh` 扩展名是一种约定，表示文件是一个 shell 脚本。这对于用户来说是一种方便，但系统本身并不要求这种扩展名。
3. **Bash脚本和Shell脚本的关系**：   - 所有 Bash 脚本都是 shell 脚本，但并非所有 shell 脚本都是 Bash 脚本。这是因为 "shell" 是一个通用术语，它指的是任何提供用户接口的程序，用于执行命令。Bash (Bourne Again SHell) 是最常用的 Unix shell 之一。   - 不同的 shell 有不同的特性和语法。Bash 被广泛认为拥有许多先进的特性和改进，但它仍然与传统的 sh (Bourne shell) 兼容。   - 当你写 shell 脚本时，重要的是要知道它们是为哪个 shell 编写的。在脚本的第一行通常会有一个 shebang (比如 `#!/bin/bash` 或 `#!/bin/sh`) 来指定应该用哪个 shell 来执行脚本。如果你的脚本使用了特定于 Bash 的特性，你应该使用 `#!/bin/bash`，并且最好不要依赖文件的 `.sh` 扩展名来表示它是一个 Bash 脚本。





你

并且最好不要依赖文件的 `.sh` 扩展名来表示它是一个 Bash 脚本。 这句话我不理解，请解释



ChatGPT

聊天GPT

这句话的意思是，虽然 `.sh` 扩展名通常被用来标识 shell 脚本文件，但这个扩展名本身并不决定脚本将如何执行或脚本内可以使用哪些特性。换句话说，仅凭文件名的扩展名（如 `.sh`），我们不能确定该脚本是为 Bash 设计的，还是为其他 shell（如 sh、ksh 或 zsh）设计的。 这里的核心观点是： 1. **扩展名不决定执行方式**：在 Unix 和类 Unix 系统中，文件是否可以执行以及如何执行，是由文件的权限和 shebang（#!）行决定的，而不是文件的扩展名。你可以有一个没有 `.sh` 扩展名的脚本文件，只要这个文件有适当的执行权限和正确的 shebang 行（例如 `#!/bin/bash`），它就可以作为 Bash 脚本执行。 2. **明确指定解释器**：对于 shell 脚本，最好在文件的第一行明确指定哪个 shell 应该用来执行该脚本。这是通过 shebang 行完成的，例如 `#!/bin/bash` 表明脚本应该由 Bash 解释器执行。这样做比依赖于文件扩展名更为可靠，因为它直接告诉系统如何运行脚本。 因此，即使大多数人习惯于将 `.sh` 作为 shell 脚本的扩展名，最好的做法是在脚本的 shebang 行明确指定用哪个 shell 执行脚本，这样就不会对脚本应该如何执行产生任何混淆



使用./aa来执行当前目录下的aa可执行文件，如果/home/bb可执行脚本不在当前目录如何执行



ChatGPT

shell脚本不写  shebang 行  #!/bin/bash 也执行成功了为什么



ChatGPT

ChatGPT

如果一个 shell 脚本没有指定 shebang 行（如 `#!/bin/bash`），那么系统会使用当前的 shell 来解释执行这个脚本。这意味着脚本的执行依赖于你当前的 shell 环境。

1. **默认 Shell**：
   - 在大多数 Linux 系统中，当你打开一个终端或者一个 shell 会话时，默认的 shell 是 Bash。所以，如果你在这样的环境中执行一个没有 shebang 的脚本，系统默认使用 Bash 来执行这个脚本。如果脚本是用 Bash 语法编写的，它就能正常工作。
2. **兼容性**：
   - 许多 shell 脚本是用标准的 shell 命令和结构编写的，这些通常在不同的 shell 环境中都是兼容的。这意味着即使脚本没有指定 shebang 行，它也可能在不同的 shell（如 Bash、sh 或其他兼容的 shell）中成功运行。
3. **风险**：
   - 不指定 shebang 行的主要风险是脚本的可移植性和一致性。不同的用户可能有不同的默认 shell，或者同一个用户在不同的系统中可能遇到不同的默认 shell。这可能导致脚本在一个环境中正常工作，在另一个环境中出现问题。

因此，即使一个没有 shebang 的 shell 脚本可以在特定情况下执行成功，最佳实践还是在脚本的开头明确指定希望使用的 shell。这样可以确保脚本的行为在不同环境中更加一致可预测。





![User](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/ACg8ocIHS-8SrIxNACX_W4kh1gBxxAmKatgl2D-uFcgwungh9g=s96-c.jpeg)

You





ChatGPT

ChatGPT

### 查看当前用户默认使用的 shell bash

，你可以使用以下几种方法：

1. **通过 `/etc/passwd` 文件**:

   - 这个文件包含了系统上每个用户的信息。你可以查找与你的用户名相关的行，行中的最后部分会指明该用户的默认 shell。

   - 你可以使用 `grep`命令结合你的用户名来直接从 `/etc/passwd`中获取这个信息。例如，如果你的用户名是 `username`，你可以使用以下命令：

     ```
     bashCopy code
     grep username /etc/passwd
     ```

   - 结果将是一个包含你的用户信息的行，最后部分（通常以 `:` 分隔）就是你的默认 shell。

2. **使用环境变量**:

   - ```
     $SHELL
     ```

      环境变量通常保存了当前用户的默认 shell。你可以简单地打印这个环境变量的值来查看：

     ```
     bashCopy code
     echo $SHELL
     ```

   - 这将输出当前用户的默认 shell 的路径。

3. **使用 `getent` 命令**:

   - `getent` 命令用来获取条目，你可以使用它来查询 `/etc/passwd` 文件。这个方法和直接查询 `/etc/passwd` 文件类似，但它提供了一种更为通用和可移植的方式来访问这类数据库。

   - 例如，要查找用户 `username`的默认 shell，可以使用：

     ```
     bashCopy code
     getent passwd username
     ```

   - 输出格式与直接从 `/etc/passwd` 获取的格式相同。

这些方法都可以帮助你确认当前用户的默认 shell。通常，`echo $SHELL` 是最快和最直接的方法。



### 使用./aa来执行当前目录下的aa可执行文件，如果/home/bb可执行脚本不在当前目录如何执行

ChatGPT

如果 `/home/bb` 是一个可执行脚本并且不在当前目录下，你可以通过提供脚本的完整路径来执行它。假设 `bb` 是脚本的名称，而不是包含脚本的目录的名称，你可以这样做：

1. **直接使用完整路径**:

   - 你可以直接在命令行中输入完整的路径来执行脚本，如下：

     ```
     bashCopy code
     /home/bb
     ```

   - 这条命令会执行位于 `/home` 目录下名为 `bb` 的脚本。

2. **如果 `bb` 是目录，且脚本在该目录下**:

   - 如果 bb实际上是包含脚本的目录，并且脚本的名称是比如说 script.sh，那么你应该这样执行：

     ```
     bashCopy code
     /home/bb/script.sh
     ```

   - 这条命令会执行 `/home/bb` 目录下名为 `script.sh` 的脚本。

确保你的脚本有执行权限。如果没有，你需要先赋予执行权限。你可以使用 `chmod` 命令给脚本文件添加执行权限，例如：

```
bashCopy code
chmod +x /home/bb
```

或者，如果 `bb` 是目录：

```
bashCopy code
chmod +x /home/bb/script.sh
```

之后，你就可以像上面展示的那样执行脚本了。



##  15. Linux 实操篇-定时任务调度

#### 15.1 crond 任务调度

- **概述**: 定时任务调度是指系统在设定时间自动执行特定的命令或程序。
- 分类:
  - 系统工作：例如，周期性的病毒扫描。
  - 个人任务：如数据库备份等。

#### 15.1.1 crontab 基本语法

- 使用 `crontab` 命令进行定时任务的设置。

#### 15.1.2 crontab 常用选项

- 命令格式：`crontab [选项]`



1. **`crontab -e`**: 编辑当前用户的 crontab 文件。如果不存在会创建新文件。
2. **`crontab -l`**: 列出当前用户的 crontab 文件内容。
3. **`crontab -r`**: 删除当前用户的 crontab 文件，移除所有任务。
4. **`crontab filename`**: 将指定文件的内容载入到当前用户的 crontab。
5. **`crontab -i`**: 删除前要求确认（某些系统支持），用于避免意外删除任务。



#### 15.1.3 快速入门

- 设置系统级任务调度文件：编辑 `/etc/crontab` 文件。
- 设置个人任务调度：执行 `crontab -e` 命令并输入任务计划。
- **例子**: 每分钟执行一次的任务 - `*/1 * * * * ls –l /etc/ > /tmp/to.txt`

**退出编辑crontab的方式和 vim 一样**

![image-20240121202424467](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240121202424467.png)

#### 15.1.4 crontab 参数和特殊符号

- 详细说明了 crontab 文件中的五个时间字段。
- 讨论了时间字段中可用的特殊符号。

#### 15.1.5 实际应用示例

- **例子 1**: 每1分钟将当前日期追加到 `/tmp/mydate` 文件 - `*/1 * * * * date >> /tmp/mydate`
- 例子 2: 每1分钟将当前日期和日历追加到 `/home/mycal`文件：
  1. 创建脚本 `/home/my.sh` 并写入 `date` 和 `cal` 命令。
  2. 使脚本可执行：`chmod u+x /home/my.sh`。
  3. 设置 crontab：`*/1 * * * * /home/my.sh`

---

出现的问题

crontab的内容如下：

~~~shell
*/1 * * * * ls -l /etc/ > /tmp/to.txt 

*/1 * * * * date >> /home/mycal

*/1 * * * * cal >> /home/mycal 
~~~

#### 为什么写入到/home/mycal时不是先写date然后再写cal呢？

ChatGPT

根据你提供的 `crontab` 内容，你有三个任务，每个任务每分钟都会执行一次。这些任务分别是：

1. `*/1 * * * * ls -l /etc/ > /tmp/to.txt`
2. `*/1 * * * * date >> /home/mycal`
3. `*/1 * * * * cal >> /home/mycal`

这些任务应该几乎同时开始执行，因为它们都设置为每分钟执行一次。但是，实际执行的顺序以及它们写入文件的速度可能会有细微的差异。这种差异可能导致 `date` 命令和 `cal` 命令输出到 `/home/mycal` 文件的顺序不是你期望的顺序。

这里可能发生的情况包括：

1. **命令执行的微小延迟**：尽管这些命令都设置为每分钟执行，但操作系统在处理它们时可能存在微小的延迟。这可能导致某些命令稍微早一点开始执行。
2. **命令执行时间**：某些命令（如 `ls -l /etc/`）可能需要更多时间来完成。尽管在这个例子中 `date` 和 `cal` 通常执行得很快，但它们的开始执行时间可能仍有细微差别。
3. **I/O 延迟**：写入文件的操作可能受到文件系统I/O操作的影响，这可能导致写入操作的实际完成时间有所不同。

如果你想要确保 `date` 命令的输出先于 `cal` 命令的输出写入到 `/home/mycal`，你可以考虑将这两个命令组合成一个 `crontab` 任务，确保它们按照顺序执行和写入。例如：

```
bashCopy code
*/1 * * * * { date; cal; } >> /home/mycal
```

这样，`date` 和 `cal` 命令将按顺序执行，并且它们的输出将按照执行的顺序追加到 `/home/mycal` 文件中。这个方法将确保输出顺序符合你的预期。



#### **将执行命令放在同一个 Shell 脚本中，脚本中的命令会按照顺序依次执行**

如果你将 `date >> /home/mycal` 和 `cal >> /home/mycal` 放在同一个脚本 `my.sh` 中，并且按顺序执行，像这样：

```
bashCopy code#!/bin/bash
date >> /home/mycal
cal >> /home/mycal
```

那么，当你执行这个脚本时，它们会按照脚本中出现的顺序依次执行。这意味着：

1. 首先，`date` 命令的输出会被追加到 `/home/mycal` 文件的末尾。
2. 然后，`cal` 命令的输出也会被追加到 `/home/mycal` 文件的末尾，紧跟在 `date` 命令的输出之后。

因为这两个命令是在同一个脚本中按顺序执行的，它们的执行不会互相干扰，也不会由于调度问题导致执行顺序不确定。脚本确保了命令的执行是顺序的，并且一个命令完成后下一个命令才开始执行。

所以，使用脚本是确保命令按预期顺序执行的好方法，这也避免了你之前在 `crontab` 中遇到的问题。



#### **{ date; cal; } 这个语法是什么意思？通常在哪使用？请举例说明**

ChatGPT

`{ date; cal; }` 这个语法在 Bash 和其他类 Unix 的 shell 中表示命令组。它可以用来将多个命令序列化，并作为一个整体来执行。这种结构特别有用，当你需要在单个 shell 实例中按顺序执行多个命令，并且希望它们作为一个组来处理时。这里的关键点包括：

1. **命令按顺序执行**：在大括号内的命令会按照它们出现的顺序依次执行。第一个命令完成后，第二个命令开始执行，以此类推。
2. **作为一个整体**：这些命令被视为一个整体，因此你可以对它们整组重定向输入/输出。比如，你可以将整个命令组的输出重定向到一个文件。
3. **语法注意事项**：
   - 命令组的开头和结尾使用大括号 `{` 和 `}`。
   - 大括号内的命令用分号 `;` 分隔，或者用换行符。
   - 大括号前后需要有空格。

**使用场景举例：**

1. **在一个 crontab 任务中顺序执行多个命令**：

   ```
   bashCopy code
   */1 * * * * { echo "Current date and time:"; date; echo "Calendar:"; cal; } >> /home/mycal
   ```

   这个例子中，`echo "Current date and time:"`、`date`、`echo "Calendar:"` 和 `cal` 依次执行，并且它们的输出会追加到 `/home/mycal` 文件。

2. **将多个命令的输出重定向到同一个文件**：

   ```
   bashCopy code
   { echo "Header"; cat file1; echo "Footer"; } > output.txt
   ```

   这会在 `output.txt` 文件中创建一个包含 "Header"、`file1` 的内容和 "Footer" 的文件。

3. **在单个命令中执行一系列的命令，并且根据整个命令组的成功或失败进行条件执行**：

   ```
   bashCopy code
   { command1; command2; command3; } && echo "All commands succeeded" || echo "Some command failed"
   ```

   如果 `command1`、`command2` 和 `command3` 都成功执行，将打印 "All commands succeeded"。如果任何一个命令失败，将打印 "Some command failed"。

命令组提供了一种将多个命令逻辑分组的方式，使得它们可以作为一个单元进行管理和执行，非常适用于需要确保命令按特定顺序执行的场景。



- 例子 3: 每天凌晨2点备份 mysql 数据库 `testdb`：
  1. 编辑 crontab：`crontab -e`
  2. 添加备份任务：`0 2 * * * mysqldump -u root -proot testdb > /home/db.bak`

#### 15.1.6 crond 相关命令

- `crontab -r`：移除所有定时任务。
- `crontab -l`：列出所有定时任务。
- `service crond restart`：重启定时任务服务。

#### 15.2 at 命令

#### 15.2.1 at 命令基本介绍

- `at` 用于一次性任务调度，由 `atd` 守护进程后台运行并检查作业队列。

#### 15.2.2 at 命令格式和选项

- 命令格式：`at [选项] [时间]`
- 结束输入：Ctrl + D。

`at` 是一个 Linux 命令，用于调度一次性任务，即让系统在指定的时间执行指定的命令。不同于 `cron`，它通常用于计划单次任务而非定期重复任务。

**常用选项**:

- **`atq`**：列出当前用户的挂起的 `at` 作业。
- **`atrm`** 或 `at -d`：删除指定的 `at` 作业。
- **`at -f filename`**：从指定的文件中读取要执行的命令。
- **`at -t time`**：在特定时间执行命令。时间格式为 `[[CC]YY]MMDDhhmm[.ss]`。

**具体用法**：

1. **安排任务**:

   ```
   at time
   ```

   这里的 `time` 可以是多种格式，例如 `now + 1 minute`，`4pm + 2 days` 等。执行这个命令后，你会进入一个提示符，你可以输入希望在指定时间执行的命令，然后按两次 `Ctrl+D` 结束。

2. **查看任务**:

   ```
   atq
   ```

   这个命令会列出所有已安排的 `at` 任务。且会显示所有安排的 `at` 任务及其任务编号。

3. **查看特定任务的详细内容**:

   ~~~
   at -c job_number
   ~~~

​       其中 `job_number` 是通过 `atq` 命令得到的任务编号。

​	   例如，如果 `atq` 显示任务编号为 3，你可以用以下命令来查看这个任务的详细内容：

​		`at -c 3`

​	这会显示任务 3 的完整内容，包括你输入的命令以及一些环境设置信息。

4. **删除任务**:

```
atrm job_number
```

这里的 `job_number` 是使用 `atq` 命令时显示的作业编号。

5. **提交任务：Ctrl + D **

在完成命令输入后，按两次 Ctrl + D 来结束输入并提交 `at` 任务。



`at` 命令非常适合那些只需要执行一次的任务，如重启服务、运行备份等。



**在 `at` 命令的提示符下，如果你输入了错误的命令或者想要删除一些字符**，通常使用的退格键或删除键可能不按预期工作，这取决于你的终端和 shell 配置。

**Ctrl + U**：一次性清除当前行。

这不会删除你为 `at` 命令输入的所有内容，只是清除当前正在输入的行。

**Ctrl + C**：取消当前任务的创建。

 你可能需要重新开始命令输入。在 `at` 命令提示符下，可以按 Ctrl + C 来取消当前任务的创建。然后你可以重新执行 `at 5pm + 2days` 并重新输入正确的命令。





### at 时间定义

`at` 命令允许你以多种方式指定任务应当执行的时间，提供灵活性来满足不同的调度需求。

1. **特定时间**：可以直接指定具体的时间点，如 `hh:mm` 格式。如果指定的时间已经过去，则任务将在第二天的该时刻执行。例如：`04:00` 表示早上4点。
2. **语义化时间**：可以使用如 `midnight`（深夜）、`noon`（中午）、`teatime`（下午茶时间，通常是下午4点）等词语来指定时间。
3. **12小时制**：使用AM/PM来明确时间是上午还是下午。例如：`12pm` 表示中午12点。
4. **具体日期**：可以指定任务执行的具体日期，格式为 `month day`（月 日）、`mm/dd/yy`（月/日/年）或 `dd.mm.yy`（日.月.年）。指定日期需要紧跟在时间后面。例如：`04:00 2021-03-1`。
5. **相对计时法**：使用 `now + count time-units` 的格式，其中 `now` 表示当前时间，`time-units` 是时间单位（可以是 `minutes`、`hours`、`days`、`weeks`），`count` 是数量。例如：`now + 5 minutes` 表示从现在开始的5分钟后。
6. **今天和明天**：可以直接使用 `today` 或 `tomorrow` 来指定任务在今天或明天的同一时间执行。

![image-20240121215803400](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240121215803400.png)

**`atd`** :at的守护进程，会以后台模式运行

![image-20240121215716651](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240121215716651.png)

检测`atd`是否在运行

`ps -ef` 是一个在 Unix 和类 Unix 系统中常用的命令，用于显示当前系统中活动进程的详细信息。这个命令的输出提供了每个进程的快照。以下是该命令选项的详细解释：

- `ps`：这是 "process status" 的缩写，是用来显示当前运行的系统进程信息的命令。
- `-e`：这个选项告诉 `ps` 命令显示所有进程。没有 `-e` 选项，`ps` 通常只显示当前用户和当前终端相关的进程。
- `-f`：这个选项表示 "full format"，意味着显示完整格式的信息。这会提供关于每个进程的更详细信息，而不仅仅是基本信息。

使用 `ps -ef` 命令通常会显示如下信息：

- **UID**：启动进程的用户 ID。
- **PID**：进程 ID。
- **PPID**：父进程 ID（即创建这个进程的进程的 ID）。
- **C**：CPU 利用率。
- **STIME**：进程开始时间。
- **TTY**：与进程关联的终端类型。
- **TIME**：进程占用的 CPU 时间。
- **CMD**：启动进程的命令名称或命令行。

这个命令非常有用，可以帮助系统管理员查看系统中所有运行的进程及其相关信息，进行故障诊断，了解系统运行状态等。

#### 15.2.3 at 时间定义

- 定义执行命令的时间，可以使用具体时间点或相对时间。

#### 15.2.4 应用示例

- **例子**: 两天后下午5点执行 `/bin/ls /home` - 定时检查 `/home` 目录。

在 `at` 命令中，指定时间时不应该在数字和时间单位之间留空格。所以正确的格式是：

```
at 5pm + 2days
```

这条命令的意思是安排一个任务在今天之后的第二天的下午5点执行。如果今天是1月1日，这个任务会被安排在1月3日的下午5点执行。



## 16. Linux 分区和磁盘管理

### 16.1 Linux 分区

#### 16.1.1 原理介绍

1. Linux 文件系统是单一树状结构，无论有多少分区，都挂载在一个统一的根目录下。
2. Linux 使用“挂载”将特定分区的存储空间映射到目录树中的一个目录下。
3. 示意图（未提供）

#### 16.1.2 硬盘说明

1. Linux 硬盘分为 IDE 和 SCSI，当前主要是 SCSI 硬盘。（斯嘎sei硬盘）
2. IDE 硬盘的命名规则为 `hdx~`，`hd`表示 IDE 硬盘，`x`是盘号（a、b、c、d 对应不同的硬盘），`~`代表分区号。
   - 例如：`hda3` 表示第一个 IDE 硬盘的第三个主分区或扩展分区。
3. SCSI 硬盘命名规则为 `sdx~`，规则与 IDE 相同。

#### 16.1.3 查看所有设备挂载情况

- 使用命令：`lsblk` 或 `lsblk -f` 查看。



`lsblk` 实际上不是一个缩写，而是 Linux 命令行工具的名称。`lsblk` 是从 **"list block devices"**（列出块设备）这一功能性描述中提取的命令名，用于列出系统中所有的块设备信息，包括硬盘、分区和其他存储设备。尽管它看起来像是一个缩写，但它实际上是一个独立的命令，而不是由几个单词的首字母组成的缩写。

`lsblk` 是一个Linux命令，用于列出所有可用的块设备的信息。

**中文意思**：列出块设备。

**具体用法**：

- 执行 `lsblk` 命令将显示系统中的所有块设备，如硬盘、分区、光驱等。
- 该命令提供了关于块设备的详细信息，包括设备名称、挂载点、磁盘大小、分区类型等。
- `lsblk` 常被用于查看设备挂载情况和设备属性。

例如，执行 `lsblk` 命令可能会输出如下信息：

```
NAME   MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
sda      8:0    0    80G  0 disk 
├─sda1   8:1    0   500M  0 part /boot
└─sda2   8:2    0  79.5G  0 part /
sdb      8:16   0  160G  0 disk 
├─sdb1   8:17   0   159G  0 part /mnt/data
└─sdb2   8:18   0     1G  0 part 
sr0     11:0    1  1024M  0 rom  
```

这个输出展示了系统中的磁盘（sda 和 sdb），它们的分区（如 sda1 和 sdb1），挂载点（如 / 和 /mnt/data），以及每个设备的大小、类型和读写权限。

#### **`sda`、`sdb`** 的意思解释：

在Linux中，**`sda`、`sdb`** 这样的名字用于标识系统中的硬盘。

- `sd` 是历史上用于标识SCSI设备的前缀，但现在这个前缀用于所有类型的硬盘，包括SATA和SSD。
- `a`、`b`、`c` 等字母用于区分系统中的不同硬盘。`a` 通常是第一块硬盘，`b` 是第二块硬盘，以此类推。

例如：

- `sda`：系统中的第一块硬盘。
- `sdb`：系统中的第二块硬盘。

此外，分区则通过在硬盘标识后添加数字来标识。例如：

- `sda1`：第一块硬盘的第一个分区。
- `sdb3`：第二块硬盘的第三个分区。

这种命名规则提供了一种直观的方式来识别和引用系统中的硬盘和分区。



#### 执行 `lsblk` 命令输出后的列名解释：

**`NAME`, `MAJ:MIN`, `RM`, `SIZE`, `RO`, `TYPE`, `MOUNTPOINT`** 是 `lsblk` 命令输出中的列标题，每个标题代表不同的信息：

1. **NAME**: 设备的名称。例如，`sda`、`sdb`（通常代表硬盘），或者 `sda1`、`sda2`（代表硬盘上的分区）。
2. **MAJ:MIN**: 这是设备的主次设备号。主设备号（MAJ）标识设备类型，次设备号（MIN）标识特定的设备。这对于内核识别设备很重要。
3. **RM**: 表示设备是否为可移除设备。如果是可移除的，如U盘或可移动硬盘，这里会显示 `1`，否则显示 `0`。
4. **SIZE**: 设备的大小。显示的是整个设备或分区的存储容量。
5. **RO**: 表示设备是否为只读。如果设备是只读的，这里会显示 `1`，否则显示 `0`。
6. **TYPE**: 设备类型。它可以是 `disk`（表示整个硬盘）、`part`（表示硬盘上的分区）、`rom`（光驱），等等。
7. **MOUNTPOINT**: 挂载点。这是文件系统挂载到系统中的位置。如果设备或分区已经挂载，它会显示挂载点的路径，否则这一列为空。

这些信息共同提供了关于系统中块设备的详细概述，非常有用于系统管理员进行磁盘和存储管理。



#### 执行`lsblk -f`后结果如下： 

![image-20240122163631882](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240122163631882.png)

![image-20240122173822407](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240122173822407.png)

`sr0` 在 `lsblk` 命令显示的输出中通常代表第一个SCSI光驱设备。在这里：

- `sr` 表示 SCSI 光驱（CD-ROM、DVD-ROM等）。
- `0` 表示第一个此类设备。如果有多个光驱，接下来会是 `sr1`、`sr2` 等。

这种设备通常用于读取或写入光盘媒体，例如 CD 或 DVD。虽然现代计算机使用光驱的情况越来越少，但Linux仍然保留了对这些设备的支持，并且在系统中将它们标识为 `srX`。



`sr0` 通常指的是物理的 SCSI 光驱设备，但在虚拟环境中（比如使用虚拟机软件），`sr0` 也可以代表虚拟的 CD/DVD 驱动器。在这种情况下，`sr0` 可以指向一个挂载的 ISO 镜像文件，比如 `CentOS-7-x86_64-DVD-1810.iso`。

当在虚拟机中挂载一个 ISO 镜像作为虚拟 CD/DVD 时，操作系统会将这个 ISO 镜像视为一个实际的 CD/DVD 光盘，并分配一个设备名称，如 `sr0`。这样，系统和应用程序可以像访问物理光驱中的光盘一样访问这个 ISO 镜像中的数据。

所以，如果你看到 `lsblk` 命令中有 `sr0` 设备，并且你知道在你的虚拟环境中挂载了 `CentOS-7-x86_64-DVD-1810.iso` 镜像文件，那么 `sr0` 很可能就是指向这个 ISO 镜像的。



### 16.2 挂载的经典案例

#### 16.2.1 如何增加一块硬盘

1. 在虚拟机中添加硬盘。
2. 进行分区。
3. 对新分区进行格式化。
4. 将新分区挂载到特定目录。
5. 设置自动挂载。

#### 16.2.2 虚拟机增加硬盘步骤

1. **添加硬盘**：在虚拟机设置中添加硬盘并设置大小，完成后重启系统。
2. 分区：使用 `fdisk /dev/sdb`对 `/sdb` 进行分区。
   - `m` 显示命令列表。
   - `p` 显示磁盘分区。
   - `n` 新增分区。
   - `d` 删除分区。
   - `w` 写入并退出。
3. **格式化磁盘**：使用 `mkfs -t ext4 /dev/sdb1` 对新分区进行格式化。

`**mkfs**` 不是一个缩写，而是一个命令名，代表 **"make filesystem"**，即“创建文件系统”。

**中文意思**：`mkfs` 命令用于在一个分区上创建文件系统，它可以创建多种类型的文件系统，如 `ext2`、`ext3`、`ext4`、`xfs` 等。

**选项解释**：

- `-t`：该选项后面跟文件系统类型。用户可以指定要创建的文件系统类型。
- `ext4`：是一种文件系统类型，是 `ext3` 的进一步发展。`ext4` 提供了更多的特性和更好的性能。
- `/dev/sdb1`：指定在哪个分区上创建文件系统。这里，它指的是第二块硬盘的第一个分区。

**命令示例**：

```
mkfs -t ext4 /dev/sdb1
```

这个命令会在 `/dev/sdb1` 分区上创建一个 `ext4` 类型的文件系统。在使用这个命令前，请确保 `/dev/sdb1` 分区已经存在，并且所有重要数据已经备份，因为创建文件系统会格式化分区，导致所有已有数据丢失。



![image-20240122181837084](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240122181837084.png)

4. **挂载**：将新分区挂载到特定目录，例如 `mount /dev/sdb1 /newdisk`。



当您在修改 `/etc/fstab` 文件后输入 `mount -a`，这个命令的意思是挂载 `/etc/fstab` 文件中指定的所有文件系统。

`/etc/fstab` 是系统启动时用来挂载文件系统的配置文件，其中包含了各个文件系统的信息，如设备名、挂载点、文件系统类型、挂载选项等。

`mount -a` 命令会读取 `/etc/fstab` 文件的内容，并尝试挂载其中列出的所有文件系统。这个命令常用于：

1. 系统启动时自动挂载文件系统。
2. 手动修改 `/etc/fstab` 后，可以通过 `mount -a` 快速应用更改，而无需重启系统。

请注意，`mount -a` 不会重新挂载已经挂载的文件系统，它只会挂载 `/etc/fstab` 中列出但当前未挂载的文件系统。此外，如果 `/etc/fstab` 中的某些文件系统包含 `noauto` 选项，则 `mount -a` 命令会忽略这些文件系统，不会进行挂载。



5. **自动挂载**：修改 `/etc/fstab` 文件，添加挂载项并执行 `mount -a`。



~~~shell
[root@hspEdu01 newdisk]# cat /etc/fstab 

#
# /etc/fstab
# Created by anaconda on Fri Jan 12 09:42:02 2024
#
# Accessible filesystems, by reference, are maintained under '/dev/disk'
# See man pages fstab(5), findfs(8), mount(8) and/or blkid(8) for more info
#
UUID=86cd80bb-5d8b-4bb6-bd02-6fe959b12138 /                       ext4    defaults        1 1
UUID=4e6e9b24-ef6a-4024-956b-567019ad1666 /boot                   ext4    defaults        1 2
UUID=ccd0bb15-86af-4ad8-8c51-48c3e5d4305e swap                    swap    defaults        0 0
/dev/sdb1                                 /newdisk                ext4    defaults        0 0
[root@hspEdu01 newdisk]# 

~~~

该 `/etc/fstab` 配置文件定义了系统启动时或使用 `mount -a` 命令时应挂载的文件系统。文件中的每一行代表一个文件系统，每行的各个字段具有特定的含义。下面是各列的解释：

1. **设备**：这列通常显示文件系统所在的设备或分区。在你的例子中，使用了 `UUID`（通用唯一标识符）来唯一标识设备。例如，`UUID=87cd80bb-5d8b-4bb6-bd02-6fe959b12138` 是一个分区的唯一标识。使用 UUID 的好处是即使设备名（如 `/dev/sdb1`）改变，系统也能准确挂载正确的分区。确实，你也可以使用传统的设备名（如 `/dev/sdb1`），但使用 UUID 可以提供更高的稳定性。
2. **挂载点**：文件系统挂载的目录。例如 `/` 表示根文件系统，`/boot` 表示启动分区。
3. **文件系统类型**：分区的文件系统类型，如 `ext4`、`swap` 等。
4. **挂载选项**：定义了挂载时的各种设置，`defaults` 是一组默认的挂载选项。
5. **dump**：这列用来决定是否需要通过 `dump` 命令备份文件系统。`0` 表示不备份，`1` 表示需要备份。
6. **pass (fsck order)**：这列用于 `fsck` 命令（文件系统检查）。`0` 表示不检查，`1` 表示首先检查这个文件系统，`2` 表示在 root 文件系统之后检查。在 root 文件系统 (`/`) 上，这个数字通常是 `1`，其他文件系统通常是 `2` 或更大。

总结，`/etc/fstab` 中的每一行都定义了一个文件系统及其挂载方式。使用 UUID 而不是传统的设备名（如 `/dev/sdb1`）可以使系统配置更加稳定，因为 UUID 不会因为添加新硬盘或更改启动顺序而改变。



### 16.3 磁盘情况查询

#### 16.3.1 查询系统整体磁盘使用情况

#### df -h

- 使用命令：`df -h` 查看整体磁盘使用情况。

`df` 是缩写，通常被认为是 "disk free" 或 "disk filesystem" 的缩写。

**中文意思**：`df` 命令的中文意思是“磁盘空间使用情况”或“显示磁盘空间使用情况”。

这个命令用于显示Linux系统中每个挂载的文件系统的磁盘使用情况，包括总空间、已使用空间、可用空间以及使用百分比等信息。

**常用选项：**

`df` 命令提供了多个选项来定制输出或获取特定类型的信息。以下是一些常用的选项：

1. **`-a`**:
   - 显示所有文件系统的磁盘使用情况，包括通常不显示的系统特殊文件系统。
2. **`-h`**:
   - 以易读的格式（如 KB、MB、GB）显示磁盘空间大小，而不是以字节数显示。
3. **`-H`**:
   - 类似于 `-h`，但使用 1000 为基数而不是 1024（1GB = 10^9 bytes）。
4. **`-i`**:
   - 显示inode信息而不是块使用情况。
5. **`-k`**:
   - 显示每个块的大小为 1024 字节，而不是默认的 512 字节。
6. **`-l`**:
   - 仅显示本地文件系统的磁盘使用情况。
7. **`-T`**:
   - 在输出中显示每个文件系统的类型。
8. **`--total`**:
   - 在输出的最后添加一个总计行。
9. **`-t type`**:
   - 仅显示指定类型的文件系统。
10. **`-x type`**:
    - 排除指定类型的文件系统。

**具体用法**：

- 执行 `df` 命令将显示系统中每个挂载的文件系统的总空间、已使用空间、可用空间以及挂载点。
- `-h` 选项（`df -h`）表示以易读的格式（如 K、M、G）显示空间大小，而不是以字节数显示。

例如，执行 `df -h` 命令可能会输出如下信息：

```
[root@hspEdu01 newdisk]# df -h
文件系统        容量  已用  可用 已用% 挂载点
/dev/sda3        17G  5.8G   11G   37% /
devtmpfs        975M     0  975M    0% /dev
tmpfs           991M     0  991M    0% /dev/shm
tmpfs           991M   11M  980M    2% /run
tmpfs           991M     0  991M    0% /sys/fs/cgroup
/dev/sdb1       991M  2.6M  922M    1% /newdisk
/dev/sda1       976M  134M  776M   15% /boot
.host:/         532G  434G   99G   82% /mnt/hgfs
tmpfs           199M  4.0K  199M    1% /run/user/42
tmpfs           199M   20K  199M    1% /run/user/0
/dev/sr0        4.3G  4.3G     0  100% /run/media/root/CentOS 7 x86_64

```

这个输出展示了系统中每个文件系统的大小、已用空间、可用空间、使用百分比以及挂载点。







#### 16.3.2 查询指定目录的磁盘占用情况

- 使用命令：`du -h` 查看指定目录的磁盘占用情况。
- 选项说明：
  - `-s`：显示指定目录的总占用大小。
  - `-h`：以易读的格式显示大小。
  - `-a`：包括文件。
  - `--max-depth=1`：子目录深度为 1。
  - `-c`：显示总计。



`du -h --max-depth=1 /opt`

~~~
[root@hspEdu01 opt]# du -h --max-depth=1 /opt #该命令只统计深度=1的目录/文件夹
163M	/opt/vmware-tools-distrib
4.0K	/opt/rh
217M	/opt  #这里是统计的/opt这个文件的总计大小
[root@hspEdu01 opt]# du -ha --max-depth=1 /opt #该命令统计深度=1的目录/文件夹和文件！
163M	/opt/vmware-tools-distrib
54M	/opt/VMwareTools-10.3.10-13959562.tar.gz
892K	/opt/浴衣.jpg
4.0K	/opt/rh
217M	/opt
[root@hspEdu01 opt]# du -hac --max-depth=1 /opt #增加 -c 选项，多一个总用量，更明确
163M	/opt/vmware-tools-distrib
54M	/opt/VMwareTools-10.3.10-13959562.tar.gz
892K	/opt/浴衣.jpg
4.0K	/opt/rh
217M	/opt
217M	总用量

~~~



### `du` 命令

`du` 命令是一个用于估算文件空间使用量的常用工具。它可以用来获取文件、目录占用磁盘空间的大小。

**缩写：**

- `du` 代表 "disk usage"。**usage**	n.使用;(词语的)用法，惯用法;利用;利用率   /美/ˈjuːsɪdʒ/

**中文意思：**

- `du` 的中文意思是“磁盘使用情况”。

**常用选项：**

1. **`-h`**（`--human-readable`）：以易读的格式显示文件大小（例如 KB、MB 或 GB）。
2. **`-a`**（`--all`）：含文件，显示所有文件和目录的磁盘使用情况，而不仅仅是目录。
3. **`-s`**（`--summarize`）：指定目录占用大小汇总，仅显示总计，即当前目录的总磁盘使用量。
4. **`--max-depth=N`**：子目录深度，显示目录树下各级目录（直至N层）的磁盘使用情况。
5. **`-c`**（`--total`）：除了显示各目录或文件的磁盘使用量之外，还在最后一行显示它们的总和。

**用法：**

- 获取目录的磁盘使用量：

  ```
  bashCopy code
  du /path/to/directory
  ```

  这将显示指定目录及其子目录的磁盘使用量。

- 以易读的格式显示目录的磁盘使用量：

  ```
  bashCopy code
  du -h /path/to/directory
  ```

  这将以 KB、MB 或 GB 的形式显示大小。

- 显示目录及其直接子目录的磁盘使用量：

  ```
  bashCopy code
  du --max-depth=1 -h /path/to/directory
  ```

  这将显示目录和其直接子目录的磁盘使用量。

- 显示目录总磁盘使用量：

  ```
  bashCopy code
  du -sh /path/to/directory
  ```

  选项 `-s` 仅显示总计，`-h` 使输出易于阅读。

`du` 命令非常有用于管理磁盘空间，特别是当您需要找出占用大量磁盘空间的文件或目录时。



#### 直接输入`du -h /opt `是什么意思

ChatGPT

输入 `du -h /opt` 命令的意思是：查看 `/opt` 目录及其子目录下所有文件和目录占用的磁盘空间，并以易读的格式（例如 KB、MB、GB）显示每个文件和目录的大小。

这里的命令参数含义如下：

- `du`：是 "disk usage" 的缩写，用于估算文件空间的使用量。
- `-h`：是 "human-readable" 的缩写，意思是以易于阅读的方式显示文件大小（自动选择合适的单位）。
- `/opt`：指定要查看磁盘使用情况的目录，这里是 `/opt` 目录。

这个命令通常用于评估特定目录下文件和子目录的磁盘使用情况，帮助你了解磁盘空间的使用状况。

#### du -h /opt 默认 也会查看所有子目录的吗？即所有的文件？

ChatGPT

是的，当您使用 `du -h /opt` 命令时，默认情况下，它会递归地查看 `/opt` 目录下所有子目录和文件的磁盘使用情况。每个子目录和文件的磁盘使用量将被累加并显示。

命令将列出 `/opt` 目录中每个子目录的总磁盘使用量，以及 `/opt` 目录本身的总磁盘使用量。如果您想查看每个文件的磁盘使用情况，可以添加 `-a`（或 `--all`）选项，这样命令会显示目录中每个文件的磁盘使用量。

如果您只对 `/opt` 目录的总磁盘使用量感兴趣，而不关心子目录的具体细节，您可以使用 `-s`（或 `--summarize`）选项来仅显示总计，例如 `du -sh /opt`。

### 16.4 磁盘情况-工作实用指令

1. 统计 `/opt` 文件夹下文件的个数：`ls -l /opt | grep "^-" | wc -l`
2. 统计 `/opt` 文件夹下目录的个数：`ls -l /opt | grep "^d" | wc -l`
3. 统计 `/opt` 文件夹下文件的个数，包括子文件夹里的。

​	`ls -lR /opt | grep "^-" | wc -l`

4. 统计 `/opt` 文件夹下目录的个数，包括子文件夹里的。

 `ls -lR /opt | grep "^d" | wc -l`

5. 以树状显示目录结构 `tree /home`,注意如果没有tree，则使用 **`yum install tree`**安装

   ~~~
   [root@hspEdu01 opt]# tree /opt
   bash: tree: 未找到命令...
   [root@hspEdu01 opt]# yum install tree
   ... 后面有提示，就输入`y`
   
   [root@hspEdu01 opt]# tree /home/
   /home/
   ├── jack
   ├── milan
   ├── test
   └── zwj
   
   4 directories, 0 files
   [root@hspEdu01 opt]# 
   ~~~

   

   ![image-20240122212819171](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240122212819171.png)

### `wc` 命令

`wc` 命令是一个非常实用的文本处理工具，它用于计算字数（word count）。`wc` 命令可以计算文本文件的行数、字数和字节（或字符）数。

**缩写：**

- `wc` 代表 "word count"。

**中文意思：**

- `wc` 的中文意思是“字数统计”。

**常用选项：**

1. **`-l`**（`--lines`）：仅显示行数。
2. **`-w`**（`--words`）：仅显示字数。
3. **`-c`**（`--bytes`）：显示字节（或字符）数。
4. **`-m`**：显示字符数（如果与 `-c` 不同）。
5. **`-L`**（`--max-line-length`）：显示最长行的长度。

**用法：**

- 计算文件的行数：

  ```
  bashCopy code
  wc -l filename
  ```

  这将会显示文件 `filename` 中的行数。

- 计算文件的字数：

  ```
  bashCopy code
  wc -w filename
  ```

  这将会显示文件 `filename` 中的字数。

- 计算文件的字符数：

  ```
  bashCopy code
  wc -c filename
  ```

  这将会显示文件 `filename` 中的字符数（字节数）。

- 同时显示行数、字数和字节（字符）数：

  ```
  bashCopy code
  wc filename
  ```

  不带任何选项，`wc` 命令会同时显示行数、字数和字节（字符）数。

`wc` 命令常用于处理和分析文本文件，它可以快速提供文本内容的基本统计信息。





## 17 Linux 实操篇-网络配置

### NAT知识科普

**问题:** 可以将宿主机（物理主机）与其虚拟机在同一虚拟网络（网段）中进行直接通信的情况理解为宿主机具有两个IP地址吗？一个是面向实际互联网访问所使用的IP地址，例如WLAN 2的IP地址192.168.0.38，另一个是面向虚拟网络的虚拟IP地址，即VMnet8适配器的IP地址192.168.2.1，这样理解是否正确？

**回答:** 是的，你的理解是正确的。宿主机（物理主机）可以具备多个网络接口，每个接口都可以配置自己的IP地址。具体来说，在你的例子中：

- 宿主机的一个网络接口配置有WLAN 2的IP地址192.168.0.38，此IP地址用于宿主机与外部网络（例如家庭网络或互联网）的通信。
- 同时，宿主机也配置有一个虚拟的网络接口，即VMware Network Adapter VMnet8，它的IP地址为192.168.2.1。这个虚拟网络接口充当宿主机与VMnet8虚拟网络中虚拟机之间通信的桥梁。

因此，宿主机能够同时与外部网络进行通信（通过WLAN 2接口）以及与VMnet8虚拟网络内的虚拟机进行通信（通过VMnet8接口）。这两个网络是分隔开的，它们在网络层上是隔离的，除非进行了特定的路由规则或网络共享配置以便它们之间的连接。

---



**问题:** 在VMnet8虚拟网络中，宿主机的IP地址被配置为192.168.2.1。如果宿主机尝试使用其物理网络接口（例如WLAN 2，IP地址为192.168.0.38）的IP地址来ping虚拟机（假设虚拟机的IP地址为192.168.2.131），这种通信会成功吗？

**回答:** 在这种情况下，宿主机与虚拟机之间的通信实际上是通过VMnet8虚拟网络适配器的IP地址（即192.168.2.1）进行的。这是因为宿主机和虚拟机都配置在VMnet8虚拟网络上，它们之间的通信是通过这个虚拟网络适配器进行的。宿主机的物理网络适配器（比如WLAN 2，IP地址192.168.0.38）通常用于与外部网络（如互联网或本地局域网）的通信，并非用于与虚拟网络内部的虚拟机通信。因此，即使宿主机具有面向实际互联网的IP地址，它在与虚拟机通信时通常会使用VMnet8适配器的IP地址，这样可以确保宿主机和虚拟机之间的通信是隔离并且独立于宿主机的物理网络环境的。

------

**问题:** 如果两个设备分别位于不同的网段，比如一个设备的IP地址是192.168.1.10（子网掩码255.255.255.0），另一个设备的IP地址是192.168.2.10（子网掩码255.255.255.0），它们之间能否通过ping命令直接通信？

**回答:** 通常情况下，如果两个设备位于不同的网段，它们无法直接通信。这是因为网络设备（如路由器）会根据IP地址和子网掩码决定数据包的传输路径。如果没有路由器或其他路由设备来转发它们之间的数据包，位于不同网段的设备通常不能直接通信。然而，在某些特殊配置下，比如使用了特定的路由规则或网络地址转换（NAT），不同网段的设备也可能通信。在VMnet8虚拟网络的具体案例中，由于宿主机和虚拟机被配置在同一个虚拟网络（即同一网段）中，它们可以直接通信，无需通过路由器。如果宿主机的另一个网络适配器处于不同的网段，则通常需要特定的路由或网络共享配置来实现与虚拟机的通信。











###  17. 网络配置和主机名解析

### Linux 网络配置原理图



![image-20240122224959655](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240122224959655.png)

#### 17.1 配置静态IP地址



vi /etc/sysconfig/network-scripts/ifcfg-ens33

**注意事项：**

- **重启虚拟机后发现配置在 `/etc/sysconfig/network-scripts/ifcfg-ens33` 的ipv4地址192.168.200.130没生效，只需要重启网络服务或者重启系统生效即可，执行下面的指令**：

- **service network restart** 

  ```
  service network restart 或 reboot
  ```

---



- **说明**： 直接修改配置文件来指定 IP, 并可以连接到外网（程序员推荐）。

- **配置步骤**：

  1. 编辑网络配置文件：

     ```
     
     disable
     英
     /dɪsˈeɪbl/
       
     美
     /dɪsˈeɪbl/
      
     vt.
     使伤残;使无效;使残废;使丧失能力;使不能运转
     
     
     vi /etc/sysconfig/network-scripts/ifcfg-ens33
      
     ```
  
  2. 将 IP 地址配置为静态，例如设置 IP 地址为 `192.168.200.130`。



# 网络配置ifcfg-ens33文件中，注意等号右边的值一定要添加引号才能识别，否则会出问题！



**网络配置ifcfg-ens33文件详情：**

vi /etc/sysconfig/network-scripts/ifcfg-ens33

~~~
#注意等号右边的值一定要添加引号才能识别，否则会出问题！

TYPE="Ethernet"
PROXY_METHOD="none"
BROWSER_ONLY="no"
BOOTPROTO="static"
DEFROUTE="yes"
IPV4_FAILURE_FATAL="no"
IPV6INIT="yes"
IPV6_AUTOCONF="yes"
IPV6_DEFROUTE="yes"
IPV6_FAILURE_FATAL="no"
IPV6_ADDR_GEN_MODE="stable-privacy"
NAME="ens33"
UUID="2e5a5c25-b0b3-489a-aecd-1461cf86d9d8"
DEVICE="ens33"
ONBOOT="yes"
#IP 地址
IPADDR=192.168.200.130
#网关
GATEWAY=192.168.200.2
#域名解析器
DNS1=192.168.200.2
#子网掩码，不写默认就是255.255.255.0
NETMASK=255.255.255.0

~~~

**ens33网络配置文件的等号右边的值在添加了引号后，使用ifconfig才会输出ens33网络配置文件中，我们自己手动配置的ipv4地址！！才会生效！此时即使关机在重新启动虚拟机，ens33网络配置文件中自己配置的IPV4地址也生效！**

![image-20240129044243169](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240129044243169.png)

- **ifcfg-ens33 文件说明**：
  - `DEVICE=eth0`：接口名（设备，网卡）
  - `HWADDR=00:0C:2x:6x:0x:xx`：MAC 地址
  - `TYPE=Ethernet`：网络类型（通常是 Ethernet）
  - `UUID=926a57ba-92c6-4231-bacb-f27e5e6a9f44`：随机 ID
  - `ONBOOT=yes`：系统启动的时候网络接口是否有效（yes/no）
  - `BOOTPROTO=static`：IP 的配置方法（none|static|bootp|dhcp）
  - `IPADDR=192.168.200.130`：IP 地址
  - `GATEWAY=192.168.200.2`：网关
  - `DNS1=192.168.200.2`：域名解析器

~~~
# 网络接口类型，这里是以太网
TYPE=Ethernet
# 代理设置，这里表示不使用代理
PROXY_METHOD=none
# 此设置仅用于图形用户界面，这里表示非仅浏览器模式
BROWSER_ONLY=no
# 启动协议，设置为dhcp表示IP地址通过动态主机配置协议（DHCP）自动获取，也可设置为static表示使用固定的IP地址
BOOTPROTO=static
# 是否作为默认路由，这里是是
DEFROUTE=yes
# IPv4连接失败是否致命，这里设置为不致命
IPV4_FAILURE_FATAL=no
# 是否初始化IPv6设置
IPV6INIT=yes
# 是否允许IPv6自动配置
IPV6_AUTOCONF=yes
# IPv6是否作为默认路由
IPV6_DEFROUTE=yes
# IPv6连接失败是否致命
IPV6_FAILURE_FATAL=no
# IPv6地址生成模式，这里设置为stable-privacy
IPV6_ADDR_GEN_MODE=stable-privacy
# 网络接口名称
NAME=ens33
# 网络接口的唯一标识符
UUID=2e5a5c25-b0b3-489a-aecd-1461cf86d9d8
# 设备名称，对应网络接口名称
DEVICE=ens33
# 系统启动时是否激活该网络接口
ONBOOT=yes
~~~



- **重启网络服务或者重启系统生效**：

  ```
  service network restart 或 reboot
  ```



**VMware虚拟网络编辑器配置如下：**

**==============================VMware虚拟网络编辑器配置开始==============================**

![image-20240206013056054](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240206013056054.png)

![image-20240206013348906](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240206013348906.png)

 

![image-20240206014040497](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240206014040497.png)



**==============================VMware虚拟网络编辑器配置结束==============================**

通过上述配置后，即使在网络适配器选项中，**VMware Network Adapter VMnet8**之前配置的是自动获取IP地址，也会被更改为下面的配置，这里**不用**手动输入IP地址和子网掩码，**会自动分配！**



![image-20240123000850098](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240123000850098.png)





测试

1. **获取配置后的IP** 

2. **宿主机 ping 虚拟机192.168.200.130**

**宿主机** IP有两个，注意，此时测试时宿主机面向虚拟网络的IP地址为192.168.200.1，因为一般情况下，不做特殊处理，同网段的才可以互相通信

~~~
C:\Users\yangd>ipconfig

Windows IP 配置

以太网适配器 VMware Network Adapter VMnet1:

   连接特定的 DNS 后缀 . . . . . . . :
   本地链接 IPv6 地址. . . . . . . . : fe80::4014:45fd:771c:709e%16
   自动配置 IPv4 地址  . . . . . . . : 169.254.86.133
   子网掩码  . . . . . . . . . . . . : 255.255.0.0
   默认网关. . . . . . . . . . . . . :

以太网适配器 VMware Network Adapter VMnet8:

   连接特定的 DNS 后缀 . . . . . . . :
   IPv4 地址 . . . . . . . . . . . . : 192.168.200.1
   子网掩码  . . . . . . . . . . . . : 255.255.255.0
   默认网关. . . . . . . . . . . . . :

无线局域网适配器 WLAN 2:

   连接特定的 DNS 后缀 . . . . . . . :
   IPv4 地址 . . . . . . . . . . . . : 192.168.43.191
   子网掩码  . . . . . . . . . . . . : 255.255.255.0
   默认网关. . . . . . . . . . . . . : 192.168.43.1

C:\Users\yangd>ping 192.168.200.130

正在 Ping 192.168.200.130 具有 32 字节的数据:
来自 192.168.200.130 的回复: 字节=32 时间<1ms TTL=64
来自 192.168.200.130 的回复: 字节=32 时间<1ms TTL=64
来自 192.168.200.130 的回复: 字节=32 时间<1ms TTL=64
来自 192.168.200.130 的回复: 字节=32 时间<1ms TTL=64

192.168.200.130 的 Ping 统计信息:
    数据包: 已发送 = 4，已接收 = 4，丢失 = 0 (0% 丢失)，
往返行程的估计时间(以毫秒为单位):
    最短 = 0ms，最长 = 0ms，平均 = 0ms

C:\Users\yangd>

~~~



3. **虚拟机192.168.200.130 ping 宿主机 192.168.200.1** 注意需要关闭宿主机公用网络防火墙！！！
3. 即使宿主机公用网络防火墙是打开状态，此时只有配置正确虚拟机就可以正常上网(可以ping通百度)，也可以使用Xshell7正常连接上Linux虚拟机，只不过**此时ping不通宿主机**的VMNet8虚拟网卡

![image-20240206012502135](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240206012502135.png)

~~~
#如果没有关闭宿主机防火墙！下面这里就不会ping通
[root@hspEdu100 ~]# ping f2
PING F2 (192.168.200.1) 56(84) bytes of data.
^C
--- F2 ping statistics ---
3 packets transmitted, 0 received, 100% packet loss, time 2000ms

~~~



~~~
[root@hspEdu01 ~]# ping 192.168.200.1
PING 192.168.200.1 (192.168.200.1) 56(84) bytes of data.
64 bytes from 192.168.200.1: icmp_seq=1 ttl=128 time=0.305 ms
64 bytes from 192.168.200.1: icmp_seq=2 ttl=128 time=0.187 ms
64 bytes from 192.168.200.1: icmp_seq=3 ttl=128 time=0.204 ms
64 bytes from 192.168.200.1: icmp_seq=4 ttl=128 time=0.185 ms
^C
--- 192.168.200.1 ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3000ms
rtt min/avg/max/mdev = 0.185/0.220/0.305/0.050 ms

~~~

![image-20240123000701299](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240123000701299.png)



#### 17.2 设置主机名和 hosts 映射

- **17.2.1 设置主机名**：
  - 为方便记忆和管理，可以给 Linux 系统设置或修改主机名。
  - 查看当前主机名：`hostname`
  - 修改主机名配置文件：`vi /etc/hostname`
  - 修改后重启系统生效。
- **17.2.2 设置 hosts 映射**：
  - Hosts 文件用于将主机名映射到 IP 地址。
  - 在 Windows 中编辑：`C:\Windows\System32\drivers\etc\hosts`，例如添加 `192.168.200.130 hspedu100`。
  - 在 Linux 中编辑：`vi /etc/hosts`，例如添加 `192.168.200.1 ThinkPad-PC`。

**注意细节：**

   `hosts` 文件中配置的映射关系是**不区分大小写**的。这意味着，在 `hosts` 文件中，域名 `Example.com`、`example.com` 和 `EXAMPLE.COM` 会被视为相同的域名。

这种行为与 DNS 协议是一致的，DNS 协议规定域名是不区分大小写的。因此，无论是在 `hosts` 文件还是在 DNS 查询中，域名都应该被视为不区分大小写的字符串。当处理域名时，通常会将其转换为小写，以确保一致性和可预测性。

   无论是在 Windows 10 还是 Linux 系统中，`hosts` 文件中配置的映射关系都是不区分大小写的。这是因为域名系统（DNS）规范本身就是不区分大小写的，这个规范被 `hosts` 文件所遵循。无论你在 `hosts` 文件中如何大小写混合地写入域名，解析时都会被视为相同的域名。

  因此，在 Windows 或 Linux 的 `hosts` 文件中：

```
Copy code192.168.1.10    example.com
192.168.1.10    Example.com
192.168.1.10    EXAMPLE.com
```

这些条目实际上都是等价的。

#### 17.3 主机名解析过程分析

- **17.3.1 Hosts 文件**：
  - 一个文本文件，记录 IP 和 Hostname (主机名) 的映射关系。
- **17.3.2 DNS 解析过程**：
  - DNS 是互联网上用于将域名和 IP 地址相互映射的分布式数据库。
  - 用户在浏览器输入 `www.baidu.com` 时，浏览器和操作系统会按照一定的顺序查找对应的 IP 地址，包括浏览器缓存、DNS 缓存、hosts 文件以及询问 DNS 服务器。



**域名解析的步骤**

当用户在浏览器输入 `www.baidu.com` 时，系统会按照以下顺序进行域名解析：

1. **浏览器缓存**：
   - 浏览器首先检查自己的缓存中是否有 `www.baidu.com` 的 DNS 记录。如果有，浏览器直接使用这个缓存的 IP 地址完成解析。
2. **本地解析器缓存**：
   - 如果浏览器缓存中没有找到，系统会检查本地解析器（操作系统层面）的 DNS 缓存。如果这里有缓存的 DNS 记录，系统会使用这个 IP 地址完成解析。
   - 在 Windows 系统中，可以通过命令 `ipconfig /displaydns` 查看本地 DNS 解析器缓存的内容，通过 `ipconfig /flushdns` 命令清空本地 DNS 缓存。
3. **hosts 文件**：
   - 如果本地 DNS 解析器缓存中也没有找到相应的记录，系统会检查 `hosts` 文件。如果 `hosts` 文件中有 `www.baidu.com` 对应的条目，系统会使用这个条目中指定的 IP 地址。
4. **远程 DNS 服务器**：
   - 如果上述步骤都未能解析域名，系统会向配置的 DNS 服务器发送解析请求。DNS 服务器会进行递归查询或迭代查询，直到找到域名对应的 IP 地址。
5. **DNS 解析的结果**：
   - 一旦获得 IP 地址，浏览器就会向该地址发送 HTTP 请求，开始加载网页。

#### 17.4 DNS解析示意图

这里少了一个先找浏览器缓存的步骤，但如果是直接ping，那么这个图是对的

![image-20240123175149741](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240123175149741.png)

此步骤说明了从用户输入域名到浏览器获取 IP 地址的整个过程。如果在本地找到了 DNS 记录，解析过程会很快；如果需要向远程 DNS 服务器请求解析，可能会稍慢，但通常这个过程也非常迅速。

这个过程确保了域名可以被解析成 IP 地址，而 IP 地址是网络上设备的唯一标识，使得浏览器能够连接到正确的服务器，从而加载并显示用户请求的网页。





#  18. Linux 实操篇-进程管理

### 18.1 基本介绍

1. **进程定义**：在 Linux 中，每个执行的程序称为一个进程。每个进程拥有一个唯一的进程号 (pid)。
2. 进程类型：
   - 前台进程：用户可见，可直接与用户交互。
   - 后台进程：在后台执行，用户不直接交互，如系统服务。
3. **服务进程**：通常作为后台进程存在，为系统提供核心功能，如网络、安全等。




**进程和线程**都是计算机中的并发执行的活动单元，但它们之间有本质的区别：

1. **进程（Process）**：
   - 进程是操作系统进行资源分配和调度的基本单位。
   - 每个进程都有自己独立的地址空间、内存、数据栈以及其他记录其运行轨迹的辅助数据。
   - 进程间的通信（IPC）需要特定的机制，如管道、信号、套接字等。
2. **线程（Thread）**：
   - 线程是进程中的实际运行单位，是 CPU 调度和分派的基本单位。
   - 同一进程中的多个线程共享该进程的地址空间和资源，如文件描述符和全局变量等。
   - 线程间的通信可以直接通过读写进程数据段（如全局变量）来进行，因此同一进程的线程之间的数据共享和通信更加方便。

**关系**：

- 进程和线程的主要差别在于它们是不同的操作系统资源管理方式。一个程序至少有一个进程,一个进程至少有一个线程。
- 线程作为轻量级的进程，占用资源更少，创建、撤销的开销小，但并发性高。
- 多线程可以并发执行，增加了程序的处理性能。

**举例**：

- 假设你的电脑是一家工厂，那么每个运行的程序（比如 Word、Excel、浏览器）就是一个进程。这家工厂（电脑）为每个进程（程序）分配了必要的资源（比如内存、计算时间）。
- 在每个程序内部，可能会有多个任务需要同时进行，比如浏览器可能同时加载多个网页。每个这样的任务可以看作是一个线程。所有这些线程都在同一进程内共享资源，但它们各自执行自己的任务。





### 18.2 显示系统执行的进程 - `ps` 命令

- **基本介绍**：`ps` 命令用于展示当前系统中执行的进程及其状态。

**`ps`**是一个缩写，代表 "Process Status"（进程状态）。它是一个用于显示当前系统中活动进程的信息的命令。通过使用 `ps` 命令，可以获取进程的各种信息，包括 PID（进程ID）、TTY（终端类型）、时间（进程占用CPU的时间）和 CMD（启动进程的命令）等。

**用法示例**：

- `ps`：显示当前终端的进程。
- `ps -e`：显示所有进程。
- `ps -u [用户名]`：显示指定用户的进程。
- `ps -aux`：显示所有进程的详细信息。

`ps` 命令是 Linux 和 Unix 系统上常用的进程监控工具，特别适用于系统管理和调试。



使用 `ps` 命令可以查看系统当前的进程状态，以及各个进程的详细信息。`ps –aux|grep xxx` 是一个常用的组合命令，用于过滤和显示特定的进程信息。

**命令示例：**

```
ps –aux | grep xxx
```

- 比如想查看是否有 `sshd` 服务正在运行，可以使用：

```
ps –aux | grep sshd
```



![image-20240126010001412](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240126010001412.png)


上面这个问题是由于命令中的破折号（dash）字符不正确导致的。在您提供的两个命令中：

1. 第一个命令：

   ```
   csharpCopy code
   [root@hspEdu100 ~]# ps -aux | grep sshd
   ```

   这个命令正确执行了，因为它使用了正确的短破折号 `-`。

2. 第二个命令：

   ```
   csharpCopy code
   [root@hspEdu100 ~]# ps –aux | grep sshd
   ```

   这个命令产生了错误，原因可能是使用了长破折号 `–`（通常是在文本编辑器或处理器中输入时生成的），而不是标准的短破折号 `-`。



**命令输出字段解释：**

- **USER**: 进程所属的用户名称。
- **PID**: 进程的ID号。
- **%CPU**: 进程占用的CPU百分比。
- **%MEM**: 进程占用的物理内存百分比。
- **VSZ**: 进程占用的虚拟内存大小（单位：KB）。
- **RSS**: 进程占用的物理内存大小（单位：KB）。
- **TT**: 终端名称，如果有的话，否则显示为缩写。
- STAT: 进程状态，其中：
  - **S**: 睡眠状态
  - **s**: 会话的先导进程
  - **N**: 比普通优先级更低的优先级
  - **R**: 正在运行
  - **D**: 短期等待
  - **Z**: 僵死进程
  - **T**: 被跟踪或者被停止
- **STARTED**: 进程的启动时间。
- **TIME**: 进程使用CPU的总时间。
- **COMMAND**: 启动进程所用的命令和参数。如果命令过长，可能会被截断显示。

该命令输出提供了关于系统进程的详细信息，是系统管理和故障排查的重要工具。



`PPID` 和 `PID` 都是缩写：

- **PID**: Process ID，即进程标识符。在操作系统中，每个进程都有一个唯一的数字标识符，称为PID。这是操作系统用来管理进程的一种方式。
- **PPID**: Parent Process ID，即父进程标识符。这代表创建当前进程的父进程的PID。在进程树中，每个进程（除了最初的系统进程）都有一个父进程。通过PPID，可以追溯一个进程的“家族树”。

---

<img src="https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240123203649813.png" alt="alt_text_here" style="float: left; margin-right: 10px;" />

对应：

![image-20240123203651985](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240123203651985.png)

---

<img src="https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240123203947955.png" alt="alt_text_here" style="float: left; margin-right: 10px;" />

对应：

![image-20240123203951847](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240123203951847.png)



`ps -ef` 是一个在 Unix 和类 Unix 系统中常用的命令，用于显示当前系统中活动进程的详细信息。这个命令的输出提供了每个进程的快照。以下是该命令选项的详细解释：

- `ps`：这是 "process status" 的缩写，是用来显示当前运行的系统进程信息的命令。
- `-e`：这个选项告诉 `ps` 命令显示所有进程。没有 `-e` 选项，`ps` 通常只显示当前用户和当前终端相关的进程。
- `-f`：这个选项表示 "full format"，意味着显示完整格式的信息。这会提供关于每个进程的更详细信息，而不仅仅是基本信息。

使用 `ps -ef` 命令通常会显示如下信息：

- **UID**：启动进程的用户 ID。
- **PID**：进程 ID。
- **PPID**：父进程 ID（即创建这个进程的进程的 ID）。
- **C**：CPU 利用率。
- **STIME**：进程开始时间。
- **TTY**：与进程关联的终端类型。
- **TIME**：进程占用的 CPU 时间。
- **CMD**：启动进程的命令名称或命令行。

这个命令非常有用，可以帮助系统管理员查看系统中所有运行的进程及其相关信息，进行故障诊断，了解系统运行状态等。

---



### 18.3 终止进程：`kill` 和 `killall`

### 

#### 18.3.1 介绍

在Linux系统中，若某个进程执行中需要被终止，或者它已消耗了大量的系统资源，此时可以考虑终止该进程。可以使用`kill`命令来实现。

#### 18.3.2 基本语法

- `kill [选项] 进程号`：通过进程号杀死/终止进程。
- `killall 进程名称`：通过进程名称杀死进程，也支持通配符，这在系统因负载过大而变得很慢时很有用。 支持通配符，相关的进程一条线都kill掉，快速清理内存

#### 18.3.3 常用选项

- `-9`：表示强迫进程立即停止。

#### 18.3.4 最佳实践

- 案例 1：踢掉某个非法登录用户

  ```
  kill 进程号  # 比如 kill 11421
  ```

- 案例 2：终止远程登录服务sshd，在适当时候再次重启sshd服务

  ```
  kill sshd对应的进程号; /bin/systemctl start sshd.service
  ```

- 案例 3：终止多个gedit 。支持通配符，相关的进程一条线都kill掉，快速清理内存

  ```
  killall gedit
  ```

- 案例 4：强制杀掉一个终端

  ```
  kill -9 bash对应的进程号
  ```

centos7图形界面上的两个控制台终端，这里要查询Linux控制台终端的进程要使用bash 

即`ps -aux | grep bash`

![image-20240123222724259](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240123222724259.png)

以上操作演示了如何使用`kill`和`killall`命令来管理系统进程，包括强制终止和平滑关闭进程。这些操作在系统管理中非常常见，特别是处理不响应的程序或服务时。



![image-20240123221116710](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240123221116710.png)



![image-20240123221507997](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240123221507997.png)



### 18.4 查看进程树 - `pstree`

- **介绍**：以树状形式显示进程信息。

**基本语法:**

`pstree [选项]` ,可以更加直观的来看进程信息

- 常用选项：
  - `-p`：显示进程 PID。
  - `-u`：显示进程所属用户。

**应用实例：**

 案例 1：请你树状的形式显示进程的 pid

`pstree -p`

 案例 2：请你树状的形式进程的用户

`pstree -u`







###   18.5 服务(service)管理

#### 18.5.1 介绍

服务（service）本质上是进程，但是它在后台运行，通常会监听某个端口，等待其他程序的请求，如（mysqld, sshd, 防火墙等）。因此，我们也称之为守护进程，它是Linux中一个非常重要的概念。

#### 18.5.2 service管理指令

1. `service 服务名 [start | stop | restart | reload | status]`

2. 在CentOS7.0之后，很多服务不再使用service，而是采用systemctl。

3. service指令管理的服务在`/etc/init.d`中可以查看。

   ![image-20240125220107061](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240125220107061.png)

#### 18.5.3 service管理指令案例

- 请使用service指令，查看、关闭、启动network（注意：在虚拟系统中演示，因为网络连接会关闭）。
  - `service network status`
  - `service network stop`
  - `service network start`

#### 18.5.4 查看服务名

- 方式1：使用`setup -> 系统服务`就可以看到全部。

- 方式2：在

  ```
  /etc/init.d
  ```

  中可以看到service指令管理的服务。

  - `ls -l /etc/init.d`

#### 18.5.5 服务的运行级别(runlevel)

- Linux系统有7种运行级别(runlevel)，常用的是级别3和5。
  - 运行级别0：系统停机状态，系统默认运行级别不能设为0，否则不能正常启动。
  - 运行级别1：单用户工作状态，root权限，用于系统维护，禁止远程登录。
  - 运行级别2：多用户状态(没有NFS)，不支持网络。
  - 运行级别3：完全的多用户状态(有NFS)，无界面，登录后进入控制台命令行模式。
  - 运行级别4：系统未使用，保留。
  - 运行级别5：X11控制台，登录后进入图形GUI模式。
  - 运行级别6：系统正常关闭并重启，默认运行级别不能设为6，否则不能正常启动。

#### 18.5.6 CentOS7之后的运行级别说明

- 在

  ```
  /etc/initab
  ```

  中进行了简化。

  - `multi-user.target`: 相当于runlevel 3。
  - `graphical.target`: 相当于runlevel 5。
  - `init 0`
  - 要查看当前默认目标，运行: `systemctl get-default`
  - 要设置默认目标，运行: `systemctl set-default TARGET.target`

#### 18.5.7 chkconfig指令

- 介绍：通过chkconfig命令，可以为服务的各个运行级别设置自启动/关闭。

 	  `chkconfig` 是一个缩写，常用于 Unix 和 Linux 系统中。它代表 "检查配置"（check configuration）。  

- chkconfig指令管理的服务在`/etc/init.d`中可以查看,有三个。
- ![image-20240126015058187](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240126015058187.png)
- 注意: CentOS7.0之后，很多服务使用systemctl管理。

基本语法：

- 查看服务：`chkconfig --list [| grep xxx]`
- `chkconfig 服务名 --list`
- `chkconfig --level 5 服务名 on/off`

案例演示:

- 对network服务进行各种操作，把network在3运行级别关闭自启动：`chkconfig --level 3 network off`
- 同样的，可以打开自启动：`chkconfig --level 3 network on`
- 注意：使用chkconfig重新设置服务后自启动或关闭，需要重启机器`reboot`生效。

#### 18.5.8 systemctl管理指令

基本语法：`systemctl [start | stop | restart | status] 服务名`

- systemctl指令管理的服务在`/usr/lib/systemd/system`中可以查看。

`systemctl` 是 `system control` 的缩写，用于控制 `systemd` 系统和服务管理器。在 Linux 中，`systemd` 是一个系统和服务管理器，负责初始化系统组件、管理系统服务等。

**中文含义：** 系统控制

**常用选项及用法：**

1. `systemctl start 服务名`：启动服务。
2. `systemctl stop 服务名`：停止服务。
3. `systemctl restart 服务名`：重启服务。
4. `systemctl reload 服务名`：重新加载服务配置文件，而不中断服务。
5. `systemctl status 服务名`：查看服务当前状态。
6. `systemctl enable 服务名`：设置服务为开机自启。
7. `systemctl disable 服务名`：取消服务的开机自启。
8. `systemctl is-enabled 服务名`：检查服务是否设置为开机自启。
9. `systemctl list-unit-files`：列出所有服务的启动状态。

通过这些命令，用户可以管理和控制系统上的服务和进程。

#### 18.5.9 systemctl设置服务的自启动状态

- `systemctl list-unit-files [| grep 服务名]` (查看服务开机启动状态，grep可以进行过滤)



- `systemctl enable 服务名` (设置服务开机启动) 
- `systemctl disable 服务名` (关闭服务开机启动)

> 上面这两种设置服务开机启动/关闭服务的方式，没有像chkconfig指定运行级别，是因为在centos7以后默认设置的是运行级别**3和5**下是否开机启动/关闭服务



- `systemctl is-enabled 服务名` (查询某个服务是否是自启动的)

#### 18.5.10 应用案例

- 查看当前防火墙的状况，关闭防火墙和重启防火墙。=> `firewalld.service`

  1. 首先查出防火墙服务的名称 `ll /usr/lib/systemd/system/ | grep firewalld`
  2. 查看防火墙服务的启动状态, `systemctl list-unit-files | grep firewalld`
  3. 

  - `systemctl status firewalld`
  - `systemctl stop firewalld` ，这条指令只是**暂时关闭**防火墙，下次启动Linux系统防火墙会自动打开。
  - `systemctl start firewalld`

#### 18.5.11 细节讨论

- 关闭或者启用防火墙后，立即生效。(可以通过telnet测试某个端口)
- 这种方式只是**临时生效**，当重启系统后，会回到之前对服务的设置。
- 如果希望设置某个服务自启动或关闭永久生效，应该使用`systemctl [enable|disable] 服务名`。

查看Linux防火墙是否启用`systemctl is-enabled firewalld`

设置启用`systemctl enable firewalld`,最好设置为启用状态

#### 18.5.12 打开或关闭指定端口

cmd命令行中 **`telnet`**指令

**测试防火墙是否关闭** `telnet [主机地址] [端口号]`,比如在虚拟机Linux中关闭了防火墙，测试有没有成功关闭，可以使用，宿主机对虚拟机的Linux系统发起远程连接请求。

`telnet` 是 "Telecommunication Network" 的缩写。

**中文含义：** 远程登录

**常用选项及用法：**

- 基本用法：`telnet [主机地址] [端口号]`，用于远程登录到指定的主机上。如果不指定端口号，默认为23端口。

**常见用途：**

- 远程登录：允许用户通过网络登录到另一台计算机上，并在上面执行命令，就如同在本地计算机上一样。
- 测试网络连接：可以用来测试TCP连接，比如检查某个端口是否开放。

**注意事项：**

- `telnet` 是不安全的，因为它不为客户端和服务器之间的通信提供加密，可能会暴露敏感信息。现代系统更推荐使用 `SSH`（Secure Shell）作为更安全的远程登录方法。

查看网络服务的信息 `netstat -anp | more`

![image-20240125232415933](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240125232415933.png)



如果关闭防火墙，那么就相当于防护没有了，防火墙没有了，那么里面的3306，22，111... 等端口客户端cmd telnet 都可以访问到



![image-20240126000510687](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240126000510687.png)



如果报错，则启用Telnet客户端

![image-20240126002403924](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240126002403924.png)

![image-20240126002327428](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240126002327428.png)

![image-20240126002452023](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240126002452023.png)

之后就可以连接上了

![image-20240126002633574](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240126002633574.png)



如果Linux防火墙是打开的，同时111端口没有在Linux防火墙打开/放行的端口列表中，则访问不到，如下

![image-20240126002850686](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240126002850686.png)

![image-20240126004049827](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240126004049827.png)



应用案例：

\1) 启用防火墙， 测试 111 端口是否能 telnet , 不行

\2) 开放 111 端口

`firewall-cmd --permanent --add-port=111/tcp` ; 需要 `firewall-cmd --reload`

\3) 再次关闭 111 端口

`firewall-cmd --permanent --remove-port=111/tcp` ; 需要 `firewall-cmd --reload` 不然不生效



![image-20240126004729270](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240126004729270.png)

- 在生产环境中，通常需要打开防火墙，但如果打开防火墙，外部请求数据包就不能与服务器监听端口通信。这时需要打开指定的端口，例如80、22、8080等。

#### 18.5.13 firewall指令

##### Linux如何在使用防火墙的情况下，放行/打开特定端口呢？比如111端口？

可以使用以下指令

- 打开端口: `firewall-cmd --permanent --add-port=端口号/协议`

- 关闭端口: `firewall-cmd --permanent --remove-port=端口号/协议`
- 增加服务: `firewall-cmd --add-service=http --permanent #增加了一个 http 服务,理解`
- 移除服务: `firewall-cmd --remove-service=http --permanent #移除了一个 http 服务`
- 重新载入, 才能生效: `firewall-cmd --reload`
- 查询端口是否开放: `firewall-cmd --query-port=端口/协议`
- 查询和显示当前活动的防火墙区域（zone）的详细信息`firewall-cmd --list-all` 



`firewall-cmd --list-all`  **用于查询和显示当前活动的防火墙区域（zone）的详细信息。**这个命令是 `firewalld` 服务的一部分，`firewalld` 是现代 Linux 发行版中用于管理网络访问控制的防火墙守护程序。

当您执行 `firewall-cmd --list-all` 命令时，它会提供以下信息：

1. **当前区域（Zone）的名称**：在 `firewalld` 中，区域是用来定义不同的网络信任级别的。每个区域可以有不同的规则和策略。
2. **接口（Interfaces）**：显示与该区域关联的网络接口。
3. **源地址（Sources）**：显示已指定为该区域一部分的源 IP 地址。
4. **服务（Services）**：列出在该区域中允许的服务。服务是预定义的规则集合，例如 HTTP、SSH 等。
5. **端口（Ports）**：显示在该区域中开放的特定端口。
6. **协议（Protocols）**：列出在该区域中允许的网络协议。
7. **转发规则（Forwarding rules）**：显示有关 IPv4 和 IPv6 转发的规则。
8. **其他规则**：如富规则（rich rules）、ICMP 阻止和允许的类型等。

这个命令非常有用，因为它可以让系统管理员快速查看当前防火墙的配置状态，了解哪些服务和端口是开放的，以及哪些网络接口被包含在特定的防火墙区域中。这对于网络安全和故障排除来说是非常重要的。

![image-20240206032155177](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240206032155177.png)





这里的`协议`可以使用指令 `netstat -anp | more` 来查看监听的端口使用的协议

![image-20240126003744862](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240126003744862.png)



`netstat` 是一个非常有用的网络工具，用于在 Unix 和 Unix-like 系统（如 Linux）上显示网络连接、路由表、接口统计、伪装连接以及多播成员资格等信息。以下是 `netstat` 的一些主要功能和常用选项的简要说明：

### netstat指令的作用

1. **显示网络连接**：
   - 查看活动的连接（TCP/UDP）。
2. **路由表信息**：
   - 显示路由表，包括目的地、网关等。
3. **接口统计信息**：
   - 查看每个网络接口的状态和统计数据。
4. **监听端口**：
   - 显示在系统上监听的端口。
5. **伪装连接**：
   - 显示伪装（masqueraded）的网络连接。
6. **多播成员资格**：
   - 显示多播网络的成员资格信息。

### 常用选项

1. `-a`（all）：
   - 显示所有选项的默认输出。
2. `-n`（numeric）：
   - 显示数字形式的地址和端口号，而不是尝试确定符号名称。
3. `-p`（program）：
   - 显示哪个进程正在使用哪个套接字或端口。
4. `-t`：
   - 仅显示 TCP 连接。
5. `-u`：
   - 仅显示 UDP 连接。
6. `-l`（listening）：
   - 仅显示监听的套接字。
7. `-r`：
   - 显示路由表。
8. `-s`：
   - 按协议显示统计数据（例如 TCP、UDP、ICMP）。
9. `-i`：
   - 显示网络接口的统计信息。

### 示例命令

- 查看所有活动连接：`netstat -a`
- 查看所有活动的 TCP 连接：`netstat -at`
- 查看哪些端口正在监听：`netstat -l`
- 显示每个协议的统计数据：`netstat -s`
- 查看路由表：`netstat -r`
- 显示所有活动连接的数值地址和端口：`netstat -an`

请注意，`netstat` 命令在一些新的 Linux 发行版中可能已被 `ss` 命令和其他 `iproute2` 工具取代。不过，`netstat` 仍然是一个广泛使用的工具，特别是在那些较旧或保持传统的系统中。

### 18.6 动态监控进程

#### 18.6.1 介绍

- `top` 与 `ps` 命令都用于显示正在执行的进程。`top` 与 `ps` 的主要区别在于，`top` 可以定期更新当前运行的进程，从而动态监控系统的进程状态。

#### 18.6.2 基本语法

- 命令：`top [选项]`

![image-20240126010735893](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240126010735893.png)



好的，让我们逐一解释 `top` 命令输出顶部的信息：

- **top - 01:01:44**：表示 `top` 命令的当前时间是凌晨1点1分44秒。
- **up 50 min**：系统已经运行了50分钟。
- **1 user**：当前有1个用户登录系统。
- **load average: 0.00, 0.01, 0.05**：系统平均负载，分别表示过去1分钟、5分钟和15分钟的平均负载。

接下来是进程和资源使用的摘要：

- Tasks

  ：系统中进程的总数。

  - **total**: 总进程数。
  - **running**: 正在运行的进程数。
  - **sleeping**: 处于睡眠状态的进程数。
  - **stopped**: 已停止的进程数。
  - **zombie**: 僵尸进程数。

- %Cpu(s)

  ：CPU使用率的百分比。

  - **us** (user): 用户空间占用的CPU百分比。
  - **sy** (system): 内核空间占用的CPU百分比。
  - **ni** (nice): 优先级调整后的用户进程占用的CPU百分比。
  - **id** (idle): 空闲的CPU百分比。
  - **wa** (iowait): 等待I/O的CPU时间百分比。
  - **hi** (hardware IRQ): 硬件中断的CPU时间百分比。
  - **si** (software interrupts): 软件中断的CPU时间百分比。
  - **st** (steal time): 虚拟化环境中，被其他操作系统占用的CPU时间百分比。




- KiB Mem：以Kibibyte（KiB）为单位显示的物理内存使用情况。
  - **total**: 系统的总内存量。
  - **free**: 当前未被使用的内存量。
  - **used**: 当前已被使用的内存量。
  - **buff/cache**: 用于缓冲和缓存的内存量。
- KiB Swap：交换分区的使用情况，交换空间是当物理内存不足时，系统用作内存的硬盘空间部分。
  - **total**: 总的交换空间量。
  - **free**: 未被使用的交换空间量。
  - **used**: 已被使用的交换空间量。
  - **avail Mem**: 估计的可用内存量，即尽管已被缓冲和缓存占用，但仍可以不经过交换就被当前或即将启动的进程使用的内存量。

接下来是每个进程的具体信息，列出了系统中的每个进程及其资源使用情况，这部分通常会在 `top` 命令的后续输出中显示，例如：

- **PID**: 进程ID。
- **USER**: 运行该进程的用户名称。
- **PR**: 进程的优先级。
- **NI**: Nice值，影响进程优先级的值。
- **VIRT**: 虚拟内存的总量，该进程使用的虚拟地址空间的大小。
- **RES**: 进程使用的、未被换出的物理内存大小。
- **SHR**: 进程使用的共享内存大小。
- **S**: 进程的状态（例如，睡眠（S）、运行（R）等）。
- **%CPU**: 该进程使用的CPU百分比。
- **%MEM**: 该进程使用的物理内存百分比。
- **TIME+**: 进程使用的CPU时间总和。
- **COMMAND**: 启动进程的命令名称或命令行。



#### 18.6.3 选项说明

![image-20240126011327840](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240126011327840.png)

#### 18.6.4 交互操作说明

![image-20240126011343965](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240126011343965.png)

这里在交互时输入大写的P才可以,也可以输入shift+p，但是不能输入小写的p





#### 18.6.5 应用实例

- 案例 1：监视特定用户，例如监控 `tom` 用户

  - 执行 `top` 命令，查看执行的进程。
  - 输入 `u`，然后回车，再输入用户名 `tom`。

- 案例 2：终止指定的进程，例如结束 `tom` 用户的登录

  - 执行 `top` 命令，查看执行的进程。
  - 输入 `k`，然后回车，再输入要结束的进程 ID 号。

  ![image-20240126012854400](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240126012854400.png)

  回车，这时让我们输入信号量，输入9,即强制结束/删除

![image-20240126012955495](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240126012955495.png)

- 案例 3：指定系统状态更新的时间（每隔 10 秒自动更新），默认是 3 秒
  - 执行命令 `top -d 10`。

### 18.7 监控网络状态

#### 18.7.1 查看系统网络情况 `netstat`

- 基本语法：`netstat [选项]`		`netstat -anp | more`
- 选项说明：
  - `-an`：按一定顺序排列输出
  - `-p`：显示哪个进程在调用



- 应用案例：
  - 查看服务名为 `sshd` 的服务的信息：`netstat -anp | grep sshd`



![image-20240126013859439](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240126013859439.png)

- **Proto**: 表示协议类型，通常是 TCP 或 UDP。
- **Recv-Q**: 接收队列大小，显示待处理的接收数据量。
- **Send-Q**: 发送队列大小，显示待处理的发送数据量。
- **Local Address**: 本地端口和地址，表示本机的端口号和IP地址。
- **Foreign Address**: 远端地址和端口，表示外部连接到本机的端口和IP地址。
- **State**: 连接的状态，如 LISTEN 表示正在监听的端口，ESTABLISHED 表示已经建立的连接。

在网络配置中，这些地址具有特殊含义：

- `0.0.0.0`：这个地址通常表示 "在所有IP地址上监听"。如果一个服务在 `0.0.0.0` 上监听，它将接受来自所有网络接口上的所有IPv4地址的连接。这是让服务对外界所有可能的IPv4连接都可达的一种方式。
- `127.0.0.1`：这是一个特殊的IP地址，称为 "环回" 或 "localhost" 地址。它用于一个主机网络内部的IP通信。基本上，它用来让计算机发送消息给自己。如果一个服务在 `127.0.0.1` 上监听，它只能接受从同一台机器上发起的连接。
- `:::22`：这是 IPv6 地址格式，其中 `::` 表示一串连续的零。在这里，它表示在端口22上监听所有IPv6地址。这就像 IPv4 中的 `0.0.0.0`，表示服务对所有IPv6接口上的连接都是可达的。
- `::1`：这是 IPv6 的本地回环地址，类似于 IPv4 的 `127.0.0.1`。服务如果在这个地址上监听，只能接受从同一台机器上的IPv6连接。

#### 18.7.2 检测主机连接命令 `ping`

- `ping` 是一种网络检测工具，主要用于检测远程主机是否正常，或检测两台主机间的网线或网卡是否存在故障。
- 用法示例：`ping [对方 ip 地址]`

以上内容根据您提供的资料整理而成。如果需要更多详细信息，您可以参考 `man` 页面或其他文档。



**ping IP ，这里默认ping的是哪一个端口？**



实际上，`ping` 命令并不使用 TCP 或 UDP 端口。它使用的是 ICMP（Internet Control Message Protocol，互联网控制消息协议），这是一个用于发送诊断消息的网络层协议。

当您执行 `ping` 到一个 IP 地址时，它发送一个 ICMP Echo Request 消息到目标地址，并等待 ICMP Echo Reply 消息作为响应。这种通信机制用于测试目标主机是否可达以及往返通信的延迟。

由于 ICMP 操作在网络协议的较低层次（IP层），而不是在传输层（如 TCP 或 UDP），因此 `ping` 不与特定的端口关联。它直接与 IP 地址进行交互，而不是基于端口的服务。



### 19.1 rpm 包的管理

#### 19.1.1 介绍

rpm 是 RedHat Package Manager（RedHat 软件包管理工具）的缩写，是一种在互联网上下载包的打包及安装工具，生成的文件具有 `.RPM` 扩展名。它被多个Linux发行版采用，如 SUSE、RedHat、CentOS 等。

#### 19.1.2 rpm 包的简单查询指令

- 查询已安装的 rpm 列表：`rpm –qa|grep xx`
- 举例：查看系统是否安装了 firefox：`rpm -qa | grep firefox`

#### 19.1.3 rpm 包名基本格式

一个 rpm 包名例子：`firefox-60.2.2-1.el7.centos.x86_64`

- 名称：firefox
- 版本号：60.2.2-1
- 适用操作系统：el7.centos.x86_64
  - 表示 CentOS 7.x 的 64 位系统
  - 如果是 i686、i386 表示 32 位系统，noarch 表示通用

#### 19.1.4 rpm 包的其它查询指令

- `rpm -qa`：查询所有安装的 rpm 软件包
- `rpm -qa | more`
- `rpm -qa | grep X`：如 `rpm -qa | grep firefox`
- `rpm -q 软件包名`：查询软件包是否安装，如 `rpm -q firefox`
- `rpm -qi 软件包名`：查询软件包信息，如 `rpm -qi firefox`
- `rpm -ql 软件包名`：查询软件包中的文件，如 `rpm -ql firefox`
- `rpm -qf 文件全路径名`：查询文件所属的软件包，如 `rpm -qf /etc/passwd`



常用的rpm命令选项：

- `-ivh`：安装软件包。`i` 代表 install，`v` 代表 verbose（显示详细信息），`h` 代表 hash（显示安装进度条）。
- `-q`：查询软件包。单独使用时，`-q` 查询一个软件包是否安装。
- `-qa`：查询所有已安装的软件包。
- `-qi`：显示指定已安装软件包的详细信息。
- `-ql`：列出指定已安装软件包中的所有文件。
- `-qf`：查询指定文件属于哪个软件包。
- `-e`：卸载（erase）一个已安装的软件包。
- `-Uvh`：更新软件包，如果软件包尚未安装，则安装它。`U` 代表 upgrade。
- `--nodeps`：安装或卸载软件包时忽略依赖性检查，不推荐使用，因为可能会破坏系统依赖关系。
- `--force`：强制安装软件包，即使这可能会覆盖已安装的文件。

使用rpm进行软件包管理时，通常需要有管理员权限。



问题说明：

1. **使用 `-ivh` 选项进行 RPM 包的安装时，通常需要先将包下载到本地文件系统。**这个选项的组合表示安装（`i`），并在安装过程中显示详细输出（`v`），同时显示一个进度条（`h`），以便用户可以看到安装的进度。

   例如，如果您有一个名为 `package.rpm` 的软件包文件，您将使用以下命令安装它：

   ```bash
   rpm -ivh package.rpm
   ```

   这条命令会从您的本地存储中查找 `package.rpm` 文件，并执行安装过程。

   如果您不想手动下载 RPM 包并希望自动解决依赖性问题，通常会使用 `yum` 或 `dnf`（在较新的 Fedora 和某些 Red Hat Enterprise Linux 版本中）等包管理工具，这些工具会从配置的软件仓库中下载并安装包及其所有依赖项。



2. **不会自动找到安装包。**在使用 `rpm -ivh package.rpm` 命令时，您需要确保已经在命令行的当前工作目录下有 `package.rpm` 文件，或者您需要指定包的完整路径。如果包不在当前目录下，就必须提供完整的路径。例如，如果您的包在 `/home/user/downloads` 目录中，命令应该是这样的：

   ```bash
   rpm -ivh /home/user/downloads/package.rpm
   ```

   如果不提供完整路径，并且包也不在当前目录中，`rpm` 将会报错，提示找不到该文件。

   

3. **`rpm` 命令本身并不直接支持指定软件包的安装位置，因为 RPM 包中包含了软件应该被安装到的位置信息。**通常情况下，软件包的构建者已经在构建 RPM 包时指定了软件的安装路径，遵循的是 Linux 文件系统的标准结构。

   如果你需要安装到一个自定义的目录，你可能需要考虑使用 `relocate` 选项，但这只适用于软件包构建时被标记为可重定位的。即使如此，也不是所有的软件包都支持这个选项，因为它可能会破坏软件的功能。使用这个选项的基本语法如下：

   ```bash
   rpm -ivh --relocate /原始路径=/新路径 package.rpm
   ```

   但请注意，这种方法并不常见，也不推荐使用，除非你非常清楚自己在做什么，而且软件包明确支持重定位。

   通常来说，如果需要将软件安装到非标准目录，更常见的做法是通过编译源代码时指定安装前缀，或者使用容器技术（如 Docker）来隔离安装环境。

#### 19.1.5 卸载 rpm 包

- 基本语法：`rpm -e RPM包的名称`（e 是erase  意思是“擦除”或“删除”）
- 应用案例：`rpm -e firefox`  指定安装包的名字即可，不用是全的安装包名，firefox 即可
- 注意：如果其他软件包依赖于要卸载的包，会产生错误信息。可用 `--nodeps` 强制删除，但不推荐。

#### 19.1.6 安装 rpm 包

- 基本语法：`rpm -ivh RPM包全路径名称`
- 参数说明：
  - `i`=install 安装
  - `v`=verbose 提示
  - `h`=hash 进度条
- 应用实例：安装或卸载 firefox 浏览器
  - `rpm -e firefox`
  - `rpm -ivh firefox`

### 19.2 yum

#### 19.2.1 介绍

Yum 是一个基于 RPM 包管理的 Shell 前端软件包管理器。能够自动下载 RPM 包并且安装，自动处理依赖性关系，并一次性安装所有依赖的软件包。

### 19.2.2 查询

- 查询 yum 服务器是否有需要安装的软件：`yum list|grep xx`
  - 例如，列出所有可安装或更新的软件包：`yum list`
  - 查询特定软件：`yum list | grep firefox`

### 19.2.3 安装指定的 yum 包

- 基本语法：`yum install 包名`
  - 例如，下载并安装软件包：`yum install firefox`

### 19.2.4 yum 应用实例

- 安装 firefox 浏览器的案例：
  1. 卸载现有的 firefox 版本（如果有）：`rpm -e firefox`
  2. 查询可用的 firefox 包：`yum list | grep firefox`
  3. 安装 firefox 浏览器：`yum install firefox`

[注意：使用 yum 进行软件包管理时，它会自动处理软件之间的依赖关系，相对于直接使用 rpm 命令更加方便。]





## 20. JavaEE 开发环境的搭建

### 20.1 概述

在 Linux 下进行 JavaEE 开发需要安装一系列软件。

### 20.2 安装 JDK

#### 20.2.1 安装步骤

1. 创建目录 `/opt/jdk`
2. 使用 xftp6 上传到 `/opt/jdk`
3. 进入目录 `cd /opt/jdk`
4. 解压 JDK `tar -zxvf jdk-8u261-linux-x64.tar.gz`
5. 创建目录 `/usr/local/java`
6. 移动解压后的 JDK 到目标目录 `mv /opt/jdk/jdk1.8.0_261 /usr/local/java`
7. 配置环境变量 `vim /etc/profile`
8. 设置 JAVA_HOME `export JAVA_HOME=/usr/local/java/jdk1.8.0_261`
9. 更新 PATH `export PATH=$JAVA_HOME/bin:$PATH`
10. 应用配置 `source /etc/profile`

#### 20.2.2 测试安装

编写并运行一个简单的 Hello.java 程序。

### 20.3 安装 Tomcat

#### 20.3.1 安装步骤

1. 上传并解压 Tomcat 至 `/opt/tomcat`

2. 进入 `/opt/tomcat/bin`，启动 Tomcat `./startup.sh`

   ![image-20240128030030959](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240128030030959.png)

3. 开放 8080 端口，回顾 `firewall-cmd` 指令

~~~
[root@hspEdu100 bin]# firewall-cmd --permanent --add-port=8080/tcp
success
[root@hspEdu100 bin]# firewall-cmd --reload
success
[root@hspEdu100 bin]# firewall-cmd --query-port=8080/tcp
yes
~~~

![image-20240128031424957](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240128031424957.png)



#### 20.3.2 测试安装

在浏览器中访问 `http://linuxip:8080` 测试 Tomcat。

http://192.168.200.130:8080

![image-20240128031759720](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240128031759720.png)



http://192.168.200.130:8080/hsp.html

![image-20240128032045697](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240128032045697.png)

### 20.4 安装 IntelliJ IDEA 2020

#### 20.4.1 安装步骤

1. 下载地址：[JetBrains 官网](https://www.jetbrains.com/idea/download/#section=windows)
2. 解压至 `/opt/idea`
3. 启动 IDEA `bin/idea.sh` 并配置 JDK

**Linux中SDK的选择，就指定到jdk1.8安装目录文件夹即可，不需要指定到bin目录**

![image-20240128034210204](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240128034210204.png)

1. 编写并测试 Hello World 程序

### 20.5 安装 MySQL 5.7

#### 20.5.1 安装步骤

1. 按照文档进行安装步骤
2. 准备相关安装软件
3. 根据老师的演示和文档进行安装



注意：mysql 在命令行使用时，注意分号`;`结尾退出指令为`quit`

 

修改过mysql5.7自动分配的默认密码后，这里在Linux中安装的mysql5.7密码是:  **hspedu100**

~~~shell
[root@hspEdu100 mysql]# mysql -u root -p
Enter password: 
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 5
Server version: 5.7.26 MySQL Community Server (GPL)

Copyright (c) 2000, 2019, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> use hspedu
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> select * from myorder
    -> ;
Empty set (0.00 sec)

mysql> insert into myorder values(100,'dog');
Query OK, 1 row affected (0.00 sec)

mysql> select * from myorder;
+------+------+
| id   | name |
+------+------+
|  100 | dog  |
+------+------+
1 row in set (0.00 sec)

mysql> insert into myorder values(200,"cat");
Query OK, 1 row affected (0.01 sec)

mysql> select * from myorder;
+------+------+
| id   | name |
+------+------+
|  100 | dog  |
|  200 | cat  |
+------+------+
2 rows in set (0.00 sec)

mysql> quit
Bye
[root@hspEdu100 mysql]# 
~~~















# 第 17 章大数据定制篇 - Shell 编程

## 17.1 为什么要学习 Shell 编程
- Linux 运维工程师在进行服务器集群管理时，需要编写 Shell 程序来进行服务器管理。
- 对于 JavaEE 和 Python 程序员来说，工作的需要，你的老大会要求你编写一些 Shell 脚本进行程序或者是服务器的维护，比如编写一个定时备份数据库的脚本。
- 对于大数据程序员来说，需要编写 Shell 程序来管理集群。

## 17.2 Shell 是什么
Shell 是一个命令行解释器，它为用户提供了一个向 Linux 内核发送请求以便运行程序的界面系统级程序，用户可以用 Shell 来启动、挂起、停止甚至是编写一些程序。

## 17.3 Shell 脚本的执行方式
### 17.3.1 脚本格式要求
- 脚本以 `#!/bin/bash` 开头
- 脚本需要有可执行权限

### 17.3.2 编写第一个 Shell 脚本
需求说明：创建一个 Shell 脚本，输出 "hello world!"
```bash
vim hello.sh
#!/bin/bash
echo "hello,world~"
```

### 17.3.3 脚本的常用执行方式
- 方式 1 (输入脚本的绝对路径或相对路径)
  - 说明：首先要赋予 `helloworld.sh` 脚本的 +x 权限，再执行脚本。比如 `./hello.sh` 或者使用绝对路径 `/root/shcode/hello.sh`
- 方式 2 (`sh` + 脚本)
  - 说明：不用赋予脚本 +x 权限，直接执行即可。比如 `sh hello.sh`，也可以使用绝对路径。

## 17.4 Shell 的变量
### 17.4.1 Shell 变量介绍
- Linux Shell 中的变量分为系统变量和用户自定义变量。
- 系统变量：`$HOME`、`$PWD`、`$SHELL`、`$USER` 等等。比如：`echo $HOME`。
- 显示当前 shell 中所有变量：`set`

### 17.4.2 自定义 Shell 变量 
- 基本语法：
  - 定义变量：`变量名=值` ，**注意等号两边没有空格**
  - 撤销变量：`unset 变量`
  - 声明静态变量：`readonly 变量`，注意：不能 `unset`
  
  

**将指令返回的结果赋给变量**

 ~~~
 # 将指令返回的结果赋给变量
 C=`date`
 D=$(date)
 ~~~



- 快速入门：
  - 案例 1：定义变量 A
  - 案例 2：撤销/销毁变量 A
  - 案例 3：声明静态的变量 B=2，不能 `unset`


```bash
#!/bin/bash
# 案例 1：定义变量 A
A=100
# 输出变量需要加上$
echo "A=$A"
# 案例 2：撤销变量 A
unset A
echo "A=$A"
# 案例 3：声明静态的变量 B=2，不能 unset
readonly B=2
echo "B=$B"
# 将指令返回的结果赋给变量
C=`date`
D=$(date)
echo "C=$C"
echo "D=$D"
# 使用环境变量 TOMCAT_HOME
echo "tomcat_home=$TOMCAT_HOME"
```

###  

### 17.4.3 Shell 变量的定义规则
- 变量名称可以由字母、数字和下划线组成，但是不能以数字开头。例如 `5A=200` 是不允许的。
- 等号两侧不能有空格。
- 变量名称一般习惯为大写，这是一个规范，我们遵守即可。

## 17.5 设置环境变量
### 17.5.1 基本语法
- `export 变量名=变量值`：将 shell 变量输出为环境变量/全局变量
- `source 配置文件`：让修改后的配置信息立即生效
- `echo $变量名`：查询环境变量的值

### 17.5.2 快速入门
- 在 `/etc/profile` 文件中定义 `TOMCAT_HOME` 环境变量
- 查看环境变量 `TOMCAT_HOME` 的值
- 在另外一个 shell 程序中使用 `TOMCAT_HOME`
- 注意：在输出 `TOMCAT_HOME` 环境变量前，需要让其生效：`source /etc/profile`

## 17.6 位置参数变量
### 17.6.1 介绍
当我们执行一个 shell 脚本时，如果希望获取到命令行的参数信息，就可以使用到位置参数变量。

### 17.6.2 基本语法
- `$n`：n 为数字，`$0` 代表命令本身，`$1-$9` 代表第一到第九个参数，十以上的参数需要用大括号包含，如 `${10}`
- `$*`：这个变量代表命令行中所有的参数，`$*` 把所有的参数看成一个整体
- `$@`：这个变量也代表命令行中所有的参数，不过 `$@` 把每个参数区分对待
- `$#`：这个变量代表命令行中所有参数的个数

## 17.7 预定义变量

### 17.7.1 基本介绍
就是 shell 设计者事先已经定义好的变量，可以直接在 shell 脚本中使用。

### 17.7.2 基本语法
- `$$`：当前进程的进程号（PID）
- `$!`：后台运行的最后一个进程的进程号（PID）
- `$?`：最后一次执行的命令的返回状态。如果这个变量的值为 0，证明上一个命令正确执行；如果这个变量的值为非 0（具体是哪个数，由命令自己来决定），则证明上一个命令执行不正确了。

## 17.8 运算符
### 17.8.1 基本介绍
学习如何在 shell 中进行各种运算操作。

### 17.8.2 基本语法
- `$((运算式))` 或 `$[运算式]` 或 `expr m + n`：进行加法运算
- 注意：`expr` 运算符间要有空格，如果希望将 `expr` 的结果赋给某个变量，使用反引号
- `expr m - n`：进行减法运算
- `expr \*, /, %`：进行乘、除、取余运算

 

## 17.9 条件判断
### 17.9.1 判断语句
- 基本语法：`[ condition ]` 注意 condition 前后要有空格。
- `[ hspEdu ]` 返回 true，`[ ]` 返回 false。
- `[ condition ] && echo OK || echo notok`：条件满足，执行后面的语句。

### 17.9.2 常用判断条件
- `=`：字符串比较。
- `-lt`：小于。
- `-le`：小于等于。
- `-eq`：等于。
- `-gt`：大于。
- `-ge`：大于等于。
- `-ne`：不等于。

**按文件权限判断**
- `-r`：有读权限。
- `-w`：有写权限。
- `-x`：有执行权限。

**按文件类型判断**
- `-f`：文件存在并且是一个常规文件。
- `-e`：文件存在。
- `-d`：文件存在并是一个目录。

**应用实例**
- 判断 "ok" 是否等于 "ok" 使用 `=`。

~~~shell
#!/bin/bash
#案例 1："ok"是否等于"ok" 判断语句：使用 =
#if [ "ok"="ok" ]
#注意这里等号两边可以没有空格，也可以有空格，但是中括号相邻的一定要有空格
if [ "ok" = "ok" ]
then
        echo "equal"
fi

~~~



- 判断 23 是否大于等于 22 使用 `-ge`。

~~~shell
#案例 2：23 是否大于等于 22 判断语句：使用 -ge

if [ 23 -ge 22 ]
then
        echo "大于"
fi

~~~



- 检查 `/root/shcode/aaa.txt` 文件是否存在使用 `-f`。

~~~shell
#案例 3：/root/shcode/aaa.txt 目录中的文件是否存在 判断语句： 使用 -f

if [ -f /root/shcode/aaa.txt ]
then
        echo "存在"
elif [ ! -f /root/shcode/aaa.txt ]
then
        echo "不存在"
fi
#案例空的为假，必须打一个空格，否则报错

#if [] 语法错误
#if [ ] 语法正确，但是判断为假
#if [ ! ] 语法正确，判断为真
if [ ! ]
then
        echo "空的，打一个空格，为假,叹号取反为真"
fi
#非空判断为真
if [ hspedu ]
then
        echo "hello,hspedu,为真"
fi
~~~



## 17.10 流程控制
### 17.10.1 if 判断
**基本语法**
- `if [ 条件判断式 ]` 然后 `then` 执行代码，结束以 `fi`。
- 多分支语法：`if [ 条件判断式 ]` 然后 `then` 执行代码，`elif [条件判断式]` 然后 `then` 执行代码，最终 `fi`。

**注意事项**
- `[ 条件判断式 ]`，中括号和条件判断式之间必须有空格。

**应用实例**
- 判断输入的参数，如果大于等于 60，则输出 "及格了"，小于 60 则输出 "不及格"。

~~~shell
#!/bin/bash
#案例：请编写一个 shell 程序，如果输入的参数，大于等于 60，则输出 "及格了"，如果小于 60,则输出 "不及格"
if [ $1 -ge 60 ]
then
        echo "及格了"
elif [ $1 -lt 60 ]
then
        echo "不及格"
fi
~~~



### 17.10.2 case 语句
**基本语法**
- 使用 `case $变量名 in` 开始，对不同值进行匹配和操作，以 `esac` 结束。

**应用实例**
- 当命令行参数是 1 时，输出 "周一"，是 2 时，输出 "周二"，其他情况输出 "other"。

~~~shell
#!/bin/bash
# 案例 1 ：当命令行参数是 1 时，输出 "周一", 是 2 时，就输出"周二"， 其它情况输出 "other"
case $1 in
"1")
echo "周一"
;;
"2")
echo "周二"
;;
*)
echo "other"
;;
esac
~~~



### 17.10.3 for 循环
**基本语法 1**

- `for 变量 in 值1 值2 值3…` 然后 `do` 执行代码，结束以 `done`。

**应用实例**
- 打印命令行输入的参数，展示 `$*` 和 `$@` 的区别。

~~~shell
#!/bin/bash
#案例 1 ：打印命令行输入的参数 [这里可以看出$* 和 $@ 的区别]
#这里“$*” 是把输入的参数，当作一个整体，所以只会输出一句话
for i in "$*"
do
        echo "num is $i"
done

#使用 “$@”来获取输入的参数，注意，这里是分别对待的，有几个参数，就输出几句话
echo "======================================="

for j in "$@"
do
        echo "num is $j"
done
~~~

~~~
#输出结果如下：
[root@hspEdu100 shcode]# ./testFor1.sh 100 200 300
num is 100 200 300
=======================================
num is 100
num is 200
num is 300
~~~

**基本语法 2**
- `for (( 初始值; 循环控制条件; 变量变化 ))` 然后 `do` 执行代码，结束以 `done`。


当在 shell 脚本中使用 `for` 循环时，有几个重要的**注意事项**需要考虑：

1. **引用参数**：当处理传递给脚本的参数时，特别是那些可能包含空格或特殊字符的参数，应该总是使用双引号将 `$@` 或 `$*` 包围起来。这确保了参数作为整体被处理，避免了错误的参数分割。
2. **`$\*` 与 `$@` 的区别**：
   - **未加引号时**：`$*` 和 `$@` 无引号时行为相似，会根据内部字段分隔符（IFS，默认为空格）分割参数。
   - **加引号时**：`"$*"` 将所有参数合并为一个字符串，而 `"$@"` 保留每个参数作为独立的引号包裹的字符串。在大多数情况下，建议使用 `"$@"` 以正确处理每个单独的参数。
3. **循环变量的命名**：虽然通常使用 `i` 作为循环变量，但可以根据上下文使用更有意义的名称，以提高脚本的可读性。
4. **循环体的执行次数**：循环的执行次数取决于 `in` 关键词后面的元素数量。这些元素可以是静态列表、数组元素、或者是像 `$@` 这样的特殊参数。
5. **处理特殊字符**：如果参数中可能包含特殊字符（如 `*`、`?` 等），使用双引号是非常重要的，以确保这些字符不会被 shell 解释或展开。
6. **循环中的错误处理**：如果循环体内的命令可能失败，应该考虑加入错误检查。例如，你可以检查命令的退出状态，并在必要时退出循环或脚本。
7. **避免不必要的复杂性**：在编写 `for` 循环时，保持循环体简单和清晰。如果循环体变得过于复杂，考虑将某些逻辑提取到函数中。

遵循这些最佳实践可以帮助你编写更健壮、更易于维护和理解的 shell 脚本。













~~~
for i in $*; do
  echo "The parameter is $i"
done 
#这样写语法还对吗？
~~~

是的，这样写语法是正确的。不过，这里使用了 `$*` 而没有加引号。这意味着如果传递给脚本的参数中包含空格，那么空格会被用作分隔符，参数会被拆分。例如，如果你有一个参数是 `"two words"`，在这个 `for` 循环中它会被拆分成两个参数：`two` 和 `words`。

以下是脚本执行的示例：

```bash
# 假设脚本接收到三个参数：one, two, 和 "three four"
for i in $*; do
  echo "The parameter is $i"
done
# 可能的输出：
# The parameter is one
# The parameter is two
# The parameter is three
# The parameter is four
```

正如你可以看到的，即使 `"three four"` 是作为一个参数传递的，由于没有引号，空格被用来分隔，结果是它被视为了两个不同的参数。这通常不是你想要的结果，特别是在处理文件名或者其他可能包含空格的数据时。

为了更安全地处理参数，特别是当它们包含空格或者特殊字符时，最佳实践是总是在 `$*` 或 `$@` 周围使用双引号：

```bash
for i in "$@"; do
  echo "The parameter is $i"
done
```

这样每个参数都会被正确地保留和处理，即使它们包含空格。











**应用实例**
- 从 1 加到 100 的值输出显示。



~~~shell
#!/bin/bash
#案例 1 ：从 1 加到 100 的值输出显示
#定义一个变量SUM
SUM=0
for(( i=1; i<=$1; i++ ))
do
#写上你的业务代码
        SUM=$[$SUM+$i]
done

echo "1到 $1 的和sum=$SUM"
~~~

~~~
[root@hspEdu100 shcode]# ./testFor2.sh 100
1到 100 的和sum=5050
[root@hspEdu100 shcode]# ./testFor2.sh 10
1到 10 的和sum=55
~~~







### 17.10.4 while 循环
**基本语法**
- `while [ 条件判断式 ]` 然后 `do` 执行代码，结束以 `done`。

**应用实例**
- 从命令行输入一个数 n，统计从 1 加到 n 的值。

~~~shell
#!/bin/bash
#案例 1 ：从命令行输入一个数 n，统计从 1+..+ n 的值是多少？
SUM=0
i=0
while [ $i -le $1 ]
do
        SUM=$[$SUM+$i]
        #i自增
        i=$[$i+1]
done
echo "执行结果=$SUM"
~~~

上面的程序第一次累加的结果是0+0 啊，会不会影响最后的结果？这两句话反转一下执行顺序会不会更好？

您提出的一个很好的观察。在脚本中，由于初始 `SUM` 和 `i` 都被设为 0，第一次循环时确实会执行 `0 + 0` 的操作。这一步实际上是多余的，不会改变 `SUM` 的值，但也不会影响最后的结果，因为它只是在 0 的基础上增加了 0。

但您的建议是合理的，更改这两行的顺序会使脚本更加高效，因为它避免了不必要的第一次加法操作。通过首先增加 `i` 的值，然后再执行累加，您可以确保从 1 开始累加到 `n`。修改后的循环部分将如下所示：

```bash
while [ $i -lt $1 ]
do
    # i 自增
    i=$(($i + 1))

    # 累加
    SUM=$(($SUM + $i))
done
```

注意，我还改用了更现代的 `$((expression))` 语法进行算术运算，它比老式的 `$[expression]` 语法更可取。

同时，我将 `while` 循环的条件从 `-le`（小于等于）改为 `-lt`（小于），因为我们现在在累加之前就已经增加了 `i` 的值。这样，当 `i` 等于 `$1` 时，循环就会停止，确保 `SUM` 只累加到 `n`，而不是 `n+1`。

## 17.11 read 读取控制台输入
**基本语法**
- `read (选项) (参数)` 其中 `-p` 指定读取时的提示符，`-t` 指定读取时等待的时间。

**应用实例**
- 读取控制台输入的数值，并在 10 秒内输入。

~~~shell
#!/bin/bash
#案例 1：读取控制台输入一个 NUM1 值
read -p "请输入一个数NUM1=" NUM1
echo "你输入的NUM1=$NUM1"

#案例 2：读取控制台输入一个 NUM2 值，在 10 秒内输入。
read -t 10 -p "请在10s内输入一个数NUM2=" NUM2
echo "你输入的NUM2=$NUM2"
~~~



 

## 17.12 函数

### 17.12.1 函数介绍
Shell 编程和其它编程语言一样，有系统函数，也可以自定义函数。系统函数中，我们这里就介绍两个。

### 17.12.2 系统函数

**basename 基本语法**
功能：返回完整路径最后 / 的部分，常用于获取文件名。

```shell
basename [pathname] [suffix]
basename [string] [suffix]
```

如果 suffix 被指定了，basename 会将 pathname 或 string 中的 suffix 去掉。

**应用实例**
- 请返回 `/home/aaa/test.txt` 的 "test.txt" 部分。
  ```shell
  basename /home/aaa/test.txt
  ```

**dirname 基本语法**
功能：返回完整路径最后 / 的前面的部分，常用于返回路径部分。
```shell
dirname 文件绝对路径
```
从给定的包含绝对路径的文件名中去除文件名（非目录的部分），然后返回剩下的路径（目录的部分）。

**应用实例**
- 请返回 `/home/aaa/test.txt` 的 `/home/aaa`。
  ```shell
  dirname /home/aaa/test.txt
  ```

### 17.12.3 自定义函数

**基本语法**
```shell
[ function ] funname[()]
{
    Action;
    [return int;]
}
```
调用直接写函数名：`funname [值]`

**应用实例**
- 计算输入两个参数的和(动态的获取)，`getSum`。
  ```shell
  #!/bin/bash
  #案例 1：计算输入两个参数的和(动态的获取)， getSum
  
  #定义函数getSum
  function getSum(){
  
          SUM=$[$n1+$n2]
          echo "和是sum=$SUM"
  
  }
  
  #输入两个值
  read -p "请输入一个数n1=" n1
  read -p "请输入一个数n2=" n2
  
  #调用自定义函数
  getSum $n1 $n2
  ```

## 17.13 Shell 编程综合案例

### 17.13.1 需求分析
1. 每天凌晨 2:30 备份数据库 hspedu 到 `/data/backup/db`。
2. 备份开始和备份结束能够给出相应的提示信息。
3. 备份后的文件要求以备份时间为文件名，并打包成 `.tar.gz` 的形式，比如：`2021-03-12_230201.tar.gz`。
4. 在备份的同时，检查是否有 10 天前备份的数据库文件，如果有就将其删除。
5. 画一个思路分析图。

### 17.13.2 代码 /usr/sbin/mysql_db.backup.sh
```shell
# 备份目录
BACKUP=/data/backup/db
# 当前时间
DATETIME=$(date +%Y-%m-%d_%H%M%S)
echo $DATETIME
# 数据库的地址
HOST=localhost
# 数据库用户名
DB_USER=root
# 数据库密码
DB_PW=hspedu100
# 备份的数据库名
DATABASE=hspedu

# 创建备份目录, 如果不存在，就创建
[ ! -d "${BACKUP}/${DATETIME}" ] && mkdir -p "${BACKUP}/${DATETIME}"

# 备份数据库
mysqldump -u${DB_USER} -p${DB_PW} --host=${HOST} -q -R --databases ${DATABASE} | gzip > ${BACKUP}/${DATETIME}/$DATETIME.sql.gz

# 将文件处理成 tar.gz
cd ${BACKUP}
tar -zcvf $DATETIME.tar.gz ${DATETIME}

# 删除对应的备份目录
rm -rf ${BACKUP}/${DATETIME}

# 删除 10 天前的备份文件
find ${BACKUP} -atime +10 -name "*.tar.gz" -exec rm -rf {} \;

echo "备份数据库${DATABASE} 成功~"
```





**问题1：这里可以不写if-then 语句吗？**

答：是的，您可以不使用 `if-then` 语句来创建目录。在 Bash 脚本中，您使用的这行代码：

```bash
[ ! -d "${BACKUP}/${DATETIME}" ] && mkdir -p "${BACKUP}/${DATETIME}"
```

这使用了条件执行的概念。`&&` 是一个逻辑 AND 运算符，它在 Shell 脚本中用于组合两个命令。如果左边的命令（`[ ! -d "${BACKUP}/${DATETIME}" ]`）成功执行（即，如果指定的目录不存在，返回 true），那么右边的命令（`mkdir -p "${BACKUP}/${DATETIME}"`）才会执行。

这是一种在 Shell 脚本中常见的简写方法，用于在一个条件为真时执行命令，而不需要完整的 `if-then` 语句。它在脚本中用于简化控制流和节省空间，特别是当后续命令只有一个时非常有用。

完整的 `if-then` 语句对于更复杂的条件测试或者当有多个后续命令需要执行时是有用的。在您的例子中，由于只需要创建一个目录，使用 `&&` 运算符是完全可以的。



**问题2：`${BACKUP}/${DATETIME}` ，这里为什么使用了大括号？作用是？**

答：在 Bash 脚本中，变量通常是通过在变量名前加上 `$` 符号来引用的。大括号 `${}` 在这里用于**明确变量的界限。**这种语法对于下面这些情况特别有用：

1. **当你需要将变量与其他文字或字符直接相连时，如拼接字符串或添加后缀，大括号可以明确变量名的结束。**例如，如果你有一个名为 `VAR` 的变量，你想打印出 "VAR_value"，那么你可以这样写 `echo ${VAR}_value`。如果不用大括号，直接写 `$VAR_value`，shell 会尝试查找名为 `VAR_value` 的变量，这可能不是你想要的。

2. 大括号还可以在变量替换中使用，执行更复杂的操作，如变量截取、默认值等。

在您的例子 `${BACKUP}/${DATETIME}` 中，虽然没有直接跟随文字或字符，使用大括号也是一种良好的实践，尤其是当变量名与斜杠或其他特殊字符相连时，因为它增加了可读性并避免了解析问题。然而，即使没有大括号，这个表达式也会正确工作，因为斜杠 `/` 明确地标识了变量名的结束。所以，`$BACKUP/$DATETIME` 与 `${BACKUP}/${DATETIME}` 在功能上是等效的。





**`> ${BACKUP}/${DATETIME}/${DATETIME}.sql.gz` ，这里相当于给输出的文件重命名吗？**

ChatGPT

是的，这行命令中的重定向操作 `>` 和路径字符串结合起来，确实是在指定输出文件的名称和位置。

在这个脚本中：

- `${BACKUP}/${DATETIME}/` 指定了文件将要被保存的目录。
- `${DATETIME}.sql.gz` 是文件的命名方式，这里结合了之前定义的 `DATETIME` 变量和 `.sql.gz` 后缀。

所以，完整的路径和文件名 `${BACKUP}/${DATETIME}/${DATETIME}.sql.gz` 指的是在 `${BACKUP}` 目录下，以 `${DATETIME}` 命名的子目录中，创建一个以 `${DATETIME}.sql.gz` 为名称的文件。由于 `mysqldump` 的输出被重定向到了这个路径和文件名，所以这个文件将会包含数据库的压缩备份。

这种命名方式有助于通过文件名就能识别出备份文件的创建时间，对于管理多个备份来说是非常有用的。





**如果没有这句话`> ${BACKUP}/${DATETIME}/${DATETIME}.sql.gz` ，默认的命名是什么形式呢?**

ChatGPT

如果您没有在 `mysqldump` 命令中指定输出文件的名称和路径，那么 `mysqldump` 将不会自动生成一个文件。相反，它会将导出的数据库输出到标准输出（通常是您的终端屏幕）。

例如，如果您只是运行：

```
bashCopy code
mysqldump -u${DB_USER} -p${DB_PW} --host=${HOST} -q -R --databases ${DATABASE}
```

这条命令会在命令行界面显示数据库的整个导出，除非您重定向输出到一个文件或者通过管道传递给另一个命令（例如 `gzip`）。

要将输出保存到一个文件，您必须使用重定向符号 `>` 后面跟上您希望保存的文件路径和文件名。在没有指定文件名的情况下，您必须手动执行这个操作，例如：

```
bashCopy code
mysqldump -u${DB_USER} -p${DB_PW} --host=${HOST} -q -R --databases ${DATABASE} > my_backup.sql
```

这里，`my_backup.sql` 就是您自定义的文件名。如果您不这样做，就不会有默认的文件名或路径。





**mysqldump 没有提供默认的文件名吗？如果没有  >  默认输出到哪里？**

ChatGPT

正确的，`mysqldump` 没有提供默认的文件名。如果您在使用 `mysqldump` 命令时不使用重定向符号 `>` 来指定一个输出文件，它默认会将导出的数据发送到标准输出，也就是您的命令行终端。

在命令行终端中，标准输出（stdout）通常是屏幕，因此不加重定向的 `mysqldump` 命令会将数据库的内容打印到屏幕上。这可以用于将输出通过管道传递给其他命令，比如 `gzip` 用于压缩或 `mysql` 用于直接将数据导入到另一个数据库中。

例如：

```
mysqldump -u${DB_USER} -p${DB_PW} --host=${HOST} --databases ${DATABASE} | mysql -u${DB_USER} -p${DB_PW} --host=other_host -C other_database
```

上面的命令行会将一个数据库的导出直接导入到另一个数据库中。

要保存输出到一个文件，您需要明确地使用 `>` 或 `>>`（追加到文件而不是覆盖文件）将输出重定向到一个文件中。









**`> ${BACKUP}/${DATETIME}/${DATETIME}.sql.gz `将压缩后的输出重定向到一个文件中，文件名包括时间戳，以 .sql.gz 结尾。这里必须指定以 .sql.gz 结尾吗？**

ChatGPT

不是必须的，指定以 `.sql.gz` 结尾是出于约定和清晰性考虑，但不是技术上的要求。

文件扩展名主要用于帮助用户和操作系统识别文件内容的类型。`.sql` 扩展名通常用于未压缩的 SQL 脚本文件，而 `.gz` 是 Gzip 压缩文件的标准扩展名。将它们组合为 `.sql.gz` 表示文件是一个压缩的 SQL 脚本。这有助于在管理文件时立即识别文件的内容和格式。

在命令 `mysqldump ... | gzip > ${BACKUP}/${DATETIME}/${DATETIME}.sql.gz` 中：

- `mysqldump` 命令生成的是 SQL 语句的纯文本输出。
- `gzip` 命令将这个纯文本压缩，并且默认的输出是二进制格式的。
- 重定向符号 `>` 将这个二进制输出写入到指定的文件中。

您可以选择任何文件名和扩展名，但为了维护方便，最好使用描述性的命名，比如包含 `.sql.gz`，这样做可以清晰地表明这是一个压缩的 SQL 数据备份文件。如果您用其他扩展名，将来可能不容易记住每个文件的具体内容。



**tar命令的选项 -z 可以用来会生成/解压.gz后缀的文件对吗？**

ChatGPT

是的，`tar` 命令的 `-z` 选项用于指定 `tar` 应该通过 `gzip` 程序来压缩或解压缩文件。当创建压缩归档时，通常会将 `-z` 与 `-c`（创建）和 `-f`（文件）选项一起使用，如下所示：

```
bashCopy code
tar -czf archive_name.tar.gz directory_to_compress
```

这将创建一个名为 `archive_name.tar.gz` 的压缩归档文件，其中包含了 `directory_to_compress` 目录的内容。

而在解压缩 `.tar.gz` 文件时，通常会将 `-z` 与 `-x`（解压缩）和 `-f` 选项一起使用，如下所示：

```
bashCopy code
tar -xzf archive_name.tar.gz
```

这将解压缩 `archive_name.tar.gz` 文件。

`-z` 选项告诉 `tar` 命令调用 `gzip` 压缩或解压缩数据。如果不使用 `-z`，`tar` 会创建或提取未压缩的归档文件。在最新版本的 `tar` 中，通常不需要显式指定 `-z` 选项，因为 `tar` 能够自动检测 `.gz` 扩展名并使用适当的压缩/解压缩程序。

---



~~~shell
#备份数据库
mysqldump -u${DB_USER} -p${DB_PW} --host=${HOST} -q -R --databases ${DATABASE} | gzip > ${BACKUP}/${DATETIME}/$DATETIME.sql.gz
~~~

上面这条命令是用来备份MySQL数据库的，它使用 `mysqldump` 工具进行数据库导出，然后通过 `gzip` 进行压缩。以下是命令中各部分的详细解释：

- `mysqldump`：这是MySQL提供的一个工具，用于创建数据库的备份（导出数据库的数据和结构到标准输出）。

- `-u${DB_USER}`：指定连接数据库的用户名，`${DB_USER}` 是一个变量，其值在脚本的前面部分定义（例如 `root`）。

- `-p${DB_PW}`：指定连接数据库的密码，`${DB_PW}` 是一个变量，包含了数据库用户的密码。出于安全原因，建议在实际使用中不要直接在命令行中包含密码，因为这可能会在系统的历史记录中留下敏感信息。

- `--host=${HOST}`：指定MySQL服务器的主机名或IP地址，`${HOST}` 是一个变量，通常设置为 `localhost`。

- `-q`：表示 "quick"。它会加快导出的速度，尤其是在处理大型数据库时。它通过减少锁定数据库表的时间来实现这一点。

- `-R`：表示导出存储过程和函数。

- `--databases ${DATABASE}`：指定要备份的数据库名称，`${DATABASE}` 是一个变量，其值也是在脚本的前面部分定义的。

- `| gzip`：这个管道命令 (`|`) 将 `mysqldump` 的输出传递给 `gzip` 命令，后者用于压缩数据。`gzip` 将标准输出压缩并输出到它的标准输出。

- `>`：这个是重定向操作符，它将 `gzip` 的压缩输出重定向到一个文件中。

- `${BACKUP}/${DATETIME}/${DATETIME}.sql.gz`：这是压缩文件的完整路径和文件名。`${BACKUP}` 和 `${DATETIME}` 是脚本前面定义的变量，分别代表备份的根目录和当前的日期时间。文件名 `${DATETIME}.sql.gz` 说明了文件是一个压缩的SQL文件，并且通过日期时间进行了命名，以便于知道备份是何时创建的。

总之，这条命令创建了一个压缩的数据库备份文件，该文件包含了指定数据库的所有数据和结构，并以当前的日期和时间命名，存储在指定的备份目录中。



**`mysqldump` 命令中的 `--databases` 选项确实允许您指定多个数据库进行备份。**当使用这个选项时，您可以在其后列出多个数据库名称，每个名称之间用空格分隔。这将导出每个指定的数据库的完整结构和数据，使得您可以在一个操作中备份多个数据库。

在您的命令中：

```bash
mysqldump -u${DB_USER} -p${DB_PW} --host=${HOST} -q -R --databases ${DATABASE} | gzip > ${BACKUP}/${DATETIME}/${DATETIME}.sql.gz
```

如果 `${DATABASE}` 变量包含一个数据库名称，那么它会备份那个单一的数据库。如果 `${DATABASE}` 包含多个数据库名称，用空格分隔，那么它将会备份所有列出的数据库。此外，使用 `--databases` 选项时，`mysqldump` 会在导出的文件中包含 `CREATE DATABASE` 和 `USE` 语句，这使得导出的 `.sql` 文件可以在导入时重新创建数据库。

例如，如果您想备份名为 `db1` 和 `db2` 的数据库，您可以将命令写成：

```bash
mysqldump -u${DB_USER} -p${DB_PW} --host=${HOST} -q -R --databases db1 db2 | gzip > ${BACKUP}/${DATETIME}/databases_${DATETIME}.sql.gz
```

在这里，`db1` 和 `db2` 将会被备份，并且备份文件将包含用于创建这些数据库的 SQL 语句。



**如果您这样定义变量：**

```bash
DATABASE="db1 db2"
```

然后在 `mysqldump` 命令中使用 `--databases ${DATABASE}`，在这种情况下，因为变量 `DATABASE` 包含了多个数据库名称，分隔符是空格，`mysqldump` 将会尝试备份这两个数据库。

但是，为了确保这种情况下的正确扩展（特别是在可能包含空格或特殊字符的情况下），最好是在引用时使用引号，如下所示：

```bash
mysqldump -u"${DB_USER}" -p"${DB_PW}" --host="${HOST}" -q -R --databases ${DATABASE} | gzip > "${BACKUP}/${DATETIME}/${DATETIME}.sql.gz"
```

当在变量中包含空格时，不加引号可能会导致 shell 错误地将它们解释为分隔的命令行参数。在这种情况下，因为您希望 `mysqldump` 识别 `db1` 和 `db2` 为不同的数据库名称，不加引号通常是可以的。但是，最佳实践是在变量扩展可能包含空格或特殊字符时使用引号，以确保命令按预期方式执行。

在实际的 shell 脚本中，您可能还需要考虑如何安全地处理密码，因为在命令行中直接使用 `-p` 选项可能会暴露密码。一个更安全的做法是将密码存储在客户端配置文件中，或者使用环境变量，而不是直接在命令行中传递。



## mysqldump指令

`mysqldump` 是一个用于导出 MySQL 数据库的内容到一个文本文件中的强大工具。在您提供的脚本中，`mysqldump` 命令用于备份数据库。以下是该命令中使用的一些常用选项的解释，以及它们的作用：

1. `-u${DB_USER}` 或 `-u [用户名]`
   - 指定连接到数据库的用户名。例如，`-uroot` 表示以 `root` 用户身份登录。

2. `-p${DB_PW}` 或 `-p[密码]`
   - 指定连接到数据库的密码。请注意，紧接在 `-p` 后面输入密码是不安全的做法，因为这样密码可能会显示在历史记录中。最佳实践是单独使用 `-p`，系统会提示您输入密码。在脚本中，为了自动化，可能会使用 `-p${DB_PW}` 的形式。

3. `--host=${HOST}` 或 `--host=[主机地址]`
   - 指定 MySQL 服务器的地址。如果 MySQL 服务器运行在本地机器上，通常使用 `localhost`。

4. `-q` 或 `--quick`
   - 快速模式。当备份大数据库时非常有用，因为它会减少内存使用量。它通过直接从服务器传输数据到 mysqldump 客户端而不是首先检索到内存中来实现这一点。

5. `-R` 或 `--routines`
   - 导出存储过程和函数。如果数据库中包含这些元素，您可能希望将它们包含在备份中。

6. `--databases [数据库名]`
   - 指定要导出的数据库。可以指定一个或多个数据库，数据库名之间用空格分隔。当指定多个数据库时，`mysqldump` 会为每个数据库添加 `CREATE DATABASE` 和 `USE` 语句。

7. `| gzip`
   - 这不是 `mysqldump` 的选项，而是一个将 `mysqldump` 的输出传递给 `gzip` 命令的管道，用于压缩导出的数据。这在处理大型数据库时非常有用，因为它可以显著减小备份文件的大小。

8. `> ${BACKUP}/${DATETIME}/$DATETIME.sql.gz`
   - 这也不是 `mysqldump` 的选项，而是一个重定向操作符，用于将 `gzip` 的压缩输出保存到一个文件中。这里指定了文件的存储路径和文件名。

这些选项组合在一起，提供了一个强大的工具来备份 MySQL 数据库，同时优化了速度和存储。通过压缩和指定备份文件的存储位置，您的脚本能够有效地管理备份过程。



### mysqldump 命令中的用户名和密码选项使用说明及安全性注意事项

在 MySQL 命令行工具（如 `mysqldump` 和 `mysql`）中，`-u` 和 `-p` 选项用于指定数据库的用户名和密码。这里是这些选项的简洁说明以及使用时的注意点：

1. **`-u` 和 `-uroot`**：
   - **意义**：`-u` 选项后跟着的是要连接到数据库的用户名。例如，`-uroot` 表示使用用户名 `root` 进行连接。
   - **格式**：选项 `-u` 与用户名之间不需要空格。例如，`-uroot`。
   - **注意点**：在脚本或命令行中明确指定用户名是安全的。

2. **`-p` 和 `-p密码`**：
   - **意义**：`-p` 选项用于指定连接数据库的密码。如果直接跟着密码（如 `-p密码`），则表示以该密码登录。
   - **格式**：当直接在 `-p` 后面跟密码时，两者之间没有空格，例如 `-pYourPassword`。
   - **注意点**：
     - **安全性**：直接在命令行中使用 `-p密码` 形式不安全，因为这样密码可能会被记录在命令历史或日志中。
     - **推荐做法**：最佳实践是仅使用 `-p`，不直接跟密码。这样，在执行命令时，系统会提示您输入密码，从而保护密码不被暴露。
     - **自动化脚本**：在自动化脚本中，尽管可以使用 `-p密码` 形式来避免交互式输入，但应谨慎处理，确保脚本的安全性。

总结：使用 `-u` 时直接跟用户名（如 `-uroot`）是常见且安全的做法。使用 `-p` 时，出于安全考虑，建议单独使用 `-p` 并在提示时输入密码，而不是直接将密码写在命令行中。

## find指令

~~~shell
#删除十天前的备份文件
find ${BACKUP} -atime +10 -name "*.tar.gz" -exec rm -rf {} \;
~~~

上面这条命令使用 `find` 命令搜索并删除在 `${BACKUP}` 目录下最后访问时间超过十天的 `.tar.gz` 压缩备份文件。下面是对该命令中各个部分的详细解释：

- `find`：这是一个强大的命令行工具，用于在指定目录下查找文件和目录。

- `${BACKUP}`：这是 `find` 命令搜索的目录，变量 `BACKUP` 在脚本的前面定义，代表备份文件存储的根目录。

- `-atime +10`：这个选项指定了 `find` 命令查找那些最后访问时间在当前时间之前至少十天的文件。`atime` 是 "access time" 的缩写，代表文件最后被读取或访问的时间。

- `-name "*.tar.gz"`：这个选项让 `find` 命令只查找那些名称匹配模式 `*.tar.gz` 的文件，也就是以 `.tar.gz` 结尾的文件，这通常是压缩文件的扩展名。

- `-exec rm -rf {} \;`：这个选项定义了一旦找到匹配的文件，`find` 命令就会执行的动作。`-exec` 后面跟着的是要执行的命令，这里是 `rm -rf`，用于删除文件或目录。
  
  - `rm` 是 "remove" 的缩写，用于删除文件或目录。
  - `-r` 或 `-R` 表示递归删除，使得 `rm` 可以删除目录及其所有内容。
  - `-f` 表示 "force"，用于强制删除，不会询问确认也不会因为特定的错误而停止。
  
  `{}` 是 `find` 命令的占位符，它在执行时会被替换为当前找到的文件名。
  
  `\;` 是 `-exec` 选项的参数终止符，告诉 `find` 命令 `-exec` 参数到此结束。

总结来说，这条命令的作用是在 `${BACKUP}` 目录下查找所有最后访问时间超过十天的 `.tar.gz` 文件，并将这些文件删除。这是一种清理旧备份的常用方法，以确保不会因为积累过多过时的备份文件而耗尽磁盘空间。



---



# 1.VM虚拟机网络连接问题

## 1.1 VMware中出现“此主机不支持64位客户机操作系统，此系统无法运行” 或者 “VMware Workstation 与 Hyper-V不兼容 ”的问题

1、问题阐述与截图
在桌面虚拟机软件VMVare Workstation中创建新的虚拟机，选择客户机操作系统时，出现“此主机不支持64位客户机操作系统，此系统无法运行”的警告（如图1），

![img](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/format,png.png)

如果无视这个问题，直接点击“下一步”，倒也可以完成环境的配置，但是后面想要开启此虚拟机并正式安装红帽系统时，会出现“ VMware Workstation 与 Hyper-V不兼容 ”的提示（如图2），需要移除Hyper-V然后再运行VMWare安装RHEL。

![img](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/20191015114859593.png)



这两个问题出现的根本原因都是Hyper-V和VMware冲突了，因此解决这个问题就需要关闭Hyper-V。

2、解决方法
（1）通过命令行（亲测可行，个人认为最简单）
以管理员身份运行命令提示符（cmd），然后执行命令  bcdedit /set hypervisorlaunchtype off  ，执行完后重启计算机即可解决。

~~~
bcdedit /set hypervisorlaunchtype off 
~~~



## 1.2 虚拟机中Linux无法联网，VMware DHCP服务启动后停止

 笔记本新安装的workstation，接着装了centOS-7，开机后无法联网，首先检查下这两个服务，八成是没起来。

![image-20240112193015083](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240112193015083.png)


 VMware DHCP service启动不起来应该是这个地方没勾选,就按照图上勾选就行了，不用改什么配置文件

![img](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/a00e388c2e4a4a2ea3fd42bb685795cf.png)

最后   执行下 service network restart  ? 重启虚拟机 ,重启下面两个服务  应该就可以了  。

![img](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/118d5b016765435a90c155d86cb67a1d.png)





![image-20240112193015083](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240112193015083.png)





## 在虚拟机中设置静态 IP 地址

通常涉及两个步骤：首先，在虚拟化软件（如 VMware、VirtualBox 等）中配置网络设置，然后在虚拟机的操作系统内部配置 IP 地址。

1. **打开网络配置文件**：根据您的网络接口（通常是 `eth0` 或 `ens33` 等），打开相应的配置文件。例如：

~~~
[root@hspEdu01 ~]# sudo vi /etc/sysconfig/network-scripts/ifcfg-ens33

YPE=Ethernet
PROXY_METHOD=none
BROWSER_ONLY=no
BOOTPROTO=dhcp
DEFROUTE=yes
IPV4_FAILURE_FATAL=no
IPV6INIT=yes
IPV6_AUTOCONF=yes
IPV6_DEFROUTE=yes
IPV6_FAILURE_FATAL=no
IPV6_ADDR_GEN_MODE=stable-privacy
NAME=ens33
UUID=2e5a5c25-b0b3-489a-aecd-1461cf86d9d8
DEVICE=ens33
ONBOOT=yes
~                               
~~~

2. **编辑配置文件**：配置文件中有多个选项，您可以设置静态 IP 地址或设置为 DHCP。对于静态 IP，通常需要设置 `BOOTPROTO` 为 `none` 或 `static`，并指定 `IPADDR`、`NETMASK`、`GATEWAY` 和 `DNS` 等：

```
makefileCopy codeBOOTPROTO=static
IPADDR=192.168.1.100
NETMASK=255.255.255.0
GATEWAY=192.168.1.1
DNS1=8.8.8.8
ONBOOT=yes
```

对于 DHCP（自动获取 IP），则设置 `BOOTPROTO=dhcp`。

3. **重启网络服务**：保存配置并重启网络服务来应用更改：

```
shCopy code
sudo systemctl restart network
```

或者重启虚拟机。



##  DHCP 的含义

当在 Linux 中的网络配置文件中设置 `BOOTPROTO=dhcp`，这意味着网络接口将被配置为使用 DHCP (Dynamic Host Configuration Protocol) 来自动获取其 IP 地址、子网掩码、默认网关和 DNS 服务器地址。

这里是具体含义：

- **DHCP (动态主机配置协议)**：这是一个网络管理协议，用于自动分配 IP 地址给设备，以便它们可以在网络上通信。
- **`BOOTPROTO=dhcp`**：这个设置告诉系统在启动时自动从网络上的 DHCP 服务器请求 IP 地址和其他网络设置。这样做的好处是您不需要手动配置网络设置，特别是当您处在经常变化的网络环境中时（如 WiFi 网络）。

设置 `BOOTPROTO=dhcp` 后，当系统启动或网络服务重启时，网络接口会向网络上的 DHCP 服务器发送一个请求，询问它应该使用的网络设置。如果在网络上配置了 DHCP 服务器（在大多数网络中通常都有），它会回应并为网络接口提供一个 IP 地址以及其他必要的网络配置信息。

如果您在虚拟机或者任何 Linux 系统中使用 `BOOTPROTO=dhcp`，确保您的网络环境中有可响应 DHCP 请求的 DHCP 服务器。大多数家用路由器和企业级网络都内建了 DHCP 服务器。







## 1.3 VM虚拟机NAT模式连不上网问题

#### 1.宿主IP配置相关

物理主机F2 IPV4为：192.168.0.12

![image-20240112191215742](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240112191215742.png)

![image-20240112194326151](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240112194326151.png)



![image-20240113175635254](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240113175635254.png)

**为什么一般不需要为VMNet8勾选共享网络呢？**

ChatGPT

在VMware中，VMnet8是一个虚拟网络适配器，它被配置为NAT模式，允许虚拟机通过宿主机的物理网络接口访问外部网络。VMnet8适配器本身就是一个内置的NAT设备，它管理虚拟机和宿主机之间的网络流量转发。因此，通常情况下，不需要在VMnet8上启用“共享网络”。

这里是不勾选“共享网络”的几个原因：

1. **内置NAT服务**：VMware为NAT模式提供了内置的NAT服务，这个服务在宿主机上运行，负责管理虚拟机与外部网络之间的流量。因此，不需要通过Windows的“共享网络”功能来分享宿主机的网络连接。
2. **避免冲突**：如果在VMnet8上启用了Windows的“共享网络”，可能会导致网络配置冲突，因为这样会有两个NAT层：Windows的网络共享服务和VMware的NAT服务。
3. **简化网络设置**：VMware旨在提供一个简单的网络设置过程，自动配置NAT、DHCP等服务，以便用户不需要手动进行复杂的网络设置。
4. **安全与隔离**：VMware的NAT模式提供了一个隔离的网络环境，这有助于提高安全性，因为虚拟机不会直接暴露在局域网上。

总之，VMware的NAT模式设计为自包含和自管理，不需要额外的网络共享。当您选择NAT模式时，VMware会自动处理所有的网络流量路由，无需用户干预。这是为什么通常不需要也不建议为VMnet8勾选“共享网络”。



![image-20240112191034031](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240112191034031.png)

#### 2.虚拟网卡VMNet8 配置相关:

VMware Virtual Ethernet Adapter for VMnet8  IPv4 地址: 192.168.137.1

最好设置为自动获取否则后面会出现宿主机ping不通虚拟机的情况

![image-20240112190631853](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240112190631853.png)

![image-20240113174255779](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240113174255779.png)

但是在宿主机ping NAT模式的虚拟机时用到了上图的VMnet8，最好不要禁用！！ 



![image-20240114013433918](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240114013433918.png)

![image-20240114011414434](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240114011414434.png)

如果宿主机VMNet8配置有误会导致宿主机ping不通虚拟机

通过命令查看宿主机VMNet8自动分配的IP地址为**192.168.2.1**

因此将虚拟机子网的网关设置为第二号IP**192.168.2.2**最合适

~~~
C:\WINDOWS\system32>ipconfig /all
Ethernet adapter VMware Network Adapter VMnet8:

   Connection-specific DNS Suffix  . :
   Description . . . . . . . . . . . : VMware Virtual Ethernet Adapter for VMnet8
   Physical Address. . . . . . . . . : 00-50-56-C0-00-08
   DHCP Enabled. . . . . . . . . . . : Yes
   Autoconfiguration Enabled . . . . : Yes
   IPv4 Address. . . . . . . . . . . : 192.168.2.1(Preferred)
   Subnet Mask . . . . . . . . . . . : 255.255.255.0
   Lease Obtained. . . . . . . . . . : 2024年1月14日 1:02:18
   Lease Expires . . . . . . . . . . : 2024年1月14日 1:47:17
   Default Gateway . . . . . . . . . : 0.0.0.0
   DHCP Server . . . . . . . . . . . : 192.168.2.254
   Primary WINS Server . . . . . . . : 192.168.2.1
   NetBIOS over Tcpip. . . . . . . . : Enabled
   
   
~~~







#### 2. 虚拟机 配置相关:

这里的VMnet8 才是用到的和虚拟机网络连接的配置

编辑->虚拟网络编辑器配置如下：

![image-20240112200447804](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240112200447804.png)

在许多家庭和小型办公室网络中，网关地址通常被配置为子网中的第一个主机地址，也就是以`.1`结束的地址（例如`192.168.1.1`或`192.168.0.1`）。这是一种常见的约定，但并不是强制性的网络标准。网关地址可以是子网中的任何有效主机地址，这取决于网络管理员的配置。

在企业或大型网络环境中，网关的IP地址可能根据特定的网络设计和规划而有所不同。网络设计者可能会基于各种原因选择不同的地址作为网关，例如网络策略、安全考虑或是出于历史配置的延续。

因此，尽管`.1`作为网关是非常普遍的做法，但并不是唯一的选择。网络的实际配置应该总是查阅相关的网络文档或通过网络设置来确定。

![image-20240112204059671](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240112204059671.png)

<img src="https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240112200742424.png" alt="image-20240112200742424" style="zoom: 67%;" />





虚拟机IPV4: 192.168.100.128

![image-20240112192635021](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240112192635021.png)



总结：

1. **物理主机的IP地址**（例如192.168.0.12）:
   - 这是宿主机在其所连接的局域网中的IP地址，由物理网络的DHCP服务分配。宿主机通过这个IP地址与局域网和互联网通信。
2. **虚拟机使用的网络适配器vmnet8**：
   - 这是用于NAT模式的虚拟网络适配器。虽然名称相同，但其配置和IP地址范围与VMware Network Adapter VMnet8不同。这个适配器的子网可能是192.168.100.0/24，并且虚拟机的IP地址如192.168.100.128。虚拟机通过这个适配器上的网关（192.168.100.1）连接到外部网络。
3. **未使用的VMware Network Adapter VMnet8**（IP地址为192.168.137.1）:
   - 这是一个配置在192.168.137.0/24子网上的虚拟网络适配器，目前未被虚拟机使用。它的IP地址192.168.137.1通常是这个子网内虚拟机的默认网关，但在这种情况下，它是闲置的。

流量通道描述：

当虚拟机尝试访问互联网时，数据包流程如下：

- 虚拟机（例如，IP地址为192.168.100.128）发送数据包到其配置的默认网关（192.168.100.1）。
- 网络适配器vmnet8接收数据包，然后VMware的NAT服务处理这些数据包，允许数据包通过物理主机的网络接口传输。
- 物理主机（IP地址为192.168.0.12）接收到这些数据包，并通过其连接到路由器的网络接口（无线或有线）将数据包转发到互联网。
- 路由器处理数据包，将其发送到互联网。返回的数据包走相同的路径回到虚拟机。

这样，虚拟机可以通过物理主机的网络接口访问互联网，尽管它们处于不同的IP地址范围内。通过NAT配置，虚拟机的流量似乎来自物理主机的IP地址，这使得虚拟机能够无缝访问外部资源。

 



---



---

# 2 Xshell7连接Linux服务器设置

## 0 注意细节 

取消 工具-选项 的勾选，解决“XShell7 使用时复制的内容粘贴到Xshell7时，竟然自动执行了，我还没回车呢。如何解决”

![image-20240128011621661](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240128011621661.png)



## 1.使用代理时进行Xshell7连接虚拟机Linux，出现连接已经建立，但之后被远程主机关闭

首先不要使用代理！

否则Xshell7连接时会出报下面的信息

~~~
Connecting to 192.168.2.129:22...
Connection established.
To escape to local shell, press 'Ctrl+Alt+]'.
Connection closing...Socket close.

Connection closed by foreign host.

Disconnected from remote host(192.168.2.129[hspedu100]) at 23:03:19.

Type `help' to learn how to use Xshell prompt.
~~~

是说当尝试使用Xshell连接到远程主机（192.168.2.129）时，连接已经建立，但之后被远程主机关闭了。这通常意味着连接到服务器的过程中存在一些问题。

解决方法，关闭代理

接着会出现下面的问题Xshell7连接虚拟机失败 和 宿主机ping虚拟机请求超时

![image-20240114011533125](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240114011533125.png)

## 2. 宿主机ping虚拟机请求超时

#### 虚拟机ping主机可以通，但宿主机ping虚拟机就请求超时

ping 192.168.2.129

~~~
C:\WINDOWS\system32>ping 192.168.2.129

Pinging 192.168.2.129 with 32 bytes of data:
Request timed out.
Request timed out.
Request timed out.
Request timed out.

Ping statistics for 192.168.2.129:
    Packets: Sent = 4, Received = 0, Lost = 4 (100% loss),


~~~





解决办法
打开电脑的设置，找到网络
![在这里插入图片描述](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBAX3N0cml2aW5nXw==,size_20,color_FFFFFF,t_70,g_se,x_16.png)
![在这里插入图片描述](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBAX3N0cml2aW5nXw==,size_20,color_FFFFFF,t_70,g_se,x_16-17051654514379.png)
[VMware](https://so.csdn.net/so/search?q=VMware&spm=1001.2101.3001.7020) Network Adapter VMnet1和 VMware Network Adapter VMnet8 分别进行如下操作

![在这里插入图片描述](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBAX3N0cml2aW5nXw==,size_20,color_FFFFFF,t_70,g_se,x_16-170516545143710.png)
![在这里插入图片描述](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBAX3N0cml2aW5nXw==,size_14,color_FFFFFF,t_70,g_se,x_16.png)
然后就可以了

~~~
C:\WINDOWS\system32>ping 192.168.2.129

Pinging 192.168.2.129 with 32 bytes of data:
Reply from 192.168.2.129: bytes=32 time<1ms TTL=64
Reply from 192.168.2.129: bytes=32 time<1ms TTL=64
Reply from 192.168.2.129: bytes=32 time<1ms TTL=64
Reply from 192.168.2.129: bytes=32 time<1ms TTL=64

Ping statistics for 192.168.2.129:
    Packets: Sent = 4, Received = 4, Lost = 0 (0% loss),
Approximate round trip times in milli-seconds:
    Minimum = 0ms, Maximum = 0ms, Average = 0ms
~~~



下面是网络适配器的配置

![image-20240114011318880](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240114011318880.png)

![image-20240114011414434](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240114011414434.png)



Ethernet adapter VMware Network Adapter VMnet8作为虚拟机的网关192.168.2.1

~~~
Ethernet adapter VMware Network Adapter VMnet8:

   Connection-specific DNS Suffix  . :
   Description . . . . . . . . . . . : VMware Virtual Ethernet Adapter for VMnet8
   Physical Address. . . . . . . . . : 00-50-56-C0-00-08
   DHCP Enabled. . . . . . . . . . . : Yes
   Autoconfiguration Enabled . . . . : Yes
   IPv4 Address. . . . . . . . . . . : 192.168.2.1(Preferred)
   Subnet Mask . . . . . . . . . . . : 255.255.255.0
   Lease Obtained. . . . . . . . . . : 2024年1月14日 1:02:18
   Lease Expires . . . . . . . . . . : 2024年1月14日 1:47:17
   Default Gateway . . . . . . . . . : 0.0.0.0
   DHCP Server . . . . . . . . . . . : 192.168.2.254
   Primary WINS Server . . . . . . . : 192.168.2.1
   NetBIOS over Tcpip. . . . . . . . : Enabled

Wireless LAN adapter WLAN 2:

   Connection-specific DNS Suffix  . :
   Description . . . . . . . . . . . : Intel(R) Wireless-N 7265
   Physical Address. . . . . . . . . : 44-03-2C-E3-BF-07
   DHCP Enabled. . . . . . . . . . . : Yes
   Autoconfiguration Enabled . . . . : Yes
   IPv4 Address. . . . . . . . . . . : 192.168.43.191(Preferred)
   Subnet Mask . . . . . . . . . . . : 255.255.255.0
   Lease Obtained. . . . . . . . . . : 2024年1月14日 0:57:11
   Lease Expires . . . . . . . . . . : 2024年1月14日 1:58:38
   Default Gateway . . . . . . . . . : 192.168.43.1
   DHCP Server . . . . . . . . . . . : 192.168.43.1
   DNS Servers . . . . . . . . . . . : 192.168.43.1
   NetBIOS over Tcpip. . . . . . . . : Enabled
~~~

![image-20240114013358273](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240114013358273.png)

如果宿主机VMNet8配置有误会导致宿主机ping不通虚拟机

通过命令查看宿主机VMNet8自动分配的IP地址为**192.168.2.1**

因此将虚拟机子网的网关设置为第二号IP**192.168.2.2**最合适

~~~
C:\WINDOWS\system32>ipconfig /all
Ethernet adapter VMware Network Adapter VMnet8:

   Connection-specific DNS Suffix  . :
   Description . . . . . . . . . . . : VMware Virtual Ethernet Adapter for VMnet8
   Physical Address. . . . . . . . . : 00-50-56-C0-00-08
   DHCP Enabled. . . . . . . . . . . : Yes
   Autoconfiguration Enabled . . . . : Yes
   IPv4 Address. . . . . . . . . . . : 192.168.2.1(Preferred)
   Subnet Mask . . . . . . . . . . . : 255.255.255.0
   Lease Obtained. . . . . . . . . . : 2024年1月14日 1:02:18
   Lease Expires . . . . . . . . . . : 2024年1月14日 1:47:17
   Default Gateway . . . . . . . . . : 0.0.0.0
   DHCP Server . . . . . . . . . . . : 192.168.2.254
   Primary WINS Server . . . . . . . : 192.168.2.1
   NetBIOS over Tcpip. . . . . . . . : Enabled
~~~

和物理网络连接的WIFI的IP地址如下：

~~~

Wireless LAN adapter WLAN 2:

   Connection-specific DNS Suffix  . :
   Description . . . . . . . . . . . : Intel(R) Wireless-N 7265
   Physical Address. . . . . . . . . : 44-03-2C-E3-BF-07
   DHCP Enabled. . . . . . . . . . . : Yes
   Autoconfiguration Enabled . . . . : Yes
   IPv4 Address. . . . . . . . . . . : 192.168.43.191(Preferred)
   Subnet Mask . . . . . . . . . . . : 255.255.255.0
   Lease Obtained. . . . . . . . . . : 2024年1月14日 0:57:11
   Lease Expires . . . . . . . . . . : 2024年1月14日 1:58:38
   Default Gateway . . . . . . . . . : 192.168.43.1
   DHCP Server . . . . . . . . . . . : 192.168.43.1
   DNS Servers . . . . . . . . . . . : 192.168.43.1
   NetBIOS over Tcpip. . . . . . . . : Enabled
~~~



**经过以上设置后，网络通畅！**

宿主机ping test:

~~~
#ping 虚拟机子网的网关IP
C:\WINDOWS\system32>ping 192.168.2.2

Pinging 192.168.2.2 with 32 bytes of data:
Reply from 192.168.2.2: bytes=32 time<1ms TTL=64
Reply from 192.168.2.2: bytes=32 time<1ms TTL=64
Reply from 192.168.2.2: bytes=32 time<1ms TTL=64
Reply from 192.168.2.2: bytes=32 time<1ms TTL=64

Ping statistics for 192.168.2.2:
    Packets: Sent = 4, Received = 4, Lost = 0 (0% loss),
Approximate round trip times in milli-seconds:
    Minimum = 0ms, Maximum = 0ms, Average = 0ms
#ping 虚拟机IP
C:\WINDOWS\system32>ping 192.168.2.129

Pinging 192.168.2.129 with 32 bytes of data:
Reply from 192.168.2.129: bytes=32 time<1ms TTL=64
Reply from 192.168.2.129: bytes=32 time<1ms TTL=64
Reply from 192.168.2.129: bytes=32 time<1ms TTL=64
Reply from 192.168.2.129: bytes=32 time<1ms TTL=64

Ping statistics for 192.168.2.129:
    Packets: Sent = 4, Received = 4, Lost = 0 (0% loss),
Approximate round trip times in milli-seconds:
    Minimum = 0ms, Maximum = 0ms, Average = 0ms
~~~

虚拟机ping 外界test:

 

~~~
#虚拟机ping 本身所在的子网网关
[root@hspEdu01 ~]# ping 192.168.2.2
PING 192.168.2.2 (192.168.2.2) 56(84) bytes of data.
64 bytes from 192.168.2.2: icmp_seq=1 ttl=128 time=0.118 ms
64 bytes from 192.168.2.2: icmp_seq=2 ttl=128 time=0.100 ms
64 bytes from 192.168.2.2: icmp_seq=3 ttl=128 time=0.137 ms
--- 192.168.2.2 ping statistics ---
7 packets transmitted, 7 received, 0% packet loss, time 6001ms
rtt min/avg/max/mdev = 0.100/0.136/0.163/0.022 ms

#虚拟机ping 宿主机
[root@hspEdu01 ~]# ping 192.168.43.191
PING 192.168.43.191 (192.168.43.191) 56(84) bytes of data.
64 bytes from 192.168.43.191: icmp_seq=1 ttl=128 time=0.600 ms
64 bytes from 192.168.43.191: icmp_seq=2 ttl=128 time=0.538 ms
64 bytes from 192.168.43.191: icmp_seq=3 ttl=128 time=0.523 ms
--- 192.168.43.191 ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3002ms
rtt min/avg/max/mdev = 0.523/0.559/0.600/0.042 ms

#虚拟机ping 百度
[root@hspEdu01 ~]# ping www.baidu.com
PING www.a.shifen.com (220.181.38.150) 56(84) bytes of data.
64 bytes from 220.181.38.150 (220.181.38.150): icmp_seq=1 ttl=128 time=0.428 ms
64 bytes from 220.181.38.150 (220.181.38.150): icmp_seq=2 ttl=128 time=0.434 ms
64 bytes from 220.181.38.150 (220.181.38.150): icmp_seq=3 ttl=128 time=0.446 ms
--- www.a.shifen.com ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 4054ms
rtt min/avg/max/mdev = 0.428/0.441/0.459/0.028 ms

~~~

此时在进行Xshell7远程连接，连接虚拟机Linux服务器主机成功！

![image-20240114015301812](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240114015301812.png)

---

# 3 
