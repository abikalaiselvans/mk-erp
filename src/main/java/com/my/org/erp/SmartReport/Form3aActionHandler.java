package com.my.org.erp.SmartReport;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JRExporter;
import net.sf.jasperreports.engine.JasperPrint;

import com.my.org.erp.Math.MathFunction;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.common.CommonFunctions;

public class Form3aActionHandler extends AbstractActionHandler {

	public void handle(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("inside bank handle");
		try {
			String action = request.getParameter("actionS");
			String comid = request.getParameter("company");
			String branchid = request.getParameter("branch");
			String officeid = request.getParameter("Office");
			String year = request.getParameter("Year");
			int yr = Integer.parseInt(year);
			String staff[] = request.getParameterValues("staff");

			int byear = 0, cyear = 0;
			String form2A = "0.00", form3A = "0.00", form4A = "0.00", form4bA = "0.00";
			String form2M = "0.00", form3M = "0.00", form4M = "0.00", form4bM = "0.00";
			String form2J = "0.00", form3J = "0.00", form4J = "0.00", form4bJ = "0.00";
			String form2L = "0.00", form3L = "0.00", form4L = "0.00", form4bL = "0.00";
			String form2U = "0.00", form3U = "0.00", form4U = "0.00", form4bU = "0.00";
			String form2S = "0.00", form3S = "0.00", form4S = "0.00", form4bS = "0.00";
			String form2O = "0.00", form3O = "0.00", form4O = "0.00", form4bO = "0.00";
			String form2N = "0.00", form3N = "0.00", form4N = "0.00", form4bN = "0.00";
			String form2D = "0.00", form3D = "0.00", form4D = "0.00", form4bD = "0.00";
			String form21 = "0.00", form31 = "0.00", form41 = "0.00", form4b1 = "0.00";
			String form2F = "0.00", form3F = "0.00", form4F = "0.00", form4bF = "0.00";
			String form2R = "0.00", form3R = "0.00", form4R = "0.00", form4bR = "0.00";
			String cyend = "", byend = "", staffid = "";
			double form2t = 0.00, form3t = 0.00, form4t = 0.00, form4bt = 0.00;
			String empid = "";
			for (int k = 0; k < staff.length; k++)
				empid = empid + ",'" + staff[k] + "'";

			staffid = empid.substring(1);

			byear = (Integer.parseInt(year));
			cyear = Integer.parseInt(year + 1);
			cyend = year.substring(2, 4);
			byend = (("" + byear).trim()).substring(2, 4);

			String sql = "";
			sql = " SELECT b.CHR_EMPID, b.CHR_PFNO,a.CHR_EMPNAME ";
			sql = sql + "	FROM  com_m_staff b,pay_t_salary a ";
			sql = sql + "	WHERE b.CHR_TYPE!='T' AND b.CHR_HOLD!='Y'";

			if (!"0".equals(comid))
				sql = sql + "	AND b.INT_COMPANYID = " + comid;

			if (!"0".equals(branchid))
				sql = sql + "	AND b.INT_BRANCHID = " + branchid;

			if (!"0".equals(officeid))
				sql = sql + "	AND b.INT_OFFICEID = " + officeid;

			sql = sql + " AND a.CHR_EMPID=b.CHR_EMPID and a.CHR_EMPID in("
					+ staffid + ") group BY a.CHR_EMPID";

			String data[][] = CommonFunctions.QueryExecute(sql);
			if (data.length > 0)
				for (int i = 0; i < data.length; i++) {

					form2A = "0.00";
					form3A = "0.00";
					form4A = "0.00";
					form4bA = "0.00";
					form2M = "0.00";
					form3M = "0.00";
					form4M = "0.00";
					form4bM = "0.00";
					form2J = "0.00";
					form3J = "0.00";
					form4J = "0.00";
					form4bJ = "0.00";
					form2L = "0.00";
					form3L = "0.00";
					form4L = "0.00";
					form4bL = "0.00";
					form2U = "0.00";
					form3U = "0.00";
					form4U = "0.00";
					form4bU = "0.00";
					form2S = "0.00";
					form3S = "0.00";
					form4S = "0.00";
					form4bS = "0.00";
					form2O = "0.00";
					form3O = "0.00";
					form4O = "0.00";
					form4bO = "0.00";
					form2N = "0.00";
					form3N = "0.00";
					form4N = "0.00";
					form4bN = "0.00";
					form2D = "0.00";
					form3D = "0.00";
					form4D = "0.00";
					form4bD = "0.00";
					form21 = "0.00";
					form31 = "0.00";
					form41 = "0.00";
					form4b1 = "0.00";
					form2F = "0.00";
					form3F = "0.00";
					form4F = "0.00";
					form4bF = "0.00";
					form2R = "0.00";
					form3R = "0.00";
					form4R = "0.00";
					form4bR = "0.00";

					sql = " SELECT a.CHR_EMPNAME ,ROUND(sum(a.DOU_PENBASIC),2),ROUND(sum(a.DOU_PF),2),ROUND(sum(a.DOU_CPYPF1),2),ROUND(sum(a.DOU_CPYPF2),2) ";
					sql = sql + "	FROM pay_t_salary a ";
					sql = sql + "	WHERE a.CHR_EMPID ='" + data[i][0] + "' ";
					sql = sql + " AND a.CHR_MONTH ='Apirl' AND a.INT_YEAR="
							+ byear + " group by a.CHR_EMPID";
					String data1[][] = CommonFunctions.QueryExecute(sql);
					if (data1.length > 0) {
						form2A = data1[0][1];
						form3A = data1[0][2];
						form4A = data1[0][3];
						form4bA = data1[0][4];
					}

					sql = " SELECT a.CHR_EMPNAME ,ROUND(sum(a.DOU_PENBASIC),2),ROUND(sum(a.DOU_PF),2),ROUND(sum(a.DOU_CPYPF1),2),ROUND(sum(a.DOU_CPYPF2),2) ";
					sql = sql + "	FROM pay_t_salary a ";
					sql = sql + "	WHERE a.CHR_EMPID ='" + data[i][0] + "' ";
					sql = sql + " AND a.CHR_MONTH ='May' AND a.INT_YEAR="
							+ byear + " group by a.CHR_EMPID";
					String data2[][] = CommonFunctions.QueryExecute(sql);
					if (data2.length > 0) {
						form2M = data2[0][1];
						form3M = data2[0][2];
						form4M = data2[0][3];
						form4bM = data2[0][4];
					}

					sql = " SELECT a.CHR_EMPNAME ,ROUND(sum(a.DOU_PENBASIC),2),ROUND(sum(a.DOU_PF),2),ROUND(sum(a.DOU_CPYPF1),2),ROUND(sum(a.DOU_CPYPF2),2) ";
					sql = sql + "	FROM pay_t_salary a ";
					sql = sql + "	WHERE a.CHR_EMPID ='" + data[i][0] + "' ";
					sql = sql + " AND a.CHR_MONTH ='June' AND a.INT_YEAR="
							+ byear + " group by a.CHR_EMPID";
					String data3[][] = CommonFunctions.QueryExecute(sql);
					if (data3.length > 0) {
						form2J = data3[0][1];
						form3J = data3[0][2];
						form4J = data3[0][3];
						form4bJ = data3[0][4];
					}

					sql = " SELECT a.CHR_EMPNAME ,ROUND(sum(a.DOU_PENBASIC),2),ROUND(sum(a.DOU_PF),2),ROUND(sum(a.DOU_CPYPF1),2),ROUND(sum(a.DOU_CPYPF2),2) ";
					sql = sql + "	FROM pay_t_salary a ";
					sql = sql + "	WHERE a.CHR_EMPID ='" + data[i][0] + "' ";
					sql = sql + " AND a.CHR_MONTH ='July' AND a.INT_YEAR="
							+ byear + " group by a.CHR_EMPID";
					String data4[][] = CommonFunctions.QueryExecute(sql);
					if (data4.length > 0) {
						form2L = data4[0][1];
						form3L = data4[0][2];
						form4L = data4[0][3];
						form4bL = data4[0][4];
					}

					sql = " SELECT a.CHR_EMPNAME ,ROUND(sum(a.DOU_PENBASIC),2),ROUND(sum(a.DOU_PF),2),ROUND(sum(a.DOU_CPYPF1),2),ROUND(sum(a.DOU_CPYPF2),2) ";
					sql = sql + "	FROM pay_t_salary a ";
					sql = sql + "	WHERE a.CHR_EMPID ='" + data[i][0] + "' ";
					sql = sql + " AND a.CHR_MONTH ='August' AND a.INT_YEAR="
							+ byear + " group by a.CHR_EMPID";
					String data5[][] = CommonFunctions.QueryExecute(sql);
					if (data5.length > 0) {
						form2U = data5[0][1];
						form3U = data5[0][2];
						form4U = data5[0][3];
						form4bU = data5[0][4];
					}

					sql = " SELECT a.CHR_EMPNAME ,ROUND(sum(a.DOU_PENBASIC),2),ROUND(sum(a.DOU_PF),2),ROUND(sum(a.DOU_CPYPF1),2),ROUND(sum(a.DOU_CPYPF2),2) ";
					sql = sql + "	FROM pay_t_salary a ";
					sql = sql + "	WHERE a.CHR_EMPID ='" + data[i][0] + "' ";
					sql = sql + " AND a.CHR_MONTH ='September' AND a.INT_YEAR="
							+ byear + " group by a.CHR_EMPID";
					String data6[][] = CommonFunctions.QueryExecute(sql);
					if (data6.length > 0) {
						form2S = data6[0][1];
						form3S = data6[0][2];
						form4S = data6[0][3];
						form4bS = data6[0][4];
					}

					sql = " SELECT a.CHR_EMPNAME ,ROUND(sum(a.DOU_PENBASIC),2),ROUND(sum(a.DOU_PF),2),ROUND(sum(a.DOU_CPYPF1),2),ROUND(sum(a.DOU_CPYPF2),2) ";
					sql = sql + "	FROM pay_t_salary a ";
					sql = sql + "	WHERE a.CHR_EMPID ='" + data[i][0] + "' ";
					sql = sql + " AND a.CHR_MONTH ='October' AND a.INT_YEAR="
							+ byear + " group by a.CHR_EMPID";
					String data7[][] = CommonFunctions.QueryExecute(sql);
					if (data7.length > 0) {
						form2O = data7[0][1];
						form3O = data7[0][2];
						form4O = data7[0][3];
						form4bO = data7[0][4];
					}

					sql = " SELECT a.CHR_EMPNAME ,ROUND(sum(a.DOU_PENBASIC),2),ROUND(sum(a.DOU_PF),2),ROUND(sum(a.DOU_CPYPF1),2),ROUND(sum(a.DOU_CPYPF2),2) ";
					sql = sql + "	FROM pay_t_salary a ";
					sql = sql + "	WHERE a.CHR_EMPID ='" + data[i][0] + "' ";
					sql = sql + " AND a.CHR_MONTH ='November' AND a.INT_YEAR="
							+ byear + " group by a.CHR_EMPID";
					String data8[][] = CommonFunctions.QueryExecute(sql);
					if (data8.length > 0) {
						form2N = data8[0][1];
						form3N = data8[0][2];
						form4N = data8[0][3];
						form4bN = data8[0][4];
					}

					sql = " SELECT a.CHR_EMPNAME ,ROUND(sum(a.DOU_PENBASIC),2),ROUND(sum(a.DOU_PF),2),ROUND(sum(a.DOU_CPYPF1),2),ROUND(sum(a.DOU_CPYPF2),2) ";
					sql = sql + "	FROM pay_t_salary a ";
					sql = sql + "	WHERE a.CHR_EMPID ='" + data[i][0] + "' ";
					sql = sql + " AND a.CHR_MONTH ='December' AND a.INT_YEAR="
							+ byear + " group by a.CHR_EMPID";
					String data9[][] = CommonFunctions.QueryExecute(sql);
					if (data9.length > 0) {
						form2D = data9[0][1];
						form3D = data9[0][2];
						form4D = data9[0][3];
						form4bD = data9[0][4];
					}

					sql = " SELECT a.CHR_EMPNAME ,ROUND(sum(a.DOU_PENBASIC),2),ROUND(sum(a.DOU_PF),2),ROUND(sum(a.DOU_CPYPF1),2),ROUND(sum(a.DOU_CPYPF2),2) ";
					sql = sql + "	FROM pay_t_salary a ";
					sql = sql + "	WHERE a.CHR_EMPID ='" + data[i][0] + "' ";
					sql = sql + " AND a.CHR_MONTH ='January' AND a.INT_YEAR="
							+ cyear + " group by a.CHR_EMPID";
					String data10[][] = CommonFunctions.QueryExecute(sql);
					if (data10.length > 0) {
						form21 = data10[0][1];
						form31 = data10[0][2];
						form41 = data10[0][3];
						form4b1 = data10[0][4];
					}

					sql = " SELECT a.CHR_EMPNAME ,ROUND(sum(a.DOU_PENBASIC),2),ROUND(sum(a.DOU_PF),2),ROUND(sum(a.DOU_CPYPF1),2),ROUND(sum(a.DOU_CPYPF2),2) ";
					sql = sql + "	FROM pay_t_salary a ";
					sql = sql + "	WHERE a.CHR_EMPID ='" + data[i][0] + "' ";
					sql = sql + " AND a.CHR_MONTH ='February' AND a.INT_YEAR="
							+ cyear + " group by a.CHR_EMPID";
					String data11[][] = CommonFunctions.QueryExecute(sql);
					if (data11.length > 0) {
						form2F = data11[0][1];
						form3F = data11[0][2];
						form4F = data11[0][3];
						form4bF = data11[0][4];
					}

					sql = " SELECT a.CHR_EMPNAME ,ROUND(sum(a.DOU_PENBASIC),2),ROUND(sum(a.DOU_PF),2),ROUND(sum(a.DOU_CPYPF1),2),ROUND(sum(a.DOU_CPYPF2),2) ";
					sql = sql + "	FROM pay_t_salary a ";
					sql = sql + "	WHERE a.CHR_EMPID ='" + data[i][0] + "' ";
					sql = sql + " AND a.CHR_MONTH ='March' AND a.INT_YEAR="
							+ cyear + " group by a.CHR_EMPID";
					String data12[][] = CommonFunctions.QueryExecute(sql);
					if (data12.length > 0) {
						form2R = data12[0][1];
						form3R = data12[0][2];
						form4R = data12[0][3];
						form4bR = data12[0][4];
					}

				}

		} catch (Exception e) {
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request
					.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
		}
	}

}
