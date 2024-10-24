<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<html>
<head>

<title> :: ATTENDANCE ::</title>


<script src="../JavaScript/AJAXFunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript">  
  function Edit()
 	{		
 	    var count=0;
 	    sel=document.forms[0].staffid;
 	    for(i=0;i<sel.length;i++)
 	    {
 	         if(sel[i].checked)
 	         count=count+1;  
 	    }
		 
 	    if(count==0)
 	    { 	       
		   if(document.forms[0].staffid.checked)
		    { 
		    	count=1;
		    }   
		    else{	    
		   	   alert("Select Record to Edit");
		   	   return false;
		   	 }
 	    }
 	    if(count>1)
 	    {
 	       alert("Select One Record to Edit");
 	       return false
 	    }
 	    if(count==1)
 	    {
		document.StaffManualAttendanceEditfrm.action="StaffManualAttendanceUpdate.jsp";
		return true;
		}
 	} 	
 function Delete()
 	{		
		var count;
		count=0;
		c1=document.forms[0].staffid
		txt=""
		for (i=0;i<c1.length;++ i)
		{
			if (c1[i].checked)
			{
			count=count+1;
			}
		}
		if(count==0)
		{
			if (document.forms[0].staffid.checked) { count=1;}
		}
		if(count>=1){			
			var name=confirm("Confirm to Delete")
			if (name==true)
			{ 
				document.StaffManualAttendanceEditfrm.action="../SmartLoginAuth";
				return true;			
			}
			else
				return false;
		}
		else
		{
		    alert("Select Atleast One Value");
		    return false;
		}		
 	}

function Validate()
  {
  	if(checkNull("ename","Select Staff") 
	&& checkNull("fromdt","Enter From Date") 
	&& checkNull("todt","Enter To Date") 
  	&& checkNull("it","Enter In Time")
	&& checkDate("fromdt","todt")
	&& checkTime('it','ot'))
		return true;
	else
		return false;
  }
	function updateStaffAtten()
	{
		var f ="StaffManualAttenUpdate.jsp?staffid="+document.getElementById("staffId").value;
		newWindow = window.open(f,"subWind",",,height=250,width=325,top=0,left=0");
		newWindow.focus( );
		return true 	
	}

 </script>
 
<style type="text/css">
<!--
.style3 {color: #FF0000}
-->
</style>
</head>

<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form  AUTOCOMPLETE = "off"   name="StaffManualAttendanceEditfrm" method="post"
	action="../SmartLoginAuth">
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td width="100">
		<%
try
{
%> <%@ include file="index.jsp"%> <%
			String staff  = request.getParameter("staffid");
			String staffname= com.my.org.erp.bean.Attendance.StaffRegistration.staffName(staff.trim());
			String sql ="";
			int year  = Integer.parseInt(request.getParameter("year"));
			String month =com.my.org.erp.ServiceLogin.DateUtil.getMonth(Integer.parseInt(request.getParameter("month")));
				
			sql = "SELECT COUNT(*) FROM ATT_SMART_ATTENDANCE WHERE CHR_EMPID = '"+staff+"'";
			sql = sql +"AND  CHR_LOGMONTH ='"+month+"' AND INT_LOGYEAR = "+year;
			boolean f =com.my.org.erp.bean.Attendance.StaffRegistration.getAnyRecordExisist2(sql); 
			if(f==false)
				 response.sendRedirect("Manual Attendance.jsp?staff="+staff);
	%>
		</td>
	</tr>
	<tr>
		<td height="53">&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table width="858" border="0" align="center" cellpadding="1"
			cellspacing="1">
			<tr>
				<td width="753">&nbsp;</td>
			</tr>
			<tr>
				<td height="229" valign="top">
				<table width="810" border="0" align="center" cellpadding="0"
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
							<td valign="top">
							<table width="831" border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td width="100%">
									<div align="center" class="boldEleven"><strong>Staff
									Manual Attendance Information</strong> <%
					  	sql = "SELECT DT_TIMEIN,DT_TIMEOUT,DT_LOGIN,DT_LOGOUT,INT_TOTALHOUR,INT_TOTALMIN,CHR_SHIFTCODE,";
						sql = sql +"CHR_PRESENTTYPE,CHR_LATE,CHR_TYPE FROM ATT_SMART_ATTENDANCE WHERE CHR_EMPID = '"+staff+"'";
						sql = sql +"AND  CHR_LOGMONTH ='"+month+"' AND INT_LOGYEAR = "+year+" ORDER BY DT_LOGIN";
						 
					  %>
									</div>
									</td>
								</tr>
								<tr>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td>
									<table width="468" border="0" align="center" cellpadding="1"
										cellspacing="1">
										<tr>
											<td class="boldEleven"><strong>Staff Id <span
												class="style3">::</span></strong></td>
											<td class="boldEleven"><strong><strong><%=staff%></strong></strong></td>
											<td width="20" class="boldEleven">&nbsp;</td>
											<td class="boldEleven"><strong>Staf Name <span
												class="style3">::</span></strong></td>
											<td class="boldEleven"><strong><strong><%=staffname%></strong></strong></td>
											<td width="17" class="boldEleven">&nbsp;</td>
										</tr>
									</table>
									</td>
								</tr>
								<tr>
									<td></td>
								</tr>
								<tr>
									<td height="19" class="boldEleven">
									<table width="783" border="0" cellpadding="1" cellspacing="1">
										<tr class="boldEleven">
											<td width="11">&nbsp;</td>
											<td width="90"><strong>S.No</strong></td>
											<td width="87"><strong>Time In </strong></td>
											<td width="73"><strong>Time Out </strong></td>
											<td width="99"><strong>Login</strong></td>
											<td width="85"><strong>Logout</strong></td>
											<td width="38"><strong>Hour </strong></td>
											<td width="60"><strong>Minutes </strong></td>
											<td width="39"><strong> Code </strong></td>
											<td width="97"><strong>Present Type </strong></td>
											<td width="52"><strong>Late</strong></td>
											<td width="45"><strong>Type</strong></td>
										</tr>
									</table>
									</td>
								</tr>
								<tr>
									<td height="19">
									<%
					
					String tableRow[] =com.my.org.erp.bean.Attendance.StaffRegistration.getTableAllValue(sql).split("#") ;
					boolean bgflag=false;
				
					out.println("<div  id='divscroll' style='OVERFLOW: auto;width:810px;height:190px'>");
					out.println("<table width='100%'>");
					for(int u=0; u<tableRow.length;u++)
					{
						String s[] = tableRow[u].split("~");
						String q = staff +"~" +s[2]+"~";
						if(bgflag)
						{
							bgflag = false;
							out.println("<tr class='MRow2'>");
							out.print("<td width=14 ><input type='checkbox' name='staffid' id='staffid' value='"+q+"'>");
							out.println("<td width=52>"+(u+1));
						}	
						else
						{
							bgflag = true;
							out.println("<tr class='MRow1'>");
							out.print("<td width=14 ><input type='checkbox' name='staffid' id='staffid' value='"+q+"'>");
							out.println("<td width=52>"+(u+1));
						}											
						out.println("<td width=86>&nbsp;<a href='StaffManualAttendanceUpdate.jsp?staffid="+q+"'>"+s[0]+"</a>");
						out.println("<td width=107>&nbsp;"+s[1]);
						out.println("<td width=107>&nbsp;"+(s[2]));
						out.println("<td width=96>&nbsp;"+s[3]);
						out.println("<td width=38>&nbsp;"+s[4]);
						out.println("<td width=60>&nbsp;"+s[5]);
						out.println("<td width=42>&nbsp;"+s[6]);
						out.println("<td width=100>&nbsp;"+s[7]);
						out.println("<td width=31>&nbsp;"+s[8]);
						out.println("<td width=86>&nbsp;"+s[9]);
						
						
					
					}
					out.println("</table>");
					out.println("</div>");
				
					
				%> <input name="filename" type="hidden" id="filename"
										value="StaffManualAttendance"> <input name="actionS"
										type="hidden" id="actionS"
										value="ATTStaffManualAttendanceDeletes"></td>
								</tr>
								<tr>
									<td height="34">
									<table border="0" align="center" cellpadding="1"
										cellspacing="1">
										<tr>
											<!--<td  width="56" >
						  <input name="Submit1" type="submit" class="buttonbold" value="Update" onClick=" return Edit()"></td>-->

											<td width="56"><input name="Submit2" type="submit"
												class="buttonbold" value="Delete" onClick=" return Delete()"></td>
											<td width="56"><input name="Submit3" type="Button"
												class="buttonbold"  value="Close"   accesskey="c" 
												onClick="javascript:history.back()"></td>
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
		</td>
	</tr>
	<tr>
		<td><%@ include file="../footer.jsp"%> <%
}
catch(Exception  er)
{
	out.println(er);
}
%>
		</td>
	</tr>
</table>
</form>
</body>
</html>
