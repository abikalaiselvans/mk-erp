package com.my.org.erp.SmartPayroll;
import com.my.org.erp.ServiceLogin.DateUtil;
public class StaffLoanCredit 
{
	  String name,loantype,desc,authorised;
	  String creditdate,dob;
	  double loanamount;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getLoantype() {
		return loantype;
	}
	public void setLoantype(String loantype) {
		this.loantype = loantype;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
	public String getAuthorised() {
		return authorised;
	}
	public void setAuthorised(String authorised) {
		this.authorised = authorised;
	}
	public String getCreditdate() 
	{
		if(creditdate.length()>5)
			return DateUtil.FormateDateSQL(creditdate);
		else
			return null;
	}
	public void setCreditdate(String creditdate) {
		this.creditdate = creditdate;
	}
	public String getDob() {
		return dob;
	}
	public void setDob(String dob) {
		this.dob = dob;
	}
	public double getLoanamount() {
		return loanamount;
	}
	public void setLoanamount(double loanamount) {
		this.loanamount = loanamount;
	}
			  
}
