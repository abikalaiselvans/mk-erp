package com.my.org.erp.SmartHRM;

import java.io.IOException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class BenefitsActionHandler extends AbstractActionHandler{

	
	private void benefitsAdd(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException{
		try{			
		HttpSession session=request.getSession();			
		String userId=""+session.getAttribute("USRID");	
		
		java.text.SimpleDateFormat datetime = new java.text.SimpleDateFormat("yyyy-MM-dd");
		java.util.Date date = new java.util.Date();
		String updatedate = "" + datetime.format(date);
		String TxtName=request.getParameter("TxtName").trim();
		String TxtMission=request.getParameter("TxtMission").trim();
		String TxtObjective=request.getParameter("TxtObjective").trim();
		String TxtWork=request.getParameter("TxtWork").trim();
		String TxtPaid=request.getParameter("TxtPaid").trim();
		String Benefits[]=null;
		Benefits=request.getParameterValues("Benefits");
		String s="";
		for(int i=0;i<Benefits.length;i++)
		{
			s=s+Benefits[i]+"~";
		}
		
		Statement st = con.createStatement();
		String sql="DELETE FROM hrm_m_mission";
		st.executeUpdate(sql);
		
		
		String Query= "INSERT INTO hrm_m_mission VALUES (";
		Query = Query + " '" + TxtName + "' ,";			
		Query = Query + " '" + TxtMission + "' ,";
		Query = Query + " '" + TxtObjective + "' ,";			
		Query = Query + " '" + TxtWork + "' ,";		
		Query = Query + " '" + TxtPaid + "' ,";
		Query = Query + " '" + s + "' ,";					
		Query = Query + " '" + userId + "' ,";
		Query = Query + " '" + updatedate + "' ,";
		Query = Query + " '" + "Y" + "' )";
		
		st = con.createStatement();
		st.executeUpdate(Query);
			
											
		}
		catch(Exception e){
			 request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
						
			 System.out.println(e.getMessage());
		}
	}
	
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try
		{
				String action=request.getParameter("actionS");						
				if(action.equals("HRMbenefitsAdd"))
				{					
					benefitsAdd(request, response);		
					con.close();   
					response.sendRedirect("Smart HRM/Benefits.jsp");
				}
				
		} 
		catch (Exception e) 
		{
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
		    System.out.println(e.getMessage());
		}
	}
	
}

