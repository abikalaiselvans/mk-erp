package com.my.org.erp.SmartInventory;

public class Vendor 
{ 
	
	String name,cperson,address1,address2;
	Long country,state,district,city,pin;
	String area,phone,mobile,fax,email;
	String website,doh,bank,accno,vendorgroup,tin,cst,pan,gst;
	
	public String getPan()
	{
		return pan;
	}
	public void setPan(String pan) 
	{
		this.pan = pan;
	}
	long rowid,ids[];
	 
	String status;
	double  climit;
	
	 
	public double getClimit() 
	{
		return climit;
	}
	public void setClimit(double climit) 
	{
		this.climit = climit;
	}
	public String getStatus() 
	{
		if(!"1".equals(status))
			status="0";
		return status;
	}
	public void setStatus(String status) 
	{
		this.status = status;
	}
	public String getName() 
	{
		return name;
	}
	public void setName(String name) 
	{
		this.name = name;
	}
	public String getCperson() 
	{
		return cperson;
	}
	public void setCperson(String cperson) 
	{
		this.cperson = cperson;
	}
	public String getAddress1() 
	{
		return address1;
	}
	public void setAddress1(String address1) 
	{
		this.address1 = address1;
	}
	public String getAddress2() 
	{
		return address2;
	}
	public void setAddress2(String address2) 
	{
		this.address2 = address2;
	}
	public Long getCountry() 
	{
		return country;
	}
	public void setCountry(Long country) 
	{
		this.country = country;
	}
	public Long getState() 
	{
		return state;
	}
	public void setState(Long state) 
	{
		this.state = state;
	}
	public Long getDistrict() 
	{
		return district;
	}
	public void setDistrict(Long district) 
	{
		this.district = district;
	}
	public Long getCity() 
	{
		return city;
	}
	public void setCity(Long city) 
	{
		this.city = city;
	}
	public Long getPin() 
	{
		return pin;
	}
	public void setPin(Long pin)
	{
		this.pin = pin;
	}
	public String getArea() 
	{
		return area;
	}
	public void setArea(String area) 
	{
		this.area = area;
	}
	public String getPhone() 
	{
		return phone;
	}
	public void setPhone(String phone) 
	{
		this.phone = phone;
	}
	public String getMobile()
	{
		return mobile;
	}
	public void setMobile(String mobile) 
	{
		this.mobile = mobile;
	}
	public String getFax() 
	{
		return fax;
	}
	public void setFax(String fax) 
	{
		this.fax = fax;
	}
	public String getEmail() 
	{
		return email;
	}
	public void setEmail(String email) 
	{
		this.email = email;
	}
	public String getWebsite() 
	{
		return website;
	}
	public void setWebsite(String website) 
	{
		this.website = website;
	}
	public String getDoh() 
	{
		return doh;
	}
	public void setDoh(String doh) 
	{
		this.doh = doh;
	}
	public String getBank() 
	{
		return bank;
	}
	public void setBank(String bank) 
	{
		this.bank = bank;
	}
	public String getAccno() 
	{
		return accno;
	}
	public void setAccno(String accno) 
	{
		this.accno = accno;
	}
	public String getVendorgroup() 
	{
		return vendorgroup;
	}
	public void setVendorgroup(String vendorgroup) 
	{
		this.vendorgroup = vendorgroup;
	}
	public String getTin() 
	{
		return tin;
	}
	public void setTin(String tin) 
	{
		this.tin = tin;
	}
	public String getCst() 
	{
		return cst;
	}
	public void setCst(String cst) 
	{
		this.cst = cst;
	}
	public long getRowid() 
	{
		return rowid;
	}
	public void setRowid(long rowid) 
	{
		this.rowid = rowid;
	}
	public long[] getIds() 
	{
		return ids;
	}
	public void setIds(long[] ids) 
	{
		this.ids = ids;
	}
	public String getGst() {
		return gst;
	}
	public void setGst(String gst) {
		this.gst = gst;
	}
	 
	 
	
	
}