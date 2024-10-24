package com.my.org.erp.SmartCommon;

import java.io.IOException;
import java.sql.SQLException;
 
 
 
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
 
import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class BankBranchActionHandler extends AbstractActionHandler 
{
	 

	
	private void BankBranchDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String[] Id = request.getParameterValues("id");
			acs = con.prepareCall("{call  COM_PRO_BANKBRANCHNAME(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			for (int i = 0; i < Id.length; i++) 
			{
				
				acs.setString(1, "DELETE");
				acs.setString(2, Id[i]);
				acs.setString(3, "");
				acs.setString(4, "");
				acs.setString(5, "");
				acs.setString(6, "");
				acs.setString(7, "");
				acs.setString(8, "");
				acs.setString(9, "");
				acs.setString(10, "");
				acs.setString(11, "");
				acs.setString(12, "");
				acs.setString(13, "");
				acs.addBatch();
			}
			acs.executeBatch();
			acs.close();
		} 
		catch (SQLException e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}
	}

	private void BankBranchAdd(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			acs = con.prepareCall("{call  COM_PRO_BANKBRANCHNAME(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			acs.setString(1, "INSERT");
			acs.setString(2, "");
			acs.setString(3,  request.getParameter("bank").trim() );
			acs.setString(4,  request.getParameter("Name").trim());
			acs.setString(5,  request.getParameter("IFSC").trim() );
			acs.setString(6,  request.getParameter("MCR").trim());
			acs.setString(7,  request.getParameter("Address").trim());
			acs.setString(8,  request.getParameter("Contact").trim());
			acs.setString(9,  request.getParameter("City").trim());
			acs.setString(10, request.getParameter("District").trim() );
			acs.setString(11, request.getParameter("State").trim() );
			acs.setString(12, request.getParameter("Country").trim());
			acs.setString(13, auserid);
			 System.out.println(  ""+acs);
			acs.execute();
			acs.close();
		} 
		catch (SQLException e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}
	}
	
	

	private void BankBranchEdit(HttpServletRequest request, 	HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String id = request.getParameter("id");
			acs = con.prepareCall("{call  COM_PRO_BANKBRANCHNAME(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			acs.setString(1, "UPDATE");
			acs.setString(2, id);
			acs.setString(3,  request.getParameter("bank").trim() );
			acs.setString(4,  request.getParameter("Name").trim());
			acs.setString(5,  request.getParameter("IFSC").trim() );
			acs.setString(6,  request.getParameter("MCR").trim());
			acs.setString(7,  request.getParameter("Address").trim());
			acs.setString(8,  request.getParameter("Contact").trim());
			acs.setString(9,  request.getParameter("City").trim());
			acs.setString(10, request.getParameter("District").trim() );
			acs.setString(11, request.getParameter("State").trim() );
			acs.setString(12, request.getParameter("Country").trim());
			acs.setString(13, auserid);
			acs.execute();
			acs.close(); 
			 
		} 
		catch (SQLException e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

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
			 
			if (action.equals("GENBankBranchDelete")) 
			{
				BankBranchDelete(request, response);
				con.close();   
				response.sendRedirect("Smart Common/BankBranchView.jsp");
			} 
			else if (action.equals("GENBankBranchAdd")) 
			{
				BankBranchAdd(request, response);
				con.close();    
				response.sendRedirect("Smart Common/BankBranchView.jsp"); 
			} 
			else if (action.equals("GENBankBranchEdit")) 
			{
				String bank = request.getParameter("bank").trim();
				BankBranchEdit(request, response);
				con.close();   
				response.sendRedirect("Smart Common/BankBranchView.jsp?bank="+bank);
				 
			}
		} 
		catch (SQLException e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

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