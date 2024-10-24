package com.my.org.erp.SmartInventory;

import java.io.IOException;
import java.sql.PreparedStatement;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;

public class ServicePaymentMultipleInvoiceActionHandler extends AbstractActionHandler 
{
	 
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String userId = "" + session.getAttribute("USRID");
			String branchid = session.getAttribute("INVBRANCH").toString();
			 
			if (action.equals("INVServicePaymenMultipleinvoice")) 
			{
				String paymentMethod = request.getParameter("paymentMethod");
				String payment[] = paymentMethod.split(",");
				String Bank = request.getParameter("Bank");
				String Challanno = request.getParameter("Challanno");
				String chequeDate = request.getParameter("chequeDate");
				String paymentDate = request.getParameter("paymentDate");
				paymentDate = DateUtil.FormateDateSQL(paymentDate);
				String remarks = request.getParameter("remarks");
				String ref = request.getParameter("ref");
				String creditto = request.getParameter("creditto");
				if ("Select".equals(Bank) || "".equals(Bank))
					Bank = "1";
				
				String totalrecords = request.getParameter("totalrecords");
				int count  = Integer.parseInt(totalrecords);
				System.out.println(count);
				if(count >0)
				{
					String customerid = request.getParameter("customerid");
					
					for(int u=0;u<count;u++)
					{
						String salesOrderId = request.getParameter("salesnumber"+u);
						String salesAmount = request.getParameter("salesAmount"+u);
						String Balance = request.getParameter("Balance"+u);
						String Paid = request.getParameter("Paid"+u);
						String tickyes = request.getParameter("paidrow"+u);
						String payType = "Direct";
						String divisionid="";
						
						if("Y".equals(tickyes))
						{	
							double bal1 = Double.parseDouble(Balance)- Double.parseDouble(Paid);
							int bal = (int) bal1;
							 
							
							asql = "INSERT INTO   inv_t_servicebillingpayment  ";
							asql = asql	+ "( INT_BRANCHID,INT_CUSTOMERID,CHR_SALESNO,";
							asql = asql	+ " INT_PAYMENTTERMID,INT_BANKID,CHR_REFNO,DAT_PAYMENTDATE,";		
							asql = asql	+ " DOU_OPENDEBIT,DOU_PAIDAMOUNT,DOU_BALANCEAMOUNT,CHR_REMARK,CHR_PAYEMENTCOLLECTEDBY,CHR_CHKDATE,CHR_USRNAME, ";
							asql = asql	+ "  DT_UPDATEDATE,CHR_UPDATESTATUS,INT_DEPOSITID )";
							asql = asql	+ " VALUES   ";
							asql = asql	+ "( ?,?,?,";
							asql = asql	+ " ?,?,?,DATE(NOW()),";		
							asql = asql	+ " ?,?,?,?,?,?,?, ";
							asql = asql	+ " DATE(NOW()),'Y',? )";
							apstm = con.prepareStatement(asql);
							apstm.setString(1,branchid);
							apstm.setString(2,customerid);
							apstm.setString(3,salesOrderId);
							apstm.setString(4,payment[0] );
							apstm.setString(5,Bank);
							apstm.setString(6,Challanno);
							apstm.setString(7,salesAmount);
							apstm.setString(8,Paid);
							apstm.setString(9,""+bal);
							apstm.setString(10,remarks);
							apstm.setString(11,ref);
							apstm.setString(12,DateUtil.FormateDateSQL(chequeDate));
							apstm.setString(13,userId);
							apstm.setString(14,creditto);
							System.out.println(""+apstm);
							apstm.execute();
							apstm.close();
							
							String paymentid = CommonFunctions.QueryExecute(" SELECT MAX(INT_PAYMENTID) FROM inv_t_servicebillingpayment")[0][0];
							// Payment commitment Block start..
							String rowid = request.getParameter("checkboxs"+u);
							 
							asql = "UPDATE inv_t_paymentcommitment SET INT_PAYMENTID=?,DT_RECIEVEDDATE=?,DOU_RECEIVEDAMOUNT=?,";
							asql = asql	+ " CHR_PAYMENTFLAG='Y',CHR_USRNAME=?,DT_UPDATEDATE=now() WHERE CHR_INVOICETYPE ='S' AND INT_PAYMENTCOMMITMENTID=? AND ";
							asql = asql + " CHR_SALESNO =? AND CHR_STATUS='Y' AND CHR_NEXTFLAG='N'";
							apstm = con.prepareStatement(asql);
							apstm.setString(1, paymentid);// Customer Payment id
							apstm.setString(2, paymentDate);// Payment received date
							apstm.setString(3, Paid);// Received Amount
							apstm.setString(4, auserid);
							apstm.setString(5, rowid);
							apstm.setString(6, salesOrderId);
							System.out.println(""+apstm);
							apstm.execute();
							apstm.close();
							// Payment Commitment Block End..
							
							divisionid=CommonFunctions.QueryExecute("SELECT INT_DIVIID from inv_t_servicebilling WHERE  CHR_SALESNO ='"+salesOrderId+"'")[0][0];
	
						
							if (bal == 0) 
							{
								 
								asql = "update inv_t_servicebilling SET CHR_PAYMENTSTATUS='Y'  where CHR_SALESNO='"+ salesOrderId + "'";
								apstm = con.prepareStatement(asql);
								System.out.println(""+apstm);
								apstm.execute();
								apstm.close();
							}
							else if (bal > 0)
							{
	
								// DIRECT SALES BILLING
								// UPDATE PARTIALLY PAID
								if (payType.equals("Direct")) 
								{
									 
									asql = "update inv_t_servicebilling SET CHR_PAYMENTSTATUS='P'  where CHR_SALESNO='"+ salesOrderId + "'";
									apstm = con.prepareStatement(asql);
									System.out.println(""+apstm);
									apstm.execute();
									apstm.close();
	
									// Add one more payment commitment backend. that means
									// automated
									 
									String newcomitmentdate = CommonFunctions.QueryExecute("SELECT DATE_FORMAT(DATE_ADD(DT_COMMITMENTDATE, INTERVAL 7 DAY),'%Y-%m-%d') FROM inv_t_paymentcommitment  WHERE INT_PAYMENTCOMMITMENTID ="+ rowid)[0][0];
									asql = "INSERT INTO inv_t_paymentcommitment (CHR_SALESNO,CHR_INVOICETYPE,DOU_ACTUALAMOUNT,DT_COMMITMENTDATE,DOU_COMMITMENTAMOUNT,CHR_STATUS) ";
									asql = asql + " VALUES(?,?,?,?,?,'Y')";
									apstm = con.prepareStatement(asql);
									apstm.setString(1, salesOrderId);
									apstm.setString(2, "S");
									apstm.setString(3, salesAmount);
									apstm.setString(4, "" + newcomitmentdate);
									apstm.setString(5, "" + bal);
									System.out.println("" + apstm);
									apstm.execute();
									apstm.close();
									
									 
									asql = " UPDATE inv_t_servicebilling SET CHR_NOOFPAYMENTCOMMITMENT = (CHR_NOOFPAYMENTCOMMITMENT+1) WHERE CHR_SALESNO =? ";
									apstm = con.prepareStatement(asql);
									apstm.setString(1, salesOrderId);
									System.out.println("" + apstm);
									apstm.execute();
									apstm.close();
								}
								
								 
	
							}
	
							//Mail generation
							PaymentMail.sendServiceBillingPaymentAddMail(branchid, divisionid, salesOrderId, Path);

						 
							
						}	
						
					}//end for loop
					
				}// end if
				
				con.close();
				response.sendRedirect("Smart Inventory/ServiceBillingPayments.jsp");
 				
			} 
			

		} 
		catch (Exception e) 
		{
			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
		}
	}

}
