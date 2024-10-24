package com.my.org.erp.bean.payroll;

public  final class AllowanceTransaction {

	String empId;

	String allode[];

	public AllowanceTransaction() {
		super();
		 
	}

	public String[] getAllode() {
		return allode;
	}

	public void setAllode(String[] allode) {
		this.allode = allode;
	}

	public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}

}
