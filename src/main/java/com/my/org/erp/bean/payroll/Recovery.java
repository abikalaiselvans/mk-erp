package com.my.org.erp.bean.payroll;

public  final class Recovery {
	String recCode;

	String recName;
	String recChange;

	public Recovery(String recCode, String recName,String recChange) {
		super();
		this.recCode = recCode;
		this.recName = recName;
		this.recChange=recChange;
	}

	public String getRecCode() {
		return recCode;
	}

	public void setRecCode(String recCode) {
		this.recCode = recCode;
	}

	public String getRecName() {
		return recName;
	}

	public void setRecName(String recName) {
		this.recName = recName;
	}

	public String getRecChange() {
		return recChange;
	}

	public void setRecChange(String recChange) {
		this.recChange = recChange;
	}

}
