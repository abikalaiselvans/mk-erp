package com.my.org.erp.SmartMarketing;

public class Incentive {

	String empId,empName,tranId,incentiveNo,amount,amountdate,payTermiId,desc;

	public Incentive() {
		super();
		 
	}

	public Incentive(String empId, String empName, String tranId, String incentiveNo, String amount, String amountdate, String payTermiId, String desc) {
		super();
		this.empId = empId;
		this.empName = empName;
		this.tranId = tranId;
		this.incentiveNo = incentiveNo;
		this.amount = amount;
		this.amountdate = amountdate;
		this.payTermiId = payTermiId;
		this.desc = desc;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	public String getAmountdate() {
		return amountdate;
	}

	public void setAmountdate(String amountdate) {
		this.amountdate = amountdate;
	}

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
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

	public String getIncentiveNo() {
		return incentiveNo;
	}

	public void setIncentiveNo(String incentiveNo) {
		this.incentiveNo = incentiveNo;
	}

	public String getPayTermiId() {
		return payTermiId;
	}

	public void setPayTermiId(String payTermiId) {
		this.payTermiId = payTermiId;
	}

	public String getTranId() {
		return tranId;
	}

	public void setTranId(String tranId) {
		this.tranId = tranId;
	}
	
}
