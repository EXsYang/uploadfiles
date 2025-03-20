# 1 docker 复制文件夹 和复制文件 都是docker cp 指令



~~~bash
[root@racknerd-8454f32 ~]# docker ps
CONTAINER ID   IMAGE                                              COMMAND                  CREATED        STATUS                    PORTS                                      NAMES
c58f9e66f252   shirous/fiora-r2-storage:stable-no-progress-v1.8   "docker-entrypoint.s…"   16 hours ago   Up 16 hours               9200/tcp, 0.0.0.0:9211->9211/tcp           fiorar2
~~~





要将 Docker 容器中的 app、web 和 server 文件夹复制到宿主机的 /mydata/testfiora/ 目录下，可以使用 docker cp 命令。以下是具体步骤和命令：

前提条件

1. 确保宿主机上的目标目录 /mydata/testfiora/ 已存在。如果不存在，可以先创建：

   bash

   ```bash
   mkdir -p /mydata/testfiora/
   ```

2. 从你的输出中，容器 fiorar2 的 CONTAINER ID 是 c58f9e66f252，文件位于容器内的 /usr/app/fiora/packages/ 目录下。

使用 docker cp 复制文件夹

docker cp 命令的格式是：

```text
docker cp [容器ID或名称]:[容器内路径] [宿主机路径]
```

根据你的需求，分别复制 app、web 和 server 文件夹到宿主机的 /mydata/testfiora/ 目录：

1. 复制 app 文件夹：

   bash

   ```bash
   docker cp c58f9e66f252:/usr/app/fiora/packages/app /mydata/testfiora/
   ```

2. 复制 web 文件夹：

   bash

   ```bash
   docker cp c58f9e66f252:/usr/app/fiora/packages/web /mydata/testfiora/
   ```

3. 复制 server 文件夹：

   bash

   ```bash
   docker cp c58f9e66f252:/usr/app/fiora/packages/server /mydata/testfiora/
   ```

验证

复制完成后，可以在宿主机上检查 /mydata/testfiora/ 目录，确认文件夹是否成功复制：

bash

```bash
ls -l /mydata/testfiora/
```

注意事项

- 如果容器名称（fiorar2）更容易记住，也可以用名称替代 CONTAINER ID，例如：

  bash

  ```bash
  docker cp fiorar2:/usr/app/fiora/packages/app /mydata/testfiora/
  ```

- 如果目标目录 /mydata/testfiora/ 需要覆盖已有内容，请确保提前备份。

- 复制过程中，容器不需要停止，docker cp 支持运行中的容器操作。

这样，你就可以成功将容器内的 app、web 和 server 文件夹复制到宿主机的指定目录下了！





# 2 **Docker命名卷(数据卷)的方式数据持久化**

使用Docker命名卷方式确实更简洁，而且**即使容器被删除，数据也不会丢失**。这是命名卷的一个重要特性和主要优势。

#### **命名卷的工作原理**

Docker命名卷是由Docker管理的特殊存储区域，它们完全独立于容器的生命周期。当使用命名卷时：

1. **数据持久性**：命名卷中的数据会持久保存在宿主机上，即使容器被删除，数据卷依然存在 **存储位置**：数据实际存储在宿主机的 `/var/lib/docker/volumes/` 目录下，每个命名卷会有自己的子目录 **独立性**：命名卷与容器解耦，可以被多个容器共享和重复使用

#### **命名卷的优势**

相比之前的直接挂载（绑定挂载），命名卷有以下优势：

1. **更好的隔离性**：宿主机无法直接访问卷中的文件，提高了安全性
2. **便于管理**：Docker自动管理卷的创建、存储和生命周期 **跨平台兼容性**：不依赖于宿主机的目录结构，提高了应用的可移植性
3. **更高效的性能**：在某些文件系统上可能有更好的I/O性能

#### **管理命名卷的相关命令**

bash



```bash
# 创建命名卷
docker volume create fiora-db-data

# 查看所有卷
docker volume ls

# 查看卷的详细信息
docker volume inspect fiora-db-data

# 删除不再使用的卷
docker volume rm fiora-db-data

# 删除所有未被容器使用的卷
docker volume prune
```

#### **重要说明**

1. 即使您删除了容器，命名卷中的数据仍然保留
2. 只有显式地使用 `docker volume rm` 命令或 `docker volume prune` 命令才会删除卷中的数据
3. 如果需要备份数据，可以查看卷的实际存储路径，然后进行备份
4. 如果您之后想要使用新容器但沿用原来的数据，只需要在创建新容器时指定同一个命名卷即可

使用命名卷既满足了您不希望容器内修改直接影响宿主机指定路径的需求，同时又保证了数据的持久性和便捷管理。



# 3 以下是查看内存和硬盘信息的 Docker 相关指令，以及删除闲置镜像的指令：



## 检查服务器资源使用情况:

```bash
# 检查内存使用
free -h

# 检查磁盘空间
df -h

# 检查CPU使用
top
```

有时候资源不足也会导致服务无法正常启动。





查看内存和硬盘信息的指令

1. **查看容器内存使用情况**
   使用 docker stats 可以实时查看所有运行中容器的内存、CPU 等资源使用情况：

   bash

   ```bash
   docker stats
   ```

   - 如果只想查看特定容器的信息，可以指定容器 ID 或名称，例如：

     bash

     ```bash
     docker stats c58f9e66f252
     ```

   - 输出会包含内存使用量（Memory Usage）和限制（Memory Limit）。

2. **查看宿主机硬盘使用情况**
   Docker 本身的镜像、容器和卷会占用宿主机的硬盘空间，可以使用以下命令查看：

   - 查看 Docker 占用的总磁盘空间：

     bash

     ```bash
     docker system df
     ```

     - 输出包括镜像（Images）、容器（Containers）、本地卷（Local Volumes）等的占用空间。

   - 查看更详细的信息（包括每个镜像、容器等的具体大小）：

     bash

     ```bash
     docker system df -v
     ```

3. **查看宿主机的内存和硬盘信息（非 Docker 专用）**
   如果需要查看宿主机的整体资源情况，可以使用 Linux 系统命令：

   - 查看内存使用情况：

     bash

     ```bash
     free -h
     ```

     - 输出以人类可读的格式显示总内存、已用内存和可用内存。

   - 查看硬盘使用情况：

     bash

     ```bash
     df -h
     ```

     - 输出显示各个挂载点的磁盘使用情况，包括总大小、已用空间和可用空间。





## 删除闲置镜像的指令

闲置镜像指的是没有任何容器依赖的镜像（即“dangling”镜像）。以下是清理它们的命令：

1. **删除所有未使用的（dangling）镜像**  

   bash

   ```bash
   docker image prune
   ```

   - 这会删除所有没有被任何容器引用的镜像。
   - 执行前会提示确认，显示将被释放的空间。

2. **删除所有未使用的镜像（包括未被容器引用的所有镜像）**
   如果想更彻底清理，包括未标记（untagged）和未使用的镜像：

   bash

   ```bash
   docker image prune -a
   ```

   - -a 表示删除所有未被运行中容器使用的镜像（即使它们有标签）。
   - 注意：这可能会删除你手动拉取但当前未使用的镜像，请谨慎操作。

3. **强制删除特定镜像**
   如果你知道某个镜像的 ID 或名称，可以直接删除：

   bash

   ```bash
   docker rmi [镜像ID或名称]
   ```

   - 例如：

     bash

     ```bash
     docker rmi shirous/fiora-r2-storage:stable-no-progress-v1.8
     ```

   - 如果镜像正在被容器使用，需要先停止并删除相关容器，或者加上 -f 强制删除：

     bash

     ```bash
     docker rmi -f [镜像ID或名称]
     ```

4. **清理所有未使用的资源（包括容器、网络、镜像等）**
   如果想一次性清理所有未使用的 Docker 对象：

   bash

   ```bash
   docker system prune
   ```

   - 这会删除所有停止的容器、未使用的网络和 dangling 镜像。

   - 如果加上 -a，则清理所有未使用的镜像：

     bash

     ```bash
     docker system prune -a
     ```

注意事项

- 在删除镜像之前，建议先用 docker images 查看当前所有镜像，确认哪些是闲置的：

  bash

  ```bash
  docker images
  ```

- 如果镜像被运行中的容器依赖，需先停止并删除相关容器（docker stop 和 docker rm）。

希望这些指令能帮到你！如果有其他需求，可以随时告诉我。





# 4 清理服务器闲置docker镜像



~~~bash
[root@racknerd-8454f32 ~]# docker images
REPOSITORY                      TAG                       IMAGE ID       CREATED        SIZE
calciumion/new-api              latest                    26b23331093d   2 days ago     174MB
shirous/r2-presign-service      latest                    60e843245630   6 days ago     159MB
shirous/fiorar2-cors-proxy      latest                    8d3b86f7beb9   6 days ago     125MB
shirous/fiorar2-nginx           latest                    94eea2e719b7   6 days ago     204MB
shirous/fiora-r2-storage        stable-no-progress-v1.8   4be93fe7db07   9 days ago     3.02GB
ghcr.io/open-webui/open-webui   main                      44f22c911346   11 days ago    4.49GB
shirous/shirouwebchat           latest                    4e7a47ec51f2   2 weeks ago    2.62GB
shirous/ai-adapter_vrchats      latest                    1c6540236940   2 weeks ago    927MB
shirous/vrchats                 <none>                    c9a0209bb757   2 weeks ago    1.89GB
redis                           latest                    fa310398637f   2 months ago   117MB
mongo                           latest                    6fe2220a3a52   3 months ago   881MB
redislabs/redisinsight          1.13.1                    76f704dba29e   2 years ago    1.15GB
[root@racknerd-8454f32 ~]# df -h
Filesystem      Size  Used Avail Use% Mounted on
devtmpfs        1.2G     0  1.2G   0% /dev
tmpfs           1.3G     0  1.3G   0% /dev/shm
tmpfs           1.3G  133M  1.1G  11% /run
tmpfs           1.3G     0  1.3G   0% /sys/fs/cgroup
/dev/vda1        39G   25G   12G  68% /
tmpfs           247M     0  247M   0% /run/user/0
overlay          39G   25G   12G  68% /var/lib/docker/overlay2/3f66a07602ac442b70d2e9187fed2ceedacb0b2e5489a0aff8e44bbd83306236/merged
overlay          39G   25G   12G  68% /var/lib/docker/overlay2/fce71a5f49df83167680a089c1fa8e731cfa43cc7debd9e55a97dfd93ef2b3e2/merged
overlay          39G   25G   12G  68% /var/lib/docker/overlay2/8c81308488ef3943b2c0109bebf0fbc282b0fb4e440e4ef6b619a4ac0bbddc00/merged
overlay          39G   25G   12G  68% /var/lib/docker/overlay2/75b72ae0c95f4f8968307ef4a1f2d849351e218d5cfb67ba10113de25435f86b/merged
overlay          39G   25G   12G  68% /var/lib/docker/overlay2/a4e6e1f2c36106cc1215d5a0065bf1d267613ecc40440444d57b39bbe0f18e1b/merged
overlay          39G   25G   12G  68% /var/lib/docker/overlay2/8e20e7f23c8178399ad83342caf8b2b7cf7a5b63267e620febf0b2eeef89cc4d/merged
overlay          39G   25G   12G  68% /var/lib/docker/overlay2/9b024e9115bda94768a0747e1b5e00e5f3d22c80d623e6f598d79ababb043ed7/merged
overlay          39G   25G   12G  68% /var/lib/docker/overlay2/c912bc8632b4aa6662b1d280b432c4c285ef4ccb534fcb9050395b992523f6fa/merged
overlay          39G   25G   12G  68% /var/lib/docker/overlay2/c7d39b7fb2d421c9582c04cecbc62ff7e5908a9324ca98388a6d899b91479576/merged
overlay          39G   25G   12G  68% /var/lib/docker/overlay2/02e377801cf1292cb34a1944ff16e018eedbb3a51daa22c0aa1233a1e178a542/merged
[root@racknerd-8454f32 ~]# 
~~~





从你的输出中可以看到，宿主机的根分区（/dev/vda1）和 Docker 的 overlay 文件系统都占用了 39G 中的 25G，剩余 12G，使用率达到 68%。Docker 镜像和相关数据占据了很大一部分空间。以下是逐步清理的建议和具体操作，帮助你释放磁盘空间：

------

1. 检查 Docker 占用空间的详情

运行以下命令，查看 Docker 的镜像、容器和卷具体占用了多少空间：

bash

```bash
docker system df
```

如果需要更详细的信息：

bash

```bash
docker system df -v
```

- 这会显示每个镜像、容器和卷的大小，帮助你定位占用空间的主要来源。

------

2. 清理未使用的 Docker 对象

你的镜像列表中有一些较大的镜像（例如 4.49GB 的 open-webui 和 3.02GB 的 fiora-r2-storage），可能还有未使用的容器或数据。以下是逐步清理的方法：

(1) 删除停止的容器

停止的容器可能会占用空间，先查看是否有已停止的容器：

bash

```bash
docker ps -a
```

如果有不需要的已停止容器，可以删除：

bash

```bash
docker rm [容器ID]
```

或者一次性删除所有已停止的容器：

bash

```bash
docker container prune
```

(2) 删除未使用的镜像

从你的 docker images 输出中，shirous/vrchats 显示 <none>，这是一个 dangling 镜像（未被标记），可以清理：

bash

```bash
docker image prune
```

- 这会删除所有未被容器使用的 dangling 镜像。

如果想更彻底清理，包括未被容器使用的所有镜像（即使有标签）：

bash

```bash
docker image prune -a
```

- **注意**：这会删除所有当前未运行的镜像，例如你列出的 calciumion/new-api:latest 等，如果不需要这些镜像，可以执行。

(3) 删除未使用的卷

Docker 卷也可能占用空间，检查是否有未使用的卷：

bash

```bash
docker volume ls
```

删除所有未被使用的卷：

bash

```bash
docker volume prune
```

(4) 一键清理所有未使用资源

如果想一步到位，清理所有未使用的容器、网络、dangling 镜像和卷：

bash

```bash
docker system prune
```

- 如果还想清理未使用的有标签镜像：

  bash

  ```bash
  docker system prune -a
  ```

- 执行前会提示你确认，显示预计释放的空间。

------

3. 手动删除特定大镜像

你的镜像中有些占用空间较大（例如 ghcr.io/open-webui/open-webui:main 4.49GB 和 shirous/fiora-r2-storage:stable-no-progress-v1.8 3.02GB）。如果这些镜像不再需要，可以手动删除：

先检查是否有容器依赖这些镜像：

bash

```bash
docker ps -a
```

如果有依赖的容器，先停止并删除：

bash

```bash
docker stop [容器ID]
docker rm [容器ID]
```

然后删除镜像：

bash

```bash
docker rmi ghcr.io/open-webui/open-webui:main
docker rmi shirous/fiora-r2-storage:stable-no-progress-v1.8
```

------

4. 检查清理效果

清理完成后，再次检查磁盘使用情况：

bash

```bash
df -h
```

以及 Docker 的占用情况：

bash

```bash
docker system df
```

------

5. 其他优化建议

如果清理后空间仍然不足，可以考虑以下措施：

- **减少镜像大小**：检查 Dockerfile 是否可以优化（例如使用更小的基础镜像如 alpine）。

- **调整存储位置**：如果服务器有其他分区，可以将 Docker 的数据目录（默认在 /var/lib/docker）迁移到更大的磁盘。

  - 查看当前 Docker 数据目录：

    bash

    ```bash
    docker info --format '{{.DockerRootDir}}'
    ```

  - 迁移需要停止 Docker 服务并移动数据，操作前请备份。

------

示例操作流程

假设你想清理所有未使用的资源并删除 open-webui 镜像：

1. 清理未使用资源：

   bash

   ```bash
   docker system prune -a
   ```

2. 停止并删除依赖 open-webui 的容器（例如 b67224cbe896）：

   bash

   ```bash
   docker stop b67224cbe896
   docker rm b67224cbe896
   ```

3. 删除镜像：

   bash

   ```bash
   docker rmi ghcr.io/open-webui/open-webui:main
   ```

4. 检查效果：

   bash

   ```bash
   df -h
   ```

------

通过以上步骤，你的磁盘占用率应该会显著下降。如果还有问题或需要更具体的帮助，请告诉我！





# 5 如何将docker镜像解包为编译前的文件夹？

Docker 镜像本身是一个分层文件系统（基于 UnionFS，例如 overlay2），它包含了编译后的文件、依赖和配置等内容，无法直接“解包”成编译前的源代码文件夹，因为镜像中通常不包含源代码（除非源代码被刻意打包进去）。不过，你可以将 Docker 镜像的内容提取到宿主机上，得到镜像文件系统的完整结构（即运行时的文件和目录）。以下是具体方法：

------

方法 1：使用 docker export 提取镜像内容

这种方法适用于提取整个镜像的文件系统，但需要先将镜像运行成容器。

1. **查看镜像列表** 先确认你要解包的镜像名称和标签：

   bash

   ```bash
   docker images
   ```

   例如，你想解包 shirous/fiora-r2-storage:stable-no-progress-v1.8。

2. **创建并运行一个临时容器** 用目标镜像启动一个容器，但不需要长期运行：

   bash

   ```bash
   docker run -d --name temp_container shirous/fiora-r2-storage:stable-no-progress-v1.8 tail -f /dev/null
   ```

   - -d 表示后台运行。
   - tail -f /dev/null 让容器保持运行状态。

3. **导出容器文件系统** 将容器的文件系统导出为 tar 文件：

   bash

   ```bash
   docker export temp_container > fiora-r2-storage.tar
   ```

4. **解压 tar 文件** 在宿主机上解压导出的 tar 文件到指定目录：

   bash

   ```bash
   mkdir /mydata/fiora-r2-storage
   tar -xvf fiora-r2-storage.tar -C /mydata/fiora-r2-storage
   ```

5. **清理临时容器** 完成后停止并删除临时容器：

   bash

   ```bash
   docker stop temp_container
   docker rm temp_container
   ```

6. **结果** 现在 /mydata/fiora-r2-storage 目录下包含了镜像的完整文件系统。你可以用 ls -l /mydata/fiora-r2-storage 查看内容。

------

方法 2：使用 docker save 和手动解包镜像层

这种方法直接操作镜像本身，不需要运行容器，但需要处理分层结构。

1. **保存镜像为 tar 文件**

   bash

   ```bash
   docker save shirous/fiora-r2-storage:stable-no-progress-v1.8 -o fiora-r2-storage.tar
   ```

2. **解压 tar 文件** 创建一个目录并解压：

   bash

   ```bash
   mkdir /mydata/fiora-r2-storage-raw
   tar -xvf fiora-r2-storage.tar -C /mydata/fiora-r2-storage-raw
   ```

   - 你会看到多个文件，包括 manifest.json 和一些以哈希命名的 .tar 文件（每层一个）。

3. **解析 manifest.json** 查看 manifest.json 文件，找到镜像的层信息：

   bash

   ```bash
   cat /mydata/fiora-r2-storage-raw/manifest.json
   ```

   - 它会列出镜像的层（Layers），例如 "Layers": ["abc123/layer.tar", "def456/layer.tar"]。

4. **逐层解压** 每一层是一个 .tar 文件，解压所有层到一个目录：

   bash

   ```bash
   mkdir /mydata/fiora-r2-storage-layers
   for layer in /mydata/fiora-r2-storage-raw/*.tar; do tar -xvf "$layer" -C /mydata/fiora-r2-storage-layers; done
   ```

   - 层之间可能有覆盖关系，最终结果是合并后的文件系统。

5. **结果** /mydata/fiora-r2-storage-layers 包含了镜像的所有文件和目录。

------

注意事项

1. **编译前文件夹的局限性**

   - 镜像中通常只有编译后的二进制文件、库和配置，不包含源代码或 Dockerfile。
   - 如果你需要“编译前的文件夹”（即源代码），必须在镜像构建时将源代码包含进去，或者从镜像的构建上下文（例如原始 Dockerfile 和代码仓库）获取。

2. **检查镜像中的文件** 在解包后，检查是否有类似 Dockerfile、src/ 或其他源代码目录。例如：

   bash

   ```bash
   ls -l /mydata/fiora-r2-storage
   find /mydata/fiora-r2-storage -name "*.ts" -o -name "*.js" -o -name "Dockerfile"
   ```

   如果有 .ts、.js 或其他源文件，说明镜像包含部分源代码。

3. **直接从容器内复制** 如果你只关心某些特定目录（例如之前的 app、web、server），可以用 docker cp：

   bash

   ```bash
   docker cp temp_container:/usr/app/fiora/packages/app /mydata/testfiora/
   ```

------

推荐操作

如果你只是想提取文件系统，建议使用 **方法 1（docker export）**，因为它简单直接。如果需要分析镜像的分层结构，可以用 **方法 2（docker save）**。

例如，提取 shirous/fiora-r2-storage:stable-no-progress-v1.8：

bash

```bash
docker run -d --name temp_container shirous/fiora-r2-storage:stable-no-progress-v1.8 tail -f /dev/null
docker export temp_container > fiora-r2-storage.tar
mkdir /mydata/fiora-r2-storage
tar -xvf fiora-r2-storage.tar -C /mydata/fiora-r2-storage
docker stop temp_container
docker rm temp_container
```

完成后，检查 /mydata/fiora-r2-storage 是否包含你需要的文件。如果还有其他需求（例如反编译或重建 Dockerfile），请告诉我！
