package com.my.org.erp.bean.inventory;

public class ConsumableStock 
{
	String companyname,branchname,productid,product,productcode;
	String description,division,pquantity, squantity,bquantity;
	String averageprice,branchid;
	public ConsumableStock(String companyname, String branchname,
			String productid, String product, String productcode,
			String description, String division, String pquantity,
			String squantity, String bquantity, String averageprice,
			String branchid) {
		super();
		this.companyname = companyname;
		this.branchname = branchname;
		this.productid = productid;
		this.product = product;
		this.productcode = productcode;
		this.description = description;
		this.division = division;
		this.pquantity = pquantity;
		this.squantity = squantity;
		this.bquantity = bquantity;
		this.averageprice = averageprice;
		this.branchid = branchid;
	}
	public String getCompanyname() {
		return companyname;
	}
	public void setCompanyname(String companyname) {
		this.companyname = companyname;
	}
	public String getBranchname() {
		return branchname;
	}
	public void setBranchname(String branchname) {
		this.branchname = branchname;
	}
	public String getProductid() {
		return productid;
	}
	public void setProductid(String productid) {
		this.productid = productid;
	}
	public String getProduct() {
		return product;
	}
	public void setProduct(String product) {
		this.product = product;
	}
	public String getProductcode() {
		return productcode;
	}
	public void setProductcode(String productcode) {
		this.productcode = productcode;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getDivision() {
		return division;
	}
	public void setDivision(String division) {
		this.division = division;
	}
	public String getPquantity() {
		return pquantity;
	}
	public void setPquantity(String pquantity) {
		this.pquantity = pquantity;
	}
	public String getSquantity() {
		return squantity;
	}
	public void setSquantity(String squantity) {
		this.squantity = squantity;
	}
	public String getBquantity() {
		return bquantity;
	}
	public void setBquantity(String bquantity) {
		this.bquantity = bquantity;
	}
	public String getAverageprice() {
		return averageprice;
	}
	public void setAverageprice(String averageprice) {
		this.averageprice = averageprice;
	}
	public String getBranchid() {
		return branchid;
	}
	public void setBranchid(String branchid) {
		this.branchid = branchid;
	}
	
}
