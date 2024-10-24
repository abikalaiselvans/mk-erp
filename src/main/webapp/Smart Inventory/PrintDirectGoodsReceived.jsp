<%@ page language="java" import="java.sql.*" errorPage="../error/index.jsp"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="com.my.org.erp.common.CommonInfo"%>
<%
try
{
	%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>:: INVENTORY ::</title><%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/Inventory/InvenAJAX.js"></script>

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
body {
	margin-left: .5cm;
	margin-top: 1cm;
	margin-right: 0.5cm;
	margin-bottom: 1cm;
}
-->
</style>
</head>
<%
 
	String goodsRecNo=""+request.getParameter("gdreceiveno");
	if("null".equals(goodsRecNo))
		response.sendRedirect("GoodsRecived.jsp");
	String sql="";

	String salesid = goodsRecNo;
 
	sql ="select INT_BRANCHID,CHR_PURCHASEORDERNO,INT_VENDORID,DATE_FORMAT(DAT_ORDERDATE,'%d-%b-%Y'),INT_PAYMENTTERMID ";
	sql = sql +",CHR_DES,FIND_A_EMPLOYEE_ID_NAME(CHR_REF),DOU_AMOUNT,DOU_DISCOUNT,INT_TAXID,DOU_TAXAMOUNT,DOU_TOTALAMOUNT, ";
	sql = sql +" DOU_PAIDAMOUNT,CHR_PAYMENTSTATUS,INT_DIVIID,CHR_VENDORPO,DOU_ROUNDED,CHR_POREQUESTNO, CHR_CANCEL, ";
	sql = sql +" IF(CHR_BASEVALUE='Y',DOU_BASEAMOUNT,ROUND((DOU_AMOUNT-(DOU_AMOUNT*DOU_DISCOUNT/100)),2) ),DOU_FRIEGHT_CHARGE_BASE_AMOUNT,DOU_FRIEGHT_CHARGE_PERCENT, DOU_FRIEGHT_CHARGE  ";
	sql = sql +" from inv_t_directpurchase WHERE CHR_PURCHASEORDERNO ='"+salesid+"'";
	//out.println(sql);
	
	String branchid = session.getAttribute("BRANCHID").toString();
	String cashdata[][] = CommonFunctions.QueryExecute(sql);
	String cancellimage="";
	if("Y".equals(cashdata[0][18]))
		cancellimage=" background='../Image/report/cancelled1.jpg' ";

	
%>
<body >
<form  AUTOCOMPLETE = "off"   action="" method="post" name="frm" id="frm">
<div align="center"> 
<table width="700" border="1"  cellpadding="0" cellspacing="0" bordercolor="#000000" align="center">
	<tr>
		<td>
		<table width="663" border="0" align="left" cellpadding="0" cellspacing="0" <%=cancellimage%> >
			<tr>
				<td width="650"></td>
			</tr>
			<tr>
				<td align="center" class="bolddeeplogin">
				<div align="center"><h2>PURCHASE INVOICE</h2> </div>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>
				<table width="673" border="0" align="center" cellpadding="1"
					cellspacing="1">
					<tr>
						<td width="150" valign="top" class="boldEleven">
						<div align="left"><strong> Ref. No. </strong></div>						</td>
						<td width="229" valign="top" class="boldEleven">
						<div align="left"><%=cashdata[0][1]%> <input name="ponumber"
							type="hidden" id="ponumber" value="<%=cashdata[0][1]%>">
						</div>						</td>
						<td width="150" valign="top" class="boldEleven"><strong>Purchase
						Date </strong></td>
						<td width="217" valign="top" class="boldEleven"><%=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(cashdata[0][3])%></td>
					</tr>
					<tr>
						<td valign="top" class="boldEleven">&nbsp;</td>
						<td valign="top" class="boldEleven">
						<td valign="top" class="boldEleven"><strong>Payment
						Terms</strong></td>
						<td valign="top" class="boldEleven">
						<%
			
			String paymentids[][] =  CommonFunctions.QueryExecute("Select INT_PAYMENTTERMID,CHR_PAYMENTNAME from inv_m_paymentterms");
			String pid = cashdata[0][4].trim();			
			for(int u=0; u<paymentids.length; u++)
			{
				if(pid.equals(paymentids[u][0]))
					out.print(paymentids[u][1]);
				
						
			}	
			%>						</td>
					</tr>
					<tr>
					  <td valign="top" class="boldEleven"><strong>Vendor Ref.No </strong></td>
					  <td valign="top" class="boldEleven"><%=cashdata[0][15]%>
					  <td valign="top" class="boldEleven"><strong>Purchase Request </strong></td>
					  <td valign="top" class="boldEleven"><%=cashdata[0][17]%></td>
				  </tr>
					<tr>
					  <td valign="top" class="boldEleven"><strong>Vendor
					  Address </strong></td>
					  <td valign="top" class="boldEleven"><%
						
						
									 sql =" SELECT  a.CHR_VENDORNAME,a.CHR_CONTACTPERSON,a.CHR_ADDRESS1,a.CHR_ADDRESS2, ";
sql = sql + " e.CHR_CITYNAME,d.CHR_DISTRICT,  ";
sql = sql + " c.CHR_STATENAME,   CONCAT('PIN :',a.INT_PINCODE),CONCAT('MOBILE :',a.CHR_MOBILE),   ";
sql = sql + " a.INT_ACTIVE,a.CHR_PHONE,a.CHR_EMAIL     ";
sql = sql + " FROM  inv_m_vendorsinformation a, com_m_country b,com_m_state c,com_m_district d,  ";
sql = sql + " com_m_city e  ,inv_m_vendorsgroup f   ";
sql = sql + " WHERE a.INT_GROUPID = f.INT_GROUPID  ";
sql = sql + " AND a.INT_COUNTRYID = b.INT_COUNTRYID   "; 
sql = sql + " AND a.INT_STATEID =c.INT_STATEID     ";
sql = sql + " AND a.INT_DISTRICTID= d.INT_DISTRICTID  ";
sql = sql + " AND a.INT_CITYID =e.INT_CITYID AND INT_VENDORID="+cashdata[0][2];  
String vendor[][]=CommonFunctions.QueryExecute( sql);
if(vendor.length>0)
{

	out.println(vendor[0][0]+",<br>");
	if(!"-".equals(vendor[0][1]))
		out.println(vendor[0][1]+",<br>");
	if(!"-".equals(vendor[0][2]))	
		out.println(vendor[0][2]+",<br>");
	if(!"-".equals(vendor[0][3]))
		out.println(vendor[0][3]+",<br>");
	if(!"-".equals(vendor[0][4]))
		out.println(vendor[0][4]+".<br>");

}
						%>                    
					  <td valign="top" class="boldEleven"><strong>Customer Name </strong></td>
					  <td valign="top" class="boldEleven"><%
String PR = CommonFunctions.QueryExecute("SELECT CHR_PR_BYPASS FROM m_inventorysetting WHERE INT_ROWID=1")[0][0];
sql="SELECT FUN_GET_CUSTOMER_ADDRESS(INT_CUSTOMERID,'<br>') FROM inv_t_purchaserequest WHERE CHR_POREQUESTNO='"+cashdata[0][17]+"'";
if(PR.equals("Y"))
	out.println(CommonFunctions.QueryExecute(sql)[0][0]);
%></td>
				  </tr>
					<tr>
						<td valign="top" class="boldEleven">&nbsp;</td>
						<td valign="top" class="boldEleven">
						<td valign="top" class="boldEleven">&nbsp;</td>
						<td valign="top" class="boldEleven">&nbsp;</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td></td>
			</tr>
			<tr>
				<td align="center">
				<table width="98%" border="0" cellpadding="2" cellspacing="1" bgcolor="#999999">
					<tr bgcolor="#FFFFFF">
						<td height="23" class="boldEleven"><b>S.No</b></td>
						<td height="23" class="boldEleven"><b>Type</b></td>
						<td height="23" class="boldEleven"><b>Item</b></td>
						<td class="boldEleven" width=500><b>Description</b></td>
						<td class="boldEleven"><b>Quantity/Unit</b></td>
						<td class="boldEleven"><b>Unit Price</b></td>
						<td class="boldEleven"><b>Discount(%)</b></td>
						<td class="boldEleven"><b>Unit Discount</b></td>
						<td class="boldEleven" valign="top"><b>Total</b></td>
						<%
						  
	 	String iname="";
		String itemname="";
		String itemcolor="";
		String iitype=""; 
						  
		 sql ="SELECT CHR_PURCHASEORDERNO,if(CHR_TYPE='i','Item','Product'),FUN_INV_PRODUCTCODE(CHR_TYPE,CHR_ITEMID),CHR_DESC,INT_QUANTITY,DOU_UNITPRICE,DOU_DISCOUNT,DOU_UNITDISCOUNT,DOU_TOTAL FROM inv_t_directpurchaseitem WHERE CHR_PURCHASEORDERNO='"+salesid+"'";
		String itemDatas[][] = CommonFunctions.QueryExecute(sql);
		int lens = itemDatas.length;
		for(int u=0;u<itemDatas.length;u++)
		{
			out.print("<tr  bgcolor='#FFFFFF'>");
			out.print("<td   class='boldEleven'  valign='top'>"+(u+1)+"</td>");
			out.print("<td   class='boldEleven'  valign='top'>"+itemDatas[u][1]+"</td>");
			out.print("<td  class='boldEleven'   valign='top'>"+itemDatas[u][2]+"</td>");
			out.print("<td  class='boldEleven'  valign='top' align='right'>"+itemDatas[u][3]+"</td>");
			out.print("<td  class='boldEleven'  valign='top' align='right'>"+itemDatas[u][4]+"</td>");
            out.print("<td  class='boldEleven'  valign='top' align='right'>"+itemDatas[u][5]+"</td>");
            out.print("<td  class='boldEleven'  valign='top' align='right'>"+itemDatas[u][6]+"</td>");
            out.print("<td  class='boldEleven'  valign='top' align='right'>"+itemDatas[u][7]+"</td>");
            out.print("<td  class='boldEleven'  valign='top' align='right'>"+itemDatas[u][8]+"</td>");
				
		}		
	%>
					
				</table>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td align="center">
				<%
				 	  	
	String chkserial = ""+request.getParameter("serialyes");
	sql = " select CHR_TYPE , CHR_ITEMID ,CHR_SERIALNO, CHR_WARRANTY,INT_ID from inv_t_vendorgoodsreceived ";
	sql = sql +" WHERE CHR_PURCHASEORDERNO = '"+goodsRecNo+"' ";
	sql = sql +" and CHR_RECIVEDID='"+goodsRecNo+"'";
	itemcolor="";
	String stockdata[][] =  CommonFunctions.QueryExecute(sql);
	if("true".equals(chkserial) && stockdata.length > 0)
	{
		
						
						if(stockdata.length>0)
						{
							out.println("<table width='95%' align='center' cellpadding='2' cellspacing='1' bgcolor='#999999'>");
							out.println("<tr  bgcolor='#ffffff'><td class='boldEleven'><b>S.No</b><td class='boldEleven'><b>Type<td class='boldEleven'><b>Item Name<td class='boldEleven'><b>Serial Number<td  class='boldEleven'><b>Waranty (yrs)</b> ");
							
							for(int u=0; u<stockdata.length;u++)
							{
								
								if(stockdata[u][0].equals("I"))
								{
									iname="Item";
									sql = "SELECT CHR_ITEMNAME FROM inv_m_item WHERE CHR_ITEMID='"+stockdata[u][1]+"'";
									itemname = com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_ITEMNAME");
									itemcolor="MRow3";
								}	
								if(stockdata[u][0].equals("P"))
								{
									iname="Product";
									sql = "SELECT CHR_PRODUCTCODE FROM inv_m_produtlist WHERE CHR_PRODUCTID='"+stockdata[u][1]+"'";
									itemname=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_PRODUCTCODE");
									itemcolor="MRow4";
								}	
								out.println("<tr   bgcolor='#ffffff' >");
								out.println("<td class='boldEleven'>"+(u+1)+"</td>");
								out.println("<td class='boldEleven'>"+iname+"</td>");
								out.println("<td class='boldEleven'>"+itemname+"</td>");
								out.println("<td class='boldEleven'>"+stockdata[u][2]);
								out.println("<td class='boldEleven'>"+stockdata[u][3] );
								 
							}	
							out.println("</table>");
						}
			}		
			else
			{
				
				if(stockdata.length>0)
				{
					String spec="Serial Number :";
					if(stockdata.length>1)
						spec="Serial Numbers :";
					out.println("<table align='left' cellspacing=2 cellpadding=2><tr><td class='boldEleven'><b>"+spec+"</b><tr>");
					int cv=1;
					for(int v=0;v<stockdata.length; v++)
					{
						out.println("<td class='boldEleven' width='125'>"+stockdata[v][2]);
						if(cv ==8 )
						{
							cv =0;
							out.println("<tr>");
						}
						cv = cv+1;
					}
					out.println("</table>");
				}
			}			
					  %> <input name="seriallength" type="hidden" id="seriallength"
					value="<%=stockdata.length%>"></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>
				<table width="688" border="0" align="center" cellpadding="1"
					cellspacing="1">
					<tr>
					  <td colspan="2" rowspan="5" valign="top" class="boldEleven">
                      
                      <center>
                      <div align="left">
                            <%
						
						
						sql="SELECT SUM(a.DOU_UNITPRICE*a.INT_QUANTITY),b.CHR_TAXNAME,a.DOU_TAX_PERCENTAGE,SUM(a.DOU_TAX_AMOUNT)";
						sql = sql + " FROM inv_t_directpurchaseitem a, inv_m_tax b ";
						sql = sql+ "  WHERE a.INT_TAXID = b.INT_TAXID AND a.DOU_TAX_PERCENTAGE >0 ";
						sql = sql+ "  AND a.CHR_PURCHASEORDERNO ='"+salesid+"' ";
						sql = sql+ "  GROUP BY a.INT_TAXID ";
						String tData[][] =  CommonFunctions.QueryExecute(sql);
						
						sql ="SELECT CHR_TAXNAME,DOU_VALUE FROM inv_m_tax WHERE INT_TAXID ="+cashdata[0][9];
						double taxvalues = Double.parseDouble(CommonFunctions.QueryExecute(sql)[0][1]);
						
						double tvalue=0;
						if(tData.length>0 || taxvalues>0)
						{
							out.println("<table align='center' border='1' cellpadding='2' cellspacing='0' bordercolor='#CCCCCC' width='300'>");
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
									tvalue = tvalue +Double.parseDouble(tData[k][3]);
									out.println("</tr>");
								}
							}
							if(taxvalues>0)
							{
								out.println("<tr   bgcolor='#ffffff'>");
								out.println("<td class='boldElevenPrint' >"+CommonFunctions.QueryExecute(sql)[0][0]+"</td>");
								out.println("<td class='boldElevenPrint' align='right' >"+ cashdata[0][19] +"</td>");
								out.println("<td class='boldElevenPrint' align='right' >"+ cashdata[0][10] +"</td>");
								tvalue = tvalue +Double.parseDouble(cashdata[0][10]);
								out.println("</tr>");
							}	
							out.println("</table>");
						}	
						%>
                          </div>
                          </center>                      </td>
					  <td width="107" valign="top" class="boldEleven">
						<div align="left"><strong>Sub Total</strong></div>						</td>
						<td width="169" valign="top" class="boldEleven" id="totals1">
						<div align="right"><%=cashdata[0][7]%></div>						</td>
					</tr>
					<tr>
					  <td valign="top" class="boldEleven">
						<div align="left"><strong><!--Discount (%) --></strong></div>						</td>
						<td width="169" valign="top" class="boldEleven"
							id="totaldiscount1">
						<div align="right"><!--<%=cashdata[0][8]%>--></div>						</td>
					</tr>
					<tr>
					  <td class="boldEleven">&nbsp;</td>
					  <td align="right" class="boldEleven" id="nettotal2"><div align="right">
					    <!--<%
						  if(tvalue>0)
						  	out.println(""+tvalue);
						  %>-->
					  </div></td>
				  </tr>
					<tr>
					  <td class="boldEleven"><strong>
					    <!--Tax-->
                        <strong>Frieght Amount </strong></strong></td>
					  <td class="boldEleven" id="nettotal1"><div align="right"><%=cashdata[0][22]%></div></td>
				  </tr>
					<tr>
					  <td class="boldEleven"><strong>Rounded </strong></td>
								  <td class="boldEleven"  width="169" id="nettotal1"><div align="right"><%=cashdata[0][16]%></div></td>
				  </tr>
					<tr>
						<td class="boldEleven">
						<div align="left"></div>						</td>
						<td class="boldEleven">
						<div align="left"></div>						</td>
						<td class="boldEleven">
					  <div align="left" class="copyright"><strong>Net Total </strong></div>						</td>
						<td width="169" class="boldEleven" id="nettotal1">
					  <div align="right" class="copyright"><%=cashdata[0][11]%></div>						</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td></td>
			</tr>
			<tr>
				<td></td>
			</tr>
			<tr>
				<td valign="top" class="boldEleven">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" class="boldEleven">
				<div align="center" id="Rupees"><script language="javascript">
							numberWord("<%=cashdata[0][11]%>","Rupees") 
						  </script></div>
				</td>
			</tr>
			<tr>
				<td valign="top" class="boldEleven">&nbsp;</td>
			</tr>
		</table>
		</td>

	</tr>
</table>
</div>
</form>

</body>
</html>
<%
}
catch(Exception e)
{
	System.out.println("Error :"+e.getMessage());
}
%>
<br>
<br>