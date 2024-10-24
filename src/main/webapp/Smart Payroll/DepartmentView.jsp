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
-->
</style>

<title> :: PAYROLL ::</title>


 
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
	     document.frm.action="Payrollmain.jsp";
		 document.frm.submit();
    }
</script>
</head>
<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   method="get" name='frm'>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<br>
<br>
<br>
<table border=0 width="1002">
	<!--DWLayoutTable-->
	<tr>
		<td width="698"></td>
		<table width="400" align="center" border="1"  >
			<tr>
				<td align="center" width="350" class="BackGround" 
					height="30">Department</td>
			</tr>
			<tr>
				<td>
				<div id="divscroll" style="OVERFLOW:auto;width:400px;height:120px"
					class="boldEleven">
				<table width="100%">
					<tr>
						<td class="bolddeepblue" align="center" bgcolor="#efefef"></td>
					</tr>
					<tr>

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
%>
						<td class="tabledata"><input type="checkbox"
							name="OptDepartName" value='<%=  depart.getDepartId()%>'>
						<%=depart.getDepartName() %></td>
					</tr>

					<%
			}
			String dis="";
			if(departmentList.size()==0) dis="disabled='disabled'";
			//session.removeAttribute("courseList");
			departId=request.getParameter("departId");
      %>
					<input type="hidden" name="filename" value="Department">
					<input type="hidden" name="actionS" value="COM_ATTdepartDelete">
					<input type="hidden" name="msg" value="">
				</table>
				</div>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<center>
<table cellpadding="1" cellspacing="1">
	<tr>
		<td width="56"><input type="submit" class="buttonbold"
			onClick="Add()" name="action1" value="Add"></td>
		<td width="56"><input type="submit" class="buttonbold" <%=dis %>
			onClick="return Edit()" name="action1" value="Edit"></td>
		<td width="56"><input type="submit" class="buttonbold" <%=dis %>
			onClick="return Delete()" value="Delete"></td>
		<td width="56"><input class="buttonbold" type="submit"
			name="Submit"  value="Close"   accesskey="c"  onClick="mainPage()"></td>
	</tr>
</table>
</center>
</form>
<br>
<br>
<br>
<br>
<br>
<%@ include file="../footer.jsp"%>

</body>
</html>

