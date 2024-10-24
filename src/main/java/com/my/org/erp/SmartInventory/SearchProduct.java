package com.my.org.erp.SmartInventory;

public class SearchProduct {
    String prodName,prodId;

	public SearchProduct() {
		super();
		 
	}

	public SearchProduct(String prodName, String prodId) {
		super();
		this.prodName = prodName;
		this.prodId = prodId;
	}

	public String getProdId() {
		return prodId;
	}

	public void setProdId(String prodId) {
		this.prodId = prodId;
	}

	public String getProdName() {
		return prodName;
	}

	public void setProdName(String prodName) {
		this.prodName = prodName;
	}
    
	
}
