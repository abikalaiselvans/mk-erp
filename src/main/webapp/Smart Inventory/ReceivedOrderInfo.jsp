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

<script language="javascript"
	src="../JavaScript/Inventory/InventAJAX.js"></script>

<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript">

    function Add()
	{ 
		document.frm.action="PurchaseOrderAdd.jsp";
 	}
 	
	function order()
	{ 
	
		document.frm.action="ReceiveOrder.jsp?id=1";
 	}
	
	function Edit()
 	{		
		
		/*
		var count;
		count=0;
		alert("");
		coffee1=document.forms[0].ponumber;
		txt=""
		for (i=0;i<frm.length;++ i)
		{
			if (frm[i].checked)
			{
			count=count+1;
			}
		}
		if(count==0)
		{
			if (document.forms[0].ponumber.checked) { count=1;}
		}
		if(count==1){			
			document.frm.action="CustomerInfoEdit.jsp";
			return true;
		}
		else
		{
		    alert("Select Only one Value");
		    return false;
		}
		*/
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

<body >
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
		<table width="900" height="227" border="1" align="center"
			cellpadding="1" cellspacing="1"  >
			<tr class="BackGround">
				<td height="31" class="BackGround">
				<div align="center" class="boldThirteen">Goods Received
				Informations</div>
				</td>
			</tr>
			<tr class="BackGround">
				<td height="31" class="BackGround">
				<table width="28%" border="0" align="center" cellpadding="1"
					cellspacing="1" class="boldEleven">
					<tr>
						<td>Month ::</td>
						<td><span class="boldThirteen"> <select name="month"
							id="month" onBlur="loadPurchase('0')">
							<%@ include file="../JavaScript/Inventory/month.jsp"%>
						</select> </span></td>
						<td><span class="boldThirteen">Year ::</span></td>
						<td><span class="boldThirteen"> <select name="year"
							id="year" onBlur="loadPurchase('0')">
							<%@ include file="../JavaScript/Inventory/year.jsp"%>
						</select> </span></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td class="BackGround">
				<div align="center">
				<table width="900" border="0" cellspacing="1" cellpadding="1">
					<tr>
						<td width="220" class="bold1">
						<div align="left">Ref.No</div>
						</td>
						<td width="130" class="bold1">
						<div align="left">OrderDate</div>
						</td>
						<td width="130" class="bold1">
						<div align="left">Vendor</div>
						</td>
						<td width="130" class="bold1">
						<div align="left">OrderFrom</div>
						</td>
						<td width="130" class="bold1">
						<div align="left">ShippingTo</div>
						</td>
						<td width="60" class="bold1">
						<div align="left">onHold</div>
						</td>
						<td width="60" class="bold1">
						<div align="left">Status</div>
						</td>
						<td width="60" class="bold1">
						<div align="left">Payment</div>
						</td>
					</tr>
				</table>
				</div>
				</td>
			</tr>
			<tr>
				<td class="bold1"></td>
			</tr>

			<tr>
				<td height="127" valign="top" class="footermenu">
				<table>
					<tr>
						<td class="bolddeepblue" align="center"></td>
					</tr>
					<tr>
						<td class="bolddeepblue" align="center" bgcolor="#efefef"></td>
					</tr>
					<tr>
						<td>

						<div id="PurchaseTable"
							style="OVERFLOW:auto;width:920px;height:130px" class="boldEleven"></div>

						</td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td class="bolddeepblue">
						<div align="center" id="totRec"></div>
						</td>
					</tr>
					<tr>
						<td></td>
					</tr>

				</table>
				</td>
			</tr>

		</table>
		</td>
	</tr>
	<tr>
		<td></td>
	</tr>
	<tr>
		<td>
		<table width="900" border="0" align="center" cellpadding="1"
			cellspacing="1"  >
			<tr class="para">
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadPurchase('')">All</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadPurchase('A')">A</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadPurchase('B')">B</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadPurchase('C')">C</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadPurchase('D')">D</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadPurchase('E')">E</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadPurchase('F')">F</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadPurchase('G')">G</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadPurchase('H')">H</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadPurchase('I')">I</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadPurchase('J')">J</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadPurchase('K')">K</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadPurchase('L')">L</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadPurchase('M')">M</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadPurchase('N')">N</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadPurchase('O')">O</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadPurchase('P')">P</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadPurchase('Q')">Q</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadPurchase('R')">R</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadPurchase('S')">S</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadPurchase('T')">T</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadPurchase('U')">U</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadPurchase('V')">V</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadPurchase('W')">W</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadPurchase('X')">X</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadPurchase('Y')">Y</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadPurchase('Z')">Z</a></div>
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
					class="buttonbold"  value="Add"   accesskey="s"   /></td>
				<td width="56" valign="top"><input type="button" id="Edit"
					class="buttonbold" value="Edit" onclick="return Edit()" /></td>
				<td width="56" valign="top"><input type="submit" name="Receive"
					class="buttonbold" onClick="order()" value="Receive" /></td>
				<td width="56" valign="top"><input name="Delete" type="submit"
					class="buttonbold" id="Delete" onclick="return Delete()"
					value="Delete" /></td>
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
