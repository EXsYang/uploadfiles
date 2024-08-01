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

