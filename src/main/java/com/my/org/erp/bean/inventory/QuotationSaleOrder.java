package com.my.org.erp.bean.inventory;

public  final class QuotationSaleOrder 
{
	 
	String quotationid,customerid,custponumber, saleby,saldate;
	String hold,billingto,shipingto,payment,memo,ref,totals;
	String totaldiscount,tax,salestaxamount,nettotal;
	String commitmentdays, division;
	String podate,deliverydate,cdetails,cnumber ;
	String descriptions,salestax  ;
	String multiplebill,partialbill,bankguarantee,delivery;
	String oref,dnote,dthru,destination,tdelivery,taxtype,project,multipleloaction,installation ;
	String  copyaddress;
	String ref1,ref2,blockinvoice,byback,bybackdescription ;
	String stocktype;
	
	String demurrage,demurragedate,poreceiveddate;
	double demurragepercentage;
	long percentage,percentage1,percentage2,demurragedays;
	double bybackamount;
	
	long cpostatus;
	
	
	
	public String getPoreceiveddate() {
		return poreceiveddate;
	}
	public void setPoreceiveddate(String poreceiveddate) {
		this.poreceiveddate = poreceiveddate;
	}
	public long getCpostatus() {
		return cpostatus;
	}
	public void setCpostatus(long cpostatus) {
		this.cpostatus = cpostatus;
	}
	public long getDemurragedays() {
		return demurragedays;
	}
	public void setDemurragedays(long demurragedays) {
		this.demurragedays = demurragedays;
	}
	public String getDemurrage() {
		return demurrage;
	}
	public void setDemurrage(String demurrage) {
		this.demurrage = demurrage;
	}
	public String getDemurragedate() {
		return demurragedate;
	}
	public void setDemurragedate(String demurragedate) {
		this.demurragedate = demurragedate;
	}
	public double getDemurragepercentage() {
		return demurragepercentage;
	}
	public void setDemurragepercentage(double demurragepercentage) {
		this.demurragepercentage = demurragepercentage;
	}
	public String getQuotationid() {
		return quotationid;
	}
	public void setQuotationid(String quotationid) {
		this.quotationid = quotationid;
	}
	public String getCustomerid() {
		return customerid;
	}
	public void setCustomerid(String customerid) {
		this.customerid = customerid;
	}
	public String getCustponumber() {
		return custponumber;
	}
	public void setCustponumber(String custponumber) {
		this.custponumber = custponumber;
	}
	public String getSaleby() {
		return saleby;
	}
	public void setSaleby(String saleby) {
		this.saleby = saleby;
	}
	public String getSaldate() {
		return saldate;
	}
	public void setSaldate(String saldate) {
		this.saldate = saldate;
	}
	public String getHold() {
		if(!"Y".equals(hold))
			hold ="N";
		return hold;
	}
	public void setHold(String hold) {
		this.hold = hold;
	}
	public String getBillingto() {
		return billingto;
	}
	public void setBillingto(String billingto) {
		this.billingto = billingto;
	}
	public String getShipingto() {
		return shipingto;
	}
	public void setShipingto(String shipingto) {
		this.shipingto = shipingto;
	}
	public String getPayment() {
		return payment;
	}
	public void setPayment(String payment) {
		this.payment = payment;
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
	public String getTotals() {
		return totals;
	}
	public void setTotals(String totals) {
		this.totals = totals;
	}
	public String getTotaldiscount() {
		return totaldiscount;
	}
	public void setTotaldiscount(String totaldiscount) {
		this.totaldiscount = totaldiscount;
	}
	public String getTax() {
		return tax;
	}
	public void setTax(String tax) {
		this.tax = tax;
	}
	public String getSalestaxamount() {
		return salestaxamount;
	}
	public void setSalestaxamount(String salestaxamount) {
		this.salestaxamount = salestaxamount;
	}
	public String getNettotal() {
		return nettotal;
	}
	public void setNettotal(String nettotal) {
		this.nettotal = nettotal;
	}
	public String getPodate() {
		return podate;
	}
	public void setPodate(String podate) {
		this.podate = podate;
	}
	public String getDeliverydate() {
		return deliverydate;
	}
	public void setDeliverydate(String deliverydate) {
		this.deliverydate = deliverydate;
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
	public String getDescriptions() {
		return descriptions;
	}
	public void setDescriptions(String descriptions) {
		this.descriptions = descriptions;
	}
	public String getSalestax() {
		return salestax;
	}
	public void setSalestax(String salestax) {
		this.salestax = salestax;
	}
	public String getCommitmentdays() {
		return commitmentdays;
	}
	public void setCommitmentdays(String commitmentdays) {
		this.commitmentdays = commitmentdays;
	}
	public String getDivision() {
		return division;
	}
	public void setDivision(String division) {
		this.division = division;
	}
	public String getOref() {
		return oref;
	}
	public void setOref(String oref) {
		this.oref = oref;
	}
	public String getDnote() {
		return dnote;
	}
	public void setDnote(String dnote) {
		this.dnote = dnote;
	}
	public String getDthru() {
		return dthru;
	}
	public void setDthru(String dthru) {
		this.dthru = dthru;
	}
	public String getDestination() {
		return destination;
	}
	public void setDestination(String destination) {
		this.destination = destination;
	}
	public String getTdelivery() {
		return tdelivery;
	}
	public void setTdelivery(String tdelivery) {
		this.tdelivery = tdelivery;
	}
	public String getTaxtype() {
		return taxtype;
	}
	public void setTaxtype(String taxtype) {
		this.taxtype = taxtype;
	}
	public String getProject() {
		return project;
	}
	public void setProject(String project) {
		this.project = project;
	}
	public String getMultipleloaction() {
		return multipleloaction;
	}
	public void setMultipleloaction(String multipleloaction) {
		this.multipleloaction = multipleloaction;
	}
	public String getInstallation() {
		return installation;
	}
	public void setInstallation(String installation) {
		this.installation = installation;
	}
	public String getMultiplebill() {
		return multiplebill;
	}
	public void setMultiplebill(String multiplebill) {
		this.multiplebill = multiplebill;
	}
	public String getPartialbill() {
		return partialbill;
	}
	public void setPartialbill(String partialbill) {
		this.partialbill = partialbill;
	}
	public String getBankguarantee() {
		return bankguarantee;
	}
	public void setBankguarantee(String bankguarantee) {
		this.bankguarantee = bankguarantee;
	}
	public String getDelivery() {
		return delivery;
	}
	public void setDelivery(String delivery) {
		this.delivery = delivery;
	}
	public String getCopyaddress() {
		
		if(!"Y".equals(copyaddress))
			copyaddress ="N";
		return copyaddress;
	}
	public void setCopyaddress(String copyaddress) {
		this.copyaddress = copyaddress;
	}
	public String getRef1() {
		return ref1;
	}
	public void setRef1(String ref1) {
		this.ref1 = ref1;
	}
	public String getRef2() {
		return ref2;
	}
	public void setRef2(String ref2) {
		this.ref2 = ref2;
	}
	public String getBlockinvoice() {
		if("".equals(blockinvoice ))
			blockinvoice ="N";
		return blockinvoice;
	}
	public void setBlockinvoice(String blockinvoice) {
		this.blockinvoice = blockinvoice;
	}
	public String getByback() {
		if("".equals(byback ))
			byback ="N";
		return byback;
	}
	public void setByback(String byback) {
		this.byback = byback;
	}
	public String getBybackdescription() {
		return bybackdescription;
	}
	public void setBybackdescription(String bybackdescription) {
		this.bybackdescription = bybackdescription;
	}
	public long getPercentage() {
		return percentage;
	}
	public void setPercentage(long percentage) {
		this.percentage = percentage;
	}
	public long getPercentage1() {
		return percentage1;
	}
	public void setPercentage1(long percentage1) {
		this.percentage1 = percentage1;
	}
	public long getPercentage2() {
		return percentage2;
	}
	public void setPercentage2(long percentage2) {
		this.percentage2 = percentage2;
	}
	public double getBybackamount() {
		return bybackamount;
	}
	public void setBybackamount(double bybackamount) {
		this.bybackamount = bybackamount;
	}
	public String getStocktype() {
		return stocktype;
	}
	public void setStocktype(String stocktype) {
		this.stocktype = stocktype;
	}
	
	 
	 
}
