<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage=""%>
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
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
 <link href="../JavaScript/SmartStyles.css" rel="stylesheet" type="text/css">
</head>

<body  onpaste='return false;'>
<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" onSubmit="return validate()">
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
					<table width="300" border="0" align="center" cellpadding="2" cellspacing="2"
						 >
						<!--DWLayoutTable-->
						<tr align="center" valign="middle">
							<td height="18" colspan="2"  class="BackGround">MUTER ROLL CALCULATION </td>
						</tr>
						<tr class="bolddeepblue">
							<td height="24" valign="middle" class="bolddeepblue"><!--DWLayoutEmptyCell-->&nbsp;</td>
							<td valign="top" class="bolddeepblue"><!--DWLayoutEmptyCell-->&nbsp;</td>
						</tr>
						<tr class="bolddeepblue">
							<td height="24" valign="middle" class="boldEleven">Office<font
								color='red'> *</font></td>
							<td valign="top" class="bolddeepblue">
							<%
			   	String branchid=""+session.getAttribute("BRANCHID");
	   			String oficeid=""+session.getAttribute("OFFICEID");
				 
			  %> <select name="Office" class="formText135" id="Office" style="width:150">
								<option value="Select">Select Office</option>
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
						</tr>
						<tr class="bolddeepblue">
							<td height="24" valign="middle" class="boldEleven">Department<font
								color='red'> *</font></td>
							<td valign="top" class="bolddeepblue"><select name="dept"
								id="dept" class="formText135"  style="width:150" >
								<option value="Select">Select Department</option>
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
								  <td> <select name="Category" class="formText135" id="Category" style="width:150">
								  <option value="Select">Select Category</option>
	<option value="0">All</option>
	<%
	String empcategorysql=" SELECT INT_EMPLOYEECATEGORYID,CHR_CATEGORYNAME  FROM   com_m_employeecategory WHERE INT_ATTENDANCE_CYCLE=2   ORDER BY CHR_CATEGORYNAME ";
	String empcategoryData[][]= CommonFunctions.QueryExecute(empcategorysql);
	if (empcategoryData.length>0)
		for (int i=0; i<empcategoryData.length; i++) 
			out.println("<option value="+empcategoryData[i][0]+">"+empcategoryData[i][1] +"</option>");			
	
						%>

</select></td>
					  </tr>
						 
						<tr class="bolddeepblue">
							<td width="95" height="24" valign="middle" class="boldEleven">Month<font
								color='red'> *</font></td>
						  <td width="191" valign="top" class="bolddeepblue"><jsp:include page="../JavaScript/monthcycle.jsp" flush="true" /></td>
						</tr>
						<tr>
							<td class="boldEleven">Year<font
								color='red'> *</font></td>
						  <td><select name="year"  id="year" class="formText135">
								<option value="Select">Select Year</option>
								<%@ include file="../JavaScript/years.jsp"%>
                                
							</select> <script language='JavaScript' type="text/javascript">setCurrentYear('year')</script>
							<input type="hidden" name="actionS" value="ATTProcess">
                             <input type="hidden" name="registercheck" id="registercheck" value="N">
							<input type="hidden" name="filename" value="AttendanceProcessCycle2">
							<input name="checkmonth" type="hidden" id="checkmonth" value="<%=CommonFunctions.QueryExecute("SELECT MONTH(DATE_SUB(NOW(), INTERVAL 1 MONTH))")[0][0]%>">
                            <input name="checkday" type="hidden" id="checkday" value="<%=CommonFunctions.QueryExecute("SELECT DAY(NOW())")[0][0]%>">
                            <input name="checkyear" type="hidden" id="checkyear" value="<%=CommonFunctions.QueryExecute("SELECT YEAR(DATE_SUB(NOW(), INTERVAL 1 MONTH))")[0][0]%>">							</td>
						</tr>

						<tr>
						  <td height="28" colspan="2" valign="middle" class="bolddeepblue">
                          <%
						  String SData[][] =CommonFunctions.QueryExecute(" SELECT CHR_SALAYCALCULATION FROM  pay_m_basicsettings WHERE INT_ID=1");
						  if(SData.length>0)
						  {
							  if("WRK".equals(SData[0][0]))
									out.println("<center><h1><font class='bolddeepred'>Sunday not consider... please change the settings</font></h1></center>");
						  }
						  %>
                          
                         <!-- * CTC - Salary calculated in (month salary*12/365) *working days - including sundays
* Month - Salary calculated in (month salary/No of days in a Month) *working days - including sundays
* Working - Salary calculated in (month salary/(No of days in aMonth - No of sundays in a month)) *working days 
                         --> 
                          </td>
					  </tr>
						<tr>
							<td height="28" colspan="2" valign="middle" class="bolddeepblue">
							<table   border="0" align="center" cellpadding="3"
								cellspacing="3">
								<tr>
									<td width="70"><input name="Submit2" type="submit"
										class="buttonbold" id="submit" value="Calculate"></td>
									<td width="70"><input name="Button" type="button" class="buttonbold" onClick=" View()"
										value="View"></td>
									<td width="70"><input class="buttonbold" type="button"
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
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<div align="center" class="bolddeepred">

		<div align="center">
		<%
		String er=""+request.getParameter("er");
		if( "null".equals(er)  || "".equals(er))
			out.println();
		else
		{
			
			out.println("<h1>"+er+"</h1>");
			String rofficeid=request.getParameter("Office");
			String rdept = ""+request.getParameter("dept");
			String rmont=request.getParameter("month");
			String ryear=request.getParameter("year");
			String rCategory=request.getParameter("Category");
			String flag=request.getParameter("flag");
			String rr = "AttendanceProcessResponseCycle2.jsp?month="+rmont+"&year="+ryear+"&office="+rofficeid+"&dept="+rdept+"&category="+rCategory ;
			if("Y".equals(flag))
			{
				
			%>
			<script language="javascript">
				var name=confirm("<%=er%> Then Confirm to View the data....")
				if (name==true)
				{
					location = "<%=rr%>";
				}
			</script>
			<%
			}
			else
			{
			%>
			<script language="javascript">
				 alert("Reset the Attendance , because <%=er%>");
			</script>
			<%
			}
		}
		
	%>
		</div>
		</div>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>

<script language="javascript">
	function View()
 	{		
		//AttendanceProcessResponseCycle2.jsp?month=10&year=2007&Office=0&dept=0
		
		if( 
			checkNullSelect('Office','Select Office','Select')
			&& checkNullSelect('dept','Select Department','Select')
			&& checkNullSelect('Category','Select Category','Select')
			&& checkNullSelect('month','Select month','Select')
			&& checkNullSelect('year','Select year','Select')
			
		  )
		  {
		
			var month= document.getElementById('month').value;
			var year= document.getElementById('year').value;
			var Office= document.getElementById('Office').value;
			var dept= document.getElementById('dept').value;
			var cat= document.getElementById('Category').value;
			var sql="AttendanceProcessResponseCycle2.jsp?month="+month+"&year="+year+"&office="+Office+"&dept="+dept+"&category="+cat;
			window.location=sql;
		  	
		  }
		 
			
		 
		
 	}
	
function  validate()
{
	try
	{ 
	 
	 	if(document.getElementById('registercheck').value == "N")
			alert("Smart not consider the blanks");
	 
		if( 
			 checkNullSelect('Office','Select Office','Select')
			&& checkNullSelect('dept','Select Department','Select')
			&& checkNullSelect('Category','Select Category','Select')
			&& checkNullSelect('month','Select month','Select')
			&& checkNullSelect('year','Select year','Select')
			&&  checkCycle()
			
		  )
			return true;
		else
			return false;
			
	}
	catch(err)
	{
		alert(err);
		return false;
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



</form>
<%@ include file="../footer.jsp"%>
</body>
</html>
