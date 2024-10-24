package com.my.org.erp.bean.Attendance;

public  final class Permission {

	String empId;

	String empName;

	String date;

	String fromTime;

	String toTime;

	String reason;

	public Permission(String empId, String empName, String date,
			String fromTime, String toTime, String reason) {
		super();
		this.empId = empId;
		this.empName = empName;
		this.date = date;
		this.fromTime = fromTime;
		this.toTime = toTime;
		this.reason = reason;
	}

	public Permission() {
		 
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

	public String getFromTime() {
		return fromTime;
	}

	public void setFromTime(String fromTime) {
		this.fromTime = fromTime;
	}

	public void setToTime(String toTime) {
		this.toTime = toTime;
	}

	public String getToTime() {
		return toTime;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getDate() {
		return date;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

}
