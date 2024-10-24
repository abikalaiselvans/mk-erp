package com.my.org.erp.SmartAttendance;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import com.my.org.erp.common.CommonFunction;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.bean.Attendance.Attinfo;
import com.my.org.erp.common.CommonFunctions;

public class StaffPresentActionHandler extends AbstractActionHandler {
	Statement st;
	ResultSet rs;
	java.text.SimpleDateFormat datetime = new java.text.SimpleDateFormat(
			"yyyy-MM-dd");
	java.util.Date date = new java.util.Date();
	String updatedate = "" + datetime.format(date);
	@SuppressWarnings("deprecation")
	String year = "" + (1900 + date.getYear());
	boolean redirectflag = false;
	String redirecterror = "";
	String sql;
	boolean flag = false;
	ArrayList<Attinfo> attinfo = new ArrayList<Attinfo>();
	HttpSession session = null;
	String userid = null;

	public synchronized void handle(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			String action = request.getParameter("actionS");
			session = request.getSession();
			userid = (String) session.getAttribute("USRID");
			session.removeAttribute("attinfo");
			System.out.println("CONTROLLER FROM CONTINUOUS PRESENT ENTRY  ACTION HANDLER  : "+ action + " USER : " + userid);
			if ("ATTStaffPresentAdd".equals(action))// DATE WISE
			{
				//StaffPresentAddDateWise1(request, response);
				StaffPresentAddDateWiseCheckandMark(request, response);
				con.close();
				response.sendRedirect("Smart Attendance/DateWiseEntry.jsp");
			}

		} catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
		}
	}

	@SuppressWarnings("unused")
	private void StaffPresentAddDateWise(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {

			String staffids[] = request.getParameterValues("ename");
			String fromdt = request.getParameter("fromdt");
			String todt = request.getParameter("todt");
			String fromdtsql = DateUtil.FormateDateSQL(fromdt);
			String todasql = DateUtil.FormateDateSQL(todt);
			String dd[][] = CommonFunctions.QueryExecute("SELECT MONTH('"+ fromdtsql + "'),YEAR('" + fromdtsql + "')");
			//System.out.println(dd[0][0] + dd[0][1]);
			String dates[] = CommonFunctions.QueryExecute("SELECT FIND_A_DAYS_BETWEEN_TWO_DAYS_EXPECT_SUNDAY('"	+ fromdtsql + "','" + todasql + "')")[0][0].split(",");

			//System.out.println(CommonFunctions.QueryExecute("SELECT FIND_A_DAYS_BETWEEN_TWO_DAYS_EXPECT_SUNDAY('"	+ fromdtsql + "','" + todasql + "')")[0][0]);
			// String dates[] =
			// CommonFunctions.QueryExecute("SELECT FIND_A_DAYS_EXPECT_SUNDAY("+dd[0][0]+","+dd[0][1]+")")[0][0].split(",");
			String updatequery1 = "";
			acs = con.prepareCall("{call ATT_PRO_CONTINUOUSENTRY( ?,?,?,?,?,?,?)}");
			boolean f = false;

			for (int x = 0; x < staffids.length; x++) {
				updatequery1 = "";
				asql = "";
				for (int y = 0; y < dates.length; y++) {
					int day = Integer.parseInt(dates[y].split("-")[2].trim());

					updatequery1 = " SElECT COUNT(*)  FROM att_t_register  WHERE CHR_MONTH = MONTHNAME('"
							+ dates[y]
							+ "') AND INT_YEAR= YEAR('"
							+ dates[y]
							+ "') ";
					updatequery1 = updatequery1 + " AND CHR_MORNING" + day
							+ " !='0'  AND CHR_EVENING" + day + " !='0'";
					updatequery1 = updatequery1 + "  AND CHR_EMPID='"
							+ staffids[x].trim() + "' ";

					asql = " SELECT COUNT(*) FROM att_t_continuousentry WHERE DT_CONTINUOUSDATE = '"
							+ dates[y]
							+ "'  AND CHR_EMPID='"
							+ staffids[x]
							+ "'";
					if ((!CommonFunction.RecordExist(asql))
							&& (!CommonFunction.RecordExist(updatequery1))) {

						f = true;

						acs.setString(1, "INSERT");
						acs.setString(2, null);
						acs.setString(3, staffids[x].trim());
						acs.setString(4, dates[y]);
						acs.setString(5, "Full Day");
						acs.setString(6, "1.0");
						acs.setString(7, userid);
						// System.out.println(""+acs);
						acs.addBatch();

						String field = " UPDATE att_t_register SET CHR_USRNAME='"
								+ userid + "',DAT_MODIFIEDDATE=NOW(),";
						field = field + " CHR_MORNING" + day
								+ " = 'PRE' , CHR_EVENING" + day + "='PRE' , ";
						field = field + " CHR_UPDATESTATUS='Y' ,";
						field = field.trim();
						field = field.substring(0, field.length() - 1);
						field = field
								+ "  WHERE CHR_EMPID=? AND CHR_MONTH = MONTHNAME('"
								+ dates[y] + "') AND INT_YEAR= YEAR('"
								+ dates[y] + "')";

						apstm = con.prepareStatement(field);
						apstm.setString(1, staffids[x]);
						// System.out.println(""+apstm);
						apstm.execute();
						apstm.close();
					}

				}
			}
			if (f)
				acs.executeBatch();

		} catch (Exception e) {
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request
					.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
		}
	}

	
	private void StaffPresentAddDateWise1(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{

			String staffids[] = request.getParameterValues("ename");
			String fromdt = request.getParameter("fromdt");
			String todt = request.getParameter("todt");
			String fromdtsql = DateUtil.FormateDateSQL(fromdt);
			String todasql = DateUtil.FormateDateSQL(todt);
			String dates[] = CommonFunctions.QueryExecute("SELECT FIND_A_DAYS_BETWEEN_TWO_DAYS_EXPECT_SUNDAY('"	+ fromdtsql + "','" + todasql + "')")[0][0].split(",");
			String monthname = CommonFunctions.QueryExecute("SELECT MONTHNAME('" + fromdtsql + "')")[0][0];
			String year = CommonFunctions.QueryExecute("SELECT YEAR('"	+ fromdtsql + "')")[0][0];
			asql = " UPDATE att_t_register SET ";
			for (int y = 0; y < dates.length; y++)
				asql = asql + " CHR_MORNING"+ Integer.parseInt(dates[y].split("-")[2].trim())+ " = 'PRE' , CHR_EVENING"	+ Integer.parseInt(dates[y].split("-")[2].trim())+ "='PRE' , ";
			asql = asql + " CHR_USRNAME='" + userid	+ "',DAT_MODIFIEDDATE=NOW(),";
			asql = asql + " CHR_UPDATESTATUS='Y' ";
			asql = asql	+ "   WHERE CHR_EMPID=? AND CHR_MONTH =?  AND INT_YEAR=?  ";
			asql = asql.trim();
			apstm = con.prepareStatement(asql);
			for (int x = 0; x < staffids.length; x++) 
			{
				apstm.setString(1, staffids[x]);
				apstm.setString(2, monthname);
				apstm.setString(3, year);
				System.out.println("Entry : " + x + "/" + staffids.length+ "   " + apstm);
				apstm.addBatch();
			}
			apstm.executeBatch();
			apstm.close();
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request	.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
		}
	}

	
	
	private void StaffPresentAddDateWiseCheckandMark(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{

			String staffids[] = request.getParameterValues("ename");
			String fromdt = request.getParameter("fromdt");
			String todt = request.getParameter("todt");
			String fromdtsql = DateUtil.FormateDateSQL(fromdt);
			String todasql = DateUtil.FormateDateSQL(todt);
			String dates[] = CommonFunctions.QueryExecute("SELECT FIND_A_DAYS_BETWEEN_TWO_DAYS_EXPECT_SUNDAY('"	+ fromdtsql + "','" + todasql + "')")[0][0].split(",");
			String monthname = CommonFunctions.QueryExecute("SELECT MONTHNAME('" + fromdtsql + "')")[0][0];
			String year = CommonFunctions.QueryExecute("SELECT YEAR('"	+ fromdtsql + "')")[0][0];
			
			for (int y = 0; y < dates.length; y++)
			{
				for (int x = 0; x < staffids.length; x++) 
				{
					//Morning Attendance
					asql = " UPDATE att_t_register SET ";
					asql = asql + " CHR_MORNING"+ Integer.parseInt(dates[y].split("-")[2].trim())+ " = 'PRE' ,";
					asql = asql + " CHR_USRNAME='" + userid	+ "',DAT_MODIFIEDDATE=NOW(),";
					asql = asql + " CHR_UPDATESTATUS='Y' ";
					asql = asql	+ "   WHERE CHR_EMPID=? AND CHR_MONTH =?  AND INT_YEAR=?  ";
					asql = asql	+ "  AND CHR_MORNING"+ Integer.parseInt(dates[y].split("-")[2].trim())+ "  NOT IN ('LEA','HOL','ABS') ";
					asql = asql.trim();
					apstm = con.prepareStatement(asql);
					apstm.setString(1, staffids[x]);
					apstm.setString(2, monthname);
					apstm.setString(3, year);
					apstm.execute();
					apstm.close();
					
					asql = " UPDATE att_t_register SET ";
					asql = asql + " CHR_EVENING"+ Integer.parseInt(dates[y].split("-")[2].trim())+ " = 'PRE' ,";
					asql = asql + " CHR_USRNAME='" + userid	+ "',DAT_MODIFIEDDATE=NOW(),";
					asql = asql + " CHR_UPDATESTATUS='Y' ";
					asql = asql	+ "   WHERE CHR_EMPID=? AND CHR_MONTH =?  AND INT_YEAR=?  ";
					asql = asql	+ "  AND CHR_EVENING"+ Integer.parseInt(dates[y].split("-")[2].trim())+ "  NOT IN ('LEA','HOL','ABS') ";
					asql = asql.trim();
					apstm = con.prepareStatement(asql);
					apstm.setString(1, staffids[x]);
					apstm.setString(2, monthname);
					apstm.setString(3, year);
					apstm.execute();
					apstm.close();
				}
			}
			
			/*asql = " UPDATE att_t_register SET ";
			for (int y = 0; y < dates.length; y++)
				asql = asql + " CHR_MORNING"+ Integer.parseInt(dates[y].split("-")[2].trim())+ " = 'PRE' , CHR_EVENING"	+ Integer.parseInt(dates[y].split("-")[2].trim())+ "='PRE' , ";
			asql = asql + " CHR_USRNAME='" + userid	+ "',DAT_MODIFIEDDATE=NOW(),";
			asql = asql + " CHR_UPDATESTATUS='Y' ";
			asql = asql	+ "   WHERE CHR_EMPID=? AND CHR_MONTH =?  AND INT_YEAR=?  ";
			asql = asql.trim();
			apstm = con.prepareStatement(asql);
			for (int x = 0; x < staffids.length; x++) 
			{
				apstm.setString(1, staffids[x]);
				apstm.setString(2, monthname);
				apstm.setString(3, year);
				System.out.println("Entry : " + x + "/" + staffids.length+ "   " + apstm);
				apstm.addBatch();
			}
			apstm.executeBatch();
			apstm.close();*/
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request	.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
		}
	}

}
