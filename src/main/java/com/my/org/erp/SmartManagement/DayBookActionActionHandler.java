package com.my.org.erp.SmartManagement;
import java.io.IOException;
import java.sql.Connection;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.bean.HRM.JobDemand;

public class DayBookActionActionHandler extends AbstractActionHandler
{
	 
	String userid="";
	String empid="";
	
	@SuppressWarnings("rawtypes")
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
		try
		{
				String action=request.getParameter("actionS");
				HttpSession session=request.getSession();			
				userid=""+session.getAttribute("USRID");
				empid=""+session.getAttribute("EMPID");
				if(action.equals("MGTDayBookActionDelete"))
				{					
					Delete(request, response);
					con.close();   
					response.sendRedirect("Smart Management/DayBook.jsp");
				}
				else if(action.equals("MGTDayBookActionAdd"))
				{					
					
					Add(request, response);
					con.close();   
					response.sendRedirect("Smart Management/DayBook.jsp");
				}
				else if(action.equals("MGTDayBookActionEdit"))
				{					
					 
					Edit(request, response);
					con.close();   
					response.sendRedirect("Smart Management/DayBook.jsp");
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
	
	
	
	private void Add(HttpServletRequest request,HttpServletResponse response )throws ServletException, IOException
	{
		try
		{			
			 String  category = request.getParameter("category");
			 String fromdate = request.getParameter("fromdate");
			 String  type= request.getParameter("type");
			 String  amount= request.getParameter("amount");
			 String desc = request.getParameter("desc");
			 String paymentmode = request.getParameter("paymentmode");
			 asql = "INSERT INTO mgt_t_daybook (  INT_CATEGORYID,DT_DATE,CHR_DESC,CHR_TYPE,INT_CREDITAMOUNT,INT_DEBITAMOUNT,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS,INT_PAYMENTMODE) ";
			 asql = asql +" VALUES (?,?,?,?,?,?,?,NOW(),'Y',?) ";
			 apstm = con.prepareStatement(asql);
			 apstm.setString(1,category);
			 apstm.setString(2, DateUtil.FormateDateSQL(fromdate));
			 apstm.setString(3, desc);
			 apstm.setString(4,type);
			 if("C".equals(type))
			 {
				 apstm.setString(5, amount);
				 apstm.setString(6, null);
			 }
			 else
			 {
				 apstm.setString(5, null);
				 apstm.setString(6, amount);
				 
			 }
			 apstm.setString(7, auserid);
			 apstm.setString(8, paymentmode);
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
	
	
	
	private void Edit(HttpServletRequest request,HttpServletResponse response )throws ServletException, IOException
	{
		try
		{	
			
			 String  rowid = request.getParameter("rowid"); 
			 String  category = request.getParameter("category");
			 String fromdate = request.getParameter("fromdate");
			 String  type= request.getParameter("type");
			 String  amount= request.getParameter("amount");
			 String desc = request.getParameter("desc");
			 String paymentmode = request.getParameter("paymentmode");
			 asql = " UPDATE mgt_t_daybook SET  INT_CATEGORYID=? , DT_DATE=?, CHR_TYPE=? ,  ";
			 if("C".equals(type))
				 asql = asql + " INT_CREDITAMOUNT=?, INT_DEBITAMOUNT=null, ";
			 else
				 asql = asql + " INT_CREDITAMOUNT=null, INT_DEBITAMOUNT=?, ";
			 asql = asql + " CHR_DESC =?, CHR_USRNAME = ?, DT_UPDATEDATE=NOW() ,INT_PAYMENTMODE =?";
			 asql = asql + " WHERE INT_ROWID=?";
			 
			 apstm = con.prepareStatement(asql);
			 apstm.setString(1,category);
			 apstm.setString(2, DateUtil.FormateDateSQL(fromdate));
			 apstm.setString(3,type   );
			 apstm.setString(4,amount);
			 apstm.setString(5, desc);
			 apstm.setString(6, auserid);
			 apstm.setString(7, paymentmode);
			 apstm.setString(8, rowid);
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
	
	private void Delete(HttpServletRequest request,HttpServletResponse response )throws ServletException, IOException
	{
		try
		{			
			String []rowid= request.getParameterValues("rowid");	
			asql = " DELETE FROM mgt_t_daybook WHERE INT_ROWID=?";
			apstm = con.prepareStatement(asql);
			for(int i=0;i<rowid.length;i++)
			{
				apstm.setString(1, rowid[i]);
				System.out.println(""+apstm);
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
	
	
	
	
	
}

