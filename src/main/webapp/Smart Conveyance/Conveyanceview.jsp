<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*" errorPage="../error/index.jsp"%>
<%@ page import="com.my.org.erp.SmartInventory.Model"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<!-- TemplateBeginEditable name="doctitle" -->

<title> :: CONVEYANCE ::</title>

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<style type="text/css">
<!--
.style3 {COLOR: #000000; LINE-HEIGHT: 15px; FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; TEXT-DECORATION: none; font-size: 10px;}
.style4 {color: #FF0000}
-->
</style>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/Inventory/Conveyance.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>


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
</script>
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">


<script language="javascript">
function validate()
{
	if(checkNullSelect('empid','Select Employee Name','Select'))
		return true;
	else
		return false;
}
</script>
<body  onpaste='return false;'>

<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="Conveyanceaccept.jsp"
	onSubmit="return validate()">
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
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table class="BackGround" cellspacing="0" cellpadding="0" width="390"
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
					<table width="374" border="0" cellspacing="2" cellpadding="2"
						 >
						<!--DWLayoutTable-->
						<tr align="center" valign="middle">
							<td height="18" colspan="2"  class="BackGround"><span
								class="boldThirteen">CONVEYANCE APPROVAL </span></td>
						</tr>

						<tr class="bolddeepblue">
							<td height="24" colspan="2" valign="middle" class="style3"><!--DWLayoutEmptyCell-->&nbsp;</td>
						</tr>
						<tr class="bolddeepblue">
							<td height="24" colspan="2" valign="middle" class="style3">
							<table width="100%" border="0" align="center" cellpadding="2"
								cellspacing="2">
								<tr>
									<td width="28%" class="style3">Emp Id<span class="style4"> * </span></td>
									<td width="72%">
									<%
									String aval="";
					  String empid =""+session.getAttribute("EMPID");
					   
   		 			String sql="select a.CHR_EMPID,b.CHR_STAFFNAME from conveyance_t_conveyance a, com_m_staff b  WHERE a.CHR_EMPID in(SELECT CHR_EMPID FROM ";
sql=sql+ " com_m_staff WHERE CHR_REPTO='"+empid+"'  AND CHR_TYPE!='T' AND CHR_HOLD!='Y' order by CHR_STAFFNAME ) "; //AND CHR_TYPE!='T' AND CHR_HOLD!='Y'
sql=sql+" AND a.CHR_EMPID =b.CHR_EMPID AND a.CHR_STATUS='N'  group by a.CHR_EMPID ORDER BY  b.CHR_STAFFNAME ";
//out.println(sql);				
String Data[][] =  CommonFunctions.QueryExecute(sql);	
   		 		
   		 		
					%> <select name="empid" id="empid" class="boldEleven">
										<option value="Select">select</option>
										<%
										
									
					for(int u=0;u<Data.length;u++)
						out.println("<option value='"+Data[u][0]+"'  style='background-color:#66ccff'>"+Data[u][0]+" / "+Data[u][1]+"</option>");		
						
					
					  %>
									</select></td>
								</tr>
								<tr>
								  <td class="style3"><span class="boldEleven">From</span></td>
								  <td><input name="fromdate" type="text" class="formText135" id="fromdate"   size="12" readonly="readonly" ></td>
							  </tr>
								<tr>
								  <td class="style3"><span class="boldEleven">To</span></td>
								  <td><input name="todate" type="text" class="formText135" id="todate" size="12" readonly="readonly" >   
										<script language="JavaScript">			
 			 		
			setCurrentDate('fromdate');
			setCurrentDate('todate');			
			
 
                          </script></td>
							  </tr>
							</table>
							</td>
						</tr>
						<tr>
							<td height="28" colspan="2" valign="middle" class="bolddeepblue">
							<table width="142" border="0" align="center" cellpadding="3"
								cellspacing="3">
								<tr>
									<td width="61"><input name="Submit2" type="submit"
										class="tMLAscreenHead" id="submit" value="Submit"   accesskey="s"   ></td>
									<td width="60"><input class="tMLAscreenHead" type="button"
										name="Submit"  value="Close"   accesskey="c" 
										onClick="redirect('Conveyancemain.jsp')"></td>
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
