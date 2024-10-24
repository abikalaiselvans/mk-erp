package com.my.org.erp.SmartPayroll;

public class Training {
	String progId;

	String progName;

	String pdate;

	String ptime;

	String venu;

	String trainer;

	String subject;

	public Training(String progId, String progName, String pdate, String ptime,
			String venu, String trainer, String subject) {
		super();
		this.progId = progId;
		this.progName = progName;
		this.pdate = pdate;
		this.ptime = ptime;
		this.venu = venu;
		this.trainer = trainer;
		this.subject = subject;
	}

	public String getPdate() {
		return pdate;
	}

	public void setPdate(String pdate) {
		this.pdate = pdate;
	}

	public String getProgId() {
		return progId;
	}

	public void setProgId(String progId) {
		this.progId = progId;
	}

	public String getProgName() {
		return progName;
	}

	public void setProgName(String progName) {
		this.progName = progName;
	}

	public String getPtime() {
		return ptime;
	}

	public void setPtime(String ptime) {
		this.ptime = ptime;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getTrainer() {
		return trainer;
	}

	public void setTrainer(String trainer) {
		this.trainer = trainer;
	}

	public String getVenu() {
		return venu;
	}

	public void setVenu(String venu) {
		this.venu = venu;
	}
}
