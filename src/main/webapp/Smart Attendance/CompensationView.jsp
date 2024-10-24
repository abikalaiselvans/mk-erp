<%@ page import="java.io.*,java.util.*" isErrorPage="false"
	errorPage="./error.jsp"%>
<%@ page import="com.my.org.erp.bean.Attendance.Compensation"%>
<html>
<head>

<title> :: ATTENDANCE ::</title>


<script language="javascript"> 

	function Delete()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].OptCompensationName
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
			if (document.forms[0].OptCompensationName.checked) { count=1;}
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
	    //document.frmState.action="../RemoveSession";
		history.back(1);    
  } 
</script>
</head>
<%@ include file="index.jsp"%>
 
<form  AUTOCOMPLETE = "off"   method="get" name='frm'>
<table width="100%" height="322" border="0">
	<tr>
		<td height="238">
		<table align="center">
			<tr>
				<td>
				<table border="1" align="center"  >
					<tr class="tabledata" bgcolor="#6E8FBC">
						<td class="BackGround"  height="30">Employee
						Id</td>
						<td class="BackGround"  height="30">Employee
						Name</td>
						<td class="BackGround"  height="30" width="174">Holiday
						Name</td>
						<td class="BackGround"  height="30" width="174">Holiday
						Date</td>
					</tr>
					<% 
			ArrayList compensationList=(ArrayList) session.getAttribute("compensationList");
			for(int i=0;i<compensationList.size();i++)
			{
				Compensation holi= (Compensation)compensationList.get(i);
			%>
					<tr class="tabledata">
						<td>
						<%
				String val=holi.getEmpId()+"@"+holi.getHolidayDate();
			%> <input type="checkbox" name="OptCompensationName"
							value='<%= val%>'> <%= holi.getEmpId() %></td>
						<td><%= holi.getEmpName() %></td>
						<td><%=holi.getHolidayName() %></td>
						<td><%= holi.getHolidayDate() %></td>
					</tr>
					<%
			}
			String dis="";
			if(compensationList.size()==0) dis="disabled='disabled'";
		
			%>
					<tr>
						<td align="center" colspan="4"><input type="hidden"
							name="filename" value="Compensation"> <input
							type="hidden" name="actionS" value="ATTcompensationDelete">
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		<table width="116" border="0" align="center" cellpadding="1"
			cellspacing="1">
			<tr>
				<td width="56"><input type="Submit" <%=dis %>
					onClick="return Delete()" class="buttonbold" name="Submit"
					value="Delete"></td>
				<td width="56"><input name="Button" type="button"
					class="buttonbold"  value="Close"   accesskey="c"  onClick="mainPage()"></td>
			</tr>
		</table>
		<p>&nbsp;</p>
		</td>
	</tr>
</table>
<p>&nbsp;</p>

</form>

<%@ include file="../footer.jsp"%>
</body>
</html>
