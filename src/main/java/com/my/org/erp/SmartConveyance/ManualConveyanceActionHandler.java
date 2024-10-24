package com.my.org.erp.SmartConveyance;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;
 
public class ManualConveyanceActionHandler extends AbstractActionHandler 
{
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String empid = ""+session.getAttribute("EMPID");
			System.out.println("................."+action);
			if ("CONManualConveyanceDelete".equals(action)) 
			{ 
				String rowid [] = request.getParameterValues("rowid");
				if(rowid.length>0)
				{
					asql = "DELETE FROM conveyance_m_manual WHERE INT_MANAUALID=?";
					apstm = con.prepareStatement(asql);
					for(int u=0;u<rowid.length;u++)
					{
						apstm.setString(1, rowid[u]);
						apstm.addBatch();
					}
					apstm.executeBatch();
					apstm.close();
				}
				con.close();
				response.sendRedirect("Smart Conveyance/ManualConveyance.jsp");
				
			}
			else if ("CONManualConveyanceAdd".equals(action)) 
			{ 
				String staffid = "" + request.getParameter("ename");
				String month = "" + request.getParameter("month");
				String year = "" + request.getParameter("year");
				String amount = "" + request.getParameter("advamount");
				String desc = "" + request.getParameter("desc");
				String authorised = "" + request.getParameter("authorised");
				month = DateUtil.getMonth(Integer.parseInt(month));
				
				asql =  "INSERT INTO conveyance_m_manual (CHR_EMPID,DAT_ENTRYDATE,DOU_AMOUNT,";
				asql = asql +" CHR_MONTH,INT_YEAR,CHR_DESC, CHR_AUTHORITY,CHR_ENTRYBY, CHR_USRNAME, DT_UPDATEDATE, CHR_UPDATESTATUS) ";
				asql = asql +" VALUES ( ";
				asql = asql + "?,NOW(),?,?,?,?,?,?,?,NOW(),'Y')";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,staffid);
				apstm.setString(2,amount);
				apstm.setString(3,month);
				apstm.setString(4,year);
				apstm.setString(5,desc);
				apstm.setString(6,empid);
				apstm.setString(7,authorised);
				apstm.setString(8,auserid);
				System.out.println(""+apstm);
				apstm.execute(); 
				con.close();    
				response.sendRedirect("Smart Conveyance/ManualConveyance.jsp");
			}
			else if ("CONConveyanceAdvanceUpdate".equals(action)) 
			{ 
				 
				String rowid = "" + request.getParameter("rowid");
				String staffid = "" + request.getParameter("ename");
				String month = "" + request.getParameter("month");
				String year = "" + request.getParameter("year");
				String amount = "" + request.getParameter("advamount");
				String desc = "" + request.getParameter("desc");
				String authorised = "" + request.getParameter("authorised");
				month = DateUtil.getMonth(Integer.parseInt(month));
				
				asql =   "UPDATE conveyance_m_manual SET ";
				asql = asql +" CHR_MONTH=?,";
				asql = asql +" INT_YEAR=?,";
				asql = asql +" DOU_AMOUNT=?,";
				asql = asql +" CHR_DESC=?,";
				asql = asql +" CHR_AUTHORITY=?,";
				asql = asql +" CHR_USRNAME= ?,";
				asql = asql +" DT_UPDATEDATE= DATE(NOW())  WHERE INT_MANAUALID =? ";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,month);
				apstm.setString(2,year);
				apstm.setString(3,amount);
				apstm.setString(4,desc);
				apstm.setString(5,authorised);
				apstm.setString(6,auserid);
				apstm.setString(7,rowid);
				System.out.println(""+apstm);
				apstm.execute(); 
				con.close();    
				response.sendRedirect("Smart Conveyance/ManualConveyance.jsp");
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
