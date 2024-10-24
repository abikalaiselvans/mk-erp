package com.my.org.erp.SmartMarketing;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.common.CommonFunctions;

public class CustomerNameActionHandler extends AbstractActionHandler
{
	String rowid="0";
	private void Delete(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{
			String []rowid= request.getParameterValues("rowid");							
			asql ="DELETE FROM mkt_m_customername   WHERE INT_CUSTOMERNAMEID=?";
			apstm = con.prepareStatement(asql);
			for(int i=0;i<rowid.length;i++)
			{	
				apstm.setString(1,rowid[i]);
				apstm.addBatch();				
			}
			apstm.executeBatch();
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
	
	private void Add(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{			
			String name=""+request.getParameter("customername").trim();
			String shortname=""+request.getParameter("shortname").trim();
			String division=""+request.getParameter("division").trim();
			asql=" INSERT INTO mkt_m_customername "; 
			asql = asql + " (CHR_NAME,CHR_SHORT,INT_DIVIID,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS )";
			asql = asql + " VALUES ( ?,?,?,?, DATE(NOW()),'Y') ";
			apstm =con.prepareStatement(asql);
			apstm.setString(1,name.replaceAll("&", " AND ").toUpperCase());
			apstm.setString(2,shortname );
			apstm.setString(3,division);
			apstm.setString(4,auserid);
			apstm.execute();
			apstm.close();
			
			asql = " SELECT MAX(INT_CUSTOMERNAMEID) FROM mkt_m_customername ";
			rowid = CommonFunctions.QueryExecute(asql)[0][0];
			
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
		}
	}
	
	private void Edit(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{	
			String  rowid=""+request.getParameter("Rowid");
			String name=request.getParameter("customername");
			String shortname=request.getParameter("shortname");
			String verification=""+request.getParameter("verification");
			String division=""+request.getParameter("division");
			asql=" UPDATE mkt_m_customername SET ";
			asql = asql + " CHR_NAME=?, CHR_SHORT=?,CHR_VERIFY=?,INT_DIVIID=?, CHR_USRNAME=?,DT_UPDATEDATE=DATE(NOW()),CHR_UPDATESTATUS='Y' WHERE INT_CUSTOMERNAMEID=?"; 
			apstm =con.prepareStatement(asql);
			apstm.setString(1,name);
			apstm.setString(2,shortname);
			apstm.setString(3,verification);
			apstm.setString(4,division);
			apstm.setString(5,auserid);
			apstm.setString(6,rowid);
			System.out.println(""+apstm);
			apstm.execute();
			apstm.close();
		}
		catch(Exception e)
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
				String action=request.getParameter("actionS");
				HttpSession session = request.getSession();
				String usertype  = (""+session.getAttribute("USERTYPE")).toUpperCase();
				String empid  = (""+session.getAttribute("EMPID")).toUpperCase();
				
				if(action.equals("MKTCustomerNameDelete"))
				{					
					Delete(request, response);
					con.close();    
					response.sendRedirect("Smart Marketing/CustomerName.jsp");
				}
				if("MKTCustomerNameAdd".equals(action))
				{				
					Add(request, response);
					con.close();   
					response.sendRedirect("Smart Marketing/CustomerInfoAction.jsp?action1=Add&customerrowid="+rowid);
					//response.sendRedirect("Smart Marketing/CustomerNameAction.jsp?action1=Add Customer&msg=Y&rowid="+rowid);
				}
				else if("MKTCustomerNameEdit".equals(action)){					
					Edit(request, response);
					con.close();    
					response.sendRedirect("Smart Marketing/CustomerName.jsp");
				}
				else if("MKTMovetoCustomerName".equals(action))
				{					
					String customerrowid = request.getParameter("customerrowid");
					asql = " INSERT INTO inv_m_customergroup (CHR_NAME,CHR_SHORT,CHR_MODE,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS) "; 
					asql = asql +" SELECT CHR_NAME,CHR_SHORT,CONCAT('S'),CONCAT('"+auserid+"'),DATE(NOW()),'Y'  FROM mkt_m_customername WHERE INT_CUSTOMERNAMEID="+customerrowid;
					apstm = con.prepareStatement(asql);
					apstm.execute();
					apstm.close();
					
					asql = "UPDATE mkt_m_customername SET CHR_MOVETO_INVENTORY=?,DT_DATEOFMOVE=NOW(),CHR_MOVEDBY= ? WHERE INT_CUSTOMERNAMEID=?";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,"Y");
					apstm.setString(2,empid);
					apstm.setString(3,customerrowid);
					apstm.execute();
					apstm.close();
					con.close();    
					response.sendRedirect("Smart Marketing/MovetoCustomerName.jsp");
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


