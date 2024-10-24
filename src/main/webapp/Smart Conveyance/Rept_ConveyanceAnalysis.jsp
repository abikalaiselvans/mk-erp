<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="../error/index.jsp"%>
<%@ page import="com.my.org.erp.SmartInventory.Model"%>
<%@ page import="com.my.org.erp.common.*"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<!-- TemplateBeginEditable name="doctitle" -->

<title> :: CONVEYANCE ::</title>

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<style type="text/css">
<!--
.style3 {COLOR: #000000; LINE-HEIGHT: 15px; FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; TEXT-DECORATION: none; font-size: 10px;}
-->
</style>
</head>
<script language="javascript" src="../JavaScript/Attendance/ReportAjax.js"></script>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
<script> 	
	$(function() {
		var dates = $( "#fromdate, #todate" ).datepicker({
			defaultDate: "+1w",
			changeMonth: true,
			numberOfMonths: 2,
			
			maxDate: "+0D",
			showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			buttonImageOnly: true ,
			
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
	
	
function validate()
{
	if( 
		 checkNull("fromdate","Enter fromdate") 
		&& checkNull("todate","Enter todate") 
		 
		 
		)
		{
			return true;
		}
		else
		{
			return false;
		}
}

/*checkNullSelect("company","Select company   ","0")
		&& checkNullSelect("branch","Select branch   ","0")
		&& checkNullSelect("office","Select office   ","0")
		&& 
*/		
		
	</script>
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">
  
 <body  onpaste='return false;'>

<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth" onSubmit="retrun validate()">
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
							<td height="18" colspan="2"  class="BackGround"><span
								class="boldThirteen">Report Conveyance</span></td>
						</tr>

						<tr class="bolddeepblue">
							<td height="22" colspan="2" valign="middle" class="style3">
							<table width="346" border="0" align="center" cellpadding="3"
								cellspacing="1">
								<tr>
									<td class="boldEleven">Company</td>
									<td class="boldEleven"><select name="company" id="company"
										onChange="loadBranch()" onBlur="loadBranch()"
										class="formText135" style="width:200px">
										<%                  
     					String branch1[][]=CommonFunctions.QueryExecute("SELECT INT_COMPANYID,CHR_COMPANYNAME FROM com_m_company");
     					for(int i=0;i<branch1.length;i++)
 	 						out.println("<option value='"+branch1[i][0]+"'>"+branch1[i][1]+"</option>");
 			   %>
									</select></td>
								</tr>
								<tr>
									<td class="boldEleven">Branch</td>
									<td class="boldEleven"><select name="branch" id="branch"
										class="formText135" style="width:200px">
										<option value="0">All</option>
									</select></td>
								</tr>
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

		String shipids[][] =  CommonFunctions.QueryExecute(sq);
		for(int u=0; u<shipids.length; u++)
			if(shipids[u][0].trim().equals(oficeid.trim()))
				out.print("<option selected = 'selected' value='"+shipids[u][0]+"'>"+shipids[u][1] +"</option>");
			else
				out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][1] +"</option>");
			
				%>
									</select></td>
								</tr>
								<tr>
									<td class="boldEleven">From Date</td>
									<td class="boldEleven"><span class="demo">
									  <input name="fromdate" type="text" id="fromdate" maxlength="12" class="formText135" readonly="readonly" />
									  <script language="javascript">setCurrentDate('fromdate')</script>
									</span></td>
								</tr>
								<tr>
								  <td class="boldEleven">To Date </td>
								  <td class="boldEleven"><input name="todate" type="text" id="todate" maxlength="12" class="formText135" readonly="readonly"  />
								  <script language="javascript">setCurrentDate('todate')</script>
								  <input name="filename" type="hidden" id="filename" value="PDFConveyancePie">
								  <input name="actionS" type="hidden" id="actionS" value="CONConveyancePieChart"></td>
							  </tr>
								<tr>
								  <td class="boldEleven">Chart Type</td>
								  <td class="boldEleven">
								  <select name="type" id="type">
								   
								  <option value="Bar">Bar</option>
								  <option value="Pie" selected="selected">Pie</option>
								  
								    </select>
								  </td>
							  </tr>
							</table>
							</td>
						</tr>
						<tr class="bolddeepblue">
							<td height="22" colspan="2" valign="middle" class="style3"></td>
						</tr>
						<tr>
							<td height="28" colspan="2" valign="middle" class="bolddeepblue">
							<table width="142" border="0" align="center" cellpadding="3"
								cellspacing="3">
								<tr>
									<td width="61"><input name="Submit2" type="submit" class="buttonbold14" id="submit" value="Submit"   accesskey="s"   ></td>
									<td width="60"><input class="buttonbold14" type="button" name="Submit"  value="Close"   accesskey="c"  onClick="redirect('Conveyancemain.jsp')"></td>
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
