 <%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
%>
<html>
<head>
<title>-</title> 
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


<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
 <style type="text/css">
 @import url("../JavaScript/SmartStyles.css");
 </style>
</head>
 <script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
<script language="javascript" src="../JavaScript/Inventory/PurchaseRequestDate.js"></script>
<script>
 

 $(function() {
		var dates = $( "#fromdate, #todate" ).datepicker({
			defaultDate: "+1w",
			changeMonth: true,
			changeYear: true,
			changeMonth: true,maxDate: "+0D" ,
			
			showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			buttonImageOnly: true,
			numberOfMonths: 1,
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
	if(  checkNull( "fromdate","Enter from date" ) 
		 && checkNull( "todate","Enter to date" ) )
		return true;
	else
		return false;				
		
 } 	
</script> 
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  >
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
	 <form  AUTOCOMPLETE = "off"   action="Rept_DailyCallsResponse.jsp" method="post" name="frm" id="frm" onSubmit="return Validate()">
	<table class="BackGround1" cellspacing="0" cellpadding="0" width="400"
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
                <td colspan="2" class="bold1"><div align="center">CALL TYPE 
                    			
				
				</div></td>
                </tr>
              <tr>
                <td width="23%" class="boldEleven">Call Type </td>
                <td width="77%" class="boldEleven"><select name="calltype" class="formText135" id="calltype"   style="width:175">
                  <option value="0">All</option>
                  <%
							String ctdata[][]= CommonFunctions.QueryExecute("SELECT INT_CALLTYPEID,CHR_CALLTYPE FROM mkt_k_calltype ORDER BY CHR_CALLTYPE");
							if(ctdata.length>0)
							for(int u=0;u<ctdata.length;u++)
							out.println("<option value='"+ctdata[u][0]+"'>"+ctdata[u][1]+"</option>");
						%>
                </select> 
				 
				</td>
              </tr>
              
               
              <tr>
                <td valign="top" class="boldEleven">Customer </td>
                <td class="boldEleven"><select name="customer" class="formText135" id="customer"  style="width:175">
                  <option value="0">All</option>
                  <%
String cdata[][]= CommonFunctions.QueryExecute("SELECT INT_CUSTOMERID,CHR_COMPANYNAME ,CHR_CONTACTPERSON FROM mkt_m_customerinfo ORDER BY CHR_COMPANYNAME");
if(cdata.length>0)
for(int u=0;u<cdata.length;u++)
	out.println("<option value='"+cdata[u][0]+"'>"+cdata[u][1]+" / "+cdata[u][2]+"</option>");
%>
                </select>
					 
				</td>
              </tr>
              <tr>
                <td class="boldEleven">Status</td>
                <td class="boldEleven"><select name="close" id="close"  class="formText135"  style="width:175" >
                  <option value="0" selected>All</option>
                  <option value="Y">Closed</option>
                  <option value="N">Pending</option>
                </select></td>
              </tr>
              <tr>
                <td class="boldEleven">From </td>
                <td class="boldEleven"><input
									tabindex="2" name="fromdate" type="text" class="formText135"
									id="fromdate" size="15" readonly>
<script language="javascript">setCurrentDate('fromdate')</script>                                    
                                    
                                    </td>
              </tr>
              <tr>
                <td class="boldEleven">To</td>
                <td class="boldEleven"><input tabindex="2"
									name="todate" type="text" class="formText135" id="todate"
									size="15" readonly><script language="javascript">setCurrentDate('todate')</script> </td>
              </tr>
              <tr>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">&nbsp; </td>
              </tr>
              <tr>
                <td colspan="2" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1" cellspacing="1">
                  <tr>
                    <td><input name="Submit"  id="Submit" type="submit" class="tMLAscreenHead" value="Submit"   accesskey="s"   ></td>
                    <td><input name="Close" type="button"   class="tMLAscreenHead" id="Close"  value="Close"   accesskey="c"  onClick="redirect('Userframe.jsp')"></td>
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
 
<%
	
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>
</body>
</html>
