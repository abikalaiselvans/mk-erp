package com.my.org.erp.SmartAttendance;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

 
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
 
import com.my.org.erp.bean.Attendance.Attinfo; 
 
public class StaffManualAttendanceActionHandler extends AbstractActionHandler 
{
	Statement st;
	ResultSet rs;
	java.text.SimpleDateFormat datetime = new java.text.SimpleDateFormat("yyyy-MM-dd");
	java.util.Date date = new java.util.Date();
	String updatedate = "" + datetime.format(date);
	@SuppressWarnings("deprecation")
	String year = "" + (1900 + date.getYear());
	boolean redirectflag = false;
	String redirecterror="";
	String sql;
	boolean flag = false;
	ArrayList<Attinfo> attinfo = new ArrayList<Attinfo>();
	
	
		private void StaffManualAttendanceUpdate(	HttpServletRequest request,
									HttpServletResponse response) 
												throws ServletException, IOException 
		{
			try 
			{
				String staffid = request.getParameter("staffid");
				String pdate = request.getParameter("Date");
				String l = ""+request.getParameter("Late");
				String intime = ""+request.getParameter("inTime");
				String outime = ""+request.getParameter("outTime");
				String pType=""+request.getParameter("ComboDay");
				String str="SELECT TIMEDIFF('"+outime+"','"+intime+"')";
				String timeDiff[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(str);
				if((l.equals(""))||(l.equals("null")))
					l = null;
				else
					l ="'"+l+"'";
				String totH="0";
				String totM="0";
				if(timeDiff.length>0)
				{
					String tValue[]=timeDiff[0][0].split(":");
					totH=tValue[0];
					totM=tValue[1];					
				}
				 
				String sql ="UPDATE ATT_SMART_ATTENDANCE SET ";
				sql = sql + " CHR_LATE = " +l;
				sql = sql + " , DT_TIMEIN = '" +intime;
				sql = sql + "' , DT_TIMEOUT = '" +outime;
				sql = sql + "' , DT_LOGOUT = '" +pdate;
				sql = sql + "' , CHR_TYPE = '" +pType;
				sql = sql + "' , INT_TOTALHOUR =" +totH;
				sql = sql + " , INT_TOTALMIN = " +totM;
				sql = sql +" WHERE CHR_EMPID = '"+staffid+"'";
				sql = sql +" AND DT_LOGIN = '"+pdate+"'";
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
		
 


public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
{
		try 
		{
			String action = request.getParameter("actionS");
			
			javax.servlet.http.HttpSession session=request.getSession();
			session.removeAttribute("attinfo"); 
			System.out.println("CONTROLLER FROM MANUAL ATTENDANCE ACTION HANDLER  : "+action);
			if ("ATTStaffManualAttendanceAdd".equals(action)  ) 
			{
				 	StaffManualAttendanceAdd(request, response);
					con.close();   
					response.sendRedirect("Smart Attendance/Manual Attendance.jsp");
			}
			else if (action.equals("ATTStaffManualAttendanceUpdate")) //Pending
			{
				StaffManualAttendanceUpdate(request, response);
				con.close();    
				response.sendRedirect("Smart Attendance/Manual Attendance.jsp");
			}
			else if (action.equals("ATTStaffManualAttendanceDeletes")) 
			{
				StaffManualAttendanceDeletes(request, response);
				con.close();   
				response.sendRedirect("Smart Attendance/Manual Attendance.jsp");
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











private synchronized void StaffManualAttendanceAdd(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException 
{
	try 
	{
			
			HttpSession session =  request.getSession();
			String userId = (String) session.getAttribute("USRID");
			String staffids[] = request.getParameterValues("ename");
			String fdate = ""+request.getParameter("fromdt");
			String dat[] = fdate.split("-");
			String day = ""+Integer.parseInt(dat[0]);
			String umonth=DateUtil.getMonth(Integer.parseInt(dat[1]));
			String uyear = dat[2];
			fdate =DateUtil.FormateDateSQL(fdate);
		  
			String ftime = ""+request.getParameter("int");
			String ttime =""+request.getParameter("out");
			String late = ""+request.getParameter("ChkLate");
			String type =""+request.getParameter("ComboDay");
			String inserttype="";
			String shiftcode="";
			String presentType = "Manual";				
			 
		
			if("null".equals(ttime.trim()) || "".equals(ttime.trim()))
				ttime ="18:30:00";
			String f[] = ftime.split(":");
			String t[] = ttime.split(":");
			int hours =Integer.parseInt(t[0]) - Integer.parseInt(f[0]);
			int m1 =Integer.parseInt(f[1]);
			int m2 =Integer.parseInt(t[1]);
			int m=0;
			int big =m1;
			if (big <= m2) 
				m = m2-big;
			else
				m = big-m2;
			 
			 
			 
		
			
			String updatequery="UPDATE att_t_register SET CHR_USRNAME='"+userId+"',DAT_MODIFIEDDATE=NOW(),";
			String  updatequery1= " ";
			String daytype="";
			double dayvalue=0.0;
			 
			if("null".equals(late) || "".equals(late))
			{
				inserttype =type;
				if("P".equals(type))
				{
					daytype="Full Day";
					dayvalue=1.0;
					updatequery=updatequery+" CHR_MORNING"+day+" = 'PRE' , ";
					updatequery=updatequery+" CHR_EVENING"+day+" = 'PRE', ";
					updatequery1 = updatequery1 + " AND CHR_MORNING"+day+"   NOT IN ('LEA','HOL','ABS') ";
					updatequery1 = updatequery1 + " AND CHR_EVENING"+day+"   NOT IN ('LEA','HOL','ABS') "; 
				}
				else if("F".equals(type))
				{	
					daytype="Forenoon";
					dayvalue=0.5;
					updatequery=updatequery+" CHR_MORNING"+day+" = 'PRE' , ";
					updatequery1 = updatequery1 + " AND CHR_MORNING"+day+"   NOT IN ('LEA','HOL','ABS') ";
					 
				}	
				else if("A".equals(type))
				{	
					daytype="Afternoon";
					dayvalue=0.5;
					updatequery=updatequery+" CHR_EVENING"+day+" = 'PRE' , ";
					updatequery1 = updatequery1 + " AND CHR_EVENING"+day+"   NOT IN ('LEA','HOL','ABS') "; 
					 
				}	
			}
			else
			{	
				inserttype="L";
				daytype="Full Day";
				dayvalue=1.0;
				updatequery=updatequery+" CHR_MORNING"+day+" = 'LAT' , ";
				updatequery1 = updatequery1 + " AND CHR_MORNING"+day+"   NOT IN ('LEA','HOL','ABS') ";
				 
			}
			
			updatequery=updatequery.trim();
			updatequery = updatequery.substring(0,updatequery.length()-1);
			String ssql=updatequery+" WHERE CHR_EMPID=? AND CHR_MONTH=? AND INT_YEAR=? "+updatequery1;
			System.out.println(ssql);
			PreparedStatement pstm = con.prepareStatement(ssql);
 
			CallableStatement cs = con.prepareCall("{call ATT_PRO_MANUALATTENDANCE(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			for (int i = 0; i < staffids.length; i++) 
			{
				 	pstm.setString(1, staffids[i].trim());
					pstm.setString(2, umonth);
					pstm.setString(3, uyear);
					pstm.addBatch();
					
					cs.setString(1, "INSERT");
					cs.setString(2,  null);//
					cs.setString(3,  staffids[i].trim());//empid
					cs.setString(4, ftime );//timein
					cs.setString(5, ttime );//timeout
					cs.setString(6,  null);//lunchout
					cs.setString(7, null );//lunchin
					cs.setString(8,  fdate);//login
					cs.setString(9,  fdate);// logout
					cs.setString(10,  ""+hours);//thours
					cs.setString(11,  ""+m);//tminutes
					cs.setString(12,  umonth);//lmonth
					cs.setString(13,  year);//lyear
					cs.setString(14,  shiftcode);//shiftcode
					cs.setString(15,  presentType);//pretypesent
					cs.setString(16,  null);//late
					cs.setString(17,  inserttype);//atype
					cs.setString(18,  daytype);//daytype
					cs.setString(19,  ""+dayvalue);//dayvalue
					cs.setString(20,  userId);//userid
					cs.addBatch();
			}
			pstm.executeBatch(); 
			cs.executeBatch();
			pstm.close();
			cs.close();
			
			
			 
			 
			
		}
	catch (Exception e) 
	{
		System.out.println(e.getMessage());
		request.setAttribute("error", e.getMessage() );
        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    	dispatchers.forward(request, response); 

	}	
	}













private void StaffManualAttendanceDeletes(	HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
{
	try 
	{
		String rowid[] = request.getParameterValues("rowid");
		String  updatequery1 ="";
		String updatequery="  ";
		CallableStatement cs = con.prepareCall("{call ATT_PRO_MANUALATTENDANCE(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		st = con.createStatement();
		for(int u=0; u<rowid.length;u++)
		{
			updatequery1 ="";
			 sql ="SELECT CHR_EMPID,CHR_LOGMONTH,INT_LOGYEAR,CHR_DAYTYPE,DAY(DT_LOGIN) FROM att_smart_attendance WHERE INT_ATTENDANCEID="+rowid[u];
			 String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			 updatequery=" UPDATE att_t_register SET  ";
			 if("Full Day".equals(readData[0][3]))
			 {
			 	updatequery=updatequery+" CHR_MORNING"+readData[0][4]+" = null ,  CHR_EVENING"+readData[0][4]+" = null, ";
			 	updatequery1 = updatequery1 + " AND CHR_MORNING"+readData[0][4]+" NOT IN ('LEA','HOL','ABS') AND CHR_EVENING"+readData[0][4]+"  NOT IN ('LEA','HOL','ABS')";
				
			 }	
			 else if("Forenoon".equals(readData[0][3]))
			 {
				updatequery=updatequery+" CHR_MORNING"+readData[0][4]+" = null , ";
				updatequery1 = updatequery1 + " AND CHR_MORNING"+readData[0][4]+" NOT IN ('LEA','HOL','ABS') ";
			 }
			 else if("Afternoon".equals(readData[0][3]))
			 {
				updatequery=updatequery+" CHR_EVENING"+readData[0][4]+" = null , ";
				updatequery1 = updatequery1 + "  AND CHR_EVENING"+readData[0][4]+"  NOT IN ('LEA','HOL','ABS')";
			 }
			 updatequery=updatequery.trim();
			 updatequery = updatequery.substring(0,updatequery.length()-1);
			 updatequery = updatequery+" WHERE CHR_EMPID='"+readData[0][0]+"' AND CHR_MONTH='"+readData[0][1]+"' AND INT_YEAR="+readData[0][2]+updatequery1;
			 System.out.println(updatequery);
			 st.executeUpdate(updatequery);
			 
			 cs.setString(1, "DELETE");
			 cs.setString(2, rowid[u]);
			 cs.setString(3, null);
			 cs.setString(4, null);
			 cs.setString(5, null);
			 cs.setString(6, null );
			 cs.setString(7, null);
			 cs.setString(8, null);
			 cs.setString(9, null);
			 cs.setString(10, null);
			 cs.setString(11, null);
			 cs.setString(12, null);
			 cs.setString(13, null);
			 cs.setString(14, null);
			 cs.setString(15, null);
			 cs.setString(16,  null );
			 cs.setString(17, null);
			 cs.setString(18, null);
			 cs.setString(19, null);
			 cs.setString(20, null);
			 cs.addBatch(); 
			
		}
		cs.executeBatch();
		st.close();
		cs.close();
		 
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
