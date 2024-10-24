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

public class ServiceBillingPOActionHandler extends AbstractActionHandler 
{
	public synchronized void handle(HttpServletRequest request,	HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String action = "" + request.getParameter("actionS").trim();
			HttpSession session = request.getSession();
			String branchid = session.getAttribute("BRANCHID").toString();
			String user = session.getAttribute("USRID").toString();
			String officeid = "" + session.getAttribute("OFFICEID");
			Statement st = con.createStatement();
			if ("INVServiceBillingAdd".equals(action)) 
			{

				String divis = request.getParameter("divis");
				String SaleNo = "";
				String saleDate = request.getParameter("saleDate");
				String saleDate2 = request.getParameter("saleDate2");
				saleDate = DateUtil.FormateDateSQL(saleDate);
				saleDate2 = DateUtil.FormateDateSQL(saleDate2);
				String customer = request.getParameter("customer");
				String ref = request.getParameter("ref");
				String memo = request.getParameter("memo");
				@SuppressWarnings("unused")
				String dt = request.getParameter("saleDate");
				String amount = request.getParameter("totals");
				String Shipping = request.getParameter("Shipping");
				String shippingaddress = request.getParameter("shippingaddress");
				SaleNo = InventoryInvoiceFunctions.servicePONumberGet(officeid,divis);
				asql = " INSERT INTO inv_t_servicebillingpo  ( ";
				asql = asql	+ " INT_BRANCHID,INT_DIVIID,CHR_SERVICEPOREF,DAT_PODATE,DAT_POENDDATE, ";
				asql = asql	+ " INT_CUSTOMERID,CHR_SHIPPING,CHR_SHIPPINGADDRESS,CHR_REF, ";
				asql = asql	+ " CHR_DES,DOU_AMOUNT,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS ";
				asql = asql	+ " ) ";
				asql = asql	+ " VALUES (?,?,?,? ,?,?,?,?,?,?,?,?,DATE(NOW()),'Y') ";
				apstm = con.prepareStatement(asql);
				apstm.setString(1, branchid);
				apstm.setString(2, divis);
				apstm.setString(3, SaleNo);
				apstm.setString(4, saleDate);
				apstm.setString(5, saleDate2);
				apstm.setString(6, customer);
				apstm.setString(7, Shipping);
				apstm.setString(8, shippingaddress);
				apstm.setString(9, ref);
				apstm.setString(10, memo);
				apstm.setString(11, amount);
				apstm.setString(12, auserid);
				System.out.println("" + apstm);
				apstm.execute();
				apstm.close();
				con.close();
				response.sendRedirect("Smart Inventory/ServiceBillingPO.jsp");
			}
			else if ("INVServiceBillingEdit".equals(action)) 
			{
				String rowid = request.getParameter("rowid").trim();
				String saleDate = request.getParameter("saleDate").trim();
				saleDate = DateUtil.FormateDateSQL(saleDate).trim();
				String saleDate2 = request.getParameter("saleDate2").trim();
				saleDate2 = DateUtil.FormateDateSQL(saleDate2).trim();
				
				String customer = request.getParameter("customer").trim();
				String ref = request.getParameter("ref").trim();
				String memo = request.getParameter("memo").trim();
				String totals = request.getParameter("totals").trim();
				String Shipping = request.getParameter("Shipping").trim();
				String shippingaddress = request.getParameter("shippingaddress").trim();
				asql = "UPDATE inv_t_servicebillingpo SET ";
				asql = asql + " DAT_PODATE = ? ,";
				asql = asql + " DAT_POENDDATE = ? ,";
				asql = asql + " INT_CUSTOMERID = ?,";
				asql = asql + " CHR_REF = ?,";
				asql = asql + " CHR_DES = ?,";
				asql = asql + " DOU_AMOUNT = ? ,";
				asql = asql + " CHR_SHIPPING =?,";
				asql = asql + " CHR_SHIPPINGADDRESS=?,";
				asql = asql + " WHERE INT_SERVICEPOID=? ";

				apstm = con.prepareStatement(asql);
				apstm.setString(1, saleDate);
				apstm.setString(2, saleDate2);
				apstm.setString(3, customer);
				apstm.setString(4, ref);
				apstm.setString(5, memo);
				apstm.setString(6, totals);
				apstm.setString(7, Shipping);
				apstm.setString(8, shippingaddress);
				apstm.setString(9, rowid);
				System.out.println("" + apstm);
				apstm.execute();
				apstm.close();
 
				con.close();
				response.sendRedirect("Smart Inventory/ServiceBillingPO.jsp");
			}
			else if ("INVServiceBillingDelete".equals(action)) 
			{
				String saleno = "" + request.getParameter("saleno");
				String reason = "" + request.getParameter("reason");
				String email = "" + request.getParameter("email");
				String salno[] = (saleno + ",").split(",");
				for (int u = 0; u < salno.length; u++) 
				{
					asql = " DELETE FROM inv_t_servicebillingpo WHERE CHR_STATUS ='N' AND CHR_CANCEL='N' AND INT_SERVICEPOID=?";
					apstm = con.prepareStatement(asql);
					apstm.setString(1, salno[u]);
					apstm.execute();
					apstm.close();

					// Send a mail for Delete invoice
					/*String a[] = (email + "," + CommonData.mailid).split(",");
					com.my.org.erp.mail.Mail.SimpleHTMLMail(a,
							"DELETE  SERVICE BILLING :: " + salno[u],
							InvoiceDeletetMail.InvoiceDeletesendtoMail(
									"DELETE  SERVICE BILLING :: " + salno[u],
									salno[u], reason, "SERVICE BILLING"));
					*/
				}
				

				
				con.close();
				response.sendRedirect("Smart Inventory/ServiceBillingPO.jsp");
			} 
			else if ("INVServiceBillingCancel".equals(action)) 
			{
				String saleno = request.getParameter("salesid");
				String reason = request.getParameter("reason");
				asql = "UPDATE inv_t_servicebillingPO SET DOU_CANCELAMOUNT=DOU_AMOUNT ,  DOU_AMOUNT=0, CHR_CANCEL='Y',CHR_CANCELDESC=?, CHR_CANCELID=?,DAT_CANCELDATE=NOW() WHERE CHR_SERVICEPOREF=?";
				apstm = con.prepareStatement(asql);
				apstm.setString(1, reason);
				apstm.setString(2, "" + session.getAttribute("EMPID"));
				apstm.setString(3, saleno);
				apstm.execute();
				apstm.close();
				con.close();

				// Send a mail for Delete invoice
				/*
				String email = "" + request.getParameter("email");
				String a[] = (email + "," + CommonData.mailid).split(",");
				com.my.org.erp.mail.Mail.SimpleHTMLMail(a,"CANCELL  SERVICE BILLING :: " + saleno,	InvoiceDeletetMail.InvoiceCancellsendtoMail("CANCELL SERVICE BILLING :: " + saleno, saleno,	reason, "SERVICE BILLING"));
				*/
				response.sendRedirect("Smart Inventory/ServiceBillingPO.jsp");
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