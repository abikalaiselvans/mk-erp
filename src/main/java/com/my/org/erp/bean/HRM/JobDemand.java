package com.my.org.erp.bean.HRM;

public final class JobDemand 
{
	String office,jobgrade,jobTitle ,rowid;
	String demandescription;
	 String demandraisedby;
	 
	 String demandacceptedby;
	 String acceptdescription;
	 String demandstatus;
	 
	int demand;
	public int getDemand() {
		return demand;
	}
	public String getRowid() {
		return rowid;
	}
	public void setRowid(String rowid) {
		this.rowid = rowid;
	}
	public void setDemand(int demand) {
		this.demand = demand;
	}
	public String getJobgrade() {
		return jobgrade;
	}
	public void setJobgrade(String jobgrade) {
		this.jobgrade = jobgrade;
	}
	public String getJobTitle() {
		return jobTitle;
	}
	public void setJobTitle(String jobTitle) {
		this.jobTitle = jobTitle;
	}
	public String getOffice() {
		return office;
	}
	public void setOffice(String office) {
		this.office = office;
	}
	public String getDemandescription() {
		return demandescription;
	}
	public void setDemandescription(String demandescription) {
		this.demandescription = demandescription;
	}
	 
	public String getDemandraisedby() {
		return demandraisedby;
	}
	public void setDemandraisedby(String demandraisedby) {
		this.demandraisedby = demandraisedby;
	}
	public String getAcceptdescription() {
		return acceptdescription;
	}
	public void setAcceptdescription(String acceptdescription) {
		this.acceptdescription = acceptdescription;
	}
	public String getDemandacceptedby() {
		return demandacceptedby;
	}
	public void setDemandacceptedby(String demandacceptedby) {
		this.demandacceptedby = demandacceptedby;
	}
	public String getDemandstatus() {
		return demandstatus;
	}
	public void setDemandstatus(String demandstatus) {
		this.demandstatus = demandstatus;
	}
}
