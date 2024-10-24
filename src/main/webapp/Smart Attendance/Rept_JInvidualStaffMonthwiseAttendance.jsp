<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<html>
<head>
<script src="../JavaScript/common/StaffloadAjax.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript">

function changeState()
{
  var comboLate=document.getElementById("late").checked;
  if(comboLate==true)
  {
    document.getElementById("TxtDay").disabled=true;
    document.getElementById("TxtDay1").disabled=true;
    document.getElementById("TxtDay2").disabled=true;
    document.getElementById("ot").disabled=true;
  }
  else
  {
    document.getElementById("TxtDay").disabled=false;
    document.getElementById("TxtDay1").disabled=false;
    document.getElementById("TxtDay2").disabled=false;
    document.getElementById("ot").disabled=false;    
  }  
}
function morningTimeOnly()
{
      alert("In morning time");
      if(checkNull("fromdt","Enter From Date"))
      return true;
      else
      return false;
}

//week day 

	
function Validate()
  {
	
  	if(checkNull("ename","Select Staff") && checkNullSelect("month","Select Month","Select")&&(checkNullSelect("year","Select Year","Select")) && 
  		  	(checkNullSelect( "reportType","Select Export Type" ,'0')))	
			return true;
  	else
 			return false;	
  }
 </script>
<title><%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='ATT' ")[0][0]%></title>
 
<style type="text/css">
<!--
.style3 {color: #FF0000}
-->
</style>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="init()">
<%@ include file="index.jsp"%>
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td width="100"><br>
		<br>
		</td>
	</tr>
	<tr>
		<td>
		<form  AUTOCOMPLETE = "off"   name="StaffManualAttendanceEditfrm" method="post"
			action="../SmartLoginAuth">
		<table width="598" border="0" align="center" cellpadding="1"
			cellspacing="1">
			<tr>
				<td width="594">&nbsp;</td>
			</tr>
			<tr>
				<td>
				<table width="591" border="0" align="center" cellpadding="0"
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
							<table width="577" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="100%">
									<div align="center" class="boldEleven"><strong>
									Monthwise and Yearwise Staff Attendance Information</strong></div>									</td>
								</tr>
								<tr>
									<td>
									<div align="right"><font color="#FF0000">* </font><span
										class="changePos">Mandatory</span></div>									</td>
								</tr>
								<tr>
									<td>
									  <div align="center">
									    <%@ include
										file="../JavaScript/ajax.jsp"%>
									  </div></td>
								</tr>
								<tr>
								  <td>&nbsp;</td>
							  </tr>
								<tr>
									<td></td>
								</tr>
								<tr>
									<td height="19">
									<table width="397" border="0" align="center" cellpadding="1"
										cellspacing="1">
										<tr>
											<td width="123" valign="middle"  
												class="boldEleven">Month <span class="style3">*</span> </td>
											<td width="267" class="boldEleven"><strong><font size="1"><font size="1">
											  <select name="month"  id="month"
								class="formText135">
                                                <option value="Select">Select</option>
												  <option value="0">All</option>
                                                <option value="01">January</option>
                                                <option value="02">February</option>
                                                <option value="03">March</option>
                                                <option value="04">April</option>
                                                <option value="05">May</option>
                                                <option value="06">June</option>
                                                <option value="07">July</option>
                                                <option value="08">August</option>
                                                <option value="09">September</option>
                                                <option value="10">October</option>
                                                <option value="11">November</option>
                                                <option value="12">December</option>
                                              </select>
											</font></font></strong></td>
										</tr>
										<tr>
											<td align="left" valign="middle"  
												class="boldEleven">Year <span class="style3">*</span> </td>
											<td class="boldEleven"><strong>
											  <select
								name="year" id="year" class="formText135">
                                                <option value="Select">Select</option>
                                                <%
								java.util.Date d = new java.util.Date();
								int y = 1900+d.getYear();
								int styear = y-20;
								int edyear = y+20;
			         for(int i=styear;i<=edyear;i++)
			      {
			       out.println("<option value="+i+">"+i+"</option>");
			      }
			     %>  </select>	</strong></td>
										</tr>
										<tr>
										  <td align="left" valign="middle"  
												class="boldEleven"> <div align="left">Export Type <span class="style3">*</span> </div></td>
										  <td class="boldEleven"><select name="reportType" id="reportType">
                                            <option value="0">Select Export Type</option>
                                            <option value="csv">CSV</option>
                                            <option value="xls">Excel</option>
                                            <option value="html">HTML</option>
                                            <option value="pdf" selected="selected">PDF</option>
                                            <option value="txt">Text</option>
                                            <option value="rtf">Word</option>
                                            <option value="xml">XML</option>
                                          </select></td>
									  </tr>
									</table>									</td>
								</tr>

								<tr>
									<td height="19"><div align="center"><span class="boldEleven">
									  <input name="filename" type="hidden" id="filename"
										value="Rept_JInvidualStaffMonthwiseAttendance">
                                      <input name="actionS"
										type="hidden" id="actionS"
										value="ATTRept_JInvidualStaffMonthwiseAttendance">
                                      <input name="rptfilename" type="hidden" id="rptfilename" value="IndividualStaffMonthwiseAttendance">
									</span><span class="boldEleven">
									<input name="rptfilename1" type="hidden" id="rptfilename1" value="IndividualStaffAttendanceYearwise">
									</span></div>								  </td>
								</tr>
								<tr>
									<td height="19">
									<table border="0" align="center" cellpadding="2"
										cellspacing="2">
										<tr>
											<td width="56"><input type="submit" name="Submit"
												id="submit_btn" class="buttonbold" value="Submit"   accesskey="s"   
												onClick="return Validate()"/></td>
											<td width="56"><input type="button" name="submit"
												class="buttonbold"  value="Close"   accesskey="c" 
												onClick="javascript:redirect('AttendanceMain.jsp')" /></td>
										</tr>
									</table>									</td>
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