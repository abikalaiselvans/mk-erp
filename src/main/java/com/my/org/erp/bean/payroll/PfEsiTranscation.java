package com.my.org.erp.bean.payroll;

public  final class PfEsiTranscation {
	int pfAmt, esiAmt;

	String empId,pfType, pfNo, esiType, esiNo;
     
	public PfEsiTranscation() {
		super();
		 
	}

	public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}

	public int getEsiAmt() {
		return esiAmt;
	}

	public void setEsiAmt(int esiAmt) {
		this.esiAmt = esiAmt;
	}

	public String getEsiNo() {
		return esiNo;
	}

	public void setEsiNo(String esiNo) {
		this.esiNo = esiNo;
	}

	public String getEsiType() {
		return esiType;
	}

	public void setEsiType(String esiType) {
		this.esiType = esiType;
	}

	public int getPfAmt() {
		return pfAmt;
	}

	public void setPfAmt(int pfAmt) {
		this.pfAmt = pfAmt;
	}

	public String getPfNo() {
		return pfNo;
	}

	public void setPfNo(String pfNo) {
		this.pfNo = pfNo;
	}

	public String getPfType() {
		return pfType;
	}

	public void setPfType(String pfType) {
		this.pfType = pfType;
	}

}
