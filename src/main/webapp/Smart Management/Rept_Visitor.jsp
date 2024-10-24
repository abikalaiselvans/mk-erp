    <%@ page import="java.sql.*,java.util.*,java.io.*"%>
 <%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
%>
<html>
<head>
<title>:: INVENTORY ::</title> 
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



</head>
 <script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>

<script>
	$(function() {
		var dates = $( "#fromdate, #todate" ).datepicker({
			defaultDate: "+1w",
			changeMonth: true,changeYear: true,
			numberOfMonths: 1,
			showOn: "button",
				buttonImage: "../JavaScript/jquery/images/calendar.gif",
				buttonImageOnly: true,
			onSelect: function( selectedDate ) {
				var option = this.id == "fromdate" ? "minDate" : "maxDate",
					instance = $( this ).data( "datepicker" ),
					date = $.datepicker.parseDate(
						instance.settings.dateFormat ||
						$.datepicker._defaults.dateFormat,
						selectedDate, instance.settings );
				dates.not( this ).datepicker( "option", option, date );
				
			}
		});
	});
	</script>
	
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">

<script language="JavaScript">

function Validate()
  {
	
   
	if(  checkNull( "fromdate","Enter The fromdate" ) 
	     &&  checkNull( "todate","Enter The todate" )
		  )
		return true;
	else
		return false;				
		
	
 } 	
 
  

</script>
<body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  >
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
	 <form  AUTOCOMPLETE = "off"   action="Rept_VisitorResponse.jsp" method="post" name="frm" id="frm" onSubmit="return Validate()">
	<table class="BackGround1" cellspacing="0" cellpadding="0" width="424"
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
          <td width="412" valign="top">
		 
		    <table width="100%" border="0" align="center" cellpadding="3" cellspacing="3">
              <tr>
                <td colspan="2" class="bold1"><div align="center"><span class="boldThirteen">VISITORS</span></div></td>
                </tr>
              <tr>
                <td width="173" class="boldEleven">From Date </td>
                <td   class="boldEleven"><input   
												name="fromdate" type="text" class="formText135"
												id="fromdate" size="15" maxlength="10"
												onKeyPress="dateOnly('fromdate')" />
                  &nbsp;
                  
                  <script
												language='JavaScript' type="text/javascript">
		<!--
			
			setCurrentDate('fromdate');
		//-->
	                              </script></td>
                </tr>
              <tr>
                <td class="boldEleven">To Date </td>
                <td   class="boldEleven"><input
												name="todate" type="text" class="formText135" id="todate"  
												size="15" maxlength="10" onKeyPress="dateOnly('todate')" />
                  <!-- <a href="javascript:cal2.popup();"> <img
												src="../JavaScript/img/cal.gif" width="16" height="16"
												border="0" alt="Click Here to Pick up the date" /> </a>-->
                  <script
												language='JavaScript' type="text/javascript">
		<!--
			
			setCurrentDate('todate');
		//-->
	                              </script></td>
                </tr>
              <tr>
                <td align="left" valign="top" class="boldEleven">Building <span class="boldred">*</span></td>
                <td class="boldEleven"><select name="building" tabindex="3" class="formText135" id="building" style="width:150">
                  <option value="0"  >All</option>
                  <%
				String buildingData[][]=  CommonFunctions.QueryExecute("SELECT INT_BUILDINGID ,CHR_BUILDINGNAME FROM  mgt_m_buildingname ORDER BY CHR_BUILDINGNAME");
			if(buildingData.length>0) 
				for(int i=0;i<buildingData.length;i++)
					out.println("<option value='"+buildingData[i][0]+"'>"+buildingData[i][1]+"</option>");
				%>
                </select></td>
              </tr>
              <tr>
                <td align="left" valign="top" class="boldEleven">Floor <span class="boldred">*</span></td>
                <td class="boldEleven"><select name="floor" tabindex="4" class="formText135" id="floor" style="width:150">
                  <option value="0"  >All</option>
                  <%
				String floorData[][]=  CommonFunctions.QueryExecute("SELECT INT_FLOORID ,CHR_FLOOR FROM  mgt_m_floor ORDER BY CHR_FLOOR");
			if(floorData.length>0) 
				for(int i=0;i<floorData.length;i++)
					out.println("<option value='"+floorData[i][0]+"'>"+floorData[i][1]+"</option>");
				%>
                </select></td>
              </tr>
              <tr>
                <td align="left" valign="top" class="boldEleven">Purpose <span class="boldred">*</span></td>
                <td class="boldEleven"><select name="purpose" tabindex="5" class="formText135" id="purpose" style="width:150">
                  <option value="0"  >All</option>
                  <%
				String purposeData[][]=  CommonFunctions.QueryExecute("SELECT INT_PURPOSEID ,CHR_PURPOSE FROM  mgt_m_purpose ORDER BY CHR_PURPOSE");
			if(purposeData.length>0) 
				for(int i=0;i<purposeData.length;i++)
					out.println("<option value='"+purposeData[i][0]+"'>"+purposeData[i][1]+"</option>");
				%>
                </select></td>
              </tr>
              <tr>
                <td colspan="2" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                  <tr>
                    <td><input name="Submit" id="Submit" type="submit" 	class="buttonbold13" value="Submit"></td>
                    <td><input name="Close" type="button"   class="buttonbold13" id="Close"  value="Close"   accesskey="c"  	onClick="redirect('Building.jsp')"></td>
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
 
}
catch(Exception e)
{
	System.out.println(e.getMessage());
}
%>
</body>
</html>
