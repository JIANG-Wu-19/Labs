package com.example.palmhospitalservice.dao;

import com.example.palmhospitalservice.bean.Order;
import com.example.palmhospitalservice.bean.Orders;
import com.example.palmhospitalservice.bean.User;
import com.example.palmhospitalservice.utils.DbUtil;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import java.sql.SQLException;
import java.util.List;

public class OrderDao {
    private QueryRunner queryRunner = new QueryRunner();

    public int addOrder(int sid,int uid){
        String oid = Integer.toString(sid)+"-" + Integer.toString(uid);
        int res = 0;

        System.out.println("添加的oid：" + oid);
        try {
            res = queryRunner.update(DbUtil.getConnection(),"INSERT INTO myOrder values(?,?,?)",oid,sid,uid);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return res;
    }

    public List<Orders> selectordersByUid(int uid){
        List<Orders> orders=null;
        try{
            orders=queryRunner.query(DbUtil.getConnection(),"select schedule.time,depart.departname,doctor.dname " +
                    "from schedule,depart,doctor,myorder,user " +
                    "where schedule.sid=myorder.sid " +
                    "and schedule.did=doctor.did " +
                    "and doctor.departid=depart.departid " +
                    "and myorder.uid=user.uid " +
                    "and user.uid=?;",new BeanListHandler<Orders>(Orders.class),uid);
        }catch(SQLException e){
            e.printStackTrace();
        }

        return orders;
    }

    public int DeleteOrderByOid(String oid){
        int deleteRecords=0;

        try{
            deleteRecords=queryRunner.update(DbUtil.getConnection(),"delete from myorder where oid=?",oid);
        }catch(SQLException e){
            e.printStackTrace();
        }

        return deleteRecords;
    }

}
