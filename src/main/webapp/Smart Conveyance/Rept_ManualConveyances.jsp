<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="../error/index.jsp"%>
<%@ page import="com.my.org.erp.SmartInventory.Model"%>
<%@ page import="com.my.org.erp.common.*"%><head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<!-- TemplateBeginEditable name="doctitle" -->

<title> :: CONVEYANCE ::</title>
 <script language="javascript" src="../JavaScript/comfunction.js"></script>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
 <style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>
</head>
    
 <body  onpaste='return false;'>

<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="Rept_ManualConveyances_Response.jsp" onSubmit="retrun validate()">
<table width="900" height="150" border="0" align="center"
	cellpadding="2" cellspacing="2">
	<%
try
{
	
	 
 %>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table class="BackGround" cellspacing="0" cellpadding="0" width="300"
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
					<td width="7"><spacer height="1" width="1" type="block" /></td>
					<td width="575">
					<table width="100%" border="0" cellspacing="2" cellpadding="2"
						 >
						<!--DWLayoutTable-->
						<tr align="center" valign="middle">
							<td height="18" colspan="2"  class="BackGround"><span
								class="boldThirteen">Report Manual Conveyance</span></td>
						</tr>

						<tr class="bolddeepblue">
							<td height="22" colspan="2" valign="middle" class="style3">
							<table width="346" border="0" align="center" cellpadding="3"
								cellspacing="1">
								
								<tr>
									<td class="boldEleven">office</td>
									<td class="boldEleven">
									<%
			   	String branchid=""+session.getAttribute("BRANCHID");
	   			String oficeid=""+session.getAttribute("OFFICEID");
				 
			  %> <select name="office" class="formText135" id="office">
										<option value="0">All</option>
										<%
								
		String sq=" select INT_OFFICEID,CHR_OFFICENAME from  com_m_office  order by CHR_OFFICENAME";

		String shipids[][] = CommonFunctions.QueryExecute(sq);
		for(int u=0; u<shipids.length; u++)
			if(shipids[u][0].trim().equals(oficeid.trim()))
				out.print("<option selected = 'selected' value='"+shipids[u][0]+"'>"+shipids[u][1] +"</option>");
			else
				out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][1] +"</option>");
			
				%>
									</select></td>
								</tr>
								<tr>
									<td class="boldEleven">Month</td>
									<td class="boldEleven"><span class="demo">
									  
								      <select name="month"
							id="month" ><option value="0">All</option>
                                        <%@ include file="../JavaScript/months.jsp"%>
                                      </select>
								  </span></td>
								</tr>
								<tr>
								  <td class="boldEleven">Year</td>
								  <td class="boldEleven"><select name="year"
							id="year" >
                        <%@ include file="../JavaScript/years.jsp"%>
                      </select>
                        <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1
						var day1=d.getDay();
						var day=d.getDate()
						if(day<10) day="0"+day;
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						setOptionValue('month',month1);
						setOptionValue('year',year1);	
						 					
				//-->
                </script>   </td>
								</tr>
								<tr>
								  <td colspan="2" class="boldEleven"><table width="142" border="0" align="center" cellpadding="3"
								cellspacing="3">
                                    <tr>
                                      <td width="61"><input name="Submit2" type="submit" class="buttonbold14" id="submit" value="Submit"   accesskey="s"   ></td>
                                      <td width="60"><input class="buttonbold14" type="button" name="Submit"  value="Close"   accesskey="c"  onClick="redirect('ListConveyance.jsp')"></td>
                                    </tr>
                                  </table></td>
							  </tr>
							</table>
							</td>
						</tr>
						 
						<tr>
							<td width="135" height="2"></td>
							<td width="225"></td>
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
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<%
}
catch(Exception e)
{
	//System.out.println(e.getMessage());
}
%>
</form>
<%@ include file="../footer.jsp"%>
</body>
</html>
