package com.my.org.erp.Stock;
import java.io.IOException;
import java.sql.CallableStatement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
public class TargetAssignActionHandler extends AbstractActionHandler
{
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try
		{
			HttpSession session=request.getSession();			
			String action=request.getParameter("actionS");
			String userid=""+session.getAttribute("USRID");
			CallableStatement cs ;
			
			if("STKTargetAssignAdd".equals(action)) 
			{
				String ename[]= request.getParameterValues("ename");
				String Financialyear= request.getParameter("Financialyear");
				String April= request.getParameter("April");
				String May= request.getParameter("May");
				String June= request.getParameter("June");
				String July= request.getParameter("July");
				String August= request.getParameter("August");
				String September= request.getParameter("September");
				String October= request.getParameter("October");
				String November= request.getParameter("November");
				String December= request.getParameter("December");
				String January= request.getParameter("January");
				String February= request.getParameter("February");
				String March= request.getParameter("March");
				cs = con.prepareCall("{call  CON_INV_PRO_TARGETASSIGN (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				for(int u=0; u<ename.length;u++)
				{
					cs.setString(1, "INSERT");
					cs.setString(2, "1");
					cs.setString(3,ename[u]);
					cs.setString(4,Financialyear);
					cs.setString(5, April);
					cs.setString(6, May);
					cs.setString(7, June);
					cs.setString(8, July);
					cs.setString(9, August);
					cs.setString(10, September);
					cs.setString(11, October);
					cs.setString(12, November);
					cs.setString(13, December);
					cs.setString(14, January);
					cs.setString(15, February);
					cs.setString(16, March);
					cs.setString(17, userid);
					cs.addBatch();	
				}	
				cs.executeBatch();
				cs.close();
				response.sendRedirect("SmartStock/TargetAssignview.jsp");
			}
			else if("STKTargetAssignEdit".equals(action))
			{
				String TargetAssignid= request.getParameter("TargetAssignid");
				String ename= request.getParameter("ename");
				String Financialyear= request.getParameter("Financialyear");
				String April= request.getParameter("April");
				String May= request.getParameter("May");
				String June= request.getParameter("June");
				String July= request.getParameter("July");
				String August= request.getParameter("August");
				String September= request.getParameter("September");
				String October= request.getParameter("October");
				String November= request.getParameter("November");
				String December= request.getParameter("December");
				String January= request.getParameter("January");
				String February= request.getParameter("February");
				String March= request.getParameter("March");
				cs = con.prepareCall("{call  CON_INV_PRO_TARGETASSIGN (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				cs.setString(1, "UPDATE");
				cs.setString(2, TargetAssignid);
				cs.setString(3,ename);
				cs.setString(4,Financialyear);
				cs.setString(5, April);
				cs.setString(6, May);
				cs.setString(7, June);
				cs.setString(8, July);
				cs.setString(9, August);
				cs.setString(10, September);
				cs.setString(11, October);
				cs.setString(12, November);
				cs.setString(13, December);
				cs.setString(14, January);
				cs.setString(15, February);
				cs.setString(16, March);
				cs.setString(17, userid);
				cs.execute();
				cs.close();
				 
				response.sendRedirect("SmartStock/TargetAssignview.jsp");
			}
			else if("STKTargetAssignDelete".equals(action))
			{
				String data[] =request.getParameterValues("TargetAssignid");
				 
				try 
				{
					cs = con.prepareCall("{call  CON_INV_PRO_TARGETASSIGN (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					for(int y=0;y<data.length;y++)
					{
						cs.setString(1, "DELETE");
						cs.setString(2,data[y]);
						cs.setString(3,"1");
						cs.setString(4, "1");
						cs.setString(5, "1");
						cs.setString(6, "1");
						cs.setString(7, "1");
						cs.setString(8, "1");
						cs.setString(9, "1");
						cs.setString(10, "1");
						cs.setString(11, "1");
						cs.setString(12, "1");
						cs.setString(13, "1");
						cs.setString(14, "1");
						cs.setString(15, "1");
						cs.setString(16, "1");
						cs.setString(17, "1");
						cs.addBatch();				
					}
					cs.executeBatch();
					cs.close();
				}
				catch(Exception e)
				{
					
				}

				response.sendRedirect("SmartStock/TargetAssignview.jsp");
				
			}
			 
		} 
		catch (Exception e) 
		{
				 System.out.println(e.getMessage());			
		}
	}	
}
