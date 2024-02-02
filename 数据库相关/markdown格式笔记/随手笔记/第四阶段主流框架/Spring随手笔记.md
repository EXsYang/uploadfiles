**Spring 其实学的是SpringFramework**
Spring是一组框架

**Spring**	弹簧;春天，春季;

# 1 关于spring文件中的jar包说明

![image-20230829195626194](D:\TyporaPhoto\image-20230829195626194.png)

---

![image-20230829204148413](D:\TyporaPhoto\image-20230829204148413.png)

![image-20230829204111661](D:\TyporaPhoto\image-20230829204111661.png)



ioc 容器对象是一个重量级的对象 很大 创建很耗费资源，因此一般只创建一个就够了



---

# 2 Spring 容器创建

**把容器配置文件 放在src目录下面去 不要乱放**



![image-20230830134139652](D:\TyporaPhoto\image-20230830134139652.png)

文件的名字是随意的 这里老韩取名为beans



![image-20230830135722698](D:\TyporaPhoto\image-20230830135722698.png)



![image-20230830134504041](D:\TyporaPhoto\image-20230830134504041.png)

![image-20230830134621236](D:\TyporaPhoto\image-20230830134621236.png)

**unmapped**	映射;非映射

![image-20230830134736911](D:\TyporaPhoto\image-20230830134736911.png)

![image-20230830134909087](D:\TyporaPhoto\image-20230830134909087.png)

![image-20230830135038336](D:\TyporaPhoto\image-20230830135038336.png)

做完这些之后 就不再有提示了

![image-20230830135250712](D:\TyporaPhoto\image-20230830135250712.png)



---

# 3 类加载路径

![image-20230830145934217](D:\TyporaPhoto\image-20230830145934217.png)

**默认会把src 当作类的加载路径 但是程序运行过后 真实走的是out目录那条线**

---



# 4 class.getResource() 和 classLoader.getResource() 是不同的

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



# 4.1 [Java中getResourceAsStream的用法](https://www.cnblogs.com/macwhirr/p/8116583.html)

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

![image-20230930232647577](D:\TyporaPhoto\image-20230930232647577.png)

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

  ![image-20230930232713311](D:\TyporaPhoto\image-20230930232713311.png)

~~~
InputStream in = PropertiesUtil.class.getResourceAsStream("xx.properties");

~~~

（2）要加载的资源路径在resources下

![image-20230930232726764](D:\TyporaPhoto\image-20230930232726764.png)

~~~
InputStream in = PropertiesUtil.class.getResourceAsStream("/xx.properties");
~~~

---





---

# 5 回顾泛型指定的时机

![image-20230905202217597](D:\TyporaPhoto\image-20230905202217597.png)

![image-20230905202132032](D:\TyporaPhoto\image-20230905202132032.png)





---

# 6 Spring AOP debug 调试 导错包，容器中找不到实现子类 报错

**注意：当把一个实现子类复制到另一个包下 时 ，这个实现子类引的接口，还是原来包下的接口！！容易出现该报错！！** 

![image-20230908182142611](D:\TyporaPhoto\image-20230908182142611.png)

![image-20230908182621066](D:\TyporaPhoto\image-20230908182621066.png)

```java
package com.hspedu.spring.aop.aspectj;

// 下面这里的包引错了 导致报错
// expected single matching bean but found 2: com.hspedu.spring.test.Man#0,com.hspedu.spring.test.Man#1
// 解决 方法 不写导包import 默认找同包下的SmartAnimalable类
import com.hspedu.spring.aop.proxy3.SmartAnimalable;


import org.springframework.stereotype.Component;

/**
 * @author 韩顺平
 * @version 1.0
 */
@Component //使用@Component 当spring容器启动时，将 SmartDog注入到容器
public class SmartDog implements SmartAnimalable {
    @Override
    public float getSum(float i, float j) {
        //System.out.println("日志-方法名-getSum-参数 " + i + " " + j);
        float result = i + j;
        System.out.println("方法内部打印result = " + result);
        //System.out.println("日志-方法名-getSum-结果result= " + result);
        return result;
    }

    @Override
    public float getSub(float i, float j) {
        //System.out.println("日志-方法名-getSub-参数 " + i + " " + j);
        float result = i - j;
        System.out.println("方法内部打印result = " + result);
        //System.out.println("日志-方法名-getSub-结果result= " + result);
        return result;
    }
}
```





![image-20230908182048508](D:\TyporaPhoto\image-20230908182048508.png)

---

# 7 老师补充: 动态代理 jdk的 Proxy与Spring的CGlib

## 1. 为什么要使用动态代理？

动态代理：在不改变原有代码的情况下上进行对象功能增强 使用代理对象代替原来的对象完成功能 进而达到拓展功能的目的

## 2.JDK Proxy 动态代理面向接口的动态代理

特点：

1. 一定要有接口和实现类的存在 代理对象增强的是实现类 在实现接口的方法重写的方法
2. 生成的代理对象只能转换成 接口的不能转换成 被代理类
3. 代理对象只能增强接口中定义的方法 实现类中其他和接口无关的方法是无法增强的
4. 代理对象只能读取到接口中方法上的注解 不能读取到实现类方法上的注解
   使用方法：



```
public class Test1 {
    public static void main(String[] args) {
        Dinner dinner=new Person("张三");
        // 通过Porxy动态代理获得一个代理对象,在代理对象中,对某个方法进行增强
//        ClassLoader loader,被代理的对象的类加载器
        ClassLoader classLoader = dinner.getClass().getClassLoader();
//        Class<?>[] interfaces,被代理对象所实现的所有接口
        Class[] interaces= dinner.getClass().getInterfaces();
//        InvocationHandler h,执行处理器对象,专门用于定义增强的规则
        InvocationHandler handler = new InvocationHandler(){
            // invoke 当我们让代理对象调用任何方法时,都会触发invoke方法的执行
            public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
//                Object proxy, 代理对象
//                Method method,被代理的方法
//                Object[] args,被代理方法运行时的实参
                Object res=null;
               if(method.getName().equals("eat")){
                   System.out.println("饭前洗手");
                   // 让原有的eat的方法去运行
                   res =method.invoke(dinner, args);
                   System.out.println("饭后刷碗");
               }else{
                   // 如果是其他方法,那么正常执行就可以了
                   res =method.invoke(dinner, args);
               }
                return res;
            }
        };
        Dinner dinnerProxy =(Dinner) Proxy.newProxyInstance(classLoader,interaces,handler);
        //dinnerProxy.eat("包子");
        dinnerProxy.drink();
    }
}
interface Dinner{
    void eat(String foodName);
    void drink();
}
class Person implements Dinner{
    private String name;
    public Person(String name) {
        this.name = name;
    }
    @Override
    public void eat(String foodName) {
        System.out.println(name+"正在吃"+foodName);
    }
    @Override
    public void drink( ) {
        System.out.println(name+"正在喝茶");
    }
}
class Student implements Dinner{
    private String name;
    public Student(String name) {
        this.name = name;
    }
    @Override
    public void eat(String foodName) {
        System.out.println(name+"正在食堂吃"+foodName);
    }
    @Override
    public void drink( ) {
        System.out.println(name+"正在喝可乐");
    }
}
```

## 3.CGlib动态代理

cglib动态代理模式是面向父类

特点：

1. 面向父类的和接口没有直接关系
   2.不仅可以增强接口中定义的方法还可以增强其他方法
   3.可以读取父类中方法上的所有注解
2. 使用实例



```
public class Test1 {
    @Test
    public void testCglib(){
        Person person =new Person();
        // 获取一个Person的代理对象
        // 1 获得一个Enhancer对象
        Enhancer enhancer=new Enhancer();
        // 2 设置父类字节码
        enhancer.setSuperclass(person.getClass());
        // 3 获取MethodIntercepter对象 用于定义增强规则
        MethodInterceptor methodInterceptor=new MethodInterceptor() {
            @Override
            public Object intercept(Object o, Method method, Object[] objects, MethodProxy methodProxy) throws Throwable {
                /*Object o,  生成之后的代理对象 personProxy
                Method method,  父类中原本要执行的方法  Person>>> eat()
                Object[] objects, 方法在调用时传入的实参数组
                MethodProxy methodProxy  子类中重写父类的方法 personProxy >>> eat()
                */
                Object res =null;
                if(method.getName().equals("eat")){
                    // 如果是eat方法 则增强并运行
                    System.out.println("饭前洗手");
                    res=methodProxy.invokeSuper(o,objects);
                    System.out.println("饭后刷碗");
                }else{
                    // 如果是其他方法 不增强运行
                    res=methodProxy.invokeSuper(o,objects); // 子类对象方法在执行,默认会调用父类对应被重写的方法
                }
                return res;
            }
        };
        // 4 设置methodInterceptor
        enhancer.setCallback(methodInterceptor);
        // 5 获得代理对象
        Person personProxy = (Person)enhancer.create();
        // 6 使用代理对象完成功能
        personProxy.eat("包子");
    }
}
class Person  {
    public Person( ) {
    }
    public void eat(String foodName) {
        System.out.println("张三正在吃"+foodName);
    }
}
```

## 4.两个动态代理的区别

1. JDK动态代理是面向接口的，只能增强实现类中接口中存在的方法。CGlib是面向父类的，可以增强父类的所有方法
2. JDK得到的对象是JDK代理对象实例，而CGlib得到的对象是被代理对象的子类

---

# 8 Spring 版本报错java: Compilation failed: internal java compiler error java:编译失败：内部java编译器错误  

临时解决方案：不想改pom文件

pom.xml 中引入新的jar包 就会在下面两个位置自动切换成language 5 和

Target bytecode version 1.5  需要改成 8 和 1.8

![image-20230911172146354](D:\TyporaPhoto\image-20230911172146354.png)

![image-20230911172353792](D:\TyporaPhoto\image-20230911172353792.png)

![image-20230911172255055](D:\TyporaPhoto\image-20230911172255055.png)

---

# 9 要获取注解的类对象不可以加@！！！



```
// 注意要获取注解的类对象不可以加@！！！
//if(declaredField.isAnnotationPresent(@Autowired.class)){
// 下面这个是正确的！
if(declaredField.isAnnotationPresent(Autowired.class)){
```

---

# 10 关于方法返回值 手动抛出一个异常可以替代return 即可以不用再return

```java
// 编写方法 返回容器中的对象
public Object getBean(String name) {


    // 抛出一个异常 说明传进来的name 不存在 是瞎传了一个name
    // 抛出异常可以代替返回值 就不用在返回了 return
    throw new NullPointerException("没有该bean");
    //
    //return null;
}
```

---

# 11 判断clazz对象 的类 有没有实现某个接口 ,使用	某个接口.class.isAssignableFrom(clazz)

![image-20230915144229566](D:\TyporaPhoto\image-20230915144229566.png)







---

# 12 判断实例对象 的类 有没有实现某个接口 ,使用 instanceof



---

# 13aspectClass.getDeclaredMethod() 方法 在获取无参数的方法时注意细节



![image-20230917164136421](D:\TyporaPhoto\image-20230917164136421.png)

![image-20230917164202570](D:\TyporaPhoto\image-20230917164202570.png)

```Java
// 通过方法名获取该方法
// 下面这个可以找到 注意小细节 第二个参数在该方法无参的情况下
// 不可以带类型【(Class<?>) null】 不可以强转后传入 而是应该直接传一个null !!!!
//Method declaredMethod1 = aspectClass.getDeclaredMethod(name, (Class<?>) null);
Method declaredMethod1 = aspectClass.getDeclaredMethod(name,  null);
//Method declaredMethod1 = aspectClass.getDeclaredMethod("showBeginLog",  null);
//进行反射调用
//declaredMethod1.invoke(aspectClass.newInstance(),null);
declaredMethod1.invoke(null,null);
```





---

# 14 resource.getPath() 和 resource.getFile() 类似都返回一个String类型

使用的位置如下：

D:\Java_developer_tools\ssm\my_spring\spring\src\com\hspedu\spring\annotation2\YdSpringApplicationContext.java

```java
 // 通过类的加载器 得到要扫描的包的全路径
        ClassLoader classLoader = YdSpringApplicationContext.class.getClassLoader();
        //URL resource = classLoader.getResource("com/hspedu/spring/component");
        URL resource = classLoader.getResource(path);
        //System.out.println("resource= " + resource);
        //resource= file:/D:/Java_developer_tools/ssm/my_spring/spring/out/production/spring/com/hspedu/spring/component

        // 得到要扫描的包的文件 因为此时的url 不是 String 类型
        // 因此需要通过getPath()方法 转换为String类型

        //File file = new File(resource.getPath());
        File file = new File(resource.getFile());
```



---

# 15 spring 声明式事务嵌套时出现死锁 一直转圈的情况







~~~java
C:\jdk\jdk1.8\bin\java.exe -ea -Didea.test.cyclic.buffer.size=1048576 "-javaagent:D:\Java_developer_tools\developer_tools_IDEA\IntelliJ IDEA 2020.2.1\lib\idea_rt.jar=62800:D:\Java_developer_tools\developer_tools_IDEA\IntelliJ IDEA 2020.2.1\bin" -Dfile.encoding=UTF-8 -classpath "D:\Java_developer_tools\developer_tools_IDEA\IntelliJ IDEA 2020.2.1\lib\idea_rt.jar;C:\Users\yangd\.m2\repository\org\junit\platform\junit-platform-launcher\1.4.2\junit-platform-launcher-1.4.2.jar;D:\Java_developer_tools\developer_tools_IDEA\IntelliJ IDEA 2020.2.1\plugins\junit\lib\junit5-rt.jar;D:\Java_developer_tools\developer_tools_IDEA\IntelliJ IDEA 2020.2.1\plugins\junit\lib\junit-rt.jar;C:\jdk\jdk1.8\jre\lib\charsets.jar;C:\jdk\jdk1.8\jre\lib\deploy.jar;C:\jdk\jdk1.8\jre\lib\ext\access-bridge-64.jar;C:\jdk\jdk1.8\jre\lib\ext\cldrdata.jar;C:\jdk\jdk1.8\jre\lib\ext\dnsns.jar;C:\jdk\jdk1.8\jre\lib\ext\jaccess.jar;C:\jdk\jdk1.8\jre\lib\ext\jfxrt.jar;C:\jdk\jdk1.8\jre\lib\ext\localedata.jar;C:\jdk\jdk1.8\jre\lib\ext\nashorn.jar;C:\jdk\jdk1.8\jre\lib\ext\sunec.jar;C:\jdk\jdk1.8\jre\lib\ext\sunjce_provider.jar;C:\jdk\jdk1.8\jre\lib\ext\sunmscapi.jar;C:\jdk\jdk1.8\jre\lib\ext\sunpkcs11.jar;C:\jdk\jdk1.8\jre\lib\ext\zipfs.jar;C:\jdk\jdk1.8\jre\lib\javaws.jar;C:\jdk\jdk1.8\jre\lib\jce.jar;C:\jdk\jdk1.8\jre\lib\jfr.jar;C:\jdk\jdk1.8\jre\lib\jfxswt.jar;C:\jdk\jdk1.8\jre\lib\jsse.jar;C:\jdk\jdk1.8\jre\lib\management-agent.jar;C:\jdk\jdk1.8\jre\lib\plugin.jar;C:\jdk\jdk1.8\jre\lib\resources.jar;C:\jdk\jdk1.8\jre\lib\rt.jar;D:\Java_developer_tools\ssm\my_spring\spring\out\production\spring;D:\Java_developer_tools\ssm\my_spring\spring\lib\commons-logging-1.1.3.jar;D:\Java_developer_tools\ssm\my_spring\spring\lib\spring-beans-5.3.8.jar;D:\Java_developer_tools\ssm\my_spring\spring\lib\spring-context-5.3.8.jar;D:\Java_developer_tools\ssm\my_spring\spring\lib\spring-core-5.3.8.jar;D:\Java_developer_tools\ssm\my_spring\spring\lib\spring-expression-5.3.8.jar;C:\Users\yangd\.m2\repository\org\junit\jupiter\junit-jupiter\5.4.2\junit-jupiter-5.4.2.jar;C:\Users\yangd\.m2\repository\org\junit\jupiter\junit-jupiter-api\5.4.2\junit-jupiter-api-5.4.2.jar;C:\Users\yangd\.m2\repository\org\apiguardian\apiguardian-api\1.0.0\apiguardian-api-1.0.0.jar;C:\Users\yangd\.m2\repository\org\opentest4j\opentest4j\1.1.1\opentest4j-1.1.1.jar;C:\Users\yangd\.m2\repository\org\junit\platform\junit-platform-commons\1.4.2\junit-platform-commons-1.4.2.jar;C:\Users\yangd\.m2\repository\org\junit\jupiter\junit-jupiter-params\5.4.2\junit-jupiter-params-5.4.2.jar;C:\Users\yangd\.m2\repository\org\junit\jupiter\junit-jupiter-engine\5.4.2\junit-jupiter-engine-5.4.2.jar;C:\Users\yangd\.m2\repository\org\junit\platform\junit-platform-engine\1.4.2\junit-platform-engine-1.4.2.jar;D:\Java_developer_tools\ssm\my_spring\spring\lib\dom4j-1.6.1.jar;D:\Java_developer_tools\ssm\my_spring\spring\lib\spring-aop-5.3.8.jar;D:\Java_developer_tools\ssm\my_spring\spring\lib\com.springsource.org.aopalliance-1.0.0.jar;D:\Java_developer_tools\ssm\my_spring\spring\lib\com.springsource.net.sf.cglib-2.2.0.jar;D:\Java_developer_tools\ssm\my_spring\spring\lib\com.springsource.org.aspectj.weaver-1.6.8.RELEASE.jar;D:\Java_developer_tools\ssm\my_spring\spring\lib\spring-aspects-5.3.8.jar;D:\Java_developer_tools\ssm\my_spring\spring\lib\c3p0-0.9.1.2.jar;D:\Java_developer_tools\ssm\my_spring\spring\lib\mysql-connector-java-5.1.7-bin.jar;D:\Java_developer_tools\ssm\my_spring\spring\lib\spring-jdbc-5.3.8.jar;D:\Java_developer_tools\ssm\my_spring\spring\lib\spring-orm-5.3.8.jar;D:\Java_developer_tools\ssm\my_spring\spring\lib\spring-tx-5.3.8.jar" com.intellij.rt.junit.JUnitStarter -ideVersion5 -junit5 com.hspedu.spring.tx.homework.HomeworkTest,queryPriceByIdTest

九月 21, 2023 10:15:33 上午 com.mchange.v2.log.MLog <clinit>
信息: MLog clients using java 1.4+ standard logging.
九月 21, 2023 10:15:34 上午 com.mchange.v2.c3p0.C3P0Registry banner
信息: Initializing c3p0-0.9.1.2 [built 21-May-2007 15:04:56; debug? true; trace: 10]
九月 21, 2023 10:15:34 上午 com.mchange.v2.c3p0.impl.AbstractPoolBackedDataSource getPoolManager
信息: Initializing c3p0 pool... com.mchange.v2.c3p0.ComboPooledDataSource [ acquireIncrement -> 3, acquireRetryAttempts -> 30, acquireRetryDelay -> 1000, autoCommitOnClose -> false, automaticTestTable -> null, breakAfterAcquireFailure -> false, checkoutTimeout -> 0, connectionCustomizerClassName -> null, connectionTesterClassName -> com.mchange.v2.c3p0.impl.DefaultConnectionTester, dataSourceName -> 1hgf2oaay1ed5w8zu66ezx|2fb3536e, debugUnreturnedConnectionStackTraces -> false, description -> null, driverClass -> com.mysql.jdbc.Driver, factoryClassLocation -> null, forceIgnoreUnresolvedTransactions -> false, identityToken -> 1hgf2oaay1ed5w8zu66ezx|2fb3536e, idleConnectionTestPeriod -> 0, initialPoolSize -> 3, jdbcUrl -> jdbc:mysql://localhost:3306/spring, maxAdministrativeTaskTime -> 0, maxConnectionAge -> 0, maxIdleTime -> 0, maxIdleTimeExcessConnections -> 0, maxPoolSize -> 15, maxStatements -> 0, maxStatementsPerConnection -> 0, minPoolSize -> 3, numHelperThreads -> 3, numThreadsAwaitingCheckoutDefaultUser -> 0, preferredTestQuery -> null, properties -> {user=******, password=******}, propertyCycle -> 0, testConnectionOnCheckin -> false, testConnectionOnCheckout -> false, unreturnedConnectionTimeout -> 0, usesTraditionalReflectiveProxies -> false ]
用户购买信息 userId= 1 goodsId= 1 amount= 1
第一个方法正常执行完
用户购买信息 userId= 1 goodsId= 1 amount= 1


org.springframework.dao.CannotAcquireLockException: PreparedStatementCallback; SQL [UPDATE user_account SET money=money-? Where user_id=?]; Lock wait timeout exceeded; try restarting transaction; nested exception is java.sql.SQLException: Lock wait timeout exceeded; try restarting transaction

	at org.springframework.jdbc.support.SQLErrorCodeSQLExceptionTranslator.doTranslate(SQLErrorCodeSQLExceptionTranslator.java:267)
	at org.springframework.jdbc.support.AbstractFallbackSQLExceptionTranslator.translate(AbstractFallbackSQLExceptionTranslator.java:70)
	at org.springframework.jdbc.core.JdbcTemplate.translateException(JdbcTemplate.java:1541)
	at org.springframework.jdbc.core.JdbcTemplate.execute(JdbcTemplate.java:667)
	at org.springframework.jdbc.core.JdbcTemplate.update(JdbcTemplate.java:960)
	at org.springframework.jdbc.core.JdbcTemplate.update(JdbcTemplate.java:1015)
	at org.springframework.jdbc.core.JdbcTemplate.update(JdbcTemplate.java:1025)
	at com.hspedu.spring.tx.homework.dao.GoodsDao.updateBalance2(GoodsDao.java:73)
	at com.hspedu.spring.tx.homework.service.GoodsService.buyGoodsBuyTx2(GoodsService.java:102)
	at com.hspedu.spring.tx.homework.service.GoodsService$$FastClassBySpringCGLIB$$6d10e5bd.invoke(<generated>)
	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)
	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:779)
	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:163)
	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:750)
	at org.springframework.transaction.interceptor.TransactionInterceptor$1.proceedWithInvocation(TransactionInterceptor.java:123)
	at org.springframework.transaction.interceptor.TransactionAspectSupport.invokeWithinTransaction(TransactionAspectSupport.java:388)
	at org.springframework.transaction.interceptor.TransactionInterceptor.invoke(TransactionInterceptor.java:119)
	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)
	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:750)
	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:692)
	at com.hspedu.spring.tx.homework.service.GoodsService$$EnhancerBySpringCGLIB$$a3efd790.buyGoodsBuyTx2(<generated>)
	at com.hspedu.spring.tx.homework.service.MultiplyService.multiBuyGoodsByTx(MultiplyService.java:52)
	at com.hspedu.spring.tx.homework.service.MultiplyService$$FastClassBySpringCGLIB$$b640abf3.invoke(<generated>)
	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)
	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:779)
	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:163)
	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:750)
	at org.springframework.transaction.interceptor.TransactionInterceptor$1.proceedWithInvocation(TransactionInterceptor.java:123)
	at org.springframework.transaction.interceptor.TransactionAspectSupport.invokeWithinTransaction(TransactionAspectSupport.java:388)
	at org.springframework.transaction.interceptor.TransactionInterceptor.invoke(TransactionInterceptor.java:119)
	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)
	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:750)
	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:692)
	at com.hspedu.spring.tx.homework.service.MultiplyService$$EnhancerBySpringCGLIB$$a359bbf2.multiBuyGoodsByTx(<generated>)
	at com.hspedu.spring.tx.homework.HomeworkTest.queryPriceByIdTest(HomeworkTest.java:45)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:498)
	at org.junit.platform.commons.util.ReflectionUtils.invokeMethod(ReflectionUtils.java:628)
	at org.junit.jupiter.engine.execution.ExecutableInvoker.invoke(ExecutableInvoker.java:117)
	at org.junit.jupiter.engine.descriptor.TestMethodTestDescriptor.lambda$invokeTestMethod$7(TestMethodTestDescriptor.java:184)
	at org.junit.platform.engine.support.hierarchical.ThrowableCollector.execute(ThrowableCollector.java:73)
	at org.junit.jupiter.engine.descriptor.TestMethodTestDescriptor.invokeTestMethod(TestMethodTestDescriptor.java:180)
	at org.junit.jupiter.engine.descriptor.TestMethodTestDescriptor.execute(TestMethodTestDescriptor.java:127)
	at org.junit.jupiter.engine.descriptor.TestMethodTestDescriptor.execute(TestMethodTestDescriptor.java:68)
	at org.junit.platform.engine.support.hierarchical.NodeTestTask.lambda$executeRecursively$5(NodeTestTask.java:135)
	at org.junit.platform.engine.support.hierarchical.ThrowableCollector.execute(ThrowableCollector.java:73)
	at org.junit.platform.engine.support.hierarchical.NodeTestTask.lambda$executeRecursively$7(NodeTestTask.java:125)
	at org.junit.platform.engine.support.hierarchical.Node.around(Node.java:135)
	at org.junit.platform.engine.support.hierarchical.NodeTestTask.lambda$executeRecursively$8(NodeTestTask.java:123)
	at org.junit.platform.engine.support.hierarchical.ThrowableCollector.execute(ThrowableCollector.java:73)
	at org.junit.platform.engine.support.hierarchical.NodeTestTask.executeRecursively(NodeTestTask.java:122)
	at org.junit.platform.engine.support.hierarchical.NodeTestTask.execute(NodeTestTask.java:80)
	at java.util.ArrayList.forEach(ArrayList.java:1257)
	at org.junit.platform.engine.support.hierarchical.SameThreadHierarchicalTestExecutorService.invokeAll(SameThreadHierarchicalTestExecutorService.java:38)
	at org.junit.platform.engine.support.hierarchical.NodeTestTask.lambda$executeRecursively$5(NodeTestTask.java:139)
	at org.junit.platform.engine.support.hierarchical.ThrowableCollector.execute(ThrowableCollector.java:73)
	at org.junit.platform.engine.support.hierarchical.NodeTestTask.lambda$executeRecursively$7(NodeTestTask.java:125)
	at org.junit.platform.engine.support.hierarchical.Node.around(Node.java:135)
	at org.junit.platform.engine.support.hierarchical.NodeTestTask.lambda$executeRecursively$8(NodeTestTask.java:123)
	at org.junit.platform.engine.support.hierarchical.ThrowableCollector.execute(ThrowableCollector.java:73)
	at org.junit.platform.engine.support.hierarchical.NodeTestTask.executeRecursively(NodeTestTask.java:122)
	at org.junit.platform.engine.support.hierarchical.NodeTestTask.execute(NodeTestTask.java:80)
	at java.util.ArrayList.forEach(ArrayList.java:1257)
	at org.junit.platform.engine.support.hierarchical.SameThreadHierarchicalTestExecutorService.invokeAll(SameThreadHierarchicalTestExecutorService.java:38)
	at org.junit.platform.engine.support.hierarchical.NodeTestTask.lambda$executeRecursively$5(NodeTestTask.java:139)
	at org.junit.platform.engine.support.hierarchical.ThrowableCollector.execute(ThrowableCollector.java:73)
	at org.junit.platform.engine.support.hierarchical.NodeTestTask.lambda$executeRecursively$7(NodeTestTask.java:125)
	at org.junit.platform.engine.support.hierarchical.Node.around(Node.java:135)
	at org.junit.platform.engine.support.hierarchical.NodeTestTask.lambda$executeRecursively$8(NodeTestTask.java:123)
	at org.junit.platform.engine.support.hierarchical.ThrowableCollector.execute(ThrowableCollector.java:73)
	at org.junit.platform.engine.support.hierarchical.NodeTestTask.executeRecursively(NodeTestTask.java:122)
	at org.junit.platform.engine.support.hierarchical.NodeTestTask.execute(NodeTestTask.java:80)
	at org.junit.platform.engine.support.hierarchical.SameThreadHierarchicalTestExecutorService.submit(SameThreadHierarchicalTestExecutorService.java:32)
	at org.junit.platform.engine.support.hierarchical.HierarchicalTestExecutor.execute(HierarchicalTestExecutor.java:57)
	at org.junit.platform.engine.support.hierarchical.HierarchicalTestEngine.execute(HierarchicalTestEngine.java:51)
	at org.junit.platform.launcher.core.DefaultLauncher.execute(DefaultLauncher.java:229)
	at org.junit.platform.launcher.core.DefaultLauncher.lambda$execute$6(DefaultLauncher.java:197)
	at org.junit.platform.launcher.core.DefaultLauncher.withInterceptedStreams(DefaultLauncher.java:211)
	at org.junit.platform.launcher.core.DefaultLauncher.execute(DefaultLauncher.java:191)
	at org.junit.platform.launcher.core.DefaultLauncher.execute(DefaultLauncher.java:128)
	at com.intellij.junit5.JUnit5IdeaTestRunner.startRunnerWithArgs(JUnit5IdeaTestRunner.java:71)
	at com.intellij.rt.junit.IdeaTestRunner$Repeater.startRunnerWithArgs(IdeaTestRunner.java:33)
	at com.intellij.rt.junit.JUnitStarter.prepareStreamsAndStart(JUnitStarter.java:220)
	at com.intellij.rt.junit.JUnitStarter.main(JUnitStarter.java:53)
Caused by: java.sql.SQLException: Lock wait timeout exceeded; try restarting transaction
	at com.mysql.jdbc.SQLError.createSQLException(SQLError.java:1055)
	at com.mysql.jdbc.SQLError.createSQLException(SQLError.java:956)
	at com.mysql.jdbc.MysqlIO.checkErrorPacket(MysqlIO.java:3515)
	at com.mysql.jdbc.MysqlIO.checkErrorPacket(MysqlIO.java:3447)
	at com.mysql.jdbc.MysqlIO.sendCommand(MysqlIO.java:1951)
	at com.mysql.jdbc.MysqlIO.sqlQueryDirect(MysqlIO.java:2101)
	at com.mysql.jdbc.ConnectionImpl.execSQL(ConnectionImpl.java:2554)
	at com.mysql.jdbc.PreparedStatement.executeInternal(PreparedStatement.java:1761)
	at com.mysql.jdbc.PreparedStatement.executeUpdate(PreparedStatement.java:2046)
	at com.mysql.jdbc.PreparedStatement.executeUpdate(PreparedStatement.java:1964)
	at com.mysql.jdbc.PreparedStatement.executeUpdate(PreparedStatement.java:1949)
	at com.mchange.v2.c3p0.impl.NewProxyPreparedStatement.executeUpdate(NewProxyPreparedStatement.java:105)
	at org.springframework.jdbc.core.JdbcTemplate.lambda$update$2(JdbcTemplate.java:965)
	at org.springframework.jdbc.core.JdbcTemplate.execute(JdbcTemplate.java:651)
	... 82 more



Process finished with exit code -1

~~~

