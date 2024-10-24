<%@ page contentType="text/html; charset=iso-8859-1" language="java" 	import="java.sql.*" errorPage=""%>
<html>
<head>
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

<title> :: MARKETING ::</title>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/Marketing/EnquiryEntry.js"></script>
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
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %> 
<link href="../JavaScript/SmartStyles.css" rel="stylesheet" type="text/css">
</head>
<script language="JavaScript">

    function GAdd()
	{ 
		document.frm.action="CustomerEnquiryAction.jsp";
	}

	function GEdit()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].id
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
			document.frm.action="CustomerEnquiryEdit.jsp";
			return true;
		}
		else
		{
		    alert("Select Only one Value");
		    return false;
		}
 	}	

 	function RDelete()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].id
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
		if(count>=1){			
			var name=confirm("Confirm to Delete")
			if (name==true)
			{ 
				document.frm.action="../SmartLoginAuth";
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
<body onselectstart="return false" onpaste="return false;" onCopy="return false"    onLoad="LoadEnquiryEntry('0')" >
<%@ include file="index.jsp"%>

<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="get" name="frm">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
	  <td><table width="90%" height="200" border="0" align="center" cellpadding="0" cellspacing="0" class="TableDesign">
	  	
        <tr>
          <td height="31"><div align="center" class="whiteMedium">Customer Enquiry </div></td>
        </tr>
        <tr  >
          <td height="31" align="center" valign="top"  ><table width="554" border="0" align="center" cellpadding="2"
					cellspacing="2" class="whiteMedium">
           
			
          </table>
		<table width="100%">  
		   <tr>
				  <td width="8%" align="center" ><font color="#FFFFFF">S.No</font></td>
				  <td width="23%" align="center" ><font color="#FFFFFF">CustomerName</font> </td>
				  <td width="23%" align="center"><font color="#FFFFFF">Subject</font></td>
				  <td width="23%" align="center"><font color="#FFFFFF">CallReceived</font></td>
				  <td width="23%" align="center"><font color="#FFFFFF">Assign To </font></td>
			</tr>
		</table>
		  </td>
        </tr>
         
         
        <tr class="MRow1">
          <td >
		  <div id="GroupTable" style="OVERFLOW:auto;width:100%x;height:300px" class="boldEleven"></div>
		  <br><div id="totalrec"></div> <br></td>
        </tr>
         
	     
      </table></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td><table width="90%" border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
          <tr class="para">
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadEnquiryEntry('0')">All</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadEnquiryEntry('A')">A</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadEnquiryEntry('B')">B</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadEnquiryEntry('C')">C</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadEnquiryEntry('D')">D</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadEnquiryEntry('E')">E</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadEnquiryEntry('F')">F</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadEnquiryEntry('G')">G</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadEnquiryEntry('H')">H</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadEnquiryEntry('I')">I</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadEnquiryEntry('J')">J</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadEnquiryEntry('K')">K</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadEnquiryEntry('L')">L</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadEnquiryEntry('M')">M</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadEnquiryEntry('N')">N</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadEnquiryEntry('O')">O</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadEnquiryEntry('P')">P</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadEnquiryEntry('Q')">Q</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadEnquiryEntry('R')">R</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadEnquiryEntry('S')">S</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadEnquiryEntry('T')">T</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadEnquiryEntry('U')">U</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadEnquiryEntry('V')">V</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadEnquiryEntry('W')">W</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadEnquiryEntry('X')">X</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadEnquiryEntry('Y')">Y</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadEnquiryEntry('Z')">Z</a></div></td>
          </tr>
        </table></td>
	</tr>
	<tr>
	  <td>&nbsp;</td>
    </tr>
	<tr>
	  <td><span class="boldEleven">
      <input type="hidden" name="filename" value="EnquiryCustomerInfo" />
      <input type="hidden" name="actionS" value="MKTEnquiryEntryDelete" />
      </span></td>
    </tr>
	<tr>
		<td><table width="224" border="0" align="center" cellpadding="1"
			cellspacing="1">
          <!--DWLayoutTable-->
          <tr>
            <td width="56" valign="top"><input type="submit" class="ButtonHead"  name="action1" id="Add"  value="Add"   accesskey="s"   onClick="GAdd()" /></td>
            <td width="56" valign="top"><input type="submit" class="ButtonHead" name="Edit" id="Edit" value="Edit"  onclick="return GEdit()" /></td>
            <%
	  String usertype=""+session.getAttribute("USRTYPE");
	  if("F".equals(usertype))
	  {
	  %>
            <td width="56" valign="top"><input type="submit" class="ButtonHead" name="Submit" id="Delete" value="Delete" onClick="return RDelete()" /></td>
            <%
		}
		%>
            <td width="56"><input type="button" class="ButtonHead" name="Close"  value="Close"   accesskey="c"  onClick="redirect('MarketingMain.jsp')" /></td>
          </tr>
        </table></td>
	</tr>
</table>
</form>
<%@ include file="../footer.jsp"%>
</body>
</html>
