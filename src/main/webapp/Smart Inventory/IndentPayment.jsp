<%@ page import="java.io.*,java.util.*" isErrorPage="false" errorPage="../error/error.jsp"%>
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
<script language="javascript" src="../JavaScript/Inventory/IndentPayment.js"></script>
<script language="JavaScript">
    function PAdd()
	{ 
		document.frm.action="IndentPaymentAdd.jsp";
 	}

	function PaymentEdit()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].pid
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
			if (document.forms[0].pid.checked) { count=1;}
		}
		if(count==1){			
			document.frm.action="Indentpaymentdetails.jsp";
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
		coffee1=document.forms[0].pid
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
			if (document.forms[0].pid.checked) { count=1;}
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
<body    onLoad="LoadIndentPayment('0')">
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
		<table width="900" height="257" border="0" align="center"
			cellpadding="0" cellspacing="0"  
			 >
			<tr class="BackGround">
				<td width="843" height="31" class="BackGround">
				<div align="center"><span class="boldThirteen">Purchase
				Indent Payment Details</span>
				  <input name="payment" type="hidden" id="payment" value="IndentPayment">
				</div>
				</td>
			</tr>
			<tr class="BackGround">
				<td height="27" class="BackGround">
				<table width="420" border="0" align="center" cellpadding="0"
					cellspacing="0">
					<tr>
						<td class="boldEleven"><strong class="boldThirteen">Vendors</strong></td>
						<td>
						<select name="vendorid" class="formText135" id="vendorid" onChange="LoadIndentPayment('0')">
						<option value=0>All</option>
						<%
						String vendordata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_VENDORID,CHR_VENDORNAME FROM  inv_m_vendorsinformation  ORDER BY CHR_VENDORNAME");
								for(int u=0; u<vendordata.length; u++)
									out.print("<option value='"+vendordata[u][0]+"'>"+vendordata[u][1]  +"</option>");
						%>			
						</select>						</td>
						<td><span class="boldThirteen">Status</span></td>
						<td><span class="boldThirteen"> <select name="Status"
							id="Status" onChange="LoadIndentPayment('0')">
							<option value=0>All</option>
							<option value=1>Pending</option>
							<option value=2>completed</option>
						</select> </span></td>
						<td>
						<a title="Excel" href=javascript:;
			onClick=" CreateExcelSheet()"><img
			src="../Image/report/Excel.png" width="15" height="14" border="0"></a>						</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr class="BackGround">
				<td height="31" class="BackGround">
				<div align="center">
				<table width="100%" border="0" cellspacing="1" cellpadding="1">
					<tr class="BackGround">
						<td class="bold1" width="135">
						<div align="center">Purchase Indent</div>
						</td>
						<td class="bold1" width="120">
						<div align="center">Vendor Name</div>
						</td>
						<td class="bold1" width="110">
						<div align="center">Total Amount</div>
						</td>
						<td class="bold1" width="85">
						<div align="center">Paid Amount</div>
						</td>
						<td class="bold1" width="123">
						<div align="center">Balance Amount</div>
						</td>
						<td class="bold1" width="127">
						<div align="center">Status</div>
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
						<div id="divscroll" style="OVERFLOW:auto;width:100%;height:130px"
							class="boldEleven">
						<div id="PaymentTable"></div>
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
		<table width="900" border="0" align="center" cellpadding="1"
			cellspacing="1"  >
			<tr class="para">
				<td class="boldEleven">
				<div align="center"><a href="javascript:LoadIndentPayment('')">All</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:LoadIndentPayment('A')">A</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:LoadIndentPayment('B')">B</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:LoadIndentPayment('C')">C</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:LoadIndentPayment('D')">D</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:LoadIndentPayment('E')">E</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:LoadIndentPayment('F')">F</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:LoadIndentPayment('G')">G</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:LoadIndentPayment('H')">H</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:LoadIndentPayment('I')">I</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:LoadIndentPayment('J')">J</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:LoadIndentPayment('K')">K</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:LoadIndentPayment('L')">L</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:LoadIndentPayment('M')">M</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:LoadIndentPayment('N')">N</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:LoadIndentPayment('O')">O</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:LoadIndentPayment('P')">P</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:LoadIndentPayment('Q')">Q</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:LoadIndentPayment('R')">R</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:LoadIndentPayment('S')">S</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:LoadIndentPayment('T')">T</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:LoadIndentPayment('U')">U</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:LoadIndentPayment('V')">V</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:LoadIndentPayment('W')">W</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:LoadIndentPayment('X')">X</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:LoadIndentPayment('Y')">Y</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:LoadIndentPayment('Z')">Z</a></div>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td><input name="filename" type="hidden" value="PurchaseIndent" />
		<input name="actionS" type="hidden" value="INVPurchaseIndentPaymentDelete" /></td>
	</tr>
	<tr>
		<td>
		<table width="178" border="0" align="center" cellpadding="1"
			cellspacing="1">
			<!--DWLayoutTable-->
			<tr>
				<td width="56" valign="top"><input type="submit"
					class="buttonbold13" name="action1"  value="Add"   accesskey="s"   onClick="PAdd()" /></td>
				<td width="56" valign="top"><input type="submit"
					class="buttonbold13" name="Edit" id="Edit" value="Edit"
					onclick="PaymentEdit()" /></td>
					 
					<%
	  String usertype=""+session.getAttribute("USRTYPE");
	  if("F".equals(usertype))
	  {
	  %>
            <td width="56"><input type="submit" class="buttonbold13"
					name="Submit3" id="btnDelete" value="Delete"
					onClick="return Delete()" /></td>
            <%
		}
		else
		{
			out.println("<input type='hidden' id='btnDelete'>");
		}
		%>
		 
				<td width="56"><input type="button" class="buttonbold13"
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
