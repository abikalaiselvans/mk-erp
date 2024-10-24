package com.my.org.erp.bean;

public  final class NewEmployee {
	String empId;

	String empName;

	public NewEmployee() {
		 
	}

	public NewEmployee(String empId, String empName) {
		this.empId = empId;
		this.empName = empName;
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
}
