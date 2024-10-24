<%@ include file="index.jsp"%>
<html>
<head>
<title><%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='PAY' ")[0][0]%></title>
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
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/Validnamecheck.js"></script>
<script language="javascript">
function checkvalue(from,to){
var from=document.getElementById(from).value;
var to=document.getElementById(to).value;
var tovalue = parseInt(to);
var fromvalue = parseInt(from);
if(fromvalue > tovalue)
  		{
			alert("From should be less than To");
  			return false; 
		}else{
			return true;
		}
}

 function Validate()
{
	//Taxid,GT,LT,Percentage,Amount,desc
	if(	
	 	checkNull('GT','Enter To Value') 
		&& checkNull('LT','Enter From Value')
		&& checkNull('Percentage','Enter Percentage')
		&& checkNull('desc','Enter Description')
		&& checkvalue('LT','GT')
		&& percentage()
	 )
		return true;
	else
		return false;
}

function percentage()
{
	var Percen=document.getElementById('Percentage').value;
	var Percenvalue = parseInt(Percen);
	if(Percenvalue>100)
		{
			alert("Your percentage exceeds the 100");
			return false;
		}
		else
			return true;
}

	
</script>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form  AUTOCOMPLETE = "off"   name="frm" action="../SmartLoginAuth" onSubmit="return Validate()">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="center" height="80">
		
	</td>
		
	</tr>
	<tr>
		<td>
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

					<table width="100%" border="0" align="center" cellpadding="0"
						cellspacing="0"  >
						<!--DWLayoutTable-->
						<tr align="center" valign="middle">
							<td height="30" colspan="2" class="BackGround" >INCOME TAX VALUE <span class="boldEleven"><%
			String grd="";
			String grd1="";
		%>
							  <%
						  String Incomeid =request.getParameter("Incometaxvalueid");
						  String sql="SELECT INT_ACCOUNTYEAR,INT_TO,INT_FROM,DOU_PERCENTAGE,CHR_DESC,CHR_GENDER from lncome_m_taxvalue WHERE INT_ID ="+Incomeid+"";
						  String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
						  %>
						  <%
									grd="";
									grd1="";
									if("Male".equals(data[0][5]))
										grd ="checked='checked'";
							
									if("Female".equals(data[0][5]))
									grd1 ="checked='checked'";
						%>	
							</span></td>
						</tr>
						<tr>
						  <td height="28" valign="middle" class="boldEleven">Account year <span class="bolddeepred"> * </span></td>
						  <td>
							<select name="Year" class="formText135" id="Year"  >
						  	<option value="0">Select</option>
						  <%@ include file="../JavaScript/accountyears.jsp"%>
						  </select>	<script language="javascript">setOptionValue("Year","<%=data[0][0]%>") </script>					  </td>
					   </tr>
					   <tr>
					   	<td height="28" valign="middle" class="boldEleven">Gender<span class="bolddeepred"> * </span></td>
						<td><input name="gender" id="gender" type="radio" class="formText135" value="Male" <%=grd%>  />Male<input name="gender" id="gender" type="radio" class="formText135" value="Female" <%=grd1%>  />
						  Female</td>
					   </tr>
						
						 
						<tr>
						  <td height="28" valign="middle" class="boldEleven">From<span class="bolddeepred">* </span></td>
						  <td>
<input name="LT" type="text" class="formText135" id="LT" onKeyPress="return numeric_only(event,'GT','11')"  value="<%=data[0][2]%>" size="10" maxlength="10" style="text-align:right">                        
					  </tr>
                      
                      <tr>
							<td width="162" height="28" valign="middle" class="boldEleven">To<span class="bolddeepred"> * </span></td>
							<td width="178">
	<input name="GT" type="text" class="formText135" id="GT" onKeyPress="return numeric_only(event,'GT','11')"  size="10" maxlength="10" value="<%=data[0][1]%>" style="text-align:right">
							<div id="soValid"></div>							</td>
						</tr>
						<tr>
						  <td height="28" valign="middle" class="boldEleven">Percentage<span class="bolddeepred"> * </span></td>
						  <td>
	<input name="Percentage" type="text" class="formText135" id="Percentage"  onKeyUp="doubleValue('Percentage','9')"  value="<%=data[0][3]%>" size="10" maxlength="5" style="text-align:right">                        
					  </tr>
						
						<tr>
							<td width="162" height="28" valign="middle" class="boldEleven">
							Description<span class="bolddeepred"> * </span></td>
							<td width="178"><textarea name="desc"  class="formText135" id="desc" size="10" maxlength="300"><%=data[0][4]%></textarea>
							  <input type="hidden" name="filename" value="IncomeTaxValue">
                        	  <input type="hidden" name="actionS" value="PAYIncomeTaxValueEdit">	
							  <input type="hidden" name="Incometaxvalueid" value="<%=Incomeid%>">
					</tr>
						<tr>
							<td height="28" colspan="2" valign="middle" class="bolddeepblue">
							<div align="center">
							
							<table border="0" cellspacing="3" cellpadding="0">
								<tr>
									<td width="56"><input class="buttonbold14" type="submit" name="Submit" value="Edit"></td>
									<td width="56"><input class="buttonbold14" type="Button" name="Submit2"  value="Close"   accesskey="c" 
										onClick="redirect('IncomeTaxValue.jsp')"></td>
								</tr>
							</table>
							</div>							</td>
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
</table></form>


<%@ include file="../footer.jsp"%>
</body>
</html>
