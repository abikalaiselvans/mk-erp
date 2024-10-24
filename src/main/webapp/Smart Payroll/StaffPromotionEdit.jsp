<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.bean.Attendance.*"%>
<%@ page import="com.my.org.erp.bean.payroll.*"%>
<%@ page import="com.my.org.erp.SmartPayroll.*"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon"></jsp:useBean>

<html>
<head>

<title> :: PAYROLL ::</title>


 <style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>

 

 
 
<script src="../JavaScript/AJAXFunction.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"> </script>
<script language="JavaScript">
function validateFields()
    {
   	 if(checkNull('promotiondate','Enter Promotion Date')  
   	&& checkNullSelect('toDesigId','Select Designation Name','Select')
	 && checkNull('reason','Enter Reason') 
	 )
   	  {   	 	
   	 	   return true;
   	   }
   	 else{
   	   return false;	  
   	 }
	 }
</script>

<script type="text/JavaScript">
<!--
function MM_jumpMenu(targ,selObj,restore){ //v3.0
  eval(targ+".location='MessBillEdit.jsp?SelMonth="+selObj.options[selObj.selectedIndex].value+"'");
  if (restore) selObj.selectedIndex=0;
}
//-->
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

 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>

<body  onpaste='return false;'>
<%@ include file="index.jsp"%>
<%
try
{
%>
<form  AUTOCOMPLETE = "off"   name="StaffPromotion" action="../SmartLoginAuth"
	onSubmit="return validateFields()">
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
		<table width="563" border="0" align="center" cellpadding="0"
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
					<td width="549" valign="top">
					<table width="549" border="0" cellspacing="0" cellpadding="0">
						<tr class="boldEleven">
							<td height="20">
							<div align="center"><strong>EMPLOYEE PROMOTION </strong><strong>
							  <%
String staff =request.getParameter("staffid");
 
if(!com.my.org.erp.common.CommonFunction.RecordExist("SELECT count(*) FROM pay_m_emp_promotion   WHERE CHR_EMPID='"+staff+"' "))
{
%>
<script language="javascript">location="error.jsp?msg=Record not found..."</script>
<%

}

 

String sql = " SELECT a.INT_PROMOTION_ID,a.CHR_EMPID,b.CHR_STAFFNAME,DATE_FORMAT(a.DT_PRODATE,'%d-%m-%Y'), ";
sql = sql+ " a.INT_FROM_DESIGID,a.INT_TO_DESIGID,a.CHR_REASON,a.CHR_SALARYCHANGE  ";
sql = sql+ " FROM pay_m_emp_promotion a ,com_m_staff b ";
sql = sql+ " WHERE a.CHR_EMPID=b.CHR_EMPID AND a.CHR_EMPID='"+staff+"'";
sql = sql+ " ORDER BY a.INT_PROMOTION_ID DESC ";
String Datas[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);

String staffname=  Datas[0][2];
    
		%> </strong></div>
							</td>
						</tr>
						<tr>
							<td>
							<div align="right"><span class="boldEleven">* </span><span
								class="changePos">Mandatory</span></div>
							</td>
						</tr>
						<tr>
							<td></td>
						</tr>
						<tr>
							<td></td>
						</tr>

						<tr>
							<td height="19">
							<table width="80%" border="0" align="center" cellpadding="2"
								cellspacing="2">
								<tr>
									<td width="140" align="left" valign="middle"  
										class="boldEleven">Staff id</td>
									<td class="boldEleven"><%=staff%> <input name="staffid"
										type="hidden" id="staffid" value="<%=Datas[0][1]%>"> <input
										name="rowid" type="hidden" id="rowid"
										value="<%=Datas[0][0]%>"></td>
								</tr>
								<tr>
									<td align="left" valign="middle"  
										class="boldEleven">Staff Name</td>
									<td class="boldEleven"><%=staffname %></td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">Promotion Date									 <span class="boldred">*</span> </td>
									<td width="176" class="boldEleven"><input
										name="promotiondate" type="text" class="formText135"
										id="promotiondate" readonly 
										value="<%=Datas[0][3]%> " size="12" maxlength="10"> 
									<a
										href="javascript:cal2.popup();"> <img
										src="../JavaScript/img/cal.gif" width="16" height="16"
										border="0" alt="Click here to Pick Up the Date"> </a> <script
										language="JavaScript">
<!--
  var cal2=new calendar1(document.forms['StaffPromotion'].elements['promotiondate']);
  cal2.year_scroll=true;
  cal2.time_comp=false;
  
//-->
</script></td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">Present Designation</td>
									<td class="boldEleven"><%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_DESIGNAME FROM com_m_desig WHERE INT_DESIGID="+Datas[0][4])[0][0]%></td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">Transfer Designation <span class="boldred">*</span> </td>
									<td class="boldEleven"><select name="toDesigId"
										class="formText135" id="toDesigId">
										<option value="Select">Select</option>
										  <%
                                              String sql1="SELECT INT_DESIGID,CHR_DESIGNAME FROM com_m_desig ORDER BY CHR_DESIGNAME";
                                              String desg[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql1);
                                              for(int i=0;i<desg.length;i++){
                                            	  out.println("<option value="+desg[i][0]+">"+desg[i][1]+"</option>");		
                                              }
                                            %>
									</select>
									<script language="javascript">setOptionValue('toDesigId','<%=Datas[0][5]%>')</script>
									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">Reason									 <span class="boldred">*</span> </td>
									<td class="boldEleven"><textarea name="reason" rows="5"
										class="formText135" id="reason" onKeyPress="textArea('reason','250')"><%=Datas[0][6]%></textarea></td>
								</tr>
								<tr>
                                  <td valign="top" class="boldEleven"><!--Change Salary details  <span class="boldred">*</span>--> </td>
								  <td class="boldEleven">
								  <%
								   String s1="";
								   if("Y".equals(Datas[0][7]))
								   		s1= "checked  = 'checked' ";
								  %>
								  <input name="salary" type="hidden" id="salary"   value="<%=Datas[0][7]%>"></td>
							  </tr>
							</table>
							</td>
						</tr>
						<tr>
							<td height="19">&nbsp;</td>
						</tr>
						<tr>
							<td height="19">
							<div align="center"><input name="filename" type="hidden"
								id="filename" value="StaffPromotion" /> <input name="actionS"
								type="hidden" id="actionS" value="PAYStaffPromotionUpdate" /></div>
							</td>
						</tr>
						<tr>
							<td height="19">
							<table border="0" align="center" cellpadding="2" cellspacing="2">
								<tr>
									<td width="56"><input type="submit" name="Submit"
										id="submit_btn" class="buttonbold14" value="Update" /></td>
									<td width="56"><input type="button" name="submit"
										class="buttonbold14"  value="Close"   accesskey="c" 
										onClick="javascript:history.back()" /></td>
								</tr>
							</table>
							</td>
						</tr>
					</table>
					</td>
					<td nowrap="nowrap" width="6"><spacer height="1" width="1"
						type="block" /></td>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BLCorner.gif" width="7" /></td>
					<td height="6"><spacer height="1" width="1" type="block"></td>
					<td colspan="2" rowspan="2" valign="bottom">
					<div align="right"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></div>
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
<%
 }
 catch(Exception e)
 {
 }
 %> <%@ include file="../footer.jsp"%></form>