

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



# 2 普罗米修斯(Prometheus)+Grafana数据展示测试

直达链接：https://www.bilibili.com/video/BV1r94y1b7eS?spm_id_from=333.788.videopod.episodes&vd_source=5b09ee9382c8983b40a6600e7faeb262&p=45



![image-20241117201708000](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20241117201708000.png)



**actuator**	/ˈæktjʊeɪtə/	执行器

**micrometer**	/maɪˈkrɒmɪtə(r)/	千分尺；螺旋测微器



导入两个依赖：

~~~xml
 <!--
         这个依赖引入 Micrometer 的 Prometheus 导出器。
        io.micrometer:micrometer-registry-prometheus 依赖的作用是将 Micrometer 的指标导出到 Prometheus 格式。
         Micrometer 是一个用于度量应用程序指标的库，而 Prometheus 是一个强大的开源监控系统。
         这个依赖允许你将 Micrometer 收集到的指标（例如 CPU 使用率、内存使用率、HTTP 请求数等）以 Prometheus 能够理解和读取的格式进行导出。
        scope: runtime 说明这个依赖只在运行时需要，而在编译时不需要。这意味着该依赖在构建 JAR 包时不会被包含在内，
        只有在运行时应用程序需要使用 Micrometer 导出指标到 Prometheus 时才会使用该依赖。

        如何工作：
        Micrometer 收集指标: Micrometer 库会监控应用程序，收集各种指标数据。
        Prometheus 导出器: micrometer-registry-prometheus 依赖提供一个导出器，用于将 Micrometer 收集到的指标转换为 Prometheus 的格式。
        Prometheus 接收指标: Prometheus 服务可以从你的应用程序收集到的指标数据中获取数据。
        总结： 这个依赖使得 Micrometer 收集的指标能够被 Prometheus 监控系统使用，方便你监控应用程序的性能和运行状况。
         runtime 范围确保了只有在运行时才包含必要的组件，从而减小了构建 JAR 包的大小。

         测试接口：要测试的接口显示在http://localhost:8881/actuator的json数据中
         "prometheus":{"href":"http://localhost:8881/actuator/prometheus",
         即http://localhost:8881/actuator/prometheus
         -->
        <dependency>
            <!--这个micrometer指标在阿里云上是有现成的指标对应的，使用起来方便一些-->
            <groupId>io.micrometer</groupId>
            <artifactId>micrometer-registry-prometheus</artifactId>
            <scope>runtime</scope>
        </dependency>


        <!-- 这个依赖配置的作用是引入 Spring Boot 的 Actuator 模块，并排除掉 Spring Boot 默认的日志记录器 spring-boot-starter-logging。
        spring-boot-starter-actuator 依赖引入 Spring Boot Actuator。Actuator 模块提供了一个强大的工具集，
        用于监控和管理 Spring Boot 应用程序。它暴露了各种端点（endpoints），
        允许你通过 HTTP 访问应用程序的各种指标、健康状态、配置信息等。 这对于应用程序的诊断和监控至关重要。

        exclusions 标签 则排除掉了默认的日志记录器 spring-boot-starter-logging。 这意味着，
        你将不会使用 Spring Boot 默认的日志配置，你需要自己配置日志记录器。 你可能需要添加其他日志依赖（例如 Logback 或 SLF4j 等）。
        为什么排除默认日志记录器？
        通常，这样做是为了：
        自定义日志配置： 在 Actuator 中，可能需要自定义日志记录的方式，以符合项目特定的需求。
        整合其他日志框架： 可能需要使用 Logback 或其他日志框架，而 Actuator 仍依赖于默认的 spring-boot-starter-logging 可能会出现冲突。
        避免冲突： 防止 spring-boot-starter-logging 与项目中已有的日志依赖发生冲突。
        总结： 该配置引入 Actuator 模块，但强制你使用自己选择的日志记录器。 这种做法通常是为了获得更精细的日志控制，或者避免与其他日志框架冲突。 你通常需要在 application.properties 或 application.yml 文件中配置你选择的日志库。

        测试暴露了各种端口的地址：http://localhost:8881/actuator
        然后再根据上面测试端口中的json数据可以查看暴露出来的所有的beans的信息：http://localhost:8881/actuator/beans

         -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-actuator</artifactId>

            <exclusions><!-- 去掉springboot默认配置 -->
                <exclusion>
                    <groupId>org.springframework.boot</groupId>
                    <artifactId>spring-boot-starter-logging</artifactId>
                </exclusion>
            </exclusions>
        </dependency>
        <!--
                上面两个依赖组合使用（spring-boot-starter-actuator，micrometer-registry-prometheus）的效果是：
                将 Spring Boot Actuator 收集的指标以 Prometheus 格式导出，方便 Prometheus 监控系统进行监控和分析。

                更详细地解释：
                spring-boot-starter-actuator: 提供 Spring Boot Actuator 模块，它暴露了各种端点（endpoints），用于监控和管理应用程序的运行状况。 这些端点提供各种指标数据，例如 CPU 使用率、内存使用量、HTTP 请求数等。
                micrometer-registry-prometheus: 提供 Micrometer 的 Prometheus 导出器。 它将 Spring Boot Actuator 提供的指标数据转换为 Prometheus 能够理解的格式 (例如，文本形式的 Metrics)。
                组合使用效果：
                通过将这两个依赖组合使用，Spring Boot 应用程序能够将 Actuator 收集的指标数据，以 Prometheus 可以识别的格式输出。
                 这样，你就可以使用 Prometheus 来监控应用程序的性能，并进行可视化分析。
                简而言之： 你使用 Actuator 收集指标，使用 Micrometer 的 Prometheus 导出器将这些指标转换成 Prometheus 可以读取的格式，从而可以使用 Prometheus 的强大监控功能。
                -->

~~~



配置文件：

~~~yaml

management:
  endpoint:
    metrics:
      enabled: true #支持metrics
    prometheus:
      enabled: true #支持Prometheus
  metrics:
    export:
      prometheus:
        enabled: true # 上面这段配置对应 micrometer-registry-prometheus依赖

    tags:
      application: jvm-test #实例名采集

  endpoints:
    web:
      exposure:
        include: '*' #开放所有端口  对应spring-boot-starter-actuator依赖




#设置应用名
spring:
  application:
    name: jvm-service
  datasource:
    driver-class-name: com.mysql.cj.jdbc.Driver
    url: jdbc:mysql://localhost:3306/jvm_test?serverTimeZone=UTC&useUnicode=true&characterEncoding=UTF-8
    username: root
    password: 123456
#    url: jdbc:mysql://rm-cn-zpr3eymps0008cso.rwlb.rds.aliyuncs.com:3306/jvm?serverTimeZone=UTC&useUnicode=true&characterEncoding=UTF-8
#    url: jdbc:mysql://rm-cn-zpr3eymps0008c.rwlb.rds.aliyuncs.com:3306/jvm?serverTimeZone=UTC&useUnicode=true&characterEncoding=UTF-8
#    username: jvm
#    password: itheima123456@
  rabbitmq:
    host: localhost # rabbitMQ的ip地址
    port: 5672 # 端口
    username: guest
    password: guest
    virtual-host: /

arthas:
  #tunnel地址，目前是部署在同一台服务器，正式环境需要拆分
  tunnel-server: ws://localhost:7777/ws
  #tunnel显示的应用名称，直接使用应用名
  app-name: ${spring.application.name}
  #arthas http访问的端口和远程连接的端口
  http-port: 8888
  telnet-port: 9999

server:
  port: 8881
  tomcat:
    threads:
      min-spare: 50
      max: 500


mybatis:
  mapper-locations: classpath:mapper/*xml
  type-aliases-package: com.itheima.jvmoptimize.practice.demo.pojo



~~~



测试接口：

http://localhost:8881/actuator

http://localhost:8881/actuator/beans

http://localhost:8881/actuator/prometheus





5.8540032E7 等价于 5.8540032E7*10的7次方 单位是字节，大概是58MB左右。

科学计数法 E7 表示 10 的 7 次方。 所以 5.8540032 * 10<sup>7</sup> 字节 = 58,540,032 字节，约为 58MB。

```
jvm_memory_committed_bytes{application="jvm-test",area="nonheap",id="Metaspace",} 5.8540032E7
jvm_memory_committed_bytes{application="jvm-test",area="heap",id="PS Survivor Space",} 2.5165824E7
jvm_memory_committed_bytes{application="jvm-test",area="heap",id="PS Old Gen",} 3.58088704E8
jvm_memory_committed_bytes{application="jvm-test",area="heap",id="PS Eden Space",} 1.2845056E8
jvm_memory_committed_bytes{application="jvm-test",area="nonheap",id="Code Cache",} 1.0289152E7
jvm_memory_committed_bytes{application="jvm-test",area="nonheap",id="Compressed Class Space",} 8257536.0
```





# 3 











