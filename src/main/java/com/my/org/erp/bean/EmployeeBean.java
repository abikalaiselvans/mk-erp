package com.my.org.erp.bean;

public  final class EmployeeBean {

	private String id, depId, desId;

	private String firstName;

	private String departName;

	public String getDepartName() {
		return departName;
	}

	public EmployeeBean() {
	}

	public EmployeeBean(String id, String firstName, String departName) {
		this.id = id;
		this.firstName = firstName;
		this.departName = departName;
	}

	public String getId() {
		return id;
	}

	public String getFirstName() {
		return firstName;
	}

	public String getDepId() {
		return depId;
	}

	public void setDepId(String depId) {
		this.depId = depId;
	}

	public String getDesId() {
		return desId;
	}

	public void setDesId(String desId) {
		this.desId = desId;
	}

	public void setDepartName(String departName) {
		this.departName = departName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public void setId(String id) {
		this.id = id;
	}
}