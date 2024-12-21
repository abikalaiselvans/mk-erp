package com.my.org.erp.SmartInventory;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.Arrays;
import java.util.Map;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;

import com.my.org.erp.bean.inventory.SwapSale;
import com.my.org.erp.common.CommonFunction;
import com.my.org.erp.common.CommonFunctions;
import com.my.org.erp.mail.Mail;
import com.my.org.erp.setting.CommonData;
import com.my.org.erp.way2sms.Way2Sms;
import com.my.org.erp.Math.MathFunction;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;

public class SwapSaleActionHandlerold extends AbstractActionHandler
{
	static String blockinvoice ="N";
	public static void  itemInsert(HttpServletRequest request,HttpServletResponse response, String SwapSaleNo ,Connection con,Statement st,String branch,String division)throws ServletException, IOException 
	{
		try 
		{
			String field="";
			String sql="";			
			HttpSession session=request.getSession();			
			String userId=""+session.getAttribute("USRID");
			String branchid = session.getAttribute("INVBRANCH").toString();
			String param[] = request.getParameter("param").split(",");
			String itype="";
			String itemid = "",warranty="";
			String consumables="";
			int pqty=0;
			for(int p=0;p<param.length; p++)
			{
				String e =""+request.getParameter("itype"+param[p].trim());
				itemid =""+request.getParameter("item"+param[p].trim());
				consumables =""+request.getParameter("consumables"+param[p].trim()); 
				pqty =Integer.parseInt(request.getParameter("qty"+param[p].trim()));
				String productswap="N";
				if(e.equals("1") )
					itype="I";
				if(e.equals("2") )
					itype="P";
				//other products 
				if("P".equals(itype))
				{
					String producttype =  CommonFunctions.QueryExecute( "SELECT CHR_PTYPE FROM inv_m_produtlist WHERE CHR_PRODUCTID='"+itemid+"'")[0][0];
					if("C".equals(producttype))
					{	
						String checkvalue = request.getParameter("SwapCheckbox"+param[p].trim());
						if("on".equalsIgnoreCase(checkvalue))
							productswap="Y";
						else
							productswap="N";
					}		
				}
				else
					productswap="N";
				
				//insert into total item 
				field = "INT_BRANCHID,CHR_SALESNO,CHR_ITEMID,CHR_TYPE,CHR_DESC,INT_QUANTITY,INT_WARRANTY,"; 
				field = field+"DOU_UNITPRICE,DOU_DISCOUNT,DOU_UNITDISCOUNT,INT_TAXID,DOU_TAX_PERCENTAGE,DOU_TAX_AMOUNT,DOU_TOTAL,CHR_SWAP,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS" ;
				sql=" INSERT INTO inv_t_swapsalesitem (" +field+" ) VALUES ( ";
				sql = sql +" ?,?,?,?,?,?,?,"; 
				sql = sql +" ?,?,?,?,?,?,?,?,?,DATE(NOW()),'Y' " ;
				sql = sql +")";
				PreparedStatement  apstm = con.prepareStatement(sql);
				apstm.setString(1, branch);
				apstm.setString(2, SwapSaleNo);
				apstm.setString(3, itemid);
				apstm.setString(4, itype);
				apstm.setString(5, (request.getParameter("desc"+param[p].trim()).replace("\"", "")).replaceAll("&", " and"));
				apstm.setString(6, ""+pqty);
				apstm.setString(7, (request.getParameter("warranty"+param[p].trim())));
				apstm.setString(8, (request.getParameter("uprice"+param[p].trim())));
				apstm.setString(9, request.getParameter("discount"+param[p].trim()));
				apstm.setString(10, (request.getParameter("unitdiscount"+param[p].trim())));
				apstm.setString(11, request.getParameter("stax"+param[p].trim()));
				apstm.setString(12, request.getParameter("staxpercentage"+param[p].trim()));
				apstm.setString(13, request.getParameter("staxamount"+param[p].trim()));
				apstm.setString(14, (request.getParameter("total"+param[p].trim())));
				apstm.setString(15, productswap);
				apstm.setString(16,userId);
				System.out.println(""+apstm);
				apstm.execute();
				apstm.close();
				 
				 
				if(!consumables.equals("S"))
				{
					//insert into individual serial number and warranty
					sql ="";
					field ="  INT_BRANCHID,CHR_SALESNO,CHR_ITEMID,CHR_TYPE ,DOU_UNITPRICE,CHR_SWAP ," +
					" CHR_USRNAME,DT_UPDATEDATE ,CHR_DESC,CHR_UPDATESTATUS,CHR_WARRANTY ";
					sql ="INSERT INTO inv_t_swapsalesserialno ( " + field  +" ) ";
					sql = sql+	" VALUES ( ";
					sql = sql+	" ?,?,?,? ,? ,? ,?,DATE(NOW()) ,?,'Y',?  ";
					sql = sql +")";
					apstm = con.prepareStatement(sql);
					for(int u=0; u<Integer.parseInt(request.getParameter("qty"+param[p].trim()));u++)
					{
						apstm.setString(1, branch);
						apstm.setString(2, SwapSaleNo);
						apstm.setString(3, itemid);
						apstm.setString(4, itype);
						apstm.setString(5,(request.getParameter("uprice"+param[p].trim())) );
						apstm.setString(6, productswap);
						apstm.setString(7, userId );
						apstm.setString(8, request.getParameter("desc"+param[p].trim()) );
						apstm.setString(9, (request.getParameter("warranty"+param[p].trim())));
						System.out.println(""+apstm);
						apstm.addBatch();
					}
					apstm.executeBatch();
					apstm.close();
				}
				else
				{
					//consumable products
					
					sql = " SELECT FUN_GET_CONSUMABLESTOCK("+branchid+",'"+itemid+"')";
					int stock =Integer.parseInt(CommonFunctions.QueryExecute(sql)[0][0]);
					 
					sql = " select DOU_AVGPRICE from inv_t_vendorgoodsreceivedconsumable "; 
					sql = sql + " WHERE  INT_BRANCHID ="+branchid+" AND CHR_ITEMID='"+itemid+"' ORDER BY INT_ROWID desc ";
					String ccdata[][] =CommonFunctions.QueryExecute(sql);
					double averageprice =0;
					if(ccdata.length>0)
						averageprice=Double.parseDouble(ccdata[0][0]);
					
					sql = "INSERT INTO inv_t_vendorgoodsreceivedconsumable  ";
					sql = sql+" (INT_DIVIID,INT_BRANCHID,CHR_SALESNO,CHR_TYPE,CHR_ITEMID,INT_SQTY,  ";
					sql = sql+" CHR_RDSTATUS,DOU_SALESUNITPRICE,";
					sql = sql + " INT_STOCK,DOU_AVGPRICE ,CHR_INVOICEBLOCK,";
					sql = sql + " CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS  )  "; 
					sql = sql+" VALUES(?,?,?,?,?,?,?,?,?, ?,?,?,DATE(NOW()),'Y' )";
					apstm = con.prepareStatement(sql);
					apstm.setString(1,division );
					apstm.setString(2,branchid );
					apstm.setString(3,SwapSaleNo );
					apstm.setString(4,itype );
					apstm.setString(5,itemid );
					apstm.setString(6,""+pqty );
					apstm.setString(7,"O" );
					apstm.setString(8,request.getParameter("uprice"+param[p].trim()) );
					if((stock-pqty) < 1)
					{
						apstm.setString(9,"0" );
						apstm.setString(10,""+averageprice);
					}
					else
					{
						apstm.setString(9,""+(stock-pqty) );
						apstm.setString(10,""+averageprice );
					} 
					apstm.setString(11,blockinvoice );
					apstm.setString(12,userId );
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
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
	
	
	
	@SuppressWarnings("static-access")
	public synchronized  void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	 {
		try
		{
				String action=request.getParameter("actionS");
				HttpSession session=request.getSession();			
				String userId=""+session.getAttribute("USRID");
				String branchid = session.getAttribute("INVBRANCH").toString();
				
				Statement st = con.createStatement();
				String sql="";
				if(action.equals("INVSwapSaleAdd"))
				{					
					SwapSale d = new  SwapSale();
					@SuppressWarnings("rawtypes")
					Map map=request.getParameterMap();
					BeanUtils.populate(d,map);
					DirectSaleMethod.addSwapSale(con,apstm, d, request, response);
					String SwapSaleNo ="";
					String Invno=""+session.getAttribute("INVNO");
					SwapSaleNo =Invno;
					blockinvoice = d.getBlockinvoice();//CHR_INVOICEBLOCK
					itemInsert(request,response,SwapSaleNo,con,st,branchid,d.getDivision());
					//Insert the Payment commitment table
					int noofpayment = Integer.parseInt(request.getParameter("noofpaymentcommitment"));
					for(int h=0;h<noofpayment;h++)
					{
						sql="INSERT INTO inv_t_paymentcommitment (CHR_SALESNO,CHR_INVOICETYPE,DOU_ACTUALAMOUNT) VALUE('"+SwapSaleNo+"','C',"+request.getParameter("nettotal")+")";
						System.out.println(""+sql);
						CommonFunctions.Execute(sql);
					}
					con.close();   
					response.sendRedirect("Smart Inventory/SwapSaleSerial.jsp?salno="+SwapSaleNo);
				}
				else if("INVSwapSaleAddserial".equals(action))
			    {
					String salesno =request.getParameter("salesno").trim();
					String length =request.getParameter("length").trim();
					String division =request.getParameter("division").trim();
				    String reqdt =request.getParameter("reqdt").trim();
					sql ="";
					int swaprow=0;
					int removerow=0;
					double contributionamount=0.0;
					double serialamount=0.0;
					System.out.println("\n\n");
					boolean finalflag = false;
					String wrongserialnumber="";
					if(Integer.parseInt(length)>=1)
					{
						if(DirectSaleMethod.checkSerialNumberSale(con,request, response))
						{
							System.out.println("All the serial numbers are correct...");
							finalflag = true;;
							for(int u=1; u<=Integer.parseInt(length);u++)
							{
								String item=request.getParameter("item"+u).trim();
								String itype=request.getParameter("itype"+u).trim();
								String Warrantys=request.getParameter("Warrantys"+u).trim();
								String topswap=request.getParameter("topswap"+u).trim();
								String serial=request.getParameter("serial"+u).trim();
								String rowid=request.getParameter("rowid"+u).trim();
								String saleunitprice=request.getParameter("saleunitprice"+u).trim();
								String swapdescription="";
								sql = "SELECT DOU_UNITPRICE  FROM  inv_t_vendorgoodsreceived WHERE CHR_SERIALNO='"+serial.trim()+"'";
								String camount[][] =CommonFunction.doubleRecordSetArraywithCon(con,sql);
								
								// = contributionamount+Double.parseDouble(camount[0][0]);
								serialamount=Double.parseDouble(camount[0][0]);
								String swapdesc="";
								String removedesc="";
								double samount=0.0;
								double ramount=0.0;
								String sdesc="";
								//mythraaaaaaaaaaaaaa
								
								//Swapping  or Product
								if("Y".equals(topswap)&& "P".equalsIgnoreCase(itype))
								{
									swapdesc="";
									sql = "SELECT CHR_ITEMLIST FROM inv_m_produtlist WHERE CHR_PRODUCTID='"+item+"'";
									String ppitemlist[] = CommonFunctions.QueryExecutecon(con, sql)[0][0].split("~");
									swapdescription=request.getParameter("swapdescription"+u).trim();
									
									//SWAPPING HERE Changeable Items in the product
									 for(int c=0;c<ppitemlist.length;c++)
									 {
										swaprow=swaprow+1;
										String SwapCheckbox =""+request.getParameter("SwapCheckbox"+swaprow);
										if("on".equals(SwapCheckbox ))
										{
											String SwapSerial =""+request.getParameter("SwapSerial"+swaprow).trim();
											String SwapWarranty =""+request.getParameter("SwapWarranty"+swaprow).trim();
											String Swapprice =""+request.getParameter("Swapprice"+swaprow).trim();
											String swapitem =""+request.getParameter("swapitem"+swaprow).trim();
											String SSwapSerial =""+request.getParameter("SSwapSerial"+swaprow).trim();
											sql = "SELECT DOU_UNITPRICE  FROM  inv_t_vendorgoodsreceived WHERE CHR_SERIALNO='"+SSwapSerial+"'";
											String ssamount[][] =CommonFunction.doubleRecordSetArraywithCon(con, sql);
											String SSwapprice =ssamount[0][0];
											samount = samount+Double.parseDouble(Swapprice);
											ramount = ramount +Double.parseDouble(SSwapprice);
											swapdesc=swapdesc+" Changable Materials ::  ";
											swapdesc=swapdesc+" Removed Materials  :: ";
											swapdesc=swapdesc+ ppitemlist[c]+" / " +SwapSerial;
											swapdesc=swapdesc+" Added Materials  :: ";
											swapdesc=swapdesc+ swapitem +" / " +SSwapSerial;
											sdesc=sdesc+swapitem+",";
											
											//material inward to stock according to sales no...
											asql = " INSERT INTO inv_t_swapserial ";
											asql = asql + " ( INT_BRANCHID,CHR_SALESNO,CHR_TYPE,CHR_ITEMID,DAT_SWAPDATE, "; 
											asql = asql + " CHR_SERIALNO,CHR_WARRANTY,DOU_UNITPRICE,CHR_FLAG, ";
											asql = asql + " CHR_USRNAME,CHR_ACTION,CHR_SWAPPING_SERIALNO,DT_UPDATEDATE,CHR_UPDATESTATUS ) ";
											asql = asql + " VALUES (";
											asql = asql + " ?,?,?,?,DATE(NOW()) , "; 
											asql = asql + " ?,?,?,'N', ";
											asql = asql + " ?,?,?,DATE(NOW()),'Y'   ";
											asql = asql + " ) ";
											apstm = con.prepareStatement(asql);
											apstm.setString(1,branchid); 
											apstm.setString(2,salesno); 
											apstm.setString(3,"I"); 
											apstm.setString(4,ppitemlist[c]); 
											apstm.setString(5,SwapSerial); 
											apstm.setString(6,SwapWarranty); 
											apstm.setString(7,Swapprice); 
											apstm.setString(8,auserid);
											apstm.setString(9,"C"); 
											apstm.setString(10,SSwapSerial);//serial SSwapSerial
											System.out.println("----------- Swap     "+apstm);
											apstm.execute();
											apstm.close();
		 									
											//insert int goods received
											String pno=CommonFunctions.QueryExecutecon(con,"SELECT CHR_PURCHASEORDERNO FROM inv_t_vendorgoodsreceived WHERE CHR_SERIALNO='"+SSwapSerial.trim()+"'")[0][0];
											asql = "INSERT INTO inv_t_vendorgoodsreceived (INT_BRANCHID,CHR_PURCHASEORDERNO,";
											asql = asql +" CHR_TYPE,CHR_ITEMID,CHR_RECIVEDID,DAT_RECIVEDDATE ,CHR_RECEIVEDMODE,";
											asql = asql +" CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS,CHR_SERIALNO,CHR_WARRANTY,";
											asql = asql +" DOU_UNITPRICE,DAT_PURCHASE_WARRANTY_START,DAT_PURCHASE_WARRANTY_END,CHR_SWAPPING_SERIALNO,INT_DIVIID  ) VALUES ( ";
											asql = asql +" ? , ";
											asql = asql+" ? , ";
											asql = asql+" ? , ";
											asql = asql+" ? , ";
											asql = asql+" ? , ";
											asql = asql+" DATE(NOW()) , 'S',";
											asql = asql +"?, ";
											asql = asql +" DATE(NOW()) , 'Y' , ";
											asql = asql +"?, ";
											asql = asql +"  ? ,?,DATE(NOW()), ";
											asql = asql +"  DATE_FORMAT(DATE_ADD(DATE(NOW()), INTERVAL "+SwapWarranty+" YEAR),'%Y-%m-%d'),  ";
											asql = asql +" ? ,?) ";
											apstm = con.prepareStatement(asql);
											apstm.setString(1,branchid); 
											apstm.setString(2,pno); //salesno
											apstm.setString(3,"I"); 
											apstm.setString(4,ppitemlist[c]); 
											apstm.setString(5,salesno); 
											apstm.setString(6,userId); 
											apstm.setString(7,SwapSerial); 
											apstm.setString(8,SwapWarranty);
											apstm.setString(9,Swapprice); 
											apstm.setString(10,serial);//serial SSwapSerial
											apstm.setString(11,division );
											System.out.println("----------- Swap      "+apstm);
											apstm.execute();
											apstm.close();
											st.execute(sql);
											
											
										 	
											//Stock Updation insertion required
											//material Swaped to stock according to sales no...	
											asql = "UPDATE inv_t_vendorgoodsreceived SET";
											asql = asql+" CHR_FLAG ='Y'  , CHR_SALESNO=?,CHR_SALEWARRANTY=?, DOU_SALEUNITPRICE=?, DT_SALEDATE=? , CHR_USRNAME=? , DT_UPDATEDATE = DATE(NOW()) ,CHR_UPDATESTATUS='Y' ,";
											asql = asql+" DAT_SALES_WARRANTY_START=DATE(NOW()),DAT_SALES_WARRANTY_END=( SELECT DATE_FORMAT(DATE_ADD(DATE(NOW()), INTERVAL "+Warrantys+" YEAR),'%Y-%m-%d') )   ";
											asql = asql+" WHERE CHR_ITEMID =? AND CHR_TYPE='I' AND CHR_SERIALNO=? AND CHR_FLAG='N'";
											apstm = con.prepareStatement(asql);
											apstm.setString(1,salesno);
											apstm.setString(2,Warrantys);
											apstm.setString(3,saleunitprice); 
											apstm.setString(4,reqdt); 
											apstm.setString(5,auserid); 
											apstm.setString(6,swapitem); 
											apstm.setString(7,SSwapSerial); 
											System.out.println(""+apstm);
											apstm.execute();
											apstm.close();
											
											asql = "UPDATE inv_t_directpurchase SET CHR_SALEFLAG='Y'  WHERE CHR_PURCHASEORDERNO=?";
											apstm = con.prepareStatement(asql);
											//String pno=CommonFunctions.QueryExecute("SELECT CHR_PURCHASEORDERNO FROM inv_t_vendorgoodsreceived WHERE CHR_SERIALNO='"+SSwapSerial.trim()+"'")[0][0];
											apstm.setString(1,pno); 
											System.out.println(""+apstm);
											apstm.execute();
											apstm.close();	
											
											//update inv_t_directsale is swapping or not 
											asql="UPDATE inv_t_directsales SET CHR_SALESTYPE='S' WHERE CHR_SALESNO =?";
											apstm = con.prepareStatement(asql);
											apstm.setString(1,salesno);
											System.out.println(""+apstm);
											apstm.execute();
											apstm.close();
										}
									}
									 
									 
									 
									 
									//==================================
									//Removable Items in the product
									//==================================
									for(int c=0;c<ppitemlist.length;c++)
									{
										removerow=removerow+1;
										String RemoveCheckbox =""+request.getParameter("RemoveCheckbox"+removerow);
										if("on".equals(RemoveCheckbox ))
										{
											String RemoveSerial =""+request.getParameter("RemoveSerial"+removerow).trim();
											String RemoveWarranty =""+request.getParameter("RemoveWarranty"+removerow).trim();
											String Removeprice =""+request.getParameter("Removeprice"+removerow).trim();
											samount = samount+Double.parseDouble(Removeprice);
											removedesc=removedesc+" Removed Materials  :: ";
											removedesc=removedesc+ ppitemlist[c]+" / " +RemoveSerial;
											//material inward to stock according to sales no...
											
											asql = " INSERT INTO inv_t_swapserial ";
											asql = asql + " ( INT_BRANCHID,CHR_SALESNO,CHR_TYPE,CHR_ITEMID,DAT_SWAPDATE, "; 
											asql = asql + " CHR_SERIALNO,CHR_WARRANTY,DOU_UNITPRICE,CHR_FLAG, ";
											asql = asql + " CHR_USRNAME,CHR_ACTION,DT_UPDATEDATE,CHR_UPDATESTATUS ) ";
											asql = asql + " VALUES (";
											asql = asql + " ?,?,?,?,DATE(NOW()) , "; 
											asql = asql + " ?,?,?,'N', ";
											asql = asql + " ?,?,DATE(NOW()),'Y'   ";
											asql = asql + " ) ";
											apstm = con.prepareStatement(asql);
											apstm.setString(1,branchid); 
											apstm.setString(2,salesno); 
											apstm.setString(3,"I"); 
											apstm.setString(4,ppitemlist[c]); 
											apstm.setString(5,RemoveSerial); 
											apstm.setString(6,RemoveWarranty); 
											apstm.setString(7,Removeprice); 
											apstm.setString(8,auserid);
											apstm.setString(9,"R"); 
											System.out.println("----------- remove     "+apstm);
											apstm.execute();
											apstm.close();
											
											String pno=CommonFunctions.QueryExecutecon(con,"SELECT CHR_PURCHASEORDERNO FROM inv_t_vendorgoodsreceived WHERE CHR_SERIALNO='"+serial.trim()+"'")[0][0];
											asql = "INSERT INTO inv_t_vendorgoodsreceived (INT_BRANCHID,CHR_PURCHASEORDERNO,";
											asql = asql +" CHR_TYPE,CHR_ITEMID,CHR_RECIVEDID,DAT_RECIVEDDATE ,CHR_RECEIVEDMODE,";
											asql = asql +" CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS,CHR_SERIALNO,CHR_WARRANTY,";
											asql = asql +" DOU_UNITPRICE ,DAT_PURCHASE_WARRANTY_START,DAT_PURCHASE_WARRANTY_END,INT_DIVIID  ) VALUES ( ";
											asql = asql +" ?, ";
											asql = asql+" ? , ";
											asql = asql+" ? , ";
											asql = asql+" ? , ";
											asql = asql+" ? , ";
											asql = asql+" DATE(NOW()) , 'S',";
											asql = asql +"?, ";
											asql = asql +" DATE(NOW()) , 'Y' , ";
											asql = asql +"?, ";
											asql = asql +"  ? ,?,DATE(NOW()), ";
											asql = asql +"  ( SELECT DATE_FORMAT(DATE_ADD(DATE(NOW()), INTERVAL "+RemoveWarranty+" YEAR),'%Y-%m-%d') ) ,  ";
											asql = asql +" ? ) ";
											apstm = con.prepareStatement(asql);
											apstm.setString(1,branchid); 
											apstm.setString(2,pno); //salesno
											apstm.setString(3,"I"); 
											apstm.setString(4,ppitemlist[c]); 
											apstm.setString(5,salesno); 
											apstm.setString(6,userId); 
											apstm.setString(7,RemoveSerial); 
											apstm.setString(8,RemoveWarranty);
											apstm.setString(9,Removeprice);
											apstm.setString(10,division);
											
											System.out.println("----------- Swap      "+apstm);
											apstm.execute();
											apstm.close();
											st.execute(sql);
											
								 		}
										//update inv_t_directsale is swapping or not 
										asql="UPDATE inv_t_directsales SET CHR_SALESTYPE='S' WHERE CHR_SALESNO =?";
										apstm = con.prepareStatement(asql);
										apstm.setString(1,salesno);
										System.out.println(""+apstm);
										apstm.execute();
										apstm.close();
									}
									//==================================
									
									
									
									
									
									//Upgrade description
									sql = " UPDATE inv_t_swapsalesitem SET CHR_DESC=? WHERE INT_BRANCHID=? ";
									sql =sql+ " AND CHR_SALESNO=? AND CHR_ITEMID=? AND CHR_TYPE=?  ";
									apstm= con.prepareStatement(sql);
									apstm.setString(1, swapdescription);
									apstm.setInt(2, Integer.parseInt(branchid));
									apstm.setString(3, salesno);
									apstm.setString(4, item);
									apstm.setString(5, itype);
									System.out.println(""+apstm);
									apstm.execute();
									apstm.close();
									
									//total product updation
									sql = " UPDATE inv_t_swapsalesserialno SET  CHR_SERIALNO=? ,CHR_WARRANTY=?,";
									sql =sql+ " CHR_SWAPDESC=? ,CHR_SALESNO=? ,CHR_DESC=? WHERE INT_BRANCHID=? ";
									sql =sql+ " AND CHR_SALESNO=? AND CHR_ITEMID=? AND CHR_TYPE=? AND INT_ID=?";
									apstm = con.prepareStatement(sql);
									apstm.setString(1, serial);
									apstm.setString(2, Warrantys);
									apstm.setString(3, swapdesc+removedesc);//+
									apstm.setString(4, salesno);
									apstm.setString(5, swapdescription);
									apstm.setInt(6, Integer.parseInt(branchid));
									apstm.setString(7, salesno);
									apstm.setString(8, item);
									apstm.setString(9, itype);
									apstm.setString(10, rowid);
									System.out.println(""+apstm);
									apstm.execute();
									apstm.close();
									
									//Sales Updation flag set to be "Y"
									sql = "UPDATE inv_t_vendorgoodsreceived SET";
									sql = sql+" CHR_FLAG =? , CHR_SALESNO=?,DOU_SALEUNITPRICE=?,CHR_SALEWARRANTY=?, DT_SALEDATE=?,";
									sql =sql+ " CHR_USRNAME=?,DT_UPDATEDATE=DATE(NOW()),CHR_UPDATESTATUS=?,";			
									sql =sql+ " DAT_SALES_WARRANTY_START=?,DAT_SALES_WARRANTY_END=( SELECT DATE_FORMAT(DATE_ADD('"+reqdt+"', INTERVAL "+Warrantys+" YEAR),'%Y-%m-%d') )   ";
									sql = sql+" WHERE CHR_ITEMID =? AND CHR_TYPE=? AND CHR_SERIALNO=? AND CHR_FLAG='N' ";
									apstm = con.prepareStatement(sql);
									apstm.setString(1,"Y");
									apstm.setString(2,salesno);
									apstm.setString(3,saleunitprice);
									apstm.setString(4, Warrantys);
									apstm.setString(5, reqdt);
									apstm.setString(6, userId );
									apstm.setString(7, "Y");
									apstm.setString(8, reqdt);
									apstm.setString(9, item);
									apstm.setString(10, itype);
									apstm.setString(11, serial);
									System.out.println(""+apstm);
									apstm.execute();
									apstm.close();
									// System.out.println(""+pst);
									
									
									String pno= CommonFunctions.QueryExecutecon(con, "SELECT CHR_PURCHASEORDERNO FROM inv_t_vendorgoodsreceived WHERE CHR_SERIALNO='"+serial+"'")[0][0] ;
									sql = "UPDATE inv_t_directpurchase SET CHR_SALEFLAG='Y'  WHERE CHR_PURCHASEORDERNO=?";
									apstm = con.prepareStatement(sql);
									apstm.setString(1, pno);
									System.out.println(""+apstm);
									apstm.execute();
									apstm.close();
							}
								else
								{
									//update serialnumber and warranty
									swapdesc="";
									sql = " UPDATE inv_t_swapsalesserialno SET  CHR_SERIALNO=? ,CHR_WARRANTY=?, ";
									sql = sql+" CHR_SWAPDESC=? ,CHR_SALESNO=? WHERE INT_BRANCHID=? ";
									sql = sql+" AND CHR_SALESNO=? AND CHR_ITEMID=? AND CHR_TYPE=? AND INT_ID=?";
									apstm = con.prepareStatement(sql);
									apstm.setString(1, serial);
									apstm.setString(2, Warrantys);
									apstm.setString(3, swapdesc);
									apstm.setString(4, salesno);
									apstm.setInt(5, Integer.parseInt(branchid));
									apstm.setString(6, salesno);
									apstm.setString(7, item);
									apstm.setString(8, itype);
									apstm.setString(9, rowid);
									System.out.println(""+apstm);
									apstm.execute();
									apstm.close();
									
									//Sales Updation flag set to be "Y"
									sql = "UPDATE inv_t_vendorgoodsreceived SET";
									sql = sql+" CHR_FLAG =? , CHR_SALESNO=?, DOU_SALEUNITPRICE=?, DT_SALEDATE=?,CHR_SALEWARRANTY=?,";
									sql = sql+" CHR_USRNAME=?,DT_UPDATEDATE=DATE(NOW()),CHR_UPDATESTATUS=? , ";
									sql =sql+ " DAT_SALES_WARRANTY_START=?,DAT_SALES_WARRANTY_END=( SELECT DATE_FORMAT(DATE_ADD('"+reqdt+"', INTERVAL "+Warrantys+" YEAR),'%Y-%m-%d') )   ";
									sql = sql+" WHERE CHR_ITEMID =? AND CHR_TYPE=? AND CHR_SERIALNO=? AND CHR_FLAG ='N'";
									apstm = con.prepareStatement(sql);
									apstm.setString(1,"Y");
									apstm.setString(2,salesno);
									apstm.setString(3,saleunitprice);
									apstm.setString(4, reqdt);
									apstm.setString(5, Warrantys);
									apstm.setString(6, userId );
									apstm.setString(7, "Y");
									apstm.setString(8, reqdt);
									apstm.setString(9, item);
									apstm.setString(10, itype);
									apstm.setString(11, serial);
									System.out.println(""+apstm);
									apstm.execute();
									// System.out.println(""+apstm);
									apstm.close();
									
									String pno= CommonFunctions.QueryExecutecon(con, "SELECT CHR_PURCHASEORDERNO FROM inv_t_vendorgoodsreceived WHERE CHR_SERIALNO='"+serial+"'")[0][0] ;
									sql = "UPDATE inv_t_directpurchase SET CHR_SALEFLAG='Y'  WHERE CHR_PURCHASEORDERNO=?";
									apstm = con.prepareStatement(sql);
									apstm.setString(1, pno);
									System.out.println(""+apstm);
									apstm.execute();
									apstm.close();
									
								}
															
								//calculating contribution amount...
								contributionamount = contributionamount+serialamount -samount+ramount;
								System.out.println();
								System.out.println("rows =="+(u)+". seraial-"+serialamount+"-samount-"+samount+"-ramount-"+ramount );
							
							}
						}
						else
						{
							wrongserialnumber = DirectSaleMethod.getWrongSerialNumberforSale(con,request, response);
						}
						
					}
					else
					{
						System.out.println("Only consumables");
						finalflag = true;;
					}
					
					
					
					if(finalflag)
					{	
						@SuppressWarnings("unused")
						double avgsum=0;
						@SuppressWarnings("unused")
						String ksql="";
						sql = "UPDATE inv_t_directsales SET INT_SALESSTATUS=1 WHERE CHR_SALESNO='"+salesno+"'";
						st.execute(sql);
						asql = " SELECT ";   
						asql = asql + " a.CHR_REF,a.INT_REF_PERCENTAGE1, ";
						asql = asql + " a.CHR_REF1,a.INT_REF_PERCENTAGE2,  ";
						asql = asql + " a.CHR_REF2,a.INT_REF_PERCENTAGE3,  ";
						asql = asql + " SUM(b.INT_QUANTITY*b.DOU_UNITPRICE),  ";
						asql = asql + " (SELECT MONTH('"+request.getParameter("reqdt")+"')), ";
						asql = asql + " (SELECT YEAR('"+request.getParameter("reqdt")+"'))" ;
						asql = asql + " FROM inv_t_directsales a , inv_t_swapsalesitem b WHERE ";
						asql = asql + " a.CHR_SALESNO = b.CHR_SALESNO ";
						asql = asql + " AND a.CHR_SALESNO='"+salesno+"' ";
						asql = asql + " GROUP BY a.CHR_SALESNO ";
						 
						String condata[][] = CommonFunctions.QueryExecutecon(con,asql);
						if(condata.length>0)
						{
							String empid1 =condata[0][0];
							double percentage1 = Double.parseDouble(condata[0][1]);
							String empid2 =condata[0][2];
							double percentage2 =Double.parseDouble(condata[0][3]);
							String empid3 =condata[0][4];
							double percentage3 =Double.parseDouble(condata[0][5]);
							double saleamout =Double.parseDouble(condata[0][6]);
							
							String monthname=condata[0][7];
							String year=condata[0][8];
							
							contributionamount = contributionamount + Double.parseDouble(request.getParameter("conribution"));
							
							//percentage1
							if(percentage1>=1)
							{
								asql = "INSERT INTO inv_t_contribution (CHR_EMPID,CHR_MONTH,INT_YEAR,CHR_SALESNO," +
								"DAT_SALESDATE,DOU_AMOUNT1,DOU_AMOUNT2,DOU_AMOUNT3,DOU_CONTRIBUTION," +
								"CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS,DOU_PAMOUNT,DOU_SAMOUNT ,INT_PERCENTAGE)";
								asql = asql+" VALUES (?,?,?,?,?,?,?,?,?,?,DATE(NOW()),'Y',?,?,? )";
						
								apstm = con.prepareStatement(asql);
								apstm.setString(1, empid1);
								apstm.setString(2, monthname);
								apstm.setString(3, year); 
								apstm.setString(4, salesno );
								apstm.setString(5, request.getParameter("reqdt") );
								apstm.setString(6, ""+Double.parseDouble(request.getParameter("conribution")) );//adjustment value
								apstm.setString(7, ""+ contributionamount);//purchase
								apstm.setString(8, ""+saleamout );//sales
								
								apstm.setString(9,""+((saleamout-contributionamount) *percentage1/100) );// contribution
								
								apstm.setString(10, userId );
								apstm.setString(11, ""+contributionamount );
								apstm.setString(12, ""+saleamout );
								apstm.setString(13, ""+percentage1 );
								System.out.println(""+apstm);
								apstm.execute();
								apstm.close();
							}
							
							if(percentage2>=1)
							{
								asql = "INSERT INTO inv_t_contribution (CHR_EMPID,CHR_MONTH,INT_YEAR,CHR_SALESNO," +
								"DAT_SALESDATE,DOU_AMOUNT1,DOU_AMOUNT2,DOU_AMOUNT3,DOU_CONTRIBUTION," +
								"CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS,DOU_PAMOUNT,DOU_SAMOUNT ,INT_PERCENTAGE)";
								asql = asql+" VALUES (?,?,?,?,?,?,?,?,?,?,DATE(NOW()),'Y',?,?,? )";
						
								apstm = con.prepareStatement(asql);
								apstm.setString(1, empid2);
								apstm.setString(2, monthname);
								apstm.setString(3, year); 
								apstm.setString(4, salesno );
								apstm.setString(5, request.getParameter("reqdt") );
								apstm.setString(6, ""+Double.parseDouble(request.getParameter("conribution")) );//adjustment value
								apstm.setString(7, ""+ contributionamount);//purchase
								apstm.setString(8, ""+saleamout );//sales
								
								apstm.setString(9,""+((saleamout-contributionamount) *percentage2/100) );// contribution
								
								apstm.setString(10, userId );
								apstm.setString(11, ""+contributionamount );
								apstm.setString(12, ""+saleamout );
								apstm.setString(13, ""+percentage2 );
								System.out.println(""+apstm);
								apstm.execute();
								apstm.close();
						
							}
							
							if(percentage3>=1)
							{
								asql = "INSERT INTO inv_t_contribution (CHR_EMPID,CHR_MONTH,INT_YEAR,CHR_SALESNO," +
								"DAT_SALESDATE,DOU_AMOUNT1,DOU_AMOUNT2,DOU_AMOUNT3,DOU_CONTRIBUTION," +
								"CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS,DOU_PAMOUNT,DOU_SAMOUNT ,INT_PERCENTAGE)";
								asql = asql+" VALUES (?,?,?,?,?,?,?,?,?,?,DATE(NOW()),'Y',?,?,? )";
						
								apstm = con.prepareStatement(asql);
								apstm.setString(1, empid3);
								apstm.setString(2, monthname);
								apstm.setString(3, year); 
								apstm.setString(4, salesno );
								apstm.setString(5, request.getParameter("reqdt") );
								apstm.setString(6, ""+Double.parseDouble(request.getParameter("conribution")) );//adjustment value
								apstm.setString(7, ""+ contributionamount);//purchase
								apstm.setString(8, ""+saleamout );//sales
								apstm.setString(9,""+((saleamout-contributionamount) *percentage3/100) );// contribution
								apstm.setString(10, userId );
								apstm.setString(11, ""+contributionamount );
								apstm.setString(12, ""+saleamout );
								apstm.setString(13, ""+percentage3 );
								System.out.println(""+apstm);
								apstm.execute();
								apstm.close();
							}
						}
						
						
						//Mail trigger
						String mdata[][] = CommonFunctions.QueryExecute("SELECT  CHR_MAILENABLE ,CHR_INVOICEDELETE FROM m_inventorysetting  WHERE INT_ROWID=1");
						if(mdata.length>0){
							System.out.println("******************************** MAIL TRIGGER START **********************************");
							if(mdata[0][0].equals("Y")){
								String subject ="SALES INVOICE:";
								String empmaildata[][] = CommonFunctions.QueryExecute("SELECT a.CHR_EMAILID FROM com_m_staff a, inv_t_directsales b  WHERE a.CHR_EMPID = b.CHR_REF AND b.CHR_SALESNO = '"+salesno+"'");
								String email =mdata[0][1];
								if(empmaildata.length >0 && empmaildata[0][0].length()>0)
								{
									email = email +","+ empmaildata[0][0];
								}
								
								System.out.println("******************************** MAIL IDS "+email+" **********************************");
								String a[] =(email).split(",") ;
								String content = InvoiceHTMLMail.employeeBasedMailContent(salesno, branchid, session, request.getRealPath("/")); 
								String[] attachments = new String [2];
								attachments[0] =Path+"images\\Header.png";
								attachments[1] =  Path+"images\\logo.jpg";
								if(!"".equals(email) || !"null".equals(email) )
									InvMail.sendEmailWithAttachments(a, subject+": "+salesno, content, attachments);
							}
							System.out.println("******************************** MAIL TRIGGER END **********************************");
						}
						
						/*
						 
						 
						 String salesno =request.getParameter("salesno");
					String subject =request.getParameter("subject");
					String email =request.getParameter("email");
					String a[] =(email+",").split(",") ;
					System.out.println("======");
					String content = InvoiceHTMLMail.mailContent(salesno, branchid, session, request.getRealPath("/")); 
					System.out.println("******************************************************************************");
					System.out.println(content);
					System.out.println("******************************************************************************");
					String[] attachments = new String [2];
					attachments[0] =Path+"images\\Header.png";
					attachments[1] =  Path+"images\\logo.jpg";
					
					
					if(!"".equals(email) || !"null".equals(email) )
						InvMail.sendEmailWithAttachments(a, subject+": "+salesno, content, attachments);
					
					  
						 */
						response.sendRedirect("Smart Inventory/PaymentCommitmentEdit.jsp?salno="+salesno+"&Billinttype=C");	
					}
					else
					{
						response.sendRedirect("Smart Inventory/swapserialcheck.jsp?salno="+salesno+"&wrongserialnumber="+wrongserialnumber);
					}
				//===============================Swap serial end
				
			}
				else if(action.equals("INVSwapSaleDelete"))
				{
					String sales = request.getParameter("saleno");
					String reason = request.getParameter("reason");
					String email = request.getParameter("email");
					sales=sales+",";
					String salnos[] = sales.split(",");
					for(int s=0; s<salnos.length;s++)
					{
							sql = "SELECT INT_SALESSTATUS,CHR_ROOT,CHR_CPONUMBER FROM inv_t_directsales WHERE CHR_SALESNO='"+salnos[s]+"'";
							String dt[][] = CommonFunctions.RecordSetArray(con, sql);
							if("0".equals(dt[0][0]))
							{
								asql = "DELETE FROM inv_t_directsales WHERE CHR_SALESNO=?";
								apstm = con.prepareStatement(asql);
								apstm.setString(1, salnos[s]);
								System.out.println(""+apstm);
								apstm.execute();
								apstm.close();
								
								//RESET TO CUSTOMER PURCHASE ORDER
								if("C".equals(dt[0][1]))
								{
									asql = "SELECT CHR_TYPE, CHR_ITEMID ,INT_QUANTITY FROM inv_t_swapsalesitem WHERE CHR_SALESNO ='"+salnos[s]+"'";
									String data[][] = CommonFunctions.QueryExecute(asql);
									if(data.length>0)
									{
										asql = " UPDATE inv_t_customersalesorderitem SET ";
										asql = asql + " INT_BILLEDQUANTITY = ( INT_BILLEDQUANTITY - ? )";
										asql = asql + " WHERE CHR_TYPE=? ";
										asql = asql + " AND CHR_ITEMID =? ";
										asql = asql + " AND CHR_SALESORDERNO=?";
										for(int u=0;u<data.length;u++)
										{
											apstm = con.prepareStatement(asql);
											apstm.setInt(1,Integer.parseInt(data[u][2]));
											apstm.setString(2,data[u][0]);
											apstm.setString(3,data[u][1]);
											apstm.setString(4,dt[0][2]);
											System.out.println(""+apstm);
											apstm.addBatch();
										}
										apstm.executeBatch();
										
										asql = " UPDATE  inv_t_customersalesorder SET CHR_BILLED ='P'";
										asql = asql + " WHERE CHR_SALESORDERNO =?";
										apstm = con.prepareStatement(asql);
										apstm.setString(1,dt[0][2]);
										System.out.println(""+apstm);
										apstm.execute();
									}
									
								}
								
								asql = "DELETE FROM inv_t_swapsalesitem WHERE CHR_SALESNO=?";
								apstm = con.prepareStatement(asql);
								apstm.setString(1, salnos[s]);
								System.out.println(""+apstm);
								apstm.execute();
								apstm.close();
								
								asql = "DELETE FROM inv_t_swapsalesserialno WHERE CHR_SALESNO=?";
								apstm = con.prepareStatement(asql);
								apstm.setString(1, salnos[s]);
								System.out.println(""+apstm);
								apstm.execute();
								apstm.close();
								
								asql = "DELETE FROM inv_t_vendorgoodsreceivedconsumable WHERE CHR_SALESNO=?";
								apstm = con.prepareStatement(asql);
								apstm.setString(1, salnos[s]);
								System.out.println(""+apstm);
								apstm.execute();
								apstm.close();
								
								asql = "DELETE FROM inv_t_contribution WHERE CHR_SALESNO=?";
								apstm = con.prepareStatement(asql);
								apstm.setString(1, salnos[s]);
								System.out.println(""+apstm);
								apstm.execute();
								apstm.close();
								
								
								
								asql = " SELECT DOU_PAIDAMOUNT, if(INT_ADVANCEID > 0,'Advance adjust',''),INT_ADVANCEID " ;
								asql = asql + " FROM inv_t_customersalespayment WHERE INT_ADVANCEID >0 AND  CHR_SALESORDERNO ='"+salnos[s]+"'"; 
								String advanceData[][] =CommonFunctions.QueryExecute(asql);
								if(advanceData.length>0)
								{
									for(int h=0;h<advanceData.length;h++)
									{
										asql = " UPDATE inv_t_advancepayment SET DOU_TRANSFERAMOUNT= (DOU_TRANSFERAMOUNT-"+advanceData[h][0]+" ) ";
										asql = asql + "  WHERE INT_ADVANCEID = ? ";
										apstm = con.prepareStatement(asql);
										apstm.setString(1,advanceData[h][2] );
										System.out.println(""+apstm);
										apstm.execute();
										apstm.close();
									}
								}
								
								asql = "DELETE FROM inv_t_customersalespayment WHERE CHR_SALESORDERNO=?";
								apstm = con.prepareStatement(asql);
								apstm.setString(1, salnos[s]);
								System.out.println(""+apstm);
								apstm.execute();
								apstm.close();
								
								
								
								asql = "DELETE FROM inv_t_directsales_installation WHERE CHR_SALESNO=?";
								apstm = con.prepareStatement(asql);
								apstm.setString(1, salnos[s]);
								System.out.println(""+apstm);
								apstm.execute();
								apstm.close();
								
								asql = "SELECT CHR_SERIALNO FROM inv_t_swapserial WHERE CHR_SALESNO= '"+salnos[s]+"'";
								String datas[][] =CommonFunctions.QueryExecute(asql);
								if(datas.length>0)
								{
									asql = "DELETE FROM inv_t_vendorgoodsreceived WHERE CHR_SERIALNO=?";
									apstm = con.prepareStatement(asql);
									for(int x=0;x<datas.length;x++)
									{
										apstm.setString(1,datas[x][0]);
										apstm.addBatch();
									}
									System.out.println(""+apstm);
									apstm.executeBatch();
									apstm.close();
								}
								
								asql = "DELETE FROM inv_t_swapserial WHERE CHR_SALESNO=?";
								apstm = con.prepareStatement(asql);
								apstm.setString(1, salnos[s]);
								System.out.println(""+apstm);
								apstm.execute();
								apstm.close();
								
								asql = "DELETE FROM inv_t_paymentcommitment WHERE CHR_SALESNO=? AND CHR_INVOICETYPE=?";
								apstm = con.prepareStatement(asql);
								apstm.setString(1, salnos[s]);
								apstm.setString(2, "C");
								System.out.println(""+apstm);
								apstm.execute();
								apstm.close();
								
							}
							
							asql =" INSERT INTO inv_t_directsalesdelete (INT_BRANCHID,CHR_SALESNO,CHR_DES,DAT_DELETEDATE,CHR_INVOICEMODE,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS) ";
							asql = asql +"VALUES ( "+branchid+", ";
							asql = asql+"'"+salnos[s] +"', ";
							asql = asql+"'"+reason+"', NOW(),'DIRECT BILLING','ADMIN',NOW(),'Y' )";
							apstm = con.prepareStatement(asql);
							apstm.execute();
							apstm.close();
							
							//Send a mail for Delete invoice
							String a[] =(email+","+CommonData.mailid).split(",") ;
							Mail.SimpleHTMLMail(  a,  "DELETE  CUSTOMER SALES BILLING :: "+salnos[s], InvoiceDeletetMail.InvoiceDeletesendtoMail("DELETE  CUSTOMER SALES BILLING :: "+salnos[s],salnos[s],reason, " CUSTOMER SALES BILLING"));
						}

						con.close();   
						response.sendRedirect("Smart Inventory/InventoryMain.jsp");
				}
				else if(action.equals("INVSwapSaleAdminDelete"))
				{
					System.out.println("DIRECT SALE DELETE");
					String salnos = request.getParameter("salesno");
					String reason=request.getParameter("reason");
					String email=request.getParameter("email");
					@SuppressWarnings("unused")
					double avgprice=0;
					@SuppressWarnings("unused")
					double avgsum=0;
					@SuppressWarnings("unused")
					double dbavgprice=0;
					@SuppressWarnings("unused")
					double dbavgsum=0;
					if(DirectSaleMethod.checkSwapSerialSaleornot(salnos, con, request, response))
					{
						 
						asql =" SELECT INT_BRANCHID FROM inv_t_directsales WHERE CHR_SALESNO='"+salnos+"'";
						String bid = CommonFunctions.stringGetAnySelectField(con, asql, "INT_BRANCHID");
						
						asql =" SELECT CHR_FLAG,CHR_SERIALNO,CHR_SALESNO FROM inv_t_vendorgoodsreceived  WHERE CHR_PURCHASEORDERNO ='"+salnos+"' AND INT_BRANCHID="+bid;
						String data[][] = CommonFunctions.RecordSetArray(con, asql);
						String swapserial="";
						boolean transflag = false;
						if(data.length>0)
						{
							for(int u=0;u<data.length;u++)
							{
								if("Y".equals(data[u][0]))
								{	
									transflag = true;
									swapserial=swapserial+data[u][1]+" sold  by "+data[u][2]+",";
								}
							}
						}
						
						if(!transflag)
						{	
							
							asql = "SELECT INT_SALESSTATUS,CHR_ROOT,CHR_CPONUMBER FROM inv_t_directsales WHERE CHR_SALESNO='"+salnos+"'";
							String dt[][] = CommonFunctions.RecordSetArray(con, asql);
							  
							if( dt.length>0)
							{
								//RESET TO CUSTOMER PURCHASE ORDER
								if("C".equals(dt[0][1]))
								{
									asql = "SELECT CHR_TYPE, CHR_ITEMID ,INT_QUANTITY,INT_CPO_ROWID FROM inv_t_swapsalesitem WHERE CHR_SALESNO ='"+salnos+"'";
									String sdata[][] = CommonFunctions.QueryExecute(asql);
									if(sdata.length>0)
									{
										asql = " UPDATE inv_t_customersalesorderitem SET ";
										asql = asql + " INT_BILLEDQUANTITY = ( INT_BILLEDQUANTITY - ? )";
										asql = asql + " WHERE CHR_TYPE=? ";
										asql = asql + " AND CHR_ITEMID =? ";
										asql = asql + " AND CHR_SALESORDERNO=?";
										asql = asql + " AND INT_ID=?";
										apstm = con.prepareStatement(asql);
										for(int u=0;u<sdata.length;u++)
										{
											apstm.setInt(1,Integer.parseInt(sdata[u][2]));
											apstm.setString(2,sdata[u][0]);
											apstm.setString(3,sdata[u][1]);
											apstm.setString(4,dt[0][2]);
											apstm.setString(5,sdata[u][3]);
											System.out.println(""+apstm);
											apstm.addBatch();
										}
										apstm.executeBatch();
										
										asql = " UPDATE  inv_t_customersalesorder SET CHR_BILLED ='P'";
										asql = asql + " WHERE CHR_SALESORDERNO =?";
										apstm = con.prepareStatement(asql);
										apstm.setString(1,dt[0][2]);
										System.out.println(""+apstm);
										apstm.execute();
									}
									
								}
							}
							
							//Delete inv_t_directsales
							asql = "DELETE FROM inv_t_directsales WHERE CHR_SALESNO=?";
							apstm = con.prepareStatement(asql);
							apstm.setString(1, salnos);
							System.out.println(apstm);
							apstm.execute();
							
							//Delete inv_t_swapsalesitem
							asql = "DELETE FROM inv_t_swapsalesitem WHERE CHR_SALESNO=?";
							apstm = con.prepareStatement(asql);
							apstm.setString(1, salnos);
							System.out.println(""+apstm);
							apstm.execute();
							
							//Delete inv_t_swapsalesitem
							asql = "DELETE FROM inv_t_swapsalesserialno WHERE CHR_SALESNO=?";
							apstm = con.prepareStatement(asql);
							apstm.setString(1, salnos);
							System.out.println(""+apstm);
							apstm.execute();
							
							
							//===============================================================
							
							//delete swapping serial number in inv_t_swapserial
							asql ="DELETE FROM  inv_t_swapserial WHERE CHR_SALESNO=?";
							apstm = con.prepareStatement(asql);
							apstm.setString(1,salnos );
							System.out.println(""+apstm);
							apstm.execute();
							apstm.close();
							
							//delete swapping serial number in inv_t_vendorgoodsreceived
							asql ="DELETE FROM  inv_t_vendorgoodsreceived WHERE CHR_RECIVEDID=? AND CHR_FLAG='N'";
							apstm = con.prepareStatement(asql);
							apstm.setString(1,salnos );
							System.out.println(""+apstm);
							apstm.execute();
							apstm.close();
							
							//=======================================================================
							
							
							//DELETE ADVANCE PAYMENT

							asql = " SELECT DOU_PAIDAMOUNT, if(INT_ADVANCEID > 0,'Advance adjust',''),INT_ADVANCEID " ;
							asql = asql + " FROM inv_t_customersalespayment WHERE INT_ADVANCEID >0 AND  CHR_SALESORDERNO ='"+salnos+"'"; 
							String advanceData[][] =CommonFunctions.QueryExecute(asql);
							if(advanceData.length>0)
							{
								for(int h=0;h<advanceData.length;h++)
								{
									asql = " UPDATE inv_t_advancepayment SET DOU_TRANSFERAMOUNT= (DOU_TRANSFERAMOUNT-"+advanceData[h][0]+" ) ";
									asql = asql + "  WHERE INT_ADVANCEID = ? ";
									apstm = con.prepareStatement(asql);
									apstm.setString(1,advanceData[h][2] );
									System.out.println(""+apstm);
									apstm.execute();
									apstm.close();
								}
							}

							
							//Delete inv_t_customersalespayment 
							asql = "DELETE FROM inv_t_customersalespayment WHERE CHR_SALESORDERNO=?";
							apstm = con.prepareStatement(asql);
							apstm.setString(1, salnos);
							System.out.println(""+apstm);
							apstm.execute();
							
							//deleting consuamble;
							asql = "DELETE  FROM inv_t_vendorgoodsreceivedconsumable WHERE CHR_SALESNO='"+salnos+"'";
							apstm = con.prepareStatement(asql);
							System.out.println(""+apstm);
							apstm.execute();
							apstm.close();
							
							//Set sales flag Y to N
							asql =" UPDATE inv_t_vendorgoodsreceived SET CHR_FLAG='N' ,CHR_SALEWARRANTY=null, DAT_SALES_WARRANTY_START=null,DAT_SALES_WARRANTY_END=null ,DOU_SALEUNITPRICE=0, CHR_SALEWARRANTY=null, CHR_SALESNO=null,DT_SALEDATE=null,  CHR_USRNAME='"+ userId +"' , DT_UPDATEDATE = DATE(NOW()) ,CHR_UPDATESTATUS='Y'  WHERE CHR_SALESNO='"+salnos+"'";
							apstm = con.prepareStatement(asql);
							System.out.println(""+apstm);
							apstm.execute();
							apstm.close();
							 
							//deleting split entry records...
							asql="DELETE  FROM inv_t_vendorgoodsreceived WHERE CHR_PURCHASEORDERNO ='"+salnos+"' AND CHR_FLAG='N'";
							apstm = con.prepareStatement(asql);
							System.out.println(""+apstm);
							apstm.execute();
							apstm.close();
							
							//deleting Contribution 
							asql="DELETE  FROM inv_t_contribution WHERE CHR_SALESNO ='"+salnos+"'";
							apstm = con.prepareStatement(asql);
							System.out.println(""+apstm);
							apstm.execute();
							apstm.close();
							
							//deleting Customer payment 
							asql="DELETE  FROM inv_t_customersalespayment WHERE CHR_SALESORDERNO ='"+salnos+"'";
							apstm = con.prepareStatement(asql);
							System.out.println(""+apstm);
							apstm.execute();
							apstm.close();
							
							//Deleting installation table
							asql = "DELETE FROM inv_t_directsales_installation WHERE CHR_SALESNO=?";
							apstm = con.prepareStatement(asql);
							apstm.setString(1, salnos);
							System.out.println(""+apstm);
							apstm.execute();
							apstm.close();
							
							
							//Deleting installation table
							asql = "DELETE FROM inv_t_directsales_installation_postpone WHERE CHR_SALESNO=?";
							apstm = con.prepareStatement(asql);
							apstm.setString(1, salnos);
							System.out.println(""+apstm);
							apstm.execute();
							
							//deleting inv_t_paymentcommitment
							asql = "DELETE FROM inv_t_paymentcommitment WHERE CHR_SALESNO=? AND CHR_INVOICETYPE=?";
							apstm = con.prepareStatement(asql);
							apstm.setString(1, salnos);
							apstm.setString(2, "C");
							System.out.println(""+apstm);
							apstm.execute();
							apstm.close();
							
							asql =" INSERT INTO inv_t_directsalesdelete (INT_BRANCHID,CHR_SALESNO,CHR_DES,DAT_DELETEDATE,CHR_INVOICEMODE,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS) ";
							asql = asql +"VALUES ( "+branchid+", ";
							asql = asql+"'"+salnos+"', ";
							asql = asql+"'"+reason+"', NOW(),'DIRECT SALE','ADMIN',NOW(),'Y' )";
							apstm = con.prepareStatement(asql);
							System.out.println(""+apstm);
							apstm.execute();
								
							//Send a mail for Delete invoice
							String a[] =(email+","+CommonData.mailid).split(",") ;
							com.my.org.erp.mail.Mail.SimpleHTMLMail(a,"DELETE  CUSTOMER SALES BILLING :: "+salnos, InvoiceDeletetMail.InvoiceDeletesendtoMail("DELETE  CUSTOMER SALES BILLING :: "+salnos,salnos,reason, " CUSTOMER SALES BILLING"));
							
							con.close();   
							response.sendRedirect("Smart Inventory/SwapSale.jsp");
						}
						else
						{
							con.close();   
							response.sendRedirect("Smart Inventory/SwapSaleerror.jsp?er="+swapserial);
						}
						System.out.println();
				
					}
					else
					{
						con.close();   
						response.sendRedirect("Smart Inventory/SwapSaleerror.jsp?er=Swapping serial number sold");
					}
				}
				else if(action.equals("INVSwapSaleCancel"))
				{

					System.out.println("DIRECT SALE CANCEL");
					String saleno = request.getParameter("salesno");
					String reason = request.getParameter("reason");
					boolean SwapSerialSale = DirectSaleMethod.checkSwapSerialSaleornot(saleno, con, request, response);
					System.out.println(""+SwapSerialSale);
					if(SwapSerialSale) 
					{	
					
						asql = "UPDATE inv_t_directsales SET DOU_CANCELAMOUNT = DOU_TOTALAMOUNT ,DOU_AMOUNT=0, DOU_DISCOUNT=0,DOU_TAXAMOUNT=0,DOU_TOTALAMOUNT=0,CHR_CANCELDESC =?,CHR_CANCEL='Y', CHR_CANCELID=?,DAT_CANCELDATE=NOW() WHERE CHR_SALESNO=?";
						apstm = con.prepareStatement(asql);
						apstm.setString(1, reason);
						apstm.setString(2, ""+session.getAttribute("EMPID"));
						apstm.setString(3, saleno);
						System.out.println(""+apstm);
						apstm.execute();
						apstm.close();
					
						sql = "SELECT INT_SALESSTATUS,CHR_ROOT,CHR_CPONUMBER FROM inv_t_directsales WHERE CHR_SALESNO='"+saleno+"'";
						String dt[][] = CommonFunctions.RecordSetArray(con, sql);
						if( dt.length>0)
						{
							//RESET TO CUSTOMER PURCHASE ORDER
							if("C".equals(dt[0][1]))
							{
								asql = "SELECT CHR_TYPE, CHR_ITEMID ,INT_QUANTITY,INT_CPO_ROWID FROM inv_t_swapsalesitem WHERE CHR_SALESNO ='"+saleno+"'";
								String data[][] = CommonFunctions.QueryExecute(asql);
								if(data.length>0)
								{
									asql = " UPDATE inv_t_customersalesorderitem SET ";
									asql = asql + " INT_BILLEDQUANTITY = ( INT_BILLEDQUANTITY - ? )";
									asql = asql + " WHERE CHR_TYPE=? ";
									asql = asql + " AND CHR_ITEMID =? ";
									asql = asql + " AND CHR_SALESORDERNO=?";
									asql = asql + " AND INT_ID=?";
									for(int u=0;u<data.length;u++)
									{
										apstm = con.prepareStatement(asql);
										apstm.setInt(1,Integer.parseInt(data[u][2]));
										apstm.setString(2,data[u][0]);
										apstm.setString(3,data[u][1]);
										apstm.setString(4,dt[0][2]);
										apstm.setString(5,data[u][3]);
										System.out.println(""+apstm);
										apstm.addBatch();
									}
									apstm.executeBatch();
									
									asql = " UPDATE  inv_t_customersalesorder SET CHR_BILLED ='P', INT_PROGRESSBAR =75 ";
									asql = asql + " WHERE CHR_SALESORDERNO =?";
									apstm = con.prepareStatement(asql);
									apstm.setString(1,dt[0][2]);
									System.out.println(""+apstm);
									apstm.execute();
								}
								
							}
						}
						
						asql = " UPDATE inv_t_swapsalesitem  SET DOU_UNITPRICE=0 , DOU_TAX_AMOUNT=0, DOU_TOTAL=0 WHERE CHR_SALESNO =? ";
						apstm = con.prepareStatement(asql);
						apstm.setString(1, saleno);
						System.out.println(""+apstm);
						apstm.execute();
						apstm.close();
						
						asql = " UPDATE inv_t_swapsalesserialno  SET CHR_CANCEL='Y'   WHERE CHR_SALESNO =? ";
						apstm = con.prepareStatement(asql);
						apstm.setString(1, saleno);
						System.out.println(""+apstm);
						apstm.execute();
						apstm.close();
						
						
						asql = " UPDATE inv_t_vendorgoodsreceived SET CHR_SALEWARRANTY=null, ";
						asql = asql + " CHR_FLAG='N',DAT_SALES_WARRANTY_START=null,DAT_SALES_WARRANTY_END=null, ";
						asql = asql + " CHR_SALESNO=null,DT_SALEDATE=null,DOU_SALEUNITPRICE=null ";
						asql = asql + "  WHERE CHR_SALESNO=? ";
						apstm = con.prepareStatement(asql);
						apstm.setString(1, saleno);
						System.out.println(""+apstm);
						apstm.execute();
						apstm.close();
						
						asql = " UPDATE inv_t_vendorgoodsreceivedconsumable SET CHR_CANCEL='Y' ,  CHR_INVOICEBLOCK='N'  ";
						asql = asql + "  WHERE CHR_SALESNO=? ";
						apstm = con.prepareStatement(asql);
						apstm.setString(1, saleno);
						System.out.println(""+apstm);
						apstm.execute();
						apstm.close();
						
						
						//delete swapping serial number in inv_t_swapserial
						asql ="DELETE FROM  inv_t_swapserial WHERE CHR_SALESNO=?";
						apstm = con.prepareStatement(asql);
						apstm.setString(1,saleno );
						System.out.println(""+apstm);
						apstm.execute();
						apstm.close();
						
						//delete swapping serial number in inv_t_vendorgoodsreceived
						asql ="DELETE FROM  inv_t_vendorgoodsreceived WHERE CHR_RECIVEDID=?";
						apstm = con.prepareStatement(asql);
						apstm.setString(1,saleno );
						System.out.println(""+apstm);
						apstm.execute();
						apstm.close();
						
						
						asql = " SELECT DOU_PAIDAMOUNT, if(INT_ADVANCEID > 0,'Advance adjust',''),INT_ADVANCEID " ;
						asql = asql + " FROM inv_t_customersalespayment WHERE INT_ADVANCEID >0 AND  CHR_SALESORDERNO ='"+saleno+"'"; 
						String advanceData[][] =CommonFunctions.QueryExecute(asql);
						if(advanceData.length>0)
						{
							for(int h=0;h<advanceData.length;h++)
							{
								asql = " UPDATE inv_t_advancepayment SET DOU_TRANSFERAMOUNT= (DOU_TRANSFERAMOUNT-"+advanceData[h][0]+" ) ";
								asql = asql + "  WHERE INT_ADVANCEID = ? ";
								apstm = con.prepareStatement(asql);
								apstm.setString(1,advanceData[h][2] );
								System.out.println(""+apstm);
								apstm.execute();
								apstm.close();
							}
						}

						
						
						//Send a mail for cancell invoice
						if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_MAILENABLE FROM m_inventorysetting  WHERE INT_ROWID=1")[0][0]))
						{	
							String email=request.getParameter("email");
							String a[] =(email+","+CommonData.mailid).split(",") ;
							Mail.SimpleHTMLMail(  a,  "CANCELLED  CUSTOMER SALES BILLING :: "+saleno, InvoiceDeletetMail.InvoiceCancellsendtoMail("CANCELLED CUSTOMER SALES BILLING :: "+saleno,saleno,reason, " CUSTOMER SALES BILLING"));
						}	
						
						con.close();   
						response.sendRedirect("Smart Inventory/SwapSale.jsp");
					}
					else
					{
						con.close();   
						response.sendRedirect("Smart Inventory/SwapSaleerror.jsp?er=Swapping serial number sold");
					}
				}
				else if(action.equals("INVSwapSaleClone"))//_Manual_invoice_not_allowed
				{
					String fromsalesno = request.getParameter("salesno");
					String newsaleno = request.getParameter("newsaleno");
					String salesinvoicecreatedby = CommonFunctions.QueryExecute("SELECT CHR_SALES_INVOICE_CREATED  FROM m_inventorysetting  WHERE INT_ROWID=1")[0][0];
					
					//String salesno="";
					int noofclone = Integer.parseInt(request.getParameter("noofclone"));
					String userid=""+session.getAttribute("USRID");	
					branchid = session.getAttribute("BRANCHID").toString();
					String officeid=""+session.getAttribute("OFFICEID");
					String divisionid = CommonFunctions.QueryExecute("SELECT INT_DIVIID FROM inv_t_directsales WHERE CHR_SALESNO='"+fromsalesno+"'")[0][0];
					String invoicenumber=InventoryInvoiceFunctions.directSalesNumberGet(branchid,""+session.getAttribute("INVSTATE"),officeid,divisionid);
					System.out.println(invoicenumber);
					if(!salesinvoicecreatedby.equals("A")){
						invoicenumber = newsaleno;
					}
					System.out.println(invoicenumber);
					
					
					String payment ="N";
					String dt =DateUtil.getCurrentDateTime() ;
					String field ="";  
					int noofpayment = 0;
					double nettotal =0;
					for(int i=0;i<noofclone;i++)
					{
						System.out.println("Insert into Master Begin");
						//Insert into Master 
						sql = " SELECT INT_BRANCHID,DATE(NOW()),INT_PAYMENTTERMID, INT_CUSTOMERID,	CHR_DES,CHR_REF,DOU_AMOUNT,DOU_DISCOUNT,INT_TAXID,";  
						sql = sql + " DOU_TAXAMOUNT,DOU_TOTALAMOUNT,  CHR_SHIPPING,CHR_SHIPPINGADDRESS,CHR_OTHERREF ,"; 
						sql = sql + " CHR_DELIVERYNOTE,CHR_DESPATCHTHRU,CHR_DESTINATION, CHR_TERMSOFDELIVERY,CHR_CONTACTDETAILS ,CHR_CONTACTNO,"; 
						sql = sql + " INT_DIVIID,CHR_NOOFPAYMENTCOMMITMENT,CHR_BYBACK,CHR_BYBACKDESC,";
						sql = sql + " DOU_BYBACKAMOUNT,CHR_INSTALLATION,CHR_INVOICEBLOCK,INT_PAYMENT_COMMITMENT_DAYS,CHR_TAXTYPE,CHR_REF1,CHR_REF2,";
						sql = sql + " INT_REF_PERCENTAGE1,INT_REF_PERCENTAGE2,INT_REF_PERCENTAGE3,INT_PROJECTID,CHR_GST_TYPE, "; 
						sql = sql + " CHR_ADD_TO_ME_NAME,DOU_FRIEGHT_CHARGE,DOU_ROUNDED,CHR_DCREFENCE,CHR_DISCOUNTBILL,INT_SHIPPING_CUSTOMERID,";
						sql = sql + " CHR_INVOICEBLOCK, CHR_TCS,DOU_TCS_PERCENTAGE,DOU_TCS_AMOUNT FROM inv_t_directsales WHERE CHR_SALESNO ='"+fromsalesno+"'";
						System.out.println(sql);
						String fromData[][] = CommonFunctions.QueryExecute(sql);
						if(fromData.length>0) {
							blockinvoice = fromData[0][42];//
							noofpayment = Integer.parseInt(fromData[0][21]);
							nettotal = Double.parseDouble(fromData[0][10]);
							sql ="";
						    field = " (INT_BRANCHID,CHR_SALESNO,DAT_SALESDATE,INT_PAYMENTTERMID, ";
							field = field+"	INT_CUSTOMERID,	CHR_DES,CHR_REF,DOU_AMOUNT,DOU_DISCOUNT,INT_TAXID, ";
							field = field+"	DOU_TAXAMOUNT,DOU_TOTALAMOUNT,INT_SALESSTATUS,CHR_PAYMENTSTATUS, CHR_SALESTYPE,";
							field = field+"	CHR_SHIPPING,CHR_SHIPPINGADDRESS,CHR_OTHERREF ,";
							field = field+"	CHR_DELIVERYNOTE,CHR_DESPATCHTHRU,CHR_DESTINATION,";
							field = field+"	CHR_TERMSOFDELIVERY,CHR_CONTACTDETAILS ,CHR_CONTACTNO,";
							field = field+"	CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS,INT_DIVIID,";
							field = field+"	CHR_NOOFPAYMENTCOMMITMENT,CHR_BYBACK,CHR_BYBACKDESC,";
							field = field+"	DOU_BYBACKAMOUNT,CHR_INSTALLATION,CHR_INVOICEBLOCK,  ";
							field = field+"	INT_PAYMENT_COMMITMENT_DAYS,CHR_TAXTYPE,CHR_REF1,CHR_REF2,";
							field = field+"	INT_REF_PERCENTAGE1,INT_REF_PERCENTAGE2,INT_REF_PERCENTAGE3,INT_PROJECTID,CHR_GST_TYPE,";
							field = field+"	CHR_ADD_TO_ME_NAME,DOU_FRIEGHT_CHARGE,DOU_ROUNDED,CHR_DCREFENCE,CHR_DISCOUNTBILL,INT_SHIPPING_CUSTOMERID, CHR_TCS, DOU_TCS_PERCENTAGE,DOU_TCS_AMOUNT, CHR_CLONE) ";
							sql = " INSERT INTO inv_t_directsales "+field+" VALUES (";
							sql = sql +"?,?,?,?,?,?,?,?,?,?,";
							sql = sql +"?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,? , ";
							sql = sql +"?,?,?,?,?,";
							sql = sql +"?,?,?,?,?,?,?,?,?,?,?,?,?) ";
							apstm=con.prepareStatement(sql);
							apstm.setString(1, fromData[0][0]);
							apstm.setString(2, invoicenumber);
							apstm.setString(3, fromData[0][1]);
							apstm.setString(4, fromData[0][2]);
							apstm.setString(5, fromData[0][3]);
							apstm.setString(6, fromData[0][4]);
							apstm.setString(7, fromData[0][5]);
							apstm.setString(8, fromData[0][6]);
							apstm.setString(9, fromData[0][7] );
							apstm.setString(10, fromData[0][8]);
							apstm.setString(11, fromData[0][9] );
							apstm.setString(12, fromData[0][10]);
							apstm.setString(13, "0");
							apstm.setString(14,payment);
							apstm.setString(15,"D");
							apstm.setString(16,fromData[0][11]);
							apstm.setString(17,fromData[0][12]);
							apstm.setString(18,fromData[0][13]);
							apstm.setString(19,fromData[0][14]);
							apstm.setString(20,fromData[0][15]);
							apstm.setString(21,fromData[0][16]);
							apstm.setString(22,fromData[0][17]);
							apstm.setString(23,fromData[0][18]);
							apstm.setString(24,fromData[0][19] );//request.getParameter("cnumber")
							apstm.setString(25, userid);
							apstm.setString(26,dt);
							apstm.setString(27, "Y");	
							apstm.setString(28, fromData[0][20]);	
							apstm.setString(29, fromData[0][21]);
							apstm.setString(30, fromData[0][22]);
							apstm.setString(31, fromData[0][23]);
							apstm.setString(32, fromData[0][24]);
							apstm.setString(33, fromData[0][25]);
							apstm.setString(34, fromData[0][26]);
							apstm.setString(35, fromData[0][27]);
							apstm.setString(36, fromData[0][28]);
							apstm.setString(37, fromData[0][29]);
							apstm.setString(38, fromData[0][30]);
							apstm.setString(39, fromData[0][31]);
							apstm.setString(40, fromData[0][32]);
							apstm.setString(41, fromData[0][33]);
							apstm.setString(42, fromData[0][34]);
							apstm.setString(43, fromData[0][35]);
							apstm.setString(44, fromData[0][36]);
							apstm.setString(45, fromData[0][37]);
							apstm.setString(46, fromData[0][38]);
							apstm.setString(47, fromData[0][39]);
							apstm.setString(48, fromData[0][40]);
							apstm.setString(49, fromData[0][41]);
							
							apstm.setString(50, fromData[0][43]);
							apstm.setString(51, fromData[0][44]);
							apstm.setString(52, fromData[0][45]);
							apstm.setString(53, "Y");
							System.out.println("SQL : "+apstm);
							apstm.execute();
							System.out.println("Insert inv_t_directsales ");
							
							
							//DIRECT SALE INVOICE NUMBER INSERT
							apstm=con.prepareStatement("  SELECT FUN_INV_DIRECT_SALESNUMBER_INSERT(?) ");
							apstm.setString(1,""+session.getAttribute("INVSTATE"));
							System.out.println("SQL : "+apstm);
							apstm.execute();
							System.out.println("Insert Invoice number inserted. ");
						}
						
						
						System.out.println("Insert into item Began");
						//Insert into total item 
						sql = " SELECT INT_BRANCHID,CHR_SALESNO,CHR_ITEMID,CHR_TYPE,CHR_DESC,INT_QUANTITY,INT_WARRANTY, ";
						sql = sql +" DOU_UNITPRICE,DOU_DISCOUNT,DOU_UNITDISCOUNT,INT_TAXID,DOU_TAX_PERCENTAGE,DOU_TAX_AMOUNT,DOU_TOTAL,CHR_SWAP,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS ";
						sql = sql +" FROM inv_t_swapsalesitem WHERE CHR_SALESNO ='"+fromsalesno+"' ";
						System.out.println(sql);
						String fromItemData[][] = CommonFunctions.QueryExecute(sql);
						if(fromData.length>0 && fromItemData.length>0){
							for(int x1=0;x1<fromItemData.length;x1++) {
								field = "INT_BRANCHID,CHR_SALESNO,CHR_ITEMID,CHR_TYPE,CHR_DESC,INT_QUANTITY,INT_WARRANTY,"; 
								field = field+"DOU_UNITPRICE,DOU_DISCOUNT,DOU_UNITDISCOUNT,INT_TAXID,DOU_TAX_PERCENTAGE,DOU_TAX_AMOUNT,DOU_TOTAL,CHR_SWAP,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS" ;
								sql=" INSERT INTO inv_t_swapsalesitem (" +field+" ) VALUES ( ";
								sql = sql +" ?,?,?,?,?,?,?,"; 
								sql = sql +" ?,?,?,?,?,?,?,?,?,DATE(NOW()),'Y' " ;
								sql = sql +")";
								PreparedStatement  apstm = con.prepareStatement(sql);
								apstm.setString(1, fromItemData[x1][0]);
								apstm.setString(2, invoicenumber );//fromItemData[x1][1]
								apstm.setString(3, fromItemData[x1][2]);
								apstm.setString(4, fromItemData[x1][3]);
								apstm.setString(5, fromItemData[x1][4]);
								apstm.setString(6, fromItemData[x1][5]);
								apstm.setString(7, fromItemData[x1][6]);
								apstm.setString(8, fromItemData[x1][7]);
								apstm.setString(9, fromItemData[x1][8]);
								apstm.setString(10, fromItemData[x1][9]);
								apstm.setString(11, fromItemData[x1][10]);
								apstm.setString(12, fromItemData[x1][11]);
								apstm.setString(13, fromItemData[x1][12]);
								apstm.setString(14, fromItemData[x1][13]);
								apstm.setString(15, fromItemData[x1][14]);
								apstm.setString(16,userId);
								System.out.println(""+apstm);
								apstm.execute();
								System.out.println("Inserted Item data ");
							}
						}
						

						System.out.println("Insert into serial Begin");
						//insert into individual serial number and warranty
						sql = " SELECT INT_BRANCHID,CHR_SALESNO,CHR_ITEMID,CHR_TYPE ,DOU_UNITPRICE,CHR_SWAP , ";
						sql = sql +" CHR_DESC,CHR_WARRANTY "; 
						sql = sql +" FROM inv_t_swapsalesserialno WHERE CHR_SALESNO ='"+fromsalesno+"' ";
						System.out.println(sql);
						String fromItemSerialnoData[][] = CommonFunctions.QueryExecute(sql);
						if(fromData.length>0 && fromItemSerialnoData.length>0){
							sql ="";
							field ="  INT_BRANCHID,CHR_SALESNO,CHR_ITEMID,CHR_TYPE ,DOU_UNITPRICE,CHR_SWAP ," +
							" CHR_USRNAME,DT_UPDATEDATE ,CHR_DESC,CHR_UPDATESTATUS,CHR_WARRANTY ";
							sql ="INSERT INTO inv_t_swapsalesserialno ( " + field  +" ) ";
							sql = sql+	" VALUES ( ";
							sql = sql+	" ?,?,?,? ,? ,? ,?,DATE(NOW()) ,?,'Y',?  ";
							sql = sql +")";
							apstm = con.prepareStatement(sql);
							for(int x1=0;x1<fromItemSerialnoData.length;x1++) {
								apstm.setString(1, fromItemSerialnoData[x1][0]);
								apstm.setString(2, invoicenumber);//fromItemSerialnoData[x1][1]
								apstm.setString(3, fromItemSerialnoData[x1][2]);
								apstm.setString(4, fromItemSerialnoData[x1][3]);
								apstm.setString(5, fromItemSerialnoData[x1][4]);
								apstm.setString(6, fromItemSerialnoData[x1][5]);
								apstm.setString(7, userId );
								apstm.setString(8, fromItemSerialnoData[x1][6] );
								apstm.setString(9, fromItemSerialnoData[x1][7]);
								System.out.println(""+apstm);
								apstm.addBatch();
								System.out.println(""+apstm);
							}
							apstm.executeBatch();
							System.out.println("Inserted Item serialdata ");
						}
						
						
						System.out.println("Insert into consumable begin");
						//consumable products Entry
						sql ="";
						sql = sql + " SELECT  INT_DIVIID,INT_BRANCHID,CHR_SALESNO,CHR_TYPE,CHR_ITEMID,INT_SQTY,  ";
						sql = sql + " CHR_RDSTATUS,DOU_SALESUNITPRICE,   INT_STOCK,DOU_AVGPRICE ,CHR_INVOICEBLOCK, ";
						sql = sql + "  CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS ";
						sql = sql + " FROM inv_t_vendorgoodsreceivedconsumable WHERE CHR_SALESNO ='"+fromsalesno+"' ";
						System.out.println(sql);
						String fromItemConsumableData[][] = CommonFunctions.QueryExecute(sql);
						if(fromData.length>0 && fromItemConsumableData.length>0){
							for(int x1=0;x1<fromItemConsumableData.length;x1++) {
								sql = " SELECT FUN_GET_CONSUMABLESTOCK("+fromItemConsumableData[x1][1]+",'"+fromItemConsumableData[x1][0]+"')";
								int stock =Integer.parseInt(CommonFunctions.QueryExecute(sql)[0][0]);
								int pqty =Integer.parseInt(fromItemConsumableData[x1][5]);
								
								sql = " select DOU_AVGPRICE from inv_t_vendorgoodsreceivedconsumable "; 
								sql = sql + " WHERE  INT_BRANCHID ="+branchid+" AND CHR_TYPE='"+fromItemConsumableData[x1][3]+"' AND CHR_ITEMID='"+fromItemConsumableData[x1][3]+"' ORDER BY INT_ROWID desc ";
								String ccdata[][] =CommonFunctions.QueryExecute(sql);
								double averageprice =0;
								if(ccdata.length>0)
									averageprice=Double.parseDouble(ccdata[0][0]);
								
								sql = "INSERT INTO inv_t_vendorgoodsreceivedconsumable  ";
								sql = sql+" (INT_DIVIID,INT_BRANCHID,CHR_SALESNO,CHR_TYPE,CHR_ITEMID,INT_SQTY,  ";
								sql = sql+" CHR_RDSTATUS,DOU_SALESUNITPRICE,";
								sql = sql + " INT_STOCK,DOU_AVGPRICE ,CHR_INVOICEBLOCK,";
								sql = sql + " CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS  )  "; 
								sql = sql+" VALUES(?,?,?,?,?,?,?,?,?, ?,?,?,DATE(NOW()),'Y' )";
								apstm = con.prepareStatement(sql);
								apstm.setString(1,fromItemConsumableData[x1][0] );
								apstm.setString(2,fromItemConsumableData[x1][1] );
								apstm.setString(3,invoicenumber);//fromItemConsumableData[x1][2] 
								apstm.setString(4,fromItemConsumableData[x1][3] );
								apstm.setString(5,fromItemConsumableData[x1][4] );
								apstm.setString(6,fromItemConsumableData[x1][5] );
								apstm.setString(7,fromItemConsumableData[x1][6] );
								apstm.setString(8,fromItemConsumableData[x1][7]);
								if((stock-pqty) < 1)
								{
									apstm.setString(9,"0" );
									apstm.setString(10,""+averageprice);
								}
								else
								{
									apstm.setString(9,""+(stock-pqty) );
									apstm.setString(10,""+averageprice );
								} 
								apstm.setString(11,blockinvoice );
								apstm.setString(12,userId );
								System.out.println(""+apstm);
								apstm.execute();
								System.out.println("Inserted ItemConsumableData ");
							}
						}
		
						
						System.out.println("Insert the Payment commitment table begin");
						//Insert the Payment commitment table
						for(int h=0;h<noofpayment;h++)
						{
							sql="INSERT INTO inv_t_paymentcommitment (CHR_SALESNO,CHR_INVOICETYPE,DOU_ACTUALAMOUNT) ";
							sql = sql + " VALUE(?,'C',?)";
							apstm = con.prepareStatement(sql);
							apstm.setString(1,invoicenumber);
							apstm.setString(2,""+nettotal);
							System.out.println(""+apstm);
							apstm.execute();
							System.out.println("Inserted Payment commitment ");
						}
						
						apstm.close();
						con.close(); 
						System.out.println("Clone "+(i+1));
						//response.sendRedirect("Smart Inventory/SwapSaleSerial.jsp?salno="+salesno);
					}
					
					con.close();   
					response.sendRedirect("Smart Inventory/SwapSale.jsp");
				}
				else if(action.equals("INVSwapSaleserialUpdation"))
				{
					String itype = request.getParameter("itype");
					String itemid = request.getParameter("itemid");
					String salesno = request.getParameter("salesno");
					String saleserial = request.getParameter("saleserial");
					String serial1 = request.getParameter("serial1");
					//String saleunitprice = request.getParameter("saleunitprice");
					asql = "SELECT DOU_SALEUNITPRICE,CHR_SALEWARRANTY,DAT_SALES_WARRANTY_START,DAT_SALES_WARRANTY_END FROM inv_t_vendorgoodsreceived WHERE CHR_SERIALNO='"+saleserial+"' ";
					String data[][] = CommonFunctions.QueryExecute(asql);
					asql = " SELECT COUNT(*) FROM inv_t_vendorgoodsreceived WHERE  CHR_SERIALNO='"+serial1+"'";
					if(CommonFunctions.RecordExist(con, asql))
					{	
						//New serial number updation
						asql = "UPDATE  inv_t_vendorgoodsreceived  SET DOU_SALEUNITPRICE=?, ";
						asql = asql +" CHR_SALEWARRANTY=?,DAT_SALES_WARRANTY_START=?,DAT_SALES_WARRANTY_END=?, ";
						asql = asql +" CHR_SALESNO=? , CHR_FLAG=?   , CHR_USRNAME=?, ";
						asql = asql+" DT_UPDATEDATE = DATE(NOW()) ,CHR_UPDATESTATUS='Y'  WHERE CHR_SERIALNO=? ";
						apstm = con.prepareStatement(asql);
						apstm.setString(1,data[0][0]  );//saleunitprice
						apstm.setString(2,data[0][1]   );
						apstm.setString(3,data[0][2]  );
						apstm.setString(4,data[0][2]  );
						apstm.setString(5,salesno );
						apstm.setString(6,"Y" );
						apstm.setString(7,auserid );
						apstm.setString(8,serial1);
						System.out.println(""+apstm);
						apstm.execute();
						apstm.close();
						 
						//Old serial number updation
						asql = "UPDATE  inv_t_vendorgoodsreceived SET DOU_SALEUNITPRICE=?,  ";
						asql = asql + " CHR_SALEWARRANTY=?,DAT_SALES_WARRANTY_START=?,DAT_SALES_WARRANTY_END=?,  CHR_SALESNO=? ,";
						asql = asql + " CHR_FLAG=? , CHR_USRNAME=? , DT_UPDATEDATE = DATE(NOW()) ,";
						asql = asql + " CHR_UPDATESTATUS='Y' WHERE CHR_SERIALNO=? ";
						apstm = con.prepareStatement(asql);
						apstm.setString(1,"0");//saleunitprice
						apstm.setString(2,null);
						apstm.setString(3,null);
						apstm.setString(4,null);
						apstm.setString(5,null);
						apstm.setString(6,"N");
						apstm.setString(7,auserid );
						apstm.setString(8,saleserial);
						System.out.println(""+apstm);
						apstm.execute();
						apstm.close();
						
						asql = "UPDATE   inv_t_swapsalesserialno SET CHR_SERIALNO='"+serial1+"' WHERE  CHR_SALESNO='"+salesno+"' AND CHR_ITEMID='"+itemid+"' AND CHR_TYPE='"+itype+"' AND CHR_SERIALNO='"+saleserial+"'";
						apstm = con.prepareStatement(asql);
						apstm.execute();
					} 
					con.close();   
					response.sendRedirect("Smart Inventory/SwapSaleSerialView.jsp?salno="+salesno);
				}
				else if("INVSwapSaleShippingaddressUpdation".equals(action))
				{
					String address =request.getParameter("address");
					String salno =request.getParameter("salno");
					asql="UPDATE inv_t_directsales SET  CHR_SHIPPINGADDRESS='"+address+"'  WHERE CHR_SALESNO='"+salno+"'";
					apstm = con.prepareStatement(asql);
					apstm.execute();
					con.close();   
					response.sendRedirect("Smart Inventory/SwapSaleSerialView.jsp?salno="+salno);
				}
				else if("INVSwapSaleResetSerialNumber".equals(action))
				{ 
					String salesno =request.getParameter("salesno");
					asql ="UPDATE inv_t_vendorgoodsreceived SET CHR_FLAG='N',DOU_SALEUNITPRICE=0 WHERE CHR_SALESNO=?";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,salesno );
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
					
					asql ="UPDATE inv_t_swapsalesserialno SET CHR_SERIALNO=? WHERE CHR_SALESNO=?";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,null );
					apstm.setString(2,salesno );
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
					
					asql = "DELETE FROM inv_t_swapserial WHERE CHR_SALESNO=?";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,salesno );
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
					
					con.close();   
					response.sendRedirect("Smart Inventory/SwapSale.jsp");
					
				}
				else if("INVSwapSaleResetDivision".equals(action))
				{
					String salesno =request.getParameter("salesno");
					String division =request.getParameter("division");
					asql ="UPDATE inv_t_directsales SET INT_DIVIID='"+division+"' WHERE CHR_SALESNO='"+salesno+"'";
					apstm = con.prepareStatement(asql);
					apstm.execute();
					con.close();   
					response.sendRedirect("Smart Inventory/SwapSaleSerialView.jsp?salno="+salesno);
				}
				else if("INVSwapSaleSendMail".equals(action))
				{
					String salesno =request.getParameter("salesno");
					String subject =request.getParameter("subject");
					String email =request.getParameter("email");
					String a[] =(email+",").split(",") ;
					System.out.println("======");
					String content = InvoiceHTMLMail.mailContent(salesno, branchid, session, request.getRealPath("/")); 
					System.out.println("******************************************************************************");
					System.out.println(content);
					System.out.println("******************************************************************************");
					String[] attachments = new String [2];
					attachments[0] =Path+"images\\Header.png";
					attachments[1] =  Path+"images\\logo.jpg";
					
					
					if(!"".equals(email) || !"null".equals(email) )
						InvMail.sendEmailWithAttachments(a, subject+": "+salesno, content, attachments);
					
					 
					con.close();   
			        response.sendRedirect("Smart Inventory/SwapSale.jsp");
				}
				else if("INVCustomerSalesInvoiceSendtoSMS".equals(action))
				{
					String txtMobileNo =request.getParameter("txtMobileNo");
					String txtMessage =request.getParameter("txtMessage");
					 Way2Sms w = new  Way2Sms();
					w.mySendSMS(txtMobileNo, txtMessage);
					CommonFunctions.CloseServletResponse(response);
				}
				else if("INVSwapSaleUnBlock".equals(action))
				{
					String salno =request.getParameter("salesno");
					asql = "SELECT (DATEDIFF(NOW(),DAT_SALESDATE ) > (SELECT INT_UNBLOCK FROM m_inventorysetting  WHERE INT_ROWID=1)) ";
					asql = asql + " FROM inv_t_directsales ";
					asql = asql + " WHERE CHR_SALESNO='"+salno+"' ";
					if("0".equals(CommonFunctions.QueryExecute(asql)[0][0]))
					{	
						asql="UPDATE inv_t_directsales SET  CHR_INVOICEBLOCK='N'  WHERE CHR_SALESNO='"+salno+"'";
						apstm = con.prepareStatement(asql);
						apstm.execute();
						
						asql="UPDATE inv_t_vendorgoodsreceivedconsumable SET  CHR_INVOICEBLOCK='N'  WHERE CHR_SALESNO='"+salno+"'";
						apstm = con.prepareStatement(asql);
						apstm.execute(); 
					}	
					con.close();   
					response.sendRedirect("Smart Inventory/SwapSale.jsp");
				}	
				else if("INVSwapSaleChanges".equals(action))
				{
					String salno =request.getParameter("salesno");
					//String saledate =request.getParameter("saledate");
					String customer =request.getParameter("customer");
					String shippingaddress =request.getParameter("shippingaddress");
					String ref =request.getParameter("ref");
					String division =request.getParameter("division");
					String Shipping =request.getParameter("Shipping");
					String oref =request.getParameter("oref");
					String cnumber =request.getParameter("cnumber");
					String cdetails =request.getParameter("cdetails");
					  
					asql = "";
					asql = " UPDATE inv_t_directsales SET INT_CUSTOMERID =?,CHR_SHIPPING=?, CHR_SHIPPINGADDRESS=?,"; 
					asql = asql +" CHR_REF = ?, INT_DIVIID=? , CHR_OTHERREF=?,CHR_CONTACTNO=? , CHR_CONTACTDETAILS=?  WHERE CHR_SALESNO= ?";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,customer );
					apstm.setString(2,Shipping);
					apstm.setString(3,shippingaddress);
					apstm.setString(4,ref);
					apstm.setString(5,division);
					apstm.setString(6,oref);
					apstm.setString(7,cnumber);
					apstm.setString(8,cdetails);
					apstm.setString(9,salno);
					
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
					
					asql = " UPDATE  inv_t_contribution SET  CHR_EMPID = ? WHERE CHR_SALESNO = ?";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,ref );
					apstm.setString(2,salno); 
					apstm.execute();
					apstm.close();
					con.close();
					response.sendRedirect("Smart Inventory/windowexit.jsp");
				}	
				else if("INVSwapSaleAdminReset".equals(action))
				{
					try 
					{
						System.out.println("Bill Reset :");
						String salnos = request.getParameter("salesno");
						boolean SwapSerialSale = DirectSaleMethod.checkSwapSerialSaleornot(salnos, con, request, response);
						System.out.println(SwapSerialSale);
						boolean transflag = false;
						if(SwapSerialSale) 
						{	
							if(!transflag   )
							{
								
								//delete swapping serial number in inv_t_swapserial
								asql ="DELETE FROM  inv_t_swapserial WHERE CHR_SALESNO=?";
								apstm = con.prepareStatement(asql);
								apstm.setString(1,salnos );
								System.out.println(""+apstm);
								apstm.execute();
								apstm.close();
								
								//delete swapping serial number in inv_t_vendorgoodsreceived
								asql ="DELETE FROM  inv_t_vendorgoodsreceived WHERE CHR_RECIVEDID=?";
								apstm = con.prepareStatement(asql);
								apstm.setString(1,salnos );
								System.out.println(""+apstm);
								apstm.execute();
								apstm.close();
								
								
								asql ="UPDATE inv_t_swapsalesserialno SET CHR_SERIALNO=? ,CHR_WARRANTY=null WHERE CHR_SALESNO=?";
								apstm = con.prepareStatement(asql);
								apstm.setString(1,null );
								apstm.setString(2,salnos );
								apstm.execute();
								apstm.close();
								
								//Set Serial Number to null
								asql =" UPDATE inv_t_vendorgoodsreceived SET CHR_FLAG='N' ,DAT_SALES_WARRANTY_START=null, DAT_SALES_WARRANTY_END=null,CHR_SALEWARRANTY=null, CHR_SALESNO=null,DT_SALEDATE=null,  CHR_USRNAME='"+ userId +"' , DT_UPDATEDATE = DATE(NOW()) ,CHR_UPDATESTATUS='Y'  WHERE CHR_SALESNO='"+salnos+"'";
								apstm = con.prepareStatement(asql);
								apstm.execute();
								
								//deleting Contribution 
								asql="DELETE  FROM inv_t_contribution WHERE CHR_SALESNO ='"+salnos+"'";
								apstm = con.prepareStatement(asql);
								apstm.execute();
								
								//Delete inv_t_customersalespayment
								asql = "DELETE FROM inv_t_customersalespayment WHERE CHR_SALESORDERNO=?";
								apstm = con.prepareStatement(asql);
								apstm.setString(1, salnos);
								apstm.execute();
								
								asql = "UPDATE inv_t_paymentcommitment SET CHR_STATUS ='N' WHERE CHR_SALESNO=? AND CHR_INVOICETYPE=?";
								apstm = con.prepareStatement(asql);
								apstm.setString(1, salnos);
								apstm.setString(2, "C");
								apstm.execute();
								
								//Deleting installation table
								asql = "DELETE FROM inv_t_directsales_installation WHERE CHR_SALESNO=?";
								apstm = con.prepareStatement(asql);
								apstm.setString(1, salnos);
								apstm.execute();
								
								asql = "UPDATE inv_t_directsales SET INT_SALESSTATUS=0 WHERE CHR_SALESNO=?";
								apstm = con.prepareStatement(asql);
								apstm.setString(1, salnos);
								apstm.execute();
							}
	
							if(!transflag  )
							{	
								 //If product is consumable its revert in stock
								 asql = " SELECT a.INT_BRANCHID ,a.CHR_ITEMID,a.CHR_TYPE,a.INT_QUANTITY,a.CHR_SWAP ";
								 asql = asql +" FROM inv_t_swapsalesitem  a ,inv_m_produtlist b";
								 asql = asql +" WHERE a.CHR_ITEMID =b.CHR_PRODUCTID ";
								 asql = asql +" AND b.CHR_PTYPE='S'";
								 asql = asql +" AND CHR_SALESNO='"+salnos+"'";
								 String  salesData[][] = CommonFunctions.QueryExecutecon(con, asql);
								 if(salesData.length>0)
								 {
									//deleting consuamble;
									sql = "DELETE  FROM inv_t_vendorgoodsreceivedconsumable WHERE CHR_SALESNO='"+salnos+"'";
									st.equals(sql);
								 }
								
							}
							con.close();   
							response.sendRedirect("Smart Inventory/SwapSale.jsp");
						}
						else
						{
							con.close();   
							response.sendRedirect("Smart Inventory/SwapSaleerror.jsp?er=Swapping serial number sold");
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
				else if("INVSwapSaleCourierAdd".equals(action))
				{
					try
					{
						String saledate = request.getParameter("saledate");
						String salno = request.getParameter("salno");
						String division = request.getParameter("division");
						
						String datadiff =CommonFunctions.QueryExecute("SELECT DATEDIFF(now(),'"+saledate+"')")[0][0];
						int dat = Integer.parseInt(datadiff);
						String deliverylock =CommonFunctions.QueryExecute("SELECT INT_DELIVERYDAYS FROM m_inventorysetting WHERE INT_ROWID=1")[0][0];
						int dat1 =0;
						if(deliverylock.length()>0)
							dat1=Integer.parseInt(deliverylock);
						if(dat<=dat1)
						{
							String through = request.getParameter("through");
							String courier = request.getParameter("courier");
							String engname= request.getParameter("engname"); 
							String engmobile = request.getParameter("engmobile");
							String starting = request.getParameter("starting");
							String endig = request.getParameter("endig");
							String kilometer = request.getParameter("kilometer");
							String description = request.getParameter("description");
							String amount = request.getParameter("amount");
							
							String startdate =request.getParameter("startdate");
							String stdate[] = startdate.split(" ");
							String sdate = DateUtil.FormateDateSQL(stdate[0])+" "+stdate[1];
							System.out.println(sdate);
							asql = "UPDATE inv_t_directsales SET CHR_DELIVERYTHROUGH=?,CHR_COURIER_EMPID=?,CHR_COURIER_EMPID_MOBILE=?,";
							asql = asql +" DAT_COURIERDATE=?,CHR_DELIVERY=?,INT_COURIERID=?,DAT_COURIERDATE=NOW(),CHR_STARTING_PLACE=?,";
							asql = asql +" CHR_ENDING_PLACE=?,INT_COURIER_KILOMETER=?,CHR_COURIER_DESC=?,";
							asql = asql +" DOU_COURIERAMOUNT=? WHERE CHR_SALESNO=? ";
							apstm = con.prepareStatement(asql);
							apstm.setString(1,through);
							apstm.setString(2,engname);
							apstm.setString(3,engmobile);
							apstm.setString(4,sdate);
							apstm.setString(5,"P");
							apstm.setString(6,courier);
							apstm.setString(7,starting);
							apstm.setString(8,endig);
							apstm.setString(9,kilometer);
							apstm.setString(10,description);
							apstm.setString(11,amount);
							apstm.setString(12,salno);
							System.out.println(""+apstm);
							apstm.execute();
							apstm.close();
							
							//mail alert
							SwapSaleMail.sendSalesShippedMail(branchid,salno, division, Path);
							
							
						}	
						con.close();   
						
						response.sendRedirect("Smart Inventory/SwapSale.jsp");
					}
					catch (Exception e) 
					{
						System.out.println(e.getMessage());
						request.setAttribute("error", e.getMessage() );
			            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
			    		dispatchers.forward(request, response); 
					}
				}
				else if("INVSwapSaleCourierUpdate".equals(action))
				{
					try
					{
						String cdate = request.getParameter("cdate");
						String division = request.getParameter("division");
						String datadiff =CommonFunctions.QueryExecute("SELECT DATEDIFF(now(),'"+cdate+"')")[0][0];
						int dat = Integer.parseInt(datadiff);
						String deliverylock =CommonFunctions.QueryExecute("SELECT INT_DELIVERYDAYS FROM m_inventorysetting WHERE INT_ROWID=1")[0][0];
						int dat1 =0;
						if(deliverylock.length()>0)
							dat1=Integer.parseInt(deliverylock);
						
						if(dat<=dat1)
						{
							String through = request.getParameter("through");
							String courier = request.getParameter("courier");
							String engname= request.getParameter("engname"); 
							String engmobile = request.getParameter("engmobile");
							String starting = request.getParameter("starting");
							String endig = request.getParameter("endig");
							String kilometer = request.getParameter("kilometer");
							String description = request.getParameter("description");
							String amount = request.getParameter("amount");
							String salno = request.getParameter("salno");
							String startdate =request.getParameter("startdate") ;
							String stdate[] = startdate.split(" ");
							String sdate = DateUtil.FormateDateSQL(stdate[0])+" "+stdate[1];
							 
							asql = "UPDATE inv_t_directsales SET CHR_DELIVERYTHROUGH=?,CHR_COURIER_EMPID=?,CHR_COURIER_EMPID_MOBILE=?,";
							asql = asql +" DAT_COURIERDATE=?,CHR_DELIVERY=?,INT_COURIERID=?,DAT_COURIERDATE=NOW(),CHR_STARTING_PLACE=?,";
							asql = asql +" CHR_ENDING_PLACE=?,INT_COURIER_KILOMETER=?,CHR_COURIER_DESC=?,";
							asql = asql +" DOU_COURIERAMOUNT=?";
							asql = asql +" WHERE CHR_SALESNO=? ";
							apstm = con.prepareStatement(asql);
							apstm.setString(1,through);
							apstm.setString(2,engname);
							apstm.setString(3,engmobile);
							apstm.setString(4,sdate);
							apstm.setString(5,"P");
							apstm.setString(6,courier);
							apstm.setString(7,starting);
							apstm.setString(8,endig);
							apstm.setString(9,kilometer);
							apstm.setString(10,description);
							apstm.setString(11,amount);
							apstm.setString(12,salno);
							System.out.println(""+apstm);
							apstm.execute();
							apstm.close();
							 
							//mail alert
							SwapSaleMail.sendSalesShippedMail(branchid,salno, division, Path);
							
							
						}	
						con.close();   
						response.sendRedirect("Smart Inventory/SwapSale.jsp");
					
					}
					catch (Exception e) 
					{
						System.out.println(e.getMessage());
						request.setAttribute("error", e.getMessage() );
			            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
			    		dispatchers.forward(request, response); 
						
					}
				}
				else if("INVSwapSaleCourierClose".equals(action))
				{
					try
					{
						String salno = request.getParameter("salno");
						String division = request.getParameter("division");
						
						String cdate = request.getParameter("cdate");
						String datadiff =CommonFunctions.QueryExecute("SELECT DATEDIFF(now(),'"+cdate+"')")[0][0];
						int dat = Integer.parseInt(datadiff);
						String deliverylock =CommonFunctions.QueryExecute("SELECT INT_DELIVERYDAYS FROM m_inventorysetting WHERE INT_ROWID=1")[0][0];
						int dat1 =0;
						if(deliverylock.length()>0)
							dat1=Integer.parseInt(deliverylock);
						
						if(dat<=dat1)
						{
							 
							String receivername = request.getParameter("receivername");
							String receivermobile = request.getParameter("receivermobile");
							String dispatchdate =request.getParameter("enddate") ;;
							String eddate[] = dispatchdate.split(" ");
							String edate = DateUtil.FormateDateSQL(eddate[0])+" "+eddate[1];
							String status = request.getParameter("status");
							String description = request.getParameter("description");
							
							asql = "UPDATE inv_t_directsales SET CHR_DELIVERY=?,";
							asql = asql +" CHR_RECEIVERNAME=?, CHR_RECEIVER_MOBILE=?, DAT_DISPATCHEDDATE=?,CHR_CLOSEDBY=? , CHR_RECEIVER_DESC =?";
							asql = asql +" WHERE CHR_SALESNO=? ";
							apstm = con.prepareStatement(asql);
							apstm.setString(1,status);
							apstm.setString(2,receivername);
							apstm.setString(3,receivermobile);
							apstm.setString(4,edate);
							apstm.setString(5,auserid);
							apstm.setString(6,description);
							apstm.setString(7,salno);
							System.out.println(""+apstm);
							apstm.execute();
							apstm.close();
							
							//mail alert
							SwapSaleMail.sendSalesDeliveredMail(branchid,salno, division, Path);
							
							
						}	
						con.close();   
						response.sendRedirect("Smart Inventory/SwapSale.jsp");
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
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
		}
	}
	
 	
	public static void invoiceSendtoMail( String recipients[] ,String subject,String content)
    {
    	try
    	{   System.out.println("invoiceSendtoMail....");
    		boolean debug = false;
    		String hData[][] =  CommonFunctions.QueryExecute("SELECT CHR_HOST,CHR_USERID,CHR_PASSWORD,CHR_MAILID FROM  m_mailsetting WHERE INT_MAILID = 1");
		    String host =hData[0][0]   ;
            String user =hData[0][1]   ;
            String password =hData[0][2]   ;
            String from =hData[0][3]   ;
            host = "smtp.gmail.com";
            Properties props = new Properties();
  	        props.setProperty("mail.transport.protocol", "smtp");
  	        props.setProperty("mail.host", ""+host);
	        props.setProperty("mail.user", ""+user);
  	        props.setProperty("mail.password", ""+password);
  	        props.setProperty("mail.smtp.port", "465");
  	        props.setProperty("mail.smtp.ssl.enable", "true");
  	        props.setProperty("mail.smtp.auth", "true");
  	        
  	        Session session = Session.getDefaultInstance(props, null);
  	        session.setDebug(debug); 
  	        Message msg = new MimeMessage(session);
  	        InternetAddress addressFrom = new InternetAddress(from);
  	        msg.setFrom(addressFrom);
            InternetAddress[] addressTo = new InternetAddress[recipients.length]; 
  	        for (int i = 0; i < recipients.length; i++)
  	    	   addressTo[i] = new InternetAddress(recipients[i]);
  	        msg.setRecipients(Message.RecipientType.BCC, addressTo);
  	        msg.addHeader("MyHeaderName", "myHeaderValue");
  	        msg.setSubject(subject);
  	        msg.setContent(content, "text/html");
  	        Transport.send(msg);
    	}
    	catch(Exception e)
    	{
    		 System.out.println(e.getMessage()); 
    	}
    }
	
	
	
	public static void swapDelete(HttpServletRequest request,HttpServletResponse response,String salnos )
	{
		try
		{ }
		catch(Exception e)
		{
			
		}
	}
	
}
