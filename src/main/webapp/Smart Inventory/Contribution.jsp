<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="../error/index.jsp"%>
<%@ page import="com.my.org.erp.SmartInventory.Model"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>:: INVENTORY ::</title><%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>
<script language="javascript" src="../JavaScript/Inventory/Contribution.js"></script>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<%@ include file="indexinv.jsp"%>
<body    onLoad="loadContribution('0')">


<form  AUTOCOMPLETE = "off"   name="frm" method="get" >
<table width="100%" height="150" border="0" align="center" 	cellpadding="2" cellspacing="2">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table height="227" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"  >
			<tr  >
				<td height="31"  >
				<div align="center" class="boldThirteen">CONTRIBUTION</div>				</td>
			</tr>
			<tr  >
				<td height="31"  >
				<div align="center">
				<table width="100%" border="0" cellpadding="0" cellspacing="0" class="whiteMedium">
					<tr  >
					  <td>Customer</td>
					  <td><span class="boldThirteen">
                        <select name="customer" style="width:200"
							id="customer" class="formText135"  onChange="loadContribution('0')">
                          <option value="0">All</option>
                          <jsp:include page="LoadCustomer.jsp" />                      
                      </select>
                      </span></td>
					  <td width="102" >
						<div align="center">Staff Name</div>						</td>
						<td width="46" >
						<div align="left">
						<select name="ref" id="ref" class="formText135" onChange="loadContribution('0')" style="width:170" >
							<option value="0">All</option>
							<jsp:include page="Staffload.jsp" flush="true" />
						</select></div>						</td>
						<td width="62" >Day</td>
						<td width="62" ><select name="day" id="day"  onBlur="loadContribution('0') ">
                          <option value="0">All</option>
                          <%
						for(int u=1;u<32;u++)
							out.println("<option value='"+(u)+"'>"+u+"</option>");
						%>
                        </select></td>
						<td width="62" >Month						</td>
						<td width="37" >
						<select name="month" id="month" onChange="loadContribution('0')"  style="width:170" >
							<option value="0">All</option>
							<%@ include file="../JavaScript/Inventory/month.jsp"%>
						</select></td>
						<td width="46" >Year						</td>
						<td width="37" >
						<select name="year" id="year" onChange="loadContribution('0')"  style="width:170" >
							<%@ include file="../JavaScript/Inventory/year.jsp"%>
						</select> <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						var day=d.getDate();
						setOptionValue('day',day);	
						setOptionValue('month',month1);
						setOptionValue('year',year1);							
				//-->
          </script></td>
					</tr>
				</table>
				</div>				</td>
		  </tr>
			 
			<tr class="MRow1">
				<td height="127" valign="top" class="footermenu">
				
				
						
						
				  
			  <div id="Contribution" style="OVERFLOW:auto;width:100%;height:300px" class="boldEleven">	</div><br />	<div id="totRec" align="center"></div>	<br />
			  <div id="totRec"></div><br>			    </td>
		  </tr>
		</table>		</td>
	</tr>
	<tr>
	  <td>&nbsp;</td>
  </tr>
	<tr>
	  <td><table width="90%" border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
        <tr  >
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadContribution('')">All</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadContribution('A')">A</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadContribution('B')">B</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadContribution('C')">C</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadContribution('D')">D</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadContribution('E')">E</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadContribution('F')">F</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadContribution('G')">G</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadContribution('H')">H</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadContribution('I')">I</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadContribution('J')">J</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadContribution('K')">K</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadContribution('L')">L</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadContribution('M')">M</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadContribution('N')">N</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadContribution('O')">O</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadContribution('P')">P</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadContribution('Q')">Q</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadContribution('R')">R</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadContribution('S')">S</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadContribution('T')">T</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadContribution('U')">U</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadContribution('V')">V</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadContribution('W')">W</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadContribution('X')">X</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadContribution('Y')">Y</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadContribution('Z')">Z</a></div></td>
        </tr>
      </table></td>
  </tr>
	<tr>
		<td>&nbsp; </td>
	</tr>
	<tr>	</tr>
	<tr>
		<td>
		<table border="0" align="center" cellpadding="1" cellspacing="1">

			<tr>
				<td width="56"><input name="Close" type="button"
					class="ButtonHead" id="Close"  value="Close"   accesskey="c" 
					onclick="redirect( 'InventoryMains.jsp')" /></td>
			</tr>
		</table>		</td>
	</tr>
</table>
<%
}
catch(Exception e)
{
	System.out.println(e.getMessage());
	out.println(e.getMessage());
}
%> <%@ include file="../footer.jsp"%>
</body>
</html>
