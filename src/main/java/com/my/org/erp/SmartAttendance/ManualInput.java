package com.my.org.erp.SmartAttendance;

public class ManualInput 
{
	double present,onduty,sunday,holiday,leave,absent,extradays;
	int late,permission;
	String ename[];
	String month ;
	int year ;
	int attendancecycle;
	public String[] getEname() {
		return ename;
	}

	public void setEname(String[] ename) {
		this.ename = ename;
	}

	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}

	public int getYear() {
		return year;
	}

	public void setYear(int year) {
		this.year = year;
	}

	public double getAbsent() {
		return absent;
	}

	public void setAbsent(double absent) {
		this.absent = absent;
	}

	public double getExtradays() {
		return extradays;
	}

	public void setExtradays(double extradays) {
		this.extradays = extradays;
	}

	public double getHoliday() {
		return holiday;
	}

	public void setHoliday(double holiday) {
		this.holiday = holiday;
	}

	 

	public double getLeave() {
		return leave;
	}

	public void setLeave(double leave) {
		this.leave = leave;
	}

	public double getOnduty() {
		return onduty;
	}

	public void setOnduty(double onduty) {
		this.onduty = onduty;
	}

	 

	public double getPresent() {
		return present;
	}

	public void setPresent(double present) {
		this.present = present;
	}

	public double getSunday() {
		return sunday;
	}

	public void setSunday(double sunday) {
		this.sunday = sunday;
	}

	public int getLate() {
		return late;
	}

	public void setLate(int late) {
		this.late = late;
	}

	public int getPermission() {
		return permission;
	}

	public void setPermission(int permission) {
		this.permission = permission;
	}

	public int getAttendancecycle() {
		return attendancecycle;
	}

	public void setAttendancecycle(int attendancecycle) {
		this.attendancecycle = attendancecycle;
	}
	
}
