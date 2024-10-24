package com.my.org.erp.SmartPayroll;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;

public class DOBActionHandler extends AbstractActionHandler {
	String OptType, fromdate, todate, sql;

	private void DOBList(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			ArrayList<Travel> travelingList = new ArrayList<Travel>();
			Statement st = con.createStatement();
			//com.my.org.erp.common.CommonFunctions.RivisionGenerate();
			OptType = request.getParameter("OptType");
			fromdate = request.getParameter("fromdt");
			String fdate = DateUtil.FormateDateSQL(fromdate);
			todate = request.getParameter("todt");
			String tdate = DateUtil.FormateDateSQL(todate);
			if (OptType == "M") {
				String sql = "SELECT A.CHR_EMPID,A.CHR_STAFFNAME,B.CHR_DEPARTNAME,C.CHR_DESIGNAME,A.CHR_GENDER,A.DT_DOJCOLLEGE,";
				sql = sql
						+ "A.DT_DOB FROM  com_m_staff  A,  com_m_depart   B, com_m_desig  C WHERE A.DT_DOB>='"
						+ fdate + "'";
				sql = sql
						+ "AND A.DT_DOB<='"
						+ tdate
						+ "' AND A.INT_DEPARTID=B.INT_DEPARTID AND A.INT_DESIGID=C.INT_DESIGID";
			} else {
				String sql = "SELECT A.CHR_EMPID,A.CHR_STAFFNAME,B.CHR_DEPARTNAME,C.CHR_DESIGNAME,A.CHR_GENDER,A.DT_DOJCOLLEGE,";
				sql = sql
						+ "A.DT_WEDDATE FROM  com_m_staff  A,  com_m_depart   B, com_m_desig  C WHERE A.DT_WEDDATE>='"
						+ fdate + "' ";
				sql = sql
						+ "AND A.DT_WEDDATE<='"
						+ tdate
						+ "'AND A.INT_DEPARTID=B.INT_DEPARTID AND A.INT_DESIGID=C.INT_DESIGID";
			}
			ResultSet rs = st.executeQuery(sql);
			while (rs.next()) {
				String travelId = rs.getString("");
				String empId = rs.getString(2);
				String visitPlace = rs.getString(3);
				String period = rs.getString(4);
				String purpose = rs.getString(5);
				String ticket = rs.getString(6);
				String fromDept = rs.getString(7);
				String toDept = rs.getString(8);
				String deptDate = rs.getString(9);
				String deptTime = rs.getString(10);
				String fromReturn = rs.getString(11);
				String toReturn = rs.getString(12);
				String returnDate = rs.getString(13);
				String returnTime = rs.getString(14);
				Travel travel = new Travel(travelId, empId, visitPlace, period,
						purpose, ticket, fromDept, toDept, deptDate, deptTime,
						fromReturn, toReturn, returnDate, returnTime);
				travelingList.add(travel);
			}
			HttpSession session = request.getSession();
			session.setAttribute("travelingList", travelingList);
		} catch (Exception e) {
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}

	public void handle(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			String action = request.getParameter("actionS");
			if (action.equals("PAYbdobList")) {
				DOBList(request, response);
				con.close();    
				response.sendRedirect("Smart Payroll/DOBView.jsp");
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
