package com.my.org.erp.SmartInventory;

public class Payment {
	
	
	int payTermId;
	String payTermName;
	String payTermDes;
	
	public Payment(int payTermId, String payTermName, String payTermDes) {
		super();
		this.payTermId = payTermId;
		this.payTermName = payTermName;
		this.payTermDes = payTermDes;
	}
	public String getPayTermDes() {
		return payTermDes;
	}
	public void setPayTermDes(String payTermDes) {
		this.payTermDes = payTermDes;
	}
	public int getPayTermId() {
		return payTermId;
	}
	public void setPayTermId(int payTermId) {
		this.payTermId = payTermId;
	}
	public String getPayTermName() {
		return payTermName;
	}
	public void setPayTermName(String payTermName) {
		this.payTermName = payTermName;
	}

}
