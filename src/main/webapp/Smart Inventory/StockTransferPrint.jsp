<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="com.my.org.erp.common.CommonInfo"%>
<%@ page import="com.my.org.erp.common.CommonFunction"%>
<%@ page import="com.my.org.erp.Math.MathFunction"%>
<%
try
{
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>:: INVENTORY ::</title><script language="javascript" src="../JavaScript/comfunction.js"></script>
<style type="text/css">
@import url("../JavaScript/SmartStyles.css");
.style7 {COLOR: #000000; LINE-HEIGHT: 15px; FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; TEXT-DECORATION: none; font-size: 10px;}
</style>
</head>
<%
	String sql="";
	String transNo=request.getParameter("transNo");
	sql=" SELECT CHR_STOCKTRANSFERID,INT_BRANCHID_FROM,INT_BRANCHID_TO,"
	+"DATE_FORMAT(DAT_TRANSFERDATE,'%d-%b-%Y'),CHR_DES,INT_STATUS, DATE_FORMAT(DAT_RECEIVEDDATE,'%d-%b-%Y'),FIND_A_EMPLOYEE_ID_NAME(CHR_TRANSFERBY),FIND_A_EMPLOYEE_ID_NAME(CHR_RECEIVEDBY) from inv_t_stocktransfer "
	+" where CHR_STOCKTRANSFERID='"+transNo+"'";	
	String readData[][] =  CommonFunctions.QueryExecute(sql); 
	
	 sql=" Select FUN_GET_BRANCH_ADDRESS('"+readData[0][1]+"', '\n')";
 	String fBarnch= CommonFunctions.QueryExecute(sql)[0][0];
	
	sql=" Select FUN_GET_BRANCH_ADDRESS('"+readData[0][2]+"', '\n')";
 	String tBarnch= CommonFunctions.QueryExecute(sql)[0][0];
	
	 
	String status="";
	int s=Integer.parseInt(readData[0][5]);
	if(s==0)
		status="Transfered";
	else
		status="Received";	
 
%>
<body onLoad="window.print()" ><br><br>
<table width="600" border="1" align="center" cellpadding="2" cellspacing="3">
  <tr>
    <td><table width="663" border="0" align="center" cellpadding="1"
						cellspacing="1">
      <tr>
        <td width="650"></td>
      </tr>
      <tr>
        <td align="center" class="bolddeeplogin"><div align="center"><%=request.getParameter("title")%></div></td>
      </tr>
      <tr>
        <td><table width="673" border="0" align="center" cellpadding="3"
								cellspacing="3">
          <tr>
            <td colspan="4" class="boldEleven"  >
			<%
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
									
			%>			</td>
            </tr>
          <tr>
            <td width="123" class="boldEleven"><strong>Trans Ref No</strong></td>
            <td width="229" class="boldEleven"><div align="left"><%=readData[0][0] %>
              <input
										name="salno" type="hidden" id="salno"
										value="<%=readData[0][0]%>">
            </div></td>
            <td width="107" class="boldEleven"><strong>Status</strong></td>
            <td width="201" class="boldEleven"><%=status %></td>
          </tr>
          <tr>
            <td align="left" valign="top" class="boldEleven"><strong>From Branch</strong></td>
            <td align="left" valign="top" class="boldEleven"><%=fBarnch %></td>
            <td align="left" valign="top" class="boldEleven"><strong>To Branch</strong></td>
            <td align="left" valign="top" class="boldEleven"><div align="left">
              <%=tBarnch	%>
              <div align="left"></div></td>
          </tr>
          <tr>
            <td class="boldEleven"><strong>Transfer Date</strong></td>
            <td class="boldEleven"><%=readData[0][3] %></td>
            <td class="boldEleven"><strong>Received Date</strong></td>
            <td class="boldEleven"><%=readData[0][6] %></td>
          </tr>
          <tr>
            <td class="boldEleven"><strong>Transfer By</strong></td>
            <td class="boldEleven"><%=readData[0][7] %></td>
            <td class="boldEleven"><strong>Received By</strong></td>
            <td class="boldEleven"><%=readData[0][8] %></td>
          </tr>
          <tr>
            <td class="boldEleven"><div align="left"><strong>Description</strong></div></td>
            <td class="boldEleven"><div align="left"><%=readData[0][4] %></div></td>
            <td class="boldEleven">&nbsp;</td>
            <td class="boldEleven">&nbsp;</td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td><div align="center">
          <%
							
sql = " SELECT a.INT_ID , ";
sql = sql +" if(a.CHR_TYPE='P','PRODUCT','ITEM'),  ";

sql = sql +" if( ";
sql = sql +" a.CHR_TYPE='I', ";
sql = sql +" (SELECT b.CHR_ITEMNAME FROM inv_m_item b WHERE b.CHR_ITEMID=a.CHR_ITEMID), ";
sql = sql +" (SELECT c.CHR_PRODUCTCODE FROM inv_m_produtlist c WHERE c.CHR_PRODUCTID=a.CHR_ITEMID)    ";
sql = sql +" ), ";

sql = sql +" if( ";
sql = sql +" a.CHR_TYPE='I', ";
sql = sql +" (SELECT d.CHR_DES FROM inv_m_item d WHERE d.CHR_ITEMID=a.CHR_ITEMID), ";
sql = sql +" (SELECT e.CHR_PRODUCTDESC FROM inv_m_produtlist e WHERE e.CHR_PRODUCTID=a.CHR_ITEMID)    ";
sql = sql +" ), ";

sql = sql +" a.INT_QUANTITY ,ROUND(a.DOU_AVERAGEPRICE,2), ROUND((a.INT_QUANTITY*a.DOU_AVERAGEPRICE),2)  from inv_t_stocktransferitem  a WHERE a.CHR_STOCKTRANSFERID='"+readData[0][0]+"' ";
//out.println(sql);
String saledata[][] = CommonFunctions.QueryExecute(sql);

out.println("<table width='90%'  class='boldEleven' id='myTable' cellpadding='2' cellspacing='1' bgcolor='#000000'>");
out.println("<tr bgcolor='#ffffff'>");
out.println("<td class='boldEleven' align='center'><b>S.No</b></td>");
out.println("<td class='boldEleven' align='center'><b>Item / Product </b></td>");
out.println("<td class='boldEleven' align='center'><b>Item / Product Name</b></td>");
out.println("<td class='boldEleven' align='center'><b>Description</b></td>");
out.println("<td class='boldEleven' align='center'><b>Qty</b></td>");
out.println("<td class='boldEleven' align='center'><b>Unit Price</b></td>");
out.println("<td class='boldEleven' align='center'><b>Total</b></td>");
out.println("</tr>");
if(saledata.length >0)
{
	double d=0;
	for(int u=0; u<saledata.length;u++)
	{
		if(u%2==0)
			out.println("<tr  bgcolor='#ffffff'>");
		else
			out.println("<tr  bgcolor='#ffffff' >");	
		out.println("<td class='boldEleven'>"+(u+1)+".</td>");
		out.println("<td class='boldEleven'>"+saledata[u][1]+"</td>");
		out.println("<td class='boldEleven'>"+saledata[u][2]+"</td>");
		out.println("<td class='boldEleven' >"+saledata[u][3]+"</td>");
		out.println("<td class='boldEleven' align='right' >"+saledata[u][4]+"&nbsp;</td>");
		out.println("<td class='boldEleven' align='right' >"+saledata[u][5]+"&nbsp;</td>");
		out.println("<td class='boldEleven' align='right' >"+saledata[u][6]+"&nbsp;</td>");
		d = d+Double.parseDouble(saledata[u][6]);
		out.println("</tr>");
	}
	String strDouble = String.format("%.2f", d);
	out.println("<tr  bgcolor='#ffffff' >");	
	out.println("<td class='boldEleven' align='right' colspan='6'><b>Net Total   </b>&nbsp;</td>");
	out.println("<td class='boldEleven' align='right' >"+strDouble+"&nbsp;</td>");
	out.println("</tr>");
}
out.println("</table>");							
 %>
        </div></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td><div align="center"></div></td>
      </tr>
      <tr>
        <td><div align="center">
          <%
		
sql = " SELECT a.INT_ID,  ";
sql = sql+ " if(a.CHR_TYPE='P','PRODUCT','ITEM'),  ";
sql = sql+ " if(  ";
sql = sql+ " a.CHR_TYPE='I',  ";
sql = sql+ " (SELECT b.CHR_ITEMNAME FROM inv_m_item b WHERE b.CHR_ITEMID=a.CHR_ITEMID),  ";
sql = sql+ " (SELECT c.CHR_PRODUCTCODE FROM inv_m_produtlist c WHERE c.CHR_PRODUCTID=a.CHR_ITEMID)     ";
sql = sql+ " ),  ";
sql = sql+ " a.CHR_SERIALNO,a.CHR_WARRANTY,a.CHR_RECEIVEDBY, a.CHR_RECEIVEDSTATUS 	  ";
sql = sql+ " from inv_t_stocktransferitemserial a   ";
sql = sql+ " WHERE a.CHR_STOCKTRANSFERID='"+readData[0][0]+"' ";
String saledata1[][] = CommonFunctions.QueryExecute(sql);

if(saledata1.length >0)
{
	out.println("<table width='80%' border='1' class='boldEleven' id='myTable'  cellpadding=2 cellspacing=1 bgcolor='#000000' >");
	out.println("<tr bgcolor='#ffffff' >");
	out.println("<td class='boldEleven' align='center'><b>S.No</b></td>");
	out.println("<td class='boldEleven' align='center'><b>Item / Product </b></td>");
	out.println("<td class='boldEleven' align='center'><b>Item / Product Code</b></td>");
	out.println("<td class='boldEleven' align='center'><b>Serial</b></td>");
	out.println("<td class='boldEleven' align='center'><b>Warranty</b></td>");
	out.println("<td class='boldEleven' align='center'><b>Status</b></td>");
	out.println("</tr>");
	for(int u=0; u<saledata1.length;u++)
	{
		if(u%2==0)
			out.println("<tr  bgcolor='#ffffff'>");
		else
			out.println("<tr bgcolor='#ffffff' >");	
		out.println("<td class='boldEleven'>"+(u+1)+".</td>");
		out.println("<td  class='boldEleven'>"+saledata1[u][1]+"</td>");
		out.println("<td class='boldEleven'>"+saledata1[u][2]+"</td>");
		out.println("<td class='boldEleven'  >"+saledata1[u][3]+"</td>");
		out.println("<td class='boldEleven'  >"+saledata1[u][4]+" -Years</td>");
		if("Y".equals(saledata1[u][6]))
			out.println("<td class='boldEleven' >Received</td>");
		else
			out.println("<td class='boldEleven' >Not Received</td>");
		out.println("</tr>");
	}
	out.println("</table>");
} 

 %>
        </div></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td> 
		  <table width="99%"  align="center" bgcolor="#000000" cellpadding='2' cellspacing='1'>
            <tr bgcolor="#FFFFFF">
              <td width="46%" valign="top"><table width="100%" border="0" cellspacing="2" cellpadding="2">
                  <!--<tr>
										<td class="boldEleven"><strong>Local Tax No</strong>.
										<%=cpydata[0][13]%></td>
									</tr>-->
                  <tr>
                    <td class="boldEleven"><strong>PAN No</strong>. <%=cpydata[0][14]%></td>
                  </tr>
                  <tr>
                    <td class="boldEleven"><strong>CST No : </strong> <%=cpydata[0][10]%> </td>
                  </tr>
                  <tr>
                    <td><span class="boldEleven"><strong>TIN
                      No : </strong></span><span class="style7"><%=cpydata[0][12]%></span></td>
                  </tr>
                  <tr>
                    <td class="boldEleven">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="boldEleven">&nbsp;</td>
                  </tr>
              </table></td>
              <td width="54%" valign="top"><table width="100%" border="0" cellspacing="2" cellpadding="2">
                  <tr>
                    <td width="34%" rowspan="5" class="bolddeeplogin" style=""background="../qrservlet?qrtext=<%=readData[0][0].trim()%>">&nbsp;</td>
                    <td width="66%" class="bold1"><div align="right">
                      <%
						out.println("For  "+cpydata[0][0]);
						%>
                    </div></td>
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
                    <td class="boldEleven"><div align="right"><strong>Authorised
                      Signatory </strong></div></td>
                  </tr>
              </table></td>
            </tr>
          </table></td>
      </tr>
      <tr>
        <td></td>
      </tr>
      <tr>
        <td></td>
      </tr>
      <tr>
        <td></td>
      </tr>
      <tr>
        <td valign="top" class="boldEleven"><div align="right">
<%
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("EEE  dd-MMM-yyyy HH:mm a");
        java.util.Date currDate = new java.util.Date();
        out.println( sdf.format(currDate));
%>
                      </div></td>
      </tr>
      <tr>
        <td valign="top" class="boldEleven">&nbsp; </td>
      </tr>
    </table></td>
  </tr>
</table>
<br><br>
</body>
</html>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}

%>