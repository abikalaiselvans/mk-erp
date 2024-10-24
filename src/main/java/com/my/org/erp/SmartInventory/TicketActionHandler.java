package com.my.org.erp.SmartInventory;
import java.io.IOException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class TicketActionHandler extends AbstractActionHandler
{
 public void handle(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException
	{
		try
		{
			String action=request.getParameter("actionS");
			HttpSession session=request.getSession();
			String userid=""+session.getAttribute("USRID");
			@SuppressWarnings("unused")
			String branchId=""+session.getAttribute("BRANCHID");
			@SuppressWarnings("unused")
			String admin =""+session.getAttribute("USRTYPE");
			String sql="";
			Statement st = con.createStatement();
			if(action.equals("INVTicketAdd"))
			{
				String pack=request.getParameter("package");
				String priority=request.getParameter("priority");
				String problem=request.getParameter("desc");
				sql ="INSERT INTO com_m_ticket (CHR_FROMUSER,CHR_PACKAGE,CHR_PRIORITY,CHR_PROBLEM,DAT_PDATE) VALUES ";
				sql = sql +"(";
				sql = sql +"'"+userid+"' , ";
				sql = sql +"'"+pack+"' , ";
				sql = sql +"'"+priority+"' , ";
				sql = sql +"'"+problem+"' , ";
				sql = sql +"now() ) ";
				st.execute(sql);
				String m[][] = com.my.org.erp.common.CommonFunctions.RecordSetArray(con, "SELECT MAX(INT_TICKETID) from com_m_ticket");
				con.close();   
				response.sendRedirect("Smart Inventory/TicketResponse.jsp?id="+m[0][0]);
			}
			else if(action.equals("INVTicketUpdate"))
			{
				String ticketid  = request.getParameter ("Ticketid");
				String pack=request.getParameter("package");
				String priority=request.getParameter("priority");
				String problem=request.getParameter("desc");
				sql = "UPDATE  com_m_ticket SET CHR_PACKAGE='"+pack +"' , CHR_PRIORITY = '"+priority+"' , CHR_PROBLEM ='"+problem+"' WHERE INT_TICKETID="+ticketid;
				st.execute(sql);
				con.close();   
				response.sendRedirect("Smart Inventory/TicketView.jsp");
			}
			else if(action.equals("INVTicketReply"))
			{
				String ticketid  = request.getParameter ("Ticketid");
				String desc=request.getParameter("desc");
				sql = "UPDATE  com_m_ticket SET   CHR_SOLUTION ='"+desc+"' , DAT_SDATE =now(), CHR_STATUS='Y' WHERE INT_TICKETID="+ticketid;
				st.execute(sql);
				con.close();   
				response.sendRedirect("Smart Inventory/TicketView.jsp");
			}
			else if(action.equals("INVTicketDelete"))
			{
				String ticketids[] = request.getParameterValues("Ticketid");
				for(int u=0;u<ticketids.length;u++)
				{
					sql = "DELETE FROM com_m_ticket WHERE INT_TICKETID="+ticketids[u];
					st.execute(sql);
				}
				con.close();   
				response.sendRedirect("Smart Inventory/TicketView.jsp");
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
