package com.example.palmhospitalservice.backend;


import com.example.palmhospitalservice.bean.BackDoctors;
import com.example.palmhospitalservice.dao.BackDoctorsDao;
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

@WebServlet(name = "DoctorServlet",value = "/DoctorServlet")
public class DoctorServlet extends HttpServlet {
    public DoctorServlet(){super();}

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        BackDoctorsDao backDoctorsDao =new BackDoctorsDao();
        List<BackDoctors> backDoctors=backDoctorsDao.SelectAllDoctors();

        PrintWriter writer=response.getWriter();
        String data="";
        data=new Gson().toJson(backDoctors,new TypeToken<List<BackDoctors>>(){}.getType());

        String result="";
        response.setStatus(HttpServletResponse.SC_OK);
        result="{\"code\": 0,\"msg\": \"\",\n" +
                "\"count\": "+ backDoctors.size()+",\n" +
                "\"data\": " + data +"}";
        writer.write(result);
        writer.flush();
        writer.close();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }
}
