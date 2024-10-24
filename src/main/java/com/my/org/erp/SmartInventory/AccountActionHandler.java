package com.my.org.erp.SmartInventory;
import java.io.IOException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.my.org.erp.ServiceLogin.AbstractActionHandler;
public class AccountActionHandler extends AbstractActionHandler
{
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{		
		try
		{
				String action=""+request.getParameter("actionS").trim();
				String sql="";
				if("INVDirectDCUpdate".equals(action))
				{
					String desc = request.getParameter("desc");
					String flag = request.getParameter("flag");
					String pono = request.getParameter("pono");
					
					if("Y".equals(flag))
					{
						asql = "UPDATE inv_t_directpurchase SET CHR_ACCOUNTFLAG='Y', CHR_ACCOUNTDESC=? WHERE CHR_PURCHASEORDERNO=?";
						apstm = con.prepareStatement(asql);
						apstm.setString(1, desc);
						apstm.setString(2, pono);
						apstm.execute();
						apstm.close();
						con.close();    
						response.sendRedirect("Smart Inventory/AccountDirectPurchase.jsp");
					}
					else
					{
						asql = "UPDATE inv_t_directpurchase SET CHR_ACCOUNTFLAG='N', CHR_ACCOUNTDESC=? WHERE CHR_PURCHASEORDERNO=?";
						apstm = con.prepareStatement(asql);
						apstm.setString(1, "");
						apstm.setString(2, pono);
						apstm.execute();
						apstm.close();
						con.close();    
						response.sendRedirect("Smart Inventory/AccountDirectPurchase.jsp");
					}
					
				}
				else if("INVDirectSalesDCUpdate".equals(action))
				{
					String desc = request.getParameter("desc");
					String flag = request.getParameter("flag");
					String salesno = request.getParameter("salesno");
					
					if("Y".equals(flag))
					{
						sql = " UPDATE inv_t_directsales SET CHR_ACCOUNTFLAG='Y', CHR_ACCOUNTDESC='"+desc+"' WHERE CHR_SALESNO='"+salesno+"'";
						Statement ts = con.createStatement();
						ts.execute(sql);
						ts.close();
						con.close();    
						response.sendRedirect("Smart Inventory/AccountDirectSale.jsp");
					}
					else
					{
						sql = " UPDATE inv_t_directsales SET CHR_ACCOUNTFLAG='N', CHR_ACCOUNTDESC='' WHERE CHR_SALESNO='"+salesno+"'";
						Statement ts = con.createStatement();
						ts.execute(sql);
						ts.close();
						con.close();   
						response.sendRedirect("Smart Inventory/AccountDirectSale.jsp");
					}
					
				}
				else if("INVServiceBillDCUpdate".equals(action))
				{
					String desc = request.getParameter("desc");
					String flag = request.getParameter("flag");
					String salesno = request.getParameter("salesno");
					
					if("Y".equals(flag))
					{
						sql = " UPDATE inv_t_servicebilling SET CHR_ACCOUNTFLAG='Y', CHR_ACCOUNTDESC='"+desc+"' WHERE CHR_SALESNO='"+salesno+"'";
						Statement ts = con.createStatement();
						ts.execute(sql);
						ts.close();
						con.close();    
						response.sendRedirect("Smart Inventory/AccountServiceBill.jsp");
					}
					else
					{
						sql = " UPDATE inv_t_directsales SET CHR_ACCOUNTFLAG='N', CHR_ACCOUNTDESC='' WHERE CHR_SALESNO='"+salesno+"'";
						Statement ts = con.createStatement();
						ts.execute(sql);
						ts.close();
						con.close();    
						response.sendRedirect("Smart Inventory/AccountDirectSale.jsp");
					}
					
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


