<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 2023/12/25
  Time: 15:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>掌上医院后台系统</title>
  <style>
    * {
      padding: 0;
      margin: 0;
      transition: .3s;
    }

    body {
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      background-image: url(./res/1.jpg);
      background-size: cover;
      font-family: 幼圆, Consolas, serif;
    }

    .shell {
      width: 350px;
      padding: 40px;
      display: flex;
      align-items: center;
      flex-direction: column;
      background-color: #ffffff49;
      border-radius: 50px;
      box-shadow: 0 0 30px rgba(255, 255, 255, 0.5) inset;
      transform: translateY(-50px);
    }

    .title {
      font-size: 80px;
      margin-bottom: 30px;
      color: #fff;
      text-shadow: 0 0 10px #ff9dff80;
    }

    .bigtitle {
      font-size: 120px;
      margin-bottom: 30px;
      color: #0000FF;
      text-shadow: 0 0 10px #ff9dff80;
      margin-right: 30px;
    }

    input[type="text"],
    input[type="password"] {
      width: 100%;
      height: 50px;
      margin: 10px 0;
      box-sizing: border-box;
      color: rgb(0, 0, 0);
      border: 5px solid transparent;
      background: rgba(255, 255, 255, .5);
      border-radius: 100px;
      padding: 5px 20px 0 20px;
      transition: 0.3s;
      font-size: 18px;
      outline: none
    }

    input[type="text"]:hover,
    input[type="password"]:hover {
      background: rgba(255, 255, 255, 0);
      border: 5px solid #ffffff;
    }

    input[type="submit"] {
      width: 100%;
      height: 50px;
      padding: 10px;
      margin: 15px 0;
      border-radius: 100px;
      border: none;
      background-color: #007bff;
      color: #fff;
      cursor: pointer;
      font-size: 20px;
      letter-spacing: 3px;
    }

    input::placeholder {
      color: #92A7E8;
    }

    .footer {
      display: flex;
      justify-content: space-between;
      align-items: center;
      width: 100%;
      margin-top: 20px;
    }

    .Remember {
      opacity: 1;
      display: flex;
      justify-content: center;
      align-items: center;
      font-size: 18px;
      color: #7597ff;
    }

    input[type="checkbox"] {
      display: block;
      width: 25px;
      height: 25px;
      margin-right: 10px;
      background-color: #007bff;
    }

    #Password {
      border: none;
      background-color: #ffffff00;
      color: #7597ff;
      font-size: 18px;
    }
  </style>
</head>

<body>
<div>
  <h1 class="bigtitle">掌医后台管理系统</h1>
</div>
<div class="shell">

  <h2 class="title">注册</h2>
  <form action="BackRegisterServlet" method="POST">
    <input type="text" id="user" placeholder="Username" name="user">
    <input type="password" id="password" placeholder="Password" name="password">
    <input type="submit" value="Register" id="loginBtn">
  </form>
  <div class="footer">
    <div class="Remember">
      <input type="checkbox" id="rememberMe">
      <label for="rememberMe">记住我</label>
    </div>

    <a href="login.jsp">
      <button id="Password">去登录</button>
    </a>
  </div>
</div>

</body>


</html>
