package com.my.org.erp.SmartHRM;

import java.io.IOException;
import java.sql.PreparedStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;

public class InterviewSheetActionHandler extends AbstractActionHandler {

	String userid = null;

	public void handle(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			userid = "" + session.getAttribute("USRID");

			if (action.equals("HRMInterViewSheetAdd")) {
				interviewAdd(request, response);
				con.close();
				response.sendRedirect("Smart HRM/ApplicantGeneralInformations.jsp");
			} else if (action.equals("HRMInterViewSheetUpdate")) {
				interviewEdit(request, response);
				response.sendRedirect("Smart HRM/ApplicantGeneralInformations.jsp");
			} else if (action.equals("HRMInterViewSheetDelete")) {
				interviewDelete(request, response);
				con.close();
				response.sendRedirect("Smart HRM/ApplicantGeneralInformations.jsp");
			} else if (action.equals("HRMSecondInterViewSheetUpdate")) {
				secondInterviewAdd(request, response);
				con.close();
				response.sendRedirect("Smart HRM/HRSecondInterview.jsp");
			} else if (action.equals("HRMSecondInterViewSheetEditUpdate")) {
				secondInterviewUpdate(request, response);
				con.close();
				response.sendRedirect("Smart HRM/HRSecondInterview.jsp");
			} else if (action.equals("HRMSecondInterViewSheetDelete")) {
				secondInterviewDelete(request, response);
				con.close();
				response.sendRedirect("Smart HRM/HRSecondInterview.jsp");
			}

			else if (action.equals("HRMSecondInterViewSheetSelected")) {
				String rowid = request.getParameter("rowid");
				PreparedStatement pstm;
				String sql = " ";

				sql = " UPDATE  hrm_t_interview SET ";
				sql = sql + " CHR_FINALSTATUS =?";
				sql = sql + " WHERE INT_INTERVIEWID =?";
				pstm = con.prepareStatement(sql);
				pstm.setString(1, "Y");
				pstm.setString(2, rowid);
				pstm.execute();
				pstm.close();
				con.close();
				response.sendRedirect("Smart HRM/HRConculusion.jsp");
			}

		} catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}	
	}

	private void interviewAdd(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {

		try {

			String applicantid = request.getParameter("applicantid");
			String doi = request.getParameter("doi");
			String position = request.getParameter("position");
			String experience = request.getParameter("experience");
			String education = request.getParameter("education");
			String age = request.getParameter("age");
			String csalary = request.getParameter("csalary");
			String esalary = request.getParameter("esalary");
			String noticeperiod = request.getParameter("noticeperiod");
			String preferedlocation = request.getParameter("preferedlocation");
			String vehicle = request.getParameter("vehicle");
			String relocation = request.getParameter("relocation");
			String fieldwork = request.getParameter("fieldwork");
			String referedby = request.getParameter("referedby");
			String comments = request.getParameter("comments");
			String InterviewedBy = request.getParameter("InterviewedBy");
			String NextLevel = request.getParameter("NextLevel");
			if (!"Y".equals(NextLevel))
				NextLevel = "N";

			String sql = "INSERT INTO  hrm_t_interview  ";

			sql = sql + "(  INT_APPLICANTID,DAT_DOI,CHR_POSITION, ";
			sql = sql
					+ " INT_TOTALEXP,INT_QUALIFICATIONID,INT_AGE,DOU_CSALARY,DOU_ESALARY, ";
			sql = sql
					+ " INT_NOTICEPERIOD,CHR_VEHICLE,CHR_RELOCATION,CHR_FIELDWORK, ";
			sql = sql + " CHR_REFERENCE,CHR_PREFEREDLOCATION,CHR_SKILLIDS, ";
			sql = sql + " CHR_SKILLLEVELS, ";
			sql = sql
					+ " CHR_FIRSTINTERVIEWBY,DAT_FIRSTINTERVIEWDATE,CHR_FIRSTCOMMENTS,CHR_ALLOWSECONDINTERVIEW, ";
			sql = sql + " CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS   ) ";
			sql = sql
					+ "  VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,NOW(),?,?,?,DATE(NOW()),'Y' )";

			apstm = con.prepareStatement(sql);

			apstm.setString(1, applicantid);
			apstm.setString(2, DateUtil.FormateDateSQL(doi));
			apstm.setString(3, position);
			apstm.setString(4, experience);
			apstm.setString(5, education);
			apstm.setString(6, age);
			apstm.setString(7, csalary);
			apstm.setString(8, esalary);
			apstm.setString(9, noticeperiod);
			apstm.setString(10, vehicle);
			apstm.setString(11, relocation);
			apstm.setString(12, fieldwork);
			apstm.setString(13, referedby);
			apstm.setString(14, preferedlocation);

			String skillsids = com.my.org.erp.common.CommonFunctions
					.QueryExecute("SELECT CHR_GENERALSKILL FROM hrm_m_jobdesign WHERE INT_JOBID=(SELECT INT_JOBID FROM hrm_m_application WHERE INT_APPID= "
							+ applicantid + ") ")[0][0];
			String skilldata[][] = com.my.org.erp.common.CommonFunctions
					.QueryExecute(" SELECT INT_SKILLID,CHR_SKILLNAME FROM  hrm_m_skilllevel WHERE INT_SKILLID IN ("
							+ skillsids + " 0) ORDER BY CHR_SKILLNAME ");
			String skillids = "";
			String skilllevels = "";
			String skillrequest = "";
			if (skilldata.length > 0) {
				for (int u = 0; u < skilldata.length; u++) {
					skillrequest = ""
							+ request.getParameter("skill_" + skilldata[u][0]);
					skillids = skillids + skilldata[u][0] + ",";
					skilllevels = skilllevels + skillrequest + ",";
				}

			}

			/*
			 * 6months 20400 3646.65+450
			 * 
			 * 22801
			 * 
			 * 
			 * month EMI - 3646 processing fees 450.
			 * 
			 * 7th feb
			 */

			apstm.setString(15, skillids);
			apstm.setString(16, skilllevels);
			apstm.setString(17, InterviewedBy);
			apstm.setString(18, comments);
			apstm.setString(19, NextLevel);
			apstm.setString(20, userid);
			System.out.println("" + apstm);
			apstm.execute();
			apstm.close();

		} catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}	
	}

	private void interviewDelete(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {

		try {

			String rowids[] = request.getParameterValues("rowid");

			String sql = " DELETE FROM hrm_t_interview WHERE INT_INTERVIEWID=? ";
			apstm = con.prepareStatement(sql);

			for (int i = 0; i < rowids.length; i++) {

				apstm.setString(1, rowids[i]);
				apstm.addBatch();

			}
			apstm.executeBatch();
			apstm.close();
			apstm.close();

		} catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}	
	}

	private void interviewEdit(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {

		try {

			String rowid = request.getParameter("rowid");
			System.out.println(rowid);
			String applicantid = request.getParameter("applicantid");
			String doi = request.getParameter("doi");
			String position = request.getParameter("position");
			String experience = request.getParameter("experience");
			String education = request.getParameter("education");
			String age = request.getParameter("age");
			String csalary = request.getParameter("csalary");
			String esalary = request.getParameter("esalary");
			String noticeperiod = request.getParameter("noticeperiod");
			String preferedlocation = request.getParameter("preferedlocation");
			String vehicle = request.getParameter("vehicle");
			String relocation = request.getParameter("relocation");
			String fieldwork = request.getParameter("fieldwork");
			String referedby = request.getParameter("referedby");
			String comments = request.getParameter("comments");
			String InterviewedBy = request.getParameter("InterviewedBy");
			String NextLevel = request.getParameter("NextLevel");
			if (!"Y".equals(NextLevel))
				NextLevel = "N";
			else
				NextLevel = "Y";

			String sql = "UPDATE hrm_t_interview   SET ";

			sql = sql + "  INT_APPLICANTID=?,DAT_DOI=?,CHR_POSITION=?, ";
			sql = sql
					+ " INT_TOTALEXP=?,INT_QUALIFICATIONID=?,INT_AGE=?,DOU_CSALARY=?,DOU_ESALARY=?, ";
			sql = sql
					+ " INT_NOTICEPERIOD=?,CHR_VEHICLE=?,CHR_RELOCATION=?,CHR_FIELDWORK=?, ";
			sql = sql
					+ " CHR_REFERENCE=?,CHR_PREFEREDLOCATION=?,CHR_SKILLIDS=?,CHR_SKILLLEVELS=?, ";
			sql = sql + "  ";
			sql = sql
					+ " CHR_FIRSTINTERVIEWBY=?,DAT_FIRSTINTERVIEWDATE=NOW(),CHR_FIRSTCOMMENTS=?,CHR_ALLOWSECONDINTERVIEW=?, ";
			sql = sql
					+ " CHR_USRNAME=?,DT_UPDATEDATE=DATE(NOW()),CHR_UPDATESTATUS='Y',CHR_SKILLIDS1=?,CHR_SKILLLEVELS1 =?  WHERE INT_INTERVIEWID=?  ";

			apstm = con.prepareStatement(sql);
			apstm.setString(1, applicantid);
			apstm.setString(2, DateUtil.FormateDateSQL(doi));
			apstm.setString(3, position);
			apstm.setString(4, experience);
			apstm.setString(5, education);
			apstm.setString(6, age);
			apstm.setString(7, csalary);
			apstm.setString(8, esalary);
			apstm.setString(9, noticeperiod);
			apstm.setString(10, vehicle);
			apstm.setString(11, relocation);
			apstm.setString(12, fieldwork);
			apstm.setString(13, referedby);
			apstm.setString(14, preferedlocation);

			String skillsids = com.my.org.erp.common.CommonFunctions
					.QueryExecute("SELECT CHR_GENERALSKILL FROM hrm_m_jobdesign WHERE INT_JOBID=(SELECT INT_JOBID FROM hrm_m_application WHERE INT_APPID= "
							+ applicantid + ") ")[0][0];
			String skilldata[][] = com.my.org.erp.common.CommonFunctions
					.QueryExecute(" SELECT INT_SKILLID,CHR_SKILLNAME FROM  hrm_m_skilllevel WHERE INT_SKILLID IN ("
							+ skillsids + " 0) ORDER BY CHR_SKILLNAME ");
			String skillids = "";
			String skilllevels = "";
			String skillrequest = "";
			if (skilldata.length > 0) {
				for (int u = 0; u < skilldata.length; u++) {
					skillrequest = ""
							+ request.getParameter("skill_" + skilldata[u][0]);
					skillids = skillids + skilldata[u][0] + ",";
					skilllevels = skilllevels + skillrequest + ",";
				}

			}

			apstm.setString(15, skillids);
			apstm.setString(16, skilllevels);
			apstm.setString(17, InterviewedBy);
			apstm.setString(18, comments);
			apstm.setString(19, NextLevel);
			apstm.setString(20, userid);
			apstm.setString(21, skillids);
			apstm.setString(22, skilllevels);
			apstm.setString(23, rowid);

			System.out.println("" + apstm);
			apstm.execute();
			apstm.close();

		} catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}	
	}

	private void secondInterviewAdd(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {

		try {

			String rowid = request.getParameter("rowid");
			String InterviewedBy = request.getParameter("InterviewedBy");
			String comments = request.getParameter("comments");
			String NextLevel = "" + request.getParameter("NextLevel");
			String jobid = "" + request.getParameter("jobid");

			String status = "Y";
			if (!NextLevel.equals("Y")) {
				NextLevel = "N";
				status = "F";
			}

			String sql = " ";
			sql = " UPDATE  hrm_t_interview SET ";
			sql = sql
					+ " CHR_SKILLIDS=?,CHR_SKILLLEVELS=?,CHR_TECHNICALIDS=?,CHR_TECHNICALLEVELS=?,CHR_SECONDINTERVIEWBY=?,"
					+ "DAT_SECONDINTERVIEWDATE=NOW(),CHR_SECONDCOMMENTS=?,CHR_ALLOWTHIRDINTERVIEW=? , "
					+ " CHR_SECONDINTERVIEWSTATUS=?   ";
			sql = sql + " ";
			sql = sql + " WHERE INT_INTERVIEWID =?";

			// GENERAL SKILLS
			String skillsids = com.my.org.erp.common.CommonFunctions
					.QueryExecute("SELECT CHR_GENERALSKILL FROM hrm_m_jobdesign WHERE INT_JOBID= "
							+ jobid)[0][0];
			String skilldata[][] = com.my.org.erp.common.CommonFunctions
					.QueryExecute(" SELECT INT_SKILLID,CHR_SKILLNAME FROM  hrm_m_skilllevel WHERE INT_SKILLID IN ("
							+ skillsids + " 0) ORDER BY CHR_SKILLNAME ");
			String skillids = "";
			String skilllevels = "";
			String skillrequest = "";
			if (skilldata.length > 0) {
				for (int u = 0; u < skilldata.length; u++) {
					skillrequest = ""
							+ request.getParameter("skill_" + skilldata[u][0]);
					skillids = skillids + skilldata[u][0] + ",";
					skilllevels = skilllevels + skillrequest + ",";
				}

			}

			// TECHNICAL SKILLS
			String techsids = com.my.org.erp.common.CommonFunctions
					.QueryExecute("SELECT CHR_TECHNICALSKILL FROM hrm_m_jobdesign WHERE INT_JOBID="
							+ jobid)[0][0];
			String techdata[][] = com.my.org.erp.common.CommonFunctions
					.QueryExecute(" SELECT INT_TECHNICALCOMPETENCYID,CHR_TECHNICALCOMPETENCYNAME FROM  hrm_m_technicalcompetencylevel WHERE INT_TECHNICALCOMPETENCYID IN ("
							+ techsids
							+ " 0) ORDER BY CHR_TECHNICALCOMPETENCYNAME ");
			String techids = "";
			String techlevels = "";
			String techrequest = "";
			if (techdata.length > 0) {
				for (int u = 0; u < techdata.length; u++) {
					techrequest = ""
							+ request.getParameter("Tskill_" + techdata[u][0]);
					techids = techids + techdata[u][0] + ",";
					techlevels = techlevels + techrequest + ",";
				}

			}

			apstm = con.prepareStatement(sql);
			apstm.setString(1, skillids);
			apstm.setString(2, skilllevels);
			apstm.setString(3, techids);
			apstm.setString(4, techlevels);
			apstm.setString(5, InterviewedBy);
			apstm.setString(6, comments);
			apstm.setString(7, NextLevel);
			apstm.setString(8, status);
			apstm.setString(9, rowid);
			System.out.println("-----------     " + apstm);
			apstm.execute();
			apstm.close();

		} catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}	
	}

	private void secondInterviewUpdate(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {

		try {

			String rowid = request.getParameter("rowid");
			String InterviewedBy = request.getParameter("InterviewedBy");
			String comments = request.getParameter("comments");
			String NextLevel = "" + request.getParameter("NextLevel");
			String jobid = "" + request.getParameter("jobid");
			String status = "Y";
			if (!NextLevel.equals("Y")) {
				NextLevel = "N";
				status = "F";
			}

			
			String sql = " ";
			sql = " UPDATE  hrm_t_interview SET ";
			sql = sql
					+ " CHR_TECHNICALIDS=?,CHR_TECHNICALLEVELS=?,CHR_SECONDINTERVIEWBY=?,"
					+ "DAT_SECONDINTERVIEWDATE=NOW(),CHR_SECONDCOMMENTS=?,CHR_ALLOWTHIRDINTERVIEW=? ,"
					+ " CHR_SECONDINTERVIEWSTATUS=?";
			sql = sql + " ";
			sql = sql + " WHERE INT_INTERVIEWID =?";

			String techsids = com.my.org.erp.common.CommonFunctions
					.QueryExecute("SELECT CHR_TECHNICALSKILL FROM hrm_m_jobdesign WHERE INT_JOBID="
							+ jobid)[0][0];
			String techdata[][] = com.my.org.erp.common.CommonFunctions
					.QueryExecute(" SELECT INT_TECHNICALCOMPETENCYID,CHR_TECHNICALCOMPETENCYNAME FROM  hrm_m_technicalcompetencylevel WHERE INT_TECHNICALCOMPETENCYID IN ("
							+ techsids
							+ " 0) ORDER BY CHR_TECHNICALCOMPETENCYNAME ");
			String techids = "";
			String techlevels = "";
			String techrequest = "";
			if (techdata.length > 0) {
				for (int u = 0; u < techdata.length; u++) {
					techrequest = ""
							+ request.getParameter("Tskill_" + techdata[u][0]);
					techids = techids + techdata[u][0] + ",";
					techlevels = techlevels + techrequest + ",";
				}

			}

			apstm = con.prepareStatement(sql);
			apstm.setString(1, techids);
			apstm.setString(2, techlevels);
			apstm.setString(3, InterviewedBy);
			apstm.setString(4, comments);
			apstm.setString(5, NextLevel);
			apstm.setString(6, status);
			apstm.setString(7, rowid);
			apstm.execute();
			apstm.close();

		} catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}	
	}

	private void secondInterviewDelete(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {

		try {

			String rowids[] = request.getParameterValues("rowid");
			PreparedStatement pstm;
			String sql = " ";

			sql = " UPDATE  hrm_t_interview SET ";
			sql = sql
					+ " CHR_TECHNICALIDS=null, CHR_TECHNICALLEVELS=null,CHR_SECONDINTERVIEWBY =null,DAT_SECONDINTERVIEWDATE=null,CHR_SECONDCOMMENTS=null,CHR_ALLOWTHIRDINTERVIEW='N',CHR_SECONDINTERVIEWSTATUS='N' ";
			sql = sql
					+ " , CHR_SKILLIDS= CHR_SKILLIDS1,CHR_SKILLLEVELS=CHR_SKILLLEVELS1 WHERE INT_INTERVIEWID =? AND  CHR_CANDIDATESTATUS ='N' AND CHR_FINALSTATUS  ='N'";
			pstm = con.prepareStatement(sql);

			for (int i = 0; i < rowids.length; i++) {

				pstm.setString(1, rowids[i]);
				// System.out.println(""+pstm);
				pstm.addBatch();

			}
			pstm.executeBatch();
			pstm.close();

		} catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}	
	}

}
