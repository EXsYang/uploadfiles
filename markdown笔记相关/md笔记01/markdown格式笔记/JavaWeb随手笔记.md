





## JavaWeb 问题总结

# 0 Tomcat 配置时的发布方式 选第二个

![image-20230925212010781](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230925212010781.png)

---

# 1 启动HspTomcatV3 的main 方法时，报错 NoClassDefFoundError: javax/servlet/http/HttpServlet

```
tomcat本身是有servlet的jar 的，tomcat 运行 可以找到HttpServlet
```



~~~java
package com.hspedu.tomcat;

import com.hspedu.tomcat.handler.HspRequestHandler;
import com.hspedu.tomcat.servlet.CallServlet;
import com.hspedu.tomcat.servlet.HspHttpServlet;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import javax.servlet.Filter;
import javax.servlet.http.HttpServlet;
import java.io.File;
import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.List;
import java.util.concurrent.ConcurrentHashMap;

/**
 * @author yangda
 * @description: 通过 反射 + xml来初始化容器
 * @create 2023-06-04-22:08
 */
public class HspTomcatV3 {

    //1. 存放容器 servletMapping
    // -ConcurrentHashMap
    // -HashMap
    // key            - value
    // ServletName    对应的实例

    public static final ConcurrentHashMap<String, HspHttpServlet>
            servletMapping = new ConcurrentHashMap<>();


    //2容器 servletUrlMapping
    // -ConcurrentHashMap
    // -HashMap
    // key                    - value
    // url-pattern       ServletName

    public static final ConcurrentHashMap<String, String>
            servletUrlMapping = new ConcurrentHashMap<>();


    public static final ConcurrentHashMap<String, Filter>
            filterMapping = new ConcurrentHashMap<>();

    public static final ConcurrentHashMap<String, String>
            filterUrlMapping = new ConcurrentHashMap<>();




    public static void main(String[] args) throws IOException {

        System.out.println("========");
        /*
        下面这行代码 会抛出异常
        Exception in thread "main" java.lang.NoClassDefFoundError:
        javax/servlet/http/HttpServlet

        public class CallServlet extends HttpServlet {}
        运行时找不到 类HttpServlet

        https://www.ibashu.cn/news/show_118694.html
        NoClassDefFoundError错误的发生，是因为Java虚拟机在编译时能找到合适的类，而在运行时不能找到合适的类导致的错误。例如在运行时我们想调用某个类的方法或者访问这个类的静态成员的时候，发现这个类不可用，此时Java虚拟机就会抛出NoClassDefFoundError错误。与ClassNotFoundException的不同在于，这个错误发生只在运行时需要加载对应的类不成功，而不是编译时发生。很多Java开发者很容易在这里把这两个错误搞混。
        */

        // 如果写了下面的代码也会报错 NoClassDefFoundError
        //HttpServlet callServlet = new CallServlet();
        //System.out.println("callServlet=" + callServlet);


        HspTomcatV3 hspTomcatV3 = new HspTomcatV3();
        //对容器进行初始化
        hspTomcatV3.init();

        // 在8080端口进行监听，获取http请求
        ServerSocket serverSocket = new ServerSocket(8088);
        //
        //// serverSocket没有关闭就一直监听
        while (!serverSocket.isClosed()){
            System.out.println("========HspTomcatV2 正在监听8080端口=======");
            Socket socket = serverSocket.accept();
            System.out.println("==========连接成功===========");




            new Thread(new HspRequestHandler(socket)).start();
        }

    }

    //直接对两个容器进行初始化
    public void init() {
        //读取web.xml => dom4j =>
        //得到web.xml文件的路径 => 拷贝一份. web.xml文件到工作目录target\classes下
        /*注意：在main/resources目录下的资源会自动拷贝到工作目录target\classes下*/
        //URL resource = HspTomcatV3.class.getResource("/");// 得到的是工作目录，而不是源码目录
        String path = HspTomcatV3.class.getResource("/").getPath();// 得到的是工作目录，而不是源码目录
        System.out.println("path= " + path);

        // 使用dom4j 读取
        SAXReader saxReader = new SAXReader();
        try {
            Document document = saxReader.read(new File(path + "web.xml"));
            System.out.println("document= " + document);
            //得到根节点 <web-app>
            Element rootElement = document.getRootElement();
            System.out.println("rootElement=" + rootElement);
            // 遍历根元素下面的所有节点元素
            List<Element> elements = rootElement.elements(); // 不写参数取出来的servlet_name=null,
            // 即将xml中根节点下一级全部节点取出
            //List<Element> elements = rootElement.elements("servlet");
            System.out.println("elements= " + elements);
            for (Element element : elements) {
                //Element servlet_name = element.element("servlet-name");
                //System.out.println("servlet-name=" + servlet_name);//null

                //if ("display-name".equalsIgnoreCase(element.getName())){
                //    // 是display-name
                //    System.out.println("发现 display-name");
                //}else

                //if ("servlet".equalsIgnoreCase(element.element("servlet").getText())){
                if ("servlet".equalsIgnoreCase(element.getName())) {
                    // 是servlet
                    System.out.println("发现 servlet");
                    // 使用反射将servlet实例放入servletMapping
                    Element servletName = element.element("servlet-name");
                    Element servletClass = element.element("servlet-class");
                    servletMapping.put(servletName.getText(), (HspHttpServlet) Class.forName(servletClass.getText().trim()).newInstance());

                    //}else if ("servlet-mapping".equalsIgnoreCase(element.element("servlet-mapping").getText())){
                } else if ("servlet-mapping".equalsIgnoreCase(element.getName())) {
                    // 是servlet-mapping
                    System.out.println("发现 servlet-mapping");
                    // 使用反射将 放入servletUrlMapping
                    Element servletName = element.element("servlet-name");
                    Element urlPattern = element.element("url-pattern");
                    servletUrlMapping.put(urlPattern.getText(), servletName.getText());

                }
            }
        } catch (Exception e) {
            System.out.println("出异常");
            e.printStackTrace();
        }

        System.out.println("servletMapping= " + servletMapping);
        System.out.println("servletUrlMapping= " + servletUrlMapping);
    }


}

~~~



~~~xml
<!DOCTYPE web-app PUBLIC
 "-//Sun Microsystems, Inc.//DTD Web Application 2.3//EN"
 "http://java.sun.com/dtd/web-app_2_3.dtd" >

<web-app>
  <display-name>Archetype Created Web Application</display-name>

  <servlet>
    <servlet-name>CalServlet</servlet-name>
    <servlet-class>com.hspedu.servlet.CalServlet</servlet-class>
  </servlet>
  <servlet-mapping>
    <servlet-name>CalServlet</servlet-name>
    <url-pattern>/calServlet</url-pattern>
  </servlet-mapping>

  <!--配置自己设计的Servlet
  会报红的原因是这里不是原生的servlet
      老韩提示： 因为这是我们自己的servlet , 所以不识别, 没有关系
      直接忽略爆红，将右上角Highlight:All Problems 改为语法 Syntax
  -->
  <servlet>
    <servlet-name>HspCalServlet</servlet-name>
    <servlet-class>com.hspedu.tomcat.servlet.HspCalServlet</servlet-class>
  </servlet>
  <servlet-mapping>
    <servlet-name>HspCalServlet</servlet-name>
    <url-pattern>/hspCalServlet</url-pattern>
  </servlet-mapping>
  <servlet>
    <servlet-name>Hsp6CalServlet</servlet-name>
    <servlet-class>com.hspedu.tomcat.servlet.Hsp6CalServlet</servlet-class>
  </servlet>

  <servlet-mapping>
    <servlet-name>Hsp6CalServlet</servlet-name>
    <url-pattern>/hsp6CalServlet</url-pattern>
  </servlet-mapping>

  <!--注意：在启动HspTomcatV3 的main 方法时，要把不属于自己创建的Servlet注销掉！！！，
    即web.xml 文件中不可以有继承于 HttpServlet 的Servlet配置
   否则会报错 NoClassDefFoundError: javax/servlet/http/HttpServlet
   虽然编译时不报错，但是在运行时 找不到合适的类
            .ClassNotFoundException: javax.servlet.http.HttpServlet
   原因是 进行反射时找不到指定的类
   这里的classpath 类加载路径就是target 路径，
   该路径下找不到类javax.servlet.http.HttpServlet
   所以反射失败！！！

   我们经常被java.lang.ClassNotFoundException和java.lang.NoClassDefFoundError这两个错误迷惑不清，
   尽管他们都与Java classpath有关，但是他们完全不同。NoClassDefFoundError
   发生在JVM在动态运行时，根据你提供的类名，在classpath中找到对应的类进行加载
   ，但当它找不到这个类时，就发生了java.lang.NoClassDefFoundError的错误，
   而ClassNotFoundException是在编译的时候在classpath中找不到对应的类而发生的错误
   。ClassNotFoundException比NoClassDefFoundError容易解决，是因为在编译时我们就
   知道错误发生，并且完全是由于环境的问题导致。而如果你在J2EE的环境下工作，并且得到
   NoClassDefFoundError的异常，而且对应的错误的类是确实存在的，这说明这个类对于
   类加载器来说，可能是不可见的。
   -->

  <!--<servlet>-->
  <!--  <servlet-name>CallServlet</servlet-name>-->
  <!--  <servlet-class>com.hspedu.tomcat.servlet.CallServlet</servlet-class>-->
  <!--</servlet>-->

  <!--<servlet-mapping>-->
  <!--  <servlet-name>CallServlet</servlet-name>-->
  <!--  <url-pattern>/callServlet</url-pattern>-->
  <!--</servlet-mapping>-->

  <!--<servlet>-->
  <!--  <servlet-name>TestServlet2</servlet-name>-->
  <!--  <servlet-class>com.hspedu.servlet.TestServlet2</servlet-class>-->
  <!--</servlet>-->
  <!--<servlet-mapping>-->
  <!--  <servlet-name>TestServlet2</servlet-name>-->
  <!--  <url-pattern>/test</url-pattern>-->
  <!--</servlet-mapping>-->

</web-app>

~~~

解决问题 的参考文献

https://www.ibashu.cn/news/show_118694.html

https://blog.csdn.net/weixin_50843918/article/details/129666631?spm=1001.2014.3001.5506

---

# 2 关于HspTomcatV3 main方法报错NoClassDefFoundError

不同的运行环境的classpath tomcat 和使用 maven 创建的项目 下的main主方法中的运行环境的classpath

maven 的classpath

~~~
C:\jdk\jdk1.8\bin\java.exe "-javaagent:D:\Java_developer_tools\developer_tools_IDEA\IntelliJ IDEA 2020.2.1\lib\idea_rt.jar=59120:D:\Java_developer_tools\developer_tools_IDEA\IntelliJ IDEA 2020.2.1\bin" -Dfile.encoding=UTF-8 -classpath C:\jdk\jdk1.8\jre\lib\charsets.jar;C:\jdk\jdk1.8\jre\lib\deploy.jar;C:\jdk\jdk1.8\jre\lib\ext\access-bridge-64.jar;C:\jdk\jdk1.8\jre\lib\ext\cldrdata.jar;C:\jdk\jdk1.8\jre\lib\ext\dnsns.jar;C:\jdk\jdk1.8\jre\lib\ext\jaccess.jar;C:\jdk\jdk1.8\jre\lib\ext\jfxrt.jar;C:\jdk\jdk1.8\jre\lib\ext\localedata.jar;C:\jdk\jdk1.8\jre\lib\ext\nashorn.jar;C:\jdk\jdk1.8\jre\lib\ext\sunec.jar;C:\jdk\jdk1.8\jre\lib\ext\sunjce_provider.jar;C:\jdk\jdk1.8\jre\lib\ext\sunmscapi.jar;C:\jdk\jdk1.8\jre\lib\ext\sunpkcs11.jar;C:\jdk\jdk1.8\jre\lib\ext\zipfs.jar;C:\jdk\jdk1.8\jre\lib\javaws.jar;C:\jdk\jdk1.8\jre\lib\jce.jar;C:\jdk\jdk1.8\jre\lib\jfr.jar;C:\jdk\jdk1.8\jre\lib\jfxswt.jar;C:\jdk\jdk1.8\jre\lib\jsse.jar;C:\jdk\jdk1.8\jre\lib\management-agent.jar;C:\jdk\jdk1.8\jre\lib\plugin.jar;C:\jdk\jdk1.8\jre\lib\resources.jar;C:\jdk\jdk1.8\jre\lib\rt.jar;D:\Java_developer_tools\javaweb\testMavenCreate\target\classes test.Test01
test ok
~~~

在该运行环境下  HspTomcatV3.java  main主方法 中，实例化一个extends HttpServlet 的实现子类对象 时 会报错

~~~
NoClassDefFoundError
ClassNotFoundException
~~~

```
NoClassDefFoundError错误的发生，是因为Java虚拟机在编译时能找到合适的类，而在运行时不能找到合适的类导致的错误。例如在运行时我们想调用某个类的方法或者访问这个类的静态成员的时候，发现这个类不可用，此时Java虚拟机就会抛出NoClassDefFoundError错误。与ClassNotFoundException的不同在于，这个错误发生只在运行时需要加载对应的类不成功，而不是编译时发生。很多Java开发者很容易在这里把这两个错误搞混。
```

原因是 在该运行环境下真实的 运行环境classpath 下没有找到合适的类 javax/servlet/http/HttpServlet

Maven 项目下真实的类加载路径= /D:/Java_developer_tools/javaweb/hsptomcat2/target/classes/





Maven 项目下main主方法的所有的classpath 路径如下：

~~~
C:\jdk\jdk1.8\bin\java.exe "-javaagent:D:\Java_developer_tools\developer_tools_IDEA\IntelliJ IDEA 2020.2.1\lib\idea_rt.jar=51300:D:\Java_developer_tools\developer_tools_IDEA\IntelliJ IDEA 2020.2.1\bin" -Dfile.encoding=UTF-8 -classpath C:\jdk\jdk1.8\jre\lib\charsets.jar;C:\jdk\jdk1.8\jre\lib\deploy.jar;C:\jdk\jdk1.8\jre\lib\ext\access-bridge-64.jar;C:\jdk\jdk1.8\jre\lib\ext\cldrdata.jar;C:\jdk\jdk1.8\jre\lib\ext\dnsns.jar;C:\jdk\jdk1.8\jre\lib\ext\jaccess.jar;C:\jdk\jdk1.8\jre\lib\ext\jfxrt.jar;C:\jdk\jdk1.8\jre\lib\ext\localedata.jar;C:\jdk\jdk1.8\jre\lib\ext\nashorn.jar;C:\jdk\jdk1.8\jre\lib\ext\sunec.jar;C:\jdk\jdk1.8\jre\lib\ext\sunjce_provider.jar;C:\jdk\jdk1.8\jre\lib\ext\sunmscapi.jar;C:\jdk\jdk1.8\jre\lib\ext\sunpkcs11.jar;C:\jdk\jdk1.8\jre\lib\ext\zipfs.jar;C:\jdk\jdk1.8\jre\lib\javaws.jar;C:\jdk\jdk1.8\jre\lib\jce.jar;C:\jdk\jdk1.8\jre\lib\jfr.jar;C:\jdk\jdk1.8\jre\lib\jfxswt.jar;C:\jdk\jdk1.8\jre\lib\jsse.jar;C:\jdk\jdk1.8\jre\lib\management-agent.jar;C:\jdk\jdk1.8\jre\lib\plugin.jar;C:\jdk\jdk1.8\jre\lib\resources.jar;C:\jdk\jdk1.8\jre\lib\rt.jar;D:\Java_developer_tools\javaweb\hsptomcat2\target\classes;C:\Users\yangd\.m2\repository\dom4j\dom4j\1.1\dom4j-1.1.jar com.hspedu.tomcat.HspTomcatV3
~~~

报错信息如下：

```
java.lang.NoClassDefFoundError: javax/servlet/http/HttpServlet
	at java.lang.Class.getDeclaredMethods0(Native Method)
	at java.lang.Class.privateGetDeclaredMethods(Class.java:2701)
	at java.lang.Class.privateGetMethodRecursive(Class.java:3048)
	at java.lang.Class.getMethod0(Class.java:3018)
	at java.lang.Class.getMethod(Class.java:1784)
	at sun.launcher.LauncherHelper.validateMainClass(LauncherHelper.java:544)
	at sun.launcher.LauncherHelper.checkAndLoadMain(LauncherHelper.java:526)
Caused by: java.lang.ClassNotFoundException: javax.servlet.http.HttpServlet
	at java.net.URLClassLoader.findClass(URLClassLoader.java:382)
	at java.lang.ClassLoader.loadClass(ClassLoader.java:424)
	at sun.misc.Launcher$AppClassLoader.loadClass(Launcher.java:349)
	at java.lang.ClassLoader.loadClass(ClassLoader.java:357)
	... 7 more
Error: A JNI error has occurred, please check your installation and try again
Exception in thread "main" 

```





![image-20230926131944587](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230926131944587.png)





tomcat的classpath 的真实的运行路径

~~~
//真正的运行环境= /D:/Java_developer_tools/javaweb/hsptomcat2/target/ydtomcat/WEB-INF/classes/
~~~

```java
public class TestServlet2 extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("TestServlet2 doPost...");

        URL resource = TestServlet2.class.getResource("/");
        System.out.println("真正的运行环境= " + resource.getPath());
        //真正的运行环境= /D:/Java_developer_tools/javaweb/hsptomcat2/target/ydtomcat/WEB-INF/classes/
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
```

**在Maven项目下的 tomcat 运行环境下 可以找到类 javax/servlet/http/HttpServlet**

**因此可以正常实例化HttpServlet 实现子类对象** 



---

# 3 Maven 关于生成的tomcat工作目录的名称问题



![image-20230926114713028](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230926114713028.png)

刷新的是 修改文件后弹出的下面这个标志

![image-20230926131608417](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230926131608417.png)

![image-20230926130804845](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230926130804845.png)

![image-20230926131033975](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230926131033975.png)

Load Maven Changes
Maven project structure has been changed.
Load changes into IntelliJ IDEA to make it work correctly

 加载Maven更改  

 Maven项目结构已更改。  

 将更改加载到IntelliJ IDEA中以使其正常工作  

![image-20230926131511758](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230926131511758.png)

---



# 4 Maven 项目创建源码目录细节

**使用 maven 创建的项目 运行后会产生target目录**

![image-20230926111547363](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230926111547363.png)



![image-20230926111802656](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230926111802656.png)



![image-20230926111942430](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230926111942430.png)



![image-20230926112217237](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230926112217237.png)



---

#   

# 5 class.getResource() 和 classLoader.getResource() 是不同的

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

# 项目jiaju_mall

## 注意点

### 1 **空格问题**

![image-20230715102347894](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230715102347894.png)

![image-20230715102513082](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230715102513082.png)

![image-20230715102654801](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230715102654801.png)

### 2 HTML文件直接改名为jsp文件导致中文乱码问题

![image-20230715231022183](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230715231022183.png)

解决方法：

将 改名后的jsp文件首行的	**<!DOCTYPE html>**	替换为

```jsp
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
```

就解决了！

---

### 3 回显错误信息问题

![image-20230716004550902](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230716004550902.png)

**当时自己的思路分析出错！！**

```jsp
  // 登录界面数据回显功能
            // 错误的思路：当用户点击login按钮时 发送Ajax请求


            $("#login_submit").click(function () {
                // 登录回显功能 点击Login button后进行后端校验 通过返回的数据进行 回显
                alert("ok~！~");


            })


            // 如果用户名或密码错误 回显信息
            // 这里需要到后端进行校验，也就是需要提交一次 然后将错误的用户名填写到输入框中

            // 将后端返回来的信息显示出来    只需要使用jsp页面的特性，在后端设置request域对象
            // 的属性 在前端通过el表达式中的隐藏域对象<%-- ${requestScope.msg} --%>来动态的获取！！

            //----------------------------------------------------------------------------
<%--            <%--%>
<%--            // 取出request域中的错误信息--%>
<%--            String error_username = request.getParameter("error_username");--%>
<%--            if (error_username != null){--%>
<%--                //说明后端登录失败 将用户名填写在用户名输入框中--%>

<%--                //--%>
<%--                //并提示 回显信息 用户名或密码错误--%>
<%--                %>--%>
<%--            $("span.errorMsg").text("用户名或密码错误");--%>

<%--            $("#login_username").val(<%=request.getParameter("error_username")%>);--%>
<%--            &lt;%&ndash;$("#login_username").val(${requestScope.error_username});&ndash;%&gt;--%>
<%--            $("#login_password").val(<%=request.getParameter("error_password")%>);--%>
<%--            return false;--%>
<%--            <%--%>
<%--             }else{--%>
<%--            %>--%>
<%--            // 说明request域中的error_username 为空 没有设置过  也可能是 提交以前！同样--%>
<%--            //也没有设置过    需要判断的是提交以后的结果   要想得到提交以后的结果就需要表单提交为true--%>
<%--            // 或者是使用ajax 请求的方式进行处理  表单提交的方式完成不了 因为需要在提交之前得到结果 不可行！--%>
<%--            // 使用ajax请求 当失去焦点时/点击提交按钮后 发送ajax请求--%>
<%--            /*  --%>
<%--             *  这里的这种需求可以使用jsp 动态获取数据的特性 动态获取request域对象中的数据   --%>
<%--                使用el表达式 或jsp表达式脚本 动态的获取数据！！ 表达式脚本: &lt;%&ndash; <%=%> &ndash;%&gt; --%>
<%--             */--%>
<%--            --%>
<%--            //$("span.errorMsg").text("验证通过ok...");--%>
<%--            &lt;%&ndash;$("span.errorMsg").text(<%=request.getContextPath() +"/"%>);&ndash;%&gt;--%>
<%--            return true;--%>
<%--            <%--%>
<%--             }--%>
<%--             %>--%>
```



**正确的思路：**

```jsp
/ 如果用户名或密码错误 回显信息
// 这里需要到后端进行校验，也就是需要提交一次 然后将错误的用户名填写到输入框中

// 将后端返回来的信息显示出来    只需要使用jsp页面的特性，在后端设置request域对象
// 的属性 在前端通过el表达式中的隐藏域对象<%-- ${requestScope.msg} --%>来动态的获取！！
```

![image-20230716004957604](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230716004957604.png)



![image-20230716005616220](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230716005616220.png)

<img src="https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230716005752619.png" alt="image-20230716005752619" style="zoom: 67%;" />







<img src="https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230716010057730.png" alt="image-20230716010057730" style="zoom:67%;" />



---



# JavaWeb debug 技巧

![image-20230716192552609](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230716192552609.png)

点击小虫子 后tomcat进入debug 模式 

前端进行 相关操作 使代码运行到断点处 比如登录操作  浏览器就会一直卡住 不停的转圈，因为后端正在代码调试

没有放行	如何使前端不停的转的浏览器 放行？ 点击**Resume Program**按钮 进行放行	后面的代码该怎么走就怎么走，放行是代表那一次请求 debug结束	此时可以动态的添加**新的断点**

但是整体 此时 tomcat 仍然处于debug模式	等待下一次 只要是处于debug模式 就还可以进行调试 再次进行登录测试 就会进入debug



![image-20230716193948008](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230716193948008.png)

![image-20230716194131069](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230716194131069.png)



![image-20230716194302157](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230716194302157.png)



---

### 4 方法重写细节补充

![image-20230717010801407](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230717010801407.png)

![image-20230717010953920](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230717010953920.png)

### 5 jsp 用到的jar

![image-20230717183655551](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230717183655551.png)







 	![image-20230717184140820](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230717184140820.png)

![image-20230717184245198](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230717184245198.png)

![image-20230717184425674](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230717184425674.png)

![image-20230717184536057](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230717184536057.png)

![image-20230717184615724](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230717184615724.png)



![image-20230717185435153](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230717185435153.png)

### 6 jsp相关jar包说明

```jsp
<%--
    当导入 servlet-api.jar    jsp-api.jar
    (jasper.jar 将jsp翻译成.java文件后 查看继承的类  查看相关的类图 相关的父类在此包下)
    后就可以使用 <%!%> <%%> <%=%> el表达式:${}、还有jsp标签了 <jsp:forward page="/bb.jsp"></jsp:forward>
    要想使用jstl标签库 替代 <%%> 代码脚本 需要导入两个jar包 即
    taglibs-standard-impl-1.2.1.jar
    taglibs-standard-spec-1.2.1.jar
    如上 相关笔记见 JavaWeb随手笔记.md

<% %> 代码脚本
<%= %> 表达式脚本
<%! %> 声明脚本
--%>
```

![image-20230717185936236](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230717185936236.png)

---

### 7 在jsp不同位置声明  el表达式 	测试是否生效

![image-20230717200937434](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230717200937434.png)

![image-20230717200955915](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230717200955915.png)

![image-20230717201526454](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230717201526454.png)

---

### 8 在前端的JavaScript代码块中获取服务器端  设置在request中的属性 

request是**域对象** 在.jsp文件中获取方式如下

![image-20230717222520066](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230717222520066.png)

也可以在html 代码中直接使用！

---

9 数据库int(10) 和int(11) 说明

![image-20230718012230793](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230718012230793.png)

![image-20230718012523331](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230718012523331.png)

![image-20230718012845765](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230718012845765.png)

---

### 9 JavaBean 属性类型 尽量使用包装类

![image-20230718014417113](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230718014417113.png)

![image-20230718014629623](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230718014629623.png)

除了上图中的 防止null 问题	还有自动装箱问题

---

### 10 JavaBean 属性和数据库表的字段不一致问题

数据库命名 经常会使用下划线，如果出现JavaBean 属性和数据库表的字段不一致问题如何解决呢？如下操作

![image-20230718021809404](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230718021809404.png)

![image-20230718020648646](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230718020648646.png)



![image-20230718022304512](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230718022304512.png)

如何解决：

使用	别名！	as

![image-20230718021441935](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230718021441935.png)

---



### 11 服务器端没有写doGet() 浏览器报405错误

![image-20230718121714029](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230718121714029.png)



![image-20230718121850977](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230718121850977.png)

解决方法：增加doGet()方法

![image-20230718121952710](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230718121952710.png)



![image-20230718124119608](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230718124119608.png)

![image-20230718124834173](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230718124834173.png)

传入一个action=list	form表单提交的数据通过name-value 进行提交	name="action"	value="list"

这里是直接写在url里进行提交的	**getParamter("") 是对uri 的字段进行分割获取的**

![image-20230718124512259](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230718124512259.png)





---

### 12 jsp注释生成问题

![image-20230718152338297](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230718152338297.png)

### 13 el表达式的 书写位置以及是否写在双引号中的问题

![image-20230718153652149](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230718153652149.png)

---

```
服务器后端设置的属性值不可以直接在javaScript中使用el表达式获取，可以用html当跳板 先传给html的一个input元素
再在js中获取input元素的value！
```





### 14 jstl 在tomcat项目中爆红问题

说明：写jsp文件时 是在out目录下的jsp文件中书写的 因此爆红，

注意 **当确定写的文件是那个目录下的文件时在进行写代码！！！！**

![image-20230718155737974](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230718155737974.png)

如何解决： 切换到web目录下的文件中 加入

```jsp
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
```

![image-20230718205701142](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230718205701142.png)

![image-20230718205919479](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230718205919479.png)

发现一个问题 

### 15 javaweb 项目文件覆盖问题

out/artifacts/jiaju_mall_war_exploded/pages/manager/furn_manage.jsp

web/pages/manager/furn_manage.jsp

虽然是在out目录下写的代码

 但是ieda失去焦点后热加载、重新发布、重启ieda(关闭tomcat后重新启动idea，但是重启ieda后还没有启动tomcat)、第一次启动tomcat out目录下的文件 并没有被覆盖掉	即使第二层重启tomcatout目录下的文件 并也没有被覆盖掉

**重新rebuild project	+ 	restart server	out/.../furn_manage.jsp  out目录下的文件立即马上就被覆盖掉了**

---



### 16 BasicServlet  **InvocationTargetException**	 调用目标异常 

![image-20230719114420857](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230719114420857.png)

![image-20230719115136265](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230719115136265.png)

![image-20230719120003921](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230719120003921.png)

![image-20230719114122896](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230719114122896.png)

![image-20230719114306507](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230719114306507.png)

![image-20230719120628654](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230719120628654.png)

EL表达式获取对象属性的原理是这样的：
以表达式${user.name}为例
EL表达式会根据name去User类里寻找这个name的get方法，此时会自动把name首字母大写并加上get前缀，一旦找到与之匹配的方法，El表达式就会认为这就是要访问的属性，并返回属性的值。

所以，想要通过EL表达式获取对象属性的值，那么这个属性就必须有与之对应的get方法。


其实你要了解EL表达式的运行原理，它其实后台也对应的java代码，
 它会先将你EL表达式中的对象属性的首字符大写，拼成getXX()方法，
 然后利用**反射**将对象构建出来，然后再执行getXX()方法，
 所以这中间不关私有属性的事，调用的是私有属性的get/set方法。
 如果你不写get/set方法，那EL表达式就拿不到值了。set方法是给你后台设置值用的。

![image-20230719123803248](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230719123803248.png)

---

### 17 jstl 使用细节

#### 17.1 细节1

 c:if test(”el表达式“) 中条件不满足不会进入 

el表达式中获取了不存在的属性count   el表达式不会报错 

```jsp
 <%--前端查看源代码的页面 没有识别出jstl 语句--%>
<%--如果 服务器端设置的计数count 大于0 说明放入了数据库的信息 此时进行展示！--%>
<%----%>
<%--                                <c:if test="${requestScope.count > 0}">--%>
<%--如果${requestScope.list}不存在 则不会进入forEach语句 这样就不用添加c:if test=""进行判断了--%>
requestScope.list=${requestScope.list} <br/>
forEach 前
<c:forEach items="${requestScope.list}" var="furn">
    <%--家居整体信息!：${furn}<br/>--%>
    <%--如下是从requestScope.list中取出的单个的furn对象 然后再获取furn.product_name属性！
    在el表达式中获取属性时使用到反射
    --%>
    --forEach 里面 &nbsp;

    <%--下面这句话注销掉 就不会报错 java.lang.reflect.InvocationTargetException--%>
    出现报错的原因是 ￥{furn.product_name} el表达式 这里底层进行了反射
    <%--家居信息!：${furn.product_name}-${furn.merchant_name}-${furn.price}<br/>--%>
</c:forEach>
<%--                                </c:if>--%>

```

#### 17.2 细节2 

```jsp
<%--c:if 标签中 不要填scope属性 填了会报错！！！
HTTP Status 500 - <h3>Validation error messages from TagLibraryValidator for c in /jstl/c_if.jsp</h3><p>17: Illegal scope attribute without var in "c:if" tag.</p>
--%>

<%--<c:set scope="request" var="num1" value="100"></c:set>--%>
<c:set scope="request" var="num1" value="101"></c:set>
<%--<c:set scope="request" var="num1" value="200"></c:set>--%>
<c:set scope="request" var="num2" value="20"></c:set>
<h1>${num1} - ${num2}</h1>
num1=${requestScope.num1} num2=${requestScope.num2}<br>

<%--正确的写法：不加scope属性！--%>
<c:if test="true">
    <h1>if2 ${num1} > ${num2}</h1>
</c:if>


<%--错误的写法：加了scope属性！会报错--%>
<%--<c:if scope="page" test="${requestScope.num1 > num2}">--%>
<%--    <h1>${num1} > ${num2}</h1>--%>
<%--</c:if>--%>
```

#### 17.3 细节3

```jsp
<%--
c:forEach 注意事项：
	1.forEach 属性位置 数字写在双引号""中，
	2.<c:forEach begin="1" end="${end}" var="i">
      中的var="i" 可以在el表达式中直接获取 
${i} 或 <c:iftest="${sessionScope.page.pageNo == i}">

<%--显示所有页数的页码--%>
<%--<c:set scope="request" var="begin" value="1"></c:set>
<c:set scope="request" var="end" value="${sessionScope.page.pageTotalCount}"></c:set>
<c:forEach begin="1" end="${end}" var="i">
    <c:if test="${sessionScope.page.pageNo == i}">
        <li><a class="active" href="manage/furnServlet?action=page&pageNo=${i}&pageSize=${sessionScope.page.pageSize}">${i}</a></li>
    </c:if>

    <c:if test="${sessionScope.page.pageNo != i}">
        &lt;%&ndash;<li><a href="manage/furnServlet?action=page&pageNo=${sessionScope.page.pageNo}&pageSize=${sessionScope.page.pageSize}">${i}</a></li>&ndash;%&gt;
        <li><a href="manage/furnServlet?action=page&pageNo=${i}&pageSize=${sessionScope.page.pageSize}">${i}</a></li>
    </c:if>
</c:forEach>--%>
```



### 18 el 表达式使用细节

**el 表达式使用位置** 

1.jsp的html代码中 包括 属性位置 和 innerTest位置

2.jsp的JavaScript代码中

注意：在js中使用el表达式，一定要使用引号括起来。如果返回的json中包括双引号，那么就使用单引号包围el表达式，否则，使用双引号。

```js
$(function () {//页面加载完毕后执行function

    //决定是显示登录还是注册tab  ""不能少 28行少了会报错 Uncaught ReferenceError: register is not defined
    // 浏览器将el取到的结果register 当作了一个变量处理
    // 类似var register;
    //如果注册失败，显示注册tab,而不是默认的登录tab
    <%--if ( ${requestScope.active} == "register"){ --%>
    if ("${requestScope.active}" == "register"){
        //这里弹窗会导致下面的模拟点击失效
        //alert(dcsdf) //Uncaught ReferenceError: dcsdf is not defined
        <%--console.log(${requestScope.active});--%>
        $("#register_tab")[0].click();//模拟点击
    }
})
```

![image-20230802001424736](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230802001424736.png)

#### 18.1 细节1

**el表达式里不可以使用+号进行字符串的拼接操作 el表达式里的+号只当作加减运算的操作符来使用，而不是连字符**

```jsp
在el表达式中获取对象属性时使用到反射！！！
<%--下面这句话注销掉 就不会报错 java.lang.reflect.InvocationTargetException--%>
出现报错的原因是 ￥{furn.product_name} el表达式 这里底层进行了反射
<%--家居信息!：${furn.product_name}-${furn.merchant_name}-${furn.price}<br/>--%>

 
<%--不存在的requestScope的属性fur 这里不会报错 会就往下执行--%>
fur.product_name=    ${fur.product_name}<br/>
 <%--存在的requestScope的属性furn1 获取通过furn1.错误的属性名product_name
这里进行反射会报错InvocationTargetException
只能写furn1.name 
因为furn1时Furn对象 Furn只有getName()方法 没有getProduct_name()方法
反射时找不到getProduct_name()方法导致报错
--%>
<%--furn.product_name=    ${furn1.product_name}<br/>--%>

 <%--<base href="${pageContext.request.contextPath + "/"}">  不行 el表达式内部使用 + 出现问题！！！ 当作运算符+而不是当作拼接符号的+ --%>

<c:set scope="request" var="path" value="/jiaju_mall/"></c:set>
<h2>用el表达式来取数据：</h2>
c:set-path的值= ${requestScope.path}  /jiaju_mall/
<base href="${requestScope.path}" >



  
    <%--<base href=${requestScope.} + "/">不行 不可以使用requestScope 获取contextPath--%>
    <%--<base href="${pageContext.request.contextPath + "/"}">  不行 el表达式内部使用+ 出现问题 --%>
	
    <%--<base href="${pageContext.request.contextPath}" >  单独写一个el表达式不会报错 但是还是不行 路径不对啊--%>

    <c:set scope="request" var="path" value="/jiaju_mall/"></c:set>
    <%--<h2>用el表达式来取数据：</h2>--%>
    c:set-path的值= ${requestScope.path}  <%-- /jiaju_mall/ --%>
    <base href="${requestScope.path}" >

    <%--<base href='<%=request.getContextPath()%>/'> 可以使用这种--%>
<%--<base href='<%=request.getContextPath()%>/'/> 也可以使用这种形式 最后一个/> 中的/ 不加也没事--%>
<%--<base href="<%=request.getContextPath() + "/"%>" 可以	  "/"要加到表达式脚本的里面才行--%>
下面这种形式也可以
<a href="<%=request.getContextPath()%>/addMonsterUI">添加妖怪</a>
```



#### 18.2 细节2

```jsp
num1 = ${num1}<br/> 90
num2 = ${num2}<br/> 30
num1 = num2 一个等号相当于赋值符号 结果为：${num1 = num2} 输出的是num2的值<br/>
```

#### **18.3 细节3** el表达式中通过${cart.totalCount}本质是调用get方法 即getTotalCount()

![image-20230802233706370](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230802233706370.png)

![image-20230802233741990](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230802233741990.png)

![image-20230802233800720](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230802233800720.png)

```java
//购物车总商品数
//private Integer totalCount;
//这里注销掉了！没有totalCount属性 前端在el表达式中是否还可以通过cart.totalCount
// 结论：设置在session域对象中 cart对象的没有totalCount属性
// 前端在el表达式中 依然可以通过 ${sessionScope.cart.totalCount} 进行获取
// 因为el表达式 这种方式 找的是cart对象的get方法 只要对象中有get方法 就可以这样获取！！
```

```jsp
<a href="#offcanvas-cart"
   class="header-action-btn header-action-btn-cart offcanvas-toggle pr-0">
    <i class="icon-handbag"> 购物车</i>
    <%--${sessionScope.cart.totalCount} 本质是调用cart对象的getTotalCount()方法--%>
    <span class="header-action-num">${sessionScope.cart.totalCount}</span>
</a>
```

![image-20230803021751947](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230803021751947.png)

---



### 19 jsp表达式脚本<%=%>使用细节

#### 19.1 细节1

**表达式脚本里面可以使用+号进行字符串的拼接操作**

~~~ jsp

<%--<base href="/jiaju_mall/">--%>

<%--<base href="<%=request.getContextPath()%> + /">不行--%>
<%--<base href=<%=request.getContextPath()%> + "/">不行--%>
<%--<base href=${requestScope.} + "/">不行--%>
<%--<base href='<%=request.getContextPath()%>/'> 可以使用这种--%>
<%--<base href='<%=request.getContextPath()%>/'/> 也可以使用这种形式 最后一个/> 中的/ 不加也没事--%>

<base href="<%=request.getContextPath() + "/"%>"> 			"/"要加到表达式脚本的里面才行！！！
表达式脚本里面可以使用+号进行字符串的拼接操作
el表达式里不可以使用+号进行字符串的拼接操作 el表达式里的+号只当作加减运算的操作符来使用，而不是连字符
~~~

#### 19.2 细节2

在html元素的**属性位置 的双引号中** jsp**表达式脚本内部**可以使用连字符号加号 +  如base标签中的

![image-20230808121704288](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230808121704288.png)

但是 在**属性位置**的**表达式脚本外部**直接写后面的内容 （如路径） 

不用使用加号+  进行拼接

![image-20230808121506208](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230808121506208.png)

#### 19.3 细节3

 **jsp表达式脚本<%=%>使用位置**

1.可以在jsp的html代码部分使用

2.可以在javascript脚本代码中使用

![image-20230801221726175](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230801221726175.png)

![image-20230803174512763](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230803174512763.png)



### 20 jsp使用细节

```jsp
<%--测试在jsp 的 html代码 中是否可以识别到el表达式
jsp页面中 这种注释--%> <%-- --%>   <%--
、el表达式、jstl 都不会在前端查看页面源代码时显示出来
 但是el表达式在jsp 的 html代码中生效！即下面这行代码生效 在js代码中声明el表达式就像没写过一样
 js中的双斜杠注释会在前端查看页面源代码时显示出来
--%>

<%--ctrl + shift + /--%> 在当前位置生成jsp注释
<%--  ctrl + /            --%> 在行首位置生成jsp注释
```



---





### 21 base 标签要写在引用资源的路径前！！

![image-20230720183355456](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230720183355456.png)

---



### 22 设置服务器端获取参数 中文乱码细节

![image-20230720203804037](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230720203804037.png)

![image-20230720204019305](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230720204019305.png)



---

### 23 alt + R 重新发布项目问题

**当鼠标定位到红色部分时 会出现如下提示框**

<img src="https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230720222454678.png" alt="image-20230720222454678" style="zoom:50%;" />

**当鼠标定位到黄色部分 或蓝色选中条选中 Service 中的组件时 不会出现上图的提示框 而是直接重新启动Tomcat!**

![image-20230720222710962](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230720222710962.png)



---

### 24 解决表单重复提交问题

![image-20230721000926164](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230721000926164.png)



解决方法1(自己写的)：

重新发送的数据 到数据库进行验证 查看是否有重复的数据 以此来判断 

不好用 用户也许只想在本页面 而不回添加页面呢 

解决方法2：

使用重定向



**●** **老韩解读**

**1.** **从实现效果上看是没有问题的**

**2.** **有** **bug:** **如果用户刷新页面，就会发现有重新添加一次家居****[****给小伙伴演示一下****]**

**3.** **原因：当用户提交完请求，浏览器会记录下最后一次请求的全部信息。当用户刷新页面(f5)，**

**就会发起浏览器记录的上一次请求****

**4.** **解决:** **使用重定向即可，因为重定向本质是两次请求，而且最后一次就是请求显示家居，而不是添加家居**



---

### 25 debugger 技巧 计算表达式的值 Evaluate Expression

![image-20230721010447614](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230721010447614.png)

<img src="https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230721010832619.png" alt="image-20230721010832619" style="zoom:50%;" />

<img src="https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230721010856209.png" alt="image-20230721010856209" style="zoom:50%;" />

---



### 26 javaweb 使用的jar说明

*//**处理添加家居的请求*

protected void add(HttpServletRequest req, HttpServletResponse resp)

throws ServletException, IOException {

*//1.* *获取请求参数，并封装成* *Furn* *对象**[**说明：后面我们会使用工具类* ***DataUtils*** *来完成*

*自动封装* *JavaBean]*

String name = req.getParameter("name");

String price = req.getParameter("price");

String sales = req.getParameter("sales");

String stock = req.getParameter("stock");

String maker = req.getParameter("maker");

Furn furn = new Furn(null, name, maker, new BigDecimal(price), 

new Integer(sales), new Integer(stock), null)

**完成将前端提交的数据， 封装成Furn的Javabean对象
        //使用BeanUtils完成javabean对象的自动封装.**

** **使用工具类** **DataUtils(底层使用 BeanUtils)** **来完成自动封装** **JavaBean**	

说明：DataUtils是自己写的工具类 BeanUtils是导入的包里的类

**●** **老韩解读**

**1. BeanUtils** **工具类，它可以一次性的把所有请求的参数注入到** **JavaBean** **中。**

**2. BeanUtils** **工具类，经常用于把** **Map** **中的值注入到** **JavaBean** **中，或者是对象属性值的拷贝操作**

**3. BeanUtils** **不是** **Jdk** **的类，需要导入需要的** **jar** **包：**

 **commons-beanutils-1.8.0.jar**

**commons-logging-1.1.1.jar**

![image-20230721160501330](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230721160501330.png)

---

### 27 测试BeanUtils  反射使用的是带参构造器吗？ 还是set方法？

```
// 测试BeanUtils  反射使用的是带参构造器吗？ 还是set方法？
// 测试方法：前端页面添加一个input 用于提交imgPath
```



![image-20230721170615708](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230721170615708.png)

![image-20230721172246101](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230721172246101.png)

数据库添加数据成功，BeanUtils 反射Furn对象成功

furn= Furn{id=null, name='Namexxzxz', maker='蚂蚁家居', price=60.00, sales=100, stock=80, imgPath=''}

数据库进行添加时 因为 imgPath='' 获取属性不会为null

所以数据库可以添加数据

不能添加数据 是因为之前Furn对象的属性默认值 imgPath=null 数据库在创建furn表的字段img_path 时 写了 NOT NULL 所以导致添加失败 

![image-20230721173132206](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230721173132206.png)

![image-20230721172116146](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230721172116146.png)

![image-20230721172946381](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230721172946381.png)

---

### 28 关于 javaweb 中DAO层和Service层方法的功能基本相同  为什么不直接只写一层就好了呢？

问题提出：

FurnDAO中的addFurn()方法和FurnService中的addFurn()方法功能基本相同，在Service层只是一个简单的调用，为什么不直接只写一层就好了呢？

原因如下：

将来可能 会出现Service层的某个功能 需要调用到多个DAO层的方法的问题 只有一个DAO层满足不了需要 比如前端发送了一个订单的请求，可能要完成支付，又要生成订单

![image-20230721205731345](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230721205731345.png)

![image-20230721210249996](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230721210249996.png)

**所以Service层是必须的** 即使实现的功能还很简单，只是一个简单的调用，Service也有必要存在	现在的问题是业务比较简单造成的

![image-20230721211313798](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230721211313798.png)

**所以Service层 和DAO层的存在是非常有必须的！**

---

### 29 JavaScript/jquery弹出一个确认对话框的操作

 				// confirm :确认
 	            //弹出一个确认的对话框
 	            var b = window.confirm("确定要删除用户 " + $(this).attr("id") + " 吗？");

```javascript
jquery/homework2/homework4.html
$("#addUser").click(
    function () {
        // alert("xxx")
        // $("#name").val()
        // $("#email").val()
        // $("#tel").val()


        var $tr = $("<tr/>");

        var $td_n = $("<td/>");
        var $td_e = $("<td/>");
        var $td_t = $("<td/>");
        var $td_d = $(" <td/>");
        var $a = $("<a/>");
        //    <td><a id="Tom" href="deleteEmp?id=Tom">Delete</a></td>

        // alert( typeof $("#name").val()); // string
        if ($("#name").val()) {
            $td_n.text($("#name").val());

            $a.attr("id", $("#name").val());
            // alert(typeof $a.attr("id"));
            // $a.attr("href", "deleteEmp?id=" + $("#name").val());
            // $a.attr("href", "#"); //"#" 当前页面 也可以！
            $a.text("Delete");
            // alert(typeof $a.attr("id"));
            // alert($a[0].innerHTML);

            $td_d.append($a);
            // var $p = $("<p>点击我~</p>");
            // $td_d.append($p);

            //a元素创造出来后绑定事件 用于删除
            $a.click(function () {

                // 进行删除操作
                //  根据点击的a元素，找到父级tr 删除tr
                // // parent() 返回一个 jquery对象！！
                // alert("$td_d this typeof= " + typeof this);
                // confirm :确认
                //弹出一个确认的对话框
                var b = window.confirm("确定要删除用户 " + $(this).attr("id") + " 吗？");
                // alert("确定要删除用户 " + $(this).attr("id") + " 吗？");
                 console.log("确认对话框返回的值 b= " ,b);
                            //确认对话框返回的值 b=  false  
                            //确认对话框返回的值 b=  true
                if (!b) {
                    return false;
                }
                // console.log("this.attr(id)= " + $(this).attr("id"));  //传进来的是a标签的dom对象

                //继续处理删除
                //1. 通过$a 找到父tr
                var $tr = $a.parent().parent();
                // alert("父级元素tr= " + tr);
                $tr.remove()
                //老韩解读：如果我们返回的false ,则表示放弃提交，页面就会停留在原页面
                return false;// 可以让 a标签不进行跳转，停留在原页面

            })
```

---



### 30 idea 异常关闭Error running ‘Tomcat 8.5.34‘: Address localhost:1099 is already in use

今天在启动IDEA编辑器的时候遇到了这样的一个报错，导致项目无法运行起来。问题如图所示，在IDEA中开启tomcat服务器时报错：端口已被占用。出现的原因是没有正常关闭tomcat 而是直接关闭了ieda导致的

![image-20230813182240148](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230813182240148.png)

    1.Error running ‘Tomcat 8.5.34‘: Address localhost:1099 is already in use

最有效的解决方法：是打开任务管理器 alt+shift+esc

找到一个java进程 **Java(TM) Platform SE binary** 将其关闭

![image-20230813182618030](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230813182618030.png)

IDEA启动报错：Error running ‘Tomcat 8.5.34‘: Address localhost:1099 is already in use_linux

这是因为在tomcat开启的状态下，IDEA异常关闭，导致tomcat一直占用端口。
解决办法如下：

1：打开cmd
输入命令netstat -ano|findstr "1099"，查看1099端口是否被占用，且得到了进程号“1400”；

2： 再输入命令tasklist|findstr "1400"，得到进程映像名java.exe；

3： 启动任务管理器，结束java.exe进程；

    用鼠标打开任务管理器，首先鼠标放在电脑最下边靠右边的任务栏上，点击右键




    选择启动任务管理器，用鼠标左键单击，就打开了任务管理器


​    IDEA启动报错：Error running ‘Tomcat 8.5.34‘: Address localhost:1099 is already in use_tomcat_05

    找到1400所对应的程序java.exe，结束任务


4： 最后再输入命令netstat -ano|findstr "1099"，查看1099端口是否被还占用
  ![image-20230723112748014](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230723112748014.png)

OK，从新启动你的项目，解决端口被占用的问题了。
-----------------------------------

IDEA启动报错：Error running ‘Tomcat 8.5.34‘: Address localhost:1099 is already in use
https://blog.51cto.com/u_15315508/3208250





---



### 31 如何绑定页面加载后通过jstl动态的添加进去的所有的删除a标签呢？ 使用类选择器

![image-20230723114838292](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230723114838292.png)



参考的代码位置：jquery/homework/homework01.html 如下所示

 **统一绑定.** 
 **只要是p标签就绑定一个click事件   $("p")即使是单个元素返回也是返回的一个数组对象，取下标为零位置的元素**



```html

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>homework01</title>

    <script type="text/javascript" src="../script/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
        /*  $(function () {
              // 只要是p标签就绑定一个click事件   $("p")即使是单个元素返回也是返回的一个数组对象，取下标为零位置的元素
              $("p").click(function (){

              })


              var $ps = $("p");
              $ps.each(function () {
                  $(this).click(
                      function () {
                          alert("文本内容是= " + $(this).text());
                      }
                  )
              })


          })*/
        $(function (){
            //方式1
            //老韩思路
            //1. 选择器选择p元素-基础选择器
            //2. 绑定事件-函数-获取p元素的文本
            //3. 统一绑定.
            // 只要是p标签就绑定一个click事件   $("p")即使是单个元素返回也是返回的一个数组对象，取下标为零位置的元素 
            $("p").click(function (){
                //3. 当我们点击p元素时, 会隐式的传入this(dom), 表示你当前点击的p
                //   元素,对应的dom对象
                //alert("p的内容是= " + this.innerText)
                alert("p的内容是(jquer方式)=" + $(this).text())
            })

            //方式2
            //对所有的p元素进行遍历
            //遍历执行内部function 依然会隐式的传入this(表示当前的p的dom对象)
            //这是遍历出一个p对象, 就绑定一个click事件
            $("p").each(function (){
                $(this).click(function (){
                    alert("p的内容~=" + $(this).text())
                })
            })

        })

    </script>
</head>
<body>
<p>段落1</p>
<p>段落2</p>
<p>段落3</p>
</body>
</html>
```

---



### 32 MySQL 字段的别名问题





老韩的查询语句是：

![image-20230723184930275](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230723184930275.png)

![image-20230723185031685](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230723185031685.png)

![image-20230723185556356](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230723185556356.png)

1、在mysql中，group by中可以使用别名；where中不能使用别名；order by中可以使用别名。


2、在oracle中：

1）where/group by/having子句中只能直接使用栏位或者常量，而不能使用栏位的别名，除非这个别名来自子查询之中，如：select .... from (select col1 ccc from table) where ccc > 1 
2）而order by 则可以直接使用别名，如select col1 ccc from table order by ccc 

这和sql 的执行顺序是有关的，where中的部分先执行 －> 如果有group by，接着执行group by －> select中的函数计算、别名指定再运行－> 最后order by 
因此，字段、表达式的别名在where子句和group by子句都是不能使用的，而在order by中不仅可以使用别名，甚至可以直接使用栏位的下标来进行排序，如：order by 1 desc,2 asc

---

### 33 测试时DBUtils 的update() 方法 删除成功返回值为0的问题

![image-20230723193739438](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230723193739438.png)

![image-20230723193931244](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230723193931244.png)

---



### 34 前端页面js 统一绑定事件问题



![image-20230723213738629](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230723213738629.png)

![image-20230723202504901](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230723202504901.png)

导致的结果如下：

![image-20230723202735644](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230723202735644.png)

出现的原因 相当于**普通的通过id/class选择器进行获取 并弹窗** 

alert("furn_id= " + $(".furn_id").val());

alert("furn_id= " + $("#furn_id").val()); 

上面两行代码出现的效果相同 如上图所示的问题 都是第一个家居的家居名





因为这里点击的不是通过类选择器选择到的元素 情况有区别 

解决方法：使用点击事件 this(这个this是 *$(".delete_a").click(function (){*  中隐式的传入的this)

获取 和这个this相关联的其他的dom节点并获取对应的值 val()

```
因为这里并没有点击通过类选择器选择到的元素 所以在该选择器中选择到的浏览器解析时它不知道到底是哪一个，所以默认打印出第一个id=1	这里的点击事件绑定的是$(".delete_a")

解决方法：
$(".delete_a").click(function (){
alert("通过点击的该删除图标得到对应的furnId= "+$(this).parent().parent().eq(0).children().filter("input[name='furnId']").val());
 })

<input type="hidden" class="furn_id" name="furnId" value="${furn.id}">




如下是当时的情况：
可见点击的就是对应的标签，所以可以准确取到对应的值，因为点击事件里一时的传入了一个this dom对象

  $(function (){
            //方式1
            //老韩思路
            //1. 选择器选择p元素-基础选择器
            //2. 绑定事件-函数-获取p元素的文本
            //3. 统一绑定.
            // 只要是p标签就绑定一个click事件   $("p")即使是单个元素返回也是返回的一个数组对象，取下标为零位置的元素 
            $("p").click(function (){
                //3. 当我们点击p元素时, 会隐式的传入this(dom), 表示你当前点击的p
                //   元素,对应的dom对象
                //alert("p的内容是= " + this.innerText)
                alert("p的内容是(jquer方式)=" + $(this).text())
            })

            //方式2
            //对所有的p元素进行遍历
            //遍历执行内部function 依然会隐式的传入this(表示当前的p的dom对象)
            //这是遍历出一个p对象, 就绑定一个click事件
            $("p").each(function (){
                $(this).click(function (){
                    alert("p的内容~=" + $(this).text())
                })
            })

        })
```

![image-20230723202849337](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230723202849337.png)

---



### 35  请求转发路径前 没加斜杠问题

在jsp页面的a标签中 路径如下

localhost:8080/jiaju_mall/manage/furnServlet?action=showFurn&id=87

![image-20230725000437974](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230725000437974.png)

点击后浏览器进行跳转 

localhost:8080/jiaju_mall/manage/furnServlet?action=showFurn&id=87

![image-20230725000539134](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230725000539134.png)

服务器端进行页面转发的路径

```java
req.getRequestDispatcher("views/manage/furn_update.jsp").forward(req,resp);
```

多级目录结构的servlet-mapping  url-pattern  /manage/furnServlet

请求转发时前面没有写斜杠 / 

相当于req.getRequestDispatcher方法里写的是

”/manage/“+"views/manage/furn_update.jsp"

同样的 第一个斜杠被解析为 http://ip:port/jiaju_mall/

/jiaju_mall/manage/views/manage/furn_update.jsp



参考测试的位置：webpath/com.hspedu.servlet/DispatcherServlet



```java
public class DispatcherServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("DispatcherServlet 被调用...");
        //老师解读 正常情况下：servlet url-pattern书写格式为 /servlet时的规则
        //1. 在服务器端 解析第一个 /时，会被解析成 http://ip:port/项目名[application context]/
        //   老韩再补充： 项目名=> 说成 application context
        //2. "/login.html" => 被解析 http://ip:port/项目名/login.html
        //request.getRequestDispatcher("/login.html").forward(request,response);
        //3. 在服务器进行转发时, 没有 / 就按照默认的方式参考定位 http://ip:port/项目名/
        //   老师建议，仍然使用上面的

        // 特殊情况：servlet—mapping url-pattern 书写格式为 多级目录格式 时
        // 服务器端请求转发路径解析的规则如下：
        /*
        * 相关的文件 web/DispatcherTest.html
        *           web/test/login.html
        */
        
        // /webpath/test/login.html 没有写斜杠时会参考对应Servlet 的
        //<url-pattern>/test/dispatcherServlet</url-pattern>里写的路径
        //拿掉‘dispatcherServlet’ 后使用前面的 /test/ 拼接 请求转发里写的地址 login.html
        // 拼接后为/test/login.html 其中第一个斜杠被解析为 项目名/
        // 最终结果被服务器端解析为 /webpath/test/login.html
        // 服务器端访问的完整是路径http://localhost:8080/webpath/test/login.html
        // 如果此servlet有多级目录 同时再转发时没写/ 相当于写成了/test/login.html
        // 会把url-pattern 中的多级目录结构最后一个斜杠后的Servlet拿掉
        // 再和没写斜杠的字符串进行拼接
        request.getRequestDispatcher("login.html").forward(request,response);


    }
```

---

### 36 数据库update语句 更新不存在的列时 id不存在的问题

~~~mysql
-- ============================================================================

 -- 创建家居表(表如何设计)
-- 设计furn表 家居表
 -- 老师说 需求-文档-界面 
 -- 技术细节
 -- 有时会看到 id int(11) ... 11 表示的显示宽度,存放的数据范围和int 配合zerofill
 --                int(2) .... 2 表示的显示宽度
 --                67890 => int(11) 00000067890
 --                67890 => int(2)  67890
 -- 创建表的时候，一定注意当前是DB
 -- 表如果是第一次写项目，表的字段可能会增加,修改，删除

CREATE TABLE `furn`(
`id` INT UNSIGNED PRIMARY KEY AUTO_INCREMENT, #id
`name` VARCHAR(64) NOT NULL, #家居名
`maker` VARCHAR(64) NOT NULL, #制造商
`price` DECIMAL(11,2) NOT NULL, #价格 定点数
`sales` INT UNSIGNED NOT NULL, #销量
`stock` INT UNSIGNED NOT NULL, #库存
`img_path` VARCHAR(256) NOT NULL #存放图片的路径
)CHARSET utf8 ENGINE INNODB;

-- 因为id没有限制非空 可以为null 执行更新语句时不会报错 只是受影响的行为0 
UPDATE `furn` SET `name`= '123',`maker` =1,`price`=1 ,`sales`=1,`stock`=1 WHERE `id` = NULL;
-- 更新不存在的id号   执行更新语句时不会报错 只是受影响的行为0 
UPDATE `furn` SET `name`= '123',`maker` =1,`price`=1 ,`sales`=1,`stock`=1 WHERE `id` = 0;


~~~

---

### 37 form表单中 后端根据action的值确认调用具体方法 ，action在form表单中的书写位置

![image-20230725152839163](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230725152839163.png)

![image-20230725111938233](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230725111938233.png)

![image-20230725112010699](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230725112010699.png)

![image-20230725112216396](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230725112216396.png)

![image-20230725112134904](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230725112134904.png)

---

### 38 关于是否写bese标签  a标签跳转 细节 

![image-20230727224641250](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230727224641250.png)

如果页面没有写base标签 那么本页的a标签href="#" 

![image-20230727224746255](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230727224746255.png)

点击跳转到本页面 浏览器地址栏地址如下

http://localhost:8080/jiaju_mall/manage/furnServlet?action=lastPage&pageNo=4&pageSize=3#

![image-20230727224934312](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230727224934312.png)



如果写了base标签

![image-20230727225007459](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230727225007459.png)



![image-20230727225050251](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230727225050251.png)

点击跳转到参考base标签下的路径 浏览器地址栏地址如下

http://localhost:8080/jiaju_mall/#

![image-20230727225128507](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230727225128507.png)

参考位置：webpath/a.html

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>a.html</title>
    <!--<base href="/webpath/">-->
</head>
<body>
<h1>这是a.html~~~~~</h1>
<!-- 相对路径
    1. href="d1/d2/b.html" 等价于 http://localhost:8080/项目名/d1/d2/b.html
-->
<a href="d1/d2/b.html">跳转到/d1/d2/b.html</a>
<br/><br/>
<!--
老韩解析
1. 在实际开发中，往往不是直接访问一个资源的而是在服务端进行转发或者重定向来访问资源
2. 演示转发定位 b.html
3. href="servlet03" http://localhost:8080/webpath/servlet03
-->
<!--在没写base标签时 遵守上述规则 参考浏览器地址栏的地址 即拿掉资源名后的路径和href中写的路径进行拼接
点击下面的a标签后地址栏地址为:http://localhost:8080/webpath/servlet03
-->
<a href="servlet03">转发到/d1/d2/b.html</a><br>

<!--在没写base标签时 即默认的使用相对路径作为参考 参考地址栏的地址时 
注意a标签只写#号时,跳转到当前页面 直接在当前地址栏路径屁股后面加一个#作为新的地址
而不会拿掉资源名后再加#
在没写base标签时 不遵守拿掉资源名后再将href中的内容进行拼接  而是直接加载当前页面地址的后面!
点击下面的a标签后地址栏地址为:http://localhost:8080/webpath/a.html#

写了base标签时 直接参考base中的地址
点击下面的a标签后地址栏地址为:http://localhost:8080/webpath/#
-->
<a href="#">只写一个#</a>



</body>
</html>
```



---

### 39 关于多个页面之间 参数传递说明

***如下为 前端页面1 - servlet - 前端页面2 之间的参数传递***

#### 39.1.1 使用域对象request 进行参数传递

```html
manage.jsp
<a href="manage/furnServlet?action=showFurn&id=${furn.id}&pageNo=${requestScope.page.pageNo}">修改</a> 
```

**1.在servlet使用req.getParameter("pageNo"); 接收前端页面1 manage.jsp**

 **通过a href 传递过来的参数**

**2.设置到域对象中**

 request.setAttribute("pageNo"，req.getParameter("pageNo"))

**3.在前端 使用el表达式${requestScope.pageNo}获取参数**



#### 39.1.2 使用el表达式的隐藏对象param进行参数传递

~~~html
manage.jsp
<a href="manage/furnServlet?action=showFurn&id=${furn.id}&pageNo=${requestScope.page.pageNo}">修改</a> 
~~~

**1.在servlet 如果请求带来的参数 pageNo=1 , 而且是请求转发到下一个页面, 在下一个页面可以通过 param.pageNo**

**2.在第二个页面update.jsp 使用el表达式取出**

```html
update.jsp
<input type="hidden" name="pageNo" value="${param.pageNo}">
```

![image-20230729220046019](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230729220046019.png)

![image-20230729214603234](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230729214603234.png)



#### 39.2.1前端页面1  - 前端页面2 之间的参数传递

***如下为 前端页面1  - 前端页面2 之间的参数传递***

**结论：可以使用el表达式 隐藏对象param.参数名进行获取**

```html
manage.jsp
<%--这里直接通过a标签将参数传递过去 --%>
<a href="views/manage/furn_add.jsp?pageNo=${requestScope.page.pageNo}">添加家居</a>
```

```html
add.jsp
<%--两个页面之间通过a href 进行请求参数传递 的方式 可以使用
el表达式 隐藏对象param.参数名进行获取--%>
<input type="hidden" name="pageNo" value="${param.pageNo}">
```

![image-20230729230607972](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230729230607972.png)

![image-20230729230648338](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230729230648338.png)

---

### 40. jstl 标签书写格式错误导致前端页面显示异常问题

![image-20230730122152784](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230730122152784.png)

![image-20230730122007208](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230730122007208.png)

---



### 41 MySQL分页获取数据细节

# 
~~~mysql
-- 分页查询!!!

# LIMIT begin,size; begin从0开始 0对应第一条数据 size 每页的数据条数
# LIMIT start,rows; start+1开始取，取出rows行， start从0开始计算；
-- 推导出一个公式：LIMIT 每页显示的记录数 * (第几页 - 1),每页显示的记录数; 

 -- 第n页
-- 推导出一个公式：LIMIT 每页显示的记录数 * (第几页 - 1),每页显示的记录数; 
SELECT * FROM emp
	ORDER BY empno ASC
	LIMIT 每页显示的记录数 * (第几页 - 1),每页显示的记录数;


-- begin为负数时 查询会报错
SELECT * FROM `furn` 	
	LIMIT -1 , 3;
-- begin为0时 查询不会报错 因为begin 是从0开始的	
SELECT * FROM `furn` 	
	LIMIT 0 , 3;
-- 正常分页查询
SELECT * FROM `furn` 	
	LIMIT 3, 3;

# 当begin 大于等于 最后一条数据行数时 就取不到数据了

SELECT * FROM `furn` 	
	LIMIT 3333, 3;	
~~~



---



### 42 tomcat 启动时访问index页面顺序

![image-20230730182548665](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230730182548665.png)

**tomcat conf/web.xml配置文件 中规定的启动tomcat访问项目index文件的顺序	**

**注意：如果没有index.jsp 文件也没有会报错 缺少文件**

![image-20230730182742191](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230730182742191.png)



---

### 43 DAO层构建sql为模糊查询时书写格式细节



![image-20230731000306796](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230731000306796.png)

```java
@Override
public int getTotalRowByName(String name) {
    //构建Sql
    String sql = "SELECT COUNT(*) FROM `furn` WHERE `name` LIKE ?"; // 正确写法

    //String sql = "SELECT COUNT(*) FROM `furn` WHERE `name` LIKE '%?%'"; // 报错
    //String sql = "SELECT COUNT(*) FROM `furn` WHERE `name` LIKE '%"+"?"+"%'"; // 报错

    // 返回包含name的总记录数totalCount
    Object totalCount = queryScalar(sql, "%"+name+"%");// 正确写法
    
    //Object totalCount = queryScalar(sql, name);// 报错
    // 因为这里的totalCount查询返回来的运行类型是Long类型 所以先要转成Number类型

    return ((Number) totalCount).intValue();
}
```

**和 MD5(?) 不同** 	 **MD5(?)的？可以直接写在MD5()的括号内**

而模糊查询 需要在传参给?时 如上面代码在queryScalar(sql, "%"+name+"%");的时候

拼接上%或_  将 %name% 当成一个整体传给sql语句中的问号	

```java
//方法，根据empId 和 pwd 返回一个Employee对象
public Employee getEmployeeByIdAndPwd(String empId, String pwd) {
    return employeeDAO.querySingle("select * from employee where empId = ? and pwd = MD5(?)", Employee.class, empId, pwd);

}

 if(employeeDAO.update("INSERT INTO employee VALUES(NULL, ?, MD5(?),?,?);", empId, pwd, name, job) <= 0){
            return false;
        }
```

---



### 44  MySQL 模糊查询细节

下面这种地址栏填了name=	但是没有填value值	在servlet获取时

```java
String name = req.getParameter("name");
// 有name属性 获取到空串”“	不存在name属性 获取到null

```

![image-20230731013637844](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230731013637844.png)

地址栏传的值为name=	

相当于传了一个空字符串”“	类似下面这种

![image-20230731012805057](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230731012805057.png)

![image-20230731013314981](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230731013314981.png)

但是在SQLyog 中 如下这样写得到的结果：

~~~mysql
SELECT COUNT(*) FROM `furn` WHERE `name` LIKE '%""%';	# 结果为0
SELECT COUNT(*) FROM `furn` WHERE `name` LIKE '%%';	
# 结果为 75 返回所有数据

# 即在java后端传入一个空串"" 相当于下面这种查询！
SELECT COUNT(*) FROM `furn` WHERE `name` LIKE '%%';
~~~

---

### 45 img src"#" 请求当前页面的问题

```jsp
<%--img src="#" 会去请求当前页url http://localhost:8080/jiaju_mall/# --%>
<%--<img src="#" alt="">--%>
```

![image-20230731171122638](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230731171122638.png)

![image-20230731171056978](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230731171056978.png)



---

### 46 前端页面中的img 图片 首次访问会请求一次，第二次重复请求地址会请求两次

tomcat重新发布后 第一次请求

http://localhost:8080/jiaju_mall/manage/furnServlet?action=page

![image-20230731175852380](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230731175852380.png)

![image-20230731180107380](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230731180107380.png)

第二次重复请求

http://localhost:8080/jiaju_mall/manage/furnServlet?action=page

![image-20230731180221588](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230731180221588.png)

---



### 47 修改文件名后缀 **do refactor**	联动修改

**refactor**	重构

**do refactor**	联动修改

![image-20230731233745602](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230731233745602.png)

![image-20230731233808555](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230731233808555.png)

![image-20230731233455747](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230731233455747.png)

**注释不会修改**

---



### 48 直接访问 http://localhost:8080/jiaju_mall 会被重定向到 http://localhost:8080/jiaju_mall/

![image-20230801022707991](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230801022707991.png)

**Location**	位置;定位;地点;地方;

---



### 49 页面加载后 点击登录注册按钮后  还没点击验证码绑定的事件进行发送请求时 图片默认发出了一次请求

![image-20230801180604522](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230801180604522.png)

![image-20230801180834112](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230801180834112.png)

![image-20230801180904466](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230801180904466.png)

![image-20230801180950153](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230801180950153.png)

**在加载页面的时候 你还没点 它已经去了一次kaptchaServlet**



---



### 50 修改了 web.xml 文件后需要重新发布才会生效！

虽然热加载 也把out目录下的web.xml文件 更新了 但是配置并不会及时生效！！



---

### 51 页面加载时 img 的src属性向后端发送请求

```html
<img alt="" id="codeImg" src="kaptchaServlet" style="width: 120px;height:50px">
```

---

### 52 JQuery 中 $ 作用

```
1、作为jQuery包装器，利用选择器来选择DOM元素（这个也是最强大的功能）
例如：
$("table tr:nth-child(even)")
2、实用工具函数，作为几个通用的实用工具函数的命名空间的前缀
例如：
$.trim(someString)
3、文档就绪处理程序，相当于$(document).ready(...)
例如：
$(function(){...}); //里面的函数会在DOM树加载完之后执行
4、创建DOM元素
例如：
$("<p>how are you?</p>")
5、扩展jQuery
例如：
$.fn.disable = function(){...}
6、使用jQuery和其他库
例如：Prototype库也是使用$符号，jQuery提供noConflict函数避免冲突，
jQuery.noConflict();把$符号还原到非jQuery库定义的含义。
```

```js
//验证码不可以为空的前端验证
var codeText = $("#code").text();
/*2、实用工具函数，作为几个通用的实用工具函数的命名空间的前缀
    例如：
    $.trim(someString)*/
// 去掉验证码前后空格
codeText = $.trim(codeText);
if ("" == codeText || null == codeText){
    //提示信息
    $("span.errorMsg").text("验证码不能为空")
    return false;
}
```

---

### 53 小技巧 idea todo标记

**预留一个以后需要添加代码逻辑的todo标记，**

**点击下方的TODO 就会显示出在某某文件的**

**第几行 留有一个todo标记**

![image-20230802175651879](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230802175651879.png)

---

### 54 idea 提示Cannot resolve directory 'views'  但是该目录/文件存在 前端点击没反应

问题不是Cannot resolve directory 'views'  而是a标签的class中 根据

$(".offcanvas-toggle") 进行了处理 



一个html元素的 class可以有多个 使用空格进行间隔

```
class="header-action-btn header-action-btn-cart offcanvas-toggle pr-0"
```

![image-20230803181042078](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230803181042078.png)

![image-20230803181303675](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230803181303675.png)

![image-20230803183908611](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230803183908611.png)

**解决方法：**

**使用全局搜索关键字 查找该class 属性 调用的位置 看看到底干了什么！**

![image-20230803185039301](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230803185039301.png)

![image-20230803185139067](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230803185139067.png)

![image-20230803185459816](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230803185459816.png)

![image-20230803185718938](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230803185718938.png)

![image-20230803190229362](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230803190229362.png)



---

### 55 返回BigDecimal类型的参数 前端页面也可以使用el表达式取出

![image-20230803192323405](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230803192323405.png)

![image-20230803192301827](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230803192301827.png)

![image-20230803192232378](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230803192232378.png)

---



### 56 BigDecimal add方法注意事项 原来的值不会受影响

bigDecimalTotalPrice.add(cartItem.getTotalPrice()); 只是返回的一个结果 
对原来的值bigDecimalTotalPrice 没有影响！！

```java
public BigDecimal getCartTotalPrice() {
//public Integer getTotalPrice() {
    BigDecimal bigDecimalTotalPrice = new BigDecimal(0);
    //Integer totalPrice = 0;
    //遍历items集合
    Set<Integer> keyset = items.keySet();
    for (Integer id : keyset) {
        CartItem cartItem = items.get(id);
        //老师提醒, 一定要包add后的值, 重新赋给 cartTotalPrice, 这样才是累加.
        // bigDecimalTotalPrice.add(cartItem.getTotalPrice()); 只是返回的一个结果 
        // 对原来的值bigDecimalTotalPrice 没有影响！！
        bigDecimalTotalPrice = bigDecimalTotalPrice.add(cartItem.getTotalPrice());
    }
    return bigDecimalTotalPrice;
    //return bigDecimalTotalPrice.intValue();
}
```



---

### 57 当a标签的class值的数量为多个时，选择该a标签的方法

**只选择a标签元素的class属性的值的 其中的一个值， 就可以选中该a标签，而不用按照/根据此属性值前的一些值进行选**择

![image-20230804135210529](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230804135210529.png)

![image-20230804135120388](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230804135120388.png)

例子2

![image-20230804135416952](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230804135416952.png)

![image-20230804135434991](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230804135434991.png)

---



### 58 当jsp文件和main.js 文件中有两段逻辑相同的js代码时 同时生效

将下面这段代码 拿到jsp页面为我所用 注意

原来的js代码一定要注销 否则点一次加号/减号 会加/减两次

因为此时在jsp文件和main.js 文件中有两段逻辑相同的js代码

![image-20230804200926891](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230804200926891.png)



![image-20230804200755305](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230804200755305.png)

---



### 58 前面使用set 后面一般使用get进行获取

因为直接传进来的count可能不是我们最终要的数据 可能在setCount()方法中

进行数据的处理 比如边界的处理/数据格式的校验... 

![image-20230804224831515](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230804224831515.png)

```java
/**
 * 修改指定的CartItem的数量和总价, 根据传入的id 和 count
 *
 * @param id
 * @param count
 */
public void updateCount(int id, int count) {

    CartItem item = items.get(id);
    if (null != item) {//如果得到CartItem
        //先更新数量
        item.setCount(count);
        //再更新总价 这里的参数填item.getCount() 从item对象来取更加合理
        // 更符合oop的原则 前面使用set 后面一般使用get进行获取
        //因为直接传进来的count可能不是我们最终要的数据 可能在setCount()方法中
        //进行数据的处理 比如边界的处理/数据格式的校验... 
        item.setTotalPrice(item.getPrice().multiply(new BigDecimal(item.getCount())));
    }

}
```

---

### 59 MySQL 命名 多单词时 使用下划线比较好，不建议使用驼峰命名法

---

### 60 数据库是datetime类型  java中可以直接传进去一个java.util.Date 类型 是正确的 不用进行格式化

![image-20230807104357527](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230807104357527.png)

![image-20230807104335935](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230807104335935.png)

<img src="https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230807104433982.png" alt="image-20230807104433982" style="zoom:150%;" />

---

### 61 JavaBean中的get()方法 返回值类型写了具体的泛型 在调用该get()方法时 alt+enter/.var才会自动补全具体泛型！

![image-20230807122648105](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230807122648105.png)

![image-20230807122909019](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230807122909019.png)

---

### 62 请求转发不会走过滤器！！！重定向是会走过滤器的！！！

```java
public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
    System.out.println("AuthFilter doFilter() 被调用...");

    HttpServletRequest request = (HttpServletRequest) req;

    // GET /jiaju_mall/views/manage/manage_login.jsp HTTP/1.1
    // 得到url
    String url = request.getServletPath();
    System.out.println("url=" + request.getServletPath());
    // url=/views/manage/manage_login.jsp
    System.out.println("url=" + request.getRequestURL());
    // url=http://localhost:8080/jiaju_mall/views/manage/manage_login.jsp

    Member member = (Member)request.getSession().getAttribute("member");

    // 只是对象进行比较 把member对象写在前面也是可以的 因为没有 member.什么东西
    if (member == null){
        // 说明没有登录过
        // 转发到用户登录页面
        // 请求转发不会走过滤器！！！
        // 直接转发到/views/member/login.jsp 返回给浏览器这个事就结束了
        //System.out.println("AuthFilter doFilter 中 转发到用户登录页面");
        //req.getRequestDispatcher("/views/member/login.jsp").forward(req,resp);

        // 重定向是会走过滤器的！！！
        // 浏览器请求访问/views/member/login.jsp 与过滤器匹配上了 在没有登录时
        // 会走下面的重定向 重定向后的页面又和过滤器配置的url-pattern 匹配上 进入
        // 过滤器的doFilter 判断没有登录 再次请求转发
        /*此页面不能正确地重定向
        Firefox 检测到该服务器正在将指向此网址的请求无限循环重定向。
            有时候禁用或拒绝接受 Cookie 会导致此问题。
        */
        System.out.println("AuthFilter doFilter 中重定向到用户登录页面");
        ((HttpServletResponse)resp).sendRedirect(request.getContextPath() + "/views/member/login.jsp");
        return; // 直接返回 不走了
    }

    // 登录过 直接放行 访问请求的资源
    chain.doFilter(req, resp);
}
```



![image-20230809134416208](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230809134416208.png)

![image-20230809133943877](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230809133943877.png)

![image-20230809134703728](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230809134703728.png)



---

### 63 优化JDBCUtilsByDruid.java 的getConnection()   保证同一次请求/同一个线程 中 使用的是同一个connection连接对象 后  进行第二次数据库操作时出现了异常：java.lang.RuntimeException: java.sql.SQLException:

结论 ： 已经**放回**数据库连接池的连接对象 **即使持有**该对象的地址值也**不能**对数据库进行操作！！！

![image-20230811192641911](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230811192641911.png)

```java
JDBCUtilsByDruid.java 

//开发通用的dml方法, 针对任意的表
    public int update(String sql, Object... parameters) {

        Connection connection = null;

        try {
            connection = JDBCUtilsByDruid.getConnection();
            int update = qr.update(connection, sql, parameters);
            return  update;
        } catch (SQLException e) {
           throw  new RuntimeException(e); //将编译异常->运行异常 ,抛出
        }
        // 使用事务管理 进行优化后 下面的执行一次数据库操作就关闭该连接的操作
        // 就要注销掉 放在了 commit() 和 rollback() 方法中 在执行完所有的
        // 数据库操作后再进行关闭连接 因为在事务操作中 为了保证数据一致性 使用的
        // 是同一个数据库连接 connection对象 如果其中有dml操作出错 可以统一进行
        // 事务提交和回滚操作！！
        //finally {
        //    JDBCUtilsByDruid.close(null, null, connection);
        //} 如果留着这里的关闭 会导致在同一个线程/同一次请求中
        // 使用同一个connection对象 再次对数据库操作失败

}
//======================================================    
//改写getConnection方法 使同一次请求 用的是一个连接对象 事务管理
//public static Connection getConnection() throws SQLException {
public static Connection getConnection(){
    // 使用优化后的getConnection() 方法 会导致 到 数据库模糊 查询 出问题

    //return ds.getConnection();
    Connection connection = threadLocalConn.get();
    if (connection == null){
        try {
            connection = ds.getConnection();
            // 从数据库连接池中拿到连接后 立马将自动提交设置为false
            // 改为手动提交
            //connection.setAutoCommit(false);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        threadLocalConn.set(connection);

    }

    return connection;

}
```

```java
Basic.java
    
/**
 *
 * @param sql sql 语句，可以有 ?
 * @param clazz 传入一个类的Class对象 比如 Actor.class
 * @param parameters 传入 ? 的具体的值，可以是多个
 * @return 根据Actor.class 返回对应的 ArrayList 集合
 */
public List<T> queryMulti(String sql, Class<T> clazz, Object... parameters) {

    Connection connection = null;
    try {
        connection = JDBCUtilsByDruid.getConnection();
        return qr.query(connection, sql, new BeanListHandler<T>(clazz), parameters);

    } catch (SQLException e) {
        throw  new RuntimeException(e); //将编译异常->运行异常 ,抛出
    } finally {
        JDBCUtilsByDruid.close(null, null, connection);
    }

}
```

```java
JDBCUtilsByDruid.java 

//关闭连接, 老师再次强调： 在数据库连接池技术中，close 不是真的断掉连接
//而是把使用的Connection对象放回连接池
public static void close(ResultSet resultSet, Statement statement, Connection connection) {

    try {
        if (resultSet != null) {
            resultSet.close();
        }
        if (statement != null) {
            statement.close();
        }
        if (connection != null) {
            connection.close();
        }
    } catch (SQLException e) {
        throw new RuntimeException(e);
    }
}
```





```java
furnDAOImpl.java

/**
 * 根据传入的家居名 包含此家居名的 家居信息
 *
 * @param name
 * @param begin 从第begin+1条数据开始取
 * @param pageSize 每页的取出多少记录
 * @return 返回根据名字查询出来的结果 分页后的
 * @return
 */
@Override
public List<Furn> getPageItemsByName(String name,int begin, int pageSize) {

    // 构建Sql
    String sql = "SELECT `id`,`name`,`maker`,`price`,`sales`,`stock`,`img_path` `imgPath` FROM `furn` where `name` LIKE ? LIMIT ?, ?";

    // 返回包含name的所有的furn数据的List集合
    List<Furn> furns = queryMulti(sql, Furn.class, "%"+name+"%",begin,pageSize);

    return furns;
}
```

```java
@Test
public void getPageItemsByName(){

    //List<Page> pageItems = pageDAO.getPageItems(0, 3);
    //System.out.println(pageItems);

    //System.out.println(furnDAO.getPageItemsByName("aa"));

   System.out.println(furnDAO.getPageItemsByName("",0,3));
System.out.println(furnDAO.getPageItemsByName("小椅子",0,3)); 

} // 第二次进行数据库操作时出现异常
//java.lang.RuntimeException: java.sql.SQLException: connection holder is null Query: SELECT `id`,`name`,`maker`,`price`,`sales`,`stock`,`img_path` `imgPath` FROM `furn` where `name` LIKE ? LIMIT ?, ? Parameters: [%小椅子%, 0, 3]

```



原因是 执行过第一次sql操作后 在Basic.java的 queryMulti()等工具方法中 每执行一次工具方法 queryMulti() 在其方法中 已经关闭了当前connection的连接 已经放回了数据库连接池  再执行第二次请求时

从threadLocal 中取得的在该线程 第一次放入的connection连接对象

是已经放回了数据库连接池！ 就不可以对数据库进行操作了！

结论 ： 已经**放回**数据库连接池的连接对象 **即使持有**该对象的地址值也**不能**对数据库进行操作！！！

---

### 64 发生异常 优先执行最近的类 中try-catch 

```java
OrderServlet.java


 String orderId = null;
try {
    // 下面这行代码 发生异常 不论connection是否设置了自动提交 
    // 即这里发生了异常 就会先走本类里的try-catch 不会走上一个调用者
    // BasicServlet.java  doPost()中
    // declaredMethod.invoke(this, req, resp); 外面的try-catch
    
    orderId = orderService.saveOrder(cart, member.getId());
    JDBCUtilsByDruid.commit();
} catch (Exception e) {
    JDBCUtilsByDruid.rollback();
    e.printStackTrace();
}
```

```java
BasicServlet.java

try {
    // 通过反射动态的获取 this对象/当前对象 的相关方法

    // 这里的 this对象是动态的，方法名action也是动态的
    // action 如果为null 下面这行代码空指针异常 getDeclaredMethod()方法中 使用 action.方法 了 ==> name.intern()
    Method declaredMethod = aClass.getDeclaredMethod(action,HttpServletRequest.class,HttpServletResponse.class);
    // 通过 invoke 方法调用 declaredMethod方法对象的方法

    // 说明： invoke方法
    // 第一个参数：是declaredMethod 获取的方法对应的类的对象 即此时是实现子类的MemberServlet对象
    // 此时传入的this 是通过动态绑定 运行类型是子类MemberServlet对象
    // 第二三个参数 是传入方法名为方法action(实际上是login或register等方法)的 实参
    //使用方法对象，进行反射调用
    //Object invoke = declaredMethod.invoke(this, req, resp);
    declaredMethod.invoke(this, req, resp);
    // 到这里 就已经走通了！！
    //System.out.println("invoke= " + invoke);// invoke= null
    //System.out.println("invoke.getClass()= " + invoke.getClass());// 空指针异常

} catch (Exception e) {
    

    e.printStackTrace();
}
```

 **将发生的异常继续抛出**
**否则doFilter中捕获不到异常 被catch处理后 后面的catch没有机会捕获！**

```java



public abstract class BasicServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 将子类的doPost() 提到抽象父类BasicServlet
        System.out.println("BasicServlet doPost() 被调用...");

        // 在获取参数之前设置编码格式
        // 处理中文乱码问题 一定要设置在获取参数之前    在获取参数中间设置编码格式不好使
        req.setCharacterEncoding("utf-8");

        // 取出 action
        String action = req.getParameter("action");
        System.out.println("action= " + action);

        // 通过反射获取 this对象  对应的方法
        // 1.this 对象 就是请求的Servlet   通过动态绑定 这里是实现子类的MemberServlet对象
        // 2.2.declaredMethod 方法对象就是当前请求的servlet对应的"action名字" 的方法, 该方法对象(declaredMethod)
        //System.out.println("this= " + this);//this= com.hspedu.furns.web.MemberServlet@12478698
        //  是变化的,根据用户请求
        //3. 老韩的体会：使用模板模式+反射+动态机制===> 简化多个 if--else if---..

        // 通过反射获取 子类Servlet对象
        Class<? extends BasicServlet> aClass = this.getClass();
        // getDeclaredMethod(action,req,resp); 填入方法名 方法形参的数据类型对应的Class对象
        //Method declaredMethod = aClass.getDeclaredMethod(action,req,resp);// 这里不可以填入 req,resp对象 应该填入 方法形参的数据类型对应的Class对象
        try {
            // 通过反射动态的获取 this对象/当前对象 的相关方法

            // 这里的 this对象是动态的，方法名action也是动态的
            // action 如果为null 下面这行代码空指针异常 getDeclaredMethod()方法中 使用 action.方法 了 ==> name.intern()
            Method declaredMethod = aClass.getDeclaredMethod(action,HttpServletRequest.class,HttpServletResponse.class);
            // 通过 invoke 方法调用 declaredMethod方法对象的方法

            // 说明： invoke方法
            // 第一个参数：是declaredMethod 获取的方法对应的类的对象 即此时是实现子类的MemberServlet对象
            // 此时传入的this 是通过动态绑定 运行类型是子类MemberServlet对象
            // 第二三个参数 是传入方法名为方法action(实际上是login或register等方法)的 实参
            //使用方法对象，进行反射调用
            //Object invoke = declaredMethod.invoke(this, req, resp);
            declaredMethod.invoke(this, req, resp);
            // 到这里 就已经走通了！！
            //System.out.println("invoke= " + invoke);// invoke= null
            //System.out.println("invoke.getClass()= " + invoke.getClass());// 空指针异常

        } catch (Exception e) {
            // java基础 异常机制
            // 将发生的异常继续抛出
            // 否则doFilter中捕获不到异常 被catch处理后 后面的catch没有机会捕获！
            throw new RuntimeException(e);
            //e.printStackTrace();
        }


    }
}
```





---

### 65 ajax的url路径怎么写？

比如你的页面路径是：http://localhost:8080/projectname/resource/index.html

url请求最后加.do是为了服务器区分这个请求是静态资源还是servlet请求（后边有.do就是servlet请求）

1、相对于网站根目录可以用"/"开始 (根目录是指服务器的根目录，不是你项目的根目录)

~~~java
$ajax({
	url:"/getData.do";
})
~~~

**该方式请求的路径为**：http://localhost:8080/getData.do

2、“../”表示页面目录的上一级目录

~~~java
$ajax({
	url:"../getData.do;
})
~~~

**该方法请求的路径是**：http://localhost:8080/projectname/getData.do

3、项目的根路径

~~~java
$ajax({
	url:"getData.do";
})	
~~~



**该方式的请求路径**：http://localhost:8080/projectname/getData.do

4、全路径

~~~
$ajax({
	url:"http://localhost:8080/projectname/getdata.do";
})	

~~~

**该方式的请求路径**：http://localhost:8080/projectname/getdata.do



**springMVC如果是这样写的请求映射**

~~~java
@RequestMapping("/user")
@Controller
public  class UserController{
@RequestMapping("/register")
public @ResponseBody JsonMessageObject register(@RequestBody UserInfoPo userInfoPo){
~~~

如果我们要请求register这个方法，url：…/user/register.do这样写
因为页面路径是这样http://localhost:8080/projectname/resource/index.html
让servlet映射请求跟在项目路径http://localhost:8080/projectname后面就可以了
最终请求的路径是http://localhost:8080/projectname/user/register.do

以上就是ajax的url路径怎么写

---

### 66 Ajax发出的请求 在服务器端也是用HttpServletRequest 请求对象进行处理吗？

**是**

---



### 67 浏览器发出的ajax请求在服务器端进行重定向和请求转发会失效问题

**3.** **测试，你会发现针对** **ajax** **的重定向和请求转发会失效,** **也就是** **AuthFilter.java的权限拦截没用了,也就是我们点击add to cart ,后台服务没有响应， 怎么办?**

**●** **使用** **ajax** **向后台发送请求跳转页面无效的原因**

**1.** **主要是服务器得到是ajax发送过来的request,也就是说这个请求不是浏览器请求的,而是ajax 请求的所以,servlet对request 进行请求转发或重定向都不能影响浏览器的跳转**

**2.** **这时出现请求转发和重定向失效的问题**

**3.** **解决方案：如果想要实现跳转，可以返回** **url,** **在浏览器执行** **window.location(url)**



如果是Ajax请求  请求头 会有一个  

**X-Requested-With：XMLHttpRequest**

![image-20230813190522365](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230813190522365.png)



```java
/**
 * 判断该请求是否为ajax请求
 * @param httpServletRequest
 * @return 返回true 是ajax请求
 */
public static boolean isAjaxRequest(HttpServletRequest httpServletRequest){
    return "XMLHttpRequest".equals(httpServletRequest.getHeader("X-Requested-With"));
}
```



---



### 68 注意 是给form表单绑定onsubmit事件 而不是给form表单中的input元素绑定onsubmit事件！！！



---

### 69 使用文件阅读器处理过的 input type="file"不再显示 丑陋的【浏览...】字样

![image-20230815140901027](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230815140901027.png)

**具体原因是 给文件类型的 input[name="pic"] 设置了css样式**

 ***opacity: 0*，表示完全透明**

 

```html
<style>

    input[name="pic"] {
        /*不可以使用 此定位 而是根据显示的图片 进行定位！！！*/
        position: absolute;
        left: 0;
        top: 0;
        height: 200px;
        opacity: 0;

        /*cursor: pointer
        是指当鼠标移动到元素上时,鼠标指针的形状会发生变化,变成一只		  手,表示该元素可以被点击。*/
        cursor: pointer;
    }
</style>
```







```java
<%--
  Created by IntelliJ IDEA.
  User: 韩顺平
  Version: 1.0
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>FileUpload</title>
    <%--http://localhost:8080/fileupdown/upload.jsp--%>
    <!-- 指定了base标签 -->
    <base href="<%=request.getContextPath()+"/"%>>">
    <style type="text/css">
        input[type="submit"] {
            outline: none;
            border-radius: 5px;
            cursor: pointer;
            background-color: #31B0D5;
            border: none;
            width: 70px;
            height: 35px;
            font-size: 20px;
        }

        img {
            border-radius: 50%;
        }

        form {
            position: relative;
            width: 200px;
            height: 200px;
        }

        input[name="pic"] {
            position: absolute;
            left: 0;
            top: 0;
            height: 200px;
            opacity: 0;
            cursor: pointer;
        }
        input[name="pic2"] {
            position: absolute;
            left: 0;
            top: 244px;
            height: 200px;
            opacity: 0;
            cursor: pointer;
        }
    </style>

    <script type="text/javascript">
        function prev(event) {
            //获取展示图片的区域
            var img = document.getElementById("prevView");
            //获取文件对象
            var file = event.files[0];
            //获取文件阅读器： Js的一个类，直接使用即可
            var reader = new FileReader();
            reader.readAsDataURL(file);
            reader.onload = function () {
                //给img的src设置图片url
                img.setAttribute("src", this.result);
            }
        }
        function prev2(event) {
            //获取展示图片的区域
            var img2 = document.getElementById("prevView2");
            //获取文件对象
            var file2 = event.files[0];
            //获取文件阅读器： Js的一个类，直接使用即可
            var reader2 = new FileReader();
            reader2.readAsDataURL(file2);
            reader2.onload = function () {
                //给img的src设置图片url
                img2.setAttribute("src", this.result);
            }
        }
    </script>

</head>
<body>
<!-- 表单的enctype属性要设置为multipart/form-data
    enctype="multipart/form-data" 表示提交的数据是多个部分构造，有文件和文本
 -->

<form action="fileUploadServlet" method="post"  enctype="multipart/form-data">
    家居图1: <img src="2.jpg" alt="" width="200" height="200" id="prevView">
    家居图2: <img src="2.jpg" alt="" width="200" height="200" id="prevView2">
<%--    小伙伴愿意完成自己测试--%>
    <input type="file"/><br>

    <input type="file" name="pic" id="" value="" onchange="prev(this)"/>
    <input type="file" name="pic2" id="" value="" onchange="prev2(this)"/>

    家居名: <input type="text" name="name"><br/>
    家居名: <input type="text" name="name"><br/>

    <input type="submit" value="上传"/>
</form>
</body>
</html>
```



---

### 70 form 表单enctype 默认提交方式和文件上传时多部分提交方式的不同

```jsp
<form action="manage/furnServlet" method="post">
    
不写 enctype属性 等价于下面这种 
默认为application/x-www-form-urlencoded
    
<form action="manage/furnServlet" method="post" enctype="application/x-www-form-urlencoded">

```



```jsp
<%--<form action="manage/furnServlet" method="post"  enctype="multipart/form-data">--%>
```

**默认的form表单提交数据的方式：**

![image-20230816001418296](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230816001418296.png)

**form表单设置enctype 多部分的  提交数据的方式：**

![image-20230816001941951](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230816001941951.png)



**如果你的表单是enctype="multipart/form-data", req.getParameter("id") 得不到id**

![image-20230816005351446](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230816005351446.png)



**解决方案：** 通过form表单的action属性 带过去，即通过url带过去!!!

```jsp
<form action="manage/furnServlet?action=update&id=${requestScope.furn.id}&pageNo=${param.pageNo}" method="post"  enctype="multipart/form-data">
```

![image-20230816005608758](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230816005608758.png)





---

### 71 req.getParameter("id")  可以接收ajax请求的参数/url/默认的form表单提交数据方式

![image-20230816002528297](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230816002528297.png)

![image-20230816002559022](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230816002559022.png)



**ajax 发送请求的方式 是：在底层处理 拼接成常规的url 所以在服务器端可以使用 req.getParamter()的方式获取参数**！



![image-20230816002752870](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230816002752870.png)







---

### 72 tomcat如果配置了 error-page ，倘如程序内部发生错误 服务器端不会抛出对应的异常，而是直接跳转到web.xml 中配置的error-page页面 ，若想看到具体的异常信息,需要先将配置的对应异常的error-page 注销掉才能看到

前提是 在抛出异常后没有手动打印 而是直接抛出一个异常，如下面直接抛出了一个运行异常，才看不到，手动打印了的在后端可以看到

![image-20230816003701969](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230816003701969.png)

---



![image-20230816004058475](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230816004058475.png)

**但是浏览器会跳转到 配置的error-page 页面 ，**

**浏览器不会显示错误信息**

![image-20230816004122876](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230816004122876.png)





***如何才可以使前端 在发生错误后不跳转到指定的error-page页面，而是显示具体的错误信息呢？ 注销掉error-page配置***



如果是程序内部发生错误 注销掉配置的

<error-page>

<error-code>500</error-code> 对应的配置信息即可



如果是找不到文件 注销掉配置的

<error-page>

<error-code>404</error-code> 对应的配置信息即可

```xml
<!--500错误提示页面-->
<error-page>
    <error-code>500</error-code>
    <location>/views/error/500.jsp</location>
</error-page>
```



---



### 73 HttpServletRequest 获取真实的运行路径时,前面到底加不加"/"问题 

推荐**加上** 因为老韩是这样处理的 

**req.getServletContext().getRealPath("/"+imgPath);**

**获取到的是 项目真实的运行时的路径！！！**

*D:\Java_developer_tools\javaweb\jiaju_mall\out\artifacts\jiaju_mall_war_exploded\assets\images\product-image\14.jpg*



```java
System.out.println("imgPath= " + imgPath);
// imgPath= assets/images/product-image/14.jpg

String realImgPath1 = req.getServletContext().getRealPath(imgPath);
System.out.println("realImgPath1= " + realImgPath1);
// realImgPath1= D:\Java_developer_tools\javaweb\jiaju_mall\
// out\artifacts\jiaju_mall_war_exploded\assets\images\product-image\14.jpg

String realImgPath2 = req.getServletContext().getRealPath("/"+imgPath);
System.out.println("realImgPath2= " + realImgPath2);
// realImgPath2= D:\Java_developer_tools\javaweb\jiaju_mall\
// out\artifacts\jiaju_mall_war_exploded\assets\images\product-image\14.jpg

// 即req.getServletContext().getRealPath(imgPath)和req.getServletContext().getRealPath("/"+imgPath)没有区别
// 都是从根目录开始计算的！！！
```

---

### 74 file.mkdir();和file.createNewFile();的区别

file.mkdir();//创建一级目录 创建的是目录文件 即目录

file.createNewFile();//没有后缀名也可以创建成功 创建的是文件 即文件 文件类型为.

```java
@Test
public void test2(){
    //判断 e:\\demo02 是否存在，如果存在就删除,否则提示不存在
    File file = new File("E:\\demo02");//文件目录，也是特殊的文件

    if (file.exists()){
        if (file.delete()){
            System.out.println("删除成功");
        }else {
            System.out.println("删除失败");
        }
    }else {
        System.out.println("该文件不存在");
        //file.mkdir();//创建一级目录 创建的是目录文件 即目录
        try {
            file.createNewFile();//没有后缀名也可以创建成功 创建的是文件 即文件 文件类型为.
        } catch (IOException e) {
            e.printStackTrace();
        }
        System.out.println("目录创建成功");
    }
}
```

---

### 75 关于创建文件new File() 时 不同运行环境中  前面加不加斜杠的问题

结论：取决于程序的运行环境 根据运行环境的不同 参考的路径也不同

如：

**在Junit Test测试类中 运行：**

 前面**带了斜杠**创建文件时的参考路径是**D盘根目录** ，

前面**没带斜杠**创建文件时的参考路径是当前Tset测试用例所在的 **Module的根目录**

---



**在main方法中 运行：**

 前面**带了斜杠**创建文件时的参考路径是**D盘根目录** ，

前面**没带斜杠**创建文件时的参考路径是当前Tset测试用例所在的 **项目的根目录**

---

**在tomcat中 运行：**

 前面**带了斜杠**创建文件时的参考路径是**D盘根目录** ，

前面**没带斜杠**创建文件时的参考路径是当前Tset测试用例所在的 **Tomcat 运行的bin目录，即会在bin目录下创建文件！！！**



运行结果：

测试的代码 运行所处的环境 是Tomcat 环境

FileDownloadServlet 被调用...
downLoadFileFullPath= /download/1.jpg
mimeType= image/jpeg
该文件不存在
文件绝对路径：D:\testFile
文件创建成功
该文件2不存在
文件2绝对路径：D:\Java_developer_tools\javaweb\apache-tomcat-8.0.50-windows-x64\apache-tomcat-8.0.50\bin\txestFile2
文件2创建成功

---

### 76 关于配置tomcat 时 ApplicationContext的说明

**建议和项目名保持一致** 	

![image-20230922185506624](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230922185506624.png)

可以直接写一个斜杠 后面什么都不写

但是如果tomcat中管理有多个项目 

都没有写项目名而是 直接写了一个 斜杠“/”

就不知道哪个是哪个了





---

# 77 测试如果ApplicationContext不以斜杠开头： 





![image-20230922190111192](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230922190111192.png)



![image-20230922190903308](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230922190903308.png)



![image-20230922190929285](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230922190929285.png)



![image-20230922191141366](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20230922191141366.png)

**即使不写也会自动补上 但是建议还是写上**

