package com.my.org.erp.SmartAttendance;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
 
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.common.CommonFunctions;
 

public class PasswordActionHandler extends AbstractActionHandler 
{
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			action = action.trim();
			HttpSession session=request.getSession();			
			String user = session.getAttribute("USRID").toString();
			String datass[][] =  CommonFunctions.QueryExecute(" SELECT CHR_PASSWORD FROM m_institution WHERE INT_ID=1");
			String defaultpass=datass[0][0];
			 
			if (action.equals("ATTPasswordReset")) 
			{
				String empids[]=request.getParameterValues("ename");
				for(int u=0;u<empids.length;u++)
				{
					if(!"ADMIN".equals(user.toUpperCase()))
					{	
						//sql ="UPDATE M_USER SET CHR_USERNAME='"+user+"' ,DT_UPDATEDATE=DATE(NOW()),CHR_UPDATESTATUS='Y',  CHR_USRPWD =(ENCODE('"+defaultpass+"','9865043008')), DAT_LASTPASSWORDCHANGE = NOW() WHERE CHR_USRNAME='"+empids[u].substring(10,16)+"'";
						asql ="UPDATE M_USER SET CHR_USERNAME=? ,DT_UPDATEDATE=DATE(NOW()),CHR_UPDATESTATUS='Y', ";
						asql = asql + " CHR_USRPWD =(ENCODE(?,'9865043008')), DAT_LASTPASSWORDCHANGE = NOW() ";
						asql = asql + " WHERE CHR_USRNAME=?";
						apstm = con.prepareStatement(asql);
						apstm.setString(1,user);
						apstm.setString(2,defaultpass);
						apstm.setString(3,empids[u].substring(10,16));
						apstm.execute();
						apstm.close();
					}	
				}
				con.close();    
				response.sendRedirect("Smart Attendance/AttendanceMain.jsp");
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