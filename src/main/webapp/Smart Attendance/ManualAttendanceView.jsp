<%@ page import="java.io.*,java.util.*" isErrorPage="false"
	errorPage="./error.jsp"%>
<%@ page import="com.my.org.erp.bean.Attendance.ManualAttendance"%>
<html>
<head>

<title> :: ATTENDANCE ::</title>


<script language="javascript">    
	function Delete()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].OptManualName
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
			if (document.forms[0].OptManualName.checked) { count=1;}
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
 	function mainPage()
	{
  	    //document.frm.action="../RemoveSession";
  	    //document.frm.submit();
		history.back(1);
    } 
</script>
</head>
 
<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   method="get" name='frm'>
<table align="center">
	<tr>
		<td><br>
		</td>
	</tr>
</table>
<table width="100%" border="0">
	<tr>
		<td height="278">
		<table border="1" align="center"  >
			<tr class="tablehead" bgcolor="#6E8FBC">
				<td class="tablehead"  height="30">Employee Id</td>
				<td class="tablehead"  height="30">Employee
				Name</td>
				<td class="tablehead"  height="30" width="174">Date</td>
				<td class="tablehead"  height="30">In Time</td>
				<td class="tablehead"  height="30">Out Time</td>
			</tr>
			<% 
			ArrayList manualList=(ArrayList) session.getAttribute("manualList");
			for(int i=0;i<manualList.size();i++)
			{
				ManualAttendance manual= (ManualAttendance)manualList.get(i);
%>
			<tr class="bolddeepblue">
				<td>
				<%
				String val=manual.getEmpId()+"@"+manual.getDate();
			%> <input type="checkbox" name="OptManualName" value='<%= val%>'>
				<%=manual.getEmpId() %></td>
				<td><%=manual.getEmpName() %></td>
				<td><%=manual.getDate() %></td>
				<td><%=manual.getInTime() %></td>
				<td><input type="hidden" name="filename"
					value="ManualAttendance"> <input type="hidden"
					name="actionS" value="ATTmanualDelete"> <%=manual.getOutTime() %>
				</td>
			</tr>
			<%
			}
			String dis="";
			if(manualList.size()==0) dis="disabled='disabled'";
			//session.removeAttribute("courseList");
	//		stateId=request.getParameter("stateId");
%>

		</table>
		<table border="0" align="center" cellpadding="2" cellspacing="2">
			<tr>
				<td width="56"><input name="Submit" type="Submit"
					class="buttonbold" onClick="return Delete()" value="Delete"
					<%=dis %>></td>
				<td width="56"><input name="Button" type="button"
					class="buttonbold"  value="Close"   accesskey="c"  onClick="mainPage()"></td>
			</tr>
		</table>
		<p>&nbsp;</p>
		</td>
	</tr>
</table>
<p>&nbsp;</p>
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
