# 1 通过cmd控制台启动的vue项目关闭方法

**启动vue项目 按给出指令执行即可**

![image-20231109160253193](D:\TyporaPhoto\image-20231109160253193.png)

cmd控制台关闭vue项目 输入	**CTRL**+**C**

![image-20231109160124967](D:\TyporaPhoto\image-20231109160124967.png)



---

# 2 如果无意间点了 Add el... 

意思是 idea 识别不到这个标签 

添加 el... 到自定义 html 标签

![image-20231112213448234](D:\TyporaPhoto\image-20231112213448234.png)



将其从自定义标签库删除 

操作方法是

In *Settings | Editor | Inspections, HTML | Unknown HTML* tag inspection, remove it from *Custom HTML tags*: list:

![image-20231112213721403](D:\TyporaPhoto\image-20231112213721403.png)



---

# 3 SpringMVC返回的是一个实体类，对象或者集合

```
当return的是一个实体类，对象，集合的时候，
就不能普通的return，那样回报解析不了的错误，这里使用jackson来进行类型转换
```

第一步：在pom.xml 添加jackson依赖 ,处理前端发送的json数据

~~~xml

<dependency>
    <groupId>com.fasterxml.jackson.core</groupId>
    <artifactId>jackson-databind</artifactId>
    <version>2.12.4</version>
</dependency>

~~~

第二步：配置结果转换器

~~~xml
<!--配置结果转换器-->
    <!--<bean class="org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter">
        <property name="messageConverters">
            <list>
                &lt;!&ndash;把响应结果转换成json个数数据&ndash;&gt;
                <bean class="org.springframework.http.converter.json.MappingJackson2HttpMessageConverter"/>
            </list>
        </property>
    </bean>-->

<!--注解驱动 自动根据依赖配置转换器-->
    <mvc:annotation-driven/>
~~~

上面配置结果转换器可以省略，写上注解驱动下面的内容即可，会自动配置转换

第三步：编写controller

~~~
//响应json数据
    @RequestMapping("/method6")
    @ResponseBody
    public List<User> method6(){
        List<User> list = new ArrayList<User>();
        for(int i = 1;i<=3;i++){
            User user = new User();
            user.setId(i);
            user.setName("张三");
            user.setAge(18);
            list.add(user);
        }
        return list;
    }
~~~

//在这里就可以直接返回对象，集合之类的了



---

# 4 @responseBody注解的使用

> 1、@responseBody注解的作用是将controller的方法返回的对象通过适当的转换器转换为指定的格式之后，写入到response对象的body区，通常用来返回JSON数据或者是XML
>  数据，需要注意的呢，在使用此注解之后不会再走试图处理器，而是直接将数据写入到输入流中，他的效果等同于通过response对象输出指定格式的数据。



2

```java
　@RequestMapping("/login")
　　@ResponseBody
　　public User login(User user){
　　　　return user;
　　}
　　User字段：userName pwd
　　那么在前台接收到的数据为：'{"userName":"xxx","pwd":"xxx"}'

　　效果等同于如下代码：
　　@RequestMapping("/login")
　　public void login(User user, HttpServletResponse response){
　　　　response.getWriter.write(JSONObject.fromObject(user).toString());
　　}
```



```java
package com.toltech.controller;

import com.alibaba.fastjson.JSON;
import com.toltech.pojo.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by wanggs on 2017/8/9.
 */
@Controller
public class ResponseController {
    @RequestMapping("/response")
    public void response(HttpServletResponse response) throws IOException {
        User user = new User();
        user.setEmail("123@qq.com");
        user.setId(001);
        user.setPassword("******");
        user.setUserName("tom");
        
        response.getWriter().write(JSON.toJSON(user).toString());
    }

    @ResponseBody
    @RequestMapping("/re")
    public User response() {
        User user = new User();
        user.setEmail("123@qq.com");
        user.setId(001);
        user.setPassword("******");
        user.setUserName("tom");
        return user;
    }
}
```



作者：wanggs
链接：https://www.jianshu.com/p/1233b22738d8
来源：简书

第二篇文章解释 @ResponseBody：

 [@ResponseBody注解作用和原理](https://www.cnblogs.com/nsywBlog/p/14826924.html)

- @responsebody这个注解表示你的返回值将存在responsebody中返回到前端，也就是将return返回值作为请求返回值，return的数据不会解析成返回跳转路径，将java对象转为json格式的数据，前端接收后会显示将数据到页面，如果不加的话 返回值将会作为url的一部分，页面会跳转到这个url，也就是跳转到你返回的这个路径。
-  @ResponseBody这个注解通常使用在控制层（controller）的方法上，其作用是将方法的返回值以特定的格式写入到response的body区域，进而将数据返回给客户端。当方法上面没有写ResponseBody,底层会将方法的返回值封装为ModelAndView对象。
-  @ResponseBody这个注解使用情景：当返回的数据不是html标签的页面，而是其他某种格式的数据时（如json、xml等）使用，常用在ajax异步请求中，可以通过 ajax 的“success”：fucntion(data){} data直接获取到。
-  @ResponseBody这个注解一般是作用在方法上的，加上该注解表示该方法的返回结果直接写到Http response Body中，在RequestMapping中 return返回值默认解析为跳转路径，如果你此时想让Controller返回一个字符串或者对象到前台。

 

举个栗子：下面这一段代码的return返回值是做为json格式在前台页面显示，而不是把return返回值做为请求的url：

[![复制代码](D:\TyporaPhoto\copycode.gif)](javascript:void(0);)

```
 1     @RequestMapping(value="/login",method=RequestMethod.POST)
 2     @ResponseBody
 3     public Map<String,String> loginAct(User user,String cpacha){
 4         Map<String,String> ret = new HashMap<String,String>(); 
 5         if(user == null) {
 6             ret.put("type","error");
 7             ret.put("msg","请填写用户信息！");
 8         }
 9         if(cpacha==null) {
10             ret.put("type", "error");
11             ret.put("msg","请填写验证码！");
12         }
13         if(StringUtil.isEmpty(user.getUsername())) {
14             ret.put("type","error");
15             ret.put("msg","请填写用户名！");
16         }
17         if(StringUtil.isEmpty(user.getPassword())) {
18             ret.put("type","error");
19             ret.put("msg", "请填写密码！");
20         }
21         ret.put("type", "success");
22         ret.put("msg", "登陆成功！");
23         return ret;    
24     }
```

---

# 5 Vue 当绑定事件的方法只有一句话时，可以直接写在绑定事件的位置

![image-20231113224626952](D:\TyporaPhoto\image-20231113224626952.png)



---

# 6 furnList是一个List集合时， 注解@ResponseBody 返回的json格式 为 [{},{},{}] ,数组包含n个对象的形式





```java
@RequestMapping("/furns")
@ResponseBody
public Msg listFurns() {
    List<Furn> furnList = furnService.findAll();

    // Msg msg = Msg.success();
    // msg.add("furnList",furnList);

    // return msg;
    return Msg.success().add("furnList",furnList);
}
```



```
@Override
public List<Furn> findAll() {
    // 返回所有家居数据，传入 null 即可
    List<Furn> furns = furnMapper.selectByExample(null);
    // select id, name, maker, price, sales, stock, img_path from furn

    return furns;
}
```



```java
@Test
public void findAll() {
    List<Furn> furnList = furnService.findAll();
    for (Furn furn : furnList) {
        System.out.println(furn);
        // 返回给前端的list中 furn对象 都有id
        // Furn{id=1, name='hh桌子1', maker='tt家居1', price=180.00, sales=666, stock=7, imgPath='assets/images/product-image/1.jpg'}

    }
    // System.out.println("furnList= " + furnList);


}
```



前端接收到的结果

~~~json
{
    "code": 200,
    "msg": "success",
    "extend": {
        "furnList": [
            {
                "id": 1,
                "name": "hh桌子1",
                "maker": "tt家居1",
                "price": 180.00,
                "sales": 666,
                "stock": 7,
                "imgPath": "assets/images/product-image/1.jpg"
            },
            {
                "id": 2,
                "name": "简 约 风 格 小 椅 子",
                "maker": "熊 猫 家 居",
                "price": 180.00,
                "sales": 666,
                "stock": 7,
                "imgPath": "assets/images/product-image/2.jpg"
            },
        ]
    }
}
~~~

---

# 7 

