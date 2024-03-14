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

# 8 BOM的介绍 BOM是 "Bill of Materials" 的缩写

BOM 是 "Bill of Materials" 的缩写，这是 Maven 和 Gradle 这类构建工具中的一个概念。在 Maven 项目中，BOM 通常是指一个特定的 POM 文件（Project Object Model），它定义了一系列的依赖项及其版本，但不包括实际的依赖实现（即它不会自动将这些依赖添加到构建路径中）。

### BOM的主要作用：

1. **依赖版本管理**：BOM 允许您在一个中央位置定义和管理依赖库的版本，而不是在每个项目或模块中分别指定。这样做可以确保在多个项目或模块之间使用相同版本的依赖项，从而减少版本冲突和维护成本。

2. **简化依赖声明**：在项目中使用 BOM 后，可以在添加依赖项时省略版本号，因为这些版本号已在 BOM 中定义。这使得依赖声明更加简洁，并减少了更新版本时的工作量。

3. **提高一致性和兼容性**：由于所有项目或模块都使用 BOM 中定义的相同版本，这有助于保持构建的一致性和依赖项之间的兼容性。

### 如何使用 BOM：

在 Maven 项目中，可以通过 `<dependencyManagement>` 部分并使用 `<scope>import</scope>` 来引入 BOM。例如，Spring Boot 提供了一个名为 `spring-boot-dependencies` 的 BOM，你可以这样在你的项目中导入它：

```xml
<dependencyManagement>
    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-dependencies</artifactId>
            <version>2.5.3</version>
            <type>pom</type>
            <scope>import</scope>
        </dependency>
    </dependencies>
</dependencyManagement>
```

在这之后，项目中的依赖就可以省略版本号，因为它们将使用 BOM 文件中指定的版本。

通过使用 BOM，你可以在多个项目中轻松管理和同步依赖项版本，同时确保项目的稳定性和一致性。



# 9 `dependencyManagement`的作用

在Maven中，`dependencyManagement`元素用于集中管理项目中所有子模块的依赖版本，而且它本身不会引入任何依赖。这是一个重要的特性，因为它帮助避免了在每个子模块中重复定义相同依赖的不同版本，这样可以使项目的维护变得更简单、更一致。

### `dependencyManagement`的作用:

1. **锁定版本**: 当你在父项目的`dependencyManagement`部分声明依赖时，你可以指定这些依赖的版本号。这意味着所有继承自该父项目的子模块，在引用这些依赖时就不需要再指定版本号了，他们会自动采用在`dependencyManagement`中定义的版本。同时在当前项目(即写dependencyManagement的项目)中引入`dependencyManagement`部分声明依赖时，也不需要再指定依赖的版本号

1. **锁定版本**: 当你在一个 Maven 项目（可以是父项目或任何项目）的`dependencyManagement`部分声明依赖时，你可以指定这些依赖的版本号。这样做的主要目的是为了统一管理项目中使用的依赖版本。这意味着所有继承自该项目的子模块，在引用这些依赖时不需要再指定版本号了，他们会自动采用在`dependencyManagement`中定义的版本。这有助于保持项目的依赖版本一致性和易于管理。
2. **简化依赖声明**: 在具有`dependencyManagement`部分的项目及其子项目中，当添加这些已经在`dependencyManagement`中声明过的依赖时，可以在`<dependencies>`部分中省略`<version>`标签。尽管如此，要在项目的实际构建路径中使用这些依赖，你仍需在项目的`<dependencies>`部分明确地引入它们，但是你可以省略版本号，因为它们会继承自`dependencyManagement`部分的定义。这样可以使依赖声明更加简洁，并减少在多个地方修改依赖版本的需要。
3. **统一管理依赖**: 这帮助确保项目中所有模块对同一个依赖使用相同的版本，从而避免了版本冲突的问题。

# 10 Maven的单继承机制:

Maven的项目结构遵循单继承机制，即每个Maven项目（或模块）只能有一个父项目。这种设计简化了依赖和插件的管理，但它也限制了灵活性——比如，一个子模块不能同时继承多个父项目的配置。

为了克服单继承的限制，Maven引入了`dependencyManagement`和`<scope>import</scope>`的概念。通过在父项目的`dependencyManagement`部分使用`<scope>import</scope>`，你可以“导入”另一个项目（通常是一个“BOM”——Bill of Materials）的`dependencyManagement`部分。这样，父项目实际上可以“继承”多个其他项目的依赖管理策略，而无需直接继承这些项目本身。

在提供的XML片段中：

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-dependencies</artifactId>
    <version>2.2.2.RELEASE</version>
    <type>pom</type>
    <scope>import</scope>
</dependency>
```

这表示项目使用了Spring Boot的依赖管理（BOM）。通过将`spring-boot-dependencies`的`type`设置为`pom`和`scope`设置为`import`，你将Spring Boot定义的所有依赖及其管理的版本“导入”到你的项目中。这意味着当你在你的子模块中添加一个Spring Boot管理的依赖时，你不需要指定该依赖的版本；它会自动使用`spring-boot-dependencies`定义的版本。

总的来说，使用`dependencyManagement`和Maven的单继承机制，可以使项目的依赖管理更加统一和简洁，而`<scope>import</scope>`允许在遵守单继承规则的同时，引入其他项目的依赖管理配置。

# 11 `dependencyManagement`部分使用`<scope>import</scope>` 允许在遵守单继承规则的同时，引入其他项目的依赖管理配置。

在Maven中，使用`<scope>import</scope>`并不是真正打破了单继承规则，而是一种机制，让你能够在保持单继承结构的前提下，将其他项目的依赖管理（比如版本控制）引入到你的项目中。实际上，这个机制允许项目间共享和管理依赖配置，而不是改变Maven的继承结构。

具体来说，当你在一个项目的`dependencyManagement`部分使用`<scope>import</scope>`时，这个项目还是只有一个直接的父项目，遵循了Maven的单继承规则。但是，通过导入另一个项目（通常是一个POM项目，我们称之为BOM，或物料清单）的依赖管理部分，它可以间接地应用多个项目的依赖配置。

这种导入并不改变项目的继承树或结构，而是让当前项目能够引用（import）另一个项目的依赖版本控制信息。这样，即使在Maven的单继承限制下，也可以共享和重用依赖版本控制，实现了依赖管理的“软继承”。

例如，如果你的项目是一个Spring Boot应用，通过在你的项目的`dependencyManagement`中导入`spring-boot-dependencies`，你的项目并没有直接继承自Spring Boot，它的父POM可能是另一个项目。但是，通过`<scope>import</scope>`，你的项目可以使用Spring Boot管理的所有依赖和版本，就像它们是直接在你自己的项目中定义的一样。

因此，`<scope>import</scope>`是一种策略，让你在遵守Maven的单继承规则的同时，还能够灵活地引入和管理跨多个项目的依赖。这是一种逻辑上的继承，而不是结构上的继承。

# 12 `<parent> 和 <scope>import</scope>`的比较

不完全是这样。使用 `<scope>import</scope>` 来导入一个 POM，如 `spring-boot-dependencies`，与将该 POM 设置为 `<parent>` 有重要的区别。

1. **设置为`<parent>`**:
   - 当你将 `spring-boot-starter-parent` 设置为项目的 `<parent>`，你的项目将直接继承 Spring Boot 的配置。这包括依赖管理（dependency management）、插件管理（plugin management）以及其他构建配置。
   - 这实际上意味着你的 Maven 项目将继承自 `spring-boot-starter-parent`，使得你的项目能够自动使用 Spring Boot 定义的默认配置和版本管理。这是单继承——你的项目不能再有另一个父项目。

2. **使用`<scope>import</scope>`**:
   - 当你在项目的 `dependencyManagement` 部分使用 `<scope>import</scope>` 来导入 `spring-boot-dependencies` 时，你不是在设置项目的父项，而是导入了 Spring Boot 的依赖版本控制，而不继承它的其他配置。
   - 这允许你在不更改项目现有父级的情况下，利用 Spring Boot 的依赖管理。你可以继续继承自另一个父 POM，并且仍然能够利用 Spring Boot 对依赖项版本的管理。

简而言之，将 `spring-boot-starter-parent` 设置为 `<parent>` 会让你的项目直接继承 Spring Boot 的全部 Maven 配置。而使用 `<scope>import</scope>` 导入 `spring-boot-dependencies` 仅仅是导入了依赖版本的管理，而不会继承其他构建或配置信息。这样做的好处是你可以保持自己的父 POM，同时利用 Spring Boot 的依赖管理，这在多模块项目中尤其有用。

**即使你通过`<scope>import</scope>`导入了`spring-boot-dependencies`，你仍然需要在项目中显式地添加具体的`<dependency>`元素来实际引入你需要的Spring Boot启动器或其他库。**

# 13 依赖版本的管理作用：

是的，即使你通过`<scope>import</scope>`导入了`spring-boot-dependencies`，你仍然需要在项目中显式地添加具体的`<dependency>`元素来实际引入你需要的Spring Boot启动器或其他库。然而，导入`spring-boot-dependencies`主要提供了以下作用：

### 依赖版本的管理作用：

1. **版本一致性**：当你导入`spring-boot-dependencies`，你实际上是在利用Spring Boot团队为你管理的依赖版本。这意味着你引入的所有Spring Boot管理的库将会自动选用一个经过测试且兼容的版本，你不需要自己指定每个依赖的版本，从而保证了整个项目依赖库的一致性。

2. **简化依赖声明**：由于版本已经被管理，你在项目的`<dependencies>`部分添加依赖时，可以省略`<version>`标签。例如，你只需要像这样声明：

   ```xml
   <dependency>
       <groupId>org.springframework.boot</groupId>
       <artifactId>spring-boot-starter-web</artifactId>
   </dependency>
   ```

   这段代码中没有指定版本号，因为`spring-boot-starter-web`的版本将由导入的`spring-boot-dependencies`控制。

3. **减少版本冲突**：通过统一管理版本，可以减少依赖之间的版本冲突。当多个依赖库可能依赖于相同的子库时，Spring Boot的依赖管理帮助确保所有的库都兼容，减少了因版本不兼容导致的问题。

4. **维护简单**：当需要升级Spring Boot或其他相关库时，通常只需要改变导入的`spring-boot-dependencies`版本。由于所有的Spring Boot库和相关依赖都是通过这个BOM管理的，这样可以确保所有组件都是兼容的，同时简化了升级过程。

### 实际项目中的应用：

虽然你需要在项目中明确引入每个需要的库（如`spring-boot-starter-web`），但你不必担心这些库的具体版本号，因为它们已经通过`spring-boot-dependencies`进行了统一管理。这样做的好处是简化了项目的配置，同时保证了使用的库之间的兼容性和稳定性。

# 14 `<dependencyManagement>`的作用

当然，以下是将上述内容整理成 Markdown 格式的版本：

---

**关于 Maven 的 `<dependencyManagement>` 与 `<dependencies>` 的使用和区别**

### `<dependencyManagement>`的作用:

1. **版本管理**:
   在 `<dependencyManagement>` 内部声明的 `<dependencies>` 用于管理项目依赖的版本和范围。它定义了一组依赖的版本管理模板，这些版本可以被该项目的所有模块共享和继承。

2. **统一控制**:
   使用 `<dependencyManagement>` 可以在父项目中统一控制多个子模块的依赖版本，确保项目整体依赖的一致性，减少版本冲突。

### 实际引入依赖：

1. **独立声明**:
   实际要在项目构建路径中使用依赖，必须在项目的 `<dependencies>` 部分单独声明这些依赖。仅当在 `<dependencyManagement>` 中定义了这些依赖时，你才可以在 `<dependencies>` 部分引入它们而省略版本号。

2. **引入依赖**:
   在 `<dependencies>` 中声明的依赖才会被实际引入到项目中。如果相应的依赖在 `<dependencyManagement>` 中已有定义，则引入时可以不指定版本号，这样依赖版本会自动继承自 `<dependencyManagement>` 中的设置。

### 示例说明：

```xml
<dependencyManagement>
    <dependencies>
        <dependency>
            <!-- 这里的依赖用于版本管理，并不实际引入到项目中 -->
            <groupId>...</groupId>
            <artifactId>...</artifactId>
            <version>...</version>
        </dependency>
    </dependencies>
</dependencyManagement>

<dependencies>
    <dependency>
        <!-- 这里的依赖才会被实际引入到项目中 -->
        <groupId>...</groupId>
        <artifactId>...</artifactId>
        <!-- 如果已在dependencyManagement中声明，可以省略version -->
    </dependency>
</dependencies>
```

通过以上设置，你可以在父项目中使用 `<dependencyManagement>` 来统一管理依赖版本，同时在具体项目或模块中通过 `<dependencies>` 实际引入所需依赖。这种做法有助于维护大型项目的依赖版本一致性，同时保持了各模块依赖的灵活性。

# 15
