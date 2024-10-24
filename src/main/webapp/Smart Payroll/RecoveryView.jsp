<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title> :: PAYROLL ::</title>



<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/Payroll/Recoverys.js"></script>


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
			if (document.forms[0].rowid.checked)
			 { count=1;	}
		}
 	    if(count==0)
 	    {
 	        alert("Select Recovery to Edit");
 	        return false; 
 	    }
 	    	    
 	    if(count==1)
 	    {
     	    document.frm.action="RecoveryAction.jsp";
	     	document.frm.submit();
            return true;
 	    }
 	    else
 	    {
 	        alert("Select One Recovery");
 	        return false; 
 	    }
 }
	function Add()
 	{		
         
		document.frm.action="RecoveryAction.jsp";
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
<body  onpaste='return false;'  onLoad="loadRecoverys('0')">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td> <%@ include file="index.jsp"%></td>
  </tr>
  <tr>
    <td></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td> <table border="0" align="center" cellpadding="0"
	cellspacing="0" class="TableDesign"  
	 >
      <tr>
        <td   height="32" align="center" valign="middle">RECOVERY</td>
      </tr>
      <tr class="MRow1">
        <td><div id="payTable" style="OVERFLOW:auto;width:100%;height:300px"></div>
            <br>
            <div id="totalrecord" align="center"></div>
          <br>
        </td>
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
        <td><div align="center"><a class="whiteMedium" href="javascript:loadRecoverys('0')">ALL</a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:loadRecoverys('A')">A</a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:loadRecoverys('B')">B</a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:loadRecoverys('C')">C</a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:loadRecoverys('D')">D</a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:loadRecoverys('E')">E</a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:loadRecoverys('F')">F</a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:loadRecoverys('G')">G</a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:loadRecoverys('H')">H</a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:loadRecoverys('I')">I</a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:loadRecoverys('J')">J</a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:loadRecoverys('K')">K</a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:loadRecoverys('L')">L</a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:loadRecoverys('M')">M</a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:loadRecoverys('N')">N</a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:loadRecoverys('O')">O</a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:loadRecoverys('P')">P</a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:loadRecoverys('Q')">Q</a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:loadRecoverys('R')">R</a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:loadRecoverys('S')">S</a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:loadRecoverys('T')">T</a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:loadRecoverys('U')">U</a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:loadRecoverys('V')">V</a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:loadRecoverys('W')">W</a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:loadRecoverys('X')">X</a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:loadRecoverys('Y')">Y</a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:loadRecoverys('Z')">Z</a></div></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><TABLE BORDER="0" ALIGN="CENTER">
      <TR>
        <td width="56"><input class="ButtonHead" type="submit"
			name="action1" id="action1"   value="Add"   accesskey="s"   onClick=Add() ></td>
        <td width="56"><input class="ButtonHead" type="submit"
			name="action12" id="action12" value="Edit" onClick="return Edit()"></td>
        <td width="56"><input class="ButtonHead" type="button"
			name="Button" id="Submit"  value="Close"   accesskey="c"  onclick="redirect('Payrollmain.jsp')"></td>
      </tr>
    </table></td>
  </tr>
  
  <tr>
    <td><%@ include file="../footer.jsp"%></td>
  </tr>
</table>
 

</body>
</html>

  <%	
 
}
catch(Exception e)
{
	System.out.println(e.getMessage());
}
%>
