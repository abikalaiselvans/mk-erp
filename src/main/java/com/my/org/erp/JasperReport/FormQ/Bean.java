package com.my.org.erp.JasperReport.FormQ;


import java.util.List;



public class Bean {

	 private String query;
	public List generate(String month,String year,String path,String fName, String  sourceFileName){
		
		int days=getDaysPerMonth(month, year);
		query="SELECT b.CHR_EMPID,b.CHR_STAFFNAME,b.DT_DOB,c.CHR_DESIGNAME,";
		for(int i=1;i<=days;i++)
			query+="a.CHR_MORNING"+i+", a.CHR_EVENING"+i+",";
		query+="a.CHR_MONTH,a.INT_YEAR FROM att_t_register a, com_m_staff b,com_m_desig c WHERE a.CHR_MONTH=? AND a.INT_YEAR=? AND b.CHR_EMPID =a.CHR_EMPID"; 
	    query+=" AND c.INT_DESIGID = b.INT_DESIGID ORDER BY b.CHR_STAFFNAME";
	    
		DAO dao=new DAO();
		List list=dao.getRecords(month, year,days);
		 
		return list;
		
	}
	public String getQuery(){
		return query;
	}
	public Integer getDaysPerMonth(String monthname,String yearargs)
	{
		
		    int year = Integer.parseInt(yearargs);
		    int mon=0;
	        if(monthname.equalsIgnoreCase("January"))
	            mon = 1;
	        else  if(monthname.equalsIgnoreCase("February"))
	            mon = 2;
	        else  if(monthname.equalsIgnoreCase("March"))
	            mon = 3;
	        else  if(monthname.equalsIgnoreCase("April"))
	            mon = 4;
	        else if(monthname.equalsIgnoreCase("May"))
	            mon = 5;
	        else if(monthname.equalsIgnoreCase("June"))
	            mon = 6;
	        else  if(monthname.equalsIgnoreCase("July"))
	            mon = 7;
	        else if(monthname.equalsIgnoreCase("August"))
	            mon = 8;
	        else  if(monthname.equalsIgnoreCase("September"))
	            mon = 9;
	        else  if(monthname.equalsIgnoreCase("October"))
	            mon = 10;
	        else  if(monthname.equalsIgnoreCase("November"))
	            mon = 11;
	        else  if(monthname.equalsIgnoreCase("December"))
	            mon = 12;
	        
	        
	        int listTotalDays[] = { 0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31   };
	        if(year % 4 == 0)
	            listTotalDays[2] = 29;
	        return listTotalDays[mon];
	}

}
