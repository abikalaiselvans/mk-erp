package com.my.org.erp.SmartInventory;

public class Item {
	int branchId;
	String productId,itemId,itemName,itemDesc,purDes,salesDes,warrandy;
	double purPrice,salesPrice;
	int stockInHand;
	boolean active;
	public Item() {
		super();
		 
	}
	public boolean isActive() {
		return active;
	}
	public void setActive(boolean active) {
		this.active = active;
	}
	public int getBranchId() {
		return branchId;
	}
	public void setBranchId(int branchId) {
		this.branchId = branchId;
	}
	public String getItemDesc() {
		return itemDesc;
	}
	public void setItemDesc(String itemDesc) {
		this.itemDesc = itemDesc;
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
	public String getPurDes() {
		return purDes;
	}
	public void setPurDes(String purDes) {
		this.purDes = purDes;
	}
	public double getPurPrice() {
		return purPrice;
	}
	public void setPurPrice(double purPrice) {
		this.purPrice = purPrice;
	}
	public String getSalesDes() {
		return salesDes;
	}
	public void setSalesDes(String salesDes) {
		this.salesDes = salesDes;
	}
	public double getSalesPrice() {
		return salesPrice;
	}
	public void setSalesPrice(double salesPrice) {
		this.salesPrice = salesPrice;
	}
	public int getStockInHand() {
		return stockInHand;
	}
	public void setStockInHand(int stockInHand) {
		this.stockInHand = stockInHand;
	}
	public String getWarrandy() {
		return warrandy;
	}
	public void setWarrandy(String warrandy) {
		this.warrandy = warrandy;
	}
	
}
