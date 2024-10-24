package com.my.org.erp.SmartInventory;

import javax.servlet.http.HttpSession;

import com.my.org.erp.common.CommonFunction;
import com.my.org.erp.common.CommonFunctions;

public class InvoiceHTMLMail {

	public static String mailContent(String salesno, String branchid,HttpSession session,String Path) {
		String s = "";
		String sql = "";
	
		
		try {
 
				double tdsamount= 0;
				/*
				if(  CommonFunction.RecordExist("SELECT   count(*) FROM inv_t_paymentcommitment   WHERE    CHR_SALESNO ='"+salesno+"'  AND  CHR_STATUS='N'"))
				{
					System.out.println("Please Payment commitment needed ,Otherwise you can't able to take print out for the invoice "+salesno);
					return null;
				}
				*/
				String Discount = "N";
				
				
				sql = " SELECT  ";
				sql = sql +" INT_COMPANYID,INT_BRANCHID,INT_SALESID,CHR_SALESNO,DAT_SALESDATE,INT_PAYMENTTERMID,  ";
				sql = sql +" INT_CUSTOMERID,CHR_DES,CHR_REF,DOU_AMOUNT,ROUND( (DOU_AMOUNT*(DOU_DISCOUNT/100)),2) discount,INT_TAXID,DOU_TAXAMOUNT,  ";
				sql = sql +" ROUND(DOU_TOTALAMOUNT,2),INT_SALESSTATUS,CHR_PAYMENTSTATUS,CHR_SALESTYPE,CHR_SHIPPING,  ";
				sql = sql +" UPPER(CHR_SHIPPINGADDRESS),CHR_OTHERREF,CHR_DELIVERYNOTE,CHR_DESPATCHTHRU,CHR_DESTINATION,  ";
				sql = sql +" CHR_TERMSOFDELIVERY,CHR_CONTACTDETAILS,CHR_CONTACTNO,INT_DIVIID,CHR_ACCOUNTFLAG,  ";
				sql = sql +" CHR_ACCOUNTDESC,IMG_INVOICE,CHR_NOOFPAYMENTCOMMITMENT,CHR_BYBACK,CHR_BYBACKDESC,  ";
				sql = sql +" DOU_BYBACKAMOUNT,CHR_INSTALLATION,CHR_INSTALLATION_STATUS,CHR_INVOICEBLOCK,  ";
				sql = sql +" INT_PAYMENT_COMMITMENT_DAYS,CHR_TAXTYPE,CHR_REF1,CHR_REF2,INT_REF_PERCENTAGE1,  ";
				sql = sql +" INT_REF_PERCENTAGE2,INT_REF_PERCENTAGE3,CHR_DELIVERY,CHR_DELIVERYTHROUGH,  ";
				sql = sql +" CHR_COURIER_EMPID,CHR_COURIER_EMPID_MOBILE,INT_COURIERID,DAT_COURIERDATE,  ";
				sql = sql +" CHR_STARTING_PLACE,CHR_ENDING_PLACE,INT_COURIER_KILOMETER,CHR_COURIER_DESC,  ";
				sql = sql +" DOU_COURIERAMOUNT,CHR_RECEIVERNAME,CHR_RECEIVER_MOBILE,DAT_DISPATCHEDDATE,  ";
				sql = sql +" CHR_CLOSEDBY,CHR_RECEIVER_DESC,CHR_CANCEL,INT_PROJECTID,FUN_GET_SUBTOTAL(CHR_SALESNO) , CHR_USRNAME,  ";
				sql = sql +" DT_UPDATEDATE,CHR_UPDATESTATUS,CHR_GST_TYPE ,UPPER(CHR_SHIPPING), CHR_DES, CHR_DCREFENCE, CHR_TCS,DOU_TCS_PERCENTAGE,DOU_TCS_AMOUNT,DOU_ROUNDED ";
				sql = sql +" FROM inv_t_directsales WHERE CHR_SALESNO='"+salesno+"'";
				//System.out.println(sql);
				String perdata[][]=CommonFunctions.QueryExecute(sql );
			 
				String cancellimage="";
				if("Y".equals(perdata[0][60]))
					cancellimage=" background='../Image/report/cancelled1.jpg' ";
									 				   
				String ssql=" ";


				ssql = " SELECT UPPER(b.CHR_COMPANYNAME),UPPER(a.CHR_BRANCHNAME),UPPER(a.CHR_STREET),UPPER(e.CHR_CITYNAME),UPPER(d.CHR_STATENAME),a.INT_PINCODE,a.CHR_PHONE,  ";
				ssql = ssql +" a.CHR_FAX,UPPER(a.CHR_EMAIL), a.CHR_TNGSTNO,a.CHR_CSTNO,a.CHR_REGNO,a.CHR_TINNO,a.CHR_LOCALTAXNO,UPPER(a.CHR_PANNO), "; 
				ssql = ssql +" a.CHR_SERVICETAX ,d1.CHR_DISTRICT,a.CHR_CIN_NUMBER,UPPER(a.CHR_WEBSITE),a.CHR_MOBILE,a.CHR_MOBILE1,UPPER(a.CHR_GSTNO),a.CHR_AREACODE FROM com_m_branch a , com_m_company b ,com_m_country c, com_m_state d, com_m_district d1, com_m_city e ";
				ssql = ssql +" WHERE  a.INT_CITYID = e.INT_CITYID ";
				ssql = ssql +" AND a.INT_COUNTRYID = c.INT_COUNTRYID ";
				ssql = ssql +" AND a.INT_STATEID =d.INT_STATEID AND a.INT_DISTRICTID =d1.INT_DISTRICTID  ";
				ssql = ssql +" AND a.INT_COMPANYID = b.INT_COMPANYID  ";
				ssql = ssql +" AND a.INT_BRANCHID="+ session.getAttribute("INVBRANCH");
				//System.out.println(ssql);
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


				sql="SELECT a.INT_CUSTOMERID,f.CHR_NAME ,a.CHR_ADDRESS1,a.CHR_ADDRESS2, e.CHR_CITYNAME,d.CHR_DISTRICT,c.CHR_STATENAME,  CONCAT('PIN :',a.INT_PINCODE),IF(LENGTH(a.CHR_PHONE)>4 ,CONCAT('Phone :',a.CHR_AREACODE,'-',a.CHR_PHONE),''),IF(LENGTH(a.CHR_MOBILE)>4 ,CONCAT('MOBILE :',a.CHR_MOBILE),''),IF(LENGTH(a.CHR_EMAIL )>4 ,CONCAT('E-Mail : :',a.CHR_EMAIL),''),a.CHR_PAN,CHR_GSTNO FROM  inv_m_customerinfo a, com_m_country b,com_m_state c,com_m_district d,com_m_city e  ,inv_m_customergroup f   WHERE a.INT_CUSTOMERGROUPID = f.INT_CUSTOMERGROUPID   AND a.INT_COUNTRYID = b.INT_COUNTRYID    AND a.INT_STATEID =c.INT_STATEID    AND a.INT_DISTRICTID= d.INT_DISTRICTID   AND a.INT_CITYID =e.INT_CITYID AND a.INT_CUSTOMERID="+perdata[0][6];
				String vendor[][] =  CommonFunctions.QueryExecute(sql);
			
				s= s+ "<html> ";
				s= s+ "<head> ";
				s= s+ "<meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1' /> ";
				s= s+ "<title>:: INVENTORY ::</title>  ";
				s= s+ "<style type='text/css'> ";
				s= s+ "#header {visibility: hidden;} ";
				s= s+ "#footer{visibility: hidden;} ";
				s= s+ "@media print { .pagebreak { clear: both; page-break-after: always; } } ";
				s= s+ "</style> ";
				
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
				
				s= s+ ".boldElevenPrint { FONT-WEIGHT: bold; FONT-SIZE: 9px; COLOR: #000000; LINE-HEIGHT: 13px; FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; TEXT-DECORATION: none }";

				
				s= s+ "</style> ";
				
				s= s+ "</head> ";
				s= s+ "<body> ";
			 
				s= s+ "<table width='700' height='1000' border='1' align='center' cellpadding='2' ";
				s= s+ " cellspacing='0' bordercolor='#CCCCCC' class='boldEleven'  id='masterTbl' "+cancellimage+" > ";
				s= s+ "<tr> ";
				s= s+ "<td height='20' colspan='4' valign='top'>";
				s= s+ "<table width='100%' border='1' cellspacing='0' cellpadding='0'> ";
				s= s+ "<tr> ";
				s= s+ "<td width='150' align='center' valign='middle'><img src='Header.png' ></td> ";
				s= s+ "<td   align='center' valign='middle'><div align='center'><span class='style3'>TAX INVOICE ";
				String qrcode=""; 
				s= s+ "</span></div></td> ";
				s= s+ "<td width='150' align='center' valign='middle'>&nbsp;</td> ";
				s= s+ "</tr> ";
				s= s+ "</table>";
				s= s+ "</td> ";
				s= s+ " </tr> ";
						 
			 	 	
						
				 	
				s= s+ "<tr> ";
				s= s+ "<td colspan='2' rowspan='2' valign='top'  > <span class='boldElevenHead'>";
				header="<b>"+cpydata[0][0]+"</b><br>";
				
				 
				if(!"-".equals(cpydata[0][2]))
					header=header+cpydata[0][2]+"<br> ";
				if(!"-".equals(cpydata[0][3]))	
					header=header+cpydata[0][3]+", ";
				if(!"-".equals(cpydata[0][16]))	
					header=header+cpydata[0][16]+" - " +cpydata[0][5]+".<br> ";
				//if(!"-".equals(cpydata[0][4]))
					//header=header+cpydata[0][4]+" - " +cpydata[0][5]+".<br> ";
				//if(!"-".equals(cpydata[0][5]))
					//header=header+" - " +cpydata[0][5]+".<br> ";
				
				if(!"-".equals(cpydata[0][6]))
					header=header+" PHONE : " +cpydata[0][22]+" - "+cpydata[0][6]+" <br> ";
				//if(!"-".equals(cpydata[0][19]))
					//header=header+" Mobile : " +cpydata[0][19] +" / "+cpydata[0][20]+",<br> ";
				if(!"-".equals(cpydata[0][8]))
					header=header+" Email : " +cpydata[0][8]+" <br>";
					 
				//if(!"-".equals(cpydata[0][18]))
				//	header=header+" Web : " +cpydata[0][18]+" ";
				if(!"-".equals(cpydata[0][21]))
					header=header+" GST : " +cpydata[0][21]+" <br>";
				
				 
				header=header+"</span>";	
				s= s+ header;
				s= s+ " </td> ";
				 
						
				s= s+ " <td height='24' valign='top'  ><span class='boldElevenPrint'>Invoice No </span><br> ";
				s= s+ perdata[0][3];
			    qrcode = qrcode+"INVOICE : "+perdata[0][3]+"\n";
			    s= s+ " </td> ";
			    s= s+ " <td valign='top'  ><span class='boldElevenPrint'>Invoice Date </span><br> ";
			    s= s+ com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(perdata[0][4])+"</td> ";
			    s= s+ " </tr> ";
			   
			    s= s+ " <tr> ";
			    s= s+ " <td height='24' valign='top'  ><span class='boldElevenPrint'>PO  Reference </span><br> "+perdata[0][19]+"</td>";
				s= s+ " <td valign='top'><span class='boldElevenPrint'>Payment Term</span> <br> ";
				s= s+ CommonFunctions.QueryExecute("Select INT_PAYMENTTERMID,CHR_PAYMENTNAME from inv_m_paymentterms WHERE INT_PAYMENTTERMID="+perdata[0][5])[0][1];
				s= s+ " </td> ";
				s= s+ " </tr> ";
				 
				 
						
				s= s+ " <tr> ";
				s= s+ " <td height='37' colspan='2' valign='top'  ><span class='boldElevenPrint'>Billing Address</span><br> ";
				
				if(!"-".equals(vendor[0][1]))
					s= s+ " <span class='boldElevenHead'><b>"+vendor[0][1]+"</b>,</span><br><span class='boldEleven'><br>";
				if(!"-".equals(vendor[0][2]))	
					s= s+ vendor[0][2]+",<br>";
				if(!"-".equals(vendor[0][3]))
					s= s+ vendor[0][3];
				if(!"-".equals(vendor[0][4]))	
					s= s+  vendor[0][4]+",<br>";	
				if(!"-".equals(vendor[0][5]))	
					s= s+  vendor[0][5]+",<br>";	
				if(!"-".equals(vendor[0][6]))	
					s= s+  vendor[0][6]+",<br>";
				if(!"-".equals(vendor[0][7]))	
					s= s+  vendor[0][7]+".<br>";	
				if(!"-".equals(vendor[0][11]))	
					s= s+ " PAN : "+vendor[0][11]+".<br>";	
				if(!"-".equals(vendor[0][12]))	
					s= s+ "  GST : "+vendor[0][12];		
				s= s+ " <span>";	
				
				
				
			 qrcode = qrcode+ " BILLING ADDRESS : "	;									
			 if(!"-".equals(vendor[0][1]))
				qrcode = qrcode+vendor[0][1]+",\n";
			 if(!"-".equals(vendor[0][2]))	
				qrcode = qrcode+vendor[0][2]+",\n";
			 if(!"-".equals(vendor[0][3]))
				qrcode = qrcode+vendor[0][3] +",\n";
			 if(!"-".equals(vendor[0][4]))	
				qrcode = qrcode+vendor[0][4]+",\n";	
			 if(!"-".equals(vendor[0][5]))	
				qrcode = qrcode+vendor[0][5]+",\n";	
			 if(!"-".equals(vendor[0][6]))	
				qrcode = qrcode+vendor[0][6]+",\n";
			 if(!"-".equals(vendor[0][7]))	
				qrcode = qrcode+vendor[0][7]+".\n";	
			 qrcode = qrcode+ " NETT AMOUNT : "+perdata[0][13]+ "\n"; 	 
			 s= s+ "  </td>";
			 s= s+ " <td colspan='2' valign='top'  > ";
						  			
									 
		  	if("S".equals(perdata[0][17]))
			{
				 if(!"-".equals(vendor[0][1]))
					s= s+ vendor[0][1]+",<br>";
				if(!"-".equals(vendor[0][2]))	
					s= s+ vendor[0][2]+",<br>";
				if(!"-".equals(vendor[0][3]))
					s= s+ vendor[0][3];
				if(!"-".equals(vendor[0][4]))	
					s= s+ vendor[0][4]+",<br>";	
				if(!"-".equals(vendor[0][5]))	
					s= s+ vendor[0][5]+",<br>";	
				if(!"-".equals(vendor[0][6]))	
					s= s+ vendor[0][6]+",<br>";
			}
			else
			{
				s= s+ "<span class='boldElevenPrint'>Shipping Address </span><br>";
				s= s+ perdata[0][18].replaceAll(",","<br>"); 
			}
			 
		  	s= s+ "</td>";
		  	s= s+ "</tr> ";
						 
		  	s= s+ "<tr> ";
		  	s= s+ "<td width='154' height='24' valign='top'  ><span class='boldElevenPrint'>Contact Name</span><br>"+perdata[0][24]+"</td> ";
		  	s= s+ "<td width='200' height='24' valign='top'  ><span class='boldElevenPrint'>Contact Person</span><br>"+perdata[0][25]+"</td> ";
		  	s= s+ "<td valign='top'  ><span class='boldElevenPrint'>Despatch Through</span> <br>"+perdata[0][21]+"</td>";
		  	s= s+ "<td valign='top'  ><span class='boldElevenPrint'>Destination</span><br>"+perdata[0][22]+"</td> ";
		  	s= s+ "</tr> ";	 
						
		  	s= s+ "<tr> ";
		  	s= s+ "<td height='45' colspan='4' valign='top'  > ";
		  	s= s+ "<table width='100%' border='0' align='center' cellpadding='0' cellspacing='0'> ";
								
		  	s= s+ "<tr> ";
		  	s= s+ "<td height='9' colspan='2'><br>";
		   
		  	
		  	
		  	
			sql = "SELECT CHR_SALESNO,CHR_ITEMID,CHR_TYPE ,INT_QUANTITY,DOU_UNITPRICE,DOU_DISCOUNT, DOU_UNITDISCOUNT,((INT_QUANTITY*DOU_UNITPRICE)-DOU_UNITDISCOUNT),CHR_DESC, INT_TAXID, ROUND(DOU_TAX_PERCENTAGE,0),DOU_TAX_AMOUNT,IF(CHR_TYPE='I','ITEM','PRODUCT'),FUN_INV_PRODUCTCODE(CHR_TYPE,CHR_ITEMID),FUN_INV_PRODUCTDESCRIPTION(CHR_TYPE,CHR_ITEMID),FUN_INV_HSNCODE(CHR_TYPE,CHR_ITEMID),DOU_TOTAL,FUN_INV_UNITS(CHR_TYPE,CHR_ITEMID),CONCAT(INT_WARRANTY,'-Yrs')  FROM inv_t_swapsalesitem WHERE CHR_SALESNO ='"+salesno+"'";
			String iname="";
			String datas[][] = CommonFunctions.QueryExecute(sql);
			if(datas.length>0 )
			{
				s= s+ "<table  width=99% border='1' bordercolor='#CCCCCC' cellpadding=1 cellspacing=0 align='center'>";
				s= s+ "<tr  bgcolor='#ffffff'><th width='20' class='boldElevenPrint'><strong>S.No</strong></th>";
				s= s+ "<th  width='360' class='boldElevenPrint'><strong >Description</strong></th>";
				s= s+ "<th  width='50' class='boldElevenPrint'><strong >HSN/<br>SAC</strong></th>";
				s= s+ "<th  width='20' class='boldElevenPrint'><strong >QTY</strong></th>";
				s= s+ "<th  width='20' class='boldElevenPrint'><strong >UOM</strong></th>";
				s= s+ "<th  width='50' class='boldElevenPrint'><strong >Warranty</strong></th>";
				s= s+ "<th  width='50' class='boldElevenPrint'><strong >Unit Price</strong></th>";
				if(Discount.equals("Y")) {
					s= s+ "<th class='boldElevenPrint'><strong >Discount(%)</strong></th>";
					s= s+ "<th class='boldElevenPrint'><strong >Unit Discount</strong></th>";
				}
				s= s+ "<th  width='50' class='boldElevenPrint'><strong >Tax (%)</strong></th>";
				s= s+ "<th class='boldElevenPrint'><strong >Tax Amount</strong></th>";
				s= s+ "<th  width='50' class='boldElevenPrint'><strong >Total<br>(INR)</strong></th>";
					 
				for(int v=0;v<datas.length; v++)
				{	
					s= s+ "<tr><td   class='boldEleven' >"+(v+1)+".</td>";
					s= s+ "<td valign='top'   class='boldEleven' >"+datas[v][8] +"</td>";
					s= s+ "<td valign='top'   class='boldEleven' align='center'>"+datas[v][15] +"</td>";
					s= s+ "<td valign='top'   class='boldEleven'  align='center' >"+datas[v][3] +"</td>";
					s= s+ "<td valign='top'   class='boldEleven'  align='center' >"+datas[v][17]+"</td>";
					s= s+ "<td valign='top'   class='boldEleven'  align='center'>"+datas[v][18] +"</td>";
					s= s+ "<td valign='top'   class='boldEleven'  align='right'>"+datas[v][4]+"</td>";
					if(Discount.equals("Y")) {
						s= s+ "<td valign='top'   class='boldEleven'  align='right'>"+datas[v][5] +"</td>";
						s= s+ "<td valign='top'   class='boldEleven'  align='right'>"+datas[v][6]+"</td>";
					}
					s= s+ "<td valign='top'   class='boldEleven'  align='right'>"+datas[v][10]+" % </td>"; 
					s= s+ "<td valign='top'   class='boldEleven'  align='right'>"+datas[v][11]+"</td>";
					s= s+ "<td valign='top'   class='boldEleven'  align='right' >"+datas[v][7] +"</td>";
					s= s+ "</tr>";
					 
				}	
				sql = " SELECT  ROUND(SUM((INT_QUANTITY*DOU_UNITPRICE)),2) subtotal, ";
				sql = sql + " ROUND(SUM(DOU_TAX_AMOUNT),2) taxamount,  ";
				sql = sql + " ROUND(SUM(DOU_TAX_AMOUNT)* b.DOU_IGST/100,2) igst, ";
				sql = sql + " ROUND(SUM(DOU_TAX_AMOUNT)* b.DOU_CGST/100,2) cgst, ";
				sql = sql + " ROUND(SUM(DOU_TAX_AMOUNT)* b.DOU_SGST/100,2) sgst, ";
				sql = sql + " ROUND(SUM(DOU_TOTAL),2) total ";
				sql = sql + " FROM inv_t_swapsalesitem a , inv_m_tax b  WHERE a.INT_TAXID = b.INT_TAXID AND a.CHR_SALESNO ='"+salesno+"'";
				String taxSplit[][] =  CommonFunctions.QueryExecute(sql);
				if(taxSplit.length>0) {
					s= s+ "<tr class='boldEleven' align='right'>";	
					s= s+ "<td colspan='9'>Subtotal</td>";
					s= s+ "<td>"+taxSplit[0][0]+"</td>";
					s= s+ "</tr>";
					if("D".equals(perdata[0][66])) {
						s= s+ "<tr class='boldEleven' align='right'>";	
						s= s+ "<td colspan='9'>IGST</td>";
						s= s+ "<td>"+taxSplit[0][2]+"</td>";
						s= s+ "</tr>";
					} else {							
						s= s+ "<tr class='boldEleven' align='right'>";	
						s= s+ "<td colspan='9'>CGST</td>";
						s= s+ "<td>"+taxSplit[0][3]+"</td>";
						s= s+ "</tr>";
						s= s+ "<tr class='boldEleven' align='right'>";	
						s= s+ "<td colspan='9'>SGST</td>";
						s= s+ "<td>"+taxSplit[0][4]+"</td>";
						s= s+ "</tr>";
					
					}
					
					//TCS
					if("Y".equals(perdata[0][70])) {
						s= s+ "<tr class='boldEleven' align='right'>";	
						s= s+ "<td colspan='9'>TCS @ "+perdata[0][71]+"%</td>";
						s= s+ "<td>"+perdata[0][72]+"</td>";
						s= s+ "</tr>";
					}
					
					
					
					//TDS
					tdsamount= Double.parseDouble(perdata[0][12]);
					if(tdsamount > 0){
						s= s+ "<tr class='boldEleven' align='right'>";	
						s= s+ "<td colspan='9'>TDS @ "+perdata[0][11]+"%</td>";
						s= s+ "<td>"+perdata[0][12]+"</td>";
						s= s+ "</tr>";
					}
					//Round Off
					s= s+ "<tr class='boldEleven' align='right'>";	
					s= s+ "<td colspan='9'><b>Round Off</b></td>";
					s= s+ "<td>"+perdata[0][73]+"</td>";
					s= s+ "</tr>";
					s= s+ "<tr class='boldEleven' align='right'>";	
					s= s+ "<td colspan='9'><b>Net Total&nbsp;<img src='../Image/report/Rupee.jpeg' width='10' height='10'>&nbsp;&nbsp;</b></td>";
					s= s+ "<td><b>"+perdata[0][13]+"</b></td>";
					s= s+ "</tr>";
				}
				
				s= s+ "</table>";	
			}	
								  
			
			
			
			double tvalue=0;
			double igstvalue=0;
			double sgtvalue=0;
			double gstvalue=0;
			 
									 
			s= s+ "</td>";
			s= s+ "</tr>";
								
								
			s= s+ "<tr>";
			s= s+ "<td colspan='2'>";
			s= s+ "<div align='left'>";
			int row=1;
			iname="";
			sql = "SELECT INT_ID,CHR_SALESNO,CHR_ITEMID,CHR_SERIALNO,CHR_WARRANTY,CHR_TYPE,CHR_SWAPDESC,CHR_DESC,FUN_INV_PRODUCTCODE(CHR_TYPE,CHR_ITEMID) FROM inv_t_swapsalesserialno WHERE CHR_SALESNO ='"+salesno+"' ORDER By INT_ID";
			String recdData[][]= CommonFunctions.QueryExecute(sql);
			if(recdData.length>0)
				s= s+ "<span class='boldElevenprint'>Serial Number :<br></span>";
				
			if(datas.length>0)
			{
				for(int ip=0; ip<datas.length;ip++)
				{
					sql = "SELECT INT_ID,CHR_SALESNO,CHR_ITEMID,CHR_SERIALNO,CHR_WARRANTY,CHR_TYPE,CHR_SWAPDESC,CHR_DESC,FUN_INV_PRODUCTCODE(CHR_TYPE,CHR_ITEMID)";
					sql = sql + "  FROM inv_t_swapsalesserialno WHERE CHR_SALESNO = '"+salesno+"' AND CHR_ITEMID ='"+datas[ip][1]+"' AND CHR_TYPE='"+datas[ip][2]+"' ORDER By INT_ID";
					String serialnumberData[][]= CommonFunctions.QueryExecute(sql);
					String sserial="";
					if(serialnumberData.length>0) {
						s= s+ "<span class='boldElevenprint'>"+datas[ip][13]+" : &nbsp;&nbsp;</span> ";
						for(int sp=0; sp<serialnumberData.length;sp++)
							sserial = sserial + serialnumberData[sp][3]+",&nbsp;  " ;
						sserial = sserial.trim();
						sserial = sserial.substring(0,sserial.length()-1);
						sserial = sserial.trim();
						 
						s= s+ "<span class='boldEleven'>"+sserial+"</span>";
					}
					s= s+ "<br>";
				}
			}		
			s= s+ "</div> </td> </tr> ";
								 
			s= s+ "<tr> ";
			s= s+ "<td colspan='2'></td> ";
			s= s+ "</tr> ";
								
								 
			s= s+ "<tr> ";
			s= s+ "<td colspan='2' valign='top' class='boldElevenPrint'> </td> ";
			s= s+ "</tr> ";
			s= s+ "</table>";
			s= s+ "</td> ";
			s= s+ "</tr> ";
						
			
			s= s+ "<tr> ";
			s= s+ "<td height='30' colspan='4' valign='top' class='boldEleven'  > ";
			s= s+ "<table width='100%' border='0' cellpadding='0' cellspacing='0' class='boldEleven'>";
			s= s+ "<tr>";
			s= s+ "<td width='29%' height='28' align='left' valign='top' class='boldElevenPrint'>&nbsp;Amount Chargeable (In words) INR ::</td>";
			s= s+ "<td width='71%' class='boldElevenHead'><b>";
			s= s+ "<div id='Rupees'>";
			s= s+ perdata[0][13];
			s= s+ "</div>";
			s= s+ "<b> &nbsp;</td>";
			s= s+ "</tr>";
			s= s+ "</table>";
			s= s+ "</td> ";
			s= s+ "</tr> ";
			
			s= s+ "<tr>";
			s= s+ "<td height='30' colspan='4' valign='top' class='boldEleven'  >";
			sql ="";
			sql = sql + " SELECT  b.CHR_GST_TYPE,FUN_INV_HSNCODE(a.CHR_TYPE,a.CHR_ITEMID),(a.INT_QUANTITY*a.DOU_UNITPRICE), ";
			sql = sql + " Round(a.DOU_TAX_PERCENTAGE,0),  Round(a.DOU_TAX_PERCENTAGE/2,0) ,";
			sql = sql + " Round((a.DOU_TAX_AMOUNT * c.DOU_IGST/100 ),2), ";
			sql = sql + " Round((a.DOU_TAX_AMOUNT * c.DOU_CGST/100 ),2),Round((a.DOU_TAX_AMOUNT * c.DOU_SGST/100 ),2), ";
			sql = sql + " a.DOU_TAX_AMOUNT  ";
			sql = sql + "  FROM inv_t_swapsalesitem a , inv_t_directsales b, inv_m_tax c  ";
			sql = sql + "  WHERE a.CHR_SALESNO =  b.CHR_SALESNO AND a.INT_TAXID = c.INT_TAXID ";
			sql = sql + " AND  a.CHR_SALESNO ='"+salesno+"' ";
			sql = sql + " GROUP BY FUN_INV_HSNCODE(a.CHR_TYPE,a.CHR_ITEMID) ";
			String splitTaxData[][]= CommonFunctions.QueryExecute(sql);
			if(splitTaxData.length>0) {
				s= s+ "<table width='100%' border='1' cellpadding='1' cellspacing='0'   class='boldEleven' bordercolor='#CCCCCC'>";
				s= s+ "<tr align='center'>";
				s= s+ "<th rowspan='2' class='boldElevenPrint'>HSN/SAC</th>";
				s= s+ "<th rowspan='2' class='boldElevenPrint'>Taxable Value </th>";
				if(splitTaxData[0][0].equals("D")) {
					s= s+ "<th colspan='2' class='boldElevenPrint'>Central Tax </th>";
				}
				else {	
					s= s+ "<th colspan='2' class='boldElevenPrint'>Central Tax </th>";
					s= s+ "<th colspan='2' class='boldElevenPrint'>State Tax </th>";
				}	
				s= s+ "<th rowspan='2' class='boldElevenPrint'>Total Tax Amount</th>";
				s= s+ " </tr>";
				
				s= s+ "<tr align='center'>";
				if(splitTaxData[0][0].equals("D")) {
					s= s+ "<td  class='boldElevenPrint'>Rate</td>";
					s= s+ "<td  class='boldElevenPrint'>Amount</td>";
				} else {	
					s= s+ "<td  class='boldElevenPrint'>Rate</td>";
					s= s+ "<td  class='boldElevenPrint'>Amount</td>";
					s= s+ "<td  class='boldElevenPrint'>Rate</td>";
					s= s+ "<td  class='boldElevenPrint'>Amount</td>";
				}	
				s= s+ " </tr>";
				for(int v=0;v<splitTaxData.length; v++)
				{
					s= s+ "<tr class='boldEleven'>";
					s= s+ "<td align='center'>"+splitTaxData[v][1]+"</td>";
					s= s+ "<td align='right'>"+splitTaxData[v][2]+"</td>";
					if(splitTaxData[0][0].equals("D")) {
						s= s+ "<td align='right'>"+splitTaxData[v][3]+" %</td>";
						s= s+ "<td align='right'>"+splitTaxData[v][5]+"</td>";
					} else {	
						s= s+ "<td align='right'>"+splitTaxData[v][4]+" %</td>";
						s= s+ "<td align='right'>"+splitTaxData[v][6]+"</td>";
						s= s+ "<td align='right'>"+splitTaxData[v][4]+" %</td>";
						s= s+ "<td align='right'>"+splitTaxData[v][7]+"</td>";
					}	
					s= s+ "<td align='right'>"+splitTaxData[v][8]+"</td>";
					s= s+ " </tr>";
				}
				
				sql = "SELECT  SUM(a.INT_QUANTITY*a.DOU_UNITPRICE), ";
				sql = sql + " SUM(Round((a.DOU_TAX_AMOUNT * c.DOU_IGST/100 ),2)), ";
				sql = sql + " SUM(Round((a.DOU_TAX_AMOUNT * c.DOU_CGST/100 ),2)), SUM(Round((a.DOU_TAX_AMOUNT * c.DOU_SGST/100 ),2)), ";
				sql = sql + " SUM(a.DOU_TAX_AMOUNT ) ";
				sql = sql + " FROM inv_t_swapsalesitem a , inv_t_directsales b, inv_m_tax c  ";
				sql = sql + " WHERE a.CHR_SALESNO =  b.CHR_SALESNO AND a.INT_TAXID = c.INT_TAXID ";
				sql = sql + " AND  a.CHR_SALESNO ='"+salesno+"' ";
				String sumSplitTaxData[][]= CommonFunctions.QueryExecute(sql);
				if(sumSplitTaxData.length >0) {
					s= s+ "<tr class='boldElevenPrint' align='right'>";
					s= s+ "<td>Total</td>";
					s= s+ "<td>"+sumSplitTaxData[0][0]+"</td>";
					if(splitTaxData[0][0].equals("D")) {
						s= s+ "<td>&nbsp;</td>";
						s= s+ "<td>"+sumSplitTaxData[0][1]+"</td>";
					} else {	
						s= s+ "<td>&nbsp;</td>";
						s= s+ "<td>"+sumSplitTaxData[0][2]+"</td>";
						s= s+ "<td>&nbsp;</td>";
						s= s+ "<td>"+sumSplitTaxData[0][3]+"</td>";
					}	
					s= s+ "<td>"+sumSplitTaxData[0][4]+"</td>";
					s= s+ " </tr>";
				}
				s= s+ "</table>";
			
			}
			s= s+ "</td>";
			s= s+ "</tr>";
			
			
			
			
			s= s+ "<tr> ";
			s= s+ "<td colspan='2' rowspan='5' valign='top' class='boldEleven'> ";
			if(tdsamount > 0){
		  
			  s= s+ "<b>TDS DECLARATION </b>:<br>  ";
			  s= s+ " In terms of notification no.21/2012 dt.13 june 2012, We hereby declare that transaction with remarks \"ref, tds declaration\" is software";
			  s= s+ "acquired in a subsequent transfer and is transferred without any  modification and is already subjected to tax deducation at source under";
			  s= s+ "section 194j and/or under section 195 (whohever is applicable) on payment for the previous transfer of such software, you are not required";
			  s= s+ "to deduct tax at source on this account. our permanent account is AAKCM7953M <br>  ";
			 
			}
			 
			s= s+ "<b>Kindly Note </b>:<br>  ";
			s= s+ "1. Goods Once Sold cannot be taken back.<br> ";
			s= s+ "2. Mishandling or Physical Damage will not be covered under warranty.</td> ";
			
		  s= s+ "<td height='24' colspan='2' valign='top' class='boldEleven' align='center'  ><span class='boldElevenPrint'>Company's Bank Details ";
		  sql = "SELECT CHR_BANK_NAME,CHR_ACCOUNT_NO,CHR_IFSCCODE, CHR_FOOTER_CONTENT    FROM m_inventorysetting WHERE INT_ROWID = 1 ";
		  String BankDetails[][]= CommonFunctions.QueryExecute(sql);
		  s= s+ "</span></td> ";
		  s= s+ "</tr> ";
		  
		  s= s+ "<tr> ";
		  s= s+ "<td height='20' valign='top' class='boldEleven'  ><span class='boldElevenPrint'>Bank Name &amp; Branch </span></td> ";
		  s= s+ "<td height='20' valign='top' class='boldEleven'  >"+BankDetails[0][0]+"</td> ";
		  s= s+ " </tr> ";
		  
		  s= s+ "<tr> ";
		  s= s+ "<td height='20' valign='top' class='boldEleven'  ><span class='boldElevenPrint'>A/c No</span></td> ";
		  s= s+ "<td height='20' valign='top' class='boldEleven'  >"+BankDetails[0][1]+"</td> ";
		  s= s+ "</tr> ";
		  
		  s= s+ "<tr> ";
		  s= s+ "<td height='20' valign='top' class='boldEleven'  ><span class='boldElevenPrint'>IFSC code </span></td> ";
		  s= s+ "<td height='20' valign='top' class='boldEleven'  >"+BankDetails[0][2] +"</td> ";
		  s= s+ "</tr> ";
		  
		  s= s+ "<tr> ";
		  s= s+ "<td height='79' colspan='2' valign='top' class='boldEleven'  > ";
		  s= s+ "<div align='right'><span class='bold1'>For  "+cpydata[0][0]+"</span></div> ";
		  s= s+ "<br> ";
		  s= s+ "<br><br> ";
		  s= s+ "<div align='right'><span class='boldElevenPrint'>Authorized Signatory </span></div></td>";
		  s= s+ "</tr> ";
		
		  s= s+ "<tr> ";
		  s= s+ "<td height='20' colspan='4' valign='top'  ><div align='center' class='boldEleven'>"+BankDetails[0][3]+"</div></td> ";
		  s= s+ "</tr> ";
		  
		  s= s+ "</table> ";
		  s= s+ "</div> ";
		  s= s+ "</body> ";
		  s= s+ "</html> ";
			  
			}
			 catch(Exception e)
			 {
			 	System.out.println(e.getMessage());
			 }
		return s;

	}
	
	
	
	
	public static String employeeBasedMailContent(String salesno, String branchid,HttpSession session,String Path) {
		String s = "";
		String sql = "";
	
		
		try {
 
				double tdsamount= 0;
				String Discount = "N";
				
				
				sql = " SELECT  ";
				sql = sql +" INT_COMPANYID,INT_BRANCHID,INT_SALESID,CHR_SALESNO,DAT_SALESDATE,INT_PAYMENTTERMID,  ";
				sql = sql +" INT_CUSTOMERID,CHR_DES,CHR_REF,DOU_AMOUNT,ROUND( (DOU_AMOUNT*(DOU_DISCOUNT/100)),2) discount,INT_TAXID,DOU_TAXAMOUNT,  ";
				sql = sql +" ROUND(DOU_TOTALAMOUNT,2),INT_SALESSTATUS,CHR_PAYMENTSTATUS,CHR_SALESTYPE,CHR_SHIPPING,  ";
				sql = sql +" UPPER(CHR_SHIPPINGADDRESS),CHR_OTHERREF,CHR_DELIVERYNOTE,CHR_DESPATCHTHRU,CHR_DESTINATION,  ";
				sql = sql +" CHR_TERMSOFDELIVERY,CHR_CONTACTDETAILS,CHR_CONTACTNO,INT_DIVIID,CHR_ACCOUNTFLAG,  ";
				sql = sql +" CHR_ACCOUNTDESC,IMG_INVOICE,CHR_NOOFPAYMENTCOMMITMENT,CHR_BYBACK,CHR_BYBACKDESC,  ";
				sql = sql +" DOU_BYBACKAMOUNT,CHR_INSTALLATION,CHR_INSTALLATION_STATUS,CHR_INVOICEBLOCK,  ";
				sql = sql +" INT_PAYMENT_COMMITMENT_DAYS,CHR_TAXTYPE,CHR_REF1,CHR_REF2,INT_REF_PERCENTAGE1,  ";
				sql = sql +" INT_REF_PERCENTAGE2,INT_REF_PERCENTAGE3,CHR_DELIVERY,CHR_DELIVERYTHROUGH,  ";
				sql = sql +" CHR_COURIER_EMPID,CHR_COURIER_EMPID_MOBILE,INT_COURIERID,DAT_COURIERDATE,  ";
				sql = sql +" CHR_STARTING_PLACE,CHR_ENDING_PLACE,INT_COURIER_KILOMETER,CHR_COURIER_DESC,  ";
				sql = sql +" DOU_COURIERAMOUNT,CHR_RECEIVERNAME,CHR_RECEIVER_MOBILE,DAT_DISPATCHEDDATE,  ";
				sql = sql +" CHR_CLOSEDBY,CHR_RECEIVER_DESC,CHR_CANCEL,INT_PROJECTID,FUN_GET_SUBTOTAL(CHR_SALESNO) , CHR_USRNAME,  ";
				sql = sql +" DT_UPDATEDATE,CHR_UPDATESTATUS,CHR_GST_TYPE ,UPPER(CHR_SHIPPING), CHR_DES, CHR_DCREFENCE, CHR_TCS,DOU_TCS_PERCENTAGE,DOU_TCS_AMOUNT,DOU_ROUNDED ";
				sql = sql +" FROM inv_t_directsales WHERE CHR_SALESNO='"+salesno+"'";
				//System.out.println(sql);
				String perdata[][]=CommonFunctions.QueryExecute(sql );
			 
				String cancellimage="";
				if("Y".equals(perdata[0][60]))
					cancellimage=" background='../Image/report/cancelled1.jpg' ";
									 				   
				String ssql=" ";


				ssql = " SELECT UPPER(b.CHR_COMPANYNAME),UPPER(a.CHR_BRANCHNAME),UPPER(a.CHR_STREET),UPPER(e.CHR_CITYNAME),UPPER(d.CHR_STATENAME),a.INT_PINCODE,a.CHR_PHONE,  ";
				ssql = ssql +" a.CHR_FAX,UPPER(a.CHR_EMAIL), a.CHR_TNGSTNO,a.CHR_CSTNO,a.CHR_REGNO,a.CHR_TINNO,a.CHR_LOCALTAXNO,UPPER(a.CHR_PANNO), "; 
				ssql = ssql +" a.CHR_SERVICETAX ,d1.CHR_DISTRICT,a.CHR_CIN_NUMBER,UPPER(a.CHR_WEBSITE),a.CHR_MOBILE,a.CHR_MOBILE1,UPPER(a.CHR_GSTNO),a.CHR_AREACODE FROM com_m_branch a , com_m_company b ,com_m_country c, com_m_state d, com_m_district d1, com_m_city e ";
				ssql = ssql +" WHERE  a.INT_CITYID = e.INT_CITYID ";
				ssql = ssql +" AND a.INT_COUNTRYID = c.INT_COUNTRYID ";
				ssql = ssql +" AND a.INT_STATEID =d.INT_STATEID AND a.INT_DISTRICTID =d1.INT_DISTRICTID  ";
				ssql = ssql +" AND a.INT_COMPANYID = b.INT_COMPANYID  ";
				ssql = ssql +" AND a.INT_BRANCHID="+ session.getAttribute("INVBRANCH");
				//System.out.println(ssql);
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


				sql="SELECT a.INT_CUSTOMERID,f.CHR_NAME ,a.CHR_ADDRESS1,a.CHR_ADDRESS2, e.CHR_CITYNAME,d.CHR_DISTRICT,c.CHR_STATENAME,  CONCAT('PIN :',a.INT_PINCODE),IF(LENGTH(a.CHR_PHONE)>4 ,CONCAT('Phone :',a.CHR_AREACODE,'-',a.CHR_PHONE),''),IF(LENGTH(a.CHR_MOBILE)>4 ,CONCAT('MOBILE :',a.CHR_MOBILE),''),IF(LENGTH(a.CHR_EMAIL )>4 ,CONCAT('E-Mail : :',a.CHR_EMAIL),''),a.CHR_PAN,CHR_GSTNO FROM  inv_m_customerinfo a, com_m_country b,com_m_state c,com_m_district d,com_m_city e  ,inv_m_customergroup f   WHERE a.INT_CUSTOMERGROUPID = f.INT_CUSTOMERGROUPID   AND a.INT_COUNTRYID = b.INT_COUNTRYID    AND a.INT_STATEID =c.INT_STATEID    AND a.INT_DISTRICTID= d.INT_DISTRICTID   AND a.INT_CITYID =e.INT_CITYID AND a.INT_CUSTOMERID="+perdata[0][6];
				String vendor[][] =  CommonFunctions.QueryExecute(sql);
			
				s= s+ "<html> ";
				s= s+ "<head> ";
				s= s+ "<meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1' /> ";
				s= s+ "<title>:: INVENTORY ::</title>  ";
				s= s+ "<style type='text/css'> ";
				s= s+ "#header {visibility: hidden;} ";
				s= s+ "#footer{visibility: hidden;} ";
				s= s+ "@media print { .pagebreak { clear: both; page-break-after: always; } } ";
				s= s+ "</style> ";
				
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
				
				s= s+ ".boldElevenPrint { FONT-WEIGHT: bold; FONT-SIZE: 9px; COLOR: #000000; LINE-HEIGHT: 13px; FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; TEXT-DECORATION: none }";

				
				s= s+ "</style> ";
				
				s= s+ "</head> ";
				s= s+ "<body> ";
			 
				s= s+ "<table width='700' height='1000' border='1' align='center' cellpadding='2' ";
				s= s+ " cellspacing='0' bordercolor='#CCCCCC' class='boldEleven'  id='masterTbl' "+cancellimage+" > ";
				s= s+ "<tr> ";
				s= s+ "<td height='20' colspan='4' valign='top'>";
				s= s+ "<table width='100%' border='1' cellspacing='0' cellpadding='0'> ";
				s= s+ "<tr> ";
				s= s+ "<td width='150' align='center' valign='middle'><img src='Header.png' ></td> ";
				s= s+ "<td   align='center' valign='middle'><div align='center'><span class='style3'>TAX INVOICE ";
				String qrcode=""; 
				s= s+ "</span></div></td> ";
				s= s+ "<td width='150' align='center' valign='middle'>&nbsp;</td> ";
				s= s+ "</tr> ";
				s= s+ "</table>";
				s= s+ "</td> ";
				s= s+ " </tr> ";
						 
			 	 	
						
				 	
				s= s+ "<tr> ";
				s= s+ "<td colspan='2' rowspan='2' valign='top'  > <span class='boldElevenHead'>";
				header="<b>"+cpydata[0][0]+"</b><br>";
				
				 
				if(!"-".equals(cpydata[0][2]))
					header=header+cpydata[0][2]+"<br> ";
				if(!"-".equals(cpydata[0][3]))	
					header=header+cpydata[0][3]+", ";
				if(!"-".equals(cpydata[0][16]))	
					header=header+cpydata[0][16]+" - " +cpydata[0][5]+".<br> ";
				//if(!"-".equals(cpydata[0][4]))
					//header=header+cpydata[0][4]+" - " +cpydata[0][5]+".<br> ";
				//if(!"-".equals(cpydata[0][5]))
					//header=header+" - " +cpydata[0][5]+".<br> ";
				
				if(!"-".equals(cpydata[0][6]))
					header=header+" PHONE : " +cpydata[0][22]+" - "+cpydata[0][6]+" <br> ";
				//if(!"-".equals(cpydata[0][19]))
					//header=header+" Mobile : " +cpydata[0][19] +" / "+cpydata[0][20]+",<br> ";
				if(!"-".equals(cpydata[0][8]))
					header=header+" Email : " +cpydata[0][8]+" <br>";
					 
				//if(!"-".equals(cpydata[0][18]))
				//	header=header+" Web : " +cpydata[0][18]+" ";
				if(!"-".equals(cpydata[0][21]))
					header=header+" GST : " +cpydata[0][21]+" <br>";
				
				 
				header=header+"</span>";	
				s= s+ header;
				s= s+ " </td> ";
				 
						
				s= s+ " <td height='24' valign='top'  ><span class='boldElevenPrint'>Invoice No </span><br> ";
				s= s+ perdata[0][3];
			    qrcode = qrcode+"INVOICE : "+perdata[0][3]+"\n";
			    s= s+ " </td> ";
			    s= s+ " <td valign='top'  ><span class='boldElevenPrint'>Invoice Date </span><br> ";
			    s= s+ com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(perdata[0][4])+"</td> ";
			    s= s+ " </tr> ";
			   
			    s= s+ " <tr> ";
			    s= s+ " <td height='24' valign='top'  ><span class='boldElevenPrint'>PO  Reference </span><br> "+perdata[0][19]+"</td>";
				s= s+ " <td valign='top'><span class='boldElevenPrint'>Payment Term</span> <br> ";
				s= s+ CommonFunctions.QueryExecute("Select INT_PAYMENTTERMID,CHR_PAYMENTNAME from inv_m_paymentterms WHERE INT_PAYMENTTERMID="+perdata[0][5])[0][1];
				s= s+ " </td> ";
				s= s+ " </tr> ";
				 
				 
						
				s= s+ " <tr> ";
				s= s+ " <td height='37' colspan='2' valign='top'  ><span class='boldElevenPrint'>Billing Address</span><br> ";
				
				if(!"-".equals(vendor[0][1]))
					s= s+ " <span class='boldElevenHead'><b>"+vendor[0][1]+"</b>,</span><br><span class='boldEleven'><br>";
				if(!"-".equals(vendor[0][2]))	
					s= s+ vendor[0][2]+",<br>";
				if(!"-".equals(vendor[0][3]))
					s= s+ vendor[0][3];
				if(!"-".equals(vendor[0][4]))	
					s= s+  vendor[0][4]+",<br>";	
				if(!"-".equals(vendor[0][5]))	
					s= s+  vendor[0][5]+",<br>";	
				if(!"-".equals(vendor[0][6]))	
					s= s+  vendor[0][6]+",<br>";
				if(!"-".equals(vendor[0][7]))	
					s= s+  vendor[0][7]+".<br>";	
				if(!"-".equals(vendor[0][11]))	
					s= s+ " PAN : "+vendor[0][11]+".<br>";	
				if(!"-".equals(vendor[0][12]))	
					s= s+ "  GST : "+vendor[0][12];		
				s= s+ " <span>";	
				
				
				
			 qrcode = qrcode+ " BILLING ADDRESS : "	;									
			 if(!"-".equals(vendor[0][1]))
				qrcode = qrcode+vendor[0][1]+",\n";
			 if(!"-".equals(vendor[0][2]))	
				qrcode = qrcode+vendor[0][2]+",\n";
			 if(!"-".equals(vendor[0][3]))
				qrcode = qrcode+vendor[0][3] +",\n";
			 if(!"-".equals(vendor[0][4]))	
				qrcode = qrcode+vendor[0][4]+",\n";	
			 if(!"-".equals(vendor[0][5]))	
				qrcode = qrcode+vendor[0][5]+",\n";	
			 if(!"-".equals(vendor[0][6]))	
				qrcode = qrcode+vendor[0][6]+",\n";
			 if(!"-".equals(vendor[0][7]))	
				qrcode = qrcode+vendor[0][7]+".\n";	
			 qrcode = qrcode+ " NETT AMOUNT : "+perdata[0][13]+ "\n"; 	 
			 s= s+ "  </td>";
			 s= s+ " <td colspan='2' valign='top'  > ";
						  			
									 
		  	if("S".equals(perdata[0][17]))
			{
				 if(!"-".equals(vendor[0][1]))
					s= s+ vendor[0][1]+",<br>";
				if(!"-".equals(vendor[0][2]))	
					s= s+ vendor[0][2]+",<br>";
				if(!"-".equals(vendor[0][3]))
					s= s+ vendor[0][3];
				if(!"-".equals(vendor[0][4]))	
					s= s+ vendor[0][4]+",<br>";	
				if(!"-".equals(vendor[0][5]))	
					s= s+ vendor[0][5]+",<br>";	
				if(!"-".equals(vendor[0][6]))	
					s= s+ vendor[0][6]+",<br>";
			}
			else
			{
				s= s+ "<span class='boldElevenPrint'>Shipping Address </span><br>";
				s= s+ perdata[0][18].replaceAll(",","<br>"); 
			}
			 
		  	s= s+ "</td>";
		  	s= s+ "</tr> ";
						 
		  	s= s+ "<tr> ";
		  	s= s+ "<td width='154' height='24' valign='top'  ><span class='boldElevenPrint'>Contact Name</span><br>"+perdata[0][24]+"</td> ";
		  	s= s+ "<td width='200' height='24' valign='top'  ><span class='boldElevenPrint'>Contact Person</span><br>"+perdata[0][25]+"</td> ";
		  	s= s+ "<td valign='top'  ><span class='boldElevenPrint'>Despatch Through</span> <br>"+perdata[0][21]+"</td>";
		  	s= s+ "<td valign='top'  ><span class='boldElevenPrint'>Destination</span><br>"+perdata[0][22]+"</td> ";
		  	s= s+ "</tr> ";	 
						
		  	s= s+ "<tr> ";
		  	s= s+ "<td height='45' colspan='4' valign='top'  > ";
		  	s= s+ "<table width='100%' border='0' align='center' cellpadding='0' cellspacing='0'> ";
								
		  	s= s+ "<tr> ";
		  	s= s+ "<td height='9' colspan='2'><br>";
		   
		  	
		  	
		  	
			sql = "SELECT CHR_SALESNO,CHR_ITEMID,CHR_TYPE ,INT_QUANTITY,DOU_UNITPRICE,DOU_DISCOUNT, DOU_UNITDISCOUNT,((INT_QUANTITY*DOU_UNITPRICE)-DOU_UNITDISCOUNT),CHR_DESC, INT_TAXID, ROUND(DOU_TAX_PERCENTAGE,0),DOU_TAX_AMOUNT,IF(CHR_TYPE='I','ITEM','PRODUCT'),FUN_INV_PRODUCTCODE(CHR_TYPE,CHR_ITEMID),FUN_INV_PRODUCTDESCRIPTION(CHR_TYPE,CHR_ITEMID),FUN_INV_HSNCODE(CHR_TYPE,CHR_ITEMID),DOU_TOTAL,FUN_INV_UNITS(CHR_TYPE,CHR_ITEMID),CONCAT(INT_WARRANTY,'-Yrs')  FROM inv_t_swapsalesitem WHERE CHR_SALESNO ='"+salesno+"'";
			String iname="";
			String datas[][] = CommonFunctions.QueryExecute(sql);
			if(datas.length>0 )
			{
				s= s+ "<table  width=99% border='1' bordercolor='#CCCCCC' cellpadding=1 cellspacing=0 align='center'>";
				s= s+ "<tr  bgcolor='#ffffff'><th width='20' class='boldElevenPrint'><strong>S.No</strong></th>";
				s= s+ "<th  width='360' class='boldElevenPrint'><strong >Description</strong></th>";
				s= s+ "<th  width='50' class='boldElevenPrint'><strong >HSN/<br>SAC</strong></th>";
				s= s+ "<th  width='20' class='boldElevenPrint'><strong >QTY</strong></th>";
				s= s+ "<th  width='20' class='boldElevenPrint'><strong >UOM</strong></th>";
				s= s+ "<th  width='50' class='boldElevenPrint'><strong >Warranty</strong></th>";
				s= s+ "<th  width='50' class='boldElevenPrint'><strong >Unit Price</strong></th>";
				if(Discount.equals("Y")) {
					s= s+ "<th class='boldElevenPrint'><strong >Discount(%)</strong></th>";
					s= s+ "<th class='boldElevenPrint'><strong >Unit Discount</strong></th>";
				}
				s= s+ "<th  width='50' class='boldElevenPrint'><strong >Tax (%)</strong></th>";
				s= s+ "<th class='boldElevenPrint'><strong >Tax Amount</strong></th>";
				s= s+ "<th  width='50' class='boldElevenPrint'><strong >Total<br>(INR)</strong></th>";
					 
				for(int v=0;v<datas.length; v++)
				{	
					s= s+ "<tr><td   class='boldEleven' >"+(v+1)+".</td>";
					s= s+ "<td valign='top'   class='boldEleven' >"+datas[v][8] +"</td>";
					s= s+ "<td valign='top'   class='boldEleven' align='center'>"+datas[v][15] +"</td>";
					s= s+ "<td valign='top'   class='boldEleven'  align='center' >"+datas[v][3] +"</td>";
					s= s+ "<td valign='top'   class='boldEleven'  align='center' >"+datas[v][17]+"</td>";
					s= s+ "<td valign='top'   class='boldEleven'  align='center'>"+datas[v][18] +"</td>";
					s= s+ "<td valign='top'   class='boldEleven'  align='right'>"+datas[v][4]+"</td>";
					if(Discount.equals("Y")) {
						s= s+ "<td valign='top'   class='boldEleven'  align='right'>"+datas[v][5] +"</td>";
						s= s+ "<td valign='top'   class='boldEleven'  align='right'>"+datas[v][6]+"</td>";
					}
					s= s+ "<td valign='top'   class='boldEleven'  align='right'>"+datas[v][10]+" % </td>"; 
					s= s+ "<td valign='top'   class='boldEleven'  align='right'>"+datas[v][11]+"</td>";
					s= s+ "<td valign='top'   class='boldEleven'  align='right' >"+datas[v][7] +"</td>";
					s= s+ "</tr>";
					 
				}	
				sql = " SELECT  ROUND(SUM((INT_QUANTITY*DOU_UNITPRICE)),2) subtotal, ";
				sql = sql + " ROUND(SUM(DOU_TAX_AMOUNT),2) taxamount,  ";
				sql = sql + " ROUND(SUM(DOU_TAX_AMOUNT)* b.DOU_IGST/100,2) igst, ";
				sql = sql + " ROUND(SUM(DOU_TAX_AMOUNT)* b.DOU_CGST/100,2) cgst, ";
				sql = sql + " ROUND(SUM(DOU_TAX_AMOUNT)* b.DOU_SGST/100,2) sgst, ";
				sql = sql + " ROUND(SUM(DOU_TOTAL),2) total ";
				sql = sql + " FROM inv_t_swapsalesitem a , inv_m_tax b  WHERE a.INT_TAXID = b.INT_TAXID AND a.CHR_SALESNO ='"+salesno+"'";
				String taxSplit[][] =  CommonFunctions.QueryExecute(sql);
				if(taxSplit.length>0) {
					s= s+ "<tr class='boldEleven' align='right'>";	
					s= s+ "<td colspan='9'>Subtotal</td>";
					s= s+ "<td>"+taxSplit[0][0]+"</td>";
					s= s+ "</tr>";
					if("D".equals(perdata[0][66])) {
						s= s+ "<tr class='boldEleven' align='right'>";	
						s= s+ "<td colspan='9'>IGST</td>";
						s= s+ "<td>"+taxSplit[0][2]+"</td>";
						s= s+ "</tr>";
					} else {							
						s= s+ "<tr class='boldEleven' align='right'>";	
						s= s+ "<td colspan='9'>CGST</td>";
						s= s+ "<td>"+taxSplit[0][3]+"</td>";
						s= s+ "</tr>";
						s= s+ "<tr class='boldEleven' align='right'>";	
						s= s+ "<td colspan='9'>SGST</td>";
						s= s+ "<td>"+taxSplit[0][4]+"</td>";
						s= s+ "</tr>";
					
					}
					
					//TCS
					if("Y".equals(perdata[0][70])) {
						s= s+ "<tr class='boldEleven' align='right'>";	
						s= s+ "<td colspan='9'>TCS @ "+perdata[0][71]+"%</td>";
						s= s+ "<td>"+perdata[0][72]+"</td>";
						s= s+ "</tr>";
					}
					
					
					
					//TDS
					tdsamount= Double.parseDouble(perdata[0][12]);
					if(tdsamount > 0){
						s= s+ "<tr class='boldEleven' align='right'>";	
						s= s+ "<td colspan='9'>TDS @ "+perdata[0][11]+"%</td>";
						s= s+ "<td>"+perdata[0][12]+"</td>";
						s= s+ "</tr>";
					}
					//Round Off
					s= s+ "<tr class='boldEleven' align='right'>";	
					s= s+ "<td colspan='9'><b>Round Off</b></td>";
					s= s+ "<td>"+perdata[0][73]+"</td>";
					s= s+ "</tr>";
					s= s+ "<tr class='boldEleven' align='right'>";	
					s= s+ "<td colspan='9'><b>Net Total&nbsp;<img src='../Image/report/Rupee.jpeg' width='10' height='10'>&nbsp;&nbsp;</b></td>";
					s= s+ "<td><b>"+perdata[0][13]+"</b></td>";
					s= s+ "</tr>";
				}
				
				s= s+ "</table>";	
			}	
								  
			
			
			
			double tvalue=0;
			double igstvalue=0;
			double sgtvalue=0;
			double gstvalue=0;
			 
									 
			s= s+ "</td>";
			s= s+ "</tr>";
								
								
			s= s+ "<tr>";
			s= s+ "<td colspan='2'>";
			s= s+ "<div align='left'>";
			int row=1;
			iname="";
			sql = "SELECT INT_ID,CHR_SALESNO,CHR_ITEMID,CHR_SERIALNO,CHR_WARRANTY,CHR_TYPE,CHR_SWAPDESC,CHR_DESC,FUN_INV_PRODUCTCODE(CHR_TYPE,CHR_ITEMID) FROM inv_t_swapsalesserialno WHERE CHR_SALESNO ='"+salesno+"' ORDER By INT_ID";
			String recdData[][]= CommonFunctions.QueryExecute(sql);
			if(recdData.length>0)
				s= s+ "<span class='boldElevenprint'>Serial Number :<br></span>";
				
			if(datas.length>0)
			{
				for(int ip=0; ip<datas.length;ip++)
				{
					sql = "SELECT INT_ID,CHR_SALESNO,CHR_ITEMID,CHR_SERIALNO,CHR_WARRANTY,CHR_TYPE,CHR_SWAPDESC,CHR_DESC,FUN_INV_PRODUCTCODE(CHR_TYPE,CHR_ITEMID)";
					sql = sql + "  FROM inv_t_swapsalesserialno WHERE CHR_SALESNO = '"+salesno+"' AND CHR_ITEMID ='"+datas[ip][1]+"' AND CHR_TYPE='"+datas[ip][2]+"' ORDER By INT_ID";
					String serialnumberData[][]= CommonFunctions.QueryExecute(sql);
					String sserial="";
					if(serialnumberData.length>0) {
						s= s+ "<span class='boldElevenprint'>"+datas[ip][13]+" : &nbsp;&nbsp;</span> ";
						for(int sp=0; sp<serialnumberData.length;sp++)
							sserial = sserial + serialnumberData[sp][3]+",&nbsp;  " ;
						sserial = sserial.trim();
						sserial = sserial.substring(0,sserial.length()-1);
						sserial = sserial.trim();
						 
						s= s+ "<span class='boldEleven'>"+sserial+"</span>";
					}
					s= s+ "<br>";
				}
			}		
			s= s+ "</div> </td> </tr> ";
								 
			s= s+ "<tr> ";
			s= s+ "<td colspan='2'></td> ";
			s= s+ "</tr> ";
			 
			 
		  
		  s= s+ "</table> ";
		  s= s+ "</div> ";
		  s= s+ "</body> ";
		  s= s+ "</html> ";
			  
			}
			 catch(Exception e)
			 {
			 	System.out.println(e.getMessage());
			 }
		return s;

	}
}
