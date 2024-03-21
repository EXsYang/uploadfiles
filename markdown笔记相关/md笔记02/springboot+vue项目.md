# 1 MyBatis Plus 的分页插件是怎么生效的？体现在哪里？`PaginationInnerInterceptor` 是通过拦截数据库操作来实现分页功能的。



MyBatis Plus 的分页插件 `PaginationInnerInterceptor` 是通过拦截数据库操作来实现分页功能的。它的工作原理如下：

1. **配置分页插件**：在你的 Spring Boot 应用中，你需要配置 `MybatisPlusInterceptor` 并向其添加 `PaginationInnerInterceptor`。这是在你的配置类 `MybatisPlusConfig` 中完成的，如下所示：

   ```java
   @Configuration
   public class MybatisPlusConfig {
       @Bean
       public MybatisPlusInterceptor mybatisPlusInterceptor() {
           MybatisPlusInterceptor interceptor = new MybatisPlusInterceptor();
           interceptor.addInnerInterceptor(new PaginationInnerInterceptor(DbType.MYSQL));
           return interceptor;
       }
   }
   ```

   这段代码的作用是创建一个 `MybatisPlusInterceptor` 实例，并向其添加一个配置好的 `PaginationInnerInterceptor` 实例，这样就启用了分页功能。

2. **使用分页功能**：当你需要执行分页查询时，你会创建一个 `Page` 对象并传递给 MyBatis Plus 的 `page` 方法。例如，在你的控制器中，当调用 `furnService.page(...)` 方法时，你实际上是在请求 MyBatis Plus 为你执行分页查询：

   ```java
   @GetMapping("/furnByPage")
   public Result listFurnsByPage(@RequestParam(defaultValue = "1") Integer pageNum,
                                 @RequestParam(defaultValue = "5") Integer pageSize) {
       Page<Furn> page = furnService.page(new Page<>(pageNum, pageSize));
       return Result.success(page);
   }
   ```

   在这个例子中，`new Page<>(pageNum, pageSize)` 创建了一个分页请求，`pageNum` 是当前页号，`pageSize` 是每页显示的记录数。`furnService.page(...)` 方法内部会根据这些参数，使用分页插件自动修改 SQL 语句，以实现分页查询。

3. **分页插件的作用**：`PaginationInnerInterceptor` 会自动修改你的 SQL 查询，添加 LIMIT 子句（对于 MySQL 数据库），以实现分页功能。它还会执行另一个查询以获取总记录数（总行数），这是为了支持分页控件显示总页数和总记录数。

4. **体现**：分页插件的作用主要体现在：
   
   - 自动改写原始 SQL 语句，添加用于限制结果集大小的语句，实现物理分页。
   - 自动查询总记录数，并将结果封装到 `Page` 对象中，方便前端分页显示和操作。
   - 开发者无需手动编写分页逻辑和计算总页数，极大提高开发效率。

总之，分页插件的生效是在你配置了相应的拦截器并在**服务层调用分页方法时**自动实现的。这个过程对开发者来说是透明的，你只需要按照正常方式编写你的查询条件，剩下的分页处理都由 MyBatis Plus 和分页插件完成。



# 2 也就是说如果用到MybatisPlus的分页操作，形如furnService.page(...)的，就必须注入一个分页插件/拦截器对吗？

是的，你的理解是正确的。如果你想使用 MyBatis Plus 的分页功能，例如通过 `furnService.page(...)` 这样的方法实现自动分页，那么你必须在你的 Spring Boot 应用中配置并注入 MyBatis Plus 的分页插件，也就是 `PaginationInnerInterceptor`。这是因为 MyBatis Plus 的分页功能是通过这个分页插件来实现的。

分页插件工作的方式是拦截所有的查询操作，然后检查是否有分页参数（`Page` 对象），如果有，则自动修改 SQL 语句以实现分页查询。同时，分页插件还会自动执行一个额外的查询以获取总记录数，从而支持前端的分页显示。

要启用分页功能，你需要按照如下步骤在你的配置类中添加分页插件：

```java
@Configuration
public class MybatisPlusConfig {

    @Bean
    public MybatisPlusInterceptor mybatisPlusInterceptor() {
        MybatisPlusInterceptor interceptor = new MybatisPlusInterceptor();
        interceptor.addInnerInterceptor(new PaginationInnerInterceptor(DbType.MYSQL)); // 这里的 DbType.MYSQL 根据实际数据库类型决定
        return interceptor;
    }
}
```

这段代码将确保在执行数据库操作时，分页插件能够拦截到这些操作，并根据需要修改 SQL 语句以实现分页。因此，确实需要注入这个分页插件/拦截器，以便你的应用能够使用 MyBatis Plus 提供的分页功能。

# 3  `page` 方法是通过 MyBatis Plus 实现自动分页的核心方法

在 MyBatis Plus 中进行分页操作的那部分代码是这一行：

```java
public class AttrgroupServiceImpl extends ServiceImpl<AttrgroupDao, AttrgroupEntity> implements AttrgroupService {

 @Override
    public PageUtils queryPage(Map<String, Object> params, Long categoryId) {

    IPage<AttrgroupEntity> page = this.page(
        new Query<AttrgroupEntity>().getPage(params),
        wrapper
    );
    ...    
        
```

在这段代码中：

1. `this.page(...)` 方法是 MyBatis Plus 提供的，用于执行分页查询。`this` 在这里指的是当前的服务类 `AttrgroupServiceImpl` 的实例，它继承自 `ServiceImpl<AttrgroupDao, AttrgroupEntity>`，而 `ServiceImpl` 类提供了 `page` 方法，用于执行分页查询。因此，这里的 `this` 实际上就是指当前的服务实例，它继承了 `ServiceImpl` 从而具有执行分页查询的能力。

2. `new Query<AttrgroupEntity>().getPage(params)` 是创建一个分页查询条件，其中 `Query` 是一个工具类，它根据传入的参数 `params`（这些参数一般包括分页的信息，如当前页和每页大小等），构造出一个 `IPage<AttrgroupEntity>` 类型的对象，这个对象表示分页请求的信息。

3. `wrapper` 是一个 `QueryWrapper<AttrgroupEntity>` 类的实例，它定义了查询的条件。如果 `wrapper` 没有指定任何条件，那么 `page` 方法将会返回所有记录的分页结果。

因此，`this.page(...)` 这行代码是执行分页操作的核心，它结合了分页信息和查询条件，进行数据库查询，并返回查询结果。这里的 `page` 方法是通过 MyBatis Plus 实现自动分页的核心方法，通过它可以非常方便地实现复杂的分页逻辑。



# 4