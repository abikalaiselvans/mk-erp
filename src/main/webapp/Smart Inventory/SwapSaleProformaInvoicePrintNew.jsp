    <%@ page contentType="text/html; charset=iso-8859-1" language="java" 	import="java.sql.*" errorPage="../error/index.jsp"%>
  <%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{ 
	String sql="";
	String salesno = request.getParameter("salno");
	String chkserial = ""+request.getParameter("serialyes");
	String chkserialno = ""+request.getParameter("serialno");
sql = " SELECT  ";
sql = sql +" INT_COMPANYID,INT_BRANCHID,INT_SALESID,CHR_SALESNO,DAT_SALESDATE,INT_PAYMENTTERMID,  ";
sql = sql +" INT_CUSTOMERID,CHR_DES,CHR_REF,DOU_AMOUNT,DOU_DISCOUNT,INT_TAXID,DOU_TAXAMOUNT,  ";
sql = sql +" DOU_TOTALAMOUNT,INT_SALESSTATUS,CHR_PAYMENTSTATUS,CHR_SALESTYPE,CHR_SHIPPING,  ";
sql = sql +" CHR_SHIPPINGADDRESS,CHR_OTHERREF,CHR_DELIVERYNOTE,CHR_DESPATCHTHRU,CHR_DESTINATION,  ";
sql = sql +" CHR_TERMSOFDELIVERY,CHR_CONTACTDETAILS,CHR_CONTACTNO,INT_DIVIID,CHR_ACCOUNTFLAG,  ";
sql = sql +" CHR_ACCOUNTDESC,IMG_INVOICE,CHR_NOOFPAYMENTCOMMITMENT,CHR_BYBACK,CHR_BYBACKDESC,  ";
sql = sql +" DOU_BYBACKAMOUNT,CHR_INSTALLATION,CHR_INSTALLATION_STATUS,CHR_INVOICEBLOCK,  ";
sql = sql +" INT_PAYMENT_COMMITMENT_DAYS,CHR_TAXTYPE,CHR_REF1,CHR_REF2,INT_REF_PERCENTAGE1,  ";
sql = sql +" INT_REF_PERCENTAGE2,INT_REF_PERCENTAGE3,CHR_DELIVERY,CHR_DELIVERYTHROUGH,  ";
sql = sql +" CHR_COURIER_EMPID,CHR_COURIER_EMPID_MOBILE,INT_COURIERID,DAT_COURIERDATE,  ";
sql = sql +" CHR_STARTING_PLACE,CHR_ENDING_PLACE,INT_COURIER_KILOMETER,CHR_COURIER_DESC,  ";
sql = sql +" DOU_COURIERAMOUNT,CHR_RECEIVERNAME,CHR_RECEIVER_MOBILE,DAT_DISPATCHEDDATE,  ";
sql = sql +" CHR_CLOSEDBY,CHR_RECEIVER_DESC,CHR_CANCEL,INT_PROJECTID,FUN_GET_SUBTOTAL(CHR_SALESNO),CHR_USRNAME,  ";
sql = sql +" DT_UPDATEDATE,CHR_UPDATESTATUS  ";
sql = sql +" FROM inv_t_directsales WHERE CHR_SALESNO='"+salesno+"'";
//out.println(sql);
String perdata[][]=CommonFunctions.QueryExecute(sql );
 
String cancellimage="";
if("Y".equals(perdata[0][60]))
	cancellimage=" background='../Image/report/cancelled1.jpg' ";
										   

String ssql = "SELECT b.CHR_COMPANYNAME,a.CHR_BRANCHNAME,a.CHR_STREET,e.CHR_CITYNAME,d.CHR_STATENAME,a.INT_PINCODE,a.CHR_PHONE,  ";
ssql = ssql +" a.CHR_FAX,a.CHR_EMAIL, a.CHR_TNGSTNO,a.CHR_CSTNO,a.CHR_REGNO,a.CHR_TINNO,a.CHR_LOCALTAXNO,a.CHR_PANNO, "; 
ssql = ssql +" b.CHR_SERVICETAX FROM com_m_branch a , com_m_company b ,com_m_country c, com_m_state d, com_m_city e ";
ssql = ssql +" WHERE  a.INT_CITYID = e.INT_CITYID ";
ssql = ssql +" AND a.INT_COUNTRYID = c.INT_COUNTRYID ";
ssql = ssql +" AND a.INT_STATEID =d.INT_STATEID ";
ssql = ssql +" AND a.INT_COMPANYID = b.INT_COMPANYID  ";
ssql = ssql +" AND a.INT_BRANCHID="+ session.getAttribute("BRANCHID");
 
String cpydata[][]=com.my.org.erp.common.CommonInfo.RecordSetArray(ssql);
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

%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>:: INVENTORY ::</title><%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/Inventory/InvenCustomerAJAX.js"></script>
<script language="JavaScript" src="../JavaScript/AJAX.js"></script>
<script language="javascript">
	function  Change(salno)
		{
			var width="800", height="400";
			var f =document.getElementById('serial').checked;
			var left = (screen.width/2) - width/2;
			var top = (screen.height/2) - height/2;
			var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=no,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
			 
			alert(salno);
			newWindow = window.open(salno,"subWind",styleStr);
			newWindow.focus( );
	}
	
	 
	
</script>
<style type="text/css">
<!--
.style3 {
	font-size: 18px;
	font-weight: bold;
}
.style7 {COLOR: #000000; LINE-HEIGHT: 15px; FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; TEXT-DECORATION: none; font-size: 10px;}
body {
	margin-top: .60in;
	 background-color:#FFFFFF;
	scrollbar-face-color: #fffff; 
	scrollbar-arrow-color: #ffffff; 
	scrollbar-track-color: #fffff; 
	scrollbar-shadow-color: #ffffff; 
	scrollbar-highlight-color:#fffff; 
	scrollbar-3dlight-color: #fffff; 
	scrollbar-darkshadow-Color: #fffff;
}

 -->
 </style>
 

<script language="javascript">
</script>
<link href="../JavaScript/SmartStyles.css" rel="stylesheet" type="text/css">
</head>
<!--onLoad="javascript:window.print(), window.close()" onLoad="formatTableForPrint()"-->
<body     onLoad="javascript:window.print()">


<form  AUTOCOMPLETE = "off"   action="../ServiceLoginAuth" method="post" name="frm" id="frm" >


<div align="center"><br />
<table width="100%" border="0" cellspacing="1" cellpadding="1" >
	 
	<tr>
		<td>
		<table width="600" border="1" align="center" cellpadding="0" id="masterTbl"
			cellspacing="0" bordercolor="#000000"  <%=cancellimage%>>
			<tr>
				<td height="757">
				<table width="700" border="0" align="center" cellpadding="1"
					cellspacing="1">
					<tr>
						<td width="650"></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td>
						<div align="center" class="style3"><%=request.getParameter("title").toUpperCase()%></div>						</td>
					</tr>
					<tr>
						<td>
						<table width="100%" border="0" align="center" cellpadding="2"
							cellspacing="2">
							<tr>
								<td colspan="3" valign="top" class="boldEleven">
								<%
					   
					   
					   String sql1 ="SELECT CHR_NAME,CHR_ADD1,CHR_ADD2,CHR_CITY,INT_PINCODE,INT_PHONE FROM m_institution";
					   
					   out.println("<b>"+cpydata[0][0]+"</b>,<br>");
						if(!"-".equals(cpydata[0][1]))
							out.println(cpydata[0][1]+",<br>");
						if(!"-".equals(cpydata[0][2]))	
							out.println(cpydata[0][2]+",<br>");
						if(!"-".equals(cpydata[0][3]))
							out.println(cpydata[0][3]+",<br>");
						if(!"-".equals(cpydata[0][4]))
							out.println("PIN  : " +cpydata[0][4]+".");	
						if(!"-".equals(cpydata[0][5]))
							out.println("Phone : " +cpydata[0][5]+".");	
					    
					  %>								</td>
							</tr>
							<tr>
								<td width="308" valign="top" class="boldEleven">
								<table width="100%" border="0" cellspacing="2" cellpadding="0">
									<tr>
										<td width="36%" valign="top" class="boldEleven"><strong>
										Sales/Invoice .No </strong></td>
										<td width="64%" valign="top" class="boldEleven"><%=perdata[0][3]%></td>
									</tr>
									<tr>
										<td valign="top" class="boldEleven"><strong>Billing
										Address </strong></td>
										<td valign="top" class="boldEleven">
										<%
										sql="SELECT a.INT_CUSTOMERID,a.CHR_ALIASNAME ,a.CHR_ADDRESS1,a.CHR_ADDRESS2, e.CHR_CITYNAME,d.CHR_DISTRICT,c.CHR_STATENAME,  CONCAT('PIN :',a.INT_PINCODE),CONCAT('Phone :',a.CHR_AREACODE,'-',a.CHR_PHONE),CONCAT('MOBILE :',a.CHR_MOBILE),CONCAT('E-Mail :',a.CHR_EMAIL),a.CHR_TIN,CHR_CST FROM  inv_m_customerinfo a, com_m_country b,com_m_state c,com_m_district d,com_m_city e  ,inv_m_customergroup f   WHERE a.INT_CUSTOMERGROUPID = f.INT_CUSTOMERGROUPID   AND a.INT_COUNTRYID = b.INT_COUNTRYID    AND a.INT_STATEID =c.INT_STATEID    AND a.INT_DISTRICTID= d.INT_DISTRICTID   AND a.INT_CITYID =e.INT_CITYID AND a.INT_CUSTOMERID="+perdata[0][6];
			String vendor[][] =  CommonFunctions.QueryExecute(sql);
			
			 if(!"-".equals(vendor[0][1]))
							out.println(vendor[0][1]+",<br>");
						if(!"-".equals(vendor[0][2]))	
							out.println(vendor[0][2]+",<br>");
						if(!"-".equals(vendor[0][3]))
							out.println(vendor[0][3]);
						if(!"-".equals(vendor[0][4]))	
							out.println(vendor[0][4]+",<br>");	
						if(!"-".equals(vendor[0][5]))	
							out.println(vendor[0][5]+",<br>");	
							if(!"-".equals(vendor[0][6]))	
							out.println(vendor[0][6]+",<br>");
						if(!"-".equals(vendor[0][7]))	
							out.println(vendor[0][7]+",<br>");	
						if(!"-".equals(vendor[0][8]))	
							out.println(vendor[0][9]+",<br>");									
		 
						
						%>										</td>
									</tr>
									<tr>
										<td valign="top" class="boldEleven"><strong>Shipping
										Address </strong></td>
										<td valign="top" class="boldEleven">
										<%
						  	if("S".equals(perdata[0][17]))
							{
								
						
								 if(!"-".equals(vendor[0][1]))
									out.println(vendor[0][1]+",<br>");
								if(!"-".equals(vendor[0][2]))	
									out.println(vendor[0][2]+",<br>");
								if(!"-".equals(vendor[0][3]))
									out.println(vendor[0][3]);
								if(!"-".equals(vendor[0][4]))	
									out.println(vendor[0][4]+",<br>");	
								if(!"-".equals(vendor[0][5]))	
									out.println(vendor[0][5]+",<br>");	
									if(!"-".equals(vendor[0][6]))	
									out.println(vendor[0][6]+",<br>");
								if(!"-".equals(vendor[0][7]))	
									out.println(vendor[0][7]+",<br>");	
								if(!"-".equals(vendor[0][8]))	
									out.println(vendor[0][9]+",<br>");									
												
																											
												
						 
							}
							else
							{
								out.println(perdata[0][18]);
							}
							
						  %>										</td>
									</tr>
									<tr>
                                      <td valign="top" class="boldElevenPrint"><strong>TIN
                                        Number </strong></td>
									  <td valign="top" class="boldElevenPrint"><%=vendor[0][11]%></td>
								  </tr>
									<tr>
                                      <td valign="top" class="boldElevenPrint"><strong>CST Number </strong></td>
									  <td valign="top" class="boldElevenPrint"><%=vendor[0][12]%></td>
								  </tr>
								</table>								</td>
								<td width="278" valign="top" class="boldEleven">
								<table width="100%" height="185" border="0" cellpadding="0"
									cellspacing="2">
									<tr>
										<td width="40%" valign="top" class="boldEleven"><strong>Sale
										Date </strong></td>
										<td width="60%" valign="top" class="boldEleven"><%=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(perdata[0][4])%></td>
									</tr>
									<tr>
										<td valign="top" class="boldEleven"><strong>Order
										Reference </strong></td>
										<td valign="top" class="boldEleven"><%=perdata[0][19]%></td>
									</tr>
									<tr>
										<td valign="top" class="boldEleven"><strong>Delivery
										Note </strong></td>
										<td valign="top" class="boldEleven"><%=perdata[0][20]%></td>
									</tr>
									<tr>
										<td valign="top" class="boldEleven"><strong>Despatch
										Through </strong></td>
										<td valign="top" class="boldEleven"><%=perdata[0][21]%></td>
									</tr>
									<tr>
										<td valign="top" class="boldEleven"><strong>Destination</strong></td>
										<td valign="top" class="boldEleven"><%=perdata[0][22]%></td>
									</tr>
									<tr>
										<td valign="top" class="boldEleven"><strong>Terms
										of Delivery </strong></td>
										<td valign="top" class="boldEleven"><%=perdata[0][23]%></td>
									</tr>
									<tr>
										<td valign="top" class="boldEleven"><strong>Contact
										Person </strong></td>
										<td valign="top" class="boldEleven"><%=perdata[0][24]%></td>
									</tr>
									<tr>
										<td valign="top" class="boldEleven"><strong>Contact
										No </strong></td>
										<td valign="top" class="boldEleven"><%=perdata[0][25]%></td>
									</tr>
								</table>								</td>
							</tr>
						</table>						</td>
					</tr>
					<tr>
						<td height="9">
						<%
					sql = "SELECT CHR_SALESNO,CHR_ITEMID,CHR_TYPE ,INT_QUANTITY,DOU_UNITPRICE,DOU_DISCOUNT,DOU_UNITDISCOUNT,( DOU_UNITPRICE * INT_QUANTITY),CHR_DESC  FROM inv_t_swapsalesitem WHERE CHR_SALESNO ='"+salesno+"'";
					String iname="";
					String itemname="";
					String datas[][] = com.my.org.erp.common.CommonInfo.RecordSetArray(sql);
					String typedesc="";	
					out.println("<table border=1 width=99%  cellpadding=2 cellspacing=1 bgcolor='#000000' align='center'>");
					out.println("<tr bgcolor='#ffffff'><th class='boldEleven'><strong>Sl.No</strong></th>");
                    out.println("<th class='boldEleven'><strong >Product Code</strong></th>");
					out.println("<th class='boldEleven'><strong >Description</strong></th>");
					out.println("<th class='boldEleven'><strong >Quantity/Units</strong></th>");
					out.println("<th class='boldEleven'><strong >Unit Price</strong></th>");
					out.println("<th class='boldEleven'><strong >Discount(%)</strong></th>");
					out.println("<th class='boldEleven'><strong >Unit Discount</strong></th>");
					out.println("<th class='boldEleven'><strong >Total</strong></th>");
					     
					for(int v=0;v<datas.length; v++)
					{	
						 
						if(datas[v][2].equals("I"))
						{
							iname="Item";
							sql = "SELECT CHR_ITEMNAME ,CHR_WARRANTY,CHR_DES FROM inv_m_item WHERE CHR_ITEMID='"+datas[v][1]+"'";
							itemname = com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_ITEMNAME");
							typedesc=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_DES");
						}	
						if(datas[v][2].equals("P"))
						{
						  iname="Product";
						  sql= "SELECT CHR_PRODUCTCODE,CHR_WARRANTY,CHR_PRODUCTDESC FROM inv_m_produtlist WHERE CHR_PRODUCTID='"+datas[v][1]+"'";
						  itemname=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_PRODUCTCODE");
						  typedesc=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_PRODUCTDESC");
						}	
						out.println("<tr  bgcolor='#ffffff'><td   class='boldEleven' >"+(v+1)+"</td>");
						out.println("<td valign='top'   class='boldEleven' >"+itemname );
						out.println("<td valign='top'   class='boldEleven' >"+datas[v][8]);
						out.println("<td valign='top'   class='boldEleven'  align='right' >"+datas[v][3] );
						out.println("<td valign='top'   class='boldEleven'  align='right'>"+datas[v][4] );
						out.println("<td valign='top'   class='boldEleven'  align='right'>"+datas[v][5] );
						out.println("<td valign='top'   class='boldEleven'  align='right'>"+datas[v][6] );
						out.println("<td valign='top'   class='boldEleven'  align='right' >"+datas[v][7] );
					}	
					out.println("</table>");	
					  %>						</td>
					</tr>
					<tr>
						<td valign="top">
						<table cellspacing="1" cellpadding="1" width="100%" align="center"
							border="0">
							<tbody>
								<tr>
									<td width="353" rowspan="2" valign="top">
									  <div align="left">
                                        <%
						
						
						sql="SELECT SUM(a.DOU_UNITPRICE*a.INT_QUANTITY),b.CHR_TAXNAME,a.DOU_TAX_PERCENTAGE,SUM(a.DOU_TAX_AMOUNT)";
						sql = sql + " FROM inv_t_swapsalesitem a, inv_m_tax b ";
						sql = sql+ "  WHERE a.INT_TAXID = b.INT_TAXID AND a.DOU_TAX_PERCENTAGE >0 ";
						sql = sql+ "  AND a.CHR_SALESNO ='"+salesno+"' ";
						sql = sql+ "  GROUP BY a.INT_TAXID ";
 						String tData[][] =  CommonFunctions.QueryExecute(sql);
						
						sql ="SELECT CHR_TAXNAME,DOU_VALUE FROM inv_m_tax WHERE INT_TAXID ="+perdata[0][11];
						double taxvalues = Double.parseDouble(CommonFunctions.QueryExecute(sql)[0][1]);
						
						if(tData.length>0 || taxvalues>0)
						{
							out.println("<table border='1' cellpadding='2' cellspacing='0' bordercolor='#CCCCCC' width='300'>");
							out.println("<tr   bgcolor='#ffffff'>");
							out.println("<td class='boldElevenPrint' align='center'><b>Tax</b></td>");
							out.println("<td class='boldElevenPrint' align='center'><b> Value</b></td>");
							out.println("<td class='boldElevenPrint' align='center'><b>Tax Amount</b></td>");
							out.println("</tr>");
							
							
							if(tData.length>0)
							{
							 
								for(int k=0; k<tData.length;k++)
								{
									out.println("<tr   bgcolor='#ffffff'>");
									out.println("<td class='boldElevenPrint' >"+tData[k][1]+"</td>");
									out.println("<td class='boldElevenPrint'  align='right' >"+tData[k][0]+"</td>");
									out.println("<td class='boldElevenPrint'  align='right' >"+tData[k][3]+"</td>");
									out.println("</tr>");
								}
							}
							if(taxvalues>0)
							{
								out.println("<tr   bgcolor='#ffffff'>");
								out.println("<td class='boldElevenPrint' >"+CommonFunctions.QueryExecute(sql)[0][0]+"</td>");
								out.println("<td class='boldElevenPrint' align='right' >"+ perdata[0][9] +"</td>");
								out.println("<td class='boldElevenPrint' align='right' >"+ perdata[0][12] +"</td>");
								out.println("</tr>");
							}	
							out.println("</table>");
						}	
						%>
                                      </div></td>
									<td valign="top" width="10">&nbsp;</td>
									<td width="140" valign="top" class="boldEleven">
									<div align="left"><strong>Sub Total</strong></div>									</td>
									<td width="182" valign="top" class="boldEleven" id="totals1">
									<div align="right"><%=perdata[0][62]%></div>									</td>
								</tr>
								 
								<tr>
								  <td valign="top" width="10">&nbsp;</td>
									<td valign="top" class="boldEleven">
									<div align="left"><H2>Net Total </H2></div>									</td>
									<td width="182" valign="top" class="boldEleven" id="tax1">
									<div align="right"><H2><%=perdata[0][13]%></H2></div>									</td>
								</tr>
							</tbody>
						</table>						</td>
					</tr>
					<tr>
						<td class="bolddeeplogin">Amount in words ::</td>
					</tr>
					<tr>
						<td>
						<table width="80%" border="0" align="center" cellpadding="0"
							cellspacing="0">
							<tr>
								<td align="center" class="boldEleven">
								<div id="Rupees"><script language="javascript">
					  	numberWord("<%=perdata[0][13]%>","Rupees") 
					  </script></div>								</td>
							</tr>
						</table>						</td>
					</tr>
					<tr>
						<td align="center" class="bold1"></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td>
						<div align="center">
						<%
	int row=1;
	iname="";
	itemname="";
	String masterwarranty="";
	String h="";
	String h1="";
	
	sql = "SELECT INT_ID,CHR_SALESNO,CHR_ITEMID,CHR_SERIALNO,CHR_WARRANTY,CHR_TYPE,CHR_SWAPDESC,CHR_DESC FROM inv_t_swapsalesserialno WHERE CHR_SALESNO ='"+salesno+"' ORDER By INT_ID";
		//out.println(sql);
		String recdData[][]= com.my.org.erp.common.CommonInfo.RecordSetArray(sql);
	 
				
	 	 
%>  </div>						</td>
					</tr>
					<tr>
						<td> </td>
					</tr>
					<tr>
						<td></td>
					</tr>
					
					<tr>
						<td height="38" valign="top" class="boldEleven">
						<table width="99%" border="1" align="center" cellpadding="0"
							cellspacing="0" bordercolor="#333333">
							<tr>
								<td width="46%" valign="top">
								<table width="100%" border="0" cellspacing="2" cellpadding="2">
									<!--<tr>
										<td class="boldEleven"><strong>Local Tax No</strong>.
										<%=cpydata[0][13]%></td>
									</tr>-->
									<tr>
									  <td class="boldEleven"><strong>PAN No</strong>. <%=cpydata[0][14]%></td>
								  </tr>
									<tr>
										<td class="boldEleven"><strong>CST No : </strong> <%=cpydata[0][10]%>										</td>
									</tr>
									<tr>
										<td><span class="boldEleven"><strong>TIN
										No : </strong></span><span class="style7"><%=cpydata[0][12]%></span></td>
									</tr>
									<tr>
										<td class="boldEleven"><strong>Declaration </strong>:</td>
									</tr>
									<tr>
										<td class="boldEleven">
										<div align="justify">We declare that this invoice shows
										the actual price of the good descibed and that all particulars
										are true and correct.</div>										</td>
									</tr>
								</table>								</td>
								<td width="54%" valign="top">
								<table width="100%" border="0" cellspacing="2" cellpadding="2">
									<tr>
										<td class="bolddeeplogin">
										<div align="right">
										<%
						out.println("For  "+cpydata[0][0]);
						%>
										</div>										</td>
									</tr>
									<tr>
										<td class="boldEleven">&nbsp;</td>
									</tr>
									<tr>
										<td class="boldEleven">&nbsp;</td>
									</tr>
									<tr>
										<td class="boldEleven">&nbsp;</td>
									</tr>
									<tr>
										<td class="boldEleven">
										<div align="right"><strong>(Authorised
										Signatory ) </strong></div>										</td>
									</tr>
								</table>								</td>
							</tr>
						</table>						</td>
					</tr>
					<tr>
					  <td>&nbsp;</td>
				  </tr>
					<tr><td>
                      <div align="right">
                        <%
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("EEE  dd-MMM-yyyy HH:mm a");
        java.util.Date currDate = new java.util.Date();
        out.println( sdf.format(currDate));
%>
                      </div></td></tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
</div>

  <%
}
 catch(Exception e)
 {
 	out.println(e.getMessage());
 }
  
%>
</form>

</body>
<%@ page import="com.my.org.erp.common.CommonInfo"%>
</html>
