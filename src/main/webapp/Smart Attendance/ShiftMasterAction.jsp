 <%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%
try
{
%>
<html>
<head>

<title> :: ATTENDANCE ::</title>


 
<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>

<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id,payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



<style type="text/css">
<!--
.style3 {color: #FF0000}
-->
</style>
</head>
<script language="JavaScript" src="../JavaScript/calendar1.js" type="text/javascript"></script>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/ComAJAX.js"></script>
<script language="JavaScript" src="../JavaScript/common/prototype.js"></script>
<script language="JavaScript" src="../JavaScript/common/html-form-input-mask.js"></script>
<script language="javascript">
	function validate()
	{
	
		if( checkNull('TxtShiftName','Enter Shift Name')
		&& checkNull('TxtStart','Enter Shift Starting Time')
		&& checkNull('MorTeaIn','Enter Mornign Tea In Time')
		&& checkNull('MorTeaOut','Enter Mornign Tea Out Time')
		&& checkNull('LunchIn','Enter Lunch In Time')
		&& checkNull('LunchOut','Enter Lunch Out Time')
		&& checkNull('EveTeaIn','Enter Evening Tea In Time')
		&& checkNull('EveTeaOut','Enter Ebeninig Tea Out Time')
		&& checkNull('TxtEnding','Enter Shift Ending Time')
		&& checkNull('StartGrace', 'Enter Shift Starting Grace Time')
		&& checkNull('EndGrace', 'Enter Shift Ending Grace Time')
		&& ( 
		 checkTimeFormat('TxtStart','Enter Correct 24 Hrs Time Format for the Shift Starting Time')
		&& checkTimeFormat('MorTeaIn','Enter Correct 24 Hrs Time Format for the Mornign Tea In Time')
		&& checkTimeFormat('MorTeaOut','Enter Correct 24 Hrs Time Format for the Mornign Tea Out Time')
		&& checkTimeFormat('LunchIn','Enter Correct 24 Hrs Time Format for the Lunch In Time')
		&& checkTimeFormat('LunchOut','Enter Correct 24 Hrs Time Format for the Lunch Out Time')
		&& checkTimeFormat('EveTeaIn','Enter Correct 24 Hrs Time Format for the Evening Tea In Time')
		&& checkTimeFormat('EveTeaOut','Enter Correct 24 Hrs Time Format for the Ebeninig Tea Out Time')
		&& checkTimeFormat('TxtEnding','Enter Correct 24 Hrs Time Format for the Shift Ending Time')
		&& checkTimeFormat('StartGrace', 'Enter Correct 24 Hrs Time Format for the Shift Starting Grace Time')
		&& checkTimeFormat('EndGrace', 'Enter Correct 24 Hrs Time Format for the Shift Ending Grace Time')
		)
		&& ( 
		checkTimeCompare('TxtStart','TxtEnding','End Time Should Be Greater Than Start Time(Enter 24 Hrs Time Format)') 
		   && checkTimeCompare('MorTeaIn','MorTeaOut','Morning Break Time Out Should Be Greater Than Morning Break Time In (Enter 24 Hrs Time Format)') 
		   && checkTimeCompare('LunchIn','LunchOut','Lunch Out Time Should Be Greater Than Lunch In Time(Enter 24 Hrs Time Format)') 
		   && checkTimeCompare('EveTeaIn','EveTeaOut','Evening Break Time Out Should Be Greater Than Evening Break Time In(Enter 24 Hrs Time Format)') 
		   && checkTimeCompare('TxtStart','StartGrace','Start Grace Time Should Be Greater Than Start Time(Enter 24 Hrs Time Format)') 
		   && checkTimeCompare('EndGrace','TxtEnding','Ending Time Should Be Greater Than End Grace Time(Enter 24 Hrs Time Format)') 
		   && checkTimeCompare('TxtStart','EndGrace','End Grace Time Should Be Greater Than start Time(Enter 24 Hrs Time Format)')
		   && checkTimeCompare('EveTeaOut','EndGrace','End Grace Time Should Be Greater Than Evening Break Time Out(Enter 24 Hrs Time Format)')
		   && checkTimeCompare('TxtStart','MorTeaIn','Morning Break Time In Should Be Greater Than Start Time(Enter 24 Hrs Time Format)')
		   && checkTimeCompare('MorTeaOut','LunchIn','Lunch In Time Should Be Greater Than Morning Break Time Out(Enter 24 Hrs Time Format)')
		   && checkTimeCompare('LunchOut','EveTeaIn','Evening Break Time In Should Be Greater Than Lunch Out Time(Enter 24 Hrs Time Format)')
		   && checkTimeCompare('EveTeaOut','TxtEnding','Ending Time Should Be Greater Than Evening Break Time Out(Enter 24 Hrs Time Format)')
		   )
		)
		{
		
		document.a.action="../SmartLoginAuth";
	//	document.a.submit();

		}
		else
		{
		
			return false;		
			
			}
	}

</script>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="document.getElementById('TxtShiftName').focus(),Xaprb.InputMask.setupElementMasks()">
<%@ include file="index.jsp"%>
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
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>
	 <form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm" onSubmit="return Validate()">
	<table class="BackGround1" cellspacing="0" cellpadding="0" width="486"
			align="center" border="0">
      <tbody>
        <tr>
          <td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></td>
          <td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
          <td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" /></td>
        </tr>
        <tr>
          <td height="6"><spacer height="1" width="1" type="block" /></td>
        </tr>
        <tr>
          <td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
          <td width="6"><spacer height="1" width="1" type="block" /></td>
          <td width="472" valign="top">
		 
		    <table width="99%" border="0" align="center" cellpadding="3" cellspacing="3">
              <tr>
                <td colspan="3" class="bold1"><div align="center"> SHIFT MASTER
				
				
				    <%
							String action=request.getParameter("action1");
							String id="",Name="",desc="",actionS="",value="",shiftName="",shiftFromDate="",
							teaTimeIn1="",teaTimeOut1="",lunchIn="",lunchOut="",teaTimeIn2="",
							teaTimeOut2="",shiftToDate="",graceIn="",graceOut="";
							String sql="";
							String link="";
							 
							if("Add".equals(action))
							{
								id="";Name=""; desc="";
								actionS="ATTshiftAdd";
								value="Add";
								link=" onBlur=\"CheckUnique(this,'divunitname','att_m_shift','CHR_SHIFTNAME')\"  onKeyUp=\"CheckUnique(this,'divunitname','att_m_shift','CHR_SHIFTNAME')\" ";
							}
							else
							{
								id="";Name=""; 
								shiftName="";
								id=request.getParameter("OptShiftName");
								sql="SELECT INT_SHIFTID,CHR_SHIFTNAME,DT_STARTINGTIME,DT_TEA_TIMEIN1,DT_TEA_TIMEOUT1,DT_LUNCH_IN,DT_LUNCH_OUT,DT_TEA_TIMEIN2,DT_TEA_TIMEOUT2,DT_ENDINGTIME,DT_GRACEIN,DT_GRACEOUT FROM att_m_shift where INT_SHIFTID="+id;
								String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
								id=data[0][0];
								shiftName=data[0][1];  
								shiftFromDate=data[0][2];
								teaTimeIn1=data[0][3];
								teaTimeOut1=data[0][4];
								lunchIn=data[0][5];
								lunchOut=data[0][6];
								teaTimeIn2=data[0][7];
								teaTimeOut2=data[0][8];
								shiftToDate=data[0][9];
								graceIn=data[0][10];
								graceOut=data[0][11];
							
							
								actionS="ATTshiftEdit";
								value="Update";
								link="  readonly = 'readonly' ";
								
							}
							
						%>
				    			
				
				</div></td>
                </tr>
				<tr>
				  <td colspan="3"><span class="style3">Note:Use 24 Hrs Time Format(Enter only  valid  numbers continuously) for each 'Time Inputboxes'.</span></td>
				</tr>
              <tr>
                <td width="34%" valign="middle"   class="boldEleven"> Shift Name <font color='red'>* </font></td>
                <td width="36%" class="boldEleven"><input name="TxtShiftName"
												type="text" class="formText135" id="TxtShiftName"
												  onBlur="upperMe(this)"   
												onkeypress="alphaNumeric('TxtShiftName','25')" 
												value="<%= shiftName %>" size="30" maxlength="30" 
												 <%=link%> />
                    <div id="divunitname"></td>
                <td width="30%" class="boldEleven">&nbsp;</td>
              </tr>
              <tr>
                <td valign="middle"   class="boldEleven">Starting Time <font color='red'>*</font></td>
                <td class="boldEleven"><input name="TxtStart" class="text input_mask mask_time"
												type="text"  id="TxtStart"
												value="<%= shiftFromDate %>" size="25" /></td>
                <td class="boldred">( HH:MM:SS )</td>
              </tr>
              <tr>
                <td valign="middle"   class="boldEleven">Mor Tea Time In <font color='red'>*</font></td>
                <td class="boldEleven"><input name="MorTeaIn"
												type="text" class="text input_mask mask_time" id="MorTeaIn"
												value="<%= teaTimeIn1 %>" size="25"></td>
                <td class="boldred">( HH:MM:SS )</td>
              </tr>
              <tr>
                <td valign="middle"   class="boldEleven"> Mor Tea Time Out <font color='red'>*</font></td>
                <td class="boldEleven"><input name="MorTeaOut" type="text"
												class="text input_mask mask_time" id="MorTeaOut"
												value="<%= teaTimeOut1 %>"
												size="25"></td>
                <td class="boldred">( HH:MM:SS )</td>
              </tr>
              <tr>
                <td valign="middle"   class="boldEleven"> Lunch Time In <font color='red'>*</font></td>
                <td class="boldEleven"><input name="LunchIn" type="text"
												class="text input_mask mask_time" id="LunchIn"
												value="<%= lunchIn %>"
												size="25"></td>
                <td class="boldred">( HH:MM:SS )</td>
              </tr>
              <tr>
                <td valign="middle"   class="boldEleven"> Lunch Time Out <font color='red'>*</font></td>
                <td class="boldEleven"><input name="LunchOut"
												type="text" class="text input_mask mask_time" id="LunchOut"
												value="<%= lunchOut %>"
												size="25"></td>
                <td class="boldred">( HH:MM:SS )</td>
              </tr>
              <tr>
                <td valign="middle"   class="boldEleven"> Eve Tea Time In <font color='red'>*</font></td>
                <td class="boldEleven"><input name="EveTeaIn" type="text"
												class="text input_mask mask_time" id="EveTeaIn"
												value="<%= teaTimeIn2 %>"
												size="25"></td>
                <td class="boldred">( HH:MM:SS )</td>
              </tr>
              <tr>
                <td valign="middle"   class="boldEleven"> Eve Tea Time Out <font color='red'>*</font></td>
                <td class="boldEleven"><input name="EveTeaOut" type="text"
												class="text input_mask mask_time" id="EveTeaOut"
												value="<%= teaTimeOut2 %>"
												size="25"></td>
                <td class="boldred">( HH:MM:SS )</td>
              </tr>
              <tr>
                <td valign="middle"   class="boldEleven"> Ending Time <font color='red'>*</font></td>
                <td class="boldEleven"><input name="TxtEnding" type="text"
												class="text input_mask mask_time" id="TxtEnding"
												value="<%= shiftToDate %>"
												size="25"></td>
                <td class="boldred">( HH:MM:SS )</td>
              </tr>
              <tr>
                <td valign="middle"   class="boldEleven">Starting Grace Time <font color="#ff0000">*</font></td>
                <td class="boldEleven"><input name="StartGrace" type="text"
												class="text input_mask mask_time" id="StartGrace"
												value="<%= graceIn %>"
												size="25"></td>
                <td class="boldred">( HH:MM:SS )</td>
              </tr>
              <tr>
                <td valign="middle"   class="boldEleven">Ending Grace
                  Time <font color="#ff0000">*</font></td>
                <td class="boldEleven"><input name="EndGrace" type="text"
												class="text input_mask mask_time" id="EndGrace"
												value="<%= graceOut %>"
												size="25"></td>
                <td class="boldred">( HH:MM:SS )</td>
              </tr>
              
              <tr>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">
				<input type="hidden" name="filename" value="ShiftMaster" />
				<input type="hidden" name="actionS"  value="<%=actionS%>" />
				<input name="id" type="HIDDEN" id="id" value="<%=id%>">				</td>
                <td class="boldEleven">&nbsp;</td>
              </tr>
              <tr>
                <td colspan="3" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                  <tr>
                    <td><input name="Submit" id="Submit" type="submit" 	class="buttonbold13" value="<%=value%>" onClick="return validate()"></td>
                    <td><input name="Close" type="button"   class="buttonbold13" id="Close"  value="Close"   accesskey="c"  	onClick="redirect('ShiftMasterView.jsp')"></td>
                  </tr>
                </table></td>
                </tr>
            </table>
		 </td>
          <td nowrap="nowrap" width="6"><spacer height="1" width="1"
						type="block" /></td>
          <td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
        </tr>
        <tr>
          <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BLCorner.gif" width="7" /></td>
          <td height="6"><spacer height="1" width="1" type="block" /></td>
          <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></td>
        </tr>
        <tr>
          <td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
        </tr>
      </tbody>
    </table> </form></td>
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
<%@ include file="../footer.jsp"%>

<%
	String msg=""+request.getParameter("msg");
	if(!"null".equals(msg))
	{
	%>
	<script language="javascript">
		var rs=confirm("<%=msg%>, Add one more record...");
		if (rs==true)
  		 	location = 'EmailCompanyAction.jsp?action1=Add'; 
		else	
		location = 'EmailCompany.jsp'; 
	</script>
	<%	
	}
}
catch(Exception e)
{
}
%>
</body>
</html>
