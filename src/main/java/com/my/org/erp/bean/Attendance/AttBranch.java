package com.my.org.erp.bean.Attendance;

public  final  class AttBranch {
   int INT_BRANCHID;
   String CHR_BRANCHNAME,CHR_LEGALNAME,CHR_STREET,CHR_CITY,CHR_STATE,CHR_POSTAL,CHR_COUNTRY,CHR_AREACODE,CHR_PHONE;
   String CHR_FAX,CHR_EMAIL,CHR_WEBSITE,CHR_TNGSTNO,CHR_CSTNO,CHR_REGNO,CHR_TINNO;
   
public AttBranch(int int_branchid, String chr_branchname, String chr_legalname, String chr_street, String chr_city, String chr_state, String chr_postal, String chr_country, String chr_areacode, String chr_phone, String chr_fax, String chr_email, String chr_website, String chr_tngstno, String chr_cstno, String chr_regno, String chr_tinno)
{
	super();
	INT_BRANCHID = int_branchid;
	CHR_BRANCHNAME = chr_branchname;
	CHR_LEGALNAME = chr_legalname;
	CHR_STREET = chr_street;
	CHR_CITY = chr_city;
	CHR_STATE = chr_state;
	CHR_POSTAL = chr_postal;
	CHR_COUNTRY = chr_country;
	CHR_AREACODE = chr_areacode;
	CHR_PHONE = chr_phone;
	CHR_FAX = chr_fax;
	CHR_EMAIL = chr_email;
	CHR_WEBSITE = chr_website;
	CHR_TNGSTNO = chr_tngstno;
	CHR_CSTNO = chr_cstno;
	CHR_REGNO = chr_regno;
	CHR_TINNO = chr_tinno;
}

public AttBranch(int int_branchid, String chr_branchname) {
	super();
	INT_BRANCHID = int_branchid;
	CHR_BRANCHNAME = chr_branchname;
}

public String getCHR_AREACODE() {
	return CHR_AREACODE;
}
public void setCHR_AREACODE(String chr_areacode) {
	CHR_AREACODE = chr_areacode;
}
public String getCHR_CITY() {
	return CHR_CITY;
}
public void setCHR_CITY(String chr_city) {
	CHR_CITY = chr_city;
}
public String getCHR_BRANCHNAME() {
	return CHR_BRANCHNAME;
}
public void setCHR_stateNAME(String chr_branchname) {
	CHR_BRANCHNAME= chr_branchname;
}
public String getCHR_COUNTRY() {
	return CHR_COUNTRY;
}
public void setCHR_COUNTRY(String chr_country) {
	CHR_COUNTRY = chr_country;
}
public String getCHR_CSTNO() {
	return CHR_CSTNO;
}
public void setCHR_CSTNO(String chr_cstno) {
	CHR_CSTNO = chr_cstno;
}
public String getCHR_EMAIL() {
	return CHR_EMAIL;
}
public void setCHR_EMAIL(String chr_email) {
	CHR_EMAIL = chr_email;
}
public String getCHR_FAX() {
	return CHR_FAX;
}
public void setCHR_FAX(String chr_fax) {
	CHR_FAX = chr_fax;
}
public String getCHR_LEGALNAME() {
	return CHR_LEGALNAME;
}
public void setCHR_LEGALNAME(String chr_legalname) {
	CHR_LEGALNAME = chr_legalname;
}
public String getCHR_PHONE() {
	return CHR_PHONE;
}
public void setCHR_PHONE(String chr_phone) {
	CHR_PHONE = chr_phone;
}
public String getCHR_POSTAL() {
	return CHR_POSTAL;
}
public void setCHR_POSTAL(String chr_postal) {
	CHR_POSTAL = chr_postal;
}
public String getCHR_REGNO() {
	return CHR_REGNO;
}
public void setCHR_REGNO(String chr_regno) {
	CHR_REGNO = chr_regno;
}
public String getCHR_STATE() {
	return CHR_STATE;
}
public void setCHR_STATE(String chr_state) {
	CHR_STATE = chr_state;
}
public String getCHR_STREET() {
	return CHR_STREET;
}
public void setCHR_STREET(String chr_street) {
	CHR_STREET = chr_street;
}
public String getCHR_TINNO() {
	return CHR_TINNO;
}
public void setCHR_TINNO(String chr_tinno) {
	CHR_TINNO = chr_tinno;
}
public String getCHR_TNGSTNO() {
	return CHR_TNGSTNO;
}
public void setCHR_TNGSTNO(String chr_tngstno) {
	CHR_TNGSTNO = chr_tngstno;
}
public String getCHR_WEBSITE() {
	return CHR_WEBSITE;
}
public void setCHR_WEBSITE(String chr_website) {
	CHR_WEBSITE = chr_website;
}

public int getINT_BRANCHID() {
	return INT_BRANCHID;
}
public void setINT_BRANCHID(int int_branchid) {
	INT_BRANCHID = int_branchid;
}
   
}
