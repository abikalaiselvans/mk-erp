<%@ page import="java.io.*,java.util.*" isErrorPage="false" errorPage="./error.jsp"%>
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.bean.Attendance.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%> 
<%@ include file="index.jsp"%>
<%
try
{
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
<script language="JavaScript" src="../JavaScript/Payroll/NDCFinalAccept.js"></script>

<script language="javascript">

 	 

function SEdit()
{	
	try
	{	
		
		
		obj = findObj("Rowid"); 
		if(obj == null)
		{
			alert("Records not available");
			return false
		}	
		
		var count;
		count=0;
		coffee1=document.forms[0].Rowid;
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
			if (document.forms[0].Rowid.checked) { count=1;}
		}
		if(count==1)
		{			
			document.frm.action="NDC_FinalAccept.jsp";
			return true;
		}
		else
		{
			alert("Select Only one Value");
			return false;
		}
	}
	catch(err)
	{
		alert(err.description);
		return false;
	}	
}

	 
 	</script>
 
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
 
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="LoadNDCFinalAccept('0')">
<form  AUTOCOMPLETE = "off"   method="get" name="frm">
<table width="100%" height="285" align="center">


	<tr>
		<td height="151" align="center"><br>
		<table width="90%" height="120" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign" 
			 >
			 
			 
			<tr align="center" valign="middle"  >
				<td height="28"    
					class="tablehead"><span class="whiteMedium">NDC FINAL </span></td>
			</tr>

			<tr  >
			  <td height="31" align="center" valign="middle" class="boldEleven"><table width="765" border="0" align="center" cellpadding="5" cellspacing="5" class="whiteMedium">
                <tr>
                 <td width="40" >Month</td>
                    <td width="52"  >
					<select name="month" id="month" onChange="LoadNDCFinalAccept('0')">
					<option value="0">All</option>
                      <%@ include file="../JavaScript/months.jsp"%>
                    </select>				  </td>
                    <td width="32"  >Year</td>
                  <td width="44"  ><select name="year" id="year"  onChange="LoadNDCFinalAccept('0')">
                      <%@ include file="../JavaScript/years.jsp"%>
                    </select>
                  <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						var day=d.getDate();
						 
						setOptionValue('month',month1);
						setOptionValue('year',year1);							
				//-->
                      </script></td>
                  <td width="73">Status</td>
                  <td width="93"><select name="status" id="status" onChange="LoadNDCFinalAccept('0')"  class="formText135" >
                      <option value="0">All</option>
                      <option value="Y">Close</option>
                      <option value="N">Not Close</option>
                    </select>
                  </td>
                  <td width="174">Search Id / Name </td>
                  <td width="132"><input name="search" type="text" class="formText135" id="search" onBlur="LoadNDCFinalAccepts('0')"   onKeyUp="LoadNDCFinalAccepts()" size="20" maxlength="8"></td>
                </tr>
              </table></td>
		  </tr>
			<tr  >
			  <td height="31" align="left" valign="middle" class="boldEleven"><table width="100%" border="0" class="whiteMedium"
					  >
                 
                <tr>
                  <td align="center">S.No</td>
                  <td align="center">Staff Id</td>
                  <td align="center">Staff Name</td>
                  <td align='Center'>Company</td>
                  <td align='Center'>Branch</td>
                  <td align='Center'>Department</td>
                  <td align='Center'>Designation</td>
                  <td align='Center'>Entry Date</td>
                  <td align='Center'>Status</td>
			    </tr>
              </table></td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td height="28" valign="top">
				<div id="RecordTable" style="OVERFLOW: auto;width:100%;height:300px"></div>
				 <br>
			  <div id="totRec"></div>	<br>					</td>
		</table>		</td>
	</tr>
	<tr>
		<td height="17">&nbsp;  </td>
	</tr>
	<tr>
		<td height="17">
		<table border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
			<tr class="para">
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadNDCFinalAccept('0')">All</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadNDCFinalAccept('A')">A</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadNDCFinalAccept('B')">B</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadNDCFinalAccept('C')">C</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadNDCFinalAccept('D')">D</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadNDCFinalAccept('E')">E</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadNDCFinalAccept('F')">F</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadNDCFinalAccept('G')">G</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadNDCFinalAccept('H')">H</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadNDCFinalAccept('I')">I</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadNDCFinalAccept('J')">J</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadNDCFinalAccept('K')">K</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadNDCFinalAccept('L')">L</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadNDCFinalAccept('M')">M</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadNDCFinalAccept('N')">N</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadNDCFinalAccept('O')">O</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadNDCFinalAccept('P')">P</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadNDCFinalAccept('Q')">Q</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadNDCFinalAccept('R')">R</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadNDCFinalAccept('S')">S</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadNDCFinalAccept('T')">T</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadNDCFinalAccept('U')">U</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadNDCFinalAccept('V')">V</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadNDCFinalAccept('W')">W</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadNDCFinalAccept('X')">X</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadNDCFinalAccept('Y')">Y</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadNDCFinalAccept('Z')">Z</a></div>				</td>
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
					type="submit" onClick="return SEdit()" value="Accept"></td>
				
				  
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
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
	System.out.println(e.getMessage());
}
%>
