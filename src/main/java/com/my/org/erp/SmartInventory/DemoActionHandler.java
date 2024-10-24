package com.my.org.erp.SmartInventory;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;

public class DemoActionHandler extends AbstractActionHandler
{
	
	 

	private void DemoDelete(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			
			String demoId[]=request.getParameterValues("rowid");		
			asql = "DELETE FROM INV_T_DEMO WHERE   INT_DEMOID=?";		
			apstm = con.prepareStatement(asql);
			for (int i = 0; i < demoId.length; i++) 
			{				
				apstm.setString(1,  demoId[i]);				
				apstm.addBatch();
			}
			apstm.executeBatch();
			apstm.close();
			
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}
	}

	private void DemoAdd(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			HttpSession session=request.getSession();
			String branch=""+session.getAttribute("INVBRANCH");
			String TxtCustName= request.getParameter("TxtCustName");
			String TxtCustAdd=""+request.getParameter("TxtCustAdd");
			String dt=request.getParameter("fromdt");
			String date1 = DateUtil.FormateDateSQL(dt);  			
			String TxtDemoDes=""+request.getParameter("TxtDemoDes");
			String TxtAuthorised=""+request.getParameter("TxtAuthorised");
			String TxtHandle=""+request.getParameter("TxtHandle");			
			 
			asql="INSERT INTO INV_T_DEMO( INT_BRANCHID,CHR_CUSTNAME,";
			asql = asql + "DT_DEMODATE,CHR_CUSTADD,CHR_DESCRIPTION,CHR_AUTHORISEDBY,";
			asql = asql + "CHR_HANDLEDBY, CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS ) ";
			asql = asql + " VALUES ( ";
			asql = asql + "  ?,?,?,?,?,?,?,?,DATE(NOW()),'Y' ";
			asql = asql + ") ";
			
			apstm = con.prepareStatement(asql);
			apstm.setString(1, branch);			
			apstm.setString(2, TxtCustName);
			apstm.setString(3, date1);
			apstm.setString(4, TxtCustAdd);			
			apstm.setString(5, TxtDemoDes);
			apstm.setString(6, TxtAuthorised);
			apstm.setString(7, TxtHandle);	
			apstm.setString(8, auserid);
			System.out.println(""+apstm);
			apstm.execute();
			apstm.close();
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}
	}
	
	private void DemoEdit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
		
			HttpSession session=request.getSession();
			String branch=""+session.getAttribute("INVBRANCH");
			String TxtCustName= request.getParameter("TxtCustName");
			String TxtCustAdd=""+request.getParameter("TxtCustAdd");
			String dt=request.getParameter("fromdt");
			String date1 = DateUtil.FormateDateSQL(dt);  			
			String TxtDemoDes=""+request.getParameter("TxtDemoDes");
			String TxtAuthorised=""+request.getParameter("TxtAuthorised");
			String TxtHandle=""+request.getParameter("TxtHandle");
			String rowid=""+request.getParameter("rowid");
			String status=""+request.getParameter("status");	
			
			
			 
			if(!"Y".equals(status) )
				status="N";
			asql="UPDATE INV_T_DEMO SET CHR_CUSTNAME=?,";
			asql = asql + " DT_DEMODATE=?,CHR_CUSTADD=?,CHR_DESCRIPTION=?,";
			asql = asql + " CHR_STATUS=?,CHR_AUTHORISEDBY=?,CHR_HANDLEDBY=?, ";
			asql = asql + " CHR_USRNAME=?,DT_UPDATEDATE=DATE(NOW()),CHR_UPDATESTATUS='Y'";
			asql = asql + " where int_demoid=?";
			apstm = con.prepareStatement(asql);					
			apstm.setString(1, TxtCustName);
			apstm.setString(2, date1);
			apstm.setString(3, TxtCustAdd);			
			apstm.setString(4, TxtDemoDes);
			apstm.setString(5, status);
			apstm.setString(6, TxtAuthorised);
			apstm.setString(7, TxtHandle);
			apstm.setString(8, auserid);
			apstm.setString(9, rowid);
			System.out.println(""+apstm);
			apstm.execute();
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}
	}
	
	private void DemoReturn(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
		
			HttpSession session=request.getSession();
			String rowid=""+request.getParameter("rowid");
			String reason=""+request.getParameter("reason");
			 
			asql="UPDATE INV_T_DEMO SET CHR_STATUS=?,";
			asql = asql + " CHR_RETURNEDBY=?,DAT_RETURN=NOW(),CHR_RETURNDESC=?, ";
			asql = asql + " CHR_USRNAME=?,DT_UPDATEDATE=DATE(NOW()),CHR_UPDATESTATUS='Y'";
			asql = asql + " where int_demoid=?";
			apstm = con.prepareStatement(asql);					
			apstm.setString(1, "Y");
			apstm.setString(2, ""+session.getAttribute("EMPID"));
			apstm.setString(3, reason);			
			apstm.setString(4, auserid);
			apstm.setString(5, rowid);
			System.out.println(""+apstm);
			apstm.execute();
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}
	}
	private void DemoReset(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
		
			 
			String rowid=""+request.getParameter("rowid");
			asql="UPDATE INV_T_DEMO SET CHR_STATUS='N',";
			asql = asql + " CHR_RETURNEDBY=null,DAT_RETURN=null,CHR_RETURNDESC=null, ";
			asql = asql + " CHR_USRNAME=?,DT_UPDATEDATE=DATE(NOW()),CHR_UPDATESTATUS='Y'";
			asql = asql + " WHERE INT_DEMOID=?";
			apstm = con.prepareStatement(asql);					
			apstm.setString(1, auserid);
			apstm.setString(2, rowid);
			System.out.println(""+apstm);
			apstm.execute();
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}
	}     
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			if (action.equals("INVdemoAdd")) 
			{
				DemoAdd(request, response);		
				con.close();    
				response.sendRedirect("Smart Inventory/Demo.jsp");						
			}
			else if (action.equals("INVdemoEdit")) 
			{
				DemoEdit(request, response);	
				con.close();   
				response.sendRedirect("Smart Inventory/Demo.jsp");						
			}
			else if (action.equals("INVdemoDelete")) 
			{
				DemoDelete(request, response);	
				con.close();   
				response.sendRedirect("Smart Inventory/Demo.jsp");	
			}			
			else if (action.equals("INVdemoClosed")) 
			{
				DemoReturn(request, response);	
				con.close();   
				response.sendRedirect("Smart Inventory/Demo.jsp");	
			}
			else if (action.equals("INVdemoReset")) 
			{
				DemoReset(request, response);	
				con.close();   
				response.sendRedirect("Smart Inventory/Demo.jsp");	
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
