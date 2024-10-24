package com.my.org.erp.SmartHRM;

import java.io.File;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.my.org.erp.common.CommonFunctions;

public class CommonMethod extends HttpServlet {
	public static final long serialVersionUID = 1l;

	// 1
	public static void LoadJobGrade(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {
			String id = request.getParameter("id");
			String stltr = "" + request.getParameter("startLetter");
			String sql = "";

			sql = " SELECT a.INT_JOBID,  a.CHR_JOBCODE,  a.CHR_JOBTITLE,  a.CHR_QUALIFICATIONID,  a.INT_SALARY,  a.INT_EXPERIENCE ";
			sql = sql + " FROM hrm_m_jobdesign a   WHERE a.INT_JOBID > 0 ";
			if (!"0".equals(id))
				sql = sql + " AND a.CHR_JOBGRADE='" + id + "' ";

			if (!"0".equals(stltr))
				sql = sql + "AND a.CHR_JOBTITLE LIKE'" + stltr + "%'";

			System.out.println(sql);

			String readData[][] = CommonFunctions.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			String ed = "";
			if (readData.length > 0) {
				for (int u = 0; u < readData.length; u++) {
					sb.append("<job>");
					sb.append("<id>" + readData[u][0] + "</id>");
					sb.append("<code>" + readData[u][1] + "</code>");
					sb.append("<title>" + readData[u][2] + "</title>");
					String eduData[][] = CommonFunctions
							.QueryExecute("SELECT CHR_QUALIFICATIONNAME FROM com_m_qualification   WHERE 	INT_QUALIFICATIONID IN("
									+ readData[u][3] + ")");
					ed = "";
					for (int y = 0; y < eduData.length; y++)
						ed = ed + eduData[y][0] + " ,";
					ed = ed + "  ";
					ed = ed.trim();
					ed = ed.substring(0, ed.length() - 1);
					sb.append("<education>" + ed + "</education>");
					sb.append("<scale>" + readData[u][4] + "</scale>");
					sb.append("<experience>" + readData[u][5] + "</experience>");
					sb.append("</job>");

				}
				response.setContentType("text/xml");
				response.setHeader("Cache-Control", "no-cache");
				response.getWriter()
						.write("<jobs>" + sb.toString() + "</jobs>");
			} else {
				response.setStatus(HttpServletResponse.SC_NO_CONTENT);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
		}
	}

	// 2
	public static void LoadDemandJobTitle(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {
			String jobgrade = request.getParameter("jobgrade");

			String sql = "SELECT INT_JOBID,CHR_JOBCODE,CHR_JOBTITLE   FROM  hrm_m_jobdesign  WHERE CHR_JOBGRADE='"
					+ jobgrade + "'";
			String readData[][] = com.my.org.erp.common.CommonFunctions
					.QueryExecute(sql);

			StringBuffer sb = new StringBuffer();
			if (readData.length > 0) {
				for (int u = 0; u < readData.length; u++) {
					sb.append("<Row>");
					sb.append("<id>" + readData[u][0] + "</id>");
					sb.append("<code>" + readData[u][1] + "</code>");
					sb.append("<title>" + readData[u][2] + "</title>");
					sb.append("</Row>");

				}
				response.setContentType("text/xml");
				response.setHeader("Cache-Control", "no-cache");
				response.getWriter()
						.write("<Rows>" + sb.toString() + "</Rows>");
			} else {
				response.setStatus(HttpServletResponse.SC_NO_CONTENT);
			}

			// com.my.org.erp.common.CommonInfo.RecordSetArray

		} catch (Exception e) {
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
		}
	}

	// 3
	public static void loadJobDemand(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {

			String year = request.getParameter("year");
			String month = request.getParameter("month");
			String jobgrade = request.getParameter("jobgrade");
			String startLetter = request.getParameter("startLetter");
			String status = request.getParameter("status");
			String sql = "";
			sql = "SELECT a.INT_JOBDEMANDID,a.CHR_JOBGRADE,b.CHR_JOBCODE,b.CHR_JOBTITLE,c.CHR_OFFICENAME,DATE_FORMAT(a.DAT_REGISTERDATE,'%d-%b-%Y'), ";
			sql = sql
					+ " MONTHNAME(a.DAT_REGISTERDATE),YEAR(a.DAT_REGISTERDATE),a.INT_DEMAND ,a.CHR_DEMANDRAISEDBY,d.CHR_STAFFNAME,a.CHR_STATUS ";
			sql = sql
					+ " FROM hrm_m_jobdemand a,hrm_m_jobdesign b,com_m_office c ,com_m_staff d";
			sql = sql
					+ " WHERE a.INT_JOBID=b.INT_JOBID AND a.INT_OFFICEID= c.INT_OFFICEID AND a.CHR_DEMANDRAISEDBY=d.CHR_EMPID ";

			if (!"0".equals(year))
				sql = sql + " AND YEAR(a.DAT_REGISTERDATE) =" + year;

			if (!"0".equals(month))
				sql = sql + " AND MONTH(a.DAT_REGISTERDATE) =" + month;

			if (!"0".equals(jobgrade))
				sql = sql + " AND a.CHR_JOBGRADE ='" + jobgrade + "' ";

			if (!"0".equals(status))
				sql = sql + " AND a.CHR_STATUS ='" + status + "' ";

			if (!"0".equalsIgnoreCase(startLetter))
				sql = sql + "  AND b.CHR_JOBTITLE LIKE '" + startLetter + "%' ";
			sql = sql + "  order By b.CHR_JOBTITLE ";
			System.out.println(sql);

			String readData[][] = CommonFunctions.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			if (readData.length > 0) {
				for (int u = 0; u < readData.length; u++) {
					sb.append("<Rows>");
					sb.append("<id>" + readData[u][0] + "</id>");
					sb.append("<grade>" + readData[u][1]
							+ " Management </grade>");
					sb.append("<code>" + readData[u][2] + "</code>");
					sb.append("<title>" + readData[u][3] + "</title>");
					sb.append("<office>" + readData[u][4] + "</office>");
					sb.append("<date>" + readData[u][5] + "</date>");
					sb.append("<month>" + readData[u][6] + "</month>");
					sb.append("<year>" + readData[u][7] + "</year>");
					sb.append("<demand>" + readData[u][8] + "</demand>");
					sb.append("<Entry>" + readData[u][9] + "</Entry>");
					sb.append("<Entryname>" + readData[u][10] + "</Entryname>");
					sb.append("<status>" + readData[u][11] + "</status>");
					sb.append("<usertype>" + readData[u][11] + "</usertype>");

					sb.append("</Rows>");
				}

				response.setContentType("text/xml");
				response.setHeader("Cache-Control", "no-cache");
				response.getWriter().write(
						"<Rowss>" + sb.toString() + "</Rowss>");
			} else {
				response.setStatus(HttpServletResponse.SC_NO_CONTENT);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
		}
	}

	public static void loadJobCode(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {
			String id = request.getParameter("id");

			String startLetter = request.getParameter("startLetter");

			String sql = "";
			sql = "SELECT INT_JOBID,CHR_JOBTITLE,CHR_JOBCODE,CHR_JOBGRADE FROM hrm_m_jobdesign WHERE INT_JOBID >=1 ";
			if (!id.equals("0"))
				sql = sql + " AND CHR_JOBGRADE='" + id + "'";

			if (!startLetter.equals("0"))
				sql = sql + " AND CHR_JOBTITLE LIKE '" + startLetter + "%'";

			sql = sql + " ORDER BY CHR_JOBCODE ";

			String readData[][] = com.my.org.erp.common.CommonFunctions
					.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			if (readData.length > 0) {
				for (int u = 0; u < readData.length; u++) {
					sb.append("<job>");
					sb.append("<id>" + readData[u][0] + "</id>");
					sb.append("<name>" + readData[u][1] + "</name>");
					sb.append("<code>" + readData[u][2] + "</code>");
					sb.append("<grade>" + readData[u][3] + "</grade>");
					sb.append("</job>");
				}
				response.setContentType("text/xml");
				response.setHeader("Cache-Control", "no-cache");
				response.getWriter()
						.write("<jobs>" + sb.toString() + "</jobs>");
			} else {
				response.setStatus(HttpServletResponse.SC_NO_CONTENT);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
		}
	}

	public static void loadJobCodes(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {
			String id = request.getParameter("id");

			String sql = "";
			String Data[][] = com.my.org.erp.common.CommonFunctions
					.QueryExecute("SELECT INT_JOBID FROM hrm_m_jobperformance");
			String s = "0,";
			if (Data.length > 0) {
				for (int u = 0; u < Data.length; u++) {
					s = s + Data[u][0] + ",";
				}
			}

			s = s.substring(0, s.length() - 1);

			sql = "SELECT INT_JOBID FROM hrm_m_jobperformance";

			sql = "SELECT INT_JOBID,CHR_JOBTITLE,CHR_JOBCODE,CHR_JOBGRADE FROM hrm_m_jobdesign   WHERE INT_JOBID >=1";
			sql = sql + "  AND  NOT INT_JOBID IN(" + s + ")  ";

			if (!id.equals("0"))
				sql = sql + " AND CHR_JOBGRADE='" + id + "'";
			sql = sql + "  ORDER BY INT_JOBID   ";

			String readData[][] = com.my.org.erp.common.CommonFunctions
					.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			if (readData.length > 0) {
				for (int u = 0; u < readData.length; u++) {
					sb.append("<job>");
					sb.append("<id>" + readData[u][0] + "</id>");
					sb.append("<name>" + readData[u][1] + "</name>");
					sb.append("<code>" + readData[u][2] + "</code>");
					sb.append("<grade>" + readData[u][3] + "</grade>");
					sb.append("</job>");
				}
				response.setContentType("text/xml");
				response.setHeader("Cache-Control", "no-cache");
				response.getWriter()
						.write("<jobs>" + sb.toString() + "</jobs>");
			} else {
				sb.append("<job>");
				sb.append("<id>0</id>");
				sb.append("<name>Data not found...</name>");
				sb.append("<code>-</code>");
				sb.append("<grade>-</grade>");
				sb.append("</job>");
				response.setContentType("text/xml");
				response.setHeader("Cache-Control", "no-cache");
				response.getWriter()
						.write("<jobs>" + sb.toString() + "</jobs>");
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
		}
	}

	public static void loadAppView(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {

			String month = request.getParameter("mon");
			String year = request.getParameter("yr");
			String startLetter = request.getParameter("startLetter");
			String jobgrade = request.getParameter("jobgrade");
			String jobtitle = request.getParameter("jobtitle");
			String result = request.getParameter("result");
			String day = request.getParameter("day");
			String office = request.getParameter("office");

			String sql = "";
			sql = "SELECT a.CHR_JOBGRADE,a.CHR_JOBCODE,a.CHR_JOBTITLE, ";
			sql = sql
					+ " b.INT_APPID,b.CHR_APPNAME,DATE_FORMAT(b.DT_APPLICATIONDATE,'%d-%m-%Y'), b.CHR_APPCODE,";
			sql = sql
					+ " DATE_FORMAT(b.DT_DOB,'%d-%m-%Y'),b.CHR_EMAILID,b.CHR_MOBILE,b.CHR_ONLINETESTSTATUS,b.CHR_RESULT FROM hrm_m_jobdesign a, ";
			sql = sql + " hrm_m_application b WHERE a.INT_JOBID=b.INT_JOBID   ";
			sql = sql + " AND YEAR(b.DT_APPLICATIONDATE)=" + year;
			if (!"0".equals(month))
				sql = sql + " AND  MONTH (b.DT_APPLICATIONDATE)= " + month
						+ " ";
			if (!"0".equals(day))
				sql = sql + " AND  DAY(b.DT_APPLICATIONDATE)= " + day + " ";
			if (!"0".equalsIgnoreCase(result))
				sql = sql + " AND b.CHR_RESULT= '" + result + "' ";

			if (!"0".equalsIgnoreCase(jobgrade))
				sql = sql + " AND a.CHR_JOBGRADE='" + jobgrade + "'";
			if (!"0".equalsIgnoreCase(jobtitle))
				sql = sql + " AND a.INT_JOBID= " + jobtitle + " ";
			if (!office.equals("0"))
				sql = sql + " AND INT_OFFICEID= " + office + " ";
			if (!"0".equalsIgnoreCase(startLetter))
				sql = sql + "  AND b.CHR_APPNAME LIKE '" + startLetter
						+ "%' order By a.CHR_JOBTITLE ";

			System.out.println(sql);

			String readData[][] = com.my.org.erp.common.CommonFunctions
					.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			if (readData.length > 0) {
				for (int u = 0; u < readData.length; u++) {
					sb.append("<Application>");
					sb.append("<id>" + readData[u][3] + "</id>");
					sb.append("<grade>" + readData[u][0] + "</grade>");
					sb.append("<code>" + readData[u][1] + "</code>");
					sb.append("<title>" + readData[u][2] + "</title>");
					sb.append("<name>" + readData[u][4] + "</name>");
					sb.append("<dt>" + readData[u][5] + "</dt>");
					sb.append("<appcode>" + readData[u][6] + "</appcode>");

					sb.append("<dob>" + readData[u][7] + "</dob>");
					sb.append("<email>" + readData[u][8] + "</email>");
					sb.append("<mobile>" + readData[u][9] + "</mobile>");
					sb.append("<onlinetest>" + readData[u][10]
							+ "</onlinetest>");
					sb.append("<result>" + readData[u][11] + "</result>");
					sb.append("</Application>");
				}

				response.setContentType("text/xml");
				response.setHeader("Cache-Control", "no-cache");
				response.getWriter().write(
						"<Applications>" + sb.toString() + "</Applications>");
			} else {
				response.setStatus(HttpServletResponse.SC_NO_CONTENT);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
		}
	}

	public static void loadOnlineTestDetails(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {

			String month = request.getParameter("mon");
			String year = request.getParameter("yr");
			String startLetter = request.getParameter("startLetter");
			String jobgrade = request.getParameter("jobgrade");
			String jobtitle = request.getParameter("jobtitle");
			String result = request.getParameter("result");
			String day = request.getParameter("day");
			String sql = "";

			sql = "SELECT a.INT_APPID,b.CHR_APPCODE,b.CHR_APPNAME,b.CHR_JOBGRADE,c.CHR_JOBTITLE, ";
			sql = sql
					+ " DATE_FORMAT(a.DAT_ATTENDDATE,'%d-%m-%Y'),MONTHNAME(a.DAT_ATTENDDATE),YEAR(a.DAT_ATTENDDATE), ";
			sql = sql
					+ " DATE_FORMAT(b.DT_DOB,'%d-%m-%Y'),b.CHR_EMAILID,b.CHR_MOBILE,b.CHR_ONLINETESTSTATUS,b.CHR_RESULT   ";

			sql = sql
					+ " FROM hrm_t_testquestion a,hrm_m_application b ,hrm_m_jobdesign c  ";
			sql = sql
					+ " WHERE a.INT_APPID = b.INT_APPID AND b.INT_JOBID=c.INT_JOBID AND b.INT_ONLINETEST=1 ";

			if (!"0".equals(month))
				sql = sql + " AND MONTH(a.DAT_ATTENDDATE)='" + month + "'";
			if (!"0".equals(year))
				sql = sql + " AND YEAR(a.DAT_ATTENDDATE)= " + year + " ";
			if (!"0".equals(day))
				sql = sql + " AND  DAY(a.DAT_ATTENDDATE)= " + day + " ";
			if (!"0".equalsIgnoreCase(result))
				sql = sql + " AND b.CHR_RESULT= '" + result + "' ";

			if (!"0".equalsIgnoreCase(jobgrade))
				sql = sql + " AND b.CHR_JOBGRADE='" + jobgrade + "'";
			if (!"0".equalsIgnoreCase(jobtitle))
				sql = sql + " AND b.INT_JOBID= " + jobtitle + " ";
			if (!"0".equalsIgnoreCase(startLetter))
				sql = sql + "  AND b.CHR_APPNAME LIKE '" + startLetter
						+ "%'   ";

			sql = sql + " GROUP BY a.INT_APPID ";
			sql = sql + " ORDER BY b.CHR_APPNAME ";

			System.out.println(sql);

			String readData[][] = com.my.org.erp.common.CommonFunctions
					.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			if (readData.length > 0) {
				for (int u = 0; u < readData.length; u++) {
					sb.append("<Row>");
					sb.append("<ApplicantId>" + readData[u][0]
							+ "</ApplicantId>");
					sb.append("<ApplicantCode>" + readData[u][1]
							+ "</ApplicantCode>");
					sb.append("<Name>" + readData[u][2] + "</Name>");
					sb.append("<Grade>" + readData[u][3] + "</Grade>");
					sb.append("<Title>" + readData[u][4] + "</Title>");
					sb.append("<Date>" + readData[u][5] + "</Date>");
					sb.append("<Month>" + readData[u][6] + "</Month>");
					sb.append("<Year>" + readData[u][7] + "</Year>");

					sb.append("<dob>" + readData[u][8] + "</dob>");
					sb.append("<email>" + readData[u][9] + "</email>");
					sb.append("<mobile>" + readData[u][10] + "</mobile>");
					sb.append("<onlinetest>" + readData[u][11]
							+ "</onlinetest>");
					sb.append("<result>" + readData[u][12] + "</result>");

					sb.append("</Row>");
					// ApplicantId,ApplicantCode,Name,Grade,Title,Date,Month,Year
				}

				response.setContentType("text/xml");
				response.setHeader("Cache-Control", "no-cache");
				response.getWriter()
						.write("<Rows>" + sb.toString() + "</Rows>");
			} else {
				response.setStatus(HttpServletResponse.SC_NO_CONTENT);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
		}
	}

	public static void loadUnique(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {

			String id = request.getParameter("ID");
			String sql = "SELECT CHR_APPCODE FROM hrm_m_application";
			String nameBase[][] = com.my.org.erp.common.CommonFunctions
					.QueryExecute(sql);

			String msg = "Valid Name";

			for (int i = 0; i < nameBase.length; i++) {
				if (id.equalsIgnoreCase(nameBase[i][0])) {
					msg = "Already Exists";
					break;
				}
			}
			response.setContentType("text/xml");
			response.setHeader("Cache-Control", "no-cache");
			response.getWriter().write(msg);

		} catch (Exception e) {
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
		}
	}

	public static void LoadJobCodeView(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {
			String id = request.getParameter("id");
			String stltr = "" + request.getParameter("startLetter");
			String sql = "";
			if ("".equals(stltr)) {
				sql = "SELECT INT_JOBID, CHR_JOBCODE, CHR_JOBTITLE FROM hrm_m_jobdesign WHERE CHR_JOBGRADE='"
						+ id + "'";
			} else {
				sql = "SELECT INT_JOBID, CHR_JOBCODE, CHR_JOBTITLE FROM hrm_m_jobdesign WHERE CHR_JOBGRADE='"
						+ id + "' ";
				sql = sql + "AND CHR_JOBCODE LIKE'" + stltr + "%'";
			}

			String readData[][] = com.my.org.erp.common.CommonInfo
					.RecordSetArray(sql);
			StringBuffer sb = new StringBuffer();

			if (readData.length > 0) {
				for (int u = 0; u < readData.length; u++) {
					sb.append("<job>");
					sb.append("<id>" + readData[u][0] + "</id>");
					sb.append("<code>" + readData[u][1] + "</code>");
					sb.append("<title>" + readData[u][2] + "</title>");
					sb.append("</job>");

				}

				response.setContentType("text/xml");
				response.setHeader("Cache-Control", "no-cache");
				response.getWriter()
						.write("<jobs>" + sb.toString() + "</jobs>");
			} else {
				response.setStatus(HttpServletResponse.SC_NO_CONTENT);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
		}
	}

	public static void LoadJobTitle(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {
			String id = request.getParameter("id");

			String sql = "SELECT CHR_JOBCODE,UPPER(CHR_JOBTITLE),CHR_JOBGRADE,CHR_JOBPURPOSE,CHR_JOBDUTY,CHR_JOBAUTH,CHR_JOBPROMOTIONS,CHR_JOBHAZ,CHR_JOBREPORT,CHR_RESPONSE,INT_SALARY,INT_DA,INT_HRA FROM  hrm_m_jobdesign  WHERE CHR_JOBCODE='"
					+ id + "'";
			String readData[][] = com.my.org.erp.common.CommonInfo
					.RecordSetArray(sql);

			StringBuffer sb = new StringBuffer();
			boolean flag = false;
			for (int u = 0; u < readData.length; u++) {
				sb.append("<title>");
				sb.append("<id>" + readData[u][0] + "</id>");
				sb.append("<titleName>"
						+ readData[u][1].replaceAll("&", " AND")
						+ "</titleName>");
				sb.append("<titleGrade>" + readData[u][2] + "</titleGrade>");
				sb.append("<titlePurpose>" + readData[u][3] + "</titlePurpose>");
				sb.append("<titleDuty>" + readData[u][4] + "</titleDuty>");
				sb.append("<titleAuth>" + readData[u][5] + "</titleAuth>");
				sb.append("<titlePromotion>" + readData[u][6]
						+ "</titlePromotion>");
				sb.append("<titleHaz>" + readData[u][7] + "</titleHaz>");
				sb.append("<titleReport>" + readData[u][8] + "</titleReport>");
				sb.append("<titleResponse>" + readData[u][9]
						+ "</titleResponse>");
				sb.append("<titleScale>" + readData[u][10] + "</titleScale>");
				sb.append("<titleDA>" + readData[u][11] + "</titleDA>");
				sb.append("<titleHRA>" + readData[u][12] + "</titleHRA>");
				sb.append("</title>");
				flag = true;
			}
			if (flag) {
				response.setContentType("text/xml");
				response.setHeader("Cache-Control", "no-cache");
				response.getWriter().write(
						"<titles>" + sb.toString() + "</titles>");
			} else {
				response.setStatus(HttpServletResponse.SC_NO_CONTENT);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
		}
	}

	public static void loadDemandJobGrade(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {
			String id = request.getParameter("id");

			String sql1 = "SELECT INT_JOBID,CHR_JOBTITLE FROM hrm_m_jobdesign WHERE CHR_JOBGRADE='"
					+ id + "'";
			String readData[][] = com.my.org.erp.common.CommonFunctions
					.QueryExecute(sql1);

			String sql2 = "SELECT INT_JOBID FROM hrm_m_jobdemand";
			String rdData[][] = com.my.org.erp.common.CommonFunctions
					.QueryExecute(sql2);

			StringBuffer sb = new StringBuffer();
			if (readData.length > 0) {

				for (int u = 0; u < readData.length; u++) {
					boolean flag = true;

					for (int k = 0; k < rdData.length; k++) {
						if (readData[u][0].equals(rdData[k][0])) {
							flag = false;
						}
					}

					if (flag) {
						sb.append("<job>");
						sb.append("<id>" + readData[u][0] + "</id>");
						sb.append("<name>" + readData[u][1] + "</name>");
						sb.append("</job>");
					}
				}
				response.setContentType("text/xml");
				response.setHeader("Cache-Control", "no-cache");
				response.getWriter()
						.write("<jobs>" + sb.toString() + "</jobs>");
				// System.out.println(sb);
			} else {
				response.setStatus(HttpServletResponse.SC_NO_CONTENT);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
		}
	}

	// ---------------------------------

	public static void loadApplication(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {

			int mon = Integer.parseInt(request.getParameter("mon"));
			String yr = request.getParameter("yr");
			String startLetter = request.getParameter("startLetter");
			String sql = "";
			if ("0".equalsIgnoreCase(startLetter)) {
				sql = "SELECT A.CHR_JOBGRADE,A.CHR_JOBCODE,A.CHR_JOBTITLE, ";
				sql = sql
						+ " B.INT_APPID,B.CHR_APPNAME,B.DT_APPLICATIONDATE, B.CHR_APPCODE FROM hrm_m_jobdesign A, ";
				sql = sql
						+ " hrm_m_application B WHERE A.INT_JOBID=B.INT_JOBID AND ";
				sql = sql
						+ " B.CHR_MONTH='"
						+ com.my.org.erp.ServiceLogin.DateUtil
								.getMonth(mon) + "' AND B.INT_YEAR="
						+ Integer.parseInt(yr);
			} else {
				sql = "SELECT A.CHR_JOBGRADE,A.CHR_JOBCODE,A.CHR_JOBTITLE, ";
				sql = sql
						+ " B.INT_APPID,B.CHR_APPNAME,B.DT_APPLICATIONDATE, B.CHR_APPCODE FROM hrm_m_jobdesign A, ";
				sql = sql
						+ " hrm_m_application B WHERE A.INT_JOBID=B.INT_JOBID AND ";
				sql = sql
						+ " B.CHR_MONTH='"
						+ com.my.org.erp.ServiceLogin.DateUtil
								.getMonth(mon) + "' AND B.INT_YEAR="
						+ Integer.parseInt(yr) + " AND B.CHR_APPNAME LIKE '"
						+ startLetter + "%' order By A.CHR_JOBTITLE ";
			}
			String readData[][] = com.my.org.erp.common.CommonFunctions
					.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			if (readData.length > 0) {
				for (int u = 0; u < readData.length; u++) {
					sb.append("<Application>");
					sb.append("<id>" + readData[u][3] + "</id>");
					sb.append("<grade>" + readData[u][0] + "</grade>");
					sb.append("<code>" + readData[u][1] + "</code>");
					sb.append("<title>" + readData[u][2] + "</title>");
					sb.append("<name>" + readData[u][4] + "</name>");
					sb.append("<dt>" + readData[u][5] + "</dt>");
					sb.append("<appcode>" + readData[u][6] + "</appcode>");
					sb.append("</Application>");
				}

				response.setContentType("text/xml");
				response.setHeader("Cache-Control", "no-cache");
				response.getWriter().write(
						"<Applications>" + sb.toString() + "</Applications>");
			} else {
				response.setStatus(HttpServletResponse.SC_NO_CONTENT);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
		}
	}

	public static void loadAppOrder(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {

			String appCode = request.getParameter("ID");

			/*
			 * String sql1=
			 * "SELECT CHR_APPNAME, INT_JOBID, DT_APPLICATIONDATE from hrm_m_application WHERE INT_APPID ='"
			 * + appCode+ "'"; String readData1[][]
			 * =com.my.org.erp.common.CommonFunctions.QueryExecute(sql1);
			 * 
			 * 
			 * String
			 * sql2="SELECT CHR_JOBTITLE from hrm_m_jobdesign WHERE INT_JOBID ='"
			 * + readData1[0][1]+ "'"; String readData2[][]
			 * =com.my.org.erp.common.CommonFunctions.QueryExecute(sql2);
			 * 
			 * StringBuffer sb = new StringBuffer();
			 * 
			 * if(readData1.length>0 && readData2.length>0) {
			 */

			String sql1 = "SELECT A.CHR_APPNAME, A.INT_JOBID, A.DT_APPLICATIONDATE, B.CHR_JOBTITLE, B.INT_SALARY  from hrm_m_application A, hrm_m_jobdesign B WHERE A.INT_APPID ="
					+ appCode + " AND A.INT_JOBID=B.INT_JOBID";
			String readData1[][] = com.my.org.erp.common.CommonFunctions
					.QueryExecute(sql1);
			StringBuffer sb = new StringBuffer();
			if (readData1.length > 0) {
				sb.append("<Appointment>");
				sb.append("<name>" + readData1[0][0] + "</name>");
				sb.append("<title>" + readData1[0][3] + "</title>");
				sb.append("<salary>" + readData1[0][4] + "</salary>");
				sb.append("<appdate>"
						+ com.my.org.erp.ServiceLogin.DateUtil
								.FormateDateSys(readData1[0][2]) + "</appdate>");
				sb.append("</Appointment>");

				response.setContentType("text/xml");
				response.setHeader("Cache-Control", "no-cache");
				response.getWriter().write(
						"<Appointments>" + sb.toString() + "</Appointments>");
			} else {
				response.setStatus(HttpServletResponse.SC_NO_CONTENT);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
		}
	}

	public static void loadPerformance(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {
			// int mon=Integer.parseInt(request.getParameter("mon"));
			String mon = request.getParameter("mon");
			String yr = request.getParameter("yr");
			String startLetter = request.getParameter("startLetter");
			String sql = "";

			if ("0".equalsIgnoreCase(startLetter)) {
				sql = "SELECT ";
				sql = sql + "A.INT_APPID, A.CHR_APPLICATIONSTATUS, ";
				sql = sql + "B.CHR_APPCODE, B.CHR_APPNAME, ";
				sql = sql
						+ "C.CHR_JOBGRADE, C.CHR_JOBCODE, C.CHR_JOBTITLE ,B.CHR_OFFERORDERSTATUS";
				sql = sql
						+ " from hrm_t_jobperformance A, hrm_m_application B, hrm_m_jobdesign C ";
				sql = sql
						+ " where A.INT_APPID=B.INT_APPID and B.INT_JOBID=C.INT_JOBID";
				sql = sql + " and month(A.DT_UPDATEDATE)=" + mon;
				sql = sql + " and year(A.DT_UPDATEDATE)=" + yr;

			} else {
				sql = "SELECT ";
				sql = sql + "A.INT_APPID, A.CHR_APPLICATIONSTATUS, ";
				sql = sql + "B.CHR_APPCODE, B.CHR_APPNAME, ";
				sql = sql
						+ "C.CHR_JOBGRADE, C>CHR_JOBCODE, C.CHR_JOBTITLE , B.CHR_OFFERORDERSTATUS";
				sql = sql
						+ " from hrm_t_jobperformance A, hrm_m_application B, hrm_m_jobdesign C ";
				sql = sql
						+ " where A.INT_APPID=B.INT_APPID and B.INT_JOBID=C.INT_JOBID";
				sql = sql + " and month(A.DT_UPDATEDATE)=" + mon;
				sql = sql + " and year(A.DT_UPDATEDATE)=" + yr;
				sql = sql + " and B.CHR_APPNAME LIKE '" + startLetter
						+ "%' ORDER BY C.CHR_JOBGRADE";
			}

			// System.out.println(request.getRealPath("/"), sql);
			String readData[][] = com.my.org.erp.common.CommonFunctions
					.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();

			if (readData.length > 0) {
				for (int u = 0; u < readData.length; u++) {
					sb.append("<Performance>");
					sb.append("<appid>" + readData[u][0] + "</appid>");
					sb.append("<status>" + readData[u][1] + "</status>");
					sb.append("<appcode>" + readData[u][2] + "</appcode>");
					sb.append("<name>" + readData[u][3] + "</name>");
					sb.append("<grade>" + readData[u][4] + "</grade>");
					sb.append("<code>" + readData[u][5] + "</code>");
					sb.append("<title>" + readData[u][6] + "</title>");
					sb.append("<Appionment>" + readData[u][7] + "</Appionment>");
					sb.append("</Performance>");
				}

				response.setContentType("text/xml");
				response.setHeader("Cache-Control", "no-cache");
				response.getWriter().write(
						"<Performances>" + sb.toString() + "</Performances>");
				// System.out.println(sb);
			} else {
				response.setStatus(HttpServletResponse.SC_NO_CONTENT);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
		}
	}

	// -------------------------- Performance ADD ----------------------------

	public static void ComboPerformance(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {
			String appcode = request.getParameter("ID");
			// System.out.println("IXXXXXXXXX: " + appcode);

			String sql1 = "select INT_APPID, CHR_APPCODE, CHR_APPNAME, INT_JOBID from hrm_m_application where INT_APPID="
					+ appcode;
			String rData1[][] = com.my.org.erp.common.CommonFunctions
					.QueryExecute(sql1);

			String sql3 = "select INT_JOBID from hrm_m_jobperformance where INT_JOBID="
					+ rData1[0][3];
			// System.out.println(sql3);
			String rData3[][] = com.my.org.erp.common.CommonFunctions
					.QueryExecute(sql3);

			// System.out.println("\n\n\t\t Length : "+rData3.length);
			StringBuffer sb = new StringBuffer();

			if (rData3.length == 0) {
				response.setContentType("text/html");
				response.setHeader("Cache-Control", "no-cache");
				String msg = "true";
				response.getWriter().write(msg);
				System.out.println(msg);
			} else {

				if (rData1.length > 0) {
					String sql2 = "select CHR_JOBTITLE from hrm_m_jobdesign where INT_JOBID= '"
							+ rData1[0][3] + "'";
					String rData2[][] = com.my.org.erp.common.CommonFunctions
							.QueryExecute(sql2);

					sb.append("<Performance>");
					sb.append("<appId>" + rData1[0][0] + "</appId>");
					sb.append("<appcode>" + rData1[0][1] + "</appcode>");
					sb.append("<name>" + rData1[0][2] + "</name>");
					sb.append("<title>" + rData2[0][0] + "</title>");
					sb.append("</Performance>");
					response.setContentType("text/xml");
					response.setHeader("Cache-Control", "no-cache");
					response.getWriter().write(
							"<Perform>" + sb.toString() + "</Perform>");
					System.out.println(sb);
				}
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
		}
	}

	public static void loadEmployeeVerification(HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException 
	{
		try 
		{

			String mon = request.getParameter("mon");
			String yr = request.getParameter("yr");
			String startLetter = request.getParameter("startLetter");
			String sql = "";
			sql = " SELECT a.INT_VERIFICATIONID,a.CHR_NAME,a.CHR_COMPANYNAME,a.CHR_ADDRESS, a.CHR_EMAILID,a.INT_MOBILE,a.INT_PHONE,DATE_FORMAT(a.DAT_REQUEST,'%d-%b-%Y'), ";
			sql = sql
					+ " a.CHR_VERIFICATIONID,b.CHR_STAFFNAME,a.CHR_STATUS,DATE_FORMAT(a.DAT_RESPONSE,'%d-%b-%Y')  ,a.CHR_RESPONSEDBY ";
			sql = sql
					+ " FROM com_m_employeeverification a,com_m_staff b WHERE a.CHR_VERIFICATIONID = b.CHR_EMPID  ";
			if (!"0".equals(mon))
				sql = sql + " AND MONTH(a.DAT_REQUEST) ='" + mon + "' ";

			if (!"0".equals(yr))
				sql = sql + " AND YEAR(a.DAT_REQUEST) =" + yr;

			if (!"0".equals(startLetter))
				sql = sql + " AND  a.CHR_NAME LIKE '" + startLetter + "%'";
			sql = sql + " ORDER BY a.DAT_REQUEST ";
			System.out.println(sql);
			String readData[][] = CommonFunctions.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			if (readData.length > 0) 
			{
				for (int u = 0; u < readData.length; u++) 
				{
					sb.append("<Row>");
					sb.append("<Id>" + readData[u][0] + "</Id>");
					sb.append("<Name>" + readData[u][1] + "</Name>");
					sb.append("<CName>" + readData[u][2] + "</CName>");
					sb.append("<Address>" + readData[u][3] + "</Address>");
					sb.append("<Email>" + readData[u][4] + "</Email>");
					sb.append("<Mobile>" + readData[u][5] + "</Mobile>");
					sb.append("<Phone>" + readData[u][6] + "</Phone>");
					sb.append("<RequestDate>" + readData[u][7]+ "</RequestDate>");
					sb.append("<VerificationId>" + readData[u][8]+ "</VerificationId>");
					sb.append("<EmpName>" + readData[u][9] + "</EmpName>");
					sb.append("<Status>" + readData[u][10] + "</Status>");
					sb.append("<ResponseDate>" + readData[u][11]+ "</ResponseDate>");
					sb.append("<ResponsedBy>" + readData[u][12]+ "</ResponsedBy>");
					sb.append("</Row>");

				}

				response.setContentType("text/xml");
				response.setHeader("Cache-Control", "no-cache");
				response.getWriter().write("<Rows>" + sb.toString() + "</Rows>");
			} 
			else 
			{
				response.setStatus(HttpServletResponse.SC_NO_CONTENT);
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

	public static void loadResume(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {

			String month = request.getParameter("month");
			String year = request.getParameter("year");
			String day = "" + request.getParameter("day");
			String search = "" + request.getParameter("search");
			String experience = "" + request.getParameter("experience");
			
			String sql = "";

			sql = " SELECT a.INT_CAREERID,a.CHR_NAME,a.CHR_FATHERNAME,DATE_FORMAT(a.CHR_DOB,'%d-%M-%Y'), ";
			sql = sql + "  a.CHR_GENDER,a.CHR_CURRENTLOCATION,a.CHR_INTERESTEDLOCATION, ";
			sql = sql + "  b.CHR_QUALIFICATIONNAME,a.CHR_AREAOFINTEREST,a.CHR_PREVIOUSDETAILS,a.CHR_DESCRIPTION, ";
			sql = sql + "  a.CHR_EMAIL,a.INT_MOBILE,a.INT_EXPERIENCE,a.CHR_APPLIEDPOST,a.CHR_REF, ";
			sql = sql + "  a.CHR_REFNUMBER,DATE_FORMAT(a.DAT_REGISTER,'%d-%M-%Y'),a.CHR_RESUMESTATUS,CHR_RESUMEVIEWSTATUS ";
			sql = sql + "  FROM com_m_careers a ,com_m_qualification b ";
			sql = sql + "  WHERE a.INT_QUALIFICATIONID=b.INT_QUALIFICATIONID ";
			if (!"0".equals(experience))
				sql = sql + "  AND  a.INT_EXPERIENCE  = " + experience + " ";
			if (!"0".equals(day))
				sql = sql + " AND DAY(a.DAT_REGISTER)=" + day;
			if (!"0".equals(month))
				sql = sql + " AND MONTH(a.DAT_REGISTER)=" + Integer.parseInt(month);
			sql = sql + "  AND  YEAR(a.DAT_REGISTER)  =" + year + " ";
			if (!"0".equals(search))
				sql = sql + " AND  a.CHR_NAME LIKE '" + search + "%' ";
			sql = sql + "  ORDER BY a.DAT_REGISTER ";
			System.out.println(sql);
			String readData[][] = CommonFunctions.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			
			String path = request.getRealPath("/");
			File f = null;

			if (readData.length > 0) 
			{
				for (int u = 0; u < readData.length; u++) 
				{
					sb.append("<Row>");
					sb.append("<CareID>" + readData[u][0] + "</CareID>");
					sb.append("<Name>"+ readData[u][1].replaceAll("&", " AND ")	+ "</Name>");
					sb.append("<Father>"+ readData[u][2].replaceAll("&", " AND ")+ "</Father>");
					sb.append("<DOB>" + readData[u][3].replaceAll("&", " AND ")+ "</DOB>");
					sb.append("<Gender>"+ readData[u][4].replaceAll("&", " AND ")+ "</Gender>");
					sb.append("<Qualification>"+ readData[u][7].replaceAll("&", " AND ")+ "</Qualification>");
					sb.append("<Email>"+ readData[u][11].replaceAll("&", " AND ")+ "</Email>");
					sb.append("<Mobile>"+ readData[u][12].replaceAll("&", " AND ")+ "</Mobile>");
					sb.append("<Experience>"+ readData[u][13].replaceAll("&", " AND ")+ "</Experience>");
					sb.append("<AppliedPost>"+ readData[u][14].replaceAll("&", " AND ")+ "</AppliedPost>");
					sb.append("<DateofReg>"+ readData[u][17].replaceAll("&", " AND ")+ "</DateofReg>");
					sb.append("<Status>"+ readData[u][18].replaceAll("&", " AND ")+ "</Status>");
					f = new File(path+"uploadfiles/CareersResume/"+ readData[u][0] +".doc");
					if(f.exists())
						sb.append("<Download>Y</Download>");
					else
						sb.append("<Download>N</Download>");
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
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
		}
	}

	public static void loadTestType(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {
			String search = request.getParameter("search");
			String sql = "";
			sql = " SELECT INT_TESTTYPEID,CHR_TESTNAME,CHR_DESC FROM hrm_m_testtype ";
			sql = sql + " WHERE INT_TESTTYPEID >0 ";
			if (!"0".equals(search))
				sql = sql + " AND CHR_TESTNAME LIKE '" + search + "%' ";
			sql = sql + " ORDER BY CHR_TESTNAME";
			System.out.println(sql);

			String readData[][] = CommonFunctions.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			if (readData.length > 0) {
				for (int u = 0; u < readData.length; u++) {
					sb.append("<Row>");
					sb.append("<ID>" + readData[u][0] + "</ID>");
					sb.append("<Name>"
							+ readData[u][1].replaceAll("&", " AND ")
							+ "</Name>");
					sb.append("<Desc>"
							+ readData[u][2].replaceAll("&", " AND ")
							+ "</Desc>");
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
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
		}
	}

	public static void loadTestTypeQuestion(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {

			String sql = "";
			String typeid = request.getParameter("typeid");
			String search = request.getParameter("search");
			sql = " SELECT a.INT_EQUESTIONID,b.CHR_TESTNAME,a.CHR_QUESTION,a.CHR_ANSWER1,a.CHR_ANSWER2,a.CHR_ANSWER3,a.CHR_ANSWER4,a.CHR_ACTUAL_ANSWER";
			sql = sql
					+ " FROM hrm_m_testquestion a,hrm_m_testtype b WHERE a.INT_TESTTYPEID = b.INT_TESTTYPEID  ";
			if (!"0".equals(typeid))
				sql = sql + " AND a.INT_TESTTYPEID =" + typeid;
			if (!"0".equals(search))
				sql = sql + " AND a.CHR_QUESTION LIKE '" + search + "%' ";

			sql = sql + " ORDER BY b.CHR_TESTNAME ";

			System.out.println(sql);

			// System.out.println(sql);
			String readData[][] = com.my.org.erp.common.CommonFunctions
					.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			if (readData.length > 0) {
				for (int u = 0; u < readData.length; u++) {
					sb.append("<Row>");
					sb.append("<ID>" + readData[u][0] + "</ID>");
					sb.append("<Type>"
							+ (readData[u][1].replaceAll("&", " 9629314396 "))
									.replaceAll("<", "9865043008") + "</Type>");
					sb.append("<Question>"
							+ (readData[u][2].replaceAll("&", " 9629314396 "))
									.replaceAll("<", "9865043008")
							+ "</Question>");
					sb.append("<Answer1>"
							+ (readData[u][3].replaceAll("&", " 9629314396 "))
									.replaceAll("<", "9865043008")
							+ "</Answer1>");
					sb.append("<Answer2>"
							+ (readData[u][4].replaceAll("&", " 9629314396 "))
									.replaceAll("<", "9865043008")
							+ "</Answer2>");
					sb.append("<Answer3>"
							+ (readData[u][5].replaceAll("&", " 9629314396 "))
									.replaceAll("<", "9865043008")
							+ "</Answer3>");
					sb.append("<Answer4>"
							+ (readData[u][6].replaceAll("&", " 9629314396 "))
									.replaceAll("<", "9865043008")
							+ "</Answer4>");
					sb.append("<CorrectAnswer>"
							+ (readData[u][7].replaceAll("&", " 9629314396 "))
									.replaceAll(">", "9865043008")
							+ "</CorrectAnswer>");
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
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
		}
	}

	public static void loadSkill(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {

			String search = request.getParameter("search");
			String sql = "";
			sql = " SELECT INT_SKILLID,CHR_SKILLNAME,CHR_DESC FROM hrm_m_skilllevel ";
			sql = sql + " WHERE INT_SKILLID >0 ";
			if (!"0".equals(search))
				sql = sql + " AND CHR_SKILLNAME LIKE '" + search + "%' ";
			sql = sql + " ORDER BY CHR_SKILLNAME";
			System.out.println(sql);
			String readData[][] = CommonFunctions.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			if (readData.length > 0) {
				for (int u = 0; u < readData.length; u++) {
					sb.append("<Row>");
					sb.append("<ID>" + readData[u][0] + "</ID>");
					sb.append("<Name>"
							+ readData[u][1].replaceAll("&", " AND ")
							+ "</Name>");
					sb.append("<Desc>"
							+ readData[u][2].replaceAll("&", " AND ")
							+ "</Desc>");
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
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
		}
	}

	public static void loadTechnicalCompetency(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {

			String search = request.getParameter("search");
			String sql = "";

			sql = " SELECT INT_TECHNICALCOMPETENCYID,CHR_TECHNICALCOMPETENCYNAME,CHR_DESC FROM hrm_m_technicalcompetencylevel ";
			sql = sql + " WHERE INT_TECHNICALCOMPETENCYID >0 ";
			if (!"0".equals(search))
				sql = sql + " AND CHR_TECHNICALCOMPETENCYNAME LIKE '" + search
						+ "%' ";
			sql = sql + " ORDER BY CHR_TECHNICALCOMPETENCYNAME";
			System.out.println(sql);
			String readData[][] = CommonFunctions.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			if (readData.length > 0) {
				for (int u = 0; u < readData.length; u++) {
					sb.append("<Row>");
					sb.append("<ID>" + readData[u][0] + "</ID>");
					sb.append("<Name>"
							+ readData[u][1].replaceAll("&", " AND ")
							+ "</Name>");
					sb.append("<Desc>"
							+ readData[u][2].replaceAll("&", " AND ")
							+ "</Desc>");
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
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
		}
	}

	public static void loadFirstInterview(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {

			String month = request.getParameter("mon");
			String year = request.getParameter("yr");
			String startLetter = request.getParameter("startLetter");
			String jobgrade = request.getParameter("jobgrade");
			String jobtitle = request.getParameter("jobtitle");
			String result = request.getParameter("result");
			String day = request.getParameter("day");
			String office = request.getParameter("office");

			String sql = "";

			sql = sql
					+ " SELECT a.INT_INTERVIEWID, b.CHR_APPCODE,b.CHR_APPNAME,c.CHR_JOBGRADE,c.CHR_JOBCODE,c.CHR_JOBTITLE, DATE_FORMAT(a.DAT_DOI,'%d-%b-%Y'),";
			sql = sql
					+ " d.CHR_DESIGNAME,a.INT_TOTALEXP,a.INT_AGE,a.DOU_CSALARY,a.DOU_ESALARY,a.INT_NOTICEPERIOD, ";
			sql = sql
					+ " a.CHR_FIRSTINTERVIEWBY,DATE_FORMAT(a.DAT_FIRSTINTERVIEWDATE,'%d-%b-%Y'),a.CHR_ALLOWSECONDINTERVIEW , a.CHR_SECONDINTERVIEWSTATUS  ";
			sql = sql
					+ " FROM hrm_t_interview a , hrm_m_application b,hrm_m_jobdesign c ,com_m_desig d ";

			sql = sql + " WHERE a.INT_APPLICANTID  = b.INT_APPID ";
			sql = sql
					+ " AND b.INT_JOBID=c.INT_JOBID  AND a.CHR_POSITION = d.INT_DESIGID";
			if (!"0".equals(year))
				sql = sql + " AND  YEAR (a.DAT_DOI)= " + year + " ";

			if (!"0".equals(month))
				sql = sql + " AND  MONTH (a.DAT_DOI)= " + month + " ";
			if (!"0".equals(day))
				sql = sql + " AND  DAY(a.DAT_DOI)= " + day + " ";
			if (!"0".equals(office))
				sql = sql + " AND b.INT_OFFICEID= " + office + " ";

			if (!"0".equalsIgnoreCase(result))
				sql = sql + " AND a.CHR_ALLOWSECONDINTERVIEW= '" + result
						+ "' ";

			if (!"0".equalsIgnoreCase(jobgrade))
				sql = sql + " AND c.CHR_JOBGRADE='" + jobgrade + "'";
			if (!"0".equalsIgnoreCase(jobtitle))
				sql = sql + " AND c.INT_JOBID= " + jobtitle + " ";
			if (!"0".equalsIgnoreCase(startLetter))
				sql = sql + "  AND b.CHR_APPNAME LIKE '" + startLetter
						+ "%' order By b.CHR_APPNAME ";

			System.out.println(sql);
			;

			String readData[][] = com.my.org.erp.common.CommonFunctions
					.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			if (readData.length > 0) {
				for (int u = 0; u < readData.length; u++) {
					sb.append("<Row>");
					sb.append("<Id>" + readData[u][0] + "</Id>");
					sb.append("<Code>" + readData[u][1] + "</Code>");
					sb.append("<Name>" + readData[u][2] + "</Name>");
					sb.append("<Jobgrade>" + readData[u][3] + "</Jobgrade>");
					sb.append("<Jobcode>" + readData[u][4] + "</Jobcode>");
					sb.append("<Jobtitle>" + readData[u][5] + "</Jobtitle>");
					sb.append("<Dateofinterview>" + readData[u][6]
							+ "</Dateofinterview>");
					sb.append("<Position>" + readData[u][7] + "</Position>");
					sb.append("<Exp>" + readData[u][8] + "</Exp>");
					sb.append("<Age>" + readData[u][9] + "</Age>");
					sb.append("<Csalary>" + readData[u][10] + "</Csalary>");
					sb.append("<Esalary>" + readData[u][11] + "</Esalary>");
					sb.append("<NoticeP>" + readData[u][12] + "</NoticeP>");
					sb.append("<Interviewedby>"
							+ com.my.org.erp.common.CommonFunctions
									.QueryExecute("SELECT CHR_STAFFNAME FROM com_m_staff WHERE CHR_EMPID='"
											+ readData[u][13] + "'")[0][0]
							+ "</Interviewedby>");
					sb.append("<Intervieweddate>" + readData[u][14]
							+ "</Intervieweddate>");
					sb.append("<Interviewedstatus>" + readData[u][15]
							+ "</Interviewedstatus>");
					sb.append("<Secondinterviewstatus>" + readData[u][16]
							+ "</Secondinterviewstatus>");
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
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
		}
	}

	public static void loadSecondInterview(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {

			String month = request.getParameter("mon");
			String year = request.getParameter("yr");
			String startLetter = request.getParameter("startLetter");
			String jobgrade = request.getParameter("jobgrade");
			String jobtitle = request.getParameter("jobtitle");
			String office = request.getParameter("office");

			String day = request.getParameter("day");

			String sql = "";

			sql = " SELECT a.INT_INTERVIEWID, b.CHR_APPCODE,b.CHR_APPNAME,c.CHR_JOBGRADE,c.CHR_JOBCODE,c.CHR_JOBTITLE, ";
			sql = sql
					+ " DATE_FORMAT(a.DAT_DOI,'%d-%b-%Y'),    a.CHR_POSITION,  ";
			sql = sql + " a.CHR_FIRSTINTERVIEWBY, ";
			sql = sql
					+ " (select d.CHR_STAFFNAME FROM com_m_staff d where d.CHR_EMPID=a.CHR_FIRSTINTERVIEWBY ), ";
			sql = sql + " DATE_FORMAT(a.DAT_FIRSTINTERVIEWDATE,'%d-%b-%Y'),  ";
			sql = sql
					+ "  a.CHR_ALLOWSECONDINTERVIEW ,a.CHR_SECONDINTERVIEWBY, ";
			sql = sql
					+ " (select e.CHR_STAFFNAME FROM com_m_staff e where e.CHR_EMPID=a.CHR_SECONDINTERVIEWBY ), ";
			sql = sql
					+ " DATE_FORMAT(a.DAT_SECONDINTERVIEWDATE,'%d-%b-%Y'),a.CHR_SECONDINTERVIEWSTATUS ,a.CHR_FINALINTERVIEWSTATUS";
			sql = sql
					+ "  FROM hrm_t_interview a , hrm_m_application b,hrm_m_jobdesign c  ";
			sql = sql + " WHERE a.INT_APPLICANTID  = b.INT_APPID    ";
			sql = sql + " AND b.INT_JOBID=c.INT_JOBID  ";
			sql = sql + " AND a.CHR_ALLOWSECONDINTERVIEW='Y'   ";

			if (!"0".equals(office))
				sql = sql + " AND b.INT_OFFICEID= " + office + " ";

			if (!"0".equals(year))
				sql = sql + " AND  YEAR(a.DAT_DOI)= " + year + " ";

			if (!"0".equals(month))
				sql = sql + " AND  MONTH (a.DAT_DOI)= " + month + " ";
			if (!"0".equals(day))
				sql = sql + " AND  DAY(a.DAT_DOI)= " + day + " ";

			if (!"0".equalsIgnoreCase(jobgrade))
				sql = sql + " AND c.CHR_JOBGRADE='" + jobgrade + "'";
			if (!"0".equalsIgnoreCase(jobtitle))
				sql = sql + " AND c.INT_JOBID= " + jobtitle + " ";
			if (!"0".equalsIgnoreCase(startLetter))
				sql = sql + "  AND b.CHR_APPNAME LIKE '" + startLetter
						+ "%' order By b.CHR_APPNAME ";

			

			String readData[][] = com.my.org.erp.common.CommonFunctions
					.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			if (readData.length > 0) {
				for (int u = 0; u < readData.length; u++) {
					sb.append("<Row>");
					sb.append("<Id>" + readData[u][0] + "</Id>");
					sb.append("<Code>" + readData[u][1] + "</Code>");
					sb.append("<Name>" + readData[u][2] + "</Name>");
					sb.append("<Jobgrade>" + readData[u][3] + "</Jobgrade>");
					sb.append("<Jobcode>" + readData[u][4] + "</Jobcode>");
					sb.append("<Jobtitle>" + readData[u][5] + "</Jobtitle>");
					sb.append("<Dateofinterview>" + readData[u][6]
							+ "</Dateofinterview>");
					sb.append("<Position>" + readData[u][7] + "</Position>");
					sb.append("<FInterviewedby>" + readData[u][8]
							+ "</FInterviewedby>");
					sb.append("<FInterviewedname>" + readData[u][9]
							+ "</FInterviewedname>");
					sb.append("<FIntervieweddate>" + readData[u][10]
							+ "</FIntervieweddate>");
					sb.append("<FInterviewedstatus>" + readData[u][11]
							+ "</FInterviewedstatus>");
					sb.append("<SInterviewedby>" + readData[u][12]
							+ "</SInterviewedby>");
					sb.append("<SInterviewedname>" + readData[u][13]
							+ "</SInterviewedname>");
					sb.append("<SIntervieweddate>" + readData[u][14]
							+ "</SIntervieweddate>");
					sb.append("<SInterviewedstatus>" + readData[u][15]
							+ "</SInterviewedstatus>");
					sb.append("<finalstatus>" + readData[u][16]
							+ "</finalstatus>");
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
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
		}
	}

	public static void loadFinalInterview(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {

			String month = request.getParameter("mon");
			String year = request.getParameter("yr");
			String startLetter = request.getParameter("startLetter");
			String jobgrade = request.getParameter("jobgrade");
			String jobtitle = request.getParameter("jobtitle");
			String day = request.getParameter("day");
			String office = request.getParameter("office");
			String Status = request.getParameter("Status");
			String sql = "";

			sql = " SELECT a.INT_INTERVIEWID, b.CHR_APPCODE,b.CHR_APPNAME,c.CHR_JOBGRADE,c.CHR_JOBCODE,c.CHR_JOBTITLE, ";
			sql = sql
					+ " DATE_FORMAT(a.DAT_DOI,'%d-%b-%Y'),    a.CHR_POSITION,  ";
			sql = sql + " a.CHR_FIRSTINTERVIEWBY, ";
			sql = sql
					+ " (select d.CHR_STAFFNAME FROM com_m_staff d where d.CHR_EMPID=a.CHR_FIRSTINTERVIEWBY ), ";
			sql = sql + " DATE_FORMAT(a.DAT_FIRSTINTERVIEWDATE,'%d-%b-%Y'),  ";
			sql = sql
					+ "  a.CHR_ALLOWSECONDINTERVIEW ,a.CHR_SECONDINTERVIEWBY, ";
			sql = sql
					+ " (select e.CHR_STAFFNAME FROM com_m_staff e where e.CHR_EMPID=a.CHR_SECONDINTERVIEWBY ), ";
			sql = sql
					+ " DATE_FORMAT(a.DAT_SECONDINTERVIEWDATE,'%d-%b-%Y'),a.CHR_SECONDINTERVIEWSTATUS, a.CHR_CANDIDATESTATUS     ,a.CHR_FINALINTERVIEWSTATUS,a.CHR_FINALSTATUS";
			sql = sql
					+ "  FROM hrm_t_interview a , hrm_m_application b,hrm_m_jobdesign c  ";
			sql = sql + " WHERE a.INT_APPLICANTID  = b.INT_APPID    ";
			sql = sql + " AND b.INT_JOBID=c.INT_JOBID  ";
			sql = sql + " AND a.CHR_ALLOWSECONDINTERVIEW='Y'   ";

			if (!"0".equals(year))
				sql = sql + " AND  YEAR(a.DAT_DOI)= " + year + " ";

			if (!"0".equals(month))
				sql = sql + " AND  MONTH (a.DAT_DOI)= " + month + " ";
			if (!"0".equals(day))
				sql = sql + " AND  DAY(a.DAT_DOI)= " + day + " ";

			if (!"0".equals(Status))
				sql = sql + " AND   a.CHR_CANDIDATESTATUS = '" + Status + "' ";

			if (!"0".equals(office))
				sql = sql + " AND b.INT_OFFICEID= " + office + " ";

			if (!"0".equalsIgnoreCase(jobgrade))
				sql = sql + " AND c.CHR_JOBGRADE='" + jobgrade + "'";
			if (!"0".equalsIgnoreCase(jobtitle))
				sql = sql + " AND c.INT_JOBID= " + jobtitle + " ";
			if (!"0".equalsIgnoreCase(startLetter))
				sql = sql + "  AND b.CHR_APPNAME LIKE '" + startLetter
						+ "%' order By b.CHR_APPNAME ";

			
			String readData[][] = com.my.org.erp.common.CommonFunctions
					.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			if (readData.length > 0) {
				for (int u = 0; u < readData.length; u++) {
					sb.append("<Row>");
					sb.append("<Id>" + readData[u][0] + "</Id>");
					sb.append("<Code>" + readData[u][1] + "</Code>");
					sb.append("<Name>" + readData[u][2] + "</Name>");
					sb.append("<Jobgrade>" + readData[u][3] + "</Jobgrade>");
					sb.append("<Jobcode>" + readData[u][4] + "</Jobcode>");
					sb.append("<Jobtitle>" + readData[u][5] + "</Jobtitle>");
					sb.append("<Dateofinterview>" + readData[u][6]
							+ "</Dateofinterview>");
					sb.append("<Position>" + readData[u][7] + "</Position>");
					sb.append("<FInterviewedby>" + readData[u][8]
							+ "</FInterviewedby>");
					sb.append("<FInterviewedname>" + readData[u][9]
							+ "</FInterviewedname>");
					sb.append("<FIntervieweddate>" + readData[u][10]
							+ "</FIntervieweddate>");
					sb.append("<FInterviewedstatus>" + readData[u][11]
							+ "</FInterviewedstatus>");
					sb.append("<SInterviewedby>" + readData[u][12]
							+ "</SInterviewedby>");
					sb.append("<SInterviewedname>" + readData[u][13]
							+ "</SInterviewedname>");
					sb.append("<SIntervieweddate>" + readData[u][14]
							+ "</SIntervieweddate>");
					sb.append("<SInterviewedstatus>" + readData[u][15]
							+ "</SInterviewedstatus>");
					sb.append("<CandidateStatus>" + readData[u][16]
							+ "</CandidateStatus>");
					sb.append("<Status>" + readData[u][17] + "</Status>");
					sb.append("<Conculsion>" + readData[u][18]
							+ "</Conculsion>");
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
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
		}
	}

	public static void loadconclusion(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {

			String month = request.getParameter("mon");
			String year = request.getParameter("yr");
			String startLetter = request.getParameter("startLetter");
			String jobgrade = request.getParameter("jobgrade");
			String jobtitle = request.getParameter("jobtitle");
			String office = request.getParameter("office");
			String result = request.getParameter("result");
			String sql = "";

			sql = " SELECT a.INT_INTERVIEWID, b.CHR_APPCODE,b.CHR_APPNAME,c.CHR_JOBGRADE,c.CHR_JOBCODE,c.CHR_JOBTITLE, ";
			sql = sql
					+ " DATE_FORMAT(a.DAT_DOI,'%d-%m-%Y'),    a.CHR_POSITION,  ";
			sql = sql + " a.CHR_FIRSTINTERVIEWBY, ";
			sql = sql
					+ " (select d.CHR_STAFFNAME FROM com_m_staff d where d.CHR_EMPID=a.CHR_FIRSTINTERVIEWBY ), ";
			sql = sql + " DATE_FORMAT(a.DAT_FIRSTINTERVIEWDATE,'%d-%m-%Y'),  ";
			sql = sql
					+ "  a.CHR_ALLOWSECONDINTERVIEW ,a.CHR_SECONDINTERVIEWBY, ";
			sql = sql
					+ " (select e.CHR_STAFFNAME FROM com_m_staff e where e.CHR_EMPID=a.CHR_SECONDINTERVIEWBY ), ";
			sql = sql
					+ " DATE_FORMAT(a.DAT_SECONDINTERVIEWDATE,'%d-%m-%Y'),a.CHR_ALLOWTHIRDINTERVIEW  ,a.CHR_CANDIDATESTATUS,a.CHR_FINALSTATUS";
			sql = sql
					+ "  FROM hrm_t_interview a , hrm_m_application b,hrm_m_jobdesign c  ";
			sql = sql + " WHERE a.INT_APPLICANTID  = b.INT_APPID    ";
			sql = sql + " AND b.INT_JOBID=c.INT_JOBID  ";
			sql = sql
					+ " AND a.CHR_ALLOWSECONDINTERVIEW='Y' AND  a.CHR_CANDIDATESTATUS ='S'";

			if (!"0".equals(year))
				sql = sql + " AND  YEAR(a.DAT_DOI)= " + year + " ";

			if (!"0".equals(month))
				sql = sql + " AND  MONTH (a.DAT_DOI)= " + month + " ";

			if (!"0".equals(result))
				sql = sql + " AND   a.CHR_CANDIDATESTATUS = '" + result + "' ";

			if (!"0".equals(office))
				sql = sql + " AND b.INT_OFFICEID= " + office + " ";

			if (!"0".equalsIgnoreCase(jobgrade))
				sql = sql + " AND c.CHR_JOBGRADE='" + jobgrade + "'";
			if (!"0".equalsIgnoreCase(jobtitle))
				sql = sql + " AND c.INT_JOBID= " + jobtitle + " ";
			if (!"0".equalsIgnoreCase(startLetter))
				sql = sql + "  AND b.CHR_APPNAME LIKE '" + startLetter
						+ "%' order By b.CHR_APPNAME ";

		
			String readData[][] = com.my.org.erp.common.CommonFunctions
					.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			if (readData.length > 0) {
				for (int u = 0; u < readData.length; u++) {
					sb.append("<Row>");
					sb.append("<Id>" + readData[u][0] + "</Id>");
					sb.append("<Code>" + readData[u][1] + "</Code>");
					sb.append("<Name>" + readData[u][2] + "</Name>");
					sb.append("<Jobgrade>" + readData[u][3] + "</Jobgrade>");
					sb.append("<Jobcode>" + readData[u][4] + "</Jobcode>");
					sb.append("<Jobtitle>" + readData[u][5] + "</Jobtitle>");
					sb.append("<Dateofinterview>" + readData[u][6]
							+ "</Dateofinterview>");
					sb.append("<Position>" + readData[u][7] + "</Position>");
					sb.append("<FInterviewedby>" + readData[u][8]
							+ "</FInterviewedby>");
					sb.append("<FInterviewedname>" + readData[u][9]
							+ "</FInterviewedname>");
					sb.append("<FIntervieweddate>" + readData[u][10]
							+ "</FIntervieweddate>");
					sb.append("<FInterviewedstatus>" + readData[u][11]
							+ "</FInterviewedstatus>");
					sb.append("<SInterviewedby>" + readData[u][12]
							+ "</SInterviewedby>");
					sb.append("<SInterviewedname>" + readData[u][13]
							+ "</SInterviewedname>");
					sb.append("<SIntervieweddate>" + readData[u][14]
							+ "</SIntervieweddate>");
					sb.append("<SInterviewedstatus>" + readData[u][15]
							+ "</SInterviewedstatus>");
					sb.append("<Status>" + readData[u][16] + "</Status>");
					sb.append("<FStatus>" + readData[u][17] + "</FStatus>");

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
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
		}
	}

	public static void loadResult(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {

			String month = request.getParameter("month");
			String year = request.getParameter("year");
			String startLetter = request.getParameter("startLetter");
			String finalstatus = request.getParameter("finalstatus");

			String sql = "";

			sql = " SELECT a.INT_INTERVIEWID, b.CHR_APPCODE,b.CHR_APPNAME,c.CHR_JOBGRADE,c.CHR_JOBCODE,c.CHR_JOBTITLE, ";
			sql = sql + " DATE_FORMAT(a.DAT_DOI,'%d-%m-%Y'),   ";
			sql = sql + " a.CHR_POSITION, a.DOU_CSALARY,a.DOU_ESALARY , ";
			sql = sql
					+ " a.CHR_FIRSTINTERVIEWBY,DATE_FORMAT(a.DAT_FIRSTINTERVIEWDATE,'%d-%m-%Y'),  ";
			sql = sql
					+ " a.CHR_ALLOWSECONDINTERVIEW ,a.CHR_SECONDINTERVIEWBY, ";
			sql = sql
					+ " DATE_FORMAT(a.DAT_SECONDINTERVIEWDATE,'%d-%m-%Y'),a.CHR_CANDIDATESTATUS,a.CHR_FINALSTATUS   ";

			sql = sql
					+ " FROM hrm_t_interview a , hrm_m_application b,hrm_m_jobdesign c  ";

			sql = sql + " WHERE a.INT_APPLICANTID  = b.INT_APPID  ";
			sql = sql
					+ " AND b.INT_JOBID=c.INT_JOBID  AND a.CHR_ALLOWSECONDINTERVIEW='Y' "
					+ " AND a.CHR_CANDIDATESTATUS='S'   ";

			if (!"0".equals(finalstatus))
				sql = sql + " AND    a.CHR_FINALSTATUS='" + finalstatus + "' ";

			if (!"0".equals(month))
				sql = sql + " AND  MONTH (a.DAT_DOI)= " + month + " ";

			if (!"0".equals(year))
				sql = sql + " AND  YEAR (a.DAT_DOI)= " + year + " ";

			if (!"0".equalsIgnoreCase(startLetter))
				sql = sql + "  AND b.CHR_APPNAME LIKE '" + startLetter
						+ "%' order By b.CHR_APPNAME ";

			// System.out.println(sql);
			String readData[][] = com.my.org.erp.common.CommonFunctions
					.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			if (readData.length > 0) {
				for (int u = 0; u < readData.length; u++) {
					sb.append("<Row>");
					sb.append("<Id>" + readData[u][0] + "</Id>");
					sb.append("<Code>" + readData[u][1] + "</Code>");
					sb.append("<Name>" + readData[u][2] + "</Name>");
					sb.append("<Jobgrade>" + readData[u][3] + "</Jobgrade>");
					sb.append("<Jobcode>" + readData[u][4] + "</Jobcode>");
					sb.append("<Jobtitle>" + readData[u][5] + "</Jobtitle>");
					sb.append("<Dateofinterview>" + readData[u][6]
							+ "</Dateofinterview>");
					sb.append("<Position>" + readData[u][7] + "</Position>");
					sb.append("<Csalary>" + readData[u][8] + "</Csalary>");
					sb.append("<Esalary>" + readData[u][9] + "</Esalary>");
					sb.append("<Interviewedby>" + readData[u][10]
							+ "</Interviewedby>");
					sb.append("<Intervieweddate>" + readData[u][11]
							+ "</Intervieweddate>");
					sb.append("<Interviewedstatus>" + readData[u][12]
							+ "</Interviewedstatus>");
					sb.append("<SInterviewedby>" + readData[u][13]
							+ "</SInterviewedby>");
					sb.append("<SIntervieweddate>" + readData[u][14]
							+ "</SIntervieweddate>");
					sb.append("<SInterviewedstatus>" + readData[u][15]
							+ "</SInterviewedstatus>");
					sb.append("<Finalstatus>" + readData[u][16]
							+ "</Finalstatus>");
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
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
		}
	}

	public static void LoadOfferview(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {

			String month = request.getParameter("month");
			String year = request.getParameter("year");
			String startLetter = request.getParameter("startLetter");
			String finalstatus = request.getParameter("finalstatus");
			String office = request.getParameter("office");
			String offerstatus = request.getParameter("offerstatus");

			String sql = "";

			sql = " SELECT a.INT_INTERVIEWID, b.CHR_APPCODE,b.CHR_APPNAME,c.CHR_JOBGRADE,c.CHR_JOBCODE,c.CHR_JOBTITLE, ";
			sql = sql + " DATE_FORMAT(a.DAT_DOI,'%d-%m-%Y'),   ";
			sql = sql + " a.CHR_POSITION, a.DOU_CSALARY,a.DOU_ESALARY , ";
			sql = sql
					+ " a.CHR_FIRSTINTERVIEWBY,DATE_FORMAT(a.DAT_FIRSTINTERVIEWDATE,'%d-%m-%Y'),  ";
			sql = sql
					+ " a.CHR_ALLOWSECONDINTERVIEW ,a.CHR_SECONDINTERVIEWBY, ";
			sql = sql
					+ " DATE_FORMAT(a.DAT_SECONDINTERVIEWDATE,'%d-%m-%Y'),a.CHR_CANDIDATESTATUS,a.CHR_FINALSTATUS,b.CHR_OFFERORDERSTATUS,d.INT_APPID,b.CHR_EMAILID,d.CHR_ACCEPT  ";
			sql = sql
					+ " FROM hrm_t_interview a , hrm_m_application b,hrm_m_jobdesign c , hrm_t_offerletter d ";
			sql = sql
					+ " WHERE a.INT_APPLICANTID  = b.INT_APPID   AND b.INT_APPID =d.INT_APPID  ";
			sql = sql
					+ " AND b.INT_JOBID=c.INT_JOBID  AND a.CHR_ALLOWSECONDINTERVIEW='Y' "
					+ " AND a.CHR_CANDIDATESTATUS='S' AND a.CHR_FINALSTATUS='Y'  ";
			if (!"0".equals(finalstatus))
				sql = sql + " AND b.CHR_OFFERORDERSTATUS='" + finalstatus
						+ "' ";
			if (!"0".equals(offerstatus))
				sql = sql + " AND d.CHR_ACCEPT ='" + offerstatus + "' ";
			if (!"0".equals(month))
				sql = sql + " AND  MONTH (d.DT_OFFERDATE)= " + month + " ";
			if (!"0".equals(year))
				sql = sql + " AND  YEAR (d.DT_OFFERDATE)= " + year + " ";
			if (!"0".equals(office))
				sql = sql + " AND b.INT_OFFICEID= " + office + " ";
			if (!"0".equalsIgnoreCase(startLetter))
				sql = sql + "  AND b.CHR_APPNAME LIKE '" + startLetter
						+ "%' order By b.CHR_APPNAME ";

			sql = " SELECT  ";
			sql = sql
					+ " b.INT_INTERVIEWID, a.CHR_APPCODE,a.CHR_APPNAME,c.CHR_JOBGRADE,c.CHR_JOBCODE,c.CHR_JOBTITLE,   ";
			sql = sql + " DATE_FORMAT(b.DAT_DOI,'%d-%m-%Y'),      ";
			sql = sql + " b.CHR_POSITION, b.DOU_CSALARY,b.DOU_ESALARY ,  ";
			sql = sql
					+ "  b.CHR_FIRSTINTERVIEWBY,DATE_FORMAT(b.DAT_FIRSTINTERVIEWDATE,'%d-%m-%Y'),   ";
			sql = sql
					+ " b.CHR_ALLOWSECONDINTERVIEW ,b.CHR_SECONDINTERVIEWBY,    ";
			sql = sql
					+ " DATE_FORMAT(b.DAT_SECONDINTERVIEWDATE,'%d-%m-%Y'),b.CHR_CANDIDATESTATUS,   ";
			sql = sql
					+ " b.CHR_FINALSTATUS,a.CHR_OFFERORDERSTATUS,d.INT_APPID,a.CHR_EMAILID,d.CHR_ACCEPT    ";
			sql = sql + " FROM hrm_m_application a   ";
			sql = sql
					+ " LEFT JOIN hrm_t_interview b ON a.INT_APPID = b.INT_APPLICANTID  ";
			sql = sql + " JOIN  hrm_m_jobdesign c ,hrm_t_offerletter d   ";
			sql = sql
					+ " WHERE a.INT_JOBID=c.INT_JOBID  AND a.INT_APPID =d.INT_APPID    ";
			sql = sql
					+ " AND ( (   b.CHR_ALLOWSECONDINTERVIEW='Y' AND b.CHR_CANDIDATESTATUS='S' AND b.CHR_FINALSTATUS='Y')   ";
			sql = sql + "       OR (a.INT_ONLINETEST=0 )     ";
			sql = sql + "   )    ";
			if (!"0".equals(finalstatus))
				sql = sql + " AND a.CHR_OFFERORDERSTATUS='" + finalstatus
						+ "' ";
			if (!"0".equals(offerstatus))
				sql = sql + " AND d.CHR_ACCEPT ='" + offerstatus + "' ";
			if (!"0".equals(month))
				sql = sql + " AND  MONTH (d.DT_OFFERDATE)= " + month + " ";
			if (!"0".equals(year))
				sql = sql + " AND  YEAR (d.DT_OFFERDATE)= " + year + " ";
			if (!"0".equals(office))
				sql = sql + " AND a.INT_OFFICEID= " + office + " ";
			if (!"0".equalsIgnoreCase(startLetter))
				sql = sql + "  AND a.CHR_APPNAME LIKE '" + startLetter + "%'  ";

			sql = sql + "   GROUP BY a.INT_APPID  ";
			sql = sql + "   ORDER BY a.CHR_APPCODE  ";

			System.out.println(sql);

			String readData[][] = com.my.org.erp.common.CommonFunctions
					.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			if (readData.length > 0) {
				for (int u = 0; u < readData.length; u++) {
					sb.append("<Row>");
					sb.append("<Id>" + readData[u][0] + "</Id>");
					sb.append("<Code>" + readData[u][1] + "</Code>");
					sb.append("<Name>" + readData[u][2] + "</Name>");
					sb.append("<Jobgrade>" + readData[u][3] + "</Jobgrade>");
					sb.append("<Jobcode>" + readData[u][4] + "</Jobcode>");
					sb.append("<Jobtitle>" + readData[u][5] + "</Jobtitle>");
					sb.append("<Dateofinterview>" + readData[u][6]
							+ "</Dateofinterview>");
					sb.append("<Position>" + readData[u][7] + "</Position>");
					sb.append("<Csalary>" + readData[u][8] + "</Csalary>");
					sb.append("<Esalary>" + readData[u][9] + "</Esalary>");
					sb.append("<Interviewedby>" + readData[u][10]
							+ "</Interviewedby>");
					sb.append("<Intervieweddate>" + readData[u][11]
							+ "</Intervieweddate>");
					sb.append("<Interviewedstatus>" + readData[u][12]
							+ "</Interviewedstatus>");
					sb.append("<SInterviewedby>" + readData[u][13]
							+ "</SInterviewedby>");
					sb.append("<SIntervieweddate>" + readData[u][14]
							+ "</SIntervieweddate>");
					sb.append("<SInterviewedstatus>" + readData[u][15]
							+ "</SInterviewedstatus>");
					sb.append("<Finalstatus>" + readData[u][16]
							+ "</Finalstatus>");
					sb.append("<Offer>" + readData[u][17] + "</Offer>");
					sb.append("<ApplicantId>" + readData[u][18]
							+ "</ApplicantId>");
					sb.append("<Mail>" + readData[u][19] + "</Mail>");
					sb.append("<OfferAccept>" + readData[u][20]
							+ "</OfferAccept>");
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
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
		}
	}

	public static void loadOfferLetter(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		try {

			String id = request.getParameter("id");

			String sql = "";

			sql = " SELECT a.INT_INTERVIEWID, b.CHR_APPCODE,b.CHR_APPNAME,c.CHR_JOBGRADE,c.CHR_JOBCODE,c.CHR_JOBTITLE, ";
			sql = sql + " DATE_FORMAT(a.DAT_DOI,'%d-%m-%Y'),   ";
			sql = sql + " d.CHR_DESIGNAME, a.DOU_CSALARY,a.DOU_ESALARY , ";
			sql = sql
					+ " a.CHR_FIRSTINTERVIEWBY,DATE_FORMAT(a.DAT_FIRSTINTERVIEWDATE,'%d-%m-%Y'),  ";
			sql = sql
					+ " a.CHR_ALLOWSECONDINTERVIEW ,a.CHR_SECONDINTERVIEWBY, ";
			sql = sql
					+ " DATE_FORMAT(a.DAT_SECONDINTERVIEWDATE,'%d-%m-%Y'),a.CHR_CANDIDATESTATUS,a.CHR_FINALSTATUS ,a.DOU_SALARYFIXATION ,a.CHR_PREFEREDLOCATION, ";
			sql = sql
					+ " a.INT_NOTICEPERIOD,a.CHR_POSITION FROM hrm_t_interview a , hrm_m_application b,hrm_m_jobdesign c ,com_m_desig d  ";

			sql = sql + " WHERE a.INT_APPLICANTID  = b.INT_APPID  ";
			sql = sql
					+ " AND b.INT_JOBID=c.INT_JOBID  AND a.CHR_ALLOWSECONDINTERVIEW='Y' "
					+ " AND a.CHR_CANDIDATESTATUS='S' AND a.CHR_FINALSTATUS='Y'  ";
			sql = sql
					+ "  AND a.CHR_POSITION =d.INT_DESIGID AND a.INT_APPLICANTID  = "
					+ id;

			System.out.println(sql);

			String readData[][] = CommonFunctions.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			if (readData.length > 0) {
				for (int u = 0; u < readData.length; u++) {
					sb.append("<Row>");
					sb.append("<Id>" + readData[u][0] + "</Id>");
					sb.append("<Code>" + readData[u][1] + "</Code>");
					sb.append("<Name>" + readData[u][2] + "</Name>");
					sb.append("<Jobgrade>" + readData[u][3] + "</Jobgrade>");
					sb.append("<Jobcode>" + readData[u][4] + "</Jobcode>");
					sb.append("<Jobtitle>" + readData[u][5] + "</Jobtitle>");
					sb.append("<Dateofinterview>" + readData[u][6]
							+ "</Dateofinterview>");
					sb.append("<Position>" + readData[u][7] + "</Position>");
					sb.append("<Csalary>" + readData[u][8] + "</Csalary>");
					sb.append("<Esalary>" + readData[u][9] + "</Esalary>");
					sb.append("<Interviewedby>" + readData[u][10]
							+ "</Interviewedby>");
					sb.append("<Intervieweddate>" + readData[u][11]
							+ "</Intervieweddate>");
					sb.append("<Interviewedstatus>" + readData[u][12]
							+ "</Interviewedstatus>");
					sb.append("<SInterviewedby>" + readData[u][13]
							+ "</SInterviewedby>");
					sb.append("<SIntervieweddate>" + readData[u][14]
							+ "</SIntervieweddate>");
					sb.append("<SInterviewedstatus>" + readData[u][15]
							+ "</SInterviewedstatus>");
					sb.append("<Finalstatus>" + readData[u][16]
							+ "</Finalstatus>");
					sb.append("<Salary>" + readData[u][17] + "</Salary>");
					sb.append("<preferedlocation>" + readData[u][18]
							+ "</preferedlocation>");
					sb.append("<noticeperiod>" + readData[u][19]
							+ "</noticeperiod>");
					sb.append("<positionid>" + readData[u][20]
							+ "</positionid>");
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
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
		}
	}

}