<%@ page import="java.io.*,java.util.*" errorPage="../error/index.jsp"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>

<%@ page import="sun.net.smtp.SmtpClient"%>
<html>
<head><title>:: INVENTORY ::</title><link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>

<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
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
<script language="javascript" src="../JavaScript/comfunction.js"></script>
 
 <script language="javascript" type="text/javascript">
function Validate()
  {
    	if( checkNullSelect( "reportType","Select Export Type" ,'0') )	
			return true;
		else
			return false;
}
</script>
 </head>
<body >
 <%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth" onSubmit="return Validate()">
<table width="56" border="0" align="center" cellpadding="5" cellspacing="0">
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><table class="BackGround1" cellspacing="0" cellpadding="0" width="424"
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
          <td width="412"><table cellspacing="2" cellpadding="2" width="407" align="center"
						border="0">
              <!--DWLayoutTable-->
              <tbody>
                <tr>
                  <td height="16" colspan="3" align="center" valign="top"
									class="boldThirteen">Consumable Stock
                    </td>
                </tr>
                <tr>
                  <td height="19" colspan="3" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory </span></td>
                </tr>
                 
                <tr>
                  <td width="126" height="17" class="boldEleven">Branch</td>
                  <td width="267" colspan="2" align="left">
				  <select name="Branch" class="formText135" id="Branch" tabindex="6"  style="width:240">
										<option value="0">All</option>
										<%
								String branchid=""+session.getAttribute("BRANCHID");
								String sq=" Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID ";
 
								String shipids[][] =  CommonFunctions.QueryExecute(sq);
								for(int u=0; u<shipids.length; u++)
									out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][2]+ "  @  " +shipids[u][1] +"</option>");
							%>
					  </select>				  </td>
                </tr>
                <tr>
                  <td height="17" class="boldEleven">Division</td>
                  <td colspan="2" align="left"><select name="division" class="formText135" id="division" tabindex="1"  style="width:240">
                    <option value='0'>All</option>
                    <%
								String division[][] =  CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division   WHERE INT_DIVIID >0 AND CHR_OFFICEIDS LIKE '%"+session.getAttribute("INVOFFICEID")+"%'  ORDER BY CHR_DIVICODE"); 
								for(int u=0; u<division.length; u++)
									out.print("<option value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
							%>
                  </select></td>
                </tr>
                <tr>
                  <td height="17" class="boldEleven">Consumables</td>
                  <td colspan="2" align="left"><select name="product" class="formText135" id="product" tabindex="1"  style="width:240">
                    <option value='0'>All</option>
                    <%
								String consumables[][] =  CommonFunctions.QueryExecute("SELECT CHR_PRODUCTID , CHR_PRODUCTCODE FROM inv_m_produtlist WHERE CHR_PTYPE='S' ORDER BY CHR_PRODUCTCODE"); 
								for(int u=0; u<consumables.length; u++)
									out.print("<option value='"+consumables[u][0]+"'>"+consumables[u][1]  +"</option>");
							%>
                  </select></td>
                </tr>
                <tr>
                  <td height="17" class="boldEleven">Export File Type <span class="boldred">*</span></td>
                  <td colspan="2" align="left"><span class="boldEleven">
                     <%@include file="loadJasperReportType.jsp" %>
                  </span></td>
                </tr>
                 
                 
                <tr>
                  <td height="17" colspan="3" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                      <tr>
                        <td><input name="Submit" type="submit"
											class="buttonbold13" value="Submit"   accesskey="s"   ></td>
                        <td><input name="Close" type="button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="javascript:window.close()"></td>
                      </tr>
                  </table></td>
                </tr>
                <tr>
                  <td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                  <td colspan="2" align="left"><input name="filename"
									type="hidden" value="Rept_JConsaumableStockCount" />
                    <input name="actionS"
									type="hidden" value="INVRept_JConsaumableStockCount" />
                    <span class="boldEleven">
                    <input name="rptfilename" type="hidden" id="rptfilename" value="consumableStockCountDetail">
                    </span></td>
                </tr>
              </tbody>
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
</table>
</form><%@ include file="../footer.jsp"%>
</body>
</html>
