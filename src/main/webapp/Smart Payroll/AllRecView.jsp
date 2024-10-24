<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.bean.payroll.*"%>
<%!
	String recName,recCode;
	String actionRec;
	String msg="",empId="",empName="",bodyLoad="onLoad='init()'";
	String btnValue="Submit";
	String strOnClick="onclick='return validate()'";
	String recValue[]=new String[7];
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
	    document.rec.action="Payrollmain.jsp";
		document.rec.submit();
		return true;
    }
</script>
</head>
<form  AUTOCOMPLETE = "off"   name="rec" action="../SmartLoginAuth"><%@ include
	file="index.jsp"%> <%
	msg=""+request.getParameter("message");
	if(msg.equalsIgnoreCase("List"))
	{  	  
	  empId=request.getParameter("empId");
	  empName=request.getParameter("empName");
	  ArrayList recTransList=(ArrayList) session.getAttribute("recoveryTranList");
	  if(recTransList!=null){
	  if(recTransList.size()==1){
		RecoveryTransaction allTran= (RecoveryTransaction) recTransList.get(0);
		recValue=allTran.getReccode();
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
		for(i=0;i<recValue.length;i++){
			recValue[i]="0";
	   }
	}
	else
	{
		bodyLoad="onLoad='init()'";
		for(i=0;i<recValue.length;i++){
			recValue[i]="0";
	 	}
	}
	 for(i=0;i<recValue.length;i++){
			if((recValue[i]==null)) recValue[i]="0";
	 } 
%>
<body  onpaste="return false;" <%= bodyLoad %>>
<table width="959" border="0" cellpadding="0" cellspacing="0">
	<!--DWLayoutTable-->
	<tr>
		<td width="279" height="141">&nbsp;</td>
		<td width="207">&nbsp;</td>
		<td width="58">&nbsp;</td>
		<td width="210">&nbsp;</td>
		<td width="12">&nbsp;</td>
		<td width="193">&nbsp;</td>
	</tr>
	<tr>
		<td height="40">&nbsp;</td>
		<td colspan="4" valign="middle">
		<%
    if(msg.equalsIgnoreCase("List"))  {
   	  out.println("<table border='0' width='100%'><tr><td width='40%' class='tabledata' align='center'>Emp Id&nbsp;&nbsp;&nbsp;"+empId +"</td><td width='60%' class='tabledata' align='center'>Name&nbsp;&nbsp;&nbsp;"+empName+"</td></tr></table>");
   	%>
		</td>
		<input type="hidden" name="empId" value="<%= empId%>">
		<%
    }else{    	
    %>
		<%@ include file="../JavaScript/ajax.jsp"%>
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
		<td height="62">&nbsp;</td>
		<td colspan="3" valign="top">
		<table width="100%" border="1" cellpadding="0" cellspacing="1"
			 >
			<!--DWLayoutTable-->
			<tr valign="middle">
				<td height="30" colspan="2" align="center" 
					class="tablehead">Recovery</td>
			</tr>
			<%
        String val=""; 
        ArrayList recoveryList=(ArrayList) session.getAttribute("recoveryList");
		for(i=0;i<recoveryList.size();i++)
		{
			Recovery recovery= (Recovery)recoveryList.get(i);
			recCode=recovery.getRecCode();
			recName=recovery.getRecName();					
			if(recValue[i].equals("0"))
	          	 val="";
				else
				val=recValue[i];	
	  %>
			<tr>
				<td width="214" height="24" valign="middle" class="bolddeepblue"><%=recName%></td>
				<td width="239" valign="middle"><input type="text"
					name=<%=recCode%> value="<%=val%>" size="30"
					onkeypress=numericValue('<%=recCode%>','5')></td>
			</tr>
			<%
		    }
        %>
			<input type="hidden" name="recsize" value="<%=i%>">
		</table>
		</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
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
		<input type="hidden" name="filename" value="recoveryTrans">
		<input type="hidden" name="actionS" value="PAYrecoveryAdd">
		<td width="56" valign="top"><input class="buttonbold"
			type="Submit" name="Submit" value="<%= btnValue %>" <%=strOnClick%>>
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
</form>
</body>
</html>

