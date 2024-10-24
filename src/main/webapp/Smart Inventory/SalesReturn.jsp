<%@ page import="java.io.*,java.util.*"%>
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
 <style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
 </style>
</head>
<script language="javascript" src="../JavaScript/Inventory/InventAJAX.js"></script>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript"	src="../JavaScript/Inventory/SalesReturn.js"></script>
<script language="JavaScript">

    function Add()
	{ 
		document.frm.action="CategoryMaster.jsp";
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
    
		var count=0;
		coffee1=document.forms[0].rowid;
		for (i=0;i<coffee1.length;++ i)
			if (coffee1[i].checked)
				count=count+1;
		if(count==0)
			if (document.forms[0].rowid.checked)
				count=1;
	
		if(count>=1)
		{
			 
				return true;
			 
		}
		else
		{
		    alert("Select Only one Value");
		    return false;
		}
  } 
 	
	
</script>

<body    onLoad="LoadSaleNumber(),buttonDisable('Submit')">
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth" onSubmit="return Validate()">
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
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="424"
			align="center" border="0">
			<tbody>
				<tr>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/Smart Inventory/TLCorner.gif" width="7" /></td>
					<td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/Smart Inventory/TRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
				</tr>
				<tr>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
					<td width="6"><spacer height="1" width="1" type="block" /></td>
					<td width="412">
					<table width="663" border="0" align="center" cellpadding="1"
						cellspacing="1">
						<tr>
							<td width="650"></td>
						</tr>
						<tr>
							<td align="center" class="bolddeeplogin">
							<div align="center">SALES RETURN </div>
							</td>
						</tr>
						<tr>
							<td>
							<table width="100%" border="0" align="center" cellpadding="2"
								cellspacing="2">
								 
								<tr>
									<td>
									<table width="100%" border="0">
										<tr>
											<td class="boldEleven">Month</td>
											<td class="boldEleven"><select name="month" id="month"
												onBlur="LoadSaleNumber()" style="width:120">
												<%@ include file="../JavaScript/Inventory/month.jsp"%>
											</select></td>
											<td class="boldEleven">Year</td>
											<td class="boldEleven"><select name="year" id="year"
												onBlur="LoadSaleNumber()"  style="width:120">
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
                    </script></td>
											<td class="boldEleven">Return</td>
											<td class="boldEleven"><select name="returnType"
												id="returnType" onBlur="LoadSaleNumber()"  style="width:120">
												<option value="Invoice" selected>Invoice Sale</option>
												<option value="Direct">Direct Sale</option>
											</select></td>
											<td class="boldEleven">Sale Number</td>
											<td class="boldEleven"><select name="saleno" id="saleno"
												onBlur="LoadSaleNumberItems()"  style="width:200">
												<option>Select</option>
												<%
					  	
						/*String sql ="SELECT CHR_SALESORDERNO,CHR_DELIVERYNO,CHR_INVOICENO from  inv_t_customersalesorder  ";
						//System.out.print(sql);

						String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
						for(int u=0;u<data.length;u++)
						{
							out.print("<option value='"+data[u][0]+"' >" +data[u][0] +"</option>");
						}*/
					  
					  %>
											</select></td>
										</tr>
									</table>
									</td>
								</tr>
							</table>
							</td>
						</tr>
						 
						<tr>
							<td>

							<div id="ReturnTable"
								style="OVERFLOW:auto;width:800px;height:300px"
								class="boldEleven"></div>
							</td>
						</tr>
						<tr>
							<td><input name="filename" type="hidden" id="filename"
								value="SalesReturn"> <input name="actionS" type="hidden"
								id="actionS" value="INVSalesReturn"></td>
						</tr>
						<tr>
							<td></td>
						</tr>
						<tr>
							<td></td>
						</tr>
						<tr>
							<td valign="top" class="boldEleven">
							<table border="0" align="center">
								<tr>
									<td width="56"><input id="Submit"  name="Submit" type="submit"
										class="buttonbold13" value="Return"></td>
									<td width="56"><input type="button" class="buttonbold13"
										name="submit"  value="Close"   accesskey="c" 
										onClick="redirect('Sales Return.jsp')" /></td>
								</tr>
							</table>
							</td>
						</tr>
					</table>
					</td>
					<td nowrap="nowrap" width="4"><spacer height="1" width="1"
						type="block" /></td>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/Smart Inventory/BLCorner.gif" width="7" /></td>
					<td height="6"><spacer height="1" width="1" type="block" />
					<div align="center"></div>
					</td>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/Smart Inventory/BRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
			</tbody>
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
</form>
<%@ include file="../footer.jsp"%>
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