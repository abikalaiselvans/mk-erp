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
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;


public class ServiceAMCActionHandler extends AbstractActionHandler
{
		public synchronized void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
		{
			try
			{
					String action=request.getParameter("actionS");
					String sql="";
					HttpSession session=request.getSession();			
					String userid=""+session.getAttribute("USRID");
					String branchid=""+session.getAttribute("BRANCHID");
					Statement st = con.createStatement();
					if(action.equals("INVServiceAMCAdd"))
					{					
						String param  = request.getParameter("param");
						String params[] = param.split(",");
						String customerid = request.getParameter("customerid");
						String startdate = request.getParameter("startdate");
						String amcperiod = request.getParameter("amcperiod");
						String stdate[] = startdate.split(" ");
						String sdate = DateUtil.FormateDateSQL(stdate[0])+" "+stdate[1];
						String complainttype = request.getParameter("complainttype");
						
						for(int u=0;u<params.length;u++)
						{
							String amcno= CommonFunctions.serviceAMCNumber()+"/AMC/"+CommonFunctions.AccountYear();
							String peripheralid = request.getParameter("type"+params[u]);
							String serialno = request.getParameter("serailno"+params[u]);
							String description = request.getParameter("description"+params[u]);
							String amcamount = request.getParameter("amcamount"+params[u]);
							sql = " INSERT INTO inv_m_serviceamc ( INT_BRANCHID  ,CHR_AMCID,INT_CUSTOMERID,INT_SERVICEITEMID,CHR_SERIALNO,CHR_CATEGORY,CHR_DESC,DT_STARTDATE,DAT_UPDATION,DT_ENDDATE,INT_NOOFYEAR,DOU_AMCAMOUNT,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS )";
							sql = sql + " VALUES ( ";
							sql = sql +" " +branchid+" , ";
							sql = sql +" '" +amcno+"' , ";
							sql = sql +" " +customerid+" , ";
							sql = sql +" " +peripheralid+" , ";
							sql = sql +" '" +serialno+"' , ";
							sql = sql +" '" +complainttype+"' , ";
							sql = sql +" '" +description+"' , ";
							sql = sql +" '" +sdate+"' , ";
							sql = sql +" '" +sdate+"' , ";
							sql = sql +" ( SELECT DATE_ADD('"+sdate+"', INTERVAL ("+amcperiod+"*365.25) DAY))  , ";
							sql = sql +" " +amcperiod+" , ";
							sql = sql +" '" +amcamount+"' , ";
							sql = sql +" '" +userid+"' , now(),'Y')";
							st.execute(sql);
							sql=" INSERT INTO inv_m_serviceamcnumbergenerate VALUES ("+CommonFunctions.serviceAMCNumber()+")";
							st.execute(sql);
							
							
						}
						st.close();
						con.close();    
						response.sendRedirect("Smart Inventory/amc.jsp");
					}
					else if(action.equals("INVServiceAMCEdit"))
					{					
						String amcid = request.getParameter("id");
						String customerid = request.getParameter("customerid");
						String peripheralid = request.getParameter("peripheralid");
						String serialno = request.getParameter("serialno");
						String description = request.getParameter("description");
						String startdate = request.getParameter("startdate");
						String amcperiod = request.getParameter("amcperiod");
						String amcamount = request.getParameter("amcamount");
						String stdate[] = startdate.split(" ");
						String sdate = DateUtil.FormateDateSQL(stdate[0])+" "+stdate[1];
						String complainttype = request.getParameter("complainttype");
						//com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(indate)
						sql = " UPDATE inv_m_serviceamc SET ";
						sql = sql+ " INT_CUSTOMERID="+customerid+" , ";
						sql = sql+ " INT_SERVICEITEMID="+peripheralid+" , ";
						sql = sql+ " CHR_SERIALNO='"+serialno+"' , ";
						sql = sql+ " CHR_CATEGORY='"+complainttype+"' , ";
						sql = sql+ " CHR_DESC='"+description+"' , ";
						sql = sql+ " DT_STARTDATE='"+sdate+"',";
						sql = sql+ " DAT_UPDATION='"+sdate+"',";
						sql = sql+ " DT_ENDDATE=( SELECT DATE_ADD('"+sdate+"', INTERVAL ("+amcperiod+"*365.25) DAY))  ,";
						sql = sql+ " INT_NOOFYEAR="+amcperiod+", ";
						sql = sql+ " DOU_AMCAMOUNT="+amcamount+" , ";
						sql = sql+ " CHR_STATUS='Y' ,"; 
						sql = sql+ " CHR_USRNAME='"+userid+"' , ";
						sql = sql+ " DT_UPDATEDATE=now() , ";
						sql = sql+ " CHR_UPDATESTATUS='Y'";
						sql =sql +" WHERE CHR_AMCID='"+amcid+"'";
						 
						st.execute(sql);
						st.close();
						con.close();    
						response.sendRedirect("Smart Inventory/amc.jsp");
					}
					else if(action.equals("INVServiceAMCDELETE"))
					{					
						 
						String custids[] = request.getParameterValues("id");
						for(int u=0; u<custids.length;u++)
						{
							sql = "DELETE FROM inv_m_serviceamc Where  CHR_AMCID = '"+(custids[u])+"'";
							st.execute(sql);
						}
						st.close();
						con.close();    
						response.sendRedirect("Smart Inventory/amc.jsp");
					}
					else if(action.equals("INVServiceAMCDELETEs"))
					{					
						 
						String custids[] = request.getParameterValues("id");
						for(int u=0; u<custids.length;u++)
						{
							sql = "DELETE FROM inv_m_serviceamc Where  INT_AMCID = "+(custids[u]);
							st.execute(sql);
						}
						st.close();
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
		
		
		@SuppressWarnings({ "unused", "deprecation" })
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
			catch (Exception e) 
			{
				System.out.println(e.getMessage());
				request.setAttribute("error", e.getMessage() );
		        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
		    	dispatchers.forward(request, response); 

			}
		
	}
		@SuppressWarnings({ "unused", "deprecation" })
		private void addDelete(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException 
		{
			try
			{
			
				String Amcid[] = request.getParameterValues("amcid");
				HttpSession session=request.getSession();			
				String userId=""+session.getAttribute("USRID");	
				java.text.SimpleDateFormat datetime = new java.text.SimpleDateFormat("dd-MM-yyyy");
				java.util.Date date = new java.util.Date();
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
			catch (Exception e) 
			{
				System.out.println(e.getMessage());
				request.setAttribute("error", e.getMessage() );
		        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
		    	dispatchers.forward(request, response); 

			}
		
			
			
	}	
		
		
		
		
		@SuppressWarnings({ "unused", "deprecation" })
		private void addUpdate(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException 
		{
			try
			{
				HttpSession session=request.getSession();			
				String userId=""+session.getAttribute("USRID");	
				java.text.SimpleDateFormat datetime = new java.text.SimpleDateFormat("dd-MM-yyyy");
				java.util.Date date = new java.util.Date();
				int year = 1900+date.getYear();
				String Amcid  = request.getParameter("amcid");
				String serialno = request.getParameter("serialno");
				String description = request.getParameter("description");
				String startdate = request.getParameter("startdate");
				String dt[] = startdate.split("-");
				String enddate= dt[0]+"-"+dt[1]+"-"+(Integer.parseInt(dt[2])+1);
				int warranty = Integer.parseInt(request.getParameter("warranty"));
				String amcamount = request.getParameter("amcamount");
				String sql ="";
				sql = " UPDATE inv_t_amc  SET " +
						"CHR_SERIALNO = '"+serialno+"' , CHR_WARRANTY ='"+warranty+"' ,  " +
								" CHR_AMCDESC = '"+description+"', " +
										" DT_STARTDATE='"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(startdate)+"' , DT_ENDDATE='"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(enddate)+"' WHERE  CHR_AMCID ='"+Amcid+"'  ";
				Statement ps=con.createStatement();
				ps.execute(sql);
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