<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.bean.payroll.*"%>
<%!
	String pfType,pfNo,esiType,esiNo;
	String actionAll;
	int pfAmt,esiAmt;
	String msg="",empId="",empName="",bodyLoad="onLoad='init()'";
	String btnValue="Submit";
	String strOnClick="onclick='return validate()'";
	String allValue[]=new String[7];
	int i=0;
%>
<html>
<head>
<script src="../JavaScript/comfunction.js"></script>
<script src="../JavaScript/AJAXFunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"> </script>
<script language="javascript">	
  function manual()
  {  
      document.getElementById("damt").disabled=true;
      damt.style.visibility="hidden";
      document.getElementById("instal").disabled=true;
      instal.style.visibility="hidden";
      a.dueamt.value="0";
      a.noinstal.value="0";
  }
  function automatic()
  {
      document.getElementById("damt").disabled=false;
      damt.style.visibility="visible";
      document.getElementById("instal").disabled=false;
      instal.style.visibility="visible";
  }
  function due()
  {
      document.a.dueamt.value=document.a.advamt.value/document.a.noinstal.value
      if(document.a.advamt.value=="")
      alert("Hai");
        }	
  function validate()
  {
  
	   if(checkNull('advid','Enter Advance Id') && checkNull('openday','Enter Opening Date') && checkNull('advamt','Enter Advance Amount'))
	   {
	     if(a.binstal.value=="")
	     {
	       a.binstal.value=0;
	     }
	     if(a.balamt.value=="")
	     {
	       a.balamt.value=0;
	     }
	     val=document.getElementById("intypeA").checked;
	     if(val==true)
	     {
			if(checkNull('noofinstal','Enter No Of Instalment') && checkNull('dueamt','Enter Due Amount'))
			  return true;
			else
			  return false;
	 	 }
	   }
	   else 
	   return false;
	  }
	  function mainPage()
	{
	    document.a.action="Payrollmain.jsp";
		document.a.submit();
		return true;
    }
</script>

<title> :: PAYROLL ::</title>


 
 
</head>
<form  AUTOCOMPLETE = "off"   name="a" method="post" action="../SmartLoginAuth"><%@ include
	file="index.jsp"%> <%
	msg=""+request.getParameter("message");
    String advId="",closeDate="",due="",dueType="",openDate="";
    int balAmt=0,advAmt=0,balIns=0,dueAmt=0,noIns=0;
	if(msg.equalsIgnoreCase("List"))
	{  	  
	  empId=request.getParameter("empId");
	  empName=request.getParameter("empName");
	  ArrayList advanceList=(ArrayList) session.getAttribute("advancelist");
	  if(advanceList!=null){
	  if(advanceList.size()==1){
		  Advance advance=(Advance) advanceList.get(0);
		  advId=advance.getAdv_Id();
		  balAmt=advance.getBalAmt();
		  advAmt=advance.getAdvAmt();
		  balIns=advance.getBalInstal();
		  closeDate=advance.getCloseDate();
		  due=advance.getDue();
		  dueAmt=advance.getDueAmt();
		  dueType=advance.getDueType();
		  noIns=advance.getNoInstal();
		  openDate=advance.getOpenDate();
	  }
	  bodyLoad="";
	  btnValue="Update";
	  strOnClick="";
      }else
      { 	  
    	  advId="";
		  balAmt=0;
		  advAmt=0;
		  balIns=0;
		  closeDate="";
		  due="";
		  dueAmt=0;
		  dueType="";
		  noIns=0;
		  openDate="";
      }	  
	}
	else
	{
		bodyLoad="onLoad='init()'";
		
	 }
	
%>
<body  onpaste="return false;" <%= bodyLoad%>>

<center>
<table width=1000>
	<!--DWLayoutTable-->
	<tr>
		<td width="269" height="140"></td>
		<td width="174">&nbsp;</td>
		<td width="58">&nbsp;</td>
		<td width="232">&nbsp;</td>
		<td width="102"></td>
		<td width="125"></td>
	<tr>
		<td height="41"></td>
		<td colspan="4" valign="top">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<!--DWLayoutTable-->
			<tr>
				<td width="478" height="39" valign="top">
				<%if(msg.equalsIgnoreCase("List"))  {
    	out.println("Emp Id:"+empId +"</td><td>Emp Name"+empName+"</td>");
      %> <input type="hidden" name="empId" value="<%= empId%>">
				<%
        }else{    	
      %> <%@ include file="../JavaScript/ajax.jsp"%>
				</td>
				<td width="56" valign="center"><input class="buttonbold"
					type="button" Value="List"></td>
				<%} %>
			</tr>
		</table>
		</td>
		<td>&nbsp;</td>
	<tr>
		<td height="13"></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
	<tr>
		<td height="288"></td>
		<td colspan="3" valign="top">
		<table width="476" border=1  >
			<!--DWLayoutTable-->
			<tr valign="middle">
				<td height="28" colspan="4" align="center" 
					class="tablehead">Advance Details</td>
			</tr>
			<%
  str="SELECT * FROM  com_m_staff ";
  rs=st.executeQuery(str);
%>
			<tr>
				<td width="167" height="26" align="left" valign="middle"
					class="bolddeepblue">Advance Id</td>
				<td colspan="3" align="left"><input name="advid" type="text"
					id="advid" size="40" value="<%=advId%>"
					onkeypress="numericValue('advid',5)">
				<div id="advanceid"></div>
				</td>
			</tr>
			<tr>
				<td width="167" height="26" align="left" valign="middle"
					class="bolddeepblue">Installment Type</td>
				<td width="147" align="left" valign="top" class="bolddeepblue"><input
					name="intype" id="intypeM" type="radio" value="M"
					onClick="manual()"> <strong> Manual</strong></td>
				<td width="132" align="left" valign="top" class="bolddeepblue">
				<input name="intype" id="intypeA" type="radio" value="A" checked
					onClick="automatic()"><strong> Automatic </strong></td>
			</tr>
			<tr>
				<td width="167" height="26" align="left" valign="middle"
					class="bolddeepblue">Opening Date</td>
				<td colspan="3" align="left"><input type="text" name="openday"
					id="openday" value="<%=openDate%>" onKeyPress="dateOnly('openday')">
				<a href="javascript:cal1.popup();"> <img
					src="../JavaScript/img/cal.gif" width="16" height="16" border="0"
					alt="Click here to Pick Up the Date"></a></td>
			</tr>
			<tr>
				<td height="26" align="left" valign="middle" class="bolddeepblue">
				Due Amount</td>
				<td width="147" align="left" valign="top" class="bolddeepblue">
				<input name="duemonth" type="radio" value="c" checked> <strong>
				Current</strong></td>
				<td width="132" align="left" valign="top" class="bolddeepblue">
				<input name="duemonth" type="radio" value="n"> <strong>
				Next</strong></td>
			</tr>

			<tr>
				<td height="26" align="left" valign="middle" class="bolddeepblue">
				Advance Amount</td>
				<td colspan="3" align="left"><input name="adamt" type="text"
					id="advamt" size="40" value="<%=advAmt%>"
					onkeyPress="numericValue('adamt',6)"></td>
			</tr>
			<tr>
				<td height="26" align="left" valign="middle" class="bolddeepblue"><strong>No.Of.Installment</strong></td>
				<td colspan="3" align="left" id="instal"><input name="noinstal"
					type="text" id="noofinstal" value="<%=noIns%>" size="40"
					onkeyPress="numericValue('noinstal',3)"></td>
			</tr>
			<tr>
				<td height="26" align="left" valign="middle" class="bolddeepblue">
				<div align="left"><strong>Due Amount</strong></div>
				</td>
				<td colspan="3" align="left" id="damt"><input name="dueamt"
					type="text" id="dueamt" size="40" value="<%=dueAmt%>"
					onkeyPress="numericValue('dueamt',6)" onFocus="due()"></td>
			</tr>
			<tr>
				<td height="26" align="left" valign="middle" class="bolddeepblue">
				Due Status</td>
				<td width="147" align="left" valign="top" class="bolddeepblue">
				<input name="status" type="radio" value="P" checked> <strong>
				Present</strong></td>
				<td width="132" align="left" valign="top" class="bolddeepblue">
				<input name="status" type="radio" value="C"> <strong>
				Closed </strong></td>
			</tr>
			<tr>
				<td width="167" height="26" align="left" valign="middle"
					class="bolddeepblue">Closing Date</td>
				<td colspan="3" align="left"><input type="text" name="closeday"
					id="closeday" value="<%=closeDate%>"
					onKeyPress="dateOnly('closeday')"> <a
					href="javascript:cal2.popup();"> <img
					src="../JavaScript/img/cal.gif" width="16" height="16" border="0"
					alt="Click here to Pick Up the Date"></a></td>
			</tr>
			<tr>
				<td height="26" align="left" valign="middle" class="bolddeepblue">
				Balance Amount</td>
				<td colspan="3" align="left"><input name="balamt" type="text"
					id="balamt" size="40" value="<%=balAmt%>"
					onkeyPress="numericValue('balamt',6)" value="0"></td>
			</tr>
			<tr>
				<td height="26" align="left" valign="middle" class="bolddeepblue">Balance
				Installment</td>
				<td colspan="3" align="left"><input name="binstal" type="text"
					id="balinstal" size="40" value="<%=balIns%>"
					onkeyPress="numericValue('binstal',6)" value="0"></td>
			</tr>
		</table>
		</td>
		<td></td>
		<td></td>
	<tr>
		<td height="25"></td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td></td>
		<td></td>
	<tr>
		<td height="26"></td>
		<td>&nbsp;</td>
		<input type="hidden" name="filename" value="Advance">
		<input type="hidden" name="actionS" value="PAYAdvanceAdd">
		<td width="56" valign="top"><input class="buttonbold"
			type="Submit" name="Submit" value="<%= btnValue %>" <%= strOnClick%>></td>
		<td width="56" valign="top"><input class="buttonbold"
			type="submit" name="Submit"  value="Close"   accesskey="c"  onClick="mainPage()"></td>
		<td>&nbsp;</td>
		<td></td>
		<td></td>
</table>

<script language="JavaScript">
<!--
  var cal1=new calendar1(document.forms['a'].elements['openday']);
  cal1.year_scroll=true;
  cal1.time_comp=false;
  var cal2=new calendar1(document.forms['a'].elements['closeday']);
  cal2.year_scroll=true;
  cal2.time_comp=false;
//-->
</script> <% 	
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
<%@ include file="../footer.jsp"%></center>
</body>
</form>
</html>
