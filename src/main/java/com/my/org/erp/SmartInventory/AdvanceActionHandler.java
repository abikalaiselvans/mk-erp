package com.my.org.erp.SmartInventory;
import java.io.IOException;


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;

public class AdvanceActionHandler extends AbstractActionHandler
{
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try
		{
				String action=request.getParameter("actionS");
				if("INVAdvanceAmountADD".equals(action) )
				{			
					payAdd(request,response);
					con.close();    
					response.sendRedirect("Smart Inventory/Advance.jsp");
				}
				if("INVAdvanceAmountUpdate".equals(action) )
				{			
					payEdit(request,response);
					con.close();    
					response.sendRedirect("Smart Inventory/Advance.jsp");
				}
				
				else if("INVAdvanceDelete".equals(action) )
				{
					payDelete(request,response);
					con.close();    
					response.sendRedirect("Smart Inventory/Advance.jsp");
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
	
	
	
	private void payAdd(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{			
			HttpSession session=request.getSession();			
			String userid=""+session.getAttribute("USRID");		
			String Branch=""+session.getAttribute("INVBRANCH");
			String officeid=""+session.getAttribute("INVOFFICEID");
			String customer=request.getParameter("customer");
			String divis=request.getParameter("divis");
			String paymentMethod=request.getParameter("paymentMethod");
			String its[] =paymentMethod.split(",");
			boolean f = false;
			if(its[1] != "CASH" || its[1] != "CASH")
				f = true;
			
			String Bank=request.getParameter("Bank");
			String Challanno=request.getParameter("Challanno");
			String chequeDate=request.getParameter("chequeDate");
			if(f)
				chequeDate =DateUtil.FormateDateSQL(chequeDate);
			else
				chequeDate = null;
			String receivedDate=request.getParameter("receivedDate");
			receivedDate =DateUtil.FormateDateSQL(receivedDate);
			String Advanceamount=request.getParameter("Advanceamount");
			String remarks=request.getParameter("remarks");
			String ref=request.getParameter("ref");
			String advanceto=request.getParameter("advanceto");
			String creditto=request.getParameter("creditto");
			
			 
			String sql="";			
			String advnumber="";
			//"ADV/"+InventoryInvoiceFunctions.accountYear()+InventoryInvoiceFunctions.advanceNumber();
			advnumber = InventoryInvoiceFunctions.advanceNumberGet(""+session.getAttribute("INVSTATE"),officeid,divis);
			
			sql = " INSERT INTO inv_t_advancepayment ";
			sql = sql + " ( CHR_ADVANCEID,INT_BRANCHID,INT_CUSTOMERID,INT_DIVIID,CHR_TYPE,";
			sql = sql + " INT_PAYMENTTERMID,INT_BANKID ,CHR_PAYNO,";
			sql = sql + " DAT_PAYMENTDATE,DAT_COLLECTEDDATE,DOU_ADVANCEAMOUNT, ";
			sql = sql + " DAT_CREATEDATE,CHR_CREATED_BY,";
			sql = sql + " CHR_DESC,CHR_COLLECTEDBY,INT_DEPOSITID,";
			sql = sql + " CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS) ";
			sql = sql + " VALUE (";
			sql = sql + " ?,?,?,?,?, ?,?,?, ?,?,?,NOW(),?, ?,?, ?,?,DATE(NOW()),'Y') ";
			apstm = con.prepareStatement(sql);
			apstm.setString(1,advnumber);
			apstm.setString(2,Branch);
			apstm.setString(3,customer);
			apstm.setString(4,divis);
			apstm.setString(5,advanceto);
			apstm.setString(6,its[0]);
			apstm.setString(7,Bank);
			apstm.setString(8,Challanno);
			apstm.setString(9,chequeDate);
			apstm.setString(10,receivedDate);
			apstm.setString(11,Advanceamount);
			apstm.setString(12,userid);
			apstm.setString(13,remarks);
			apstm.setString(14,ref);
			apstm.setString(15,creditto);
			apstm.setString(16,userid);
			System.out.println(""+apstm);
			apstm.execute();
			apstm.close();
			
			//ADVANCE NUMBER INSERT
			apstm=con.prepareStatement("  SELECT FUN_INV_DIRECT_ADVANCENUMBER_INSERT(?) ");
			apstm.setString(1,""+session.getAttribute("INVSTATE"));
			apstm.execute();
			apstm.close();
		
			//mail generated 
			AdvanceMail.sendAdvanceMail(Branch, divis, advnumber, Path,"A");
			
			
			
		}
		catch(Exception e)
		{
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
			System.out.println(e.getMessage());
		}
	}	
	
	
	
	
	private void payEdit(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{			
			HttpSession session=request.getSession();			
			String userid=""+session.getAttribute("USRID");	
			String Branch=""+session.getAttribute("INVBRANCH");
			String customer=request.getParameter("customer");
			String advanceid=request.getParameter("advanceid");
			String divis=request.getParameter("divis");
			String paymentMethod=request.getParameter("paymentMethod");
			String its[] =paymentMethod.split(",");
			boolean f = false;
			if(its[1] != "CASH" || its[1] != "CASH")
				f = true;
			
			String Bank=request.getParameter("Bank");
			String Challanno=request.getParameter("Challanno");
			String chequeDate=request.getParameter("chequeDate");
			if(f)
				chequeDate =DateUtil.FormateDateSQL(chequeDate);
			else
				chequeDate = null;
			String receivedDate=request.getParameter("receivedDate");
			receivedDate =DateUtil.FormateDateSQL(receivedDate);
			String Advanceamount=request.getParameter("Advanceamount");
			String remarks=request.getParameter("remarks");
			String ref=request.getParameter("ref");
			String advanceto=request.getParameter("advanceto");
			String creditto=request.getParameter("creditto");
			String advancenumber=request.getParameter("advancenumber");
			
			asql = " UPDATE inv_t_advancepayment  SET ";
			asql = asql + "  INT_CUSTOMERID =?,INT_DIVIID=?,";
			asql = asql + " INT_PAYMENTTERMID=?,INT_BANKID =?,CHR_PAYNO=?,";
			asql = asql + " DAT_PAYMENTDATE=?,DAT_COLLECTEDDATE=?,DOU_ADVANCEAMOUNT=?, ";
			asql = asql + " DAT_MODIFIEDDATE=DATE(NOW()), CHR_MODIFIED_BY=? ,";
			asql = asql + " CHR_DESC=?,CHR_COLLECTEDBY=?,";
			asql = asql + " CHR_TYPE=?, INT_DEPOSITID=?,";
			asql = asql + " CHR_USRNAME=?,DT_UPDATEDATE=DATE(NOW()),CHR_UPDATESTATUS='Y'  ";
			asql = asql + "  WHERE INT_ADVANCEID= "+advanceid;;
			apstm = con.prepareStatement(asql);
			apstm.setString(1,customer);
			apstm.setString(2,divis);
			apstm.setString(3,its[0]);
			apstm.setString(4,Bank);
			apstm.setString(5,Challanno);
			apstm.setString(6,chequeDate);
			apstm.setString(7,receivedDate);
			apstm.setString(8,Advanceamount);
			apstm.setString(9,userid);
			apstm.setString(10,remarks);
			apstm.setString(11,ref);
			apstm.setString(12,advanceto);
			apstm.setString(13,creditto);
			apstm.setString(14,userid);
			apstm.execute();
			apstm.close();
			
			//mail generated 
			AdvanceMail.sendAdvanceMail(Branch, divis, advancenumber, Path,"M");
			
		}
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}	
	}	
	
	
	
	
	private void payDelete(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{			
			String advanceid=request.getParameter("advanceid");
			String sql="update inv_t_advancepayment SET CHR_DELETEFLAG =? WHERE INT_ADVANCEID =?";			
			apstm = con.prepareStatement(sql);
			apstm.setString(1,"Y");
			apstm.setString(2,advanceid);
			System.out.println(""+apstm);
			apstm.execute();
			apstm.close();
		}
		catch(Exception e)
		{
			 request.setAttribute("error", e.getMessage() );
			 RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
			 dispatchers.forward(request, response); 
			 System.out.println(e.getMessage());
		}
	}	
}

