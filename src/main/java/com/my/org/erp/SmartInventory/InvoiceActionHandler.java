package com.my.org.erp.SmartInventory;
import java.io.IOException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 

import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class InvoiceActionHandler extends AbstractActionHandler
{
	 
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	 {
		try
		{
				String action=request.getParameter("actionS");
				 			
				 
				Statement st = con.createStatement();
				String sql="";
				if("INVInvoice".equals(action))
				{
					String invnumber =request.getParameter("invnumber"); 
					String invDate =request.getParameter("invDate");
					String salno =request.getParameter("salno");
					sql = sql +" UPDATE  inv_t_customersalesorder   SET ";
					sql = sql +" CHR_INVOICENO = '"+invnumber+"' , ";
					sql = sql +" DT_INVOICEDATE = '"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(invDate)+"' , ";
					sql = sql +" CHR_INVOICESTATUS ='Y'";
					sql = sql +" WHERE CHR_SALESORDERNO= '"+salno+"' ";
					st.execute(sql);
					con.close();    
					response.sendRedirect("Smart Inventory/Invoice.jsp");
				}
				else if("INVDelivarySerialAdd".equals(action))
				{
					con.close();    
					response.sendRedirect("Smart Inventory/Delivary Challan.jsp");
				}
				else if("INVDelivaryChallanEdit".equals(action))
				{
					sql="";
					 
					con.close();   
					 response.sendRedirect("Smart Inventory/SalesItemSerialnoEntry.jsp?delivaryId=");					
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