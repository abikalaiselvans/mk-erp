package com.my.org.erp.bean.Attendance;

public  final class ShiftAllocation {
	String empId;

	String empName;

	String shiftCode;

	String shiftDate;

	public ShiftAllocation(String empId, String empName, String shiftCode,
			String shiftDate) {
		super();
		this.empId = empId;
		this.empName = empName;
		this.shiftCode = shiftCode;
		this.shiftDate = shiftDate;

	}

	public ShiftAllocation() {
		 
	}

	public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}

	public String getShiftDate() {
		return shiftDate;
	}

	public void setShiftDate(String shiftDate) {
		this.shiftDate = shiftDate;
	}

	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName;
	}

	public String getShiftCode() {
		return shiftCode;
	}

	public void setShiftCode(String shiftCode) {
		this.shiftCode = shiftCode;
	}

}
