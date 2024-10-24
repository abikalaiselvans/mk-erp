<%@ page import="java.lang.*,java.util.*,java.io.*"%>
<%!
	String supplierId,supplierName;
%>
<%@ page import="com.my.org.erp.SmartInventory.Supplier"%>
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

<script language="JavaScript">
  function Delete()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].OptSupplierName
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
			if (document.forms[0].OptSupplierName.checked) { count=1;}
		}
		if(count>=1){			
			var name=confirm("Confirm to Delete")
			if (name==true)
			{ 
				document.supplier.action="../SmartLoginAuth";
				// document.supplier.submit();
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
	function Add()
	{ 
		document.supplier.action="SupplierAction.jsp";
		// document.supplier.submit();
 	}
	function Edit()
	{  
	  var count=0;
	  sel=document.forms[0].OptSupplierName
	  for(i=0;i<sel.length;i++)
	  {
	    if(sel[i].checked)
	    count=count+1;
	  }
	  if(count==0)
	  {
	   if(document.forms[0].OptSupplierName.checked)
	   {
	    count=1;
		}
	  }
	  if(count==0)
	  {
	  alert("Select the Record to Edit");
	  return false;
	  }
	  if(count==1)
	  {
		document.supplier.action="SupplierAction.jsp";
		// document.supplier.submit();
 	  return true;
	  }
	  else
	  {
	   alert("Select only one Record to Edit");
	   return false;
	   }
	   }
	    function mainPage()
	{
	     document.supplier.action="InventoryMain.jsp";
	    // frm.submit();
    }
	   
</script>
</head>
<body     >
<form  AUTOCOMPLETE = "off"   name="supplier" action="../SmartLoginAuth">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td><%@ include file="indexinv.jsp"%></td>
	</tr>
	<tr>
		<td height="83">&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table width="400" border="1" align="center"  >
			<!--DWLayoutTable-->
			<tr>
				<td width="400" height="154" align="left" valign="top">
				<table width="101%" align="center" border="0">
					<!--DWLayoutTable-->
					<tr>
						<td width="363" height="27" align="center" valign="middle"
							class="tableheadInv">Supplier</td>
					</tr>
				</table>
				<div id="divscroll" style="OVERFLOW:auto;width:400px;height:120px"
					class="sbarclr">
				<table width="100%" align="center" cellpadding="0" cellspacing="0"
					  border="0"  >
					<%
			ArrayList supplierList=(ArrayList) session.getAttribute("supplierList");
			String bgcolor1="#ccccc";
			boolean bgflag=false;
			for(int i=0;i<supplierList.size();i++)
			{
				Supplier supplier= (Supplier)supplierList.get(i);
				if(bgflag)
				{
					bgflag = false;
					bgcolor1="#FFFFFF";
				}
				else
				{
					bgflag = true;
					bgcolor1="#EEFFEE";
				}
				out.println("<tr bgcolor='"+bgcolor1+"' class='tabledata'>");				
				%>

					<td valign="middle" class="bolddeepblue"><input
						type="checkbox" name="OptSupplierName"
						value='<%=supplier.getSupplierId()%>'> <%=supplier.getSupplierId()%></td>
					<td class="bolddeepblue"><%=supplier.getSupplierName()%></td>
					<%					
			}
			String dis="";
			if(supplierList.size()==0) dis="disabled='disabled'";		
			supplierId=request.getParameter("supplierId");			
			%>
					</tr>
				</table>
				</td>
			</tr>
		</table>

		</td>
	</tr>
	<tr>
		<td><input type="hidden" name="filename" value="Supplier">
		<input type="hidden" name="actionS" value="INVsupplierDelete">

		</td>
	</tr>
	<tr>
		<td>
		<table border="0" align="center" cellpadding="1" cellspacing="1">
			<!--DWLayoutTable-->
			<tr>
				<td width="56"><input type="submit" class="buttonbold"
					name="action1"  value="Add"   accesskey="s"   onClick=Add()></td>
				<td width="56"><input type="submit" class="buttonbold" <%=dis%>
					name="action1" value="Edit" onClick="return Edit()"></td>
				<td width="56"><input name="submit" type="submit"
					class="buttonbold" onClick="return Delete()" value="Delete"
					<%=dis%>></td>
				<td width="56"><input type="submit" name="close"
					class="buttonbold"  value="Close"   accesskey="c"  onClick="redirect( 'InventoryMains.jsp')"></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td height="115">&nbsp;</td>
	</tr>
	<tr>
		<td><%@ include file="../footer.jsp"%></td>
	</tr>
</table>

</form>
</body>
</html>
