<%@ page import="java.io.*,java.util.*"%>
<%@ page import="sun.net.smtp.SmtpClient"%>

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
<script language="JavaScript" src="../JavaScript/calendar1.js"
	type="text/javascript"></script>
<script language="javascript" src="../JavaScript/TicketAJAX.js"></script>
<script language="javascript">
function Validate()
{
		if(
			checkNullSelect('package','Select Package..', 'Select')
			&& checkNullSelect('priority','Select Priority..', 'Select')
			&& checkNull('desc', 'Enter Problem Description..')
		)
		{
			return true;
		}
		else
		{
			return false;
		}	
}		
</script>

<script language="JavaScript">

    function Add()
	{ 
		document.frm.action="Ticket.jsp";
 	}

	function Edit()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].Ticketid
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
			if (document.forms[0].Ticketid.checked) { count=1;}
		}
		if(count==1){			
			document.frm.action="TicketEdit.jsp";
			return true;
		}
		else
		{
		    alert("Select Only one Ticket Id");
		    return false;
		}
 	}
	

 	function Delete()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].Ticketid
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
			if (document.forms[0].Ticketid.checked) { count=1;}
		}
		if(count>=1){			
				document.frm.action="../SmartLoginAuth";			
		}
		else
		{
		    alert("Select Atleast One Ticket Id");
		    return false;
		}		
 	} 	 	
 	 	
     	
</script>

<body    onLoad="LoadTicket()">
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth">
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
		<table width="838" height="227" border="0" align="center"
			cellpadding="0" cellspacing="0"  
			 >
			<tr class="BackGround">
				<td height="31" class="BackGround">
				<div align="center">Ticket Informations</div>
				</td>
			</tr>
			<tr class="BackGround">
				<td class="BackGround">
				<table width="698" border="0" align="center" cellpadding="2"
					cellspacing="2">
					<tr>
						<td width="18" class="boldThirteen">Package</td>
						<td width="19" class="boldThirteen"><select name="package"
							id="package" onBlur="LoadTicket()">
							<option value='0' selected>All
							<option value='A'>Attendance
							<option value='P'>Payroll
							<option value='I'>Inventory
							<option value='U'>Utility
						</select></td>
						<td width="37" class="boldThirteen">Status</td>
						<td width="37" class="boldThirteen"><select name="Status"
							id="Status" class="formText135" onBlur="LoadTicket()">
							
							<option value="N">Not Completed
							<option value="Y">Completed
						</select></td>
						<td width="74" class="boldThirteen">Month ::</td>
						<td width="89"><select name="month" id="month"
							onBlur="LoadTicket()">
							<option value="0">All</option>
							<%@ include file="../JavaScript/Inventory/month.jsp"%>
						</select></td>
						<td width="50" class="boldThirteen">Year ::</td>
						<td width="88"><select name="year" id="year"
							onBlur="LoadTicket()">
							<%@ include file="../JavaScript/Inventory/year.jsp"%>
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
				<table width="100%" border="0" cellspacing="1" cellpadding="2">
					<tr class="BackGround">
						<td class="bold1" width="100">
						<div align="left">Ticket id</div>
						</td>
						<td class="bold1" width="200">
						<div align="left">From</div>
						</td>
						<td class="bold1" width="100">
						<div align="left">date</div>
						</td>
						<td class="bold1" width="400">
						<div align="left">Problem</div>
						</td>
						<td class="bold1" width="100">Status</td>
					</tr>
				</table>
				</div>
				</td>
			</tr>
			<tr>
				<td height="127" valign="top" class="footermenu">
				<table width="100%">

					<tr>
						<td class="bolddeepblue" align="center" bgcolor="#efefef"></td>
					</tr>
					<tr>
						<td>
						<div id="ticket" style="OVERFLOW:auto;width:100%;height:200px"
							class="boldEleven"></div>
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
		<table border="0" align="center" cellpadding="3" cellspacing="3">
			<!--DWLayoutTable-->
			<tr>
				<td width="56" valign="top"><input type="submit"
					class="buttonbold13" name="action1"  value="Add"   accesskey="s"   onClick="Add()" /></td>
				<td width="56" valign="top"><input type="submit"
					class="buttonbold13" name="action12" id="btnEdit" value="Edit"
					onclick="return Edit()" /></td>
				<%
		  String usertype=""+session.getAttribute("USRTYPE");
		  if("F".equals(usertype))
		  {
	  %>
				<td width="56"><input type="submit" class="buttonbold13"
					name="Submit3" id="btnDelete" value="Cancel"
					onClick="return Delete()" /></td>
				<%
		}
		else
		{
			out.println("<input type='hidden' id='btnDelete'>");
		}
		%>
				<td width="56"><input name="button" type="button"
					class="buttonbold13" onClick="redirect( 'InventoryMains.jsp')"
					 value="Close"   accesskey="c"  /></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td><input name="filename" type="hidden" value="Ticket" /> <input
			name="actionS" type="hidden" value="INVTicketDelete" /></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<%@ include file="../footer.jsp"%></form>
</body>
</html>
