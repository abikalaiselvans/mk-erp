package com.my.org.erp.SmartInventory;

public class Stock {

	
	String productId ;
	String itemId;
	String itemName;
	int stockIn;
	int stockOut;
	public String getItemId() {
		return itemId;
	}
	public void setItemId(String itemId) {
		this.itemId = itemId;
	}
	public String getItemName() {
		return itemName;
	}
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	public String getProductId() {
		return productId;
	}
	public void setProductId(String productId) {
		this.productId = productId;
	}
	public int getStockIn() {
		return stockIn;
	}
	public void setStockIn(int stockIn) {
		this.stockIn = stockIn;
	}
	public int getStockOut() {
		return stockOut;
	}
	public void setStockOut(int stockOut) {
		this.stockOut = stockOut;
	}
}
