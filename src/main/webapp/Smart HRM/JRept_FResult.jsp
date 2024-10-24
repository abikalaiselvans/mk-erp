 
<%
try
{
%>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<form action="../hrmCon" method="post">
<p>
  <input type="hidden" name="pageAction" value="QualifiedResult" />
</p>
<table width="178" align="center">
  <tr>
<td>Month:</td>
<td><select name="month" class="formText135" id="month" style="width:100">
 
	<option value="January">January</option>
	<option value="February">February</option>
	<option value="March">March</option>
	<option value="April">April</option>
	<option value="May">May</option>
	<option value="June">June</option>
	<option value="July">July</option>
	<option value="August">August</option>
	<option value="September">September</option>
	<option value="October">October</option>
	<option value="November">November</option>
	<option value="December">December</option>
</select>

 
<script language='JavaScript' type="text/javascript">
				<!--			
						
						var today = new Date();
						var monthnum = today.getMonth();
						var monthname=new Array("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December");
						var day=today.getDate();
						setOptionValue('month',monthname[monthnum]);
					
				//-->
          </script>

</td>
</tr>
<tr>
<td>Year:</td>
<td><select name="year"  id="year">
<%@include file="../JavaScript/years.jsp" %>
</select>
</td></tr>
<tr><td colspan="2" align="center" ><input type="submit" value="submit"/></td></tr>
</table>
</form>

<script language="JavaScript">
                             var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						 
						setOptionValue('year',year1);
                             </script>
                        
</body>
</html>

<%
}
catch(Exception e)
{
		out.println(e.getMessage());
}
%>