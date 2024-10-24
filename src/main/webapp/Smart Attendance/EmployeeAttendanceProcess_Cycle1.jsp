<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<html>
<head>
<script src="../JavaScript/common/StaffloadAjax.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript">

 
//week day 

	
function Validate()
{
 	if( checkNull("ename","Select Staff") 
		&& checkNullSelect("month","Select month" ,"")
		&& checkNullSelect("year","Select year" ,"")
	 )
			return true;
		else
			return false;
}

  
 </script>

<title> :: ATTENDANCE ::</title>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"
	onLoad="init(),assign()">
<%@ include file="index.jsp"%>
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td width="100"></td>
	</tr>
	<tr>
		<td>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth" onSubmit="  Validate()  ">
		<table width="800" border="0" align="center" cellpadding="1"
			cellspacing="1">
			<tr>
				<td width="594">&nbsp;</td>
			</tr>
			<tr>
				<td>
				<table width="300" border="0" align="center" cellpadding="0"
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
							<td class="BorderLine" width="1"><spacer height="1"
								width="1" type="block" /></td>
							<td width="6"><spacer height="1" width="1" type="block"></td>
							<td width="577" valign="top">
							<table width="300" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td colspan="2">
									<div align="center" class="boldEleven"><strong>   EMPLOYEE ATTENDANCE PROCESS  CYCLE-1 </strong>
									  <input type="hidden" name="actionS" value="ATTEmployeeWiseAttendanceProcess">
                                      <input type="hidden" name="filename" value="EmployeeWiseAttendanceProcess">
                                      <input name="registercheck" type="hidden" id="registercheck" value="N" >
                                      <br>
									</div>
									</td>
								</tr>
								<tr>
									<td colspan="2">
									<div align="right"><font color="#FF0000">* </font><span
										class="changePos">Mandatory</span></div>
									</td>
								</tr>
								<tr>
									<td colspan="2">
									<div align="center"><%@ include
										file="../JavaScript/ajax.jsp"%></div>
									</td>
								</tr>
								<tr>
									<td colspan="2"></td>
								</tr>
								<tr>
									<td height="19" colspan="2">
									<table width="300" border="0" align="center" cellpadding="2"
										cellspacing="2">
										 
										<tr>
											<td width="119"><span class="boldEleven">Month<font color="#FF0000">*</font><span
												class="bolddeepblue">   </span></span></td>
											<td width="81"><span class="boldThirteen"> 
											  <select name="month" id="month"  >
												<%@ include file="../JavaScript/Inventory/month.jsp"%>
										  </select> </span></td>
										</tr> month,year
										<tr>
											<td><span class="boldEleven">Year<font color="#FF0000">*</font></span></td>
											<td><span class="boldThirteen"> <select name="year" id="year" >
												<%@ include file="../JavaScript/Inventory/year.jsp"%>
												 
											</select> 
                                            
                                            <script language='JavaScript' type="text/javascript">
				<!--			
					 
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						var day=d.getDate();
						
						setOptionValue('month',month1);
						setOptionValue('year',year1);
						 
												
				//-->
</script>	

                                              </span></td>
										</tr>
										 
										 
									</table>
									</td>
								</tr>

								 
								<tr>
									<td height="19" colspan="2">
									<table border="0" align="center" cellpadding="2"
										cellspacing="2">
										<tr>
											<td width="56"><input type="submit" name="Submit"
												id="submit_btn" class="buttonbold" value="Submit"   accesskey="s"   
												/></td>
											<td width="56"><input type="button" name="submit"
												class="buttonbold"  value="Close"   accesskey="c" 
												onClick="redirect('AttendanceMain.jsp')" /></td>
										</tr>
									</table>
									</td>
								</tr>
							</table>
							</td>
							<td nowrap="nowrap" width="6"><spacer height="1" width="1"
								type="block" /></td>
							<td width="1" class="BorderLine"><spacer height="1"
								width="1" type="block" /></td>
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
							<td class="BorderLine" height="1"><spacer height="1"
								width="1" type="block" /></td>
						</tr>
					</tbody>
				</table>
				</td>
			</tr>
			<tr>
			  <td><div align="center" class="bolddeepred">

		<div align="center">
		<%
		String er=""+request.getParameter("er");
		if( "null".equals(er)  || "".equals(er))
			out.println();
		else
		{
			out.println("<h3>"+er+"</h3>");
			String flag=request.getParameter("flag");
			if("N".equals(flag))
			{ 
			%>
			<script language="javascript">
				 alert("Check the Attendance , because <%=er%>");
			</script>
			<%
			}
		}
		
	%>
		</div>
		</div></td>
		  </tr>
		</table>
		</form>
		</td>
	</tr>
	<tr>
		<td><%@ include file="../footer.jsp"%></td>
	</tr>
</table>