<%@ page import="java.io.*,java.util.*" isErrorPage="false" errorPage="./error.jsp"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%>

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
@import url("../JavaScript/SmartStyles.css");
-->
</style>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/Inventory/Termsandconditions.js"></script>


 <script language="JavaScript">

    function Add()
	{ 
		document.frm.action="TermsAction.jsp";
 	}

	function Edit()
 	{		
		obj = findObj("rowid"); 
		if(obj == null)
		{
			alert("Edit not available");
			return false;
		}	
		
		var count;
		count=0;
		coffee1=document.forms[0].rowid
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
			if (document.forms[0].rowid.checked) { count=1;}
		}
		if(count==1){			
			document.frm.action="TermsAction.jsp";
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
		obj = findObj("rowid"); 
		if(obj == null)
		{
			alert("Delete not available");
			return false;
		}	
		
		
		var count;
		count=0;
		coffee1=document.forms[0].rowid
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
			if (document.forms[0].rowid.checked) { count=1;}
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
<body onLoad="LoadTermsandconditions('0')" >
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="">
<table width="100%" border="0" cellspacing="1" cellpadding="1">
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
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td><table height="200" border="0" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"  
			 >
              <tr>
                <td height="31"><div align="center" class="whiteMedium">TERMS AND CONDITIONS </div></td>
              </tr>
               
              <tr bgcolor="#FFFFFF">
                <td height="300" valign="top"> 
                    <div id="divscroll" style="OVERFLOW:auto;width:100%;height:200px" 	class="boldEleven">                  </div>
                  <br>
                      <div id ="totRec" align="center"> </div>
                  <br>					</td>
              </tr>
               
              <tr>
                <td><input type="hidden" name="filename" value="Term" />
                    <input
			type="hidden" name="actionS" value="INVtermDelete" /></td>
              </tr>
               
            </table></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td><table width="90%" border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
              <tr class="para">
                <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadTermsandconditions('0')">All</a></div></td>
                <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadTermsandconditions('A')">A</a></div></td>
                <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadTermsandconditions('B')">B</a></div></td>
                <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadTermsandconditions('C')">C</a></div></td>
                <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadTermsandconditions('D')">D</a></div></td>
                <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadTermsandconditions('E')">E</a></div></td>
                <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadTermsandconditions('F')">F</a></div></td>
                <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadTermsandconditions('G')">G</a></div></td>
                <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadTermsandconditions('H')">H</a></div></td>
                <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadTermsandconditions('I')">I</a></div></td>
                <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadTermsandconditions('J')">J</a></div></td>
                <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadTermsandconditions('K')">K</a></div></td>
                <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadTermsandconditions('L')">L</a></div></td>
                <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadTermsandconditions('M')">M</a></div></td>
                <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadTermsandconditions('N')">N</a></div></td>
                <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadTermsandconditions('O')">O</a></div></td>
                <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadTermsandconditions('P')">P</a></div></td>
                <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadTermsandconditions('Q')">Q</a></div></td>
                <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadTermsandconditions('R')">R</a></div></td>
                <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadTermsandconditions('S')">S</a></div></td>
                <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadTermsandconditions('T')">T</a></div></td>
                <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadTermsandconditions('U')">U</a></div></td>
                <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadTermsandconditions('V')">V</a></div></td>
                <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadTermsandconditions('W')">W</a></div></td>
                <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadTermsandconditions('X')">X</a></div></td>
                <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadTermsandconditions('Y')">Y</a></div></td>
                <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadTermsandconditions('Z')">Z</a></div></td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td>
			
			
			  <div align="center">
			    <%
			out.println("<table  border='0' align='center' cellpadding='1' cellspacing='1'>");
			out.println("<tr>");
			 
			
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_ADD_INV FROM m_user_privilege WHERE CHR_USRNAME ='"+session.getAttribute("USRID").toString()+"'")[0][0]))
			{
				out.println("<td   valign='top'>");
				out.println("<input class='ButtonHead' type='submit' onClick='Add()' name='action1' id='action1' value='Add'>");
				out.println("</td>");
			
			}
			else	
			 	out.println("<input type='hidden' name='action1' id='action1' value='Add'>");
			 
			
			
			
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_EDIT_INV FROM m_user_privilege WHERE CHR_USRNAME ='"+session.getAttribute("USRID").toString()+"'")[0][0]))
			{
			 out.println("<td  valign='top'>");
			 out.println("<input class='ButtonHead' type='submit' onClick='return Edit()' name='action1' id='action1' value='Edit'>");	
			 out.println("</td>");
			 
			 }		
			 else	
				out.println("<input type='hidden'  name='Edit' id='Edit' value='Edit'>");
			 
			
			
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_DELETE_INV FROM m_user_privilege WHERE CHR_USRNAME ='"+session.getAttribute("USRID").toString()+"'")[0][0]))
			{
				out.println("<td  valign='top'>");
				out.println("<input class='ButtonHead' type='submit' onClick='return  Delete()' name='Submit' id='Submit' value='Delete'>");
				out.println("</td>");	
			}
			else
			{	
				out.println("<input type='hidden'  name='Delete' id='Delete' value='Delete'>");
				
			}
			
			
			out.println("<td   valign='top'>");
			out.println("<input type='button' class='ButtonHead' name='Button' value='Close' onClick=\"redirect( 'InventoryMains.jsp')\" />");
			out.println("</td>");
			
			out.println("</tr>");	
			out.println("</table>");
			
			%>
	          </div></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td>&nbsp;</td>
          </tr>
        </table>
		<p>&nbsp;</p>
		<%@ include file="../footer.jsp"%></form>
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
