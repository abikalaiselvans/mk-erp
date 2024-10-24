<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<html>
<head>
<title>:: INVENTORY ::</title><link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>

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
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"	type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/Inventory/InventAJAX.js" type="text/javascript"></script>
<script language="javascript" src="../JavaScript/Inventory/CustomerSalesCreditlimit.js"></script>
<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
<script>
		
$(function() {
		$( "#saleDate" ).datepicker({ minDate: -7, maxDate: "+7D" });
	});
 


 

	</script>
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">





<%
	String taxid[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_TAXID,CHR_TAXNAME,DOU_VALUE from inv_m_tax");
	String lvalue="";
	for(int x=0; x<taxid.length;x++)
	{
		for(int y=0; y<3;y++)
		{
			lvalue = lvalue+taxid[x][y]+",";
		}
		lvalue = lvalue+"~";	
	}
	%>
<script language="javascript">
	var taxvalue = "<%=lvalue%>";
	var taxvalue1 =taxvalue.split("~");

	function assignTotals(taxs)
	{
		
		var taxid = taxs.value;
		if(taxid == "0")
		{
			document.getElementById("taxamounts").value = "0";
		}
		else
		{
			var nettotal=0.0;
			for(i=0; i<taxvalue1.length-1; i++)
			{
				var rowvalue = taxvalue1[i].split(",")
				if(rowvalue[0]=== taxid)
				{
					document.getElementById("taxamounts").value = rowvalue[2];
				}	
			}
		}	
   		calltotsl();
	}
</script>
<body >
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth" onSubmit=" return  Validate() ">
<table width="100%" border="0" cellspacing="1" cellpadding="1">
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
		<td>
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="424"
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
					<table cellspacing="2" cellpadding="2" width="600" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							<tr>
								<td height="16" colspan="3" align="center" valign="top"
									class="boldThirteen">Direct Billing Add </td>
							</tr>

							<tr>
								<td height="19" colspan="3" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory
								</span></td>
							</tr>
							<tr>
							  <td height="17" colspan="3" valign="top" class="errormessage">
							    <div align="center">
							      <%
							  	String er="";
								er = ""+request.getParameter("er");
								if(!"null".equals(er))
									out.println(" Invoice Number :: "+er);
								
								
							  %>
					            </div></td>
						  </tr>
							<tr>
								<td width="190" height="17" valign="top" class="boldEleven">Division <span class="boldred">* </span></td>
								<td width="396" colspan="2" align="left">
								<select name="divis"
							class="formText135" id="divis" tabindex="1"
							 >
                    <option value='0'>Select</option>
                    <%
								String division[][] =  CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division   WHERE INT_DIVIID >0 AND CHR_OFFICEIDS LIKE '%"+session.getAttribute("INVOFFICEID")+"%'  ORDER BY CHR_DIVICODE"); 
								for(int u=0; u<division.length; u++)
									out.print("<option value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
							%>
                  </select>								</td>
							</tr>
							<tr>
								<td height="17" valign="top" class="boldEleven">Invoice Number  <span class="boldred">* </span></td>
								<td colspan="2" align="left">
								<input tabindex="0" name="saleno" type="text" class="formText135" id="saleno"
onkeyup="upperMe(this), CheckUniqueNO(this,'soValid','inv_t_directbilling','CHR_SALESNO')"
												onkeypress="" size="30" maxlength="50"
												onblur="upperMe(this), CheckUniqueNO(this,'soValid','inv_t_directbilling','CHR_SALESNO')" >
											<div id="soValid"></div>								</td>
							</tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven">Invoice date  <span class="boldred">* </span></td>
							  <td colspan="2" align="left"><span class="boldEleven">
							    <input tabindex="2"
										name="saleDate" type="text" class="formText135" id="saleDate"
										size="15" readonly="readonly">
							    <!--<a
										href="javascript:cal2.popup();"> <img
										src="../JavaScript/img/cal.gif" width="16" height="16"
										border="0" /> </a>-->
                                <script language='JavaScript'
										type="text/javascript">
		<!--			
				var cal2 = new calendar1(document.forms['frm'].elements['saleDate']);
				cal2.year_scroll = true;
				cal2.time_comp = false;
				setCurrentDate('saleDate'); 
		//-->
                                </script>
							  </span></td>
						  </tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven">Customer Name  <span class="boldred">* </span></td>
							  <td colspan="2" align="left">
							  <%
							  String CreditLimitData =  CommonFunctions.QueryExecute("SELECT CHR_CUSTOMERCREDITLIMIT FROM  m_inventorysetting WHERE INT_ROWID=1")[0][0];
			String climit="";
			if("Y".equals(CreditLimitData))
				climit=" onChange=\"LoadCreditLimt('customer','creditdetail','D')\" ";
			else
				climit="";	
			%>
							  <select name="customer"  <%=climit%>
							id="customer" class="formText135" onBlur="LoadCreditAmount('customer')" style="width:200"  >
                    <option value="0">Select</option>
                    <jsp:include page="LoadCustomer.jsp" />                  
</select> 

<input name="pendingamount" type="hidden" id="pendingamount" value="0" />
<input name="creditamount" type="hidden" id="creditamount" value="0" />									  							  </td>
						  </tr>
							<tr>
							  <td height="17" colspan="3" valign="top" class="boldEleven">
							  <div id="creditdetail"> </div>
							<div id="creditdetailerror"> </div>							</td>
						  </tr>
							 
							<tr>
							  <td height="17" valign="top" class="boldEleven">Payment Commitment Days <span class="boldred">*</span></td>
							  <td colspan="2" align="left"><span class="boldEleven">
							    <select name="commitmentdays" class="formText135" id="commitmentdays">
                                  <option value="">Select Payment commitment Days</option>
                                  <option value="0">Advance Amount</option>
                                  <%
								  for(int u=1;u<=40;u++)
								  	out.println("<option value='"+u+"'>"+u+" - Days</option>");
								  %>
                                </select>
							  </span></td>
						  </tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven">Reference <span class="boldred">* </span></td>
							  <td colspan="2" align="left">
							  <select name="ref" id="ref" class="formText135" size="5" style="width:200" >
										<jsp:include page="Staffload.jsp" flush="true" />
								</select>							  </td>
						  </tr>
							<tr>
								<td height="17" valign="top" class="boldEleven">Others Description  <span class="boldred">* </span></td>
								<td colspan="2" align="left"><textarea name="memo" cols="20"
										rows="5" class="formText135" id="memo" tabindex="9">Enter the description</textarea></td>
							</tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven">Amount  <span class="boldred">* </span></td>
							  <td colspan="2" align="left">
							  <input name="totals" type="text"
										class="formText135" id="totals"
										style='text-align:right' tabindex="11" onBlur="calltotsl()"   onKeyPress="return numeric_only(event,'totals','13')"
										  value="0" maxlength="10" />							  </td>
						  </tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven">Contribution <span class="boldred">  </span></td>
							  <td colspan="2" align="left"><input name="contribution" type="text"
										class="formText135" id="contribution"  
										style='text-align:right' tabindex="11"
										onKeyPress="return numeric_only(event,'contribution','10')" value="0" maxlength="9" /></td>
						  </tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven">Tax Group <span class="boldred"> * </span></td>
							  <td colspan="2" align="left"><select name="tax" class="formText135"
										id="tax" onChange="assignTotals(this)" tabindex="13">
                                <option value="0">Select</option>
                                <%
								String taxids[][] =  CommonFunctions.QueryExecute("Select INT_TAXID,CHR_TAXNAME from inv_m_tax");
								for(int u=0; u<taxids.length; u++)
									out.print("<option value='"+taxids[u][0]+"'>"+taxids[u][1]+"</option>");
							%>
                              </select></td>
						  </tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven">Tax Value <span class="boldred"> </span></td>
							  <td colspan="2" align="left"><input name="taxamounts" 
										type="text" readonly="readonly"  class="formText135" id="taxamounts" style='text-align:right' tabindex="14" value="0"
										 /></td>
						  </tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven">Net Amount  <span class="boldred">* </span></td>
							  <td colspan="2" align="left"><input name="netamount" type="text"
										class="formText135" id="netamount"   readonly="readonly" 
										style='text-align:right' tabindex="11"
										onkeypress="doubleValue('netamount','12')" value="0" />
										<script language="javascript">
											function calltotsl()
											{
												if(document.getElementById('totals').value=="")
												{
													alert("Kindly enter the amount...");
													document.getElementById('totals').focus();
												}
												else
												{
													var total=parseFloat(document.getElementById("totals").value);
													var tax=parseFloat(document.getElementById("taxamounts").value);
													tax= total+(total*(tax/100));
													document.getElementById('netamount').value=tax;
												}	
											}
										</script>										</td>
						  </tr>
							<tr>
								<td height="17" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td colspan="2" align="left"><input name="filename"
									type="hidden" value="DirectBilling" /> 
								<input name="actionS"
									type="hidden" value="INVDirectBillingAdd" />
								<input name="noofpaymentcommitment" type="hidden" id="noofpaymentcommitment" value="1"></td>
							</tr>
							<tr>
								<td height="17" colspan="3" class="boldEleven">
								<table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
									<tr>
										<td><input id="Submit"  name="Submit" type="submit"
											class="buttonbold13" value="Submit"   accesskey="s"   ></td>
										<td><input name="Close" type="button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="redirect('DirectBilling.jsp')"></td>
									</tr>
								</table>								</td>
							</tr>
							<tr>
								<td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
								<td colspan="2" align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
							</tr>
						</tbody>
						<input type="hidden" name="mobileBookingOption" />
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
</table>
<script language="JavaScript">

function Validate()
  {
	  
	var tot = parseFloat(document.getElementById('totals').value);
	var cont = parseFloat(document.getElementById('contribution').value);
	tot = (tot*20/100);
	if(tot<cont)
	{
		alert("Kindly check ur contribution amount. ");
		document.getElementById('contribution').focus();
		return false;
	}
	
	if(checkNullSelect("divis","Select Division","0")
	&& checkNull( "saleno","Enter Invoice Number" )
	&& checkNull( "saleDate","Enter Invoice Date" )
	&& checkNullSelect("customer","Select Customer","0")
	&& checkNullSelect("commitmentdays","Select commitment days","")
	&& checkNull( "ref","Select reference" )
	&& checkNull( "memo","Enter Description" )
	&& checkNull( "totals","Enter Total amount" )
	&& checkNullSelect("tax","Select tax","0")
	&& ValidateBill()
	)
		return true;
	else
		return false;				
		
 } 	
 
 function ValidateBill()
{
		var pamount = parseFloat(document.getElementById('pendingamount').value);
		var camount = parseFloat(document.getElementById('creditamount').value);
		var namount= parseFloat(document.getElementById('netamount').value);
		 
			if(camount<(pamount+namount)) 
			{
				var tb=document.getElementById("creditdetailerror");
				tb.innerHTML= "<font color='red'><h3><b>This Bill Not Allowed due to  Exceed the credit limit   The Credit Limit : "+camount +"  The Pending Amount : "+pamount +" Current Bill Amount : "+namount +"</b></h3></font>";
					return false;
			}
			else
				return true;	
		 
		
}


</script> <%@ include file="../footer.jsp"%></form>
</body>
</html>
