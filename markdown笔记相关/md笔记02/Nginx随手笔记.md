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

- 打开端口: `firewall-cmd --permanent --add-port=端口号/协议`
- 关闭端口: `firewall-cmd --permanent --remove-port=端口号/协议`
- 增加服务: `firewall-cmd --add-service=http --permanent #增加了一个 http 服务,理解`
- 移除服务: `firewall-cmd --remove-service=http --permanent #移除了一个 http 服务`
- 重新载入, 才能生效: `firewall-cmd --reload`
- 查询端口是否开放: `firewall-cmd --query-port=端口/协议`
- 查询和显示当前活动的防火墙区域（zone）的详细信息`firewall-cmd --list-all` 
- `firewall-cmd --list-all`  **显示当前活动的防火墙区域（zone）的详细信息。**



![image-20240206040104988](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240206040104988.png)

![image-20240206040156364](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240206040156364.png)



## 查看端口监听是否在监听`netstat -anp  | more`

![image-20240206055330502](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240206055330502.png)



## 启动Nginx 的指令

~~~
#启动Nginx 指令 进入到nginx目录后
./sbin/nginx -c nginx.conf

#重新加载Nginx
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





![image-20240206081057137](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240206081057137.png)



否则只能通过端口访问到(即开启代理的情况下，只能通过IP地址访问到Linux上的tomcat)

![image-20240206081116936](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240206081116936.png)



开启代理小猫咪(正向代理)使用域名`www.hsp.com:8080`访问会出现下面的连接超时错误信息，猜测这里是代理服务器拿去进行解析了，然后没找到，因为此时使用的是日本东京Tokyo节点从下图可以看出来

![image-20240206081406622](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240206081406622.png)

































