package com.my.org.erp.bean;

public  final class District {

	int districtId;

	String districtName;

	String districtDes;

	int stateId;

	public District(int districtId, String districtName, String districtDes,
			int stateId) {
		super();
		this.districtId = districtId;
		this.districtName = districtName;
		this.districtDes = districtDes;
		this.stateId = stateId;
	}

	public District() {
		 
	}

	public String getDistrictDes() {
		return districtDes;
	}

	public void setDistrictDes(String districtDes) {
		this.districtDes = districtDes;
	}

	public int getDistrictId() {
		return districtId;
	}

	public void setDistrictId(int districtId) {
		this.districtId = districtId;
	}

	public String getDistrictName() {
		return districtName;
	}

	public void setDistrictName(String districtName) {
		this.districtName = districtName;
	}

	public int getStateId() {
		return stateId;
	}

	public void setStateId(int stateId) {
		this.stateId = stateId;
	}

}
