package com.my.org.erp.bean.Attendance;

public  final class FingerPrint {
	String empId;

	String empName;

	String depName;

	String desName;

	public FingerPrint(String empId, String empName, String depName,
			String desName) {
		super();
		this.empId = empId;
		this.empName = empName;
		this.depName = depName;
		this.desName = desName;
	}

	public FingerPrint() {
		 
	}

	public FingerPrint(String empId, String empName) {
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

	public String getDepName() {
		return depName;
	}

	public void setDepName(String depName) {
		this.depName = depName;
	}

	public String getDesName() {
		return desName;
	}

	public void setDesName(String desName) {
		this.desName = desName;
	}
}
