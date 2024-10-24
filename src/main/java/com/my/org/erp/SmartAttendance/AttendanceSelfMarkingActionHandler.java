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
 
public class AttendanceSelfMarkingActionHandler extends AbstractActionHandler 
{
	Statement st;
	public synchronized void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		
		try 
		{

			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String userid = (String) session.getAttribute("USRID");
			 
			if (action.equals("ATTAttendanceSelfMarkingMove"))
			{ 
				try 
				{
					String month = request.getParameter("month");
					String year = request.getParameter("year");
					String length  = request.getParameter("dec");
					String accept="";
					String reject="";
					String rejectdec="";
					String hiddenField="";
					String status="";
					String empids="'0',";
					
					//SELF MARKING UPDATION
					asql = " UPDATE att_t_registerselfmarking SET CHR_STATUS =? ,  DAT_APPROVAL_TIME=NOW(), CHR_APPROVEDBY=? ,CHR_DESCRIPTION=?  ";
					asql = asql + " WHERE  CHR_STATUS ='N'   AND  INT_RNO =? ";
					apstm = con.prepareStatement(asql);
					for(int u=0;u<Integer.parseInt(length);u++)
					{
						accept = ""+request.getParameter("accept"+u);
						reject = ""+request.getParameter("reject"+u);
						rejectdec = ""+request.getParameter("dec"+u);
						hiddenField=request.getParameter("hiddenField"+u);
						empids =empids + "'"+request.getParameter("empid"+u)+"',";
						
						if( ("on".equals(accept))  ||   ("on".equals(reject)))
						{
							if("on".equals(accept))
								status = "Y";
							if("on".equals(reject))
								status = "R";
						
							apstm.setString(1,status);
							apstm.setString(2,userid);
							apstm.setString(3,rejectdec);
							apstm.setString(4,hiddenField );
							System.out.println(""+apstm);
							apstm.addBatch();
						}
					}
					apstm.executeBatch();
					apstm.close();
					
					//MOVE FROM SELF MARKING TO REGISTER
					asql = "";
					asql = " UPDATE att_t_register a,att_t_registerselfmarking b SET ";
					for(int u=1;u<=31;u++)
						asql = asql + " a.CHR_MORNING"+u+" = b.CHR_MORNING"+u+" ,a.CHR_EVENING"+u+"=b.CHR_EVENING"+u+", ";
					asql = asql + " DAT_MODIFIEDDATE =NOW() "; 
					asql = asql + " WHERE a.CHR_EMPID = b.CHR_EMPID ";
					asql = asql + " AND a.CHR_MONTH  = b.CHR_MONTH ";
					asql = asql + " AND a.INT_YEAR  =  b.INT_YEAR ";
					asql = asql + " AND b.CHR_STATUS = 'Y' ";
					asql = asql + " AND b.CHR_MONTH = '"+month+"' ";
					asql = asql + " AND b.INT_YEAR = "+ year; 
					asql = asql + " AND b.CHR_EMPID IN  ("+empids+" '0' ) ";
					apstm = con.prepareStatement(asql);
					System.out.println(apstm);
					apstm.execute();
					apstm.close();
					
					con.close();    
					response.sendRedirect("Smart Attendance/AttendanceSelfMarkingView.jsp");
				} 
				catch (Exception e) 
				{
					System.out.println(e.getMessage());
					e.printStackTrace();
				}
				
 				
			}
			else if ("ATTAttendanceSelfMarkingReset".equals(action ) )
			{ 
				try 
				{
					
					String rowid  = request.getParameter("rowid");
					asql = " UPDATE att_t_registerselfmarking SET CHR_STATUS =?   ";
					asql = asql + " WHERE  INT_RNO =? ";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,"N");
					apstm.setString(2,rowid);
					System.out.println(""+apstm);
					apstm.execute();
					con.close();    
					response.sendRedirect("Smart Attendance/AttendanceSelfMarkingView.jsp");
				} 
				catch (Exception e) 
				{
					System.out.println(e.getMessage());
					e.printStackTrace();
				}
			}
			else if ("ATTAttendanceApprovalReset".equals(action ) )
			{ 
				try 
				{
					String officeid=request.getParameter("Office");
					String Category=request.getParameter("Category");
					String dept = ""+request.getParameter("dept");
					String mont=request.getParameter("month");
					String month=DateUtil.getMonth(Integer.parseInt(mont));
					String year=request.getParameter("year");
					String officeids = CommonFunctions.QueryExecute("SELECT a.CHR_OFFICELIST FROM m_user a WHERE a.CHR_USRNAME='"+""+session.getAttribute("USRID")+"' ")[0][0];
	    		 	String catids = CommonFunctions.QueryExecute("SELECT a.CHR_GATEGORYLIST FROM m_user a WHERE a.CHR_USRNAME='"+session.getAttribute("USRID")+"' ")[0][0]+",0";
	    		 	asql = " UPDATE    att_t_registerselfmarking a , com_m_staff b  SET a.CHR_STATUS='N'     ";
					asql = asql+ " WHERE  b.CHR_EMPID=a.CHR_EMPID  ";
					if(!"0".equals(officeid))
						asql=asql + " AND b.INT_OFFICEID="+officeid;
					else
	        			asql = asql + " AND b.INT_OFFICEID IN ("+officeids+" )";
					
					if(!"0".equals(dept))
						asql=asql + " AND b.INT_DEPARTID="+dept;
					
					if(!"0".equals(Category))
						asql=asql + " AND b.CHR_CATEGORY="+Category;
					else
	        			asql = asql + " AND b.CHR_CATEGORY IN ("+catids+" )";
	 				asql = asql + " AND a.CHR_MONTH='"+month+"'"; 
					asql = asql + " AND a.INT_YEAR= "+year+ "   ";
					apstm=con.prepareStatement(asql);
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close(); 
					
					con.close();    
					response.sendRedirect("Smart Attendance/AttendanceSelfMarkingView.jsp");
				} 
				catch (Exception e) 
				{
					System.out.println(e.getMessage());
					e.printStackTrace();
				}
			}
			else if("ATTAttendanceMarkingIndividual".equals(action))
			{
				String month = request.getParameter("month");
				String year = request.getParameter("year");
				String length  = request.getParameter("dec");
				String empid  = request.getParameter("empid");
				String accept="";
				String reject="";
				String rejectdec="";
				String hiddenField="";
				String status="";
				String entrydate="";
				String morning="";
				String evening="";
				//SELF MARKING UPDATION
				asql = " UPDATE att_m_selfmarking SET CHR_STATUS =? ,  DAT_APPROVAL_TIME=NOW(), CHR_APPROVEDBY=? ,CHR_DESCRIPTION=?  ";
				asql = asql + " WHERE  CHR_STATUS ='N'   AND  INT_ROWID =? ";
				apstm = con.prepareStatement(asql);
				for(int u=0;u<Integer.parseInt(length);u++)
				{
					accept = ""+request.getParameter("accept"+u);
					reject = ""+request.getParameter("reject"+u);
					rejectdec = ""+request.getParameter("dec"+u);
					hiddenField=request.getParameter("hiddenField"+u);
					 
					if( ("on".equals(accept))  ||   ("on".equals(reject)))
					{
						if("on".equals(accept))
							status = "Y";
						if("on".equals(reject))
							status = "R";
					
						apstm.setString(1,status);
						apstm.setString(2,userid);
						apstm.setString(3,rejectdec);
						apstm.setString(4,hiddenField );
						System.out.println(""+apstm);
						apstm.addBatch();
					}
				}
				apstm.executeBatch();
				apstm.close();
				
				System.out.println();
				System.out.println("Migrate the attendance");
				//update Attendance Register
				for(int u=0;u<Integer.parseInt(length);u++)
				{
					entrydate = ""+request.getParameter("entrydate"+u);
					morning = ""+request.getParameter("morning"+u);
					evening = ""+request.getParameter("evening"+u);
					accept = ""+request.getParameter("accept"+u);
					if( "on".equals(accept) )
					{
						asql = "UPDATE att_t_register SET CHR_MORNING"+Integer.parseInt(entrydate)+" = ?, ";
						asql = asql + " CHR_EVENING"+Integer.parseInt(entrydate)+" = ? ";
						asql = asql + " WHERE CHR_EMPID = ? "; 
						asql = asql + " AND CHR_MONTH= ? "; 
						asql = asql + " AND INT_YEAR= ? "; 
						apstm = con.prepareStatement(asql);
						apstm.setString(1,morning);
						apstm.setString(2,evening);
						apstm.setString(3,empid);
						apstm.setString(4,month );
						apstm.setString(5,year );
						System.out.println(""+apstm);
						apstm.execute();
						apstm.close();
						
					}
				}
				
				con.close();    
				response.sendRedirect("Smart Attendance/AttendanceSelfMarking.jsp");
			}
			else if("ATTAttendanceSelfMarkingApprovalReset".equals(action))
			{
				String empid = request.getParameter("ename");
				String month = request.getParameter("month");
				String year = request.getParameter("year");
				String monthname=DateUtil.getMonth(Integer.parseInt(month));
				asql = " UPDATE att_m_selfmarking SET CHR_STATUS='N', CHR_DESCRIPTION= null ";
				asql = asql + " WHERE CHR_EMPID=? AND CHR_MONTH=? AND INT_YEAR=? AND CHR_STATUS !='N' ";
				apstm = con.prepareStatement(asql);
				apstm.setString(1, empid);
				apstm.setString(2, monthname);
				apstm.setString(3, year);
				System.out.println(""+apstm);
				apstm.execute();
				con.close();    
				response.sendRedirect("Smart Attendance/SelfmarkingApprovalResetIndividual.jsp");
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