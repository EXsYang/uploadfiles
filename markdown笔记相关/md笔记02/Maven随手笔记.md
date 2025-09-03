# 0 Idea中Maven软件只需要修改一次，下一次创建新项目就会自动选择该软件

这里把.m2下idea自带的Maven改了后(改成自己安装的Maven)，再重新创建新的项目，Maven是修改后的，即修改一次下次就会自动选择修改后的Maven。
这里的Maven可以是自定义安装的Maven，也可以是其他Idea软件中的Maven。



![image-20250902211102752](https://tgimgbed.999190.xyz/file/1756818672898_image-20250902211102752.png)



![image-20250902211643020](https://tgimgbed.999190.xyz/file/1756819014288_image-20250902211643020.png)









# 1 当同时存在多个maven软件时，在windows上要如何区分？



查看当前使用的是哪个maven的指令，`mvn -v`

~~~
C:\Users\yangd>mvn -v
Apache Maven 3.6.3 (cecedd343002696d0abb50b32b541b8a6ba2883f)
Maven home: D:\Java_developer_tools\Must_learn_must_know_technology\MavenProgram\apache-maven-3.6.3\bin\..
Java version: 1.8.0_201, vendor: Oracle Corporation, runtime: C:\jdk\jdk1.8\jre
Default locale: zh_CN, platform encoding: GBK
OS name: "windows 10", version: "10.0", arch: "amd64", family: "windows"

~~~



![image-20240415223041052](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240415223041052.png)



![image-20240415223702102](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240415223702102.png)





![image-20240415224218720](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240415224218720.png)



# 2 在 Maven 中，如果 `settings.xml` 文件中的 `<mirrors>` 部分被注释掉或未指定任何镜像，Maven 将默认使用 Maven 中央仓库来下载依赖项。

Maven 中央仓库的地址是：

```
https://repo.maven.apache.org/maven2/
```

### Maven 的默认行为

当你运行 Maven 构建命令（如 `mvn install` 或 `mvn package`）时，Maven 会按照以下顺序解析和下载依赖项：

1. **本地仓库**：Maven 首先检查本地仓库是否已经存在所需的依赖。本地仓库通常位于用户的主目录下的 `.m2/repository` 文件夹中。如果依赖在本地仓库中找到，则 Maven 将直接使用这些依赖，不会去网络上下载。

2. **中央仓库**：如果本地仓库中没有找到所需的依赖，Maven 会尝试从中央仓库下载这些依赖。中央仓库包含了绝大多数公开可用的 Maven 项目。

3. **远程仓库**（如果有配置）：如果你在 `pom.xml` 或 `settings.xml` 中配置了其他远程仓库，Maven 将按照配置尝试从这些仓库下载依赖。

### 如何配置镜像

如果你处于网络环境中，Maven 中央仓库的访问速度较慢或者因为网络限制无法访问，你可以在 `settings.xml` 中配置一个镜像仓库。配置镜像的目的是替代默认的中央仓库或其他特定的远程仓库。这里是一个配置镜像的例子：

```xml
<mirrors>
    <mirror>
      <id>nexus-aliyun</id>
      <mirrorOf>central</mirrorOf>
      <name>Aliyun Central</name>
      <url>https://maven.aliyun.com/repository/central</url>
    </mirror>
</mirrors>
```

这个配置定义了一个 ID 为 `nexus-aliyun` 的镜像，它将镜像 `central` 仓库（即 Maven 中央仓库）的所有请求重定向到阿里云提供的镜像地址。这样配置后，所有原本需要从 Maven 中央仓库下载的依赖都会通过这个镜像来下载。

### 总结

如果你的 `settings.xml` 中没有明确指定镜像，并且 `pom.xml` 中也没有其他仓库配置，Maven 默认会从 Maven 中央仓库下载所需的依赖。这通常是全球许多 Maven 用户的标准配置。如果需要优化下载速度或解决访问问题，适当配置镜像是一个非常有效的方法。

# 3 走国外中央仓库的ieda网络配置

**注意自己安装的maven 配置的是阿里云镜像maven中央仓库**

![image-20240416211553678](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240416211553678.png)





# 3.1 如果Maven配置文件什么仓库都不配置则默认走国外中央仓库



~~~xml
<mirrors>
    <!-- mirror
     | Specifies a repository mirror site to use instead of a given repository. The repository that
     | this mirror serves has an ID that matches the mirrorOf element of this mirror. IDs are used
     | for inheritance and direct lookup purposes, and must be unique across the set of mirrors.
     |
	-->
	
	<!-- 
    <mirror>
      <id>mirrorId</id>
      <mirrorOf>repositoryId</mirrorOf>
      <name>Human Readable Name for this Mirror.</name>
      <url>http://my.repository.com/repo/path</url>		
    </mirror>
	-->

    <!-- 
	<mirror>
    <id>alimaven</id>
    <name>aliyun maven</name>
    <url>http://maven.aliyun.com/nexus/content/groups/public/</url>
    <mirrorOf>central</mirrorOf>
    </mirror> 
	-->

	<!-- 
	<mirror>
	<id>nexus-tencentyun</id>
	<mirrorOf>*</mirrorOf>
	<name>Nexus tencentyun</name>
	<url>http://mirrors.cloud.tencent.com/nexus/repository/maven-public/</url>
	</mirror>
	-->


  </mirrors>
~~~





是的，完全正确。

如果你在 `settings.xml` 的 `<mirrors>` 标签内什么都不配置，或者像你的例子一样将所有 `<mirror>` 都注释掉，那么 Maven 会**默认直接连接到官方的 Maven 中央仓库** (Maven Central Repository) 去下载所有依赖。

------



### 工作原理：Super POM



这个默认行为被定义在 Maven 的一个内置“父项目”文件中，称为 **Super POM**。你可以认为每个 Maven 项目都隐式地继承了这个 Super POM，它包含了最基础的配置，其中就定义了中央仓库：

Super POM 中关于中央仓库的配置大致如下：

XML

```
<repositories>
  <repository>
    <id>central</id>
    <name>Central Repository</name>
    <url>https://repo.maven.apache.org/maven2</url>
    <layout>default</layout>
    <snapshots>
      <enabled>false</enabled>
    </snapshots>
  </repository>
</repositories>
```

所以，当你没有配置任何镜像来“拦截”对 `central` 仓库的请求时，Maven 就会使用上面这个内置的官方地址。

------



### 总结 📝



- **不配置镜像** = **直连官方中央仓库**。
- **配置镜像** = **拦截请求，并转向到你指定的镜像地址**，以提高下载速度。

对于国内用户来说，直连官方仓库的速度通常会比较慢，这就是为什么我们推荐配置国内镜像的原因。







# 4 注意idea的setting中配置的maven只对ThisWindow的项目生效，即默认打开一个新的Maven项目，默认使用的是idea自带的maven软件

默认打开一个新的Maven项目，默认使用的是idea自带的maven软件，同时配置文件和仓库的位置也是默认的配置，如果想要使用自定义的配置文件或是仓库，需要勾选右侧的Override

![image-20240416214320537](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240416214320537.png)



# 5 **全局** setting 和 用户 setting



**1. global settings:** 本机器的配置，使用这台机器的所有用户都使用这个配置。

**2. user settings:** 当前用户的配置。

**3. maven** **安装路径下的 `conf` 下的 `settings` 属于全局配置**: 

**4. **IDEA 中, `.m2/settings.xml` 下属于用户配置: 如图。

![image-20240416215958710](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240416215958710.png)

**5.** **用户配置也可以指定，比如前面我们切换 Maven, 就重新指定了 `user setting`**。

![image-20240416220027212](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240416220027212.png)

**6.** **在 Maven 运行的时候，用户配置会覆盖全局配置, 也就是用户配置优先级高。**



**5.3.5** **注意事项和细节说明**

**1.** **给某个项目指定了新的 Maven, `user setting` 和 `local repository` 只对当前这个项目生效**。

![image-20240416220104602](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240416220104602.png)

**2.** **不会影响你以前创建的 Maven 项目**。

**3.** **创建新的 Maven 项目时, 仍然是默认的 Maven, `user setting` 和 `local repository`**。

![image-20240416220110614](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240416220110614.png)



**4.如果取消勾选User settings 右侧的Override，就会变为默认的.m2\setting.xml,**

**如果在上面User settings指定的配置文件中没有配置自定义本地仓库的位置，那么如果取消勾选Override，就会变为默认的.m2\repository**,<mark>即这个界面中的配置显示的是什么使用的就是什么配置</mark>，如下图:

![image-20240416215550047](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240416215550047.png)



# 6 mvn 指令

<mark>mvn 指令需要在项目根目录下执行，否则报错</mark>

~~~

#查看当前使用的maven的版本，安装目录等信息。要配置使用的maven是哪个，需要到环境变量配置PATH
mvn -v

#编译 需要在maven目录解构的 src 和 pom.xml文件 同级目录下，进入cmd命令行执行
# 生成target/classes 和 target/maven-status文件夹
mvn compile 

#测试 需要在maven目录解构的 src 和 pom.xml文件 同级目录下，进入cmd命令行执行
#生成target/surefire-reports 和 target/test-classes文件夹
mvn test

#打包 需要在maven目录解构的 src 和 pom.xml文件 同级目录下，进入cmd命令行执行
#生成target/maven-archiver 和 target/java-project-maven-1.0-SNAPSHOT.jar(如果在pom.xml文件
#中指定了<packaging>war</packaging> 则会生成maven-archiver和.war文件，如maven-web项目
#web-hello-maven中执行该命令即会如此,这里注意一下)
#.jar 文件的文件名是根据 pom.xml文件中的<artifactId>java-project-maven</artifactId>
# 和 <version>1.0-SNAPSHOT</version> 生成的
mvn package


#安装 将项目安装到本地仓库
mvn install

#清理 完成 maven 项目的清理，会清除/删除 前面生成的/当前的 target 目录
mvn clean

~~~

![image-20240417011415684](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240417011415684.png)

# 7 使用cmd命令行，写mvn命令，编译maven项目，这种最原始的maven编译代码的方式，默认走的是该mvn 命令所在的maven软件中的setting.xml文件的配置吗？是的

![image-20240416234148882](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240416234148882.png)





![image-20240416234327446](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240416234327446.png)

**是的**，当你使用 Maven 来编译代码时，默认情况下 Maven 会使用 `mvn` 命令所在的 Maven 安装目录下的 `conf` 目录中的 `settings.xml` 文件的配置。这个配置文件定义了 Maven 的行为，包括仓库的位置、激活的 profiles、环境配置、服务器认证信息等。

### Maven 的配置文件选择逻辑

1. **全局配置文件**：Maven 的安装目录下的 `conf/settings.xml` 是全局配置文件。这个文件为所有使用该 Maven 安装的用户提供默认配置。

2. **用户级配置文件**：用户目录下的 `.m2/settings.xml`（在 Windows 系统中通常是在 `C:\Users\<username>\.m2` 目录）。这个文件允许用户覆盖全局配置的某些设置。

当你执行 `mvn` 命令时，Maven 会首先查找用户级的 `settings.xml` 文件，如果存在，则使用该文件。如果用户级文件不存在，Maven 将回退到使用全局的 `settings.xml` 文件。

### 为什么需要检查这些配置文件？

- **仓库配置**：确保你的 `settings.xml` 中配置的仓库是可用的，并且是你需要使用的。如果你想要使用阿里云的 Maven 镜像，应确保它被正确配置在 `mirrors` 节点下。
  
- **代理设置**：如果你的网络环境中需要通过代理服务器访问外部网络（如互联网），需要在 `settings.xml` 中正确设置代理。

- **认证信息**：如果你访问的 Maven 仓库需要认证（如私有仓库），需要在 `servers` 节点下配置正确的用户名和密码。

### 如何查看当前 Maven 使用的配置

如果你不确定 `mvn` 命令实际使用的 `settings.xml` 文件位置，可以使用以下命令查看：

```bash
mvn help:effective-settings
```

这个命令会输出 Maven 实际使用的设置，包括从哪个 `settings.xml` 文件读取的配置，以及所有激活的配置详情。这可以帮助你确认 Maven 的配置是否如预期那样工作。

总之，确保 Maven 配置文件正确无误是解决依赖下载问题的一个关键步骤。如果配置正确，且网络无障碍，Maven 应该能够从配置的仓库中正确下载所有依赖项。如果问题依然存在，可能需要进一步检查网络设置或与仓库管理员联系。



# 8 mvn指令使用的位置有要求

<mark>mvn 指令需要在项目根目录下执行，否则报错</mark>

![image-20240417001128636](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240417001128636.png)



![image-20240417001330931](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240417001330931.png)

# 9 `mvn install` 的具体流程

 `mvn install` 是 Maven 的一个重要命令，它通常在本地开发过程中被频繁使用，以确保项目的构件（如 JAR 文件）被安装到本地仓库中，从而可以被同一机器上的其他项目依赖。具体地，`mvn install` 命令执行了以下几个步骤：

### 1. 编译源代码
- **执行目标**：`compile`
- **生成物**：编译后的 `.class` 文件，存放在 `target/classes` 目录。

### 2. 处理资源文件
- **执行目标**：`process-resources`
- **生成物**：将 `src/main/resources` 下的资源文件复制到 `target/classes` 目录，确保这些资源与 `.class` 文件在同一目录，供程序运行时使用。

### 3. 执行单元测试
- **执行目标**：`test`
- **生成物**：运行 `src/test/java` 下的测试代码，生成的测试结果报告存放在 `target/surefire-reports` 目录，编译后的测试代码 `.class` 文件存放在 `target/test-classes` 目录。

### 4. 打包
- **执行目标**：`package`
- **生成物**：根据 `pom.xml` 中定义的打包方式（如 jar, war）将应用打包。通常是创建 JAR 文件，存放在 `target` 目录，例如 `target/java-project-maven-1.0-SNAPSHOT.jar`。

### 5. 安装包到本地仓库
- **执行目标**：`install`
- **生成物**：将包（例如 JAR 文件）复制到本地 Maven 仓库中，位置通常是用户目录下的 `.m2/repository`。这样，同一机器上的其他 Maven 项目就可以通过依赖声明使用这个项目构建的包了。

### 为何使用 `mvn install`?
使用 `mvn install` 将项目安装到本地仓库主要是为了：
- **便于协作**：当多个项目相互依赖时，通过安装到本地仓库，其他项目可以轻松引用依赖，无需每次都重新编译。
- **持续集成**：在持续集成环境中，经常需要从源代码构建项目并使用最新的快照版本，`install` 命令确保所有构件都是最新并且可用。
- **开发效率**：减少了项目间依赖的复杂度，开发者可以专注于他们的工作，而不是依赖管理和更新的问题。

### 总结
`mvn install` 命令不仅包含了编译、测试、打包这些基本步骤，还包括了将构建的成果（如 JAR 文件）安装到本地仓库的过程，使得这些成果可以被其他项目依赖和使用。这一系列步骤保证了项目的构建生命周期在本地开发过程中的完整性和一致性。



# 10 在配置 Tomcat 服务器进行 Maven Web 项目部署时，`war-exploded` 这个术语通常指的是“展开的 WAR 文件”。

#### **`war-exploded` 可以理解为“已解压的 WAR 形式”或“非压缩的 WAR 部署”**

在配置 Tomcat 服务器进行 Maven Web 项目部署时，**`war-exploded`** 这个术语通常指的是“展开的 WAR 文件”。其中文翻译**可以理解为“已解压的 WAR 形式”或“非压缩的 WAR 部署”。**这种部署方式涉及将 WAR 文件的内容解压到 Apache Tomcat 的 webapps 目录下的一个特定文件夹，而不是以单一 WAR 文件的形式部署。

### 解释和使用场景

1. **定义**：
   - **War-exploded**：这是一个部署模式，其中 WAR 文件不是作为一个压缩的归档文件部署，而是其内容被解压到一个目录中。这使得在开发过程中可以不重新打包整个 WAR 文件而直接快速地部署新的代码更改。

2. **优点**：
   - **快速迭代**：开发者可以对代码进行更改后，直接刷新服务器，无需重新打包和部署整个项目，极大提高了开发和测试的效率。
   - **调试方便**：解压的文件可以直接在服务器目录中查看，便于直接修改静态资源（如 HTML, CSS, JS 文件）和快速调试。

3. **配置示例**：
   - 在 IntelliJ IDEA 中，配置 Tomcat 服务器时选择部署方式为 "war-exploded"，这样每次启动服务器或代码更改时，IDEA 会自动将更改的文件同步到 Tomcat 的部署目录下，而无需手动重新打包和部署。

4. **适用场景**：
   - 主要适合于开发和测试阶段，因为这样可以快速地看到更改的效果。
   - 在生产环境中，通常还是会使用压缩的 WAR 文件部署，以优化性能和资源使用。

### 如何设置

在使用 IntelliJ IDEA 等 IDE 进行开发时，你可以在项目的运行/调试配置中设置部署方式为 "war-exploded"。配置步骤如下：

1. 打开项目设置。
2. 导航到 “运行/调试配置”。
3. 选择或创建一个 Tomcat 服务器配置。
4. 在 “部署” 标签页中，添加一个 "Artifact"，选择类型为 "war-exploded"。
5. 应用并保存设置。

通过以上设置，每次代码更改后，IDE 将自动将更新同步到 Tomcat 的部署目录，实现快速部署和测试。这种方式特别适合于动态调整和测试 Web 应用，使得开发过程更加流畅。



# 11 传统web项目创建过程



![image-20240417170450816](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240417170450816.png)



![image-20240417170635921](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240417170635921.png)



![image-20240417170749207](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240417170749207.png)



![image-20240417170905233](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240417170905233.png)





![image-20240417171051166](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240417171051166.png)



## 11.1  在 IntelliJ IDEA 中，传统web项目的“Add as Library”的说明 

在 IntelliJ IDEA 中，当你通过 “Add Framework Support” 创建传统的 Web 项目并使用 “Add as Library” 功能将 JAR 文件加入到项目中时，IDEA 执行了几个关键的步骤来确保这些库在编译和运行时都可用。这里的 “Add as Library” 操作具体做了以下几件事：

### 1. 将 JAR 文件注册到项目依赖中

- **更新项目文件**：IDEA 会更新项目的配置文件（如 `.iml` 文件），在其中记录下添加的库。这个配置告诉 IDEA 编译器在编译项目时需要包含这些 JAR 文件。

### 2. 配置类路径

- **类路径添加**：将 JAR 文件加入到项目的类路径中。类路径是 Java 应用在运行时查找类文件和资源文件的路径集合。加入类路径后，项目中的代码就可以无缝访问和使用 JAR 文件中的类和资源。

### 3. 方便管理和更新

- **库管理**：通过将 JAR 文件添加为库，IDEA 允许你统一管理所有外部依赖。例如，如果一个库需要更新或替换，你可以在 IDEA 的库管理界面中进行操作，而不必手动更改多个项目设置。

### 4. 支持构建和部署

- **自动包含到构建输出**：在 Web 项目中，特别是需要部署到如 Tomcat 或 JBoss 等服务器的项目，IDEA 确保所有必要的库都会被自动包含在构建的输出（如 WAR 文件）中。

### 将 JAR 文件放到了哪里？

当你使用 “Add as Library” 将 JAR 文件加入到项目中时，这些 JAR 文件物理上通常保留在你指定的位置，例如你可能将它们放在 `web/WEB-INF/lib/` 目录下。这个目录是 Java EE Web 应用的标准库目录，Web 容器（如 Tomcat）会自动从这个目录加载库：

- **物理存储**：JAR 文件保留在你放置它们的目录中，不会被复制到其他位置。
- **项目设置中的引用**：IDEA 在项目设置中保存对这些 JAR 文件的引用路径。

### 为什么选择 “Add as Library”？

这样做的好处包括但不限于：

- **减少错误**：自动处理类路径和依赖项，减少因配置错误导致的问题。
- **增强兼容性**：确保所有开发者和环境中的项目设置一致，提高项目的兼容性。
- **易于维护**：集中管理依赖库，便于升级和替换库文件。

总之，通过使用 IntelliJ IDEA 的 “Add as Library” 功能，你可以更有效地管理项目依赖，并确保项目的构建和部署过程中依赖项的正确性和一致性。这是一个非常实用的功能，特别是在处理较大或复杂的项目时。

## 11.2 



# 12 web-maven项目注意事项



## 1 关于类路径中包含 C:\Users\yangd\.m2\repository\com\hspedu\java-project-maven\1.0-SNAPSHOT\java-project-maven-1.0-SNAPSHOT.jar; 的说明

![image-20240417172917722](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240417172917722.png)



mvn install 安装jar的过程如下

~~~
Downloaded from nexus-aliyun: https://maven.aliyun.com/repository/central/org/codehaus/plexus/plexus-utils/3.0.5/plexus-
utils-3.0.5.jar (0 B at 0 B/s)
Downloaded from nexus-aliyun: https://maven.aliyun.com/repository/central/org/codehaus/plexus/plexus-digest/1.0/plexus-d
igest-1.0.jar (0 B at 0 B/s)
[INFO] Installing D:\Java_developer_tools\mycode\maven\hspedu_mymaven\java-project-maven\target\java-project-maven-1.0-S
NAPSHOT.jar to C:\Users\yangd\.m2\repository\com\hspedu\java-project-maven\1.0-SNAPSHOT\java-project-maven-1.0-SNAPSHOT.
jar
[INFO] Installing D:\Java_developer_tools\mycode\maven\hspedu_mymaven\java-project-maven\pom.xml to C:\Users\yangd\.m2\r
epository\com\hspedu\java-project-maven\1.0-SNAPSHOT\java-project-maven-1.0-SNAPSHOT.pom
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  22.190 s
[INFO] Finished at: 2024-04-17T00:54:53+08:00
[INFO] ------------------------------------------------------------------------

D:\Java_developer_tools\mycode\maven\hspedu_mymaven\java-project-maven>
~~~



类路径如下：

~~~
C:\jdk\jdk1.8\bin\java.exe -ea -Didea.test.cyclic.buffer.size=1048576 "-javaagent:D:\Java_developer_tools\developer_tools_IDEA\IntelliJ IDEA 2020.2.1\lib\idea_rt.jar=49891:D:\Java_developer_tools\developer_tools_IDEA\IntelliJ IDEA 2020.2.1\bin" -Dfile.encoding=UTF-8 -classpath "D:\Java_developer_tools\developer_tools_IDEA\IntelliJ IDEA 2020.2.1\lib\idea_rt.jar;D:\Java_developer_tools\developer_tools_IDEA\IntelliJ IDEA 2020.2.1\plugins\junit\lib\junit5-rt.jar;D:\Java_developer_tools\developer_tools_IDEA\IntelliJ IDEA 2020.2.1\plugins\junit\lib\junit-rt.jar;C:\jdk\jdk1.8\jre\lib\charsets.jar;C:\jdk\jdk1.8\jre\lib\deploy.jar;C:\jdk\jdk1.8\jre\lib\ext\access-bridge-64.jar;C:\jdk\jdk1.8\jre\lib\ext\cldrdata.jar;C:\jdk\jdk1.8\jre\lib\ext\dnsns.jar;C:\jdk\jdk1.8\jre\lib\ext\jaccess.jar;C:\jdk\jdk1.8\jre\lib\ext\jfxrt.jar;C:\jdk\jdk1.8\jre\lib\ext\localedata.jar;C:\jdk\jdk1.8\jre\lib\ext\nashorn.jar;C:\jdk\jdk1.8\jre\lib\ext\sunec.jar;C:\jdk\jdk1.8\jre\lib\ext\sunjce_provider.jar;C:\jdk\jdk1.8\jre\lib\ext\sunmscapi.jar;C:\jdk\jdk1.8\jre\lib\ext\sunpkcs11.jar;C:\jdk\jdk1.8\jre\lib\ext\zipfs.jar;C:\jdk\jdk1.8\jre\lib\javaws.jar;C:\jdk\jdk1.8\jre\lib\jce.jar;C:\jdk\jdk1.8\jre\lib\jfr.jar;C:\jdk\jdk1.8\jre\lib\jfxswt.jar;C:\jdk\jdk1.8\jre\lib\jsse.jar;C:\jdk\jdk1.8\jre\lib\management-agent.jar;C:\jdk\jdk1.8\jre\lib\plugin.jar;C:\jdk\jdk1.8\jre\lib\resources.jar;C:\jdk\jdk1.8\jre\lib\rt.jar;D:\Java_developer_tools\mycode\maven\test-maven-project\target\test-classes;D:\Java_developer_tools\mycode\maven\test-maven-project\target\classes;C:\Users\yangd\.m2\repository\com\hspedu\java-project-maven\1.0-SNAPSHOT\java-project-maven-1.0-SNAPSHOT.jar;C:\Users\yangd\.m2\repository\junit\junit\4.12\junit-4.12.jar;C:\Users\yangd\.m2\repository\org\hamcrest\hamcrest-core\1.3\hamcrest-core-1.3.jar" com.intellij.rt.junit.JUnitStarter -ideVersion5 -junit4 at.sgg.TestHi,test01

~~~



发现类路径中包含：

~~~
C:\Users\yangd\.m2\repository\com\hspedu\java-project-maven\1.0-SNAPSHOT\java-project-maven-1.0-SNAPSHOT.jar;
~~~

其中 `\com\hspedu\`的生成与在pom.xml文件中的  **Group ID** (`com.hspedu`) 相关



![image-20240417174402827](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240417174402827.png)

在 Maven 中，本地仓库中的路径构建是基于项目的坐标来生成的，具体涉及 `groupId`、`artifactId` 和 `version`。对于你的项目：

- `groupId`: com.hspedu
- `artifactId`: java-project-maven
- `version`: 1.0-SNAPSHOT

### 2 路径生成规则

当你执行 `mvn install` 命令时，Maven 将构建的 JAR 文件以及相关的项目描述文件（POM 文件）安装到本地仓库中。这些文件的存储路径是根据项目的坐标生成的，遵循以下格式：

```
{local_repository}/{group_id}/{artifact_id}/{version}/{artifact_id}-{version}.jar
```

其中 `{local_repository}` 是本地仓库的路径，通常是用户主目录下的 `.m2/repository` 目录。`{group_id}`、`{artifact_id}` 和 `{version}` 分别对应于项目的 `groupId`、`artifactId` 和 `version`。例如：

- **Local Repository Path**：`C:\Users\yangd\.m2\repository`
- **Group ID** (`com.hspedu`)：变换为路径 `com/hspedu`
- **Artifact ID** (`java-project-maven`)：作为路径的一部分
- **Version** (`1.0-SNAPSHOT`)：作为子目录

因此，结合上述规则，你的项目 JAR 文件和 POM 文件的路径会是：

```
C:\Users\yangd\.m2\repository\com\hspedu\java-project-maven\1.0-SNAPSHOT\java-project-maven-1.0-SNAPSHOT.jar
C:\Users\yangd\.m2\repository\com\hspedu\java-project-maven\1.0-SNAPSHOT\java-project-maven-1.0-SNAPSHOT.pom
```

### 3 `groupId` vs. 包路径

- **`groupId`**：这是一个基本的项目标识符，用于唯一标识一个项目组。它常常表达为包名风格（如 `com.hspedu`），在 Maven 仓库中转换为路径形式，但这与代码内的 Java 包路径无直接关系。
- **包路径**：Java 源代码中的 `package` 声明，决定了 Java 类文件在 JAR 包内的存储结构。例如，`package com.hspedu.app;` 的类会在 JAR 包内的 `com/hspedu/app/` 路径下。

因此，`com\hspedu` 路径是直接基于 `groupId` 生成的，与 JAR 中的包路径无关，后者是源代码层面的组织结构。

这样的设计使得 Maven 可以在全球范围内的项目中管理依赖并避免命名冲突，同时也方便了项目管理和模块化开发。希望这解答了你的疑问！如果还有其他问题或需要进一步的解释，欢迎继续询问。



## 2 在 `pom.xml` 文件中包含 `java-project-maven` 作为依赖项，这正是导致在类路径中出现 `C:\Users\yangd\.m2\repository\com\hspedu\java-project-maven\1.0-SNAPSHOT\java-project-maven-1.0-SNAPSHOT.jar` 的原因。

是的，你的理解是正确的。在你的 `pom.xml` 文件中包含 `java-project-maven` 作为依赖项，这正是导致在类路径中出现 `C:\Users\yangd\.m2\repository\com\hspedu\java-project-maven\1.0-SNAPSHOT\java-project-maven-1.0-SNAPSHOT.jar` 的原因。这里的过程涉及几个关键的 Maven 依赖管理和构建步骤，我将逐一解释：

### 1. 依赖声明

在你的 `pom.xml` 中，你声明了对 `java-project-maven` 项目的依赖：

```xml
<dependency>
    <groupId>com.hspedu</groupId>
    <artifactId>java-project-maven</artifactId>
    <version>1.0-SNAPSHOT</version>
</dependency>
```

这表示 Maven 在构建 `test-maven-project` 项目时，需要先解析并下载（如果本地仓库中没有）`java-project-maven` 项目的 JAR 文件。

### 2. 依赖解析和下载

Maven 会查看本地仓库（默认在 `C:\Users\{username}\.m2\repository`）是否存在指定的依赖。如果依赖不存在，Maven 会尝试从远程仓库下载这个依赖到本地仓库中。由于你之前已经执行过 `mvn install`，所以 `java-project-maven` 的 JAR 文件和相关的 POM 文件已经安装到了本地仓库中。

### 3. 类路径的构成

当 Maven 解析并确认依赖可用后，它会自动将这些依赖的 JAR 文件路径添加到你的项目的类路径中。这是为了确保在编译和运行你的项目时，所有依赖的类都可用。因此，`java-project-maven-1.0-SNAPSHOT.jar` 被添加到类路径中，其路径为:

```
C:\Users\yangd\.m2\repository\com\hspedu\java-project-maven\1.0-SNAPSHOT\java-project-maven-1.0-SNAPSHOT.jar
```

### 4. 使用依赖中的类

添加到类路径后，Maven 项目中的任何 Java 文件都可以直接导入并使用 `java-project-maven` JAR 中的类，例如 `Hello.java` 中定义的 `Hello` 类。这就像在 Java 项目中直接引用本地库一样，无需任何特殊配置。

```java
import com.hspedu.java_project_maven.Hello; // 假设 Hello.java 位于这个包下

public class Test {
    public static void main(String[] args) {
        Hello hello = new Hello();
        hello.sayHello();
    }
}
```

### 为什么可以直接使用这些类？

- **类路径包含**：因为 Maven 自动处理依赖并更新了项目的类路径，包括了所有必要的 JAR 文件。
- **Java 类加载机制**：在运行时，Java 虚拟机(JVM)会根据类路径查找并加载所需的类。由于依赖的 JAR 文件已经在类路径中，JVM 能够找到并加载这些类。

### 结论

通过在 `pom.xml` 中声明依赖，Maven 管理了复杂的依赖树和类路径问题，使得开发者可以专注于业务逻辑的开发，而不是依赖的具体管理。这种依赖管理方式保证了项目构建的一致性和可移植性，是现代 Java 项目开发中推荐的做法。



## 3 在 Java 开发中，当使用类路径来引用 JAR 文件时，确实**不需要将 JAR 文件解压**。这是因为 Java 虚拟机（JVM）和各种 Java 工具链（如编译器和运行时环境）都设计有能力直接从 JAR 文件中读取类和其他资源。以下是几个关键点说明为什么直接引用 JAR 文件是足够的，无需解压：

### 1. **JAR 文件的本质**

- **JAR 文件结构**：JAR（Java ARchive）文件实质上是一个 ZIP 格式的压缩文件，用于打包 Java 类文件（.class）和应用程序的资源文件（如图片、文本、配置文件等）。这种格式由 Java 平台原生支持。

### 2. **Java 类加载机制**

- **类加载**：Java 的类加载器可以直接从 JAR 文件中加载类。当你在应用程序中引用某个类时，Java 类加载器会查找类路径（CLASSPATH）指定的所有目录和 JAR 文件，寻找并加载相应的类文件。
- **资源访问**：除了类，JVM 还能从 JAR 文件中加载其他资源，如配置文件、图像等。

### 3. **使用 JAR 文件的优势**

- **便于管理**：使用单个 JAR 文件管理所有相关类和资源，简化了依赖管理，减少了项目中的文件数量，使构建输出更为整洁。
- **性能优化**：JAR 文件由于是压缩格式，可以减少磁盘空间的占用，并且在网络传输（如 Maven 仓库同步）时也能提高效率。
- **保护代码**：压缩的 JAR 文件可以稍微增加反编译的难度，对于某些希望保护其代码不被轻易查看的应用或库来说，这是一个辅助的好处。

### 4. **开发和部署简化**

- **直接部署**：Web 应用程序通常将 JAR 文件放置在 WEB-INF/lib 目录下，应用服务器如 Tomcat 会自动识别这些 JAR 文件并将它们纳入应用的类路径。这简化了部署过程，你只需将 JAR 文件放在正确的位置。
- **构建工具支持**：现代 Java 构建工具（如 Maven 和 Gradle）都内置了对 JAR 文件的处理支持，自动处理依赖和构建路径，无需手动解压或配置复杂的路径。

### 5. **例外情况**

- **需要修改内容时**：如果你需要修改 JAR 文件内的某些文件，这时候可能需要解压，修改后再重新打包。但这种操作一般不推荐在生产环境或常规开发流程中进行。
- **特定的资源访问**：某些非常特殊的情况下，如果资源加载机制与标准 Java 类加载器不兼容，可能需要解压（极少见）。

#### **总结而言，直接在类路径中引用 JAR 文件是 Java 开发中的标准和推荐做法，这既方便又高效。无需解压 JAR 文件即可正常使用其中的类和资源，这是由 Java 的设计直接支持的。**



## 4 在 Java 中，类路径（CLASSPATH）是一个指定查找类文件和包的路径集。当 Java 运行时系统或 Java 编译器需要加载类或资源时，它会在这些指定的路径中查找。对于加载到类路径中的目录，Java 确实可以访问这个目录以及其子目录下的文件，但这里有一些具体的规则和限制需要注意：

### 类文件的加载

1. **.class 文件**：
   - Java 虚拟机（JVM）在类路径中的目录里查找以 `.class` 结尾的文件来加载类。
   - JVM 期望这些类文件遵循与其包结构相对应的目录结构。例如，如果有一个类名为 `com.example.MyClass`，JVM 会期望在类路径的某个目录下找到路径为 `com/example/MyClass.class` 的文件。

### 源文件和编译

2. **.java 文件**：
   - 源代码文件（`.java`）通常不会被直接添加到类路径中。类路径用于查找 Java 的编译代码（即 `.class` 文件）。
   - `.java` 文件需要先被编译成 `.class` 文件，编译器（如 `javac`）也可以通过类路径来查找这些源文件需要的类的引用。

### 资源文件的加载

3. **资源文件**：
   - 除了 `.class` 文件，类路径也用于定位其他资源文件，如配置文件、图片等。
   - 这些资源可以被应用直接通过类加载器访问，使用相对于类路径根目录的路径。例如，使用 `ClassLoader.getResource("config/settings.xml")` 可以加载类路径下的 `config/settings.xml` 文件。

### 特殊情况

4. **非标准文件结构**：
   - 如果类文件或资源文件没有放在正确的包结构目录中，它们将无法被正确加载。例如，如果 `MyClass.class` 直接放在类路径的根目录下而不是其包对应的目录结构中，它将无法被包为 `com.example` 的类引用。

### 总结

- **类路径中的目录**：Java 可以访问加载到类路径中的目录及其子目录下的 `.class` 文件和其他资源文件，但是 `.java` 文件需要编译成 `.class` 文件才有用。
- **访问权限**：只有遵循了正确的包目录结构的类文件和资源文件才能被正确加载和访问。
- **动态加载**：Java 的类加载器支持动态地加载类路径中的类文件，这是 Java 应用常用的扩展和插件加载机制的基础。

这些特性使得 Java 在运行时具有极高的灵活性和扩展性，但也要求开发者正确管理项目的目录结构和类路径配置。



# 13 在maven-Java项目 maven_A中创建同级的 maven_D的方式

![image-20240731215352177](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240731215352177.png)

![image-20240417194627807](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240417194627807.png)



![image-20240417194702919](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240417194702919.png)



![image-20240417194750009](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240417194750009.png)



![image-20240417194824486](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240417194824486.png)



![image-20240417194908677](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240417194908677.png)



![image-20240417195018396](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240417195018396.png)



![image-20240417195145894](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240417195145894.png)



![image-20240417195230474](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240417195230474.png)





# 12.1 idea2024.1中创建Maven-Java项目的方式

![image-20240731215352177](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240731215352177.png)



### idea2024.1中创建Maven-Java项目的方式如下所示：

![image-20240731215025916](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240731215025916.png)





# 14  Maven 插件与 Maven 版本之间的兼容性对应关系说明

在 Maven 中，确实存在某些 Maven 插件与 Maven 版本之间的兼容性对应关系。这种对应关系主要是由于插件依赖于 Maven 的某些内部 API 或功能，这些 API 或功能可能会在不同的 Maven 版本中变化。然而，并没有一个统一的官方文档直接列出所有 Maven 版本与其插件版本的对应关系。不过，你可以通过以下几种方法来确定特定 Maven 插件与 Maven 版本之间的兼容性：

### 1. **插件的官方文档**

最直接的方式是查看插件的官方文档。例如，对于 `maven-source-plugin`，可以访问 Apache Maven 的官方插件目录（[Maven Source Plugin](https://maven.apache.org/plugins/maven-source-plugin/)），查看不同版本的插件文档，通常会有版本历史和兼容性说明。

### 2. **插件仓库信息**

你可以在 [Maven Central](https://search.maven.org/) 或其他 Maven 仓库查找插件的具体版本信息。这些仓库通常会展示插件的元数据，包括其依赖关系，有时这些依赖关系中会指定兼容的 Maven 版本。

### 3. **阅读插件的 `pom.xml`**

插件的 `pom.xml` 文件中通常会声明它所依赖的 Maven 版本。下载插件的源代码或从 Maven 中央仓库查看其 `pom.xml` 可以获取这些信息。

```xml
<prerequisites>
    <maven>3.0</maven>
</prerequisites>
```

这个元素指定了插件运行所需的最低 Maven 版本。

### 4. **社区和开发者资源**

- **论坛和问答**：Maven 的用户和开发者社区（如 Stack Overflow）常常讨论关于版本兼容性的问题。
- **开发者邮件列表**：Apache Maven 项目和其他插件项目通常有邮件列表，开发者和用户会在这些平台上讨论版本更新和兼容性问题。

### 5. **构建和测试**

在实际使用中，也可以通过直接在项目中尝试构建来检测版本兼容性。如果遇到由于版本不兼容导致的构建错误，通常需要根据错误信息调整 Maven 或插件的版本。

### 6. **示例：检查插件版本兼容性**

例如，你可以在命令行中使用 Maven 命令来获取 `maven-source-plugin` 的信息：

```bash
mvn help:describe -Dplugin=org.apache.maven.plugins:maven-source-plugin -Ddetail
```

这个命令会显示插件的详细信息，包括其目标、可用参数、默认配置和所需的 Maven 版本。

通过以上方法，你可以较为有效地确认特定的 Maven 插件是否适用于你当前的 Maven 版本。这种做法虽然可能需要一些额外的步骤，但可以有效避免因版本不兼容导致的构建失败。 

# 15 在 IntelliJ IDEA 2022.4的 Maven 设置中勾选 “Use settings from .mvn/maven.config” 的选项的作用





![image-20240602110854643](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240602110854643.png)





在 IntelliJ IDEA 的 Maven 设置中勾选 “Use settings from .mvn/maven.config” 的选项主要用于告诉 IDE 优先使用项目中 `.mvn/maven.config` 文件里的配置，而非全局或用户级的 Maven 配置。

### .mvn/maven.config 文件的作用

`.mvn/maven.config` 是 Maven 项目中的一个配置文件，位于项目根目录下的 `.mvn` 目录中。这个文件允许你为当前项目指定特定的 Maven 配置，这些配置将覆盖全局配置。常用于设置以下内容：

- JVM 参数和 Maven 参数
- 特定的 Maven 插件版本
- 环境特定的配置，如代理设置

### 使用这个选项的好处

1. **项目级配置的一致性**：确保所有使用这个项目的开发者都在相同的 Maven 配置下工作，这有助于减少因环境差异导致的构建问题。

2. **便于项目迁移和共享**：通过将 Maven 配置集中管理在项目内部，可以更容易地分享和迁移项目，不必担心不同开发者机器上的 Maven 配置差异。

3. **简化构建流程**：对于需要特定 Maven 设置的项目，无需修改全局或用户级的 Maven 配置，只需调整项目内的 `.mvn/maven.config` 文件即可。

### 如何使用

- 当这个选项被勾选时，每次构建项目时，IntelliJ IDEA 会读取 `.mvn/maven.config` 文件中的配置，并以此来执行 Maven 命令。
- 如果项目中不存在 `.mvn/maven.config` 文件，或者文件中的某些设置不完整，IDE 将回退到使用其他 Maven 配置（用户级或全局级）。

勾选这个选项后，确保你的项目中的 `.mvn` 目录及其 `maven.config` 文件被正确配置和维护，以避免构建错误或不预期的行为。



# 16 Maven的 settings.xml 文件中直接配置jdk编译的版本为1.8/17，因为有些时候会是1.5的版本，导致一些Java语法用不了,如钻石符号<>



## `C:\Users\yangd\.m2\settings.xml` 文本格式的配置：

~~~xml
  <profiles>
    <!-- JDK 1.8 配置 -->
    <profile>
        <id>jdk-1.8</id>
        <activation>
            <activeByDefault>true</activeByDefault>
            <jdk>1.8</jdk>
        </activation>
        <properties>
            <maven.compiler.source>1.8</maven.compiler.source>
            <maven.compiler.target>1.8</maven.compiler.target>
            <maven.compiler.compilerVersion>1.8</maven.compiler.compilerVersion>
        </properties>
    </profile>

    <!-- JDK 17 配置 -->
<!--     <profile>
        <id>jdk-17</id>
        <activation>
            <activeByDefault>true</activeByDefault>
            <jdk>17</jdk>
        </activation>
        <properties>
            <maven.compiler.source>17</maven.compiler.source>
            <maven.compiler.target>17</maven.compiler.target>
            <maven.compiler.compilerVersion>17</maven.compiler.compilerVersion>
        </properties>
    </profile> -->
  </profiles>
~~~



## pom.xml文件中的配置如下:

~~~xml
 <!--解决 java: -source 1.5 中不支持 diamond 运算符-->
    <properties>
        <java.version>1.8</java.version>
        <maven.compiler.source>8</maven.compiler.source>
        <maven.compiler.target>8</maven.compiler.target>
    </properties>

~~~



## 配置解释：

这是 Maven 的 `settings.xml` 文件中定义的一部分配置，包括两个 JDK 版本的 Maven profile 设置。这些设置确实类似于在 `pom.xml` 文件中指定 JDK 版本，但使用 `settings.xml` 可以更全局地管理和重用配置

这些配置定义了两个 Maven 构建配置文件（profiles），分别用于 JDK 1.8 和 JDK 17。这些配置文件中包含的设置说明如下：

1. **`<id>`**：配置文件的唯一标识符，用于在命令行或 IDE 中引用。
2. **`<activation>`**：
   - **`<activeByDefault>`**：如果设置为 `true`，则此配置文件默认激活。注意，在同一 `settings.xml` 中有多个默认激活的配置文件可能会导致冲突。
   - **`<jdk>`**：指定此配置文件应激活的 JDK 版本。
3. **`<properties>`**：
   - **`maven.compiler.source`**：指定 Java 源代码的版本。
   - **`maven.compiler.target`**：指定生成的类文件的目标 Java 版本。
   - **`maven.compiler.compilerVersion`**：指定用于编译的 JDK 版本。

### 与 pom.xml 中的配置比较

在 `pom.xml` 中直接指定 JDK 版本是针对特定项目的，而在 `settings.xml` 中通过 profiles 配置 JDK 版本可以被多个项目共享。使用 `settings.xml` 配置 JDK 版本可以为不同的项目提供灵活的 JDK 版本切换能力，特别是在你需要在多个项目间频繁切换 JDK 环境时，这种方式更为高效。

### 使用建议

- **避免冲突**：确保不要在 `settings.xml` 中同时激活多个冲突的配置文件。如果有多个 `<activeByDefault>` 设置为 `true`，只有一个会被激活。
- **项目特定设置**：如果项目需要特定的 JDK 版本配置，最好在该项目的 `pom.xml` 中指定，以避免全局配置影响到特定项目的构建。



# 17  idea导入Maven项目报错 ,在包信息上提示需要`Add Library xx to classpath`

> 问题出现的背景是，在JVMDemo1项目中引入一个Maven-java项目，该操作导致出现了大面积报错！



![image-20240801192945078](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240801192945078.png)



解决方案: 

https://stackoverflow.com/questions/38854465/cannot-access-org-springframework-context-configurableapplicationcontext-class-f

![image-20240801193907250](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240801193907250.png)



# 18 java: java.lang.NoSuchFieldError: Class com.sun.tools.javac.tree.JCTree$JCImport does not have member field 'com.sun.tools.javac.tree.JCTree qualid'

解决方案：

https://stackoverflow.com/questions/77171270/compilation-error-after-upgrading-to-jdk-21-nosuchfielderror-jcimport-does-n



报错原因是选择了过高版本的jdk，修改项目modules依赖的jdk版本

,改为pom中指定的对应版本的jdk依赖

通过`File -> New -> Project from existing source`的方式选择一个.pom文件来打开项目

会使得idea自动管理该项目，默认会使用项目配置的jdk，我这里配置的的jdk22

![image-20240801194556812](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240801194556812.png)



查看.pom文件指定的jdk版本是1.8

![image-20240801194713874](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240801194713874.png)



修改项目依赖的版本为1.8

![image-20240801194327287](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/image-20240801194327287.png)



项目启动成功！





# 19 Maven 镜像配置 “第一个匹配优先”



一旦找到**第一个**能够匹配该仓库 ID 的镜像，Maven 就会**立即使用它，并停止继续向后查找**。



~~~xml
<!-- mirrors
   | This is a list of mirrors to be used in downloading artifacts from remote repositories.
   |
   | It works like this: a POM may declare a repository to use in resolving certain artifacts.
   | However, this repository may have problems with heavy traffic at times, so people have mirrored
   | it to several places.
   |
   | That repository definition will have a unique id, so we can create a mirror reference for that
   | repository, to be used as an alternate download site. The mirror site will be the preferred
   | server for that repository.
   |-->
  <mirrors>
    <!-- mirror
     | Specifies a repository mirror site to use instead of a given repository. The repository that
     | this mirror serves has an ID that matches the mirrorOf element of this mirror. IDs are used
     | for inheritance and direct lookup purposes, and must be unique across the set of mirrors.
     |
	-->
	
	<!-- 
    <mirror>
      <id>mirrorId</id>
      <mirrorOf>repositoryId</mirrorOf>
      <name>Human Readable Name for this Mirror.</name>
      <url>http://my.repository.com/repo/path</url>		
    </mirror>
	-->

    
	<!-- <mirror>
    <id>alimaven</id>
    <name>aliyun maven</name>
    <url>http://maven.aliyun.com/nexus/content/groups/public/</url>
    <mirrorOf>central</mirrorOf>
    </mirror> -->
	
	<mirror>
	<id>nexus-tencentyun</id>
	<mirrorOf>*</mirrorOf>
	<name>Nexus tencentyun</name>
	<url>http://mirrors.cloud.tencent.com/nexus/repository/maven-public/</url>
	</mirror>

  </mirrors>

~~~





#### 1. 什么是 Maven 镜像 (Mirror)？



**核心作用**：加速依赖下载。

Maven 镜像相当于一个“重定向器”或“代理服务器”。当你配置了一个镜像后，Maven 在请求某个远程仓库（如官方的 Maven 中央仓库）时，会转而向你指定的镜像地址发起请求。

通常，我们会将镜像地址设置为国内的镜像源（如阿里云、腾讯云、华为云等），因为它们的服务器在国内，访问速度比直连国外的官方仓库快得多。

此配置位于 Maven 的 `settings.xml` 文件中的 `<mirrors>` 标签内。



#### 2. 镜像的匹配规则：“第一个匹配优先”



这是 Maven 镜像机制中最核心、也最容易混淆的一点。

- **顺序**：Maven 会从上到下读取 `settings.xml` 文件中定义的所有 `<mirror>`。
- **匹配**：当需要从某个仓库（比如 ID 为 `central`）下载依赖时，Maven 会拿着这个 ID 逐个检查 `<mirror>` 的 `<mirrorOf>` 设置。
- **决策**：一旦找到**第一个**能够匹配该仓库 ID 的镜像，Maven 就会**立即使用它，并停止继续向后查找**。

**关键点**：它不是一个“备用”或“失败重试”机制。如果第一个匹配的镜像服务器挂了，Maven 构建会直接失败，它不会自动去尝试列表中的第二个镜像。



#### 3. 关键配置项：`<mirrorOf>` 详解



`<mirrorOf>` 标签是镜像配置的灵魂，它决定了当前这个 `<mirror>` 要拦截（或代理）哪个远程仓库的请求。

它有以下几种常见配置：

- **`<mirrorOf>central</mirrorOf>`**
  - **含义**：只拦截对 Maven 中央仓库（repository ID 为 `central`）的请求。如果项目依赖了其他仓库（如 `jcenter`），则该镜像不会生效。
- **`<mirrorOf>\*</mirrorOf>` （最常用）**
  - **含义**：通配符，拦截**所有**的远程仓库请求。无论是 `central` 还是在 POM 文件中定义的任何其他 `<repository>`，所有下载请求都会被这个镜像捕获。
  - **效果**：相当于一个全局代理，简单、高效，是国内开发者的首选配置。
- **`<mirrorOf>repo1,repo2</mirrorOf>`**
  - **含义**：拦截多个指定的仓库，仓库 ID 之间用逗号隔开。
- **`<mirrorOf>\*,!repo-to-exclude</mirrorOf>`**
  - **含义**：拦截所有仓库，**但是**排除（`!`）指定的仓库。例如，`*,!internal-repo` 表示代理所有公共仓库，但不代理公司内部的私有仓库。



#### 4. 关于默认 `settings.xml` 中的示例



在未经修改的 `settings.xml` 文件中，你会看到一段被注释掉（被 `` 包围）的 `<mirror>` 配置：

**必须明确**：

- **这是示例，不是默认值**：它是一个配置模板或例子，告诉你应该如何填写。
- **默认是无效的**：只要它被注释，Maven 就会完全忽略它，它对你的系统没有任何影响。`http://my.repository.com/repo/path` 也只是一个无意义的占位符。

------



### 总结与最佳实践



1. **全局镜像配置**：对于个人开发环境，最省心的方式是配置一个 `<mirrorOf>*</mirrorOf>` 的国内镜像（如腾讯云或阿里云），这样可以加速所有 Maven 项目的构建。
2. **理解匹配规则**：牢记“第一个匹配优先”原则，避免在配置多个镜像时产生逻辑混乱。
3. **区分示例与配置**：`settings.xml` 中被注释掉的部分是说明和示例，不是生效的配置。需要时应取消注释并修改为你自己的值。





# 20 刷新听书项目的Maven总是报错







![image-20250831044832523](https://tgimgbed.999190.xyz/file/1756586918947_image-20250831044832523.png)



~~~
[ERROR] Failed to execute goal org.apache.maven.plugins:maven-compiler-plugin:3.10.1:compile (default-compile) on project model: Fatal error compiling: java.lang.NoSuchFieldError: Class com.sun.tools.javac.tree.JCTree$JCImport does not have member field 'com.sun.tools.javac.tree.JCTree qualid' -> [Help 1]
[ERROR] 
[ERROR] To see the full stack trace of the errors, re-run Maven with the -e switch.
[ERROR] Re-run Maven using the -X switch to enable full debug logging.
[ERROR] 
[ERROR] For more information about the errors and possible solutions, please read the following articles:
[ERROR] [Help 1] http://cwiki.apache.org/confluence/display/MAVEN/MojoExecutionException
[ERROR] 
[ERROR] After correcting the problems, you can resume the build with the command
[ERROR]   mvn <args> -rf :model

~~~





好的，我们来详细解释一下这个常见的 Maven 报错。

这个错误的核心原因是 **版本不兼容**，具体来说，是你用来运行 Maven 的 **JDK 版本** 与项目中的 **Maven 编译器插件 (`maven-compiler-plugin`)** 或其依赖（尤其是 **Lombok**）之间存在冲突。

------



### 问题的根源：版本不兼容 💥



简单来说，错误信息 `NoSuchFieldError` 意味着一个程序（在这里是 Maven 插件）想去调用 Java 编译器内部的一个零件（字段 `qualid`），但在它实际使用的编译器版本里，这个零件根本不存在或者换了个名字。

这就像一个汽修工拿着 1998 年的发动机图纸，去修理一辆 2025 年的电动汽车。他想找的“化油器”在电动车里根本就不存在，于是就彻底懵了。

**最常见的罪魁祸首**：

1. **Lombok 版本过低**：Lombok 通过直接操作 Java 编译器的内部代码来实现功能（如自动生成 `get/set` 方法），因此它对 JDK 版本极其敏感。
2. **`maven-compiler-plugin` 版本过低**：旧的编译器插件不认识新版 JDK 的内部结构。
3. **JDK 版本过高或过低**：你系统环境的 JDK 版本与项目 `pom.xml` 文件中声明的版本不匹配。

------



### 如何解决？



解决方案就是**统一并升级相关工具的版本**，确保它们能够协同工作。请按以下顺序尝试：



#### 方案一（推荐）：更新 `pom.xml` 中的插件版本



这是最常见也是最正确的解决方法。打开你项目模块（`model`）的 `pom.xml` 文件，检查并升级以下配置。

XML

```
<properties>
    <maven.compiler.source>17</maven.compiler.source>
    <maven.compiler.target>17</maven.compiler.target>
    
    <lombok.version>1.18.32</lombok.version> 
</properties>

<dependencies>
    <dependency>
        <groupId>org.projectlombok</groupId>
        <artifactId>lombok</artifactId>
        <version>${lombok.version}</version>
        <scope>provided</scope>
    </dependency>
</dependencies>

<build>
    <plugins>
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-compiler-plugin</artifactId>
            <version>3.13.0</version>
            <configuration>
                <annotationProcessorPaths>
                    <path>
                        <groupId>org.projectlombok</groupId>
                        <artifactId>lombok</artifactId>
                        <version>${lombok.version}</version>
                    </path>
                </annotationProcessorPaths>
            </configuration>
        </plugin>
    </plugins>
</build>
```

**操作指南**：

- 将 `maven-compiler-plugin` 的版本升级到较新的稳定版（例如 `3.13.0`）。
- 将 `lombok` 的版本升级到较新的稳定版（例如 `1.18.32`）。
- 确保 `<maven.compiler.source>` 和 `<maven.compiler.target>` 设置为你希望使用的 Java 版本（例如 11, 17）。

修改后，保存 `pom.xml` 文件并让 Maven 重新加载依赖，然后再次尝试构建。

------



#### 方案二：检查 Maven 使用的 JDK 环境



有时候，你系统里安装了多个 JDK，而 Maven 可能没有使用你期望的那个。

操作指南：

在你的项目根目录下打开终端，运行以下命令：

Bash

```
mvn -v
```

检查输出的 `Java version` 和 `Java home` 是否指向你为这个项目所期望的 JDK 版本。如果不是，请修改你系统的 `JAVA_HOME` 环境变量，使其指向正确的 JDK 安装目录。

------



#### 方案三（备选方案）：降低项目的 JDK 版本



如果因为某些原因不能升级插件，你可以尝试在 `pom.xml` 中降低项目的 Java 版本，使其与你现有的旧插件兼容。

操作指南：

修改 pom.xml 中的 <properties>：

XML

```
<properties>
    <maven.compiler.source>11</maven.compiler.source>
    <maven.compiler.target>11</maven.compiler.target>
</properties>
```

同时，确保你运行 `mvn` 命令的 JDK 环境也是对应的版本（Java 11 或 8）。

------



### 总结



这个错误几乎总是**版本不匹配**导致的。**首选方案是更新 `pom.xml` 中的 `maven-compiler-plugin` 和 `lombok` 的版本**，这能解决 95% 以上的问题。





## 解决方案：修改jdk版本为jdk17

![image-20250831045317509](https://tgimgbed.999190.xyz/file/1756587207498_image-20250831045317509.png)



![image-20250831045326770](https://tgimgbed.999190.xyz/file/1756587213718_image-20250831045326770.png)



# 21 升级项目jdk版本为Jdk17



这个报错的核心原因是：你用来运行 Maven 的 **Java (JDK) 版本太低了**。

------



### 问题的根源：JDK 版本过低 ☕



这个错误的关键信息是 `Unsupported major.minor version 52.0`。这是一个非常明确的 Java 错误，它告诉我们：

1. **版本号 `52.0`** 对应的是 **Java 8**。
2. `Unsupported` 的意思是，你当前的 Java 环境**不支持**这个版本。

**结论**：你项目依赖的 `maven-clean-plugin` 版本 `3.2.0` 是用 **Java 8** 编译的。而你系统里用来执行 `mvn` 命令的 Java 环境是 **Java 7 或者更早的版本**。

这就像试图在一台只能播放 VCD 的老旧影碟机上播放一张蓝光光盘——机器根本不认识这种新的格式，所以直接报错。

------



### 如何解决？



你有两种解决方案，强烈推荐第一种。



#### 方案一（强烈推荐）：升级你的 JDK



这是最正确、最符合现代开发实践的方案。你的开发环境应该使用一个受支持的 Java 版本。

1. **安装新版 JDK**：下载并安装一个 **Java 8 或更高版本** 的 JDK（例如 JDK 8、JDK 11 或 JDK 17 都是不错的选择）。

2. **配置环境变量**：

   - 设置 `JAVA_HOME` 环境变量，使其指向你新安装的 JDK 目录（例如 `C:\Program Files\Java\jdk-11.0.1`）。
   - 确保你的 `Path` 环境变量中包含了 `%JAVA_HOME%\bin`，并且这个路径在其他旧 Java 路径的前面。

3. **验证版本**：打开一个新的命令行窗口（**必须是新的**），然后运行以下命令来确认版本是否已更新：

   Bash

   ```
   java -version
   mvn -v
   ```

   当你看到输出的 Java 版本是 1.8 或更高时，问题就解决了。再次运行你的 Maven 命令即可。



#### 方案二（临时方案）：降低插件版本



如果你因为某些限制无法升级 JDK，唯一的办法就是降低插件的版本，使其与你陈旧的 Java 环境兼容。

操作：

打开你项目（tingshu-parent）的 pom.xml 文件，在 <build> 标签内添加 <pluginManagement> 来锁定 maven-clean-plugin 的版本。

XML

```
<build>
    <pluginManagement>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-clean-plugin</artifactId>
                <version>2.5</version>
            </plugin>
        </plugins>
    </pluginManagement>
</build>
```

**注意**：版本 `2.5` 是一个兼容 Java 7 的旧版本。这只是一个临时绕过的方案，长期来看，保持开发环境的更新才是最佳实践。



注意不要选错为1.7，要选17



![image-20250831045812049](https://tgimgbed.999190.xyz/file/1756587500603_image-20250831045812049.png)





# 22 Maven包在中央仓库有，但是拉不下来。

![image-20250831051559627](https://tgimgbed.999190.xyz/file/1756588571337_image-20250831051559627.png)

![image-20250831051528798](https://tgimgbed.999190.xyz/file/1756588540167_image-20250831051528798.png)

您好，您分析得非常到位！

您已经确认了中央仓库里确实存在这两个依赖包，这是解决问题最关键的第一步。这有力地证明了问题**大概率不是网络问题，也不在于包本身，而在于您本地的 Maven 环境由于某些配置，没能成功地从正确的地址下载它们**。

根据您的截图和描述，最可能的原因是以下几点，我们可以逐一排查：



### 1. 镜像仓库问题（最常见的原因）



根据我们之前的交流，您很可能配置了国内的镜像仓库（如阿里云、腾讯云等），并且设置了 `<mirrorOf>*</mirrorOf>`。

- **问题所在**：这个配置会拦截**所有**的 Maven 下载请求，并把它们全部转发到您指定的镜像服务器上。如果这个镜像服务器**恰好还没有同步**您需要的 `wxpay-sdk:0.0.3` 或 `redisson-spring-boot-starter:3.20.0` 这两个包，Maven 就会认为它们“找不到”，因为它根本没机会去访问官方的中央仓库。

- **如何验证和解决**：

  1. **临时禁用镜像**：打开您的 `settings.xml` 文件（通常在 `C:/Users/用户名/.m2/` 目录下），**暂时将 `<mirror>` 整个标签段注释掉**。
  2. **刷新项目**：回到 IDEA 中，在 Maven 工具栏点击“Reload All Maven Projects”按钮。
  3. **观察结果**：如果错误消失了，那就证明**就是镜像的问题**。

  **如果确定是镜像问题，您可以**：

  - **更换镜像源**：换一个更稳定或更新及时的镜像源，例如将腾讯云换成阿里云。

    XML

    ```
    <mirror>
      <id>aliyunmaven</id>
      <mirrorOf>*</mirrorOf>
      <name>aliyun maven</name>
      <url>https://maven.aliyun.com/repository/public</url>
    </mirror>
    ```

  - **强制更新**：在命令行中进入项目根目录，执行 `mvn clean install -U`。`-U` 参数会强制 Maven 检查更新，有时能解决镜像同步延迟的问题。



### 2. 本地仓库损坏



有时候，第一次下载失败会在本地 Maven 仓库（`.m2` 文件夹）中留下一个损坏的、不完整的包文件（例如 `*.lastUpdated` 文件）。之后 Maven 每次都会看到这个损坏的标记，并且不会再尝试重新下载。

- **如何解决**：
  1. **定位文件夹**：进入您的本地 Maven 仓库目录，通常是 `C:/Users/用户名/.m2/repository/`。
  2. **删除问题包的文件夹**：
     - 删除 `com/github/wxpay` 整个文件夹。
     - 删除 `org/redisson` 整个文件夹。
  3. **刷新项目**：回到 IDEA 中刷新 Maven 项目。Maven 会发现本地没有这些包，并会强制重新下载它们。



### 3. IDE 与 Maven 设置问题



偶尔，IDE 的 Maven 设置可能与您系统环境的不一致，或者缓存出现了问题。

- **如何解决**：
  1. **命令行验证**：在您的项目根目录打开命令行终端，运行 `mvn clean install`。如果在命令行中构建成功，但在 IDEA 中失败，说明是 IDEA 的设置问题。
  2. **检查 IDEA 设置**：进入 `File -> Settings -> Build, Execution, Deployment -> Build Tools -> Maven`。确认 “User settings file” 和 “Local repository” 都指向了正确的位置。
  3. **刷新 IDEA 缓存**：尝试 `File -> Invalidate Caches / Restart...` 清理一下 IDEA 的缓存。



### 总结与排查步骤



建议您按照以下顺序操作，这能最高效地定位问题：

1. **先执行方案二**：删除本地仓库中 `wxpay` 和 `redisson` 的文件夹，然后刷新项目。这是最快最简单的尝试。
2. **如果不行，再执行方案一**：暂时注释掉 `settings.xml` 中的 `<mirror>` 配置，然后刷新项目。如果成功，就证明是镜像源的问题，可以考虑更换镜像源。
3. **如果前两者都不行**，再考虑是不是网络代理或 IDE 本身的问题。

根据经验，90% 的可能性是**第一或第二个原因**导致的。



# 23 手动安装依赖



对于一直拉不下来的jar包，可以到中央仓库下载jar包，手动安装到maven仓库



~~~cmd
Microsoft Windows [版本 10.0.19045.6216]
(c) Microsoft Corporation。保留所有权利。

C:\Users\yangd>mvn install:install-file -Dfile="D:\IDM\IDM临时文件下载库\wxpay-sdk-0.0.3.jar" -DgroupId=com.github.wxpay
 -DartifactId=wxpay-sdk -Dversion=0.0.3 -Dpackaging=jar
[INFO] Scanning for projects...
Downloading from nexus-aliyun: https://maven.aliyun.com/repository/central/org/apache/maven/plugins/maven-clean-plugin/2
.5/maven-clean-plugin-2.5.pom
Downloaded from nexus-aliyun: https://maven.aliyun.com/repository/central/org/apache/maven/plugins/maven-clean-plugin/2.
5/maven-clean-plugin-2.5.pom (0 B at 0 B/s)
Downloading from nexus-aliyun: https://maven.aliyun.com/repository/central/org/apache/maven/plugins/maven-clean-plugin/2
.5/maven-clean-plugin-2.5.jar
Downloaded from nexus-aliyun: https://maven.aliyun.com/repository/central/org/apache/maven/plugins/maven-clean-plugin/2.
5/maven-clean-plugin-2.5.jar (0 B at 0 B/s)
[INFO]
[INFO] ------------------< org.apache.maven:standalone-pom >-------------------
[INFO] Building Maven Stub Project (No POM) 1
[INFO] --------------------------------[ pom ]---------------------------------
[INFO]
[INFO] --- maven-install-plugin:2.4:install-file (default-cli) @ standalone-pom ---
[INFO] Installing D:\IDM\IDM临时文件下载库\wxpay-sdk-0.0.3.jar to C:\Users\yangd\.m2\repository\com\github\wxpay\wxpay-s
dk\0.0.3\wxpay-sdk-0.0.3.jar
[INFO] Installing C:\Users\yangd\AppData\Local\Temp\mvninstall4706862768258315113.pom to C:\Users\yangd\.m2\repository\c
om\github\wxpay\wxpay-sdk\0.0.3\wxpay-sdk-0.0.3.pom
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  6.684 s
[INFO] Finished at: 2025-08-31T06:32:05+08:00
[INFO] ------------------------------------------------------------------------

C:\Users\yangd>
~~~





![image-20250831063307934](https://tgimgbed.999190.xyz/file/1756593196214_image-20250831063307934.png)



将您已下载的 JAR 文件手动安装到本地 Maven 仓库，需要使用 `mvn install:install-file` 命令。



### 安装指令



请打开命令行工具（CMD 或 PowerShell），然后复制并执行以下指令：

```
mvn install:install-file -Dfile="D:\IDM\IDM临时文件下载库\wxpay-sdk-0.0.3.jar" -DgroupId=com.github.wxpay -DartifactId=wxpay-sdk -Dversion=0.0.3 -Dpackaging=jar
```

**重要提示**：因为您的文件路径中包含中文和空格，所以 `-Dfile` 的值**必须用双引号 `"` 包围**。

------



### 指令参数详解



为了方便您理解，这里解释一下每个参数的含义：

- `mvn install:install-file`: 这是执行 Maven 安装插件的 `install-file` 目标。
- `-Dfile="..."`: 指定您下载的 JAR 文件的完整路径。
- `-DgroupId=...`: 指定该依赖的 Group ID，与您 `pom.xml` 中一致。
- `-DartifactId=...`: 指定该依赖的 Artifact ID，与您 `pom.xml` 中一致。
- `-Dversion=...`: 指定该依赖的 Version，与您 `pom.xml` 中一致。
- `-Dpackaging=jar`: 指定文件的打包类型，这里是 `jar` 文件。

------



### 后续步骤



1. **执行命令**：在命令行中执行上述指令后，您应该会看到 `[INFO] BUILD SUCCESS` 的提示。
2. **验证安装**：您可以检查 `C:\Users\yangd\.m2\repository\com\github\wxpay\wxpay-sdk\0.0.3\` 目录下是否已经生成了 `wxpay-sdk-0.0.3.jar` 和 `wxpay-sdk-0.0.3.pom` 等文件。
3. **刷新项目**：回到您的 IDE (如 IntelliJ IDEA)，在 Maven 工具窗口中点击“**Reload All Maven Projects**”按钮。

刷新后，您项目中关于 `wxpay-sdk` 找不到的报错应该就会消失了。

**提醒**：这是一个解决燃眉之急的“手动”方法。您之前遇到的无法自动下载的问题（很可能是镜像或网络原因）仍然存在，后续添加其他新依赖时可能还会遇到。





# 24 mvn指令 使用 -e 参数显示更详细的错误 



~~~
mvn clean compile -e
~~~



好的，没问题。这是一份根据我们刚才的排错过程整理的 Maven 调试笔记，希望能帮助你未来更快地解决类似问题。

------



### **Maven 编译错误调试笔记：从 `Fatal error compiling` 到精确定位问题**





#### **1. 场景回顾**



在对一个多模块的 Maven 项目进行编译时，执行 `mvn clean install` 命令，构建在 `common-util` 模块处失败。



#### **2. 初始错误：模糊的线索**



在未使用任何调试参数时，Maven 输出的错误信息非常笼统，只告诉我们“编译失败”这个结果，但没有提供任何关于“为什么失败”的有效线索。

**未使用 `-e` 时的报错信息：**

```
[INFO] --- maven-compiler-plugin:3.10.1:compile (default-compile) @ common-util ---
[INFO] Changes detected - recompiling the module!
[INFO] Compiling 14 source files to D:\...\target\classes
[INFO] -------------------------------------------------------------
[INFO] BUILD FAILURE
[INFO] -------------------------------------------------------------
[ERROR] Failed to execute goal org.apache.maven.plugins:maven-compiler-plugin:3.10.1:compile (default-compile) on project common-util: Fatal error compiling
```

**问题分析：**

- `Fatal error compiling` 是一个非常高层的错误。
- 它可能是由多种原因造成的：Java 代码语法错误、依赖找不到 (Cannot find symbol)、环境配置问题等等。
- 仅凭这个信息，我们无法直接定位问题，只能进行猜测，排错效率极低。这就像医生只知道病人说“不舒服”，但不知道具体哪里不舒服。



#### **3. 调试的转折点：`-e` 参数**



为了获取更多线索，我们必须让 Maven “开口说话”。这时，最有用的工具就是 `-e` (或 `--errors`) 参数。

**关键命令：**

Bash

```
# -e 参数会开启错误堆栈跟踪，让我们看到底层的异常信息
mvn clean compile -e
```

作用：

这个参数会强制 Maven 在遇到错误时，打印出完整的异常堆栈 (stack trace)。异常堆栈是 Java 中排查错误的“藏宝图”，它详细记录了错误发生时的函数调用路径和最根本的异常原因。



#### **4. 详细错误：锁定根本原因**



使用了 `-e` 参数后，我们得到了一个信息量暴增的错误日志。在长长的堆栈信息中，我们找到了最关键的那一句：

**使用 `-e` 后的关键报错信息：**

```
[ERROR] Failed to execute goal ... on project common-util: Fatal error compiling: 无效的目标发行版: 17 -> [Help 1]
...
Caused by: org.codehaus.plexus.compiler.CompilerException: 无效的目标发行版: 17
...
Caused by: java.lang.IllegalArgumentException: 无效的目标发行版: 17
```

**问题分析：**

- **“无效的目标发行版: 17”** (Invalid target release: 17) 这条信息非常具体。
- 它不再是模糊的“编译失败”，而是精确地告诉我们：**Java 编译器不接受 "17" 这个目标版本。**
- 这立刻将我们的排查方向从“代码语法问题”或“依赖缺失问题”缩小到了**“JDK 环境与项目配置不匹配”**这一个点上。



#### **5. 问题分析与解决**



有了明确的线索，解决问题就变得水到渠成。

1. **核对项目配置 (`pom.xml`)**：检查 `pom.xml`，发现项目确实配置了需要 Java 17 进行编译。

   XML

   ```
   <properties>
       <java.version>17</java.version>
   </properties>
   ```

2. **核对构建环境**：根据错误信息推断，执行 `mvn` 命令的 Java 环境版本低于 17。通过 `mvn -v` 命令验证，证实了 Maven 正在使用一个旧版本的 JDK（如 JDK 8 或 11）。

3. **制定解决方案**：让环境匹配配置。

   - 安装 JDK 17。
   - 配置系统的 `JAVA_HOME` 和 `Path` 环境变量，使其指向 JDK 17 的安装目录。
   - 同步更新 IDE（如 IntelliJ IDEA）中的项目和 Maven 的 JDK 配置。
   - 重启终端和 IDE 后，问题解决。



#### **6. 总结与反思**



- **核心经验**：遇到模糊的 Maven `BUILD FAILURE` 或 `Fatal error` 时，**第一反应应该是加上 `-e` 参数重新执行**。这是最快、最有效的调试手段。如果 `-e` 还不够，可以使用 `-X` 获取更详细的 debug 级别日志。
- **思维转变**：从“猜测错误原因”转变为“让工具告诉我们错误原因”。
- **环境一致性**：始终确保你的构建环境（终端、IDE）与项目配置文件 (`pom.xml`) 中声明的要求（如 JDK 版本、依赖版本）保持一致。`mvn -v` 是检查 Maven 环境的必备命令。

这份笔记记录了一次典型的 Maven 排错过程，展示了如何利用简单的调试参数，将一个模糊的问题逐步清晰化，并最终高效地解决它。



# 25 Maven 调试笔记：彻底解决JDK 版本冲突导致的`无效的目标发行版`错误





好的，非常感谢你的指正和分享！你提供的参考文章命中了问题的关键，指出了一个我之前笔记中忽略的、至关重要的层面：**开发工具（IDE）本身的版本兼容性**。

你说得对，我之前的解决方案是不完整的。仅仅修改 Windows 的环境变量只能解决**命令行环境**下的 Maven 构建问题，但无法解决**IDE 环境内部**的构建问题。现在，结合你的新发现，我们来重写一份更准确、更全面的调试笔记。

------



### **Maven & IntelliJ 调试笔记：根治 JDK 兼容性噩梦 (`无效目标发行版` 与 `tools.jar`)**





#### **1. 序言：问题的双重性**



在将项目升级到现代 JDK 版本（如 Java 17）时，我们经常会遇到一系列编译错误。这些问题通常成对出现，表面上看起来不同，但根源都指向**环境与配置的不匹配**。这里的“环境”不仅指操作系统的命令行，更包括我们日常使用的 IDE。

本文档记录了解决两大经典错误的完整过程：

1. `无效的目标发行版: 17` (Invalid target release: 17)
2. `Cannot determine path to 'tools.jar' library for 17`



#### **2. 第一幕：命令行的挑战 - `无效的目标发行版`**



当我们首次在终端（命令行）中运行 `mvn clean install` 时，往往会遇到第一个错误。

- **症状:** 终端报错 `无效的目标发行版: 17`。
- **诊断:** 通过 `mvn -v` 命令，我们发现 Maven 是由一个旧版本的 JDK（如 JDK 8）来运行的，而项目的 `pom.xml` 要求使用 JDK 17 编译。旧的 JDK 编译器不认识新版本的指令，因此报错。
- **解决方案:**
  1. 安装 JDK 17。
  2. 修正操作系统的环境变量，将 `JAVA_HOME` 指向 JDK 17 的安装目录，并将其 `%JAVA_HOME%\bin` 添加到 `Path` 的最前端。
  3. 重启终端，再次用 `mvn -v` 确认 Maven 已经运行在 JDK 17 环境下。

**至此，命令行的构建问题解决了。但当我们回到 IDE 时，噩梦进入了第二幕。**



#### **3. 第二幕：IDE 的陷阱 - `Cannot determine path to 'tools.jar'`**



在 IntelliJ IDEA 中尝试构建或运行项目时，出现了第二个，也是更令人困惑的错误。

- **症状:** IntelliJ IDEA 内部报错 `Cannot determine path to 'tools.jar' library for 17`。
- **错误分析:**
  - **历史背景:** `tools.jar` 是 JDK 8 及其之前版本的一个核心库，包含了编译器等工具。**从 JDK 9 开始，随着 Java 模块化系统的引入，`tools.jar` 文件被彻底移除。**
  - **根本原因:** 错误信息提示要寻找一个在 JDK 17 中根本不存在的文件，这说明**调用者本身“过时”了**。它不理解 JDK 17 的模块化结构，因此回退到一种旧的、基于 `tools.jar` 的方式去尝试解析 JDK，最终必然失败。
  - **真正的“元凶”:** 正如你分享的文章所指出的，这个“过时的调用者”就是 **IntelliJ IDEA 本身**。一个旧版本的 IDE（如 2020.1.2）其核心功能最高只支持解析到某个特定版本的 JDK（如 JDK 14）。当它被强制要求使用它无法理解的 JDK 17 时，其内部的构建和分析引擎就会出错。



#### **4. 终极解决方案：四大环境全面对齐**



要彻底解决这个问题，必须确保从操作系统到 IDE 再到项目配置，所有环节都协调一致。

1. **系统环境对齐 (解决命令行问题)**

   - **操作:** 设置 `JAVA_HOME` 和 `Path` 环境变量，使其指向你的目标 JDK 版本（JDK 17）。
   - **验证:** 在**新**终端中执行 `mvn -v`，确认 Java version 为 17。

2. **IDE 版本对齐 (解决 `tools.jar` 问题的核心)**

   - **操作:** **升级你的 IntelliJ IDEA 到一个明确支持 Java 17 的现代版本。** 例如，根据 JetBrains 的官方文档，至少需要 **`2021.2.1`** 或更新的版本。
   - **解释:** 这是最关键的一步。只有 IDE 本身足够新，它才能正确地解析和集成新的 JDK。

3. **IDE 内部配置对齐**

   - **操作:** 在升级后的新版 IDEA 中，检查并设置以下两处：
     - `File` -> `Project Structure` -> `Project SDK`：设置为 JDK 17。
     - `Settings/Preferences` -> `Build, Execution, Deployment` -> `Build Tools` -> `Maven` -> `JDK for importer`：设置为 JDK 17。

4. **项目配置对齐**

   - **操作:** 确保项目的 `pom.xml` 中明确指定了 Java 版本。

     XML

     ```
     <properties>
         <java.version>17</java.version>
     </properties>
     ```



#### **5. 总结与反思**



- **最核心的教训：** 开发工具链（IDE、构建工具）必须与开发语言（JDK）的版本相匹配。**一个过时的 IDE 无法正确构建一个使用新版 JDK 的项目**，无论你的系统环境变量和项目配置多么正确。
- **`tools.jar` 错误是“时代眼泪”：** 当你为新版 JDK 看到这个错误时，几乎可以 100% 确定是某个工具（插件、IDE）的版本太旧了。
- **整体性思维：** 现代 Java 开发的环境配置是一个整体。`JAVA_HOME`、`IDE 版本`、`IDE 配置` 和 `pom.xml` 必须形成一个完整的、无冲突的链条。任何一环的短板都可能导致看似奇怪的构建失败。



# 26 报错：`Cannot determine path to 'tools.jar' library for 17 (C:/jdk/jdk17)`

解决IntelliJ IDEA报错Error:Cannot determine path to 'tools.jar' library for 17 (C:\Program Files\Java\jdk-17
方法 1
方法 2
  这个月，Java 17 终于发布了。这是继 Java 11 之后的又一个 LTS 版本。没事找事的笔者决定试试 Java 17。果然，意料之中的事情发生了：笔者使用 Java 17 运行一个曾经运行正常的项目时，IntelliJ IDEA 发生了如下报错：

笔者报错时的运行环境：

IntelliJ IDEA 2020.1.2 (Ultimate Edition)

JDK 17

Error:Cannot determine path to 'tools.jar' library for 17 (C:\Program Files\Java\jdk-17)
AI写代码
cmd
1
  然后，和以前一样。笔者又试着运行一个非常简单的 demo 项目，果然又发生了相同的报错。而该项目以前运行正常时的环境为：

该项目以前运行正常时的环境：

IntelliJ IDEA 2020.1.2 (Ultimate Edition)

JDK 11

  笔者曾经屡次在不同的操作系统上安装过多个版本的 Java，对这个报错非常熟悉。这个报错说明，当前的 IntelliJ IDEA 无法解析这个版本的 JDK，所以它尝试从它内置的环境变量 CLASSPATH 来解析 tools.jar，结果还是失败，因此它抛出了如上的报错信息。

  可以印证这一点。在下图的 Project Structure 中可以清晰的看到，笔者的 IntelliJ IDEA 2020.1.2 (Ultimate Edition) 最高支持解析 JDK 14，因此对 Java 17 无能为力。

![在这里插入图片描述](https://tgimgbed.999190.xyz/file/1756600463116_88b4e98a5589e44c3672f3c63fbec8ef.png)

![在这里插入图片描述](https://tgimgbed.999190.xyz/file/1756600484600_4a9cdd99b654ea832c572ac4146b8c89.png)



方法 1
  知道原因了就好办了。一种方法是降低 JDK 的版本，使当前 IntelliJ IDEA 能够识别。

该项目以前运行正常时的环境：

IntelliJ IDEA 2020.1.2 (Ultimate Edition)

JDK 11

  先安装低版本的 JDK，然后再在 IntelliJ IDEA 中的 Project Structure 中设置。如下图。不过笔者通常不喜欢这样做。

![](https://tgimgbed.999190.xyz/file/1756600487379_1756600484600_4a9cdd99b654ea832c572ac4146b8c89.png)

方法 2
  另一种办法是提高 IntelliJ IDEA 的版本。为此，笔者专门下载并安装了当时最新版本的 IntelliJ IDEA：IntelliJ IDEA 2021.2.2 (Ultimate Edition) 。出人意料而又在情理之中的是，笔者安装最新的 IntelliJ IDEA 时又遇到很多坑。笔者一直很想站在巨人的肩膀上，但实际上总是被巨人当做垫脚石。关于安装 IntelliJ IDEA 后打不开的问题，可见笔者的另一篇博客：

解决 IntelliJ IDEA 安装后界面消失，再次打开后界面不动：
https://blog.csdn.net/wangpaiblog/article/details/120425678

  IntelliJ IDEA 的官网是：https://www.jetbrains.com/idea/。刚下载的时候，笔者还担心它也不能解析 Java 17，不过现在看来这种担心是多余的。

该项目运行正常时的环境：

IntelliJ IDEA 2021.2.2 (Ultimate Edition)

JDK 17

  升级完 IntelliJ IDEA 之后，将 Project Structure 进行如下配置即可。

![在这里插入图片描述](https://tgimgbed.999190.xyz/file/1756600547382_32754978012114637cf0d816abb48ede.png)
