<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%
try
{
%>
<html>
<head>

<title>:: ACCOUNTS ::</title>

 
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
</head>
<script language="JavaScript" src="../JavaScript/calendar1.js" type="text/javascript"></script>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript">

function Validate()
  {
	
 
	
	if(checkNull("Openingbalance","Enter the Openning Balance")
	&& checkNull( "OpenningOutstanding","Enter the Openning Out Standing" )
	&& checkNullSelect("Financialyear","Select Financialyear","0")

	
	)
		return true;
	else
		return false;				
		
	
 } 	
</script>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<%@ include file="indexacct.jsp"%>
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
    <td><table class="BackGround1" cellspacing="0" cellpadding="0"
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
		  <form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm" onSubmit="return Validate()">
		    <table width="700" border="0" align="center" cellpadding="3" cellspacing="3">
              <tr>
                <td colspan="4" class="bold1"><div align="center">SETTING <span class="boldEleven">
                  <input type="hidden" name="filename" value="Setting" />
                  <input type="hidden" name="actionS" value="ACCSettingUpdate" />
                </span></div></td>
                </tr>
              <tr>
                <td width="23%" class="boldEleven">Opening Balance  </td>
                <td width="12%" class="boldEleven"><input name="Openingbalance" type="text" class="formText135" id="Openingbalance" size="12" maxlength="12" style='text-align:right' onKeyPress="doubleValue('Openingbalance','12')"></td>
                <td width="31%" class="boldEleven">Currency Symbol </td>
                <td width="34%" class="boldEleven"><input name="textfield" type="text" class="formText135" value="Rs." size="10" maxlength="3"> 
                  (Rs.) </td>
              </tr>
              <tr>
                <td class="boldEleven">Opening Outstanding  </td>
                <td class="boldEleven"><input name="OpenningOutstanding" type="text" class="formText135" id="OpenningOutstanding" size="12" maxlength="12" style='text-align:right' onKeyPress="doubleValue('OpenningOutstanding','12')"></td>
                <td class="boldEleven">Currency String </td>
                <td class="boldEleven"><input name="textfield2" type="text" class="formText135" value="Rupees." size="10" maxlength="15">
                  (Rupees.)</td>
              </tr>
             <tr>
                <td class="boldEleven">Financial Year</td>
                <td class="boldEleven">
				<select name="Financialyear" id="Financialyear">
	<%
		String CurrentFinancialYear = com.my.org.erp.common.CommonFunctions.CurrentFinancialYear();
		String ydata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_FINANCIALYEARID,CHR_FINANCIALYEAR FROM  com_m_financialyear ORDER BY INT_FINANCIALYEARID");
		for(int u=0;u<ydata.length;u++)
			if(CurrentFinancialYear.equals(ydata[u][1]))
				out.println("<option selected='selected' value='"+ydata[u][0]+"'>"+ydata[u][1]+"</option>");
			else
				out.println("<option   value='"+ydata[u][0]+"'>"+ydata[u][1]+"</option>");	
			
	%>
    </select>				</td>
                <td class="boldEleven">Currency Sub Strring </td>
                <td class="boldEleven"><input name="textfield3" type="text" class="formText135" value="Paissa" size="10" maxlength="15">
                  (Paissa)</td>
             </tr>
              <tr>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">Date format </td>
                <td class="boldEleven"><input name="textfield4" type="text" class="formText135" value="dd-mm-yyyy" size="20" maxlength="15">
                  (dd-mm-yyyy)</td>
              </tr>
              <tr>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">Date separator </td>
                <td class="boldEleven"><input name="textfield5" type="text" class="formText135" value="-" size="10" maxlength="3">
                  (-)</td>
              </tr>
              <tr>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">Currency decimal places </td>
                <td class="boldEleven"><input name="textfield6" type="text" class="formText135" value="2" size="10" maxlength="3">
                  (2)</td>
              </tr>
              <tr>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">&nbsp;</td>
              </tr>
              <tr>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">&nbsp;</td>
              </tr>
              <tr>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">&nbsp;</td>
              </tr>
              <tr>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">&nbsp;</td>
              </tr>
              <tr>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">&nbsp;</td>
              </tr>
              <tr>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">&nbsp;</td>
              </tr>
              <tr>
                <td colspan="4" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                  <tr>
                    <td><input name="Submit" type="submit"
											class="buttonbold13" value="Submit"   accesskey="s"   ></td>
                    <td><input name="Close" type="button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="redirect('Group.jsp')"></td>
                  </tr>
                </table></td>
                </tr>
            </table>
		  </form></td>
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
</table>
<%@ include file="../footer.jsp"%>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>
</body>
</html>
