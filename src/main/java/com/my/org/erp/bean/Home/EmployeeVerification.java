package com.my.org.erp.bean.Home;

public  final class EmployeeVerification 
{
	String name,cname,address,emailid ,empid;
	long mobiles, phone;
	 
	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getCname() {
		return cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}

	public String getEmailid() {
		return emailid;
	}

	public void setEmailid(String emailid) {
		this.emailid = emailid;
	}

	public String getEmpid() {
		return empid;
	}

	public void setEmpid(String empid) {
		this.empid = empid;
	}
 

	 
	public void setMobiles(int mobiles) {
		this.mobiles = mobiles;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	 

	public long getMobiles() {
		return mobiles;
	}

	public void setMobiles(long mobiles) {
		this.mobiles = mobiles;
	}

	public long getPhone() {
		return phone;
	}

	public void setPhone(long phone) {
		this.phone = phone;
	}

	public void setPhone(int phone) {
		this.phone = phone;
	}

	public String  toString() 
	{
		return " THIS IS FOR EMPLOYEE VERIFIFCATION BEAN CLASS.";
	}
}
