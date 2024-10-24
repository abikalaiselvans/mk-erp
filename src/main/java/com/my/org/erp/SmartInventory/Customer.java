package com.my.org.erp.SmartInventory;

public class Customer {

	String INT_BRANCHID,INT_CUSTOMERGROUPID,INT_CUSTOMERID;
	String DOU_CREDITLIMIT;
	String CHR_CUSTOMERNAME,CHR_LEGALNAME,CHR_STREET,CHR_CITY,CHR_STATE,CHR_POSTAL;
	String CHR_COUNTRY,CHR_AREACODE,CHR_PHONE,CHR_FAX,CHR_EMAIL,CHR_WEBSITE,INT_ACTIVE,DAT_SINCE;
	String CHR_ACCNO,CHR_BANKNAME,DOU_BALANCE,DAT_BALANCEASOF;
	public Customer() {
		super();
		 
	}
	public Customer(String int_branchid, String int_customergroupid, String int_customerid, String dou_creditlimit, String chr_customername, String chr_legalname, String chr_street, String chr_city, String chr_state, String chr_postal, String chr_country, String chr_areacode, String chr_phone, String chr_fax, String chr_email, String chr_website, String int_active, String dat_since, String chr_accno, String chr_bankname, String dou_balance, String dat_balanceasof) {
		super();
		INT_BRANCHID = int_branchid;
		INT_CUSTOMERGROUPID = int_customergroupid;
		INT_CUSTOMERID = int_customerid;
		DOU_CREDITLIMIT = dou_creditlimit;
		CHR_CUSTOMERNAME = chr_customername;
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
		INT_ACTIVE = int_active;
		DAT_SINCE = dat_since;
		CHR_ACCNO = chr_accno;
		CHR_BANKNAME = chr_bankname;
		DOU_BALANCE = dou_balance;
		DAT_BALANCEASOF = dat_balanceasof;
	}
	public String getCHR_ACCNO() {
		return CHR_ACCNO;
	}
	public void setCHR_ACCNO(String chr_accno) {
		CHR_ACCNO = chr_accno;
	}
	public String getCHR_AREACODE() {
		return CHR_AREACODE;
	}
	public void setCHR_AREACODE(String chr_areacode) {
		CHR_AREACODE = chr_areacode;
	}
	public String getCHR_BANKNAME() {
		return CHR_BANKNAME;
	}
	public void setCHR_BANKNAME(String chr_bankname) {
		CHR_BANKNAME = chr_bankname;
	}
	public String getCHR_CITY() {
		return CHR_CITY;
	}
	public void setCHR_CITY(String chr_city) {
		CHR_CITY = chr_city;
	}
	public String getCHR_COUNTRY() {
		return CHR_COUNTRY;
	}
	public void setCHR_COUNTRY(String chr_country) {
		CHR_COUNTRY = chr_country;
	}
	public String getCHR_CUSTOMERNAME() {
		return CHR_CUSTOMERNAME;
	}
	public void setCHR_CUSTOMERNAME(String chr_customername) {
		CHR_CUSTOMERNAME = chr_customername;
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
	public String getCHR_WEBSITE() {
		return CHR_WEBSITE;
	}
	public void setCHR_WEBSITE(String chr_website) {
		CHR_WEBSITE = chr_website;
	}
	public String getDAT_BALANCEASOF() {
		return DAT_BALANCEASOF;
	}
	public void setDAT_BALANCEASOF(String dat_balanceasof) {
		DAT_BALANCEASOF = dat_balanceasof;
	}
	public String getDAT_SINCE() {
		return DAT_SINCE;
	}
	public void setDAT_SINCE(String dat_since) {
		DAT_SINCE = dat_since;
	}
	public String getDOU_BALANCE() {
		return DOU_BALANCE;
	}
	public void setDOU_BALANCE(String dou_balance) {
		DOU_BALANCE = dou_balance;
	}
	public String getDOU_CREDITLIMIT() {
		return DOU_CREDITLIMIT;
	}
	public void setDOU_CREDITLIMIT(String dou_creditlimit) {
		DOU_CREDITLIMIT = dou_creditlimit;
	}
	public String getINT_ACTIVE() {
		return INT_ACTIVE;
	}
	public void setINT_ACTIVE(String int_active) {
		INT_ACTIVE = int_active;
	}
	public String getINT_BRANCHID() {
		return INT_BRANCHID;
	}
	public void setINT_BRANCHID(String int_branchid) {
		INT_BRANCHID = int_branchid;
	}
	public String getINT_CUSTOMERGROUPID() {
		return INT_CUSTOMERGROUPID;
	}
	public void setINT_CUSTOMERGROUPID(String int_customergroupid) {
		INT_CUSTOMERGROUPID = int_customergroupid;
	}
	public String getINT_CUSTOMERID() {
		return INT_CUSTOMERID;
	}
	public void setINT_CUSTOMERID(String int_customerid) {
		INT_CUSTOMERID = int_customerid;
	}
	
	
}