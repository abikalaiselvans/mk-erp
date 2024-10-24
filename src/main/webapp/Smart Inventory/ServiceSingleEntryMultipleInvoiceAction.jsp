<%@ page import="java.io.*,java.util.*"%>
<%@ page import="sun.net.smtp.SmtpClient"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%> <html>

<%
try
{
%>
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
<%@ include file="javascriptinclude.jsp"%>
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
 <style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
 </style>
</head>

<script language="JavaScript" src="../JavaScript/calendar1.js" type="text/javascript"></script>
<script language="javascript" src="../JavaScript/Numericfunctions.js"></script>
<script language="javascript">

function assignNumber(itm)
{
	try
	{
		var its = itm.value.split(",");
		if(its[1] != "CASH" || its[1] != "CASH")
			enable();
		else
			disable();
	}
	catch(err)
	{
		alert(err);
	}
}
	
function enable()
{
	chk1.style.visibility="Visible";
	chk2.style.visibility="Visible";
	chk3.style.visibility="Visible";
}
function disable()
{
	 chk1.style.visibility="hidden";
	 chk2.style.visibility="hidden";
	 chk3.style.visibility="hidden";
}


function CheckBalance(gctr,Balance,divid)
	{
		var bval=document.getElementById(Balance).value;
		var gval=gctr.value;
		bval=parseInt(bval);
		gval=parseInt(gval);
		if(gval<=bval)
		{
			document.getElementById('Valid'+divid).innerHTML="<font class='boldgreen' size='2'>VALID</font>";
			document.getElementById('submit').disabled=false;
		}
		else 
		{
			document.getElementById('Valid'+divid).innerHTML="<font class='bolddeepred' size='2'>IN VALID</font>";
			document.getElementById('submit').disabled=true;
		}
	}
	
	
	
	
	
function Validate()
{
	try
	{
		 
		if(
			checkNullSelect("paymentMethod","Select Payment Method",'Select') 
			&& checkBankName()
			&& checkNull("paymentDate","Enter paymentDate")
			&& checkNull("chequeamount","Enter the chequeamount")
			&& checkNull("remarks","Enter the remarks")
			&& checkNull("ref","Select Payment collected by")
			&& checkNullSelect("creditto","Select credited to",'') 
			&& checkfillAmountAndChequeAmount()
		)
		{		
			sval=document.getElementById('paymentMethod').value;	
			var its =sval.split(",");
			if(its[1] != "CASH" || its[1] != "CASH")
			{
				if(checkNullSelect("Bank","Select Bank Name ","") && 
				checkNull('Challanno','Enter '+its[1]+' Number'))
				{
					if (confirm("Once again confirm to all the informations are correct")==true)
					 	return true;
					else
						return false;
				}
				else
					return false;
			}
			else
				return true;	 
		}		
		else
			return false;	
	}
	catch(err)
	{
		alert(err)
		return false;
	}
} 

  
  function checkBankName()
 {
 	try
	{
			sval=document.getElementById('paymentMethod').value;	
			var its =sval.split(",");
			if(its[1] != "CASH" || its[1] != "CASH")
			{
				if(checkNullSelect("Bank","Select Bank Name ","") && checkNull('Challanno','Enter '+its[1]+' Number'))
					return true;
				else
					return false;
			}
			else
				return true;
	}
	catch(err)
	{
		alert(err)
	}
 } 
 
 
</script>
<body >
<%@ include file="indexinv.jsp"%>
 <form action="../SmartLoginAuth" method="post" name="frm" id="frm"  onSubmit="return Validate()">
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
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="800"
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
							  <td height="17" class="boldEleven">
                             
							    <table width="100%" border="0" cellspacing="0" cellpadding="0">
							      <tr>
							        <td colspan="6" align="center" class="copyright"><span class="bolddeepred">
							          <input name="filename" type="hidden" id="filename" value="ServicePaymentMultipleInvoice">
                                      <input name="actionS"
									type="hidden" value="INVServicePaymenMultipleinvoice" />
                                    </span>SERVICE BILLING -SINGLE ENTRY MULTIPLE INVOICE
                                    <%
									String sql = "";
									int l =0;
									String customergroupid = request.getParameter("Rowid");
									String salesnumber[] = request.getParameterValues("salesnumber");
									String ids=" AND a.CHR_SALESNO IN (" ;
									if(salesnumber.length>0)
										for(int u=0;u<salesnumber.length; u++)
											ids =ids + "'"+salesnumber[u]+"' ,";
									ids =ids + " '0' )";		
									
									sql = "";
									sql = " SELECT a.CHR_SALESNO ,FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID),DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y'),";
								    sql = sql + "a.DOU_NETAMOUNT,FUN_INV_GET_SERVICEBALANCEAMOUNT(a.CHR_SALESNO),a.INT_CUSTOMERID, ";
									sql = sql + " FUN_INV_GET_SERVICEPAYMENTCOMMITMENTID(a.CHR_SALESNO) ";
									sql = sql + " ";
									sql = sql + " FROM inv_t_servicebilling a ,  inv_m_customerinfo b  ";
									sql = sql + " WHERE  a.INT_CUSTOMERID = b.INT_CUSTOMERID  AND a.CHR_PAYMENTSTATUS <> 'Y'  ";
									sql = sql + " AND a.CHR_CANCEL='N' AND FIND_A_PAYMENTCOMMITMENT(a.CHR_SALESNO,'S') > 0   ";
									//sql = sql + " AND b.INT_CUSTOMERGROUPID =" +customergroupid;
									sql  = sql + ids ;
									sql = sql + "  ORDER BY a.DAT_SALESDATE  ";
									//out.println(sql);
									String data[][] = CommonFunctions.QueryExecute(sql);
									
									%>
                                     </td>
						          </tr>
							      <tr>
							        <td colspan="6">&nbsp;</td>
						          </tr>
							      <tr>
							        <td colspan="6" align="center"><%
if(data.length>0)
{
	l = data.length;
	out.println("<center>");
	out.println("<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
	out.println("<tr class='MRow1'>");
	out.println("<td class='boldEleven' align='center'><b>S.No</b></td>");
	out.println("<td class='boldEleven' align='center'><b>Invoice</b></td>");
	out.println("<td class='boldEleven' align='center'><b>Customer</b></td>");
	out.println("<td class='boldEleven' align='center'><b>Sale Date</b></td>");
	out.println("<td class='boldEleven' align='center'><b>Sale Amount</b></td>");
	out.println("<td class='boldEleven' align='center'><b>Balance</b></td>");
	out.println("<td class='boldEleven' align='center'><b>Paid Amount</b></td>");
	out.println("<td class='boldEleven' align='center'><b></b></td>");
	//out.println("<td class='boldEleven' align='center'><b></b></td>");
	//out.println("<td class='boldEleven' align='center'><b></b></td>");
	out.println("</tr>");
	for(int u=0;u<data.length;u++)
	{
		if(u%2 ==0)
			out.println("<tr class='MRow1'>");
		else
			out.println("<tr class='MRow2'>");	
			
		out.println("<td class='boldEleven'>"+(u+1)+".</td>");
		out.println("<td class='boldEleven'>"+data[u][0]+"</td>");
		out.println("<td class='boldEleven'>"+data[u][1]+"</td>");
		out.println("<td class='boldEleven'>"+data[u][2]+"</td>");
		 
		
		out.println("<td class='boldEleven' align='right'> "+data[u][3]);
		out.println("<input name='salesAmount"+(u)+"' value='"+data[u][3]+"' size='10' type='hidden' class='formText135'");
		out.println("id='salesAmount"+(u)+"' maxlength='15' onKeyPress=\"doubleValue('salesAmount"+(u)+"','5')\"  readonly='readonly'>");
		out.println("</td>");
									
		//Balance Amount
		out.println("<td class='boldEleven' align='right'> "+data[u][4]);
		out.println("<input name='Balance"+(u)+"' value='"+data[u][4]+"' size='10' type='hidden' class='formText135' id='Balance"+(u)+"' maxlength='15' " );
		out.println("onKeyPress=\"doubleValue('Balance"+(u)+"','5')\" readonly='readonly'>" );
		out.println("</td>");
		
		//Paind Amount
		out.println("<td class='boldEleven'> ");
		out.println("<input name='Paid"+(u)+"' size='10' type='text' class='formText135' id='Paid"+(u)+"' value='0'  ");
		out.println("maxlength='10' onKeyUp=\"extractNumber(this,2,true),CheckBalance(this,'Balance"+(u)+"','"+(u)+"');\"    ");
		out.println("onKeyPress=\"return blockNonNumbers(this, event, true, true);\" onBlur=\"checkfillAmount()\" > <div id='Valid"+(u)+"'></div>	");
		out.println("</td>");
		 
		out.println("<td class='boldEleven'>");
		out.println("<input name='paidrow"+(u)+"'  id='paidrow"+(u)+"' type='checkbox' value='Y' onClick=\"fillBalance('"+u+"')\">");
		out.println("<input name='salesnumber"+(u)+"'  id='salesnumber"+(u)+"' type='hidden' value='"+data[u][0]+"'>");
		out.println("<input name='customerid'  id='customerid' type='hidden' value='"+data[u][5]+"'>");
		out.println("<input name='checkboxs"+(u)+"'  id='checkboxs"+(u)+"' type='hidden' value='"+data[u][6]+"'>");
		out.println("</td>");
		
		 
		//out.println("<td class='boldEleven'></td>");
		//out.println("<td class='boldEleven'></td>");
		
		out.println("</tr>");
	}
	out.println("</table>");
	out.println("<center>");
	
	out.println("<input name='totalrecords'  id='totalrecords' type='hidden' value='"+data.length+"'>");
	
	
}
else
{
		out.println("<center>");
		out.println("<font class='Bolddeepred'> Data not fond </font>");
		out.println("</center>");
		
		
}
%></td>
						          </tr>
							      <tr>
							        <td colspan="6">
                                    
<%
if(data.length>0)
{
	%>                                    
                                    
                                    <table border="0" align="center" cellpadding="2" cellspacing="2">
							          <tr>
							            <td class="boldEleven">Filled Amount </td>
							            <td><div id='filledamount'></div></td>
						              </tr>
							          <tr>
							            <td class="boldEleven">Payment Method <span
									class="bolddeepred">* 
						                </span></td>
							            <td><select name="paymentMethod"
									id="paymentMethod" style="width: 200" class="formText135"
									onblur='assignNumber(this)'>
							              <option value="Select">Select</option>
							              <%
					  	String payments[][] = CommonFunctions.QueryExecute("SELECT INT_PAYMENTTERMID,CHR_PAYMENTNAME FROM inv_m_paymentterms  ");	
						
					  for(int u=0; u<payments.length;u++)
					  		out.println("<option value='"+payments[u][0]+","+payments[u][1]+"'>"+payments[u][1]+"</option>");
					  %>
							              </select></td>
						              </tr>
							          <tr  id="chk1">
							            <td class="boldEleven">Bank Name <span
									class="bolddeepred">* </span></td>
							            <td><select name="Bank" id="Bank"
									style="width: 200">
							              <option value="">Select</option>  
							              <%
					   sql = "SELECT INT_BANKGROUPID, CHR_BANKGROUPNAME FROM com_m_bankgroup ORDER BY CHR_BANKGROUPNAME";
					   String banks[][] = CommonFunctions.QueryExecute(sql);
					  for(int u=0; u<banks.length;u++)
					  		out.println("<option value='"+banks[u][0]+"'>"+banks[u][1]+"</option>");
					  %>
							              </select></td>
						              </tr>
							          <tr  id="chk2">
							            <td class="boldEleven">Cheque/ D.D /Credit Card
							              /NEFT / RTGS Number<span class="bolddeepred">* </span></td>
							            <td><input name="Challanno"
									type="text" class="formText135"   onBlur="upperMe(this)"    id="Challanno" size="27" maxlength="20"></td>
						              </tr>
							          <tr  id="chk3">
							            <td class="boldEleven">Cheque/ D.D  / Date</td>
							            <td><input name="chequeDate"
									type="text" class="formText135" id="chequeDate" size="27"
									onKeyPress="dateOnly(this)"  readonly="readonly" />
							              <a
									href="javascript:ccal1.popup();"> <img
									src="../JavaScript/img/cal.gif" width="16" height="16"
									border="0" /></a>
							              <script language='JavaScript'
									type="text/javascript">
						<!--			
							var ccal1 = new calendar1(document.forms['frm'].elements['chequeDate']);
							ccal1.year_scroll = true;
							ccal1.time_comp = false;
							setCurrentDate('chequeDate'); 
						//-->
                                      </script></td>
						              </tr>
							          <tr>
							            <td class="boldEleven">Payment Received Date <span
									class="bolddeepred">* </span></td>
							            <td><input name="paymentDate"
									type="text" class="formText135" id="paymentDate" size="27"
									onKeyPress="dateOnly(this)" readonly />
							              <a
									href="javascript:cal1.popup();"> <img
									src="../JavaScript/img/cal.gif" width="16" height="16"
									border="0" /></a>
							              <script language='JavaScript'
									type="text/javascript">
						<!--			
							var cal1 = new calendar1(document.forms['frm'].elements['paymentDate']);
							cal1.year_scroll = true;
							cal1.time_comp = false;
							setCurrentDate('paymentDate'); 
						//-->
                                      </script></td>
						              </tr>
							          <tr>
							            <td valign="top" class="boldEleven">Cheque Amount  <span
									class="bolddeepred">* </span></td>
							            <td><input name="chequeamount" size="27" type="text" class="formText135" id="chequeamount" maxlength="12" onKeyUp="extractNumber(this,2,true) " onKeyPress="return blockNonNumbers(this, event, true, true);"
									   ></td>
						              </tr>
							          <tr>
							            <td valign="top" class="boldEleven">Remarks <span
									class="bolddeepred">* </span></td>
							            <td><textarea name="remarks"
									cols="25" rows="5" class="formText135" id="remarks"></textarea></td>
						              </tr>
							          <tr>
							            <td valign="top" class="boldEleven">Payment collected by <span
									class="bolddeepred">* </span></td>
							            <td><select name="ref" id="ref"
										class="formText135" size="5" style="width:200">
							              <jsp:include page="Staffload.jsp" flush="true" />                                    
							              </select></td>
						              </tr>
							          <tr>
							            <td class="boldEleven">Credit to <span
									class="bolddeepred">* </span></td>
							            <td><select name="creditto" class="formText135" id="creditto" style="width:200">
							              <option value="">Select</option>
							              <%
					   sql = "SELECT INT_DEPOSITID, CHR_DEPOSITNAME FROM com_m_deposit_to WHERE CHR_STATUS !='N' ORDER BY CHR_DEPOSITNAME";
					   String deposit[][] = CommonFunctions.QueryExecute(sql);
					  for(int u=0; u<deposit.length;u++)
					  		out.println("<option value='"+deposit[u][0]+"'>"+deposit[u][1]+"</option>");
					  %>
							              </select></td>
						              </tr>
							          <tr>
							            <td>&nbsp;</td>
							            <td>&nbsp;</td>
						              </tr>
						            </table>
                                    
<%
}
%>                                    
                                    
                                    </td>
						          </tr>
							      <tr>
							        <td colspan="6">&nbsp;</td>
						          </tr>
							      <tr>
							        <td>&nbsp;</td>
							        <td>&nbsp;</td>
							        <td>&nbsp;</td>
							        <td>&nbsp;</td>
							        <td>&nbsp;</td>
							        <td>&nbsp;</td>
						          </tr>
							      <tr>
							        <td colspan="6"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
							          <tr>
							            <td>
                                        
                                        
                                        <%
if(data.length>0)
{
	%>                                    

                                        <input name="Submit11" type="submit" id="submit"
											class="buttonbold13" value="Submit"   accesskey="s"   >
                                            
<%
}
%>
                                            
                                            </td>
							            <td><input name="Close" type="Button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="redirect('SingleEntryMultipleInvoice.jsp')"></td>
						              </tr>
							          </table></td>
						          </tr>
						        </table>
						      </td>
						  </tr>
						</tbody>
						<input type="hidden" name="mobileBookingOption" />
					</table>					</td>
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
	</table>	  </td>
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

<script language="javascript">




function fillBalance(rowid)
{
	try
	{
		if(document.getElementById('paidrow'+rowid).checked)
		{
			var bval=document.getElementById('Balance'+rowid).value;
			document.getElementById('Paid'+rowid).value = bval;
		}
		else
		{
			document.getElementById('Paid'+rowid).value = "0";
		}
		checkfillAmount();
	}
	catch(err)
	{
		alert(err)
	}
}



function checkfillAmount()
{
	try
	{
		 
		var paidamountamount=0;
		var sum=0;
		var count="<%=l%>";
		for( i=0;i<count;i++)
		{
			
			if(document.getElementById('paidrow'+i).checked)
				paidamountamount = parseFloat(document.getElementById('Paid'+i).value);
			else
				paidamountamount =0;
			sum = sum+paidamountamount;
		}
		
		var str="<center><font class='bolddeepred'>"+sum+"</font><center>";
	 	var tb=document.getElementById('filledamount');	 
  	 	tb.innerHTML=str  ;
		 
		
	}
	catch(err)
	{
		alert(err)
	}
}

function checkfillAmountAndChequeAmount()
{
	try
	{
		if(document.getElementById('chequeamount').value == "")
		{
			alert("Kindly enter the Cheque Amount...");
			return false;
		}
		
		var chequeamount=document.getElementById('chequeamount').value;
		var paidamountamount=0;
		var sum=0;
		var count="<%=l%>";
		for( i=0;i<count;i++)
		{
			if(document.getElementById('paidrow'+i).checked)
				paidamountamount = parseFloat(document.getElementById('Paid'+i).value);
			else
				paidamountamount =0;
			
			sum = sum+paidamountamount;
		}
		
		if( chequeamount != sum )
		{
			alert("Kindly check the paind amount is not equal to check amount ");
			document.getElementById('chequeamount').value="";
			document.getElementById('chequeamount').focus();
			return false;
		}
		else
		{
			return true;
		}
		
	}
	catch(err)
	{
		alert(err)
	}
}

</script>
</form>
<%@ include file="../footer.jsp"%>
</body>
</html>



<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>
