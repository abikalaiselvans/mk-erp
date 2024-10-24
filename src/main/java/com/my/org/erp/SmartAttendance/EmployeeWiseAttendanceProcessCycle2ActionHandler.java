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
public class EmployeeWiseAttendanceProcessCycle2ActionHandler extends AbstractActionHandler 
{
	Statement st;
	public synchronized void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String userid = (String) session.getAttribute("USRID");
			if (action.equals("ATTEmployeeWiseAttendanceProcess"))
			{
				String cycledt[][] = CommonFunctions.QueryExecute("SELECT INT_FROM, INT_TO  FROM  att_m_basicsettings WHERE INT_ID=1 ");
				int cycle2_fromdt =Integer.parseInt(cycledt[0][0]); //20
				int cycle2_todt =Integer.parseInt(cycledt[0][1]);//19

				
				
				String month=request.getParameter("month");
				String year=request.getParameter("year");
				String ename = ""+request.getParameter("ename");
				String registercheck=request.getParameter("registercheck");
				
				String fromdt = cycle2_fromdt+"-"+month+"-"+year;//20
				String fromdtsql = DateUtil.FormateDateSQL(fromdt);
				String todt = CommonFunctions.QueryExecute("SELECT DATE_FORMAT(DATE_SUB(DATE_ADD('"+fromdtsql+"', INTERVAL 1 MONTH), INTERVAL 1 DAY),'%d-%m-%Y')")[0][0];
				String todtsql = DateUtil.FormateDateSQL(todt);
				int fromdtend = Integer.parseInt(CommonFunctions.QueryExecute("SELECT DAY(LAST_DAY('"+fromdtsql+"'))")[0][0]);
				String monthname=CommonFunctions.QueryExecute("SELECT MONTHNAME('"+todtsql+"')")[0][0];
				String sql=" ";
				
				
				
				/*
				 * Start the blank check
				 * Here the Attendance register checking  for blank or not 
				 */
				sql = "SELECT a.CHR_EMPID,a.CHR_FLAG FROM att_t_register_cycle2 a ,com_m_staff b WHERE a.CHR_EMPID =b.CHR_EMPID ";
				sql = sql +" AND a.CHR_FLAG='N'  AND b.INT_ATTENDANCECYCLE =2 ";
				sql = sql + " AND a.CHR_EMPID='"+ename+"'"; 
				sql = sql + " AND a.CHR_MONTH='"+monthname+"'"; 
				sql = sql + " AND a.INT_YEAR= "+year+ " ORDER BY  a.CHR_EMPID ";
				System.out.println(sql);
				String cdata[][] = CommonFunctions.QueryExecutecon(con, sql);

				
				boolean incomplete=true;
				String inempid="";
				if(cdata.length>0)
				{
					for(int u=0;u<cdata.length;u++)
					{
						sql=" SELECT ( ";
						for(int x=cycle2_fromdt;x<=fromdtend;x++)//20
							sql = sql+" (CHR_MORNING"+x+"='0') OR (CHR_EVENING"+x+"='0') OR ";
						for(int x=1;x<=cycle2_todt;x++) //19
							sql = sql+" (CHR_MORNING"+x+"='0') OR (CHR_EVENING"+x+"='0') OR ";
						sql=sql.trim();
						sql = sql.substring(0,sql.length()-2);	
						sql=sql+" ) ";
						sql = sql+" FROM att_t_register_cycle2 WHERE CHR_EMPID='"+cdata[u][0]+"' AND CHR_MONTH='"+monthname+"' AND INT_YEAR="+year;
						//System.out.println(sql);
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
				/*
				 * End the blank check
				 * Here the Attendance register checking  for blank or not 
				 */
				
				
				sql = "SELECT COUNT(*) FROM att_t_register_cycle2 a ,com_m_staff b WHERE a.CHR_EMPID =b.CHR_EMPID";
				sql = sql + " AND a.CHR_FLAG='N' AND b.INT_ATTENDANCECYCLE =2 ";
				sql = sql + " AND a.CHR_EMPID='"+ename+"'"; 
				sql = sql + " AND a.CHR_MONTH='"+monthname+"'"; 
				sql = sql + " AND a.INT_YEAR= "+year+ " ORDER BY  a.CHR_EMPID ";
				System.out.println(sql); 
				boolean flag =CommonFunctions.RecordExist(con, sql);
				
				//check the attendance register is fully mark or incomplete
				if(cdata.length>0)
				{
					if(incomplete)
					{
						if( flag)
						{
							sql = "SELECT a.CHR_EMPID,a.CHR_FLAG FROM att_t_register_cycle2 a ,com_m_staff b ";
							sql = sql + " WHERE a.CHR_EMPID =b.CHR_EMPID AND a.CHR_FLAG='N'  AND b.INT_ATTENDANCECYCLE =2 ";
							sql = sql + " AND a.CHR_EMPID='"+ename+"'"; 
							sql = sql + " AND a.CHR_MONTH='"+monthname+"'"; 
							sql = sql + " AND a.INT_YEAR= "+year+ " ORDER BY  a.CHR_EMPID ";
							 
							String data[][] =  CommonFunctions.QueryExecutecon(con, sql);
							
							sql="SELECT INT_PERLIMIT,INT_LATELIMIT FROM att_m_basicsettings WHERE INT_ID=1";
							String basedata[][] =  CommonFunctions.QueryExecutecon(con, sql);
							int latelimit=Integer.parseInt(basedata[0][1]);
							int perlimit=Integer.parseInt(basedata[0][0]);
							String attbasicdata[][]=  CommonFunctions.QueryExecute("SELECT DOU_LOSSOFDAY1,DOU_LOSSOFDAY2 FROM att_m_basicsettings	");
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
								acs = con.prepareCall("{call ATT_PRO_ATTENDANCEPROCESS_CYCLE2(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
								for(int u=0;u<data.length;u++)
								{
									String empid = data[u][0];
									late=0;
									permission=0;
									present=0.0;
									absent=0.0;
									leave=0.0;
									sunday=0.0;
									holiday=0.0;
									onduty=0.0;
									 
									sql=" SELECT ";
									for(int x=cycle2_fromdt;x<=fromdtend;x++)//20 
										sql = sql+" CHR_MORNING"+x+","+"CHR_EVENING"+x+",";
									for(int x=1;x<=cycle2_todt;x++) //19
										sql = sql+" CHR_MORNING"+x+","+" CHR_EVENING"+x+",";
									sql=sql+" DOU_EXTRADAYS ";
									sql = sql+" FROM att_t_register_cycle2 WHERE CHR_EMPID='"+empid+"' AND CHR_MONTH='"+monthname+"' AND INT_YEAR="+year;
									String attData[][] = com.my.org.erp.common.CommonFunctions.QueryExecutecon(con, sql);
									 
									int row=0;
									for(int x=cycle2_fromdt;x<=fromdtend;x++) //20
									{
										if("SUN".equals(attData[0][row]))
											sunday = sunday+0.5;
										else if("HOL".equals(attData[0][row]))
											holiday=holiday+0.5;
										else if("OND".equals(attData[0][row]))	
											onduty=onduty+0.5;
										else if("PRE".equals(attData[0][row]))	
											present=present+0.5; 
										else if("LEA".equals(attData[0][row]))
											leave=leave+0.5;
										else if("ABS".equals(attData[0][row]))	
											absent=absent+0.5;
										else if("NA".equals(attData[0][row]))	
											absent=absent+0.5;
										else if("LAT".equals(attData[0][row]))
											late = late+1;
										else if("PER".equals(attData[0][row]))	
											permission=permission+1;
										else if("0".equals(attData[0][row]))	
											absent=absent+0.5;
										else if("-".equals(attData[0][row]))	
											absent=absent+0.5;
										row= row+1;
										
										
										if("SUN".equals(attData[0][row]))
											sunday = sunday+0.5;
										else if("HOL".equals(attData[0][row]))
											holiday=holiday+0.5;
										else if("OND".equals(attData[0][row]))	
											onduty=onduty+0.5;
										else if("PRE".equals(attData[0][row]))	
											present=present+0.5; 
										else if("LEA".equals(attData[0][row]))
											leave=leave+0.5;
										else if("ABS".equals(attData[0][row]))	
											absent=absent+0.5;
										else if("NA".equals(attData[0][row]))	
											absent=absent+0.5;
										else if("LAT".equals(attData[0][row]))
											late = late+1;
										else if("PER".equals(attData[0][row]))	
											permission=permission+1;
										else if("0".equals(attData[0][row]))	
											absent=absent+0.5;
										else if("-".equals(attData[0][row]))	
											absent=absent+0.5;
										row= row+1;
									}
									
									for(int x=1;x<=cycle2_todt;x++) //19
									{
										if("SUN".equals(attData[0][row]))
											sunday = sunday+0.5;
										else if("HOL".equals(attData[0][row]))
											holiday=holiday+0.5;
										else if("OND".equals(attData[0][row]))	
											onduty=onduty+0.5;
										else if("PRE".equals(attData[0][row]))	
											present=present+0.5; 
										else if("LEA".equals(attData[0][row]))
											leave=leave+0.5;
										else if("ABS".equals(attData[0][row]))	
											absent=absent+0.5;
										else if("NA".equals(attData[0][row]))	
											absent=absent+0.5;
										else if("LAT".equals(attData[0][row]))
											late = late+1;
										else if("PER".equals(attData[0][row]))	
											permission=permission+1;
										else if("0".equals(attData[0][row]))	
											absent=absent+0.5;
										else if("-".equals(attData[0][row]))	
											absent=absent+0.5;
										row= row+1;
										
										if("SUN".equals(attData[0][row]))
											sunday = sunday+0.5;
										else if("HOL".equals(attData[0][row]))
											holiday=holiday+0.5;
										else if("OND".equals(attData[0][row]))	
											onduty=onduty+0.5;
										else if("PRE".equals(attData[0][row]))	
											present=present+0.5; 
										else if("LEA".equals(attData[0][row]))
											leave=leave+0.5;
										else if("ABS".equals(attData[0][row]))	
											absent=absent+0.5;
										else if("NA".equals(attData[0][row]))	
											absent=absent+0.5;
										else if("LAT".equals(attData[0][row]))
											late = late+1;
										else if("PER".equals(attData[0][row]))	
											permission=permission+1;
										else if("0".equals(attData[0][row]))	
											absent=absent+0.5;
										else if("-".equals(attData[0][row]))	
											absent=absent+0.5;
										row= row+1;
									}
									 
									extradays =Double.parseDouble(attData[0][(row)]);//62
									
									String SData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_SALAYCALCULATION FROM  pay_m_basicsettings WHERE INT_ID=1");
									if("MTH".equals(SData[0][0]))
										totaldays= present+sunday+leave+onduty+holiday+(late*0.5)+(permission*0.5);
									else if("CTC".equals(SData[0][0]))
										totaldays= present+sunday+leave+onduty+holiday+(late*0.5)+(permission*0.5);
									else if("WRK".equals(SData[0][0]))
										totaldays= present+sunday+leave+onduty+holiday+(late*0.5)+(permission*0.5);  
									
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
									
									acs.setString(1, "UPDATE");
									acs.setString(2, ""+present);
									acs.setString(3, ""+onduty);
									acs.setString(4, ""+sunday);
									acs.setString(5, ""+holiday);
									acs.setString(6, ""+leave);
									acs.setString(7, ""+absent);
									acs.setString(8, ""+late);
									acs.setString(9, ""+totaldays);
									acs.setString(10, ""+permission);
									acs.setString(11, ""+empid);
									acs.setString(12, ""+monthname);
									acs.setString(13, ""+year);
									acs.setString(14, ""+userid);
									acs.addBatch();
									System.out.println("Attendance Calculate:"+data.length+" / "+u+" / "+empid);
								}
								 
								acs.executeBatch();
								acs.close();
								con.close();    
								response.sendRedirect("Smart Attendance/EmployeeAttendanceProcess_Cycle2.jsp?er="+data.length+" Nos of employee Attendance process done successfully&flag=Y");
																														
						 	}
							else
							{
								con.close();    
								response.sendRedirect("Smart Attendance/EmployeeAttendanceProcess_Cycle2.jsp");
									
							}
						}
						else
						{
							con.close();    
							response.sendRedirect("Smart Attendance/EmployeeAttendanceProcess_Cycle2.jsp?er=Attendance alredy processed...&flag=N");
						}
					}
					else
					{
							con.close();  
							response.sendRedirect("Smart Attendance/EmployeeAttendanceProcess_Cycle2.jsp?er=Process does not complete due to incomplete  employee Attendance - "+inempid);
					}
					
				}
				else
				{
					con.close();  
					response.sendRedirect("Smart Attendance/EmployeeAttendanceProcess_Cycle2.jsp?er=Already processed / Records not found...");
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