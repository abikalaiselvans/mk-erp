package com.my.org.erp.SmartUtility;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.common.CommonFunctions;

public class PasswordReSetActionHandler extends AbstractActionHandler 
{
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session=request.getSession();			
			String user = session.getAttribute("USRID").toString();
			action = action.trim();
			String datass[][] = CommonFunctions.QueryExecute(" SELECT CHR_PASSWORD FROM m_institution WHERE INT_ID=1");
			String defaultpass=datass[0][0];
			if (action.equals("UTIPasswordReset")) 
			{	
				String userid = request.getParameter("userid");
				String type = request.getParameter("type");
				asql ="UPDATE M_USER SET CHR_USERNAME='"+user+"' ,DT_UPDATEDATE=DATE(NOW()),CHR_UPDATESTATUS='Y',  CHR_USRPWD =(ENCODE('"+defaultpass+"','9865043008')), DAT_LASTPASSWORDCHANGE = NOW() WHERE CHR_USRNAME=?";
				apstm = con.prepareStatement(asql);	
				apstm.setString(1,userid);
				apstm.execute();
				apstm.close();
				con.close();    
				if("U".equals(type))
					response.sendRedirect("Utility/PassView.jsp");
				else
					response.sendRedirect("Utility/Userframe.jsp");
			}
			else if (action.equals("UTICallPasswordReset")) 
			{	
				asql ="UPDATE M_USER SET CHR_USRPWD =(ENCODE('"+defaultpass+"','9865043008')), DAT_LASTPASSWORDCHANGE = NOW()";
				apstm = con.prepareStatement(asql);
				System.out.println(""+apstm);
				apstm.execute();
				apstm.close();
				con.close();    
				response.sendRedirect("Utility/Userframe.jsp");
			}
			if (action.equals("UTIOperationPolicyReset")) 
			{	
				String userid = request.getParameter("userid");
				String type = request.getParameter("type");
				asql ="UPDATE M_USER SET CHR_USERNAME='"+user+"' ,   CHR_LOGINTERMSANDCONDITIONS = 'N'  WHERE CHR_USRNAME=?";
				apstm = con.prepareStatement(asql);	
				apstm.setString(1,userid);
				apstm.execute();
				apstm.close();
				con.close();    
				if("U".equals(type))
					response.sendRedirect("Utility/PassView.jsp");
				else
					response.sendRedirect("Utility/Userframe.jsp");
			}
			if (action.equals("UTIMessageHide")) 
			{	
				String userid = request.getParameter("userid");
				asql ="UPDATE M_USER SET CHR_ALERT_REQUIRED = 'N'  WHERE CHR_USRNAME=?";
				apstm = con.prepareStatement(asql);	
				apstm.setString(1,userid);
				apstm.execute();
				apstm.close();
				con.close();    
				response.sendRedirect("Common/exit.jsp");
				
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
