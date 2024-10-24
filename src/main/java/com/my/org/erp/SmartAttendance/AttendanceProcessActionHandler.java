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

public class AttendanceProcessActionHandler extends AbstractActionHandler 
{
	Statement st;
	public synchronized void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
 			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String usertype = ""+session.getAttribute("USERTYPE");
			if("ATTAttendanceProcessReset".equals(action))
			{
				String officeid=request.getParameter("Office");
				String Category=request.getParameter("Category");
				String dept = ""+request.getParameter("dept");
				String mont=request.getParameter("month");
				String month=DateUtil.getMonth(Integer.parseInt(mont));
				String year=request.getParameter("year");
				
    		 	String officeids = CommonFunctions.QueryExecute("SELECT a.CHR_OFFICELIST FROM m_user a WHERE a.CHR_USRNAME='"+""+session.getAttribute("USRID")+"' ")[0][0];
    		 	String catids = CommonFunctions.QueryExecute("SELECT a.CHR_GATEGORYLIST FROM m_user a WHERE a.CHR_USRNAME='"+session.getAttribute("USRID")+"' ")[0][0];
    		 	
    		 	asql = " UPDATE    att_t_register a , com_m_staff b  SET a.CHR_FLAG='N',";
    		 	if("F".equals(usertype))
					asql=asql + "  a.CHR_SALARYFLAG ='N' , ";
				asql = asql + " a.DAT_RESET=NOW()    ";
				asql = asql+ " WHERE  b.CHR_EMPID=a.CHR_EMPID  AND b.INT_ATTENDANCECYCLE =1";
				if(!"F".equals(usertype))
					asql=asql + " AND a.CHR_SALARYFLAG ='N' ";
				if(!"0".equals(dept))
					asql=asql + " AND b.INT_DEPARTID="+dept;
				if(!"0".equals(officeid))
					asql=asql + " AND b.INT_OFFICEID="+officeid;
				else
        			asql = asql + " AND b.INT_OFFICEID IN ("+officeids+" )";
				if(!"0".equals(Category))
					asql=asql + " AND b.CHR_CATEGORY="+Category;
				else
        			asql = asql + " AND b.CHR_CATEGORY IN ("+catids+" )";
 				asql = asql + " AND a.CHR_MONTH='"+month+"'"; 
				asql = asql + " AND a.INT_YEAR= "+year+ "   ";
				
				System.out.println("Attendance Reset :"+asql);
				apstm=con.prepareStatement(asql);
				apstm.execute();
				apstm.close();
				
				con.close();   
				response.sendRedirect("Smart Attendance/AttendanceProcessReset.jsp");
			} 
			else if (action.equals("ATTProcess"))
			{
				
				String officeid=request.getParameter("Office");
				String Category=request.getParameter("Category");
				String dept = ""+request.getParameter("dept");
				String mont=request.getParameter("month");
				String registercheck=request.getParameter("registercheck");
				String startingdate=request.getParameter("startingdate");
				String endingdate=request.getParameter("endingdate");
				String month=DateUtil.getMonth(Integer.parseInt(mont));
				String year=request.getParameter("year");
				
				int lastday = Integer.parseInt(CommonFunctions.QueryExecutecon(con,"SELECT DAY(LAST_DAY('"+year+"-"+mont+"-01'))" )[0][0]);
				
				//String date = year+"-"+mont+"-01";
				 
				/*Thread.sleep(2000);
				AttendanceFunctions.AttAssignNewJoiner(acs,apstm,con, month, year);
				Thread.sleep(2000);
				AttendanceFunctions.AttAssignResignner(apstm,con, month, year);
				Thread.sleep(2000);
				*/
				 
				 
				String verifydate=year+"-"+mont+"-01";
				int daysInMonth = CommonFunctions.daysInMonth(year+"-"+mont+"-01");
				boolean verificationflag =CommonFunctions.AttendanceProcess(verifydate);
				String sql=" ";
				
				 
				String categoryids = CommonFunctions.QueryExecutecon(con,"SELECT a.CHR_GATEGORYLIST FROM m_user a WHERE a.CHR_USRNAME='"+session.getAttribute("USRID")+"' ")[0][0] ;
				String officeids = CommonFunctions.QueryExecutecon(con,"SELECT a.CHR_OFFICELIST FROM m_user a WHERE a.CHR_USRNAME='"+""+session.getAttribute("USRID")+"' ")[0][0];
    		 	 
				 
				sql = "SELECT a.CHR_EMPID,a.CHR_FLAG FROM att_t_register a ,com_m_staff b WHERE a.CHR_EMPID =b.CHR_EMPID AND a.CHR_FLAG='N'  AND b.INT_ATTENDANCECYCLE =1 ";
				if(!"0".equals(dept))
					sql=sql + " AND b.INT_DEPARTID="+dept;
				
				if("0".equals(officeid))
					sql = sql + " AND b.INT_OFFICEID IN ("+officeids+" )";
				else
					sql=sql + " AND b.INT_OFFICEID="+officeid;
        			
				if("0".equals(Category))
 					sql = sql + " AND b.CHR_CATEGORY IN ("+categoryids+" )";
 				else
 					sql=sql + " AND b.CHR_CATEGORY="+Category;
 				 
				sql = sql + " AND a.CHR_MONTH='"+month+"'"; 
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
				
				//check the attendance register is fully mark or incomplete
				if(cdata.length>0)
				{
					if(incomplete )
					{
					 	sql = "SELECT COUNT(*) FROM att_t_register a ,com_m_staff b WHERE a.CHR_EMPID =b.CHR_EMPID AND a.CHR_FLAG='N'   AND b.INT_ATTENDANCECYCLE =1 ";
						if(!"0".equals(officeid))
							sql=sql + " AND b.INT_OFFICEID="+officeid;
						else
		        			sql = sql + " AND b.INT_OFFICEID IN ("+officeids+" )";
	
						if(!"0".equals(dept))
							sql=sql + " AND b.INT_DEPARTID="+dept;
					
						sql = sql + " AND b.CHR_CATEGORY IN ("+categoryids+"  )";
						sql = sql + " AND a.CHR_MONTH='"+month+"'"; 
						sql = sql + " AND a.INT_YEAR= "+year+ " ORDER BY  a.CHR_EMPID ";
						boolean recordexistflag =CommonFunctions.RecordExist(con, sql);
						System.out.println(verificationflag +"/"+ recordexistflag);
						if(verificationflag && recordexistflag  )
						{
							
							 
							
							sql = "SELECT a.CHR_EMPID,a.CHR_FLAG, FUN_ATT_GET_EXTRADAYS(a.CHR_EMPID ,'"+month+"','"+year+"') FROM att_t_register a ,com_m_staff b WHERE a.CHR_EMPID =b.CHR_EMPID AND a.CHR_FLAG='N'  AND b.INT_ATTENDANCECYCLE =1 ";
							if(!"0".equals(dept))
								sql=sql + " AND b.INT_DEPARTID="+dept;
							
							if(!"0".equals(officeid))
								sql=sql + " AND b.INT_OFFICEID="+officeid;
							else
			        			sql = sql + " AND b.INT_OFFICEID IN ("+officeids+")";
	
							sql = sql + " AND b.CHR_CATEGORY IN ("+categoryids+" )";
							sql = sql + " AND a.CHR_MONTH='"+month+"'"; 
							sql = sql + " AND a.INT_YEAR= "+year+ " ORDER BY  a.CHR_EMPID ";
							System.out.println();
							System.out.println(sql);
							
							String data[][] = CommonFunctions.QueryExecutecon(con, sql);
							System.out.println();
							
							
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
							
							
							//Leave 
							
							asql ="SELECT CHR_SYMBOL FROM att_m_leavetype ORDER BY INT_LEAVEID ";
							String leaveData[][] = CommonFunctions.QueryExecutecon(con,asql);
							
							if(data.length>0)
							{
								String SData[][] = CommonFunctions.QueryExecutecon(con,"SELECT CHR_SALAYCALCULATION FROM  pay_m_basicsettings WHERE INT_ID=1");
								asql = " UPDATE att_t_register SET  DOU_PRESENT= ?, ";
				                asql = asql + " DOU_ONDUTY=?, DOU_SUNDAY=?, DOU_HOLIDAY=?, ";
				                asql = asql + " DOU_LEAVE=?, DOU_ABSENT=?, 	INT_LATE=?, ";
				                asql = asql + " DOU_TOTALDAYS=?, CHR_FLAG='Y', ";
				                asql = asql + " INT_PERMISSION=? ,DOU_EXTRADAYS=?, DAT_PROCESSDATE=NOW(),";
				                //leave update
				                if(leaveData.length>0)
				                	for(int x=0;x<leaveData.length;x++)
				                	{
				                		asql = asql + " CHR_LEAVE"+(x+1)+" =  '"+leaveData[x][0]+"' , "; //Leave Symbol
				                		//asql = asql + " INT_LEAVETAKEN"+(x+1)+" = FUN_ATT_GET_LEAVETAKEN('"+leaveData[x][0]+"',CHR_EMPID,'"+month+"',"+year+") , ";
				                	}	
				                asql = asql + "  DAT_PROCESSDATE=NOW() ";	
				                asql = asql + " WHERE  CHR_EMPID=? ";
				                asql = asql + " AND  CHR_MONTH=? AND INT_YEAR=? ";
								apstm = con.prepareStatement(asql);	
								int count=0;
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
									extradays=0;
									 
									
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
										//else if("0".equals(attData[0][i]))	
										//	absent=absent+0.5;
										//else if("-".equals(attData[0][i]))	
										//	absent=absent+0.5;
											
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
									extradays = Double.parseDouble(data[u][2]);
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
									apstm.setString(10,""+data[u][2] );
									apstm.setString(11,data[u][0] );
									apstm.setString(12,month );
									apstm.setString(13,year );
									//System.out.println(apstm);
									//System.out.println(lastday + "<= "+(present+onduty+sunday+holiday+leave+absent+late+permission));
									if(lastday <= (present+onduty+sunday+holiday+leave+absent+late+permission))
									{
										apstm.addBatch();
										count = count+1;
									}	
								}
								apstm.executeBatch();
								apstm.close();
								
								
								//leave update
								double leavetaken=0;
								for(int u=0;u<data.length;u++)
								{
									asql = " UPDATE att_t_register SET  ";
					                if(leaveData.length>0)
					                	for(int x=0;x<leaveData.length;x++)
					                	{
					                		leavetaken = Double.parseDouble(CommonFunctions.QueryExecutecon(con, "SELECT FUN_ATT_GET_LEAVETAKEN('"+leaveData[x][0]+"','"+data[u][0]+"','"+month+"',"+year+")")[0][0]);
					                		asql = asql + " INT_LEAVETAKEN"+(x+1)+" = "+leavetaken +", ";
					                	}	
					                asql = asql + "  CHR_UPDATESTATUS='Y' ";	
					                asql = asql + " WHERE  CHR_EMPID=? ";
					                asql = asql + " AND  CHR_MONTH=? AND INT_YEAR=? ";
									apstm = con.prepareStatement(asql);		
									apstm.setString(1,data[u][0] );
									apstm.setString(2,month );
									apstm.setString(3,year );
									System.out.println(apstm);
									apstm.execute();
									
								}
								con.close();   
								response.sendRedirect("Smart Attendance/AttendanceProcess.jsp?er="+count+"/"+data.length+" Nos of employee Attendance process done successfully&flag=Y&Office="+officeid+"&dept="+dept+"&month="+mont+"&year="+year+"&Category="+Category+"&startingdate="+startingdate+"&endingdate="+endingdate);
						 	}
							else
							{
								con.close();    
								response.sendRedirect("Smart Attendance/AttendanceProcess.jsp");
									
							}
						}
						else
						{
							con.close();   
							response.sendRedirect("Smart Attendance/AttendanceProcess.jsp?er=Attendance process already done, please reset and process...&flag=N");
						}
						
					}
					else
					{
						con.close();  
						response.sendRedirect("Smart Attendance/AttendanceProcess.jsp?er=Process does not complete due to incomplete  employee Attendance - "+inempid);
					}
				}
				else
				{
					con.close();  
					response.sendRedirect("Smart Attendance/AttendanceProcess.jsp?er=Records not found...");
				}
 			}
			
			else if ("ATTAttendanceReset".equals(action))
			{
				
				String month= request.getParameter("month");
				String year= request.getParameter("year");
				String empid= request.getParameter("empid");
				String monthname = DateUtil.getMonth(Integer.parseInt(month));
				String d="";
				int totaldays = Integer.parseInt(CommonFunctions.QueryExecute("SELECT DAY(LAST_DAY('"+year+"-"+month+"-01'))")[0][0]);
				 
				asql =" UPDATE att_t_register   SET ";
				 
				for(int day=1;day<totaldays;day++)
				{	
					if(day<10)
						d="0"+day;
					else
						d=""+day;
					
					if("Sunday".equals( CommonFunctions.QueryExecute(" SELECT DAYNAME('"+year+"-"+month+"-"+d+"') ")[0][0]))
					{
						asql=asql+"CHR_MORNING"+day+"='SUN' , CHR_EVENING"+day+"='SUN' ,";
					}
					else
					{
						String mdata[][] = CommonFunctions.QueryExecute("SELECT CHR_MORNING"+day+"   FROM att_t_register WHERE  CHR_EMPID='"+empid+"' AND  CHR_MONTH='"+monthname+"' AND  INT_YEAR="+year);
						String edata[][] = CommonFunctions.QueryExecute("SELECT CHR_MORNING"+day+"   FROM att_t_register WHERE  CHR_EMPID='"+empid+"' AND  CHR_MONTH='"+monthname+"' AND  INT_YEAR="+year);
						if( !  ("LEA".equals(mdata[0][0]) || "ABS".equals(mdata[0][0] ) || "HOL".equals(mdata[0][0]) )  )  
							asql=asql+"CHR_MORNING"+day+"=0 ,";
						if( !("LEA".equals(edata[0][0]) || "ABS".equals(edata[0][0])  || "HOL".equals(mdata[0][0]) ) )
							asql=asql+" CHR_EVENING"+day+"=0 ,";
					}
						
					 
				}

				asql = asql+" DOU_PRESENT=0,DOU_ONDUTY=0,DOU_SUNDAY=0,DOU_HOLIDAY=0, ";
				asql = asql+" DOU_LEAVE=0,DOU_ABSENT=0,INT_LATE=0,  ";
				asql = asql+" INT_PERMISSION=0,DOU_EXTRADAYS=0,DOU_EXTRAHOURS=0 , ";
				asql = asql+" DOU_TOTALDAYS=0  ";
				asql = asql +" WHERE  CHR_EMPID=? AND  CHR_MONTH=? AND  INT_YEAR=?";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,empid);
				apstm.setString(2,monthname);
				apstm.setString(3,year);
				apstm.execute();
				
				asql = "DELETE FROM  att_smart_attendance    WHERE  CHR_EMPID=? AND  MONTHNAME(DT_LOGIN)=? AND  YEAR(DT_LOGIN)=?";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,empid);
				apstm.setString(2,monthname);
				apstm.setString(3,year);
				apstm.execute();
				 
				asql = "DELETE FROM  att_t_onduty    WHERE  CHR_EMPID=? AND  MONTHNAME(DT_ODDATE)=? AND  YEAR(DT_ODDATE)=?";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,empid);
				apstm.setString(2,monthname);
				apstm.setString(3,year);
				apstm.execute();
				
				asql = "DELETE FROM  att_t_continuousentry    WHERE  CHR_EMPID=? AND  MONTHNAME(DT_CONTINUOUSDATE)=? AND  YEAR(DT_CONTINUOUSDATE)=?";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,empid);
				apstm.setString(2,monthname);
				apstm.setString(3,year);
				apstm.execute();
				
				asql = "DELETE FROM  att_t_permission    WHERE  CHR_EMPID=? AND  MONTHNAME(DT_PDATE)=? AND  YEAR(DT_PDATE)=?";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,empid);
				apstm.setString(2,monthname);
				apstm.setString(3,year);
				apstm.execute();
				
				response.sendRedirect("Smart Attendance/MusterRoll.jsp");
				
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