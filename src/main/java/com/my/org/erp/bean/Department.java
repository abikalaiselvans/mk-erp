package com.my.org.erp.bean;

public  final class Department {

	int departId;

	String departName;

	String departDes;

	public Department(int departId, String departName, String departDes) {
		super();
		this.departId = departId;
		this.departName = departName;
		this.departDes = departDes;

	}

	public Department() {
		 
	}

	public String getDepartDes() {
		return departDes;
	}

	public void setDepartDes(String departDes) {
		this.departDes = departDes;
	}

	public int getDepartId() {
		return departId;
	}

	public void setDepartId(int departId) {
		this.departId = departId;
	}

	public String getDepartName() {
		return departName;
	}

	public void setDepartName(String departName) {
		this.departName = departName;
	}

}
