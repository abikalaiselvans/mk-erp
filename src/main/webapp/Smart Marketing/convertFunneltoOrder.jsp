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
	var v =document.getElementsByName("close")[0].value;  
	if("Y" == v)		
	{
		nstartdate.style.visibility="hidden";
	   	ncalltype.style.visibility="hidden";
	}
	else
	{
		nstartdate.style.visibility="visible";
	   	ncalltype.style.visibility="visible";    
	}
}

function Validate()
  {
	if( 
	   
	   	checkNullSelect( "customer","Select customer" ,'0')
		&& checkNullSelect( "calltype","Select calltype" ,'0')
		&& checkNull( "fromdate","Enter starting date" )
		&& checkNull( "todate","Enter ending date" )
		&& dateComparision('fromdate','todate','Please check the starting date and ending date') 
		&& checkNull( "desc","Enter Description" )
		&& checkNull( "opportunityvalue","Enter opportunity value  " )
		&& checkNull( "close","Please select Call status" )
		&& checksfadateOnly()
		
	){
		
		var sval=document.getElementsByName("close");
			for (var x = 0; x < sval.length; x++) {
		  	if (sval[x].checked) {
				if(sval[x].value != "Y"){
					if(checkNull("nfromdate","Select from date ","") && checkNull('ntodate','Enter to date'))
						return true;
					else
						return false;
				}		 	
			}
		 }
	}else
		return false;		
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
</script>
<style type="text/css">
@import url("../JavaScript/SmartStyles.css");
</style>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>

<link href="../JavaScript/jquery/Time/jquery-ui.css" rel="stylesheet" type="text/css">
<link href="../JavaScript/jquery/Time/jquery-ui-timepicker-addon.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
 
<script type="text/javascript" src="../JavaScript/jquery/Time/jquery-ui.min.js"></script>
<script type="text/javascript" src="../JavaScript/jquery/Time/jquery-ui-timepicker-addon.js"></script>
<script type="text/javascript" src="../JavaScript/jquery/Time/jquery-ui-sliderAccess.js"></script>


    
</head>

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
                      <td colspan="2" class="bold1"><div align="center">CONVERT FUNNEL TO ORDER CONFIRMATION
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
							int rowid=0,previousrowid=0;
								id=request.getParameter("id");
								sql = "SELECT a.INT_CALLID,a.INT_CUSTOMERID,d.CHR_NAME,c.INT_CALLTYPEID,a.CHR_DESC,DATE_FORMAT(a.DAT_START,'%d-%m-%Y %H:%i:%s'),DATE_FORMAT(a.DAT_END,'%d-%m-%Y %H:%i:%s'), a.CHR_STATUS,DOU_VALUE,a.CHR_ADDEDTO_FUNNEL FROM mkt_t_daillycalls a,mkt_m_customerinfo b,mkt_k_calltype c,mkt_m_customername d WHERE a.INT_CUSTOMERID=b.INT_CUSTOMERID AND a.CHR_CALLTYPE=c.INT_CALLTYPEID AND b.INT_CUSTOMERNAMEID =d.INT_CUSTOMERNAMEID AND a.INT_CALLID= "+id;
 								
								 
								String data[][]=CommonFunctions.QueryExecute(sql);
								if(data.length>0)
									for(int i=0;i<8;i++)
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
								
								actionS="MKTScheduleEntryEdit";
								value="Update";
						%>
                          <span class="boldEleven">
                          <input type="hidden" name="filename" value="DaillyCalls" />
                          <input type="hidden" name="actionS"  value="MKTDaillyCallsConvertFunnel" />
                          <input name="id" type="hidden" id="id" value="<%=id%>">
						  <input name="customer" type="hidden" id="customer" value="<%=customerid%>">
                          </span>
                          <input name="close"  id="close" type="hidden" value="Y">
                      </div></td>
                    </tr>
                    <tr>
                      <td class="boldEleven">Customer<span class="spc"> *</span></td>
                      <td class=""><%=customername%> </td>
                    </tr>
                    
					
					<tr>
                      <td width="35%" class="boldEleven"> Call Type<span class="spc"> *</span></td>
                      <td width="65%" class="boldEleven"> 
					  <select name="calltype" class="formText135" id="calltype" style="width:150">
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
                      <td width="35%" class="boldEleven">Description<span class="spc"> *</span></td>
                      <td width="65%" class="boldEleven"><textarea name="desc" cols="26" rows="5" class="formText135"
									id="desc"><%=desc%></textarea></td>
                    </tr>
					
                    <tr>
                      <td class="boldEleven">Starting Date<span class="spc"> *</span></td>
                      <td class="boldEleven"><input name="fromdate" type="text" class="formText135" id="fromdate" value="<%=Nfrom%>" size="30"  readonly="readonly"/></td>
                    </tr>
                    <tr>
                      <td class="boldEleven">Ending Date<span class="spc"> *</span></td>
                      <td class="boldEleven"><input name="todate" type="text" class="formText135" id="todate" value="<%=Nto%>" size="30" readonly />
										 
					
					 
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
	numberOfMonths: 1,minDate: -0,  
    
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
	numberOfMonths: 1,minDate: -0,  
    
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
</script>					  </td>
                    </tr>
                     
                    <tr>
                      <td class="boldEleven">Added to funnel </td>
                      <td class="boldEleven"><input <%=("Y".equals(data[0][9]))? " checked='checked' ":" "%> name="funnel" type="checkbox" id="funnel" value="Y" ></td>
                    </tr>
                    <tr>
                      <td class="boldEleven"> Opportunity Value <span class="spc"> *</span></td>
                      <td class="boldEleven"><input name="opportunityvalue" type="text" class="formText135" id="opportunityvalue" value="<%=callvalue%>" size="30" maxlength="10"  onKeyPress="return numeric_only(event,'opportunityvalue','25')"></td>
                    </tr>
                     
					<tr>
                      <td width="35%" class="boldEleven"> <span class="spc"></span></td>
					  
					   <td width="65%">&nbsp;</td>
                    </tr>
					
				 
					 
                     
                     
                    <tr>
                      <td colspan="2" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
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

