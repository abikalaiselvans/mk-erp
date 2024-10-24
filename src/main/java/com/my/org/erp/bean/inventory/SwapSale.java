package com.my.org.erp.bean.inventory;

public  final class SwapSale 
{
	String SwapSaleNo,company,branchId, customerId,saleDate,payment,memo;
	String ref ;
	String Shipping,shippingaddress,oref,dnote,dthru,destination,tdelivery,cdetails;
	String cnumber;
	String division;
	String noofpaymentcommitment;
	String byback="N",bybackdescription;
	String tcs="N";
	double tcsamount=0;
	double tcspercentage=0;
	String installation;
	String blockinvoice="N";
	String gststateid;
	double totals,totaldiscount,salestax,salestaxamount,nettotal,bybackamount;
	double roundedoption;
	String ref1,ref2,taxtype;
	int tax,commitmentdays,percentage,percentage1,percentage2;
	int project;
	String dcref;
	String cporeference;
	String addmetarget;
	double frieghtcharge;
	String discountbill="N";
	int shippingCustomerId;
	String manualsalesinvoicenumber;
	String roundoffcheck="N";
	
	public double getFrieghtcharge() {
		return frieghtcharge;
	}

	public void setFrieghtcharge(int frieghtcharge) {
		this.frieghtcharge = frieghtcharge;
	}

	public int getShippingCustomerId() {
		return shippingCustomerId;
	}

	public void setShippingCustomerId(int shippingCustomerId) {
		this.shippingCustomerId = shippingCustomerId;
	}

	public String getDiscountbill() {
		return discountbill;
	}

	public void setDiscountbill(String discountbill) {
		this.discountbill = discountbill;
	}

	public String getDcref() {
		return dcref;
	}

	public void setDcref(String dcref) {
		this.dcref = dcref;
	}

	public String getAddmetarget() {
		return addmetarget;
	}

	public void setAddmetarget(String addmetarget) {
		this.addmetarget = addmetarget;
	}

	public void setFrieghtcharge(double frieghtcharge) {
		this.frieghtcharge = frieghtcharge;
	}

	public String getCporeference() {
		return cporeference;
	}

	public void setCporeference(String cporeference) {
		this.cporeference = cporeference;
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

	public double getBybackamount() {
		return bybackamount;
	}

	public void setBybackamount(double bybackamount) {
		this.bybackamount = bybackamount;
	}

	public int getProject() {
		return project;
	}

	public void setProject(int project) {
		this.project = project;
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

	public String getTaxtype() {
		return taxtype;
	}

	public void setTaxtype(String taxtype) {
		this.taxtype = taxtype;
	}

	public int getCommitmentdays() {
		return commitmentdays;
	}

	public void setCommitmentdays(int commitmentdays) {
		this.commitmentdays = commitmentdays;
	}

	public int getPercentage() {
		return percentage;
	}

	public void setPercentage(int percentage) {
		this.percentage = percentage;
	}

	public int getPercentage1() {
		return percentage1;
	}

	public void setPercentage1(int percentage1) {
		this.percentage1 = percentage1;
	}

	public int getPercentage2() {
		return percentage2;
	}

	public void setPercentage2(int percentage2) {
		this.percentage2 = percentage2;
	}

	public String getBlockinvoice() 
	{
		return blockinvoice;
	}

	public void setBlockinvoice(String blockinvoice) {
		this.blockinvoice = blockinvoice;
	}

	public String getInstallation() {
		return installation;
	}

	public void setInstallation(String installation) {
		this.installation = installation;
	}

	public String getByback() {
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

	public SwapSale() {
		super();
		 
	}

	public String getBranchId() {
		return branchId;
	}

	public void setBranchId(String branchId) {
		this.branchId = branchId;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getCustomerId() {
		return customerId;
	}

	public void setCustomerId(String customerId) {
		this.customerId = customerId;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
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

	 

	public String getSwapSaleNo() {
		return SwapSaleNo;
	}

	public void setSwapSaleNo(String swapSaleNo) {
		SwapSaleNo = swapSaleNo;
	}

	 

	public String getCdetails() {
		return cdetails;
	}

	public void setCdetails(String cdetails) {
		this.cdetails = cdetails;
	}

	public String getDestination() {
		return destination;
	}

	public void setDestination(String destination) {
		this.destination = destination;
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

	public String getOref() {
		return oref;
	}

	public void setOref(String oref) {
		this.oref = oref;
	}

	public String getShipping() {
		return Shipping;
	}

	public void setShipping(String shipping) {
		Shipping = shipping;
	}

	public String getShippingaddress() {
		return shippingaddress;
	}

	public void setShippingaddress(String shippingaddress) {
		this.shippingaddress = shippingaddress;
	}

	public String getTdelivery() {
		return tdelivery;
	}

	public void setTdelivery(String tdelivery) {
		this.tdelivery = tdelivery;
	}

	public String getCnumber() {
		return cnumber;
	}

	public void setCnumber(String cnumber) {
		this.cnumber = cnumber;
	}

	public String getDivision() {
		return division;
	}

	public void setDivision(String division) {
		this.division = division;
	}

	public String getNoofpaymentcommitment() {
		return noofpaymentcommitment;
	}

	public void setNoofpaymentcommitment(String noofpaymentcommitment) {
		this.noofpaymentcommitment = noofpaymentcommitment;
	}

	public int getTax() {
		return tax;
	}

	public void setTax(int tax) {
		this.tax = tax;
	}

	public String getGststateid() {
		return gststateid;
	}

	public void setGststateid(String gststateid) {
		this.gststateid = gststateid;
	}

	public double getRoundedoption() {
		return roundedoption;
	}

	public void setRoundedoption(double roundedoption) {
		this.roundedoption = roundedoption;
	}

	public String getManualsalesinvoicenumber() {
		return manualsalesinvoicenumber;
	}

	public void setManualsalesinvoicenumber(String manualsalesinvoicenumber) {
		this.manualsalesinvoicenumber = manualsalesinvoicenumber;
	}

	public String getTcs() {
		return tcs;
	}

	public void setTcs(String tcs) {
		this.tcs = tcs;
	}

	public double getTcsamount() {
		return tcsamount;
	}

	public void setTcsamount(double tcsamount) {
		this.tcsamount = tcsamount;
	}

	public double getTcspercentage() {
		return tcspercentage;
	}

	public void setTcspercentage(double tcspercentage) {
		this.tcspercentage = tcspercentage;
	}

	public String getRoundoffcheck() {
		return roundoffcheck;
	}

	public void setRoundoffcheck(String roundoffcheck) {
		this.roundoffcheck = roundoffcheck;
	}

	 
	

}
