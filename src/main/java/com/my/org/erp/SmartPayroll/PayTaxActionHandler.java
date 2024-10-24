package com.my.org.erp.SmartPayroll;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;


public class PayTaxActionHandler extends AbstractActionHandler {
	 

	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session=request.getSession();			
			String userid=""+session.getAttribute("USRID");
			
			Statement st = con.createStatement();
			if (action.equals("PAYPayTaxAdd")) 
			{
				String Taxname=request.getParameter("Taxname");
				String desc = request.getParameter("desc");
				asql = "INSERT INTO pay_m_tax (CHR_TAXNAME,CHR_DESC,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS) VALUES (";
				asql = asql+" '"+Taxname+"' , ";
				asql = asql+" '"+desc+"' , ";
				asql = asql+" '"+userid+"' , ";
				asql = asql+" now() , ";
				asql = asql+" 'Y'  ";
				asql = asql + " )";
				st.execute(asql);
				con.close();   
				response.sendRedirect("Smart Payroll/PayTax.jsp");
			}
			else if(action.equals("PAYPayTaxEdit")) 
			{
				String Taxname=request.getParameter("Taxname");
				String desc = request.getParameter("desc");
				String rowid = request.getParameter("Paytaxid");
				asql = "UPDATE  pay_m_tax  SET ";
				asql = asql+" CHR_TAXNAME ='"+Taxname+"' , ";
				asql = asql+" CHR_DESC='"+desc+"' , ";
				asql = asql+" CHR_USRNAME='"+userid+"' , ";
				asql = asql+" DT_UPDATEDATE= now() , ";
				asql = asql+" CHR_UPDATESTATUS= 'Y'  WHERE INT_ID="+rowid;
				st.execute(asql);
				con.close();    
				response.sendRedirect("Smart Payroll/PayTax.jsp");
			}
			
			else if(action.equals("PAYPayTaxDelete")) 
			{
				String rowid[] = request.getParameterValues("Paytaxid");
				for(int u=0;u<rowid.length;u++)
				{
					asql = "DELETE FROM pay_m_tax   ";
					asql = asql+"WHERE INT_ID="+rowid[u];
					st.execute(asql);
				}	
				con.close();    
				response.sendRedirect("Smart Payroll/PayTax.jsp");
			}
			else if(action.equals("PAYPayTaxDeductionAdd")) 
			{
				String rowid[] = request.getParameterValues("ename");
				String month = request.getParameter("month");
				String year = request.getParameter("year");
				String tax = request.getParameter("tax");
				String Type = request.getParameter("Type");
				CallableStatement cs = con.prepareCall("{call  PAY_PRO_TAXDEDUCTION(?,?,?,?,?,?,?,?)}");
				for (int i = 0; i < rowid.length; i++) {
					cs.setString(1, "INSERT");
					cs.setString(2, "");
					cs.setString(3, tax);
					cs.setString(4, rowid[i]);
					cs.setString(5, month);
					cs.setString(6, year);
					cs.setString(7, Type);
					cs.setString(8, userid);
					cs.addBatch();
				}
				
				cs.executeBatch();
				con.close();    
				response.sendRedirect("Smart Payroll/Ptaxdetection.jsp");
			}
			else if(action.equals("PAYPayTaxDeductionDelete")) 
			{
				String rowid[] = request.getParameterValues("id");
				CallableStatement cs = con.prepareCall("{call  PAY_PRO_TAXDEDUCTION(?,?,?,?,?,?,?,?)}");
				for (int i = 0; i < rowid.length; i++) {
					cs.setString(1, "DELETE");
					cs.setString(2, rowid[i]);
					cs.setString(3, "");
					cs.setString(4, "");
					cs.setString(5, "");
					cs.setString(6, "");
					cs.setString(7, "");
					cs.setString(8, "");
					cs.addBatch();
				}
				cs.executeBatch();

				con.close();    
				response.sendRedirect("Smart Payroll/Ptaxdetection.jsp");
			}
			
			
			
			st.close();
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
