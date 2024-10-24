<%@ page contentType="text/html; charset=iso-8859-1" language="java" 	import="java.sql.*" errorPage=""%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
String sql = "";
String usertype=""+session.getAttribute("USRTYPE");	
%>
<html>
<head>
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

<title> :: MARKETING ::</title>
<script type="text/javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/Marketing/LoadCustomerAddress.js"></script>
<script language="javascript" src="../JavaScript/Marketing/LoadCustomerContactPerson.js"></script>
<script language="javascript" src="../JavaScript/Marketing/LoadQuotationRegardsCustomer.js"></script>

<script type="text/javascript" src="../JavaScript/Jdateandtime/js/jquery-1.7.1.js"></script>
<script type="text/javascript" src="../JavaScript/Jdateandtime/js/jquery.ui.core.js"></script>
<script type="text/javascript" src="../JavaScript/Jdateandtime/js/jquery.ui.widget.js"></script>
<script type="text/javascript" src="../JavaScript/Jdateandtime/js/jquery.ui.datepicker.js"></script>
<script type="text/javascript" src="../JavaScript/Jdateandtime/jsDateTimePickerV1/DateTimePicker.js"></script>

<link type="text/css" href="../JavaScript/Jdateandtime/css/jquery.ui.theme.css" rel="stylesheet" />
<link type="text/css" href="../JavaScript/Jdateandtime/css/jquery.ui.datepicker.css" rel="stylesheet" />
<link type="text/css" href="../JavaScript/Jdateandtime/css/demos.css" rel="stylesheet" />
	

<script language="javascript">

 //LoadCustomerContactPerson.js
	

	
	
	
function dateComparision(ctr,ctr1,msg) 
{
	try
	{
		var f1 =  document.getElementById(ctr).value;
		var f2  = document.getElementById(ctr1).value;
		var t1=f1.split(" ");
	  	var t2=f2.split(" ");
	  	f1 = t1[0].split("-")[2]+"-"+t1[0].split("-")[1]+"-"+t1[0].split("-")[0]+" "+t1[1];
		f2 = t2[0].split("-")[2]+"-"+t2[0].split("-")[1]+"-"+t2[0].split("-")[0]+" "+t2[1];
			
		var time1 = new Date(f1.replace(/\-/g,'\/').replace(/[T|Z]/g,' '));
		var time2  = new Date(f2.replace(/\-/g,'\/').replace(/[T|Z]/g,' '));
		 
		if(time1<time2)
		{
			 
			return true; 
		}
		else if(time1.getTime()==time2.getTime())	
		{
			alert("From date&time  and To date&time should not be equals");
			document.getElementById(ctr1).focus();
			return false;
			 
		}
		else if(time1>time2)
		{
			alert("From date&time should be lesser than the to date&time");
			document.getElementById(ctr1).focus();
			return false;
		}
		  
	}
	catch(err)
	{
		alert(err);
		return false;
	}

}

 



 function changeState()
{
	var v =document.getElementsByName("Follows")[0].value;  
	if("Y" == v)		
	{
		nstartdate.style.visibility="visible";
	   	//nenddate.style.visibility="visible"; 
	   	ncalltype.style.visibility="visible"; 
		
		
	}
	else
	{
		nstartdate.style.visibility="hidden";
	   	//nenddate.style.visibility="hidden";
	   	ncalltype.style.visibility="hidden";
	}
}
 
function Validate()
  {
	
	if( 
	   
	    checkNullSelect( "customername","Select customername" ,'0')
		&& checkNullSelect( "customer","Select customer" ,'0')
		&& checkNullSelect( "calltype","Select calltype" ,'0')
		&& checkNull( "department","Enter department" )
		&& checkNull( "designination","Enter designination" )
		
		&& checkNull( "cperson","Enter contac person" )
		&& checkNull( "fromdate","Enter starting date" )
		&& checkNull( "todate","Enter ending date" )
		&& checkDateTimes("fromdate","Check starting date")
		&& checkDateTimes("todate","Check  ending date")
		&& dateComparision('fromdate','todate','Please check the starting date and ending date') 
		&& checkNull( "desc","Enter Description" )
		&& funnelCheck()
		&& checkNullSelect( "funnelpercentage","Select Call %" ,'')
		 
		&& checkNull( "opportunityvalue","Enter opportunity value  " )
		&& checkNullSelect( "Follows","Select Follows" ,'0')
		&& checksfadateOnly()
		
	) 
	{	 
		var rs = confirm("Confirm, All informations are correct");
		if (rs == true)
			return true;	
		else
			return false;	
	}
	else
		return false;		
 } 	
 
 
 
 function funnelCheck()
 {
	 try
	 {
		 	if(document.getElementById('funnel').checked)
			{
				if(checkNull( "quotationnumber","Enter quotation number" ) && checkQuotationLength() && checkNull( "opportunityvalue","Enter opportunity value  " ) )
				{
					var v = parseFloat(document.getElementById('opportunityvalue').value);
					if(v>0)
						return true;
					else
					{
							alert("Opportunity value should not be zero");
							return false;
					}
				}
				else
					return false;
			}
			else
			{
				document.getElementById('opportunityvalue').value=0;
				return true;
			}
	 }
	 catch(err)
	 {
		 alert(err.description);
		 return false;
	 }
 }
 
 function checksfadateOnly()
 {
	 	var v =document.getElementsByName("Follows")[0].value;  
		if("Y" == v)
		{
			if( checkNull("nfromdate","Enter from date ") 
				&& dateComparision('todate','nfromdate','Please check the Ending Date and Follows Date From ') 
				&& checkNullSelect('newcalltype','Select new call type','0')
				
				)
						return true;
					else
						return false;
		}
		else
			return true;
		
 }
 
 
  function checksfadate()
 {
	 	var v =document.getElementsByName("Follows")[0].value;  
		if("Y" == v)
		{
			if( checkNull("nfromdate","Enter from date ") 
				&& checkNull('ntodate','Enter to date')
				&& checkDateTimes("nfromdate","check Follows Date From ")
				&& checkDateTimes("ntodate","check Follows Date To")
		
				&& dateComparision('todate','nfromdate','Please check the Ending Date and Follows Date From ') 
				&& dateComparision('nfromdate','ntodate','Please check the Follows Date From and Follows Date To') 
				&& checkNullSelect('newcalltype','Select new call type','0')
				
				)
						return true;
					else
						return false;
		}
		else
			return true;
		
 }
 
 
 
 function checkQuotationLength()
 {
	 try
	 {
		 var quotationnumber = document.getElementById('quotationnumber').value;
		 if(quotationnumber.length >=8)
		 {
			 return true;
		 }
		 else
		 {
			 alert("Check the quotation number  ");
			 return false;
		 }
	

	 }
	 catch(err)
	 {
		 alert(err);
		 return false;
	 }
 }
</script>

 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
 <style type="text/css">
@import url("../JavaScript/SmartStyles.css");
</style>
</head>




<script type="text/javascript">
function lookupbefore(othersid) 
{
		var type = document.getElementById('funnel').checked;
		if( type && checkNullSelect('customer','Select the customer','0'))
		{
			lookup(othersid) 
		}
}

function lookup(othersid) 
{
	try
	{
		
			if(othersid.length == 0) 
			{
				$('#suggestions').hide();
			} 
			else 
			{
				var customer = document.getElementById('customer').value;
				
				$.post("getQuotationNumber.jsp?customer="+customer , {queryString: ""+othersid}, function(data)
				{
					if(data.length >0) 
					{
						$('#suggestions').show();
						$('#autoSuggestionsList').html(data);
					}
				});
			}
		 
	}
	catch(err)
	{
		alert(err);
	}
}
function fill(thisValue) 
{
	var type = document.getElementById('funnel').checked;
	if( type)
	{		
		var v = thisValue.split(",");
		document.getElementById('quotationnumber').value=v[0];
		document.getElementById('opportunityvalue').value=v[1];
		//$('#quotationnumber').val(thisValue);
		//$('#suggestions').hide();
		setTimeout("$('#suggestions').hide();", 1000);
	}
}
</script>
<style type="text/css">
@import url("../JavaScript/SmartStyles.css");

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


<body onselectstart="return false" onpaste="return false;" onCopy="return false"    >
<%@ include file="index.jsp"%>

<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm" onSubmit="return Validate()">  
 <table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
        <%
String msg = ""+request.getParameter("msg");
if(!"null".equals(msg))
{
%>
<script language="javascript">
	var rs=confirm("Your call informations are <%=msg%>, You want to add one more call...");
	if (rs==true)
		location = 'DaillyCallsAdd.jsp'; 
	else	
		location = 'DaillyCalls.jsp'; 
</script>
<%
}
%>        </td>
	</tr>
	
	<tr>
		<td>
		<table class="BackGround" cellspacing="0" cellpadding="0" width="500"
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
				  <td  >
				   
		 
				  <table width="100%" border="0" align="center" cellpadding="3" cellspacing="3">
                    <tr>
                      <td colspan="2" class="bold1"><div align="center">DAILY CALLS
                      
                     
                        <span class="boldEleven">
                          <input type="hidden" name="filename" value="DaillyCalls" />
                          <input type="hidden" name="actionS"  value="MKTDaillyCallsAdd" />
                          </span></div></td>
                    </tr>
                    <tr>
                      <td class="boldEleven">Customer Name</td>
                      <td class="boldEleven">
                      <select name="customername" class="formText135" id="customername"  style="width:250" autofocus onChange="LoadCustomerAddress()">
                      <option value="0">Select Customer Name</option>
                      <%
					  
sql = " SELECT b.INT_CUSTOMERNAMEID,b.CHR_NAME  FROM mkt_m_customerinfo a, mkt_m_customername b  ";
sql = sql + " WHERE a.INT_CUSTOMERNAMEID = b.INT_CUSTOMERNAMEID  ";//AND  a.CHR_VERIFY='Y' 
if("A".equals(usertype) || "S".equals(usertype))
	sql = sql + " AND a.CHR_HOLDER='"+session.getAttribute("EMPID")+"' ";
sql = sql + "GROUP BY b.INT_CUSTOMERNAMEID ORDER BY b.CHR_NAME ";
String cdata[][]= CommonFunctions.QueryExecute(sql); //
if(cdata.length>0)
for(int u=0;u<cdata.length;u++)
	out.println("<option value='"+cdata[u][0]+"'>"+cdata[u][1] +"</option>"); 
%>
                     
                      </select></td>
                    </tr>
                    <tr>
                      <td class="boldEleven">Customer Branch<span class="spc"> *</span></td>
                      <td class="boldEleven">
<select name="customer" class="formText135" id="customer" style="width:250" onChange="LoadCustomerContactPerson()">
<option value="0">Select Customer</option>
<%
/*String cdata[][]= CommonFunctions.QueryExecute("SELECT a.INT_CUSTOMERID,b.CHR_NAME, a.CHR_ADDRESS1,c.CHR_CITYNAME  FROM mkt_m_customerinfo a, mkt_m_customername b  ,com_m_city c WHERE a.INT_CUSTOMERNAMEID =b.INT_CUSTOMERNAMEID AND   a.INT_CITYID =c.INT_CITYID AND  a.CHR_VERIFY='Y'    ORDER BY b.CHR_NAME"); // onBlur="LoadQuotationRegardsCustomer()"  
if(cdata.length>0)
for(int u=0;u<cdata.length;u++)
	out.println("<option value='"+cdata[u][0]+"'>"+cdata[u][1]+" / "+cdata[u][2]+ " @ "+cdata[u][3]+"</option>");*/
%>
</select>                </td>
                    </tr>
                    
					
					<tr>
                      <td width="35%" class="boldEleven">Call Type<span class="spc"> *</span></td>
                      <td width="65%" class="boldEleven">
                       <select name="calltype" class="formText135" id="calltype"  style="width:250">
						<option value="0">Select CallType</option>
						<%
							String ctdata[][]=CommonFunctions.QueryExecute("SELECT INT_CALLTYPEID,CHR_CALLTYPE FROM mkt_k_calltype ORDER BY CHR_CALLTYPE");
							if(ctdata.length>0)
							for(int u=0;u<ctdata.length;u++)
							out.println("<option value='"+ctdata[u][0]+"'>"+ctdata[u][1]+"</option>");
						%>
						</select>                      </td>
                    </tr>
					
					 <tr>
					   <td class="boldEleven">Department <span class="spc"> *</span></td>
					   <td class="boldEleven"><input name="department" type="text" class="formText135" id="department" size="33" maxlength="100"></td>
				    </tr>
					 <tr>
					   <td class="boldEleven">Desigination <span class="spc"> *</span></td>
					   <td class="boldEleven"><input name="designination" type="text" class="formText135" id="designination" size="33" maxlength="100"></td>
				    </tr>
					 <tr>
					   <td class="boldEleven">Contact Person <span class="spc"> *</span></td>
					   <td class="boldEleven"><input name="cperson" type="text" class="formText135" id="cperson" size="33" maxlength="50" onBlur="upperMe(this)"   ></td>
				    </tr>
					 <tr>
                      <td class="boldEleven">Starting Date<span class="spc"> *</span></td>
                      <td class="boldEleven"><input name="fromdate" type="text" class="formText135" id="fromdate"  style="width:250px;" value="" size="33" readonly/>					              </td>
                    </tr>
                    <tr>
                      <td class="boldEleven">Ending Date<span class="spc"> *</span></td>
                      <td class="boldEleven"><input name="todate" type="text" class="formText135" id="todate"  style="width:250px;" value="" size="33"  readonly />
                      <script language="javascript">
					  setCurrentDateandTime('fromdate');
					  setCurrentDateandTime('todate');
					  </script>
					  
						 
<script language="javascript">
 

$(function() {
	$( "#fromdate" ).datetimepicker({
		
		showSecond: true,
		timeFormat: 'hh:mm:ss',
		stepHour: 1,
		stepMinute: 1,
		stepSecond: 10,
		changeMonth: true,
		changeYear: true,
		showOn: "button",
		buttonImage: "../JavaScript/jquery/images/calendar.gif",
		buttonImageOnly: true,
		minDate: -7, maxDate: "+60D"  
	});
}); 

 
 

$(function() {
	$( "#todate" ).datetimepicker({
		
		showSecond: true,
		timeFormat: 'hh:mm:ss',
		stepHour: 1,
		stepMinute: 1,
		stepSecond: 10,
		changeMonth: true,
		changeYear: true,
		showOn: "button",
		buttonImage: "../JavaScript/jquery/images/calendar.gif",
		buttonImageOnly: true,
		minDate: -7, maxDate: "+60D"  
	});
}); 

 

$(function() {
	$( "#nfromdate" ).datetimepicker({
		
		showSecond: true,
		timeFormat: 'hh:mm:ss',
		stepHour: 1,
		stepMinute: 1,
		stepSecond: 10,
		changeMonth: true,
		changeYear: true,
		showOn: "button",
		buttonImage: "../JavaScript/jquery/images/calendar.gif",
		buttonImageOnly: true,
		minDate: -7, maxDate: "+60D"  
	});
}); 

</script>					  </td>
                    </tr>
					<tr>
                      <td width="35%" align="left" valign="top" class="boldEleven">Description<span class="spc"> *</span></td>
                      <td width="65%" align="left" valign="top" class="boldEleven"><textarea name="desc" cols="32" rows="3" class="formText135"
									id="desc" ></textarea>                      </td>
                    </tr>
					
                   
                     
                    <tr>
                      <td class="boldEleven">&nbsp;</td>
                      <td class="boldEleven"><input type="hidden" name="funnel" id="funnel" value="N">
                      <input type="hidden" name="quotationnumber" id="quotationnumber" value="">
                      <input type="hidden" name="opportunityvalue" id="opportunityvalue" value="0">
                      <input type="hidden" name="funnelpercentage" id="funnelpercentage" value="1">
                      </td>
                    </tr>
                    
                    
                   <!-- <tr>
                      <td class="boldEleven">Added to funnel </td>
                      <td class="boldEleven">
                        <table width="302" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td><input name="funnel" type="checkbox" id="funnel" value="Y" onClick="qutoationCheck()" >
                             </td>
                            <td id="quotationid">
                            
                            <input name="quotationnumber" type="text" class="formText135" id="quotationnumber" size="30" maxlength="30"  onBlur="fill();"   onkeyup="upperMe(this),lookupbefore(this.value);" value="" >
                <div class="suggestionsBox" id="suggestions" style="display: none;">
					<div class="suggestionList" id="autoSuggestionsList" style="OVERFLOW:auto;width:100%;height:100px" ></div>
				 </div>
                            </td>
                            
                          </tr>
                      </table></td>
                    </tr>
                   
                    <tr>
                      <td class="boldEleven"> Opportunity Value <span class="spc"> *</span> </td>
                      <td class="boldEleven"><input name="opportunityvalue" type="text" class="formText135" id="opportunityvalue"  onKeyPress="return numeric_only(event,'opportunityvalue','25')" value="0" size="33" maxlength="10" readonly='readonly' ></td>
                    </tr>
                    
                     
                    
                     <tr>
                      <td class="boldEleven">Call ( % )<span class="spc">*</span></td>
                      <td class="boldEleven"><select name="funnelpercentage" class="formText135" id="funnelpercentage" style="width:250">
                        <option value="">Select Call % </option>
						<%
                    String stagedata[][]= CommonFunctions.QueryExecute("SELECT INT_PERCENTAGE,UPPER(CHR_STAGENAME)  FROM mkt_m_stage WHERE CHR_STATUS='Y' ORDER BY INT_PERCENTAGE");
                    if(stagedata.length>0)
                    	for(int u=0;u<stagedata.length;u++)
                    		out.println("<option value='"+stagedata[u][0]+"'>"+stagedata[u][1]+" ( "+stagedata[u][0]+"% )</option>");
                %>
                      </select></td>
                    </tr>
                    -->
                    
                    <tr>
                      <td class="boldEleven">Follows on<span class="spc"> *</span></td>
                      <td class="boldEleven"><select name="Follows" id="Follows"  class="formText135" onChange="changeState()" style="width:250">
                        <option value="0" selected>Select Close</option>
                          <option value="Y">Yes</option>
                          <option value="N">No</option>
                      </select></td>
                    </tr>
                    <tr id="nstartdate" style="visibility:hidden">
                      <td class="boldEleven" >Follows Date From<span class="spc"> *</span></td>
                      <td class="boldEleven"><input name="nfromdate" type="text" class="formText135" id="nfromdate" value="" style="width:250px;" readonly /> <script language="javascript">setCurrentDateandTime('nfromdate');setCurrentDateandTime('ntodate');</script></td>
                    </tr>
                   
                 
					
                     <tr id="ncalltype" style="visibility:hidden">
                       <td class="boldEleven" > New Call Type<span class="spc"> *</span></td>
                       <td class="boldEleven">
                       <select name="newcalltype" class="formText135" id="newcalltype"  style="width:250">
                        <option value="0">Select CallType</option>  
                         <%
							if(ctdata.length>0)
								for(int u=0;u<ctdata.length;u++)
									out.println("<option value='"+ctdata[u][0]+"'>"+ctdata[u][1]+"</option>");
						%>
                       </select>                       </td>
                    </tr>
                    
                    <tr>
                      <td colspan="2" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                          <tr>
                            <td><input name="Submit"  id="Submit" type="submit" class="buttonbold13"  value="Add"   accesskey="s"   ></td>
                            <td><input name="Close" type="button" class="buttonbold13" id="Close"  value="Close"   accesskey="c"  onClick="redirect('DaillyCalls.jsp')"></td>
                          </tr>
                      </table></td>
                    </tr>
                  </table>				  </td>
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
		<td height="50">&nbsp;</td>
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
		<td align="center" valign="middle">					  </td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
</form>

<script language="javascript">
function qutoationCheck()
{
	try
	{
		if(document.getElementById('funnel').checked )
		{
			quotationid.style.visibility="Visible";
		}
		else
		{
			quotationid.style.visibility="hidden";
		}
	}
	catch(err)
	{
	}
}
  
  //quotationid.style.visibility="hidden";
</script>
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