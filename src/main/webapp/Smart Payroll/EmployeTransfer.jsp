<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.bean.Attendance.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%> 


<%
try
{
%>
<%@ include file="index.jsp"%>
<html>
<head>

<title> :: PAYROLL ::</title>


 <style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>


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

 
<script language="JavaScript" src="../JavaScript/comfunction.js"> </script>
<script language="JavaScript" src="../JavaScript/Payroll/PayrollTransfer.js"></script>
<script language="javascript">



function Edit()
{		
	
	try
	{
	
		obj = findObj("staffid"); 
		if(obj == null)
		{
			alert("Edit not available");
			return false;
		}
		
		var count=0;
		var sel=document.forms[0].staffid;
		for(i=0;i<sel.length;i++)
		{
			 if(sel[i].checked)
			 count=count+1;  
		}
		 
		if(count==0)
		{ 	       
		   if(document.forms[0].staffid.checked)
			{ 
				count=1;
			}   
			else{	    
			   alert("Select Record to Edit");
			   return false;
			 }
		}
		if(count>1)
		{
		   alert("Select One Record to Edit");
		   return false
		}
		if(count==1)
		{
			document.frm.action="EmployeTransferEdit.jsp";
			document.frm.submit();
			return true;
		}
	}
	catch(err)
	{
		alert(err);
	}
		
}



function Add()
{		
	
	try
	{
		obj = findObj("staffid"); 
		if(obj == null)
		{
			alert("Add not available");
			return false;
		}
		
		var count=0;
		sel=document.forms[0].staffid;
		for(i=0;i<sel.length;i++)
		{
			 if(sel[i].checked)
			 count=count+1;  
		}
		 
		if(count==0)
		{ 	       
		   if(document.forms[0].staffid.checked)
			{ 
				count=1;
			}   
			else
			{	    
			   alert("Select Record to Add");
			   return false;
			 }
		}
		if(count>1)
		{
		   alert("Select One Record to Edit");
		   return false;
		}
		if(count==1)
		{
			document.frm.action="EmployeTransferAdd.jsp";
			document.frm.submit();
			return true;
		}
	}
	catch(err)
	{
		alert(err);
	}
		
}


	 
	 
 	
	/*function Add()
 	{		
		document.frm.action="EmployeTransferAdd.jsp";		
 	}*/		
	function Delete()
 	{		
		var count;
		count=0;
		c1=document.forms[0].staffid
		txt=""
		for (i=0;i<c1.length;++ i)
		{
			if (c1[i].checked)
			{
			count=count+1;
			}
		}
		if(count==0)
		{
			if (document.forms[0].staffid.checked) { count=1;}
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
	
	
	
		
	function LoadAll()
	{
			var name=confirm("Confirm to Load All Employee")
			if (name==true)
			 	loadTransfer('0')
			else
				document.getElementById('search').focus();
				 
	
	}
	
	
	
	
 	</script>
 
 
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="LoadAll()">
<form   AUTOCOMPLETE = "off"   method="get" name="frm" action="../SmartLoginAuth">
<table width="100%" height="285" align="center">
	<tr>
		<td height="151" align="center"><br>
		<table height="120" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"  
			 >
			<!--DWLayoutTable-->
			<tr align="center" valign="middle" >
				<td height="28"  
					class="whiteMedium">Employee
				Transfer</td>
			</tr>

			<tr  >
			  <td height="31" align="center" valign="middle"  ><table width="400" border="0" align="center" cellpadding="0" cellspacing="0" class="whiteMedium">
                <tr>
                  <td>Search By ID / Name</td>
                  <td><input name="search" type="text" class="formText135" id="search"  onKeyUp="loadTransfers('0')" onBlur="loadTransfers('0')"></td>
                </tr>
              </table></td>
		  </tr>
			 
			<tr bgcolor="#FFFFFF">
				<td height="28" valign="top">
			  <div id="TransferTable"
					style="OVERFLOW: auto;width:100%;height:300px"></div><br>	
					<br>
				<div id="totalrecord" align="center"></div>
				<br> 
							</td>
		</table>		</td>
	</tr>
	<tr>
	  <td height="23">&nbsp;</td>
  </tr>
	<tr>
		<td height="23"><input name="filename" type="hidden"
			id="filename" value="StaffTransfer" /> <input name="actionS"
			type="hidden" id="actionS" value="PAYStaffTransferDelete" />
		<table border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
			<tr class="para">
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadTransfer('0')">All</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadTransfer('A')">A</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadTransfer('B')">B</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadTransfer('C')">C</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadTransfer('D')">D</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadTransfer('E')">E</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadTransfer('F')">F</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadTransfer('G')">G</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadTransfer('H')">H</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadTransfer('I')">I</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadTransfer('J')">J</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadTransfer('K')">K</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadTransfer('L')">L</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadTransfer('M')">M</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadTransfer('N')">N</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadTransfer('O')">O</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadTransfer('P')">P</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadTransfer('Q')">Q</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadTransfer('R')">R</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadTransfer('S')">S</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadTransfer('T')">T</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadTransfer('U')">U</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadTransfer('V')">V</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadTransfer('W')">W</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadTransfer('X')">X</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadTransfer('Y')">Y</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadTransfer('Z')">Z</a></div>				</td>
			</tr>
		</table>		</td>
	</tr>
	<tr>
	  <td height="17" align="center">    
  <tr>
	  <td height="17" align="center">
		<center>
		<div align="center">
          <%
			out.println("<table   border='0' align='center' cellpadding='1' cellspacing='1'>");
			out.println("<tr>");
			 
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_ADD_PAY FROM m_user_privilege WHERE CHR_USRNAME = '"+session.getAttribute("USRID").toString()+"'")[0][0]))
				out.println("<input class='ButtonHead' type='submit' onClick='return Add()' name='action1' id='action1' value='Add'>");
			else	
				out.println("<input type='hidden' name='action1' id='action1' value='Add'>");
			out.println("</td>");
			
			
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_EDIT_PAY FROM m_user_privilege WHERE CHR_USRNAME = '"+session.getAttribute("USRID").toString()+"'")[0][0]))
			 out.println("<input class='ButtonHead' type='submit' onClick='return Edit()' name='action1' id='action1' value='Edit'>");
			else	
				out.println("<input type='hidden'  name='Edit' id='Edit' value='Edit'>");
			out.println("</td>");
			
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_DELETE_PAY FROM m_user_privilege WHERE CHR_USRNAME = '"+session.getAttribute("USRID").toString()+"'")[0][0]))
				out.println("<input class='ButtonHead' type='submit' onClick='return  Delete()' name='Submit' id='Submit' value='Delete'>");
			else	
				out.println("<input type='hidden'  name='Delete' id='Delete' value='Delete'>");
			out.println("</td>");	
			
			out.println("<td ' valign='top'>");
			out.println("<input type='button' class='ButtonHead' name='Button' value='Close' onClick=\"redirect('Payrollmain.jsp')\" />");
			out.println("</td>");
			
			out.println("</tr>");	
			out.println("</table>");
			
			%>
        </div>
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
