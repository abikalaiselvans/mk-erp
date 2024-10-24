<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
String sql="";
sql = sql + " SELECT   ";
sql = sql + " CONCAT(MKT_FUN_GET_STAGENAME(a.INT_PERCENTAGE) , ' ( ',a.INT_PERCENTAGE,'% )') stage, ";
sql = sql + " ROUND(SUM(b.DOU_TOTAL),2) "; ///100000
sql = sql + " FROM mkt_t_daillycalls a ,mkt_t_quotationitem b, mkt_t_quotation c  ";
sql = sql + " WHERE  a.INT_CALLID >0  AND a.CHR_QUOTATION = b.CHR_QUOTATIONNO  AND b.CHR_QUOTATIONNO = c.CHR_QUOTATIONNO  ";
sql = sql + " AND  a.CHR_ADDEDTO_FUNNEL ='Y'  AND a.CHR_STATUS ='N'  ";
sql = sql + " GROUP BY a.INT_PERCENTAGE ";
sql = sql + " ORDER BY a.INT_PERCENTAGE  ";
//out.println(sql);
String edata[][] = CommonFunctions.QueryExecute(sql);
String labels ="";
String values ="";
if(edata.length>0)
{
	for(int u=0;u<edata.length;u++)
	{
		labels = labels +"\""+edata[u][0] +"\",";
		values = values +edata[u][1] +",";
	}
	labels=labels.trim();
	labels = labels.substring(0,labels.length()-1);
	
	values=values.trim();
	values = values.substring(0,values.length()-1);
}
%>
<html>
<head>
<title> :: MARKETING ::</title> 
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
 <style type="text/css">
 @import url("../JavaScript/SmartStyles.css");
 </style>
</head>
 <script language="javascript" src="../JavaScript/comfunction.js"></script>
 <script src="Chart.js"></script> 
 
<body onselectstart="return false" onpaste="return false;" onCopy="return false"    leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  >
<%@ include file="index.jsp"%>
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
    <td>
    
    
     <center>
    <div style="width: 50%">
			<canvas id="canvas" height="450" width="600"></canvas>
		</div>
</center>
 
<script>
	var randomScalingFactor = function(){ return Math.round(Math.random()*100)};

	var barChartData = {
		labels : [<%=labels%>],
		datasets : [
			{
				fillColor : "#99cc00" ,
				data : [<%=values%>]
				
				
				 
			}
		]

	}
	window.onload = function(){
		var ctx = document.getElementById("canvas").getContext("2d");
		window.myBar = new Chart(ctx).Bar(barChartData, {
			responsive : true
		});
	}

	</script>
    </td>
  </tr>
  <tr>
    <td>&nbsp;
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
  <tr>
    <td><table width="60" border="0" align="center" cellpadding="1" cellspacing="1">
      <tr>
        <td><input name="Close" type="button"   class="tMLAscreenHead" id="Close"  value="Close"   accesskey="c"  onClick="redirect('MarketingMain.jsp')"></td>
      </tr>
    </table></td>
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
