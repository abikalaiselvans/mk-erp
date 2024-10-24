package com.my.org.erp.SmartInventory;

public class Product {
  int barnchId,productGropuId,stockInHand;
  String productId,productName,productDes,warranty,itemList;
  boolean active,priceStatus;
  
public Product() {
	super();	
}
public boolean isActive() {
	return active;
}
public void setActive(boolean active) {
	this.active = active;
}
public int getBarnchId() {
	return barnchId;
}
public void setBarnchId(int barnchId) {
	this.barnchId = barnchId;
}
public boolean isPriceStatus() {
	return priceStatus;
}
public void setPriceStatus(boolean priceStatus) {
	this.priceStatus = priceStatus;
}
public String getProductDes() {
	return productDes;
}
public void setProductDes(String productDes) {
	this.productDes = productDes;
}
public int getProductGropuId() {
	return productGropuId;
}
public void setProductGropuId(int productGropuId) {
	this.productGropuId = productGropuId;
}
public String getProductId() {
	return productId;
}
public void setProductId(String productId) {
	this.productId = productId;
}
public String getProductName() {
	return productName;
}
public void setProductName(String productName) {
	this.productName = productName;
}
public String getWarranty() {
	return warranty;
}
public void setWarranty(String warranty) {
	this.warranty = warranty;
}
public int getStockInHand() {
	return stockInHand;
}
public void setStockInHand(int stockInHand) {
	this.stockInHand = stockInHand;
}
public String getItemList() {
	return itemList;
}
public void setItemList(String itemList) {
	this.itemList = itemList;
}
  
}

