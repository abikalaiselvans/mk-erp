<%@ page import="java.sql.*" errorPage="../error/index.jsp"%>
<%@ page import="com.my.org.erp.common.CommonInfo"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>:: INVENTORY ::</title><%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<style type="text/css">
<!--
.style3 {
	font-size: 18px;
	font-weight: bold;
}
.style7 {COLOR: #000000; LINE-HEIGHT: 15px; FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; TEXT-DECORATION: none; font-size: 10px;}
body {
	margin-top: 1.5in;
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
</head>
<!--onLoad="javascript:window.print(), window.close()" onLoad="formatTableForPrint()"-->
<body    >

<%
 
	String dcno= ""+request.getParameter("dcno");
	String sql="";
	
	sql = " SELECT INT_DIVIID,CHR_DCNO,DATE_FORMAT(DAT_DCDATE,'%d-%b-%Y'),INT_CUSTOMERID,CHR_REF,CHR_DES,";
	sql = sql+" INT_DCSTATUS,CHR_SHIPPING,CHR_SHIPPINGADDRESS,CHR_OTHERREF,	CHR_DELIVERYNOTE,";
	sql = sql+" CHR_DESPATCHTHRU,CHR_DESTINATION,CHR_TERMSOFDELIVERY,CHR_CONTACTDETAILS,CHR_CONTACTNO";
	sql = sql+"	   FROM inv_t_directdc WHERE CHR_DCNO='"+dcno+"'";
	String data[][] = CommonFunctions.QueryExecute(sql);
	
	
String ssql = "SELECT b.CHR_COMPANYNAME,a.CHR_BRANCHNAME,a.CHR_STREET,e.CHR_CITYNAME,d.CHR_STATENAME,a.INT_PINCODE,a.CHR_PHONE,  ";
ssql = ssql +" a.CHR_FAX,a.CHR_EMAIL, a.CHR_TNGSTNO,a.CHR_CSTNO,a.CHR_REGNO,a.CHR_TINNO,a.CHR_LOCALTAXNO,a.CHR_PANNO, "; 
ssql = ssql +" b.CHR_SERVICETAX FROM com_m_branch a , com_m_company b ,com_m_country c, com_m_state d, com_m_city e ";
ssql = ssql +" WHERE  a.INT_CITYID = e.INT_CITYID ";
ssql = ssql +" AND a.INT_COUNTRYID = c.INT_COUNTRYID ";
ssql = ssql +" AND a.INT_STATEID =d.INT_STATEID ";
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


	
	 
%>


<table width="100%" border="0" cellspacing="1" cellpadding="1" >
	 
	<tr>
		<td>
		<table width="600" border="1" align="center" cellpadding="0" id="masterTbl"
			cellspacing="0" bordercolor="#000000">
			<tr>
				<td height="600">
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
						<div align="center" class="style3">DELIVERY CHALLAN </div>						</td>
					</tr>
					<tr>
						<td>
						<table width="100%" border="0" align="center" cellpadding="2"
							cellspacing="2">
							<tr>
								<td colspan="3" valign="top" class="boldEleven">
								<%
					   
					   
					 
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
										DC .No </strong></td>
										<td width="64%" valign="top" class="boldEleven"><%=dcno%></td>
									</tr>
									<tr>
										<td valign="top" class="boldEleven"><strong>Customer
										Address </strong></td>
										<td valign="top" class="boldEleven">
<%
sql="SELECT a.INT_CUSTOMERID,f.CHR_NAME,a.CHR_ADDRESS1,a.CHR_ADDRESS2, e.CHR_CITYNAME,d.CHR_DISTRICT,c.CHR_STATENAME,  CONCAT('PIN :',a.INT_PINCODE),CONCAT('Phone :',a.CHR_AREACODE,'-',a.CHR_PHONE),CONCAT('MOBILE :',a.CHR_MOBILE),CONCAT('E-Mail :',a.CHR_EMAIL),a.CHR_TIN,CHR_CST FROM  inv_m_customerinfo a, com_m_country b,com_m_state c,com_m_district d,com_m_city e  ,inv_m_customergroup f   WHERE a.INT_CUSTOMERGROUPID = f.INT_CUSTOMERGROUPID   AND a.INT_COUNTRYID = b.INT_COUNTRYID    AND a.INT_STATEID =c.INT_STATEID    AND a.INT_DISTRICTID= d.INT_DISTRICTID   AND a.INT_CITYID =e.INT_CITYID AND a.INT_CUSTOMERID="+data[0][3];
String vendor[][] =  CommonFunctions.QueryExecute(sql);
if(!"-".equals(vendor[0][1]))
	out.println(vendor[0][1]+",<br>");
if(!"-".equals(vendor[0][2]))	
	out.println(vendor[0][2]+",<br>");
if(!"-".equals(vendor[0][3]))
	out.println(vendor[0][3]+"<br>");
if(!"-".equals(vendor[0][4]))
	out.println(vendor[0][4]+"<br>");										
if(!"-".equals(vendor[0][5]))
	out.println(vendor[0][5]+"<br>");										
if(!"-".equals(vendor[0][6]))
	out.println(vendor[0][6]+"<br>");										
if(!"-".equals(vendor[0][7]))
	out.println(vendor[0][7]+".");										
 %></td>
									</tr>
									<tr>
										<td valign="top" class="boldEleven"><strong>Customer
										Address </strong></td>
										<td valign="top" class="boldEleven"><%
						  	if("S".equals(data[0][7]))
							{
								if(!"-".equals(vendor[0][1]))
									out.println(vendor[0][1]+",<br>");
								if(!"-".equals(vendor[0][2]))	
									out.println(vendor[0][2]+",<br>");
								if(!"-".equals(vendor[0][3]))
									out.println(vendor[0][3]+"<br>");
								if(!"-".equals(vendor[0][4]))
									out.println(vendor[0][4]+"<br>");										
								if(!"-".equals(vendor[0][5]))
									out.println(vendor[0][5]+"<br>");										
								if(!"-".equals(vendor[0][6]))
									out.println(vendor[0][6]+"<br>");										
								if(!"-".equals(vendor[0][7]))
									out.println(vendor[0][7]+".");	
							}
							else
							{
								out.println(data[0][8]);
							}
							
						  %></td>
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
										<td width="60%" valign="top" class="boldEleven"><%=data[0][2].toUpperCase()%></td>
									</tr>
									<tr>
										<td valign="top" class="boldEleven"><strong>Other
										Reference </strong></td>
										<td valign="top" class="boldEleven"><%=data[0][9].toUpperCase()%></td>
									</tr>
									<tr>
										<td valign="top" class="boldEleven"><strong>Delivery
										Note </strong></td>
										<td valign="top" class="boldEleven"><%=data[0][10].toUpperCase()%></td>
									</tr>
									<tr>
										<td valign="top" class="boldEleven"><strong>Despatch
										Through </strong></td>
										<td valign="top" class="boldEleven"><%=data[0][11].toUpperCase()%></td>
									</tr>
									<tr>
										<td valign="top" class="boldEleven"><strong>Destinaion</strong></td>
										<td valign="top" class="boldEleven"><%=data[0][12].toUpperCase()%></td>
									</tr>
									<tr>
										<td valign="top" class="boldEleven"><strong>Terms
										of Delivery </strong></td>
									  <td valign="top" class="boldEleven"><%=data[0][13].toUpperCase()%></td>
									</tr>
									<tr>
										<td valign="top" class="boldEleven"><strong>Contact
										Person </strong></td>
										<td valign="top" class="boldEleven"><%=data[0][14].toUpperCase()%></td>
									</tr>
									<tr>
										<td valign="top" class="boldEleven"><strong>Contact
										No </strong></td>
										<td valign="top" class="boldEleven"><%=data[0][15].toUpperCase()%></td>
									</tr>
								</table>								</td>
							</tr>
						</table>						</td>
					</tr>
					<tr>
						<td height="9"><%
	sql="SELECT CHR_TYPE,CHR_ITEMID,CHR_SERIALNO,CHR_WARRANTY FROM inv_t_directdcitem WHERE CHR_DCNO='"+dcno+"'";
	
	sql = " SELECT  ";
	sql = sql + "  if(a.CHR_TYPE='I','Item','Product'),  ";
	sql = sql + "  if(a.CHR_TYPE='I',  ";
	sql = sql + "  (SELECT b.CHR_ITEMNAME FROM inv_m_item b WHERE b.CHR_ITEMID=a.CHR_ITEMID)  ";
	sql = sql + "  ,  ";
	sql = sql + "  (SELECT c.CHR_PRODUCTCODE  FROM inv_m_produtlist  c WHERE c.CHR_PRODUCTID=a.CHR_ITEMID)  ";
	sql = sql + "  ),  ";
	sql = sql + "  if(a.CHR_TYPE='I',  ";
	sql = sql + "  (SELECT d.CHR_DES FROM inv_m_item d WHERE d.CHR_ITEMID=a.CHR_ITEMID)  ";
	sql = sql + "  ,  ";
	sql = sql + "  (SELECT e.CHR_PRODUCTDESC  FROM inv_m_produtlist  e WHERE e.CHR_PRODUCTID=a.CHR_ITEMID)  ";
	sql = sql + "  ),  ";
	
	sql = sql + " a.CHR_SERIALNO,a.CHR_WARRANTY   ";
	sql = sql + "  FROM inv_t_directdcitem  a WHERE a.CHR_DCNO='"+dcno+"'";
	String seriladata[][] =CommonFunctions.QueryExecute(sql);
	String itemname="";
	out.println("<center>");
	out.println("<table width='90%'  class='boldEleven'  id='myTable'     cellpadding=3 cellspacing=1 bgcolor='#cccccc' >");
	out.println("<tr bgcolor='#ffffff'>");
	out.println("<td class='boldEleven' align='center'><b>S.No</b></td>");
	out.println("<td class='boldEleven' align='center'><b>Type</b></td>");
	out.println("<td class='boldEleven' align='center'><b>Product</b></td>");
	out.println("<td class='boldEleven' align='center'><b>Description </b></td>");
	out.println("<td class='boldEleven' align='center'><b>Qty</b></td>");
	out.println("<td  class='boldEleven' align='center'><b> Serialnumber </b></td>");
	out.println("</tr>");
	for(int u=0;u<seriladata.length;u++)
	{
		if(u%2==0)
			out.println("<tr  bgcolor='#ffffff'>");
		else
			out.println("<tr  bgcolor='#ffffff'>");
			
	    out.println("<td class='boldEleven'>"+(u+1)+"</td>");
		out.println("<td class='boldEleven'>"+seriladata[u][0]+"</td>");
		out.println("<td class='boldEleven'>"+seriladata[u][1]+"</td>");
		out.println("<td class='boldEleven'>"+seriladata[u][2]+"</td>");
		out.println("<td class='boldEleven'>1</td>");
		out.println("<td class='boldEleven'>"+seriladata[u][3]+"</td>");
		out.println("</tr>");
		
	}
	out.println("</table></center>");
%>						</td>
					</tr>
					<tr>
					  <td valign="top"><strong>Remarks:</strong></td>
					</tr>
					 <tr>
					  <td valign="top"><%=data[0][5]%></td>
					</tr>
					<tr>
						<td align="center" class="bold1"></td>
					</tr>
					<tr>
						<td> </td>
					</tr>
					<tr>
						<td>						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td></td>
					</tr>
					
					<tr>
						<td height="38" valign="top" class="boldEleven">
						<table width="98%" border="1" align="center" cellpadding="0"
							cellspacing="0" bordercolor='#000000'>
							<tr>
								<td width="46%" valign="top">
								<table width="100%" border="0" cellspacing="2" cellpadding="2">
									<tr>
										<td class="boldEleven"><strong>Local Tax No</strong>.
										0540788</td>
									</tr>
									<tr>
										<td class="boldEleven"><strong>CST No : <%=cpydata[0][10]%></strong></td>
									</tr>
									<tr>
										<td><span class="boldEleven"><strong>TIN
										No :<span class="style7"><%=cpydata[0][12]%></span></strong></span></td>
									</tr>
									<tr>
									  <td class="boldEleven"><strong>Service Tax No <%=cpydata[0][13]%></strong></td>
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



</body>
</html>
<%
}
 catch(Exception e)
 {
 	out.println(e.getMessage());
	System.out.println(e.getMessage());
 }
  
%>