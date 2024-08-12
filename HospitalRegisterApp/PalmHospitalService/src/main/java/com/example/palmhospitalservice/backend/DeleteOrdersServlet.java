package com.example.palmhospitalservice.backend;

import com.example.palmhospitalservice.bean.Orders;
import com.example.palmhospitalservice.dao.OrderDao;
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

@WebServlet(name="DeleteOrdersServlet",value = "/DeleteOrdersServlet")
public class DeleteOrdersServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String oid=new String(request.getParameter("oid").getBytes("ISO-8859-1"),"UTF-8");
        OrderDao orderDao=new OrderDao();
        int deleteRecords=orderDao.DeleteOrderByOid(oid);

        if(deleteRecords>0){
            System.out.println("删除成功");

            response.setStatus(HttpServletResponse.SC_OK);
        }else{
            response.setStatus(HttpServletResponse.SC_BAD_GATEWAY);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        doGet(request,response);
    }
}
