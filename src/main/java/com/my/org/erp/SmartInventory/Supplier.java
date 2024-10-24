package com.my.org.erp.SmartInventory;

public class Supplier {

	int supplierId;
	String supplierName;
	String contactPerson;
	String street;
	String area;
	String city;
	String state;
	int pin;
	String phone;
	String mobile;
	String fax;
	String email;
	public Supplier(int supplierId, String supplierName, String street, String area, String city, String state, int pin, String phone, String mobile, String fax, String email) {
		super();
		this.supplierId = supplierId;
		this.supplierName = supplierName;
		this.street = street;
		this.area = area;
		this.city = city;
		this.state = state;
		this.pin = pin;
		this.phone = phone;
		this.mobile = mobile;
		this.fax = fax;
		this.email = email;
	}
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getFax() {
		return fax;
	}
	public void setFax(String fax) {
		this.fax = fax;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public int getPin() {
		return pin;
	}
	public void setPin(int pin) {
		this.pin = pin;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getStreet() {
		return street;
	}
	public void setStreet(String street) {
		this.street = street;
	}
	public int getSupplierId() {
		return supplierId;
	}
	public void setSupplierId(int supplierId) {
		this.supplierId = supplierId;
	}
	public String getSupplierName() {
		return supplierName;
	}
	public void setSupplierName(String supplierName) {
		this.supplierName = supplierName;
	}
	public String getContactPerson() {
		return contactPerson;
	}
	public void setContactPerson(String contactPerson) {
		this.contactPerson = contactPerson;
	}
}
