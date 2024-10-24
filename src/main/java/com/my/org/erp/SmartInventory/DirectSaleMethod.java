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

import com.my.org.erp.Date.Day;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.bean.inventory.DirectSale;
import com.my.org.erp.common.CommonFunctions;
 

public class DirectSaleMethod extends HttpServlet
{
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -3781319210840309132L;

	 
	
	public static void addDirectSale(Connection con , DirectSale d, HttpServletRequest request, HttpServletResponse response) throws IOException 
	{
		try
		{			
			HttpSession session=request.getSession();			
			String userid=""+session.getAttribute("USRID");	
			String branchid = session.getAttribute("BRANCHID").toString();
			String sql ="";
			String payment ="N";
			String dt =DateUtil.getCurrentDateTime() ;
			String field = " (INT_BRANCHID,CHR_SALESNO,DAT_SALESDATE,INT_PAYMENTTERMID, ";
			field = field+"	INT_CUSTOMERID,	CHR_DES,CHR_REF,DOU_AMOUNT,DOU_DISCOUNT,INT_TAXID, ";
			field = field+"	DOU_TAXAMOUNT,DOU_TOTALAMOUNT,INT_SALESSTATUS,CHR_PAYMENTSTATUS,CHR_SALESTYPE, ";
			field = field+"	CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS ) ";
			sql = " INSERT INTO inv_t_directsales "+field+" VALUES (";
			sql = sql +"?,?,?,?,?,?,?,?,?,?,";
			sql = sql +"?,?,?,?,?,?,?,?)";
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setInt(1, Integer.parseInt(branchid));
			ps.setString(2, d.getCashSaleNo());
			ps.setString(3, DateUtil.FormateDateSQL(d.getSaleDate()));
			ps.setInt(4, Integer.parseInt(d.getPayment()));
			ps.setInt(5, Integer.parseInt(d.getCustomerId()));
			ps.setString(6, d.getMemo());
			ps.setString(7, d.getRef());
			ps.setDouble(8, Double.parseDouble(d.getTotals()));
			ps.setDouble(9, Double.parseDouble(d.getTotaldiscount()));
			ps.setInt(10, Integer.parseInt(d.getTax()));
			ps.setDouble(11, Double.parseDouble(d.getSalestaxamount()));
			ps.setDouble(12, Double.parseDouble(d.getNettotal()));
			ps.setInt(13, 0);
			ps.setString(14,payment);
			ps.setString(15, "D");
			ps.setString(16, userid);
			ps.setString(17,dt);
			ps.setString(18, "Y");	
			ps.execute();
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
			response.sendRedirect("error.jsp?error="+e.getMessage());			
		}
	}
	
 	
	public static synchronized void addSwapSale(Connection con ,PreparedStatement apstm, com.my.org.erp.bean.inventory.SwapSale d, HttpServletRequest request, HttpServletResponse response) throws IOException,SQLWarning, ServletException 
	{
		try
		{			
			HttpSession session=request.getSession();	
			
			String userid=""+session.getAttribute("USRID");	
			String branchid = session.getAttribute("BRANCHID").toString();
			String officeid=""+session.getAttribute("OFFICEID");
			String divisionid =d.getDivision();
			String invbranchstateid = session.getAttribute("INVBRANCHSTATEID").toString();
			//String invoicenumber="IN/"+InventoryInvoiceFunctions.accountYear()+InventoryInvoiceFunctions.directSalesinvoiceNumber(""+session.getAttribute("INVSTATE"))+"/"+InventoryInvoiceFunctions.invoiceLocation(officeid)+"/"+InventoryInvoiceFunctions.invoiceDivision(divisionid);
			
			String salesinvoicecreatedby = CommonFunctions.QueryExecute("SELECT CHR_SALES_INVOICE_CREATED  FROM m_inventorysetting  WHERE INT_ROWID=1")[0][0];
			String invoicenumber=InventoryInvoiceFunctions.directSalesNumberGet(branchid,""+session.getAttribute("INVSTATE"),officeid,divisionid);
			System.out.println(invoicenumber);
			if(!salesinvoicecreatedby.equals("A")){
				invoicenumber = d.getManualsalesinvoicenumber();
			}
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
			field = field+"	INT_REF_PERCENTAGE1,INT_REF_PERCENTAGE2,INT_REF_PERCENTAGE3,INT_PROJECTID,CHR_GST_TYPE,";
			field = field+"	CHR_ADD_TO_ME_NAME,DOU_FRIEGHT_CHARGE,DOU_ROUNDED,CHR_DCREFENCE,CHR_DISCOUNTBILL,INT_SHIPPING_CUSTOMERID, ";
			field = field+"	CHR_TCS,DOU_TCS_PERCENTAGE,DOU_TCS_AMOUNT,CHR_ROUNDEDCHECK) ";
			sql = " INSERT INTO inv_t_directsales "+field+" VALUES (";
			sql = sql +"?,?,?,?,?,?,?,?,?,?,";
			sql = sql +"?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,? , ";
			sql = sql +"?,?,?,?,?,";
			sql = sql +"?,?,?,?,?,?,?,?,?,?,?,?,?,?) ";
			
			apstm=con.prepareStatement(sql);
			apstm.setInt(1, Integer.parseInt(branchid));
			apstm.setString(2, invoicenumber);
			apstm.setString(3, DateUtil.FormateDateSQL(d.getSaleDate()));
			apstm.setInt(4, Integer.parseInt(d.getPayment()));
			apstm.setInt(5, Integer.parseInt(d.getCustomerId()));
			apstm.setString(6, d.getMemo());
			apstm.setString(7, d.getRef());
			apstm.setString(8,  ""+d.getTotals() );
			apstm.setString(9,  ""+d.getTotaldiscount() );
			apstm.setInt(10, Integer.parseInt(""+d.getTax()));
			apstm.setString(11,  ""+d.getSalestaxamount() );
			apstm.setString(12, ""+d.getNettotal() );
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
			if(invbranchstateid.equalsIgnoreCase(d.getGststateid()))
				apstm.setString(43,"S");
			else
				apstm.setString(43,"D");
			apstm.setString(44,""+d.getAddmetarget());
			apstm.setDouble(45,d.getFrieghtcharge());
			apstm.setDouble(46,d.getRoundedoption());
			apstm.setString(47,""+d.getDcref());
			apstm.setString(48,""+d.getDiscountbill());
			apstm.setString(49,""+d.getShippingCustomerId());
			apstm.setString(50,""+d.getTcs());
			apstm.setString(51,""+d.getTcspercentage());
			apstm.setString(52,""+d.getTcsamount());
			apstm.setString(53,""+d.getRoundoffcheck());
			System.out.println("Sales Entry Added :"+apstm);
			
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
	
	
	public static synchronized boolean checkSerialNumberSale(Connection con,HttpServletRequest request, HttpServletResponse response) throws IOException,SQLWarning, ServletException 
	{
		boolean flag = true;
		try
		{
			String length =request.getParameter("length").trim();
			System.out.println();
			System.out.println();
			System.out.println("===========================================");
			String sql = "";
			String sss="";
			boolean individualflag = true;
			for(int u=1; u<=Integer.parseInt(length);u++)
			{
				sql = " SELECT COUNT(*) FROM  inv_t_vendorgoodsreceived	WHERE CHR_SERIALNO IS NOT NULL  AND CHR_FLAG ='N' ";
				sql = sql+ " AND CHR_TYPE = '"+request.getParameter("itype"+u).trim()+"'";
				sql = sql+ " AND CHR_ITEMID = '"+request.getParameter("item"+u).trim()+"' "; 
				sql = sql+ " AND CHR_SERIALNO = '"+request.getParameter("serial"+u).trim()+"' ";
				System.out.println(u+". Sale serial number checking : "+request.getParameter("serial"+u).trim());
				sss =request.getParameter("serial"+u).trim(); 
				//!CommonFunction.RecordExist(sql)
				if(!CommonFunctions.RecordExist(con, sql))
				{
					individualflag = false;
					Day.getMonth(1);
					break;
				}
			}
			System.out.println("===========================================");
			return individualflag;
			
			 
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
		}
		return flag;
	}
	
	public static synchronized String getWrongSerialNumberforSale(Connection con,HttpServletRequest request, HttpServletResponse response) throws IOException,SQLWarning, ServletException 
	{
		String sss="";
		try
		{
			String length =request.getParameter("length").trim();
			String sql = "";
			sss="";
			boolean individualflag = true;
			for(int u=1; u<=Integer.parseInt(length);u++)
			{
				sql = " SELECT COUNT(*) FROM  inv_t_vendorgoodsreceived	WHERE CHR_SERIALNO IS NOT NULL  AND CHR_FLAG ='N' ";
				sql = sql+ " AND CHR_TYPE = '"+request.getParameter("itype"+u).trim()+"'";
				sql = sql+ " AND CHR_ITEMID = '"+request.getParameter("item"+u).trim()+"' "; 
				sql = sql+ " AND CHR_SERIALNO = '"+request.getParameter("serial"+u).trim()+"' ";
				sss = u +" - "+request.getParameter("serial"+u).trim(); 
				if(!CommonFunctions.RecordExist(con, sql))
				{
					individualflag = false;
					break;
				}
			}
			
			if(individualflag)
				sss="";
			
			return sss;
			
			 
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
		}
		return sss;
	}
	
	
	
	public static synchronized boolean checkSwapSerialSaleornot(String salnos,Connection con,HttpServletRequest request, HttpServletResponse response) throws IOException,SQLWarning, ServletException 
	{
		boolean flag = true;
		try
		{
			String sql = " SELECT CHR_SERIALNO,CHR_FLAG  FROM  inv_t_vendorgoodsreceived WHERE CHR_RECIVEDID='"+salnos+"'  ";
			String swapdata[][] = CommonFunctions.QueryExecutecon(con, sql);
			boolean individualflag = true;
			if(swapdata.length>0)
			{
				for(int u=0;u<swapdata.length;u++)
				{
					if("Y".equals(swapdata[u][1]))
					{
						individualflag = false;
						break;
					}
				}
			}
			return individualflag;
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
		}
		return flag;
	}
	
	
}

