package com.my.org.erp.SmartMarketing;

import java.sql.*;
import com.my.org.erp.common.CommonFunctions;

public class WinorLost 
{

	public static String  revisedQuotation(String id,String quotationnumber,Connection con, PreparedStatement apstm)
	{
		String asql ="";
		String rowid="";
		try
		{
			//Quotation table
			asql = " INSERT INTO mkt_t_quotation ";
			asql = asql + " ( ";
			asql = asql + " DAT_CREATIONTIME,INT_BRANCHID, CHR_QUOTATIONNO,INT_REVISEDNO,CHR_OLDQUOTENO,INT_OFFICEID,INT_CUSTOMERID, ";
			asql = asql + " CHR_ADDRESSID1,CHR_ADDRESSFLAG,CHR_ADDRESSID2,DAT_QUOTATIONDATE , ";
			asql = asql + " INT_DIVIID, INT_CONDITIONID,CHR_DES,CHR_REF , ";
			asql = asql + " INT_TAXID,DOU_AMOUNT,DOU_DISCOUNT,DOU_TAXAMOUNT , ";
			asql = asql + " DOU_TOTALAMOUNT, CHR_CONTACTDETAILS,CHR_CONTACTNO ,CHR_ATTENTION ,CHR_SUBJECT, CHR_TERMS, ";
			asql = asql + " CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS ";
			asql = asql + " ) ";
			asql = asql + " SELECT  ";
			asql = asql + " NOW(),INT_BRANCHID, CONCAT(CHR_OLDQUOTENO,'/REV-',(INT_REVISEDNO+1) ),(INT_REVISEDNO+1),CHR_OLDQUOTENO,INT_OFFICEID,INT_CUSTOMERID, ";
			asql = asql + " CHR_ADDRESSID1,CHR_ADDRESSFLAG,CHR_ADDRESSID2,DAT_QUOTATIONDATE , ";
			asql = asql + " INT_DIVIID, INT_CONDITIONID,CHR_DES,CHR_REF , ";
			asql = asql + " INT_TAXID,DOU_AMOUNT,DOU_DISCOUNT,DOU_TAXAMOUNT , ";
			asql = asql + " DOU_TOTALAMOUNT, CHR_CONTACTDETAILS,CHR_CONTACTNO ,CHR_ATTENTION ,CHR_SUBJECT, CHR_TERMS, ";
			asql = asql + " CHR_USRNAME,DATE(NOW()),CHR_UPDATESTATUS ";
			asql = asql + " FROM mkt_t_quotation WHERE CHR_REVISED='N' AND CHR_QUOTATIONNO =? ";
			apstm = con.prepareStatement(asql);
			apstm.setString(1, quotationnumber);
			apstm.execute();
			apstm.close();

			asql = "INSERT INTO  mkt_t_quotationitem  ";
			asql = asql + " ( ";
			asql = asql + " CHR_QUOTATIONNO, CHR_DESC,INT_QUANTITY, ";
			asql = asql + " DOU_UNITPRICE,DOU_DISCOUNT,DOU_UNITDISCOUNT,INT_WARRANTY, ";
			asql = asql + " INT_TAXID,DOU_TAX_PERCENTAGE,DOU_TAX_AMOUNT, ";
			asql = asql + " DOU_TOTAL,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS ";
			asql = asql + " ) ";
			asql = asql + " SELECT "; 
			asql = asql + " CONCAT(a.CHR_OLDQUOTENO,'/REV-',(a.INT_REVISEDNO+1) ), ";
			asql = asql + " b.CHR_DESC,b.INT_QUANTITY, ";
			asql = asql + " b.DOU_UNITPRICE,b.DOU_DISCOUNT,b.DOU_UNITDISCOUNT,b.INT_WARRANTY, ";
			asql = asql + " b.INT_TAXID,b.DOU_TAX_PERCENTAGE,b.DOU_TAX_AMOUNT, ";
			asql = asql + " b.DOU_TOTAL,b.CHR_USRNAME,DATE(NOW()),b.CHR_UPDATESTATUS ";
			asql = asql + " FROM mkt_t_quotation a, mkt_t_quotationitem b WHERE a.CHR_QUOTATIONNO = b.CHR_QUOTATIONNO "; 
			asql = asql + " AND a.CHR_REVISED ='N' AND  a.CHR_QUOTATIONNO= ?  ";
			apstm = con.prepareStatement(asql);
			apstm.setString(1, quotationnumber);
			apstm.execute();
			apstm.close();
			Thread.sleep(2000);
			
			asql = " UPDATE  mkt_t_quotation SET CHR_REVISED='Y' WHERE CHR_QUOTATIONNO= ?  ";
			apstm = con.prepareStatement(asql);
			apstm.setString(1, quotationnumber);
			apstm.execute();
			apstm.close();
			
			
			asql =" SELECT a.CHR_OLDQUOTENO FROM mkt_t_quotation  a WHERE a.CHR_QUOTATIONNO='"+quotationnumber+"' ";
			String data[][]= CommonFunctions.QueryExecute(asql);
			 
			if(data.length>0)
			{
				asql = " SELECT a.CHR_QUOTATIONNO FROM mkt_t_quotation  a  WHERE a.CHR_OLDQUOTENO= '"+data[0][0]+"' ORDER BY INT_QUOTATIONID desc LIMIT 1 ";
				System.out.println(asql);
				String data1[][] = CommonFunctions.QueryExecute(asql);
				asql = " UPDATE  mkt_t_daillycalls SET CHR_QUOTATION=? WHERE CHR_ADDEDTO_FUNNEL='Y' AND CHR_STATUS='Y' AND INT_CALLID =?  "; //CHR_QUOTATION
				apstm = con.prepareStatement(asql);
				apstm.setString(1, data1[0][0]);
				apstm.setString(2, id);
				System.out.println(""+apstm);
				apstm.execute();
				apstm.close();
				
				
				asql = "UPDATE mkt_t_quotation SET CHR_ASSIGNED=?, CHR_REVISED='Y'  WHERE CHR_QUOTATIONNO =? ";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,"Y" );
				apstm.setString(2,data1[0][0] );
				System.out.println(""+apstm);
				apstm.execute();
				apstm.close();
				
				rowid = data1[0][0];
				 
				//response.sendRedirect("Smart Marketing/QuotationOrderEdit.jsp?rowid="+data1[0][0]);
			}
			 
			return rowid;
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		return rowid;
	}
	
}
