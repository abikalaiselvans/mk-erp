package com.my.org.erp.bean.SmartTraining;

import com.my.org.erp.ServiceLogin.DateUtil;

public class Training 
{
	long id;
	String desc,test,conductedby,todate,fromdate,type,ename;
	
	
	
	
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
	public String getTest() {
		
		if(!"Y".equals(test))
			test ="N";
		return test;
	}
	public void setTest(String test) {
		this.test = test;
	}
	public String getConductedby() {
		return conductedby;
	}
	public void setConductedby(String conductedby) {
		this.conductedby = conductedby;
	}
	
	public String getTodate() {
		
		
		if("-".equals(todate) || todate.length()<8)
			return null;
		else
			return DateUtil.FormateDateSQL(todate);
		
		 
	}
	public void setTodate(String todate) {
		this.todate = todate;
	}
	
	
	
	public String getFromdate() {
		

		if("-".equals(fromdate) || fromdate.length()<8)
			return null;
		else
			return DateUtil.FormateDateSQL(fromdate);
		 
	}
	public void setFromdate(String fromdate) {
		this.fromdate = fromdate;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getEname() {
		return ename;
	}
	public void setEname(String ename) {
		this.ename = ename;
	}
	
}
