package com.my.org.erp.SmartInventory;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class StockBookActionHandler extends AbstractActionHandler
{
		public synchronized void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
		{
			try
			{
					String action=request.getParameter("actionS");
					HttpSession session=request.getSession();			
					String userid=""+session.getAttribute("USRID");
					System.out.println("STOCK BOOK IN & OUT CREATED BY :"+userid.toUpperCase());
					if(action.equals("INVStockBookCreate"))
					{					
						String Branch = request.getParameter("Branch");
						String Producttype = request.getParameter("Producttype");
						String month = request.getParameter("month");
						String year = request.getParameter("year");
						String sql ="";
						String starting =year+"-"+month+"-01";
						String ending =year+"-"+month+"-"+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT DAY(LAST_DAY('"+starting+"'))")[0][0];
						 
						if("I".equals(Producttype))
						{
							sql = " SELECT CHR_ITEMID,CHR_ITEMNAME  FROM inv_m_item  WHERE INT_ACTIVE!=0  ORDER BY CHR_ITEMID ";
							String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
							acs = con.prepareCall("{call INV_PRO_STOCKBOOKCREATEITEM (?,?,?,?,?,?,?,? )}");
							for(int u=0;u<data.length;u++)
							{
								acs.setString(1, "INSERT");
								acs.setString(2, "");
								acs.setString(3, Branch);
								acs.setString(4, Producttype);
								acs.setString(5,  data[u][0]);
								acs.setString(6, starting);
								acs.setString(7, ending);
								acs.setString(8, userid);
								System.out.println("Branch : "+Branch+"Item :"+data[u][0] +" :"+(u+1)+"/"+data.length);
								asql = " SELECT COUNT(*) FROM inv_t_stockbookinandout WHERE  CHR_TYPE='I' AND CHR_PRODUCTCODE= '"+data[u][0]+"'  AND CHR_MONTH=MONTHNAME('"+starting+"') AND INT_YEAR=YEAR('"+starting+"') AND INT_BRANCHID= "+Branch;
								if(!com.my.org.erp.common.CommonFunctions.RecordExist(con, asql)) 
									acs.addBatch();
								
							}
							acs.executeBatch();
							acs.close();
							
						}
						else if("P".equals(Producttype))
						{
							try 
							{
								acs = con.prepareCall("{call INV_PRO_STOCKBOOKCREATE_PRODUCT_CURSOR (?,?,?,?)}");
								acs.setString(1, Branch);
								acs.setString(2, starting);
								acs.setString(3, ending);
								acs.setString(4, userid);
								System.out.println(""+acs);
								acs.execute();
								acs.close();
							} 
							catch (RuntimeException e) 
							{
								System.out.println(e.getMessage());
							}
							
						}
						
						
						 
						con.close();   
						response.sendRedirect("Smart Inventory/Rept_StockbookCreate.jsp");
					}
					else if(action.equals("INVStockBookCreateCompany"))
					{
						String Company = request.getParameter("Company");
						String Producttype = request.getParameter("Producttype");
						String month = request.getParameter("month");
						String year = request.getParameter("year");
						String sql ="";
						String starting =year+"-"+month+"-01";
						String ending =year+"-"+month+"-"+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT DAY(LAST_DAY('"+starting+"'))")[0][0];
						if("0".equals(Company))
							asql = "SELECT INT_BRANCHID FROM com_m_branch    ORDER BY INT_BRANCHID ";
						else
							asql = " SELECT INT_BRANCHID FROM com_m_branch  WHERE INT_COMPANYID="+Company+" ORDER BY INT_BRANCHID ";
						String Branchids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(asql);
						String s="";
						for(int h=0;h<Branchids.length;h++)
							s = s+Branchids[h][0]+",";
						
						String Branch[] =s.split(",");
						
						if("I".equals(Producttype))
						{
							
							sql = " SELECT CHR_ITEMID,CHR_ITEMNAME  FROM inv_m_item  WHERE INT_ACTIVE!=0  ORDER BY CHR_ITEMID ";
							String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
							
							for(int b=0; b<Branch.length-1;b++)
							{
								acs = con.prepareCall("{call INV_PRO_STOCKBOOKCREATEITEM (?,?,?,?,?,?,?,? )}");
								for(int u=0;u<data.length;u++)
								{
									
									acs.setString(1, "INSERT");
									acs.setString(2, "");
									acs.setString(3, Branch[b]);
									acs.setString(4, Producttype);
									acs.setString(5,  data[u][0]);
									acs.setString(6, starting);
									acs.setString(7, ending);
									acs.setString(8, userid);
									asql = " SELECT COUNT(*) FROM inv_t_stockbookinandout WHERE  CHR_TYPE='I' AND CHR_PRODUCTCODE= '"+data[u][0]+"'  AND CHR_MONTH=MONTHNAME('"+starting+"') AND INT_YEAR=YEAR('"+starting+"') AND INT_BRANCHID= "+Branch[b];
									if(!com.my.org.erp.common.CommonFunctions.RecordExist(con, asql)) 
										acs.addBatch();
									
									System.out.println("Branch : "+Branch+"Item :"+data[u][0] +" :"+(u+1)+"/"+data.length);
									 
									
								}
								acs.executeBatch();
								acs.close();
							}
							
						}
						else if("P".equals(Producttype))
						{
							sql ="SELECT CHR_PRODUCTID,CHR_PRODUCTCODE  FROM inv_m_produtlist  WHERE INT_ACTIVE!=0 AND CHR_PTYPE!='S'   ORDER BY CHR_PRODUCTID ";
							String pdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
							
							
							for(int b=0; b<Branch.length-1;b++)
							{
								acs = con.prepareCall("{call INV_PRO_STOCKBOOKCREATEPRODUCT (?,?,?,?,?,?,?,? )}");
								for(int u=0;u<pdata.length;u++)
								{
									acs.setString(1, "INSERT");
									acs.setString(2, "");
									acs.setString(3, Branch[b]);
									acs.setString(4, Producttype);
									acs.setString(5,  pdata[u][0]);
									acs.setString(6, starting);
									acs.setString(7, ending);
									acs.setString(8, userid);
									asql = " SELECT COUNT(*) FROM inv_t_stockbookinandout WHERE  CHR_TYPE='P'  AND CHR_PRODUCTCODE= '"+pdata[u][0]+"' AND CHR_MONTH=MONTHNAME('"+starting+"') AND INT_YEAR=YEAR('"+starting+"')  AND INT_BRANCHID= "+Branch[b];
									if(!com.my.org.erp.common.CommonFunctions.RecordExist(con, asql)) 
										acs.addBatch();
									System.out.println("Branch : "+Branch+"Item :"+pdata[u][0] +" :"+(u+1)+"/"+pdata.length);
								}
								acs.executeBatch();
								acs.close();
							}
						}
						
						con.close();    
						response.sendRedirect("Smart Inventory/Rept_StockbookCreateCompanywise.jsp");
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
		
		
		
		 
 
 