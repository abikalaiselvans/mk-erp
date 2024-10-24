package com.my.org.erp.SmartPayroll;
import com.my.org.erp.ServiceLogin.DateUtil;
public class StaffLoanDebit 
{
	  String name,loantype,desc,mode;
	  String debitdate;
	  double debitloanamount;
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
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public String getDebitdate() 
	{
		if(debitdate.length()>5)
			return DateUtil.FormateDateSQL(debitdate);
		else
			return null;
		 
	}
	public void setDebitdate(String debitdate) {
		this.debitdate = debitdate;
	}
	public double getDebitloanamount() {
		return debitloanamount;
	}
	public void setDebitloanamount(double debitloanamount) {
		this.debitloanamount = debitloanamount;
	}
				  
}
