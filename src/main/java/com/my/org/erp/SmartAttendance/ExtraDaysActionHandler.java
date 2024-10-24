package com.my.org.erp.SmartAttendance;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;

public class ExtraDaysActionHandler extends AbstractActionHandler 
{
	
	private void ExtraDaysDelete(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String rowid[] = request.getParameterValues("rowid");
			acs = con.prepareCall("{call ATT_PRO_EXTRADAYS(?,?,?,?,?,?,?,?)}");
			for(int u=0; u<rowid.length;u++)
			{
				acs.setString(1, "DELETE");
				acs.setString(2, rowid[u]);
				acs.setString(3, "");
				acs.setString(4, "");
				acs.setString(5, "");
				acs.setString(6,  "" );
				acs.setString(7, "");
				acs.setString(8, "");
				acs.addBatch(); 
			}
			acs.executeBatch();
			acs.close();
		}
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}	
	}


	private void ExtraDaysAdd(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			HttpSession session = request.getSession();
			String userid = (String) session.getAttribute("USRID");
			 String staffids[] = request.getParameterValues("ename");
			String entDay = request.getParameter("txtDay");
			String fromdt = request.getParameter("fromdt");
			String ComboDay = request.getParameter("ComboDay");
			String hdescription = request.getParameter("hdescription");
			String sql = " SELECT DATE_FORMAT(DT_HOLIDATE,'%d-%m-%Y'),datediff(now(),DT_HOLIDATE) FROM att_t_commonholiday  WHERE datediff(now(),DT_HOLIDATE) <= 30 AND datediff(now(),DT_HOLIDATE) >= -30 ORDER BY DT_HOLIDATE ";
			String commonData[][]= CommonFunctions.QueryExecute(sql);
			String commondate ="";
			boolean flag =false;
			if(commonData.length>0)
					for(int u=0;u<commonData.length;u++)
						commondate = commondate +commonData[u][0]+",";
			
			String s[] = commondate.split(",");
			if(s.length>0)
				for(int x=0;x<s.length;x++)
					if(fromdt.equals(s[x]))
						flag = true;
			
			if (entDay.equals("Sunday") || flag) 
			{    
				 
				double dayvalue=0.0;
				acs = con.prepareCall("{call ATT_PRO_EXTRADAYS(?,?,?,?,?,?,?,?)}");
				for (int i = 0; i < staffids.length; i++) 
				{
					asql ="SELECT COUNT(*) FROM att_t_extradays WHERE CHR_EMPID='"+staffids[i]+"' AND DT_EXTRADATE='"+DateUtil.FormateDateSQL(fromdt)+"'";
					if(!CommonFunctions.RecordExist(con, asql))
					{	
						acs.setString(1, "INSERT");
						acs.setString(2, "");
						acs.setString(3, staffids[i]);
						acs.setString(4, DateUtil.FormateDateSQL(fromdt));
						acs.setString(5, ComboDay);
						
						if("Full Day".equals(ComboDay))
							dayvalue=1.0;
						else
							dayvalue=0.5;
						
						acs.setString(6,  ""+dayvalue);
						acs.setString(7, hdescription);
						acs.setString(8, userid);
						System.out.println(""+acs);
						acs.addBatch();
					}
				}
				
				acs.executeBatch();
				acs.close();
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
	
	
 
	
	private void ExtraDaysUpdate (	HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			HttpSession session = request.getSession();
			String userid = (String) session.getAttribute("USRID");
			String rowid = request.getParameter("rowid");
			String fromdt = request.getParameter("fromdt");
			String hdescription = request.getParameter("hdescription");
			String ComboDay = request.getParameter("ComboDay");
			String entDay = request.getParameter("txtDay");
			double dayvalue=0.0;
			if("Full Day".equals(ComboDay))
				dayvalue=1.0;
			else
				dayvalue=0.5;
			if (entDay.equals("Sunday")) 
			{    
			
				acs = con.prepareCall("{call ATT_PRO_EXTRADAYS(?,?,?,?,?,?,?,?)}");
				acs.setString(1, "UPDATE");
				acs.setString(2, rowid);
				acs.setString(3, "");
				acs.setString(4, DateUtil.FormateDateSQL(fromdt));
				acs.setString(5, ComboDay);
				
				if("Full Day".equals(ComboDay))
					dayvalue=1.0;
				else
					dayvalue=0.5;
				acs.setString(6,  ""+dayvalue);
				acs.setString(7, hdescription);
				acs.setString(8, userid);
				acs.execute();
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
	
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			if (action.equals("ATTExtraDaysAdd")) 
			{
				ExtraDaysAdd(request, response);
				con.close();   
				response.sendRedirect("Smart Attendance/ExtraDays.jsp");
			}
			else if (action.equals("ATTExtraDaysUpdate")) 
			{
				ExtraDaysUpdate(request, response);
				con.close();   
				response.sendRedirect("Smart Attendance/ExtraDays.jsp");
			}
			else if (action.equals("ATTExtraDaysDelete")) 
			{
				ExtraDaysDelete(request, response);
				con.close();   
				response.sendRedirect("Smart Attendance/ExtraDays.jsp");
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