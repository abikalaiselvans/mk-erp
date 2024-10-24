<%@ page import="java.io.*,java.util.*" isErrorPage="false" 	errorPage="./error.jsp"%>

<html>
 

<title> :: ATTENDANCE ::</title>


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

<style type="text/css">
<!--
.style8 {
	font-family: Verdana;
	font-size: 12px;
}
.style9 {color: #FFFFFF}
.style10 {font-family: Verdana; font-size: 12px; color: #FFFFFF; }
a:visited {
	color: #663366;
}
a:hover {
	color: #FF0000;
}
a:active {
	color: #0000FF;
}
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>

<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/Attendance/ShiftMasterAjax.js"></script>

<script language="javascript">    
	function SDelete()
 	{	
		var count;
		count=0;
		coffee1=document.forms[0].OptShiftName
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
			if (document.forms[0].OptShiftName.checked) { count=1;}
		}
		if(count>=1){			
			var name=confirm("Confirm to Delete")
			if (name==true)
			{ 
				document.frm.action="../SmartLoginAuth";
//				document.frm.submit();
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
 	function SEdit()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].OptShiftName
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
			if (document.forms[0].OptShiftName.checked) { count=1;}
		}
		if(count==1){		
		
		document.frm.action="ShiftMasterAction.jsp";
			
//			document.frm.submit();
			return true;
		}
		else
		{
		    alert("Select Only one Value");
		    return false;
		}
 	}
	function Add()
 	{
		
		document.frm.action="ShiftMasterAction.jsp";
//		document.frm.submit();
 	}
 	function mainPage()
	{
	   document.frm.action="../RemoveSession";
    }
	
</script>

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<form  AUTOCOMPLETE = "off"   method="get" name='frm' >
<body  onpaste="return false;" onLoad=" loadShiftMaster('0')">
<%@ include file="index.jsp"%>
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td></td>
	</tr>
	<tr>
		<td></td>
	</tr>
	<tr>
	  <td>&nbsp;</td>
  </tr>
	<tr>
		<td>

		<table width="90%" height="220" border="0" align="center" cellpadding="0" cellspacing="0" class="TableDesign"
			 >
			<tr>
			  <td height="30" align="center" class="whiteMedium" >Shift Master </td>
		  </tr>
			
			<tr>
				<td height="30" align="center" ><table width="100%" border="0" align="center" cellpadding="5" cellspacing="0" class="whiteMedium">
                  <tr>
                    <td  ><div align="center">S.No</div></td>
                    <td ><div align="center">Shift Name</td>
					<td  ><div align="center">From Time</td>
					<td  ><div align="center">To Time</td>
                  </tr>
                </table></td>
			</tr>
			<tr>
				<td bgcolor="#FFFFFF" >
				
				<div id="ShiftMasterTable" style="OVERFLOW:auto;width:100%;height:300px"></div>				</td>
			</tr>
		</table>		</td>
	</tr>

	<tr>
	  <td>&nbsp;</td>
  </tr>
	<tr>
		<td>
		<table width="317" align="center">
			<tr>
				<td width="56"><div align="center"><input class="ButtonHead" type="submit"
					onClick="Add()" name="action1" id="action1" value="Add"></div>				</td>
				<td width="56">
				<div align="center"><input class="ButtonHead" type="submit"  name="Edit"   id="Edit" value="Edit" onClick="return SEdit()">
				</div>				</td>
				<%
	 String usertype=""+session.getAttribute("USRTYPE");
	  if("F".equals(usertype))
	  {
	  %>


				<td width="56">
				<div align="center"><input name="submit" id="submit" type="submit"
					class="ButtonHead" onClick="return SDelete()" value="Delete"
					 ></div>				</td>

				<%
}
%>
				<td width="56">
				<div align="center"><input class="ButtonHead" type="button"
					name="Button" id="Button"  value="Close"   accesskey="c"  onClick="redirect('AttendanceMain.jsp')"></div>				</td>
			    <td width="69"  ><input type="hidden" name="filename"	value="ShiftMaster">
		        <input type="hidden" name="actionS"	value="ATTshiftDelete"></td>
			</tr>
		</table>		</td>
	</tr>
</table>



<%@ include file="../footer.jsp"%>

</body>
</html>



