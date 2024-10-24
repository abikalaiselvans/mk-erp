<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="../error/index.jsp"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="com.my.org.erp.ServiceLogin.DateUtil"%>
<%@include file="Redirect.jsp" %>

<% 
try
{
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title><%= CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='ATT' ")[0][0]%></title>
  <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
 </head>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/Attendance/StaffPermissionLeave.js"></script>


<script language="javascript">

	function Add()
	{ 
		document.frm.action="ifOnlineApply.jsp";
 	}

</script> 

<script language="JavaScript">
 

 
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
	 
		
//-->

</script>
<body  onpaste="return false;"  onload="StaffloadPermissionLeave()">
<form  AUTOCOMPLETE = "off"   name="frm" method="get" action="">
<p>&nbsp;</p>
<table border="0" align="center" cellpadding="0"
	cellspacing="0">
	<tr>
		<td width="489">&nbsp;</td>
	</tr>

	<tr>
		<td><span class="tablehead"><span class="boldEleven">
		<%
			String userid = ""+session.getAttribute("USRID");
			
			String sql ="";
			sql = "SELECT CHR_EMPID,CHR_TYPE  ,CHR_STAFFNAME FROM com_m_staff WHERE CHR_EMPID = '"+session.getAttribute("EMPID")+"'";
			 
			String staff  = CommonFunctions.QueryExecute(sql)[0][0];
			userid = ""+session.getAttribute("USRID");
			
			String ptype = CommonFunctions.QueryExecute(sql)[0][1];
			String staffname= CommonFunctions.QueryExecute(sql)[0][2];
			
			%> </span></span></td>
	</tr>
	<tr>
		<td>
		<table width="700" border="0" align="center" cellpadding="0"
			cellspacing="0" bgcolor="#dce4f9" class="BackGround">
			<tbody>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></td>
					<td width="222" height="1" class="BorderLine"><spacer
						height="1" width="1" type="block" /></td>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
				</tr>
				<tr>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
					<td width="6"><spacer height="1" width="1" type="block" /></td>
					<td valign="top">
					<table width="700" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td width="100%">
							<div align="center" class="boldEleven"><strong>LEAVE/ PERMISSION STSTUS </strong></div>							</td>
						</tr>
						<tr>
							<td>
							<div align="right"><span class="article style3">* </span><span
								class="changePos">Mandatory</span></div>							</td>
						</tr>
						 
						<tr>
							<td height="36">
							<table width="500" border="0" align="center" cellpadding="0"
								cellspacing="0">
								<tr>
									<td width="47" class="bold1">Staff id</td>
									<td width="44" class="boldEleven"><%=staff%></td>
								    <td width="82" class="bold1">&nbsp;</td>
								    <td width="82" class="bold1">Staff Name</td>
								    <td width="23" class="boldEleven"><%=staffname%></td>
								</tr>
							</table>							</td>
						</tr>
						<tr>
						  <td height="18"><table width="80%" border="0" align="center" cellpadding="0" cellspacing="0">
                            <tr>
                              <td class="bold1">Type</td>
                              <td><select name="leavetype" id="leavetype"    onblur="StaffloadPermissionLeave()">
                                <option value="0">All</option>
                                <option value="PERMISSION">PERMISSION</option>
                                <option value="LEAVE">LEAVE</option>
                              </select></td>
                              <td class="bold1">&nbsp;</td>
                              <td>&nbsp;</td>
                              <td class="bold1">Status</td>
                              <td><select name="Status" id="Status"    onblur="StaffloadPermissionLeave()">
                                <option value="0">All</option>
                                <option value="P">PENDING</option>
                                <option value="A">ACCEPTED</option>
                                <option value="R">REJECTED</option>
                              </select></td>
                               
                            </tr>
                            <tr>
                              <td class="bold1">Month</td>
                              <td><span class="boldThirteen">
                                <select name="month" class="formText135" onChange="StaffloadPermissionLeave()" 
							id="month"  onblur="StaffloadPermissionLeave()">
                                  <%@ include file="../JavaScript/months.jsp"%>
                                </select>
                              </span></td>
                              <td class="bold1">Year</td>
                              <td><span class="boldThirteen">
                                <select name="year" class="formText135"
							id="year"    onblur="StaffloadPermissionLeave()">
                                  <%@ include file="../JavaScript/years.jsp"%>
                                </select>
                                <script language='JavaScript' type="text/javascript">
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
                              <td class="bold1">Day</td>
                              <td><select name="day" id="day"    onblur="StaffloadPermissionLeave()">
                                  <option value="0">All</option>
                                  <%
						for(int u=1;u<32;u++)
							out.println("<option value='"+(u)+"'>"+u+"</option>");
						%>
                                </select>                              </td>
                              
                            </tr>
                          </table></td>
					  </tr>
						<tr>
						  <td height="18">&nbsp;</td>
					  </tr>
						<tr>
							<td height="18">
							
							<div id="PermissionLeaveTable" style="OVERFLOW: auto;width:100%;height:auto">			  </div>							 						</td>
						</tr>
					</table>
					</td>
					<td nowrap="nowrap" width="4"><spacer height="1" width="1"
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
					<td class="BorderLine" height="1"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
			</tbody>
		</table>
		</td>
	</tr>
	<tr>
		<td>
		<table border="0" align="center" cellpadding="3" cellspacing="5">
			<tr>
				<td width="56"><input type="submit"	class="buttonbold" name="action1"  value="Add"   accesskey="s"   onClick="Add()" /></td>
				<td width="56"><input class="buttonbold" type="button"
					name="Button"  value="Close"   accesskey="c"  onClick="redirect('iframeStaffMain.jsp')"></td>
			</tr>
		</table>
		</td>
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