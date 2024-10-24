package com.my.org.erp.bean.management;

import java.util.Date;

import com.my.org.erp.ServiceLogin.DateUtil;


public final class Visitors
{

	int rowid;
	String userid, status, refno;
	String deleteid[];
	Date userdate; 
	String name, desc;
	
	long building,floor,purpose,mobile;
	String address,whomtomeet;
	String fromdate,todate,vechileno,notification,emailid,validupto;
	
	
	String entryby,createtime;
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	

	public int getRowid() 
	{
		return rowid;
	}

	public void setRowid(int rowid) 
	{
		this.rowid = rowid;
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

	public long getBuilding() {
		return building;
	}

	public void setBuilding(long building) {
		this.building = building;
	}

	public long getFloor() {
		return floor;
	}

	public void setFloor(long floor) {
		this.floor = floor;
	}

	public long getPurpose() {
		return purpose;
	}

	public void setPurpose(long purpose) {
		this.purpose = purpose;
	}

	public long getMobile() {
		return mobile;
	}

	public void setMobile(long mobile) {
		this.mobile = mobile;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getWhomtomeet() {
		return whomtomeet;
	}

	public void setWhomtomeet(String whomtomeet) {
		this.whomtomeet = whomtomeet;
	}

	public String getFromdate() {
		if(fromdate.length()>8)
			return DateUtil.FormateDateandTimeSQL(fromdate);
		else
			return null;
	}

	public void setFromdate(String fromdate) {
		this.fromdate = fromdate;
	}

	public String getVechileno() {
		return vechileno;
	}

	public void setVechileno(String vechileno) {
		this.vechileno = vechileno;
	}

	public String getNotification() {
		return notification;
	}

	public void setNotification(String notification) {
		this.notification = notification;
	}

	public String getEmailid() {
		return emailid;
	}

	public void setEmailid(String emailid) {
		this.emailid = emailid;
	}

	public String getValidupto() {
		 
		if(validupto.length()>8)
			return DateUtil.FormateDateandTimeSQL(validupto);
		else
			return null;
	}

	public void setValidupto(String validupto) {
		this.validupto = validupto;
	}

	public String getRefno() {
		return refno;
	}

	public void setRefno(String refno) {
		this.refno = refno;
	}

	public String getTodate() {
		 
		if(todate.length()>8)
			return DateUtil.FormateDateandTimeSQL(todate);
		else
			return null;
	}

	public void setTodate(String todate) {
		this.todate = todate;
	}

	public String getEntryby() {
		return entryby;
	}

	public void setEntryby(String entryby) {
		this.entryby = entryby;
	}

	public String getCreatetime() {
		return createtime;
	}

	public void setCreatetime(String createtime) {
		this.createtime = createtime;
	}
 
	
	
	 
}
