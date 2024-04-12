# 1 内存（RAM）和磁盘（如HDD或SSD）的读写速度差异

内存（RAM）和磁盘（如HDD或SSD）的读写速度差异很大，这是因为它们基于完全不同的技术和物理原理。内存的访问速度远快于磁盘。

- **内存（RAM）**：数据是直接在CPU可以快速访问的内存芯片上进行读写的。内存访问的延迟通常在几十纳秒（ns）范围内，数据传输速率可以达到每秒几十到几百GB。

- **硬盘驱动器（HDD）**：基于旋转磁盘的存储设备，读写数据需要移动磁头到正确的位置，这个过程相对较慢。HDD的平均访问延迟通常在几毫秒（ms）范围，数据传输速率一般在每秒几十到几百MB。

- **固态硬盘（SSD）**：虽然SSD是基于闪存的，速度比HDD快很多，但通常仍然比RAM慢。SSD的访问延迟通常在几十到几百微秒（μs）范围，数据传输速率可以达到每秒几百MB到几GB。

大体上，内存的速度比HDD快约10,000倍到100,000倍，比SSD快约100倍到1000倍。这些数字只是粗略估计，实际性能会根据具体硬件和操作的不同而有所变化。

因此，当你比较像Redis（内存数据库）和MySQL（通常存储在HDD或SSD上）这样的系统时，Redis在数据访问速度上有显著优势，这是它被广泛用于需要高速读写的场景（如缓存）的原因之一。

# 2 Linux网络配置文件





~~~
[root@hspEdu100 ~]# cat /etc/sysconfig/network-scripts/ifcfg-ens33
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
#IPADDR=192.168.200.130
#网关
#GATEWAY=192.168.200.2
#域名解析器
#DNS1=192.168.200.2

#IP 地址
IPADDR="192.168.198.135"
#网关
GATEWAY="192.168.198.2"
#域名解析器
DNS1="192.168.198.2"
#域名解析器，只写下面这个dns 解析失败
DNS2="8.8.8.8"

#子网掩码，不写默认就是255.255.255.0
NETMASK="255.255.255.0"

# 你希望 NetworkManager 接管并应用 ifcfg-ens33 文件中的配置
NM_CONTROLLED="yes"

~~~







# 3 安装Redis的过程以及启动redis的命令



~~~
#启动redis的命令
[root@hspEdu100 redis-6.2.6]# /usr/local/bin/redis-server /etc/redis.conf 
~~~





~~~
#以下是查看端口和进程号的方式 查看是否启动成功
ps -aux | grep redis

netstat -anp | grep redis

netstat -anp | more
~~~







简略的redis安装过程如下：

~~~
#安装C语言环境gcc
[root@hspEdu100 ~]# yum install gcc


#编译redis
[root@hspEdu100 redis-6.2.6]# make


#安装redis
[root@hspEdu100 redis-6.2.6]# make install



[root@hspEdu100 redis-6.2.6]# cp redis.conf /etc/redis.conf
#修改配置信息 修改/etc/redis.con 后台启动 设置 daemonize no 改成 yes,并保存退出。 即设置为守护进程，运行完之后退出控制台，使其在后台运行，不影响其他指令的执行
[root@hspEdu100 redis-6.2.6]# vi /etc/redis.conf 
#启动redis的命令
[root@hspEdu100 redis-6.2.6]# /usr/local/bin/redis-server /etc/redis.conf 


#查看redis是否启动，是否在6379端口监听
[root@hspEdu100 redis-6.2.6]# ps -aux | grep redis
root      17163  0.0  0.3 162412  6684 ?        Ssl  20:41   0:00 /usr/local/bin/redis-server 127.0.0.1:6379
root      17314  0.0  0.0 112728   988 pts/0    S+   20:57   0:00 grep --color=auto redis


#查看redis是否启动，是否在6379端口监听
[root@hspEdu100 redis-6.2.6]# netstat -anp | grep redis
tcp        0      0 127.0.0.1:6379          0.0.0.0:*               LISTEN      17163/redis-server  
tcp6       0      0 ::1:6379                :::*                    LISTEN      17163/redis-server  

#查看redis是否启动，是否在6379端口监听
[root@hspEdu100 redis-6.2.6]# netstat -anp | more
Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name    
tcp6       0      0 ::1:6379                :::*                    LISTEN      17163/redis-server  



~~~



详细的redis安装过程如下：

~~~

#安装C语言环境gcc
[root@hspEdu100 ~]# yum install gcc
已加载插件：fastestmirror, langpacks
Loading mirror speeds from cached hostfile
 * base: mirror.aktkn.sg
 * extras: mirror.aktkn.sg
 * updates: mirror.aktkn.sg
软件包 gcc-4.8.5-44.el7.x86_64 已安装并且是最新版本
无须任何处理
[root@hspEdu100 ~]# gcc --version
gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-44)
Copyright © 2015 Free Software Foundation, Inc.
本程序是自由软件；请参看源代码的版权声明。本软件没有任何担保；
包括没有适销性和某一专用目的下的适用性担保。
[root@hspEdu100 ~]# cd /opt
[root@hspEdu100 opt]# ls
firefox-60.2.2-1.el7.centos.x86_64.rpm  idea  jdk  mysql  nginx-1.20.2.tar.gz  rh  tomcat  VMwareTools-10.3.10-1395
[root@hspEdu100 opt]# ls
firefox-60.2.2-1.el7.centos.x86_64.rpm  idea  jdk  mysql  nginx-1.20.2.tar.gz  redis-6.2.6.tar.gz  rh  tomcat  VMwa
[root@hspEdu100 opt]# ll
总用量 152364
-rw-r--r--. 1 root root 95103108 10月  9 2018 firefox-60.2.2-1.el7.centos.x86_64.rpm
drwxr-xr-x. 3 root root     4096 1月  28 03:25 idea
drwxr-xr-x. 2 root root     4096 1月  28 02:35 jdk
drwxr-xr-x. 2 root root     4096 1月  28 03:52 mysql
-rw-r--r--. 1 root root  1062124 2月   6 02:45 nginx-1.20.2.tar.gz
-rw-r--r--. 1 root root  2476542 4月   7 20:20 redis-6.2.6.tar.gz
drwxr-xr-x. 2 root root     4096 10月 31 2018 rh
drwxr-xr-x. 4 root root     4096 2月   8 05:57 tomcat
-rw-r--r--. 1 root root 56431201 6月  13 2019 VMwareTools-10.3.10-13959562.tar.gz
drwxr-xr-x. 9 root root     4096 6月  13 2019 vmware-tools-distrib
-rw-r--r--. 1 root root   911021 1月  14 17:09 浴衣.jpg
[root@hspEdu100 opt]# tar -zxvf redis-6.2.6.tar.gz 



[root@hspEdu100 opt]# ls
firefox-60.2.2-1.el7.centos.x86_64.rpm  nginx-1.20.2.tar.gz  tomcat
idea                                    redis-6.2.6          VMwareTools-10.3.10-13959562.tar.gz
jdk                                     redis-6.2.6.tar.gz   vmware-tools-distrib
mysql                                   rh                   浴衣.jpg
[root@hspEdu100 opt]# cd redis-6.2.6/
[root@hspEdu100 redis-6.2.6]# ls
00-RELEASENOTES  CONTRIBUTING  INSTALL    README.md   runtest-cluster    sentinel.conf  TLS.md
BUGS             COPYING       Makefile   redis.conf  runtest-moduleapi  src            utils
CONDUCT          deps          MANIFESTO  runtest     runtest-sentinel   tests

#编译redis
[root@hspEdu100 redis-6.2.6]# make



[root@hspEdu100 bin]# pwd
/usr/local/bin
[root@hspEdu100 bin]# cd /opt
[root@hspEdu100 opt]# ls
firefox-60.2.2-1.el7.centos.x86_64.rpm  nginx-1.20.2.tar.gz  tomcat
idea                                    redis-6.2.6          VMwareTools-10.3.10-13959562.tar.gz
jdk                                     redis-6.2.6.tar.gz   vmware-tools-distrib
mysql                                   rh                   浴衣.jpg
[root@hspEdu100 opt]# cd redis-6.2.6/
[root@hspEdu100 redis-6.2.6]# ls
00-RELEASENOTES  CONTRIBUTING  INSTALL    README.md   runtest-cluster    sentinel.conf  TLS.md
BUGS             COPYING       Makefile   redis.conf  runtest-moduleapi  src            utils
CONDUCT          deps          MANIFESTO  runtest     runtest-sentinel   tests

#安装redis
[root@hspEdu100 redis-6.2.6]# make install
cd src && make install
make[1]: 进入目录“/opt/redis-6.2.6/src”
    CC Makefile.dep
make[1]: 离开目录“/opt/redis-6.2.6/src”
make[1]: 进入目录“/opt/redis-6.2.6/src”

Hint: It's a good idea to run 'make test' ;)

    INSTALL redis-server
    INSTALL redis-benchmark
    INSTALL redis-cli
make[1]: 离开目录“/opt/redis-6.2.6/src”
[root@hspEdu100 redis-6.2.6]# cd /usr/local/bin/
[root@hspEdu100 bin]# ls
genhash  redis-benchmark  redis-check-aof  redis-check-rdb  redis-cli  redis-sentinel  redis-server



[root@hspEdu100 bin]# cd /opt/redis-6.2.6/
[root@hspEdu100 redis-6.2.6]# ls
00-RELEASENOTES  CONTRIBUTING  INSTALL    README.md   runtest-cluster    sentinel.conf  TLS.md
BUGS             COPYING       Makefile   redis.conf  runtest-moduleapi  src            utils
CONDUCT          deps          MANIFESTO  runtest     runtest-sentinel   tests
[root@hspEdu100 redis-6.2.6]# cp redis.conf /etc/redis.conf
[root@hspEdu100 redis-6.2.6]# vi /etc/redis.conf 
[root@hspEdu100 redis-6.2.6]# /usr/local/bin/redis-server /etc/redis.conf 



[root@hspEdu100 redis-6.2.6]# netstat -anp | grep redis
tcp        0      0 127.0.0.1:6379          0.0.0.0:*               LISTEN      17163/redis-server  
tcp6       0      0 ::1:6379                :::*                    LISTEN      17163/redis-server  


[root@hspEdu100 redis-6.2.6]# netstat -anp | more
Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name    
tcp        0      0 127.0.0.1:6379          0.0.0.0:*               LISTEN      17163/redis-server  
tcp        0      0 0.0.0.0:111             0.0.0.0:*               LISTEN      1/systemd           
tcp        0      0 0.0.0.0:6000            0.0.0.0:*               LISTEN      7448/X              
tcp        0      0 192.168.122.1:53        0.0.0.0:*               LISTEN      7979/dnsmasq        
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      7057/sshd           
tcp        0      0 127.0.0.1:631           0.0.0.0:*               LISTEN      7058/cupsd          
tcp        0      0 127.0.0.1:6010          0.0.0.0:*               LISTEN      11541/sshd: root@pt 
tcp        0     36 192.168.198.135:22      192.168.198.1:59047     ESTABLISHED 11541/sshd: root@pt 
tcp        0      0 192.168.198.135:22      192.168.198.1:54485     ESTABLISHED 12539/sshd: root@no 
tcp6       0      0 :::3306                 :::*                    LISTEN      7816/mysqld         
tcp6       0      0 ::1:6379                :::*                    LISTEN      17163/redis-server  
~~~





# 4 Redis使用 【redis-cli】



#### 1 连接到 redis-server的两种方式

~~~
[root@hspEdu100 redis-6.2.6]# cd /usr/local/bin/
[root@hspEdu100 bin]# ls
genhash  redis-benchmark  redis-check-aof  redis-check-rdb  redis-cli  redis-sentinel  redis-server
#连接和退出redis的方式1 不指定端口，即使用默认的6379端口进行连接
[root@hspEdu100 bin]# redis-cli
127.0.0.1:6379> ping
PONG
127.0.0.1:6379> quit
[root@hspEdu100 bin]# 

#连接和退出redis的方式2 指定端口进行连接(适合修改过默认端口的情况，修改过端口的就必须指定端口进行连接)
#否则连接失败，因为如果不指定端口，就会使用默认的6379端口进行连接
[root@hspEdu100 bin]# redis-cli -p 6379
127.0.0.1:6379> ping
PONG
127.0.0.1:6379> quit
[root@hspEdu100 bin]# 
~~~



#### **2 环境变量中包含 /usr/local/bin 目录 因此在任何目录下输入`redis-server /etc/redis.conf`都可以启动成功**

~~~
#查看环境变量
[root@hspEdu100 bin]# env
PATH=/usr/local/java/jdk1.8.0_261/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin
~~~



#### 3 关闭redis-server 服务的指令shutdown的三种使用方式：

**1 不指定端口 默认关闭的就是6379端口的 redis-server  `redis-cli shutdown`**

~~~

[root@hspEdu100 bin]# redis-cli shutdown
[root@hspEdu100 bin]# ps -aux | grep redis
root      17623  0.0  0.0 112724   988 pts/0    S+   21:28   0:00 grep --color=auto redis
~~~



**2 指定端口关闭 6379端口的 redis-server `redis-cli -p 6379 shutdown`**

~~~
[root@hspEdu100 bin]# redis-server /etc/redis.conf 
[root@hspEdu100 bin]# ps -aux | grep redis
root      17701  0.0  0.3 162412  6628 ?        Ssl  21:34   0:00 redis-server 127.0.0.1:6379
root      17707  0.0  0.0 112724   984 pts/0    S+   21:34   0:00 grep --color=auto redis
[root@hspEdu100 bin]# redis-cli -p 6379 shutdown
[root@hspEdu100 bin]# ps -aux | grep redis
root      17718  0.0  0.0 112724   988 pts/0    S+   21:35   0:00 grep --color=auto redis
~~~



**3 使用`redis-cli`指令进入redis-server内部关闭redis-server `shutdown`**

~~~
[root@hspEdu100 bin]# redis-server /etc/redis.conf 
[root@hspEdu100 bin]# ps -aux | grep redis
root      17663  0.0  0.3 162412  6624 ?        Ssl  21:32   0:00 redis-server 127.0.0.1:6379
root      17669  0.0  0.0 112724   984 pts/0    S+   21:32   0:00 grep --color=auto redis
[root@hspEdu100 bin]# redis-cli
127.0.0.1:6379> shutdown
not connected> quit
[root@hspEdu100 bin]# ps -aux | grep redis
root      17681  0.0  0.0 112724   988 pts/0    S+   21:32   0:00 grep --color=auto redis
~~~



#### 4 修改端口的方式 修改/etc/redis.conf 文件的 port 即可



~~~
[root@hspEdu100 bin]# vi /etc/redis.conf 

# Accept connections on the specified port, default is 6379 (IANA #815344).
# If port 0 is specified Redis will not listen on a TCP socket.
port 6379 #即修改这里，使用端口号6379进行全局搜索字段即可 即命令行模式输入`/6379`
~~~





# 5 quit/exit 退出redis客户端 redis数据还在，shutdown结束redis-server 数据也还在

当你使用`SHUTDOWN`命令结束Redis服务器时，数据依然会被保存到磁盘上。`SHUTDOWN`命令会执行以下操作：

1. **停止所有客户端连接**：断开与所有客户端的连接。
2. **执行数据持久化操作**：如果Redis配置了持久化（RDB、AOF或两者都有），`SHUTDOWN`命令会触发最终的数据持久化过程。这意味着，Redis会将内存中的数据保存到磁盘上的数据文件中。
   - **RDB**（Redis数据库文件）：在`SHUTDOWN`时，会创建一个内存数据快照，并将其保存到磁盘上的`.rdb`文件中。
   - **AOF**（追加文件）：如果启用了AOF持久化，Redis会确保AOF文件完整地反映了所有写操作，然后才关闭服务器。

3. **退出Redis服务**：完成所有必要的持久化操作后，Redis服务器将安全地退出。

因此，当你重新启动Redis服务器时，它可以从持久化文件（RDB或AOF）中重新加载数据，恢复到`SHUTDOWN`命令执行时的状态。这保证了即使在服务器关闭后，你的数据也不会丢失。



~~~
127.0.0.1:6379> set k1 king1
OK
127.0.0.1:6379> get k1
"king1"
127.0.0.1:6379> quit
[root@hspEdu100 bin]# redis-cli
127.0.0.1:6379> keys *
1) "k1"
127.0.0.1:6379> exit
[root@hspEdu100 bin]# redis-cli
127.0.0.1:6379> shutdown
not connected> quit
[root@hspEdu100 bin]# ps -aux | grep redis
root      29605  0.0  0.0 112724   984 pts/0    S+   19:01   0:00 grep --color=auto redis
[root@hspEdu100 bin]# redis-server /etc/redis.conf 
[root@hspEdu100 bin]# ps -aux | grep redis
root      29607  0.0  0.1 162412  2688 ?        Ssl  19:01   0:00 redis-server 127.0.0.1:6379
root      29613  0.0  0.0 112724   988 pts/0    S+   19:01   0:00 grep --color=auto redis
[root@hspEdu100 bin]# redis-cli
127.0.0.1:6379> keys *
1) "k1"
127.0.0.1:6379> 
~~~





# 6 Redis命令 

`TTL`是"Time to Live"的缩写，中文意思是“生存时间”。



## String命令 

| 命令        | 缩写全称                    | 中文意思                                                   |
| ----------- | --------------------------- | ---------------------------------------------------------- |
| SET         | Set                         | 设置指定 key 的值                                          |
| GET         | Get                         | 获取指定 key 的值                                          |
| GETRANGE    | Get Range                   | 返回 key 中字符串值的子字符                                |
| GETSET      | Get Set                     | 将给定 key 的值设为 value ，并返回 key 的旧值              |
| GETBIT      | Get Bit                     | 对 key 所储存的字符串值，获取指定偏移量上的位              |
| MGET        | Multiple Get                | 获取所有(一个或多个)给定 key 的值                          |
| SETBIT      | Set Bit                     | 对 key 所储存的字符串值，设置或清除指定偏移量上的位        |
| SETEX       | Set with EXpiration         | 设置 key 的值为 value 同时将过期时间设为 seconds           |
| SETNX       | Set if Not eXists           | 只有在 key 不存在时设置 key 的值                           |
| SETRANGE    | Set RANGE                   | 从偏移量 offset 开始用 value 覆写给定 key 所储存的字符串值 |
| STRLEN      | STRing LENgth               | 返回 key 所储存的字符串值的长度                            |
| MSET        | Multiple SET                | 同时设置一个或多个 key-value 对                            |
| MSETNX      | Multiple SET if Not eXists  | 同时设置一个或多个 key-value 对，仅当所有 key 都不存在时   |
| PSETEX      | Precise SET with EXpiration | 以毫秒为单位设置 key 的生存时间                            |
| INCR        | INCrement                   | 将 key 中储存的数字值增一                                  |
| INCRBY      | INCrement BY                | 将 key 所储存的值加上给定的增量值                          |
| INCRBYFLOAT | INCrement BY FLOAT          | 将 key 所储存的值加上给定的浮点增量值                      |
| DECR        | DECrement                   | 将 key 中储存的数字值减一                                  |
| DECRBY      | DECrement BY                | 将 key 所储存的值减去给定的减量值                          |
| APPEND      | APPEND                      | 将 value 追加到 key 原来的值的末尾                         |



这个表格包含了缩写中含有的单词本身，它们的简单中文解释以及音标。

| 缩写单词   | 中文解释       | 音标            |
| ---------- | -------------- | --------------- |
| Set        | 设置，安装     | /sɛt/           |
| Get        | 获取，得到     | /ɡɛt/           |
| Range      | 范围，区间     | /reɪndʒ/        |
| Bit        | 位，比特       | /bɪt/           |
| Multiple   | 多个的，多重的 | /ˈmʌltɪpl/      |
| Expiration | 过期，到期     | /ˌɛkspəˈreɪʃən/ |
| Exists     | 存在           | /ɪɡˈzɪsts/      |
| Increment  | 增加，增量     | /ˈɪnkrəmənt/    |
| Decrement  | 减少，减量     | /ˈdɛkrɪmənt/    |
| Append     | 追加，附加     | /əˈpɛnd/        |
| Precise    | 精确的，准确的 | /prɪˈsaɪs/      |
| Float      | 浮动的，浮点   | /floʊt/         |



## config 命令



~~~
# 获取配置文件中的信息
config get requirepass

config get loglevel

config get logfile

# 临时设置配置文件中的信息 退出客户端在重新登录才生效！
config set requirepass hspedu


~~~





![image-20240410192822247](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240410192822247.png)













# 7 none 不存在



~~~redis
127.0.0.1:6379> type k1
string
127.0.0.1:6379> type k10
none
~~~



# 8 在Redis的命令行界面（CLI）中，默认是没有代码补全功能的。这是因为Redis CLI主要设计为一个简单的命令行工具，用于快速测试和操作数据，而没有集成更高级的特性，如代码补全。

然而，有几种方法可以获得更好的Redis操作体验，包括代码补全：

1. **使用第三方工具：** 存在一些第三方的Redis客户端和工具，如Redis Desktop Manager, Redsmin, 或RDM等，这些工具通常提供了一个更丰富的用户界面，包括代码补全、数据可视化等高级功能。

2. **使用IDE插件：** 一些集成开发环境（IDE）提供了Redis插件，这些插件可能包含代码补全、语法高亮等功能。例如，Visual Studio Code（VSCode）有多个Redis插件可供选择。

3. **使用高级终端：** 某些高级终端（如iTerm2 for macOS）或Shell环境（如Zsh或Fish）可以配置以支持自动补全功能，包括对Redis命令的补全。这通常需要一定程度的自定义配置。

4. **编写自定义脚本：** 如果你倾向于使用命令行工具并且熟悉Shell脚本编程，你可以编写自定义脚本来为Redis CLI添加代码补全功能。这可能包括设置别名、编写函数来包装`redis-cli`命令，或者利用现有的Shell代码补全框架。

虽然Redis自带的CLI在代码补全方面有限，但通过上述方法，你可以获得更丰富的开发和操作体验。选择哪种方法取决于你的个人喜好、操作系统和工作流程。





# 9 Redis只有使用shutdown关闭后再重启才会生效，如果不使用shutdown指令，而是直接使用redis-server指令重启redis,不会报错，但其实这时还是上次启动的redis，实际上没有重启



Redis只有使用`shutdown`关闭后再重启修改的配置文件配置才会生效，如果不使用shutdown指令，而是直接使用redis-server指令重启redis,不会报错，其实重启失败了，其实这时还是上次启动的redis，实际上没有重启

~~~
redis-cli

redis-server /etc/redis.conf

redis-cli shutdown

redis-server /etc/redis.conf

~~~







# 10 redis备份文件 dump.rdb 及备份文件位置说明

修改 `/etc/redis.conf`

~~~
# 默认情况下，在使用 redis-server /etc/redis.conf 指令启动redis的目录
# ，在使用shutdown指令后，生成dump.rdb文件对redis数据进行自动备份
# dir ./

# 修改为不论在哪个目录启动，关闭数据库即shutdown时，都到指定目录 /root/ 备份redis数据
dir /root/

~~~



~~~
#手动备份/生成/更新 dump.rdb文件的指令
#阻塞的
save 
#非阻塞的
bgsave
~~~





# 11 redis.conf 中的save属性，如果设置为save "" ，在shutdown后，还会触发rdb的自动持久化吗？会

在 Redis 的配置文件 `redis.conf` 中，`save` 指令用于配置自动快照（snapshotting）的条件，即在多少秒和多少次键值对变更后自动保存数据到磁盘（RDB文件）。这种机制是 Redis 进行数据持久化的一种方式，被称为 RDB 持久化。

如果你在 `redis.conf` 中设置 `save` 为：

```plaintext
save ""
```

这意味着禁用了基于时间和变更次数的自动快照。具体到 Redis 关闭时的行为，这里需要区分两种情况：

1. **正常关闭（如执行 `SHUTDOWN` 命令）：** 在这种情况下，即使 `save` 配置为空（即所有的自动快照条件都被移除），Redis 依然会执行一次 RDB 快照。这是因为 `SHUTDOWN` 命令默认会触发保存操作，除非使用 `SHUTDOWN NOSAVE` 明确指定不保存。

2. **异常终止：** 如果 Redis 因为崩溃或其他非正常方式终止，且 `save` 参数被设置为空，那么不会有自动的快照文件生成，这将导致数据丢失。

因此，如果你的配置中 `save` 被设置为 `""`，在正常使用 `SHUTDOWN` 命令关闭 Redis 时仍然会有 RDB 文件生成，保证了数据的持久化。但如果要避免任何自动保存，可以使用 `SHUTDOWN NOSAVE` 命令。如果担心数据丢失情况，建议定期使用 `BGSAVE` 命令手动触发 RDB 快照，或者考虑启用 AOF（Append Only File）持久化策略。

## save "" 只禁用了基于时间和变更次数的自动快照？对shutdown的自动保存机制没有影响？

是的，你的理解是正确的。在 Redis 配置中将 `save` 设置为 `save ""` 确实仅仅禁用了基于时间间隔和键值对变更次数的自动快照机制。这意味着在正常运行时，Redis 不会因为达到某些操作阈值而自动进行 RDB 快照。

然而，这种设置对 `SHUTDOWN` 命令时的行为没有影响。当使用 `SHUTDOWN` 命令（不带任何参数）正常关闭 Redis 服务时，无论 `save` 配置如何，Redis 默认都会进行一次 RDB 快照以保存当前的全部数据到磁盘。这是一个设计上的选择，确保了即使在禁用自动快照的情况下，正常关闭数据库也不会导致数据丢失。

要避免在关闭时保存数据，可以使用带 `NOSAVE` 参数的 `SHUTDOWN` 命令，如：

```plaintext
SHUTDOWN NOSAVE
```

这条命令会使 Redis 服务器关闭而不进行任何形式的数据持久化。

因此，`save ""` 的设置确实只影响了自动快照的触发条件，而非关闭时的持久化行为。如果需要控制关闭时的持久化，应使用相应的 `SHUTDOWN` 命令参数来明确指定。







# 12 修复Redis数据，AOF持久化的磁盘文件

~~~
#修复Redis AOF文件的指令如下
redis-check-aof --fix /root/appendonly.aof
~~~



**redis如果RDB和AOF同时开启，那么默认是从AOF恢复数据的，如果AOF文件损坏了，redis-server启动不起来。需要对AOF文件进行修复，再从AOF文件恢复数据到内存。**



~~~
127.0.0.1:6379> shutdown
not connected> quit
[root@hspEdu100 ~]# ps -aux | grep redis
root      81411  0.0  0.0 112724   988 pts/0    S+   15:20   0:00 grep --color=auto redis
[root@hspEdu100 ~]# redis-server /etc/redis.conf 
[root@hspEdu100 ~]# ps -aux | grep redis
root      81419  0.0  0.0 112724   988 pts/0    S+   15:21   0:00 grep --color=auto redis
[root@hspEdu100 ~]# redis-cli
Could not connect to Redis at 127.0.0.1:6379: Connection refused
not connected> quit
[root@hspEdu100 ~]# 
~~~





~~~
[root@hspEdu100 ~]# redis-check-aof --fix /root/appendonly.aof
0x              9c: Expected prefix '*', got: 'h'
AOF analyzed: size=166, ok_up_to=156, ok_up_to_line=39, diff=10
This will shrink the AOF from 166 bytes, with 10 bytes, to 156 bytes
Continue? [y/N]: y
Successfully truncated AOF
~~~





# 13 Redis 同步频率设置/写回策略分为三种：

- **appendfsync always**（谨慎使用）：

  每条 Redis 操作命令都会写入磁盘，最多丢失一条数据

  始终同步，每次 Redis 的写入都会立刻记入磁盘/日志；性能较差但数据完整性比较好

- **appendfsync  everysec**（默认）：

  每秒同步，每秒记入磁盘/日志一次，如果宕机，本秒的数据可能丢失。

- **appendfsync no**（不推荐）：

  不主动进行同步，把同步时机交给操作系统,由操作系统决定何时写入磁盘，Linux 默认 30s 写入一次数据至磁盘





# 14 如何理解AOF的数据一致性要强于RDB?

redis如果RDB和AOF同时开启，那么默认是从AOF恢复数据的 (AOF的数据一致性要强于RDB,默认情况下从AOF恢复数据，如果宕机的情况下，丢失数据最多就是1s内的数据，**AOF数据一致性更强**一些，因此作者设计时，可能是考虑的这个)

在 Redis 中，数据持久化主要有两种方式：RDB (Redis Database) 和 AOF (Append Only File)。理解 AOF 持久化提供的数据一致性优势相对于 RDB 持久化，需要对两者的工作原理有一个清晰的了解。

### RDB 持久化

**工作原理：**

- RDB 持久化通过创建数据集的内存快照来工作，在预定的时间间隔内（根据配置的规则如 `save 30 5`，即30秒内至少5个键被修改）执行。
- 当快照发生时，Redis 会 fork 出一个子进程，子进程会将当前内存中的数据集写入到一个临时 RDB 文件中。写入完成后，这个临时文件会替换掉旧的 RDB 文件。

**数据一致性：**

- RDB 的缺点在于数据恢复只能回到最后一次快照的时间点。这意味着如果 Redis 服务器在两次快照之间失败了，那么自最后一次快照以来的所有数据变更都会丢失。
- 因此，RDB 更适用于对数据一致性要求不是非常高的场合，或者可以接受分钟级数据丢失的场景。

### AOF 持久化

**工作原理：**

- AOF 持久化记录每个写操作命令，并追加到 AOF 文件的末尾。这意味着每一个对数据库做出的更改都会即时被记录。
- 默认情况下，AOF 文件的更新策略为每秒同步一次，但可以配置为更频繁（甚至每次操作后）或者从不同步（这会增加数据丢失的风险）。

**数据一致性：**

- AOF 提供了比 RDB 更高的数据一致性，因为所有的操作都被记录下来，可以重新执行这些操作来恢复数据。在配置为每次操作后同步时，AOF 可以实现零数据丢失。
- AOF 文件通常会比 RDB 文件大，且恢复速度可能比从 RDB 恢复要慢，但提供了更好的数据安全保障。

### 结论

**AOF 持久化方式的数据一致性之所以强于 RDB，主要是因为 AOF 会记录每一条写命令并根据配置实时同步，这减少了数据丢失的风险。**相比之下，RDB 通过周期性快照来持久化数据，如果 Redis 在两次快照之间发生故障，那么这段时间内的所有数据更改都将丢失。

因此，如果业务场景对数据的实时性和一致性要求极高，推荐使用 AOF 持久化；如果是对性能要求更高，且可以容忍短时间内的数据丢失，可以考虑使用 RDB 持久化，或者两者结合使用以达到最优的效果。



# 15 悲观锁和乐观锁

 悲观锁和乐观锁并不是特定于 Redis 或 MySQL 的概念，而是广泛应用于多种数据库和数据存储系统中的并发控制技术。这两种锁的机制各有特点，用于处理数据在多用户环境下的安全性和一致性问题。让我们详细了解它们在不同系统中的应用：

### 悲观锁

**概念**：悲观锁是一种保守的锁策略，假设最坏的情况，即在数据处理过程中，总是假设其他线程会尝试修改同样的数据。因此，悲观锁在数据处理前就会先锁定数据，直到事务完成才释放锁。这种策略适用于写操作多的环境，可以避免数据修改冲突。

**应用**：
- **MySQL**：在传统的关系数据库管理系统（RDBMS）中，如 MySQL，悲观锁通常通过 `SELECT FOR UPDATE` 语句实现，该语句在读取一条记录时，会对其加上排它锁（Exclusive Lock），直到事务结束。
- **Redis**：Redis 并不内置传统的悲观锁支持，但可以通过其他机制实现类似功能，例如使用 `SETNX` 命令（set if not exists）模拟锁的行为。

### 乐观锁

**概念**：乐观锁是一种宽松的锁策略，基于冲突在大多数情况下不会发生的假设。它允许多个事务几乎同时进行，只在事务提交时检查是否有冲突。如果发现冲突，事务可以选择重试或者放弃。乐观锁通常使用数据版本（version）控制或时间戳来实现。

**应用**：
- **MySQL**：乐观锁在 MySQL 中通常不是直接由数据库引擎提供，而是通过在数据库表中使用一个版本号或时间戳字段实现。当更新数据时，会检查版本号是否发生变化，若未变化，则执行更新并增加版本号。
- **Redis**：Redis 支持乐观锁机制，主要通过 `WATCH` 命令实现。使用 `WATCH` 可以监视一个或多个键，如果在执行事务的 `EXEC` 命令前这些键被其他命令改动过，那么事务将失败。

### 总结

悲观锁和乐观锁都不是 Redis 或 MySQL 特有的；它们是通用的并发控制策略，广泛应用于不同的数据库和数据存储系统中。选择使用悲观锁还是乐观锁取决于应用场景的具体需求，例如操作的冲突率、性能要求、数据一致性需求等因素。在实际应用中，这两种锁策略有时会结合使用，以达到最优的性能和数据一致性。



# 16 watch 和 unwatch



A客户端先执行exec操作

~~~
127.0.0.1:6379> watch k1
OK
127.0.0.1:6379> multi
OK
127.0.0.1:6379(TX)> incrby k1 4000
QUEUED
127.0.0.1:6379(TX)> exec
1) (integer) 4120
127.0.0.1:6379> 
~~~



B客户端后执行exec操作

~~~
127.0.0.1:6379> watch k1
OK
127.0.0.1:6379> multi
OK
127.0.0.1:6379(TX)> unwatch  #在开启的multi事务中执行unwatch不可行，如果监控的k1已经被改变了
#，该事务会直接被打断，而不会执行到unwatch!
QUEUED
127.0.0.1:6379(TX)> incrby k1 2
QUEUED
127.0.0.1:6379(TX)> exec
(nil)
127.0.0.1:6379> get k1
"4120"
127.0.0.1:6379> 
~~~





# 17 在 Java Web 应用中，使用 jQuery 或任何静态资源（如 CSS、JavaScript、图片等），这些资源的加载和引用都遵循同一基本规则：它们必须位于 Web 应用的可公开访问的目录中，通常是 `web` 目录下，而不是 `WEB-INF` 目录下。

### 关于 WEB-INF 目录

`WEB-INF` 目录用于存放应用的配置文件、类文件和库文件（JAR文件），以及不能直接由浏览器访问的其他资源（如 JSP 文件等）。这个目录的内容不会被 Web 容器（如 Tomcat）直接公开访问，是用来存放应用的“内部”资源。

### 关于静态资源的访问

对于静态资源，如 JavaScript 文件、CSS 文件或图片，它们应该放在 `WEB-INF` 外的某个目录中。常见的做法是在 Web 应用的根目录下创建如 `script`、`css`、`img` 等文件夹，以便这些资源可以被公开访问。例如：

- **Web 应用目录结构示例**
  ```
  /webapp
    /WEB-INF
      web.xml
      /classes
      /lib
    /script
      /jquery
        jquery-3.1.0.js
    /css
    /images
  ```

在这种结构中，jQuery 文件位于 `/script/jquery` 目录下，可以通过相对 URL 路径直接访问。

### 关于您的 HTML 页面

您的 HTML 示例中引用的 jQuery 脚本路径是：

```html
<script type="text/javascript" src="script/jquery/jquery-3.1.0.js"></script>
```

这里的路径 `script/jquery/jquery-3.1.0.js` 是相对于 Web 应用的根目录的。因此，您应该确保 `script` 目录位于应用的根目录下（即与 `WEB-INF` 同级），而不是在 `WEB-INF` 目录下。

### 结论

确保将 `script` 目录（及其中的 `jquery` 目录和文件）放置在 Web 应用的根目录下，而不是 `WEB-INF` 目录下。这样，jQuery 文件和其他静态资源就可以被用户的浏览器正常访问。如果放在 `WEB-INF` 下，浏览器将无法加载这些资源，因为这个目录是不对外公开的。





# 18  Servlet 规范

Servlet 规范是由 Java 社区过程（Java Community Process，JCP）提出的一系列标准，旨在定义 Java Servlet 技术的各种方面，包括 Servlet 的生命周期、与Web容器（如Tomcat, Jetty）的交互方式、目录结构等。Servlet 规范的目的是确保不同开发者开发的 Web 应用组件能够在所有遵循这些规范的 Web 容器上无缝运行。

### 主要内容

#### 1. Servlet 生命周期
- **加载和实例化**：容器负责加载 Servlet 类，并创建其实例。
- **初始化**：通过调用 `init()` 方法完成初始化。`init` 方法只被调用一次。
- **请求处理**：每接收一个请求，容器可能使用单独的线程调用 `service()` 方法。`service()` 方法根据请求的类型（GET、POST 等），进一步调用 `doGet()`, `doPost()` 等方法。
- **销毁**：当容器关闭或容器需要释放资源时，`destroy()` 方法被调用，执行清理工作。

#### 2. 目录结构和特殊文件
Servlet 规范定义了Web应用的标准目录结构，这在部署到任何兼容的Web容器时都是必须遵守的：

- **`/WEB-INF`**：
  - **`web.xml`**：部署描述文件，定义 Servlet、过滤器、监听器、安全配置等。
  - **`/classes`**：存放编译后的 `.class` 文件，即 Servlet 和其他类文件。
  - **`/lib`**：存放应用所需的 JAR 文件。根据规范，这个目录必须命名为 `lib`（而不是 `libs` 或其他任何名称），且所有 JAR 文件必须直接位于此目录下，不支持子目录。
  
- **静态资源**（HTML, CSS, JavaScript等）和 JSP 文件通常位于 `WEB-INF` 目录外，以便可以直接被客户端请求访问。

#### 3. Servlet 容器和服务器通信
- Servlet 容器负责管理 Servlet 的生命周期，处理请求，以及维护和服务器的通信。
- 容器也负责会话管理、安全性、多线程管理等。

#### 4. 安全性
- Servlet 规范包括用于声明式安全配置的规则，允许开发者在 `web.xml` 中配置安全约束。

### Servlet API
Servlet API 提供了多个重要的接口和类，包括但不限于：
- `javax.servlet.Servlet`
- `javax.servlet.http.HttpServlet`
- `javax.servlet.ServletRequest`
- `javax.servlet.ServletResponse`
- `javax.servlet.Filter`
- `javax.servlet.http.HttpSession`

### 兼容性和版本
- Servlet 技术从 1997 年的 Servlet 1.0 发展至今，最新的主要版本是 Servlet 4.0，随 Java EE 8 一起发布。
- 每个版本的发布都可能包括新的功能、性能改进、安全性增强以及规范更新。

### 总结
Servlet 规范为 Java Web 开发提供了一套标准的规则和接口，确保开发的 Web 应用可以跨多个服务器和容器平台移植和运行。遵循这些规范可以帮助开发者编写更稳定、更安全、更高效的 Web 应用。

























