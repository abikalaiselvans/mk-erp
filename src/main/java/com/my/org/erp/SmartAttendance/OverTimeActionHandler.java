package com.my.org.erp.SmartAttendance;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.bean.Attendance.Holiday;
import com.my.org.erp.common.CommonFunctions;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;

public class OverTimeActionHandler extends AbstractActionHandler 
{
	String TxtOvertime, sesUser,batta,washing,Txtdes;
	String ovTime="";
	Statement st;
	int courseId;
	public void insertOverTime(String staffid, String dat) 
	{	
		try 
		{
			acs = con.prepareCall("{call ATT_PRO_OT(?,?,?,?,?,?,?,?,?,?)}");
			acs.setString(1, "INSERT");
			acs.setString(2, staffid);
			acs.setString(3, dat);
			acs.setString(4, ovTime);
			acs.setString(5, batta);
			acs.setString(6, washing);
			acs.setString(7, Txtdes);
			String data[] = dat.split("-");
			String month = DateUtil.getMonth(Integer.parseInt(data[1]));
			acs.setString(8, month);
			acs.setInt(9, Integer.parseInt(data[0]));
			acs.setString(10, sesUser);
			acs.execute();
			acs.close();
			
		} 
		catch (Exception e) 
		{
			 System.out.println(e.getMessage());
		}
	}
	
	private void OverTimeDelete(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try 
		{
			String staffids[] = request.getParameterValues("staffid");
			st = con.createStatement();
			for(int u=0; u<staffids.length;u++)
			{
				String val[] = staffids[u].trim().split("~");
				String sql =" DELETE FROM ATT_T_OT WHERE CHR_EMPID = '"+val[0]+"'";	
				sql = sql +" AND  DT_OTDATE = '"+val[1]+"'";
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


	private void OverTimeAdd(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			HttpSession session = request.getSession();
			sesUser = (String) session.getAttribute("USRID");
			String staffname[] = request.getParameterValues("ename");
			TxtOvertime = request.getParameter("overtime");
			batta =""+request.getParameter("batta");		
			
			if(batta.equals("")|| batta.equals(null))
				batta="0";				
						
			washing = ""+request.getParameter("washing");		
			
			if(washing.equals("")|| washing.equals(null))
				washing="0";				
			
			String ottype = request.getParameter("otType");

			if (ottype.equals("hours")) {
				if (TxtOvertime != "" || TxtOvertime != "0" || TxtOvertime != null)							
					ovTime = String.valueOf(Integer.parseInt(TxtOvertime)*60);
			}
			else
			{
				ovTime = TxtOvertime;	
			}
			
			Txtdes = request.getParameter("Txtdes");
			String fdate = request.getParameter("fromdt");
			String tdate = request.getParameter("todt");
			String date1 = DateUtil.FormateDateSQL(fdate);
			String date2 = DateUtil.FormateDateSQL(tdate);
			for (int i = 0; i < staffname.length; i++) {
				date1 = DateUtil.FormateDateSQL(fdate);
				date2 = DateUtil.FormateDateSQL(tdate);			
				while (true) {
					insertOverTime(staffname[i], date1);
						
						if (date1.equalsIgnoreCase(date2))
							break;
			
						date1 = DateUtil.addDate(date1, 1);
				}
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

	@SuppressWarnings("unused")
	private void OverTimeView(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			HttpSession session = request.getSession();
			sesUser = (String) session.getAttribute("USRID");
			String staffname[] = request.getParameterValues("ename");
			String fdate = request.getParameter("fromdt");
			String tdate = request.getParameter("todt");
			String date1 = DateUtil.FormateDateSQL(fdate);
			String date2 = DateUtil.FormateDateSQL(tdate);
			ArrayList<Holiday> holidayList = new ArrayList<Holiday>();
			date1 = DateUtil.FormateDateSQL(fdate);
			date2 = DateUtil.FormateDateSQL(tdate);

			if (staffname == null) {
				String sql = "SELECT A.CHR_EMPID,A.CHR_STAFFNAME,B.DT_HOLIDATE,B.CHR_HOLINAME FROM ";
				sql = sql
						+ "  com_m_staff  A,ATT_T_HOLIDAY B WHERE A.CHR_EMPID=B.CHR_EMPID AND B.DT_HOLIDATE>='"
						+ date1 + "' AND B.DT_HOLIDATE<='" + date2 + "'";

				Statement st = con.createStatement();
				ResultSet rs = st.executeQuery(sql);
				while (rs.next()) {
					Holiday holiday = new Holiday();
					holiday.setEmpId(rs.getString(1));
					holiday.setEmpName(rs.getString(2));
					holiday.setHolidayDate(rs.getString(3));
					holiday.setHolidayName(rs.getString(4));
					holidayList.add(holiday);
				}
			} 
			else
				for (int i = 0; i < staffname.length; i++) {
					String sql = "SELECT A.CHR_EMPID,A.CHR_STAFFNAME,B.DT_HOLIDATE,B.CHR_HOLINAME FROM ";
					sql = sql
							+ "  com_m_staff  A,ATT_T_HOLIDAY B WHERE A.CHR_EMPID=B.CHR_EMPID AND B.DT_HOLIDATE>='"
							+ date1 + "' AND B.DT_HOLIDATE<='" + date2
							+ "' AND B.CHR_EMPID='" + staffname[i] + "'";
					Statement st = con.createStatement();
					ResultSet rs = st.executeQuery(sql);
					while (rs.next()) {
						Holiday holiday = new Holiday();
						holiday.setEmpId(rs.getString(1));
						holiday.setEmpName(rs.getString(2));
						holiday.setHolidayDate(rs.getString(3));
						holiday.setHolidayName(rs.getString(4));
						holidayList.add(holiday);
					}
				}
			session.setAttribute("holidayList", holidayList);
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
		}
	}

	private void OnDutyUpdate(	HttpServletRequest request,
			HttpServletResponse response) 
						throws ServletException, IOException 
						{
		try 
		{
			String staffid = request.getParameter("staffid");
			String fdate = request.getParameter("date");
			String TxtOt = request.getParameter("TxtOt");
			String TxtBatta = request.getParameter("TxtBatta");
			String TxtWashing = request.getParameter("TxtWashing");
			String TxtDes = request.getParameter("TxtDes");
			String sql ="";
			sql ="UPDATE ATT_T_OT SET ";
			sql = sql +" INT_MINS = '"+TxtOt+"' , ";
			sql = sql +" CHR_BATTA = '"+TxtBatta+"' , ";
			sql = sql +" CHR_WASHING = '"+TxtWashing+"' , ";
			sql = sql +" CHR_DIS = '"+TxtDes+"'  ";
			sql = sql +" WHERE CHR_EMPID = '"+staffid+"'";
			sql = sql +" AND DT_OTDATE = '"+fdate+"'";
			st = con.createStatement();
			st.executeUpdate(sql);
		}
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
		}
						
	}

	
	
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");			
			String act = "" + request.getParameter("Submit");			
			act = act.trim();
			if (action.equals("ATTovertimeAdd"))	
			{
				String staffname[] = request.getParameterValues("ename");
				String fdate = DateUtil.FormateDateSQL(request.getParameter("fromdt"));
				String tdate = DateUtil.FormateDateSQL(request.getParameter("todt"));
				boolean flag=true;
				String msg="";
				for (int i = 0; i < staffname.length; i++)
				{
					
					String sname = staffname[i]; 
					
					String sql = "SELECT CHR_EMPID, DT_OTDATE, INT_MINS from att_t_ot WHERE ";
					sql = sql + "CHR_EMPID ='"+sname+"' ";
					sql = sql + "AND DT_OTDATE >= '"+fdate +"' AND DT_OTDATE <= '"+tdate+"'";
					
					
					String dat[][]=CommonFunctions.QueryExecute(sql);
					String mdat="";
					String hname="";
					
					if (dat.length>0)
					{
						for (int k=0; k<dat.length; k++)
						{
							if (k==0)
							{
								mdat=mdat+dat[k][1];
								hname=hname+dat[k][2];
							}
							else
							{
								mdat=mdat+"/"+dat[k][1];
								hname=hname+"/"+dat[k][2];
							}
						}
						flag=false;
						msg = sname+"&Adate="+mdat+"&Hname="+hname;	
						break;
					}
				}
				
				if (!flag)
				{
					con.close();   
					response.sendRedirect("Smart Attendance/OverTimeAdd.jsp?mess=Already&staffID="+msg);
				}
				else
				{
					OverTimeAdd(request, response);
					con.close();    
					response.sendRedirect("Smart Attendance/OverTime.jsp");
				}
 			}
			else if (action.equals("ATTovertimeUpdate")) 
			{
				OnDutyUpdate(request, response);
				con.close();   
				response.sendRedirect("Smart Attendance/OverTime.jsp");
			}
			else if (action.equals("ATTovertimeDelete")) 
			{
				OverTimeDelete(request, response);
				con.close();   
				response.sendRedirect("Smart Attendance/OverTime.jsp");
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