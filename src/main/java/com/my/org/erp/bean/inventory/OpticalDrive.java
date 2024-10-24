package com.my.org.erp.bean.inventory;

import java.util.Date;


public final class OpticalDrive
{

	int rowid;
	
	String name,desc;
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
 
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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
