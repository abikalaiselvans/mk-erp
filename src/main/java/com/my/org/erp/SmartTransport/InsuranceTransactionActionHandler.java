package com.my.org.erp.SmartTransport;

 
import java.io.IOException;
import java.sql.CallableStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;

public class InsuranceTransactionActionHandler extends AbstractActionHandler
{
	
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
				
		try
		{
		
			String action=request.getParameter("actionS");
			HttpSession session=request.getSession();
			String user=""+session.getAttribute("USRID");			
			if(action.equals("TRSInsuranceTransactionAdd"))
			{
				String ename=request.getParameter("ename");
				String reminder=request.getParameter("reminder");
				String policyno=request.getParameter("policyno");
				String period=request.getParameter("period");
				String premiumamount=request.getParameter("premiumamount");
				String entrydate=request.getParameter("entrydate");
				if(!"".equals(entrydate))
					entrydate = DateUtil.FormateDateSQL(entrydate);
				else
					entrydate="";
				String duedate=request.getParameter("duedate");
				if(!"".equals(duedate))
					duedate = DateUtil.FormateDateSQL(duedate);
				else
					duedate="";
				String matureddate=request.getParameter("matureddate");
				if(!"".equals(matureddate))
					matureddate = DateUtil.FormateDateSQL(matureddate);
				else
					matureddate="";
				String sumassured=request.getParameter("sumassured");
				String regnumber=request.getParameter("regnumber");
				String make=request.getParameter("make");
				String model=request.getParameter("model");
				String Issuer=request.getParameter("Issuer");
				String validupto=request.getParameter("validupto");
				if(!"".equals(validupto))
					validupto = DateUtil.FormateDateSQL(validupto);
				else
					validupto="";
				String office=request.getParameter("offices");
				String desc=request.getParameter("desc");
				String Policystatus=""+request.getParameter("Policystatus");
				if("null".equals(Policystatus))
					Policystatus="N";
				String vehiclestatus=""+request.getParameter("vehiclestatus");
				if("null".equals(vehiclestatus))
					vehiclestatus="N";
				CallableStatement cs = con.prepareCall("{call VEH_PRO_INSURANCETRANSACTION(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				cs.setString(1, "INSERT");
				cs.setString(2, "1");
				cs.setString(3, ename);
				cs.setString(4, reminder);
				cs.setString(5, policyno);
				cs.setString(6, period);
				cs.setString(7, premiumamount);
				cs.setString(8, entrydate);
				cs.setString(9, duedate);
				cs.setString(10, matureddate);
				cs.setString(11, sumassured);
				cs.setString(12, regnumber);
				cs.setString(13, make);
				cs.setString(14, model);
				cs.setString(15, Issuer);
				cs.setString(16, validupto);
				cs.setString(17, office);
				cs.setString(18, desc);
				cs.setString(19, Policystatus);
				cs.setString(20, vehiclestatus);
				cs.setString(21, user);
				cs.execute();
				 
				response.sendRedirect("Smart Transport/InsuranceTransaction.jsp");

			}
			else if(action.equals("TRSInsuranceTransactionEdit"))
			{
				
				String id=request.getParameter("id");
				String ename=request.getParameter("ename");
				String reminder=request.getParameter("reminder");
				String policyno=request.getParameter("policyno");
				String period=request.getParameter("period");
				String premiumamount=request.getParameter("premiumamount");
				String entrydate=request.getParameter("entrydate");
				if(!"".equals(entrydate))
					entrydate = DateUtil.FormateDateSQL(entrydate);
				else
					entrydate="";
				String duedate=request.getParameter("duedate");
				if(!"".equals(duedate))
					duedate = DateUtil.FormateDateSQL(duedate);
				else
					duedate="";
				
				String matureddate=request.getParameter("matureddate");
				if(!"".equals(matureddate))
					matureddate = DateUtil.FormateDateSQL(matureddate);
				else
					matureddate="";
				
				String sumassured=request.getParameter("sumassured");
				String regnumber=request.getParameter("regnumber");
				String make=request.getParameter("make");
				String model=request.getParameter("model");
				String Issuer=request.getParameter("Issuer");
				String validupto=request.getParameter("validupto");
				if(!"".equals(validupto))
					validupto = DateUtil.FormateDateSQL(validupto);
				else
					validupto="";
				
				String office=request.getParameter("offices");
				String desc=request.getParameter("desc");
				String Policystatus=""+request.getParameter("Policystatus");
				if("null".equals(Policystatus))
					Policystatus="N";
				
				String vehiclestatus=""+request.getParameter("vehiclestatus");
				if("null".equals(vehiclestatus))
					vehiclestatus="N";
				
				CallableStatement cs = con.prepareCall("{call VEH_PRO_INSURANCETRANSACTION(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				cs.setString(1, "UPDATE");
				cs.setString(2, id);
				cs.setString(3, ename);
				cs.setString(4, reminder);
				cs.setString(5, policyno);
				cs.setString(6, period);
				cs.setString(7, premiumamount);
				cs.setString(8, entrydate);
				cs.setString(9, duedate);
				cs.setString(10, matureddate);
				cs.setString(11, sumassured);
				cs.setString(12, regnumber);
				cs.setString(13, make);
				cs.setString(14, model);
				cs.setString(15, Issuer);
				cs.setString(16, validupto);
				cs.setString(17, office);
				cs.setString(18, desc);
				cs.setString(19, Policystatus);
				cs.setString(20, vehiclestatus);
				cs.setString(21, user);
				cs.execute();
				 
				response.sendRedirect("Smart Transport/InsuranceTransaction.jsp");
			}
			else if(action.equals("TRSInsuranceTransactionDelete"))
			{
				String ids[] = request.getParameterValues("id");
				CallableStatement cs = con.prepareCall("{call VEH_PRO_INSURANCETRANSACTION(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				for (int i = 0; i < ids.length; i++) {
					cs.setString(1, "DELETE");
					cs.setString(2, ids[i]);
					cs.setString(3, "");
					cs.setString(4, "");
					cs.setString(5, "");
					cs.setString(6, "");
					cs.setString(7, "");
					cs.setString(8, "");
					cs.setString(9, "");
					cs.setString(10, "");
					cs.setString(11, "");
					cs.setString(12, "");
					cs.setString(13, "");
					cs.setString(14, "");
					cs.setString(15, "");
					cs.setString(16, "");
					cs.setString(17, "");
					cs.setString(18, "");
					cs.setString(19, "");
					cs.setString(20, "");
					cs.setString(21, "");
					cs.addBatch();
				}
				cs.executeBatch();
				 
				response.sendRedirect("Smart Transport/InsuranceTransaction.jsp");
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