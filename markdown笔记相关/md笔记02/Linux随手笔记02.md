# 1 排查Linux 总体磁盘占用并排序

从你截取的终端图片来看，Docker 确实已经非常干净了（镜像只有 192MB，运行中的容器只有 2 字节，没有卷占用），说明 Docker 的嫌疑已经彻底排除。

你的最后一个命令 `du -ahx / | sort -rh | head -n 20` 刚刚敲下去了，但还没显示结果（或者因为根目录文件太多，它需要跑个十几秒到一两分钟）。

既然结果还没出来，我们先不等这个命令。我给你一个**更高效、按层级排查**的方法，这样能更直观地看到是哪个非 Docker 目录吞掉了磁盘。

请依次在终端运行以下命令：

## 1. 揪出根目录下哪个大分类占的大（第一层排查）

直接运行这个命令，它只看根目录下的第一级文件夹，速度极快：

Bash

```
du -h --max-depth=1 / 2>/dev/null | sort -rh | head -n 15
```

**💡 怎么看结果？**

你会看到类似这样的输出：

- 如果 `/var` 很大（比如 30G） $\rightarrow$ 说明是系统日志、缓存或数据库。
- 如果 `/root` 很大 $\rightarrow$ 说明是你自己下载的东西、跑的脚本或打包的压缩包留在了管理员家目录。
- 如果 `/home` 很大 $\rightarrow$ 说明是其他普通用户占用的空间。
- 如果 `/www` 或 `/data` 很大 $\rightarrow$ 说明是网站数据、宝塔面板或自定义的数据盘。

~~~
[root@racknerd-8454f32 mydata]# du -h --max-depth=1 / 2>/dev/null | sort -rh | head -n 15
35G     /
26G     /var
4.0G    /usr
3.4G    /mydata
1.1G    /opt
321M    /boot
130M    /etc
117M    /run
72M     /root
268K    /home
20K     /tmp
16K     /path
16K     /lost+found
4.0K    /srv
4.0K    /mnt
[root@racknerd-8454f32 mydata]# du -h --max-depth=1 /var 2>/dev/null | sort -rh | head -n 10
~~~



## 2. 顺藤摸瓜（第二层排查）

根据上一步的结果，哪个目录大，你就把命令的尾巴改成那个目录。

- *假设上一步发现是 `/var` 最大：*

  Bash

  ```
  du -h --max-depth=1 /var 2>/dev/null | sort -rh | head -n 15
  ```

- ~~~
  [root@racknerd-8454f32 mydata]# du -h --max-depth=1 /var 2>/dev/null | sort -rh | head -n 10
  26G     /var
  24G     /var/lib
  1.1G    /var/cache
  376M    /var/log
  88K     /var/spool
  20K     /var/tmp
  12K     /var/www
  12K     /var/kerberos
  12K     /var/db
  8.0K    /var/empty
  ~~~

  

- *如果发现是 `/var/log` 最大，就再深入一层：*

  ```
  du -h --max-depth=1 /var/log 2>/dev/null | sort -rh | head -n 15
  ```

~~~
[root@racknerd-8454f32 mydata]# du -h --max-depth=1 /var/log 2>/dev/null | sort -rh | head -n 15
376M    /var/log
257M    /var/log/mongodb
37M     /var/log/audit
2.8M    /var/log/letsencrypt
144K    /var/log/nginx
20K     /var/log/php-fpm
16K     /var/log/tuned
4.0K    /var/log/sssd
4.0K    /var/log/private
4.0K    /var/log/httpd
4.0K    /var/log/chrony
4.0K    /var/log/anaconda
~~~





用这种“剥洋葱”的方式，通常不到 3 次就能精准定位到是哪个具体的文件或者日志夹爆了。

## 3.  用 `ll` 命令只能看到目录本身的大小（通常都是 4096 字节），看不到里面包含的文件总大小。

既然已经进了 `/var` 目录，我们直接用刚才那个专门看总容量的命令来给 `/var` 下的所有文件夹排个序。请直接复制并运行下面这一行：

Bash

```
du -h --max-depth=1 ./ 2>/dev/null | sort -rh | head -n 10
```

运行后，你会直接看到类似下面这样的结果，一眼就能看出是哪个文件夹吞了那 **26G**：

- 如果显示大头是 **`./log`** $\rightarrow$ 说明是**系统日志**或者某些软件的运行日志爆了。
- 如果显示大头是 **`./lib`** $\rightarrow$ 说明是**数据库数据文件**（比如 `/var/lib/mysql`），或者是 Docker 之前没清理干净的底层残留（虽然概率很低）。



~~~
[root@racknerd-8454f32 var]# du -h --max-depth=1 ./ 2>/dev/null | sort -rh | head -n 10
26G     ./
24G     ./lib
1.1G    ./cache
376M    ./log
88K     ./spool
20K     ./tmp
12K     ./www
12K     ./kerberos
12K     ./db
8.0K    ./empty
~~~





# 2 `du -h --max-depth=1 ./ 2>/dev/null | sort -rh | head -n 10`  磁盘文件夹深度1，磁盘空间占用情况排序，前10个最大的





~~~
[root@racknerd-8454f32 var]# 
[root@racknerd-8454f32 var]# du -h --max-depth=1 ./ 2>/dev/null | sort -rh | head -n 10
26G     ./
24G     ./lib
1.1G    ./cache
376M    ./log
88K     ./spool
20K     ./tmp
12K     ./www
12K     ./kerberos
12K     ./db
8.0K    ./empty
[root@racknerd-8454f32 var]# 
[root@racknerd-8454f32 var]# cd ./lib/
[root@racknerd-8454f32 lib]# ls
alternatives  dbus        fail2ban   letsencrypt     os-prober  private    sss
authselect    dhclient    games      logrotate       php        rpm        systemd
chrony        dnf         httpd      misc            plymouth   rpm-state  tpm
containerd    docker      hysteria   mongo           polkit-1   rsyslog    tuned
dav           docker.old  initramfs  NetworkManager  portables  selinux    unbound
[root@racknerd-8454f32 lib]# du -h --max-depth=1 ./ 2>/dev/null | sort -rh | head -n 10
24G     ./
23G     ./docker.old
405M    ./mongo
404M    ./docker
195M    ./rpm
30M     ./selinux
4.4M    ./dnf
1.3M    ./sss
720K    ./containerd
156K    ./systemd
[root@racknerd-8454f32 lib]# 
~~~



# 这条指令是 Linux 运维中用来快速定位“空间小偷”**的黄金组合命令。它由四个部分通过**管道符（`|`）连接而成，意思是把前一个命令的输出作为后一个命令的输入。

为了让你彻底搞懂，我们把它拆成 4 块来详细解释：

## 1. 核心扫描：`du -h --max-depth=1 ./`

`du` 是 **D**isk **U**sage（磁盘使用量）的缩写，负责计算文件和目录的大小。

- **`-h` (Human-readable)：** 以人类容易阅读的格式显示大小。如果不加，它会显示冷冰冰的字节数（比如 `54321234`）；加了之后，它会自动换算成 **K、M、G**（比如 `54M`、`26G`）。

- **`--max-depth=1`：** 这是最关键的参数，意思是**最大深度为 1 层**。

  如果不加这个参数，`du` 会把当前目录下的所有子目录、孙子目录、曾孙目录里的每一个文件都列出来，屏幕会瞬间被成千上万行垃圾信息刷屏。限制为 `1` 之后，它只会显示当前目录下的**直属文件夹**的总大小。

- **`./`：** 代表**当前目录**（你刚才已经 `cd /var` 了，所以此时 `./` 就代表 `/var`）。

## 2. 垃圾信息过滤：`2>/dev/null`

在 Linux 中，数字 `2` 代表**标准错误输出（Standard Error）**。

- 当你扫描系统文件时，有些目录可能因为权限不足拒绝访问，系统会疯狂弹出 `du: cannot read directory '...': Permission denied` 这样的报错信息。
- **`>/dev/null`** 是 Linux 里的“黑洞”或“垃圾桶”。
- **`2>/dev/null` 的含义：** 把所有的报错信息通通扔进垃圾桶，不让它们显示在屏幕上。这样能保证最终输出的结果非常干净，只有成功计算出大小的目录。

## 3. 智能排序：`| sort -rh`

`sort` 命令用来对前面的扫描结果进行排序。

- **`-r` (Reverse)：** 默认排序是从小到大，加上 `-r` 代表**逆序排序（从大到小）**。这样最大的文件夹就会排在最前面。

- **`-h` (Numeric-sort for human readable)：** 配合前面 `du -h` 产生的 K、M、G 单位进行**智能数字排序**。

  如果不加 `-h`，只用普通的 `-n` 排序，Linux 会认为 `5M` 比 `2G` 还要大（因为 5 比 2 大）。加了 `-h` 之后，Linux 就能聪明地识别出 **G > M > K**，把 26G 稳稳地排在最上面。

## 4. 截取前 10 行：`| head -n 10`

`head` 命令用来查看文件的开头部分。

- **`-n 10`：** 意思是**只显示前 10 行**。

  因为一个目录下可能有很多碎小文件夹（比如几 KB 的空文件夹），我们根本不关心它们。用 `head -n 10` 斩断输出，只把最肥的、排名前 10 的大户留下来。

## 🎯 总结

用一句大白话来翻译整条命令就是：

> **“帮我查一下当前目录下每个一二级子文件夹的总大小，别报怨权限不够，把结果按从大到小排好序，我只看前 10 个最大的。”**

你运行它之后，它会吐出清爽的 10 行结果，第一行就是吃掉你 26G 空间的罪魁祸首。



## 2.2 清理磁盘空间占用，调试过程

~~~
[root@racknerd-8454f32 mydata]# find /var/lib/docker/containers/ -name "*-json.log" -exec du -sh {} + | sort -rh | head -n 10
8.0K    /var/lib/docker/containers/a016f7f637c86c2879e44dd135a8bf9bd9fc37c5304966d5aef7829c5e6ce7ab/a016f7f637c86c2879e44dd135a8bf9bd9fc37c5304966d5aef7829c5e6ce7ab-json.log
[root@racknerd-8454f32 mydata]# find /var/lib/docker/containers/ -name "*-json.log" -exec sh -c 'cat /dev/null > "{}"' \;
[root@racknerd-8454f32 mydata]# docker system df
TYPE            TOTAL     ACTIVE    SIZE      RECLAIMABLE
Images          1         1         192MB     0B (0%)
Containers      1         1         2B        0B (0%)
Local Volumes   0         0         0B        0B
Build Cache     0         0         0B        0B
[root@racknerd-8454f32 mydata]# docker volume rm $(docker volume ls -qf dangling=true)
"docker volume rm" requires at least 1 argument.
See 'docker volume rm --help'.

Usage:  docker volume rm [OPTIONS] VOLUME [VOLUME...]

Remove one or more volumes
[root@racknerd-8454f32 mydata]# du -ahx / | sort -rh | head -n 20
^C

[root@racknerd-8454f32 mydata]# du -h --max-depth=1 / 2>/dev/null | sort -rh | head -n 15
35G     /
26G     /var
4.0G    /usr
3.4G    /mydata
1.1G    /opt
321M    /boot
130M    /etc
117M    /run
72M     /root
268K    /home
20K     /tmp
16K     /path
16K     /lost+found
4.0K    /srv
4.0K    /mnt
[root@racknerd-8454f32 mydata]# du -h --max-depth=1 /var 2>/dev/null | sort -rh | head -n 10
26G     /var
24G     /var/lib
1.1G    /var/cache
376M    /var/log
88K     /var/spool
20K     /var/tmp
12K     /var/www
12K     /var/kerberos
12K     /var/db
8.0K    /var/empty
[root@racknerd-8454f32 mydata]# du -h --max-depth=1 /var/log 2>/dev/null | sort -rh | head -n 15
376M    /var/log
257M    /var/log/mongodb
37M     /var/log/audit
2.8M    /var/log/letsencrypt
144K    /var/log/nginx
20K     /var/log/php-fpm
16K     /var/log/tuned
4.0K    /var/log/sssd
4.0K    /var/log/private
4.0K    /var/log/httpd
4.0K    /var/log/chrony
4.0K    /var/log/anaconda
[root@racknerd-8454f32 mydata]# find / -type f -size +1G -exec du -h {} + 2>/dev/null | sort -rh | head -n 10
0       /proc/kcore
[root@racknerd-8454f32 mydata]# cd /var
[root@racknerd-8454f32 var]# ll
total 72
drwxr-xr-x.  2 root root 4096 Oct  9  2021 adm
drwxr-xr-x. 10 root root 4096 Sep 24  2025 cache
drwxr-xr-x.  3 root root 4096 Jan  5  2024 db
drwxr-xr-x.  3 root root 4096 Jan  5  2024 empty
drwxr-xr-x.  2 root root 4096 Oct  9  2021 ftp
drwxr-xr-x.  2 root root 4096 Oct  9  2021 games
drwxr-xr-x.  2 root root 4096 Oct  9  2021 gopher
drwxr-xr-x.  3 root root 4096 Nov  4  2024 kerberos
drwxr-xr-x. 37 root root 4096 Sep 24  2025 lib
drwxr-xr-x.  2 root root 4096 Oct  9  2021 local
lrwxrwxrwx.  1 root root   11 Jan  5  2024 lock -> ../run/lock
drwxr-xr-x. 13 root root 4096 Jun  7 03:21 log
lrwxrwxrwx.  1 root root   10 Oct  9  2021 mail -> spool/mail
drwxr-xr-x.  2 root root 4096 Oct  9  2021 nis
drwxr-xr-x.  2 root root 4096 Oct  9  2021 opt
drwxr-xr-x.  2 root root 4096 Oct  9  2021 preserve
lrwxrwxrwx.  1 root root    6 Jan  5  2024 run -> ../run
drwxr-xr-x.  7 root root 4096 Jan  5  2024 spool
drwxrwxrwt.  4 root root 4096 May 22 13:41 tmp
drwxr-xr-x   4 root root 4096 Sep 24  2025 www
drwxr-xr-x.  2 root root 4096 Oct  9  2021 yp
[root@racknerd-8454f32 var]# 
[root@racknerd-8454f32 var]# du -h --max-depth=1 ./ 2>/dev/null | sort -rh | head -n 10
26G     ./
24G     ./lib
1.1G    ./cache
376M    ./log
88K     ./spool
20K     ./tmp
12K     ./www
12K     ./kerberos
12K     ./db
8.0K    ./empty
[root@racknerd-8454f32 var]# 
[root@racknerd-8454f32 var]# cd ./lib/
[root@racknerd-8454f32 lib]# ls
alternatives  dbus        fail2ban   letsencrypt     os-prober  private    sss
authselect    dhclient    games      logrotate       php        rpm        systemd
chrony        dnf         httpd      misc            plymouth   rpm-state  tpm
containerd    docker      hysteria   mongo           polkit-1   rsyslog    tuned
dav           docker.old  initramfs  NetworkManager  portables  selinux    unbound
[root@racknerd-8454f32 lib]# du -h --max-depth=1 ./ 2>/dev/null | sort -rh | head -n 10
24G     ./
23G     ./docker.old
405M    ./mongo
404M    ./docker
195M    ./rpm
30M     ./selinux
4.4M    ./dnf
1.3M    ./sss
720K    ./containerd
156K    ./systemd
[root@racknerd-8454f32 lib]# cd docker.old/
[root@racknerd-8454f32 docker.old]# ls
buildkit  containers  engine-id  image  network  overlay2  plugins  runtimes  swarm  tmp  volumes
[root@racknerd-8454f32 docker.old]# rm -rf /var/lib/docker.old
~~~

