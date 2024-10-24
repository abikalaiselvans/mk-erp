package com.my.org.erp.bean.inventory;

public  final class Quotation 
{
	 
	String quoNumber,customerId,quoDate,reqDate,payment,hold ;
	String order,ship,memo,ref,totals,totaldiscount,tax,salestax,salestaxamount,nettotal;
	String quotationId; 
	String cdetails,cnumber;
	public Quotation() {
		super();
		 
	}

	public String getCustomerId() {
		return customerId;
	}

	public void setCustomerId(String customerId) {
		this.customerId = customerId;
	}

	public String getHold() {
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

	public String getPayment() {
		return payment;
	}

	public void setPayment(String payment) {
		this.payment = payment;
	}

	public String getQuoDate() {
		return quoDate;
	}

	public void setQuoDate(String quoDate) {
		this.quoDate = quoDate;
	}

	public String getQuoNumber() {
		return quoNumber;
	}

	public void setQuoNumber(String quoNumber) {
		this.quoNumber = quoNumber;
	}

	public String getRef() {
		return ref;
	}

	public void setRef(String ref) {
		this.ref = ref;
	}

	public String getReqDate() {
		return reqDate;
	}

	public void setReqDate(String reqDate) {
		this.reqDate = reqDate;
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

	public String getQuotationId() {
		return quotationId;
	}

	public void setQuotationId(String quotationId) {
		this.quotationId = quotationId;
	}

	public String getCdetails() {
		return cdetails;
	}

	public void setCdetails(String cdetails) {
		this.cdetails = cdetails;
	}

	public String getCnumber() {
		return cnumber;
	}

	public void setCnumber(String cnumber) {
		this.cnumber = cnumber;
	}
	 

}
