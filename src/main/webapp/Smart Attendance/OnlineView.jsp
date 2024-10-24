<%@ page import="com.my.org.erp.common.*"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<title> :: ATTENDANCE ::</title>


 
 
<link href="../JavaScript/SmartStyles.css" rel="stylesheet" type="text/css" />
</head>
<script language="javascript" src="../JavaScript/comfunction.js" /></script>
<script language="javascript" src="../JavaScript/Attendance/PermissionLeave.js" ></script>

<script language="javascript">

	function Add()
	{ 
		document.frm.action="OnlineApply.jsp";
 	}

</script> 
 
<body  onpaste="return false;" onLoad="loadPermissionLeave('0')">
<jsp:include page="index.jsp" />
<form  AUTOCOMPLETE = "off"   name="frm" method="get" action="">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>&nbsp;</td>
	</tr>

	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table width="90%" height="177" border="0" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"
			 >
			<!--DWLayoutTable-->
			<tr align="center" valign="middle" >
			  <td   height="28" class="whiteMedium" >PERMISSION / LEAVE  </td>
		  </tr>
			<tr align="center" valign="middle"   background="">
			  <td height="28" class="tablehead"><table width="90%" border="0" cellpadding="5" cellspacing="0" class="whiteMedium">
                <tr>
                  <td  >Office<span
					class="bold1">
<%

	String branchid=""+session.getAttribute("BRANCHID");
	String oficeid=""+session.getAttribute("OFFICEID");
	String usertype=""+session.getAttribute("USRTYPE");
	String empid=""+session.getAttribute("EMPID");
	 String userid=""+session.getAttribute("USRID");

%>
                  </span> </td>
                  <td>                    <select name="Office" class="formText135" id="Office"  tabindex="6" onChange="loadPermissionLeave('0')" style="width:150" >
                      <%
		if("F".equals(usertype)  || "B".equals(usertype) ) 
			out.print("<option value='0' >All</option>");
		 
		
			
	String OfficeData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(" SELECT b.INT_OFFICEID,b.CHR_OFFICENAME FROM  com_m_office  b WHERE b.INT_OFFICEID IN("+ CommonFunctions.QueryExecute("SELECT a.CHR_OFFICELIST FROM m_user a WHERE a.CHR_USRNAME='"+userid+"' ")[0][0]+" )");
 if(OfficeData.length>0)
 	for(int u=0;u<OfficeData.length;u++)
		if(OfficeData[u][0].trim().equals(oficeid.trim()))
				out.print("<option selected = 'selected' value='"+OfficeData[u][0]+"'>"+OfficeData[u][1] +"</option>");
			else
				out.print("<option value='"+OfficeData[u][0]+"'>"+OfficeData[u][1] +"</option>");
 
	
		
		
		 
		
				
							%>
                    </select>                  </td>
				  <td   >Staff </td>
						<td colspan="3" ><select name="staffid" class="formText135" id="staffid"   onBlur="loadPermissionLeave('0') " style="width:150" >
                            <option value="0">All</option>
                            <%
 String empdata[][] =  CommonFunctions.QueryExecute(" SELECT  CHR_EMPID,CHR_STAFFNAME FROM com_m_staff WHERE   CHR_TYPE!='T' AND INT_OFFICEID= "+oficeid+" AND CHR_HOLD!='Y'  ORDER BY CHR_STAFFNAME ");
		for(int u=0; u<empdata.length; u++)
			out.print("<option value='"+empdata[u][0]+"'>"+empdata[u][1] +"</option>");
%>
                          </select>                        </td>
						
						<td >Type </td>
					    <td><select name="leavetype" id="leavetype"  onBlur="loadPermissionLeave('0') " style="width:150" >
						<option value="0">All</option>
						<option value="PERMISSION">PERMISSION</option>
						<option value="LEAVE">LEAVE</option>
						
						 
						 
						  </select>					    </td>
                </tr>
                <tr>
                  <td  >Day</td>
                  <td><select name="day" id="day"  onBlur="loadPermissionLeave('0') " style="width:150" >
                    <option value="0">All</option>
                    <%
						for(int u=1;u<32;u++)
							out.println("<option value='"+(u)+"'>"+u+"</option>");
						%>
                  </select></td>
                  <td   >Month</td>
                  <td ><span class="boldThirteen">
                    <select name="month" class="formText135"
							id="month"  onBlur="loadPermissionLeave('0') " style="width:150" >
                      <%@ include file="../JavaScript/months.jsp"%>
                    </select>
                  </span></td>
                  <td >Year</td>
                  <td><span class="boldThirteen">
                    <select name="year" class="formText135"
							id="year"  onBlur="loadPermissionLeave('0') " style="width:150" >
                      <%@ include file="../JavaScript/years.jsp"%>
                    </select><script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						setOptionValue('month',month1);
						setOptionValue('year',year1);							
				//-->
          </script> 
                  </span></td>
                  <td >Status</td>
                  <td><select name="Status" id="Status"    onBlur="loadPermissionLeave('0')" style="width:150" >
                    <option value="0">All</option>
                    <option value="P">PENDING</option>
                    <option value="A">ACCEPTED</option>
                    <option value="R">REJECTED</option>
                  </select></td>
                </tr>
              </table></td>
		  </tr>
			<tr  >
				<td height="31" align="left" valign="middle" class="boldEleven">
				<table width="100%" border="0" class="whiteMedium"
					  >
					<tr>
						<td width="36">&nbsp;</td>
						<td width="128" valign="top">Staff
						Id</td>
						<td width="131" valign="top">Name</td>
						<td width="105">Date </td>
						<td width="198">Description</td>
						<td width="137">Reason</td>
						<td width="135">Type </td>
					</tr>
				</table>				</td>
			</tr>
			<tr bgcolor="#FFFFFF">
			  <td valign="top">
			  <div id="PermissionLeaveTable" style="OVERFLOW: auto;width:100%;height:250px">			  </div>
			  <br>
				<div id='totRec' align="center"></div>
				<br>			  </td>
		  </tr>
			<tr>
				<td valign="top">				</td>
			</tr>
		</table>		</td>
	</tr>
	<tr>
	  <td>&nbsp;</td>
    </tr>
	<tr>
	  <td><table width="90%" border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
        <tr class="para">
          <td><div align="center"><a class="whiteMedium" href="javascript:loadPermissionLeave('0')">All</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadPermissionLeave('A')">A</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadPermissionLeave('B')">B</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadPermissionLeave('C')">C</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadPermissionLeave('D')">D</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadPermissionLeave('E')">E</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadPermissionLeave('F')">F</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadPermissionLeave('G')">G</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadPermissionLeave('H')">H</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadPermissionLeave('I')">I</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadPermissionLeave('J')">J</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadPermissionLeave('K')">K</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadPermissionLeave('L')">L</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadPermissionLeave('M')">M</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadPermissionLeave('N')">N</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadPermissionLeave('O')">O</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadPermissionLeave('P')">P</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadPermissionLeave('Q')">Q</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadPermissionLeave('R')">R</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadPermissionLeave('S')">S</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadPermissionLeave('T')">T</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadPermissionLeave('U')">U</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadPermissionLeave('V')">V</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadPermissionLeave('W')">W</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadPermissionLeave('X')">X</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadPermissionLeave('Y')">Y</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadPermissionLeave('Z')">Z</a></div></td>
        </tr>
      </table></td>
    </tr>
	<tr>
	  <td>&nbsp;</td>
    </tr>
	<tr>
		<td>
		<table border="0" align="center" cellpadding="1" cellspacing="1">
			<tr>
			 <%
	 
	  if("F".equals(usertype))
	  {
	  %>
				<%
			}
			%>
				<td width="56"><input class="ButtonHead" type="button"
					name="Button" id="Button"  value="Close"   accesskey="c" 
					onclick="redirect('AttendanceMain.jsp')"></td>
			</tr>
		</table>		</td>
	</tr>
	
	<tr>
		<td><jsp:include page="../footer.jsp" /></td>
	</tr>
</table>
</form>

</body>
</html>
