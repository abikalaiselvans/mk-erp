<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.bean.payroll.*"%>
<%!
	String pfType,pfNo,esiType,esiNo,pfAmt,esiAmt;
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


 
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
 
<script src="../JavaScript/AJAXFunction.js"></script>
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
    document.pf.action="Payrollmain.jsp";
	document.pf.submit();
	return true;
}
</script>
</head>
<form  AUTOCOMPLETE = "off"   name="pf" method="post" action="../SmartLoginAuth"><%@ include
	file="index.jsp"%> <%
	msg=""+request.getParameter("message");
	if(msg.equalsIgnoreCase("List"))
	{  	  
	  empId=request.getParameter("empId");
	  empName=request.getParameter("empName");
	  ArrayList pfesiList=(ArrayList) session.getAttribute("pfesiList");
	  if(pfesiList!=null){
	  if(pfesiList.size()==1){
		  PfEsiTranscation pfesiTran=(PfEsiTranscation) pfesiList.get(0);
		  pfType=pfesiTran.getPfType();
		  pfAmt=""+pfesiTran.getPfAmt();
		  pfNo=pfesiTran.getPfNo();
		  esiType=pfesiTran.getEsiType();
		  esiAmt=""+pfesiTran.getEsiAmt();
		  esiNo=pfesiTran.getEsiNo();
	  }
	  bodyLoad="";
	  btnValue="Update";
	  strOnClick="";
      }else
      { 	  
    	  msg="";
    	  pfType="";
		  pfAmt="";
		  pfNo="";
		  esiType="";
		  esiAmt="";
		  esiNo="";
      }	  
	}
	else if(msg.equalsIgnoreCase("View"))
	{
		btnValue="Submit";
		bodyLoad="onLoad='init()'";
		pfType="";
		pfAmt="";
		pfNo="";
		esiType="";
		esiAmt="";
		esiNo=" ";	
	}
	else
	{
		bodyLoad="onLoad='init()'";
		pfType="";
		pfAmt="";
		pfNo="0";
		esiType="";
		esiAmt="";
		esiNo="0";
	} 
%>
<body  onpaste="return false;" <%= bodyLoad %>>
<center>

<table width="1000" border="0">
	<!--DWLayoutTable-->
	<tr>
		<td width="271" height="141">&nbsp;</td>
		<td width="174">&nbsp;</td>
		<td width="294">&nbsp;</td>
		<td width="10">&nbsp;</td>
		<td width="165">&nbsp;</td>

		<td width="60">&nbsp;</td>
	<tr>
		<td height="40">&nbsp;</td>
		<td colspan="3" valign="middle">
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
		<td width="60"><input class="buttonbold" type="Submit"
			name="Submit" value="List" onClick="return validate()"></td>
		<%} %>
	</tr>
	<tr>
		<td height="10">
		<td>
		<td>
		<td>
		<td></td>
		<td></td>
	<tr>
		<td height="258">
		<td colspan="2" valign="top">
		<table border="1" width="472"  >
			<!--DWLayoutTable-->
			<tr>
				<td align="center" height="30" colspan="2" 
					class="tablehead">PF & ESI</td>
			</tr>

			<tr>
				<td width="166" rowspan="2" class="bolddeepblue">PF TYPE</td>

				<td width='290' class='bolddeepblue'><input name='optpf'
					type='radio' value='A'> Amount</td>
			<tr>
				<td class='bolddeepblue'><input name='optpf' type='radio'
					value='P' checked>Percentage
			<tr>
				<td class="bolddeepblue">PF Number
				<td><input type="text" name="TxtPfNo" size="20"
					onKeyPress="alphaNumeric('TxtPfNo','9')" value=<%=pfNo%>>
			<tr>
				<td class="bolddeepblue">PF Amount
				<td><input type="text" name="TxtPfValue" size="20"
					onKeyPress="numericValue('TxtPfValue','9')" value=<%=pfAmt%>></td>
			</tr>
			<tr>
				<td rowspan="2" class="bolddeepblue">ESI TYPE</td>
				<td class='bolddeepblue'><input name='optesi' type='radio'
					value='A'>Amount</td>
			</tr>
			<tr>
				<td class='bolddeepblue'><input name='optesi' type='radio'
					value='P' checked>Percentage</td>
			</tr>
			<tr>
				<td class="bolddeepblue">ESI Number
				<td><input type="text" name="TxtEsiNo" size="20"
					onKeyPress="alphaNumeric('TxtEsiNo','9')" value=<%=esiNo%>></td>
			</tr>
			<tr>
				<td class="bolddeepblue">ESI Amount
				<td><input type="text" name="TxtEsiValue" size="20"
					onKeyPress="numericValue('TxtEsiValue','9')" value=<%=esiAmt%>></td>
			</tr>

			<tr>
				<td align="right"></td>
				<td></td>
			</tr>
		</table>
		<td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	<tr>
		<td height="21">
		<td><input type="hidden" name="filename" value="PfEsiTrans">
		<input type="hidden" name="actionS" value="PAYPfEsiAdd">
		<td valign="top">
		<td>
		<td></td>
		<td></td>
	<tr>
		<td height="28">
		<td colspan="2">
		<table width="112" align="center" cellpadding="0" cellspacing="0">
			<tr>
				<td width="56" valign="top"><input class="buttonbold"
					type="Submit" name="Submit2" value="<%=btnValue%>" <%=strOnClick%>></td>
				<td valign="top" width="56"><input class="buttonbold"
					type="submit" name="Submit3"  value="Close"   accesskey="c"  onClick="mainPage()">
				</td>
			</tr>
		</table>
		</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
</table>
</center>
<tr>
	<center>
	<td width="237" height="72" valign="top">
	<div align="left"></div>
	</td>
	<td width="54"></td>
	<td width="94" valign="top">&nbsp;</td>
	<td width="199"></td>

	<td width="92" valign="top" background="../if"><a
		href="Payrollmain.jsp"></td>
	<td width="300">&nbsp;</td>
	</center>
</tr>
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
</html>

