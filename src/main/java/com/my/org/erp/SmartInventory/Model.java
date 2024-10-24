package com.my.org.erp.SmartInventory;

public class Model 
{
	int INT_MODELID;
	String CHR_MODELCODE;
/*	String CHR_COLORCODE;*/
	public Model(int INT_MODELID,String CHR_MODELCODE)
	{
		this.INT_MODELID=INT_MODELID;
		this.CHR_MODELCODE=CHR_MODELCODE;
	/*	this.CHR_COLORCODE=CHR_COLORCODE;*/
	}
	/*public String getCHR_COLORCODE() {
		return CHR_COLORCODE;
	}
	public void setCHR_COLORCODE(String chr_colorcode) {
		CHR_COLORCODE = chr_colorcode;
	}*/
	public String getCHR_MODELCODE() {
		return CHR_MODELCODE;
	}
	public void setCHR_MODELCODE(String chr_modelcode) {
		CHR_MODELCODE = chr_modelcode;
	}
	public int getINT_MODELID() {
		return INT_MODELID;
	}
	public void setINT_MODELID(int int_modelid) {
		INT_MODELID = int_modelid;
	}
	

}
