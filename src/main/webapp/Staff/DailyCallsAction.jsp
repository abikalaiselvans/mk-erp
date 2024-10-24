 <%@ page contentType="text/html; charset=iso-8859-1" language="java" 	import="java.sql.*" errorPage=""%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
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

<title>:: STAFF ::</title>

<script type="text/javascript" src="${pageContext.request.contextPath}/JavaScript/comfunction.js"></script>

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
	   	nenddate.style.visibility="visible"; 
	   	ncalltype.style.visibility="visible"; 
		
		
	}
	else
	{
		nstartdate.style.visibility="hidden";
	   	nenddate.style.visibility="hidden";
	   	ncalltype.style.visibility="hidden";
	}
}
 
function Validate()
  {
	
	if( 
	   
	   	checkNullSelect( "customer","Select customer" ,'0')
		&& checkNull( "name","Enter Agenda" )
		&& checkNullSelect( "calltype","Select calltype" ,'0')
		&& checkNull( "fromdate","Enter starting date" )
		&& checkNull( "todate","Enter ending date" )
		&& checkDateTimes("fromdate","Check starting date")
		&& checkDateTimes("todate","Check  ending date")
		&& dateComparision('fromdate','todate','Please check the starting date and ending date') 
		&& checkNull( "desc","Enter Description" )
		&& checkNull( "opportunityvalue","Enter opportunity value  " )
		&& checkNullSelect( "Follows","Select Follows" ,'0')
		&& checksfadate()
		
	) 
		 return true;	
	 else
		return false;		
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
				&& checkNull('newcalltype','Select new call type','0')
				
				)
						return true;
					else
						return false;
		}
		else
			return true;
		
 }
</script>

 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<link href="../JavaScript/jquery/Time/jquery-ui.css" rel="stylesheet" type="text/css">
<link href="../JavaScript/jquery/Time/jquery-ui-timepicker-addon.css" rel="stylesheet" type="text/css">
<style type="text/css">
@import url("../JavaScript/SmartStyles.css");
</style>
</head>

<body  onpaste="return false;" onLoad="document.getElementById('customer').focus()">
 
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
		<table class="BackGround" cellspacing="0" cellpadding="0" width="450"
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
                      <td colspan="2" class="bold1"><div align="center">DAILY CALLS<span class="boldEleven">
                        <input type="hidden" name="filename" value="DaillyCalls" />
                        <input type="hidden" name="actionS"  value="STADaillyCallsAdd" />
                      </span></div></td>
                    </tr>
                    <tr>
                      <td class="boldEleven">Customer<span class="spc"> *</span></td>
                      <td class="boldEleven">
<select name="customer" class="formText135" id="customer" style="width:170">
<option value="0">Select Customer</option>
<%
String cdata[][]= CommonFunctions.QueryExecute("SELECT a.INT_CUSTOMERID,b.CHR_NAME ,FIND_A_MKT_CUSTOMER_ADDRESS(a.INT_CUSTOMERID)  FROM mkt_m_customerinfo a, mkt_m_customername b  WHERE a.INT_CUSTOMERNAMEID =b.INT_CUSTOMERNAMEID  AND  a.CHR_VERIFY='Y'  ORDER BY b.CHR_NAME");
if(cdata.length>0)
for(int u=0;u<cdata.length;u++)
	out.println("<option value='"+cdata[u][0]+"'>"+cdata[u][1]+" / "+cdata[u][2]+"</option>");
%>
</select>                </td>
                    </tr>
                    <tr>
                      <td width="35%" class="boldEleven"> Agenda <span class="spc"> *</span></td>
                      <td width="65%" class="boldEleven"><input name="name" type="text" class="formText135" id="name" value="" size="30" maxlength="100">                          </td>
                    </tr>
					
					
					<tr>
                      <td width="35%" class="boldEleven">Call Type<span class="spc"> *</span></td>
                      <td width="65%" class="boldEleven">
                       <select name="calltype" class="formText135" id="calltype"  style="width:170">
						<option value="0">Select CallType</option>
						<%
							String ctdata[][]=CommonFunctions.QueryExecute("SELECT INT_CALLTYPEID,CHR_CALLTYPE FROM mkt_k_calltype ORDER BY CHR_CALLTYPE");
							if(ctdata.length>0)
							for(int u=0;u<ctdata.length;u++)
							out.println("<option value='"+ctdata[u][0]+"'>"+ctdata[u][1]+"</option>");
						%>
						</select>  
                      </td>
                    </tr>
					
					 <tr>
                      <td class="boldEleven">Starting Date<span class="spc"> *</span></td>
                      <td class="boldEleven"><input name="fromdate" type="text" class="formText135" id="fromdate" value="" size="30"  readonly="readonly"/>                      </td>
                    </tr>
                    <tr>
                      <td class="boldEleven">Ending Date<span class="spc"> *</span></td>
                      <td class="boldEleven"><input name="todate" type="text" class="formText135" id="todate" value="" size="30" readonly />
                      <script language="javascript">setCurrentDateandTime('fromdate');setCurrentDateandTime('todate');</script>
						<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script type="text/javascript" src="../JavaScript/jquery/Time/jquery-ui.min.js"></script>
<script type="text/javascript" src="../JavaScript/jquery/Time/jquery-ui-timepicker-addon.js"></script>
<script type="text/javascript" src="../JavaScript/jquery/Time/jquery-ui-sliderAccess.js"></script>
 
					 
					 
					   <script language="javascript">

$('#fromdate').datetimepicker(
{
	showSecond: true,
	timeFormat: 'hh:mm:ss',
	stepHour: 1,
	stepMinute: 1,
	stepSecond: 10,
	showOn: "button",
	buttonImage: "../JavaScript/jquery/images/calendar.gif",
	buttonImageOnly: true,
	changeMonth: true,
	numberOfMonths: 2,minDate: -2, maxDate: "+2D" ,
			
    onClose: function(dateText, inst) 
	{
        var endDateTextBox = $('#todate');
        if (endDateTextBox.val() != '') 
		{
            var testStartDate = new Date(dateText);
            var testEndDate = new Date(endDateTextBox.val());
            if (testStartDate > testEndDate)
                endDateTextBox.val(dateText);
        }
        else 
		{
            endDateTextBox.val(dateText);
        }
    },
	
	
    onSelect: function (selectedDateTime)
	{
        var start = $(this).datetimepicker('getDate');
        $('#todate').datetimepicker('option', 'minDate', new Date(start.getTime()));
    }
}
);




$('#todate').datetimepicker(
{
	showSecond: true,
	timeFormat: 'hh:mm:ss',
	stepHour: 1,
	stepMinute: 1,
	stepSecond: 10,
	showOn: "button",
	buttonImage: "../JavaScript/jquery/images/calendar.gif",
	buttonImageOnly: true,
	changeMonth: true,
	numberOfMonths: 2,minDate: -2, maxDate: "+2D" ,
			
    onClose: function(dateText, inst) 
	{
        var startDateTextBox = $('#fromdate');
        if (startDateTextBox.val() != '') 
		{
            var testStartDate = new Date(startDateTextBox.val());
            var testEndDate = new Date(dateText);
            if (testStartDate > testEndDate)
                startDateTextBox.val(dateText);
        }
        else 
		{
            startDateTextBox.val(dateText);
        }
    },
	
	
    onSelect: function (selectedDateTime){
        var end = $(this).datetimepicker('getDate');
        $('#fromdate').datetimepicker('option', 'maxDate', new Date(end.getTime()) );
    }
}
);
</script>					  </td>
                    </tr>
					<tr>
                      <td width="35%" class="boldEleven">Description<span class="spc"> *</span></td>
                      <td width="65%" class="boldEleven"><textarea name="desc" cols="30" rows="5" class="formText135"
									id="desc" ></textarea>                      </td>
                    </tr>
					
                   
                     
                    <tr>
                      <td class="boldEleven"> Opportunity Value <span class="spc"> *</span> </td>
                      <td class="boldEleven"><input name="opportunityvalue" type="text" class="formText135" id="opportunityvalue" size="30" maxlength="10"  onKeyPress="return numeric_only(event,'opportunityvalue','25')"></td>
                    </tr>
                    <tr>
                      <td class="boldEleven">Follows on<span class="spc"> *</span></td>
                      <td class="boldEleven"><select name="Follows" id="Follows"  class="formText135" onChange="changeState()" style="width:170">
                        <option value="0" selected>Select Close</option>
                          <option value="Y">Yes</option>
                          <option value="N">No</option>
                      </select></td>
                    </tr>
                    <tr id="nstartdate" style="visibility:hidden">
                      <td class="boldEleven" >Follows Date From<span class="spc"> *</span></td>
                      <td class="boldEleven"><input name="nfromdate" type="text" class="formText135" id="nfromdate" value="" size="30" readonly />                     	</td>
                    </tr>
                   
                    <tr id="nenddate" style="visibility:hidden">
                      <td class="boldEleven" >Follows Date To <span class="spc"> *</span></td>
                      <td class="boldEleven"><input name="ntodate" type="text" class="formText135" id="ntodate" value="" size="30" readonly /><script language="javascript">setCurrentDateandTime('nfromdate');setCurrentDateandTime('ntodate');</script>
						
					   <script language="javascript">

$('#nfromdate').datetimepicker(
{
	
	showSecond: true,
	timeFormat: 'hh:mm:ss',
	stepHour: 1,
	stepMinute: 1,
	stepSecond: 10,
	showOn: "button",
	buttonImage: "../JavaScript/jquery/images/calendar.gif",
	buttonImageOnly: true,
	changeMonth: true,
	numberOfMonths: 2,minDate: -0,  
    
	onClose: function(dateText, inst) 
	{
        var endDateTextBox = $('#ntodate');
        if (endDateTextBox.val() != '') 
		{
            var testStartDate = new Date(dateText);
            var testEndDate = new Date(endDateTextBox.val());
            if (testStartDate > testEndDate)
                endDateTextBox.val(dateText);
        }
        else 
		{
            endDateTextBox.val(dateText);
        }
    },
	
    onSelect: function (selectedDateTime)
	{
        var start = $(this).datetimepicker('getDate');
        $('#ntodate').datetimepicker('option', 'minDate', new Date(start.getTime()));
    }
}
);




$('#ntodate').datetimepicker(
{
	
	showSecond: true,
	timeFormat: 'hh:mm:ss',
	stepHour: 1,
	stepMinute: 1,
	stepSecond: 10,
	showOn: "button",
	buttonImage: "../JavaScript/jquery/images/calendar.gif",
	buttonImageOnly: true,
	changeMonth: true,
	numberOfMonths: 2, minDate: -0, 
    
	onClose: function(dateText, inst) 
	{
        var startDateTextBox = $('#nfromdate');
        if (startDateTextBox.val() != '') 
		{
            var testStartDate = new Date(startDateTextBox.val());
            var testEndDate = new Date(dateText);
            if (testStartDate > testEndDate)
                startDateTextBox.val(dateText);
        }
        else 
		{
            startDateTextBox.val(dateText);
        }
    },
	
    onSelect: function (selectedDateTime)
	{
        var end = $(this).datetimepicker('getDate');
        $('#nfromdate').datetimepicker('option', 'maxDate', new Date(end.getTime()) );
    }
}
);
</script>	
					 			 </td>
                    </tr>
                     <tr id="ncalltype" style="visibility:hidden">
                       <td class="boldEleven" > New Call Type<span class="spc"> *</span></td>
                       <td class="boldEleven">
                       <select name="newcalltype" class="formText135" id="newcalltype"  style="width:170">
                        <option value="0">Select CallType</option>  
                         <%
							if(ctdata.length>0)
								for(int u=0;u<ctdata.length;u++)
									out.println("<option value='"+ctdata[u][0]+"'>"+ctdata[u][1]+"</option>");
						%>
                       </select>
                      
                       </td>
                    </tr>
                    <tr>
                      <td class="boldEleven">All Day </td>
                      <td class="boldEleven"><label>
                        <input name="active" type="checkbox" id="active" value=""  >
                      
                      ( please tick for full day work)</label></td>
                    </tr>
                    <tr>
                      <td colspan="2" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                          <tr>
                            <td><input name="Submit"  id="Submit" type="submit" class="buttonbold13"  value="Add"   accesskey="s"   ></td>
                            <td><input name="Close" type="button" class="buttonbold13" id="Close"  value="Close"   accesskey="c"  onClick="redirect('DailyCalls.jsp')"></td>
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
		<td height="50">&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td align="center" valign="middle"> 			<%
					  		
							String msg= ""+request.getParameter("msg");
					  		if(msg.length()>=6)
					  			out.println("<center><font class='boldgreen'>"+msg+"</font></center>");
					  %> 
					  
					  </td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
  </form>
 </body>
</html>
