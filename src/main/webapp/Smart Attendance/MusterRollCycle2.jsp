<%@ page contentType="text/html; charset=iso-8859-1" language="java" 	import="java.sql.*" errorPage=""%>
<%@ page  import="com.my.org.erp.common.CommonFunctions"  %>
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


<title> :: ATTENDANCE ::</title>


<script language="javascript" src="../JavaScript/comfunction.js"></script>
 
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
 <style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
 </style>
</head>

<body  onpaste='return false;'>
<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" onSubmit="return validate()">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="390"
			align="center" border="0">
			<tbody>
				<tr>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/Smart Inventory/TLCorner.gif" width="7" /></td>
					<td class="BorderLine" height="0"> </td>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/Smart Inventory/TRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td height="6"> </td>
				</tr>
				<tr>
					<td class="BorderLine" width="1"> </td>
					<td width="6"> </td>
					<td width="412">
					<table width="324" border="0" align="center" cellpadding="2" cellspacing="2"
						 >
						<!--DWLayoutTable-->
						<tr align="center" valign="middle">
							<td height="18" colspan="2"  class="BackGround">MUSTER
							ROLL CYCLE-2
							   
							</td>
						</tr>
						 
						<tr class="bolddeepblue">
							<td height="35" valign="middle" class="boldEleven">Office<font
								color='red'> *</font></td>
							<td valign="top" class="bolddeepblue">
							<%
			   	String branchid=""+session.getAttribute("BRANCHID");
	   			String oficeid=""+session.getAttribute("OFFICEID");
				 
			  %> <select name="office" class="formText135" id="office"  style="width:150">
								<option value="0">All</option>
								<%
								
		String sq=" select INT_OFFICEID,CHR_OFFICENAME from  com_m_office  order by CHR_OFFICENAME";

		String shipids[][] = CommonFunctions.QueryExecute(sq);
		for(int u=0; u<shipids.length; u++)
			if(shipids[u][0].trim().equals(oficeid.trim()))
				out.print("<option selected = 'selected' value='"+shipids[u][0]+"'>"+shipids[u][1] +"</option>");
			else
				out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][1] +"</option>");
							%>
							</select></td>
						</tr>
						<tr class="bolddeepblue">
							<td height="35" valign="middle" class="boldEleven">Department<font
								color='red'> *</font></td>
							<td valign="top" class="bolddeepblue"><select name="dept"
								id="dept" class="formText135"   style="width:150">
								<option value="0">All</option>
								<%
		sq="SELECT INT_DEPARTID,CHR_DEPARTNAME FROM   com_m_depart   ORDER BY  CHR_DEPARTNAME";
		String deptid[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sq);
		
		for(int u=0;u<deptid.length;u++)
			out.print("<option value='"+deptid[u][0]+"'>"+deptid[u][1]+"</option>"); 
	%>
							</select></td>
						</tr>
						<tr>
								  <td class="boldEleven">Category<font
								color='red'> *</font></td>
								  <td> <select name="category" class="formText135" id="category" style="width:150">
	<option value="0">All</option>
	<%
	String empcategorysql=" SELECT INT_EMPLOYEECATEGORYID,CHR_CATEGORYNAME  FROM   com_m_employeecategory   ORDER BY CHR_CATEGORYNAME ";
	String empcategoryData[][]= CommonFunctions.QueryExecute(empcategorysql);
	if (empcategoryData.length>0)
		for (int i=0; i<empcategoryData.length; i++) 
			out.println("<option value="+empcategoryData[i][0]+">"+empcategoryData[i][1] +"</option>");			
	
						%>

</select></td>
					  </tr>
						<tr class="bolddeepblue">
							<td width="132" height="35" valign="middle" class="boldEleven">Month<font
								color='red'> *</font></td>
							<td width="268" valign="top" class="bolddeepblue"> <jsp:include page="../JavaScript/monthcycle.jsp" flush="true" /></td>
						</tr>
						<tr>
							<td class="boldEleven">Year<font
								color='red'> *</font></td>
						  <td><select name="year"  id="year" class="formText135" style="width:150">
								<option value="select">Select</option>
								<%
			      for(int i=2000;i<=2050;i++)
			      {
			       out.println("<option value="+i+">"+i+"</option>");
			      }
			     %>
							</select> <script language='JavaScript' type="text/javascript">setCurrentYear('year')</script>
				 
         
							<input type="hidden" name="actionS" value="ATTAttendanceCalculateCycle2">
                            <input type="hidden" name="filename" value="AttendanceCycl2">
                            <input name="checkmonth" type="hidden" id="checkmonth" value="<%=CommonFunctions.QueryExecute("SELECT MONTH(DATE_SUB(NOW(), INTERVAL 1 MONTH))")[0][0]%>">
                            <input name="checkday" type="hidden" id="checkday" value="<%=CommonFunctions.QueryExecute("SELECT DATE_FORMAT(now(),'%d-%m-%Y')")[0][0]%>">
							<input name="checkyear" type="hidden" id="checkyear" value="<%=CommonFunctions.QueryExecute("SELECT YEAR(DATE_SUB(NOW(), INTERVAL 1 MONTH))")[0][0]%>">
							
						  </td>
						</tr>

						<tr>
						  <td height="28" colspan="2" valign="middle" class="bolddeepblue">
							<table width="142" border="0" align="center" cellpadding="3"
								cellspacing="3">
								<tr>
									<td width="61"><input name="Submit2" type="submit"
										class="buttonbold" id="submit" value="Submit"   accesskey="s"   ></td>
									<td width="60"><input class="buttonbold" type="button"
										name="Submit"  value="Close"   accesskey="c" 
										onClick="redirect('AttendanceMain.jsp')"></td>
								</tr>
							</table>							</td>
						</tr>
						<tr>
							<td height="2"></td>
							<td></td>
						</tr>
					</table>
					</td>
					<td nowrap="nowrap" width="4"> </td>
					<td class="BorderLine" width="1"> </td>
				</tr>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/Smart Inventory/BLCorner.gif" width="7" /></td>
					<td height="6"> </td>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/Smart Inventory/BRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td class="BorderLine" height="0"> </td>
				</tr>
			</tbody>
		</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
</form>

<script language="javascript" >
function validate()
{
	try
	{
		 
		if(
			checkNullSelect('month','Select month','0')
			&& checkNullSelect('year','Select year','0')
			&& checkCycle()
		   )
			return true
		else
			return false
	}
	catch(err)
	{
		alert(err);
	}
}


function checkCycle()
{
	try
	{
		var s1 = parseInt(document.getElementById('month').value)  ;
		var s2 = parseInt(document.getElementById('checkmonth').value)  ;
		var s4 = parseInt(document.getElementById('year').value)  ; 
		var s5 = parseInt(document.getElementById('checkyear').value)  ; 
		if(   ( s1 == s2)  && (s4 == s5)  )
		{
			return true;
		}
		else
		{
			 
			return true;
		
		}
	}
	catch(err)
	{
		alert(err);
		return false;
	}
}
</script>
<%@ include file="../footer.jsp"%>
</body>
</html>
