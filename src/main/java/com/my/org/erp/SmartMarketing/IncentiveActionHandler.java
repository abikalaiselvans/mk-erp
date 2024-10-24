package com.my.org.erp.SmartMarketing;
import java.io.IOException;
import java.sql.CallableStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;

public class IncentiveActionHandler extends AbstractActionHandler {
	String TxtInNo, TxtAmount,incentive,OptStatus,date1,fdate,paymentId, TxtDes, sesUser;
	int courseId;
	public void insertUserInformation(String staffid) {
	try {
			CallableStatement cs = con.prepareCall("{call MKT_PRO_INCENTIVE(?,?,?,?,?,?,?,?,?,?,?,?)}");
			cs.setString(1, "INSERT");
			cs.setString(2, "1");	
			cs.setString(3, staffid);			
			cs.setString(4, TxtInNo);
			cs.setString(5, TxtAmount);
			cs.setString(6, date1);			
			cs.setString(7, paymentId);			
			String data[] = date1.split("-");
			String month = DateUtil.getMonth(Integer.parseInt(data[1]));
			cs.setString(8, month);
			cs.setInt(9, Integer.parseInt(data[0]));
			cs.setString(10, TxtDes);
			cs.setString(11, OptStatus);
			cs.setString(12, sesUser);			
			cs.execute();
		} 
	catch (Exception e)
		{
			 System.out.println(e.getMessage());
		}
	}	
	public void editUserInformation(String staffid,String incentive) {
	try {
			CallableStatement cs = con.prepareCall("{call MKT_PRO_INCENTIVE(?,?,?,?,?,?,?,?,?,?,?,?)}");
			cs.setString(1, "UPDATE");
			cs.setString(2, incentive);		
			cs.setString(3, staffid);		
			cs.setString(4, TxtInNo);
			cs.setString(5, TxtAmount);
			cs.setString(6, date1);			
			cs.setString(7, paymentId);			
			String data[] = date1.split("-");
			String month = DateUtil.getMonth(Integer.parseInt(data[1]));
			cs.setString(8, month);
			cs.setInt(9, Integer.parseInt(data[0]));
			cs.setString(10, TxtDes);
			cs.setString(11, OptStatus);
			cs.setString(12, sesUser);			
			cs.execute();
		} catch (Exception e)
		{
			 System.out.println(e.getMessage());
		}
	}	
	private void incentiveAdd(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession session = request.getSession();
			sesUser = (String) session.getAttribute("USRID");
			String staffname[] = request.getParameterValues("ename");
			TxtInNo = request.getParameter("TxtInNo");
			TxtAmount = request.getParameter("TxtAmount");
			paymentId = request.getParameter("paymentId");
			TxtDes = request.getParameter("TxtDes");	
			OptStatus =""+request.getParameter("OptStatus");	
			
			if(OptStatus.equalsIgnoreCase("on"))
			{OptStatus="Y";}
			else
			{OptStatus="N";}	
			fdate = request.getParameter("fromdt");			
			date1 = DateUtil.FormateDateSQL(fdate);				
			for (int i = 0; i < staffname.length; i++) {
				insertUserInformation(staffname[i]);
			}
		} catch (Exception e)
		{
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}	
	private void incentiveDelete(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession session = request.getSession();
			sesUser = (String) session.getAttribute("USRID");
			String incentive[] =(""+request.getParameter("incentive")).split("~");
			//System.out.println("incent"+incentive);	
			CallableStatement cs = con.prepareCall("{call MKT_PRO_INCENTIVE(?,?,?,?,?,?,?,?,?,?,?,?)}");
			for (int i = 0; i<incentive.length; i++) {				
				cs.setString(1, "DELETE");
				cs.setString(2, incentive[0]);	
				cs.setString(3, incentive[1]);
				cs.setString(4, "1");
				cs.setString(5, "1");
				cs.setString(6, "1");			
				cs.setString(7, "1");			
				cs.setString(8, "1");
				cs.setString(9, "1");
				cs.setString(10, "1");
				cs.setString(11, "1");
				cs.setString(12, "1");			
				cs.addBatch();				
			}
			cs.executeBatch();
		} catch (Exception e) {
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}
		
	private void incentiveEdit(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession session = request.getSession();
			sesUser = (String) session.getAttribute("USRID");
			String staffname=request.getParameter("staffid");
			incentive=request.getParameter("incentive");
			TxtInNo = request.getParameter("TxtInNo");
			TxtAmount = request.getParameter("TxtAmount");
			paymentId = request.getParameter("paymentId");
			TxtDes = request.getParameter("TxtDes");	
			OptStatus =""+request.getParameter("OptStatus");	
			if(OptStatus.equalsIgnoreCase("on"))
			{OptStatus="Y";	}
			else
			{OptStatus="N";}	
		    fdate = request.getParameter("fromdt");			
			date1 = DateUtil.FormateDateSQL(fdate);	
			editUserInformation(staffname,incentive);
		
		} catch (Exception e) {
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}


	public void handle(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			String action = request.getParameter("actionS");
			//System.out.println("King"+action);
			if ("MKTincentiveAdd".equals(action)) {
				incentiveAdd(request, response);				
				response.sendRedirect("Smart Marketing/Incentive.jsp");
			} 		
			else
			if ("MKTincentiveEdit".equals(action)) {
				incentiveEdit(request, response);				
				response.sendRedirect("Smart Marketing/Incentive.jsp");
			} 		
			else
			if ("MKTincentiveDelete".equals(action)) {
				incentiveDelete(request, response);				
				response.sendRedirect("Smart Marketing/Incentive.jsp");
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
