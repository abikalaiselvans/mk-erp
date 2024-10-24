package com.my.org.erp.Account;

import java.io.IOException;

import java.sql.Statement;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class SettingActionHandler extends AbstractActionHandler 
{
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String user  = (String) session.getAttribute("USRID");
			String sql="";
			Statement st = con.createStatement();
			if ("ACCSettingUpdate".equals(action))
			{
				String Openingbalance = request.getParameter("Openingbalance");
				String OpenningOutstanding = request.getParameter("OpenningOutstanding");
				String Financialyear = request.getParameter("Financialyear");
				sql = "SELECT COUNT(*) FROM acc_m_openingbalance WHERE INT_COMPANYID="+session.getAttribute("ACCCOMPANY")+"  AND INT_BRANCHID="+session.getAttribute("ACCBRANCH")+" AND INT_FINANCIALYEARID="+Financialyear;
				if(!com.my.org.erp.common.CommonFunctions.RecordExist(con, sql))
				{
					sql = " INSERT INTO acc_m_openingbalance  (INT_COMPANYID,INT_BRANCHID,INT_FINANCIALYEARID,DOU_OPENINGBALANCE,DOU_OPENINGOUTSTANDING,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS ) VALUES (";
					sql = sql+session.getAttribute("ACCCOMPANY") + " , ";
					sql = sql+session.getAttribute("ACCBRANCH") + " , ";
					sql = sql+ Financialyear + " , ";
					sql = sql+ Openingbalance + " , ";
					sql = sql+ OpenningOutstanding + " ,  '"+user+"' ,now(), 'Y' )";
					
				}
				else
				{
					sql = " UPDATE acc_m_openingbalance SET DOU_OPENINGBALANCE="+Openingbalance+", DOU_OPENINGOUTSTANDING="+OpenningOutstanding+" WHERE INT_COMPANYID="+ session.getAttribute("ACCCOMPANY"); 
					sql = sql + " AND INT_BRANCHID="+session.getAttribute("ACCBRANCH");
					sql = sql + " AND INT_FINANCIALYEARID="+Financialyear;
				}
				System.out.println(sql);
				st.execute(sql);
				st.close();
				 
				response.sendRedirect("Smart Accounts/AccountsMain.jsp");
			}
			 
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			 System.out.println(e.getMessage());
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
		}
	}

}
