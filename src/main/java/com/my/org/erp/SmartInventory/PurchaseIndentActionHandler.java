package com.my.org.erp.SmartInventory;
import java.io.IOException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;
public class PurchaseIndentActionHandler extends AbstractActionHandler
{
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{		
		try
		{
				String action=""+request.getParameter("actionS").trim();
				HttpSession session=request.getSession();			
				 
				String user = session.getAttribute("USRID").toString();
				 
				Statement st = con.createStatement();
				String sql="";
				if("INVPurchaseIndentAdd".equals(action))
				{
					
					
					
					String dept = request.getParameter("dept");
					String pono ="";
					
					String IndentDate = request.getParameter("IndentDate");
					IndentDate= com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(IndentDate);
					String ExpectedDate = request.getParameter("ExpectedDate");
					ExpectedDate= com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(ExpectedDate);
					String cdetails = request.getParameter("cdetails");
					String cnumber = request.getParameter("cnumber");
					String memo = request.getParameter("memo");
					String nettotal = request.getParameter("nettotal");
					 
				 
					
					String param[] = request.getParameter("param").split(",");
					String id="";
					for(int u=0;u<param.length;u++)
						id=id+request.getParameter("Product"+param[u])+",";
					
					String qty="";
					for(int u=0;u<param.length;u++)
						qty=qty+request.getParameter("Quantity"+param[u])+",";
					
					String expamount="";
					for(int u=0;u<param.length;u++)
						expamount=expamount+request.getParameter("Amount"+param[u])+",";
					
					String amount="";
					for(int u=0;u<param.length;u++)
						amount=amount+request.getParameter("Totalamount"+param[u])+",";
					
					
					
					
					pono= CommonFunctions.purchaseIndentNumber()+"/PO/"+CommonFunctions.AccountYear();
					//inv_t_purchaseindent
					//CHR_PURCHASENO,DAT_INDENTDATE,DAT_EXPECTDATE,INT_DEPARTID,
					//CHR_CONTACTDETAILS,CHR_CONTACTNO,CHR_DES,DOU_TOTALAMOUNT,
					
					
					sql = " INSERT INTO inv_t_purchaseindent  ( CHR_PURCHASENO,CHR_INDENTRAISEFROM,DAT_INDENTDATE,DAT_EXPECTDATE,INT_DEPARTID,CHR_CONTACTDETAILS,CHR_CONTACTNO,CHR_DES,DOU_TOTALAMOUNT,";
					sql=sql+"CHR_USRNAME,DT_UPDATEDATE ,CHR_UPDATESTATUS )";
					sql = sql +"VALUES (";
					sql = sql+"'"+pono+"' ,";
					sql = sql+"'"+session.getAttribute("EMPID")+"' ,";
					sql = sql+"'"+IndentDate+"' ,";
					sql = sql+"'"+ExpectedDate+"' ,";
					sql = sql+""+dept+" ,";
					sql = sql+" '"+cdetails+"' , ";
					sql = sql+"'"+cnumber+"' ,";
					sql = sql+"'"+memo+"' ,";
					sql = sql+""+nettotal+" ,";
					sql = sql+"'"+user+"',now(),'Y' )";
					st.execute(sql);
					sql=" INSERT INTO inv_t_purchaseindentnumber VALUES ("+CommonFunctions.purchaseIndentNumber()+")";
					st.execute(sql);
					
					
					
					//inv_t_purchaseindentdetail
					//CHR_PURCHASENO,INT_PRODUCTID,CHR_DESC,	INT_QUANTITY
					//DOU_UNITPRICE,DOU_TOTAL
					for(int u=0;u<param.length;u++)
					{
						sql = "INSERT INTO inv_t_purchaseindentdetail (CHR_PURCHASENO,INT_PRODUCTID,CHR_DESC,INT_QUANTITY,DOU_UNITPRICE,DOU_TOTAL,CHR_USRNAME,DT_UPDATEDATE ,CHR_UPDATESTATUS) ";
						sql = sql +"VALUES (";
						sql = sql+"'"+pono+"' ,";
						sql = sql+" "+request.getParameter("Product"+param[u])+" ,";
						sql = sql+"'"+request.getParameter("Productdescription"+param[u])+"' ,";
						sql = sql+""+request.getParameter("Quantity"+param[u])+" ,";
						sql = sql+" "+request.getParameter("Amount"+param[u])+" , ";
						sql = sql+"'"+request.getParameter("Totalamount"+param[u])+"' ,";
						sql = sql+"'"+user+"',now(),'Y' )";
						st.execute(sql);
					}	
					con.close();    
					response.sendRedirect("Smart Inventory/IndentRaise.jsp" );
					
				}
				else if("INVServiceBillingEdit".equals(action))
				{
					String SaleNo = request.getParameter("SaleNo");
					String saleDate = request.getParameter("saleDate");
					saleDate= com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(saleDate);
					String customer = request.getParameter("customer");
					String ref = request.getParameter("ref");
					String memo = request.getParameter("memo");
					String totals = request.getParameter("totals");
					String Shipping = request.getParameter("Shipping");
					String shippingaddress = request.getParameter("shippingaddress");
					String oref = request.getParameter("oref");
					String dnote = request.getParameter("dnote");
					String dthru = request.getParameter("dthru");
					String destination = request.getParameter("destination");
					String tdelivery = request.getParameter("tdelivery");
					String cdetails = request.getParameter("cdetails");
					String cnumber = request.getParameter("cnumber");
					String param[] = request.getParameter("param").split(",");
					String taxid="";
					for(int u=0;u<param.length;u++)
						taxid=taxid+request.getParameter("Tax"+param[u])+",";
					String taxvalue="";
					for(int u=0;u<param.length;u++)
						taxvalue=taxvalue+request.getParameter("Taxvalue"+param[u])+",";
					String taxamount="";
					for(int u=0;u<param.length;u++)
						taxamount=taxamount+request.getParameter("Taxamount"+param[u])+",";
					String nettotal = request.getParameter("nettotal");
					sql = "UPDATE inv_t_servicebilling SET ";
					sql = sql +" DAT_SALESDATE = '"+saleDate+"' ,";
					sql = sql +" INT_CUSTOMERID = "+customer+",";
					sql = sql +" CHR_REF = '"+ref+"',";
					sql = sql +" CHR_DES = '"+memo+"',";
					sql = sql +" DOU_AMOUNT = "+totals+" ,";
					sql = sql +" CHR_SHIPPING ='"+Shipping+"',";
					sql = sql +" CHR_SHIPPINGADDRESS='"+shippingaddress+"',";
					sql = sql +" CHR_OTHERREF='"+oref+"',";
					sql = sql +" CHR_DELIVERYNOTE='"+dnote+"',";
					sql = sql +" CHR_DESPATCHTHRU='"+dthru+"',";
					sql = sql +" CHR_DESTINATION='"+destination+"',";
					sql = sql +" CHR_TERMSOFDELIVERY='"+tdelivery+"',";
					sql = sql +" CHR_CONTACTDETAILS='"+cdetails+"',";
					sql = sql +" CHR_CONTACTNO='"+cnumber+"',";
					sql = sql +" CHR_TAXID='"+taxid+"',";
					sql = sql +" CHR_TAXVALUE='"+taxvalue+"',";
					sql = sql +" CHR_TAXAMOUNT='"+taxamount+"',";
					sql = sql +" DOU_NETAMOUNT="+nettotal+"";
					sql = sql +" WHERE CHR_SALESNO='"+SaleNo+"' ";
					st.execute(sql);
					con.close();    
					response.sendRedirect("Smart Inventory/IndentRaise.jsp");
				}	
				else if("INVPurchaseIndentDelete".equals(action))
				{
					
					String indentid = request.getParameter("indentid");
					sql = " DELETE FROM inv_t_purchaseindent WHERE CHR_PURCHASENO='"+indentid+"' ";
					st.execute(sql);
					sql ="DELETE FROM inv_t_purchaseindentdetail WHERE  CHR_PURCHASENO='"+indentid+"' ";
					st.execute(sql);
					con.close();   
					 
					response.sendRedirect("Smart Inventory/IndentRaise.jsp");
				}
				else if("INVPurchaseIndentAdminDelete".equals(action))
				{
					
					String indentid = request.getParameter("indentid");
					String reason = request.getParameter("reason");
					
					sql = " DELETE FROM inv_t_purchaseindent WHERE CHR_PURCHASENO='"+indentid+"' ";
					st.execute(sql);
					sql ="DELETE FROM inv_t_purchaseindentdetail WHERE  CHR_PURCHASENO='"+indentid+"' ";
					st.execute(sql);
					//CHR_PURCHASEORDERNO,CHR_DES,DAT_DELETEDATE,CHR_USRNAME,DT_UPDATEDATE ,CHR_UPDATESTATUS) ";
					sql = "INSERT INTO inv_t_purchaseindentdelete (CHR_PURCHASEORDERNO,CHR_DES,DAT_DELETEDATE,CHR_USRNAME,DT_UPDATEDATE ,CHR_UPDATESTATUS) ";
					sql = sql +"VALUES (";
					sql = sql+"'"+indentid+"' ,";
					sql = sql+"'"+reason+"' ,";
					sql = sql+"now() ,";
					sql = sql+"'"+user+"',now(),'Y' )";
					st.execute(sql);
					con.close();    
					response.sendRedirect("Smart Inventory/IndentRaise.jsp");
				}
				else if (action.equals("INVPurchaseIndentAccept")) 
				{
					
					String length  = request.getParameter("dec");
					String accept="";
					String reject="";
					String rejectdec="";
					String hiddenField="";
					sql="";
					for(int u=0;u<Integer.parseInt(length);u++)
					{
						sql="";
						accept = request.getParameter("accept"+u);
						reject = request.getParameter("reject"+u);
						rejectdec = request.getParameter("dec"+u);
						hiddenField=request.getParameter("hiddenField"+u);
						if("on".equals(accept))
							sql =" UPDATE inv_t_purchaseindent  SET   CHR_STATUS ='Y',CHR_ACCEPT ='Y' "+" WHERE INT_PURCHASEINDENTID="+hiddenField;
						if("on".equals(reject))
							sql =" UPDATE inv_t_purchaseindent  SET   CHR_STATUS ='R' , CHR_ACCEPT ='R' ,CHR_ACCDESC ='"+rejectdec+"'"+" WHERE INT_PURCHASEINDENTID="+hiddenField;;
						sql = sql.trim();
						if(sql.length()>10)
						{
							st.execute(sql);
							
						}
					}
					st.close();
					con.close();    
					response.sendRedirect("Smart Inventory/IndentRaise.jsp");	
				}
				
				else if (action.equals("INVPurchaseIndentCloseUpdate")) 
				{
					String ponumber=request.getParameter("ponumber");
					String podate=request.getParameter("podate");
					String memo=request.getParameter("memo");
					String indentid=request.getParameter("indentid");
					String Vendor=request.getParameter("Vendor");
					
					sql =" UPDATE inv_t_purchaseindent  SET  ";
					sql = sql +" CHR_ACCSTATUS ='Y' , ";
					sql = sql +" DAT_ACCDATE =now() , ";
					sql = sql +" INT_VENDORID ='"+Vendor+"' , ";
					sql = sql +" CHR_PURCHASEORDERNO ='"+ponumber+"' , ";
					sql = sql +" DAT_PODATE ='"+DateUtil.FormateDateSQL(podate)+"' , ";
					sql = sql +" CHR_PODESC ='"+memo+"'  ";
					sql = sql +" WHERE CHR_PURCHASENO='"+indentid+"'";
					st.execute(sql);
					st.close();
					con.close();    
					response.sendRedirect("Smart Inventory/IndentClose.jsp");	
				}
				else if (action.equals("INVPurchaseIndentCloseRestore")) 
				{
					String indentid=request.getParameter("indentid");
					sql =" UPDATE inv_t_purchaseindent  SET  ";
					sql = sql +" CHR_ACCSTATUS ='N' , ";
					sql = sql +" CHR_PURCHASEORDERNO ='' , ";
					sql = sql +" CHR_PODESC =''  ";
					sql = sql +" WHERE CHR_PURCHASENO='"+indentid+"'";
					 
					st.execute(sql);
					sql = "DELETE FROM inv_t_purchaseindentpayment WHERE CHR_PURCHASENO='"+indentid+"'";
					st.execute(sql);
					 
					st.close();
					con.close();    
					response.sendRedirect("Smart Inventory/IndentClose.jsp");	
				}
				else if (action.equals("INVPurchaseIndentCloseDelete")) 
				{
					String indentid=request.getParameter("indentid");
					
					sql =" DELETE FROM  inv_t_purchaseindent  WHERE CHR_PURCHASENO='"+indentid+"'";
					st.execute(sql);
					sql =" DELETE FROM  inv_t_purchaseindentdetail  WHERE CHR_PURCHASENO='"+indentid+"'";
					st.execute(sql);
					sql = "DELETE FROM inv_t_purchaseindentpayment WHERE CHR_PURCHASENO='"+indentid+"'";
					st.execute(sql);
					st.close();
					con.close();    
					response.sendRedirect("Smart Inventory/IndentClose.jsp");	
				}
				else if("INVPurchaseIndentPaymentAdd".equals(action))
				{
					//INVPurchasePaymentAdd
					String purchaseid = request.getParameter("purchaseid");
					String paymentmode = request.getParameter("paymentmode");
					String pays[] =paymentmode.split(",");
					paymentmode = pays[0];
					String chequedate = request.getParameter("chequedate");
					String paymentdt = request.getParameter("paymentdt");
					String paymentdesc = request.getParameter("paymentdesc");
					String amount = request.getParameter("amount");
					String previousamt =request.getParameter("paid");
					String paid = request.getParameter("given");
					 
					String bank = request.getParameter("Bank");
					String Challanno= request.getParameter("Challanno");
					int bal=(int)(Double.parseDouble(amount)-(Double.parseDouble(paid)+Double.parseDouble(previousamt)));
					sql = "INSERT INTO  inv_t_purchaseindentpayment  ( ";
					sql = sql +" CHR_PURCHASENO,";
					sql = sql +" INT_PAYMENTTERMID,	INT_BANKID,CHR_DDNUMBER,DAT_DDDATE,DAT_PAYMENTDATE,";
					sql = sql +" CHR_PAYMENTDESC,DOU_PURCHASEAMOUNT,";
					sql = sql +" DOU_PAIDAMOUNT,DOU_BALANCEAMOUNT,";
					sql = sql +" CHR_USRNAME,DT_UPDATEDATE,	CHR_UPDATESTATUS )";
					sql = sql +" VALUES (";
					sql = sql +"'"+purchaseid+"' , ";
					sql = sql +" "+paymentmode+" , ";
					sql = sql +" "+bank+" , ";
					sql = sql +" '"+Challanno+"'  , ";
					sql = sql +"'"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(chequedate)+"' , ";
					sql = sql +"'"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(paymentdt)+"' , ";
					sql = sql +"'"+paymentdesc+"' , ";
					sql = sql +Double.parseDouble(amount)+" , ";
					sql = sql +Double.parseDouble(paid)+" , ";
					sql = sql +bal+" , ";
					sql = sql +"'"+user+"' , NOW(),'Y' )";	
					st.execute(sql);	
					
					String tableName="";				
					sql = "SELECT DOU_PAIDAMOUNT FROM  inv_t_purchaseindent  WHERE CHR_PURCHASENO='"+purchaseid+"'";
					tableName=" inv_t_purchaseindent ";
					
					
					String paidamount = com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "DOU_PAIDAMOUNT");
					double pamt = 0;				
					 pamt=(Double.parseDouble(paidamount)+Double.parseDouble(paid));					
					sql = "UPDATE "+tableName+" SET ";
					sql = sql + " DOU_PAIDAMOUNT = " +pamt +" , ";
					if(pamt ==Double.parseDouble(amount))
						sql = sql + " CHR_PAYMENTSTATUS = 'Y' ";
					else 
						sql = sql + " CHR_PAYMENTSTATUS ='P' ";
					
					sql = sql + " WHERE CHR_PURCHASENO='"+purchaseid+"'";
					
					st.execute(sql);
					st.close();
					con.close();    
					response.sendRedirect("Smart Inventory/IndentPayment.jsp");
				}
				else if ("INVPurchaseIndentPaymentDelete".equals(action)) 
				{
					String pid =request.getParameter("pid");
					 
					sql= "UPDATE inv_t_purchaseindent SET DOU_PAIDAMOUNT=0.0 ,CHR_PAYMENTSTATUS='N'  WHERE CHR_PURCHASENO='"+pid+"'";
					st.execute(sql);
					sql = "DELETE FROM inv_t_purchaseindentpayment WHERE CHR_PURCHASENO='"+pid+"'";
					st.execute(sql);
						
					st.close();
					con.close();    
					response.sendRedirect("Smart Inventory/IndentPayment.jsp");
				}
				else if ("INVPurchaseIndentPaymentChanges".equals(action)) 
				{
					 
					String pid =request.getParameter("pid");
					String rowid=request.getParameter("rowid");
					 
					double purchaseamount=Double.parseDouble(request.getParameter("purchaseamount"));
					double balance=Double.parseDouble(request.getParameter("balance"));
					double paid=Double.parseDouble(request.getParameter("paid"));
					double totPaid=Double.parseDouble(request.getParameter("totalPaid"));
					sql ="UPDATE  inv_t_purchaseindentpayment  SET ";
					sql = sql +" DOU_PURCHASEAMOUNT = "+purchaseamount;
					sql = sql +" , DOU_PAIDAMOUNT = "+paid;
					sql = sql +" , DOU_BALANCEAMOUNT = "+balance;
					sql = sql + " WHERE CHR_PURCHASENO='"+pid+"'";
					sql = sql +" AND INT_PAYMENTID = "+Integer.parseInt(rowid);
					st.execute(sql);
					
					
					sql = "UPDATE inv_t_purchaseindent SET ";
					sql = sql + " DOU_PAIDAMOUNT = " +totPaid +" , ";
					if(totPaid ==purchaseamount)
						sql = sql + " CHR_PAYMENTSTATUS = 'Y' ";
					else
						sql = sql + " CHR_PAYMENTSTATUS ='P' ";					
					sql = sql + " WHERE CHR_PURCHASENO='"+pid+"'";
					st.execute(sql);
					st.close();
					con.close();    
					response.sendRedirect("Smart Inventory/IndentPayment.jsp");
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


