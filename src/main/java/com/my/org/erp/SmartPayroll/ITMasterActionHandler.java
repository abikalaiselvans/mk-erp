package com.my.org.erp.SmartPayroll;

import java.io.IOException; 

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class ITMasterActionHandler extends AbstractActionHandler 
{
	private String FinacialYear, Gender, From, To, Cal,Fixed,Precent,Sub,Userid;
	private HttpSession session=null;
	
	private void ITMasterAdd(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			session=request.getSession();
			Userid=""+session.getAttribute("USRID");
			FinacialYear = request.getParameter("financial");
			Gender = request.getParameter("gender");
			From = request.getParameter("from");
			To = request.getParameter("to");
			Cal = request.getParameter("calculate");
			Fixed = request.getParameter("fixed");
			Precent = request.getParameter("precent");
			Sub = request.getParameter("sub");
			acs = con.prepareCall("{call PAY_PRO_INCOMETAX(?,?,?,?,?,?,?,?,?,?,?)}");
			acs.setString(1, "INSERT");
			acs.setInt(2, 1);
			acs.setString(3, FinacialYear);
			acs.setString(4, Gender);
			acs.setString(5, From);
			acs.setString(6, To);
			acs.setString(7, Cal);
			acs.setString(8, Fixed);
			acs.setString(9, Precent);
			acs.setString(10, Sub);
			acs.setString(11, Userid);
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

	private void ITMasterEdit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			session=request.getSession();
			Userid=""+session.getAttribute("USRID");
			String id = request.getParameter("id");
			FinacialYear = request.getParameter("financial");
			Gender = request.getParameter("gender");
			From = request.getParameter("from");
			To = request.getParameter("to");
			Cal = request.getParameter("calculate");
			Fixed = request.getParameter("fixed");
			Precent = request.getParameter("precent");
			Sub = request.getParameter("sub");
			acs = con.prepareCall("{call PAY_PRO_INCOMETAX(?,?,?,?,?,?,?,?,?,?,?)}");
			acs.setString(1, "UPDATE");
			acs.setInt(2, Integer.parseInt(id));
			acs.setString(3, FinacialYear);
			acs.setString(4, Gender);
			acs.setString(5, From);
			acs.setString(6, To);
			acs.setString(7, Cal);
			acs.setString(8, Fixed);
			acs.setString(9, Precent);
			acs.setString(10, Sub);
			acs.setString(11, Userid);
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
	
	private void ITMasterDelete(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			String[] id=request.getParameterValues("id");
			acs = con.prepareCall("{call PAY_PRO_INCOMETAX(?,?,?,?,?,?,?,?,?,?,?)}");
			for(int i=0;i<id.length;i++)
			{
				acs.setString(1, "DELETE");
				acs.setString(2, id[i]);
				acs.setString(3, "0");
				acs.setString(4, "0");
				acs.setString(5, "0");
				acs.setString(6, "0");
				acs.setString(7, "0");
				acs.setString(8, "0");
				acs.setString(9, "0");
				acs.setString(10, "0");
				acs.setString(11, "0");
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
	
	public void handle(HttpServletRequest request, HttpServletResponse response)  throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			if (action.equals("PAYITMasterAdd")) 
			{
				ITMasterAdd(request, response);
				con.close();   
				response.sendRedirect("Smart Payroll/ITMasterAdd.jsp?message=Master Added Sucessfully");
			}
			else if (action.equals("PAYITMasterEdit")) 
			{
				ITMasterEdit(request, response);
				con.close();   
				response.sendRedirect("Smart Payroll/ITMasterView.jsp?message=Master Edited Sucessfully");
			}
			else if (action.equals("PAYITMasterDelete")) 
			{
				ITMasterDelete(request, response);
				con.close();   
				response.sendRedirect("Smart Payroll/ITMasterView.jsp?message=Master Deleted Sucessfully");
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
