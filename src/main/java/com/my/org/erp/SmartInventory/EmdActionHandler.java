package com.my.org.erp.SmartInventory;
import java.io.IOException;
 
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
import com.my.org.erp.SmartMail.Mail;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;
import com.my.org.erp.setting.CommonData;
  
public class EmdActionHandler extends AbstractActionHandler
{
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{		
		try
		{
				String action=""+request.getParameter("actionS").trim();
				HttpSession session=request.getSession();			
				String userid=""+session.getAttribute("USRID");
				String EMPID=""+session.getAttribute("EMPID");
				String officeid=""+session.getAttribute("OFFICEID");
				String branchid = session.getAttribute("BRANCHID").toString();
				int branch = Integer.parseInt(branchid);
				String EmdType =request.getParameter("EmdType");
				String TenderNo =request.getParameter("TenderNo");
				String TenderDate =request.getParameter("TenderDate");
				String CustomerName =request.getParameter("CustomerName");
				String EmdAmt =request.getParameter("EmdAmt");
				String EmdFavourOf =request.getParameter("EmdFavourOf");
				String Payableat =request.getParameter("Payableat");
				String OrderValue =request.getParameter("OrderValue");
				String Descrip=""+request.getParameter("Descrip");
				String division=""+request.getParameter("division");
				String timeline=""+request.getParameter("timeline");
				String mailids = CommonFunctions.QueryExecute("SELECT CHR_EMD_MAILIDS  FROM m_inventorysetting WHERE INT_ROWID=1")[0][0]+",";
				if("INVEmdAssign".equals(action))
				{
					double emdamt=Double.parseDouble(EmdAmt);
					double ordervalue=Double.parseDouble(OrderValue);
					
					//String emdnumber="EMD/"+InventoryInvoiceFunctions.accountYear()+InventoryInvoiceFunctions.emdNumber()+"/"+InventoryInvoiceFunctions.invoiceLocation(officeid)+"/"+InventoryInvoiceFunctions.invoiceDivision(division);
					
					String emdnumber=InventoryInvoiceFunctions.emdNumberGet(officeid, division);
					asql = " INSERT INTO inv_t_emd_informations (CHR_EMD_REFNUMBER,INV_BRANCHID,INT_DIVIID,INT_EMD_TYPE,DAT_CREATION,CHR_TENDERNO,DAT_TENDER_LASTDATE,";
					asql = asql +" CHR_TENDER_DESC,INT_CUSTOMERID,DOU_EMD_AMOUNT,CHR_EMD_INFAVOUROF,CHR_PAYABLE_AT,DOU_ORDERVALUE,";
					asql = asql +" CHR_REF,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS ,DAT_TENDER_TIMELINE) VALUES ";
					asql = asql +" ( ";
					asql = asql +"  ?,?,?,?,NOW(),?,?,";
					asql = asql +" ?,?,?,?,?,?, ";
					asql = asql +" ?,?,DATE(NOW()),'Y',?   ";
					asql = asql +" ) ";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,""+emdnumber);
					apstm.setString(2,""+branch);
					apstm.setString(3,division);
					apstm.setString(4,EmdType);
					apstm.setString(5,TenderNo);
					apstm.setString(6,DateUtil.FormateDateSQL(TenderDate));
					apstm.setString(7,Descrip);
					apstm.setString(8,CustomerName);
					apstm.setString(9,""+emdamt);
					apstm.setString(10,EmdFavourOf);
					apstm.setString(11,Payableat);
					apstm.setString(12,""+ordervalue);
					apstm.setString(13,EMPID);
					apstm.setString(14,userid);
					apstm.setString(15,DateUtil.FormateDateSQL(timeline));
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
					
					String divisionmailid = CommonFunctions.QueryExecute("SELECT CHR_EMAILID  FROM inv_m_division WHERE INT_DIVIID ="+division)[0][0];
					String a[] =(mailids+divisionmailid+","+CommonData.mailid).split(",") ;
					Mail.SimpleHTMLMail(a, "Kindly Approve the EMD "+emdnumber, emdContent(emdnumber));
					con.close();   
					response.sendRedirect("Smart Inventory/Emd.jsp");
				}
				else if("INVEmdAssignEdit".equals(action))
				{
					double emdamt=Double.parseDouble(EmdAmt);
					double ordervalue=Double.parseDouble(OrderValue);
					String Rowid=""+request.getParameter("Rowid").trim();
					int rowId = Integer.parseInt(Rowid);
					
					asql= " UPDATE  inv_t_emd_informations SET INT_EMD_TYPE= ?,";
					asql = asql+"	CHR_TENDERNO =?,";
					asql = asql+"	DAT_TENDER_LASTDATE = ? ,";
					asql = asql+"	DAT_TENDER_TIMELINE = ? ,";
					asql = asql+"	INT_CUSTOMERID = ?, ";
					asql = asql+"	DOU_EMD_AMOUNT = ?, ";
					asql = asql+"	CHR_EMD_INFAVOUROF = ?, ";
					asql = asql+"	CHR_PAYABLE_AT = ?, ";
					asql = asql+"	DOU_ORDERVALUE = ? ,";
					asql = asql+"	INT_DIVIID = ?, ";
					asql = asql+"	CHR_TENDER_DESC = ? ";
					asql = asql+"	WHERE  INT_EMDID = ? ";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,EmdType);
					apstm.setString(2,TenderNo);
					apstm.setString(3,DateUtil.FormateDateSQL(TenderDate));
					apstm.setString(4,DateUtil.FormateDateSQL(timeline));
					apstm.setString(5,CustomerName);
					apstm.setString(6,""+emdamt);
					apstm.setString(7,EmdFavourOf);
					apstm.setString(8,Payableat);
					apstm.setString(9,""+ordervalue);
					apstm.setString(10,division);
					apstm.setString(11,Descrip);
					apstm.setString(12,""+rowId);
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
					
					String emdnumber = CommonFunctions.QueryExecute("SELECT CHR_EMD_REFNUMBER  FROM inv_t_emd_informations WHERE INT_EMDID="+rowId)[0][0];
					String divisionmailid = CommonFunctions.QueryExecute("SELECT CHR_EMAILID  FROM inv_m_division WHERE INT_DIVIID ="+division)[0][0];
					String a[] =(mailids+divisionmailid+","+CommonData.mailid).split(",") ;
					Mail.SimpleHTMLMail(a, "Kindly Approve the Modified EMD "+emdnumber, emdContent(emdnumber));
					
					
					con.close();    
					response.sendRedirect("Smart Inventory/Emd.jsp");
				}
				else if("INVEmdAssignDELETE".equals(action))
				{
					try
					{
						String Rowiddel[] = request.getParameterValues("Rowid");
						asql = " DELETE FROM inv_t_emd_informations WHERE CHR_STATUS = ? AND INT_EMDID = ? ";
						apstm = con.prepareStatement(asql);
						for(int u=0; u<Rowiddel.length;u++)
						{
							apstm.setString(1,"N" );
							apstm.setString(2,Rowiddel[u] );
							System.out.println(""+apstm);
							apstm.addBatch();
						}
						apstm.executeBatch();
						apstm.close();
						con.close();    
						response.sendRedirect("Smart Inventory/Emd.jsp");
					}
					catch(Exception e)
					{

						System.out.println(e.getMessage());
						request.setAttribute("error", e.getMessage() );
			            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
			    		dispatchers.forward(request, response); 
					}
				}
				else if("INVEmdAssignApproval".equals(action))
				{
					String Rowid=""+request.getParameter("Rowid").trim();
					String OtherDescrip=""+request.getParameter("OtherDescrip").trim();
					String approval=""+request.getParameter("approval") ;
					
					String Bank=""+request.getParameter("Bank") ;
					String ddnumber=""+request.getParameter("ddnumber") ;
					
					asql= " UPDATE  inv_t_emd_informations SET CHR_APPROVAL =?, ";
					asql = asql+"  CHR_OTHERDEC = ?,INT_BANKGROUPID=?,  CHR_DD_NUMBER=? ";
					asql = asql+"	WHERE  INT_EMDID = ? ";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,approval );
					apstm.setString(2,OtherDescrip);
					apstm.setString(3,Bank );
					apstm.setString(4,ddnumber );
					apstm.setString(5,Rowid );
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
					con.close();
					
					String emdnumber = CommonFunctions.QueryExecute("SELECT CHR_EMD_REFNUMBER  FROM inv_t_emd_informations WHERE INT_EMDID="+Rowid)[0][0];
					String a[] =(mailids+""+CommonData.mailid).split(",") ;
					Mail.SimpleHTMLMail(a, "EMD Approved "+emdnumber, emdApproved(emdnumber,EMPID));
					
					
					response.sendRedirect("Smart Inventory/EMDApproval.jsp");
					
				}
				else if("INVEmdAssignReceived".equals(action))
				{
					String Rowid=""+request.getParameter("Rowid").trim();
					String DateofDD=""+request.getParameter("DateofDD").trim();
					String returned=""+request.getParameter("returned") ;
					String OtherDescrip=""+request.getParameter("OtherDescrip").trim();
					
					if(!"Y".equals(returned))
						returned="N";
					asql= " UPDATE  inv_t_emd_informations SET CHR_STATUS= ?,";
					asql = asql+"	DAT_DATEOFDD = ?,CHR_OTHERDEC = ? ";
					asql = asql+"	WHERE  INT_EMDID = ? ";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,returned );
					apstm.setString(2,DateUtil.FormateDateSQL(DateofDD));
					apstm.setString(3,OtherDescrip);
					apstm.setString(4,Rowid );
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
					con.close();
					response.sendRedirect("Smart Inventory/EMDApproval.jsp");
				}
		}	
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}
	}


	

	
	public static String emdContent( String emdnumber)
    {
    	String content="";
		try
    	{
			String sql ="";
			sql = " SELECT  IF(a.INT_EMD_TYPE='E' ,'Earnest money deposit',if(a.INT_EMD_TYPE='B','Bank guarantee','Security deposit')), ";
			sql = sql +" b.CHR_DIVICODE,a.CHR_TENDERNO,DATE_FORMAT(a.DAT_TENDER_LASTDATE,'%d-%b-%Y'), ";
			sql = sql +" DATE_FORMAT(a.DAT_TENDER_TIMELINE,'%d-%b-%Y'),FIND_A_CUSTOMER_ADDRESS(a.INT_CUSTOMERID), ";
			sql = sql +" a.DOU_EMD_AMOUNT,a.CHR_EMD_INFAVOUROF,a.CHR_PAYABLE_AT,a.DOU_ORDERVALUE, ";
			sql = sql +" a.CHR_TENDER_DESC,FIND_A_EMPLOYEE_ID_NAME(CHR_REF) ";
			sql = sql +" FROM inv_t_emd_informations a, inv_m_division b ";
			sql = sql +" WHERE a.INT_DIVIID =b.INT_DIVIID ";
			sql = sql +" AND CHR_EMD_REFNUMBER = '"+emdnumber+"'";
			String data[][] =CommonFunctions.QueryExecute(sql);
			if(data.length>0)
			{
				content = content + " <html>   ";
				content = content + " <head>   ";
				content = content + " <meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1'>   ";
				content = content + " <title>Untitled Document</title>   ";
				content = content + " <style type='text/css'>   ";
				content = content + " <!--   ";
				content = content + " .style1 {   ";
				content = content + " color: #FFFFFF;   ";
				content = content + "  font-weight: bold;   ";
				content = content + " }   ";
				content = content + " -->   ";
				content = content + " </style>   ";
				content = content + " </head>   ";
				content = content + " </style>   ";
				content = content +" <style type='text/css'> ";
				content = content +" .boldred { ";
				content = content +" FONT-WEIGHT: normal; ";
				content = content +" FONT-SIZE: 10px; ";
				content = content +" COLOR: #FF0000; ";
				content = content +" LINE-HEIGHT: 15px; ";
				content = content +" FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
				content = content +" TEXT-DECORATION: none ";
				content = content +" } ";
				content = content +" .boldgreen { ";
				content = content +" FONT-WEIGHT: normal; ";
				content = content +" FONT-SIZE: 10px; ";
				content = content +" COLOR: #006600; ";
				content = content +" LINE-HEIGHT: 15px; ";
				content = content +" FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
				content = content +" TEXT-DECORATION: none ";
				content = content +" } ";
				content = content +" .boldEleven { ";
				content = content +" FONT-WEIGHT: normal; ";
				content = content +" FONT-SIZE: 10px; ";
				content = content +" COLOR: #000000; ";
				content = content +" LINE-HEIGHT: 15px; ";
				content = content +" FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
				content = content +" TEXT-DECORATION: none ";
				content = content +" } ";
				content = content +" .MRow1 { ";
				content = content +" BACKGROUND-COLOR: #fdfae7; ";
				content = content +" FONT-WEIGHT: normal; ";
				content = content +" FONT-SIZE: 10px; ";
				content = content +" COLOR: #000000; ";
				content = content +" LINE-HEIGHT: 15px; ";
				content = content +" FONT-FAMILY: Verdana; ";
				content = content +" TEXT-DECORATION: none; ";
				content = content +" } ";
				content = content +" .MRow2 { ";
				content = content +" BACKGROUND-COLOR: #f2f2f2; ";
				content = content +" FONT-WEIGHT: normal; ";
				content = content +" FONT-SIZE: 10px; ";
				content = content +" COLOR: #000000; ";
				content = content +" LINE-HEIGHT: 15px; ";
				content = content +" FONT-FAMILY: Verdana; ";
				content = content +" TEXT-DECORATION: none; ";
				content = content +" } "; 
				content = content +" </style> ";
				content = content + " <body> <center>  ";
				content = content + " <table width='90%' border='0' cellpadding='2' cellspacing='2' bgcolor='#0066CC'>   ";
				content = content + " <tr>   ";
				content = content + " <td><div align='center'><span class='style1'>E M D  -  R E Q U E S T</span></div></td>   ";
				content = content + " </tr>   ";
				content = content + " <tr>   ";
				content = content + " <td bgcolor='#FFFFFF'><table width='100%' border='0' cellspacing='2' cellpadding='2'>   ";
				content = content + " <tr class='MRow1'>   ";
				content = content + " <td width='54'>&nbsp;</td>   ";
				content = content + " <td>Reference Number </td>   ";
				content = content + " <td width='325'>"+emdnumber+"</td>   ";
				content = content + "   <td width='30'>&nbsp;</td>   ";
				content = content + " </tr>   ";
				content = content + " <tr class='MRow2'>   ";
				content = content + " <td>&nbsp;</td>   ";
				content = content + " <td width='132' class='boldEleven'><div align='left'><span class='boldEleven'>Emd Type</span></div></td>   ";
				content = content + " <td>"+data[0][0]+"</td>   ";
				content = content + " <td>&nbsp;</td>   ";
				content = content + " </tr>   ";
				content = content + " <tr class='MRow1'>   ";
				content = content + " <td>&nbsp;</td>   ";
				content = content + " <td class='boldEleven'  >Division</td>   ";
				content = content + " <td>"+data[0][1]+"</td>   ";
				content = content + " <td>&nbsp;</td>   ";
				content = content + " </tr>   ";
				content = content + " <tr class='MRow2'>   ";
				content = content + " <td>&nbsp;</td>   ";
				content = content + " <td width='132' class='boldEleven'><div align='left'><span class='boldEleven'>Tender No</span></div></td>   ";
				content = content + " <td>"+data[0][2]+"</td>   ";
				content = content + " <td>&nbsp;</td>   ";
				content = content + " </tr>   ";
				content = content + " <tr class='MRow1'>   ";
				content = content + " <td>&nbsp;</td>   ";
				content = content + " <td width='132' class='boldEleven'><div align='left'><span class='boldEleven'>Tender Last Date</span></div></td>   ";
				content = content + " <td>"+data[0][3]+"</td>   ";
				content = content + " <td>&nbsp;</td>   ";
				content = content + " </tr>   ";
				content = content + " <tr class='MRow2'>   ";
				content = content + " <td>&nbsp;</td>   ";
				content = content + " <td class='boldEleven'>Tender Timeline</td>   ";
				content = content + " <td>"+data[0][4]+"</td>   ";
				content = content + " <td>&nbsp;</td>   ";
				content = content + " </tr>   ";
				content = content + " <tr class='MRow1'>   ";
				content = content + " <td>&nbsp;</td>   ";
				content = content + " <td width='132' class='boldEleven'><div align='left'><span class='boldEleven'>Customer Name</span></div></td>   ";
				content = content + " <td>"+data[0][5]+"</td>   ";
				content = content + " <td>&nbsp;</td>   ";
				content = content + " </tr>   ";
				content = content + " <tr class='MRow2'>   ";
				content = content + " <td>&nbsp;</td>   ";
				content = content + " <td width='132' class='boldEleven'><div align='left'><span class='boldEleven'>EMD Amount</span></div></td>   ";
				content = content + " <td>"+data[0][6]+"</td>   ";
				content = content + " <td>&nbsp;</td>   ";
				content = content + " </tr>   ";
				content = content + " <tr class='MRow1'>   ";
				content = content + " <td>&nbsp;</td>   ";
				content = content + " <td width='132' class='boldEleven'><div align='left'><span class='boldEleven'>EMD Favour Of</span></div></td>   ";
				content = content + " <td>"+data[0][7]+"</td>   ";
				content = content + " <td>&nbsp;</td>   ";
				content = content + " </tr>   ";
				content = content + " <tr class='MRow2'>   ";
				content = content + " <td>&nbsp;</td>   ";
				content = content + " <td width='132' class='boldEleven'><div align='left'><span class='boldEleven'>Payable at</span></div></td>   ";
				content = content + " <td>"+data[0][8]+"</td>   ";
				content = content + " <td>&nbsp;</td>   ";
				content = content + " </tr>   ";
				content = content + " <tr class='MRow1'>   ";
				content = content + " <td>&nbsp;</td>   ";
				content = content + " <td width='132' class='boldEleven'><div align='left'><span class='boldEleven'>Order Value</span></div></td>   ";
				content = content + " <td>"+data[0][9]+"</td>   ";
				content = content + " <td>&nbsp;</td>   ";
				content = content + " </tr>   ";
				content = content + " <tr class='MRow2'>   ";
				content = content + " <td>&nbsp;</td>   ";
				content = content + " <td width='132' align='left' valign='top' class='boldEleven'><div align='left'><span class='boldEleven'>Description</span></div></td>   ";
				content = content + " <td>"+data[0][10]+"</td>   ";
				content = content + " <td>&nbsp;</td>   ";
				content = content + " </tr>   ";
				content = content + " <tr class='MRow1'>   ";
				content = content + " <td>&nbsp;</td>   ";
				content = content + " <td>Entry By </td>   ";
				content = content + " <td>"+data[0][11]+"</td>   ";
				content = content + " <td>&nbsp;</td>   ";
				content = content + " </tr>   ";
				content = content + " </table></td>   ";
				content = content + " </tr>   ";
				content = content + " </table></center>   ";
				content = content + " </body>   ";
				content = content + " </html>   ";

			}
      	       
			return content;
    	}
    	catch(Exception e)
    	{
    		 System.out.println(e.getMessage()); 
    	}
		return content;
    }
	
	
	public static String emdApproved( String emdnumber,String approval)
    {
    	String content="";
		try
    	{
			String sql ="";
			sql = " SELECT  IF(a.INT_EMD_TYPE='E' ,'Earnest money deposit',if(a.INT_EMD_TYPE='B','Bank guarantee','Security deposit')), ";
			sql = sql +" b.CHR_DIVICODE,a.CHR_TENDERNO,DATE_FORMAT(a.DAT_TENDER_LASTDATE,'%d-%b-%Y'), ";
			sql = sql +" DATE_FORMAT(a.DAT_TENDER_TIMELINE,'%d-%b-%Y'),FIND_A_CUSTOMER_ADDRESS(a.INT_CUSTOMERID), ";
			sql = sql +" a.DOU_EMD_AMOUNT,a.CHR_EMD_INFAVOUROF,a.CHR_PAYABLE_AT,a.DOU_ORDERVALUE, ";
			sql = sql +" a.CHR_TENDER_DESC,FIND_A_EMPLOYEE_ID_NAME('"+approval+"') ";
			sql = sql +" FROM inv_t_emd_informations a, inv_m_division b ";
			sql = sql +" WHERE a.INT_DIVIID =b.INT_DIVIID ";
			sql = sql +" AND CHR_EMD_REFNUMBER = '"+emdnumber+"'";
			System.out.println(sql);
			String data[][] =CommonFunctions.QueryExecute(sql);
			if(data.length>0)
			{
				content = content + " <html>   ";
				content = content + " <head>   ";
				content = content + " <meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1'>   ";
				content = content + " <title>Untitled Document</title>   ";
				content = content + " <style type='text/css'>   ";
				content = content + " <!--   ";
				content = content + " .style1 {   ";
				content = content + " color: #FFFFFF;   ";
				content = content + "  font-weight: bold;   ";
				content = content + " }   ";
				content = content + " -->   ";
				content = content + " </style>   ";
				content = content +" <style type='text/css'> ";
				content = content +" .boldred { ";
				content = content +" FONT-WEIGHT: normal; ";
				content = content +" FONT-SIZE: 10px; ";
				content = content +" COLOR: #FF0000; ";
				content = content +" LINE-HEIGHT: 15px; ";
				content = content +" FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
				content = content +" TEXT-DECORATION: none ";
				content = content +" } ";
				content = content +" .boldgreen { ";
				content = content +" FONT-WEIGHT: normal; ";
				content = content +" FONT-SIZE: 10px; ";
				content = content +" COLOR: #006600; ";
				content = content +" LINE-HEIGHT: 15px; ";
				content = content +" FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
				content = content +" TEXT-DECORATION: none ";
				content = content +" } ";
				content = content +" .boldEleven { ";
				content = content +" FONT-WEIGHT: normal; ";
				content = content +" FONT-SIZE: 10px; ";
				content = content +" COLOR: #000000; ";
				content = content +" LINE-HEIGHT: 15px; ";
				content = content +" FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
				content = content +" TEXT-DECORATION: none ";
				content = content +" } ";
				content = content +" .MRow1 { ";
				content = content +" BACKGROUND-COLOR: #fdfae7; ";
				content = content +" FONT-WEIGHT: normal; ";
				content = content +" FONT-SIZE: 10px; ";
				content = content +" COLOR: #000000; ";
				content = content +" LINE-HEIGHT: 15px; ";
				content = content +" FONT-FAMILY: Verdana; ";
				content = content +" TEXT-DECORATION: none; ";
				content = content +" } ";
				content = content +" .MRow2 { ";
				content = content +" BACKGROUND-COLOR: #f2f2f2; ";
				content = content +" FONT-WEIGHT: normal; ";
				content = content +" FONT-SIZE: 10px; ";
				content = content +" COLOR: #000000; ";
				content = content +" LINE-HEIGHT: 15px; ";
				content = content +" FONT-FAMILY: Verdana; ";
				content = content +" TEXT-DECORATION: none; ";
				content = content +" } "; 
				content = content +" </style> ";
				content = content + " </head>   ";

				content = content + " <body> <center>  ";
				content = content + " <table width='90%' border='0' cellpadding='2' cellspacing='2' bgcolor='#0066CC'>   ";
				content = content + " <tr>   ";
				content = content + " <td><div align='center'><span class='style1'>E M D -  A P P R O V E D</span></div></td>   ";
				content = content + " </tr>   ";
				content = content + " <tr>   ";
				content = content + " <td bgcolor='#FFFFFF'><table width='100%' border='0' cellspacing='2' cellpadding='2'>   ";
				content = content + " <tr class='MRow1'>   ";
				content = content + " <td width='54'>&nbsp;</td>   ";
				content = content + " <td>Reference Number </td>   ";
				content = content + " <td width='325'>"+emdnumber+"</td>   ";
				content = content + "   <td width='30'>&nbsp;</td>   ";
				content = content + " </tr>   ";
				content = content + " <tr class='MRow2'>   ";
				content = content + " <td>&nbsp;</td>   ";
				content = content + " <td width='132' class='boldEleven'><div align='left'><span class='boldEleven'>Emd Type</span></div></td>   ";
				content = content + " <td>"+data[0][0]+"</td>   ";
				content = content + " <td>&nbsp;</td>   ";
				content = content + " </tr>   ";
				content = content + " <tr class='MRow1'>   ";
				content = content + " <td>&nbsp;</td>   ";
				content = content + " <td class='boldEleven'  >Division</td>   ";
				content = content + " <td>"+data[0][1]+"</td>   ";
				content = content + " <td>&nbsp;</td>   ";
				content = content + " </tr>   ";
				content = content + " <tr class='MRow2'>   ";
				content = content + " <td>&nbsp;</td>   ";
				content = content + " <td width='132' class='boldEleven'><div align='left'><span class='boldEleven'>Tender No</span></div></td>   ";
				content = content + " <td>"+data[0][2]+"</td>   ";
				content = content + " <td>&nbsp;</td>   ";
				content = content + " </tr>   ";
				content = content + " <tr class='MRow1'>   ";
				content = content + " <td>&nbsp;</td>   ";
				content = content + " <td width='132' class='boldEleven'><div align='left'><span class='boldEleven'>Tender Last Date</span></div></td>   ";
				content = content + " <td>"+data[0][3]+"</td>   ";
				content = content + " <td>&nbsp;</td>   ";
				content = content + " </tr>   ";
				content = content + " <tr class='MRow2'>   ";
				content = content + " <td>&nbsp;</td>   ";
				content = content + " <td class='boldEleven'>Tender Timeline</td>   ";
				content = content + " <td>"+data[0][4]+"</td>   ";
				content = content + " <td>&nbsp;</td>   ";
				content = content + " </tr>   ";
				content = content + " <tr class='MRow1'>   ";
				content = content + " <td>&nbsp;</td>   ";
				content = content + " <td width='132' class='boldEleven'><div align='left'><span class='boldEleven'>Customer Name</span></div></td>   ";
				content = content + " <td>"+data[0][5]+"</td>   ";
				content = content + " <td>&nbsp;</td>   ";
				content = content + " </tr>   ";
				content = content + " <tr class='MRow2'>   ";
				content = content + " <td>&nbsp;</td>   ";
				content = content + " <td width='132' class='boldEleven'><div align='left'><span class='boldEleven'>EMD Amount</span></div></td>   ";
				content = content + " <td>"+data[0][6]+"</td>   ";
				content = content + " <td>&nbsp;</td>   ";
				content = content + " </tr>   ";
				content = content + " <tr class='MRow1'>   ";
				content = content + " <td>&nbsp;</td>   ";
				content = content + " <td width='132' class='boldEleven'><div align='left'><span class='boldEleven'>EMD Favour Of</span></div></td>   ";
				content = content + " <td>"+data[0][7]+"</td>   ";
				content = content + " <td>&nbsp;</td>   ";
				content = content + " </tr>   ";
				content = content + " <tr class='MRow2'>   ";
				content = content + " <td>&nbsp;</td>   ";
				content = content + " <td width='132' class='boldEleven'><div align='left'><span class='boldEleven'>Payable at</span></div></td>   ";
				content = content + " <td>"+data[0][8]+"</td>   ";
				content = content + " <td>&nbsp;</td>   ";
				content = content + " </tr>   ";
				content = content + " <tr class='MRow1'>   ";
				content = content + " <td>&nbsp;</td>   ";
				content = content + " <td width='132' class='boldEleven'><div align='left'><span class='boldEleven'>Order Value</span></div></td>   ";
				content = content + " <td>"+data[0][9]+"</td>   ";
				content = content + " <td>&nbsp;</td>   ";
				content = content + " </tr>   ";
				content = content + " <tr class='MRow2'>   ";
				content = content + " <td>&nbsp;</td>   ";
				content = content + " <td width='132' align='left' valign='top' class='boldEleven'><div align='left'><span class='boldEleven'>Description</span></div></td>   ";
				content = content + " <td>"+data[0][10]+"</td>   ";
				content = content + " <td>&nbsp;</td>   ";
				content = content + " </tr>   ";
				content = content + " <tr class='MRow1'>   ";
				content = content + " <td>&nbsp;</td>   ";
				content = content + " <td>Approved By </td>   ";
				content = content + " <td>"+data[0][11]+"</td>   ";
				content = content + " <td>&nbsp;</td>   ";
				content = content + " </tr>   ";
				content = content + " </table></td>   ";
				content = content + " </tr>   ";
				content = content + " </table></center>   ";
				content = content + " </body>   ";
				content = content + " </html>   ";

			}
      	       
			return content;
    	}
    	catch(Exception e)
    	{
    		 System.out.println(e.getMessage()); 
    	}
		return content;
    }
	
	
}
