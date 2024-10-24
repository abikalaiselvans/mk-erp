package com.my.org.erp.bean.payroll;

public  final class Advance {
	String emp_Id, emp_name, adv_Id, month, due, dueType, openDate, closeDate;

	int year, advAmt, noInstal, dueAmt, balAmt, balInstal;



	public Advance() {
		super();
		 
	}

	public String getAdv_Id() {
		return adv_Id;
	}

	public void setAdv_Id(String adv_Id) {
		this.adv_Id = adv_Id;
	}

	public int getAdvAmt() {
		return advAmt;
	}

	public void setAdvAmt(int advAmt) {
		this.advAmt = advAmt;
	}

	public int getBalAmt() {
		return balAmt;
	}

	public void setBalAmt(int balAmt) {
		this.balAmt = balAmt;
	}

	public int getBalInstal() {
		return balInstal;
	}

	public void setBalInstal(int balInstal) {
		this.balInstal = balInstal;
	}

	public String getCloseDate() {
		return closeDate;
	}

	public void setCloseDate(String closeDate) {
		this.closeDate = closeDate;
	}

	public String getDue() {
		return due;
	}

	public void setDue(String due) {
		this.due = due;
	}

	public int getDueAmt() {
		return dueAmt;
	}

	public void setDueAmt(int dueAmt) {
		this.dueAmt = dueAmt;
	}

	public String getDueType() {
		return dueType;
	}

	public void setDueType(String dueType) {
		this.dueType = dueType;
	}

	public String getEmp_Id() {
		return emp_Id;
	}

	public void setEmp_Id(String emp_Id) {
		this.emp_Id = emp_Id;
	}

	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}

	public int getNoInstal() {
		return noInstal;
	}

	public void setNoInstal(int noInstal) {
		this.noInstal = noInstal;
	}

	public String getOpenDate() {
		return openDate;
	}

	public void setOpenDate(String openDate) {
		this.openDate = openDate;
	}

	public int getYear() {
		return year;
	}

	public void setYear(int year) {
		this.year = year;
	}

	public String getEmp_name() {
		return emp_name;
	}

	public void setEmp_name(String emp_name) {
		this.emp_name = emp_name;
	}

}