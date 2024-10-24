package com.my.org.erp.bean.payroll;

public  final class RecoveryTransaction {

	String empId;

	String recCode[];

	public RecoveryTransaction() {
		super();
		 
	}

	public String[] getReccode() {
		return recCode;
	}

	public void setReccode(String[] reccode) {
		this.recCode = reccode;
	}

	public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}

}