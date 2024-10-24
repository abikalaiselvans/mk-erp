 <%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*" errorPage="../error/index.jsp"%>
<%
try
{ 
	String sql="";
	String salesno = request.getParameter("salno");
	sql = " INT_SALESID,INT_BRANCHID,CHR_SALESNUMBER,	CHR_SALESREFNUMBER,	INT_CUSTOMERID,	CHR_ADDRESSFLAG,	CHR_ADDRESS,	INT_DIVIID,	DATE_FORMAT(DAT_SALEDATE,'%d-%m-%Y'),	INT_PAYMENTMODEID,	CHR_PAYMENTSTATUS,	CHR_SALESTYPE,	CHR_ORDERREF,	CHR_DELIVERYNOTE,	CHR_DESPATCHTHROUGH	,CHR_DESTINATION,	CHR_TERMSOFDELIVERY,	CHR_CONTACTPERSON,	CHR_CONTACTNO,	CHR_DES	,CHR_REF,	DOU_AMOUNT,	DOU_DISCOUNT,	INT_TAXID,	DOU_TAXAMOUNT,	DOU_TOTALAMOUNT,	INT_FINANCIALYEARID,	DT_UPDATEDATE,	CHR_USRNAME,	CHR_UPDATESTATUS ";

	 
	String perdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT "+sql+" FROM con_inv_t_sales WHERE CHR_SALESNUMBER='"+salesno+"'");
	
	
	
					   
String ssql="SELECT b.CHR_COMPANYNAME,a.CHR_BRANCHNAME,a.CHR_STREET,a.CHR_CITY,a.CHR_STATE,a.CHR_POSTAL,a.CHR_PHONE, ";
ssql = ssql +" a.CHR_FAX,a.CHR_EMAIL, a.CHR_TNGSTNO,a.CHR_CSTNO,a.CHR_REGNO,a.CHR_TINNO,a.CHR_LOCALTAXNO FROM com_m_branch a , com_m_company b ";
ssql = ssql +" WHERE  a.INT_BRANCHID="+ session.getAttribute("STKBRANCH") +"  AND a.INT_COMPANYID = b.INT_COMPANYID" ;
 
String cpydata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(ssql);
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
<title><%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='STK' ")[0][0]%></title></title>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="javascript" src="../JavaScript/comfunction.js"></script>

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
.style9 {COLOR: #666666; LINE-HEIGHT: 15px; FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; TEXT-DECORATION: none; font-size: 9px; }

 -->
 </style>
 

<script language="javascript">
</script>
</head>
 <body  onpaste="return false;" onLoad="javascript:window.print()" >


 
<div align="center"><br />
<table width="100%" border="0" cellspacing="1" cellpadding="1" >
	 
	<tr>
		<td>
		<table width="600" border="1" align="center" cellpadding="5" id="masterTbl"
			cellspacing="0" bordercolor="#000000">
			<tr>
				<td height="644">
				<table width="700" border="0" align="center" cellpadding="1"
					cellspacing="1">
					<tr>
						<td width="650"></td>
					</tr>
					<tr>
						<td>
						<div align="center" class="style3">Invoice</div>						</td>
					</tr>
					<tr>
						<td>
						<table width="100%" border="0" align="center" cellpadding="2"
							cellspacing="2">
							<tr>
								<td colspan="3" valign="top" class="boldEleven">
								<%
					   
					   
					   String sql1 ="SELECT CHR_NAME,CHR_ADD1,CHR_ADD2,CHR_CITY,INT_PINCODE,INT_PHONE FROM  m_institution ";
					   
					   out.println("<b>"+cpydata[0][0]+"</b>,<br>");
						if(!"-".equals(cpydata[0][2]))
							out.println(cpydata[0][2]+",<br>");
						if(!"-".equals(cpydata[0][3]))	
							out.println(cpydata[0][3]+",<br>");
						if(!"-".equals(cpydata[0][4]))
							out.println(cpydata[0][4]+",<br>");
						if(!"-".equals(cpydata[0][5]))
							out.println("PIN  : " +cpydata[0][5]+".");	
						if(!"-".equals(cpydata[0][6]))
							out.println("Phone : " +cpydata[0][6]+".");	
					   
					  %>								</td>
							</tr>
							<tr>
								<td width="308" valign="top" class="boldEleven">
								<table width="100%" border="0" cellspacing="2" cellpadding="0">
									<tr>
										<td width="36%" valign="top" class="boldEleven"><strong>
										Sales/Invoice .No </strong></td>
										<td width="64%" valign="top" class="boldEleven"><%=perdata[0][2]%></td>
									</tr>
									<tr>
										<td valign="top" class="boldEleven"><strong>Billing
										Address </strong></td>
										<td valign="top" class="boldEleven">
										
										<%
						sql = " SELECT CHR_CUSTOMERNAME ,CHR_STREET,CHR_CITY,CHR_MOBILE ,CHR_TIN FROM con_inv_m_customerinfo WHERE INT_CUSTOMERID="+Integer.parseInt(perdata[0][4]); 
						 
						String vendor[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
						 
						
						out.println(vendor[0][0]+",<br>");
						if(!"-".equals(vendor[0][1]))
							out.println(vendor[0][1]+",<br>");
						if(!"-".equals(vendor[0][2]))	
							out.println(vendor[0][2]+",<br>");
						if(!"-".equals(vendor[0][3]))
							out.println(vendor[0][3]);
						
						%>										</td>
									</tr>
									<tr>
										<td valign="top" class="boldEleven"><strong>Shipping
										Address </strong></td>
										<td valign="top" class="boldEleven">
										<%
										if("D".equals(perdata[0][5]))
											out.println(perdata[0][6].replaceAll(",", ",<br>"));
										else
										{
											out.println(vendor[0][0]+",<br>");
											if(!"-".equals(vendor[0][1]))
												out.println(vendor[0][1]+",<br>");
											if(!"-".equals(vendor[0][2]))	
												out.println(vendor[0][2]+",<br>");
											if(!"-".equals(vendor[0][3]))
												out.println(vendor[0][3]);
										}
											
											
										%>										</td>
									</tr>
									<tr>
										<td valign="top" class="boldEleven"><strong>TIN
										Number </strong></td>
										<td valign="top" class="boldEleven"><%=vendor[0][4]%></td>
									</tr>
								</table>								</td>
								<td width="278" valign="top" class="boldEleven">
								<table width="100%" height="185" border="0" cellpadding="0"
									cellspacing="2">
									<tr>
										<td width="40%" valign="top" class="boldEleven"><strong>Sale
										Date </strong></td>
										<td width="60%" valign="top" class="boldEleven">
										<%=perdata[0][8]%>										</td>
									</tr>
									<tr>
										<td valign="top" class="boldEleven"><strong>Order
										Reference </strong></td>
										<td valign="top" class="boldEleven"><%=perdata[0][12]%></td>
									</tr>
									<tr>
										<td valign="top" class="boldEleven"><strong>Delivery
										Note </strong></td>
										<td valign="top" class="boldEleven"><%=perdata[0][13]%></td>
									</tr>
									<tr>
										<td valign="top" class="boldEleven"><strong>Despatch
										Through </strong></td>
										<td valign="top" class="boldEleven"><%=perdata[0][14]%></td>
									</tr>
									<tr>
										<td valign="top" class="boldEleven"><strong>Destination</strong></td>
										<td valign="top" class="boldEleven"><%=perdata[0][15]%></td>
									</tr>
									<tr>
										<td valign="top" class="boldEleven"><strong>Terms
										of Delivery </strong></td>
										<td valign="top" class="boldEleven"><%=perdata[0][16]%></td>
									</tr>
									<tr>
										<td valign="top" class="boldEleven"><strong>Contact
										Person </strong></td>
										<td valign="top" class="boldEleven"><%=perdata[0][17]%></td>
									</tr>
									<tr>
										<td valign="top" class="boldEleven"><strong>Contact
										No </strong></td>
										<td valign="top" class="boldEleven"><%=perdata[0][18]%></td>
									</tr>
								</table>								</td>
							</tr>
						</table>						</td>
					</tr>
					<tr>
						<td height="9">
						<%
	sql = "SELECT c.CHR_GROUPNAME,b.CHR_ITEMNAME,b.CHR_DESC , a.INT_QUANTITY,d.CHR_SHORTNAME,a.DOU_UNITPRICE,a.DOU_DISCOUNT,";
	sql = sql + " a.DOU_UNITDISCOUNT,a.DOU_TOTAL  FROM con_inv_t_salesdetail a , con_inv_m_itemlist b,con_inv_m_itemgroup ";
	sql = sql + " c,con_inv_m_unites d WHERE a.INT_ITEMID=b.INT_ITEMID AND a.INT_GROUPID=c.INT_GROUPID";
	sql = sql + " AND a.INT_GROUPID=b.INT_GROUPID AND b.INT_GROUPID=c.INT_GROUPID AND d.INT_UNITID = c.INT_UNITID ";
	sql = sql + " AND a.CHR_SALESNUMBER ='"+salesno+"'";
	 
	String salesdetail[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	
	out.println("<table border=1 width=99% cellpadding=0 cellspacing=0>");
	out.println("<tr><th class='boldEleven'><strong>Sl.No</strong></th>");
	out.println("<th class='boldEleven'><strong >Item Group</strong></th>");
	out.println("<th class='boldEleven'><strong >Item Name</strong></th>");
	out.println("<th class='boldEleven'><strong >Description</strong></th>");
	out.println("<th class='boldEleven'><strong >Quantity</strong></th>");
	out.println("<th class='boldEleven'><strong >Unit Price</strong></th>");
	out.println("<th class='boldEleven'><strong >Discount(%)</strong></th>");
	out.println("<th class='boldEleven'><strong >Unit Discount</strong></th>");
	out.println("<th class='boldEleven'><strong >Total</strong></th>");
	for(int u=0;u<salesdetail.length;u++)
	{
	
		out.println("<tr><td   class='boldEleven' >"+(u+1)+"</td>");
		out.println("<td valign='top'   class='boldEleven' >"+salesdetail[u][0]);
		out.println("<td valign='top'   class='boldEleven'  align='right' >"+salesdetail[u][1] );
		out.println("<td valign='top'   class='boldEleven'  align='right'>"+salesdetail[u][2] );
		out.println("<td valign='top'   class='boldEleven'  align='right'>"+salesdetail[u][3] +" - ( "+salesdetail[u][4] +" )");
		out.println("<td valign='top'   class='boldEleven'  align='right' >"+salesdetail[u][5] );
		out.println("<td valign='top'   class='boldEleven'  align='right'>"+salesdetail[u][6] );
		out.println("<td valign='top'   class='boldEleven'  align='right'>"+salesdetail[u][7] );
		out.println("<td valign='top'   class='boldEleven'  align='right'>"+salesdetail[u][8] );
		
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
									<td width="240" rowspan="3" valign="top">
									<table width="227" border="0" cellspacing="2" cellpadding="0">
										<tr>
											<td width="92" class="boldEleven"><strong>Total
											Discount </strong></td>
											<td class="boldEleven">
											<div align="right"><%=perdata[0][22]%>(%)</div>											</td>
										</tr>
										<tr>
											<td class="boldEleven"><strong>Tax Name </strong></td>
											<td class="boldEleven">

											<div align="right">
											<%
							sql = "SELECT CHR_TAXNAME,DOU_VALUE FROM con_inv_m_tax WHERE INT_TAXID ="+perdata[0][23];
							String taxdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
							out.println(taxdata[0][0] );
							%>
											</div>											</td>
										</tr>
										<tr>
											<td class="boldEleven"><strong>Tax </strong></td>
											<td class="boldEleven">
											<div align="right"><%=taxdata[0][1] %>(%)</div>											</td>
										</tr>
									</table>									</td>
									<td valign="top" width="121">&nbsp;</td>
									<td width="140" valign="top" class="boldEleven">
									<div align="left"><strong>Total</strong></div>									</td>
									<td width="182" valign="top" class="boldEleven" id="totals1">
									<div align="right"><%=perdata[0][21]%></div>									</td>
								</tr>
								<tr>
									<td valign="top" width="121">&nbsp;</td>
									<td valign="top" class="boldEleven">
									<div align="left"><strong> Tax Amount </strong></div>									</td>
									<td width="182" valign="top" class="boldEleven"
										id="totaldiscount1">
									<div align="right"><%=perdata[0][24]%></div>									</td>
								</tr>
								<tr>
									<td valign="top" width="121">&nbsp;</td>
									<td valign="top" class="boldEleven">
									<div align="left"><strong>Net Total </strong></div>									</td>
									<td width="182" valign="top" class="boldEleven" id="tax1">
									<div align="right"><%=perdata[0][25]%></div>									</td>
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
					  	numberWord("<%=perdata[0][25]%>","Rupees") 
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
						<div align="center"></div>						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td></td>
					</tr>
					
					<tr>
						<td height="38" valign="top" class="boldEleven">
						<table width="99%" border="1" align="center" cellpadding="0"
							cellspacing="0">
							<tr>
								<td width="46%" valign="top">
								<table width="100%" border="0" cellspacing="2" cellpadding="2">
									<tr>
										<td class="boldEleven"><strong>Local Tax No</strong>.
										<%=cpydata[0][13]%></td>
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
					  <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td width="69%"><div align="justify"><strong>* Terms :</strong> <span class="style9">Goods once sold can't be taken back, Our responsibility ceases immediately after goods are delivere d to the Carrires, Interest @24% p.a. will be charged extra if bill is not paid within above mentioned payment terms. </span></div></td>
                          <td width="31%" valign="bottom"><div align="right"><strong>(Receiver Sign &amp; Seal ) </strong></div></td>
                        </tr>
                      </table></td>
				  </tr>
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
 

</body>
 </html>
