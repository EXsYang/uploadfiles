package com.atguigu.java;

import java.io.InputStream;
import java.util.HashMap;
import java.util.Scanner;

windows 快捷键
alt + shift 切换输入法语言

idea 快捷键小技巧：
String sql = ""; 连按两次" 会自动到两个双引号后 再加一个分号;即可

/*
 * Eclipse中的快捷键：
 修改过的：
进入方法：ctrl + B / ctrl + 鼠标左键
进入实现类的方法: ctrl + alt + B
转换大小写 ctrl + shift + U
 * 30.调出生成getter/setter/构造器等结构： alt + shift + s / alt + insert
全局查找某个文件/类  ctrl + shift + t  /  ctrl + n
移除了 ctrl + n / 打开context menu  菜单
CTRL+H 全局搜索 修改为 默认的 CTRL + SHIFT + I



 * 1.补全代码的声明：alt + /
 * 2.快速修复: ctrl + 1  
 * 3.批量导包：ctrl + shift + o
 * 4.使用单行注释：ctrl + /
 * 5.使用多行注释： ctrl + shift + /   
 * 6.取消多行注释：ctrl + shift + \
 * 7.复制指定行的代码：ctrl + alt + down 或 ctrl + alt + up
 * 8.删除指定行的代码：ctrl + d
 * 9.上下移动代码：alt + up  或 alt + down
 * 10.切换到下一行代码空位：shift + enter
 * 11.切换到上一行代码空位：ctrl + shift + enter
 * 12.如何查看源码：ctrl + 选中指定的结构   或  ctrl + shift + t
 * 13.退回到前一个编辑的页面：alt + left 
 * 14.进入到下一个编辑的页面(针对于上面那条来说的)：alt + right
 * 15.光标选中指定的类，查看继承树结构：ctrl + t
 * 16.复制代码： ctrl + c
 * 17.撤销： ctrl + z
 * 18.反撤销： ctrl + y
 * 19.剪切：ctrl + x 
 * 20.粘贴：ctrl + v
 * 21.保存： ctrl + s
 * 22.全选：ctrl + a
 * 23.格式化代码： ctrl + shift + f  /  ctrl + alt + L
 * 24.选中数行，整体往后移动：tab
 * 25.选中数行，整体往前移动：shift + tab
 * 26.在当前类中，显示类结构，并支持搜索指定的方法、属性等：ctrl + o
 * 27.批量修改指定的变量名、方法名、类名等：alt + shift + r
 * 28.选中的结构的大小写的切换：变成大写： ctrl + shift + x/ctrl + shift + U
 * 29.选中的结构的大小写的切换：变成小写：ctrl + shift + y/ctrl + shift +  U
 * 新增：CTRL+H  可以查看这个接口下面有哪些实现类
      ctrl+shift+i 全局搜索字符 find in path


 * 30.调出生成getter/setter/构造器等结构： alt + shift + s / alt + insert
 * 31.显示当前选择资源(工程 or 文件)的属性：alt + enter
 * 32.快速查找：参照选中的Word快速定位到下一个 ：ctrl + k
	

 * 
 * 33.关闭当前窗口：ctrl + w
 * 34.关闭所有的窗口：ctrl + shift + w
 * 35.查看指定的结构使用过的地方：ctrl + alt + g
 * 36.查找与替换：ctrl + f
 * 37.最大化当前的View：ctrl + m
 * 38.直接定位到当前行的首位：home
 * 39.直接定位到当前行的末位：end
	

 */

public class EclipseKeys{

	public static void main(String[] args) {
		System.out.println();

		Scanner scanner = new Scanner(System.in);

		int[] arr = new int[] { 33, 44, 5, 2, 4, 53, 2 };

		int max = 0;
		int temp = 0;
		String string = new String();
		char c = string.charAt(0);

		for (int i = 0; i < arr.length; i++) {

		}

		EclipseKeys e = new EclipseKeys();
		e.method();
		e.num = 10;

		InputStream is = null;
		
		HashMap map1 = null;
		map1 = new HashMap();
		map1.put(null, null);
		
		System.out.println(map1);
		
	}

	int num = 10;

	public void method() {

	}
}
