<%@ page import="java.io.*,java.util.*" isErrorPage="false"
	errorPage="./error.jsp"%>
<%@ page import="com.my.org.erp.bean.Attendance.LeaveEntry"%>

<html>
<head>

<title> :: ATTENDANCE ::</title>


<script language="javascript">    
	function Delete()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].OptLeaveName
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
			if (document.forms[0].OptLeaveName.checked) { count=1;}
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
		}		
 	} 
	 function mainPage()
	{
  	    //document.frm.action="../RemoveSession";
  	    //document.frm.submit();
		history.back(1);
    } 
     function AddPage()
	{
  	    document.frm.action="Leave EntryAdd.jsp";
  	    document.frm.submit();
    } 
</script>
</head>
 
<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   method="get" name='frm' action="../SmartLoginAuth"><br>
<br>
<br>
<br>
<table width="758" align="center" height="50%">
	<tr>
		<td height="91" valign="top">
		<table border="1" align="center"   width="100%">
			<tr class="tablehead" bgcolor="#6E8FBC">
				<td class="tablehead"  height="30">
				<div align="center" class="tablehead">Employee Id</div>
				</td>
				<td class="tablehead"  height="30">
				<div align="center" class="tablehead">Employee Name</div>
				</td>
				<td class="tablehead"  height="30">
				<div align="center" class="tablehead">Leave Type</div>
				</td>
				<td class="tablehead"  height="30">
				<div align="center" class="tablehead">From Date</div>
				</td>
				<td class="tablehead"  height="30">
				<div align="center" class="tablehead">To Date</div>
				</td>
			</tr>
			<% 
			ArrayList leaveList=(ArrayList) session.getAttribute("leaveList");
			for(int i=0;i<leaveList.size();i++)
			{
				LeaveEntry leave=(LeaveEntry)leaveList.get(i);
%>
			<tr class="bolddeepblue">
				<td>
				<%
				String val=leave.getLeaveId();
			%> <input type="checkbox" name="OptLeaveName" value='<%= val%>'>
				<%=leave.getEmpId() %></td>
				<td>&nbsp; <%=leave.getEmpName() %></td>
				<td>&nbsp; <%=leave.getLeaveType()%></td>
				<td>&nbsp; <%=leave.getFromDate() %></td>
				<td>&nbsp; <%=leave.getToDate() %></td>
			</tr>
			<%
			}
			String dis="";
			if(leaveList.size()==0) dis="disabled='disabled'";
			//session.removeAttribute("courseList");
	//		stateId=request.getParameter("stateId");
%>
		</table>
		<br>
		<table border="0" align="center" cellpadding="2" cellspacing="2">
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
		</td>
	</tr>
</table>
<input type="hidden" name="filename" value="LeaveEntry"> <input
	type="hidden" name="actionS" value="ATTleaveDelete">
<p>
<% 
	String msg=""+request.getParameter("message");
	if(!msg.equals("null")){
%>
</p>
<CENTER>
<table width="23%" border="1" cellspacing="2" cellpadding="2"
	 >

	<tr>
		<td align="center" class="tabledata"><%=msg%></td>
	</tr>
	<% } %>
</table>
</CENTER>

</form>

<%@ include file="../footer.jsp"%>
</body>
</html>
