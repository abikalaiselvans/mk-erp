package com.my.org.erp.bean.Attendance;

public  final class ShiftMaster {

	String shiftName;
	String shiftCode;
	String fromDate;
	String toDate;
	String teaTimeIn1, teaTimeOut1, teaTimeIn2, teaTimeOut2, lunchIn,lunchOut,graceIn,graceOut;

	public ShiftMaster(String shiftCode, String shiftName, String fromDate,
			String toDate) {
		super();
		this.shiftCode = shiftCode;
		this.shiftName = shiftName;
		this.fromDate = fromDate;
		this.toDate = toDate;
	}
	public ShiftMaster() {
		 
	}
	public String getFromDate() {
		return fromDate;
	}
	public void setFromDate(String fromDate) {
		this.fromDate = fromDate;
	}
	public String getToDate() {
		return toDate;
	}
	public void setToDate(String toDate) {
		this.toDate = toDate;
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
	public String getGraceIn() {
		return graceIn;
	}
	public void setGraceIn(String graceIn) {
		this.graceIn = graceIn;
	}
	public String getGraceOut() {
		return graceOut;
	}
	public void setGraceOut(String graceOut) {
		this.graceOut = graceOut;
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
	public String getTeaTimeIn1() {
		return teaTimeIn1;
	}
	public void setTeaTimeIn1(String teaTimeIn1) {
		this.teaTimeIn1 = teaTimeIn1;
	}
	public String getTeaTimeIn2() {
		return teaTimeIn2;
	}
	public void setTeaTimeIn2(String teaTimeIn2) {
		this.teaTimeIn2 = teaTimeIn2;
	}
	public String getTeaTimeOut1() {
		return teaTimeOut1;
	}
	public void setTeaTimeOut1(String teaTimeOut1) {
		this.teaTimeOut1 = teaTimeOut1;
	}
	public String getTeaTimeOut2() {
		return teaTimeOut2;
	}
	public void setTeaTimeOut2(String teaTimeOut2) {
		this.teaTimeOut2 = teaTimeOut2;
	}
}
