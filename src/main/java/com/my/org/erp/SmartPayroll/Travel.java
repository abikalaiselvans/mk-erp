package com.my.org.erp.SmartPayroll;

public class Travel {

	String travelId;

	String empId;

	String visitPlace;

	String period;

	String purpose;

	String ticket;

	String fromDept;

	String toDept;

	String deptDate;

	String deptTime;

	String fromReturn;

	String toReturn;

	String returnDate;

	String returnTime;

	public Travel(String travelId, String empId, String visitPlace,
			String period, String purpose, String ticket, String fromDept,
			String toDept, String deptDate, String deptTime, String fromReturn,
			String toReturn, String returnDate, String returnTime) {
		super();
		this.travelId = travelId;
		this.empId = empId;
		this.visitPlace = visitPlace;
		this.period = period;
		this.purpose = purpose;
		this.ticket = ticket;
		this.fromDept = fromDept;
		this.toDept = toDept;
		this.deptDate = deptDate;
		this.deptTime = deptTime;
		this.fromReturn = fromReturn;
		this.toReturn = toReturn;
		this.returnDate = returnDate;
		this.returnTime = returnTime;
	}

	public String getDeptDate() {
		return deptDate;
	}

	public void setDeptDate(String deptDate) {
		this.deptDate = deptDate;
	}

	public String getDeptTime() {
		return deptTime;
	}

	public void setDeptTime(String deptTime) {
		this.deptTime = deptTime;
	}

	public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}

	public String getFromDept() {
		return fromDept;
	}

	public void setFromDept(String fromDept) {
		this.fromDept = fromDept;
	}

	public String getFromReturn() {
		return fromReturn;
	}

	public void setFromReturn(String fromReturn) {
		this.fromReturn = fromReturn;
	}

	public String getPeriod() {
		return period;
	}

	public void setPeriod(String period) {
		this.period = period;
	}

	public String getPurpose() {
		return purpose;
	}

	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}

	public String getReturnDate() {
		return returnDate;
	}

	public void setReturnDate(String returnDate) {
		this.returnDate = returnDate;
	}

	public String getReturnTime() {
		return returnTime;
	}

	public void setReturnTime(String returnTime) {
		this.returnTime = returnTime;
	}

	public String getTicket() {
		return ticket;
	}

	public void setTicket(String ticket) {
		this.ticket = ticket;
	}

	public String getToDept() {
		return toDept;
	}

	public void setToDept(String toDept) {
		this.toDept = toDept;
	}

	public String getToReturn() {
		return toReturn;
	}

	public void setToReturn(String toReturn) {
		this.toReturn = toReturn;
	}

	public String getTravelId() {
		return travelId;
	}

	public void setTravelId(String travelId) {
		this.travelId = travelId;
	}

	public String getVisitPlace() {
		return visitPlace;
	}

	public void setVisitPlace(String visitPlace) {
		this.visitPlace = visitPlace;
	}

}
