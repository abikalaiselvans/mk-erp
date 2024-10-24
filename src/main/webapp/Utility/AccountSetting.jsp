<%@ page contentType="text/html; " language="java" import="java.sql.*"
	errorPage="../error/index.jsp"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<html>
<head>

<title> :: UTILITY :: </title>


 
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
<script language="JavaScript">

function valid()
{
	if( checkNull(ctr,msg))
		return true;
	else
		return false;
}	
	
</script>

<body  onpaste='return false;'>
<form name="a" action=" Userframe.jsp" method="post" >
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td> </td>
	</tr>
	<tr>
	  <td align="center">&nbsp;</td>
    </tr>
	<tr>
	  <td align="center">&nbsp;</td>
    </tr>
	<tr>
	  <td align="center">&nbsp;</td>
    </tr>
	<tr>
	  <td align="center">&nbsp;</td>
    </tr>
	<tr>
	  <td align="center">&nbsp;</td>
    </tr>
	<tr>
		<td align="center">
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="700"
			align="center" border="0">
			<tbody>
				<tr>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></td>
					<td class="BorderLine" height="0"> </td>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td height="6"> </td>
				</tr>
				<tr>
					<td class="BorderLine" width="1"> </td>
					<td width="6"> </td>
					<td>
					<table width="100%" border='0' align="center" cellpadding='0' cellspacing='0' bgcolor='#9900CC'  class='boldEleven'>
						<!--DWLayoutTable-->
						<tr align="center" valign="middle">
							<td height="28" colspan="5"  class="BackGround">Account
							Information</td>
				        </tr>
						<tr class="BackGround">
							      	
        	
							<td width="161" height="28" valign="middle" class="bolddeepblue">Stock Opening </td>
							<td width="177" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
							<td width="17" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
						    <td width="115" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
						    <td width="147" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
						</tr>
						<tr class="BackGround">
							<td height="28" valign="middle" class="bolddeepblue">Salary </td>
							<td valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
							<td valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
						    <td valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
						    <td valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
						</tr>
						<tr class="BackGround">
							<td height="28" valign="middle" class="bolddeepblue">Conyance</td>
							<td valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
							<td valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
						    <td valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
						    <td valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
						</tr>
						<tr class="BackGround">
							<td height="28" valign="middle" class="bolddeepblue"><!--DWLayoutEmptyCell-->&nbsp;</td>
							<td valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
							<td valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
						    <td valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
						    <td valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
						</tr>
						<tr class="BackGround">
						  <td height="28" colspan="5" valign="middle" class="bolddeepblue">
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
						  </center>						  </td>
					  </tr>
					</table>				  </td>
					<td nowrap="nowrap" width="4"> </td>
					<td class="BorderLine" width="1"> </td>
				</tr>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BLCorner.gif" width="7" /></td>
					<td height="6"> </td>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td class="BorderLine" height="0"> </td>
				</tr>
			</tbody>
		</table>	  </td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td> </td>
	</tr>
</table>
</form>
</body>
</html>
