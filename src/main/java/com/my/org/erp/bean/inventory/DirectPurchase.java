package com.my.org.erp.bean.inventory;

public  final class DirectPurchase 
{
	String cashSaleNo,saleDate,memo;
	String ref;
	String purchaserequest;
	String basevaluecheck;
	long company,branchId,vendorid,payment,division;
	double basevalue,frieghtcharge,roundedoption;
	double frieghtamount,frieghttax;
	double totals,totaldiscount,tax,salestax,salestaxamount,nettotal;
	public String getCashSaleNo() {
		return cashSaleNo;
	}
	public void setCashSaleNo(String cashSaleNo) {
		this.cashSaleNo = cashSaleNo;
	}
	public String getSaleDate() {
		return saleDate;
	}
	public void setSaleDate(String saleDate) {
		this.saleDate = saleDate;
	}
	public String getMemo() {
		return memo;
	}
	public double getRoundedoption() {
		return roundedoption;
	}
	public void setRoundedoption(double roundedoption) {
		this.roundedoption = roundedoption;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public String getRef() {
		return ref;
	}
	public void setRef(String ref) {
		this.ref = ref;
	}
	public String getPurchaserequest() {
		return purchaserequest;
	}
	public void setPurchaserequest(String purchaserequest) {
		this.purchaserequest = purchaserequest;
	}
	public String getBasevaluecheck() {
		if(!"Y".equals(basevaluecheck ))
			basevaluecheck="N";
		
		return basevaluecheck;
	}
	public void setBasevaluecheck(String basevaluecheck) {
		this.basevaluecheck = basevaluecheck;
	}
	public long getCompany() {
		return company;
	}
	public void setCompany(long company) {
		this.company = company;
	}
	public long getBranchId() {
		return branchId;
	}
	public void setBranchId(long branchId) {
		this.branchId = branchId;
	}
	public long getVendorid() {
		return vendorid;
	}
	public void setVendorid(long vendorid) {
		this.vendorid = vendorid;
	}
	 
	public long getPayment() {
		return payment;
	}
	public void setPayment(long payment) {
		this.payment = payment;
	}
	public long getDivision() {
		return division;
	}
	public void setDivision(long division) {
		this.division = division;
	}
	public double getBasevalue() {
		return basevalue;
	}
	public void setBasevalue(double basevalue) {
		this.basevalue = basevalue;
	}
	public double getFrieghtcharge() {
		return frieghtcharge;
	}
	public void setFrieghtcharge(double frieghtcharge) {
		this.frieghtcharge = frieghtcharge;
	}
	public double getTotals() {
		return totals;
	}
	public void setTotals(double totals) {
		this.totals = totals;
	}
	public double getTotaldiscount() {
		return totaldiscount;
	}
	public void setTotaldiscount(double totaldiscount) {
		this.totaldiscount = totaldiscount;
	}
	public double getTax() {
		return tax;
	}
	public void setTax(double tax) {
		this.tax = tax;
	}
	public double getSalestax() {
		return salestax;
	}
	public void setSalestax(double salestax) {
		this.salestax = salestax;
	}
	public double getSalestaxamount() {
		return salestaxamount;
	}
	public void setSalestaxamount(double salestaxamount) {
		this.salestaxamount = salestaxamount;
	}
	public double getNettotal() {
		return nettotal;
	}
	public void setNettotal(double nettotal) {
		this.nettotal = nettotal;
	}
	public double getFrieghtamount() {
		return frieghtamount;
	}
	public void setFrieghtamount(double frieghtamount) {
		this.frieghtamount = frieghtamount;
	}
	public double getFrieghttax() {
		return frieghttax;
	}
	public void setFrieghttax(double frieghttax) {
		this.frieghttax = frieghttax;
	}
	
	 
}
