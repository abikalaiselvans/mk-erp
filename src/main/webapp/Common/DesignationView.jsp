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
<meta name="copyright"
	content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords"
	content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />


<style type="text/css">
<!--
.style8 {
	font-family: Verdana;
	font-size: 12px;
}

.style9 {
	color: #FFFFFF
}

.style10 {
	font-family: Verdana;
	font-size: 12px;
	color: #FFFFFF;
}

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
<title><%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='COM' ")[0][0]%></title>
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
<%@ include file="../JavaScript/dynamicStylesheet.jsp"%>
</head>

<form AUTOCOMPLETE="off" method="get" name='frm'><%@ include
	file="insert.jsp"%> <input name="path"
	type="hidden" value="<%=path%>"> <input name="qp" type="hidden"
	value="<%=qp%>">

<body onpaste="return false;" leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td></td>
	</tr>
	<tr>
		<td height="84">&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table width="90%" border="0" align="center" cellpadding="0"
			cellspacing="0" class="TableDesign">
			<tr>
				<td height="30" align="center" class="whiteMedium">DESIGNATION</td>
			</tr>
			<tr>
				<td align="center" width="350" height="30">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="35%" class="whiteMedium">S.NO</td>
						<td width="65%" class="whiteMedium">DESIGNATION</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td>

				<div id="divscroll"
					style="OVERFLOW: auto; width: 100%; height: 250px">
				<table width='100%' class='boldEleven' id='myTable' cellpadding=2
					cellspacing=1 bgcolor='#9900CC'>
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
	 	 	 	out.println("<td width='50' class='tabledata'>"+(i+1)+". <input type='checkbox' name='OptDesigName' value='"+designation.getDesigId()+"'>");
	 	 	 	out.println("<td width='394' class='bolddeepblue'>");	

				 
				out.println("<a href=DesignationAction.jsp?OptDesigName="+designation.getDesigId()+"&qp=ATT&action1=Edit><font class='boldEleven'>"+designation.getDesigName()+"</font></a>");
				out.println("</td></tr>");
			}
			String dis="";
			if(designationList.size()==0) dis="disabled='disabled'";
			//session.removeAttribute("courseList");
			desigId=request.getParameter("desigId");
%>
				</table>
				</div>
				<br>
				<br>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td><input type="hidden" name="filename" value="Designation">
		<input type="hidden" name="actionS" value="COM_ATTdesigDelete">
		<input type="hidden" name="msg" value=""></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table align="center" cellpadding="1" cellspacing="1">
			<tr>
				<td width="56"><input class="ButtonHead" type="submit"
					onClick="Add()" name="action1" value="Add"></td>
				<td width="56"><input class="ButtonHead" type="submit"
					<%=dis %> onClick="return Edit()" name="action1" value="Edit"></td>

				<%
	  String usertype=""+session.getAttribute("USRTYPE");
	  if("F".equals(usertype))
	  {
	  %>
				<td width="56"><input name="submit" type="submit"
					class="ButtonHead" onClick="return Delete()" value="Delete"
					<%=dis %>></td>
				<%
	   }
	   %>
				<td width="56"><input class="ButtonHead" type="submit"
					name="Submit" value="Close" accesskey="c" onClick="mainPage()"></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td height="85">&nbsp;</td>
	</tr>
	<tr>
		<td><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
</form>
</body>
</html>
