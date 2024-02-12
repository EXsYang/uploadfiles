# 0 Maven 配置文件位置

C:\用户\yangd\.m2\

![image-20231226155514428](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20231226155514428.png)

以下是Maven相关设置文件，本地仓库路径的位置



![image-20231227225019027](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20231227225019027.png)





---



# 1 创建Maven项目报错 [WARNING] No archetype found in remote catalog. Defaulting to internal catalog（已解决）

> 问题描述：当创建maven-archetype-webapp时出现警告提示
>
> [WARNING] No archetype found in remote catalog. Defaulting to internal catalog



![image-20231227140955242](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20231227140955242.png)

![image-20231227140812175](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20231227140812175.png)



解决方法参考链接https://blog.csdn.net/gao_zhennan/article/details/123247536

该博客文章讨论了在使用 Maven 生成项目模板时遇到的一个常见警告：“No archetype found in remote catalog. Defaulting to internal catalog”，并提供了解决方案。问题发生在使用 Maven 命令 `mvn archetype:generate` 时，这通常是由于 Maven 配置的镜像仓库中不包含 `archetype-catalog.xml` 文件导致的。作者在调试过程中发现从配置的阿里云镜像仓库中无法找到该文件。

解决方案分为以下几步：

1. 在运行 `mvn archetype:generate` 时(**这里改为在idea创建Maven项目时**)，暂时不使用任何镜像仓库，即使用 Maven 默认的中央仓库。
2. 创建项目模板后，再配置镜像仓库以获取依赖和插件。

此外，作者还提到，这个警告并不会影响 Maven 命令创建项目的功能。对于希望从中央仓库获取更多项目模板的用户，可以直接访问 `https://repo1.maven.org/maven2/archetype-catalog.xml` 并将该文件保存到 Maven 用户目录（通常是 `~/.m2/`）中。这样做可以让用户访问上千个项目模板。尽管这样做可能仍会出现警告，但对正常使用 Maven 没有影响。

解决步骤：

1. 修改Maven配置文件

![image-20231227144719570](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20231227144719570.png)

2. 重新创建 maven-archetype-webapp 项目，注意**此时需要使用外网，需要将Clash的TUN模式打开！！否则还是会出错**

3. 创建成功

   ![image-20231227150403326](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20231227150403326.png)

   

---

# 2 遇到Maven导入不进来报错Failed to read artifact descriptor for com.fasterxml:classmate:jar:1.5.1

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

C:\用户\yangd\.m2\repository

![image-20231226160255345](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20231226160255345.png)

删除repository文件夹

安装 maven helper插件

重新再导入几遍就好使了，注意网络连接有没有代理之类的

---

# 3 Maven 在 dependencyManagement 中导入配置报错Dependency 'org.mybatis.spring.boot:mybatis-spring-boot-starter:2.2.0' not found

> 问题发生的原因:
>
> 在刷新 Maven 时，这通常是由于 Maven 配置的镜像仓库/中央仓库中不包含 `org.mybatis.spring.boot:mybatis-spring-boot-starter:2.2.0` 文件导致的。在调试过程中发现从配置的阿里云镜像仓库中无法找到该文件。

~~~
<dependencyManagement>
     <dependencies> 
     <!--配置springboot 整合mybatis的依赖 mybatis starter-->
		<dependency>
    	 <groupId>org.mybatis.spring.boot</groupId>
    	 <artifactId>mybatis-spring-boot-starter</artifactId>
    	 <!--在这里指定mysql、mybatis.spring.boot.version的版本，不使用版本仲裁
		 <properties>
	 		<mybatis.spring.boot.version>2.2.0</mybatis.spring.boot.version>
		 </properties>
		 -->
    	 <version>${mybatis.spring.boot.version}</version> 
		</dependency>
     </dependencies>
</dependencyManagement>
~~~



> 创建springcloud项目时，在<dependencyManagement>标签中锁定版本时报错如下：



刷新Maven还是报错

![image-20231227214416128](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20231227214416128.png)

因为这时的maven配置的是Maven中央仓库

C:\Users\yangd\.m2\settings.xml中的配置如下：

![image-20231227214848066](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20231227214848066.png)

配置在Maven设置文件中默认的url地址：http://my.repository.com/repo/path 

查看maven中央仓库文档https://mvnrepository.com/ 是否有版本为2.2.0的mybatis-spring-boot-starter依赖 发现有2.0.0这个版本 

从中央仓库下载依赖的地址是 https://repo.maven.apache.org/maven2

![image-20231227220550063](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20231227220550063.png)

解决方法，新建一个Maven项目 真正的导入一下这个jar

![image-20231227222129746](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20231227222129746.png)

刷新Maven

![image-20231227222605351](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20231227222605351.png)

当新建的项目导入成功后，创建的springcloud项目 **e-commerce-center2**的pom.xml中的

**dependencyManagement**标签中指定的版本也不再报错了

![image-20231227223126322](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20231227223126322.png)



需要注意的是：**dependencyManagement**标签主要用于锁定版本，本身并不引入依赖jar,即刷新Maven时看不到依赖的引入dependencies

总结：

1. **Maven下载下来的依赖会保存在本地磁盘C:\Users\yangd\.m2\repository文件中**
2. Maven会去哪里下载依赖的文件会根据Maven配置在C:\Users\yangd\.m2\settings.xml文件中的<mirror>标签的url路径下载文件
3. 如果Maven刷新失败，可以切换配置在C:\Users\yangd\.m2\settings.xml文件中的<mirror>标签的url路径下载文件的url，比如使用阿里镜像
4. 如果使用默认的Maven中央仓库注意需要外网，打开TUN模式

---

# 4 Maven报错Failed to read artifact descriptor for org.springframework.boot:spring-boot-starter-web:jar:2.2.2.RELEASE多次导入失败解决经验

如果在idea中网络使用的是clash TUN 模式 ，同时指定的是从中央仓库下载maven的jar包

，按理说所有的流量都走代理，不应该会下载失败，通过检查本地Maven仓库对应的存放依赖的位置

，如在导入spring-boot-starter-web-2.2.2.RELEASE 时，反复刷新Maven仓库，导入失败如下:

![image-20231228172731302](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20231228172731302.png)

打开本地的Maven仓库 文件夹`C:\Users\yangd\.m2\repository\org\springframework\boot\spring-boot-starter-web\2.2.2.RELEASE\`，发现该文件夹下只含有一个名为`spring-boot-starter-web-2.2.2.RELEASE.pom.lastUpdated`的文件如下：

![image-20231228172301650](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20231228172301650.png)

猜测，因为存在这个文件,导致maven刷新时，不再去Maven仓库下载对应的依赖资源了，在对应的存放maven依赖的文件夹下，将这个`spring-boot-starter-web-2.2.2.RELEASE.pom.lastUpdated`文件删除，在删除后重新刷新Maven，发现此时

maven已经重新开始下载对应的依赖文件`spring-boot-starter-web-2.2.2.RELEASE`了，问题解决！！

~~~xml
spring-boot-starter-web-2.2.2.RELEASE.pom.lastUpdated文件中的内容如下：

#NOTE: This is a Maven Resolver internal implementation file, its format can be changed without prior notice.
#Thu Dec 28 16:44:33 CST 2023
@default-central-https\://repo.maven.apache.org/maven2/.lastUpdated=1703753073751
https\://repo.maven.apache.org/maven2/.error=Could not transfer artifact org.springframework.boot\:spring-boot-starter-web\:pom\:2.2.2.RELEASE from/to central (https\://repo.maven.apache.org/maven2)\: Transfer failed for https\://repo.maven.apache.org/maven2/org/springframework/boot/spring-boot-starter-web/2.2.2.RELEASE/spring-boot-starter-web-2.2.2.RELEASE.pom

~~~

出现该问题的原因可能是之前导入依赖失败过，比如，之前使用的是阿里云镜像网站下载该依赖资源，但是在镜像网站没有该依赖资源，最后生成了这样一个损坏的文件留在本地仓库中，导致后面将下载文件的位置设置到默认的maven中央仓库后，再重新下载该文件时已经不去中央仓库下载了，只需要把这个损坏的文件`spring-boot-starter-web-2.2.2.RELEASE.pom.lastUpdated`删除，重新刷新Maven再导入一次即可

删除后本地仓库中的依赖文件如下：

![image-20231228173332848](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20231228173332848.png)

此时idea右侧Maven选项框中还是爆红

![image-20231228173436665](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20231228173436665.png)

只需要重启idea即可

![image-20231228173607029](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20231228173607029.png)

如果右侧maven选项页还是爆红，尝试 clean Maven ，rebuild project ，重启idan 即可 





---

# 5 在中央仓库中找不到依赖的报错Could not find artifact com.alibaba:druid-spring-boot-starter:jar:unknown in central (https://repo.maven.apache.org/maven2)

这里没有指定版本，父项目中和本项目中都没有指定版本，导致的报错

解决方法：指定版本即可

![image-20231228175644084](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20231228175644084.png)

指定版本

![image-20231228175933018](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20231228175933018.png)

---

# 6 中央仓库明明有对应的jar包，但是刷新maven,导入失败 “Plugin 'com.spotify:docker-maven-plugin:0.4.14' not found”



 ![image-20240212220141206](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240212220141206.png)



![image-20240212220334462](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240212220334462.png)



![image-20240212215613461](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240212215613461.png)



![image-20240212220038363](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240212220038363.png)



# 7 Maven Lifecycle中的clean和package是什么意思。有时项目报错，执行这两个后就好了，为什么

![image-20240213022310286](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240213022310286.png)

在Maven的构建生命周期中，`clean` 和 `package` 是两个不同的阶段，它们有特定的目的：

1. **clean**: 这个阶段是用来清理之前构建生成的文件。在你开始一个新的构建前，你通常会运行 `mvn clean` 来删除 `target` 目录，确保你的新构建不会包含任何旧的或者腐败的数据。这可以帮助避免编译和打包过程中的一些常见问题，如遗留的编译产物导致的不一致性。

2. **package**: 这个阶段是用来将编译后的代码打包成可分发的格式，如 JAR、WAR等。这个过程会包含编译你的代码（如果尚未编译），执行单元测试，然后创建 JAR 或 WAR 文件。这个包是可以部署到服务器上或者用于其他项目作为依赖的。

当你的项目报错时，运行 `mvn clean package` 可以帮助解决问题，因为：

- `mvn clean` 会移除所有之前可能导致问题的旧文件。
- `mvn package` 会重新编译代码和重新打包应用，这意味着它会创建一个全新的构建环境。

这两个命令的组合确保了你从一个干净的状态开始构建项目，这样可以减少因为旧的构建残留物导致的问题。
