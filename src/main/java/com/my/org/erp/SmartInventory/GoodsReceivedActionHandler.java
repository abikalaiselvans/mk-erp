package com.my.org.erp.SmartInventory;
import java.io.IOException;
import java.sql.SQLWarning;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;

public class GoodsReceivedActionHandler extends AbstractActionHandler
{
	String userId="";
	private static String serialnumber="";
	 public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	 {
		try
		{
				String action=request.getParameter("actionS");
				HttpSession session=request.getSession();			
				userId=""+session.getAttribute("USRID");
				String branchid = session.getAttribute("BRANCHID").toString();
				Statement st = con.createStatement();
				String sql="";
				if("INVGoodsReceivedAdd".equals(action))
				{
					String purchaseno = request.getParameter("purchaseno");
					String received = request.getParameter("received");
					String delivaryNo = request.getParameter("delivaryNo");
					String invoiceNo = request.getParameter("invoiceNo");
					String receddt = request.getParameter("receddt");
					String receivedby = request.getParameter("receivedby");
					String rlength = request.getParameter("length");
					String flag="";
					String division = ""+request.getParameter("division");
					int ppqty=0;
					//Insert to vendor goods received & vendorgoods consumables
					for(int u=1;u<=Integer.parseInt(rlength);u++)
					{
						String odqty = ""+request.getParameter("odqty"+u);
						String receivedqty = ""+request.getParameter("receivedqty"+u);
						ppqty = Integer.parseInt(receivedqty);
						String itemid = ""+request.getParameter("item"+u);
						String itemtype = ""+request.getParameter("itype"+u);
						String unitprice = ""+request.getParameter("unitprice"+u);
						String pmode = ""+request.getParameter("pmode"+u);
						if(!"S".equals(pmode))
						{
							//serial number entry
							asql =" SELECT COUNT(*) FROM inv_t_vendorgoodsreceived WHERE CHR_PURCHASEORDERNO='"+purchaseno+"' ";
							if("0".equals(CommonFunctions.QueryExecutecon(con, asql)[0][0]))
							{
								sql = "";
								sql = "INSERT INTO inv_t_vendorgoodsreceived ( ";
								sql =sql + " INT_BRANCHID,INT_DIVIID,CHR_PURCHASEORDERNO ," ;
								sql =sql + " CHR_ITEMID,CHR_TYPE,CHR_RECEIVEDMODE,DOU_UNITPRICE," ;
								sql =sql + "  CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS  " ;
								sql =sql + " ) VALUES ( " ;
								sql =sql + " ?,?,?,?,?,?,?,?,DATE(NOW()),'Y'  " ;
								sql =sql + " )  " ;
								apstm = con.prepareStatement(sql);
								for(int x=0; u<=Integer.parseInt(odqty);u++)
								{
									apstm.setString(1,branchid);//branch
									apstm.setString(2,division);//division
									apstm.setString(3,purchaseno);//purchaseno
									apstm.setString(4,itemid);//item
									apstm.setString(5,itemtype);//itype
									apstm.setString(6, "P");//inward mode
									apstm.setString(7,unitprice);//uprice
									apstm.setString(8,userId);
									System.out.println(""+apstm);
									apstm.addBatch();
								}
								apstm.executeBatch();
								apstm.close();
							}
						}
						else
						{
							//consumables Entry
							//asql =" SELECT COUNT(*) FROM inv_t_vendorgoodsreceivedconsumable WHERE CHR_PURCHASEORDERNO='"+purchaseno+"' ";
							//if("0".equals(CommonFunctions.QueryExecutecon(con, asql)[0][0]))
							{
								//====================================
								 
									sql = " SELECT FUN_GET_CONSUMABLESTOCK("+branchid+",'"+itemid+"')";
									int stock =Integer.parseInt(CommonFunctions.QueryExecute(sql)[0][0]);
									
									sql = "INSERT INTO inv_t_vendorgoodsreceivedconsumable (";
									sql = sql + " INT_DIVIID,INT_BRANCHID,CHR_PURCHASEORDERNO,";
									sql = sql + " CHR_TYPE,CHR_ITEMID,INT_PQTY,CHR_RECIVEDID, ";
									sql = sql + " DAT_RECIVEDDATE ,CHR_RECEIVEDMODE, DOU_UNITPRICE, ";
									sql = sql + " INT_STOCK,DOU_AVGPRICE ,";
									sql = sql + " CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS  ) VALUES ( ";
									sql = sql+division +" , ";
									sql = sql+branchid +" , ";
									sql = sql+" '"+purchaseno +"' , ";
									sql = sql+" '"+itemtype +"' , ";
									sql = sql+" '"+itemid +"' , ";
									sql = sql+" "+receivedqty +" , ";
									sql = sql+" '"+purchaseno +"' , ";
									sql = sql+" now() , 'D',";
									sql = sql+Double.parseDouble(unitprice)+",";
									if(stock == 0)
										sql = sql+" "+ppqty +" , ";
									else
										sql = sql +""+(stock+ppqty)+", ";
									
									if(stock == 0)
										sql = sql+Double.parseDouble(unitprice)+",";
									else
									{
										String asql = " select DOU_AVGPRICE from inv_t_vendorgoodsreceivedconsumable "; 
										asql = asql + " WHERE  INT_BRANCHID ="+branchid+" AND CHR_ITEMID='"+itemid+"' ORDER BY INT_ROWID desc ";
										double averageprice=Double.parseDouble(CommonFunctions.QueryExecute(asql)[0][0]);
										double s1 = stock*averageprice;
										double s2 = ppqty*Double.parseDouble(unitprice);;
										double s3 = s1+s2;
										int totstack = stock+ppqty;
										double avgprice = 0;
										if(totstack != 0)
											avgprice = s3/totstack;
										sql = sql +""+(avgprice)+", ";
									}
											
									sql = sql +"'"+userId+"', ";
									sql = sql +" now() , 'Y' ) ";
									System.out.println(sql);
									st.execute(sql);
								 
								//====================================
							}
						}
					}
					
					
					
					 
					
					for(int u=1;u<=Integer.parseInt(rlength);u++)
					{
						String rqty = ""+request.getParameter("receivedqty"+u);
						String pqty = ""+request.getParameter("qty"+u);
						String prv = ""+request.getParameter("prev"+u);
						String orderqty = ""+request.getParameter("ordered"+u);
						if("null".equalsIgnoreCase(prv) || "".equals(prv))
							prv="0";
						String rowid = ""+request.getParameter("rowid"+u);
						String itemid = ""+request.getParameter("item"+u);
						String itemtype = ""+request.getParameter("itype"+u);
						String dbid = ""+request.getParameter("dbreceived"+u);
						if("null".equalsIgnoreCase(dbid) || "".equals(dbid))
							dbid ="0";
						String pmode = ""+request.getParameter("pmode"+u);
						
						//Consumables start
						if("S".equals(pmode))
						{
							asql ="SELECT INT_BRANCHID,CHR_PURCHASEORDERNO,CHR_TYPE,CHR_ITEMID,INT_PQTY,DOU_UNITPRICE,((INT_PQTY)*(DOU_UNITPRICE)) 	FROM inv_t_vendorgoodsreceivedconsumable WHERE CHR_PURCHASEORDERNO='"+purchaseno+"' ORDER BY INT_ROWID";
							String consdata[][] =  CommonFunctions.QueryExecutecon(con, asql);
							if(consdata.length>0)
							{	
								for(int v=0;v<consdata.length;v++)
								{
									String pid = consdata[v][3].trim();
									//this is for inward to stock
									asql = "UPDATE  inv_t_vendorgoodsreceivedconsumable SET CHR_RDSTATUS='S' ";
									asql = asql +" WHERE CHR_TYPE='P'  AND CHR_ITEMID=?";
									asql = asql +" AND INT_BRANCHID=?";
									apstm = con.prepareStatement(asql);
									apstm.setString(1,pid);
									apstm.setString(2,branchid);
									System.out.println(""+apstm);
									apstm.execute();
								}
							}
						}
						//Consumables end
						
						sql ="UPDATE  inv_t_vendorpurchaseorderitem SET ";
						sql = sql +" CHR_RECIVEDID = '"+received+"' ,";
						sql = sql +" DAT_RECIVEDDATE = '"+DateUtil.FormateDateSQL(receddt)+"' ,";
						sql = sql +" CHR_RECIVEDBY = '"+receivedby+"' ,";
						sql = sql +" INT_RECIVEDQUANTITY = "+(Integer.parseInt(rqty)+Integer.parseInt(prv))+" ,";
						sql = sql +" INT_REMAINQUANTITY = "+(Integer.parseInt(pqty)-Integer.parseInt(rqty))+",";
						sql = sql +" INT_FAULT = 0 ";
						sql = sql +" WHERE CHR_PURCHASEORDERNO = '"+purchaseno+"'";
						sql = sql +" AND INT_ID  = "+Integer.parseInt(rowid)+"";
						sql = sql +" AND CHR_TYPE  = '"+itemtype+"'";
						sql = sql +" AND CHR_ITEMID  = '"+itemid+"'";
						st.execute(sql);
						
						if((Integer.parseInt(rqty)+Integer.parseInt(dbid)) == Integer.parseInt(orderqty))
							flag = flag+"true,";
						else
							flag = flag+"false,";
					}
					
					String check[] = flag.split(",");
					boolean flags = true;  
					for(int y=0;y<check.length;y++)
						if("false".equals(check[y].trim()))
							flags = false;
					
					//update for inv_t_vendorpurchaseorder table
					String stat="";
					if(flags)
						stat="1";
					else
						stat="-1";
					
					sql ="UPDATE  inv_t_vendorpurchaseorder  SET ";
					sql = sql +" CHR_RECIVEDID = '"+received+"' ,";
					sql = sql +" DAT_RECIVEDDATE = '"+DateUtil.FormateDateSQL(receddt)+"' ,";
					sql = sql +" CHR_RECIVEDBY = '"+receivedby+"' ,";
					sql = sql +" INT_PURCHASESTATUS ="+stat;
					sql = sql +" WHERE CHR_PURCHASEORDERNO = '"+purchaseno+"'";
					st.execute(sql);
					String url="Smart Inventory/GoodsReceivedSerialnoEntry.jsp?ponumber="+purchaseno
					+"&refno="+received
					+"&delivaryNo="+delivaryNo
					+"&invoiceNo="+invoiceNo;
					con.close();    
					response.sendRedirect(url);
				}
				else if("INVGoodsReceivedChange".equals(action))
				{
					String purchaseno = request.getParameter("purchaseno");
					String delivaryNo = request.getParameter("delivaryNo");
					String invoiceNo = request.getParameter("invoiceNo");
					String received = request.getParameter("receivedNo");
					String receddt = request.getParameter("receddt");
					String receivedby = request.getParameter("receivedby");
					String rlength = request.getParameter("length");
								
					int totRecQty=0;
					for(int u=1;u<=Integer.parseInt(rlength);u++)
					{
						String rqty  = ""+request.getParameter("dcreceivedqty"+u);
						String pqty = ""+request.getParameter("qty"+u);
						String prv = ""+request.getParameter("prev"+u);
						if("null".equalsIgnoreCase(prv) || "".equals(prv))
							prv="0";
						String rowid = ""+request.getParameter("rowid"+u);
						String itemid = ""+request.getParameter("item"+u);
						String itype = ""+request.getParameter("itype"+u);
						String dbid = ""+request.getParameter("dbreceived"+u);
						if("null".equalsIgnoreCase(dbid) || "".equals(dbid))
							dbid ="0";
						totRecQty=totRecQty+(Integer.parseInt(pqty)-Integer.parseInt(rqty));
						sql ="UPDATE  inv_t_vendorpurchaseorderitem SET ";
						sql = sql +" CHR_RECIVEDID = '"+received+"' ,";
						sql = sql +" DAT_RECIVEDDATE = '"+DateUtil.FormateDateSQL(receddt)+"' ,";
						sql = sql +" CHR_RECIVEDBY = '"+receivedby+"' ,";
						sql = sql +" INT_RECIVEDQUANTITY = "+Integer.parseInt(rqty)+" ,";
						sql = sql +" INT_REMAINQUANTITY = "+(Integer.parseInt(pqty)-Integer.parseInt(rqty))+",";
						sql = sql +" INT_FAULT = 0 ";
						sql = sql +" WHERE CHR_PURCHASEORDERNO = '"+purchaseno+"'";
						sql = sql +" AND INT_ID  = "+Integer.parseInt(rowid)+"";
						sql = sql +" AND CHR_ITEMID  = '"+itemid+"'";
						sql = sql +" AND CHR_TYPE  = '"+itype+"'";
						st.execute(sql);
				}
					String stat="-1";
					if(totRecQty==0) stat="1";
					sql ="UPDATE  inv_t_vendorpurchaseorder  SET ";
					sql = sql +" CHR_RECIVEDID = '"+received+"' ,";
					sql = sql +" DAT_RECIVEDDATE = '"+DateUtil.FormateDateSQL(receddt)+"' ,";
					sql = sql +" CHR_RECIVEDBY = '"+receivedby+"' ,";
					sql = sql +" INT_PURCHASESTATUS ="+stat;
					sql = sql +" WHERE CHR_PURCHASEORDERNO = '"+purchaseno+"'";
					st.execute(sql);
					String url="Smart Inventory/GoodsReceivedSerialnoChange.jsp?ponumber="+purchaseno
						+"&refno="+received
						+"&delivaryNo="+delivaryNo
						+"&invoiceNo="+invoiceNo+"&updateflag=true";
					
					con.close();    
					response.sendRedirect(url);
				}
				if("INVGoodsReceivedSerialAdd".equals(action))
				{
					String serialflag = ""+request.getParameter("serialflag");
					if("true".equals(serialflag))
					{
						String purchaseno = ""+request.getParameter("purchaseno");
						String delivaryNo = request.getParameter("delivaryNo");
						String invoiceNo = request.getParameter("invoiceNo");
						String recdid =""+request.getParameter("received");
						String rlength = ""+request.getParameter("length");
						String recddate = ""+request.getParameter("receddt");
						String recdby = ""+request.getParameter("receivedby");
						
						String serial ="";
						for(int u=1;u<Integer.parseInt(rlength);u++)
							serial =serial+"'"+request.getParameter("serail"+u)+"' ,";
						serial=serial.trim();
						serial = serial.substring(0,serial.length()-1);
						System.out.println(serial);
						boolean flag =checkSerialNumber(serial);
						if(!flag)
						{
							asql = "UPDATE  inv_t_vendorgoodsreceived SET" ;
							asql = asql +" CHR_RECIVEDID = ? ,";
							asql = asql +" DAT_RECIVEDDATE = ? ,";
							asql = asql +" CHR_RECIVEDBY = ? ,";
							asql = asql +" CHR_SERIALNO = ? ,";
							asql = asql +" CHR_WARRANTY = ? ,";
							asql = asql +" CHR_DELIVARYNO = ?,";
							asql = asql +" CHR_INVOICENO = ? ";
							asql = asql +"WHERE CHR_PURCHASEORDERNO =?";
							asql = asql +" AND CHR_ITEMID = ?";
							asql = asql +" AND CHR_TYPE = ?";
							asql = asql +" AND INT_ID = ? ";
							apstm = con.prepareStatement(asql);
							
							for(int u=1;u<Integer.parseInt(rlength);u++)
							{	
								String itemid =""+request.getParameter("item"+u);
								String itype =""+request.getParameter("itype"+u);
								String rowid =""+request.getParameter("row"+u);
								serial =""+request.getParameter("serail"+u);
								String waranty =""+request.getParameter("warranty"+u);
								apstm.setString(1,recdid);
								apstm.setString(2,DateUtil.FormateDateSQL(recddate));
								apstm.setString(3,recdby);
								apstm.setString(4,serial);
								apstm.setString(5,waranty);
								apstm.setString(6,delivaryNo);
								apstm.setString(7,invoiceNo);
								apstm.setString(8,purchaseno);
								apstm.setString(9,itemid);
								apstm.setString(10,itype);
								apstm.setString(11,rowid);
								System.out.println(""+apstm);
								apstm.addBatch(); 
							}
							apstm.executeBatch();
							apstm.close();
							
							
							
							//Update the purchase request 
							asql = "UPDATE inv_t_purchaserequest SET CHR_PR_PARTIALLY_RECEIVED=? WHERE CHR_POREQUESTNO= ?";
							apstm = con.prepareStatement(asql);
							apstm.setString(1,"P");
							apstm.setString(2,request.getParameter("purchaserequest"));
							System.out.println(""+apstm);
							apstm.execute();
							apstm.close(); 
							
							con.close();    
							response.sendRedirect("Smart Inventory/GoodsRecived.jsp");
						}
						else
						{
							con.close();    
							response.sendRedirect("Smart Inventory/GoodsReceivedSerialnoEntryCheck.jsp?err=Kindly check the serial number ["+serialnumber+" ] ");
						}
					}
					else
					{
						con.close();    
						response.sendRedirect("Smart Inventory/GoodsRecived.jsp");
					}
					
				}
				if("INVGoodsReceivedSerialUpdate".equals(action))
				{
					String purchaseno = ""+request.getParameter("purchaseno");
					String recdid =""+request.getParameter("received");
					String rlength = ""+request.getParameter("length");
					//String recddate = ""+request.getParameter("receddt");
					//String recdby = ""+request.getParameter("receivedby");
					for(int u=1;u<=Integer.parseInt(rlength);u++)
					{	
						String itemid =""+request.getParameter("item"+u);
						String rowid =""+request.getParameter("row"+u);
						String serial =""+request.getParameter("serail"+u);
						String waranty =""+request.getParameter("warranty"+u);
						sql = "UPDATE  inv_t_vendorgoodsreceived SET" ;
						sql = sql +" CHR_RECIVEDID = '"+recdid+"' ,";
						sql = sql +" CHR_SERIALNO = '"+(serial.trim()).toUpperCase()+"' ,";
						sql = sql +" CHR_WARRANTY = '"+waranty+"' ";
						sql = sql +"WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
						sql = sql +" AND CHR_ITEMID = '"+itemid+"'";
						sql = sql +" AND INT_ID = '"+rowid+"'";
						st.execute(sql);
					}
					con.close();    
					response.sendRedirect("Smart Inventory/GoodsRecived.jsp");
				}
				if("INVGoodsReceivedDelete".equals(action))
				{
					String purchaseno[] = request.getParameterValues("ponumber");
					for(int p=0; p<purchaseno.length; p++)
					{
						sql ="UPDATE  inv_t_vendorpurchaseorder  SET ";
						sql = sql +" DAT_REQUESTDATE = now() , ";	
						sql = sql +" INT_PURCHASESTATUS = 0 , ";
						sql = sql +" CHR_RECIVEDID = '' , ";
						sql = sql +" DAT_RECIVEDDATE = null , ";						
						sql = sql +" CHR_RECIVEDBY = null ";
						sql = sql +" WHERE CHR_PURCHASEORDERNO ='"+purchaseno[p]+"'";
						st.execute(sql);
						sql = "SELECT * FROM  inv_t_vendorpurchaseorderitem WHERE CHR_PURCHASEORDERNO ='"+purchaseno[p]+"'";
						String purchaseorderitemData[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
						for(int u=0;u<purchaseorderitemData.length;u++)
						{
							sql = "UPDATE  inv_t_vendorpurchaseorderitem SET ";
							sql = sql +" CHR_RECIVEDID = '' , ";
							sql = sql +" DAT_RECIVEDDATE = null , ";
							sql = sql +" CHR_RECIVEDBY = null , ";
							sql = sql +" INT_RECIVEDQUANTITY = 0 , " ;
							sql = sql +" INT_REMAINQUANTITY = 0 ";
							sql = sql +" WHERE CHR_PURCHASEORDERNO ='"+purchaseorderitemData[u][2]+"'";
							sql = sql +" AND CHR_ITEMID ='"+purchaseorderitemData[u][3]+"'";
							sql = sql +" AND INT_ID ='"+Integer.parseInt(purchaseorderitemData[u][0])+"'";
							
							st.execute(sql);
							int recdqty = Integer.parseInt(purchaseorderitemData[u][12]);
							sql = "UPDATE inv_t_vendorgoodsreceived SET ";
							sql = sql +" CHR_RECIVEDID = ' ' , ";
							sql = sql +" DAT_RECIVEDDATE = null , ";
							sql = sql +" CHR_RECIVEDBY = null , ";
							sql = sql +" CHR_SERIALNO = null , ";
							sql = sql +" CHR_WARRANTY = null  ";
							sql = sql +" WHERE CHR_PURCHASEORDERNO ='"+purchaseorderitemData[u][2]+"'";
							sql = sql +" AND CHR_ITEMID ='"+purchaseorderitemData[u][3]+"'";
							st.execute(sql);
							sql = "SELECT INT_STOCKID,INT_STOCKINHAND FROM inv_t_stock ";
							sql = sql +" WHERE CHR_ITEMID ='"+purchaseorderitemData[u][3]+"'  AND INT_BRANCHID="+branchid;
							String stockData[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
						
							int sthandqty = Integer.parseInt(stockData[0][1]);
							sql = "UPDATE inv_t_stock SET ";
							sql = sql +" INT_STOCKINHAND = "+(sthandqty-recdqty)+" ";
							sql = sql +" WHERE  CHR_ITEMID ='"+purchaseorderitemData[u][3]+"'  AND INT_BRANCHID="+branchid;
							st.execute(sql);
						}
					}
					con.close();    
					response.sendRedirect("Smart Inventory/GoodsRecived.jsp");
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
		
	 
	 public static synchronized boolean checkSerialNumber(String serial) throws IOException,SQLWarning, ServletException 
		{
			boolean flag = false;
			try
			{
				 
	 			String sql = " SELECT CHR_SERIALNO FROM  inv_t_vendorgoodsreceived	WHERE CHR_SERIALNO IN(";
				sql = sql+serial ;
				sql = sql+" ) ";
			
				System.out.println("===========================================");
				System.out.println("  serial number checking : "+sql);
				System.out.println("===========================================");
				String checkData[][] = CommonFunctions.QueryExecute(sql);
				if(checkData.length>0)
					for (String[] element : checkData) {
						serialnumber = element[0];
						 
						  flag = true;
							break;
					}
				
				return flag;
			}
			catch(Exception e)
			{
				System.out.println(e.getMessage());
				
			}
			return flag;
		}
}