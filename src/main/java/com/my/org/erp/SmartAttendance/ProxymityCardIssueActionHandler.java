package com.my.org.erp.SmartAttendance;

import java.io.IOException;
import java.sql.CallableStatement;
 

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
 

public class ProxymityCardIssueActionHandler extends AbstractActionHandler 
{
	 
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		
		try 
		{
			
			HttpSession session=request.getSession();			
			String userid=""+session.getAttribute("USRID");
			String action = request.getParameter("actionS");
			CallableStatement cs ;
			if (action.equals("ATTProxymityCardADD")) 
			{
				String ename= request.getParameter("ename");
				String cardno= request.getParameter("cardno");
				cs = con.prepareCall("{call ATT_PRO_PROXYMITYCARDISSUE (?,?,?,?,?)}");
				cs.setString(1, "INSERT");
				cs.setString(2, "1");
				cs.setString(3,ename);
				cs.setString(4,cardno.trim());
				cs.setString(5,userid);
				cs.execute();
				cs.close();
				response.sendRedirect("Smart Attendance/ProximityView.jsp");
			}
			else if (action.equals("ATTProxymityCardUpdate")) 
			{
				String ename= request.getParameter("ename");
				String cardno= request.getParameter("cardno");
				String rowid= request.getParameter("rowid");
				cs = con.prepareCall("{call ATT_PRO_PROXYMITYCARDISSUE (?,?,?,?,?)}");
				cs.setString(1, "UPDATE");
				cs.setString(2, rowid);
				cs.setString(3,ename);
				cs.setString(4,cardno.trim());
				cs.setString(5,userid);
				cs.execute();
				cs.close();
				con.close();   
				response.sendRedirect("Smart Attendance/ProximityView.jsp");
			}
			else if (action.equals("ATTProxymityCardDelete")) 
			{
				String data[] =request.getParameterValues("staffid");
				cs = con.prepareCall("{call ATT_PRO_PROXYMITYCARDISSUE (?,?,?,?,?)}");
				for(int y=0;y<data.length;y++)
				{
					cs.setString(1, "DELETE");
					cs.setString(2,"0");
					cs.setString(3,data[y]);
					cs.setString(4, "1");
					cs.setString(5, "1");
					cs.addBatch();				
				}
				cs.executeBatch();
				con.close();   ;
				response.sendRedirect("Smart Attendance/ProximityView.jsp");
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
