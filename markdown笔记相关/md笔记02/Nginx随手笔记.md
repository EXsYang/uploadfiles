# 1 Nginx 安装



**Nginx 安装指令中调整格式后的命令**

~~~
./configure --prefix=/usr/local/nginx \
--pid-path=/var/run/nginx/nginx.pid \
--lock-path=/var/lock/nginx.lock \
--error-log-path=/var/log/nginx/error.log \
--http-log-path=/var/log/nginx/access.log \
--with-http_gzip_static_module \
--http-client-body-temp-path=/var/temp/nginx/client \
--http-proxy-temp-path=/var/temp/nginx/proxy \
--http-fastcgi-temp-path=/var/temp/nginx/fastcgi \
--http-uwsgi-temp-path=/var/temp/nginx/uwsgi \
--http-scgi-temp-path=/var/temp/nginx/scgi \
--conf-path=/usr/local/nginx/nginx.conf

~~~





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





~~~
[root@hspEdu100 nginx]# firewall-cmd --list-all
public (active)
  target: default
  icmp-block-inversion: no
  interfaces: ens33
  sources: 
  services: ssh dhcpv6-client
  ports: 8080/tcp
  protocols: 
  masquerade: no
  forward-ports: 
  source-ports: 
  icmp-blocks: 
  rich rules: 
	
[root@hspEdu100 nginx]# systemctl list-unit-files | grep firewalld
firewalld.service                             enabled 
[root@hspEdu100 nginx]# firewall-cmd --permanent --add-port=80/tcp
success
[root@hspEdu100 nginx]# firewall-cmd --list-all
public (active)
  target: default
  icmp-block-inversion: no
  interfaces: ens33
  sources: 
  services: ssh dhcpv6-client
  ports: 8080/tcp
  protocols: 
  masquerade: no
  forward-ports: 
  source-ports: 
  icmp-blocks: 
  rich rules: 
	
[root@hspEdu100 nginx]# firewall-cmd --reload
success
[root@hspEdu100 nginx]# firewall-cmd --list-all
public (active)
  target: default
  icmp-block-inversion: no
  interfaces: ens33
  sources: 
  services: ssh dhcpv6-client
  ports: 8080/tcp 80/tcp
  protocols: 
  masquerade: no
  forward-ports: 
  source-ports: 
  icmp-blocks: 
  rich rules: 
	
[root@hspEdu100 nginx]# 
~~~



![image-20240206033320058](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240206033320058.png)





`firewall-cmd --add-service=http --permanent` 命令用于在 `firewalld` 防火墙服务中永久地添加 HTTP 服务。在大多数情况下，**HTTP 服务默认监听在端口 80 上**。

`firewalld` 使用预定义的服务配置，这些配置指定了哪些端口和协议应该被允许用于该服务。对于 HTTP 服务，默认的配置通常包括 TCP 端口 80，因为这是 HTTP 通信的标准端口。

如果您想验证或查看 HTTP 服务的具体配置，您可以查看 `firewalld` 的服务配置文件。这些文件通常位于 `/usr/lib/firewalld/services`（系统默认服务）或 `/etc/firewalld/services`（自定义服务）目录。例如，查看 HTTP 服务配置的命令可能是：

```bash
cat /usr/lib/firewalld/services/http.xml
```

这个文件将包含关于 HTTP 服务的详细信息，包括它监听的端口。



~~~
[root@hspEdu100 nginx]# cat /usr/lib/firewalld/services/http.xml
<?xml version="1.0" encoding="utf-8"?>
<service>
  <short>WWW (HTTP)</short>
  <description>HTTP is the protocol used to serve Web pages. If you plan to make your Web server publicly available, enable this option. This option is not required for viewing pages locally or developing Web pages.</description>
  <port protocol="tcp" port="80"/>
</service>
[root@hspEdu100 nginx]# 
~~~

## 防火墙指令

- 打开端口: `firewall-cmd --permanent --add-port=端口号/协议` 或者
- `firewall-cmd --add-port=端口号/协议 --permanent `



- 关闭端口: `firewall-cmd --permanent --remove-port=端口号/协议`
- 增加服务: `firewall-cmd --add-service=http --permanent #增加了一个 http 服务,理解`
- 移除服务: `firewall-cmd --remove-service=http --permanent #移除了一个 http 服务`
- 重新载入, 才能生效: `firewall-cmd --reload`
- 查询端口是否开放: `firewall-cmd --query-port=端口/协议`
- 查询和显示当前活动的防火墙区域（zone）的详细信息`firewall-cmd --list-all` 
- `firewall-cmd --list-all`  **显示当前活动的防火墙区域（zone）的详细信息。**



![image-20240206040104988](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240206040104988.png)

![image-20240206040156364](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240206040156364.png)



## 查看端口监听是否在监听使用指令

## `netstat -anp  | more`

`netstat -anp` 命令主要用于显示系统中所有网络连接、端口的监听状态，以及这些连接和端口所关联的程序信息，同时以数字形式显示地址和端口。

netstat -anp  | more   

![image-20240206055330502](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240206055330502.png)

`netstat -anp` 是一个在Linux系统中用于显示网络连接、路由表、接口统计等信息的命令。这个命令的选项组合 `-anp` 提供了特定类型的输出。下面是对这些选项的解释：

1. `-a`（all）: 显示所有选项。包括监听和非监听的套接字（sockets）。
2. `-n`（numeric）: 以数字形式显示地址和端口号，而不是尝试解析成域名、服务名。
3. `-p`（program）: 显示创建连接或监听端口的程序的标识符和程序名。

使用 `netstat -anp`，你可以看到网络系统的详细状态，包括：

- 所有打开的连接和监听端口
- 连接的状态（例如，ESTABLISHED, LISTENING）
- 使用这些连接的程序的PID和名称
- 远程地址和端口号以及本地地址和端口号

这个命令对于网络诊断和监控非常有用，特别是当你需要确定哪个程序正在使用网络或哪些端口正在监听时。

除了 `-anp`，`netstat` 还有其他一些常用的选项：

- `-r`（route）: 显示路由表。用于查看本机的路由信息，包括目的地、网关等。
- `-i`（interfaces）: 显示网络接口的信息。用于查看网络接口的状态，例如数据包传输的数量和速率。
- `-s`（statistics）: 按协议显示统计数据。这个选项会列出每个协议（如IP, TCP, UDP等）的统计信息。
- `-t`（TCP）: 仅显示TCP协议的连接。
- `-u`（UDP）: 仅显示UDP协议的连接。
- `-l`（listening）: 仅显示监听状态的套接字。这对于查找正在等待连接的服务非常有用。
- `-c`（continuous）: 持续输出网络信息，通常与其他选项结合使用，以实时监控网络状态。
- `-p`（program）: 如之前所述，显示创建连接或监听端口的程序的标识符和程序名。
- `-n`（numeric）: 使用数字地址和端口号，而不是尝试将它们解析为域名或服务名。

使用这些选项可以帮助你更详细地了解网络状态和各种网络协议的使用情况。例如，`netstat -tuln` 会列出所有处于监听状态的TCP和UDP连接，并以数字形式显示端口和地址。这些信息对于网络管理和故障排除非常重要。

请注意，`netstat` 在一些最新的Linux发行版中可能已被 `ss` 和其他更现代的工具所取代。但是，在很多系统中，`netstat` 仍然是一个非常有用的工具。

## 启动Nginx 的指令

~~~
#启动Nginx 指令 进入到nginx目录后
./sbin/nginx -c nginx.conf

#重新加载Nginx 这里的-s是signal，信号的意思
./sbin/nginx -s reload

#停止运行Nginx
./sbin/nginx -s stop

~~~

![image-20240206041240416](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240206041240416.png)



![image-20240206040632694](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240206040632694.png)



# 2 修改hosts，访问Linux配置的Tomcat

`C:\Windows\System32\drivers\etc\hosts` 文件中配置的ip和域名的映射，要想在Windows宿主机上通过浏览器访问到，需要关闭代理



~~~
#配置Linux虚拟机IP(学习Nginx反向代理时配置的)，这里自己配置的域名要想访问到需要关闭代理软件
192.168.198.135		www.hsp.com
~~~

**需要关闭代理软件 再访问**		http://www.hsp.com:8080/



![image-20240206081057137](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240206081057137.png)



否则只能通过端口访问到(即开启代理的情况下，只能通过IP地址访问到Linux上的tomcat)

http://192.168.198.135:8080/

![image-20240206081116936](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240206081116936.png)



开启代理小猫咪(正向代理)使用域名`www.hsp.com:8080`访问会出现下面的连接超时错误信息，猜测这里是代理服务器拿去进行解析了，然后没找到，因为此时使用的是日本东京Tokyo节点从下图可以看出来

![image-20240206081406622](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240206081406622.png)



# 3 nginx location规则 location = / {} 和 location / {} 的作用和区别

在 Nginx 配置中，`location` 指令用于定义如何处理特定类型的请求。其中，`location = / {}` 和 `location / {}` 是两种不同的匹配模式，它们有着不同的作用和匹配规则。

1. `location = / {}`：
   - 这是一个精确匹配（exact match）规则。
   - 这条规则仅当请求的 URI 完全等于 `/` 时才会匹配，即只有当请求的是根路径（如 `http://example.com/`）时才适用。
   - 这是最具体的匹配类型，当有多个 `location` 匹配同一个请求时，精确匹配的优先级最高。

2. `location / {}`：
   - 这是一个普通匹配（prefix match）规则。
   - 这条规则会匹配任何以 `/` 开始的请求，基本上它会匹配所有的请求，因为所有的 URI 都是以 `/` 开始的。
   - 在存在多个匹配时，这种匹配的优先级较低。Nginx 会选择最长的匹配前缀的 `location` 块。

总结一下，`location = / {}` 用于精确匹配根路径的请求，而 `location / {}` 用于匹配所有以 `/` 开头的请求。在实际使用中，选择哪一种取决于你的具体需求和期望的行为。精确匹配对于特定的路径非常有用，而普通匹配则适用于更广泛的场景。



# 4 Nginx `location` 指令解析与示例

具体细节参考下面链接

https://chat.openai.com/share/b58a494b-7b2f-4c9e-990c-960ac56ee857


#### `location = / {}` vs. `location / {}`

- **`location = / {}`** 是一个精确匹配规则，仅匹配请求的根路径 `/`。例如，如果配置了如下：
  ```nginx
  location = / {
    # 针对根URL的配置
  }
  ```
  仅当请求为 `http://example.com/` 时，该规则才会被匹配和执行。

- **`location / {}`** 是一个前缀匹配规则，匹配任何以 `/` 开头的请求。这意味着它会匹配所有请求，因为所有的 URI 都是以 `/` 开头的。例如：
  ```nginx
  location / {
    # 对所有请求的通用配置
  }
  ```
  这将匹配任何请求，如 `http://example.com/page`、`http://example.com/img/logo.png` 等。

#### 正则表达式匹配 `location`

- **`location ~ \.xhtml$ {}`** 使用区分大小写的正则表达式匹配以 `.xhtml` 结尾的请求。例如，它会匹配 `http://example.com/page.xhtml` 但不匹配 `http://example.com/page.html`。
  
- **`location !~ \.xhtml$ {}`** 使用区分大小写的正则表达式进行否定匹配，即匹配不以 `.xhtml` 结尾的请求。例如，它不会匹配 `http://example.com/page.xhtml` 但会匹配 `http://example.com/page.html`。

- **`location !~* \.xhtml$ {}`** 使用不区分大小写的正则表达式进行否定匹配，与 `!~` 类似，但对大小写不敏感。这意味着它不会匹配 `http://example.com/page.XHTML` 或 `http://example.com/page.xhtml`。

### `server_name` 配置和 `hosts` 文件的交互

配置 `hosts` 文件将域名解析指向特定的 IP 地址，而在 Nginx 中使用 `server_name` 来指定该服务器块应处理哪些域名的请求。如果 `server_name` 设置为一个 IP 地址，而实际的请求使用的是通过 `hosts` 文件解析的域名，则可能导致请求无法与期望的 `server` 块匹配，因为 `server_name` 与请求的 `Host` 头部不匹配。

### 示例

假设 `hosts` 文件配置如下：

```
192.168.198.135    www.hsp.com
192.168.198.135    www.hsp2.com
192.168.198.135    www.hsp3.com
```

而 Nginx 配置中的 `server` 块设置如下：

```nginx
server {
    listen 80;
    server_name 192.168.198.135; # 仅以 IP 地址作为 server_name
    ...
}
```

这种配置下，无论是访问 `www.hsp.com`、`www.hsp2.com` 还是 `www.hsp3.com`，由于 `server_name` 与请求的 `Host` 头部不匹配，所有这些请求都会被同一个 `server` 块处理（假设没有其他更适合的匹配），导致无法根据不同的域名提供差异化的服务或内容。

### 结论

为了确保 Nginx 能根据不同的域名提供特定的处理逻辑，`server_name` 应该被设置为相应的域名，而不是 IP 地址。这样，Nginx 可以根据请求的 `Host` 头部正确地选择相应的 `server` 块进行处理，从而实现基于域名的虚拟主机配置。



# 5 Tomcat`webapps/ROOT/`目录说明

Tomcat是一个广泛使用的Java Servlet容器和Web服务器。在Tomcat中，`webapps`目录是用来存放所有的Web应用程序的地方，每个Web应用程序都会被放在这个目录下的一个子目录中。

特别地，`webapps/ROOT/`目录在Tomcat服务器中扮演着一个特殊的角色。这个目录用于存放Tomcat的默认或根Web应用程序。当你访问Tomcat服务器的根URL（比如 http://localhost:8080/）时，你实际上是在访问`webapps/ROOT/`目录下的内容。

这意味着，如果你想要你的Web应用程序在不需要任何额外的路径就能直接通过服务器的根URL访问，你可以将其放在`webapps/ROOT/`目录中。这对于想要作为主要或唯一应用程序运行在Tomcat上的Web应用来说很有用。

总结来说，`webapps/ROOT/`目录是用于存放那些希望能够通过服务器根URL直接访问的Web应用程序的内容。

#  6 Tomcat`webapps/`目录说明

你的理解是对的。默认情况下，访问`http://localhost:8080/`确实是访问`webapps/ROOT/`目录下的资源。我之前的回答是基于你提供的路径`webapps/member/hi.html`，解释如何直接访问位于`webapps`目录下名为`member`的应用中的`hi.html`文件。

当你将一个文件或应用放在`webapps/member/`目录下时，这意味着你创建了一个名为`member`的Web应用。因此，要访问这个应用中的资源，你需要在URL中包含应用的名称（即`member`），这样Tomcat就知道你想要访问的是哪个应用下的资源。

如果你希望通过访问`http://localhost:8080/`直接访问`hi.html`文件，你需要将该文件放在`webapps/ROOT/`目录下，而不是`webapps/member/`。这样，当你访问Tomcat服务器的根URL时，Tomcat会默认访问`webapps/ROOT/`目录下的资源。

简而言之，如果你的**文件位于`webapps/member/hi.html`，通过URL`http://localhost:8080/member/hi.html`访问是正确的方式**，因为它指向`member`应用下的`hi.html`文件。而`http://localhost:8080/`默认访问的是`webapps/ROOT/`目录下的资源，所以不会去访问`webapps/ROOT/member/hi.html`，除非你将文件放在`webapps/ROOT/member/`目录下，并通过`http://localhost:8080/member/hi.html`进行访问。

# 7



~~~
cd /opt/tomcat/apache-tomcat-8.5.59/webapps/ROOT/


cd /usr/local/nginx/


C:\Windows\System32\drivers\etc\

D:\Java_developer_tools\mycode\javaweb\apache-tomcat-8.0.50-windows-x64\apache-tomcat-8.0.50\webapps
~~~



# 7 Nginx代理的URI访问机制说明

当你配置了 Nginx 以使用 `proxy_pass` 指令反向代理到另一个服务（比如 Tomcat 运行在 `127.0.0.1:8080`）时，Nginx 会将匹配的请求转发到指定的地址和端口。在你的示例中，配置如下：

```nginx
location ~ /product/ {
    proxy_pass http://127.0.0.1:8080;
}
```

这意味着，当一个请求的 URI 匹配到 `/product/` 时（例如 `http://www.hsp.com:10000/product/ok.jpg`），Nginx 会将这个请求转发到 `http://127.0.0.1:8080`。重要的是要理解 Nginx 如何处理这个转发：

1. **URI 的保留**：**Nginx 会保留原始请求的 URI 部分（`/product/ok.jpg`），并将其附加到 `proxy_pass` 指定的基础 URL 后面，除非在 `proxy_pass` 中指定了 URI。因此，Nginx 会请求 `http://127.0.0.1:8080/product/ok.jpg`。**

2. **端口访问**：Nginx 不仅仅是访问一个端口，而是向目标服务（在这个例子中是 `127.0.0.1:8080`）发送一个完整的 HTTP 请求。目标服务（比如 Tomcat）然后基于请求的 URI（`/product/ok.jpg`）来处理这个请求。

3. **资源的定位**：目标服务（在这里是运行在端口 8080 上的 Tomcat）会根据其配置来解析和定位请求的资源。在这个例子中，Tomcat 会在其部署的应用中查找相对于应用根的 `/product/ok.jpg` 路径。

因此，当你的 Nginx 配置用于反向代理到 `http://127.0.0.1:8080`，并且接收到一个请求匹配到 `/product/` 时，Nginx 实际上是在请求 `http://127.0.0.1:8080/product/ok.jpg`。这就是说，它会到 Tomcat 服务器的 8080 端口下面去找 `/product/ok.jpg` 这个资源。

总结来说，Nginx 在这里充当反向代理的角色，将特定的请求转发给后端服务，并且保留了请求的 URI 部分，使得后端服务可以根据该 URI 定位和返回相应的资源。



# ^~和正则匹配先后顺序说明

![image-20240208040522223](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240208040522223.png)





