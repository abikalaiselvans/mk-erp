package com.my.org.erp.bean.inventory;

import java.util.Date;


public final class Unit
{

	int rowid;
	
	String measurement,unit,desc;
	String userid, status;
	String deleteid[];
	Date userdate; 

	public int getRowid() 
	{
		return rowid;
	}

	public void setRowid(int rowid) 
	{
		this.rowid = rowid;
	}

	 
 
	 

	public String getMeasurement() {
		return measurement;
	}

	public void setMeasurement(String measurement) {
		this.measurement = measurement;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	 
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
		 
	}

	public String[] getDeleteid() {
		return deleteid;
	}

	public void setDeleteid(String[] deleteid) {
		this.deleteid = deleteid;
	}

	public Date getUserdate() {
		return userdate;
	}

	public void setUserdate(Date userdate) {
		this.userdate = userdate;
		 
	}
 
	
	
	 
}
