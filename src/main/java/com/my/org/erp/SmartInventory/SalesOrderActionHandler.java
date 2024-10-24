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

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.bean.inventory.QuotationSaleOrder;
import com.my.org.erp.common.CommonFunctions;

public class SalesOrderActionHandler extends AbstractActionHandler
{
	static String delivId=null;
	 
	public static void  itemInsert(HttpServletRequest request,HttpServletResponse response, String salesOrderNo ,String quoNumber, Connection con, PreparedStatement   apstm )throws ServletException, IOException 
	{
		try 
		{			
			String field="";
			String sql="";			
			HttpSession session=request.getSession();			
			String userId=""+session.getAttribute("USRID");
			String branchid = session.getAttribute("BRANCHID").toString();
			String param = request.getParameter("params");
			String itype="";
			for(int p=1;p<=Integer.parseInt(param); p++)
			{
				sql = "INSERT INTO  inv_t_customersalesorderitem   ( ";
				sql = sql +"INT_BRANCHID,CHR_SALESORDERNO,CHR_ITEMID,CHR_TYPE,CHR_DESC,";
				sql = sql +" INT_QUANTITY,INT_WARRANTY, DOU_UNITPRICE,DOU_DISCOUNT,DOU_UNITDISCOUNT, ";
				sql = sql +" INT_TAXID,DOU_TAX_PERCENTAGE,DOU_TAX_AMOUNT,DOU_TOTAL,";
				sql = sql +" CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS ";
				sql = sql +" )";
				sql = sql +" VALUES ";
				sql = sql +"( ";
				sql = sql +"?,?,?,?,?,";
				sql = sql +" ?,?, ?,?,?, ";
				sql = sql +" ?,?,?,?,";
				sql = sql +" ?,DATE(NOW()),'Y' ";
				sql = sql +") ";
				apstm = con.prepareStatement(sql);
				apstm.setString(1,branchid);
				apstm.setString(2,salesOrderNo);
				apstm.setString(3,request.getParameter("item"+p));
				apstm.setString(4,request.getParameter("itype"+p));
				apstm.setString(5,request.getParameter("desc"+p));
				apstm.setString(6,request.getParameter("qty"+p));
				apstm.setString(7,request.getParameter("warranty"+p));
				apstm.setString(8,request.getParameter("uprice"+p) );
				apstm.setString(9,request.getParameter("discount"+p));
				apstm.setString(10,request.getParameter("unitdiscount"+p));
				apstm.setString(11,request.getParameter("tax"+p));
				apstm.setString(12,request.getParameter("taxpercentage"+p));
				apstm.setString(13,request.getParameter("taxamount"+p));
				apstm.setString(14,request.getParameter("total"+p));
				apstm.setString(15,userId);
				System.out.println(""+apstm);
				apstm.execute();
				
				String pptype =request.getParameter("pptype"+p);
				if(!"S".equals(pptype))
				{
					sql = " INSERT INTO  inv_t_customersalesorderitemserial  ("; 
					sql = sql+"INT_BRANCHID,CHR_SALESORDERNO, ";
					sql = sql+"CHR_ITEMID,CHR_TYPE,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS ";
					sql = sql+" ) VALUE (";
					sql = sql+"?,?, ";
					sql = sql+"?,?,?,DATE(NOW()),'Y' ";
					sql = sql+" )";
					apstm = con.prepareStatement(sql);
					
					for(int v=0; v<Integer.parseInt(request.getParameter("qty"+p));v++)
					{
						apstm.setString(1,branchid);
						apstm.setString(2,salesOrderNo);
						apstm.setString(3,request.getParameter("item"+p));
						apstm.setString(4,request.getParameter("itype"+p));
						apstm.setString(5,userId);
						System.out.println(""+apstm);
						apstm.addBatch(); 
					}
					apstm.executeBatch();
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
				String branchid = session.getAttribute("INVBRANCH").toString();
				Statement st = con.createStatement();
				String sql="";
				String itm="";
				String desc="";
				String qty="";  
				String uprice="";
				String discount="";
				String unitdiscount="";
				String total="";
				 
				if("INVSalesOrderAdd".equals(action))
				{
					QuotationSaleOrder d = new  QuotationSaleOrder();
					Map map=request.getParameterMap();
					BeanUtils.populate(d,map);
					String quoNumber =d.getQuotationid(); 
					String officeid=""+session.getAttribute("OFFICEID");
					String divisionid =d.getDivision();
					String salesordernumbero=InventoryInvoiceFunctions.customerSaleorderNumberGet(""+session.getAttribute("INVSTATE"),  officeid,   divisionid );
					//delete inv_t_customersalesorderitemserial 
					//delete inv_t_customersalesorderitem
					//delete inv_t_customersalesorder
					asql = " SELECT CHR_SALESORDERNO FROM inv_t_customersalesorder WHERE CHR_QUOTATIONNO ='"+quoNumber+"'";
					String data[][] =CommonFunctions.QueryExecute(asql);
					if(data.length>0)
					{
						asql = "DELETE FROM inv_t_customersalesorderitemserial WHERE CHR_SALESORDERNO =?";
						apstm = con.prepareStatement(asql);
						apstm.setString(1,data[0][0]);
						apstm.execute();
						
						asql = "DELETE FROM inv_t_customersalesorderitem WHERE CHR_SALESORDERNO =?";
						apstm = con.prepareStatement(asql);
						apstm.setString(1,data[0][0]);
						apstm.execute();
						
						asql = "DELETE FROM inv_t_customersalesorder WHERE CHR_QUOTATIONNO =?";
						apstm = con.prepareStatement(asql);
						apstm.setString(1,quoNumber);
						apstm.execute();
					}
					boolean f = CustomerQuotationMethod.addQuotationSalesOrder(con,apstm ,d ,salesordernumbero,request, response);
					
					if(f)
					{
						itemInsert(request,response,salesordernumbero,quoNumber,con,apstm);
						asql="update  inv_t_customerquotation  set INT_PROGRESSBAR=100,CHR_STATUS='Y' where CHR_QUOTATIONNO=?";
						apstm = con.prepareStatement(asql);
						apstm.setString(1,quoNumber );
						System.out.println(""+apstm );
						apstm.execute();
						apstm.close();
						
						//Mailgenerate
						SaleOrderMail.sendCPOAttachedMail(branchid,salesordernumbero, divisionid, Path); 
					}
					
					con.close();    
					response.sendRedirect("Smart Inventory/SalesOrder.jsp");
				}
				else if("INVSalesOrderUpdate".equals(action))
				{
					sql="";
					String collectname="";
					collectname= collectname+"quoNumber,salesOrderNo,customerId," +
					"reqDate,payment,hold,billingTo,ship,shipingTo,memo,ref,totals,totaldiscount,tax,salestax,nettotal,";					
					String quoNumber =""+request.getParameter("quotationId");
					String custponumber=""+request.getParameter("custponumber");
					String salesOrderNo =""+request.getParameter("salesOrderNo");
					String saleBy =""+request.getParameter("saleBy");
					String salDate =""+request.getParameter("salDate");
					salDate=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(salDate);
					String hold =""+request.getParameter("hold");
					String billingTo =""+request.getParameter("billingTo");
					String shipingTo =""+request.getParameter("shipingTo");					
					String memo =""+request.getParameter("memo");
					String ref =""+request.getParameter("ref");
					String tot =""+request.getParameter("totals");
					String totaldiscount =""+request.getParameter("totaldiscount");
					String tax =""+request.getParameter("tax");
					String salestaxamount =""+request.getParameter("salestaxamount");
					String nettotal =""+request.getParameter("nettotal");
					sql = "UPdate inv_t_customersalesorder SET ";									
					sql = sql +" CHR_CUSTPURCHASENO='"+custponumber+"', ";
					sql = sql +" CHR_SALESORDERNO='"+salesOrderNo+"', ";
					sql = sql +" CHR_SALEBY='"+saleBy+"' , ";
					sql = sql +" DAT_SALEDATE='"+salDate+"' , ";					
					sql = sql +" CHR_BILLINGADDRESS='"+billingTo+"' , ";
					sql = sql +" CHR_SHIPINGADDRESS='"+shipingTo+"' , ";
					if(hold.trim().equals("true"))
						sql = sql +" INT_ONHOLD=1 , ";
					else
						sql = sql +" INT_ONHOLD=0 , ";
					sql = sql +" CHR_DES='"+memo+"' , ";
					sql = sql +" CHR_REF='"+ref+"' , ";
					sql = sql +" INT_TAXID="+tax+" , ";
					sql = sql +" DOU_AMOUNT="+ tot+" , ";
					sql = sql +" DOU_DISCOUNT="+Double.parseDouble(totaldiscount)+" , ";
					sql = sql +" DOU_TAXAMOUNT="+salestaxamount+" , ";
					sql = sql +" DOU_TOTALAMOUNT="+Double.parseDouble(nettotal)+" , ";
					sql = sql +" CHR_USRNAME='"+userId+"'";				
					sql = sql +" WHERE CHR_QUOTATIONNO='"+quoNumber+"'";
					st.execute(sql);
					sql = "delete from inv_t_customersalesorderitem WHERE ";
					sql = sql + " CHR_SALESORDERNO='"+salesOrderNo+"'";					
					st.execute(sql);
					sql = "delete from inv_t_customersalesorderitemserial WHERE ";
					sql = sql + " CHR_SALESORDERNO='"+salesOrderNo+"'";					
					st.execute(sql);
					 
					itemInsert(request,response,salesOrderNo,quoNumber,con,apstm);
					con.close();   
					response.sendRedirect("Smart Inventory/SalesOrder.jsp");
				}
				else if("INVDelivarySerialAdd".equals(action))
				{
					String purchaseno = ""+request.getParameter("salesId");
				//	String recdid =""+request.getParameter("deliveredId");
					String rlength = ""+request.getParameter("length");
					String recddate = ""+request.getParameter("deliveredDate");
					String recdby = ""+request.getParameter("receivedby");
					for(int u=1;u<=Integer.parseInt(rlength);u++)
					{
						String itemid =""+request.getParameter("item"+u);
						String rowid =""+request.getParameter("row"+u);
						String serial =""+request.getParameter("serail"+u);
						String waranty =""+request.getParameter("warranty"+u);
						sql = "UPDATE  inv_t_salesitem SET" ;						
						sql = sql +" DAT_SALESDATE = '"+recddate+"' ,";
						sql = sql +" CHR_RECIVEDBY = '"+recdby+"' ,";
						sql = sql +" CHR_SERIALNO = '"+serial+"' ,";
						sql = sql +" CHR_WARRANTY = '"+waranty+"' ";
						sql = sql +"WHERE INT_SALESORDERID ="+purchaseno+"";
						sql = sql +" AND CHR_ITEMID = '"+itemid+"'";
						sql = sql +" AND INT_ID = '"+rowid+"'";
						st.execute(sql);
					}
					con.close();   
					response.sendRedirect("Smart Inventory/Delivary Challan.jsp");
				}
				else if("INVQuotationEdit".equals(action))
				{
					sql="";
					String collectname="";
					collectname= collectname+"quoNumber,customerId,quoDate,payment,hold,order,ship,reqDate,memo,ref,totals,totaldiscount,tax,salestax,nettotal,";					
					String quoNumber =""+request.getParameter("quotationId");
					String quoDate =""+request.getParameter("quoDate");
					quoDate=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(quoDate);
					String reqDate =""+request.getParameter("reqDate");
					reqDate=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(reqDate);
					String paymentterm =""+request.getParameter("payment");
					String hold =""+request.getParameter("hold");
					//String orderid =""+request.getParameter("order");
					//String shipid =""+request.getParameter("ship");
					//String duedt =""+request.getParameter("reqDate"); // To Remove
					String memo =""+request.getParameter("memo");
					String ref =""+request.getParameter("ref");
					String tot =""+request.getParameter("totals");
					String totaldiscount =""+request.getParameter("totaldiscount");
					String tax =""+request.getParameter("tax");
					//String salestax =""+request.getParameter("salestax"); 
					String salestaxamount =""+request.getParameter("salestaxamount");
					String nettotal =""+request.getParameter("nettotal");
					
					String field="( INT_BRANCHID,CHR_QUOTATIONNO,INT_CUSTOMERID,DAT_QUOTATIONDATE , " +
					" DAT_REQUESTDATE,INT_ONHOLD, " +
					" INT_CONDITIONID,CHR_DES,CHR_REF , " +
					" INT_TAXID,DOU_AMOUNT,DOU_DISCOUNT,DOU_TAXAMOUNT , " +
					" DOU_TOTALAMOUNT,INT_QUOTATIONSTATUS, " +
					" CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS )";
					sql = " UPDATE   inv_t_customerquotation  SET ";					
					sql = sql +" DAT_QUOTATIONDATE='"+quoDate+"'";
					sql = sql +",DAT_REQUESTDATE='"+reqDate+"'";
					
					if(hold.trim().equals("true"))
						sql = sql +",INT_ONHOLD=1";
					else
						sql = sql +",INT_ONHOLD=0";
					
					sql = sql +",INT_PAYMENTTERMID="+paymentterm;
					sql = sql +",CHR_DES='"+memo+"' ";
					sql = sql +",CHR_REF='"+ref+"' ";
					sql = sql +",INT_TAXID="+tax;
					sql = sql +",DOU_AMOUNT="+tot;
					sql = sql +",DOU_DISCOUNT="+totaldiscount;
					sql = sql +",DOU_TAXAMOUNT="+salestaxamount;
					sql = sql +",DOU_TOTALAMOUNT="+nettotal;
					sql = sql +",CHR_USRNAME='"+userId+"'";
					sql=sql+" WHERE INT_QUOTATIONID="+quoNumber;
					st.execute(sql);
					
					String dynamic[] = com.my.org.erp.common.CommonInfo.callDynamicName(request,response).split(",");
					for(int u=0; u<dynamic.length;u++)
					{
						if(dynamic[u].startsWith("item"))
							itm=itm+dynamic[u]+",";
						if(dynamic[u].startsWith("desc"))
							desc=desc+dynamic[u]+",";
						if(dynamic[u].startsWith("qty"))
							qty=qty+dynamic[u]+",";
						if(dynamic[u].startsWith("uprice"))
							uprice=uprice+dynamic[u]+",";
						if(dynamic[u].startsWith("discount"))
							discount=discount+dynamic[u]+",";
						if(dynamic[u].startsWith("unitdiscount"))
							unitdiscount=unitdiscount+dynamic[u]+",";
						if(dynamic[u].startsWith("total"))
							total=total+dynamic[u]+",";
					}
					
					String descs[]=desc.split(",");
					String itms[]=itm.split(",");
					String qtys[]=qty.split(",");
					String uprices[]=uprice.split(",");
					String discounts[]=discount.split(",");
					String unitdiscounts[]=unitdiscount.split(",");
					String totals[]=total.split(",");
					sql="delete from  inv_t_customerquotationitem  where INT_QUOTATIONID="+quoNumber;
					st.execute(sql);
					
					field ="INT_BRANCHID,INT_QUOTATIONID,CHR_ITEMID,CHR_DESC,INT_QUANTITY," +
					"DOU_UNITPRICE,DOU_DISCOUNT,DOU_UNITDISCOUNT,DOU_TOTAL," +
					"CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS";
					
					for(int i=0;i<itms.length;i++)
					{	
						sql=" INSERT INTO  inv_t_customerquotationitem  (" +field+" ) VALUES (";
						sql = sql +Integer.parseInt(branchid)+" , ";
						sql = sql +quoNumber+" , ";
						sql = sql +"'"+request.getParameter(itms[i].trim())+"' , ";
						sql = sql +"'"+request.getParameter(descs[i].trim())+"' , ";
						sql = sql +Integer.parseInt(request.getParameter(qtys[i].trim()))+" , ";
						sql = sql +Double.parseDouble(request.getParameter(uprices[i].trim()))+" , ";
						sql = sql +"'"+request.getParameter(discounts[i].trim())+"' , ";
						sql = sql +Double.parseDouble(request.getParameter(unitdiscounts[i].trim()))+" , ";
						sql = sql +Double.parseDouble(request.getParameter(totals[i].trim()))+" , ";
						sql = sql +"'"+userId+"' , ";
						sql = sql +" now() , 'Y' ) ";
						st.execute(sql);
					}
					con.close();    
					response.sendRedirect("Smart Inventory/Quotation.jsp?quoId="+quoNumber);
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