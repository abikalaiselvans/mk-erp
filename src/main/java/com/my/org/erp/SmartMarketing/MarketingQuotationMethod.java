package com.my.org.erp.SmartMarketing;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;
 
 

public class MarketingQuotationMethod 
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
			String divisionid =""+d.getDivision();
			
			String quotationnumber= customerQuotationNumberGet("","",divisionid);
			
			String sql ="";
			String field="( DAT_CREATIONTIME,INT_BRANCHID, CHR_QUOTATIONNO,CHR_OLDQUOTENO,INT_CUSTOMERID," +
			"CHR_ADDRESSID1,CHR_ADDRESSFLAG,CHR_ADDRESSID2,DAT_QUOTATIONDATE , " +
			" INT_DIVIID, " +
			" INT_CONDITIONID,CHR_DES,CHR_REF , " +
			" INT_TAXID,DOU_AMOUNT,DOU_DISCOUNT,DOU_TAXAMOUNT , " +
			" DOU_TOTALAMOUNT, CHR_CONTACTDETAILS,CHR_CONTACTNO ,CHR_ATTENTION ,CHR_SUBJECT, CHR_TERMS,INT_OFFICEID  , " +
			" CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS)";
			sql = " INSERT INTO  mkt_t_quotation  "+field+" VALUES ";
			sql = sql+" (NOW(),?,?, ?,?,?,?,?,?,?,?,?, ?,?, ?,?,  ?,?,?,?,?,?,?,?,?,DATE(NOW()),'Y') ";
			PreparedStatement pstm=con.prepareStatement(sql);
			pstm.setString(1, branchid);
			pstm.setString(2, quotationnumber);
			pstm.setString(3, quotationnumber);
			pstm.setString(4, ""+d.getCustomerId()) ;
			pstm.setString(5, d.getOrder());
			pstm.setString(6, d.getCopyaddress());
			pstm.setString(7, d.getShip());
			pstm.setString(8, DateUtil.FormateDateSQL(d.getQuoDate()));
			pstm.setString(9, ""+d.getDivision());
			pstm.setString(10, ""+d.getPayment());
			pstm.setString(11, d.getMemo());
			pstm.setString(12, d.getRef());
			pstm.setString(13, ""+d.getTax());
			pstm.setString(14, ""+d.getTotals());
			pstm.setString(15, ""+d.getTotaldiscount());
			pstm.setString(16, ""+d.getSalestaxamount());
			pstm.setString(17,""+d.getNettotal());
			pstm.setString(18,""+d.getCdetails());
			pstm.setString(19,""+d.getCnumber());
			pstm.setString(20,d.getAttention() );
			pstm.setString(21,d.getSubject() );
			pstm.setString(22,d.getTerms() );
			pstm.setString(23,""+d.getOffice());
			pstm.setString(24, userid);
			
			System.out.println("=============="+pstm);
			pstm.execute(); 
			session.setAttribute("QUTNO", quotationnumber);
			//CUSTOMER QUOTATION NUMBER INSERT
			pstm=con.prepareStatement("  SELECT FUN_MKT_GET_QUOTATION_NUMBER_INSERT() ");
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
			sql = " UPDATE   mkt_t_quotation  SET ";
			sql = sql +" INT_CUSTOMERID = ?,  ";
			sql = sql +" CHR_ADDRESSID1=? , ";
			sql = sql +" CHR_ADDRESSID2=? , ";
			sql = sql +" DAT_QUOTATIONDATE=? ,";
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
			sql = sql +" CHR_ATTENTION= ? , " ;
			sql = sql +" CHR_SUBJECT= ? , " ;
			sql = sql +" CHR_TERMS= ? , " ;
			sql = sql +" CHR_USRNAME=? ";
			sql=sql+" WHERE CHR_QUOTATIONNO=?";
			
			PreparedStatement pstm=con.prepareStatement(sql);
			pstm.setString(1, ""+d.getCustomerId()) ;
			pstm.setString(2, d.getOrder());
			pstm.setString(3, d.getShip());
			pstm.setString(4, DateUtil.FormateDateSQL(d.getQuoDate()));
			pstm.setString(5, ""+d.getDivision());
			pstm.setString(6, ""+d.getPayment());
			pstm.setString(7, d.getMemo());
			pstm.setString(8, d.getRef());
			pstm.setString(9, ""+d.getTax());
			pstm.setString(10, ""+d.getTotals());
			pstm.setString(11, ""+d.getTotaldiscount());
			pstm.setString(12, ""+d.getSalestaxamount());
			pstm.setString(13,""+d.getNettotal());
			pstm.setString(14,""+d.getCdetails());
			pstm.setString(15,""+d.getCnumber());
			pstm.setString(16,""+d.getCopyaddress());
			pstm.setString(17,d.getAttention() );
			pstm.setString(18,d.getSubject() );
			pstm.setString(19,d.getTerms() );
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
	 
	 
	//CUSTOMER QUOTATION NUMBER GET
	public static String customerQuotationNumberGet(String state,String officeid,String divisionid) 
	 {
		try 
	 	{
			return CommonFunctions.QueryExecute("  SELECT FUN_MKT_GET_QUOTATION_NUMBER( '"+divisionid+"') ")[0][0];
			
	 	}
	 	catch (Exception e) 
	 	{
	 		 System.out.println(e.getMessage());
	 	}
	 	return null;
	 }

}
