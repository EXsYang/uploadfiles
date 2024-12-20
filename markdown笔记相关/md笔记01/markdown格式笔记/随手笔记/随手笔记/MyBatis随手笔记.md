# 1 SqlSessionFactory类找不到

重新刷一下右侧的Maven刷新按钮 需要保证左侧的External Libraries出现

Maven:org.mybatis:mybatis:3.5.7 

![image-20231017192029280](D:\TyporaPhoto\image-20231017192029280.png)



---

# 2 MyBatis Mapper.xml中识别不到insert语句

![image-20231018141036475](D:\TyporaPhoto\image-20231018141036475.png)

解决方法：

```
文件头中使用 "http://mybatis.org/dtd/mybatis-3-mapper.dtd"
```

![image-20231018144904865](D:\TyporaPhoto\image-20231018144904865.png)

```
mybatis-config.xml文件
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE configuration
        PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-config.dtd">
<!--注意点：mybatis官方文档https://mybatis.org/mybatis-3/zh/getting-started.html中 使用的是
https://mybatis.org/dtd/mybatis-3-config.dtd和https://mybatis.org/dtd/mybatis-3-mapper.dtd
但是在自己写的项目中 不好使

需要按照老韩使用的http协议的才好使
http://mybatis.org/dtd/mybatis-3-config.dtd和http://mybatis.org/dtd/mybatis-3-mapper.dtd
其中mybatis-config.xml 中使用https://mybatis.org/dtd/mybatis-3-config.dtd 也可以
但是Mapper.xml中使用https://mybatis.org/dtd/mybatis-3-mapper.dtd 不好使！！
mapper标签中检测不到insert语法
```

![image-20231018151349494](D:\TyporaPhoto\image-20231018151349494.png)

![image-20231018151447951](D:\TyporaPhoto\image-20231018151447951.png)

---

# 3 saxReader 获取元素属性值的方式有两种

```java
try {
    // 得到hspspringmvc1.xml文件的文档对象
    Document document = saxReader.read(resourceAsStream);
    // 获取根元素
    Element rootElement = document.getRootElement();
    // 通过根节点获取 子元素
    Element element = rootElement.element("component-scan");
    // 获取元素的base-package属性
    Attribute attribute = element.attribute("base-package");
    //String attributeValue = element.attributeValue("base-package");
    // 获取属性的值 方式一：
    String pack = attribute.getText();
    System.out.println("通过 attribute.getText() 获取到的属性的值pack= " + pack);
    //通过 attribute.getText() 获取到的属性的值pack= com.hspedu1.controller,com.hspedu1.service
    // 获取属性的值 方式二：
    // 下面这种方式也可以获取到属性的值 是一样的
    //String pack2 = element.attributeValue("base-package");
    //System.out.println("通过 element.attributeValue(\"base-package\");" +
    //        " 获取到的属性的值pack2= " + pack2);
    //通过 element.attributeValue("base-package"); 获取到的属性的值pack2= com.hspedu1.controller,com.hspedu1.service

    return pack;

} catch (Exception e) {
    e.printStackTrace();
}
```





---



# 4 创建的maven项目 默认的编译器版本是1.5 在pom.xml文件中加入一段代码 统一编译器的版本为1.8



**Java1.5 的编译器**  switch case 语句中 **switch() 中 不能使用 String类型** 

需要改成1.8的

 switch结构中的表达式，只能是如下的6种数据类型之一：
   byte 、short、char、int、枚举类型(JDK5.0新增)、**String类型(JDK7.0新增)**

 

**Incompatible types. Found: 'java.lang.String', required: 'byte, char, short or int'**

![image-20231019164815193](D:\TyporaPhoto\image-20231019164815193.png)





```
<!--创建的maven项目 默认的编译器版本是1.5 这里统一编译器的版本为1.8-->
<properties>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    <maven.compiler.source>1.8</maven.compiler.source>
    <maven.compiler.target>1.8</maven.compiler.target>
    <java.version>1.8</java.version>
</properties>
```



![image-20231019164619838](D:\TyporaPhoto\image-20231019164619838.png)

![image-20231019164300767](D:\TyporaPhoto\image-20231019164300767.png)



**解决方法：**

![image-20231019164729596](D:\TyporaPhoto\image-20231019164729596.png)



![image-20231019165301097](D:\TyporaPhoto\image-20231019165301097.png)



---



# 5 **IDEA Lombok无法获取get、set方法**

 今天尝试在IDEA中使用Lombok,但是在编译时，提示找不到set()和get()方法，我明明在javabean中使用了@Data注解，但是编译器就是找不到。于是从网上查询了很多的方法去解决，最后终于解决了。接下来我就将过程分享一下，希望能够帮助需要的人：

Idea下安装lombok(需要二步) 

 **第一步： pom.xml中加入lombok依赖包**

```php-template
<!-- https://mvnrepository.com/artifact/org.projectlombok/lombok -->
  <dependency>
   <groupId>org.projectlombok</groupId>
   <artifactId>lombok</artifactId>
   <version>1.16.20</version>
   <scope>provided</scope>
  </dependency>
```

**第二步：加入lombok插件**

步骤：File ——》Settings——》Plugins.   搜索lombok，点击安装install。然后会提示重启，重启。

![如何解决IDEA下lombok安装及找不到get,set的问题](D:\TyporaPhoto\87496.png)

**解决编译时无法找到set和get 的问题：**

可能一：IDEA的编译方式选项错误，应该是javac，而不是eclipse。因为eclipse是不支持lombok的编译方式的，javac支持lombok的编译方式。

![如何解决IDEA下lombok安装及找不到get,set的问题](D:\TyporaPhoto\87497.png)

可能二：没有打开注解生成器Enable annotation processing。

![如何解决IDEA下lombok安装及找不到get,set的问题](D:\TyporaPhoto\87498.png)

可能三（我遇到的就是这个问题）：pom.xml中加入的lombok依赖包版本和自动安装的plugin中的lombok依赖包版本不一致。

因为我们添加的lombok插件plugin，点击insall时是自动安装的最新版本的lombok。但是我在pom.xml中的依赖包是maven中的低版本的一个依赖包，版本不一致，造成了无法找到set和get.

 

---

# 6 MySQL 字符串类型用数字可以查出来 MySQL字符串类型会转换成数字 MySQL隐式类型转换



![image-20231019210433532](D:\TyporaPhoto\image-20231019210433532.png)



1、原因： 当MySQL字段类型和传入条件数据类型不一致时，会进行隐形的数据类型转换（MySQL Implicit conversion）

2、若字符串是以数字开头，且全部都是数字，则转换为数字结果是整个字符串；部分是数字，则转换为数字结果是截止到第一个不是数字的字符为止。 理解： varchar str = "123dafa"，转换为数字是123 。 SELECT '123dafa'+1 ; --- 124 。

3、若字符串不是以数字开头，则转换为数字结果是 0 。 varchar str = "aabb33" ; 转换为数字是 0 。 SELECT 'aabb33'+100 ; --- 100 。

 

4、更多隐式转换规则摘录：

两个参数至少有一个是 NULL 时，比较的结果也是 NULL，例外是使用 <=> 对两个 NULL 做比较时会返回 1，这两种情况都不需要做类型转换
两个参数都是字符串，会按照字符串来比较，不做类型转换
两个参数都是整数，按照整数来比较，不做类型转换
十六进制的值和非数字做比较时，会被当做二进制串
有一个参数是 TIMESTAMP 或 DATETIME，并且另外一个参数是常量，常量会被转换为 timestamp
有一个参数是 decimal 类型，如果另外一个参数是 decimal 或者整数，会将整数转换为 decimal 后进行比较，如果另外一个参数是浮点数，则会把 decimal 转换为浮点数进行比较

~~~

3.1、SELECT 'a10'+10 ; -- 10
SHOW WARNINGS ; -- WARNINGS: Truncated incorrect DOUBLE value: 'a10'
查看warnings可以看到隐式转化把字符串转为了double类型。但是因为字符串是非数字型的，所以就会被转换为0，因此最终计算的是0+10=10 .
 
3.2、SELECT '10a'+10 ; -- 20 
SHOW WARNINGS ; -- WARNINGS: Truncated incorrect DOUBLE value: '10a'
 
3.3、SELECT 'a'=0 ; -- 1 , 相当于 true 
SHOW WARNINGS ; -- WARNINGS: Truncated incorrect DOUBLE value: 'a'
 
3.4、SELECT 'a23423' = 0 ; -- 1 , 相当于 true 
SHOW WARNINGS ; -- WARNINGS：Truncated incorrect DOUBLE value: 'a23423'
 
3.5、SELECT '11dafdfwwe'=11; -- 1, 相当于 true 
SHOW WARNINGS ; -- WARNINGS：Truncated incorrect DOUBLE value: '11dafdfwwe'
 
3.6、SELECT 11= 11 ; -- 1, 相当于 true 
SHOW WARNINGS ; -- 无 
 
3.7、SELECT 'abc'='abc' ; -- 1, 相当于 true 
SHOW WARNINGS ; -- 无 
 
3.8、SELECT 'abc'='abc232322' ; -- 0 , 数据类型一样，不会进行转换 
SHOW WARNINGS ; -- 无 
 
3.9、SELECT 'a'+'b'; -- 0 , 都转换为0了， 0+0=0 。
SHOW WARNINGS ; -- WARNINGS: Truncated incorrect DOUBLE value: 'a' , Truncated incorrect DOUBLE value: 'b'
 
3.10、SELECT 'a'+'b'='c' ; -- 1 ,等价于 0+0=0 --> 0=0=1。
   SHOW WARNINGS ; -- WARNINGS: Truncated incorrect DOUBLE value: 'a' , Truncated incorrect DOUBLE value: 'b' , Truncated incorrect DOUBLE value: 'c'
~~~



---

# 7 快速复制全类名 

```
<?xml version="1.0" encoding="UTF-8" ?>
<!--这里的全类名 可以使用【右键菜单】-【Copy】-【Copy Reference】-->
<mapper nameSpace="com.hspedu.mapper.MonsterMapper">
    <select id="getMonsterById" resultType="com.hspedu.entity.Monster">

    </select>

</mapper>
```

---

# 8 快速复制 Path From Source Root

```
<!--说明
1. 这里我们配置需要关联的Mapper.xml
2. 这里可以通过 [菜单]-[Copy]-[Path From Source Root]
点击生成下面需要的格式:全路径点换成斜杠加上文件后缀
-->
<mappers>
    <mapper resource="com/hspedu/mapper/MonsterMapper.xml"/>
</mappers>
```

---

# 9 泛型方法  public <T> T getMapper(Class<T> clazz){} ，泛型指定的时机







```java
//编写方法 返回代理对象 Class<T> 这里传入时 指定了T的类型！！！
public <T> T getMapper(Class<T> clazz){

    return (T)Proxy.newProxyInstance(clazz.getClassLoader(), new Class[]{clazz},
            new HspMapperProxy(hspConfiguration,this,clazz));
}
```



```java
@Test
public void openSession(){

    HspSqlSession hspSqlSession = HspSessionFactory.openSession();

    // 这里 alt+enter 自动补全的返回 MonsterMapper 类型 因为
    //public <T> T getMapper(Class<T> clazz){} 返回代理对象
    // Class<T> 这里传入时 指定了T的类型！！！
    //
    MonsterMapper mapper = hspSqlSession.getMapper(MonsterMapper.class);
    // 测试 确实是 在getMapper(Class<T> clazz) 传入时 指定了T的类型！！！
    // 返回类型也按照 T 类型进行返回的
    //Goods goods = hspSqlSession.getMapper(Goods.class);

    
    // 这里自动补全的就是Monster类型 是因为在接口中声明的返回类型就是Monster
    Monster monster = mapper.getMonsterById(1);
    System.out.println("monster====== " + monster);


}
```



---

# 10 解决maven项目 默认编译器版本1.5问题 

1.5 不可以使用钻石<>符号 会报错

![image-20231029214929380](D:\TyporaPhoto\image-20231029214929380.png)

![image-20231029214720866](D:\TyporaPhoto\image-20231029214720866.png)



**解决方法：**

**1 . 在父项目 的pom.xml 文件中指定**

```xml
<!--Settings-Build,...-Compiler-Java Compiler- Target bytecode version 默认是1.5-->
<!--这里指定maven编译器 和 jdk的版本  /source/target/java的版本为1.8 -->
<properties>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    <maven.compiler.source>1.8</maven.compiler.source>
    <maven.compiler.target>1.8</maven.compiler.target>
    <java.version>1.8</java.version>
</properties>
```

**2 . 刷新Maven**

![image-20231029215116650](D:\TyporaPhoto\image-20231029215116650.png)

 ![image-20231029215139952](D:\TyporaPhoto\image-20231029215139952.png)



---

# 11 mybatis mapper.xml文件中注释说明

在mapper.xml 文件中的 <select> 等语句块中 可以使用的注释 如下：

<!---->

```java
<!--注意 最好不要在 下面的select 语句中写注释  杠杠 和 /**/ 的注释会导致报错 但是下面那种注释没事
会被当成sql的一部分 导致查询失败 报错-->
<select id="getPersonById" parameterType="Integer" resultMap="personResultMap">
    SELECT * FROM `person`,`idencard`
    WHERE `person`.`id` = #{id} AND `person`.`id` = `idencard`.`id`;
    <!-- SELECT `person`.`id`,`person`.`NAME`,`person`.`card_id`,`idencard`.`card_sn` FROM `person`,`idencard`-->
    <!-- WHERE `person`.`id` = #{id} AND `person`.`id` = `idencard`.`id`;-->
</select>
```

---

# 12 resultMap 细节

```xml
<resultMap id="resultWifeMap" type="Wife">
    <!--这里如果 没有指定 就按照默认的规则进行匹配
    即 javabean属性名和表的字段名要保持一致，否则匹配不上，封装的Javabean对象该属性值为null-->
    <!--<result property="id" column="id"/>-->
    <result property="name" column="wife_name"/>
</resultMap>
<select id="getWifeById" parameterType="Integer" resultMap="resultWifeMap">
    SELECT * FROM `wife` WHERE `id` = #{id};
</select>
```







“ofType” 属性。这个属性非常重要，它用来将 JavaBean（或字段）属性的类型和集合存储的类型区分开来。 所以你可以按照下面这样来阅读映射：

```xml
<collection property="posts" javaType="ArrayList" column="id" ofType="Post" select="selectPostsForBlog"/>
```



读作： “posts 是一个存储 Post 的 ArrayList 集合”

在一般情况下，MyBatis 可以推断 javaType 属性，因此并不需要填写。所以很多时候你可以简略成：

```xml
<collection property="posts" column="id" ofType="Post" select="selectPostsForBlog"/>
```





在UserMapper.xml 的 resultMap 中使用  collection 标签 如果没有指定 集合的javaType
// mybatis底层会 进行类型推断 默认封装为'class java.util.ArrayList'

```java
// 会出现栈溢出 StackOverflowError
// 原因:
// 在UserMapper.xml 的 resultMap 中使用  collection 标签 如果没有指定 集合的javaType
// mybatis底层会 进行类型推断 默认封装为'class java.util.ArrayList'
// ArrayList 直接输出 也会调用集合中元素的toString 方法
@Override
public String toString() {
    return "User{" +
            "id=" + id +
            ", name='" + name + '\'' +
            // 下面打印pets时 会调用pet.toString
            // 通过输出pets的运行类型 可以发现声明为List类型的属性
            // mybatis底层会 进行类型推断 封装为'class java.util.ArrayList'
            // 因为ArrayList 重写了 toString方法 因此
            // 又会调用ArrayList集合中元素的toString方法 即调用pet.toString
            // 而pet.toString 中 直接输出了user对象 就又会调用user.toString...
            // 因此造成了栈溢出
            ", pets=" + pets + ", pets.getClass='" + pets.getClass() + '\'' +
            '}';
}
```





---

# 13 如果注解中有多个值,value = 不能省略 否则报错

![image-20231103201749529](D:\TyporaPhoto\image-20231103201749529.png)



![image-20231103201715358](D:\TyporaPhoto\image-20231103201715358.png)





---

# 14 new File("mbg2.xml"); 在不同环境下 读取文件的路径不同



```
// 总结: 在maven生成的项目的test环境下的junit测试环境下
// 使用 new File("mbg2.xml"); 不带斜杠 默认读取的路径是在项目下
// 但是如果是在普通的Java项目 module 下的普通的junit单元测试环境下
// 读取文件的路径是在module下
```





注意不要使用核心文件mbg.xml文件进行测试！！

测试代码如下  可以将下面的这段代码 拿到不同的环境中进行测试 

如 

1. 普通的Java工程 junit @Test 环境

   ![image-20231108202903187](D:\TyporaPhoto\image-20231108202903187.png)

2. maven 创建的 web项目 furn_ssm 项目下 的 项目专门的test环境 下 使用  junit @Test junit @Test 进行测试

![image-20231108202824083](D:\TyporaPhoto\image-20231108202824083.png)



```java
 @Test
    public void t2(){

        // 如果这里这样访问=> new File("mbg.xml");
        // 总结: 在maven生成的项目的test环境下的junit测试环境下
        // 使用 new File("mbg2.xml"); 不带斜杠 默认读取的路径是在项目下
        // 但是如果是在普通的Java项目 module 下的普通的junit单元测试环境下
        // 读取文件的路径是在module下

        File file2 = new File("mbg2.xml");

        // 如果这里这样访问=> new File("mbg.xml");
        // 在这里读取 需要将 mbg.xml 文件直接放在module下
        // File file = new File("mbg.xml");


        if (file.exists()){
            if (file.delete()){
                System.out.println("test删除成功");
            }else {
                System.out.println("test删除失败");
            }
        }else {
            System.out.println("test该文件不存在");
            try {
                file.createNewFile();
                System.out.println("test文件绝对路径：" + file.getAbsolutePath());
                //文件绝对路径：D:\testFile
                System.out.println("test文件创建成功");
            } catch (IOException e) {
                e.printStackTrace();
            }
        }


//调用相应的方法，得到对应的信息
        System.out.println("文件名：" + file.getName()); // 文件名：news1.txt
        System.out.println("文件绝对路径：" + file.getAbsolutePath());
        System.out.println("文件父级目录：" + file.getParent());
        System.out.println("文件大小(字节)：" + file.length());
        System.out.println("文件是否存在：" + file.exists());
        System.out.println("是否为文件：" + file.isFile());
        System.out.println("是否是一个目录:" + file.isDirectory());//文件夹


    }
```





---



# 15 
