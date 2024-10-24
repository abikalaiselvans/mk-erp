<%@ page isErrorPage="false" errorPage="./InValidSession.jsp"%>
<%!
	String sql;
%>
<html>
<head>
 

<title> :: ATTENDANCE ::</title>


<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="javascript"
	src="../JavaScript/Attendance/ReportAjax.js"></script>
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
			if(checkNullSelect("Year","Select Year","0") && checkNullSelect("Month","Select Month","0"))
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
	    document.salfrm.action="AttendanceMain.jsp";
		document.salfrm.submit();
		return true;
    }
	
</script>
</head>
<body  onpaste='return false;'>
<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   name="salfrm" action="../SmartLoginAuth" onSubmit="return validate()">
<br>
<br>
<br>
<br>
<table height="147" border="0" align="center" cellpadding="0"
	cellspacing="0"    >
	<tr>
		<td height="145" valign="top">
		<table width="100%" height="75%" border="0" align="center"
			cellpadding="0" cellspacing="0"  
			 >

			<tr>
				<td height="26" colspan="4" align="center" valign="middle"
					  class="tablehead">
				Muster Roll Calculation</td>
			</tr>
			<tr>
				<td width="162" height="28" valign="middle" class="bolddeepblue"><strong>
				Company</strong></td>
				<td></td>
				<td width="210"><select name="company" id="company"
					onChange="loadBranch()" class="bolddeepblue" style="width:200px">
					<%                  
     					String queryBranch1="SELECT * FROM  com_m_company ";
     					String	branch1[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(queryBranch1);
     					for(int i=0;i<branch1.length;i++)
 	 						out.println("<option value='"+branch1[i][0]+"'>"+branch1[i][1]+"</option>");
 			   %>
				</select></td>
			</tr>
			<tr>
				<td width="162" height="28" valign="middle" class="bolddeepblue"><strong>
				Branch</strong></td>
				<td></td>
				<td width="210"><select name="branch" id="branch"
					class="bolddeepblue" style="width:200px">
					<option value="-1">All</option>
				</select></td>
			</tr>
			<tr>
				<td height="21" colspan="4" align=center class="boldgre">
				<table width="104" border="0" align="center" cellpadding="0"
					cellspacing="0">
					<tr>
						<td><span class="bolddeepblue"> <input type="radio"
							id="month1" name="reportType" value="Month"
							onClick="disableMonthWise()" checked> </span></td>
						<td><span class="bolddeepblue">Month Wise</span></td>
						<!--<td><span class="bolddeepblue">
                  <input type="radio" id="date1" name="reportType" value="Date" onClick="disableYearWise()" >
                </span></td>
                <td><span class="bolddeepblue">Date Wise</span></td>-->
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td height="21" colspan="4" align=center class="boldgre">
				<table width="254" border="1" align="center" cellpadding="3"
					cellspacing="1"  >
					<tr>
						<td width="135" class="bolddeepblue"><strong>Month</strong></td>
						<td width="183"><%@ include file="../JavaScript/month.jsp"%></td>
					</tr>
					<tr>
						<td class="bolddeepblue"><strong> Year</strong></td>
						<td><%@ include file="../JavaScript/year.jsp"%></td>
					</tr>
				</table>
				</td>
			</tr>
			<!--<tr>
            <td height="21" colspan="4"  align=center class="boldgre">&nbsp;</td>
          </tr>
          <tr>
            <td height="21" colspan="2"  align=center class="boldgre">
				<div align="center" class="bolddeepblue"></div>			</td>
            <td width="210" colspan="2" align=center class="boldgre"><div align="center" class="bolddeepblue"></div>			</td>
          </tr>
          <tr>
            <td height="59" colspan="2" align="center">&nbsp;</td>
            <td colspan="2" align="center"><table border="1" cellspacing="1" cellpadding="1"  >
                <tr>
                  <td class="bolddeepblue">Form Date </td>
                  <td><input name="frmdate" type="text" class="bolddeepblue" id="frmdate" onKeyPress="dateOnly('frmdate')" size="18">
                    <a href="javascript:cal1.popup();" > <img src="../JavaScript/img/cal.gif" width="16" height="16" border="0" alt="Click Here to Pick up the date"></a> </td>
                <tr>
                  <td class="bolddeepblue">To Date </td>
                  <td><input name="todate" type="text" class="bolddeepblue" id="todate" onKeyPress="dateOnly('todate')" size="18">
                    <a href="javascript:call1.popup();"> <img src="../JavaScript/img/cal.gif" width="16" height="16" border="0" alt="Click Here to Pick up the date"></a> </td>
                </tr>
            </table></td>
          </tr>-->
			<tr>
				<td height="26" colspan="2" align="right" class="bolddeepblue">
				<div align="center"><strong>Department </strong></div>
				</td>
				<td colspan="2"><select name="select" class="bolddeepblue"
					id="select">
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
				</select> <input type="hidden" name="actionS" value="ATTmusterCal"> <input
					type="hidden" name="filename" value="MusterRoll"></td>
			</tr>
			<tr>
				<td height="81" colspan="4" align="right" class="bolddeepblue">
				<table border="0" align="center" cellpadding="3" cellspacing="3">
					<!--DWLayoutTable-->
					<tr>
						<td width="56"><input name="Submit2" type="submit"
							class="buttonbold" accesskey="C" value="Calculate"></td>
						<td width="56"><input name="Submit2" type="submit"
							class="buttonbold" accesskey="V" value="View"></td>
						<td width="56"><input class="buttonbold" type="button"
							name="Submit"  value="Close"   accesskey="c"  onClick="mainPage()"></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
</table>
<!--<p>
    <script language="JavaScript">			
 
			var cal1 = new calendar1(document.forms['salfrm'].elements['frmdate']);
			cal1.year_scroll = true;
			cal1.time_comp = false;
			var call1 = new calendar1(document.forms['salfrm'].elements['todate']);
			cal1.year_scroll = true;
			cal1.time_comp = false;				
 	
    </script>
  </p>-->
<p><br>
<br>
<br>
<br>
<%@ include file="../footer.jsp"%></p>
</form>
</body>
</html>
