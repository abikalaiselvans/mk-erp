package com.my.org.erp.SmartInventory;
import java.io.IOException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class ServiceCenterActionHandler extends AbstractActionHandler
{
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	 {
		try
		{
				String action=request.getParameter("actionS");
				HttpSession session=request.getSession();			
				String userId=""+session.getAttribute("USRID");
				Statement st = con.createStatement();
				String sql="";
							
				if("INVServiceCenterAdd".equals(action))
				{
					String ServiceCenter=request.getParameter("ServiceCenter");
					String peremailid=request.getParameter("peremailid");
					String mobile=request.getParameter("mobile");
					String shortName=request.getParameter("shortName");
					sql = "INSERT INTO inv_m_servicecenter ( CHR_CENTERNAME,CHR_SHORTNAME,CHR_MOBILE,CHR_MAIL,CHR_USRNAME, DT_UPDATEDATE, CHR_UPDATESTATUS )  VALUES (";
					sql = sql +" '"+ServiceCenter+"' ,";
					sql = sql +" '"+shortName+"' ,";
					sql = sql +" '"+mobile+"' ,";
					sql = sql +" '"+peremailid+"' ,";
					sql = sql +" '"+userId +"' , ";
					sql = sql +" now() , 'Y' )";
					st.execute(sql);
					con.close();    
					response.sendRedirect("Smart Inventory/ServiceCenter.jsp");
				}	
				//SELECT INT_GROUPID ,CHR_GROUPNAME FROM  inv_m_servicecustomergroup 

				else if("INVServiceCenterEdit".equals(action))
				{
					String ServiceCenter=request.getParameter("ServiceCenter");
					String shortName=request.getParameter("shortName");
					String peremailid=request.getParameter("peremailid");
					String mobile=request.getParameter("mobile");
					String id =request.getParameter("id");
					sql = "UPDATE inv_m_servicecenter SET " ;
					sql = sql +" CHR_CENTERNAME = '"+ServiceCenter +"' , ";
					sql = sql +" CHR_SHORTNAME = '"+shortName +"' , ";
					sql = sql +" CHR_MOBILE = '"+mobile +"' , ";
					sql = sql +" CHR_MAIL = '"+peremailid +"' , ";
					
					sql = sql +" CHR_USRNAME ='"+userId +"'  ";
					sql = sql +" Where  INT_SERVICECENTERID = "+id;
					st.execute(sql);
					con.close();    
					response.sendRedirect("Smart Inventory/ServiceCenter.jsp");
				}
				else if("INVServiceCenterDelete".equals(action))
				{
					String custids[] = request.getParameterValues("id");
					for(int u=0; u<custids.length;u++)
					{
						sql = "DELETE FROM inv_m_servicecenter Where  INT_SERVICECENTERID = "+Integer.parseInt(custids[u]);
						st.execute(sql);
					}
					con.close();    
					response.sendRedirect("Smart Inventory/ServiceCenter.jsp");
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