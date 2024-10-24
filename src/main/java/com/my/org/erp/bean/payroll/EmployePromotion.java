package com.my.org.erp.bean.payroll;

public  final class EmployePromotion {
	int proid;

	String empId, proDate, reason, proTo, proFrom;

	public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}

	public EmployePromotion(int proid, String proTo, String proFrom,
			String empId, String proDate, String reason) {
		super();
		this.proid = proid;
		this.proTo = proTo;
		this.proFrom = proFrom;
		this.empId = empId;
		this.proDate = proDate;
		this.reason = reason;
	}

	public EmployePromotion() {
		 
	}

	public String getProDate() {
		return proDate;
	}

	public void setProDate(String proDate) {
		this.proDate = proDate;
	}

	public String getProFrom() {
		return proFrom;
	}

	public void setProFrom(String proFrom) {
		this.proFrom = proFrom;
	}

	public int getProid() {
		return proid;
	}

	public void setProid(int proid) {
		this.proid = proid;
	}

	public String getProTo() {
		return proTo;
	}

	public void setProTo(String proTo) {
		this.proTo = proTo;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

}
