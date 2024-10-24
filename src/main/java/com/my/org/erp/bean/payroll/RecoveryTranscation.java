package com.my.org.erp.bean.payroll;

public  final class RecoveryTranscation {
	String empId;

	String recCode;

	public RecoveryTranscation(String empId, String recCode) {
		super();
		this.empId = empId;
		this.recCode = recCode;
	}

	public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}

	public String getRecCode() {
		return recCode;
	}

	public void setRecCode(String recCode) {
		this.recCode = recCode;
	}

}
