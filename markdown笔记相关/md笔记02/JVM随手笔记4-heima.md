

# 说明，这是学习黑马JVM的笔记



# 1 Spring Boot 项目连接 RabbitMQ 错误分析及依赖说明



**问题描述：**

在使用 Spring Boot 项目连接 RabbitMQ 时，出现 org.springframework.amqp.AmqpConnectException: java.net.ConnectException: Connection refused: connect 和 MySQL 连接错误。 在本地运行时，这些错误指向 RabbitMQ 和 MySQL 连接配置问题。但在云服务器上使用 Arthas Tunnel 进行远程调试时，日志中没有出现这些错误信息，但应用程序仍然无法正常连接到 RabbitMQ【虽然这不是本次测试的重点，本次测试的重点是**使用arthas-tunnel-server-3.7.1-fatjar.jar同时监控多个服务**】。



**注意项目在本地也启动成功了，但只是报错了而已。**

![image-20241116012000898](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20241116012000898.png)



**关于rabbitmq的这个报错，在老韩的秒杀项目教学中有提到，具体位置在视频1-14如下**

![image-20241116175238257](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20241116175238257.png)





![image-20241116012228443](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20241116012228443.png)

**错误原因分析:**

1. **Spring Boot Starter AMQP 依赖:** spring-boot-starter-amqp 依赖 **仅** 提供了与 AMQP 消息代理交互的工具和配置。它 **不包含** RabbitMQ 服务器软件本身。 你需要在服务器上安装和配置 RabbitMQ。
2. **Arthas Tunnel Server 与应用程序独立：** Arthas Tunnel Server 仅仅提供远程调试的通道，它本身 **不会启动或管理** 应用程序的依赖服务，包括 RabbitMQ 和 MySQL。
3. **云服务器环境：** 在云服务器上，你 **必须独立安装和启动** RabbitMQ。 之前错误信息没有出现在日志中，是因为连接尝试在应用程序启动时进行，但因为 RabbitMQ 没有启动，连接失败，但是应用程序本身却可以启动，所以错误信息被吞掉了。

**关键点：**

- 应用程序的启动成功 **不代表** 其依赖的服务也启动了。
- 你需要在云服务器上启动 RabbitMQ 和 MySQL 服务器，并配置应用程序连接到这些服务器。

**解决步骤：**

1. **在云服务器上安装和启动 RabbitMQ。**
2. **在云服务器上安装和启动 MySQL。**
3. **配置应用程序的配置文件 (application.properties 或 application.yml)：** 确保配置了正确的 RabbitMQ 连接信息（例如：主机、端口、用户名、密码）。 同时确保配置了正确的 MySQL 数据库连接信息。
4. **单独启动 Spring Boot 应用程序：** 在云服务器上用适当的命令（例如 java -jar ...）启动你的应用程序。
5. **使用 Arthas Tunnel Server 进行远程调试：** 确认 Arthas Tunnel Server 正确配置并连接到云服务器上的应用程序。

**总结：** 错误信息可能被 Arthas Tunnel Server 隐藏，但问题仍然存在于云服务器上的应用程序无法连接到 RabbitMQ 和 MySQL。 解决的关键在于确保 RabbitMQ 和 MySQL 以及你的应用程序在云服务器上都已正确启动和配置。



# 2 







