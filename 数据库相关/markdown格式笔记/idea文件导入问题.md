# ieda文件导入问题

## **1 导入没有.iml 的idea项目文件**

![image-20230716113117922](D:\TyporaPhoto\image-20230716113117922.png)



![image-20230716113227222](D:\TyporaPhoto\image-20230716113227222.png)



![image-20230716113030450](D:\TyporaPhoto\image-20230716113030450.png)

**解决方法：** **从有.iml的文件中copy 一份**

无法解决！ 目前还没找到生成方法，当作遗留问题保留！





## **2 Maven项目中.iml文件缺失**

简单说明

IDEA中的.iml文件是项目标识文件，缺少了这个文件，IDEA就无法识别项目。跟Eclipse的.project文件性质是一样的。并且这些文件不同的设备上的内容也会有差异，所以我们在管理项目的时候，.project和.iml文件都需要忽略掉。
生成iml文件

    方法一（建议）：刷新一下Maven Project就会自动生成.iml文件。点击下图红框标记的按钮即可
    在这里插入图片描述
    完成后就会自动生成.iml文件。
    
    方法二：在缺少.iml文件项目下运行mvn idea:module，完成后将自动生成.iml文件（在Terminal中输入mvn idea:module）

![](D:\TyporaPhoto\image-20230716114644107.png)



对.project和.iml的思考（仅供参考）

这两个文件都是项目标识文件，用于告诉编辑器这个目录并不是一个普通的目录，而是一个项目。我们会发现，Eclipse用普通导入项目的方式，在缺少.project文件的情况下会找不到项目，无法正常的导入。但通过Maven的方式导入，则会自动生成.project。所以我们需要了解到，我们的开发工具有Maven插件，Maven其实对各个编辑器也内置了一些处理。可以用mvn idea，mvn eclipse这些命令对项目进行基础信息构建。这些基础信息存储在类似.project、.iml文件中供编辑器去读取。IDEA除了.iml文件，还有.ipr、.iws等。至于每个文件存储了些什么信息，IDEA又是怎么去读取的不打算做深一步研究。
（完）
扩展

从博文https://blog.csdn.net/dmcpxy/article/details/52522968中了解到几个maven idea的命令。

    生成.ipr文件: mvn idea:project
    生成.iws文件: mvn idea:workspace
    生成.iml文件: mvn idea:module
 

## 3 导入的项目无法正常运行

普通的项目文件 iml 文件丢失问题 暂时没法解决











