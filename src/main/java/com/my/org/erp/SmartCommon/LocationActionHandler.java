package com.my.org.erp.SmartCommon;

import java.io.IOException;
 

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

 
import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class LocationActionHandler extends AbstractActionHandler 
{
	String courseName;
	int courseId;
	String userid = "";
	 
	
	private void locationDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String []rowid= request.getParameterValues("id");
			asql ="DELETE FROM com_m_locations WHERE INT_LOCATIONID=?";
			apstm = con.prepareStatement(asql);
			for(int i=0;i<rowid.length;i++)
			{	
				apstm.setString(1,rowid[i]);
				apstm.addBatch();				
			}
			apstm.executeBatch();
			apstm.close();
		} 
		catch (Exception e) 
		{
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 
		}
	}

	
	
	private void locationAdd(HttpServletRequest request, 	HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			HttpSession session=request.getSession();			
			String userid=""+session.getAttribute("USRID");	
			String Name = request.getParameter("Name");
			String officeid = request.getParameter("officeid");
			String sdescription = request.getParameter("sdescription");
			String inactive = request.getParameter("inactive");
			if(inactive == null || "".equals(inactive))
				inactive="N";
			asql=" INSERT INTO com_m_locations ";
			asql = asql + " (CHR_LOCATION,CHR_DESC,CHR_ACTIVE,INT_OFFICEID,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS )";
			asql = asql + " VALUES (?,?,?,?,?,DATE(NOW()),'Y') ";
			apstm =con.prepareStatement(asql);
			System.out.println("asql...."+asql);
			apstm.setString(1, Name);
			apstm.setString(2, sdescription);
			apstm.setString(3, inactive);
			apstm.setString(4, officeid);
			apstm.setString(5, userid);
			apstm.execute();
			apstm.close();
		} 
		catch (Exception e) 
		{
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 
		}
	}

	private void locationEdit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String lid = request.getParameter("id");
			String name = request.getParameter("Name");
			String officeid = request.getParameter("officeid");
			String sdescription = request.getParameter("sdescription");
			String inactive = request.getParameter("inactive");
			if(inactive == null || "".equals(inactive))
				inactive="N";
			asql=" UPDATE com_m_locations SET ";
			asql = asql + " CHR_LOCATION=?,CHR_DESC=?,CHR_ACTIVE=?,INT_OFFICEID=? WHERE INT_LOCATIONID=?"; 
			System.out.println("asql...."+asql);
			apstm =con.prepareStatement(asql);
			apstm.setString(1,name);
			apstm.setString(2,sdescription);
			apstm.setString(3,inactive);
			apstm.setString(4,officeid);
			apstm.setString(5,lid);
			apstm.execute();
			apstm.close();
		} 
		catch (Exception e) 
		{
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
		}
	}

	
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{

		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			userid = "" + session.getAttribute("USRID");
			
			if (action.equals("GENlocationDelete")) 
			{
				locationDelete(request, response);
				con.close();   
				response.sendRedirect("Smart Common/LocationView.jsp");
			} 
			else if (action.equals("GENlocationAdd")) 
			{
				System.out.println("location add....");
				locationAdd(request, response);
				con.close();   
				response.sendRedirect("Smart Common/LocationView.jsp");
			} 
			else if (action.equals("GENlocationEdit")) 
			{
				locationEdit(request, response);
				con.close();   
				response.sendRedirect("Smart Common/LocationView.jsp");
			}
		} 
		catch (Exception e) 
		{
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 
		}
	}

}
