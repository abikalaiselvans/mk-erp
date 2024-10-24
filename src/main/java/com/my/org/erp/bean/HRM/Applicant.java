package com.my.org.erp.bean.HRM;

import java.io.Serializable;

import com.my.org.erp.ServiceLogin.DateUtil;

public   class Applicant implements Serializable 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	String name,fname,adate,jobgrade,jobtitle,gender, bike,married ;
	String dob,wedding,education,emailid,passport,pan,dlicence ;
	String padd1,padd2 ;
	String cadd1,cadd2 ;
	String exemployee;
	String language1 ;
	String read1 ;
	String write1 ;
	String speak1 ;
	String language2 ;
	String read2 ;
	String write2 ;
	String speak2 ;
	String language3 ;
	String read3 ;
	String write3 ;
	String speak3 ;
	String keyskill,certificates,previousdetails,description;
	int pcity,pdistrict,pstate,pcountry,ppincode,pphone ;
	int ccity,cdistrict,cstate,ccountry,cpincode,cphone ;
	int bg; 
	int office;
	long mobilenumber;
	String appcode,rowid;  
	int onlinetest;
	
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public int getOnlinetest() {
		return onlinetest;
	}
	public void setOnlinetest(int onlinetest) {
		this.onlinetest = onlinetest;
	}
	public String getLanguage1() {
		return language1;
	}
	public void setLanguage1(String language1) {
		this.language1 = language1;
	}
	public String getRead1() {
		return read1;
	}
	public void setRead1(String read1) {
		this.read1 = read1;
	}
	public String getWrite1() {
		return write1;
	}
	public void setWrite1(String write1) {
		this.write1 = write1;
	}
	public String getSpeak1() {
		return speak1;
	}
	public void setSpeak1(String speak1) {
		this.speak1 = speak1;
	}
	public String getLanguage2() {
		return language2;
	}
	public void setLanguage2(String language2) {
		this.language2 = language2;
	}
	public String getRead2() {
		return read2;
	}
	public void setRead2(String read2) {
		this.read2 = read2;
	}
	public String getWrite2() {
		return write2;
	}
	public void setWrite2(String write2) {
		this.write2 = write2;
	}
	public String getSpeak2() {
		return speak2;
	}
	public void setSpeak2(String speak2) {
		this.speak2 = speak2;
	}
	public String getLanguage3() {
		return language3;
	}
	public void setLanguage3(String language3) {
		this.language3 = language3;
	}
	public String getRead3() {
		return read3;
	}
	public void setRead3(String read3) {
		this.read3 = read3;
	}
	public String getWrite3() {
		return write3;
	}
	public void setWrite3(String write3) {
		this.write3 = write3;
	}
	public String getSpeak3() {
		return speak3;
	}
	public void setSpeak3(String speak3) {
		this.speak3 = speak3;
	}
	
	public String getExemployee() {
		return exemployee;
	}
	public void setExemployee(String exemployee) {
		this.exemployee = exemployee;
	}
	
	public String getAppcode() {
		return appcode;
	}
	public void setAppcode(String appcode) {
		this.appcode = appcode;
	}
	public String getRowid() {
		return rowid;
	}
	public void setRowid(String rowid) {
		this.rowid = rowid;
	}
	 
	public String getBike() {
		return bike;
	}
	public void setBike(String bike) {
		this.bike = bike;
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
	public int getCcity() {
		return ccity;
	}
	public void setCcity(int ccity) {
		this.ccity = ccity;
	}
	public int getCcountry() {
		return ccountry;
	}
	public void setCcountry(int ccountry) {
		this.ccountry = ccountry;
	}
	public int getCdistrict() {
		return cdistrict;
	}
	public void setCdistrict(int cdistrict) {
		this.cdistrict = cdistrict;
	}
	public int getCphone() {
		return cphone;
	}
	public void setCphone(int cphone) {
		this.cphone = cphone;
	}
	public int getCpincode() {
		return cpincode;
	}
	public void setCpincode(int cpincode) {
		this.cpincode = cpincode;
	}
	public int getCstate() {
		return cstate;
	}
	public void setCstate(int cstate) {
		this.cstate = cstate;
	}
	 
	public String getDlicence() {
		return dlicence;
	}
	public void setDlicence(String dlicence) {
		this.dlicence = dlicence;
	}
	public String getDob() 
	{
		if(dob.length()>8)
			dob = DateUtil.FormateDateSQL(dob);
		else
			dob = null;
		return dob;
	}
	public void setDob(String dob) {
		this.dob = dob;
	}
	public String getEducation() {
		return education;
	}
	public void setEducation(String education) {
		this.education = education;
	}
	public String getEmailid() {
		return emailid;
	}
	public void setEmailid(String emailid) {
		this.emailid = emailid;
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
	public String getJobgrade() {
		return jobgrade;
	}
	public void setJobgrade(String jobgrade) {
		this.jobgrade = jobgrade;
	}
	public String getJobtitle() {
		return jobtitle;
	}
	public void setJobtitle(String jobtitle) {
		this.jobtitle = jobtitle;
	}
	public String getMarried() {
		return married;
	}
	public void setMarried(String married) {
		this.married = married;
	}
	 
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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
	public String getPan() {
		return pan;
	}
	public void setPan(String pan) {
		this.pan = pan;
	}
	public String getPassport() {
		return passport;
	}
	public void setPassport(String passport) {
		this.passport = passport;
	}
	public int getPcity() {
		return pcity;
	}
	public void setPcity(int pcity) {
		this.pcity = pcity;
	}
	public int getPcountry() {
		return pcountry;
	}
	public void setPcountry(int pcountry) {
		this.pcountry = pcountry;
	}
	public int getPdistrict() {
		return pdistrict;
	}
	public void setPdistrict(int pdistrict) {
		this.pdistrict = pdistrict;
	}
	public int getPphone() {
		return pphone;
	}
	public void setPphone(int pphone) {
		this.pphone = pphone;
	}
	public int getPpincode() {
		return ppincode;
	}
	public void setPpincode(int ppincode) {
		this.ppincode = ppincode;
	}
	public int getPstate() {
		return pstate;
	}
	public void setPstate(int pstate) {
		this.pstate = pstate;
	}
	public String getWedding() 
	{
	
		if(wedding.length()>8)
			wedding = DateUtil.FormateDateSQL(wedding);
		else
			wedding  = null;
		return wedding;
	}
	public void setWedding(String wedding) {
		this.wedding = wedding;
	}
	public String getAdate() {
		
		if(adate.length()>8)
			adate = DateUtil.FormateDateSQL(adate);
		else
			adate = null;
		return adate;
	}
	public void setAdate(String adate) {
		this.adate = adate;
	}
	public String getCertificates() {
		return certificates;
	}
	public void setCertificates(String certificates) {
		this.certificates = certificates;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getKeyskill() {
		return keyskill;
	}
	public void setKeyskill(String keyskill) {
		this.keyskill = keyskill;
	}
	public String getPreviousdetails() {
		return previousdetails;
	}
	public void setPreviousdetails(String previousdetails) {
		this.previousdetails = previousdetails;
	}
	public int getOffice() {
		return office;
	}
	public void setOffice(int office) {
		this.office = office;
	}
	public long getMobilenumber() {
		return mobilenumber;
	}
	public void setMobilenumber(long mobilenumber) {
		this.mobilenumber = mobilenumber;
	}
	public int getBg() {
		return bg;
	}
	public void setBg(int bg) {
		this.bg = bg;
	}
	 
	 
}
