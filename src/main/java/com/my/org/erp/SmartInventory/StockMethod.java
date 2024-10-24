package com.my.org.erp.SmartInventory;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
@SuppressWarnings("serial")
public class StockMethod extends HttpServlet
{
		
	/*	
	 *	Start - Author :: Kalaiselvan----------------------Sales Payment-----------------------
	 * 	Date: 21/03/2006
	 *  
	 */
	public static void loadSalesPayment(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
    {
    	 try
    	 {
    		 	String month=request.getParameter("month");
		 		int year=Integer.parseInt(request.getParameter("year"));
		 		int mon=Integer.parseInt(month);
		 		String fDate=year+"-"+month+"-01";
		 		String tDate=year+"-"+month+"-"+com.my.org.erp.ServiceLogin.DateUtil.totalDays(mon, year);
		 		String sql=" SELECT CHR_SALESORDERNO, INT_CUSTOMERID,DOU_TOTALAMOUNT , CHR_PAYMENTSTATUS  ,DAT_SALEDATE";
		 		sql = sql +" FROM  inv_t_customersalesorder   ";
		 		sql = sql +" WHERE DAT_SALEDATE >='"+fDate+"'"; 
		 		sql = sql +" AND DAT_SALEDATE <='"+tDate+"'";
		 		sql = sql +" ORDER BY CHR_SALESORDERNO ";
		 		String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		 		StringBuffer sb = new StringBuffer();
		 		String StartLetter = ""+request.getParameter("id");
		 		for(int u=0;u<20;u++);
		 			//System.out.println();
		 		//System.out.println(sql);
		 		
		 		@SuppressWarnings("unused")
				boolean flag = false;
		 		if (readData.length > 0)
		 		{	
		 			for(int u=0; u<readData.length;u++)
		 			{
		 	 			if(readData[u][0].startsWith(StartLetter) || "0".startsWith(StartLetter))
		 	 			{
		 	 				sb.append("<Payment>");
		 	 				sb.append("<Customerid>" + readData[u][0]+  "</Customerid>");
		 	 				sql = "SELECT CHR_CUSTOMERNAME FROM inv_m_customerinfo WHERE INT_CUSTOMERID ="+Integer.parseInt(readData[u][1]);
		    	     		String customer= com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql,"CHR_CUSTOMERNAME");
		    	     		sb.append("<Customername>" +customer+ "</Customername>");
		 	 				sb.append("<Totalamount>" + readData[u][2]+ "</Totalamount>");
		 	 				sb.append("<Status>" +  readData[u][3]+"</Status>");
		 	 				sql = "select sum(DOU_PAIDAMOUNT) from   inv_t_customersalespayment   where CHR_SALESORDERNO ='"+readData[u][0]+"'";
		 	 				String paidamount[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		    	     		String paid =paidamount[0][0].trim();
		    	     		if("-".equals(paid))
		    	     			paid="0.0";
		    	     		else
		    	     			paid =paidamount[0][0].trim();
		    	     		double balance=0.0;
		    	     		balance= Double.parseDouble(readData[u][2])-Double.parseDouble(paid);
		    	     		String ck="";
		    	     		if(balance<0)
		    	     		{
		    	     			balance=0.0;
		    	     			ck="(Check)";
		    	     		}	
		    	     		sb.append("<Paidamount>"+paid+"</Paidamount>");
		    	     		sb.append("<Balance>"+balance+ck+"</Balance>");
		    	     		sb.append("<OrderDate>" +  readData[u][4]+"</OrderDate>");
		 	 				sb.append("</Payment>");
		 	 				
		 	 			}	
		 			}
		 			response.setContentType("text/xml");
		 			response.setHeader("Cache-Control", "no-cache");
		 			response.getWriter().write("<Payments>" + sb.toString() + "</Payments>");
		 		} 
		 		else 
		 		{
		 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
		 		}			     	 	 
 	 		 
    	 } 
    	 catch (Exception e) 
    	 {
			 System.out.println(e.getMessage());
			//System.out.println(e);
    	 } 
    }	
	//	End - Author :: Kalaiselvan----------------------Sales Payment-----------------------
	
    
	
}
