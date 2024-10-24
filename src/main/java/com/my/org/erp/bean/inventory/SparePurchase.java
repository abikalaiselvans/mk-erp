package com.my.org.erp.bean.inventory;

public  final class SparePurchase 
{
	String company,branchId,cashSaleNo,vendorid,saleDate,payment,memo;
	String ref,totals,totaldiscount,tax,salestax,salestaxamount,nettotal;
	String division;
	

	public SparePurchase() 
	{
		super();
		 
	}
	public String getBranchId() {
		return branchId;
	}
	public void setBranchId(String branchId) {
		this.branchId = branchId;
	}
	public String getCashSaleNo() {
		return cashSaleNo;
	}
	public void setCashSaleNo(String cashSaleNo) {
		this.cashSaleNo = cashSaleNo;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public String getNettotal() {
		return nettotal;
	}
	public void setNettotal(String nettotal) {
		this.nettotal = nettotal;
	}
	public String getPayment() {
		return payment;
	}
	public void setPayment(String payment) {
		this.payment = payment;
	}
	public String getRef() {
		return ref;
	}
	public void setRef(String ref) {
		this.ref = ref;
	}
	public String getSaleDate() {
		return saleDate;
	}
	public void setSaleDate(String saleDate) {
		this.saleDate = saleDate;
	}
	public String getSalestax() {
		return salestax;
	}
	public void setSalestax(String salestax) {
		this.salestax = salestax;
	}
	public String getSalestaxamount() {
		return salestaxamount;
	}
	public void setSalestaxamount(String salestaxamount) {
		this.salestaxamount = salestaxamount;
	}
	public String getTax() {
		return tax;
	}
	public void setTax(String tax) {
		this.tax = tax;
	}
	public String getTotaldiscount() {
		return totaldiscount;
	}
	public void setTotaldiscount(String totaldiscount) {
		this.totaldiscount = totaldiscount;
	}
	public String getTotals() {
		return totals;
	}
	public void setTotals(String totals) {
		this.totals = totals;
	}
	public String getVendorid() {
		return vendorid;
	}
	public void setVendorid(String vendorid) {
		this.vendorid = vendorid;
	}
	public String getDivision() {
		return division;
	}
	public void setDivision(String division) {
		this.division = division;
	}
	 
	 

}
