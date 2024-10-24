<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.bean.Attendance.*"%>
<%@ include file="index.jsp"%>
<%!
	ArrayList empdata = new ArrayList();
%>
<%
try
{
%>

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
a:visited {
	color: #663366;
}
a:hover {
	color: #FF0000;
}
a:active {
	color: #0000FF;
}

-->
</style>

 
<style type="text/css">
<!--
.style3 {color: #000000}
-->
</style>
<script language="JavaScript" src="../JavaScript/comfunction.js"> </script>
<script language="JavaScript" src="../JavaScript/Attendance/CommonHolidayAjax.js"></script>

<script language="javascript">
 
function HEdit()
 	{					
	   
 	    var count;
		count=0; 				
		coffee1=document.forms[0].holiday;
		txt="";
		for (i=0;i<coffee1.length;++ i)
		{
			if (coffee1[i].checked)
			{
			count=count+1;
			}
		}
		if(count==0)
		{
			if (document.frm.holiday.checked) { count=1;}
		}
		if(count==1){			
			document.frm.action="CommonHolidayEdit.jsp";			
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
		document.frm.action="CommonHolidayAdd.jsp";		
 	}		
	
function HDelete()
{
	var count;
		count=0;
		c1=document.forms[0].holiday;
		txt=""
		for (i=0;i<c1.length;++ i)
		{
			if (c1[i].checked)
			{
			count=count+1;
			}
		}
		if(count==0)
		{
			if (document.forms[0].holiday.checked) { count=1;}
		}
		if(count==1){			
			var name=confirm("Confirm to Delete")
			if (name==true)
			{ 
				document.frm.action="../SmartLoginAuth?filename=Holiday&actionS=ATTCommonHolidayDelete";
				document.frm.submit();
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
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadCommonHoliday('0')" >
<form  AUTOCOMPLETE = "off"   method="get" name="frm" >
<table width="100%" height="285" align="center">
	<tr>
		<td height="151" align="center"><br>
		<table width="90%" height="120" border="0" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"
			 >
			<!--DWLayoutTable-->
			<tr align="center" valign="middle"  >
				<td height="28" 
					class="tablehead"><span class="whiteMedium">Common Holidays</span></td>
			</tr>
			<tr>
				<td height="31" align="center">
				<table width="46%" border="0" align="center" cellpadding="1"
					cellspacing="1" class="whiteMedium">
					<tr>
						<td>Month </td>
						<td><span class="boldThirteen"> 
						<select name="month"	id="month" onChange="loadCommonHoliday('0')">
							<option value="0">All</option>
							<%@ include file="../JavaScript/months.jsp"%>
						</select> </span></td>
						<td>Year </td>
						<td><span class="boldThirteen"> 
						<select name="year"	id="year" onBlur="loadCommonHoliday('0')">
							<%@ include file="../JavaScript/years.jsp"%>
						</select> <script language='JavaScript' type="text/javascript">
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
			<tr>
				<td height="31" align="left" valign="middle" class="boldEleven">
				<table width="100%" border="0" class="whiteMedium"
					  >
					<tr>
						<td width="15%" align="center">S.No</td>
						<td width="16%" align="center">Date</td>
						<td width="12%" align="center">Description</td>
						<td width="12%" align="center">Status</td>
					</tr>
				</table>				</td>
		  </tr>
			<tr bgcolor="#7F9DB9">
				<td height="28" valign="top" bgcolor="#FFFFFF">
				<div id="holidayTable" 	style="OVERFLOW: auto;width:100%;height:200px"></div><br>
				<br>
				<div id="totRec"></div>
				<br>
				
			  </td>
		</table>
		</td>
	</tr>
	<tr>
		<td height="17"><input name="filename" type="hidden"
			id="filename" value="Holiday"> <input name="actionS"
			type="hidden" id="actionS" value="ATTCommonHolidayDelete"></td>
	</tr>
	<tr>
		<td height="17" align="center">
		 
		<table border="0" cellspacing="1" cellpadding="1">
			<tr>
				<td width="56">
				<input class="ButtonHead" name="submit2"  id="submit2" type="submit" onClick=Add() value="Add"></td>
				<td width="56">
				<input class="ButtonHead" name="Edit" id="Edit"  type="submit" onClick="return HEdit()" value="Edit"></td>
				<!--<td width="56">
				<input class="ButtonHead" name="Delete"  id="Delete" type="submit" onClick="return HDelete()" value="Delete">
				</td>-->
				<td width="56">
				<input class="ButtonHead" type="Button"	name="Button"  	id="Button"  value="Close"   accesskey="c" 
					onClick="redirect('AttendanceMain.jsp')"></td>
			</tr>
		</table>
	<tr>
		<td height="20"><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
</body>
<%
}
catch(Exception e)
{
}
%>
