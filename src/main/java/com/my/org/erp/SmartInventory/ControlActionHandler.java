package com.my.org.erp.SmartInventory;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.common.CommonFunctions;
public class ControlActionHandler extends AbstractActionHandler
{
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try
		{
			HttpSession session=request.getSession();			
			String action=request.getParameter("actionS");
			
			if(action.equals("INVControlAssign"))
			{
				String branchid = request.getParameter("branchid");
				String office = request.getParameter("office");
				String sql = " SELECT b.INT_COMPANYID,a.CHR_COMPANYNAME,b.CHR_BRANCHNAME,b.INT_BRANCHID,a.CHR_SHORTNAME, b.INT_STATEID FROM com_m_branch b, com_m_company a ";
				sql = sql +"	WHERE a.INT_COMPANYID = b.INT_COMPANYID 	AND b.INT_BRANCHID="+Integer.parseInt(branchid);
				String data[][] =  CommonFunctions.RecordSetArray(con, sql);
				session.setAttribute("INVCOMPANY", data[0][0]);	
				session.setAttribute("INVBRANCH",data[0][3]);
				session.setAttribute("INVOFFICEID", office);
				session.setAttribute("BRANCHID", data[0][3]);
				session.setAttribute("COMPANYSHORTNAME", data[0][4]);
				session.setAttribute("OFFICEID", office);
				session.setAttribute("INVBRANCHSTATEID", data[0][5]);
				session.setAttribute("INVSTATE", CommonFunctions.QueryExecute("SELECT INT_STATEID FROM com_m_office WHERE INT_OFFICEID ="+office)[0][0]);
				con.close();     
				response.sendRedirect("Smart Inventory/InventoryMain.jsp");
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
