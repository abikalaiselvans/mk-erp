package com.my.org.erp.SmartHRM;

import java.io.IOException;
 
import java.sql.Statement;

import java.util.Map;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;
 

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.SmartMailtemplates.Mail;
import com.my.org.erp.bean.Home.EmployeeVerification;
import com.my.org.erp.common.CommonFunctions;
import com.my.org.erp.setting.CommonData;
 

public class EmployeeVerificationActionHandler extends AbstractActionHandler 
{
	Statement st;
	@SuppressWarnings("rawtypes")
	public synchronized void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			String sql = "";
			HttpSession session = request.getSession();
			if (action.equals("HRMEmployeeVerification")  )
			{
				try 
				{
					EmployeeVerification d = new EmployeeVerification();
					Map map=request.getParameterMap();
					BeanUtils.populate(d,map);
					sql = " INSERT INTO com_m_employeeverification ( CHR_NAME,CHR_COMPANYNAME,CHR_ADDRESS,CHR_EMAILID,INT_MOBILE," +
							"INT_PHONE,CHR_VERIFICATIONID,DAT_REQUEST)VALUES (";
					sql = sql +"?,?,?,?,?,?,?,? )";
					apstm=con.prepareStatement(sql);
					apstm.setString(1,  d.getName());
					apstm.setString(2,  d.getCname());
					apstm.setString(3,  d.getAddress());
					apstm.setString(4,  d.getEmailid());
					apstm.setString(5,  ""+d.getMobiles());
					apstm.setString(6,  ""+d.getPhone());
					apstm.setString(7,  d.getEmpid());
					apstm.setString(8, DateUtil.getCurrentDateTime());
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
					if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_MAILALERT from m_hrm_setting WHERE INT_ROWID  =1")[0][0]))
					{
						HRMMailMethod.sendEmployeeVerificationMail(d.getEmpid(),d.getName(),d.getCname(), d.getAddress(),d.getEmailid(),""+d.getMobiles(),""+d.getPhone());
					}
					response.sendRedirect("Employee VerififcationResponse.jsp");
				} 
				catch (RuntimeException e) 
				{
					 request.setAttribute("error", e.getMessage() );
					 RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
					 dispatchers.forward(request, response); 
					 System.out.println(e.getMessage());
				}
				
			} 
			else if (action.equals("HRMEmployeeVerificationResponse")  )
			{
				 
				String salary= ""+request.getParameter("salary");
				String Attendance= ""+request.getParameter("Attendance");
				String description= ""+request.getParameter("description");
				String rowid= ""+request.getParameter("rowid");
				String Status= ""+request.getParameter("Status");
				String authority= ""+request.getParameter("authority");
				
				
				sql = "  UPDATE com_m_employeeverification SET CHR_STATUS=?,DAT_RESPONSE=?,CHR_RESPONSEDBY=?, CHR_ADDITIONINFO=? WHERE  INT_VERIFICATIONID=?";
				apstm=con.prepareStatement(sql);
				apstm.setString(1,  "Y");
				apstm.setString(2,  DateUtil.getCurrentDateTime());
				apstm.setString(3,  ""+ session.getAttribute("EMPID"));
				apstm.setString(4,  description);
				apstm.setString(5,  rowid); 
				apstm.execute();
				apstm.close();
				
				if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_MAILALERT from m_hrm_setting WHERE INT_ROWID  =1")[0][0]))
				{
					HRMMailMethod.sendEmployeeVerificationResponseMail(rowid, description, salary, Attendance, Status, authority, authority);
				}	
				response.sendRedirect("Smart HRM/EmpVerificationView.jsp");
				
			} 
			 
			
			
		} 
		catch (Exception e) 
		{
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}
}