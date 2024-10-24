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
.suggestionList {	margin: 0px;
	padding: 0px;
}
.suggestionsBox {	position: relative;
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
 
<script language="JavaScript" src="../JavaScript/Inventory/SerialnoloadAjax.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">
function validate()
{
	if(
		checkNull('ename','Select Staff name') 
		&& checkNull('SerialNumber','Select Asset Serial Number') 
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
            <td width="412"> 
			
			<table width="465" height="162" border="0" align="center">
              <tr>
                <td colspan="4"><div align="center"><span class="boldThirteen">ASSET IMFORMATIONS</span></div></td>
              </tr>
              <tr>
                <td height="20" colspan="4" align="center" valign="top">&nbsp;</td>
              </tr>
              <tr>
                <td height="20" colspan="4" align="center" valign="top"> 
                  <%
 
String sql="";
sql = sql+ "  SELECT   ";
sql = sql+ "  if(a.CHR_TYPE='I','Item','Product'),    ";
sql = sql+ "  if(a.CHR_TYPE='I',     ";
sql = sql+ "  (SELECT d.CHR_ITEMNAME FROM inv_m_item d WHERE d.CHR_ITEMID=a.CHR_ITEMID)    ";
sql = sql+ "  ,    ";
sql = sql+ "  (SELECT e.CHR_PRODUCTCODE  FROM inv_m_produtlist  e WHERE e.CHR_PRODUCTID=a.CHR_ITEMID)   ";
sql = sql+ "  ),    ";  
sql = sql+ "  a.CHR_SERIALNO,   "; 
sql = sql+ "  DATE_FORMAT(a.DAT_CREATIONDATE,'%d-%b-%Y'), a.CHR_STATUS     ";
sql = sql+ "  FROM inv_t_asset a,com_m_staff b,inv_t_vendorgoodsreceived c    ";
sql = sql+ "  WHERE a.CHR_EMPID=b.CHR_EMPID   "; 
sql = sql+ "  AND a.CHR_ITEMID = c.CHR_ITEMID    ";
sql = sql+ "  AND a.CHR_SERIALNO =c.CHR_SERIALNO    ";
sql = sql+ "  AND a.CHR_EMPID ='"+session.getAttribute("EMPID")+"'   ";
//out.println(sql);
String Data[][] = CommonFunctions.QueryExecute(sql);
if (Data.length > 0)
{
	 
	out.println("<center>");
	out.println("<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
	out.println("<tr class='MRow1'>");
	out.println("<td class='boldEleven' align='center'><b>S.No</b></td>");
	out.println("<td class='boldEleven' align='center'><b>Type</b></td>");
	out.println("<td class='boldEleven' align='center'><b>Product Code</b></td>");
	out.println("<td class='boldEleven' align='center'><b>Serial Number</b></td>");
	out.println("<td class='boldEleven' align='center'><b>Date</b></td>");
	out.println("<td class='boldEleven' align='center'><b>Status</b></td>");
	out.println("</tr>");
	for(int i=0;i<Data.length;i++)
	{ 
		if(i%2==0)
			out.println("<tr class='MRow1'>");
		else
			out.println("<tr class='MRow2'>");	
			
		out.println("<td class='boldEleven'  >"+(i+1)+"</td>");
		out.println("<td class='boldEleven'  >"+Data[i][0]+"</td>");
		out.println("<td class='boldEleven'  >"+Data[i][1]+"</td>");
		out.println("<td class='boldEleven'  >"+Data[i][2]+"</td>");
		out.println("<td class='boldEleven'  >"+Data[i][3]+"</td>");
		if("Y".equals(Data[i][4]))
			out.println("<td class='boldEleven'  ><font class='boldgreen'>Returned</font></td>");
		else
			out.println("<td class='boldEleven'  ><font class='bolddeepred'>Not return</font></td>");	
			
		out.println("</tr>");	 
			
	}
	out.println("</table>");
	out.println("<center>");
}

 
	 
%>
              </td>
              </tr>
               
               
              <tr>
                <td height="20" colspan="4" align="center" valign="top" class="boldEleven">&nbsp;</td>
                </tr>
              <tr>
                <td height="21" class="boldEleven">&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp; 
                    </td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td height="36" colspan="4"><table border="0" align="center" cellpadding="2"
										cellspacing="2">
                    <tr>
                       
                      <td width="56">
                      <input type="button" name="submit" class="buttonbold"  value="Close"   accesskey="c"  onClick="redirect( 'InventoryMains.jsp')" /></td>
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
