package com.my.org.erp.SmartInventory;

public class SalesPayment {

	int paymentId,salesOrderID,customerId,paymentMethod;
	String paymentDate,CustomerName;
	double openDebit,paidAmount;
	public SalesPayment() {
		
	}
	public int getCustomerId() {
		return customerId;
	}
	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}
	public String getCustomerName() {
		return CustomerName;
	}
	public void setCustomerName(String customerName) {
		CustomerName = customerName;
	}
	public double getOpenDebit() {
		return openDebit;
	}
	public void setOpenDebit(double openDebit) {
		this.openDebit = openDebit;
	}
	public double getPaidAmount() {
		return paidAmount;
	}
	public void setPaidAmount(double paidAmount) {
		this.paidAmount = paidAmount;
	}
	public String getPaymentDate() {
		return paymentDate;
	}
	public void setPaymentDate(String paymentDate) {
		this.paymentDate = paymentDate;
	}
	public int getPaymentId() {
		return paymentId;
	}
	public void setPaymentId(int paymentId) {
		this.paymentId = paymentId;
	}
	public int getPaymentMethod() {
		return paymentMethod;
	}
	public void setPaymentMethod(int paymentMethod) {
		this.paymentMethod = paymentMethod;
	}
	public int getSalesOrderID() {
		return salesOrderID;
	}
	public void setSalesOrderID(int salesOrderID) {
		this.salesOrderID = salesOrderID;
	}

}
