package com.my.org.erp.SmartInventory;

public class ItemGroup {
int proGroupId;
String proGroupName;
public ItemGroup(int proGroupId, String proGroupName) {
	super();
	this.proGroupId = proGroupId;
	this.proGroupName = proGroupName;
}
public int getproGroupId() {
	return proGroupId;
}
public void setproGroupId(int termId) {
	this.proGroupId = termId;
}
public String proGroupName() {
	return proGroupName;
}
public void setproGroupName(String proGroupName) {
	this.proGroupName = proGroupName;
}	
}
