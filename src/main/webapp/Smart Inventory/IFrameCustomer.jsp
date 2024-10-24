<%@ page import="java.io.*,java.util.*,java.sql.*" isErrorPage="false"
	errorPage="../error/error.jsp"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<html>
<head>
<title>:: INVENTORY ::</title><link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
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
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="javascript"
	src="../JavaScript/Inventory/InvenProductSearchAJAX.js"></script>

</head>
<body    onLoad="loadCustomerSearch()">
<form  AUTOCOMPLETE = "off"   name="frm" method="get">
<table width="100%" height="375" border="0" cellspacing="1"
	cellpadding="1">
	<tr>
		<td valign="middle">
		<table width="600" height="250" border="1" align="center"
			cellpadding="1" cellspacing="1"  >
			<tr class="BackGround">
				<td height="31" class="BackGround">
				<div align="center" class="boldThirteen">Customer Group Name:
				<select name="selProduct" id="selProduct"
					onChange="loadCustomerSearch()">
					<%
           Connection con=conbean.getConnection();  
           Statement st=con.createStatement();
           String str="SELECT INT_CUSTOMERGROUPID,CHR_NAME FROM INV_M_CUSTOMERGROUP";
           ResultSet rs=null;
           rs=st.executeQuery(str);
         while(rs.next())
 	 	 {
 	 	 	
 	 	 	out.println("<option value='"+rs.getString("INT_CUSTOMERGROUPID")+"'>"+rs.getString("CHR_NAME")+"</option>");
 	 	 }
        %>
				</select> Customer Name :: <input type="text" name="txtSer" id="txtSer"
					maxlength="10" size="5" class="formText135"
					onKeyUp="loadCustomerSearch()"> </select></div>
				</td>
			</tr>
			<tr class="BackGround" colspan="6">
				<td height="31" class="BackGround">
				<div align="center">
				<table width="100%" border="0" cellspacing="1" cellpadding="1">
					<tr class="BackGround">
						<td class="bold1" width="100">
						<div>SNO</div>
						</td>
						<td class="bold1" width="130">
						<div>Customer Id</div>
						</td>
						<td class="bold1" width="200">
						<div>Customer Name</div>
						</td>
						<td class="bold1" width="150">
						<div>City</div>
						</td>
						<td class="bold1" width="150">
						<div>Phone</div>
						</td>
						<td class="bold1" width="150">
						<div>Fax</div>
						</td>

					</tr>
				</table>
				</div>
				</td>
			</tr>
			<tr>
				<td height="127" valign="top" class="footermenu">
				<table width="100%">
					<tr>
						<td class="bolddeepblue" align="center">
						<div align="center" id="totRec"></div>
						</td>
					</tr>
					<tr>
						<td class="bolddeepblue" align="center" bgcolor="#efefef"></td>
					</tr>
					<tr>
						<td>
						<div id="divscroll" style="OVERFLOW:auto;width:600px;height:130px"
							class="boldEleven">
						<div id="CustomerSearchTable"></div>
						</div>
						</td>
					</tr>
				</table>
				</td>
			</tr>

		</table>
		</td>
	</tr>




</table>

</form>
</body>
</html>
