package com.my.org.erp.SmartAttendance;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.common.CommonFunctions;

public class AttendanceMethod extends HttpServlet {

	private static final long serialVersionUID = 1353669185209145078L;

	/*
	 * Start - Author :: Kalaiselvan Date: 1/02/2006
	 */

	public static void loadCompensationData(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {
			int year = Integer.parseInt(request.getParameter("year"));
			int mon = Integer.parseInt(request.getParameter("month"));
			String Office = "" + request.getParameter("Office");
			String s = "";
			if (!"0".equals(Office))
				s = " AND INT_OFFICEID=" + Office;
			String startLetter = "" + request.getParameter("id");
			String sql = "";
			if ("0".equals(startLetter)) {
				sql = " SELECT A.CHR_EMPID, A.CHR_STAFFNAME, C.CHR_COMPANYNAME, B.CHR_BRANCHNAME, ";
				sql = sql
						+ " D.CHR_DEPARTNAME, E.CHR_DESIGNAME, F.CHR_HOLINAME, ";
				sql = sql + " count(F.DT_HOLIDATE) FROM  com_m_staff  A, ";
				sql = sql
						+ " com_m_branch  B, com_m_company C,  com_m_depart D,  com_m_desig E, ";
				sql = sql
						+ " att_t_compensation F WHERE A.INT_BRANCHID=B.INT_BRANCHID ";
				sql = sql + s;
				sql = sql + " AND A.INT_DEPARTID=D.INT_DEPARTID ";
				sql = sql
						+ " AND A.INT_DESIGID= E.INT_DESIGID AND A.CHR_EMPID=F.CHR_EMPID ";
				sql = sql
						+ " AND F.CHR_MONTH='"
						+ com.my.org.erp.ServiceLogin.DateUtil
								.getMonth(mon) + "' ";
				sql = sql + " AND F.INT_YEAR=" + year
						+ " group by A.CHR_EMPID order By A.CHR_STAFFNAME";

			} else {

				sql = " SELECT A.CHR_EMPID, A.CHR_STAFFNAME , C.CHR_COMPANYNAME, B.CHR_BRANCHNAME, ";
				sql = sql
						+ " D.CHR_DEPARTNAME, E.CHR_DESIGNAME, F.CHR_HOLINAME, count(F.DT_HOLIDATE) ";
				sql = sql + " FROM com_m_staff A, ";
				sql = sql
						+ " com_m_branch B, com_m_company C, com_m_depart D, com_m_desig E, ";
				sql = sql
						+ " att_t_compensation F WHERE A.INT_BRANCHID=B.INT_BRANCHID ";
				sql = sql + s;
				sql = sql + " AND A.INT_DEPARTID=D.INT_DEPARTID ";
				sql = sql
						+ " AND A.INT_DESIGID= E.INT_DESIGID AND A.CHR_EMPID=F.CHR_EMPID ";
				sql = sql
						+ " AND F.CHR_MONTH='"
						+ com.my.org.erp.ServiceLogin.DateUtil
								.getMonth(mon) + "' ";
				sql = sql + " AND F.INT_YEAR=" + year
						+ " and A.CHR_STAFFNAME LIKE '" + startLetter
						+ "%' group by A.CHR_EMPID order By A.CHR_STAFFNAME";
			}
			String readData[][] = com.my.org.erp.common.CommonFunctions
					.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			for (int u = 0; u < readData.length; u++) {
				sb.append("<Compensation>");
				sb.append("<Empid>" + readData[u][0] + "</Empid>");
				sb.append("<Staffname>" + readData[u][1] + "</Staffname>");
				sb.append("<Companyname>" + readData[u][2] + "</Companyname>");
				sb.append("<Branchname>" + readData[u][3] + "</Branchname>");
				sb.append("<Depart>" + readData[u][4] + "</Depart>");
				sb.append("<Desig>" + readData[u][5] + "</Desig>");
				sb.append("<NoDays>" + readData[u][7] + "</NoDays>");
				sb.append("</Compensation>");
			}
			response.setContentType("text/xml");
			response.setHeader("Cache-Control", "no-cache");
			response.getWriter().write(
					"<compensations>" + sb.toString() + "</compensations>");

		} catch (Exception e) {

			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request
					.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
			System.out.println(e.getMessage());
		}
	}

	public static void loadOverTime(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {
			String year = request.getParameter("year");
			String mon = request.getParameter("month");
			String day = request.getParameter("day");
			String startLetter = "" + request.getParameter("id");
			String Office = "" + request.getParameter("Office");
			String sql = "";
			sql = " SELECT DISTINCT A.CHR_EMPID, A.CHR_STAFFNAME, C.CHR_COMPANYNAME, B.CHR_BRANCHNAME,";
			sql = sql
					+ " D.CHR_DEPARTNAME, E.CHR_DESIGNAME,  F.INT_MINS,DATE_FORMAT(F.DT_OTDATE,'%d-%b-%Y')  FROM  com_m_staff A, ";
			sql = sql
					+ " com_m_branch B, com_m_company C, com_m_depart D, com_m_desig E, att_t_ot F ";
			sql = sql
					+ " WHERE A.INT_BRANCHID=B.INT_BRANCHID  AND B.INT_COMPANYID = C.INT_COMPANYID ";
			sql = sql + " AND A.INT_DEPARTID=D.INT_DEPARTID ";
			sql = sql + " AND A.INT_DESIGID= E.INT_DESIGID ";
			sql = sql + " AND A.CHR_EMPID=F.CHR_EMPID ";
			if (!"0".equals(Office))
				sql = sql + " AND INT_OFFICEID=" + Office;
			;
			if (!"0".equals(day))
				sql = sql + " AND DAY(F.DT_OTDATE) = " + day;
			if (!"0".equals(mon))
				sql = sql + " AND MONTH(F.DT_OTDATE)=" + mon;
			if (!"0".equals(year))
				sql = sql + " AND YEAR(F.DT_OTDATE)=" + year;
			if (!"0".equals(startLetter))
				sql = sql + " AND A.CHR_STAFFNAME LIKE '" + startLetter + "%'";
			sql = sql + "  ORDER BY A.CHR_STAFFNAME";

			System.out.println(sql);

			String readData[][] = CommonFunctions.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			for (int u = 0; u < readData.length; u++) {
				sb.append("<OverTime>");
				sb.append("<Empid>" + readData[u][0] + "</Empid>");
				sb.append("<Staffname>" + readData[u][1] + "</Staffname>");
				sb.append("<Companyname>" + readData[u][2] + "</Companyname>");
				sb.append("<Branchname>" + readData[u][3] + "</Branchname>");
				sb.append("<Depart>" + readData[u][4] + "</Depart>");
				sb.append("<Desig>" + readData[u][5] + "</Desig>");
				sb.append("<time>" + readData[u][6] + "</time>");
				sb.append("<Odate>" + readData[u][7] + "</Odate>");
				sb.append("</OverTime>");
			}

			response.setContentType("text/xml");
			response.setHeader("Cache-Control", "no-cache");
			response.getWriter().write(
					"<overtimes>" + sb.toString() + "</overtimes>");

		} catch (Exception e) {

			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request
					.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
			System.out.println(e.getMessage());
		}
	}

	public static void loadExtraDayschk(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {

			String typeDate = request.getParameter("ID");
			String changeDate = com.my.org.erp.ServiceLogin.DateUtil
					.FormateDateSQL(typeDate);

			String sql = "SELECT DT_HOLIDATE from att_t_holiday WHERE DT_HOLIDATE='"
					+ changeDate + "'";
			String readData[][] = com.my.org.erp.common.CommonFunctions
					.QueryExecute(sql);
			String message = "";

			if (readData.length == 0)
				message = "true";
			else
				message = "false";

			response.setContentType("text/xml");
			response.setHeader("Cache-Control", "no-cache");
			response.getWriter().write(message);

		} catch (Exception e) {

			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request
					.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
			System.out.println(e.getMessage());
		}
	}

	public static void loadShiftData(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {
			int year = Integer.parseInt(request.getParameter("year"));
			String month = request.getParameter("month");
			String startLetter = "" + request.getParameter("id");
			String sql = "";
			String shor = "";

			if ("0".equals(startLetter))
				shor = "";
			else
				shor = " AND A.CHR_STAFFNAME LIKE '" + startLetter + "%'";

			sql = "SELECT A.CHR_EMPID, A.CHR_STAFFNAME, C.CHR_COMPANYNAME, B.CHR_BRANCHNAME, ";
			sql = sql
					+ "D.CHR_DEPARTNAME, E.CHR_DESIGNAME FROM  com_m_staff  A, ";
			sql = sql
					+ " com_m_branch B, com_m_company C, com_m_depart D, com_m_desig E, ";
			sql = sql
					+ " att_t_shiftallocation F WHERE A.INT_BRANCHID=B.INT_BRANCHID ";
			sql = sql + " AND A.INT_DEPARTID=D.INT_DEPARTID ";
			sql = sql
					+ " AND A.INT_DESIGID= E.INT_DESIGID AND A.CHR_EMPID=F.CHR_EMPID ";
			sql = sql + " AND F.CHR_MONTH='" + month + "' AND F.INT_YEAR="
					+ year;
			sql = sql + shor + " group by a.CHR_EMPID order By A.CHR_STAFFNAME";

			String readData[][] = com.my.org.erp.common.CommonFunctions
					.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			for (int u = 0; u < readData.length; u++) {
				sb.append("<Shift>");
				sb.append("<Empid>" + readData[u][0] + "</Empid>");
				sb.append("<Staffname>" + readData[u][1] + "</Staffname>");
				sb.append("<Companyname>" + readData[u][2] + "</Companyname>");
				sb.append("<Branchname>" + readData[u][3] + "</Branchname>");
				sb.append("<Depart>" + readData[u][4] + "</Depart>");
				sb.append("<Desig>" + readData[u][5] + "</Desig>");
				sb.append("</Shift>");
			}
			response.setContentType("text/xml");
			response.setHeader("Cache-Control", "no-cache");
			response.getWriter()
					.write("<shifts>" + sb.toString() + "</shifts>");

		} catch (Exception e) {

			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request
					.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
			System.out.println(e.getMessage());
		}
	}

	public static void loadBranchData(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {
			int id = Integer.parseInt(request.getParameter("id"));
			String stltr = "" + request.getParameter("startLetter");

			String sql = null;
			if (stltr.equals("null")) {
				sql = "SELECT INT_BRANCHID,CHR_BRANCHNAME,CHR_LEGALNAME,CHR_CITY,CHR_COUNTRY,CHR_EMAIL ";
				sql = sql + "FROM  com_m_branch  WHERE INT_COMPANYID=" + id;

			} else {
				sql = "SELECT INT_BRANCHID,CHR_BRANCHNAME,CHR_LEGALNAME,CHR_CITY,CHR_COUNTRY,CHR_EMAIL ";
				sql = sql + "FROM  com_m_branch  WHERE INT_COMPANYID=" + id
						+ " AND CHR_BRANCHNAME LIKE'" + stltr + "%'";
			}
			String readData[][] = com.my.org.erp.common.CommonFunctions
					.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();

			boolean flag = false;
			for (int u = 0; u < readData.length; u++) {
				sb.append("<branch>");
				sb.append("<id>" + readData[u][0] + "</id>");
				sb.append("<branchName>" + readData[u][1] + "</branchName>");
				sb.append("<legalName>" + readData[u][2] + "</legalName>");
				sb.append("<city>" + readData[u][3] + "</city>");
				sb.append("<country>" + readData[u][4] + "</country>");
				sb.append("<email>" + readData[u][5] + "</email>");
				sb.append("</branch>");
				flag = true;
			}
			if (flag) {

				response.setContentType("text/xml");
				response.setHeader("Cache-Control", "no-cache");
				// //System.out.println(sb.toString());
				response.getWriter().write(
						"<branches>" + sb.toString() + "</branches>");
			} else {
				response.setStatus(HttpServletResponse.SC_NO_CONTENT);
			}
		} catch (Exception e) {

			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request
					.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
			System.out.println(e.getMessage());
		}
	}

	public static void loadCommonHolidayData(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException 
	{
		try 
		{
			int year = Integer.parseInt(request.getParameter("year"));
			int mon = Integer.parseInt(request.getParameter("month"));
			String sql = "";
			sql = " SELECT INT_ID ,DATE_FORMAT(DT_HOLIDATE,'%d-%m-%Y') ,CHR_HOLIDESC,CHR_STATUS FROM  att_t_commonholiday ";
			sql = sql + " WHERE INT_ID>0 ";

			if (mon > 0)
				sql = sql
						+ " AND CHR_MONTH='"
						+ com.my.org.erp.ServiceLogin.DateUtil
								.getMonth(mon) + "'";

			sql = sql + " AND INT_YEAR =" + year + " ORDER BY DT_HOLIDATE";
			// System.out.println(sql);

			String readData[][] =  CommonFunctions.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			for (int u = 0; u < readData.length; u++)
			{
				sb.append("<Holiday>");
				sb.append("<Id>" + readData[u][0] + "</Id>");
				sb.append("<Date>" + readData[u][1] + "</Date>");
				sb.append("<Desc>" + readData[u][2] + "</Desc>");
				sb.append("<Status>" + readData[u][3] + "</Status>");
				sb.append("</Holiday>");
			}
			response.setContentType("text/xml");
			response.setHeader("Cache-Control", "no-cache");
			response.getWriter().write(	"<holidays>" + sb.toString() + "</holidays>");

		} catch (Exception e) {

			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request
					.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
			System.out.println(e.getMessage());
		}
	}

	public static void loadDistrict(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {
			String stateId = request.getParameter("id");
			String vrtxtstr = request.getParameter("txtSer");
			// //System.out.println("vendor"+stateId);
			vrtxtstr = vrtxtstr.toUpperCase();
			String query = "SELECT INT_DISTRICTID,CHR_DISTRICT from  com_m_district  where int_stateid='"
					+ stateId + "' ORDER BY CHR_DISTRICT";

			String readData[][] = CommonFunctions.QueryExecute(query);
			StringBuffer sb = new StringBuffer();
			boolean flag = false;
			for (int u = 0; u < readData.length; u++) {
				if (readData[u][1].toUpperCase().startsWith(vrtxtstr)
						|| "".equalsIgnoreCase(vrtxtstr)) {
					flag = true;
					sb.append("<district>");
					sb.append("<districtId>" + readData[u][0] + "</districtId>");
					sb.append("<districtName>" + readData[u][1]
							+ "</districtName>");
					sb.append("</district>");
				}
			}
			if (flag) {
				response.setContentType("text/xml");
				response.setHeader("Cache-Control", "no-cache");
				response.getWriter().write(
						"<districts>" + sb.toString() + "</districts>");
			} else {
				response.setStatus(HttpServletResponse.SC_NO_CONTENT);
			}
		} catch (Exception e) {
			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request
					.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
			System.out.println(e.getMessage());
		}
	}

	// Start Author :: Kalaiselvan ------------------------------Load
	// Staff-----------
	public static void loadStaff(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {
			String companyId = request.getParameter("companyId");
			String branchId = request.getParameter("branchId");
			String departId = request.getParameter("departId");
			String desigId = request.getParameter("desigId");
			String startLetter = request.getParameter("startLetter");
			int dbcompanyid = 0;
			int dbbranchid = 0;
			int dbdeptid = 0;
			int dbdesgid = 0;
			dbcompanyid = Integer.parseInt(companyId);
			dbbranchid = Integer.parseInt(branchId);
			dbdeptid = Integer.parseInt(departId);
			dbdesgid = Integer.parseInt(desigId);
			String br = "";

			String dg = "";
			if (0 != dbdeptid)
				br = " AND A.INT_DEPARTID = " + dbdeptid;
			if (0 != dbdesgid)
				dg = " AND A.INT_DESIGID = " + dbdesgid;
			String query = "";
			if (!"0".equals(startLetter))
				startLetter = " AND CHR_STAFFNAME Like'" + startLetter
						+ "%' ORDER BY CHR_STAFFNAME";
			else
				startLetter = " ORDER BY CHR_STAFFNAME";
			if ("0".equals(companyId)) {
				if ("0".equals(branchId)) {
					query = " SELECT  A.CHR_EMPID,A.CHR_STAFFNAME,B.CHR_BRANCHNAME,C.CHR_DEPARTNAME,D.CHR_DESIGNAME "
							+ " , A.CHR_MOBILE  ,E.CHR_COMPANYNAME  from  com_m_staff  A, com_m_branch  B,  com_m_depart   C, com_m_desig  D,  com_m_company  E where A.INT_BRANCHID=B.INT_BRANCHID AND "
							+ " A.INT_DEPARTID=C.INT_DEPARTID AND A.INT_COMPANYID =  E.INT_COMPANYID AND A.INT_DESIGID=D.INT_DESIGID  "
							+ br + "  " + dg + " " + startLetter;
				} else if (!"0".equals(branchId)) {
					query = " SELECT  A.CHR_EMPID,A.CHR_STAFFNAME,B.CHR_BRANCHNAME,C.CHR_DEPARTNAME,D.CHR_DESIGNAME "
							+ "  ,A.CHR_MOBILE  ,E.CHR_COMPANYNAME  from  com_m_staff  A, com_m_branch  B,  com_m_depart   C, com_m_desig  D,  com_m_company  E where A.INT_BRANCHID=B.INT_BRANCHID AND A.INT_COMPANYID =  E.INT_COMPANYID "
							+ " AND A.INT_BRANCHID="
							+ dbbranchid
							+ " AND A.INT_DEPARTID=C.INT_DEPARTID "
							+ br
							+ "  AND A.INT_DESIGID=D.INT_DESIGID "
							+ dg
							+ startLetter;
				}

			} else if (!"0".equals(companyId)) {
				if ("0".equals(branchId)) {
					query = " SELECT  A.CHR_EMPID,A.CHR_STAFFNAME,B.CHR_BRANCHNAME,C.CHR_DEPARTNAME,D.CHR_DESIGNAME "
							+ " ,A.CHR_MOBILE  ,E.CHR_COMPANYNAME from  com_m_staff  A, com_m_branch  B,  com_m_depart   C, com_m_desig  D,  com_m_company  E where A.INT_BRANCHID=B.INT_BRANCHID AND A.INT_COMPANYID =  E.INT_COMPANYID AND "
							+ " A.INT_DEPARTID=C.INT_DEPARTID AND A.INT_COMPANYID="
							+ dbcompanyid
							+ " AND A.INT_DESIGID=D.INT_DESIGID  "
							+ br
							+ "  "
							+ dg + " " + startLetter;
				} else if (!"0".equals(branchId)) {
					query = " SELECT  A.CHR_EMPID,A.CHR_STAFFNAME,B.CHR_BRANCHNAME,C.CHR_DEPARTNAME,D.CHR_DESIGNAME "
							+ " , A.CHR_MOBILE ,E.CHR_COMPANYNAME  from  com_m_staff  A, com_m_branch  B,  com_m_depart   C, com_m_desig  D ,  com_m_company  E where A.INT_BRANCHID=B.INT_BRANCHID "
							+ "  AND A.INT_COMPANYID =  E.INT_COMPANYID AND A.INT_BRANCHID="
							+ dbbranchid
							+ " AND  A.INT_COMPANYID="
							+ dbcompanyid
							+ " AND A.INT_DEPARTID=C.INT_DEPARTID "
							+ br
							+ "  AND A.INT_DESIGID=D.INT_DESIGID "
							+ dg
							+ startLetter;
				}
			}
			// System.out.println(query);
			if (!"".equals(query)) {
				String readData[][] = com.my.org.erp.common.CommonFunctions
						.QueryExecute(query);
				if (readData.length > 0) {
					StringBuffer sb = new StringBuffer();
					for (int u = 0; u < readData.length; u++) {
						sb.append("<Staff>");
						sb.append("<StaffId>" + readData[u][0] + "</StaffId>");
						sb.append("<StaffName>" + readData[u][1]
								+ "</StaffName>");
						sb.append("<BranchName>" + readData[u][2]
								+ "</BranchName>");
						sb.append("<DepartName>" + readData[u][3]
								+ "</DepartName>");
						sb.append("<DesigName>" + readData[u][4]
								+ "</DesigName>");
						sb.append("<Mobile>" + readData[u][5] + "</Mobile>");
						sb.append("<Company>" + readData[u][6] + "</Company>");
						sb.append("</Staff>");
					}
					// System.out.println(sb);
					response.setContentType("text/xml");
					response.setHeader("Cache-Control", "no-cache");
					response.getWriter().write(
							"<Staffs>" + sb.toString() + "</Staffs>");
				} else {
					response.setStatus(HttpServletResponse.SC_NO_CONTENT);
				}
			}
		} catch (Exception e) {
			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request
					.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
			System.out.println(e.getMessage());
		}
	}

	// END Author :: Kalaiselvan ------------------------------Load
	// Staff-----------

	// Start Author :: Kalaiselvan ------------------------------Leave
	// Entry-----------
	public static void loadLeaveData(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {

			HttpSession session = request.getSession();
			String usertype = ""+session.getAttribute("USERTYPE").toString();
			String officeid = request.getParameter("Office");
			String Category = "" + request.getParameter("Category");
			String dept = request.getParameter("dept");
			int year = Integer.parseInt(request.getParameter("year"));
			String startLetter = "" + request.getParameter("startLetter");

			String OfficeData[][] = CommonFunctions
					.QueryExecute(" SELECT b.INT_OFFICEID,b.CHR_OFFICENAME FROM  com_m_office  b "
							+ "WHERE b.INT_OFFICEID IN("
							+ CommonFunctions
									.QueryExecute("SELECT a.CHR_OFFICELIST FROM m_user a "
											+ "WHERE a.CHR_USRNAME='"
											+ ""
											+ session.getAttribute("USRID")
											+ "' ")[0][0] + " )");
			String officeids = "";
			if (OfficeData.length > 0)
				for (int u = 0; u < OfficeData.length; u++)
					officeids = officeids + OfficeData[u][0] + ",";

			String catids = "";
			String empcategoryData[][] = CommonFunctions
					.QueryExecute(" SELECT b.INT_EMPLOYEECATEGORYID,b.CHR_CATEGORYNAME "
							+ " FROM  com_m_employeecategory  b WHERE b.INT_EMPLOYEECATEGORYID IN("
							+ CommonFunctions
									.QueryExecute("SELECT a.CHR_GATEGORYLIST "
											+ " FROM m_user a WHERE a.CHR_USRNAME='"
											+ session.getAttribute("USRID")
											+ "' ")[0][0] + " )");
			if (empcategoryData.length > 0)
				for (int u = 0; u < empcategoryData.length; u++)
					catids = catids + empcategoryData[u][0] + ",";

			String sql = " SELECT A.CHR_STAFFNAME ,B.* FROM  com_m_staff  A ,ATT_M_LEAVE B ";
			sql = sql
					+ " WHERE A.CHR_TYPE!='T' AND A.CHR_HOLD!='Y' AND A.CHR_EMPID=B.CHR_EMPID ";
			sql = sql + " AND B.INT_YEAR = " + year;
			if (!"0".equals(officeid))
				sql = sql + " AND A.INT_OFFICEID =" + officeid;
			else
				sql = sql + " AND A.INT_OFFICEID IN (" + officeids + "0 )";

			if (!"0".equals(Category))
				sql = sql + " AND A.CHR_CATEGORY =" + Category;
			else
				sql = sql + " AND A.CHR_CATEGORY IN (" + catids + "0 )";

			if (!"0".equals(dept))
				sql = sql + " AND A.INT_DEPARTID =" + dept;
			if (!"0".equals(startLetter))
				sql = sql + " AND A.CHR_STAFFNAME LIKE '" + startLetter
						+ "%'  ";
			sql = sql + " order by A.CHR_STAFFNAME";

			System.out.println(sql);
			String readData[][] = CommonFunctions.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			if (readData.length > 0) {
				sql = "SELECT CHR_LEAVENAME FROM att_m_leavetype ORDER BY INT_LEAVEID";
				String Leaves[][] = CommonFunctions.QueryExecute(sql);

				for (int u = 0; u < readData.length; u++) {
					sb.append("<Leave>");
					sb.append("<Empid>" + readData[u][1] + "</Empid>");
					sb.append("<usertype>" + usertype+ "</usertype>");
					
					sb.append("<Staffname>" + readData[u][0] + "</Staffname>");
					int o = 3;
					for (int x = 0; x < Leaves.length; x++) {
						sb.append("<Leave" + (x + 1) + ">" + readData[u][o]
								+ "</Leave" + (x + 1) + ">");
						o = o + 1;
						sb.append("<Eligible" + (x + 1) + ">" + readData[u][o]
								+ "</Eligible" + (x + 1) + ">");
						o = o + 1;
						sb.append("<Available" + (x + 1) + ">" + readData[u][o]
								+ "</Available" + (x + 1) + ">");
						o = o + 1;
					}
					sb.append("</Leave>");
				}
				response.setContentType("text/xml");
				response.setHeader("Cache-Control", "no-cache");
				response.getWriter().write(
						"<Leaves>" + sb.toString() + "</Leaves>");
			} else {
				response.setStatus(HttpServletResponse.SC_NO_CONTENT);
			}
		} catch (Exception e) {

			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request
					.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
			System.out.println(e.getMessage());
		}
	}

	// END Author :: Kalaiselvan ------------------------------Leave
	// Entry-----------

	// Start Author :: Kalaiselvan ------------------------------Leave
	// Entry-----------
	public static void loadLeaveDatas(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {

			HttpSession session = request.getSession();

			String officeid = "" + request.getParameter("Office");
			String Category = "" + request.getParameter("Category");
			String dept = "" + request.getParameter("dept");
			String year = "" + request.getParameter("year");
			String search = "" + request.getParameter("search");
			String startLetter = "" + request.getParameter("startLetter");

			String OfficeData[][] = CommonFunctions
					.QueryExecute(" SELECT b.INT_OFFICEID,b.CHR_OFFICENAME FROM  com_m_office  b "
							+ "WHERE b.INT_OFFICEID IN("
							+ CommonFunctions
									.QueryExecute("SELECT a.CHR_OFFICELIST FROM m_user a "
											+ "WHERE a.CHR_USRNAME='"
											+ ""
											+ session.getAttribute("USRID")
											+ "' ")[0][0] + " )");
			String officeids = "";
			if (OfficeData.length > 0)
				for (int u = 0; u < OfficeData.length; u++)
					officeids = officeids + OfficeData[u][0] + ",";

			String catids = "";
			String empcategoryData[][] = CommonFunctions
					.QueryExecute(" SELECT b.INT_EMPLOYEECATEGORYID,b.CHR_CATEGORYNAME "
							+ " FROM  com_m_employeecategory  b WHERE b.INT_EMPLOYEECATEGORYID IN("
							+ CommonFunctions
									.QueryExecute("SELECT a.CHR_GATEGORYLIST "
											+ " FROM m_user a WHERE a.CHR_USRNAME='"
											+ session.getAttribute("USRID")
											+ "' ")[0][0] + " )");
			if (empcategoryData.length > 0)
				for (int u = 0; u < empcategoryData.length; u++)
					catids = catids + empcategoryData[u][0] + ",";

			String sql = "";

			sql = " SELECT A.CHR_STAFFNAME ,B.* FROM   com_m_staff  A ,ATT_M_LEAVE B ";
			sql = sql + " WHERE A.CHR_EMPID=B.CHR_EMPID ";
			sql = sql + " AND A.CHR_TYPE!='T' AND A.CHR_HOLD!='Y' ";
			sql = sql + " AND B.INT_YEAR = " + year;

			if (!"0".equals(officeid))
				sql = sql + " AND A.INT_OFFICEID =" + officeid;
			else
				sql = sql + " AND A.INT_OFFICEID IN (" + officeids + "0 )";

			if (!"0".equals(Category))
				sql = sql + " AND A.CHR_CATEGORY =" + Category;
			else
				sql = sql + " AND A.CHR_CATEGORY IN (" + catids + "0 )";

			if (!"0".equals(dept))
				sql = sql + " AND INT_DEPARTID =" + dept;

			if ("".equals(search)) {
				if (!"0".equals(startLetter))
					sql = sql + " AND A.CHR_STAFFNAME LIKE '" + startLetter
							+ "%' ";
			} else {
				sql = sql + " AND( ( A.CHR_STAFFNAME LIKE '%" + search.trim()
						+ "%' ) OR ( A.CHR_EMPID LIKE '%" + search.trim()
						+ "%' )  )";

			}

			sql = sql + "  order by A.CHR_STAFFNAME";
			System.out.println(sql);

			// System.out.println(sql);
			String readData[][] = com.my.org.erp.common.CommonFunctions
					.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			if (readData.length > 0) {
				sql = "SELECT CHR_LEAVENAME FROM att_m_leavetype ORDER BY INT_LEAVEID";
				String Leaves[][] = com.my.org.erp.common.CommonFunctions
						.QueryExecute(sql);

				for (int u = 0; u < readData.length; u++) {
					sb.append("<Leave>");
					sb.append("<Empid>" + readData[u][1] + "</Empid>");
					sb.append("<Staffname>" + readData[u][0] + "</Staffname>");
					int o = 3;
					for (int x = 0; x < Leaves.length; x++) {
						sb.append("<Leave" + (x + 1) + ">" + readData[u][o]
								+ "</Leave" + (x + 1) + ">");
						o = o + 1;
						sb.append("<Eligible" + (x + 1) + ">" + readData[u][o]
								+ "</Eligible" + (x + 1) + ">");
						o = o + 1;
						sb.append("<Available" + (x + 1) + ">" + readData[u][o]
								+ "</Available" + (x + 1) + ">");
						o = o + 1;
					}
					sb.append("</Leave>");
				}
				response.setContentType("text/xml");
				response.setHeader("Cache-Control", "no-cache");
				response.getWriter().write(
						"<Leaves>" + sb.toString() + "</Leaves>");
			} else {
				response.setStatus(HttpServletResponse.SC_NO_CONTENT);
			}
		} catch (Exception e) {

			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request
					.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
			System.out.println(e.getMessage());
		}
	}

	// END Author :: Kalaiselvan ------------------------------Leave
	// Entry-----------

	public static void loadStaffHold(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {
			String Office = "" + request.getParameter("Office");
			String startLetter = "" + request.getParameter("id");
			String type = "" + request.getParameter("type");
			String sql = "";
			sql = " SELECT a.CHR_EMPID,a.CHR_STAFFNAME,g.CHR_COMPANYNAME,f.CHR_BRANCHNAME,c.CHR_DEPARTNAME,b.CHR_OFFICENAME ,a.CHR_HOLD ";
			sql = sql
					+ " FROM com_m_staff a ,  com_m_office  b ,com_m_depart c , ";
			sql = sql + " com_m_branch f , com_m_company g , att_t_hold h ";
			sql = sql + " where a.CHR_HOLD='Y'  AND a.CHR_EMPID = h.CHR_EMPID";
			sql = sql + " AND a.INT_COMPANYID =g.INT_COMPANYID  ";
			sql = sql + " AND a.INT_BRANCHID =f.INT_BRANCHID ";
			sql = sql + " AND a.INT_DEPARTID = c.INT_DEPARTID ";
			sql = sql + " AND a.INT_OFFICEID= b.INT_OFFICEID ";
			if (!"0".equals(Office))
				sql = sql + "  AND a.INT_OFFICEID=" + Office;
			if ("1".equals(type)) {
				if (!"0".equals(startLetter))
					sql = sql + "  AND A.CHR_STAFFNAME LIKE '" + startLetter
							+ "%' ";
			} else {
				sql = sql + "  AND ( ( A.CHR_STAFFNAME LIKE '" + startLetter
						+ "%' ) || ( A.CHR_EMPID LIKE '%" + startLetter
						+ "%' )  )  ";
			}

			sql = sql + " ORDER BY a.CHR_STAFFNAME ";
			String readData[][] = CommonFunctions.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			if (readData.length > 0) {
				for (int u = 0; u < readData.length; u++) {
					sb.append("<ONHOLD>");
					sb.append("<Empid>" + readData[u][0] + "</Empid>");
					sb.append("<Staffname>" + readData[u][1] + "</Staffname>");
					sb.append("<Companyname>" + readData[u][2]
							+ "</Companyname>");
					sb.append("<Branchname>" + readData[u][3] + "</Branchname>");
					sb.append("<Depart>" + readData[u][4] + "</Depart>");
					sb.append("<Office>" + readData[u][5] + "</Office>");
					if ("Y".equals(readData[u][6]))
						sb.append("<Status>HOLD</Status>");
					else
						sb.append("<Status>UNHOLD</Status>");
					sb.append("</ONHOLD>");
				}

				response.setContentType("text/xml");
				response.setHeader("Cache-Control", "no-cache");
				response.getWriter().write(
						"<ONHOLDS>" + sb.toString() + "</ONHOLDS>");
			} else {
				response.setStatus(HttpServletResponse.SC_NO_CONTENT);
			}
		} catch (Exception e) {

			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request
					.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
			System.out.println(e.getMessage());
		}
	}

	// End Author :: Kalaiselvan ------------------------------On
	// Duty-----------

	public static void loadManual(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {

			HttpSession session = request.getSession();
			String year = request.getParameter("year");
			String month = request.getParameter("month");
			String startLetter = "" + request.getParameter("startLetter");
			String Office = "" + request.getParameter("Office");
			String day = "" + request.getParameter("day");
			String staffid = "" + request.getParameter("staffid");

			String OfficeData[][] = CommonFunctions
					.QueryExecute(" SELECT b.INT_OFFICEID,b.CHR_OFFICENAME FROM  com_m_office  b "
							+ "WHERE b.INT_OFFICEID IN("
							+ CommonFunctions
									.QueryExecute("SELECT a.CHR_OFFICELIST FROM m_user a "
											+ "WHERE a.CHR_USRNAME='"
											+ ""
											+ session.getAttribute("USRID")
											+ "' ")[0][0] + " )");
			String officeids = "";
			if (OfficeData.length > 0)
				for (int u = 0; u < OfficeData.length; u++)
					officeids = officeids + OfficeData[u][0] + ",";

			String sql = "";
			sql = " SELECT a.INT_ATTENDANCEID ,a.CHR_EMPID,b.CHR_STAFFNAME,c.CHR_OFFICENAME,DATE_FORMAT(a.DT_LOGIN,'%d-%m-%Y'),a.CHR_DAYTYPE ,   (DATEDIFF(now(),a.DT_LOGIN ) <=45 )";
			sql = sql
					+ " FROM att_smart_attendance a,com_m_staff b,com_m_office c ";
			sql = sql
					+ " WHERE a.CHR_EMPID= b.CHR_EMPID  AND b.INT_OFFICEID =c.INT_OFFICEID";
			if (!"0".equals(month))
				sql = sql + " AND MONTH(a.DT_LOGIN) =" + month;
			if (!"0".equals(day))
				sql = sql + " AND DAY(a.DT_LOGIN)=" + day;

			if (!"0".equals(year))
				sql = sql + " AND YEAR(a.DT_LOGIN)=" + year;
			if (!"0".equals(Office))
				sql = sql + " AND b.INT_OFFICEID=" + Office;
			else
				sql = sql + " AND b.INT_OFFICEID IN (" + officeids + "0 )";

			if (!"0".equals(staffid))
				sql = sql + " AND   a.CHR_EMPID= '" + staffid + "' ";

			if (!"0".equals(startLetter))
				sql = sql + " AND b.CHR_STAFFNAME LIKE  '" + startLetter
						+ "%' ";

			sql = sql + " ORDER BY  CHR_STAFFNAME";

			// System.out.println(sql);
			String readData[][] = com.my.org.erp.common.CommonFunctions
					.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			for (int u = 0; u < readData.length; u++) {
				sb.append("<Rows>");
				sb.append("<Rowid>" + readData[u][0] + "</Rowid>");
				sb.append("<Empid>" + readData[u][1] + "</Empid>");
				sb.append("<Staffname>" + readData[u][2] + "</Staffname>");
				sb.append("<Office>" + readData[u][3] + "</Office>");
				sb.append("<Date>" + readData[u][4] + "</Date>");
				sb.append("<type>" + readData[u][5] + "</type>");
				sb.append("<Status>" + readData[u][6] + "</Status>");
				sb.append("</Rows>");
			}

			response.setContentType("text/xml");
			response.setHeader("Cache-Control", "no-cache");
			response.getWriter().write("<Rowss>" + sb.toString() + "</Rowss>");

		} catch (Exception e) {
			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request
					.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
			System.out.println(e.getMessage());
		}
	}

	public static void LoadAbsentDays(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {
			String year = request.getParameter("year");
			String month = request.getParameter("month");
			String startLetter = "" + request.getParameter("startLetter");
			String Office = "" + request.getParameter("Office");
			String day = "" + request.getParameter("day");
			String staffid = "" + request.getParameter("staffid");
			HttpSession session = request.getSession();

			String OfficeData[][] = CommonFunctions
					.QueryExecute(" SELECT b.INT_OFFICEID,b.CHR_OFFICENAME FROM  com_m_office  b "
							+ "WHERE b.INT_OFFICEID IN("
							+ CommonFunctions
									.QueryExecute("SELECT a.CHR_OFFICELIST FROM m_user a "
											+ "WHERE a.CHR_USRNAME='"
											+ ""
											+ session.getAttribute("USRID")
											+ "' ")[0][0] + " )");
			String officeids = "";
			if (OfficeData.length > 0)
				for (int u = 0; u < OfficeData.length; u++)
					officeids = officeids + OfficeData[u][0] + ",";

			String sql = "";
			sql = " SELECT a.INT_ABSENTID ,a.CHR_EMPID,b.CHR_STAFFNAME,c.CHR_OFFICENAME,DATE_FORMAT(a.DT_ABSENTDATE,'%d-%m-%Y'),a.CHR_DAYTYPE, (DATEDIFF(now(),a.DT_ABSENTDATE ) <=45 ) ";
			sql = sql + " FROM att_t_absent a,com_m_staff b,com_m_office c ";
			sql = sql
					+ " WHERE a.CHR_EMPID= b.CHR_EMPID  AND b.INT_OFFICEID =c.INT_OFFICEID";
			if (!"0".equals(month))
				sql = sql + " AND MONTH(a.DT_ABSENTDATE) =" + month;
			if (!"0".equals(day))
				sql = sql + " AND DAY(a.DT_ABSENTDATE)=" + day;

			if (!"0".equals(year))
				sql = sql + " AND YEAR(a.DT_ABSENTDATE)=" + year;
			if (!"0".equals(Office))
				sql = sql + " AND b.INT_OFFICEID=" + Office;
			else
				sql = sql + " AND b.INT_OFFICEID IN (" + officeids + "0 )";

			if (!"0".equals(staffid))
				sql = sql + " AND a.CHR_EMPID = '" + staffid + "' ";

			if (!"0".equals(startLetter))
				sql = sql + " AND b.CHR_STAFFNAME LIKE  '" + startLetter
						+ "%' ";

			sql = sql + " ORDER BY  CHR_STAFFNAME";

			// System.out.println(sql);
			String readData[][] = com.my.org.erp.common.CommonFunctions
					.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			for (int u = 0; u < readData.length; u++) {
				sb.append("<Rows>");
				sb.append("<Rowid>" + readData[u][0] + "</Rowid>");
				sb.append("<Empid>" + readData[u][1] + "</Empid>");
				sb.append("<Staffname>" + readData[u][2] + "</Staffname>");
				sb.append("<Office>" + readData[u][3] + "</Office>");
				sb.append("<Date>" + readData[u][4] + "</Date>");
				sb.append("<type>" + readData[u][5] + "</type>");
				sb.append("<Status>" + readData[u][6] + "</Status>");
				sb.append("</Rows>");
			}

			response.setContentType("text/xml");
			response.setHeader("Cache-Control", "no-cache");
			response.getWriter().write("<Rowss>" + sb.toString() + "</Rowss>");

		} catch (Exception e) {
			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request
					.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
			System.out.println(e.getMessage());
		}
	}

	public static void LoadContinuousEntryDays(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {

			HttpSession session = request.getSession();
			String year = request.getParameter("year");
			String month = request.getParameter("month");
			String startLetter = "" + request.getParameter("startLetter");
			String Office = "" + request.getParameter("Office");
			String day = "" + request.getParameter("day");
			String staffid = "" + request.getParameter("staffid");
			String OfficeData[][] = CommonFunctions
					.QueryExecute(" SELECT b.INT_OFFICEID,b.CHR_OFFICENAME FROM  com_m_office  b "
							+ "WHERE b.INT_OFFICEID IN("
							+ CommonFunctions
									.QueryExecute("SELECT a.CHR_OFFICELIST FROM m_user a "
											+ "WHERE a.CHR_USRNAME='"
											+ ""
											+ session.getAttribute("USRID")
											+ "' ")[0][0] + " )");
			String officeids = "";
			if (OfficeData.length > 0)
				for (int u = 0; u < OfficeData.length; u++)
					officeids = officeids + OfficeData[u][0] + ",";

			String sql = "";
			sql = " SELECT a.INT_CONTINUOUSID ,a.CHR_EMPID,b.CHR_STAFFNAME,c.CHR_OFFICENAME,DATE_FORMAT(a.DT_CONTINUOUSDATE,'%d-%m-%Y'),a.CHR_DAYTYPE, (DATEDIFF(now(),a.DT_CONTINUOUSDATE ) <=45 ) ";
			sql = sql
					+ " FROM att_t_continuousentry a,com_m_staff b,com_m_office c ";
			sql = sql
					+ " WHERE a.CHR_EMPID= b.CHR_EMPID  AND b.INT_OFFICEID =c.INT_OFFICEID";
			if (!"0".equals(month))
				sql = sql + " AND MONTH(a.DT_CONTINUOUSDATE) =" + month;
			if (!"0".equals(day))
				sql = sql + " AND DAY(a.DT_CONTINUOUSDATE)=" + day;

			if (!"0".equals(year))
				sql = sql + " AND YEAR(a.DT_CONTINUOUSDATE)=" + year;
			if (!"0".equals(Office))
				sql = sql + " AND b.INT_OFFICEID=" + Office;
			else
				sql = sql + " AND b.INT_OFFICEID IN (" + officeids + "0 )";

			if (!"0".equals(staffid))
				sql = sql + " AND a.CHR_EMPID = '" + staffid + "' ";

			if (!"0".equals(startLetter))
				sql = sql + " AND b.CHR_STAFFNAME LIKE  '" + startLetter
						+ "%' ";

			sql = sql + " ORDER BY  CHR_STAFFNAME";
			System.out.println(sql);
			;

			// System.out.println(sql);
			String readData[][] = com.my.org.erp.common.CommonFunctions
					.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			for (int u = 0; u < readData.length; u++) {
				sb.append("<Rows>");
				sb.append("<Rowid>" + readData[u][0] + "</Rowid>");
				sb.append("<Empid>" + readData[u][1] + "</Empid>");
				sb.append("<Staffname>" + readData[u][2] + "</Staffname>");
				sb.append("<Office>" + readData[u][3] + "</Office>");
				sb.append("<Date>" + readData[u][4] + "</Date>");
				sb.append("<type>" + readData[u][5] + "</type>");
				sb.append("<Status>" + readData[u][6] + "</Status>");
				sb.append("</Rows>");
			}

			response.setContentType("text/xml");
			response.setHeader("Cache-Control", "no-cache");
			response.getWriter().write("<Rowss>" + sb.toString() + "</Rowss>");

		} catch (Exception e) {
			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request
					.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
			System.out.println(e.getMessage());
		}
	}

	public static void loadPermission(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {

		try {

			HttpSession session = request.getSession();

			String OfficeData[][] = CommonFunctions
					.QueryExecute(" SELECT b.INT_OFFICEID,b.CHR_OFFICENAME FROM  com_m_office  b "
							+ "WHERE b.INT_OFFICEID IN("
							+ CommonFunctions
									.QueryExecute("SELECT a.CHR_OFFICELIST FROM m_user a "
											+ "WHERE a.CHR_USRNAME='"
											+ ""
											+ session.getAttribute("USRID")
											+ "' ")[0][0] + " )");
			String officeids = "";
			if (OfficeData.length > 0)
				for (int u = 0; u < OfficeData.length; u++)
					officeids = officeids + OfficeData[u][0] + ",";

			String year = request.getParameter("year");
			String month = request.getParameter("month");
			String startLetter = "" + request.getParameter("startLetter");
			String Office = "" + request.getParameter("Office");
			String day = "" + request.getParameter("day");
			String staffid = "" + request.getParameter("staffid");
			String sql = "";
			sql = " SELECT a.INT_PERMISSIONID ,a.CHR_EMPID,b.CHR_STAFFNAME,c.CHR_OFFICENAME,DATE_FORMAT(a.DT_PDATE,'%d-%m-%Y'),a.CHR_DAYTYPE,a.DT_TIME_FROM,a.DT_TIME_TO  , (DATEDIFF(now(),a.DT_PDATE ) <=45 )";
			sql = sql
					+ " FROM att_t_permission a,com_m_staff b,com_m_office c ";
			sql = sql
					+ " WHERE a.CHR_EMPID= b.CHR_EMPID  AND b.INT_OFFICEID =c.INT_OFFICEID";
			if (!"0".equals(month))
				sql = sql + " AND MONTH(a.DT_PDATE) =" + month;
			if (!"0".equals(day))
				sql = sql + " AND DAY(a.DT_PDATE)=" + day;

			if (!"0".equals(year))
				sql = sql + " AND YEAR(a.DT_PDATE)=" + year;
			if (!"0".equals(Office))
				sql = sql + " AND b.INT_OFFICEID=" + Office;
			else
				sql = sql + " AND b.INT_OFFICEID IN (" + officeids + "0 )";

			if (!"0".equals(staffid))
				sql = sql + " AND a.CHR_EMPID = '" + staffid + "' ";

			if (!"0".equals(startLetter))
				sql = sql + " AND b.CHR_STAFFNAME LIKE  '" + startLetter
						+ "%' ";

			sql = sql + " ORDER BY  CHR_STAFFNAME";

			// System.out.println(sql);
			String readData[][] = com.my.org.erp.common.CommonFunctions
					.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			for (int u = 0; u < readData.length; u++) {
				sb.append("<Rows>");
				sb.append("<Rowid>" + readData[u][0] + "</Rowid>");
				sb.append("<Empid>" + readData[u][1] + "</Empid>");
				sb.append("<Staffname>" + readData[u][2] + "</Staffname>");
				sb.append("<Office>" + readData[u][3] + "</Office>");
				sb.append("<Date>" + readData[u][4] + "</Date>");
				sb.append("<type>" + readData[u][5] + "</type>");
				sb.append("<Timein>" + readData[u][6] + "</Timein>");
				sb.append("<Timeout>" + readData[u][7] + "</Timeout>");
				sb.append("<Status>" + readData[u][8] + "</Status>");
				sb.append("</Rows>");
			}
			response.setContentType("text/xml");
			response.setHeader("Cache-Control", "no-cache");
			response.getWriter().write("<Rowss>" + sb.toString() + "</Rowss>");

		} catch (Exception e) {
			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request
					.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
			System.out.println(e.getMessage());
		}

	}

	// Start Author :: Kalaiselvan -----------------------UserName----------
	public static void loadAttQuery(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {
			String d1 = request.getParameter("d1");
			String d2 = request.getParameter("d2");
			String sql = "SELECT DATEDIFF('"
					+ com.my.org.erp.ServiceLogin.DateUtil
							.FormateDateSQL(d2)
					+ "','"
					+ com.my.org.erp.ServiceLogin.DateUtil
							.FormateDateSQL(d1) + "')";
			String daydiff[][] = com.my.org.erp.common.CommonFunctions
					.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			sb.append("<Date>");
			sb.append("<Day>" + (Integer.parseInt(daydiff[0][0]) + 1)
					+ "</Day>");
			sb.append("</Date>");
			response.setContentType("text/xml");
			response.setHeader("Cache-Control", "no-cache");
			response.getWriter().write("<Dates>" + sb.toString() + "</Dates>");

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}

	// End Author :: Kalaiselvan
	// ------------------------------UserName----------

	// Start Author :: Kalaiselvan -----------------------UserName----------
	public static void loadBranch(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {
			String cpyid = request.getParameter("cpyid");
			String sql = "SELECT INT_BRANCHID,INT_COMPANYID,CHR_BRANCHNAME from  com_m_branch  WHERE INT_COMPANYID ="
					+ Integer.parseInt(cpyid);
			String readData[][] = com.my.org.erp.common.CommonFunctions
					.QueryExecute(sql);

			StringBuffer sb = new StringBuffer();
			if (readData.length > 0) {
				for (int u = 0; u < readData.length; u++) {
					sb.append("<Branch>");
					sb.append("<Branchid>" + readData[0][0] + "</Branchid>");
					sb.append("<Branchname>" + readData[0][2] + "</Branchname>");

					sb.append("</Branch>");
				}

				response.setContentType("text/xml");
				response.setHeader("Cache-Control", "no-cache");
				response.getWriter().write(
						"<Branchs>" + sb.toString() + "</Branchs>");

			} else {
				response.setStatus(HttpServletResponse.SC_NO_CONTENT);
			}
		} catch (Exception e) {
			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request
					.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
			System.out.println(e.getMessage());
		}
	}

	public static void loadProxy(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {
			String Office = "" + request.getParameter("Office");
			String issued = "" + request.getParameter("issued");
			String status = "" + request.getParameter("status");
			String type = "" + request.getParameter("type");

			String startLetter = "" + request.getParameter("startLetter");

			String sql = " SELECT A.CHR_EMPID,A.CHR_STAFFNAME ,C.CHR_COMPANYNAME,B.CHR_BRANCHNAME,D.CHR_DEPARTNAME,";
			sql = sql + " E.CHR_DESIGNAME , ";
			sql = sql + " FUN_GET_PROXIMITY_YES(A.CHR_EMPID), ";
			sql = sql + " FUN_GET_PROXIMITY_NUMBER(A.CHR_EMPID) , ";
			sql = sql + " FUN_GET_PROXIMITY_STATUS(A.CHR_EMPID),   ";
			sql = sql + " FUN_GET_PROXIMITY_NUMBER_RETURN(A.CHR_EMPID)    ";

			// sql = sql +
			// " (SELECT count(*)  FROM att_m_proximitycardno f WHERE A.CHR_EMPID=f.CHR_EMPID),";
			// sql = sql +
			// " (SELECT g.CHR_CARDNO FROM att_m_proximitycardno g WHERE A.CHR_EMPID=g.CHR_EMPID), ";
			// sql = sql +
			// " (SELECT h.CHR_RETURN FROM att_m_proximitycardno h WHERE h.CHR_EMPID=A.CHR_EMPID) ";
			sql = sql
					+ " FROM  com_m_staff  A  , com_m_branch  B, com_m_company  C ,   com_m_depart   D,  com_m_desig  E ";
			sql = sql
					+ " WHERE A.INT_BRANCHID=B.INT_BRANCHID AND A.INT_COMPANYID=C.INT_COMPANYID ";
			sql = sql
					+ " AND A.INT_DEPARTID=D.INT_DEPARTID AND A.INT_DESIGID= E.INT_DESIGID ";

			if (!"0".equals(Office))
				sql = sql + "  AND A.INT_OFFICEID=" + Office;
			if (!"-1".equals(issued))
				sql = sql + "  AND FUN_GET_PROXIMITY_YES(A.CHR_EMPID)="
						+ issued;
			if (!"0".equals(status))
				sql = sql + "  AND FUN_GET_PROXIMITY_STATUS(A.CHR_EMPID)= '"
						+ status + "' ";
			if ("1".equals(type)) {
				if (!"0".equals(startLetter))
					sql = sql + "  AND A.CHR_STAFFNAME LIKE '" + startLetter
							+ "%' ";
			} else {
				sql = sql + "  AND ( ( A.CHR_STAFFNAME LIKE '" + startLetter
						+ "%' ) || ( A.CHR_EMPID LIKE '%" + startLetter
						+ "%' )  )  ";
			}
			sql = sql + " order by A.CHR_STAFFNAME";

			System.out.println(sql);
			String readData[][] = CommonFunctions.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			if (readData.length > 0) {
				for (int u = 0; u < readData.length; u++) {

					sb.append("<Proxys>");
					sb.append("<Empid>" + readData[u][0] + "</Empid>");
					sb.append("<Staffname>" + readData[u][1] + "</Staffname>");
					sb.append("<Companyname>" + readData[u][2]
							+ "</Companyname>");
					sb.append("<Branchname>" + readData[u][3] + "</Branchname>");
					sb.append("<Depart>" + readData[u][4] + "</Depart>");
					sb.append("<Desig>" + readData[u][5] + "</Desig>");
					sb.append("<Status>" + readData[u][6] + "</Status>");
					sb.append("<Card>" + readData[u][7] + "</Card>");
					sb.append("<Return>" + readData[u][8] + "</Return>");
					sb.append("<Cardno>" + readData[u][9] + "</Cardno>");
					sb.append("</Proxys>");

				}
				response.setContentType("text/xml");
				response.setHeader("Cache-Control", "no-cache");
				response.getWriter().write(
						"<Proxyss>" + sb.toString() + "</Proxyss>");
			} else {
				response.setStatus(HttpServletResponse.SC_NO_CONTENT);
			}
		} catch (Exception e) {

			System.out.println(e.getMessage());
		}
	}

	public static void LoadEmailCustomerGroup(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {
			String startLetter = request.getParameter("startLetter");
			String sql = "";
			sql = " SELECT INT_GROUPID,CHR_GROUPNAME,DATE_FORMAT(DAT_REGISTER,'%d-%m-%Y'),CHR_ACTIVE FROM email_m_customergroup WHERE INT_GROUPID>=1 ";
			if (!"0".equals(startLetter))
				sql = sql + " AND CHR_GROUPNAME LIKE '" + startLetter + "%' ";
			sql = sql + " ORDER BY CHR_GROUPNAME ";

			String readData[][] = com.my.org.erp.common.CommonFunctions
					.QueryExecute(sql);

			if (readData.length > 0) {
				StringBuffer sb = new StringBuffer();
				for (int u = 0; u < readData.length; u++) {
					sb.append("<Row>");
					sb.append("<Id>" + readData[u][0] + "</Id>");
					sb.append("<Name>"
							+ (readData[u][1].toUpperCase()).replaceAll("&",
									" AND ") + "</Name>");
					sb.append("<Date>" + readData[u][2] + "</Date>");
					sb.append("<Active>" + readData[u][3] + "</Active>");
					sb.append("</Row>");
				}
				sb.toString();
				response.setContentType("text/xml");
				response.setHeader("Cache-Control", "no-cache");
				response.getWriter()
						.write("<Rows>" + sb.toString() + "</Rows>");
			} else {
				response.setStatus(HttpServletResponse.SC_NO_CONTENT);
			}

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}

	public static void LoadEmailCustomerinfo(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {
			String startLetter = request.getParameter("startLetter");
			String group = request.getParameter("group");

			String sql = "";
			sql = "  SELECT a.INT_CUSTOMERID,a.CHR_CUSTOMERNAME,a.CHR_COMPANYNAME, a.CHR_ADDRESS1,a.CHR_ADDRESS2,a.CHR_ADDRESS3 , ";
			sql = sql
					+ " c.CHR_STATENAME,d.CHR_DISTRICT, e.CHR_CITYNAME, a.INT_PINCODE,a.INT_PHONE1,a.INT_MOBILE1,a.CHR_FAX,a.CHR_EMAIL,a.CHR_WEBSITE,   ";
			sql = sql + "  a.CHR_ACTIVE, b.CHR_GROUPNAME    ";
			sql = sql
					+ " FROM email_m_customerinfo a,email_m_customergroup  b ,com_m_state c  ,com_m_district d,com_m_city e   ";
			sql = sql + " WHERE a.INT_GROUPID=b.INT_GROUPID    ";
			sql = sql + " AND a.INT_STATEID=c.INT_STATEID     ";
			sql = sql + " AND a.INT_DISTRICTID = d.INT_DISTRICTID   ";
			sql = sql + " AND a.INT_CITYID = e.INT_CITYID   ";

			if (!"0".equals(group))
				sql = sql + " AND a.INT_GROUPID =" + group;
			if (!"0".equals(startLetter))
				sql = sql + " AND a.CHR_CUSTOMERNAME LIKE '" + startLetter
						+ "%' ";
			sql = sql + " ORDER BY a.INT_CUSTOMERID ";

			// System.out.println(sql);
			String readData[][] = com.my.org.erp.common.CommonFunctions
					.QueryExecute(sql);

			if (readData.length > 0) {
				StringBuffer sb = new StringBuffer();
				for (int u = 0; u < readData.length; u++) {
					sb.append("<Row>");
					sb.append("<Id>" + readData[u][0] + "</Id>");
					sb.append("<Name>"
							+ (readData[u][1].toUpperCase()).replaceAll("&",
									" AND ") + "</Name>");
					sb.append("<CName>"
							+ (readData[u][2].toUpperCase()).replaceAll("&",
									" AND ") + "</CName>");
					sb.append("<Add1>"
							+ (readData[u][3].toUpperCase()).replaceAll("&",
									" AND ") + "</Add1>");
					sb.append("<Add2>"
							+ (readData[u][4].toUpperCase()).replaceAll("&",
									" AND ") + "</Add2>");
					sb.append("<Add3>"
							+ (readData[u][5].toUpperCase()).replaceAll("&",
									" AND ") + "</Add3>");
					sb.append("<State>"
							+ (readData[u][6].toUpperCase()).replaceAll("&",
									" AND ") + "</State>");
					sb.append("<District>"
							+ (readData[u][7].toUpperCase()).replaceAll("&",
									" AND ") + "</District>");
					sb.append("<City>"
							+ (readData[u][8].toUpperCase()).replaceAll("&",
									" AND ") + "</City>");
					sb.append("<Pin>"
							+ (readData[u][9].toUpperCase()).replaceAll("&",
									" AND ") + "</Pin>");
					sb.append("<Phone>"
							+ (readData[u][10].toUpperCase()).replaceAll("&",
									" AND ") + "</Phone>");
					sb.append("<Mobile>"
							+ (readData[u][11].toUpperCase()).replaceAll("&",
									" AND ") + "</Mobile>");
					sb.append("<Fax>"
							+ (readData[u][12].toUpperCase()).replaceAll("&",
									" AND ") + "</Fax>");
					sb.append("<Email>" + (readData[u][13]) + "</Email>");
					sb.append("<Web>"
							+ (readData[u][14].toUpperCase()).replaceAll("&",
									" AND ") + "</Web>");
					sb.append("<GName>"
							+ (readData[u][16].toUpperCase()).replaceAll("&",
									" AND ") + "</GName>");
					sb.append("<Active>" + readData[u][15] + "</Active>");
					sb.append("</Row>");

				}

				sb.toString();
				response.setContentType("text/xml");
				response.setHeader("Cache-Control", "no-cache");
				response.getWriter().write(
						"<Rowss>" + sb.toString() + "</Rowss>");
			} else {
				response.setStatus(HttpServletResponse.SC_NO_CONTENT);
			}

		} catch (Exception e) {
			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request
					.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
			System.out.println(e.getMessage());
		}
	}

	public static void loadCertification(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {

			String sql = " SELECT INT_CERTIFICATIONID,CHR_CERTIFICATIONNAME FROM com_m_certification ORDER BY CHR_CERTIFICATIONNAME";

			String readData[][] = com.my.org.erp.common.CommonFunctions
					.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			if (readData.length > 0) {
				for (int u = 0; u < readData.length; u++) {
					sb.append("<Row>");
					sb.append("<Id>" + readData[u][0] + "</Id>");
					sb.append("<Name>" + readData[u][1] + "</Name>");
					sb.append("</Row>");
				}

				response.setContentType("text/xml");
				response.setHeader("Cache-Control", "no-cache");
				response.getWriter()
						.write("<Rows>" + sb.toString() + "</Rows>");
			} else {
				response.setStatus(HttpServletResponse.SC_NO_CONTENT);
			}
		} catch (Exception e) {

			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request
					.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
			System.out.println(e.getMessage());
		}
	}

	public static void loadEmployeeCategory(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {

			String sql = " SELECT INT_EMPLOYEECATEGORYID,CHR_CATEGORYNAME FROM  com_m_employeecategory  ORDER BY CHR_CATEGORYNAME";
			String readData[][] = com.my.org.erp.common.CommonFunctions
					.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			if (readData.length > 0) {
				for (int u = 0; u < readData.length; u++) {
					sb.append("<Row>");
					sb.append("<Id>" + readData[u][0] + "</Id>");
					sb.append("<Name>" + readData[u][1] + "</Name>");
					sb.append("</Row>");
				}

				response.setContentType("text/xml");
				response.setHeader("Cache-Control", "no-cache");
				response.getWriter()
						.write("<Rows>" + sb.toString() + "</Rows>");
			} else {
				response.setStatus(HttpServletResponse.SC_NO_CONTENT);
			}
		} catch (Exception e) {

			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request
					.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
			System.out.println(e.getMessage());
		}
	}

	public static void loadStaffType(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {

			String sql = " SELECT INT_STAFFTYPEID,CHR_TYPENAME,CHR_FLAG FROM com_m_stafftype ORDER BY CHR_TYPENAME";
			// System.out.println(sql);
			String readData[][] = com.my.org.erp.common.CommonFunctions
					.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			if (readData.length > 0) {
				for (int u = 0; u < readData.length; u++) {
					sb.append("<Row>");
					sb.append("<Id>" + readData[u][0] + "</Id>");
					sb.append("<Name>" + readData[u][1] + "</Name>");
					sb.append("<Flag>" + readData[u][2] + "</Flag>");
					sb.append("</Row>");
				}

				response.setContentType("text/xml");
				response.setHeader("Cache-Control", "no-cache");
				response.getWriter()
						.write("<Rows>" + sb.toString() + "</Rows>");
			} else {
				response.setStatus(HttpServletResponse.SC_NO_CONTENT);
			}
		} catch (Exception e) {

			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request
					.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
			System.out.println(e.getMessage());
		}
	}

	public static void loadBloodGroup(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {

			String sql = " SELECT INT_BLOODGROUPID,CHR_GROUPNAME FROM com_m_bloodgroup ORDER BY CHR_GROUPNAME";
			// System.out.println(sql);
			String readData[][] = com.my.org.erp.common.CommonFunctions
					.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			if (readData.length > 0) {
				for (int u = 0; u < readData.length; u++) {
					sb.append("<Row>");
					sb.append("<Id>" + readData[u][0] + "</Id>");
					sb.append("<Name>" + readData[u][1] + "</Name>");
					sb.append("</Row>");
				}

				response.setContentType("text/xml");
				response.setHeader("Cache-Control", "no-cache");
				response.getWriter()
						.write("<Rows>" + sb.toString() + "</Rows>");
			} else {
				response.setStatus(HttpServletResponse.SC_NO_CONTENT);
			}
		} catch (Exception e) {
			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request
					.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
			System.out.println(e.getMessage());
		}
	}

	public static void LoadQualification(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {

			String startLetter = request.getParameter("startLetter");
			String sql = " SELECT INT_QUALIFICATIONID,CHR_QUALIFICATIONNAME FROM  com_m_qualification  WHERE INT_QUALIFICATIONID>=1";
			if (!"0".equals(startLetter))
				sql = sql + " AND CHR_QUALIFICATIONNAME LIKE '" + startLetter
						+ "%' ";

			sql = sql + " ORDER BY CHR_QUALIFICATIONNAME  ";
			// System.out.println(sql);
			String readData[][] = com.my.org.erp.common.CommonFunctions
					.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			if (readData.length > 0) {
				for (int u = 0; u < readData.length; u++) {
					sb.append("<Row>");
					sb.append("<Id>" + readData[u][0] + "</Id>");
					sb.append("<Name>" + readData[u][1] + "</Name>");
					sb.append("</Row>");
				}

				response.setContentType("text/xml");
				response.setHeader("Cache-Control", "no-cache");
				response.getWriter()
						.write("<Rows>" + sb.toString() + "</Rows>");
			} else {
				response.setStatus(HttpServletResponse.SC_NO_CONTENT);
			}
		} catch (Exception e) {
			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request
					.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
			System.out.println(e.getMessage());
		}
	}

	public static void LoadIdProof(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {

			String sql = " SELECT INT_ADDRESSPROOFID, CHR_PROOFNAME FROM com_m_addressproof   ORDER BY CHR_PROOFNAME";

			String readData[][] = com.my.org.erp.common.CommonFunctions
					.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			if (readData.length > 0) {
				for (int u = 0; u < readData.length; u++) {
					sb.append("<Row>");
					sb.append("<Id>" + readData[u][0] + "</Id>");
					sb.append("<Name>" + readData[u][1] + "</Name>");
					sb.append("</Row>");
				}

				response.setContentType("text/xml");
				response.setHeader("Cache-Control", "no-cache");
				response.getWriter()
						.write("<Rows>" + sb.toString() + "</Rows>");
			} else {
				response.setStatus(HttpServletResponse.SC_NO_CONTENT);
			}
		} catch (Exception e) {
			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request
					.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
			System.out.println(e.getMessage());
		}
	}

	public static void loadLeaveEntry(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {

			HttpSession session = request.getSession();
			String Office = request.getParameter("Office");
			String day = request.getParameter("day");
			String year = request.getParameter("year");
			String month = request.getParameter("month");
			String leavetype = request.getParameter("leavetype");
			String staffid = request.getParameter("staffid");
			String startLetter = request.getParameter("startLetter");

			String sql = "";

			String OfficeData[][] = CommonFunctions
					.QueryExecute(" SELECT b.INT_OFFICEID,b.CHR_OFFICENAME FROM  com_m_office  b "
							+ "WHERE b.INT_OFFICEID IN("
							+ CommonFunctions
									.QueryExecute("SELECT a.CHR_OFFICELIST FROM m_user a "
											+ "WHERE a.CHR_USRNAME='"
											+ ""
											+ session.getAttribute("USRID")
											+ "' ")[0][0] + " )");
			String officeids = "";
			if (OfficeData.length > 0)
				for (int u = 0; u < OfficeData.length; u++)
					officeids = officeids + OfficeData[u][0] + ",";

			sql = " SELECT a.INT_LEAVEID,a.CHR_EMPID,b.CHR_STAFFNAME,DATE_FORMAT(a.DT_LDATE,'%d-%m-%Y'),a.CHR_DAYTYPE ,c.CHR_LEAVENAME ";
			sql = sql
					+ " , (DATEDIFF(now(),a.DT_LDATE)<=45),( month(now()) =month(a.DT_LDATE)),( year(now()) =year(a.DT_LDATE)) ";
			sql = sql
					+ " FROM att_t_leave a , com_m_staff b,att_m_leavetype c WHERE a.CHR_EMPID= b.CHR_EMPID AND a.CHR_LEAVETYPE=c.CHR_SYMBOL  ";
			if (!"0".equals(Office))
				sql = sql + " AND b.INT_OFFICEID=" + Office;
			else
				sql = sql + " AND b.INT_OFFICEID IN (" + officeids + "0 )";

			if (!"0".equals(month))
				sql = sql + " AND MONTH(a.DT_LDATE)= '" + month + "'";

			if (!"0".equals(year))
				sql = sql + " AND YEAR(a.DT_LDATE)=" + year;

			if (!"0".equals(day))
				sql = sql + " AND DAY(a.DT_LDATE)=" + day;

			if (!"0".equals(leavetype))
				sql = sql + " AND c.CHR_SYMBOL='" + leavetype + "'";

			if (!"0".equals(staffid))
				sql = sql + " AND a.CHR_EMPID = '" + staffid + "'";

			if ("0".equals(staffid))
				if (!"0".equals(startLetter))
					sql = sql + " AND b.CHR_STAFFNAME LIKE '" + startLetter
							+ "%'";

			System.out.println(sql);
			String readData[][] = CommonFunctions.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();

			if (readData.length > 0) {
				for (int u = 0; u < readData.length; u++) {
					sb.append("<Row>");
					sb.append("<Rowid>" + readData[u][0] + "</Rowid>");
					sb.append("<Empid>" + readData[u][1] + "</Empid>");
					sb.append("<Name>" + readData[u][2] + "</Name>");
					sb.append("<Date>" + readData[u][3] + "</Date>");
					sb.append("<Type>" + readData[u][4] + "</Type>");
					sb.append("<LName>" + readData[u][5] + "</LName>");
					sb.append("<Status>" + readData[u][6] + "</Status>");
					sb.append("<Month>" + readData[u][7] + "</Month>");
					sb.append("<Year>" + readData[u][8] + "</Year>");
					sb.append("</Row>");
				}

				response.setContentType("text/xml");
				response.setHeader("Cache-Control", "no-cache");
				response.getWriter()
						.write("<Rows>" + sb.toString() + "</Rows>");
			} else {
				System.out.println("sdsd");
				response.setStatus(HttpServletResponse.SC_NO_CONTENT);
			}
		} catch (Exception e) {
			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request
					.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
			System.out.println(e.getMessage());
		}
	}

	public static void checkLeaveBalance(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {

			String empid = request.getParameter("empid");
			String leavetype = request.getParameter("leavetype");
			String date = request.getParameter("date");
			String leavid = CommonFunctions
					.QueryExecute("SELECT INT_LEAVEID FROM att_m_leavetype WHERE CHR_SYMBOL='"
							+ leavetype + "'")[0][0];
			String sql = "";
			sql = " SELECT  CHR_LEAVE" + leavid + " ,INT_NOD" + leavid
					+ ",INT_NOD" + leavid + "BALANCE,(INT_NOD" + leavid
					+ " -INT_NOD" + leavid + "BALANCE) FROM  att_m_leave ";
			sql = sql + " WHERE CHR_EMPID='" + empid + "' AND  INT_YEAR=Year('"
					+ date + "')";

			// System.out.println(sql);
			String readData[][] = com.my.org.erp.common.CommonFunctions
					.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			if (readData.length > 0) {
				for (int u = 0; u < readData.length; u++) {
					sb.append("<Row>");
					sb.append("<Leave>" + readData[u][0] + "</Leave>");
					sb.append("<Eligible>" + readData[u][1] + "</Eligible>");
					sb.append("<Taken>" + readData[u][2] + "</Taken>");
					sb.append("<Balance>" + readData[u][3] + "</Balance>");
					sb.append("</Row>");
				}

				response.setContentType("text/xml");
				response.setHeader("Cache-Control", "no-cache");
				response.getWriter()
						.write("<Rows>" + sb.toString() + "</Rows>");
			} else {
				response.setStatus(HttpServletResponse.SC_NO_CONTENT);
			}
		} catch (Exception e) {
			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request
					.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
			System.out.println(e.getMessage());
		}
	}

	public static void loadHolidayData(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {

			HttpSession session = request.getSession();
			String year = request.getParameter("year");
			String month = request.getParameter("month");
			String startLetter = "" + request.getParameter("startLetter");
			String Office = "" + request.getParameter("Office");
			String day = "" + request.getParameter("day");
			String staffid = "" + request.getParameter("staffid");

			String OfficeData[][] = CommonFunctions
					.QueryExecute(" SELECT b.INT_OFFICEID,b.CHR_OFFICENAME FROM  com_m_office  b "
							+ "WHERE b.INT_OFFICEID IN("
							+ CommonFunctions
									.QueryExecute("SELECT a.CHR_OFFICELIST FROM m_user a "
											+ "WHERE a.CHR_USRNAME='"
											+ ""
											+ session.getAttribute("USRID")
											+ "' ")[0][0] + " )");
			String officeids = "";
			if (OfficeData.length > 0)
				for (int u = 0; u < OfficeData.length; u++)
					officeids = officeids + OfficeData[u][0] + ",";

			String sql = "";
			sql = " SELECT a.INT_HOLIDAYID ,a.CHR_EMPID,b.CHR_STAFFNAME,c.CHR_OFFICENAME,DATE_FORMAT(a.DT_HOLIDATE,'%d-%m-%Y'), (DATEDIFF(now(),a.DT_HOLIDATE ) <=45 ) ";
			sql = sql + " FROM att_t_holiday a,com_m_staff b,com_m_office c ";
			sql = sql
					+ " WHERE a.CHR_EMPID= b.CHR_EMPID  AND b.INT_OFFICEID =c.INT_OFFICEID";
			if (!"0".equals(month))
				sql = sql + " AND MONTH(a.DT_HOLIDATE) =" + month;
			if (!"0".equals(day))
				sql = sql + " AND DAY(a.DT_HOLIDATE)=" + day;

			if (!"0".equals(year))
				sql = sql + " AND YEAR(a.DT_HOLIDATE)=" + year;

			if (!"0".equals(staffid))
				sql = sql + " AND a.CHR_EMPID = '" + staffid + "' ";

			if (!"0".equals(Office))
				sql = sql + " AND b.INT_OFFICEID=" + Office;
			else
				sql = sql + " AND b.INT_OFFICEID IN (" + officeids + "0 )";

			if (!"0".equals(startLetter))
				sql = sql + " AND b.CHR_STAFFNAME LIKE  '" + startLetter
						+ "%' ";

			sql = sql + " ORDER BY  b.CHR_STAFFNAME";

			// System.out.println(sql);
			String readData[][] = com.my.org.erp.common.CommonFunctions
					.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			for (int u = 0; u < readData.length; u++) {
				sb.append("<Rows>");
				sb.append("<Rowid>" + readData[u][0] + "</Rowid>");
				sb.append("<Empid>" + readData[u][1] + "</Empid>");
				sb.append("<Staffname>" + readData[u][2] + "</Staffname>");
				sb.append("<Office>" + readData[u][3] + "</Office>");
				sb.append("<Date>" + readData[u][4] + "</Date>");
				sb.append("<Status>" + readData[u][5] + "</Status>");
				sb.append("</Rows>");
			}

			response.setContentType("text/xml");
			response.setHeader("Cache-Control", "no-cache");
			response.getWriter().write("<Rowss>" + sb.toString() + "</Rowss>");

		} catch (Exception e) {
			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request
					.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
			System.out.println(e.getMessage());
		}
	}

	public static void loadStaffName(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {

			String Office = "" + request.getParameter("Office");
			String sql = "";
			sql = " SELECT  CHR_EMPID,CHR_STAFFNAME FROM com_m_staff WHERE   CHR_TYPE!='T' AND CHR_HOLD!='Y'    ";
			if (!"0".equals(Office))
				sql = sql + " AND  INT_OFFICEID=" + Office;
			sql = sql + " ORDER BY  CHR_STAFFNAME";
			// System.out.println(sql);
			String readData[][] = com.my.org.erp.common.CommonFunctions
					.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			for (int u = 0; u < readData.length; u++) {
				sb.append("<Rows>");
				sb.append("<Id>" + readData[u][0] + "</Id>");
				sb.append("<Name>" + readData[u][1] + "</Name>");
				sb.append("</Rows>");
			}

			response.setContentType("text/xml");
			response.setHeader("Cache-Control", "no-cache");
			response.getWriter().write("<Rowss>" + sb.toString() + "</Rowss>");

		} catch (Exception e) {
			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request
					.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
			System.out.println(e.getMessage());
		}
	}

	public static void loadExtraDays(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {

			String year = request.getParameter("year");
			String month = request.getParameter("month");
			String startLetter = "" + request.getParameter("startLetter");
			String Office = "" + request.getParameter("Office");
			String day = "" + request.getParameter("day");
			String staffid = "" + request.getParameter("staffid");
			String sql = "";
			sql = " SELECT a.INT_EXTRADAYSID ,a.CHR_EMPID,b.CHR_STAFFNAME,c.CHR_OFFICENAME,DATE_FORMAT(a.DT_EXTRADATE,'%d-%m-%Y'),a.CHR_DAYTYPE, (DATEDIFF(now(),a.DT_EXTRADATE ) <=45 ) ";
			sql = sql + " FROM att_t_extradays a,com_m_staff b,com_m_office c ";
			sql = sql
					+ " WHERE a.CHR_EMPID= b.CHR_EMPID  AND b.INT_OFFICEID =c.INT_OFFICEID";
			if (!"0".equals(month))
				sql = sql + " AND MONTH(a.DT_EXTRADATE) =" + month;
			if (!"0".equals(day))
				sql = sql + " AND DAY(a.DT_EXTRADATE)=" + day;

			if (!"0".equals(year))
				sql = sql + " AND YEAR(a.DT_EXTRADATE)=" + year;
			if (!"0".equals(Office))
				sql = sql + " AND b.INT_OFFICEID=" + Office;

			if (!"0".equals(startLetter))
				sql = sql + " AND b.CHR_STAFFNAME LIKE  '" + startLetter
						+ "%' ";

			if (!"0".equals(staffid))
				sql = sql + " AND a.CHR_EMPID = '" + staffid + "' ";

			sql = sql + " ORDER BY  CHR_STAFFNAME";

			// System.out.println(sql);
			String readData[][] = com.my.org.erp.common.CommonFunctions
					.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			for (int u = 0; u < readData.length; u++) {
				sb.append("<Rows>");
				sb.append("<Rowid>" + readData[u][0] + "</Rowid>");
				sb.append("<Empid>" + readData[u][1] + "</Empid>");
				sb.append("<Staffname>" + readData[u][2] + "</Staffname>");
				sb.append("<Office>" + readData[u][3] + "</Office>");
				sb.append("<Date>" + readData[u][4] + "</Date>");
				sb.append("<type>" + readData[u][5] + "</type>");
				sb.append("<Status>" + readData[u][6] + "</Status>");
				sb.append("</Rows>");
			}

			response.setContentType("text/xml");
			response.setHeader("Cache-Control", "no-cache");
			response.getWriter().write("<Rowss>" + sb.toString() + "</Rowss>");

		} catch (Exception e) {
			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request
					.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
			System.out.println(e.getMessage());
		}

	}

	public static void loadOnduty(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {

			try {

				HttpSession session = request.getSession();

				String year = request.getParameter("year");
				String month = request.getParameter("month");
				String startLetter = "" + request.getParameter("startLetter");
				String Office = "" + request.getParameter("Office");
				String day = "" + request.getParameter("day");
				String staffid = "" + request.getParameter("staffid");

				String OfficeData[][] = CommonFunctions
						.QueryExecute(" SELECT b.INT_OFFICEID,b.CHR_OFFICENAME FROM  com_m_office  b "
								+ "WHERE b.INT_OFFICEID IN("
								+ CommonFunctions
										.QueryExecute("SELECT a.CHR_OFFICELIST FROM m_user a "
												+ "WHERE a.CHR_USRNAME='"
												+ ""
												+ session.getAttribute("USRID")
												+ "' ")[0][0] + " )");
				String officeids = "";
				if (OfficeData.length > 0)
					for (int u = 0; u < OfficeData.length; u++)
						officeids = officeids + OfficeData[u][0] + ",";

				String sql = "";
				sql = " SELECT a.INT_ONDUTYID ,a.CHR_EMPID,b.CHR_STAFFNAME,c.CHR_OFFICENAME,DATE_FORMAT(a.DT_ODDATE,'%d-%m-%Y'),a.CHR_TYPE, (DATEDIFF(now(),a.DT_ODDATE ) <=45 ) ";
				sql = sql
						+ " FROM att_t_onduty a,com_m_staff b,com_m_office c ";
				sql = sql
						+ " WHERE a.CHR_EMPID= b.CHR_EMPID  AND b.INT_OFFICEID =c.INT_OFFICEID";
				if (!"0".equals(month))
					sql = sql + " AND MONTH(a.DT_ODDATE) =" + month;
				if (!"0".equals(day))
					sql = sql + " AND DAY(a.DT_ODDATE)=" + day;

				if (!"0".equals(year))
					sql = sql + " AND YEAR(a.DT_ODDATE)=" + year;
				if (!"0".equals(Office))
					sql = sql + " AND b.INT_OFFICEID=" + Office;
				else
					sql = sql + " AND b.INT_OFFICEID IN (" + officeids + "0 )";

				if (!"0".equals(staffid))
					sql = sql + " AND  a.CHR_EMPID= '" + staffid + "' ";
				if (!"0".equals(startLetter))
					sql = sql + " AND b.CHR_STAFFNAME LIKE  '" + startLetter
							+ "%' ";

				sql = sql + " ORDER BY  CHR_STAFFNAME";

				// System.out.println(sql);
				String readData[][] = com.my.org.erp.common.CommonFunctions
						.QueryExecute(sql);
				StringBuffer sb = new StringBuffer();
				for (int u = 0; u < readData.length; u++) {
					sb.append("<Rows>");
					sb.append("<Rowid>" + readData[u][0] + "</Rowid>");
					sb.append("<Empid>" + readData[u][1] + "</Empid>");
					sb.append("<Staffname>" + readData[u][2] + "</Staffname>");
					sb.append("<Office>" + readData[u][3] + "</Office>");
					sb.append("<Date>" + readData[u][4] + "</Date>");
					sb.append("<type>" + readData[u][5] + "</type>");
					sb.append("<Status>" + readData[u][6] + "</Status>");
					sb.append("</Rows>");
				}

				response.setContentType("text/xml");
				response.setHeader("Cache-Control", "no-cache");
				response.getWriter().write(
						"<Rowss>" + sb.toString() + "</Rowss>");

			} catch (Exception e) {
				request.setAttribute("error", e.getMessage());
				RequestDispatcher dispatchers = request
						.getRequestDispatcher("/error/index.jsp");
				dispatchers.forward(request, response);
				System.out.println(e.getMessage());
			}

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}

	public static void StaffPermissionLeave(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {

			HttpSession session = request.getSession();
			String empid = (String) session.getAttribute("EMPID");
			String year = request.getParameter("year");
			String month = request.getParameter("month");

			String Status = "" + request.getParameter("Status");
			String day = "" + request.getParameter("day");
			String leavetype = "" + request.getParameter("leavetype");
			String startletter = "" + request.getParameter("startletter");
			String sql = "";

			sql = "SELECT a.INT_ONLINELEAVEAPPLYID, a.CHR_EMPID,b.CHR_STAFFNAME,date_format(a.DT_PDATE,'%d-%b-%Y'),a.CHR_LDESC,a.CHR_REASON,a.CHR_TYPE,a.DT_PDATE,a.CHR_STATUS,a.CHR_ADMINDESC FROM att_m_onlineapplyleave  a,com_m_staff b";
			sql = sql + " WHERE   a.CHR_EMPID = b.CHR_EMPID";
			sql = sql + "   AND a.CHR_EMPID='" + empid + "'";

			if (!"0".equals(month))
				sql = sql + " AND MONTH(a.DT_PDATE) =" + month;
			if (!"0".equals(day))
				sql = sql + " AND DAY(a.DT_PDATE)=" + day;
			if (!"0".equals(year))
				sql = sql + " AND YEAR(a.DT_PDATE)=" + year;

			if (!"0".equals(Status))
				sql = sql + " AND  a.CHR_STATUS= '" + Status + "' ";
			if (!"0".equals(leavetype))
				sql = sql + " AND  a.CHR_TYPE= '" + leavetype + "' ";
			if (!"0".equals(startletter))
				sql = sql + " AND b.CHR_STAFFNAME  LIKE '" + startletter
						+ "%' ";

			sql = sql + " ORDER BY  a.DT_PDATE ";

			System.out.println(sql);
			String readData[][] = CommonFunctions.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			for (int u = 0; u < readData.length; u++) {
				sb.append("<Rows>");
				sb.append("<Rowid>" + readData[u][0] + "</Rowid>");
				sb.append("<EmpId>" + readData[u][1] + "</EmpId>");
				sb.append("<EmpName>" + readData[u][2] + "</EmpName>");
				sb.append("<Date>" + readData[u][3] + "</Date>");
				sb.append("<Description>" + readData[u][4] + "</Description>");
				sb.append("<Reason>" + readData[u][5] + "</Reason>");
				sb.append("<Type>" + readData[u][6] + "</Type>");
				sb.append("<Sqldate>" + readData[u][7] + "</Sqldate>");
				sb.append("<Status>" + readData[u][8] + "</Status>");
				sb.append("<ARDesc>" + readData[u][9] + "</ARDesc>");
				sb.append("</Rows>");
			}

			response.setContentType("text/xml");
			response.setHeader("Cache-Control", "no-cache");
			response.getWriter().write("<Rowss>" + sb.toString() + "</Rowss>");

		} catch (Exception e) {
			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request
					.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
			System.out.println(e.getMessage());
		}
	}

	public static void ForceLeaveandPermission(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {
			HttpSession session = request.getSession();

			String year = request.getParameter("year");
			String month = request.getParameter("month");

			String Status = "" + request.getParameter("Status");
			String day = "" + request.getParameter("day");
			String leavetype = "" + request.getParameter("leavetype");
			String startletter = "" + request.getParameter("startletter");
			String sql = "";

			sql = "SELECT a.INT_ONLINELEAVEAPPLYID, a.CHR_EMPID,b.CHR_STAFFNAME,date_format(a.DT_PDATE,'%d-%b-%Y'),";
			sql = sql
					+ " a.CHR_LDESC,a.CHR_REASON,a.CHR_TYPE,a.DT_PDATE,a.CHR_STATUS,a.CHR_ADMINDESC ";
			sql = sql + " FROM att_m_onlineapplyleave  a,com_m_staff b";
			sql = sql + " WHERE   a.CHR_EMPID = b.CHR_EMPID";

			if (!"0".equals(month))
				sql = sql + " AND MONTH(a.DT_PDATE) =" + month;
			if (!"0".equals(day))
				sql = sql + " AND DAY(a.DT_PDATE)=" + day;
			if (!"0".equals(year))
				sql = sql + " AND YEAR(a.DT_PDATE)=" + year;
			if (!"0".equals(Status))
				sql = sql + " AND  a.CHR_STATUS= '" + Status + "' ";
			if (!"0".equals(leavetype))
				sql = sql + " AND  a.CHR_TYPE= '" + leavetype + "' ";
			if (!"0".equals(startletter))
				sql = sql + " AND b.CHR_STAFFNAME  LIKE '" + startletter
						+ "%' ";
			sql = sql + " AND a.CHR_USRNAME ='" + session.getAttribute("USRID")
					+ "'";
			sql = sql + " ORDER BY  a.DT_PDATE ";

			System.out.println(sql);
			String readData[][] = CommonFunctions.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			for (int u = 0; u < readData.length; u++) {
				sb.append("<Rows>");
				sb.append("<Rowid>" + readData[u][0] + "</Rowid>");
				sb.append("<EmpId>" + readData[u][1] + "</EmpId>");
				sb.append("<EmpName>" + readData[u][2] + "</EmpName>");
				sb.append("<Date>" + readData[u][3] + "</Date>");
				sb.append("<Description>" + readData[u][4] + "</Description>");
				sb.append("<Reason>" + readData[u][5] + "</Reason>");
				sb.append("<Type>" + readData[u][6] + "</Type>");
				sb.append("<Sqldate>" + readData[u][7] + "</Sqldate>");
				sb.append("<Status>" + readData[u][8] + "</Status>");
				sb.append("<ARDesc>" + readData[u][9] + "</ARDesc>");
				sb.append("</Rows>");
			}

			response.setContentType("text/xml");
			response.setHeader("Cache-Control", "no-cache");
			response.getWriter().write("<Rowss>" + sb.toString() + "</Rowss>");

		} catch (Exception e) {
			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request
					.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
			System.out.println(e.getMessage());
		}
	}

	public static void PermissionLeave(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {

			HttpSession session = request.getSession();
			String empid = "" + session.getAttribute("EMPID");

			String startLetter = request.getParameter("startletter");
			String year = request.getParameter("year");
			String month = request.getParameter("month");
			String Office = "" + request.getParameter("Office");
			String day = "" + request.getParameter("day");
			String staffid = "" + request.getParameter("staffid");
			String leavetype = "" + request.getParameter("leavetype");
			String Status = "" + request.getParameter("Status");
			String sql = "";

			sql = "SELECT a.INT_ONLINELEAVEAPPLYID, a.CHR_EMPID,b.CHR_STAFFNAME, ";
			sql = sql
					+ " date_format(a.DT_PDATE,'%d-%b-%Y'),a.CHR_LDESC,a.CHR_REASON, ";
			sql = sql
					+ " a.CHR_TYPE,a.DT_PDATE,a.CHR_STATUS,a.CHR_ADMINDESC,a.CHR_LEAVEMARK  ";
			sql = sql + " FROM att_m_onlineapplyleave  a,com_m_staff b ";
			sql = sql + " WHERE   a.CHR_EMPID = b.CHR_EMPID";
			sql = sql + " AND b.CHR_REPTO = '" + empid + "' ";
			if (!"0".equals(month))
				sql = sql + " AND MONTH(a.DT_PDATE) =" + month;
			if (!"0".equals(day))
				sql = sql + " AND DAY(a.DT_PDATE)=" + day;
			if (!"0".equals(year))
				sql = sql + " AND YEAR(a.DT_PDATE)=" + year;
			if (!"0".equals(Office))
				sql = sql + " AND b.INT_OFFICEID=" + Office;
			if (!"0".equals(staffid))
				sql = sql + " AND  a.CHR_EMPID= '" + staffid + "' ";
			if (!"0".equals(leavetype))
				sql = sql + " AND  a.CHR_TYPE= '" + leavetype + "' ";
			if (!"0".equals(Status))
				sql = sql + " AND  a.CHR_STATUS= '" + Status + "' ";
			if ("0".equals(staffid))
				if (!"0".equals(startLetter))
					sql = sql + " AND b.CHR_STAFFNAME LIKE  '" + startLetter
							+ "%' ";
			sql = sql + " ORDER BY  b.CHR_STAFFNAME,a.DT_PDATE ";
			System.out.println(sql);

			String readData[][] = CommonFunctions.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			for (int u = 0; u < readData.length; u++) {
				sb.append("<Rows>");
				sb.append("<Rowid>" + readData[u][0] + "</Rowid>");
				sb.append("<EmpId>" + readData[u][1] + "</EmpId>");
				sb.append("<EmpName>" + readData[u][2] + "</EmpName>");
				sb.append("<Date>" + readData[u][3] + "</Date>");
				sb.append("<Description>" + readData[u][4] + "</Description>");
				sb.append("<Reason>" + readData[u][5] + "</Reason>");
				sb.append("<Type>" + readData[u][6] + "</Type>");
				sb.append("<Sqldate>" + readData[u][7] + "</Sqldate>");
				sb.append("<Status>" + readData[u][8] + "</Status>");
				sb.append("<ARDesc>" + readData[u][9] + "</ARDesc>");
				sb.append("<Mark>" + readData[u][10] + "</Mark>");
				sb.append("</Rows>");
			}

			response.setContentType("text/xml");
			response.setHeader("Cache-Control", "no-cache");
			response.getWriter().write("<Rowss>" + sb.toString() + "</Rowss>");

		} catch (Exception e) {
			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request
					.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
			System.out.println(e.getMessage());
		}
	}

	public static void loadPermissionLeaveRegisterMark(
			HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		try {

			String startLetter = request.getParameter("startletter");
			String year = request.getParameter("year");
			String month = request.getParameter("month");
			String Office = "" + request.getParameter("Office");
			String day = "" + request.getParameter("day");
			String staffid = "" + request.getParameter("staffid");
			String leavetype = "" + request.getParameter("leavetype");
			String Status = "" + request.getParameter("Status");
			String sql = "";

			sql = "SELECT a.INT_ONLINELEAVEAPPLYID, a.CHR_EMPID,b.CHR_STAFFNAME, ";
			sql = sql
					+ " date_format(a.DT_PDATE,'%d-%b-%Y'),a.CHR_LDESC,a.CHR_REASON, ";
			sql = sql + " a.CHR_TYPE,a.DT_PDATE, ";
			sql = sql
					+ " if(a.CHR_STATUS='P','Pending',if(a.CHR_STATUS='R','Reject','Accept')), ";
			sql = sql + " a.CHR_ADMINDESC ,a.CHR_LEAVEMARK, ";
			sql = sql
					+ " if(CHR_MARK_STATUS='P','PERMISSION MARKED',if(CHR_MARK_STATUS='L','LEAVE MARKED',IF(CHR_MARK_STATUS='N',' ','ABSENT MARKED'))) ";
			sql = sql + " FROM att_m_onlineapplyleave  a,com_m_staff b ";
			sql = sql
					+ " WHERE   a.CHR_EMPID = b.CHR_EMPID AND a.CHR_STATUS IN ('A','R') ";

			if (!"0".equals(month))
				sql = sql + " AND MONTH(a.DT_PDATE) =" + month;
			if (!"0".equals(day))
				sql = sql + " AND DAY(a.DT_PDATE)=" + day;
			if (!"0".equals(year))
				sql = sql + " AND YEAR(a.DT_PDATE)=" + year;
			if (!"0".equals(Office))
				sql = sql + " AND b.INT_OFFICEID=" + Office;
			if (!"0".equals(staffid))
				sql = sql + " AND  a.CHR_EMPID= '" + staffid + "' ";
			if (!"0".equals(leavetype))
				sql = sql + " AND  a.CHR_TYPE= '" + leavetype + "' ";
			if (!"0".equals(Status))
				sql = sql + " AND  a.CHR_LEAVEMARK= '" + Status + "' ";
			if ("0".equals(staffid))
				if (!"0".equals(startLetter))
					sql = sql + " AND b.CHR_STAFFNAME LIKE  '" + startLetter
							+ "%' ";
			sql = sql + " ORDER BY  b.CHR_STAFFNAME,a.DT_PDATE ";
			System.out.println(sql);

			String readData[][] = CommonFunctions.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			for (int u = 0; u < readData.length; u++) {
				sb.append("<Rows>");
				sb.append("<Rowid>" + readData[u][0] + "</Rowid>");
				sb.append("<EmpId>" + readData[u][1] + "</EmpId>");
				sb.append("<EmpName>" + readData[u][2] + "</EmpName>");
				sb.append("<Date>" + readData[u][3] + "</Date>");
				sb.append("<Description>" + readData[u][4] + "</Description>");
				sb.append("<Reason>" + readData[u][5] + "</Reason>");
				sb.append("<Type>" + readData[u][6] + "</Type>");
				sb.append("<Sqldate>" + readData[u][7] + "</Sqldate>");
				sb.append("<Status>" + readData[u][8] + "</Status>");
				sb.append("<ARDesc>" + readData[u][9] + "</ARDesc>");
				sb.append("<Mark>" + readData[u][10] + "</Mark>");
				sb.append("<MarkStatus>" + readData[u][11] + "</MarkStatus>");
				sb.append("</Rows>");
			}

			response.setContentType("text/xml");
			response.setHeader("Cache-Control", "no-cache");
			response.getWriter().write("<Rowss>" + sb.toString() + "</Rowss>");

		} catch (Exception e) {
			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request
					.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
			System.out.println(e.getMessage());
		}
	}

	public static void loadAttendanceReport(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {

			HttpSession session = request.getSession();
			String empid = (String) session.getAttribute("EMPID");
			String year = request.getParameter("year");
			String month = request.getParameter("month");

			String sql = "";

			sql = " SELECT b.CHR_EMPID,b.CHR_STAFFNAME,DATE_FORMAT(a.DT_LDATE,'%d-%m-%Y'),c.CHR_LEAVENAME,a.CHR_DAYTYPE,a.DOU_VALUE   ";
			sql = sql
					+ " FROM att_t_leave a , com_m_staff b,att_m_leavetype c   ";
			sql = sql
					+ " WHERE a.CHR_EMPID = b.CHR_EMPID AND a.CHR_LEAVETYPE=c.CHR_SYMBOL   ";
			sql = sql + " AND b.CHR_EMPID ='" + empid + "'";
			if (!"0".equals(month))
				sql = sql + " AND MONTH(a.DT_LDATE) =" + month;

			if (!"0".equals(year))
				sql = sql + " AND YEAR(a.DT_LDATE)=" + year;

			String day = CommonFunctions.QueryExecute("select day(LAST_DAY('"
					+ year + "-" + month + "-01'))")[0][0];
			day = year + "-" + month + "-" + day;
			if (!"0".equals(month))
				sql = sql + " AND a.DT_LDATE  <='" + day + "'";
			sql = sql + " ORDER BY a.DT_LDATE   ";

			System.out.println(sql);
			String readData[][] = CommonFunctions.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			for (int u = 0; u < readData.length; u++) {
				sb.append("<Rows>");
				sb.append("<Id>" + readData[u][0] + "</Id>");
				sb.append("<Name>" + readData[u][1] + "</Name>");
				sb.append("<Date>" + readData[u][2] + "</Date>");
				sb.append("<Leave>" + readData[u][3] + "</Leave>");
				sb.append("<Type>" + readData[u][4] + "</Type>");
				sb.append("<Value>" + readData[u][5] + "</Value>");

				sb.append("</Rows>");
			}

			response.setContentType("text/xml");
			response.setHeader("Cache-Control", "no-cache");
			response.getWriter().write("<Rowss>" + sb.toString() + "</Rowss>");

		} catch (Exception e) {
			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request
					.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
			System.out.println(e.getMessage());
		}
	}

	public static void loadAttendanceReport1(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {
			String empid = request.getParameter("empid");
			String year = request.getParameter("year");
			String month = request.getParameter("month");
			String sql = "";
			sql = " SELECT b.CHR_EMPID,b.CHR_STAFFNAME,DATE_FORMAT(a.DT_LDATE,'%d-%m-%Y'),c.CHR_LEAVENAME,a.CHR_DAYTYPE,a.DOU_VALUE   ";
			sql = sql
					+ " FROM att_t_leave a , com_m_staff b,att_m_leavetype c   ";
			sql = sql
					+ " WHERE a.CHR_EMPID = b.CHR_EMPID AND a.CHR_LEAVETYPE=c.CHR_SYMBOL   ";
			sql = sql + " AND b.CHR_EMPID ='" + empid + "'";
			if (!"0".equals(month))
				sql = sql + " AND MONTH(a.DT_LDATE) =" + month;

			if (!"0".equals(year))
				sql = sql + " AND YEAR(a.DT_LDATE)=" + year;

			String day = CommonFunctions.QueryExecute("select day(LAST_DAY('"
					+ year + "-" + month + "-01'))")[0][0];
			day = year + "-" + month + "-" + day;
			if (!"0".equals(month))
				sql = sql + " AND a.DT_LDATE  <='" + day + "'";
			sql = sql + " ORDER BY a.DT_LDATE   ";

			String readData[][] = CommonFunctions.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			for (int u = 0; u < readData.length; u++) {
				sb.append("<Rows>");
				sb.append("<Id>" + readData[u][0] + "</Id>");
				sb.append("<Name>" + readData[u][1] + "</Name>");
				sb.append("<Date>" + readData[u][2] + "</Date>");
				sb.append("<Leave>" + readData[u][3] + "</Leave>");
				sb.append("<Type>" + readData[u][4] + "</Type>");
				sb.append("<Value>" + readData[u][5] + "</Value>");

				sb.append("</Rows>");
			}

			response.setContentType("text/xml");
			response.setHeader("Cache-Control", "no-cache");
			response.getWriter().write("<Rowss>" + sb.toString() + "</Rowss>");

		} catch (Exception e) {
			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request
					.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
			System.out.println(e.getMessage());
		}
	}

	public static void loadShiftMaster(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {
			String startLetter = "" + request.getParameter("id");
			String sql = "";
			sql = " SELECT INT_SHIFTID,CHR_SHIFTNAME,"
					+ "DT_STARTINGTIME,DT_TEA_TIMEIN1,DT_TEA_TIMEOUT1,DT_LUNCH_IN,"
					+ "DT_LUNCH_OUT,DT_TEA_TIMEIN2,DT_TEA_TIMEOUT2,DT_ENDINGTIME,"
					+ "DT_GRACEIN,DT_GRACEOUT FROM att_m_shift ";

			if (!"0".equals(startLetter))
				sql = " AND a.CHR_STAFFNAME LIKE '" + startLetter + "%'  ";
			System.out.println(sql);

			String readData[][] = CommonFunctions.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			if (readData.length > 0) {
				for (int u = 0; u < readData.length; u++) {
					sb.append("<ONHOLD>");
					sb.append("<Rowid>" + readData[u][0] + "</Rowid>");
					sb.append("<Shiftname>" + readData[u][1] + "</Shiftname>");
					sb.append("<Fromtime>" + readData[u][2] + "</Fromtime>");
					sb.append("<Totime>" + readData[u][9] + "</Totime>");
					sb.append("</ONHOLD>");
				}

				response.setContentType("text/xml");
				response.setHeader("Cache-Control", "no-cache");
				response.getWriter().write(
						"<ONHOLDS>" + sb.toString() + "</ONHOLDS>");
			} else {
				response.setStatus(HttpServletResponse.SC_NO_CONTENT);
			}
		} catch (Exception e) {

			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request
					.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
			System.out.println(e.getMessage());
		}
	}

}
