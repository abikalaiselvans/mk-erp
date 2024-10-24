<%@ page import="java.io.*,java.util.*" isErrorPage="false"
	errorPage="./error.jsp"%>
<%@ page import="com.my.org.erp.bean.Attendance.ShiftAllocation"%>
<html>
<head>

<title> :: ATTENDANCE ::</title>


<script language="javascript">    
	function Delete()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].OptShiftName
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
			if (document.forms[0].OptShiftName.checked) { count=1;}
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
</script>
</head>
 
<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   method="get" name='frm' action="../SmartLoginAuth">
<table width="100%" border="0">
	<tr>
		<td height="339">
		<table align="center">
			<tr>
				<td width="687">
				<table border="1" align="center"  >
					<tr class="tabledata" bgcolor="#6E8FBC">
						<td class="BackGround"  height="30">Employee
						Id</td>
						<td class="BackGround"  height="30">Employee
						Name</td>
						<td class="BackGround"  height="30" width="174">Shift
						Code</td>
						<td class="BackGround"  height="30" width="174">Shift
						Date</td>
					</tr>
					<% 
			ArrayList shiftList=(ArrayList) session.getAttribute("shiftList");
			for(int i=0;i<shiftList.size();i++)
			{
				ShiftAllocation holi= (ShiftAllocation)shiftList.get(i);
			%>
					<tr class="tabledata">
						<td>
						<%
				String val=holi.getEmpId()+"@"+holi.getShiftDate();
			%> <input type="checkbox" name="OptShiftName" value='<%= val%>'>
						<%= holi.getEmpId() %></td>
						<td><%= holi.getEmpName() %></td>
						<td><%=holi.getShiftCode() %></td>
						<td><%= holi.getShiftDate() %></td>
					</tr>
					<%
			}
			String dis="";
			if(shiftList.size()==0) dis="disabled='disabled'";
		
			%>
					<tr>
						<td align="center" colspan="4"><input type="hidden"
							name="filename" value="ShiftAllocation"> <input
							type="hidden" name="actionS" value="ATTshiftDelete"></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		<table width="12%" border="0" align="center">
			<tr>
				<td>
				<div align="center"><input name="Submit" type="Submit"
					class="buttonbold" onClick="return Delete()" value="Delete"
					<%=dis %>></div>
				</td>
				<td width="56"><input name="Submit" type="button"
					class="buttonbold"  value="Close"   accesskey="c"  onClick="mainPage()"></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</form>
<%@ include file="../footer.jsp"%>
</body>
</html>
