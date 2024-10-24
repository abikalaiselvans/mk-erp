package com.my.org.erp.sample;

import java.io.Serializable;



public class Sample implements Serializable 
{
	String name,age,blood,department;
	
	public Sample(String name, String age, String blood,String department) {
		this.name = name;
		this.age = age;
		this.blood = blood;
		this.department = department;
	}
	
	public String getAge() {
		return age;
	}

	public void setAge(String age) {
		this.age = age;
	}

	public String getBlood() {
		return blood;
	}

	public void setBlood(String blood) {
		this.blood = blood;
	}

	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
}
