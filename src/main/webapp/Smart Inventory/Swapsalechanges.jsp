<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
 
String salesno=request.getParameter("salesno");
String sql = " SELECT a.CHR_SALESNO,DATE_FORMAT(a.DAT_SALESDATE,'%d-%m-%Y'),a.INT_CUSTOMERID,FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID), ";
sql = sql + " a.CHR_SHIPPINGADDRESS,a.CHR_REF,FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF),a.INT_DIVIID ,c.CHR_DIVICODE ,a.DAT_SALESDATE ,a.CHR_SHIPPING,a.CHR_OTHERREF,a.CHR_CONTACTNO,a.CHR_CONTACTDETAILS";
sql = sql + " FROM inv_t_directsales a, inv_m_customerinfo b, inv_m_division c ";
sql = sql + " WHERE a.INT_CUSTOMERID = b.INT_CUSTOMERID ";
sql = sql + " AND a.INT_DIVIID = c.INT_DIVIID ";
sql = sql + " AND a.CHR_SALESNO ='"+salesno+"'";
String data[][]=CommonFunctions.QueryExecute(sql);
String diff = CommonFunctions.QueryExecute(" SELECT (datediff(now(),'"+data[0][9]+"') <= INT_ME_NAME_CHANGE )  FROM m_inventorysetting WHERE INT_ROWID=1 ")[0][0];
boolean flag = true;
if("0".equals(diff))
	flag = false;
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
<script language="javascript" src="../JavaScript/Inventory/customeraddress.js"></script>
 

<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
<script>

$(function() {
		$( "#saledate" ).datepicker({
			minDate: -2, maxDate: "+7D" ,
			showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			buttonImageOnly: true
		});
	}); </script>
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">





 <script language="JavaScript">




function resoffval()
{
	
	if(document.frm.Shipping[0].checked==true)
	{
		
		document.getElementById('shippingaddress').disabled = true;
		document.getElementById("shippingaddress").style.visibility="hidden";
	}         
	else 
	{
		
		document.getElementById("shippingaddress").style.visibility="visible";
		document.getElementById('shippingaddress').disabled = false;
	}
	return true;
}//end of 
function Validate()
{
	try
	{	
		if(  
			checkNull( "saledate","Enter The sale date..." )  
			&& checkNullSelect( "customer","Select the customer...",'0' )  
			&& checkNull( "saledate","Enter The shipping address..."  )  
			&& checkNullSelect( "ref","Select the Reference...",'0' )  
			&& checkNullSelect( "division","Select the division ...",'0' )  
		  )
			return true;
		else
			return false;				
	}
	catch(err)
	{
		alert(err);
	}
 } 	
 
  

</script>
<body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
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
	 <form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm" onSubmit="return Validate()">
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
                <td colspan="4" class="bold1"><div align="center"><span class="boldThirteen">SWAP SALE CHANGE</span>
	
                  
                </div></td>
                </tr>
              <tr>
                <td class="boldEleven">Sale Date <font
									color="ff0000"> *</font></td>
                <td class="boldEleven"><%=data[0][1]%></td>
                <td class="boldEleven">Sale Date</td>
                <td class="boldEleven">
<input value="<%=data[0][1]%>"  readonly="readonly"  name="saledate" type="text" class="formText135" id="saledate" size="15" maxlength="10"> 
<span class="boldred">(dd-mm-yyyy) </span></td>
              </tr>
              <tr>
                <td class="boldEleven">Customer Name </td>
                <td class="boldEleven"><%=data[0][3]%></td>
                <td class="boldEleven">Customer Name </td>
                <td class="boldEleven">
				<select name="customer" id="customer" class="formText135" style="width: 150px"  onchange="loadAddress('customer','shippingaddress') ">  
				<jsp:include page="LoadCustomer.jsp" />
                </select>
<script language="javascript">setOptionValue('customer','<%=data[0][2]%>')</script>				</td>
              </tr>
              <tr>
                <td rowspan="2" class="boldEleven">Shipping Address </td>
                <td rowspan="2" class="boldEleven"><%=data[0][4]%></td>
                <td rowspan="2" align="left" valign="top" class="boldEleven">Shipping Address 
				<%
				String ss="";
				String ss1="";
				if("D".equals(data[0][10]))
					ss = " checked='checked' " ;
				
				if("S".equals(data[0][10]))
					ss1 = " checked='checked' " ;
					
				%>				</td>
                <td class="boldEleven"><table width="141" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td ><input name="Shipping" type="radio" value="S"  onClick="return resoffval()"  <%=ss%> /></td>
                    <td class="boldEleven">Same</td>
                    <td class="boldEleven"><input  name="Shipping" type="radio" value="D" onClick="return resoffval()"  checked="checked"  <%=ss1%> /></td>
                    <td class="boldEleven">Different                       </td>
                  </tr>
                </table></td>
              </tr>
              <tr>
                <td class="boldEleven"><textarea name="shippingaddress"
										cols="40" rows="7" class="formText135" id="shippingaddress"><%=data[0][4]%></textarea></td>
              </tr>
              <tr>
                <td width="24%" class="boldEleven">M.E Name </td>
                <td width="20%" class="boldEleven"><%=data[0][6]%> </td>
                <td width="6%" class="boldEleven">M.E Name </td>
                <td width="50%" class="boldEleven">
				<select name="ref" id="ref"	class="formText135" size="5" style="width:200">
				<option value="0">Select M.E Name</option>
										<jsp:include page="Staffload.jsp" flush="true" />
									</select>
									<script language="javascript">setOptionValue('ref','<%=data[0][5]%>')</script>					</td>
              </tr>
              <tr>
                <td class="boldEleven">Division</td>
                <td class="boldEleven"><%=data[0][8]%></td>
                <td class="boldEleven">Division</td>
                <td class="boldEleven"><select
										name="division" class="formText135" id="division" tabindex="1" onChange="">
                 <option value="0">Select Division</option>
                  <%
								String division[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division   WHERE INT_DIVIID >0 AND CHR_OFFICEIDS LIKE '%"+session.getAttribute("INVOFFICEID")+"%'  ORDER BY CHR_DIVICODE"); 
								for(int u=0; u<division.length; u++)
									out.print("<option value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
							%>
                </select>
				<script language="javascript">setOptionValue('division','<%=data[0][7]%>')</script>				</td>
              </tr>
              <tr>
                <td class="boldEleven">Order Reference</td>
                <td class="boldEleven"><%=data[0][11]%></td>
                <td class="boldEleven"><div align="left">Order Reference<span class="ui-state-error-text">* </span></div></td>
                <td class="boldEleven"><div align="left">
                    <input name="oref" type="text"
										class="formText135" id="oref"     onBlur="upperMe(this)"      value="<%=data[0][11]%>" size="34" maxlength="50"
										 />
                </div></td>
              </tr>
              <tr>
                <td class="boldEleven"> Contact Person</td>
                <td class="boldEleven"><%=data[0][13]%></td>
                <td class="boldEleven">Contact Person <span class="ui-state-error-text">* </span></td>
                <td class="boldEleven"><input name="cdetails" type="text"
										class="formText135" id="cdetails"
										    onBlur="upperMe(this)"    value="<%=data[0][13]%>"  size="31" maxlength="100" /></td>
              </tr>
              <tr>
                <td class="boldEleven">Contact No.</td>
                <td class="boldEleven"><%=data[0][12]%></td>
                <td class="boldEleven"><div align="left">Contact No.<span class="ui-state-error-text">* </span></div></td>
                <td class="boldEleven"><div align="left">
                    <input name="cnumber" type="text"
										class="formText135" id="cnumber" onKeyPress="return numeric_only(event,'cnumber','15')" value="<%=data[0][12]%>" size="34" maxlength="14"/>
                </div></td>
              </tr>
              <tr>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">
				<input type="hidden" name="filename" value="SwapSale" />
				<input type="hidden" name="actionS"  value="INVSwapSaleChanges" />
				<input name="salesno" type="HIDDEN" id="salesno" value="<%=salesno%>">				 </td>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">&nbsp;</td>
              </tr>
              <tr>
                <td colspan="4" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                  <tr>
                    <td>
<%
if(flag)
	out.println("<input name='Submit' id='Submit' type='submit' 	class='buttonbold13' value='Update'>");
else
	out.println("<font class='bolddeepred'>Changes not applicable... </font>");
%>					</td>
                    <td><input name="Close" type="button"   class="buttonbold13" id="Close"  value="Close"   accesskey="c"  	onClick="javascript:window.close()"></td>
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
	System.out.println(e.getMessage());
}
%>
</body>
</html>
