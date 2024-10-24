<%@ page
	import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.bean.Attendance.*"%>
<%@ include file="index.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

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
<script language="JavaScript" src="../JavaScript/comfunction.js"> </script>
<script language="JavaScript"
	src="../JavaScript/Attendance/AttendanceAjax.js"></script>

<script language="javascript">

function disable()
{
    document.getElementById('Edit').disabled=true; 	
}

 	function cEdit()
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
		   if(document.forms[0].staffid.checked)
		    { 
		    	count=1;
		    }   
		    else{	    
		   	   alert("Select Record to Edit");
		   	   return false;
		   	 }
 	    }
 	    if(count>1)
 	    {
 	       alert("Select One Record to Edit");
 	       return false
 	    }
 	    if(count==1)
 	    {
		document.Compensationfrm.action="CompensationEdit.jsp";
		
		return true;
		}
 	}

	function Add()
 	{		
		document.Compensationfrm.action="CompensationAdd.jsp";		
 	}		
	
	
	 
	
 	</script>
 
<style type="text/css">
<!--
.style3 {color: #000000}
-->
</style>
</head>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form  AUTOCOMPLETE = "off"   method="get" name="Compensationfrm">
<table width="100%" height="285" align="center">
	<tr>
		<td height="151" align="center"><br>
		<table width="970" height="120" border="0" align="center"
			cellpadding="0" cellspacing="0"  
			 
			 >
			<!--DWLayoutTable-->
			<tr align="center" valign="middle"   background="">
				<td height="28"  
					class="tablehead"><span class="style3">Compensation</span></td>
			</tr>
			<tr class="BackGround">
				<td height="31" class="BackGround">
				<table width="28%" border="0" align="center" cellpadding="1"
					cellspacing="1" class="boldEleven">
					<tr>
						<td class="boldThirteen"><strong>Office</strong></td>
						<td class="boldThirteen">
						<%
			   	String branchid=""+session.getAttribute("BRANCHID");
	   			String oficeid=""+session.getAttribute("OFFICEID");
				 
			  %> <select name="Office" class="formText135" id="Office"
							tabindex="6" onChange="loadCompensation('0')">
							<option value="0">All</option>
							<%
								
		String sq=" select INT_OFFICEID,CHR_OFFICENAME from  com_m_office  order by CHR_OFFICENAME";

		String shipids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sq);
		for(int u=0; u<shipids.length; u++)
			if(shipids[u][0].trim().equals(oficeid.trim()))
				out.print("<option selected = 'selected' value='"+shipids[u][0]+"'>"+shipids[u][1] +"</option>");
			else
				out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][1] +"</option>");
							%>
						</select></td>
						<td class="boldThirteen">Month ::</td>
						<td><span class="boldThirteen"> <select name="month"
							id="month" onChange="loadCompensation('0')">
							<%@ include file="../JavaScript/months.jsp"%>
						</select> </span></td>
						<td><span class="boldThirteen">Year ::</span></td>
						<td><span class="boldThirteen"> <select name="year"
							id="year" onChange="loadCompensation('0')">
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
			<tr  >
				<td height="31" align="left" valign="middle" class="boldEleven">
				<table width="100%" border="0"
					  >
					<tr>
						<td width="15%"><strong class="bold1">Staff Id</strong></td>
						<td width="15%"><strong class="bold1">Staff Name</strong></td>
						<td width="12%"><strong class="bold1">Company</strong></td>
						<td width="12%"><strong class="bold1">Branch</strong></td>
						<td width="12%"><strong class="bold1">Department</strong></td>
						<td width="10%"><strong class="bold1">Designation</strong></td>
						<!--            <td width="10%"><strong class="bold1">Comp.Name</strong></td>
				<td width="9%"><strong class="bold1">From Date</strong></td>
                <td width="8%"><strong class="bold1">To Date</strong></td> -->
						<td width="8%"><strong class="bold1">No.Days</strong></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td height="28" valign="top">
				<div id="compensationTable"
					style="OVERFLOW: auto;width:970px;height:200px"></div>
				</td>
		</table>
		</td>
	</tr>
	<tr>
		<td height="17"><input name="filename" type="hidden"
			id="filename" value="Compensation"> <input name="actionS"
			type="hidden" id="actionS" value="ATTCompensationDelete">
		<table width="900" border="0" align="center" cellpadding="1"
			cellspacing="1"  >
			<tr class="para">
				<td>
				<div align="center"><a href="javascript:loadCompensation('0')">All</a></div>
				</td>
				<td>
				<div align="center"><a href="javascript:loadCompensation('A')">A</a></div>
				</td>
				<td>
				<div align="center"><a href="javascript:loadCompensation('B')">B</a></div>
				</td>
				<td>
				<div align="center"><a href="javascript:loadCompensation('C')">C</a></div>
				</td>
				<td>
				<div align="center"><a href="javascript:loadCompensation('D')">D</a></div>
				</td>
				<td>
				<div align="center"><a href="javascript:loadCompensation('E')">E</a></div>
				</td>
				<td>
				<div align="center"><a href="javascript:loadCompensation('F')">F</a></div>
				</td>
				<td>
				<div align="center"><a href="javascript:loadCompensation('G')">G</a></div>
				</td>
				<td>
				<div align="center"><a href="javascript:loadCompensation('H')">H</a></div>
				</td>
				<td>
				<div align="center"><a href="javascript:loadCompensation('I')">I</a></div>
				</td>
				<td>
				<div align="center"><a href="javascript:loadCompensation('J')">J</a></div>
				</td>
				<td>
				<div align="center"><a href="javascript:loadCompensation('K')">K</a></div>
				</td>
				<td>
				<div align="center"><a href="javascript:loadCompensation('L')">L</a></div>
				</td>
				<td>
				<div align="center"><a href="javascript:loadCompensation('M')">M</a></div>
				</td>
				<td>
				<div align="center"><a href="javascript:loadCompensation('N')">N</a></div>
				</td>
				<td>
				<div align="center"><a href="javascript:loadCompensation('O')">O</a></div>
				</td>
				<td>
				<div align="center"><a href="javascript:loadCompensation('P')">P</a></div>
				</td>
				<td>
				<div align="center"><a href="javascript:loadCompensation('Q')">Q</a></div>
				</td>
				<td>
				<div align="center"><a href="javascript:loadCompensation('R')">R</a></div>
				</td>
				<td>
				<div align="center"><a href="javascript:loadCompensation('S')">S</a></div>
				</td>
				<td>
				<div align="center"><a href="javascript:loadCompensation('T')">T</a></div>
				</td>
				<td>
				<div align="center"><a href="javascript:loadCompensation('U')">U</a></div>
				</td>
				<td>
				<div align="center"><a href="javascript:loadCompensation('V')">V</a></div>
				</td>
				<td>
				<div align="center"><a href="javascript:loadCompensation('W')">W</a></div>
				</td>
				<td>
				<div align="center"><a href="javascript:loadCompensation('X')">X</a></div>
				</td>
				<td>
				<div align="center"><a href="javascript:loadCompensation('Y')">Y</a></div>
				</td>
				<td>
				<div align="center"><a href="javascript:loadCompensation('Z')">Z</a></div>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td height="17" align="center">
		<center>
		<table border="0" cellspacing="1" cellpadding="1">
			<tr>
				<td width="56"><input class="buttonbold" name="submit2"
					type="submit" onClick=Add() value="Add"></td>
				<td width="56"><input class="buttonbold" name="Edit" id="Edit"
					type="submit" onClick="return cEdit()" value="Edit"></td>
				<td width="56"><input class="buttonbold" type="Button"
					name="Button"  value="Close"   accesskey="c" 
					onClick="redirect('AttendanceMain.jsp')"></td>
			</tr>
		</table>
	<tr>
		<td height="20"><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
</body>
</html>
