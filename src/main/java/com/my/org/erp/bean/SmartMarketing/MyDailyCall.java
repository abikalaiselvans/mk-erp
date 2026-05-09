package com.my.org.erp.bean.SmartMarketing;

public class MyDailyCall {
	
	String clientname = "",location = "",contactperson = "",designation = "",contactnumber = "";
	String typeofcall = "",entrydate = "",description = "",nextfollowdate = "", mename;
	String id="", value="", actionS="" ;
	String sql="";
	String link="";
	String rowid="";
	public String getClientname() {
		return clientname;
	}
	public void setClientname(String clientname) {
		this.clientname = clientname;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getContactperson() {
		return contactperson;
	}
	public void setContactperson(String contactperson) {
		this.contactperson = contactperson;
	}
	public String getDesignation() {
		return designation;
	}
	public void setDesignation(String designation) {
		this.designation = designation;
	}
	public String getContactnumber() {
		return contactnumber;
	}
	public void setContactnumber(String contactnumber) {
		this.contactnumber = contactnumber;
	}
	public String getTypeofcall() {
		return typeofcall;
	}
	public void setTypeofcall(String typeofcall) {
		this.typeofcall = typeofcall;
	}
	public String getEntrydate() {
		return entrydate;
	}
	public void setEntrydate(String entrydate) {
		this.entrydate = entrydate;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getNextfollowdate() {
		return nextfollowdate;
	}
	public void setNextfollowdate(String nextfollowdate) {
		this.nextfollowdate = nextfollowdate;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	public String getActionS() {
		return actionS;
	}
	public void setActionS(String actionS) {
		this.actionS = actionS;
	}
	public String getSql() {
		return sql;
	}
	public void setSql(String sql) {
		this.sql = sql;
	}
	public String getLink() {
		return link;
	}
	public void setLink(String link) {
		this.link = link;
	}
	public String getRowid() {
		return rowid;
	}
	public void setRowid(String rowid) {
		this.rowid = rowid;
	}
	
	
	
	public String getMename() {
		return mename;
	}
	public void setMename(String mename) {
		this.mename = mename;
	}
	@Override
	public String toString() {
		return "MyDailyCall [clientname=" + clientname + ", location=" + location + ", contactperson=" + contactperson
				+ ", designation=" + designation + ", contactnumber=" + contactnumber + ", typeofcall=" + typeofcall
				+ ", entrydate=" + entrydate + ", description=" + description + ", nextfollowdate=" + nextfollowdate
				+ ", id=" + id + ", value=" + value + ", actionS=" + actionS + ", sql=" + sql + ", link=" + link
				+ ", rowid=" + rowid + "]";
	}
	
	
	
	

}
