<%@ page import="java.io.*,java.util.*"%>
<%@ page errorPage="../errorpge.jsp"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<%!
	String userId,stateName,disName,consName,sql;
	boolean bgflag=false;  	         
	boolean buttonflag = false;
%>
<%@include file="Redirect.jsp" %>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.ResultSet"%>
<html>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/utility/Utility.js"></script>
<head>

<title> :: UTILITY :: </title>


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
-->
</style>
 <script language="javascript">    
	function Delete()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].loginName
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
			if (document.forms[0].loginName.checked) { count=1;}
		}
		if(count>=1){			
			var name=confirm("Confirm to Delete")
			if (name==true)
			{ 
				document.frm.action="UserDelete.jsp";
				//document.frm.submit();
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
 	function Edit1()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].loginName
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
			if (document.forms[0].loginName.checked) { count=1;}
		}
	if(count==1){			
				document.frm.action="UserEdit.jsp";
				//document.frm.submit();
				return true;						
		}
		else
		{
		    alert("Select Atleast One Value");
		    return false;
		}		
 	}
	
 	
</script>
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head><!-- onLoad="loadAllStaff('0')"-->
<body  onpaste='return false;'>
<%
try
{		
%>
<form name="frm" method="get">
<br><br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td> </td>
	</tr>
	<tr>
		<td align="center">
		  <table width="600" height="227" align="center"
			cellpadding="1" cellspacing="1" class="TableDesign"  >
			<tr  >
				<td align="center"   class="copyright">
				<table border="0" align="center" cellpadding="2"
					cellspacing="2" class="whiteMedium">
					<tr>
						<td  ><strong>Search by Employee Name</strong></td>
						<td  ><input name="search" type="text"
							class="formText135" id="search" size="15"
							onKeyUp="loadAllStaff('0')"></td>
						<td  ><strong>Category</strong></td>
						<td  >
						<select name="category" class="formText135" id="category" onChange="loadAllStaff('0')">
							<option value="0">All</option>
							<option value="F">Super Admin</option>
							<option value="B">Branch Admin</option>
							<option value="A">Admin</option>
							<option value="S">Employee</option>
						</select></td>
					</tr>
			  </table>			  </td>
			</tr>
			<tr  >
				<td   class="copyright">
				<table width="600" border="0" cellpadding="0" cellspacing="0" class="whiteMedium">
					<tr>
						<td width="220"  ><strong>Employee name</strong></td>
						<td width="160"  ><strong>Employee Id</strong></td>
						<td width="160"  ><strong>User Name</strong></td>
						<td width="160"  ><strong>User Type</strong></td>
						<td width="100"  ><strong>Status</strong></td>
					</tr>
				</table>				</td>
			</tr>
			<tr class="MRow1">
				<td height="204" align="center" valign="top">


				<div id="StafTable" style="OVERFLOW: auto;width:100%;height:250px">				</div>
				<br>
				<div id="totRec"></div>	<br>			</td>
			</tr>
		</table>	  </td>
	</tr>
	<tr>
	  <td height="25" align="center">&nbsp;</td>
    </tr>
	<tr>
		<td height="25" align="center">
		<table width="800" border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign">
			<tr class="para">
				<td width="9"><a  class="whiteMedium"   href="javascript:loadAllStaff('0')">All</a></td>
				<td width="9"><a class="whiteMedium" href="javascript:loadAllStaff('A')">A</a></td>
				<td width="8"><a class="whiteMedium" href="javascript:loadAllStaff('B')">B</a></td>
				<td width="9"><a class="whiteMedium" href="javascript:loadAllStaff('C')">C</a></td>
				<td width="9"><a class="whiteMedium" href="javascript:loadAllStaff('D')">D</a></td>
				<td width="8"><a class="whiteMedium" href="javascript:loadAllStaff('E')">E</a></td>
				<td width="8"><a class="whiteMedium" href="javascript:loadAllStaff('F')">F</a></td>
				<td width="9"><a class="whiteMedium" href="javascript:loadAllStaff('G')">G</a></td>
				<td width="9"><a class="whiteMedium" href="javascript:loadAllStaff('H')">H</a></td>
				<td width="6"><a class="whiteMedium" href="javascript:loadAllStaff('I')">I</a></td>
				<td width="6"><a class="whiteMedium" href="javascript:loadAllStaff('J')">J</a></td>
				<td width="8"><a class="whiteMedium" href="javascript:loadAllStaff('K')">K</a></td>
				<td width="7"><a class="whiteMedium" href="javascript:loadAllStaff('L')">L</a></td>
				<td width="10"><a class="whiteMedium" href="javascript:loadAllStaff('M')">M</a></td>
				<td width="9"><a class="whiteMedium" href="javascript:loadAllStaff('N')">N</a></td>
				<td width="10"><a class="whiteMedium" href="javascript:loadAllStaff('O')">O</a></td>
				<td width="8"><a class="whiteMedium" href="javascript:loadAllStaff('P')">P</a></td>
				<td width="10"><a class="whiteMedium" href="javascript:loadAllStaff('Q')">Q</a></td>
				<td width="8"><a class="whiteMedium" href="javascript:loadAllStaff('R')">R</a></td>
				<td width="8"><a class="whiteMedium" href="javascript:loadAllStaff('S')">S</a></td>
				<td width="8"><a class="whiteMedium" href="javascript:loadAllStaff('T')">T</a></td>
				<td width="9"><a class="whiteMedium" href="javascript:loadAllStaff('U')">U</a></td>
				<td width="8"><a class="whiteMedium" href="javascript:loadAllStaff('V')">V</a></td>
				<td width="14"><a class="whiteMedium" href="javascript:loadAllStaff('W')">W</a></td>
				<td width="8"><a class="whiteMedium" href="javascript:loadAllStaff('X')">X</a></td>
				<td width="8"><a class="whiteMedium" href="javascript:loadAllStaff('Y')">Y</a></td>
				<td width="20"><a class="whiteMedium" href="javascript:loadAllStaff('Z')">Z</a></td>
			</tr>
		</table>		</td>
	</tr>
	<tr>
	  <td height="25" align="center">&nbsp;</td>
    </tr>
	<tr>
		<td height="25" align="center">

		<center>
		<table align="center" cellpadding="1" cellspacing="1">
			<tr>

				<td width="56"><input class="ButtonHead" type="submit"
					name="Edit" id="Edit" onClick="return Edit1()" value="Edit"></td>
				<td width="56"><input name="Button" type="button" class="ButtonHead" onClick="redirect('Userframe.jsp')"
					 value="Close"   accesskey="c" ></td>
			</tr>
		</table>
		</center>		</td>
	</tr>
</table>
</table>
</td>
</tr>
<tr>
	<td height="20"></td>
</tr>
<tr>
	<td>&nbsp;</td>
</tr>
<tr>
	<td height="20"></td>
</tr>
<tr>
	<td></td>
</tr>
<tr>
	<td height="40">&nbsp;</td>
</tr>
 </table>
</form>
</body>
<%
  	}
	catch(Exception er)
	{
		//System.out.print(er.getMessage());
	}

%>

</html>
