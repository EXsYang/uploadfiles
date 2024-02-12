# 命令总结

当然，根据您提供的命令历史记录，这里是按类别整理且去重的正确命令列表：

1. **克隆仓库（Cloning Repositories）**:
   - `git clone https://github.com.cnpmjs.org/thx/gogocode.git`
   - `git clone git@github.com:YoYoDeveloper/phdbcsv.git`
   - `git clone https://github.com/hwdsl2/setup-ipsec-vpn.git`
   - `git clone https://github.com/Chuyu-Team/Dism-Multi-language.git`
   - `git clone https://github.com/codinglin/StudyNotes.git`
   - `git clone https://github.com/remote-jp/remote-in-japan.git`

2. **配置 Git（Configuring Git）**:
   - `git config --global http.proxy "localhost:443"`
   - `git config --global --unset http.proxy`
   - `git config --global user.name "yangda27"`
   - `git config --global user.email "yangda27@aliyun.com"`
   - `git config -l`
   - `git config --global user.name "EXsYang"`
   - `git config --system --list`

3. **初始化仓库（Initializing Repositories）**:
   - `git init`

4. **检查状态（Checking Status）**:
   - `git status`

5. **添加文件到暂存区（Adding to Staging Area）**:
   - `git add .`

6. **提交更改（Committing Changes）**:
   - `git commit -m 'commit 1'`
   - `git commit -m '第一次提交哦'`
   - `git commit -m 'hot-fix 第一次提交'`
   - `git commit -m 'master 第二次提交'`

7. **分支操作（Branching）**:
   - `git branch`
   - `git branch -v`
   - `git checkout -b hot-fix`
   - `git checkout master`
   - `git checkout -b master`

8. **查看日志（Viewing Logs）**:
   - `git log`
   - `git reflog`

9. **远程仓库操作（Remote Repositories）**:
   - `git remote -v`
   - `git remote add git-demo https://github.com/EXsYang/git-demo.git`

10. **推送到远程仓库（Pushing to Remote Repository）**:
    - `git push git-demo master`

这个整理的列表包含了各种 Git 操作的基本命令，从仓库的克隆、配置、到常见的分支和提交操作，以及与远程仓库的交互。







# 1 git基本命令





~~~bash
#基本配置
$ git config -l

$ git config --global user.name 'CodeYang' 

$ git config --global user.email '10825197+kapaiya@user.noreply.gitee.com'


#初始化本地仓库
$ git init


#克隆
$ git clone url


#文件状态，使用 git add 文件从 Untracked(未跟踪) -> Staged(暂存)
$ git status ABC.txt

$ git add .

$ git commit -m 'commit 1'

$ git status

#查看日志
$ git log

#远程推送
$ git push git-demo master


~~~

![image-20240131184824281](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240131184824281.png)





## 版本回退

~~~
yangda@F2 MINGW64 /d/Java_developer_tools/GiteeRepository/gitee_hsp_java/hspgit (master)
$ git-log
* f3d3cc3 (HEAD -> master) 第二次提交
* beeb1a7 第一次提交

yangda@F2 MINGW64 /d/Java_developer_tools/GiteeRepository/gitee_hsp_java/hspgit (master)
$ git reset --hard beeb1a7
HEAD is now at beeb1a7 第一次提交

yangda@F2 MINGW64 /d/Java_developer_tools/GiteeRepository/gitee_hsp_java/hspgit (master)
$ git-log
* beeb1a7 (HEAD -> master) 第一次提交

yangda@F2 MINGW64 /d/Java_developer_tools/GiteeRepository/gitee_hsp_java/hspgit (master)
$

~~~



**注意事项：找回回退之前的commitID的指令 `git reflog`**



![image-20240131173033336](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240131173033336.png)



## 分支

**查看当前有哪些分支  `git branch`**

**创建新分支  `git branch dev01`**

**切换分支 `git chechout master`**

**合并分支 `git merge dev01`** ,将分支dev01合并到master上

**删除分支`git branch -d 分支名`**

**强制删除分支`git branch -D 分支名`**

**`master` 分支可能从未被创建**：在某些情况下，如果仓库是新的并且没有任何提交，`master` 分支可能根本就没有被创建。只有在第一次提交后，`master` 分支才会被自动创建。

**初始分支可能有不同的名称**：最近，一些 Git 服务（如 GitHub）开始使用 `main` 而非 `master` 作为新仓库的默认分支名称。如果您的仓库是从这样的服务克隆或创建的，那么默认分支可能是 `main`。

## 检出文件

`git checkout -- filename` 命令实际上是从本地仓库（Git 术语中的“repository”）中取出文件的最后一次提交（commit）的版本，并将其放到工作目录中。这个命令并不涉及暂存区（Git 术语中的“index”或“staging area”）。

这里的流程解释如下：

- **工作目录（Working Directory）**：这是您当前正在进行工作的地方，文件在这里被创建、编辑和删除。

- **暂存区（Staging Area/Index）**：在您提交之前，更改过的文件会放到这里。通过使用 `git add` 命令，文件更改会从工作目录移动到暂存区。

- **本地仓库（Repository）**：当您执行 `git commit` 命令时，暂存区的内容会成为仓库的一部分，即一次提交。

当您执行 `git checkout -- filename` 时，Git 会查找该文件在最后一次提交中的状态（即本地仓库中的状态），并将其复制到工作目录，无论其是否已经被添加到暂存区。这意味着工作目录中的文件将被替换为最后一次提交时的内容，所有未提交的更改都将丢失。



## 解决合并分支冲突问题

![image-20240131181928392](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240131181928392.png)



## 合并分支的步骤和注意事项

当然，使用具体的分支名称如 `master` 和 `dev` 会让步骤更加明确。以下是使用 `master` 作为目标分支和 `dev` 作为源分支时合并分支的步骤和注意事项的总结：

1. **检查当前分支**：
   - 使用 `git status` 确认当前所在分支。

2. **切换到 `master` 分支**：
   - 如果您不在 `master` 分支上，使用 `git checkout master` 切换到 `master` 分支。

3. **从 `dev` 分支合并到 `master`**：
   - 在 `master` 分支上执行 `git merge dev` 命令，将 `dev` 分支的更改合并进来。
   - 如果合并成功且没有冲突，Git 会自动创建一个合并提交。

4. **自动合并提交**：
   - Git 在无冲突的合并后会自动生成提交信息，如 "Merge branch 'dev' into master"。

5. **处理合并冲突**：
   - 如果在合并时出现冲突，Git 会暂停并允许您手动解决冲突。
   - 解决冲突后，使用 `git add <解决冲突的文件>` 将这些文件标记为已解决。
   - 然后执行 `git commit`，此时可以编辑自动生成的合并提交信息或直接使用。
   - 注意这里执行提交时 使用 git commit 命令时**不能带文件名**！ 
   
6. **自定义提交信息**：
   - 如果您想为合并提供自定义的提交信息，可以在合并时加上 `--no-commit` 选项，然后使用 `git commit -m "您的自定义合并信息"` 手动提交。

7. **确认合并结果**：
   - 使用 `git log` 检查提交历史，确认合并操作按照预期完成。

通过遵循这些步骤，您可以清晰地将 `dev` 分支的更改合并到 `master` 分支，并确保整个过程顺利进行。













# 2 使用 Git 进行提交时的步骤和注意事项

当然，我将重新整理并包含您提到的关于使用 Vim 编辑器进行提交的详细步骤。以下是使用 Git 进行提交时的步骤和注意事项：

1. **检查当前状态**：
   - 使用 `git status` 来查看哪些文件被修改了。
   - 这有助于确定哪些文件需要添加到暂存区。

2. **添加文件到暂存区**：
   - 使用 `git add <文件名>` 将更改的文件添加到暂存区。
   - 可以使用 `git add .` 添加所有修改过的文件到暂存区，但要小心不要意外添加不需要的文件。

3. **执行提交**：
   - 使用 `git commit`（不带 `-m` 选项）将暂存区的更改提交到仓库。
   - 这会打开 Vim 编辑器以便您输入提交信息。

4. **在 Vim 中编写提交信息**：
   - 在 Vim 编辑器打开后，在文件的最顶部空白行输入提交信息。
   - 避免在以 `#` 开头的注释行输入文本。

5. **保存提交信息并退出 Vim**：
   - 完成提交信息的编写后，按 `Esc` 退出插入模式。
   - 输入 `:wq` 后按 `Enter` 保存您的提交信息并退出 Vim。

6. **自动完成提交**：
   - 退出 Vim 后，Git 会自动使用您在 Vim 中输入的提交信息完成提交过程。

7. **查看提交历史**：
   - 使用 `git log` 查看您的提交历史，以确认提交成功。

8. **注意事项**：
   - 如果直接执行 `git commit` 而没有先使用 `git add` 添加文件，尚未暂存的更改将不会被包括在提交中。
   - 对于新文件（即 Git 之前未跟踪的文件），必须先使用 `git add` 添加这些文件，然后才能提交。
   - 在 Vim 中编写提交信息时，确保在最上面的空白行输入，避免在注释行（以 `#` 开头）输入。
   - 如果您在 Vim 中未输入任何提交信息就退出（使用 `:q!`），提交将被取消。

这些步骤和注意点将帮助您更准确、有效地使用 Git 进行版本控制和提交管理。



配置的邮箱地址

### yangda27@aliyun.com

pwd:131407da



# 3 将 Git 的默认编辑器恢复为默认设置（通常是 Vim）

**要将 Git 的默认编辑器从 Visual Studio Code 恢复为默认设置（通常是 Vim）**，您可以通过修改 Git 的配置来实现。在 Git Bash 或其他命令行界面中，您可以使用以下命令来更改默认的提交编辑器：

```bash
git config --global core.editor vim
```

这个命令将全局的 Git 配置中的 `core.editor` 设置为 `vim`，这是 Git 默认使用的文本编辑器。

如果您不熟悉 Vim 编辑器，它的操作方式可能与您熟悉的编辑器有所不同。基本的 Vim 命令包括：

- `i` 进入插入模式，可以开始输入文本。
- `Esc` 退出插入模式，回到普通模式。
- 在普通模式下输入 `:wq` 然后按 `Enter` 保存更改并退出。
- 在普通模式下输入 `:q!` 然后按 `Enter` 不保存更改并退出。

这些是使用 Vim 的基础知识。如果您想使用一个更简单的文本编辑器，比如 Nano，您可以将上述命令中的 `vim` 替换为 `nano`。例如：

```bash
git config --global core.editor nano
```

Nano 编辑器的操作会更直观一些，特别是对于那些习惯了图形界面编辑器的用户。



# 4 idea进行push到gitee远程仓库时，会让我输入账号和密码，可是我已经配置了公共ssh公钥了啊？

![image-20240131172033830](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240131172033830.png)

![image-20240131171824741](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240131171824741.png)

如果 IntelliJ IDEA 在进行 Git 提交操作时要求您输入账号和密码，即使您已经配置了 SSH 公钥，这通常意味着 IDEA 正在尝试通过 HTTPS 而非 SSH 来连接 Git 仓库。要解决这个问题，您可以按照以下步骤操作：

1. **检查仓库的远程 URL**：
   - 首先，您需要确认 IDEA 使用的 Git 仓库远程 URL 是 SSH 格式还是 HTTPS 格式。
   - 您可以在 IDEA 的 Git 仓库设置中查看，或者在命令行使用 `git remote -v` 查看。

2. **切换到 SSH URL**：
   - 如果远程 URL 是 HTTPS 格式的（如 `https://`），您需要将其更改为 SSH 格式（如 `git@github.com:用户名/仓库名.git`）。
   - 在命令行中，您可以使用 `git remote set-url origin 新的SSH_URL` 来更改。

3. **确认 SSH 密钥配置**：
   - 确保您的 SSH 密钥已经添加到 Git 服务器（如 GitHub、GitLab 等）的账户中。
   - 在本地计算机上，SSH 密钥应该存储在 `~/.ssh` 目录下，并且 `ssh-agent` 正在运行并已加载您的密钥。

4. **在 IDEA 中配置 SSH**：
   - 在 IDEA 中，确保您的 SSH 配置是正确的。
   - 您可以在 IDEA 的设置中找到 SSH 配置，确保它指向了正确的 SSH 密钥文件。

完成这些步骤后，您应该能够通过 SSH 使用 IDEA 进行 Git 操作，而不需要再输入账号和密码。如果问题仍然存在，可能需要检查防火墙设置或网络连接，以确保您的计算机能够通过 SSH 访问远程 Git 仓库。



# 从Git仓库中移除一个远程仓库别名（remote alias）

要从Git仓库中移除一个远程仓库别名（remote alias），您可以使用以下命令：

```
git remote remove 别名
```

这里的“别名”是您要移除的远程仓库的名称。例如，如果您要移除名为 "origin" 的远程仓库别名，您可以运行：

```
git remote remove origin
```

运行这个命令后，Git将从您的本地仓库中移除指定的远程仓库别名。请谨慎操作，因为一旦移除，您将无法再使用该别名来与该远程仓库进行交互，除非重新添加它。



# 6 如果远程 URL 是 HTTPS 格式的是不可以进行免密登录吗？

实际上，HTTPS URL 也可以用于免密登录，但它通常需要不同的方法来实现，如使用凭据存储或访问令牌。与 SSH 公钥/私钥认证不同，HTTPS 连接通常会要求用户名和密码，但这些可以通过以下方式自动提供：

1. **凭据缓存**：
   - Git 提供了凭据存储的功能，可以在一段时间内记住您的用户名和密码。您可以通过 Git 命令启用这个特性：
     ```bash
     git config --global credential.helper cache
     ```
   - 这会使 Git 在一定时间内记住您的凭据。

2. **凭据管理器**：
   - 在 Windows 上，Git 可以使用 Windows 凭据管理器来存储凭据。设置方法为：
     ```bash
     git config --global credential.helper manager
     ```
   - 在 macOS 上，Git 可以使用 macOS 密钥链存储访问凭据。

3. **访问令牌**：
   - 对于一些服务（如 GitHub），您可以生成一个访问令牌并使用它作为密码。这在多因素认证（MFA）启用的情况下特别有用。

4. **使用 `.netrc` 文件**：
   - 您可以在主目录下创建一个 `.netrc`（在 Windows 下是 `_netrc`）文件，其中存储您的登录凭据。Git 会从这个文件读取凭据以进行自动登录。

即使您配置了 SSH 公钥，如果您的远程仓库 URL 是 HTTPS 格式的，Git 默认会使用 HTTPS 连接，此时您需要按照上述方法之一来配置 HTTPS 的免密登录。不过，出于安全和便利性考虑，很多人更倾向于使用 SSH 连接，因为它在配置后可以非常方便地进行免密操作。







# 7 远程推送到GitHub是否成功的案例

![image-20240201005959906](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240201005959906.png)







# 8 解决超出 GitHub 文件大小限制的问题

要解决超出 GitHub 文件大小限制的问题，并成功推送您的代码，您可以按照以下步骤操作：

### 使用 Git LFS

1. **初始化 Git LFS**：如果您还没有在您的仓库中初始化 Git LFS，请运行：

   ```
   bashCopy code
   git lfs install
   ```

2. **跟踪大文件**：使用 Git LFS 跟踪那些大文件。以您提到的文件为例：

   ```
   bashCopy codegit lfs track "学习时的代码/springcloud/nacos/nacos-server-1.2.1/nacos/target/nacos-server.jar"
   git lfs track "学习时的代码/springcloud/nacos/nacos-server-1.2.1.zip"
   git lfs track "学习时的代码/javaweb/HTML/resources/video/命运石之门01.mp4"
   ```

   这些命令会更新 `.gitattributes` 文件。

3. **添加 `.gitattributes` 文件**：提交 `.gitattributes` 文件的更改。

   ```
   bashCopy codegit add .gitattributes
   git commit -m "Configure LFS tracking"
   ```

4. **重新提交大文件**：现在您需要重新添加并提交这些大文件，以便 Git LFS 能够处理它们。

   ```
   bashCopy codegit add 学习时的代码/springcloud/nacos/nacos-server-1.2.1/nacos/target/nacos-server.jar
   git add 学习时的代码/springcloud/nacos/nacos-server-1.2.1.zip
   git add 学习时的代码/javaweb/HTML/resources/video/命运石之门01.mp4
   git commit -m "Add large files with LFS"
   ```

5. **推送到远程仓库**：强制推送您的更改到远程仓库。

   ```
   bashCopy code
   git push mycode master --force
   ```

### 注意事项

- **备份您的仓库**：在进行这些操作之前，确保备份您的仓库。这些操作可能会更改您的提交历史。
- **确保安装 Git LFS**：在您的机器上安装 Git LFS 是使用 Git LFS 的前提条件。
- **强制推送的影响**：强制推送（`--force`）会重写远程仓库的历史。如果其他人正在使用同一个仓库，他们需要注意这一更改。
- **GitHub LFS 配额**：使用 Git LFS 时请记住 GitHub 对 LFS 存储和带宽的限制。

如果您决定不使用 Git LFS，而是选择移除或缩小这些大文件的大小，那么您可能需要重写您的 Git 历史，并移除这些大文件。这通常涉及复杂的 Git 操作，如 `git filter-branch` 或使用第三方工具如 BFG Repo-Cleaner。



# 9 Git LFS使用时必须在要使用的仓库里安装对吗？需要执行git lfs install，并指定跟踪的大文件类型

**即需要在对应的.git 仓库文件夹打开的gitBash命令行窗口中执行过`git lfs install`后**

**，这个仓库才会跟踪大文件！**

要在一个仓库中使用 Git Large File Storage（LFS），您需要在该仓库中安装 Git LFS，并指定需要由 Git LFS 跟踪的大文件类型。这里是详细的步骤：

### 安装 Git LFS

1. **在您的系统上安装 Git LFS**：如果您的系统上还没有安装 Git LFS，请从 [Git LFS 官方网站](https://git-lfs.github.com/) 下载并安装它。

2. **在仓库中初始化 Git LFS**：打开命令行工具，切换到您的 Git 仓库目录，然后运行：

   ```
   bashCopy code
   git lfs install
   ```

   这个命令会设置 Git LFS 的钩子（hooks）。这是在每个使用 Git LFS 的仓库中需要执行的步骤。

### 配置文件跟踪

1. **指定要跟踪的文件类型**：在仓库目录中，使用 `git lfs track` 命令来指定 Git LFS 应该跟踪哪些文件类型。例如，要跟踪所有 `.zip` 和 `.mp4` 文件，您可以执行：

   ```
   bashCopy codegit lfs track "*.zip"
   git lfs track "*.mp4"
   ```

   这将会修改 `.gitattributes` 文件，添加关于这些文件类型的规则。

2. **提交 `.gitattributes` 文件**：将更新后的 `.gitattributes` 文件提交到您的仓库：

   ```
   bashCopy codegit add .gitattributes
   git commit -m "Add LFS tracking for .zip and .mp4 files"
   ```

### 使用 Git LFS

- 一旦完成上述设置，Git LFS 将自动处理所有指定类型的文件。当您 `git add`、`git commit` 和 `git push` 这些文件时，Git LFS 会自动介入。
- 对于已经存在于仓库中的大文件，如果您希望将它们迁移到 Git LFS，您需要从仓库中删除这些文件，然后重新提交。这样做的目的是为了让 Git LFS 接管这些文件的版本控制。

### 注意事项

- 确保在开始跟踪大文件之前配置好 `.gitattributes` 文件。
- 如果您的仓库已经包含大文件，而这些文件未被 Git LFS 跟踪，那么您可能需要重写仓库历史来迁移这些文件到 Git LFS，这是一个复杂的过程，需要谨慎操作。
- 在团队环境中使用 Git LFS 时，确保所有团队成员都安装了 Git LFS，并理解如何使用它。



# 10 Git LFS 重置服务器空间方法

![image-20240202235756609](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240202235756609.png)



# 11 ssh 免密登录连接终极配置

## 1 设置ssh代理（终极解决方案）


https代理存在一个局限，那就是没有办法做身份验证，每次拉取私库或者推送代码时，都需要输入github的账号和密码，非常痛苦。
设置ssh代理前，请确保你已经设置ssh key。可以参考[在 github 上添加 SSH key](https://link.zhihu.com/?target=https%3A//tjfish.github.io/posts/%E5%9C%A8github%E4%B8%8A%E6%B7%BB%E5%8A%A0SSH-key/) 完成设置
更进一步是设置ssh代理。只需要配置一个config就可以了。

```bash
# Linux、MacOS
vi ~/.ssh/config
# Windows 
到C:\Users\your_user_name\.ssh目录下，新建一个config文件（无后缀名）
```


将下面内容加到config文件中即可

对于windows用户，代理会用到connect.exe，你如果安装了Git都会自带connect.exe，如我的路径为C:\APP\Git\mingw64\bin\connect

```text
#Windows用户，注意替换你的端口号和connect.exe的路径
ProxyCommand "D:\Java_developer_tools\Git\Git\mingw64\bin\connect" -S 127.0.0.1:7890 -a none %h %p

#MacOS用户用下方这条命令，注意替换你的端口号
#ProxyCommand nc -v -x 127.0.0.1:7890 %h %p

Host github.com
  User git
  Port 443
  Hostname ssh.github.com
  # 注意修改路径为你的路径
  IdentityFile "C:\Users\yangd\.ssh\github01_id_rsa"
  TCPKeepAlive yes

Host ssh.github.com
  User git
  Port 443
  Hostname ssh.github.com
  # 注意修改路径为你的路径
  IdentityFile "C:\Users\yangd\.ssh\github01_id_rsa"
  TCPKeepAlive yes
```


保存后文件后测试方法如下，返回successful之类的就成功了。

```text
# 测试是否设置成功
ssh -T git@github.com
```

测试成功如下：

~~~shell
xx@F2 MINGW64 /d/Java_developer_tools/GithubRepository/git-demo (master)
$ ssh -T git@github.com
The authenticity of host '[ssh.github.com]:443 (<no hostip for proxy command>)' can't be established.
ED25519 key fingerprint is SHA256:+DiY3wvvV6TuJJhbpZisF/zLDA0zPMSvHdkr4UvCOqU.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '[ssh.github.com]:443' (ED25519) to the list of known hosts.
Hi EXsYang! You've successfully authenticated, but GitHub does not provide shell access.

~~~



之后都推荐走ssh拉取代码，再github 上选择clone地址时，选择ssh地址，入下图。这样`git push` 与 `git clone` 都可以直接走代理了，并且不需要输入密码。

![img](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/v2-0e58a44f513be7005919b320222f2985_720w.webp)

###  原理部分


代理服务器就是你的电脑和互联网的中介。当您访问外网时（如[http://google.com](https://link.zhihu.com/?target=http%3A//google.com)) , 你的请求首先转发到代理服务器，然后代理服务器替你访问外网，并将结果原封不动的给你的电脑，这样你的电脑就可以看到外网的内容啦。
路径如下：

> 你的电脑->代理服务器->外网
> 外网->代理服务器->你的电脑


很多朋友配置代理之后，可以正常访问github 网页了，但是发现在本地克隆github仓库（git clone xxx）时还是报网络错误。那是因为git clone 没有走你的代理，所以需要设置git走你的代理才行。







## 2 Git 配置多个 SSH Key

链接地址：https://help.gitee.com/enterprise/code-manage/%E6%9D%83%E9%99%90%E4%B8%8E%E8%AE%BE%E7%BD%AE/%E9%83%A8%E7%BD%B2%E5%85%AC%E9%92%A5%E7%AE%A1%E7%90%86/Git%E9%85%8D%E7%BD%AE%E5%A4%9A%E4%B8%AASSH-Key

### 背景[](https://help.gitee.com/enterprise/code-manage/权限与设置/部署公钥管理/Git配置多个SSH-Key#背景)

同时使用两个 Gitee 帐号，需要为两个帐号配置不同的 SSH Key：

- 帐号 A 用于公司；
- 帐号 B 用于个人。



### 解决方法[](https://help.gitee.com/enterprise/code-manage/权限与设置/部署公钥管理/Git配置多个SSH-Key#解决方法)

1. 生成帐号 A 的 SSH Key，并在帐号 A 的 Gitee 设置页面添加 SSH 公钥：

```bash
ssh-keygen -t ed25519 -C "Gitee User A" -f ~/.ssh/gitee_user_a_ed25519
```

![image-20240212110520938](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240212110520938.png)

1. 生成帐号 B 的 SSH-Key，并在帐号 B 的 Gitee 设置页面添加 SSH 公钥：

```bash
ssh-keygen -t ed25519 -C "Gitee User B" -f ~/.ssh/gitee_user_b_ed25519
```



1. 创建或者修改文件 `~/.ssh/config`，添加如下内容：

```bash
Host gt_a
    User git
    Hostname gitee.com
    Port 22
    IdentityFile ~/.ssh/gitee_user_a_ed25519
Host gt_b
    User git
    Hostname gitee.com
    Port 22
    IdentityFile ~/.ssh/gitee_user_b_ed25519
```



1. 用 ssh 命令分别测试两个 SSH Key：

```text
$ ssh -T gt_a
Hi Gitee User A! You've successfully authenticated, but GITEE.COM does not provide shell access.

$ ssh -T gt_b
Hi Gitee User B! You've successfully authenticated, but GITEE.COM does not provide shell access.
```



1. 拉取代码：

将 `git@gitee.com` 替换为 SSH 配置文件中对应的 `Host`，如原仓库 SSH 链接为：

```text
git@gitee.com:owner/repo.git
```



使用帐号 A 推拉仓库时，需要将连接修改为：

```text
gt_a:owner/repo.git
```



## 3 github ssh 设置



要想使用ssh免密连接到GitHub，需要修改配置文件如下：

位置在 `C:\Users\yangd\.ssh\config`



~~~
#config文件配置
#Windows用户，注意替换你的端口号和connect.exe的路径
#，下面这行在使用代理的情况下，如github时需要打开
#，在使用gitee时需要注销掉
ProxyCommand "D:\Java_developer_tools\Git\Git\mingw64\bin\connect" -S 127.0.0.1:7890 -a none %h %p

#MacOS用户用下方这条命令，注意替换你的端口号
#ProxyCommand nc -v -x 127.0.0.1:7890 %h %p

Host github.com
  User git
  Port 443
  Hostname ssh.github.com
  # 注意修改路径为你的路径
  IdentityFile "C:\Users\yangd\.ssh\github01_id_rsa"
  TCPKeepAlive yes


Host ssh.github.com
  User git
  Port 443
  Hostname ssh.github.com
  # 注意修改路径为你的路径
  IdentityFile "C:\Users\yangd\.ssh\github01_id_rsa"
  TCPKeepAlive yes
~~~



## 4 gitee ssh 设置

~~~
#Windows用户，注意替换你的端口号和connect.exe的路径
#，下面这行在使用代理的情况下，如github时需要打开
#，在使用gitee时需要注销掉
#ProxyCommand "D:\Java_developer_tools\Git\Git\mingw64\bin\connect" -S 127.0.0.1:7890 -a none %h %p

#MacOS用户用下方这条命令，注意替换你的端口号
#ProxyCommand nc -v -x 127.0.0.1:7890 %h %p

Host github.com
  User git
  Port 443
  Hostname ssh.github.com
  # 注意修改路径为你的路径
  IdentityFile "C:\Users\yangd\.ssh\github01_id_rsa"
  TCPKeepAlive yes


Host ssh.github.com
  User git
  Port 443
  Hostname ssh.github.com
  # 注意修改路径为你的路径
  IdentityFile "C:\Users\yangd\.ssh\github01_id_rsa"
  TCPKeepAlive yes
  
Host gt_a
    User git
    Hostname gitee.com
    Port 22
    IdentityFile ~/.ssh/gitee_user_a_ed25519
	
~~~



需要配置好

![image-20240212104004645](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240212104004645.png)



![image-20240212103938206](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240212103938206.png)

### 测试ssh免密登录是否成功如下：

~~~
yangda@F2 MINGW64 /d/Java_developer_tools/GiteeRepository/gitee_hsp_java/新建文件夹/daqiao-java-project-001 (master)
$ ssh -T gt_a
Hi CodeYang(@kapaiya)! You've successfully authenticated, but GITEE.COM does not provide shell access.
#注意这里使用ssh -T git@gitee.com进行测试也可以

~~~

注意：使用gitee免密登录不可以使用代理，同时需要把生成的公钥配置的gitee

即使开着clash也可以使用gitee ssh免密登录，注销上面这一行，同时需要在该文件中配置过gitee的Host，

​								，如下面这种样式的

~~~
Host gt_a
    User git
    Hostname gitee.com
    Port 22
    IdentityFile ~/.ssh/gitee_user_a_ed25519
~~~

![image-20240212105007023](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240212105007023.png)



# 5 密钥类型`-t rsa`和`-t ed25519`解释：

~~~
ssh-keygen -t rsa -C 'Github_Email_yangda27@aliyun.com' -f ~/.ssh/github01_id_rsa
~~~



命令 `ssh-keygen -t rsa -C 'Github_Email_yangda27@aliyun.com' -f ~/.ssh/github01_id_rsa` 用于生成一个新的SSH密钥对，通常用于安全地与远程服务器（如GitHub）进行通信。下面是命令各部分的详细解释：

- `ssh-keygen`: 这是一个用于生成、管理和转换SSH密钥的工具。它是SSH套件的一部分，可以创建新的密钥对或操作现有的密钥。

- `-t rsa`: 指定生成密钥的类型。`rsa` 是目前最广泛使用的一种公钥加密算法，用于SSH连接。这个选项告诉 `ssh-keygen` 使用RSA算法生成密钥对。

- `-C 'Github_Email_yangda27@aliyun.com'`: 这个选项允许你为生成的密钥对添加一个注释，通常是一个邮箱地址。这个邮箱地址没有技术上的作用，但它可以帮助你标识和管理使用特定邮箱创建的密钥。这里使用的邮箱地址 `'Github_Email_yangda27@aliyun.com'` 应该是你的GitHub账户邮箱，用于帮助识别这个密钥是为GitHub服务生成的。

- `-f ~/.ssh/github01_id_rsa`: 指定生成的密钥存储的文件名和位置。`~/.ssh` 是用户主目录下的一个隐藏目录，通常用于存储SSH密钥和配置。`github01_id_rsa` 是私钥文件的名称，意味着这个文件包含密钥的私有部分。默认情况下，`ssh-keygen` 会在同一位置生成一个公钥文件，文件名为`github01_id_rsa.pub`。

执行这个命令后，系统会在 `~/.ssh` 目录下生成一对密钥文件：私钥文件 `github01_id_rsa` 和公钥文件 `github01_id_rsa.pub`。私钥文件应该保密，不应该泄露或分享；而公钥文件则可以安全地添加到GitHub账户中，用于建立安全的SSH连接，以便无需密码即可推送和拉取代码。



~~~
ssh-keygen -t ed25519 -C "Gitee User A" -f ~/.ssh/gitee_user_a_ed25519
~~~



命令 `ssh-keygen -t ed25519 -C "Gitee User A" -f ~/.ssh/gitee_user_a_ed25519` 用于生成一个新的SSH密钥对，这次使用的是Ed25519算法，专门为SSH连接而设计。下面是命令各部分的详细解释：

- `ssh-keygen`: 这是生成、管理和转换SSH密钥的工具，是SSH工具集的一部分。

- `-t ed25519`: 指定生成密钥的类型为Ed25519，这是一种使用EdDSA签名方案的公钥加密算法。Ed25519被认为比传统的RSA算法更安全、更高效，特别是在抵抗侧通道攻击方面。

- `-C "Gitee User A"`: 为生成的密钥对添加一个注释，通常是一个邮箱地址或者用户标识。这里的注释是 `"Gitee User A"`，用于帮助识别这个密钥是为哪个用户或用途生成的。注释在技术上没有特定的作用，但有助于管理多个密钥。

- `-f ~/.ssh/gitee_user_a_ed25519`: 指定生成的密钥存储的文件名和位置。`~/.ssh` 是用户主目录下的一个隐藏目录，通常用于存储SSH密钥和配置。`gitee_user_a_ed25519` 是私钥文件的名称，意味着这个文件包含密钥的私有部分。默认情况下，`ssh-keygen` 也会在同一位置生成一个公钥文件，文件名为`gitee_user_a_ed25519.pub`。

执行此命令后，系统会在 `~/.ssh` 目录下生成一对密钥文件：私钥文件 `gitee_user_a_ed25519` 和公钥文件 `gitee_user_a_ed25519.pub`。私钥文件应该被保密处理，不应泄露或分享；而公钥文件可以被添加到Gitee（或其他支持SSH的服务）账户中，以便建立安全的SSH连接进行代码推送和拉取操作，无需使用密码。这种方式特别适合于提高开发者在使用Git仓库时的安全性和便捷性。

# 6 `-C` 在 `ssh-keygen` 命令中是一个缩写，代表 `comment`（注释）。

是的，`-C` 在 `ssh-keygen` 命令中是一个缩写，代表 `comment`（注释）。它用于为生成的SSH密钥对添加一个注释字符串。这个注释通常包含在公钥文件的末尾，形式上看起来像这样：

```
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAI... 用户提供的注释
```

在实际使用中，注释通常包含用于标识密钥所有者的信息，比如邮箱地址或用户名。虽然这个注释在技术上不影响密钥的功能，但它可以帮助用户在管理多个密钥时区分它们。例如，如果你为不同的服务生成了多个SSH密钥，可以通过在生成密钥时使用不同的注释来帮助记住每个密钥的用途或服务。

在你提供的命令 `ssh-keygen -t ed25519 -C "Gitee User A" -f ~/.ssh/gitee_user_a_ed25519` 中，`-C "Gitee User A"` 就是为生成的密钥对添加了一个标识为“Gitee User A”的注释，帮助用户识别这个密钥是专门为“Gitee User A”这个用途或身份创建的。

## 7 C:\Users\yangd\.ssh\config 文件的最终配置

~~~
#Windows用户，注意替换你的端口号和connect.exe的路径
#，下面这行在使用代理的情况下，如github时需要打开
#，在使用gitee时需要注销掉
#，最好使用github时将下面这行打开才好，但是不打开也行，clash使用TUN模式，偶尔也能ssh连接上
#ProxyCommand "D:\Java_developer_tools\Git\Git\mingw64\bin\connect" -S 127.0.0.1:7890 -a none %h %p


#MacOS用户用下方这条命令，注意替换你的端口号
#ProxyCommand nc -v -x 127.0.0.1:7890 %h %p

Host github.com
  User git
  Port 443
  Hostname ssh.github.com
  # 注意修改路径为你的路径
  IdentityFile "C:\Users\yangd\.ssh\github01_id_rsa"
  TCPKeepAlive yes


Host ssh.github.com
  User git
  Port 443
  Hostname ssh.github.com
  # 注意修改路径为你的路径
  IdentityFile "C:\Users\yangd\.ssh\github01_id_rsa"
  TCPKeepAlive yes
  
Host gt_a
    User git
    Hostname gitee.com
    Port 22
    IdentityFile ~/.ssh/gitee_user_a_ed25519
	
~~~





#  小技巧：

# 1  gitbash命令窗口复制粘贴的说明

**在gitBash命令窗口中，选中文本就是已经复制了，不需要再右键选择复制,默认按下鼠标滚轮/中键就是粘贴paste**

# 2 SSH 密钥注意事项说明

当然，以下是关于同一个 SSH 密钥可用于多个平台，以及本地可以生成多份 SSH 密钥的简要总结：

1. **同一个 SSH 密钥可用于多个平台**：
   - 一个生成的 SSH 密钥对（包括公钥和私钥）可以在多个平台或服务中使用。
   - 公钥可以被安全地添加到多个远程服务（如 GitHub, GitLab, Bitbucket 等）的账户设置中。
   - 私钥保留在本地，用于身份验证。它应保持安全，不被公开或在不同设备间共享。

2. **本地可以生成多份 SSH 密钥**：
   - 可以在本地生成多个 SSH 密钥对，用于不同的目的或服务，这有助于管理和安全性。
   - 每个密钥对都可以有不同的文件名和注释，以便于区分。
   - 例如，您的命令 `ssh-keygen -t rsa -C 'Github_Email_yangda27@aliyun.com' -f ~/.ssh/github01_id_rsa` 创建了一个专门用于 GitHub 的密钥对，文件名为 `github01_id_rsa`，注释为您的 GitHub 邮箱地址。
   - 为不同服务或目的创建单独的密钥对可以增加安全性，因为每个密钥的使用范围和访问权限被限制在特定的服务或场景中。

简而言之，单个 SSH 密钥对可跨多个平台使用，但为了更好的安全性和管理，建议为不同的服务或目的生成不同的密钥对，并且可以通过命令行选项指定每个密钥对的文件名和注释。

# 3 可以在该仓库的任何子目录中使用“Git Bash Here”打开bash命令行界面，然后执行Git命令来对仓库进行操作。

对于操作Git本地仓库，如你所述的 `uploadfiles` 仓库，**并不必须** 在仓库的根目录下打开Git Bash来执行Git命令。你可以在该仓库的任何子目录中使用“Git Bash Here”打开bash命令行界面，然后执行Git命令来对仓库进行操作。

当你在仓库的任何子目录中执行Git命令时，Git会自动向上搜索直到找到 `.git` 目录（这个目录标识了仓库的根目录）。因此，无论你当前处于仓库的哪个子目录中，Git都能正确地识别出你正在操作的是哪个仓库，并对该仓库执行相应的操作。

这意味着，比如你想提交更改、查看状态、切换分支等操作，即使你在仓库的一个子目录中，这些命令仍然会作用于整个仓库。这个特性使得在大型项目中工作更加灵活，你不需要每次都切换到仓库的根目录下去执行Git命令。

举个例子，如果你在 `uploadfiles/images` 目录中有文件改动，直接在这个目录中打开Git Bash并使用 `git status` 或 `git commit` 等命令，Git会显示和处理整个 `uploadfiles` 仓库的状态和提交，而不仅仅是 `images` 目录的。这样，你可以更方便地管理仓库，而不必频繁地在目录之间切换。



# 4 在一个仓库中嵌套了另一个仓库，可以吗？可以

在一个Git仓库中嵌套另一个Git仓库是可以的，但这需要以特定的方式来处理，即使用Git子模块（Git Submodule）。Git子模块允许你将一个Git仓库作为另一个Git仓库的子目录。这对于包含依赖的项目或者当你想将第三方库或项目作为你项目的一部分时特别有用。

从你提供的信息来看，你在主仓库中添加了一个名为 `gittest` 的子目录，该子目录本身是一个独立的Git仓库。Git通过警告提示你已经添加了一个嵌套的仓库，并给出了一些建议。

### 如何处理嵌套的仓库

#### 1. 将嵌套仓库转换为子模块

如果你打算保留嵌套仓库并希望它作为主仓库的一部分，你应该按照Git的提示，使用`git submodule add`命令将其添加为子模块：

```bash
git submodule add <url> gittest
```

这里的`<url>`是嵌套仓库的远程仓库URL。执行这个命令后，Git会将嵌套仓库作为子模块处理，这意味着主仓库会包含指向特定提交的引用，而不是嵌套仓库的实际文件。

#### 2. 如果嵌套仓库是错误添加的

如果嵌套的`gittest`仓库是无意中添加的，你可以按照Git的提示，使用以下命令将其从索引中移除（但保留在磁盘上）：

```bash
git rm --cached gittest
```

然后，你可以选择将`gittest`目录添加到`.gitignore`文件中，以防止将来再次错误地将其添加到仓库中：

```bash
echo 'gittest/' >> .gitignore
git add .gitignore
git commit -m "Ignore gittest directory"
```

### 总结

- **使用子模块**：如果嵌套的仓库是项目所需的，应将其作为子模块添加。
- **移除嵌套仓库**：如果嵌套的仓库是无意添加的，可以从索引中移除并忽略它。

处理嵌套仓库时，确保了解你的项目需求，并选择最适合你项目的方法来管理这些仓库。

# 5  `git submodule add <url> gittest`，执行后的作用是？

 执行 `git submodule add <url> gittest` 命令将一个外部Git仓库作为子模块（submodule）添加到你的Git仓库中。这个命令主要用于将其他项目或库作为依赖项集成到你的项目中，同时保持对那些项目或库的独立版本控制。以下是该命令执行后的具体作用和步骤：

### 1. 添加子模块

- **下载子模块**：Git会从提供的 `<url>` 克隆子模块到当前仓库中的指定目录`gittest`。这个URL应该是子模块仓库的远程仓库地址。

### 2. 初始化子模块配置

- **`.gitmodules`文件**：Git在主仓库的根目录下创建或更新一个名为`.gitmodules`的文件。这个文件跟踪子模块的配置信息，包括每个子模块的路径和克隆它们的URL。对于上述命令，它会添加一个条目来描述`gittest`子模块。

### 3. 注册子模块

- **子模块的初始化**：添加子模块后，你可能需要在新克隆的仓库中运行 `git submodule init` 来初始化本地配置文件（`.git/config`），这会注册子模块。但是，使用 `git submodule add` 命令时，这一步通常会自动完成。

### 4. 更新和克隆子模块

- **首次检出**：对于克隆了含有子模块的仓库的用户，他们需要运行 `git submodule update --init`（如果还未初始化，则加上 `--init`）来拉取子模块的内容。

### 5. 独立的提交历史

- **独立管理**：子模块和主仓库有独立的提交历史和分支管理。在主仓库中，子模块被记录为特定的提交ID（即提交哈希），这意味着主仓库会指向子模块特定的一个快照，而不是最新的提交。这有助于确保项目依赖的外部代码的稳定性和可追溯性。

### 6. 单独更新

- **更新子模块**：如果子模块有了更新，需要在主仓库中手动执行更新命令（如 `git submodule update --remote`），这样可以将子模块更新到最新的提交。更新后，主仓库中会记录新的子模块提交ID，这个变更需要被提交。

### 使用场景

- **依赖管理**：这个机制特别适用于管理和集成外部库或项目，比如第三方库、公共框架或者是团队内部共享的模块。

总结来说，`git submodule add` 命令提供了一种管理项目依赖的强大工具，使得你可以在项目中集成并维护外部代码，同时保持主项目和外部代码的独立性和可控性。

