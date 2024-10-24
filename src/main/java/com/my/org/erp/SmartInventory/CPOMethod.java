package com.my.org.erp.SmartInventory;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLWarning;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.DateUtil;

public class CPOMethod 
{
	public static synchronized void addSwapSale(Connection con ,PreparedStatement apstm, com.my.org.erp.bean.inventory.SwapSale d, HttpServletRequest request, HttpServletResponse response) throws IOException,SQLWarning, ServletException 
	{
		try
		{			
			HttpSession session=request.getSession();	
			
			String userid=""+session.getAttribute("USRID");	
			String branchid = session.getAttribute("BRANCHID").toString();
			String officeid=""+session.getAttribute("OFFICEID");
			String divisionid =d.getDivision();
			//String invoicenumber="IN/"+InventoryInvoiceFunctions.accountYear()+InventoryInvoiceFunctions.directSalesinvoiceNumber(""+session.getAttribute("INVSTATE"))+"/"+InventoryInvoiceFunctions.invoiceLocation(officeid)+"/"+InventoryInvoiceFunctions.invoiceDivision(divisionid);
			
			String invoicenumber=InventoryInvoiceFunctions.directSalesNumberGet(branchid,""+session.getAttribute("INVSTATE"),officeid,divisionid);
			System.out.println(invoicenumber);
			
			
			String sql ="";
			String payment ="N";
			String dt =DateUtil.getCurrentDateTime() ;
			String field = " (INT_BRANCHID,CHR_SALESNO,DAT_SALESDATE,INT_PAYMENTTERMID, ";
			field = field+"	INT_CUSTOMERID,	CHR_DES,CHR_REF,DOU_AMOUNT,DOU_DISCOUNT,INT_TAXID, ";
			field = field+"	DOU_TAXAMOUNT,DOU_TOTALAMOUNT,INT_SALESSTATUS,CHR_PAYMENTSTATUS, CHR_SALESTYPE,";
			field = field+"	CHR_SHIPPING,CHR_SHIPPINGADDRESS,CHR_OTHERREF ,";
			field = field+"	CHR_DELIVERYNOTE,CHR_DESPATCHTHRU,CHR_DESTINATION,";
			field = field+"	CHR_TERMSOFDELIVERY,CHR_CONTACTDETAILS ,CHR_CONTACTNO,";
			field = field+"	CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS,INT_DIVIID,";
			field = field+"	CHR_NOOFPAYMENTCOMMITMENT,CHR_BYBACK,CHR_BYBACKDESC,";
			field = field+"	DOU_BYBACKAMOUNT,CHR_INSTALLATION,CHR_INVOICEBLOCK,  ";
			field = field+"	INT_PAYMENT_COMMITMENT_DAYS,CHR_TAXTYPE,CHR_REF1,CHR_REF2,";
			field = field+"	INT_REF_PERCENTAGE1,INT_REF_PERCENTAGE2,INT_REF_PERCENTAGE3,";
			field = field+"	INT_PROJECTID,CHR_ROOT,CHR_CPONUMBER) ";
			sql = " INSERT INTO inv_t_directsales "+field+" VALUES (";
			sql = sql +"?,?,?,?,?,?,?,?,?,?,";
			sql = sql +"?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,? , ";
			sql = sql +"?,?,?,?,";
			sql = sql +"?,?,?,?,?,? ) ";
		
			apstm=con.prepareStatement(sql);
			apstm.setInt(1, Integer.parseInt(branchid));
			apstm.setString(2, invoicenumber);
			apstm.setString(3, DateUtil.FormateDateSQL(d.getSaleDate()));
			apstm.setString(4,  d.getPayment() );
			apstm.setString(5, d.getCustomerId() );
			apstm.setString(6, d.getMemo());
			apstm.setString(7, d.getRef());
			apstm.setString(8 ,""+d.getTotals() );
			apstm.setString(9,""+d.getTotaldiscount() );
			apstm.setString(10,""+d.getTax());
			apstm.setString(11,""+d.getSalestaxamount());
			apstm.setString(12,""+d.getNettotal());
			apstm.setInt(13, 0);
			apstm.setString(14,payment);
			apstm.setString(15,"D");
			apstm.setString(16,request.getParameter("Shipping"));
			apstm.setString(17,d.getShippingaddress());
			apstm.setString(18,d.getOref());
			apstm.setString(19,d.getDnote());
			apstm.setString(20,d.getDthru());
			apstm.setString(21,d.getDestination());
			apstm.setString(22,d.getTdelivery());
			apstm.setString(23,d.getCdetails());
			apstm.setString(24,d.getCnumber() );//request.getParameter("cnumber")
			apstm.setString(25, userid);
			apstm.setString(26,dt);
			apstm.setString(27, "Y");	
			apstm.setString(28, ""+d.getDivision());	
			apstm.setString(29, ""+d.getNoofpaymentcommitment());
			apstm.setString(30, d.getByback());
			apstm.setString(31, d.getBybackdescription());
			apstm.setString(32, ""+d.getBybackamount());
			apstm.setString(33, d.getInstallation());
			apstm.setString(34, d.getBlockinvoice());
			apstm.setString(35,""+d.getCommitmentdays());
			apstm.setString(36,d.getTaxtype());
			apstm.setString(37,d.getRef1());
			apstm.setString(38,d.getRef2());
			apstm.setString(39,""+d.getPercentage());
			apstm.setString(40,""+d.getPercentage1());
			apstm.setString(41,""+d.getPercentage2());
			apstm.setString(42,""+d.getProject());
			apstm.setString(43,"C" );
			apstm.setString(44,d.getCporeference() );
			System.out.println(""+apstm);
			apstm.execute();
			session.setAttribute("INVNO", invoicenumber);
			
			
			//DIRECT SALE INVOICE NUMBER INSERT
			apstm=con.prepareStatement("  SELECT FUN_INV_DIRECT_SALESNUMBER_INSERT(?) ");
			apstm.setString(1,""+session.getAttribute("INVSTATE"));
			apstm.execute();
			apstm.close();
			
		}
		
		catch(Exception e)
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
							
		}
	}
	
}
