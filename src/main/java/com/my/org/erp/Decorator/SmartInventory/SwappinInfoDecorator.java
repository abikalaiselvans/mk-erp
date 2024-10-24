package com.my.org.erp.Decorator.SmartInventory;

import org.displaytag.decorator.TableDecorator;

public class SwappinInfoDecorator extends TableDecorator
{
	 
	public String getSno() 
	{
		SwappingInfo actorData = (SwappingInfo)getCurrentRowObject();
		return actorData.getSno() ;
	}
	
	public String getBranch() {
		SwappingInfo actorData = (SwappingInfo)getCurrentRowObject();
		return actorData.getBranch() ;
		
	}
	public String getDivision() 
	{
		SwappingInfo actorData = (SwappingInfo)getCurrentRowObject();
		return actorData.getDivision() ;
		
	}
	public String getSalesno() {
		SwappingInfo actorData = (SwappingInfo)getCurrentRowObject();
		return actorData.getSalesno();
		
	}
	public String getType() {
		SwappingInfo actorData = (SwappingInfo)getCurrentRowObject();
		return actorData.getType();
		
	}
	public String getProduct() {
		SwappingInfo actorData = (SwappingInfo)getCurrentRowObject();
		return actorData.getProduct() ;
		
	}
	public String getDescription() {
		SwappingInfo actorData = (SwappingInfo)getCurrentRowObject();
		return actorData.getDescription();
		
	}
	public String getDate() {
		SwappingInfo actorData = (SwappingInfo)getCurrentRowObject();
		return actorData.getDate() ;
		
	}
	public String getSerialno() {
		SwappingInfo actorData = (SwappingInfo)getCurrentRowObject();
		return actorData.getSerialno() ;
		
	}
	public String getStatus() {
		SwappingInfo actorData = (SwappingInfo)getCurrentRowObject();
		return actorData.getStatus() ;
		
	}
	public String getSwappingserial() 
	{
		SwappingInfo actorData = (SwappingInfo)getCurrentRowObject();
		String href="<a href='1'>"+actorData.getSwappingserial()+"</a>";
		return href;
		
	}
	
}
