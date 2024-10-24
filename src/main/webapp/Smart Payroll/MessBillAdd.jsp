<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.bean.payroll.*"%>
<%@ page import="com.my.org.erp.SmartPayroll.*"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon"></jsp:useBean>

<html>
<head>

<title> :: PAYROLL ::</title>


 
 
<script src="../JavaScript/common/StaffloadAjax.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"> </script>
<script language="javascript">
function validate()
{
    if(checkNull("ename","Select Staff")&& checkNullSelect("Month","select the Month","Select")  
	&& checkNull("TxtAmount","Enter the Amount")) 
	 
	
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
 
function due()
  {
      document.advance.dueamount.value=parseInt(document.advance.advamount.value/document.advance.noinstalment.value);
  }		

function manual()
  {  
	 //document.advance.advamount.disabled=true;
	 document.advance.noofinstal.disabled=true;
	 document.advance.dueamount.disabled=true;
	 //document.advance.advamount.value="0";
	 document.advance.dueamount.value="0";
	 document.advance.noofinstal.value="0";
  }
 
  function automatic()
  {
     //document.advance.advamount.disabled=false;
	 document.advance.noofinstal.disabled=false;
	 document.advance.dueamount.disabled=false;
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
.style4 {color: #FF0000}
-->
</style>
</head>

<body  onpaste="return false;" onLoad="init()">
<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   name="advance" action="../SmartLoginAuth" onSubmit="return validate()">
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
							<td height="20" colspan="2">
							<div align="center"><strong>Mess Bill Details</strong></div>
							</td>
						</tr>
						<tr>
							<td colspan="2">
							<div align="right"><font color="#FF0000">*</font> <span
								class="changePos">Mandatory</span></div>
							</td>
						</tr>
						<tr>
							<td colspan="2"></td>
						</tr>
						<tr>
							<td colspan="2"></td>
						</tr>

						<tr>
							<td width="49%" height="19">&nbsp;</td>
							<td width="51%">&nbsp;</td>
						</tr>
						<tr>
							<td height="19" colspan="2">
							<div align="center"><%@ include
								file="../JavaScript/ajax.jsp"%></div>
							</td>
						</tr>
						<tr>
							<td height="19" colspan="2"></td>
						</tr>
						<tr>
							<td height="19" colspan="2">
							<table width="233" border="0" align="center" cellpadding="2"
								cellspacing="2">
								<tr>
									<td width="97"   class="bolddeepblue">Year
									<font color="#ff0000">*</font></td>
									<td width="122"><%@ include file="../JavaScript/year.jsp"%></td>
								</tr>
								<tr>
									<td   class="bolddeepblue">Month <font
										color="#ff0000">*</font></td>
									<td><%@ include file="../JavaScript/monthName.jsp"%></td>
								</tr>
								<tr>
									<td   class="tabledata"><span
										class="bolddeepblue">Amount</span> <font color="#ff0000">*</font>
									</td>
									<td><input name="TxtAmount" type="text"
										class="formText135" id="TxtAmount"
										onkeyPress="numericValue('TxtAmount',6)" size="14"></td>
								</tr>
								<tr>
									<td   class="bolddeepblue">Cheque No</td>
									<td><input name="TxtChequeno" type="text"
										class="formText135"
										onkeyPress="alphaNumeric('TxtChequeno',10)" size="14"></td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td height="19" colspan="2">
							<div align="center"><input name="filename" type="hidden"
								id="filename" value="StaffMessBill" /> <input name="actionS"
								type="hidden" id="actionS" value="PAYStaffMessBillAdd" /></div>
							</td>
						</tr>
						<tr align='center'>
							<td colspan="2" align='center'>
							<table align='center' border="0" width="500">
								<tr>
									<td>

									<div id="disp" style="OVERFLOW:auto; width:500px; height:75px;">

									<%
					String id = request.getParameter("ID");	
					//System.out.println("\n\n\nID : "+id);
					if (id==null || id=="")
					{
						//System.out.println("");
					}
					else
					{
						out.print("<table width='500' border='1' cellspacing='2' cellpadding='2' bordercolor='#EEEAFE'>");
						out.print("<tr  class='MRow2'>");
						out.print("<td colspan='5' class='boldEleven'><font color='red'><b>The following Details are Already Avilable....</b></font></td>");
						out.print("<tr  class='MRow1'>");
						out.print("<td class='boldEleven'>&nbsp;<b>Name</b></td> <td><b>Amount</b></td><td><b>Cheque</b></td><td><b>Month</b></td><td><b>Year</b></td>");
						out.print("<tr  class='MRow2'>");
						out.print("<td class='boldEleven'>&nbsp;"+request.getParameter("Name")+"</td>");
						out.print("<td class='boldEleven'>&nbsp;"+request.getParameter("Amount")+"</td>");
						out.print("<td class='boldEleven'>&nbsp;"+request.getParameter("Cheque")+"</td>");
						out.print("<td class='boldEleven'>&nbsp;"+request.getParameter("Month")+"</td>");
						out.print("<td class='boldEleven'>&nbsp;"+request.getParameter("Year")+"</td>");
						out.print("</tr></table>");
						
					}
			%>
									</div>

									</td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td height="19" colspan="2">
							<table border="0" align="center" cellpadding="2" cellspacing="2">
								<tr>
									<td width="56"><input type="submit" name="Submit"
										id="submit_btn" class="buttonbold14" value="Submit"   accesskey="s"    /></td>
									<td width="56"><input type="button" name="submit"
										class="buttonbold14"  value="Close"   accesskey="c" 
										onClick="redirect('Mess Bill.jsp')" /></td>
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
		<td height="40"><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
</form>