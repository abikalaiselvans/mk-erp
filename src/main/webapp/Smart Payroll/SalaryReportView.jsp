<%@ page import="java.sql.*" isErrorPage="false"
	errorPage="./InValidSession.jsp"%>
<%! String sql; %>
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
	function mainPage()
	{
	    document.salfrm.action="PayBill Details.jsp";
		document.salfrm.submit();
		return true;
    }
</script>
</head>
<%@ include file="index.jsp"%>
<body  onpaste='return false;'>
<form  AUTOCOMPLETE = "off"   name="salfrm" action="../SmartLoginAuth">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="111">
		<%String view =request.getParameter("view");%> <input type="hidden"
			name="view" value="<%= view %>"></td>
	</tr>
	<tr>
		<td height="186">
		<table height="190" border="0" align="center" cellpadding="0"
			cellspacing="0"  >
			<!--DWLayoutTable-->
			<tr>
				<td height="188" valign="top">
				<table class="BackGround" cellspacing="0" cellpadding="0"
					width="390" align="center" border="0">
					<tbody>
						<tr>
							<td colspan="2" rowspan="2" valign="top"><img height="7"
								src="../Image/Smart Inventory/TLCorner.gif" width="7" /></td>
							<td class="BorderLine" height="0"><spacer height="1"
								width="1" type="block" /></td>
							<td colspan="2" rowspan="2" valign="top"><img height="7"
								src="../Image/Smart Inventory/TRCorner.gif" width="7" /></td>
						</tr>
						<tr>
							<td height="6"><spacer height="1" width="1" type="block" /></td>
						</tr>
						<tr>
							<td width="1" height="220" class="BorderLine"><spacer
								height="1" width="1" type="block" /></td>
							<td width="6"><spacer height="1" width="1" type="block" /></td>
							<td width="412">





							<table width="455" height="100%" align="right" cellpadding="1"
								cellspacing="1"  >
								<!--DWLayoutTable-->
								<tr>
									<td height="26" colspan="2" align="center" valign="middle"
										class="BackGround" >Pay Bill Report</td>
								</tr>
								<tr>
									<td width="202" height="35" align=center class="boldgre">
									<div align="center" class="bolddeepblue"><input
										type="radio" id="month1" name="reportType" value="Month"
										onClick="disableMonthWise()" checked> MonthWise</div>
									</td>
									<td width="240" align=center class="boldgre">
									<div align="center" class="bolddeepblue"><input
										type="radio" id="date1" name="reportType" value="Date"
										onClick="disableYearWise()"> DateWise</div>
									</td>
								</tr>
								<tr>
									<td align="center">
									<table border="1" cellspacing="1" cellpadding="1"
										 >
										<tr>
											<td class="bolddeepblue">Select Month</td>
											<td><%@ include file="../JavaScript/month.jsp"%>
											</td>
										</tr>
										<tr>
											<td class="bolddeepblue">Select Year</td>
											<td><%@ include file="../JavaScript/year.jsp"%>
											</td>
										</tr>
									</table>
									</td>
									<td align="center">
									<table border="1" cellspacing="1" cellpadding="1"
										 >
										<tr>
											<td class="bolddeepblue">Form</td>
											<td><input name="frmdate" type="text"
												class="bolddeepblue" id="frmdate"
												onKeyPress="dateOnly('frmdate')" size="18"> <a
												href="javascript:cal1.popup();"> <img
												src="../JavaScript/img/cal.gif" width="16" height="16"
												border="0" alt="Click Here to Pick up the date"></a></td>
										<tr>
											<td class="bolddeepblue">To</td>
											<td><input name="todate" type="text"
												class="bolddeepblue" id="todate"
												onKeyPress="dateOnly('todate')" size="18"> <a
												href="javascript:call1.popup();"> <img
												src="../JavaScript/img/cal.gif" width="16" height="16"
												border="0" alt="Click Here to Pick up the date"></a></td>
										</tr>
									</table>
									</td>
								</tr>
								<tr>
									<td height="67" align="right" class="bolddeepblue">
									<div align="right">Department</div>
									</td>
									<td><select name="Department" class="bolddeepblue">
										<option value="-1">ALL</option>
										<%	
              ArrayList departmentList=(ArrayList) session.getAttribute("departmentList");
  			  for(int i=0;i<departmentList.size();i++)
  			  {
  				com.my.org.erp.bean.Department depart= (com.my.org.erp.bean.Department)departmentList.get(i);
		%>
										<option value="<%= depart.getDepartId() %>">
										<%    	out.println(depart.getDepartName()); 	  %>
										</option>
										<%
			  }
		%>
									</select> <input type="hidden" name="filename" value="SalaryCalculation">
									<input type="hidden" name="actionS"
										value="PAYSalaryCalculationNPF"></td>
								<tr>
									<td height="36" colspan="2" valign="top">
									<table width="127" border="0" align="center" cellpadding="2"
										cellspacing="2">
										<!--DWLayoutTable-->
										<tr valign="top">
											<td width="56" height="28"><input type="submit"
												class="buttonbold14" name="CalculationNPF" value="View"
												accesskey="V" onClick="return validate()"></td>
											<td width="56" valign="top"><input class="buttonbold14"
												type="submit" name="Submit"  value="Close"   accesskey="c" 
												onClick="mainPage()"></td>
										</tr>
									</table>
									</td>
								</tr>
							</table>

							</td>
							<td nowrap="nowrap" width="4"><spacer height="1" width="1"
								type="block" /></td>
							<td class="BorderLine" width="1"><spacer height="1"
								width="1" type="block" /></td>
						</tr>
						<tr>
							<td colspan="2" rowspan="2"><img height="7"
								src="../Image/Smart Inventory/BLCorner.gif" width="7" /></td>
							<td height="6"><spacer height="1" width="1" type="block" /></td>
							<td colspan="2" rowspan="2"><img height="7"
								src="../Image/Smart Inventory/BRCorner.gif" width="7" /></td>
						</tr>
						<tr>
							<td class="BorderLine" height="0"><spacer height="1"
								width="1" type="block" /></td>
						</tr>
					</tbody>
				</table>

				</td>
		</table>
		</td>
	</tr>
	<tr>
		<td></td>
	</tr>
	<tr>
		<td height="23"><script language="JavaScript">			
<!--
			var cal1 = new calendar1(document.forms['salfrm'].elements['frmdate']);
			cal1.year_scroll = true;
			cal1.time_comp = false;
			var call1 = new calendar1(document.forms['salfrm'].elements['todate']);
			cal1.year_scroll = true;
			cal1.time_comp = false;		
			setCurrentDate('frmdate');
			setCurrentDate('todate');			
			
//-->	
</script></td>
	</tr>
	<tr>
		<td height="13"></td>
	</tr>
</table>
<%@ include file="../footer.jsp"%></form>
</body>
</html>
