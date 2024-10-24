package com.my.org.erp.SmartInventory;

import com.my.org.erp.ServiceLogin.DateUtil;

public class SpareDemand 
{
	long  rowid[] ;
	long id;
	String 	memo,callnumber,demanddate,despatchlocation,filename,actionS,productserialnumber;
	String customer,customeraddress,calltype;
	public String getProductserialnumber() {
		return productserialnumber;
	}
	public void setProductserialnumber(String productserialnumber) {
		this.productserialnumber = productserialnumber;
	}
	 
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public String getCallnumber() {
		return callnumber;
	}
	public void setCallnumber(String callnumber) {
		this.callnumber = callnumber;
	}
	public String getDemanddate() 
	{
		if(demanddate.length()>6)
			return DateUtil.FormateDateandTimeSQL(demanddate);
		else 
			return null;
	}
	public void setDemanddate(String demanddate) {
		this.demanddate = demanddate;
	}
	public String getDespatchlocation() {
		return despatchlocation;
	}
	public void setDespatchlocation(String despatchlocation) {
		this.despatchlocation = despatchlocation;
	}
	public long[] getRowid() {
		return rowid;
	}
	public void setRowid(long[] rowid) {
		this.rowid = rowid;
	}
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getActionS() {
		return actionS;
	}
	public void setActionS(String actionS) {
		this.actionS = actionS;
	}
	public String getCustomer() {
		return customer;
	}
	public void setCustomer(String customer) {
		this.customer = customer;
	}
	public String getCustomeraddress() {
		return customeraddress;
	}
	public void setCustomeraddress(String customeraddress) {
		this.customeraddress = customeraddress;
	}
	public String getCalltype() {
		return calltype;
	}
	public void setCalltype(String calltype) {
		this.calltype = calltype;
	}
	
	
	
}
