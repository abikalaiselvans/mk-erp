package com.my.org.erp.SmartPayroll;

import java.io.IOException;
 
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
 
public class MinimumWagesActionHandler extends AbstractActionHandler 
{
	String userid ="";
	@SuppressWarnings("unused")
	private void TrainingList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			ArrayList<Training> trainingList = new ArrayList<Training>();
			HttpSession session = request.getSession();
			Statement st = con.createStatement();
			String fdate = "" + session.getAttribute("fromdate");
			String tdate = "" + session.getAttribute("todate");
			ResultSet rs = st.executeQuery("SELECT * FROM PAY_M_EMP_TRAINING WHERE DT_PDATE>='"+ fdate + "' AND DT_PDATE<='" + tdate + "'");

					while (rs.next()) {
				//System.out.println("InSide Fun");
				String progId = rs.getString(1);
				String progName = rs.getString(2);
				String pdate = rs.getString(3);
				String ptime = rs.getString(4);
				String venu = rs.getString(5);
				String trainer = rs.getString(6);
				String subject = rs.getString(7);
				Training train = new Training(progId, progName, pdate, ptime,
						venu, trainer, subject);
				trainingList.add(train);
			}

			session.setAttribute("trainingList", trainingList);
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}	
	}

	private void MinimumWagesAdd(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{ 
		
			acs = con.prepareCall("{call PAY_PRO_MINIMUMWAGES(?,?,?,?,?,? )}");
			acs.setString(1,"INSERT");
			acs.setString(2,"1");
			acs.setString(3,request.getParameter("state"));
			acs.setString(4,request.getParameter("mini"));
			acs.setString(5,request.getParameter("maxi"));
			acs.setString(6,userid);
			if(!com.my.org.erp.common.CommonFunctions.RecordExist(con, "SELECT COUNT(*) FROM  pay_m_minimumwages WHERE INT_STATEID="+request.getParameter("state")))
				acs.execute();//2000-2004
			acs.close(); //21 
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}	
	}

	
	
	private void MinimumWagesUpdate(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{ 
		
			acs = con.prepareCall("{call PAY_PRO_MINIMUMWAGES(?,?,?,?,?,? )}");
			acs.setString(1,"UPDATE");
			acs.setString(2,request.getParameter("rowid"));
			acs.setString(3,request.getParameter("state"));
			acs.setString(4,request.getParameter("mini"));
			acs.setString(5,request.getParameter("maxi"));
			acs.setString(6,userid);
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
	
	
	
	private void MinimumWagesDelete(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{ 
			
			String ids[] = request.getParameterValues("rowid");
			acs = con.prepareCall("{call PAY_PRO_MINIMUMWAGES(?,?,?,?,?,? )}");
			for (int i = 0; i < ids.length; i++) 
			{
				acs.setString(1, "DELETE");
				acs.setString(2, ids[i]);
				acs.setString(3, "");
				acs.setString(4, null);
				acs.setString(5, null);
				acs.setString(6, null);
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

	
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			userid = (String) session.getAttribute("USRID");
			if (action.equals("PAYMinimumWagesAdd")) 
			{
				MinimumWagesAdd(request, response);
				con.close();    
				response.sendRedirect("Smart Payroll/MinimumWagesView.jsp");
			}
			else if (action.equals("PAYMinimumWagesUpdate")) 
			{
				MinimumWagesUpdate(request, response);
				con.close();    
				response.sendRedirect("Smart Payroll/MinimumWagesView.jsp");
			}
			else if (action.equals("PAYMinimumWagesDelete")) 
			{
				MinimumWagesDelete(request, response);
				con.close();    
				response.sendRedirect("Smart Payroll/MinimumWagesView.jsp");
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
