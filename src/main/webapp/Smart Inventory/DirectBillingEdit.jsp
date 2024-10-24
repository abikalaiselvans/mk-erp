<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
%>
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


<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
<script>
	/*$(function() {
		$( "#saleDate" ).datepicker({
			changeMonth: true,
			changeYear: true
		});
	});
*/
 
 
 		
$(function() {
		$( "#saleDate" ).datepicker({ minDate: -7, maxDate: "+7D" });
	});
 


	</script>
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">




<%
	String taxid[][] =  CommonFunctions.QueryExecute("Select INT_TAXID,CHR_TAXNAME,DOU_VALUE from inv_m_tax");
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
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="500"
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
					<table cellspacing="2" cellpadding="2" width="100%" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							<tr>
								<td height="16" colspan="3" align="center" valign="top"
									class="boldThirteen">Direct Billing Edit </td>
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
								String  invoiceno= request.getParameter("salesid");
								String sql=" SELECT INT_DIVIID,date_format(DAT_SALESDATE,'%d-%m-%Y'),INT_CUSTOMERID,CHR_REF,";
								sql = sql+" CHR_DES,DOU_AMOUNT,DOU_CONTRIBUTION,INT_TAXID, ";
								sql = sql+"  DOU_TAXVALUE,DOU_NETAMOUNT,CHR_NOOFPAYMENTCOMMITMENT ,INT_PAYMENT_COMMITMENT_DAYS,INT_ID,CHR_SALESNO FROM inv_t_directbilling WHERE INT_ID="+invoiceno;
								out.println(sql);
								String readData[][] =  CommonFunctions.QueryExecute(sql);
								String dbdivis="",dbSaleNo="",dbsaleDate="",dbcustomer="",dbref="",dbmemo="",dbtotals="";
								String dbcontribution="",dbtaxid="",dbtaxvalue="",dbnetamount="",noofcommitment="";
								String commitmentdays="",rowid="",saleno="";
								if(readData.length>0)
								{
									dbdivis=readData[0][0];
									dbsaleDate=readData[0][1];
									dbcustomer=readData[0][2];
									dbref=readData[0][3];
									dbmemo=readData[0][4];
									dbtotals=readData[0][5];
									dbcontribution=readData[0][6];
									dbtaxid=readData[0][7];
									dbtaxvalue=readData[0][8];
									dbnetamount=readData[0][9]; 
									noofcommitment=readData[0][10]; 
									commitmentdays=readData[0][11]; 
									rowid=readData[0][12]; 
									saleno=readData[0][13]; 
								}
								 
							  %>
					            </div></td>
						  </tr>
							<tr>
								<td width="213" height="17" valign="top" class="boldEleven">Division<span class="boldred">*</span></td>
								<td width="256" colspan="2" align="left" class="boldEleven">
								<select name="divis"
							class="formText135" id="divis" tabindex="1"
							 >
                    <option value='0'>Select</option>
                    <%
								String division[][] =  CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division   WHERE INT_DIVIID >0 AND CHR_OFFICEIDS LIKE '%"+session.getAttribute("INVOFFICEID")+"%'  ORDER BY CHR_DIVICODE"); 
								for(int u=0; u<division.length; u++)
									out.print("<option value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
							%>
                  </select>	
				  <script language="javascript">
				  setOptionValue('divis',"<%=dbdivis%>")  
				  </script>  							  </td>
							</tr>
							<tr>
								<td height="17" valign="top" class="boldEleven">Invoice Number </td>
							  <td colspan="2" align="left" class="boldEleven"><%=saleno%>
								 
										  <input name="saleno" type="hidden" id="saleno" value="<%=saleno%>">
										  <input name="rowid" type="hidden" id="rowid" value="<%=rowid%>"></td>
							</tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven">Invoice date <span class="boldred">*</span></td>
							  <td colspan="2" align="left" class="boldEleven"><span class="boldEleven">
							    <input tabindex="2"
										name="saleDate" type="text" class="formText135" id="saleDate"
										size="15" readonly="readonly" value="<%=dbsaleDate%>">
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
				//setCurrentDate('saleDate'); 
		//-->
                                </script>
								
								<script language="javascript">
				  setOptionValue('saleDate',"<%=dbsaleDate%>") 
				  </script>
				  
							  </span></td>
						  </tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven">Customer Name <span class="boldred">*</span></td>
							  <td colspan="2" align="left" class="boldEleven">
							  <select name="customer"
							id="customer" class="formText135"  style="width:200"  >
                    <option value="0">Select</option>
                    <jsp:include page="LoadCustomer.jsp" />                  
</select>		

 <script language="javascript">
				  setOptionValue('customer',"<%=dbcustomer%>") 
				  </script>					  </td>
						  </tr>
							 
							<tr>
							  <td height="17" valign="top" class="boldEleven">Payment Commitment Days <span class="boldred">*</span></td>
							  <td colspan="2" align="left" class="boldEleven"><select name="commitmentdays" class="formText135" id="commitmentdays">
                                <option value="">Select Payment commitment Days</option>
                                <option value="0">Advance Amount</option>
                                <%
								  for(int u=1;u<=40;u++)
								  	out.println("<option value='"+u+"'>"+u+" - Days</option>");
								  %>
                              </select>
							  <script language="javascript" >setOptionValue('commitmentdays','<%=commitmentdays%>')</script>
							  
							  </td>
						  </tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven">Reference<span class="boldred">*</span></td>
							  <td colspan="2" align="left" class="boldEleven">
							  <select name="ref" id="ref"
										class="formText135" size="5" style="width:200" >
										<jsp:include page="Staffload.jsp" flush="true" />
								</select>	
								
								 <script language="javascript">
				  setOptionValue('ref',"<%=dbref%>") 
				  </script>							  </td>
						  </tr>
							<tr>
								<td height="17" valign="top" class="boldEleven">Others Description   <span class="boldred">* </span></td>
							  <td colspan="2" align="left" class="boldEleven"><textarea name="memo" cols="20"
										rows="5"   class="formText135" id="memo" tabindex="9"><%=dbmemo%></textarea></td>
							</tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven">Total Amount <span class="boldred">*</span></td>
							  <td colspan="2" align="left" class="boldEleven">
							  <input tabindex="11" name="totals"
										 onKeyPress="return numeric_only(event,'totals','15')" type="text"
										class="formText135" id="totals"  
										style='text-align:right'  value="<%=dbtotals%>" maxlength="10"/>							  </td>
						  </tr>
							<tr>
                              <td height="17" valign="top" class="boldEleven">Contribution</td>
							  <td colspan="2" align="left"><input name="contribution" type="text"
										class="formText135" id="contribution"  
										style='text-align:right' tabindex="11" maxlength="10"
										 onKeyPress="return numeric_only(event,'contribution','11')" value="<%=dbcontribution%>" /></td>
						  </tr>
							<tr>
                              <td height="17" valign="top" class="boldEleven">Tax Group <span class="boldred">*</span></td>
							  <td colspan="2" align="left"><select name="tax" class="formText135"
										id="tax" onChange="assignTotals(this)" tabindex="13">
                                  <option value="0">Select</option>
                                  <%
								String taxids[][] =  CommonFunctions.QueryExecute("Select INT_TAXID,CHR_TAXNAME from inv_m_tax");
								for(int u=0; u<taxids.length; u++)
									out.print("<option value='"+taxids[u][0]+"'>"+taxids[u][1]+"</option>");
							%>
                              </select>
							  <script language="javascript"> setOptionValue('tax',"<%=dbtaxid%>") </script>	 						  </td>
						  </tr>
							<tr>
                              <td height="17" valign="top" class="boldEleven">Tax Value </td>
							  <td colspan="2" align="left"><input name="taxamounts" value="<%=dbtaxvalue%>"
										type="text" class="formText135" id="taxamounts"
										readonly="readonly" tabindex="14" style='text-align:right' /></td>
						  </tr>
							<tr>
                              <td height="17" valign="top" class="boldEleven">Net Amount </td>
							  <td colspan="2" align="left"><input name="netamount" type="text"
										class="formText135" id="netamount"  
										style='text-align:right' tabindex="11"
										maxlength="10"
										 onKeyPress="return numeric_only(event,'netamount','11')" value="<%=dbnetamount%>"  readonly="readonly"/>
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
										</script>                              </td>
						  </tr>
							
							<tr>
							  <td height="17" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td colspan="2" align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  </tr>
							<tr>
								<td height="17" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td colspan="2" align="left"><input name="filename"
									type="hidden" value="DirectBilling" /> 
								<input name="actionS"
									type="hidden" value="INVDirectBillingEdit" />
								<input name="noofpaymentcommitment" type="hidden" id="noofpaymentcommitment" value="<%=noofcommitment%>"></td>
							</tr>
							<tr>
								<td height="17" colspan="3" class="boldEleven">
								<table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
									<tr>
										<td><input name="Submit" type="submit"
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
		alert("Kindly check ur contribution amount");
		document.getElementById('contribution').focus();
		return false;
	}
	

	if(
		checkNullSelect("divis","Select Division","0")
		&& checkNull( "saleDate","Enter Invoice Date" )
		&& checkNullSelect("customer","Select Customer","0")
		&& checkNullSelect("commitmentdays","Select commitment days","")
		&& checkNull( "ref","Select reference" )
		&& checkNull( "memo","Enter Description" )
		&& checkNull( "totals","Enter Total amount" )
		&& checkNullSelect("tax","Select tax","0")
	)
		return true;
	else
		return false;				
		
 } 	
</script> 
<%@ include file="../footer.jsp"%></form>
</body>
</html>
<%
}
catch(Exception e)
{
	System.out.println(e.getMessage());
}
%>