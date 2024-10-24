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
 


public class StockAdjumentActionHandler extends AbstractActionHandler
{
		public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
		{
			try
			{
					String action=request.getParameter("actionS");
					if(action.equals("INVStockAdjument"))
					{					
						String length = request.getParameter("length");
						String bid = request.getParameter("bid");
						int l = Integer.parseInt(length);
						String sql = " UPDATE inv_t_stock SET  INT_STOCKINHAND=? WHERE CHR_TYPE='P' AND CHR_ITEMID=? AND  INT_BRANCHID=?" ;
						String sql1 = " UPDATE inv_t_averageprice SET  DOU_AVGPRICE=? WHERE CHR_TYPE='P' AND CHR_ITEMID=? AND  INT_BRANCHID=?" ;
						PreparedStatement pstm = con.prepareStatement(sql);
						PreparedStatement pstm1 = con.prepareStatement(sql1);
						for(int u=0; u<l;u++)
						{
							String pid = request.getParameter("pid"+(u+1));
							String pstock = request.getParameter("stockinhand"+(u+1));
							String pprice = request.getParameter("price"+(u+1));
							
							pstm.setString(1, pstock);
							pstm.setString(2, pid);
							pstm.setString(3, bid);	
							pstm.addBatch();
							
							pstm1.setString(1, pprice);
							pstm1.setString(2, pid);
							pstm1.setString(3, bid);	
							pstm1.addBatch();
							
							 
						}
						pstm.executeBatch();
						pstm1.executeBatch();
						pstm.close();
						pstm.close();
						con.close();    
						response.sendRedirect("Smart Inventory/InventoryMain.jsp");
					}
					else if(action.equals("INVAMCUpdate"))
					{					

						String length = request.getParameter("length");
						String bid = request.getParameter("bid");
						int l = Integer.parseInt(length);
						String pid="";
						String pstock="";
						String pprice="";
						String sql="";
						for(int u=0; u<l;u++)
						{
							pid = request.getParameter("pid"+(u+1));
							pstock = request.getParameter("stockinhand"+(u+1));
							pprice = request.getParameter("price"+(u+1));
							sql = " UPDATE inv_t_stock SET  INT_STOCKINHAND=" + pstock+" WHERE CHR_TYPE='P' AND CHR_ITEMID='"+pid+"' AND  INT_BRANCHID="+bid;
							com.my.org.erp.common.CommonFunctions.Execute(sql);
							 
							sql = " UPDATE inv_t_averageprice SET  DOU_AVGPRICE=" + pprice+" WHERE CHR_TYPE='P' AND CHR_ITEMID='"+pid+"' AND  INT_BRANCHID="+bid;
							//out.println(sql);
							com.my.org.erp.common.CommonFunctions.Execute(sql); 
							
						}
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
			catch (Exception e) 
			{
				System.out.println(e.getMessage());
				request.setAttribute("error", e.getMessage() );
		        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
		    	dispatchers.forward(request, response); 

			}
		
			
			
	}	
		
		
		
		
		 
		@SuppressWarnings("unused")
		private void addUpdate(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException 
		{
			try
			{
				 String Amcid  = request.getParameter("amcid");
				String serialno = request.getParameter("serialno");
				String description = request.getParameter("description");
				String startdate = request.getParameter("startdate");
				String dt[] = startdate.split("-");
				String enddate= dt[0]+"-"+dt[1]+"-"+(Integer.parseInt(dt[2])+1);
				int warranty = Integer.parseInt(request.getParameter("warranty"));
				 
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