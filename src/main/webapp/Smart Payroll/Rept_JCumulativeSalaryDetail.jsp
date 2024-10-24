<%@ page import="com.my.org.erp.common.CommonFunctions"%>

  <html>
<head>
 
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
 
 
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

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
.style8 {font-family: Verdana;
	font-size: 12px;
}
-->
</style>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>

<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/smartcommon/LoadBranchAjax.js"></script>
<script language="javascript" type="text/javascript">
function Validate()
  {

  	if(checkNullSelect( "company","Select Company" ,'0') && checkNullSelect('Month','Select Month','select') && checkNullSelect( "reportType","Select Export Type" ,'0'))	
		return true;
	else
	return false;
}
</script>

</head>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >

<%@ include file="index.jsp"%>
<!--PaySlipView.jsp-->
<form  AUTOCOMPLETE = "off"   method="post" action="../SmartLoginAuth" onSubmit="return Validate()">
<table width="100%" height="285" border="0" align="center"
	cellpadding="0" cellspacing="0">
	<tr>
		<td height="31">&nbsp;</td>
	</tr>
	<tr>
		<td height="198">
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="390"
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

					  <table width="455" border="0" align="center" cellpadding="0"
						cellspacing="0"  >
                        <!--DWLayoutTable-->
                        <tr align="center" valign="middle">
                          <td height="30" colspan="2" class="BackGround" >CUMULATIVE SALARY REPORT </td>
                        </tr>
                        <tr>
                          <td width="162" height="28" valign="middle" class="boldEleven"> Company <span class="bolddeepred">*</span> </td>
                          <td width="178"><select name="company" id="company"
onblur="loadBranch()" 
								class="formText135" style="width:200px">
                              <option value="0">Select</option>
                              <%                  
     					String queryBranch1="SELECT INT_COMPANYID,CHR_COMPANYNAME FROM  com_m_company  ORDER BY CHR_COMPANYNAME";
     					String	branch1[][]= CommonFunctions.QueryExecute(queryBranch1);
     					for(int i=0;i<branch1.length;i++)
 	 						out.println("<option value='"+branch1[i][0]+"'>"+branch1[i][1]+"</option>");
 			   %>
                          </select></td>
                        </tr>
                        <tr>
                          <td width="162" height="28" valign="middle" class="boldEleven"> Branch <span class="bolddeepred">*</span> </td>
                          <td width="178"><span class="tabledata">
                            <select name="branch" id="branch"
								class="formText135" style="width:170px">
                              <option value="0">All</option>
                            </select>
                          </span></td>
                        </tr>
                        <tr align="center" valign="middle">
                          <td height="28" align="left" valign="middle" class="boldEleven">Office <span class="bolddeepred">*</span> </td>
                          <td align="left" valign="middle" class="boldEleven"><span
								class="bolddeepblue">
                            <%
			   	String branchid=""+session.getAttribute("BRANCHID");
	   			String oficeid=""+session.getAttribute("OFFICEID");
				 
			  %>
                            <select name="Office" class="formText135" id="Office">
                              <option value="0">All</option>
                              <%
								
		

		String shipids[][] =  CommonFunctions.QueryExecute(" select INT_OFFICEID,CHR_OFFICENAME from  com_m_office  order by CHR_OFFICENAME");
		for(int u=0; u<shipids.length; u++)
			if(shipids[u][0].trim().equals(oficeid.trim()))
				out.print("<option selected = 'selected' value='"+shipids[u][0]+"'>"+shipids[u][1] +"</option>");
			else
				out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][1] +"</option>");
							%>
                            </select>
                          </span></td>
                        </tr>
                        <tr class="bolddeepblue">
                          <td height="24" valign="middle" class="boldEleven">Department <span class="bolddeepred">*</span></td>
                          <td valign="top" class="bolddeepblue"><select name="dept"
								id="dept" class="formText135">
                              <option value="0">All</option>
                              <%
		 
		String deptid[][] =  CommonFunctions.QueryExecute("SELECT INT_DEPARTID,CHR_DEPARTNAME FROM   com_m_depart   ORDER BY  CHR_DEPARTNAME");
		
		for(int u=0;u<deptid.length;u++)
			out.print("<option value='"+deptid[u][0]+"'>"+deptid[u][1]+"</option>"); 
	%>
                          </select></td>
                        </tr>
                        <tr align="center" valign="middle">
                          <td width="162" height="28" align="left" valign="middle"
								class="boldEleven">Month <span class="bolddeepred">*</span> </td>
                          <td width="178" align="left" valign="middle" class="boldEleven"><select name="Month" class="formText135" id="Month" style="width:100">
                              <option value="select">Select</option>
                              <option value="0" selected="selected">All</option>
                              <option value="01">January</option>
                              <option value="02">February</option>
                              <option value="03">March</option>
                              <option value="04">April</option>
                              <option value="05">May</option>
                              <option value="06">June</option>
                              <option value="07">July</option>
                              <option value="08">August</option>
                              <option value="09">September</option>
                              <option value="10">October</option>
                              <option value="11">November</option>
                              <option value="12">December</option>
                            </select>
                          </td>
                        </tr>
                        <tr>
                          <td valign="middle" height="28" class="boldEleven">Year <span class="bolddeepred">*</span> </td>
                          <td valign="middle" class="boldEleven"><%@ include
								file="../JavaScript/year.jsp"%>
                              <script	language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						setOptionValue('Month',month1);
						setOptionValue('Year',year1);							
				//-->
                        </script></td>
                        </tr>
                        <tr>
                          <td valign="middle" height="28" class="boldEleven">Export Type <span class="bolddeepred">*</span> </td>
                          <td valign="middle" class="boldEleven"><select name="reportType" id="reportType">
                              <option value="0">Select Export Type</option>
                              <option value="csv">CSV</option>
                              <option value="xls">Excel</option>
                              <option value="html">HTML</option>
                              <option value="pdf" selected="selected">PDF</option>
                              <option value="txt">Text</option>
                              <option value="rtf">Word</option>
                              <option value="xml">XML</option>
                          </select></td>
                        </tr>
                        <tr>
                          <td height="28" colspan="2" valign="middle" class="bolddeepblue"><div align="center">
                              <table border="0" cellspacing="3" cellpadding="0">
                                <tr>
                                  <td width="56"><input class="buttonbold14" type="submit"
										name="Submit2" value="Submit"   accesskey="s"    /></td>
                                  <td width="56"><input class="buttonbold14" type="button"
										name="Submit"  value="Close"   accesskey="c" 
										onclick="redirect('PayRollConsolidation.jsp')" /></td>
                                </tr>
                              </table>
                            <span class="boldEleven">
                              <input name="filename" type="hidden" id="filename"
										value="Rept_JCumulativeSalaryDetail" />
                              <input name="actionS"
										type="hidden" id="actionS"
										value="PAYRept_JCumulativeSalaryDetail" />
                              <input name="rptfilename" type="hidden" id="rptfilename" value="PageWidth3200" />
                          </span></div></td>
                        </tr>
                      </table></td>
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
		<td height="19"></td>
	</tr>
	<tr>
		<td height="37">&nbsp;</td>
	</tr>
</table>
</form>

<%@ include file="../footer.jsp"%>
</body>
</html>
