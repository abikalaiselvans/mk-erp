<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*" errorPage="../error/index.jsp"%>
<%@ page import="com.my.org.erp.SmartInventory.Model"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<!-- TemplateBeginEditable name="doctitle" -->
<title>:: INVENTORY ::</title><%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<style type="text/css">
<!--
.style4 {font-weight: bold}
.style5 {COLOR: #000000; LINE-HEIGHT: 15px; FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; TEXT-DECORATION: none; font-size: 10px;}
-->
</style>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript"
	src="../JavaScript/Inventory/Conveyance.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="javascript">
function validate()
{
	if(
		checkNullSelect('Vendor','Select vendor Name','0')
		&& checkNull('ponumber','Enter Purchase Order Number' )
		&& checkNull('podate','Enter Purchase Order Date' )
		&& checkNull('memo','Enter Description' )
	)
		return true;
	else
		return false;
}
</script>
<body >

<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth" onSubmit="return validate()">
<table width="900" height="150" border="0" align="center"
	cellpadding="2" cellspacing="2">
	<%
try
{
	
	 
 %>
	<tr>
	  <td>&nbsp;</td>
    </tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table class="BackGround" cellspacing="0" cellpadding="0" width="390"
			align="center" border="0">
			<tbody>
				<tr>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/Smart Inventory/TLCorner.gif" width="7" /></td>
					<td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/Smart Inventory/TRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
				</tr>
				<tr>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
					<td width="6"><spacer height="1" width="1" type="block" /></td>
				  <td width="412"><table width="700" border="0" align="center" cellpadding="2" cellspacing="2">
                    <tr>
                      <td colspan="4"><div align="center"><span class="boldThirteen">Indent Approval Update
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
                      <td width="133" class="style5">Contact Person </td>
                      <td width="85" class="boldEleven"><%=Data[0][5]%></td>
                    </tr>
                    <tr>
                      <td class="boldEleven">Indent Date </td>
                      <td class="boldEleven"><%=Data[0][1]%></td>
                      <td class="style5">Contact Number </td>
                      <td class="boldEleven"><%=Data[0][5]%></td>
                    </tr>
                    <tr>
                      <td class="boldEleven">Expected Date </td>
                      <td class="boldEleven"><%=Data[0][2]%></td>
                      <td class="style5">Description</td>
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
                      <td class="boldEleven">
					  <%
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
                      <td colspan="4" class="boldEleven">
					  
                        <div align="center">
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
		out.println("<table>");
		out.println("<tr bgcolor='#ffffff'><td class='boldEleven'><b>S.No");
		out.println("<td class='boldEleven'><b>S.No");
		out.println("<td class='boldEleven'><b>Group");
		out.println("<td class='boldEleven'><b>Product");
		out.println("<td class='boldEleven'><b>Quantity");
		out.println("<td class='boldEleven'><b>Aproximate Price");
		out.println("<td class='boldEleven'><b>Amount");
		for(int u=0;u<IData.length;u++)
		{
			if(u%2==1)
				out.println("<tr class='MRow2'>");
			else
				out.println("<tr class='MRow1'>");	
			out.println("<td class='boldEleven'>"+(u+1));
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
                      <td class="style5">Net Amount </td>
                      <td class="boldEleven"><%=Data[0][7]%></td>
                      <td class="boldEleven">&nbsp;</td>
                      <td class="boldEleven">&nbsp;</td>
                    </tr>
                    <tr>
                      <td class="boldEleven">Vendor</td>
                      <td colspan="3" class="boldEleven"><select name="Vendor" id="Vendor">
                        <option value="0">Select</option>
                        <%

String vdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT  INT_VENDORID,CHR_VENDORNAME FROM   inv_m_vendorsinformation   ORDER BY CHR_VENDORNAME");	
	for (int u=0;u<vdata.length;u++)
		out.println("<option value='"+vdata[u][0]+"'>"+vdata[u][1]+"</option>"); 
	
  %>
                      </select></td>
                    </tr>
                    <tr>
                      <td class="boldEleven">Purchase Order Number </td>
                      <td class="boldEleven"><input name="ponumber" type="text"
										class="formText135" id="ponumber" maxlength="50"
										    onBlur="upperMe(this)"      o /></td>
                      <td class="boldEleven">&nbsp;</td>
                      <td class="boldEleven">&nbsp;</td>
                    </tr>
                    <tr>
                      <td class="boldEleven">Purchase Order date </td>
                      <td class="boldEleven"><input tabindex="2"
										name="podate" type="text" class="formText135" id="podate"
										size="15" readonly="readonly">
                        <a
										href="javascript:cal3.popup();"> <img
										src="../JavaScript/img/cal.gif" width="16" height="16"
										border="0" /> </a>
                        <script language='JavaScript'
										type="text/javascript">
		<!--			
				var cal3 = new calendar1(document.forms['frm'].elements['podate']);
				cal3.year_scroll = true;
				cal3.time_comp = false;
				setCurrentDate('podate'); 
		//-->
                                </script></td>
                      <td class="boldEleven">&nbsp;</td>
                      <td class="boldEleven">&nbsp;</td>
                    </tr>
                    <tr>
                      <td valign="top" class="boldEleven">Description</td>
                      <td colspan="3" valign="top" class="boldEleven"><textarea name="memo" cols="30"
										rows="5" class="formText135" id="memo" tabindex="9"   onKeyPress="charOnly('memo',8000)"></textarea></td>
                    </tr>
                    <tr>
                      <td class="boldEleven">&nbsp;</td>
                      <td class="boldEleven">&nbsp;</td>
                      <td class="boldEleven">&nbsp;</td>
                      <td class="boldEleven">&nbsp;</td>
                    </tr>
                    <tr>
                      <td colspan="4"><table width="142" border="0" align="center" cellpadding="3"
								cellspacing="3">
                          <tr>
                            <td width="61"><input name="Submit2" type="submit"
										class="buttonbold14" id="submit" value="Submit"   accesskey="s"    /></td>
                            <td width="60"><input class="buttonbold14" type="button"
										name="Submit"  value="Close"   accesskey="c" 
										onclick="redirect('IndentClose.jsp')" /></td>
                          </tr>
                      </table></td>
                    </tr>
                    <tr>
                      <td>&nbsp;</td>
                      <td>&nbsp;</td>
                      <td>&nbsp;</td>
                      <td>&nbsp;</td>
                    </tr>
                    <tr>
                      <td>&nbsp;</td>
                      <td>&nbsp;</td>
                      <td>&nbsp;</td>
                      <td>&nbsp;</td>
                    </tr>
                  </table></td>
					<td nowrap="nowrap" width="4"><spacer height="1" width="1"
						type="block" /></td>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/Smart Inventory/BLCorner.gif" width="7" /></td>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/Smart Inventory/BRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
			</tbody>
		</table>		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<%
}
catch(Exception e)
{
	//System.out.println(e.getMessage());
}
%>
</form>
<%@ include file="../footer.jsp"%>
</body>
</html>
