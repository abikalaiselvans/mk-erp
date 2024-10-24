package com.my.org.erp.SmartAttendance;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;

public class ShiftAllocationActionHandler extends AbstractActionHandler {
	String TxtHoliname, sesUser;
	int courseId;
	private PreparedStatement ps=null;
	
	
	private void insertAllocation(String staff[],String Shift,String days,String user,String cudate)
	{
		try
		{
			String day[]=days.split(",");
			String fields="";
			String month="";
			int year=0;
			int no_of_day=0;
			String sql="";
			boolean flag=false;
			for(int n=0;n<staff.length;n++)
			{
				for(int i=0;i<day.length;i++)
				{
					month=DateUtil.getMonth(Integer.parseInt(com.my.org.erp.common.CommonInfo.stringGetAnySelectField("select month('"+day[i]+"') as month1", "month1")));
					year=Integer.parseInt(com.my.org.erp.common.CommonInfo.stringGetAnySelectField("select year('"+day[i]+"') as year1", "year1"));
					no_of_day=Integer.parseInt(com.my.org.erp.common.CommonInfo.stringGetAnySelectField("select day('"+day[i]+"') as day1", "day1"));
					sql="select * from att_t_shiftallocation where CHR_EMPID='"+staff[n]+"' and CHR_MONTH='"+month+"' and INT_YEAR='"+year+"'";
					flag=com.my.org.erp.common.CommonInfo.RecordExist(sql);
					if(flag)
						fields="UPDATE att_t_shiftallocation SET DAT_SHIFT"+no_of_day+"="+Shift+",CHR_USRNAME='"+user+"',DT_UPDATEDATE='"+cudate+"',CHR_UPDATESTATUS='Y' where CHR_EMPID='"+staff[n]+"' and CHR_MONTH='"+month+"' and INT_YEAR="+year+"";
					else
						fields="INSERT INTO att_t_shiftallocation(CHR_EMPID,CHR_MONTH,INT_YEAR,DAT_SHIFT"+no_of_day+",CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS) VALUES('"+staff[n]+"','"+month+"',"+year+","+Shift+",'"+user+"','"+cudate+"','Y')";
					ps=con.prepareStatement(fields);
					ps.execute();
				}
			}
		}
		
		catch (NumberFormatException e) 
		{
			 System.out.println(e.getMessage());
		} 
		catch (SQLException e) 
		{			
			 System.out.println(e.getMessage());
		}
		catch(Exception es)
		{
			es.printStackTrace();
		}
	}
	
	
	
	private void ShiftAllocationAdd(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			HttpSession session = request.getSession();
			sesUser = (String) session.getAttribute("USRID");
			String staffname[] = request.getParameterValues("ename");
			String shiftname = request.getParameter("shift");
			String fdate = request.getParameter("fromdt");
			String tdate = request.getParameter("todt");
			String cudate=DateUtil.getCurrentDBDate();
			fdate = DateUtil.FormateDateSQL(fdate);
			tdate = DateUtil.FormateDateSQL(tdate);
			String days=com.my.org.erp.common.CommonFunctions.getDaysBetweenDateinSQLformat(fdate, tdate);
			insertAllocation(staffname,shiftname,days,sesUser,cudate);
			
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}	
	}	

	private void ShiftAllocationUpdate (HttpServletRequest request, HttpServletResponse response) 
	throws ServletException, IOException 
	{
		try 
		{
				HttpSession session = request.getSession();
				sesUser = (String) session.getAttribute("USRID");
				String staffid = request.getParameter("staffid");
				String month = request.getParameter("month");
				String year = request.getParameter("year");
				String Odate = request.getParameter("Odate");
				int no_of_day=Integer.parseInt(com.my.org.erp.common.CommonInfo.stringGetAnySelectField("select day('"+Odate+"') as day1", "day1"));
				String shift = request.getParameter("shift");
				String cudate=DateUtil.getCurrentDBDate();
				String sql ="";
				sql ="UPDATE att_t_shiftallocation SET DAT_SHIFT"+no_of_day+"="+shift+",CHR_USRNAME='"+sesUser+"',DT_UPDATEDATE='"+cudate+"',CHR_UPDATESTATUS='Y' where CHR_EMPID='"+staffid+"' and CHR_MONTH='"+month+"' and INT_YEAR="+year+"";
				
				ps= con.prepareStatement(sql);
				ps.executeUpdate(sql);
				
		}
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}	
	}

	private void ShiftAllocationDelete(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			String staffids[] = request.getParameterValues("allocation");
			String staff="",month="",year="",date="";
			Statement st = con.createStatement();
			int no_of_day=0;
			for(int u=0; u<staffids.length;u++)
			{
				String val[] = staffids[u].trim().split("~");
				staff=val[0];
				month=val[1];
				year=val[2];
				date=val[4];
				no_of_day=Integer.parseInt(com.my.org.erp.common.CommonInfo.stringGetAnySelectField("select day('"+date+"') as day1", "day1"));
				
				String sql ="UPDATE att_t_shiftallocation SET DAT_SHIFT"+no_of_day+"=0 where CHR_EMPID='"+staff+"' and CHR_MONTH='"+month+"' and INT_YEAR="+year+"";
				;
				st.executeUpdate(sql);
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
			
			if (action.equals("ATTshiftAdd")) 
			{
				ShiftAllocationAdd(request, response);		
				con.close();   
				response.sendRedirect("Smart Attendance/ShiftAllocation.jsp");
			}
			else if (action.equals("ATTshiftUpdate"))
			{
				String staffid = request.getParameter("staffid");
				String month = request.getParameter("month");
				String year = request.getParameter("year");
				ShiftAllocationUpdate(request, response);
				con.close();   
				response.sendRedirect("Smart Attendance/ShiftAllocationEdit.jsp?month="+month+"&year="+year+"&stafftid="+staffid+"");
			}
			else if (action.equals("ATTshiftDelete")) 
			{
				ShiftAllocationDelete(request, response);
				con.close();   
				response.sendRedirect("Smart Attendance/ShiftAllocation.jsp");
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
