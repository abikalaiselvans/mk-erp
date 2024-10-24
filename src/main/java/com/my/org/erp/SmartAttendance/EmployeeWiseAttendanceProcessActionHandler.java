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

public class EmployeeWiseAttendanceProcessActionHandler extends AbstractActionHandler 
{
	Statement st;
	public synchronized void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			if (action.equals("ATTEmployeeWiseAttendanceProcess"))
			{
				String ename = ""+request.getParameter("ename");
				String mont=request.getParameter("month");
				String month=DateUtil.getMonth(Integer.parseInt(mont));
				String year=request.getParameter("year");
				String registercheck = ""+request.getParameter("registercheck");
				String verifydate=year+"-"+mont+"-01";
				int daysInMonth = CommonFunctions.daysInMonth(year+"-"+mont+"-01");
				boolean verificationflag =CommonFunctions.AttendanceProcess(verifydate);
				String sql=" ";
				
				String categorys[]=request.getParameterValues("Category");
				String categoryids="";
				 
				for(int x=0;x<categorys.length;x++)
					categoryids =categoryids+categorys[x] +",";
				
				 
				sql = "SELECT a.CHR_EMPID,a.CHR_FLAG FROM att_t_register a ,com_m_staff b ";
				sql = sql + " WHERE a.CHR_EMPID =b.CHR_EMPID AND a.CHR_FLAG='N'  AND b.INT_ATTENDANCECYCLE =1 ";
				sql = sql + " AND a.CHR_EMPID='"+ename+"'"; 
				sql = sql + " AND a.CHR_MONTH='"+month+"'"; 
				sql = sql + " AND a.INT_YEAR= "+year+ " ORDER BY  a.CHR_EMPID ";
				System.out.println(sql);
				String cdata[][] = CommonFunctions.QueryExecutecon(con, sql);
				
				
					
				//checking the attendance is empty
				boolean incomplete=true;
				String inempid="";
				if(cdata.length>0)
				{
					for(int u=0;u<cdata.length;u++)
					{
					
						sql=" SELECT ( ";
						for(int i=1;i<(daysInMonth+1);i++)
							sql = sql+" (CHR_MORNING"+i+"='0') OR (CHR_EVENING"+i+"='0') OR ";
						sql=sql.trim();
						sql = sql.substring(0,sql.length()-2);	
						sql=sql+" ) ";
						sql = sql+" FROM att_t_register WHERE CHR_EMPID='"+cdata[u][0]+"' AND CHR_MONTH='"+month+"' AND INT_YEAR="+year;
						if("1".equals(CommonFunctions.QueryExecutecon(con, sql)[0][0]))
						{
							incomplete = false;
							inempid=cdata[u][0];
							break;
						}
					}
				}
				
				if(!"Y".equals(registercheck))
					incomplete=true;
				
				
				System.out.println("Attendance Check flag : "+incomplete);
				//check the attendance register is fully mark or incomplete
				if(cdata.length>0)
				{
					if(incomplete )
					{
					 
						 
						sql = "SELECT COUNT(*) FROM att_t_register a ,com_m_staff b WHERE a.CHR_EMPID =b.CHR_EMPID AND a.CHR_FLAG='N'  ";
						sql = sql + " AND b.INT_ATTENDANCECYCLE =1 ";
						sql = sql + " AND a.CHR_EMPID='"+ename+"'"; 
						sql = sql + " AND a.CHR_MONTH='"+month+"'"; 
						sql = sql + " AND a.INT_YEAR= "+year+ " ORDER BY  a.CHR_EMPID ";
						boolean recordexistflag =CommonFunctions.RecordExist(con, sql);
						if(verificationflag && recordexistflag  )
						{
							
							 
							
							sql = "SELECT a.CHR_EMPID,a.CHR_FLAG FROM att_t_register a ,com_m_staff b ";
							sql=sql + " WHERE a.CHR_EMPID =b.CHR_EMPID AND a.CHR_FLAG='N'  AND b.INT_ATTENDANCECYCLE =1 ";
							sql = sql + " AND a.CHR_EMPID='"+ename+"'"; 
							sql = sql + " AND a.CHR_MONTH='"+month+"'"; 
							sql = sql + " AND a.INT_YEAR= "+year+ " ORDER BY  a.CHR_EMPID ";
							String data[][] = CommonFunctions.QueryExecutecon(con, sql);
							
							
							
							sql="SELECT INT_PERLIMIT,INT_LATELIMIT FROM att_m_basicsettings WHERE INT_ID=1";
							String basedata[][] = CommonFunctions.QueryExecutecon(con, sql);
							int latelimit=Integer.parseInt(basedata[0][1]);
							int perlimit=Integer.parseInt(basedata[0][0]);
							String attbasicdata[][]= CommonFunctions.QueryExecutecon(con,"SELECT DOU_LOSSOFDAY1,DOU_LOSSOFDAY2 FROM att_m_basicsettings	");
							double lossofday1=Double.parseDouble(attbasicdata[0][0]);
							double lossofday2=Double.parseDouble(attbasicdata[0][1]);
							
							int late=0;
							int permission=0;
							double present=0.0;
							double absent=0.0;
							double leave=0.0;
							double sunday=0.0;
							double holiday=0.0;
							double onduty=0.0;
							double totaldays=0.0;
							double extradays=0.0;
							
							
							
							if(data.length>0)
							{
								String SData[][] = CommonFunctions.QueryExecutecon(con,"SELECT CHR_SALAYCALCULATION FROM  pay_m_basicsettings WHERE INT_ID=1");
								asql = " UPDATE att_t_register SET  DOU_PRESENT= ?, ";
				                asql = asql + " DOU_ONDUTY=?, DOU_SUNDAY=?, DOU_HOLIDAY=?, ";
				                asql = asql + " DOU_LEAVE=?, DOU_ABSENT=?, 	INT_LATE=?, ";
				                asql = asql + " DOU_TOTALDAYS=?, CHR_FLAG='Y', ";
				                asql = asql + " INT_PERMISSION=? ,DAT_PROCESSDATE=NOW() WHERE  CHR_EMPID=? ";
				                asql = asql + " AND  CHR_MONTH=? AND INT_YEAR=? ";
								apstm = con.prepareStatement(asql);		
								for(int u=0;u<data.length;u++)
								{
									
									System.out.println("Attendance Process : "+u+" / "+data.length+"--->"+data[u][0]);
									late=0;
									permission=0;
									present=0.0;
									absent=0.0;
									leave=0.0;
									sunday=0.0;
									holiday=0.0;
									onduty=0.0;
									sql=" SELECT ";
									for(int i=1;i<(daysInMonth+1);i++)//32
										sql = sql+"CHR_MORNING"+i+","+"CHR_EVENING"+i+",";
									sql=sql+" DOU_EXTRADAYS ";
									sql = sql+" FROM att_t_register WHERE CHR_EMPID='"+data[u][0]+"' AND CHR_MONTH='"+month+"' AND INT_YEAR="+year;
									String attData[][] = CommonFunctions.QueryExecutecon(con, sql);
									for(int i=0;i<(daysInMonth*2);i++)//56/58/60/62
									{
										if("SUN".equals(attData[0][i]))
											sunday = sunday+0.5;
										else if("HOL".equals(attData[0][i]))
											holiday=holiday+0.5;
										else if("OND".equals(attData[0][i]))	
											onduty=onduty+0.5;
										else if("PRE".equals(attData[0][i]))	
											present=present+0.5; 
										else if("LEA".equals(attData[0][i]))
											leave=leave+0.5;
										else if("ABS".equals(attData[0][i]))	
											absent=absent+0.5;
										else if("NA".equals(attData[0][i]))	
											absent=absent+0.5;
										else if("LAT".equals(attData[0][i]))
											late = late+1;
										else if("PER".equals(attData[0][i]))	
											permission=permission+1;
										else if("0".equals(attData[0][i]))	
											absent=absent+0.5;
										else if("-".equals(attData[0][i]))	
											absent=absent+0.5;
											
									}
									extradays =Double.parseDouble(attData[0][(daysInMonth*2)]);//62
									if("MTH".equals(SData[0][0]))
										totaldays= present+sunday+leave+onduty+holiday+(late*0.5)+(permission*0.5);
									else if("CTC".equals(SData[0][0]))
										totaldays= present+sunday+leave+onduty+holiday+(late*0.5)+(permission*0.5);
									else if("WRK".equals(SData[0][0]))
										totaldays= present+leave+onduty+holiday+(late*0.5)+(permission*0.5);  
									
									if(late>=latelimit)
									{
										totaldays=totaldays-(((int)(late/latelimit))*lossofday1);
										absent = absent+(((int)(late/latelimit))*lossofday1);
									}
									
									if(permission>=perlimit)
									{
										totaldays=totaldays-(((int)(permission/perlimit))*lossofday2);
										absent = absent+(((int)(permission/perlimit))*lossofday2);
									}
									
									totaldays=totaldays+extradays;
									
									apstm.setString(1,""+present );
									apstm.setString(2,""+onduty );
									apstm.setString(3,""+sunday );
									apstm.setString(4,""+holiday );
									apstm.setString(5,""+leave );
									apstm.setString(6,""+absent );
									apstm.setString(7,""+late );
									apstm.setString(8,""+totaldays );
									apstm.setString(9,""+permission );
									apstm.setString(10,data[u][0] );
									apstm.setString(11,month );
									apstm.setString(12,year );
									apstm.addBatch();
								}
								apstm.executeBatch();
								apstm.close();
								con.close();   
								response.sendRedirect("Smart Attendance/EmployeeAttendanceProcess_Cycle1.jsp?er="+ename+"  employee Attendance process done successfully&flag=Y&month="+mont+"&year="+year);
						 	}
							else
							{
								con.close();    
								response.sendRedirect("Smart Attendance/EmployeeAttendanceProcess_Cycle1.jsp");
									
							}
						}
						else
						{
							con.close();   
							response.sendRedirect("Smart Attendance/EmployeeAttendanceProcess_Cycle1.jsp?er=Attendance process already done, please reset and process...&flag=N");
						}
						
					}
					else
					{
						con.close();  
						response.sendRedirect("Smart Attendance/EmployeeAttendanceProcess_Cycle1.jsp?er=Process does not complete due to incomplete  employee Attendance - "+inempid);
					}
				}
				else
				{
					con.close();  
					response.sendRedirect("Smart Attendance/EmployeeAttendanceProcess_Cycle1.jsp?er=Already processes / Records not found...");
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
}