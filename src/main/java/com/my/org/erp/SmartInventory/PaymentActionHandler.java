package com.my.org.erp.SmartInventory;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class PaymentActionHandler extends AbstractActionHandler{
 	
	
	private void payDelete(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{
			String []rowid= request.getParameterValues("rowid");							
			asql ="DELETE FROM inv_m_paymentterms WHERE INT_PAYMENTTERMID=?";
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
	
	private void payAdd(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException{
		try{			
			HttpSession session=request.getSession();			
			String userid=""+session.getAttribute("USRID");		
			String name=""+request.getParameter("TxtPayment").trim();
			String description=request.getParameter("TxtPayDes");
			asql=" INSERT INTO inv_m_paymentterms ";
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
	
	private void payEdit(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{	
			String  rowid=""+request.getParameter("termId");
			HttpSession session=request.getSession();				
			String userid=""+session.getAttribute("USRID");
			String name=request.getParameter("TxtPayment").trim();
			String description=request.getParameter("TxtPayDes").trim();
			asql=" UPDATE inv_m_paymentterms SET ";
			asql = asql + " CHR_PAYMENTNAME=?,CHR_DES=?,CHR_USRNAME=?,DT_UPDATEDATE=DATE(NOW()),CHR_UPDATESTATUS='Y' WHERE INT_PAYMENTTERMID=?"; 
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
				if(action.equals("INVpayDelete")){					
					payDelete(request, response);
					con.close();    
					response.sendRedirect("Smart Inventory/PaymentTermView.jsp");
				}
				if("INVpayAdd".equals(action)){					
					payAdd(request, response);
					con.close();    
					response.sendRedirect("Smart Inventory/PaymentTermView.jsp");
				}
				else if("INVpayEdit".equals(action)){					
					payEdit(request, response);
					con.close();    
					response.sendRedirect("Smart Inventory/PaymentTermView.jsp");
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

