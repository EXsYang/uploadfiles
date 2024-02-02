SpringBoot随手笔记

# 1SpringBoot启动失败，报错



~~~xml
pom.xml

<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>com.hspedu</groupId>
    <artifactId>quickstart</artifactId>
    <version>1.0-SNAPSHOT</version>


    <!--导入springboot父工程-规定写法-->
    <parent>
        <artifactId>spring-boot-starter-parent</artifactId>
        <groupId>org.springframework.boot</groupId>
        <version>2.5.3</version>
    </parent>

    <!--这里我们可以指定mysql.version-->
    <!--<properties>-->
    <!--    <mysql.version>5.1.49</mysql.version>-->
    <!--</properties>-->


    <!--导入web项目场景启动器: 会自动导入和web开发相关的所有依赖[库/jar]
    后面老师还会说spring-boot-starter-web 到底引入哪些相关依赖
    -->
    <dependencies>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-web</artifactId>
    </dependency>
    </dependencies>

</project>
~~~



报错下面的语句并输出三行日志就运行结束

~~~
error statuslogger log4j2 could not find a logging implementation. please add log4j-core to the classpath. using simplelogger to log to the console...
~~~

![image-20231121164053601](D:\TyporaPhoto\image-20231121164053601.png)

**解决方法 刷新Maven依赖！**

![image-20231121163951252](D:\TyporaPhoto\image-20231121163951252.png)





---

# 2 maven项目启动后全局都爆红

![image-20231121232438853](D:\TyporaPhoto\image-20231121232438853.png)



![image-20231121232501510](D:\TyporaPhoto\image-20231121232501510.png)

![image-20231121232637650](D:\TyporaPhoto\image-20231121232637650.png)



因为把上一级的普通文件目录当作idea项目文件打开了，生成了 .idea文件，破坏了项目原有的结构，这时只需要**将在maven项目上一级的普通文件夹(my_mybatis文件夹)中 生成的.idea文件删除**  并 **Build Project**即可解决！！！

![image-20231121234342298](D:\TyporaPhoto\image-20231121234342298.png)



参考csdn https://blog.csdn.net/qq_35077107/article/details/111657346

运行报错常用解决办法:
1. 删除项目文件夹中的 .idea, .iml 文件, 然后重新用 IDEA 打开项目
2. 重新 build 项目, 见下图:


3. 双击 maven 中 lifecycle 中的 clean ,清理项目, 见下图:


4. 如果还不行, 可以重启下电脑试一下, 有时候会有这种奇怪的问题, 本身设置都没错, 但就是报 无法加载主类的错误.
5. 最后再不行, 建议重新创建一个 maven工程, 然后将要复制的文件内容手动复制到新项目中, 这样一般最终都可以, 就是略麻烦.
参考:

[idea] 解决 idea 复制进项目的文件运行时无法找到的问题



---

# 3 json字符串处理 [ArrayList] 转成json格式数据

```
// 把result [ArrayList] 转成json格式数据 => 返回
// 这里我们需要使用到java中如何将ArrayList 转成 json
// 这里我们需要使用jackson包下的工具类可以轻松搞定
// 老师演示如何操作
ObjectMapper objectMapper = new ObjectMapper();
String resultJson = objectMapper.writeValueAsString(result);

```



位置 D:\Java_developer_tools\ssm\my_springmvc\hsp_springmvc\src\main\java\com\hspedu\JacksonTest.java

需要导入 相关的 jar 	jackson  

~~~java
 public static void main(String[] args) {

        ArrayList<Monster> monsters = new ArrayList<>();
        monsters.add(new Monster(100,"牛魔王","牛魔王拳",400));
        monsters.add(new Monster(200,"蜘蛛精","吐口水",200));

        //注意引入的是 com.fasterxml.jackson.databind.ObjectMapper;
        ObjectMapper objectMapper = new ObjectMapper();
        try {
            //把monsters转成json
            String  monstersJson = objectMapper.writeValueAsString(monsters);

            System.out.println("monstersJson= " + monstersJson);
            //monstersJson=
            // [{"id":100,"name":"牛魔王","skill":"牛魔王拳","age":400},
            // {"id":200,"name":"蜘蛛精","skill":"吐口水","age":200}]
        } catch (Exception e) {
            e.printStackTrace();
        }

    }	
~~~

---

# 4 springboot中 classpath: 和 file: 分别指的是类路径和项目根路径

```
#springboot在哪里配置读取application.properties文件：
#public class ConfigFileApplicationListener implements EnvironmentPostProcessor, SmartApplicationListener, Ordered {
#  解读 "classpath:/,classpath:/config/,file:./,file:./config/*/,file:./config/";
#  类路径、类路径下的/config/ ，file路径 就是项目根路径
#  ,默认在这些路径下可以读取到 application.properties 文件
#    private static final String DEFAULT_SEARCH_LOCATIONS = "classpath:/,classpath:/config/,file:./,file:./config/*/,file:./config/";

#   这里指定了 springboot默认配置文件名要求叫做 application .properties 而不能乱写的原因
#    private static final String DEFAULT_NAMES = "application";
```

![image-20231127134356010](D:\TyporaPhoto\image-20231127134356010.png)

![image-20231127134544548](D:\TyporaPhoto\image-20231127134544548.png)

---

# 5 想创建一个springboot的项目，本地安装的是1.8，但是在使用Spring Initializr创建项目时，发现版本只有17和21。




起因

想创建一个springboot的项目，本地安装的是1.8，但是在使用Spring Initializr创建项目时，发现版本只有17和21。

![image-20231202141315140](D:\TyporaPhoto\image-20231202141315140.png)

在JDK为1.8的情况下，无论选择Java17版本或者21版本时，都会报错。
要求你要么选择更低的Java版本或者更换更高的SDK版本即跟换JDK版本

![img](D:\TyporaPhoto\39aacff2f6254313ad5c8e8360e8336c.png)

>  Java17和Java 8(JDK1.8)的区别

版本号：Java 17 是 Java SE 17 的版本，而 JDK 1.8 是 Java SE 8 的版本。

发布时间：Java 17 发布于 2021 年，而 JDK 1.8 发布于 2014 年.

新特性：Java 17 相对于 JDK 1.8，新增了很多特性和改进，例如：Switch 表达式、Sealed 类、Pattern
Matching for instanceof 等。

兼容性：Java 17 和 JDK 1.8 不兼容，由于 Java 的向后兼容性，Java 17 可以运行 JDK 1.8 的代码，但
JDK 1.8 不支持 Java 17 的新特性。

安全性：Java 17 相对于 JDK 1.8，修复了更多的安全漏洞，提高了程序的安全性。

> exe和msi的区别

"exe"和"msi"是两种常见的文件扩展名，用于Windows操作系统中的安装程序。它们之间有以下区别：

格式：exe文件是可执行文件，而msi文件是Windows Installer安装包。
安装方式：exe文件通常是自解压缩文件，一般包含一个可执行文件和其他必要的资源。当你运行exe文件时，它会解压缩并执行其中的程序来完成安装。msi文件是一种基于Windows Installer技术的安装包，它采用了Windows Installer服务来处理安装和卸载操作。
安装过程：exe文件通常是自包含的安装程序，可以执行多个操作，例如复制文件、创建注册表项、安装驱动程序等。msi文件则使用Windows Installer提供的功能，通过一系列的安装动作和操作来完成安装过程。这包括执行预定义的安装脚本、处理文件和注册表项、创建快捷方式等。
高级功能：由于采用了Windows Installer技术，msi文件支持一些高级功能，例如安装时的自定义设置、升级和修补程序、回滚机制等。这些功能使得msi文件更适合在企业环境中进行软件分发和管理。
总的来说，exe文件更加灵活，适用于简单的安装过程，而msi文件提供了更强大和可定制的安装功能，适用于需要管理和分发的复杂软件。在选择使用哪种文件格式时，应根据具体的需求和情况进行评估。

分析

1. Spring官方发布Spring Boot 3.0.0 的时候告知了一些情况，Java 17将成为未来的主流版本，所有的Java EE Api都需要迁移到Jakarta EE上来。大部分用户需要修改import相关API的时候，要用jakarta替换javax。比如：原来引入javax.servlet.Filter的地方，需要替换为jakarta.servlet.Filter

2. 进入Springboot官网查看情况，发现在2023年11月24日，3.0以下的版本不再支持了。

   ![img](D:\TyporaPhoto\1e76e147733a4a0d9e5514a92e1cd104.png)


解决
方案一：替换创建项目的源
我们只知道IDEA页面创建Spring项目，其实是访问spring initializr去创建项目。故我们可以通过阿里云国服去间接创建Spring项目。将https://start.spring.io/或者http://start.springboot.io/替换为 https://start.aliyun.com/

![image-20231202141935979](D:\TyporaPhoto\image-20231202141935979.png)

![image-20231202142043591](D:\TyporaPhoto\image-20231202142043591.png)

方案二：升级JDK版本
采用JDK17或者21版本，创建项目后，springboot的版本要改为3.0以下，在pom.xml中把java改为1.8，如下图。

![在这里插入图片描述](D:\TyporaPhoto\94b467f90d014473b86f658f382f2c72.png)

1、下载JDK17，JDK官网
选择Windows X64 Installer下载即可。

![在这里插入图片描述](D:\TyporaPhoto\32f499971da74c25bdd24d00ae3519f8.png)

2、安装JDK17
双击已下载的jdk17，进入安装界面，点击下一步 ==> 选择安装路径，可更改路径，点击更改，我选择安装在E盘，点击确定 == > 点击下一步进行安装。安装完成后直接点击关闭即可。

![img](D:\TyporaPhoto\0139bb8efb6648f78c4c7428d5df198a.png)


3、配置Java环境变量

方式一：点击开始设置 ==> 搜索环境变量
方式二：右击此电 ==> 属性 ==> 高级系统设置 ==>环境变量

![在这里插入图片描述](D:\TyporaPhoto\2f196186f08d4adaa420b85698a5e244.png)

![img](D:\TyporaPhoto\92d285ceaa584ca08d44ced1d1326733.png)

![在这里插入图片描述](D:\TyporaPhoto\504a20af0f6a4455ab3691b9c8dcc48d.png)

在系统变量中找到ptah双击，进入path页面，添加jdk安装位置，新建，选择自己的安装JDK17位置如下图

![img](D:\TyporaPhoto\cef937b97f4247c68c76e6839889748a.png)

![在这里插入图片描述](D:\TyporaPhoto\d55d0ae3f77c4667b7fcf560e791523f.png)

4、验证是否配置成功
win+R输入cmd回车，输入java -version和javac -version,均返回jdk版本，如下图

![在这里插入图片描述](D:\TyporaPhoto\72ef4e6b43994196b755efe48132340c.png)

参考文献
jdk17下载及环境变量配置
exe和msi的区别

---

# 6 IDEA2020.2版本创建/打开高版本Spring Boot项目  3.2.0 卡死

构建时，IDEA卡死无响应
![在这里插入图片描述](D:\TyporaPhoto\20210507201715718.png)
把项目中的.mvn文件夹删除即可
![在这里插入图片描述](D:\TyporaPhoto\watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2wxMzUwMTA1ODU5NQ==,size_16,color_FFFFFF,t_70.png)
应该是这个版本的问题 

> 第二种 在idea中使用Spring Initializr 创建的高版本springboot项目 卡死

![image-20231202152254798](D:\TyporaPhoto\image-20231202152254798.png)

## [IDEA2020.2创建springboot项目卡死在reading maven project的问题](https://www.cnblogs.com/jijm123/p/16425401.html)

## 解决方法一

**问题描述：**
昨天更新IDEA2020.2版本后，创建springboot项目的时候发现一直在reading maven project 中，如下图，而且一点setting（想修改本地maven路径）时，IDEA就卡死，而且打开任务管理器发现IDEA高占CPU。

![img](D:\TyporaPhoto\1107379-20220630001628497-677409574.png)

 

 

**原因：**
猜测是2020.2版本问题，用其他版本没有出现这类情况。
由于第一次用spring Initializr创建maven的项目，它不会找IDEA自带的maven，也不会找你配置的本地maven，而是重新下载一个全新的maven（而且用的是外网下载，特别慢，也导致电脑卡）

> 我是w10的，系统盘在C
> 下载的目录：C:\Users\Administrator.m2\wrapper\dists\apache-maven-3.6.3-bin\1iopthnavndlasol9gbrbg6bf2
>
>  

![img](D:\TyporaPhoto\1107379-20220630001714819-2056362790.png)

 

 **快速解决**：直接删除工程目录maven-wrapper.properties 文件；

![img](D:\TyporaPhoto\1107379-20220630001729910-443067501.png)

 

 

**解决方法：**

`C:\Users\Administrator\.m2\`
1、找的这个目录，bin下面的这层目录大家可能不一样，在这个目录把maven手动放进去，下次创建就不会再下载了而卡死了。

![img](D:\TyporaPhoto\1107379-20220630001746796-676894219.png)

 

 

2、不要关闭IDEA，让它自己慢慢下载，慢慢的等待吧…一个小时估计下载好了。。。。
3、换个版本，我用过的2019.3或者2020.1都没有这些问题、

下载压缩版apache-maven-3.6.3：

注意：因某些限制，某链接通过如下方式获取：

遗留问题：

1、我改了很多次setting，或者setting for new project 结果重启或者重新用spring Initializr创建还是恢复成这个路径，其实保证本地的maven也是3.6.3不会造成影响，修改下面两项是本地的就行。仓库还是用本地的，某还是用本地setting配置的阿里云。

2、如果有更好的解决方案会及时更新。

解决方法二

附录：如果上述方法还是帮不到你，可以尝试下面的解决方法@2

idea2020.2卡死在reading maven projects | idea 2020.2正在读取maven项目 卡住

这是Idea2020.2版本的官方bug，经过多方案测试，我已经解决，下面分享下经验。

我的方法：修改Host文件

1.结束idea的[进程](https://www.finclip.com/news/tags-254.html)

2.将所有指向127.0.0.1的网址注掉，并添加一条新纪录，将127.0.0.1指向localhost

3.保存并重启Idea

提示：修改host文件需要管理员权限(否则系统会提示你需要另存为)，这类基础操作自行百度即可。

网友的方法：

移除项目下 .mvn/maven-wrapper.properties 文件，重启IDEA

解决方法三

idea2020.2创建springboot项目打开卡死在reading maven projects；

解决方法：

移除工程目录/.mvn/maven-wrapper.properties 文件，重新打开idea，再根据路径open一下项目

---

# 7 IDEA异常关闭导致的8080端口占用可以打开任务管理器 输入 J 找到正在运行的java程序 将其关闭即可

![image-20231202221102292](D:\TyporaPhoto\image-20231202221102292.png)

---

# 8
