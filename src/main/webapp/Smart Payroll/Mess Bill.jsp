<%@ page
	import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.bean.Attendance.*"%>
<%@ include file="index.jsp"%>
<%!
	ArrayList empdata = new ArrayList();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title> :: PAYROLL ::</title>


 

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
<script language="JavaScript" src="../JavaScript/comfunction.js"> </script>
<script language="JavaScript" src="../JavaScript/Payroll/PayrollAjax.js"></script>

<script language="javascript">

 	function Edit()
{		
  var count=0;
 	    sel=document.forms[0].staffid;
 	    for(i=0;i<sel.length;i++)
 	    {
 	         if(sel[i].checked)
 	         count=count+1;  
 	    } 
 	    if(count==0)
 	    {
 	       alert("Select Record to Edit");
 	       return false;
 	    
 	    }
 	    if(count>1)
 	    {
 	       alert("Select One Record to Edit");
 	       return false;
 	    }
 	    if(count==1)
 	    {
		document.messbillfrm.action="MessBillEdit.jsp";
		document.messbillfrm.submit();
		return true;
		}
 	}
 	
	 
		
	function Add()
{		
	document.messbillfrm.action="MessBillAdd.jsp";
	document.messbillfrm.submit();
}		
	
	function Delete()
 	{		
		var count;
		count=0;
		c1=document.forms[0].staffid
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
			if (document.forms[0].staffid.checked) { count=1;}
		}
		if(count>=1){			
			var name=confirm("Confirm to Delete")
			if (name==true)
			{ 
				document.messbillfrm.action="../SmartLoginAuth";
				document.messbillfrm.submit();
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
 
<style type="text/css">
<!--
.style3 {color: #000000}
-->
</style>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"
	onLoad="loadMessBill('0')">
<form  AUTOCOMPLETE = "off"   method="get" name="messbillfrm">
<table width="100%" height="285" align="center">
	<tr>
		<td height="151" align="center"><br>
		<table height="120" border="1" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"  
			 >
			<!--DWLayoutTable-->
			<tr align="center" valign="middle"   background="">
				<td height="28"  
					class="tablehead"><span class="whiteMedium">Mess Bills</span></td>
			</tr>
			<tr>
				<td height="31" align="center">
				<table width="28%" border="0" align="center" cellpadding="1"
					cellspacing="1" class="whiteMedium">
					<tr>
						<td>Month </td>
						<td><span class="boldThirteen"> <select name="month"
							id="month" onChange="loadMessBill('0')">
							<%@ include file="../JavaScript/months.jsp"%>
						</select> </span></td>
						<td>Year </td>
						<td><span class="boldThirteen"> <select name="year"
							id="year" onChange="loadMessBill('0')">
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
				</table>			  </td>
		  </tr>
			<tr  >
				<td height="31" align="left" valign="middle" class="boldEleven">
				<table width="100%" border="0" class="whiteMedium"
					  >
					<tr>

						<td width="150">Staff Id</td>
						<td width="170">Staff Name</td>
						<td width="140">Company</td>
						<td width="120">Branch</td>
						<td width="130">Department</td>
						<td width="120">Designation</td>
						<td width="100">Mess Amount</td>
					</tr>
				</table>				</td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td height="28" valign="top">
				<div id="MessTable" style="OVERFLOW: auto;width:970px;height:180px">				</div><br>			  </td>
		</table>		</td>
	</tr>
	<tr>
	  <td height="23">&nbsp;</td>
  </tr>
	<tr>
		<td height="23"><input name="filename" type="hidden"
			id="filename" value="StaffMessBill" /> <input name="actionS"
			type="hidden" id="actionS" value="PAYStaffMessBillDelete" />
		<table border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
			<tr class="para">
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadMessBill('0')">All</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadMessBill('A')">A</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadMessBill('B')">B</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadMessBill('C')">C</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadMessBill('D')">D</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadMessBill('E')">E</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadMessBill('F')">F</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadMessBill('G')">G</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadMessBill('H')">H</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadMessBill('I')">I</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadMessBill('J')">J</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadMessBill('K')">K</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadMessBill('L')">L</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadMessBill('M')">M</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadMessBill('N')">N</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadMessBill('O')">O</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadMessBill('P')">P</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadMessBill('Q')">Q</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadMessBill('R')">R</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadMessBill('S')">S</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadMessBill('T')">T</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadMessBill('U')">U</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadMessBill('V')">V</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadMessBill('W')">W</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadMessBill('X')">X</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadMessBill('Y')">Y</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadMessBill('Z')">Z</a></div>				</td>
			</tr>
		</table>		</td>
	</tr>
	<tr>
	  <td height="17" align="center">    
  <tr>
	  <td height="17" align="center">
		<center>
		<table border="0" cellspacing="1" cellpadding="1">
			<tr>
				<td width="56"><input class="ButtonHead" name="submit2"
					type="submit" onClick=Add() value="Add"></td>
				<td width="56"><input class="ButtonHead" name="submit3"
					type="submit" onClick=Edit() value="Edit"></td>
				<td width="56"><input class="ButtonHead" name="submit3"
					type="Button" onClick="return Delete();" value="Delete"></td>
				<td width="56"><input class="ButtonHead" type="Button"
					name="Button"  value="Close"   accesskey="c"  onClick="redirect('Payrollmain.jsp')"></td>
			</tr>
		</table>
	<tr>
		<td height="20"><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
</body>
</html>
