package com.my.org.erp.bean.Attendance;

public  final class LeaveEntry {

	String empId;

	String empName;

	String date;

	String leaveType;

	String fromDate;

	String toDate;

	String leaveId;

	public LeaveEntry(String empId, String empName, String date,
			String leaveType) {
		super();
		this.empId = empId;
		this.empName = empName;
		this.date = date;
		this.leaveType = leaveType;
	}

	public LeaveEntry() {
		 
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
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

	public String getFromDate() {
		return fromDate;
	}

	public void setFromDate(String fromDate) {
		this.fromDate = fromDate;
	}

	public String getLeaveId() {
		return leaveId;
	}

	public void setLeaveId(String leaveId) {
		this.leaveId = leaveId;
	}

	public String getLeaveType() {
		return leaveType;
	}

	public void setLeaveType(String leaveType) {
		this.leaveType = leaveType;
	}

	public String getToDate() {
		return toDate;
	}

	public void setToDate(String toDate) {
		this.toDate = toDate;
	}

}
