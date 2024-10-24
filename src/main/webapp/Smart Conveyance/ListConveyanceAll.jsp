 <%@ page contentType="text/html; charset=iso-8859-1" language="java" 	import="java.sql.*" errorPage="../error/index.jsp"%>
<%@ page import="com.my.org.erp.SmartInventory.Model"%>
<%@ page import="com.my.org.erp.common.*"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<!-- TemplateBeginEditable name="doctitle" -->

<title> :: CONVEYANCE ::</title>

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
 <script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/Attendance/ReportAjax.js"></script>
 


<script src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
<script>
$(function() {
	var dates = $( "#fromdate, #todate" ).datepicker({
		defaultDate: "+1w",
		changeMonth: true,
		numberOfMonths: 2,
		showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			buttonImageOnly: true,
		onSelect: function( selectedDate ) {
			var option = this.id == "fromdate" ? "minDate" : "maxDate",
				instance = $( this ).data( "datepicker" ),
				date = $.datepicker.parseDate(
					instance.settings.dateFormat ||
					$.datepicker._defaults.dateFormat,
					selectedDate, instance.settings );
			dates.not( this ).datepicker( "option", option, date );
		}
	});
});
</script>
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">




<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>

</head>
 
<body  onpaste="return false;" >

<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post"  action="ListConveyanceAllResponsee.jsp" >
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
		<table class="BackGround" cellspacing="0" cellpadding="0" width="588"
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
							<td height="18" colspan="2"  class="BackGround1"><span
								class="boldThirteen">CONVEYANCE EMPLOYEE ONLY </span></td>
						</tr>

						<tr >
							<td height="22" colspan="2" valign="middle" class="style3"><!--DWLayoutEmptyCell-->&nbsp;
							</td>
						</tr>
						<tr >
							<td height="22" colspan="2" valign="middle" class="style3"><table width="462" border="0" align="center" cellpadding="3" cellspacing="4">
                              <tr  >
                                <td height="28" valign="middle" class="boldEleven">From <span class="boldred">*</span> </td>
                                <td>
								<input readonly="readonly" name="fromdate" type="text" id="fromdate" maxlength="12" size="15" class="formText135"/><script language="javascript">setCurrentDate('fromdate')</script>
								
							    </td>
                              </tr>
                              <tr  >
                                <td height="28" valign="middle" class="boldEleven">To <span class="boldred">*</span> </td>
                                <td><input  readonly="readonly" name="todate" type="text" id="todate" maxlength="12"  size="15" class="formText135"/><script language="javascript">setCurrentDate('todate')</script></td>
                              </tr>
                              <tr  >
                                <td height="28" valign="middle" class="boldEleven"> Company <span class="boldred">*</span> </td>
                                <td><select name="company" id="company"
								onChange="loadBranch()" onBlur="loadBranch()"
								class="formText135" style="width:200px">
<%                  
     					 
     					String branch1[][]=CommonFunctions.QueryExecute("SELECT INT_COMPANYID,CHR_COMPANYNAME FROM com_m_company");
     					for(int i=0;i<branch1.length;i++)
 	 						out.println("<option value='"+branch1[i][0]+"'>"+branch1[i][1]+"</option>");
 			   %>
                                </select></td>
                              </tr>
                              <tr  >
                                <td height="28" valign="middle" class="boldEleven"> Branch <span class="boldred">*</span> </td>
                                <td><select name="branch" id="branch"
								class="formText135" style="width:200px">
                                    <option value="0">All</option>
                                </select></td>
                              </tr>
                              
                              <tr   >
                                <td height="24" valign="middle" class="boldEleven" >Office <span class="boldred">*</span> </td>
                                <td valign="top"  ><%
			   	String branchid=""+session.getAttribute("BRANCHID");
	   			String oficeid=""+session.getAttribute("OFFICEID");
				 
			  %>
                                    <select name="Office" class="formText135" id="Office">
                                      <option value="0">All</option>
                                      <%
								
		String sq=" select INT_OFFICEID,CHR_OFFICENAME from  com_m_office  order by CHR_OFFICENAME";

		String shipids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sq);
		for(int u=0; u<shipids.length; u++)
			if(shipids[u][0].trim().equals(oficeid.trim()))
				out.print("<option selected = 'selected' value='"+shipids[u][0]+"'>"+shipids[u][1] +"</option>");
			else
				out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][1] +"</option>");
							%>
                                  </select></td>
                              </tr>
                              <tr   >
                                <td height="24" valign="middle" class="boldEleven" >Department <span class="boldred">*</span> </td>
                                <td valign="top"  ><select name="Dept"
								id="Dept" class="formText135">
                                    <option value="0">All</option>
                                    <%
		sq="SELECT INT_DEPARTID,CHR_DEPARTNAME FROM   com_m_depart   ORDER BY  CHR_DEPARTNAME";
		String deptid[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sq);
		
		for(int u=0;u<deptid.length;u++)
			out.print("<option value='"+deptid[u][0]+"'>"+deptid[u][1]+"</option>"); 
	%>
                                </select></td>
                              </tr>
                              <tr  >
                                <td class="boldEleven">Category <span class="boldred">*</span> </td>
                                <td><select name="Category" class="formText135" id="Category">
                                    <option value="0">All</option>
                                    <%
	String empcategorysql=" SELECT INT_EMPLOYEECATEGORYID,CHR_CATEGORYNAME  FROM   com_m_employeecategory   ORDER BY CHR_CATEGORYNAME ";
	String empcategoryData[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(empcategorysql);
	if (empcategoryData.length>0)
		for (int i=0; i<empcategoryData.length; i++) 
			out.println("<option value="+empcategoryData[i][0]+">"+empcategoryData[i][1] +"</option>");			
	
						%>
                                </select></td>
                              </tr>
                              <tr  >
                                <td class="boldEleven">Including Resigner's  <span class="boldred">*</span> </td>
                                <td><input name="detail" type="checkbox" id="detail" value="Y"></td>
                              </tr>
                              
                            </table></td>
						</tr>
						<tr>
							<td height="28" colspan="2" valign="middle" >
							<table width="141" border="0" align="center" cellpadding="3"
								cellspacing="3">
								<tr>
								  <td width="60"><input name="Submit2" type="submit" class="buttonbold14" value="Submit"   accesskey="s"   ></td>
									<td width="60"><input class="buttonbold14" type="button"
										name="Submit"  value="Close"   accesskey="c" 
										onClick="redirect('ListConveyance.jsp')"></td>
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
	 
}
%>
</form>
<%@ include file="../footer.jsp"%>
</body>
</html>
