package com.my.org.erp.SmartAttendance;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.bean.Attendance.Compensation;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;

public class CompensationActionHandler extends AbstractActionHandler {
	String TxtHoliname, sesUser;
	Statement st;
	int courseId;

	public void insertUserInformation(String staffid, String dat) {
		@SuppressWarnings("unused")
		java.text.SimpleDateFormat datetime = new java.text.SimpleDateFormat(
				"yyyy-MM-dd HH:mm:ss");
		@SuppressWarnings("unused")
		java.util.Date date = new java.util.Date();
		try {
			CallableStatement cs = con
					.prepareCall("{call ATT_PRO_COMPENSATION(?,?,?,?,?,?,?)}");
			cs.setString(1, "INSERT");
			cs.setString(2, staffid);
			cs.setString(3, dat);
			cs.setString(4, TxtHoliname);
			String data[] = dat.split("-");
			String month = DateUtil.getMonth(Integer.parseInt(data[1]));
			cs.setString(5, month);
			cs.setInt(6, Integer.parseInt(data[0]));
			cs.setString(7, sesUser);
			cs.execute();
		} catch (Exception e) {
			 System.out.println(e.getMessage());
		}
	}

	
	private void CompensationUpdate (HttpServletRequest request, HttpServletResponse response) 
	throws ServletException, IOException 
	{
		try 
		{
				String staffid = request.getParameter("staffid");
				String Odate = request.getParameter("Odate");
				String Hname = request.getParameter("TxtHname");

				String sql ="";
				sql ="UPDATE att_t_compensation SET ";
				sql = sql +"CHR_HOLINAME = '"+Hname+"' ";
				sql = sql +"WHERE CHR_EMPID = '"+staffid+"'";
				sql = sql +"AND DT_HOLIDATE = '"+Odate+"'";
//	//System.out.println("\n\n"+sql);
				st = con.createStatement();
				st.executeUpdate(sql);
		}
		catch (Exception e) 
		{
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}



	
	private void CompensationDelete(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			String staffids[] = request.getParameterValues("staffid");
			st = con.createStatement();
			for(int u=0; u<staffids.length;u++)
			{
				String val[] = staffids[u].trim().split("~");
				String sql =" DELETE FROM att_t_compensation WHERE CHR_EMPID = '"+val[0]+"'";	
				sql = sql +" AND  DT_HOLIDATE = '"+val[1]+"'";
				st.executeUpdate(sql);
			}
		} catch (Exception e) {
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}

	private void CompensationAdd(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession session = request.getSession();
			sesUser = (String) session.getAttribute("USRID");
			String staffname[] = request.getParameterValues("ename");
			TxtHoliname = request.getParameter("holiname");
			String fdate = request.getParameter("fromdt");
			String tdate = request.getParameter("todt");
			String date1 = DateUtil.FormateDateSQL(fdate);
			String date2 = DateUtil.FormateDateSQL(tdate);
			for (int i = 0; i < staffname.length; i++) {
				date1 = DateUtil.FormateDateSQL(fdate);
				date2 = DateUtil.FormateDateSQL(tdate);
				while (true) {
					insertUserInformation(staffname[i], date1);
					if (date1.equalsIgnoreCase(date2))
						break;
					date1 = DateUtil.addDate(date1, 1);
				}
			}
		} catch (Exception e) {
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}

	private void CompensationView(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession session = request.getSession();
			sesUser = (String) session.getAttribute("USRID");
			String staffname[] = request.getParameterValues("ename");
			String fdate = request.getParameter("fromdt");
			String tdate = request.getParameter("todt");
			String date1 = DateUtil.FormateDateSQL(fdate);
			String date2 = DateUtil.FormateDateSQL(tdate);
			ArrayList<Compensation> compensationList = new ArrayList<Compensation>();

			if (staffname == null) {
				String sql = "SELECT A.CHR_EMPID,A.CHR_STAFFNAME,B.DT_HOLIDATE,B.CHR_HOLINAME FROM ";
				sql = sql
						+ "  com_m_staff  A,ATT_T_COMPENSATION B WHERE A.CHR_EMPID=B.CHR_EMPID AND B.DT_HOLIDATE>='"
						+ date1 + "' AND B.DT_HOLIDATE<='" + date2 + "'";
				Statement st = con.createStatement();
				ResultSet rs = st.executeQuery(sql);
				while (rs.next()) {
					Compensation comp = new Compensation();
					comp.setEmpId(rs.getString(1));
					comp.setEmpName(rs.getString(2));
					comp.setHolidayDate(rs.getString(3));
					comp.setHolidayName(rs.getString(4));
					compensationList.add(comp);
				}
			} else

				for (int i = 0; i < staffname.length; i++) {
					date1 = DateUtil.FormateDateSQL(fdate);
					date2 = DateUtil.FormateDateSQL(tdate);
					String sql = "SELECT A.CHR_EMPID,A.CHR_STAFFNAME,B.DT_HOLIDATE,B.CHR_HOLINAME FROM ";
					sql = sql
							+ "  com_m_staff  A,ATT_T_COMPENSATION B WHERE A.CHR_EMPID=B.CHR_EMPID AND B.DT_HOLIDATE>='"
							+ date1 + "' AND B.DT_HOLIDATE<='" + date2
							+ "' AND B.CHR_EMPID='" + staffname[i] + "'";
					Statement st = con.createStatement();
					ResultSet rs = st.executeQuery(sql);
					while (rs.next()) {
						Compensation comp = new Compensation();
						comp.setEmpId(rs.getString(1));
						comp.setEmpName(rs.getString(2));
						comp.setHolidayDate(rs.getString(3));
						comp.setHolidayName(rs.getString(4));
						compensationList.add(comp);
					}
				}
			session.setAttribute("compensationList", compensationList);

		} catch (Exception e) {
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}

	public void handle(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			
			String action = request.getParameter("actionS");
			String act = "" + request.getParameter("Submit");
			
			//System.out.println("Comp.Action.Handler - Action inside Handle :" + action);
			
			act = act.trim();
			if (action.equals("ATTcompensationAdd") && act.equals("Submit")) {

				
				String staffname[] = request.getParameterValues("ename");
				String fdate = DateUtil.FormateDateSQL(request.getParameter("fromdt"));
				String tdate = DateUtil.FormateDateSQL(request.getParameter("todt"));
				
				boolean flag=true;
				String msg="";
				for (int i = 0; i < staffname.length; i++)
				{
					
					String sname = staffname[i]; 
					
					String sql = "SELECT CHR_EMPID, DT_HOLIDATE, CHR_HOLINAME from att_t_compensation WHERE ";
					sql = sql + "CHR_EMPID ='"+sname+"' ";
					sql = sql + "AND DT_HOLIDATE >= '"+fdate +"' AND DT_HOLIDATE <= '"+tdate+"'";

					
					String dat[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
					String mdat="";
					String hname="";
					
					//System.out.println("\n\n"+sql);
//					//System.out.println("\nLength : "+dat.length);
					if (dat.length>0)	{

						for (int k=0; k<dat.length; k++)	{

							if (k==0) {
								mdat=mdat+dat[k][1];
								hname=hname+dat[k][2];
							}
							else	{
								mdat=mdat+"/"+dat[k][1];
								hname=hname+"/"+dat[k][2];
							}
						}
						flag=false;
						msg = sname+"&Adate="+mdat+"&Hname="+hname;	
						break;
					}
				}
				
				if (!flag)
				{
					response.sendRedirect("Smart Attendance/CompensationAdd.jsp?mess=Already&staffID="+msg);
				}
				else
				{
					CompensationAdd(request, response);
					response.sendRedirect("Smart Attendance/Compensation.jsp?message='Successfuly Added'");
				}
			} else if (action.equals("ATTcompensationAdd")
					&& act.equals("View")) {
				CompensationView(request, response);
				response.sendRedirect("Smart Attendance/CompensationView.jsp");
			} 
			else if (action.equals("ATTCompensationUpdate"))
			{
				CompensationUpdate(request, response);
				response.sendRedirect("Smart Attendance/Compensation.jsp");
			}
			else if (action.equals("ATTcompensationDelete")) {
				// //System.out.println("SDFDSF");
				CompensationDelete(request, response);
				response.sendRedirect("Smart Attendance/Compensation.jsp?message=Successfully Deleted");
			}
			
		} catch (Exception e) {
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}
}
