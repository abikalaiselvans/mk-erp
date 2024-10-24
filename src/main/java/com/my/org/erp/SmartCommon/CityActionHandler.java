package com.my.org.erp.SmartCommon;

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
			HttpSession session = request.getSession();
			String userId = "" + session.getAttribute("USRID");
			
			if (action.equals("GENCityAdd")) 
			{
				 
				String country = request.getParameter("country");
				String state = request.getParameter("state");
				String district = request.getParameter("district");
				String cityname = request.getParameter("cityname");
				String pincode = request.getParameter("pincode");
				acs = con.prepareCall("{call  COM_PRO_CITY (?,?,?,?,?,?,?,?)}");
				acs.setString(1, "INSERT");
				acs.setString(2, "1");
				acs.setString(3, country);
				acs.setString(4, state);
				acs.setString(5, district);
				acs.setString(6, cityname);
				acs.setString(7, pincode);
				acs.setString(8, userId);
				acs.execute();
				acs.close();
				con.close();    
				response.sendRedirect("Smart Common/CityView.jsp?country="+country+"&state="+state+"&district="+district);
				//response.sendRedirect("Smart Common/CityView.jsp");
				
			} 
			else if (action.equals("GENCityEdit")) 
			{
				 
				String rowid = request.getParameter("cityid");
				String country = request.getParameter("country");
				String state = request.getParameter("state");
				String district = request.getParameter("district");
				String cityname = request.getParameter("cityname");
				String pincode = request.getParameter("pincode");
				acs = con.prepareCall("{call  COM_PRO_CITY (?,?,?,?,?,?,?,?)}");
				acs.setString(1, "UPDATE");
				acs.setString(2, rowid);
				acs.setString(3, country);
				acs.setString(4, state);
				acs.setString(5, district);
				acs.setString(6, cityname);
				acs.setString(7, pincode);
				acs.setString(8, userId);
				acs.execute();
				acs.close();
				con.close();
				response.sendRedirect("Smart Common/CityView.jsp?country="+country+"&state="+state+"&district="+district);
			}
			else if (action.equals("GENCityDelete")) 
			{
				try 
				{
					String[] Id = request.getParameterValues("id");
					acs = con.prepareCall("{call  COM_PRO_CITY (?,?,?,?,?,?,?,?)}");
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
						acs.addBatch();
					}
					acs.executeBatch();
					acs.close();
					con.close();
					String country = request.getParameter("country");
					String state = request.getParameter("state");
					String district = request.getParameter("district");
					response.sendRedirect("Smart Common/CityView.jsp?country="+country+"&state="+state+"&district="+district);
					//response.sendRedirect("Smart Common/CityView.jsp");
				} 
				catch (Exception e) 
				{
					System.out.println(e.getMessage());
					request.setAttribute("error", e.getMessage() );
			        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
			    	dispatchers.forward(request, response); 

				}	
			}
			else if(action.equals("GENCityAdds")) 
			{

				 
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
				con.close();    
				response.sendRedirect("Smart Common/exit.jsp");
			
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
