package com.my.org.erp.SmartInventory;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;


public class AMCActionHandler extends AbstractActionHandler
{
		public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
		{
			try
			{
					String action=request.getParameter("actionS");
					if(action.equals("INVAMCADD"))
					{					
						addAMC(request,response);
						con.close();    
						response.sendRedirect("Smart Inventory/amc.jsp");
					}
					else if(action.equals("INVAMCUpdate"))
					{					
						addUpdate(request,response);
						 
						con.close();   
						response.sendRedirect("Smart Inventory/amc.jsp");
					}
					else if(action.equals("INVAMCDELETE"))
					{					
						addDelete(request,response);
						con.close();   
						response.sendRedirect("Smart Inventory/amc.jsp");
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
		
		
		@SuppressWarnings("deprecation")
		private void addAMC(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException 
		{
			try
			{
			
				String Amcid = request.getParameter("Amcid");
				String customertype = request.getParameter("customertype");
				String customerid = request.getParameter("customerid");
				String type = request.getParameter("type");
				String itemname = request.getParameter("itemname");
				String serialno = request.getParameter("serialno");
				String description = request.getParameter("description");
				String startdate = request.getParameter("startdate");
				String dt[] = startdate.split("-");
				String enddate= dt[0]+"-"+dt[1]+"-"+(Integer.parseInt(dt[2])+1);
				int warranty = Integer.parseInt(request.getParameter("warranty"));
				double amcamount = Double.parseDouble(request.getParameter("amcamount"));
				HttpSession session=request.getSession();			
				String userId=""+session.getAttribute("USRID");	
				@SuppressWarnings("unused")
				java.text.SimpleDateFormat datetime = new java.text.SimpleDateFormat("dd-MM-yyyy");
				java.util.Date date = new java.util.Date();
				int year = 1900+date.getYear();
				String sql ="";
				sql = " INSERT INTO inv_t_amc ( INT_YEAR,CHR_AMCID,INT_CUSTOMERID,";
				sql = sql +" CHR_CUSTOMERFLAG,CHR_ITEMID,CHR_SERIALNO,CHR_WARRANTY,";
				sql = sql +" CHR_AMCDESC,DT_STARTDATE,DT_ENDDATE,DOU_AMCAMOUNT,";//
				sql = sql +" CHR_ITEMFLAG,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS,CHR_TYPE )";
				sql = sql + " VALUES ("+year+", '"+Amcid+"'" +
				" , '"+customerid+"','"+customertype+"'" +
				" , '"+itemname+"','"+serialno+"'" +
				" , '"+warranty+"','"+description+"'" +
				" , '"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(startdate)+"'" +
				" , '"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(enddate)+"'" +
				" , "+amcamount+"" +
				" , '"+type+"'" +
				" , '"+userId+"'" +
				" , now()" +
				" , 'Y','"+type+"')";
				PreparedStatement ps=con.prepareStatement(sql);
				ps.execute();
			 	
			}
			catch(Exception e)
			{
				System.out.println(e.getMessage());
				request.setAttribute("error", e.getMessage() );
	            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    		dispatchers.forward(request, response); 
			 
			}
		
	}
		@SuppressWarnings("deprecation")
		private void addDelete(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException 
		{
			try
			{
			
				String Amcid[] = request.getParameterValues("amcid");
				HttpSession session=request.getSession();			
				@SuppressWarnings("unused")
				String userId=""+session.getAttribute("USRID");	
				@SuppressWarnings("unused")
				java.text.SimpleDateFormat datetime = new java.text.SimpleDateFormat("dd-MM-yyyy");
				java.util.Date date = new java.util.Date();
				@SuppressWarnings("unused")
				int year = 1900+date.getYear();
				String sql ="";
				for(int u=0;u<Amcid.length;u++)
				{	
					sql = " DELETE FROM  inv_t_amc WHERE  CHR_AMCID ='"+Amcid[u]+"'  ";
				    Statement ps=con.createStatement();
				    ps.execute(sql);
				    
				    sql = " DELETE FROM  inv_t_amcamount WHERE  CHR_AMCID ='"+Amcid[u]+"'  ";
				    ps.execute(sql);
				}    
			 	
			}
			catch(Exception e)
			{
				System.out.println(e.getMessage());
				request.setAttribute("error", e.getMessage() );
	            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    		dispatchers.forward(request, response); 
			}
		
			
			
	}	
		
		
		
		
		@SuppressWarnings("deprecation")
		private void addUpdate(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException 
		{
			try
			{
				java.util.Date date = new java.util.Date();
				@SuppressWarnings("unused")
				int year = 1900+date.getYear();
				String Amcid  = request.getParameter("amcid");
				String serialno = request.getParameter("serialno");
				String description = request.getParameter("description");
				String startdate = request.getParameter("startdate");
				String dt[] = startdate.split("-");
				String enddate= dt[0]+"-"+dt[1]+"-"+(Integer.parseInt(dt[2])+1);
				int warranty = Integer.parseInt(request.getParameter("warranty"));
				@SuppressWarnings("unused")
				String amcamount = request.getParameter("amcamount");
				String sql ="";
				sql = " UPDATE inv_t_amc  SET " +
						"CHR_SERIALNO = '"+serialno+"' , CHR_WARRANTY ='"+warranty+"' ,  " +
								" CHR_AMCDESC = '"+description+"', " +
										" DT_STARTDATE='"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(startdate)+"' , DT_ENDDATE='"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(enddate)+"' WHERE  CHR_AMCID ='"+Amcid+"'  ";
				Statement ps=con.createStatement();
				ps.execute(sql);
			}
			catch(Exception e)
			{
				System.out.println(e.getMessage());
				request.setAttribute("error", e.getMessage() );
	            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    		dispatchers.forward(request, response); 
			}
	}		
}