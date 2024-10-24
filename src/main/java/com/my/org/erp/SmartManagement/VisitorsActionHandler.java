package com.my.org.erp.SmartManagement;

import java.io.IOException;
import java.util.Date;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 

import org.apache.commons.beanutils.BeanUtils;
 
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.bean.management.Visitors;
import com.my.org.erp.common.CommonFunctions;
 

public class VisitorsActionHandler extends AbstractActionHandler {

	@SuppressWarnings("rawtypes")
	private static String  empid =null;
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session=request.getSession();			
			String userid=""+session.getAttribute("USRID");
			empid=""+session.getAttribute("EMPID");
			String branchid = session.getAttribute("BRANCHID").toString();
			String officeid=""+session.getAttribute("OFFICEID");
			if ("MGTVisitorsAdd".equals(action)) 
			{	
				Add(request,response);
				con.close();
				response.sendRedirect("Smart Management/Visitors.jsp");
			}
			else if ("MGTVisitorsEdit".equals(action)) 
			{ 
				Edit(request,response); 
				con.close();
				response.sendRedirect("Smart Management/Visitors.jsp");
				
			} 
			else if ("MGTVisitorsOuttime".equals(action)) 
			{ 
				String rowid = request.getParameter("rowid");
				String todate = request.getParameter("todate");
				asql = " UPDATE mgt_m_visitor SET DT_TIMEOUT =?, CHR_STATUS='Y' WHERE INT_VISITORID=?";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,DateUtil.FormateDateandTimeSQL(todate) );
				apstm.setString(2,rowid );
				System.out.println(""+apstm);
				apstm.execute();
				con.close();
				response.sendRedirect("Smart Management/Visitors.jsp");
			}
			 
			else if ("MGTVisitorsDelete".equals(action)) 
			{ 
				Delete(request,response); 
				con.close();
				response.sendRedirect("Smart Management/Visitors.jsp");
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

	
	public void Add(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException
	{
		try
		{
			 
			Visitors c =new Visitors();
			Map map=request.getParameterMap();
			BeanUtils.populate(c,map);
			c.setTodate("date");
			c.setRefno(visitorsNumber() );
			c.setUserdate(new Date());
			c.setCreatetime(DateUtil.getCurrentDate());
			c.setStatus("Y");
			c.setEntryby(empid);
			HVisitorsInsertion.insert(c);
			 
			
		}
		catch (Exception e) 
		{
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}
	}
	
	
	
	public void Edit(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException
	{
		try
		{
			
			Visitors c =new Visitors();
			Map map=request.getParameterMap();
			BeanUtils.populate(c,map);
			c.setTodate("date");
			c.setUserdate(new Date());
			c.setStatus("Y");
			c.setEntryby(empid);
			HVisitorsInsertion.update(c) ;
			
			 
			
		}
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}
	}
	public void Delete(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException
	{
		try
		{
			
			String []rowid= request.getParameterValues("rowid");							
			Visitors c =new Visitors();
			Map map=request.getParameterMap();
			BeanUtils.populate(c,map);
			c.setTodate("date");
			c.setFromdate("date");
			c.setValidupto("sd");
			c.setRefno("");
			c.setUserdate(new Date());
			c.setCreatetime(DateUtil.getCurrentDate());
			c.setStatus("Y");
			c.setEntryby(empid);  
		 
			for(int i=0;i<rowid.length;i++)
			{
				c.setRowid(Integer.parseInt(rowid[i]));
				HVisitorsInsertion.delete(c) ;
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
	
	
	public static String visitorsNumber() 
	 {
		try 
	 	{
			
			String sql =" SELECT CONCAT('VT/',RIGHT(CONCAT('00000', (SELECT IF( (COUNT(*)>0 ) , (MAX(INT_VISITORID)+1),'1')   FROM mgt_m_visitor)),6) )";
			return CommonFunctions.QueryExecute(sql)[0][0];
			
	 	}
	 	catch (Exception e) 
	 	{
	 		 System.out.println(e.getMessage());
	 	}
	 	return null;
	 }
	 
}