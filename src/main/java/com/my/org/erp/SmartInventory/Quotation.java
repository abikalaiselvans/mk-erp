package com.my.org.erp.SmartInventory;

public class Quotation {

	String quotationId,quotationNo,des,customerName;
	String order,ship;
	String quoDate,reqDate,hold ,memo,ref;
	String cdetails;
	long payment,customerId,conditionId,taxId,division,cnumber;
	String copyaddress;
	boolean onhold,quotationStatus;
	double amount,taxAmount,totAmount,credit;	
	double totals,totaldiscount,tax,salestax,salestaxamount,nettotal;
	public String getQuotationNo() {
		return quotationNo;
	}
	public void setQuotationNo(String quotationNo) {
		this.quotationNo = quotationNo;
	}
	public String getDes() {
		return des;
	}
	public void setDes(String des) {
		this.des = des;
	}
	public String getCustomerName() {
		return customerName;
	}
	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}
	public String getOrder() {
		return order;
	}
	public void setOrder(String order) {
		this.order = order;
	}
	public String getShip() {
		return ship;
	}
	public void setShip(String ship) {
		this.ship = ship;
	}
	public String getQuoDate() {
		return quoDate;
	}
	public void setQuoDate(String quoDate) {
		this.quoDate = quoDate;
	}
	public String getReqDate() {
		return reqDate;
	}
	public void setReqDate(String reqDate) {
		this.reqDate = reqDate;
	}
	public String getHold() {
		if(!"Y".equals(hold))
			hold ="N";
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
	public String getRef() {
		return ref;
	}
	public void setRef(String ref) {
		this.ref = ref;
	}
	 
	public String getQuotationId() {
		return quotationId;
	}
	public void setQuotationId(String quotationId) {
		this.quotationId = quotationId;
	}
	public long getPayment() {
		return payment;
	}
	public void setPayment(long payment) {
		this.payment = payment;
	}
	public long getCustomerId() {
		return customerId;
	}
	public void setCustomerId(long customerId) {
		this.customerId = customerId;
	}
	public long getConditionId() {
		return conditionId;
	}
	public void setConditionId(long conditionId) {
		this.conditionId = conditionId;
	}
	public long getTaxId() {
		return taxId;
	}
	public void setTaxId(long taxId) {
		this.taxId = taxId;
	}
	public long getDivision() {
		return division;
	}
	public void setDivision(long division) {
		this.division = division;
	}
	public boolean isOnhold() {
		return onhold;
	}
	public void setOnhold(boolean onhold) {
		this.onhold = onhold;
	}
	public boolean isQuotationStatus() {
		return quotationStatus;
	}
	public void setQuotationStatus(boolean quotationStatus) {
		this.quotationStatus = quotationStatus;
	}
	public double getAmount() {
		return amount;
	}
	public void setAmount(double amount) {
		this.amount = amount;
	}
	public double getTaxAmount() {
		return taxAmount;
	}
	public void setTaxAmount(double taxAmount) {
		this.taxAmount = taxAmount;
	}
	public double getTotAmount() {
		return totAmount;
	}
	public void setTotAmount(double totAmount) {
		this.totAmount = totAmount;
	}
	public double getCredit() {
		return credit;
	}
	public void setCredit(double credit) {
		this.credit = credit;
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
		return Math.round(nettotal);
	}
	public void setNettotal(double nettotal) {
		this.nettotal = nettotal;
	}
	public String getCdetails() {
		return cdetails;
	}
	public void setCdetails(String cdetails) {
		this.cdetails = cdetails;
	}
	public long getCnumber() {
		return cnumber;
	}
	public void setCnumber(long cnumber) {
		this.cnumber = cnumber;
	}
	public String getCopyaddress() 
	{
		if(!"Y".equals(copyaddress))
			copyaddress ="N";
		return copyaddress;
	}
	public void setCopyaddress(String copyaddress) {
		this.copyaddress = copyaddress;
	}
	
}
