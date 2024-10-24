package com.my.org.erp.SmartInventory;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 

import com.my.org.erp.common.CommonInfo;
import com.my.org.erp.ServiceLogin.DateUtil;
@SuppressWarnings("serial")
public class ReportCustomerMethod extends HttpServlet
{
	
	public static void loadQuotation(HttpServletRequest request, HttpServletResponse response)throws IOException, ServletException 
	{
		try
		{	
			@SuppressWarnings("unused")
			String action=request.getParameter("actionS");
			String month=request.getParameter("month");
	 		int year=Integer.parseInt(request.getParameter("year"));
	 		int mon=Integer.parseInt(month);
	 		String fDate=year+"-"+month+"-01";
	 		String tDate=year+"-"+month+"-"+com.my.org.erp.ServiceLogin.DateUtil.totalDays(mon, year);
	 		 		
	 		String sql=" SELECT a.INT_QUOTATIONID,a.CHR_QUOTATIONNO,b.CHR_CUSTOMERNAME,a.DAT_QUOTATIONDATE,";
	 		sql = sql +" a.DAT_REQUESTDATE , a.INT_ONHOLD,a.INT_CONDITIONID,a.CHR_DES,a.DOU_TOTALAMOUNT,a.INT_QUOTATIONSTATUS"; 
	 		sql = sql +" FROM  inv_t_customerquotation  a ,inv_m_customerinfo b";
	 		sql = sql +" where a.DAT_QUOTATIONDATE>='"+fDate+"' ";
	 		sql = sql +" AND a.DAT_QUOTATIONDATE<='"+tDate+"'  ";
	 		sql = sql +" AND a.INT_CUSTOMERID =b.INT_CUSTOMERID";
	 		sql = sql +" order by a.DAT_QUOTATIONDATE";
	 		String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	 		StringBuffer sb = new StringBuffer();
	 		String StartLetter = ""+request.getParameter("id");
	 		if(readData.length>0)
	 		{	
	 			for(int u=0; u<readData.length;u++)
	 			{
	 				if(readData[u][1].toUpperCase().startsWith(StartLetter) || "0".startsWith(StartLetter))
	 				{
	 					sb.append("<quotation>");
	 				    sb.append("<id>" + readData[u][0]+ "</id>");
	 	                sb.append("<quotationNo>" + readData[u][1]+ "</quotationNo>");
	 	                if(!readData[u][3].equals("-"))
	 	                	sb.append("<quotationDate>" + DateUtil.FormateDateSys(readData[u][3])+ "</quotationDate>");
	 	                else
	 	                	sb.append("<quotationDate>" + readData[u][3]+ "</quotationDate>");
	 	                
	 	                sb.append("<customerName>" + readData[u][2]+ "</customerName>");
	 	               
	 	                if(!readData[u][4].equals("-"))
	 	                	sb.append("<reqDate>" + DateUtil.FormateDateSys(readData[u][4])+ "</reqDate>");
	 	                else
	 	                	sb.append("<reqDate>" + readData[u][4]+ "</reqDate>");
	 	                sb.append("<onHold>" + readData[u][5]+ "</onHold>");
	 	                sb.append("<quotationStatus>" + readData[u][9] + "</quotationStatus>");
	 	                sb.append("<credit>" + readData[u][7]+ "</credit>");
	 	                sb.append("<totalAmount>" +readData[u][8]+ "</totalAmount>");                
	 	                sb.append("</quotation>");	
		 				}	
	 			}
	 			 
	 			response.setContentType("text/xml");
	 			response.setHeader("Cache-Control", "no-cache");		 			
	 			response.getWriter().write("<quotations>" + sb.toString() + "</quotations>");
	 		} 
	 		else 
	 		{
	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
	 		} 
	 
		}
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}
	}	
	
	 public static void loadSalesOrder(HttpServletRequest request, HttpServletResponse  response)
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
	    	     String sql = " SELECT a.INT_QUOTATIONID,a.CHR_QUOTATIONNO,b.CHR_CUSTOMERNAME,a.DAT_QUOTATIONDATE,a.INT_QUOTATIONSTATUS"; 
	    	     sql = sql +" FROM  inv_t_customerquotation  a ,inv_m_customerinfo b";
	    	     sql = sql +" where a.DAT_QUOTATIONDATE>='"+fDate+"' ";
	    	     sql = sql +" AND a.DAT_QUOTATIONDATE<='"+tDate+"'  ";
	    	     sql = sql +" AND a.INT_CUSTOMERID =b.INT_CUSTOMERID";
	    	     sql = sql +" order by a.INT_QUOTATIONID";
	    	     String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	    	     StringBuffer sb = new StringBuffer();
			 	 if(readData.length >0)
			 	 {
			 		 for(int u=0; u<readData.length;u++)
			 		 {
			 			
			 			if(readData[u][2].toUpperCase().startsWith(txtSer.toUpperCase()) || "0".equals(txtSer))
			    	     {	    	     
			 				sb.append("<SalesOrder>");
		     				sb.append("<quoId>" + readData[u][0] +"</quoId>");
		     				sb.append("<quoNo>" + readData[u][1] +"</quoNo>");
		     				if(!readData[u][3].equals("-"))
		     					sb.append("<quoDate>" + DateUtil.FormateDateSys(readData[u][3])+ "</quoDate>");
		     				else
		     					sb.append("<quoDate>" +readData[u][3]+ "</quoDate>");
		     				
		     				sb.append("<quoStatus>" + readData[u][4]+ "</quoStatus>");	
		     				sb.append("<quoCust>" + readData[u][2]+ "</quoCust>");
		     				sql="SELECT CHR_SALESORDERNO,DAT_SALEDATE,CHR_DELIVERYSTATUS FROM  inv_t_customersalesorder   " +
		     				"WHERE CHR_QUOTATIONNO= '"+readData[u][1]+"'";
		                	String salesOrder[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		                	if(salesOrder.length>0)
		                	{
		                		sb.append("<salNo>" + salesOrder[0][0]+ "</salNo>");
			     				sb.append("<salDate>" + salesOrder[0][1]+ "</salDate>");
			     				sb.append("<salStatus>" + salesOrder[0][2]+ "</salStatus>");
		                	}
		                	else
		                	{	
		                		sb.append("<salNo>-</salNo>");
		                		sb.append("<salDate>-</salDate>");
		                		sb.append("<salStatus>-</salStatus>");
		                	}
		                	sb.append("</SalesOrder>");	
			    	     }
		     		}
			 		 
			 		response.setContentType("text/xml");
	 	     		response.setHeader("Cache-Control", "no-cache");
	 	     		response.getWriter().write("<SalesOrders>" + sb.toString() + "</SalesOrders>");
	 	     	} 
	 	     	else 
	 	     	{
	 	     		response.setStatus(HttpServletResponse.SC_NO_CONTENT);
	 	     	}	
	             
			} 
	    	 catch (Exception e) 
	 		{
	 			System.out.println(e.getMessage());
	 			request.setAttribute("error", e.getMessage() );
	 	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	 	    	dispatchers.forward(request, response); 

	 		}
	    }
	 
	 
	 public static  void loadDelData(HttpServletRequest request, HttpServletResponse response) 
		{
		 try 
		  	{
			 
			 		 
		    		String txtSer=""+request.getParameter("txtSer");
		    		if(txtSer.equals("null")) txtSer="";
		    	     	String month=request.getParameter("month");
		    	    int year=Integer.parseInt(request.getParameter("year"));    	     
		    	    int mon=Integer.parseInt(month);    	     
		    	    String fDate=year+"-"+month+"-01";
		    	    String tDate=year+"-"+month+"-"+com.my.org.erp.ServiceLogin.DateUtil.totalDays(mon, year);
		    	    String sql ="SELECT a.CHR_QUOTATIONNO,a.CHR_CUSTPURCHASENO ,a.CHR_SALESORDERNO,a.CHR_SALEBY,a.DAT_SALEDATE,b.CHR_CUSTOMERNAME,";
		    	    sql = sql +" a.CHR_DELIVERYSTATUS  FROM  inv_t_customersalesorder   a ,inv_m_customerinfo b ";
		    	    sql = sql +" where a.DAT_SALEDATE>='"+fDate+"' ";
		    	    sql = sql+" AND a.DAT_SALEDATE<='"+tDate+"' ";
		    	    sql = sql+" AND a.INT_CUSTOMERID =b.INT_CUSTOMERID  order by a.DAT_SALEDATE";
	    		    	    
		    	    String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		
		    	    
		    	    StringBuffer sb = new StringBuffer();
		            if(readData.length >0)
				 	{
				 		 for(int u=0; u<readData.length;u++)
				 		 {
				 			
				 			  String query = "select CHR_SALESORDERNO,CHR_DELIVERYNO,DT_DELIVERYDATE from  inv_t_customersalesorderitemserial   WHERE CHR_SALESORDERNO='"+readData[u][2]+"' AND  CHR_DELIVERYNO is not null GROUP by CHR_DELIVERYNO" ;
					    	  @SuppressWarnings("unused")
							String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(query);			  
				 			//System.out.println("Mydata:"+data[0][1]);
					    	  if(readData[u][2].toUpperCase().startsWith(txtSer.toUpperCase()) || "0".equals(txtSer))
				    	     {	    	     
				 				sb.append("<Delivery>");
			     				sb.append("<Qno>" + readData[u][0] +"</Qno>");
			     				sb.append("<Custpurchaseno>" + readData[u][1] +"</Custpurchaseno>");
			     				sb.append("<Saleno>" + readData[u][2]+ "</Saleno>");
			     				sb.append("<Saleby>" + readData[u][3]+ "</Saleby>"); 				
			     	           	sb.append("<Saledate>" + readData[u][4]+ "</Saledate>");
			                	sb.append("<Custname>" + readData[u][5]+ "</Custname>");
				     			sb.append("<Status>" + readData[u][6]+ "</Status>");
				     			sb.append("<Did>" + readData[0][1]+ "</Did>");
				     			sb.append("</Delivery>");	
				    	     }
			     		}	
				 		response.setContentType("text/xml");
		 	     		response.setHeader("Cache-Control", "no-cache");
		 	     		response.getWriter().write("<Deliverys>" + sb.toString() + "</Deliverys>");
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
	
	 	 

	    public static  void loadInvoiceData(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	    {
	    	try 
	    		{
	    		  
	    		  
	    		 String txtSer=""+request.getParameter("txtSer");
	    		 String month=request.getParameter("month");
	    	     int year=Integer.parseInt(request.getParameter("year"));    	     
	    	     int mon=Integer.parseInt(month);    	     
	    	     String fDate=year+"-"+month+"-01";
	    	     String tDate=year+"-"+month+"-"+com.my.org.erp.ServiceLogin.DateUtil.totalDays(mon, year);
	    	     String sql=" SELECT  a.CHR_QUOTATIONNO,a.CHR_INVOICENO,a.DT_INVOICEDATE,a.CHR_SALESORDERNO,";
	    	     sql = sql + " b.CHR_CUSTOMERNAME ,a.CHR_INVOICESTATUS ";
	    	     sql = sql + " FROM  inv_t_customersalesorder   a ,inv_m_customerinfo b ";
	    	     sql = sql + " where a.DAT_SALEDATE>='"+fDate+"'  ";
	    	     sql = sql + " AND a.DAT_SALEDATE<='"+tDate+"' ";
	    	     sql = sql + " AND a.INT_CUSTOMERID = b.INT_CUSTOMERID ";
	    	     sql = sql + "  and CHR_DELIVERYSTATUS='Y' order by a.DAT_SALEDATE ";
	    	     String readData[][] = com.my.org.erp.common.CommonInfo.KRecordSetArray(sql);
	             StringBuffer sb = new StringBuffer();
			 	 if(readData.length >0)
			 	 {
			 		 for(int u=0; u<readData.length;u++)
			 		 {
	                	if(readData[u][0].toUpperCase().startsWith(txtSer.toUpperCase()) || "0".equals(txtSer))
			    	     {
			 				sb.append("<Invoice>");
			 				sb.append("<Quotationid>" + readData[u][0]+ "</Quotationid>");
			 				sb.append("<Invnumber>" + readData[u][1]+ "</Invnumber>");
			     			sb.append("<Invdate>" +readData[u][2]+ "</Invdate>");
			     			sb.append("<SalesOrderNo>" +readData[u][3]+ "</SalesOrderNo>");
			     			sb.append("<Customername>" + readData[u][4]+ "</Customername>");
			     			sb.append("<Invstatus>" + readData[u][5]+ "</Invstatus>");
		                	sb.append("</Invoice>");	
			    	     }
		     		}
			 		response.setContentType("text/xml");
	 	     		response.setHeader("Cache-Control", "no-cache");
	 	     		response.getWriter().write("<invoices>" + sb.toString() + "</invoices>");
	 	     	} 
	 	     	else 
	 	     		response.setStatus(HttpServletResponse.SC_NO_CONTENT);
	    	 	} 
	    	catch (Exception e) 
			{
				System.out.println(e.getMessage());
				request.setAttribute("error", e.getMessage() );
		        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
		    	dispatchers.forward(request, response); 

			}
		}
	    
	    public static  void loadCashSale(HttpServletRequest request, HttpServletResponse  response)
	    throws IOException, ServletException 
	    {
	    	 try 
	    	 {
	    		  
	    		 String txtSer=""+request.getParameter("txtSer");
	    		 if(txtSer.equals("null")) txtSer="";
	    	     String month=request.getParameter("month");
	    	     int year=Integer.parseInt(request.getParameter("year"));    	     
	    	     int mon=Integer.parseInt(month);    	     
	    	     String fDate=year+"-"+month+"-01";
	    	     String tDate=year+"-"+month+"-"+com.my.org.erp.ServiceLogin.DateUtil.totalDays(mon, year);
	    	     String sql="SELECT INT_SALESID,CHR_SALESNO,INT_CUSTOMERID,DAT_SALESDATE" +
	    	     		" ,DOU_TOTALAMOUNT,CHR_PAYMENTSTATUS FROM inv_t_cashsales " +
	    	     		" where DAT_SALESDATE>='"+fDate+"' AND DAT_SALESDATE<='"+tDate+"' " +	    	     		
	    	     		" order by DAT_SALESDATE";
	    	     String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	             StringBuffer sb = new StringBuffer();
			 	 if(readData.length >0)
			 	 {
			 		 for(int u=0; u<readData.length;u++)
			 		 {
			 			 if(readData[u][2].toUpperCase().startsWith(txtSer.toUpperCase()) || "0".equals(txtSer))
			    	     {	    	     
			 				sb.append("<cashSale>");
		     				sb.append("<salId>" + readData[u][0] +"</salId>");
		     				sb.append("<salNo>" + readData[u][1] +"</salNo>");
		     				sb.append("<salDate>" + readData[u][3]+ "</salDate>");
		     				sb.append("<salTotal>" + readData[u][4]+ "</salTotal>");
		     				if(!readData[u][2].equals("-"))
		     				{
		     					String csql="Select CHR_CUSTOMERNAME from  inv_m_customerinfo where INT_CUSTOMERID="+readData[u][2];
		     					String custName=CommonInfo.stringGetAnySelectField(csql,"CHR_CUSTOMERNAME");
		     					sb.append("<quoCust>" +custName + "</quoCust>");
		     				}
		     				else
		     					sb.append("<quoCust>-</quoCust>");
		                	sb.append("</cashSale>");
			    	     }
		     		}	
			 		response.setContentType("text/xml");
	 	     		response.setHeader("Cache-Control", "no-cache");
	 	     		response.getWriter().write("<cashSales>" + sb.toString() + "</cashSales>");
	 	     	} 
	 	     	else 
	 	     	{
	 	     		response.setStatus(HttpServletResponse.SC_NO_CONTENT);
	 	     	}             
			} 
	    	 catch (Exception e) 
	 		{
	 			System.out.println(e.getMessage());
	 			request.setAttribute("error", e.getMessage() );
	 	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	 	    	dispatchers.forward(request, response); 

	 		}
	    }
	   
	    
		public static void loadSalesPayment(HttpServletRequest request, HttpServletResponse  response)
	    throws IOException, ServletException 
	    {
	    	 try
	    	 {
	    		 	String payType=request.getParameter("payType");
	    		 	String month=request.getParameter("month");
			 		int year=Integer.parseInt(request.getParameter("year"));
			 		int mon=Integer.parseInt(month);
			 		String fDate=year+"-"+month+"-01";
			 		String tDate=year+"-"+month+"-"+com.my.org.erp.ServiceLogin.DateUtil.totalDays(mon, year);
			 		String sql="";
			 		if(payType.equals("Invoice"))
			 		{
				 		sql=" SELECT CHR_INVOICENO,INT_CUSTOMERID,DOU_TOTALAMOUNT,CHR_PAYMENTSTATUS,DT_INVOICEDATE";
				 		sql = sql +" FROM  inv_t_customersalesorder   ";
				 		sql = sql +" WHERE DT_INVOICEDATE >='"+fDate+"'"; 
				 		sql = sql +" AND DT_INVOICEDATE <='"+tDate+"'";
				 		sql = sql +" ORDER BY DT_INVOICEDATE ";
			 		}
			 		else if(payType.equals("CashPay"))
			 		{
			 			sql=" SELECT CHR_SALESNO,INT_CUSTOMERID,DOU_TOTALAMOUNT,CHR_PAYMENTSTATUS,DAT_SALESDATE";
				 		sql = sql +" FROM inv_t_cashsales ";
				 		sql = sql +" WHERE DAT_SALESDATE >='"+fDate+"'"; 
				 		sql = sql +" AND DAT_SALESDATE <='"+tDate+"'";
				 		sql = sql +" ORDER BY DAT_SALESDATE ";
			 		}
			 		else if(payType.equals("Direct")){
			 			sql=" SELECT CHR_SALESNO,INT_CUSTOMERID,DOU_TOTALAMOUNT,CHR_PAYMENTSTATUS,DAT_SALESDATE";
				 		sql = sql +" FROM inv_t_directsales ";
				 		sql = sql +" WHERE DAT_SALESDATE >='"+fDate+"'"; 
				 		sql = sql +" AND DAT_SALESDATE <='"+tDate+"'";
				 		sql = sql +" ORDER BY DAT_SALESDATE ";
			 		}
			 		String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			 		StringBuffer sb = new StringBuffer();
			 		String StartLetter = ""+request.getParameter("id");
			 		if (readData.length > 0)
			 		{	
			 			for(int u=0; u<readData.length;u++)
			 			{
			 	 			if(readData[u][0].toUpperCase().startsWith(StartLetter.toUpperCase()) || "0".startsWith(StartLetter))
			 	 			{
			 	 				sb.append("<Payment>");
			 	 				sb.append("<Customerid>" + readData[u][0]+  "</Customerid>");
			 	 				sql = "SELECT CHR_CUSTOMERNAME FROM inv_m_customerinfo WHERE INT_CUSTOMERID ="+readData[u][1];
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
			    	     			paid=paidamount[0][0].trim();
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
			 	 				//Customerid,Customername,Totalamount,Status,Paidamount,Balance,OrderDate
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
	 			request.setAttribute("error", e.getMessage() );
	 	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	 	    	dispatchers.forward(request, response); 

	 		} 
	    }	
}

