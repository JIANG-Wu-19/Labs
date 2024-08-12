package com.example.palmhospitalservice.dao;

import com.example.palmhospitalservice.bean.BackSchedules;
import com.example.palmhospitalservice.utils.DbUtil;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import java.sql.SQLException;
import java.util.List;

public class BackSchedulesDao {
    private QueryRunner queryRunner=new QueryRunner();

    public List<BackSchedules> SelectAllBackSchedules(){
        List<BackSchedules> backSchedules=null;
        try{
            backSchedules=queryRunner.query(DbUtil.getConnection(),"select schedule.sid,doctor.dname,depart.departname,schedule.time,schedule.price " +
                    "from schedule,doctor,depart " +
                    "where schedule.did=doctor.did " +
                    "and doctor.departid=depart.departid",new BeanListHandler<BackSchedules>(BackSchedules.class));
        }catch (SQLException e) {
            e.printStackTrace();
        }
        return backSchedules;
    }
}
