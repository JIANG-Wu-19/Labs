package com.example.palmhospitalservice.backend;

import com.example.palmhospitalservice.bean.BackOrders;
import com.example.palmhospitalservice.bean.BackSchedules;
import com.example.palmhospitalservice.dao.BackOrderDao;
import com.example.palmhospitalservice.dao.BackSchedulesDao;
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

@WebServlet(name = "ScheduleServlet",value = "/ScheduleServlet")
public class ScheduleServlet extends HttpServlet {
    public ScheduleServlet(){super();}

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        BackSchedulesDao backSchedulesDao=new BackSchedulesDao();
        List<BackSchedules> backSchedules=backSchedulesDao.SelectAllBackSchedules();

        PrintWriter writer=response.getWriter();
        String data="";
        data=new Gson().toJson(backSchedules,new TypeToken<List<BackSchedules>>(){}.getType());

        String result="";
        response.setStatus(HttpServletResponse.SC_OK);
        result="{\"code\": 0,\"msg\": \"\",\n" +
                "\"count\": "+ backSchedules.size()+",\n" +
                "\"data\": " + data +"}";

        writer.write(result);
        writer.flush();
        writer.close();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }
}
