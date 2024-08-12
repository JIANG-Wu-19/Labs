package com.example.palmhospitalservice.backend;

import com.example.palmhospitalservice.bean.Administrator;
import com.example.palmhospitalservice.dao.AdministratorDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringReader;
import java.util.List;

@WebServlet(name="TestServlet",value="/TestServlet")
public class TestServlet extends HttpServlet {
    public TestServlet (){
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String user=new String(request.getParameter("user").getBytes("ISO-8859-1"),"UTF-8");
        String password=new String(request.getParameter("password").getBytes("ISO-8859-1"),"UTF-8");

        AdministratorDao administratorDao=new AdministratorDao();
        Administrator administrator=administratorDao.selectAdministratorByUser(user);
        if(administrator!=null&& administrator.getPassword().equals(password)){
            request.getSession().setAttribute("user",user);
            response.sendRedirect("controller.jsp");
        }else{
            response.sendRedirect("login.jsp");
        }
//        if(user.equals("admin")&&password.equals("123")){
//            request.getSession().setAttribute("user",user);
//            response.sendRedirect("controller.jsp");
//        }else{
//            response.sendRedirect("login.jsp");
//        }

    }


    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
