package com.my.org.erp.Decorator.SmartInventory;

import java.util.ArrayList;
import java.util.Vector;

import com.my.org.erp.common.CommonFunctions;

public class SwappingInfo 
{
	String sno,branch,division,salesno,type,product,description;
	String date,serialno,status,swappingserial;
	public SwappingInfo()
	{
 
	}
	
	public SwappingInfo(String sno, String branch, String division,
			String salesno, String type, String product, String description,
			String date, String serialno, String status, String swappingserial) {
		 
		this.sno = sno;
		this.branch = branch;
		this.division = division;
		this.salesno = salesno;
		this.type = type;
		this.product = product;
		this.description = description;
		this.date = date;
		this.serialno = serialno;
		this.status = status;
		this.swappingserial = swappingserial;
	}
	
	public String getSno() {
		return sno;
	}
	public void setSno(String sno) {
		this.sno = sno;
	}
	public String getBranch() {
		return branch;
	}
	public void setBranch(String branch) {
		this.branch = branch;
	}
	public String getDivision() {
		return division;
	}
	public void setDivision(String division) {
		this.division = division;
	}
	public String getSalesno() {
		return salesno;
	}
	public void setSalesno(String salesno) {
		this.salesno = salesno;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getProduct() {
		return product;
	}
	public void setProduct(String product) {
		this.product = product;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getSerialno() {
		return serialno;
	}
	public void setSerialno(String serialno) {
		this.serialno = serialno;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getSwappingserial() {
		return swappingserial;
	}
	public void setSwappingserial(String swappingserial) {
		this.swappingserial = swappingserial;
	}
	
	public ArrayList loadData(String sql)
	{
		ArrayList<SwappingInfo> userList = new ArrayList<SwappingInfo>();
		String Data[][] = CommonFunctions.QueryExecute(sql);
		if(Data.length>0)
		{
			for(int u=0;u<Data.length;u++)
			{
				
				userList.add(new SwappingInfo( 
				""+(u+1),Data[u][0],Data[u][1],
				Data[u][2],Data[u][3],Data[u][4],	
				Data[u][5],Data[u][6],Data[u][7],
				Data[u][8],Data[u][9])
				 );
			}
		}
		
		return userList;
	}
	 
	public Vector loadData1(String sql)
	{
		Vector mn = new Vector();
	 	Vector child= null;
		String data[][] = CommonFunctions.QueryExecute(sql);
		if(data.length>0)
		{
			for(int u=0;u<data.length;u++)
			{
				child = new Vector();
				child.addElement((u+1));
				child.addElement(data[u][0]);
				child.addElement(data[u][1]);
				child.addElement(data[u][2]);
				child.addElement(data[u][3]);
				child.addElement(data[u][4]);
				child.addElement(data[u][5]);
				child.addElement(data[u][6]);
				child.addElement(data[u][7]);
				child.addElement(data[u][8]);
				child.addElement(data[u][9]);
				mn.add(child); 
			}
		} 
		 
		
		return mn;
	}
}
