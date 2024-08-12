<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 2024/1/6
  Time: 19:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<%
    String user=(String) request.getSession().getAttribute("user");
    if(user==null){
        response.sendRedirect("login.jsp");
        return;
    }
%>
<head>
    <meta charset="utf-8">
    <title>掌医后台管理系统</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="//cdn.staticfile.org/layui/2.9.3/css/layui.css" rel="stylesheet">

    <style>
        html, body {height: 100%;width: 100%;}
        iframe {width: 100%;height: 100%;}
    </style>

    <script type="text/javascript">
        function iframeHeight() {
            document.getElementById('mainframe').height = 100% ;
        }
    </script>
    <link rel="icon" href="./res/icon_zhangyi.png">
</head>
<body>
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo layui-hide-xs layui-bg-black">控制台</div>
        <!-- 头部区域（可配合layui 已有的水平导航） -->
        <!-- <ul class="layui-nav layui-layout-left">
          <li class="layui-nav-item layui-show-xs-inline-block layui-hide-sm" lay-header-event="menuLeft">
            <i class="layui-icon layui-icon-spread-left"></i>
          </li>
          <li class="layui-nav-item layui-hide-xs"><a href="javascript:;">nav 1</a></li>
          <li class="layui-nav-item layui-hide-xs"><a href="javascript:;">nav 2</a></li>
          <li class="layui-nav-item layui-hide-xs"><a href="javascript:;">nav 3</a></li>
          <li class="layui-nav-item">
            <a href="javascript:;">nav groups</a>
            <dl class="layui-nav-child">
              <dd><a href="javascript:;">menu 11</a></dd>
              <dd><a href="javascript:;">menu 22</a></dd>
              <dd><a href="javascript:;">menu 33</a></dd>
            </dl>
          </li>
        </ul> -->
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item layui-hide layui-show-sm-inline-block">
                <a href="javascript:;">
                    <img src="./res/2.jpg" class="layui-nav-img">
                    超级管理员
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="LogoutServlet">退出登录</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item" lay-header-event="menuRight" lay-unselect>
                <a href="javascript:;">
                    <i class="layui-icon layui-icon-more-vertical"></i>
                </a>
            </li>
        </ul>
    </div>
    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree" lay-filter="test">
                <li class="layui-nav-item layui-nav-itemed">
                    <a class="main_left" data-src="orders.jsp">预约信息管理</a>
                </li>

                <li class="layui-nav-item layui-nav-itemed">
                    <a class="main_left" data-src="doctors.jsp">医生信息管理</a>
                </li>

                <li class="layui-nav-item layui-nav-itemed">
                    <a class="main_left" data-src="schedules.jsp">排班信息管理</a>
                </li>

            </ul>
        </div>
    </div>

    <div class="layui-body">
        <!-- 内容主体区域 -->
        <iframe id="mainframe" frameborder="0" scrolling="yes" style="width: 100%;height: 100%" src="orders.jsp"> </iframe>
    </div>

    <div class="layui-footer">
        <!-- 底部固定区域 -->
        Copyright &copy; 2024 | Powered by <a href="https://github.com/JIANG-Wu-19">J&Ocean</a>
    </div>
</div>

<script src="//cdn.staticfile.org/layui/2.9.3/layui.js"></script>
<script>
    //JS
    layui.use(['element', 'layer', 'util'], function(){
        var element = layui.element;
        var layer = layui.layer;
        var util = layui.util;
        var $ = layui.$;

        //头部事件
        util.event('lay-header-event', {
            menuLeft: function(othis){ // 左侧菜单事件
                layer.msg('展开左侧菜单的操作', {icon: 0});
            },
            menuRight: function(){  // 右侧菜单事件
                layer.open({
                    type: 1,
                    title: '更多',
                    content: '<div style="padding: 15px;"></div>',
                    area: ['260px', '100%'],
                    offset: 'rt', // 右上角
                    anim: 'slideLeft', // 从右侧抽屉滑出
                    shadeClose: true,
                    scrollbar: false
                });
            }
        });
    });
</script>

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
    $(function(){
        $(".main_left").click(function(){
            var src = $(this).attr("data-src");
            $("#mainframe").attr("src",src);
        });
    });
</script>
</body>
</html>
