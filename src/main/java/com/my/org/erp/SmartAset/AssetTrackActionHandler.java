package com.my.org.erp.SmartAset;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;
 
public class AssetTrackActionHandler extends AbstractActionHandler
{
	String sql="";
	public synchronized void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{		
		try
		{
				String action=""+request.getParameter("actionS").trim();
				HttpSession session=request.getSession();			
				String user = session.getAttribute("USRID").toString();
				Statement st = con.createStatement();
				//25300000
				if("ASSAssetTrackAdd".equals(action))
				{
					String Branch = request.getParameter("Branch");
					String divis = request.getParameter("divis");
					String customerId = request.getParameter("customerId");
					String Shipping = request.getParameter("Shipping");
					String shippingaddress = request.getParameter("shippingaddress");
					String saledate = request.getParameter("saledate");
					saledate= DateUtil.FormateDateSQL(saledate);
					String salenumber = request.getParameter("salenumber");
					String ref = request.getParameter("ref");
					CallableStatement cs = con.prepareCall("{call ASSET_PRO_ASSETS(?,?,?,?,?,?,?,?,?,?,?,?)}");
					cs.setString(1, "INSERT");
					cs.setString(2, "");
					cs.setString(3, Branch);		
					cs.setString(4, divis);
					cs.setString(5, customerId);
					cs.setString(6, Shipping);
					cs.setString(7, shippingaddress);
					cs.setString(8, saledate);
					cs.setString(9, salenumber);
					cs.setString(10, ref);
					cs.setString(11, "N");
					cs.setString(12, user);
					cs.execute();
					cs.close();
					String  assetid = CommonFunctions.QueryExecute("SELECT MAX(INT_ASSETID) FROM asset_t_asset")[0][0];
					String param[] = request.getParameter("param").split(",");
					for(int u=0;u<param.length;u++)
					{
						String Item = request.getParameter("Item"+param[u]);
						String Quantity = request.getParameter("Quantity"+param[u]);
					 	cs = con.prepareCall("{call ASSET_PRO_ASSETQTY(?,?,?,?,?,?,?,? )}");
						cs.setString(1, "INSERT");
						cs.setString(2, "");
						cs.setString(3, assetid);		
						cs.setString(4, Item);
						cs.setString(5, "I");
						cs.setString(6, Quantity);
						cs.setString(7, salenumber);
						cs.setString(8, user);
						cs.execute();
						cs.close();
						
						int qty = Integer.parseInt(Quantity);
						CallableStatement cs1 = con.prepareCall("{call ASSET_PRO_ASSETSERIAL(?,?,?,?,?,?,?,?,? )}");
						 
						for(int h=0;h<qty;h++)
						{
							cs1.setString(1, "INSERT");
							cs1.setString(2, "");
							cs1.setString(3, Branch);
							cs1.setString(4, Item);
							cs1.setString(5, "I");
							cs1.setString(6,  salenumber);
							cs1.setString(7,  "");
							cs1.setString(8,  "N");
							cs1.setString(9, user);
						 
							cs1.addBatch();
						}
						cs1.executeBatch();
						cs1.close();
					}
					response.sendRedirect("Smart Asset/AssetTrackSerial.jsp?assetid="+assetid );
					
				}
				else if("ASSAssetTrackSerialAdd".equals(action))
				{
					try 
					{
						String param = request.getParameter("param");
						String salenumber = request.getParameter("salenumber");
						String salesdate = request.getParameter("saledate");
						String assetid = request.getParameter("assetid");
						int count= Integer.parseInt(param);
						String customerid = request.getParameter("customerId");
						String addressflag = request.getParameter("Shipping");
						String address = request.getParameter("shippingaddress");
						for(int u=0;u<count;u++)
						{
							String rowid=request.getParameter("rowid"+(u+1));
							String serial=request.getParameter("serial"+(u+1));
							sql=" UPDATE asset_t_assetserial SET CHR_SERIALNUMBER='"+serial+"' , CHR_STATUS='Y' WHERE INT_SERIALID="+rowid;
							st.execute(sql);
							sql = " UPDATE asset_t_assetserilano SET CHR_ADDRESSFLAG='"+addressflag+"', CHR_ADDRESS='"+address+"' ,  CHR_FLAG='Y', INT_CUSTOMERID="+customerid+" , DT_SALES='"+DateUtil.FormateDateSQL(salesdate)+"' , CHR_SALEINVOICE='"+salenumber+"'  WHERE CHR_SERIALNUMBER='"+serial+"' ";
							st.execute(sql);
						}
						sql = "UPDATE asset_t_asset SET CHR_STATUS='Y' WHERE INT_ASSETID="+assetid;
						st.execute(sql);
						st.close();
						con.close();
						response.sendRedirect("Smart Asset/AssetTrack.jsp" );
					}
					catch (RuntimeException e) 
					{
					
						e.printStackTrace();
						
					}
				}	
				else if("INVAssetTrackSerialUpdate".equals(action))
				{ 
					String rowid = request.getParameter("rowid");
					String serial = request.getParameter("serial1");
					String oldserial = request.getParameter("oldserial");
					
					sql = "UPDATE inv_t_assetserial SET CHR_SERIALNUMBER='"+serial+"' WHERE INT_SERIALID= "+ rowid;
					st.execute(sql);
					sql = "UPDATE inv_t_assetserilano SET CHR_FLAG='N' WHERE CHR_SERIALNUMBER='"+oldserial+"'";
					st.execute(sql);
					sql = "UPDATE inv_t_assetserilano SET CHR_FLAG='Y' WHERE CHR_SERIALNUMBER='"+serial+"'";
					st.execute(sql);
					
					
					//9841344716
					
					
					//sql = " SELECT INT_CUSTOMERID,CHR_ADDRESSFLAG,CHR_ADDRESS,DT_SALES,CHR_SALEINVOICE WHERE CHR_SERIALNUMBER='"+oldserial+"'";
					//String data[][] = com.mmi.common.CommonFunctions.QueryExecute(sql);
					//sql = "UPDATE inv_t_assetserilano SET CHR_FLAG='Y', INT_CUSTOMERID="+data[0][0]+" , CHR_ADDRESSFLAG='"+data[0][1]+"',  CHR_SALEINVOICE='"+data[0][3]+"'  WHERE CHR_SERIALNUMBER='"+serial+"'";
					//st.execute(sql);
					con.close();
					response.sendRedirect("Smart Inventory/AssetTrack.jsp" );
					
				}
				else if("INVAssetTrackDelete".equals(action))
				{ 
					String ids[] = request.getParameterValues("assetid");
					CallableStatement cs = con.prepareCall("{call INVENTORY_PRO_ASSETS(?,?,?,?,?,?,?,?,?,?,?,?)}");
					

					//inv_t_asset
					//inv_t_assetqty
					//inv_t_assetserial
					
					for(int u=0;u<ids.length;u++)
					{
						cs.setString(1, "DELETE");
						cs.setString(2, ids[0]);
						cs.setString(3, "");		
						cs.setString(4, "");
						cs.setString(5, "");
						cs.setString(6, "");
						cs.setString(7, "");
						cs.setString(8, "");
						cs.setString(9, "");
						cs.setString(10, "");
						cs.setString(11, "");
						cs.setString(12, "");
						 ;
						cs.addBatch();
					}
					cs.executeBatch();
					cs.close();
					response.sendRedirect("Smart Inventory/AssetTrack.jsp" );
					
				}
				else if("INVAssetSerialReturntoStock".equals(action))
				{ 
					String length = request.getParameter("dec");
					int rowcount = Integer.parseInt(length);
					String serial="";
					String returnstock=""; 
					String sql = "";
					String rowid="";
					for(int u=0;u<rowcount;u++)
					{
						rowid = request.getParameter("rowid"+u);
						serial = request.getParameter("serial"+u);
						returnstock = ""+request.getParameter("accept"+u);
						if("on".equals(returnstock)) 
						{
							sql = " UPDATE inv_t_assetserilano  SET CHR_FLAG ='N',  INT_CUSTOMERID=0,  CHR_ADDRESSFLAG ='', CHR_ADDRESS='' , DT_SALES=null,  CHR_SALEINVOICE=null  WHERE CHR_SERIALNUMBER='"+serial+"'";
							 
							CommonFunctions.Execute(sql);
							sql = " UPDATE inv_t_assetserial  SET CHR_RETURNTOSTOCK ='Y' ,  DT_RETURNDATE=now() WHERE INT_SERIALID="+rowid+"  AND CHR_SERIALNUMBER='"+serial+"'";
							CommonFunctions.Execute(sql);
							 
						}	
					
					}
					response.sendRedirect("Smart Inventory/AssetTrack.jsp" );
					
				}
				
				 
				st.close();
						
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


