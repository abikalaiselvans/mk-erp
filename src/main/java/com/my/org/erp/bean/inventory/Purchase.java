package com.my.org.erp.bean.inventory;

public  final class Purchase 
{
	String ponumber,vendorid,orderdate,requestdate,payment,paymentterm,hold;
	String order,ship,duedt,memo,ref,totals,totaldiscount,tax,salestax,nettotal;
	String division;
	String purchaserequest ;
	String verified;
	long frieghtcharge;
	public Purchase() {
		super();
		 
	}
	public String getDuedt() {
		return duedt;
	}
	public void setDuedt(String duedt) {
		this.duedt = duedt;
	}
	public String getHold() {
		if(!"1".equals(hold))
			hold ="0";
		return hold;
	}
	public void setHold(String hold) {
		this.hold = hold;
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
	public String getOrder() {
		return order;
	}
	public void setOrder(String order) {
		this.order = order;
	}
	public String getOrderdate() {
		return orderdate;
	}
	public void setOrderdate(String orderdate) {
		this.orderdate = orderdate;
	}
	public String getPayment() {
		return payment;
	}
	public void setPayment(String payment) {
		this.payment = payment;
	}
	public String getPaymentterm() {
		return paymentterm;
	}
	public void setPaymentterm(String paymentterm) {
		this.paymentterm = paymentterm;
	}
	public String getPonumber() {
		return ponumber;
	}
	public void setPonumber(String ponumber) {
		this.ponumber = ponumber;
	}
	public String getRef() {
		return ref;
	}
	public void setRef(String ref) {
		this.ref = ref;
	}
	public String getRequestdate() {
		return requestdate;
	}
	public void setRequestdate(String requestdate) {
		this.requestdate = requestdate;
	}
	public String getSalestax() {
		return salestax;
	}
	public void setSalestax(String salestax) {
		this.salestax = salestax;
	}
	public String getShip() {
		return ship;
	}
	public void setShip(String ship) {
		this.ship = ship;
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
	public String getPurchaserequest() {
		return purchaserequest;
	}
	public void setPurchaserequest(String purchaserequest) {
		this.purchaserequest = purchaserequest;
	}
	public long getFrieghtcharge() {
		return frieghtcharge;
	}
	public void setFrieghtcharge(long frieghtcharge) {
		this.frieghtcharge = frieghtcharge;
	}
	public String getVerified() {
		if(!"Y".equals(verified))
			verified = "N";
		return verified;
	}
	public void setVerified(String verified) {
		this.verified = verified;
	}
	
}
