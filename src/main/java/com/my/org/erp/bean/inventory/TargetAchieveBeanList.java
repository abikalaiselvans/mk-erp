package com.my.org.erp.bean.inventory;

public  final class TargetAchieveBeanList 
{
	String empid,empname;
	double target, salesamount, achieve;
	
	public TargetAchieveBeanList() 
	{
	}
	
	public double getAchieve() {
		return achieve;
	}
	public void setAchieve(double achieve) {
		this.achieve = achieve;
	}
	public String getEmpid() {
		return empid;
	}
	public void setEmpid(String empid) {
		this.empid = empid;
	}
	public String getEmpname() {
		return empname;
	}
	public void setEmpname(String empname) {
		this.empname = empname;
	}
	public double getSalesamount() {
		return salesamount;
	}
	public void setSalesamount(double salesamount) {
		this.salesamount = salesamount;
	}
	public double getTarget() {
		return target;
	}
	public void setTarget(double target) {
		this.target = target;
	}
}
