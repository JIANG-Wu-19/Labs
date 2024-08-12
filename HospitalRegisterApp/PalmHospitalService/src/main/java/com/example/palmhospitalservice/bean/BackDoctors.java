package com.example.palmhospitalservice.bean;

public class BackDoctors {
    private int did;
    private String departname;
    private String dname;
    private String dlevel;
    private String dinfo;
    private String ddetail;

    public BackDoctors() {

    }

    public BackDoctors(int did, String departname, String dname, String dlevel, String dinfo, String ddetail) {
        this.did = did;
        this.departname = departname;
        this.dname = dname;
        this.dlevel = dlevel;
        this.dinfo = dinfo;
        this.ddetail = ddetail;
    }

    public int getDid() {
        return did;
    }

    public String getDepartname() {
        return departname;
    }

    public String getDname() {
        return dname;
    }

    public String getDlevel() {
        return dlevel;
    }

    public String getDinfo() {
        return dinfo;
    }

    public String getDdetail() {
        return ddetail;
    }

    public void setDid(int did) {
        this.did = did;
    }

    public void setDepartname(String departname) {
        this.departname = departname;
    }

    public void setDname(String dname) {
        this.dname = dname;
    }

    public void setDlevel(String dlevel) {
        this.dlevel = dlevel;
    }

    public void setDinfo(String dinfo) {
        this.dinfo = dinfo;
    }

    public void setDdetail(String ddetail) {
        this.ddetail = ddetail;
    }
}
