package com.my.org.erp.SmartMarketing;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
public class ScheduleEntryActionHandler extends AbstractActionHandler 
{
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{

		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String userid  = (String) session.getAttribute("USRID");
			String empid  = (String) session.getAttribute("EMPID");
			if (action.equals("MKTScheduleEntryDelete")) 
			{
				String ids[] = request.getParameterValues("id");
				acs = con.prepareCall("{call MKT_PRO_SCHEDULE(?,?,?,?,?,?,?,?,?)}");
				for (int i = 0; i < ids.length; i++) {
					acs.setString(1, "DELETE");
					acs.setString(2, ids[i]);
					acs.setString(3, "");
					acs.setString(4, "");
					acs.setString(5, "");
					acs.setString(6, "");
					acs.setString(7, "");
					acs.setString(8, "");
					acs.setString(9, "");
					acs.addBatch();
				}
				acs.executeBatch();
				acs.close();
				 
				response.sendRedirect("Smart Marketing/ScheduleEntry.jsp");
			}
			else if (action.equals("MKTScheduleEntryAdd")) 
			{
				String name=request.getParameter("name");
				String customer=request.getParameter("customer");
				String fromdate=request.getParameter("fromdate");
				String todate=request.getParameter("todate");
				String allday=request.getParameter("active");
				if("on".equals(allday) || "".equals(allday))
					allday="Y";
				else
					allday="N";
				name=name.trim();
				acs = con.prepareCall("{call MKT_PRO_SCHEDULE(?,?,?,?,?,?,?,?,?)}");
				acs.setString(1, "INSERT");
				acs.setString(2, "");
				acs.setString(3, customer);
				acs.setString(4, name);
				acs.setString(5, DateUtil.FormateDateandTimeSQL(fromdate));
				acs.setString(6, DateUtil.FormateDateandTimeSQL(todate));
				acs.setString(7, allday);
				acs.setString(8, empid);
				acs.setString(9, userid);
				acs.execute();
				response.sendRedirect("Smart Marketing/ScheduleEntry.jsp");
			} 
			else if (action.equals("MKTScheduleEntryEdit")) 
			{
				String id=request.getParameter("id");
				String name=request.getParameter("name");
				String customer=request.getParameter("customer");
				String fromdate=request.getParameter("fromdate");
				String todate=request.getParameter("todate");
				String allday=request.getParameter("active");
				if("on".equals(allday) || "".equals(allday))
					allday="Y";
				else
					allday="N";
				name=name.trim();
				acs = con.prepareCall("{call MKT_PRO_SCHEDULE(?,?,?,?,?,?,?,?,?)}");
				acs.setString(1, "UPDATE");
				acs.setString(2, id);
				acs.setString(3, customer);
				acs.setString(4, name);
				acs.setString(5, DateUtil.FormateDateandTimeSQL(fromdate));
				acs.setString(6, DateUtil.FormateDateandTimeSQL(todate));
				acs.setString(7, allday);
				acs.setString(8, empid);
				acs.setString(9, userid);
				acs.execute();
				response.sendRedirect("Smart Marketing/ScheduleEntry.jsp");
			}
			else if("MKTScheduleEntryOnline".equals(action))
			{
				String name=request.getParameter("name");
				String customer=request.getParameter("customer");
				String fromdate=request.getParameter("fromdate") ;
				String todate=request.getParameter("todate") ;
				String allday=request.getParameter("active");
				if("on".equals(allday) || "".equals(allday))
					allday="Y";
				else
					allday="N";
				name=name.trim();
				acs = con.prepareCall("{call MKT_PRO_SCHEDULE(?,?,?,?,?,?,?,?,?)}");
				acs.setString(1, "INSERT");
				acs.setString(2, "");
				acs.setString(3, customer);
				acs.setString(4, name);
				acs.setString(5, DateUtil.FormateDateandTimeSQL(fromdate));
				acs.setString(6, DateUtil.FormateDateandTimeSQL(todate));
				acs.setString(7, allday);
				acs.setString(8, empid);
				acs.setString(9, userid);
				System.out.println(""+acs);
				acs.execute();
				response.sendRedirect("Smart Marketing/Refresh.jsp");
				
			}
		} 
		catch (Exception e) 
		{
			 System.out.println(e.getMessage());
		}
	}

}
