<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage=""%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
%>

<head>
<title> :: ATTENDANCE ::</title>
<link href="../JavaScript/SmartStyles.css" rel="stylesheet" type="text/css" />
</head>
<script language="javascript" src="../JavaScript/comfunction.js" /></script>
<script language="javascript" src="../JavaScript/Attendance/loadPermissionLeaveRegisterMark.js" ></script>

<script language="javascript">

 
	
	 function  Delete()
 	{		
		
		obj = findObj("rowid");
		if(obj == null)
		{
			alert("No records  to delete...");
			return false;
		}
			
		
		
		var count;
		count=0;
		c1=document.forms[0].rowid;
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
			if (document.forms[0].rowid.checked) { count=1;}
		}
		
		if(count>=1){			
			var name=confirm("Confirm to Mark")
			if (name==true)
			{ 
				document.frm.action="../SmartLoginAuth";
				document.frm.submit();
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
	 

</script> 
 
<body  onpaste="return false;" onLoad="loadPermissionLeaveRegisterMark('0')">
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
			  <td   height="28" class="whiteMedium" >Leave  &amp; Permission Transfer to Register
			  <%
			  String er =""+request.getParameter("er");
			  if(er.length()>5)
			  {
			  %>
			  <script language="javascript">alert("<%=er%>")</script>
			  <%
			  }
			  %>
			  </td>
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
                  <td>                    <select name="Office" class="formText135" id="Office"  tabindex="6" onChange="loadPermissionLeaveRegisterMark('0')" style="width:150" >
                      <%
		if("F".equals(usertype)  || "B".equals(usertype) ) 
			out.print("<option value='0' >All</option>");
		 
		
			
	String OfficeData[][] =  CommonFunctions.QueryExecute(" SELECT b.INT_OFFICEID,b.CHR_OFFICENAME FROM  com_m_office  b WHERE b.INT_OFFICEID IN("+ CommonFunctions.QueryExecute("SELECT a.CHR_OFFICELIST FROM m_user a WHERE a.CHR_USRNAME='"+userid+"' ")[0][0]+" )");
 if(OfficeData.length>0)
 	for(int u=0;u<OfficeData.length;u++)
		if(OfficeData[u][0].trim().equals(oficeid.trim()))
				out.print("<option selected = 'selected' value='"+OfficeData[u][0]+"'>"+OfficeData[u][1] +"</option>");
			else
				out.print("<option value='"+OfficeData[u][0]+"'>"+OfficeData[u][1] +"</option>");
 
	
		
		
		 
		
				
							%>
                    </select>                  </td>
				  <td   >Staff </td>
						<td colspan="3" ><select name="staffid" class="formText135" id="staffid"   onBlur="loadPermissionLeaveRegisterMark('0') " style="width:150" >
                            <option value="0">All</option>
                            <%
 String empdata[][] =  CommonFunctions.QueryExecute(" SELECT  CHR_EMPID,CHR_STAFFNAME FROM com_m_staff WHERE   CHR_TYPE!='T' AND INT_OFFICEID= "+oficeid+" AND CHR_HOLD!='Y'  ORDER BY CHR_STAFFNAME ");
		for(int u=0; u<empdata.length; u++)
			out.print("<option value='"+empdata[u][0]+"'>"+empdata[u][1] +"</option>");
%>
                          </select>                        </td>
						
						<td >Type </td>
					    <td><select name="leavetype" id="leavetype"  onBlur="loadPermissionLeaveRegisterMark('0') " style="width:150" >
						<option value="0">All</option>
						<option value="PERMISSION">PERMISSION</option>
						<option value="LEAVE">LEAVE</option>
						
						 
						 
						  </select>					    </td>
                </tr>
                <tr>
                  <td  >Day</td>
                  <td><select name="day" id="day"  onBlur="loadPermissionLeaveRegisterMark('0') " style="width:150" >
                    <option value="0">All</option>
                    <%
						for(int u=1;u<32;u++)
							out.println("<option value='"+(u)+"'>"+u+"</option>");
						%>
                  </select></td>
                  <td   >Month</td>
                  <td ><span class="boldThirteen">
                    <select name="month" class="formText135"
							id="month"  onBlur="loadPermissionLeaveRegisterMark('0') " style="width:150" >
                      <%@ include file="../JavaScript/months.jsp"%>
                    </select>
                  </span></td>
                  <td >Year</td>
                  <td><span class="boldThirteen">
                    <select name="year" class="formText135"
							id="year"  onBlur="loadPermissionLeaveRegisterMark('0') " style="width:150" >
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
                  <td><select name="Status" id="Status"    onBlur="loadPermissionLeaveRegisterMark('0')" style="width:150" >
                    <option value="0">All</option>
                    <option value="Y">MARK</option>
                    <option value="N">UNMARK</option>
                  </select></td>
                </tr>
              </table></td>
		  </tr>
			 
			<tr bgcolor="#FFFFFF">
			  <td valign="top">
			  <div id="PermissionLeaveTable" style="OVERFLOW: auto;width:100%;height:250px">			  </div>
			  <br><br><br>
				<div id='totRec' align="center"></div>
				<br><br><br>			  </td>
		  </tr>
			<tr>
				<td valign="top">				</td>
			</tr>
		</table>		</td>
	</tr>
	<tr>
	  <td><input name="filename" type="hidden"
			id="filename" value="StaffPermission">
        <input name="actionS"
			type="hidden" id="actionS" value="ATTStaffPermissionLeaveTransfer"></td>
    </tr>
	<tr>
	  <td><table width="90%" border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
        <tr class="para">
          <td><div align="center"><a class="whiteMedium" href="javascript:loadPermissionLeaveRegisterMark('0')">All</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadPermissionLeaveRegisterMark('A')">A</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadPermissionLeaveRegisterMark('B')">B</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadPermissionLeaveRegisterMark('C')">C</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadPermissionLeaveRegisterMark('D')">D</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadPermissionLeaveRegisterMark('E')">E</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadPermissionLeaveRegisterMark('F')">F</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadPermissionLeaveRegisterMark('G')">G</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadPermissionLeaveRegisterMark('H')">H</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadPermissionLeaveRegisterMark('I')">I</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadPermissionLeaveRegisterMark('J')">J</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadPermissionLeaveRegisterMark('K')">K</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadPermissionLeaveRegisterMark('L')">L</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadPermissionLeaveRegisterMark('M')">M</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadPermissionLeaveRegisterMark('N')">N</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadPermissionLeaveRegisterMark('O')">O</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadPermissionLeaveRegisterMark('P')">P</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadPermissionLeaveRegisterMark('Q')">Q</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadPermissionLeaveRegisterMark('R')">R</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadPermissionLeaveRegisterMark('S')">S</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadPermissionLeaveRegisterMark('T')">T</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadPermissionLeaveRegisterMark('U')">U</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadPermissionLeaveRegisterMark('V')">V</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadPermissionLeaveRegisterMark('W')">W</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadPermissionLeaveRegisterMark('X')">X</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadPermissionLeaveRegisterMark('Y')">Y</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadPermissionLeaveRegisterMark('Z')">Z</a></div></td>
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
			  <td width="56"><input class='ButtonHead' type='submit' onClick='return  Delete()' name='Submit' id='Submit' value='Mark'></td>
			  
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
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>