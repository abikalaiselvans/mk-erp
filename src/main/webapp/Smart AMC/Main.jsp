<%
try
{
CommonFunctions.autoUpdate(request,""+application.getInitParameter("Auto"));
%>

 <link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>



<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />


<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="cache-control" content="no-store">
<meta http-equiv="cache-control" content="private">
<meta http-equiv="cache-control" content="max-age=0, must-revalidate">
<meta http-equiv="expires" content="now-1">
<meta http-equiv="pragma" content="no-cache">
<script language="javascript" src="../JavaScript/Servercheck.js"></script>
<script language="javascript">
loadServer()
</script>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/Inventory/InvenAJAX.js"></script>
<script language="javascript" src="../JavaScript/Inventory/branches.js"></script>
<script language="javascript">
  function Validate()
  {
	  
	obj = findObj("branchid");
	if(obj == null)
	{
		alert("Branch not available");
		return false;
	}	
	
	if(	checkNullSelect("office","Select Office","0") && OptionboxCheck())
		return true;	
	else
		return false;			
  } 
 
 
 function OptionboxCheck()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].branchid;
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
			if (document.forms[0].branchid.checked) { count=1;}
		}
		if(count==1){			
			 
			return true;
		}
		else
		{
		    alert("Select Only one Branch...");
		    return false;
		}
 	}

</script>

</script>
 <html>
<head>

<title> :: AMC ::</title>

 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
 
<body   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="#b7e9ff"  >
<center>

<table width='100%' border="0" cellpadding="0" cellspacing="0">
	<tr>
	  <td align=center><%@ include file="header.jsp"%></td>
    </tr>
	<tr>
		<td height="400" align=center>

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
					<td width="412" valign="top">
					<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm"
						onSubmit="return Validate()">
					<table width="267" border="0" align="center" cellpadding="5"
						cellspacing="5">
						<tr>
							<td colspan="2" valign="top" class="paramenu"></td>
						</tr>
						<tr>
							<td width="94" valign="top" class="paramenu">
							<div align="right"><input type="hidden" name="filename"
								value="Control" /> <input type="hidden" name="actionS"
								value="AMCControlAssign" /> 
							<span class="bold1">Office</span></div>							</td>
						  <td width="138" valign="top" class="paramenu">
							<%
				 	String usertype=""+session.getAttribute("USRTYPE");
					String officename= ""+session.getAttribute("OFFICENAME");
					String officeid= ""+session.getAttribute("OFFICEID");
					String user= ""+session.getAttribute("USRID"); 
					user=user.trim();
					
	 
 
 %>
 <select name="office" class="boldEleven" id="office" onChange="LoadBranches()" 		  onBlur="LoadBranches()">
	<option value="0">Select</option>
<%                  
	
	
	String OfficeData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(" SELECT b.INT_OFFICEID,b.CHR_OFFICENAME FROM  com_m_office  b WHERE b.INT_OFFICEID IN("+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT a.CHR_OFFICELIST FROM m_user a WHERE a.CHR_USRNAME='"+user+"' ")[0][0]+" )");
 if(OfficeData.length>0)
 	for(int u=0;u<OfficeData.length;u++)
		out.println("<option value='"+OfficeData[u][0]+"'>"+OfficeData[u][1]+"</option>");
 
	
	
	 
	%>
</select>
							 </td>
						</tr>
						<tr>
							<td colspan="2" valign="top" class="paramenu">
							<div id='branchTable'></div>							</td>
						</tr>

						<tr>
						  <td colspan="2" class="paramenu">
							<table   border="0" align="center" cellpadding="0"
								cellspacing="2">
								<tr>
									<td width="56"><input name="Submit" type="submit" id="Submit"
										class="buttonbold13" value="Submit"   accesskey="s"   >								  </td>
								    <td width="56"><input name="Close" type="button" id="Close"
										class="buttonbold13"  value="Close"   accesskey="c"  onClick="redirect('../Home.jsp')"></td>
								</tr>
							</table>							
							<a href="../SmartStock/Main.jsp"> </a></td>
						</tr>
					</table>
					</form>					</td>
					<td nowrap="nowrap" width="4"><spacer height="1" width="1"
						type="block" /></td>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/Smart Inventory/BLCorner.gif" width="7" /></td>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/Smart Inventory/BRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
			</tbody>
		</table>		</td>
	</tr>
	<tr>
		<td><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
</center>
</html>
<%
}
catch(Exception e)
{

}
%>