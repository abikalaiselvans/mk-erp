package com.my.org.erp.SmartPayroll;

import java.io.IOException;


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;
 
public class TemporarysuspensionActionHandler extends AbstractActionHandler 
{
	 
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String userid = (String) session.getAttribute("USRID");
			if("PAYTemporarysuspensionDelete".equals(action))
			{ 
				String rowid = request.getParameter("rowid");
				String empid = CommonFunctions.QueryExecutecon(con, "SELECT CHR_EMPID FROM pay_t_temporarysuspension WHERE INT_ROWID="+rowid)[0][0];
				asql = "DELETE FROM pay_t_temporarysuspension WHERE CHR_STATUS= 'N' AND INT_ROWID=? ";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,request.getParameter("rowid"));
				apstm.execute();
				apstm.close();
				
				asql = "UPDATE  com_m_staff  SET  CHR_E_STATUS='Y' , DT_UPDATEDATE=DATE(NOW()),DAT_RESIGNDATE=null, DAT_PFRESIGNDATE=null WHERE CHR_EMPID =? ";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,empid);
				apstm.execute();
				
				/*String rowid[] = request.getParameterValues("rowid");
				for(int u=0;u<rowid.length;u++)
				{
					apstm = con.prepareStatement(asql);
					apstm.setString(1, rowid[u]);
					apstm.addBatch();
				}	
				apstm.executeBatch();*/
				con.close();
				response.sendRedirect("Smart Payroll/Temporarysuspension.jsp");
			}  
			else if("PAYTemporarysuspensionAdd".equals(action))
			{ 

				String staffid = request.getParameter("ename");
				String month = request.getParameter("Month");
				String year = request.getParameter("Year");
				String description = request.getParameter("description");
				String low = request.getParameter("low");
				String authorisedby = request.getParameter("authorisedby");
				
				//low,authorisedby
				asql= "SELECT COUNT(*)  FROM pay_t_temporarysuspension WHERE   CHR_EMPID='"+staffid+"' AND CHR_MONTH ='"+DateUtil.getMonth(Integer.parseInt(month))+"' AND INT_YEAR="+year;
				if(!CommonFunctions.RecordExist(con, asql) && !("ADMIN".equals(staffid.toUpperCase())))
				{	
					asql = "INSERT INTO pay_t_temporarysuspension (CHR_EMPID,CHR_MONTH,INT_YEAR,CHR_DESC,DAT_LOW,CHR_ENTEREDEDBY,CHR_AUTHORAISEDBY,CHR_USRNAME,DAT_CREATEDATE,DT_UPDATEDATE,CHR_UPDATESTATUS)";
					asql = asql + "VALUES (?,?,?,?,?,?,?,?,NOW(),DATE(NOW()),'Y') ";
					apstm = con.prepareStatement(asql);
					apstm.setString(1, staffid);
					apstm.setString(2, DateUtil.getMonth(Integer.parseInt(month)));
					apstm.setString(3, year);
					apstm.setString(4, description);
					apstm.setString(5, DateUtil.FormateDateSQL(low) );
					apstm.setString(6, ""+session.getAttribute("EMPID") );
					apstm.setString(7, authorisedby );
					apstm.setString(8, userid.toUpperCase());
					apstm.execute();
					apstm.close();
				}	
				response.sendRedirect("Smart Payroll/Temporarysuspension.jsp");
			}
			else if("PAYTemporarysuspensionApproved".equals(action))
			{ 
				String fdate = request.getParameter("fdate");
				String rowid = request.getParameter("rowid");
				String ndc = request.getParameter("ndc");
				String empid = request.getParameter("empid"); 
				String replacement = request.getParameter("replacement");
				String skillset = request.getParameter("skillset");
				
				asql = " UPDATE pay_t_temporarysuspension SET CHR_STATUS=?,CHR_REPLACEMENT=?,";
				asql = asql +" DAT_APPROVED_DATE = ? ,CHR_SKILLSET=?  ";
				asql = asql +" WHERE INT_ROWID =?";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,ndc );
				apstm.setString(2,replacement );
				apstm.setString(3, DateUtil.FormateDateSQL(fdate) );
				apstm.setString(4, skillset);
				apstm.setString(5, rowid);
				System.out.println(""+apstm);
				apstm.execute();
				apstm.close();
				
				asql = " UPDATE com_m_staff SET CHR_E_STATUS ='H' WHERE CHR_EMPID=?";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,empid );
				apstm.execute();
				apstm.close();
				
				response.sendRedirect("Smart Payroll/Refresh.jsp");
			}  
			else if("PAYTemporarysuspensionDeleteAfterApproval".equals(action))
			{
				String empid = request.getParameter("empid"); 
				
				asql = "DELETE FROM pay_t_temporarysuspension WHERE CHR_EMPID=? ";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,empid);
				apstm.execute();
				apstm.close();
				
				asql = "UPDATE  com_m_staff  SET  CHR_E_STATUS='Y' , DT_UPDATEDATE=DATE(NOW()),DAT_RESIGNDATE=null, DAT_PFRESIGNDATE=null WHERE CHR_EMPID =? ";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,empid);
				apstm.execute();
				
				apstm.close();
				con.close();
				response.sendRedirect("Smart Payroll/TemporarysuspensionApproval.jsp");
			}
			else if("PAYTemporarysuspensionMoved".equals(action))
			{
				String empid  = request.getParameter("empid");
				asql = "";
				asql = asql +" INSERT INTO pay_t_resignationletter  ";
				asql = asql +" (CHR_EMPID,CHR_REPORTINGTO,DAT_APPPLYDATE,DAT_LASTDATE,CHR_DESCRIPTION,  ";
				asql = asql +" CHR_ACCEPTSTATUS,CHR_REPLACEMENT,CHR_REJECTDESCRIPTION,CHR_MODE,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS  ";
				asql = asql +" )  ";
				asql = asql +" SELECT a.CHR_EMPID, b.CHR_REPTO,DATE_FORMAT(a.DAT_LOW,'%Y-%m-%d'),DATE_FORMAT(a.DAT_LOW,'%Y-%m-%d'),  ";
				asql = asql +" CONCAT('-'),a.CHR_STATUS,a.CHR_REPLACEMENT,a.CHR_DESC,'S', 'ADMIN',DATE(NOW()),'Y'  ";
				asql = asql +" FROM pay_t_temporarysuspension a , com_m_staff b  ";
				asql = asql +" WHERE a.CHR_EMPID = b.CHR_EMPID  ";
				asql = asql +" AND a.CHR_EMPID=? ";
				apstm = con.prepareStatement(asql);
				apstm.setString(1, empid);
				System.out.println(""+apstm);
				apstm.execute();
				apstm.close();
				
				asql = "UPDATE pay_t_temporarysuspension SET CHR_MOVE_RESIGINATION_POST='Y' WHERE CHR_EMPID=?";
				apstm = con.prepareStatement(asql);
				apstm.setString(1, empid);
				System.out.println(""+apstm);
				apstm.execute();
				apstm.close();
				con.close();
				response.sendRedirect("Smart Payroll/TemporarysuspensionApproval.jsp");
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
