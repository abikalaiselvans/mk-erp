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
function SalesOrderPrint(query)
{	
	var width="800", height="400";
	var left = (screen.width/2) - width/2;
	var top = (screen.height/2) - height/2;
	var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=yes,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
	var f ="SalesOrderViewprint.jsp?itemId="+query;
	newWindow = window.open(f,"subWind",styleStr);
	newWindow.focus( );
}		

function mainPage()
{
      document.frm.action="../InventoryMain.jsp";
} 	
 	
</script>

<body    onLoad="loadSalesOrder('0')">
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
		<table width="900" height="199" border="1" align="center"
			cellpadding="1" cellspacing="1"  >
			<tr class="BackGround">
				<td class="BackGround">
				<div align="center"><span class="boldThirteen">Customer
				Purchase </span> 
				</div>
				</td>
			</tr>
			<tr class="BackGround">
				<td height="31" class="BackGround">
				<div align="center" class="boldThirteen">&nbsp;&nbsp;&nbsp;Month
				:: <select name="month" id="month" onChange="loadSalesOrder('0')">
					<%@ include file="../../JavaScript/Inventory/month.jsp"%>
				</select> &nbsp;&nbsp;&nbsp;Year :: <select name="year" id="year"
					onChange="loadSalesOrder('0')">
					<%@ include file="../../JavaScript/Inventory/year.jsp"%>
				</select> <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						setOptionValue('month',month1);
						setOptionValue('year',year1);							
				//-->
          </script></div>
				</td>
			</tr>
			<tr class="BackGround">
				<td height="31" class="BackGround">
				<div align="center">
				<table width="100%" cellspacing='0' cellpadding='0' border='0'>
					<tr class="BackGround">
						<td class="bold1" width="100">
						<div align="center">Quo No</div>
						</td>
						<td class="bold1" width="100">
						<div align="center">Quo.Date</div>
						</td>
						<td class="bold1" width="150">
						<div align="center">Cu.Pur.Order No</div>
						</td>
						<td class="bold1" width="100">
						<div align="center">Sale Date</div>
						</td>
						<td class="bold1" width="150">
						<div align="center">Customer Name</div>
						</td>
						<!--     <td class="bold1" width="100"><div align="left">Action</div></td> -->
						<td class="bold1" width="150">
						<div align="center">Print</div>
						</td>
					</tr>
				</table>
				</div>
				</td>
			</tr>
			<tr>
				<td height="107" valign="top" class="footermenu">
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
						<div id="divscroll" style="OVERFLOW:auto;width:900px;height:130px"
							class="boldEleven">
						<div id="QuotationTable"></div>
						</div>
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
				<div align="center"><a href="javascript:loadSalesOrder('0')">All</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadSalesOrder('A')">A</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadSalesOrder('B')">B</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadSalesOrder('C')">C</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadSalesOrder('D')">D</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadSalesOrder('E')">E</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadSalesOrder('F')">F</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadSalesOrder('G')">G</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadSalesOrder('H')">H</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadSalesOrder('I')">I</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadSalesOrder('J')">J</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadSalesOrder('K')">K</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadSalesOrder('L')">L</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadSalesOrder('M')">M</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadSalesOrder('N')">N</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadSalesOrder('O')">O</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadSalesOrder('P')">P</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadSalesOrder('Q')">Q</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadSalesOrder('R')">R</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadSalesOrder('S')">S</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadSalesOrder('T')">T</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadSalesOrder('U')">U</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadSalesOrder('V')">V</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadSalesOrder('W')">W</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadSalesOrder('X')">X</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadSalesOrder('Y')">Y</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadSalesOrder('Z')">Z</a></div>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td></td>
	</tr>
	<tr>
		<td>
		<table width="111" border="0" align="center" cellpadding="1"
			cellspacing="1">
			<!--DWLayoutTable-->
			<tr align="center">
				<!--     <td width="51"><input type="button" class="buttonbold13" name="view"  value="Print" onMouseOver="return Delete()" onClick="SalesOrderPrint()" /></td> -->
				<td width="53"><input type="button" class="buttonbold13"
					name="submit"  value="Close"   accesskey="c" 
					onClick="redirect('../InventoryMain.jsp')" /></td>
			</tr>
		</table>
		</td>
	</tr>

</table>
<%@ include file="../../footer.jsp"%></form>
</body>
</html>
