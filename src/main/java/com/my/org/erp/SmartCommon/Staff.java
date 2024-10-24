package com.my.org.erp.SmartCommon;

import com.my.org.erp.ServiceLogin.DateUtil;

public class Staff {
  String id;
  
  String name;
  
  String fname;
  
  String gender;
  
  String dob;
  
  String adob;
  
  String bg;
  
  String doj;
  
  String grade;
  
  String card;
  
  String stype;
  
  String pf;
  
  String esi;
  
  String revisiondate;
  
  String marry;
  
  String wedding;
  
  String bank;
  
  String number;
  
  String padd1;
  
  String padd2;
  
  String cadd1;
  
  String cadd2;
  
  String emailid;
  
  String mobile;
  
  String optpf;
  
  String dispensary;
  
  String optesi;
  
  String carry;
  
  String management;
  
  String repto;
  
  String reporinghead;
  
  String hold;
  
  String conveyance;
  
  String salarycalculation;
  
  String payslip;
  
  String fplogin;
  
  String userid;
  
  String pfesidate;
  
  String resigndate;
  
  String pannumber;
  
  String passportnumber;
  
  String drivingnumber;
  
  String previousdetails;
  
  String peremailid;
  
  String middlename;
  
  String companypfnumber;
  
  String addressstatus;
  
  String addressproof;
  
  String pfclaimstatus;
  
  String pfclaimdate;
  
  String pfclaimdescription;
  
  String interview;
  
  String salarysplitupby;
  
  String creationdateandtime;
  
  String createdby;
  
  String ifsccode;
  
  String salarytype;
  
  String nominee;
  
  String username;
  
  String updatedate;
  
  String status;
  
  String previousempid;
  
  String rejoin;
  
  String pfnomineerelationship;
  
  String aadharnumber;
  
  String uannumber;
  
  long company;
  
  long branch;
  
  long balance;
  
  long pin;
  
  long txtpfno;
  
  long txtesno;
  
  long depart;
  
  long desig;
  
  long off;
  
  long pcity;
  
  long pdistrict;
  
  long pstate;
  
  long pcountry;
  
  long ppincode;
  
  long pphone;
  
  long ccity;
  
  long cdistrict;
  
  long cstate;
  
  long ccountry;
  
  long cpincode;
  
  long cphone;
  
  long qualification;
  
  long category;
  
  long attendancecycle;
  
  long location;
  
  long applicantid;
  
  String employeetype;
  
  String mothername;
  
  String spousename;
  
  String pfcalculationtype;
  
  String refempid;
  
  int conveyancelimit;
  
  double basic;
  
  double gross;
  
  double ctc;
  
  double txtpfvalue;
  
  double txtesivalue;
  
  public String getEmployeetype() {
    return this.employeetype;
  }
  
  public void setEmployeetype(String employeetype) {
    this.employeetype = employeetype;
  }
  
  public String getSpousename() {
    return this.spousename;
  }
  
  public void setSpousename(String spousename) {
    this.spousename = spousename;
  }
  
  public String getMothername() {
    return this.mothername;
  }
  
  public void setMothername(String mothername) {
    this.mothername = mothername;
  }
  
  public long getApplicantid() {
    return this.applicantid;
  }
  
  public void setApplicantid(long applicantid) {
    this.applicantid = applicantid;
  }
  
  public double getCtc() {
    return this.ctc;
  }
  
  public void setCtc(double ctc) {
    this.ctc = ctc;
  }
  
  public long getLocation() {
    return this.location;
  }
  
  public void setLocation(long location) {
    this.location = location;
  }
  
  public String getRevisiondate() {
    if (this.revisiondate.length() < 8)
      return null; 
    return DateUtil.FormateDateSQL(this.revisiondate);
  }
  
  public void setRevisiondate(String revisiondate) {
    this.revisiondate = revisiondate;
  }
  
  public double getGross() {
    return this.gross;
  }
  
  public void setGross(double gross) {
    this.gross = gross;
  }
  
  public String getAddressproof() {
    return this.addressproof;
  }
  
  public void setAddressproof(String addressproof) {
    this.addressproof = addressproof;
  }
  
  public String getAddressstatus() {
    return this.addressstatus;
  }
  
  public void setAddressstatus(String addressstatus) {
    this.addressstatus = addressstatus;
  }
  
  public String getBank() {
    return this.bank;
  }
  
  public void setBank(String bank) {
    this.bank = bank;
  }
  
  public String getBg() {
    return this.bg;
  }
  
  public void setBg(String bg) {
    this.bg = bg;
  }
  
  public String getCadd1() {
    return this.cadd1;
  }
  
  public void setCadd1(String cadd1) {
    this.cadd1 = cadd1;
  }
  
  public String getCadd2() {
    return this.cadd2;
  }
  
  public void setCadd2(String cadd2) {
    this.cadd2 = cadd2;
  }
  
  public String getCard() {
    return this.card;
  }
  
  public void setCard(String card) {
    this.card = card;
  }
  
  public String getCarry() {
    if (!"Y".equals(this.carry))
      this.carry = "N"; 
    return this.carry;
  }
  
  public void setCarry(String carry) {
    this.carry = carry;
  }
  
  public String getCompanypfnumber() {
    return this.companypfnumber;
  }
  
  public void setCompanypfnumber(String companypfnumber) {
    this.companypfnumber = companypfnumber;
  }
  
  public String getConveyance() {
    if (!"Y".equals(this.conveyance))
      this.conveyance = "N"; 
    return this.conveyance;
  }
  
  public void setConveyance(String conveyance) {
    this.conveyance = conveyance;
  }
  
  public String getCreatedby() {
    return this.createdby;
  }
  
  public void setCreatedby(String createdby) {
    this.createdby = createdby;
  }
  
  public String getCreationdateandtime() {
    return this.creationdateandtime;
  }
  
  public void setCreationdateandtime(String creationdateandtime) {
    this.creationdateandtime = creationdateandtime;
  }
  
  public String getAdob() {
    if (this.adob.length() < 8)
      return null; 
    return DateUtil.FormateDateSQL(this.adob);
  }
  
  public void setAdob(String adob) {
    this.adob = adob;
  }
  
  public String getDob() {
    if (this.dob.length() < 8)
      return null; 
    return DateUtil.FormateDateSQL(this.dob);
  }
  
  public void setDob(String dob) {
    this.dob = dob;
  }
  
  public String getDoj() {
    if (this.doj.length() < 8)
      return null; 
    return DateUtil.FormateDateSQL(this.doj);
  }
  
  public void setDoj(String doj) {
    this.doj = doj;
  }
  
  public String getDrivingnumber() {
    return this.drivingnumber;
  }
  
  public void setDrivingnumber(String drivingnumber) {
    this.drivingnumber = drivingnumber;
  }
  
  public String getEmailid() {
    return this.emailid;
  }
  
  public void setEmailid(String emailid) {
    this.emailid = emailid;
  }
  
  public String getEsi() {
    return this.esi;
  }
  
  public void setEsi(String esi) {
    this.esi = esi;
  }
  
  public String getFname() {
    return this.fname;
  }
  
  public void setFname(String fname) {
    this.fname = fname;
  }
  
  public String getFplogin() {
    return this.fplogin;
  }
  
  public void setFplogin(String fplogin) {
    this.fplogin = fplogin;
  }
  
  public String getGender() {
    return this.gender;
  }
  
  public void setGender(String gender) {
    this.gender = gender;
  }
  
  public String getGrade() {
    return this.grade;
  }
  
  public void setGrade(String grade) {
    this.grade = grade;
  }
  
  public String getHold() {
    if (!"Y".equals(this.hold))
      this.hold = "N"; 
    return this.hold;
  }
  
  public void setHold(String hold) {
    this.hold = hold;
  }
  
  public String getId() {
    return this.id;
  }
  
  public void setId(String id) {
    this.id = id;
  }
  
  public String getIfsccode() {
    return this.ifsccode;
  }
  
  public void setIfsccode(String ifsccode) {
    this.ifsccode = ifsccode;
  }
  
  public String getInterview() {
    if (!"Y".equals(this.interview))
      this.interview = "N"; 
    return this.interview;
  }
  
  public void setInterview(String interview) {
    this.interview = interview;
  }
  
  public String getManagement() {
    if (!"Y".equals(this.management))
      this.management = "N"; 
    return this.management;
  }
  
  public void setManagement(String management) {
    this.management = management;
  }
  
  public String getMarry() {
    return this.marry;
  }
  
  public void setMarry(String marry) {
    this.marry = marry;
  }
  
  public String getMiddlename() {
    return this.middlename;
  }
  
  public void setMiddlename(String middlename) {
    this.middlename = middlename;
  }
  
  public String getMobile() {
    return this.mobile;
  }
  
  public void setMobile(String mobile) {
    this.mobile = mobile;
  }
  
  public String getName() {
    return this.name;
  }
  
  public void setName(String name) {
    this.name = name;
  }
  
  public String getNumber() {
    return this.number;
  }
  
  public void setNumber(String number) {
    this.number = number;
  }
  
  public String getOptesi() {
    return this.optesi;
  }
  
  public void setOptesi(String optesi) {
    this.optesi = optesi;
  }
  
  public String getOptpf() {
    return this.optpf;
  }
  
  public void setOptpf(String optpf) {
    this.optpf = optpf;
  }
  
  public String getPadd1() {
    return this.padd1;
  }
  
  public void setPadd1(String padd1) {
    this.padd1 = padd1;
  }
  
  public String getPadd2() {
    return this.padd2;
  }
  
  public void setPadd2(String padd2) {
    this.padd2 = padd2;
  }
  
  public String getPannumber() {
    return this.pannumber;
  }
  
  public void setPannumber(String pannumber) {
    this.pannumber = pannumber;
  }
  
  public String getPassportnumber() {
    return this.passportnumber;
  }
  
  public void setPassportnumber(String passportnumber) {
    this.passportnumber = passportnumber;
  }
  
  public String getPayslip() {
    if (!"Y".equals(this.payslip))
      this.payslip = "N"; 
    return this.payslip;
  }
  
  public void setPayslip(String payslip) {
    this.payslip = payslip;
  }
  
  public String getPeremailid() {
    return this.peremailid;
  }
  
  public void setPeremailid(String peremailid) {
    this.peremailid = peremailid;
  }
  
  public String getPf() {
    return this.pf;
  }
  
  public void setPf(String pf) {
    this.pf = pf;
  }
  
  public String getPfclaimdate() {
    if ("-".equals(this.pfclaimdate) || this.pfclaimdate.length() < 8)
      return null; 
    return DateUtil.FormateDateSQL(this.pfclaimdate);
  }
  
  public void setPfclaimdate(String pfclaimdate) {
    this.pfclaimdate = pfclaimdate;
  }
  
  public String getPfclaimdescription() {
    return this.pfclaimdescription;
  }
  
  public void setPfclaimdescription(String pfclaimdescription) {
    this.pfclaimdescription = pfclaimdescription;
  }
  
  public String getPfclaimstatus() {
    return this.pfclaimstatus;
  }
  
  public void setPfclaimstatus(String pfclaimstatus) {
    this.pfclaimstatus = pfclaimstatus;
  }
  
  public String getPfesidate() {
    if ("-".equals(this.pfesidate) || this.pfesidate.length() < 8)
      return null; 
    return DateUtil.FormateDateSQL(this.pfesidate);
  }
  
  public void setPfesidate(String pfesidate) {
    this.pfesidate = pfesidate;
  }
  
  public String getPreviousdetails() {
    return this.previousdetails;
  }
  
  public void setPreviousdetails(String previousdetails) {
    this.previousdetails = previousdetails;
  }
  
  public String getRejoin() {
    if (!"Y".equals(this.rejoin))
      this.rejoin = "N"; 
    return this.rejoin;
  }
  
  public void setRejoin(String rejoin) {
    this.rejoin = rejoin;
  }
  
  public String getReporinghead() {
    if (!"Y".equals(this.reporinghead))
      this.reporinghead = "N"; 
    return this.reporinghead;
  }
  
  public void setReporinghead(String reporinghead) {
    this.reporinghead = reporinghead;
  }
  
  public String getRepto() {
    return this.repto;
  }
  
  public void setRepto(String repto) {
    this.repto = repto;
  }
  
  public String getResigndate() {
    if (this.resigndate.length() < 8) {
      this.resigndate = null;
    } else {
      this.resigndate = DateUtil.FormateDateSQL(this.resigndate);
    } 
    return this.resigndate;
  }
  
  public void setResigndate(String resigndate) {
    this.resigndate = resigndate;
  }
  
  public String getSalarycalculation() {
    if (!"Y".equals(this.salarycalculation))
      this.salarycalculation = "N"; 
    return this.salarycalculation;
  }
  
  public void setSalarycalculation(String salarycalculation) {
    this.salarycalculation = salarycalculation;
  }
  
  public String getSalarysplitupby() {
    if (!"Y".equals(this.salarycalculation))
      this.salarycalculation = "N"; 
    return this.salarysplitupby;
  }
  
  public void setSalarysplitupby(String salarysplitupby) {
    this.salarysplitupby = salarysplitupby;
  }
  
  public String getSalarytype() {
    return this.salarytype;
  }
  
  public void setSalarytype(String salarytype) {
    this.salarytype = salarytype;
  }
  
  public String getStatus() {
    return this.status;
  }
  
  public void setStatus(String status) {
    this.status = status;
  }
  
  public String getStype() {
    return this.stype;
  }
  
  public void setStype(String stype) {
    this.stype = stype;
  }
  
  public double getTxtesivalue() {
    return this.txtesivalue;
  }
  
  public void setTxtesivalue(double txtesivalue) {
    this.txtesivalue = txtesivalue;
  }
  
  public double getTxtpfvalue() {
    return this.txtpfvalue;
  }
  
  public void setTxtpfvalue(double txtpfvalue) {
    this.txtpfvalue = txtpfvalue;
  }
  
  public String getUpdatedate() {
    return this.updatedate;
  }
  
  public void setUpdatedate(String updatedate) {
    this.updatedate = updatedate;
  }
  
  public String getUserid() {
    return this.userid;
  }
  
  public void setUserid(String userid) {
    this.userid = userid;
  }
  
  public String getUsername() {
    return this.username;
  }
  
  public void setUsername(String username) {
    this.username = username;
  }
  
  public String getWedding() {
    if (this.wedding.length() < 8)
      return null; 
    return DateUtil.FormateDateSQL(this.wedding);
  }
  
  public void setWedding(String wedding) {
    this.wedding = wedding;
  }
  
  public String getDispensary() {
    return this.dispensary;
  }
  
  public void setDispensary(String dispensary) {
    this.dispensary = dispensary;
  }
  
  public String getNominee() {
    return this.nominee;
  }
  
  public void setNominee(String nominee) {
    this.nominee = nominee;
  }
  
  public double getBasic() {
    return this.basic;
  }
  
  public void setBasic(double basic) {
    this.basic = basic;
  }
  
  public long getCompany() {
    return this.company;
  }
  
  public void setCompany(long company) {
    this.company = company;
  }
  
  public long getBranch() {
    return this.branch;
  }
  
  public void setBranch(long branch) {
    this.branch = branch;
  }
  
  public long getBalance() {
    return this.balance;
  }
  
  public void setBalance(long balance) {
    this.balance = balance;
  }
  
  public long getPin() {
    return this.pin;
  }
  
  public void setPin(long pin) {
    this.pin = pin;
  }
  
  public long getTxtpfno() {
    return this.txtpfno;
  }
  
  public void setTxtpfno(long txtpfno) {
    this.txtpfno = txtpfno;
  }
  
  public long getTxtesno() {
    return this.txtesno;
  }
  
  public void setTxtesno(long txtesno) {
    this.txtesno = txtesno;
  }
  
  public long getDepart() {
    return this.depart;
  }
  
  public void setDepart(long depart) {
    this.depart = depart;
  }
  
  public long getDesig() {
    return this.desig;
  }
  
  public void setDesig(long desig) {
    this.desig = desig;
  }
  
  public long getOff() {
    return this.off;
  }
  
  public void setOff(long off) {
    this.off = off;
  }
  
  public long getPcity() {
    return this.pcity;
  }
  
  public void setPcity(long pcity) {
    this.pcity = pcity;
  }
  
  public long getPdistrict() {
    return this.pdistrict;
  }
  
  public void setPdistrict(long pdistrict) {
    this.pdistrict = pdistrict;
  }
  
  public long getPstate() {
    return this.pstate;
  }
  
  public void setPstate(long pstate) {
    this.pstate = pstate;
  }
  
  public long getPcountry() {
    return this.pcountry;
  }
  
  public void setPcountry(long pcountry) {
    this.pcountry = pcountry;
  }
  
  public long getPpincode() {
    return this.ppincode;
  }
  
  public void setPpincode(long ppincode) {
    this.ppincode = ppincode;
  }
  
  public long getPphone() {
    return this.pphone;
  }
  
  public void setPphone(long pphone) {
    this.pphone = pphone;
  }
  
  public long getCcity() {
    return this.ccity;
  }
  
  public void setCcity(long ccity) {
    this.ccity = ccity;
  }
  
  public long getCdistrict() {
    return this.cdistrict;
  }
  
  public void setCdistrict(long cdistrict) {
    this.cdistrict = cdistrict;
  }
  
  public long getCstate() {
    return this.cstate;
  }
  
  public void setCstate(long cstate) {
    this.cstate = cstate;
  }
  
  public long getCcountry() {
    return this.ccountry;
  }
  
  public void setCcountry(long ccountry) {
    this.ccountry = ccountry;
  }
  
  public long getCpincode() {
    return this.cpincode;
  }
  
  public void setCpincode(long cpincode) {
    this.cpincode = cpincode;
  }
  
  public long getCphone() {
    return this.cphone;
  }
  
  public void setCphone(long cphone) {
    this.cphone = cphone;
  }
  
  public long getQualification() {
    return this.qualification;
  }
  
  public void setQualification(long qualification) {
    this.qualification = qualification;
  }
  
  public long getCategory() {
    return this.category;
  }
  
  public void setCategory(long category) {
    this.category = category;
  }
  
  public long getAttendancecycle() {
    return this.attendancecycle;
  }
  
  public void setAttendancecycle(long attendancecycle) {
    this.attendancecycle = attendancecycle;
  }
  
  public String getPreviousempid() {
    return this.previousempid;
  }
  
  public void setPreviousempid(String previousempid) {
    this.previousempid = previousempid;
  }
  
  public String getPfnomineerelationship() {
    return this.pfnomineerelationship;
  }
  
  public void setPfnomineerelationship(String pfnomineerelationship) {
    this.pfnomineerelationship = pfnomineerelationship;
  }
  
  public String getPfcalculationtype() {
    return this.pfcalculationtype;
  }
  
  public void setPfcalculationtype(String pfcalculationtype) {
    this.pfcalculationtype = pfcalculationtype;
  }
  
  public String getAadharnumber() {
    return this.aadharnumber;
  }
  
  public void setAadharnumber(String aadharnumber) {
    this.aadharnumber = aadharnumber;
  }
  
  public String getUannumber() {
    if (this.uannumber.length() > 5)
      return this.uannumber; 
    return null;
  }
  
  public void setUannumber(String uannumber) {
    this.uannumber = uannumber;
  }
  
  public String getRefempid() {
    return this.refempid;
  }
  
  public void setRefempid(String refempid) {
    this.refempid = refempid;
  }
  
  public int getConveyancelimit() {
    return this.conveyancelimit;
  }
  
  public void setConveyancelimit(int conveyancelimit) {
    this.conveyancelimit = conveyancelimit;
  }
  
  public String toString() {
    return "Staff [id=" + this.id + ", name=" + this.name + ", fname=" + this.fname + 
      ", gender=" + this.gender + ", dob=" + this.dob + ", adob=" + this.adob + 
      ", bg=" + this.bg + ", doj=" + this.doj + ", grade=" + this.grade + 
      ", card=" + this.card + ", stype=" + this.stype + ", pf=" + this.pf + 
      ", esi=" + this.esi + ", revisiondate=" + this.revisiondate + 
      ", marry=" + this.marry + ", wedding=" + this.wedding + ", bank=" + 
      this.bank + ", number=" + this.number + ", padd1=" + this.padd1 + ", padd2=" + 
      this.padd2 + ", cadd1=" + this.cadd1 + ", cadd2=" + this.cadd2 + 
      ", emailid=" + this.emailid + ", mobile=" + this.mobile + ", optpf=" + 
      this.optpf + ", dispensary=" + this.dispensary + ", optesi=" + this.optesi + 
      ", carry=" + this.carry + ", management=" + this.management + 
      ", repto=" + this.repto + ", reporinghead=" + this.reporinghead + 
      ", hold=" + this.hold + ", conveyance=" + this.conveyance + 
      ", salarycalculation=" + this.salarycalculation + ", payslip=" + 
      this.payslip + ", fplogin=" + this.fplogin + ", userid=" + this.userid + 
      ", pfesidate=" + this.pfesidate + ", resigndate=" + this.resigndate + 
      ", pannumber=" + this.pannumber + ", passportnumber=" + 
      this.passportnumber + ", drivingnumber=" + this.drivingnumber + 
      ", previousdetails=" + this.previousdetails + ", peremailid=" + 
      this.peremailid + ", middlename=" + this.middlename + 
      ", companypfnumber=" + this.companypfnumber + ", addressstatus=" + 
      this.addressstatus + ", addressproof=" + this.addressproof + 
      ", pfclaimstatus=" + this.pfclaimstatus + ", pfclaimdate=" + 
      this.pfclaimdate + ", pfclaimdescription=" + this.pfclaimdescription + 
      ", interview=" + this.interview + ", salarysplitupby=" + 
      this.salarysplitupby + ", creationdateandtime=" + 
      this.creationdateandtime + ", createdby=" + this.createdby + 
      ", ifsccode=" + this.ifsccode + ", salarytype=" + this.salarytype + 
      ", nominee=" + this.nominee + ", username=" + this.username + 
      ", updatedate=" + this.updatedate + ", status=" + this.status + 
      ", previousempid=" + this.previousempid + ", rejoin=" + this.rejoin + 
      ", pfnomineerelationship=" + this.pfnomineerelationship + 
      ", aadharnumber=" + this.aadharnumber + ", uannumber=" + this.uannumber + 
      ", company=" + this.company + ", branch=" + this.branch + ", balance=" + 
      this.balance + ", pin=" + this.pin + ", txtpfno=" + this.txtpfno + 
      ", txtesno=" + this.txtesno + ", depart=" + this.depart + ", desig=" + 
      this.desig + ", off=" + this.off + ", pcity=" + this.pcity + ", pdistrict=" + 
      this.pdistrict + ", pstate=" + this.pstate + ", pcountry=" + this.pcountry + 
      ", ppincode=" + this.ppincode + ", pphone=" + this.pphone + ", ccity=" + 
      this.ccity + ", cdistrict=" + this.cdistrict + ", cstate=" + this.cstate + 
      ", ccountry=" + this.ccountry + ", cpincode=" + this.cpincode + 
      ", cphone=" + this.cphone + ", qualification=" + this.qualification + 
      ", category=" + this.category + ", attendancecycle=" + 
      this.attendancecycle + ", location=" + this.location + ", applicantid=" + 
      this.applicantid + ", employeetype=" + this.employeetype + 
      ", mothername=" + this.mothername + ", spousename=" + this.spousename + 
      ", pfcalculationtype=" + this.pfcalculationtype + ", refempid=" + 
      this.refempid + ", conveyancelimit=" + this.conveyancelimit + 
      ", basic=" + this.basic + ", gross=" + this.gross + ", ctc=" + this.ctc + 
      ", txtpfvalue=" + this.txtpfvalue + ", txtesivalue=" + this.txtesivalue + 
      "]";
  }
}
