package com.my.org.erp.common;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class SmartAttendenceActionHandler extends AbstractActionHandler {
	String userid = null;

	String pwd = null;

	String sql = null;

	String attType = null;

	private boolean checkAttenType(String val) {
		sql = "SELECT "+val+" FROM STU_BASICSETTINGS WHERE INT_ID=1";
		//System.out.println("SQL:"+sql);
		try {
			PreparedStatement pst = con.prepareStatement(sql);
			ResultSet rs = pst.executeQuery();
			if (rs.next()) {
				attType = rs.getString(1);
				return true;
			} else
				return false;

		} catch (SQLException e) {
			 System.out.println(e.getMessage());
			return false;
		}
	}

	public void handle(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String action = request.getParameter("actionS");
			action = action.trim();
			//System.out.println("Action :" + action);
			if (action.equalsIgnoreCase("COM_ATTSingleEntry")) {
				response.sendRedirect("FingerPrint/FingerPrintVerification.jsp?type=Single");
			} else if (action.equalsIgnoreCase("COM_ATTMultiEntry")) {
				response.sendRedirect("FingerPrint/FingerPrintVerification.jsp?type=Multi");
			} else if (action.equalsIgnoreCase("COM_ATTNoShfit")) {
				response.sendRedirect("FingerPrint/FingerPrintVerification.jsp?type=NShift");
			} else if (action.equalsIgnoreCase("COM_STULibrary")) {
				checkAttenType("CHR_LIB_INOUT");
				if (attType.equalsIgnoreCase("B"))
					response.sendRedirect("FingerPrint/StudentFPVerification.jsp?Stype=Library");
				else
					response.sendRedirect("SmartStudent/PinNoTimeInOutWindow.jsp?fileName=PinNoWindow.jsp?Stype=Library");
			} else if (action.equalsIgnoreCase("COM_STUInternet")) {
				checkAttenType("CHR_INTERNET");
				if (attType.equalsIgnoreCase("B"))
					response.sendRedirect("FingerPrint/StudentFPVerification.jsp?Stype=Internet");
				else
					response.sendRedirect("SmartStudent/PinNoTimeInOutWindow.jsp?fileName=IntTimeInOutWindow.jsp?Stype=Internet");
			} else if (action.equalsIgnoreCase("COM_STULab")) {
				checkAttenType("CHR_LAB");
				if (attType.equalsIgnoreCase("B"))
					response.sendRedirect("FingerPrint/StudentFPVerification.jsp?Stype=Lab");
				else
					response.sendRedirect("SmartStudent/PinNoTimeInOutWindow.jsp?fileName=LabTimeInOutWindow.jsp?Stype=Lab");
			} else if (action.equalsIgnoreCase("COM_STUGHostel")) {
				checkAttenType("CHR_GHOSTEL");
				if (attType.equalsIgnoreCase("B"))
					response.sendRedirect("FingerPrint/StudentFPVerification.jsp?Stype=GentsHostel");
				else
					response.sendRedirect("SmartStudent/PinNoTimeInOutWindow.jsp?fileName=GHTimeInOutWindow.jsp?Stype=GentsHostel");
			} else if (action.equalsIgnoreCase("COM_STULHostel")) {
				checkAttenType("CHR_LHOSTEL");
				if (attType.equalsIgnoreCase("B"))
					response.sendRedirect("FingerPrint/StudentFPVerification.jsp?Stype=LadiesHostel");
				else
					response.sendRedirect("SmartStudent/PinNoTimeInOutWindow.jsp?fileName=LHTimeInOutWindow.jsp?Stype=LadiesHostel");
			} else if (action.equalsIgnoreCase("COM_STUGMess")) {
				checkAttenType("CHR_GMESS");
				if (attType.equalsIgnoreCase("B"))
					response.sendRedirect("FingerPrint/StudentFPVerification.jsp?Stype=GentsMess");
				else
					response.sendRedirect("SmartStudent/PinNoTimeInOutWindow.jsp?fileName=GMTimeInOutWindow.jsp?Stype=GentsMess");
			} else if (action.equalsIgnoreCase("COM_STULMess")) {
				checkAttenType("CHR_LMESS");
				if (attType.equalsIgnoreCase("B"))
					response.sendRedirect("FingerPrint/StudentFPVerification.jsp?Stype=LadiesMess");
				else
					response.sendRedirect("SmartStudent/PinNoTimeInOutWindow.jsp?fileName=LMTimeInOutWindow.jsp?Stype=LadiesMess");
			}
		} catch (Exception e) {
			 System.out.println(e.getMessage());
			response.sendRedirect("InValidSession.jsp?error=" + e.getMessage());
		}
	}
}
