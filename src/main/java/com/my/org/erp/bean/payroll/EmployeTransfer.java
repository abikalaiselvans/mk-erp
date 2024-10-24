package com.my.org.erp.bean.payroll;

public  final class EmployeTransfer {

	int transId;

	String empId, TransferDate, reason, releavingDate, fromDist, toDist;

	public EmployeTransfer() {
		super();
		 
	}

	public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}

	public String getFromDist() {
		return fromDist;
	}

	public void setFromDist(String fromDist) {
		this.fromDist = fromDist;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getReleavingDate() {
		return releavingDate;
	}

	public void setReleavingDate(String releavingDate) {
		this.releavingDate = releavingDate;
	}

	public String getToDist() {
		return toDist;
	}

	public void setToDist(String toDist) {
		this.toDist = toDist;
	}

	public String getTransferDate() {
		return TransferDate;
	}

	public void setTransferDate(String transferDate) {
		TransferDate = transferDate;
	}

	public int getTransId() {
		return transId;
	}

	public void setTransId(int transId) {
		this.transId = transId;
	}
}
