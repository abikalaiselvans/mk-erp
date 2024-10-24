<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<html>
<head>
<title><%= CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='INV' ")[0][0]%></title>
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
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<style type="text/css">
@import url("../JavaScript/SmartStyles.css");
</style>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="javascript" src="../JavaScript/Inventory/SpareDemandnumber.js"></script>
<script language="javascript" src="../JavaScript/Inventory/SSpareloaditemproduct.js"></script>
<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script type="text/javascript" src="../JavaScript/jquery/Time/jquery-ui.min.js"></script>
<script type="text/javascript" src="../JavaScript/jquery/Time/jquery-ui-timepicker-addon.js"></script>
<script type="text/javascript" src="../JavaScript/jquery/Time/jquery-ui-sliderAccess.js"></script>
<script language="JavaScript">
function  usedquantity(qty){
	var returnquatityno=document.getElementById('qty').value;
	var issueqty=document.getElementById('quantity').value;
	document.getElementById('usedquatity').value = parseInt(issueqty)-parseInt(returnquatityno);
}

function LoadSelecttypeMessages() 
{	 
	var issueserialno=document.getElementById('issueserialno').value;
	var receivedserialno=document.getElementById('receivedserialno').value
	if(issueserialno==receivedserialno){
		var typename = 'Good';
	 	var typeid = 'Y';
	  	var _targ=document.getElementsByName('receivedstatus')[0];  
    	_targ.options.length=0;
	    _targ.options[0]=new Option(typename,typeid);
	}
	else if((issueserialno!=receivedserialno) && (receivedserialno != "") ){
		var typename = 'Bad';
	 	var typeid = 'B';
	  	var _targ=document.getElementsByName('receivedstatus')[0];  
    	_targ.options.length=0;
	    _targ.options[0]=new Option(typename,typeid);
	}
else{
	var typename = 'Pending';
	 var typeid = 'N';
	  var _targ=document.getElementsByName('receivedstatus')[0];  
    _targ.options.length=0;
	 _targ.options[0]=new Option(typename,typeid);
	 }
}

</script>
<script language="JavaScript">

 
	function validate()
	{
	if(
		checkserial()
		&& checkNull("recivedDate","Enter receivedDate...")
		&& checkNull("receiveddescription","Enter the Description...")
		&& checkNullSelect("returntype","Select Return Type...",'0')
	)
		return true;
	else
		return false;
}	
	function checkserial()
	{
	var sptyp=document.getElementById('sparetype').value
	if(sptyp=='S'){
	if(checkNull("receivedserialno","Enter the serial No...") 
	&& checkNullSelect("receivedstatus","Select Received Status...",'0') 
	)
		return true;
	else
		return false;
	}
	if(sptyp=='C'){
	if(checkNullSelect("qty","Select Quatity...",'0'))
		return true;
	else
		return false;
	}
	}
</script>
 <body onLoad=""><!--checkqty()-->
<%@ include file="indexinv.jsp"%>
<link href="../JavaScript/jquery/Time/jquery-ui.css" rel="stylesheet" type="text/css">
<link href="../JavaScript/jquery/Time/jquery-ui-timepicker-addon.css" rel="stylesheet" type="text/css">
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth" onSubmit="return validate()">
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
					<table cellspacing="2" cellpadding="2" width="510" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							<tr>
								<td height="16" colspan="3" align="center" valign="top"
									class="boldThirteen">SPARE RETURN</td>
							</tr>
							<tr>
								<td height="19" colspan="3" align="right" valign="top">
								<%
String Rowid = request.getParameter("id");
String idissue="",demandNo="",sparetype ="",type="",productcode="",qty="",issueserialnum="",issuestatus="",issueby="",issuedate="",despatchthrough="",description="",typedescrip="";
String sql="SELECT INT_ISSUEID,CHR_DEMANDNO,CHR_SPARETYPE,CHR_TYPE,CHR_PRODUCTCODE,INT_QTY,CHR_ISSUED_SERIALNUMBER,CHR_ISSUED,CHR_ISSUED_BY,DATE_FORMAT(DAT_ISSUED_DATE,'%d-%b-%Y %H:%m:%s'),CHR_ISSUE_THROUGH,CHR_ISSUE_DESC ";
sql = sql+" FROM inv_ss_t_sparedemandissue  WHERE  INT_ISSUEID="+Rowid+"";
String data1[][]=  CommonFunctions.QueryExecute(sql);
								idissue=data1[0][0];
								demandNo=data1[0][1];
								sparetype=data1[0][2];
								type=data1[0][3];
								productcode= data1[0][4];
								qty=data1[0][5];
								issueserialnum=data1[0][6];
								issuestatus=data1[0][7];
								issuedate=data1[0][9];
								despatchthrough=data1[0][10];
								description=data1[0][11];
								if(type.equals("P"))
									typedescrip="Product";
								else
									typedescrip="Item";
%>
								<span class="bolddeepred">* </span><span class="fairyHead">
								Mandatory </span></td>
							</tr>
							<tr>
								<td width="172" height="17" class="boldEleven">
								Demand Number</td>
								<td colspan="2" align="left"> 
								<%=demandNo%>								</td>
							</tr>
							<tr>
							  <td height="17" colspan="3" class="boldEleven">
							  <%
String demanddetail = request.getParameter("demandId");
String sql1="SELECT a.CHR_CALLNUMBER,a.CHR_PRODUCT_SERIALNUMBER,DATE_FORMAT(a.DAT_DEMAND_RAISED_DATE,'%d-%b-%Y %H:%m:%s'),a.CHR_DEMAND_RAISED_BY,a.CHR_DESPATCH_LOCATION FROM inv_ss_sparedemand a,com_m_branch b WHERE a.INT_DEMANID>0 AND a.INT_BRANCHID=b.INT_BRANCHID  AND a.CHR_DEMANDNO ='"+demandNo+"' ORDER BY a.CHR_DEMANDNO";
String datas[][] =  CommonFunctions.QueryExecute(sql1);
if(datas.length>0)
{
	out.println("<center><table width='100%' border='0' bgcolor='#9900CC'  class='boldEleven' cellpadding='2' cellspacing='1'>");
	out.println("<tr bgcolor='#ffffff'><td class='boldEleven'><b> S.No");
	out.println("<td class='boldEleven'><b> Call No");
	out.println("<td class='boldEleven'><b> Serial No");
	out.println("<td class='boldEleven'><b> Raised Date");
	out.println("<td class='boldEleven'><b> Raised By");
	out.println("<td class='boldEleven'><b>Depatch Location");
	for(int u=0;u<datas.length;u++)
	{
		if(u%2==0)
			out.println("<tr bgcolor='#ffffff' class='MROW1'><td>"+(u+1));
		else
			out.println("<tr bgcolor='#ffffff' class='MROW2'><td>"+(u+1));
			
		out.println("<td class='boldEleven'>"+datas[u][0]);
		out.println("<td class='boldEleven'>"+datas[u][1]);
		out.println("<td class='boldEleven'>"+datas[u][2]);
		out.println("<td class='boldEleven'>"+datas[u][3]);
		out.println("<td class='boldEleven'>"+datas[u][4]);
		
	}
	out.println("</table></center>");
}
%>							  </td>
						  	</tr>
							
							<tr>
							  <td height="17" colspan="3" class="boldEleven"><table width="100%" border="1" cellpadding="3" cellspacing="2" class="boldEleven">
							    <tr>
							      <td width="22%" class="boldEleven">Spare Type</td>
							      <td width="36%">
                                    <span class="boldEleven">
                                    <%
								  if("C".equals(sparetype.trim()))
								  	out.println("Consumable");
								  else
								  	out.println("Serial");	
								   %>
								  
                                 
                                  </span></td>
							      <td width="21%" class="boldEleven">Product Type</td>
							      <td width="21%" class="boldEleven"><%=typedescrip%></td>
						        </tr>
							    <tr>
							      <td class="boldEleven">Product Code</td>
							      <td class="boldEleven">
						          <%
								String producttype[][]=null;
								if("I".equals(type)){
								
								producttype =  CommonFunctions.QueryExecute("Select replace(UPPER(CHR_ITEMNAME),'&','AND') from inv_m_item   WHERE INT_ACTIVE=1 AND CHR_ITEMID ='"+productcode+"' ORDER BY CHR_ITEMNAME");
								 }
								if("P".equals(type) && ("S".equals(sparetype))){
								producttype =  CommonFunctions.QueryExecute("select replace(UPPER(CHR_PRODUCTCODE),'&','AND')from inv_m_produtlist  WHERE CHR_PTYPE!= 'S' AND CHR_PRODUCTID='"+productcode+"' ORDER BY CHR_PRODUCTCODE");
								}
								if(("P".equals(type)) && ("C".equals(sparetype)) ){
								producttype =  CommonFunctions.QueryExecute("Select CHR_PRODUCTCODE from inv_m_produtlist WHERE CHR_PRODUCTID >0 AND CHR_PTYPE= 'S'  AND CHR_PRODUCTID='"+productcode+"' ORDER BY CHR_PRODUCTID");
								}
								
									%>
						          <%=producttype[0][0]%></td>
							      <td class="boldEleven">Spare Issuedate</td>
							      <td class="boldEleven"><%=issuedate%></td>
						        </tr>
							    <tr>
							      <td class="boldEleven">
                                  
                                  <%
								  	if("C".equals(sparetype))
								  		out.println("Qty");
									else if("S".equals(sparetype))
										out.println("Serial Number");
									else
									 out.println("");
								  %>
                                  
                                  </td>
							      <td class="boldEleven"> 
                                  <%
								  	if("C".equals(sparetype))
								  		out.println(qty);
									else  if("S".equals(sparetype))
										out.println(issueserialnum);
									else
									 out.println("");
								  %>
                                  
                                  </td>
							      <td class="boldEleven">Spare Issue</td>
							      <td class="boldEleven"><%
					   		String ird="";
							String ird1="";
									
									if("Y".equals(issuestatus.trim()))
										ird="Issue";
							
									if("N".equals(issuestatus.trim()))
										ird="Not Issue";
								 %>
                                  <%=ird%></td>
						        </tr>
							     
							    <tr>
							      <td class="boldEleven">Despatch Through</td>
							      <td class="boldEleven">
								  <%
								  if("C".equals(despatchthrough))
								  	out.println("Courier");
 								  else if("P".equals(despatchthrough))
								  	out.println("Person");	
								  else if("V".equals(despatchthrough))
								  	out.println("Vechicle");	
								  
								  %></td>
							      <td class="boldEleven">Despatch Details</td>
							      <td class="boldEleven"><%=description%></td>
						        </tr>
							    <tr>
							      <td>&nbsp;</td>
							      <td>&nbsp;</td>
							      <td>&nbsp;</td>
							      <td>&nbsp;</td>
						        </tr>
						      </table></td>
						  </tr>
							 
							 
							<%if("S".equals(sparetype)){%>
							<tr>
								<td height="17" valign="top" class="boldEleven">Received SerialNo<span class="bolddeepred"> * </span></td>
								<td colspan="2" align="left"><input name="receivedserialno" size="27" type="text" class="formText135" id="receivedserialno" onKeyUp="LoadSelecttypeMessages()"/></td>
							</tr>
							<tr>
								<td height="17" valign="top" class="boldEleven">Received Status <span class="bolddeepred">*</span></td>
								<td colspan="2" align="left">
								<select name="receivedstatus" id = "receivedstatus" style="width: 160">
										<option value="N">Pending</option>
									</select></td>
							</tr><%}%>
							<%if("C".equals(sparetype)){%>
							<tr>
								<td height="17" class="boldEleven">Qty<span
									class="bolddeepred"> * </span></td>
								<td colspan="2" align="left">
								<select name="qty" id="qty" style="width:160" class="formText135" onChange="usedquantity(this)">
									<option value="0">Select</option>
									<%
					  					for(int u=1; u<=Integer.parseInt(qty);u++)
					  						out.println("<option value='"+u+"'>"+u+"</option>");
					 			    %>
								</select> </td>
							</tr><%}%>
				
							<tr>
							  <td height="17" class="boldEleven">Spare Returndate <span class="bolddeepred">*</span></td>
							  <td colspan="2" align="left"><input name="recivedDate"
									type="text" class="formText135" id="recivedDate" size="27"
									 readonly  value=""/>
                                <script language="javascript">
								setCurrentDateandTime('recivedDate');
						$('#recivedDate').datetimepicker({
						
						timeFormat: 'hh:mm:ss',
						stepHour: 1,
						stepMinute: 1,
						stepSecond: 10,
						changeMonth: true,
						changeYear: true,
						minDate: -20, maxDate: "+0D" ,showOn: "button",
						buttonImage: "../JavaScript/jquery/images/calendar.gif",
						numberOfMonths: 1,
						buttonImageOnly: true,
			
							onClose: function(dateText, inst) {
								var startDateTextBox = $('#recivedDate');
								if (startDateTextBox.val() != '') {
									var testStartDate = new Date(startDateTextBox.val());
									var testEndDate = new Date(dateText);
									if (testStartDate > testEndDate)
										startDateTextBox.val(dateText);
								}
								else {
									startDateTextBox.val(dateText);
								}
							},
							
						});
				</script>				</td>
				</tr>
				<tr>
					<td height="17" valign="top" class="boldEleven">Received Description<span class="bolddeepred"> * </span></td>
					<td colspan="2" align="left"><textarea name="receiveddescription" cols="24" rows="5" class="formText135" id="receiveddescription"></textarea></td>
				</tr>
				
				
				<tr>
								<td height="17" valign="top" class="boldEleven">Return Type<span class="bolddeepred"> *</span></td>
								<td colspan="2" align="left">
								<select name="returntype" id = "returntype" style="width: 160">
										<option value="0">Select</option>
					  					<option value="R">Returned</option>
										<option value="S">Stand BY</option>
										<option value="M">Replacement </option>
										<option value="B">Billed </option>
									</select></td>
				</tr>
							
							<tr>
								<td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td colspan="2" align="left">
							  	<input name="filename" type="hidden" value="SSpareReturnitemproduct" /> 
								<input name="actionS" type="hidden" value="INVSparereturnitemproductedit" />
								<input id="issueserialno" name="issueserialno" type="hidden" value="<%=issueserialnum%>" />
								<input id="quantity" name="quantity" type="hidden" value="<%=qty%>" />
								<input id="usedquatity" name="usedquatity" type="hidden" value="" />
								<input id="sparetype" name="sparetype" type="hidden" value="<%=sparetype%>" />
								<input id="returnid" name="returnid" type="hidden" value="<%=idissue%>" />
							  </td>
							</tr>
							<tr>
								<td height="17" colspan="3" class="boldEleven">
								<table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
									<tr>
										<td>
										<input type="submit" name="Submit"	id="submit_btn" class="buttonbold13" value="Return" />										</td>
										<td><input name="Close" type="Button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="redirect('SSparereturnview.jsp')"></td>
									</tr>
								</table>								</td>
							</tr>
						</tbody>
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
 
</form>
<%@ include file="../footer.jsp"%>
</body>
</html>
