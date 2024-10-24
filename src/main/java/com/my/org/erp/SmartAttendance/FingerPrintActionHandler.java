package com.my.org.erp.SmartAttendance;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class FingerPrintActionHandler extends AbstractActionHandler {
	String sql = null;

	String repName = null;

	String repHeader = null;

	String s = "";

	private void WriteFile(HttpServletRequest request,
			HttpServletResponse response, int noField) throws ServletException,
			IOException {
		try {

			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery(sql);
			String fline = "";
			String filename = "Report.sys";
			FileWriter fw = new FileWriter(filename);
			BufferedWriter bw = new BufferedWriter(fw);
			fline = fline + repName + "\n";
			fline = fline + repHeader + "\n";
			int rcount = 0;
			while (rs.next()) {
				for (int i = 1; i <= noField; i++) {
					fline = fline + "   " + rs.getString(i) + "^";
				}

				fline = fline + "^\n";
				rcount = rcount + 1;
			}
			if (rcount < 1)
				fline = fline + "Record not found...";
			bw.write(fline);
			bw.close();
		} catch (Exception e) {
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}

	public void handle(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String action = request.getParameter("actionS");
			action = action.trim();
			if (action.equals("ATTRegStaff")) 
			{
				repName = "Finger Print Image - Registred Staff";
				repHeader = "Emp Id^Emp Name^Depart^Desig";
				sql = "SELECT A.CHR_EMPID,A.CHR_STAFFNAME,B.CHR_DEPARTNAME,C.CHR_DESIGNAME FROM  com_m_staff  A,  com_m_depart   B, com_m_desig  C ";
				sql = sql+ "WHERE A.INT_DEPARTID=B.INT_DEPARTID AND A.INT_DESIGID=C.INT_DESIGID AND ";
				sql = sql+ "CHR_EMPID IN (SELECT CHR_EMPID FROM  att_m_staffimage ) ORDER BY CHR_STAFFNAME";
				WriteFile(request, response, 4);
				response.sendRedirect("Smart Attendance/ReportVewFingerPrint.jsp");
			}
			if(action.equals("ATTFPRegCancel"))
			{
				String ids[] =request.getParameterValues("staffid");
				for(int u=0; u<ids.length;u++)
					com.my.org.erp.common.CommonFunctions.Execute("DELETE FROM com_m_staffimage WHERE CHR_EMPID='"+ids[u]+"'");
				response.sendRedirect("Smart Attendance/FingerPrintRegistrationView.jsp");
			}
			if (action.equals("ATTNonRegStaff")) 
			{
				repName = "Finger Print Image - Non Registred Staff";
				repHeader = "Emp Id^Emp Name^Depart^Desig";
				sql = "SELECT A.CHR_EMPID,A.CHR_STAFFNAME,B.CHR_DEPARTNAME,C.CHR_DESIGNAME FROM  com_m_staff  A,  com_m_depart   B, com_m_desig  C ";
				sql = sql+ "WHERE A.INT_DEPARTID=B.INT_DEPARTID AND A.INT_DESIGID=C.INT_DESIGID AND ";
				sql = sql+ "CHR_EMPID NOT IN (SELECT CHR_EMPID FROM  att_m_staffimage ) ORDER BY CHR_STAFFNAME";
				WriteFile(request, response, 4);
				response.sendRedirect("Smart Attendance/ReportVewFingerPrint.jsp");
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
