# 1 在Linux 系统中，Docker 的安装方式主要取决于你的**Linux 发行版体系**（使用`apt`的Debian/Ubuntu 体系，还是使用`yum`/`dnf`的RHEL/CentOS 体系）以及**应用场景**（自动化部署、规范生产环境还是离线机房）。

以下是完整的4 种安装方式分类与详细步骤解析：

### 方式一：官方自动化脚本安装（最快、跨发行版通用）

Docker 官方提供了一个检测环境并自动配置的Shell 脚本。它会自动判断当前系统是Ubuntu、Debian，还是CentOS、Rocky Linux、AlmaLinux，并对应调用`apt`或`yum`写入官方镜像源并完成安装。

- **适用场景**：个人VPS、快速测试环境搭建。

- **执行命令**：

  Bash

  ```
  curl -fsSL https://get.docker.com | bash
  ```

- **特点**：

  - **优点**：无需关心底层包管理器是`apt`还是`yum`，一行命令自动解决依赖、密钥和仓库配置。
  - **注意**：脚本默认总是拉取最新稳定版（Stable），无法精细指定特定历史版本。

### 方式二：手动配置官方软件源安装（生产环境标准做法）

这是生产环境中最规范的方式。通过手动信任Docker 官方GPG 密钥并加入官方仓库，后续可以通过系统的包管理器正常更新。根据系统体系不同，分为`yum`/`dnf`和`apt`两个分支：

#### 1. RHEL / CentOS / Rocky Linux / AlmaLinux 体系（使用`yum`或`dnf`）

Bash

```
# 步骤 1：安装基础工具包（提供 yum-config-manager 工具）
yum install -y yum-utils

# 步骤 2：添加 Docker 官方的 yum 软件源
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# 步骤 3：通过 yum 安装 Docker 核心引擎、命令行工具及 Compose 插件
yum install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# 步骤 4：启动 Docker 并设置开机自启（RHEL 体系安装后默认不自动启动）
systemctl enable --now docker
```

#### 2. Debian / Ubuntu 体系（使用`apt`）

Bash

```
# 步骤 1：安装证书与网络下载依赖
apt-get update
apt-get install -y ca-certificates curl gnupg

# 步骤 2：创建密钥存放目录并下载 Docker 官方 GPG 密钥
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

# 步骤 3：将官方源地址写入系统的 apt 源列表文件
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null

# 步骤 4：更新索引并安装
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

- **特点**：
  - **优点**：版本最新且稳定，日常只需执行`yum update`或`apt upgrade`就能直接获取官方安全补丁。
  - **缺点**：首次配置步骤相对较多。

### 方式三：使用发行版自带的仓库直接安装（开箱即用，无外部依赖）

许多Linux 发行版自己的默认官方软件仓库中也收录了Docker，不需要引入Docker 官方的第三方源：

- **RHEL / CentOS 体系**：

  Bash

  ```
  yum install -y docker
  ```

  *(注：在CentOS 8 / RHEL 8 之后的较新版本中，红帽官方主推Podman，默认源中可能不再提供`docker`包)*

- **Debian / Ubuntu 体系**：

  Bash

  ```
  apt-get update
  apt-get install -y docker.io docker-compose-v2
  ```

- **特点**：

  - **优点**：操作最简单，不需要导入任何第三方仓库与公钥。
  - **缺点**：发行版维护的版本通常更新滞后，可能比Docker 官方最新版本慢数个小版本，偶发部分新特性或新的Compose 配置语法不兼容问题。

### 方式四：离线手动安装（无外网环境/ 内网隔离）

在完全不能访问公网的服务器（如金融、政企专网）上，通常采用打包离线文件后上传安装：

1. **RPM / DEB 包离线安装**：
   - 在有网的机器上提前从官方归档站（`[https://download.docker.com/linux/](https://download.docker.com/linux/)`）下载对应系统的安装包（如`containerd.io`、`docker-ce`、`docker-ce-cli`）。
   - CentOS/RHEL 体系上传后执行：`yum localinstall *.rpm`或`rpm -ivh *.rpm`。
   - Debian/Ubuntu 体系上传后执行：`dpkg -i *.deb`。
2. **静态二进制文件解压（TGZ）**：
   - 下载官方预编译的静态二进制归档文件（如`docker-xx.xx.x.tgz`）。
   - 解压后将`docker`、`dockerd`等可执行文件直接拷贝至`/usr/bin/`目录下，并手动编写`systemd`服务单元文件。

- **特点**：
  - **优点**：不受网络限制，适合机房离线隔离环境。
  - **缺点**：依赖包冲突需要人工逐一排查，升级维护成本较高。

### 总结建议

- 如果你的VPS**连接公网良好**：直接运行`curl -fsSL [https://get.docker.com](https://get.docker.com) | bash`是目前最高效稳妥的选择。
- 如果是**企业级长期维护的云主机**：推荐采用**方式二**手动添加官方`yum`或`apt`源规范化管理。