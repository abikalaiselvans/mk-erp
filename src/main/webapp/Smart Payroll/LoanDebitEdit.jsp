<%@ page import="java.io.*,java.util.*"%>
<%@page import="com.my.org.erp.bean.payroll.*"%>
<%@page import="com.my.org.erp.SmartPayroll.*"%>
<%@ page import="com.my.org.erp.common.CommonInfo"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>

<jsp:useBean id="conbean" class="DBConnection.DBCon"></jsp:useBean>

<html>
<head>
<title>:: PAYROLL ::</title>
 
<script src="../JavaScript/common/StaffloadAjax.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"> </script>
<script language="javascript">
function validate()
{
    if(
	checkNullSelect('loantype','select loan type','0') 
	&& checkNull("debitdate","Select Debit Date") 
	&& checkNull("debitloanamount","Enter Debit Amount") 
	&& checkNull("desc","Enter Description") 
	&& checkNullSelect('mode','Cash Mode','0') 
	 	
	)
    	return true;
    else
    	return false;
}

function list()
  {   
     if(checkNull("ename","Select Staff"))
	 {
        return true;
     }
     else
     {
     	return false;
     }     
   }
 
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
.style3 {COLOR: #000000; LINE-HEIGHT: 15px; FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; TEXT-DECORATION: none; font-size: 10px;}
-->
</style>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>

<body  onpaste="return false;" onLoad="init()">
<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   name="loan" action="../SmartLoginAuth" onSubmit="return validate()">
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
							<td width="100%" height="20">
							<div align="center"><strong>Staff Loan Debit Details</strong>
							</div>
							<%
				String dbvalue="";
			 %><%
				   	String id =request.getParameter("id");
				   String sql1="SELECT  INT_LOANID,CHR_EMPID,DAT_DEBIT,INT_DEBIT_AMOUNT,CHR_MODE,CHR_DESCRIPTION from  pay_t_loandebit where INT_LOAN_DEBITID="+id+"";
				  String debitinfo[][] = CommonFunctions.QueryExecute(sql1);
				   String Empid =debitinfo[0][1];
				  %></td>
						</tr>
						<tr>
							<td>
							<div align="right"><span class="boldEleven">* </span><span
								class="changePos">Mandatory</span></div>							</td>
						</tr>
						<tr>
							<td></td>
						</tr>
						<tr>
							<td></td>
						</tr>
						
						<tr>
							<td height="19">
							<table width="433" border="0" align="center" cellpadding="2"
								cellspacing="2">
								
								
								<tr>
									<td class="boldEleven">Employee Name</td>
								    <td class="bold1">	<%=CommonFunctions.QueryExecute("SELECT FIND_A_EMPLOYEE_ID_NAME('"+Empid+"') " )[0][0]%>			</td>
								</tr>
								<tr>
									<td class="boldEleven">Loan Type<span class="bolddeepred">*</span></td>
								  <td class="tabledata">
									
									  <select name="loantype"  id="loantype"class="formText135" > 
									  <option value="0">Select</option>
									  <%
	String loandata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT  INT_LOANID,CHR_LOANNAME FROM  pay_m_loan ORDER BY CHR_LOANNAME ");
	 if(loandata.length>0)
		for(int h=0;h<loandata.length;h++)
		out.print("<option selected='selected' value='"+loandata[h][0]+"'>"+ loandata[h][1] +"</option>");
		
%>
								      </select><script language="javascript">setOptionValue("loantype","<%=debitinfo[0][0]%>") </script>							      </td>
								</tr>
								
								<tr>
									<td width="108" align="left" valign="middle"
										  class="boldEleven">Debit   Date<span class="bolddeepred">*</span></td>
									<td>
									
									
									 <%
									dbvalue=debitinfo[0][2];
									
									if (dbvalue.equalsIgnoreCase("null") ||dbvalue.equalsIgnoreCase(""))
										dbvalue="";
									else
										{
										 String sdt[] = dbvalue.split("-");	
										 dbvalue = sdt[2]+"-"+sdt[1]+"-"+sdt[0];
										} 
									%>	
									<input name="debitdate" type="text" class="formText135"
										id="debitdate" onKeyPress="numericHypenOnly('debitdate',10)"
										size="20" maxlength="10" readonly="readonly" value="<%=dbvalue%>"/> 
									<a
										href="javascript:cal1.popup();"> <img
										src="../JavaScript/img/cal.gif" width="16" height="16"
										border="0" alt="Click here to Pick Up the Date"></a> <script
										language="JavaScript">
<!--
  var cal1=new calendar1(document.forms['loan'].elements['debitdate']);
  cal1.year_scroll=true;
  cal1.time_comp=false;
 //  setCurrentDate('creditdate');
//-->
</script></td>
								</tr>
								<tr>
									<td align="left" valign="middle"  
										class="boldEleven">Debit   Amount<span class="bolddeepred">*</span></td>
									<td><input name="debitloanamount" type="text" class="formText135"
										id="debitloanamount"  onKeyPress="return numeric_only(event,'debitloanamount','14')"
										size="20" maxlength="10" value="<%=debitinfo[0][3]%>"></td>
								</tr>
								<tr>
									<td align="left" valign="top"  
										class="boldEleven">Description<span class="bolddeepred">*</span></td>
									<td><textarea name="desc" cols="40" rows="7"
										class="formText135" id="desc"><%=debitinfo[0][5]%></textarea></td>
								</tr>
								<tr>
									<td class="boldEleven">Cash Mode<span class="bolddeepred">*</span></td>
									<td class="tabledata">
									
									  <select name="mode"  id="mode" class="formText135" > 
									  <option value='0'>Select</option>
									  <option value='D'>Demand Draft</option>
									  <option value='C'>Cash</option>
									  <option value='Q'>Cheque</option>
									  <option value='E'>NEFT</option>
								      </select>	<script language="javascript">setOptionValue("mode","<%=debitinfo[0][4]%>") </script></td>
								</tr>
							</table></td>
						</tr>
						<tr>
							<td height="19">
							<div align="center">
								<input name="filename" type="hidden" id="filename" value="StaffLoanDebit" /> 
								<input name="actionS" type="hidden" id="actionS" value="PAYStaffLoanDebitEdit"/>
								<input name="idloan" type="hidden" id="idloan" value="<%=id%>"/>
								</div>							</td>
						</tr>
						<tr>
							<td height="19">
							<table border="0" align="center" cellpadding="2" cellspacing="2">
								<tr>
									<td width="56"><input type="submit" name="Submit"
										id="submit_btn" class="buttonbold14" value="Edit" /></td>
									<td width="56"><input type="button" name="submit"
										class="buttonbold14"  value="Close"   accesskey="c" 
										onClick="redirect('LoanDebitView.jsp')" /></td>
								</tr>
							</table></td>
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
<%@ include file="../footer.jsp"%></form></body></html>