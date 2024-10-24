package com.my.org.erp.SmartPayroll;
import java.io.IOException;
import java.net.InetAddress;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.pdf.FontSelector;
import com.lowagie.text.pdf.PdfWriter;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunction;
import com.my.org.erp.common.CommonFunctions;
public class StaffCessationActionHandler extends AbstractActionHandler 
{
	
	Statement st;
	ResultSet rs;
	PreparedStatement pstm;

	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String action = ""+request.getParameter("actionS");
			HttpSession session = request.getSession();
			String userId = (String) session.getAttribute("USRID");
			String loginempid = (String) session.getAttribute("EMPID");
			String branchid = session.getAttribute("BRANCHID").toString();
			if (action.equals("PAYStaffCessationAdd")) 
			{
				String staffid = ("" + request.getParameter("ename")).trim();
				String cessation = "" + request.getParameter("cessation");
				String date = "" + request.getParameter("date");
				String pfdate = "" + request.getParameter("pfdate");
				String reason = "" + request.getParameter("reason");
				String mode = "" + request.getParameter("mode");
				String pdata[][] =CommonFunctions.QueryExecute("SELECT CHR_PF,CHR_ESI,('"+DateUtil.FormateDateSQL(date)+"' > DT_DOJCOLLEGE) from com_m_staff WHERE CHR_EMPID ='"+staffid+"'");
				
				try 
				{	
				 
					if( (pdata.length>0) && (!"ADMIN".equals(staffid)) )
					{
						if( "1".equals(pdata[0][2]))
						{
						
							
							int daysInloop = Integer.parseInt(date.split("-")[0]);
							String monthname = DateUtil.getMonth(Integer.parseInt(date.split("-")[1]));
							int year =Integer.parseInt(date.split("-")[2]);
							boolean attregisterflag=true;
							
							//Attendance Register check
							asql = " SELECT COUNT(*) from att_t_register  WHERE  CHR_MONTH='"+monthname+"' AND INT_YEAR="+year+" AND CHR_EMPID = '"+staffid+"' ";
							attregisterflag = CommonFunctions.RecordExist(con, asql);
							
							if(attregisterflag)
							{
								asql=" SELECT ( ";
								for(int i=1;i<=daysInloop;i++)
									asql = asql+" (CHR_MORNING"+i+"='0') OR (CHR_EVENING"+i+"='0') OR ";
								asql=asql.trim();
								asql = asql.substring(0,asql.length()-2);	
								asql=asql+" ) ";
								asql = asql+" FROM att_t_register WHERE CHR_EMPID='"+staffid+"' AND CHR_MONTH='"+monthname+"' AND INT_YEAR="+year;
								System.out.println(asql);
								if("1".equals(CommonFunctions.QueryExecutecon(con, asql)[0][0]))
									attregisterflag = false;
							}
							 
								
							
							//conveyance clear
							asql ="SELECT COUNT(*) from conveyance_t_conveyance a, com_m_staff b  WHERE a.CHR_EMPID in(SELECT CHR_EMPID FROM ";
							asql = asql + " com_m_staff WHERE CHR_REPTO='"+staffid+"'  order by CHR_STAFFNAME ) "; 
							asql = asql +" AND a.CHR_EMPID =b.CHR_EMPID AND CHR_STATUS='N'  group by a.CHR_EMPID ORDER BY  b.CHR_STAFFNAME ";
							boolean conveyanceclearflag = CommonFunctions.RecordExist(con, asql);
											
							//conveyance entry
							asql = " SELECT COUNT(*) from conveyance_t_conveyance  WHERE  CHR_STATUS='N'  AND CHR_EMPID = '"+staffid+"' ";
							boolean conveyanceentryflag = CommonFunctions.RecordExist(con, asql);
								
							//reporting head
							asql = "SELECT COUNT(*) FROM  com_m_staff WHERE   CHR_TYPE !='T' AND CHR_REPTO ='"+staffid+"'";
							boolean reportingheadflag = CommonFunctions.RecordExist(con, asql);
							
							
							
							if(attregisterflag)
							{
								if(!conveyanceclearflag)
								{
									if(!conveyanceentryflag)
									{	
										if(!reportingheadflag)
										{
											//cessation process
											asql = " DELETE FROM pay_m_emp_termination WHERE CHR_EMPID = ? ";
											apstm = con.prepareStatement(asql);
											apstm = con.prepareStatement(asql);
											apstm.setString(1, staffid);
											System.out.println(""+apstm);
											apstm.execute();
											
											asql = " INSERT INTO pay_m_emp_termination (";
											asql = asql + " CHR_EMPID,DT_TERM_DATE,DAT_PFRESIGNDATE,CHR_PF,CHR_ESI,CHR_REASON,CHR_TER_TYPE, CHR_MODE ,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS )";
											asql = asql + "VALUES(?,?,?,?,?,?,?,?,?,DATE(NOW()),'Y')";
											apstm = con.prepareStatement(asql);
											apstm.setString(1, staffid);
											apstm.setString(2,DateUtil.FormateDateSQL(date));
											apstm.setString(3,DateUtil.FormateDateSQL(pfdate));
											apstm.setString(4,pdata[0][0]);
											apstm.setString(5,pdata[0][1]);
											apstm.setString(6,reason );
											apstm.setString(7,cessation );
											apstm.setString(8,mode );
											apstm.setString(9,userId);
											System.out.println(""+apstm);
											apstm.execute();
											
											asql = "UPDATE  com_m_staff  SET CHR_TYPE='T',CHR_E_STATUS='N' , DAT_RESIGNDATE=? , DAT_PFRESIGNDATE=? WHERE CHR_EMPID = ? ";
											apstm = con.prepareStatement(asql);
											apstm.setString(1,DateUtil.FormateDateSQL(date));
											apstm.setString(2,DateUtil.FormateDateSQL(pfdate));
											apstm.setString(3, staffid);
											System.out.println(""+apstm);
											apstm.execute();
											apstm.close();
											
											 
											acs = con.prepareCall("{call ATT_PRO_RESIGNER_EMPLOYEE_ABSENT_MARKING(?,?,?)}");
											acs.setString(1,staffid);
											acs.setString(2,DateUtil.FormateDateSQL(date));
											acs.setString(3,auserid);
											System.out.println(""+acs);
											acs.execute();
											
											asql = " INSERT INTO  pay_t_exitinterview (CHR_EMPID,DAT_CREATIONTIME ) VALUES (?, NOW()  )";
											apstm = con.prepareStatement(asql);
											apstm.setString(1, staffid);
											System.out.println(""+apstm);
											apstm.execute();
											apstm.close();
											
											
											asql = " INSERT INTO  pay_t_emp_ndc (CHR_EMPID,DAT_CREATION_DATE ) VALUES (?,NOW())";
											apstm = con.prepareStatement(asql);
											apstm.setString(1, staffid);
											System.out.println(""+apstm);
											apstm.execute();
											apstm.close();
											
											//NDC STORE CLOSED AUTOMATICALLY
											if(!CommonFunctions.RecordExist(con,"SELECT COUNT(*) FROM inv_t_asset WHERE CHR_EMPID ='"+staffid+"'  AND CHR_STATUS='N'"))
											{
												asql= " UPDATE pay_t_emp_ndc SET DOU_STORE =?,CHR_STORE =?, CHR_STORE_DESC=?, CHR_STORE_EMPID=?,  DAT_STORE_DATE=? WHERE CHR_EMPID=?";
												apstm  = con.prepareStatement(asql);
												apstm.setString(1,"0" );
												apstm.setString(2,"Y" );
												apstm.setString(3,"AUTOMATIC" );
												apstm.setString(4,""+session.getAttribute("EMPID") );
												apstm.setString(5,DateUtil.getCurrentDate() );
												apstm.setString(6,staffid );
												System.out.println(""+apstm);
												apstm.execute();
												apstm.close();
											}
											
											//NDC FOR BUSINESS
											boolean aflag = false;
											boolean cflag = false;
											asql="SELECT sum(INT_ADVAMT) FROM pay_m_advance WHERE CHR_EMPID='"+staffid+"' ";
											String advdata[][] = CommonFunction.doubleRecordSetArray(asql);
											double advance=0.0;
											double dtection=0.0;
											if(advdata.length>0)
												advance=Double.parseDouble(advdata[0][0]);
											asql="SELECT sum(INT_DUEAMT) FROM pay_t_advance WHERE CHR_EMPID='"+staffid+"' ";
											String detectdata[][] = CommonFunction.doubleRecordSetArray(asql);
											if(detectdata.length>0)
												dtection=Double.parseDouble(detectdata[0][0]);

											if((advance-dtection)>0)
												aflag = true;
											
											asql = " select count(*) from conveyance_t_conveyance a, com_m_staff b WHERE a.CHR_EMPID =b.CHR_EMPID AND a.CHR_STATUS='N' and a.CHR_EMPID  = '"+staffid+"' group by a.CHR_EMPID ORDER BY  b.CHR_STAFFNAME ";
											String conveyance[][] = CommonFunctions.QueryExecute(asql);
											if(conveyance.length>0)
												cflag = true;
											if(aflag == false  && cflag ==false)
											{
												asql= " UPDATE pay_t_emp_ndc SET DOU_ACCOUNTS =?,CHR_ACCOUNTS =?, CHR_ACCOUNTS_DESC=?, CHR_ACCOUNTS_EMPID=?,  DAT_ACCOUNTS_DATE=? WHERE CHR_EMPID=?";
												apstm  = con.prepareStatement(asql);
												apstm.setString(1,"0" );
												apstm.setString(2,"Y" );
												apstm.setString(3,"AUTOMATIC" );
												apstm.setString(4,""+session.getAttribute("EMPID") );
												apstm.setString(5,DateUtil.getCurrentDate() );
												apstm.setString(6,staffid );
												apstm.execute();
												apstm.close();
											}
											
											//NDC BUSINESS CLOSED AUTOMATICALLY
											if(!CommonFunctions.RecordExist(con,"SELECT COUNT(*) FROM inv_t_asset WHERE CHR_EMPID ='"+staffid+"'  AND CHR_STATUS='N'"))
											{
												asql= " UPDATE pay_t_emp_ndc SET DOU_GENERAL =?, CHR_GENERAL =?, CHR_GENERAL_DESC=?, CHR_GENERAL_EMPID=?,  DAT_GENERAL_DATE=? WHERE CHR_EMPID=?";
												apstm  = con.prepareStatement(asql);
												apstm.setString(1,"0" );
												apstm.setString(2,"Y" );
												apstm.setString(3,"AUTOMATIC" );
												apstm.setString(4,""+session.getAttribute("EMPID") );
												apstm.setString(5,DateUtil.getCurrentDate() );
												apstm.setString(6,staffid );
												System.out.println(""+apstm);
												apstm.execute();
												apstm.close();
											}
											
											//Mail generation
											StaffCessationMail.sendStaffCessationMail(staffid, branchid, Path);
											 
											
											
											con.close();   
											response.sendRedirect("Smart Payroll/EmployeeCessation.jsp");
										}
										else
										{
											//please check reporting head 
											con.close();  
											response.sendRedirect("Smart Payroll/ReportingTo.jsp?er=Kindly check, Some employees are reporting to him/her&repto="+staffid);
											//response.sendRedirect("Smart Payroll/CessationAdd.jsp?er=Kindly check, Some employees are reporting to him/her");
										}
									}
									else
									{
										//please check conveyance entry for staff
										con.close();  
										//response.sendRedirect("Smart Payroll/CessationAdd.jsp?er=Kindly check, He/She conveyance entries are not accepted");
										response.sendRedirect("Smart Payroll/CessationConveyancePending.jsp?staffid="+staffid+"&er=Kindly check,conveyance entries are not accepted");
									}
								}
								else
								{
									//please clear the conveyance clear for Reporting head
									con.close();  
									//response.sendRedirect("Smart Payroll/CessationAdd.jsp?er=Kindly check, Conveyance should be cleared for some employees ");
									response.sendRedirect("Smart Payroll/CessationConveyancePendinginReportinghead.jsp?staffid="+staffid+"&er=Kindly check, Conveyance should be cleared for reporting employees ");
								}
							}
							else
							{
								 
								asql ="INSERT INTO att_t_register"; 
			                    asql = asql +" (CHR_EMPID,CHR_MONTH,INT_YEAR,CHR_USRNAME,DT_UPDATEDATE,DAT_CREATEDATE,CHR_UPDATESTATUS)";  
			                    asql = asql +"  VALUES(?,MONTHNAME(NOW()),YEAR(NOW()),?,DATE(NOW()),NOW(),'Y');";
			                    apstm = con.prepareStatement(asql);
			        			apstm.setString(1,staffid);
			        			apstm.setString(2,auserid);
			        			System.out.println(apstm);
			        			apstm.execute();
			        			apstm.close();
			        			
			        			acs = con.prepareCall("{call  ATT_PRO_REGISTER_SUNDAY_MARKING( ?)}");
			    				acs.setString(1, auserid);
			    				acs.execute();
			    				acs.close();
			    				
			    				 
			    		        
			    				String fromdtsql = DateUtil.FormateDateSQLFromOne(date);
			    				String todasql = DateUtil.FormateDateSQL(date);
			    				String dates[] = CommonFunctions.QueryExecute("SELECT FIND_A_DAYS_BETWEEN_TWO_DAYS_EXPECT_SUNDAY('"	+ fromdtsql + "','" + todasql + "')")[0][0].split(",");
			    				asql = " UPDATE att_t_register SET ";
			    				for (int y = 0; y < dates.length; y++)
			    					asql = asql + " CHR_MORNING"+ Integer.parseInt(dates[y].split("-")[2].trim())+ " = 'PRE' , CHR_EVENING"	+ Integer.parseInt(dates[y].split("-")[2].trim())+ "='PRE' , ";
			    				asql = asql + " CHR_USRNAME='" + auserid	+ "',DAT_MODIFIEDDATE=NOW(),";
			    				asql = asql + " CHR_UPDATESTATUS='Y' ";
			    				asql = asql	+ "   WHERE CHR_EMPID=? AND CHR_MONTH =?  AND INT_YEAR=?  ";
			    				asql = asql.trim();
			    				apstm = con.prepareStatement(asql);
			    				apstm.setString(1, staffid);
			    				apstm.setString(2, monthname);
			    				apstm.setInt(3, year);
			    				System.out.println(apstm);
			    				System.out.println("Entry : "  + "/" + staffid+ "   " + apstm);
			    				apstm.execute();
			    				apstm.close();
								
								//please check attendance register
								con.close();   
								//response.sendRedirect("Smart Payroll/CessationAdd.jsp?er=Kindly check, Attendance register - "+daysInloop+" not close");
								response.sendRedirect("Smart Payroll/CessationAttendanceRegister.jsp?staffid="+staffid+"&month="+date.split("-")[1]+"&year="+year+"&er=Blank Available, Kindly Check the Attendance");
							}
						}
						else
						{
							//"please check date of joinning and date of resignning
							con.close();  
							response.sendRedirect("Smart Payroll/CessationAdd.jsp?er=Kindly check, Resigning  date should be greater than the joinning date");
						}
					}
					else
					{
						con.close();   
						response.sendRedirect("Smart Payroll/CessationAdd.jsp?er=Kindly check");
					}
					
				 	 
				} 
				catch (RuntimeException e) 
				{
					System.out.println("Cessation : "+e.getMessage());
					request.setAttribute("error", e.getMessage() );
		            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
		    		dispatchers.forward(request, response); 
				}
					
					
			}
			else if(action.equals("PAYStaffCessationMove"))
			{

				String staffid = ("" + request.getParameter("ename")).trim();
				String cessation = "" + request.getParameter("cessation");
				String date = "" + request.getParameter("date");
				String pfdate = "" + request.getParameter("pfdate");
				String reason = "" + request.getParameter("reason");
				String pdata[][] =CommonFunctions.QueryExecute("SELECT CHR_PF,CHR_ESI,('"+DateUtil.FormateDateSQL(date)+"' > DT_DOJCOLLEGE) from com_m_staff WHERE CHR_EMPID ='"+staffid+"'");
				
				
				try 
				{	
				 
					if( (pdata.length>0) && (!"ADMIN".equals(staffid)) )
					{
						if( "1".equals(pdata[0][2]))
						{
							
							int daysInloop = Integer.parseInt(date.split("-")[0]);
							String monthname = DateUtil.getMonth(Integer.parseInt(date.split("-")[1]));
							int year =Integer.parseInt(date.split("-")[2]);
							boolean attregisterflag=true;
							 
							//Attendance Register check
							asql = " SELECT COUNT(*) from att_t_register  WHERE  CHR_MONTH='"+monthname+"' AND INT_YEAR="+year+" AND CHR_EMPID = '"+staffid+"' ";
							attregisterflag = CommonFunctions.RecordExist(con, asql);
							
							if(attregisterflag)
							{
								asql=" SELECT ( ";
								for(int i=1;i<=daysInloop;i++)
									asql = asql+" (CHR_MORNING"+i+"='0') OR (CHR_EVENING"+i+"='0') OR ";
								asql=asql.trim();
								asql = asql.substring(0,asql.length()-2);	
								asql=asql+" ) ";
								asql = asql+" FROM att_t_register WHERE CHR_EMPID='"+staffid+"' AND CHR_MONTH='"+monthname+"' AND INT_YEAR="+year;
								System.out.println(asql);
								if("1".equals(CommonFunctions.QueryExecutecon(con, asql)[0][0]))
									attregisterflag = false;
							}
							
							
							//conveyance clear
							asql ="SELECT COUNT(*) from conveyance_t_conveyance a, com_m_staff b  WHERE a.CHR_EMPID in(SELECT CHR_EMPID FROM ";
							asql = asql + " com_m_staff WHERE CHR_REPTO='"+staffid+"'  order by CHR_STAFFNAME ) "; 
							asql = asql +" AND a.CHR_EMPID =b.CHR_EMPID AND CHR_STATUS='N'  group by a.CHR_EMPID ORDER BY  b.CHR_STAFFNAME ";
							boolean conveyanceclearflag = CommonFunctions.RecordExist(con, asql);
											
							//conveyance entry
							asql = " SELECT COUNT(*) from conveyance_t_conveyance  WHERE  CHR_STATUS='N'  AND CHR_EMPID = '"+staffid+"' ";
							boolean conveyanceentryflag = CommonFunctions.RecordExist(con, asql);
								
							//reporting head
							asql = "SELECT COUNT(*) FROM  com_m_staff WHERE   CHR_TYPE !='T' AND CHR_REPTO ='"+staffid+"'";
							boolean reportingheadflag = CommonFunctions.RecordExist(con, asql);
							
							if(attregisterflag)
							{
								if(!conveyanceclearflag)
								{
									if(!conveyanceentryflag)
									{	
										if(!reportingheadflag)
										{
											//cessation process
											asql = " DELETE FROM pay_m_emp_termination WHERE CHR_EMPID = ? ";
											apstm = con.prepareStatement(asql);
											apstm = con.prepareStatement(asql);
											apstm.setString(1, staffid);
											System.out.println(""+apstm);
											apstm.execute();
											
											asql = " INSERT INTO pay_m_emp_termination (";
											asql = asql + " CHR_EMPID,DT_TERM_DATE,DAT_PFRESIGNDATE,CHR_PF,";
											asql = asql + " CHR_ESI,CHR_REASON,CHR_TER_TYPE,CHR_MODE, ";
											asql = asql + " CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS )";
											asql = asql + "VALUES(?,?,?,?,?,?,?,'P',?,DATE(NOW()),'Y')";
											apstm = con.prepareStatement(asql);
											apstm.setString(1, staffid);
											apstm.setString(2,DateUtil.FormateDateSQL(date));
											apstm.setString(3,DateUtil.FormateDateSQL(pfdate));
											apstm.setString(4,pdata[0][0]);
											apstm.setString(5,pdata[0][1]);
											apstm.setString(6,reason );
											apstm.setString(7,cessation );
											apstm.setString(8,userId);
											System.out.println(""+apstm);
											apstm.execute();
											
											
											asql = "UPDATE  com_m_staff  SET CHR_TYPE='T',CHR_E_STATUS='N' , DAT_RESIGNDATE=? , DAT_PFRESIGNDATE=? WHERE CHR_EMPID = ? ";
											apstm = con.prepareStatement(asql);
											apstm.setString(1,DateUtil.FormateDateSQL(date));
											apstm.setString(2,DateUtil.FormateDateSQL(pfdate));
											apstm.setString(3, staffid);
											System.out.println(""+apstm);
											apstm.execute();
											apstm.close();
											
											asql = "UPDATE pay_t_resignationletter SET CHR_CESSATION_STATUS=? WHERE CHR_EMPID=?" ;
											apstm = con.prepareStatement(asql);
											apstm.setString(1, "Y");
											apstm.setString(2, staffid);
											System.out.println(""+apstm);
											apstm.execute();
											apstm.close();
											
											
											
											acs = con.prepareCall("{call ATT_PRO_RESIGNER_EMPLOYEE_ABSENT_MARKING(?,?,?)}");
											acs.setString(1,staffid);
											acs.setString(2,DateUtil.FormateDateSQL(date));
											acs.setString(3,auserid);
											System.out.println(""+acs);
											acs.execute();
											
											asql = " INSERT INTO  pay_t_exitinterview (CHR_EMPID,DAT_CREATIONTIME ) VALUES (?, NOW()  )";
											apstm = con.prepareStatement(asql);
											apstm.setString(1, staffid);
											System.out.println(""+apstm);
											apstm.execute();
											apstm.close();
											
											
											asql = " INSERT INTO  pay_t_emp_ndc (CHR_EMPID,DAT_CREATION_DATE ) VALUES (?,NOW())";
											apstm = con.prepareStatement(asql);
											apstm.setString(1, staffid);
											System.out.println(""+apstm);
											apstm.execute();
											apstm.close();
											
											
											asql = "UPDATE pay_t_resignationletter SET CHR_CESSATION_STATUS='Y' WHERE CHR_EMPID=? ";
											apstm = con.prepareStatement(asql);
											apstm.setString(1, staffid);
											System.out.println(""+apstm);
											apstm.execute();
											apstm.close();
											
											
											//NDC STORE CLOSED AUTOMATICALLY
											if(!CommonFunctions.RecordExist(con,"SELECT COUNT(*) FROM inv_t_asset WHERE CHR_EMPID ='"+staffid+"'  AND CHR_STATUS='N'"))
											{
												asql= " UPDATE pay_t_emp_ndc SET DOU_STORE =?,CHR_STORE =?, CHR_STORE_DESC=?, CHR_STORE_EMPID=?,  DAT_STORE_DATE=? WHERE CHR_EMPID=?";
												apstm  = con.prepareStatement(asql);
												apstm.setString(1,"0" );
												apstm.setString(2,"Y" );
												apstm.setString(3,"AUTOMATIC" );
												apstm.setString(4,""+session.getAttribute("EMPID") );
												apstm.setString(5,DateUtil.getCurrentDate() );
												apstm.setString(6,staffid );
												System.out.println(""+apstm);
												apstm.execute();
												apstm.close();
											}
											
											//NDC FOR BUSINESS
											boolean aflag = false;
											boolean cflag = false;
											asql="SELECT sum(INT_ADVAMT) FROM pay_m_advance WHERE CHR_EMPID='"+staffid+"' ";
											String advdata[][] = CommonFunction.doubleRecordSetArray(asql);
											double advance=0.0;
											double dtection=0.0;
											if(advdata.length>0)
												advance=Double.parseDouble(advdata[0][0]);
											asql="SELECT sum(INT_DUEAMT) FROM pay_t_advance WHERE CHR_EMPID='"+staffid+"' ";
											String detectdata[][] = CommonFunction.doubleRecordSetArray(asql);
											if(detectdata.length>0)
												dtection=Double.parseDouble(detectdata[0][0]);

											if((advance-dtection)>0)
												aflag = true;
											
											asql = " select count(*) from conveyance_t_conveyance a, com_m_staff b WHERE a.CHR_EMPID =b.CHR_EMPID AND a.CHR_STATUS='N' and a.CHR_EMPID  = '"+staffid+"' group by a.CHR_EMPID ORDER BY  b.CHR_STAFFNAME ";
											String conveyance[][] = CommonFunctions.QueryExecute(asql);
											if(conveyance.length>0)
												cflag = true;
											if(aflag == false  && cflag ==false)
											{
												asql= " UPDATE pay_t_emp_ndc SET DOU_ACCOUNTS =?,CHR_ACCOUNTS =?, CHR_ACCOUNTS_DESC=?, CHR_ACCOUNTS_EMPID=?,  DAT_ACCOUNTS_DATE=? WHERE CHR_EMPID=?";
												apstm  = con.prepareStatement(asql);
												apstm.setString(1,"0" );
												apstm.setString(2,"Y" );
												apstm.setString(3,"AUTOMATIC" );
												apstm.setString(4,""+session.getAttribute("EMPID") );
												apstm.setString(5,DateUtil.getCurrentDate() );
												apstm.setString(6,staffid );
												apstm.execute();
												apstm.close();
											}
											
											//NDC BUSINESS CLOSED AUTOMATICALLY
											if(!CommonFunctions.RecordExist(con,"SELECT COUNT(*) FROM inv_t_asset WHERE CHR_EMPID ='"+staffid+"'  AND CHR_STATUS='N'"))
											{
												asql= " UPDATE pay_t_emp_ndc SET DOU_GENERAL =?, CHR_GENERAL =?, CHR_GENERAL_DESC=?, CHR_GENERAL_EMPID=?,  DAT_GENERAL_DATE=? WHERE CHR_EMPID=?";
												apstm  = con.prepareStatement(asql);
												apstm.setString(1,"0" );
												apstm.setString(2,"Y" );
												apstm.setString(3,"AUTOMATIC" );
												apstm.setString(4,""+session.getAttribute("EMPID") );
												apstm.setString(5,DateUtil.getCurrentDate() );
												apstm.setString(6,staffid );
												System.out.println(""+apstm);
												apstm.execute();
												apstm.close();
											}
											
											
											//Mail generation
											StaffCessationMail.sendStaffCessationMail(staffid, branchid, Path);
											 
											
											
											con.close();   
											response.sendRedirect("Smart Payroll/ResignationView.jsp");
										}
										else
										{
											//please check reporting head 
											con.close();  
											response.sendRedirect("Smart Payroll/MovetoCessation.jsp?staffid="+staffid+"&er=Kindly check, Some employees are reporting to him/her");
										}
									}
									else
									{
										//please check conveyance entry
										con.close();  
										response.sendRedirect("Smart Payroll/MovetoCessation.jsp?staffid="+staffid+"&er=Kindly check, He/She conveyance entries are not accepted");
									
									}
								}
								else
								{
									//please clear the conveyance clear
									con.close();  
									response.sendRedirect("Smart Payroll/MovetoCessation.jsp?staffid="+staffid+"&er=Kindly check, Conveyance should be cleared for some employees ");
								}
							}
							else
							{
								//please check attendance register
								con.close();  
								response.sendRedirect("Smart Payroll/MovetoCessation.jsp?staffid="+staffid+"&er=Kindly check, Attendance register - "+daysInloop+" not close");
							}
						}
						else
						{
							//"please check date of joinning and date of resignning
							con.close();  
							response.sendRedirect("Smart Payroll/MovetoCessation.jsp?staffid="+staffid+"&er=Kindly check, Resigning  date should be greater than the joinning date");
						}
					}
					else
					{
						con.close();   
						response.sendRedirect("Smart Payroll/MovetoCessation.jsp?staffid="+staffid+"&er=Kindly check");
					}
					
				 	 
					} 
					catch (RuntimeException e) 
					{
						System.out.println(e.getMessage());
						request.setAttribute("error", e.getMessage() );
			            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
			    		dispatchers.forward(request, response); 
					}
					
					
			
			}
			else if (action.equals("PAYStaffCessationUpdate")) 
			{
				String staffid = "" + request.getParameter("staffid");
				staffid.trim();
				String cessation = "" + request.getParameter("cessation");
				String date = "" + request.getParameter("date");
				String pfdate = "" + request.getParameter("pfdate");
				date = DateUtil.FormateDateSQL(date);
				pfdate=DateUtil.FormateDateSQL(pfdate);
				String reason = "" + request.getParameter("reason");
				
				String pdata[][] =CommonFunctions.QueryExecute("SELECT CHR_PF,CHR_ESI from com_m_staff WHERE CHR_EMPID ='"+staffid+"'");
				 
				
				asql =  " UPDATE  pay_m_emp_termination SET ";
				asql = asql + " DT_TERM_DATE = ? , ";
				asql = asql + " DAT_PFRESIGNDATE = ? , CHR_PF=?, CHR_ESI=?,";
				asql = asql + " CHR_REASON = ? , ";
				asql = asql + " CHR_TER_TYPE = ? ";
				asql = asql + " WHERE CHR_EMPID = ? ";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,date);
				apstm.setString(2,pfdate);
				apstm.setString(3,pdata[0][0] );
				apstm.setString(4,pdata[0][1] );
				apstm.setString(5, reason);
				apstm.setString(6, cessation);
				apstm.setString(7, staffid);
				apstm.execute();
				
				asql="UPDATE  com_m_staff  SET CHR_TYPE='T',CHR_E_STATUS='N', DAT_RESIGNDATE=? ,DAT_PFRESIGNDATE=? WHERE CHR_EMPID =? ";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,date);
				apstm.setString(2,pfdate);
				apstm.setString(3, staffid);
				apstm.execute();
				apstm.close();
				
				con.close();   
				response.sendRedirect("Smart Payroll/EmployeeCessation.jsp");
			} 
			else if (action.equals("PAYStaffCessationDelete")) 
			{
				String staff[] = request.getParameterValues("staffid");
				String reason  = request.getParameter("reason");
				
				String sql = "";
				for (int i = 0; i < staff.length; i++) 
				{
					asql = " SELECT DAY(DT_TERM_DATE),MONTH(DT_TERM_DATE),MONTHNAME(DT_TERM_DATE),YEAR(DT_TERM_DATE),DATE_FORMAT(DT_TERM_DATE,'%Y-%m-%d'),CHR_MODE FROM pay_m_emp_termination WHERE CHR_EMPID = '"+staff[i]+"'";
					String data[][] = CommonFunctions.QueryExecute(asql);
					if(data.length>0)
					{
						int day= Integer.parseInt(data[0][0]);
						day = day+1;
						asql = "UPDATE att_t_register SET ";
						for(int u=day;u<=31;u++)
						{
							if(u<10)
								sql= "SELECT if(DAYNAME('"+data[0][3]+"-"+data[0][1]+"-0"+u+"') ='Sunday' ,'1','0') ";
							else
								sql= "SELECT if(DAYNAME('"+data[0][3]+"-"+data[0][1]+"-"+u+"') ='Sunday' ,'1','0') ";
							if("0".equals(CommonFunctions.QueryExecute(sql)[0][0]))
								asql = asql + " CHR_MORNING"+u+" ='0' ,  CHR_EVENING"+u+"='0'  , ";
							else
								asql = asql + " CHR_MORNING"+u+" ='SUN' ,  CHR_EVENING"+u+"='SUN'  , ";
						}
						asql = asql + " DT_UPDATEDATE =DATE(NOW()) , CHR_USRNAME ='"+auserid+"', CHR_UPDATESTATUS= 'Y'";
						asql = asql + "  WHERE CHR_EMPID =? AND CHR_MONTH=? AND INT_YEAR=?";
						apstm = con.prepareStatement(asql);
						apstm.setString(1, staff[i]);
						apstm.setString(2,data[0][2] );
						apstm.setString(3,data[0][3] );
						apstm.execute();
					}
					
					String termdate= data[0][4] ;
					asql = "SELECT (  (MONTH(NOW())= MONTH('"+termdate+"') )  AND (YEAR(NOW())= YEAR('"+termdate+"') )     )";
					if("0".equals(CommonFunctions.QueryExecute(asql)[0][0]))
					{
						asql = "SELECT COUNT(*) FROM att_t_register  WHERE CHR_EMPID ='"+staff[i]+"' AND CHR_MONTH =MONTHNAME(NOW()) AND INT_YEAR=YEAR(NOW())";
						if(!CommonFunctions.RecordExist(con, asql))
						{
							asql = " INSERT INTO att_t_register (CHR_EMPID,CHR_MONTH,INT_YEAR) ";
							asql = asql + " VALUES('"+staff[i]+"',MONTHNAME(NOW()) ,YEAR(NOW()) )";
							apstm = con.prepareStatement(asql);
							apstm.execute();
							
							String sundays[] = CommonFunctions.QueryExecute(" SELECT FIND_A_SUNDAY("+data[0][1]+","+data[0][3]+")")[0][0].split(",");
							asql= " UPDATE att_t_register SET ";
							for(int y=0; y<sundays.length;y++)
								asql = asql +" CHR_MORNING"+sundays[y]+" ='SUN' , CHR_EVENING"+sundays[y]+"='SUN',  ";
							asql = asql +" DT_UPDATEDATE=DATE(NOW()),CHR_USRNAME='"+auserid+"',CHR_UPDATESTATUS='Y' ";
							asql = asql +" WHERE CHR_MONTH ='"+data[0][2]+"' AND INT_YEAR="+data[0][3];
							asql = asql +" AND CHR_EMPID ='"+staff[i]+"'";
							System.out.println(asql);
							apstm = con.prepareStatement(asql);
							apstm.execute();
						}
						
					}
					if(data.length>0)
						if("P".equals(data[0][5]))
						{
							asql = "UPDATE pay_t_resignationletter SET CHR_CESSATION_STATUS=? WHERE CHR_EMPID=?" ;
							apstm = con.prepareStatement(asql);
							apstm.setString(1, "N");
							apstm.setString(2, staff[i]);
							System.out.println(""+apstm);
							apstm.execute();
							apstm.close();
						}
					
					asql = " DELETE FROM pay_m_emp_termination  WHERE CHR_EMPID = ? ";
					apstm = con.prepareStatement(asql);
					apstm.setString(1, staff[i]);
					apstm.execute();
					
					asql = " DELETE FROM pay_t_exitinterview  WHERE CHR_EMPID = ? ";
					apstm = con.prepareStatement(asql);
					apstm.setString(1, staff[i]);
					apstm.execute();
					
					asql = " DELETE FROM pay_t_emp_ndc  WHERE CHR_EMPID = ? ";
					apstm = con.prepareStatement(asql);
					apstm.setString(1, staff[i]);
					apstm.execute();
					
					asql = " DELETE FROM pay_t_resignationletter  WHERE CHR_EMPID = ? ";
					apstm = con.prepareStatement(asql);
					apstm.setString(1, staff[i]);
					apstm.execute();
					
					asql = " DELETE FROM pay_t_temporarysuspension  WHERE CHR_EMPID = ? ";
					apstm = con.prepareStatement(asql);
					apstm.setString(1, staff[i]);
					apstm.execute();
					
 					asql = "UPDATE  com_m_staff  SET CHR_TYPE='Permanent',CHR_E_STATUS='Y',  CHR_USERNAME='"+userId+"' , DT_UPDATEDATE=DATE(NOW()),DAT_RESIGNDATE=null, DAT_PFRESIGNDATE=null WHERE CHR_EMPID =? ";
					apstm = con.prepareStatement(asql);
					apstm.setString(1, staff[i]);
					apstm.execute();
					
					//Mail generation
					StaffCessationMail.deletedStaffCessationMail(staff[i], branchid, Path,reason );
					
					
					//insert the delete tracking 
					String remoteadress = request.getRemoteAddr();
					InetAddress inetAddress = InetAddress.getByName(request.getRemoteAddr());
					String inetaddress = inetAddress.getHostName();
			 		reason = reason+"/ "+ remoteadress +" / "+inetaddress;
			 		
			        System.out.println("comp name::"+java.net.InetAddress.getLocalHost().getHostName());
					asql = "INSERT INTO pay_t_emp_terminationdelete (CHR_EMPID,DT_DELETEDATE,CHR_REASON,CHR_USERNAME,DT_UPDATEDATE,CHR_UPDATESTATUS) ";
					asql = asql + " VALUES (?,NOW(),?,?,NOW(),'Y') ";
					apstm = con.prepareStatement(asql);
					apstm.setString(1, staff[i]);
					apstm.setString(2, reason);
					apstm.setString(3, auserid);
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
					
					 
				}
				con.close();   
				response.sendRedirect("Smart Payroll/EmployeeCessation.jsp");
			}
			else if (action.equals("PAYStaffCessationPDF")) 
			{
				ResignLetter(request, response);
			}
			else if (action.equals("PAYStaffCessationIssue")) 
			{
				 String empid = request.getParameter("empid");
				 String issuedate = request.getParameter("date");
				 String description = request.getParameter("");
				 asql = "UPDATE pay_t_emp_ndc SET ";
				 asql = asql +"  CHR_ISSUE=?, DAT_ISSUE=?, CHE_ISSUE_DESC=?, CHR_ISSUEDBY =? WHERE CHR_EMPID=?";
				 apstm = con.prepareStatement(asql);
				 apstm.setString(1,"Y" );
				 apstm.setString(2,DateUtil.FormateDateSQL(issuedate) );
				 apstm.setString(3, description);
				 apstm.setString(4,loginempid );
				 apstm.setString(5,empid );
				 System.out.println(""+apstm);
				 apstm.execute();
				 apstm.close();
				 con.close();
				 response.sendRedirect("Smart Payroll/EmployeeCessation.jsp");
				 
			}
			
			else if (action.equals("PAYStaffExitInterview")) 
			{
				 String staffid = request.getParameter("staffid");
				 asql = "";
				 asql = "UPDATE pay_t_exitinterview SET  ";
				 asql = asql + " DAT_INTERVIEWDATE=DATE(NOW()),CHR_STATUS='Y',CHR_USRNAME=?, ";
				 asql = asql + " DT_UPDATEDATE=DATE(NOW()),CHR_UPDATESTATUS='Y'  WHERE CHR_EMPID=?";
				 apstm = con.prepareStatement(asql);
				 apstm.setString(1, auserid);
				 apstm.setString(2, staffid);
				 apstm.execute();
				 apstm.close();
				 con.close();
				 response.sendRedirect("Smart Payroll/EmployeeCessation.jsp");
				 
			}

		} 
		catch (Exception e) 
		{
			System.out.println("Cessation : "+e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
				
		}
	}
	
	public static void cessationsendtoMail( String recipients[] ,String subject,String content)
    {
    	try
    	{
    		boolean debug = false;
    		String hData[][] =  CommonFunctions.QueryExecute("SELECT CHR_HOST,CHR_USERID,CHR_PASSWORD,CHR_MAILID FROM  m_mailsetting WHERE INT_MAILID = 1");
		    String host =hData[0][0]   ;
            String user =hData[0][1]   ;
            String password =hData[0][2]   ;
            String from =hData[0][3]   ;
             
            Properties props = new Properties();
  	        props.setProperty("mail.transport.protocol", "smtp");
  	        props.setProperty("mail.host", ""+host);
	        props.setProperty("mail.user", ""+user);
  	        props.setProperty("mail.password", ""+password);
  	        
  	        Session session = Session.getDefaultInstance(props, null);
  	        session.setDebug(debug); 
  	        Message msg = new MimeMessage(session);
  	        InternetAddress addressFrom = new InternetAddress(from);
  	        msg.setFrom(addressFrom);
  	        
            InternetAddress[] addressTo = new InternetAddress[recipients.length]; 
  	        for (int i = 0; i < recipients.length; i++)
  	    	   addressTo[i] = new InternetAddress(recipients[i]);
  	        msg.setRecipients(Message.RecipientType.BCC, addressTo);
  	        msg.addHeader("MyHeaderName", "myHeaderValue");
  	        msg.setSubject(subject);
  	        msg.setContent(content, "text/html");
  	        Transport.send(msg);
  	       

    	}
    	catch(Exception e)
    	{
    		 System.out.println(e.getMessage()); 
    	}
    }
	
	
	public static String  mailContent(  String staffid )
    {
    	String content="";
		try
    	{ 
    		
			content="";
			
						 						
			String asql = " ";
			asql = " SELECT a.CHR_EMPID,a.CHR_STAFFNAME,b.CHR_OFFICENAME,c.CHR_DEPARTNAME  ,DATE_FORMAT(e.DT_TERM_DATE,'%d-%b-%Y') ,e.CHR_REASON";
			asql = asql + " FROM com_m_staff a, com_m_office b, com_m_depart c, pay_t_emp_ndc d ,pay_m_emp_termination e ";
			asql = asql + " WHERE a.INT_OFFICEID =b.INT_OFFICEID ";
			asql = asql + " AND a.INT_DEPARTID = c.INT_DEPARTID ";
			asql = asql + " AND a.CHR_EMPID = d.CHR_EMPID   AND a.CHR_EMPID = e.CHR_EMPID  ";
			asql = asql + " AND a.CHR_EMPID='"+staffid+"' ";
			String data[][] = CommonFunctions.QueryExecute(asql);
					
			if(data.length>0)
			{
				content = content + " <style type='text/css'> ";
				content = content + " <!-- ";
				content = content + " .style1 { ";
				content = content + " color: #FFFF00; ";
				content = content + " font-weight: bold; ";
				content = content + " } ";
				content = content + ".boldEleven {  ";
				content = content + "	FONT-WEIGHT: normal;  ";
				content = content + "	FONT-SIZE: 10px;  ";
				content = content + "	COLOR: #000000;  ";
				content = content + "	LINE-HEIGHT: 15px;  ";
				content = content + "	FONT-FAMILY: Verdana;  ";
				content = content + "	TEXT-DECORATION: none;  ";
				content = content + "}  ";
				content = content + " --> ";
				content = content + " </style> ";
				content = content + " <table width='500' border='0' align='center' cellpadding='3' cellspacing='3' bgcolor='#006699'> ";
				content = content + " <tr> ";
				content = content + " <td><div align='center' class='style1'> ";
				content = content + " <h1>NDC CLOSE </h1> ";
				content = content + " </div></td> ";
				content = content + " </tr> ";
				content = content + " <tr> ";
				content = content + " <td bgcolor='#FFFFFF'><table width='100%' border='0' align='center' cellpadding='2' cellspacing='2'> ";
				content = content + " <tr> ";
				content = content + " <td>&nbsp;</td> ";
				content = content + " <td class='boldEleven'><b>EMP ID </td> ";
				content = content + " <td class='boldEleven'>"+data[0][0]+"</td> ";
				content = content + " <td>&nbsp;</td> ";
				content = content + " </tr> ";
				content = content + " <tr> ";
				content = content + " <td>&nbsp;</td> ";
				content = content + " <td class='boldEleven'><b>NAME</td> ";
				content = content + " <td class='boldEleven'>"+data[0][1]+"</td> ";
				content = content + " <td>&nbsp;</td> ";
				content = content + " </tr> ";
				content = content + " <tr> ";
				content = content + " <td>&nbsp;</td> ";
				content = content + " <td class='boldEleven'><b>OFFICE</td> ";
				content = content + " <td class='boldEleven'>"+data[0][2]+"</td> ";
				content = content + " <td>&nbsp;</td> ";
				content = content + " </tr> ";
				content = content + " <tr> ";
				content = content + " <td>&nbsp;</td> ";
				content = content + " <td class='boldEleven'><b>DEPARTMENT</td> ";
				content = content + " <td class='boldEleven'>"+data[0][3]+"</td> ";
				content = content + " <td>&nbsp;</td> ";
				content = content + " </tr> ";
				content = content + " <tr> ";
				content = content + " <td>&nbsp;</td> ";
				content = content + " <td class='boldEleven'><b>LAST WORKING DAY</td> ";
				content = content + " <td class='boldEleven'>"+data[0][4]+"</td> ";
				content = content + " <td>&nbsp;</td> ";
				content = content + " </tr> ";
				content = content + " <tr> ";
				content = content + " <td>&nbsp;</td> ";
				content = content + " <td class='boldEleven'><b>REASON</td> ";
				content = content + " <td class='boldEleven'>"+data[0][5]+"</td> ";
				content = content + " <td>&nbsp;</td> ";
				content = content + " </tr> ";
				//Advance
				asql="SELECT sum(INT_ADVAMT) FROM pay_m_advance WHERE CHR_EMPID='"+staffid+"' ";
				String advdata[][] = CommonFunction.doubleRecordSetArray(asql);
				double advance=0.0;
				double dtection=0.0;
				if(advdata.length>0)
					advance=Double.parseDouble(advdata[0][0]);


				asql="SELECT sum(INT_DUEAMT) FROM pay_t_advance WHERE CHR_EMPID='"+staffid+"' ";
				String detectdata[][] = CommonFunction.doubleRecordSetArray(asql);
				if(detectdata.length>0)
					dtection=Double.parseDouble(detectdata[0][0]);

				if((advance-dtection)>0)
				{
					content = content + " <tr> ";
					content = content + " <td>&nbsp;</td> ";
					content = content + " <td class='boldEleven'><b>ADVANCE</td> ";
					content = content + " <td class='boldEleven' bgcolor='#d9534f'>Advance Amount Rs."+(advance-dtection)+"</td> ";
					content = content + " <td>&nbsp;</td> ";
					content = content + " </tr> ";
				}
				//Asset
				if(CommonFunction.RecordExist("SELECT COUNT(*) FROM inv_t_asset WHERE CHR_EMPID ='"+staffid+"'  AND CHR_STATUS='N'"))
				{
					content = content + " <tr> ";
					content = content + " <td>&nbsp;</td> ";
					content = content + " <td class='boldEleven'><b>ASSET</td> ";
					content = content + " <td class='boldEleven'>";
					asql = " SELECT  b.CHR_ITEMNAME ,a.CHR_SERIALNO ,a.CHR_DESCRIPTION,DATE_FORMAT(a.DAT_CREATIONDATE,'%d-%b-%Y')  ";
					asql = asql + " FROM inv_t_asset a, inv_m_item b   ";
					asql = asql + " WHERE  b.CHR_ITEMID = a.CHR_ITEMID AND a.CHR_STATUS ='N'  ";
					asql = asql + " AND a.CHR_EMPID ='"+staffid+"'  ";
					String adata[][] = CommonFunctions.QueryExecute(asql);
					if(adata.length>0)
					{
						content = content + "<center>";
						content = content + "<table width='60%' cellpadding=2 cellspacing=1 bgcolor='#d9534f' >";
						content = content + "<tr >";
						content = content + "<td class='boldEleven' align='center'><b>S.No<b></td>";
						content = content + "<td class='boldEleven' align='center'><b>Item<b></td>";
						content = content + "<td class='boldEleven' align='center'><b>Serial<b></td>";
						content = content + "<td class='boldEleven' align='center'><b>Description<b></td>";
						content = content + "<td class='boldEleven' align='center'><b>Date<b></td>";
						content = content + "</tr>";
						
						for(int x=0;x<adata.length;x++)
						{
							content = content + "<tr >";
							content = content + "<td class='boldEleven' >"+(x+1)+"</td>";
							content = content + "<td class='boldEleven' >"+adata[0][0]+"</td>";
							content = content + "<td class='boldEleven' >"+adata[0][1]+"</td>";
							content = content + "<td class='boldEleven' >"+adata[0][2]+"</td>";
							content = content + "<td class='boldEleven' >"+adata[0][3]+"</td>";
							content = content + "</tr>" ;
						}
						content = content + "</table>" ;
						content = content + "</center>" ;
						
					content = content + " <td>&nbsp;</td> ";
					content = content + " </tr> ";
					}
					content = content + " </td>";
				}
				content = content + " </table></td> ";
				content = content + " </tr> ";
				content = content + " </table> ";

			}
	
			
			return content;
    		
    	}
    	catch(Exception e)
    	{
    		 
    		System.out.println(e.getMessage());
    	}
    	return content;
    }
	
	 
	

	private void ResignLetter(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
		try
		{         
			
			
			String sql="";
	   		String empid=request.getParameter("empid");
			
			Document document = new Document(); 
			document.addAuthor("CARE");
			document.addCreationDate();
			document.addCreator("SmartCampus");
			document.addTitle("CARE RESIGN LETTER");
			
			response.setContentType("application/octet-stream");
			response.setHeader("Content-Disposition", "attachment;filename=\"Resignletter_" +empid+".pdf\"");
			//response.setContentType("application/octet-stream");
			PdfWriter.getInstance(document, response.getOutputStream());
			
			document.open();
			 
			 
			
			    
			FontSelector fontselector = new FontSelector();
            fontselector.addFont(new Font(Font.TIMES_ROMAN, 12,Font.BOLD));
            Phrase ph = fontselector.process("\n\n\n SUB: RELIEVING ORDER CUM EXPERIENCE CERTIFICATE");
			Paragraph paragraph  = new Paragraph(ph);
			paragraph.setAlignment(Element.ALIGN_CENTER);
			document.add(paragraph);
			 
			
			
			sql =" SELECT a.CHR_EMPID,a.CHR_STAFFNAME,DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y'),DATE_FORMAT(c.DT_TERM_DATE,'%d-%b-%Y'),b.CHR_DESIGNAME, ";
	  		sql = sql + " if(a.CHR_GENDER= 'Male' ,'Mr.' , (if(a.CHR_MARITALSTATUS ='M', 'Mrs. ' ,'Miss. ' )) ), ";
	  		sql = sql + " if(a.CHR_GENDER= 'Male' ,'his' ,'her') , if(a.CHR_GENDER= 'Male' ,'he' ,'she') ";
	  		sql = sql + " FROM com_m_staff a, com_m_desig b, pay_m_emp_termination c ";
	  		sql = sql + " WHERE a.CHR_EMPID =c.CHR_EMPID AND a.INT_DESIGID = b.INT_DESIGID AND a.CHR_EMPID = '"+empid+"'";
	  		String data[][]=CommonFunctions.QueryExecute(sql);
	  		
	  		
	  		fontselector = new FontSelector();
	  		fontselector.addFont(new Font(Font.TIMES_ROMAN, 12 ));
			String content="\n\n\nFurther to your resignation letter, we are placed to inform you that you are relieved from your service effective "+ data[0][3]+".";
			fontselector.addFont(new Font(Font.TIMES_ROMAN, 12));
			ph = fontselector.process(content);
			paragraph  = new Paragraph(ph);
			paragraph.setAlignment(Element.ALIGN_LEFT);
			document.add(paragraph);
		
			
			content="\n We also certify "+data[0][5] +" " +data[0][1]+ " was employed in our organization as " +data[0][4]+"  from  "+data[0][2]+" to "+data[0][3]+".   During "+data[0][6]+" tenure in our organization "+data[0][7]+" was found to be efficient, hardworking and sincere in delivering "+data[0][6]+" duties to the organization and "+data[0][6]+" conduct was very good.";
			ph = fontselector.process(content);
			paragraph  = new Paragraph(ph);
			paragraph.setAlignment(Element.ALIGN_LEFT);
			document.add(paragraph);
			
			content="\n we wish you best of luck in the new assignment that you are taking up."  ;
			 
			ph = fontselector.process(content);
			paragraph  = new Paragraph(ph);
			paragraph.setAlignment(Element.ALIGN_LEFT);
			document.add(paragraph);
			 
			
			content="\nWishing you all the very best. ";
			ph = fontselector.process(content);
			paragraph  = new Paragraph(ph);
			paragraph.setAlignment(Element.ALIGN_LEFT);
			document.add(paragraph);
			
			content="\nYour's faithfully. ";
			ph = fontselector.process(content);
			paragraph  = new Paragraph(ph);
			paragraph.setAlignment(Element.ALIGN_LEFT);
			document.add(paragraph);
			
			
			content="\n\nFor Care IT Solutions Pvt Ltd,";
			ph = fontselector.process(content);
			paragraph  = new Paragraph(ph);
			paragraph.setAlignment(Element.ALIGN_LEFT);
			document.add(paragraph);
			
			
			content="\n\nAuthorized Signatory ";
			ph = fontselector.process(content);
			paragraph  = new Paragraph(ph);
			paragraph.setAlignment(Element.ALIGN_LEFT);
			document.add(paragraph);
			
			
            content="\n\n\nNote* \n[Background verifications is : "+CommonFunctions.getPath(request)+"/Employee Verififcation.jsp ]";
            fontselector = new FontSelector();
	  		fontselector.addFont(new Font(Font.TIMES_ROMAN, 12,Font.BOLD));
	  		ph = fontselector.process(content);
			paragraph  = new Paragraph(ph);
			paragraph.setAlignment(Element.ALIGN_JUSTIFIED);
			document.add(paragraph);
			 
			document.close(); 
			 
		}
		catch(Exception e)
		{         
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
			
		}     
		
	}
	 
}
