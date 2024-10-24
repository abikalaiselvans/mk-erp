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
import com.my.org.erp.SmartInventory.InventoryInvoiceFunctions;
import com.my.org.erp.common.CommonFunctions;

public class QuoteConversionMethod 
{
	 public static void addQuotation(Connection con , QuoteConversion d, HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException 
		{
			try
			{			
				HttpSession session=request.getSession();			
				String userid=""+session.getAttribute("USRID");		
				String branchid=""+session.getAttribute("BRANCHID");
				String officeid=""+session.getAttribute("OFFICEID");
				String divisionid =""+d.getDivision();
				//""+session.getAttribute("INVSTATE")
				String sql ="";
				sql = "SELECT INT_STATEID  FROM com_m_office WHERE INT_OFFICEID="+d.getOffice();
				String data[][] = CommonFunctions.QueryExecute(sql);
				String stateid="31";
				if(data.length>0)
					stateid = data[0][0] ;
				String quotationnumber=InventoryInvoiceFunctions.customerQuotationNumberGet(stateid,""+d.getOffice(),divisionid);
				
				
				String field="( DAT_CREATIONTIME,INT_BRANCHID, CHR_QUOTATIONNO,INT_CUSTOMERID," +
				"CHR_ADDRESSID1,CHR_ADDRESSFLAG,CHR_ADDRESSID2,DAT_QUOTATIONDATE , " +
				" DAT_REQUESTDATE,CHR_ONHOLD,INT_DIVIID, " +
				" INT_CONDITIONID,CHR_DES,CHR_REF , " +
				" INT_TAXID,DOU_AMOUNT,DOU_DISCOUNT,DOU_TAXAMOUNT , " +
				" DOU_TOTALAMOUNT, CHR_CONTACTDETAILS,CHR_CONTACTNO , CHR_MODE,CHR_SFAQUOTATION, " +
				" CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS)";
				sql = " INSERT INTO  inv_t_customerquotation  "+field+" VALUES ";
				sql = sql+" (NOW(),?,?,?,?,?,?,?,?,?,?,?, ?,?,?,?,?,  ?,?,?,?,?,?,?,DATE(NOW()),'Y') ";
				PreparedStatement pstm=con.prepareStatement(sql);
				pstm.setString(1, branchid);
				pstm.setString(2, quotationnumber);
				pstm.setString(3, ""+d.getCustomerId()) ;
				pstm.setString(4, d.getOrder());
				pstm.setString(5, d.getCopyaddress());
				pstm.setString(6, d.getShip());
				pstm.setString(7, DateUtil.FormateDateSQL(d.getQuoDate()));
				pstm.setString(8, DateUtil.FormateDateSQL(d.getQuoDate()));//request date
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
				pstm.setString(21, "S"); //Quote mode SFA
				pstm.setString(22, d.sfno);//SFA Quote number
				pstm.setString(23, userid);
				System.out.println("==============1"+pstm);
				pstm.execute(); 
				session.setAttribute("QUTNO", quotationnumber);
				//CUSTOMER QUOTATION NUMBER INSERT
				pstm=con.prepareStatement("  SELECT FUN_INV_GET_QUOTATION_NUMBER_INSERT(?) ");
				pstm.setString(1,stateid);
				System.out.println("==============2"+pstm);
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
}
