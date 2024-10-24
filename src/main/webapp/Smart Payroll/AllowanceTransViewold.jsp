<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.bean.payroll.*"%>
<%!
	String allName,allCode;
	String actionAll;
	String msg="",empId="",empName="",bodyLoad="onLoad='init()'";
	String btnValue="Submit";
	String strOnClick="onclick='return validate()'";
	String allValue[]=new String[7];
	int i=0;
%>
<html>
<head>

<title> :: PAYROLL ::</title>


 
 
<script src="../JavaScript/AJAXFunction.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">
function validate()
{
    if(checkNull("ename","Select Staff"))
    	return true;
    else
    	return false;
}
function list()
  {   
     if(checkNull("ename","Select Staff"))
	 {
        return true;
     }
     else
     {
     	return false;
     }     
   }
function mainPage()
	{
	    document.allow.action="Payrollmain.jsp";
		document.allow.submit();
		return true;
    }
</script>
</head>
<form  AUTOCOMPLETE = "off"   name="allow" action="../SmartLoginAuth"><%@ include
	file="index.jsp"%> <%
	msg=""+request.getParameter("message");
	if(msg.equalsIgnoreCase("List"))
	{  	  
	  empId=request.getParameter("empId");
	  empName=request.getParameter("empName");
	  ArrayList allTransList=(ArrayList) session.getAttribute("allowanceTranList");
	  if(allTransList!=null){
	  if(allTransList.size()==1){
		AllowanceTransaction allTran= (AllowanceTransaction) allTransList.get(0);
		allValue=allTran.getAllode();
	  }
	  bodyLoad="";
	  btnValue="Update";
	  strOnClick="";
      }else
    	  msg="";
	}
	else if(msg.equalsIgnoreCase("View"))
	{
	  btnValue="Submit";
	  bodyLoad="onLoad='init()'";
	   for(i=0;i<allValue.length;i++){
			allValue[i]="";
	   }

	}
	else
	{
		bodyLoad="onLoad='init()'";
		for(i=0;i<allValue.length;i++){
			allValue[i]="";
	 }
	}
	 for(i=0;i<allValue.length;i++){
			if((allValue[i]==null)) allValue[i]="0";
	 } 
%>
<body  onpaste="return false;" <%= bodyLoad %>>
<table width="959" border="0" cellpadding="0" cellspacing="0">
	<!--DWLayoutTable-->
	<tr>
		<td width="282" height="142">&nbsp;</td>
		<td width="187">&nbsp;</td>
		<td width="58">&nbsp;</td>
		<td width="215">&nbsp;</td>
		<td width="14">&nbsp;</td>
		<td width="203">&nbsp;</td>
	</tr>
	<tr>
		<td height="40">&nbsp;</td>
		<td colspan="4" valign="middle">
		<%
    if(msg.equalsIgnoreCase("List"))  {
   	  out.println("<table border='0' width='100%'><tr><td width='40%' class='tabledata' align='center'>Emp Id&nbsp;&nbsp;&nbsp;"+empId +"</td><td width='60%' class='tabledata' align='center'>Name&nbsp;&nbsp;&nbsp;"+empName+"</td></tr></table>");
   	%>
		</td>
		<td><input type="hidden" name="empId" value="<%= empId%>">
		<%
    }else{    	
    %> <%@ include file="../JavaScript/ajax.jsp"%>
		</td>
		<td width="56" valign="center"><input input class="buttonbold"
			type="Submit" name="Submit" value="List" onClick="return validate()"></td>
		<%} %>
	</tr>
	<tr>
		<td height="23">&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="59">&nbsp;</td>
		<td colspan="3" valign="top">
		<table width="95%" border="1" cellpadding="0" cellspacing="1"
			 >
			<!--DWLayoutTable-->
			<tr valign="middle">
				<td height="30" colspan="2" align="center" 
					class="tablehead">Allowance</td>
			</tr>
			<%   	
        	ArrayList allowanceList=(ArrayList) session.getAttribute("allowanceList");
            String val="";
			for(i=0;i<allowanceList.size();i++)
			{
				Allowance allowance= (Allowance)allowanceList.get(i);
				allCode=allowance.getAllCode();
				allName=allowance.getAllName();		    
				if(allValue[i].equals("0"))
	          	 val="";
				else
				val=allValue[i];	
	  %>
			<tr>
				<td width="221" height="24" valign="middle" class="bolddeepblue"><%=allName%></td>
				<td width="223" valign="middle"><input type="text"
					name=<%=allCode%> value="<%=val %>" size="30"
					onkeypress=numericValue('<%=allCode%>','5')></td>
			</tr>

			<%
		    }
        %>
			<input type="hidden" name="allsize" value="<%=i%>">

		</table>
		<table width="95%" border="1" cellpadding="0" cellspacing="1"
			 >
			<!--DWLayoutTable-->
			<tr>
				<td height="30" colspan="2" align="center" valign="top"
					  class="tablehead">Recovery</td>
			</tr>
			<tr>
				<td width="180" height="24" valign="top" class="tabledata">Red</td>
				<td width="195"><input type="text" name="text1" size="30"></td>
			</tr>
		</table>
	<tr>
		<td height="57">&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="24"></td>
		<td></td>
		<input type="hidden" name="filename" value="AllowanceTrans">
		<input type="hidden" name="actionS" value="PAYallowanceAdd">
		<td width="56" valign="top"><input class="buttonbold"
			type="Submit" name="Submit" value="<%= btnValue %>" <%= strOnClick%>>
		</td>
		<td width="56" valign="top"><input class="buttonbold"
			type="submit" name="Submit"  value="Close"   accesskey="c"  onClick="mainPage()">
		</td>
		<td></td>
		<td></td>
		<td></td>
	</tr>
	<tr>
		<td height="13"></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
	</tr>
</table>
<% 	
	if(!msg.equals("null")){
%>
<CENTER>
<table width="50%" border="1" cellspacing="2" cellpadding="2"
	 >
	<tr>
		<td align="center" class="tabledata"><%=msg%></td>
	</tr>
	<% } %>
</table>
</CENTER>
<%@ include file="../footer.jsp"%>
</body>
</form>
</html>
