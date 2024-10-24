package com.my.org.erp.bean;

public  final class Designation {

	int desigId;

	String desigName;

	String desigDes;

	public Designation(int desigId, String desigName, String desigDes) {
		super();
		this.desigId = desigId;
		this.desigName = desigName;
		this.desigDes = desigDes;

	}

	public Designation() {
		 
	}

	public String getDesigDes() {
		return desigDes;
	}

	public void setDesigDes(String desigDes) {
		this.desigDes = desigDes;
	}

	public int getDesigId() {
		return desigId;
	}

	public void setDesigId(int desigId) {
		this.desigId = desigId;
	}

	public String getDesigName() {
		return desigName;
	}

	public void setDesigName(String desigName) {
		this.desigName = desigName;
	}

}
