<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.bean.payroll.*"%>
<%@ page import="com.my.org.erp.SmartPayroll.*"%>
<html>
<head>

<title> :: PAYROLL ::</title>


 
 
<script src="../JavaScript/AJAXFunction.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/Payroll/PayrollAjax.js"></script>
<script language="javascript">
function validate()
{
    if(checkNull("ename","Select Staff"))
    	return true;
    else
    	return false;
}
function list()
  {   
     if(checkNull("ename","Select Staff"))
	 {
        return true;
     }
     else
     {
     	return false;
     }     
   }
function mainPage()
	{
	    document.allow.action="Payrollmain.jsp";
		document.allow.submit();
		return true;
    }	
	
function Add()
{		
	document.allowancefrm.action="AllowanceRecoveryAdd.jsp";
	document.allowancefrm.submit();
}	
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
		document.allowancefrm.action="AllowanceRecoveryEdit.jsp";
		document.allowancefrm.submit();
		return true;
		}
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
				document.allowancefrm.action="../SmartLoginAuth";
				document.allowancefrm.submit();
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
	 	
		function mainPage()
	{
	    document.allowancefrm.action="Payrollmain.jsp";
		document.allowancefrm.submit();
		return true;
    }
</script>
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
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
.style3 {
	COLOR: #000000;
	LINE-HEIGHT: 15px;
	FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif;
	TEXT-DECORATION: none;
	font-size: 10px;
	font-weight: bold;
}
-->
</style>
</head>

<body  onpaste="return false;" onLoad="loadAllowance('')">
<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   name="allowancefrm">
<table width="100%" border="0" align="center" cellpadding="2"
	cellspacing="2">
	<tr>
		<td></td>
	</tr>
	<tr>
		<td>
		<table width="800" height="200" border="0" align="center"
			cellpadding="1" cellspacing="1"  >


			<tr>
				<td height="54">
				<table width="741" align="center" border="1" cellspacing="0"
					cellpadding="0"  >
					<!--DWLayoutTable-->
					<tr align="center" valign="middle">
						<td width="737" height="31" class="BackGround">
						<%
	    String sl=""+request.getParameter("startLetter");
		if(sl.equalsIgnoreCase("null")) sl="A";
    %>
						<div align="center" class="boldThirteen">Allowance and
						Recovery &nbsp;&nbsp;&nbsp;Month :: <select name="month"
							id="month" onBlur="loadAllowance('')">
							<%@ include file="../JavaScript/months.jsp"%>
						</select> &nbsp;&nbsp;&nbsp;Year :: <select name="year" id="year"
							onBlur="loadAllowance('')">
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
          </script></div>
						</td>
					</tr>
					<tr align="center" valign="middle"
						  >
						<td bgcolor="#FFFFFF">
						<table width="100%" height="19" border="0" cellpadding="0"
							cellspacing="0">
							<tr>
								<td width="79" height="19" class="boldEleven"><strong>Staff
								Id</strong></td>
								<td width="102"   
									class="boldEleven"><strong>Staff Name</strong></td>
								<td width="137"   
									class="boldEleven"><strong>Branch Name</strong></td>
								<td width="137"   
									class="boldEleven"><strong>Company Name</strong></td>
								<td width="137"   
									class="boldEleven"><strong>Recovery</strong></td>
								<td width="178"   
									class="boldEleven"><strong>Allowance</strong></td>
							</tr>
						</table>
					<tr>
						<td>
						<div id="divscroll" style="OVERFLOW:auto;width:600px;height:130px"
							class="boldEleven">
						<div id="AllowanceTable"></div>
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
		<td height="23"><input name="filename" type="hidden"
			id="filename" value="StaffAllowanceRecovery"> <input
			name="actionS" type="hidden" id="actionS"
			value="PAYStaffAllowanceRecoveryDelete">
		<table width="700" border="0" align="center" cellpadding="2"
			cellspacing="2"  >
			<tr class="boldEleven">
				<td width="9"><a href="AllowanceTransView.jsp?startLetter=A">A</a></td>
				<td width="8"><a href="AllowanceTransView.jsp?startLetter=B">B</a></td>
				<td width="9"><a href="AllowanceTransView.jsp?startLetter=C">C</a></td>
				<td width="9"><a href="AllowanceTransView.jsp?startLetter=D">D</a></td>
				<td width="8"><a href="AllowanceTransView.jsp?startLetter=E">E</a></td>
				<td width="8"><a href="AllowanceTransView.jsp?startLetter=F">F</a></td>
				<td width="9"><a href="AllowanceTransView.jsp?startLetter=G">G</a></td>
				<td width="9"><a href="AllowanceTransView.jsp?startLetter=H">H</a></td>
				<td width="6"><a href="AllowanceTransView.jsp?startLetter=I">I</a></td>
				<td width="6"><a href="AllowanceTransView.jsp?startLetter=J">J</a></td>
				<td width="8"><a href="AllowanceTransView.jsp?startLetter=K">K</a></td>
				<td width="7"><a href="AllowanceTransView.jsp?startLetter=L">L</a></td>
				<td width="10"><a href="AllowanceTransView.jsp?startLetter=M">M</a></td>
				<td width="9"><a href="AllowanceTransView.jsp?startLetter=N">N</a></td>
				<td width="10"><a href="AllowanceTransView.jsp?startLetter=O">O</a></td>
				<td width="8"><a href="AllowanceTransView.jsp?startLetter=P">P</a></td>
				<td width="10"><a href="AllowanceTransView.jsp?startLetter=Q">Q</a></td>
				<td width="8"><a href="AllowanceTransView.jsp?startLetter=R">R</a></td>
				<td width="8"><a href="AllowanceTransView.jsp?startLetter=S">S</a></td>
				<td width="8"><a href="AllowanceTransView.jsp?startLetter=T">T</a></td>
				<td width="9"><a href="AllowanceTransView.jsp?startLetter=U">U</a></td>
				<td width="8"><a href="AllowanceTransView.jsp?startLetter=V">V</a></td>
				<td width="14"><a href="AllowanceTransView.jsp?startLetter=W">W</a></td>
				<td width="8"><a href="AllowanceTransView.jsp?startLetter=X">X</a></td>
				<td width="8"><a href="AllowanceTransView.jsp?startLetter=Y">Y</a></td>
				<td width="20"><a href="AllowanceTransView.jsp?startLetter=Z">Z</a></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td height="40">
		<table border="0" align="center" cellpadding="2" cellspacing="2">
			<tr>
				<td width="56"><input class="buttonbold" name="submit2"
					type="submit" onClick=Add() value="Add"></td>
				<td width="56"><input class="buttonbold" name="submit3"
					type="submit" onClick="return Edit();" value="Edit"></td>
				<td width="56"><input class="buttonbold" name="submit3"
					type="Button" onClick="return Delete();" value="Delete"></td>
				<td width="56"><input class="buttonbold" type="submit"
					name="Button"  value="Close"   accesskey="c"  onClick="mainPage()"></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<%@ include file="../footer.jsp"%></form>
</body>

</html>
