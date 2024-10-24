package com.my.org.erp.SmartStaff;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;
public class StaffDaillyCallsActionHandler extends AbstractActionHandler 
{
 
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String userid  = (String) session.getAttribute("USRID");
			String empid  = (String) session.getAttribute("EMPID");
			if (action.equals("STADaillyCallsAdd")) 
			{
				String name=request.getParameter("name");
				String customer=request.getParameter("customer");
				String calltype=request.getParameter("calltype");
				String desc=request.getParameter("desc");
				String fromdate=request.getParameter("fromdate");
				String todate=request.getParameter("todate");
				String allday=request.getParameter("active");
				String Follows=request.getParameter("Follows");
				String opportunityvalue=request.getParameter("opportunityvalue");
				if(!"Y".equals(Follows))
					Follows ="N";
				if("Y".equals(allday) || "".equals(allday))
					allday="Y";
				else
					allday="N";
				String refnumber = CommonFunctions.QueryExecute("SELECT CONCAT('SFA/', (SELECT RIGHT(CONCAT('00000', (SELECT IF( (COUNT(*)>0 ) , (MAX(INT_CALLID)+1),'1')   FROM mkt_t_daillycalls)),6)) ) ")[0][0];
				acs = con.prepareCall("{call MKT_PRO_SCHEDULESTATUS( ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				acs.setString(1, "INSERT");
				acs.setString(2, "");
				acs.setString(3, customer);
				acs.setString(4, name);
				acs.setString(5, calltype);
				acs.setString(6, empid);
				acs.setString(7, desc);
				acs.setString(8, DateUtil.FormateDateandTimeSQL(fromdate));
				acs.setString(9, DateUtil.FormateDateandTimeSQL(todate));
				acs.setString(10, allday);
				if ("N".equals(Follows)) // no follows up
				{
					acs.setString(11, "Y");//status
					acs.setString(12, "N");//next call
					acs.setString(13, null);
					acs.setString(14, null);
					acs.setString(15,refnumber);
					acs.setString(16,opportunityvalue);
					acs.setString(17, userid);
				}	
				else
				{
					acs.setString(11, "Y");//status
					acs.setString(12, "Y");//next call
					acs.setString(13, null);
					acs.setString(14, null);
					acs.setString(15,refnumber);
					acs.setString(16,opportunityvalue);
					acs.setString(17, userid);
				}
				System.out.println(""+acs);
				acs.execute();
				
				String rowid = CommonFunctions.QueryExecute("SELECT MAX(INT_CALLID) FROM mkt_t_daillycalls")[0][0];
				
				if ("Y".equals(Follows))
				{

					String nfromdate=request.getParameter("nfromdate");
					String ntodate=request.getParameter("ntodate");
					String newcalltype=request.getParameter("newcalltype");
					
					acs = con.prepareCall("{call MKT_PRO_SCHEDULESTATUS(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					acs.setString(1, "UPDATE");
					acs.setString(2, rowid);
					acs.setString(3, "");
					acs.setString(4, name);
					acs.setString(5, calltype);
					acs.setString(6, empid);
					acs.setString(7, desc);
					acs.setString(8, DateUtil.FormateDateandTimeSQL(fromdate));
					acs.setString(9, DateUtil.FormateDateandTimeSQL(todate));
					acs.setString(10, allday);
					acs.setString(11, "Y");//status
					acs.setString(12, "Y");//next flag
					acs.setString(13, rowid);//refid
					acs.setString(14, DateUtil.FormateDateandTimeSQL(nfromdate));
					acs.setString(15, refnumber);//refnumber
					acs.setString(16,opportunityvalue);
					acs.setString(17, userid);
					System.out.println("------------------"+acs);
					acs.execute();

					
					acs = con.prepareCall("{call MKT_PRO_SCHEDULESTATUS(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					acs.setString(1, "INSERT");
					acs.setString(2, "");
					acs.setString(3, customer);
					acs.setString(4, name);
					acs.setString(5, newcalltype);
					acs.setString(6, empid);
					acs.setString(7, desc);
					acs.setString(8, DateUtil.FormateDateandTimeSQL(nfromdate));
					acs.setString(9, DateUtil.FormateDateandTimeSQL(ntodate));
					acs.setString(10, allday);
					acs.setString(11, "N");//status
					acs.setString(12, "N");//next flag
					acs.setString(13, rowid);//parent ref id
					acs.setString(14, "");//date follow
					acs.setString(15, refnumber); //refnumber
					acs.setString(16,opportunityvalue);
					acs.setString(17, userid);
					System.out.println(""+acs);
					acs.execute();					
				}
				con.close();
				response.sendRedirect("Staff/DailyCallsAction.jsp?msg=Record added successfully...");
				
			}
			else if (action.equals("STADaillyCallsEdit")) 
			{ 

				String id = request.getParameter("id");
				String name=request.getParameter("name");
				String customer=request.getParameter("customer");
				String calltype=request.getParameter("calltype");
				String newcalltype=request.getParameter("newcalltype");
				String desc=request.getParameter("desc");
				String fromdate=request.getParameter("fromdate");
				String todate=request.getParameter("todate");
				String nfromdate=request.getParameter("nfromdate");
				String ntodate=request.getParameter("ntodate");
				String allday=request.getParameter("active");
				String close=request.getParameter("close");
				String opportunityvalue=request.getParameter("opportunityvalue");
				
				if(!"Y".equals(allday))
					allday="N";
				
				asql = "select INT_CALLID,INT_REFID,CHR_REFNUMBER from mkt_t_daillycalls where INT_CALLID="+id;
				String call[][] =CommonFunctions.QueryExecute(asql);
				
				if("Y".equals(close))
				{
					acs = con.prepareCall("{call MKT_PRO_SCHEDULESTATUS(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					acs.setString(1, "UPDATE");
					acs.setString(2, id);
					acs.setString(3, "");
					acs.setString(4, name);
					acs.setString(5, calltype);
					acs.setString(6, empid);
					acs.setString(7, desc);
					acs.setString(8, DateUtil.FormateDateandTimeSQL(fromdate));
					acs.setString(9, DateUtil.FormateDateandTimeSQL(todate));
					acs.setString(10, allday);
					acs.setString(11, "Y");//status
					acs.setString(12, "N");//nextflag
					acs.setString(13, call[0][1]);//refid
					acs.setString(14, null);
					acs.setString(15, call[0][2]);//refnumber
					acs.setString(16,opportunityvalue);
					acs.setString(17, userid);
					System.out.println(""+acs);
					acs.execute();
					con.close();
					response.sendRedirect("Staff/DailyCalls.jsp");
					
				}
				else
				{
					
					//Update parent row
					acs = con.prepareCall("{call MKT_PRO_SCHEDULESTATUS(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					acs.setString(1, "UPDATE");
					acs.setString(2, id);
					acs.setString(3, "");
					acs.setString(4, name);
					acs.setString(5, calltype);
					acs.setString(6, empid);
					acs.setString(7, desc);
					acs.setString(8, DateUtil.FormateDateandTimeSQL(fromdate));
					acs.setString(9, DateUtil.FormateDateandTimeSQL(todate));
					acs.setString(10, allday);
					acs.setString(11, "Y");//status
					acs.setString(12, "Y");//next flag
					acs.setString(13, call[0][1]);//refid
					acs.setString(14, DateUtil.FormateDateandTimeSQL(nfromdate));
					acs.setString(15, call[0][2]);//refnumber
					acs.setString(16,opportunityvalue);
					acs.setString(17, userid);
					System.out.println(""+acs);
					acs.execute();
					
					//INSERT NEW RECORD
					acs = con.prepareCall("{call MKT_PRO_SCHEDULESTATUS(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					acs.setString(1, "INSERT");
					acs.setString(2, "");
					acs.setString(3, customer);
					acs.setString(4, name);
					acs.setString(5, newcalltype);
					acs.setString(6, empid);
					acs.setString(7, desc);
					acs.setString(8, DateUtil.FormateDateandTimeSQL(nfromdate));
					acs.setString(9, DateUtil.FormateDateandTimeSQL(ntodate));
					acs.setString(10, allday);
					acs.setString(11, "N");//status
					acs.setString(12, "N");//next flag
					acs.setString(13, id);//parent ref id
					acs.setString(14, "");//date follow
					acs.setString(15, call[0][2]); //refnumber
					acs.setString(16,opportunityvalue);
					acs.setString(17, userid);
					System.out.println(""+acs);
					acs.execute();
					con.close();
					response.sendRedirect("Staff/DailyCalls.jsp");
				}
				
			
			}
			else
			{
				con.close();
				response.sendRedirect("Staff/DailyCalls.jsp");
			}
			 
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
 			request.setAttribute("error", e.getMessage());
 			RequestDispatcher dispatchers = request	.getRequestDispatcher("/error/index.jsp");
 			dispatchers.forward(request, response); 
		}
	}

}
