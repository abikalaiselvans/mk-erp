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
	src="../../JavaScript/Inventory/ReportDirect.js"></script>
<script language="JavaScript">
function SalesOrderPrint(query1)
{	
			var width="800", height="400";
			var left = (screen.width/2) - width/2;
			var top = (screen.height/2) - height/2;
			var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbar=yes,resizable=yes,copyhistory=yes,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
	
			var f ="DirectSalePrint_Report.jsp?itemId="+query1;
			newWindow = window.open(f,"subWind",styleStr);
			newWindow.focus( );
}

function mainPage()
{
      document.frm.action="../InventoryMain.jsp";
}
 </script>

<body    onLoad="loadDirectSales('0')">
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
				<div align="center"><span class="boldThirteen">Direct
				Sales </span></div>
				</td>
			</tr>
			<tr class="BackGround">
				<td class="BackGround">
				<table width="311" border="0" align="center" cellpadding="0"
					cellspacing="2">
					<tr>
						<td width="87" class="boldThirteen">Month ::</td>
						<td width="76"><select name="month" id="month"
							onChange="loadDirectSales('0')">
							<%@ include file="../../JavaScript/Inventory/month.jsp"%>
						</select></td>
						<td width="50" class="boldThirteen">Year ::</td>
						<td width="88"><select name="year" id="year"
							onChange="loadDirectSales('0')">
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
          </script></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr class="BackGround">
				<td height="31" class="BackGround">
				<div align="center">
				<table width="100%" border="1" cellspacing="1" cellpadding="1">
					<tr class="BackGround">
						<td class="bold1" width="120">
						<div align="center">Ref No</div>
						</td>
						<td class="bold1" width="99">
						<div align="center">Date</div>
						</td>
						<td class="bold1" width="263">
						<div align="center">Customer Name</div>
						</td>
						<td class="bold1" width="140">
						<div align="center">Total Amount</div>
						</td>
						<td class="bold1" width="158">
						<div align="center">Print View</div>
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
						<div id="divscroll" style="OVERFLOW:auto;width:800px;height:130px"
							class="boldEleven">
						<div id="DirectSalesTable"></div>
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
		<td>
		<table width="800" border="0" align="center" cellpadding="1"
			cellspacing="1"  >
			<tr class="para">
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadDirectSales('0')">All</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadDirectSales('A')">A</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadDirectSales('B')">B</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadDirectSales('C')">C</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadDirectSales('D')">D</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadDirectSales('E')">E</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadDirectSales('F')">F</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadDirectSales('G')">G</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadDirectSales('H')">H</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadDirectSales('I')">I</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadDirectSales('J')">J</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadDirectSales('K')">K</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadDirectSales('L')">L</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadDirectSales('M')">M</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadDirectSales('N')">N</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadDirectSales('O')">O</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadDirectSales('P')">P</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadDirectSales('Q')">Q</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadDirectSales('R')">R</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadDirectSales('S')">S</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadDirectSales('T')">T</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadDirectSales('U')">U</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadDirectSales('V')">V</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadDirectSales('W')">W</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadDirectSales('X')">X</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadDirectSales('Y')">Y</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadDirectSales('Z')">Z</a></div>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td><input name="filename" type="hidden" value="DirectSale" /> <input
			name="actionS" type="hidden" value="INVDirectSaleDelete" /></td>
	</tr>
	<tr>
		<td>
		<table border="0" align="center" cellpadding="3" cellspacing="3">
			<!--DWLayoutTable-->
			<tr>
				<td width="56"><input type="submit" class="buttonbold13"
					name="submits"  value="Close"   accesskey="c"  onClick="redirect( 'InventoryMains.jsp')" /></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<%@ include file="../../footer.jsp"%></form>
</body>
</html>
