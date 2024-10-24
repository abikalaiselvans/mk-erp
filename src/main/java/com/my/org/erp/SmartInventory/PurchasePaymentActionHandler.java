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

public class PurchasePaymentActionHandler extends AbstractActionHandler {
	
	
	public void handle(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException 
	{
		try 
		{
			HttpSession session=request.getSession();			
			String branchId=session.getAttribute("INVBRANCH").toString();			
			String action = request.getParameter("actionS");
			String sql="";
			
			if ("INVPurchasePaymentAdd".equals(action)) 
			{
				String payment=request.getParameter("payment"); 
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
				String transactiontype = request.getParameter("transactiontype");
				String bank = request.getParameter("Bank");
				System.out.println("bank  "+bank);
				String Challanno= request.getParameter("Challanno");
				//String transactiontype= request.getParameter("transactiontype");
				int bal=(int)(Double.parseDouble(amount)-(Double.parseDouble(paid)+Double.parseDouble(previousamt)));
				
				
				asql = "INSERT INTO  inv_t_vendorpurchasepayment  ( ";
				asql = asql +" INT_BRANCHID ,CHR_PURCHASEORDERNO,CHR_INVOICEFOR,";
				asql = asql +" INT_PAYMENTTERMID,	INT_BANKID,CHR_DDNUMBER,DAT_DDDATE,DAT_PAYMENTDATE,";
				asql = asql +" CHR_PAYMENTDESC,DOU_PURCHASEAMOUNT,";
				asql = asql +" DOU_PAIDAMOUNT,DOU_BALANCEAMOUNT,";
				asql = asql +" CHR_USRNAME,DT_UPDATEDATE,	CHR_UPDATESTATUS,INT_TRANSACTIONTYPE )";
				asql = asql +" VALUES (";
				asql = asql +" ?,?,?,";
				asql = asql +" ?,?,?,?,?,";
				asql = asql +" ?,?,";
				asql = asql +" ?,?,";
				asql = asql +" ?,DATE(NOW()),'Y',?)";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,branchId );
				apstm.setString(2,purchaseid );
				if("Purchase".equals(payment))
					apstm.setString(3,"P");
				else
					apstm.setString(3,"D" );
				apstm.setString(4,paymentmode);
				apstm.setString(5,bank );
				apstm.setString(6,Challanno );
				apstm.setString(7,DateUtil.FormateDateSQL(chequedate));
				apstm.setString(8,DateUtil.FormateDateSQL(paymentdt) );
				apstm.setString(9,paymentdesc );
				apstm.setString(10,amount);
				apstm.setString(11,paid);
				apstm.setString(12,""+bal );
				apstm.setString(13,auserid);
				apstm.setString(14,transactiontype);
				System.out.println(""+apstm);
				apstm.execute();
				apstm.close();
			 
				String tableName="";				
				if("Purchase".equals(payment))
				{
					sql = "SELECT DOU_PAIDAMOUNT FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO='"+purchaseid+"'";
					tableName=" inv_t_vendorpurchaseorder ";
				}
				else if("Direct".equals(payment))
				{
					sql = "SELECT DOU_PAIDAMOUNT FROM inv_t_directpurchase WHERE CHR_PURCHASEORDERNO='"+purchaseid+"'";
					tableName="inv_t_directpurchase";
				}
				
				String paidamount =  CommonFunctions.QueryExecute(sql)[0][0];
				double pamt = 0;				
				pamt=(Double.parseDouble(paidamount)+Double.parseDouble(paid));					
				
				 
				asql = "UPDATE "+tableName+" SET ";
				asql = asql + " DOU_PAIDAMOUNT = " +pamt +" , ";
				
				if( (pamt == Double.parseDouble(amount)) ||  (Double.parseDouble(amount)-pamt < 1) )
					asql = asql + " CHR_PAYMENTSTATUS = 'Y' ";
				else 
					asql = asql + " CHR_PAYMENTSTATUS ='P' ";
				
				asql = asql + " WHERE CHR_PURCHASEORDERNO='"+purchaseid+"'";
				apstm = con.prepareStatement(asql);
				System.out.println(""+apstm);
				apstm.execute();
				apstm.close();
			 	con.close();    
				response.sendRedirect("Smart Inventory/Payment.jsp");
				
			}
			else if ("INVPurchasePaymentChanges".equals(action)) 
				{
					
					 
					
					String payment=request.getParameter("payment"); 
					String pid =request.getParameter("pid");
					String rowid=request.getParameter("rowid");
				 	String purchaseamount=request.getParameter("purchaseamount");
					String balance=request.getParameter("balance");
					String paid=request.getParameter("paid");
					String totPaid=request.getParameter("totalPaid");
				
					asql ="UPDATE  inv_t_vendorpurchasepayment  SET ";
					asql = asql +" DOU_PURCHASEAMOUNT = ?, ";
					asql = asql +" DOU_PAIDAMOUNT = ?, ";
					asql = asql +" DOU_BALANCEAMOUNT = ? ";
					asql = asql + " WHERE CHR_PURCHASEORDERNO=  ?";
					asql = asql +" AND INT_PAYMENTID =  ? ";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,""+purchaseamount );
					apstm.setString(2,""+paid );
					apstm.setString(3,""+balance);
					apstm.setString(4,pid);
					apstm.setString(5, rowid);
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
					
					 
					
					String tableName="";
					if("Purchase".equals(payment))		
					{					
						tableName=" inv_t_vendorpurchaseorder ";
					}
					else if("Direct".equals(payment))		
					{					
						tableName="inv_t_directpurchase";
						asql = " SELECT DOU_TOTALAMOUNT,FUN_INV_GET_VENDORBALANCEAMOUNT_DIRECT(CHR_PURCHASEORDERNO) FROM inv_t_directpurchase WHERE  CHR_PURCHASEORDERNO='"+pid+"'";
						String updata[][] = CommonFunctions.QueryExecute(asql);
						if(updata.length>0)
						{	
							double paidamount = Double.parseDouble(updata [0][1]);
							double poamount = Double.parseDouble(updata [0][0]);
							double pobalance = poamount - paidamount;
							
							asql = "UPDATE inv_t_directpurchase SET ";
							asql = asql + " DOU_PAIDAMOUNT = " +totPaid +" , ";
							if(pobalance<1)
								asql = asql + " CHR_PAYMENTSTATUS = 'Y' ";
							else 
								asql = asql + " CHR_PAYMENTSTATUS ='P' ";
							asql = asql + " WHERE CHR_PURCHASEORDERNO='"+pid+"'";
							apstm = con.prepareStatement(asql);
							System.out.println(""+apstm);
							apstm.execute();
							apstm.close();	 
						}
					}
					
					
					/*asql = "UPDATE "+tableName+" SET ";
					asql = asql + " DOU_PAIDAMOUNT = " +totPaid +" , ";
					if(totPaid ==purchaseamount)
						asql = asql + " CHR_PAYMENTSTATUS = 'Y' ";
					else
						asql = asql + " CHR_PAYMENTSTATUS ='P' ";					
					asql = asql + " WHERE CHR_PURCHASEORDERNO='"+pid+"'";
					apstm = con.prepareStatement(asql);
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
					*/
					 
					con.close();    
					response.sendRedirect("Smart Inventory/Payment.jsp");
				}
			else if ("INVPurchasePaymentDelete".equals(action)) 
			{
				String payment=request.getParameter("payment"); 
				String pid =request.getParameter("pid");
				 
				
				if("Purchase".equals(payment))			
				{					
					 
					asql= "UPDATE inv_t_vendorpurchaseorder SET DOU_PAIDAMOUNT=0.0 ,CHR_PAYMENTSTATUS='N'  WHERE CHR_PURCHASEORDERNO='"+pid+"'";
					apstm = con.prepareStatement(asql);
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
					
					asql = "DELETE FROM inv_t_vendorpurchasepayment WHERE CHR_PURCHASEORDERNO='"+pid+"'";
					apstm = con.prepareStatement(asql);
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
				}
				else if("Direct".equals(payment))		
				{					
					asql= "UPDATE inv_t_directpurchase SET DOU_PAIDAMOUNT=0.0 ,CHR_PAYMENTSTATUS='N'  WHERE CHR_PURCHASEORDERNO='"+pid+"'";
					apstm = con.prepareStatement(asql);
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
					
					asql = "DELETE FROM inv_t_vendorpurchasepayment WHERE CHR_PURCHASEORDERNO='"+pid+"'";
					apstm = con.prepareStatement(asql);
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
					
				}
				 
				con.close();   
				response.sendRedirect("Smart Inventory/Payment.jsp");
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
