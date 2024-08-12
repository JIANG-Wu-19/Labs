package com.example.palmhospitalservice.servlet;

import com.example.palmhospitalservice.bean.Orders;
import com.example.palmhospitalservice.dao.OrderDao;
import com.example.palmhospitalservice.bean.Order;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "MyInfoServlet",value = "/MyInfoServlet")
public class MyInfoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        int uid=Integer.parseInt(request.getParameter("uid"));
        OrderDao orderDao=new OrderDao();
        List<Orders> orders=orderDao.selectordersByUid(uid);

        PrintWriter writer=response.getWriter();
        String result="";

        response.setStatus(HttpServletResponse.SC_OK);
        result =new Gson().toJson(orders,new TypeToken<List<Orders>>(){}.getType());
        writer.write(result);
        writer.flush();
        writer.close();

        System.out.println("查看我的信息"+result);
    }
}
