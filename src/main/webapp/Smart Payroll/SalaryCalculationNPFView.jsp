<%@ page import="java.sql.*" isErrorPage="false"
	errorPage="./InValidSession.jsp"%>
<%!
	String sql;
%>
<html>
<head>
 

<title> :: PAYROLL ::</title>


 
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="javascript">


	function disableMonthWise()
	{
		document.salfrm.Year.disabled=false;
		document.salfrm.Month.disabled=false;
		document.salfrm.frmdate.disabled=true;
		document.salfrm.todate.disabled=true;
		
	}
	function disableYearWise()
	{
		document.salfrm.Year.disabled=true;
		document.salfrm.Month.disabled=true;
		document.salfrm.frmdate.disabled=false;
		document.salfrm.todate.disabled=false;
	}
	function validate()
	{
		var val=document.getElementById("month1").checked;
		if(val==true)
		{
			if(checkNullSelect("Month","Select Month","0") && checkNullSelect("Year","Select Year","0"))
				return true;
			else
				return false;
		}
		else
		{
			if(checkNull('frmdate','Select From Date') && checkNull('todate','Select From Date'))
				return true;
			else
				return false;
		}
		return false;
	}
	
</script>
</head>
<body  onpaste='return false;'>
<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   name="salfrm" action="../SmartLoginAuth" onSubmit="return validate()">
<table width="47%" height="197" border="1" align="center"
	cellpadding="0" cellspacing="0"  >
	<!--DWLayoutTable-->
	<tr>
		<td width="451" height="195" valign="top">
		<table width="455" height="75% border=" align="right" cellpadding="1"
			cellspacing="1" "  1>
			<!--DWLayoutTable-->
			<tr>
				<td height="26" colspan="2" align="center" valign="middle"
					  class="tablehead">Report Based On</td>
			</tr>
			<tr>
				<td width="204" align=center><input type="radio" id="month1"
					name="reportType" value="Month" onClick="disableMonthWise()"
					checked> MonthWise</td>
				<td width="242" align=center><input type="radio" id="date1"
					name="reportType" value="Date" onClick="disableYearWise()">
				DateWise</td>
			</tr>
			<tr>
				<td align="center">
				<table border="1" cellspacing="1" cellpadding="1"
					 >
					<tr>
						<td>Select Month</td>
						<td><%@ include file="../JavaScript/month.jsp"%>
						</td>
					</tr>
					<tr>
						<td>Select Year</td>
						<td><%@ include file="../JavaScript/year.jsp"%>
						</td>
					</tr>
				</table>
				</td>
				<td align="center">
				<table border="1" cellspacing="1" cellpadding="1"
					 >
					<tr>
						<td>Form Date :</td>
						<td><input name="frmdate" type="text" class="tabledata"
							id="frmdate" onKeyPress="dateOnly('frmdate')" size="18">
						<a href="javascript:cal1.popup();"> <img
							src="../JavaScript/img/cal.gif" width="16" height="16" border="0"
							alt="Click Here to Pick up the date"></a></td>
					<tr>
						<td>To Date :</td>
						<td><input name="todate" type="text" class="tabledata"
							id="todate" onKeyPress="dateOnly('todate')" size="18"> <a
							href="javascript:call1.popup();"> <img
							src="../JavaScript/img/cal.gif" width="16" height="16" border="0"
							alt="Click Here to Pick up the date"></a></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td align="right">Department</td>
				<td><select name="Department" class="tabledata">
					<%
              ArrayList departmentList=(ArrayList) session.getAttribute("departmentList");
  			  for(int i=0;i<departmentList.size();i++)
  			  {
  				  com.my.org.erp.bean.payroll.Department depart= (com.my.org.erp.bean.payroll.Department)departmentList.get(i);
		%>
					<option value="<%= depart.getDepartId() %>">
					<%    	out.println(depart.getDepartName()); 	  %>
					</option>
					<%
			  }
		%>
				</select></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="hidden"
					name="filename" value="SalaryCalculation"> <input
					type="hidden" name="actionS" value="PAYSalaryCalculationNPF">
				<input type="submit" value="Calculate" name="CalculationNPF"
					accesskey="C"> <input type="submit" name="CalculationNPF"
					value="     View     " accesskey="V"></td>
			</tr>
		</table>
		</td>
</table>
<script language="JavaScript">			
<!--
			var cal1 = new calendar1(document.forms['salfrm'].elements['frmdate']);
			cal1.year_scroll = true;
			cal1.time_comp = false;
			var call1 = new calendar1(document.forms['salfrm'].elements['todate']);
			cal1.year_scroll = true;
			cal1.time_comp = false;				
//-->	
</script> <br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<%@ include file="../footer.jsp"%></form>
</body>
</html>
