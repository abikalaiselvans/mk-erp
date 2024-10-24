<%@ page import="java.io.*,java.util.*" isErrorPage="false"
	errorPage="./error.jsp"%>

<%!
	String desigId,desigName;
%>
<%@ page import="com.my.org.erp.bean.Designation"%>
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

 
<style type="text/css">
<!--
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
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>

<title> :: PAYROLL ::</title>


 
<script language="javascript">    
	function Delete()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].OptDesigName
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
			if (document.forms[0].OptDesigName.checked) { count=1;}
		}
		if(count>=1){			
			var name=confirm("Confirm to Delete")
			if (name==true)
			{ 
				document.frm.action="../SmartLoginAuth";
				//document.frm.submit();
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
 	function Edit()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].OptDesigName
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
			if (document.forms[0].OptDesigName.checked) { count=1;}
		}
		if(count==1){			
			document.frm.action="DesignationAction.jsp";
		//	document.frm.submit();
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
		document.frm.action="DesignationAction.jsp";
//		document.frm.submit();
 	}
 	function mainPage()
	{
	 document.frm.action="../RemoveSession";
    }
</script>
</head>

<form  AUTOCOMPLETE = "off"   method="get" name='frm'>
<body  onpaste='return false;'>
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td><%@ include file="index.jsp"%></td>
	</tr>
	<tr>
		<td height="74">&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table width="400" align="center" border="1"  >
			<tr>
				<td align="center" width="350" class="BackGround" 
					height="30">Designation</td>
			</tr>
			<tr>
				<td>
				<div id="divscroll" style="OVERFLOW:auto;width:400px;height:120px">
				<table class="400" cellpaddding="1" cellspacing="1" border="0">
					<tr>
						<td class="bolddeepblue" align="center" bgcolor="#efefef"></td>
					</tr>
					<tr>
						<td>
						<% 

String bgcolor1="#ccccc";	
int count=1;
			ArrayList designationList=(ArrayList) session.getAttribute("designationList");
			for(int i=0;i<designationList.size();i++)
			{
				Designation designation= (Designation)designationList.get(i);
				if(count%2==0)
					out.print("<tr class='MRow1'>");
				else
				    out.print("<tr  class='MRow2'>");			
	 	 	 	count++;
%>
						
						<td width="394" class="bolddeepblue"><input type="checkbox"
							name="OptDesigName" value='<%= designation.getDesigId()%>'>
						<%=designation.getDesigName() %></td>
					</tr>
					<%
			}
			String dis="";
			if(designationList.size()==0) dis="disabled='disabled'";
			//session.removeAttribute("courseList");
			desigId=request.getParameter("desigId");
%>
					<input type="hidden" name="filename" value="Designation">
					<input type="hidden" name="actionS" value="COM_PAYdesigDelete">
					<input type="hidden" name="msg" value="">
				</table>
				</div>
				</td>
			</tr>
		</table>
	<tr>
		<td align="center">
		<table width="224" border="0" cellspacing="1" cellpadding="1">
			<tr>
				<td width="56"><input class="buttonbold" type="submit"
					onClick="Add()" name="action1" value="Add"></td>
				<td width="56"><input class="buttonbold" type="submit"
					<%=dis %> onClick="return Edit()" name="action1" value="Edit"></td>
				<td width="56"><input name="submit" type="submit"
					class="buttonbold" onClick="return Delete()" value="Delete"
					<%=dis %>></td>
				<td width="56"><input class="buttonbold" type="submit"
					name="Submit"  value="Close"   accesskey="c"  onClick="mainPage()"></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="74">&nbsp;</td>
	</tr>
	<tr>
		<td><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
</form>
</body>
</html>
