package com.my.org.erp.SmartUtility;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class SecuritySettingActionHandler extends AbstractActionHandler {
	String courseName;

	int courseId;

	private void SecurityAdd(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession session = request.getSession();
			String userId = "" + session.getAttribute("USRID");
			String TxtName = request.getParameter("TxtName");
			String TxtAddress = request.getParameter("TxtAddress");
			String TxtCity = request.getParameter("TxtCity");
			String TxtState = request.getParameter("TxtState");
			String TxtPin = request.getParameter("TxtPin");
			String TxtPhone = request.getParameter("TxtPhone");
			String TxtMail = request.getParameter("TxtMail");
			String RadioDuty = request.getParameter("RadioDuty");
			String RadioLeave = request.getParameter("RadioLeave");
			String RadioPermission = request.getParameter("RadioPermission");
			String RadioManual = request.getParameter("RadioManual");
			String RadioSmart = request.getParameter("RadioSmart");
			String TxtTimeIn = request.getParameter("TxtIn");
			String TxtOut = request.getParameter("TxtOut");
			String TxtLunchIn = request.getParameter("TxtLunchIn");
			String TxtLunchOut = request.getParameter("TxtLunchOut");
			String TxtGraceIn = request.getParameter("TxtGraceIn");
			String TxtGraceOut = request.getParameter("TxtGraceOut");
			String TxtOt = request.getParameter(" TxtOt");

			CallableStatement cs = con
					.prepareCall("{call UTI_PRO_ATTSECURITY(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			cs.setString(1, "INSERT");
			cs.setString(2, "1");
			cs.setString(3, TxtName);
			cs.setString(4, TxtAddress);
			cs.setString(5, TxtCity);
			cs.setString(6, TxtState);
			cs.setString(7, TxtPin);
			cs.setString(8, TxtPhone);
			cs.setString(9, TxtMail);
			cs.setString(10, RadioDuty);
			cs.setString(11, RadioLeave);
			cs.setString(12, RadioPermission);
			cs.setString(13, RadioManual);
			cs.setString(14, RadioSmart);
			cs.setString(15, TxtTimeIn);
			cs.setString(16, TxtOut);
			cs.setString(17, TxtLunchIn);
			cs.setString(18, TxtLunchOut);
			cs.setString(19, TxtGraceIn);
			cs.setString(20, TxtGraceOut);
			cs.setString(21, TxtOt);
			cs.setString(22, userId);
			cs.execute();
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}
	}

	
	private void StudentSecurityUpdate(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession session = request.getSession();
			String userId = "" + session.getAttribute("USRID");
			String sql="Select * from stu_basicsettings";
			String resValue[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			if(resValue.length<=0)
			{
				sql="insert into stu_basicsettings(INT_ID,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS) ";
				sql=sql+ " values(1,'"+userId+"', now(),'Y')";
				PreparedStatement pst=con.prepareStatement(sql);
				pst.execute();
			}			
			sql="UPDATE  stu_basicsettings SET ";
			sql=sql+" CHR_LIB_INOUT='"+getResValue("RadioLibrary", request);			
			sql=sql+"', CHR_LIB_ISSUED='"+getResValue("RadioLibIss", request);
			sql=sql+"', CHR_LIB_RETURN='"+getResValue("RadioLibRet", request);
			sql=sql+"', CHR_INTERNET='"+getResValue("RadioInter", request);
			sql=sql+"', CHR_LAB='"+getResValue("RadioLab", request);
			sql=sql+"', CHR_GHOSTEL='"+getResValue("RadioGentHos", request);
			sql=sql+"', CHR_LHOSTEL='"+getResValue("RadioLadyHos", request);
			sql=sql+"', CHR_GMESS='"+getResValue("RadioGenMess", request);
			sql=sql+"', CHR_LMESS='"+getResValue("RadioLadyMess", request);
			sql=sql+"', CHR_CANTEEN='"+getResValue("RadioCanteen", request);
			sql=sql+"', CHR_STORE='"+getResValue("RadioStore", request);
			sql=sql+"' WHERE INT_ID=1";
			Statement st=con.createStatement();
			st.execute(sql);
			st.close();
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}
	}
	private String getResValue(String obj,HttpServletRequest request){
		String value=""+request.getParameter(obj);
		if(value.equals("null")) value="";
		return value;
	}
	
	
	public void handle(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			String action = request.getParameter("actionS");
			//System.out.println("Depart Action:" + action);
			action = action.trim();
			if (action.equals("UTIsecurityAdd")) {
				
				SecurityAdd(request, response);
				con.close();    
				response.sendRedirect("Smart Utility/SecuritySetting.jsp");
			}else if (action.equals("UTIStuSecurity")) {
				StudentSecurityUpdate(request, response);
				con.close();    
				response.sendRedirect("Smart Utility/StudentsBasicSettings.jsp?msg=Settings Changed");
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
