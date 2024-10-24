package com.my.org.erp.bean.Attendance;

import java.io.Serializable;

public final class Attinfo implements Serializable  
{
	 /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String  empid,name, date;

	 private String daytype,attendance;
	private String registertype;
	
	public String getRegistertype() {
		return registertype;
	}

	public void setRegistertype(String registertype) {
		this.registertype = registertype;
	}

	public String getAttendance() {
		return attendance;
	}

	public void setAttendance(String attendance) {
		this.attendance = attendance;
	}

	public String getDaytype() {
		return daytype;
	}

	public void setDaytype(String daytype) {
		this.daytype = daytype;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getEmpid() {
		return empid;
	}

	public void setEmpid(String empid) {
		this.empid = empid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
}
