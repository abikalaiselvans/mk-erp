<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
String sql="";
sql = " SELECT  INT_PERCENTAGE , CHR_STAGENAME FROM mkt_m_stage ORDER BY  CHR_STAGENAME ";
String pdata[][] = CommonFunctions.QueryExecute(sql);
String mname = "'January','February','March','April','May','June','July','August','September','October','November','December' ";
String monthname[] = mname.split(",");
String datasets="";
String datasetsvalues="";
if(pdata.length>0)
{
	for(int u=0;u<pdata.length;u++)
	{
		datasetsvalues="";
		for(int v=0;v<monthname.length;v++)
		{
			sql =  " SELECT MONTHNAME(a.DAT_START ),COUNT(*)   ";
			sql = sql + " FROM mkt_t_daillycalls a    ";
			sql = sql + "  WHERE a.INT_CALLID >0    ";
			sql = sql + "  AND  a.CHR_STATUS ='Y'    AND a.CHR_RESCHEDULE = 'N'   AND YEAR(a.DAT_START )  = YEAR(NOW()) ";
			sql = sql + "  AND  a.INT_PERCENTAGE = "+ pdata[u][0];
			sql = sql + "  AND  MONTHNAME(a.DAT_START )   ="+monthname[v];
			sql = sql + "  GROUP BY MONTHNAME(a.DAT_START )  ";
			sql = sql + "  ORDER BY a.DAT_START  ";
			String gdata[][] = CommonFunctions.QueryExecute(sql);
			if(gdata.length>0)
				datasetsvalues= datasetsvalues+gdata[0][1]+",";
			else	
				datasetsvalues= datasetsvalues+"0,";
		}
		datasetsvalues=datasetsvalues.trim();
		datasetsvalues = datasetsvalues.substring(0,datasetsvalues.length()-1);
		
		
		datasets = datasets + "{ ";
		datasets = datasets + " label				: 	\""+pdata[u][1]+"\",";
		datasets = datasets + " fillColor 			: 	\"rgba(151,187,"+(205-(u+1)*10)+",0.2)\",";
		datasets = datasets + " strokeColor 		: 	\"rgba(151,187,"+(205-(u+1)*10)+",1)\",";
		datasets = datasets + " pointColor 			: 	\"rgba(151,187,"+(205-(u+1)*10)+",1)\",";
		datasets = datasets + " pointStrokeColor 	: 	\"#fff\",";
		datasets = datasets + " pointHighlightFill 	: 	\"#fff\",";
		datasets = datasets + " pointHighlightStroke : 	\"rgba(151,187,"+(205-(u+1)*10)+",1)\",";
		datasets = datasets + " data : ["+datasetsvalues+"] ";
	    datasets = datasets + " },  \n\n";
	}
		
}

datasets=datasets.trim();
datasets = datasets.substring(0,datasets.length()-1);
//out.println(datasets);


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
    <div style="width:30%">
			<div>
				<canvas id="canvas" height="450" width="600"></canvas>
			</div>
		</div>

 
	<script>
		var randomScalingFactor = function(){ return Math.round(Math.random()*100)};
		var lineChartData = {
			labels : [<%=mname%>],
			datasets : [<%=datasets%>]

		}

	window.onload = function(){
		var ctx = document.getElementById("canvas").getContext("2d");
		window.myLine = new Chart(ctx).Line(lineChartData, {
			responsive: true
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
