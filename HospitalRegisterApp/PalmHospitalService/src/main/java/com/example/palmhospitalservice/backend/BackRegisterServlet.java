package com.example.palmhospitalservice.backend;

import com.example.palmhospitalservice.bean.Administrator;
import com.example.palmhospitalservice.bean.User;
import com.example.palmhospitalservice.dao.AdministratorDao;
import com.example.palmhospitalservice.dao.UserDao;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "BackRegisterServlet",value="/BackRegisterServlet")
public class BackRegisterServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("接受到注册请求了");
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // 接收参数
        String user = request.getParameter("user");
        String password = request.getParameter("password");

        PrintWriter writer=response.getWriter();
        String result="";

        AdministratorDao administratorDao=new AdministratorDao();
        Administrator administrator=new Administrator(user,password);
        int res = administratorDao.AddAdministrator(administrator);

        if(res == 0){   // 登录失败
            System.out.println("注册失败999！");
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
        }
        else{       // 登录成功
            System.out.println("注册成功啦！");
            response.setStatus(HttpServletResponse.SC_OK);
            response.sendRedirect("login.jsp");
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }
}
