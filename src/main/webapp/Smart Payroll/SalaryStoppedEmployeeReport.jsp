<%@ page import="com.my.org.erp.common.CommonFunctions"%>

<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage=""%>
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


<title> :: PAYROLL ::</title>

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>
 

<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/Attendance/ReportAjax.js"></script>
<script language="javascript">
function  validate()
{
	try
	{
		if(
		  	checkNullSelect('month','Select Month','0')
			&& checkNullSelect('year','Select Year','0')
			
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
</script>
 
</head>

<body  onpaste='return false;'>
<%@ include file="index.jsp"%>
<!--SalaryReportResponse.jsp 
-->
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="ReportSalaryStoppedEmployeeResponse.jsp" onSubmit="return  validate()">
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
		<td height="200">
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
					<table width="600" border="0" cellspacing="2" cellpadding="2"
						 >
						<!--DWLayoutTable-->
						<tr align="center" valign="middle">
							<td height="18" colspan="2"  class="BackGround">Salary
							Report</td>
						</tr>

						<tr class="bolddeepblue">
							<td height="22" valign="middle" class="boldEleven">Company<span class="boldred"> *</span> </td>
							<td valign="top" class="bolddeepblue">
							
							<select name="company" 	id="company" onChange="loadBranch()" class="formText135"
								style="width:200px">
								<option value="0">All</option>
								<%                  
     					String queryBranch1 = "SELECT * FROM  com_m_company ";
     					String	branch1[][] = CommonFunctions.QueryExecute(queryBranch1);
     					for(int i=0;i<branch1.length;i++)
 	 						out.println("<option value='"+branch1[i][0]+"'>"+branch1[i][1]+"</option>");
 			   %>
							</select></td>
						</tr>
						<tr class="bolddeepblue">
							<td height="22" valign="middle" class="boldEleven">Branch<span class="boldred"> *</span> </td>
							<td valign="top" class="bolddeepblue"><span
								class="tabledata"> <select name="branch" id="branch"
								class="formText135" style="width:200px">
								<option value="0">All</option>
							</select> </span></td>
						</tr>
						<tr class="bolddeepblue">
							<td height="23" valign="middle" class="boldEleven">Office<span class="boldred"> *</span> </td>
							<td valign="top" class="bolddeepblue">
							<%
			   	String branchid=""+session.getAttribute("BRANCHID");
	   			String oficeid=""+session.getAttribute("OFFICEID");
				 
			  %> <select name="Office" class="formText135" id="Office">
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
							<td height="22" valign="middle" class="boldEleven">Department<span class="boldred"> *</span> </td>
							<td valign="top" class="bolddeepblue"><select name="dept"
								id="dept" class="formText135">
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
								  <td class="boldEleven">Category<span class="boldred"> *</span> </td>
								  <td> <select name="Category" class="formText135" id="Category">
	<option value="0">All</option>
	<%
	String empcategorysql=" SELECT INT_EMPLOYEECATEGORYID,CHR_CATEGORYNAME  FROM   com_m_employeecategory   ORDER BY CHR_CATEGORYNAME ";
	String empcategoryData[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(empcategorysql);
	if (empcategoryData.length>0)
		for (int i=0; i<empcategoryData.length; i++) 
			out.println("<option value="+empcategoryData[i][0]+">"+empcategoryData[i][1] +"</option>");			
	
						%>

</select></td>
					  </tr>
						<tr class="bolddeepblue">
						  <td height="22" valign="middle" class="boldEleven">Staff Type <span class="boldred"> *</span> </td>
						  <td valign="top" class="bolddeepblue">
						  
						  
<select name="type"   id="type"  class="formText135" style="width:100">
	<option value="0">All</option>
	 <option value="CONSOLIDATE">CONSOLIDATE EMPLOYEE ONLY</option>
	 <option value="2">WITHOUT CONSOLIDATE EMPLOYEE</option>
</select>



						  </td>
					  </tr>
						<tr class="bolddeepblue">
							<td width="132" height="22" valign="middle" class="boldEleven">Month<span class="boldred"> *</span> </td>
							<td width="268" valign="top" class="bolddeepblue"><select
								name="month" 	id="month" class="formText135">
								<option value="0">Select</option>
								<%@ include file="../JavaScript/months.jsp" %>
							</select></td>
						</tr>
						<tr>
							<td class="boldEleven">Year<span class="boldred"> *</span> </td>
							<td><select name="year"  id="year" class="formText135">
								<option value="0">Select</option>
								<%@ include file="../JavaScript/years.jsp" %>
							</select> <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						setOptionValue('month',month1);
						setOptionValue('year',year1);							
				//-->
          </script> <input name="filename" type="hidden" id="filename"
								value="SalaryProcess" /> <input name="actionS" type="hidden"
								id="actionS" value="PAYSalaryReport" /></td>
						</tr>
						<tr>
							<td height="28" colspan="2" valign="middle" class="bolddeepblue">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td colspan="2" class="boldEleven">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="3%"><!--<input name="empid" type="checkbox"
												readonly="readonly" id="empid" value="Y" checked>-->
										    <input name="basic" type="checkbox" id="basic"
												value="Y" checked></td>
											<td width="34%" class="boldEleven">Basic </td>
											<td width="3%"><input name="pf" type="checkbox" id="pf"
												value="Y" checked></td>
											<td width="24%" class="boldEleven">PF</td>
											<td width="3%"><input name="netpay" type="checkbox"
												id="netpay" value="Y" checked></td>
											<td width="33%" class="boldEleven">Net Pay</td>
										</tr>
										<tr>
											<td><!--<input name="empname" type="checkbox" id="empname"
												value="Y" checked>-->
										    <input name="wdays" type="checkbox" id="wdays"
												value="Y" checked></td>
											<td class="boldEleven">Working days </td>
											<td><input name="esi" type="checkbox" id="esi" value="Y"
												checked></td>
											<td class="boldEleven">ESI</td>
											<td><input name="monhpay" type="checkbox" id="monhpay"
												value="Y" checked></td>
											<td class="boldEleven">Month Pay</td>
										</tr>
										<tr>
											<td><input name="bank" type="checkbox" id="bank"
												value="Y"></td>
											<td class="boldEleven">Bank Name</td>
											<td><input name="mess" type="checkbox" id="mess"
												value="Y"></td>
											<td class="boldEleven">Mess Bill</td>
											<td><input name="cpyesi" type="checkbox" id="cpyesi"
												value="Y"></td>
											<td class="boldEleven">Company ESI</td>
										</tr>
										<tr>
											<td><input name="acno" type="checkbox" id="acno"
												value="Y"></td>
											<td class="boldEleven">Account No.</td>
											<td><input name="advance" type="checkbox" id="advance"
												value="Y"></td>
											<td class="boldEleven">Advance</td>
											<td><input name="cpypf" type="checkbox" id="cpypf"
												value="Y"></td>
											<td class="boldEleven">Company PF</td>
										</tr>
										<tr>
											<td><input name="hold"
												type="checkbox" id="hold" value="Y"></td>
											<td class="boldEleven">Allow Hold</td>
											<td><input name="ctc" type="checkbox" id="ctc" value="Y"></td>
											<td class="boldEleven">CTC</td>
											<td><input name="PFNumber" type="checkbox" id="PFNumber"
												value="Y"></td>
											<td class="boldEleven">P.F. Number </td>
										</tr>
										<tr>
											<td><input name="salarynotissue"
												type="checkbox" id="salarynotissue" value="Y"></td>
											<td class="boldEleven">Salary not issue </td>
											<td><input name="resigned" type="checkbox" id="resigned"
												value="Y"></td>
											<td class="boldEleven">Allow Resigned</td>
											<td class="boldEleven"><input name="ESINumber" type="checkbox" id="ESINumber"
												value="Y"></td>
											<td class="boldEleven">E.S.I. Number </td>
										</tr>
										<tr>
										  <td><input name="pfdoj" type="checkbox" id="pfdoj"
												value="Y"></td>
										  <td class="boldEleven">P.F. Date of Joinning </td>
										  <td><input name="ifsc" type="checkbox" id="ifsc"
												value="Y"></td>
										  <td class="boldEleven">IFSC Code </td>
										  <td class="boldEleven">&nbsp;</td>
										  <td class="boldEleven">&nbsp;</td>
									  </tr>
										<tr>
										  <td>&nbsp;</td>
										  <td class="boldEleven">&nbsp;</td>
										  <td>&nbsp;</td>
										  <td class="boldEleven">&nbsp;</td>
										  <td class="boldEleven">&nbsp;</td>
										  <td class="boldEleven">&nbsp;</td>
									  </tr>
									</table>									</td>
								</tr>
								<tr>
									<td width="34%" class="boldEleven"><strong>Allowance</strong></td>
									<td width="66%">&nbsp;</td>
								</tr>
								<tr>
									<td colspan="2" class="boldEleven">
									  <div align="left">
									    <%
						String sql = "SELECT CHR_ACODE,CHR_ANAME  FROM pay_m_allowance ORDER BY INT_ALLOWANCEID";
 						String aname[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sql);
						out.println("<table cellspacing=0 cellpadding=0  width='100%'><tr>");
 						int i=0;
						for(int a=0;a<aname.length;a++)
						{
							if(i>=3)
							{
								out.println("<tr>");
								i=0;
							}
							i=i+1;	
							out.println("<td  class=\"boldEleven\"><input type=\"checkbox\" name=\"Acheckbox\" value=\""+aname[a][0]+"\"><font class='boldEleven'>"+aname[a][1]);
						}
 						out.println("</table>");
					%>									
							        </div></td>
								</tr>
								<tr>
									<td class="boldEleven"><strong>Recovery</strong></td>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td colspan="2" class="boldEleven">
									<%
					    
						sql = "SELECT CHR_RCODE,CHR_RNAME  FROM pay_m_recovery ORDER BY INT_RECOVERYID";
 						String rname[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sql);
						out.println("<table cellspacing=0 cellpadding=0   width='100%' ><tr>");
 						i=0;
						for(int a=0;a<rname.length;a++)
						{
							if(i>=3)
							{
								out.println("<tr>");
								i=0;
							}
							i=i+1;	
							out.println("<td  class=\"boldEleven\"><input type=\"checkbox\" name=\"Rcheckbox\" value=\""+rname[a][0]+"\">"+rname[a][1]);
						}
 						out.println("</table>");
					%>									</td>
								</tr>
								<tr>
									<td class="boldEleven">&nbsp;</td>
									<td>&nbsp;</td>
								</tr>
							</table>							</td>
						</tr>
						<tr>
							<td height="28" colspan="2" valign="middle" class="bolddeepblue">
							<table width="142" border="0" align="center" cellpadding="3"
								cellspacing="3">
								<tr>
									<td width="61"><input name="Submit2" type="submit"
										class="buttonbold14" id="submit" value="Submit"   accesskey="s"   ></td>
									<td width="60"><input class="buttonbold14" type="button"
										name="Submit"  value="Close"   accesskey="c" 
										onClick="redirect('SalaryReport.jsp')"></td>
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
<%@ include file="../footer.jsp"%>
</body>
</html>
