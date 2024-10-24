package com.my.org.erp.SmartTraining;

import java.io.IOException;
 
 
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

 
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
 
 
public class TestTypeActionHandler extends AbstractActionHandler 
{
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String user  = (String) session.getAttribute("USRID");
			System.out.println("========="+action);
			if (action.equals("TRATestTypeDelete")) 
			{
				String ids[] = request.getParameterValues("id");
				asql = "DELETE FROM internal_training_m_testtype WHERE INT_TESTTYPEID=? ";
				apstm = con.prepareStatement(asql);
				for (int i = 0; i < ids.length; i++) 
				{
					apstm.setString(1,ids[i]);
					apstm.addBatch();
					
				}
				apstm.executeBatch();
				con.close();   
				response.sendRedirect("Smart Training/TestType.jsp");
			}
			else if ( "TRATestTypeAdd".equals(action) ) 
			{
				String name=request.getParameter("Name");
				String noofquetion=request.getParameter("noofquetion");
				String duration=request.getParameter("duration");
				String percentage=request.getParameter("percentage");
				//duration,percentage
				String desc=request.getParameter("desc");
				name=name.trim();
				asql = "";
				asql = " INSERT INTO internal_training_m_testtype ";  
				asql = asql + "(CHR_TESTNAME,INT_NO_OF_QUESTION,INT_DURATION,INT_PECENTAGE,CHR_DESC,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS) "; 
				asql = asql + " VALUES  (?,?,?,?,?,?,DATE(NOW()),'Y') ";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,name);
				apstm.setString(2,noofquetion);
				apstm.setString(3,duration);
				apstm.setString(4,percentage);
				apstm.setString(5,desc);
				apstm.setString(6,user);
				apstm.execute(); 
				apstm.close();
				con.close();   
				response.sendRedirect("Smart Training/TestType.jsp");
			} 
			else if (action.equals("TRATestTypeEdit")) 
			{
				String id=request.getParameter("id");
				String name=request.getParameter("Name");
				String desc=request.getParameter("desc");
				String noofquetion=request.getParameter("noofquetion");
				String duration=request.getParameter("duration");
				String percentage=request.getParameter("percentage");
				name=name.trim();
				asql="";
				asql = asql + " UPDATE internal_training_m_testtype SET CHR_TESTNAME =?,INT_NO_OF_QUESTION=?,INT_DURATION=?,INT_PECENTAGE=?,CHR_DESC=?,";
				asql = asql + " CHR_USRNAME=?,DT_UPDATEDATE=DATE(NOW()),CHR_UPDATESTATUS='Y'";
				asql = asql + " where  INT_TESTTYPEID =?";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,name);
				apstm.setString(2,noofquetion);
				apstm.setString(3,duration);
				apstm.setString(4,percentage);
				apstm.setString(5,desc);
				apstm.setString(6,user);
				apstm.setString(7,id);
				apstm.execute(); 
				apstm.close();
				con.close();   
				response.sendRedirect("Smart Training/TestType.jsp");
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
