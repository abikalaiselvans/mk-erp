package com.my.org.erp.SmartPayroll;
 
import java.io.IOException;
 

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
 
public class PFwagesBandActionHandler extends AbstractActionHandler 
{
	 
	private void  Delete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String[] Id = request.getParameterValues("Rowid");
			asql = " DELETE FROM  m_pf_setting  WHERE INT_ROWID=?";
			apstm = con.prepareStatement(asql);
			for (int i = 0; i < Id.length; i++) 
			{
				apstm.setString(1,Id[i]);
				System.out.println(""+apstm);
				apstm.addBatch();
			}
			apstm.executeBatch();
			apstm.close();
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}	
	}

	private void  Add(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String pfmini = request.getParameter("pfmini").trim();
			String pfmaxi = request.getParameter("pfmaxi").trim();
			String esilimit = request.getParameter("esilimit").trim();
			String status = request.getParameter("status").trim();
			asql =" INSERT INTO m_pf_setting ( INT_PFMINIMUM_LIMIT,INT_PFMAXIMUM_LIMIT,INT_ESILIMIT, CHR_STATUS )";
			asql = asql + " VALUES(?,?,?,?)";
			apstm = con.prepareStatement(asql);
			apstm.setString(1,pfmini);
			apstm.setString(2,pfmaxi);
			apstm.setString(3,esilimit);
			apstm.setString(4,status);
			System.out.println(""+apstm);
			apstm.execute();
			apstm.close();
			
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}	
	}
	
	

	private void  Edit(HttpServletRequest request, 	HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String Rowid = request.getParameter("Rowid");
			String pfmini = request.getParameter("pfmini").trim();
			String pfmaxi = request.getParameter("pfmaxi").trim();
			String esilimit = request.getParameter("esilimit").trim();
			String status = request.getParameter("status").trim();
			asql = " UPDATE m_pf_setting SET INT_PFMINIMUM_LIMIT=?,INT_PFMAXIMUM_LIMIT=?,INT_ESILIMIT=?, CHR_STATUS=? WHERE INT_ROWID=?";
			apstm = con.prepareStatement(asql);
			apstm.setString(1,pfmini);
			apstm.setString(2,pfmaxi);
			apstm.setString(3,esilimit);
			apstm.setString(4,status);
			apstm.setString(5,Rowid);
			System.out.println(""+apstm);
			apstm.execute();
			apstm.close();
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
			if (action.equals("PAYPFwagesBandDelete"))
			{
				Delete(request, response);
				response.sendRedirect("Smart Payroll/PFwagesBand.jsp");
			} 
			else if (action.equals("PAYPFwagesBandAdd")) 
			{
				Add(request, response);
				response.sendRedirect("Smart Payroll/PFwagesBand.jsp"); 
			} 
			else if (action.equals("PAYPFwagesBandEdit")) 
			{
				Edit(request, response);
				response.sendRedirect("Smart Payroll/PFwagesBand.jsp");
				 
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