<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.bean.payroll.*"%>
<%@ page import="com.my.org.erp.SmartPayroll.*"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon"></jsp:useBean>

<html>
<head>

<title> :: PAYROLL ::</title>


 
 
<script src="../JavaScript/AJAXFunction.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"> </script>
<script language="javascript">
function validate()
{
    if(checkNullSelect("staff","Select Staff",'0')
    && checkNull("reason","Enter reason"))
    	return true;
    else
    	return false;
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

<body  onpaste='return false;'>
<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   name="Cessation" action="../SmartLoginAuth" onSubmit="return validate()">
<table width="100%" border="0" align="center" cellpadding="2"
	cellspacing="2">
	<tr>
		<td></td>
	</tr>

	<tr>
		<td height="54">
		  <span class="bolddeepblue">
		  <input
								type="hidden" name="actionS" value="PAYResignationAcceptanceEdit">
          <input name="filename" type="hidden" id="filename" value="Resignation">
          <input name="id" type="hidden" id="id" value="<%//= id%>">
		  </span>
		  <table width="429" border="0" align="center" cellpadding="0"
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
				  <td width="410" valign="top"><table width="410" border="0" align="center" cellpadding="2" cellspacing="2">
                    <tr>
                      <th colspan="5" class="bold1" scope="col"><div align="center">Resignation Acceptance </div></th>
                    </tr>
                    <tr>
                      <th width="18" class="boldEleven" scope="col">&nbsp;</th>
                      <th width="110" class="boldEleven" scope="col"><div align="left">Staff Id </div></th>
                      <th colspan="3" scope="col"><div align="left">
                        <select name="staff" class="boldEleven" id="staff">
                          <option value="0" selected>Select</option>
                          <%
                          String sql="select CHR_EMPID,CHR_STAFFNAME from com_m_staff where CHR_EMPID in(select CHR_EMPID from pay_t_resignationletter where CHR_ACCEPTSTATUS='N' AND CHR_REPORTINGTO='"+""+session.getAttribute("EMPID")+"')";
                          String data[][]=com.my.org.erp.common.CommonInfo.RecordSetArray(sql);
                          for(int i=0;i<data.length;i++)
                        	  out.println("<option value='"+data[i][0]+"'>"+data[i][0]+" / "+data[i][1]+"</option>");
                          
                          %>
                        </select>
                      </div></th>
                    </tr>
                    <tr>
                      <th class="boldEleven" scope="col">&nbsp;</th>
                      <th class="boldEleven" scope="col"><div align="left">Status</div></th>
                      <th width="95" class="boldEleven" scope="col"><div align="left">
                        <input name="status" type="radio" value="N" checked>
                      Pending </div></th>
                      <th width="74" class="boldEleven" scope="col"><div align="left">
                        <input name="status" type="radio" value="Y">
                      Accept </div></th>
                      <th width="81" class="boldEleven" scope="col"><div align="left">
                        <input name="status" type="radio" value="R">
                        Reject</div></th>
                    </tr>
                    <tr>
                      <th class="boldEleven" scope="col">&nbsp;</th>
                      <th class="boldEleven" scope="col"><div align="left">Reason</div></th>
                      <th colspan="3" scope="col"><div align="left">
                        <textarea name="reason" cols="25" rows="10" id="reason"></textarea>
                      </div></th>
                    </tr>
                    
                    <tr>
                      <th colspan="5" class="boldEleven" scope="col"><table width="149" border="0" cellspacing="2" cellpadding="2">
                        <tr>
                          <th scope="col"><input name="Submit" type="submit" class="buttonbold12" value="Submit"   accesskey="s"   ></th>
                          <th scope="col"><input name="Submit2" type="button" class="buttonbold12"  value="Close"   accesskey="c"  onclick="redirect('ResignationView.jsp')"></th>
                        </tr>
                      </table></th>
                    </tr>
                  </table></td>
					<td nowrap="nowrap" width="11"><spacer height="1" width="1"
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
						src="../Image/General/BRCorner.gif" width="7" /></div>					</td>
				</tr>
				<tr>
					<td class="BorderLine" height="1"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
			</tbody>
	  </table>		</td>
	</tr>
	<tr>
		<td height="23">&nbsp;</td>
	</tr>
	<tr>
		<td height="40"><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
</form>
</body>