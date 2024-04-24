# 1 使用 MyBatis Plus 插件来自动化创建从数据库表生成相应的实体类`User` 和映射文件。这一过程的说明

说明；根据数据库表生成对应的基本的crud代码和Entity类，可以参考renren代码生成器，以前在hspliving分布式项目中使用过！参考老韩在hspliving-commodity中crud代码的自动生成过程视频，和**renren-generator代码生成器**的使用即可！



在 MyBatis 或 MyBatis Plus 中，虽然没有直接的命令或一键生成代码的内置功能，但你可以使用一些工具和插件来自动从数据库表生成相应的实体类和映射文件。下面是如何手动创建对应的实体类 `User` 和使用 MyBatis Plus 插件来自动化这一过程的说明：

### 手动创建实体类

首先，你可以手动创建一个实体类 `User` 来映射 `seckill_user` 表：

```java
import java.util.Date;

public class User {
    private Long id;
    private String nickname;
    private String password;
    private String salt;
    private String head;
    private Date registerDate;
    private Date lastLoginDate;
    private Integer loginCount;

    // Getters and Setters
}
```

### 使用 MyBatis Plus 自动生成实体类

对于自动化生成实体类和映射文件，你可以使用 MyBatis Plus 的代码生成器。这个生成器可以根据数据库表的结构自动创建实体类、Mapper 接口以及对应的 XML 文件。

以下是使用 MyBatis Plus 代码生成器的基本步骤：

1. **添加依赖**：确保你的项目中添加了 MyBatis Plus 和代码生成器的依赖。

```xml
<dependencies>
    <dependency>
        <groupId>com.baomidou</groupId>
        <artifactId>mybatis-plus-boot-starter</artifactId>
        <version>3.x.x</version>
    </dependency>
    <dependency>
        <groupId>com.baomidou</groupId>
        <artifactId>mybatis-plus-generator</artifactId>
        <version>3.x.x</version>
    </dependency>
    <dependency>
        <groupId>org.freemarker</groupId>
        <artifactId>freemarker</artifactId>
        <version>2.x.x</version>
    </dependency>
    <!-- 数据库驱动 -->
    <dependency>
        <groupId>数据库驱动</groupId>
        <artifactId>具体数据库驱动</artifactId>
        <version>驱动版本</version>
    </dependency>
</dependencies>
```

2. **配置代码生成器**：设置生成器的配置，包括数据库连接、包名、策略等。

```java
import com.baomidou.mybatisplus.core.exceptions.MybatisPlusException;
import com.baomidou.mybatisplus.core.toolkit.StringPool;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.generator.AutoGenerator;
import com.baomidou.mybatisplus.generator.config.DataSourceConfig;
import com.baomidou.mybatisplus.generator.config.GlobalConfig;
import com.baomidou.mybatisplus.generator.config.PackageConfig;
import com.baomidou.mybatisplus.generator.config.StrategyConfig;
import com.baomidou.mybatisplus.generator.config.rules.NamingStrategy;
import com.baomidou.mybatisplus.generator.engine.FreemarkerTemplateEngine;

import java.util.Scanner;

public class CodeGenerator {

    public static String scanner(String tip) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("请输入" + tip + "：");
        if (scanner.hasNext()) {
            String ipt = scanner.next();
            if (StringUtils.isNotBlank(ipt)) {
                return ipt.trim();
            }
        }
        throw new MybatisPlusException("请输入正确的" + tip + "！");
    }

    public static void main(String[] args) {
        // 代码生成器
        AutoGenerator mpg = new AutoGenerator();

        // 全局配置
        GlobalConfig gc = new GlobalConfig();
        String projectPath = System.getProperty("user.dir");
        gc.setOutputDir(projectPath + "/src/main/java");
        gc.setAuthor("Your Name");
        gc.setOpen(false);
        gc.setFileOverride(true); // 是否覆盖文件
        gc.setServiceName("%sService");
        gc.setMapperName("%sMapper");
        mpg.setGlobalConfig(gc);

        // 数据源配置
        DataSourceConfig dsc = new DataSourceConfig();
        dsc.setUrl("jdbc:mysql://localhost:3306/yourDatabase?useUnicode=true&useSSL=false&characterEncoding=utf8");
        dsc.setDriverName("com.mysql.cj.jdbc.Driver");
        dsc.setUsername("username");
        dsc.setPassword("password");
        mpg.setDataSource(dsc);

        // 包配置
        PackageConfig pc = new PackageConfig();
        pc.setModuleName(scanner("模块名"));
        pc.setParent("com.example");
        mpg.setPackageInfo(pc);

        // 策略配置
        StrategyConfig strategy = new StrategyConfig();
        strategy.setNaming(NamingStrategy.underline_to_camel);
        strategy.setColumnNaming(NamingStrategy.underline_to_camel);
       

 strategy.setEntityLombokModel(true);
        strategy.setRestControllerStyle(true);
        strategy.setInclude(scanner("表名，多个英文逗号分割").split(","));
        mpg.setStrategy(strategy);

        // 设置模板引擎
        mpg.setTemplateEngine(new FreemarkerTemplateEngine());
        mpg.execute();
    }
}
```

3. **运行代码生成器**：运行上述代码，按提示输入模块名和表名，代码生成器会在指定目录下创建相应的文件。

这样，你就可以自动从数据库表 `seckill_user` 生成对应的 `User` 实体类，以及相关的 Mapper 接口和 XML 文件，极大地提高开发效率。



# 2 映射关系梳理

在使用 MyBatis 和 MyBatis Plus 框架时，理解它们如何处理实体类与数据库表以及字段的映射关系是关键。这些框架支持将数据库表的列映射到 Java 对象的属性上，但它们在实现这一功能时的方法和灵活性上存在差异。

### MyBatis 映射关系

#### **表名和字段名映射**

在 MyBatis 中，表名和字段名通常需要在 XML 映射文件中显式指定。MyBatis 不提供自动映射表名和字段名到类名和属性名的功能。

- **表名映射**：表名通常直接在 SQL 查询中硬编码，如在 `mapper.xml` 文件中指定：

  ```xml
  <select id="selectUser" resultType="com.example.User">
      SELECT * FROM user_table WHERE id = #{id}
  </select>
  ```

- **字段名映射**：如果实体类属性名和数据库字段名不一致，需要使用 `<resultMap>` 来显式定义映射关系：

  ```xml
  <resultMap id="userResultMap" type="com.example.User">
      <result property="username" column="user_name"/>
      <result property="email" column="email_address"/>
  </resultMap>
  ```

  使用 `<resultMap>` 允许开发者定义属性名和数据库中字段名之间的对应关系，实现灵活的映射。

#### **映射文件配置**

MyBatis 需要开发者为每种数据库操作提供详细的 SQL 语句，这包括对于查询、插入、更新和删除操作的完整定义。

### MyBatis Plus 映射关系

#### **自动映射功能**

MyBatis Plus 提供了更高级的自动映射功能，它可以自动将表名和字段名转换为对应的类名和属性名。

- **@TableName 和 @TableField**：通过注解自动映射表名和字段名。

  - **@TableName**：用于指定实体类对应的数据库表名。

    ```java
    @TableName("user_table")
    public class User {
        private Long id;
        private String username;
        private String email;
        // getters and setters
    }
    ```

  - **@TableField**：用于指定实体类属性对应的数据库字段名，特别是当属性名和字段名不直接对应时。

    ```java
    public class User {
        @TableField("user_name")
        private String username;
        @TableField("email_address")
        private String email;
        // getters and setters
    }
    ```

- **自动驼峰命名支持**：默认情况下，MyBatis Plus 自动将数据库的下划线命名方式转换为 Java 的驼峰式命名规则，即 `user_name` 自动映射到 `userName` 属性。

  ~~~java
  import com.baomidou.mybatisplus.annotation.TableId;
  import com.baomidou.mybatisplus.annotation.TableName;
  import com.baomidou.mybatisplus.annotation.IdType;
  //在Mybatis-Plus中默认启用自动驼峰命名，除非字段名与属性名的映射不遵循下划线转驼峰的规则
  //，或者有特殊映射需求，才需要显式使用@TableField。
  
  @TableName("user_table") // 指定表名
  public class User {
      @TableId(type = IdType.AUTO) // 设置主键生成策略
      private Long userId;  // 映射到 user_id 字段
  
      private String userName; // 自动映射到 user_name 字段
  
      private String emailAddress; // 自动映射到 email_address 字段
  
      // Getters and Setters
  }
  
  ~~~





#### **全局配置与局部覆盖**

MyBatis Plus 允许在全局配置文件中设置默认行为（如主键策略），同时可以通过在实体类上使用注解来局部覆盖这些设置。

### MyBatis vs MyBatis Plus 映射关系的区别

- **映射配置**：MyBatis 需要显式配置每一个 SQL 语句和映射关系，而 MyBatis Plus 提供了注解和智能映射，减少了重复和繁琐的配置工作。
- **自动映射**：MyBatis Plus 支持自动驼峰命名和通过注解简化映射配置的工作，而 MyBatis 则没有这些自动化功能，需要手动映射每一个字段。
- **开发便利性**：MyBatis Plus 通过提供 CRUD 操作的默认实现，显著提高了开发效率，适合快速开发业务应用。MyBatis 提供了更

多的控制权和灵活性，适用于需要精细控制 SQL 行为的场景。

总结来说，MyBatis Plus 在许多常见场景下提供了更简洁高效的解决方案，特别是在处理实体类与数据库表的映射关系时更加直观和自动化。然而，MyBatis 提供了更深层次的 SQL 控制和定制化，对于复杂的数据库交互场景可能更适用。选择哪一个框架取决于项目需求和开发团队的偏好。



# 3 mybatis默认不支持驼峰法映射，但是mybatis-plus默认是支持驼峰法映射的

MyBatis 和 MyBatis-Plus 在处理属性和数据库列映射的默认行为上有所不同，这确实影响了是否需要额外配置 `resultMap`。

### MyBatis 的默认行为

- **非自动映射**：MyBatis 默认并不自动进行驼峰命名（camelCase）到下划线（underscore）的转换。如果数据库的列名是下划线风格，而Java实体属性是驼峰风格，开发者通常需要手动配置映射关系，或者在 MyBatis 的配置文件中设置 `mapUnderscoreToCamelCase` 为 `true` 来启用自动映射。

```xml
<settings>
    <setting name="mapUnderscoreToCamelCase" value="true"/>
</settings>
```

这个设置告诉 MyBatis 在执行 SQL 映射到 Java 实体时，自动把数据库中的下划线命名转换成Java实体的驼峰命名。

### MyBatis-Plus 的默认行为

- **自动映射**：MyBatis-Plus 默认支持驼峰到下划线的自动转换。这意味着在大多数常见场景下，你不需要手动写 `resultMap` 来处理基本的属性映射。此外，MyBatis-Plus 提供了许多方便的功能，如自动的 CRUD 操作和更简单的查询构造，这些都是基于约定优于配置的原则。

因此，如果你在使用 MyBatis-Plus，并且你的数据模型与数据库列直接对应（遵循驼峰和下划线自动映射规则），你可能不需要频繁使用 `resultMap`。但如之前所述，对于复杂的SQL操作，如多表联合、非标准列映射、复杂的聚合或特定的优化需求，自定义 `resultMap` 仍然是有用的。

总结一下，选择使用 MyBatis 还是 MyBatis-Plus 取决于项目的需求以及你对框架提供的便利性和灵活性的需求。如果项目中有大量标准化的数据库操作，并且希望尽可能减少配置的工作量，MyBatis-Plus 是一个很好的选择。但对于需要精细控制SQL表达和数据映射处理的复杂业务场景，MyBatis 提供了更多的控制力和灵活性。