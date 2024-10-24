package com.my.org.erp.SmartInventory;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.bean.inventory.SparePurchase;
import com.my.org.erp.ServiceLogin.DateUtil;
public class SparePurchaseMethod extends HttpServlet
{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 5836713030790907573L;



	public static void addSparePurchase(Connection con , SparePurchase d, HttpServletRequest request, HttpServletResponse response) throws IOException 
	{
		try
		{			
			HttpSession session=request.getSession();			
			String userid=""+session.getAttribute("USRID");		
			String branchid=""+session.getAttribute("BRANCHID");
			String sql ="";
			String dt =DateUtil.getCurrentDateTime() ;
			String officeid=""+session.getAttribute("OFFICEID");
			String divisionid =d.getDivision();
			String ponumber="SP/"+InventoryInvoiceFunctions.accountYear()+InventoryInvoiceFunctions.sparePurchaseNumber()+"/"+InventoryInvoiceFunctions.invoiceLocation(officeid)+"/"+InventoryInvoiceFunctions.invoiceDivision(divisionid);
			String field="( INT_BRANCHID,CHR_PURCHASENO,INT_VENDORID,DAT_ORDERDATE,INT_PAYMENTTERMID,";
			field = field+"	CHR_DES,CHR_REF,INT_TAXID,DOU_AMOUNT,DOU_DISCOUNT,DOU_TAXAMOUNT,";
			field = field+"	DOU_TOTALAMOUNT,CHR_USRNAME,";
			field = field+"	DT_UPDATEDATE,CHR_UPDATESTATUS ,CHR_FLAG,INT_DIVIID,CHR_VENDORPO)";
			sql = " INSERT INTO inv_t_sparepurchase "+field+" VALUES (";
			sql = sql +"?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,? )";
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setString(1,branchid);
			ps.setString(2, ponumber);
			ps.setString(3,d.getVendorid());
			ps.setString(4, DateUtil.FormateDateSQL(d.getSaleDate()));
			ps.setString(5,d.getPayment());
			ps.setString(6, d.getMemo());
			ps.setString(7, d.getRef());
			ps.setString(8,d.getTax());
			ps.setString(9,d.getTotals());
			ps.setString(10,d.getTotaldiscount());
			ps.setString(11,d.getSalestaxamount());
			ps.setString(12,d.getNettotal());
			ps.setString(13, userid);
			ps.setString(14,dt);
			ps.setString(15, "Y");	
			ps.setString(16, "N");
			ps.setString(17,d.getDivision());
			ps.setString(18, d.getCashSaleNo());
			System.out.println(""+ps);
			ps.execute();
			session.setAttribute("PONO", ponumber);
			sql=" INSERT INTO inv_m_sparegenerate VALUES (?)";
			ps=con.prepareStatement(sql);
			ps.setString(1,InventoryInvoiceFunctions.sparePurchaseNumber());
			System.out.println(""+ps);
			ps.execute();
			ps.close();
			 
		 				 
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
			response.sendRedirect("error.jsp?error="+e.getMessage());			
		}
	}
	
	
	
	public static void addPurchase(Connection con , com.my.org.erp.bean.inventory.Purchase d, HttpServletRequest request, HttpServletResponse response) throws IOException 
	{
		try
		{			
			HttpSession session=request.getSession();			
			String userid=""+session.getAttribute("USRID");		
			String branchid=""+session.getAttribute("BRANCHID");
			String sql ="";
			
			String dt =DateUtil.getCurrentDateTime() ;
			sql = "SELECT MAX(INT_PURCHASEORDERID) FROM inv_t_vendorpurchaseorder ";
			int rowmax = com.my.org.erp.common.CommonFunction.intMaxCount(sql)+1;
			String field="(INT_BRANCHID,CHR_PURCHASEORDERNO,INT_VENDORID,DAT_ORDERDATE , " +
			" DAT_REQUESTDATE,INT_ADDRESSID1,INT_ADDRESSID2,INT_ONHOLD , " +
			" INT_CONDITIONID,INT_PAYMENTTERMID,CHR_DES,CHR_REF ,CHR_DISCOUNT, " +
			" INT_TAXID,DOU_AMOUNT,DOU_TAXAMOUNT , " +
			" DOU_TOTALAMOUNT,INT_PURCHASESTATUS, " +
			" CHR_PAYMENTSTATUS,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS, INT_PURCHASEORDERID,INT_DIVIID )";
			sql = " INSERT INTO  inv_t_vendorpurchaseorder  "+field+" VALUES ";
			sql = sql+" (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,? ) ";
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setInt(1, Integer.parseInt(branchid));
			ps.setString(2, d.getPonumber());
			ps.setInt(3, Integer.parseInt(d.getVendorid()));
			ps.setString(4, com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(d.getOrderdate()));
			ps.setString(5, com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(d.getOrderdate()));
			ps.setInt(6, Integer.parseInt(d.getOrder()));
			ps.setInt(7, Integer.parseInt(d.getShip()));
			if((""+d.getHold()).equals("true"))
				ps.setInt(8, 1);
			else
				ps.setInt(8, 0);
			ps.setInt(9, Integer.parseInt(d.getPayment()));
			ps.setInt(10, Integer.parseInt(d.getPaymentterm()));
			ps.setString(11, d.getMemo());
			ps.setString(12, d.getRef());
			ps.setString(13, d.getTotaldiscount());
			ps.setInt(14, Integer.parseInt(d.getTax()));
			ps.setDouble(15, Double.parseDouble(d.getTotals()));
			double taxamount = (Double.parseDouble(d.getSalestax())/100)*Double.parseDouble(d.getTotals());
			ps.setDouble(16, taxamount);
			ps.setDouble(17, Double.parseDouble(d.getNettotal()));
			ps.setInt(18, 0);
			ps.setString(19, "N");
			ps.setString(20, userid);
			ps.setString(21, dt);
			ps.setString(22, "Y");
			ps.setInt(23, rowmax);
			ps.setInt(24, Integer.parseInt(d.getDivision()));
			ps.execute();
					 
		}
		catch(Exception e){
			 System.out.println(e.getMessage());
			response.sendRedirect("error.jsp?error="+e.getMessage());			
		}
	}
	
}

