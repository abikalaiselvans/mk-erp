package com.my.org.erp.SmartCommon;

import java.io.IOException; 

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

 
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.common.CommonFunctions;

 
public class CertificationTrackActionHandler extends AbstractActionHandler 
{
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String user  = (String) session.getAttribute("USRID");
			if (action.equals("GENCertificationTrackDelete")) 
			{
				String ids[] = request.getParameterValues("id");
				acs = con.prepareCall("{call  COM_PRO_CERTIFICATIONTRACK(?,?,?,?,? )}");
				for (int i = 0; i < ids.length; i++) 
				{
					acs.setString(1, "DELETE");
					acs.setString(2, ids[i]);
					acs.setString(3, "");
					acs.setString(4, null);
					acs.setString(5, user);
					acs.addBatch();
				}
				acs.executeBatch();
				acs.close();
				con.close();    
				response.sendRedirect("Smart Common/CertificationTrack.jsp");
			}
			else if ( action.equals("GENCertificationTrackAdd")   ) 
			{
				String name=request.getParameter("ename");
				String checkbox[]=request.getParameterValues("checkbox");
				String c = "";
				for(int u=0;u<checkbox.length ;u++)
					c = c+checkbox[u]+",";
				c = c.substring(0,c.length()-1);
				name=name.trim();
				if(! CommonFunctions.RecordExist(con,"SELECT COUNT(*) FROM  com_t_certification   WHERE CHR_EMPID='"+name+"'"))
				{
					acs = con.prepareCall("{call  COM_PRO_CERTIFICATIONTRACK(?,?,?,?,? )}");
					acs.setString(1, "INSERT");
					acs.setString(2, "1");
					acs.setString(3, name);
					acs.setString(4, c);
					acs.setString(5, user);
					acs.execute();
					acs.close();
					con.close();
					response.sendRedirect("Smart Common/CertificationTrack.jsp");
					
				}
				else
				{
					con.close();
					response.sendRedirect("Smart Common/CertificationTrackAction.jsp?action1=Add&msg=Kindly edit and update the certifications.. ");
					
				}
				//response.sendRedirect("Smart Attendance/CertificationTrackAction.jsp?action1=Add");
			} 
			else if (action.equals("GENCertificationEdit")) 
			{
				String id=request.getParameter("id");
				String name=request.getParameter("ename");
				String checkbox[]=request.getParameterValues("checkbox");
				String c = "";
				for(int u=0;u<checkbox.length ;u++)
					c = c+checkbox[u]+",";
				c = c.substring(0,c.length()-1);
				acs = con.prepareCall("{call  COM_PRO_CERTIFICATIONTRACK(?,?,?,?,? )}");
				acs.setString(1, "UPDATE");
				acs.setString(2, id);
				acs.setString(3, name);
				acs.setString(4, c);
				acs.setString(5, user);
				acs.execute();
				acs.close();
				con.close();    
				response.sendRedirect("Smart Common/CertificationTrack.jsp");
			}
			
		} catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}	
	}

}
