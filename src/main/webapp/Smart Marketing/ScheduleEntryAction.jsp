<%@ page   language="java" 	import="java.sql.*" %>
<%@ page import="com.my.org.erp.common.CommonFunctions"%><%
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

 

 
function Validate()
  {
	if( 
	   
	   	checkNullSelect( "customer","Select customer" ,'0')
		&& checkNull( "name","Enter Title" )
		&& checkNull( "fromdate","Enter starting date" )
		&& checkNull( "fromdate","Enter starting date" )
		&& checkNull( "todate","Enter ending date" )
		&& checkDateTimes("fromdate","Check from date")
		&& checkDateTimes("todate","Check to date")
		&& dateComparision('fromdate','todate','Please check the from date and to date') 
	)
		return true;
	else
		return false;				
		
 } 	
</script>

 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>


<link href="../JavaScript/jquery/Time/jquery-ui.css" rel="stylesheet" type="text/css">
<link href="../JavaScript/jquery/Time/jquery-ui-timepicker-addon.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script type="text/javascript" src="../JavaScript/jquery/Time/jquery-ui.min.js"></script>
<script type="text/javascript" src="../JavaScript/jquery/Time/jquery-ui-timepicker-addon.js"></script>
<script type="text/javascript" src="../JavaScript/jquery/Time/jquery-ui-sliderAccess.js"></script>
 
 
 
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>
</head>

<body onselectstart="return false" onpaste="return false;" onCopy="return false"    onLoad="document.getElementById('name').focus()">
<%@ include file="index.jsp"%>
<!--onclick="this.disabled='disabled'"-->
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
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="600"
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
                      <td colspan="2" class="bold1"><div align="center">Schedule Entry
                          <%
							String action=request.getParameter("action1");
							String id="",Name="",actionS="",value="",dt="";
							String from="";
							String to="";
							String customerid="0";
							String active="";
							String sql="";
							if("Add".equals(action))
							{
								id="";Name="";active="";dt="";from="";to="";customerid="0";
								actionS="MKTScheduleEntryAdd";
								value="Add";
							}
							else
							{
								id="";Name="";dt="";from="";to="";customerid="0";
								id=request.getParameter("id");
								      
								sql = " SELECT INT_SCHEDULEID,INT_CUSTOMERID,CHR_TITLE,DATE_FORMAT(DAT_START,'%d-%m-%Y %H:%i'),DATE_FORMAT(DAT_END,'%d-%m-%Y %H:%i'),CHR_ALLDAY     FROM mkt_t_schedule WHERE INT_SCHEDULEID= "+id;
								
								 
								String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
								id=data[0][0];
								customerid=data[0][1];
								Name=data[0][2];
								from=data[0][3];
								to=data[0][4];
								active=data[0][5]; 
								actionS="MKTScheduleEntryEdit";
								value="Update";
							}
							
						%>
                          <span class="boldEleven">
                          <input type="hidden" name="filename" value="ScheduleEntry" />
                          <input type="hidden" name="actionS"  value="<%=actionS%>" />
                          <input name="id" type="HIDDEN" id="id" value="<%=id%>">
                          </span></div></td>
                    </tr>
                    <tr>
                      <td class="boldEleven">Customer<span class="spc"> *</span></td>
                      <td class="boldEleven">
<select name="customer" class="formText135" id="customer" style="width:170">
<option value="0">Select Customer</option>
<%
String cdata[][]= CommonFunctions.QueryExecute("SELECT a.INT_CUSTOMERID,b.CHR_NAME ,a.CHR_CONTACTPERSON  FROM mkt_m_customerinfo a, mkt_m_customername b  WHERE a.INT_CUSTOMERNAMEID =b.INT_CUSTOMERNAMEID   ORDER BY b.CHR_NAME"); // AND  a.CHR_VERIFY='Y'
if(cdata.length>0)
for(int u=0;u<cdata.length;u++)
	out.println("<option value='"+cdata[u][0]+"'>"+cdata[u][1]+" / "+cdata[u][2]+"</option>");
%>
</select>  
<script language="javascript">setOptionValue('customer','<%=customerid%>')</script>                    </td>
                    </tr>
                    <tr>
                      <td width="35%" class="boldEleven"> Title <span class="spc"> *</span></td>
                      <td width="65%" class="boldEleven"><input name="name" type="text" class="formText135" id="name" value="<%=Name%>" size="30" maxlength="25">
                          <span class="errormessage">( Short title)                        </span>
                          <div id='divunitname'></div></td>
                    </tr>
                    <tr>
                      <td class="boldEleven">Starting Date<span class="spc"> *</span></td>
                      <td class="boldEleven"><input name="fromdate" type="text" class="formText135" id="fromdate" value="<%=from%>" size="30" readonly/>
                      

					 															
																
					  </td>
                    </tr>
                    <tr>
                      <td class="boldEleven">Ending Date<span class="spc"> *</span></td>
                      <td class="boldEleven"><input name="todate" type="text" class="formText135" id="todate" value="<%=to%>" size="30" readonly />
					  
			                      <script language="javascript">setCurrentDateandTime('fromdate');setCurrentDateandTime('todate');</script>
		 
					 
					 
					   <script language="javascript">
$('#fromdate').datetimepicker({
	showSecond: true,
	timeFormat: 'hh:mm:ss',
	stepHour: 1,
	stepMinute: 1,
	stepSecond: 10,
	showOn: "button",
	buttonImage: "../JavaScript/jquery/images/calendar.gif",
	buttonImageOnly: true,
	changeMonth: true,
	numberOfMonths: 2,minDate: -2, maxDate: "+30D" ,		
    onClose: function(dateText, inst) {
        var endDateTextBox = $('#todate');
        if (endDateTextBox.val() != '') {
            var testStartDate = new Date(dateText);
            var testEndDate = new Date(endDateTextBox.val());
            if (testStartDate > testEndDate)
                endDateTextBox.val(dateText);
        }
        else {
            endDateTextBox.val(dateText);
        }
    },
    onSelect: function (selectedDateTime){
        var start = $(this).datetimepicker('getDate');
        $('#todate').datetimepicker('option', 'minDate', new Date(start.getTime()));
    }
});
$('#todate').datetimepicker({
	 showSecond: true,
	timeFormat: 'hh:mm:ss',
	stepHour: 1,
	stepMinute: 1,
	stepSecond: 10,
	showOn: "button",
	buttonImage: "../JavaScript/jquery/images/calendar.gif",
	buttonImageOnly: true,
	changeMonth: true,
	numberOfMonths: 2,minDate: -2, maxDate: "+20D" ,		
    onClose: function(dateText, inst) {
        var startDateTextBox = $('#fromdate');
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
    onSelect: function (selectedDateTime){
        var end = $(this).datetimepicker('getDate');
        $('#fromdate').datetimepicker('option', 'maxDate', new Date(end.getTime()) );
    }
});
</script>
					  
					  </td>
                    </tr>
                     
                    <tr>
                      <td class="boldEleven">All Day </td>
                      <td class="boldEleven"><label>
                        <input name="active" type="checkbox" id="active" value=""  >
                        <%					
	if(!"Add".equals(action) && "Y".equals(active))
	{
	%>
                        <script language="javascript">document.getElementById('active').checked=true</script>
                        <%
	}
	%>
                      ( please tick for full day work)</label></td>
                    </tr>
                    <tr>
                      <td class="boldEleven">&nbsp;</td>
                      <td class="boldEleven">&nbsp;</td>
                    </tr>
                    <tr>
                      <td colspan="2" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                          <tr>
                            <td><input name="Submit"  id="Submit" type="submit" class="buttonbold13" value="Submit"   accesskey="s"    ></td>
                            <td><input name="Close" type="button" class="buttonbold13" id="Close"  value="Close"   accesskey="c"  onClick="redirect('ScheduleEntry.jsp')"></td>
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