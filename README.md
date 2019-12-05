#### 1. 사용자 생성 및 권한 주기 및 DB 생성
- create user 'blogAdm'@'localhost' identified by 'blogPw1!';
- GRANT ALL PRIVILEGES ON *.* TO blogAdm@localhost;
- create database blog;
- use blog;

#### 2. 테이블
```sql
CREATE TABLE user(
	id int auto_increment primary key,
    username varchar(100) not null unique,
    password varchar(100) not null,
    salt varchar(100) not null,
    email varchar(100) not null,
    address varchar(300),
    profile text,
    insDt timestamp not null
);
```

```sql
create table board(
	id int auto_increment primary key,
    title varchar(100) not null,
    content longtext,
    insId int not null,
    insDt timestamp not null,
    updDt timestamp,
    delDt timestamp
);
```
