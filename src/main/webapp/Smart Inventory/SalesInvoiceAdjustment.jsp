 <%@ page import="java.io.*,java.util.*"%>
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
%>
<html>
<head>
<title>:: INVENTORY ::</title><link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
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
<script language="javascript" src="../JavaScript/Numericfunctions.js"></script>

<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">

<link href="../JavaScript/SmartStyles.css" rel="stylesheet" type="text/css" />
 
<script language="JavaScript">

function Validate()
  {
	if(  
	
		checkNull( "Paid1","Enter Installation Amount.." )
		&& checkNull( "Paid2","Enter Logistics  Amount.." )
		&& checkNull( "Paid3","Enter ORC  Amount.." )
		&& checkNull( "Paid4","Enter Others  Amount.." )
	
	)
		return true;
	else
		return false;				
		
 } 	
</script>

<body >
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth" onSubmit="return Validate()">
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td> </td>
	</tr>
	<tr>    </tr>
	<tr>
	  <td>&nbsp;</td>
    </tr>
	<tr>
	  <td>&nbsp;</td>
    </tr>
	<tr>
	  <td><table width="350" border="0"
			align="center" cellpadding="0" cellspacing="0" class="BackGround1">
        <tbody>
          <tr>
            <td colspan="2" rowspan="2" valign="top"><img
						src="../Image/Smart Inventory/TLCorner.gif" alt="left" width="7" height="7" /></td>
            <td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
            <td colspan="2" rowspan="2" valign="top"><img
						src="../Image/Smart Inventory/TRCorner.gif" alt="right" width="7" height="7" /></td>
          </tr>
          <tr>
            <td height="6"><spacer height="1" width="1" type="block" /></td>
          </tr>
          <tr>
            <td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
            <td width="6"><spacer height="1" width="1" type="block" /></td>
            <td width="410"><table cellspacing="2" cellpadding="2" width="100%" align="center"
						border="0">
                <!--DWLayoutTable-->
                <tbody>
                  <tr>
                    <td height="19" colspan="2" align="right" valign="top"><div align="center"><strong>INVOICE ADDITIONAL CHARGES </strong><span class="boldEleven">
                        <%
				String branchid=""+session.getAttribute("BRANCHID");
				String usertype=""+session.getAttribute("USRTYPE");
				String user= ""+session.getAttribute("USRID"); 
				String salno = request.getParameter("salno");
				String Billinttype = request.getParameter("Billinttype");
				
				String sql="";
				sql=" SELECT DOU_INSTALLAMOUNT, DOU_LOGISTICAMOUNT, DOU_ORCAMOUNT, DOU_OTHERSAMOUNT";
				sql = sql + "  FROM inv_t_directsales  WHERE CHR_SALESNO='"+salno+"'";
				String data[][] = CommonFunctions.QueryExecute(sql);
				 
	 
				%>
				<input name="filename" type="hidden" value="SwapSale" /> 
				<input name="actionS" type="hidden" value="INVSwapSaleAdjustment" />
                    </span>
                        <input name="salno" type="hidden" id="salno" value="<%=salno%>">
                    </div></td>
                  </tr>
                  <tr>
                    <td width="156"  class="boldEleven">Installation <span class="boldred">*</span></td>
                    <td width="216"  align="left"><span class="boldEleven">
                      <input name="Paid1" size="30" type="text" class="formText135" value="<%=data[0][0]%>" id="Paid1" maxlength="15" onKeyUp="extractNumber(this,2,true);" onKeyPress="return blockNonNumbers(this, event, true, true);"
									   >
                    </span></td>
                  </tr>
                  <tr>
                    <td  class="boldEleven">Logistics <span class="boldred">*</span></td>
                    <td  align="left"><span class="boldEleven">
                      <input name="Paid2" size="30" type="text" class="formText135" value="<%=data[0][1]%>" id="Paid2" maxlength="15" onKeyUp="extractNumber(this,2,true);" onKeyPress="return blockNonNumbers(this, event, true, true);"
									   >
                    </span></td>
                  </tr>
                  <tr>
                    <td height="17" class="boldEleven">ORC <span class="boldred">*</span></td>
                    <td   align="left"><span class="boldEleven">
                      <input name="Paid3" size="30" type="text" class="formText135" value="<%=data[0][2]%>" id="Paid3" maxlength="15" onKeyUp="extractNumber(this,2,true);" onKeyPress="return blockNonNumbers(this, event, true, true);"
									   >
                    </span></td>
                  </tr>
                  <tr>
                    <td height="17" class="boldEleven">Others <span class="boldred">*</span></td>
                    <td   align="left"><span class="boldEleven">
                      <input name="Paid4" size="30" type="text" value="<%=data[0][3]%>" class="formText135" id="Paid4" maxlength="15" onKeyUp="extractNumber(this,2,true);" onKeyPress="return blockNonNumbers(this, event, true, true);"
									   >
                    </span></td>
                  </tr>
                  <tr>
                    <td height="19" colspan="2" align="right" valign="top"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                        <tr>
                          <td><input name="Submit" type="submit"
											class="buttonbold13" value="Submit"   accesskey="s"   ></td>
                          <td><input name="Close" type="button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="redirect('SwapSale.jsp')"></td>
                        </tr>
                    </table></td>
                  </tr>
                  <tr>
                    <td height="19" align="right" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                    <td align="right" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                  </tr>
                </tbody>
                <input type="hidden" name="mobileBookingOption" />
            </table></td>
            <td nowrap="nowrap" width="6"><spacer height="1" width="1"
						type="block" /></td>
            <td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
          </tr>
          <tr>
            <td colspan="2" rowspan="2"><img
						src="../Image/Smart Inventory/BLCorner.gif" alt="left" width="7" height="7" /></td>
            <td height="6"><spacer height="1" width="1" type="block" /></td>
            <td colspan="2" rowspan="2"><img
						src="../Image/Smart Inventory/BRCorner.gif" alt="right" width="7" height="7" /></td>
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
</table>
<p>
  <script language="JavaScript">

 
  </script> 
  <%@ include file="../footer.jsp"%>
</form>
  
  <%
  }
catch(Exception e)
{
	out.println(e.getMessage());
	System.out.println(e.getMessage());
}

  %>
</p>
<p>&nbsp;</p>
<p>
   
</p>
<p>
  
</p>
</body>
</html>
