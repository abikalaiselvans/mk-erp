package com.my.org.erp.bean.payroll;

public  final class Allowance {
	String allCode;
	String allName;
	String flag;
	String mflag;
	String bflag;
	public Allowance(String allCode, String allName,String flag,String mflag,String bflag) {
		super();
		this.allCode = allCode;
		this.allName = allName;
		this.flag = flag;
		this.mflag=mflag;
		this.bflag=bflag;
	}

	public Allowance() {
		super();
	}

	public String getAllCode() {
		return allCode;
	}

	public void setAllCode(String allCode) {
		this.allCode = allCode;
	}

	public String getAllName() {
		return allName;
	}

	public void setAllName(String allName) {
		this.allName = allName;
	}
	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

	public String getMflag() {
		return mflag;
	}

	public void setMflag(String mflag) {
		this.mflag = mflag;
	}

	public String getBflag() {
		return bflag;
	}

	public void setBflag(String bflag) {
		this.bflag = bflag;
	}
	
}
