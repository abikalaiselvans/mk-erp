<%@ page import="java.io.*,java.util.*" isErrorPage="false" 	errorPage="./error.jsp"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%> 
<%
try
{
%>

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
<script language="javascript" src="../JavaScript/smartcommon/BankBranchAjax.js"></script>


<script language="javascript">    
	function RDelete()
 	{		
		obj = findObj("id"); 
		if(obj == null)
		{
			alert("Delete not available");
			return false;
		}


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
				document.frm.submit();
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
	
	
 	function  Edit()
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
			document.frm.action="BankBranchAction.jsp";
			document.frm.submit();
			return true;
		}
		else
		{
		    alert("Select Only one Value");
		    return false;
		}
 	}
	function Add()
 	{				
		document.frm.action="BankBranchAction.jsp";
		document.frm.submit();
 	}
 	 
</script>

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



<form  AUTOCOMPLETE = "off"   method="get" name='frm' action="../SmartLoginAuth" >
<body  onpaste="return false;" onLoad="loadBankBranch('0')" >
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
			  <td height="30" align="center"  class="whiteMedium">BANK BRANCH </td>
		  </tr>
			<tr>
			  <td height="30" align="center"  class="whiteMedium"><table width="294" border="0" cellpadding="0" cellspacing="0" class="whiteMedium">
                <tr>
                  <td>Bank</td>
                  <td>
				  <select name="bank" id="bank"    onChange="loadBankBranch('0')">
				  	<option value="0"> Select Bank</option>
					<%
		 			
	String BData[][] = CommonFunctions.QueryExecute("SELECT INT_BANKGROUPID,CHR_BANKGROUPNAME,CHR_SHORTNAME FROM com_m_bankgroup  ORDER BY CHR_BANKGROUPNAME");
	if (BData.length>0)
		for (int i=0; i<BData.length; i++) 
			out.println("<option value="+BData[i][0]+">"+BData[i][1] +"</option>");			
	
	
					%>
                  </select>
<script language="javascript">setOptionValue('bank','<%=request.getParameter("bank")%>'); </script>                  </td>
                </tr>
              </table></td>
		  </tr>
		 
			<tr class="MRow1"  >
				<td >
				
				<div id="BankTable" style="OVERFLOW:auto;width:100%;height:300px"></div><br>
				<div id="totrec"  > </div><br>					</td>
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
          <td><div align="center"><a class="whiteMedium" href="javascript:loadBankBranch('0')">ALL</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadBankBranch('A')">A</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadBankBranch('B')">B</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadBankBranch('C')">C</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadBankBranch('D')">D</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadBankBranch('E')">E</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadBankBranch('F')">F</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadBankBranch('G')">G</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadBankBranch('H')">H</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadBankBranch('I')">I</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadBankBranch('J')">J</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadBankBranch('K')">K</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadBankBranch('L')">L</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadBankBranch('M')">M</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadBankBranch('N')">N</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadBankBranch('O')">O</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadBankBranch('P')">P</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadBankBranch('Q')">Q</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadBankBranch('R')">R</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadBankBranch('S')">S</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadBankBranch('T')">T</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadBankBranch('U')">U</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadBankBranch('V')">V</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadBankBranch('W')">W</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadBankBranch('X')">X</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadBankBranch('Y')">Y</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadBankBranch('Z')">Z</a></div></td>
        </tr>
      </table></td>
  </tr>
	<tr>
	  <td><input type="hidden" name="filename"	value="BankBranch">
      <input type="hidden" name="actionS"	value="GENBankBranchDelete"></td>
  </tr>
	<tr>
		<td>
		  <div align="center">
            <%
			out.println("<table   border='0' align='center' cellpadding='1' cellspacing='1'>");
			out.println("<tr>");
			 
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_ADD_GEN FROM m_user_privilege WHERE CHR_USRNAME = '"+session.getAttribute("USRID").toString()+"'")[0][0]))
				out.println("<input class='ButtonHead' type='submit' onClick='Add()' name='action1' id='action1' value='Add'>");
			else	
				out.println("<input type='hidden' name='action1' id='action1' value='Add'>");
			out.println("</td>");
			
			
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_EDIT_GEN FROM m_user_privilege WHERE CHR_USRNAME = '"+session.getAttribute("USRID").toString()+"'")[0][0]))
			 out.println("<input class='ButtonHead' type='submit' onClick='return Edit()' name='action1' id='action1' value='Edit'>");
			else	
				out.println("<input type='hidden'  name='Edit' id='Edit' value='Edit'>");
			out.println("</td>");
			
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_DELETE_GEN FROM m_user_privilege WHERE CHR_USRNAME ='"+session.getAttribute("USRID").toString()+"'")[0][0]))
				out.println("<input class='ButtonHead' type='submit' onClick='return  RDelete()' name='Submit' id='Submit' value='Delete'>");
			else	
				out.println("<input type='hidden'  name='Delete' id='Delete' value='Delete'>");
			out.println("</td>");	
			
			out.println("<td ' valign='top'>");
			out.println("<input type='button' class='ButtonHead' name='Button' value='Close' onClick=\"redirect('commonmain.jsp')\" />");
			out.println("</td>");
			
			out.println("</tr>");	
			out.println("</table>");
			
			%>
          </div></td>
	</tr>
</table>



<%@ include file="../footer.jsp"%>

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



