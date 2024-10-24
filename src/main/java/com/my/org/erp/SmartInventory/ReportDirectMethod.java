package com.my.org.erp.SmartInventory;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 

import com.my.org.erp.common.CommonInfo;
@SuppressWarnings("serial")
public class ReportDirectMethod extends HttpServlet
{
    
    public  static void loadDirectPurchase(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
    {
    	 try 
    	 {
    		  
    		 String txtSer=""+request.getParameter("txtSer");
    		 
    		 String month=request.getParameter("month");
    	     int year=Integer.parseInt(request.getParameter("year"));    	     
    	     int mon=Integer.parseInt(month);    	     
    	     String fDate=year+"-"+month+"-01";
    	     String tDate=year+"-"+month+"-"+com.my.org.erp.ServiceLogin.DateUtil.totalDays(mon, year);
    	     String sql="SELECT INT_PURCHASEORDERID,CHR_PURCHASEORDERNO,INT_VENDORID,DAT_ORDERDATE" +
    	     		" ,DOU_TOTALAMOUNT,CHR_PAYMENTSTATUS FROM inv_t_directpurchase " +
    	     		" where DAT_ORDERDATE>='"+fDate+"' AND DAT_ORDERDATE<='"+tDate+"' " ;
    	     if( ! "0".equals(txtSer))
    	    	 sql = sql +" AND CHR_PURCHASEORDERNO LIKE '"+txtSer+"%'";
    	     sql = sql+ "  order by DAT_ORDERDATE";
    	     String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
    	     StringBuffer sb = new StringBuffer();
		 	 if(readData.length >0)
		 	 {
		 		 for(int u=0; u<readData.length;u++)
		 		 {
		 			 	sb.append("<directPurchase>");
	     				sb.append("<salId>" + readData[u][0] +"</salId>");
	     				sb.append("<salNo>" + readData[u][1] +"</salNo>");
	     				sb.append("<salDate>" + readData[u][3]+ "</salDate>");
	     				String csql="Select CHR_VENDORNAME from   inv_m_vendorsinformation  where INT_VENDORID="+readData[u][2];
	     				String ventName=CommonInfo.stringGetAnySelectField(csql,"CHR_VENDORNAME");		                
	     				sb.append("<salTotal>" + readData[u][4]+ "</salTotal>");
	                	sb.append("<quoCust>" + ventName+ "</quoCust>");                	
	                	sb.append("</directPurchase>");
		    	}	
		 		response.setContentType("text/xml");
 	     		response.setHeader("Cache-Control", "no-cache");
 	     		response.getWriter().write("<directPurchases>" + sb.toString() + "</directPurchases>");
 	     	} 
 	     	else 
 	     	{
 	     		response.setStatus(HttpServletResponse.SC_NO_CONTENT);
 	     	}             
		} catch (Exception e) {
			 
			 System.out.println(e.getMessage());
		} 
    }

    
    public  static void loadDirectSale(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
    {
    	 try 
    	 {
    		 
    		 String txtSer=""+request.getParameter("txtSer");
    		 txtSer = txtSer.toUpperCase();
    		 String month=request.getParameter("month");
    	     int year=Integer.parseInt(request.getParameter("year"));    	     
    	     int mon=Integer.parseInt(month);    	     
    	     String fDate=year+"-"+month+"-01";
    	     String tDate=year+"-"+month+"-"+com.my.org.erp.ServiceLogin.DateUtil.totalDays(mon, year);
    	     String sql="SELECT INT_SALESID,CHR_SALESNO,INT_CUSTOMERID,DAT_SALESDATE" +
    	     		" ,DOU_TOTALAMOUNT,CHR_PAYMENTSTATUS FROM inv_t_directsales " +
    	     		" where DAT_SALESDATE>='"+fDate+"' AND DAT_SALESDATE<='"+tDate+"' " ;
    	     if( ! "0".equals(txtSer))
    	    	 sql = sql +" AND CHR_SALESNO LIKE '"+txtSer+"%'";
    	     
    	     sql = sql+ "  order by DAT_SALESDATE";
    	     String readData[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sql);
             StringBuffer sb = new StringBuffer();
		 	 if(readData.length >0)
		 	 {
		 		 for(int u=0; u<readData.length;u++)
		 		 {
		 			 	sb.append("<directSale>");
	     				sb.append("<salId>" + readData[u][0] +"</salId>");
	     				sb.append("<salNo>" + readData[u][1] +"</salNo>");
	     				sb.append("<salDate>" + readData[u][3]+ "</salDate>");
	     				sb.append("<salTotal>" + readData[u][4]+ "</salTotal>");
	     				String csql="Select CHR_CUSTOMERNAME from  inv_m_customerinfo where INT_CUSTOMERID="+readData[u][2];
	     				String custName=CommonInfo.stringGetAnySelectField(csql,"CHR_CUSTOMERNAME");
	                	sb.append("<quoCust>" + custName+ "</quoCust>");                	
	                	sb.append("</directSale>");
		 		 }
		 		response.setContentType("text/xml");
 	     		response.setHeader("Cache-Control", "no-cache");
 	     		response.getWriter().write("<directSales>" + sb.toString() + "</directSales>");
 	     	} 
 	     	else 
 	     	{
 	     		response.setStatus(HttpServletResponse.SC_NO_CONTENT);
 	     	}             
		} 
    	 catch (Exception e) 
    	 {
			 System.out.println(e.getMessage());
		} 
    }
    
	
    public  static void loadBranchData(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException {
    	 try 
    	 {    		 	
    		 	int id=Integer.parseInt(request.getParameter("id"));
    		 	String stltr=""+request.getParameter("startLetter");
    		 	//System.out.println("Id"+id);
    		 	String sql=null;
    		 	if(stltr.equals("null"))
    		 	{
    		 		sql="SELECT INT_BRANCHID,CHR_BRANCHNAME,CHR_LEGALNAME,CHR_CITY,CHR_COUNTRY,CHR_EMAIL ";
        		 	sql=sql+"FROM  com_m_branch  WHERE INT_COMPANYID="+id;
        		 
    		 	}
    		 	else
    		 	{
    		 	  sql="SELECT INT_BRANCHID,CHR_BRANCHNAME,CHR_LEGALNAME,CHR_CITY,CHR_COUNTRY,CHR_EMAIL ";
    		 	  sql=sql+"FROM  com_m_branch  WHERE INT_COMPANYID="+id+" AND CHR_BRANCHNAME LIKE'"+stltr+"%'";
    		 	}
    		 	////System.out.println("Branch sql---------------------------------"+sql);
    	     	String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
    	     	StringBuffer sb = new StringBuffer(); 
    	     	////System.out.println(readData.length);
    	     	boolean flag = false;
    	     	for(int u=0; u<readData.length;u++)
    	     	{
    	     		sb.append("<branch>");    	     		
                    sb.append("<id>"+readData[u][0]+"</id>");
                    sb.append("<branchName>"+readData[u][1]+"</branchName>");
                    sb.append("<legalName>"+readData[u][2]+"</legalName>");
                    sb.append("<city>"+readData[u][3]+"</city>");                      
                    sb.append("<country>" +readData[u][4]+"</country>");
                    sb.append("<email>"+readData[u][5]+"</email>");                                
                    sb.append("</branch>");
                    flag = true;
    	     	}    	     	
    	     	if (flag) 
    	     	{
    	     		
    	     		response.setContentType("text/xml");
    	     		response.setHeader("Cache-Control", "no-cache");
    	     		////System.out.println("---------------------------------"+sb.toString());
    	     		response.getWriter().write("<branches>" + sb.toString() + "</branches>");
    	     	} 
    	     	else 
    	     	{
    	     		response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    	     	}			     	 	 
    	 	} 
    	 	catch (Exception e) 
    	 	{
    	 		 
    	 	} 
    }    
    
	
    public  static void loadDemo(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException {
    	try{	
			String comp=""+request.getParameter("comp");
			String branch=""+request.getParameter("branch");
			String mon=""+request.getParameter("month");
			String month=com.my.org.erp.ServiceLogin.DateUtil.getMonth(Integer.parseInt(mon));
			String year=""+request.getParameter("year");
			String txtSer=""+request.getParameter("txtSer");
			String query="";
			if(comp.equals("0")&& branch.equals("0"))
			{
				if(txtSer.equals("0"))
				{
				query="select * from inv_t_demo where CHR_MONTH='"+month+"' AND INT_YEAR="+year+" ";
				}
				else
				{
				query="select * from inv_t_demo where CHR_MONTH='"+month+"' AND INT_YEAR="+year+" AND CHR_CUSTNAME LIKE '"+txtSer+"%' ";	
				}
			}else{
			if(txtSer.equals("0"))
			{
			query="select * from inv_t_demo where INT_COMPANYID="+Integer.parseInt(comp)+" AND INT_BRANCHID="+Integer.parseInt(branch)+" AND CHR_MONTH='"+month+"' AND INT_YEAR="+year+" ";
			}
			else
			{
			query="select * from inv_t_demo where INT_COMPANYID="+Integer.parseInt(comp)+" AND INT_BRANCHID="+Integer.parseInt(branch)+" AND CHR_MONTH='"+month+"' AND INT_YEAR="+year+" AND CHR_CUSTNAME LIKE '"+txtSer+"%' ";	
			}	}
			String company[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(query);
			StringBuffer sb = new StringBuffer();
			boolean namesAdded = false;		
	        for(int k=0;k<company.length;k++){
	        		namesAdded=true;
	            	sb.append("<Demo>");
	                sb.append("<id>" +company[k][2]+ "</id>");
	                sb.append("<customerName>" + company[k][4]+ "</customerName>");  
	                sb.append("<customerDate>" + company[k][5]+ "</customerDate>");	             
	                sb.append("</Demo>");         	            	
	        }    
	        
		    if (namesAdded) {
			    response.setContentType("text/xml");
	            response.setHeader("Cache-Control", "no-cache");
		        response.getWriter().write("<demos>" + sb.toString() + "</demos>");
			} else {
	            //nothing to show
	        response.setStatus(HttpServletResponse.SC_NO_CONTENT);
	        }
		}
		catch(Exception e){
			 
		}
			
	}	

    
}

