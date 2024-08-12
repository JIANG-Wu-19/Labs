package com.example.palmhospitalservice.bean;

public class BackSchedules {
    private int sid;
    private String dname;
    private String departname;
    private String time;
    private float price;

    public BackSchedules() {

    }

    public BackSchedules(int sid, String dname, String departname, String time, float price) {
        this.sid = sid;
        this.dname = dname;
        this.departname = departname;
        this.time = time;
        this.price = price;
    }

    public int getSid() {
        return sid;
    }

    public String getDname() {
        return dname;
    }

    public String getDepartname() {
        return departname;
    }

    public String getTime() {
        return time;
    }

    public float getPrice() {
        return price;
    }

    public void setSid(int sid) {
        this.sid = sid;
    }

    public void setDname(String dname) {
        this.dname = dname;
    }

    public void setDepartname(String departname) {
        this.departname = departname;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public void setPrice(float price) {
        this.price = price;
    }
}
