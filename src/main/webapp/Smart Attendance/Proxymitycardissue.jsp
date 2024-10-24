<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%@ page import="com.my.org.erp.common.*, com.my.org.erp.ServiceLogin.*"%>
<%
try
{
%>
<html>
<head>

<title> :: ATTENDANCE ::</title>


 
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

</head>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/ComAJAX.js"></script>
<script src="../JavaScript/common/StaffloadAjax.js"></script>

<script language="javascript">
 function Validate()
  {
  	if(checkNull("ename","Select Staff")
	&& checkNull("cardno","Enter Card Number")
	)
	{
		return true;
	}	
	else
		return false;
  }
  
</script>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="init()">
<%@ include file="index.jsp"%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>
	
	<form  AUTOCOMPLETE = "off" name="frm" method="post" onSubmit="return Validate()" action="../SmartLoginAuth"   >
	<table class="BackGround" cellspacing="0" cellpadding="0" width="390"
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
          <td width="412"><table width="400" height="155" border="0" align="center"
						  class="bolddeepblue">
              <!--DWLayoutTable-->
              <tr align="center" valign="middle">
                <td width="390" height="28" colspan="3" align="center"
								valign="middle" class="boldgre"><div align="center">PROXYMITY CARD ISSUE </div></td>
              </tr>
              <tr align="center" valign="middle">
                <td height="29" colspan="3" valign="middle" class="BackGround"
								 ><%@ include file="../JavaScript/ajax.jsp"%>
                  &nbsp;</td>
              </tr>
              <tr>
                <td height="28" valign="middle" class="bolddeepblue"><table width="92%" border="0" align="center" cellpadding="3"
								cellspacing="2">
                    <tr>
                      <td width="45%" class="boldEleven"><span class="style13">Proximity Card Number <font color='red'>*</font> </span></td>
                      <td width="55%" class="boldEleven"> 
					  <input type="hidden" name="filename" id="filename" value="ProxymityCard" />
                        <input type="hidden" name="actionS" id="actionS" value="ATTProxymityCardADD" />
                        <input name="cardno" type="text" class="formText135" id="cardno" maxlength="10" onKeyUp=" CheckUnique(this,'divunitname','att_m_proximitycardno','CHR_CARDNO')"  >
                        <div id="divunitname"/>                        </td>
                      </tr>

                </table></td>
              </tr>
              <tr>
                <td height="29" valign="middle" class="bolddeepblue">
				<%
					String msg = ""+request.getParameter("msg");
					if(msg.length() >5)
						out.println("<center><font class='bolddeepred'>"+msg+"</font></center>");
				%>
				</td>
              </tr>
              <tr>
                <td height="29" valign="middle" class="bolddeepblue"><table border="0" align="center" cellpadding="3" cellspacing="3">
                    <tr>
                      <td width="56">
					  <input id="Submit"  name="Submit" type="submit" class="buttonbold13" value="Submit"   accesskey="s"   >					  </td>
                      <td width="56">
  <input name="Button" type="Button" class="buttonbold13"  value="Close"   accesskey="c" 	onClick="redirect('ProximityView.jsp')">  </td>                    </tr>
                </table></td>
              </tr>
          </table></td>
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
</table>

<%@ include file="../footer.jsp"%>
</body>
</html>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
	System.out.println(e.getMessage());
}

%>
