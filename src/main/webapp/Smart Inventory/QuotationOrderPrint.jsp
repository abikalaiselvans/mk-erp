<%@ page contentType="text/html; charset=iso-8859-1" language="java" 	import="java.sql.*" errorPage="../error/index.jsp"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>

<%
	try{
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>:: INVENTORY ::</title><%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
 
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
body {
	margin-left: .5px;
	margin-top: .5px;
	margin-right: .5px;
	margin-bottom: .5px;
}
-->
</style>
</head>
<%
	 
	String poId=request.getParameter("quotationnumber");
	String sql="SELECT INT_QUOTATIONID,CHR_QUOTATIONNO,INT_CUSTOMERID,"+
				" DATE_FORMAT(DAT_QUOTATIONDATE,'%d-%b-%Y'),DATE_FORMAT(DAT_REQUESTDATE,'%d-%b-%Y'),CHR_ONHOLD,INT_CONDITIONID,"+
				" CHR_DES,CHR_REF,INT_TAXID,DOU_DISCOUNT,DOU_TAXAMOUNT,"+
				" DOU_TOTALAMOUNT,CHR_STATUS,DOU_AMOUNT,CHR_ADDRESSID1,CHR_ADDRESSID2,CHR_CONTACTDETAILS,CHR_CONTACTNO,ROUND(DOU_TOTALAMOUNT,2) "+
				" from  inv_t_customerquotation  where CHR_QUOTATIONNO='"+poId+"'";
	//out.println(sql);			
	String purchaseInfo[][] =  CommonFunctions.QueryExecute(sql);	
	
	 
	 
%>
<body    onLoad="javascript:window.print()">
<br><br> 
<table width="800" border="1" cellpadding="0" cellspacing="0" bordercolor="#999999" align="center">
	<tr>
		<td align="center" valign="middle">
		  <table width="95%" border="0" align="center" cellpadding="1"
			cellspacing="1">
			<tr>
				<td width="650"></td>
			</tr>
			<tr>
				<td height="27" class="boldEleven">
				<div align="center" class="style4"><span class="bold1">QUOTATION</span>
				<%
				String ssql=" " ;
		ssql = " SELECT b.CHR_COMPANYNAME,a.CHR_BRANCHNAME,a.CHR_STREET,e.CHR_CITYNAME,d.CHR_STATENAME,a.INT_PINCODE,a.CHR_PHONE,  ";
ssql = ssql +" a.CHR_FAX,a.CHR_EMAIL, a.CHR_TNGSTNO,a.CHR_CSTNO,a.CHR_REGNO,a.CHR_TINNO,a.CHR_LOCALTAXNO,a.CHR_PANNO, "; 
ssql = ssql +" b.CHR_SERVICETAX ,d1.CHR_DISTRICT FROM com_m_branch a , com_m_company b ,com_m_country c, com_m_state d, com_m_district d1, com_m_city e ";
ssql = ssql +" WHERE  a.INT_CITYID = e.INT_CITYID ";
ssql = ssql +" AND a.INT_COUNTRYID = c.INT_COUNTRYID ";
ssql = ssql +" AND a.INT_STATEID =d.INT_STATEID AND a.INT_DISTRICTID =d1.INT_DISTRICTID  ";
ssql = ssql +" AND a.INT_COMPANYID = b.INT_COMPANYID  ";
ssql = ssql +" AND a.INT_BRANCHID="+ session.getAttribute("BRANCHID");
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

				
				%></div>				</td>
			</tr>
			<tr>
			  <td>
			  <%
			  	String s=  "<b>"+cpydata[0][0]+"</b>,<br>" ;
				if(!"-".equals(cpydata[0][2]))
					s= s+ cpydata[0][2]+",<br>" ;
				if(!"-".equals(cpydata[0][3]))	
					s= s+ cpydata[0][3]+",<br>"  ;
				if(!"-".equals(cpydata[0][4]))
					s= s+ cpydata[0][4]+",<br>"  ;
				if(!"-".equals(cpydata[0][5]))
					s= s+ "PIN  : " +cpydata[0][5]+".<br> " ;	
				if(!"-".equals(cpydata[0][6]))
					s= s+ "Phone : " +cpydata[0][6]+"." ;	
		   
		   		out.println(s);
			  %>			  </td>
		    </tr>
			<tr>
				<td>
				<table width="99%" border="0" align="center" cellpadding="5"
					cellspacing="3">
					<tr>
						<td width="123" align="left" valign="top" class="boldEleven">
						<div align="left"><strong>Quotation No</strong></div>						</td>
						<td width="229" align="left" valign="top" class="boldEleven">
						<div align="left"><%=purchaseInfo[0][1]%></div>						</td>
						<td width="107" align="left" valign="top" class="boldEleven">
						<div align="left"><strong> </strong><strong>Payment Terms </strong></div>						</td>
						<td width="201" align="left" valign="top" class="boldEleven">
						<div align="left">
						  <%
							String paymentids[][] =  CommonFunctions.QueryExecute("Select INT_PAYMENTTERMID,CHR_PAYMENTNAME from inv_m_paymentterms where INT_PAYMENTTERMID="+purchaseInfo[0][6]);
									 out.print(paymentids[0][1]);
							%>
</div>						</td>
					</tr>
					<tr>
						<td align="left" valign="top" class="boldEleven"><strong><strong>Contact Person </strong>
						</strong></td>
						<td align="left" valign="top" class="boldEleven"><%= purchaseInfo[0][17]  %> </td>
						<td align="left" valign="top" class="boldEleven">
						<div align="left"><strong>Quotation Date</strong></div>						</td>
						<td align="left" valign="top" class="boldEleven">
						<div align="left"><%= (purchaseInfo[0][3]) %></div>						</td>
					</tr>
					<tr>
					  <td align="left" valign="top" class="boldEleven"><strong>Contact Number </strong></td>
					  <td align="left" valign="top" class="boldEleven"><%= purchaseInfo[0][18]  %></td>
					  <td align="left" valign="top" class="boldEleven"><strong>Request Date</strong></td>
					  <td align="left" valign="top" class="boldEleven"><%= (purchaseInfo[0][4]) %></td>
				  </tr>
					 
					<tr>
					  <td align="left" valign="top" class="boldEleven"><strong>Order From </strong></td>
					  <td align="left" valign="top" class="boldEleven"><%=  purchaseInfo[0][15]  %></td>
					  <td align="left" valign="top" class="boldEleven"><strong>Shipping To </strong></td>
					  <td align="left" valign="top" class="boldEleven"><%= purchaseInfo[0][16]  %></td>
				  </tr>
					<tr>
					  <td align="left" valign="top" class="boldEleven"><strong>Description </strong></td>
					  <td colspan="3" align="left" valign="top" class="boldEleven"><%=purchaseInfo[0][7] %></td>
				  </tr>
					<tr>
					  <td align="left" valign="top" class="boldEleven">&nbsp;</td>
					  <td align="left" valign="top" class="boldEleven">&nbsp; </td>
					  <td align="left" valign="top" class="boldEleven">&nbsp;</td>
					  <td align="left" valign="top" class="boldEleven">&nbsp;</td>
				  </tr>
				</table>				</td>
			</tr>
			<tr>
				<td>
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
						//out.println("<td  class='boldEleven'><b>Discount(%)</b></td>");
						//out.println("<td  class='boldEleven'><b>Unit Discount</b></td>");
						//out.println("<td  class='boldEleven'><b>Tax</b></td>");
						//out.println("<td  class='boldEleven'><b>Tax (%)</b></td>");
						//out.println("<td  class='boldEleven'><b>Tax Amount </b></td>");
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
						sql = sql +" from inv_t_customerquotationitem  a,inv_m_tax b ";
						sql = sql +"  WHERE a.INT_TAXID =b.INT_TAXID AND CHR_QUOTATIONNO ='"+poId+"' ";
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
							//out.println("<td class='boldEleven' align='right'>&nbsp;"+purchaseItem[i][5]+"</td>");		
							//out.println("<td class='boldEleven' align='right'>&nbsp;"+purchaseItem[i][6]+"</td>");		
							//out.println("<td class='boldEleven' align='right'>&nbsp;"+purchaseItem[i][7]+"</td>");		
							//out.println("<td class='boldEleven' align='right'>&nbsp;"+purchaseItem[i][8]+"</td>");		
							//out.println("<td class='boldEleven' align='right'>&nbsp;"+purchaseItem[i][9]+"</td>");		
							out.println("<td class='boldEleven' align='right'>&nbsp;"+purchaseItem[i][9]+"</td>");		
							out.println("</tr>");
						}
						out.println("</table>");
					%>				</td>
			</tr>
			<tr>
				<td>
				<div align="left"></div>				</td>
			</tr>
			<tr>
				<td></td>
			</tr>
			<tr>
				<td valign="top" class="boldEleven">
				<table width="100%" border="0" align="center" cellpadding="1"
					cellspacing="1">
					<tr>
						<td rowspan="4" align="left" valign="top" class="boldEleven">
						
						<div align="left">
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
                          </div>					  </td>
						<td width="148"   valign="top" class="boldEleven">
						<div align="left"><strong>Total</strong></div>						</td>
						<td  valign="top" class="boldEleven" id="totals1">
						  <div align="right"><%=purchaseInfo[0][14]%></div></td>
					</tr>
					<tr>
					  <td valign="top" class="boldEleven"><strong>Discount [%] </strong></td>
					  <td valign="top" class="boldEleven"
							id="totaldiscount2"><div align="right"><%=tvalue%></div></td>
				  </tr>
					<tr>
					  <td valign="top" class="boldEleven"><strong>Tax Amount </strong></td>
					  <td valign="top" class="boldEleven"
							id="totaldiscount1"><div align="right"><%=tvalue%></div></td>
				  </tr>
					<tr>
					  <td valign="top" class="boldEleven"><div align="left" class="bold1"><strong>Net Total </strong></div>						  <strong>
					  </strong></td>
						<td width="123" valign="top" class="bold1"
							id="totaldiscount1"><div align="right"><%=purchaseInfo[0][12] %></div></td>
					</tr>
					 
					 
					 
					<tr>
					  <td colspan="3" class="boldEleven"> </td>
				  </tr>
					<tr>
					  <td colspan="3" class="boldEleven"><span class="bolddeeplogin">Amount in words ::</span></td>
				  </tr>
					<tr>
					  <td colspan="3" class="boldEleven" align="center">
					 <div id="Rupees">
					   
					     <script language="javascript">numberWord("<%=purchaseInfo[0][19]%>","Rupees") </script>
					 </div>					  </td>
				  </tr>
				</table>				</td>
			</tr>
		</table>
	  </td>
	</tr>
</table>
</div>

</body>
<%
	}
	catch(Exception e)
	{
		System.out.println(e.getMessage());
		out.println(e.getMessage());
	}
%>
</html>
<br> 
<br>
