package com.my.org.erp.SmartDebug;
import java.io.IOException;
 

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.common.CommonFunctions;

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
			 
			if(action.equals("DEBTicketAdd"))
			{
				String pack=request.getParameter("package");
				String priority=request.getParameter("priority");
				String problem=request.getParameter("desc");
				
				asql = " INSERT INTO com_m_ticket (CHR_FROMUSER,CHR_PACKAGE,CHR_PRIORITY,CHR_PROBLEM,DAT_PDATE) VALUES ";
				asql = asql +" ( ?,?,?,?,DATE(NOW()) ) ";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,userid);
				apstm.setString(2,pack);
				apstm.setString(3,priority);
				apstm.setString(4,problem);
				System.out.println(""+apstm);
				apstm.execute();
				apstm.close();
				String m[][] = CommonFunctions.RecordSetArray(con, "SELECT MAX(INT_TICKETID) from com_m_ticket");
				response.sendRedirect("Smart Debug/TicketResponse.jsp?id="+m[0][0]);
			}
			else if(action.equals("DEBTicketUpdate"))
			{
				String ticketid  = request.getParameter ("Ticketid");
				String pack=request.getParameter("package");
				String priority=request.getParameter("priority");
				String problem=request.getParameter("desc");
				
				asql = "UPDATE  com_m_ticket SET CHR_PACKAGE=?," +
						"CHR_PRIORITY=?,CHR_PROBLEM=? WHERE INT_TICKETID=?";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,pack  );
				apstm.setString(2,priority);
				apstm.setString(3,problem);
				apstm.setString(4,ticketid);
				System.out.println(""+apstm);
				apstm.execute();
				apstm.close();
				response.sendRedirect("Smart Debug/DebugView.jsp");
			}
			else if(action.equals("DEBTicketReply"))
			{
				String ticketid  = request.getParameter ("Ticketid");
				String desc=request.getParameter("desc");
				asql = "UPDATE  com_m_ticket SET   CHR_SOLUTION =? , DAT_SDATE =DATE(NOW()), CHR_STATUS='Y' WHERE INT_TICKETID=?";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,desc  );
				apstm.setString(2,ticketid);
				System.out.println(""+apstm);
				apstm.execute();
				apstm.close();
				response.sendRedirect("Smart Debug/DebugView.jsp");
			}
			else if(action.equals("DEBTicketDelete"))
			{
				String ticketids[] = request.getParameterValues("Ticketid");
				asql = "DELETE FROM com_m_ticket WHERE INT_TICKETID=?";
				apstm = con.prepareStatement(asql);
				for(int u=0;u<ticketids.length;u++)
				{
					apstm.setString(1,ticketids[u]);
					apstm.addBatch();
					
				}
				apstm.execute();
				apstm.close();
				response.sendRedirect("Smart Debug/DebugView.jsp");
			}
			
		}catch(Exception e)
		{
			  request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
						
			 System.out.println(e.getMessage());
		}
	}
}
