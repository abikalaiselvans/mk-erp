<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
%>
 <html>
<head>
<title><%=CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='INV' ")[0][0]%></title>
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
<!--
@import url("../JavaScript/SmartStyles.css");
-->
 </style>
 </head>
<script language="javascript" src="../JavaScript/Inventory/Qtynovalidateedit.js"></script>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="javascript" src="../JavaScript/Inventory/SpareDemandnumber.js"></script>
<script language="javascript" src="../JavaScript/Inventory/SSpareloaditemproduct.js"></script>
<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script type="text/javascript" src="../JavaScript/jquery/Time/jquery-ui.min.js"></script>
<script type="text/javascript" src="../JavaScript/jquery/Time/jquery-ui-timepicker-addon.js"></script>
<script type="text/javascript" src="../JavaScript/jquery/Time/jquery-ui-sliderAccess.js"></script>
<script language="javascript" src="../JavaScript/Inventory/Serialnovalidate.js"></script>

 <body >

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
									class="boldThirteen">Spare Issue </td>
							</tr>
							<tr>
								<td height="19" colspan="3" align="right" valign="top">
								<%
String Rowid = request.getParameter("id");
String idissue="",demandNo="",sparetype ="",type="",productcode="",qty="",issueserialnum="",issuestatus="",issueby="",issuedate="",despatchthrough="",description="",typedescription="";
String sql="SELECT INT_ISSUEID,CHR_DEMANDNO,CHR_SPARETYPE,CHR_TYPE,CHR_PRODUCTCODE,INT_QTY,CHR_ISSUED_SERIALNUMBER,CHR_ISSUED,CHR_ISSUED_BY,DATE_FORMAT(DAT_ISSUED_DATE,'%d-%m-%Y %H:%i'),CHR_ISSUE_THROUGH,CHR_ISSUE_DESC ";
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
									typedescription="Product";
								else
									typedescription="Item";
%>
								<span class="bolddeepred">* </span><span class="fairyHead">
								Mandatory </span></td>
							</tr>
							<tr>
								<td width="172" height="17" class="boldEleven">
								Demand Number <span class="bolddeepred">* </span></td>
								<td colspan="2" align="left"> 
								<%=demandNo%>
								</td>
							</tr>
							<tr>
							  <td height="17" colspan="3" class="boldEleven">
							  <%
String demanddetail = request.getParameter("demandId");
String sql1="SELECT CHR_CALLNUMBER,CHR_PRODUCT_SERIALNUMBER,DAT_DEMAND_RAISED_DATE,CHR_DEMAND_RAISED_BY,CHR_DESPATCH_LOCATION FROM inv_ss_sparedemand a,com_m_branch b,inv_ss_sparemaster c WHERE a.INT_DEMANID>0 AND a.INT_BRANCHID=b.INT_BRANCHID AND c.CHR_SERIALNO=a.CHR_PRODUCT_SERIALNUMBER AND CHR_DEMANDNO ='"+demanddetail+"' ORDER BY CHR_DEMANDNO";
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
%>	
							  </td>
						  	</tr>
							
							<tr>
								<td height="17" class="boldEleven">Spare Type <span
									class="bolddeepred">* </span></td>
								<td colspan="2" align="left">
								<%if("C".equals(sparetype.trim())){%>
								 Consumable	
								 <%}else{%>
								 Serial
								 <%}%>	
								</td>
							</tr>
							
							<tr >
								<td height="17" class="boldEleven">Product Type<span
									class="bolddeepred"> * </span></td>
							    <td colspan="2" align="left">
								<%=typedescription%>
							  </td>
							</tr>
							<tr >
								<td height="17" class="boldEleven">Product Code</td>
							  <td colspan="2" align="left">
							  
							
                    				<%
								String producttype[][]=null;
								if("I".equals(type)){
								producttype =  CommonFunctions.QueryExecute("Select CHR_ITEMID,replace(UPPER(CHR_ITEMNAME),'&','AND') from inv_m_item   WHERE INT_ACTIVE=1 AND CHR_ITEMID='"+ productcode+"' ORDER BY CHR_ITEMNAME");
								 }
								if("P".equals(type) && ("S".equals(sparetype))){
								producttype =  CommonFunctions.QueryExecute("select CHR_PRODUCTID,replace(UPPER(CHR_PRODUCTCODE),'&','AND')from inv_m_produtlist  WHERE CHR_PTYPE!= 'S' AND CHR_PRODUCTID='"+ productcode+"' ORDER BY CHR_PRODUCTCODE");
								}
								if(("P".equals(type)) && ("C".equals(sparetype)) ){
								producttype =  CommonFunctions.QueryExecute("Select CHR_PRODUCTID,CHR_PRODUCTCODE from inv_m_produtlist WHERE CHR_PRODUCTID >0 AND CHR_PTYPE= 'S' AND CHR_PRODUCTID='"+ productcode+"' ORDER BY CHR_PRODUCTID");
								}
																	%>
									<%=producttype[0][1]%>
							  </td>
							</tr>
							<%if("C".equals(sparetype)){%>
							<tr>
								<td height="17" class="boldEleven">Qty<span
									class="bolddeepred"> * </span></td>
								<td colspan="2" align="left"><select name="qty"
									id="qty" style="width: 160" class="formText135"
									onChange="validQtynoedit(this.value)">
									<option value="0">Select</option>
									<%
					  					for(int u=1; u<11;u++)
					  						out.println("<option value='"+u+"'>"+u+"</option>");
					 			    %>
								</select> <script language="javascript">setOptionValue('qty','<%=qty%>')</script>
								<div id='divqtyeditname'></div>
								</td>
							</tr><%}%><%if("S".equals(sparetype)){%>
							<tr >
								<td height="17" class="boldEleven">Serial Number<span class="bolddeepred">* </span></td>
								<td colspan="2" align="left"> 
								
													
					
<script type="text/javascript">
function lookup(serialNo) 
{
	if(serialNo.length == 0) 
	{
		$('#suggestions').hide();
	} 
	else 
	{
		var itype= document.getElementById('itype').value;
		var icode= document.getElementById('prodid').value;
		$.post("sspareissueserialnumberget.jsp?itype="+itype+"&icode="+icode, {queryString: ""+serialNo+""}, function(data)
		{
			 
			if(data.length >0) 
			{
				$('#suggestions').show();
				$('#autoSuggestionsList').html(data);
			}
		});
	}
}

function fill(thisValue) 
{
	document.getElementById('serialno').value=thisValue;
	$('#serialno').val(thisValue);
	setTimeout("$('#suggestions').hide();", 200);
}
</script>
<style type="text/css">
body {
font-family: Helvetica;
font-size: 13px;
color: #000;
}
h3 {
margin: 0px;
padding: 0px;
}


.suggestionsBox 
{
	position: relative;
	margin: 0px 0px 0px 0px;
	width: 200px;
	background-color: #ffffff;
	-moz-border-radius: 7px;
	-webkit-border-radius: 7px;
	border: 1px solid #000;
	color: #000;
}
.suggestionList 
{
	margin: 0px;
	padding: 0px;
}
.suggestionList li 
{
	margin: 0px 0px 3px 0px;
	padding: 1px;
	cursor: pointer;
}

.suggestionList li:hover {
background-color: #99cc99;
}
</style>

					
								   <input name="serialno" type="text" class="formText135" id="serialno" tabindex="2" size="27" maxlength="30" onBlur="fill();"  <%=issueserialnum%> onkeyup=" lookup(this.value);"  >
                  <br>
                  <div class="suggestionsBox" id="suggestions" style="display: none;">
                    <div class="suggestionList" id="autoSuggestionsList" style="OVERFLOW:auto;width:100%;height:100px" ></div>
                    </div> 
					
					
					
					
								</td>
							</tr><%}%>
							<tr >
							  <td height="17" class="boldEleven">Spare Issuedate <span class="bolddeepred">* </span></td>
							  <td colspan="2" align="left"><input name="issueDate"
									type="text" class="formText135" id="issueDate" size="27"
									onKeyPress="dateOnly(this)" readonly="readonly"  value="<%=issuedate%>"/>
                                <script language="javascript">
						$('#issueDate').datetimepicker({
						
						defaultDate: "+1w",
						changeMonth: true,
						showSecond: true,
						timeFormat: 'hh:mm:ss',
						stepHour: 1,
						stepMinute: 1,
						stepSecond: 10,
						changeYear: true,
						showOn: "button",
						buttonImage: "../JavaScript/jquery/images/calendar.gif",
						numberOfMonths: 1,
						buttonImageOnly: true,
							onClose: function(dateText, inst) {
								var startDateTextBox = $('#issueDate');
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
				</script></td>
						  </tr>
							<tr>
								<td height="17" class="boldEleven">Spare Issue <span class="bolddeepred">* </span></td>
								<td colspan="2" align="left">
								 <%
					   		String ird="";
							String ird1="";
									
									if("Y".equals(issuestatus.trim()))
										ird ="checked='checked'";
							
									if("N".equals(issuestatus.trim()))
										ird1 ="checked='checked'";
								 %>		
								
									<input name="spareissue"  id="spareissue" type="radio" value="Y" <%=ird%> class="formText135" />Issue
								  	<input name="spareissue"  id="spareissue" type="radio" value="N" <%=ird1%> class="formText135" />Not Issue</td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Despatch Through <span class="bolddeepred">*</span></td>
								<td colspan="2" align="left">
									<select name="despatchthrough" id = "despatchthrough" style="width: 160">
										<option value="0">Select</option>
					  					<option value="C">Courier</option>
										<option value="P">Person</option>
										<option value="V">Vechicle </option>
									</select> <script language="javascript">setOptionValue('despatchthrough','<%=despatchthrough%>')</script></td>
							</tr>
							<tr>
								<td height="17" valign="top" class="boldEleven">Despatch Details <span class="bolddeepred">* </span>
		 					  </td>
								<td colspan="2" align="left"><textarea name="despatchdetail" cols="24" rows="5" class="formText135" id="despatchdetail"><%=description%></textarea></td>
							</tr>
							
							<tr>
								<td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td colspan="2" align="left">
							  	<input name="filename" type="hidden" value="SSpareIsssueitemproduct" /> 
								<input name="actionS" type="hidden" value="INVSpareissueitemproductedit" />
								<input id="id" name="id" type="hidden" value="<%=idissue%>" />
								<input id="oldserialno" name="oldserialno" type="hidden" value="<%=issueserialnum%>" />
								<input id="sptype" name="sptype" type="hidden" value="<%=sparetype%>" />
								<input id="spoldqty" name="spoldqty" type="hidden" value="<%=qty%>" />
								<input id="sdemandno" name="sdemandno" type="hidden" value="<%=demandNo%>" />
								<input id="sparetype" name="sparetype" type="hidden" value="<%=sparetype%>" />
								<input id="prodid" name="prodid" type="hidden" value="<%=producttype[0][0]%>" />
							    <input name="itype" type="hidden" id="itype" value="<%=type%>"></td>
							</tr>
							<tr>
								<td height="17" colspan="3" class="boldEleven">
								<table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
									<tr>
										<td>
										<input type="submit" name="Submit"	id="submit_btn" class="buttonbold13" value="Update" />
										</td>
										<td><input name="Close" type="Button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="redirect('SSpareissueview.jsp')"></td>
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
 <script language="JavaScript">
function checkqty()
{
	var sptyp=document.getElementById('sptype').value
	if(sptyp=='C')
	{
		qty.style.visibility="Visible";
	}
	else
	{
		qty.style.visibility="hidden";
	}
}

	
	
 
function validate()
{
	if(
		checkserial()
		&& checkNull("issueDate","Enter IssueDate...")
		&& checkNullSelect("despatchthrough","Select Despatch Through...",'0')
		&& checkNull("despatchdetail","Enter Despatch Detail...")
		 
	)
		return true;
	else
		return false;
}	


 	
	
function checkserial()
{
	var sptyp=document.getElementById('sptype').value
	if(sptyp=='S')
	{
		if(checkNull("serialno","Enter Serial No..."))
			return true;
		else
			return false;
	}
	
	if(sptyp=='C')
	{
		if(checkNullSelect("qty","Select Quatity...",'0'))
			return true;
		else
			return false;
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
