package com.my.org.erp.bean.SmartMarketing;

public class CustomerInfo 
{
	 
	long rowid,group,cname,city,district,state,country,pincode;
	long areacode,phone1,extn1,phone2,extn2,mobile1,mobile2,fax;
	String salute,name,salute1,name1,alias,alias1,desigination1,desigination2;
	String address1,address2,address3,email,website;
	String  active,verification,memo;

	
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public String getSalute() {
		return salute;
	}
	public void setSalute(String salute) {
		this.salute = salute;
	}
	 
	public String getAlias() {
		return alias;
	}
	public void setAlias(String alias) {
		this.alias = alias;
	}
	
	public String getVerification() {
		return verification;
	}
	public void setVerification(String verification) {
		this.verification = verification;
	}
	public long getCname() {
		return cname;
	}
	public void setCname(long cname) {
		this.cname = cname;
	}
	public long getRowid() {
		return rowid;
	}
	public void setRowid(long rowid) {
		this.rowid = rowid;
	}
	public long getGroup() {
		return group;
	}
	public void setGroup(long group) {
		this.group = group;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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
	public long getPincode() {
		return pincode;
	}
	public void setPincode(long pincode) {
		this.pincode = pincode;
	}
	public long getPhone1() {
		return phone1;
	}
	public void setPhone1(long phone1) {
		this.phone1 = phone1;
	}
	
	public long getPhone2() {
		return phone2;
	}
	public void setPhone2(long phone2) {
		this.phone2 = phone2;
	}
	
	public long getExtn1() {
		return extn1;
	}
	public void setExtn1(long extn1) {
		this.extn1 = extn1;
	}
	public long getExtn2() {
		return extn2;
	}
	public void setExtn2(long extn2) {
		this.extn2 = extn2;
	}
	public long getMobile1() {
		return mobile1;
	}
	public void setMobile1(long mobile1) {
		this.mobile1 = mobile1;
	}
	public long getMobile2() {
		return mobile2;
	}
	public void setMobile2(long mobile2) {
		this.mobile2 = mobile2;
	}
	public long getFax() {
		return fax;
	}
	public void setFax(long fax) {
		this.fax = fax;
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
	public String getActive() {
		if("on".equals(active) || "".equals(active))
			return "Y";
		else
			return "N";
	}
	public void setActive(String active) {
		this.active = active;
	}
	public String getAlias1() {
		return alias1;
	}
	public void setAlias1(String alias1) {
		this.alias1 = alias1;
	}
	public String getSalute1() {
		return salute1;
	}
	public void setSalute1(String salute1) {
		this.salute1 = salute1;
	}
	public String getName1() {
		return name1;
	}
	public void setName1(String name1) {
		this.name1 = name1;
	}
	public String getDesigination1() {
		return desigination1;
	}
	public void setDesigination1(String desigination1) {
		this.desigination1 = desigination1;
	}
	public String getDesigination2() {
		return desigination2;
	}
	public void setDesigination2(String desigination2) {
		this.desigination2 = desigination2;
	}
	public long getAreacode() {
		return areacode;
	}
	public void setAreacode(long areacode) {
		this.areacode = areacode;
	}
	
 
}
