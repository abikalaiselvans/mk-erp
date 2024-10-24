package com.my.org.erp.SmartPayroll;

import java.io.IOException;

import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;


public class PayTaxValueActionHandler extends AbstractActionHandler {
	 

	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session=request.getSession();			
			String userid=""+session.getAttribute("USRID");
			String sql="";
			Statement st = con.createStatement();
			if (action.equals("PAYPayTaxAdd")) 
			{
				
				//Taxid,GT,LT,Percentage,Amount,desc
				String Taxid = request.getParameter("Taxid");
				String GT = request.getParameter("GT");
				String LT = request.getParameter("LT");
				String Percentage = request.getParameter("Percentage");
				String Amount = request.getParameter("Amount");
				String desc = request.getParameter("desc");
				sql = "INSERT INTO pay_m_taxvalue (INT_TAXID,INT_GTEQL,INT_LSEQL,DOU_PERCENTAGE,DOU_AMOUNT,CHR_DESC,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS) VALUES (";
				sql = sql+" "+Taxid+" , ";
				sql = sql+" "+GT+" , ";
				sql = sql+" "+LT+" , ";
				sql = sql+" "+Percentage+" , ";
				sql = sql+" "+Amount+" , ";
				sql = sql+" '"+desc+"' , ";
				sql = sql+" '"+userid+"' , ";
				sql = sql+" now() , ";
				sql = sql+" 'Y'  ";
				sql = sql + " )";
				st.execute(sql);
				con.close();    
				response.sendRedirect("Smart Payroll/PayTaxValue.jsp");
			}
			else if(action.equals("PAYPayTaxEdit")) 
			{
				
				String Taxid = request.getParameter("Taxid");
				String GT = request.getParameter("GT");
				String LT = request.getParameter("LT");
				String Percentage = request.getParameter("Percentage");
				String Amount = request.getParameter("Amount");
				String desc = request.getParameter("desc");
				String rowid = request.getParameter("Paytaxvalueid");
				sql = "UPDATE  pay_m_taxvalue  SET ";
				sql = sql+" INT_TAXID ="+Taxid+" , ";
				sql = sql+" INT_GTEQL ="+GT+" , ";
				sql = sql+" INT_LSEQL ="+LT+" , ";
				sql = sql+" DOU_PERCENTAGE ="+Percentage+" , ";
				sql = sql+" DOU_AMOUNT ="+Amount+" , ";
				sql = sql+" CHR_DESC='"+desc+"' , ";
				sql = sql+" CHR_USRNAME='"+userid+"' , ";
				sql = sql+" DT_UPDATEDATE= now() , ";
				sql = sql+" CHR_UPDATESTATUS= 'Y'  WHERE INT_ID="+rowid;
				st.execute(sql);
				con.close();    
				response.sendRedirect("Smart Payroll/PayTaxValue.jsp");
			}
			else if(action.equals("PAYPayTaxValueDelete")) 
			{
				String rowid[] = request.getParameterValues("Paytaxvalueid");
				for(int u=0;u<rowid.length;u++)
				{
					sql = "DELETE FROM pay_m_taxvalue   ";
					sql = sql+"WHERE INT_ID="+rowid[u];
					st.execute(sql);
				}	
				con.close();    
				response.sendRedirect("Smart Payroll/PayTaxValue.jsp");
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
