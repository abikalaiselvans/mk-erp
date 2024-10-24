package com.my.org.erp.SmartStaff;

import java.io.IOException; 
 
 
 
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

 
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.common.CommonFunction;
import com.my.org.erp.common.CommonFunctions;
 
 
 

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
			 
			if (action.equals("STAOnlineTestApply")) 
			{
				String rowids[] = request.getParameterValues("rowid");
				String passpercent[] = request.getParameterValues("passpercent");
				String applicantid = request.getParameter("applicantid");
				String testid = request.getParameter("testid");
				
				String data[][] = CommonFunctions.QueryExecute("SELECT INT_NO_OF_QUESTION,INT_DURATION,INT_PECENTAGE FROM internal_training_m_testtype WHERE INT_TESTTYPEID ="+testid);
				
				asql = " ";
				asql = " insert into internal_training_t_backup_testemployeelist "; 
				asql = asql + " SELECT * FROM internal_training_t_testemployeelist ";
				asql = asql + " WHERE INT_TESTTYPEID = "+testid; 
				asql = asql + " AND CHR_EMPID = '"+applicantid +"' ";
				asql = asql + " AND CHR_RESULT !='P'";
				apstm = con.prepareStatement(asql);
				apstm.execute();
				apstm.close();
				
				asql = " ";
				asql = " DELETE  FROM internal_training_t_testemployeelist ";
				asql = asql + " WHERE INT_TESTTYPEID = "+testid; 
				asql = asql + " AND CHR_EMPID = '"+applicantid +"' ";
				asql = asql + " AND CHR_RESULT !='P'";
				apstm = con.prepareStatement(asql);
				apstm.execute();
				apstm.close();
				
				
				
				asql = " ";
				asql = " insert into internal_training_t_backup_testquestion "; 
				asql = asql + " SELECT * FROM internal_training_t_testquestion ";
				asql = asql + " WHERE INT_TESTTYPEID = "+testid; 
				asql = asql + " AND CHR_EMPID = '"+applicantid +"' ";
				apstm = con.prepareStatement(asql);
				apstm.execute();
				apstm.close();
				
				asql = " ";
				asql = " DELETE  FROM internal_training_t_testquestion ";
				asql = asql + " WHERE INT_TESTTYPEID = "+testid; 
				asql = asql + " AND CHR_EMPID = '"+applicantid +"' ";
				apstm = con.prepareStatement(asql);
				apstm.execute();
				apstm.close();
				
				int noofattempt =0;
				asql = " ";
				asql = " SELECT * FROM internal_training_t_backup_testemployeelist ";
				asql = asql + " WHERE INT_TESTTYPEID = "+testid; 
				asql = asql + " AND CHR_EMPID = '"+applicantid +"' ";
				 
				if(CommonFunctions.QueryExecute(asql).length>0)
					noofattempt = Integer.parseInt(CommonFunctions.QueryExecute(asql)[0][0])+1;
				else
					noofattempt=1;
								
				
				boolean f = CommonFunction.RecordExist("SELECT COUNT(*) FROM internal_training_m_testquestion WHERE CHR_EMPID= '"+applicantid +"' AND INT_TESTTYPEID ="+testid);
				if (!f) 
				{
					int correctanswercount = 0;
					acs = con.prepareCall("{call TRA_PRO_ONLINETEST (?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					String s = "";
					for (int i = 0; i < rowids.length; i++) 
					{
						String correctanswer = CommonFunctions.QueryExecute("SELECT CHR_ACTUAL_ANSWER FROM internal_training_m_testquestion WHERE INT_ROWID="+ rowids[i])[0][0];
						correctanswer = correctanswer+",";
						String ans1 = ""+ request.getParameter("Ans_" + rowids[i]);
						String ans2 = ""+ request.getParameter("Ans_" + rowids[i]);
						String ans3 = ""+ request.getParameter("Ans_" + rowids[i]);
						String ans4 = ""+ request.getParameter("Ans_" + rowids[i]);
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
						System.out.println(""+acs);
						acs.addBatch();
					}
					System.out.println(""+acs);
					acs.executeBatch();
					acs.close();
					
					asql = "";
					asql = "INSERT INTO internal_training_t_testemployeelist ";
					asql = asql + " (INT_TESTTYPEID,CHR_EMPID,";
					asql = asql + " INT_NO_OF_QUESTION,INT_DURATION,INT_PECENTAGE,DAT_WRITTEN, ";
					asql = asql + " CHR_ONLINETESTSTATUS,INT_NOOF_ATTEMPT,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS) "; 
					asql = asql + " VALUES(?,?,?,?,?,NOW(),'Y',? ,? ,DATE(NOW()),'y' );";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,testid );
					apstm.setString(2,applicantid );
					apstm.setString(3,data[0][0]);
					apstm.setString(4,data[0][1]);
					apstm.setString(5,data[0][2]);
					apstm.setString(6,""+noofattempt );
					apstm.setString(7,userid );
					apstm.execute();
					apstm.close();
					con.close();   
					
					
					response.sendRedirect("Staff/OnlineTestResult.jsp?applicantid="+applicantid+"&testid="+testid);
				}				
				else
				{
					con.close();   
					response.sendRedirect("Staff/error.jsp?error=All Read Online Test Attended..."  );
				}
				
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
