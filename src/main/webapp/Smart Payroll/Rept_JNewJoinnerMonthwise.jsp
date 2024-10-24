<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>

<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*" errorPage=""%>
<html>
<head>
<link href="../JavaScript/SmartStyles.css" rel="stylesheet" type="text/css">
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

<title> :: PAYROLL ::</title>

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
.style8 {font-family: Verdana;
	font-size: 12px;
}
-->
</style><script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">
	function disableMonthWise()
	{
		document.frm.year.disabled=false;
		document.frm.month.disabled=false;
		document.frm.frmdate.disabled=true;
		document.frm.todate.disabled=true;		
	}
	function disableYearWise()
	{
		document.frm.year.disabled=true;
		document.frm.month.disabled=true;
		document.frm.frmdate.disabled=false;
		document.frm.todate.disabled=false;
	}
	</script>
	<script language="javascript" type="text/javascript">
function Validate()
  {
  	if(checkNullSelect( "reportType","Select Export Type" ,'0') && checkNullSelect('Month','Select Month','0'))	
		return true;
	else
	return false;
}
</script>

 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>

</head>

<body  onpaste='return false;'>
<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth" onSubmit="return Validate()">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="200">
		<table class="BackGround" cellspacing="0" cellpadding="0" width="342"
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
					<table width="328" border="0" cellspacing="2" cellpadding="2"
						 >
						<!--DWLayoutTable-->
						<tr align="center" valign="middle">
							<td height="18" colspan="2"  class="BackGround">JOINNER LIST </td>
						</tr>

						<tr class="bolddeepblue">
						  <td height="23" valign="middle" class="style3"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  <td valign="top" class="bolddeepblue"><!--DWLayoutEmptyCell-->&nbsp;</td>
					  </tr>
						<tr class="bolddeepblue">
							<td width="146" height="24" valign="middle"><span class="boldEleven">Office</span><span class="bolddeepred"> * </span></td>
							<td width="168" valign="top" class="bolddeepblue">
							<%
			   	String branchid=""+session.getAttribute("BRANCHID");
	   			String oficeid=""+session.getAttribute("OFFICEID");
				 
			  %> <select name="Office" class="formText135" id="Office">
								<option value="0">All</option>
								<%
								
		String sq=" select INT_OFFICEID,CHR_OFFICENAME from  com_m_office  order by CHR_OFFICENAME";

		String shipids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sq);
		for(int u=0; u<shipids.length; u++)
			if(shipids[u][0].trim().equals(oficeid.trim()))
				out.print("<option selected = 'selected' value='"+shipids[u][0]+"'>"+shipids[u][1] +"</option>");
			else
				out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][1] +"</option>");
							%>
							</select></td>
						</tr>
						<tr class="bolddeepblue">
							<td height="24" valign="middle"><span class="boldEleven">Department</span><span class="bolddeepred"> * </span></td>
							<td valign="top" class="bolddeepblue"><select name="dept"
								id="dept" class="formText135" onChange="init()">
								<option value="0">All</option>
								<%
		sq="SELECT INT_DEPARTID,CHR_DEPARTNAME FROM   com_m_depart   ORDER BY  CHR_DEPARTNAME";
		String deptid[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sq);
		
		for(int u=0;u<deptid.length;u++)
			out.print("<option value='"+deptid[u][0]+"'>"+deptid[u][1]+"</option>"); 
	%>
							</select></td>
						</tr>
						<tr class="bolddeepblue">
						  <td height="24" valign="middle"><span class="boldEleven">Order by</span><span class="bolddeepred"> * </span></td>
						  <td valign="top" class="bolddeepblue"><select name="orderby"
								class="formText135" id="orderby">
                            <option value="a.CHR_STAFFNAME">Staff Name</option>
                            <option value="a.DT_DOJCOLLEGE">Joinning Date</option>
                          </select></td>
					  </tr>
						<tr class="bolddeepblue">
							<td height="24" valign="middle"><span class="boldEleven">Excluding Resigner</span><span class="bolddeepred"> * </span></td>
							<td valign="top" class="bolddeepblue"><input name="Resign" type="checkbox" id="Resign" value="Y"></td>
						</tr>
						<tr align="center" valign="middle">
                          <td height="28" align="left" valign="middle"
								class="boldEleven"><span class="boldEleven">Month</span> <span class="bolddeepred">*</span> </td>
						  <td align="left" valign="middle" class="boldEleven"><%@ include file="../JavaScript/month.jsp"%></td>
					  </tr>
						<tr align="center" valign="middle">
						  <td height="28" align="left" valign="middle"
								class="boldEleven"><span class="boldEleven">Day</span> <span class="bolddeepred">*</span> </td>
						  <td align="left" valign="middle" class="boldEleven">
						  <select id="Day" name="Day">
						  <%
						  for(int u=0;u<32;u++)
						      out.print("<option value='"+(u+1)+"'>"+(u+1)+"</option>"); 
						  %>
						  </select>						  </td>
					  </tr>
						<tr align="center" valign="middle">
						  <td height="28" align="left" valign="middle"
								class="boldEleven"><span class="boldEleven">Export Type</span> <span class="bolddeepred">*</span> </td>
						  <td align="left" valign="middle" class="boldEleven"><select name="select">
                            <option value="0">Select Export Type</option>
                            <option value="csv">CSV</option>
                            <option value="xls">Excel</option>
                            <option value="html">HTML</option>
                            <option value="pdf">PDF</option>
                            <option value="txt">Text</option>
                            <option value="rtf">Word</option>
                            <option value="xml">XML</option>
                          </select></td>
					  </tr>
						 
						
						<tr class="bolddeepblue">
						  <td height="23" colspan="2" valign="middle" class="style3"><!--DWLayoutEmptyCell-->&nbsp;</td>
						</tr>
						<tr>
							<td height="28" colspan="2" valign="middle" class="bolddeepblue">
							<table width="142" border="0" align="center" cellpadding="3"
								cellspacing="3">
								<tr>
									<td width="61"><input name="Submit2" type="submit"
										class="buttonbold14" id="submit" value="Submit"   accesskey="s"   ></td>
									<td width="60"><input class="buttonbold14" type="button"
										name="Submit"  value="Close"   accesskey="c" 
										onClick="redirect('NewJoinner.jsp')"></td>
								</tr>
							</table>							</td>
						</tr>
						<tr>
							<td height="2"></td>
							<td></td>
						</tr>
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
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
</form>
<%@ include file="../footer.jsp"%>
</body>
</html>
