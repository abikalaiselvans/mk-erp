package com.my.org.erp.SmartAttendance;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;

public class StaffDailyLateAttendanceActionHandler extends AbstractActionHandler
{
	 
	HttpSession session = null;
	String userid = null;

	public synchronized void handle(HttpServletRequest request,	HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			session = request.getSession();
			userid = (String) session.getAttribute("USRID");
			if ("ATTStaffDailyLateAttendanceinUploadedExcel".equals(action))// DATE WISE
			{ 
				String filename =""+request.getParameter("xlsfilename");
 				String month=""+request.getParameter("month");
 				String year=""+request.getParameter("year");
 				String monthname = DateUtil.getMonth(Integer.parseInt(month));
 				 
 				@SuppressWarnings("deprecation")
				String filepath = request.getRealPath("/")+"UploadExcelFile/"+filename+"_"+month+"_"+year+".xls" ;
 				
 				String timeout = CommonFunctions.QueryExecutecon(con, "SELECT TIM_TIMEOUT  FROM att_m_basicsettings  WHERE INT_ID =1")[0][0];
 				String timein = null; 
 				
 				
 				Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
 				String myDB ="jdbc:odbc:Driver={Microsoft Excel Driver (*.xls)};DBQ="+filepath+";DriverID=22;READONLY=false";
 				Connection cona = DriverManager.getConnection(myDB,"","");
 				Statement sts = cona.createStatement();
 				ResultSet rss = sts.executeQuery("SELECT * FROM [Sheet1$]");
 				 
 				 
 				String date ="0";
 				int username = 0;
 				String empid="";
 				acs = con.prepareCall("{call ATT_PRO_MANUALATTENDANCE(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
 				boolean flag = false;
 				while(rss.next())
 				{
 					username = (int)Double.parseDouble(rss.getString(1));
 					empid =  rss.getString(2) ;
 					date = rss.getString(3);
 					timein = rss.getString(5);
 					if(!"ADMIN".equalsIgnoreCase(empid) )
 					{	
	 					//Update the ATTENDANCE REGISTER
 						asql = " UPDATE att_t_register SET ";
	 					asql = asql+ " CHR_MORNING"+(int)Double.parseDouble(date)+"='LAT' , ";
	 					asql = asql+ " DT_UPDATEDATE = DATE(NOW()), CHR_USRNAME=?, CHR_UPDATESTATUS='Y' ";
	 					asql = asql+ " WHERE CHR_EMPID=FIND_A_EMPLOYEE_ID_ONLY_BY_USERID(RIGHT(?,6)) AND CHR_MONTH=? AND INT_YEAR=? ";
	 					asql =asql + " AND CHR_MORNING"+(int)Double.parseDouble(date)+"   NOT IN ('LEA','HOL','ABS')  " ;
	 					
	 					apstm = con.prepareStatement(asql);
	 					apstm.setString(1,userid );
	 					apstm.setString(2,"000000"+username );//empid
	 					apstm.setString(3,monthname );
	 					apstm.setString(4,year );
	 					System.out.println(""+apstm);
	 					int i = apstm.executeUpdate();
	 					apstm.close(); 
	 					
	 					if(i>0)
	 					{
		 					//INSERT THE STAFF MANUAL ATTENDANCE
		 					acs.setString(1, "INSERT");
							acs.setString(2,  null);//
							acs.setString(3,  CommonFunctions.QueryExecutecon(con,"SELECT FIND_A_EMPLOYEE_ID_ONLY_BY_USERID(RIGHT('000000"+username+"',6))")[0][0]);//empid
							acs.setString(4, timein );//timein
							acs.setString(5, timeout );//timeout
							acs.setString(6,  null);//lunchout
							acs.setString(7, null );//lunchin
							acs.setString(8,  year+"-"+month+"-"+date);//login
							acs.setString(9,  year+"-"+month+"-"+date);// logout
							acs.setString(10,  null );//thours
							acs.setString(11,  null );//tminutes
							acs.setString(12,  monthname);//lmonth
							acs.setString(13,  year);//lyear
							acs.setString(14,  null);//shiftcode
							acs.setString(15,  "Manual");//pretypesent
							acs.setString(16,  null);//late
							acs.setString(17,  "L");//atype
							acs.setString(18,  "Full Day");//daytype
							acs.setString(19,  "1.0" );//dayvalue
							acs.setString(20,  userid);//userid
							System.out.println(""+acs);
							acs.addBatch();
							flag = true;
	 					}
 					}
 				}
 				 
 				if(flag)
 				{
 					acs.executeBatch();
 					acs.close();
 				}
				rss.close();
				sts.close();
				cona.close(); 
				con.close();   
				response.sendRedirect("Common/exit.jsp");
			
			}

		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
		}
	}
 

}
