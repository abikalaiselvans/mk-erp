package com.my.org.erp.SmartInventory;

public class PurchasePayment {

	String purchaseOrderId,paymentId,vendorName,paymentMode;
	String paymentDate,openDebit,paidAmt,balAmt;
	public PurchasePayment() {
		super();
		 
	}
	public String getBalAmt() {
		return balAmt;
	}
	public void setBalAmt(String balAmt) {
		this.balAmt = balAmt;
	}
	public String getOpenDebit() {
		return openDebit;
	}
	public void setOpenDebit(String openDebit) {
		this.openDebit = openDebit;
	}
	public String getPaidAmt() {
		return paidAmt;
	}
	public void setPaidAmt(String paidAmt) {
		this.paidAmt = paidAmt;
	}
	public String getPaymentDate() {
		return paymentDate;
	}
	public void setPaymentDate(String paymentDate) {
		this.paymentDate = paymentDate;
	}
	public String getPaymentId() {
		return paymentId;
	}
	public void setPaymentId(String paymentId) {
		this.paymentId = paymentId;
	}
	public String getPaymentMode() {
		return paymentMode;
	}
	public void setPaymentMode(String paymentMode) {
		this.paymentMode = paymentMode;
	}
	public String getPurchaseOrderId() {
		return purchaseOrderId;
	}
	public void setPurchaseOrderId(String purchaseOrderId) {
		this.purchaseOrderId = purchaseOrderId;
	}
	public String getVendorName() {
		return vendorName;
	}
	public void setVendorName(String vendorName) {
		this.vendorName = vendorName;
	}
	
}
