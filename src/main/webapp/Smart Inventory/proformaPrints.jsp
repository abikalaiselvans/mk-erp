 <%@ page contentType="text/html; charset=iso-8859-1" language="java" 	import="java.sql.*" errorPage="../error/index.jsp"%>
<%@ page import="com.my.org.erp.common.*"%>
<%@ page import="com.my.org.erp.common.CommonInfo"%>
<br><br><br><br><br><br>
<%
try
{ 
String sql="";
String proformanumber = request.getParameter("proformanumber");
String poId = proformanumber;
 sql="SELECT INT_PROFORMAID,CHR_PROFORMANO,INT_CUSTOMERID,"+
			" DATE_FORMAT(DAT_PROFORMADATE,'%d-%b-%Y'),DATE_FORMAT(DAT_REQUESTDATE,'%d-%b-%Y'),CHR_ONHOLD,INT_CONDITIONID,"+
			" CHR_DES,CHR_REF,INT_TAXID,DOU_DISCOUNT,DOU_TAXAMOUNT,"+
			" DOU_TOTALAMOUNT,CHR_STATUS,DOU_AMOUNT,CHR_ADDRESSID1,CHR_ADDRESSID2,CHR_CONTACTDETAILS,CHR_CONTACTNO,ROUND(DOU_TOTALAMOUNT,2), "+
			" CHR_ADDRESSFLAG,CHR_OTHERREF,FUN_INV_GET_PAYMENTTERM(INT_CONDITIONID) from  inv_t_proforma  where CHR_PROFORMANO='"+proformanumber+"'";
//out.println(sql);
String perdata[][]=CommonFunctions.QueryExecute(sql );
String purchaseInfo[][] =  CommonFunctions.QueryExecute(sql);	
				   
String ssql=" ";


ssql = " SELECT b.CHR_COMPANYNAME,a.CHR_BRANCHNAME,a.CHR_STREET,e.CHR_CITYNAME,d.CHR_STATENAME,a.INT_PINCODE,a.CHR_PHONE,  ";
ssql = ssql +" a.CHR_FAX,a.CHR_EMAIL, a.CHR_TNGSTNO,a.CHR_CSTNO,a.CHR_REGNO,a.CHR_TINNO,a.CHR_LOCALTAXNO,a.CHR_PANNO, "; 
ssql = ssql +" a.CHR_SERVICETAX ,d1.CHR_DISTRICT,a.CHR_CIN_NUMBER FROM com_m_branch a , com_m_company b ,com_m_country c, com_m_state d, com_m_district d1, com_m_city e ";
ssql = ssql +" WHERE  a.INT_CITYID = e.INT_CITYID ";
ssql = ssql +" AND a.INT_COUNTRYID = c.INT_COUNTRYID ";
ssql = ssql +" AND a.INT_STATEID =d.INT_STATEID AND a.INT_DISTRICTID =d1.INT_DISTRICTID  ";
ssql = ssql +" AND a.INT_COMPANYID = b.INT_COMPANYID  ";
ssql = ssql +" AND a.INT_BRANCHID="+ session.getAttribute("INVBRANCH");
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

%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>:: INVENTORY ::</title> 

<style type="text/css">
#header {visibility: hidden;}

#footer{visibility: hidden;}
 

</style>

   

 

<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/Inventory/InvenCustomerAJAX.js"></script>
<script language="JavaScript" src="../JavaScript/AJAX.js"></script>



<script language="javascript">
</script>

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
.style12 {
	font-size: 16px;
	font-weight: bold;
}
-->
</style>



</head>
<!--onLoad="javascript:window.print(), window.close()" onLoad="formatTableForPrint()"-->
<body     onLoad="javascript:window.print()">


<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm" >


<div align="center"> 
<table width="100%" border="0" cellspacing="1" cellpadding="1" >
	 
	<tr>
		<td>
		<table width="700" border="1" align="center" cellpadding="0"
			cellspacing="0" bordercolor="#000000"  id="masterTbl" >
			<tr>
				<td  >
				<table width="700" border="0" align="center" cellpadding="1"
					cellspacing="1">
					 
					<tr>
						<td colspan="2" >
						<div align="center" ><h1><%=request.getParameter("title")%></h1>
						  <%
						String qrcode="";
						%></div>						</td>
					    
					</tr>
					<tr>
						<td colspan="2">
						<table width="100%" border="0" align="center" cellpadding="2"
							cellspacing="2">
							 
							<tr>
								<td width="50%" height="106" valign="top" class="boldElevenPrint">
								<table width="100%" border="0" cellspacing="2" cellpadding="0">
									<tr>
										<td width="36%" valign="top" class="boldElevenPrint">
										Proforma Ref No </td>
										<td width="64%" valign="top" class="boldElevenPrint"><%=perdata[0][1]%>
										<%
										qrcode = qrcode+"Ref No : "+perdata[0][1]+"\n";
										%>
									  </td>
									</tr>
									<tr>
										<td valign="top" class="boldElevenPrint">Billing
										Address </td>
										<td valign="top" class="boldElevenPrint">
										<%
										//f.CHR_NAME
						sql="SELECT a.INT_CUSTOMERID,a.CHR_ALIASNAME ,a.CHR_ADDRESS1,a.CHR_ADDRESS2, e.CHR_CITYNAME,d.CHR_DISTRICT,c.CHR_STATENAME,  CONCAT('PIN :',a.INT_PINCODE),IF(LENGTH(a.CHR_PHONE)>4 ,CONCAT('Phone :',a.CHR_AREACODE,'-',a.CHR_PHONE),''),IF(LENGTH(a.CHR_MOBILE)>4 ,CONCAT('MOBILE :',a.CHR_MOBILE),''),IF(LENGTH(a.CHR_EMAIL )>4 ,CONCAT('E-Mail : :',a.CHR_EMAIL),''),a.CHR_TIN,CHR_CST FROM  inv_m_customerinfo a, com_m_country b,com_m_state c,com_m_district d,com_m_city e  ,inv_m_customergroup f   WHERE a.INT_CUSTOMERGROUPID = f.INT_CUSTOMERGROUPID   AND a.INT_COUNTRYID = b.INT_COUNTRYID    AND a.INT_STATEID =c.INT_STATEID    AND a.INT_DISTRICTID= d.INT_DISTRICTID   AND a.INT_CITYID =e.INT_CITYID AND a.INT_CUSTOMERID="+perdata[0][2];
			String customerData[][] =  CommonFunctions.QueryExecute(sql);
			
			 			if(!"-".equals(customerData[0][1]))
							out.println(customerData[0][1]+",<br>");
						if(!"-".equals(customerData[0][2]))	
							out.println(customerData[0][2]+",<br>");
						if(!"-".equals(customerData[0][3]))
							out.println(customerData[0][3]);
						if(!"-".equals(customerData[0][4]))	
							out.println(customerData[0][4]+",<br>");	
						if(!"-".equals(customerData[0][5]))	
							out.println(customerData[0][5]+",<br>");	
							if(!"-".equals(customerData[0][6]))	
							out.println(customerData[0][6]+",<br>");
						if(!"-".equals(customerData[0][7]))	
							out.println(customerData[0][7]+".<br>");	
						 				
						  
						 
										
										 
						
						
						%>										</td>
									</tr>
									<tr>
										<td valign="top" class="boldElevenPrint">Shipping
										Address </td>
										<td valign="top" class="boldElevenPrint">
										<%
						  	if("S".equals(perdata[0][20]))
							{
								
						
								 if(!"-".equals(customerData[0][1]))
									out.println(customerData[0][1]+",<br>");
								if(!"-".equals(customerData[0][2]))	
									out.println(customerData[0][2]+",<br>");
								if(!"-".equals(customerData[0][3]))
									out.println(customerData[0][3]);
								if(!"-".equals(customerData[0][4]))	
									out.println(customerData[0][4]+",<br>");	
								if(!"-".equals(customerData[0][5]))	
									out.println(customerData[0][5]+",<br>");	
									if(!"-".equals(customerData[0][6]))	
									out.println(customerData[0][6]+",<br>");
							}
							else
							{
								out.println(perdata[0][16]);
							}
							 
						  %>										</td>
									</tr>
									<tr>
										<td valign="top" class="boldElevenPrint">TIN
										Number </td>
										<td valign="top" class="boldElevenPrint"><%=customerData[0][11]%></td>
									</tr>
									<tr>
									  <td valign="top" class="boldElevenPrint">CST Number </td>
									  <td valign="top" class="boldElevenPrint"><%=customerData[0][12]%></td>
								  </tr>
							  </table>								</td>
							  <td valign="top" class="boldElevenPrint">
								<table width="100%" height="102" border="0" align="right" cellpadding="0"
									cellspacing="2">
									<tr>
										<td width="40%" height="18" valign="top" class="boldElevenPrint"> Date </td>
										<td width="60%" valign="top" class="boldElevenPrint"><%= perdata[0][3] %></td>
									</tr>
									<tr>
										<td height="18" valign="top" class="boldElevenPrint">Contact
										Person</td>
										<td valign="top" class="boldElevenPrint"><%=perdata[0][17]%></td>
									</tr>
									<tr>
										<td height="18" valign="top" class="boldElevenPrint">Contact Phone</td>
										<td valign="top" class="boldElevenPrint"><%=perdata[0][18]%></td>
									</tr>
									<tr>
									  <td height="18" valign="top" class="boldElevenPrint">Payment Terms</td>
									  <td valign="top" class="boldElevenPrint"><%=perdata[0][22]%></td>
								  </tr>
									<tr>
										<td height="18" valign="top" class="boldElevenPrint">Order
								  Reference<span class="ui-state-error-text"> </span></td>
										<td valign="top" class="boldElevenPrint"><%=perdata[0][21]%></td>
									</tr>
									 
								</table>								</td>
							</tr>
						</table>						</td>
					</tr>
					<tr>
					  <td height="9" colspan="2">
					  
					  <%
					  out.println("<table width='100%'  border='1' cellspacing='1' cellpadding='1' >");
						out.println("<tr>");
						out.println("<td  class='boldEleven' align='center'><b>S.No</b></td>");
						out.println("<td  class='boldEleven' align='center'><b>Type</b></td>");
						out.println("<td  class='boldEleven' align='center'><b>Item / Product</b></td>");
						out.println("<td  class='boldEleven' align='center'><b>Description</b></td>");
						out.println("<td  class='boldEleven' align='center'><b>Quantity</b></td>");
						out.println("<td  class='boldEleven' align='center'><b>Warranty</b></td>");
						out.println("<td  class='boldEleven' align='center'><b>Unit Price</b></td>");
						out.println("<td  class='boldEleven' align='center'><b>Total</b></td>");
						out.println("</tr>");
						sql = " SELECT  ";
						sql = sql +" if(a.CHR_TYPE='I','Item','Product'), ";
						sql = sql +" if( a.CHR_TYPE ='I' , ";
						sql = sql +" (SELECT a1.CHR_ITEMNAME FROM inv_m_item a1  WHERE  a1.CHR_ITEMID =a.CHR_ITEMID), ";
						sql = sql +" (SELECT a2.CHR_PRODUCTCODE FROM inv_m_produtlist a2  WHERE  a2.CHR_PRODUCTID =a.CHR_ITEMID)";
						sql = sql +" ) productcode, ";
						sql = sql +" a.CHR_DESC,a.INT_QUANTITY,a.DOU_UNITPRICE,a.DOU_DISCOUNT, a.DOU_UNITDISCOUNT, ";
						sql = sql +" b.CHR_TAXNAME,a.DOU_TAX_PERCENTAGE, ";
						sql = sql +" a.DOU_TOTAL ,a.DOU_TAX_AMOUNT,IF(a.INT_WARRANTY=0,'NO WARRANTY',CONCAT(a.INT_WARRANTY,'-Yrs'))  ";
						sql = sql +" from inv_t_proformaitem  a,inv_m_tax b ";
						sql = sql +"  WHERE a.INT_TAXID =b.INT_TAXID AND CHR_PROFORMANO ='"+poId+"' ";
						//out.println(sql);
						String purchaseItem[][] =  CommonFunctions.QueryExecute(sql);	
						String iname="";
						String itemname="";
						for(int i=0;i<purchaseItem.length;i++)
						{
							out.println("<tr>");
							out.println(" <td class='boldEleven'>&nbsp;"+(i+1)+".</td>");	
							out.println(" <td class='boldEleven'>&nbsp;"+purchaseItem[i][0]+"</td>");		
							out.println(" <td class='boldEleven'>&nbsp;"+purchaseItem[i][1]+"</td>");		
							out.println("<td class='boldEleven'>&nbsp;"+purchaseItem[i][2]+"</td>");		
							out.println("<td class='boldEleven' align='right'>&nbsp;"+purchaseItem[i][3]+"</td>");
							out.println("<td class='boldEleven' align='center'>&nbsp;"+purchaseItem[i][11]+"</td>");			
							out.println("<td class='boldEleven' align='right'>&nbsp;"+purchaseItem[i][4]+"</td>");		
							out.println("<td class='boldEleven' align='right'>&nbsp;"+purchaseItem[i][9]+"</td>");		
							out.println("</tr>");
						}
						out.println("</table>");
					  %></td>
				  </tr>
					<tr>
					  <td height="9" colspan="2"><table width="100%" border="0" cellpadding="2" cellspacing="2" class="boldElevenPrint">
                        <tr>
                          <td colspan="2" rowspan="4" align="left" valign="middle"><div align="left">
                            <%
						
						
                            out.println("<table border='1' cellpadding='2' cellspacing='0' bordercolor='#CCCCCC' width='300'>");
    						out.println("<tr   bgcolor='#ffffff'>");
    						out.println("<td class='boldElevenPrint' align='center'><b>Tax</b></td>");
    						out.println("<td class='boldElevenPrint' align='center'><b> Value</b></td>");
    						out.println("<td class='boldElevenPrint' align='center'><b>Tax Amount</b></td>");
    						out.println("</tr>");
    						double tvalue=0;
    						sql="SELECT SUM(a.DOU_UNITPRICE*a.INT_QUANTITY),b.CHR_TAXNAME,a.DOU_TAX_PERCENTAGE,SUM(a.DOU_TAX_AMOUNT)";
    						sql = sql + " FROM inv_t_customerquotationitem a, inv_m_tax b ";
    						sql = sql+ "  WHERE a.INT_TAXID = b.INT_TAXID AND a.DOU_TAX_PERCENTAGE >0 ";
    						sql = sql+ "  AND a.CHR_QUOTATIONNO ='"+poId+"' ";
    						sql = sql+ "  GROUP BY a.INT_TAXID ";
     						String tData[][] =  CommonFunctions.QueryExecute(sql);
    						if(tData.length>0)
    						{
    						 
    							for(int k=0; k<tData.length;k++)
    							{
    								out.println("<tr   bgcolor='#ffffff'>");
    								out.println("<td class='boldElevenPrint' >"+tData[k][1]+"</td>");
    								out.println("<td class='boldElevenPrint'  align='right' >"+tData[k][0]+"</td>");
    								out.println("<td class='boldElevenPrint'  align='right' >"+tData[k][3]+"</td>");
    								tvalue = tvalue + Double.parseDouble(tData[k][3]);
    								out.println("</tr>");
    							}
    						}
    						sql ="SELECT CHR_TAXNAME,DOU_VALUE FROM inv_m_tax WHERE INT_TAXID ="+purchaseInfo[0][9];
    						double taxvalues = Double.parseDouble(CommonFunctions.QueryExecute(sql)[0][1]);
    						if(taxvalues>0)
    						{
    							out.println("<tr   bgcolor='#ffffff'>");
    							out.println("<td class='boldElevenPrint' >"+CommonFunctions.QueryExecute(sql)[0][0]+"</td>");
    							out.println("<td class='boldElevenPrint' align='right' >"+ purchaseInfo[0][14] +"</td>");
    							out.println("<td class='boldElevenPrint' align='right' >"+ purchaseInfo[0][11] +"</td>");
    							tvalue = tvalue + Double.parseDouble(purchaseInfo[0][11]);
    							out.println("</tr>");
    						}	
    						out.println("</table>");
						%>
                          </div></td>
                          <td width="14%"><div align="left" class="boldElevenPrint">Sub Total</div></td>
                          <td width="19%"><div align="right"><%=perdata[0][14]%></div></td>
                        </tr>
                        <%
						double  dd = Double.parseDouble(perdata[0][10]);
						if(dd > 0)
						{
							out.println("<tr>");
							out.println("<td>Discount </td>");
							out.println("<td align='right'>"+perdata[0][10]+"</td>");
							out.println("</tr>");
						}
						%>
                    	<tr>
                          <td>Tax</td>
                          <td align="right">
						  <%
						  if(tvalue>0)
						  	out.println(""+com.my.org.erp.Math.MathFunction.keep2Digit(tvalue));
						  %>						  </td>
                        </tr>
                        <tr>
                          <td><span class="style12">Net Total </span></td>
                          <td><b><div align="right" class="style12"><%="<img src='../Image/report/Rupee.jpeg' width='10' height='10'>&nbsp;"+perdata[0][12]%>
						  
						   </div></b></td>
                        </tr>
                       
					    
								
					    </table></td>
				  </tr>
					 
					
					<tr height="50">
						<td colspan="2" class="bolddeeplogin"><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="22%" align="left" valign="top" class="boldElevenPrint">&nbsp;Amount in words ::</td>
    <td width="78%" align="left" valign="top" class="boldElevenPrint" >&nbsp;
    <div id="Rupees"><script language="javascript">numberWord("<%=perdata[0][12]%>","Rupees") </script></div></td>
  </tr>
</table></td>
					</tr>
					
					<tr>
						<td colspan="2" align="center" class="bold1"></td>
					</tr>
					 
					<tr>
						<td colspan="2">
						 		</td>
					</tr>
					<tr>
						<td colspan="2"><input name="filename" type="hidden" value="DirectSale" />
						<input name="actionS" type="hidden" value="INVDirectSaleAddserial" /></td>
					</tr>
					<tr>
						<td colspan="2"></td>
					</tr>
					
					<tr>
					  <td height="38" colspan="2" valign="top" class="boldElevenPrint"><table width="99%" border="1" align="center" cellpadding="0"
							cellspacing="0">
                        <tr>
                          <td width="49%" valign="top"><table width="99%" border="0" cellpadding="0" cellspacing="0">
                              <tr>
                                <td><br>
                                    <table width="99%" border="1" align="center" cellpadding="2" cellspacing="0" bordercolor="#CCCCCC">
                                      <!--<tr>
										<td class="boldElevenPrint"><strong>Local Tax No</strong>.
										<%=cpydata[0][13]%></td>
									</tr>-->
                                      <tr>
                                        <td width="25%" class="boldElevenPrint">PAN </td>
                                        <td width="32%" class="boldElevenPrint"><div align="left"><%=cpydata[0][14]%></div></td>
                                        <td class="boldElevenPrint">TIN </td>
                                        <td class="boldElevenPrint"><div align="left"><span class="style7"><%=cpydata[0][12]%></span></div></td>
                                      </tr>
                                      <tr>
                                        <td class="boldElevenPrint">SERVICE TAX </td>
                                        <td class="boldElevenPrint"><div align="left"><%=cpydata[0][15]%></div></td>
                                        <td class="boldElevenPrint">CST </td>
                                        <td class="boldElevenPrint"><div align="left"><%=cpydata[0][10]%></div></td>
                                      </tr>
                                      <tr>
                                        <td class="boldElevenPrint">CIN</td>
                                        <td class="boldElevenPrint"><div align="left"><%=cpydata[0][17]%></div></td>
                                        <td class="boldElevenPrint">&nbsp;</td>
                                        <td class="boldElevenPrint">&nbsp;</td>
                                      </tr>
                                  </table></td>
                              </tr>
                              <tr>
                                <td>&nbsp;</td>
                              </tr>
                              <tr>
                                <td bordercolor="#CCCCCC"><table width="99%" border="1" align="center" cellpadding="2" cellspacing="0" bordercolor="#CCCCCC">
                                    <!--<tr>
										<td class="boldElevenPrint"><strong>Local Tax No</strong>.
										<%=cpydata[0][13]%></td>
									</tr>-->
                                    <tr>
                                      <td colspan="4" class="boldElevenPrint">NEFT/RTGS Details </td>
                                    </tr>
                                    <tr>
                                      <td class="boldElevenPrint">A/c NAME</td>
                                      <td class="boldElevenPrint"><div align="left">Mythra IT SOLUTIONS PRIVATE    LIMITED</div></td>
                                      <td width="11%" class="boldElevenPrint">BANK</td>
                                      <td width="32%" class="boldElevenPrint"><div align="left">STANDARD CHARTERED BANK</div></td>
                                    </tr>
                                    <tr>
                                      <td class="boldElevenPrint">A/c NO</td>
                                      <td class="boldElevenPrint"><div align="left">42605104898</div></td>
                                      <td class="boldElevenPrint">IFSC CODE</td>
                                      <td class="boldElevenPrint"><div align="left">SCBL0036079</div></td>
                                    </tr>
                                </table></td>
                              </tr>
                              <tr>
                                <td>&nbsp;</td>
                              </tr>
                          </table></td>
                          <td width="51%" valign="top"><table width="100%" border="0" cellspacing="2" cellpadding="2">
                              <tr>
                                <td width="37%" rowspan="6" class="bold1" background="../qrservlet?qrtext=<%=qrcode%>" > 								 </td>
                                <td width="63%" class="boldElevenPrint"><div align="right" class="bold1"> <%="For  "+cpydata[0][0] %> </div></td>
                              </tr>
                              <tr>
                                <td class="boldElevenPrint">&nbsp;</td>
                              </tr>
                              <tr>
                                <td class="boldElevenPrint">&nbsp;</td>
                              </tr>
                              <tr>
                                <td class="boldElevenPrint">&nbsp;</td>
                              </tr>
                              <tr>
                                <td class="boldElevenPrint">&nbsp;</td>
                              </tr>
                              <tr>
                                <td class="boldElevenPrint"><div align="right">Authorised
                                Signatory </div></td>
                              </tr>
                              <tr>
                                <td colspan="2" class="boldElevenPrint">&nbsp;</td>
                              </tr>
                              <tr>
                                <td colspan="2" class="boldElevenPrint">&nbsp;</td>
                              </tr>
                          </table></td>
                        </tr>
                      </table></td>
					</tr>
					<tr>
					  <td colspan="2">&nbsp;</td>
				  </tr>
					<tr>
					  <td colspan="2"><div align="center"><span class="boldElevenPrint">
					    
				      </span></div></td>
				  </tr>
				</table>			</td>
			</tr>
		</table><br>	
		<div align="center" class="boldElevenPrint">
		  <%
					   
/*ssql = " SELECT b.CHR_COMPANYNAME,a.CHR_BRANCHNAME,a.CHR_STREET,e.CHR_CITYNAME,d.CHR_STATENAME,a.INT_PINCODE,a.CHR_PHONE,  ";
ssql = ssql +" a.CHR_FAX,a.CHR_EMAIL, a.CHR_TNGSTNO,a.CHR_CSTNO,a.CHR_REGNO,a.CHR_TINNO,a.CHR_LOCALTAXNO,a.CHR_PANNO, "; 
ssql = ssql +" a.CHR_SERVICETAX ,d1.CHR_DISTRICT,a.CHR_CIN_NUMBER FROM com_m_branch a , com_m_company b ,com_m_country c, com_m_state d, com_m_district d1, com_m_city e ";
ssql = ssql +" WHERE  a.INT_CITYID = e.INT_CITYID ";
ssql = ssql +" AND a.INT_COUNTRYID = c.INT_COUNTRYID ";
ssql = ssql +" AND a.INT_STATEID =d.INT_STATEID AND a.INT_DISTRICTID =d1.INT_DISTRICTID  ";
ssql = ssql +" AND a.INT_COMPANYID = b.INT_COMPANYID  ";
ssql = ssql +" AND a.INT_BRANCHID="+ session.getAttribute("BRANCHID");
//out.println(ssql);

*/ header ="<br>";					   
 header=cpydata[0][0]+" ";
if(!"-".equals(cpydata[0][2]))
	header=header+cpydata[0][2]+", ";
if(!"-".equals(cpydata[0][3]))	
	header=header+cpydata[0][3]+", ";
if(!"-".equals(cpydata[0][16]))	
	header=header+cpydata[0][16]+", ";
if(!"-".equals(cpydata[0][4]))
	header=header+cpydata[0][4]+", ";
if(!"-".equals(cpydata[0][5]))
	header=header+"PIN : " +cpydata[0][5]+". ";	
 out.println(header.toUpperCase());
					   
					   
					  %>		
	    </div><br></td>
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

<div align="center" class="style9"></div>
<div align="center"><span class="style9"><span class="style10"><!--Thank you for your Business...--></span></span>
</div>
</body>
</html>
