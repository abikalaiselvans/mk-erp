package com.my.org.erp.SmartAttendance;

import java.io.IOException;
import java.sql.CallableStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
public class CityActionHandler extends AbstractActionHandler 
{
	String courseName;
	int courseId;
	
	
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			if (action.equals("ATTCityAdd")) 
			{
				 
				HttpSession session = request.getSession();
				String userId = "" + session.getAttribute("USRID");
				String country = request.getParameter("country");
				String state = request.getParameter("state");
				String district = request.getParameter("district");
				String cityname = request.getParameter("cityname");
				String pincode = request.getParameter("pincode");
				CallableStatement cs = con.prepareCall("{call  COM_PRO_CITY (?,?,?,?,?,?,?,?)}");
				cs.setString(1, "INSERT");
				cs.setString(2, "1");
				cs.setString(3, country);
				cs.setString(4, state);
				cs.setString(5, district);
				cs.setString(6, cityname);
				cs.setString(7, pincode);
				cs.setString(8, userId);
				cs.execute();
				cs.close();
				 
				response.sendRedirect("Smart Attendance/CityAction.jsp?msg=Record Added Successfully&country="+country+"&state="+state+"&district="+district+"&action1=Add");
			} 
			if (action.equals("ATTCityEdit")) 
			{
				 
				HttpSession session = request.getSession();
				String userId = "" + session.getAttribute("USRID");
				String rowid = request.getParameter("cityid");
				String country = request.getParameter("country");
				String state = request.getParameter("state");
				String district = request.getParameter("district");
				String cityname = request.getParameter("cityname");
				String pincode = request.getParameter("pincode");
				CallableStatement cs = con.prepareCall("{call  COM_PRO_CITY (?,?,?,?,?,?,?,?)}");
				cs.setString(1, "UPDATE");
				cs.setString(2, rowid);
				cs.setString(3, country);
				cs.setString(4, state);
				cs.setString(5, district);
				cs.setString(6, cityname);
				cs.setString(7, pincode);
				cs.setString(8, userId);
				cs.execute();
				cs.close();
				 
				response.sendRedirect("Smart Attendance/City.jsp");
			}
			if (action.equals("ATTCityDelete")) 
			{
				try 
				{
					String[] Id = request.getParameterValues("id");
					CallableStatement cs = con.prepareCall("{call  COM_PRO_CITY (?,?,?,?,?,?,?,?)}");
					for (int i = 0; i < Id.length; i++) 
					{
						cs.setString(1, "DELETE");
						cs.setString(2, Id[i]);
						cs.setString(3, "");
						cs.setString(4, "");
						cs.setString(5, "");
						cs.setString(6, "");
						cs.setString(7, "");
						cs.setString(8, "");
						cs.addBatch();
					}
					cs.executeBatch();
					cs.close();
					 
					response.sendRedirect("Smart Attendance/City.jsp");
				} 
				catch (Exception e) 
				{
					response.sendRedirect("error/index.jsp?error=" + e.getMessage());
					 System.out.println(e.getMessage());
				}
			}
			else if(action.equals("ATTCityAdds")) 
			{

				 
				HttpSession session = request.getSession();
				String userId = "" + session.getAttribute("USRID");
				String country = request.getParameter("country");
				String state = request.getParameter("state");
				String district = request.getParameter("district");
				String cityname = request.getParameter("cityname");
				String pincode = request.getParameter("pincode");
				CallableStatement cs = con.prepareCall("{call  COM_PRO_CITY (?,?,?,?,?,?,?,?)}");
				cs.setString(1, "INSERT");
				cs.setString(2, "1");
				cs.setString(3, country);
				cs.setString(4, state);
				cs.setString(5, district);
				cs.setString(6, cityname);
				cs.setString(7, pincode);
				cs.setString(8, userId);
				cs.execute();
				cs.close();
				 
				response.sendRedirect("Common/exit.jsp");
			
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
