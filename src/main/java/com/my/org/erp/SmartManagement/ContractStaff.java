package com.my.org.erp.SmartManagement;

import com.my.org.erp.ServiceLogin.DateUtil;

public class ContractStaff 
{
	  String name,fname,gender;
	  String marry,dob,wedding;
	  String doj, peremailid,  repto;
	  String no,ifsccode; 
	  String padd1,padd2;
	  String cadd1,cadd2;
	  String pannumber,passportnumber,drivingnumber,previousdetails;
	  double basic;
	  long bg,mobile;
	  long category, company,  branch, off;
	  long depart, desig, bank;
	  long pcity,pdistrict,pstate,pcountry,ppincode,pphone;
	  long ccity,cdistrict,cstate,ccountry,cpincode,cphone;
	  long staffid;
	  long rowids[];
	  
	  
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getFname() {
		return fname;
	}
	public void setFname(String fname) {
		this.fname = fname;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getMarry() {
		return marry;
	}
	public void setMarry(String marry) {
		this.marry = marry;
	}
	public String getDob() {
		if(dob.length()<8)
			return null;
		else
			return DateUtil.FormateDateSQL(dob );
	}
	public void setDob(String dob) {
		this.dob = dob;
	}
	public String getWedding() {
		 
		
		if(wedding.length()<8)
			return null;
		else
			return DateUtil.FormateDateSQL(wedding );
		 
		
	}
	public void setWedding(String wedding) {
		this.wedding = wedding;
	}
	
	public String getDoj() 
	{
		if(doj.length()<8)
			return null;
		else
			return DateUtil.FormateDateSQL(doj );
		 
		
	}
	
	public void setDoj(String doj) {
		this.doj = doj;
	}
	public String getPeremailid() {
		return peremailid;
	}
	public void setPeremailid(String peremailid) {
		this.peremailid = peremailid;
	}
	public String getRepto() {
		return repto;
	}
	public void setRepto(String repto) {
		this.repto = repto;
	}
	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
	}
	public String getIfsccode() {
		return ifsccode;
	}
	public void setIfsccode(String ifsccode) {
		this.ifsccode = ifsccode;
	}
	public String getPadd1() {
		return padd1;
	}
	public void setPadd1(String padd1) {
		this.padd1 = padd1;
	}
	public String getPadd2() {
		return padd2;
	}
	public void setPadd2(String padd2) {
		this.padd2 = padd2;
	}
	public String getCadd1() {
		return cadd1;
	}
	public void setCadd1(String cadd1) {
		this.cadd1 = cadd1;
	}
	public String getCadd2() {
		return cadd2;
	}
	public void setCadd2(String cadd2) {
		this.cadd2 = cadd2;
	}
	public String getPannumber() {
		return pannumber;
	}
	public void setPannumber(String pannumber) {
		this.pannumber = pannumber;
	}
	public String getPassportnumber() {
		return passportnumber;
	}
	public void setPassportnumber(String passportnumber) {
		this.passportnumber = passportnumber;
	}
	public String getDrivingnumber() {
		return drivingnumber;
	}
	public void setDrivingnumber(String drivingnumber) {
		this.drivingnumber = drivingnumber;
	}
	public String getPreviousdetails() {
		return previousdetails;
	}
	public void setPreviousdetails(String previousdetails) {
		this.previousdetails = previousdetails;
	}
	public double getBasic() {
		return basic;
	}
	public void setBasic(double basic) {
		this.basic = basic;
	}
	public long getBg() {
		return bg;
	}
	public void setBg(long bg) {
		this.bg = bg;
	}
	public long getMobile() {
		return mobile;
	}
	public void setMobile(long mobile) {
		this.mobile = mobile;
	}
	public long getCategory() {
		return category;
	}
	public void setCategory(long category) {
		this.category = category;
	}
	public long getCompany() {
		return company;
	}
	public void setCompany(long company) {
		this.company = company;
	}
	public long getBranch() {
		return branch;
	}
	public void setBranch(long branch) {
		this.branch = branch;
	}
	public long getOff() {
		return off;
	}
	public void setOff(long off) {
		this.off = off;
	}
	public long getDepart() {
		return depart;
	}
	public void setDepart(long depart) {
		this.depart = depart;
	}
	public long getDesig() {
		return desig;
	}
	public void setDesig(long desig) {
		this.desig = desig;
	}
	public long getBank() {
		return bank;
	}
	public void setBank(long bank) {
		this.bank = bank;
	}
	public long getPcity() {
		return pcity;
	}
	public void setPcity(long pcity) {
		this.pcity = pcity;
	}
	public long getPdistrict() {
		return pdistrict;
	}
	public void setPdistrict(long pdistrict) {
		this.pdistrict = pdistrict;
	}
	public long getPstate() {
		return pstate;
	}
	public void setPstate(long pstate) {
		this.pstate = pstate;
	}
	public long getPcountry() {
		return pcountry;
	}
	public void setPcountry(long pcountry) {
		this.pcountry = pcountry;
	}
	public long getPpincode() {
		return ppincode;
	}
	public void setPpincode(long ppincode) {
		this.ppincode = ppincode;
	}
	public long getPphone() {
		return pphone;
	}
	public void setPphone(long pphone) {
		this.pphone = pphone;
	}
	public long getCcity() {
		return ccity;
	}
	public void setCcity(long ccity) {
		this.ccity = ccity;
	}
	public long getCdistrict() {
		return cdistrict;
	}
	public void setCdistrict(long cdistrict) {
		this.cdistrict = cdistrict;
	}
	public long getCstate() {
		return cstate;
	}
	public void setCstate(long cstate) {
		this.cstate = cstate;
	}
	public long getCcountry() {
		return ccountry;
	}
	public void setCcountry(long ccountry) {
		this.ccountry = ccountry;
	}
	public long getCpincode() {
		return cpincode;
	}
	public void setCpincode(long cpincode) {
		this.cpincode = cpincode;
	}
	public long getCphone() {
		return cphone;
	}
	public void setCphone(long cphone) {
		this.cphone = cphone;
	}
	public long getStaffid() {
		return staffid;
	}
	public void setStaffid(long staffid) {
		this.staffid = staffid;
	}
	public long[] getRowids() {
		return rowids;
	}
	public void setRowids(long[] rowids) {
		this.rowids = rowids;
	}
	  
	  
	  
}
