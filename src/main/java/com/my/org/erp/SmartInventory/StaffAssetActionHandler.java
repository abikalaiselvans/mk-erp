package com.my.org.erp.SmartInventory;
import java.io.IOException;
 
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
 
import com.my.org.erp.common.CommonFunctions;
public class StaffAssetActionHandler extends AbstractActionHandler
{
	public synchronized  void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{		
		try
		{
				String action=""+request.getParameter("actionS").trim();
				HttpSession session=request.getSession();			
				String userid=""+session.getAttribute("USRID");
				String branchid = session.getAttribute("INVBRANCH").toString();
				String sqlDate = DateUtil.getCurrentDate();
				String empid =request.getParameter("ename");
				String SerialNumber =request.getParameter("SerialNumber");
				String Descrip =request.getParameter("Descrip");
				String Approvedby =request.getParameter("Approvedby");
				String oldserial=""+request.getParameter("oldserial") ;
				String sql = "SELECT CHR_TYPE,CHR_ITEMID FROM inv_t_vendorgoodsreceived WHERE CHR_SERIALNO='"+SerialNumber+"'";
				String itemTypeData[][] =CommonFunctions.QueryExecute(sql);
				if("INVStaffAssetAssign".equals(action))
				{
					asql = " INSERT INTO inv_t_asset (INT_BRANCHID,CHR_EMPID,CHR_TYPE,CHR_ITEMID,";
					asql = asql +" CHR_SERIALNO,CHR_DESCRIPTION,DAT_CREATIONDATE,CHR_AUTHORISEDBY,CHR_STATUS,";
					asql = asql +" CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS ) VALUES ";
					asql = asql +" (?,?,?,?,?,?,?,?,?,?,NOW(),'Y')";
					apstm = con.prepareStatement(asql);
					apstm.setInt(1,Integer.parseInt(branchid));
					apstm.setString(2,empid);
					apstm.setString(3,itemTypeData[0][0]);
					apstm.setString(4,itemTypeData[0][1] );
					apstm.setString(5,SerialNumber);
					apstm.setString(6,Descrip);
					apstm.setString(7,sqlDate);
					apstm.setString(8,Approvedby);
					apstm.setString(9,"N");
					apstm.setString(10,userid);
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
					
					asql = "UPDATE inv_t_vendorgoodsreceived SET CHR_FLAG=? WHERE CHR_TYPE=? AND CHR_ITEMID=? AND CHR_SERIALNO=?";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,"A");
					apstm.setString(2,itemTypeData[0][0]);
					apstm.setString(3,itemTypeData[0][1]);
					apstm.setString(4,SerialNumber);
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
					con.close();   
					response.sendRedirect("Smart Inventory/StaffAsset.jsp");
				}
				else if("INVStaffAssetEdit".equals(action))
				{
					
					
					String Rowid=""+request.getParameter("Rowid").trim();
					asql= " UPDATE  inv_t_asset SET CHR_TYPE=?,CHR_ITEMID= ? ,";
					asql = asql+"	CHR_SERIALNO = ?,";
					asql = asql+"	CHR_DESCRIPTION = ? ,";
					asql = asql+"	CHR_AUTHORISEDBY = ? ";
					asql = asql+"	WHERE  INT_ASSETID = ? ";
					asql = asql+"	AND  CHR_STATUS = ? ";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,itemTypeData[0][0]);
					apstm.setString(2,itemTypeData[0][1]);
					apstm.setString(3,SerialNumber);
					apstm.setString(4,Descrip);
					apstm.setString(5,Approvedby);
					apstm.setString(6,Rowid);
					apstm.setString(7,"N");
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
					
					if(oldserial != SerialNumber)
					{
						sql = "SELECT CHR_TYPE,CHR_ITEMID FROM inv_t_vendorgoodsreceived WHERE CHR_SERIALNO='"+oldserial+"'";
						String oldItemTypeData[][] =CommonFunctions.QueryExecute(sql);
						
						asql = "UPDATE inv_t_vendorgoodsreceived SET CHR_FLAG=? WHERE CHR_TYPE=? AND CHR_ITEMID=? AND CHR_SERIALNO=?";
						apstm = con.prepareStatement(asql);
						apstm.setString(1,"N");
						apstm.setString(2,oldItemTypeData[0][0]);
						apstm.setString(3,oldItemTypeData[0][1]);
						apstm.setString(4,oldserial);
						System.out.println(""+apstm);
						apstm.execute();
						apstm.close();
						
						asql = "UPDATE inv_t_vendorgoodsreceived SET CHR_FLAG=? WHERE CHR_TYPE=? AND CHR_ITEMID=? AND CHR_SERIALNO=?";
						apstm = con.prepareStatement(asql);
						apstm.setString(1,"A");
						apstm.setString(2,itemTypeData[0][0]);
						apstm.setString(3,itemTypeData[0][1]);
						apstm.setString(4,SerialNumber);
						System.out.println(""+apstm);
						apstm.execute();
						apstm.close();
					}	
					con.close();    
					response.sendRedirect("Smart Inventory/StaffAsset.jsp");
				}
				else if("INVStaffAssetDELETE".equals(action))
				{
					try
					{
						String Rowid[] = request.getParameterValues("Rowid");
						asql = " DELETE FROM inv_t_asset WHERE CHR_STATUS = ? AND INT_ASSETID = ? AND DATEDIFF(NOW(),DAT_CREATIONDATE)<=2";
						apstm = con.prepareStatement(asql);
						for(int u=0; u<Rowid.length;u++)
						{
							apstm.setString(1,"N" );
							apstm.setString(2,Rowid[u] );
							System.out.println(""+apstm);
							apstm.addBatch();
							
							sql="SELECT CHR_TYPE,CHR_ITEMID,CHR_SERIALNO FROM inv_t_asset  WHERE  INT_ASSETID="+Rowid[u];
							String data[][]= CommonFunctions.QueryExecute(sql);
							if(data.length>0)
							{
								sql = "UPDATE inv_t_vendorgoodsreceived SET CHR_FLAG='N' WHERE CHR_TYPE='"+data[0][0]+"' AND CHR_ITEMID='"+data[0][1]+"' AND CHR_SERIALNO='"+data[0][2]+"'";
								System.out.println(sql);
								CommonFunctions.Execute(sql);
							}	
						}
						apstm.executeBatch();
						apstm.close();
						con.close();    
						response.sendRedirect("Smart Inventory/StaffAsset.jsp");
					}
					catch(Exception e)
					{

						System.out.println(e.getMessage());
						request.setAttribute("error", e.getMessage() );
			            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
			    		dispatchers.forward(request, response); 
						
					}
						
				}
				
				else if("INVStaffAssetReceived".equals(action))
				{
					
					String Rowid=""+request.getParameter("Rowid").trim();
					String Status=request.getParameter("Status").trim();
					String ReceivedBy=request.getParameter("ReceivedBy").trim();
					String ReceivedDate=request.getParameter("ReceivedDate").trim();
					ReceivedDate=DateUtil.FormateDateSQL(ReceivedDate);
					String Description=request.getParameter("Description").trim();
					
					sql="SELECT CHR_TYPE,CHR_ITEMID,CHR_SERIALNO FROM inv_t_asset  WHERE  INT_ASSETID="+Rowid;
					String data[][]= CommonFunctions.QueryExecute(sql);
					
					
					asql= " UPDATE  inv_t_asset SET CHR_STATUS= ? ,";
					asql = asql+"	CHR_RECIVEDBY = ?,";
					asql = asql+"	DAT_RECIVEDDATE = ?, CHR_USRNAME=?,DT_UPDATEDATE=DATE(NOW()),";
					asql = asql+"	CHR_RECEIVEDDESCRIPTION = ?";
					asql = asql+"	WHERE  INT_ASSETID = ? ";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,Status);
					apstm.setString(2,ReceivedBy);
					apstm.setString(3,ReceivedDate);
					apstm.setString(4,auserid);
					apstm.setString(5,Description);
					apstm.setString(6,Rowid);
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
					
					asql = "UPDATE inv_t_vendorgoodsreceived SET CHR_FLAG=? WHERE CHR_TYPE=? AND CHR_ITEMID=? AND CHR_SERIALNO=?";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,"N");
					apstm.setString(2,data[0][0]);
					apstm.setString(3,data[0][1]);
					apstm.setString(4,data[0][2]);
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
					
					con.close();
					response.sendRedirect("Smart Inventory/StaffAsset.jsp");
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
