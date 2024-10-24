<%@ page import="java.io.*,java.util.*"%>
<%@ page import="sun.net.smtp.SmtpClient"%>

<html>
<head>
<title>:: INVENTORY ::</title><link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>


<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js" type="text/javascript"></script>

<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
<script>
$(function() {
		var dates = $( "#fromdate, #todate" ).datepicker({
			defaultDate: "+1w",
			changeMonth: true,
			numberOfMonths: 3,
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
	});</script>
	
	
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">



<script language="javascript" >
function valid()
{
	var from = document.getElementById('frombranch').value;
	var to = document.getElementById('tobranch').value;
	if(from === to)
	{
		alert("Please select different Branch...");
		document.getElementById('tobranch').focus();
		return false;
	}	
	else
		return true;
}
</script>
<body >
<%@ include file="indexinv.jsp"%>
<table width="100%" border="0" cellspacing="1" cellpadding="1">
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
    <td><form action="Rept_StockTransferBranchwiseresponse.jsp" method="get" name="frm" id="frm" onSubmit="return valid()">
      <table class="BackGround1" cellspacing="0" cellpadding="0" width="250"
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
            <td width="412"><table cellspacing="2" cellpadding="2" width="600" align="center"
						border="0">
                <!--DWLayoutTable-->
                <tbody>
                  <tr>
                    <td height="16" colspan="4" align="center" valign="top"
									class="boldThirteen">Stock Transfer Branch Wise </td>
                    </tr>
					
					<%
					String usertype=""+session.getAttribute("USRTYPE");
					String branchid = ""+session.getAttribute("BRANCHID");
				
					if(usertype.equals("F"))
						{
					%>
                     
                    <tr>
                      <td height="17" colspan="4" class="boldEleven"><table width="100%" border="0" align="center" cellpadding="2" cellspacing="2">
                        <tr>
                          <td height="17" class="boldEleven">From</td>
                          <td height="17" class="boldEleven"><select  class="formText135"
							id="frombranch" name="frombranch" tabindex="6" style="width:200"  >
                            <%
 						
						
							String ssql= " Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID ";
							String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(ssql);	
							for(int u=0;u<data.length;u++)
								out.print("<option value='"+data[u][0]+"'>"+data[u][2]+" @ "+data[u][1]+"</option>");
					%>
                          </select></td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven">To </td>
                          <td height="17" class="boldEleven"><select  class="formText135"
							id="tobranch"  name="tobranch" tabindex="6"   style="width:200">
                            <%
 						 for(int u=0;u<data.length;u++)
								out.print("<option value='"+data[u][0]+"'>"+data[u][2]+" @ "+data[u][1]+"</option>");
					%>
                          </select>
						  <script language="javascript">
						  	setOptionValue("frombranch","<%=branchid%>") 
						  	setOptionValue("tobranch","<%=branchid%>") 
						  </script>
						  </td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven">Division</td>
                          <td height="17" class="boldEleven">
						  <select name="division"
									class="formText135" id="division" tabindex="1" style="width:200">
									<option value='0'>All</option>
									<%
								String division[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division   WHERE INT_DIVIID >0 AND CHR_OFFICEIDS LIKE '%"+session.getAttribute("INVOFFICEID")+"%'  ORDER BY CHR_DIVICODE"); 
								for(int u=0; u<division.length; u++)
									out.print("<option value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
							%>
								</select>						  </td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven">From Date <span
									class="bolddeepred">* </span></td>
                          <td height="17" class="boldEleven"><input
									tabindex="2" name="fromdate" type="text" class="formText135"
									id="fromdate" size="15" readonly="readonly">
                             <!-- <a
									href="javascript:cal2.popup();"> <img
									src="../JavaScript/img/cal.gif" width="16" height="16"
									border="0" /> </a>-->
                              <script language='JavaScript'
									type="text/javascript">
		<!--			
				//document.getElementById('saleDate').disabled=true;
				var cal2 = new calendar1(document.forms['frm'].elements['fromdate']);
				cal2.year_scroll = true;
				cal2.time_comp = false;
				setCurrentDate('fromdate'); 
		//-->
                                </script></td>
                        </tr>
                        <tr>
                          <td height="17" class="boldEleven">To Date <span
									class="bolddeepred">* </span></td>
                          <td height="17" class="boldEleven"><input tabindex="2"
									name="todate" type="text" class="formText135" id="todate"
									size="15" readonly="readonly">
                              <!--<a
									href="javascript:cal3.popup();"> <img
									src="../JavaScript/img/cal.gif" width="16" height="16"
									border="0" /> </a>-->
                              <script language='JavaScript'
									type="text/javascript">
		<!--			
				//document.getElementById('saleDate').disabled=true;
				var cal3 = new calendar1(document.forms['frm'].elements['todate']);
				cal3.year_scroll = true;
				cal3.time_comp = false;
				setCurrentDate('todate'); 
		//-->
                                </script></td>
                        </tr>
                        <tr>
                          <td height="17" colspan="2" class="boldEleven">Including Date Range
                            <input name="daterange" type="checkbox" id="daterange" value="Y" checked></td>
                        </tr>
                        
                      </table></td>
                    </tr>
                    <tr>
                    <td height="17" colspan="2" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                    <td height="17" colspan="2" class="boldEleven"> 		</td>
                  </tr>
				  <%
				  }
				  %>
                  <tr>
                    <td height="17" colspan="4" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                      <tr>
                        <td><input name="Submit" type="submit"
											class="buttonbold13" value="Submit"   accesskey="s"   ></td>
                        <td><input name="Close" type="button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="javascirpt:window.close()"></td>
                      </tr>
                    </table></td>
                    </tr>
                  <tr>
                    <td height="17" colspan="2" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                    <td height="17" colspan="2" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                  </tr>
                </tbody>
                <input type="hidden" name="mobileBookingOption" />
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
      </table>
            </form>
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
</table>
<%@ include file="../footer.jsp"%>
</body>
</html>
