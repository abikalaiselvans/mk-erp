package com.my.org.erp.bean;

public  final class MusterRoll {
	String empId;

	String empName;

	String attValue[];

	double attPresent;

	double attLeave;

	double attOD;

	double attAbsent;

	double attLate;

	double attHoliday;

	int attSunday;

	public MusterRoll() {
	}

	public double getAttAbsent() {
		return attAbsent;
	}

	public void setAttAbsent(double attAbsent) {
		this.attAbsent = attAbsent;
	}

	public double getAttHoliday() {
		return attHoliday;
	}

	public void setAttHoliday(double attHoliday) {
		this.attHoliday = attHoliday;
	}

	public double getAttLate() {
		return attLate;
	}

	public void setAttLate(double attLate) {
		this.attLate = attLate;
	}

	public double getAttLeave() {
		return attLeave;
	}

	public void setAttLeave(double attLeave) {
		this.attLeave = attLeave;
	}

	public double getAttOD() {
		return attOD;
	}

	public void setAttOD(double attOD) {
		this.attOD = attOD;
	}

	public double getAttPresent() {
		return attPresent;
	}

	public void setAttPresent(double attPresent) {
		this.attPresent = attPresent;
	}

	public int getAttSunday() {
		return attSunday;
	}

	public void setAttSunday(int attSunday) {
		this.attSunday = attSunday;
	}

	public String[] getAttValue() {
		return attValue;
	}

	public void setAttValue(String[] attValue) {
		this.attValue = attValue;
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

	protected void finalize() {
		empId = null;
		empName = null;
		attValue = null;
		attPresent = 0;
		attLeave = 0;
		attOD = 0;
		attAbsent = 0;
		attLate = 0;
		attHoliday = 0;
		attSunday = 0;
	}
}
