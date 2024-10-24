<%@ page import="java.io.*,java.util.*"%>
<%
try
{
%>

<html>
<head>

<title> :: PAYROLL ::</title>


 
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/Payroll/Allowance.js"></script>
<script language="javascript"> 	
 	function Edit()
 	{		
 	    
		obj = findObj("rowid"); 
		if(obj == null)
		{
			alert("Edit not available");
			return false;
		}
		var count=0;
 	    sel=document.forms[0].rowid
 	   
 	    for(i=0;i<sel.length;i++)
 	    {
 	       if(sel[i].checked)
 	       count=count+1; 
 	    }
 	    if(count==0)
		{
			if (document.forms[0].rowid.checked) { count=1;	}
		}
 	    if(count==0)
 	    {
 	        alert("Select Allowance to Edit");
 	        return false; 
 	    }
 	    
 	    if(count==1)
 	    {
     	    document.frm.action="AllowanceAction.jsp";
	    	document.frm.submit();
	    	return true;
 	    }
 	    else
 	    {
 	        alert("Select One Allowance to Edit");
 	        return false; 
 	    }
	}
	
	
	function Add()
 	{		
		document.frm.action="AllowanceAction.jsp";
		document.frm.submit();
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
@import url("../JavaScript/SmartStyles.css");
-->
</style>

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>

<form  AUTOCOMPLETE = "off"   method="get" name='frm'>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadAllowances('0')">
 <%@ include file="index.jsp"%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td> </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>
	<table border="0" align="center" cellpadding="0"
	cellspacing="0" class="TableDesign"  
	 >
      <tr>
        <td   height="32" align="center" valign="middle">ALLOWANCE</td>
      </tr>
       
      <tr class="MRow1">
        <td>
		
		 
					<div id="payTable" style="OVERFLOW:auto;width:100%;height:300px"></div>
				<br>
				<div id="totalrecord" align="center"></div>
				<br>        </td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><table width="90%" border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign">
      <tr class="para">
        <td><div align="center"><a class="whiteMedium" href="javascript:loadAllowances('0')">ALL</a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:loadAllowances('A')">A</a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:loadAllowances('B')">B</a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:loadAllowances('C')">C</a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:loadAllowances('D')">D</a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:loadAllowances('E')">E</a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:loadAllowances('F')">F</a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:loadAllowances('G')">G</a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:loadAllowances('H')">H</a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:loadAllowances('I')">I</a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:loadAllowances('J')">J</a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:loadAllowances('K')">K</a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:loadAllowances('L')">L</a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:loadAllowances('M')">M</a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:loadAllowances('N')">N</a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:loadAllowances('O')">O</a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:loadAllowances('P')">P</a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:loadAllowances('Q')">Q</a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:loadAllowances('R')">R</a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:loadAllowances('S')">S</a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:loadAllowances('T')">T</a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:loadAllowances('U')">U</a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:loadAllowances('V')">V</a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:loadAllowances('W')">W</a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:loadAllowances('X')">X</a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:loadAllowances('Y')">Y</a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:loadAllowances('Z')">Z</a></div></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>	</td>
  </tr>
  
  
  
  <tr>
    <td><table align="center">
      <tr>
        <td width="56"><input class="ButtonHead" type='submit'
					name="action1" id="action1"   value="Add"   accesskey="s"   onClick=Add()  ></td>
        <td width="56"><input class="ButtonHead" type="submit"
					name="action1" value="Edit" onClick="return Edit()"></td>
        <td width="56"><input class="ButtonHead" type="button"
					name="Button"  value="Close"   accesskey="c"  onClick="redirect('Payrollmain.jsp')"></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td>  	</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td> <%@ include file="../footer.jsp"%></td>
  </tr>
</table>
 
 


</body>
</form>
</html>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>
