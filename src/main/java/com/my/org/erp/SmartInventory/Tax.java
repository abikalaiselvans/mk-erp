package com.my.org.erp.SmartInventory;

public class Tax{
int taxId;
String taxName;
String taxDes;
double taxValue;
public Tax(int taxId, String taxName, String taxDes, double taxValue) {
	super();
	this.taxId = taxId;
	this.taxName = taxName;
	this.taxDes = taxDes;
	this.taxValue = taxValue;
}
public String getTaxDes() {
	return taxDes;
}
public void setTaxDes(String taxDes) {
	this.taxDes = taxDes;
}
public int getTaxId() {
	return taxId;
}
public void setTaxId(int taxId) {
	this.taxId = taxId;
}
public String getTaxName() {
	return taxName;
}
public void setTaxName(String taxName) {
	this.taxName = taxName;
}
public double getTaxValue() {
	return taxValue;
}
public void setTaxValue(double taxValue) {
	this.taxValue = taxValue;
}
}
