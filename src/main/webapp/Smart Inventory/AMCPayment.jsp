<%@ page import="java.io.*,java.util.*" errorPage="../error/index.jsp"%>
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
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="javascript"
	src="../JavaScript/Inventory/InventAJAX.js"></script>
<script language="JavaScript">
	function getDBPath()
	{
		var pathname = window.location.pathname;
		var iPos = window.location.pathname.toString().toLowerCase().lastIndexOf('.nsf');
		if(iPos>0) return pathname.substring(0, iPos+4);
		alert(pathname);
		return pathname; 
	} 

    function Add()
	{ 
		document.frm.action="AMCPaymentAdd.jsp";		
 	}

	function Edit()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].salesid
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
			if (document.forms[0].salesid.checked) { count=1;}
		}
		if(count==1){			
			document.frm.action="AMCPaymentEdit.jsp";
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
		coffee1=document.forms[0].salesid;
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
			if (document.forms[0].salesid.checked) { count=1;}
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

<body    onLoad="AMCPayment('0')">
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
		<table height="227" border="0" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"  
			 >
			<tr >
				<td height="31" >
				<div align="center"><span class="boldThirteen"> Payment
				Details </span></div>
				</td>
			</tr>
			<tr >
				<td height="31" align="center" >
				<table border="0" align="center" cellpadding="3" cellspacing="3" class="whiteMedium">
					<tr>
						<td class="boldThirteen">Payment</td>
						<td><select name="payType" id="payType"
							onBlur="AMCPayment('0')">

							<option value="Invoice">AMC Payment</option>
							<option value="CashPay">Service Payment</option>
						</select></td>
						<td height="28"><span class="boldThirteen">&nbsp;Month</span></td>
						<td><span class="boldThirteen"> <select name="month"
							id="month" onBlur="AMCPayment('0')">
							<%@ include file="../JavaScript/Inventory/month.jsp"%>
						</select> </span></td>
						<td><span class="boldThirteen">Year</span></td>
						<td><span class="boldThirteen"> <select name="year"
							id="year" onBlur="AMCPayment('0')">
							<%@ include file="../JavaScript/Inventory/year.jsp"%>
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
			<tr >
				<td height="31" >
				<div align="center">
				<table width="100%"
					cellpadding="0" cellspacing="0" class="whiteMedium">
					<tr >
						<td   width="114">
						<div align="center">AMC/Service -ID</div>
						</td>
						<td   width="101">
						<div align="center">Date</div>
						</td>
						<td   width="151">
						<div align="center">Customer Name</div>
						</td>
						<td   width="117">
						<div align="center">Total Amount</div>
						</td>
						<td   width="88">
						<div align="center">Paid Amount</div>
						</td>
						<td   width="132">
						<div align="center">Balance Amount</div>
						</td>
						<td   width="51">
						<div align="center">Status</div>
						</td>
					</tr>
				</table>
				</div>
				</td>
			</tr>
			<tr class="MRow1">
				<td height="127" valign="top" class="footermenu">
				
				<div id="PaymentTable"></div>
				<br>
				<div align="center" id="totRec"></div>
				<br>
				 
				</td>
		  </tr>

		</table>
		</td>
	</tr>
	<tr>
	  <td height="20"><input name="filename" type="hidden" value="AMCPayment" /> <input
			name="actionS" type="hidden" value="INVAMCPaymentDelete" /></td>
	</tr>
	<tr>
		<td>
		<table border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
			<tr class="para">
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:AMCPayment('0')">All</a></div>
				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:AMCPayment('A')">A</a></div>
				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:AMCPayment('B')">B</a></div>
				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:AMCPayment('C')">C</a></div>
				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:AMCPayment('D')">D</a></div>
				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:AMCPayment('E')">E</a></div>
				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:AMCPayment('F')">F</a></div>
				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:AMCPayment('G')">G</a></div>
				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:AMCPayment('H')">H</a></div>
				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:AMCPayment('I')">I</a></div>
				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:AMCPayment('J')">J</a></div>
				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:AMCPayment('K')">K</a></div>
				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:AMCPayment('L')">L</a></div>
				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:AMCPayment('M')">M</a></div>
				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:AMCPayment('N')">N</a></div>
				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:AMCPayment('O')">O</a></div>
				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:AMCPayment('P')">P</a></div>
				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:AMCPayment('Q')">Q</a></div>
				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:AMCPayment('R')">R</a></div>
				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:AMCPayment('S')">S</a></div>
				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:AMCPayment('T')">T</a></div>
				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:AMCPayment('U')">U</a></div>
				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:AMCPayment('V')">V</a></div>
				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:AMCPayment('W')">W</a></div>
				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:AMCPayment('X')">X</a></div>
				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:AMCPayment('Y')">Y</a></div>
				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:AMCPayment('Z')">Z</a></div>
				</td>
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
	<tr>
		<td>
		<table width="224" border="0" align="center" cellpadding="1"
			cellspacing="1">
			<!--DWLayoutTable-->
			<tr>
				<td width="56" valign="top"><input type="submit"
					class="ButtonHead" name="action1"  value="Add"   accesskey="s"   onClick="Add()" /></td>
				<td width="56" valign="top"><input type="submit"
					class="ButtonHead" name="action12" id="btnEdit" value="Edit"
					onClick="return Edit()" /></td>

				<%
	  String usertype=""+session.getAttribute("USRTYPE");
	  if("F".equals(usertype))
	  {
	  %>
				<td width="56" valign="top"><input type="submit"
					class="ButtonHead" name="Submit3" id="btnDelete" value="Delete"
					onclick="return Delete()" /></td>
				<%
		}
		else
		{
			out.println("<input type='hidden' id='btnDelete'>");
		}
		%>

				<td width="56"><input type="button" class="ButtonHead"
					name="submit"  value="Close"   accesskey="c"  onClick="redirect( 'InventoryMains.jsp')" /></td>
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
<%@ include file="../footer.jsp"%></form>
</body>
</html>
