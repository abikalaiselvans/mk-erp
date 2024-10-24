package com.my.org.erp.SmartTraining;

import java.io.IOException;
 
 
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

 
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
 
 
public class TestTypeQuestionActionHandler extends AbstractActionHandler 
{
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String user  = (String) session.getAttribute("USRID");
			if (action.equals("TRATestTypeQuestionDelete")) 
			{
				String ids[] = request.getParameterValues("id");
				asql = "DELETE FROM internal_training_m_traningdetails WHERE INT_ROWID=?  ";
				apstm = con.prepareStatement(asql);
				for (int i = 0; i < ids.length; i++) 
				{
					apstm.setString(1,ids[i]);
					apstm.addBatch();
					
				}
				apstm.executeBatch();
				con.close();  
				response.sendRedirect("Smart Training/TestTypeQuestion.jsp");
			}
			else if ( "TRATestTypeQuestionADD".equals(action) ) 
			{
				String type=request.getParameter("type");
				String question= request.getParameter("question");
				String answer1= request.getParameter("answer1");
				String answer2= request.getParameter("answer2");
				String answer3= request.getParameter("answer3");
				String answer4= request.getParameter("answer4");
				String Correct[]=  request.getParameterValues("Correct");
				
				String s="";
				for(int u=0;u<Correct.length;u++)
					s=s+Correct[u]+",";
				s = s.trim();
				s = s.substring(0,s.length()-1);
				
				acs = con.prepareCall("{call  TRA_PRO_TESTTYPEQUESTION(?,?,?,?,?,?,?,?,?,? )}");
				acs.setString(1, "INSERT");
				acs.setString(2, " ");
				acs.setString(3, type);
				acs.setString(4,  question);
				acs.setString(5,  answer1);
				acs.setString(6,  answer2);
				acs.setString(7,  answer3);
				acs.setString(8,  answer4);
				acs.setString(9,  s);
				acs.setString(10, user);
				System.out.println(""+acs);
				acs.execute();
				acs.close();
				con.close();   
				response.sendRedirect("Smart Training/TestTypeQuestion.jsp");
			} 
			else if (action.equals("TRATestTypeQuestionEdit")) 
			{
				String id=request.getParameter("id");
				String type=request.getParameter("type");
				String question= request.getParameter("question");
				String answer1= request.getParameter("answer1");
				String answer2= request.getParameter("answer2");
				String answer3= request.getParameter("answer3");
				String answer4= request.getParameter("answer4");
				String Correct[]=  request.getParameterValues("Correct");
				String s="";
				for(int u=0;u<Correct.length;u++)
					s=s+Correct[u]+",";
				s = s.trim();
				s = s.substring(0,s.length()-1);
				acs = con.prepareCall("{call  TRA_PRO_TESTTYPEQUESTION(?,?,?,?,?,?,?,?,?,? )}");
				acs.setString(1, "UPDATE");
				acs.setString(2, id);
				acs.setString(3, type);
				acs.setString(4,  question);
				acs.setString(5,  answer1);
				acs.setString(6,  answer2);
				acs.setString(7,  answer3);
				acs.setString(8,  answer4);
				acs.setString(9,  s);
				acs.setString(10, user);
				acs.execute();
				response.sendRedirect("Smart Training/TestTypeQuestion.jsp");
				acs.close();
				 
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
