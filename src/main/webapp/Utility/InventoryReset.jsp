<html>
<head>

<title> :: UTILITY :: </title>


 
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

 <script src="../JavaScript/comfunction.js" language="javascript"></script>
<script>
function validate()
{
	if(
		checkNullSelect("Type","Select Type...","0")
		&& checkNull("starting","Enter Starting number...")
	)
	{
		var name=confirm("Wait, Please confirm to reset the number");
		if (name==true)
			return true;
		else
			return false;
	}
	else
		return false;
}

</script>
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
 
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td></td>
	</tr>
	<tr>
		<td></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
	  <td>&nbsp;</td>
  </tr>
	<tr>
	  <td><table class="BackGround" cellspacing="0" cellpadding="0" width="450"
			align="center" border="0">
        <tbody>
          <tr>
            <td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></td>
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
            <td width="412"><table width="100%" height="95%" align="right" cellpadding="1"
						cellspacing="1"  1>
                <!--DWLayoutTable-->
                <tr>
                  <td align=center class="boldgre"></td>
                  <!--<td width="242" align=center class="boldgre"><div align="center" class="bolddeepblue">
            <input type="radio" id="date1" name="reportType" value="Date" onClick="disableYearWise()" >
            DateWise</div></td>-->
                </tr>
                <tr>
                  <td colspan="2" align="center"></td>
                </tr>
                <tr>
                  <td colspan="2" align="center">
				  <form name="a" action="../SmartLoginAuth" method="post"  onSubmit="return validate()" >
				  <table width="100%" border="0" cellspacing="5" cellpadding="5">
                    <tr>
                      <td colspan="2" class="boldEleven"><div align="center"><strong>Inventory Starting Number Set
                        <input name="filename" type="hidden"
								id="filename" value="InventorySetting" />
                        <input name="actionS"
								type="hidden" id="actionS" value="UTIInventorySetting" />
</strong></div></td>
                      </tr>
                    <tr>
                      <td class="boldEleven">Select Type </td>
                      <td class="boldEleven">
                        <select name="Type" class="formText135"  id="Type" >
						<option value="0">Select</option>
						<option value="inv_m_advancepaymentgenerate">Advance </option>
                        <option value="inv_m_customersalesordergenerate">Customer Purchase Order [ CPO ]   </option>
                        <option value="inv_m_directdcgenerate">Delivery Challan</option>
                        <option value="inv_m_invoicegenerate"> Sales </option>
                        <option value="inv_m_pogenerate">Purchase Order </option>
                        <option value="inv_m_quotationgenerate"> Quotation </option>
                        <option value="inv_m_servicebillgenerate">Service Bill </option>
                        <option value="inv_m_vendorpogenerate">Vendor PO </option>
                        <option value="inv_t_deliverychallangenerate">DC </option>
                        <option value="inv_t_scrabgenerate">Scrab </option>
                        <option value="inv_m_purchaserequestnogenerate">Purchase Request</option>
                        <option value="inv_m_stocktransfergenerate">Stock Transfer </option>
						<option value="All">All</option>
                        </select>                      </td>
                    </tr>
                    <tr>
                      <td class="boldEleven">Staring No </td>
                      <td class="boldEleven"><input name="starting" type="text" class="formText135" id="starting" onKeyPress="return numeric_only(event,&#39;starting&#39;,&#39;12&#39;)"value="1" size="18" maxlength="4" style="text-align:right"></td>
                    </tr>
                    <tr>
                      <td colspan="2" class="boldEleven"><table border="0" align="center" cellpadding="3" cellspacing="0">
                        <tr>
                          <td width="56"><input name="Submit" type="submit" class="buttonbold" value="Submit"   accesskey="s"   ></td>
                          <td width="56"><input name="button" type="button"
					class="buttonbold"  value="Close"   accesskey="c"  onClick="redirect('Userframe.jsp')"></td>
                        </tr>
                      </table></td>
                      </tr>
                  </table>
				  </form>				  </td>
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
		<td></td>
	</tr>
</table>
 
</body>
</html>
