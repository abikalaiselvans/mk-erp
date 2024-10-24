<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.ServiceLogin.DateUtil"%>
<html>
<head>
 
 <script language="JavaScript" src="../JavaScript/comfunction.js"></script>
 <script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
<script>
	
	$(function() {
		$( "#fromdt" ).datepicker({ minDate: -30, maxDate: "+0D" });
	});
	
 	
</script>
	
	
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">


<script language="JavaScript">
 function Validate()
  {
  	 
	
	if(   
		 checkNull("fromdt","Enter Leave Date") 
		&& checkNull("hdescription","Enter the description...") 
		 
		
	){
	
		return true;
	}
	else
		return false;
  }
  
  
 	 	
 </script>

<title> :: ATTENDANCE ::</title>


 
<style type="text/css">
<!--
.style3 {color: #FF0000}
-->
</style>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<%@ include file="index.jsp"%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="100">
		<%
try
{
%> </td>
	</tr>
	<tr>
	<tr>
		<td height="68">&nbsp;</td>
	</tr>
	<td height="299">
	<table width="400" border="0" align="center" cellpadding="1"
		cellspacing="1">
		<tr>
			<td width="594" height="15">
			 
			</td>
		</tr>
		<tr>
			<td>
			
			<form action="../SmartLoginAuth" method="post"   name="frm" id="frm"  AUTOCOMPLETE = "off" onSubmit="return Validate() ">
			<table width="100%" border="0" align="center" cellpadding="0"
				cellspacing="0" bgcolor="#dce4f9" class="BackGround">
				<tbody>
					<tr>
						<td colspan="2" rowspan="2"><img height="7"
							src="../Image/General/TLCorner.gif" width="7" /></td>
						<td class="BorderLine" height="1"><spacer height="1"
							width="1" type="block" /></td>
						<td colspan="2" rowspan="2"><img height="7"
							src="../Image/General/TRCorner.gif" width="7" /></td>
					</tr>
					<tr>
						<td height="6"><spacer height="1" width="1" type="block" /></td>
					</tr>
					<tr>
						<td class="BorderLine" width="1"><spacer height="1" width="1"
							type="block" /></td>
						<td width="6"><spacer height="1" width="1" type="block"></td>
						<td width="577" valign="top">
						<table width="500" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100%">
								<div align="center" class="boldEleven"><strong>HOLIDAY EDIT </strong></div>
								</td>
							</tr>
							<tr>
								<td>
								<div align="right"><span class="article style3">   
								
<%

String sql ="";
String rowid = request.getParameter("holiday");
sql = " SELECT a.INT_HOLIDAYID ,a.CHR_EMPID,b.CHR_STAFFNAME,c.CHR_OFFICENAME,DATE_FORMAT(a.DT_HOLIDATE,'%d-%m-%Y'),a.CHR_DESC FROM att_t_holiday a,com_m_staff b,com_m_office c WHERE a.CHR_EMPID= b.CHR_EMPID  AND b.INT_OFFICEID =c.INT_OFFICEID and a.INT_HOLIDAYID="+rowid;
String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
%>
* </span><span class="changePos">Mandatory</span></div>
								</td>
							</tr>

							<tr>
							  <td><table width="400" border="0" align="center" cellpadding="3" cellspacing="3">
                                <tr>
                                  <td width="173" class="boldEleven">Empid</td>
                                  <td width="227" class="boldEleven"><%=readData[0][1]%></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">Name</td>
                                  <td class="boldEleven"><%=readData[0][2]%></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">Date<font color="#CC0000"> *</font></td>
                                  <td class="boldEleven"><span class="boldEleven">
                                    <input name="fromdt" type="text" class="formText135"
												id="fromdt" onKeyPress="dateOnly('fromdt')" value="<%=readData[0][4]%>"
												size="15"  readonly="readonly">
                                     </span>
												
												 
								  </td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">Description <font color="#CC0000">*</font></td>
                                  <td class="boldEleven"><span class="boldEleven">
<textarea name="hdescription" cols="30" rows="5" class="formText135" id="hdescription" onKeyUp="textArea('hdescription','250')"><%=readData[0][5]%></textarea>
                                  </span></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">&nbsp;</td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">&nbsp;</td>
                                </tr>
                              </table></td>
							</tr>
							<tr>
								<td>
								 
								</td>
							</tr>
							<tr>
								<td></td>
							</tr>
							<tr>
								<td height="28">
								<table border="0" align="center" cellpadding="1" cellspacing="1">
									<tr>

										<td width=56><input name="update" type="Submit"
											class="buttonbold" id="update"  
											value="Update">
										<td width=56><input name="Submit" type="Button"
											class="buttonbold" onClick="redirect('Holiday.jsp')"
											 value="Close"   accesskey="c" ></td>
										<td><input name="filename" type="hidden" id="filename"
											value="Holiday">
										  <input name="rowid" type="hidden" id="rowid" value="<%=readData[0][0]%>"> 
										  <input name="dbdate" type="hidden" id="dbdate" value="<%=readData[0][4]%>">
										  <input name="actionS" type="hidden"
											id="actionS" value="ATTholidayUpdate"></td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
						<td nowrap="nowrap" width="6"><spacer height="1" width="1"
							type="block" /></td>
						<td width="1" class="BorderLine"><spacer height="1" width="1"
							type="block" /></td>
					</tr>
					<tr>
						<td colspan="2" rowspan="2"><img height="7"
							src="../Image/General/BLCorner.gif" width="7" /></td>
						<td height="6"><spacer height="1" width="1" type="block" /></td>
						<td colspan="2" rowspan="2" valign="bottom">
						<div align="right"><img height="7"
							src="../Image/General/BRCorner.gif" width="7" /></div>
						</td>
					</tr>
					<tr>
						<td class="BorderLine" height="1"></td>
					</tr>
				</tbody>
			</table>
			
			</form>
			</td>
		</tr>
	</table>
	</td>
	</tr>
	<tr>
		<td><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
<%
 }
 catch(Exception es)
 {
 	out.println(es.getMessage());
 }
 %>
 
</body>
</html>
