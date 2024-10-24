 <%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
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
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
 <script language="javascript">



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
			alert("From date&time  == To date&time    " +msg);
			document.getElementById(ctr1).focus();
			return false;
			 
		}
		else if(time1>time2)
		{
			alert("From date&time > to date&time    " +msg);
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
	var v =document.getElementsByName("close")[0].value;  
	if("Y" == v)		
	{
		nstartdate.style.visibility="hidden";
	   	ncalltype.style.visibility="hidden";
		funnelpercent.style.visibility="hidden";
		callstatuss.style.visibility="visible";
		fdesc.style.visibility="visible";
	}
	else
	{
		nstartdate.style.visibility="visible";
	   	ncalltype.style.visibility="visible";   
		funnelpercent.style.visibility="visible";    
		callstatuss.style.visibility="hidden";
		fdesc.style.visibility="hidden";
	}
}

function Validate()
{
	try
	{
 		  if( 
		   
			checkNullSelect( "customer","Select customer" ,'0')
			&& checkNullSelect( "calltype","Select calltype" ,'0')
			&& checkNull( "fromdate","Enter starting date" )
			&& checkNull( "todate","Enter ending date" )
			//&& checkReschedule()
			&& dateComparision('fromdate','todate','Please check the starting date and ending date') 
			&& checkNull( "desc","Enter Description" )
			&& quotationCheck()
			&& checkNull( "opportunityvalue","Enter opportunity value  " )
			&& checkNull( "close","Please select Call status" )
			&& checksfadateOnly()
			&& checkwinlost()
		)
		{
		    var sval=document.getElementsByName("close");
			for (var x = 0; x < sval.length; x++) 
			{
		  		if (sval[x].checked) 
				{
					if(sval[x].value != "Y")
					{
						if(checkNull("nfromdate","Select from date ","") && checkNull('ntodate','Enter to date'))
							return true;
						else
							return false;
					}		 	
				}
		 	}
	}
	else
		return false;		
	}
	catch(err)
	{
		alert(err);
		return false;
	}
 } 	
 
 
  function checksfadateOnly()
 {
	 try
	 {
	 	var v =document.getElementsByName("close")[0].value;  
		if("N" == v)
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
	 catch(err)
	 {
		 alert(err)
		 return false;
	 }
 }
 
 
 
 
 
 
 
 
 
 
 
  function checksfadate()
 {
	 	var v =document.getElementsByName("close")[0].value;  
		if("N" == v)
		{
			if( 
				checkNull("nfromdate","Enter from date ") 
				&& checkNull('ntodate','Enter to date')
				&& dateComparision('todate','nfromdate','Please check the Ending Date and Follows Date From ') 
				&& dateComparision('nfromdate','ntodate','Please check the Follows Date From and Follows Date To') 
				&& checkNull('newcalltype','Select new call type')
				
				)
						return true;
					else
						return false;
		}
		else
			return true;
		
 }
 
 
 function quotationCheck()
 {
	 try
	 {
 
		 if(document.getElementsByName("funnel").checked)
		 {
			 if(checkNull("quotationnumber","Enter quotation number ") && checkQuotationLength() )
			 	return true;
			else
				return false;
		 }
		 else
		 	return true;
	 }
	 catch(err)
	 {
		 alert(err);
		 return false;
	 }
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
<style type="text/css">
@import url("../JavaScript/SmartStyles.css");
</style>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
 
<script type="text/javascript" src="../JavaScript/Jdateandtime/js/jquery-1.7.1.js"></script>
<script type="text/javascript" src="../JavaScript/Jdateandtime/js/jquery.ui.core.js"></script>
<script type="text/javascript" src="../JavaScript/Jdateandtime/js/jquery.ui.widget.js"></script>
<script type="text/javascript" src="../JavaScript/Jdateandtime/js/jquery.ui.datepicker.js"></script>
<script type="text/javascript" src="../JavaScript/Jdateandtime/jsDateTimePickerV1/DateTimePicker.js"></script>

<link type="text/css" href="../JavaScript/Jdateandtime/css/jquery.ui.theme.css" rel="stylesheet" />
<link type="text/css" href="../JavaScript/Jdateandtime/css/jquery.ui.datepicker.css" rel="stylesheet" />
<link type="text/css" href="../JavaScript/Jdateandtime/css/demos.css" rel="stylesheet" />
	

</head>



<script type="text/javascript">
function lookupbefore(othersid) 
{
		var type = document.getElementById('funnel').checked;
		if( type && checkNull('customer','Enter the customer'))
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
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table class="BackGround" cellspacing="0" cellpadding="0" width="600"
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
				  <td width="600">
				   
		 
				  <table width="100%" border="0" align="center" cellpadding="3" cellspacing="3">
                    <tr>
                      <td colspan="4" class="bold1"><div align="center">DAILY CALLS
                        <%
							String id="",Name="",actionS="",value="",dt="";
							String from="";
							String to="";
							String customerid="0";
							String customername="";
							String active="";
							String sql="",sql1="",sql2="";
							String calltype="";
							String desc ="";
							String status="";
							String nextcall ="";
							String Nfrom = "";
							String Nto = "";
							String dbvalue = "";
							String type="";
							String callvalue="";
							String department="";
							String cperson="";
							String quotationnumber="";
							String transactionid="";
							String winorlost="";
							String percentage="";
							String designination="";
							int rowid=0,previousrowid=0;
								id=request.getParameter("id");
								sql = "SELECT a.INT_CALLID,a.INT_CUSTOMERID,d.CHR_NAME,c.INT_CALLTYPEID,a.CHR_DESC,DATE_FORMAT(a.DAT_START,'%d-%m-%Y %H:%i:%s'),DATE_FORMAT(a.DAT_END,'%d-%m-%Y %H:%i:%s'), a.CHR_STATUS,DOU_VALUE,a.CHR_ADDEDTO_FUNNEL,a.CHR_DEPARTMENT,a.CHR_CONTACTPERSON,a.CHR_QUOTATION, a.CHR_TRANSACTIONID,a.CHR_WINLOST,a.INT_PERCENTAGE,a.CHR_DESIGINATION,a.CHR_RESCHEDULE,MKT_FUN_GET_DAILYCALLS_PREVIOUS_DATE(a.INT_CALLID,a.INT_REFID)  FROM mkt_t_daillycalls a,mkt_m_customerinfo b,mkt_k_calltype c,mkt_m_customername d WHERE a.INT_CUSTOMERID=b.INT_CUSTOMERID AND a.CHR_CALLTYPE=c.INT_CALLTYPEID AND b.INT_CUSTOMERNAMEID =d.INT_CUSTOMERNAMEID AND a.INT_CALLID= "+id;
 							//out.println(sql);	
								 
								String data[][]=CommonFunctions.QueryExecute(sql);
								if(data.length>0)
									for(int i=0;i<15;i++)
										if("-".equals(data[0][i]))
											data[0][i] ="";
								id=data[0][0];
								customerid=data[0][1];
								customername=data[0][2];
								calltype=data[0][3];
								desc=data[0][4];
								Nfrom=data[0][5];
								Nto=data[0][6];
								status= data[0][7];
								callvalue=data[0][8];
								department=data[0][10];
								cperson=data[0][11];
								quotationnumber=data[0][12];
								transactionid=data[0][13];
								winorlost=data[0][14];
								percentage=data[0][15];
								designination=data[0][16];
								actionS="MKTScheduleEntryEdit";
								value="Update";
						%>
                          <span class="boldEleven">
                          <input type="hidden" name="filename" value="DaillyCalls" />
                          <input type="hidden" name="actionS"  value="MKTDaillyCallsEdit" />
                          <input name="id" type="hidden" id="id" value="<%=id%>">
						  <input name="customer" type="hidden" id="customer" value="<%=customerid%>">
                          <input name="transactionid" type="hidden" id="transactionid" value="<%=transactionid%>">
                          
                          </span></div></td>
                    </tr>
                    <tr>
                      <td class="boldEleven">Customer<span class="spc"> *</span></td>
                      <td colspan="3" class=""><%=customername%> </td>
                    </tr>
                    
					
					<tr>
                      <td width="26%" class="boldEleven"> Call Type<span class="spc"> *</span></td>
                      <td colspan="3" class="boldEleven"> 
					  <select name="calltype" class="formText135" id="calltype" style="width:250">
						<option value="0">Select CallType</option>
						<%
							String ctdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_CALLTYPEID,CHR_CALLTYPE FROM mkt_k_calltype ORDER BY CHR_CALLTYPE");
							if(ctdata.length>0)
							for(int u=0;u<ctdata.length;u++)
							out.println("<option value='"+ctdata[u][0]+"'>"+ctdata[u][1]+"</option>");
						%>
						</select> <script language="javascript">setOptionValue('calltype','<%=calltype%>')</script>						</td>
                    </tr>
					<tr>
					  <td class="boldEleven">Department <span class="spc"> *</span></td>
					  <td colspan="3" class="boldEleven"><input name="department" type="text" class="formText135" id="department" value="<%=department%>" size="33" maxlength="100"></td>
				    </tr>
					<tr>
					  <td class="boldEleven">Desigination <span class="spc"> *</span></td>
					  <td colspan="3" class="boldEleven"><input name="designination" type="text" class="formText135" id="designination" value="<%=designination%>" size="33" maxlength="100"></td>
				    </tr>
					<tr>
					  <td class="boldEleven">Contact Person <span class="spc"> *</span></td>
					  <td colspan="3" class="boldEleven"><input name="cperson" type="text" class="formText135" id="cperson" onBlur="upperMe(this)" value="<%=cperson%>" size="33" maxlength="50"   ></td>
				    </tr>
					<tr>
					  <td align="left" valign="top" class="boldEleven">Previous Call Description</td>
					  <td colspan="3" align="left" valign="top" class="boldEleven"><%=desc%></td>
				    </tr>
					
					
                    <tr>
                      <td class="boldEleven">Starting Date<span class="spc"> *</span></td>
                      <td width="56%" class="boldEleven"><input name="fromdate" type="text" class="formText135"  style="width:250px;" id="fromdate" value="<%=Nfrom%>" size="33"  readonly /></td>
                      <td width="5%" class="boldEleven"><input <%=("Y".equals(data[0][17]))? " checked='checked' ":" "%> name="reschedule" type="checkbox" id="reschedule" value="Y"  onClick="checkReschedule()"> </td>
                      <td width="13%" class="boldEleven">Reschedule</td>
                    </tr>
                    <tr>
                      <td class="boldEleven">Ending Date<span class="spc"> *</span></td>
                      <td colspan="3" class="boldEleven"><input name="todate" style="width:250px;"  type="text" class="formText135" id="todate" value="<%=Nto%>" size="33" readonly />
										 
					
					 
 <script language="javascript">
setCurrentDateandTime('todate');


	$(function() 
	{
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
 

 <%//=data[0][18]%>
 
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
</script>					  </td>
                    </tr>
                     
                     
                     <tr>
                      <td width="26%" align="left" valign="top" class="boldEleven">Current call Description<span class="spc"> *</span></td>
                      <td colspan="3" align="left" valign="top" class="boldEleven"><textarea name="desc" cols="33" rows="5" class="formText135"
									id="desc"></textarea></td>
                    </tr>
                     
                    <tr>
                      <td class="boldEleven">&nbsp;</td>
                      <td colspan="3" class="boldEleven">
                      
                      <input type="hidden" name="funnel" id="funnel" value="<%=data[0][9]%>">
                      <input type="hidden" name="quotationnumber" id="quotationnumber" value="<%=quotationnumber%>">
                      <input type="hidden" name="opportunityvalue" id="opportunityvalue" value="<%=callvalue%>">
                      </td>
                    </tr>
                    
                    
                    
                  <!--  <tr>
                      <td class="boldEleven">Added to funnel </td>
                      <td colspan="3" class="boldEleven">
                      
                      
                      
                      <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td width="7%"><input <%=("Y".equals(data[0][9]))? " checked='checked' ":" "%> name="funnel" type="checkbox" id="funnel" value="Y"  onClick="qutoationCheck()">
                             </td>
                            <td width="64%" id="quotationid">
                             
                            <input name="quotationnumber" type="text" class="formText135" id="quotationnumber" size="30" maxlength="30"  onBlur="fill();"   onkeyup="upperMe(this),lookupbefore(this.value);" value="<%=quotationnumber%>" >
                <div class="suggestionsBox" id="suggestions" style="display: none;">
					<div class="suggestionList" id="autoSuggestionsList" style="OVERFLOW:auto;width:100%;height:100px" ></div>
				 </div>
                            </td>
                            <td width="29%" class="boldEleven" id="quotationid"><input type="checkbox" name="quotereassign" id="quotereassign" checked onClick="assignQuote()">
                            <input type="hidden" name="quoteoldnumber" id="quoteoldnumber" value="<%=quotationnumber%>" > Same Quote
                            <script language="javascript">
							function assignQuote()
							{
								try
								{
									 
									if(document.getElementById('quotereassign').checked)
										document.getElementById('quotationnumber').value = document.getElementById('quoteoldnumber').value;
									else
										document.getElementById('quotationnumber').value = "";
								}
								catch(err)
								{
									
								}
							}
							
							</script>
                            </td>
                            
                          </tr>
                      </table>
                      
                      </td>
                    </tr>
                    <tr>
                      <td class="boldEleven"> Opportunity Value <span class="spc"> *</span></td>
                      <td colspan="3" class="boldEleven"><input name="opportunityvalue" type="text" class="formText135" id="opportunityvalue"  onKeyPress="return numeric_only(event,'opportunityvalue','25')" value="<%=callvalue%>" size="33" maxlength="10" readonly></td>
                    </tr>
                     -->
                     
                     
                     
                     
                     
					<tr>
                      <td width="26%" class="boldEleven"> Call Closed <span class="spc"> *</span></td>
					  
					   <td colspan="3">
					   <%
					   		String grd="";
							String grd1="";
									
									if("Y".equals(status.trim()))
										grd ="checked='checked'";
							
									if("N".equals(status.trim()))
										grd1 ="checked='checked'";
					 %>											
					    
					   <select name="close" id="close"  class="formText135" onChange="changeState()" style="width:250">
                        <option value="" selected>Select Close</option>
                        <option value="Y">Yes</option>
                        <option value="N">No</option>
				       </select>                       </td>
                    </tr>
					
				<%	
				//if ("N".equals(status))
				//	{ %>
					
					 <tr id ='callstatuss' >
					   <td class="boldEleven" >Call Status</td>
					   <td colspan="3" class="boldEleven"><label for="callstatus"></label>
					     <select name="winlost" class="formText135" id="winlost" style="width:250">
                          <option value="N" selected>normal</option>
                        	<option value="W">Won</option>
                       	 <option value="L">Lost</option> 
			           </select></td>
				    </tr>
                    <tr id="fdesc" style="visibility:hidden" >
                    <td class="boldEleven">WON / LOST  Description</td>
                    <td class="boldEleven" colspan="3"><textarea name="finaldescription" cols="33" rows="5" class="formText135" >&nbsp;</textarea></td>
                    </tr>
                    
					 <tr id="nstartdate" style="visibility:hidden">
                      <td class="boldEleven" >Follows Date From<span class="spc"> *</span></td>
                      <td colspan="3" class="boldEleven">
					  <input name="nfromdate" type="text" class="formText135" id="nfromdate" value="" size="33" readonly style="width:250px;"  /> 
<script language="javascript">setCurrentDateandTime('nfromdate');</script>

<script language="javascript">


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
                   
                     
                     <tr id="ncalltype" style="visibility:hidden">
                       <td class="boldEleven" > New Call Type<span class="spc"> *</span></td>
                       <td colspan="3" class="boldEleven">
                       <select name="newcalltype" class="formText135" id="newcalltype" style="width:250">
                          
                         <%
							if(ctdata.length>0)
								for(int u=0;u<ctdata.length;u++)
									out.println("<option value='"+ctdata[u][0]+"'>"+ctdata[u][1]+"</option>");
						%>
                       </select>
                       <script language="javascript">setOptionValue('newcalltype','<%=calltype%>')</script>                       </td>
                    </tr>
                    
                      <tr id="funnelpercent" style="visibility:hidden">
                       <td class="boldEleven" >Call ( %<span class="spc">) </span></td>
                       <td colspan="3" class="boldEleven">
                       <select name="funnelpercentage" class="formText135" id="funnelpercentage" style="width:250">
                      
					   <%
                    String stagedata[][]= CommonFunctions.QueryExecute("SELECT INT_PERCENTAGE,UPPER(CHR_STAGENAME)  FROM mkt_m_stage WHERE CHR_STATUS='Y' ORDER BY INT_PERCENTAGE");
                    if(stagedata.length>0)
                    	for(int u=0;u<stagedata.length;u++)
                    		out.println("<option value='"+stagedata[u][0]+"'>"+stagedata[u][1]+" ( "+stagedata[u][0]+"% )</option>");
                %>
					   
                       </select>
                       <script language="javascript">setOptionValue('funnelpercentage','<%=percentage%>')</script>        
                        
                                           </td>
                    </tr>
                    
                    <tr>
                      <td colspan="4" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                          <tr>
                            <td><input name="Submit"  id="Submit" type="submit" class="buttonbold13" value="Update" ></td>
                            <td><input name="Close" type="button" class="buttonbold13" id="Close"  value="Close"   accesskey="c"  onClick="redirect('DaillyCalls.jsp')"></td>
                          </tr>
                      </table></td>
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
	</tr>
	<tr>
		<td>&nbsp;</td>
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
  
 <%
 if(!"Y".equals(data[0][9]))
 {
 %> 
  	//quotationid.style.visibility="hidden";
<%
 }
%>	




 function checkReschedule()
 {
	 try
	 {
		 if(document.getElementById('reschedule').checked)
		{
			
		}
		else
		{
			document.getElementById('fromdate').value = "<%=Nfrom%>";
		}


	 }
	 catch(err)
	 {
		 alert(err);
		 return false;
	 }
 }
 
 
 function checkwinlost()
 {
	 try
	{
		var winlost = document.getElementById('winlost').value ;
		if(winlost =="W" || winlost =="L")
		{
			var funnel = document.getElementById('funnel').value;
			if(funnel =="Y")
				return true;
			else
			{
				alert("Quotation not assigned");
				return false;	
			}
		}
		else
			return true;
		
 	}
	 catch(err)
	 {
		 alert(err);
		 return false;
	 }
 }
 
</script>
<br><br><br><br><br><br>

<%@ include file="../footer.jsp"%>
</body>
</html>
<br><br><br><br><br><br>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>

