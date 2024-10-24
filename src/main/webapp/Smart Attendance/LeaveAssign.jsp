<%@ page language="java" import="java.sql.*" errorPage="../error/index.jsp"%>
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
%>
<title> :: ATTENDANCE ::</title>

<%
String dojlock= CommonFunctions.QueryExecute(" SELECT INT_DATLOCK FROM M_INSTITUTION WHERE INT_ID=1 ")[0][0];
%>
 
<script language="JavaScript" src="../JavaScript/AJAXFunction.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/Attendance/AttendanceAjax.js"></script>

<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
<script>
	var dojlock= "<%=dojlock%>";
	$(function() {
		$( "#fromdate" ).datepicker({ changeMonth: true,
			showOn: "button",
			minDate: "-55D", maxDate: "+0D" ,
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			numberOfMonths: 1,
			buttonImageOnly: true });
	});
</script>
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">






<script language="JavaScript">
function validateFields()
{
	try
	{
		var d1 = document.getElementById('fromdate').value;
		var dd1 = d1.split("-");
		var ds = compute(dd1[0],dd1[1],dd1[2]) ;
		if(ds=="Sunday")
		{
			alert("You are selecting Sunday");
			return false;
		}
		var cm = dd1[1];
		var cy = dd1[2];
		var sm = document.getElementById('smonth').value;
		var sy = document.getElementById('syear').value;
		
		var l = false;
		if((cm == sm) && (cy==sy))
			l = true;
		else
		{
			alert("Confirm with your date");
			l= true;
		}
		var dl = document.getElementById('dtflag').value;
		if(dl == "N")
			l = true;
 		if(!l)
		{
			document.getElementById('fromdate').focus();
			return false;
		}	
 	var f =document.getElementById('check').value;
	 		if( checkNull('Available','Enter Available Leave') 
			&& checkNull('fromdate','Enter From Date...')
			 
			)
		{	
 	 	  	
			return true;
			
		}
		else
		{
	   		return false;	  
		}   
	}
	catch(err)
	{
		alert(err.description);
		return false;
	}	
}  	



</script>
<style type="text/css">
<!--
body {
	background-color: #efefef;
}
-->
</style>
<link href="../JavaScript/SmartStyles.css" rel="stylesheet" type="text/css" />
<body  onpaste='return false;'>

<form  AUTOCOMPLETE = "off"   id="LeaveAssignfrm" name="LeaveAssignfrm" method="post"
	action="../SmartLoginAuth" onSubmit="return validateFields()"><br />
<table width="349" border="0" align="center" cellpadding="0"
	cellspacing="0">

	<tr>
		<td width="357">
		<table width="384" border="1" align="center" cellpadding="0"
			cellspacing="0"  >
			<tr>
				<td width="430" height="27"
					  class="boldEleven">
				<div align="center"><strong>LEAVE </strong></div>
				</td>
			</tr>
			<tr>
				<td>
				<table width="382" height="309" border="0" align="center"
					cellpadding="2" cellspacing="0" bgcolor="#efefef">
					<tr>
						<td colspan="4" class="boldEleven">
						<%
					  		
							String er=(""+request.getParameter("er")).trim();
							if(! er.equals("null"))
							{
								
								String val[] = er.split("~");
								out.println("<div id='onduty' style='OVERFLOW:auto;width:350px;height:300px' >");
								out.println("<center><table>");
								out.println("<tr class='MRow1'>");
								out.println("<td colspan=3 class='bolddeepred'>Already Entered the following...");
								out.println("<tr class='MRow2'>");
								out.println("<td class='bolddeepred'><input name='Button' class='buttonbold' type='button'  id='Button' value='Close' onclick='javascript:window.close()' /><td><td>");
								
								out.println("<tr class='MRow1'>");
								out.println("<td width='50' class ='boldEleven' ><b>Staffid</b><td width='250' class ='boldEleven' ><b>Date</b><td width='250' class ='boldEleven' ><b>Description</b>");
								for(int u=0; u<val.length; u++)
								{
									
									if(u%2==1)
										out.println("<tr class='MRow1'>");
									else
										out.println("<tr  class='MRow2'>");	
									String values[] = val[u].split(",");
									out.println("<td width='50' class ='boldEleven' >"+values[1]);
									out.println("<td width='80' class ='boldEleven' >"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(values[0]));
									out.println("<td width='90' class ='boldEleven' >"+values[2]);
									
								}
								
								out.println("<td colspan='2'></table></center></div>");
							}	
					  %>						</td>
					</tr>
					<tr>
						<td width="19" class="boldEleven">&nbsp;</td>
						<td width="81" class="boldEleven">Staff Id <%

	  	String A =request.getParameter("A");
	  	String E =request.getParameter("E");
	 	String staffid =request.getParameter("staffid");
	  	String colum =request.getParameter("INT_NOD1");
	  	int leave = Integer.parseInt(request.getParameter("leave"));
		 
		String Leaves[][]= CommonFunctions.QueryExecute("SELECT CHR_SYMBOL FROM att_m_leavetype ORDER BY INT_LEAVEID");
	 	String LeaveNames[][]= CommonFunctions.QueryExecute("SELECT CHR_LEAVENAME FROM att_m_leavetype ORDER BY INT_LEAVEID");
		String staffname= com.my.org.erp.bean.Attendance.StaffRegistration.staffName(staffid.trim());
	 	String Leaveids[][]= CommonFunctions.QueryExecute("SELECT INT_LEAVEID FROM att_m_leavetype ORDER BY INT_LEAVEID");
	 	
	    String leavesLimit[][]= CommonFunctions.QueryExecute("SELECT INT_LIMIT FROM att_m_leavetype ORDER BY INT_LEAVEID");
	  	String fs =com.my.org.erp.bean.Attendance.StaffRegistration.leaveTypeValue();
		String column[] = com.my.org.erp.bean.Attendance.StaffRegistration.leaveTypeValue().split("~");
		int fl= column.length;
		int al = 9-fl;
		String addfield="";
		if((fl+1)<10)
		{
			for(int u=(fl+1); u<=9; u++)
				addfield = addfield +"LEAVE"+u+"~";
		}	
		fs = fs+addfield;
		
		String columnName[]=fs.split("~");
		
		double a1 = Double.parseDouble(A);
		double e1 = Double.parseDouble(E);
		boolean flag =false;
		if (a1<e1)
		  	flag = true;
		else
		 	flag = false;
			
		 
	  %>						</td>
						<td width="240" class="boldEleven"><%=staffid%> <input
							name="staffid" type="hidden" id="staffid" value="<%=staffid%>" /></td>
						<td width="16" class="boldEleven">&nbsp;</td>
					</tr>
					<tr>
						<td class="boldEleven">&nbsp;</td>
						<td class="boldEleven">Staff Name</td>
						<td class="boldEleven"><%=staffname%></td>
						<td class="boldEleven">&nbsp;</td>
					</tr>
					<tr>
						<td class="boldEleven">&nbsp;</td>
						<td class="boldEleven">Leave Name</td>
						<td class="boldEleven">
						<%=LeaveNames[leave][0]%> 
						<input name="leave" type="hidden" id="leave" value="<%=Leaves[leave][0]%>" /> 
						<input name="leaveid" type="hidden" id="leaveid" value="<%=Leaveids[leave][0]%>" /> 
						<input	name="limit" type="hidden" id="limit"	value="<%=leavesLimit[leave][0]%>" />
						
						</td>
						<td class="boldEleven">&nbsp;</td>
					</tr>
					<tr>
						<td class="boldEleven">&nbsp;</td>
						<td class="boldEleven">Con- Limit</td>
						<td class="boldEleven"><%=leavesLimit[leave][0]%></td>
						<td class="boldEleven">&nbsp;</td>
					</tr>
					<tr>
						<td class="boldEleven">&nbsp;</td>
						<td class="boldEleven">Eligibility</td>
						<td class="boldEleven">
						
						<%
						String ss=" SELECT INT_NOD"+Leaveids[leave][0]+",INT_NOD"+Leaveids[leave][0]+"BALANCE FROM att_m_leave ";
						ss = ss+" WHERE CHR_EMPID='"+staffid+"'  AND INT_YEAR=year(now())";
						String leavedata[][]= CommonFunctions.QueryExecute(ss);
						E = leavedata[0][0];
						A = leavedata[0][1];
						%>
	
						
		<input class='formText135'	type='hidden' readonly size="6" name="Eligible" id="Eligible" value="<%=E%>" /><%=E%></td>
						<td class="boldEleven">&nbsp;</td>
					</tr>
					<tr>
						<td class="boldEleven">&nbsp;</td>
						<td class="boldEleven">Granted</td>
					  <td class="boldEleven">
			  <input class='formText135' type='hidden' readonly size="6" name="Available" id="Available" value="<%=A%>" /><%=A%>
					    <input name="check"	type="hidden" id="check" value="false" /></td>
						<td class="boldEleven">&nbsp;</td>
					</tr>
					<tr>
						<td class="boldEleven">&nbsp;</td>
						<td class="boldEleven">From <%
						
					String logintype[][]= CommonFunctions.QueryExecute("SELECT DAT_LOCK FROM m_institution");
					out.println("<input name=\"dtflag\" type=\"hidden\" value=\""+logintype[0][0]+"\" id=\"dtflag\">");
					
					String dat[][] = com.my.org.erp.common.CommonFunctions.DateExpansion();
					out.println("<input name=\"smonth\" type=\"hidden\" value=\""+dat[0][4]+"\" id=\"smonth\">");
					out.println("<input name=\"syear\" type=\"hidden\"  value=\""+dat[0][3]+"\" id=\"syear\">");
				%>						</td>
						<td class="boldEleven"><input name="fromdate" type="text"
							class="formText135" id="fromdate" size="15" maxlength="10"
							 
							title=" dd/mm/yyyy  " readonly  />  
							
							
							<script language='JavaScript'>setCurrentDate('fromdate');</script>( dd-mm-yyyy )</td>
						<td class="boldEleven">&nbsp;</td>
					</tr>
					
					<tr>
						<td height="23" colspan="4" class="boldEleven">
						<div id="queryTable"
							style="OVERFLOW: auto;width:400px;height:20px"></div>						</td>
					</tr>
					<tr>
						<td class="boldEleven">&nbsp;</td>
						<td class="boldEleven">Day</td>
						<td class="boldEleven">
						<table width="104%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td><input name="ComboDay" id="TxtDay" type="radio"
									value="Full Day" checked="checked" /></td>
								<td class="boldEleven">Full Day</td>
								<td class="boldEleven"><input name="ComboDay" type="radio" id="TxtDay1"
									value="Forenoon" /></td>
								<td class="boldEleven">Forenoon</td>
								<td class="boldEleven"><input name="ComboDay" type="radio" id="TxtDay2"
									value="Afternoon" /></td>
								<td class="boldEleven">Afternoon</td>
							</tr>
						</table>						</td>
						<td class="boldEleven">&nbsp;</td>
					</tr>
					<tr>
						<td class="boldEleven">&nbsp;</td>
						<td class="boldEleven">&nbsp;</td>
						<td class="boldEleven"><input name="filename" type="hidden"
							id="filename" value="StaffLeave" /> <input name="actionS"
							type="hidden" id="actionS" value="ATTStaffLeaveAssign" /></td>
						<td class="boldEleven">&nbsp;</td>
					</tr>
					<tr>
						<td class="boldEleven">&nbsp;</td>
						<td colspan="2" class="bolddeepred">
						<div align="center">
						<%
					 	if (flag == false)
						{
							out.println("Not Possible...");
						}	
				%>
						</div>						</td>
						<td class="boldEleven">&nbsp;</td>
					</tr>
					
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td height="46">

		<table width="125" border="0" align="center" cellpadding="5" cellspacing="5">
			<tr>
				<td width="56">
				  <div align="center">
				    <%
		  if(flag)
		   	{
			out.println("<input name='Submit' type='submit' class='buttonbold' 	value='Submit'   /> ");
			}
		 
		  %>
		          </div></td>
				<td width="56"><input name="Button" type="button"
					class="buttonbold" id="Button"  value="Close"   accesskey="c" 
					onclick="redirect('LeaveExit.jsp')" /></td>
			</tr>
		</table>


	  </td>
	</tr>
</table>
<script language="JavaScript">

function Valid()
{
	var s1 =document.getElementById("Eligible").value;
	var s2 =document.getElementById("Available").value;
	if((s1-s2)<0)
	{
	alert("Exceed the limit...");
	document.getElementById("Available").value ="";	
	}
		
}


 </script></form>

</body>
<%
}
catch(Exception e)
{
}

%>
