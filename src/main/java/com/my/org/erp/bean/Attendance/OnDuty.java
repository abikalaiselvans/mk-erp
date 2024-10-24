package com.my.org.erp.bean.Attendance;

public  final class OnDuty {

	String empId;

	String empName;

	String ODDate;

	String place;

	String reason;

	String dayType;

	public OnDuty(String empId, String empName, String ODDate, String place,
			String reason) {
		super();
		this.empId = empId;
		this.empName = empName;
		this.ODDate = ODDate;
		this.place = place;
		this.reason = reason;

	}

	public OnDuty() {
		 
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

	public String getPlace() {
		return place;
	}

	public void setPlace(String place) {
		this.place = place;
	}

	public String getODDate() {
		return ODDate;
	}

	public void setODDate(String ODDate) {
		this.ODDate = ODDate;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getDayType() {
		return dayType;
	}

	public void setDayType(String dayType) {
		this.dayType = dayType;
	}

}
