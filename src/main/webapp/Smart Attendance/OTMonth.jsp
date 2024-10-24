<%@ include file="index.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title> :: ATTENDANCE ::</title>


 
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
<style type="text/css">
<!--
.style8 {
	font-family: Verdana;
	font-size: 12px;
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
.style10 {font-family: Verdana; font-size: 12px; font-weight: bold; }
-->
</style>
<script language="JavaScript">
function Validate()
  {
  	if(checkNullSelect("month","Select Month","select")&&(checkNullSelect("year","Select Year","select"))){
		
		return true;
	}
	return false;
  }
  function mainPage()
  {
	    document.a.action="AttendanceMain.jsp";
		document.a.submit();
		return true;
  }
  </script>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<form    name="a" action="OTMonthResponse.jsp" onSubmit="return Validate()">
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<p class="style8">&nbsp;</p>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	
	<tr>
		<td height="113" align="center">
		
		<table class="BackGround" cellspacing="0" cellpadding="0" width="350"
			align="center" border="0">
			<tbody>
				<tr>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></td>
					<td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
				</tr>
				<tr>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
					<td width="6"><spacer height="1" width="1" type="block" /></td>
					<td width="412"><table width="426" border="0" align="center" cellpadding="3" cellspacing="0"
						 >
                      <!--DWLayoutTable-->
                      <tr align="center" valign="middle">
                        <td height="18" colspan="3"  class="BackGround">Over Time Report</td>
                      </tr>
                      <tr class="bolddeepblue">
                        <td height="31" valign="middle" class="boldEleven">Company</td>
                        <td valign="top" class="boldEleven"><select name="company" id="company"
								class="formText135" style="width:250px">
                            <option value="0">All</option>
                            <%                  
     					String queryBranch1="SELECT * FROM  com_m_company ";
     					String	branch1[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(queryBranch1);
     					for(int i=0;i<branch1.length;i++)
 	 						out.println("<option value='"+branch1[i][0]+"'>"+branch1[i][1]+"</option>");
 			   %>
                        </select></td>
                        <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      </tr>
                      <tr class="bolddeepblue">
                        <td width="100" height="29" valign="middle" class="boldEleven">Office</td>
                        <td valign="top" class="boldEleven"><%
			   	String branchid=""+session.getAttribute("BRANCHID");
	   			String oficeid=""+session.getAttribute("OFFICEID");
				 
			  %>
                            <select name="Office" class="formText135" id="Office">
                              <option value="0">All</option>
                              <%
								
		String sq=" select INT_OFFICEID,CHR_OFFICENAME from  com_m_office  order by CHR_OFFICENAME";

		String shipids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sq);
		for(int u=0; u<shipids.length; u++)
			if(shipids[u][0].trim().equals(oficeid.trim()))
				out.print("<option selected = 'selected' value='"+shipids[u][0]+"'>"+shipids[u][1] +"</option>");
			else
				out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][1] +"</option>");
							%>
                          </select></td>
                        <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      </tr>
                      <tr class="bolddeepblue">
                        <td height="32" valign="middle" class="boldEleven">Department</td>
                        <td width="250" valign="top" class="boldEleven"><select
								name="dept" id="dept" class="formText135">
                            <option value="0">All</option>
                            <%
		sq="SELECT INT_DEPARTID,CHR_DEPARTNAME FROM   com_m_depart   ORDER BY  CHR_DEPARTNAME";
		String deptid[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sq);
		
		for(int u=0;u<deptid.length;u++)
			out.print("<option value='"+deptid[u][0]+"'>"+deptid[u][1]+"</option>"); 
	%>
                        </select></td>
                        <td width="58" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp; </td>
                      </tr>
                      <tr>
                        <td height="28" class="boldEleven">Order by</td>
                        <td class="boldEleven"><select name="sorting" class="formText135">
                            <option value="CHR_EMPID ">Empid</option>
                            <option value="CHR_STAFFNAME">Staff Name</option>
                        </select></td>
                        <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      </tr>
                      <tr>
                        <td height="30" class="boldEleven">Sorted
                          By </td>
                        <td class="boldEleven"><select name="ss" class="formText135">
                            <option value="asc">Ascending</option>
                            <option value="desc">Descending</option>
                        </select></td>
                        <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      </tr>
                      <tr>
                        <td height="32" valign="middle" class="bolddeepblue">Month</td>
                        <td valign="middle"><strong> <font
								size="1"><font size="1">
                          <select name="month"
								id="month" class="formText135">
                            <option value="select">Select</option>
                            <%@include file="../JavaScript/months.jsp" %>
                        </select>
                        </font></font> </strong></td>
                        <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      </tr>
                      <tr>
                        <td height="33" valign="middle" class="bolddeepblue">Year </td>
                        <td valign="middle"><strong>
                          <select name="year"
								id="year" class="formText135">
                            <option value="select">Select</option>
                        <%@include file="../JavaScript/years.jsp" %></select>
                             <script language="JavaScript">
                             var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						setOptionValue('month',month1);
						setOptionValue('year',year1);
                             </script>
                          <input type="hidden" name="filename" value="Attendance">
                          <input type="hidden" name="actionS"
								value="ATTAttendanceMonthList">
                        </strong></td>
                        <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      </tr>

                      <tr>
                        <td height="28" colspan="3" valign="middle" class="bolddeepblue"><table width="142" border="0" align="center" cellpadding="3"
								cellspacing="3">
                            <tr>
                              <td width="61"><input name="Submit2" type="submit"
										class="buttonbold" id="submit" value="Submit"   accesskey="s"   ></td>
                              <td width="60"><input class="buttonbold" type="button"
										name="Submit"  value="Close"   accesskey="c" 
										onClick="redirect('AttendanceMain.jsp')"></td>
                            </tr>
                        </table></td>
                      </tr>
                      <tr>
                        <td height="2"></td>
                        <td colspan="2"></td>
                      </tr>
                    </table></td>
					<td nowrap="nowrap" width="4"><spacer height="1" width="1"
						type="block" /></td>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BLCorner.gif" width="7" /></td>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
			</tbody>
		</table>		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="44"><%@ include file="../footer.jsp"%></td>
	</tr>
</table>


</body>

</form>
</html>
