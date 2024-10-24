<%@ page import="java.io.*,java.util.*" isErrorPage="false"
	errorPage="../error/error.jsp"%>
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
</head>
<script language="javascript" src="../../JavaScript/comfunction.js"></script>
<script language="javascript" src="../../JavaScript/calendar1.js"></script>
<script language="javascript"
	src="../../JavaScript/Inventory/ReportCustomer.js"></script>
<script language="JavaScript">
function SalePay(salid)
	{	
		var payType=document.getElementById('payType').value;
		var width="800", height="400";
  		var left = (screen.width/2) - width/2;
		var top = (screen.height/2) - height/2;
  		var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=yes,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
		var f ="SalesPaymentActionEdit.jsp?payType="+payType+"&salesid="+salid;
		newWindow = window.open(f,"subWind",styleStr);
		newWindow.focus( );
	}
 	
	function getDBPath()
	{
		var pathname = window.location.pathname;
		var iPos = window.location.pathname.toString().toLowerCase().lastIndexOf('.nsf');
		if(iPos>0) return pathname.substring(0, iPos+4);
		alert(pathname);
		return pathname; 
	} 

</script>

<body    onLoad="SalesPayment('0')">
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="">
<table width="100%" border="0" cellspacing="1" cellpadding="1">
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
		<td>
		<table width="800" height="227" border="1" align="center"
			cellpadding="1" cellspacing="1"  >
			<tr class="BackGround">
				<td height="31" class="BackGround">
				<div align="center"><span class="boldThirteen">Sales
				Payment Details  </span></div>
				</td>
			</tr>
			<tr class="BackGround">
				<td height="31" class="BackGround">
				<table width="573" border="0" align="center" cellpadding="0"
					cellspacing="0">
					<tr>
						<td class="boldThirteen">Payment</td>
						<td><select name="payType" id="payType"
							onChange="SalesPayment('0')">
							<option value="Invoice">Invoice Payment</option>
							<option value="CashPay">Cash Sale Payment</option>
							<option value="Direct">Direct Sale Payment</option>
						</select></td>
						<td height="28"><span class="boldThirteen">&nbsp;Month</span></td>
						<td><span class="boldThirteen"> <select name="month"
							id="month" onChange="SalesPayment('0')">
							<%@ include file="../../JavaScript/Inventory/month.jsp"%>
						</select> </span></td>
						<td><span class="boldThirteen">Year</span></td>
						<td><span class="boldThirteen"> <select name="year"
							id="year" onChange="SalesPayment('0')">
							<%@ include file="../../JavaScript/Inventory/year.jsp"%>
						</select><script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						setOptionValue('month',month1);
						setOptionValue('year',year1);							
				//-->
          </script> </span></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr class="BackGround">
				<td height="31" class="BackGround">
				<div align="center">
				<table width="100%" border="1" bordercolor="#FFEEFF" cellspacing="1"
					cellpadding="1">
					<tr class="BackGround">
						<td class="bold1" width="105">
						<div align="center">Invoice/CaseID</div>
						</td>
						<td class="bold1" width="109">
						<div align="center">Date</div>
						</td>
						<td class="bold1" width="152">
						<div align="center">Customer Name</div>
						</td>
						<td class="bold1" width="118">
						<div align="center">Total Amount</div>
						</td>
						<td class="bold1" width="89">
						<div align="center">Paid Amount</div>
						</td>
						<td class="bold1" width="133">
						<div align="center">Balance Amount</div>
						</td>
						<td class="bold1" width="48">
						<div align="center">Print</div>
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
						<td height="24">
						<div id="SalesPaymentTable"></div>
						</td>
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
	<tr>
		<td>
		<table width="800" border="0" align="center" cellpadding="1"
			cellspacing="1"  >
			<tr class="para">
				<td class="boldEleven">
				<div align="center"><a href="javascript:SalesPayment('0')">All</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:SalesPayment('A')">A</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:SalesPayment('B')">B</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:SalesPayment('C')">C</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:SalesPayment('D')">D</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:SalesPayment('E')">E</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:SalesPayment('F')">F</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:SalesPayment('G')">G</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:SalesPayment('H')">H</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:SalesPayment('I')">I</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:SalesPayment('J')">J</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:SalesPayment('K')">K</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:SalesPayment('L')">L</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:SalesPayment('M')">M</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:SalesPayment('N')">N</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:SalesPayment('O')">O</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:SalesPayment('P')">P</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:SalesPayment('Q')">Q</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:SalesPayment('R')">R</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:SalesPayment('S')">S</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:SalesPayment('T')">T</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:SalesPayment('U')">U</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:SalesPayment('V')">V</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:SalesPayment('W')">W</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:SalesPayment('X')">X</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:SalesPayment('Y')">Y</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:SalesPayment('Z')">Z</a></div>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<p><input name="filename" type="hidden" value="SalesPayment" /> <input
			name="actionS" type="hidden" value="INVSalesDelete" />
		</td>
	</tr>
	<tr>
		<td>
		<table width="56" border="0" align="center" cellpadding="1"
			cellspacing="1">
			<!--DWLayoutTable-->
			<tr>
				<td width="111"><input type="button" class="buttonbold13"
					name="submit"  value="Close"   accesskey="c" 
					onClick="redirect('../InventoryMain.jsp')" /></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<%@ include file="../../footer.jsp"%></form>
</body>
</html>
