<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%
try
{
%>
<%@ page import="com.my.org.erp.common.CommonFunction"%>
<%@ page import="com.my.org.erp.ServiceLogin.DateUtil"%>
<%@ include file="index.jsp"%>
 <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title> :: PAYROLL ::</title>


 

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

</style>
<script language="JavaScript" src="../JavaScript/comfunction.js"> </script>
<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>

	
	
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">
<script language="JavaScript">

function checkResginDate(ctr1,ctr2)
{
   try
   {
		var date1=document.getElementById(ctr1).value;
		var d1=date1.substr(0,2);
		var m1=date1.substr(3,2);
		var y1=date1.substr(6,4);
		var date2=document.getElementById(ctr2).value;
	  
		var d2=date2.substr(0,2);
		var m2=date2.substr(3,2);
		var y2=date2.substr(6,4);
		 
		if(!isNaN(d1) && !isNaN(m1) && !isNaN(y1))
		{
			  if(!isNaN(d2) && !isNaN(m2) && !isNaN(y2))
			  { 
				 if((d1<=d2 && m1==m2 && y1==y2) ||(d1<=d2 && m1<=m2 && y1<=y2) ||
				 (m1<m2 && y1==y2) || (y1<y2) )
				  {
					return true;
				  }
				  else
				  {
					alert(" Resign Date Should Be Greater Than or Equal to "+date1);
					document.getElementById(ctr2).value="";
					document.getElementById(ctr2).focus();
					return false;
				  }
			  }
			  else
			  {
				  alert("Enter Correct Date");
				  document.getElementById(ctr2).value="";
				  document.getElementById(ctr2).focus();
				  return false;
			  }	  
		}
		else
		{
		  alert("Enter Correct Date");
		  document.getElementById(ctr1).value="";
		  document.getElementById(ctr1).focus();
		  return false;
		}
	   }
	   catch(err)
	   {
		  alert(err);
	   }
  }




  function Validate()
  {
  
	//alert(DateCompares ("fromdt","todate", "Resign submit is greather than the "+todate+"Date"));
	if(
		checkNull("fromdt","Enter Resing Date") 
  		&& checkNull("reason","Enter The Reason ") 
  		
		 
		&& checkResginDate("todate","fromdt")
		)
			return true;
		else
			return false;
  }
  
  
</script>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
 <style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style> 
</head>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<table width="100%" height="285" align="center">


	<tr>
	  <td height="151" align="center"><br>
		  <table width="414" border="0" align="center" cellpadding="0"
			cellspacing="0" bgcolor="#dce4f9" class="BackGround">
            <!--DWLayoutTable-->
            <tbody>
              <tr>
                <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></td>
                <td width="401" height="1" class="BorderLine"><spacer
						height="1" width="1" type="block" /></td>
                <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" /></td>
              </tr>
              <tr>
                <td height="6"><spacer height="1" width="1" type="block" /></td>
              </tr>
              <tr>
                <td width="1" rowspan="2" class="BorderLine"><spacer
						height="1" width="1" type="block" /></td>
                <td width="6" rowspan="2"><spacer height="1" width="1"
						type="block"></td>
                <td height="164" valign="top">
				
				
				
				<form  AUTOCOMPLETE = "off" action="../SmartLoginAuth"   method="post" name="frm" onsubmit="return Validate()">

				<table width="386" border="0" align="center" cellpadding="2"
						cellspacing="2"  >
                    <!--DWLayoutTable-->
                    <tr align="center">
                      <td height="25" colspan="2" valign="top" class="tablesubhead">Resignation Letter
					  
					  <%
	  String sesUserId1=""+session.getAttribute("EMPID");
	  
	  
	  if(com.my.org.erp.common.CommonFunction.RecordExist("SELECT COUNT(*) FROM pay_t_resignationletter WHERE CHR_EMPID='"+sesUserId1+"'"))
	  		response.sendRedirect("error.jsp?error=Already put a resign paper...");
			
	  String repto=(""+CommonFunction.stringGetAnySelectField("select CHR_REPTO from com_m_staff where CHR_EMPID='"+sesUserId1+"'","CHR_REPTO")).trim();
	  if(repto.equals("0"))
		  repto="ADMIN";
	  String resignlimit=(""+CommonFunction.stringGetAnySelectField("select INT_RESIGNATIONLIMIT from m_institution ","INT_RESIGNATIONLIMIT")).trim();
	  String cudate=(DateUtil.getCurrentDBDate());
	  String todate=DateUtil.FormateDateSys(""+CommonFunction.stringGetAnySelectField("select ADDDATE('"+cudate.trim()+"',"+(Integer.parseInt(resignlimit)-1)+" ) as addate","addate")).trim();
	    
	  
	  
	  %>
	  <input type="hidden" name="repto" id="repto" value="<%= repto %>">
      <input type="hidden" name="todate" id="todate" value="<%= todate %>">
					   <span class="bolddeepblue"> </span></td>
                    </tr>
                    <tr>
                      <td height="30" valign="middle" class="boldEleven">You can resign on or after </td>
                      <td class="bolddeepred"><%= todate %></td>
                    </tr>
                    <tr>
                      <td width="164" height="30" valign="middle" class="boldEleven">Expected Date of resign  <span class="boldred">(LWD)*</span> </td>
                      <td width="208"><input name="fromdt" type="text" class="formText135"
								id="fromdt" readonly="readonly" value="<%= todate %>" size="15">
								
								
						<script>
	
	$(function() {
		$( "#fromdt" ).datepicker({ minDate: "0D", maxDate: "+<%=resignlimit%>D",showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			buttonImageOnly: true });
	});
	
	 
 
	
</script>                      </td>
                    </tr>
                    <tr>
                      <td height="67" align="left" valign="top" class="boldEleven">Reason&nbsp; <span class="boldred">*</span> </td>
                      <td align="left" valign="top"><textarea name="reason" cols="25" rows="10" class="formText135" id="reason" onBlur="textArea('reason','250')"></textarea></td>
                    </tr>
                    <tr>
                      <td height="40" colspan="2" align="left" valign="middle"
								class="bolddeepblue"><input name="actionS"
								type="hidden" id="actionS" value="PAYResignationStaffs">
                        <input name="filename" type="hidden" id="filename" value="Resignation">
                        <table width="140" border="0" align="center" cellpadding="2"
								cellspacing="2">
                            <tr>
                              <td width="63"><input name="Submit" type="submit" class="buttonbold"
										value=" Submit "></td>
                              <td width="63"><input class="buttonbold" type="Button" name="Submit2"
										 value="Close"   accesskey="c"  onClick="javascript:history.back();"></td>
                            </tr>
                        </table></td>
                    </tr>
                </table>
				
				</form>
				</td>
                <td width="5" rowspan="2" nowrap="nowrap"><spacer height="1"
						width="1" type="block" /></td>
                <td width="1" rowspan="2" class="BorderLine"><spacer
						height="1" width="1" type="block" /></td>
              </tr>
              <tr>
                <td height="2"></td>
              </tr>
              <tr>
                <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BLCorner.gif" width="7" /></td>
                <td height="6"><spacer height="1" width="1" type="block" /></td>
                <td colspan="2" rowspan="2" valign="bottom"><div align="right"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></div></td>
              </tr>
              <tr>
                <td class="BorderLine" height="1"><spacer height="1" width="1"
						type="block" /></td>
              </tr>
            </tbody>
          </table></td>
	</tr>
	
	<tr>
	  <td height="17">&nbsp;</td>
  </tr>
	<tr>
	  <td height="17">&nbsp;</td>
	</tr>
	<tr>
	  <td height="17" align="center">    
  <tr>
	  <td height="17" align="center">
		<center>
    
  <tr>
		<td height="20"><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
</body>
</html>
<%
}
catch(Exception e)
{
}
%>