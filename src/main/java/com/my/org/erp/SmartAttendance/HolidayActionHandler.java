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

public class HolidayActionHandler extends AbstractActionHandler 
{
	 
 	
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			javax.servlet.http.HttpSession session=request.getSession();
			session.removeAttribute("attinfo");
			
			System.out.println("CONTROLLER FROM HOLIDAY ACTION HANDLER  : "+action);
			if ( "ATTholidayAdd".equals(action) )
			{
				HolidayAdd(request, response);
				con.close();    
				response.sendRedirect("Smart Attendance/Holiday.jsp");	
			} 
			else if ( "ATTholidayUpdate".equals(action) )
			{
				 
				HolidayUpdate(request, response);
				con.close();    
				response.sendRedirect("Smart Attendance/Holiday.jsp");
			}
			else if (action.equals("ATTHolidayDelete")) 
			{
				HolidayDelete(request, response);
				con.close();    
				response.sendRedirect("Smart Attendance/Holiday.jsp");
			}
			else if (action.equals("ATTCommonHolidayAdd")) 
			{
				String date=""+request.getParameter("fromdt");
				String holiname=""+request.getParameter("holiname");
				date = DateUtil.FormateDateSQL(date);
				//String ds[]=date.split("-");
				//int day=Integer.parseInt(ds[2]);
				 
				
				asql =" DELETE FROM  att_t_commonholiday WHERE DT_HOLIDATE=?";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,date);
				System.out.println(""+apstm);
				apstm.execute();
				apstm.close();
				
				
				asql =" INSERT INTO att_t_commonholiday (DT_HOLIDATE,CHR_MONTH,INT_YEAR,CHR_HOLIDESC,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS) ";
				asql = asql+" VALUES ( ";
				asql = asql+"?,";
				asql = asql+"  MONTHNAME('"+date+"') ,";
				asql = asql+"  YEAR('"+date+"') ,";
				asql = asql+"?,";
				asql = asql+"?,now(),'Y' )";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,date);
				apstm.setString(2,holiname);
				apstm.setString(3,auserid);
				System.out.println(""+apstm);
				apstm.execute();
				apstm.close();
				
				/*
				asql="UPDATE att_t_register a,com_m_staff b SET a.CHR_MORNING"+day+"='HOL' ,";
				asql=asql+ " a.CHR_EVENING"+day+" ='HOL' ";
				asql = asql+" WHERE a.CHR_EMPID = b.CHR_EMPID AND b.DT_DOJCOLLEGE <= '"+date+"' "; 
				asql = asql+" AND a.CHR_MONTH =( SELECT monthname('"+date+"') )  AND ";
				asql = asql+" a.INT_YEAR = ( SELECT year('"+date+"'))  ";
				apstm = con.prepareStatement(asql);
				System.out.println(""+apstm);
				apstm.execute();
				apstm.close();
				*/
				con.close();   
				response.sendRedirect("Smart Attendance/CommonHoliday.jsp");
				
			}
			else if (action.equals("ATTCommonHolidayUpdate")) 
			{
				String date=""+request.getParameter("fromdt");
				String holiname=""+request.getParameter("holiname");
				String holidayid = request.getParameter("holidayid");
				date = DateUtil.FormateDateSQL(date);
				/*
				Statement st = con.createStatement();
				String sql =" UPDATE att_t_commonholiday SET ";
				sql = sql + " DT_HOLIDATE='"+date+"' , CHR_MONTH =( SELECT monthname('"+date+"') ) , ";
				sql = sql + " INT_YEAR = ( SELECT year('"+date+"')) , ";
				sql = sql + " CHR_HOLIDESC='"+holiname+"', ";
				sql = sql+"CHR_USRNAME='ADMIN',DT_UPDATEDATE=now(), CHR_UPDATESTATUS='Y' WHERE INT_ID="+holidayid;
				st.execute(sql);
				st.close();
				*/
				asql = "UPDATE att_t_commonholiday SET ";
				asql = asql +" CHR_HOLIDESC=?, CHR_USRNAME=?,DT_UPDATEDATE=now(), CHR_UPDATESTATUS='Y' WHERE INT_ID=?" ;
				apstm = con.prepareStatement(asql);
				apstm.setString(1,holiname);
				apstm.setString(2,auserid);
				apstm.setString(3,holidayid);
				System.out.println(""+apstm);
				apstm.execute();
				apstm.close();
				
				con.close();   
				response.sendRedirect("Smart Attendance/CommonHoliday.jsp");
				
			}
			else if (action.equals("ATTCommonHolidayDelete")) 
			{
				
				String ids[] = request.getParameterValues("holiday");
				asql = " DELETE FROM  att_t_commonholiday WHERE CHR_STATUS='N' AND INT_ID=?";
				apstm = con.prepareStatement(asql);
				for(int u=0;u<ids.length;u++)
				{	
					apstm.setString(1, ids[u]);
					apstm.addBatch();
				}	
				//apstm.executeBatch();
				apstm.close();
				con.close();   
				response.sendRedirect("Smart Attendance/CommonHoliday.jsp");
				
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
	
	
	private void HolidayDelete(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String ids[] = request.getParameterValues("holiday");
			acs = con.prepareCall("{call ATT_PRO_HOLIDAY(?,?,?,?,?,?)}");
			for (int i = 0; i < ids.length; i++) 
			{
				asql = " SELECT a.INT_HOLIDAYID ,a.CHR_EMPID,b.CHR_STAFFNAME," +
						"c.CHR_OFFICENAME,DATE_FORMAT(a.DT_HOLIDATE,'%d-%m-%Y'),a.CHR_DESC," +
						"MONTHNAME(a.DT_HOLIDATE),YEAR(a.DT_HOLIDATE) " +
						"FROM att_t_holiday a,com_m_staff b,com_m_office c " +
						"WHERE a.CHR_EMPID= b.CHR_EMPID  AND b.INT_OFFICEID =c.INT_OFFICEID" +
						" and a.INT_HOLIDAYID="+ids[i];
				String readData[][] = CommonFunctions.QueryExecute(asql);
				String date  = DateUtil.FormateDateSQL(readData[0][4]);
				String data[] = date .split("-");
				String day=""+Integer.parseInt(data[2]);
				 asql =" UPDATE att_t_register SET CHR_MORNING"+day+" = null , CHR_EVENING"+day+" = null " +
				"WHERE   CHR_EMPID='"+readData[0][1]+"' AND CHR_MONTH =MONTHNAME('"+date +"')  AND INT_YEAR=year('"+date +"') ";
				apstm = con.prepareStatement(asql);
				apstm.execute();
				
				acs.setString(1, "DELETE");
				acs.setString(2, ids[i]);
				acs.setString(3, "");
				acs.setString(4, "");
				acs.setString(5, "");
				acs.setString(6, "");
				System.out.println(""+acs);
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
	
	
	
	
	private void HolidayUpdate (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		try 
		{
			 
			HttpSession session = request.getSession();
			String userid = (String) session.getAttribute("USRID");
			String rowid = request.getParameter("rowid");
			String fromdt = request.getParameter("fromdt");
			String date1 = DateUtil.FormateDateSQL(fromdt);
			String hdescription = request.getParameter("hdescription");
			String dbdate = request.getParameter("dbdate");
			asql = " SELECT a.INT_HOLIDAYID ,a.CHR_EMPID,b.CHR_STAFFNAME,c.CHR_OFFICENAME,DATE_FORMAT(a.DT_HOLIDATE,'%d-%m-%Y'),a.CHR_DESC,MONTHNAME(a.DT_HOLIDATE),YEAR(a.DT_HOLIDATE) FROM att_t_holiday a,com_m_staff b,com_m_office c WHERE a.CHR_EMPID= b.CHR_EMPID  AND b.INT_OFFICEID =c.INT_OFFICEID and a.INT_HOLIDAYID="+rowid;
			String readData[][] =CommonFunctions.QueryExecute(asql);
			
			
			String sql ="";
			acs = con.prepareCall("{call ATT_PRO_HOLIDAY(?,?,?,?,?,?)}");
			acs.setString(1, "UPDATE");
			acs.setString(2, rowid);
			acs.setString(3, "");
			acs.setString(4, date1);
			acs.setString(5, hdescription);
			acs.setString(6, userid);
			acs.execute();
			
			String date2 = DateUtil.FormateDateSQL(dbdate);
			String data[] = date2.split("-");
			String day=""+Integer.parseInt(data[2]);
			sql =" UPDATE att_t_register SET CHR_MORNING"+day+" = null , CHR_EVENING"+day+" = null " +
			"WHERE   CHR_EMPID='"+readData[0][1]+"' AND  CHR_MONTH =MONTHNAME('"+date2+"')  AND INT_YEAR=year('"+date2+"') ";
			apstm = con.prepareStatement(sql);
			System.out.println(""+apstm);
			apstm.execute();
			
			
			 
			String data1[] = date1.split("-");
			String day1=""+Integer.parseInt(data1[2]);
			sql =" UPDATE att_t_register SET CHR_MORNING"+day1+" = 'HOL' , CHR_EVENING"+day1+" = 'HOL' " +
			"WHERE   CHR_EMPID='"+readData[0][1]+"' AND  CHR_MONTH =MONTHNAME('"+date1+"')  AND INT_YEAR=year('"+date1+"') ";
			apstm = con.prepareStatement(sql);
			apstm.execute();
			apstm.close();
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



 

	
	
	private void HolidayAdd(HttpServletRequest request,	HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
				HttpSession session = request.getSession();
				String userid = (String) session.getAttribute("USRID");
				String staffids[] = request.getParameterValues("ename");
				String description = request.getParameter("hdescription");
				String fdate = request.getParameter("fromdt");
				String tdate = request.getParameter("todt");
				String date1 = DateUtil.FormateDateSQL(fdate);
				@SuppressWarnings("unused")
				String date2 = DateUtil.FormateDateSQL(tdate);
				String data[] = date1.split("-");
				String day=""+Integer.parseInt(data[2]);
				String umonth=DateUtil.getMonth(Integer.parseInt(data[1]));
				String year = data[0];
				String registerquery="SELECT  CHR_MORNING"+day   +" , CHR_EVENING"+day+ "  FROM att_t_register  WHERE CHR_MONTH='"+umonth+"' AND INT_YEAR="+year;
				String  updatequery1= " SElECT COUNT(*)  FROM att_t_register  WHERE CHR_MONTH='"+umonth+"' AND INT_YEAR="+year;
				updatequery1 =updatequery1 + " AND CHR_MORNING"+day+" !='0'  AND CHR_EVENING"+day+" !='0'" ;
				
			 
				
				
				String sql =" UPDATE att_t_register SET CHR_MORNING"+day+" = 'HOL' , CHR_EVENING"+day+" = 'HOL' " +
				"WHERE CHR_EMPID=?  AND CHR_MONTH =monthname('"+date1+"')  AND INT_YEAR=year('"+date1+"') ";
				apstm = con.prepareStatement(sql);
				acs = con.prepareCall("{call ATT_PRO_HOLIDAY(?,?,?,?,?,?)}");
				for (int i = 0; i < staffids.length; i++) 
				{
					
					asql = " SELECT COUNT(*) FROM att_t_holiday WHERE CHR_EMPID='"+staffids[i].trim()+"' AND   DT_HOLIDATE='"+fdate+"'";
					updatequery1 = updatequery1+"  AND CHR_EMPID='"+staffids[i].trim()+"' ";
					registerquery=registerquery+"  AND CHR_EMPID='"+staffids[i].trim()+"' ";
					acs.setString(1, "INSERT");
					acs.setString(2, "");
					acs.setString(3, staffids[i]);
					acs.setString(4, date1);
					acs.setString(5, description);
					acs.setString(6, userid);
					acs.addBatch();
						
					apstm.setString(1, staffids[i]);
					apstm.addBatch();
				}
				acs.executeBatch();
				apstm.executeBatch();
				apstm.close();
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

	
	
	 
	
}