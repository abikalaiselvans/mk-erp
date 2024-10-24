package com.my.org.erp.SmartHRM;

import java.io.IOException;
 
 
 
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

 
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
 
 
 

public class OnlineTestActionHandler extends AbstractActionHandler 
{
 	String userid=null;
 	public synchronized void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session=request.getSession();			
			userid=""+session.getAttribute("USRID");
			if (action.equals("HRMOnlineTestApply")) 
			{
				String rowids[] = request.getParameterValues("rowid");
				String passpercent[] = request.getParameterValues("passpercent");
				String applicantid = request.getParameter("applicantid");
				boolean f = com.my.org.erp.common.CommonFunction.RecordExist("SELECT COUNT(*) FROM hrm_t_testquestion WHERE INT_APPID="+applicantid);
				
				 
				if (!f) 
				{
					int correctanswercount = 0;
					acs = con
							.prepareCall("{call HRM_PRO_ONLINETEST (?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					String s = "";
					for (int i = 0; i < rowids.length; i++) {
						String correctanswer = com.my.org.erp.common.CommonFunctions
								.QueryExecute("SELECT CHR_ACTUAL_ANSWER FROM hrm_m_testquestion WHERE INT_EQUESTIONID="
										+ rowids[i])[0][0];
						String ans1 = ""
								+ request.getParameter("Ans_" + rowids[i]);
						String ans2 = ""
								+ request.getParameter("Ans_" + rowids[i]);
						String ans3 = ""
								+ request.getParameter("Ans_" + rowids[i]);
						String ans4 = ""
								+ request.getParameter("Ans_" + rowids[i]);
						s = "";
						if (!ans1.equals("null"))
							s = ans1 + ",";
						if (!ans2.equals("null"))
							s = ans2 + ",";
						if (!ans3.equals("null"))
							s = ans3 + ",";
						if (!ans4.equals("null"))
							s = ans4 + ",";
						if (s.equals(correctanswer))
							correctanswercount = correctanswercount + 1;
						acs.setString(1, "INSERT");
						acs.setString(2, "");
						acs.setString(3, applicantid);
						acs.setString(4, rowids[i]);
						acs.setString(5, "");
						acs.setString(6, "");
						acs.setString(7, "");
						acs.setString(8, "");
						acs.setString(9, correctanswer);
						acs.setString(10, s);
						acs.setString(11, "" + (s.equals(correctanswer)));
						acs.setString(12, passpercent[i]);
						acs.setString(13, userid);
						acs.addBatch();
					}
					// System.out.println(""+cs);
					acs.executeBatch();
					acs.close();
					con.close();   
					response.sendRedirect("Smart HRM/OnlineTestResult.jsp?applicantid="+applicantid);
				}				
				else
				{
					con.close();   
					response.sendRedirect("Smart HRM/error.jsp?error=All Read Online Test Attended..."  );
				}
				
			}
			else if("HRMOnlineTestApplyDelete".equals(action))
			{
				
				String  applicantids[]= request.getParameterValues( "applicantid");
				for(int u=0;u<applicantids.length;u++)
				{
					String sql = " DELETE FROM hrm_t_testquestion WHERE INT_APPID="+applicantids[u]+" ";//AND MONTH(DAT_ATTENDDATE) ="+month+" AND YEAR(DAT_ATTENDDATE)="+year;
					com.my.org.erp.common.CommonFunctions.Execute(sql);
					sql = " UPDATE hrm_m_application  SET CHR_ONLINETESTSTATUS='N',CHR_RESULT='N',DOU_PERCENT=0 WHERE INT_APPID="+applicantids[u];
					com.my.org.erp.common.CommonFunctions.Execute(sql);
				}
				con.close();   
				response.sendRedirect("Smart HRM/OnlineTestResultView.jsp");
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
