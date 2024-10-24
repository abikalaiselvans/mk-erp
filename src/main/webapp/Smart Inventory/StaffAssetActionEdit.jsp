<%@ page import="java.io.*,java.util.*"%>
<%@ page import="sun.net.smtp.SmtpClient"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>

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

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



<style type="text/css">
<!--
.suggestionList1 {margin: 0px;
	padding: 0px;
}
.suggestionList1 {	margin: 0px;
	padding: 0px;
}
.suggestionsBox1 {position: relative;
	margin: 0px 0px 0px 0px;
	width: 200px;
	background-color: #ffffff;
	-moz-border-radius: 7px;
	-webkit-border-radius: 7px;
	border: 1px solid #000;
	color: #000;
}
.suggestionsBox1 {	position: relative;
	margin: 0px 0px 0px 0px;
	width: 200px;
	background-color: #ffffff;
	-moz-border-radius: 7px;
	-webkit-border-radius: 7px;
	border: 1px solid #000;
	color: #000;
}
-->
</style>
</head>

<script language="JavaScript" src="../JavaScript/calendar1.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/Inventory/SerialnoloadAjax.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">
function validate()
{
	if(
		checkNull('SerialNumber','Select Asset Serial Number') 
		&& checkNull('Descrip','Enter Description') 
		&& checkNullSelect('Approvedby','Select ApprovedBy','0') 
	)
		return true;
	else
		return false;
		

}
</script>



<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>

<script type="text/javascript">
function lookup(SerialNumber) 
{
	if(SerialNumber.length == 0) 
	{
		$('#suggestions').hide();
	} 
	else 
	{
		$.post("assetserialnumberget.jsp", {queryString: ""+SerialNumber+""}, function(data)
		{
			if(data.length >0) 
			{
				$('#suggestions').show();
				$('#autoSuggestionsList').html(data);
			}
		});
	}
}

function fill(thisValue) 
{
	document.getElementById('SerialNumber').value=thisValue;
	$('#SerialNumber').val(thisValue);
	setTimeout("$('#suggestions').hide();", 200);
}
</script>
<style type="text/css">
body {
font-family: Helvetica;
font-size: 13px;
color: #000;
}
h3 {
margin: 0px;
padding: 0px;
}


.suggestionsBox 
{
	position: relative;
	margin: 0px 0px 0px 0px;
	width: 200px;
	background-color: #ffffff;
	-moz-border-radius: 7px;
	-webkit-border-radius: 7px;
	border: 1px solid #000;
	color: #000;
}
.suggestionList 
{
	margin: 0px;
	padding: 0px;
}
.suggestionList li 
{
	margin: 0px 0px 3px 0px;
	padding: 1px;
	cursor: pointer;
}

.suggestionList li:hover {
background-color: #99cc99;
}
</style>



<body onLoad="">
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
    <td><form  AUTOCOMPLETE = "off"   name="form1" method="post" action="../SmartLoginAuth" onSubmit=" return validate()">
    
      <table class="BackGround1" cellspacing="0" cellpadding="0" width="400"
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
            <td width="412"> <table width="95%" border="0" align="center">
              <tr>
                <td colspan="3" class="boldEleven"><div align="center"><strong>ASSET</strong>
                        <%
String Rowid = request.getParameter("Rowid");
String sql="SELECT CHR_ITEMID,CHR_SERIALNO,CHR_DESCRIPTION,CHR_AUTHORISEDBY,CHR_EMPID  ";
sql = sql+" FROM inv_t_asset  WHERE  INT_ASSETID="+Rowid+"";
String data[][]= CommonFunctions.QueryExecute(sql);
String Empid =data[0][4];
%>
                </div></td>
              </tr>
              <tr>
                <td class="boldEleven">&nbsp;</td>
                <td>&nbsp;</td>
                <td class="boldEleven" align="center">&nbsp;</td>
              </tr>
              <tr>
                <td width="4" class="boldEleven">&nbsp;</td>
                <td colspan="2" class="bold1">&nbsp;</td>
              </tr>
              <tr>
                <td width="4" class="boldEleven" align="center">&nbsp;</td>
                <td width="81"><span class="boldEleven">EmpId</span></td>
                <td width="268" class="boldEleven" align="center"><span class="bold1"><%=CommonFunctions.QueryExecute("SELECT FIND_A_EMPLOYEE_ID_NAME('"+Empid+"') " )[0][0]%></span></td>
              </tr>
              <tr>
                <td align="left" valign="top" class="boldEleven">&nbsp;</td>
                <td align="left" valign="top" ><span class="boldEleven"> <span class="bolddeepred"></span></span></td>
                <td align="left" valign="top">&nbsp;</td>
              </tr>
              <tr>
                <td align="left" valign="top" class="boldEleven">&nbsp;</td>
                <td align="left" valign="top" ><span class="boldEleven">Serial
                  Number <span class="bolddeepred">* </span></span></td>
                <td align="left" valign="top"><input name="SerialNumber" type="text" class="formText135" id="SerialNumber" tabindex="2" onBlur="fill();"   onkeyup="upperMe(this),lookup(this.value);" value="<%=data[0][1]%>" size="35" maxlength="50">
                    <br>
                    <div class="suggestionsBox" id="suggestions" style="display: none;">
                      <div class="suggestionList" id="autoSuggestionsList" style="OVERFLOW:auto;width:100%;height:100px" ></div>
                    </div></td>
              </tr>
              <tr>
                <td align="left" valign="top" class="boldEleven">&nbsp;</td>
                <td align="left" valign="top" ><span class="boldEleven">Description <span class="bolddeepred">*</span></span></td>
                <td align="left" valign="top"><textarea type="text" name="Descrip"   cols="50" id="Descrip" rows="5" class="formText135" onKeyUp="textArea('Descrip','500')" ><%=data[0][2]%></textarea></td>
              </tr>
              <tr>
                <td align="left" valign="top" class="boldEleven">&nbsp;</td>
                <td align="left" valign="top"><span class="boldEleven">ApprovedBy <span class="bolddeepred">*</span></span></td>
                <td align="left" valign="top"><select name="Approvedby" class="formText135" id="Approvedby" style="width:170" >
                    <option value='0'>Select Authoraised by</option>
                    <%
	String Approved[][] =  CommonFunctions.QueryExecute(" SELECT CHR_EMPID,CHR_STAFFNAME FROM com_m_staff WHERE   CHR_TYPE != 'T' AND CHR_REP='Y'");
 if(Approved.length>0)
 	for(int u=0;u<Approved.length;u++)
		out.println("<option value='"+Approved[u][0]+"'>"+Approved[u][0] +  " / " +Approved[u][1]+"</option>");
 %>
                  </select>
                    <script language="javascript">setOptionValue('Approvedby','<%=data[0][3]%>')</script></td>
              </tr>
              <tr>
                <td class="boldEleven">&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td><input type="hidden" name="actionS" value="INVStaffAssetEdit"/>
                    <input type="hidden" name="filename" value="StaffAsset" />
                    <input type="hidden" name="Empid" id="Empid" value="<%=Empid%>" readonly>
                    <input name="Rowid" type="hidden" id="Rowid" value="<%=Rowid%>">
                    <input name="oldserial" type="hidden" id="oldserial" value="<%=data[0][1]%>"></td>
              </tr>
              <tr>
                <td colspan="3"><table border="0" align="center" cellpadding="2"
										cellspacing="2">
                    <tr>
                      <td width="56"><input type="submit" name="Submit"	id="submit_btn" class="buttonbold" value="Submit"   accesskey="s"    /></td>
                      <td width="56"><input type="button" name="submit" class="buttonbold"  value="Close"   accesskey="c" 	onClick="redirect('StaffAsset.jsp')" /></td>
                    </tr>
                </table></td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
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
