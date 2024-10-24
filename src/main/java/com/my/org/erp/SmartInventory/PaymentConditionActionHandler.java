package com.my.org.erp.SmartInventory;
import java.io.IOException;
 

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class PaymentConditionActionHandler extends AbstractActionHandler
{
 
	private void payConditionDelete(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{
			String []rowid= request.getParameterValues("rowid");							
			asql ="DELETE FROM inv_m_paymentcondition WHERE INT_PAYMENTCONDITIONID=?";
			apstm = con.prepareStatement(asql);
			for(int i=0;i<rowid.length;i++)
			{	
				apstm.setString(1,rowid[i]);
				apstm.addBatch();				
			}
			apstm.executeBatch();
			apstm.close(); 	
			
		}
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}
	}
	
	private void payConditionAdd(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{			
			HttpSession session=request.getSession();			
			String userid=""+session.getAttribute("USRID");		
			String name=""+request.getParameter("TxtpayName").trim();
			String description=request.getParameter("TxtpayDes");
			asql=" INSERT INTO inv_m_paymentcondition "; 
			asql = asql + " (CHR_PAYMENTNAME,CHR_DES,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS )";
			asql = asql + " VALUES ( ?,?,?,DATE(NOW()),'Y') ";
			apstm =con.prepareStatement(asql);
			apstm.setString(1,name.toUpperCase());
			apstm.setString(2,description.toUpperCase());
			apstm.setString(3,userid);
			apstm.execute();
			apstm.close();
			
		}
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}
	}
	private void payConditionEdit(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException{
		try{	
			String  rowid=""+request.getParameter("paytermId");
			HttpSession session=request.getSession();				
			String userid=""+session.getAttribute("USRID");
			String name=request.getParameter("TxtpayName").trim();
			String description=request.getParameter("TxtpayDes").trim();
			asql=" UPDATE inv_m_paymentcondition SET ";
			asql = asql + " CHR_PAYMENTNAME=?, CHR_DES=?,CHR_USRNAME=?,DT_UPDATEDATE=DATE(NOW()),CHR_UPDATESTATUS='Y' WHERE INT_PAYMENTCONDITIONID=?"; 
			apstm =con.prepareStatement(asql);
			apstm.setString(1,name.toUpperCase());
			apstm.setString(2,description.toUpperCase());
			apstm.setString(3,userid);
			apstm.setString(4,rowid);
			apstm.execute();
			apstm.close();
			
			
			
		}
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}
	}
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try{
				String action=request.getParameter("actionS");
				if(action.equals("INVpayConditionDelete")){					
					payConditionDelete(request, response);
					con.close();    
					response.sendRedirect("Smart Inventory/PaymentConditionView.jsp");
				}
				if("INVpayConditionAdd".equals(action)){					
					payConditionAdd(request, response);
					con.close();    
					response.sendRedirect("Smart Inventory/PaymentConditionView.jsp");
				}
				else if("INVpayConditionEdit".equals(action)){					
					payConditionEdit(request, response);
					con.close();   
					response.sendRedirect("Smart Inventory/PaymentConditionView.jsp");
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

