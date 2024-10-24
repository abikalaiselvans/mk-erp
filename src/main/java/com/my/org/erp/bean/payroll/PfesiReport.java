package com.my.org.erp.bean.payroll;

public  final class PfesiReport {

	String empId,empName;
	String pfAmt,PfNo,EsiNo;
	String basicPay,grossPay,emplCon,emprCon,emplFund,emprFund;
	
	public PfesiReport() {
		super();
		 
	}

	public PfesiReport(String pfAmt,String empId, String empName, String pfNo, String esiNo, String basicPay, String grossPay, String emplCon, String emprCon, String emplFund, String emprFund) {
		super();
		this.pfAmt=pfAmt;
		this.empId = empId;
		this.empName = empName;
		PfNo = pfNo;
		EsiNo = esiNo;
		this.basicPay = basicPay;
		this.grossPay = grossPay;
		this.emplCon = emplCon;
		this.emprCon = emprCon;
		this.emplFund = emplFund;
		this.emprFund = emprFund;
	}
	  
	public String getPfAmt() {
		return pfAmt;
	}

	public void setPfAmt(String pfAmt) {
		this.pfAmt = pfAmt;
	}

	public String getBasicPay() {
		return basicPay;
	}

	public void setBasicPay(String basicPay) {
		this.basicPay = basicPay;
	}

	public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}

	public String getEmplCon() {
		return emplCon;
	}

	public void setEmplCon(String emplCon) {
		this.emplCon = emplCon;
	}

	public String getEmplFund() {
		return emplFund;
	}

	public void setEmplFund(String emplFund) {
		this.emplFund = emplFund;
	}

	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName;
	}

	public String getEmprCon() {
		return emprCon;
	}

	public void setEmprCon(String emprCon) {
		this.emprCon = emprCon;
	}

	public String getEmprFund() {
		return emprFund;
	}

	public void setEmprFund(String emprFund) {
		this.emprFund = emprFund;
	}

	public String getEsiNo() {
		return EsiNo;
	}

	public void setEsiNo(String esiNo) {
		EsiNo = esiNo;
	}

	public String getGrossPay() {
		return grossPay;
	}

	public void setGrossPay(String grossPay) {
		this.grossPay = grossPay;
	}

	public String getPfNo() {
		return PfNo;
	}

	public void setPfNo(String pfNo) {
		PfNo = pfNo;
	}

	
	
}
