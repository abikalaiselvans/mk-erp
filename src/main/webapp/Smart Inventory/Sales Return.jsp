<%@ page import="java.io.*,java.util.*" isErrorPage="false"	errorPage="../error/error.jsp"%>
<%
try
{
%>
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
<script language="javascript" src="../JavaScript/comfunction.js"></script>
 <script language="javascript"	src="../JavaScript/Inventory/SalesReturn.js"></script>
<script language="JavaScript">

    function Add()
	{ 
		document.frm.action="SalesReturn.jsp";
 	}
	function Edit()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].itemId
		txt=""
		for (i=0;i<coffee1.length;++ i)
		{
			if (coffee1[i].checked)
			{
			count=count+1;
			}
		}
		if(count==0)
		{
			if (document.forms[0].itemId.checked) { count=1;}
		}
		if(count==1){			
			document.frm.action="SalesPaymentAction.jsp";
			return true;
		}
		else
		{
		    alert("Select Only one Value");
		    return false;
		}
 	}
 	function Delete()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].itemId
		txt=""
		for (i=0;i<coffee1.length;++ i)
		{
			if (coffee1[i].checked)
			{
			count=count+1;
			}
		}
		if(count==0)
		{
			if (document.forms[0].itemId.checked) { count=1;}
		}
		if(count>=1){			
			var name=confirm("Confirm to Delete")
			if (name==true)
			{ 
				document.frm.action="../SmartLoginAuth";
				return true;			
			}
			else
				return false;
		}
		else
		{
		    alert("Select Atleast One Value");
		    return false;
		}		
 	} 	
</script>
<body    onLoad="loadSalesReturn('0')">
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
		<table width="800" height="196" border="0" align="center"
			cellpadding="3" cellspacing="3" class="TableDesign"  
			 >
			<tr  >
				<td  >
				<div align="center"><span  >SALES RETURN </span></div>				</td>
			</tr>
			<tr  >
				<td align="center"  >
				<table width="745" border="0" align="center" cellpadding="0"
					cellspacing="0" class="whiteMedium">
					<tr>
						<td width="126" class="whiteMedium"  >Sales Return </td>
						<td width="116"><select name="returnType" id="returnType"
							onBlur="loadSalesReturn('0')">
							<option value="Invoice">Invoice Sale</option>
							<!--<option Value="Cash"> Cash Sale </option>-->
							<option value="Direct">Direct Sale</option>
						</select></td>
						<td width="97"  >Month </td>
						<td width="102"><select name="month" id="month"
							onBlur="loadSalesReturn('0')">
							<%@ include file="../JavaScript/Inventory/month.jsp"%>
						</select></td>
						<td width="74"  >Year </td>
						<td width="80"><select name="year" id="year"
							onBlur="loadSalesReturn('0')">
							<%@ include file="../JavaScript/Inventory/year.jsp"%>
						</select></td>
						<td width="84"><script language='JavaScript'
							type="text/javascript">
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
				</table>				</td>
			</tr>
			<tr  >
				<td height="31"  >
				<div align="center">
				<table width="100%" border="0" cellpadding="1" cellspacing="1" class="whiteMedium">
					<tr  >
						<td   width="98">
						<div align="center">Sale.No</div>						</td>
						<td   width="134">
						<div align="center">Sale Date</div>						</td>
						<td   width="136">
						<div align="center">Customer Name</div>						</td>
						<td   width="94">
						<div align="center">Return Status</div>						</td>
						<td   width="101">
						<div align="center">Action</div>						</td>
					</tr>
				</table>
				</div>				</td>
			</tr>
			<tr class="MRow1">
				<td height="89" valign="top" class="footermenu">
				 
						<div id="ReturnTable" style="OVERFLOW:auto;width:100%;height:250px"  >	</div>
						<br>
						<div id="totRec"></div>
						
				<br>						 		</td>
			</tr>
		</table>		</td>
	</tr>
	<tr>
	  <td>&nbsp;</td>
    </tr>
	<tr>
		<td>
		<table border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
			<tr class="para">
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadSalesReturn('0')">All</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadSalesReturn('A')">A</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadSalesReturn('B')">B</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadSalesReturn('C')">C</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadSalesReturn('D')">D</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadSalesReturn('E')">E</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadSalesReturn('F')">F</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadSalesReturn('G')">G</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadSalesReturn('H')">H</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadSalesReturn('I')">I</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadSalesReturn('J')">J</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadSalesReturn('K')">K</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadSalesReturn('L')">L</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadSalesReturn('M')">M</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadSalesReturn('N')">N</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadSalesReturn('O')">O</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadSalesReturn('P')">P</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadSalesReturn('Q')">Q</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadSalesReturn('R')">R</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadSalesReturn('S')">S</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadSalesReturn('T')">T</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadSalesReturn('U')">U</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadSalesReturn('V')">V</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadSalesReturn('W')">W</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadSalesReturn('X')">X</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadSalesReturn('Y')">Y</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadSalesReturn('Z')">Z</a></div>				</td>
			</tr>
		</table>		</td>
	</tr>
	<tr>
		<td><input type="hidden" name="filename" /> <input type="hidden"
			name="actionS" /></td>
	</tr>
	<tr>
		<td>
		<table width="119" border="0" align="center" cellpadding="1"
			cellspacing="1">
			<!--DWLayoutTable-->
			<tr>
				<td width="56" valign="top"><input type="submit"
					class="ButtonHead" name="action1"  value="Add"   accesskey="s"   onClick="Add()" /></td>
				<td width="56"><input type="button" class="ButtonHead"
					name="submit"  value="Close"   accesskey="c"  onClick="redirect( 'InventoryMains.jsp')" /></td>
			</tr>
		</table>		</td>
	</tr>
	<tr>
		<td height="41">&nbsp;</td>
	</tr>
</table>
<%@ include file="../footer.jsp"%></form>
</body>
</html>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
	System.out.println(e.getMessage());
}
%>