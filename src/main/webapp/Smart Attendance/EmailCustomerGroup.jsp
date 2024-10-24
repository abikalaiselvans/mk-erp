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


<title> :: ATTENDANCE ::</title>


<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/Attendance/EmailCustomerGroup.js"></script>
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
</head>
<script language="JavaScript">

    function GAdd()
	{ 
		document.frm.action="EmailCustomerGroupAction.jsp";
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
			document.frm.action="EmailCustomerGroupAction.jsp";
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
<body  onpaste="return false;" onLoad="LoadEmailCustomerGroup('0')" >
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
	  <td><table width="90%" height="200" border="0" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"  
			 >
        <tr>
          <td height="31"><div align="center" class="whiteMedium">MAIL CUSTOMER GROUP </div></td>
        </tr>
        <tr>
          <td height="31"><table width="100%" border="0" cellpadding="1" cellspacing="1" class="whiteMedium">
              <tr>
                <td width="14%"  >S.No</td>
                <td width="50%" align="left"  ><div align="left">Group</div></td>
                <td width="28%" align="left"  >Creation Date </td>
                <td width="8%" align="left"  >Active</td>
              </tr>
          </table></td>
        </tr>
         
        <tr bgcolor="#FFFFFF">
          <td class="bolddeepblue">
		  <div id="GroupTable" style="OVERFLOW:auto;width:100%x;height:auto" class="boldEleven"></div> <br>
		  <br><div id="totalrec"></div>		  </td>
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
					href="javascript:LoadEmailCustomerGroup('0')">All</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadEmailCustomerGroup('A')">A</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadEmailCustomerGroup('B')">B</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadEmailCustomerGroup('C')">C</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadEmailCustomerGroup('D')">D</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadEmailCustomerGroup('E')">E</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadEmailCustomerGroup('F')">F</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadEmailCustomerGroup('G')">G</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadEmailCustomerGroup('H')">H</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadEmailCustomerGroup('I')">I</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadEmailCustomerGroup('J')">J</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadEmailCustomerGroup('K')">K</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadEmailCustomerGroup('L')">L</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadEmailCustomerGroup('M')">M</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadEmailCustomerGroup('N')">N</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadEmailCustomerGroup('O')">O</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadEmailCustomerGroup('P')">P</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadEmailCustomerGroup('Q')">Q</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadEmailCustomerGroup('R')">R</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadEmailCustomerGroup('S')">S</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadEmailCustomerGroup('T')">T</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadEmailCustomerGroup('U')">U</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadEmailCustomerGroup('V')">V</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadEmailCustomerGroup('W')">W</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadEmailCustomerGroup('X')">X</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadEmailCustomerGroup('Y')">Y</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadEmailCustomerGroup('Z')">Z</a></div></td>
          </tr>
        </table></td>
	</tr>
	<tr>
	  <td>&nbsp;</td>
    </tr>
	<tr>
	  <td><span class="boldEleven">
      <input type="hidden" name="filename" value="EmailCustomerGroup" />
      <input type="hidden" name="actionS" value="ATTEmailCustomerGroupDelete" />
      </span></td>
    </tr>
	<tr>
		<td><table width="224" border="0" align="center" cellpadding="1"
			cellspacing="1">
          <!--DWLayoutTable-->
          <tr>
            <td width="56" valign="top"><input type="Submit" class="ButtonHead" name="action1" id="Add"  value="Add"   accesskey="s"   onClick="GAdd()" /></td>
            <td width="56" valign="top"><input type="submit"
					class="ButtonHead" name="Edit" id="Edit" value="Edit"  
					onclick="return GEdit()" /></td>
            <%
	  String usertype=""+session.getAttribute("USRTYPE");
	  if("F".equals(usertype))
	  {
	  %>
            <td width="56" valign="top"><input type="submit"
					class="ButtonHead" name="Submit" id="Delete" value="Delete"  
					onclick="return RDelete()" /></td>
            <%
		}
		%>
            <td width="56"><input type="Button" class="ButtonHead"
					name="submit"  value="Close"   accesskey="c"  onClick="redirect('AttendanceMain.jsp')" /></td>
          </tr>
        </table></td>
	</tr>
</table>
</form>
<%@ include file="../footer.jsp"%>
</body>
</html>
