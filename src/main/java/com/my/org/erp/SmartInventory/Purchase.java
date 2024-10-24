package com.my.org.erp.SmartInventory;

public class Purchase {
	String INT_VENDORID,INT_PURCHASEORDERID,CHR_VENDORNAME,DAT_REQUESTDATE,INT_PAYMENTTERMID;
	String DOU_AMOUNT,DOU_TAXAMOUNT,DOU_TOTALAMOUNT,INT_PURCHASESTATUS,INT_PAYMENTSTATUS;
	
	public Purchase() {
		super();
		 
	}
	public String getCHR_VENDORNAME() {
		return CHR_VENDORNAME;
	}
	public void setCHR_VENDORNAME(String chr_vendorname) {
		CHR_VENDORNAME = chr_vendorname;
	}
	public String getDAT_REQUESTDATE() {
		return DAT_REQUESTDATE;
	}
	public void setDAT_REQUESTDATE(String dat_requestdate) {
		DAT_REQUESTDATE = dat_requestdate;
	}
	public String getDOU_AMOUNT() {
		return DOU_AMOUNT;
	}
	public void setDOU_AMOUNT(String dou_amount) {
		DOU_AMOUNT = dou_amount;
	}
	public String getDOU_TAXAMOUNT() {
		return DOU_TAXAMOUNT;
	}
	public void setDOU_TAXAMOUNT(String dou_taxamount) {
		DOU_TAXAMOUNT = dou_taxamount;
	}
	public String getDOU_TOTALAMOUNT() {
		return DOU_TOTALAMOUNT;
	}
	public void setDOU_TOTALAMOUNT(String dou_totalamount) {
		DOU_TOTALAMOUNT = dou_totalamount;
	}
	public String getINT_PAYMENTSTATUS() {
		return INT_PAYMENTSTATUS;
	}
	public void setINT_PAYMENTSTATUS(String int_paymentstatus) {
		INT_PAYMENTSTATUS = int_paymentstatus;
	}
	public String getINT_PAYMENTTERMID() {
		return INT_PAYMENTTERMID;
	}
	public void setINT_PAYMENTTERMID(String int_paymenttermid) {
		INT_PAYMENTTERMID = int_paymenttermid;
	}
	public String getINT_PURCHASEORDERID() {
		return INT_PURCHASEORDERID;
	}
	public void setINT_PURCHASEORDERID(String int_purchaseorderid) {
		INT_PURCHASEORDERID = int_purchaseorderid;
	}
	public String getINT_PURCHASESTATUS() {
		return INT_PURCHASESTATUS;
	}
	public void setINT_PURCHASESTATUS(String int_purchasestatus) {
		INT_PURCHASESTATUS = int_purchasestatus;
	}
	public String getINT_VENDORID() {
		return INT_VENDORID;
	}
	public void setINT_VENDORID(String int_vendorid) {
		INT_VENDORID = int_vendorid;
	}
  
}
