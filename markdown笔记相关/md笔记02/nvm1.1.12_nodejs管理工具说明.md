# 1 nvm基本使用

项目地址：https://github.com/coreybutler/nvm-windows

nvm1.1.12是一款node.js版本管理工具，可以在一台windows上切换不同版本的node.js
用于管理node.js版本，因为有的项目需要使用特定版本的node.js
如：老韩的分布式项目需要使用安装 node.js10.16.3，
在安装 node.js 时, 会安装 npm， npm 是随 nodejs 安装的一款包管理工具, 类似
Maven(老师前面已经讲过了，再啰嗦一句)

用法
nvm-windows 在管理员 shell 中运行。您需要powershell以管理员身份启动或命令提示符才能使用 nvm-windows
NVM for Windows 是一个命令行工具。只需nvm在控制台中输入即可获得帮助。

nvm安装后，必须为每个安装的节点【不同版本的Node.js】版本重新安装全局实用程序（例如 yarn）：
使用举例：

~~~sh
1. 安装并使用 Node.js 10.16.3

nvm install 10.16.3
nvm use 10.16.3
npm install -g yarn    # 在 14.0.0 版本中安装 yarn

2. 切换到 Node.js 22.12.0

nvm use 22.12.0        # 切换版本后，之前安装的 yarn 不可用
npm install -g yarn    # 需要重新安装 yarn
~~~



基本操作：

~~~sh
# 检查当前 Node.js 版本
node -v

# 检查全局安装的包
npm list -g --depth=0

# 切换版本后再次检查
nvm use 另一个版本
nvm use 22.12.0
npm list -g --depth=0  # 会发现全局包列表不同
~~~





通过nvm1.1.12安装的nodejs，会默认安装到D:\Java_developer_tools\program\nodejs\ 目录下【自己配制的nodejs全局包的位置】
D:\Java_developer_tools\program\nvm\nvm1.1.12\v10.16.3【自动配制的不同的nodejs版本所在位置】

这一直是一个节点版本管理器，而不是 io.js 管理器，因此没有对 io.js 的反向支持。
支持 Node 4+。请记住，运行nvm install或时nvm use，Windows 通常需要管理权限（以创建符号链接）。
要安装最新版本的 Node.js，请运行nvm install latest。要安装最新的稳定版本，请运行nvm install lts【通常使用这个】。


用法
nvm-windows 在管理员 shell 中运行。您需要powershell以管理员身份启动或命令提示符才能使用 nvm-windows

NVM for Windows 是一个命令行工具。只需nvm在控制台中输入即可获得帮助。基本命令是：

nvm arch [32|64]：显示节点是否在 32 位或 64 位模式下运行。指定 32 或 64 以覆盖默认架构。
nvm debug：检查 NVM4W 进程是否存在已知问题。
nvm current：显示现行版本。
nvm install <version> [arch]：版本可以是特定版本，“latest”表示最新当前版本，“lts”表示最新的 LTS 版本。可选择指定是否安装 32 位或 64 位版本（默认为系统架构）。将 [arch] 设置为“all”可安装 32 位和 64 位版本。添加--insecure到此命令末尾可绕过远程下载服务器的 SSL 验证。
nvm list [available]：列出 node.js 安装。available在末尾输入以显示可供下载的版本列表。
nvm on：启用node.js版本管理。
nvm off：禁用 node.js 版本管理（不卸载任何东西）。
nvm proxy [url]：设置下载时使用的代理。留空[url]可查看当前代理。设置[url]为“无”可删除代理。
nvm uninstall <version>：卸载特定版本。
nvm use <version> [arch]：切换到使用指定版本。可选择使用latest、lts或newest。newest是最新安装的版本。可选择指定 32/64 位架构。nvm use <arch>将继续使用所选版本，但切换到 32/64 位模式。有关use在特定目录中使用（或使用.nvmrc）的信息，请参阅问题 #16。
nvm root <path>：设置nvm存放不同版本node.js的目录，若未<path>设置则显示当前根目录。
nvm version：显示当前运行的 Windows 版 NVM 版本。
nvm node_mirror <node_mirror_url>：设置节点镜像。国内可以使用https://npmmirror.com/mirrors/node/
nvm npm_mirror <npm_mirror_url>：设置 npm 镜像。国内可以使用https://npmmirror.com/mirrors/npm/



# 2 nvm 安装不同版本的node.js时的命令

~~~sh
Windows PowerShell
版权所有 (C) Microsoft Corporation。保留所有权利。

尝试新的跨平台 PowerShell https://aka.ms/pscore6

PS D:\Java_developer_tools\program\nvm\nvm1.1.12> nvm arch [32|64]
所在位置 行:1 字符: 14
+ nvm arch [32|64]
+              ~~
只允许将表达式作为管道的第一个元素。
所在位置 行:1 字符: 16
+ nvm arch [32|64]
+                ~
表达式或语句中包含意外的标记“]”。
    + FullyQualifiedErrorId : ExpressionsMustBeFirstInPipeline
PS D:\Java_developer_tools\program\nvm\nvm1.1.12> nvm arch
System Default: 64-bit.
Currently Configured: -bit.
PS D:\Java_developer_tools\program\nvm\nvm1.1.12> nvm debug
Running NVM for Windows with administrator privileges.

管理员: Windows PowerShell
Windows Version: 10.0 (Build 19045)

NVM4W Version:      1.1.12
NVM4W Settings:     D:\Java_developer_tools\program\nvm\nvm1.1.12\settings.txt
NVM_SYMLINK:        D:\Java_developer_tools\program\nodejs
Node Installations: D:\Java_developer_tools\program\nvm\nvm1.1.12

Total Node.js Versions: 0
Active Node.js Version: none
(run "nvm use <version>" to activate a version)
NVM_SYMLINK does not exist yet. This is auto-created when "nvm use" is run.


No problems detected.

Find help at https://github.com/coreybutler/nvm-windows/wiki/Common-Issues
PS D:\Java_developer_tools\program\nvm\nvm1.1.12> nvm current
No current version. Run 'nvm use x.x.x' to set a version.
PS D:\Java_developer_tools\program\nvm\nvm1.1.12> nvm install 10.16.3
Downloading node.js version 10.16.3 (64-bit)...
Complete

Downloading npm version 6.9.0... Complete
Installing npm v6.9.0...

Installation complete. If you want to use this version, type

nvm use 10.16.3
PS D:\Java_developer_tools\program\nvm\nvm1.1.12> nvm use 10.16.3
PS D:\Java_developer_tools\program\nvm\nvm1.1.12> npm install -g yarn
> yarn@1.22.22 preinstall D:\Java_developer_tools\program\nodejs\node_modules\yarn
> :; (node ./preinstall.js > /dev/null 2>&1 || true)

D:\Java_developer_tools\program\nodejs\yarn -> D:\Java_developer_tools\program\nodejs\node_modules\yarn\bin\yarn.js
+ yarn@1.22.22
PS D:\Java_developer_tools\program\nvm\nvm1.1.12> nvm install lts
Downloading node.js version 22.12.0 (64-bit)...
Extracting node and npm...
Complete
npm v10.9.0 installed successfully.


Installation complete. If you want to use this version, type

nvm use 22.12.0
PS D:\Java_developer_tools\program\nvm\nvm1.1.12> npm install -g yarn

> yarn@1.22.22 preinstall D:\Java_developer_tools\program\nodejs\node_modules\yarn
> :; (node ./preinstall.js > /dev/null 2>&1 || true)

D:\Java_developer_tools\program\nodejs\yarnpkg -> D:\Java_developer_tools\program\nodejs\node_modules\yarn\bin\yarn.js
D:\Java_developer_tools\program\nodejs\yarn -> D:\Java_developer_tools\program\nodejs\node_modules\yarn\bin\yarn.js
+ yarn@1.22.22
updated 1 package in 0.313s
PS D:\Java_developer_tools\program\nvm\nvm1.1.12> node -v
v10.16.3
PS D:\Java_developer_tools\program\nvm\nvm1.1.12> npm list -g --depth=0
D:\Java_developer_tools\program\nodejs
+-- npm@6.9.0
`-- yarn@1.22.22

PS D:\Java_developer_tools\program\nvm\nvm1.1.12> nvm use 22.12.0
Now using node v22.12.0 (64-bit)
PS D:\Java_developer_tools\program\nvm\nvm1.1.12> npm list -g --depth=0
D:\Java_developer_tools\program\nodejs -> .\
+-- corepack@0.29.4
`-- npm@10.9.0

PS D:\Java_developer_tools\program\nvm\nvm1.1.12>
~~~





基本操作：

~~~
# 检查当前 Node.js 版本
node -v

# 检查全局安装的包
npm list -g --depth=0

# 切换版本后再次检查
nvm use 另一个版本
npm list -g --depth=0  # 会发现全局包列表不同
~~~



### 最佳实践：

~~~
# 1. 创建常用全局包清单
echo "yarn" > global-packages.txt
echo "typescript" >> global-packages.txt
# ... 添加其他常用包

# 2. 切换版本后批量安装
Get-Content global-packages.txt | ForEach-Object { npm install -g $_ }
~~~



### 原理解释：

~~~
nvm 的工作方式：
└── nvm
    ├── v12.0.1
    │   └── node_modules (全局包位置1)
    └── v14.0.0
        └── node_modules (全局包位置2)
~~~



建议：可以考虑

1. 优先使用包管理器（如 Chocolatey）安装 yarn
2. 这样可以避免切换 Node.js 版本时需要重新安装
3. 更容易管理和更新

所以，如果你已经用包管理器安装了 yarn，就不需要再执行 npm install -g yarn 了。

# 3 npm i -g yarn 这句话是什么意思

让我解释这个命令的每个部分：

~~~
npm        # Node.js 的包管理器
i          # install 的简写
-g         # global 的简写，表示全局安装
yarn       # 要安装的包名，这是另一个包管理器


完整写法：
# 这两个命令是等价的：
npm i -g yarn
npm install --global yarn
~~~





### 建议：

在同一个项目中最好只使用一种包管理器

团队开发时建议统一使用相同的包管理器

记录使用的包管理器版本





# 4 yarn 的基本使用：





~~~
# 初始化项目
yarn init

# 安装依赖
yarn add [包名]        # 本地安装
yarn global add [包名]  # 全局安装

# 删除依赖
yarn remove [包名]

# 更新依赖
yarn upgrade
~~~



### npm 与 yarn 的区别：

~~~
npm install           = yarn
npm install [包名]    = yarn add [包名]
npm uninstall [包名]  = yarn remove [包名]
npm update           = yarn upgrade
~~~





# 5 npm 是 Node.js 自带的包管理器。关于是否需要安装 yarn，我来解释一下：





### 1. npm 与 yarn 的比较：

~~~
# npm 优点：
- Node.js 自带，无需额外安装
- 生态系统最完整
- 最新版本性能已经很好

# yarn 优点：
- 可能比旧版本 npm 快
- 某些项目可能特别指定使用 yarn
- 某些开发者习惯使用 yarn
~~~

### 2. 实际使用建议：

```bash
# 以下情况可以只用 npm：
- 个人小项目
- npm 版本较新（>= 7.x）
- 团队统一使用 npm

# 以下情况可能需要 yarn：
- 项目特别指定使用 yarn
- 团队统一使用 yarn
- package.json 中有 yarn.lock 文件
```

### 3. 结论：

```
1. 如果你是新手，只用 npm 完全够用
2. 不需要为了安装 yarn 而安装 yarn
3. 等到项目真正需要时再安装也不迟
```

### 4. 使用建议：

```bash
# 坚持使用一种包管理器：
- 要么用 npm
- 要么用 yarn
- 不要在同一项目中混用
```

所以，如果你刚开始学习 Node.js，完全可以只使用自带的 npm，不需要安装 yarn。