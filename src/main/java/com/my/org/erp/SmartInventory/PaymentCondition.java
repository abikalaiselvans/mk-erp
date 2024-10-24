package com.my.org.erp.SmartInventory;

public class PaymentCondition {
int paytermId;
String payName;
String payDes;
public PaymentCondition(int paytermId, String payName,String payDes) {
	super();
	this.paytermId = paytermId;
	this.payName = payName;
	this.payDes=payDes;

}
public int getPayTermId() {
	return paytermId;
}
public void setPayTermId(int paytermId) {
	this.paytermId = paytermId;
}
public String getPayName() {
	return payName;
}
public void setPayName(String payName) {
	this.payName = payName;
}

public String getPayDes() {
	return payDes;
}
public void setPayDes(String payDes) {
	this.payDes = payDes;
}
	
}
