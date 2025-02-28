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



# 8 ^~和正则匹配先后顺序说明

![image-20240208040522223](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240208040522223.png)



# 9 当nginx.conf 中没有配置`location /`配置时，浏览器访问http://www.hspcrm.com/到nginx 监听的端口80 后，回退到默认行为，即显示默认页面

浏览器输入:http://www.hspcrm.com/

显示的界面如下：



![image-20240208062051830](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240208062051830.png)

 **nginx.conf 配置：**

~~~nginx

#nginx.conf 配置

server {
        listen       80;
         
        location /search/ {
        #代理到Linux的上游服务器的tomcat,版本号8.5
            proxy_pass http://hspservers;
        }

        
    }
~~~



根据你提供的Nginx配置文件内容，没有直接的配置项指定将请求指向Nginx的默认欢迎界面。但是，根据你的配置，存在一些原因可能导致当访问`http://www.hspcrm.com/`时，显示Nginx的默认欢迎界面：

1. **缺少`location /`配置**：在`server`块中，用于处理`www.hspcrm.com`的请求，没有为根路径（`location /`）指定任何处理规则。这意味着对于`www.hspcrm.com`的根URL（`/`）的请求，Nginx没有指定如何处理，因此可能回退到默认行为，即显示默认页面。

2. **缺少`root`指令**：同样，在处理`www.hspcrm.com`的`server`块中，没有看到任何`root`指令，这意味着Nginx不知道从哪个目录中提供文件。通常，对于静态文件的服务或者当使用`proxy_pass`指令外的场景，需要指定`root`指令来定义静态文件的根目录。

3. **配置未生效**：如果你在修改配置后没有重新加载Nginx配置（使用`nginx -s reload`命令），那么更改不会生效。确保每次修改配置后都重新加载。

为了解决这个问题，你可以添加一个针对根URL的`location /`块，并在其中定义如何处理这些请求。例如，如果你想将所有根URL的请求代理到上游服务器，你可以这样配置：

```nginx
location / {
    proxy_pass http://hspservers;
}
```

或者，如果你有静态文件想要直接由Nginx服务，确保设置了`root`指令，并且有一个默认文件（如`index.html`）作为入口点：

```nginx
location / {
    root /path/to/your/static/files;
    index index.html index.htm;
}
```

确保配置正确，并再次重新加载Nginx配置。这样，对于访问`www.hspcrm.com`的请求，Nginx就会按照你的新配置进行处理，而不是显示默认的欢迎界面。

   在Nginx中，如果针对给定的`server`块中的请求（比如对`http://www.hspcrm.com/`的访问），没有找到匹配的`location`指令来处理根路径（`/`），Nginx会回退到其默认行为。这通常意味着：

- **显示默认页面**：如果没有为`/`路径配置具体的处理规则（如通过`location /`指定），Nginx可能会返回默认的欢迎页面或者是一个404页面，这取决于Nginx的具体配置和版本。默认页面是Nginx用来确认服务正常运行的一个简单页面。

- **使用`root`指令的默认路径**：如果`server`块中有`root`指令，但没有为`/`路径配置`location`处理规则，Nginx会试图在`root`指令指定的目录下寻找请求的文件。如果请求的是根路径（即URL为`http://www.hspcrm.com/`），Nginx通常会查找`index`指令指定的文件作为默认页面（如`index.html`）。如果没有找到这样的文件，Nginx可能会返回一个404错误页面。

因此，当你的Nginx配置中没有针对根路径`/`的`location`配置时，确实可能会看到Nginx的默认页面。为了避免这种情况，建议明确配置`location /`块，指定如何处理根路径的请求，无论是通过代理传递给后端应用，还是直接从文件系统中提供静态内容。这样可以确保访问根路径时的行为符合你的预期。

# 10 在浏览器中直接访问http://192.168.198.136/search/cal.jsp，还会去hosts文件找吗？不会

当你在浏览器中直接使用IP地址访问一个网站，如`http://192.168.198.136/search/cal.jsp`，浏览器和底层网络栈通常不会查询`hosts`文件来解析该IP地址。`hosts`文件主要用于将主机名（如`www.example.com`）映射到IP地址。当你使用主机名而不是IP地址访问网站时，系统会首先检查`hosts`文件看是否有对应的条目。如果找到，就使用`hosts`文件中指定的IP地址。如果没有找到，系统则会进一步查询DNS（域名系统）来解析主机名。

因此，当你直接通过IP地址访问时：
- **不会**查询`hosts`文件，因为没有主机名需要解析。
- 浏览器会直接使用该IP地址尝试建立连接。

这意味着，如果你希望通过特定的主机名访问而不是IP地址，并且想要控制这个解析过程（比如开发环境中指向不同的测试服务器），你应该在`hosts`文件中添加一个相应的条目。例如：

```
192.168.198.136 example.com
```

这样，当你通过浏览器访问`http://example.com/search/cal.jsp`时，系统会查找`hosts`文件并使用里面定义的IP地址（在这个例子中是`192.168.198.136`）来访问服务，而不是通过DNS解析得到的IP。



# 11 当在浏览器地址栏直接使用IP地址访问Nginx服务器时（例如，通过`http://192.168.198.136/search/cal.jsp`） Nginx 的nginx.conf中 server_name 如何配置

当在浏览器地址栏直接使用IP地址访问Nginx服务器时（例如，通过`http://192.168.198.136/search/cal.jsp`），在`nginx.conf`文件中的`server_name`指令配置需要适当处理以确保Nginx能正确处理该请求。有几种方法可以配置`server_name`以响应基于IP地址的请求：

### 1. 使用下划线作为通配符
你可以使用`_`（下划线）作为`server_name`的值，这在Nginx中被视为一个通配符，可以匹配任何没有明确列出的主机名或IP地址的请求。

```nginx
server {
    listen 80;
    server_name _;

    location / {
        # 配置细节
    }
}
```

这种配置方式使得Nginx服务器能够接受通过任意主机名或IP地址发起的请求，包括直接使用IP地址。

### 2. 明确指定IP地址
如果你打算让Nginx只响应特定IP地址的请求，可以直接将IP地址作为`server_name`的值：

```nginx
server {
    listen 80;
    server_name 192.168.198.136;

    location / {
        # 配置细节
    }
}
```

这种方式使得Nginx仅响应目标为`192.168.198.136`的请求。

### 3. 使用默认服务器
另一种方法是配置Nginx的默认服务器（default server）。这可以通过在`listen`指令中添加`default_server`参数来实现，这样即使`server_name`没有直接匹配到请求中的IP地址或主机名，请求也会被发送到这个默认服务器。

```nginx
server {
    listen 80 default_server;
    server_name _;

    location / {
        # 配置细节
    }
}
```

这会使得这个服务器块成为接收所有未被其他服务器块捕获的请求的默认目的地，包括直接通过IP地址的请求。

### 结论
选择哪种方法取决于你的具体需求。如果你想让Nginx响应任何IP地址或主机名的请求，使用下划线`_`作为`server_name`的值或配置一个默认服务器是比较灵活的选项。如果你的Nginx服务器只服务于一个特定的IP地址，那么直接在`server_name`中指定该IP地址可能是更直接、更清晰的方法。



# 12 keepalived 配置文件vrrp_instance VI_1 {    state MASTER    interface ens33    virtual_router_id 51    priority 100 advert_int 1，这里的`state MASTER`，可以随便写吗



~~~nginx
[root@hspEdu100 sbin]# vim /etc/keepalived/keepalived.conf 

   vrrp_gna_interval 0
}

vrrp_instance VI_1 {
    state MASTER
    interface ens33
    virtual_router_id 51
    priority 100
    advert_int 1
    authentication {
        auth_type PASS
        auth_pass 1111
    }
    virtual_ipaddress {
        192.168.198.18
    }
}
~~~



在`keepalived`的配置文件中，`vrrp_instance`部分的`state`指令指定了实例启动时的初始状态。这个状态可以是**`MASTER`或`BACKUP`**。这里的配置对于`keepalived`的VRRP（虚拟路由器冗余协议）实例来说是非常重要的，因为它决定了在启动时实例的角色。

- **`MASTER`**：这个状态意味着在`keepalived`启动时，配置为`MASTER`的节点会主动尝试承担虚拟IP（VIP）的责任。它会立即发送VRRP广告，试图成为VIP的主控制者。
- **`BACKUP`**：这个状态意味着节点在启动时将处于等待状态，监听VRRP广告。如果在预定时间内没有收到`MASTER`的广告，或者`MASTER`节点的优先级比`BACKUP`节点低，`BACKUP`节点可以接管成为新的`MASTER`。

### 可以随便写吗？
理论上，你可以在配置文件中指定任一节点为`MASTER`或`BACKUP`，但这个选择应该基于你的网络和高可用架构设计。通常，你会根据以下考虑来决定：

- **预期的初始主控节点**：如果你希望某个节点在启动时即尝试成为VIP的控制者，应将其`state`设置为`MASTER`。
- **高可用性设计**：你可能希望根据服务器的硬件配置、网络连接的可靠性或其他因素来决定哪个节点更适合作为初始的`MASTER`。

### 动态选举
重要的是要理解，无论初始状态如何设置，`keepalived`都会通过VRRP协议的优先级和健康检查机制来动态选举`MASTER`。这意味着即使一个节点被配置为`MASTER`状态，如果另一个节点的优先级更高，后者也可以在运行时成为`MASTER`。

- **`priority`**：`priority`值（可以是1到254之间的任何值）决定了当有多个节点竞争成为`MASTER`时哪个节点获胜。优先级更高的节点会成为`MASTER`。

因此，虽然`state`指令的初始设置很重要，但`keepalived`会根据实时情况（如节点的可用性和优先级）来动态调整哪个节点应该承担`MASTER`角色。正确配置`priority`和健康检查是确保`keepalived`高可用性的关键。



# 13 keepalived 配置文件注意细节



![image-20240210033212628](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240210033212628.png)



![image-20240210033300735](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240210033300735.png)

**当`keepalived`配置中的`vrrp_instance`的`state`行被注释掉后，不论其下一行是设置为`MASTER`还是`BACKUP`，`keepalived`在启动时将不会使用这个指令来决定初始状态。**而是，`keepalived`将依据其他机制，如优先级（`priority`）、接收到的VRRP广告，以及预设的预先权（preemption）策略来决定节点的角色。

### VRRP优先级和动态选举

在`keepalived`的VRRP实现中，实际的`MASTER`/`BACKUP`角色是通过动态选举过程决定的，这主要基于以下因素：

- **优先级（`priority`）**：各节点通过广播自己的优先级，优先级最高的节点倾向于成为`MASTER`。如果你的`BACKUP`节点设置了较高的优先级（或者由于网络延迟，`MASTER`节点的优先级广告未能及时到达`BACKUP`节点），`BACKUP`节点可能会成为`MASTER`。
- **预先权（Preemption）**：默认情况下，预先权开启。这意味着，如果一个优先级更高的`MASTER`节点稍后上线，它将会从当前的`MASTER`节点（即便当前`MASTER`是由于优先级较高的`BACKUP`节点提升上来的）接管`MASTER`角色。如果预先权被禁用，即使一个优先级更高的节点后来上线，当前的`MASTER`状态也不会被改变。

### 网络因素和启动时间

网络延迟或节点启动时间的差异也可能影响到`MASTER`/`BACKUP`角色的决定过程。例如：

- 如果`MASTER`节点在启动时网络延迟较大，它发送的VRRP广告可能不会被`BACKUP`节点及时接收到，导致`BACKUP`节点误以为`MASTER`节点不在，从而提升自己为`MASTER`。
- 同样，如果`BACKUP`节点启动得比`MASTER`节点快很多，并且在一段时间内没有接收到`MASTER`的VRRP广告，它可能也会提升自己为`MASTER`。

### 故障排查建议

- **检查网络配置**：确保两个节点之间的网络连接是稳定的，没有造成数据包延迟或丢失的问题。
- **检查和调整优先级**：确保`MASTER`节点的优先级高于`BACKUP`节点，并检查配置确保预先权（preemption）是启用的。
- **日志和监控**：查看`keepalived`的日志可以提供为什么`BACKUP`节点成为`MASTER`的线索。日志通常可以在`/var/log/messages`、`/var/log/syslog`，或者`keepalived`的专用日志文件中找到。
- **确保配置的一致性**：确认所有的`keepalived`配置都正确无误，特别是在多节点环境中，确保每个节点的配置文件都正确反映了它们的角色和预期行为。

通过上述步骤，你应该能够诊断出为何`BACKUP`节点在某些情况下会被选为`MASTER`，即使你期望的是`MASTER`节点首先承担这一角色。



# 14 为什么有时会首先访问到BACKUP？和启动顺序有关吗？

 当**先启动`BACKUP`节点后再启动`MASTER`节点**解决了问题，这实际上揭示了`keepalived`和网络环境在处理VRRP（虚拟路由器冗余协议）选举和ARP（地址解析协议）广播方面的一些细微之处。这种情况可能由几个因素共同作用导致：

### 1. **VRRP选举机制**
在VRRP协议中，当一个新的`MASTER`节点上线时，它会通过发送VRRP通告来宣告自己的优先级。如果此时`BACKUP`节点已经在运行，并且检测到有一个优先级更高的`MASTER`节点宣告，`BACKUP`节点会将`MASTER`角色让给新上线的节点。这确保了网络中优先级最高的节点总是成为`MASTER`。

### 2. **Gratuitous ARP（GARP）**
当`MASTER`节点变更时（例如，当你启动`MASTER`节点，它从`BACKUP`节点夺回`MASTER`状态），`MASTER`节点会发送GARP消息，告知网络中的其他设备（如交换机和路由器）关于虚拟IP地址（VIP）的MAC地址已更改。如果先启动`BACKUP`，然后启动`MASTER`，这个过程可能更有可能触发并正确处理GARP消息，从而确保网络流量正确地路由到新的`MASTER`节点。

### 3. **网络设备的ARP缓存更新**
在某些情况下，网络设备可能在处理ARP缓存更新时表现出一些延迟或不一致性。先启动`BACKUP`节点可能给网络设备提供了额外的时间来处理和应用来自新`MASTER`节点的GARP更新，从而确保流量正确路由。

### 4. **`keepalived`配置和状态同步**
确保`keepalived`的配置正确，并且状态同步也很重要。在某些情况下，启动顺序可能影响到`keepalived`内部状态的同步过程，尽管这种情况较少见。

### 结论
虽然在一些情况下，启动顺序影响了期望的行为，但最佳实践仍然是确保`keepalived`配置正确（特别是关于优先级和预先权的设置），并且网络环境能够可靠地处理VRRP通告和GARP消息。如果遇到类似问题，除了调整启动顺序外，还应该检查和优化以上提到的各个方面。

此外，持续监控和测试高可用性设置，确保在各种情况下都能如预期工作，这对于维护网络的稳定性和可靠性至关重要。



# 15 Nginx 配置与端口共享笔记

遇到的问题如下：

如果我输入的是chat.999190.xyz则会进入到fiora服务页面，如果我输入的是服务器ip如：74.48.31.142 然后在地址栏回车，则会进入到nginx默认的index.html页面，为什么？这里80端口分别被默认页面和fiora共同使用着了吗？



![image-20250228042846049](https://tgimgbed.999190.xyz/file/1740688146525_image-20250228042846049.png)

![image-20250228042912232](https://tgimgbed.999190.xyz/file/1740688155642_image-20250228042912232.png)

1



~~~shell
[root@racknerd-8454f32 nginx]# cd conf/conf.d/

[root@racknerd-8454f32 conf.d]# ls

default.conf      fiora_nginx.conf.bak   fiora_nginx.conf.bak3       one-api_nginx.conf

fiora_nginx.conf  fiora_nginx.conf.bak2  fiora_nginx.conf.wanshande  one-api_nginx.conf.bak

[root@racknerd-8454f32 conf.d]# cat fiora_nginx.conf

server {

listen       80;

server_name  chat.999190.xyz vrchat.vip;  #如果要配置多个域名，则要用空格分割

# 将 HTTP 请求重定向到 HTTPS

#return 301 https://$host$request_uri;

#return 301 https://$server_name$request_uri;

#return 301 https://chat.999190.xyz$request_uri;

#}

# HTTPS 服务器

#server {

#listen       443 ssl http2;

#server_name  chat.999190.xyz;

#charset koi8-r;

#access_log  /var/log/nginx/log/host.access.log  main;

# SSL 证书配置

#ssl_certificate /root/.acme.sh/*.999190.xyz_ecc/fullchain.cer;

#ssl_certificate_key /root/.acme.sh/*.999190.xyz_ecc/*.999190.xyz.key;

# SSL 协议和加密套件配置

#ssl_protocols TLSv1.2 TLSv1.3;

#ssl_protocols TLSv1.2;

#ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:HIGH:!aNULL:!MD5:!RC4:!DHE;

#ssl_prefer_server_ciphers on;

#ssl_session_timeout 5m;

# 代理配置

location / {

#下面这一版本,记录的新用户的注册IP其实是cloudflare服务器代理的ip

#proxy_pass http://fiora:9200;  # 修改为您的后端服务地址

#proxy_set_header   X-Real-IP        $remote_addr;

#proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;

#proxy_set_header   Host             $http_host;

#proxy_set_header   Upgrade          $http_upgrade;

#proxy_set_header   X-NginX-Proxy    true;

#proxy_set_header   Connection "upgrade";

#proxy_http_version 1.1;

#proxy_pass         http://fiora:9200;

# 代理到后端服务

proxy_pass http://fiora:9200;  # 修改为您的后端服务地址

# 设置请求头

proxy_set_header   CF-Connecting-IP $http_cf_connecting_ip;  # Cloudflare真实IP

proxy_set_header   X-Real-IP        $http_cf_connecting_ip;  # 使用Cloudflare的真实IP

proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;  # 传递IP链

proxy_set_header   Host             $http_host;  # 原始主机头

proxy_set_header   Upgrade          $http_upgrade;  # WebSocket支持

proxy_set_header   X-NginX-Proxy    true;  # Nginx代理标识

proxy_set_header   Connection "upgrade";  # 连接升级

proxy_http_version 1.1;  # HTTP版本

# WebSocket 支持

#proxy_set_header Upgrade $http_upgrade;

#proxy_set_header Connection "upgrade";

#proxy_http_version 1.1;

}

#location / {

#root   /usr/share/nginx/html;

#index  index.html index.htm;

#}

#error_page  404              /404.html;

# redirect server error pages to the static page /50x.html

#

error_page   500 502 503 504  /50x.html;

location = /50x.html {

root   /usr/share/nginx/html;

}

# proxy the PHP scripts to Apache listening on 127.0.0.1:80

#

#location ~ \.php$ {

#    proxy_pass   http://127.0.0.1;

#}

# pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000

#

#location ~ \.php$ {

#    root           html;

#    fastcgi_pass   127.0.0.1:9000;

#    fastcgi_index  index.php;

#    fastcgi_param  SCRIPT_FILENAME  /scripts$fastcgi_script_name;

#    include        fastcgi_params;

#}

# deny access to .htaccess files, if Apache's document root

# concurs with nginx's one

#

#location ~ /\.ht {

#    deny  all;

#}

}

[root@racknerd-8454f32 conf.d]# cat one-api_nginx.conf

# HTTP 服务器（监听 80 端口，Cloudflare 会处理 HTTPS）

server {

listen 80;

server_name api.999190.xyz api.vrchat.vip;  # 支持多个域名，用空格分隔

# 代理配置

location / {

client_max_body_size 64m;

proxy_http_version 1.1;

proxy_pass http://one-api:38888;  # 指向 one-api 容器的 38888 端口

proxy_set_header Host $host;

proxy_set_header X-Forwarded-For $remote_addr;

proxy_set_header CF-Connecting-IP $http_cf_connecting_ip;

proxy_cache_bypass $http_upgrade;

proxy_set_header Accept-Encoding gzip;

proxy_read_timeout 300s;

proxy_set_header Upgrade $http_upgrade;

proxy_set_header Connection "upgrade";

}

# 错误页面配置（可选）

error_page 500 502 503 504 /50x.html;

location = /50x.html {

root /usr/share/nginx/html;

}

}

[root@racknerd-8454f32 conf.d]# cat default.conf

server {

listen       80;

server_name  localhost;

#charset koi8-r;

#access_log  /var/log/nginx/log/host.access.log  main;

location / {

root   /usr/share/nginx/html;

index  index.html index.htm;

}

#error_page  404              /404.html;

# redirect server error pages to the static page /50x.html

#

error_page   500 502 503 504  /50x.html;

location = /50x.html {

root   /usr/share/nginx/html;

}

# proxy the PHP scripts to Apache listening on 127.0.0.1:80

#

#location ~ \.php$ {

#    proxy_pass   http://127.0.0.1;

#}

# pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000

#

#location ~ \.php$ {

#    root           html;

#    fastcgi_pass   127.0.0.1:9000;

#    fastcgi_index  index.php;

#    fastcgi_param  SCRIPT_FILENAME  /scripts$fastcgi_script_name;

#    include        fastcgi_params;

#}

# deny access to .htaccess files, if Apache's document root

# concurs with nginx's one

#

#location ~ /\.ht {

#    deny  all;

#}

}

[root@racknerd-8454f32 conf.d]#
~~~



> 如果我输入的是chat.999190.xyz则会进入到fiora服务页面，如果我输入的是服务器ip如：74.48.31.142 然后在地址栏回车，则会进入到nginx默认的index.html页面，为什么？这里80端口分别被默认页面和fiora共同使用着了吗？

# 问题15中导致Nginx 80端口共享的配置解析

您的问题涉及 Nginx 的虚拟主机配置机制。我来解释一下为什么会出现这种情况：

## 原因分析

当您访问 `chat.999190.xyz` 时，会进入 fiora 服务页面，而访问 IP 地址 `74.48.31.142` 时，会进入 Nginx 默认页面。这是因为：

1. Nginx 使用基于域名的虚拟主机配置（server_name 指令）来区分不同的请求
2. 当请求中的 Host 头与某个 server_name 匹配时，请求会被路由到对应的 server 块
3. 当请求的 Host 头与任何 server_name 都不匹配时，Nginx 会：
   - 首先尝试使用默认服务器（即第一个定义的 server 块）
   - 或者使用明确标记为 `default_server` 的服务器块

## 您的配置分析

在您的配置中：

1. `fiora_nginx.conf` 中的 server 块配置了 `server_name chat.999190.xyz vrchat.vip`
2. `default.conf` 中的 server 块配置了 `server_name localhost`

当您通过 IP 地址访问时，请求的 Host 头是 IP 地址本身，不匹配任何已配置的 server_name，所以 Nginx 使用默认的 server 块（在这种情况下是 `default.conf` 中的配置）。

## 解决方案

如果您希望通过 IP 地址访问时也进入 fiora 服务，可以修改 `fiora_nginx.conf` 文件，在 server_name 中添加 IP 地址或设置为默认服务器：

```nginx:fiora_nginx.conf
server {
    listen       80 default_server;  # 添加 default_server 标记
    server_name  chat.999190.xyz vrchat.vip 74.48.31.142;  # 添加 IP 地址
    
    # 其余配置保持不变
    ...
}
```

这样，无论是通过域名还是 IP 地址访问，都会进入 fiora 服务页面。

## 总结

是的，80 端口确实被多个配置共同使用，但 Nginx 通过 Host 头和 server_name 指令来区分请求应该由哪个 server 块处理。这就是为什么同一个端口可以提供不同的服务，取决于访问时使用的域名或 IP 地址。



## 基本概念

Nginx 使用虚拟主机（Virtual Host）机制在同一个端口上提供多个不同的网站服务。这是通过 `server_name` 指令实现的，它允许 Nginx 根据 HTTP 请求头中的 Host 字段将请求路由到不同的配置块。

## 配置文件分析

### 1. 默认配置 (default.conf)
```
server {
    listen       80;
    server_name  localhost;
    
    location / {
        root   /usr/share/nginx/html;
        index  index.html index.htm;
    }
    
    # 错误页面配置
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }
}
```

### 2. Fiora 应用配置 (fiora_nginx.conf)
```
server {
    listen       80;
    server_name  chat.999190.xyz vrchat.vip;
    
    location / {
        proxy_pass http://fiora:9200;
        proxy_set_header   CF-Connecting-IP $http_cf_connecting_ip;
        proxy_set_header   X-Real-IP        $http_cf_connecting_ip;
        proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;
        proxy_set_header   Host             $http_host;
        proxy_set_header   Upgrade          $http_upgrade;
        proxy_set_header   X-NginX-Proxy    true;
        proxy_set_header   Connection "upgrade";
        proxy_http_version 1.1;
    }
    
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }
}
```

### 3. One-API 应用配置 (one-api_nginx.conf)
```
server {
    listen 80;
    server_name api.999190.xyz api.vrchat.vip;
    
    location / {
        client_max_body_size 64m;
        proxy_http_version 1.1;
        proxy_pass http://one-api:38888;
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-For $remote_addr;
        proxy_set_header CF-Connecting-IP $http_cf_connecting_ip;
        # 其他代理设置...
    }
}
```

## 工作原理

1. **端口共享**：所有配置都监听 80 端口，但通过不同的 `server_name` 区分
2. **请求路由**：
   - 访问 `chat.999190.xyz` → 路由到 fiora 服务
   - 访问 `api.999190.xyz` → 路由到 one-api 服务
   - 访问 IP 地址 (74.48.31.142) → 路由到默认配置

3. **默认服务器选择**：
   - 当请求的 Host 头不匹配任何 `server_name` 时，Nginx 会选择：
     - 第一个定义的 server 块，或
     - 标记为 `default_server` 的 server 块

## 解决方案

如果希望通过 IP 地址访问时也进入特定服务，可以：

1. 在目标配置中添加 IP 地址到 `server_name`：
   ```
   server_name chat.999190.xyz vrchat.vip 74.48.31.142;
   ```

2. 或将目标配置设为默认服务器：
   ```
   listen 80 default_server;
   ```

## 总结

Nginx 通过虚拟主机机制实现了在同一端口上提供多个不同服务的能力，根据请求的 Host 头将流量导向不同的应用程序。当使用 IP 地址直接访问时，由于没有匹配的 `server_name`，请求会被路由到**默认服务器**配置。



# 16 但是有时却说服务不能同时使用同一个端口，比如两个不同的服务同时监听一个端口会导致服务启动失败，报错有占用之类的，我这里的one-api服务，可以使用80端口吗？类似于上面这个问题，如何配置？



# Nginx 端口共享与服务配置说明

您提出了一个很好的问题。确实，从操作系统层面来说，一个端口只能被一个进程直接监听。当我们说多个服务"共享"同一个端口时，实际上是通过反向代理服务器(如Nginx)实现的，而不是多个服务直接监听同一个端口。

## 端口监听的工作原理

1. **直接监听端口**：在操作系统层面，一个端口只能被一个进程直接监听。如果两个服务同时尝试监听同一个端口(如80端口)，第二个服务会启动失败并报"端口已被占用"错误。

2. **通过反向代理共享端口**：Nginx作为反向代理服务器，它直接监听80端口，然后根据请求的域名(Host头)将流量转发到不同的后端服务。

## 您的情况分析

在您的配置中：

1. **Nginx**直接监听80端口
2. **fiora服务**运行在9200端口
3. **one-api服务**运行在38888端口

Nginx根据请求的域名将流量转发到不同的后端服务：
- 访问`chat.999190.xyz`时，Nginx将请求转发到`fiora:9200`
- 访问`api.999190.xyz`时，Nginx将请求转发到`one-api:38888`

## 如何配置one-api使用80端口

您不需要让one-api直接监听80端口，而是应该：

1. 让one-api监听它自己的端口(如38888)
2. 通过Nginx配置将特定域名的80端口请求转发到one-api服务

您已经有了正确的配置：

```nginx
server {
    listen 80;
    server_name api.999190.xyz api.vrchat.vip;  # 这些域名的请求会被转发到one-api

    location / {
        proxy_pass http://one-api:38888;  # 转发到one-api服务
        # 其他代理设置...
    }
}
```

## 总结

1. **不同服务不能直接共享同一个端口**：从操作系统角度，一个端口只能被一个进程监听。

2. **通过Nginx实现"端口共享"**：
   - Nginx监听80端口
   - 后端服务(fiora, one-api)监听各自的端口
   - Nginx根据请求域名将流量转发到对应的后端服务

3. **您的配置已经正确**：您不需要让one-api直接监听80端口，现有的Nginx配置已经能够将api.999190.xyz的请求转发到one-api服务。

这种架构不仅解决了端口共享问题，还提供了额外的安全性、负载均衡和灵活性优势。

