package com.my.org.erp.bean.Attendance;

public  final class AttendanceLateComersReport {
	String empId;

	String empName;

	String empDepart;

	String empDesig;

	String loginDate;

	String inTime;

	String late;

	String remarks;

	String report1;

	public AttendanceLateComersReport() {
		super();
		 
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

	public String getInTime() {
		return inTime;
	}

	public void setInTime(String inTime) {
		this.inTime = inTime;
	}

	public String getLoginDate() {
		return loginDate;
	}

	public void setLoginDate(String loginDate) {
		this.loginDate = loginDate;
	}

	public String getLate() {
		return late;
	}

	public void setLate(String outTime) {
		this.late = outTime;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getReport1() {
		return report1;
	}

	public void setReport1(String report1) {
		this.report1 = report1;
	}

}
