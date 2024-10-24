package com.my.org.erp.bean.Attendance;

public  final class ManualAttendance {

	String empId;

	String empName;

	String date;

	String inTime;

	String outTime;

	public ManualAttendance(String empId, String empName, String date,
			String inTime, String outTime) {
		super();
		this.empId = empId;
		this.empName = empName;
		this.date = date;
		this.inTime = inTime;
		this.outTime = outTime;

	}

	public ManualAttendance() {
		 
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

	public void setOutTime(String outTime) {
		this.outTime = outTime;
	}

	public String getOutTime() {
		return outTime;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getDate() {
		return date;
	}

}
