<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.bean.Attendance.*"%>
<html>
<head>
<title> :: PAYROLL ::</title>
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
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/Payroll/Appoinmentletter.js"></script>
  <%@ include file="index.jsp"%>
 

  
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
@import url("../bootstrap/css/bootstrap.min.css");
-->
</style>

  <script src="../bootstrap/js/jquery.min.js"></script>
 <script src="../bootstrap/js/bootstrap.min.js"></script>

<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="document.getElementById('searchstaff').focus()">
<form  AUTOCOMPLETE = "off"   method="get" name="frmState" > 
 

<table width="100%" height="437" align="center">
	<!--DWLayoutTable-->
	<tr>
		<td height="17" colspan="6" align="center">
	<tr>
		<td height="17" colspan="6" align="center">
	<tr>
		<td height="80" colspan="6" align="center">
		<table width="90%" height="327" border="0" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"
			 >
			<!--DWLayoutTable-->
			<tr align="center" valign="middle" 
			 background="">
				<td height="14" class="boldgre"   > <div align="center" class="whiteMedium">STAFF INFORMATION
				</div></td>
			</tr>

			
			<tr  >
				<td height="31"  >
				<table width="100%" border="0" align="center" cellpadding="0"
					cellspacing="2" class="whiteMedium">
					<tr>
					  <td ><div align="right"><span >Search by Name / ID </span></div></td>
					  <td   >&nbsp;</td>
					  <td   >
					  
					  
					  <input name="searchstaff" id="searchstaff" type="text" class="formText135" size="15" 							maxlength="10" onBlur="LoadSearchStaff('searchstaff')">  </td>
			        </tr>
				</table>				</td>
			</tr>
			<tr>
				<td height="31" align="left" valign="middle">
				<table width="100%" border="0" class="whiteMedium" >
					<tr>
						<td width="11%"><div align="center">Staff Id</div></td>
						<td width="11%"><div align="center">Staff Name</div></td>
						<td width="11%"><div align="center">Company Name</div></td>
						<td width="11%"><div align="center"> Branch</div></td>
						<td width="11%"><div align="center"> Department</div></td>
						<td width="11%"><div align="center">Designation</div></td>
						<td width="11%"><div align="center">Mobile</div></td>
					    <td width="11%"><div align="center">Print</div></td>
					</tr>
				</table>				</td>
			</tr>
			<tr>
				<td height="21" valign="top" bgcolor="#FFFFFF"><br>
				<div id="staffTable" style="OVERFLOW:auto;width:100%;height:300px"></div><br>
				<div id="totalrecord" align="center"></div><br><br>
		</table>
	<tr>
	  <td height="17" colspan="6"><!--DWLayoutEmptyCell-->&nbsp;</td>
    </tr>
	<tr>
		<td height="17" colspan="6">
		<table width="90%" border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign">
			<tr class="para">
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaff('0')">ALL</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaff('A')">A</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaff('B')">B</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaff('C')">C</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaff('D')">D</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaff('E')">E</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaff('F')">F</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaff('G')">G</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaff('H')">H</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaff('I')">I</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaff('J')">J</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaff('K')">K</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaff('L')">L</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaff('M')">M</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaff('N')">N</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaff('O')">O</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaff('P')">P</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaff('Q')">Q</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaff('R')">R</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaff('S')">S</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaff('T')">T</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaff('U')">U</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaff('V')">V</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaff('W')">W</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaff('X')">X</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaff('Y')">Y</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaff('Z')">Z</a></div>				</td>
			</tr>
		</table>
		<a href=javascript:; onClick="windowSave('sample.txt')"></a></td>
	</tr>
	<tr>
		<td id="tables" height="5" colspan="6">
	<tr>
		<td height="17" colspan="6">
		<table border="0" align="center" cellpadding="2" cellspacing="2">
			<tr>
				 
 	 
				<td width="56"><input class="ButtonHead" type="button"
					name="Button"  value="Close"   accesskey="c"  onClick="redirect('Payrollmain.jsp')"></td>
				 
			</tr>
		</table>
	<tr>
		<td height="17" colspan="6">
		  <%@ include file="../footer.jsp"%>
		 
</table>
</form>
</body>
</html>
