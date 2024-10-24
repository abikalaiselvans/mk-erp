package com.my.org.erp.common;

import java.io.IOException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/RemoveSession")
public class CloseActionHandler extends HttpServlet 
{
 	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		try {
			HttpSession session = request.getSession();
			String action = request.getParameter("actionS");
			action = action.trim();
			
			//System.out.println("CLOSE ACTION :: " + action);
			if (action.equals("ATTstateDelete") || action.equals("ATTstateAdd")
					|| action.equals("ATTdistrictDelete")
					|| action.equals("ATTdistrictAdd")
					|| action.equals("ATTdistrictEdit")) {
				session.removeAttribute("stateList");
				
				response.sendRedirect("Smart Attendance/AttendanceMain.jsp");
			} else if (action.equals("COM_ATTdepartDelete")
					|| action.equals("COM_ATTdepartAdd")
					|| action.equals("COM_ATTdepartEdit")
					|| action.equals("ATTmusterCal")
					|| action.equals("ATTmusterMonth")
					|| action.equals("COM_ATTdepartList")
					|| action.equals("ATTMUSTERMONTHDEPT")) {
				session.removeAttribute("departmentList");
				response.sendRedirect("Smart Attendance/AttendanceMain.jsp");
			} else if (action.equals("COM_ATTdesigDelete")
					|| action.equals("COM_ATTdesigAdd")
					|| action.equals("COM_ATTdesigEdit")
					|| action.equals("ATTMUSTERMONTHDESIG")) {
				session.removeAttribute("designationList");
				response.sendRedirect("Smart Attendance/AttendanceMain.jsp");
			} else if (action.equals("COM_PAYdesigDelete")) {
				session.removeAttribute("designationList");
				response.sendRedirect("Smart%20Payroll/Payrollmain.jsp");
			} else if (action.equals("ATTOfficeDelete")
					|| action.equals("ATTOfficeAdd")
					|| action.equals("ATTOfficeEdit")) {
				session.removeAttribute("OfficeList");
				response.sendRedirect("Smart Attendance/AttendanceMain.jsp");
			} else if (action.equals("ATTshiftDelete")
					|| action.equals("ATTshiftAdd")
					|| action.equals("ATTshiftEdit")) {
				session.removeAttribute("shiftList");
				response.sendRedirect("Smart Attendance/AttendanceMain.jsp");
			} else if (action.equals("ATTholidayDelete")) {
				session.removeAttribute("holidayList");
				response.sendRedirect("Smart Attendance/AttendanceMain.jsp");
			} else if (action.equals("ATTcompensationDelete")) {
				session.removeAttribute("compensationList");
				response.sendRedirect("Smart Attendance/AttendanceMain.jsp");
			} else if (action.equals("ATTleaveMasteradd")
					|| action.equals("ATTleaveTypeadd")) {
				session.removeAttribute("leaveType");
				response.sendRedirect("Smart Attendance/AttendanceMain.jsp");
			} else if (action.equals("ATTondutyDelete")) {
				session.removeAttribute("dutyList");
				response.sendRedirect("Smart Attendance/AttendanceMain.jsp");
			} else if (action.equals("ATTmanualDelete")) {
				session.removeAttribute("manualList");
				response.sendRedirect("Smart Attendance/AttendanceMain.jsp");
			} else if (action.equals("ATTmanualDelete")) {
				session.removeAttribute("manualList");
				response.sendRedirect("Smart Attendance/AttendanceMain.jsp");
			} else if (action.equals("ATTpermissionDelete")) {
				session.removeAttribute("permissionList");
				response.sendRedirect("Smart Attendance/AttendanceMain.jsp");
			} else if (action.equals("ATTleaveDelete")) {
				session.removeAttribute("leaveList");
				response.sendRedirect("Smart Attendance/AttendanceMain.jsp");
			}
		} catch (Exception e) {
			 System.out.println(e.getMessage());
			response.sendRedirect("error/index.jsp?error="
					+ e.getLocalizedMessage().toString());
		}
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		doGet(request, response);
	}
}