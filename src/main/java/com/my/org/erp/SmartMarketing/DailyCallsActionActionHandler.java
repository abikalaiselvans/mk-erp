package com.my.org.erp.SmartMarketing;

import java.io.IOException;
import java.sql.CallableStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

 
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
 
public class DailyCallsActionActionHandler extends AbstractActionHandler {
	
	 
	 

	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{

		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String user  = (String) session.getAttribute("USRID");
			
			if (action.equals("MKTDailyCallsActionDelete")) 
			{
				String ids[] = request.getParameterValues("id");
				CallableStatement cs = con.prepareCall("{call  MKT_PRO_CUSTOMERGROUP(?,?,?,?,?,?)}");
				for (int i = 0; i < ids.length; i++) {
					cs.setString(1, "DELETE");
					cs.setString(2, ids[i]);
					cs.setString(3, "");
					cs.setString(4, null);
					cs.setString(5, "");
					cs.setString(6, user);
					cs.addBatch();
				}
				cs.executeBatch();
				cs.close();
				 
				response.sendRedirect("Smart Marketing/DailyCalls.jsp");
			}
			else if (action.equals("MKTDailyCallsActionAdd")) 
			{
				String name=request.getParameter("name");
				String dor=request.getParameter("dor");
				String active=request.getParameter("active");
				if("on".equals(active) || "".equals(active))
					active="Y";
				else
					active="N";
				name=name.trim();
				CallableStatement cs = con.prepareCall("{call MKT_PRO_CUSTOMERGROUP(?,?,?,?,?,?)}");
				cs.setString(1, "INSERT");
				cs.setString(2, "1");
				cs.setString(3, name);
				cs.setString(4, DateUtil.FormateDateSQL(dor));
				cs.setString(5, active);
				cs.setString(6, user);
				cs.execute();
				response.sendRedirect("Smart Marketing/DailyCallsAction.jsp?action1=Add");
			} 
			else if (action.equals("MKTDailyCallsActionEdit")) 
			{
				 
				
				String id=request.getParameter("id");
				String name=request.getParameter("name");
				String dor=request.getParameter("dor"); 
				name=name.trim();
				String active=request.getParameter("active");
				if("on".equals(active) || "".equals(active))
					active="Y";
				else
					active="N";
				 
				CallableStatement cs = con.prepareCall("{call MKT_PRO_CUSTOMERGROUP(?,?,?,?,?,?)}");
				cs.setString(1, "UPDATE");
				cs.setString(2, id);
				cs.setString(3, name);
				cs.setString(4, DateUtil.FormateDateSQL(dor));
				cs.setString(5, active);
				cs.setString(6, user);
				cs.execute();

				response.sendRedirect("Smart Marketing/DailyCalls.jsp");
				
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
