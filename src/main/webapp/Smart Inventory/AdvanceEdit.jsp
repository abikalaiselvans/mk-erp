 <%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
 
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
<script language="javascript" src="../JavaScript/calendar1.js"></script>
 <script language="JavaScript">
 	
	
	
	
  function Validate()
  {
   
    
	if(
		 
		 checkNullSelect("customer","Select customer...",'0') 
		&& checkNullSelect("divis","Select divis...",'0') 
		&& checkNullSelect("advanceto","Select advanceto...",'0')
		&& checkNullSelect("paymentMethod","Select paymentMethod...",'0') 
		&& checkNull("receivedDate","Enter receivedDate...") 
		&& checkNull("Advanceamount","Enter Advanceamount...")
		&& checkNull("remarks","Enter remarks...")
		&& checkNull("ref","Select Payment collected by...")
		&& checkNullSelect("creditto","Select credited to",'') 
	 )
	{		
		sval=document.getElementById('paymentMethod').value;	
		var its =sval.split(",");
		if(its[1] != "CASH" || its[1] != "CASH")
		{
			if(checkNullSelect("Bank","Select Bank Name ","0") && 
			checkNull('Challanno','Enter '+its[1]+' NO'))
				return true;
			else
				return false;
		}
		else
			return true;	
	}		
	else
		return false;	
		
  } 
  
  
  
 	
</script>
<%
 //
%>

<body  >

<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" action="../SmartLoginAuth" method="post" onSubmit="return Validate()">
<table width="100%" border="0" cellspacing="1" cellpadding="1">
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
					<td width="50">
					<table cellspacing="2" cellpadding="2" width="400" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							<tr>
								<td height="16" colspan="3" align="center" valign="top"
									class="boldThirteen">Advance Payment
<%
String advanceid  = request.getParameter("advanceid");
String sql = " ";
sql = " SELECT INT_ADVANCEID,INT_CUSTOMERID,INT_DIVIID,INT_PAYMENTTERMID,INT_BANKID ,CHR_PAYNO, ";
sql = sql +" DATE_FORMAT(DAT_PAYMENTDATE,'%d-%m-%Y'),DATE_FORMAT(DAT_COLLECTEDDATE,'%d-%m-%Y'), ";
sql = sql +" DOU_ADVANCEAMOUNT,DATE_FORMAT(DAT_CREATEDATE,'%d-%m-%Y'),DATE_FORMAT(CHR_CREATED_BY,'%d-%m-%Y'), ";
sql = sql +" DATE_FORMAT(DAT_MODIFIEDDATE,'%d-%m-%Y'),CHR_MODIFIED_BY,CHR_DESC,CHR_COLLECTEDBY,CHR_TRANSFERD, ";
sql = sql +" CHR_DELETEFLAG,CHR_TYPE,INT_DEPOSITID,CHR_ADVANCEID,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS  FROM inv_t_advancepayment  ";
sql = sql +" WHERE INT_ADVANCEID= "+advanceid;
//out.println(sql);
String dbdata[][] =  CommonFunctions.QueryExecute(sql);

%>									
									
									
							  </td>
							</tr>
							<tr>
								<td height="19" colspan="3" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">
								Mandatory </span></td>
							</tr>
							 
							 
				
				<tr>
				 <td class="boldEleven">Customer <span
									class="bolddeepred">* </span></td>
                <td><span class="boldThirteen">
                  <select name="customer" style="width:150" id="customer" class="formText135"   >
                    <option value="0">Select Customer</option>
                    <jsp:include page="LoadCustomer.jsp" />                  
</select>
 <script language="javascript">setOptionValue('customer','<%=dbdata[0][1]%>')</script>               </span></td>
                </tr>
				
							<tr>
							  <td height="17" class="boldEleven">Advance to <span
									class="bolddeepred">* </span></td>
							  <td colspan="2" align="left"><select name="advanceto" class="formText135" id="advanceto">
							    <option value="0">Select Type</option>
							    <option value="D">Sales</option>
							    <option value="S">Service</option>
						      </select>
                              
                              <script language="javascript">setOptionValue('advanceto','<%=dbdata[0][17]%>')</script>
                              </td>
						  </tr>
							<tr>
							  <td height="17" class="boldEleven">Division <span
									class="bolddeepred">* </span></td>
							  <td colspan="2" align="left"><span class="boldThirteen">
							    <select name="divis"
							class="formText135" id="divis"  style="width:150"  onChange="loadAdvanceAmount('0')"
							>
                                 <option value="0">Select Division</option>
                                  <%
								String division[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division   WHERE INT_DIVIID >0 AND CHR_OFFICEIDS LIKE '%"+session.getAttribute("INVOFFICEID")+"%'  ORDER BY CHR_DIVICODE"); 
								for(int u=0; u<division.length; u++)
									out.print("<option value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
							%>
                                </select>
								<script language="javascript">setOptionValue('divis','<%=dbdata[0][2]%>')</script> 
							  </span></td>
						  </tr>
							 

							 
							<tr>
								<td height="17" class="boldEleven">Payment Method <span
									class="bolddeepred">* </span></td>
								<td colspan="2" align="left">
								
<select name="paymentMethod" id="paymentMethod"  style="width:150"  class="formText135" onBlur="assignNumber('paymentMethod')">
	<option value="0">Select paymentMethod</option>
<%
	String payments[][] =  com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_PAYMENTTERMID,CHR_PAYMENTNAME FROM inv_m_paymentterms  ");	

	for(int u=0; u<payments.length;u++)
		if(payments[u][0].equals(dbdata[0][3]))
			out.println("<option  selected value='"+payments[u][0]+","+payments[u][1]+"'>"+payments[u][1]+"</option>");
		else
			out.println("<option    value='"+payments[u][0]+","+payments[u][1]+"'>"+payments[u][1]+"</option>");
%>
</select> 


 								</td>
							</tr>
							<tr id="chk1">
								<td height="17" class="boldEleven">Bank Name <span
									class="bolddeepred">* </span></td>
								<td colspan="2" align="left"><select name="Bank" class="formText135" id="Bank"
									 style="width:150" >
									<option value="0">Select Bank</option>
									<%
					   String banks[][]=CommonFunctions.QueryExecute("SELECT INT_BANKGROUPID, CHR_BANKGROUPNAME FROM com_m_bankgroup ORDER BY CHR_BANKGROUPNAME");
					  for(int u=0; u<banks.length;u++)
					  		out.println("<option value='"+banks[u][0]+"'>"+banks[u][1]+"</option>");
					  %>
								</select>
								<script language="javascript">setOptionValue('Bank','<%=dbdata[0][4]%>')</script> 
								
								</td>
							</tr>
							<tr id="chk2">
								<td height="17" class="boldEleven">Cheque/ D.D /Credit Card
								Number<span class="bolddeepred">* </span></td>
								<td colspan="2" align="left"><input name="Challanno"
									type="text" class="formText135" id="Challanno" value="<%=dbdata[0][5]%>" size="31" maxlength="22"></td>
							</tr>
							<tr id="chk3">
							  <td height="17" class="boldEleven">Cheque/ D.D  / Date</td>
							  <td colspan="2" align="left"><input name="chequeDate" value="<%=dbdata[0][6]%>"
									type="text" class="formText135" id="chequeDate" size="27"
									 readonly="readonly" />
                                <a
									href="javascript:ccal1.popup();"> <img
									src="../JavaScript/img/cal.gif" width="16" height="16"
									border="0" /> </a>
                                <script language='JavaScript'
									type="text/javascript">
						<!--			
							var ccal1 = new calendar1(document.forms['frm'].elements['chequeDate']);
							ccal1.year_scroll = true;
							ccal1.time_comp = false;
							
						//-->
                                </script></td>
						  </tr>
							<tr>
								<td height="17" class="boldEleven">Advance Received Date <span
									class="bolddeepred">* </span></td>
								<td colspan="2" align="left"><input name="receivedDate"
									type="text" class="formText135" id="receivedDate" size="27"
									onKeyPress="dateOnly(this)" readonly  value="<%=dbdata[0][7]%>"/> <a
									href="javascript:cal1.popup();"> <img
									src="../JavaScript/img/cal.gif" width="16" height="16"
									border="0" /> </a> <script language='JavaScript'
									type="text/javascript">
						<!--			
							var cal1 = new calendar1(document.forms['frm'].elements['receivedDate']);
							cal1.year_scroll = true;
							cal1.time_comp = false;
							 
						//-->
                       </script></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Advance Amount <span
									class="bolddeepred">* </span></td>
								<td colspan="2" align="left"><input name="Advanceamount"
									  size="30" type="text" class="formText135"
									id="Advanceamount" maxlength="8"  onKeyPress="return numeric_only(event,'Advanceamount','15')"  onpaste="return false;" value="<%=dbdata[0][8]%>"></td>
							</tr>
							 
							<tr>
								<td height="17" valign="top" class="boldEleven">Description  								 <span
									class="bolddeepred">* </span></td>
							  <td colspan="2" align="left"><textarea name="remarks"
									cols="25" rows="5" class="formText135" id="remarks"><%=dbdata[0][13]%></textarea>							    </td>
							</tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven">Payment collected by  <span
									class="bolddeepred">* </span></td>
							  <td colspan="2" align="left" valign="top"><select name="ref" id="ref"
										class="formText135" size="5" style="width:200">
                                <jsp:include page="Staffload.jsp" flush="true" />                              
</select>
<script language="javascript">setOptionValue('ref','<%=dbdata[0][14]%>')</script>
</td>
						  </tr>
							<tr>
							  <td height="17" class="boldEleven">Credit to <span
									class="bolddeepred">* </span></td>
							  <td colspan="2" align="left"><select name="creditto" class="formText135" id="creditto" style="width:200">
							    <option value="">Select</option>
							    <%
					  
					   String deposit[][] = CommonFunctions.QueryExecute("SELECT INT_DEPOSITID, CHR_DEPOSITNAME FROM com_m_deposit_to WHERE CHR_STATUS !='N' ORDER BY CHR_DEPOSITNAME");
					  for(int u=0; u<deposit.length;u++)
					  		out.println("<option value='"+deposit[u][0]+"'>"+deposit[u][1]+"</option>");
					  %>
						      </select>
                              
                              <script language="javascript">setOptionValue('creditto','<%=dbdata[0][18]%>')</script>
                              
                              </td>
						  </tr>
							<tr>
								<td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td colspan="2" align="left"><input name="filename"
									type="hidden" value="Advance" /> <input name="actionS"
									type="hidden" value="INVAdvanceAmountUpdate" />
						        <input name="advanceid" type="hidden" id="advanceid" value="<%=advanceid%>">
						        <input type="hidden" name="advancenumber" id="advancenumber" value="<%=dbdata[0][19]%>"></td>
							</tr>
							<tr>
								<td height="17" colspan="3" class="boldEleven">
								<table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
									<tr>
										<td><input name="Submit11" type="submit" id="submit"
											class="buttonbold13" value="Update"></td>
										<td><input name="Close" type="Button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="redirect('Advance.jsp')"></td>
									</tr>
								</table>								</td>
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
</table>
 <script language="javascript">
	assignNumber('paymentMethod') 
   		
	function assignNumber(itms)
	{
		var itm = document.getElementById(itms).value;
		var its = itm.split(",");
		if(its[1] != "CASH" || its[1] != "CASH")
			enable();
		else
			disable();
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


</script></form>
<%@ include file="../footer.jsp"%>
</body>
</html>
