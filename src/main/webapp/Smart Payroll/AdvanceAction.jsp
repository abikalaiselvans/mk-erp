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
  function View()
    {
      document.a.action="Advancedates.jsp";
      document.a.submit();
    }
  function edit()
  {
    document.getElementById("balamt").disabled=true;
    document.getElementById("balinstal").disabled=true;
  }
  function due()
  {
      document.a.dueamt.value=document.a.advamt.value/document.a.noinstal.value
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
<form  AUTOCOMPLETE = "off"   name="a" method="post" action="../SmartLoginAuth">
<%
    String aid=request.getParameter("advance");
	msg=""+request.getParameter("message");
    String advId="",closeDate="",due="",dueType="",openDate="";
    int balAmt=0,advAmt=0,balIns=0,dueAmt=0,noIns=0;
	  ArrayList advanceList=(ArrayList) session.getAttribute("advancelist");
	  if(advanceList!=null){
	  for(i=0;i<advanceList.size();i++)
	  {
		  //System.out.println("size Id "+advanceList.size());
		  Advance advance=(Advance) advanceList.get(i);
		  advId=advance.getAdv_Id();
		  //System.out.println("advance Id is"+advId);
		  //System.out.println("advance Id "+aid);
		  if(advId.equals(aid))
		  {
		  empId=advance.getEmp_Id();
		  empName=advance.getEmp_name();
		  advAmt=advance.getAdvAmt();
		  dueAmt=advance.getDueAmt();
		  dueType=advance.getDueType();
		  noIns=advance.getNoInstal();
		  openDate=advance.getOpenDate();
		  break;
		  }
		  //System.out.println("size Is "+advanceList.size());
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
%>
<body  onpaste='return false;'>
<table width="100%" border="0">
	<tr>
		<td><%@ include file="index.jsp"%></td>
	</tr>
	<tr>
		<td height="66">
		<%
    String fromDate=request.getParameter("fromDate");
    String toDate=request.getParameter("toDate");
    %>
		</td>
	</tr>
	<tr>
		<td>
		<table width="250" border="0" align="center">
			<tr>
				<td width="40%" class="tabledata" align="center">Emp
				Id&nbsp;&nbsp;<%=empId%></td>
				<td width="60%" class="tabledata" align="center">Name&nbsp;&nbsp;<%=empName%>
				<input type="hidden" name="empId" value="<%=empId%>"></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td></td>
	</tr>
	<tr>
		<td>
		<table width="476" border=1 align="center"  >
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
				<td colspan="3" align="left" class="tabledata"><%=advId%> <input
					type="hidden" name="advId" value="<%=advId%>">
				<div id="advanceid"></div>
				</td>
			</tr>
			<tr>
				<td width="167" height="26" align="left" valign="middle"
					class="bolddeepblue">Opening Date</td>
				<td colspan="3" align="left" class="tabledata"><%=openDate%></td>
			</tr>
			<tr>
				<td height="26" align="left" valign="middle" class="bolddeepblue">
				Advance Amount</td>
				<td colspan="3" align="left" class="tabledata"><%=advAmt%></td>
			</tr>
			<tr>
				<td height="26" align="left" valign="middle" class="bolddeepblue"><strong>No.Of.Installment</strong></td>
				<td colspan="3" align="left" id="instal" class="tabledata"><%=noIns%></td>
			</tr>
			<tr>
				<td height="26" align="left" valign="middle" class="bolddeepblue">Due
				Amount</td>
				<td colspan="3" align="left" id="damt" class="tabledata"><%=dueAmt%></td>
			</tr>
			<tr>
				<td width="167" height="26" align="left" valign="middle"
					class="bolddeepblue">Closing Date</td>
				<td colspan="3" align="left"><input type="text" name="closeday"
					id="closeday" value="<%=closeDate%>"
					onKeyPress="dateOnly('closeday')"> <a
					href="javascript:cal1.popup();"> <img
					src="../JavaScript/img/cal.gif" width="16" height="16" border="0"
					alt="Click here to Pick Up the Date"></a></td>
			</tr>
		</table>

		</td>
	</tr>
	<tr>
		<td><input type="hidden" name="filename" value="Advance">
		<input type="hidden" name="actionS" value="PAYAdvanceEdit"> <input
			type="hidden" name="fromDate" value=<%=fromDate%>> <input
			type="hidden" name="toDate" value=<%=toDate%>></td>
	</tr>
	<tr>
		<td>
		<table width="112" border="0" align="center">
			<tr>
				<td width="56"><input class="buttonbold" type="Submit"
					name="Submit" value="<%=btnValue %>" <%=strOnClick%>></td>
				<td width="56"><input class="buttonbold" type="submit"
					name="Submit" value="View" onClick="View()"></td>
			</tr>
		</table>


		</td>
	</tr>
	<tr>
		<td height="50">
		<% 	
	if(!msg.equals("null"))
	{
%>
		<table width="50%" border="1" align="center" cellpadding="2"
			cellspacing="2"  >
			<tr>
				<td align="center" class="tabledata"><%=msg%></td>
			</tr>
			<% } %>
		</table>
		</td>
	</tr>
	<tr>
		<td><%@ include file="../footer.jsp"%></td>
	</tr>
</table>

<script language="JavaScript">
<!--
  var cal1=new calendar1(document.forms['a'].elements['closeday']);
  cal1.year_scroll=true;
  cal1.time_comp=false;
//-->
</script>
</body>
</form>
</html>
