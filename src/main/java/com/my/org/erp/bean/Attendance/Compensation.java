package com.my.org.erp.bean.Attendance;

public  final class Compensation {

	String empId;

	String empName;

	String holidayName;

	String holidayDate;

	public Compensation(String empId, String empName, String holidayName,
			String holidayDate) {
		super();
		this.empId = empId;
		this.empName = empName;
		this.holidayName = holidayName;
		this.holidayDate = holidayDate;

	}

	public Compensation() {
		 
	}

	public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}

	public String getHolidayDate() {
		return holidayDate;
	}

	public void setHolidayDate(String holidayDate) {
		this.holidayDate = holidayDate;
	}

	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName;
	}

	public String getHolidayName() {
		return holidayName;
	}

	public void setHolidayName(String holidayName) {
		this.holidayName = holidayName;
	}

}
