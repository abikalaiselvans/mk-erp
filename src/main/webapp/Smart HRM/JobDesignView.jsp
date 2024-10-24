<%@ page import="java.io.*,java.util.*" isErrorPage="false"  %>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%> 


<%
try
{
%>


<%!
	String batchName;
    int batchId,companyId;
%>
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

 
 <script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/HRM/jobdesignAjax.js"></script>


<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
.style8 {
	font-family: Verdana;
	font-size: 12px;
}
.style9 {color: #FFFFFF}
.style10 {font-family: Verdana; font-size: 12px; color: #FFFFFF; }
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

<title>:: HRM ::</title>



<script language="javascript">    

	function Delete()
 	{	
	
		obj = findObj("rowid"); 
		if(obj == null)
		{
			alert("Delete not available");
			return false;
		}	
			
 	    
		var chkbox = document.forms[0].rowid;
		var leng = 0;
		var ch = 0;
		
		for (i=0; i<chkbox.length; i++)
		{
			if (chkbox[i].checked)
			{
				ch = i;
				leng++;
			}
		}


		if (leng == 0)
		{
			if (chkbox.checked)
			{
				document.frm.action="../SmartLoginAuth";
				return true;
			}
			else
			{
				alert ("Select Any one Value");
				return false;		
			}
		}
		else if (leng >= 1)
		{
			var name = confirm ("Confirm to Delete ?");
			if (name == true)
			{
				document.frm.action="../SmartLoginAuth";
				return true;
			}
			else
			{
				return false;
			}
		}
				
		
 	}  
	
	function Edit()
	{
		
		obj = findObj("rowid"); 
		if(obj == null)
		{
			alert("Edit not available");
			return false;
		}	
		
		var chkbox = document.forms[0].rowid;
		var leng = 0;
		var ch = 0;
		
		for (i=0; i<chkbox.length; i++)
		{
			if (chkbox[i].checked)
			{
				ch = i;
				leng++;
			}
		}

		if (leng > 1)
		{
		    alert ("Select Only one Value");
    		return false;		
		}
		else if (leng == 0)
		{
		
			if (chkbox.checked)
			{
				document.frm.action="JobDesignAction.jsp";
				return true;
			}
			else
			{
				alert ("Select Any one Value");
				return false;		
			}
		}
		else
		{
			document.frm.action="JobDesignAction.jsp";
			return true;
		}
	}
	
		

	function Add()
 	{				
		document.frm.action="JobDesignAction.jsp";		
 	}
 	function mainPage()
	{
		document.frm.action="HRMmain.jsp";				
    }
	
</script>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head><!---->

<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad=" LoadJobGrade('0'),document.getElementById('jobGrade').focus()">
<%@ include file="indexhrm.jsp" %>
<form  AUTOCOMPLETE = "off" method="post" name='frm'> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
    <td>&nbsp;</td>
  </tr>
  
  <tr>
    <td><table width="90%" height="200" border="0" align="center" cellpadding="0" cellspacing="0" class="TableDesign0">
      <tr  >
        <td   height="31"   ><table width="346" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td class="whiteMedium"> Job Grade </td>
            <td><select name="jobGrade" id="jobGrade" onChange="LoadJobGrade('0')">
              <option value="0">All</option>
			  <option value="Top">Group-1</option>
              <option value="Middle">Group-2</option>
              <option value="Bottom">Group-3</option>
            </select></td>
          </tr>
        </table></td>
      </tr>
      <tr   >
        <td height="31"   ><div align="center">
          <table width="100%" border="0" cellpadding=2 cellspacing=1 >            
            <tr >
              <td class="whiteMedium" width='20%'   ><div align="center">Job Code</div></td>
              <td class="whiteMedium"  width='20%' ><div align="center">Job Title</div></td>
              <td class="whiteMedium"  width='20%' ><div align="center">Education</div></td>
              <td class="whiteMedium"  width='20%' ><div align="center">Scale</div></td>
              <td class="whiteMedium"  width='20%' ><div align="center">Experience</div></td>                           
            </tr>
          </table>
        </div></td>
      </tr>
       <tr bgcolor="#FFFFFF">
        <td height="127" valign="top" >
		 
		<br>	
		<div id="divscroll" style="OVERFLOW:auto;width:100%;height:250px" class="boldEleven">
		  <div id="GradeTable" ></div>
		</div>
		<br>	
		<div align="center" id="totRec"></div>
		<br>		 </td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><input type="hidden" name="filename" value="JobDesign">
      <input type="hidden" name="actionS" value="HRMjobDesignDelete"></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><table width="90%" border="0" align="center" cellpadding="1" cellspacing="1" class="TableDesign0">
      <tr class="para">
        <td><div align="center"><a class="whiteMedium" href="javascript:LoadJobGrade('0')" > All </a></div></td>
	    <td><div align="center"><a class="whiteMedium" href="javascript:LoadJobGrade('A')"> A </a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:LoadJobGrade('B')"> B </a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:LoadJobGrade('C')"> C </a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:LoadJobGrade('D')"> D </a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:LoadJobGrade('E')"> E </a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:LoadJobGrade('F')"> F </a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:LoadJobGrade('G')"> G </a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:LoadJobGrade('H')"> H </a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:LoadJobGrade('I')"> I </a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:LoadJobGrade('J')"> J </a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:LoadJobGrade('K')"> K </a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:LoadJobGrade('L')"> L </a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:LoadJobGrade('M')"> M </a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:LoadJobGrade('N')"> N </a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:LoadJobGrade('O')"> O </a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:LoadJobGrade('P')"> P </a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:LoadJobGrade('Q')"> Q </a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:LoadJobGrade('R')"> R </a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:LoadJobGrade('S')"> S </a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:LoadJobGrade('T')"> T </a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:LoadJobGrade('U')"> U </a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:LoadJobGrade('V')"> V </a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:LoadJobGrade('W')"> W </a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:LoadJobGrade('X')"> X </a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:LoadJobGrade('Y')"> Y </a></div></td>
        <td><div align="center"><a class="whiteMedium" href="javascript:LoadJobGrade('Z')"> Z </a></div></td>
          </tr>
    </table></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr> 
  <tr>
    <td><div align="center">
      <%
			out.println("<table   border='0' align='center' cellpadding='1' cellspacing='1'>");
			out.println("<tr>");
			 
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_ADD_HRM FROM m_user_privilege WHERE CHR_USRNAME = '"+session.getAttribute("USRID").toString()+"'")[0][0]))
				out.println("<input class='ButtonHead' type='submit' onClick='Add()' name='action1' id='action1' value='Add'>");
			else	
				out.println("<input type='hidden' name='action1' id='action1' value='Add'>");
			out.println("</td>");
			
			
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_EDIT_HRM FROM m_user_privilege WHERE CHR_USRNAME = '"+session.getAttribute("USRID").toString()+"'")[0][0]))
			 out.println("<input class='ButtonHead' type='submit' onClick='return Edit()' name='action1' id='action1' value='Edit'>");
			else	
				out.println("<input type='hidden'  name='Edit' id='Edit' value='Edit'>");
			out.println("</td>");
			
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_DELETE_HRM FROM m_user_privilege WHERE CHR_USRNAME ='"+session.getAttribute("USRID").toString()+"'")[0][0]))
				out.println("<input class='ButtonHead' type='submit' onClick='return  Delete()' name='Submit' id='Submit' value='Delete'>");
			else	
				out.println("<input type='hidden'  name='Delete' id='Delete' value='Delete'>");
			out.println("</td>");	
			
			out.println("<td ' valign='top'>");
			out.println("<input type='button' class='ButtonHead' name='Button' value='Close' onClick=\"redirect('HRMmain.jsp')\" />");
			out.println("</td>");
			
			out.println("</tr>");	
			out.println("</table>");
			
			%>
    </div></td>
  </tr>
</table>
 <%@ include file="../footer.jsp"%>
</form>
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