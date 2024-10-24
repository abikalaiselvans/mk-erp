package com.my.org.erp.SmartSMS;

import java.io.IOException;
 

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

 
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
 
 
public class MobileContactsActionHandler extends AbstractActionHandler {
	
	 
	 

	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{

		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String user  = (String) session.getAttribute("USRID");
			
			if (action.equals("SMSMobileContactsDelete")) 
			{
				String ids[] = request.getParameterValues("id");
				acs = con.prepareCall("{call  SMS_PRO_MOBILECONTACT(?,?,?,?,?,?,?,?,?)}");
				for (int i = 0; i < ids.length; i++) {
					acs.setString(1, "DELETE");
					acs.setString(2, ids[i]);
					acs.setString(3, "");
					acs.setString(4, "");
					acs.setString(5, "");
					acs.setString(6, "");
					acs.setString(7, "");
					acs.setString(8, "");
					acs.setString(9, user);
					acs.addBatch();
				}
				acs.executeBatch();
				acs.close();
				 
				response.sendRedirect("Smart SMS/MobileContacts.jsp");
			}
			else if (action.equals("SMSMobileContactsAdd")) 
			{
				try {
					String name=request.getParameter("name");
					String group=request.getParameter("group");
					String mobile=request.getParameter("mobile");
					String email=request.getParameter("email");
					String age=request.getParameter("age");
					String city=request.getParameter("city");
					acs = con.prepareCall("{call  SMS_PRO_MOBILECONTACT(?,?,?,?,?,?,?,?,?)}");
					acs.setString(1, "INSERT");
					acs.setString(2, "");
					acs.setString(3, group );
					acs.setString(4, name);
					acs.setString(5, mobile);
					acs.setString(6, email);
					acs.setString(7, age);
					acs.setString(8, city);
					acs.setString(9, user);
					acs.execute();
					response.sendRedirect("Smart SMS/MobileContacts.jsp");
				} 
				catch (Exception e) 
				{
					System.out.println(e.getMessage());
					request.setAttribute("error", e.getMessage() );
			        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
			    	dispatchers.forward(request, response); 

				}
			} 
			else if (action.equals("SMSMobileContactsEdit")) 
			{
				 
				
				try {
					String id=request.getParameter("id");
					String name=request.getParameter("name");
					String group=request.getParameter("group");
					String mobile=request.getParameter("mobile");
					String age=request.getParameter("age");
					String city=request.getParameter("city");
					String email=request.getParameter("email");
					acs = con.prepareCall("{call  SMS_PRO_MOBILECONTACT(?,?,?,?,?,?,?,?,?)}");
					acs.setString(1, "UPDATE");
					acs.setString(2, id);
					acs.setString(3, group );
					acs.setString(4, name);
					acs.setString(5, mobile);
					acs.setString(6, email);
					acs.setString(7, age);
					acs.setString(8, city);
					acs.setString(9, user);
					acs.execute();
					
					response.sendRedirect("Smart SMS/MobileContacts.jsp");
				} 
				catch (Exception e) 
				{
					System.out.println(e.getMessage());
					request.setAttribute("error", e.getMessage() );
			        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
			    	dispatchers.forward(request, response); 

				}
				
			}
			else if ("SMSMobileContactsGroup".equals(action))
			{
				try 
				{
					
					String name=request.getParameter("name");
					asql = " INSERT INTO sms_m_mobile_group   ( CHR_GROUPNAME,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS ) VALUES ";
					asql = asql +" ( ";
					asql = asql +" '"+name+"' ,'"+user+"' ,DATE(NOW()),'Y' ";
					asql = asql +" ) ";
					com.my.org.erp.common.CommonFunctions.Execute(asql);
					response.sendRedirect("Smart SMS/exit.jsp");
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
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}
	}

}
