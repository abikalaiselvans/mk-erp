 <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="../error/index.jsp"%>
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
<table width="100%" border="0" cellspacing="1" cellpadding="1" >
	 
	<tr>
		<td>
		<table width="600" border="1" align="left" cellpadding="0" id="masterTbl"
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
						<div align="center" class="style3">PURCHASE INDENT</div>
						</td>
					</tr>
					<tr>
					  <td><table width="700" border="0" align="center" cellpadding="2" cellspacing="2">
                        <tr>
                          <td colspan="4"><div align="center"><span class="boldThirteen">
                            <%

  	String empid =""+session.getAttribute("EMPID");
  	String indentid=request.getParameter("indentid"); 
  	String sql=" SELECT a.CHR_PURCHASENO, DATE_FORMAT(a.DAT_INDENTDATE,'%d-%m-%Y'), ";
	sql=sql+" DATE_FORMAT(a.DAT_EXPECTDATE,'%d-%m-%Y'),b.CHR_DEPARTNAME,  ";
  	sql=sql+" a.CHR_CONTACTDETAILS,  a.CHR_CONTACTNO, a.CHR_DES, a.DOU_TOTALAMOUNT, ";
  	sql=sql+" a.CHR_INDENTRAISEFROM,c.CHR_STAFFNAME, ";
	sql=sql+" a.CHR_ACCEPT,a.CHR_ACCDESC   ";
  	sql=sql+" FROM inv_t_purchaseindent a,com_m_depart b, com_m_staff c  ";
  	sql=sql+" WHERE a.INT_DEPARTID=b.INT_DEPARTID AND a.CHR_INDENTRAISEFROM = c.CHR_EMPID  ";
  	sql=sql+" AND a.CHR_PURCHASENO='"+indentid+"' ";
  	String Data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);	
   		 		
   		 		
					%>
                              </span>
                                  <input name="filename" type="hidden" value="PurchaseIndent" />
                                  <input name="actionS" type="hidden" value="INVPurchaseIndentCloseUpdate" />
                                  <input name="indentid" type="hidden" id="indentid" value="<%=indentid%>">
                          </div></td>
                        </tr>
                        <tr>
                          <td width="121" class="boldEleven">Indent Number </td>
                          <td width="135" class="boldEleven"><%=Data[0][0]%></td>
                          <td width="133" class="style7">Contact Person </td>
                          <td width="85" class="boldEleven"><%=Data[0][5]%></td>
                        </tr>
                        <tr>
                          <td class="boldEleven">Indent Date </td>
                          <td class="boldEleven"><%=Data[0][1]%></td>
                          <td class="style7">Contact Number </td>
                          <td class="boldEleven"><%=Data[0][5]%></td>
                        </tr>
                        <tr>
                          <td class="boldEleven">Expected Date </td>
                          <td class="boldEleven"><%=Data[0][2]%></td>
                          <td class="style7">Description</td>
                          <td class="boldEleven"><%=Data[0][6]%></td>
                        </tr>
                        <tr>
                          <td class="boldEleven">Department</td>
                          <td class="boldEleven"><%=Data[0][3]%></td>
                          <td class="boldEleven"><strong> </strong></td>
                          <td class="boldEleven">&nbsp;</td>
                        </tr>
                        <tr>
                          <td class="boldEleven">Raise From </td>
                          <td class="boldEleven"><%=Data[0][8] +" / " +Data[0][9]%></td>
                          <td class="boldEleven">&nbsp;</td>
                          <td class="boldEleven">&nbsp;</td>
                        </tr>
                        <tr>
                          <td class="boldEleven">Approval</td>
                          <td class="boldEleven"><%
					  if("Y".equals(Data[0][10]))
					  	out.println("Accept");
					  
					  %></td>
                          <td class="boldEleven">&nbsp;</td>
                          <td class="boldEleven">&nbsp;</td>
                        </tr>
                        <tr>
                          <td class="boldEleven">Approval Description </td>
                          <td class="boldEleven"><%=Data[0][11]%></td>
                          <td class="boldEleven">&nbsp;</td>
                          <td class="boldEleven">&nbsp;</td>
                        </tr>
                        <tr>
                          <td colspan="4" class="boldEleven"><div align="center">
                              <%
	sql="";
	sql = " SELECT c.CHR_GROUPNAME, b.CHR_PRODUCTNAME,a.CHR_DESC,a.INT_QUANTITY,a.DOU_UNITPRICE,a.DOU_TOTAL ";  
	sql=sql+" FROM inv_t_purchaseindentdetail a   , inv_m_accessoriesproduct b ,inv_m_accessoriesgroup c";
	sql=sql+" WHERE   a.INT_PRODUCTID=b.INT_PRODUCTID";
	sql=sql+" AND b.INT_GROUPID = c.INT_GROUPID";
	sql=sql+" AND a.CHR_PURCHASENO='"+indentid+"' ";
	String IData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);	
	if(IData.length>0)
	{
		out.println("<center>");
		out.println("<table border=1>");
		out.println("<tr ><td class='boldEleven'><b>S.No");
		out.println("<td class='boldEleven'><b>S.No");
		out.println("<td class='boldEleven'><b>Group");
		out.println("<td class='boldEleven'><b>Product");
		out.println("<td class='boldEleven'><b>Quantity");
		out.println("<td class='boldEleven'><b>Aproximate Price");
		out.println("<td class='boldEleven'><b>Amount");
		for(int u=0;u<IData.length;u++)
		{
			//if(u%2==1)
				out.println("<tr class='MRow2'>");
			//else
				//out.println("<tr class='MRow1'>");	
			out.println("<tr><td class='boldEleven'>"+(u+1));
			out.println("<td class='boldEleven'>"+IData[u][0]);
			out.println("<td class='boldEleven'>"+IData[u][1]);
			out.println("<td class='boldEleven'>"+IData[u][2]);
			out.println("<td class='boldEleven'>"+IData[u][3]);
			out.println("<td class='boldEleven'>"+IData[u][4]);
			out.println("<td class='boldEleven'>"+IData[u][5]);
			
		}
		out.println("</table>");
		out.println("</center>");
	}

 %>
                          </div></td>
                        </tr>
                        <tr>
                          <td class="style7">Net Amount </td>
                          <td class="boldEleven"><%=Data[0][7]%></td>
                          <td class="boldEleven">&nbsp;</td>
                          <td class="boldEleven">&nbsp;</td>
                        </tr>

                        <tr>
                          <td><span class="bolddeeplogin">Amount in words ::</span></td>
                          <td>&nbsp;</td>
                          <td>&nbsp;</td>
                          <td>&nbsp;</td>
                        </tr>
                        <tr>
                          <td colspan="4">
						  <div align="center"  id="Rupees">
						<script language="javascript">
					  	numberWord("<%=Data[0][7]%>","Rupees") 
					  </script></div>
						  </td>
                        </tr>
                      </table></td>
					</tr>
					<tr>
						<td height="9">&nbsp;</td>
					</tr>
					<tr>
					  <td valign="top">&nbsp;</td>
					</tr>
					<tr>
						<td class="bolddeeplogin">&nbsp;</td>
					</tr>
					<tr>
						<td>
						<table width="80%" border="0" align="center" cellpadding="0"
							cellspacing="0">
							<tr>
								<td align="center" class="boldEleven">
								
								</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td align="center" class="bold1"></td>
					</tr>
					<tr>
						<td> </td>
					</tr>
					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td></td>
					</tr>
					
					<tr>
					  <td height="38" valign="top" class="boldEleven">&nbsp;</td>
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
<%
}
 catch(Exception e)
 {
 	out.println(e.getMessage());
 }
  
%>


</body>
</html>
