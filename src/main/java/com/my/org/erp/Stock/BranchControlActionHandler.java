package com.my.org.erp.Stock;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
public class BranchControlActionHandler extends AbstractActionHandler
{
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try
		{
			HttpSession session=request.getSession();			
			String action=request.getParameter("actionS");
			 
			if(action.equals("STKControlAssign"))
			{
				String branchid = request.getParameter("branchid");
				String sql = " SELECT b.INT_COMPANYID,a.CHR_COMPANYNAME,b.CHR_BRANCHNAME,b.INT_BRANCHID,a.CHR_SHORTNAME FROM com_m_branch b, com_m_company a ";
				sql = sql +"	WHERE a.INT_COMPANYID = b.INT_COMPANYID 	AND b.INT_BRANCHID="+Integer.parseInt(branchid);
				String data[][] = com.my.org.erp.common.CommonFunctions.RecordSetArray(con, sql);
				session.setAttribute("STKCOMPANY", data[0][0]);	
				session.setAttribute("STKBRANCH",data[0][3]);
				response.sendRedirect("SmartStock/StockMain.jsp");
				
			}
		} 
		catch (Exception e) 
		{
				 System.out.println(e.getMessage());			
		}
	}	
}
