package com.my.org.erp.bean.inventory;

import java.util.Date;


public final class Color
{

	int rowid;
	
	String colorcode;
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

	public String getColorcode() {
		return colorcode;
	}

	public void setColorcode(String colorcode) {
		this.colorcode = colorcode;
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
		System.out.println("------"+userdate);
	}
 
	
	
	 
}
