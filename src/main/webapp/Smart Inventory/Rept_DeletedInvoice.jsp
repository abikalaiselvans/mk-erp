<%@ page import="java.io.*,java.util.*"%>

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
<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
<script language="javascript" src="../JavaScript/Inventory/PurchaseRequestDate.js"></script>
<script>
	 

 $(function() {
		var dates = $( "#saleDate, #saleDate2" ).datepicker({
			defaultDate: "+1w",
			changeMonth: true,maxDate: "+0D" ,
			numberOfMonths: 2,
			onSelect: function( selectedDate ) {
				var option = this.id == "saleDate" ? "minDate" : "maxDate",
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
    <td><form action="Rept_DeletedInvoicePrint.jsp" method="get" name="frm" id="frm">
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
                    <td height="16" colspan="2" align="center" valign="top"
									class="boldThirteen">DELETE INVOICE </td>
                    </tr>
                  <tr>
                    <td height="16" align="center" valign="top"
									class="boldThirteen"><!--DWLayoutEmptyCell-->&nbsp;</td>
                    <td align="center" valign="top"
									class="boldThirteen"><!--DWLayoutEmptyCell-->&nbsp;</td>
                  </tr>
                  <tr>
                    <td height="17" class="boldEleven">Type</td>
                    <td height="17" class="boldEleven"><select name="type"  id="type" style="width:200">
                        <option value="1">Vendor Purchase
                          <option value="2">Customer Sales
                          <option value="3">Direct Billing
                          <option value="4">Service Billing
                          </select>                    </td>
                  </tr>
                  <tr>
                    <td height="17" class="boldEleven">From Date <span
									class="bolddeepred">* </span></td>
                    <td height="17" class="boldEleven"><input
									tabindex="2" name="saleDate" type="text" class="formText135"
									id="saleDate" size="15" readonly="readonly">
                        
                        <script language='JavaScript'
									type="text/javascript">
		<!--			
				 
				setCurrentDate('saleDate'); 
		//-->
                                </script></td>
                  </tr>
                  <tr>
                    <td height="17" class="boldEleven">To Date <span
									class="bolddeepred">* </span></td>
                    <td height="17" class="boldEleven"><input tabindex="2"
									name="saleDate2" type="text" class="formText135" id="saleDate2"
									size="15" readonly="readonly">
                         
                        <script language='JavaScript'
									type="text/javascript">
		<!--			
			 
				setCurrentDate('saleDate2'); 
		//-->
                                </script></td>
                  </tr>
                  <tr>
                    <td height="17" colspan="2" class="boldEleven">Including Date Range 
                      <input name="daterange" type="checkbox" id="daterange" value="Y"></td>
                    </tr>
					
					<%
					String usertype=""+session.getAttribute("USRTYPE");
					String branchid = ""+session.getAttribute("BRANCHID");
				
					if(usertype.equals("F"))
						{
					%>
                  <tr>
                    <td height="17" class="boldEleven">
					
					Branch</td>
                    <td height="17" class="boldEleven">
					<select name="Branch" class="formText135"
							id="Branch" tabindex="6"   style="width:200">

					<%
 						
						
							String ssql= " Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID ";
							String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(ssql);	
							for(int u=0;u<data.length;u++)
								out.print("<option value='"+data[u][0]+"'>"+data[u][2]+" @ "+data[u][1]+"</option>");
					%>
					</select>
					<script language="javascript">
						  	setOptionValue("Branch","<%=branchid%>") 
						  </script>
						  
	<%
	/*out.println("<center><table width='100%' cellspacing=2 cellpadding=1 border=0>");
	out.println("<tr>");
	int i=0;
	for(int x=0;x<data.length;x++)
	{
		if(i%3 == 0)
		{
		 out.println("<tr>");
		 i=i+1;
		}
		else
		{
			i = 0;
		}	
		out.println("<td class='boldEleven'><input type='checkbox' id='customergroupid' name='customergroupid' value='"+data[x][0]+"' >"+data[x][2]+" @ "+data[x][1]);	
			
	}
	out.println("</table></center>");*/
%>					</td>
                  </tr>
				  <%
				  }
				  %>
                  <tr>
                    <td height="17" colspan="2" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                      <tr>
                        <td><input name="Submit" type="submit"
											class="buttonbold13" value="Submit"   accesskey="s"   ></td>
                        <td><input name="Close" type="button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="redirect( 'InventoryMains.jsp')"></td>
                      </tr>
                    </table></td>
                    </tr>
                  <tr>
                    <td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                    <td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
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
