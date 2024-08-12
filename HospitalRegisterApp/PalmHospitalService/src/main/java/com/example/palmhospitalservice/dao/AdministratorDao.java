package com.example.palmhospitalservice.dao;

import com.example.palmhospitalservice.bean.Administrator;
import com.example.palmhospitalservice.bean.Orders;
import com.example.palmhospitalservice.utils.DbUtil;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import java.sql.SQLException;
import java.util.List;

public class AdministratorDao {
    private QueryRunner queryRunner = new QueryRunner();

    public Administrator selectAdministratorByUser(String user){
        Administrator administrator=null;
        try{
            administrator=queryRunner.query(DbUtil.getConnection(),"select * from administrator " +
                    "where administrator.user=?;",new BeanHandler<Administrator>(Administrator.class),user);
        }catch(SQLException e){
            e.printStackTrace();
        }
        return administrator;
    }

    public int AddAdministrator(Administrator administrator){
        int res=0;
        try{
            res=queryRunner.update(DbUtil.getConnection(),"insert into administrator values(?,?)",administrator.getUser(),administrator.getPassword());
        }catch(SQLException e){
            e.printStackTrace();
        }
        return res;
    }
}
