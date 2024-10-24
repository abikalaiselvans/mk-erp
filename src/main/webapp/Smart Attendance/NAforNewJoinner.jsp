<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage=""%>
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


<title> :: ATTENDANCE ::</title>

 <style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
 </style>

<script language="javascript" src="../JavaScript/comfunction.js"></script>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>

<body  >
<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" onSubmit="return validate()">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td><table width="70%" border="0" align="center" cellpadding="0" cellspacing="0">
		  <tr>
		    <td width="66%"><table class="BackGround1" cellspacing="0" cellpadding="0" width="400"
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
		          <td width="412"><table width="100%" border="0" align="center" cellpadding="2" cellspacing="2"
						 >
		            <!--DWLayoutTable-->
		            <tr align="center" valign="middle">
		              <td height="18" colspan="2"  class="BackGround">NOT APPLICABLE FOR NEW JOINER &amp; RESIGNER</td>
		              </tr>
		            <tr class="bolddeepblue">
		              <td width="132" height="24" valign="middle" class="bolddeepblue"><!--DWLayoutEmptyCell-->&nbsp;</td>
		              <td width="268" valign="top" class="bolddeepblue"><!--DWLayoutEmptyCell-->&nbsp;</td>
		              </tr>
		            <tr>
		              <td class="boldEleven">Month</td>
		              <td><span class="boldThirteen">
		                <select name="month" id="month" onChange="assign()">
		                  <option value="0">Select Month</option>
		                  <%@ include file="../JavaScript/Inventory/month.jsp"%>
		                  </select>
		                </span></td>
		              </tr>
		            <tr>
		              <td class="boldEleven">Year</td>
		              <td><span class="boldThirteen">
		                <select name="year" id="year" onChange="assign()">
		                  <option value="0">Select Year</option>
		                  <%@ include file="../JavaScript/Inventory/year.jsp"%>
		                  </select>
		                <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						setOptionValue('month',month1);
						setOptionValue('year',year1);							
				//-->
                            </script>
		                </span></td>
		              </tr>
		            <tr>
		              <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
		              <td><input type="hidden" name="filename" value="StaffNotApplicable">
		                <input type="hidden" name="actionS" value="ATTStaffNotApplicable">
		                <span style="FONT-SIZE: 10px; LINE-HEIGHT: 15px; FONT-FAMILY: Verdana; TEXT-DECORATION: none; font-weight: normal;"><font color="#FF0000"> </font></span></td>
		              </tr>
		            <tr>
		              <td height="28" colspan="2" valign="middle" class="bolddeepblue"><table   border="0" align="center" cellpadding="3"
								cellspacing="3">
		                <tr>
		                  <td width="70"><input name="Submit2" type="submit"
										class="buttonbold" id="submit" value="Submit"   accesskey="s"   ></td>
		                  <td width="70"><input class="buttonbold" type="button"
										name="Submit"  value="Close"   accesskey="c" 
										onClick="redirect('AttendanceMain.jsp')"></td>
		                  </tr>
		                </table></td>
		              </tr>
		            <tr>
		              <td height="2"></td>
		              <td></td>
		              </tr>
		            </table></td>
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
	        </table></td>
		    <td width="34%"><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
		      <tr>
		        <td width="24%"><img src="../Image/report/msexcel-mysql1.jpg" width="60" height="60"></td>
		        <td width="76%" class="boldgreen"><a   title="Clear Datas" href="javascript:UploadWindow('UploadAttendance.jsp')">Upload Attendance</a></td>
		        </tr>
		      <tr>
		        <td>&nbsp;</td>
		        <td>&nbsp;</td>
		        </tr>
	        </table></td>
	      </tr>
      </table></td>
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

<script language="javascript">
	 
	
	function  validate()
	{
		 
		if( 
			checkNullSelect('month','Select Month','0')
			&& checkNullSelect('year','Select Year','0')
			
		  )
			return true;
		else
			return false;
	}
 
 
function UploadWindow(query)
{  
	var width="800", height="400";
	var left = (screen.width/2) - width/2;
	var top = (screen.height/2) - height/2;
	var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=yes,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
	newWindow = window.open(query,"subWind",styleStr);
	newWindow.focus( );
}

</script>
</form>
<%@ include file="../footer.jsp"%>
</body>
</html>
