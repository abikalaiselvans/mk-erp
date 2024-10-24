package com.my.org.erp.SmartInventory;

public class Term {
int termId;
String termName;
String termDes;
public Term(int termId, String termName,String termDes) {
	super();
	this.termId = termId;
	this.termName = termName;
	this.termDes=termDes;

}
public int getTermId() {
	return termId;
}
public void setTermId(int termId) {
	this.termId = termId;
}
public String getTermName() {
	return termName;
}
public void setTermName(String termName) {
	this.termName = termName;
}

public String getTermDes() {
	return termDes;
}
public void setTermDes(String termDes) {
	this.termDes = termDes;
}
	
}
