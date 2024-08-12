package com.example.palmhospitalservice.bean;

public class BackOrders {
    private String oid;
    private String uid;
    private String uname;
    private String time;
    private String departname;
    private String dname;
    private float price;

    public BackOrders(){}
    public BackOrders(String oid,String uid,String uname,String time,String departname,String dname,float price){
        this.oid=oid;
        this.uid=uid;
        this.uname=uname;
        this.time=time;
        this.departname=departname;
        this.dname=dname;
        this.price=price;
    }

    public String getUid() {
        return uid;
    }

    public String getUname() {
        return uname;
    }

    public String getTime() {
        return time;
    }

    public String getDepartname() {
        return departname;
    }

    public String getDname() {
        return dname;
    }

    public float getPrice() {
        return price;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    public void setUname(String uname) {
        this.uname = uname;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public void setDepartname(String departname) {
        this.departname = departname;
    }

    public void setDname(String dname) {
        this.dname = dname;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public String getOid() {
        return oid;
    }

    public void setOid(String oid) {
        this.oid = oid;
    }
}
