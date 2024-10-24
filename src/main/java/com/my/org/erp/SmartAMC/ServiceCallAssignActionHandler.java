package com.my.org.erp.SmartAMC;
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
 


public class ServiceCallAssignActionHandler extends AbstractActionHandler
{
		public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
		{
			try
			{
					String action=request.getParameter("actionS");
					String sql="";
					HttpSession session=request.getSession();			
					String userid=""+session.getAttribute("USRID");
					Statement st = con.createStatement();
					if(action.equals("AMCServiceCallAssignAdd"))
					{					
						String callid  = request.getParameter("callid");
						String ename  = request.getParameter("ename");
						String startdate = request.getParameter("startdate");
						String reassign = request.getParameter("reassign");
						String stdate[] = startdate.split(" ");
						String sdate = DateUtil.FormateDateSQL(stdate[0])+" "+stdate[1];

						sql = " UPDATE inv_t_servicecallbooking SET ";
						if("Y".equals(reassign))
						{	
							sql = sql +" CHR_ENGGSTATUS='R',";
						}	
						else
						{	
							sql = sql+ " CHR_ENGGSTATUS='Y' , ";
							sql = sql+ " DT_ASSIGNDATE='"+sdate+"' , ";
						}	
						
						sql = sql+ " CHR_BOOKINGEMPID='"+ename+"' , ";
						sql = sql+ " CHR_STATUS='P' , ";
						sql = sql+ " CHR_USRNAME='"+userid+"' , ";
						sql = sql+ " DT_UPDATEDATE=now() , ";
						sql = sql+ " CHR_UPDATESTATUS='Y'";
						sql =sql +" WHERE CHR_SERVICECALLNO='"+callid+"'";
						st.execute(sql);
						st.close();
						con.close();   
						response.sendRedirect("Smart AMC/servicecallassign.jsp");
					}
					else if(action.equals("AMCServiceCallAssignHistoryAdd"))
					{					
						String callid  = request.getParameter("callid");
						String empid  = request.getParameter("empid");
						String serial  = request.getParameter("serial");
						String assigndt  = request.getParameter("assigndt");
						
						String startdate = request.getParameter("startdate");
						String stdate[] = startdate.split(" ");
						String sdate = DateUtil.FormateDateSQL(stdate[0])+" "+stdate[1];
						String enddate = request.getParameter("enddate");
						String eddate[] = enddate.split(" ");
						String edate = DateUtil.FormateDateSQL(eddate[0])+" "+eddate[1];
						@SuppressWarnings("unused")
						String close = request.getParameter("close");
						String description = request.getParameter("description");
						String Spare = request.getParameter("Spare");
						String cperson = request.getParameter("cperson");
						String cmobile = request.getParameter("cmobile");
						String caddress = request.getParameter("caddress");
						String cemail = request.getParameter("cemail");
						String callstatus = request.getParameter("callstatus");
						String spare = request.getParameter("spare");
						
						sql = " INSERT INTO inv_t_servicecallbookingtrack ( CHR_SERVICECALLNO,CHR_EMPID,CHR_SERIALNO,DT_ASSIGNDATE,DT_ATTENDATE,DT_CLOSEDATE, CHR_CALLSTATUS,CHR_ENGGDESC,CHR_SPARE,CHR_SPAREDESC,CHR_CONTACTPERSON, CHR_CONTACTADDRESS, CHR_CONTACTMOBILE,  CHR_CONTACTEMAIL,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS )";
						sql = sql + " VALUES (";
						sql = sql + " '"+callid+"' , ";
						sql = sql + " '"+empid+"' , ";
						sql = sql + " '"+serial+"' , ";
						sql = sql + " '"+assigndt+"' , ";
						sql = sql + " '"+sdate+"' , ";
						sql = sql + " '"+edate+"' , ";
						sql = sql + " '"+callstatus+"' , ";
						sql = sql + " '"+description+"' , ";
						sql = sql + " '"+Spare+"' , ";
						sql = sql + " '"+spare+"' , ";
						sql = sql + " '"+cperson+"' , ";
						sql = sql + " '"+cmobile+"' , ";
						sql = sql + " '"+caddress+"' , ";
						sql = sql + " '"+cemail+"' , ";
						sql = sql + " '"+userid+"' , now(), 'Y' )";
						 
						st.execute(sql);
						//"Y".equals(close) &&
						if( "5".equals(callstatus) )
						{
							sql = "UPDATE inv_t_servicecallbooking SET DT_CLOSINGDATE='"+edate+"' , CHR_STATUS='C' WHERE CHR_SERVICECALLNO='"+callid+"'";
							st.execute(sql);
						}
						st.close();
						con.close();   
						response.sendRedirect("Smart AMC/servicecallassign.jsp");
					}
					else if(action.equals("AMCServiceCallAssignHistoryDELETE"))
					{					
						 
						String Bookingid= request.getParameter("Bookingid");
						sql = "DELETE FROM inv_t_servicecallbookingtrack WHERE CHR_SERVICECALLNO='"+Bookingid+"'";
						st.execute(sql);
						sql = " UPDATE  inv_t_servicecallbooking SET DT_ASSIGNDATE =null , DT_CLOSINGDATE =null,	CHR_STATUS='N' ,CHR_ENGGSTATUS='N'";
						sql = sql +" WHERE CHR_SERVICECALLNO='"+Bookingid+"'";
						st.execute(sql);
						st.close();
						con.close();   
						response.sendRedirect("Smart AMC/servicecallassign.jsp");
					}
					else if(action.equals("AMCServiceCallAssignHistoryCancell"))
					{					
						 
						
						String Bookingid= request.getParameter("Bookingid");
						sql = "DELETE FROM inv_t_servicecallbookingtrack WHERE CHR_SERVICECALLNO='"+Bookingid+"'";
						//st.execute(sql);
						sql = " UPDATE  inv_t_servicecallbooking SET CHR_STATUS='R' ";
						sql = sql +" WHERE CHR_SERVICECALLNO='"+Bookingid+"'";
						st.execute(sql);
						st.close();
						con.close();    
						response.sendRedirect("Smart AMC/servicecallassign.jsp");
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