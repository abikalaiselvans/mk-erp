<%@ page import="java.io.*,java.util.*"%>
<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>

<html>
<head>
<%
try
{

String ename = request.getParameter("ename");
String rights = request.getParameter("Rights");
String sql= "";
sql = " CHR_ADD_"+rights.trim()+" , CHR_EDIT_"+rights.trim()+", CHR_DELETE_"+rights.trim()+"";
sql = " select  FIND_A_EMPLOYEE_ID_NAME(a.CHR_EMPID),"+sql+" from m_user a, m_user_privilege b  ";
sql = sql +" WHERE a.CHR_USRNAME=b.CHR_USRNAME  ";
sql = sql +" AND a.CHR_EMPID = '"+ename+"' ";
String data[][] = CommonFunctions.QueryExecute(sql);

String achk="";
String ochk="";
%>

<title> :: UTILITY :: </title>

<%@include file="Redirect.jsp" %>
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
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
</head>
<body  onpaste='return false;'>
<form name="frm" method="get" action="Userprivilegeresponseupdate.jsp">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	 
	<tr>
		<td height="100">
		 
		</td>
	</tr>
	<tr align="center">
		<td align="center">
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="400"
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
					<td width="412">
					<table width="500" border="0" align="center"
						cellpadding="2" cellspacing="3"  >
						<tr>
							<td colspan="3" align="center" class="copyright">User <span class="BackGround">Privilege</span></td>
						</tr>
						<tr>
							<td width="131" class="boldEleven">User Name</td>
						  <td colspan="2" class="boldEleven"><%=data[0][0]%>
						    <input name="ename" type="hidden" id="ename" value="<%=ename%>">
						    <input name="rights" type="hidden" id="rights" value="<%=rights%>"></td>
						</tr>
						<tr>
							<td class="boldEleven">&nbsp; </td>
							<td width="114" class="boldEleven">&nbsp; </td>
							<td width="231" class="boldEleven"> </td>
						</tr>
						<tr>
						  <td class="boldEleven">Add
					      <%
		  achk="";
		  ochk="";
		  
		  if("Y".equals(data[0][1] ))
		  		achk = " checked='checked' ";
		
		  if("N".equals(data[0][1] ))
		  		ochk = " checked='checked' ";
				
		  %></td>
						  <td colspan="2" class="boldEleven"><table width="77" border="0" cellspacing="0" cellpadding="0">
						    <tr>
						      <td width="20"><input name="add" type="radio" value="Y" <%=achk%> /></td>
						      <td width="20" class="boldEleven">Yes</span></td>
						      <td width="20" class="boldEleven"><input name="add" type="radio"
										value="N" <%=ochk%> /></td>
						      <td width="40" class="boldEleven">No</span></td>
					        </tr>
					      </table></td>
					  </tr>
						<tr>
						  <td class="boldEleven">Edit
				          <%
		  achk="";
		  ochk="";
		  
		  if("Y".equals(data[0][2] ))
		  		achk = " checked='checked' ";
		
		  if("N".equals(data[0][2] ))
		  		ochk = " checked='checked' ";
				
		  %></td>
						  <td colspan="2" class="boldEleven"><table width="76" border="0" cellspacing="0" cellpadding="0">
						    <tr>
						      <td width="20"><input name="edit" type="radio" value="Y" <%=achk%> /></td>
						      <td width="20" class="boldEleven">Yes</span></td>
						      <td width="20" class="boldEleven"><input name="edit" type="radio"
										value="N" <%=ochk%> /></td>
						      <td width="40" class="boldEleven">No</span></td>
					        </tr>
					      </table></td>
					  </tr>
						<tr>
							<td class="boldEleven">Delete
					        <%
		  achk="";
		  ochk="";
		  
		  if("Y".equals(data[0][3] ))
		  		achk = " checked='checked' ";
		
		  if("N".equals(data[0][3] ))
		  		ochk = " checked='checked' ";
				
		  %></td>
							<td colspan="2" class="boldEleven"><table width="74" border="0" cellspacing="0" cellpadding="0">
							  <tr>
							    <td width="20"><input name="delete" type="radio" value="Y" <%=achk%> /></td>
							    <td width="20" class="boldEleven">Yes</span></td>
							    <td width="20" class="boldEleven"><input name="delete" type="radio"
										value="N" <%=ochk%> /></td>
							    <td width="40" class="boldEleven">No</span></td>
						      </tr>
						    </table></td>
						</tr>
						<tr>
							<td colspan="3" class="boldEleven">
							<table width="173" align="center">
								<tr>
									<td width="54"><input name="submit" type="submit"
										class="buttonbold" value="Update"></td>
									<td width="54"><input name="submit" type="button"
										class="buttonbold"  value="Close"   accesskey="c" 
										onClick="redirect('Userprivilege.jsp')"></td>
								</tr>
							</table>							</td>
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
		</table>
		</td>
	</tr>
	<tr align="center">
		<td align="center">&nbsp;</td>
	</tr>
	<tr>
		<td height="100" align="center"><font color="#ACACAC">&nbsp;
		</font></td>
	</tr>
</table>
</form>
</body>
</html>

<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>

