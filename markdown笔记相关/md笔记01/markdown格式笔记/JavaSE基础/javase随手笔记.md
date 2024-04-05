# 1 泛型擦除

在Java中，泛型擦除（Type Erasure）是指在编译时去掉泛型类型信息的过程。这是Java泛型实现的一个重要特征。泛型主要用于编译时类型检查，而在运行时，所有的泛型类型信息都会被擦除，转换为原始类型（Raw Types）或边界类型（Bounds）。这意味着在运行时，JVM看到的代码是不包含泛型信息的。

### 泛型擦除的举例说明

假设你有以下泛型类和方法：

```
javaCopy codepublic class Box<T> {
    private T t;

    public void set(T t) {
        this.t = t;
    }

    public T get() {
        return t;
    }
}
```

在这个例子中，`Box` 是一个泛型类，其中 `T` 是一个类型参数。当你使用这个类时，你可以为 `T` 指定任何类型：

```
javaCopy codeBox<String> stringBox = new Box<>();
stringBox.set("Hello");

Box<Integer> integerBox = new Box<>();
integerBox.set(123);
```

#### 编译时

- 在编译时，Java编译器会检查类型安全性，确保你没有尝试将错误的类型放入 `Box` 中。
- 编译器也会进行类型推断，根据你放入 `Box` 的数据类型来确定 `T` 的具体类型。

#### 运行时

- 但是，当代码被编译成字节码并在JVM上运行时，泛型信息会被擦除。这意味着，不论你之前使用了什么类型参数来实例化 `Box` 类，JVM只看到 `Box` 而不是 `Box<String>` 或 `Box<Integer>`。
- 在运行时，所有的泛型类型参数都被替换为它们的原始类型（如果是无界的类型参数，则替换为 `Object`），或者是它们的边界类型（如果有界的话）。

### 泛型擦除的目的

泛型擦除的主要目的是为了向后兼容。当Java引入泛型时，已经有大量不使用泛型的代码存在。通过泛型擦除，Java允许新代码使用泛型而不破坏旧代码的兼容性。这使得旧的Java代码和库可以在新版本的Java环境中运行，而不需要任何修改。

### 结论

泛型擦除意味着泛型仅在编译阶段有效，主要用于类型检查和类型推断。它使得编写更加类型安全的代码成为可能，同时保持了与旧Java代码的兼容性。但是，它也带来了一些限制，比如在运行时无法获取泛型的具体类型信息。

---

# 2 自定义注解中，如果您为一个注解属性提供了默认值，那么这个属性变成可选的。

在Java自定义注解中，如果您为一个注解属性提供了默认值，比如`String regexp() default "";`，那么在使用该注解时，指定这个属性变成可选的。如果没有提供默认值（比如只声明`String regexp();`），那么在使用这个注解时就必须显式提供该属性的值，否则编译器会报错。

# 3 基本数据类型/包装类型数据equals的比较

## 1 Long a = 0L, a.equals(0) 结果是多少？为什么



表达式 `a.equals(0)` 的结果是 `false`。

原因在于 `a` 是一个 `Long` 类型的对象，而 `0` 是一个 `int` 类型的值。在 Java 中，当你调用 `equals` 方法比较两个对象时，它们需要是相同的类型或者具有兼容的类型关系。

在这种情况下，`0` 被自动装箱成一个 `Integer` 对象（而不是 `Long`），因为字面量 `0` 默认是 `int` 类型的。因此，你实际上是在尝试使用 `Long` 类型的对象调用 `equals` 方法来比较一个 `Integer` 对象。由于 `Long` 和 `Integer` 是不同的类型，它们的 `equals` 方法会首先检查另一个对象是否也是相同的类型。在这种情况下，类型不匹配，所以结果是 `false`。

如果你想要比较它们的数值是否相等，你应该确保它们都是相同的类型，或者直接比较它们的基本类型值，例如：

```java
long b = 0L; // 注意这里使用基本类型 long
boolean result = (a == b); // 将会是 true，因为这里比较的是数值
```

或者，如果你确实需要比较两个对象，并且你知道一个是 `Long` 而另一个是 `Integer`，你可以将它们都转换为相同的类型（例如都转换为 `Long`），或者比较它们的基本类型值：

```java
Long b = 0L; // 使用 Long 类型
boolean result = a.equals(b); // 将会是 true
```

或者：

```java
boolean result = a.longValue() == 0; // 将会是 true，因为比较的是基本类型的值
```

这样可以确保比较是公平的，并且是基于数值而非类型。



## 2 当两个 `Long` 类型的对象进行 `equals` 比较时，比较的是它们所包含的数值是否相等。

在你给出的示例中：

```java
Long a = 1L;
Long b = 1L;
a.equals(b);
```

`a.equals(b)` 的结果会是 `true`，因为 `a` 和 `b` 都引用的是 `Long` 类型的对象，并且它们各自包含的数值都是 `1`。在 Java 中，`Long` 类的 `equals` 方法会检查两个对象是否都是 `Long` 类型，并且它们包含的数值是否相等。在这个例子里，这两个条件都满足，所以结果是 `true`。

需要注意的是，这里的比较是在两个对象之间进行的，而不是两个基本类型的值之间，因此 `equals` 方法是在比较两个对象所封装的数值。



## 3 类型相同的包装类对象进行 `equals` 比较时，比较的是它们所封装的数值。

是的，当类型相同的包装类对象进行 `equals` 比较时，比较的是它们所封装的数值。

例如，对于包装类 `Integer`, `Long`, `Double` 等，`equals` 方法被重写以提供值比较而非引用比较。这意味着即使两个对象引用不同（即它们是两个不同的对象实例），只要它们封装的数值相等，`equals` 方法就会返回 `true`。

这里是几个示例：

- 对于 `Integer`：

  ```java
  Integer x = 100;
  Integer y = 100;
  boolean result = x.equals(y);  // true, 因为 x 和 y 封装的整数值相等
  ```

- 对于 `Long`：

  ```java
  Long a = 123L;
  Long b = 123L;
  boolean result = a.equals(b);  // true, 因为 a 和 b 封装的长整型值相等
  ```

- 对于 `Double`：

  ```java
  Double m = 12.34;
  Double n = 12.34;
  boolean result = m.equals(n);  // true, 因为 m 和 n 封装的双精度值相等
  ```

这个行为与基本数据类型不同，基本数据类型比较的是实际的值，而不涉及对象引用。但对于包装类对象，使用 `==` 进行比较时比较的是引用（即是否指向同一个对象），而使用 `equals` 方法进行比较时，比较的是它们所封装的数值。这就是为什么在处理包装类对象时推荐使用 `equals` 而不是 `==` 来比较它们的值。

## 4 将 `Long` 转换为 `long`（通过 `Long` 对象的 `.longValue()` 方法）

# 3 `Set`集合和`List`集合独特的特点

`Set`集合和`List`集合是Java集合框架中两种不同类型的集合，它们各自有独特的特点：

**List集合的特点**：

1. **有序性**：List集合中的元素是有序的，即它们插入的顺序和取出的顺序是一致的。
2. **元素可重复**：List允许集合中有重复的元素，即同一个对象可以添加到List中多次。
3. **索引访问**：List提供基于索引的访问方式，可以通过索引（位置）快速访问集合中的元素。
4. **典型实现**：ArrayList和LinkedList是List接口的两个常用实现，前者基于动态数组，后者基于链表。

**Set集合的特点**：

1. **无序性**：Set集合中的元素是无序的，插入和取出的顺序可能不一致（注意：某些Set实现如LinkedHashSet是有序的）。
2. **元素唯一性**：Set不允许有重复的元素，集合中的每个元素都必须是唯一的。
3. **无索引访问**：Set不支持基于索引的访问，元素的访问必须通过迭代器等方式进行。
4. **典型实现**：HashSet、LinkedHashSet和TreeSet是Set接口的常用实现。HashSet是最常用的Set实现，基于哈希表；LinkedHashSet维持了元素的插入顺序；而TreeSet是基于红黑树实现，元素按照排序规则排列。

总的来说，List和Set的主要区别在于**List允许重复的元素并且元素是有序的**，而**Set不允许重复元素且通常元素是无序的**（除非使用特定的实现，如LinkedHashSet）。这些特性决定了它们适用于不同的编程场景。



# 4 集合转数组：`toArray()`

Java 集合框架提供了一种将集合转换为数组的方法，`toArray()`. 这个方法有两种形式：

1. **无参方法**: `Object[] arr = coll.toArray();`

   - 这种形式返回的是 `Object[]` 类型的数组。如果你的集合 `coll` 包含不同类型的对象，或者你不需要特定类型的数组，这种方式是合适的。

2. **有参方法**: `T[] arr = coll.toArray(new T[0]);`

   - 这种形式允许你指定返回的数组的具体类型。例如，如果你想要一个 `Long[]` 类型的数组，你可以这样做:

     ```java
     Long[] longArray = coll.toArray(new Long[0]);
     ```

   - 尽管这里使用的是长度为0的数组，但Java会根据集合的大小自动创建一个新的数组，这是一种常用的Java惯用法。这意味着，即使是 `new Long[0]`，实际返回的数组会有与 `coll` 集合相同数量的元素。

# 5 集合的反转：`Collections.reverse(List)`

`Collections.reverse(List)` 是一个用于反转 Java 中 `List` 集合元素顺序的方法。这个方法会直接在传入的 `List` 上进行操作，导致 `List` 中的元素顺序被反转，因此原始的 `List` 会被修改。

例如：

```java
List<String> list = new ArrayList<>();
list.add("tom");
list.add("smith");
list.add("king");
list.add("milan");
list.add("tom");
Collections.reverse(list);
System.out.println("list=" + list); // 输出的 list 将会是原始顺序的反转
```

在这个例子中，`list` 中的元素顺序将会被改变。

### 总结

1. **`toArray()` 方法**:
   - 用于将集合转换为数组，有两种形式：无参和有参。
   - 无参形式返回 `Object[]`，有参形式可以指定返回数组的类型，如 `Long[]`。
   - 即使指定的数组大小为0，Java会根据需要自动调整数组大小。

2. **`Collections.reverse(List)` 方法**:
   - 用于反转 List 中的元素顺序。
   - 直接修改原始 List，改变其元素顺序。

在使用 `toArray()` 方法转换集合为特定类型数组时，通常使用 `new T[0]` 作为参数来避免类型转换问题，即使这个数组长度为0，方法依然有效。`Collections.reverse(List)` 提供了一种直接在原始列表上反转元素顺序的快捷方式。



# 6 使用`Pattern`和`Matcher`与`String.matches()`整体匹配时的对比

是的，这两种写法基本上达到了相同的效果，都是用来检查字符串是否匹配给定的正则表达式，但它们在内部工作方式和性能上有些微的差异。

### 使用`Pattern`和`Matcher`（第一种写法）：

```java
Pattern pattern = Pattern.compile(regStr);
Matcher matcher = pattern.matcher(strValue);
return matcher.find();
```

这种方法涉及到编译正则表达式为`Pattern`对象，然后使用这个对象来创建一个`Matcher`，最后使用`matcher.find()`来查找字符串中是否存在匹配正则表达式的子序列。这里有两点需要注意：

1. `matcher.find()`在这个上下文中可能不是最佳选择，因为它用于查找输入字符串中的多个子序列，这可能会与整体匹配的意图相冲突。对于完全匹配的场景，`matcher.matches()`会是更加合适的方法，因为它要求整个区域都匹配正则表达式。
2. 当您需要重复使用同一正则表达式时，使用`Pattern`的好处在于，正则表达式只编译一次，然后可以多次用于创建`Matcher`对象，这可以提高性能。

### 使用`String.matches()`（第二种写法）：

```java
return value.toString().matches(regStr);
```

这种方法更简洁，它直接在字符串对象上调用`matches()`方法，并传入正则表达式字符串。如果字符串符合正则表达式定义的模式，则返回`true`。在内部，`String.matches()`实际上也是创建了`Pattern`和`Matcher`对象，但这个过程是隐藏的。这种写法每次调用时都会编译正则表达式，所以如果在一个循环或频繁调用的情况下使用这种方法，可能会比直接使用`Pattern`和`Matcher`对象的方式效率低下。

### 关于正则表达式`"^[0-1]$"`：

对于这个正则表达式，由于使用了开始`^`和结束`$`定界符，它确实要求整个字符串必须是`0`或`1`，这是一种整体匹配。

综上所述，如果你的意图是检查字符串是否完全匹配正则表达式（在这个例子中是只包含单个字符`0`或`1`），那么你应该在使用第一种写法时使用`matcher.matches()`而不是`matcher.find()`。而如果你选择简便的第二种写法，记住它适用于不需要频繁匹配的场景。

# 7 String.join(",",decript) 的使用

该方法 会遍历 decript 并使用第一个形参作为分隔符进行拼接

~~~
//String.join(",",decript) 该方法 会遍历 decript 并使用第一个形参作为分隔符进行拼接
spuInfoDescEntity.setDecript(String.join(",",decript));
~~~

# 8 