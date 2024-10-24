package com.my.org.erp.SmartStaff;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;

public class StaffAttendanceMarkingActionHandler extends AbstractActionHandler 
{
	 
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String userid = "" + session.getAttribute("USRID");
			String empid = "" + session.getAttribute("EMPID");
			
			if (action.equals("STAStaffAttendanceMarkingRegister")) 
			{
				
				String fromdt = request.getParameter("fromdt");
				String LComboDay = request.getParameter("LComboDay");
				String type = request.getParameter("type");
				fromdt = DateUtil.FormateDateSQL(fromdt);
				String dt[] = fromdt.split("-");
				String year = dt[0];
				String month = dt[1];
				int day = Integer.parseInt(dt[2]);
				String monthname=DateUtil.getMonth(Integer.parseInt(month));
				
				String sundays[] = CommonFunctions.QueryExecute(" SELECT FIND_A_SUNDAY("+month+","+year+")")[0][0].split(",");
				int noofdays= DateUtil.totalDays(Integer.parseInt(month), Integer.parseInt(year));
				
				
				String queryupdate="";
				if("Full Day".equals(LComboDay))
					queryupdate = "CHR_MORNING"+day+"= '"+type+"' ,  CHR_EVENING"+day+"= '"+type+"' ,";  
				else if("Forenoon".equals(LComboDay))
					queryupdate = "CHR_MORNING"+day+" = '"+type+"' ,";
				else if("Afternoon".equals(LComboDay))
					queryupdate = "CHR_MORNING"+day+" = '"+type+"' ,";
				
				asql = "SELECT COUNT(*) FROM att_t_registerselfmarking WHERE CHR_EMPID ='"+empid+"' AND CHR_MONTH ='"+monthname+"'AND  INT_YEAR= "+year;
				boolean availableflag = CommonFunctions.RecordExist(con, asql);
				if(availableflag) 
				{
					//Updation
					asql = " UPDATE att_t_registerselfmarking SET ";
					asql = asql +queryupdate ;
					for(int i=0; i<sundays.length;i++)
						asql = asql +" CHR_MORNING"+sundays[i]+" ='SUN' , CHR_EVENING"+sundays[i]+"='SUN',  ";
					asql = asql + " CHR_USRNAME =? , DT_UPDATEDATE = DATE(NOW()) , CHR_UPDATESTATUS ='Y' ";
					asql = asql + " WHERE CHR_EMPID = ? AND CHR_MONTH =? AND INT_YEAR= ?  AND CHR_STATUS='N'";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,userid);
					apstm.setString(2,empid);
					apstm.setString(3,monthname);
					apstm.setString(4,year);
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
					
				}
				else
				{
					//Isertion
					asql = "INSERT INTO att_t_registerselfmarking (CHR_EMPID,CHR_MONTH,INT_YEAR)  VALUES (?,?,?)";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,empid);
					apstm.setString(2,monthname);
					apstm.setString(3,year);
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
					
					//Sunday Marking & Updation
					asql = " UPDATE att_t_registerselfmarking SET ";
					asql = asql +queryupdate ;
					for(int i=0; i<sundays.length;i++)
						asql = asql +" CHR_MORNING"+sundays[i]+" ='SUN' , CHR_EVENING"+sundays[i]+"='SUN',  ";
					asql = asql + " CHR_USRNAME =? , DT_UPDATEDATE = DATE(NOW()) , CHR_UPDATESTATUS ='Y' ";
					asql = asql + " WHERE CHR_EMPID = ? AND CHR_MONTH =? AND INT_YEAR= ?   AND CHR_STATUS='N'";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,userid);
					apstm.setString(2,empid);
					apstm.setString(3,monthname);
					apstm.setString(4,year);
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
					
				}
				con.close();
				response.sendRedirect("Staff/Userframe.jsp");
			} 
			else if("STAStaffAttendanceMarkingIndividual".equals(action))
			{
				String fromdt = request.getParameter("fromdt");
				String LComboDay = request.getParameter("LComboDay");
				String type = request.getParameter("type");
				fromdt = DateUtil.FormateDateSQL(fromdt);
				String dt[] = fromdt.split("-");
				String year = dt[0];
				String month = dt[1];
				String monthname=DateUtil.getMonth(Integer.parseInt(month));
				
				
				asql = "SELECT COUNT(*) FROM att_m_selfmarking WHERE CHR_EMPID ='"+empid+"' AND DT_DATE ='"+fromdt+"'" ;
				boolean availableflag = CommonFunctions.RecordExist(con, asql);
				if(availableflag) 
				{
					//Updation
					asql = "SELECT CHR_MORNING,CHR_EVENING FROM att_m_selfmarking WHERE CHR_EMPID ='"+empid+"' AND DT_DATE ='"+fromdt+"'" ;
					String data[][] = CommonFunctions.QueryExecute(asql);
					
					asql = " UPDATE att_m_selfmarking SET CHR_MORNING=?, CHR_EVENING=? , ";
					asql = asql + " CHR_USRNAME =? , DT_UPDATEDATE = DATE(NOW()) , CHR_UPDATESTATUS ='Y' ";
					asql = asql + " WHERE CHR_EMPID = ? AND DT_DATE =?  AND CHR_STATUS='N'";
					apstm = con.prepareStatement(asql);
					if("Full Day".equals(LComboDay))
					{
						apstm.setString(1,type);
						apstm.setString(2,type);
					}
					else if("Forenoon".equals(LComboDay))
					{
						apstm.setString(1,type);
						apstm.setString(2,data[0][1]);
					}
					else if("Afternoon".equals(LComboDay))
					{
						apstm.setString(1,data[0][0]);
						apstm.setString(2,type);
					}
					apstm.setString(3,userid);
					apstm.setString(4,empid);
					apstm.setString(5,fromdt);
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
					
				}
				else
				{
					//Isertion
					asql = "INSERT INTO att_m_selfmarking (CHR_EMPID,DT_DATE,CHR_MONTH,INT_YEAR,CHR_MORNING,CHR_EVENING)  VALUES (?,?,?,?,?,?)";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,empid);
					apstm.setString(2,fromdt);
					apstm.setString(3,monthname);
					apstm.setString(4,year);
					if("Full Day".equals(LComboDay))
					{
						apstm.setString(5,type);
						apstm.setString(6,type);
					}
					else if("Forenoon".equals(LComboDay))
					{
						apstm.setString(5,type);
						apstm.setString(6,null);
					}
					else if("Afternoon".equals(LComboDay))
					{
						
						apstm.setString(5,null);
						apstm.setString(6,type);
					}
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
				}
				con.close();
				response.sendRedirect("Staff/Userframe.jsp");
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
