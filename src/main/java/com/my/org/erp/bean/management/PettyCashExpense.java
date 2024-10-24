package com.my.org.erp.bean.management;

import java.text.SimpleDateFormat;
import java.util.Date;

import com.my.org.erp.ServiceLogin.DateUtil;


public final class PettyCashExpense
{

	int rowid,category,branch ;
	String userid, status;
	String deleteid[];
	Date userdate; 
	String  desc,incomedate ;
	double income;
	int source;
	String othersid,whom,authorised;
	String paymentmode;
	
	public String getAuthorised() {
		return authorised;
	}
	public void setAuthorised(String authorised) {
		this.authorised = authorised;
	}
	public String getOthersid() {
		return othersid;
	}
	public void setOthersid(String othersid) {
		this.othersid = othersid;
	}
	public String getWhom() {
		return whom;
	}
	public void setWhom(String whom) {
		this.whom = whom;
	}
	public int getSource() {
		return source;
	}
	public void setSource(int source) {
		this.source = source;
	}
	public String getIncomedate() {
		if(incomedate.length()>5)
			return DateUtil.FormateDateSQL(incomedate); 
		else
			return null;
	}
	public void setIncomedate(String incomedate) {
		this.incomedate = incomedate;
	}
	public int getRowid() {
		return rowid;
	}
	public void setRowid(int rowid) {
		this.rowid = rowid;
	}
	public int getCategory() {
		return category;
	}
	public void setCategory(int category) {
		this.category = category;
	}
	public int getBranch() {
		return branch;
	}
	public void setBranch(int branch) {
		this.branch = branch;
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
	 
	 
 
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
	public double getIncome() {
		return income;
	}
	public void setIncome(double income) {
		this.income = income;
	}
	public String getPaymentmode() {
		return paymentmode;
	}
	public void setPaymentmode(String paymentmode) {
		this.paymentmode = paymentmode;
	}
	 
  
	 
}
