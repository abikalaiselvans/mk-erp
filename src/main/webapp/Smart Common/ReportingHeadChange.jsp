<%@ page import="java.io.*,java.util.*" isErrorPage="false" 	errorPage="./error.jsp"%>

<html>
 

<title> :: COMMON ::</title>


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
 

<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/smartcommon/ReportingHead.js"></script>


<script language="javascript">    
	 
	
 	function CEdit()
 	{		
		obj = findObj("id"); 
		if(obj == null)
		{
			alert("Edit not available");
			return false;
		}


		var count;
		count=0;
		coffee1=document.forms[0].id;
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
			if (document.forms[0].id.checked) { count=1;}
		}
		if(count==1){			
			document.frm.action="ReportingHeadAction.jsp";
			document.frm.submit();
			return true;
		}
		else
		{
		    alert("Select Only one Value");
		    return false;
		}
 	}
	 

function reportingHeadChange()
{  
	try
	{ 
		var width="800", height="400";
		var left = (screen.width/2) - width/2;
		var top = (screen.height/2) - height/2;
		var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=yes,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
	
		newWindow = window.open("Reportingto.jsp","subWind",styleStr);
		newWindow.focus( );
		window.close();
	}
	catch(err)
	{
		alert(err);
	}
}

 	 
</script>

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



<form  AUTOCOMPLETE = "off"   method="get" name='frm' >
<body  onpaste="return false;" onLoad=" loadReportingHead('0')">
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
			  <td height="30" align="center"  class="whiteMedium">EMPLOYEE REPORTING HEAD </td>
		  </tr>
			<tr>
			  <td height="30" align="center"  class="whiteMedium"><table  border="0" align="center" cellpadding="0"
					cellspacing="2" class="whiteMedium">
			    <tr>
			       
			      <td ><div align="right"><span >Search by Name / ID </span></div></td>
			      <td   ><input name="searchstaff" id="searchstaff" type="text" class="formText135" size="15" maxlength="10" onKeyUp="loadReportingHeads()"></td>
			      <td   >&nbsp;</td> 
			      <td   ><a href="javascript:reportingHeadChange()" ><font class='whiteMedium'>Bulk Change</font></a></td>
		        </tr>
		      </table></td>
		  </tr>
			<tr>
				<td height="30" align="center">
				<table width="100%" border="0" align="center"   class="whiteMedium">
                  <tr>
                    <td width="9%"><div align="center">S.No</div></td>
                    <td width="15%"><div align="center">EMP ID</div></td>
                    <td width="24%"><div align="center">NAME </div></td>
				    <td width="23%"><div align="center">OFFICE</div></td>
				    <td width="29%"><div align="center">REPORTING HEAD </div></td>
                  </tr>
              </table></td>
			</tr>
			<tr class="MRow1"  >
				<td >
				
				<div id="loadReportingHeadTable" style="OVERFLOW:auto;width:100%;height:300px"></div><br>
				<div id="totrec"  > </div><br>	<br>					</td>
		  </tr>
		</table>		</td>
	</tr>

	<tr>
	  <td>&nbsp;</td>
  </tr>
	<tr>
	  <td><table width="90%" border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign">
        <tr class="para">
          <td><div align="center"><a class="whiteMedium" href="javascript:loadReportingHead('0')">ALL</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadReportingHead('A')">A</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadReportingHead('B')">B</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadReportingHead('C')">C</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadReportingHead('D')">D</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadReportingHead('E')">E</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadReportingHead('F')">F</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadReportingHead('G')">G</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadReportingHead('H')">H</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadReportingHead('I')">I</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadReportingHead('J')">J</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadReportingHead('K')">K</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadReportingHead('L')">L</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadReportingHead('M')">M</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadReportingHead('N')">N</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadReportingHead('O')">O</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadReportingHead('P')">P</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadReportingHead('Q')">Q</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadReportingHead('R')">R</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadReportingHead('S')">S</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadReportingHead('T')">T</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadReportingHead('U')">U</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadReportingHead('V')">V</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadReportingHead('W')">W</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadReportingHead('X')">X</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadReportingHead('Y')">Y</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadReportingHead('Z')">Z</a></div></td>
        </tr>
      </table></td>
  </tr>
	<tr>
	  <td>&nbsp;</td>
  </tr>
	<tr>
		<td>
		<table   align="center">
			<tr>
				 
				<td width="56">
				<div align="center"><input class="ButtonHead" type="submit"  name="Edit"   id="Edit" value="Edit" onClick="return CEdit()">
				</div>				</td>
				 
				<td width="56">
				<div align="center"><input class="ButtonHead" type="button"
					name="Button"  value="Close"   accesskey="c"  onClick="redirect('commonmain.jsp')"></div>				</td>
			    <td width="69"  ><input type="hidden" name="filename"	value="Bank">
		        <input type="hidden" name="actionS"	value="GENBankDelete"></td>
			</tr>
		</table>		</td>
	</tr>
</table>



<%@ include file="../footer.jsp"%>

</body>
</html>



