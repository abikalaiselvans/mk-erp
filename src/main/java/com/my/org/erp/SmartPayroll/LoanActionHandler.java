package com.my.org.erp.SmartPayroll;
 
import java.io.IOException;
 

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
 
public class LoanActionHandler extends AbstractActionHandler 
{
	 
	private void AdvanceDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String[] Id = request.getParameterValues("id");
			acs = con.prepareCall("{call  PAY_PRO_LOAN(?,?,?,?,?)}");
			for (int i = 0; i < Id.length; i++) 
			{
				acs.setString(1, "DELETE");
				acs.setString(2, Id[i]);
				acs.setString(3, "");
				acs.setString(4, "");
				acs.setString(5, "");
				acs.addBatch();
			}
			acs.executeBatch();
			acs.close();
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}	
	}

	private void AdvanceAdd(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String Name = request.getParameter("Name").trim();
			String descr = request.getParameter("descr").trim();
			if("".equals(descr))
				descr = "-";
			acs = con.prepareCall("{call  PAY_PRO_LOAN(?,?,?,?,?)}");
			acs.setString(1, "INSERT");
			acs.setString(2, "1");
			acs.setString(3, Name.trim());
			acs.setString(4, descr.trim());
			acs.setString(5, auserid);
			System.out.println(""+acs);
			acs.execute();
			acs.close();
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}	
	}
	
	

	private void AdvanceEdit(HttpServletRequest request, 	HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String id = request.getParameter("id");
			String Name = request.getParameter("Name").trim();
			String descr = request.getParameter("descr").trim();
			if("".equals(descr))
				descr = "-";
			acs = con.prepareCall("{call  PAY_PRO_LOAN(?,?,?,?,?)}");
			acs.setString(1, "UPDATE");
			acs.setString(2, id);
			acs.setString(3, Name.trim());
			acs.setString(4, descr.trim());
			acs.setString(5, auserid);
			acs.execute();
			acs.close();
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}	
	}

	
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			System.out.println(action);
			if (action.equals("PAYLoanDelete"))
			{
				AdvanceDelete(request, response);
				response.sendRedirect("Smart Payroll/LoanView.jsp");
			} 
			else if (action.equals("PAYLoanAdd")) 
			{
				AdvanceAdd(request, response);
				response.sendRedirect("Smart Payroll/LoanView.jsp"); 
			} 
			else if (action.equals("PAYLoanEdit")) 
			{
				AdvanceEdit(request, response);
				response.sendRedirect("Smart Payroll/LoanView.jsp");
				 
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