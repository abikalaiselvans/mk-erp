package com.my.org.erp.bean.inventory;

import java.util.Date;


public final class Problems
{

	int rowid,problemgroup;
	String userid, status;
	String deleteid[];
	Date userdate; 
	String  problem, desc;
	public int getRowid() {
		return rowid;
	}
	public void setRowid(int rowid) {
		this.rowid = rowid;
	}
	public int getProblemgroup() {
		return problemgroup;
	}
	public void setProblemgroup(int problemgroup) {
		this.problemgroup = problemgroup;
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
	public String getProblem() {
		return problem;
	}
	public void setProblem(String problem) {
		this.problem = problem;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
	
	
	 
}
