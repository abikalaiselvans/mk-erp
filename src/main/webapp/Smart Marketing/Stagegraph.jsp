 <%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
%>

 <!doctype html>
<html>
<head>
<title> :: MARKETING ::</title> 
<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>
		<script src="Chart.js"></script>
        
        <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
 <style type="text/css">
 @import url("../JavaScript/SmartStyles.css");
 </style>

	</head>
<body onselectstart="return false" onpaste="return false;" onCopy="return false" >



<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td><%@ include file="index.jsp"%></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="center" valign="middle" class="copyright">STAGE WISE GRAPH</td>
  </tr>
  <tr>
    <td align="center" valign="middle">
    
    <center>
    <div style="width: 50%">
			<canvas id="canvas" height="450" width="600"></canvas>
		</div>
</center>

<script>
	var randomScalingFactor = function(){ return Math.round(Math.random()*100)};

	var barChartData = {
		labels : ["Opportunity Identified  ( 1% )","Quote Submission  ( 30% )","Under Negotiation  ( 60% )"],
		datasets : [
			{
				fillColor : "#a6b5c4" ,
				data : [944.72,218.73,26.13],
				 
			}
		]

	}
	window.onload = function(){
		var ctx = document.getElementById("canvas").getContext("2d");
		window.myBar = new Chart(ctx).Bar(barChartData, {
			responsive : true
		});
	}

	</script></td>
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
}
%>