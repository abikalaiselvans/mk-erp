<%@ page import="java.io.*,java.util.*"%>
<%-- <%@ page import="sun.net.smtp.SmtpClient"%> --%>
<%@ page import="com.my.org.erp.common.*"%>
<%@ page import="com.my.org.erp.common.*"%> 
<html>
<head>
 
<title>:: ASSET ::</title>


<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../JavaScript/InventoryStyles.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<body >
<br><br>
<table width="600" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#000000">
  <tr>
    <td align="center" valign="middle"> 
      <table cellspacing="2" cellpadding="2" width="98%" align="center"
						border="0">
        <!--DWLayoutTable-->
        <tbody>
          <tr>
            <td height="16" colspan="4" align="center" valign="top"
									class="boldThirteen">CARBOUYS
              <%
				 
				String usertype=""+session.getAttribute("USRTYPE");
				String assetid=request.getParameter("assetid");
				
				String sql = " SELECT  a.INT_ASSETID, c.CHR_COMPANYNAME,b.CHR_BRANCHNAME,d.CHR_DIVICODE,e.CHR_CUSTOMERNAME,  a.CHR_ADDRESSFLAG,a.CHR_ADDRESS,   a.CHR_REF,  f.CHR_STAFFNAME,  DATE_FORMAT(a.DT_SALES,'%d-%m-%Y'),a.CHR_SALEINVOICE,a.CHR_STATUS, a.INT_BRANCHID FROM   asset_t_asset a ,com_m_branch b,com_m_company c,inv_m_division d,inv_m_customerinfo e,com_m_staff f  WHERE   a.INT_BRANCHID= b.INT_BRANCHID  AND b.INT_COMPANYID= c.INT_COMPANYID AND a.INT_DIVIID= d.INT_DIVIID AND a.INT_CUSTOMERID = e.INT_CUSTOMERID AND a.CHR_REF=f.CHR_EMPID  AND  a.INT_ASSETID="+assetid;
				String sdata[][] =  CommonFunctions.QueryExecute(sql);
				
				
				
			 
				String ssql="SELECT b.CHR_COMPANYNAME,a.CHR_BRANCHNAME,a.CHR_STREET,a.CHR_CITY,a.CHR_STATE,a.CHR_POSTAL,a.CHR_PHONE, ";
	ssql = ssql +" a.CHR_FAX,a.CHR_EMAIL, a.CHR_TNGSTNO,a.CHR_CSTNO,a.CHR_REGNO,a.CHR_TINNO,b.CHR_SERVICETAX ,a.CHR_LOCALTAXNO FROM com_m_branch a , com_m_company b ";
	ssql = ssql +" WHERE  a.INT_BRANCHID="+ session.getAttribute("BRANCHID") +"  AND a.INT_COMPANYID = b.INT_COMPANYID" ;
	String cpydata[][]= CommonInfo.RecordSetArray(ssql);
				 
			%>            </td>
          </tr>
          <tr>
            <td height="19" colspan="4" align="right" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
          </tr>
          <tr>
            <td height="17" valign="top" class="boldEleven">Company</td>
            <td align="left" valign="top" class="boldEleven"> 
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
					   
					  %>
			</td>
            <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
            <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
          </tr>
          <tr>
            <td height="17" valign="top" class="boldEleven">Branch</td>
            <td align="left" valign="top" class="boldEleven"><%=sdata[0][2]%> </td>
            <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
            <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
          </tr>
          <tr>
            <td width="118" height="17" valign="top" class="boldEleven">Division</td>
            <td width="199" align="left" valign="top" class="boldEleven"><%=sdata[0][3]%> </td>
            <td width="105" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
            <td width="148" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
          </tr>
          <tr>
            <td height="17" valign="top" class="boldEleven">Customer</td>
            <td align="left" class="boldEleven"><%=sdata[0][4]%> </td>
            <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
            <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
          </tr>
          <tr>
            <td valign="top" class="boldEleven"><div align="left">Shipping Address</div></td>
            <td align="left" class="boldEleven"><%
							  	if("S".equals(sdata[0][5]))
									out.println("Same Address");
								else
									out.println("Different Address");	
							  %>            </td>
            <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
            <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
          </tr>
          <tr>
            <td height="17" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
            <td align="left" class="boldEleven"><%=sdata[0][6]%></td>
            <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
            <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
          </tr>
          <tr>
            <td height="17" valign="top" class="boldEleven">Sale date </td>
            <td align="left" class="boldEleven"><%=sdata[0][9]%></td>
            <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
            <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
          </tr>
          <tr>
            <td class="boldEleven"><div align="left">Sale Number </div></td>
            <td class="boldEleven"><%=sdata[0][10]%></td>
            <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
            <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
          </tr>
          <tr>
            <td height="17" valign="top" class="boldEleven">Reference</td>
            <td colspan="3" align="left" class="boldEleven"><div align="left"><%=sdata[0][7]%> / <%=sdata[0][8]%></div></td>
          </tr>
          <tr>
            <td height="17" colspan="4" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
          </tr>
          <tr>
            <td height="17" colspan="4" valign="top" class="boldEleven"><div id="divscroll" style="OVERFLOW:auto;width:600;height:auto">
                <%

 sql = " SELECT c.CHR_GROUPNAME, b.CHR_ITEMNAME,b.CHR_DES,a.CHR_ITEMID,a.INT_QTY,b.CHR_RETURNABLE  FROM  asset_t_assetqty  a ,asset_m_item b,asset_m_itemgroup c WHERE a.CHR_ITEMID=b.CHR_ITEMID AND b.INT_ITEMGROUPID=c.INT_ITEMGROUPID AND a.INT_ASSETID="+assetid; 
String itemdata[][] = CommonFunctions.QueryExecute(sql);
if(itemdata.length>0)
{
	out.println("<center>");
	out.println("<table width='95%' border=1 bordercolor='#000000'>");
	out.println("<tr>");
	out.println("<td class='boldEleven'><strong>Item Group</strong></td>");
	out.println("<td class='boldEleven'><strong>Item</strong></td>");
	out.println("<td class='boldEleven'><strong>Description</strong></td>");
	out.println("<td class='boldEleven'><strong>Type</strong></td>");
	out.println("<td class='boldEleven'><strong>Quantity</strong></td>");
	out.println("</tr>");
	for(int u=0;u<itemdata.length;u++)
	{
		if(u%2==0)
			out.println("<tr class='MRow1'>");
		else	
			out.println("<tr class='MRow2'>");
		out.println("<td class='boldEleven'>"+itemdata[u][0]+" </td>");
		out.println("<td class='boldEleven'>"+itemdata[u][1]+" </td>");
		out.println("<td class='boldEleven'>"+itemdata[u][2]+" </td>");
		out.println("<td class='boldEleven'>");	
		if("Y".equals(itemdata[u][5]))
			out.println("Returnable</td>");
		else
			out.println("Non-Returnable</td>");	
		out.println("<td class='boldEleven'>"+itemdata[u][4]+" </td>");	
		out.println("</tr>");
	}
	
	out.println("</table>");
	out.println("<center>");
}
%>
            </div></td>
          </tr>
          <tr>
            <td height="17" colspan="4" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
          </tr>
          <tr>
            <td height="17" colspan="4" valign="top" class="boldEleven"><table width="99%" border="1" align="center" cellpadding="0"
							cellspacing="0" bordercolor='#D9D9D9'>
              <tr>
                <td width="46%" valign="top"><table width="100%" border="0" cellspacing="2" cellpadding="2">
                    <tr>
                      <td class="boldEleven"><strong>Local Tax No</strong>. <strong><strong><%=cpydata[0][14]%></strong></strong></td>
                    </tr>
                    <tr>
                      <td class="boldEleven"><strong>CST No : <strong><%=cpydata[0][10]%></strong></strong></td>
                    </tr>
                    <tr>
                      <td><strong>TIN
                        No : <span class="style7"><%=cpydata[0][12]%></span></strong></td>
                    </tr>
                    <tr>
                      <td class="boldEleven"><strong>Service Tax No <%=cpydata[0][13]%></strong></td>
                    </tr>
                    <tr>
                      <td class="boldEleven"><strong>Declaration </strong>:</td>
                    </tr>
                    <tr>
                      <td class="boldEleven"><div align="justify">We declare that this invoice shows
                        the actual price of the good descibed and that all particulars
                        are true and correct.</div></td>
                    </tr>
                </table></td>
                <td width="54%" valign="top"><table width="100%" border="0" cellspacing="2" cellpadding="2">
                    <tr>
                      <td class="bolddeeplogin"><div align="right">
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
                      <td class="boldEleven"><div align="right"><strong>(Authorised
                        Signatory ) </strong></div></td>
                    </tr>
                </table></td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td height="17" colspan="4" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
          </tr>
          <tr>
            <td height="17" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
            <td colspan="3" align="left"><div align="right"><a href="javascript:window.print()">Print</a></div></td>
          </tr>
        </tbody>
      </table>
   </td>
  </tr>
</table>
