# 

# git报错总结

# 1 git push报错`error: failed to push some refs to `

~~~
yangda@F2 MINGW64 /d/Java_developer_tools/uploadfiles (master)
$ git commit -m 'commit6'
[master 5144cb9] commit6
 8 files changed, 10164 insertions(+)
 create mode 100644 md笔记02/Redis随手笔记.md
 create mode 100644 md笔记02/SSM整合项目随手笔记.md
 create mode 100644 md笔记02/Springmvc随手笔记.md
 create mode 100644 md笔记02/Spring随手笔记.md
 create mode 100644 md笔记02/sb随手笔记.md
 create mode 100644 md笔记02/springcloud随手笔记.md
 create mode 100644 md笔记02/分布式微服务项目随手笔记.md
 create mode 100644 md笔记02/单词.md

yangda@F2 MINGW64 /d/Java_developer_tools/uploadfiles (master)
$ git-log
* 5144cb9 (HEAD -> master) commit6
* 95e2ce5 (origin/master) commit5
* e76c59c commit4
* c1722fe commit3
* 2c9b49f 2
* b07a09a Initial commit

yangda@F2 MINGW64 /d/Java_developer_tools/uploadfiles (master)
$ git push
Enumerating objects: 13, done.
Counting objects: 100% (13/13), done.
Delta compression using up to 8 threads
Compressing objects: 100% (10/10), done.
Writing objects: 100% (11/11), 139.66 KiB | 389.00 KiB/s, done.
Total 11 (delta 2), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (2/2), completed with 1 local object.
remote: fatal error in commit_refs
To github.com:EXsYang/uploadfiles2.git
 ! [remote rejected] master -> master (failure)
error: failed to push some refs to 'github.com:EXsYang/uploadfiles2.git'

yangda@F2 MINGW64 /d/Java_developer_tools/uploadfiles (master)
$ git reset --hard HEAD~1
HEAD is now at 95e2ce5 commit5

yangda@F2 MINGW64 /d/Java_developer_tools/uploadfiles (master)
$ git-log
* 95e2ce5 (HEAD -> master, origin/master) commit5
* e76c59c commit4
* c1722fe commit3
* 2c9b49f 2
* b07a09a Initial commit

yangda@F2 MINGW64 /d/Java_developer_tools/uploadfiles (master)

~~~



> 问题描述: 推测是提交的这几个文件中有特殊字符，导致生成的`commit6`不正常，从而push失败

# 解决方案:移除敏感信息

使用 ` git reset --hard HEAD~1`  删除上一次提交记录`commit6`  , 注意这条语句会导致版本回退，后来的修改都会回退到` commit5`什么都没新增的状态，注意一定要备份`commit5`->`commit6`之间的新增/修改的文件！否则会丢失！

~~~
#删除上一条历史并回退
git reset --hard HEAD~1
~~~

检查是哪一个文件格式/有特殊字符，进行调整





# git reset --hard HEAD~1 执行了这条语句，如何恢复？



~~~
git reflog

git reset --hard 39128d1





yangda@F2 MINGW64 /d/Java_developer_tools/DistributedMicroservicesProject/hspedu_hspliving/hspliving (master)
$ git reflog
07a5352 (HEAD -> master, origin/master, origin/develop, origin/HEAD) HEAD@{0}: reset: moving to HEAD~1
39128d1 HEAD@{1}: commit: commit4.6
07a5352 (HEAD -> master, origin/master, origin/develop, origin/HEAD) HEAD@{2}: clone: from https://gitee.com/kapaiya/hspliving.git

git reset --hard 39128d1

~~~





当你执行 `git reset --hard HEAD~1`，Git 会将当前分支的 HEAD（也就是最新的提交）回退到前一个提交，同时重置工作目录和暂存区的状态以匹配那个提交。这意味着最新的提交会从分支的历史中移除，以及工作目录中的任何未提交的更改也会被清除。如果你想恢复到执行这个命令之前的状态，你可以通过以下几种方式之一来尝试：

### 1. 使用 `git reflog` 找到丢失的提交
Git 的引用日志（reflog）是一个记录了本地仓库 HEAD 和分支引用更新记录的日志。即使提交被 `reset` 命令移除了，这些操作也会被记录在 reflog 中，允许你找回丢失的提交。

首先，使用 `git reflog` 命令查看最近的仓库操作历史：

```bash
git reflog
```

这个命令会列出你最近的 Git 操作，包括提交、重置和合并等。找到执行 `git reset --hard HEAD~1` 操作之前的那个提交的引用。它可能看起来像这样：

```
abcdefg HEAD@{1}: commit: your commit message
```

这里，`abcdefg` 是你想要恢复的提交的哈希值（实际上会是一个更长的哈希值）。

### 2. 重置到你想恢复的提交
找到了你想要恢复的提交的哈希值之后，使用 `git reset --hard` 加上那个哈希值来恢复：

```bash
git reset --hard abcdefg
```

请确保将 `abcdefg` 替换为实际的提交哈希值。这会将 HEAD 指向你选择的那个提交，同时重置工作目录和暂存区的状态以匹配那个提交。

### 警告
使用 `git reset --hard` 会丢弃工作目录和暂存区中的所有更改，所以在执行这个命令之前请确保没有需要保留的未提交更改。如果你不确定，可以先使用 `git stash` 来保存这些更改。

### 总结
通过以上步骤，你应该能够恢复到之前因为 `git reset --hard HEAD~1` 而丢失的提交。记住，`git reflog` 是一个非常有用的工具，可以在很多看似数据丢失的情况下帮助你恢复数据。



~~~
yangda@F2 MINGW64 /d/Java_developer_tools/DistributedMicroservicesProject/hspedu_hspliving/hspliving (master)
$ git reflog
07a5352 (HEAD -> master, origin/master, origin/develop, origin/HEAD) HEAD@{0}: reset: moving to HEAD~1
39128d1 HEAD@{1}: commit: commit4.6
07a5352 (HEAD -> master, origin/master, origin/develop, origin/HEAD) HEAD@{2}: clone: from https://gitee.com/kapaiya/hspliving.git
~~~

根据你提供的 `git reflog` 输出，你可以看到最近的几个操作记录。这里的关键是，你想恢复到 `git reset --hard HEAD~1` 执行之前的状态。在你的 `git reflog` 输出中，`39128d1` 是执行 reset 操作前的最后一个提交（即你想要恢复到的提交）。而 `07a5352` 是当前的 HEAD 位置，也就是执行 reset 之后的状态。

要恢复到 `39128d1` 这个提交，你需要执行以下命令：

```bash
git reset --hard 39128d1
```

这会将你的 HEAD、索引（暂存区）和工作目录都重置到 `39128d1` 这个提交的状态。执行这个命令后，你之前因为执行 `git reset --hard HEAD~1` 而丢失的更改会被恢复。

请记得，`git reset --hard` 是一个强制性命令，会丢弃所有工作目录中的更改。所以在执行这个命令之前，请确保你没有未保存的工作。如果有未提交的更改你想保留，考虑先使用 `git stash` 来保存这些更改。

一旦你执行了 `git reset --hard 39128d1`，你的仓库会回到那个提交的状态，就好像之前执行 `git reset --hard HEAD~1` 的操作没有发生过一样。





## Git 推送失败问题分析

当尝试推送到远程仓库时，出现 `remote: fatal error in commit_refs` 的错误。这个问题可能由多种原因导致，但在此情况下，似乎是因为推送的内容包含敏感信息（如API密钥），触发了远程仓库的安全策略。

### 可能的原因：

- **敏感信息泄露**：提交的内容包含敏感数据（例如 `access-key` 和 `secret-key`），很多代码托管平台都会检查并阻止这类信息的泄露。
- **远程仓库的安全策略**：如预提交钩子（pre-commit hooks）或推送规则（push rules），用于检测并阻止敏感信息的提交。

### 解决步骤：

1. **移除敏感信息**：
   - 从配置文件中删除或替换掉敏感数据。
   - 使用环境变量或安全的配置管理方式来处理敏感信息。

2. **清理提交历史**：
   - 如果敏感信息已经进入了Git历史记录，需要使用 `git filter-branch` 或 `BFG Repo-Cleaner` 等工具来重写历史并移除这些信息。

3. **强制推送**：
   - 在清理了历史之后，可能需要使用 `git push --force` 来覆盖远程分支的历史。注意，这一操作可能会影响其他协作者。

4. **遵守代码仓库安全策略**：
   - 确保理解并遵循代码仓库的安全策略和规则。

### 注意事项：

- 在处理包含敏感信息的文件时应格外小心。
- 在进行强制推送之前，确保与团队成员沟通，避免对他们的工作造成影响。
- 定期检查并更新安全策略，确保不会再次发生类似的问题。



![image-20240321165136282](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240321165136282.png)



---



# 命令总结

# 0 建立一个新的基本git仓库,所需的指令

~~~
git init

git remote add origin git@github.com:EXsYang/mycode_nolfs.git

git remote add origin git@gitee.com:czbk_zhang_meng/git_test.git

#使用 git remote set-url 命令来更新 origin  
git remote set-url origin git@github.com:EXsYang/mycode_nolfs.git


git remote -v

git status

git add .

git commi
# --set-upstream 推送到远端的同时并且建立起和远端分支的关联关系。如果当前分支已经和远端分支关联，# 则可以省略分支名和远端名。
git push --set-upstream origin main
git push --set-upstream origin master
git status

git commit -m 'commit'

git push origin master:master
git push 
git push --force

执行强制推送
如果您决定强制推送，可以使用以下命令：
git push origin main --force

或者更安全的方法：
git push origin main --force-with-lease
--force-with-lease 参数提供了一个安全网，它只会在远程分支的当前状态与您本地认为的远程分支的状态相匹配时才会推送。这样可以防止覆盖由其他人所做的未知更改。
~~~









# git在主模块中添加子模块,即在下级目录下也含有.git文件夹，即在仓库下包含另一个仓库



~~~
# 在主模块中添加子模块
git submodule add git@github.com:EXsYang/hspliving2.git hspliving


~~~

既然你已经做好了**备份**，并且希望完成子模块 `hspliving2` 的添加，你可以按照以下步骤来操作。这里假设你已经在父仓库 `hspedu_hspliving` 的根目录下：

### 1. 删除已存在的 `hspliving` 目录

首先，从 Git 索引和文件系统中删除 `hspliving` 目录。这一步确保添加子模块时不会出现冲突。

```bash
git rm -r --cached hspliving
rm -rf hspliving
```

### 2. 添加子模块

然后，使用 `git submodule add` 命令添加 `hspliving2` 作为子模块。你提供的子模块仓库地址为 `git@github.com:EXsYang/hspliving2.git`，我们将其添加到当前父仓库中名为 `hspliving` 的路径下：

```bash
git submodule add git@github.com:EXsYang/hspliving2.git hspliving
```

这条命令会克隆 `hspliving2` 仓库到 `hspliving` 目录，并在父仓库中创建一个 `.gitmodules` 文件（如果它还不存在的话），记录子模块的信息。

### 3. 提交更改

添加子模块后，你需要提交这些更改到父仓库中，包括 `.gitmodules` 文件和子模块的添加：

```bash
git add .gitmodules hspliving
git commit -m "Add hspliving2 submodule"
```

### 4. 推送更改到远程仓库

最后，将这些更改推送到父仓库的远程仓库：

```bash
git push
```

完成这些步骤后，`hspliving2` 将作为一个子模块被成功添加到 `hspedu_hspliving` 仓库中。任何克隆父仓库的人现在可以通过运行 `git submodule update --init` 来获取子模块的内容。







如果运行 `cat .gitmodules` 时显示“`No such file or directory`”，这意味着当前仓库（在这个情况下，是 `hspedu_hspliving`）中不存在 `.gitmodules` 文件。`.gitmodules` 文件在仓库中用于跟踪子模块的信息，包括每个子模块的路径和对应的远程仓库 URL。如果这个文件不存在，那么可能有以下几种情况：

### 1. 子模块未被添加

如果你期望 `hspedu_hspliving` 包含子模块，但 `.gitmodules` 文件不存在，可能是因为子模块还没有被正确添加到仓库中。添加子模块的正确命令是：

```bash
git submodule add <repository-url> <path-to-submodule>
```

例如：

```bash
git submodule add https://github.com/username/submodule-repository.git path/to/submodule
```

这将会创建 `.gitmodules` 文件（如果它还不存在的话），并向其中添加刚刚添加的子模块信息。

### 2. `.gitmodules` 文件被删除或未提交

如果之前添加过子模块，但现在 `.gitmodules` 文件不见了，可能是因为这个文件被删除或者从未被提交到仓库中。检查仓库的提交历史，看是否可以找到关于 `.gitmodules` 文件的任何提交。如果文件被误删除，你可能需要从历史中恢复它或重新添加子模块。

### 3. 你不在仓库的根目录

确认你当前的工作目录是仓库的根目录。`.gitmodules` 文件位于仓库的根目录下。如果你在子目录中，可能会看到 “No such file or directory” 错误。使用 `pwd` 命令确认你的当前目录，并使用 `cd` 命令必要时更改目录到仓库的根目录。

### 解决建议

- 确认你在仓库的根目录。
- 如果你想添加子模块，使用 `git submodule add` 命令。
- 如果 `.gitmodules` 应该存在，尝试从仓库的历史中恢复这个文件，或检查是否在某个分支中忘记合并它。
- 确认你的子模块和 `.gitmodules` 文件都已经被提交并推送到了远程仓库。



## 解释`<repository-url>` 和 `<path-to-submodule>`

当你使用 `git submodule add` 命令来添加一个子模块到你的 Git 仓库时，这个命令需要两个主要参数：`<repository-url>` 和 `<path-to-submodule>`。这两个参数的含义如下：

### `<repository-url>`

这是你想要添加为子模块的 Git 仓库的 URL。这个 URL 指向子模块的远程仓库位置，可以是 HTTPS 或 SSH 格式的 URL。例如：

- 对于 GitHub 上的一个仓库，HTTPS 格式的 URL 可能看起来像 `https://github.com/username/repository.git`。
- 使用 SSH 格式的 URL，则可能是 `git@github.com:username/repository.git`。

这个 URL 允许你的 Git 仓库知道从哪里获取子模块的数据。

### `<path-to-submodule>`

这是在你的主仓库中想要放置子模块的本地路径。这个路径相对于你的主仓库的根目录，指定了子模块在你的仓库结构中的位置。这个路径不应该指向一个已经存在的目录，因为 Git 会在这个位置创建一个包含子模块内容的新目录。例如，如果你想将子模块放在 `libs/my-submodule` 目录下，`<path-to-submodule>` 应该被设置为 `libs/my-submodule`。

这个路径不仅定义了子模块在你的项目中的物理位置，而且这个信息也会被记录在 `.gitmodules` 文件中，这样 Git 就知道如何将子模块的远程仓库与你的主仓库关联起来。

### 示例命令

将上面的信息结合起来，添加一个子模块的命令看起来可能是这样的：

```bash
git submodule add https://github.com/username/repository.git path/to/submodule
```

在这个例子中，`https://github.com/username/repository.git` 是子模块的远程仓库 URL，而 `path/to/submodule` 是你想在你的主仓库中放置子模块的路径。执行这个命令后，Git 会在指定的路径下创建一个新目录，其中包含了子模块的内容，并且更新 `.gitmodules` 文件，包括子模块的路径和 URL。







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

-----------上面是之前的，下面是现在的----------------
$ git config --global user.name 'EXsYang' 

$ git config --global user.email 'yangda27@aliyun.com'
#初始化本地仓库
$ git init


#克隆
$ git clone url


#文件状态，使用 git add 文件从 Untracked(未跟踪) -> Staged(暂存)
$ git status ABC.txt

# `git add .` 需要在.git根目录下执行，如果在子目录执行，则会将该子目录之外的文件未添加追踪！
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
$ git reset --hard b8c883f9
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
   git lfs install
   ```
   
2. **跟踪大文件**：使用 Git LFS 跟踪那些大文件。以您提到的文件为例：

   ```
   git lfs track "学习时的代码/springcloud/nacos/nacos-server-1.2.1/nacos/target/nacos-server.jar"
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
   git lfs install
   ```
   
这个命令会设置 Git LFS 的钩子（hooks）。这是在每个使用 Git LFS 的仓库中需要执行的步骤。

### 配置文件跟踪

1. **指定要跟踪的文件类型**：在仓库目录中，使用 `git lfs track` 命令来指定 Git LFS 应该跟踪哪些文件类型。例如，要跟踪所有 `.zip` 和 `.mp4` 文件，您可以执行：

   ```
   git lfs track "*.zip"
   git lfs track "*.mp4"
   ```

   这将会修改 `.gitattributes` 文件，添加关于这些文件类型的规则。

2. **提交 `.gitattributes` 文件**：将更新后的 `.gitattributes` 文件提交到您的仓库：

   ```
   git add .gitattributes
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





# 6 修改历史提交中的作者和邮箱信息，使之与你的 GitHub 账户相匹配，以便于你的贡献能够正确显示在 GitHub 的贡献图上。

是的，上述操作的基本目的与之前讨论的使用 `git filter-repo` 更改作者信息的效果是一样的，都旨在修改 Git 历史中的作者名和邮箱地址。不过，这两种方法在实现上有一些关键的区别：

### `git filter-branch` vs `git filter-repo`

1. **命令和工具**：
   - `git filter-branch` 是 Git 自带的一个工具，用于重写大量的分支历史。然而，由于它的复杂性和潜在的风险，Git 官方已不推荐使用 `git filter-branch`，并建议使用更现代的 `git filter-repo`。
   - `git filter-repo` 是一个更快、更安全的第三方工具，专为替代 `git filter-branch` 而设计。它提供了更多的功能和更好的错误处理机制。

2. **安全性和性能**：
   - `git filter-branch` 可能会留下备份引用和其他副作用，这可能导致意外的数据泄露或历史不一致。它的执行速度通常比 `git filter-repo` 慢，尤其是在处理大型仓库时。
   - `git filter-repo` 更加高效，在执行过程中会明确地清理不必要的数据，并确保历史的一致性和安全。

### 实现的效果

尽管两种方法在技术实现上有所不同，但它们达到的最终效果是相似的，即修改历史提交中的作者和邮箱信息，使之与你的 GitHub 账户相匹配，以便于你的贡献能够正确显示在 GitHub 的贡献图上。

### 使用 `git filter-repo`

建议使用 `git filter-repo`，尤其是在处理较新的或较大的仓库时，因为它更安全、更快速，并且由于其设计是为了替代 `git filter-branch`，因此在处理可能的错误和边缘情况时表现更好。

如果你决定使用 `git filter-repo`，可以使用类似以下命令来替换旧的提交者和作者信息：

```bash
git filter-repo --mailmap mailmap.txt --force
```

其中 `mailmap.txt` 文件包含了旧新信息的映射，如上文所示：下面这个无效。

```
CodeYang <old-email@example.com> = EXsYang <yangda27@aliyun.com>
```

下面这个格式有效！

~~~
EXsYang <yangda27@aliyun.com> <10825197+kapaiya@user.noreply.gitee.com>
~~~

成功很可能是因为：

1. **正确的格式**：您使用的 `mailmap` 文件中的格式 `EXsYang <yangda27@aliyun.com> <10825197+kapaiya@user.noreply.gitee.com>` 正确地映射了旧的邮箱到新的用户名和邮箱。这种格式清楚地指出了旧邮箱应该被替换为新的用户名和邮箱。
2. **适用的命令选项**：`git filter-repo --mailmap` 正确地解析了 `mailmap` 文件，并应用了您希望的更改。这表明使用 `--mailmap` 选项通常更适合处理用户名和邮箱的变更。



### 结论

无论选择哪种工具，主要目标是保证历史提交信息正确反映你的身份，以确保 GitHub 能够识别出这些提交属于你，并在你的贡献概览中显示。在执行任何这类操作之前，都应该确保备份仓库，避免不可恢复的数据丢失。



## 6.1 其他仓库是不是也可以这样修改，修改历史提交中的作者和邮箱信息？

是的，您可以使用相同的方法来修改其他仓库的提交历史。`git filter-repo` 工具是非常灵活的，并且可以应用于任何 Git 仓库，以进行各种类型的历史重写操作，包括但不限于更改作者信息、移除文件、重写提交信息等。

### 在其他仓库使用 `git filter-repo` 的步骤：

1. **备份仓库**：

   - 在操作任何仓库之前，始终确保进行完整的备份，以防万一操作出现错误或不可预见的后果。

2. **准备 `mailmap.txt`**：

   - 根据需要更改的具体用户名和邮箱，准备一个 `mailmap.txt` 文件，格式与您之前成功使用的相同。

3. **执行命令**：

   - 在目标仓库的根目录下执行 `git filter-repo` 命令，使用 `--mailmap` 选项和相应的 `mailmap.txt` 文件。例如：

     ```bash
     git filter-repo --mailmap mailmap.txt --force
     ```

4. **验证更改**：

   - 使用 `git log` 检查历史记录，确保更改已正确应用，并且没有意外的副作用。

5. **推送更改**：

   - 如果您满意更改，并且确定没有问题，可以使用 `git push --force` 将更改推送到远程仓库。

6. **通知团队成员**：

   - 如果您在一个团队环境中工作，确保通知所有相关的团队成员关于历史更改。他们可能需要重新克隆仓库或调整他们的本地设置以适应新的历史。

### 注意事项

- **使用的责任**：重写历史是一种有力的操作，但它会改变仓库的基础结构。在团队项目中，这可能导致合作者的混淆和额外的工作，因为每个人都需要适应这些更改。
- **迁移引用**：在使用 `git filter-repo` 时，所有分支和标签的引用都可能会被重写，这可能会影响所有基于这些引用的开发活动。
- **透明和沟通**：在进行这样的操作时，与项目的其他参与者保持透明和开放的沟通是非常重要的。

通过遵循这些步骤和注意事项，您可以安全有效地在其他仓库中使用 `git filter-repo` 来修改提交历史。

## 6.2 重新关联远程仓库



执行如下指令即可：

~~~
git remote add origin git@github.com:EXsYang/mycode.git
git remote add origin git@github.com:EXsYang/uploadfiles.git

# --set-upstream 推送到远端的同时并且建立起和远端分支的关联关系。如果当前分支已经和远端分支关联，# 则可以省略分支名和远端名。
git push --set-upstream origin main --force
git push --set-upstream origin master --force


~~~

指令参考：

~~~

git remote add origin git@github.com:EXsYang/uploadfiles.git


#使用 git remote set-url 命令来更新 origin  
git remote set-url origin git@github.com:EXsYang/uploadfiles.git


git remote -v

git status

git add .

# --set-upstream 推送到远端的同时并且建立起和远端分支的关联关系。如果当前分支已经和远端分支关联，# 则可以省略分支名和远端名。
git push --set-upstream origin main --force
git push --set-upstream origin master --force
git status 

git commit -m 'commit'

git push origin master:master
git push 

git push --force 

执行强制推送
如果您决定强制推送，可以使用以下命令：
git push origin main --force

或者更安全的方法：
git push origin main --force-with-lease
--force-with-lease 参数提供了一个安全网，它只会在远程分支的当前状态与您本地认为的远程分支的状态相匹配时才会推送。这样可以防止覆盖由其他人所做的未知更改。

~~~



# 7 修复git提交不显示commit贡献小绿点【git bash】【不推荐使用该方案，更推荐使用`git filter-repo` 】

#### 原因:

最近一直在用github来写博客,但是今天发现github上的contributions记录并没有我的提交记录.

原因在于：本地的git默认的user.name和user.email并不是你的,而是本机.所以在此期间你的commit都是默认本机的.

你可以用git config user.name / git config user.email 来查看自己的git所属

查不出的结果应该是为空,因为你根本就没设置过.

然后用git log查看一下commit记录.你会惊奇的发现虽然在往你的github仓库中push,但是用户名和邮箱却不是你github的,而是系统默认的pc用户.

所以github贡献统计的根本就不是你的账户,就没有贡献小绿点咯.

#### 解决办法:

#### 保证以后的commit

如果你只是想以后的commit记录,你只需要把当前本地git的user.name和user.email配置一下即可

不要加双引号！

```
$ git config --global user.name github’s Name

$ git config --global user.email github@xx.com
123
```

#### 修改之前的commit

如果你不想浪费之前的commit贡献,需要把所有你用默认账户的commit都归为你真正的名下怎么办.

我们需要修改所有的commit和push历史：
【在你想修改的仓库中】

- 修改所有者：

```
git filter-branch -f --env-filter '
if [ "$GIT_AUTHOR_NAME" = "CodeYang" ]
then
export GIT_AUTHOR_NAME="EXsYang"
export GIT_AUTHOR_EMAIL="yangda27@aliyun.com"
fi
' HEAD
```

- 修改贡献者：

```
git filter-branch -f --env-filter '
if [ "$GIT_COMMITTER_NAME" = "CodeYang" ]
then
export GIT_COMMITTER_NAME="EXsYang"
export GIT_COMMITTER_EMAIL="yangda27@aliyun.com"
fi
' HEAD
```

之后就能在commit记录里看到自己的头像了，而且在github主页上也会有小绿点



# 8 手动修改提交历史的作者信息

如果只有少数几个提交需要修改，您可以使用 `git rebase -i` （交互式变基）手动编辑这些提交的作者信息，这种方法对于处理少量的提交来说非常有效和直接。

### 使用交互式变基手动修改提交

以下是手动修改几个提交的步骤：

1. **启动交互式变基**：
   
   - 找到要修改的最早的提交前一个提交的哈希。如果您要修改的第一个有问题的提交是仓库中的第一个提交，您可以使用 `--root` 选项开始变基。
   - 运行交互式变基命令：
   
     ```bash
     git rebase -i --root
     ```
   
   - 如果不是从根提交开始，替换 `commit_hash^` 为最早需要修改的提交的前一个提交的哈希：
   
     ```bash
     git rebase -i commit_hash^
     ```
   
2. **在编辑器中选择操作**：
   - Git 将打开一个文本编辑器窗口，列出将要重写的提交。
   - 对于您想要修改的每个提交，将 `pick` 命令更改为 `edit`，然后保存并关闭编辑器。

3. **修改每个选定的提交**：
   - 当变基进程暂停以允许您修改提交时，使用以下命令修改作者信息（确保移除引号）：

     ```bash
     git commit --amend --author="EXsYang <yangda27@aliyun.com>"
     ```

   - 继续变基过程：

     ```bash
     git rebase --continue
     ```

   - 重复此步骤，直到所有选定的提交都已修改。

4. **解决可能出现的冲突**：
   - 如果在变基过程中遇到冲突，Git 将提示您解决冲突。解决冲突后，添加更改到暂存区，并使用 `git rebase --continue` 继续变基。

5. **完成变基**：
   - 一旦完成所有更改并且变基进程结束，使用以下命令将更改推送到远程仓库：

     ```bash
     git push --force
     ```

### 注意事项

- **备份**：在执行变基操作之前，确保您有仓库的完整备份。
- **通知团队**：如果您在团队环境中工作，通知团队成员您将进行变基操作，因为这会改变仓库的提交历史。
- **慎用**：变基是一种强大的工具，但也可能导致复杂的问题，特别是在多人项目中。确保您完全理解变基的影响。

这种方法允许您精确控制哪些提交被修改，并确保只修改需要改变的部分，非常适合处理只有几个提交需要修正的情况。
