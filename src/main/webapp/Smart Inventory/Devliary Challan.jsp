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
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="javascript" src="../JavaScript/Inventory/InvenAJAX.js"></script>
<script language="JavaScript">

    function Add()
	{ 
		document.frm.action="QuotationAction.jsp";
 	}

	function Edit()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].optcatid
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
			if (document.forms[0].optcatid.checked) { count=1;}
		}
		if(count==1){			
			document.frm.action="CategoryMaster.jsp";
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
		coffee1=document.forms[0].optcatid
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
			if (document.forms[0].optcatid.checked) { count=1;}
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
 	

 	function PageBack()
	{
	     //future enhancement
    }
 	
  function Validate()
  {
    /*
	if(checkNull("fromdt","Enter From Date") && checkNull("todt","Enter To Date") && checkDate("fromdt","todt"))
		return true;
	else
		return false;	
	*/	
  } 
 	
</script>

<body    onload="loadQuotation()">
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
		<table width="800" height="200" border="1" align="center"
			cellpadding="1" cellspacing="1"  >
			<tr class="BackGround">
				<td height="31" class="BackGround">
				<div align="center" class="boldThirteen">Quotation Details
				&nbsp;&nbsp;&nbsp;Month :: <select name="month" id="month"
					onblur="loadQuotation()">
					<option value="01">January</option>
				</select> &nbsp;&nbsp;&nbsp;Year :: <select name="year" id="year"
					onblur="loadQuotation()">
					<option value="2007">2007</option>
					<option value="2008">2008</option>
				</select></div>
				</td>
			</tr>
			<tr class="BackGround">
				<td height="31" class="BackGround">
				<div align="center">
				<table width="100%" border="1" cellspacing="1" cellpadding="1">
					<tr class="BackGround">
						<td class="bold1" width="50">
						<div align="center">Quo No</div>
						</td>
						<td class="bold1" width="70">
						<div align="center">Date</div>
						</td>
						<td class="bold1" width="170">
						<div align="center">Customer Name</div>
						</td>
						<td class="bold1" width="70">
						<div align="center">Req Date</div>
						</td>
						<td class="bold1" width="60">
						<div align="center">On Hold</div>
						</td>
						<td class="bold1" width="70">
						<div align="center">Quo Status</div>
						</td>
						<td class="bold1" width="100">
						<div align="center">Credit</div>
						</td>
						<td class="bold1" width="100">
						<div align="center">Total Amount</div>
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
		<table width="600" border="0" align="center" cellpadding="1"
			cellspacing="1"  >
			<tr class="para">
				<td class="boldEleven">
				<div align="center"><a href="Quotation.jsp?startLetter=Al">All</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="Quotation.jsp?startLetter=A">A</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="Quotation.jsp?startLetter=B">B</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="Quotation.jsp?startLetter=C">C</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="Quotation.jsp?startLetter=D">D</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="Quotation.jsp?startLetter=E">E</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="Quotation.jsp?startLetter=F">F</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="Quotation.jsp?startLetter=G">G</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="Quotation.jsp?startLetter=H">H</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="Quotation.jsp?startLetter=I">I</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="Quotation.jsp?startLetter=J">J</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="Quotation.jsp?startLetter=K">K</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="Quotation.jsp?startLetter=L">L</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="Quotation.jsp?startLetter=M">M</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="Quotation.jsp?startLetter=N">N</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="Quotation.jsp?startLetter=O">O</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="Quotation.jsp?startLetter=P">P</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="Quotation.jsp?startLetter=Q">Q</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="Quotation.jsp?startLetter=R">R</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="Quotation.jsp?startLetter=S">S</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="Quotation.jsp?startLetter=T">T</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="Quotation.jsp?startLetter=U">U</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="Quotation.jsp?startLetter=V">V</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="Quotation.jsp?startLetter=W">W</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="Quotation.jsp?startLetter=X">X</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="Quotation.jsp?startLetter=Y">Y</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="Quotation.jsp?startLetter=Z">Z</a></div>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td><input type="hidden" name="filename" /> <input type="hidden"
			name="actionS" /></td>
	</tr>
	<tr>
		<td>
		<table width="224" border="0" align="center" cellpadding="1"
			cellspacing="1">
			<!--DWLayoutTable-->
			<tr>
				<td width="56" valign="top"><input type="submit"
					class="buttonbold" name="action1"  value="Add"   accesskey="s"   onclick="Add()" /></td>
				<td width="56" valign="top"><input type="submit"
					class="buttonbold" name="action12" id="btnEdit" value="Edit"
					onclick="return Edit()" /></td>
				<td width="56" valign="top"><input type="submit"
					class="buttonbold" name="Submit3" id="btnDelete" value="Delete"
					onclick="return Delete()" /></td>
				<td width="56"><input type="submit" class="buttonbold"
					name="submit"  value="Close"   accesskey="c"  onClick="javascript:history.back()" /></td>
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
