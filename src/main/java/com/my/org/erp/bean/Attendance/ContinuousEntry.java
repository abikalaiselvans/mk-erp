package com.my.org.erp.bean.Attendance;

public final class ContinuousEntry 
{
	String ContinuousEntry;
	String ename[];
	int value ;
	String month ;
	int year ;
	public String getContinuousEntry() {
		return ContinuousEntry;
	}
	public void setContinuousEntry(String continuousEntry) {
		ContinuousEntry = continuousEntry;
	}
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
	public int getValue() {
		return value;
	}
	public void setValue(int value) {
		this.value = value;
	}
	public int getYear() {
		return year;
	}
	public void setYear(int year) {
		this.year = year;
	}
	 
}
