package com.my.org.erp.SmartUtility;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
public class MailSettingActionHandler extends AbstractActionHandler 
{
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			if (action.equals("UTIMail")) 
			{	
				String ids[] = request.getParameterValues("ename");
				String desc = request.getParameter("desc");
				String subject = request.getParameter("subject");
				String sql = "";
				String mailid="";
				for(int u=0;u<ids.length;u++)
				{
					sql="SELECT CHR_EMAILID FROM com_m_staff WHERE CHR_EMPID='"+ids[u]+"' AND CHR_EMAILID is not null ";
					String  data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
					mailid= data[0][0];
					com.my.org.erp.mail.Mail.SimpleMail( mailid, subject, desc);
				}
				con.close();   
				response.sendRedirect("Utility/Userframe.jsp"); 
			}
			else if (action.equals("UTIMailSettingAdd")) 
			{	
				String group = request.getParameter("group");
				String fromdt = request.getParameter("fromdt");
				String email = request.getParameter("email");
				String dt[] = fromdt.split(" ");
				
				@SuppressWarnings("unused")
				String sql = "";
				com.my.org.erp.common.CommonFunctions.Execute("DELETE FROM email_m_setting");
				sql = "INSERT INTO email_m_setting (INT_GROUPID,DAT_DATE,CHR_EMAILID) VALUES ("+group+",'"+DateUtil.FormateDateSQL(dt[0])+" "+dt[1]+"','"+email+"')";
				con.close();   
				response.sendRedirect("Utility/Userframe.jsp"); 
			}
			else if (action.equals("UTIMailConfigurationAdd")) 
			{	
				String technicalheader = request.getParameter("technicalheader");
				String technicalfooter = request.getParameter("technicalfooter");
				String productheader = request.getParameter("productheader");
				String productfooter = request.getParameter("productfooter");
				String sql = "";
				sql = "UPDATE  email_m_emailconfiguration CHR_TECHHEADER='"+technicalheader+"'," +
						"CHR_TECHFOOTER='"+technicalfooter+"',CHR_PRODUCTHEADER ='"+productheader+"'," +
								"CHR_PRODUCTFOOTER ='"+productfooter+"' WHERE INT_ID=1";
				com.my.org.erp.common.CommonFunctions.Execute(sql);
				con.close();   
				response.sendRedirect("Utility/Userframe.jsp"); 
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
