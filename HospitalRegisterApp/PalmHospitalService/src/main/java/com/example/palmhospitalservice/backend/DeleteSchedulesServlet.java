package com.example.palmhospitalservice.backend;

import com.example.palmhospitalservice.dao.OrderDao;
import com.example.palmhospitalservice.dao.ScheduleDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name="DeleteSchedulesServlet",value="/DeleteSchedulesServlet")
public class DeleteSchedulesServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String temp =new String(request.getParameter("sid").getBytes("ISO-8859-1"),"UTF-8");
        int sid=Integer.parseInt(temp);

        ScheduleDao scheduleDao=new ScheduleDao();
        int deleteRecords=scheduleDao.DeleteScheduleBySid(sid);

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
