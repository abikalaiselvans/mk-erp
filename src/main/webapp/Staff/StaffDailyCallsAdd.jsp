<%@ page import="java.io.*,java.util.*" isErrorPage="false" errorPage="../error/error.jsp"%>
<html>
<head>
<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>

<%@include file="Redirect.jsp" %>

<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />


<title>:: STAFF ::</title>

 
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"> </script>
<script language="javascript" >
function validate()
{
	if(
		checkNull('calldate','Enter the calldate')
		&& checkNull('callnumber','Enter the callnumber')
		&& checkNull('customername','Enter the customername')
		&& checkNullSelect('calltype','Select Call Type','0')
		&& checkNullSelect('callstatus','Select call  status','0')
		
		&& (checkNull('hours','Select hours  ') || checkNull('minutes','Select minutes  '))
		&& (checkNull('thours','Select travel  hours  ') || checkNull('tminutes','Select travel minutes  ')) 
		&& checkNullSelect('tkm','Select travel Kilometer','0')
		&& checkNull('noofspare','Select noofspare')
	)
	
	 
		return true;
	else
		return false;
}
</script>
<body  onpaste="return false;" onLoad="document.getElementById('callnumber').focus()">
<p>&nbsp;</p>
<table width="600" border="0" align="center" cellpadding="0"
			cellspacing="0" bgcolor="#dce4f9" class="BackGround">
  <tbody>
    <tr>
      <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></td>
      <td class="BorderLine" height="1"><spacer height="1" width="1"
						type="block" /></td>
      <td width="10" colspan="2" rowspan="2"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" /></td>
    </tr>
    <tr>
      <td height="6"><spacer height="1" width="1" type="block" /></td>
    </tr>
    <tr>
      <td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
      <td width="6"><spacer height="1" width="1" type="block" /></td>
      <td   valign="top"><form action="../SmartLoginAuth" method="post" name="frm" id="frm" onSubmit=" return validate()">
        <table width="100%" border="0" cellspacing="4" cellpadding="3"  class="boldEleven">
          <tr>
            <td colspan="4"><div align="center" class="copyright">DAILY REPORT </div></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td class="boldEleven">Date <span class="errormessage">* </span></td>
            <td class="boldEleven"><span class="boldEleven">
                <input name="calldate"
								type="text" class="formText135" id="calldate"
								onKeyPress="numericHypenOnly('calldate',10)" size="12"
								maxlength="10" readonly tabindex="1">
                <a
								href="javascript:cal1.popup();"> <img
								src="../JavaScript/img/cal.gif" width="16" height="16"
								border="0" alt="Click here to Pick Up the Date" onClick="submitenable()"  
								
		 ></a>
                <script
								language="JavaScript">
<!--
  var cal1=new calendar1(document.forms['frm'].elements['calldate']);
  cal1.year_scroll=true;
  cal1.time_comp=false;
  setCurrentDate('calldate');
//-->

  
 
            </script>            </td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td width="6%">&nbsp;</td>
            <td width="24%" class="boldEleven">Call Number  <span class="errormessage">* </span></td>
            <td width="64%" class="boldEleven"><input name="callnumber" type="text" class="formText135" id="callnumber"  tabindex="2" size="50" maxlength="10"></td>
            <td width="6%">&nbsp;</td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td class="boldEleven">Customer Name  <span class="errormessage">* </span></td>
            <td class="boldEleven"><input name="customername" type="text" class="formText135" id="customername"  tabindex="3" size="50" maxlength="100"></td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td align="left" valign="top" class="boldEleven">Location</td>
            <td align="left" valign="top" class="boldEleven"><input name="location" type="text" class="formText135" id="location"  tabindex="4" size="50" maxlength="50"></td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td class="boldEleven">Call Type   <span class="errormessage">* </span></td>
            <td class="boldEleven">
			<select name="calltype" class="formText135" id="calltype"  tabindex="5">
			<option value="0">Select</option>
			<option value="1">'01' Calls</option>
			<option value="2">'02' Calls</option>
			<option value="3">Installation</option>
			<option value="4">Chargable Call</option>
			
            </select>            </td>
            <td>&nbsp;</td>
          </tr>

          <tr>
            <td>&nbsp;</td>
            <td class="boldEleven">Calls Status  <span class="errormessage">* </span></td>
            <td class="boldEleven"><select name="callstatus" class="formText135" id="callstatus"  tabindex="6">
			<option value="0">Select</option>
			 <option value="C">Closed</option>
			<option value="P">Pending</option>
            </select>            </td>
            <td>&nbsp;</td>
          </tr>

          <tr>
            <td>&nbsp;</td>
            <td class="boldEleven">Hands On Hours  <span class="errormessage">* </span></td>
            <td class="boldEleven"><table width="120" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td class="boldEleven"><select name="hours" class="formText135" id="hours"  tabindex="7">
                   
                  <%
			for(int u=-1;u<24;u++)
				out.println("<option value='"+(u+1)+"'>"+(u+1)+"</option>");
			%>
                </select></td>
                <td class="errormessage">Hours</td>
                <td class="boldEleven"><select name="minutes" class="formText135" id="minutes"  tabindex="8">
                  
                  <%
			for(int u=-1;u<60;u++)
				out.println("<option value='"+(u+1)+"'>"+(u+1)+"</option>");
			%>
                </select></td>
                <td class="errormessage">Minutes</td>
              </tr>
            </table></td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td class="boldEleven">Travel Hours/ KM  <span class="errormessage">* </span></td>
            <td class="boldEleven"><table width="120" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td class="boldEleven"><select name="thours" class="formText135" id="thours"  tabindex="9">
                   
                  <%
			for(int u=-1;u<24;u++)
				out.println("<option value='"+(u+1)+"'>"+(u+1)+"</option>");
			%>
                </select></td>
                <td class="errormessage">Hours</td>
                <td class="boldEleven"><select name="tminutes" class="formText135" id="tminutes" tabindex="10">
                  
                  <%
			for(int u=-1;u<60;u++)
				out.println("<option value='"+(u+1)+"'>"+(u+1)+"</option>");
			%>
                </select></td>
                <td class="errormessage">Minutes</td>
                <td class="boldEleven"><select name="tkm" class="formText135" id="tkm"  tabindex="11">
                   
                  <%
			for(int u=-1;u<500;u++)
				out.println("<option value='"+(u+1)+"'>"+(u+1)+"</option>");
			%>
                </select></td>
                <td class="errormessage">KM</td>
              </tr>
            </table></td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td class="boldEleven">No Spare Demanded <span class="errormessage">* </span> </td>
            <td class="boldEleven">
			<select name="noofspare" id="noofspare"  tabindex="12">
             
			<%
			for(int u=-1;u<15;u++)
				out.println("<option value='"+(u+1)+"'>"+(u+1)+"</option>");
			%>
			</select></td>
            <td>&nbsp;</td>
          </tr>

          <tr>
            <td>&nbsp;</td>
            <td class="boldEleven">Days Closed <span class="errormessage">* </span></td>
            <td class="boldEleven"><table width="74" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="22" class="boldEleven"><input name="dayclosed"  id="dayclosed" type="radio" value="Y" tabindex="13"></td>
                <td width="20" class="boldEleven">Yes</td>
                <td width="20" class="boldEleven"><input name="dayclosed" id="dayclosed"  type="radio" value="N" checked  tabindex="14"> </td>
                <td width="58" class="boldEleven">No</td>
              </tr>
            </table>
              <input name="filename"  id="filename" type="hidden" value="StaffDailyCalls" />
              <input name="actionS"   id="actionS"  type="hidden" value="SSRStaffDailyCallsADD" />
              <input name="userid" type="hidden" id="userid" value="<%=session.getAttribute("USRID")%>"></td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td colspan="4"><table width="120" border="0" align="center" cellpadding="3" cellspacing="4">
                <tr>
                  <td valign="top"><input type="submit" class="buttonbold13" name="add"  id="add" value="ADD"    tabindex="15"/></td>
                  <td valign="top"><input type="button" class="buttonbold13" name="edit" id="edit" value="CLOSE" onClick="redirect('StaffDailyCallsView.jsp')"  tabindex="16" /></td>
                </tr>
            </table></td>
          </tr>
        </table>
                  </form>
      </td>
      <td nowrap="nowrap" width="6"><spacer height="1" width="1"
						type="block" /></td>
      <td width="1" class="BorderLine"><spacer height="1" width="1"
						type="block" /></td>
    </tr>
    <tr>
      <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BLCorner.gif" width="7" /></td>
      <td height="6"><spacer height="1" width="1" type="block" /></td>
      <td colspan="2" rowspan="2" valign="bottom"><div align="right"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></div></td>
    </tr>
    <tr>
      <td class="BorderLine" height="1"></td>
    </tr>
  </tbody>
</table>
</body>
</html>
