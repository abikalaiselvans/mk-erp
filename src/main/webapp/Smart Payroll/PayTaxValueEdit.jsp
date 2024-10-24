<%@ include file="index.jsp"%>
<html>
<head>

<title> :: PAYROLL ::</title>

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>
 
 
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
 function Validate()
{
	
	
	var gt = parseInt(document.getElementById('GT').value );
	var lt = parseInt(document.getElementById('LT').value );
	if(gt>lt)
	{
		alert("Incorrect check your >= or <= data...");
		return false;
	}
	
	
	
	//Taxid,GT,LT,Percentage,Amount,desc
	if(	checkNullSelect('Taxid','Select Tax Name','0')
	 	&& checkNull('GT','Enter Greaterthan or equal') 
		 && checkNull('LT','Enter Lessthan or equal')
		  && checkNull('Percentage','Enter Percentage')
		  && checkNull('Amount','Enter Amount')
		   && checkNull('desc','Enter Description')
		   && checkPercentage()
	 )
		return true;
	else
		return false;
}




function checkPercentage()
{
	try
	{
		var gt = parseFloat(document.getElementById('Percentage').value );
		if(gt >100)
		{
			alert("Kindly check the percentage")
			document.getElementById('Percentage').focus();
			return false;
		}
		else
		{
			return true;
		}
	}
	catch(err)
	{
		alert(err);
		return false;
	}
}
		
</script>
</head>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form  AUTOCOMPLETE = "off"   name="frm" action="../SmartLoginAuth" onSubmit="return Validate()">


<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="80">&nbsp;</td>
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
							<td height="30" colspan="2" class="BackGround" >Pay Tax Value <span class="boldEleven">
	<%
	
	String Paytaxvalueid = request.getParameter("Paytaxvalueid");
	String sql="SELECT INT_ID,CHR_TAXNAME,CHR_DESC from pay_m_tax ORDER BY CHR_TAXNAME";
	String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	sql = "SELECT INT_TAXID,INT_GTEQL,INT_LSEQL,DOU_PERCENTAGE,DOU_AMOUNT,CHR_DESC FROM pay_m_taxvalue WHERE INT_ID="+Paytaxvalueid;
	String datas[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	
	 %>
							</span></td>
						</tr>
						<tr>
						  <td height="28" valign="middle" class="boldEleven">Tax Name <span class="boldred"> * </span></td>
						  <td><span class="boldEleven">
						    <select name="Taxid" class="formText135" id="Taxid"  >
                              <option value="0">Select</option>
                              <%
						   for(int u=0;u<data.length;u++)
						  	out.println("<option value='"+data[u][0]+"'>"+data[u][1]);
						  %>
                            </select>
						<script language="javascript">setOptionValue("Taxid","<%=datas[0][0]%>")</script>	
							
						  <input type="hidden" name="Paytaxvalueid" value="<%=Paytaxvalueid%>">
						  </span></td>
					  </tr>
						<tr>
							<td width="162" height="28" valign="middle" class="boldEleven">Greater than or equal<span class="boldred"> * </span></td>
							<td width="178">
	<input name="GT" type="text" class="formText135" id="GT"   onKeyPress="return numeric_only(event,'GT','11')"   value="<%=datas[0][1]%>" size="10" maxlength="7" style="text-align:right">
							<div id="soValid"></div>							</td>
						</tr>
						<tr>
						  <td height="28" valign="middle" class="boldEleven">Less than or equal to<span class="boldred"> * </span></td>
						  <td>
<input name="LT" type="text" class="formText135" id="LT"  onKeyPress="return numeric_only(event,'LT','11')"   value="<%=datas[0][2]%>" size="10" maxlength="7" style="text-align:right">                        
					  </tr>
						<tr>
						  <td height="28" valign="middle" class="boldEleven">Percentage<span class="boldred"> * </span></td>
						  <td>
	<input name="Percentage" type="text" class="formText135" id="Percentage" onKeyPress="return numeric_only(event,'Percentage','7')"   value="<%=datas[0][3]%>" size="10" maxlength="5" style="text-align:right">                        
					  </tr>
						<tr>
						  <td height="28" valign="middle" class="boldEleven">Amount<span class="boldred"> * </span></td>
						  <td>
	<input name="Amount" type="text" class="formText135" id="Amount"  onKeyPress="return numeric_only(event,'Amount','12')" value="<%=datas[0][4]%>" size="10" maxlength="7" style="text-align:right">                        
					  </tr>
						<tr>
							<td width="162" height="28" align="left" valign="top" class="boldEleven">
							Description<span class="boldred"> * </span></td>
							<td width="178" align="left" valign="top"><textarea name="desc" cols="30" rows="5" class="formText135" id="desc" onKeyPress="textArea('desc','250')"><%=datas[0][5]%></textarea>
							  <input type="hidden" name="filename" value="PayTaxValue">
                        <input type="hidden" name="actionS" value="PAYPayTaxEdit">						
                        </tr>
						<tr>
							<td height="28" colspan="2" valign="middle" class="bolddeepblue">
							<div align="center">
							
							<table border="0" cellspacing="3" cellpadding="0">
								<tr>
									<td width="56"><input class="buttonbold14" type="submit" name="Submit" value="Submit"   accesskey="s"   ></td>
									<td width="56"><input class="buttonbold14" type="Button" name="Submit2"  value="Close"   accesskey="c" 
										onClick="redirect('PayTaxValue.jsp')"></td>
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
