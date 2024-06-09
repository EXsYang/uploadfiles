 

本文档只是介绍了一部分JavaSE阶段IDEA开发工具的使用说明。

# 第18章 IDEA开发工具

IDEA 全称IntelliJ IDEA，是Java语言开发的集成环境，目前已经基本代替了Eclipse的使用。IntelliJ在业界被公认为最好的Java开发工具之一，因其功能强悍、设置人性化，而深受Java、大数据、移动端程序员的喜爱。本着"工欲善其事必先利其器"的精神，本章从IDEA的介绍、安装、设置入手，讲解IDEA中项目的创建、模板的使用、断点调试等。

说明：本文档所有截图针对IntelliJ IDEA 2022.3  Windows版本。

## 18.1 IntelliJ IDEA  介绍

### 18.1.1 JetBrains  公司介绍

IDEA，是 JetBrains ([https://www.jetbrains.com/)公司的产品，该公司成立于2000年，总部位于捷克的布拉格，致力于为开发者打造最高效智能的开发工具。](https://www.jetbrains.com/)公司的产品，该公司成立于2000年，总部位于捷克的布拉格，致力于为开发者打造最高效智能的开发工具。

公司旗下还有其它产品，比如：

* WebStorm：用于开发 JavaScript、HTML5、CSS3 等前端技术；
* PyCharm：用于开发 python
* PhpStorm：用于开发 PHP
* RubyMine：用于开发 Ruby/Rails
* AppCode：用于开发 Objective - C/Swift
* CLion：用于开发 C/C++
* DataGrip：用于开发数据库和 SQL
* Rider：用于开发.NET
* GoLand：用于开发 Go
* Datalore： 用于构建机器学习模型并在Python中创建丰富的可视化。 

而且用于开发 android的Android Studio，也是Google 基于 IDEA 社区版进行迭代的。

![1685281404895](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685281404895.png)

### 18.1.2 IntelliJ IDEA  介绍

IDEA，全称 IntelliJ IDEA，是 Java 语言的集成开发环境，IDEA 在业界被公认为是最好的 Java 开发工具之一，尤其在智能代码助手、代码自动提示、重构、J2EE支持、Ant、JUnit、CVS 整合、代码审查、创新的 GUI 设计等方面的功能可以说是超常的。

IntelliJ IDEA 在 2015 年的官网上这样介绍自己：

Excel at enterprise, mobile and web development with Java, Scala and Groovy,with all the latest modern technologies and frameworks available out of thebox.

简明翻译：IntelliJ IDEA 主要用于支持 Java、Scala、Groovy 等语言的开发工具，同时具备支持目前主流的技术和框架，擅长于企业应用、移动应用和 Web 应用的开发。

现在IntelliJ IDEA这样介绍自己的主要特征：

Every aspect of IntelliJ IDEA is specifically designed to maximize developer productivity.

Together, the powerful static code analysis and ergonomic design make development not only productive but also an enjoyable experience.

简明翻译：

IntelliJ IDEA 是为在各个方面最大化提高开发者生产力的而设计的。同时强大的静态代码分析和人机工程学设计使开发不仅高效，而且令人愉快。

它内置的工具和支持的框架有：

![1685281425626](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685281425626.png)

### 18.1.3 IDEA  的下载

下载网址： https://www.jetbrains.com/idea/download/#section=windows 

IDEA 分为两个版本： 旗舰版(Ultimate)和 社区版(Community)。

IDEA的大版本每年迭代一次，大版本下的小版本（如：2022.x）迭代时间不固定，一般每年3个小版本。

![1670222775066](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1670222775066.png)

两个不同版本的详细对比，可以参照官网：
https://www.jetbrains.com/idea/features/editions_comparison_matrix.html

官网提供的详细使用文档：
https://www.jetbrains.com/help/idea/meet-intellij-idea.html



## 18.2 安装与卸载

### 18.2.1 安装前的准备

* 64位版本的windows10,8,7；
* 最少2G内存，建议8G内存以上；
* 安装需要2.5G硬盘，建议固态硬盘；
* 分辨率1024*768以上；

从安装上来看，IntelliJ IDEA 对硬件的要求似乎不是很高。可是实际在开发中其实并不是这样的，因为 IntelliJ IDEA 执行时会有大量的缓存、索引文件，所以如果你正在使用 Eclipse / MyEclipse，想通过 IntelliJ IDEA 来解决计算机的卡、慢等问题，这基本上是不可能的，本质上你应该对自己的硬件设备进行升级。

### 18.2.2 安装过程

1、双击!![1675567212076](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1675567212076.png)

2、欢迎安装

![1670222936119](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1670222936119.png)

3、是否删除电脑上低版本的IDEA

![1685281449859](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685281449859.png)

4、选择安装目录

![1675567507422](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1675567507422.png)

5、确认操作系统类型/是否创建桌面快捷方式

确认是否与.java、.groovy、.kt 格式文件进行关联，这里也可以选择不关联。

![1675567550718](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1675567550718.png)

6、在【开始】菜单新建一个文件夹，来管理IDEA的相关内容

![1685281468771](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685281468771.png)

![1685281486127](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685281486127.png)

7、完成安装

![1685281496232](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685281496232.png)

### 18.2.3 卸载过程

在【控制面板】找到【卸载程序】

![1685281510557](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685281510557.png)

双击IntelliJ IDEA 2019.2.3进行卸载：

![1685281545618](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685281545618.png)

![1685281566007](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685281566007.png)

![1685281575093](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685281575093.png)

![1685281585514](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685281585514.png)

#### 如何打开控制面板？

win10操作系统 在【搜索框】中输入【控制面板】就可以打开控制面板：

![1685281601324](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685281601324.png)

如果没有【搜索】图标的，可以这样显示出来：右键任务栏，在弹窗的菜单中选择【搜索】->显示搜索图标。

![1685281614142](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685281614142.png)

## 18.3 初始化配置与激活(社区版不需要激活)

## 18.4 新建工程和模块

在 IntelliJ IDEA 中，没有类似于 Eclipse 工作空间（Workspace）的概念，而是提出了Project和Module这两个概念。接下来，就让我们一起看看 IntelliJ IDEA 官方是如何描述两者的吧！对于 Project，IntelliJ IDEA 官方是这样介绍的：

A project is a top-level organizational unit for your development work in IntelliJ IDEA. In its finished form, a project may represent a complete software solution. A project is a collection of:

Your work results: source code, build scripts, configuration files, documentation, artifacts, etc.
SDKs and libraries that you use to develop, compile, run and test your code.
Project settings that represent your working preferences in the context of a project.
A project has one or more modules as its parts.

对于 Module，IntelliJ IDEA 官方是这样介绍的：

A module is a part of a project that you can compile, run, test and debug independently.
Modules are a way to reduce complexity of large projects while maintaining a common (project) configuration.
Modules are reusable: if necessary, a module can be included in more than one project.

通过上面的介绍，我们知道：**在 IntelliJ IDEA 中Project是最顶级的结构单元，然后就是Module**，一个Project可以有多个Module。目前，主流的大型项目结构基本都是多Module的结构，这类项目一般是按功能划分的，比如：user-core-module、user-facade-module和user-hessian-module等等，模块之间彼此可以相互依赖。通过这些Module的命名可以看出，它们都是处于同一个项目中的模块，彼此之间是有着不可分割的业务关系。因此，我们可以大致总结出：一个Project是由一个或多个Module组成，

* 当为单Module项目的时候，这个单独的Module实际上就是一个Project；
* 当为多Module项目的时候，多个模块处于同一个Project之中，此时彼此之间具有互相依赖的关联关系。
* 当然多个模块没有建立依赖关系的话，也可以作为单独一个“小项目”运行

此外， **IntelliJ IDEA 的Project**是一个不具备任何编码设置、构建等开发功能的概念，其主要作用就是起到一个**项目定义、范围约束、规范类型**的效果，或许，我们也可以简单地理解Project就是一个单纯的目录，只是这个目录在命名上必须有其代表性的意义。在缺省情况下，IntelliJ IDEA 是默认单Project单Module的，这时Project和Module合二为一，在没有修改存储路径的时候，显然Project对Module具有强约束作用！不过说实话，这里就是将Module的内容放在了Project的目录下，实际上还是Module自己约束自己。

### 18.4.1 创建空工程

建议初学者先建Empty空工程，然后在空工程中建立不同的Java模块进行JavaSE的学习。

![1670225712403](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1670225712403.png)

!![1675577402185](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1675577402185.png)

### 18.4.2 创建Java模块

![1670225801808](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1670225801808.png)

![1670225811999](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1670225811999.png)

![1670225831075](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1670225831075.png)

![1685281711719](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685281711719.png)

##### 运行Java类

![1670225861676](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1670225861676.png)

### 18.4.3 关闭提示

![1685281724754](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685281724754.png)

### 18.4.4 HelloWorld

#### 1、新建Java类

![1685281733153](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685281733153.png)

![1685281744771](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685281744771.png)



#### 2、编写代码

```java
public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("hello");
    }
}
```

#### 3、运行

![1685281765339](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685281765339.png)

![1685281775151](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685281775151.png)

## 18.5 详细设置

### 18.5.1 配置目录介绍

启动后会在C盘的用户目录下生成如下两个目录，例如：C:\Users\Irene\\.IntelliJIdea2019.2

![1685281787776](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685281787776.png)

这是 IDEA 的各种配置的保存目录。这个设置目录有一个特性，就是你删除掉整个目录之后，重新启动 IntelliJ IDEA 会再自动帮你生成一个全新的默认配置，所以很多时候如果你把 IntelliJ IDEA 配置改坏了，没关系，删掉该目录，一切都会还原到默认。

* config 目录是 IntelliJ IDEA 个性化化配置目录，或者说是整个 IDE 设置目录。此目录可看成是最重要的目录，没有之一，如果你还记得安装篇的介绍的时候，安装新版本的 IntelliJ IDEA 会自动扫描硬盘上的旧配置目录，指的就是该目录。这个目录主要记录了：IDE 主要配置功能、自定义的代码模板、自定义的文件模板、自定义的快捷键、Project 的 tasks 记录等等个性化的设置。
* system 目录是 IntelliJ IDEA 系统文件目录，是 IntelliJ IDEA 与开发项目一个桥梁目录，里面主要有：缓存、索引、容器文件输出等等，虽然不是最重要目录，但也是最不可或缺的目录之一。

### 18.5.2 idea64.exe.vmoptions文件

IDEA本身也Java语言开发的，在IDEA安装目录的bin目录（例如：D:\ProgramFiles\JetBrains\IntelliJ_IDEA_2019.2.3\bin）下有一个idea64.exe.vmoptions文件（大家根据电脑系统的位数，选择 32 位的 VM 配置文件或者 64 位的 VM 配置文件）。它是IDEA运行的JVM参数配置文件，可以用文本编辑器打开：

![1685281801096](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685281801096.png)

注意：

如果在C盘的用户目录的config下（例如：C:\Users\Irene\\.IntelliJIdea2019.2\config）也有一个idea64.exe.vmoptions文件，那么将优先使用C盘用户目录下的。

![1685281810774](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685281810774.png)

Help菜单-->Edit Custom VM Options，优先选择的就是C盘用户目录下的idea64.exe.vmoptions文件。

![1685281821216](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685281821216.png)

第一次选择它时，会弹出这个对话框：表示C盘的用户目录下，IDEA的设置目录中没有这个配置文件，是否创建一个。

![1685281829623](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685281829623.png)

### 18.5.3 运行内存大小配置

* 64 位操作系统中 8G 内存以下的机子或是静态页面开发者是无需修改的。
* 64 位操作系统且内存大于 8G 的，如果你是开发大型项目、Java 项目或是 Android 项目，建议进行修改，常修改的就是下面 3 个参数：

![1685281861234](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685281861234.png)

```properties
-Xms128m
  如果16 G 内存的机器可尝试设置为 -Xms512m(设置初始的内存数，增加该值可以提高 Java 程序的启动速度。)
-Xmx750m
   如果16 G 内存的机器可尝试设置为 -Xmx1500m(设置最大内存数，提高该值，可以减少内存 Garage 收集的频率，提高程序性能)
-XX:ReservedCodeCacheSize=240m
	如果16G 内存的机器可尝试设置为-XX:ReservedCodeCacheSize=500m(保留代码占用的内存容量)
```

### 18.5.4 如何打开详细配置界面

#### 1、显示工具栏

#### ![1685281843897](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685281843897.png)

![1685281904220](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685281904220.png)

![1685281912474](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685281912474.png)

### 18.5.5 系统设置

#### 1、默认启动项目配置

![1685281920456](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685281920456.png)

如果去掉Reopen last project on startup前面的对勾，每次启动IDEA就会出现如下界面：

![1685281930090](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685281930090.png)

#### 2、取消自动更新

Settings-->Appearance & Behavior->System Settings -> Updates

![1685281938798](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685281938798.png)

### 18.5.6 设置整体主题

#### 1、选择主题

![1685281947189](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685281947189.png)

#### 2、设置菜单和窗口字体和大小

![1576224151081](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1576224151081.png)

### 18.5.7 设置编辑器主题样式

#### 1、编辑器主题

![1685281955886](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685281955886.png)

#### 2、字体大小与颜色

![1685281966624](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685281966624.png)

更详细的字体与颜色如下：

![1685281976278](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685281976278.png)

==温馨提示==：如果选择某个font字体，中文乱码，可以在fallback font（备选字体）中选择一个支持中文的字体。

#### 3、显示行号与方法分隔符

![1685281985180](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685281985180.png)

### 18.5.8 代码智能提示功能

![1685282000910](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685282000910.png)

IntelliJ IDEA 的代码提示和补充功能有一个特性：区分大小写。区分大小写的情况是这样的：比如我们在 Java 代码文件中输入 system，IntelliJ IDEA 默认是不会帮我们提示或是代码补充的，但是如果我们输入System 就可以进行代码提示和补充。 如果想不区分大小写的话，就把这个对勾去掉。

### 18.5.9 自动导包配置

* 默认需要自己手动导包，Alt+Enter快捷键

!![1685282011732](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685282011732.png)

* 自动导包设置
  * 动态导入明确的包：Add unambiguous imports on the fly，该设置具有全局性；
  * 优化动态导入的包：Optimize imports on the fly，该设置只对当前项目有效；

![1685282023927](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685282023927.png)



### 18.5.10 设置项目文件编码

Settings-->Editor-->File Encodings

![1685282041402](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685282041402.png)

说明： Transparent native-to-ascii conversion主要用于转换ascii，一般都要勾选。



## 18.6 编译问题

### 18.6.1 设置自动编译

Settings-->Build,Execution,Deployment-->Compiler

![1685282051272](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685282051272.png)

### 18.6.2 项目的JDK设置

方式一：File-->Project Structure...-->Platform Settings -->SDKs

方式二：工具栏-->Project Structure![1685282065639](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685282065639.png))-->Platform Settings -->SDKs

![1685282078839](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685282078839.png)

注：SDKs全称是Software Development Kit ，这里一定是选择JDK的安装根目录，而不是JRE的目录。

### 18.6.3 out目录和编译版本

方式一：File-->Project Structure...-->Project Settings -->Project

方式二：工具栏-->Project Structure![1576466440465](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1576466440465.png)-->Project Settings -->Project

![1685282091741](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685282091741.png)

## 18.7 快捷键和代码模板

### 18.7.1 取消双击shift搜索

![1685282103284](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685282103284.png)

因为我们按shift切换中英文输入方式，经常被按到，总是弹出搜索框，太麻烦了。可以取消它。

双击shift 或 ctrl + shift + a，打开如下搜索窗口：

![1685282378751](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685282378751.png)

选择registry...，找到"ide.suppress.double.click.handler"，把复选框打上勾就可以取消双击shift出现搜索框了。

![1685282390388](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685282390388.png)

### 18.7.2 常用快捷代码模板（第一部分）

* 主方法
  * psvm：public static void main(String[] args){}
  * main：public static void main(String[] args){}
* 输出语句
  * sout：System.out.println();
  * soutp：System.out.println("xxx :" + 方法形参);
  * soutm：System.out.println("xx类.当前方法名");
  * soutv：System.out.println("变量名 = " + 变量);
  * 变量.sout：System.out.println("变量名 = " + 变量);

### 18.7.3 软件通用的快捷键

* 保存：Ctrl + S
* 全选：Ctlr + A
* 复制：Ctrl + C
* 粘贴：Ctrl + V
* 剪切：Ctrl + X
* 撤销：Ctrl + Z

### 18.7.4 IDEA常用快捷键（第一部分）

* 选中行用单行注释注释掉：Ctrl + /
  * 选中单行注释行，再按一次Ctrl + /就可以取消单行注释
* 选中行用多行注释注释掉：Ctrl + Shift + /，
  * 选中整个多行注释部分再按一次Ctrl + Shift + /，就可以取消多行注释

- 复制行：Ctrl + D
- 删除行：Ctrl + Y
- 剪切行：Ctrl + X
- 重命名类、变量、方法等：选择要重名的元素，按Shift + F6
- 格式化代码：Ctrl + Alt + L
- 转大小写：Ctrl +Shift + U
- 自动声明变量接收方法调用表达式结果：Ctrl + Alt + V
- 插入空行开始编辑
  * 在当前光标下一行插入空行开始编辑：Shift + 回车
  * 在当前光标上一行插入空行开始编辑：Ctrl+Alt+回车
- 移动代码
  * 向上移动代码：Ctrl+Shift + ↑  （整个方法移动）或  Alt + Shift + ↑（逐行移动）
  * 向下移动代码：Ctrl+Shift + ↓ （整个方法移动） 或  Alt + Shift + ↓（逐行移动）

- 智能提示：Alt + 回车

- 折叠与展开
  - 折叠方法实现：Ctrl + Shift +  -
  - 展开方法实现：Ctrl +Shift + +



### 18.7.5 查看和自定义快捷键

#### 1.已知快捷键操作名，未知快捷键

![1685282415674](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685282415674.png)

#### 2.已知快捷键，不知道对应的操作名

![1685282427559](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685282427559.png)

#### 3.自定义自己的快捷键

![1685282436486](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685282436486.png)

#### 4.其他主题快捷键

苹果电脑或者是用惯eclipse快捷的，可以选择其他快捷键插件。

![1685282448807](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685282448807.png)

### 18.7.6 查看和定义代码模板

#### 1.预定义Postfix Completion模板，不能修改

![1685282459989](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685282459989.png)

#### 2.预定义Live Templates模板，可以修改

![1685282503610](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685282503610.png)

#### 3.自定义代码模板

例如：定义sop代表System.out.print();语句

①在Live Templates中增加模板

![1685282494528](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685282494528.png)

②先定义一个模板的组，这样方便管理所有自定义的代码模板

![1685282517944](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685282517944.png)

③在模板组里新建模板

![1685282526040](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685282526040.png)

④定义模板

![1685282538252](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685282538252.png)

- Abbreviation：模板的缩略名称
- Description：模板的描述
- Template text：模板的代码片段
- 模板应用范围。比如点击Define。选择如下：应用在java代码中。

![1685282548450](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1685282548450.png)





## 18.8 多模块管理

### 18.8.1 创建多模块

JavaSE阶段建议创建“Empty空工程”，然后创建多模块，每一个模块可以独立运行，相当于一个小项目。JavaSE阶段不涉及到模块之间的依赖。后期再学习模块之间的依赖。

步骤：

（1）选择创建模块

![image-20211228171812137](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20211228171812137.png)

（2）选择模块类型：这里选择创建Java模块

![1576481295518](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1576481295518.png)

（3）给模块命名

![image-20211228171942402](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20211228171942402.png)

（4）多个模块并列存在

![image-20211228172024421](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20211228172024421.png)

### 18.8.2 删除模块

（1）移除模块

![image-20211228172218397](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20211228172218397.png)

![image-20211228172234148](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20211228172234148.png)

（2）彻底删除模块

![image-20211228172320363](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20211228172320363.png)

![image-20211228172352115](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20211228172352115.png)

### 18.8.3 导入老师的模块

（1）将老师的模块整个的复制到自己idea项目的路径下

![image-20211229105551614](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20211229105551614.png)

（2）选择新建Java模块

![image-20211229111146657](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20211229111146657.png)

![image-20211229111205787](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20211229111205787.png)

（3）选择老师的模块

![image-20211229111318026](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20211229111318026.png)

![image-20211229111240565](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20211229111240565.png)

![image-20211229111342261](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20211229111342261.png)

![image-20211229111423696](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20211229111423696.png)

### 18.8.4 同时打开两个IDEA项目工程

#### 1.两个IDEA项目工程效果

有些同学想要把上课练习代码和作业代码分开两个IDEA项目工程。

![image-20211229111753237](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20211229111753237.png)

![image-20211229111906342](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20211229111906342.png)

#### 2.新建两个IDEA项目

注意：第一次需要新建，之后直接打开项目工程即可

![image-20211229112032153](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20211229112032153.png)

![image-20211229112102759](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20211229112102759.png)

![image-20211229112132017](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20211229112132017.png)

![image-20211229112228386](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20211229112228386.png)

#### 3.打开两个IDEA项目

![image-20211229112314671](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20211229112314671.png)

![image-20211229112343470](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20211229112343470.png)

![image-20211229112543076](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20211229112543076.png)

### 18.8.5 导入前几天非idea工程代码

1.先将前2天的代码文件放到idea工程代码目录下，并用第18.8.3节的方式创建两个模块。

![image-20211229112915025](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20211229112915025.png)

![image-20211229113153484](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20211229113153484.png)

2.把.java文件移动到src中

![image-20211229113238503](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20211229113238503.png)

3.设置编码

当前项目是UTF-8。如果原来的.java文件都是GBK的（如果原来.java文件有的GBK有的UTF-8就比较麻烦了）。

可以单独把这两个模块设置为GBK编码的。

![image-20211229113352739](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20211229113352739.png)

![image-20211229113319846](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20211229113319846.png)

![image-20211229113412777](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20211229113412777.png)

## 18.9 Debug调试

### 18.9.1 启动Debug

在所有调试中，调试一个Java程序是最简单的，主要有设置断点、启动调试、单步执行、结束调试几步。

1）设置断点：在源代码文件中，在想要设置断点的代码行的前面的标记行处，单击鼠标左键就可以设置断点，在相同位置再次单击即可取消断点。

![1576476225262](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1576476225262.png)

2）启动调试：IDEA提供多种方式来启动程序(Launch)的调试，分别是通过菜单(Run –> Debug)、图标(“绿色臭虫”![1576476267687](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1576476267687.png)等等

![1576476841154](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1576476841154.png)

### 18.9.2 单步调试工具介绍

![1576477907469](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1576477907469.png)

或

![1576477927994](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1576477927994.png)

![1576476917169](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1576476917169.png)：Step Over（F8）：进入下一步，如果当前行断点是调用一个方法，则不进入当前方法体内

![1576476984903](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1576476984903.png)：Step Into（F7）：进入下一步，如果当前行断点是调用一个自定义方法，则进入该方法体内

![1576477028289](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1576477028289.png)：Force Step Into（Alt +Shift  + F7）：进入下一步，如果当前行断点是调用一个核心类库方法，则进入该方法体内

![1576477117156](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1576477117156.png)：Step Out（Shift  + F8）：跳出当前方法体

![1576477204366](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1576477204366.png)：Run to Cursor（Alt + F9）：直接跳到下一个断点处继续调试

![1576477448969](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1576477448969.png)：Resume Program（F9）：恢复程序运行，但如果该断点下面代码还有断点则停在下一个断点上

![1576477293031](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1576477293031.png)：Stop（Ctrl + F2）：结束调试

![1576477330355](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1576477330355.png)：View Breakpoints（Ctrl + Shift  + F8）：查看所有断点

![1576477381767](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1576477381767.png)：Mute Breakpoints：使得当前代码后面所有的断点失效， 一下执行到底 

### 18.9.3 自定义调试数据视图

![1576478352757](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1576478352757.png)

![1576478431514](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1576478431514.png)

## 18.10 其他常用代码模板和快捷键

### 18.10.1 常用代码模板

#### 1.非空判断

* ifn：if(xx  == null)
* inn：if(xx  != null)
* 变量.null：if(变量 == null)
* 变量.nn：if(变量 != null)

#### 2.遍历数组和集合

* fori：for循环
* itar：遍历数组
* iter：foreach循环
* List集合遍历
  * list集合.for：foreach循环
  * list集合.fori：用for循环遍历list集合，正向遍历
  * list集合.forr：用for循环遍历list集合，逆向遍历

#### 3.静态常量声明

* psf：public static final
* prsf：private static final

* psfi：public static final int
* psfs：public static final String

### 18.10.2 常用快捷键

#### 1.提高代码编写速度

* 智能提示：Alt + 回车
* 自动代码
  * 自动补全函数括号、分号、当前行缩进：Ctrl + Shift + 回车
  * 提示代码模板：Ctrl + J
  * 使用xx块环绕：Ctrl + Alt + T，例如try...catch，for，while等
  * 自动生成构造器、get/set等：Alt + Insert  （有的键盘需要同时按Fn键）
  * 由方法自动生成返回值变量：Ctrl + Alt + V
* 抽取代码重构方法：Ctrl + Alt + M
* 查看所调用方法的形参列表提醒：Ctrl + P
* 重写或实现方法
  * 实现接口的方法：Ctrl + i
  * 重写父类的方法：Ctrl + O

#### 2.移动光标定位

* 移动定位
  * 跳转到上一个/下一个位置编辑位置：Ctrl + Alt + 左/右键
  * 跳转到上一个/下一个方法位置： Alt + 上/下键
  * 打开的类文件之间切换： Alt + 左/右键
  * 定位某行：Ctrl + G
* 选择文本：Ctrl + W
  * 按一下选择单词，再按选择语句，再按选择行，再按选择方法

#### 3.查找与查看源码

* 按住Ctrl键，单击某个类或方法就可以打开某个类或方法的源码
  * 但是当某个变量是通过多态引用调用父类或父接口的方法时，想要打开方法的实现类：Ctrl +Alt +B
* 查看方法文档：选中方法名后按Ctrl + Q
* 查看某个类的结构信息
  * 类的继承层次：Ctrl + H
  * 类的UML关系图：Ctrl + Alt + U
  * 当前文件结构：Ctrl + F12键
* 搜索
  * 搜索类：Ctrl + N
  * 全项目搜索文本：Ctrl + Shift + F
  * 全项目替换文本：Ctrl +Shift + R
  * 当前源文件查找文本：Ctrl + F
  * 当前源文件替换问题：Ctrl + R
  * 任何地方搜索：双击Shift（建议取消）

* 折叠与展开
  * 折叠方法实现：Ctrl + Shift +  -
  * 展开方法实现：Ctrl +Shift + +







## 18.11 文档注释

### 18.11.1 IDEA使用javadoc生成API

![1576467074566](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1576467074566.png)

![img](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/javadoc2.jpg)

### 18.11.2 自定义文档注释模板

类文档注释：

```
/**
$className$
 * date $date$
 * @since 1.8
 * @author $author$
*/
```

![image-20201016141733584](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20201016141733584.png)

![image-20201016141631395](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20201016141631395.png)

无参方法：

```java
/**
    $methodname$
 * date $date$
 * @since 1.8
 * @author $user$
 * @return $returnType$
 */
```

![image-20201016141827954](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20201016141827954.png)

![image-20201016130630633](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20201016130630633.png

![image-20201016130536254](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20201016130536254.png)

有参方法：

```java
/**
    $methodname$
 * @date $date$
 * @since 1.8
 * @author $user$
$params$ 
 * @return $returnType$
 */
```

![image-20201016130704605](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20201016130704605.png)

```
groovyScript("def result=''; def params=\"${_1}\".replaceAll('[\\\\[|\\\\]|\\\\s]', '').split(',').toList(); for(i = 0; i < params.size(); i++) {result+=' * @param ' + params[i] + ((i < params.size() - 1) ? '\\n' : '')}; return result", methodParameters())
```

注意：

设置模板之后要选择支持的语言。

使用这个两个方法的文档注释模板时，如果方法的返回值类型是void，生成之后把@return void删掉，否则生成文档注释报错

使用这两个文档注释模板时必须把光标定位在方法体内部才能有效，否则读取不到methodName等信息。

![image-20201016131024486](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20201016131024486.png)

![image-20201016131103885](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20201016131103885.png)

```java
/**
TestDocTemplate类演示文档注释
 * date 2020/10/16
 * @since 1.8
 * @author Irene
*/
public class TestDocTemplate {
    /**
     method是演示方法
     * date 2020/10/16
     * @since 1.8
     * @author Irene
     */
    public void method(){

    }

    /**
     method的作用是求两个整数的和
     * date 2020/10/16
     * @since 1.8
     * @author Irene
     * @param a int
     * @param b int
     * @return int
     */
    public int method(int a ,int b){
        return a+b;
    }
}
```



## 18.12 使用第三方框架和组件（以JUnit为例）

后面会学习maven，在maven仓库中统一管理所有第三方框架和工具组件的jar，但是现在没有学习maven之前，可以使用本地jar包。

### 18.12.1 引入本地JUnitjar

第一步：在当前IDEA项目目录下建立junitlibs，把下载的JUnit的相关jar包放进去：

![image-20211228181035532](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20211228181035532.png)

第二步：在项目中添加Libraries库

![image-20211228180938922](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20211228180938922.png)

![image-20211228181053362](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20211228181053362.png)

第三步：选择要在哪些module中应用JUnit库

![image-20211228181121005](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20211228181121005.png)

第四步：检查是否应用成功

![image-20211228181151890](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20211228181151890.png)

**注意Scope：选择Complie，否则编译时，无法使用JUnit。**

第5步：下次如果有新的模块要使用该libs库，这样操作即可

![image-20211228181316021](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20211228181316021.png)

![image-20211228181335615](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20211228181335615.png)

![image-20211228181354471](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20211228181354471.png)

![image-20211228181405547](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20211228181405547.png)

### 18.12.2 设置执行JUnit用例时支持控制台输入

在idea64.exe.vmoptions配置文件中加入下面一行设置，重启idea后生效。

需要注意的是，要看你当前IDEA读取的是哪个idea64.exe.vmoptions配置文件文件。如果在C盘的用户目录的config下（例如：C:\Users\Irene\\.IntelliJIdea2019.2\config）也有一个idea64.exe.vmoptions文件，那么将优先使用C盘用户目录下的。否则用的是IDEA安装目录的bin目录（例如：D:\ProgramFiles\JetBrains\IntelliJ_IDEA_2019.2.3\bin）下的idea64.exe.vmoptions文件。

```java
-Deditable.java.test.console=true
```

![1576488062778](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1576488062778.png)

### 18.12.3 定义test测试方法模板

选中自定义的模板组，点击”+”（1.Live Template）来定义模板。

![image-20211229100040505](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20211229100040505.png)



## 18.13 导出jar

（1）单击工具栏的![1576580533760](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1576580533760.png)打开项目设置。

（2）选择Artifacts（打包部署），选择添加jar。

![1579162223458](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1579162223458.png)

（3）给导出的jar命名，确认导出的路径

![image-20211229101041432](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20211229101041432.png)

（4）确认创建或选择已有的Manifest.MF文件。单词“manifest”的意思是“显示” 。 这个 manifest 文件定义了与扩展和包相关的数据。

说明： 打开Java的JAR文件我们经常可以看到文件中包含着一个META-INF目录，这个目录下会有一些文件，其中必有一个MANIFEST.MF，这个文件描述了该Jar文件的很多信息 

![image-20211229101204832](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20211229101204832.png)

（5） 选择Manifest.MF文件存储目录。

![image-20211229100703958](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20211229100703958.png)

![image-20211229101303913](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20211229101303913.png)

（6）选择jar要包含的.class文件的目录，即哪些模块的out目录

![1579162794688](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1579162794688.png)

![image-20211229100850073](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20211229100850073.png)

![image-20211229101452712](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20211229101452712.png)

（7）编译生成jar

![1579162846939](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1579162846939.png)

![1579162868829](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1579162868829.png)

![image-20211229101626963](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20211229101626963.png)



## 18.14 缓存和索引的清理

IntelliJ IDEA 首次加载项目的时候，都会创建索引，而创建索引的时间跟项目的文件多少成正比。

在 IntelliJ IDEA 创建索引过程中即使你编辑了代码也是编译不了、运行不起来的，所以还是安安静静等 IntelliJ IDEA 创建索引完成。

IntelliJ IDEA 的缓存和索引主要是用来加快文件查询，从而加快各种查找、代码提示等操作的速度，所以 IntelliJ IDEA 的索引的重要性再强调一次也不为过。

但是，IntelliJ IDEA 的索引和缓存并不是一直会良好地支持 IntelliJ IDEA 的，某些特殊条件下，IntelliJ IDEA 的缓存和索引文件也是会损坏的，比如：断电、蓝屏引起的强制关机，当你重新打开 IntelliJ IDEA，很可能 IntelliJ IDEA 会报各种莫名其妙错误，甚至项目打不开，IntelliJ IDEA 主题还原成默认状态。即使没有断电、蓝屏，也会有莫名奇怪的问题的时候，也很有可能是 IntelliJ IDEA 缓存和索引出现了问题，这种情况还不少。遇到此类问题也不用过多担心。我们可以清理缓存和索引。如下：

![1576466837132](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1576466837132.png)

![1576466900410](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/1576466900410.png)

* 一般建议点击 Invalidate and Restart，这样会比较干净。
* 上图警告：清除索引和缓存会使得 IntelliJ IDEA 的 Local History 丢失。**所以如果你项目没有加入到版本控制，那你最好备份下你的 LocalHistory 目录**。LocalHistory 目录在用户目录下，例如：C:\Users\Irene\.IntelliJIdea2019.2\system。
* 通过上面方式清除缓存、索引本质也就是去删除 C 盘下的 system 目录下的对应的文件而已，所以如果你不用上述方法也可以手动删除整个 system。当 IntelliJ IDEA 再次启动项目的时候会重新创建新的 system 目录以及对应项目缓存和索引。





## 18.15 高效编码

### 18.15.1 自定义代码快捷模板

#### 1、冒泡排序的快捷模板bsort

①在Settings->Editor->Live Templates中增加模板，如果没有CustomDefine的请看本比较《18.7.6的3.自定义代码模板》

![image-20220118104926687](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20220118104926687.png)

②定义bsort对应冒泡排序代码

```java
for(int $INDEX$ = 1; $INDEX$ < $ARRAY$.length; $INDEX$++) {
    for(int $INDEX2$ = 0; $INDEX2$ < $ARRAY$.length-$INDEX$; $INDEX2$++) {
        if($ARRAY$[$INDEX2$] > $ARRAY$[$INDEX2$+1]){
            $ELEMENT_TYPE$ temp = $ARRAY$[$INDEX2$];
            $ARRAY$[$INDEX2$] = $ARRAY$[$INDEX2$+1];
            $ARRAY$[$INDEX2$+1] = temp;
        }
    }
}
```

![image-20220118105305593](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20220118105305593.png)

③定义代码中$变量$含义

![image-20220118105409414](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20220118105409414.png)

![image-20220118105513616](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20220118105513616.png)

④代码模板应用范围

![image-20220118105616728](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20220118105616728.png)

![image-20220118105633683](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20220118105633683.png)

#### 2、输出数组的元素快捷模板arrprint

①在Settings->Editor->Live Templates中增加模板，如果没有CustomDefine的请看本比较《18.7.6的3.自定义代码模板》

![image-20220118104926687](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20220118104926687.png)

②增加arrprint快捷模板

```java
for(int $INDEX$ = 0; $INDEX$ < $ARRAY$.length; $INDEX$++) {
    System.out.println($ARRAY$[$INDEX$]$END$);
}
```

![image-20220118111200764](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20220118111200764.png)

③定义代码中$变量$含义

![image-20220118111301215](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20220118111301215.png)

![image-20220118111239401](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20220118111239401.png)

④设置语言范围

![image-20220118111329735](尚硅谷_陈叶_JavaSE_IDEA开发工具安装与使用.assets/image-20220118111329735.png)
