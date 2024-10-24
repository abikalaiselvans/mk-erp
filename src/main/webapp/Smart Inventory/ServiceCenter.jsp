<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.*"%>
<%
try
{
%>
<html>
<head>
<title>:: INVENTORY ::</title><link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>



<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>

<style type="text/css">
<!--
.style3 {font-size: 10px}
-->
</style>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="javascript" src="../JavaScript/Inventory/InvenAJAX.js"></script>
<script language="javascript" src="../JavaScript/Inventory/ServiceCenter.js"></script>
<script language="JavaScript">

    function Add()
	{ 
		document.frm.action="ServiceCenterAction.jsp";
 	}
	
	function IEdit()
 	{		 
		var count;
		count=0;
		coffee1=document.forms[0].id
		txt=""
		for (i=0;i<frm.length;++ i)
		{
			if (frm[i].checked)
			{
			count=count+1;
			}
		}
		if(count==0)
		{
			if (document.forms[0].id.checked) { count=1;}
		}
		if(count==1){			
			document.frm.action="ServiceCenterAction.jsp";
			return true;
		}
		else
		{
		    alert("Select Only one Value");
		    return false;
		}
		
 	}	
 	
	
	function Delete()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].id
		txt=""
		for (i=0;i<frm.length;++ i)
		{
			if (frm[i].checked)
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
<body    onLoad="LoadServiceCenter('0')">
<%@ include file="indexinv.jsp"%>

   <form  AUTOCOMPLETE = "off"   name="frm" method="post" action="">
  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
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
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>
	 
	  	  <table width="90%" height="176" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"  
			 >
        <tr  >
          <td height="22"  ><div align="center"><span class="boldThirteen">SERVICE CENTER </span></div>
              <div align="right"></div></td>
        </tr>
        <tr  >
          <td height="25"  >
	
		  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="whiteMedium">
			<tr  >
  				<td  ><b>S.No</b></td>
    			<td  ><b>Name</b> </td>
				<td  ><b>Short Name</b> </td>
				<td  ><b>Mobile</b> </td>
				<td  ><b>Email</b> </td>
			</tr> 
		  </table>		  </td>
        </tr>
        <tr class="MRow1">
          <td height="127" valign="top"  >
		  <div id="divscroll" style="OVERFLOW:auto;width:100%;height:300px" 	class="boldEleven"> </div>
		  <br>
		  <div align="center" id="totRec"></div>
		  <br>
		   </td>
        </tr>
      </table></td>
    </tr>
    <tr>
      <td>	  </td>
    </tr>
    <tr>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td><table width="90%" border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
        <tr class="para">
          <td ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceCenter('0')">All</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceCenter('A')">A</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceCenter('B')">B</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceCenter('C')">C</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceCenter('D')">D</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceCenter('E')">E</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceCenter('F')">F</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceCenter('G')">G</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceCenter('H')">H</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceCenter('I')">I</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceCenter('J')">J</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceCenter('K')">K</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceCenter('L')">L</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceCenter('M')">M</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceCenter('N')">N</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceCenter('O')">O</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceCenter('P')">P</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceCenter('Q')">Q</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceCenter('R')">R</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceCenter('S')">S</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceCenter('T')">T</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceCenter('U')">U</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceCenter('V')">V</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceCenter('W')">W</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceCenter('X')">X</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceCenter('Y')">Y</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceCenter('Z')">Z</a></div></td>
        </tr>
      </table></td>
    </tr>
    <tr>
      <td><input name="filename" type="hidden" value="ServiceCenter" />
        <input name="actionS" type="hidden" value="INVServiceCenterDelete" /></td>
    </tr>
    <tr>
      <td><table width="224" border="0" align="center" cellpadding="1"
			cellspacing="1">
        <!--DWLayoutTable-->
        <tr>
          <td width="56" valign="top"><input type="submit"
					class="ButtonHead" name="action1"  value="Add"   accesskey="s"   onClick="Add()" /></td>
          <td width="56" valign="top"><input type="submit"
					class="ButtonHead" name="Edit" id="Edit" value="Edit"
					onclick="return IEdit()" /></td>
          <%
	  String usertype=""+session.getAttribute("USRTYPE");
	  if("F".equals(usertype))
	  {
	  %>
          <td width="56" valign="top"><input type="submit"
					class="ButtonHead" name="Submit3" value="Delete"
					onclick="return Delete()" /></td>
          <% 
		}
		%>
          <td width="56"><input type="button" class="ButtonHead"
					name="submit"  value="Close"   accesskey="c"  onClick="redirect( 'InventoryMains.jsp')" /></td>
        </tr>
      </table></td>
    </tr>
</table>
  </form>

<%@ include file="../footer.jsp"%>
</body>
</html>
<%
}
catch(Exception e)
{
}

%>