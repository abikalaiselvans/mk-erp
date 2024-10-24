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
import com.my.org.erp.setting.CommonData;

public class ServiceBillingActionHandler extends AbstractActionHandler {
	public synchronized void handle(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			String action = "" + request.getParameter("actionS").trim();
			HttpSession session = request.getSession();
			String branchid = session.getAttribute("BRANCHID").toString();
			String invbranchstateid = session.getAttribute("INVBRANCHSTATEID").toString();
			String user = session.getAttribute("USRID").toString();
			String officeid = "" + session.getAttribute("OFFICEID");
			Statement st = con.createStatement();
			if ("INVServiceBillingAdd".equals(action)) {

				String divis = request.getParameter("divis");
				String mode = request.getParameter("mode");
				String ponumber = request.getParameter("ponumber");
				if(ponumber.length()<5)
					ponumber=null;
				String divisionid = divis;
				String SaleNo = "";
				String saleDate = request.getParameter("saleDate");
				saleDate = DateUtil.FormateDateSQL(saleDate);
				String customer = request.getParameter("customer");
				String gststateid = request.getParameter("gststateid");
				String ref = request.getParameter("ref");
				String memo = request.getParameter("memo");
				@SuppressWarnings("unused")
				String dt = request.getParameter("saleDate");
				String totals = request.getParameter("totals");
				String servicetaxflag = request.getParameter("servicetaxflag");
				String servicetax12 = request.getParameter("servicetax12");
				String st12 = request.getParameter("st12");
				String servicetax2 = request.getParameter("servicetax2");
				String st2 = request.getParameter("st2");
				String servicetax1 = request.getParameter("servicetax1");
				String st1 = request.getParameter("st1");
				String totals2 = request.getParameter("totals2");
				String Shipping = request.getParameter("Shipping");
				String shippingaddress = request.getParameter("shippingaddress");
				String oref = request.getParameter("oref");
				String dnote = request.getParameter("dnote");
				String dthru = request.getParameter("dthru");
				String destination = request.getParameter("destination");
				String tdelivery = request.getParameter("tdelivery");
				String cdetails = request.getParameter("cdetails");
				String cnumber = request.getParameter("cnumber");
				String noofpaymentcommitment = request.getParameter("noofpaymentcommitment");
				String commitmentdays = request.getParameter("commitmentdays");
				String project = request.getParameter("project");
				String hsncode = request.getParameter("hsncode");
				String param[] = request.getParameter("param").split(",");
				String taxid = "";
				for (int u = 0; u < param.length; u++)
					taxid = taxid + request.getParameter("Tax" + param[u])
							+ ",";
				String taxvalue = "";
				for (int u = 0; u < param.length; u++)
					taxvalue = taxvalue
							+ request.getParameter("Taxvalue" + param[u]) + ",";
				String taxamount = "";
				for (int u = 0; u < param.length; u++)
					taxamount = taxamount
							+ request.getParameter("Taxamount" + param[u])
							+ ",";
				taxid = taxid.replaceAll("null", "0");
				taxvalue = taxvalue.replaceAll("null", "0");
				taxamount = taxamount.replaceAll("null", "0");

				String nettotal = request.getParameter("nettotal").trim();

				// SaleNo=
				// "SB/"+InventoryInvoiceFunctions.accountYear()+InventoryInvoiceFunctions.serviceBillNumber()+"/"+InventoryInvoiceFunctions.invoiceLocation(officeid)+"/"+InventoryInvoiceFunctions.invoiceDivision(divisionid);
				SaleNo = InventoryInvoiceFunctions.serviceBillingNumberGet(""
						+ session.getAttribute("INVSTATE"), officeid,
						divisionid);
				asql = " INSERT INTO inv_t_servicebilling  ( INT_BRANCHID,INT_DIVIID,CHR_SALESNO,DAT_SALESDATE,INT_CUSTOMERID,";
				asql = asql + " CHR_REF,CHR_DES,DOU_AMOUNT,CHR_PAYMENTSTATUS,CHR_SHIPPING,CHR_SHIPPINGADDRESS,CHR_OTHERREF,";
				asql = asql + " CHR_DELIVERYNOTE,CHR_DESPATCHTHRU,CHR_DESTINATION,CHR_TERMSOFDELIVERY,CHR_CONTACTDETAILS, ";
				asql = asql + " CHR_CONTACTNO,CHR_TAXID,CHR_TAXVALUE,CHR_TAXAMOUNT,DOU_NETAMOUNT,CHR_NOOFPAYMENTCOMMITMENT,";
				asql = asql + " CHR_USRNAME,DT_UPDATEDATE ,CHR_UPDATESTATUS,INT_PAYMENT_COMMITMENT_DAYS, ";
				asql = asql + " CHR_SERVICETAX_FLAG,DOU_SERVICETAX12 , DOU_SERVICE_AMOUNT12,  ";
				asql = asql + " DOU_SERVICETAX2 , DOU_SERVICE_AMOUNT2,  ";
				asql = asql + " DOU_SERVICETAX1 , DOU_SERVICE_AMOUNT1,  ";
				asql = asql + " DOU_SERVICE_AMOUNT,INT_PROJECTID,CHR_MODE,CHR_SERVICEPOREF,CHR_GST_TYPE,CHR_HSNCODE  )";
				asql = asql + "VALUES (?,?,?,?,?,?,?,?, 'N',?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,now(),'Y',?,?,? ,? ,?,?,? ,?,?,?,?,?,?,?)";
				apstm = con.prepareStatement(asql);
				
				apstm.setString(1, branchid);
				apstm.setString(2, divis);
				apstm.setString(3, SaleNo);
				apstm.setString(4, saleDate);
				apstm.setString(5, customer);
				apstm.setString(6, ref);
				apstm.setString(7, memo);
				apstm.setString(8, totals);
				apstm.setString(9, Shipping);
				apstm.setString(10, shippingaddress);
				apstm.setString(11, oref);
				apstm.setString(12, dnote);
				apstm.setString(13, dthru);
				apstm.setString(14, destination);
				apstm.setString(15, tdelivery);
				apstm.setString(16, cdetails);
				apstm.setString(17, cnumber);
				apstm.setString(18, taxid);
				apstm.setString(19, taxvalue);
				apstm.setString(20, taxamount);
				apstm.setString(21, "" + Math.round(Double.parseDouble(nettotal)));
				apstm.setString(22, noofpaymentcommitment);
				apstm.setString(23, user);
				apstm.setString(24, commitmentdays);
				apstm.setString(25, servicetaxflag);
				apstm.setString(26, servicetax12);
				apstm.setString(27, st12);
				apstm.setString(28, servicetax2);
				apstm.setString(29, st2);
				apstm.setString(30, servicetax1);
				apstm.setString(31, st1);
				apstm.setString(32, totals2);
				apstm.setString(33, project);
				apstm.setString(34, mode);
				apstm.setString(35, ponumber);
				//apstm.setString(36, gststateid);
				if(invbranchstateid.equalsIgnoreCase(gststateid))
					apstm.setString(36,"S");
				else
					apstm.setString(36,"D");
				apstm.setString(37,hsncode);
				System.out.println("" + apstm);
				apstm.execute();

				asql = " SELECT FUN_INV_SERVICEBILLNUMBER_INSERT(? )";
				apstm = con.prepareStatement(asql);
				apstm.setString(1, "" + session.getAttribute("INVSTATE"));
				System.out.println("" + apstm);
				apstm.execute();

				// insert into payment commitment
				int noofpayment = Integer.parseInt(request .getParameter("noofpaymentcommitment"));

				asql = "INSERT INTO inv_t_paymentcommitment (CHR_SALESNO,CHR_INVOICETYPE,DOU_ACTUALAMOUNT) ";
				asql = asql + " VALUES(?,?,?)";
				apstm = con.prepareStatement(asql);
				for (int h = 0; h < noofpayment; h++) {
					apstm.setString(1, SaleNo);
					apstm.setString(2, "S");
					apstm.setString(3, nettotal);
					System.out.println("" + apstm);
					apstm.addBatch();
				}
				apstm.executeBatch();
				apstm.close();
				
				if("P".equals(mode))
				{
					
					asql = " SELECT DOU_AMOUNT - FUN_INV_SERVICE_PO_BILLEDAMOUNT(CHR_SERVICEPOREF) balance ";
					asql = asql + " FROM inv_t_servicebillingpo  WHERE CHR_SERVICEPOREF='"+ponumber+"'";
					double paid = Double.parseDouble(CommonFunctions.QueryExecutecon(con, asql)[0][0]);
					String s="P";
					if(paid<1)
						s="Y";
					asql = "UPDATE inv_t_servicebillingpo SET CHR_STATUS= ? WHERE CHR_SERVICEPOREF=?";
					apstm = con.prepareStatement(asql);
					apstm.setString(1, s);
					apstm.setString(2, ponumber);
					System.out.println("" + apstm);
					apstm.execute();
					apstm.close();
					
				}
				con.close();
				response.sendRedirect("Smart Inventory/PaymentCommitmentEdit.jsp?salno=" + SaleNo + "&Billinttype=S");
			} 
			else if ("INVServiceBillingEdit".equals(action))
			{
				String SaleNo = request.getParameter("SaleNo").trim();
				String saleDate = request.getParameter("saleDate").trim();
				saleDate = com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(
						saleDate).trim();
				String customer = request.getParameter("customer").trim();
				String ref = request.getParameter("ref").trim();
				String memo = request.getParameter("memo").trim();
				String totals = request.getParameter("totals").trim();
				String servicetaxflag = request.getParameter("servicetaxflag");
				String servicetax12 = request.getParameter("servicetax12");
				String st12 = request.getParameter("st12");
				String servicetax2 = request.getParameter("servicetax2");
				String st2 = request.getParameter("st2");
				String servicetax1 = request.getParameter("servicetax1");
				String st1 = request.getParameter("st1");
				String totals2 = request.getParameter("totals2");
				String Shipping = request.getParameter("Shipping").trim();
				String shippingaddress = request
						.getParameter("shippingaddress").trim();
				String oref = request.getParameter("oref").trim();
				String dnote = request.getParameter("dnote").trim();
				String dthru = request.getParameter("dthru").trim();
				String destination = request.getParameter("destination").trim();
				String tdelivery = request.getParameter("tdelivery").trim();
				String cdetails = request.getParameter("cdetails".trim());
				String cnumber = request.getParameter("cnumber").trim();
				String hsncode = request.getParameter("hsncode");
				String project = request.getParameter("project");
				String param[] = request.getParameter("param").split(",");
				String taxid = "";
				for (int u = 0; u < param.length; u++)
					taxid = taxid + request.getParameter("Tax" + param[u])
							+ ",";
				String taxvalue = "";
				for (int u = 0; u < param.length; u++)
					taxvalue = taxvalue
							+ request.getParameter("Taxvalue" + param[u]) + ",";
				String taxamount = "";
				for (int u = 0; u < param.length; u++)
					taxamount = taxamount
							+ request.getParameter("Taxamount" + param[u])
							+ ",";

				taxid = taxid.replaceAll("null", "0");
				taxvalue = taxvalue.replaceAll("null", "0");
				taxamount = taxamount.replaceAll("null", "0");

				String nettotal = request.getParameter("nettotal");
				String noofpaymentcommitment = request
						.getParameter("noofpaymentcommitment");
				String commitmentdays = request.getParameter("commitmentdays");
				asql = "UPDATE inv_t_servicebilling SET ";
				asql = asql + " DAT_SALESDATE = ? ,";
				asql = asql + " INT_CUSTOMERID = ?,";
				asql = asql + " CHR_REF = ?,";
				asql = asql + " CHR_DES = ?,";
				asql = asql + " DOU_AMOUNT = ? ,";
				asql = asql + " CHR_SERVICETAX_FLAG = ? ,";
				asql = asql + " DOU_SERVICETAX12 = ? ,";
				asql = asql + " DOU_SERVICE_AMOUNT12 = ? ,";
				asql = asql + " DOU_SERVICETAX2 = ? ,";
				asql = asql + " DOU_SERVICE_AMOUNT2 = ? ,";
				asql = asql + " DOU_SERVICETAX1 = ? ,";
				asql = asql + " DOU_SERVICE_AMOUNT1 = ? ,";
				asql = asql + " DOU_SERVICE_AMOUNT = ? ,";
				asql = asql + " CHR_SHIPPING =?,";
				asql = asql + " CHR_SHIPPINGADDRESS=?,";
				asql = asql + " CHR_OTHERREF=?,";
				asql = asql + " CHR_DELIVERYNOTE=?,";
				asql = asql + " CHR_DESPATCHTHRU=?,";
				asql = asql + " CHR_DESTINATION=?,";
				asql = asql + " CHR_TERMSOFDELIVERY=?,";
				asql = asql + " CHR_CONTACTDETAILS=?,";
				asql = asql + " CHR_CONTACTNO=?,";
				asql = asql + " CHR_TAXID=?,";
				asql = asql + " CHR_TAXVALUE=?,";
				asql = asql + " CHR_TAXAMOUNT=?,";
				asql = asql + " DOU_NETAMOUNT=? , ";
				asql = asql + " CHR_NOOFPAYMENTCOMMITMENT =?,";
				asql = asql + " INT_PAYMENT_COMMITMENT_DAYS =?, ";
				asql = asql + " INT_PROJECTID =?, ";
				asql = asql + " CHR_HSNCODE =? ";
				asql = asql + " WHERE CHR_SALESNO=? ";

				apstm = con.prepareStatement(asql);
				apstm.setString(1, saleDate);
				apstm.setString(2, customer);
				apstm.setString(3, ref);
				apstm.setString(4, memo);
				apstm.setString(5, totals);
				apstm.setString(6, servicetaxflag);
				apstm.setString(7, servicetax12);
				apstm.setString(8, st12);
				apstm.setString(9, servicetax2);
				apstm.setString(10, st2);
				apstm.setString(11, servicetax1);
				apstm.setString(12, st1);
				apstm.setString(13, totals2);
				apstm.setString(14, Shipping);
				apstm.setString(15, shippingaddress);
				apstm.setString(16, oref);
				apstm.setString(17, dnote);
				apstm.setString(18, dthru);
				apstm.setString(19, destination);
				apstm.setString(20, tdelivery);
				apstm.setString(21, cdetails);
				apstm.setString(22, cnumber);
				apstm.setString(23, taxid);
				apstm.setString(24, taxvalue);
				apstm.setString(25, taxamount);
				apstm.setString(26,
						"" + Math.round(Double.parseDouble(nettotal)));
				apstm.setString(27, noofpaymentcommitment);
				apstm.setString(28, commitmentdays);
				apstm.setString(29, project);
				apstm.setString(30, hsncode);
				apstm.setString(31, SaleNo);
				System.out.println("" + apstm);
				apstm.execute();
				apstm.close();

				asql = " DELETE FROM inv_t_paymentcommitment WHERE CHR_SALESNO=? AND CHR_INVOICETYPE=? ";
				apstm = con.prepareStatement(asql);
				apstm.setString(1, SaleNo);
				apstm.setString(2, "S");
				System.out.println("" + apstm);
				apstm.execute();
				apstm.close();

				// insert into payment commitment
				int noofpayment = Integer.parseInt(request .getParameter("noofpaymentcommitment"));
				asql = "INSERT INTO inv_t_paymentcommitment (CHR_SALESNO,CHR_INVOICETYPE,DOU_ACTUALAMOUNT) ";
				asql = asql + " VALUES(?,?,?)";
				apstm = con.prepareStatement(asql);
				for (int h = 0; h < noofpayment; h++) 
				{
					apstm.setString(1, SaleNo);
					apstm.setString(2, "S");
					apstm.setString(3, nettotal);
					apstm.addBatch();
					System.out.println("" + apstm);
				}
				apstm.executeBatch();
				apstm.close();
				con.close();
				response.sendRedirect("Smart Inventory/PaymentCommitmentEdit.jsp?salno=" + SaleNo + "&Billinttype=S");
			} 
			else if ("INVServiceBillingDelete".equals(action)) 
			{
				String saleno = "" + request.getParameter("saleno");
				String reason = "" + request.getParameter("reason");
				String email = "" + request.getParameter("email");
				String salno[] = (saleno + ",").split(",");
				 
				
				for (int u = 0; u < salno.length; u++) 
				{
					
					asql = "  SELECT CHR_MODE,CHR_SERVICEPOREF  from inv_t_servicebilling  WHERE CHR_MODE='P' AND CHR_SALESNO='"	+ salno[u] + "' ";
					String data[][] = CommonFunctions.QueryExecutecon(con, asql);
					
					asql = " DELETE FROM inv_t_servicebilling WHERE CHR_SALESNO='"	+ salno[u] + "' ";
					st.execute(asql);

					if(data.length>0)
					{
			
						asql = " SELECT DOU_AMOUNT - FUN_INV_SERVICE_PO_BILLEDAMOUNT(CHR_SERVICEPOREF) balance ";
						asql = asql + " FROM inv_t_servicebillingpo  WHERE CHR_SERVICEPOREF='"+data[0][1]+"'";
						double paid = Double.parseDouble(CommonFunctions.QueryExecutecon(con, asql)[0][0]);
						String s="P";
						if(paid<1)
							s="Y";
						asql = "UPDATE inv_t_servicebillingpo SET CHR_STATUS= ? WHERE CHR_SERVICEPOREF=?";
						apstm = con.prepareStatement(asql);
						apstm.setString(1, s);
						apstm.setString(2, data[0][1]);
						System.out.println("" + apstm);
						apstm.execute();
						apstm.close();
					}
					
					asql = " INSERT INTO inv_t_directsalesdelete (INT_BRANCHID,CHR_SALESNO,CHR_DES,DAT_DELETEDATE,CHR_INVOICEMODE,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS) ";
					asql = asql	+ "VALUES (?,?,?, NOW(),'SERVICE BILLING','ADMIN',NOW(),'Y' )";
					apstm = con.prepareStatement(asql);
					apstm.setString(1, branchid);
					apstm.setString(2, salno[u]);
					apstm.setString(3, reason);
					apstm.execute();
					apstm.close();

					asql = "DELETE FROM inv_t_servicebillingpayment WHERE  CHR_SALESNO='"	+ salno[u] + "' ";
					st.execute(asql);

					asql = " DELETE FROM inv_t_paymentcommitment WHERE CHR_SALESNO='"+ salno[u] + "' AND CHR_INVOICETYPE='S' ";
					st.execute(asql);

					// Send a mail for Delete invoice
					String a[] = (email + "," + CommonData.mailid).split(",");
					com.my.org.erp.mail.Mail.SimpleHTMLMail(a,"DELETE  SERVICE BILLING :: " + salno[u],	InvoiceDeletetMail.InvoiceDeletesendtoMail("DELETE  SERVICE BILLING :: " + salno[u],
									salno[u], reason, "SERVICE BILLING"));
				}

				// future coding for payment table
				con.close();
				response.sendRedirect("Smart Inventory/ServiceBilling.jsp");
			}
			else if ("INVServiceBillingCancel".equals(action)) 
			{
				String saleno = request.getParameter("salesid");
				String reason = request.getParameter("reason");
				asql = "UPDATE inv_t_servicebilling SET DOU_CANCELAMOUNT= DOU_NETAMOUNT, CHR_CANCELDESC=?,DOU_AMOUNT=0,  DOU_SERVICE_AMOUNT=0,DOU_NETAMOUNT=0,CHR_CANCEL='Y', CHR_CANCELID=?,DAT_CANCELDATE=NOW() WHERE CHR_SALESNO=?";
				apstm = con.prepareStatement(asql);
				apstm.setString(1, reason);
				apstm.setString(2, "" + session.getAttribute("EMPID"));
				apstm.setString(3, saleno);
				apstm.execute();
				apstm.close();
				
				asql = "  SELECT CHR_MODE,CHR_SERVICEPOREF  from inv_t_servicebilling  WHERE CHR_MODE='P' AND CHR_SALESNO='"	+saleno + "' ";
				String data[][] = CommonFunctions.QueryExecutecon(con, asql);
				
				if(data.length>0)
				{
		
					asql = " SELECT DOU_AMOUNT - FUN_INV_SERVICE_PO_BILLEDAMOUNT(CHR_SERVICEPOREF) balance ";
					asql = asql + " FROM inv_t_servicebillingpo  WHERE CHR_SERVICEPOREF='"+data[0][1]+"'";
					double paid = Double.parseDouble(CommonFunctions.QueryExecutecon(con, asql)[0][0]);
					String s="P";
					if(paid<1)
						s="Y";
					asql = "UPDATE inv_t_servicebillingpo SET CHR_STATUS= ? WHERE CHR_SERVICEPOREF=?";
					apstm = con.prepareStatement(asql);
					apstm.setString(1, s);
					apstm.setString(2, data[0][1]);
					System.out.println("" + apstm);
					apstm.execute();
					apstm.close();
				}
				

				// Send a mail for Delete invoice
				String email = "" + request.getParameter("email");
				String a[] = (email + "," + CommonData.mailid).split(",");
				com.my.org.erp.mail.Mail.SimpleHTMLMail(a,
						"CANCELL  SERVICE BILLING :: " + saleno,
						InvoiceDeletetMail.InvoiceCancellsendtoMail(
								"CANCELL SERVICE BILLING :: " + saleno, saleno,
								reason, "SERVICE BILLING"));
				con.close();
				response.sendRedirect("Smart Inventory/ServiceBilling.jsp");
			}

			// Billing payment
			else if ("INVSalesPaymen".equals(action)) {
				String Invoiceno = request.getParameter("salesOrderId");
				@SuppressWarnings("unused")
				String InvoiceDate = request.getParameter("salesDate");
				String paymentMethod = request.getParameter("paymentMethod");
				String payment[] = paymentMethod.split(",");
				String Bank = request.getParameter("Bank");
				String customerid = request.getParameter("customerid");
				asql = "SELECT INT_CUSTOMERID,INT_BRANCHID FROM inv_t_servicebilling WHERE CHR_SALESNO='"
						+ Invoiceno + "'";
				String data[][] = CommonFunctions.QueryExecute(asql);
				customerid = data[0][0];
				String branch = "";
				branch = data[0][1];
				if ("Select".equals(Bank))
					Bank = "1";

				String Challanno = request.getParameter("Challanno");
				String chequeDate = request.getParameter("chequeDate");
				String paymentDate = request.getParameter("paymentDate");
				paymentDate = DateUtil.FormateDateSQL(paymentDate);
				String salesAmount = request.getParameter("salesAmount");
				@SuppressWarnings("unused")
				String Balance = request.getParameter("Balance");
				String Paid = request.getParameter("Paid");
				@SuppressWarnings("unused")
				String payType = request.getParameter("payType");
				String remarks = request.getParameter("remarks");
				String ref = request.getParameter("ref");
				String creditto = request.getParameter("creditto");
				asql = "INSERT INTO inv_t_servicebillingpayment ( ";
				asql = asql
						+ " INT_BRANCHID,CHR_SALESNO,INT_CUSTOMERID,INT_PAYMENTTERMID ,";
				asql = asql
						+ " INT_BANKID,CHR_REFNO,CHR_CHKDATE,DAT_PAYMENTDATE,DOU_PAIDAMOUNT,";
				asql = asql
						+ " CHR_REMARK,CHR_PAYEMENTCOLLECTEDBY,INT_DEPOSITID,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS )";
				asql = asql + " VALUES (";
				asql = asql + " ?,?,?,?,?,?,?,now() ,?,?,?,?,? , now(),'Y'";
				asql = asql + " )";
				apstm = con.prepareStatement(asql);
				apstm.setString(1, branch);
				apstm.setString(2, Invoiceno);
				apstm.setString(3, customerid);
				apstm.setString(4, payment[0]);
				apstm.setString(5, Bank);
				apstm.setString(6, Challanno);
				apstm.setString(7, DateUtil.FormateDateSQL(chequeDate));
				apstm.setString(8, Paid);
				apstm.setString(9, remarks);
				apstm.setString(10, ref);
				apstm.setString(11, creditto);
				apstm.setString(12, user);
				apstm.execute();
				apstm.close();
				String paymentid = CommonFunctions
						.QueryExecute(" SELECT MAX(INT_PAYMENTID) FROM inv_t_servicebillingpayment")[0][0];

				// Payment commitment Block start..
				String rowid = request.getParameter("checkboxs");
				asql = "UPDATE inv_t_paymentcommitment SET INT_PAYMENTID=?,DT_RECIEVEDDATE=?,DOU_RECEIVEDAMOUNT=?,";
				asql = asql
						+ " CHR_PAYMENTFLAG='Y',CHR_USRNAME=?,DT_UPDATEDATE=now() WHERE CHR_INVOICETYPE ='S' AND INT_PAYMENTCOMMITMENTID=? AND ";
				asql = asql
						+ " CHR_SALESNO =? AND CHR_STATUS='Y' AND CHR_NEXTFLAG='N'";
				apstm = con.prepareStatement(asql);
				apstm.setString(1, paymentid);// Payment received date
				apstm.setString(2, paymentDate);// Payment received date
				apstm.setString(3, Paid);// Received Amount
				apstm.setString(4, "" + session.getAttribute("USRID"));
				apstm.setString(5, rowid);
				apstm.setString(6, Invoiceno);
				apstm.execute();
				apstm.close();
				// Payment Commitment Block End..

				double invoiceamount = Double.parseDouble(salesAmount);
				asql = "SELECT SUM(DOU_PAIDAMOUNT )FROM inv_t_servicebillingpayment WHERE CHR_SALESNO='"
						+ Invoiceno + "' AND INT_BRANCHID=" + branch;
				String datas[][] = CommonFunctions.QueryExecute(asql);
				double paid = 0.0;
				if (datas.length > 0)
					paid = Double.parseDouble(datas[0][0]);

				if ((invoiceamount - paid) > 0) {
					asql = "UPDATE inv_t_servicebilling SET CHR_PAYMENTSTATUS='P' WHERE CHR_SALESNO='"
							+ Invoiceno + "' AND INT_BRANCHID=" + branch;
					st.execute(asql);

					// Add one more payment commitment backend. that means
					// automated
					asql = "INSERT INTO inv_t_paymentcommitment (CHR_SALESNO,CHR_INVOICETYPE,DOU_ACTUALAMOUNT,DT_COMMITMENTDATE,DOU_COMMITMENTAMOUNT,CHR_STATUS) ";
					asql = asql + " VALUES(?,?,?,DATE(NOW()),?,'Y')";
					apstm = con.prepareStatement(asql);
					apstm.setString(1, Invoiceno);
					apstm.setString(2, "S");
					apstm.setString(3, salesAmount);
					apstm.setString(4, "" + (invoiceamount - paid));
					System.out.println("" + apstm);
					apstm.execute();
					apstm.close();

					asql = " UPDATE inv_t_servicebilling SET CHR_NOOFPAYMENTCOMMITMENT = (CHR_NOOFPAYMENTCOMMITMENT+1) WHERE CHR_SALESNO =? ";
					apstm = con.prepareStatement(asql);
					apstm.setString(1, Invoiceno);
					System.out.println("" + apstm);
					apstm.execute();
					apstm.close();

				}

				if ((invoiceamount - paid) == 0) {
					asql = "UPDATE inv_t_servicebilling SET CHR_PAYMENTSTATUS='Y' WHERE CHR_SALESNO='"
							+ Invoiceno + "' AND INT_BRANCHID=" + branch;
					st.execute(asql);
				}

				// Mail generation
				String divisionid = CommonFunctions
						.QueryExecute("SELECT INT_DIVIID from inv_t_servicebilling WHERE  CHR_SALESNO ='"
								+ Invoiceno + "'")[0][0];
				PaymentMail.sendServiceBillingPaymentAddMail(branchid,
						divisionid, Invoiceno, Path);

				con.close();
				response.sendRedirect("Smart Inventory/ServiceBillingPayment.jsp");

			}
			// Service Billing Payment Deletion
			else if ("INVServiceBillingPaymentDelete".equals(action)) {
				String invoicenos[] = request.getParameterValues("salesid");
				for (int u = 0; u < invoicenos.length; u++) {
					String invoiceno = invoicenos[u];
					asql = "DELETE FROM inv_t_servicebillingpayment WHERE CHR_SALESNO='"
							+ invoiceno + "' ";
					st.execute(asql);

					// Delete Second Commitment
					asql = " SELECT INT_PAYMENTCOMMITMENTID FROM inv_t_paymentcommitment ";
					asql = asql
							+ " WHERE  CHR_INVOICETYPE='S' AND CHR_SALESNO='"
							+ invoiceno + "'  ORDER BY INT_PAYMENTCOMMITMENTID";
					String crow = CommonFunctions.QueryExecute(asql)[0][0];
					System.out.println("======" + asql);
					asql = "DELETE FROM inv_t_paymentcommitment WHERE INT_PAYMENTCOMMITMENTID >? ";
					asql = asql + " AND   CHR_SALESNO=? AND  CHR_INVOICETYPE=?";
					apstm = con.prepareStatement(asql);
					apstm.setString(1, crow);
					apstm.setString(2, invoiceno);
					apstm.setString(3, "S");
					System.out.println("----------" + apstm);
					apstm.execute();
					apstm.close();

					asql = "UPDATE inv_t_paymentcommitment  SET DT_RECIEVEDDATE=null , ";
					asql = asql
							+ " DOU_RECEIVEDAMOUNT=0, CHR_PAYMENTFLAG='N' ,CHR_STATUS='Y' ";
					asql = asql + " WHERE INT_PAYMENTCOMMITMENTID = ?";
					asql = asql + " AND   CHR_SALESNO = ?";
					asql = asql + " AND  CHR_INVOICETYPE = ?";
					apstm = con.prepareStatement(asql);
					apstm.setString(1, crow);
					apstm.setString(2, invoiceno);
					apstm.setString(3, "S");
					apstm.execute();
					apstm.close();

					asql = "UPDATE inv_t_servicebilling SET CHR_NOOFPAYMENTCOMMITMENT=1 ,CHR_PAYMENTSTATUS='N' WHERE CHR_SALESNO='"
							+ invoiceno + "' ";
					st.execute(asql);

				}
				con.close();
				response.sendRedirect("Smart Inventory/ServiceBillingPayment.jsp");
			} else if ("INVServiceBillingPaymentEditDelete".equals(action)) {
				String invoiceno = request.getParameter("invoiceno");
				String row = request.getParameter("row");
				asql = "DELETE FROM inv_t_servicebillingpayment "
						+ "WHERE CHR_SALESNO='" + invoiceno
						+ "' AND INT_PAYMENTID=" + row;
				st.execute(asql);
				asql = "SELECT DOU_AMOUNT FROM inv_t_servicebilling "
						+ " WHERE CHR_SALESNO='" + invoiceno + "' ";
				String amounts[][] = CommonFunctions.QueryExecute(asql);
				double invoiceamount = 0.0;
				if (amounts.length > 0)
					invoiceamount = Double.parseDouble(amounts[0][0]);

				asql = "SELECT SUM(DOU_PAIDAMOUNT )FROM inv_t_servicebillingpayment "
						+ "WHERE CHR_SALESNO='" + invoiceno + "'";
				String datas[][] = CommonFunctions.QueryExecute(asql);

				double paid = 0.0;
				if (datas.length > 0)
					if (!"-".equals(datas[0][0]))
						paid = Double.parseDouble(datas[0][0]);

				if (((invoiceamount - paid) > 0)) {
					asql = "UPDATE inv_t_servicebilling SET CHR_PAYMENTSTATUS='P' WHERE CHR_SALESNO='"
							+ invoiceno + "'";
					st.execute(asql);
				}
				if (paid == 0) {
					asql = "UPDATE inv_t_servicebilling SET CHR_PAYMENTSTATUS='N' WHERE CHR_SALESNO='"
							+ invoiceno + "'";
					st.execute(asql);
				}

				if ((invoiceamount - paid) == 0) {
					asql = "UPDATE inv_t_servicebilling SET CHR_PAYMENTSTATUS='Y' WHERE CHR_SALESNO='"
							+ invoiceno + "'";
					st.execute(asql);
				}

				// Delete Second Commitment
				asql = " SELECT INT_PAYMENTCOMMITMENTID FROM inv_t_paymentcommitment ";
				asql = asql + " WHERE INT_PAYMENTID =" + row
						+ " AND    CHR_INVOICETYPE='S' AND CHR_SALESNO='"
						+ invoiceno + "' ";
				String crow = CommonFunctions.QueryExecute(asql)[0][0];

				asql = "DELETE FROM inv_t_paymentcommitment WHERE INT_PAYMENTCOMMITMENTID >? ";
				asql = asql + " AND   CHR_SALESNO=? AND  CHR_INVOICETYPE=?";
				apstm = con.prepareStatement(asql);
				apstm.setString(1, crow);
				apstm.setString(2, invoiceno);
				apstm.setString(3, "S");
				System.out.println("\n\n" + apstm);
				apstm.execute();
				apstm.close();

				asql = "UPDATE inv_t_paymentcommitment  SET DT_RECIEVEDDATE=null , ";
				asql = asql
						+ " DOU_RECEIVEDAMOUNT=0, CHR_PAYMENTFLAG='N' ,CHR_STATUS='N' ,INT_PAYMENTID =null ";
				asql = asql + " WHERE INT_PAYMENTID = ?";
				asql = asql + " AND   CHR_SALESNO = ?";
				asql = asql + " AND  CHR_INVOICETYPE = ?";
				apstm = con.prepareStatement(asql);
				apstm.setString(1, row);
				apstm.setString(2, invoiceno);
				apstm.setString(3, "S");
				System.out.println("\n\n" + apstm);
				apstm.execute();
				apstm.close();

				// reduce the No of commitment
				asql = " UPDATE inv_t_servicebilling SET CHR_NOOFPAYMENTCOMMITMENT = (CHR_NOOFPAYMENTCOMMITMENT-1) WHERE CHR_SALESNO =? ";
				apstm = con.prepareStatement(asql);
				apstm.setString(1, invoiceno);
				System.out.println("" + apstm);
				apstm.execute();
				apstm.close();

				con.close();
				response.sendRedirect("Smart Inventory/ServiceBillingPayment.jsp");
			}
			st.close();
		} catch (Exception e) {
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request
					.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
		}
	}

}