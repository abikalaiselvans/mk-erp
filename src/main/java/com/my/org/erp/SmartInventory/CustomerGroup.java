package com.my.org.erp.SmartInventory;

public class CustomerGroup {
int cusGroupId;
String cusGroupName;
public CustomerGroup(int cusGroupId, String cusGroupName) {
	super();
	this.cusGroupId = cusGroupId;
	this.cusGroupName = cusGroupName;
}
public int getcusGroupId() {
	return cusGroupId;
}
public void setcusGroupId(int termId) {
	this.cusGroupId = termId;
}
public String cusGroupName() {
	return cusGroupName;
}
public void setcusGroupName(String cusGroupName) {
	this.cusGroupName = cusGroupName;
}	
}
