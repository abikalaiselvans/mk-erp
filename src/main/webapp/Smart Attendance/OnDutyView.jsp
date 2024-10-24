<%@ page import="java.io.*,java.util.*" isErrorPage="false"
	errorPage="./error.jsp"%>
<%@ page import="com.my.org.erp.bean.Attendance.OnDuty"%>
<%!
	ArrayList empdata = new ArrayList();
%>
<html>
<head>

<title> :: ATTENDANCE ::</title>


<script language="javascript">    
	function Delete()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].OptOnDutyName
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
			if (document.forms[0].OptOnDutyName.checked) { count=1;}
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
		history.back(1);
    }
    function AddPage()
	{
  	    document.frm.action="OnDutyAdd.jsp";
    }
</script>
</head>
 
<%@ include file="index.jsp"%>
<body  onpaste='return false;'>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<form  AUTOCOMPLETE = "off"   method="get" name='frm'>
<table border="1" align="center"   width="920">
	<tr class="tablehead" bgcolor="#6E8FBC">
		<td class="tablehead"  height="30" width="157">
		<div align="center" class="tablehead">Employee Id</div>
		</td>
		<td class="tablehead"  height="30" width="180">
		<div align="center" class="tablehead">Employee Name</div>
		</td>
		<td class="tablehead"  height="30" width="163">
		<div align="center" class="tablehead">On Duty Date</div>
		</td>
		<td class="tablehead"  height="30" width="166">
		<div align="center">Day Type</div>
		</td>
		<td width="150" height="30"  class="tablehead">
		<div align="center">Place</div>
		</td>
		<td class="tablehead"  height="30" width="164">
		<div align="center">Reason</div>
		</td>
	</tr>
	<% 
			ArrayList dutyList=(ArrayList) session.getAttribute("dutyList");
			for(int i=0;i<dutyList.size();i++)
			{
				OnDuty duty= (OnDuty)dutyList.get(i);
%>

	<%
					String val=duty.getEmpId()+"@"+duty.getODDate();
				%>
	<tr class="bolddeepblue">
		<td width="157"><input type="checkbox" name="OptOnDutyName"
			value='<%= val%>'> <%= duty.getEmpId() %></td>
		<td width="180"><%=duty.getEmpName() %></td>
		<td>&nbsp; <%=duty.getODDate() %></td>
		<td>&nbsp;<%=duty.getDayType() %></td>
		<td>&nbsp;<%=duty.getPlace() %></td>
		<td width="164">&nbsp;<%=duty.getReason() %></td>
	</tr>
	<%
			}
			String dis="";
			if(dutyList.size()==0) dis="disabled='disabled'";
			//session.removeAttribute("courseList");
	//		stateId=request.getParameter("stateId");
%>
</table>
<input type="hidden" name="filename" value="OnDuty"> <input
	type="hidden" name="actionS" value="ATTondutyDelete">
<table border="0" align="center" cellpadding="2" cellspacing="2">
	<tr>
		<td width="56"><input name="Button" type="Submit"
			class="buttonbold"  value="Add"   accesskey="s"   onClick="AddPage()"></td>
		<td width="56"><input name="Submit" type="Submit"
			class="buttonbold" onClick="return Delete()" value="Delete" <%=dis %>></td>
		<td width="56"><input name="Button" type="button"
			class="buttonbold"  value="Close"   accesskey="c"  onClick="mainPage()"></td>
	</tr>
</table>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>
<% 
	String msg=""+request.getParameter("message");
	if(!msg.equals("null")){
%>
</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
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
