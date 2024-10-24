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

public class PurchasePaymentMultipleActionHandler extends AbstractActionHandler 
{
	
	
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			HttpSession session=request.getSession();			
			String branchId=session.getAttribute("INVBRANCH").toString();			
			String action = request.getParameter("actionS");
			if ("INVPurchasePaymentMultipleinvoice".equals(action)) 
			{
				String paymentMethod = request.getParameter("paymentMethod");
				String payment[] = paymentMethod.split(",");
				String Bank = request.getParameter("Bank");
				String Challanno = request.getParameter("Challanno");
				String chequeDate = request.getParameter("chequeDate");
				String paymentDate = request.getParameter("paymentDate");
				paymentDate = DateUtil.FormateDateSQL(paymentDate);
				chequeDate = DateUtil.FormateDateSQL(chequeDate);
				String remarks = request.getParameter("remarks");
				if ("Select".equals(Bank) || "".equals(Bank))
					Bank = "1";
				double paidamount=0;
				double poamount=0;
				double pobalance=0;
				String totalrecords = request.getParameter("totalrecords");
				String transactiontype= request.getParameter("transactiontype");
				int count  = Integer.parseInt(totalrecords);
				System.out.println(count);
				if(count >0)
				{
					for(int u=0;u<count;u++)
					{
						String ponumber = request.getParameter("salesnumber"+u);
						String salesAmount = request.getParameter("salesAmount"+u);
						String Balance = request.getParameter("Balance"+u);
						String Paid = request.getParameter("Paid"+u);
						String tickyes = request.getParameter("paidrow"+u);
						if("Y".equals(tickyes))
						{	
							double bal1 = Double.parseDouble(Balance)- Double.parseDouble(Paid);
							int bal = (int) bal1;
							 
							asql = "INSERT INTO  inv_t_vendorpurchasepayment  ( ";
							asql = asql +" INT_BRANCHID ,CHR_PURCHASEORDERNO,CHR_INVOICEFOR,";
							asql = asql +" INT_PAYMENTTERMID,	INT_BANKID,CHR_DDNUMBER,DAT_DDDATE,DAT_PAYMENTDATE,";
							asql = asql +" CHR_PAYMENTDESC,DOU_PURCHASEAMOUNT,";
							asql = asql +" DOU_PAIDAMOUNT,DOU_BALANCEAMOUNT,";
							asql = asql +" CHR_USRNAME,DT_UPDATEDATE,	CHR_UPDATESTATUS ,INT_TRANSACTIONTYPE)";
							asql = asql +" VALUES (";
							asql = asql +" ?,?,?,";
							asql = asql +" ?,?,?,?,?,";
							asql = asql +" ?,?,";
							asql = asql +" ?,?,";
							asql = asql +" ?,DATE(NOW()),'Y',? )";
							apstm = con.prepareStatement(asql);
							apstm.setString(1,branchId );
							apstm.setString(2,ponumber );
							apstm.setString(3,"D" );
							apstm.setString(4,payment[0] );
							apstm.setString(5,Bank );
							apstm.setString(6,Challanno );
							apstm.setString(7,chequeDate);
							apstm.setString(8,paymentDate );
							apstm.setString(9,remarks );
							apstm.setString(10,salesAmount);
							apstm.setString(11,Paid);
							apstm.setString(12,""+bal );
							apstm.setString(13,auserid);
							apstm.setString(14,transactiontype);
							System.out.println(""+apstm);
							apstm.execute();
							apstm.close();
							
							asql = " SELECT FUN_INV_GET_VENDORBALANCEAMOUNT_DIRECT('"+ponumber+"')";
							paidamount = Double.parseDouble(CommonFunctions.QueryExecute(asql)[0][0]);
							poamount = Double.parseDouble(salesAmount);
							pobalance = poamount - paidamount;
							
								
							asql = "UPDATE inv_t_directpurchase SET ";
							asql = asql + " DOU_PAIDAMOUNT = " +Paid +" , ";
							if(pobalance<1)
								asql = asql + " CHR_PAYMENTSTATUS = 'Y' ";
							else 
								asql = asql + " CHR_PAYMENTSTATUS ='P' ";
							asql = asql + " WHERE CHR_PURCHASEORDERNO='"+ponumber+"'";
							apstm = con.prepareStatement(asql);
							System.out.println(""+apstm);
							apstm.execute();
							apstm.close();	 
							 
							//Mail generation
							//PaymentMail.sendSalesPaymentAddMail(branchid,divisionid, salesOrderId,Path);
						}	
						
					}//end for loop
					
				}// end if
				
				con.close();
				response.sendRedirect("Smart Inventory/MultipleVendorPayment.jsp");
				
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
