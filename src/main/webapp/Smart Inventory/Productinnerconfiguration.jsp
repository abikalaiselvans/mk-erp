<%@ page import="java.io.*,java.util.*" isErrorPage="false" errorPage="./error.jsp"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="com.my.org.erp.SmartInventory.Product"%>
<%
try
{
%>
<%!String productId, productName;%>
<%@ page import="com.my.org.erp.common.CommonInfo"%>
<html>
<head>
<title>:: INVENTORY ::</title>
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>


<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>



<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/Inventory/InvenAJAX.js"></script>
<script language="JavaScript"> 

 
function Validate()
  {
  		 
		if(
			checkNullSelect("make","Select Make...",'0') 
			&& checkNullSelect("model","Select Model...",'0') 
			&& checkNullSelect("processor","Select Processor...",'0') 
		 	&& checkNullSelect("memory","Select Memory...",'0') 
			&& checkNullSelect("harddisk","Select Hard Disk...",'0') 
			&& checkNullSelect("graphics","Select graphics",'0') 
			&& checkNullSelect("monitor","Select monitor",'0') 
			&& checkNullSelect("wireless","Select wireless",'0') 
			&& checkNullSelect("lan","Select lan",'0') 
			&& checkNullSelect("opticaldrive","Select opticaldrive",'0') 
			&& checkNullSelect("os","Select Operating system...",'0')
			&& checkNullSelect("warrantysupport","Select Waaranty Support",'0') 
		)
			return true;
		else
			return false;
		 
  } 

</script>

<body >
<jsp:include page="indexinv.jsp" />

<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td>
		<%
String rowid=request.getParameter("rowid");
String sql=" ";
sql = " SELECT INT_PRODUCTIDS,CHR_PRODUCTID,CHR_PRODUCTCODE,CHR_ITEMLIST,DOU_PURCHASEPRICE, ";
sql = sql + " DOU_SALESPRICE,INT_STOCKINHAND,CHR_WARRANTY,CHR_COLOR,CHR_MODEL,CHR_PRODUCTDESC, ";
sql = sql + " INT_PRODUCTGROUPID,INT_ACTIVE,CHR_PTYPE,CHR_PTYPE,INT_TAXID,CHR_USRNAME, ";
sql = sql + " DT_UPDATEDATE,CHR_UPDATESTATUS, DT_UPDATEDATE,CHR_UPDATESTATUS,INT_MAKEID ,";
sql = sql + " INT_MAKEID ,CHR_MODEL,INT_PROCESSORID,INT_MEMORYID ,INT_HARDDISKID,INT_OSID,CHR_WARRANTYSUPPORT ";
sql = sql + " FROM inv_m_produtlist WHERE INT_PRODUCTIDS= "+rowid;
//out.println(sql);
String product[][]= CommonFunctions.QueryExecute(sql);
 
		%> 
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth"
			onSubmit="return Validate()">
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="424"
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
					<td width="412">
					<table cellspacing="2" cellpadding="2" width="388" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							<tr>
								<td height="16" colspan="3" align="center" valign="top"
									class="boldThirteen">PRODUCT INNER CONFIGURATION 
								  <input name="filename" type="hidden" value="ProductList" />
                                  <input
											name="actionS" type="hidden" value="INVInnerConfiguration" />
                                  <span class="boldred">
                                  <input name="rowid" type="hidden" id="rowid" value="<%=rowid%>">
                              </span></td>
							</tr>
							<tr>
								<td height="19" colspan="3" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory
								</span></td>
							</tr>
							 
							<tr>
								<td height="17" class="boldEleven">Product Code <span
									class="bolddeepred">* </span></td>
							  <td colspan="2" align="left">
<input name="productCode" 	id="productCode" size="30" value="<%=product[0][2] %>"
									type="text"     onBlur="upperMe(this)"      class="formText135"
									maxlength="50"><input type="hidden" name="productId" id="productId" value="<%=product[0][0] %>">
<span class="boldred"> <%=product[0][1]%></span></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Make  <span
									class="bolddeepred">* </span></td>
								 

								<td colspan="2" align="left"><select name="make" id="make" style="width: 200" class="formText135">
                                  <option value="0">Select Make</option>
                                  <%
	String makata[][] = CommonFunctions.QueryExecute("SELECT INT_MAKEID,CHR_MAKENAME  FROM inv_m_make  ORDER BY CHR_MAKENAME");
	for (int i = 0; i < makata.length; i++)  
		out.println("<option value='" + makata[i][0] + "'>"	+ makata[i][1] + "</option>");
	%>
                                </select>
<script language="javascript">setOptionValue('make','<%=product[0][22]%>')</script>								</td>
							</tr>
							<tr>
							  <td height="17" class="boldEleven">Model <span
									class="bolddeepred">* </span></td>
							  <td colspan="2" align="left"><select name="model" id="model" style="width: 200" class="formText135">
                                <option value="0">Select Model</option>
                                <%
	String makata1[][] = CommonFunctions.QueryExecute("SELECT INT_MODELID,CHR_MODELCODE  FROM inv_m_model  ORDER BY CHR_MODELCODE");
	for (int i = 0; i < makata1.length; i++)  
		out.println("<option value='" + makata1[i][0] + "'>"	+ makata1[i][1] + "</option>");
	%>
                              </select>
<script language="javascript">setOptionValue('model','<%=product[0][23]%>')</script>							  </td>
						  </tr>
							<tr>
							  <td height="17" class="boldEleven">Processor <span
									class="bolddeepred">* </span></td>
							  <td colspan="2" align="left"><select name="processor" id="processor" style="width: 200" class="formText135">
                                <option value="0">Select Processor</option>
                                <%
	String makata2[][] = CommonFunctions.QueryExecute("SELECT INT_PROCESSORID,CHR_PROCESSORNAME  FROM inv_m_processor  ORDER BY CHR_PROCESSORNAME");
	for (int i = 0; i < makata2.length; i++)  
		out.println("<option value='" + makata2[i][0] + "'>"	+ makata2[i][1] + "</option>");
	%>
                              </select>
<script language="javascript">setOptionValue('processor','<%=product[0][24]%>')</script>							  </td>
						  </tr>
							<tr>
							  <td height="17" class="boldEleven">Chipset</td>
							  <td colspan="2" align="left"><select name="chipset" id="chipset" style="width: 200" class="formText135">
                                <option value="0">Select chipset</option>
                                <%
	String makatac[][] = CommonFunctions.QueryExecute("SELECT INT_CHIPSETID,CHR_CHIPSET  FROM inv_m_chipset  ORDER BY CHR_CHIPSET");
	for (int i = 0; i < makatac.length; i++)  
		out.println("<option value='" + makatac[i][0] + "'>"	+ makatac[i][1] + "</option>");
	%>
                              </select></td>
						  </tr>
							<tr>
							  <td height="17" class="boldEleven">Memory <span
									class="bolddeepred">* </span></td>
							  <td colspan="2" align="left"><select name="memory" id="memory" style="width: 200" class="formText135">
                                <option value="0">Select Memory</option>
                                <%
	String makata3[][] = CommonFunctions.QueryExecute("SELECT INT_MEMORYID,CHR_MEMORYNAME  FROM inv_m_memory  ORDER BY CHR_MEMORYNAME");
	for (int i = 0; i < makata3.length; i++)  
		out.println("<option value='" + makata3[i][0] + "'>"	+ makata3[i][1] + "</option>");
	%>
                              </select>
<script language="javascript">setOptionValue('memory','<%=product[0][25]%>')</script>							  </td>
						  </tr>
							<tr>
							  <td height="17" class="boldEleven">Hard Disk  <span
									class="bolddeepred">* </span></td>
							  <td colspan="2" align="left"><select name="harddisk" id="harddisk" style="width: 200" class="formText135">
                                <option value="0">Select Hard Disk</option>
                                <%
	String makata4[][] = CommonFunctions.QueryExecute("SELECT INT_HARDDISKID,CHR_HARDDISKNAME  FROM inv_m_harddisk  ORDER BY CHR_HARDDISKNAME");
	for (int i = 0; i < makata4.length; i++)  
		out.println("<option value='" + makata4[i][0] + "'>"	+ makata4[i][1] + "</option>");
	%>
                              </select>
<script language="javascript">setOptionValue('harddisk','<%=product[0][26]%>')</script>							  </td>
						  </tr>
							<tr>
							  <td height="17" class="boldEleven">Graphics <span
									class="bolddeepred">*</span></td>
							  <td colspan="2" align="left"><select name="graphics" id="graphics" style="width: 200" class="formText135">
                                <option value="0">Select graphics</option>
                                <%
	String makatag[][] = CommonFunctions.QueryExecute("SELECT INT_GRAPHICSID,CHR_GRAPHICS  FROM inv_m_graphics  ORDER BY CHR_GRAPHICS");
	for (int i = 0; i < makatag.length; i++)  
		out.println("<option value='" + makatag[i][0] + "'>"	+ makatag[i][1] + "</option>");
	%>
                              </select></td>
						  </tr>
							<tr>
							  <td height="17" class="boldEleven">Monitor <span
									class="bolddeepred">*</span></td>
							  <td colspan="2" align="left"><select name="monitor" id="monitor" style="width: 200" class="formText135">
                                <option value="0">Select monitor</option>
                                <%
	String makatam[][]= CommonFunctions.QueryExecute("SELECT INT_MONITORID,CHR_MONITOR  FROM inv_m_monitor  ORDER BY CHR_MONITOR");
	for (int i = 0; i < makatam.length; i++)  
		out.println("<option value='" + makatam[i][0] + "'>"	+ makatam[i][1] + "</option>");
	%>
                              </select></td>
						  </tr>
							<tr>
							  <td height="17" class="boldEleven">Wireless <span
									class="bolddeepred">*</span></td>
							  <td colspan="2" align="left"><select name="wireless" id="wireless" style="width: 200" class="formText135">
                                <option value="0">Select wireless</option>
                                <%
	String makataw[][] = CommonFunctions.QueryExecute("SELECT INT_WIRELESSID,CHR_WIRELESS  FROM inv_m_wireless  ORDER BY CHR_WIRELESS");
	for (int i = 0; i < makataw.length; i++)  
		out.println("<option value='" + makataw[i][0] + "'>"	+ makataw[i][1] + "</option>");
	%>
                              </select></td>
						  </tr>
							<tr>
							  <td height="17" class="boldEleven">LAN <span
									class="bolddeepred">*</span></td>
							  <td colspan="2" align="left"><select name="lan" id="lan" style="width: 200" class="formText135">
                                <option value="0">Select lan</option>
                                <%
	String makatal[][] = CommonFunctions.QueryExecute("SELECT INT_LANID,CHR_LAN  FROM inv_m_lan  ORDER BY CHR_LAN");
	for (int i = 0; i < makatal.length; i++)  
		out.println("<option value='" + makatal[i][0] + "'>"	+ makatal[i][1] + "</option>");
	%>
                              </select></td>
						  </tr>
							<tr>
							  <td height="17" class="boldEleven">Optical Drive  <span
									class="bolddeepred">*</span></td>
							  <td colspan="2" align="left"><select name="opticaldrive" id="opticaldrive" style="width: 200" class="formText135">
                                <option value="0">Select opticaldrive</option>
                                <%
	String makatao[][] = CommonFunctions.QueryExecute("SELECT INT_OPTICALID,CHR_OPTICAL  FROM inv_m_opticaldrive  ORDER BY CHR_OPTICAL");
	for (int i = 0; i < makatao.length; i++)  
		out.println("<option value='" + makatao[i][0] + "'>"	+ makatao[i][1] + "</option>");
	%>
                              </select></td>
						  </tr>
							<tr>
							  <td height="17" class="boldEleven">WIFI <span
									class="bolddeepred">*</span></td>
							  <td colspan="2" align="left"><table width="74" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td width="27" class="boldEleven"><input name="wifi" type="radio" class="formText135" value="Y"></td>
                                  <td width="27" class="boldEleven">Yes</td>
                                  <td width="20" class="boldEleven"><input name="wifi" type="radio" class="formText135" value="N" checked></td>
                                  <td width="26" class="boldEleven">No</td>
                                </tr>
                              </table></td>
						  </tr>
							<tr>
							  <td height="17" class="boldEleven">Touch Screen  <span
									class="bolddeepred">*</span></td>
							  <td colspan="2" align="left"><table width="74" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td width="27" class="boldEleven"><input name="touchscreen" type="radio" class="formText135" value="Y"></td>
                                  <td width="27" class="boldEleven">Yes</td>
                                  <td width="20" class="boldEleven"><input name="touchscreen" type="radio" class="formText135" value="N" checked></td>
                                  <td width="26" class="boldEleven">No</td>
                                </tr>
                              </table></td>
						  </tr>
							<tr>
							  <td height="17" class="boldEleven">Card Reader  <span
									class="bolddeepred">*</span></td>
							  <td colspan="2" align="left"><table width="74" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td width="27" class="boldEleven"><input name="cardreader" type="radio" class="formText135" value="Y"></td>
                                  <td width="27" class="boldEleven">Yes</td>
                                  <td width="20" class="boldEleven"><input name="cardreader" type="radio" class="formText135" value="N" checked></td>
                                  <td width="26" class="boldEleven">No</td>
                                </tr>
                              </table></td>
						  </tr>
							<tr>
							  <td height="17" class="boldEleven">Operating System  <span
									class="bolddeepred">* </span></td>
							  <td colspan="2" align="left"><select name="os" id="os" style="width: 200" class="formText135">
                                <option value="0">Select Operating System</option>
                                <%
	String makata5[][] = CommonFunctions.QueryExecute("SELECT INT_OSID,INT_OSNAME  FROM inv_m_operatingsystem  ORDER BY INT_OSNAME");
	for (int i = 0; i < makata5.length; i++)  
		out.println("<option value='" + makata5[i][0] + "'>"	+ makata5[i][1] + "</option>");
	%>
                              </select>
<script language="javascript">setOptionValue('os','<%=product[0][27]%>')</script>							  </td>
						  </tr>
							<tr>
							  <td height="17" class="boldEleven">Warranty Support  <span
									class="bolddeepred">* </span></td>
							  <td colspan="2" align="left"><select name="warrantysupport" id="warrantysupport" style="width: 200" class="formText135">
                                <option value="0">Select Warranty Support</option>
                                  <option value="Y">Yes</option>
								  <option value="N">No</option>
                              </select>
<script language="javascript">setOptionValue('warrantysupport','<%=product[0][28]%>')</script>							  </td>
						  </tr>
							<tr>
							  <td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td colspan="2" align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  </tr>
							<tr>
								<td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp; </td>
								 	<td colspan="2" align="left"><!--DWLayoutEmptyCell-->&nbsp; </td>
							</tr>
							 
							<tr>
								<td height="17" colspan="3" class="boldEleven">
								<table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
									<tr>
										<td><input name="Submit" type="submit"
											class="buttonbold13" value="Update"></td>
										<td><input name="Close" type="Button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="location.href='ProductListView.jsp'"></td>
									</tr>
								</table>								</td>
							</tr>
						</tbody>
						<input type="hidden" name="mobileBookingOption" />
					</table>
					</td>
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
		</table>
		</form>
		</td>
	</tr>
	<tr>
		<td height="65">&nbsp;</td>
	</tr>
</table>
<jsp:include page="../footer.jsp" />
</body>
</html>

<%
}
catch(Exception e)
{
	 System.out.println(e.getMessage());
}
%>
