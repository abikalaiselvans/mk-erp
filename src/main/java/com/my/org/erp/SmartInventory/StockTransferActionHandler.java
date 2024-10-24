package com.my.org.erp.SmartInventory;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLWarning;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
  
import com.my.org.erp.common.CommonFunctions; 
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;

public class StockTransferActionHandler extends AbstractActionHandler
{
	 
	public static void  itemInsert(HttpServletRequest request,HttpServletResponse response, String quoId ,java.sql.PreparedStatement apstm ,Connection con)throws ServletException, IOException 
	{
		try 
		{
			 
			String sql="";			
			HttpSession session=request.getSession();			
			String userId=""+session.getAttribute("USRID");
			@SuppressWarnings("unused")
			String branchid = session.getAttribute("BRANCHID").toString();
			String param[] = request.getParameter("param").split(",");
			int qty=0;
			String itemname="";
			String itype="";
		 	for(int p=0;p<param.length; p++)
			{
				itemname="";
				itype="";
				itemname=request.getParameter("item"+param[p].trim());
				itype= request.getParameter("itype"+param[p].trim());
				String consumables =""+request.getParameter("consumables"+param[p].trim());
				if(itype.equals("1"))
					itype="I";
				if(itype.equals("2"))
					itype="P";
				qty =0;
				qty = Integer.parseInt(request.getParameter("qty"+param[p].trim()));
				
				
				sql=" INSERT INTO inv_t_stocktransferitem ( ";
				sql = sql +" CHR_STOCKTRANSFERID,CHR_ITEMID,CHR_TYPE,INT_QUANTITY, " ;
				sql = sql +" CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS,CHR_PTYPE )";
				sql = sql +" VALUES ( ";
				sql = sql +" ?,?,?,?, " ;
				sql = sql +" ?,DT_UPDATEDATE,CHR_UPDATESTATUS,?  ";
				sql = sql +" ) ";
				apstm = con.prepareStatement(sql);
				apstm.setString(1, quoId);
				apstm.setString(2, itemname);
				apstm.setString(3, itype);
				apstm.setString(4, ""+qty);
				apstm.setString(5, userId);
				apstm.setString(6, consumables);
				System.out.println(""+apstm);
				apstm.execute();
				apstm.close();
				
				//update stock value;
				sql =  " SELECT a.INT_ID,a.CHR_TYPE,a.CHR_ITEMID, "; 
				sql = sql + " IF( a.CHR_TYPE ='I' ,(SELECT FUN_INV_BRANCH_STOCK_AVERAGEPRICE(a.CHR_TYPE,a.CHR_ITEMID,b.INT_BRANCHID_FROM)), ";
				sql = sql + "      IF(   ";
				sql = sql + " (SELECT sa4.CHR_PTYPE FROM inv_m_produtlist sa4 WHERE sa4.CHR_PRODUCTID =a.CHR_ITEMID)= 'S', ";
				sql = sql + "  FUN_GET_OVERALL_AVERAGEPRICE(a.CHR_ITEMID ) ,  ";
				sql = sql + " FUN_INV_BRANCH_STOCK_AVERAGEPRICE(a.CHR_TYPE,a.CHR_ITEMID,b.INT_BRANCHID_FROM) ";  
				sql = sql + " ) ";
				sql = sql + " ) averageprice ";
				sql = sql + " FROM inv_t_stocktransferitem a, inv_t_stocktransfer b ";
				sql = sql + " WHERE a.CHR_STOCKTRANSFERID = b.CHR_STOCKTRANSFERID  ";
				sql = sql + " AND a.CHR_STOCKTRANSFERID ='"+quoId+"' ";
				String data[][] = CommonFunctions.QueryExecute(sql);
				if(data.length>0)
				{
					sql = " UPDATE inv_t_stocktransferitem SET DOU_AVERAGEPRICE= ? ";
					sql = sql + " WHERE INT_ID =? AND CHR_TYPE =? AND  CHR_ITEMID=? ";
					apstm = con.prepareStatement(sql);
					for(int y=0;y<data.length;y++)
					{
						apstm.setString(1, data[y][3]);
						apstm.setString(2, data[y][0]);
						apstm.setString(3, data[y][1]);
						apstm.setString(4, data[y][2]);
						System.out.println(""+apstm);
						apstm.addBatch();
					}
					apstm.executeBatch();
					apstm.close();
				}
				 
				
				if(!consumables.equals("S"))
				{
					for (int u = 0; u < qty; u++) 
					{
						
						sql = "INSERT INTO inv_t_stocktransferitemserial "
							+ " ( CHR_STOCKTRANSFERID,CHR_ITEMID,CHR_TYPE,"
							+ " CHR_USRNAME,DT_UPDATEDATE,"
							+ " CHR_UPDATESTATUS ) VALUES (";					
						sql = sql +"?,?,?,?,DATE(now()) , 'Y' ) ";
						apstm = con.prepareStatement(sql);
						apstm.setString(1, quoId);
						apstm.setString(2, itemname);
						apstm.setString(3, itype);
						apstm.setString(4, userId);
						System.out.println(""+apstm);
						apstm.execute();
						apstm.close();
						
					}
				}		
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
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	 {
		try
		{
				String action=request.getParameter("actionS");
				HttpSession session=request.getSession();			
				String userId=""+session.getAttribute("USRID");
				String branchid = session.getAttribute("INVBRANCH").toString();
				Statement st = con.createStatement();
				String sql="";
				
				if("INVStockTransAdd".equals(action))
				{
					sql="";
					String collectname = "";
					collectname = collectname+"transNumber,transDate,fromBranch,toBranch,memo,totals,";
					String transDate = ""+request.getParameter("transDate");
					transDate = DateUtil.FormateDateSQL(transDate);
					String fromBranch = ""+request.getParameter("fromBranch");
					String toBranch = ""+request.getParameter("toBranch");
					String transferBy = request.getParameter("transferBy");
					String memo = ""+request.getParameter("memo");
					String divisionid = ""+request.getParameter("division");  
					 
					//sql =" SELECT LEFT(upper(CHR_BRANCHNAME),3) from com_m_branch WHERE INT_BRANCHID=" +fromBranch;
					//String frmname[][] =CommonFunctions.RecordSetArray(con,sql);
					//sql =" SELECT LEFT(upper(CHR_BRANCHNAME),3) from com_m_branch WHERE INT_BRANCHID=" +toBranch;
					//String toname[][] = CommonFunctions.RecordSetArray(con,sql);
					
					//String id="STK/"+InventoryInvoiceFunctions.accountYear()+InventoryInvoiceFunctions.stockTransferNumber()+"/"+frmname[0][0]+"/"+toname[0][0];
					
					String id=InventoryInvoiceFunctions.stockTransferNumberGet(fromBranch, toBranch);
					String field="( CHR_STOCKTRANSFERID,INT_BRANCHID_FROM," +
					" INT_BRANCHID_TO,DAT_TRANSFERDATE,CHR_TRANSFERBY,CHR_DES," +							
					" INT_STATUS,INT_DIVIID,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS )";
					asql = "INSERT INTO inv_t_stocktransfer "+field+" VALUES (";
					asql = asql +"?,";
					asql = asql +"?,";
					asql = asql +"?,";
					asql = asql +"?,";
					asql = asql +"?,";
					asql = asql +"?,0,";
					asql = asql +"?,";
					asql = asql +"?,";
					asql = asql +" now() , 'Y' )";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,id);
					apstm.setString(2,fromBranch);
					apstm.setString(3,toBranch);
					apstm.setString(4,transDate);
					apstm.setString(5,transferBy);
					apstm.setString(6,memo);
					apstm.setString(7,divisionid);
					apstm.setString(8,auserid);
					apstm.execute();
					apstm.close();
					itemInsert(request,response,id,apstm,con);	
					
					
					//sql=" INSERT INTO inv_m_stocktransfergenerate   VALUES ("+InventoryInvoiceFunctions.stockTransferNumber()+")";
					
					asql =" SELECT FUN_INV_STOCK_TRANSFER_NUMBER_INSERT() ";
					apstm=con.prepareStatement(asql);
					System.out.println(""+apstm);
					apstm.execute();
					con.close();    
					response.sendRedirect("Smart Inventory/StockTransOrderSerialno.jsp?transferId="+id);
				}
				else if("INVStockTransSerialAdd".equals(action))
				{
					String transNo = request.getParameter("transNo");
					String seriallength= request.getParameter("seriallength");
					boolean f =false;;
					if(Integer.parseInt(seriallength)>=1)
						f =  checkSerialNumberSale(request, response);
					System.out.println(""+f);
					
					if(Integer.parseInt(seriallength)>=1)
					{
						if(f)
						{
	
							for(int u=1;u<=Integer.parseInt(seriallength);u++)
							{
								String id =request.getParameter("rowid"+u);
								String itemid =request.getParameter("itemid"+u);
								String itype =request.getParameter("itype"+u);
								String serial = request.getParameter("serial"+u);
								String Warranty = request.getParameter("Warrantys"+u);
								asql = "UPDATE inv_t_stocktransferitemserial SET";
								asql = asql+" CHR_SERIALNO =?  ,";	
								asql = asql+" CHR_WARRANTY =? ";	
								asql = asql+" WHERE INT_ID=?  AND CHR_STOCKTRANSFERID=? ";
								asql = asql+" AND CHR_ITEMID=?";
								asql = asql+" AND CHR_TYPE=?";
								apstm = con.prepareStatement(asql);
								apstm.setString(1,serial);
								apstm.setString(2,Warranty);
								apstm.setString(3,id);
								apstm.setString(4,transNo);
								apstm.setString(5,itemid);
								apstm.setString(6,itype);
								System.out.println(""+apstm);
								apstm.execute();
								apstm.close();
								
								//update goodsreceived table goods are in transfer mode
								asql = "UPDATE inv_t_vendorgoodsreceived SET";
								asql = asql+" CHR_FLAG ='T'  ";
								asql = asql+" WHERE  CHR_SERIALNO =? ";
								asql = asql+" AND CHR_ITEMID=?";
								asql = asql+" AND CHR_TYPE=?";
								apstm = con.prepareStatement(asql);
								apstm.setString(1,serial);
								apstm.setString(2,itemid);
								apstm.setString(3,itype);
								System.out.println(""+apstm);
								apstm.execute();
								apstm.close();
			 				}
							asql=" UPDATE inv_t_stocktransfer SET INT_TRANSFERSTATUS=1 WHERE CHR_STOCKTRANSFERID=? ";
							apstm = con.prepareStatement(asql);
							apstm.setString(1,transNo);
							System.out.println(""+apstm);
							apstm.execute();
							apstm.close();
							con.close();   
							response.sendRedirect("Smart Inventory/StockTransSerialPirnt.jsp?transNo="+transNo);
							 
						}
						else
						{
							con.close();    
							response.sendRedirect("Smart Inventory/StockSerialtransferserialcheck.jsp? " );				
						}
					}
					else
					{
						asql=" UPDATE inv_t_stocktransfer SET INT_TRANSFERSTATUS=1 WHERE CHR_STOCKTRANSFERID=? ";
						apstm = con.prepareStatement(asql);
						apstm.setString(1,transNo);
						System.out.println(""+apstm);
						apstm.execute();
						apstm.close();
						con.close();   
						response.sendRedirect("Smart Inventory/StockTransSerialPirnt.jsp?transNo="+transNo);
					
					}
					
				} 
				else if("INVStockTransReceive".equals(action))
				{
					String transNo = request.getParameter("transNo");
					String toBranch = request.getParameter("toBranch");	
					//String fromBranch = request.getParameter("fromBranch");
					String division = request.getParameter("division");
					
					String recDate=request.getParameter("recDate");
					String recBy=request.getParameter("reveivedBy");
					recDate=DateUtil.FormateDateSQL(recDate);
					
					//Serial number stock transfer coding 
					String length = request.getParameter("seriallength");
					int limit = Integer.parseInt(length);
					for(int u=1;u<=limit;u++)
					{
						String itemid = request.getParameter("itemid"+u);
						String itype = request.getParameter("itype"+u);
						@SuppressWarnings("unused")
						String rowid = request.getParameter("rowid"+u);
						String serial = request.getParameter("serial"+u);
						String checkbox = ""+request.getParameter("checkbox"+u );
						boolean receivedflag = false;
						if(!"null".equals(checkbox))
								receivedflag = true;
						
						//updation take place in checkbox true only
						
						if(receivedflag)
						{	
							 
							asql = "UPDATE inv_t_vendorgoodsreceived SET ";
							asql = asql+" CHR_FLAG=? , ";
							asql = asql+" CHR_RECEIVEDMODE =? ,";
							asql = asql+" INT_BRANCHID =?";
							asql = asql+" WHERE  CHR_SERIALNO =? ";
							asql = asql+" AND CHR_ITEMID=?";
							asql = asql+" AND CHR_TYPE=?";
							apstm = con.prepareStatement(asql);
							apstm.setString(1,"N");
							apstm.setString(2,"S" );
							apstm.setString(3,toBranch);
							apstm.setString(4,serial);
							apstm.setString(5,itemid);
							apstm.setString(6,itype);
							System.out.println(""+apstm);
							apstm.execute();
							apstm.close();
							
							asql = " UPDATE inv_t_stocktransferitemserial SET CHR_RECEIVEDBY=?,  CHR_RECEIVEDSTATUS='Y' WHERE  CHR_STOCKTRANSFERID=? AND CHR_SERIALNO=?";
							apstm = con.prepareStatement(asql);
							apstm.setString(1,recBy);
							apstm.setString(2,transNo );
							apstm.setString(3,checkbox);
							System.out.println(""+apstm);
							apstm.execute();
							apstm.close();
							
							
						}	
					}
					
					
					//If all serial numbers are received then set received staus is y in inv_t_stocktransferitem   
					sql = "SELECT CHR_RECEIVEDSTATUS FROM inv_t_stocktransferitemserial WHERE  CHR_STOCKTRANSFERID='"+transNo+"'";
					String idata[][] =  CommonFunctions.RecordSetArray(con, sql);
					boolean sflag = false;
					for(int u=0;u<idata.length;u++)
						if("N".equals(idata[u][0]))
							sflag=true;
					if(!sflag)
					{
						sql ="UPDATE inv_t_stocktransferitem SET  CHR_RECEIVEDSTATUS='Y' WHERE CHR_STOCKTRANSFERID='"+transNo+"' AND CHR_PTYPE <> 'S'"; 
						st.execute(sql);
					}	
					
 					
					//coding for consumable transfering 
					sql = "SELECT CHR_ITEMID,CHR_TYPE,INT_QUANTITY,CHR_PTYPE " +
							"FROM inv_t_stocktransferitem WHERE CHR_STOCKTRANSFERID='"+transNo+"'" +
									" AND CHR_PTYPE='S' AND CHR_RECEIVEDSTATUS='N'";
					String data[][] = CommonFunctions.RecordSetArray(con, sql);
					if(data.length>0)
					for(int u=0;u<data.length;u++)
					{	
						String item = data[u][0];
						String itype = data[u][1];
						int qty = Integer.parseInt(data[u][2]);
						
						//reading the stock transfer from
						sql = "SELECT INT_BRANCHID_FROM,INT_BRANCHID_TO FROM inv_t_stocktransfer WHERE CHR_STOCKTRANSFERID='"+transNo+"'";
						String frombranch[][] = CommonFunctions.RecordSetArray(con, sql);
						int frombid = Integer.parseInt(frombranch[0][0]);
						
 					
						//calculating unitprice
						sql =" SELECT FUN_GET_AVERAGEPRICE('"+frombid+"', '"+item+"') "; 
						String pricedata[][] =CommonFunctions.QueryExecute(sql);
						double uniprice=0;
						if(pricedata.length>0)
							uniprice=Double.parseDouble(pricedata[0][0]);
						else
							uniprice=0.0;
						
						sql = " SELECT FUN_GET_CONSUMABLESTOCK("+frombid+",'"+item+"')";
						int stock =Integer.parseInt(CommonFunctions.QueryExecute(sql)[0][0]);
						 
						sql = " select DOU_AVGPRICE from inv_t_vendorgoodsreceivedconsumable "; 
						sql = sql + " WHERE  INT_BRANCHID ="+frombid+" AND CHR_ITEMID='"+item+"' ORDER BY INT_ROWID desc ";
						System.out.println(sql);
						double averageprice=Double.parseDouble(CommonFunctions.QueryExecute(sql)[0][0]);
						
						 
						//inserting unitprice
						sql = "INSERT INTO inv_t_vendorgoodsreceivedconsumable (";
						sql = sql + " INT_DIVIID,INT_BRANCHID,CHR_SALESNO,CHR_TYPE,CHR_ITEMID,";
						sql = sql + " INT_SQTY,CHR_RECIVEDID,DAT_RECIVEDDATE ,CHR_RECEIVEDMODE,";
						sql = sql + " DOU_SALESUNITPRICE,";
						sql = sql + " INT_STOCK,DOU_AVGPRICE ,";
						sql = sql + " CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS ,CHR_RDSTATUS )";
						sql = sql + " VALUES ( ";
						sql = sql+ division+" , ";
						sql = sql+ frombid+" , ";
						sql = sql+" '"+transNo +"' , ";
						sql = sql+" '"+itype +"' , ";
						sql = sql+" '"+item+"' , ";
						sql = sql+" "+qty +" , ";
						sql = sql+" '"+transNo +"' , ";
						sql = sql+" now() , 'S',";
						sql = sql+"  "+uniprice +"  , ";
						if((stock-qty) < 1)
						{
							sql = sql+"0,";
							sql = sql+"0,";
						}
						else
						{
							sql = sql+(stock-qty)+" ,";
							sql = sql+averageprice+",";
						}
						sql = sql +"'"+userId+"', ";
						sql = sql +" now() , 'Y','S' ) ";
						System.out.println(sql);
						st.execute(sql);
						
						//getting stock from to branch
						sql = " SELECT FUN_GET_CONSUMABLESTOCK("+branchid+",'"+item+"')";
						stock =Integer.parseInt(CommonFunctions.QueryExecute(sql)[0][0]);
						
						sql = "INSERT INTO inv_t_vendorgoodsreceivedconsumable (INT_DIVIID,INT_BRANCHID," +
								"CHR_PURCHASEORDERNO,CHR_TYPE,CHR_ITEMID,INT_PQTY," +
								"CHR_RECIVEDID,DAT_RECIVEDDATE ,CHR_RECEIVEDMODE, " +
								"DOU_UNITPRICE,INT_STOCK,DOU_AVGPRICE ,CHR_USRNAME,DT_UPDATEDATE," +
								"CHR_UPDATESTATUS ,CHR_RDSTATUS ) VALUES ( ";
						sql = sql+ division+" , ";
						sql = sql+branchid  +" , ";
						sql = sql+" '"+transNo +"' , ";
						sql = sql+" '"+itype +"' , ";
						sql = sql+" '"+item+"' , ";
						sql = sql+" "+qty +" , ";
						sql = sql+" '"+transNo +"' , ";
						sql = sql+" now() , 'S',";
						sql = sql+"  "+uniprice +"  , ";
						if(stock == 0)
							sql = sql+" "+qty +" , ";
						else
							sql = sql +""+(stock+qty)+", ";
						
						if(stock == 0)
							sql = sql+uniprice+",";
						else
						{
							String asql = " select DOU_AVGPRICE from inv_t_vendorgoodsreceivedconsumable "; 
							asql = asql + " WHERE  INT_BRANCHID ="+branchid+" AND CHR_ITEMID='"+item+"' ORDER BY INT_ROWID desc ";
							averageprice=Double.parseDouble(CommonFunctions.QueryExecute(asql)[0][0]);
							double s1 = stock*averageprice;
							double s2 = qty*uniprice;;
							double s3 = s1+s2;
							int totstack = stock+qty;
							double avgprice = s3/totstack;
							sql = sql +""+(avgprice)+", ";
						}
						sql = sql +"'"+userId+"', ";
						sql = sql +" now() , 'Y','S' ) ";
						System.out.println(sql);
						st.execute(sql);
						
						
						
						
						
						sql ="UPDATE inv_t_stocktransferitem SET  CHR_RECEIVEDSTATUS='Y' WHERE CHR_STOCKTRANSFERID='"+transNo+"' AND CHR_PTYPE ='S'";
						sql = sql +" AND CHR_ITEMID='"+item+"' AND CHR_TYPE='"+itype+"'";
						st.execute(sql);
						
						
					}
					
					//All serial & consumables are recevied the staus is updated int stock transfer
					sql = "SELECT CHR_RECEIVEDSTATUS FROM inv_t_stocktransferitem WHERE  CHR_STOCKTRANSFERID='"+transNo+"'";
					String Alldata[][] = com.my.org.erp.common.CommonFunctions.RecordSetArray(con, sql);
					boolean aflag = false;
					for(int u=0;u<Alldata.length;u++)
						if("N".equals(Alldata[u][0]))
							aflag=true;
					if(!aflag)
					{
						sql="UPDATE inv_t_stocktransfer SET ";
						sql=sql+" CHR_RECEIVEDBY='"+recBy+"'";
						sql=sql+" , DAT_RECEIVEDDATE='"+recDate+"'";
						sql=sql+" , INT_STATUS=1 ";
						sql=sql+" WHERE CHR_STOCKTRANSFERID='"+transNo+"'";	
						st.execute(sql);
					}	
					
					con.close();    
				 	response.sendRedirect("Smart Inventory/Stock Transfer.jsp");				
				}
				else if("INVStockTransDelete".equals(action))
				{
					String ids[] = request.getParameterValues("transferId");
					for(int u=0;u<ids.length;u++)
					{
						String transferno= ids[u].trim();
						sql = " SELECT INT_ID,INT_BRANCHID_FROM,INT_BRANCHID_TO ,INT_STATUS  FROM inv_t_stocktransfer WHERE CHR_STOCKTRANSFERID='"+transferno+"'";
						String trasferdata[][] =  CommonFunctions.RecordSetArray(con, sql);
						sql = "SELECT CHR_ITEMID ,CHR_TYPE,INT_QUANTITY from inv_t_stocktransferitem  WHERE CHR_STOCKTRANSFERID='"+transferno+"'";
						@SuppressWarnings("unused")
						String trasferdatas[][] =  CommonFunctions.RecordSetArray(con, sql);
						sql = "SELECT CHR_ITEMID ,CHR_TYPE,CHR_SERIALNO from inv_t_stocktransferitemserial  WHERE CHR_STOCKTRANSFERID='"+transferno+"'";
						String trasferdatass[][] =  CommonFunctions.RecordSetArray(con, sql);
						
						asql = "DELETE FROM inv_t_stocktransfer WHERE CHR_STOCKTRANSFERID=?";
						apstm = con.prepareStatement(asql);
						apstm.setString(1,transferno);
						System.out.println(""+apstm);
						apstm.execute();
						apstm.close();
						
						asql = "DELETE from inv_t_stocktransferitem  WHERE CHR_STOCKTRANSFERID=?";
						apstm = con.prepareStatement(asql);
						apstm.setString(1,transferno);
						System.out.println(""+apstm);
						apstm.execute();
						apstm.close();
						
						asql = "DELETE from inv_t_stocktransferitemserial  WHERE CHR_STOCKTRANSFERID=?";
						apstm = con.prepareStatement(asql);
						apstm.setString(1,transferno);
						System.out.println(""+apstm);
						apstm.execute();
						apstm.close();
				
						asql = "DELETE from inv_t_vendorgoodsreceivedconsumable  WHERE CHR_PURCHASEORDERNO=?";
						apstm = con.prepareStatement(asql);
						apstm.setString(1,transferno);
						System.out.println(""+apstm);
						apstm.execute();
						apstm.close();
						
						asql = "DELETE from inv_t_vendorgoodsreceivedconsumable  WHERE CHR_SALESNO=?";
						apstm = con.prepareStatement(asql);
						apstm.setString(1,transferno);
						System.out.println(""+apstm);
						apstm.execute();
						apstm.close(); 
						 
						
						@SuppressWarnings("unused")
						String fromid = trasferdata[0][1];
						@SuppressWarnings("unused")
						String toid = trasferdata[0][2];
						for(int b=0;b<trasferdatass.length;b++);
						{
							 
						}
					}
					con.close();    
					response.sendRedirect("Smart Inventory/Stock Transfer.jsp");				
				}
				else if("INVStockTransCancel".equals(action))
				{
					String transferno = request.getParameter("transferno");
					sql ="SELECT INT_BRANCHID_FROM,INT_BRANCHID_TO FROM  inv_t_stocktransfer WHERE CHR_STOCKTRANSFERID='"+transferno+"'";
					String data[][] = CommonFunctions.QueryExecute(sql);
					String stockfrom = data[0][0];
					sql = "SELECT CHR_SERIALNO FROM inv_t_stocktransferitemserial   WHERE CHR_STOCKTRANSFERID='"+transferno+"'";
					String serialdata[][] = CommonFunctions.QueryExecute(sql);
					for(int u=0;u<serialdata.length;u++)
					{
						asql = "UPDATE inv_t_vendorgoodsreceived SET ";
						asql = asql+" CHR_FLAG=? , ";
						asql = asql+" INT_BRANCHID = ?";
						asql = asql+" WHERE  CHR_SERIALNO = ? ";
						apstm = con.prepareStatement(asql);
						apstm.setString(1,"N");
						apstm.setString(2,stockfrom);
						apstm.setString(3,serialdata[u][0]);
						System.out.println(""+apstm);
						apstm.execute();
						apstm.close();
					}
					
					asql = "DELETE FROM inv_t_stocktransfer WHERE CHR_STOCKTRANSFERID=?";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,transferno);
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
					
					asql = "DELETE FROM inv_t_stocktransferitem WHERE CHR_STOCKTRANSFERID=?";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,transferno);
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
					
					asql = "DELETE FROM inv_t_stocktransferitemserial WHERE CHR_STOCKTRANSFERID=?";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,transferno);
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
					 
					con.close();    
					response.sendRedirect("Smart Inventory/Stock Transfer.jsp");				
				}
				else if("INVStockTransDespatch".equals(action))
				{
					String transferno = request.getParameter("transferno");
					String division = request.getParameter("division");
					String through = request.getParameter("through");
					String courier = request.getParameter("courier");
					String engname= request.getParameter("engname"); 
					String engmobile = request.getParameter("engmobile");
					String starting = request.getParameter("starting");
					String endig = request.getParameter("endig");
					String kilometer = ""+request.getParameter("kilometer");
					String description = request.getParameter("description");
					String amount = request.getParameter("amount");
					
					if("".equals(kilometer))
						kilometer ="0";
					String startdate =request.getParameter("startdate");
					String stdate[] = startdate.split(" ");
					String sdate = DateUtil.FormateDateSQL(stdate[0])+" "+stdate[1];
					System.out.println(sdate);
					asql = "UPDATE inv_t_stocktransfer SET CHR_DELIVERYTHROUGH=?,CHR_COURIER_EMPID=?,CHR_COURIER_EMPID_MOBILE=?,";
					asql = asql +" DAT_COURIERDATE=?,CHR_DELIVERY=?,INT_COURIERID=?,DAT_COURIERDATE=NOW(),CHR_STARTING_PLACE=?,";
					asql = asql +" CHR_ENDING_PLACE=?,INT_COURIER_KILOMETER=?,CHR_COURIER_DESC=?,";
					asql = asql +" DOU_COURIERAMOUNT=? WHERE CHR_STOCKTRANSFERID=? ";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,through);
					apstm.setString(2,engname);
					apstm.setString(3,engmobile);
					apstm.setString(4,sdate);
					apstm.setString(5,"Y");
					apstm.setString(6,courier);
					apstm.setString(7,starting);
					apstm.setString(8,endig);
					apstm.setString(9,kilometer);
					apstm.setString(10,description);
					apstm.setString(11,amount);
					apstm.setString(12,transferno);
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
					
					//mail alert
					StockStransferMail.sendStockTransferShippedMail(branchid, transferno, division, Path);
					con.close();    
					response.sendRedirect("Smart Inventory/Stock Transfer.jsp");
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
	
	
	public static synchronized boolean checkSerialNumberSale(HttpServletRequest request, HttpServletResponse response) throws IOException,SQLWarning, ServletException 
	{
		boolean flag = true;
		try
		{
			String length =request.getParameter("seriallength").trim();
			
			String sql = " SELECT CHR_FLAG,CHR_SERIALNO FROM  inv_t_vendorgoodsreceived	WHERE CHR_SERIALNO IN(";
			String s="";
			
			
			for(int u=1; u<=Integer.parseInt(length);u++)
				s = s+ "'"+request.getParameter("serial"+u).trim()+"' ," ;
			
			sql = sql+s ;
			sql=sql.trim();
			sql = sql.substring(0,sql.length()-1);
			sql = sql+" ) ";
		
			System.out.println("===========================================");
			System.out.println("Sale serial number checking : "+sql);
			System.out.println("===========================================");
			String checkData[][] = CommonFunctions.QueryExecute(sql);
			if(checkData.length>0)
				for(int u=0;u<checkData.length;u++)
				{
					if(!"N".equals(checkData[u][0]))
					{
						flag = false;
						break;
					}	
				}
			
			return flag;
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
							
		}
		return flag;
	}
}