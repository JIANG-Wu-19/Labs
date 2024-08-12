package com.example.palmhospitalservice.dao;


import com.example.palmhospitalservice.bean.BackDoctors;
import com.example.palmhospitalservice.utils.DbUtil;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import java.sql.SQLException;
import java.util.List;

public class BackDoctorsDao {
    private QueryRunner queryRunner=new QueryRunner();

    public List<BackDoctors> SelectAllDoctors(){
        List<BackDoctors> backDoctors=null;
        try{
            backDoctors=queryRunner.query(DbUtil.getConnection(),"select doctor.did,depart.departname,doctor.dname,doctor.dlevel,doctor.dinfo,doctor.ddetail " +
                    "from doctor,depart " +
                    "where doctor.departid=depart.departid",new BeanListHandler<BackDoctors>(BackDoctors.class));
        }catch (SQLException e){
            e.printStackTrace();
        }

        return backDoctors;
    }
}
