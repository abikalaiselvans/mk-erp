<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
%>
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
<!--
@import url("../JavaScript/SmartStyles.css");
-->
 </style>
 </head>
 
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>



<script language="javascript" src="../JavaScript/Inventory/Qtynovalidate.js"></script>
<script language="javascript" src="../JavaScript/Inventory/Serialnovalidate.js"></script>
<script language="javascript" src="../JavaScript/Inventory/Productcodevalidate.js"></script>
<script language="javascript" src="../JavaScript/Inventory/SpareDemandnumber.js"></script>
<script language="javascript" src="../JavaScript/Inventory/SSpareloaditemproduct.js"></script>




<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script type="text/javascript" src="../JavaScript/jquery/Time/jquery-ui.min.js"></script>
<script type="text/javascript" src="../JavaScript/jquery/Time/jquery-ui-timepicker-addon.js"></script>
<script type="text/javascript" src="../JavaScript/jquery/Time/jquery-ui-sliderAccess.js"></script>
<script language="JavaScript">
var addissuerecord = "<%= request.getParameter("addrecord")%>"
var issueidadd = "<%= request.getParameter("issueid")%>"
var demandno = "<%= request.getParameter("demandno")%>"
var issuestatus = "<%= request.getParameter("spareissuestatus")%>"

if(addissuerecord=="R"){
if( confirm("Issue number is "+issueidadd+".Do You Want to Add One More Record...") )
					location="SSpareissueadd.jsp";
				else
					location="SSparedemandupdatestatus.jsp?demand="+demandno+"&spareissuestatus="+issuestatus;
}

 		
	function validate()
	{
	if(
		checkNullSelect("demandnumber","Select Demand No...",'0')
		&& check()
		&& checkNullSelect("serialproducttype","Select Product Type...",'0')
		&& checkNullSelect("consumableproduct","Select Product Code...",'0')
		&& checkconsumableserial()
		&& checkNull("issueDate","Enter IssueDate...")
		&& checkNullSelect("despatchthrough","Select Despatch Through...",'0')
		&& checkNull("despatchdetail","Enter Despatch Detail...")
	)
		return true;
	else
		return false;
}	


function check() {
var r = document.getElementsByName("sparetype")
var c = -1

for(var i=0; i < r.length; i++){
   if(r[i].checked) {
      c = i; 
   }
}
if (c == -1){
 alert("please select SpareType");
return false;
}else{
return true;
}
}
		
		
 function checkconsumableserial(){
 var cboxes = document.getElementsByName('sparetype');
    var len = cboxes.length;
 for (i = 0; i < len; i++){
      if (cboxes[i].checked){
		 if(cboxes[i].value=='C'){
		 	if(checkNullSelect("consumableproduct","Select Consumable product code...",'0')
			 && checkNullSelect("qty","Select Quatity...",'0')
			
			)
				return true;
			else
				return false;
		 }

		if(cboxes[i].value=='S'){
		   if( checkNullSelect("serialproducttype","Select Serial product code...",'0')
		    && checkNull("serialno","Enter Serial No...")
		   )
				return true;
		 	else
				return false;
		 
 		}    
    }
 }
}

function selectof(){
	     var _targ=document.getElementsByName('qty')[0];       
	     _targ.options.length=0;
	     _targ.options[0]=new Option('Select qty','0');
		 _targ.options[1]=new Option('1','1');
		 _targ.options[2]=new Option('2','2');
		 _targ.options[3]=new Option('3','3');
		 _targ.options[4]=new Option('4','4');
		 _targ.options[5]=new Option('5','5');
		 _targ.options[6]=new Option('6','6');
		 _targ.options[7]=new Option('7','7');
		 _targ.options[8]=new Option('8','8');
		 _targ.options[9]=new Option('9','9');
		 _targ.options[10]=new Option('10','10');
		 var tb=document.getElementById('divqtyname');
  	 	tb.innerHTML="" ; 

}


function LoadSelecttypeMessages() 
{	 
	var sparetype = document.getElementsByName('sparetype');
	 var len = sparetype.length;
	 var typename = 'Product';
	 var typeid = 'P';
	 var itmproducttype=new Array("Item","Product");
	var itmproducttypeid=new Array("I","P");
	 var _targ=document.getElementsByName('serialproducttype')[0];  
    _targ.options.length=0;
    _targ.options[0]=new Option('Select','0');
	
	 
	//get value and check the spare type for consumable and product
	 for (i = 0; i < sparetype.length; i++){
		  if (sparetype[i].checked){
				 if(sparetype[i].value=='C'){
				 		quantity.style.visibility="Visible";
						Serial.style.visibility="hidden";
						_targ.options[i+1]=new Option(typename,typeid);
						var _targCon=document.getElementsByName('consumableproduct')[0];  
   					    _targCon.options.length=0;
    					_targCon.options[0]=new Option('Select','0'); 
						var tb=document.getElementById('divcodename');
  	 					tb.innerHTML="" ;
				}
				if(sparetype[i].value=='S'){
					 quantity.style.visibility="hidden";
					 Serial.style.visibility="Visible";
					  var tb=document.getElementById('divcodename');
  	 				  tb.innerHTML="" ; 
					   var _targ=document.getElementsByName('serialproducttype')[0];  
   					   _targ.options.length=0;
    				   _targ.options[0]=new Option('Select','0'); 
					   
					for(loop = 0; loop < itmproducttype.length; loop++) 
						{	
						typename=itmproducttype[loop];
						typeid=itmproducttypeid[loop];
						_targ.options[loop+1]=new Option(typename,typeid);
					} 
					
					var _targ1=document.getElementsByName('consumableproduct')[0];  
   					   _targ1.options.length=0;
    				   _targ1.options[0]=new Option('Select','0');  
				}   
		}
 }
}
</script>
<body  onLoad="LoadSelecttypeMessages()">
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
									class="boldThirteen">SPARE ISSUE </td>
							</tr>
							<tr>
								<td height="19" colspan="3" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">
								Mandatory </span></td>
							</tr>
							<tr>
								<td width="172" height="17" class="boldEleven">
								Demand Number <span class="bolddeepred">* </span></td>
								<td colspan="2" align="left"> 
<select name="demandnumber" id="demandnumber" style="width: 150" class="formText135"  onChange="Assignsparedemanddetail(this)">
<option value="0">Select</option>
	<%
		String sql="SELECT INT_DEMANID,CHR_DEMANDNO FROM inv_ss_sparedemand WHERE CHR_ISSUED!='Y'  AND  INT_BRANCHID ="+session.getAttribute("INVBRANCH") ;
		sql = sql +" ORDER BY CHR_DEMANDNO";
		String demandnodata[][] = CommonFunctions.QueryExecute(sql);
		for(int u=0;u<demandnodata.length;u++)
			out.println("<option value="+demandnodata[u][0]+">"+demandnodata[u][1]+"</option>");
 %>
</select></td>
							</tr>
							<tr>
							  <td height="17" colspan="3" class="boldEleven"><div id="AssignsparedemandDiv"  style="OVERFLOW:auto;width:100%;height:auto" class="boldEleven"></div></td>
						  </tr>
							<tr>
<td height="17" class="boldEleven">Spare Type <span class="bolddeepred">* </span></td>
							  <td colspan="2" align="left">
		
		<table width="100" border="0" cellpadding="0" cellspacing="0" class="boldEleven">
  <tr>
    <td class="boldEleven"><input name="sparetype"  id="radio" type="radio" value="C"  class="formText135" onClick="LoadSelecttypeMessages()" /></td>
    <td class="boldEleven">Consumable</td>
    <td class="boldEleven"><input name="sparetype"  id="sparetype" type="radio" value="S" class="formText135" onClick="LoadSelecttypeMessages()" /></td>
    <td class="boldEleven">Serial</td>
  </tr>
</table>

		</td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Product Type<span
									class="bolddeepred"> * </span></td>
							    <td colspan="2" align="left">
								<select class="formText135" name="serialproducttype" id ="serialproducttype" onChange="Loaditemproductdetail()" style="width: 150">
								</select>
							  </td>
							</tr>
							
							<tr id="consumable">
								<td height="17" class="boldEleven">Product Code <span
									class="bolddeepred">* </span> </td>
							  <td colspan="2" align="left">
								<select name="consumableproduct" class="formText135" id="consumableproduct"  tabindex="1" onChange="validproductcode(this.value)" style="width: 150">
                    				<option value="0">Select</option>
                    				
               				    </select>
								<div id='divcodename'></div>
							  </td>
							</tr>
							<tr id="quantity">
								<td height="17" class="boldEleven">Qty<span
									class="bolddeepred"> * </span></td>
								<td colspan="2" align="left">
								<select name="qty" id="qty" style="width: 150" class="formText135" onChange="validQtyno(this.value)">
									
								</select>
								<div id='divqtyname' style="width:200"></div>
								</td>
							</tr>
							
							<tr id="Serial">
								<td height="17" class="boldEleven">Serial Number <span class="bolddeepred">* </span></td>
								<td colspan="2" align="left">
					<!--			<input name="serialno" type="text" class="formText135" id="serialno" onKeyUp="validserialno(this.value)" size="27" maxlength="30" >
								<div id='divunitname'></div>
					-->			
					
					
<script type="text/javascript">
function lookup(serialNo) 
{
	if(serialNo.length == 0) 
	{
		$('#suggestions').hide();
	} 
	else 
	{
		var itype= document.getElementById('serialproducttype').value;
		var icode= document.getElementById('consumableproduct').value;
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

					
								   <input name="serialno" type="text" class="formText135" id="serialno" tabindex="2" size="27" maxlength="30" onBlur="fill();"   onkeyup=" lookup(this.value);"  >
                  <br>
                  <div class="suggestionsBox" id="suggestions" style="display: none;">
                    <div class="suggestionList" id="autoSuggestionsList" style="OVERFLOW:auto;width:100%;height:100px" ></div>
                    </div> 
					
					
								</td>
							</tr>
							<tr>
							  <td height="17" class="boldEleven">Spare Issuedate <span class="bolddeepred">* </span></td>
							  <td colspan="2" align="left"><input name="issueDate"
									type="text" class="formText135" id="issueDate" size="27"
									onKeyPress="dateOnly(this)" readonly="readonly"/>
                                <script language="javascript">
								setCurrentDateandTime('issueDate');
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
				</script>			</td>
						  </tr>
							<tr>
								<td height="17" class="boldEleven">Spare Issue <span class="bolddeepred">* </span></td>
							  <td colspan="2" align="left">
								<table width="152" border="0" cellpadding="0" cellspacing="0" class="boldEleven">
  <tr>
    <td class="boldEleven"><input name="spareissue"  id="radio2" type="radio" value="Y" checked="checked" class="formText135" /></td>
    <td class="boldEleven">Issue</td>
    <td class="boldEleven"><input name="spareissue"  id="spareissue" type="radio" value="N" class="formText135" /></td>
    <td class="boldEleven">Not Issue</td>
  </tr>
</table>

								
  							  	</td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Despatch Through <span class="bolddeepred">*</span></td>
								<td colspan="2" align="left">
									<select name="despatchthrough" id = "despatchthrough" style="width: 150">
										<option value="0">Select</option>
					  					<option value="C">Courier</option>
										<option value="P">Person</option>
										<option value="V">Vechicle </option>
									</select></td>
							</tr>
							<tr>
								<td height="17" valign="top" class="boldEleven">Despatch Details<span class="bolddeepred"> * </span>
		 					  </td>
								<td colspan="2" align="left"><textarea name="despatchdetail"
									cols="24" rows="5" class="formText135" id="despatchdetail"></textarea></td>
							</tr>
							
							<tr>
								<td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td colspan="2" align="left">
							  	<input name="filename" type="hidden" value="SSpareIsssueitemproduct" /> 
								<input name="actionS" type="hidden" value="INVSpareissueitemproductadd" />
							  </td>
							</tr>
							<tr>
								<td height="17" colspan="3" class="boldEleven">
								<table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
									<tr>
										<td>
										<input type="submit" name="Submit"	id="submit_btn" class="buttonbold13" value="Submit"   accesskey="s"    />
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
