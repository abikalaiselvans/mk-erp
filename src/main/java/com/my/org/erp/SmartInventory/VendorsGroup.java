package com.my.org.erp.SmartInventory;

public class VendorsGroup {
int venGroupId;
String venGroupName;
public VendorsGroup(int venGroupId, String venGroupName) {
	super();
	this.venGroupId = venGroupId;
	this.venGroupName = venGroupName;
}
public int getvenGroupId() {
	return venGroupId;
}
public void setvenGroupId(int termId) {
	this.venGroupId = termId;
}
public String venGroupName() {
	return venGroupName;
}
public void setvenGroupName(String venGroupName) {
	this.venGroupName = venGroupName;
}	
}
