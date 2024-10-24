<%@ page contentType="text/html; " language="java" import="java.sql.*"	errorPage="../error/index.jsp"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>

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
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, servicetax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

<link href="style.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<script language="JavaScript">
function mainPage()
	{
	    document.a.action="SettingType.jsp";
		
		return true;
    }
	
function valid()
{
	if( checkNull(ctr,msg))
		return true;
	else
		return false;
}	
	
</script>

<body  onpaste='return false;'>
 <%
try
{
%>
<form name="a" action="../SmartLoginAuth"  >
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td></td>
	</tr>
	<tr>
	  <td align="center">    
    <tr>
	  <td align="center">    
    <tr>
      <td align="center">    
    <tr>
      <td align="center">    
    <tr>
      <td align="center">    
    <tr>
      <td align="center">    
    <tr>
		<td align="center">
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="600"
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
					<table width="95%" border="0" align="center" cellpadding="0"
						cellspacing="0"  >
						<!--DWLayoutTable-->
						<tr align="center" valign="middle">
							<td height="28" colspan="2"  class="BackGround">Leave 
							Information
<%
String sql="select INT_LEAVEID,UPPER(CHR_LEAVENAME), INT_BELOWONEYEAR ,INT_ABOVEONEYEAR ";
sql=sql+" from  att_m_leavetype order by INT_LEAVEID";
String data[][] =  CommonFunctions.QueryExecute(sql);
%></td>
						</tr>
						<tr>
						  <td height="28" colspan="2" valign="middle" class="bolddeepblue">
	                        <div align="center">
	                          <%
		if(data.length>0)
		{
			out.println("<center><table  width='90%' cellpadding=3 cellspacing=1   bgcolor='#9900CC' >");
			out.println("<tr class='MRow1' height='30'>");
			out.println("<td class='boldEleven' align='center'><b>S.NO");
			out.println("<td class='boldEleven' align='center'><b>LEAVE NAME");
			out.println("<td class='boldEleven' align='center'><b>BELOW ONE YEAR");
			out.println("<td class='boldEleven' align='center'><b>ABOVE ONE YEAR");
			for(int u=0;u<data.length;u++)
			{
				if(u%2 == 0)
					out.println("<tr  class='MRow1' height='30'>");
				else
					out.println("<tr  class='MRow2' height='30'>");
					
			out.println("<td class='boldEleven' align='center'>"+(u+1));
			out.println("<td class='boldEleven' align='left'>&nbsp;"+data[u][1]);
			out.println("<td class='boldEleven' align='center'> ");
			out.println("<input name='belowoneyear"+(u+1)+"' type='text' class='formText135' value='"+data[u][2]+"'");
			out.println(" onKeyPress=\"numericValue('belowoneyear"+(u+1)+"','3')\" size='10' maxlength='3' />");
			out.println("<td class='boldEleven' align='center'>");
			out.println("<input name='aboveoneyear"+(u+1)+"' type='text' class='formText135' value='"+data[u][3]+"' ");
			out.println(" onKeyPress=\"numericValue('belowoneyear"+(u+1)+"','3')\" size='10' maxlength='3' />");
			out.println("<input name='rowid"+(u+1)+"' type='hidden' value='"+data[u][0]+"' />");
			}
			out.println("<input name='length' type='hidden' value='"+data.length+"' />");
			out.println("</table></center>");
		}
		else
		{
			out.println("<center><font color='red'>Data not found...</font></center>");
		}	
	  %>						  
                          </div></td>
					  </tr>
						<tr>
							<td width="138" height="28" valign="middle" class="bolddeepblue"><!--DWLayoutEmptyCell-->&nbsp;</td>
							<td width="228" valign="top"><input name="filename"
									type="hidden" id="filename" value="LeaveUpdation" />
                              <input name="actionS"
									type="hidden" value="UTILeaveUpdation" /></td>
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
