package com.my.org.erp.SmartAttendance;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.bean.Attendance.ShiftMaster;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class ShiftMaster1ActionHandler extends AbstractActionHandler {
	
	private String TxtShiftCode,TxtShiftName,TxtShiftFrom,TxtShiftTo,sql,userId;
	private String teaTimeIn1,teaTimeOut1,teaTimeIn2,teaTimeOut2,lunchIn,lunchOut;
	private String graceIn,graceOut,cudate;
	private PreparedStatement ps=null;
	private HttpSession session =null;
	
	private void ShiftList(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			ArrayList<ShiftMaster> shiftList = new ArrayList<ShiftMaster>();
			sql="SELECT INT_SHIFTID,CHR_SHIFTNAME," +
					"DT_STARTINGTIME,DT_TEA_TIMEIN1,DT_TEA_TIMEOUT1,DT_LUNCH_IN," +
					"DT_LUNCH_OUT,DT_TEA_TIMEIN2,DT_TEA_TIMEOUT2,DT_ENDINGTIME," +
					"DT_GRACEIN,DT_GRACEOUT FROM att_m_shift";
			String shiftlist[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			for(int i=0;i<shiftlist.length;i++)
			{
				
				TxtShiftCode 	=shiftlist[i][0];
				TxtShiftName 	=shiftlist[i][1];
				TxtShiftFrom 	=shiftlist[i][2];
				teaTimeIn1		=shiftlist[i][3];
				teaTimeOut1		=shiftlist[i][4];
				lunchIn			=shiftlist[i][5];
				lunchOut		=shiftlist[i][6];
				teaTimeIn2		=shiftlist[i][7];
				teaTimeOut2		=shiftlist[i][8];
				TxtShiftTo 		=shiftlist[i][9];
				graceIn			=shiftlist[i][10];
				graceOut		=shiftlist[i][11];
				
				ShiftMaster shift = new ShiftMaster(TxtShiftCode, TxtShiftName,
						TxtShiftFrom, TxtShiftTo);
				shift.setTeaTimeOut1(teaTimeOut1);				
				shift.setTeaTimeIn1(teaTimeIn1);
				shift.setLunchOut(lunchOut);				
				shift.setLunchIn(lunchIn);
				shift.setTeaTimeOut2(teaTimeOut2);				
				shift.setTeaTimeIn2(teaTimeIn2);
				shift.setGraceIn(graceIn);
				shift.setGraceOut(graceOut);
				
				shiftList.add(shift);
			}
			
			HttpSession session = request.getSession();
			session.setAttribute("shiftList", shiftList);
			
			 
			} catch (Exception e) {
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}

	private void ShiftDelete(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			sql = "DELETE FROM ATT_M_SHIFT WHERE INT_SHIFTID=?";
			String[] ShiftId = request.getParameterValues("OptShiftName");
			ps=con.prepareStatement(sql);
			for (int i = 0; i < ShiftId.length; i++) {
				ps.setString(1,ShiftId[i]);
				ps.addBatch();
			}
			ps.executeBatch();
			
		} catch (Exception e) {
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}

	private void ShiftAdd(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {			
			
			TxtShiftName = request.getParameter("TxtShiftName");
			TxtShiftFrom = request.getParameter("TxtStart");
			teaTimeIn1=""+request.getParameter("MorTeaIn");
			teaTimeOut1=""+request.getParameter("MorTeaOut");
			lunchIn=request.getParameter("LunchIn");
			lunchOut=request.getParameter("LunchOut");
			teaTimeIn2=""+request.getParameter("EveTeaIn");
			teaTimeOut2=request.getParameter("EveTeaOut");
			TxtShiftTo = request.getParameter("TxtEnding");
			graceIn=request.getParameter("StartGrace");
			graceOut=request.getParameter("EndGrace");
			
			session = request.getSession();
			userId = "" + session.getAttribute("USRID");
			cudate=com.my.org.erp.ServiceLogin.DateUtil.getCurrentDBDate();
			
			sql="INSERT INTO att_m_shift(CHR_SHIFTNAME,DT_STARTINGTIME," +
			"DT_TEA_TIMEIN1,DT_TEA_TIMEOUT1,DT_LUNCH_IN,DT_LUNCH_OUT," +
			"DT_TEA_TIMEIN2,DT_TEA_TIMEOUT2,DT_ENDINGTIME,DT_GRACEIN," +
			"DT_GRACEOUT,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS) VALUES" +
			"(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			 
			ps=con.prepareStatement(sql);
			ps.setString(1, TxtShiftName);
			ps.setString(2, TxtShiftFrom);
			ps.setString(3, teaTimeIn1);
			ps.setString(4, teaTimeOut1);
			ps.setString(5, lunchIn);
			ps.setString(6, lunchOut);
			ps.setString(7, teaTimeIn2);
			ps.setString(8, teaTimeOut2);
			ps.setString(9, TxtShiftTo);
			ps.setString(10, graceIn);
			ps.setString(11, graceOut);
			ps.setString(12, userId);
			ps.setString(13, cudate);
			ps.setString(14, "Y");
			ps.execute();
			
		} catch (Exception e) {
			 System.out.println(e.getMessage());
		}
	}

	private void ShiftEdit(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		try {
			TxtShiftCode = request.getParameter("TxtShiftId");			
			TxtShiftName = request.getParameter("TxtShiftName");
			TxtShiftFrom = request.getParameter("TxtStart");
			teaTimeIn1=""+request.getParameter("MorTeaIn");
			teaTimeOut1=""+request.getParameter("MorTeaOut");
			lunchIn=request.getParameter("LunchIn");
			lunchOut=request.getParameter("LunchOut");
			teaTimeIn2=""+request.getParameter("EveTeaIn");
			teaTimeOut2=request.getParameter("EveTeaOut");
			TxtShiftTo = request.getParameter("TxtEnding");
			graceIn=request.getParameter("StartGrace");
			graceOut=request.getParameter("EndGrace");
			session = request.getSession();
			userId = "" + session.getAttribute("USRID");
			cudate=com.my.org.erp.ServiceLogin.DateUtil.getCurrentDBDate();
			
			sql="UPDATE att_m_shift set CHR_SHIFTNAME=?,DT_STARTINGTIME=?," +
			"DT_TEA_TIMEIN1=?,DT_TEA_TIMEOUT1=?,DT_LUNCH_IN=?,DT_LUNCH_OUT=?," +
			"DT_TEA_TIMEIN2=?,DT_TEA_TIMEOUT2=?,DT_ENDINGTIME=?,DT_GRACEIN=?," +
			"DT_GRACEOUT=?,CHR_USRNAME=?,DT_UPDATEDATE=?,CHR_UPDATESTATUS=?" +
			" WHERE INT_SHIFTID=?";
			
			ps=con.prepareStatement(sql);
			ps.setString(1, TxtShiftName);
			ps.setString(2, TxtShiftFrom);
			ps.setString(3, teaTimeIn1);
			ps.setString(4, teaTimeOut1);
			ps.setString(5, lunchIn);
			ps.setString(6, lunchOut);
			ps.setString(7, teaTimeIn2);
			ps.setString(8, teaTimeOut2);
			ps.setString(9, TxtShiftTo);
			ps.setString(10, graceIn);
			ps.setString(11, graceOut);
			ps.setString(12, userId);
			ps.setString(13, cudate);
			ps.setString(14, "Y");
			ps.setString(15, TxtShiftCode);
			ps.execute(); 
			
		} catch (Exception e) {
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}

	public void handle(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			String action = request.getParameter("actionS");

			if (action.equals("ATTshiftList")) {
				ShiftList(request, response);
				con.close();   
				response.sendRedirect("Smart Attendance/ShiftMasterView.jsp");
			} else if (action.equals("ATTshiftDelete")) {
				ShiftDelete(request, response);
				ShiftList(request, response);
				con.close();   
				response.sendRedirect("Smart Attendance/ShiftMasterView.jsp");
			} else if (action.equals("ATTshiftAdd")) {
				ShiftAdd(request, response);
				ShiftList(request, response);
				con.close();   
				response.sendRedirect("Smart Attendance/ShiftMasterView.jsp");
			} else if (action.equals("ATTshiftEdit")) {
				ShiftEdit(request, response);
				ShiftList(request, response);
				con.close();   
				response.sendRedirect("Smart Attendance/ShiftMasterView.jsp");
			} else if (action.equals("ATTshiftTest")) {
				ShiftList(request, response);
				con.close();   
				RequestDispatcher dispatcher = application
						.getRequestDispatcher("/Smart Attendance/StaffPersDeptViewPrint.jsp");
				dispatcher.forward(request, response);
				// response.sendRedirect("Smart
				// Attendance/StaffPersDeptViewPrint.jsp");
			}
		} catch (Exception e) {
			//response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}

}
