<%@ page import="java.io.*,java.util.*" isErrorPage="false"
	errorPage="./error.jsp"%>
<%@ page import="com.my.org.erp.bean.Attendance.Permission"%>
<html>
<head>

<title> :: ATTENDANCE ::</title>


<script language="javascript">    
	function Delete()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].OptPermissionName
		txt=""
		for (i=0;i<coffee1.length;++ i)
		{
			if (coffee1[i].checked)
			{
			count=count+1;
			}
		}
		if(count==0)
		{
			if (document.forms[0].OptPermissionName.checked) { count=1;}
		}
		if(count>=1){			
			var name=confirm("Confirm to Delete")
			if (name==true)
			{ 
				
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
		}		}
		function AddPage()
		{			
		  document.frm.action="PermissionAdd.jsp";   
		}
		function mainPage()
		{			
		  //document.frm.action="../RemoveSession";   
		  history.back(1);
		}

 	
</script>
</head>
<%@ include file="index.jsp"%>
 
<p>&nbsp;</p>
<p>&nbsp;</p>
<form  AUTOCOMPLETE = "off"   method="get" name='frm' action="../SmartLoginAuth">
<table align="center" height="40%">
	<tr>
		<td height="257" valign="top">
		<table align="center">
			<tr>
				<td>
				<table border="1" align="center"  >
					<tr class="tablehead" bgcolor="#6E8FBC">
						<td class="tablehead"  height="30">
						<div align="center">Employee Id</div>
						</td>
						<td class="tablehead"  height="30">
						<div align="center">Employee Name</div>
						</td>
						<td class="tablehead"  height="30">
						<div align="center">Permission Date</div>
						</td>
						<td class="tablehead"  height="30">
						<div align="center">From Time</div>
						</td>
						<td class="tablehead"  height="30">
						<div align="center">To Time</div>
						</td>
						<td class="tablehead"  height="30">
						<div align="center">Type</div>
						</td>
					</tr>
					<% 
			ArrayList permissionList=(ArrayList) session.getAttribute("permissionList");
			for(int i=0;i<permissionList.size();i++)
			{
				Permission perm=(Permission)permissionList.get(i);
%>
					<tr class="bolddeepblue">
						<td>
						<%
				String val=perm.getEmpId()+"@"+perm.getDate();
			%> <input type="checkbox" name="OptPermissionName" value='<%= val%>'>
						<%=perm.getEmpId() %></td>
						<td>&nbsp; <%=perm.getEmpName() %></td>
						<td>&nbsp; <%=perm.getDate() %></td>
						<td>&nbsp; <%=perm.getFromTime() %></td>
						<td>&nbsp;<%=perm.getToTime() %></td>
						<td>&nbsp;<%=perm.getReason() %></td>
					</tr>
					<%
			}
			String dis="";
			if(permissionList.size()==0) dis="disabled='disabled'";
			//session.removeAttribute("courseList");
	//		stateId=request.getParameter("stateId");
%>
					<tr>
						<td align="center" colspan="6"><input type="hidden"
							name="filename" value="Permission"> <input type="hidden"
							name="actionS" value="ATTpermissionDelete"></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		<div align="center">
		<table border="0">
			<tr>
				<td width="56"><input name="Submit" type="Submit"
					class="buttonbold" onClick="AddPage()" value="Add"></td>
				<td width="56"><input name="Submit" type="Submit"
					class="buttonbold" onClick="return Delete()" value="Delete"
					<%=dis %>></td>
				<td width="56"><input name="Submit" type="button"
					class="buttonbold" onClick="mainPage()"  value="Close"   accesskey="c" ></td>
			</tr>
		</table>
		<% 
	String msg=""+request.getParameter("message");
	if(!msg.equals("null")){
%>
		</div>
		<CENTER>
		<table width="23%" border="1" cellspacing="2" cellpadding="2"
			 >

			<tr>
				<td align="center" class="tabledata"><%=msg%></td>
			</tr>
			<% } %>
		</table>
		</CENTER>
		</td>
	</tr>
</table>
</form>

<%@ include file="../footer.jsp"%>
</body>
</html>
