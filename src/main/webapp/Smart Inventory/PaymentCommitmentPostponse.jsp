<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>:: INVENTORY  ::</title>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>

<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
<script>
	 
	$(function() {
		$( "#ppdate" ).datepicker({ minDate: -0, maxDate: "+60D" });
	});
	 
	 


	</script>

<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">




<body >
<p>&nbsp;</p>
<p>&nbsp;</p>
<table class="BackGround1" cellspacing="0" cellpadding="0" width="424"
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
      <td width="412">
	  <form  autocomplete = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm" onsubmit="return Validate()">
        <table cellspacing="2" cellpadding="2" width="700" align="center"
						border="0">
          <!--DWLayoutTable-->
          <tbody>
            <tr>
              <td height="16" align="center" valign="top" class="boldThirteen"> Payment Commitment Postpone
                 <%
				 	String rowid = request.getParameter("rowid");
					String sql="";
					sql=" SELECT INT_PAYMENTCOMMITMENTID, CHR_SALESNO,CHR_INVOICETYPE,DATE_FORMAT(DT_COMMITMENTDATE,'%d-%m-%Y'),DOU_COMMITMENTAMOUNT ";
					sql = sql + "  FROM inv_t_paymentcommitment  WHERE INT_PAYMENTCOMMITMENTID= "+rowid;
					String data[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				 %>
                </td>
            </tr>
            <tr>
              <td height="19" align="right" valign="top"><span
									class="bolddeepred"> </span><span class="fairyHead"></span></td>
            </tr>
            <tr>
              <td height="17" class="boldEleven"><table width="100%" border="0" cellspacing="2" cellpadding="2">
                <tr>
                  <td><strong>Invoice Number </strong></td>
                  <td><%=data[0][1]%></td>
                  <td><strong>Sales Type</strong></td>
                  <td>
				  <%
				  if("C".equals(data[0][2]))
				out.println("Customer Sales");
			else if("D".equals(data[0][2]))
				out.println("Direct Sales");
			else if("S".equals(data[0][2]))
				out.println("Service Billing");
				  %>
				  </td>
                </tr>
                <tr>
                  <td><strong>Commitment Date </strong></td>
                  <td><%=data[0][3]%> <input name="cdate" type="hidden" id="cdate" value="<%=data[0][3]%>" /></td>
                  <td><strong>Postpone Date 
                    <input name="filename" type="hidden" value="PaymentCommitment" />
                    <input
			name="actionS" type="hidden" value="INVPaymentCommitmentPostpone" />
</strong></td>
                  <td><input name="ppdate" type="text" class="formText135" id="ppdate" readonly="true" onKeyPress="dateOnly(this)" size="20" maxlength="12" value="<%=data[0][3]%>"   /> 
				  <!--<a href="javascript:cal1.popup();"> <img src="../JavaScript/img/cal.gif" width="16" height="16" border="0" /> </a> -->
				  <script language='JavaScript' type="text/javascript">
					<!--			
						var cal1 = new calendar1(document.forms['frm'].elements['ppdate']);
						cal1.year_scroll = true;
						cal1.time_comp = false;
						  
					//-->
                </script> 
				  (dd-mm-yyyy)				  </td>
                </tr>
                <tr>
                  <td><strong>Commitment Amount </strong></td>
                  <td><%=data[0][4]%>
                     <input name="rowid" type="hidden" id="rowid" value="<%=rowid%>" /></td>
                  <td><strong>Commitment Amount </strong></td>
                  <td><input name="ppamount" type="text" class="formText135" value="<%=data[0][4]%>" id="ppamount"  onkeypress= "doubleValue('ppamount','15') " size="20" maxlength="12" /></td>
                </tr>
              </table></td>
            </tr>
            <tr>
              <td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp; </td>
            </tr>
            <tr>
              <td height="17" class="boldEleven"><table border="0" align="center" cellpadding="1" cellspacing="1">
                <tr>
                  <td width="56"><input name="Submit" type="submit" class="buttonbold13" value="Submit"   accesskey="s"    /></td>
                   
                </tr>
              </table></td>
            </tr>
          </tbody>
          <input type="hidden" name="mobileBookingOption" />
        </table>
      </form></td>
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
<script language="javascript">
function Validate()
{
	
	 
	if( 
			DateCompares('cdate','ppdate' ," Postpone Date Cannot be Greater Than Commitment date...")   
			&& checkNull("ppamount","Enter PostponeAmount...")
	)
			return true;
		else
			return false;
}

</script>
</body>
</html>
