package com.my.org.erp.SmartAttendance;

import java.io.IOException;

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
import com.my.org.erp.common.CommonFunction;
import com.my.org.erp.common.CommonFunctions;
 

public class StaffPermissionActionHandler extends AbstractActionHandler 
{
	Statement st;
	ResultSet rs;
	java.text.SimpleDateFormat datetime = new java.text.SimpleDateFormat("yyyy-MM-dd");
	java.util.Date date = new java.util.Date();
	String updatedate = "" + datetime.format(date);
	@SuppressWarnings("deprecation")
	String year = "" + (1900 + date.getYear());
	String userid="";
	
	boolean redirectflag = false;
	String redirecterror="";
	boolean reflag=false;
	String avlDate="", avlDesc="";
	String sql;
	boolean flag = false;
	ArrayList<Attinfo> attinfo = new ArrayList<Attinfo>();
	private static String error="";
	private static boolean returnflag= true;
	




public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			userid = (String) session.getAttribute("USRID");
			session.removeAttribute("attinfo"); 
			String targetPage2="Smart Attendance/OnlineView.jsp";
			//System.out.println("CONTROLLER FROM PERMISSION ACTION HANDLER  : "+action);
			if ("ATTStaffPermissionAdd".equals(action)) 
			{
				StaffPermissionAdd(request, response);
				con.close();   
				if(flag)
					response.sendRedirect( "Smart Attendance/error.jsp");
				else
					response.sendRedirect("Smart Attendance/Permission.jsp");
				
			}
			else if ("ATTStaffPermissionUpdate".equals(action)) 
			{
				StaffPermissionUpdate(request, response);
				con.close();    
				response.sendRedirect("Smart Attendance/Permission.jsp");
			}
			else if ("ATTStaffPermissionDeletes".equals(action)) 
			{
				StaffPermissionDeletes(request, response);
				con.close();    
				response.sendRedirect("Smart Attendance/Permission.jsp");
			}
			else if ("ATTStaffPermissionDelete".equals(action)) 
			{
				StaffPermissionDelete(request, response);
				con.close();   
				response.sendRedirect("Smart Attendance/Permission.jsp");
			}
			
			
			else if ("ATTStaffPermissionleave".equals(action)) //admin user 
			{
				StaffPermissionLeave(request, response);
				con.close();
				if(!returnflag)
					response.sendRedirect("error/index.jsp?error="+error);
				else
					 response.sendRedirect("Smart Attendance/Onlineleavestatus.jsp");
				
			}
			else if ("ATTStaffuserPermissionleave".equals(action))  //staff user
			{
				StaffPermissionLeave(request, response);
				con.close();    
				response.sendRedirect("Staff/ifOnlineApply.jsp");
				
			}
			
			
			
			else if ("ATTStaffPermissionLeaveAcess".equals(action)) 
			{
				StaffPermissionLeaveAcess(request, response);
				con.close();   
				response.sendRedirect(targetPage2);
			}
			else if ("ATTStaffPermissionLeaveDeletes".equals(action)) 
			{
				StaffPermissionLeaveDeletes(request, response);
				con.close();    
				response.sendRedirect(targetPage2);
			}
			
			else if ("ATTStaffuserPermissionLeaveDelete".equals(action)) //Delete from staff user
			{
				acs = con.prepareCall("{call  ATT_PRO_ONLINELEAVEAPPLY (?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				acs.setString(1,"DELETE");
				acs.setString(2,request.getParameter("rowid"));
				acs.setString(3,"");
				acs.setString(4,"");
				acs.setString(5,"");
				acs.setString(6,"");
				acs.setString(7,"");
				acs.setString(8,"" );
				acs.setString(9,"");
				acs.setString(10,"");
				acs.setString(11,"");
				acs.setString(12,"");
				acs.setString(13,"");
				System.out.println(""+acs);
				acs.execute();		
				acs.close(); 
				con.close();    
				response.sendRedirect("Staff/ifStaffLeaveStatus.jsp");
			}
			else if ("ATTStaffPermissionLeaveDelete".equals(action)) //Delete from ADMIN,Branch Admin user
			{
				acs = con.prepareCall("{call  ATT_PRO_ONLINELEAVEAPPLY (?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				acs.setString(1,"DELETE");
				acs.setString(2,request.getParameter("rowid"));
				acs.setString(3,"");
				acs.setString(4,"");
				acs.setString(5,"");
				acs.setString(6,"");
				acs.setString(7,"");
				acs.setString(8,"" );
				acs.setString(9,"");
				acs.setString(10,"");
				acs.setString(11,"");
				acs.setString(12,"");
				acs.setString(13,"");
				acs.execute();		
				con.close();   	 
				response.sendRedirect("Smart Attendance/Onlineleavestatus.jsp");
			}
			else if ("ATTStaffPermissionleaveGrant".equals(action))  
			{
				String length  = request.getParameter("dec");
				String accept="";
				String reject="";
				String rejectdec="";
				String rowid="";
				sql=" UPDATE att_m_onlineapplyleave  SET   CHR_STATUS =? ,  CHR_ADMINDESC =? WHERE INT_ONLINELEAVEAPPLYID=? ";
				PreparedStatement pstm = con.prepareStatement(sql);
				for(int u=0;u<Integer.parseInt(length);u++)
				{
					accept = request.getParameter("accept"+u);
					reject = request.getParameter("reject"+u);
					rejectdec = request.getParameter("dec"+u);
					rowid=request.getParameter("rowid"+u);
					if("on".equals(accept))
					{
						pstm.setString(1, "A");
						pstm.setString(2, null);
						pstm.setString(3, ""+rowid);
						pstm.addBatch();
					
					}
					if("on".equals(reject))
					{	
						pstm.setString(1, "R");
						pstm.setString(2, rejectdec);
						pstm.setString(3, ""+rowid);
						pstm.addBatch();
					}
					 
				}
				pstm.executeBatch();
				con.close();   
				response.sendRedirect("Smart Attendance/OnlineLeavePermissionGrant.jsp");
			}
			else if ("ATTStaffPermissionLeaveTransfer".equals(action))  
			{
				 
				String rowid = request.getParameter("rowid");
				asql = "SELECT CHR_EMPID,DT_PDATE,CHR_TYPE,CHR_LDESC,DAY(DT_PDATE)  FROM att_m_onlineapplyleave WHERE INT_ONLINELEAVEAPPLYID="+rowid;
				String data[][] = CommonFunctions.QueryExecute(asql);
				asql = "SELECT CHR_LEAVEEXCEED FROM att_m_basicsettings WHERE INT_ID=1";
				boolean exceedleaveflag = false;
				if("N".equals( CommonFunctions.QueryExecute(asql)[0][0]))
					exceedleaveflag = true;
				
				if(data.length>0)
				{
					String lpday[] = data[0][3].split("~");
					
					 
					if("PERMISSION".equals(data[0][2]))
					{
						
						if("PFD".equals(lpday[0]))
							asql = asql + " CHR_MORNING"+data[0][4]+" = 'PER'  CHR_EVENING"+data[0][4]+" ='PER' ,";
						else if("PFN".equals(lpday[0]))
							asql = asql + " CHR_MORNING"+data[0][4]+" = 'PER' ,";
						else
							asql = asql + " CHR_EVENING"+data[0][4]+" = 'PER' ,";
					
						asql = " SELECT (CHR_MORNING1 ='PER' || CHR_EVENING2 ='LEA')  FROM att_t_register   ";
						asql = asql +" WHERE CHR_EMPID='"+data[0][0]+"'  AND CHR_MONTH=MONTHNAME('"+data[0][1]+"') ";
						asql = asql +" AND INT_YEAR=YEAR('"+data[0][1]+"') ";
						
						 
						asql = " UPDATE att_t_register SET DT_UPDATEDATE=DATE(NOW()), ";
						if("PFD".equals(lpday[0]))
							asql = asql + " CHR_MORNING"+data[0][4]+" = 'PER' , CHR_EVENING"+data[0][4]+" ='PER' ,";
						else if("PFN".equals(lpday[0]))
							asql = asql + " CHR_MORNING"+data[0][4]+" = 'PER' ,";
						else
							asql = asql + " CHR_EVENING"+data[0][4]+" = 'PER' ,";
					
						asql = asql + " DT_UPDATEDATE=DATE(NOW()), CHR_USRNAME=? WHERE CHR_EMPID=? AND CHR_MONTH= MONTHNAME('"+data[0][1]+"') AND INT_YEAR=YEAR('"+data[0][1]+"')";
						apstm = con.prepareStatement(asql);
						apstm.setString(1,auserid );
						apstm.setString(2,data[0][0]);
						System.out.println(asql);
						apstm.execute();
						apstm.close();
						
						asql = " UPDATE att_m_onlineapplyleave SET CHR_MARK_STATUS='P' , CHR_LEAVEMARK=?,CHR_MARK_USERID=?, DAT_MARK_DATETIME =NOW()  WHERE INT_ONLINELEAVEAPPLYID=?";
						apstm = con.prepareStatement(asql);
						apstm.setString(1,"Y");
						apstm.setString(2,auserid);
						apstm.setString(3,rowid);
						System.out.println(asql);
						apstm.execute();
						apstm.close();

						
					 
						acs = con.prepareCall("{call ATT_PRO_PERMISSION( ?,?,?,?,?,?,?,?,?,?,? )}");
						acs.setString(1, "INSERT");
						acs.setString(2,  null); 
						acs.setString(3,  data[0][0]); 
						acs.setString(4,  data[0][1]  ); 
						acs.setString(5,  data[0][3].split("~")[1] ); 
						acs.setString(6,  data[0][3].split("~")[2]); 
						acs.setString(7,   "PFA".equals(data[0][3].split("~")[0] ) ? "F":"A" ); 
						acs.setString(8,  "PFA".equals(data[0][3].split("~")[0] ) ? "Forenoon":"Afternoon"); 
						acs.setString(9,  "0.5"); 
						acs.setString(10, "Online apply "); 
						acs.setString(11, userid); 
						System.out.println(""+acs);
						acs.execute();
						

													
						
						con.close();
						response.sendRedirect("Smart Attendance/OnlineLeavePermissiontransfertoregister.jsp");
					}
					else if("LEAVE".equals(data[0][2]))
					{
						double maxleave=0;
						double takenleave=0;
						String leaveid=  CommonFunctions.QueryExecute("SELECT INT_LEAVEID  FROM att_m_leavetype  WHERE CHR_SYMBOL='"+lpday[0]+"'")[0][0];
						String sql ="SELECT  count(*) FROM att_m_leave WHERE CHR_EMPID = '"+data[0][0]+"' AND INT_YEAR =YEAR('"+data[0][1]+"')";
						if(CommonFunction.RecordExist(sql))
						{
							 sql ="SELECT  INT_NOD"+leaveid+" , INT_NOD"+leaveid+"BALANCE  FROM ATT_M_LEAVE WHERE CHR_EMPID = '"+data[0][0]+"' AND INT_YEAR =YEAR('"+data[0][1]+"')";
							 String LreadData[][] =  CommonFunctions.QueryExecute(sql);
							 if(LreadData.length>0)
							 {
								maxleave=Double.parseDouble(LreadData[0][0]);
								takenleave=Double.parseDouble(LreadData[0][1]);
							 }
						}
						double addValue = 0.0;
						if("Full Day".equals(lpday[1]))
						 	addValue = 1;
						else  
						 	addValue = 0.5;
						 
						takenleave =takenleave+addValue;
						boolean flag = true;
						if(takenleave>maxleave)
							flag = false;
						
						if(exceedleaveflag)
							flag =true;
						asql = " SELECT COUNT(*) FROM att_t_leave WHERE CHR_EMPID='"+data[0][0]+"' AND   DT_LDATE='"+data[0][1]+"'";
						if("Full Day".equals(lpday[1]))
							asql = asql+"  AND CHR_DAYTYPE = 'Full Day' ";
						else if("Forenoon".equals(lpday[1]))
							asql = asql+"  AND CHR_DAYTYPE = 'Forenoon' ";
						else if("Afternoon".equals(lpday[1]))
							asql = asql+"  AND CHR_DAYTYPE = 'Afternoon' ";
						
						System.out.println("asql"+asql);
						System.out.println("exceedleaveflag"+exceedleaveflag);
						System.out.println("flag"+flag);
						System.out.println("recordexiste"+ !CommonFunction.RecordExist(asql));
						
						//leave balance available & record not there in leave entry for particular date
						if(flag && !CommonFunction.RecordExist(asql) )
						{
							 asql = "INSERT INTO att_t_leave (CHR_EMPID,DT_LDATE,CHR_LEAVETYPE,CHR_DAYTYPE,DOU_VALUE,CHR_LEAVESTATUS,CHR_USRNAME , DT_UPDATEDATE , CHR_UPDATESTATUS)VALUES (";
							 asql = asql + "? ,? ,? ,?,?,'N' ,?,DATE(NOW()) ,'Y' )";
							 apstm = con.prepareStatement(asql);
							 apstm.setString(1,data[0][0] );
							 apstm.setString(2,data[0][1]);
							 apstm.setString(3,lpday[0] );
							 apstm.setString(4,lpday[1]);
							 apstm.setString(5,""+addValue);
							 apstm.setString(6,auserid);
							 System.out.println(asql);
							 apstm.execute();
							 apstm.close();
							 
							 
							 asql = " UPDATE att_m_leave SET ";
							 asql = asql + "INT_NOD" + leaveid+ "BALANCE =" + takenleave;
							 asql = asql + " WHERE  CHR_EMPID = '"+data[0][0]+"' AND INT_YEAR =YEAR('"+data[0][1]+"')";
							 apstm = con.prepareStatement(asql);
							 System.out.println(asql);
							 apstm.execute();
							 apstm.close();
							 
							//UPDATE REGISTER
							asql = " UPDATE att_t_register SET DT_UPDATEDATE=DATE(NOW()), ";
							if("Full Day".equals(lpday[1]))
								asql = asql + " CHR_MORNING"+data[0][4]+" = 'LEA' , CHR_EVENING"+data[0][4]+" ='LEA' ,";
							else if("Forenoon".equals(lpday[1]))
								asql = asql + " CHR_MORNING"+data[0][4]+" = 'LEA' ,";
							else
								asql = asql + " CHR_EVENING"+data[0][4]+" = 'LEA' ,";
							
							asql = asql + " DT_UPDATEDATE=DATE(NOW()), CHR_USRNAME=? WHERE CHR_EMPID=?  AND CHR_MONTH= MONTHNAME('"+data[0][1]+"') AND INT_YEAR=YEAR('"+data[0][1]+"')";
							apstm = con.prepareStatement(asql);
							apstm.setString(1,auserid );
							apstm.setString(2,data[0][0]);
							System.out.println(asql);
							apstm.execute();
							apstm.close();
							
							asql = " UPDATE att_m_onlineapplyleave SET CHR_MARK_STATUS='L', CHR_LEAVEMARK=?,CHR_MARK_USERID=?, DAT_MARK_DATETIME =NOW()  WHERE INT_ONLINELEAVEAPPLYID=?";
							apstm = con.prepareStatement(asql);
							apstm.setString(1,"Y");
							apstm.setString(2,auserid);
							apstm.setString(3,rowid);
							System.out.println(asql);
							apstm.execute();
							apstm.close();
							con.close();
							response.sendRedirect("Smart Attendance/OnlineLeavePermissiontransfertoregister.jsp");
							 
						}
						else
						{
							//IF LEAVE BALANCE IS NOT THERE ITS AUTOMATICALLY GOING TO ABSENT ENTRY.
							//flag
							if(!exceedleaveflag)
							{
								String date =data[0][1];
								String day =data[0][4];
								String updatequery="UPDATE att_t_register SET CHR_USRNAME='"+userid+"',DAT_MODIFIEDDATE=NOW(),";
								String  updatequery1= " SElECT COUNT(*)  FROM att_t_register  WHERE CHR_EMPID ='"+data[0][0]+"' AND CHR_MONTH= MONTHNAME('"+date+"') AND INT_YEAR=YEAR('"+date+"')";
								
								if("Full Day".equals(lpday[1]))
								{	
									updatequery=updatequery+" CHR_MORNING"+day+" = 'ABS' ,   CHR_EVENING"+day+" = 'ABS', ";
									updatequery1 =updatequery1 + " AND CHR_MORNING"+day+" !='0'  AND CHR_EVENING"+day+" !='0'" ;
								}
								else if("Forenoon".equals(lpday[1]))
								{
									updatequery=updatequery+" CHR_MORNING"+day+" = 'ABS' , ";
									updatequery1 =updatequery1 + " AND CHR_MORNING"+day+" !='0'  " ;
								}
								else if("Afternoon".equals(lpday[1]))
								{
									updatequery=updatequery+" CHR_EVENING"+day+" = 'ABS' , ";
									updatequery1 =updatequery1 + "  AND CHR_EVENING"+day+" !='0'" ;
								}
								
								
								updatequery = updatequery.trim();
								updatequery = updatequery.substring(0,updatequery.length()-1);
								updatequery = updatequery+" WHERE CHR_EMPID=? AND CHR_MONTH=MONTHNAME('"+date+"') AND INT_YEAR=YEAR('"+date+"')";
								
								System.out.println(updatequery);
								System.out.println(updatequery1);
								if(!CommonFunction.RecordExist(updatequery1))
								{
									apstm = con.prepareStatement(updatequery);
									apstm.setString(1,data[0][0]);
									apstm.execute();
									apstm.close();
									
									asql = " UPDATE att_m_onlineapplyleave SET CHR_MARK_STATUS='A', CHR_LEAVEMARK=?,CHR_MARK_USERID=?, DAT_MARK_DATETIME =NOW()  WHERE INT_ONLINELEAVEAPPLYID=?";
									apstm = con.prepareStatement(asql);
									apstm.setString(1,"Y");
									apstm.setString(2,auserid);
									apstm.setString(3,rowid);
									System.out.println(asql);
									apstm.execute();
									apstm.close();
								}	
								
								con.close();
								response.sendRedirect("Smart Attendance/OnlineLeavePermissiontransfertoregister.jsp");
							}
							else
							{
								con.close();
								response.sendRedirect("Smart Attendance/OnlineLeavePermissiontransfertoregister.jsp?er=Kindly check the date, Duplicate entry for "+data[0][0]);
							}
							
						}
						
						
						
						
						
						
					}
					
				
				}
				
			}
			else if("ATTStaffPermissionleaveGrantDelete".equals(action))
			{
				String rowid = request.getParameter("rowid");
				asql = "DELETE FROM att_m_onlineapplyleave WHERE INT_ONLINELEAVEAPPLYID =? AND CHR_LEAVEMARK ='N' ";
				apstm = con.prepareStatement(asql);
				apstm.setString(1, rowid);
				System.out.println(""+apstm);
				apstm.execute();
				apstm.close();
				con.close();
				response.sendRedirect("Smart Attendance/OnlineView.jsp");
			
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















private void StaffPermissionAdd(HttpServletRequest request,	HttpServletResponse response)throws ServletException, IOException 
{
	try 
	{
			HttpSession session = request.getSession();
			String userid = (String) session.getAttribute("USRID");
			String staffids[] = request.getParameterValues("ename");
			String pdate = request.getParameter("fromdt");
			String dat[] = pdate.split("-");
			String day = ""+Integer.parseInt(dat[0]);
			pdate = DateUtil.FormateDateSQL(pdate  );
			String ftime = request.getParameter("int");
			String ttime =request.getParameter("out");
			String reason = request.getParameter("reason");
			String type =request.getParameter("ComboDay");
			String umonth=DateUtil.getMonth(Integer.parseInt(dat[1]));
			
			 
			
			
			 
				 	String updatequery="UPDATE att_t_register SET CHR_USRNAME='"+userid+"',DAT_MODIFIEDDATE=NOW(), ";
					String  updatequery1= " ";
					
					if("Forenoon".equals(type))
					{
						updatequery=updatequery+" CHR_MORNING"+day+" = 'PER' , ";
						updatequery1 =updatequery1 + " AND CHR_MORNING"+day+"   NOT IN ('LEA','HOL','ABS')  " ;
					}
					else if("Afternoon".equals(type))
					{
						updatequery=updatequery+" CHR_EVENING"+day+" = 'PER' , ";
						updatequery1 =updatequery1 + "  AND CHR_EVENING"+day+"   NOT IN ('LEA','HOL','ABS')" ;
					}		
					updatequery=updatequery.trim();
					updatequery = updatequery.substring(0,updatequery.length()-1);
					String ssql=updatequery+" WHERE CHR_EMPID=? AND CHR_MONTH=MONTHNAME('"+pdate+"') AND INT_YEAR=YEAR('"+pdate+"') " +updatequery1;
					System.out.println(ssql);
					apstm = con.prepareStatement(ssql);
					acs = con.prepareCall("{call ATT_PRO_PERMISSION( ?,?,?,?,?,?,?,?,?,?,? )}");
					 
					
					for (int u = 0; u < staffids.length; u++) 
					{
 						 	acs.setString(1, "INSERT");
							acs.setString(2,  null); 
							acs.setString(3,  staffids[u].trim()); 
							acs.setString(4,  pdate  ); 
							acs.setString(5,  ftime ); 
							acs.setString(6,  ttime); 
							acs.setString(7,  type); 
							acs.setString(8,  type); 
							acs.setString(9,  "0.5"); 
							acs.setString(10, reason); 
							acs.setString(11, userid); 
							acs.addBatch();
							
							apstm.setString(1, staffids[u].trim());
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

private void StaffPermissionUpdate(	HttpServletRequest request,	HttpServletResponse response)throws ServletException, IOException 
{
		try 
		{
			
			
			HttpSession session = request.getSession();
			String userid = (String) session.getAttribute("USRID");
			String rowid = request.getParameter("rowid");
			String fromdt = request.getParameter("fromdt");
			fromdt= DateUtil.FormateDateSQL(fromdt);
			String ComboDay = request.getParameter("ComboDay");
			String ftime = request.getParameter("int");
			String ttime =request.getParameter("out");
			String reason = request.getParameter("reason");
			double dayvalue=0.5;
			 
			sql = " SELECT a.INT_PERMISSIONID ,a.CHR_DAYTYPE, DATE_FORMAT(a.DT_PDATE,'%d-%m-%Y') ,MONTHNAME(a.DT_PDATE) ,YEAR( a.DT_PDATE),DAY( a.DT_PDATE),a.CHR_EMPID FROM att_t_permission a,com_m_staff b,com_m_office c WHERE a.CHR_EMPID= b.CHR_EMPID  AND b.INT_OFFICEID =c.INT_OFFICEID and a.INT_PERMISSIONID="+rowid;
			String readData[][] = CommonFunctions.QueryExecute(sql);
			String updatequery1="";
			String updatequery=" UPDATE att_t_register SET  ";
			if("Forenoon".equals(readData[0][1]))
			{	
				updatequery=updatequery+" CHR_MORNING"+readData[0][5]+" = null , ";
				updatequery1 = updatequery1 + " AND CHR_MORNING"+readData[0][5]+"  IN ('PER') ";
			}	
			else if("Afternoon".equals(readData[0][1]))
			{	
				updatequery=updatequery+" CHR_EVENING"+readData[0][5]+" = null , ";
				updatequery1 = updatequery1 + " AND CHR_EVENING"+readData[0][5]+"  IN ('PER') ";
			}	
			updatequery=updatequery.trim();
			updatequery = updatequery.substring(0,updatequery.length()-1);
			updatequery = updatequery+" WHERE CHR_EMPID='"+readData[0][6]+"' AND CHR_MONTH='"+readData[0][3]+"' AND INT_YEAR="+readData[0][4]+updatequery1;
			System.out.println(updatequery);
			st= con.createStatement();
			st.executeUpdate(updatequery);
			 
			acs = con.prepareCall("{call ATT_PRO_PERMISSION( ?,?,?,?,?,?,?,?,?,?,? )}");
			acs.setString(1, "UPDATE");
			acs.setString(2,  rowid); 
			acs.setString(3,  readData[0][6]); 
			acs.setString(4,  fromdt  ); 
			acs.setString(5,  ftime ); 
			acs.setString(6,  ttime); 
			acs.setString(7,  ComboDay); 
			acs.setString(8,  ComboDay); 
			acs.setString(9,  ""+dayvalue); 
			acs.setString(10, reason); 
			acs.setString(11, userid); 
			acs.execute(); 
			 
			updatequery=" UPDATE att_t_register SET  ";
			updatequery1="";
			if("Forenoon".equals(ComboDay))
			{
				updatequery=updatequery+" CHR_MORNING"+readData[0][5]+" = 'PER' , ";
				updatequery1 = updatequery1 + " AND CHR_MORNING"+readData[0][5]+" NOT IN ('LEA','HOL','ABS')";
			}
			else if("Afternoon".equals(ComboDay))
			{
				updatequery=updatequery+" CHR_EVENING"+readData[0][5]+" = 'PER' , ";
				updatequery1 = updatequery1 + "  AND CHR_EVENING"+readData[0][5]+" NOT IN ('LEA','HOL','ABS') ";
			}
			updatequery=updatequery.trim();
			updatequery = updatequery.substring(0,updatequery.length()-1);
			updatequery = updatequery+" WHERE CHR_EMPID='"+readData[0][6]+"' AND CHR_MONTH='"+readData[0][3]+"' AND INT_YEAR="+readData[0][4]+updatequery1;
			System.out.println(updatequery); 
			st.executeUpdate(updatequery);
			st.close();
				
		}
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 
			 
		}
}
	
	



private void StaffPermissionDelete(	HttpServletRequest request,
								HttpServletResponse response) 
									throws ServletException, IOException 
{
		try 
		{
			String staff[] = request.getParameter("staffid").split("~");
			String staffid =staff[0];
			String date = staff[1];
			String ftime = staff[2];
			String sql ="DELETE FROM ATT_T_PERMISSION  ";
			sql = sql +" WHERE CHR_EMPID = '"+staffid+"'";
			sql = sql +" AND DT_PDATE = '"+date+"'";
			sql = sql +"  AND DT_TIME_FROM = '"+ftime+"'";
			
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



private void StaffPermissionDeletes(	HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
{
try 
{
	
	String rowid[] = request.getParameterValues("rowid");
	String updatequery1="  "; 
	String updatequery="  ";
	acs = con.prepareCall("{call ATT_PRO_PERMISSION( ?,?,?,?,?,?,?,?,?,?,? )}");
	st = con.createStatement();
	for(int u=0; u<rowid.length;u++)
	{
		
		sql ="SELECT CHR_EMPID,MONTHNAME(DT_PDATE),YEAR(DT_PDATE),CHR_DAYTYPE,DAY(DT_PDATE),DT_PDATE FROM att_t_permission WHERE INT_PERMISSIONID="+rowid[u];
		String readData[][] =  CommonFunctions.QueryExecute(sql);
		
		updatequery=" UPDATE att_t_register SET  ";
		updatequery1="";
		if("Forenoon".equals(readData[0][3]))
		{	
			updatequery=updatequery+" CHR_MORNING"+readData[0][4]+" = null , ";
			updatequery1 = updatequery1 + " AND CHR_MORNING"+readData[0][4]+"  IN ('PER') ";;
		}	
		else if("Afternoon".equals(readData[0][3]))
		{
			updatequery=updatequery+" CHR_EVENING"+readData[0][4]+" = null , ";
			updatequery1 = updatequery1 + "   AND CHR_EVENING"+readData[0][4]+"  IN ('PER') ";
		}	
		updatequery=updatequery.trim();
		updatequery = updatequery.substring(0,updatequery.length()-1);
		updatequery = updatequery+" WHERE CHR_EMPID='"+readData[0][0]+"' AND CHR_MONTH='"+readData[0][1]+"' AND INT_YEAR="+readData[0][2] +updatequery1;
		System.out.println(updatequery);
		st.executeUpdate(updatequery);
		 
		acs.setString(1, "DELETE");
		acs.setString(2,  rowid[u]); 
		acs.setString(3,  ""); 
		acs.setString(4,  ""  ); 
		acs.setString(5,  "" ); 
		acs.setString(6,  ""); 
		acs.setString(7,  ""); 
		acs.setString(8,  ""); 
		acs.setString(9,  ""); 
		acs.setString(10, ""); 
		acs.setString(11, ""); 
		acs.addBatch();
		
		asql = " UPDATE att_m_onlineapplyleave SET CHR_STATUS='R' , CHR_ADMINDESC='Entry deleted' ";
		asql = asql +" WHERE CHR_EMPID=?  AND  DT_PDATE =? ";
		apstm = con.prepareStatement(asql);
		apstm.setString(1,readData[0][0] );
		apstm.setString(2,readData[0][5]);
		System.out.println(""+apstm);
		apstm.execute();
		apstm.close();
		 
		
	}
	acs.executeBatch();
	st.close();
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

 
//Leave or Permission Assign
private void StaffPermissionLeave(	HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
{
	try 
	{
		String staffid = ""+request.getParameter("staffid");
		String ApplyLeave = ""+request.getParameter("ApplyLeave");
		String pdate1 = request.getParameter("Pfromdt");
		pdate1 =DateUtil.FormateDateSQL(pdate1);
		String fdate1 =request.getParameter("Lfromdate");
		fdate1 =DateUtil.FormateDateSQL(fdate1);
		
		
		asql = " SELECT COUNT(*) FROM att_m_onlineapplyleave WHERE CHR_EMPID='"+staffid+"' ";
		asql = asql+"   AND CHR_TYPE ='PERMISSION' ";
		if("P".equals(ApplyLeave))
			asql = asql+"  AND  DT_PDATE ='"+pdate1+"' ";
		else
			asql = asql+"  AND  DT_PDATE ='"+fdate1+"' ";
		System.out.println("PERMISSION : "+asql+"/"+(CommonFunction.RecordExist(asql)));
		boolean pflag = CommonFunction.RecordExist(asql);
		
		asql = " SELECT COUNT(*) FROM att_m_onlineapplyleave WHERE CHR_EMPID='"+staffid+"' ";
		asql = asql+"   AND CHR_TYPE ='LEAVE'  ";
		if("P".equals(ApplyLeave))
			asql = asql+"  AND  DT_PDATE ='"+pdate1+"' ";
		else
			asql = asql+"  AND  DT_PDATE ='"+fdate1+"' ";
		System.out.println("LEAVE : "+ asql+"/"+(CommonFunction.RecordExist(asql)));
		boolean lflag =	CommonFunction.RecordExist(asql);
		
		String s="";
		if(  !pflag || !lflag)
		{
			//PERMISSION TRUE THEN CHECK & INSERT LEAVE
			
			
			if(pflag)
			{
				String comboDay=request.getParameter("LComboDay");
				if("Full Day".equals(comboDay ))
					s="F";
				else if("Forenoon".equals(comboDay ))
					s="M";
				else
					s="E";
				
				asql = " SELECT CHR_DAY FROM att_m_onlineapplyleave WHERE CHR_EMPID='"+staffid+"' ";
				asql = asql+"  AND CHR_EMPID='"+staffid+"'        ";
				asql = asql+"  AND  DT_PDATE ='"+fdate1+"' ";
				System.out.println(asql);
				String pady = CommonFunctions.QueryExecute(asql)[0][0];
				 
				if(s.equals(pady) || "F".equals(s))
				{
					
					error =  "Already permission apply for the date "+DateUtil.FormateDateSys(pdate1);
					returnflag = false;
				}
				else
				{
					 
					if(ApplyLeave.equals("L"))
					{
						String leavename =request.getParameter("LeaveType");
						comboDay=request.getParameter("LComboDay");
						
						s="";
						if("Full Day".equals(comboDay ))
							s="F";
						else if("Forenoon".equals(comboDay ))
								s="M";
						else
							s="E";
						String fdate =request.getParameter("Lfromdate");
						fdate =DateUtil.FormateDateSQL(fdate);
						String preason =request.getParameter("lreason");
						String cdate = fdate;
						String data[] = cdate.split("-");
						String month = DateUtil.getMonth(Integer.parseInt(data[1]));
						String year =   data[0] ;
						acs = con.prepareCall("{call  ATT_PRO_ONLINELEAVEAPPLY (?,?,?,?,?,?,?,?,?,?,?,?,?)}");
						acs.setString(1,"INSERT");
						acs.setString(2,"");
						acs.setString(3,staffid);
						acs.setString(4,updatedate);
						acs.setString(5,fdate);
						acs.setString(6,month);
						acs.setString(7,year);
						acs.setString(8,(leavename+"~"+comboDay +"~" ) );
						acs.setString(9,preason);
						acs.setString(10,"LEAVE");
						acs.setString(11,s);
						acs.setString(12,"P");
						acs.setString(13,userid);
						System.out.println(""+acs);
						acs.execute();	
						acs.close();
					}
				}
			
			}
			
			
			//LEAVE TRUE THEN CHECK & INSERT PERMISSION
			else if (lflag)
			{
				String comboDay=request.getParameter("PComboDay");
				if("PFN".equals(comboDay ))
					s="M";
				else
					s="E";
				asql = " SELECT CHR_DAY FROM att_m_onlineapplyleave WHERE CHR_EMPID='"+staffid+"' ";
				asql = asql+"  AND CHR_EMPID='"+staffid+"'   ";
				asql = asql+"  AND  DT_PDATE ='"+pdate1+"' ";
				String pady = CommonFunctions.QueryExecute(asql)[0][0];
				 	
				 
						
				if ( !("F".equals(pady) || s.equals(pady)))
				{
					//INSERT PERMISSION
					if(ApplyLeave.equals("P"))
					{
						try 
						{
							String pdate = request.getParameter("Pfromdt");
							pdate =DateUtil.FormateDateSQL(pdate);
							String ftime =request.getParameter("int");
							String ttime =request.getParameter("out");
							String preason =request.getParameter("preason");
							String data[] = updatedate.split("-");
							String month = DateUtil.getMonth(Integer.parseInt(data[1]));
							String year =   data[0] ;
							
							acs = con.prepareCall("{call  ATT_PRO_ONLINELEAVEAPPLY (?,?,?,?,?,?,?,?,?,?,?,?,?)}");
							acs.setString(1,"INSERT");
							acs.setString(2,"");
							acs.setString(3,staffid);
							acs.setString(4,updatedate);
							acs.setString(5,pdate);
							acs.setString(6,month);
							acs.setString(7,year);
							acs.setString(8,(comboDay +"~"+ftime+"~"+ttime+"~") );
							acs.setString(9,preason);
							acs.setString(10,"PERMISSION");
							acs.setString(11,"PFN".equals(comboDay)?"M":"E");
							acs.setString(12,"P");
							acs.setString(13,userid);
							System.out.println(""+acs);
							acs.execute();	
							acs.close();
						} 
						catch (RuntimeException e) 
						{
							 
					    	error= e.getMessage();
					    	returnflag = false;
						}
					}
				}
				else
				{
					error= "Already permission/ leave apply for the date "+DateUtil.FormateDateSys(pdate1)  ;
			        returnflag = false;
				}
			}
			else
			{

				if(ApplyLeave.equals("P"))
				{
					try 
					{
						String pdate = request.getParameter("Pfromdt");
						pdate =DateUtil.FormateDateSQL(pdate);
						String comboDay=request.getParameter("PComboDay");
						String ftime =request.getParameter("int");
						String ttime =request.getParameter("out");
						String preason =request.getParameter("preason");
						String data[] = updatedate.split("-");
						String month = DateUtil.getMonth(Integer.parseInt(data[1]));
						String year =   data[0] ;
						
						acs = con.prepareCall("{call  ATT_PRO_ONLINELEAVEAPPLY (?,?,?,?,?,?,?,?,?,?,?,?,?)}");
						acs.setString(1,"INSERT");
						acs.setString(2,"");
						acs.setString(3,staffid);
						acs.setString(4,updatedate);
						acs.setString(5,pdate);
						acs.setString(6,month);
						acs.setString(7,year);
						acs.setString(8,(comboDay +"~"+ftime+"~"+ttime+"~") );
						acs.setString(9,preason);
						acs.setString(10,"PERMISSION");
						acs.setString(11,"PFN".equals(comboDay)?"M":"E");
						acs.setString(12,"P");
						acs.setString(13,userid);
						System.out.println(""+acs);
						acs.execute();	
						acs.close();
					} 
					catch (RuntimeException e) 
					{
						error= e.getMessage();
				    	returnflag = false;

					}
				}
				
				
				if(ApplyLeave.equals("L"))
				{
					String leavename =request.getParameter("LeaveType");
					String comboDay=request.getParameter("LComboDay");
					
					s="";
					if("Full Day".equals(comboDay ))
						s="F";
					else if("Forenoon".equals(comboDay ))
							s="M";
					else
						s="E";
					String fdate =request.getParameter("Lfromdate");
					fdate =DateUtil.FormateDateSQL(fdate);
					String preason =request.getParameter("lreason");
					String cdate = fdate;
					String data[] = cdate.split("-");
					String month = DateUtil.getMonth(Integer.parseInt(data[1]));
					String year =   data[0] ;
					acs = con.prepareCall("{call  ATT_PRO_ONLINELEAVEAPPLY (?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					acs.setString(1,"INSERT");
					acs.setString(2,"");
					acs.setString(3,staffid);
					acs.setString(4,updatedate);
					acs.setString(5,fdate);
					acs.setString(6,month);
					acs.setString(7,year);
					acs.setString(8,(leavename+"~"+comboDay +"~" ) );
					acs.setString(9,preason);
					acs.setString(10,"LEAVE");
					acs.setString(11,s);
					acs.setString(12,"P");
					acs.setString(13,userid);
					System.out.println(""+acs);
					acs.execute();	
					acs.close();
				}
			
			}
			 
			
			
		}
		else if(  pflag && lflag)
		{
			 
			error= "Already permission/ leave apply for the date "+DateUtil.FormateDateSys(pdate1) ;
			System.out.println(""+error);
			returnflag = false;
	    	 
		}
		
 	
	}
	catch (Exception e) 
	{
		error= e.getMessage();
    	returnflag = false;
	}
		
}








//LEAVE OR PERMISSION DELETE

private void StaffPermissionLeaveDeletes(	HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
{
	try 
	{
		String Rowid[] = request.getParameterValues("Rowid");
		acs = con.prepareCall("{call  ATT_PRO_ONLINELEAVEAPPLY (?,?,?,?,?,?,?,?,?,?,?,?)}");
		for(int y=0;y<Rowid.length;y++)
		{
			acs.setString(1,"DELETE");
			acs.setString(2,Rowid[y]);
			acs.setString(3,"");
			acs.setString(4,"");
			acs.setString(5,"");
			acs.setString(6,"");
			acs.setString(7,"");
			acs.setString(8,"" );
			acs.setString(9,"");
			acs.setString(10,"");
			acs.setString(11,"");
			acs.setString(12,userid);
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






//GRANT LEAVE OR PERMISSION



private void StaffPermissionLeaveAcess(	HttpServletRequest request, HttpServletResponse response) 	throws ServletException, IOException 
{
	try 
	{
		String Rowid =request.getParameter("Rowid");
		String Data[][] =CommonFunctions.QueryExecute("SELECT a.CHR_EMPID, date_format(a.DT_PDATE,'%d-%b-%Y') ,a.CHR_TYPE,b.CHR_STAFFNAME,a.CHR_LDESC,a.CHR_REASON FROM att_m_onlineapplyleave a, com_m_staff b   WHERE a.CHR_EMPID=b.CHR_EMPID  AND  a.INT_ONLINELEAVEAPPLYID="+Rowid);
	    String staff  =Data[0][0];
		String date  =Data[0][1];
		String type = Data[0][2];
		String Type =""+request.getParameter("submit1");
		st = con.createStatement();
		String sql="";
		boolean flag =false;
		if("Grant".equals(Type) )
		{
			sql= " UPDATE ATT_M_ONLINEAPPLYLEAVE SET CHR_STATUS='A'";
			sql = sql +" WHERE INT_ONLINELEAVEAPPLYID ="+Rowid;
			flag = true;
		}
		else if( "Deny".equals(Type)  )
		{
			sql = " UPDATE ATT_M_ONLINEAPPLYLEAVE SET CHR_STATUS='D'";
			sql = sql +" WHERE INT_ONLINELEAVEAPPLYID ="+Rowid;
		}
		else if( "Reject".equals(Type)  )
		{
			sql = " DELETE FROM  ATT_M_ONLINEAPPLYLEAVE ";
			sql = sql +" WHERE INT_ONLINELEAVEAPPLYID ="+Rowid;
			
		}
		st.execute(sql);
		
		if(flag)
		{
		 if("PERMISSION".equals(type))
		 {
			 	HttpSession session = request.getSession();
				String userId = (String) session.getAttribute("USRID");
				sql = "SELECT CHR_LDESC,CHR_REASON FROM ATT_M_ONLINEAPPLYLEAVE  ";
				sql = sql +" WHERE CHR_EMPID ='"+staff+"'";
				sql = sql +" AND DT_PDATE ='"+date+"'";
				sql = sql +" AND CHR_TYPE ='"+type+"'";
				sql = sql +" AND CHR_STATUS='A'";
				
				@SuppressWarnings("unused")
				int row = com.my.org.erp.bean.Attendance.StaffRegistration.getTableRow(sql);
				String h[][]=com.my.org.erp.bean.Attendance.StaffRegistration.getTableAllValuesArray(sql); 
			 	String d[] =h[0][0].split("~");
			 	String reason = h[0][1];
			 	String p= d[0];
			 	if("PFD".equals(p))
			 		p = "";
			 	if("PFN".equals(p))
			 		p = "F";
			 	if("PAN".equals(p))
			 		p = "F";		
				sql ="INSERT INTO ATT_T_PERMISSION VALUES ( ";
				sql = sql +"'" +staff +"' ,";
				sql = sql +"'" +date +"' ,";
				sql = sql +"'" +d[1] +"' ,";
				sql = sql +"'" +d[2] +"' ,";
				sql = sql +"'" +p +"' ,";
				sql = sql +"'" +reason +"' ,";
				String data[] = date.split("-");
				String month = DateUtil.getMonth(Integer.parseInt(data[1]));
				sql = sql +"'" +month +"' ,";
				sql = sql +year +" ,";
				sql = sql +"'" +userId +"' ,";
				sql = sql +"'" +updatedate +"' ,";
				sql = sql +"'Y' )";
				//mail send to apply candidates for future enhancements
				st.execute(sql);
		 }
		 
		 if("LEAVE".equals(type))
		 {
			 	HttpSession session = request.getSession();
				String userId = (String) session.getAttribute("USRID");
				sql = "SELECT CHR_LDESC,CHR_REASON FROM ATT_M_ONLINEAPPLYLEAVE  ";
				sql = sql +" WHERE CHR_EMPID ='"+staff+"'";
				sql = sql +" AND DT_PDATE ='"+date+"'";
				sql = sql +" AND CHR_TYPE ='"+type+"'";
				sql = sql +" AND CHR_STATUS='A'";
				String h[][]=CommonFunctions.QueryExecute(sql);
			 	String d[] =h[0][0].split("~"); 

			 	String l = d[0];
			 	String ltype = d[0];
			 	String dt= d[1];
			 	
			 	int rcount = 0;
				sql = "";
				rcount = com.my.org.erp.bean.Attendance.StaffRegistration.getAnyMaxValue("INT_LEAVEID","ATT_T_LEAVE", "CHR_EMPID",staff, "0");
				sql = "INSERT INTO ATT_T_LEAVE VALUES (";
				sql = sql + "'" + staff + "' ,";
				sql = sql + (rcount + 1) + " ,";
				sql = sql + "'" + date + "' ,";
				sql = sql + "'" + l + "' ,";
				sql = sql + "'" + dt + "' ,";
				sql = sql + "'N' ,";
				sql = sql + "'" + userId + "' ,";
				sql = sql + "'" + updatedate + "' ,";
				sql = sql + "'Y' )";
				st.execute(sql);	
				String sql3="SELECT CHR_SYMBOL from ATT_M_LEAVETYPE"; 
				String types[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql3);
				int j=0;
				for(j=0; j<types.length; j++) 
				{
					if (types[j][0].equals(ltype))
					{
						 
							break;
					}
				}
				j=j+1;
				 String sql2 = "SELECT INT_NOD"+j+", INT_NOD"+j+"BALANCE FROM att_m_leave WHERE CHR_EMPID='"+staff+"' AND INT_YEAR=year('"+date+"')";
				 String tot[][]=CommonFunctions.QueryExecute(sql2);
				float full=1.0f, half = 0.5f;
				float avl;
				if (tot[0][1].equals("0.00"))
				{
					if (dt.equals("Full Day"))
						avl = full;
					else
						avl = half;
				}
				else
				{	
					if (dt.equals("Full Day"))
						avl = Float.parseFloat(tot[0][1])+full;
					else
						avl = Float.parseFloat(tot[0][1])+half;
				}
				sql = "UPDATE att_m_leave SET ";
				sql = sql + "INT_NOD"+j+"BALANCE ="+avl;
				sql = sql + " WHERE CHR_EMPID='"+staff+"'";
				sql = sql + " AND INT_YEAR=year('"+date+"')";
				 
				st.execute(sql);
				
				sql = " SELECT  month(now()) ,year(now()) ";
				String current[][]= CommonFunctions.QueryExecute(sql);
				String pdt[] = date.split("-");
				
				if((Integer.parseInt(current[0][0]) == Integer.parseInt(pdt[1])) && (Integer.parseInt(current[0][1])==Integer.parseInt(pdt[0])))
				{
					sql = "UPDATE att_t_register SET ";
					if (dt.equals("Full Day"))
						sql = sql +" CHR_MORNING"+pdt[2]+"='LEA' , CHR_EVENING"+pdt[2]+"='LEA'   WHERE CHR_EMPID='"+staff+"' AND INT_YEAR=year('"+date+"') AND CHR_MONTH= monthname('"+date+"')";
					else if (dt.equals("Forenoon"))
						sql = sql +" CHR_MORNING"+pdt[2]+"='LEA'  WHERE CHR_EMPID='"+staff+"' AND INT_YEAR=year('"+date+"') AND CHR_MONTH= monthname('"+date+"')";
					else if (dt.equals("Afternoon"))
						sql = sql +" CHR_EVENING"+pdt[2]+"='LEA'  WHERE CHR_EMPID='"+staff+"' AND INT_YEAR=year('"+date+"') AND CHR_MONTH= monthname('"+date+"')";
					st.execute(sql);
				}
				else
				{
					sql = " INSERT INTO att_t_onlineleavegrant (CHR_EMPID,DT_LPDATE, CHR_MONTH, INT_YEAR, CHR_TYPE, CHR_DAY,CHR_STATUS,CHR_USRNAME, DT_UPDATEDATE,CHR_UPDATESTATUS ) VALUES (";
					sql = sql +" '"+staff+"' , ";
					sql = sql +" '"+date+"' , ";
					sql = sql +" monthname('"+date+"') , ";
					sql = sql +" year('"+date+"') , ";
					sql = sql +"'L' , ";
					if (dt.equals("Full Day"))
						sql = sql +" 'F' , ";
					else if (dt.equals("Forenoon"))
						sql = sql +" 'M'  , ";
					else if (dt.equals("Afternoon"))
						sql = sql +"'E' , ";
					sql = sql+" 'N' ,'"+userId+"' , now(),'Y')";
					System.out.println(sql);
					st.execute(sql);
					
				}
				
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
