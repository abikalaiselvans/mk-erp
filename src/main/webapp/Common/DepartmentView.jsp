<%@ page import="java.io.*,java.util.*"%>
<%!
	String departId,departName;
%>
<%@ page import="com.my.org.erp.bean.Department"%>
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
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">    
	function Delete()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].OptDepartName
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
			if (document.forms[0].OptDepartName.checked) { count=1;}
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
 	function Edit()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].OptDepartName
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
			if (document.forms[0].OptDepartName.checked) { count=1;}
		}
		if(count==1){			
			document.frm.action="DepartmentAction.jsp";
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
		document.frm.action="DepartmentAction.jsp";
		document.frm.submit();
 	}
    function mainPage()
	{
	     document.frm.action="../RemoveSession";
    }
</script>
<%@ include file="../JavaScript/dynamicStylesheet.jsp"%>
</head>

<form AUTOCOMPLETE="off" method="get" name='frm'><%@ include
	file="insert.jsp"%>

<body onpaste="return false;" leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0">
<table border=0 width="100%">
	<!--DWLayoutTable-->
	<tr>
		<td height="21"><!--DWLayoutEmptyCell-->&nbsp;</td>
	</tr>
	<tr>
		<td height="21"><!--DWLayoutEmptyCell-->&nbsp;</td>
	</tr>
	<tr>
		<td height="21"><!--DWLayoutEmptyCell-->&nbsp;</td>
	</tr>
	<tr>
		<td height="156">
		<table width="90%" border="0" align="center" cellpadding="0"
			cellspacing="0" class="TableDesign">
			<tr>
				<td height="30" align="center" class="whiteMedium">DEPARTMENT</td>
			</tr>
			<tr>
				<td align="center" width="350" height="30">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="35%" class="whiteMedium">S.NO</td>
						<td width="65%" class="whiteMedium">DEPARTMENT</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td bgcolor="#FFFFFF">
				<div id="divscroll"
					style="OVERFLOW: auto; width: 100%; height: 250px"
					class="boldEleven">
				<table width='100%' class='boldEleven' id='myTable' cellpadding=2
					cellspacing=1 bgcolor='#9900CC'>

					<% 
			String bgcolor1="#ccccc";			
			ArrayList departmentList=(ArrayList) session.getAttribute("departmentList");			
				int count=1;  
			for(int i=0;i<departmentList.size();i++)
			{
				Department depart= (Department)departmentList.get(i);
				if(count%2==0)
					out.print("<tr class='MRow1'>");
				else
				    out.print("<tr  class='MRow2'>");			
	 	 	 	count++;
	 	 	 	
	 	 	 	out.println("<td width='50' class='tabledata'>"+(i+1)+". <input type='checkbox' name='OptDepartName' value='"+depart.getDepartId()+"'>");
	 	 	 	out.println("<td class='tabledata'>");
    	
    out.println("<a href=DepartmentAction.jsp?OptDepartName="+depart.getDepartId()+"&action1=Edit&path=Smart+Attendance%2Findex.jsp&qp=ATT><font class='boldEleven'>"+depart.getDepartName()+"</font></a>");
    out.println("</td></tr>");

%>




					<%
			}
			String dis="";
			if(departmentList.size()==0) dis="disabled='disabled'";
			 
			departId=request.getParameter("departId");
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
		<td height="21"><input type="hidden" name="filename"
			value="Department"> <input type="hidden" name="actionS"
			value="COM_ATTdepartDelete"> <input type="hidden" name="msg"
			value=""> <input name="path" type="hidden" value="<%=path%>">
		<input name="qp" type="hidden" value="<%=qp%>"></td>
	</tr>
	<tr>
		<td height="53">
		<table align="center" cellpadding="1" cellspacing="1">
			<tr>
				<td width="56"><input type="submit" class="ButtonHead"
					onClick="Add()" name="action1" value="Add"></td>
				<td width="56"><input type="submit" class="ButtonHead"
					<%=dis %> onClick="return Edit()" name="action1" value="Edit">
				</td>
				<%
	 String usertype=""+session.getAttribute("USRTYPE");
	  if("F".equals(usertype))
	  {
	  %>
				<td width="56"><input type="submit" class="ButtonHead"
					<%=dis %> onClick="return Delete()" value="Delete"></td>
				<%
	}
	%>
				<td width="56"><input class="ButtonHead" type="button"
					name="Submit" value="Close" accesskey="c"
					onClick="redirect('<%=closefile%>')" /></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<%@ include file="../footer.jsp"%>
</body>
</html>

