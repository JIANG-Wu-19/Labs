package com.example.palmhospitalservice.bean;

public class Orders {
    private String time;
    private String departname;
    private String dname;

    public Orders(){}

    public Orders(String time,String departname,String dname){
        this.time=time;
        this.departname=departname;
        this.dname=dname;
    }

    public void setTime(String time){
        this.time=time;
    }

    public String getTime(){
        return time;
    }

    public void setDepartname(String departname){
        this.departname=departname;
    }

    public String getDepartname(){
        return departname;
    }

    public void setDname(String dname){
        this.dname=dname;
    }

    public String getDname(){
        return dname;
    }

    @Override
    public String toString(){
        return "Orders{"+"time='"+time+"',departname='"+departname+"',dname='"+dname+"}";
    }
}
