package com.my.org.erp.SmartAttendance;

import java.io.IOException;
 
  
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
 

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;
 
public class AttendanceCalculateActionHandler extends AbstractActionHandler 
{
	Statement st;
	public synchronized void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			
			
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String userid = (String) session.getAttribute("USRID");
			 
			if (action.equals("ATTAttendanceCalculate"))
			{ 
				
				String month =""+request.getParameter("month");
				String year = ""+request.getParameter("year");
				String Office = ""+request.getParameter("Office");
				String dept = ""+request.getParameter("dept");
				String Category=request.getParameter("Category");
				String umonth=DateUtil.getMonth(Integer.parseInt(month));
				System.out.println("SmartLoginAuth from Attendance calculate start");
				System.out.println("Common Holiday Assing");
				asql = "SELECT DAY(DT_HOLIDATE) FROM att_t_commonholiday WHERE CHR_MONTH = '"+umonth+"' AND INT_YEAR ="+year;
				String data[][] = CommonFunctions.QueryExecute(asql);
				if(data.length>0)
				{
					for(int u=0;u<data.length;u++)
					{
						asql="UPDATE att_t_register SET CHR_MORNING"+data[0][0]+"='HOL' ,";
						asql=asql+ " CHR_EVENING"+data[0][0]+" ='HOL' ";
						asql = asql+" WHERE CHR_MONTH ='"+umonth+"'  AND ";
						asql = asql+" INT_YEAR =  "+year+"   ";
						apstm = con.prepareStatement(asql);
						System.out.println(""+apstm);
						apstm.execute();
						apstm.close();
					}
				}
				
				
				/*
				System.out.println("New Joinner");
				AttendanceFunctions.AttAssignNewJoiner(acs,apstm,con, umonth, year);
				System.out.println("Resignner");
				AttendanceFunctions.AttAssignResignner(apstm,con, umonth, year);
				System.out.println("Duplicate");
				AttendanceFunctions.AvoidAttendanceGenerateDuplicate(apstm,con, umonth, year);
				System.out.println("SmartLoginAuth from Attendance calculate end");
				
				
				
			
				 
				CommonFunctions.AttAssignNewJoiner(request,umonth, year,Office,Category,dept);
				Thread.sleep( 5000 );
				CommonFunctions.AttAssignResignner(request,umonth, year,Office,Category,dept);
				Thread.sleep( 5000 );
				CommonFunctions.AvoidAttendanceGenerateDuplicate(request,Office,dept);
				Thread.sleep( 5000 );
				
				com.my.org.erp.common.CommonFunctions.AttAssignNewJoiner(request,umonth, year,Office,Category,dept);
				Thread.sleep( 5000 );
				com.my.org.erp.common.CommonFunctions.AttAssignResignner(request,umonth, year,Office,Category,dept);
				Thread.sleep( 5000 );
				com.my.org.erp.common.CommonFunctions.AvoidAttendanceGenerateDuplicate(request,Office,dept);
				Thread.sleep( 5000 );*/
				
				con.close();   
				response.sendRedirect("Smart Attendance/MunsterrollResponse.jsp?month="+month+"&year="+year+"&Office="+Office+"&dept="+dept+"&Category="+Category);
			}
			else if ("ATTAttendanceReset".equals(action))
			{
				String month= request.getParameter("month");
				String year= request.getParameter("year");
				String empid= request.getParameter("empid");
				String monthname = DateUtil.getMonth(Integer.parseInt(month));
				String d="";
				int totaldays = Integer.parseInt(com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT DAY(LAST_DAY('"+year+"-"+month+"-01'))")[0][0]);
				String sql ="";
				sql =" UPDATE att_t_register   SET ";
				 
				for(int day=1;day<=totaldays;day++)
				{	
					if(day<10)
						d="0"+day;
					else
						d=""+day;
					
					if("Sunday".equals( CommonFunctions.QueryExecute(" SELECT DAYNAME('"+year+"-"+month+"-"+d+"') ")[0][0]))
					{
						sql=sql+"CHR_MORNING"+day+"='SUN' , CHR_EVENING"+day+"='SUN' ,";
					}
					else
					{
						String mdata[][] = CommonFunctions.QueryExecute("SELECT CHR_MORNING"+day+"   FROM att_t_register WHERE  CHR_EMPID='"+empid+"' AND  CHR_MONTH='"+monthname+"' AND  INT_YEAR="+year);
						String edata[][] = CommonFunctions.QueryExecute("SELECT CHR_MORNING"+day+"   FROM att_t_register WHERE  CHR_EMPID='"+empid+"' AND  CHR_MONTH='"+monthname+"' AND  INT_YEAR="+year);
						if( !  ("LEA".equals(mdata[0][0])|| "OND".equals(mdata[0][0] ) || "LAT".equals(mdata[0][0] ) || "PER".equals(mdata[0][0] ) || "ABS".equals(mdata[0][0] ) || "HOL".equals(mdata[0][0]) )  )  
							sql=sql+"CHR_MORNING"+day+"=null , ";
						if( !  ("LEA".equals(edata[0][0])|| "OND".equals(edata[0][0] ) || "LAT".equals(edata[0][0] ) || "PER".equals(edata[0][0] ) || "ABS".equals(edata[0][0] ) || "HOL".equals(edata[0][0]) )  )  
								sql=sql+" CHR_EVENING"+day+"=null ,";
					}
					 
					 
				}
				
				sql = sql+" CHR_UPDATESTATUS='Y' , DAT_EMPTY  =NOW(),";
				sql=sql.trim();
				sql = sql.substring(0,sql.length()-1);
				sql = sql +" WHERE  CHR_EMPID='"+empid+"' AND  CHR_MONTH='"+monthname+"' AND  INT_YEAR="+year;
				CommonFunctions.Execute(sql);
				CommonFunctions.Execute("DELETE FROM  att_smart_attendance    WHERE  CHR_EMPID='"+empid+"' AND  MONTHNAME(DT_LOGIN)='"+monthname+"' AND  YEAR(DT_LOGIN)="+year);
				CommonFunctions.Execute("DELETE FROM  att_t_onduty    WHERE  CHR_EMPID='"+empid+"' AND  MONTHNAME(DT_ODDATE)='"+monthname+"' AND  YEAR(DT_ODDATE)="+year);
				CommonFunctions.Execute("DELETE FROM  att_t_continuousentry    WHERE  CHR_EMPID='"+empid+"' AND  MONTHNAME(DT_CONTINUOUSDATE)='"+monthname+"' AND  YEAR(DT_CONTINUOUSDATE)="+year);
				CommonFunctions.Execute("DELETE FROM  att_t_permission    WHERE  CHR_EMPID='"+empid+"' AND  MONTHNAME(DT_PDATE)='"+monthname+"' AND  YEAR(DT_PDATE)="+year);
				con.close();   
				response.sendRedirect("RefreshExit.jsp");
				
			
			}
			else if ("ATTAttendanceResets".equals(action))
			{
				String month= request.getParameter("month");
				String year= request.getParameter("year");
				String staffid[] = request.getParameterValues("ename");
				String monthname = DateUtil.getMonth(Integer.parseInt(month));
				String d="";
				int totaldays = Integer.parseInt(CommonFunctions.QueryExecute("SELECT DAY(LAST_DAY('"+year+"-"+month+"-01'))")[0][0]);
				String sql ="";
				for(int u=0;u<staffid.length;u++)
				{
					String empid= 	 staffid[u];
					sql ="";
					sql =" UPDATE att_t_register   SET ";
					for(int day=1;day<=totaldays;day++)
					{	
						if(day<10)
							d="0"+day;
						else
							d=""+day;
						
						if("Sunday".equals( CommonFunctions.QueryExecute(" SELECT DAYNAME('"+year+"-"+month+"-"+d+"') ")[0][0]))
						{
							sql=sql+"CHR_MORNING"+day+"='SUN' , CHR_EVENING"+day+"='SUN' ,";
						}
						else
						{
							String mdata[][] = CommonFunctions.QueryExecute("SELECT CHR_MORNING"+day+"   FROM att_t_register WHERE  CHR_EMPID='"+empid+"' AND  CHR_MONTH='"+monthname+"' AND  INT_YEAR="+year);
							String edata[][] = CommonFunctions.QueryExecute("SELECT CHR_MORNING"+day+"   FROM att_t_register WHERE  CHR_EMPID='"+empid+"' AND  CHR_MONTH='"+monthname+"' AND  INT_YEAR="+year);
							if( !  ("LEA".equals(mdata[0][0])       )  )  
								sql=sql+"CHR_MORNING"+day+"=null , ";
							if( !  ("LEA".equals(edata[0][0]) )  )  
									sql=sql+" CHR_EVENING"+day+"=null ,";
							
							 	
						}
						 
					}
					sql = sql+" CHR_UPDATESTATUS='Y' , DAT_EMPTY  =NOW(),";
					sql=sql.trim();
					sql = sql.substring(0,sql.length()-1);
					sql = sql +" WHERE  CHR_EMPID='"+empid+"' AND  CHR_MONTH='"+monthname+"' AND  INT_YEAR="+year;
					CommonFunctions.Execute(sql);
					CommonFunctions.Execute("DELETE FROM  att_smart_attendance    WHERE  CHR_EMPID='"+empid+"' AND  MONTHNAME(DT_LOGIN)='"+monthname+"' AND  YEAR(DT_LOGIN)="+year);
					CommonFunctions.Execute("DELETE FROM  att_t_onduty    WHERE  CHR_EMPID='"+empid+"' AND  MONTHNAME(DT_ODDATE)='"+monthname+"' AND  YEAR(DT_ODDATE)="+year);
					CommonFunctions.Execute("DELETE FROM  att_t_continuousentry    WHERE  CHR_EMPID='"+empid+"' AND  MONTHNAME(DT_CONTINUOUSDATE)='"+monthname+"' AND  YEAR(DT_CONTINUOUSDATE)="+year);
					CommonFunctions.Execute("DELETE FROM  att_t_permission    WHERE  CHR_EMPID='"+empid+"' AND  MONTHNAME(DT_PDATE)='"+monthname+"' AND  YEAR(DT_PDATE)="+year);
				}
				con.close();   
				response.sendRedirect("Smart Attendance/AttendanceMain.jsp");
				
			
			}
			else if("ATTAttendanceCalculateCycle2".equals(action))
			{
				String month =""+request.getParameter("month");
				String year = ""+request.getParameter("year");
				String Office = ""+request.getParameter("office");
				String dept = ""+request.getParameter("dept");
				String Category=request.getParameter("category");
				String fromdt = "20-"+month+"-"+year;
				String fromdtsql = DateUtil.FormateDateSQL(fromdt);
				String todt = CommonFunctions.QueryExecute("SELECT DATE_FORMAT(DATE_SUB(DATE_ADD('"+fromdtsql+"', INTERVAL 1 MONTH), INTERVAL 1 DAY),'%d-%m-%Y')")[0][0];
				String todtsql = DateUtil.FormateDateSQL(todt);
				int fromdtend = Integer.parseInt(CommonFunctions.QueryExecute("SELECT DAY(LAST_DAY('"+fromdtsql+"'))")[0][0]);
				String sql="";
				String hs="";
				String ssql="";
				String hhs="";
				
				//Employee id inserted into att_t_registerCycle2 table
				acs = con.prepareCall("{call ATT_PRO_REGISTER_CREATION_CYCLE2(?,?,?)}");
				acs.setString(1,fromdtsql);
				acs.setString(2,todtsql);
				acs.setString(3,userid);
				acs.execute();
				acs.close();
				
				 
				ssql="";
				String data[][] =CommonFunctions.QueryExecute("SELECT CHR_EMPID FROM att_t_register_cycle2 WHERE CHR_MONTH =MONTHNAME('"+todtsql+"')  AND INT_YEAR = YEAR('"+todtsql+"') "); 
				if(data.length>0)
				{
					for(int y=0;y<data.length;y++)
					{
						ssql = "UPDATE att_t_register_cycle2 SET ";
						
						
						//update the 20th to 31st date attendance...
						hs="";
						for(int x=20;x<=fromdtend;x++) 
							hs = hs+" CHR_MORNING"+x+","+" CHR_EVENING"+x+",";
						hs = hs.trim();
						hs = hs.substring(0,hs.length()-1);	
						sql = " SELECT  "+hs +" FROM att_t_register WHERE CHR_EMPID='"+data[y][0]+"' AND  CHR_MONTH =MONTHNAME('"+fromdtsql+"')  AND INT_YEAR = YEAR('"+fromdtsql+"') ";
						String fromdtdata[][] =CommonFunctions.QueryExecute(sql);
						hs="";
						if(fromdtdata.length>0)
						{
							int i=0;
							hs="";
							for(int x=20;x<=fromdtend;x++) 
							{
								hs = hs+" CHR_MORNING"+x+"='"+fromdtdata[0][i]+"',";
								i=i+1;
								hs = hs+"  CHR_EVENING"+x+"='"+fromdtdata[0][i]+"' ,";
								i=i+1;
							}
							hs = hs.trim();
							hs = hs.substring(0,hs.length()-1);	
							
							
						}
						ssql = ssql+hs+",";

						
						//update the 1st to 19th date attendance...
						hs="";
						for(int x=1;x<=19;x++) 
							hs = hs+" CHR_MORNING"+x+","+" CHR_EVENING"+x+",";
						hs = hs.trim();
						hs = hs.substring(0,hs.length()-1);	
						sql = " SELECT  "+hs +" FROM att_t_register WHERE CHR_EMPID='"+data[y][0]+"' AND  CHR_MONTH =MONTHNAME('"+todtsql+"')  AND INT_YEAR = YEAR('"+todtsql+"') ";
						String todtdata[][] =CommonFunctions.QueryExecute(sql);
						hhs="";
						if(todtdata.length>0)
						{
							int i=0;
							hhs="";
							for(int x=1;x<=19;x++) 
							{
								hhs = hhs+" CHR_MORNING"+x+"='"+todtdata[0][i]+"',";
								i=i+1;
								hhs = hhs+"  CHR_EVENING"+x+"='"+todtdata[0][i]+"' ,";
								i=i+1;
							}
							hhs = hhs.trim();
							hhs = hhs.substring(0,hhs.length()-1);	
							
						}
						
						 
						ssql = ssql+hhs +" WHERE CHR_EMPID='"+data[y][0]+"' AND CHR_MONTH=MONTHNAME('"+todtsql+"')  AND INT_YEAR=YEAR('"+todtsql+"')";
						
						
						apstm=con.prepareStatement(ssql);
						System.out.println(""+apstm);
						apstm.execute();
						apstm.close();
						
						
					}
				}
				con.close();   
				response.sendRedirect("Smart Attendance/MunsterrollCycle2Response.jsp?month="+month+"&year="+year+"&office="+Office+"&dept="+dept+"&category="+Category);
				
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