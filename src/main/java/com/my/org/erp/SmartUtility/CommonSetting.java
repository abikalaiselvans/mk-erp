package com.my.org.erp.SmartUtility;

public class CommonSetting 
{
	String companyname,companyaddress,city,state,pincode,phone;
	String mailid,pf,esi,companypf1,companypf2,companyesi,salary;
	String txtpetrol,sessiontime,conveyance;
	String order,leaveupdation ;
	String paytaxvalue,bonus,bonusdays,leavelimit,reseller,resignlimit;
	String pfnumber,esinumber,pflimit,pflimitminimum,esilimit,hrmailid;
	String billingmailid,billingmailidpassword,taxdeductionemp;
	String mailhost,groupmail,company;
	String technicalmailid,productmailid,cpyshortname;
	String grosslimit,dojlock,resignerlock,joinnerlock;
	
	String leavecarry[] ;
	 
	String dtlock,maialert,serverupdate,sms,fpass,adminhide,paytaxdeduction,creditlimit;
	String loginmailcheck,newjoinnermailalert,automaticattendancemark,firsttimeautomate;
	String txtpassword ;
	 
	String inactivecompany;
	String show;
	String whatsappalert;
	String copypaste;
	
	
	public String getCopypaste() {
		return copypaste;
	}

	public void setCopypaste(String copypaste) {
		this.copypaste = copypaste;
	}

	public String getLoginby() {
		return loginby;
	}

	public void setLoginby(String loginby) {
		this.loginby = loginby;
	}

	String loginby; 
  
	public String getShow() {
		return show;
	}

	public void setShow(String show) {
		this.show = show;
	}

	public String getInactivecompany() {
		 
		if(!"Y".equals(inactivecompany))
			inactivecompany ="N";
		return inactivecompany;
	}

	public void setInactivecompany(String inactivecompany) {
		this.inactivecompany = inactivecompany;
	}

	public String getDtlock() 
	{
		if(!"Y".equals(dtlock))
			dtlock ="N";
		return dtlock;
		 
	}

	public void setDtlock(String dtlock) {
		this.dtlock = dtlock;
	}

	
	 

	public void setMail(String maialert) {
		this.maialert = maialert;
	}

	
	
	public String getMaialert() {
		if(!"Y".equals(maialert))
			maialert ="N";
		return maialert;
	}

	public void setMaialert(String maialert) {
		this.maialert = maialert;
	}

	public String getServerupdate() {
		 
		 
		if(!"Y".equals(serverupdate))
			serverupdate ="N";
		return serverupdate;
	}

	public void setServerupdate(String serverupdate) {
		this.serverupdate = serverupdate;
	}

	public String getSms() {
		if(!"Y".equals(sms))
			sms ="N";
		return sms;
		 
	}

	public void setSms(String sms) {
		this.sms = sms;
	}

	public String getFpass() {
		 
		
		if(!"Y".equals(fpass))
			fpass ="N";
		return fpass;
	}

	public void setFpass(String fpass) {
		this.fpass = fpass;
	}

	public String getAdminhide() {
		 
		if(!"Y".equals(adminhide))
			adminhide ="N";
		return adminhide;
	}

	public void setAdminhide(String adminhide) {
		this.adminhide = adminhide;
	}

	public String getPaytaxdeduction() {
		 
		if(!"Y".equals(paytaxdeduction))
			paytaxdeduction ="N";
		return paytaxdeduction;
	}

	public void setPaytaxdeduction(String paytaxdeduction) {
		this.paytaxdeduction = paytaxdeduction;
	}

	public String getCreditlimit() {
		 
		if(!"Y".equals(creditlimit))
			creditlimit ="N";
		return creditlimit;
	}

	public void setCreditlimit(String creditlimit) {
		this.creditlimit = creditlimit;
	}

	public String getLoginmailcheck() {
		 
		if(!"Y".equals(loginmailcheck))
			loginmailcheck ="N";
		return loginmailcheck;
	}

	public void setLoginmailcheck(String loginmailcheck) {
		this.loginmailcheck = loginmailcheck;
	}

	public String getNewjoinnermailalert() {
		if(!"Y".equals(newjoinnermailalert))
			newjoinnermailalert ="N";
		return newjoinnermailalert;
		 
	}

	public void setNewjoinnermailalert(String newjoinnermailalert) {
		this.newjoinnermailalert = newjoinnermailalert;
	}

	public String getAutomaticattendancemark() {
		 
		if(!"Y".equals(automaticattendancemark))
			automaticattendancemark ="N";
		return automaticattendancemark;
		 
	}

	public void setAutomaticattendancemark(String automaticattendancemark) {
		this.automaticattendancemark = automaticattendancemark;
	}

	public String getFirsttimeautomate() {
		 
		if(!"Y".equals(firsttimeautomate))
			firsttimeautomate ="N";
		return firsttimeautomate;
	}

	public void setFirsttimeautomate(String firsttimeautomate) {
		this.firsttimeautomate = firsttimeautomate;
	}

	public String getCompanyname() {
		return companyname;
	}

	public void setCompanyname(String companyname) {
		this.companyname = companyname;
	}

	public String getCompanyaddress() {
		return companyaddress;
	}

	public void setCompanyaddress(String companyaddress) {
		this.companyaddress = companyaddress;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getPincode() {
		return pincode;
	}

	public void setPincode(String pincode) {
		this.pincode = pincode;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getMailid() {
		return mailid;
	}

	public void setMailid(String mailid) {
		this.mailid = mailid;
	}

	public String getPf() {
		return pf;
	}

	public void setPf(String pf) {
		this.pf = pf;
	}

	public String getEsi() {
		return esi;
	}

	public void setEsi(String esi) {
		this.esi = esi;
	}

	public String getCompanypf1() {
		return companypf1;
	}

	public void setCompanypf1(String companypf1) {
		this.companypf1 = companypf1;
	}

	public String getCompanypf2() {
		return companypf2;
	}

	public void setCompanypf2(String companypf2) {
		this.companypf2 = companypf2;
	}

	public String getCompanyesi() {
		return companyesi;
	}

	public void setCompanyesi(String companyesi) {
		this.companyesi = companyesi;
	}

	public String getSalary() {
		return salary;
	}

	public void setSalary(String salary) {
		this.salary = salary;
	}

	public String getTxtpetrol() {
		return txtpetrol;
	}

	public void setTxtpetrol(String txtpetrol) {
		this.txtpetrol = txtpetrol;
	}

	public String getSessiontime() {
		return sessiontime;
	}

	public void setSessiontime(String sessiontime) {
		this.sessiontime = sessiontime;
	}

	public String getConveyance() {
		return conveyance;
	}

	public void setConveyance(String conveyance) {
		this.conveyance = conveyance;
	}

	public String getOrder() {
		return order;
	}

	public void setOrder(String order) {
		this.order = order;
	}

	public String getLeaveupdation() {
		return leaveupdation;
	}

	public void setLeaveupdation(String leaveupdation) {
		this.leaveupdation = leaveupdation;
	}

	public String getPaytaxvalue() {
		return paytaxvalue;
	}

	public void setPaytaxvalue(String paytaxvalue) {
		this.paytaxvalue = paytaxvalue;
	}

	public String getBonus() {
		return bonus;
	}

	public void setBonus(String bonus) {
		this.bonus = bonus;
	}

	public String getBonusdays() {
		return bonusdays;
	}

	public void setBonusdays(String bonusdays) {
		this.bonusdays = bonusdays;
	}

	public String getLeavelimit() {
		return leavelimit;
	}

	public void setLeavelimit(String leavelimit) {
		this.leavelimit = leavelimit;
	}

	public String getReseller() {
		return reseller;
	}

	public void setReseller(String reseller) {
		this.reseller = reseller;
	}

	public String getResignlimit() {
		return resignlimit;
	}

	public void setResignlimit(String resignlimit) {
		this.resignlimit = resignlimit;
	}

	public String getPfnumber() {
		return pfnumber;
	}

	public void setPfnumber(String pfnumber) {
		this.pfnumber = pfnumber;
	}

	public String getEsinumber() {
		return esinumber;
	}

	public void setEsinumber(String esinumber) {
		this.esinumber = esinumber;
	}

	public String getPflimit() {
		return pflimit;
	}

	public void setPflimit(String pflimit) {
		this.pflimit = pflimit;
	}

	public String getPflimitminimum() {
		return pflimitminimum;
	}

	public void setPflimitminimum(String pflimitminimum) {
		this.pflimitminimum = pflimitminimum;
	}

	public String getEsilimit() {
		return esilimit;
	}

	public void setEsilimit(String esilimit) {
		this.esilimit = esilimit;
	}

	public String getHrmailid() {
		return hrmailid;
	}

	public void setHrmailid(String hrmailid) {
		this.hrmailid = hrmailid;
	}

	public String getBillingmailid() {
		return billingmailid;
	}

	public void setBillingmailid(String billingmailid) {
		this.billingmailid = billingmailid;
	}

	public String getBillingmailidpassword() {
		return billingmailidpassword;
	}

	public void setBillingmailidpassword(String billingmailidpassword) {
		this.billingmailidpassword = billingmailidpassword;
	}

	public String getTaxdeductionemp() {
		return taxdeductionemp;
	}

	public void setTaxdeductionemp(String taxdeductionemp) {
		this.taxdeductionemp = taxdeductionemp;
	}

	public String getMailhost() {
		return mailhost;
	}

	public void setMailhost(String mailhost) {
		this.mailhost = mailhost;
	}

	public String getGroupmail() {
		return groupmail;
	}

	public void setGroupmail(String groupmail) {
		this.groupmail = groupmail;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getTechnicalmailid() {
		return technicalmailid;
	}

	public void setTechnicalmailid(String technicalmailid) {
		this.technicalmailid = technicalmailid;
	}

	public String getProductmailid() {
		return productmailid;
	}

	public void setProductmailid(String productmailid) {
		this.productmailid = productmailid;
	}

	public String getCpyshortname() {
		return cpyshortname;
	}

	public void setCpyshortname(String cpyshortname) {
		this.cpyshortname = cpyshortname;
	}

	public String getGrosslimit() {
		return grosslimit;
	}

	public void setGrosslimit(String grosslimit) {
		this.grosslimit = grosslimit;
	}

	public String getDojlock() {
		return dojlock;
	}

	public void setDojlock(String dojlock) {
		this.dojlock = dojlock;
	}

	public String getResignerlock() {
		return resignerlock;
	}

	public void setResignerlock(String resignerlock) {
		this.resignerlock = resignerlock;
	}

	public String getJoinnerlock() {
		return joinnerlock;
	}

	public void setJoinnerlock(String joinnerlock) {
		this.joinnerlock = joinnerlock;
	}

	public String[] getLeavecarry() {
		return leavecarry;
	}

	public void setLeavecarry(String[] leavecarry) {
		this.leavecarry = leavecarry;
	}

	public String getTxtpassword() {
		return txtpassword;
	}

	public void setTxtpassword(String txtpassword) {
		this.txtpassword = txtpassword;
	}

	public String getWhatsappalert() {
		return whatsappalert;
	}

	public void setWhatsappalert(String whatsappalert) {
		this.whatsappalert = whatsappalert;
	}

	 
	 

	
		
}
