package com.my.org.erp.bean.Attendance;

public final class Office {

	int OfficeId;

	String OfficeName;

	String OfficeDes;
	String Officeshortname;
	public Office(int OfficeId, String OfficeName, String OfficeDes,String Officeshortname) {
		super();
		this.OfficeId = OfficeId;
		this.OfficeName = OfficeName;
		this.OfficeDes = OfficeDes;
		this.Officeshortname=Officeshortname;

	}

	public Office() {
		 
	}

	public String getOfficeDes() {
		return OfficeDes;
	}

	public void setOfficeDes(String OfficeDes) {
		this.OfficeDes = OfficeDes;
	}

	public int getOfficeId() {
		return OfficeId;
	}

	public void setOfficeId(int OfficeId) {
		this.OfficeId = OfficeId;
	}

	public String getOfficeName() {
		return OfficeName;
	}

	public void setOfficeName(String OfficeName) {
		this.OfficeName = OfficeName;
	}

	public String getOfficeshortname() {
		return Officeshortname;
	}

	public void setOfficeshortname(String officeshortname) {
		Officeshortname = officeshortname;
	}

}
