<%@ page   language="java" 	import="java.sql.*" %>
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
<script language="javascript" src="../JavaScript/Attendance/ReportAjax.js"></script>
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
 

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>
<!--onLoad="disable()"-->
<body  onpaste="return false;" >
<%@ include file="index.jsp"%>
 
 
 <script language="JavaScript" src="../JavaScript/jquery/jquery-1.7.1.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/jquery/ui/jquery.ui.core.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/jquery/ui/jquery.ui.widget.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js" type="text/javascript"></script>
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css" />

<script language="javascript">
 	
	
	$(function() {
		var dates = $( "#doj, #doj2" ).datepicker({
			defaultDate: "+1w",
			changeMonth: true,
			changeYear: true,
			 showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			numberOfMonths: 1,
			buttonImageOnly: true,
			onSelect: function( selectedDate ) 
			{
				var option = this.id == "doj" ? "minDate" : "maxDate",
					instance = $( this ).data( "datepicker" ),
					date = $.datepicker.parseDate(instance.settings.dateFormat || $.datepicker._defaults.dateFormat, selectedDate, instance.settings );
					dates.not( this ).datepicker( "option", option, date );
			}
		});
	}); 
	
	 
</script>

<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="OriginalSalaryResponses2.jsp">
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
							<td height="18" colspan="2"  class="BackGround">ORIGINAL SALARY REPORT </td>
						</tr>

						<tr class="bolddeepblue">
							<td height="24" valign="middle" class="bolddeepblue"><!--DWLayoutEmptyCell-->&nbsp;</td>
							<td valign="top" class="bolddeepblue"><!--DWLayoutEmptyCell-->&nbsp;</td>
						</tr>
						<tr>
						<td width="162" height="28" valign="middle" class="boldEleven">
							Company</td>
							<td width="178"><select name="company" id="company"
								  onChange="loadBranch()"  
								class="formText135" style="width:200px">
                                <option value="0">All</option>
								<%                  
     					String queryBranch1="SELECT INT_COMPANYID,CHR_COMPANYNAME FROM  com_m_company ";
     					String	branch1[][]=CommonFunctions.QueryExecute(queryBranch1);
     					for(int i=0;i<branch1.length;i++)
 	 						out.println("<option value='"+branch1[i][0]+"'>"+branch1[i][1]+"</option>");
 			   %>
							</select></td>
						</tr>
						<tr>
							<td width="162" height="28" valign="middle" class="boldEleven">
							Branch</td>
							<td width="178"><select name="branch" id="branch"
								class="formText135" style="width:200px">
								<option value="0">All</option>
							</select></td>
						</tr>	
							
						<tr class="bolddeepblue">
							<td width="196" height="24" valign="middle" class="boldEleven">Office</td>
							<td width="286" valign="top" class="bolddeepblue">
							<%
			   	String branchid=""+session.getAttribute("BRANCHID");
	   			String oficeid=""+session.getAttribute("OFFICEID");
				 
			  %> <select name="Office" class="formText135" id="Office" style="width:200px">
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
							<td height="24" valign="middle" class="boldEleven">Department</td>
							<td valign="top" class="bolddeepblue"><select name="Dept"
								id="Dept" class="formText135" style="width:200px">
								<option value="0">All</option>
								<%
		sq="SELECT INT_DEPARTID,CHR_DEPARTNAME FROM   com_m_depart   ORDER BY  CHR_DEPARTNAME";
		String deptid[][] = CommonFunctions.QueryExecute(sq);
		
		for(int u=0;u<deptid.length;u++)
			out.print("<option value='"+deptid[u][0]+"'>"+deptid[u][1]+"</option>"); 
	%>
							</select></td>
						</tr>
						<tr>
								  <td class="boldEleven">Category</td>
								  <td> <select name="Category" class="formText135" id="Category" style="width:200px">
	<option value="0">All</option>
	<%
	String empcategorysql=" SELECT INT_EMPLOYEECATEGORYID,CHR_CATEGORYNAME  FROM   com_m_employeecategory   ORDER BY CHR_CATEGORYNAME ";
	String empcategoryData[][]=CommonFunctions.QueryExecute(empcategorysql);
	if (empcategoryData.length>0)
		for (int i=0; i<empcategoryData.length; i++) 
			out.println("<option value="+empcategoryData[i][0]+">"+empcategoryData[i][1] +"</option>");			
	
						%>

</select></td>
							  </tr>
						<tr class="bolddeepblue">
						  <td height="24" valign="middle" class="boldEleven">Filter with DOJ </td>
						  <td valign="top" class="bolddeepblue"><span class="boldEleven">
						    <input name="dojFilter" type="checkbox" id="dojFilter"
												value="Y">
						  </span></td>
					  </tr>
						<tr class="bolddeepblue">
						  <td height="24" valign="middle" class="boldEleven">DOJ From </td>
						  <td valign="top" class="bolddeepblue"><input title="dd-mm-yyyy"   name="doj"  id="doj"  type="text" class="formText135" size="25" maxlength="10" readonly="readonly"  tabindex="3"  />
<script language="javascript">setCurrentDate('doj')</script>						  </td>
					  </tr>
						<tr class="bolddeepblue">
						  <td height="24" valign="middle" class="style3"><span class="boldEleven">DOJ To </span></td>
						  <td valign="top" class="bolddeepblue"><input title="dd-mm-yyyy"   name="doj2"  id="doj2"  type="text" class="formText135" size="25" maxlength="10" readonly="readonly"  tabindex="3"  /><script language="javascript">setCurrentDate('doj2')</script></td>
					  </tr>
						<tr class="bolddeepblue">
						  <td height="24" valign="middle" class="style3"><span class="boldEleven">Resigned People</span></td>
						  <td valign="top" class="bolddeepblue"><span class="boldEleven">
						    <input name="resigned" type="checkbox" id="resigned"
												value="Y">
						  </span></td>
					  </tr>
						<tr class="bolddeepblue">
							<td height="24" valign="middle" class="boldEleven">Order
							By </td>
							<td valign="top" class="bolddeepblue"><select name="orderby"
								id="orderby" class="formText135" style="width:200px">
								<option value=" a.CHR_EMPID ">Emp Id</option>
								<option value=" a.CHR_USERID ">Emp 6digit Id</option>
								<option value=" a.CHR_STAFFNAME " selected="selected">Emp Name</option>
								<option value=" a.DT_DOJCOLLEGE "  >DOJ</option>
								 		%>
							</select></td>
						</tr>
						<tr>
							<td height="28" colspan="2" valign="middle" class="bolddeepblue"><!--DWLayoutEmptyCell-->&nbsp;</td>
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
