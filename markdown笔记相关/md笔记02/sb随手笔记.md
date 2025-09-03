SpringBoot随手笔记

# 0 关于火狐浏览器什么时候会发出http请求的说明

**在抓包的情况下(按下F12后的模式)，不管是刷新页面还是在浏览器地址栏回车，该页面中的图片都会发出http请求；**

**但如果不是抓包的模式下,如果访问的页面和上一次访问的页面相同(地址栏的地址没有更改)，不管是刷新页面还是在浏览器地址栏回车该页面中的图片<img src="images/logo.png"/>都不会再次发出http请求，而是使用的是浏览器缓存的图片**

![image-20231209170132470](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20231209170132470.png)



```
//很多浏览器 在url没有变化的时候 ，图片不会发出新的请求
//虽然是无痕浏览但是 因为图片被缓存了 是没办法的
//浏览器认为返回的就是一个图片 因此请求就不再发出了
//为了防止不请求 不刷新 可以携带一个变化的参数
//this.src="http://localhost:8080/jiaju_mall/kaptchaServlet";
```

```
jiaju_mall项目中解决两个奇怪的问题其一
<%--img src="#" 因为写了base标签 所以参考base标签后，
会去请求当前页url http://localhost:8080/jiaju_mall/# --%>
<%--<img src="#" alt="">--%>
```

```html
<!--下面这个会发出http请求，请求当前页面-->
<img src="#"/>
<!--下面这个src为空，不会发出http请求-->
<img src=""/>
```

---



**如果是在浏览器地址栏回车请求一个图片/.css文件，http://localhost:8080/images/logo.png 并且这个图片有缓存了，这个http请求就不会被发出；**

**但如果是刷新页面，就会发出该请求。**

![image-20231212220406379](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20231212220406379.png)

---



**只要我们在代码中创建了一个img元素(HTMLImageElement实例)，并且我们给这个img元素的src赋值了，那么浏览器就会发起网络请求，加载图片内容**。

---

# 0.1为什么传统方式配置的视图解析器进行视图解析后，在底层请求转发后可以被拦截器拦截到，而通过 spring-boot-starter-thymeleaf 自动配置 ,Thymeleaf自带的视图解析器就不会被拦截器拦截！！

主要的原因在于 Thymeleaf 的工作机制与传统的视图解析器有所不同。

- 请求转发 vs 模板渲染： 传统的视图解析器（如 InternalResourceViewResolver）会使用请求转发来将请求转发到特定的 JSP 或 HTML 页面。这时，拦截器可以捕获到请求的转发并执行相应的操作。
  与此不同，Thymeleaf 作为一个模板引擎，它的工作方式是将模板渲染成最终的 HTML 输出，而不涉及到请求转发。Thymeleaf 视图解析器只负责解析视图名称对应的模板，并将渲染结果返回给客户端。
- 生命周期阶段： 拦截器的执行生命周期在请求的处理前和处理后。对于传统的视图解析器，请求转发是在处理阶段进行的，因此拦截器可以捕获到。然而，Thymeleaf 的工作是在请求处理之后的渲染阶段，此时拦截器已经完成了它的生命周期。
  由于这些差异，拦截器在 Thymeleaf 视图渲染阶段没有机会进行拦截。Thymeleaf 的设计目标是提供灵活且强大的模板渲染功能，而不一定与传统的请求转发方式完全一致。
-  如果你需要在 Thymeleaf 视图渲染之前或之后执行一些操作，可以考虑使用 Thymeleaf 提供的一些扩展机制，如 ITemplateResolver、IProcessor 等。这些扩展点可以在模板渲染的不同阶段添加自定义逻辑。



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

![image-20231121164053601](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20231121164053601.png)

**解决方法 刷新Maven依赖！**

![image-20231121163951252](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20231121163951252.png)





---

# 2 maven项目启动后全局都爆红

![image-20231121232438853](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20231121232438853.png)



![image-20231121232501510](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20231121232501510.png)

![image-20231121232637650](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20231121232637650.png)



因为把上一级的普通文件目录当作idea项目文件打开了，生成了 .idea文件，破坏了项目原有的结构，这时只需要**将在maven项目上一级的普通文件夹(my_mybatis文件夹)中 生成的.idea文件删除**  并 **Build Project**即可解决！！！

![image-20231121234342298](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20231121234342298.png)



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

![image-20231127134356010](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20231127134356010.png)

![image-20231127134544548](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20231127134544548.png)

---

# 5 想创建一个springboot的项目，本地安装的是1.8，但是在使用Spring Initializr创建项目时，发现版本只有17和21。




起因

想创建一个springboot的项目，本地安装的是1.8，但是在使用Spring Initializr创建项目时，发现版本只有17和21。

![image-20231202141315140](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20231202141315140.png)

在JDK为1.8的情况下，无论选择Java17版本或者21版本时，都会报错。
要求你要么选择更低的Java版本或者更换更高的SDK版本即跟换JDK版本

![img](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/39aacff2f6254313ad5c8e8360e8336c.png)

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

   ![img](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/1e76e147733a4a0d9e5514a92e1cd104.png)


解决
方案一：替换创建项目的源
我们只知道IDEA页面创建Spring项目，其实是访问spring initializr去创建项目。故我们可以通过阿里云国服去间接创建Spring项目。将https://start.spring.io/或者http://start.springboot.io/替换为 https://start.aliyun.com/

![image-20231202141935979](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20231202141935979.png)

![image-20231202142043591](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20231202142043591.png)

方案二：升级JDK版本
采用JDK17或者21版本，创建项目后，springboot的版本要改为3.0以下，在pom.xml中把java改为1.8，如下图。

![在这里插入图片描述](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/94b467f90d014473b86f658f382f2c72.png)

1、下载JDK17，JDK官网
选择Windows X64 Installer下载即可。

![在这里插入图片描述](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/32f499971da74c25bdd24d00ae3519f8.png)

2、安装JDK17
双击已下载的jdk17，进入安装界面，点击下一步 ==> 选择安装路径，可更改路径，点击更改，我选择安装在E盘，点击确定 == > 点击下一步进行安装。安装完成后直接点击关闭即可。

![img](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/0139bb8efb6648f78c4c7428d5df198a.png)


3、配置Java环境变量

方式一：点击开始设置 ==> 搜索环境变量
方式二：右击此电 ==> 属性 ==> 高级系统设置 ==>环境变量

![在这里插入图片描述](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/2f196186f08d4adaa420b85698a5e244.png)

![img](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/92d285ceaa584ca08d44ced1d1326733.png)

![在这里插入图片描述](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/504a20af0f6a4455ab3691b9c8dcc48d.png)

在系统变量中找到ptah双击，进入path页面，添加jdk安装位置，新建，选择自己的安装JDK17位置如下图

![img](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/cef937b97f4247c68c76e6839889748a.png)

![在这里插入图片描述](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/d55d0ae3f77c4667b7fcf560e791523f.png)

4、验证是否配置成功
win+R输入cmd回车，输入java -version和javac -version,均返回jdk版本，如下图

![在这里插入图片描述](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/72ef4e6b43994196b755efe48132340c.png)

参考文献
jdk17下载及环境变量配置
exe和msi的区别

---

# 6 IDEA2020.2版本创建/打开高版本Spring Boot项目  3.2.0 卡死

构建时，IDEA卡死无响应
![在这里插入图片描述](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/20210507201715718.png)
把项目中的.mvn文件夹删除即可
![在这里插入图片描述](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2wxMzUwMTA1ODU5NQ==,size_16,color_FFFFFF,t_70.png)
应该是这个版本的问题 

> 第二种 在idea中使用Spring Initializr 创建的高版本springboot项目 卡死

![image-20231202152254798](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20231202152254798.png)

## [IDEA2020.2创建springboot项目卡死在reading maven project的问题](https://www.cnblogs.com/jijm123/p/16425401.html)

## 解决方法一

**问题描述：**
昨天更新IDEA2020.2版本后，创建springboot项目的时候发现一直在reading maven project 中，如下图，而且一点setting（想修改本地maven路径）时，IDEA就卡死，而且打开任务管理器发现IDEA高占CPU。

![img](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/1107379-20220630001628497-677409574.png)

 

 

**原因：**
猜测是2020.2版本问题，用其他版本没有出现这类情况。
由于第一次用spring Initializr创建maven的项目，它不会找IDEA自带的maven，也不会找你配置的本地maven，而是重新下载一个全新的maven（而且用的是外网下载，特别慢，也导致电脑卡）

> 我是w10的，系统盘在C
> 下载的目录：C:\Users\Administrator.m2\wrapper\dists\apache-maven-3.6.3-bin\1iopthnavndlasol9gbrbg6bf2
>
>  

![img](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/1107379-20220630001714819-2056362790.png)

 

 **快速解决**：直接删除工程目录maven-wrapper.properties 文件；

![img](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/1107379-20220630001729910-443067501.png)

 

 

**解决方法：**

`C:\Users\Administrator\.m2\`
1、找的这个目录，bin下面的这层目录大家可能不一样，在这个目录把maven手动放进去，下次创建就不会再下载了而卡死了。

![img](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/1107379-20220630001746796-676894219.png)

 

 

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

我的方法：修改Host文件 【host文件位置:C:\Windows\System32\drivers\etc\hosts】【hosts文件位置:C:\Windows\System32\drivers\etc\hosts】

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

![image-20231202221102292](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20231202221102292.png)

---

# 8 StringUtils.hasText() 和 ObjectUtils.isEmpty()



**StringUtils和ObjectUtils都是spring框架提供的工具类**

~~~
package org.springframework.util;
~~~



```


// 做一个判断
// 如果 imgPath 有数据 就设置给this.imgPath
// 如果 null 或 空串"" 或 都是空格"    " 就使用默认的图片路径

//使用spring框架提供的工具类 StringUtils hasText()方法
//解决
// import org.springframework.util.StringUtils;
/**
 *  public static boolean hasText(@Nullable String str) {
 *         return str != null && !str.isEmpty() && containsText(str);
 *  }
 *
 *  StringUtils.hasText() 会经常使用!!
 *  该方法 如果传入的是 null 或 空串"" 或 都是空格"    "   返回false 即
 *  如果是Text 有数据 ,才会返回true
 */
if (StringUtils.hasText(imgPath)) {
    this.imgPath = imgPath;
}
```

---

# 9 自定义对象参数 封装成对象



~~~html
<h1>添加妖怪-坐骑[测试封装 POJO；]</h1>
<form action="/saveMonster" method="post">
    编号： <input name="id" value="100"><br/>
    姓名： <input name="name" value="牛魔王!"/> <br/>
    年龄： <input name="age" value="120"/> <br/>
    婚否： <input name="isMarried" value="true"/> <br/>
    生日： <input name="birth" value="2000/11/11"/> <br/>


    坐骑：<input name="car.name" value="法拉利2"/><br/>
    价格：<input name="car.price" value="99999.2"/>

    <input type="submit" value="保存"/>
</form>
~~~



~~~java
 /**
     * 演示自定义对象参数使用，完成自动封装，类型转换  从save.html发送请求进行测试
     * 形参位置直接写 Monster monster, 就可以，底层会自动完成封装
     * 注意前端提交参数的参数名 必须和对象的属性名保持一致 否则封装失败
     * 如果有级联 就按照 car.name car.price 的方式进行数据的提交 否则封装失败
     * 
     * 注意：这种封装对象的方式，不需要把相关的对象注入到容器中，会自动地完成封装
     */
    @PostMapping("/saveMonster")
    public String saveMonster(Monster monster){

        System.out.println("monster= " + monster);
        return "success";
    }
    
~~~



---

# 10 @ResponseBody注解返回json/xml格式数据



```java
//返回Monster对象-以json格式返回

/**
 * 底层会走到 AbstractJackson2HttpMessageConverter转换器类的 writeInternal方法
 *
 *
 */
@GetMapping("/get/monster")
@ResponseBody
public Monster getMonster(){

    //开发中，monster对象是从DB中获取的,这里模拟monster数据
    Monster monster = new Monster();
    monster.setId(100);
    monster.setName("孙悟空");
    monster.setAge(10000);
    monster.setBirth(new Date());
    monster.setIsMarried(false);
    Car car = new Car();
    car.setName("奔驰");
    car.setPrice(200000.0);
    monster.setCar(car);

    return monster;
}
```





```java
@Override
protected void writeInternal(Object object, @Nullable Type type, HttpOutputMessage outputMessage)
      throws IOException, HttpMessageNotWritableException {

   MediaType contentType = outputMessage.getHeaders().getContentType();
	// contentType 其实就是http协议中请求头设置的 Accept的值
    // 根据contentType决定要给浏览器/客户端返回的数据格式 [json/xml...]

   JsonEncoding encoding = getJsonEncoding(contentType);

   Class<?> clazz = (object instanceof MappingJacksonValue ?
         ((MappingJacksonValue) object).getValue().getClass() : object.getClass());
   ObjectMapper objectMapper = selectObjectMapper(clazz, contentType);
   Assert.state(objectMapper != null, "No ObjectMapper for " + clazz.getName());

   OutputStream outputStream = StreamUtils.nonClosing(outputMessage.getBody());
   try (JsonGenerator generator = objectMapper.getFactory().createGenerator(outputStream, encoding)) {
	   // JsonGenerator 容易产生误解
       // 并不是只可以处理Json格式的数据，xml也可以处理，只不过
       // 这里统一使用JsonGenerator进行处理
       // 根据contentType不一样，产生的generatorbu'yi'y
       // 如果返回的是json格式这里产生的 generator对象 是 UTF8JsonGenerator
       // 如果返回的是xml格式这里产生的 generator对象 是 ToXmlGenerator(前提是
       // 在pom.xml文件中引入了支持返回xml格式的依赖jackson-dataformat-xml)
       
       
       writePrefix(generator, object);

      Object value = object;
      Class<?> serializationView = null;
      FilterProvider filters = null;
      JavaType javaType = null;

      if (object instanceof MappingJacksonValue) {
         MappingJacksonValue container = (MappingJacksonValue) object;
         value = container.getValue();
         serializationView = container.getSerializationView();
         filters = container.getFilters();
      }
      if (type != null && TypeUtils.isAssignable(type, value.getClass())) {
         javaType = getJavaType(type, null);
      }

      ObjectWriter objectWriter = (serializationView != null ?
            objectMapper.writerWithView(serializationView) : objectMapper.writer());
      if (filters != null) {
         objectWriter = objectWriter.with(filters);
      }
      if (javaType != null && javaType.isContainerType()) {
         objectWriter = objectWriter.forType(javaType);
      }
      SerializationConfig config = objectWriter.getConfig();
      if (contentType != null && contentType.isCompatibleWith(MediaType.TEXT_EVENT_STREAM) &&
            config.isEnabled(SerializationFeature.INDENT_OUTPUT)) {
         objectWriter = objectWriter.with(this.ssePrettyPrinter);
      }
      objectWriter.writeValue(generator, value); //重要的，在这里返回数据

      writeSuffix(generator, object);
      generator.flush();
   }
   catch (InvalidDefinitionException ex) {
      throw new HttpMessageConversionException("Type definition error: " + ex.getType(), ex);
   }
   catch (JsonProcessingException ex) {
      throw new HttpMessageNotWritableException("Could not write JSON: " + ex.getOriginalMessage(), ex);
   }
}
```



没有加@ResponseBody注解时 上面writeInternal()方法形参中的 object如下：

<img src="https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20231206210334840.png" alt="image-20231206210334840" style="zoom:80%;" />

加了@ResponseBody注解时 上面writeInternal()方法形参中的 object如下：

<img src="https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20231206210338238.png" alt="image-20231206210338238" style="zoom: 80%;" />



---

# 11 浏览器发出第一次请求，在服务器端进行了重定向，浏览器根据响应码302和Location发出的第二次请求是get请求

---

# 12 form表单action如果写了一个# 默认会提交给当前这个斜杠 / 



```html
<!--action="#" 默认会提交给当前这个斜杠 / 
, 因为后端的@GetMapping(value = {"/","/login"})可以匹配到
, 所以默认不改 也是可以提交到的

-->
<!--<form action="#" method="post">-->
 <!--<form action="#" th:action="/login" method="post">-->
    <form action="/login" method="post">
        <label style="color: #ff0000" th:text="${msg}"></label><br/>
        <!--如果这里写了 th:text="" 就会报错
            org.thymeleaf.templateengine : [thymeleaf][http-nio-8080-exec-1] exception processing template "adminlogin": could not parse as expression: "" (template: "adminlogin" - line 17, col 32)
            org.thimeleaf.templateengine:[thymelaf][http-nio-8080-exec-1]异常处理模板“adminlogin”：无法解析为表达式：“”（模板：“adminlogin”-第17行，第32列
         -->
        <!--用户名:<input type="text" th:text="" style="width:150px" name="name"/><br/><br/>-->
        用户名:<input type="text" style="width:150px" name="name"/><br/><br/>
        密　码:<input type="password" style="width:150px" name="password"/><br/><br/>
        <input type="submit" value="登录"/>
        <input type="reset" value="重新填写"/>
    </form>
```



```java
@GetMapping(value = {"/","/login"})
public String login(){

    /**
     * 为什么这里没有配置视图解析器，可以找到 thymeleaf/adminLogin.html文件呢?
     * 1. 因为我们引入了starter-thymeleaf
     * 2. 这里就会直接使用视图解析到 thymeleaf下的模板文件adminLogin.html
     * 3. starter-thymeleaf它本身就进行了视图解析
     *
     */
    //这里不用写所在的包，可以直接写里面的thymeleaf文件 adminLogin.html  的文件名而不用写包名 回顾视图解析器 有前缀和后缀
    return "adminLogin";
}
```



---

# 13 思考的问题，如果上传了两个相同文件名的文件，再往回下载回来，如何进行区分？



---

# 14 springboot项目中获取类路径的方法ResourceUtils.getURL()

```
import org.springframework.util.ResourceUtils;

String path = ResourceUtils.getURL("classpath:").getPath();
log.info("path={}",path);
```

---

# 15 创建文件时 路径中的正斜杠"/"和两个反斜杠"\\"效果是一样的，都可以创建成功！！

```
创建文件时 路径中的正斜杠"/"和两个反斜杠"\\"效果是一样的，都可以创建成功！！
File uploadPhoto = new File(file.getAbsolutePath() + "\\" + originalFilename);
File uploadPhoto2 = new File(file.getAbsolutePath() + "/" + originalFilename);
log.info("uploadPhoto 绝对路径={}", uploadPhoto.getAbsolutePath());
log.info("uploadPhoto2 绝对路径={}", uploadPhoto2.getAbsolutePath());

输出如下：
uploadPhoto 绝对路径=D:\Java_developer_tools\springboot\springboot-usersys\target\classes\static\images\upload\浴衣.jpg

uploadPhoto2 绝对路径=D:\Java_developer_tools\springboot\springboot-usersys\target\classes\static\images\upload\浴衣.jpg


```



---

# 16 注入Mapper接口的代理对象的方式对比@Mapper&MapperScannerConfigurer





@Mapper接口的作用和ssm整合项目中spring配置文件中的

~~~xml
 <!-- 配置扫描器，将 mybatis 在dao层 接口的实现加入到 ioc 容器中    1. 我们的mapper接口放在com.hspedu.furn.dao    2. mybatis就是处于DAO层，操作DB  -->  
<bean class="org.mybatis.spring.mapper.MapperScannerConfigurer">        
    <!-- 1. 扫描所有的 dao 接口的实现，加入到 ioc 容器中        2. 这里 dao 接口，就是 mapper 接口 -->        
     <property name="basePackage" value="com.hspedu.furn.dao"/>  
</bean>
~~~

 是否相同？



![GPT](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/zL0pW1H0t100g1%2BUA%3D.png)

艾丽丝格雷拉特：

`@Mapper` 注解和配置 `MapperScannerConfigurer` 两种方法都用于在 MyBatis 和 Spring 集成中扫描和注册 Mapper 接口，但它们的使用方式和上下文有所不同。

### @Mapper 注解

- **用途**：`@Mapper` 注解直接标记在 Mapper 接口上。
- **作用**：这个注解告诉 MyBatis，该接口是一个 Mapper 接口，MyBatis 在启动时会自动扫描这些标记了 `@Mapper` 的接口，并为它们创建代理对象。
- **优势**：使用 `@Mapper` 注解的主要优势是简单明了，直接在接口上声明，无需其他配置。
- **缺点**：需要在每个 Mapper 接口上单独添加注解，如果 Mapper 接口很多，可能会稍显麻烦。

### MapperScannerConfigurer 配置

- **用途**：`MapperScannerConfigurer` 是在 Spring 配置文件中配置的。
- **作用**：它用于指定一个包路径，Spring 启动时会扫描这个包及其子包下所有的接口，如果它们是 MyBatis 的 Mapper 接口，Spring 会为它们创建代理对象并加入到 IOC 容器中。
- **优势**：使用 `MapperScannerConfigurer` 的主要优势是集中管理，可以一次性扫描整个包路径下的所有 Mapper 接口，无需在每个接口上单独添加注解。
- **缺点**：配置较为复杂，需要在 Spring 的配置文件中进行配置。

### 相同点和不同点

- **相同点**：两者的最终目的都是让 Spring 容器管理 MyBatis 的 Mapper 接口，并为这些接口创建代理对象。
- **不同点**：使用方式不同，`@Mapper` 是注解方式，直接标记在接口上；而 `MapperScannerConfigurer` 是通过 XML 或 Java 配置的方式，在配置文件中指定扫描的包路径。

在 Spring Boot 项目中，通常推荐使用 `@Mapper` 或者使用 `@MapperScan` 注解在配置类上指定扫描的包路径，这两种方式更符合 Spring Boot 的自动配置和约定优于配置的理念。而在传统的 Spring 项目中，使用 `MapperScannerConfigurer` 可能更常见。

---

# 17 模糊查询'%%' 中间什么都不写默认是查询所有记录

-- 模糊查询'%%' 中间什么都不写默认是查询所有记录

SELECT * FROM `monster` WHERE `email` LIKE '%%'

---

# 18 在 MyBatis-Plus 或 MyBatis 中，配置项 `map-underscore-to-camel-case` 主要影响的是属性（字段）的命名映射，而不是类名与表名的映射。

---

# 19 mabatis报错：Result type not match for select id=“findMonsterByIdAndName“

![image-20231218175228558](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20231218175228558.png)

Monster类引错了，引到别的module下的Monster了，重新引入一下Monster即可，重新输入一下

Monster 两个module下都定义了com.hspedu.entity.Monster 导致引入冲突 报错



参考如下：

**mabatis报错：Result type not match for select id=“selectAll“**

![img](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBAaGVsbG9feV93b3JsZA==,size_20,color_FFFFFF,t_70,g_se,x_16.png)

检查发现返回类型没问题啊

![img](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBAaGVsbG9feV93b3JsZA==,size_18,color_FFFFFF,t_70,g_se,x_16.png)

映射文件里的返回类型也没问题

找了好久发现：原来我定一个两个Brand类，在不同的modul下。

![img](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBAaGVsbG9feV93b3JsZA==,size_12,color_FFFFFF,t_70,g_se,x_16.png) ![img](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBAaGVsbG9feV93b3JsZA==,size_12,color_FFFFFF,t_70,g_se,x_16-17028935847081.png)

 修改为TBrand后，不再报错：

![img](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBAaGVsbG9feV93b3JsZA==,size_14,color_FFFFFF,t_70,g_se,x_16.png)

 问题解决

---

# 20 @Bean注解标注的方法是可以有参数的

在Spring框架中，`@Bean`注解的方法可以有参数，这些参数表示该Bean的依赖。Spring容器会自动地为这些参数寻找合适的实例来注入。这是Spring的依赖注入（Dependency Injection, DI）功能的一个关键方面。具体来说：

1. **寻找合适的Bean进行注入**：
   - 当Spring容器创建一个由`@Bean`注解的方法定义的Bean时，它会检查这个方法的参数。
   - 对于每个参数，Spring容器会在其当前管理的Bean中寻找与参数类型相匹配的Bean。
   - 如果找到了合适的Bean，Spring容器就会将这个Bean注入作为参数。
2. **处理多个相同类型的Bean**：
   - 如果有多个相同类型的Bean可用，Spring容器需要额外的信息来确定使用哪一个。这可以通过指定Bean的名称或使用其他限定符（如`@Qualifier`注解）来实现。
3. **无法找到合适的Bean时的行为**：
   - 如果Spring容器无法找到匹配的Bean来注入，它通常会抛出异常，因为这通常表示配置错误或者所需的Bean尚未定义。
4. **使用`@ConfigurationProperties`进行细粒度控制**：
   - 有时，您可能会看到与`@Bean`一起使用`@ConfigurationProperties`注解。这用于将外部配置（如属性文件中的属性）绑定到Bean的属性上，进一步控制Bean的配置。

总的来说，`@Bean`注解的依赖注入机制使得在Spring中管理和配置Bean更加灵活和强大。





---

# 21 springboot vue整合 **前后端分离项目中的问题**

## 1 一般来说静态方法不可以使用泛型，为什么  public static <T> Tiger2<T> useT(T data){}可以使用泛型？

~~~
User

/**
 * 该类用于测试 在静态方法中使用泛型
 * @param <T>
 */
class Tiger2<T>{
    T data;

    public Tiger2() {
    }
    public <T> Tiger2(T t) {

    }
	//一般来说静态方法不可以使用泛型，这里为什么可以使用泛型？
    public static <T> Tiger2<T> useT(T data){
        Tiger2<T> tiger2 = new Tiger2<>(data);
        return tiger2;
    }
}
~~~

 **GPT:**

在 Java 中，静态方法可以使用泛型，但这些泛型参数是独立于类泛型参数的。让我们详细看一下您的例子以理解这一点。

在 `Tiger2` 类中，您定义了一个泛型类参数 `<T>`。但是，当您在静态方法 `useT` 中使用泛型 `<T>` 时，这里的 `<T>` 并不是类级别的泛型参数。它是方法级别的泛型参数，专门用于该方法。换句话说，类泛型参数 `<T>` 和方法泛型参数 `<T>` 是完全独立的，尽管它们恰好使用了相同的字母。

同样，在构造器 `public <T> Tiger2(T t) {}` 中，泛型 `<T>` 也是方法级别的（在这里是构造器级别），它与类级别的泛型 `<T>` 无关。这意味着，即使这是一个泛型类，这个构造器可以接受任何类型的参数，而与类级别的泛型 `<T>` 无关。

这个设计在某些情况下很有用，因为它允许静态方法操作不同类型的数据，而不依赖于类实例。在静态方法的上下文中，由于没有类实例，因此不可能使用类级别的泛型参数。因此，静态方法定义自己的泛型参数，这些参数在每次方法调用时都被独立地推断或指定。

在 `Tiger2` 的例子中，`useT` 方法允许创建任何类型的 `Tiger2` 实例，而与类本身的泛型参数无关。这是泛型在静态上下文中灵活应用的一个很好的例子。



> Tiger<T,R,L>类中的方法 **public static void show2(T t){}**
> Tiger2<T>类中的方法 **public static <T> Tiger2<T> useT(T data){}**
> ，public static void show2(T t){)会报错为什么，和加了泛型的标志<T>的useT方法的主要区别是什么？为什么加了<T>后就不报错了？

```
GPT:
在 Java 泛型中，类级别的泛型参数和静态方法之间存在一些关键的区别，这解释了为什么在 Tiger 类中某些静态方法的声明会导致错误，而其他则不会。

关于 public static void show2(T t){} 的问题
在 Tiger 类中，T, R, L 是类级别的泛型参数。这意味着这些泛型参数的具体类型与每个 Tiger 实例相关联。然而，静态方法和属性不属于任何实例，它们属于类本身。因此，静态方法或属性无法直接访问类级别的泛型参数，因为它们在类实例化之前就已经存在了，而这时泛型参数的类型尚未确定。

关于 public static <T> Tiger2<T> useT(T data){} 的区别
public static <T> Tiger2<T> useT(T data){} 方法声明中的 <T> 是一个方法级别的泛型参数。这意味着每次调用该方法时，都会为该方法定义一个新的、独立的泛型类型 T。这与类级别的泛型参数完全无关。因此，这种方式是允许的，因为静态方法定义了它自己的泛型参数，不依赖于类实例。

总结
public static void show2(T t){} 会报错，因为它试图使用类级别的泛型参数 T，而静态方法无法访问与类实例相关联的泛型类型。
public static <T> Tiger2<T> useT(T data){} 不会报错，因为这里的 T 是方法级别的泛型参数，独立于类级别的泛型参数。
这种设计是 Java 泛型的一个基本特性，旨在保持类型安全，同时确保静态成员的独立性和泛型方法的灵活性。
```

---



## 2 遇到Maven导入不进来报错Failed to read artifact descriptor for com.fasterxml:classmate:jar:1.5.1

![image-20231226154451743](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20231226154451743.png)

测试发现 即使导入其他依赖，比如 mybatis-plus-boot-starter 版本号 3.5.2 也导入失败

~~~
<dependency>
            <groupId>com.baomidou</groupId>
            <artifactId>mybatis-plus-boot-starter</artifactId>
            <!--<version>3.4.3</version>-->
            <version>3.5.2</version>
</dependency>
~~~

![image-20231226155514428](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20231226155514428.png)

解决参考文档https://stackoverflow.com/questions/41589002/failed-to-read-artifact-descriptor-for-org-apache-maven-pluginsmaven-source-plu

![image-20231226155609951](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20231226155609951.png)



![image-20231226160255345](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20231226160255345.png)

安装 maven helper插件

重新再导入几遍就好使了，注意网络连接有没有代理之类的



# 22 全局异常处理机制





## 1 如何在Spring Boot应用中使用`@ControllerAdvice`和`@ExceptionHandler`实现全局异常处理，以统一管理控制器层抛出的异常，并减少代码冗余同时提供一致的错误响应结构？



~~~java
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.WebRequest;
import org.springframework.http.ResponseEntity;

@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(MethodArgumentNotValidException.class)
    @ResponseBody
    public ResponseEntity<Map<String, String>> handleValidationExceptions(MethodArgumentNotValidException ex) {
        Map<String, String> errors = new HashMap<>();
        ex.getBindingResult().getAllErrors().forEach((error) -> {
            String fieldName = ((FieldError) error).getField();
            String errorMessage = error.getDefaultMessage();
            errors.put(fieldName, errorMessage);
        });
        return ResponseEntity.badRequest().body(errors);
    }

    @ExceptionHandler(Exception.class)
    @ResponseBody
    public ResponseEntity<String> handleGeneralException(Exception ex, WebRequest request) {
        return ResponseEntity
                .status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body("An internal error occurred: " + ex.getMessage());
    }
}

~~~



在 Spring Boot 应用中使用 `@ControllerAdvice` 与 `@ExceptionHandler` 实现全局异常处理是一种高效的方式来统一处理控制器层抛出的异常。这不仅可以减少代码冗余，还能提供一致的错误响应结构。现在，我将详细解释您的代码及其工作原理。

### 全局异常处理的工作原理

#### 1. 使用 `@ControllerAdvice`

`@ControllerAdvice` 注解是用来配置控制器的通知，意味着它提供了一个集中的位置，所有控制器抛出的异常都能在这里被处理。`@ControllerAdvice` 可以指定监听的包，如果没有指定，则默认监听所有包。这个类标记了 `@ResponseBody`，表明响应内容都将自动转化为 JSON 格式。

#### 2. 使用 `@ExceptionHandler`

`@ExceptionHandler` 注解用来定义具体处理异常的方法。这个方法可以定义多个，针对不同类型的异常进行处理。

#### 3. 返回 `R.error()`

在您的全局异常处理类 (`HsplivingExceptionControllerAdvice`) 中，`handleValidException` 方法处理 `MethodArgumentNotValidException` 类型的异常，通常这种异常是由于客户端提交的数据验证失败（使用了 Spring 的验证框架如 `@Validated`）时抛出的。 

方法内部：
- **日志记录**：首先可能会记录一些日志（这部分在代码中被注释掉了）。
- **错误信息收集**：收集所有字段验证失败的信息，并将其存储在一个 Map 中。
- **返回错误响应**：使用 `R.error()` 构建一个错误响应对象，这个对象包含错误代码、错误消息和详细的验证错误信息。

这里的 `R` 类似是一个响应构造器，它可能是一个自定义的响应体结构，通常包含如下几部分：
- 状态码（如 200、400、500）
- 消息（通常是错误消息或成功消息）
- 数据（返回给前端的任何相关数据）

### 返回数据到前端的过程

当一个异常被 `@ExceptionHandler` 捕获时：
1. **异常处理方法被调用**：对应的处理方法被调用，执行方法内部的代码。
2. **构建响应体**：方法执行完成后，返回的 `R` 对象会被 Spring MVC 转换为 JSON 格式的数据。这一转换是由 Spring MVC 内置的消息转换器（通常是 Jackson2HttpMessageConverter）完成的。
3. **发送响应到客户端**：JSON 数据作为 HTTP 响应的体（body）发送回客户端。

### 示例：错误处理流程

假设客户端提交了一个不符合验证要求的请求，`MethodArgumentNotValidException` 被抛出：

- 异常在控制器层被抛出。
- `@ControllerAdvice` 注册的类捕获此异常，`handleValidException` 方法被调用。
- 方法内收集错误详情，并使用 `R.error()` 创建含有这些信息的响应对象。
- 响应对象被转换为 JSON 格式，并作为 HTTP 响应返回给客户端。

这种方式确保了所有异常的处理都是统一和集中的，前端接收到的错误信息格式一致，便于处理和展示错误信息。







## 2 如何在Spring Boot应用中使用`@ControllerAdvice`实现全局异常处理，特别是在处理异常时使用Spring MVC的视图渲染机制返回错误页面，而非直接返回JSON格式的数据？



~~~java
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;

@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler({ArithmeticException.class, NullPointerException.class, AccessException.class})
    public ModelAndView handleArithmeticException(Exception ex, Model model) {
        model.addAttribute("error", ex.getMessage());
        return new ModelAndView("error/global");
    }
}

~~~



确实，您提供的这个全局异常处理类 (`GlobalExceptionHandler`) 与上面讨论的 JSON 响应方式不同，主要在于它使用了 Spring MVC 的视图渲染机制来返回错误页面，而不是返回 JSON 格式的响应数据。这里的处理方式更适合传统的 Spring MVC 应用，其中前端直接由服务器渲染，而非前后端分离的架构。让我们逐一解析这个类和它的功能：

### 功能解析

1. **@ControllerAdvice**
   - 这个注解将类标记为全局异常处理类，意味着它会拦截所有控制器抛出的异常（除非指定了特定的包或控制器）。

2. **@ExceptionHandler**
   - 这个注解用来指定该处理器可以处理哪些异常类型。在您的代码中，它被设置为处理 `ArithmeticException`, `NullPointerException`, 和 `AccessException`。这意味着只有这三种类型的异常会被这个方法处理。

3. **方法参数**
   - `Exception e`: 被捕获的异常对象。
   - `Model model`: 一个模型对象，用来向视图传递数据。
   - `HandlerMethod handlerMethod`: 当前处理请求的方法的相关信息，可以用来获取一些额外的方法级信息，比如方法名。

4. **异常信息处理**
   - 异常信息被记录到日志中。
   - 异常信息也被添加到模型中，这样它就可以在视图中被显示。

5. **视图渲染**
   - 返回的字符串指向一个视图名，这里是 `"error/global"` 或 `"/error/global"`。根据您的视图解析器配置，这会导向 `templates/error/global.html` 路径下的 Thymeleaf 模板或其他视图模板。

### 异常处理流程

当 `ArithmeticException`, `NullPointerException`, 或 `AccessException` 其中一种异常在控制器中被抛出时：
- Spring MVC 会寻找用 `@ExceptionHandler` 注解的方法来处理这些异常。
- `handlerAritException` 方法会被调用，传入异常对象、模型和处理方法的信息。
- 异常详情被记录并传递给视图。
- 方法返回视图名，Spring MVC 根据视图解析器配置解析该视图并渲染，最后将渲染后的 HTML 返回给客户端。

### 视图解析和路径问题

关于返回的视图路径：
- 在 Spring Boot 中，通常视图解析器配置了一个基础路径（默认是 `src/main/resources/templates`）和文件后缀（默认是 `.html`）。
- 因此，返回 `"error/global"` 通常足够了，视图解析器会自动寻找 `templates/error/global.html`。
- 如果添加了 `/` 前缀，效果应该是相同的，除非配置的视图解析器对此有特殊处理。

### 异常处理与请求转发

在您的描述中，提到异常处理过程类似于请求转发，但与传统的 Servlet 请求转发不同。确实，这种内部处理机制允许数据在服务器内部从异常处理器传递到视图渲染器，而不经过客户端重定向或额外的 HTTP 请求，提高了处理效率并减少了客户端所需的处理逻辑。

### 总结

这个全局异常处理器是为那些需要通过服务端渲染错误页面的应用设计的。它提供了一种结构化的方法来处理异常，确保用户在面对错误时能获得更友好的用户体验。对于前后端分离的应用，通常建议返回 JSON 对象，以便前端应用可以更灵活地处理异常展示。



~~~
~~~



## 3 如何在Spring Boot中使用`@RestControllerAdvice`实现针对RESTful API的全局异常处理，并如何通过自定义响应体和校验注解优化异常处理逻辑？

~~~java
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.validation.BindException;
import org.springframework.http.ResponseEntity;
import org.springframework.http.HttpStatus;

@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(Exception.class)
    public ResponseEntity<RespBean> handleGeneralException(Exception e) {
        return ResponseEntity
                .status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body(RespBean.error("General Error", "An error occurred: " + e.getMessage()));
    }

    @ExceptionHandler(BindException.class)
    public ResponseEntity<RespBean> handleBindException(BindException e) {
        return ResponseEntity
                .badRequest()
                .body(RespBean.error("Validation Error", e.getBindingResult().toString()));
    }

    @ExceptionHandler(GlobalException.class)
    public ResponseEntity<RespBean> handleGlobalException(GlobalException e) {
        return ResponseEntity
                .status(e.getStatus())
                .body(RespBean.error(e.getMessage(), e.getDetails()));
    }
}

public class RespBean {
    private String message;
    private String details;
    private HttpStatus status;

    public static RespBean error(String message, String details) {
        RespBean resp = new RespBean();
        resp.message = message;
        resp.details = details;
        resp.status = HttpStatus.BAD_REQUEST;
        return resp;
    }

    // Getters and Setters
}

public class GlobalException extends RuntimeException {
    private String details;
    private HttpStatus status;

    public GlobalException(String message, String details, HttpStatus status) {
        super(message);
        this.details = details;
        this.status = status;
    }

    // Getters and Setters
}

@Target({ElementType.FIELD})
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = IsMobileValidator.class)
public @interface IsMobile {
    String message() default "手机号码格式错误";
    boolean required() default true;
    Class<?>[] groups() default {};
    Class<? extends Payload>[] payload() default {};

    class IsMobileValidator implements ConstraintValidator<IsMobile, String> {
        private boolean required;

        @Override
        public void initialize(IsMobile constraintAnnotation) {
            required = constraintAnnotation.required();
        }

        @Override
        public boolean isValid(String value, ConstraintValidatorContext context) {
            if (required) {
                return ValidatorUtil.isMobile(value);
            } else {
                return !StringUtils.hasText(value) || ValidatorUtil.isMobile(value);
            }
        }
    }
}

~~~





### 在您提供的这个例子中，`GlobalExceptionHandler` 类使用了 `@RestControllerAdvice` 注解，这与 `@ControllerAdvice` 相似，但是专门用于构建 RESTful API，通常与 `@ResponseBody` 结合使用，直接返回数据而不是视图。这个处理器设计得更具体，针对不同类型的异常提供了不同的处理策略，并且返回的是自定义的响应体 `RespBean`。让我们逐一分析这个异常处理器的构成和功能：

#### 功能解析

1. **@RestControllerAdvice**
   - 这个注解将类标记为全局异常处理类，专用于 REST 控制器。它确保所有方法的返回结果都将自动序列化为 JSON 或其他 RESTful API 响应格式。

2. **@ExceptionHandler(Exception.class)**
   - 这个注解表示该方法可以处理所有的 `Exception` 类及其子类的实例。这是一个非常广泛的异常处理范围，通常在没有更具体的异常处理方法可用时使用。

3. **异常处理逻辑**
   - **GlobalException**: 特定类型的自定义异常，通常用于业务逻辑中的错误处理。这种异常包含一个 `RespBeanEnum`，用于定义具体的错误信息和状态码。
   - **BindException**: 处理表单绑定时发生的异常（例如，Spring MVC 中使用 `@Valid` 注解验证时）。这里将错误信息提取出来，并且构造一个具体的错误响应返回给前端。

4. **RespBean 类**
   - 这是一个用于构建响应的辅助类，可能包含状态码、消息和其他可能的数据载体。该类的设计应该支持错误和正常响应的构建。

5. **IsMobileValidator 类**
   - 一个自定义的校验器，用于校验是否为有效的手机号。这里体现了 Spring 的校验框架如何与自定义校验器结合使用。
   - 校验逻辑依据 `required` 字段确定是否强制校验，以及 `ValidatorUtil.isMobile` 方法的实现来判定手机号码的有效性。

#### 特定的异常处理逻辑

这个例子中的处理逻辑更细化，并且针对不同类型的异常提供了定制化的响应。这是高效处理 RESTful API 中异常的一个典型示例，因为它不仅仅返回通用的错误信息，还考虑到了业务逻辑中可能需要特别处理的异常类型（如 `GlobalException` 和 `BindException`）。

#### 自定义校验注解 `@IsMobile`

这个注解用于校验手机号码字段，它使用 `IsMobileValidator` 作为其校验器：
- **required** 属性决定是否必须校验手机号码。
- **message** 默认错误消息为 "手机号码格式错误"。

使用此注解可以非常灵活地在实体或 DTO 类中指定需要校验手机号的字段，极大地增强了代码的可读性和易用性。

#### 总结

通过这样的全局异常处理策略，您的应用可以很容易地区分处理不同类型的业务逻辑错误和系统错误，同时向客户端返回清晰、一致的错误响应格式。这对前后端分离的现代 Web 应用尤为重要，因为它允许前端开发者根据不同的错误代码和消息进行相应的界面处理，提高用户体验。

自定义校验注解的使用进一步提升了校验逻辑的封装性和复用性，使得手机号码这样的常见字段校验变得简洁明了。这些技术的结合使用，不仅可以减少冗余代码，还可以提升整个应用的稳定性和可维护性。



~~~
~~~



## 4 在典型的 Spring Boot 应用架构中，流程通常是从控制器层 (`Controller`) 接收请求，然后将业务逻辑处理委托给服务层 (`Service`)，服务层执行具体的业务逻辑后返回数据给控制器层，最后控制器层返回响应给前端。这是 MVC (Model-View-Controller) 模式的一种实现，确保了层次间的职责清晰分明。

#### 如何全局异常处理改变了这个流程

全局异常处理机制提供了一种集中处理异常的方式，这种方式确实有点“脱离”了正常的控制器->服务->控制器的响应流程。具体来说：

#### **正常流程**
1. **控制器层**：接收请求，调用服务层。
2. **服务层**：执行业务逻辑，处理数据。
3. **控制器层**：根据服务层的结果准备响应数据，返回给前端。

#### **发生异常时的流程**
1. **控制器层**：接收请求，调用服务层。
2. **服务层**：执行业务逻辑时可能抛出异常。
3. **全局异常处理器**：捕获并处理异常，直接返回错误响应给前端。

在发生异常时，一旦异常被抛出（无论是在控制器层还是服务层），它会被传递到调用栈直到遇到一个可以处理它的异常处理器。如果在控制器层或服务层内部没有捕获异常，全局异常处理器 (`@ControllerAdvice` 或 `@RestControllerAdvice`) 将捕获这些异常。**全局异常处理器的存在是为了确保应用可以优雅地处理所有未被捕获的异常，防止它们泄露到客户端并给客户端一个友好的错误反馈**。

### 全局异常处理的优点

- **集中管理错误处理逻辑**：可以在一个地方处理所有异常，避免在每个控制器或服务中重复错误处理代码。
- **保证错误响应的一致性**：全局异常处理可以确保应用程序中所有的错误响应都是一致的，这对前端开发者来说非常重要，因为他们可以根据统一的错误格式来处理错误情况。
- **提高代码的可维护性**：减少了每个方法内部处理异常的需要，代码更加简洁和易于管理。

### 示例解释

例如，如果服务层中的方法因为数据库问题抛出了一个 `DataAccessException`，在没有全局异常处理器的情况下，控制器需要捕获这个异常并自己构造错误响应。但如果配置了全局异常处理器，控制器层的代码就可以只关注于正常情况下的业务逻辑和数据流转，异常情况由全局处理器统一处理。

这样的设计模式不仅提高了代码的整洁性，还增强了系统的健壮性，使得异常处理更加系统化和规范化。在实际应用中，这种全局的错误处理机制被广泛认为是构建健壮、易于维护的大型应用的最佳实践之一。



## 5  全局异常处理器之所以可以直接给前端返回数据信息是因为有@ResponseBody注解的支持对吗？

全局异常处理器如何直接向前端返回数据，特别是在使用 `@ControllerAdvice` 或 `@RestControllerAdvice` 时，`@ResponseBody` 注解的作用是什么？

 在使用 `@ControllerAdvice` 或 `@RestControllerAdvice` 类定义全局异常处理器时，`@ResponseBody` 注解起着关键的作用。这个注解确保方法的返回值直接作为响应体返回给客户端，并且以 JSON 或其他媒体类型格式化，这通常是在构建 RESTful API 时所需要的。

**核心代码示例**

~~~java
@RestControllerAdvice
public class GlobalExceptionHandler {
    @ExceptionHandler(Exception.class)
    public RespBean handleException(Exception e) {
        return RespBean.error("发生错误: " + e.getMessage());
    }
}

~~~



### 详细解释

#### @ResponseBody 的作用

- **数据序列化**：`@ResponseBody` 注解告诉 Spring MVC 框架，方法的返回值应该直接写入 HTTP 响应体中，而不是解释为跳转路径或视图名。这意味着返回的对象将被自动转换成 JSON（或其他配置的格式，取决于内容协商策略）。
- **内容类型处理**：与 `@ResponseBody` 相关的还有 `HttpMessageConverter` 接口，Spring 使用这个接口的实现类来转换控制器方法的返回值，使其变为客户端可接受的形式，如 JSON、XML 等。

#### @RestControllerAdvice

- **结合 @ResponseBody**：`@RestControllerAdvice` 是 `@ControllerAdvice` 与 `@ResponseBody` 的结合体。使用 `@RestControllerAdvice` 注解的类中定义的所有方法自动使用 `@ResponseBody`，所以当你用这个注解时，不需要再显式添加 `@ResponseBody`。
- **适用场景**：这种处理方式非常适合于构建 RESTful API，其中所有的响应都是数据响应，而不是视图渲染。

#### **@ResponseBody 的作用**

- **数据序列化**：
  - `@ResponseBody` 注解指导 Spring MVC 框架将方法的返回值直接写入HTTP响应体中，而不是将返回值解释为跳转路径或视图名称。
  - 这意味着返回的数据对象将自动转换为 JSON（或根据内容协商策略配置的其他格式）。
- **内容类型处理**：
  - `HttpMessageConverter` 接口的实现用于将控制器方法的返回值转换成客户端可接受的格式，如 JSON、XML 等。
  - Spring MVC 根据请求的`Accept`头部信息来选择合适的`HttpMessageConverter`进行数据转换。

#### **@RestControllerAdvice 的优势**

- **自动使用 @ResponseBody**：
  - `@RestControllerAdvice` 是 `@ControllerAdvice` 和 `@ResponseBody` 的组合，确保在该类中定义的所有方法自动应用 `@ResponseBody`。
  - 使用这个注解后，不需要在每个方法上单独添加 `@ResponseBody`，简化了代码。
- **适用场景**：
  - 这种处理方式特别适合于构建RESTful API，其中所有响应都是数据响应，这有助于前后端分离的架构实现。

### **工作流程**

1. **异常捕获**：
   - 当应用中抛出任何未被局部异常处理器捕获的 `Exception` 类型异常时，`handleException` 方法将被触发。
2. **异常处理**：
   - 方法内部构建了一个 `RespBean` 实例，其中包含错误信息。这个实例根据方法的返回类型自动转换为 JSON 格式的响应体。
3. **数据返回**：
   - JSON 数据作为HTTP响应的主体直接返回给客户端，HTTP状态码根据需要设置（例如，400 Bad Request, 500 Internal Server Error等）。

### **示例解释**

在此示例中，如果在应用执行过程中抛出异常（如空指针异常、数组越界等），全局异常处理器中的 `handleException` 方法会处理这些异常。由于使用了 `@RestControllerAdvice`，无需额外使用 `@ResponseBody`，返回的 `RespBean` 对象会被自动转换为 JSON 格式并响应给客户端，使得错误处理流程既高效又易于管理。

### **结论**

通过使用 `@RestControllerAdvice` 和 `@ResponseBody`，全局异常处理器不仅简化了异常处理逻辑，而且提高了处理效率，确保了向前端返回的数据格式的一致性和准确性。这种机制极大地优化了现代Web应用架构的错误处理方式，使开发者可以更专注于业务逻辑的实现而非低级错误处理细节。这是构建高可维护、高可用Web应用的关键实践之一。



~~~
~~~



## 6 您提出的问题非常关键，确实，全局异常处理器的处理逻辑在某种程度上“脱离”了传统的 Spring MVC 控制器到服务层再回到控制器的流程。全局异常处理器（使用`@ControllerAdvice`或`@RestControllerAdvice`）提供了一种集中处理异常的机制，这种机制允许开发者在异常发生时，直接从处理器跳转到错误响应或错误页面，而不需要再经过常规的服务层处理。这样做的好处是提高了代码的复用性和清晰性，同时也保证了异常处理的一致性和可预测性。

~~~java
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.ui.Model;
import org.springframework.http.ResponseEntity;
import org.springframework.web.context.request.WebRequest;
import org.springframework.http.HttpStatus;

@ControllerAdvice
public class GlobalExceptionHandler {

    // 处理通用异常
    @ExceptionHandler(Exception.class)
    public ResponseEntity<String> handleAllExceptions(Exception ex, WebRequest request) {
        return new ResponseEntity<>("发生异常: " + ex.getLocalizedMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
    }

    // 处理特定异常，返回错误页面
    @ExceptionHandler({ArithmeticException.class, NullPointerException.class})
    public String handleArithmeticException(Exception ex, Model model) {
        model.addAttribute("error", "发生错误: " + ex.getLocalizedMessage());
        return "error/global"; // 返回到指定的错误页面
    }
}

~~~



#### 全局异常处理流程与传统流程的不同之处

#### 1. **控制流的中断和直接响应**

在传统的流程中：
- **控制器层**：接收请求，验证参数，然后调用服务层。
- **服务层**：执行业务逻辑，操作数据库等，然后将结果返回控制器层。
- **控制器层**：接收服务层结果，构建响应对象或视图模型，返回给客户端或转发到视图解析器。

在使用全局异常处理器的流程中：
- **异常发生**：在控制器或服务层执行过程中，一旦发生异常（如`ArithmeticException`或`NullPointerException`），正常的处理流程被中断。
- **异常捕获**：全局异常处理器捕获这些异常。不需要在每个控制器或服务方法中手动捕获。
- **处理并响应**：根据异常类型，异常处理器可能直接构造一个错误响应（如JSON格式的错误信息）或准备错误视图相关的数据并选择错误页面。这个过程不再回到原来的控制器方法。

#### 2. **错误视图的渲染而非数据处理**

在您的`GlobalExceptionHandler`示例中，异常处理方法返回一个视图名称，这意味着：
- **模型填充**：异常信息和可能的其他数据被填充到`Model`对象中。
- **视图选择**：返回的字符串指向一个视图（例如，`"error/global"`），这个视图名称被视图解析器处理。
- **视图渲染**：视图解析器（如Thymeleaf或JSP）根据视图名称找到相应的模板，渲染成HTML，然后返回给客户端。这个过程类似于请求转发，但是实质上是在异常处理流程中直接处理，不通过常规的控制器响应流程。

#### 3. **异常处理的优先级和处理方式**

- **优先级**：全局异常处理器具有高于默认错误页面（如Tomcat的`500.html`）的处理优先级。这意味着如果配置了全局异常处理器，它将处理所有未被局部处理器捕获的异常。
- **处理方式**：处理器中的逻辑可以非常灵活，支持多种异常类型，可以根据不同异常类型返回不同的错误页面或错误信息。



### **详细解答与工作原理**

#### **1. 使用 `@ControllerAdvice`**

- **作用**：`@ControllerAdvice` 注解允许您创建一个集中的异常处理器，该处理器会拦截所有控制器中抛出的异常。它可以指定作用的包或控制器，如果不指定，则默认应用于所有的包和控制器。
- **响应自动化**：此类可以使用`@ResponseBody`注解，确保所有响应内容自动转化为JSON格式，适合RESTful服务。

#### **2. 使用 `@ExceptionHandler`**

- **功能**：通过`@ExceptionHandler`指定哪些异常类型由哪个方法处理。可以定义多个方法处理不同类型的异常，提高处理的精确性和灵活性。

#### **3. 错误视图的渲染与直接响应**

- **错误视图渲染**：
  - **模型填充**：异常信息被添加到`Model`对象，可在视图中显示详细错误。
  - **视图解析**：返回的是视图名（如`"error/global"`），Spring MVC 使用视图解析器解析此名称，找到相应视图模板进行渲染，然后返回渲染后的HTML给客户端。
  - **请求转发特性**：此处理过程类似于内部请求转发，但不通过浏览器重定向，减少了客户端的处理负担。
- **直接响应**：
  - **响应构建**：对于非视图响应，如RESTful API，异常处理方法直接构造并返回`ResponseEntity`对象，包含错误信息和HTTP状态码，直接返回给客户端。

#### **4. 异常处理优先级与方法**

- **优先级管理**：全局异常处理器的处理优先级高于默认的错误页面（如Tomcat的`500.html`），确保应用可以自定义错误响应。
- **灵活性**：可以根据不同的异常类型，设计不同的处理逻辑和响应方式，包括错误页面的返回或JSON数据的返回。

总结

全局异常处理器提供了一种高效、集中的方式来处理应用中的异常，它通过中断常规的控制流并直接响应来优化错误处理流程。这种机制不仅减少了代码的重复，提高了代码的复用性和清晰性，而且确保了异常处理的一致性和可预测性，特别适用于需要高可维护性和可扩展性的大型应用。通过使用`@ControllerAdvice`或`@RestControllerAdvice`，开发者可以灵活地处理各种运行时异常，保证应用的稳定性和用户的良好体验。



----

## 7 全局异常问题总结

### 1. 基础全局异常处理器的创建与配置

### **问题描述**
如何在Spring Boot应用中创建并配置一个基础的全局异常处理器，用于捕获和处理应用中抛出的所有异常？

### **代码示例**
```java
@ControllerAdvice
public class BasicGlobalExceptionHandler {
    @ExceptionHandler(Exception.class)
    public ResponseEntity<String> handleAllExceptions(Exception ex) {
        return ResponseEntity
                .status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body("发生异常: " + ex.getMessage());
    }
}

```

### **详细解答**
**详细解答**: 在Spring Boot中，使用`@ControllerAdvice`注解定义一个全局异常处理类，可以包含一个或多个用`@ExceptionHandler`注解的方法，指定它们可以处理的异常类型。在上述代码中，`handleAllExceptions`方法被配置为处理所有类型的`Exception`，该方法返回包含错误信息的HTTP响应。

`@ExceptionHandler`指定的异常类型表示应用抛出这些类型的异常时，相应的方法将被调用。这种方式可以集中处理错误，提高代码的可维护性和响应结构的一致性。



### 2. 全局异常处理器如何直接返回前端数据

### **问题描述**
全局异常处理器如何处理异常并直接向前端返回数据？这种方法与传统的Controller到Service再到Controller的流程有何不同？

### **代码示例**
```java
@RestControllerAdvice
public class GlobalDataExceptionHandler {
    @ExceptionHandler(value = {NullPointerException.class})
    public ResponseEntity<String> handleNullPointerException(NullPointerException ex) {
        return ResponseEntity
                .badRequest()
                .body("发生空指针异常: " + ex.getMessage());
    }
}

```

### **详细解答**
使用`@RestControllerAdvice`（它结合了`@ControllerAdvice`和`@ResponseBody`），全局异常处理器的方法可以直接返回数据对象。Spring Boot会自动将这些对象序列化为JSON（或根据配置的其他格式）并发送到前端。

这种方法允许异常处理方法直接构造并返回响应体，简化了处理流程，提高了异常处理的效率和响应速度，同时也使得响应格式更加一致。

### 3. 使用@ResponseBody注解支持全局异常处理器直接返回数据

### **问题描述**
全局异常处理器之所以可以直接给前端返回数据信息，是因为有`@ResponseBody`注解的支持吗？

### **详细解答**
是的，您的理解是正确的。`@ResponseBody`注解确保方法的返回值直接作为响应体返回给客户端，并且以JSON或其他媒体类型格式化。这通常是在构建RESTful API时所需的。

`@ResponseBody`的作用主要是：
- **数据序列化**：告诉Spring框架，方法返回的对象应该被序列化为客户端接受的格式（如JSON），并直接写入HTTP响应体。
- **内容类型处理**：利用`HttpMessageConverter`接口的实现，Spring将返回值从Java对象转换为如JSON或XML的格式。

在`@RestControllerAdvice`中，`@ResponseBody`是隐含的，因此所有在`@RestControllerAdvice`注解的类中的方法都将自动使用`@ResponseBody`。这使得这些方法能够直接返回数据，而无需

进行额外的配置。



### **问题4: 全局异常处理的流程优化**

**问题描述**: 全局异常处理改变了传统的Controller-Service-Controller响应流程，请问这是如何实现的？

**详细解答**: 全局异常处理器提供了一种集中处理异常的方式，这允许在异常发生时，直接从处理器跳转到错误响应，而不需通过常规的服务层处理。这样的设计优化了处理流程，提高了代码复用性与清晰度，同时保证了异常处理的一致性和可预测性。

**异常处理流程与传统流程不同之处**:

- **控制流中断**：传统流程中，数据通过控制器层到服务层再返回控制器层。在使用全局异常处理器的流程中，一旦发生异常，该异常会直接由全局处理器捕获并处理，流程中断，直接返回错误响应。
- **直接响应**：异常处理器根据异常类型直接构造错误响应（如JSON格式的错误信息），而不是返回到原控制器方法。

#### 结论
通过集中管理异常处理，全局异常处理器不仅提高了代码的可维护性和一致性，还优化了应用的错误响应过程，使其更加高效和用户友好。这些处理器特别适合于构建大型和复杂的应用，可以显著减轻单个控制器或服务组件的负担，提高整体应用的错误处理能力。





# 23 关于导入了spring-boot-starter-parent依赖后，该项目是否就是一个springboot项目的探讨。

~~~

关于<parent>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-parent</artifactId>
    <version>3.0.5</version>
    <!-- 版本对应： https://start.spring.io/actuator/info -->
</parent>

上面这个依赖，是不是写上就能是的某个maven模块变为springboot项目呢？还是说必须导入下面的web场景启动器才行？只有导入了web场景启动器才能算是一个springboot模块/项目？
<!--导入web项目场景启动器: 会自动导入和web开发相关的所有依赖[库/jar]
后面老师还会说spring-boot-starter-web 到底引入哪些相关依赖
web项目场景启动器,这里是真正的引入了依赖
starter-web 版本不需要指定 在父工程已经指定好了
-->
<dependencies>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-web</artifactId>
    </dependency>
~~~



这是一个非常好的问题，也是很多 Spring Boot 初学者容易混淆的核心概念。您的理解既对也不对，我来为您详细拆解一下。

简单来说：

spring-boot-starter-parent 是为项目提供“能力规范和管理”，而 spring-boot-starter-web 这样的场景启动器是为项目提供“具体功能”。

------



### 1. `spring-boot-starter-parent` 的作用：奠定基础 (是项目，但很空)



当你声明了 `<parent>` 并指向 `spring-boot-starter-parent` 时，你的 Maven 模块**确实已经具备了 Spring Boot 项目的核心特征**，但它是一个没有任何“业务功能”的空壳。

`parent` 主要为你做了四件大事：

1. **依赖版本管理 (最重要的)**：
   - 它内部定义了一个巨大的列表（技术上称为 Bill of Materials, BOM），里面包含了几乎所有常用开源库（如 Spring Framework, Jackson, Tomcat, Hibernate 等）的**最佳兼容版本**。
   - **效果**：正因为如此，你在下面引入 `spring-boot-starter-web` 或者其他依赖时，才**不需要写 `<version>` 标签**。Maven 会自动从 `parent` 中找到那个已经为您测试和匹配好的版本，极大地避免了版本冲突的噩梦。
2. **默认插件管理**：
   - 它预先配置了一些必要的 Maven 插件，其中最重要的就是 `spring-boot-maven-plugin`。
   - **效果**：这个插件能让你轻松地将项目打包成一个可执行的 "fat JAR"（包含所有依赖的 JAR 包），并能通过 `mvn spring-boot:run` 命令来启动项目。没有这个，你就无法方便地打包和运行 Spring Boot 应用。
3. **资源过滤和编码**：
   - 它默认使用 UTF-8 编码，并配置了资源文件的处理规则（例如，`application.properties` 或 `application.yml` 中的 `@...@` 占位符可以被 Maven 属性替换）。
4. **默认 Java 版本**：
   - 它会为你指定一个默认的 Java 编译器级别。例如在 Spring Boot 3.x 中，它强制要求 Java 17 或更高版本。

所以，只添加了 `<parent>` 的项目，可以说是一个**“配置好、有规范、待激活”**的 Spring Boot 项目。它知道用什么版本的依赖，知道如何打包，但它不知道自己要干什么。



### 2. `spring-boot-starter-*` 的作用：添加功能 (让项目活起来)



场景启动器（Starters）是 Spring Boot “约定优于配置”理念的核心体现。

1. **依赖“全家桶”**：
   - `spring-boot-starter-web` 本身没有太多代码，它的主要作用是作为一个“依赖集合”。一旦你引入它，它会通过 Maven 的传递性依赖，自动帮你把 Web 开发所需要的所有库都引入进来，例如：
     - `spring-web` 和 `spring-webmvc` (Spring MVC 核心)
     - `spring-boot-starter-json` (用于 JSON-Java 对象转换，内含 Jackson 库)
     - `spring-boot-starter-tomcat` (内置的 Tomcat 服务器)
     - 等等...
2. **激活自动配置 (最重要的)**：
   - Spring Boot 的魔法在于“自动配置”（Auto-configuration）。当 Spring Boot 在项目的 classpath（类路径）中检测到特定类的存在时（例如检测到 Tomcat 和 Spring MVC 的类），它就会自动为你配置好相关的 Bean。
   - **效果**：你只加了一个 `spring-boot-starter-web` 依赖，Spring Boot 就自动帮你配置好了 `DispatcherServlet`、嵌入式 Tomcat 服务器、字符编码过滤器等所有 Web 环境需要的东西。你什么都不用做，项目就能启动并监听端口了。



### 总结与回答



- **只写 `<parent>` 是不是就能使模块变为 Spring Boot 项目？**
  - **是**，从构建和管理上来说，它已经是了。它遵循了 Spring Boot 的规范。
  - **但不是**，从功能上来说，它是个空项目，无法运行任何有意义的业务。它就像一台有操作系统但没装任何软件的电脑。
- **是不是必须导入 `web` 场景启动器才行？**
  - **不一定非得是 `web`**，但必须导入**至少一个场景启动器**或能触发自动配置的依赖，才能让项目具备具体的功能。
  - 如果你想做一个 Web 应用，你就必须导入 `spring-boot-starter-web`。
  - 如果你想做一个只连接数据库进行批处理的命令行工具，你可以导入 `spring-boot-starter-jdbc` 或 `spring-boot-starter-data-jpa`，而不需要 `web`。
  - 如果你只想做一个最简单的“Hello World”命令行程序，你甚至可以只依赖 `spring-boot-starter` (这是所有 starter 的基础)，然后写一个 `CommandLineRunner` 的实现类。

**最终结论：**

一个**完整且有意义**的 Spring Boot 项目 = `spring-boot-starter-parent` (提供基础和管理) + **至少一个** `spring-boot-starter-*` 场景启动器 (提供具体功能并激活自动配置)。
