package com.my.org.erp.bean.inventory;

import com.my.org.erp.ServiceLogin.DateUtil;


public  final class CustomerInfo 
{
	 
	String customergroup,cperson, address1,address2,address3,street ;
	String email,website,doh,accno  ;
	String status ;
	String balanceasof=null;
	String tinnumber;
	String cstnumber,pannumber;
	long custid,city,district,state,country,pin;
	String area,phone,mobile,fax;
	long bank,customertype;
	double climit, balance ;
	String verified="N";
	String alias;
	String department;
	String billing,billingaddress;
	String taxexamption,taxexamptionno;
	String gst;
	String accounttype;
	public String getAlias() {
		return alias;
	}
	public void setAlias(String alias) {
		this.alias = alias;
	}
	public String getVerified() {
		if(!"Y".equals(verified))
			verified="N";
		return verified;
	}
	public void setVerified(String verified) {
		this.verified = verified;
	}
	public String getCustomergroup() {
		return customergroup;
	}
	public void setCustomergroup(String customergroup) {
		this.customergroup = customergroup;
	}
	public String getCperson() {
		return cperson.replaceAll("&", " AND ").toUpperCase();
	}
	public void setCperson(String cperson) {
		this.cperson = cperson;
	}
	 
	public String getStreet() {
		return street;
	}
	public void setStreet(String street) {
		this.street = street;
	}
	public String getAddress1() {
		return address1;
	}
	public void setAddress1(String address1) {
		this.address1 = address1;
	}
	public String getAddress2() {
		return address2;
	}
	public void setAddress2(String address2) {
		this.address2 = address2;
	}
	public String getAddress3() {
		return address3;
	}
	public void setAddress3(String address3) {
		this.address3 = address3;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getWebsite() {
		return website;
	}
	public void setWebsite(String website) {
		this.website = website;
	}
	public String getDoh() {
		 if(doh.length()>6)
			return DateUtil.FormateDateSQL(doh);
		else 
			return null;
	}
	public void setDoh(String doh) {
		this.doh = doh;
	}
	public String getAccno() {
		return accno;
	}
	public void setAccno(String accno) {
		this.accno = accno;
	}
	public String getStatus() 
	{
		if(!"1".equals(status))
			status="0";
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getBalanceasof() 
	{
		if(balanceasof.length()>6)
			return DateUtil.FormateDateSQL(balanceasof);
		else 
			return null;
	}
	public void setBalanceasof(String balanceasof) {
		this.balanceasof = balanceasof;
	}
	public String getTinnumber() {
		return tinnumber;
	}
	public void setTinnumber(String tinnumber) {
		this.tinnumber = tinnumber;
	}
	public String getCstnumber() {
		return cstnumber;
	}
	public void setCstnumber(String cstnumber) {
		this.cstnumber = cstnumber;
	}
	public long getCustid() {
		return custid;
	}
	public void setCustid(long custid) {
		this.custid = custid;
	}
	public long getCity() {
		return city;
	}
	public void setCity(long city) {
		this.city = city;
	}
	public long getDistrict() {
		return district;
	}
	public void setDistrict(long district) {
		this.district = district;
	}
	public long getState() {
		return state;
	}
	public void setState(long state) {
		this.state = state;
	}
	public long getCountry() {
		return country;
	}
	public void setCountry(long country) {
		this.country = country;
	}
	public long getPin() {
		return pin;
	}
	public void setPin(long pin) {
		this.pin = pin;
	}
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getFax() {
		return fax;
	}
	public void setFax(String fax) {
		this.fax = fax;
	}
	public long getBank() {
		return bank;
	}
	public void setBank(long bank) {
		this.bank = bank;
	}
	public long getCustomertype() {
		return customertype;
	}
	public void setCustomertype(long customertype) {
		this.customertype = customertype;
	}
	public double getClimit() {
		return climit;
	}
	public void setClimit(double climit) {
		this.climit = climit;
	}
	public double getBalance() {
		return balance;
	}
	public void setBalance(double balance) {
		this.balance = balance;
	}
	public String getPannumber() {
		return pannumber;
	}
	public void setPannumber(String pannumber) {
		this.pannumber = pannumber;
	}
	public String getDepartment() {
		return department;
	}
	public void setDepartment(String department) {
		this.department = department;
	}
	public String getBilling() {
		return billing;
	}
	public void setBilling(String billing) {
		this.billing = billing;
	}
	public String getBillingaddress() {
		return billingaddress;
	}
	public void setBillingaddress(String billingaddress) {
		this.billingaddress = billingaddress;
	}
	public String getTaxexamption() {
		return taxexamption;
	}
	public void setTaxexamption(String taxexamption) {
		this.taxexamption = taxexamption;
	}
	public String getTaxexamptionno() {
		return taxexamptionno;
	}
	public void setTaxexamptionno(String taxexamptionno) {
		this.taxexamptionno = taxexamptionno;
	}
	public String getGst() {
		return gst;
	}
	public void setGst(String gst) {
		this.gst = gst;
	}
	public String getAccounttype() {
		return accounttype;
	}
	public void setAccounttype(String accounttype) {
		this.accounttype = accounttype;
	}
	
	
	 
}
