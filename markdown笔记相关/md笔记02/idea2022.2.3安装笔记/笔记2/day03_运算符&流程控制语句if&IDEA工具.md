# day03_运算符&流程控制语句if&IDEA工具

## 1.知识点回顾

```tex
数据类型
	引用数据类型
		String 数组 类
	基本数据类型(四类八种)
		整数类
			byte 1   取值 -128 127
			short 2
			int 4  默认
			long 8  标记l/L
		浮点类
			float  4  标记f/F
			double  8  默认
		字符类
			char 2 取值 0-65535
			特殊  可以参与 运算   'a' + 1 = 码表值97 + 1
		布尔类
			boolean  取值 true false 
			表示逻辑的真假判断
	基本数据类型转换
		自动转换(隐式转换)
			取值范围小-> 取值范围大
			1> byte short char  参与运算时 自动提升为 int
			2> 在运算时 取值范围小 与取值范围大参与运算  都会自动提升 小 -> 大
		强制转换(显式转换)	
			取值范围大 -> 取值范围小
			格式
			目标数据类型 变量名 = (目标数据类型)(需要被转换的值);
		
运算符
	算术运算符
		+ - * / % ++ --
		/ 除法运算  特殊情况 整数/整数 结果还是整数
		% 取余的运算 
		++ 自增1
		-- 自减1
		面试题
		a++ 与++a的区别(a-- 与--a)
		相同点:
			语句结束后,自增都会完成
			在单独成行时,结果是一致的
		不同点:
            ++在后,先做其他操作,再自增
            ++在前,先自增,再做其他操作
            
	赋值运算符
		基础的赋值运算符 =  原理:将 符号的右边赋值给左边变量
		扩展的赋值运算符 
			+= -= *= /= %=
			原理: 符号左边的变量与右边的值进行对应的运算,然后运算后的结果重新赋值给左边
			例: a += 2;
			类似于 a + 2 -> 重新赋值给左边的a  a = a  + 2;
	关系运算符
		> < >= <= != ==
		特点  :结果一定是布尔类型  true false
```

## 2.day02作业讲解

```java
class Demo2_HomeWork {

	/*
		给定一个四位数,分别求出对应的各个位的数
		例1234,求出个位->4,十位->3,百位->2,千位->1

		分析思路
			1.1234   个位 ->   值 % 10  商 123 余4
			2.从 123 中拿到4  上一步 值 / 10 --> 123  % 10 -> 3
			3.依次类推

	*/
	public static void main(String[] args) {

		int num = 5678;

		int ge = num  / 1 % 10;
		int shi = num / 10 % 10;
		int bai = num / 100 % 10;
		int qian = num / 1000 % 10;

		System.out.println("当前这个四位数,各位:" + ge + ",十位" 
				+ shi + ",百位" + bai + ",千位是" + qian );
	}
}

```

```java
class Demo3_HomeWork {

	/*
	定义两个变量int a = 10, int b = 20;
	需求:将两个变量的值进行交换,结果,a = 20; b = 10;

		分析
			引入第三方变量 (无中生友)
			开关思想
	*/
	public static void main(String[] args) {

		int a = 10;
		int b = 20;
		int c;//第三方变量 

		c = a;
		a = b;
		b = c;

		System.out.println(a);
		System.out.println(b);
	}
}

```

## 3.运算符

### 3.1 逻辑运算符

```tex
逻辑运算符，是用来连接两个布尔类型结果的运算符（`!`除外），运算结果一定是boolean值true或者false
逻辑运算符
	& 与 且 and  结论 遇false 则false
	|  或            遇true则true
	!  非  取反
	^  异或 不同true 相同 false
	
	&&  具备短路效果  左边是false  右边不执行
	||  具备短路效果  左边是true  右边不执行
```

```java
class  Demo4 {

/*
	&& 与 & 区别
	相同点
		计算的逻辑结果一致的
	不同点
		&& 具备短路效果 
			原理 遇false 则false 
			如果左边是false  右边则不执行
		& 不具备短路效果
			如果左边是false  右边仍然执行
	|| 与 | 区别
	相同点
		计算的逻辑结果一致的
	不同点
		|| 具备短路效果 
			原理 遇true 则true 
			如果左边是true  右边则不执行
		| 不具备短路效果
			如果左边是true  右边仍然执行
*/
	public static void main(String[] args) {

		int a = 3;
		int b = 4;
		int c = 5;

		int x = 3;
		int y = 4;

		// & 与，且 and；有false则false
		System.out.println((a > b) && (x++ == y)); //F & F -> F
		System.out.println(x);// ?

		//System.out.println((a > b) && (a < c)); //F & T -> F
		//System.out.println((a < b) && (a > c)); //T & F -> F
		//System.out.println((a < b) && (a < c)); // T & T -> T
		//System.out.println("===============");
		// | 或；有true则true
		/*System.out.println((a > b) | (a > c)); //F
		System.out.println((a > b) | (a < c)); //T
		System.out.println((a < b) | (a > c)); //T
		System.out.println((a < b) | (a < c)); //T*/
		System.out.println("===============");

		// ^ 异或；相同为false，不同为true
		//System.out.println((a > b) ^ (a > c));//F F F
		//System.out.println((a > b) ^ (a < c)); //F T T
		//System.out.println((a < b) ^ (a > c)); //T F T
		//System.out.println((a < b) ^ (a < c)); // T T F
		System.out.println("===============");
		// ! 非；非false则true，非true则false
		//System.out.println(!false);//t
		//System.out.println(!!true);//t 
	}
}

```

### 3.2 条件运算符(三元运算符)

```tex
三元运算符(条件运算符)
	数据类型 变量名 = (条件表达式) ? 值1 : 值2;
	执行顺序
		1> 条件表达式 -> 结果
		2> 结果true  执行值1
		3> 结果false 执行值2
```

```java
class Demo8 {

	/*
		条件运算符/三元运算符
		数据类型 变量名 =  (条件表达式)? 值1 : 值2;
		执行顺序
			1.条件表达式 -> boolean
			2.boolean 值 true 执行值1
			3.boolean 值 false  执行值2
		求两个整数的最大值
		求三个整数的最大值
		求两个整数是否相等

	*/
	public static void main(String[] args) {

		int x = 80;
		int y = 20;
		
		//boolean b = (x == y)? true:false ;
		String s = (x == y)? "相等":"不相等" ;
		System.out.println(s);
		
		
		
		
		/*int z = 777;

		int max = ( x > y)? x: y;

		int min;//  代表的是x 与y的最小值
		min = (x < y)?x :y;

		int max2;// 代表的是x y z的最大值
		//max2 = (max > z) ? max : z;

		max2 = ((( x > y)? x: y) > z) ? (( x > y)? x: y) : z;

		System.out.println(max2);*/
	}
}

```

### 3.3 位运算符

```tex
<<   乘法  左移几位 乘以2的几次幂
>>   除法  右移几位  除以2的几次幂
>>> 操作的是正数  >> 一致
其他了解
```

### 3.4 运算符总结

```tex
逻辑运算符
	& 与 且 and  结论 遇false 则false
	|  或            遇true则true
	!  非  取反
	^  异或 不同true 相同 false
	
	&&  具备短路效果  左边是false  右边不执行
	||  具备短路效果  左边是true  右边不执行
三元运算符(条件运算符)
	数据类型 变量名 = (条件表达式) ? 值1 : 值2;
	执行顺序
		1> 条件表达式 -> 结果
		2> 结果true  执行值1
		3> 结果false 执行值2
位运算符
	<<   乘法  左移几位 乘以2的几次幂
	>>   除法  右移几位  除以2的几次幂
	>>> 操作的是正数  >> 一致
	其他了解
```

## 4.键盘录入对象Scanner

```tex
使用步骤
- 导包
			格式： import java.util.Scanner; //包  文件
			位置：在class上面。
		- 创建键盘录入对象
			格式：Scanner sc = new Scanner(System.in);//标准输入流
			new 关键字 创建一个引用数据类型的对象
		- 通过对象获取数据
			格式：int x = sc.nextInt();
		- 释放资源
			格式:sc.close();
```

##### 代码演示

```java
import java.util.Scanner;//导包
class Demo10_Scanner {

	/*
		- 导包
			格式： import java.util.Scanner; //包  文件
			位置：在class上面。
		- 创建键盘录入对象
			格式：Scanner sc = new Scanner(System.in);//标准输入流
			new 关键字 创建一个引用数据类型的对象
		- 通过对象获取数据
			格式：int x = sc.nextInt();
		- 释放资源
			格式:sc.close();
	*/
	public static void main(String[] args) {
		
		// 创建键盘录入对象  
		// int   a = 10/;
		Scanner sc = new Scanner(System.in);
		
		// 通过对象获取数据 通过键盘录入对象 可以获取键盘录入的一个整数
		int x = sc.nextInt(); // = 右边  获取键盘录入的一个整数
		System.out.println(x);

		sc.close();//释放资源
	
	}

}
```

##### 代码演示2:需求: 键盘录入两个整数,求出最大值

```java
import java.util.Scanner;
class Demo11 {

	/*
		需求: 键盘录入两个整数
			1> 导包  class  import java.util.Scanner
			2> 创建对象
			3> 使用对象
			4> 释放资源
		求出最大值
	*/
	public static void main(String[] args) {

		//1> 导包  class  import java.util.Scanner
		//2> 创建对象
		Scanner sc = new Scanner(System.in);

		//3> 使用对象 获得一个整数 赋值为num1
		System.out.println("请输入第一个整数:");
		int num1 = sc.nextInt();

		System.out.println("请输入第二个整数:");
		int num2 = sc.nextInt();
		System.out.println(num1 +"," +num2);

		//求出最大值
		int max = (num1 > num2)? num1 : num2;
		System.out.println("这两个整数的最大值:" + max);

		//4> 释放资源
		sc.close();

		
	}
}

```

##### 代码演示3:请通过键盘录入对象,获取个人信息,并输出至控制台(姓名,年龄,性别,身高,体重等)

```tex
需求:
		请通过键盘录入对象,获取个人信息,并输出至控制台
		(姓名,年龄,性别,身高,体重等)

		nextInt() 后面使用nextLine()   出现问题
		解决方案
			1> 使用不同Scanner  不推荐
			2> 通用nextLine()  String -> int  推荐
			3> 暂行的方案  nextLine之前 多使用nextLine()
	*/
```

```java
import java.util.Scanner;
class Demo12_Scanner {

	/*
		需求:
		请通过键盘录入对象,获取个人信息,并输出至控制台
		(姓名,年龄,性别,身高,体重等)

		nextInt() 后面使用nextLine()   出现问题
		解决方案
			1> 使用不同Scanner  不推荐
			2> 通用nextLine()  String -> int  推荐
			3> 暂行的方案  nextLine之前 多使用nextLine()
	*/
	public static void main(String[] args) {

		// 1.导包
		// 2.创建对象
		Scanner sc = new Scanner(System.in);

		// 3.使用对象
		System.out.println("请输入你的姓名");
		String name = sc.nextLine();

		System.out.println("请输入你的年龄");
		int age = sc.nextInt();

		//Scanner sc2 = new Scanner(System.in);
		sc.nextLine();
		System.out.println("请输入你的性别");
		String sex = sc.nextLine();//通过分隔符 回车识别 一行数据的界限

		System.out.println("请输入你的身高cm");
		int heigh = sc.nextInt();

		System.out.println("请输入你的体重KG");
		double weigh = sc.nextDouble();
		System.out.println(name+ ","+ age+ ","+sex+ ","+heigh+ ","+weigh);


		// 4.释放资源

		sc.close();
	}
}

```

##### next()与nextLine()接收字符数据的区别

```tex
next()方法：
			遇到空格等空白符，就认为输入结束
		nextLine()方法：
			遇到回车换行，就认为输入结束
```

```java
import java.util.Scanner;
class Demo13_Scanner {

	/*
		next()与nextLine()接收字符数据的区别
		next()方法：
			遇到空格等空白符，就认为输入结束
		nextLine()方法：
			遇到回车换行，就认为输入结束
	*/
	public static void main(String[] args) {

		// 2.创建对象
		Scanner sc = new Scanner(System.in);

		// 3.使用对象
		System.out.println("请输入一个内容");
		//String line = sc.nextLine(); // 输入aaa  bb(aaa空格空格bb) 结果aaa  bb
		String line = sc.next();// 输入aaa  bb(aaa空格空格bb) 结果aaa

		System.out.println(line);
	}
}

```

## 5.选择分支语句_if

```tex
if
		第一种格式
			if(关系表达式){
				// if语句代码块
			}

			执行顺序
				1> 关系表达式 --> 结果
				2> 结果是true --> if语句代码块
		第二种格式
			if(关系表达式){
				// true --> if语句代码块
			}else{// 以上条件不满足 false
				// false执行的语句块
			}
		第三种格式
			if(关系表达式1){
				// true --> if语句代码块
			}else if(关系表达式2){//如果关系表达式1不满足,
				//基础上进行再次条件筛选判断
					//
			}else if(关系表达式3){// 1 2 都不满足 筛选3
					//
			}
			...
			else{// 以上条件不满足 false
				// false执行的语句块
			}
			
```

##### 案例演示1

```java
class Demo14_If {

	/*
		if
		第一种格式
			if(关系表达式){
				// if语句代码块
			}

			执行顺序
				1> 关系表达式 --> 结果
				2> 结果是true --> if语句代码块
		第二种格式
			if(关系表达式){
				// true --> if语句代码块
			}else{// 以上条件不满足 false
				// false执行的语句块
			}
		第三种格式
			if(关系表达式1){
				// true --> if语句代码块
			}else if(关系表达式2){//如果关系表达式1不满足,
				//基础上进行再次条件筛选判断
					//
			}else if(关系表达式3){// 1 2 都不满足 筛选3
					//
			}
			...
			else{// 以上条件不满足 false
				// false执行的语句块
			}
		注意
			else if 以上条件不满足进行的再次筛选
		 	else    以上条件都不满足
		
		成绩
		90-100  优
		80-90  良
		60-80  中

		<60   不及格

	*/
	public static void main(String[] args) {

		int a = 10;
		if(a > 0){
			System.out.println("该数大于0");// 
		}

		if(a > 0){
			System.out.println("该数大于0");// 
		}else{
			System.out.println("该数小于等于0");	
		}

		
	}
}

```

案例演示2

```tex
成绩
		90-100  优  [90,100]
		80-90  良   [80,90)
		60-80  中   [60,80)
		<60   不及格
```

```java
class Demo15_If {

	/*
	成绩
		90-100  优  [90,100]
		80-90  良   [80,90)
		60-80  中   [60,80)
		<60   不及格

		 else if 以上条件不满足进行的再次筛选
		 else    以上条件都不满足

		 // 编程习惯 
		 1.梳理思路写注释  
		 2.边写边测试
		 3.完成功能  顺序1> 正确数据 2> 边缘数据 3>错误数据
	*/
	public static void main(String[] args) {

		int num = 99;

		// 非法的数据的排除
		/*if((num <= 0) || num > 100 ){
			System.out.println("非法数据");
		}else if( (num >= 90)&& (num <=100)){
			System.out.println("优");
		}else if((num >= 80) && (num < 90)){
			System.out.println("良");
		}else if((num >= 60) && (num < 80)){
			System.out.println("中");
		}else{// 以上条件都不满足
			System.out.println("不及格");
		}*/

		// 优化后的代码
		if((num <= 0) || num > 100 ){
			System.out.println("非法数据");
		}else if( num >= 90){
			System.out.println("优");
		}else if(num >= 80){
			System.out.println("良");
		}else if(num >= 60){
			System.out.println("中");
		}else{// 以上条件都不满足
			System.out.println("不及格");
		}

		
	}
}

```

