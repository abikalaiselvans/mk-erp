package com.my.org.erp.SmartMarketing;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.Map;
 
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.mail.Mail;
import com.my.org.erp.setting.CommonData;

import org.apache.commons.beanutils.BeanUtils;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.common.CommonFunctions;
 
public class MarketingQuotationActionHandler extends AbstractActionHandler 
{
	
	public static void  itemInsert(java.sql.Connection con, HttpServletRequest request,HttpServletResponse response, String quotationnumber ,Statement st )throws ServletException, IOException 
	{
		try 
		{
			String field="";
			String sql="";			
			HttpSession session=request.getSession();			
			String userId=""+session.getAttribute("USRID");
			String branchid = session.getAttribute("BRANCHID").toString();
			String param[] = request.getParameter("param").split(",");
			
			for(int p=0;p<param.length; p++)
			{
				 
				field =" CHR_QUOTATIONNO, CHR_DESC,INT_QUANTITY," ;
				field  = field  + "DOU_UNITPRICE,DOU_DISCOUNT,DOU_UNITDISCOUNT,INT_WARRANTY, ";
				field  = field  + "INT_TAXID,DOU_TAX_PERCENTAGE,DOU_TAX_AMOUNT, ";
				field  = field  + "DOU_TOTAL,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS ";
				sql=" INSERT INTO  mkt_t_quotationitem  (" +field+" ) VALUES (";
				sql = sql +"  ?,?,?,?,?,?,?,?,?,?,?,?,DATE(NOW()),'Y' )";
				PreparedStatement  apstm = con.prepareStatement(sql);
				apstm.setString(1, quotationnumber);
				apstm.setString(2, (request.getParameter("desc"+param[p].trim()).replace("\"", "")).replaceAll("&", " and"));
				apstm.setString(3,  request.getParameter("qty"+param[p].trim()));
				apstm.setString(4, (request.getParameter("uprice"+param[p].trim())));
				apstm.setString(5, request.getParameter("discount"+param[p].trim()));
				apstm.setString(6, (request.getParameter("unitdiscount"+param[p].trim())));
				apstm.setString(7, (request.getParameter("warranty"+param[p].trim())));
				apstm.setString(8, request.getParameter("stax"+param[p].trim()));
				apstm.setString(9, request.getParameter("staxpercentage"+param[p].trim()));
				apstm.setString(10, request.getParameter("staxamount"+param[p].trim()));
				apstm.setString(11, (request.getParameter("total"+param[p].trim())));
				apstm.setString(12,userId);
				System.out.println(""+apstm);
				apstm.execute();
				apstm.close();
				 			
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
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String user  = (String) session.getAttribute("USRID");
			Statement st = con.createStatement();
			System.out.println("CONTROLLER FROM MARKETING QUOTATION");
			if ("MKTQuotationAdd".equals(action)  ) 
			{
				
				Quotation d = new  Quotation();
				Map map=request.getParameterMap();
				BeanUtils.populate(d,map);
				MarketingQuotationMethod.addQuotation(con, d, request, response);
				String quoId=""+session.getAttribute("QUTNO");
				itemInsert(con,request,response,quoId,st);	
				con.close();    
				response.sendRedirect("Smart Marketing/Quotation.jsp");
			}
			else if("MKTQuotationEdit".equals(action))
			{
				String quotationnumber =""+request.getParameter("quotationId");
				Quotation d = new  Quotation();
				Map map=request.getParameterMap();
				BeanUtils.populate(d,map);
				MarketingQuotationMethod.addQuotationUpdate(con, d, request, response);
				asql = "delete from  mkt_t_quotationitem  where CHR_QUOTATIONNO=?";
				apstm = con.prepareStatement(asql);
				apstm.setString(1, quotationnumber);
				apstm.execute();
				apstm.close();
				itemInsert(con,request,response,quotationnumber,st);	
				con.close();    
				response.sendRedirect("Smart Marketing/Quotation.jsp");  
			}
			else if("MKTQuotationFinal".equals(action))
			{
				String quotationnumber =""+request.getParameter("quotationId");
				Quotation d = new  Quotation();
				Map map=request.getParameterMap();
				BeanUtils.populate(d,map);
				MarketingQuotationMethod.addQuotationUpdate(con, d, request, response);
				asql = "delete from  mkt_t_quotationitem  where CHR_QUOTATIONNO=?";
				apstm = con.prepareStatement(asql);
				apstm.setString(1, quotationnumber);
				apstm.execute();
				apstm.close();
				itemInsert(con,request,response,quotationnumber,st);	
				con.close();    
				response.sendRedirect("Smart Marketing/DaillyCalls.jsp");  
			}
			else if ("MKTQuotationDelete".equals(action) ) 
			{
				String qids[]=request.getParameterValues("rowid");
				for(int u=0;u<qids.length;u++)
				{	
					
					asql = "DELETE FROM  mkt_t_quotationitem  WHERE CHR_QUOTATIONNO=?";
					apstm = con.prepareStatement(asql);
					apstm.setString(1, qids[u]);
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
					
					asql = "DELETE FROM  mkt_t_quotation  WHERE CHR_QUOTATIONNO=?";
					apstm = con.prepareStatement(asql);
					apstm.setString(1, qids[u]);
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
				}
				con.close();    
				response.sendRedirect("Smart Marketing/Quotation.jsp");
			}
			else  if("MKTQuotationSendMail".equals(action ))
			{ 
					String quoNumber =request.getParameter("qid");
					String email =request.getParameter("email");
					String content = mailContent(quoNumber);
					String a[] =(email+","+CommonData.mailid).split(",") ;
					Mail.SimpleHTMLMail(  a,  "CUSTOMER QUOTATION :: "+quoNumber, content);
					System.out.println("mail has been sent "+email);
					con.close();    
					response.sendRedirect("Smart Marketing/Quotation.jsp");
			}
			else  if("MKTQuotationRevised".equals(action ))
			{
				String quotationnumber =""+request.getParameter("quotationnumber");
				asql ="";
				
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
					asql = " UPDATE  mkt_t_daillycalls SET CHR_QUOTATION=? WHERE CHR_ADDEDTO_FUNNEL='Y' AND CHR_STATUS='N' AND CHR_QUOTATION=?  "; 
					apstm = con.prepareStatement(asql);
					apstm.setString(1, data1[0][0]);
					apstm.setString(2, quotationnumber);
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
						
					
					con.close();
					response.sendRedirect("Smart Marketing/QuotationOrderEdit.jsp?rowid="+data1[0][0]);
				}
				else
				{
					con.close();
					response.sendRedirect("Smart Marketing/Quotation.jsp");	
				}
			}
			
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
	 		request.setAttribute("error", e.getMessage());
	 		RequestDispatcher dispatchers = request	.getRequestDispatcher("/error/index.jsp");
	 		dispatchers.forward(request, response);
		}
	}

	
	
	public static String mailContent(String Quotationid )
	{
		 
		String s=" ";
		try
		{ 
			String ssql="SELECT b.CHR_COMPANYNAME,a.CHR_BRANCHNAME,a.CHR_STREET,e.CHR_CITYNAME,d.CHR_STATENAME,a.INT_PINCODE,a.CHR_PHONE,  ";
			ssql = ssql +" a.CHR_FAX,a.CHR_EMAIL, a.CHR_TNGSTNO,a.CHR_CSTNO,a.CHR_REGNO,a.CHR_TINNO,a.CHR_LOCALTAXNO,a.CHR_PANNO, "; 
			ssql = ssql +" b.CHR_SERVICETAX ,d1.CHR_DISTRICT FROM com_m_branch a , com_m_company b ,com_m_country c, com_m_state d, com_m_district d1, com_m_city e ";
			ssql = ssql +" WHERE  a.INT_CITYID = e.INT_CITYID ";
			ssql = ssql +" AND a.INT_COUNTRYID = c.INT_COUNTRYID ";
			ssql = ssql +" AND a.INT_STATEID =d.INT_STATEID AND a.INT_DISTRICTID =d1.INT_DISTRICTID  ";
			ssql = ssql +" AND a.INT_COMPANYID = b.INT_COMPANYID  ";
			 
			String cpydata[][]=CommonFunctions.QueryExecute(ssql);
			String header ="";					   
			 header=cpydata[0][0]+"<br>";
			if(!"-".equals(cpydata[0][2]))
				header=header+cpydata[0][2]+"<br>";
			if(!"-".equals(cpydata[0][3]))	
				header=header+cpydata[0][3]+"<br>";
			if(!"-".equals(cpydata[0][4]))
				header=header+cpydata[0][4]+"<br>";
			if(!"-".equals(cpydata[0][5]))
				header=header+cpydata[0][5]+"<br>";	
			if(!"-".equals(cpydata[0][6]))
				header=header+cpydata[0][6]+"<br>";	

			s= s+ "<style type='text/css'> ";
			s= s+ ".style3 {	font-size: 18px; ";
			s= s+ "font-weight: bold; ";
			s= s+ "} ";
			s= s+ ".style7 {COLOR: #000000; LINE-HEIGHT: 15px; FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; TEXT-DECORATION: none; font-size: 10px;} ";
		
			s= s+ ".boldEleven { ";
			s= s+ "FONT-WEIGHT: normal; ";
			s= s+ "FONT-SIZE: 10px; ";
			s= s+ "COLOR: #000000; ";
			s= s+ "LINE-HEIGHT: 15px; ";
			s= s+ "FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
			s= s+ "TEXT-DECORATION: none ";
			s= s+ "} ";
			s= s+ "</style> ";
			s= s+ "<center><body  onpaste='return false;'  ><div align='center'><br /> ";
			
			 
			String poId=Quotationid;
			String sql="SELECT INT_QUOTATIONID,CHR_QUOTATIONNO,INT_CUSTOMERID,"+
			" DATE_FORMAT(DAT_QUOTATIONDATE,'%d-%b-%Y'),DATE_FORMAT(DAT_REQUESTDATE,'%d-%b-%Y'),CHR_STATUS,INT_CONDITIONID,"+
			" CHR_DES,CHR_REF,INT_TAXID,DOU_DISCOUNT,DOU_TAXAMOUNT,"+
			" DOU_TOTALAMOUNT,CHR_STATUS,DOU_AMOUNT,CHR_ADDRESSID1,CHR_ADDRESSID2,CHR_CONTACTDETAILS,CHR_CONTACTNO,ROUND(DOU_TOTALAMOUNT,2) "+
			" from  mkt_t_quotation  where CHR_QUOTATIONNO='"+poId+"'";
			String purchaseInfo[][] =  CommonFunctions.QueryExecute(sql);	

			s = s + " <table width='800' border='1' cellpadding='0' cellspacing='0' bordercolor='#999999'> ";
			s = s + " <tr> ";
			s = s + " <td align='center' valign='middle'> ";
			s = s + " <table width='95%' border='0' align='center' cellpadding='1' cellspacing='1'> ";
			s = s + " 	<tr> ";
			s = s + " <td  ></td> ";
			s = s + " </tr> ";
			s = s + " <tr> ";
			s = s + " <td>&nbsp;</td> ";
			s = s + " </tr> ";
			s = s + " <tr> ";
			s = s + " <td height='27' class='boldEleven'> ";
			s = s + " <div align='center' ><h2><b>QUOTATION</b></h2></div>				</td> ";
			s = s + " </tr> ";
			s = s + " <tr> ";
			s = s + " <td  class='boldEleven'> ";
			
			s= s+ "<b>"+cpydata[0][0]+"</b>,<br>" ;
			if(!"-".equals(cpydata[0][2]))
				s= s+ cpydata[0][2]+",<br>" ;
			if(!"-".equals(cpydata[0][3]))	
				s= s+ cpydata[0][3]+",<br>"  ;
			if(!"-".equals(cpydata[0][4]))
				s= s+ cpydata[0][4]+",<br>"  ;
			if(!"-".equals(cpydata[0][5]))
				s= s+ "PIN  : " +cpydata[0][5]+"." ;	
			if(!"-".equals(cpydata[0][6]))
				s= s+ "Phone : " +cpydata[0][6]+"." ;	
		   
			
			s = s + " </td> ";
			s = s + " </tr> ";
			s = s + " <tr> ";
			s = s + " <td> ";
			s = s + " <table width='99%' border='0' align='center' cellpadding='5'	cellspacing='3'> ";
			s = s + " <tr><td width='123' class='boldEleven'> <div align='left'><strong>Quotation.No</strong></div></td> ";
			s = s + " <td width='229' class='boldEleven'> <div align='left'>"+purchaseInfo[0][1]+"</div></td> ";
			s = s + " <td width='107' class='boldEleven'>	<div align='left'><strong> </strong><strong>Payment Terms </strong></div>						</td> ";
			s = s + " <td width='201' class='boldEleven'><div align='left'> ";
			String paymentids[][] =  CommonFunctions.QueryExecute("Select INT_PAYMENTTERMID,CHR_PAYMENTNAME from inv_m_paymentterms where INT_PAYMENTTERMID="+purchaseInfo[0][6]);
			s = s + paymentids[0][1]; 
			s = s + " </div> </td> ";
			s = s + " </tr> ";
						
			s = s + " <tr> ";
			s = s + " <td class='boldEleven'> </td> ";
			s = s + " <td class='boldEleven'> </td>";
		 	 
			s = s + " <td class='boldEleven'><div align='left'><strong>Quo Date</strong></div></td> ";
			s = s + " <td class='boldEleven'><div align='left'>"+purchaseInfo[0][3] +"</div></td> ";
			s = s + " </tr> ";
			s = s + " <tr> ";
			s = s + " <td valign='top' class='boldEleven'><strong>Order From </strong></td> ";
			s = s + " <td class='boldEleven'>"+purchaseInfo[0][15]+"</td> ";
			s = s + " <td class='boldEleven'>&nbsp;</td> ";
			s = s + " <td class='boldEleven'>&nbsp;</td> ";
			s = s + " </tr> "  ;
					 
			s = s + " <tr> "  ;
			s = s + " <td valign='top' class='boldEleven'><strong>Shipping To </strong></td> "  ;
			s = s + " <td class='boldEleven'>"+purchaseInfo[0][16]+"</td> "  ;
			s = s + " <td class='boldEleven'><strong>Contact Person </strong></td> "  ;
			s = s + " <td class='boldEleven'>"+ purchaseInfo[0][17] +"</td> "  ;
			s = s + " </tr> "  ;
			s = s + " <tr> "  ;
			s = s + " <td class='boldEleven'><strong>Description :: </strong></td> "  ;
			s = s + "  <td align='left' valign='top' class='boldEleven'>"+purchaseInfo[0][7] ;
			s = s + " <div align='left'></div></td> "  ;
			s = s + " <td class='boldEleven'><strong>Contact Number </strong></td> "  ;
			s = s + " <td class='boldEleven'>"+ purchaseInfo[0][18]  +"</td> "  ;
			s = s + " </tr> "  ;
			s = s + " </table> "  ;
			s = s + " </td> "  ;
			s = s + " </tr> "  ;
			s = s + " <tr> "  ;
			s = s + " <td> "  ;
			
			 
			s = s + "  <table width='100%'  border='1' cellspacing='1' cellpadding='1' >";
			s = s + " <tr>";
			s = s + " <td  class='boldEleven' align='center'><b>S.No</b></td>";
			s = s + " <td  class='boldEleven' align='center'><b>Description</b></td>";
			s = s + " <td  class='boldEleven' align='center'><b>Quantity</b></td>";
			s = s + " <td  class='boldEleven' align='center'><b>Warranty</b></td>";
			s = s + " <td  class='boldEleven' align='center'><b>Unit Price</b></td>";
			s = s + " <td  class='boldEleven'><b>Total</b></td>";
			s = s + " </tr>";
			sql = "  SELECT a.CHR_DESC,a.INT_QUANTITY, ";
			sql = sql +"  IF(a.INT_WARRANTY=0,'NO WARRANTY',CONCAT(a.INT_WARRANTY,'-Yrs')), ";
			sql = sql +"  a.DOU_UNITPRICE,a.DOU_TOTAL ";
			sql = sql +"  from mkt_t_quotationitem a,inv_m_tax b  ";
			sql = sql +"  WHERE a.INT_TAXID =b.INT_TAXID AND CHR_QUOTATIONNO ='"+poId+"' ";
			String purchaseItem[][] =  CommonFunctions.QueryExecute(sql);	
			 
			for(int i=0;i<purchaseItem.length;i++)
			{
				s = s + " <tr>";
				s = s + "  <td class='boldEleven'>&nbsp;"+(i+1)+".</td>";	
				s = s + "  <td class='boldEleven'>&nbsp;"+purchaseItem[i][0]+"</td>";		
				s = s + "  <td class='boldEleven'>&nbsp;"+purchaseItem[i][1]+"</td>";		
				s = s + " <td class='boldEleven'>&nbsp;"+purchaseItem[i][2]+"</td>";		
				s = s + " <td class='boldEleven'>&nbsp;"+purchaseItem[i][3]+"</td>";
				s = s + " <td class='boldEleven'>&nbsp;"+purchaseItem[i][4]+"</td>";
				s = s + " </tr>";
			}
			s = s + " </table>";
			
			 
		 
					 
				s = s + " </td> ";
				s = s + " </tr> ";
				s = s + " <tr> ";
				s = s + " <td> ";
				s = s + " <div align='left'></div> ";
				s = s + " </td> ";
				s = s + " </tr> ";
				s = s + " <tr> ";
				s = s + " <td></td> ";
				s = s + " </tr> ";
				s = s + " <tr> ";
				s = s + " <td valign='top' class='boldEleven'> ";
				
				
				
				
				

				

				sql="SELECT SUM(a.DOU_UNITPRICE*a.INT_QUANTITY),b.CHR_TAXNAME,a.DOU_TAX_PERCENTAGE,SUM(a.DOU_TAX_AMOUNT)";
				sql = sql + " FROM mkt_t_quotationitem a, inv_m_tax b ";
				sql = sql+ "  WHERE a.INT_TAXID = b.INT_TAXID AND a.DOU_TAX_PERCENTAGE >0 ";
				sql = sql+ "  AND a.CHR_QUOTATIONNO ='"+poId+"' ";
				sql = sql+ "  GROUP BY a.INT_TAXID ";
				String tData[][] =  CommonFunctions.QueryExecute(sql);
				sql ="SELECT CHR_TAXNAME,DOU_VALUE FROM inv_m_tax WHERE INT_TAXID ="+purchaseInfo[0][9];
				double taxvalues = Double.parseDouble(CommonFunctions.QueryExecute(sql)[0][1]);
				
				if( tData.length>0  || taxvalues>0) 
				{
					s = s + " <table width='100%' border='0' align='center' cellpadding='1' cellspacing='1'> ";
					s = s + " <tr> ";
					s = s + " <td rowspan='2' align='left' valign='top' class='boldEleven'><div align='left'> ";
					s = s + " <table border='1' cellpadding='2' cellspacing='0' bordercolor='#CCCCCC' width='300'>";
					s = s + " <tr   bgcolor='#ffffff'>";
					s = s + " <td class='boldEleven' align='center'><b>Tax</b></td>";
					s = s + " <td class='boldEleven' align='center'><b> Value</b></td>";
					s = s + " <td class='boldEleven' align='center'><b>Tax Amount</b></td>";
					s = s + " </tr>";
					if(tData.length>0)
					{
						for(int k=0; k<tData.length;k++)
						{
							s = s + " <tr   bgcolor='#ffffff'>";
							s = s + " <td class='boldEleven' >"+tData[k][1]+"</td>";
							s = s + " <td class='boldEleven'  align='right' >"+tData[k][0]+"</td>";
							s = s + " <td class='boldEleveboldElevennPrint'  align='right' >"+tData[k][3]+"</td>";
							s = s + " </tr>";
						}
					}
					if(taxvalues>0)
					{
						s = s + " <tr   bgcolor='#ffffff'>";
						s = s + " <td class='boldEleven' >"+CommonFunctions.QueryExecute(sql)[0][0]+"</td>";
						s = s + " <td class='boldEleven' align='right' >"+ purchaseInfo[0][14] +"</td>";
						s = s + " <td class='boldEleven' align='right' >"+ purchaseInfo[0][11] +"</td>";
						s = s + " </tr>";
					}	
					s = s + " </table>";
				}
				 
				s = s + " </div></td> ";
				s = s + " <td width='148'   valign='top' class='boldEleven'><div align='left'><strong>Total</strong></div></td> ";
				s = s + " <td  valign='top' class='boldEleven' id='totals1'><div align='right'>"+purchaseInfo[0][14]+" </div></td> ";
				s = s + " </tr> ";
				s = s + " <tr> ";
				s = s + " <td valign='top' class='boldEleven'><div align='left'><strong>Net Total </strong></div> ";
				s = s + " <strong> </strong></td> ";
				s = s + " <td width='123' valign='top' class='boldEleven' ";
				s = s + " id='totaldiscount1'><div align='right'>"+purchaseInfo[0][12]+"</div></td> ";
				s = s + " </tr> ";

 
				s = s + " <td colspan='4' class='boldEleven'><span class='bolddeeplogin'>Amount in words ::</span></td> ";
				s = s + " </tr> ";
				s = s + " <tr> ";
				s = s + " <td colspan='4' class='boldEleven'><div id='Rupees' align='center'> ";
				String amt[] =purchaseInfo[0][12].trim().replace(".", "-").split("-");
				s= s+  CommonFunctions.numberWord(amt[0]);		     
				s = s + " </div></td> ";
			  	s = s + "  </tr> ";
			  	s = s + " </table> ";
			  	
			  	s = s + " </td> ";
			  	s = s + " </tr> ";
			  	s = s + " </table> ";
			  	s = s + " </td> ";
			  	s = s + " </tr> ";
			  	s = s + " </table> ";
			  	s = s + " <br><br><br><br>";
			
			
			
			return s;
		}
		catch(Exception e)
		{
			 
		}
		return null;
	
	}
}
