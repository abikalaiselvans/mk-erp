package com.my.org.erp.SmartInventory;

public class StockReport {
	String productId,itemId,itemName,active,purchasePrice;
	String salesPrice,stockIn,stockOut;
	
	public String getActive() {
		return active;
	}
	public void setActive(String active) {
		this.active = active;
	}
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
	public String getPurchasePrice() {
		return purchasePrice;
	}
	public void setPurchasePrice(String purchasePrice) {
		this.purchasePrice = purchasePrice;
	}
	public String getSalesPrice() {
		return salesPrice;
	}
	public void setSalesPrice(String salesPrice) {
		this.salesPrice = salesPrice;
	}
	public String getStockIn() {
		return stockIn;
	}
	public void setStockIn(String stockIn) {
		this.stockIn = stockIn;
	}
	public String getStockOut() {
		return stockOut;
	}
	public void setStockOut(String stockOut) {
		this.stockOut = stockOut;
	}
}
