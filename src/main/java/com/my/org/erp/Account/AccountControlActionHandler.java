package com.my.org.erp.Account;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
public class AccountControlActionHandler extends AbstractActionHandler
{
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try
		{
			HttpSession session=request.getSession();			
			String action=request.getParameter("actionS");
			 
			if(action.equals("ACCControlAssign"))
			{
				String branchid = request.getParameter("branchid");
				String From = request.getParameter("frmdate");
				String To = request.getParameter("todate");
				String sqldatefrom = com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(From);
				String sysdatefrom = From;
				String sqldateto = com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(To);
				String sysdateto = To;
				
				String sql = " SELECT b.INT_COMPANYID,a.CHR_COMPANYNAME,b.CHR_BRANCHNAME,b.INT_BRANCHID,a.CHR_SHORTNAME FROM com_m_branch b, com_m_company a ";
				sql = sql +"	WHERE a.INT_COMPANYID = b.INT_COMPANYID 	AND b.INT_BRANCHID="+Integer.parseInt(branchid);
				 
				String data[][] = com.my.org.erp.common.CommonFunctions.RecordSetArray(con, sql);
				session.setAttribute("ACCCOMPANY", data[0][0]);	
				session.setAttribute("ACCBRANCH",data[0][3]);
				session.setAttribute("ACCYEAR",From.split("-")[2]);
				session.setAttribute("ACCYEAR1",To.split("-")[2]);
				session.setAttribute("ACCSYSDATEFROM",sysdatefrom);
				session.setAttribute("ACCSYSDATETO",sysdateto);
				session.setAttribute("ACCSQLDATEFROM",sqldatefrom);
				session.setAttribute("ACCSQLDATETO",sqldateto);
				
				
				if(!From.equals(""))
					session.setAttribute("ACCFROMDATE",DateUtil.FormateDateSQL(From));
				if(!To.equals(""))
				session.setAttribute("ACCTODATE",DateUtil.FormateDateSQL(To));
				
				response.sendRedirect("Smart Accounts/AccountsMain.jsp");
				
			}
		} 
		catch (Exception e) 
		{
				 System.out.println(e.getMessage());			
		}
	}	
}
