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
import com.my.org.erp.ServiceLogin.DateUtil; 
 

public class ProformaMethod extends HttpServlet
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -3781319210840309132L;

	public static void addProforma(Connection con , Proforma d, HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException 
	{
		try
		{			
			HttpSession session=request.getSession();			
			String userid=""+session.getAttribute("USRID");		
			String branchid=""+session.getAttribute("BRANCHID");
			String officeid=""+session.getAttribute("OFFICEID");
			String divisionid =""+d.getDivision();
			String quotationnumber=InventoryInvoiceFunctions.profprmaNumberGet(""+session.getAttribute("INVSTATE"),officeid,divisionid);
			String sql ="";
			String field="( DAT_CREATIONTIME,INT_BRANCHID, CHR_PROFORMANO,INT_CUSTOMERID," +
			" CHR_ADDRESSID1,CHR_ADDRESSFLAG,CHR_ADDRESSID2,DAT_PROFORMADATE , " +
			" DAT_REQUESTDATE,CHR_ONHOLD,INT_DIVIID, " +
			" INT_CONDITIONID,CHR_DES,CHR_REF , " +
			" INT_TAXID,DOU_AMOUNT,DOU_DISCOUNT,DOU_TAXAMOUNT , " +
			" DOU_TOTALAMOUNT, CHR_CONTACTDETAILS,CHR_CONTACTNO ,CHR_OTHERREF, " +
			" CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS)";
			sql = " INSERT INTO  inv_t_proforma  "+field+" VALUES ";
			sql = sql+" (NOW(),?,?,?,?,?,?,?,?,?,?,?, ?,?,?,?,?,  ?,?,?,?,?,?,DATE(NOW()),'Y') ";
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
			pstm.setString(21,d.getOref());
			pstm.setString(22, userid);
			System.out.println("=============="+pstm);
			pstm.execute(); 
			session.setAttribute("PROFORMANO", quotationnumber);
			
			//PROFORMA NUMBER INSERT
			pstm=con.prepareStatement("  SELECT FUN_INV_GET_PROFORMA_NUMBER_INSERT(?) ");
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
	public static void addProformaUpdate(Connection con , Proforma d, HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException 
	{
		try
		{			
			HttpSession session=request.getSession();			
			String userid=""+session.getAttribute("USRID");		
			String sql ="";
			sql = " UPDATE   inv_t_proforma  SET ";
			sql = sql +" INT_CUSTOMERID = ?,  ";
			sql = sql +" CHR_ADDRESSID1=? , ";
			sql = sql +" CHR_ADDRESSID2=? , ";
			sql = sql +" DAT_PROFORMADATE=? ,";
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
			sql = sql +" CHR_ADDRESSFLAG= ? , CHR_OTHERREF= ?," ;
			sql = sql +" CHR_USRNAME=? ";
			sql=sql+" WHERE CHR_PROFORMANO=?";
			
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
			pstm.setString(19,""+d.getOref());
			pstm.setString(20, userid);
			pstm.setString(21, d.getQuotationId());
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
	 
	 
	 
}

