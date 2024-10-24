<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*" errorPage="../error/index.jsp"%>
<%@ page import="com.my.org.erp.SmartInventory.Model"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@include file="Redirect.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<!-- TemplateBeginEditable name="doctitle" -->
<title><%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='INV' ")[0][0]%></title>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<style type="text/css">
<!--
.style3 {COLOR: #000000; LINE-HEIGHT: 15px; FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; TEXT-DECORATION: none; font-size: 10px;}
.style4 {color: #FF0000}
-->
</style>

</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript"
	src="../JavaScript/Inventory/Conveyance.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
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

 
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="StaffConveyanceaccept.jsp" onSubmit="return validate()">
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
									<td width="28%" class="style3">Emp Id <span class="style4">*</span> </td>
									<td width="72%">
									<%
									String aval="";
					  String empid =""+session.getAttribute("EMPID");
					  String sql="";
					  
   		 		
					%> 
					<select name="empid" id="empid" class="boldEleven">
						<option value="Select">select</option>
										<%
					 
					 
					sql = "";
					sql = " select a.CHR_EMPID,b.CHR_STAFFNAME  from conveyance_t_conveyance  a ,com_m_staff b  ";
					sql = sql + " where  a.CHR_EMPID=b.CHR_EMPID  AND b.CHR_REPTO='"+empid+"' AND b.CHR_TYPE!='T' AND b.CHR_HOLD!='Y'  ";
					sql = sql + " and a.CHR_STATUS='N'  AND a.CHR_ACCEPT='N'  group by a.CHR_EMPID  ";
 					String Data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
					for(int u=0;u<Data.length;u++)
						out.println("<option value='"+Data[u][0]+"'  style='background-color:#66ccff'>"+Data[u][0]+" / "+Data[u][1]+"</option>");
					
					/*
					 //String sql= "SELECT CHR_EMPID,CHR_STAFFNAME FROM com_m_staff WHERE CHR_REPTO='"+empid+"' AND CHR_TYPE!='T' AND CHR_HOLD!='Y'order by CHR_STAFFNAME ";
					  //String Data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
   		 		
					 for(int u=0;u<Data.length;u++)
					{
						sql="select * from conveyance_t_conveyance where CHR_EMPID='"+Data[u][0]+"' and CHR_STATUS='N' AND CHR_ACCEPT='N' group by CHR_EMPID";
						
						String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
						if(data.length>0)
							out.println("<option value='"+Data[u][0]+"'  style='background-color:#66ccff'>"+Data[u][0]+" / "+Data[u][1]+"</option>");
						else
							out.println("<option value='"+Data[u][0]+"'>"+Data[u][0]+" / "+Data[u][1]+"</option>");
							
								
						
					} */
					  %>
									</select></td>
								</tr>
								<!--<tr>
                      <td class="style3">From</td>
                      <td>  
                        <input name="fromdate" type="text" class="formText135" id="fromdate" onKeyPress="dateOnly('frmdate')" size="15">
                        <a href="javascript:cal1.popup();" > <img src="../JavaScript/img/cal.gif" width="16" height="16" border="0" alt="Click Here to Pick up the date"></a> </td>
                    </tr>
                    <tr>
                      <td class="style3">To</td>
                      <td> 
                        <input name="todate" type="text" class="formText135" id="todate" onKeyPress="dateOnly('todate')" size="15">
                        <a href="javascript:call2.popup();"> <img src="../JavaScript/img/cal.gif" width="16" height="16" border="0" alt="Click Here to Pick up the date"></a>
                        <script language="JavaScript">			
 			var cal1 = new calendar1(document.forms['frm'].elements['fromdate']);
			cal1.year_scroll = true;
			cal1.time_comp = false;
			var call2 = new calendar1(document.forms['frm'].elements['todate']);
			call2.year_scroll = true;
			call2.time_comp = false;		
			setCurrentDate('fromdate');
			setCurrentDate('todate');			
			
 
                          </script>                        </td>
                    </tr>-->
							</table>
							</td>
						</tr>
						<tr>
						  <td height="28" colspan="2" valign="middle" class="bolddeepblue">
							<table width="150" border="0" align="center" cellpadding="3"
								cellspacing="3">
								<tr>
									<td width="56"><input name="Submit2" type="submit"
										class="buttonbold14" id="submit" value="Submit"   accesskey="s"   ></td>
								    <td width="56"><input name="Button" type="Button"
										class="buttonbold14"  value="Close"   accesskey="c" 
										 onClick="redirect('ConveyanceApproval.jsp')"></td>
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
 
</body>
</html>
