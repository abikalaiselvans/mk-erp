<%@ page import="java.io.*,java.util.*"%>
<%@ page import="sun.net.smtp.SmtpClient"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
String dateCheckData[][] =  CommonFunctions.QueryExecute("SELECT DATE_FORMAT(now(),'%d-%m-%Y'), DAT_LOCK,MONTHNAME(NOW()),MONTH(NOW()), YEAR(NOW())  FROM m_institution  WHERE INT_ID=1");

%>
<html>
<head>
<title>:: INVENTORY ::</title><link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
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

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>
 <script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"	type="text/javascript"></script>
 <script language="javascript" src="../JavaScript/Numericfunctions.js"></script>

<script language="JavaScript" src="../JavaScript/Inventory/InventAJAX.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/Inventory/InvenCustomerAJAX.js" type="text/javascript"></script>
<script language="javascript" src="../JavaScript/Inventory/customeraddress.js"></script>

<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
<script>
 
 $(function() {
		var dates = $( "#saleDate, #saleDate2" ).datepicker({
			defaultDate: "+1w",
			changeMonth: true,changeYear: true,
			 minDate: -20  ,showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			numberOfMonths: 1,
			buttonImageOnly: true,
			onSelect: function( selectedDate ) 
			{
				var option = this.id == "saleDate" ? "minDate" : "maxDate",
					instance = $( this ).data( "datepicker" ),
					date = $.datepicker.parseDate(instance.settings.dateFormat || $.datepicker._defaults.dateFormat, selectedDate, instance.settings );
					dates.not( this ).datepicker( "option", option, date );
			}
		});
	}); 
	
	

var assigncontrol="";
 function resoffval()
{
	if(document.frm.Shipping[0].checked==true)
	{
		document.frm.shippingaddress.value=" ";
		document.getElementById('shippingaddress').disabled = true;
		document.getElementById("shippingaddress").style.visibility="hidden";
	}         
	else 
	{
		document.frm.shippingaddress.value=" ";
		document.getElementById("shippingaddress").style.visibility="visible";
		document.getElementById('shippingaddress').disabled = false;
	}
	return true;
}//end of resoffval


	</script>
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">







 
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
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="700"
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
					<td width="680">
					<table cellspacing="2" cellpadding="2" width="100%" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							<tr>
								<td height="16" colspan="4" align="center" valign="top"
									class="boldThirteen">Service Billing PO ADD </td>
						    </tr>

							<tr>
								<td height="19" colspan="4" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory
								</span></td>
						    </tr>
							<tr>
							  <td height="17" colspan="4" valign="top" class="errormessage">
							    <div align="center">
							      <%
							  	String er="";
								er = ""+request.getParameter("servicebillnumber");
								if(!"null".equals(er))
								{
									%>
									<script language="javascript">
										alert(" Service bill number :: <%=er%>");
										/*if(r == true)
										{
											document.frm.action="ServiceBillingAdd.jsp";
											
										}
										else
										{
											document.frm.action="ServiceBilling.jsp";
											
										}
										*/
									</script>	
									<%
									
									
									 
									
								}
								
							  %>
					            </div></td>
					      </tr>
							<tr>
								<td width="118" height="17" valign="top" class="boldEleven">Division <span class="boldred">* </span></td>
								<td width="199" align="left" valign="top">
<select name="divis" class="formText135" id="divis" tabindex="1" style="width:200" >
                    <option value='0'>Select</option>
                    <%
								String division[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division   WHERE INT_DIVIID >0 AND CHR_OFFICEIDS LIKE '%"+session.getAttribute("INVOFFICEID")+"%'  ORDER BY CHR_DIVICODE"); 
								for(int u=0; u<division.length; u++)
									out.print("<option value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
							%>
                  </select>								</td>
							    <td width="105" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp; </td>
							    <td width="148" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;                                                                     </td>
							</tr>
							
							<tr>
							  <td height="17" valign="top" class="boldEleven">P.O start date  <span class="boldred">* </span></td>
							  <td align="left"><span class="boldEleven">
							    <input tabindex="2"  value="<%=dateCheckData[0][0]%>" 
										name="saleDate" type="text" class="formText135" id="saleDate"
										size="15" readonly>
							   
                                
							  </span></td>
						      <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp; </td>
						      <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp; </td>
						  </tr>
							<tr>
							  <td class="boldEleven">P.O end date <span class="boldred">*</span></td>
							  <td class="boldEleven"><input tabindex="2"  value="<%=dateCheckData[0][0]%>" 
										name="saleDate2" type="text" class="formText135" id="saleDate2"
										size="15" readonly></td>
							  <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  </tr>
							<tr>
							  <td class="boldEleven"><div align="left">CustomerName <span class="boldred">* </span></div></td>
							  <td class="boldEleven"><div align="left">
							    
                                  <%
			
			String ssql="SELECT a.INT_CUSTOMERID,f.CHR_NAME,a.CHR_CONTACTPERSON, e.CHR_CITYNAME,d.CHR_DISTRICT,c.CHR_STATENAME,  CONCAT('PIN :',a.INT_PINCODE),CONCAT('MOBILE :',a.CHR_MOBILE),CONCAT('Phone :',a.CHR_PHONE),CONCAT('E-Mail :',a.CHR_EMAIL) FROM  inv_m_customerinfo a, com_m_country b,com_m_state c,com_m_district d,com_m_city e  ,inv_m_customergroup f   WHERE a.INT_CUSTOMERGROUPID = f.INT_CUSTOMERGROUPID   AND a.INT_COUNTRYID = b.INT_COUNTRYID    AND a.INT_STATEID =c.INT_STATEID    AND a.INT_DISTRICTID= d.INT_DISTRICTID   AND a.INT_CITYID =e.INT_CITYID AND   a.INT_ACTIVE =1  ORDER BY f.CHR_NAME";
			String custData[][] =  CommonFunctions.QueryExecute(ssql);
			
			
			String CreditLimitData = CommonFunctions.QueryExecute("SELECT CHR_CUSTOMERCREDITLIMIT FROM  m_inventorysetting WHERE INT_ROWID=1")[0][0];
			String climit="";
			if("Y".equals(CreditLimitData))
				climit=" onblur=\"LoadCreditLimt('customer','creditdetail','S')\" ";
			else
				climit="";	
			%>
                                  
								  
								  
<select name="customer" id="customer" class="formText135" style="width: 200px"  onchange="loadAddress('customer','shippingaddress') " onBlur="LoadCreditAmount('customer')"  <%=climit%> >
  <option value="0">Select</option>
  <%
for(int y=0;y<custData.length;y++)
	out.println("<option  value='"+custData[y][0]+"'>"+custData[y][1]+ " ,"+custData[y][2]+ "  ,"+custData[y][3]+ "  ,"+custData[y][4]+ "  ,"+custData[y][5]+ "  ,"+custData[y][6]+ "</option>");	
%>
</select>								  
								  
								  
								  
							      <input name="pendingamount" type="hidden" id="pendingamount" value="0" />
                                  <input name="creditamount" type="hidden" id="creditamount" value="0" />
</div></td>
							  <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp; </td>
							  <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp; </td>
						  </tr>
							<tr>
							  <td valign="top" class="boldEleven"><div align="left">Shipping Address</div></td>
							  <td class="boldEleven"><table width="38%" border="0" cellspacing="0" cellpadding="0">
                                  <tr>
                                    <td width="9%"><input name="Shipping" type="radio" onClick="return resoffval()"
												value="S" checked /></td>
                                    <td width="15%" class="boldEleven">Same</td>
                                    <td width="52%" class="boldEleven"><input
												onclick="return resoffval()" name="Shipping" type="radio"
												value="D"></td>
                                    <td width="24%" class="boldEleven">Different</td>
                                  </tr>
                                </table>
							      <div align="left"></div></td>
							  <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp; </td>
							  <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp; </td>
						  </tr>
							<tr>
							  <td rowspan="2" valign="top" class="boldEleven">&nbsp;</td>
							  <td rowspan="2" valign="top" class="boldEleven"><div align="left">
							    <textarea name="shippingaddress"
										cols="35" rows="4" class="formText135" id="shippingaddress"></textarea>
                              </div></td>
							  <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp; </td>
							  <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp; </td>
						  </tr>
							<tr>
							  <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp; </td>
							  <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp; </td>
						  </tr>
							<tr>
							  <td valign="top" class="boldEleven"> <span class="boldred"></span></td>
							  <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp; </td>
							  <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  </tr>
							<tr>
							  <td valign="top" class="boldEleven"> <span class="ui-state-error-text"></span></td>
							  <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp; </td>
							  <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp; </td>
							  <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;
</td>
						  </tr>
							 
							
							
							 
							<tr>
							  <td height="17" valign="top" class="boldEleven">Reference  <span class="boldred">* </span></td>
							  <td colspan="3" align="left"><select name="ref" id="ref"
										class="formText135" size="5" style="width:200">
                                <jsp:include page="Staffload.jsp" flush="true" />                              
</select>							    <div align="left"></div></td>
					      </tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven">Service Description  <span class="boldred">* </span></td>
							  <td colspan="3" align="left"><textarea name="memo" cols="35" style="width:150"
										rows="5" class="formText135" id="memo" tabindex="9"></textarea>
							    <div align="left"></div></td>
					      </tr>
							<tr>
								<td height="17" valign="top" class="boldEleven">P.O. Amount   <span class="boldred">* </span></td>
								<td align="left"><span class="boldEleven">
<input name="totals" type="text" class="formText135" id="totals" style='text-align:right' tabindex="11" onBlur="assigntotal()" value="0" maxlength="10"  onkeyup="extractNumber(this,2,true);" onKeyPress="return blockNonNumbers(this, event, true, true);" />
										
		 



								</span></td>
							    <td valign="top" class="boldEleven"><div align="left"></div></td>
							    <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							</tr>
							 
						  <tr>
								<td height="17" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td colspan="3" align="left"><input name="filename" type="hidden" value="ServiceBillingPO" />
							    <input name="actionS"
									type="hidden" value="INVServiceBillingAdd" />
							     
							    </td>
							</tr>
							<tr>
								<td height="17" colspan="4" class="boldEleven">
								<table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
									<tr>
										<td><input name="Submit" id="Submit" type="submit"
											class="buttonbold13" value="Submit"   accesskey="s"   ></td>
										<td><input name="Close" type="button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="redirect('ServiceBillingPO.jsp')"></td>
									</tr>
								</table>								</td>
							</tr>
							<tr>
								<td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
								<td colspan="3" align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
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
 	if(checkNullSelect("divis","Select Division","0")
	&& checkNull( "saleDate","Enter Invoice Date" )
	&& checkNullSelect("customer","Select Customer","0") 
	&& checkNull( "ref","Select reference" )
	&& checkNull( "memo","Enter Description" )
	&& checkNull( "totals","Enter Total amount" )
	 
	)
		return true;
	else
		return false;				
		
 } 	
 
  function ValidateBill()
{
		var pamount = parseFloat(document.getElementById('pendingamount').value);
		var camount = parseFloat(document.getElementById('creditamount').value);
		var namount= parseFloat(document.getElementById('nettotal').value);
		 
			if(camount<(pamount+namount)) 
			{
				var tb=document.getElementById("creditdetailerror");
				tb.innerHTML= "<font color='red'><h3><b>This Bill Not Allowed due to Exceed the credit limit  The Credit Limit : "+camount +"  The Pending Amount : "+pamount +" Current Bill Amount : "+namount +"</b></h3></font>";
					return false;
			}
			else
				return true;	
		 
		
}


function ceheckAmount()
{
	var namount= parseFloat(document.getElementById('nettotal').value);
	if(namount<100000)
	{
		setOptionValue('noofpaymentcommitment','1');
	
	}	
	return true;
}
</script> <%@ include file="../footer.jsp"%></form>
</body>
</html>
