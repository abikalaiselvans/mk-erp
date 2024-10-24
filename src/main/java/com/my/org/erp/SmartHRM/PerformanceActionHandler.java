package com.my.org.erp.SmartHRM;
import java.io.IOException;
 
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class PerformanceActionHandler extends AbstractActionHandler{
	String categoryName,categoryDes;
	int categoryId;
	
	private void hrmDelete(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException{
		try{
			
			System.out.println("Welcome to the Delete Page");
			
			String []appid=request.getParameterValues("appId");		

			
			System.out.println("length : "+ appid.length);	
			Statement st= con.createStatement();
			
			for(int i=0;i<appid.length;i++){
				

				String query = "DELETE from hrm_t_jobperformance where INT_APPID='"+appid[i]+"'";
				st.executeUpdate(query);
				
			}
		
		}
		catch(Exception e){
			 request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
						
			 System.out.println(e.getMessage());
		}
	}
	
	
	private void hrmAdd(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{			
			HttpSession session=request.getSession();			
			String userId=""+session.getAttribute("USRID");			
			String appId = request.getParameter("TxtAppId").trim();
			String TxtTest=request.getParameter("TxtTest").trim();
			String TxtInterview=request.getParameter("TxtInterview").trim();
			String TxtMedical=request.getParameter("TxtMedical").trim();
			String TxtReference=request.getParameter("TxtReference").trim();
			String TxtGD=request.getParameter("TxtGD").trim();
			java.text.SimpleDateFormat datetime = new java.text.SimpleDateFormat("yyyy-MM-dd");
			java.util.Date date = new java.util.Date();
			String updatedate = "" + datetime.format(date);
			String stat="";
			int nowtot = Integer.parseInt(TxtTest)+Integer.parseInt(TxtInterview)+Integer.parseInt(TxtMedical)+Integer.parseInt(TxtReference)+Integer.parseInt(TxtGD);
			String sql1	= "select INT_JOBID from hrm_m_application where INT_APPID="+appId;
			String Datas1[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql1);
			
			String sql2 = "select INT_TEST, INT_INTERVIEW, INT_MEDICAL, INT_REFERENCE, INT_GD from  hrm_m_jobperformance where INT_JOBID="+Datas1[0][0];
			String Datas2[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql2);
			
			int passtot = Integer.parseInt(Datas2[0][0]) + Integer.parseInt(Datas2[0][1]);
			passtot = passtot + Integer.parseInt(Datas2[0][2]) + Integer.parseInt(Datas2[0][3]);
			passtot = passtot + Integer.parseInt(Datas2[0][4]);
			
			if (nowtot>=passtot)
				stat = "Q";	
			else
				stat = "N";

			
			Statement st = con.createStatement();
			String query = "INSERT INTO hrm_t_jobperformance ";
			query = query + "(INT_APPID, INT_TEST, INT_INTERVIEW, INT_MEDICAL, INT_REFERENCE, INT_GD, CHR_APPLICATIONSTATUS, CHR_USRNAME, DT_UPDATEDATE, CHR_UPDATESTATUS) values (";
			query = query + appId + ", ";
			query = query + TxtTest + ", ";
			query = query + TxtInterview +", ";
			query = query + TxtMedical +", ";			
			query = query + TxtReference +", ";
			query = query + TxtGD +", ";			
			query = query + "'"+stat+"', ";
			query = query + "'"+userId+"', ";
			query = query + "'"+ updatedate +"', ";
			query = query + "'Y')";
 			st.executeUpdate(query);										
		}
		catch(Exception e){
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
			
		}
	}
	private void hrmEdit(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException{
		try{	
			
			HttpSession session=request.getSession();			
			String userId=""+session.getAttribute("USRID");			
			
			String appId = request.getParameter("TxtAppId").trim();
			int intappid = Integer.parseInt(appId);
			String TxtTest=request.getParameter("TxtTest").trim();
			String TxtInterview=request.getParameter("TxtInterview").trim();
			String TxtMedical=request.getParameter("TxtMedical").trim();
			String TxtReference=request.getParameter("TxtReference").trim();
			String TxtGD=request.getParameter("TxtGD").trim();
			
			java.text.SimpleDateFormat datetime = new java.text.SimpleDateFormat("yyyy-MM-dd");
			java.util.Date date = new java.util.Date();
			String updatedate = "" + datetime.format(date);
			
//-------------Calculating the Marks----------- 

			int nowtot = Integer.parseInt(TxtTest)+Integer.parseInt(TxtInterview)+Integer.parseInt(TxtMedical)+Integer.parseInt(TxtReference)+Integer.parseInt(TxtGD);
			
			String sql1	= "select INT_JOBID from hrm_m_application where INT_APPID="+appId;
			String Datas1[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql1);

			System.out.println(sql1);
			System.out.println ("JOB ID : "+ Datas1[0][0]);
						
			String sql2 = "select INT_TEST, INT_INTERVIEW, INT_MEDICAL, INT_REFERENCE, INT_GD from  hrm_m_jobperformance where INT_JOBID="+Datas1[0][0];
			String Datas2[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql2);
						
			System.out.println(sql2);
			System.out.println(Datas2.length);
						
			int passtot = Integer.parseInt(Datas2[0][0]) + Integer.parseInt(Datas2[0][1]);
			passtot = passtot + Integer.parseInt(Datas2[0][2]) + Integer.parseInt(Datas2[0][3]);
			passtot = passtot + Integer.parseInt(Datas2[0][4]);

			System.out.println("\nNow Total : "+nowtot+"\nPass Total : "+passtot);
			String stat = "";						
						
						if (nowtot>=passtot)
							stat = "Q";	
						else
							stat = "N";

//-----------------------------
			
				String query = "UPDATE hrm_t_jobperformance SET ";
						
				query = query + "INT_TEST = "+TxtTest+", ";
				query = query + "INT_INTERVIEW = "+TxtInterview+", ";
				query = query + "INT_MEDICAL = "+TxtMedical+", ";
				query = query + "INT_REFERENCE = "+TxtReference+", ";
				query = query + "INT_GD= "+TxtGD+", ";
				
				
				//-------- Change the Status after checking with the table value if it is more than the marks then OK else NOT OK
				

				query = query + "CHR_APPLICATIONSTATUS = '"+stat+"', ";
				query = query + "CHR_USRNAME = '"+userId+"', ";
				query = query + "DT_UPDATEDATE = '"+updatedate+"', ";
				query = query + "CHR_UPDATESTATUS='Y' ";
				query = query + "WHERE INT_APPID = "+intappid ;
				
				Statement st = con.createStatement();
				System.out.println(query);	
				st.executeUpdate(query);
				
				
		}
		
		catch(Exception e){
			 request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
						
			 System.out.println(e.getMessage());
		}
	}
	
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try
		{
				String action=request.getParameter("actionS");
				if(action.equals("HRMPerformanceAdd"))
				{					
					hrmAdd(request, response);	
					con.close();   
					response.sendRedirect("Smart HRM/PerformanceView.jsp");
				}
				else if(action.equals("HRMPerformanceDelete"))
				{
					hrmDelete(request, response);
					con.close();   
					response.sendRedirect("Smart HRM/PerformanceView.jsp");
				}
				else if(action.equals("HRMPerformanceEdit"))
				{
					hrmEdit(request, response);
					con.close();   
					response.sendRedirect("Smart HRM/PerformanceView.jsp");
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

