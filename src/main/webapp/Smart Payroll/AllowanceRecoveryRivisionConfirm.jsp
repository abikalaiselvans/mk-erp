 <%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.bean.payroll.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
 
<html>
<head>

<title> :: PAYROLL ::</title>


 
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">
alert("Please Confirm your updated data...");
</script>
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
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>

<body  onpaste="return false;"  >
<%@ include file="index.jsp"%>
 <table width="100%" border="0" align="center" cellpadding="2"
	cellspacing="2">
	<tr>
		<td></td>
	</tr>

	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="54">
		<table width="564" border="0" align="center" cellpadding="0"
			cellspacing="0" bgcolor="#dce4f9" class="BackGround">
			<tbody>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></td>
					<td class="BorderLine" height="1"><spacer height="1" width="1"
						type="block" /></td>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
				</tr>
				<tr>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
					<td width="6"><spacer height="1" width="1" type="block"></td>
					<td width="545" valign="top">
					<table width="549" border="0" cellspacing="2" cellpadding="0">
					 	 
						<tr>
						  <td height="19" colspan="2">
						    <div align="center">
						      <%  
							  //String  staffid= request.getAttribute("staffid").toString();
							   String  staffid= request.getParameter("staffid");
							  
							out.println("<table  cellpadding='2' cellspacing='2' class='TableDesign' >");
							out.println("<tr><td colspan='2'  class='whiteMedium'><div align='center'>Please Confirm your updated data...</div></td></tr>");
							
							out.println("<tr><td colspan='2'  class='whiteMedium'><div align='center'>BASIC</div></td></tr>");
							
							
							
							out.println("<tr  class='MRow1'> ");
							out.println(" <td class='boldEleven' align='left' > STAFFNAME ");
							out.println("<td align='right' ><b> " );
							out.println(staffid);
							out.println("</td>");
							out.println("</tr>");
							
							
							out.println("<tr  class='MRow1'> ");
							out.println(" <td class='boldEleven' align='left' > STAFFNAME ");
							out.println("<td align='right' ><b> " );
							out.println(CommonFunctions.QueryExecute("SELECT CHR_STAFFNAME from com_m_staff  WHERE CHR_EMPID='"+staffid+"'")[0][0]);
							out.println("</td>");
							out.println("</tr>");
							
							 
							out.println("<tr  class='MRow1'> ");
							out.println(" <td class='boldEleven' align='left' > BASIC ");
							out.println("<td align='right' ><b> " );
							out.println(CommonFunctions.QueryExecute("SELECT INT_SALARY from com_m_staff  WHERE CHR_EMPID='"+staffid+"'")[0][0]);
							out.println("</td>");
							out.println("</tr>");
						    out.println("</table>");
						%>						  
				          </div></td>
					  </tr>
						<tr>
						  <td height="19" colspan="2">&nbsp;</td>
					  </tr>
						<tr>
							<td height="19" colspan="2">

						 
							 
									<div align="center" >
									<%
						String all ="Alowance";
						String sv ="";
						 
				  		String query = "Select CHR_ACODE,CHR_ANAME from pay_m_allowance order by CHR_ACODE";
						String datas[][] = CommonFunctions.QueryExecute(query);
						
						
						out.println("<table width='300' align=1center1 cellpadding='2' cellspacing='2' class='TableDesign' ><tr>");
						out.println("<td colspan='2'  class='whiteMedium'><div align='center'>ALLOWANCE</div></td>");
						out.println("</tr>");
						out.println(" <tr>");
						for(int u=0; u<datas.length; u++)
						{
							if(u%2==0)
								out.println("<tr  class='MRow1'> ");
							else
								out.println("<tr  class='MRow2'> ");
							out.println(" <td class='boldEleven' align='left' >"+datas[u][1]);
							out.println("<td align='right' > <b>" );
							out.println(CommonFunctions.QueryExecute("SELECT "+datas[u][0]+" from pay_t_allowance  WHERE CHR_EMPID='"+staffid+"'")[0][0]);
							out.println("</td>");
						 
						}
						out.println("</table>");
						 
					%>
									</div>									 
								    
									
									
							 
							<div id="previoudallowance"></div>							</td>
						</tr>
						<tr>
							<td height="19">&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td height="19" colspan="2">
							 
									<div align="center">
									<%
				  		String rec ="Recovery";
			  			query = "Select CHR_RCODE,CHR_RNAME from pay_m_recovery order by CHR_RCODE";
						String datas1[][] = com.my.org.erp.common.CommonInfo.RecordSetArray(query);
						out.println("<table  cellpadding='2' cellspacing='2' class='TableDesign' ><tr>");
						out.println("<td colspan='2'  class='whiteMedium'><div align='center'>RECOVERY</div></td>");
						out.println("</tr>");
						out.println(" <tr>");
						for(int u=0; u<datas1.length; u++)
						{
							if(u%2==0)
								out.println("<tr  class='MRow1'> ");
							else
								out.println("<tr  class='MRow2'> ");
							out.println(" <td class='boldEleven'   align='left' >"+datas1[u][1]+"</td>");
							out.println("<td align='right' ><b> " );
							out.println(CommonFunctions.QueryExecute("SELECT "+datas1[u][0]+" from pay_t_recovery  WHERE CHR_EMPID='"+staffid+"'")[0][0]);
							out.println("</td>");
						}
						out.println("</table>");
						
				  %>
									</div>							</td>
						</tr>
						 
						<tr>
						  <td height="19" colspan="2"><table width="56" border="0" align="center" cellpadding="5" cellspacing="5">
                            <tr>
                              <td><input class="ButtonHead" type="button"
							name="Button"  value="Close"   accesskey="c"  onClick="redirect('Payrollmain.jsp')"></td>
                            </tr>
                          </table></td>
					  </tr>
						<tr>
							<td height="19" colspan="2">&nbsp;</td>
						</tr>
					</table>
					</td>
					<td nowrap="nowrap" width="5"><spacer height="1" width="1"
						type="block" /></td>
					<td class="BorderLine" width="2"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
				<tr>
					<td colspan="2" rowspan="2"><img height="7" src="../Image/General/BLCorner.gif" width="7" /></td>
					<td height="6"><spacer height="1" width="1" type="block"></td>
					<td colspan="2" rowspan="2" valign="bottom">
					<div align="right"><img height="7" src="../Image/General/BRCorner.gif" width="7" /></div>
					</td>
				</tr>
				<tr>
					<td class="BorderLine" height="1"><spacer height="1" width="1"
						type="block" /></td>
				</tr>

			</tbody>
		</table>
		</td>
	</tr>
	<tr>
		<td height="23">&nbsp;</td>
	</tr>
	<tr>
		<td height="40">&nbsp;</td>
	</tr>
</table>
<%@ include file="../footer.jsp"%> 
</body>

</html>
