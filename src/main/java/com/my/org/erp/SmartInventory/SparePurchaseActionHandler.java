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

import com.my.org.erp.bean.inventory.SparePurchase;
import com.my.org.erp.setting.CommonData;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;

public class SparePurchaseActionHandler extends AbstractActionHandler
{

	public static String purchaserequest="";
	public static void  itemInsert(HttpServletRequest request,HttpServletResponse response, String cashSaleNo ,Connection con, Statement st, String branch,String pDate)throws ServletException, IOException 
	{
		try 
		{
			 
			String sql="";			
			HttpSession session=request.getSession();			
			String userId=""+session.getAttribute("USRID");
			String branchid = session.getAttribute("BRANCHID").toString();
			String param[] = request.getParameter("param").split(",");
			String spareid = "";
			int pqty=0;
			for(int p=0;p<param.length; p++)
			{
			
				spareid =""+request.getParameter("spare"+param[p].trim());
				pqty =Integer.parseInt(request.getParameter("qty"+param[p].trim()));
				
				//insert into total Spare 
				sql=" INSERT INTO inv_t_sparepurchaseitem ( ";
				sql = sql+" INT_BRANCHID,CHR_PURCHASENO,INT_SPAREID,CHR_DESC,INT_QUANTITY, "; 
				sql = sql+ " DOU_UNITPRICE,DOU_DISCOUNT,DOU_UNITDISCOUNT,INT_TAXID,DOU_TAX_PERCENTAGE,DOU_TAX_AMOUNT,DOU_TOTAL,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS" ;
				sql = sql+" ) VALUES (";
				sql = sql+" ?,?,?,?,?, "; 
				sql = sql+ " ?,?,?,?,?,?,?,?,DATE(NOW()),'Y' )" ;
				PreparedStatement pstm = con.prepareStatement(sql);
				pstm.setString(1, branchid);
				pstm.setString(2, cashSaleNo );
				pstm.setString(3, spareid );
				pstm.setString(4, request.getParameter("desc"+param[p].trim()).replace("\"", ""));
				pstm.setString(5, ""+pqty);
				pstm.setString(6, request.getParameter("uprice"+param[p].trim()) );
				pstm.setString(7,  request.getParameter("discount"+param[p].trim()));
				pstm.setString(8, request.getParameter("unitdiscount"+param[p].trim()));
				pstm.setString(9, request.getParameter("stax"+param[p].trim()));
				pstm.setString(10, request.getParameter("staxpercentage"+param[p].trim()));
				pstm.setString(11, request.getParameter("staxamount"+param[p].trim()));
				pstm.setString(12, request.getParameter("total"+param[p].trim()));
				pstm.setString(13,  userId);
				System.out.println(""+pstm);
				pstm.execute();
				pstm.close();
				
				//insert into individual serial number and warranty
			 	
				for(int u=0; u<Integer.parseInt(request.getParameter("qty"+param[p].trim()));u++)
				{
					sql = "INSERT INTO inv_t_sparegoodsreceived (INT_BRANCHID,CHR_PURCHASENO," +
							"INT_SPAREID, CHR_RECIVEDID,DAT_RECIVEDDATE ,CHR_RECEIVEDMODE, " +
							"DOU_UNITPRICE,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS  ) " +
							"VALUES (?,?,?,?,?,?,?,?,DATE(NOW()),'Y' ) " ;
					pstm = con.prepareStatement(sql);
					pstm.setString(1,branchid);
					pstm.setString(2,cashSaleNo);
					pstm.setString(3,spareid);
					pstm.setString(4,cashSaleNo);
					pstm.setString(5,DateUtil.FormateDateSQL(pDate));
					pstm.setString(6,"D");
					pstm.setString(7,request.getParameter("uprice"+param[p].trim()));
					pstm.setString(8,userId);
					System.out.println(""+pstm);
					pstm.execute();
					pstm.close();
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
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	 {
		try
		{
				String action=request.getParameter("actionS");
				HttpSession session=request.getSession();			
				String userId=""+session.getAttribute("USRID");
				String branchid = session.getAttribute("BRANCHID").toString();
				String pDate=request.getParameter("saleDate");
				Statement st = con.createStatement();
				
				if(action.equals("INVSparePurchaseAdd"))
				{
					SparePurchase d = new SparePurchase();
					Map map=request.getParameterMap();
					BeanUtils.populate(d,map);
					SparePurchaseMethod.addSparePurchase(con, d, request, response);
					
					String cashSaleNo =""+request.getParameter("cashSaleNo");
					String PONO=""+session.getAttribute("PONO");
					cashSaleNo=PONO;
					itemInsert(request,response,cashSaleNo,con,st,branchid,pDate);
					con.close();   
					response.sendRedirect("Smart Inventory/SpareInwardSerial.jsp?pono="+cashSaleNo);
				}
				else if("INVSparePurchaseAddserial".equals(action))
				{
					String purchasenumber = request.getParameter("purchasenumber");
					String seriallength =request.getParameter("seriallength");
					asql =" UPDATE inv_t_sparepurchase SET ";
					asql = asql +" CHR_FLAG ='Y' ";
					asql = asql +" WHERE CHR_PURCHASENO ='"+purchasenumber+"' "; 
					asql = asql +" AND  INT_BRANCHID ="+branchid;
					apstm = con.prepareStatement(asql);
					apstm.execute();
					apstm.close();
					 
					for(int v=1;v<Integer.parseInt(seriallength); v++)
					{
						int rowid = Integer.parseInt(request.getParameter("rowid"+v));
						String serail = request.getParameter("serial"+v);
						String warranty = request.getParameter("warranty"+v);
						String good = request.getParameter("good"+v);
						
						asql ="UPDATE  inv_t_sparegoodsreceived SET " ; 
						asql = asql +" CHR_SERIALNO ='"+serail+"' , ";
						asql = asql +" CHR_WARRANTY ='"+warranty+"' , ";
						asql = asql +" CHR_QUALITY ='"+good+"' , ";
						asql = asql +" CHR_PURCHASE_WARRANTY ='"+warranty+"'  ";
						asql = asql +"WHERE CHR_PURCHASENO ='"+purchasenumber+"'";
						asql = asql +" AND INT_SERIALID = "+rowid;
						apstm = con.prepareStatement(asql);
						apstm.execute();
						apstm.close();
					}
					
					con.close();    
					response.sendRedirect("Smart Inventory/SpareInwardView.jsp ");
				}
				else if("INVSparePurchaseUpdates".equals(action))
				{
					String serial = ""+request.getParameter("serial");					
					String rowid = ""+request.getParameter("rowid");
					String spareid = ""+request.getParameter("spareid");
					String good = ""+request.getParameter("good");
					String pwaranty = (""+request.getParameter("pwaranty")).trim();
					String warranty = (""+request.getParameter("warranty")).trim();
					String unitprice = ""+request.getParameter("unitprice");
					String dbunitprice = ""+request.getParameter("dbunitprice");
					asql = "UPDATE  inv_t_sparegoodsreceived SET" ;
					asql = asql +" CHR_SERIALNO = '"+serial+"' , ";
					if(!pwaranty.equals(warranty))
					{
						asql = asql +" CHR_WARRANTY  = '"+warranty+"' , ";
						String ssql= " INSERT INTO inv_t_sparewarrantytrack (INT_SPAREID,CHR_SERIALNO,CHR_PURCHASE_WARRANTY,CHR_SALE_WARRANTY,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS) VALUES (";
						ssql = ssql+"" +spareid+" , ";
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
						String ssql= " INSERT INTO inv_t_spareunitpricetrack (INT_SPAREID,CHR_SERIALNO,DOU_UNITPRICE,DOU_DBUNITPRICE,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS) VALUES (";
						ssql = ssql+"" +spareid+" , ";
						ssql = ssql+"'" +serial+"' , ";
						ssql = ssql+"" +unitprice+" , ";
						ssql = ssql+"" +dbunitprice+" , ";
						ssql = ssql+"'" +userId+"' , ";
						ssql = ssql+" now() , 'Y' )";
						st.execute(ssql);
					}	
					asql = asql +" CHR_QUALITY = '"+good+"'";
					asql = asql +" WHERE INT_SERIALID = "+rowid;
					apstm = con.prepareStatement(asql);
					
					apstm.execute();
					apstm.close();
					con.close();    
					response.sendRedirect("Smart Inventory/InventoryMain.jsp");
				}
				else if("INVSparePurchaseUpdate".equals(action))
				{
					 
					try 
					{
						String cashSaleNo =""+request.getParameter("ponumber");
						String custid =""+request.getParameter("vendorid");
						String saleDate =""+request.getParameter("saleDate");
						saleDate=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(saleDate);
						String paymentterm =""+request.getParameter("payment");
						String memo =""+request.getParameter("memo");
						String ref =""+request.getParameter("ref");
						String tot =""+request.getParameter("totals");
						String totaldiscount =""+request.getParameter("totaldiscount");
						String tax =""+request.getParameter("tax");
						String salestaxamount =""+request.getParameter("salestaxamount");
						String nettotal =""+request.getParameter("nettotal");	
						asql =" UPDATE inv_t_sparepurchase SET ";
						asql = asql +" DAT_ORDERDATE = ? , ";
						asql = asql +" INT_PAYMENTTERMID = ? ,";
						asql = asql +" INT_VENDORID =  ? ,";
						asql = asql +" CHR_DES = ?, ";
						asql = asql +" CHR_REF = ? , ";
						asql = asql +" DOU_AMOUNT =  ? , ";
						asql = asql +" DOU_DISCOUNT = ?, ";
						asql = asql +" INT_TAXID =  ? , ";
						asql = asql +" DOU_TAXAMOUNT =  ? ,  ";
						asql = asql +" DOU_TOTALAMOUNT =  ?  ";
						asql = asql +" WHERE CHR_PURCHASENO =?"; 
						asql = asql +" AND  INT_BRANCHID =?";
						apstm = con.prepareStatement(asql);
						apstm.setString(1,saleDate);
						apstm.setString(2,paymentterm);
						apstm.setString(3,custid);
						apstm.setString(4,memo);
						apstm.setString(5,ref);
						apstm.setString(6,tot);
						apstm.setString(7,totaldiscount);
						apstm.setString(8,tax);
						apstm.setString(9,salestaxamount);
						apstm.setString(10,nettotal);
						apstm.setString(11,cashSaleNo);
						apstm.setString(12,branchid);
						apstm.execute(); 
						apstm.close();
						
						
						
						asql = "DELETE FROM inv_t_sparepurchaseitem WHERE CHR_PURCHASENO =? "; 
						asql = asql +" AND  INT_BRANCHID =?" ;
						apstm = con.prepareStatement(asql);
						apstm.setString(1,cashSaleNo);
						apstm.setString(2,branchid);
						apstm.execute(); 
						apstm.close();
						
						asql = "DELETE FROM inv_t_sparegoodsreceived WHERE CHR_PURCHASENO =? "; 
						asql = asql +" AND  CHR_RECIVEDID =?";
						asql = asql +" AND  INT_BRANCHID =?" ;
						apstm = con.prepareStatement(asql);
						apstm.setString(1,cashSaleNo);
						apstm.setString(2,cashSaleNo);
						apstm.setString(3,branchid);
						apstm.execute(); 
						apstm.close();
						
						String param[] = request.getParameter("param").split(",");
						String spareid = "";
						String pqty = "";
						for(int p=0;p<param.length; p++)
						{
						
							spareid =""+request.getParameter("spare"+param[p].trim());
							pqty = ""+request.getParameter("qty"+param[p].trim());
							
							//insert into total Spare 
							asql=" INSERT INTO inv_t_sparepurchaseitem ( ";
							asql = asql+" INT_BRANCHID,CHR_PURCHASENO,INT_SPAREID,CHR_DESC,INT_QUANTITY, "; 
							asql = asql+ " DOU_UNITPRICE,DOU_DISCOUNT,DOU_UNITDISCOUNT,INT_TAXID,DOU_TAX_PERCENTAGE,DOU_TAX_AMOUNT,DOU_TOTAL,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS" ;
							asql = asql+" ) VALUES (";
							asql = asql+" ?,?,?,?,?, "; 
							asql = asql+ " ?,?,?,?,?,?,?,?,DATE(NOW()),'Y' )" ;
							apstm = con.prepareStatement(asql);
							apstm.setString(1, branchid);
							apstm.setString(2, cashSaleNo );
							apstm.setString(3, spareid );
							apstm.setString(4, request.getParameter("desc"+param[p].trim()).replace("\"", ""));
							apstm.setString(5, ""+pqty);
							apstm.setString(6, request.getParameter("uprice"+param[p].trim()) );
							apstm.setString(7,  request.getParameter("discount"+param[p].trim()));
							apstm.setString(8, request.getParameter("unitdiscount"+param[p].trim()));
							apstm.setString(9, request.getParameter("stax"+param[p].trim()));
							apstm.setString(10, request.getParameter("staxpercentage"+param[p].trim()));
							apstm.setString(11, request.getParameter("staxamount"+param[p].trim()));
							apstm.setString(12, request.getParameter("total"+param[p].trim()));
							apstm.setString(13,  userId);
							apstm.execute();
							apstm.close();
						
							//insert into individual serial number and warranty
						 	for(int u=0; u<Integer.parseInt(request.getParameter("qty"+param[p].trim()));u++)
							{
								asql = "INSERT INTO inv_t_sparegoodsreceived (INT_BRANCHID,CHR_PURCHASENO," +
										"INT_SPAREID, CHR_RECIVEDID,DAT_RECIVEDDATE ,CHR_RECEIVEDMODE, " +
										"DOU_UNITPRICE,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS  ) " +
										"VALUES (?,?,?,?,?,?,?,?,DATE(NOW()),'Y' ) " ;
								apstm = con.prepareStatement(asql);
								apstm.setString(1,branchid);
								apstm.setString(2,cashSaleNo);
								apstm.setString(3,spareid);
								apstm.setString(4,cashSaleNo);
								apstm.setString(5,DateUtil.FormateDateSQL(pDate));
								apstm.setString(6,"D");
								apstm.setString(7,request.getParameter("uprice"+param[p].trim()));
								apstm.setString(8,userId);
								apstm.execute();
								apstm.close();
							}
						} 
						con.close();    
						response.sendRedirect("Smart Inventory/SpareInwardSerial.jsp?pono="+cashSaleNo);
					} 
					catch (Exception e) 
					{
						System.out.println(e.getMessage());
					}
				}
				else if("INVSparePurchaseDelete".equals(action))
				{
					try 
					{
						String pos = request.getParameter("saleno");
						String reason = request.getParameter("reason");
						String email = request.getParameter("email");
						pos=pos+",";
						String cashsaleids[] = pos.split(",");
						for(int u=0; u<cashsaleids.length;u++)
						{	
							asql = "DELETE FROM inv_t_sparepurchase WHERE CHR_PURCHASENO =? "; 
							apstm = con.prepareStatement(asql);
							apstm.setString(1,cashsaleids[u]);
							apstm.execute(); 
							apstm.close();
							
							asql = "DELETE FROM inv_t_sparepurchaseitem WHERE CHR_PURCHASENO =? "; 
							apstm = con.prepareStatement(asql);
							apstm.setString(1,cashsaleids[u]);
							apstm.execute(); 
							apstm.close();
							 
							asql = "DELETE FROM inv_t_sparegoodsreceived WHERE CHR_PURCHASENO =? "; 
							apstm = con.prepareStatement(asql);
							apstm.setString(1,cashsaleids[u]);
							apstm.execute(); 
							apstm.close();
							 	
						  
							asql =" INSERT INTO inv_t_spareinvoicedelete ( CHR_PURCHASENO,CHR_DES,";
							asql = asql +" DAT_DELETEDATE,CHR_INVOICEMODE,CHR_USRNAME,";
							asql = asql +" DT_UPDATEDATE,CHR_UPDATESTATUS) ";
							asql = asql +" VALUES ( ?,?, DATE(NOW()),'INWARD',?,DATE(NOW()),'Y')";
							apstm = con.prepareStatement(asql);
							apstm.setString(1,cashsaleids[u]);
							apstm.setString(2,reason);
							apstm.setString(3,userId);
							apstm.execute(); 
							apstm.close();
							
							//Send a mail for Delete invoice
							String a[] =(email+","+CommonData.mailid).split(",") ;
							com.my.org.erp.mail.Mail.SimpleHTMLMail(  a,  "DELETE SPARE BILLING :: "+cashsaleids[u], InvoiceDeletetMail.InvoiceDeletesendtoMail("DELETE SPARE BILLING :: "+cashsaleids[u],cashsaleids[u],reason, "PURCHASE SPARE BILLING"));
							 
						}
						con.close();    
						response.sendRedirect("Smart Inventory/SpareInwardView.jsp");
					} 
					catch (Exception e) 
					{
						System.out.println(e.getMessage());
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
}


