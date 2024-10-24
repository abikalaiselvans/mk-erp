package com.my.org.erp.SmartInventory;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
 


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.bean.inventory.DirectPurchase;
import com.my.org.erp.bean.inventory.Purchase;
import com.my.org.erp.common.CommonFunctions;
import com.my.org.erp.ServiceLogin.DateUtil;
public class DirectPurchaseMethod extends HttpServlet
{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 5836713030790907573L;



	public synchronized static void addDirectPurchase(Connection con ,PreparedStatement apstm, DirectPurchase d, HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException 
	{
		try
		{			
			HttpSession session=request.getSession();			
			String userid=""+session.getAttribute("USRID");		
			String branchid=""+session.getAttribute("INVBRANCH");
			String sql ="";
			String dt =DateUtil.getCurrentDateTime() ;
			String officeid=""+session.getAttribute("OFFICEID");
			String divisionid =""+d.getDivision();
			String invbranchstateid = session.getAttribute("INVBRANCHSTATEID").toString();
			sql = " SELECT INT_STATEID FROM inv_m_vendorsinformation WHERE INT_VENDORID = "+d.getVendorid();
			String gststateid = "S";
			if(invbranchstateid.equalsIgnoreCase(CommonFunctions.QueryExecute(sql)[0][0]))
				gststateid = "S" ;
			else
				gststateid = "D";
			
			//String ponumber="PO/"+InventoryInvoiceFunctions.accountYear()+InventoryInvoiceFunctions.directPurchasePONumber()+"/"+InventoryInvoiceFunctions.invoiceLocation(officeid)+"/"+InventoryInvoiceFunctions.invoiceDivision(divisionid);
			
			String ponumber =  InventoryInvoiceFunctions.directPurchaseNumberGet(""+session.getAttribute("INVSTATE"),officeid,divisionid);
			//System.out.println(ponumber);
			String field="( DAT_ACTUALINWARD,INT_BRANCHID,CHR_PURCHASEORDERNO,INT_VENDORID,DAT_ORDERDATE,INT_PAYMENTTERMID,";
			field = field+"	CHR_DES,CHR_REF,INT_TAXID,DOU_AMOUNT,DOU_DISCOUNT,DOU_TAXAMOUNT,";
			field = field+"	DOU_TOTALAMOUNT,DOU_PAIDAMOUNT,CHR_USRNAME,";
			field = field+"	DT_UPDATEDATE,CHR_UPDATESTATUS ,CHR_POREQUESTNO,CHR_FLAG,INT_DIVIID,";
			field = field+"	CHR_VENDORPO,DOU_ROUNDED,DOU_BASEAMOUNT , CHR_BASEVALUE,CHR_GST_TYPE, ";
			field = field+"	DOU_FRIEGHT_CHARGE_BASE_AMOUNT,DOU_FRIEGHT_CHARGE_PERCENT, DOU_FRIEGHT_CHARGE)";
			sql = " INSERT INTO inv_t_directpurchase "+field+" VALUES (";
			sql = sql +"NOW(),?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			apstm=con.prepareStatement(sql);
			apstm.setString(1, branchid);
			apstm.setString(2, ponumber);
			apstm.setString(3, ""+d.getVendorid());
			apstm.setString(4, DateUtil.FormateDateSQL(d.getSaleDate()));
			apstm.setString(5, ""+d.getPayment());
			apstm.setString(6, d.getMemo());
			apstm.setString(7, d.getRef());
			apstm.setString(8, ""+d.getTax());
			apstm.setDouble(9, d.getTotals());
			apstm.setDouble(10, d.getTotaldiscount());
			apstm.setDouble(11, d.getSalestaxamount());
			apstm.setDouble(12, d.getNettotal());
			apstm.setString(13, "0");
			apstm.setString(14, userid);
			apstm.setString(15,dt);
			apstm.setString(16, "Y");	
			apstm.setString(17, d.getPurchaserequest());
			apstm.setString(18, "N");
			apstm.setString(19, ""+d.getDivision());
			apstm.setString(20, d.getCashSaleNo());
			apstm.setString(21,""+ d.getRoundedoption());
			apstm.setString(22,""+d.getBasevalue()); 
			apstm.setString(23,d.getBasevaluecheck()); 
			apstm.setString(24, gststateid);
			apstm.setString(25, ""+d.getFrieghtamount()); 
			apstm.setString(26, ""+d.getFrieghttax()); 
			apstm.setString(27, ""+d.getFrieghtcharge()); 
			System.out.println(""+apstm);
			apstm.execute();
			
			session.setAttribute("PONO", ponumber);
			
			apstm=con.prepareStatement("  SELECT FUN_INV_DIRECT_PURCHASENUMBER_INSERT(?) ");
			apstm.setString(1,""+session.getAttribute("INVSTATE"));
			apstm.execute();
			apstm.close();
			 
			sql = "UPDATE inv_t_directsales SET CHR_BYBACKINWARD='Y' WHERE CHR_SALESNO = ";
			sql = sql+ "(SELECT CHR_SALESNO FROM inv_t_purchaserequest WHERE CHR_BYBACK ='Y' AND CHR_POREQUESTNO =?) ";
			apstm=con.prepareStatement(sql);
			apstm.setString(1,d.getPurchaserequest());
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
	
	
	
	public synchronized  static void addPurchase(String ponumber,Connection con ,  Purchase d, HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException 
	{
		try
		{			
			HttpSession session=request.getSession();			
			String userid=""+session.getAttribute("USRID");		
			String branchid=""+session.getAttribute("INVBRANCH");
			String sql ="";
			
			String dt =DateUtil.getCurrentDateTime() ;
		 
			String field="(INT_BRANCHID,CHR_PURCHASEORDERNO,INT_VENDORID,DAT_ORDERDATE ,DAT_REQUESTDATE, " +
			" INT_ADDRESSID1,INT_ADDRESSID2,INT_ONHOLD,INT_CONDITIONID,INT_PAYMENTTERMID,CHR_DES,CHR_REF ,CHR_DISCOUNT, " +
			" INT_TAXID,DOU_AMOUNT,DOU_TAXAMOUNT , DOU_FRIEGHT_CHARGE, " +
			" DOU_TOTALAMOUNT,INT_PURCHASESTATUS, " +
			" CHR_PAYMENTSTATUS,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS,  INT_DIVIID ,CHR_POREQUESTNO)";
			sql = " INSERT INTO  inv_t_vendorpurchaseorder  "+field+" VALUES ";
			sql = sql+" (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?  ) ";
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setString(1, branchid);
			ps.setString(2, ponumber);
			ps.setString(3, d.getVendorid());
			ps.setString(4, DateUtil.FormateDateSQL(d.getOrderdate()));
			ps.setString(5, DateUtil.FormateDateSQL(d.getRequestdate()));
			ps.setString(6, d.getOrder() );
			ps.setString(7, d.getShip());
			ps.setString(8, d.getHold());
			ps.setString(9, d.getPayment());
			ps.setString(10,d.getPaymentterm());
			ps.setString(11, d.getMemo());
			ps.setString(12, d.getRef());
			ps.setString(13, d.getTotaldiscount());
			ps.setString(14, d.getTax());
			ps.setString(15, d.getTotals());
			double taxamount = (Double.parseDouble(d.getSalestax())/100)*Double.parseDouble(d.getTotals());
			ps.setDouble(16, taxamount);
			ps.setDouble(17, d.getFrieghtcharge());
			ps.setString(18, ""+Math.round(Double.parseDouble(d.getNettotal())));
			ps.setInt(19, 0);
			ps.setString(20, "N");
			ps.setString(21, userid);
			ps.setString(22, dt);
			ps.setString(23, "Y");
			ps.setString(24, d.getDivision());
			ps.setString(25, d.getPurchaserequest());
			System.out.println(""+ps);
			ps.execute();
			
			 
			ps=con.prepareStatement("  SELECT FUN_INV_PURCHASEORDER_NUMBER_INSERT(?) ");
			ps.setString(1,""+session.getAttribute("INVSTATE"));
			ps.execute();
			ps.close();
			 
					 
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
					
		}
	}
	
	public synchronized static void addPurchaseUpdate(String ponumber,Connection con ,  Purchase d, HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException 
	{
		try
		{			
			HttpSession session=request.getSession();			
			String userid=""+session.getAttribute("USRID");		
			
			String sql ="";
			
			String dt =DateUtil.getCurrentDateTime() ;
		 
			sql = " UPDATE inv_t_vendorpurchaseorder SET ";
			sql = sql +" INT_VENDORID = ?,";
			sql = sql +" DAT_ORDERDATE = ?,";
			sql = sql +" DAT_REQUESTDATE = ?,";
			sql = sql +" INT_ADDRESSID1 = ?,";
			sql = sql +" INT_ADDRESSID2 = ?,";
			sql = sql +" INT_ONHOLD = ?,";
			sql = sql +" INT_CONDITIONID = ?,";
			sql = sql +" INT_PAYMENTTERMID = ?,";
			sql = sql +" CHR_DES = ?,";
			sql = sql +" CHR_REF = ?,";
			sql = sql +" CHR_DISCOUNT = ?,";
			sql = sql +" INT_TAXID = ?,";
			sql = sql +" DOU_AMOUNT = ?,";
			sql = sql +" DOU_TAXAMOUNT = ?,";
			sql = sql +" DOU_TOTALAMOUNT = ?,";
			sql = sql +" INT_PURCHASESTATUS = ?,";
			sql = sql +" CHR_PAYMENTSTATUS = ?,";
			sql = sql +" CHR_USRNAME = ?,";
			sql = sql +" DT_UPDATEDATE = ?,";
			sql = sql +" CHR_UPDATESTATUS = ?,";
			sql = sql +" INT_DIVIID = ? ,";
			sql = sql +" CHR_VERIFIED = ? ,";
			sql = sql +" CHR_VERIFIEDID=?, ";
			sql = sql +" DAT_VERIFIEDDATE= DATE(NOW()) ";
			sql = sql +" WHERE CHR_PURCHASEORDERNO =?";
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setString(1, d.getVendorid());
			ps.setString(2, DateUtil.FormateDateSQL(d.getOrderdate()));
			ps.setString(3, DateUtil.FormateDateSQL(d.getRequestdate()));
			ps.setString(4, d.getOrder());
			ps.setString(5, d.getShip());
			if((""+d.getHold()).equals("true"))
				ps.setInt(6, 1);
			else
				ps.setInt(6, 0);
			ps.setString(7, d.getPayment());
			ps.setString(8,d.getPaymentterm());
			ps.setString(9, d.getMemo());
			ps.setString(10, d.getRef());
			ps.setString(11, d.getTotaldiscount());
			ps.setString(12, d.getTax());
			ps.setString(13, d.getTotals());
			double taxamount = (Double.parseDouble(d.getSalestax())/100)*Double.parseDouble(d.getTotals());
			ps.setDouble(14, taxamount);
			ps.setString(15,d.getNettotal());
			ps.setInt(16, 0);
			ps.setString(17, "N");
			ps.setString(18, userid);
			ps.setString(19, dt);
			ps.setString(20, "Y");
			ps.setString(21, d.getDivision());
			ps.setString(22, d.getVerified());
			ps.setString(23, userid);
			ps.setString(24, ponumber);
			System.out.println(""+ps);
			ps.execute();
			
			
					 
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

