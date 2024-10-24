package com.my.org.erp.SmartAttendance;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.bean.Attendance.Attinfo;
import com.my.org.erp.common.CommonFunctions;

public class StaffOnDutyActionHandler extends AbstractActionHandler 
{
	Statement st;
	ResultSet rs;
	java.text.SimpleDateFormat datetime = new java.text.SimpleDateFormat("yyyy-MM-dd");
	java.util.Date date = new java.util.Date();
	String updatedate = "" + datetime.format(date);
	@SuppressWarnings("deprecation")
	String year = "" + (1900 + date.getYear());
	boolean redirectflag = false;
	String redirecterror="";
	String sql;
	boolean flag = false;
	String error="";
	
	ArrayList<Attinfo> attinfo = new ArrayList<Attinfo>();
	
	



public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
{
		try 
		{
			
			String action = request.getParameter("actionS");
			
			javax.servlet.http.HttpSession session=request.getSession();
			session.removeAttribute("attinfo"); 
			System.out.println("CONTROLLER FROM ONDUTY ACTION HANDLER  : "+action);
			if (action.equals("ATTOnDutyAdd")) 
			{
				OnDutyAdd(request, response);
				con.close();   
				response.sendRedirect("Smart Attendance/OnDuty.jsp");
			}
			else if (action.equals("ATTOnDutyUpdate")) 
			{
				OnDutyUpdate(request, response);
				con.close();    
				response.sendRedirect("Smart Attendance/OnDuty.jsp");
			}
			else if (action.equals("ATTOnDutyDeletes")) 
			{
				OnDutyDeletes(request, response);
				con.close();    
				response.sendRedirect("Smart Attendance/OnDuty.jsp");
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





private void OnDutyAdd(	HttpServletRequest request,	HttpServletResponse response)throws ServletException, IOException 
{
		try 
		{
			HttpSession session = request.getSession();
			String userId = (String) session.getAttribute("USRID");
			String staffid[] = request.getParameterValues("ename");
			String fdate = request.getParameter("fromdt");
			String dat[] = fdate.split("-");
			String day = ""+Integer.parseInt(dat[0]);
			String umonth=DateUtil.getMonth(Integer.parseInt(dat[1]));
			String uyear = dat[2];
			 
			fdate =DateUtil.FormateDateSQL(fdate);
			double dayvalue=0.0;
			String daytype = request.getParameter("ComboDay");
			String TxtPlace = request.getParameter("TxtPlace");
			String TxtReason = request.getParameter("TxtReason");
			String TxtAuthorised = request.getParameter("TxtAuthorised");
			
			String  updatequery1= " ";
			
			if("Full Day".equals(daytype))
			{
				dayvalue=1.0;
				updatequery1 =updatequery1 + " AND CHR_MORNING"+day+"   NOT IN ('LEA','ABS')  AND CHR_EVENING"+day+"   NOT IN ('LEA','ABS')" ;
			}
			else if("Forenoon".equals(daytype))
			{
				dayvalue=0.5;
				updatequery1 =updatequery1 + " AND CHR_MORNING"+day+"   NOT IN ('LEA','ABS')  " ;
			}
			else if("Afternoon".equals(daytype))
			{
				dayvalue=0.5;
				updatequery1 =updatequery1 + "    AND CHR_EVENING"+day+"   NOT IN ('LEA','ABS')" ;
			}
			
			
			String updatequery="UPDATE att_t_register SET ";
			 
			if("Full Day".equals(daytype))
				updatequery=updatequery+" CHR_MORNING"+day+" = 'OND' ,  CHR_EVENING"+day+" = 'OND', ";
			else if("Forenoon".equals(daytype))
				updatequery=updatequery+" CHR_MORNING"+day+" = 'OND' , ";
			else if("Afternoon".equals(daytype))
				updatequery=updatequery+" CHR_EVENING"+day+" = 'OND' , ";
					
			
			updatequery=updatequery.trim();
			updatequery = updatequery.substring(0,updatequery.length()-1);
			sql=updatequery+" WHERE CHR_EMPID=? AND CHR_MONTH=? AND INT_YEAR=? "+updatequery1;
			
		 
			
			PreparedStatement pstm = con.prepareStatement(sql);
			CallableStatement cs = con.prepareCall("{call ATT_PRO_ONDUTY(?,?,?,?,?,?,?,?,?,? )}");
			
			for (int u = 0; u < staffid.length; u++) 
			{
				pstm.setString(1, staffid[u]);
				pstm.setString(2, umonth);
				pstm.setString(3, uyear);	
				pstm.addBatch();
				
				cs.setString(1, "INSERT");
				cs.setString(2, "");
				cs.setString(3, staffid[u]);
				cs.setString(4, fdate);
				cs.setString(5, daytype);
				cs.setString(6, ""+dayvalue);
				cs.setString(7, TxtPlace);
				cs.setString(8, TxtReason);
				cs.setString(9, TxtAuthorised);
				cs.setString(10, userId);
				cs.addBatch();
			}
			cs.executeBatch();
			pstm.executeBatch();
			pstm.close();
			cs.close();
			 
		}
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}	
	}






private void OnDutyUpdate(	HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
{
	try 
	{

		HttpSession session = request.getSession();
		String userid = (String) session.getAttribute("USRID");
		String rowid = request.getParameter("rowid");
		String fromdt = request.getParameter("fromdt");
		fromdt= DateUtil.FormateDateSQL(fromdt);
		String ComboDay = request.getParameter("ComboDay");
		String TxtPlace = request.getParameter("TxtPlace");
		String TxtReason = request.getParameter("TxtReason");
		String TxtAuthorised = request.getParameter("TxtAuthorised");
		
		double dayvalue=0.0;
		if("Full Day".equals(ComboDay))
			dayvalue=1.0;
		else
			dayvalue=0.5;
		
		sql = " SELECT a.INT_ONDUTYID ,a.CHR_TYPE, DATE_FORMAT(a.DT_ODDATE,'%d-%m-%Y') ,MONTHNAME(a.DT_ODDATE) ,YEAR( a.DT_ODDATE),DAY( a.DT_ODDATE),a.CHR_EMPID FROM att_t_onduty a,com_m_staff b,com_m_office c WHERE a.CHR_EMPID= b.CHR_EMPID  AND b.INT_OFFICEID =c.INT_OFFICEID and a.INT_ONDUTYID="+rowid;
		String readData[][] = CommonFunctions.QueryExecute(sql);
		
		String updatequery1="";
		String updatequery=" UPDATE att_t_register SET  ";
		if("Full Day".equals(readData[0][1]))
		{	
		 	updatequery=updatequery+" CHR_MORNING"+readData[0][5]+" = null ,  CHR_EVENING"+readData[0][5]+" = null, ";
		 	updatequery1 = updatequery1 + " AND CHR_MORNING"+readData[0][5]+"  IN ('OND') AND CHR_EVENING"+readData[0][5]+"  IN ('OND') ";
		} 	
		else if("Forenoon".equals(readData[0][1]))
		{
			updatequery=updatequery+" CHR_MORNING"+readData[0][5]+" = null , ";
			updatequery1 = updatequery1 + " AND CHR_MORNING"+readData[0][5]+"  IN ('OND') ";
		}
		else if("Afternoon".equals(readData[0][1]))
		{	
			updatequery=updatequery+" CHR_EVENING"+readData[0][5]+" = null , ";
			updatequery1 = updatequery1 + " AND CHR_EVENING"+readData[0][5]+"  IN ('OND') ";
		}	
		 updatequery=updatequery.trim();
		 updatequery = updatequery.substring(0,updatequery.length()-1);
		 updatequery = updatequery+" WHERE CHR_EMPID='"+readData[0][6]+"' AND CHR_MONTH='"+readData[0][3]+"' AND INT_YEAR="+readData[0][4]+updatequery1;
		 System.out.println("----"+updatequery);
		 st= con.createStatement();
		 st.executeUpdate(updatequery);
		 
		 
		 CallableStatement cs = con.prepareCall("{call ATT_PRO_ONDUTY(?,?,?,?,?,?,?,?,?,? )}");
		 cs.setString(1, "UPDATE");
		 cs.setString(2,  rowid); 
		 cs.setString(3,  readData[0][6]); 
		 cs.setString(4, fromdt ); 
		 cs.setString(5,  ComboDay); 
		 cs.setString(6, ""+dayvalue );
		 cs.setString(7, TxtPlace);
		 cs.setString(8, TxtReason);
		 cs.setString(9, TxtAuthorised);
		 cs.setString(10,  userid); 
		  
		 cs.execute();
		 cs.close();
		 
		  
			
		 updatequery1="";
		 updatequery=" UPDATE att_t_register SET  ";
		 if("Full Day".equals(ComboDay))
		 {	 
		 	updatequery=updatequery+" CHR_MORNING"+readData[0][5]+" = 'OND'  ,  CHR_EVENING"+readData[0][5]+" = 'OND' , ";
		 	updatequery1 = updatequery1 + " AND CHR_MORNING"+readData[0][5]+" NOT IN ('LEA','HOL','ABS') AND CHR_EVENING"+readData[0][5]+"  IN ('LEA','HOL','ABS') ";
			
		 }	
		 else if("Forenoon".equals(ComboDay))
		 { 
			updatequery=updatequery+" CHR_MORNING"+readData[0][5]+" = 'OND' , ";
			updatequery1 = updatequery1 + " AND CHR_MORNING"+readData[0][5]+" NOT IN ('LEA','HOL','ABS')";
		 }	
		 else if("Afternoon".equals(ComboDay))
		 {
			updatequery=updatequery+" CHR_EVENING"+readData[0][5]+" = 'OND' , ";
			updatequery1 = updatequery1 + "  AND CHR_EVENING"+readData[0][5]+" NOT IN ('LEA','HOL','ABS') ";
		 }	
		 updatequery=updatequery.trim();
		 updatequery = updatequery.substring(0,updatequery.length()-1);
		 updatequery = updatequery+" WHERE CHR_EMPID='"+readData[0][6]+"' AND CHR_MONTH='"+readData[0][3]+"' AND INT_YEAR="+readData[0][4] +updatequery1;
		 System.out.println(updatequery); 
		 st.executeUpdate(updatequery);
		 st.close();
		
	}
	catch (Exception e) 
	{
		System.out.println(e.getMessage());
		request.setAttribute("error", e.getMessage() );
        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    	dispatchers.forward(request, response); 

	}	
}



private void OnDutyDeletes(	HttpServletRequest request,  HttpServletResponse response) 	throws ServletException, IOException 
{
	try 
	{
		String rowid[] = request.getParameterValues("rowid");
		String updatequery="  ";
		CallableStatement cs = con.prepareCall("{call ATT_PRO_ONDUTY(?,?,?,?,?,?,?,?,?,? )}");
		st = con.createStatement();
		for(int u=0; u<rowid.length;u++)
		{
			
			 sql ="SELECT CHR_EMPID,MONTHNAME(DT_ODDATE),YEAR(DT_ODDATE),CHR_TYPE,DAY(DT_ODDATE) FROM att_t_onduty WHERE INT_ONDUTYID="+rowid[u];
			 String readData[][] =  CommonFunctions.QueryExecute(sql);
			  
			 updatequery=" UPDATE att_t_register SET  ";
			String  updatequery1 ="";
			 if("Full Day".equals(readData[0][3]))
			 {	 
			 	updatequery=updatequery+" CHR_MORNING"+readData[0][4]+" = null ,  CHR_EVENING"+readData[0][4]+" = null, ";
			 	updatequery1 = updatequery1 + " AND CHR_MORNING"+readData[0][4]+"  IN ('OND') AND CHR_EVENING"+readData[0][4]+"  IN ('OND') ";
				
			 }
			 else if("Forenoon".equals(readData[0][3]))
			 {
				updatequery=updatequery+" CHR_MORNING"+readData[0][4]+" = null , ";
				updatequery1 = updatequery1 + " AND CHR_MORNING"+readData[0][4]+"  IN ('OND') ";;
			 }
			 else if("Afternoon".equals(readData[0][3]))
			 {
				 updatequery1 = updatequery1 + "   AND CHR_EVENING"+readData[0][4]+"  IN ('OND') ";
			 }
			 updatequery=updatequery.trim();
			 updatequery = updatequery.substring(0,updatequery.length()-1);
			 updatequery = updatequery+" WHERE CHR_EMPID='"+readData[0][0]+"' AND CHR_MONTH='"+readData[0][1]+"' AND INT_YEAR="+readData[0][2]+updatequery1;
			 System.out.println(updatequery); 
			 st.executeUpdate(updatequery);
			 
			cs.setString(1, "DELETE");
			cs.setString(2, rowid[u]);
			cs.setString(3, null);
			cs.setString(4, null);
			cs.setString(5, null);
			cs.setString(6, null );
			cs.setString(7, null);
			cs.setString(8, null);
			cs.setString(9, null);
			cs.setString(10, null);
			System.out.println(""+cs);  
			cs.addBatch(); 
			
		}
		 
		cs.executeBatch();
		st.close();
		cs.close();
		 
	  
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
