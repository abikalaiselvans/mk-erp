package com.my.org.erp.bean.Attendance;

public  final  class AbsentReport {

	String empId,empName,empDepart,empDesig;

	public AbsentReport() {
		super();
		 
	}

	public AbsentReport(String empId, String empName, String empDepart, String empDesig) {
		super();
		this.empId = empId;
		this.empName = empName;
		this.empDepart = empDepart;
		this.empDesig = empDesig;
	}

	public String getEmpDepart() {
		return empDepart;
	}

	public void setEmpDepart(String empDepart) {
		this.empDepart = empDepart;
	}

	public String getEmpDesig() {
		return empDesig;
	}

	public void setEmpDesig(String empDesig) {
		this.empDesig = empDesig;
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
