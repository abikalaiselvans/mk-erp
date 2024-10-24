package com.my.org.erp.bean.Attendance;

import java.io.Serializable;

public  final class LeaveType implements Serializable  
{
	
	private static final long serialVersionUID = 1L;

	String LeaveName;
	String LeaveCode;

	public LeaveType(String leaveName, String leaveCode) 
	{
		super();
		LeaveName = leaveName;
		LeaveCode = leaveCode;
	}

	public LeaveType() {
		super();
		 
	}

	public String getLeaveCode() {
		return LeaveCode;
	}

	public void setLeaveCode(String leaveCode) {
		LeaveCode = leaveCode;
	}

	public String getLeaveName() {
		return LeaveName;
	}

	public void setLeaveName(String leaveName) {
		LeaveName = leaveName;
	}
}
