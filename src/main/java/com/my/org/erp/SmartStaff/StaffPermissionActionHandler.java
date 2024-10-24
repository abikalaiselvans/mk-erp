package com.my.org.erp.SmartStaff;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunction;
import com.my.org.erp.common.CommonFunctions;

public class StaffPermissionActionHandler extends AbstractActionHandler 
{
	java.text.SimpleDateFormat datetime = new java.text.SimpleDateFormat("yyyy-MM-dd");
	java.util.Date date = new java.util.Date();
	String updatedate = "" + datetime.format(date);
	@SuppressWarnings("deprecation")
	String year = "" + (1900 + date.getYear());
	String userid = "";
	private static String error="";
	private static boolean returnflag= true;
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			userid = "" + session.getAttribute("USRID");
			System.out.println("" + action);
			if (action.equals("STAStaffuserPermissionleave")) 
			{
				 
					StaffPermissionLeave(request, response);
					con.close();
					if(!returnflag)
						response.sendRedirect("Staff/errors.jsp?error="+error);
					else
						response.sendRedirect("Staff/ifStaffLeaveStatus.jsp");
				 
			}
		} 
		catch (Exception e) 
		{
		 
			request.setAttribute("error", e.getMessage() );
	 		RequestDispatcher dispatchers = request.getRequestDispatcher("/Staff/errors.jsp");
	 		dispatchers.forward(request, response); 
	 		System.out.println(e.getMessage());
		}
	}

	// 917699 7272

	// Leave or Permission Assign
	private void StaffPermissionLeave(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException 
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
			asql = asql+"  AND CHR_EMPID='"+staffid+"'   AND CHR_TYPE ='PERMISSION' ";
			if("P".equals(ApplyLeave))
				asql = asql+"  AND  DT_PDATE ='"+pdate1+"' ";
			else
				asql = asql+"  AND  DT_PDATE ='"+fdate1+"' ";
			System.out.println(asql+"/"+(CommonFunction.RecordExist(asql)));
			boolean pflag = CommonFunction.RecordExist(asql);
			
			asql = " SELECT COUNT(*) FROM att_m_onlineapplyleave WHERE CHR_EMPID='"+staffid+"' ";
			asql = asql+"  AND CHR_EMPID='"+staffid+"'    AND CHR_TYPE ='LEAVE'  ";
			if("P".equals(ApplyLeave))
				asql = asql+"  AND  DT_PDATE ='"+pdate1+"' ";
			else
				asql = asql+"  AND  DT_PDATE ='"+fdate1+"' ";
			
			System.out.println(asql+"/"+(CommonFunction.RecordExist(asql)));
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
							error = "Successfully inserted";
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
								error = "Successfully inserted";
							} 
							catch (RuntimeException e) 
							{
							
								error = ""+e.getMessage();
								returnflag = false;

							}
						}
					}
					else
					{
						error = "Already permission/ leave apply for the date "+DateUtil.FormateDateSys(pdate1) ;
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
							error = "Successfully inserted";
						} 
						catch (RuntimeException e) 
						{
							error = e.getMessage();
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
						error = "Successfully inserted";
					}
				
				}
				 
				
				
			}
			else if(  pflag && lflag)
			{
				error =  "Already permission/ leave apply for the date "+DateUtil.FormateDateSys(pdate1)  ;
				returnflag = false;
		    	 
			}
			
 			
		} 
		catch (Exception e) 
		{
			error = e.getMessage() ;
			returnflag = false;
		}
		 
	}
}
