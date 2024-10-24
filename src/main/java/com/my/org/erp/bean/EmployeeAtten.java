package com.my.org.erp.bean;

public  final class EmployeeAtten {

	String empId;
	String empName;
	String timeIn;
	String timeOut;
	String lunchIn;
	String lunchOut;
	String loginDate;
	String logoutDate;
	String shiftCode;
	String shiftName;
	String morTeaIn,morTeaOut;
	String eveTeaIn,eveTeaOut;
	String late;
	int totalHours;
	int totalMinutes;

	public EmployeeAtten() {

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

	public String getLoginDate() {
		return loginDate;
	}

	public void setLoginDate(String loginDate) {
		this.loginDate = loginDate;
	}

	public String getLogoutDate() {
		return logoutDate;
	}

	public void setLogoutDate(String logoutDate) {
		this.logoutDate = logoutDate;
	}

	public String getLunchIn() {
		return lunchIn;
	}

	public void setLunchIn(String lunchIn) {
		this.lunchIn = lunchIn;
	}

	public String getLunchOut() {
		return lunchOut;
	}

	public void setLunchOut(String lunchOut) {
		this.lunchOut = lunchOut;
	}

	public String getTimeIn() {
		return timeIn;
	}

	public void setTimeIn(String timeIn) {
		this.timeIn = timeIn;
	}

	public String getTimeOut() {
		return timeOut;
	}

	public void setTimeOut(String timeOut) {
		this.timeOut = timeOut;
	}

	public int getTotalHours() {
		return totalHours;
	}

	public void setTotalHours(int totalHours) {
		this.totalHours = totalHours;
	}

	public int getTotalMinutes() {
		return totalMinutes;
	}

	public void setTotalMinutes(int totalMinutes) {
		this.totalMinutes = totalMinutes;
	}

	public String getShiftCode() {
		return shiftCode;
	}

	public void setShiftCode(String shiftCode) {
		this.shiftCode = shiftCode;
	}

	public String getShiftName() {
		return shiftName;
	}

	public void setShiftName(String shiftName) {
		this.shiftName = shiftName;
	}

	public String getEveTeaIn() {
		return eveTeaIn;
	}

	public void setEveTeaIn(String eveTeaIn) {
		this.eveTeaIn = eveTeaIn;
	}

	public String getEveTeaOut() {
		return eveTeaOut;
	}

	public void setEveTeaOut(String eveTeaOut) {
		this.eveTeaOut = eveTeaOut;
	}

	public String getMorTeaIn() {
		return morTeaIn;
	}

	public void setMorTeaIn(String morTeaIn) {
		this.morTeaIn = morTeaIn;
	}

	public String getMorTeaOut() {
		return morTeaOut;
	}

	public void setMorTeaOut(String morTeaOut) {
		this.morTeaOut = morTeaOut;
	}

	public String getLate() {
		return late;
	}

	public void setLate(String late) {
		this.late = late;
	}

}
