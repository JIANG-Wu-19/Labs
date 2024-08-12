# Java聊天室与白板程序

## 环境说明

* JDK版本17.0.4.1
* Windows11操作系统开发

**项目依赖**：

* jl11.0.jar
* mysql-connector-java-8.0.28.jar

在运行项目前，需要在运行环境中配置JVM，以及上述两个Jar 包；数据库使用MySQL，需要提前建好MySQL 数据库login，并在其中建立好表client，使用NavicatPremium 进行数据库的管理。

## 数据库、表建立

先建立数据库login，然后使用ddl语句创建数据库

```sql
create table client(
   id int(11) primary key auto_increment,
   username varchar(20) not null,
   password varchar(20) not null,
   picture_path varchar(200) not null
 )comment '用户表';
```

## Java聊天室

运行步骤：

1. 使用IDEA打开
2. 导入两个依赖包
3. 修改数据库的密码
4. debug

## Java白板程序

运行步骤同上

