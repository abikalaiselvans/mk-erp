<%@ page contentType="text/html; " language="java" import="java.sql.*"	errorPage="../error/index.jsp"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<html>
<head>

<title> :: UTILITY :: </title>

<%@include file="Redirect.jsp" %>
 
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

 <link href="style.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
 

<body  onpaste='return false;'>
 <%
try
{
%>
<form name="frm" action="../SmartLoginAuth" AUTOCOMPLETE='OFF'  >
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td></td>
	</tr>
	<tr>
	  <td>    
    <tr>
	  <td>    
    <tr>
      <td>    
    <tr>
      <td>    
    <tr>
      <td>    
    <tr>
      <td align="center">    
    <tr>
      <td align="center">    
    <tr>
		<td align="center">
		  <table class="BackGround1" cellspacing="0" cellpadding="0" width="400"
			align="center" border="0">
			<tbody>
				<tr>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></td>
					<td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
				</tr>
				<tr>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
					<td width="6"><spacer height="1" width="1" type="block" /></td>
					<td width="412">
					<table width="700" border="0" align="center" cellpadding="0"
						cellspacing="0"  >
						<!--DWLayoutTable-->
						<tr align="center" valign="middle">
							<td height="28" colspan="2"  class="BackGround">MODULE SETTING                          </td>
						</tr>
						<tr>
						  <td height="28" colspan="2" valign="middle" class="bolddeepblue">
	                        <div align="center">
	                           	 <%
			out.println("<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
			out.println("<tr class='MRow2'><td class='boldEleven'><div align='center'><b>S.No</div></td>");
			out.println("<td class='boldEleven'><div align='center'><b>Module</div></td>");
			out.println("<td class='boldEleven'><div align='center'><b>Package</div></td>");
			out.println("<td class='boldEleven'><div align='center'><b>Short Name</div></td>");
			out.println("<td class='boldEleven'><div align='center'><b>TITLE</div></td></tr>");
			String sql="SELECT INT_ID,CHR_SHORTNAME,CHR_MODULE,CHR_MODULETITLE,CHR_PACKAGE FROM   m_projectmodule  WHERE CHR_STATUS='Y' ORDER BY CHR_MODULE";
			String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			 
			for(int u=0;u<data.length;u++)
			{
				if(u%2==0)
					out.println("<tr class='MRow2' height='20'>");	
				else
					out.println("<tr class='MRow1' height='20'>");		
				out.println("<td width='204' class='boldEleven'>"+(u+1)+"</td>");
				out.println("<td width='204' class='boldEleven'>"+data[u][2]+"</td>");
				out.println("<td width='204' class='boldEleven'>"+data[u][4]+"</td>");
				out.println("<td width='204' class='boldEleven'>"+data[u][1]+"</td>");
				out.println("<td width='21' class='boldEleven'><input size='50'   class='formText135'  type='text' value='"+data[u][3]+"' name='title"+(u+1)+"'  id='title"+(u+1)+"' maxlength='100' ></td>");
				
				 
			}							
			out.println(" </table>");
		%>  
                          </div></td>
					  </tr>
						<tr>
							<td width="138" height="28" valign="middle" class="bolddeepblue"><!--DWLayoutEmptyCell-->&nbsp;</td>
							<td width="228" valign="top"><input name="filename"
									type="hidden" id="filename" value="ModuleSetting" />
                              <input name="actionS"
									type="hidden" value="UTIModuleSetting" /></td>
						</tr>
						<tr>
							<td height="28" colspan="2" valign="middle" class="tabledata">
							<center>
							<table border="0" align="center" cellpadding="1" cellspacing="1">
								<tr>
									<td width="56"><input name="Submit" type="submit"
										class="buttonbold" value="Submit"   accesskey="s"    /></td>
									<td width="56"><input class="buttonbold" type="button"
										name="Submit2"  value="Close"   accesskey="c" 
										onClick="redirect('Userframe.jsp')" /></td>
								</tr>
							</table>
							</center>							</td>
						</tr>
					</table>					</td>
					<td nowrap="nowrap" width="4"><spacer height="1" width="1"
						type="block" /></td>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BLCorner.gif" width="7" /></td>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
			</tbody>
		</table>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td></td>
	</tr>
</table>
<%
}
catch(Exception e)
{
}
%>
 
</form>
</body>
</html>
