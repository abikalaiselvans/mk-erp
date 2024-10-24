<%@ page import="java.io.*,java.util.*"%>
<%@ include file="index.jsp"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="com.my.org.erp.bean.Department"%>
<html>
<head>

<title> :: PAYROLL ::</title>


 
 
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

<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript"
	src="../JavaScript/Attendance/ReportAjax.js"></script>
<script language="JavaScript">
  function Validate()
  {
  	if(checkNullSelect("Department","Select The Department","select")){
  		document.a.action="../SmartLoginAuth";
		document.a.submit();
		return true;
	}
	return false;
  }
  function mainPage()
  {
     document.a.action="../RemoveSession";
   	document.a.submit();
  }
 
</script>
<style type="text/css">
<!--
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
</head>
<form  AUTOCOMPLETE = "off"   name="a" method="post">
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<br>
<br>
<br>
<br>
<br>
<%
	String fname="Report";
	String actS="COM_ATTdepartList";
	String viewType=request.getParameter("view");
	viewType=viewType.trim();
	if(viewType.equalsIgnoreCase("MusterRoll"))
	{
		fname="MusterRoll";
		actS="ATTmusterMonth";
	}
	else if(viewType.equalsIgnoreCase("Allowance"))
	{
		fname="Allowance";
		actS="PAYAllowanceView";
	}
	//System.out.println("JSP VIEW"+viewType);
%>
<table width="1002">
	<!--DWLayoutTable-->
	<tr>
		<td width="965" height="61" valign="top">
		<table class="BackGround" cellspacing="0" cellpadding="0" width="390"
			align="center" border="0">
			<tbody>
				<tr>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/Smart Inventory/TLCorner.gif" width="7" /></td>
					<td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/Smart Inventory/TRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
				</tr>
				<tr>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
					<td width="6"><spacer height="1" width="1" type="block" /></td>
					<td width="412">

					<table width="434" border="0" align="center"  >
						<!--DWLayoutTable-->
						<tr align="center" valign="middle">
							<td height="23" colspan="2" class="BackGround" ><%=viewType %>
							Details - Department Wise</td>
						</tr>
						<tr>
							<td width="162" height="28" valign="middle" class="tabledata">
							Company</td>
							<td width="247"><select name="company" id="company"
								onChange="loadBranch()" class="tabledata" style="width:200px">
								<%                  
     					String queryBranch1="SELECT * FROM  com_m_company ";
     					String	branch1[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(queryBranch1);
     					for(int i=0;i<branch1.length;i++)
 	 						out.println("<option value='"+branch1[i][0]+"'>"+branch1[i][1]+"</option>");
 			   %>
							</select></td>
						</tr>
						<tr>
							<td width="162" height="28" valign="middle" class="tabledata">
							Branch</td>
							<td width="247"><select name="branch" id="branch"
								class="tabledata" style="width:200px">
								<option value="-1">All</option>
							</select></td>
						</tr>
						<tr>
							<td height="28" valign="middle" class="tabledata">Department</td>
							<td valign="top"><select name="Department" class="tabledata"
								style="width:200px">
								<option value="-1">All</option>
								<%               
            ArrayList departmentList=(ArrayList) session.getAttribute("departmentList");
			String s="";
  			for(int i=0;i<departmentList.size();i++)
  			{
  				Department depart= (Department)departmentList.get(i);
				
		  %>
								<option value="<%= depart.getDepartId() %>">
								<% out.println(depart.getDepartName()); %>
								</option>
								<%
		    }
    	  %>
							</select></td>
						</tr>
						<tr>
							<td height="28" colspan="2" valign="middle" class="tabledata">
							<div align="center">
							<table border="0" cellspacing="3" cellpadding="0">
								<tr>
									<td width="56"><input name="Submit" type="submit"
										class="buttonbold14" value="Submit"   accesskey="s"   
										onClick="return Validate()"></td>
									<td width="56"><input name="Button" type="Button"
										class="buttonbold14" onClick="redirect('Payrollmain.jsp')"
										 value="Close"   accesskey="c" ></td>
								</tr>
							</table>
							</div>
							</td>
						</tr>
					</table>

					</td>
					<td nowrap="nowrap" width="4"><spacer height="1" width="1"
						type="block" /></td>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/Smart Inventory/BLCorner.gif" width="7" /></td>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/Smart Inventory/BRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
			</tbody>
		</table>
		<td width="13">
	</tr>
</table>
                               
<br>
<center>
<table width="15%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>&nbsp;</td>
		<td width="10"></td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td><input type="hidden" name="actionS" value="<%=actS %>">
		<input type="hidden" name="filename" value="<%= fname %>"></td>
		<td><input type="hidden" name="view" value="<%=viewType%>"></td>
	</tr>
</table>
</center>
<p><br>
                                                                       <%@ include
	file="../footer.jsp"%></p>
</body>
</form>
</html>
