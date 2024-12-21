package com.my.org.erp.SmartCommon;

import com.my.org.erp.ServiceLogin.DateUtil;

public class Staffold 
{ 

	 
	String id;
	String name,fname;
	String gender,dob,adob,bg,doj,grade,card;
	String stype,pf,esi;
	String revisiondate;
	String marry,wedding,bank,number;
	String padd1,padd2;
	String cadd1,cadd2;
	String emailid,mobile;
	String optpf ,dispensary;
	String optesi ; 
	String carry,management,repto,reporinghead,hold,conveyance,salarycalculation,payslip,fplogin;
	String userid,pfesidate,resigndate,pannumber,passportnumber,drivingnumber;
	String previousdetails,peremailid;
	String middlename,companypfnumber,addressstatus;
	String addressproof,pfclaimstatus,pfclaimdate, pfclaimdescription,interview;
	String salarysplitupby,creationdateandtime,createdby   ;
	String ifsccode,salarytype,nominee;
	String username,updatedate,status;
	String previousempid,rejoin;
	String pfnomineerelationship;
	String aadharnumber;
	String uannumber;
	long company,branch;
	long balance ;
	long pin;
	long txtpfno,txtesno;
	long depart, desig, off;
	long pcity,pdistrict,pstate,pcountry,ppincode,pphone;
	long ccity,cdistrict,cstate,ccountry,cpincode,cphone;
	long qualification, category;
	long attendancecycle;
	long location;
	long applicantid;
	String employeetype;
	String mothername,spousename;
	String pfcalculationtype;
	String refempid;
	int conveyancelimit;
	
	public String getEmployeetype() {
		return employeetype;
	}
	public void setEmployeetype(String employeetype) {
		this.employeetype = employeetype;
	}
	public String getSpousename() {
		return spousename;
	}
	public void setSpousename(String spousename) {
		this.spousename = spousename;
	}
	public String getMothername() {
		return mothername;
	}
	public void setMothername(String mothername) {
		this.mothername = mothername;
	}
	public long getApplicantid() {
		return applicantid;
	}
	public void setApplicantid(long applicantid) {
		this.applicantid = applicantid;
	}
	double basic,gross,ctc;
	double txtpfvalue,txtesivalue;
	
	public double getCtc() {
		return ctc;
	}
	public void setCtc(double ctc) {
		this.ctc = ctc;
	}
	public long getLocation() {
		return location;
	}
	public void setLocation(long location) {
		this.location = location;
	}
	
	
	public String getRevisiondate() {
		 
		
		if(revisiondate.length()<8)
			return null;
		else
			return DateUtil.FormateDateSQL(revisiondate);
	}
	public void setRevisiondate(String revisiondate) {
		this.revisiondate = revisiondate;
	}
	public double getGross() {
		return gross;
	}
	public void setGross(double gross) {
		this.gross = gross;
	}
	public String getAddressproof() {
		return addressproof;
	}
	public void setAddressproof(String addressproof) {
		this.addressproof = addressproof;
	}
	public String getAddressstatus() {
		return addressstatus;
	}
	public void setAddressstatus(String addressstatus) {
		this.addressstatus = addressstatus;
	}
	 
	 
	 
	public String getBank() {
		return bank;
	}
	public void setBank(String bank) {
		this.bank = bank;
	}
	 
	public String getBg() {
		return bg;
	}
	public void setBg(String bg) {
		this.bg = bg;
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
	public String getCard() {
		return card;
	}
	public void setCard(String card) {
		this.card = card;
	}
	public String getCarry() {
		
		if(!"Y".equals(carry))
			carry ="N";
		return carry;
	}
	public void setCarry(String carry) {
		this.carry = carry;
	}
	 
	public String getCompanypfnumber() {
		return companypfnumber;
	}
	public void setCompanypfnumber(String companypfnumber) {
		this.companypfnumber = companypfnumber;
	}
	public String getConveyance() {
		
		if(!"Y".equals(conveyance))
			conveyance ="N";
		return conveyance;
	}
	public void setConveyance(String conveyance) {
		this.conveyance = conveyance;
	}
	 
	public String getCreatedby() {
		return createdby;
	}
	public void setCreatedby(String createdby) {
		this.createdby = createdby;
	}
	public String getCreationdateandtime() {
		return creationdateandtime;
	}
	public void setCreationdateandtime(String creationdateandtime) {
		this.creationdateandtime = creationdateandtime;
	}
	 
	
	
	 
	public String getAdob() {
		 
		if(adob.length()<8   )
			return null;
		else
			return DateUtil.FormateDateSQL(adob);
	}
	
	public void setAdob(String adob) {
		this.adob = adob;
	}
	
	public String getDob() {
		if(dob.length()<8   )
			return null;
		else
			return DateUtil.FormateDateSQL(dob);
		 
	}
	public void setDob(String dob) {
		this.dob = dob;
	}
	public String getDoj() {
		if(doj.length()<8)
			return null;
		else
			return DateUtil.FormateDateSQL(doj );
		 
	}
	public void setDoj(String doj) {
		this.doj = doj;
	}
	public String getDrivingnumber() {
		return drivingnumber;
	}
	public void setDrivingnumber(String drivingnumber) {
		this.drivingnumber = drivingnumber;
	}
	public String getEmailid() {
		return emailid;
	}
	public void setEmailid(String emailid) {
		this.emailid = emailid;
	}
	public String getEsi() {
		return esi;
	}
	public void setEsi(String esi) {
		this.esi = esi;
	}
	public String getFname() {
		return fname;
	}
	public void setFname(String fname) {
		this.fname = fname;
	}
	public String getFplogin() {
		return fplogin;
	}
	public void setFplogin(String fplogin) {
		this.fplogin = fplogin;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	 
	 
	public String getHold() {
		
		if(!"Y".equals(hold))
			hold ="N";
		return hold;
	 
	}
	public void setHold(String hold) {
		this.hold = hold;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getIfsccode() {
		return ifsccode;
	}
	public void setIfsccode(String ifsccode) {
		this.ifsccode = ifsccode;
	}
	public String getInterview()
	{
		if(!"Y".equals(interview))
			interview ="N";
		
		return interview;
	}
	public void setInterview(String interview) 
	{
		this.interview = interview;
	}
	public String getManagement() {
		
		if(!"Y".equals(management))
			management ="N";
		
		return management;
	}
	public void setManagement(String management) {
		this.management = management;
	}
	public String getMarry() {
		return marry;
	}
	public void setMarry(String marry) {
		this.marry = marry;
	}
	public String getMiddlename() {
		return middlename;
	}
	public void setMiddlename(String middlename) {
		this.middlename = middlename;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getNumber() {
		return number;
	}
	public void setNumber(String number) {
		this.number = number;
	}
	 
	public String getOptesi() {
		return optesi;
	}
	public void setOptesi(String optesi) {
		this.optesi = optesi;
	}
	public String getOptpf() {
		return optpf;
	}
	public void setOptpf(String optpf) {
		this.optpf = optpf;
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
	public String getPayslip() {
		if(!"Y".equals(payslip))
			payslip ="N";
		return payslip;
	}
	public void setPayslip(String payslip) {
		this.payslip = payslip;
	}
	 
	public String getPeremailid() {
		return peremailid;
	}
	public void setPeremailid(String peremailid) {
		this.peremailid = peremailid;
	}
	public String getPf() {
		return pf;
	}
	public void setPf(String pf) {
		this.pf = pf;
	}
	public String getPfclaimdate() {
		
		if("-".equals(pfclaimdate) || pfclaimdate.length()<8)
			return null;
		else
			return DateUtil.FormateDateSQL(pfclaimdate);
		 
	}
	public void setPfclaimdate(String pfclaimdate) {
		this.pfclaimdate = pfclaimdate;
	}
	public String getPfclaimdescription() {
		return pfclaimdescription;
	}
	public void setPfclaimdescription(String pfclaimdescription) {
		this.pfclaimdescription = pfclaimdescription;
	}
	public String getPfclaimstatus() {
		return pfclaimstatus;
	}
	public void setPfclaimstatus(String pfclaimstatus) {
		this.pfclaimstatus = pfclaimstatus;
	}
	public String getPfesidate() {
		
		if("-".equals(pfesidate) || pfesidate.length()<8)
			return null;
		else
			return DateUtil.FormateDateSQL(pfesidate);
		 
	}
	public void setPfesidate(String pfesidate) {
		this.pfesidate = pfesidate;
	}
	 
	public String getPreviousdetails() {
		return previousdetails;
	}
	public void setPreviousdetails(String previousdetails) {
		this.previousdetails = previousdetails;
	}
	 
	public String getRejoin() {
		
		if(!"Y".equals(rejoin))
			rejoin ="N";
		
		return rejoin;
	}
	public void setRejoin(String rejoin) {
		this.rejoin = rejoin;
	}
	public String getReporinghead() {
		if(!"Y".equals(reporinghead))
			reporinghead ="N";
		return reporinghead;
	}
	public void setReporinghead(String reporinghead) {
		this.reporinghead = reporinghead;
	}
	
	public String getRepto() {
		return repto;
	}
	
	public void setRepto(String repto) {
		this.repto = repto;
	}
	
	public String getResigndate() {
		if(resigndate.length()<8)
			resigndate=null;
		else
			resigndate = DateUtil.FormateDateSQL(resigndate);
		return resigndate;
	}
	public void setResigndate(String resigndate) {
		this.resigndate = resigndate;
	}
	 
	public String getSalarycalculation() {
		
		if(!"Y".equals(salarycalculation))
			salarycalculation ="N";
		return salarycalculation;
	}
	
	public void setSalarycalculation(String salarycalculation) {
		this.salarycalculation = salarycalculation;
	}
	
	public String getSalarysplitupby() 
	{
		if(!"Y".equals(salarycalculation))
			salarycalculation ="N";
		
		return salarysplitupby;
	}
	
	public void setSalarysplitupby(String salarysplitupby) {
		this.salarysplitupby = salarysplitupby;
	}
	
	public String getSalarytype() {
		return salarytype;
	}
	
	public void setSalarytype(String salarytype) {
		this.salarytype = salarytype;
	}
	 
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getStype() {
		return stype;
	}
	public void setStype(String stype) {
		this.stype = stype;
	}
	public double getTxtesivalue() {
		return txtesivalue;
	}
	public void setTxtesivalue(double txtesivalue) {
		this.txtesivalue = txtesivalue;
	}
	 
	public double getTxtpfvalue() {
		return txtpfvalue;
	}
	public void setTxtpfvalue(double txtpfvalue) {
		this.txtpfvalue = txtpfvalue;
	}
	public String getUpdatedate() {
		return updatedate;
	}
	public void setUpdatedate(String updatedate) {
		this.updatedate = updatedate;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	 
	public String getWedding() 
	{
		if(wedding.length()<8)
			return null;
		else
			return DateUtil.FormateDateSQL(wedding );
	}
	
	public void setWedding(String wedding) {
		this.wedding = wedding;
	}
	public String getDispensary() {
		return dispensary;
	}
	public void setDispensary(String dispensary) {
		this.dispensary = dispensary;
	}
	public String getNominee() {
		return nominee;
	}
	public void setNominee(String nominee) {
		this.nominee = nominee;
	}
	 
	public double getBasic() {
		return basic;
	}
	public void setBasic(double basic) {
		this.basic = basic;
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
	public long getBalance() {
		return balance;
	}
	public void setBalance(long balance) {
		this.balance = balance;
	}
	public long getPin() {
		return pin;
	}
	public void setPin(long pin) {
		this.pin = pin;
	}
	public long getTxtpfno() {
		return txtpfno;
	}
	public void setTxtpfno(long txtpfno) {
		this.txtpfno = txtpfno;
	}
	public long getTxtesno() {
		return txtesno;
	}
	public void setTxtesno(long txtesno) {
		this.txtesno = txtesno;
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
	public long getOff() {
		return off;
	}
	public void setOff(long off) {
		this.off = off;
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
	public long getQualification() {
		return qualification;
	}
	public void setQualification(long qualification) {
		this.qualification = qualification;
	}
	 
	public long getCategory() {
		return category;
	}
	public void setCategory(long category) {
		this.category = category;
	}
	public long getAttendancecycle() {
		return attendancecycle;
	}
	public void setAttendancecycle(long attendancecycle) {
		this.attendancecycle = attendancecycle;
	}
	public String getPreviousempid() {
		return previousempid;
	}
	public void setPreviousempid(String previousempid) {
		this.previousempid = previousempid;
	}
	public String getPfnomineerelationship() {
		return pfnomineerelationship;
	}
	public void setPfnomineerelationship(String pfnomineerelationship) {
		this.pfnomineerelationship = pfnomineerelationship;
	}
	public String getPfcalculationtype() {
		return pfcalculationtype;
	}
	public void setPfcalculationtype(String pfcalculationtype) {
		this.pfcalculationtype = pfcalculationtype;
	}
	public String getAadharnumber() {
		return aadharnumber;
	}
	public void setAadharnumber(String aadharnumber) {
		this.aadharnumber = aadharnumber;
	}
	public String getUannumber() {
		
		if(uannumber.length()>5)
			return uannumber;
		else
			return null;
	}
	public void setUannumber(String uannumber) {
		this.uannumber = uannumber;
	}
	public String getRefempid() {
		return refempid;
	}
	public void setRefempid(String refempid) {
		this.refempid = refempid;
	}
	public int getConveyancelimit() {
		return conveyancelimit;
	}
	public void setConveyancelimit(int conveyancelimit) {
		this.conveyancelimit = conveyancelimit;
	}
	@Override
	public String toString() {
		return "Staff [id=" + id + ", name=" + name + ", fname=" + fname
				+ ", gender=" + gender + ", dob=" + dob + ", adob=" + adob
				+ ", bg=" + bg + ", doj=" + doj + ", grade=" + grade
				+ ", card=" + card + ", stype=" + stype + ", pf=" + pf
				+ ", esi=" + esi + ", revisiondate=" + revisiondate
				+ ", marry=" + marry + ", wedding=" + wedding + ", bank="
				+ bank + ", number=" + number + ", padd1=" + padd1 + ", padd2="
				+ padd2 + ", cadd1=" + cadd1 + ", cadd2=" + cadd2
				+ ", emailid=" + emailid + ", mobile=" + mobile + ", optpf="
				+ optpf + ", dispensary=" + dispensary + ", optesi=" + optesi
				+ ", carry=" + carry + ", management=" + management
				+ ", repto=" + repto + ", reporinghead=" + reporinghead
				+ ", hold=" + hold + ", conveyance=" + conveyance
				+ ", salarycalculation=" + salarycalculation + ", payslip="
				+ payslip + ", fplogin=" + fplogin + ", userid=" + userid
				+ ", pfesidate=" + pfesidate + ", resigndate=" + resigndate
				+ ", pannumber=" + pannumber + ", passportnumber="
				+ passportnumber + ", drivingnumber=" + drivingnumber
				+ ", previousdetails=" + previousdetails + ", peremailid="
				+ peremailid + ", middlename=" + middlename
				+ ", companypfnumber=" + companypfnumber + ", addressstatus="
				+ addressstatus + ", addressproof=" + addressproof
				+ ", pfclaimstatus=" + pfclaimstatus + ", pfclaimdate="
				+ pfclaimdate + ", pfclaimdescription=" + pfclaimdescription
				+ ", interview=" + interview + ", salarysplitupby="
				+ salarysplitupby + ", creationdateandtime="
				+ creationdateandtime + ", createdby=" + createdby
				+ ", ifsccode=" + ifsccode + ", salarytype=" + salarytype
				+ ", nominee=" + nominee + ", username=" + username
				+ ", updatedate=" + updatedate + ", status=" + status
				+ ", previousempid=" + previousempid + ", rejoin=" + rejoin
				+ ", pfnomineerelationship=" + pfnomineerelationship
				+ ", aadharnumber=" + aadharnumber + ", uannumber=" + uannumber
				+ ", company=" + company + ", branch=" + branch + ", balance="
				+ balance + ", pin=" + pin + ", txtpfno=" + txtpfno
				+ ", txtesno=" + txtesno + ", depart=" + depart + ", desig="
				+ desig + ", off=" + off + ", pcity=" + pcity + ", pdistrict="
				+ pdistrict + ", pstate=" + pstate + ", pcountry=" + pcountry
				+ ", ppincode=" + ppincode + ", pphone=" + pphone + ", ccity="
				+ ccity + ", cdistrict=" + cdistrict + ", cstate=" + cstate
				+ ", ccountry=" + ccountry + ", cpincode=" + cpincode
				+ ", cphone=" + cphone + ", qualification=" + qualification
				+ ", category=" + category + ", attendancecycle="
				+ attendancecycle + ", location=" + location + ", applicantid="
				+ applicantid + ", employeetype=" + employeetype
				+ ", mothername=" + mothername + ", spousename=" + spousename
				+ ", pfcalculationtype=" + pfcalculationtype + ", refempid="
				+ refempid + ", conveyancelimit=" + conveyancelimit
				+ ", basic=" + basic + ", gross=" + gross + ", ctc=" + ctc
				+ ", txtpfvalue=" + txtpfvalue + ", txtesivalue=" + txtesivalue
				+ "]";
	}
	
	  
	 
	
	
	
}
