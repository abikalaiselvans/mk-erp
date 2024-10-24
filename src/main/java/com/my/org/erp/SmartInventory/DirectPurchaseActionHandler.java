package com.my.org.erp.SmartInventory;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;

//import sun.awt.SunToolkit.InfiniteLoop;


import com.my.org.erp.bean.inventory.DirectPurchase;
import com.my.org.erp.common.CommonFunction;
import com.my.org.erp.common.CommonFunctions;
import com.my.org.erp.mail.Mail;
import com.my.org.erp.setting.CommonData;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
public class DirectPurchaseActionHandler extends AbstractActionHandler
{

	public static String purchaserequest="";
	public static String buyback="N";
	public static void  itemInsert(HttpServletRequest request,HttpServletResponse response, String cashSaleNo ,Connection con, Statement st, String branch,String pDate)throws ServletException, IOException 
	{
		try 
		{
			 
			String sql="";			
			HttpSession session=request.getSession();			
			String userId=""+session.getAttribute("USRID");
			String branchid = session.getAttribute("INVBRANCH").toString();
			String param[] = request.getParameter("param").split(",");
			String division = request.getParameter("division") ;
			String itype="",warranty="";
			String itemid = "";
			String consumables="";
			int pqty=0;
			 
			System.out.println(request.getParameter("param"));
			for(int p=0;p<param.length; p++)
			{
			
				String e =""+request.getParameter("itype"+param[p].trim());
				itemid =""+request.getParameter("item"+param[p].trim());
				consumables =""+request.getParameter("consumables"+param[p].trim());
				pqty = Integer.parseInt(request.getParameter("qty"+param[p].trim())) ;
				warranty =  request.getParameter("warranty"+param[p].trim() ) ;
				if(e.equals("1") )
					itype="I";
				if(e.equals("2") )
					itype="P";
				
				//insert into total item 
				sql=" INSERT INTO inv_t_directpurchaseitem ( ";
				sql = sql+" INT_BRANCHID,CHR_PURCHASEORDERNO,CHR_ITEMID,CHR_TYPE,CHR_DESC,INT_QUANTITY,INT_WARRANTY, "; 
				sql = sql+ " DOU_UNITPRICE,DOU_DISCOUNT,DOU_UNITDISCOUNT,INT_TAXID,DOU_TAX_PERCENTAGE,DOU_TAX_AMOUNT,DOU_TOTAL,INT_DIVIID,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS" ;
				sql = sql+" ) VALUES (";
				sql = sql+ "?,?,?,?,?,?,?,"; 
				sql = sql+"?,?,?,?,?,?,?,?,?,DATE(NOW()),'Y' )" ;
				
				PreparedStatement pstm = con.prepareStatement(sql);
				pstm.setString(1, branchid);
				pstm.setString(2, cashSaleNo );
				pstm.setString(3, itemid );
				pstm.setString(4, itype);
				pstm.setString(5, request.getParameter("desc"+param[p].trim()).replace("\"", ""));
				pstm.setString(6, ""+pqty);
				pstm.setString(7, ""+warranty);
				pstm.setString(8, request.getParameter("uprice"+param[p].trim()) );
				pstm.setString(9,  request.getParameter("discount"+param[p].trim()));
				pstm.setString(10, request.getParameter("unitdiscount"+param[p].trim()));
				pstm.setString(11, request.getParameter("stax"+param[p].trim()));
				pstm.setString(12, request.getParameter("staxpercentage"+param[p].trim()));
				pstm.setString(13, request.getParameter("staxamount"+param[p].trim()));
				pstm.setString(14, request.getParameter("total"+param[p].trim()));
				pstm.setString(15,  division);
				pstm.setString(16,  userId);
				System.out.println(""+pstm);
				pstm.execute();
				pstm.close();
				
				//insert into individual serial number and warranty
				if(!consumables.equals("S"))
				{	
					for(int u=0; u<Integer.parseInt(request.getParameter("qty"+param[p].trim()));u++)
					{
						//insert int goods received
						sql = "INSERT INTO inv_t_vendorgoodsreceived (DAT_ACTUALINWARD,INT_DIVIID,INT_BRANCHID,CHR_PURCHASEORDERNO," +
								"CHR_TYPE,CHR_ITEMID,CHR_RECIVEDID,DAT_RECIVEDDATE ,CHR_RECEIVEDMODE, " +
								"DOU_UNITPRICE,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS,CHR_POREQUESTNO ,CHR_BUYBACK_STOCK,CHR_WARRANTY   ) VALUES ( ";
						sql = sql +" NOW(),?,?,?," +
								"?,?,?,? ,?, " +
								"?,?,DATE(NOW()),'Y',? ,? ,?) " ;
						pstm = con.prepareStatement(sql);
						pstm.setString(1,division);
						pstm.setString(2,branchid);
						pstm.setString(3,cashSaleNo);
						pstm.setString(4,itype);
						pstm.setString(5,itemid);
						pstm.setString(6,cashSaleNo);
						pstm.setString(7,DateUtil.FormateDateSQL(pDate));
						pstm.setString(8,"D");
						pstm.setString(9,request.getParameter("uprice"+param[p].trim()));
						pstm.setString(10,userId);
						pstm.setString(11,purchaserequest);
						pstm.setString(12,buyback);
						pstm.setString(13,warranty);
						System.out.println(""+pstm);
						pstm.execute();
						pstm.close();
				}
				}
				else
				{
					
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
					sql = sql+" '"+cashSaleNo +"' , ";
					sql = sql+" '"+itype +"' , ";
					sql = sql+" '"+itemid +"' , ";
					sql = sql+" "+pqty +" , ";
					sql = sql+" '"+cashSaleNo +"' , ";
					sql = sql+" now() , 'D',";
					sql = sql+Double.parseDouble(request.getParameter("uprice"+param[p].trim()))+",";
					
					System.out.println("stock"+stock);
					if(stock == 0)
						sql = sql+" "+pqty +" , ";
					else
						sql = sql +""+(stock+pqty)+", ";
					
					if(stock == 0)
						sql = sql+Double.parseDouble(request.getParameter("uprice"+param[p].trim()))+",";
					else
					{
						String asql = " select DOU_AVGPRICE from inv_t_vendorgoodsreceivedconsumable "; 
						asql = asql + " WHERE  INT_BRANCHID ="+branchid+" AND CHR_ITEMID='"+itemid+"' ORDER BY INT_ROWID desc ";
						double averageprice=Double.parseDouble(CommonFunctions.QueryExecute(asql)[0][0]);
						double s1 = stock*averageprice;
						double s2 = pqty*Double.parseDouble(request.getParameter("uprice"+param[p].trim()));;
						double s3 = s1+s2;
						int totstack = stock+pqty;
						double avgprice = 0;
						if(totstack != 0)
							avgprice = s3/totstack;
						System.out.println("stock     : "+stock);
						System.out.println("pqty      : "+pqty);
						System.out.println("totstack = stock+pqty "+totstack);
						System.out.println("uprice    : "+request.getParameter("uprice"+param[p].trim()));
						System.out.println("avgprice  : "+avgprice);
						
						sql = sql +""+(avgprice)+", ";
					}
							
					sql = sql +"'"+userId+"', ";
					sql = sql +" now() , 'Y' ) ";
					System.out.println(sql);
					st.execute(sql);
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
	
	@SuppressWarnings("rawtypes")
	public synchronized  void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	 {
		try
		{
				String action=request.getParameter("actionS");
				HttpSession session=request.getSession();			
				String userId=""+session.getAttribute("USRID");
				String branchid = session.getAttribute("BRANCHID").toString();
				String invbranchstateid = session.getAttribute("INVBRANCHSTATEID").toString();
				String pDate=request.getParameter("saleDate");
				Statement st = con.createStatement();
				String sql="";
				if(action.equals("INVDirectPurchaseAdd"))
				{
					purchaserequest=request.getParameter("purchaserequest");
					String PR = CommonFunctions.QueryExecute("SELECT CHR_PR_BYPASS FROM m_inventorysetting WHERE INT_ROWID=1")[0][0];
					if(PR.equals("Y"))
						buyback = CommonFunctions.QueryExecute("SELECT CHR_BYBACK FROM  inv_t_purchaserequest WHERE CHR_POREQUESTNO='"+purchaserequest+"'")[0][0];
					DirectPurchase d = new DirectPurchase();
					Map map=request.getParameterMap();
					BeanUtils.populate(d,map);
					DirectPurchaseMethod.addDirectPurchase(con,apstm, d, request, response);
					String cashSaleNo =""+request.getParameter("cashSaleNo");
					String PONO=""+session.getAttribute("PONO");
					cashSaleNo=PONO;
					itemInsert(request,response,cashSaleNo,con,st,branchid,pDate);
					request.setAttribute("serialno", "true");
					 
					String partialreceived = request.getParameter("partialreceived");
					if("Y".equals(partialreceived))
						partialreceived = "P";
					else
						partialreceived = "Y";
					
					CommonFunctions.Execute("UPDATE inv_t_purchaserequest SET CHR_PR_PARTIALLY_RECEIVED='"+partialreceived+"' WHERE CHR_POREQUESTNO= '"+purchaserequest+"'");
					con.close();   
					response.sendRedirect("Smart Inventory/DirectPurchaseSerial.jsp?pono="+cashSaleNo);
				
				}
				else if(action.equals("INVDirectPurchaseRequestAdd"))
				{
					
					purchaserequest=request.getParameter("purchaserequest");
					buyback = CommonFunctions.QueryExecute("SELECT CHR_BYBACK FROM  inv_t_purchaserequest WHERE CHR_POREQUESTNO='"+purchaserequest+"'")[0][0];
					
					DirectPurchase d = new DirectPurchase();
					Map map=request.getParameterMap();
					BeanUtils.populate(d,map);
					
					DirectPurchaseMethod.addDirectPurchase(con,apstm, d, request, response);
					String cashSaleNo =""+request.getParameter("cashSaleNo");
					String PONO=""+session.getAttribute("PONO");
					cashSaleNo=PONO;
					itemInsert(request,response,cashSaleNo,con,st,branchid,pDate);
					request.setAttribute("serialno", "true");
					 
					String partialreceived = request.getParameter("partialreceived");
					if("Y".equals(partialreceived))
						partialreceived = "P";
					else
						partialreceived = "Y";
					
					CommonFunctions.Execute("UPDATE inv_t_purchaserequest SET CHR_PR_PARTIALLY_RECEIVED='"+partialreceived+"' WHERE CHR_POREQUESTNO= '"+purchaserequest+"'");
					con.close();   
					response.sendRedirect("Smart Inventory/DirectPurchaseSerial.jsp?pono="+cashSaleNo);
				
				}
				else if("INVDirectPurchaseUpdate".equals(action))
				{
					try 
					{
						String param = request.getParameter("param");
						String cashSaleNo =""+request.getParameter("ponumber");
						String custid =""+request.getParameter("vendorid");
						String saleDate =""+request.getParameter("saleDate");
						saleDate=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(saleDate);
						String paymentterm =""+request.getParameter("payment");
						String memo =""+request.getParameter("memo");
						String ref =""+request.getParameter("ref");
						String tot =""+request.getParameter("totals");
						String basevalue =""+request.getParameter("basevalue");
						String basevaluecheck =""+request.getParameter("basevaluecheck");
						if(!"Y".equals(basevaluecheck))
							basevaluecheck="N";
						String totaldiscount =""+request.getParameter("totaldiscount");
						String tax =""+request.getParameter("tax");
						String division =""+request.getParameter("division");
						String salestaxamount =""+request.getParameter("salestaxamount");
						String roundedoption =""+request.getParameter("roundedoption");
						String nettotal =""+request.getParameter("nettotal");
						String frieghtamount =""+request.getParameter("frieghtamount");
						String frieghttax =""+request.getParameter("frieghttax");
						String frieghtcharge =""+request.getParameter("frieghtcharge");
						
						
						purchaserequest =""+request.getParameter("purchaserequest");
						System.out.println(action);
						String PR = CommonFunctions.QueryExecute("SELECT CHR_PR_BYPASS FROM m_inventorysetting WHERE INT_ROWID=1")[0][0];
						if(PR.equals("Y"))
							buyback = ""+CommonFunctions.QueryExecute("SELECT CHR_BYBACK FROM  inv_t_purchaserequest WHERE CHR_POREQUESTNO='"+purchaserequest+"'")[0][0];
						
						System.out.println(action);
						asql =" UPDATE inv_t_directpurchase SET";
						asql = asql +" DAT_ORDERDATE = ? , ";
						asql = asql +" INT_PAYMENTTERMID = ? ,";
						asql = asql +" INT_VENDORID =  ? ,";
						asql = asql +" CHR_DES = ? , ";
						asql = asql +" CHR_REF = ? , ";
						asql = asql +" DOU_AMOUNT = ? , ";
						asql = asql +" DOU_DISCOUNT = ? ,";
						asql = asql +" INT_TAXID =  ? , ";
						asql = asql +" DOU_TAXAMOUNT =  ? ,  ";
						asql = asql +" DOU_ROUNDED =  ? ,  ";
						asql = asql +" DOU_TOTALAMOUNT =  ? ,  ";
						asql = asql +" DOU_BASEAMOUNT =  ? ,  ";
						asql = asql +" CHR_BASEVALUE =  ? ,  ";
						asql = asql +" DOU_FRIEGHT_CHARGE_BASE_AMOUNT =  ? ,  ";
						asql = asql +" DOU_FRIEGHT_CHARGE_PERCENT =  ? ,  ";
						asql = asql +" DOU_FRIEGHT_CHARGE =  ?   ";
						asql = asql +" WHERE CHR_PURCHASEORDERNO =? "; 
						asql = asql +" AND  INT_BRANCHID = ?";
						apstm = con.prepareStatement(asql);
						apstm.setString(1,saleDate );
						apstm.setString(2,paymentterm );
						apstm.setString(3,custid  );
						apstm.setString(4,memo  );
						apstm.setString(5,ref  );
						apstm.setString(6,tot  );
						apstm.setString(7,totaldiscount  );
						apstm.setString(8,tax  );
						apstm.setString(9,salestaxamount  );
						apstm.setString(10,roundedoption  );
						apstm.setString(11,nettotal  );
						apstm.setString(12,basevalue  );
						apstm.setString(13,basevaluecheck  );    
						apstm.setString(14,frieghtamount  );
						apstm.setString(15,frieghttax  );
						apstm.setString(16,frieghtcharge  );
						apstm.setString(17,cashSaleNo  );
						apstm.setString(18,branchid  );
						System.out.println("1---"+apstm);
						apstm.execute();
						apstm.close();
						
						 
						
						
						asql = "DELETE FROM inv_t_directpurchaseitem WHERE CHR_PURCHASEORDERNO ='"+cashSaleNo.trim()+"' "; 
						asql = asql +" AND  INT_BRANCHID ="+branchid;
						apstm = con.prepareStatement(asql);
						System.out.println("2---"+apstm);
						apstm.execute();
						apstm.close();
						
						asql = "DELETE FROM inv_t_vendorgoodsreceived WHERE CHR_PURCHASEORDERNO ='"+cashSaleNo.trim()+"' "; 
						asql = asql +" AND  CHR_RECIVEDID ='"+cashSaleNo.trim()+"'";
						asql = asql +" AND  INT_BRANCHID ="+branchid;
						apstm = con.prepareStatement(asql);
						System.out.println("3---"+apstm);
						apstm.execute();
						apstm.close();
						
						
						asql = "SELECT CHR_ITEMID,CHR_TYPE,INT_PQTY,DOU_UNITPRICE FROM inv_t_vendorgoodsreceivedconsumable WHERE CHR_PURCHASEORDERNO ='"+cashSaleNo.trim()+"' "; 
						asql = asql +"   AND INT_BRANCHID ="+branchid;
						
						
						asql = "DELETE FROM inv_t_vendorgoodsreceivedconsumable WHERE CHR_PURCHASEORDERNO ='"+cashSaleNo.trim()+"' "; 
						asql = asql +" AND  CHR_RECIVEDID ='"+cashSaleNo.trim()+"'";
						asql = asql +" AND  INT_BRANCHID ="+branchid;
						apstm = con.prepareStatement(asql);
						System.out.println("4---"+apstm);
						apstm.execute();
						apstm.close();
						
						int desclength = Integer.parseInt(param);
						String itype="",warranty="";
						
						String consumables="";
						itype="";
						
						int rowmax=0;
						for(int u=1; u<=desclength;u++)
						{
							itype="";
							
							itype= request.getParameter("itype"+u);
							consumables =""+request.getParameter("consumables"+u);
							int dcqty =Integer.parseInt(request.getParameter("qty"+u));
							
							rowmax=0;
							sql = "SELECT MAX(INT_ID) FROM inv_t_directpurchaseitem WHERE CHR_PURCHASEORDERNO='"+cashSaleNo+"'";
							rowmax = CommonFunction.intMaxCount(sql)+1;
							
							String field = "INT_ID,INT_BRANCHID,CHR_PURCHASEORDERNO,CHR_ITEMID,CHR_TYPE,CHR_DESC,INT_QUANTITY,INT_WARRANTY,"; 
							field = field+"DOU_UNITPRICE,DOU_DISCOUNT,DOU_UNITDISCOUNT,INT_TAXID,DOU_TAX_PERCENTAGE,DOU_TAX_AMOUNT,DOU_TOTAL,INT_DIVIID,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS" ;
							
							asql=" INSERT INTO inv_t_directpurchaseitem (" +field+" ) VALUES (";
							asql = asql +" ?,?,?,?,?,?,?,?,"; 
							asql = asql +" ?,?,?,?,?,?,?,?,?,DATE(now()) , 'Y' ) ";
							apstm = con.prepareStatement(asql);
							apstm.setString(1, ""+rowmax);
							apstm.setString(2, branchid);
							apstm.setString(3, cashSaleNo );
							apstm.setString(4, request.getParameter("item"+u) );
							apstm.setString(5, itype);
							apstm.setString(6,request.getParameter("desc"+u));
							apstm.setString(7,""+dcqty);
							apstm.setString(8,request.getParameter("warranty"+u));
							apstm.setString(9,request.getParameter("uprice"+u));
							apstm.setString(10,request.getParameter("discount"+u));
							apstm.setString(11,request.getParameter("unitdiscount"+u));
							apstm.setString(12,request.getParameter("stax"+u));
							apstm.setString(13,request.getParameter("staxpercentage"+u));
							apstm.setString(14,request.getParameter("staxamount"+u));
							apstm.setString(15,request.getParameter("total"+u));
							apstm.setString(16,division);
							apstm.setString(17,auserid);
							System.out.println("6---"+apstm);
							apstm.execute();
							apstm.close();	
							 
							 
							//
							//
							
							if(!consumables.equals("S"))
							{
								 
								for(int v=0; v<Integer.parseInt(request.getParameter("qty"+u));v++)
									{
										 
										 
										asql = "INSERT INTO inv_t_vendorgoodsreceived ( INT_DIVIID,INT_BRANCHID,CHR_PURCHASEORDERNO,";
										asql = asql+" CHR_TYPE,CHR_ITEMID,CHR_RECIVEDID,DAT_RECIVEDDATE ,CHR_RECEIVEDMODE, " ;
										asql = asql+" DOU_UNITPRICE,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS,CHR_POREQUESTNO, ";
										asql = asql+" DAT_PURCHASE_WARRANTY_START,DAT_PURCHASE_WARRANTY_END,CHR_BUYBACK_STOCK,CHR_WARRANTY  )"; 
										asql = asql+" VALUES (?,?,?,?,?,?,? ,?,?,?,DATE(NOW()),'Y',?,?,DATE(DATE_ADD('"+saleDate+"', INTERVAL 1 YEAR)) ,?  ,? ) " ;
										  
										apstm = con.prepareStatement(asql);
										apstm.setString(1, division );
										apstm.setString(2,branchid);
										apstm.setString(3,cashSaleNo);
										apstm.setString(4,itype);
										apstm.setString(5, request.getParameter("item"+u));
										apstm.setString(6,cashSaleNo);
										apstm.setString(7,saleDate);
										apstm.setString(8,"D");
										apstm.setString(9,request.getParameter("uprice"+u));
										apstm.setString(10,userId);
										apstm.setString(11,purchaserequest);
										apstm.setString(12,saleDate);
										apstm.setString(13,buyback);
										apstm.setString(14,request.getParameter("warranty"+u));
										
										System.out.println("7---"+apstm);
										apstm.execute();
										apstm.close();
								
								  
								
								
									}
							}
							else
							{
								asql = "INSERT INTO inv_t_vendorgoodsreceivedconsumable ( INT_BRANCHID,CHR_PURCHASEORDERNO,CHR_TYPE,CHR_ITEMID,INT_PQTY,CHR_RECIVEDID,DAT_RECIVEDDATE ,CHR_RECEIVEDMODE, DOU_UNITPRICE,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS  ) VALUES ( ";
								asql = asql+branchid +" , ";
								asql = asql+" '"+cashSaleNo +"' , ";
								asql = asql+" '"+itype +"' , ";
								asql = asql+" '"+request.getParameter("item"+u) +"' , ";
								asql = asql+" "+Integer.parseInt(request.getParameter("qty"+u)) +" , ";
								asql = asql+" '"+cashSaleNo +"' , ";
								asql = asql+" now() , 'D',";
								asql = asql+"  "+Double.parseDouble(request.getParameter("uprice"+u)) +"  , ";
								asql = asql +"'"+userId+"', ";
								asql = asql +" now() , 'Y' ) ";
								apstm = con.prepareStatement(asql);
								System.out.println("8---"+apstm);
								apstm.execute();
								apstm.close();
								
								 
								
							}
							
							
						}
						request.setAttribute("serialno", "true");
						con.close();    
						response.sendRedirect("Smart Inventory/DirectPurchaseSerial.jsp?pono="+cashSaleNo);
					} 
					catch (Exception e) 
					{
						System.out.println(asql);
						System.out.println(e.getMessage());
						request.setAttribute("error", e.getMessage() );
			            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
			    		dispatchers.forward(request, response); 
							

					}
				}
				else if("INVDirectPurchaseDelete".equals(action))
				{
					String pos = request.getParameter("saleno");
					String reason = request.getParameter("reason");
					String email = request.getParameter("email");
					pos=pos+",";
					String cashsaleids[] = pos.split(",");
					String prno="";
					for(int u=0; u<cashsaleids.length;u++)
					{	
						String cashSaleNo = cashsaleids[u].trim();
						sql = " SELECT INT_BRANCHID,CHR_POREQUESTNO FROM inv_t_directpurchase  WHERE CHR_PURCHASEORDERNO ='"+cashSaleNo+"' "; 
						String data[][] = CommonFunctions.RecordSetArray(con, sql);
						String  branchId= data[0][0];
						prno= data[0][1];
						
						asql ="DELETE FROM inv_t_directpurchase  WHERE CHR_PURCHASEORDERNO ='"+cashSaleNo+"' "; 
						asql = asql +" AND INT_BRANCHID ="+Integer.parseInt(branchId);
						apstm = con.prepareStatement(asql);
						System.out.println("0---"+apstm);
						apstm.execute();
						apstm.close();
						
						
						asql ="UPDATE inv_t_purchaserequest  SET CHR_PR_PARTIALLY_RECEIVED='N' WHERE  CHR_POREQUESTNO ='"+prno+"' "; 
						apstm = con.prepareStatement(asql);
						System.out.println("1---"+apstm);
						apstm.execute();
						apstm.close();
						
						
						asql = "DELETE FROM inv_t_directpurchaseitem WHERE CHR_PURCHASEORDERNO ='"+cashSaleNo.trim()+"' "; 
						asql = asql +"  AND INT_BRANCHID ="+Integer.parseInt(branchId);
						apstm = con.prepareStatement(asql);
						System.out.println("2---"+apstm);
						apstm.execute();
						apstm.close();
						
						
						
						asql = "DELETE FROM inv_t_vendorgoodsreceived WHERE CHR_PURCHASEORDERNO ='"+cashSaleNo.trim()+"' "; 
						asql = asql +"   AND INT_BRANCHID ="+branchid;
						apstm = con.prepareStatement(asql);
						System.out.println("3---"+apstm);
						apstm.execute();
						apstm.close();
						
						
						asql = "DELETE FROM inv_t_vendorgoodsreceivedconsumable WHERE CHR_PURCHASEORDERNO ='"+cashSaleNo.trim()+"' "; 
						asql = asql +"   AND INT_BRANCHID ="+branchid;
						apstm = con.prepareStatement(asql);
						System.out.println("4---"+apstm);
						apstm.execute();
						apstm.close();
						
						asql =" INSERT INTO inv_t_invoicedelete (INT_BRANCHID,CHR_PURCHASEORDERNO,CHR_DES,DAT_DELETEDATE,CHR_INVOICEMODE,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS) ";
						asql = asql +"VALUES ( "+branchid+", ";
						asql = asql+"'"+cashSaleNo+"', ";
						asql = asql+"'"+reason+"', NOW(),'INWARD','ADMIN',NOW(),'Y' )";
						apstm = con.prepareStatement(asql);
						System.out.println("5---"+apstm);
						apstm.execute();
						apstm.close();	
						
						sql = "UPDATE inv_t_directsales SET CHR_BYBACKINWARD='N' WHERE CHR_SALESNO = ";
						sql = sql+ "(SELECT CHR_SALESNO FROM inv_t_purchaserequest WHERE CHR_BYBACK ='Y' AND CHR_POREQUESTNO =?) ";
						apstm=con.prepareStatement(sql);
						apstm.setString(1,prno);
						apstm.execute();
						apstm.close();
						
						
						
						//Send a mail for Delete invoice
						String a[] =(email+","+CommonData.mailid).split(",") ;
						com.my.org.erp.mail.Mail.SimpleHTMLMail(  a,  "DELETE  PURCHASE BILLING :: "+cashSaleNo, InvoiceDeletetMail.InvoiceDeletesendtoMail("DELETE  PURCHASE BILLING :: "+cashSaleNo,cashSaleNo,reason, "PURCHASE BILLING"));
						 
					}
					con.close();    
					response.sendRedirect("Smart Inventory/Direct Purchase.jsp ");
				}
				else if("INVDirectPurchaseAddserial".equals(action))
				{
					String purchasenumber = request.getParameter("purchasenumber");
					String division = request.getParameter("division");
					String seriallength =request.getParameter("seriallength");
					String pdate =request.getParameter("pdate");
					String buybackstocktype =request.getParameter("buybackstocktype");
					 
					asql ="UPDATE  inv_t_vendorgoodsreceived SET " ; 
					asql = asql +" CHR_SERIALNO =? , ";
					asql = asql +" CHR_WARRANTY =?, ";
					asql = asql +" CHR_QUALITY =? , ";
					asql = asql +" CHR_PURCHASE_WARRANTY =? , ";
					asql = asql +" DAT_PURCHASE_WARRANTY_START = ? ,  ";
					asql = asql +" DAT_PURCHASE_WARRANTY_END  = ( SELECT DATE_FORMAT(DATE_ADD('"+pdate+"', INTERVAL ? YEAR),'%Y-%m-%d') ) ,  ";
					asql = asql +" CHR_BUYBACK_STOCK= ? ";
					asql = asql +" WHERE CHR_PURCHASEORDERNO =?";
					asql = asql +" AND CHR_ITEMID = ?";
					asql = asql +" AND CHR_TYPE = ?";
					asql = asql +" AND INT_ID = ?";
					apstm = con.prepareStatement(asql);
					for(int v=1;v<Integer.parseInt(seriallength); v++)
					{
						int rowid = Integer.parseInt(request.getParameter("rowid"+v));
						String itemid= (""+request.getParameter("item"+v)).trim();
						String itype= (""+request.getParameter("itype"+v)).trim();
						String serail = request.getParameter("serial"+v);
						String warranty = request.getParameter("warranty"+v);
						String good = request.getParameter("good"+v);
						 
						apstm.setString(1,serail.trim().replaceAll(",", "") );
						apstm.setString(2,warranty);
						apstm.setString(3,good);
						apstm.setString(4,warranty);
						apstm.setString(5,pdate);
						apstm.setString(6,warranty);
						apstm.setString(7,buybackstocktype);
						apstm.setString(8,purchasenumber);
						apstm.setString(9,itemid );
						apstm.setString(10,itype );
						apstm.setString(11,""+rowid );
						System.out.println(""+apstm);
						apstm.addBatch();
					}
					apstm.executeBatch();
					apstm.close();
					
					
					//stock updation for consumables stock
					sql ="SELECT INT_BRANCHID,CHR_PURCHASEORDERNO,CHR_TYPE,CHR_ITEMID,INT_PQTY,DOU_UNITPRICE,((INT_PQTY)*(DOU_UNITPRICE)) 	FROM inv_t_vendorgoodsreceivedconsumable WHERE CHR_PURCHASEORDERNO='"+purchasenumber+"' ORDER BY INT_ROWID";
					String consdata[][] =  CommonFunctions.RecordSetArray(con, sql);
					if(consdata.length>0)
					{	
						for(int v=0;v<consdata.length;v++)
						{
							 
							String pid = consdata[v][3].trim();
							
							//this is for inward to stock
							sql = "UPDATE  inv_t_vendorgoodsreceivedconsumable SET CHR_RDSTATUS='S' ";
							sql = sql +" WHERE CHR_TYPE='P'  AND CHR_ITEMID='"+pid+"'";
							sql = sql +" AND INT_BRANCHID="+branchid+" ";
							st.execute(sql);
				 		}
					}
					
					asql =" UPDATE inv_t_directpurchase SET ";
					asql = asql +" CHR_FLAG ='Y' ";
					asql = asql +" WHERE CHR_PURCHASEORDERNO ='"+purchasenumber+"' "; 
					asql = asql +" AND  INT_BRANCHID ="+branchid;
					apstm = con.prepareStatement(asql);
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
					 
					
					//generate mail
					DirectPurchaseMail.sendInwardMail(branchid,purchasenumber,division,Path); 
					
					con.close();    
					response.sendRedirect("Smart Inventory/Direct Purchase.jsp ");
				}
				else if("INVStockSerialUpdates".equals(action))
				{
					String serial = ""+request.getParameter("serial");					
					String rowid = ""+request.getParameter("rowid");
					String itype = ""+request.getParameter("itype");
					String itemid = ""+request.getParameter("itemid");
					String ponumber = ""+request.getParameter("ponumber");
					String good = ""+request.getParameter("good");
					String pwaranty = (""+request.getParameter("pwaranty")).trim();
					String warranty = (""+request.getParameter("warranty")).trim();
					String unitprice = ""+request.getParameter("unitprice");
					String dbunitprice = ""+request.getParameter("dbunitprice");
					String pdate = ""+request.getParameter("pdate");
					
					asql = "UPDATE  inv_t_vendorgoodsreceived SET" ;
					asql = asql +" CHR_SERIALNO = '"+serial+"' , ";
					
					if(!pwaranty.equals(warranty))
					{	
						asql = asql +" CHR_WARRANTY  = '"+warranty+"' , ";
						
						String ssql= " INSERT INTO inv_t_warrantytrack (CHR_TYPE,CHR_ITEMID,CHR_SERIALNO,CHR_PURCHASE_WARRANTY,CHR_SALE_WARRANTY,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS) VALUES (";
						ssql = ssql+"'" +itype+"' , ";
						ssql = ssql+"'" +itemid+"' , ";
						ssql = ssql+"'" +serial+"' , ";
						ssql = ssql+"'" +pwaranty+"' , ";
						ssql = ssql+"'" +warranty+"' , ";
						ssql = ssql+"'" +userId+"' , ";
						ssql = ssql+" now() , 'Y' )";
						st.execute(ssql);
					}	
					
					if(!dbunitprice.equals(unitprice))
					{	
						asql = asql +" DOU_UNITPRICE="+unitprice+" , ";
						
						String ssql= " INSERT INTO inv_t_unitpricetrack (CHR_TYPE,CHR_ITEMID,CHR_SERIALNO,DOU_UNITPRICE,DOU_DBUNITPRICE,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS) VALUES (";
						ssql = ssql+"'" +itype+"' , ";
						ssql = ssql+"'" +itemid+"' , ";
						ssql = ssql+"'" +serial+"' , ";
						ssql = ssql+"" +unitprice+" , ";
						ssql = ssql+"" +dbunitprice+" , ";
						ssql = ssql+"'" +userId+"' , ";
						ssql = ssql+" now() , 'Y' )";
						st.execute(ssql);
					}
					
					asql = asql +" CHR_QUALITY = '"+good+"' ,";
					
					if(!"-".equals(pdate))
					{
						asql = asql +" DAT_PURCHASE_WARRANTY_START ='"+pdate+"' ,  ";
						asql = asql +" DAT_PURCHASE_WARRANTY_END  = ( SELECT DATE_FORMAT(DATE_ADD('"+pdate+"', INTERVAL "+warranty+" YEAR),'%Y-%m-%d') ) ,   ";
					}
					asql = asql +" CHR_QUALITY = '"+good+"'  ";
					asql = asql +" WHERE INT_ID = "+rowid;
					asql = asql +" AND INT_BRANCHID = "+branchid;
					asql = asql +" AND CHR_PURCHASEORDERNO = '"+ponumber+"'";
					asql = asql +" AND CHR_ITEMID = '"+itemid+"'";
					asql = asql +" AND CHR_TYPE = '"+itype+"'";
					apstm = con.prepareStatement(asql);
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
					
					con.close();    
					response.sendRedirect("Smart Inventory/GoodsRecived.jsp");
				}
				else if(action.equals("INVDirectPurchaseCancel"))
				{

					System.out.println("DIRECT PURCHASE CANCEL");
					String pono = request.getParameter("pono");
					String reason = request.getParameter("reason");
					
					
					sql = " SELECT  CHR_POREQUESTNO FROM inv_t_directpurchase  WHERE CHR_PURCHASEORDERNO ='"+pono+"' "; 
					String data[][] = CommonFunctions.RecordSetArray(con, sql);
					if(data.length>0)
					{
						asql ="UPDATE inv_t_purchaserequest  SET CHR_PR_PARTIALLY_RECEIVED='N' WHERE  CHR_POREQUESTNO ='"+data[0][0]+"' "; 
						apstm = con.prepareStatement(asql);
						System.out.println("1---"+apstm);
						apstm.execute();
						apstm.close();
						
						//BY BACK set N
						asql = "UPDATE inv_t_directsales SET CHR_BYBACKINWARD='N' WHERE CHR_SALESNO = ";
						asql = asql+ "(SELECT CHR_SALESNO FROM inv_t_purchaserequest WHERE CHR_BYBACK ='Y' AND CHR_POREQUESTNO =?) ";
						apstm=con.prepareStatement(asql);
						apstm.setString(1,data[0][0]);
						System.out.println("2---"+apstm);
						apstm.execute();
						apstm.close();
					}
					
					asql = "UPDATE inv_t_directpurchase SET DOU_CANCELAMOUNT =DOU_TOTALAMOUNT,  DOU_AMOUNT=0, DOU_DISCOUNT=0,DOU_TAXAMOUNT=0,DOU_TOTALAMOUNT=0,CHR_CANCELDESC =?,CHR_CANCEL='Y',CHR_CANCELID=?,DAT_CANCELDATE=NOW() WHERE CHR_PURCHASEORDERNO=?";
					apstm = con.prepareStatement(asql);
					apstm.setString(1, reason);
					apstm.setString(2, ""+session.getAttribute("EMPID"));
					apstm.setString(3, pono);
					System.out.println("3---------"+apstm);
					apstm.execute();
					apstm.close();
					
					asql = " UPDATE inv_t_directpurchaseitem  SET DOU_UNITPRICE=0 , DOU_TAX_AMOUNT=0, DOU_TOTAL=0 WHERE CHR_PURCHASEORDERNO =? ";
					apstm = con.prepareStatement(asql);
					apstm.setString(1, pono);
					System.out.println("4--------"+apstm);
					apstm.execute();
					apstm.close();
					
					asql = " UPDATE inv_t_vendorgoodsreceivedconsumable  SET CHR_CANCEL='Y' WHERE CHR_PURCHASEORDERNO =? ";
					apstm = con.prepareStatement(asql);
					apstm.setString(1, pono);
					System.out.println("5--------"+apstm);
					apstm.execute();
					apstm.close();
					
					
					asql = " UPDATE inv_t_vendorgoodsreceived SET DAT_PURCHASE_WARRANTY_START=null, ";
					asql = asql + " CHR_FLAG='N',DAT_PURCHASE_WARRANTY_END=null, CHR_SERIALNO=null, ";
					asql = asql + " CHR_SALESNO=null,DT_SALEDATE=null,DOU_SALEUNITPRICE=null ";
					asql = asql + "  WHERE CHR_PURCHASEORDERNO=? ";
					apstm = con.prepareStatement(asql);
					apstm.setString(1, pono);
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
					
					 
					//Send a mail for cancell PURCHASE
					String email=request.getParameter("email");
					String a[] =(email+","+CommonData.mailid).split(",") ;
					Mail.SimpleHTMLMail(  a,  "CANCELLED  DIRECT PURCHASE:: "+pono, InvoiceDeletetMail.InvoiceCancellsendtoMail("CANCELLED DIRECT PURCHASE :: "+pono,pono,reason, " DIRECT PURCHASE"));
					response.sendRedirect("Smart Inventory/Direct Purchase.jsp");
				}
				else if("INVDirectPurchaseMail".equals(action))
				{
					String pono = request.getParameter("pono");
					if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_MAILENABLE FROM m_inventorysetting WHERE INT_ROWID=1")[0][0]))
					{	
						String divis =  CommonFunctions.QueryExecute("SELECT 	INT_DIVIID  FROM inv_t_directpurchase 	WHERE CHR_PURCHASEORDERNO='"+pono+"' ")[0][0];
						String to =  CommonFunctions.QueryExecute("SELECT CHR_EMAILID FROM inv_m_division  WHERE INT_DIVIID="+divis)[0][0];
						String approvalmail =  CommonFunctions.QueryExecute("SELECT CHR_PR_APPROVAL ,CHR_PR_CLOSED FROM m_inventorysetting WHERE INT_ROWID=1")[0][0];
						String a[] =(""+CommonData.mailid+","+to+","+approvalmail).split(",") ;
						String content = DirectPurchaseTriggerMail.PurchaseContent(branchid, pono);
						DirectPurchaseTriggerMail.sendtoMail(a, "Material inwarded  :: "+pono , content);
					}
					response.sendRedirect("Smart Inventory/Direct Purchase.jsp");
				}
				
				else if("INVDirectPurchaseRefModify".equals(action))
				{
					String ponumber = request.getParameter("ponumber");
					String vendorerefno = request.getParameter("vendorerefno");
					asql = "UPDATE inv_t_directpurchase SET CHR_VENDORPO =? WHERE CHR_PURCHASEORDERNO=?";
					apstm = con.prepareStatement(asql);
					apstm.setString(1, vendorerefno);
					apstm.setString(2, ponumber);
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
					response.sendRedirect("Smart Inventory/DirectGoodsReceiveModified.jsp?gdreceiveno="+ponumber);
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


