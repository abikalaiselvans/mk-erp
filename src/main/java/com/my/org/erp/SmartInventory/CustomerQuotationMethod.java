package com.my.org.erp.SmartInventory;
import java.io.IOException;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLWarning;


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.bean.inventory.*;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;
 

public class CustomerQuotationMethod extends HttpServlet
{
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -3781319210840309132L;

	 
	
	public static void addQuotation(Connection con , Quotation d, HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException 
	{
		try
		{			
			HttpSession session=request.getSession();			
			String userid=""+session.getAttribute("USRID");		
			String branchid=""+session.getAttribute("BRANCHID");
			String officeid=""+session.getAttribute("OFFICEID");
			String divisionid =""+d.getDivision();
			
			String quotationnumber=InventoryInvoiceFunctions.customerQuotationNumberGet(""+session.getAttribute("INVSTATE"),officeid,divisionid);
			
			String sql ="";
			String field="( DAT_CREATIONTIME,INT_BRANCHID, CHR_QUOTATIONNO,INT_CUSTOMERID," +
			"CHR_ADDRESSID1,CHR_ADDRESSFLAG,CHR_ADDRESSID2,DAT_QUOTATIONDATE , " +
			" DAT_REQUESTDATE,CHR_ONHOLD,INT_DIVIID, " +
			" INT_CONDITIONID,CHR_DES,CHR_REF , " +
			" INT_TAXID,DOU_AMOUNT,DOU_DISCOUNT,DOU_TAXAMOUNT , " +
			" DOU_TOTALAMOUNT, CHR_CONTACTDETAILS,CHR_CONTACTNO , " +
			" CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS)";
			sql = " INSERT INTO  inv_t_customerquotation  "+field+" VALUES ";
			sql = sql+" (NOW(),?,?,?,?,?,?,?,?,?,?,?, ?,?,?,?,?,  ?,?,?,?,?,DATE(NOW()),'Y') ";
			PreparedStatement pstm=con.prepareStatement(sql);
			pstm.setString(1, branchid);
			pstm.setString(2, quotationnumber);
			pstm.setString(3, ""+d.getCustomerId()) ;
			pstm.setString(4, d.getOrder());
			pstm.setString(5, d.getCopyaddress());
			pstm.setString(6, d.getShip());
			pstm.setString(7, DateUtil.FormateDateSQL(d.getQuoDate()));
			pstm.setString(8, DateUtil.FormateDateSQL(d.getReqDate()));
			pstm.setString(9, d.getHold());
			pstm.setString(10, ""+d.getDivision());
			pstm.setString(11, ""+d.getPayment());
			pstm.setString(12, d.getMemo());
			pstm.setString(13, d.getRef());
			pstm.setString(14, ""+d.getTax());
			pstm.setString(15, ""+d.getTotals());
			pstm.setString(16, ""+d.getTotaldiscount());
			pstm.setString(17, ""+d.getSalestaxamount());
			pstm.setString(18,""+d.getNettotal());
			pstm.setString(19,""+d.getCdetails());
			pstm.setString(20,""+d.getCnumber());
			pstm.setString(21, userid);
			
			System.out.println("=============="+pstm);
			pstm.execute(); 
			session.setAttribute("QUTNO", quotationnumber);
			//CUSTOMER QUOTATION NUMBER INSERT
			pstm=con.prepareStatement("  SELECT FUN_INV_GET_QUOTATION_NUMBER_INSERT(?) ");
			pstm.setString(1,""+session.getAttribute("INVSTATE"));
			pstm.execute();
			pstm.close();
			 
			
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 		
		}
	}
	public static void addQuotationUpdate(Connection con , Quotation d, HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException 
	{
		try
		{			
			HttpSession session=request.getSession();			
			String userid=""+session.getAttribute("USRID");		
			String sql ="";
			sql = " UPDATE   inv_t_customerquotation  SET ";
			sql = sql +" INT_CUSTOMERID = ?,  ";
			sql = sql +" CHR_ADDRESSID1=? , ";
			sql = sql +" CHR_ADDRESSID2=? , ";
			sql = sql +" DAT_QUOTATIONDATE=? ,";
			sql = sql +" DAT_REQUESTDATE=? ,";
			sql = sql +" CHR_ONHOLD= ? ,";
			sql = sql +" INT_DIVIID= ? ,";
			sql = sql +" INT_CONDITIONID=?," ;
			sql = sql +" CHR_DES=? , ";
			sql = sql +" CHR_REF=? , ";
			sql = sql +" INT_TAXID=? ," ;
			sql = sql +" DOU_AMOUNT= ? ," ;
			sql = sql +" DOU_DISCOUNT= ? ," ;
			sql = sql +" DOU_TAXAMOUNT= ? , " ;
			sql = sql +" DOU_TOTALAMOUNT= ? , " ;
			sql = sql +" CHR_CONTACTDETAILS= ? , " ;
			sql = sql +" CHR_CONTACTNO= ? , " ;
			sql = sql +" CHR_ADDRESSFLAG= ? , " ;
			sql = sql +" CHR_USRNAME=? ";
			sql=sql+" WHERE CHR_QUOTATIONNO=?";
			
			PreparedStatement pstm=con.prepareStatement(sql);
			pstm.setString(1, ""+d.getCustomerId()) ;
			pstm.setString(2, d.getOrder());
			pstm.setString(3, d.getShip());
			pstm.setString(4, DateUtil.FormateDateSQL(d.getQuoDate()));
			pstm.setString(5, DateUtil.FormateDateSQL(d.getReqDate()));
			pstm.setString(6, ""+d.getHold()); 
			pstm.setString(7, ""+d.getDivision());
			pstm.setString(8, ""+d.getPayment());
			pstm.setString(9, d.getMemo());
			pstm.setString(10, d.getRef());
			pstm.setString(11, ""+d.getTax());
			pstm.setString(12, ""+d.getTotals());
			pstm.setString(13, ""+d.getTotaldiscount());
			pstm.setString(14, ""+d.getSalestaxamount());
			pstm.setString(15,""+d.getNettotal());
			pstm.setString(16,""+d.getCdetails());
			pstm.setString(17,""+d.getCnumber());
			pstm.setString(18,""+d.getCopyaddress());
			pstm.setString(19, userid);
			pstm.setString(20, d.getQuotationId());
			System.out.println(""+pstm);
			pstm.execute(); 
			 
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
    	}
	}
	 
	public static boolean addQuotationSalesOrder(Connection con ,PreparedStatement apstm,  QuotationSaleOrder d,String  salesordernumber, HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException 
	{
		try
		{			
			HttpSession session=request.getSession();	
			String userid=""+session.getAttribute("USRID");	
			String branchid = session.getAttribute("INVBRANCH").toString();
			String asql="";
			String field="( ";
			field = field+ " DAT_CREATIONTIME,INT_BRANCHID,CHR_QUOTATIONNO,CHR_SALESORDERNO,INT_CUSTOMERID," ;
			field = field+ " CHR_CUSTPURCHASENO,CHR_PURCHASEORDER_DATE,CHR_DELIVERY_DATE," ;
			field = field+ " DAT_SALEDATE , CHR_DELIVERYSTATUS,CHR_BILLINGADDRESS,CHR_SHIPINGADDRESS, ";
			field = field+ " CHR_ONHOLD,INT_PAYMENTTERMID,CHR_DES,CHR_REF,INT_REF_PERCENTAGE1, " ;
			field = field+ " CHR_REF1,INT_REF_PERCENTAGE2, " ;
			field = field+ " CHR_REF2,INT_REF_PERCENTAGE3, " ;
			field = field+ " CHR_INVOICEBLOCK, " ;
			field = field+ " CHR_BYBACK,CHR_BYBACKDESC,DOU_BYBACKAMOUNT, " ;
			field = field+ " INT_TAXID,DOU_AMOUNT,DOU_DISCOUNT,DOU_TAXAMOUNT , " ;
			field = field+ " DOU_TOTALAMOUNT,CHR_PAYMENTSTATUS, INT_PAYMENT_COMMITMENT_DAYS,INT_DIVIID,";
			field = field+ " CHR_CONTACTDETAILS,CHR_CONTACTNO,";
			field = field+ " CHR_OTHERREF,CHR_DELIVERYNOTE,CHR_DESPATCHTHRU, ";
			field = field+ " CHR_DESTINATION,CHR_TERMSOFDELIVERY, ";
			field = field+ " CHR_TAXTYPE,INT_PROJECTID,CHR_INSTALLATION, ";
			field = field+ " CHR_MULTIPLE_LOCATION, ";
			field = field+ " CHR_ADDRESSFLAG,CHR_MULTIPLE_BILL,CHR_PARTIAL_BILL,";
			field = field+ " CHR_BG,CHR_DELIVERY, CHR_STOCKTYPE, ";
			field = field+ " CHR_DEMURRAGE,DOU_DEMARRAGE_PERCENTAGE,INT_DEMARRAGE_DAYS, ";
			field = field+ " CHR_USRNAME,DAT_DEMARRAGE_DATE,DT_UPDATEDATE,CHR_UPDATESTATUS ,INT_CPO_STATUS, ";
			field = field+ " DT_CUSTPORECEIVEDDATE )";
			
			/*INT_REF_PERCENTAGE1
			CHR_REF1,INT_REF_PERCENTAGE2
			CHR_REF2,INT_REF_PERCENTAGE3,
			CHR_INVOICEBLOCK,CHR_BYBACK,CHR_BYBACKDESC,DOU_BYBACKAMOUNT
			*/
			
			asql = " INSERT INTO  inv_t_customersalesorder   "+field+" VALUES (";
			asql = asql +" NOW(), ?,?,?,?," ;
			asql = asql +" ?,?,?,";
			asql = asql +" DATE(NOW()) ,  'N',?,";
			asql = asql +" ?, ?,?,?,?, ?," ;
			asql = asql +"  ?,?, " ;
			asql = asql +"  ?,?, " ;
			asql = asql +"  ?, " ;
			asql = asql +"  ?,?,?, " ;
			asql = asql +"  ?,?,?,? , " ;
			asql = asql +"  ?,'N', ?,?,?,?, ?,?,?,?,?,?,?,?,?,";
			asql = asql +" ?,?,?,?,?,?,?,?,?,?,";
			if("Y".equals(d.getDemurrage()))
				asql = asql +" DATE(DATE_ADD('"+DateUtil.FormateDateSQL(d.getDeliverydate())+"', INTERVAL "+d.getDemurragedays()+" DAY)), ";
			else
				asql = asql +" NULL , ";
			asql = asql +" DATE(NOW()),'Y' ,?,?";  
			asql = asql +" ) ";
			apstm = con.prepareStatement(asql);
			apstm.setString(1,branchid);
			apstm.setString(2,d.getQuotationid() );
			apstm.setString(3,salesordernumber );
			apstm.setString(4,d.getCustomerid());
			apstm.setString(5,d.getCustponumber() );
			apstm.setString(6,DateUtil.FormateDateSQL(d.getPodate()));
			apstm.setString(7,DateUtil.FormateDateSQL(d.getDeliverydate()));
			apstm.setString(8,d.getBillingto());
			apstm.setString(9,d.getShipingto());
			apstm.setString(10,d.getHold());
			apstm.setString(11,d.getPayment());
			apstm.setString(12,d.getDescriptions());
			apstm.setString(13,d.getRef());
			apstm.setString(14,""+d.getPercentage());
			apstm.setString(15,d.getRef1());
			apstm.setString(16,""+d.getPercentage1());
			apstm.setString(17,d.getRef2());
			apstm.setString(18,""+d.getPercentage2());
			apstm.setString(19,d.getBlockinvoice());
			apstm.setString(20,d.getByback());
			apstm.setString(21,d.getBybackdescription());
			apstm.setString(22,""+d.getBybackamount());
			apstm.setString(23,d.getTax());
			apstm.setString(24,d.getTotals());
			apstm.setString(25,d.getTotaldiscount());
			apstm.setString(26,d.getSalestaxamount());
			apstm.setString(27,d.getNettotal());
			apstm.setString(28,d.getCommitmentdays());
			apstm.setString(29,d.getDivision());
			apstm.setString(30,d.getCdetails());
			apstm.setString(31,d.getCnumber());
			apstm.setString(32,d.getOref());
			apstm.setString(33,d.getDnote());
			apstm.setString(34,d.getDthru());
			apstm.setString(35,d.getDestination());
			apstm.setString(36,d.getTdelivery());
			apstm.setString(37,d.getTaxtype());
			apstm.setString(38,d.getProject());
			apstm.setString(39,d.getInstallation());
			apstm.setString(40,d.getMultipleloaction());
			apstm.setString(41,d.getCopyaddress());
			apstm.setString(42,d.getMultiplebill());
			apstm.setString(43,d.getPartialbill());
			apstm.setString(44,d.getBankguarantee());
			apstm.setString(45,d.getDelivery());
			apstm.setString(46,d.getStocktype());
			apstm.setString(47,d.getDemurrage());
			apstm.setString(48,""+d.getDemurragepercentage());
			apstm.setString(49,""+d.getDemurragedays());
			apstm.setString(50,userid);
			apstm.setString(51,""+d.getCpostatus());
			apstm.setString(52,""+DateUtil.FormateDateSQL(d.getPoreceiveddate()));
			System.out.println(""+apstm );
			apstm.execute();
			apstm.close();
			
			//CUSTOMER SALES ORDER NUMBER INSERT
			apstm=con.prepareStatement("  SELECT FUN_INV_CUSTOMER_SALEORDER_NUMBER_INSERT(?) ");
			apstm.setString(1,""+session.getAttribute("INVSTATE"));
			apstm.execute();
			apstm.close();
			
			return true;
			
					 
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 		
		}
		return false;
	}
	
	 
}

