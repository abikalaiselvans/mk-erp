package com.my.org.erp.SmartInventory;
import java.io.IOException;
 

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
 

public class DivisionActionHandler extends AbstractActionHandler
{
 public void handle(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException
	{
		try
		{
			String action=request.getParameter("actionS");
			  
			if(action.equals("INVDivisionAdd"))
			{
				String checkbox[]=request.getParameterValues("checkbox");
				String c = "";
				if(checkbox.length>0)
				{
					for(int u=0;u<checkbox.length ;u++)
						c = c+checkbox[u]+",";
					c = c.substring(0,c.length()-1);
				}
				asql="INSERT INTO inv_m_division( CHR_DIVICODE,CHR_DIVISHORTCODE,CHR_EMAILID,";
				asql=asql+"CHR_OFFICEIDS,CHR_EMPID,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS) ";
				asql=asql+" VALUES(?,?,?,?,?,?,DATE(NOW()),'Y')";
				apstm=con.prepareStatement(asql);
				apstm.setString(1, request.getParameter("Division"));
				apstm.setString(2, request.getParameter("Divisionshortname"));
				apstm.setString(3, request.getParameter("email"));
				apstm.setString(4, c);
				apstm.setString(5, request.getParameter("divisionhead"));
				apstm.setString(6, auserid);
				apstm.execute();
				con.close();   
				response.sendRedirect("Smart Inventory/DivisionView.jsp");
			}
			else if(action.equals("INVDivisionDelete"))
			{
				String ids[] = request.getParameterValues("rowid");
				asql ="DELETE FROM inv_m_division   WHERE INT_DIVIID=?";
				apstm = con.prepareStatement(asql);
				for(int u=0;u<ids.length;u++)
				{
					apstm.setString(1,ids[u]);
					apstm.addBatch();	
					
				}
				apstm.executeBatch();
				apstm.close();
				con.close();    
				response.sendRedirect("Smart Inventory/DivisionView.jsp");
			}
			else if(action.equals("INVDivisionUpdate"))
			{
				String checkbox[]=request.getParameterValues("checkbox");
				String c = "";
				if(checkbox.length>0)
				{
					for(int u=0;u<checkbox.length ;u++)
						c = c+checkbox[u]+",";
					c = c.substring(0,c.length()-1);
				}
				
				asql = "UPDATE inv_m_division SET CHR_DIVICODE =?,CHR_DIVISHORTCODE=?,CHR_EMAILID=?,CHR_OFFICEIDS=?,CHR_EMPID=? ";
				asql = asql + " WHERE INT_DIVIID = ? ";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,request.getParameter("Division"));
				apstm.setString(2, request.getParameter("Divisionshortname"));
				apstm.setString(3, request.getParameter("email"));
				apstm.setString(4, c);
				apstm.setString(5, request.getParameter("divisionhead"));
				apstm.setString(6, request.getParameter("rowid"));
				System.out.println(""+apstm);
				apstm.execute();
				con.close();   
				response.sendRedirect("Smart Inventory/DivisionView.jsp");
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
