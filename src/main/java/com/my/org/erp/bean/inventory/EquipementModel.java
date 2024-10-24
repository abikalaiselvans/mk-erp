package com.my.org.erp.bean.inventory;

import java.util.Date;


public final class EquipementModel
{

	int rowid,unittype;
	String userid, status;
	String deleteid[];
	Date userdate; 
	String model, desc;
	 
	
	public int getRowid() {
		return rowid;
	}
	public void setRowid(int rowid) {
		this.rowid = rowid;
	}
	
	
	public int getUnittype() {
		return unittype;
	}
	public void setUnittype(int unittype) {
		this.unittype = unittype;
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
	public String getModel() {
		return model;
	}
	public void setModel(String model) {
		this.model = model;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
	 
	 
}
