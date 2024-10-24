package com.my.org.erp.bean.payroll;

public  final class Messbill {
	String empId, month, chequeNo, empName;

	int year, cashAmt;

	public Messbill() {
		super();
		 
	}

	public Messbill(String empId, String month, String chequeNo,
			String empName, int year, int cashAmt) {
		super();
		this.empId = empId;
		this.month = month;
		this.chequeNo = chequeNo;
		this.empName = empName;
		this.year = year;
		this.cashAmt = cashAmt;
	}

	public int getCashAmt() {
		return cashAmt;
	}

	public void setCashAmt(int cashAmt) {
		this.cashAmt = cashAmt;
	}

	public String getChequeNo() {
		return chequeNo;
	}

	public void setChequeNo(String chequeNo) {
		this.chequeNo = chequeNo;
	}

	public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}

	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName;
	}

	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}

	public int getYear() {
		return year;
	}

	public void setYear(int year) {
		this.year = year;
	}

}
