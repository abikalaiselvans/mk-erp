package com.my.org.erp.SmartAttendance;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.bean.Attendance.Office;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class OfficeActionHandler extends AbstractActionHandler 
{
	String courseName;
	int courseId;

	private void OfficeList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			ArrayList<Office> OfficeList = new ArrayList<Office>();
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery("SELECT * FROM  com_m_office  ORDER BY CHR_Officename");
			while (rs.next()) 
			{
				int OfficeId = rs.getInt(1);
				String OfficeName = rs.getString(2);
				String Officeshortname = rs.getString(3);
				String desp = rs.getString(4);
				Office office = new Office(OfficeId, OfficeName, desp,Officeshortname);
				OfficeList.add(office);
			}
			HttpSession session = request.getSession();
			session.setAttribute("OfficeList", OfficeList);
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}	
	}

	
	
	
	private void OfficeDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String[] OfficeId = request.getParameterValues("OptOfficeName");
			CallableStatement cs = con.prepareCall("{call  COM_PRO_OFFICE (?,?,?,?,?,?)}");
			for (int i = 0; i < OfficeId.length; i++) 
			{
				cs.setString(1, "DELETE");
				cs.setString(2, OfficeId[i]);
				cs.setString(3, "");
				cs.setString(4, "");
				cs.setString(5, "");
				cs.setString(6, "");
				cs.addBatch();
			}
			cs.executeBatch();
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}	
	}

	
	
	private void OfficeAdd(HttpServletRequest request, 	HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			HttpSession session = request.getSession();
			String userId = "" + session.getAttribute("USRID");
			String OfficeName = request.getParameter("TxtOfficeName");
			String shortname = request.getParameter("shortname");
			String OfficeDes = request.getParameter("TxtOfficeDes");
			CallableStatement cs = con.prepareCall("{call  COM_PRO_OFFICE (?,?,?,?,?,?)}");
			cs.setString(1, "INSERT");
			cs.setString(2, "1");
			cs.setString(3, OfficeName);
			cs.setString(4, shortname);
			cs.setString(5, OfficeDes);
			cs.setString(6, userId);
			cs.execute();
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}	
	}

	
	
	private void OfficeEdit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String OfficeId = request.getParameter("OfficeId");
			HttpSession session = request.getSession();
			String userId = "" + session.getAttribute("USRID");
			String OfficeName = request.getParameter("TxtOfficeName");
			String shortname = request.getParameter("shortname");
			String OfficeDes = request.getParameter("TxtOfficeDes");
			CallableStatement cs = con.prepareCall("{call  COM_PRO_OFFICE (?,?,?,?,?,?)}");
			cs.setString(1, "UPDATE");
			cs.setString(2, OfficeId);
			cs.setString(3, OfficeName);
			cs.setString(4, shortname);
			cs.setString(5, OfficeDes);
			cs.setString(6, userId);
			cs.execute();

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
			if (action.equals("ATTOfficeList")) 
			{
				OfficeList(request, response);
				con.close();    
				response.sendRedirect("Smart Attendance/OfficeView.jsp");
			} 
			else if (action.equals("ATTOfficeDelete")) 
			{
				OfficeDelete(request, response);
				OfficeList(request, response);
				con.close();    
				response.sendRedirect("Smart Attendance/OfficeView.jsp");
			} 
			else if (action.equals("ATTOfficeAdd")) 
			{
				OfficeAdd(request, response);
				OfficeList(request, response);
				con.close();    
				response.sendRedirect("Smart Attendance/OfficeView.jsp");
			} 
			else if (action.equals("ATTOfficeEdit")) 
			{
				OfficeEdit(request, response);
				OfficeList(request, response);
				con.close();    
				response.sendRedirect("Smart Attendance/OfficeView.jsp");
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
