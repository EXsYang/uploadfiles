# 0 报错问题

## 1  tomcat运行中 IDEA异常关闭

解决方法：重启电脑

tomcat运行中 IDEA异常关闭，再次启动tomcat 会报告

端口占用，打开任务管理器关闭一个java.exe tomcat可以正常启动

但是debug 任然提示端口被占用

Error running 'Tomcat 8.0.50-springmvc': Unable to open debugger port (127.0.0.1:54156): java.net.BindException "Address already in use: NET_Bind"

![image-20230926231655259](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230926231655259.png)

![image-20230926231341481](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230926231341481.png)





---

## 2 springmvc  RequestMapping 设置的路径重复 报错的细节说明	

```java
/*
    注意 1.即使是在不同的类中定义了相同的路径也不可以 启动tomcat时会报错
            Invocation of init method failed; nested exception is java.lang.IllegalStateException: Ambiguous mapping. Cannot map 'bookHandler' method
            com.hspedu.web.rest.BookHandler#successGenecal()
            to { [/user/success]}: There is already 'userHandler' bean method
            com.hspedu.web.UserHandler#successGenecal() mapped.
        2. 设置的value 中的路径如果相同 但是 method 不同,也可以，不会报错 如下面这两种设置
             //@PutMapping(value = "/book/{id}")
             //@DeleteMapping(value = "/book/{id}")
*/

//下面这个路径在com.hspedu.web.rest.BookHandler 中也定义了 会报错
//@RequestMapping(value = "/success")
//public String successGenecal() {
//    return "success"; //由该方法 转发到 success.jsp 页面
//}
```



---

## 3 判断int 和 null 等等 ==  , 会报空指针异常

```
// 判断int 和 null 等等 ==  , 会报空指针异常
//int t = 2;
//Integer x = null;
//System.out.print("t == x:");
//System.out.println( t == x);
```

```
java.lang.NullPointerException
	com.hspedu.web.homework.LoginHandler.doLogin(LoginHandler.java:42)
```



```
// 判断user的密码是否为123
if ( 123 == user.getPwd() ){// 此处pwd 为null时,会报空指针异常
//if ( "123".equals(user.getPwd())){ 
    return "login_ok";
}
```



---

# 4 反射暴破需要用要设置的类的属性或者是方法进行 不能使用clazz对象

```
declaredField.setAccessible(true);
```







---





# 1 传统方式通过右键项目 Add Frameworks Support 导入包细节

它有一个默认的路径

![image-20230924161923736](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230924161923736.png)

![image-20230924161341196](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230924161341196.png)

 

---

# 2 Java Web项目的lib包为什么要放到WEB-INF目录下？

在javaweb项目中，我们常常会导入项目所需要的 jar 包，那为什么 javaweb 项目的 jar 包一定要放到 WEB-INF/lib 目录下？

1）src 下的源文件（如：.java）经过了编译之后放在 WEB-INF/classes 目录下

2）lib 包在编译前需要放在 WEB-INF 下编译后才能出现在 WEB-INF/lib 目录下，所以除了 tomcat 自带的 jar 包（JRE）外，项目所需 jar 包都应放在 WEB-INF 的 lib 目录下，否则部署的web项目就会缺少lib包

Tomcat默认的路径就是WEB_INF这个目录下的lib

~~~
注意：这个文件夹名不是必须叫lib，但如果一个webapp需要第三方的jar包的话，这个jar包要放到这个lib目录下，这个目录的名字也不能随意编写，必须是全部小写的lib 例如，java语言连接数据库需要数据库的驱动jar包，那么这个jar包就一定要放到lib目录下，这是Servlet规范中规定的

自己测试的idea中写成libs也不会出错 但是有人说eclipse 会报错
所以还是写lib
~~~



![image-20230924164004769](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230924164004769.png)



![image-20230924165642468](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230924165642468.png)



![image-20230924172236036](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230924172236036.png)

![image-20230924172413240](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230924172413240.png)

![image-20230924172847048](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230924172847048.png)

对第四步中 的解释 

通过自己测试可以发现 ，使用servlet 的相关功能不会出现异常，即servlet不属于第三方的，但是使用第三方的就会出现异常，如下面第三个笔记测试的结果可以证明这点

---

# 3 接上一个问题的测试（测试WEB-INF 下lib写成libs）java.lang.NoClassDefFoundError: Could not initialize class com.hspedu.servlet.utils.JDBCUtilsByDruid

 数据库不能创建连接 会抛出异常 java.lang.NoClassDefFoundError: 

```
java.lang.NoClassDefFoundError: com/alibaba/druid/pool/DruidDataSourceFactory
	com.hspedu.servlet.utils.JDBCUtilsByDruid.<clinit>(JDBCUtilsByDruid.java:34)
	com.hspedu.servlet.test.testServlet.doPost(testServlet.java:26)
	com.hspedu.servlet.test.testServlet.doGet(testServlet.java:33)
	javax.servlet.http.HttpServlet.service(HttpServlet.java:622)
	javax.servlet.http.HttpServlet.service(HttpServlet.java:729)
	org.apache.tomcat.websocket.server.WsFilter.doFilter(WsFilter.java:52)
```



![image-20230924194423211](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230924194423211.png)

![image-20230924194527871](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230924194527871.png)



解决方法

**将WEB-INF 下的文件夹名 libs 改为lib**	rebuild + restart项目

![image-20230924194931587](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230924194931587.png)

---

# 4 add Framework Support 方式生成web项目配置 spring xml文件细节

<img src="https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230924200822550.png" alt="image-20230924200822550" style="zoom: 67%;" />

![image-20230924201011738](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230924201011738.png)

![image-20230924200739038](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230924200739038.png)

![image-20230924201052101](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230924201052101.png)

![image-20230924201143105](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230924201143105.png)

![image-20230924201216419](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230924201216419.png)

![image-20230924201241882](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230924201241882.png)

![image-20230924201348568](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230924201348568.png)

---





![image-20230924210458748](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230924210458748.png)



---

# 5  在常规web项目中 WEB-INF 目录下的xml 文件删除 后进行rebuild+restart项目 ，out目录下没有同步更新 仍然有该文件

# 注意该细节



如果是WEB-INF 文件夹下新复制进来/新创建了一个文件 通过rebuild+restart

可以同步更新到out目录

如果是WEB-INF 文件夹下删除了一个文件 通过rebuild+restart

不可以同步更新到out目录 即out目录下仍然会存在该文件 此时需要手动删除该文件

总结：新增文件时可以通过rebuild+restart 和热加载方式更新文件 这两个位置的文件都会同步新增

​			删除文件时可以通过rebuild+restart 和热加载方式更新文件  src目录下的文件都会同步删除对应的out目录下的文件和空文件夹(但会保留下out/production/springmvc[项目文件名]这个文件夹 即使该文件夹下的目录结构都是空的包) 

​	删除文件时可以通过热加载方式更新文件  WEB-INF目录下的文件都会同步删除对应的out目录下的文件和空文件夹(但会保留下out/production/springmvc[项目文件名]这个文件夹 即使该文件夹下的目录结构都是空的包) 

rebuild+restart方式WEB-INF目录下的文件不都会同步删除对应的out目录下的文件 要想同步删除out目录下的WEB-INF目录下的该文件   就需要手动删除一下

 		重新发布项目的方式不会更新该文件即不会同时删除out目录下的文件

​		**重新发布项目的方式不会更新该文件的文件名**

工作目录的***文件名修改*** **热加载**会同步更新运行目录下  修改后的文件的文件名！！！

**但是失去焦点通过热加载后，这两个位置(WEB-INF目录下 和 src目录下)都同步更新了jsp文件和xml文件，Java文件对应的class文件 		 **







![image-20230924221424901](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230924221424901.png)

![image-20230924221439700](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230924221439700.png)



---

# 6 SpringMVC 工作流程分析

 

1 浏览器发出http请求 到 中央控制器/前端控制器/分发控制器

2 中央控制器 调用处理器映射器 HandlerMapping

3 处理器映射器 返回处理器执行器链 HandlerExecutionChain 

【HandlerExecutionChain 处理器执行器链 - HandlerInterceptor-拦截器[多个]-Handler】

4 中央控制器 调用处理器适配器 HandlerAdapter 

5 处理器适配器调用 处理器Handler 就是Controller 接着调用Service DAO DB

6 处理器Handler返回 ModelAndView 给 处理器适配器HandlerAdapter 

7 处理器适配器HandlerAdapter 返回 ModelAndView 给中央控制器DispatcherServlet

8 中央控制器DispatcherServlet 调用视图解析器 ViewResolver

9 视图解析器返回View 给中央控制器DispatcherServlet

10 视图渲染 即将Model中的数据填充到View 视图：html/jsp/freemarker/thymeleaf

11 返回响应

![image-20230925190811661](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230925190811661.png)

---

# 7 [idea Spring配置提示: File is included in 4 contexts](https://www.cnblogs.com/lifuliang/p/14343473.html)

问题描述：

spring配置文件上面提示：

mvc application context in module studyDemo file is included in 4 contexts

导致原因：因为所有的配置文件都没有放在同一个上下文中

所谓File is included in 4 contexts是因为spring的配置文件放在了多个上下文中，只需找到以上位置，然后保留一个spring的上下文就OK了。

![img](https://img2020.cnblogs.com/blog/2220724/202101/2220724-20210129101724593-547486739.jpg)

 



 

 

![img](https://img2020.cnblogs.com/blog/2220724/202101/2220724-20210129101732658-1144165949.png)

 

 

 

![img](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/2220724-20210129101735678-2068586583.png)

 

 

解决方法：点击项目右键选择Open Moudle Setting 或者 F12 —>打开Project Structure —> 选择Modules -> 选择Spring ->先点减号把之前的都删除掉 ->然后点加号直选点项目 全部添加就好

---

# 8 对于Maven 的web项目而言  生成的resource目录就是它的类路径clsspath

![image-20230929150858544](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230929150858544.png)

---

# 9 [Java中getResourceAsStream的用法](https://www.cnblogs.com/macwhirr/p/8116583.html)

**首先，Java中的getResourceAsStream有以下几种：** 
\1. Class.getResourceAsStream(String path) ： path 不以’/'开头时默认是从此类所在的包下取资源，以’/'开头则是从ClassPath根下获取。其只是通过path构造一个绝对路径，最终还是由ClassLoader获取资源。 

\2. Class.getClassLoader.getResourceAsStream(String path) ：默认则是从ClassPath根下获取，path不能以’/'开头，最终是由ClassLoader获取资源。 

\3. ServletContext. getResourceAsStream(String path)：默认从WebAPP根目录下取资源，Tomcat下path是否以’/'开头无所谓，当然这和具体的容器实现有关。 

\4. Jsp下的application内置对象就是上面的ServletContext的一种实现。 

**其次，getResourceAsStream 用法大致有以下几种：** 

第一： 要加载的文件和.class文件在同一目录下，例如：com.x.y 下有类me.class ,同时有资源文件myfile.xml 

那么，应该有如下代码： 

me.class.getResourceAsStream("myfile.xml"); 

第二：在me.class目录的子目录下，例如：com.x.y 下有类me.class ,同时在 com.x.y.file 目录下有资源文件myfile.xml 

那么，应该有如下代码： 

me.class.getResourceAsStream("file/myfile.xml"); 

第三：不在me.class目录下，也不在子目录下，例如：com.x.y 下有类me.class ,同时在 com.x.file 目录下有资源文件myfile.xml 

那么，应该有如下代码： 

me.class.getResourceAsStream("/com/x/file/myfile.xml"); 

总结一下，可能只是两种写法 

第一：前面有 “  / ” 

“ / ”代表了工程的根目录，例如工程名叫做myproject，“ / ”代表了myproject 

me.class.getResourceAsStream("/com/x/file/myfile.xml"); 

第二：前面没有 “  / ” 

代表当前类的目录 

me.class.getResourceAsStream("myfile.xml"); 

me.class.getResourceAsStream("file/myfile.xml"); 

**最后，自己的理解：** 
getResourceAsStream读取的文件路径只局限与工程的源文件夹中，包括在工程src根目录下，以及类包里面任何位置，但是如果配置文件路径是在除了源文件夹之外的其他文件夹中时，该方法是用不了的。



---

# Java的Class.getClassLoader().getResourceAsStream()与Class.getResourceAsStream()理解

两者都可以实现从classPath路径读取指定资源的输入流。

为什么是classPath而不是src，这是因为web项目运行时,IDE编译器会把src下的一些资源文件移至WEB-INF/classes，classes目录就是classPath目录。该目录放的一般是web项目运行时的class文件、资源文件(xml,properties等)。

1. Class.getClassLoader().getResourceAsStream()
Class是当前类的Class对象，Class.getClassLoader()是获取当前类的类加载器。类加载器的大概作用是当需要使用一个类时，加载该类的".class"文件，并创建对应的class对象，将class文件加载到虚拟机的内存。getResourceAsStream()是获取资源的输入流。类加载器默认是从classPath路径加载资源。

因此，当使用Class.getClassLoader.getResourceAsStream()加载资源时，是从classPath路径下进行加载，放在resources下的文件加载时不能加（“/”）。

![image-20230930232647577](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230930232647577.png)

~~~java
InputStream in = PropertiesUtil.class.getClassLoader().getResourceAsStream("xx.properties");
~~~




2. Class.getResourceAsStream()

  ~~~
  //当前类的URI目录，不包括自己
  Class.getResourceAsStream("");
  //当前的classpath的绝对URI路径
  Class.getResourceAsStream("/");
  ~~~

  

  

  在使用 Class.getResourceAsStream()时，一定注意要加载的资源路径与当前类所在包的路径是否一致【使用时注意子目录】。
  （1）要加载的资源路径与当前类所在包的路径一致

  ![image-20230930232713311](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230930232713311.png)

~~~
InputStream in = PropertiesUtil.class.getResourceAsStream("xx.properties");

~~~

（2）要加载的资源路径在resources下

![image-20230930232726764](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230930232726764.png)

~~~
InputStream in = PropertiesUtil.class.getResourceAsStream("/xx.properties");
~~~

---



# 10 class.getResource() 和 classLoader.getResource() 是不同的

类的加载器中的

```
public URL getResource(String name) {
```

Class对象中的 

```
public java.net.URL getResource(String name) {


String path = HspTomcatV3.class.getResource("/").getPath();
```



```java
参考代码位置：
D:\Java_developer_tools\javase\JavaSenior2\day8\src\com\hsp\io\FileInformation.java
D:\Java_developer_tools\javaweb\jiaju_mall\src\com\hspedu\furns\utils\JDBCUtilsByDruid.java
D:\Java_developer_tools\javaweb\hsptomcat\ydtomcat\src\main\java\com\hspedu\tomcat\HspTomcatV3.java
D:\Java_developer_tools\ssm\my_spring\spring\src\com\hspedu\spring\annotation\HspSpringApplicationContext.java
    
            /*
         * 结论：默认情况下 是把 out module 的根目录 当作默认的类加载路径 即out/production/day8/
         * 但是Class.getResource() 可以只放一个斜杠 / class.getResource("/") 来获取项目当前的真实的
         * 运行路径 根路径
         * 而classLoader.getResource("/") 不可以放入一个斜杠 会返回一个Null 
但是在Tomcat下path是否以’/'开头无所谓，可以以斜杠开头也可以不以斜杠开头 都可以获取到项目的加载路径
即在Tomcat下可以 使用classLoader.getResource("/")
获取到类加载路径 //classPath= file:/D:/Java_developer_tools/ssm/my_springmvc/hsp_springmvc/target/my_springmvc/WEB-INF/classes/  
         
         * classLoader.getResource("/") 这种方式只可以写相对路径 路径前不可以写斜杠 而是从
         * 运行路径下直接写 即 classLoader.getResource("com/hsp/io/FileInformation.class")
         *
         * 而 Class.getResource() 需要在路径前提供一个斜杠才能解析到
         *  class.getResource("/com/hsp/io/FileInformation.class")
         * 不可以写相对路径前面不加斜杠
         *
         * */
    

 public static void main(String[] args) {
        // 1.得到类的加载器 使用任何一个类的.class 都可以得到类的加载器
        ClassLoader classLoader = FileInformation.class.getClassLoader();

        // 2.通过类的加载器获取到要扫描的包的资源 url
        // classLoader.getResource("com/hspedu/spring/component"); 默认是按照斜杠 / 来间隔各级文件目录的

        /*
         * 下面返回为null 在这里 即不可以写绝对路径 也不可写/   在手写hsptomcat 时 写的是
         * String path = HspTomcatV3.class.getResource("/").getPath();// 得到的是工作目录，而不是源码目录
         * System.out.println("path= " + path);
         * 这里的区别是
         * 手写tomcat时 是用 class对象.getResource() 返回的是也是URL对象
         * 类加载器.getResource() 返回的是URL对象
         * 但是用法不同 加载器中的 不可以写 "/" 和 绝对路径
         * */
        URL resource = classLoader.getResource("/"); // null
        URL resource2 = classLoader.getResource("day8/com/hsp/io"); // null
        URL resource3 = classLoader.getResource("/com/hsp/io"); // null
        URL resource4 = classLoader.getResource("com/hsp/io"); //
        URL resource5 = classLoader.getResource("com/hsp/io/FileInformation.java"); // null
        URL resource6 = classLoader.getResource("com/hsp/io/FileInformation.class"); //
        URL resource7 = classLoader.getResource("day8/com/hsp/io/FileInformation.class"); // null
        System.out.println("resource= " + resource);// null
        System.out.println("resource2= " + resource2);// null
        System.out.println("resource3= " + resource3);// null
        System.out.println("resource4= " + resource4);// resource4= file:/D:/Java_developer_tools/javase/JavaSenior2/out/production/day8/com/hsp/io
        System.out.println("resource5= " + resource5);// resource5= null
        System.out.println("resource6= " + resource6);// resource6= file:/D:/Java_developer_tools/javase/JavaSenior2/out/production/day8/com/hsp/io/FileInformation.class
        System.out.println("resource7= " + resource7);// resource7= null
        /*
        * 结论：默认情况下 是把 out module 的根目录 当作默认的类加载路径 即out/production/day8/
        * */

        //String resourcePath = classLoader.getResource("/").getPath(); // NullPointerException


        System.out.println("=========================");

        URL classResource = FileReader.class.getResource("/"); // classResource= file:/D:/Java_developer_tools/javase/JavaSenior2/out/production/day8/
        URL classResource2 = FileReader.class.getResource("src/com/hsp/io/FileInformation"); // classResource2= null
        // 绝对路径 放进去 得不到 返回null 下面这两种方式的绝对路径 都不行
        URL classResource3 = FileReader.class.getResource("file:/D:\\Java_developer_tools\\javase\\JavaSenior2\\day8\\src\\com\\hsp\\io"); // classResource3= null
        //URL classResource3 = FileReader.class.getResource("D:\\Java_developer_tools\\javase\\JavaSenior2\\day8\\src\\com\\hsp\\io"); // classResource3= null

        URL classResource4 = FileReader.class.getResource("/com/hsp/io/FileInformation.java"); // classResource5= null
        URL classResource5 = FileReader.class.getResource("/com/hsp/io/FileInformation.class"); // 这个格式正确！！ classResource4= file:/D:/Java_developer_tools/javase/JavaSenior2/out/production/day8/com/hsp/io/FileInformation.class
        URL classResource6 = FileReader.class.getResource("com/hsp/io/FileInformation.class"); // 这个格式不对 需要使用/ 开头 解析成项目真实的运行路径
        URL classResource7 = FileReader.class.getResource("day8/com/hsp/io/FileInformation.class"); // classResource6= null
        System.out.println("classResource= " + classResource); // file:/D:/Java_developer_tools/javase/JavaSenior2/out/production/day8/
        System.out.println("classResource2= " + classResource2); // null
        System.out.println("classResource3= " + classResource3); // null
        System.out.println("classResource4= " + classResource4); // null
        System.out.println("classResource5= " + classResource5); // file:/D:/Java_developer_tools/javase/JavaSenior2/out/production/day8/com/hsp/io/FileInformation.class
        System.out.println("classResource6= " + classResource6); // classResource6= null
        System.out.println("classResource7= " + classResource7); // classResource7= null
        /*
         * 结论：默认情况下 是把 out module 的根目录 当作默认的类加载路径 即out/production/day8/
         * 但是Class.getResource() 可以只放一个斜杠 / class.getResource("/") 来获取项目当前的真实的
         * 运行路径 根路径
         * 而classLoader.getResource("/") 不可以放入一个斜杠 会返回一个Null
         * classLoader.getResource("/") 这种方式只可以写相对路径 路径前不可以写斜杠 而是从
         * 运行路径下直接写 即 classLoader.getResource("com/hsp/io/FileInformation.class")
         *
         * 而 Class.getResource() 需要在路径前提供一个斜杠才能解析到
         *  class.getResource("/com/hsp/io/FileInformation.class")
         * 不可以写相对路径前面不加斜杠
         *
         * */

    }

@Test
public void test1(){
    //先创建文件对象
    File file = new File("e:\\news1.txt");

    //调用相应的方法，得到对应的信息
    System.out.println("文件名：" + file.getName());
    System.out.println("文件绝对路径：" + file.getAbsolutePath());
    System.out.println("文件父级目录：" + file.getParent());
    System.out.println("文件大小(字节)：" + file.length());
    System.out.println("文件是否存在：" + file.exists());
    System.out.println("是否为文件：" + file.isFile());
    System.out.println("是否是一个目录:" + file.isDirectory());//文件夹


    // 下面类似的方式 在hsptomcat 中也写了 还有jiaju_mall项目中也有少量应用

    /*
     * 下面返回为null 在这里 即不可以写绝对路径 也不可写/   在手写hsptomcat 时 写的是
     * String path = HspTomcatV3.class.getResource("/").getPath();// 得到的是工作目录，而不是源码目录
     * System.out.println("path= " + path);
     * 这里的区别是
 		 加载器中的 不可以写 "/" 和 绝对路径
     * 
     * jiaju_mall 项目中的使用方式是类的加载器.getResourceAsStream()
     *  //因为我们是web项目，他的工作目录在out, 文件的加载，需要使用类加载器
        //找到我们的工作目录
        properties.load(JDBCUtilsByDruid.class.getClassLoader().getResourceAsStream("druid.properties"));
     * */

    // 1.得到类的加载器 使用任何一个类的.class 都可以得到类的加载器
    ClassLoader classLoader = FileInformation.class.getClassLoader();

    // 2.通过类的加载器获取到要扫描的包的资源 url
    // classLoader.getResource("com/hspedu/spring/component"); 默认是按照斜杠 / 来间隔各级文件目录的
    URL resource = classLoader.getResource("/"); // null
    String resourcePath = classLoader.getResource("/").getPath();
    System.out.println("resource= " + resource);
    System.out.println("resourcePath= " + resourcePath);

    //File file2 = new File(resource.getPath());
    //        //if (file2.isDirectory()){
    //        //    File[] files = file2.listFiles();
    //        //    for (File f : files) {
    //        //        System.out.println("============");
    //        //        System.out.println(f.getAbsolutePath());
    //        //    }
    //        //}
}
```

## url.getPath() / url.getFile() 可以去除前缀file:

```

URL classGetResource = this.getClass().getResource("/");
System.out.println("classGetResource= " + classGetResource);
// url.getPath() / url.getFile() 可以去除前缀file:
String classGetResourcePath = classGetResource.getPath();
System.out.println("classGetResourcePath= " + classGetResourcePath);
String classGetResourceFile = classGetResource.getFile();
System.out.println("classGetResourceFile= " + classGetResourceFile);
```

~~~
输出的结果如下：
classGetResource= file:/D:/Java_developer_tools/ssm/my_springmvc/hsp_springmvc/target/test-classes/
classGetResourcePath= /D:/Java_developer_tools/ssm/my_springmvc/hsp_springmvc/target/test-classes/
classGetResourceFile= /D:/Java_developer_tools/ssm/my_springmvc/hsp_springmvc/target/test-classes/
~~~





---

# 11 form表单 如果用的是post方式提交表单 服务器端需要进行中文乱码的处理



~~~html
<h1>登录页面</h1>
<form action="/monster/login">
    <%-- form表单使用post 方式提交表单 后端如果没有使用  request.setCharacterEncoding("utf-8");
     进行处理 得到的中文是乱码 ,但是如果使用的是get 方式 提交表单 后端就不会出现中文乱码问题
     结论 form表单 如果用的是post方式提交表单 服务器端需要进行中文乱码的处理
     --%>
<form action="/monster/login" method="post">

    妖怪名： <input type="text" name="mName"> <br/>
    <input type="submit" value="提交登录" >

</form>
~~~



---

# 12 获取真正的运行环境 工作目录的方式

```java
URL resource = XMLParser.class.getResource("/");
        String resourcePath = XMLParser.class.getResource("/").getPath();
        URL resource2 = XMLParser.class.getClassLoader().getResource("");
        String resourcePath2 = XMLParser.class.getClassLoader().getResource("").getFile();


        System.out.println("真实的运行目录 工作目录是resource= " + resource);
        System.out.println("resourcePath= " + resourcePath);
        System.out.println("真实的运行目录 工作目录是resource2= " + resource2);
        System.out.println("resourcePath2= " + resourcePath2);


运行结果
真实的运行目录 工作目录是resource= file:/D:/Java_developer_tools/ssm/my_springmvc/hsp_springmvc/target/test-classes/
resourcePath= /D:/Java_developer_tools/ssm/my_springmvc/hsp_springmvc/target/test-classes/
真实的运行目录 工作目录是resource2= file:/D:/Java_developer_tools/ssm/my_springmvc/hsp_springmvc/target/test-classes/
resourcePath2= /D:/Java_developer_tools/ssm/my_springmvc/hsp_springmvc/target/test-classes/
    
```

**手写tomcat时使用的方式**

```java
//读取web.xml => dom4j =>
//得到web.xml文件的路径 => 拷贝一份. web.xml文件到工作目录target\classes下
/*注意：在main/resources目录下的资源会自动拷贝到工作目录target\classes下*/
//URL resource = HspTomcatV3.class.getResource("/");// 得到的是工作目录，而不是源码目录
String path = HspTomcatV3.class.getResource("/").getPath();// 得到的是工作目录，而不是源码目录
System.out.println("path= " + path);
```



---

# 13 测试在maven test环境下 测试classLoader.getResourceAsStream()和clazz.getResourceAsStream()



~~~java
文件位置
D:\Java_developer_tools\ssm\my_springmvc\hsp_springmvc\src\test\java\com\hspedu\test\HspSpringMVCTest.java

 @Test
    public void testGetResourceAsStream(){

        // 首先通过类的加载器拿到要扫描的包 在工作目录下的真实的绝对路径
        // getClassLoader().getResourceAsStream() 默认是在类的加载路径下获取资源[文件输入流]
        InputStream resourceAsStream = this.getClass().getClassLoader().
                getResourceAsStream(""); // 瞎写一个文件名 拿回来是null
        //classLoader.getResourceAsStream() 不能以斜杠开头 拿到的是null
        InputStream resourceAsStream1 = this.getClass().getClassLoader().
                getResourceAsStream("/"); // 不能以斜杠开头 拿到的是null 在此基础上瞎写一个文件名 "/x" 拿回来是null
        // 下面这种形式 默认是从该类HspSpringMVCTest.class的同文件夹下获取资源
        InputStream resourceAsStream2 = this.getClass().
                getResourceAsStream(""); // 瞎写一个文件名 拿回来是null
        // 下面这种形式 默认是从该类的加载路径classpath下获取资源
        InputStream resourceAsStream3 = this.getClass().
                getResourceAsStream("/");// 瞎写一个文件名 拿回来是null
        System.out.println("resourceAsStream= " + resourceAsStream);
        System.out.println("resourceAsStream1= " + resourceAsStream1);
        System.out.println("resourceAsStream2= " + resourceAsStream2);
        System.out.println("resourceAsStream3= " + resourceAsStream3);

        
        
        
        
        // 首先通过类的加载器拿到要扫描的包 在工作目录下的真实的绝对路径
        // getClassLoader().getResourceAsStream() 默认是在类的加载路径下获取资源[文件输入流]
        InputStream resourceAsStream = this.getClass().getClassLoader().
                getResourceAsStream("hspspringmvc1.xml"); // 瞎写一个文件名 拿回来是null
        InputStream resourceAsStream1 = this.getClass().getClassLoader().
                getResourceAsStream("/"); // 不能以斜杠开头 拿到的是null 在此基础上瞎写一个文件名 "/x" 拿回来是null
        // 下面这种形式 默认是从该类HspSpringMVCTest.class的同文件夹下获取资源
        InputStream resourceAsStream2 = this.getClass().
                getResourceAsStream("hspspringmvc.xml"); // 瞎写一个文件名 拿回来是null
        // 下面这种形式 默认是从该类的加载路径classpath下获取资源
        InputStream resourceAsStream3 = this.getClass().
                getResourceAsStream("/hspspringmvc1.xml");// 瞎写一个文件名 拿回来是null
        System.out.println("resourceAsStream= " + resourceAsStream);
        System.out.println("resourceAsStream1= " + resourceAsStream1);
        System.out.println("resourceAsStream2= " + resourceAsStream2);
        System.out.println("resourceAsStream3= " + resourceAsStream3);


~~~



---

# 14 在Spring和Spring Boot应用中，`@Valid` 和 `@Validated` 都用于触发数据验证，但它们在使用和支持的功能方面有所不同。下面是这两个注解的主要用法和区别，帮助你选择适合特定场景的注解。

### @Valid

`@Valid` 是由 JSR-303 和 JSR-349 Bean Validation API 定义的标准验证注解。它可以用于任何Java Bean对象上，以触发对其属性的验证约束。

**使用场景**：

- 应用在方法参数上（如控制器方法中的参数），以确保传入的参数满足定义的约束。
- 可以用在类型级别、属性级别或方法参数级别。
- 常用在Spring MVC的控制器或JAX-RS中。

### @Validated

`@Validated` 是由Spring框架提供的，作为`@Valid`的一个增强版，支持分组功能。它可以在Spring管理的Bean中使用，不仅限于验证控制器参数，还可以应用于Spring管理的任何Bean。

**使用场景**：

- 支持分组验证，允许在验证时指定一组特定的约束。例如，可以定义一些验证规则仅在创建时应用，而另一些规则仅在更新时应用。
- 可用于方法级别和类型级别。
- 常用于Spring服务或组件中，特别是当你需要在不同的上下文中应用不同的验证规则时。

### 示例解析

在你的示例中，使用了`@Valid`来确保传入的`LoginVo`对象满足验证约束：

```java
@RequestMapping("/doLogin")
@ResponseBody
public RespBean doLogin(@Valid LoginVo loginVo,
                        HttpServletRequest request,
                        HttpServletResponse response) {
    log.info("{}", loginVo);
    return userService.doLogin(loginVo, request, response);
}
```

这里`@Valid`用于控制器方法参数`loginVo`，确保在执行`doLogin`方法体之前，`loginVo`已通过验证（例如，检查是否包含有效的手机号码和密码格式）。如果`loginVo`中的数据不符合`@IsMobile`等注解定义的规则，将自动拒绝处理请求，并生成一个响应表示输入错误。

### 选择 @Valid 还是 @Validated？

- 如果你需要在控制器层简单地验证模型数据，且不需要分组功能，使用`@Valid`即可。
- 如果你需要更复杂的验证逻辑，例如分组验证或在Spring组件之外进行验证（如在服务层），应选择`@Validated`。

通常，在Spring MVC控制器中，`@Valid` 已经足够用于处理大部分常规的数据验证需求。当你的验证需求超出这些基本场景，或者当你想要利用分组特性来执行更细致的控制时，`@Validated`是一个更好的选择。



## 2 需要分组，此时就不可以使用@Valid了对吗

是的，正如你的示例所示，当你需要进行分组验证时，应使用 `@Validated` 而不是 `@Valid`。这是因为 `@Valid` 注解不支持验证分组功能，它将对所有应用了验证约束的字段进行验证，而无法区分场景。而 `@Validated` 注解支持分组功能，使得你可以根据不同的场景应用不同的验证规则。

### 分组验证的使用场景

分组验证通常在以下情况下非常有用：

- **创建与更新操作**：在创建新记录（如新品牌）时，可能所有字段都需要被验证，但在更新记录时，某些字段（如品牌ID）可能不允许更改，因此不需要验证。
- **条件验证**：在不同的操作或业务逻辑分支中，可能需要对同一对象的不同字段集进行验证。

### 示例说明

在你的代码中：

```java
@RequestMapping("/save")
public R save(@Validated(SaveGroup.class) @RequestBody BrandEntity brand) {
    // 业务逻辑
}
```

这里使用 `@Validated(SaveGroup.class)` 表明在处理 `save` 方法时，只对 `BrandEntity` 实体中属于 `SaveGroup` 这一验证组的属性进行验证。这种方式非常适合处理实体在不同操作（如新增与更新）中的验证需求。

### 关于 @Valid 和 @Validated 的选择

- **@Valid**：适用于简单的验证场景，无需分组。它是标准JSR-303规范的一部分，与Spring的集成自然不如`@Validated`灵活。
- **@Validated**：Spring特有的验证注解，支持分组功能，更适合复杂的验证场景，如同一个对象在不同的操作中需要不同的验证规则。

因此，当你的验证需求包括分组功能时，你应该选择使用 `@Validated`。这使得在Spring框架中，你可以更灵活地控制验证逻辑，确保根据具体的业务规则对数据进行正确的校验。



# 15 注入拦截器的方式分析

在Spring框架中，当你在配置类中直接实例化拦截器并将其注册到`InterceptorRegistry`时，实际上并不需要在拦截器类上使用`@Component`注解来注入到Spring的IoC容器中。这是因为在这种情况下，拦截器的实例是在配置类中直接创建的，而不是通过容器自动扫描和管理。

### 解析两种注入拦截器的方式：

1. **直接实例化并注册**：
   在你的配置类中，你直接使用`new LoginInterceptor()`来创建拦截器的实例，并通过`addInterceptor()`方法注册它。这种方法不依赖于Spring的自动组件扫描，因此不需要`@Component`或其他相关注解。

   ```java
   @Bean
   public WebMvcConfigurer webMvcConfigurer(){
       return new WebMvcConfigurer() {
           @Override
           public void addInterceptors(InterceptorRegistry registry) {
               registry.addInterceptor(new LoginInterceptor())
                       .addPathPatterns("/**")
                       .excludePathPatterns("/", "/login", "/images/**");
           }
       };
   }
   ```

2. **通过组件扫描**：
   如果你选择使用组件扫描来管理拦截器，那么你可以在拦截器类上使用`@Component`注解。这样，Spring会自动将拦截器类作为一个Bean实例化并管理。但在这种情况下，通常还需要在配置类中引用这个Bean，而不是直接创建新实例。

   ```java
   @Component
   public class LoginInterceptor implements HandlerInterceptor {
       // 实现方法
   }
   ```

   然后在配置类中这样引用：

   ```java
   @Autowired
   private LoginInterceptor loginInterceptor;
   
   @Bean
   public WebMvcConfigurer webMvcConfigurer(){
       return new WebMvcConfigurer() {
           @Override
           public void addInterceptors(InterceptorRegistry registry) {
               registry.addInterceptor(loginInterceptor)
                       .addPathPatterns("/**")
                       .excludePathPatterns("/", "/login", "/images/**");
           }
       };
   }
   ```

### 总结

- 当你在配置类中直接新建拦截器实例时，**不需要**使用`@Component`注解。
- 如果你希望Spring管理拦截器的生命周期，比如当拦截器中需要注入其他Bean或使用Spring的功能（如自动注入，生命周期回调等），则可以使用`@Component`注解，并通过自动注入（如`@Autowired`）来获取拦截器实例。

在你的示例中，第一种方法（直接实例化并注册）是合适的，不需要`@Component`注解，因为拦截器是在配置类中显式创建的。



## 关键点是确保Spring IoC容器中存在拦截器的一个实例，这样才能在Spring MVC的配置中引用并正确地注册这个拦截器。

是的，你的理解是正确的。无论是使用`@Bean`还是`@Component`注解，关键点是确保Spring IoC容器中存在拦截器的一个实例，这样才能在Spring MVC的配置中引用并正确地注册这个拦截器。这两种方法都可以达到这个目的，但它们在使用场景和控制程度上有所不同：

### 使用`@Bean`在配置类中注册拦截器

- **控制度高**：你可以在创建拦截器实例时进行更详细的配置，比如设置特定的属性或依赖。
- **明确指定**：在配置类中直接实例化和注册拦截器，可以明确地看到拦截器的使用和配置过程，适合于需要特定配置的情况。
- **局部应用**：适合于只在特定的配置中需要使用拦截器的场景。

### 使用`@Component`进行组件扫描

- **自动管理**：Spring将自动处理拦截器的生命周期和依赖注入等，适用于拦截器内部需要依赖其他Spring管理的Bean的情况。
- **全局应用**：拦截器作为组件被Spring管理，可以在多个地方被重用，无需在每个配置类中重复创建实例。
- **便于维护**：对于大型项目，使用组件扫描可以减少配置的复杂性，使项目结构更清晰。

### 选择使用哪种方式

选择`@Bean`还是`@Component`取决于你的具体需求：

- 如果拦截器的配置和使用非常特定，并且希望避免全局影响，使用`@Bean`可能更合适。
- 如果拦截器将在应用中广泛使用，或者需要Spring管理其生命周期和依赖，那么使用`@Component`更为合适。

最终，确保IoC容器中存在拦截器的一个实例，并且在Spring MVC的配置中正确注册，是使拦截器生效的关键。这可以通过以上任一方法实现，选择哪种方法取决于你对项目的架构和管理的偏好。



# 16 
