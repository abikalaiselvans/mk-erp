package com.my.org.erp.SmartAttendance;

import java.io.IOException;
 
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;

public class StaffHoldActionHandler extends AbstractActionHandler 
{
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String userid = (String) session.getAttribute("USRID");
			 
			 
			if ("ATTStaffHoldAdd".equals(action))	
			{
				String ename = request.getParameter("ename");
				String fromdt = request.getParameter("fromdt");
				
				asql=" INSERT INTO att_t_hold (CHR_EMPID,DAT_HOLD,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS) ";
				asql = asql + " VALUES (?,?,?,NOW(),'Y' )";
				apstm = con.prepareStatement(asql) ;
				apstm.setString(1,ename );
				apstm.setString(2,DateUtil.FormateDateSQL(fromdt));
				apstm.setString(3,userid);
				System.out.println(""+apstm);
				apstm.execute();
				apstm.close();
				 
				asql = " UPDATE com_m_staff SET CHR_HOLD=?, DT_HOLDDATE=? WHERE CHR_EMPID=? AND CHR_EMPID !='ADMIN' "; 
				apstm = con.prepareStatement(asql) ;
				apstm.setString(1,"Y" );
				apstm.setString(2,DateUtil.FormateDateSQL(fromdt));
				apstm.setString(3,ename);
				System.out.println(""+apstm);
				apstm.execute();
				apstm.close();
				
				asql = " SELECT DAY('"+DateUtil.FormateDateSQL(fromdt)+"'), DAY(LAST_DAY('"+DateUtil.FormateDateSQL(fromdt)+"'))" ;
				String data[][] = CommonFunctions.QueryExecutecon(con, asql);
				int start = Integer.parseInt(data[0][0]);
				int end = Integer.parseInt(data[0][1]);
				asql = " UPDATE att_t_register SET ";
				for(int u=start;u<end;u++)
					asql = asql + " CHR_MORNING"+u+"='ABS' ,  CHR_EVENING"+u+"='ABS' , ";
				asql = asql +" DT_UPDATEDATE = DATE(NOW()),  CHR_USRNAME=?, CHR_UPDATESTATUS= 'Y' ";
				asql = asql + " WHERE CHR_EMPID=?";
				asql = asql + " AND CHR_MONTH =  MONTHNAME('"+DateUtil.FormateDateSQL(fromdt)+"') AND INT_YEAR= YEAR('"+DateUtil.FormateDateSQL(fromdt)+"') ";
				apstm = con.prepareStatement(asql) ;
				apstm.setString(1,auserid );
				apstm.setString(2,ename);
				System.out.println(""+apstm);
				apstm.execute();
				apstm.close();
				
				
				con.close();    
				response.sendRedirect("Smart Attendance/StaffHoldview.jsp");
			}
			else if("ATTStaffHoldDeletes".equals(action))
			{
				String staffids[]=request.getParameterValues("staffid");
				for(int u=0;u<staffids.length;u++)
				{
					asql ="DELETE FROM att_t_hold WHERE CHR_EMPID=? AND CHR_STATUS ='N'";
					apstm = con.prepareStatement(asql) ;
					apstm.setString(1,staffids[u]);
					apstm.execute();
					apstm.close();
					
					asql ="UPDATE com_m_staff SET CHR_HOLD='N', DT_HOLDDATE= null WHERE CHR_EMPID=?";
					apstm = con.prepareStatement(asql) ;
					apstm.setString(1,staffids[u]);
					apstm.execute();
					apstm.close();
					
					asql = " SELECT DAY(NOW()), DAY(LAST_DAY(NOW())),MONTH(NOW()), YEAR(NOW())" ;
					String data[][] = CommonFunctions.QueryExecutecon(con, asql);
					int start = Integer.parseInt(data[0][0]);
					int end = Integer.parseInt(data[0][1]);
					String month =data[0][2];
					String year =data[0][3];
					String sundays[] = CommonFunctions.QueryExecute(" SELECT FIND_A_SUNDAY("+month+","+year+")")[0][0].split(",");
					asql = " UPDATE att_t_register SET ";
					for(int x=start;x<end;x++)
						asql = asql + " CHR_MORNING"+x+"='PRE' ,  CHR_EVENING"+x+"='PRE' , ";
					for(int v=0;v<sundays.length;v++)
						asql = asql + " CHR_MORNING"+sundays[v]+"='SUN' ,  CHR_EVENING"+sundays[v]+"='SUN' , ";
					asql = asql +" DT_UPDATEDATE = DATE(NOW()),  CHR_USRNAME=?, CHR_UPDATESTATUS= 'Y' ";
					asql = asql + " WHERE CHR_EMPID=?";
					asql = asql + " AND CHR_MONTH =  MONTHNAME(NOW()) AND INT_YEAR= YEAR(NOW()) ";
					apstm = con.prepareStatement(asql) ;
					apstm.setString(1,auserid );
					apstm.setString(2,staffids[u]);
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
					 
				}
				con.close();    
				response.sendRedirect("Smart Attendance/StaffHoldview.jsp");
			}
			else if("ATTStaffUnHold".equals(action))
			{
				String staffid=request.getParameter("staffid");
				String Rowid =request.getParameter("Rowid");
				String fromdt =request.getParameter("fromdt");
				
				asql ="UPDATE att_t_hold SET CHR_STATUS ='Y' , DAT_UNHOLD=? WHERE INT_ID= ?";
				apstm = con.prepareStatement(asql) ;
				apstm.setString(1,DateUtil.FormateDateSQL(fromdt));
				apstm.setString(2,Rowid);
				apstm.execute();
				apstm.close();
				
				 
				asql ="UPDATE com_m_staff SET CHR_HOLD='N', DT_HOLDDATE= null WHERE CHR_EMPID=?";
				apstm = con.prepareStatement(asql) ;
				apstm.setString(1,staffid);
				apstm.execute();
				apstm.close();
				 
				
				asql = " SELECT DAY('"+DateUtil.FormateDateSQL(fromdt)+"'), DAY(LAST_DAY('"+DateUtil.FormateDateSQL(fromdt)+"'))" ;
				String data[][] = CommonFunctions.QueryExecutecon(con, asql);
				int start = Integer.parseInt(data[0][0]);
				int end = Integer.parseInt(data[0][1]);
				String month =fromdt.split("-")[1];
				String year =fromdt.split("-")[2];
				String sundays[] = CommonFunctions.QueryExecute(" SELECT FIND_A_SUNDAY("+month+","+year+")")[0][0].split(",");
				asql = " UPDATE att_t_register SET ";
				for(int u=start;u<end;u++)
					asql = asql + " CHR_MORNING"+u+"='PRE' ,  CHR_EVENING"+u+"='PRE' , ";
				for(int v=0;v<sundays.length;v++)
					asql = asql + " CHR_MORNING"+sundays[v]+"='SUN' ,  CHR_EVENING"+sundays[v]+"='SUN' , ";
				asql = asql +" DT_UPDATEDATE = DATE(NOW()),  CHR_USRNAME=?, CHR_UPDATESTATUS= 'Y' ";
				asql = asql + " WHERE CHR_EMPID=?";
				asql = asql + " AND CHR_MONTH =  MONTHNAME('"+DateUtil.FormateDateSQL(fromdt)+"') AND INT_YEAR= YEAR('"+DateUtil.FormateDateSQL(fromdt)+"') ";
				apstm = con.prepareStatement(asql) ;
				apstm.setString(1,auserid );
				apstm.setString(2,staffid);
				System.out.println(""+apstm);
				apstm.execute();
				apstm.close();
				
				con.close();
				response.sendRedirect("Smart Attendance/StaffHoldview.jsp");
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