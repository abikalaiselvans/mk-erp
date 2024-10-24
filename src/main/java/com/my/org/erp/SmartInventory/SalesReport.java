package com.my.org.erp.SmartInventory;

public class SalesReport {

String	salesId,customerName,orderDate,delivery;
String amount,taxAmount,totalAmount,orderStatus,paymentStatus;
public SalesReport() {
	super();
	 
}
public String getAmount() {
	return amount;
}
public void setAmount(String amount) {
	this.amount = amount;
}
public String getCustomerName() {
	return customerName;
}
public void setCustomerName(String customerName) {
	this.customerName = customerName;
}
public String getDelivery() {
	return delivery;
}
public void setDelivery(String delivery) {
	this.delivery = delivery;
}
public String getOrderDate() {
	return orderDate;
}
public void setOrderDate(String orderDate) {
	this.orderDate = orderDate;
}
public String getOrderStatus() {
	return orderStatus;
}
public void setOrderStatus(String orderStatus) {
	this.orderStatus = orderStatus;
}
public String getPaymentStatus() {
	return paymentStatus;
}
public void setPaymentStatus(String paymentStatus) {
	this.paymentStatus = paymentStatus;
}
public String getSalesId() {
	return salesId;
}
public void setSalesId(String salesId) {
	this.salesId = salesId;
}
public String getTaxAmount() {
	return taxAmount;
}
public void setTaxAmount(String taxAmount) {
	this.taxAmount = taxAmount;
}
public String getTotalAmount() {
	return totalAmount;
}
public void setTotalAmount(String totalAmount) {
	this.totalAmount = totalAmount;
}
 


}
