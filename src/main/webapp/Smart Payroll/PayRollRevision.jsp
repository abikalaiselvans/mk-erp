<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.bean.Attendance.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%>
<%@ include file="index.jsp"%>
<%!
	ArrayList empdata = new ArrayList();
%>
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

 
<script language="JavaScript" src="../JavaScript/comfunction.js"> </script>
<script language="JavaScript" src="../JavaScript/Payroll/PayrollRevision.js"></script>
<script language="javascript" src="../JavaScript/jquery/jquery-latest.js"></script>
<script language="javascript" src="../JavaScript/jquery/jquery.tablesorter.min.js"></script>
<link rel="stylesheet" href="../JavaScript/jquery/themes/blue/style.css" type="text/css" id="" media="print, projection, screen" />

<script language="javascript">
$(document).ready(function()
	{
		$("#myTables").tablesorter();
	}
);
</script>
<script language="javascript">
 
	
	
	function Add()
 	{		
		
		obj = findObj("staffid"); 
		if(obj == null)
		{
			alert("Add not available");
			return false;
		}


		var count;
		count=0;
		coffee1=document.forms[0].staffid;
		 
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
			if (document.forms[0].staffid.checked) 
			{ 
			count=1;
			}
		}
		
		if(count==1)
		{			
			document.frm.action="PayRollRevisionAdd.jsp";
			return true;
		}
		else
		{
		    alert("Select Only one Record");
		    return false;
		}
 	}
	
	
 
	 
		
	function LoadAll()
	{
			var name=confirm("Confirm to Load All Employee")
			if (name==true)
			 	loadPayrollRevision('0')
			else
				document.getElementById('search').focus();
				 
	
	}
	
	
	
	
 	</script>
 
 
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="LoadAll()">
<form  AUTOCOMPLETE = "off"   method="get" name="frm">
<table width="100%" height="577" align="center">
	<tr>
	  <td height="18" align="center">&nbsp;</td>
    </tr>
	<tr>
		<td height="151" align="center">
		
		
		
		
		 
		
		
		  <table height="120" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"  
			 >
			<!--DWLayoutTable-->
			<tr align="center" valign="middle" >
				<td height="28"  
					class="whiteMedium">REVISION</td>
			</tr>

			<tr  >
			  <td height="31" align="center" valign="middle"  ><table width="80%" border="0" align="center" cellpadding="0" cellspacing="0" class="whiteMedium">
                <tr>
                  <td width="46" align="left" valign="middle">&nbsp;</td>
                  <td width="46" align="left" valign="middle">&nbsp;</td>
                  <td width="56" height="20" align="left" valign="middle">Month</td>
				  <td width="102" align="left" valign="middle" class="boldEleven">
								<select	name="month" 	id="month"  class="formText135" onChange="loadPayrollRevision('0')">
								<option value="0">All</option>
								<%@ include file="../JavaScript/months.jsp" %>
							</select>				  </td>
                 <td width="54" height="20" align="left" valign="middle">Year</td>
				  <td width="147" valign="top" class="boldEleven">
							<select name="year"  id="year" class="formText135" onChange="loadPayrollRevision('0')">
								<option value="select">Select</option>
								<%@ include file="../JavaScript/years.jsp" %>
							</select> <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						setOptionValue('month',month1);
						setOptionValue('year',year1);							
				//-->
          </script>
							<input type="hidden" name="filename" value="PayRollRevision"> 
				  <input
								type="hidden" name="actionS" value="PAYPayRollRevision"></td>
				  <td width="139">Search Id/ Name</td>
                  <td width="120"><input name="search" type="text" class="formText135" id="search" onKeyPress="loadPayrollRevisions('0')"  ></td>
                </tr>
              </table></td>
		  </tr>
			 
			<tr class="MRow1">
				<td height="28" valign="top">
			  <div id="PayrollRevisionTable" style="OVERFLOW: auto;width:100%;height:300px"></div><br>
			  <br>
				<div id="totalrecord" align="center"></div>
				<br> 
								</td>
	  </table>		</td>
	</tr>
	<tr>
	  <td height="23">&nbsp;</td>
  </tr>
	<tr>
		<td height="23"><input name="filename" type="hidden"
			id="filename" value="StaffTransfer" /> <input name="actionS"
			type="hidden" id="actionS" value="PAYStaffTransferDelete" />
		<table border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
			<tr class="para">
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadPayrollRevision('0')">All</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadPayrollRevision('A')">A</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadPayrollRevision('B')">B</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadPayrollRevision('C')">C</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadPayrollRevision('D')">D</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadPayrollRevision('E')">E</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadPayrollRevision('F')">F</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadPayrollRevision('G')">G</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadPayrollRevision('H')">H</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadPayrollRevision('I')">I</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadPayrollRevision('J')">J</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadPayrollRevision('K')">K</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadPayrollRevision('L')">L</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadPayrollRevision('M')">M</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadPayrollRevision('N')">N</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadPayrollRevision('O')">O</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadPayrollRevision('P')">P</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadPayrollRevision('Q')">Q</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadPayrollRevision('R')">R</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadPayrollRevision('S')">S</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadPayrollRevision('T')">T</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadPayrollRevision('U')">U</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadPayrollRevision('V')">V</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadPayrollRevision('W')">W</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadPayrollRevision('X')">X</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadPayrollRevision('Y')">Y</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadPayrollRevision('Z')">Z</a></div>				</td>
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
				<td width="56"><input class="ButtonHead" name="submit2" type="submit"  value="Add"   accesskey="s"      onClick="return Add()" ></td>
				
				 
		
				
				 
				<td width="56"><input class="ButtonHead" name="Button"  type="Button"  value="Close"   accesskey="c"   onClick="redirect('Payrollmain.jsp')"></td>
			</tr>
		</table>
	<tr>
		<td height="20"><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
</form>


</body>
</html>
