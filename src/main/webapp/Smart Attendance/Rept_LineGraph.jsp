<%@ include file="index.jsp"%>
<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
String sql="";
String mname = "'January','February','March','April','May','June','July','August','September','October','November','December' ";
String type = "'Present','Sunday','Leave','Absent','Late','Permission' ";
String type1 = "SUM(DOU_PRESENT),SUM(DOU_SUNDAY),SUM(DOU_LEAVE),SUM(DOU_ABSENT),SUM(INT_LATE),SUM(INT_PERMISSION) ";
String monthname[] = mname.split(",");
String pdata[] = type1.split(",");
String datasets="";
String datasetsvalues="";
if(pdata.length>0)
{
	for(int u=0;u<pdata.length;u++)
	{
		datasetsvalues="";
		for(int v=0;v<monthname.length;v++)
		{
			sql = " SELECT   "+pdata[u];
			sql = sql + " FROM att_t_register  ";
			sql = sql + " WHERE CHR_MONTH =  "+monthname[v];
			sql = sql + " AND INT_YEAR = YEAR(NOW())  ";
			sql = sql + " GROUP BY CHR_MONTH  ";
			//out.println(sql);
			String gdata[][] = CommonFunctions.QueryExecute(sql);
			if(gdata.length>0)
				datasetsvalues= datasetsvalues+gdata[0][0]+",";
			else	
				datasetsvalues= datasetsvalues+"0,";
		}
		datasetsvalues=datasetsvalues.trim();
		datasetsvalues = datasetsvalues.substring(0,datasetsvalues.length()-1);
		
		
		datasets = datasets + "{ ";
		//datasets = datasets + " label				: 	\""+pdata[u]+"\",";
		datasets = datasets + " fillColor 			: 	\"rgba(151,187,"+(205-(u+1)*10)+",0.2)\",";
		/*datasets = datasets + " strokeColor 		: 	\"rgba(151,187,"+(205-(u+1)*10)+",1)\",";
		datasets = datasets + " pointColor 			: 	\"rgba(151,187,"+(205-(u+1)*10)+",1)\",";
		datasets = datasets + " pointStrokeColor 	: 	\"#fff\",";
		datasets = datasets + " pointHighlightFill 	: 	\"#fff\",";
		datasets = datasets + " pointHighlightStroke : 	\"rgba(151,187,"+(205-(u+1)*10)+",1)\",";
		*/datasets = datasets + " data : ["+datasetsvalues+"] ";
	    datasets = datasets + " },  \n\n";
	}
		
}

datasets=datasets.trim();
datasets = datasets.substring(0,datasets.length()-1);
//out.println(datasets);

 

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

<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script src="../JavaScript/Chart.js"></script> 
  
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<form    name="a"  >
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
 <table width="100%" border="0" cellspacing="0" cellpadding="0">
	
	<tr>
	  <td height="27" align="center">&nbsp;</td>
   </tr>
	<tr>
		<td height="113" align="center">
        
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
	  <td>&nbsp;</td>
   </tr>
	<tr>
	  <td>&nbsp;</td>
   </tr>
	<tr>
		<td><table width="72" border="0" align="center" cellpadding="3"
								cellspacing="3">
		  <tr>
		    <td width="60"><input class="buttonbold" type="button"
										name="Submit"  value="Close"   accesskey="c" 
										onClick="redirect('AttendanceMain.jsp')"></td>
	      </tr>
	    </table></td>
	</tr>
	<tr>
		<td height="44"><%@ include file="../footer.jsp"%></td>
	</tr>
</table>


</body>

</form>
</html>
<%
	
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>
