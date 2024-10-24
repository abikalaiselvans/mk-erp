package com.my.org.erp.SmartAttendance;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.common.CommonFunctions;

public class StaffDailyAttendanceActionHandler extends AbstractActionHandler
{
	 
	HttpSession session = null;
	String userid = null;

	public synchronized void handle(HttpServletRequest request,	HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			session = request.getSession();
			userid = (String) session.getAttribute("USRID");
			String message="";
			if ("ATTStaffDailyAttendance".equals(action))// DATE WISE
			{
				asql = " SELECT DATE_FORMAT(DT_HOLIDATE,'%d-%m-%Y'),datediff(now(),DT_HOLIDATE) FROM att_t_commonholiday  WHERE datediff(now(),DT_HOLIDATE) <= 30 AND datediff(now(),DT_HOLIDATE) >= -30 ORDER BY DT_HOLIDATE ";
				String commonData[][]= CommonFunctions.QueryExecute(asql);
				String commondate ="";
				if(commonData.length>0)
				{
						for(int u=0;u<commonData.length;u++)
							commondate = commondate +commonData[u][0]+",";
				}
				String holidayarray[]= commondate.split(",");
				
				asql = " SELECT DAY(NOW()) , UPPER(DAYNAME(NOW())) , DATE_FORMAT(NOW(),'%d-%m-%Y'),MONTHNAME(now()), YEAR(NOW()),TIME_FORMAT(NOW(),'%H')  ";
				String data[][] = CommonFunctions.QueryExecutecon(con, asql);
				int day = Integer.parseInt(data[0][0]);
				int time = Integer.parseInt(data[0][5]);
				String dayname = data[0][1];
				String date  = data[0][2];
				
				if(time<11)
				{
					boolean f1 = true;
					boolean f2 = true;
					
					if(holidayarray.length>0)
					{
						for(int i=0;i<holidayarray.length;i++)
							if(date.equals(holidayarray[i]))
									f1 = false;
					}
						
					if("Sunday".equalsIgnoreCase(dayname))
							f2 = false;
					
					
					if( f1 && f2 )
					{
						asql = "UPDATE com_m_staff a,att_t_register b    SET b.CHR_MORNING"+day+" = 'PRE'   ,  b.CHR_EVENING"+day+" = 'PRE' "; 
						asql = asql+ " WHERE a.CHR_EMPID = b.CHR_EMPID	";
						asql = asql+ " AND ( a.DAT_RESIGNDATE is null OR a.DAT_RESIGNDATE <=NOW() )	";
						asql = asql+ " AND DT_DOJCOLLEGE <= NOW()	";
						asql = asql+ " AND b.CHR_MONTH=?  AND b.INT_YEAR=?	";		
						apstm = con.prepareStatement(asql);
						apstm.setString(1, data[0][3]);
						apstm.setString(2, data[0][4]);
						System.out.println(""+apstm);
						//apstm.execute();
						message =" Attendance successfully marked on "+date;
					}
					else
						message =" Kindly check the date "+date;
					
				}	
				else
					message =" Not possible due to time exceeds  "+time;
				
				 
				con.close();
				response.sendRedirect("Smart Attendance/AttendanceAlert.jsp?message="+message);
			}

		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
		}
	}
 

}
