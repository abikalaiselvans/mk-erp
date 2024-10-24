<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<html>
<head>
<script src="../JavaScript/common/StaffloadAjax.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript">

 
//week day 

	
function Validate()
{
 	if( checkNull("ename","Select Staff") )
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
	onLoad="init() ">
<%@ include file="index.jsp"%>
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td width="100"></td>
	</tr>
	<tr>
		<td>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="EmployeeAttendance_CycleResponse.jsp" onSubmit=" return Validate()  ">
		<table width="598" border="0" align="center" cellpadding="1"
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
									<div align="center" class="boldEleven"><strong>   EMPLOYEE ATTENDANCE </strong><br>
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
									<table width="214" border="0" align="center" cellpadding="2"
										cellspacing="2">
										<tr>
											<td width="119"><span class="boldEleven">Month<font color="#FF0000">*</font><span
												class="bolddeepblue">   </span></span></td>
											<td width="81"><span class="boldThirteen"> 
											  <select name="month" id="month"  >
												<%@ include file="../JavaScript/months.jsp"%>
										  </select> </span></td>
										</tr>
										<tr>
											<td><span class="boldEleven">Year<font color="#FF0000">*</font></span></td>
											<td><span class="boldThirteen"> <select name="year" id="year" >
												<%@ include file="../JavaScript/years.jsp"%>
												 
											</select>   </span></td>
										</tr>
										<tr>
                                          <td class="boldEleven">Starting Date </td>
										  <td><select name="startingdate" id="startingdate">
                                              <%
						  	for(int i=1;i<=27;i++)
								out.println("<option value='"+i+"'>"+i+"</option>");
						  %>
                                            </select>
                                          </td>
									  </tr>
										<tr>
                                          <td class="boldEleven">Ending Date </td>
										  <td><select name="endingdate" id="endingdate">
                                              <%
						  	for(int i=1;i<=31;i++)
								out.println("<option value='"+i+"'>"+i+"</option>");
						  %>
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
						setOptionValue('startingdate','1');	
						setOptionValue('endingdate',day);	
												
				//-->
</script>	
                                          </td>
									  </tr>
										
										<tr>
										  <td>&nbsp;</td>
										  <td>&nbsp;</td>
									  </tr>
										<tr>
										  <td>&nbsp;</td>
										  <td>&nbsp;</td>
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
		</table>
		</form>
		</td>
	</tr>
	<tr>
		<td><%@ include file="../footer.jsp"%></td>
	</tr>
</table>