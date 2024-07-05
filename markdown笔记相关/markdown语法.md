# Markdown学习

## 标题

# 一级标题

#+空格+文本+回车



## 二级标题

##+空格+文本+回车



### 三级标题

###+空格+文本+回车



······

## 字体

加粗 两边加两个星号

**Hello World!**

斜体 两边加一个星号

*Hello World!*

*Hello World!*

斜体加粗 两边三个星号

***Hello World!***

删除线 两边两个波浪号

~~Hello World!~~

## 引用 

大于号

> 是多久了啊真的太久了

## 分割线

三个杠---（减号-）或三个***

---



***



# 小圆点 

*号+空格

* 
*   
*  

想要多次生成 可以再次输入空格加回车







## 图片

![截图](https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/p1.jpg)

![网络截图]()

在网页上检查，复制图片地址

![网络截图](http://img-03.proxy.5ce.com/?url=https%3A%2F%2Fp3.pstatp.com%2Flarge%2Fpgc-image%2Faf7d5042565740008dd2b5cfc2381022&q=75)

## 超链接

[超链接文字描述]+[链接地址]

注：typora不支持超链接跳转，但是写到博客上就可以跳转了

[点击跳转到屏幕截图快捷键博客](https://blog.csdn.net/weixin_39626409/article/details/110466386)

## 列表

有序列表：数字.空格

1. a
2. b
3. c

7. e
8. f
9. g

无序列表：-空格（减号空格）

- A
- B
- C

注：shift+tab取消换行后的缩进或两次回车

- d
- d

d

## 表格

直接右键插入是最快的

| 名字 | 性别 | 生日 |
| ---- | ---- | ---- |
|      |      |      |
|      |      |      |
|      |      |      |

## 代码

三个点```+想写什么语言的代码（java），键盘左上角

```java
```



# 技巧 

## 1 让图片居左

在Markdown中，可以使用HTML标签来实现更复杂的布局，因为大多数Markdown解析器支持在Markdown文件中直接使用HTML代码。如果想让图片居左，可以直接使用HTML的<img>标签，并设置样式让图片浮动到左边。

下面是一个示例代码，展示了如何在Markdown中使用HTML来使图片居左：

html
Copy code

<img src="D:/Java_developer_tools/uploadfiles/markdown%E7%AC%94%E8%AE%B0%E7%9B%B8%E5%85%B3/image_url_here" alt="alt_text_here" style="float: left; margin-right: 10px;" />


在这段代码中：

src="image_url_here": 替换image_url_here为你的图片URL。
alt="alt_text_here": 替换alt_text_here为图片的替代文本，当图片不可见时显示。
style="float: left; margin-right: 10px;": 设置图片样式为左浮动，并在图片右侧增加10px的间距。
请注意，使用HTML可能会使Markdown的可读性降低，而且并非所有Markdown解析器都会支持HTML标签。因此，仅在需要时使用HTML，并确保你的Markdown解析器支持它。



## 2 在markdown中直接写：`[toc]` 可以生成可跳转的目录结构

[toc]

## 3 在Markdown中，如果你只想生成跳转到某个章节的链接，可以使用链接语法，并在目标章节添加相应的锚点。具体来说，可以这样操作：

1. **在目标章节添加一个锚点**：
   在目标章节的标题之前添加一个锚点标记。比如在你的120 JVM垃圾收集的GC日志输出解读章节，可以这样添加：

   ```markdown
   <a name="chapter120"></a>
   # 120 JVM垃圾收集的GC日志输出解读
   ```

2. **创建跳转链接**：
   使用Markdown链接语法创建跳转链接。比如：

   ```markdown
   详细解读也可参照[102问题](#chapter102)
   ```

3. **在相应章节添加锚点**：
   同样在102问题的标题前添加一个锚点：

   ```markdown
   <a name="chapter102"></a>
   # 102 问题
   ```

这样，当你**按住`ctrl`,再点击跳转链接**时，就会跳转到对应章节。完整示例如下：

```markdown
<a name="chapter120"></a>
# 120 JVM垃圾收集的GC日志输出解读

详细解读也可参照[102问题](#chapter102)

---

<a name="chapter102"></a>
# 102 问题

这里是102问题的详细内容。
```

这样设置后，你点击“102问题”的链接，就会跳转到带有`chapter102`锚点的章节。

希望这个方法能帮到你！如果有更多问题，请随时告诉我。

