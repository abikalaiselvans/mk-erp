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

public class SalesPaymentActionHandler extends AbstractActionHandler 
{
	private void payAdd(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			HttpSession session = request.getSession();
			String userId = "" + session.getAttribute("USRID");
			String branchId = "" + session.getAttribute("BRANCHID");
			String saleOId = request.getParameter("salesOrderId");
			String customerId = request.getParameter("customerId");
			String paymentId = request.getParameter("paymentMethod");
			String openDebit = request.getParameter("openDebit");
			String amountPaid = request.getParameter("amountPaid");
			String payDate = request.getParameter("paymentDate");
			payDate = DateUtil.FormateDateSQL(payDate);
			String curDate = DateUtil.getCurrentDateTime();
			
			
			String sql = "INSERT INTO   inv_t_customersalespayment   (INT_BRANCHID,INT_SALESORDERID,INT_CUSTOMERID,"
					+ "CHR_PAYMENTMETHOD,DAT_PAYMENTDATE,DOU_OPENDEBIT,DOU_PAIDAMOUNT,CHR_USRNAME,DT_UPDATEDATE,"
					+ "CHR_UPDATESTATUS) VALUES(?,?,?,?,?,?,?,?,?,?)";
			PreparedStatement pst = con.prepareStatement(sql);
			pst.setString(1, branchId);
			pst.setString(2, saleOId);
			pst.setString(3, customerId);
			pst.setString(4, paymentId);
			pst.setString(5, payDate);
			pst.setString(6, openDebit);
			pst.setString(7, amountPaid);
			pst.setString(8, userId);
			pst.setString(9, curDate);
			pst.setString(10, "Y");
			pst.execute();
		} catch (Exception e) {
			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request
					.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
			System.out.println(e.getMessage());
		}
	}

	
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String userId = "" + session.getAttribute("USRID");
			String branchid = session.getAttribute("INVBRANCH").toString();
			
			if (action.equals("INVSPaymentAdd")) 
			{
				payAdd(request, response);
				con.close();
				response.sendRedirect("Smart Inventory/Sales Payment.jsp");
			} 
			else if (action.equals("INVSalesPaymen")) 
			{
				String branchId = "" + session.getAttribute("BRANCHID");
				String salesOrderId = request.getParameter("salesOrderId");
				String paymentMethod = request.getParameter("paymentMethod");
				String payment[] = paymentMethod.split(",");
				String Bank = request.getParameter("Bank");
				String customerid = request.getParameter("customerid");
				String sql = "";
				sql = "SELECT INT_CUSTOMERID FROM inv_t_directsales WHERE CHR_SALESNO='"+ salesOrderId + "'";
				String data[][] = CommonFunctions.QueryExecute(sql);
				customerid = data[0][0];
				if ("Select".equals(Bank) || "".equals(Bank))
					Bank = "1";
				String Challanno = request.getParameter("Challanno");
				String chequeDate = request.getParameter("chequeDate");
				String paymentDate = request.getParameter("paymentDate");
				paymentDate = DateUtil.FormateDateSQL(paymentDate);
				String salesAmount = request.getParameter("salesAmount");
				String Balance = request.getParameter("Balance");
				String Paid = request.getParameter("Paid");
				String payType = request.getParameter("payType");
				String remarks = request.getParameter("remarks");
				String ref = request.getParameter("ref");
				String creditto = request.getParameter("creditto");
				String divisionid="";
				// System.out.println(remarks);
				double bal1 = Double.parseDouble(Balance)- Double.parseDouble(Paid);
				int bal = (int) bal1;
				String transactiontype = request.getParameter("transactiontype");
				String transactionid =CommonFunctions.QueryExecute("SELECT REPLACE(REPLACE(REPLACE(now(),'-',''),':',''),' ' ,'')")[0][0];
				
				
				asql = "INSERT INTO   inv_t_customersalespayment  ";
				asql = asql	+ "( INT_BRANCHID,INT_CUSTOMERID,CHR_SALESORDERNO,";
				asql = asql	+ " INT_PAYMENTTERMID,CHR_BANKNAME,CHR_PAYNO,DAT_PAYMENTDATE,";		
				asql = asql	+ " DOU_OPENDEBIT,DOU_PAIDAMOUNT,DOU_BALANCEAMOUNT,CHR_REMARK,CHR_PAYEMENTCOLLECTEDBY,CHR_CHKDATE,CHR_USRNAME, ";
				asql = asql	+ "  DT_UPDATEDATE,CHR_UPDATESTATUS,INT_DEPOSITID,INT_TRANSACTIONID,INT_TRANSACTIONTYPE )";
				asql = asql	+ " VALUES   ";
				asql = asql	+ "( ?,?,?,";
				asql = asql	+ " ?,?,?,DATE(NOW()),";		
				asql = asql	+ " ?,?,?,?,?,?,?, ";
				asql = asql	+ "  DATE(NOW()),'Y',?,?,? )";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,branchId);
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
				apstm.setString(15,transactionid);
				apstm.setString(16,transactiontype);
				System.out.println(""+apstm);
				apstm.execute();
				apstm.close();
				
				

				String paymentid = CommonFunctions.QueryExecute(" SELECT MAX(INT_PAYMENTID) FROM inv_t_customersalespayment")[0][0];
				// Payment commitment Block start..
				String rowid = request.getParameter("checkboxs");
				asql = "UPDATE inv_t_paymentcommitment SET INT_PAYMENTID=?,DT_RECIEVEDDATE=?,DOU_RECEIVEDAMOUNT=?,";
				asql = asql	+ " CHR_PAYMENTFLAG='Y',CHR_USRNAME=?,DT_UPDATEDATE=now() WHERE CHR_INVOICETYPE ='C' AND INT_PAYMENTCOMMITMENTID=? AND ";
				asql = asql + " CHR_SALESNO =? AND CHR_STATUS='Y' AND CHR_NEXTFLAG='N'";
				apstm = con.prepareStatement(asql);
				apstm.setString(1, paymentid);// Customer Payment id
				apstm.setString(2, paymentDate);// Payment received date
				apstm.setString(3, Paid);// Received Amount
				apstm.setString(4, "" + session.getAttribute("USRID"));
				apstm.setString(5, rowid);
				apstm.setString(6, salesOrderId);
				apstm.execute();
				apstm.close();

				// Payment Commitment Block End..
				sql = "";
				if (payType.equals("CashPay")) 
				{
					asql = "update inv_t_cashsales SET CHR_PAYMENTSTATUS='P' where CHR_SALESNO='"+ salesOrderId + "'";
					apstm = con.prepareStatement(asql);
					apstm.execute();
					apstm.close();
					divisionid =CommonFunctions.QueryExecute("SELECT INT_DIVIID from inv_t_cashsales WHERE  CHR_SALESNO ='"+salesOrderId+"'")[0][0];

				} 
				else if (payType.equals("Invoice")) 
				{
					asql = "update  inv_t_customersalesorder   SET CHR_PAYMENTSTATUS='P'  where CHR_INVOICENO='"+ salesOrderId + "'";
					apstm = con.prepareStatement(asql);
					apstm.execute();
					apstm.close();
					divisionid=CommonFunctions.QueryExecute("SELECT INT_DIVIID from inv_t_customersalesorder WHERE  CHR_SALESNO ='"+salesOrderId+"'")[0][0];

				} 
				else if (payType.equals("Direct")) 
				{
					asql = "update inv_t_directsales SET CHR_PAYMENTSTATUS='P'  where CHR_SALESNO='"+ salesOrderId + "'";
					apstm = con.prepareStatement(asql);
					apstm.execute();
					apstm.close();
					divisionid=CommonFunctions.QueryExecute("SELECT INT_DIVIID from inv_t_directsales WHERE  CHR_SALESNO ='"+salesOrderId+"'")[0][0];
				}

				
				//update progress bar in cpo 
				String cpodata[][] = CommonFunctions.QueryExecutecon(con," SELECT CHR_CPONUMBER FROM inv_t_directsales WHERE CHR_ROOT ='C' AND  CHR_SALESNO ='"+salesOrderId+"' ");
				String cponumber="";
				boolean cpoflag=false;
				if(cpodata.length>0)
				{
					cponumber= cpodata[0][0];
					cpoflag = true;
				}
				
				if (bal == 0) 
				{
					sql = "";
					if (payType.equals("Invoice")) 
					{
						asql = "update  inv_t_customersalesorder   SET CHR_PAYMENTSTATUS='Y' where CHR_INVOICENO='"	+ salesOrderId + "'";
					} 
					else if (payType.equals("CashPay")) 
					{
						asql = "update inv_t_cashsales SET CHR_PAYMENTSTATUS='Y'  where CHR_SALESNO='"+ salesOrderId + "'";
					} 
					else if (payType.equals("Direct")) 
					{
						asql = "update inv_t_directsales SET CHR_PAYMENTSTATUS='Y'  where CHR_SALESNO='"+ salesOrderId + "'";
					}
					apstm = con.prepareStatement(asql);
					apstm.execute();
					apstm.close();
					
					//update progress bar
					if(cpoflag)
					{	
						asql = "UPDATE  inv_t_customersalesorder SET INT_PROGRESSBAR = 95 WHERE CHR_SALESORDERNO=?";
						apstm = con.prepareStatement(asql);
						apstm.setString(1,cponumber );
						System.out.println(""+apstm);
						apstm.execute();
						apstm.close();
					}
				}
				else if (bal > 0)
				{

					// DIRECT SALES BILLING
					// UPDATE PARTIALLY PAID
					if (payType.equals("Direct")) 
					{
						asql = "update inv_t_directsales SET CHR_PAYMENTSTATUS='P'  where CHR_SALESNO='"+ salesOrderId + "'";
						apstm = con.prepareStatement(asql);
						apstm.execute();
						apstm.close();

						// Add one more payment commitment backend. that means
						// automated
						String newcomitmentdate = CommonFunctions.QueryExecute("SELECT DATE_FORMAT(DATE_ADD(DT_COMMITMENTDATE, INTERVAL 7 DAY),'%Y-%m-%d') FROM inv_t_paymentcommitment  WHERE INT_PAYMENTCOMMITMENTID ="+ rowid)[0][0];
						asql = "INSERT INTO inv_t_paymentcommitment (CHR_SALESNO,CHR_INVOICETYPE,DOU_ACTUALAMOUNT,DT_COMMITMENTDATE,DOU_COMMITMENTAMOUNT,CHR_STATUS) ";
						asql = asql + " VALUES(?,?,?,?,?,'Y')";
						apstm = con.prepareStatement(asql);
						apstm.setString(1, salesOrderId);
						apstm.setString(2, "C");
						apstm.setString(3, salesAmount);
						apstm.setString(4, "" + newcomitmentdate);
						apstm.setString(5, "" + bal);
						System.out.println("" + apstm);
						apstm.execute();
						apstm.close();

						asql = " UPDATE inv_t_directsales SET CHR_NOOFPAYMENTCOMMITMENT = (CHR_NOOFPAYMENTCOMMITMENT+1) WHERE CHR_SALESNO =? ";
						apstm = con.prepareStatement(asql);
						apstm.setString(1, salesOrderId);
						System.out.println("" + apstm);
						apstm.execute();
						apstm.close();
					}
					
					//progress bar updated
					if(cpoflag)
					{	
						asql = "UPDATE  inv_t_customersalesorder SET INT_PROGRESSBAR = 95 WHERE CHR_SALESORDERNO=?";
						apstm = con.prepareStatement(asql);
						apstm.setString(1,cponumber );
						System.out.println(""+apstm);
						apstm.execute();
						apstm.close();
					}

				}

				//Mail generation
				PaymentMail.sendSalesPaymentAddMail(branchid,divisionid, salesOrderId,Path);
				con.close();
				response.sendRedirect("Smart Inventory/Sales Payment.jsp");
			} 
			else if (action.equals("INVSalesPaymenUpdate")) 
			{
				String salesOrderId = request.getParameter("sid");
				String rowid = request.getParameter("rowid");
				String paid = request.getParameter("paid");
				String balance = request.getParameter("balance");
				String payType = request.getParameter("payType");
				String chkno = request.getParameter("chkno");
				String Bank = request.getParameter("Bank");
				String paymentdt = request.getParameter("paymentdt");

				asql = " UPDATE   inv_t_customersalespayment   SET ";
				asql = asql + " CHR_BANKNAME= '" + Bank + "' ";
				asql = asql + " , DOU_PAIDAMOUNT =" + paid;
				asql = asql + " , CHR_PAYNO = '" + chkno + "' ";
				asql = asql + " , DOU_BALANCEAMOUNT =" + balance;
				asql = asql + " WHERE INT_PAYMENTID =" + rowid;
				apstm = con.prepareStatement(asql);
				apstm.execute();
				apstm.close();

				asql = "UPDATE inv_t_paymentcommitment  SET DT_RECIEVEDDATE='"
						+ DateUtil.FormateDateSQL(paymentdt)
						+ "' , DOU_RECEIVEDAMOUNT=" + paid
						+ " WHERE INT_PAYMENTID=" + rowid
						+ " AND   CHR_SALESNO='" + salesOrderId
						+ "' AND  CHR_INVOICETYPE='C'";
				apstm = con.prepareStatement(asql);
				apstm.execute();
				apstm.close();

				double bal1 = Double.parseDouble(balance);
				int bal = (int) bal1;

				if (bal == 0) {
					if (payType.equals("Invoice"))
						asql = "update  inv_t_customersalesorder   SET CHR_PAYMENTSTATUS='Y'  where CHR_INVOICENO='"
								+ salesOrderId + "'";
					else if (payType.equals("CashPay"))
						asql = "update inv_t_cashsales SET CHR_PAYMENTSTATUS='Y'  where CHR_SALESNO='"
								+ salesOrderId + "'";
					else if (payType.equals("Direct"))
						asql = "update inv_t_directsales SET CHR_PAYMENTSTATUS='Y'  where CHR_SALESNO='"
								+ salesOrderId + "'";

					apstm = con.prepareStatement(asql);
					apstm.execute();
					apstm.close();
				}
				con.close();
				response.sendRedirect("Smart Inventory/Sales Payment.jsp");
			} 
			else if ("INVSalesPaymenEditDelete".equals(action)) 
			{

				String payType = request.getParameter("payType");
				String invoiceno = request.getParameter("invoiceno");
				String advanceid = request.getParameter("advanceid");
				String paidamount = request.getParameter("paidamount");
				
				String row = request.getParameter("row");
				if (payType.equals("Invoice")) 
				{

				} 
				else if (payType.equals("CashPay")) 
				{

				} 
				else if (payType.equals("Direct")) 
				{
					try 
					{
						//DELETE CUSTOMER PAYMENT
						asql = "DELETE FROM inv_t_customersalespayment WHERE CHR_SALESORDERNO=? AND INT_PAYMENTID= ?";
						apstm = con.prepareStatement(asql);
						apstm.setString(1, invoiceno);
						apstm.setString(2, row);
						System.out.println("1  : " + apstm);
						apstm.execute();
						apstm.close();
						
						asql = "SELECT DOU_TOTALAMOUNT FROM inv_t_directsales  WHERE CHR_SALESNO='" + invoiceno + "' ";
						String amounts[][] = CommonFunctions.QueryExecute(asql);
						double invoiceamount = 0.0;
						if (amounts.length > 0)
							invoiceamount = Double.parseDouble(amounts[0][0]);

						asql = "SELECT SUM(DOU_PAIDAMOUNT )FROM inv_t_customersalespayment WHERE CHR_SALESORDERNO='" + invoiceno + "'";
						String datas[][] = CommonFunctions.QueryExecute(asql);

						double ppaid = 0.0;
						if (datas.length > 0)
							if (!"-".equals(datas[0][0]))
								ppaid = Double.parseDouble(datas[0][0]);

						if (((invoiceamount - ppaid) > 0)) 
						{
							asql = "UPDATE inv_t_directsales SET CHR_PAYMENTSTATUS='P' WHERE CHR_SALESNO=?";
							apstm = con.prepareStatement(asql);
							apstm.setString(1, invoiceno);
							System.out.println("2  : " +apstm);
							apstm.execute();
							apstm.close();

						}
						if (ppaid == 0) 
						{
							asql = "UPDATE inv_t_directsales SET CHR_PAYMENTSTATUS='N' WHERE CHR_SALESNO=?";
							apstm = con.prepareStatement(asql);
							apstm.setString(1, invoiceno);
							System.out.println("2  : " + apstm);
							apstm.execute();
							apstm.close();
						}

						if ((invoiceamount - ppaid) == 0) 
						{
							asql = "UPDATE inv_t_directsales SET CHR_PAYMENTSTATUS='Y' WHERE CHR_SALESNO=?";
							apstm = con.prepareStatement(asql);
							apstm.setString(1, invoiceno);
							System.out.println("3  : " + apstm);
							apstm.execute();
							apstm.close();
						}

						
						// Delete Second Commitment
						asql = " SELECT INT_PAYMENTCOMMITMENTID FROM inv_t_paymentcommitment ";
						asql = asql + " WHERE INT_PAYMENTID ="+ row;
						asql = asql + " AND    CHR_INVOICETYPE='C' AND CHR_SALESNO='"+ invoiceno + "' ";
						System.out.println("4  : " + asql);
						String crow = CommonFunctions.QueryExecute(asql)[0][0];

						System.out.println(crow);
						asql = "DELETE FROM inv_t_paymentcommitment WHERE INT_PAYMENTCOMMITMENTID >? ";
						asql = asql + " AND   CHR_SALESNO=? AND  CHR_INVOICETYPE=?";
						System.out.println("" + asql);
						apstm = con.prepareStatement(asql);
						apstm.setString(1, crow);
						apstm.setString(2, invoiceno);
						apstm.setString(3, "C");
						System.out.println("5  : " +apstm);
						apstm.execute();
						apstm.close();

						asql = "UPDATE inv_t_paymentcommitment  SET DT_RECIEVEDDATE=null , ";
						asql = asql + " DOU_RECEIVEDAMOUNT=0, CHR_PAYMENTFLAG='N' ,CHR_STATUS='Y' ,INT_PAYMENTID =null ";
						asql = asql + " WHERE INT_PAYMENTCOMMITMENTID = ?";
						asql = asql + " AND   CHR_SALESNO = ?";
						asql = asql + " AND  CHR_INVOICETYPE = ?";
						apstm = con.prepareStatement(asql);
						apstm.setString(1, crow);
						apstm.setString(2, invoiceno);
						apstm.setString(3, "C");
						System.out.println("6  : " + apstm);
						apstm.execute();
						apstm.close();

						// reduce the No of commitment
						asql = " UPDATE inv_t_directsales SET CHR_NOOFPAYMENTCOMMITMENT = (CHR_NOOFPAYMENTCOMMITMENT-1) WHERE CHR_SALESNO =? ";
						apstm = con.prepareStatement(asql);
						apstm.setString(1, invoiceno);
						System.out.println("7  : " + apstm);
						apstm.execute();
						apstm.close();
						
						
						//cpo progress bar
						String cpodata[][] = CommonFunctions.QueryExecutecon(con," SELECT CHR_CPONUMBER FROM inv_t_directsales WHERE CHR_ROOT ='C' AND  CHR_SALESNO ='"+invoiceno+"' ");
						if(cpodata.length>0)
						{
							asql = "UPDATE  inv_t_customersalesorder SET INT_PROGRESSBAR = 65 WHERE CHR_SALESORDERNO=?";
							apstm = con.prepareStatement(asql);
							apstm.setString(1,cpodata[0][0] );
							System.out.println(""+apstm);
							apstm.execute();
							apstm.close();
						}
						
						
						asql = " UPDATE inv_t_advancepayment SET DOU_TRANSFERAMOUNT= (DOU_TRANSFERAMOUNT-"+paidamount+" ) ";
						asql = asql + "  WHERE INT_ADVANCEID = ? ";
						apstm = con.prepareStatement(asql);
						apstm.setString(1,advanceid );
						System.out.println(""+apstm);
						apstm.execute();
						apstm.close();
						
						//generate mails
						PaymentMail.sendCPaymentDeleteMail(branchid, invoiceno, Path);
						
					} 
					catch (Exception e) 
					{
						System.out.println(e.getMessage());
						e.printStackTrace();
					}
				}

				con.close();
				response.sendRedirect("Smart Inventory/Sales Payment.jsp");
			} 
			else if (action.equals("INVSalesDelete")) 
			{

				String payType = request.getParameter("payType");
				String invoicenos[] = request.getParameterValues("salesid");
				if (payType.equals("Invoice")) 
				{

				} else if (payType.equals("CashPay")) 
				{

				} else if (payType.equals("Direct")) 
				{

					for (int u = 0; u < invoicenos.length; u++) 
					{
						String invoiceno = invoicenos[u];
						asql = "DELETE FROM inv_t_customersalespayment WHERE CHR_SALESORDERNO='"
								+ invoiceno + "' ";
						apstm = con.prepareStatement(asql);
						apstm.execute();
						apstm.close();

						// Delete Second Commitment
						asql = " SELECT INT_PAYMENTCOMMITMENTID FROM inv_t_paymentcommitment ";
						asql = asql
								+ " WHERE  CHR_INVOICETYPE='C' AND CHR_SALESNO='"
								+ invoiceno
								+ "'  ORDER BY INT_PAYMENTCOMMITMENTID";
						String crow = CommonFunctions.QueryExecute(asql)[0][0];

						asql = "DELETE FROM inv_t_paymentcommitment WHERE INT_PAYMENTCOMMITMENTID >? ";
						asql = asql
								+ " AND   CHR_SALESNO=? AND  CHR_INVOICETYPE=?";
						apstm = con.prepareStatement(asql);
						apstm.setString(1, crow);
						apstm.setString(2, invoiceno);
						apstm.setString(3, "C");
						apstm.execute();
						apstm.close();

						asql = "UPDATE inv_t_paymentcommitment  SET DT_RECIEVEDDATE=null , ";
						asql = asql
								+ " DOU_RECEIVEDAMOUNT=0, CHR_STATUS='Y', CHR_PAYMENTFLAG='N' ,CHR_STATUS='Y' ";
						asql = asql + " WHERE INT_PAYMENTCOMMITMENTID = ?";
						asql = asql + " AND   CHR_SALESNO = ?";
						asql = asql + " AND  CHR_INVOICETYPE = ?";
						apstm = con.prepareStatement(asql);
						apstm.setString(1, crow);
						apstm.setString(2, invoiceno);
						apstm.setString(3, "C");
						apstm.execute();
						apstm.close();

						asql = "UPDATE inv_t_directsales SET CHR_NOOFPAYMENTCOMMITMENT=1 ,CHR_PAYMENTSTATUS='N' WHERE CHR_SALESNO='"
								+ invoiceno + "' ";
						apstm = con.prepareStatement(asql);
						apstm.execute();
						apstm.close();
					}
				}

				con.close();
				response.sendRedirect("Smart Inventory/Sales Payment.jsp");
			}

			else if (action.equals("INVDirectSalesChequeBounds")) 
			{
				String rowid = request.getParameter("rowid");
				String salesno = request.getParameter("salesno");
				String reason = request.getParameter("reason");
				String sql = " insert into inv_t_customersalespaymentchequereturn  (CHR_SALESORDERNO,INT_CUSTOMERID,INT_PAYMENTTERMID,CHR_BANKNAME, CHR_PAYNO,DAT_PAYMENTDATE,DOU_PAIDAMOUNT,CHR_PAYEMENTCOLLECTEDBY,CHR_CHKDATE, CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS,CHR_DESCRIPTION)  SELECT CHR_SALESORDERNO,INT_CUSTOMERID,INT_PAYMENTTERMID,CHR_BANKNAME, CHR_PAYNO,DAT_PAYMENTDATE,DOU_PAIDAMOUNT,CHR_PAYEMENTCOLLECTEDBY,CHR_CHKDATE,'"
						+ userId
						+ "',now(),'Y','"
						+ reason
						+ "'  FROM inv_t_customersalespayment WHERE INT_PAYMENTID="
						+ rowid;
				CommonFunctions.Execute(sql);
				CommonFunctions	.Execute("DELETE FROM inv_t_customersalespayment WHERE INT_PAYMENTID="+ rowid);
				String balanceamount = CommonFunctions
						.QueryExecute("SELECT (select ROUND(sum(DOU_PAIDAMOUNT)) from   inv_t_customersalespayment c where c.CHR_SALESORDERNO = a.CHR_SALESNO) FROM inv_t_directsales a ,inv_m_customerinfo b WHERE a.INT_CUSTOMERID=b.INT_CUSTOMERID AND a.CHR_SALESNO='"
								+ salesno + "'")[0][0];
				String Status = "P";
				if ("-".equals(balanceamount))
					Status = "N";
				CommonFunctions
						.Execute("UPDATE inv_t_directsales SET CHR_PAYMENTSTATUS='"
								+ Status
								+ "' WHERE CHR_SALESNO='"
								+ salesno
								+ "' ");
				con.close();
				response.sendRedirect("Smart Inventory/Sales Payment.jsp");
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
