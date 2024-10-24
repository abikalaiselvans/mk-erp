<%@ page language="java" import="java.sql.*" errorPage="../error/index.jsp"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="com.my.org.erp.common.*"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%>
<%@ page import="sun.net.smtp.SmtpClient"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>:: INVENTORY ::</title><%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/Inventory/InvenAJAX.js"></script>

<style type="text/css">
<!--
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
try{
	String goodsRecNo=""+request.getParameter("gdreceiveno");
	String salesid = goodsRecNo;
	String sql="";
	sql ="select INT_BRANCHID,CHR_PURCHASENO,INT_VENDORID,DATE_FORMAT(DAT_ORDERDATE,'%d-%b-%Y'),INT_PAYMENTTERMID,CHR_DES, ";
	sql = sql +"FIND_A_EMPLOYEE_ID_NAME(CHR_REF),DOU_AMOUNT,DOU_DISCOUNT,INT_TAXID,DOU_TAXAMOUNT,DOU_TOTALAMOUNT,DOU_PAIDAMOUNT,";
	sql = sql +"CHR_PAYMENTSTATUS,INT_DIVIID,CHR_VENDORPO from inv_t_sparepurchase WHERE CHR_PURCHASENO ='"+salesid+"'";
	String cashdata[][] =CommonFunctions.QueryExecute(sql);
	
%>
<body >
<form  AUTOCOMPLETE = "off"   action="" method="post" name="frm" id="frm">
<div align="center"><br />
<table width="700" border="1" align="center" cellpadding="0"
	cellspacing="0">
	<tr>
		<td>
		<table width="663" border="0" align="left" cellpadding="0"
			cellspacing="0">
			<tr>
				<td width="650"></td>
			</tr>
			<tr>
				<td align="center" class="bolddeeplogin">
				<div align="center">SPARE PURCHASE </div>
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
			
			String paymentids[][] = CommonFunctions.QueryExecute("Select INT_PAYMENTTERMID,CHR_PAYMENTNAME from inv_m_paymentterms");
			String pid = cashdata[0][4].trim();			
			for(int u=0; u<paymentids.length; u++)
			{
				if(pid.equals(paymentids[u][0]))
					out.print(paymentids[u][1]);
				
						
			}	
			%>						</td>
					</tr>
					<tr>
						<td valign="top" class="boldEleven"><strong>Vendor
						Address </strong></td>
						<td valign="top" class="boldEleven"><%
						sql = " SELECT CHR_VENDORNAME ,CHR_STREET,CHR_STREET1,CHR_CITY,CHR_MOBILE FROM  inv_m_vendorsinformation  WHERE INT_VENDORID="+Integer.parseInt(cashdata[0][2]); 
						 
						String vendor[][]=CommonFunctions.QueryExecute(sql);
						 
						
						out.println(vendor[0][0]+",<br>");
						if(!"-".equals(vendor[0][1]))
							out.println(vendor[0][1]+",<br>");
						if(!"-".equals(vendor[0][2]))	
							out.println(vendor[0][2]+",<br>");
						if(!"-".equals(vendor[0][3]))
							out.println(vendor[0][3]+",<br>");
						if(!"-".equals(vendor[0][4]))
							out.println(vendor[0][4]+".<br>");
						%>
						<td valign="top" class="boldEleven"><strong>Vendor Ref.No </strong></td>
						<td valign="top" class="boldEleven"><%=cashdata[0][14]%></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td></td>
			</tr>
			<tr>
				<td align="center">
				 <%
sql = " SELECT a.INT_SPAREID,b.CHR_SPARENAME,a.CHR_DESC ,a.INT_QUANTITY , ";
sql = sql +" a.DOU_UNITPRICE,a.DOU_DISCOUNT,a.DOU_UNITDISCOUNT, ";
sql = sql +" c.CHR_TAXNAME,a.DOU_TAX_PERCENTAGE,a.DOU_TAX_AMOUNT, ";
sql = sql +" a.DOU_TOTAL ";
sql = sql +" From  inv_t_sparepurchaseitem a, inv_m_spare b, inv_m_tax c ";
sql = sql +" WHERE a.INT_SPAREID =b.INT_SPAREID AND a.INT_TAXID = c.INT_TAXID ";
sql = sql +" AND a.CHR_PURCHASENO ='"+salesid+"' ";
String saledata[][] = CommonFunctions.QueryExecute(sql);
if(saledata.length>0)
{
	out.println("<center>");
	out.println("<table width='80%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
	out.println("<tr class='MRow1' >");
	out.println("<td class='boldEleven'><b>S.No</b></td>");
	out.println("<td class='boldEleven'><b>Spare</b></td>");
	out.println("<td class='boldEleven'><b>Description</b></td>");
	out.println("<td class='boldEleven'><b>Qty / Units</b></td>");
	out.println("<td class='boldEleven'><b>Unit Price</b></td>");
	out.println("<td class='boldEleven'><b>Discount(%)</b></td>");
	out.println("<td class='boldEleven'><b>Unit Discount</b></td>");
	out.println("<td class='boldEleven'><b>Tax</b></td>");
	out.println("<td class='boldEleven'><b>Tax (%)</b></td>");
	out.println("<td class='boldEleven'><b>Tax Amount </b></td>");
	out.println("<td class='boldEleven'><b>Total</b></td>");
	out.println("</tr>");
	for(int u=0; u<saledata.length;u++)
	{
		if(u%2==0)
			out.println("<tr class='MRow1'  >");
		else
			out.println("<tr class='MRow2'  >");
			
		out.println("<td class='boldEleven' >"+(u+1)+".</td>");
		out.println("<td class='boldEleven' align='left'>"+saledata[u][1] +"</td>");
		out.println("<td class='boldEleven' align='left'>"+saledata[u][2] +"</td>");
		out.println("<td class='boldEleven' align='right'>"+saledata[u][3] +"</td>");
		out.println("<td class='boldEleven' align='right'>"+saledata[u][4] +"</td>");
		out.println("<td class='boldEleven' align='right'>"+saledata[u][5] +"</td>");
		out.println("<td class='boldEleven' align='right'>"+saledata[u][6] +"</td>");
		out.println("<td class='boldEleven' align='left'>"+saledata[u][7] +"</td>");
		out.println("<td class='boldEleven' align='right'>"+saledata[u][8] +"</td>");
		out.println("<td class='boldEleven' align='right'>"+saledata[u][9] +"</td>");
		out.println("<td class='boldEleven' align='right'>"+saledata[u][10] +"</td>");
		out.println("</tr>");
									
	}
	out.println("</table>");
	out.println("</center>");
	
}
%>			
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td align="center">
				
<%				

String chkserial = ""+request.getParameter("serialyes");
sql =" SELECT a.INT_SERIALID,a.INT_SPAREID,b.CHR_SPARENAME,a.CHR_SERIALNO ,a.CHR_WARRANTY,a.CHR_QUALITY,a.CHR_FLAG   ";
sql = sql +"  From  inv_t_sparegoodsreceived a, inv_m_spare b   "; 
sql = sql +"  WHERE a.INT_SPAREID =b.INT_SPAREID    ";
sql = sql +"  AND a.CHR_PURCHASENO ='"+salesid+"' ORDER By a.INT_SERIALID";
String recdData[][] = CommonFunctions.QueryExecute(sql);
if(recdData.length>0)
	for(int v=0;v<recdData.length; v++)
		if("-".equals(recdData[v][3]))
			recdData[v][3]="";
			
if("true".equals(chkserial) && recdData.length > 0)
{
	  
	 
	out.println("<center>");
	out.print(" <table width='80%'  class='boldEleven'  id='myTable'  cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
	out.print("<tr class='MRow1'>");
	out.print("<th   class='boldEleven'><b>S.NO</b></th>");
	out.print("<th   class='boldEleven'><b>Spare</b></th>");
	out.print("<th   class='boldEleven'><b>Serial No</b></th> ");
	out.print("<th   class='boldEleven'><b>Warranty</b></th>");
	out.print("</tr>");
	for(int u=0; u<recdData.length;u++)
	{
		if(u%2==0)
			out.println("<tr class='MRow1'  >");
		else
			out.println("<tr class='MRow2'  >");
			
		out.println("<td class='boldEleven' >"+(u+1)+"</td>");
	 	out.println("<td class='boldEleven'>"+recdData[u][2] +"</td>");
		out.println("<td class='boldEleven'>"+recdData[u][3] +"</td>");
		out.println("<td class='boldEleven'>"+recdData[u][4] +"- Years</td>");
	}
	out.print("</tr>");
	out.print("</table> ");
	out.println("</center>");
}			
						
%>	
	

</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>
				<table width="688" border="0" align="center" cellpadding="1"
					cellspacing="1">
					<tr>
					  <td width="114" rowspan="4" valign="top" class="boldEleven"><strong>Description</strong></td>
					  <td width="197" rowspan="4" valign="top" class="boldEleven"><%=cashdata[0][5]%></td>
						<td width="107" valign="top" class="boldEleven">
						<div align="left"><strong>Total</strong></div>						</td>
						<td width="169" valign="top" class="boldEleven" id="totals1">
						<div align="right"><%=cashdata[0][7]%></div>						</td>
					</tr>
					<tr>
						<td valign="top" class="boldEleven">
						<div align="left"><strong>Total Discount (%) </strong></div>						</td>
						<td width="169" valign="top" class="boldEleven"
							id="totaldiscount1">
						<div align="right"><%=cashdata[0][8]%></div>						</td>
					</tr>
					<tr>
						<td valign="top" class="boldEleven">
						<div align="left"><strong>Tax Group </strong></div>						</td>
						<td width="169" valign="top" class="boldEleven" id="tax1">
						<div align="right">
						<%
	String taxids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_TAXID,CHR_TAXNAME ,DOU_VALUE from inv_m_tax");
		String tid =  cashdata[0][9];
		for(int u=0; u<taxids.length; u++)
		{
			if(tid.trim().equals(taxids[u][0]))
				out.print(taxids[u][1]);
			
		}		
	%>
						</div>						</td>
					</tr>
					<tr>
						<td valign="top" class="boldEleven">
						<div align="left"><strong>Sales Tax (%) </strong></div>						</td>
						<td width="169" valign="top" class="boldEleven" id="salestax1">
						<div align="right">
						<%
  String taxs[][] = com.my.org.erp.common.CommonInfo.RecordSetArray("Select DOU_VALUE from inv_m_tax WHERE INT_TAXID ="+tid);
  %> <%=taxs[0][0]%></div>						</td>
					</tr>
					<tr>
					  <td class="boldEleven"><div align="left"><strong>Reference </strong></div></td>
					  <td class="boldEleven"><div align="left"><%=cashdata[0][6]%></div></td>
						<td class="boldEleven">
						<div align="left"><strong>Sales Tax Amount </strong></div>						</td>
						<td width="169" class="boldEleven" id="salestaxamount1">
						<div align="right"><%=cashdata[0][10]%></div>						</td>
					</tr>
					<tr>
						<td class="boldEleven">
						<div align="left"></div>						</td>
						<td class="boldEleven">
						<div align="left"></div>						</td>
						<td class="boldEleven">
						<div align="left"><strong>Net Total </strong></div>						</td>
						<td width="169" class="boldEleven" id="nettotal1">
						<div align="right"><%=cashdata[0][11]%></div>						</td>
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
<%@ page import="com.my.org.erp.common.CommonInfo"%>
</html>
<%
}
catch(Exception e){
	//System.out.println("Error :"+e.getMessage());
}
%>
