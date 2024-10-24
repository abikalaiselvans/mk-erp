<%@ page  import="java.sql.*" errorPage=""%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>

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



<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/Attendance/ReportAjax.js" ></script> 
  
 
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
 

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>
 
<body  onpaste="return false;" >
<%@ include file="index.jsp"%>
 <form  AUTOCOMPLETE = "off"   name="frm" method="post" action="RevisionandArrearResponse.jsp">
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
					<table width="501" border="0" cellspacing="0" cellpadding="2"
						 >
						<!--DWLayoutTable-->
						<tr align="center" valign="middle">
							<td height="18" colspan="2"  class="BackGround">REVISION &amp; ARREARS </td>
						</tr>

						<tr class="bolddeepblue">
							<td height="24" valign="middle" class="bolddeepblue"><!--DWLayoutEmptyCell-->&nbsp;</td>
							<td valign="top" class="bolddeepblue"><!--DWLayoutEmptyCell-->&nbsp;</td>
						</tr>
						<tr>
						<td width="196" height="28" valign="middle" class="boldEleven">
							Company<span class="boldred"> *</span> </td>
							<td width="286" class="boldEleven">
<select name="company" id="company" onChange="loadBranch()"  	class="formText135" style="width:200px">
<%                  
	String	branch1[][]= CommonFunctions.QueryExecute("SELECT INT_COMPANYID,CHR_COMPANYNAME FROM  com_m_company ");
	for(int i=0;i<branch1.length;i++)
		out.println("<option value='"+branch1[i][0]+"'>"+branch1[i][1]+"</option>");
%>
</select>							</td>
						</tr>
						<tr>
							<td width="196" height="28" valign="middle" class="boldEleven">
							Branch<span class="boldred"> *</span> </td>
							<td width="286" class="boldEleven">
<select name="branch" id="branch"	class="formText135" style="width:200px">
	<option value="0">All</option>
</select>							</td>
						</tr>	
							
						<tr class="bolddeepblue">
							<td width="196" height="24" valign="middle" class="boldEleven">Office<span class="boldred"> *</span> </td>
							<td width="286" valign="top" class="boldEleven">
							
<%
	String branchid=""+session.getAttribute("BRANCHID");
	String oficeid=""+session.getAttribute("OFFICEID");
%> 
 <select name="Office" class="formText135" id="Office" style="width:200px">
<option value="0">All</option>
<%
String shipids[][] =  CommonFunctions.QueryExecute(" select INT_OFFICEID,CHR_OFFICENAME from  com_m_office  order by CHR_OFFICENAME");
for(int u=0; u<shipids.length; u++)
	if(shipids[u][0].trim().equals(oficeid.trim()))
		out.print("<option selected = 'selected' value='"+shipids[u][0]+"'>"+shipids[u][1] +"</option>");
	else
		out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][1] +"</option>");
%>
</select>						  </td>
						</tr>
						<tr class="bolddeepblue">
							<td height="24" valign="middle" class="boldEleven">Department<span class="boldred"> *</span> </td>
							<td valign="top" class="boldEleven">
<select name="Dept" id="Dept" class="formText135" style="width:200px">
								<option value="0">All</option>
								<%
		 
		String deptid[][] =  CommonFunctions.QueryExecute("SELECT INT_DEPARTID,CHR_DEPARTNAME FROM   com_m_depart   ORDER BY  CHR_DEPARTNAME");
		
		for(int u=0;u<deptid.length;u++)
			out.print("<option value='"+deptid[u][0]+"'>"+deptid[u][1]+"</option>"); 
	%>
							</select></td>
						</tr>
						<tr>
								  <td class="boldEleven">Category<span class="boldred"> *</span> </td>
								  <td class="boldEleven"> <select name="Category" class="formText135" id="Category" style="width:200px">
	<option value="0">All</option>
	<%
	 ;
	String empcategoryData[][]= CommonFunctions.QueryExecute(" SELECT INT_EMPLOYEECATEGORYID,CHR_CATEGORYNAME  FROM   com_m_employeecategory   ORDER BY CHR_CATEGORYNAME ");
	if (empcategoryData.length>0)
		for (int i=0; i<empcategoryData.length; i++) 
			out.println("<option value="+empcategoryData[i][0]+">"+empcategoryData[i][1] +"</option>");			
	
						%>

</select></td>
					  </tr>
						<tr class="bolddeepblue">
						  <td height="24" valign="middle" class="boldEleven"><span class="boldEleven">Resigned People<span class="boldred"> *</span> </span></td>
						  <td valign="top" class="boldEleven"><span class="boldEleven">
						    <input name="resigned" type="checkbox" class="formText135" id="resigned"
												value="Y">
						  </span></td>
					  </tr>
						<tr class="bolddeepblue">
							<td height="24" valign="middle" class="boldEleven">Order
							By <span class="boldred"> *</span> </td>
							<td valign="top" class="boldEleven"><select name="orderby"
								id="orderby" class="formText135" style="width:200px">
								<option value=" b.CHR_EMPID ">Emp Id</option>
								<option value=" b.CHR_USERID ">Emp 6digit Id</option>
								<option value=" b.CHR_STAFFNAME " selected="selected">Emp Name</option>
								 		%>
							</select></td>
						</tr>
						<tr >
                          <td class="boldEleven"  >Month<span class="boldred"> *</span> </td>
						  <td><span class="boldThirteen">
                            <select name="month" class="formText135" id="month" style="width:200">
                              <option value="0" >All</option>
                              <%@ include file="../JavaScript/Inventory/month.jsp"%>
                            </select>
                          </span></td>
					  </tr>
						<tr  >
                          <td class="boldEleven"  ><span  >Year<span class="boldred"> *</span> </span></td>
						  <td><span class="boldThirteen">
                            <select name="year" class="formText135"
							id="year"  style="width:200">
                              <%@ include file="../JavaScript/Inventory/year.jsp"%>
                            </select>
                            <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						setOptionValue('month',month1);
						setOptionValue('year',year1);							
				//-->
                        </script>
                          </span></td>
					  </tr>
						 
						<tr>
							<td height="28" colspan="2" valign="middle" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
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
										onClick="redirect('Payrollmain.jsp')"></td>
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
