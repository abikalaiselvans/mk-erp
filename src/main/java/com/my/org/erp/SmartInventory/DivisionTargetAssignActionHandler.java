package com.my.org.erp.SmartInventory;
import java.io.IOException;
 
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;

import com.my.org.erp.bean.inventory.*;
import com.my.org.erp.common.CommonFunctions;
public class DivisionTargetAssignActionHandler extends AbstractActionHandler
{
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{		
		try
		{
				String action=""+request.getParameter("actionS").trim();
				HttpSession session=request.getSession();			
				 
				@SuppressWarnings("unused")
				String branchid = session.getAttribute("BRANCHID").toString();
				 
				String sql="";
				if("INVTargetAssign".equals(action))
				{
					String January =request.getParameter("January");
					String February =request.getParameter("February");
					String March =request.getParameter("March");
					String April =request.getParameter("April");
					String May =request.getParameter("May");
					String June =request.getParameter("June");
					String July =request.getParameter("July");
					String August =request.getParameter("August");
					String September =request.getParameter("September");
					String October =request.getParameter("October");
					String November =request.getParameter("November");
					String December =request.getParameter("December");
					String year =request.getParameter("year");
					String division =request.getParameter("division");
					asql = "SELECT COUNT(*) FROM inv_t_targetassign_division WHERE INT_DIVIID="+division+" AND INT_YEAR="+year;
					System.out.println(asql);
					if(!CommonFunctions.RecordExist(con, asql))
					{	
						asql = " INSERT INTO inv_t_targetassign_division (INT_DIVIID,INT_YEAR,INT_APR,";
						asql = asql +" INT_MAY,INT_JUN,INT_JUL,INT_AUG,INT_SEP,INT_OCT,INT_NOV,";
						asql = asql +" INT_DEC,INT_JAN,INT_FEB,INT_MAR,";
						asql = asql +" CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS ) VALUES ";
						asql = asql +" (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,NOW(),'Y' )";
						apstm = con.prepareStatement(asql);
						apstm.setString(1,division);
						apstm.setString(2,year);
						apstm.setString(3,April);
						apstm.setString(4,May);
						apstm.setString(5,June);
						apstm.setString(6,July);
						apstm.setString(7,August);
						apstm.setString(8,September);
						apstm.setString(9,October);
						apstm.setString(10,November);
						apstm.setString(11,December);
						apstm.setString(12,January);
						apstm.setString(13,February);
						apstm.setString(14,March);
						apstm.setString(15,auserid);
						System.out.println(""+apstm);
						apstm.execute();
						apstm.close();
					}	
				 
					con.close();    
					response.sendRedirect("Smart Inventory/DivisionTargetAssign.jsp");
				}
				else if("INVTargetAssignDELETE".equals(action))
				{
					String targetrow[] = request.getParameterValues("target");
					asql = " DELETE FROM inv_t_targetassign_division WHERE INT_TARGETDIVIID = ?";
					apstm = con.prepareStatement(asql);
					for(int u=0;u<targetrow.length;u++)
					{
						apstm.setString(1,targetrow[u]);
						apstm.addBatch();
						
					}
					apstm.executeBatch();
					apstm.close();
					con.close();    
					response.sendRedirect("Smart Inventory/DivisionTargetAssign.jsp");
				}
				else if("INVTargetAssignEdit".equals(action))
				{
					String target = request.getParameter("target");
					String January =request.getParameter("January");
					String February =request.getParameter("February");
					String March =request.getParameter("March");
					String April =request.getParameter("April");
					String May =request.getParameter("May");
					String June =request.getParameter("June");
					String July =request.getParameter("July");
					String August =request.getParameter("August");
					String September =request.getParameter("September");
					String October =request.getParameter("October");
					String November =request.getParameter("November");
					String December =request.getParameter("December");
					
					asql= " UPDATE  inv_t_targetassign_division SET INT_APR= ? ,";
					asql = asql+"	INT_MAY = ?,";
					asql = asql+"	INT_JUN = ? ,";
					asql = asql+"	INT_JUL = ? ,";
					asql = asql+"	INT_AUG = ? ,";
					asql = asql+"	INT_SEP = ? ,";
					asql = asql+"	INT_OCT = ? ,";
					asql = asql+"	INT_NOV = ? ,";
					asql = asql+"	INT_DEC = ? ,";
					asql = asql+"	INT_JAN = ? ,";
					asql = asql+"	INT_FEB = ? ,";
					asql = asql+"	INT_MAR = ?" ;
					asql = asql+"	WHERE  INT_TARGETDIVIID = ? ";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,April);
					apstm.setString(2,May);
					apstm.setString(3,June);
					apstm.setString(4,July);
					apstm.setString(5,August);
					apstm.setString(6,September);
					apstm.setString(7,October);
					apstm.setString(8,November);
					apstm.setString(9,December);
					apstm.setString(10,January);
					apstm.setString(11,February);
					apstm.setString(12,March);
					apstm.setString(13,target);
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
					con.close();    
					response.sendRedirect("Smart Inventory/DivisionTargetAssign.jsp");
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
