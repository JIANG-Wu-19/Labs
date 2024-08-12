package com.example.palmhospitalservice.backend;

import com.example.palmhospitalservice.bean.BackOrders;
import com.example.palmhospitalservice.dao.BackOrderDao;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name="OrderServlet",value="/OrderServlet")
public class OrderServlet extends HttpServlet {
    public OrderServlet(){super();}

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        BackOrderDao backOrderDao=new BackOrderDao();
        List<BackOrders> backOrders=backOrderDao.selectBackOrders();

        PrintWriter writer=response.getWriter();
        String data="";
        data=new Gson().toJson(backOrders,new TypeToken<List<BackOrders>>(){}.getType());

        String result="";
        response.setStatus(HttpServletResponse.SC_OK);
        result="{\"code\": 0,\"msg\": \"\",\n" +
                "\"count\": "+ backOrders.size()+",\n" +
                "\"data\": " + data +"}";

        writer.write(result);
        writer.flush();
        writer.close();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }
}
