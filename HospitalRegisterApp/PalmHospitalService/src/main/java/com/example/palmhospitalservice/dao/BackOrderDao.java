package com.example.palmhospitalservice.dao;

import com.example.palmhospitalservice.bean.BackOrders;
import com.example.palmhospitalservice.utils.DbUtil;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import java.sql.SQLException;
import java.util.List;

public class BackOrderDao {
    private QueryRunner queryRunner = new QueryRunner();

    public List<BackOrders> selectBackOrders() {
        List<BackOrders> backOrders = null;
        try{
            backOrders=queryRunner.query(DbUtil.getConnection(),"select myorder.oid,user.uid,user.uname,schedule.time,depart.departname,doctor.dname,schedule.price " +
                    "from schedule,depart,doctor,myorder,user " +
                    "where schedule.sid=myorder.sid " +
                    "and schedule.did=doctor.did " +
                    "and doctor.departid=depart.departid " +
                    "and myorder.uid=user.uid",new BeanListHandler<BackOrders>(BackOrders.class));
        }catch (SQLException e){
            e.printStackTrace();
        }

        return backOrders;
    }

}
