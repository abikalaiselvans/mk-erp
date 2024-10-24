<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%String actionStu="PAYtrainingAdd";
String programName,programId,pgDate,pgTime,venu,trainer,subject;
%>
<%@ page import="com.my.org.erp.SmartPayroll.Training"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="../JavaScript/AJAXFunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"> </script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>

<title> :: PAYROLL ::</title>


 
 
<script src="../JavaScript/AJAXFunction.js"></script>
<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>



<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

<style type="text/css">
<!--
.style1 {	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
}
.style12 {color: #FFFFFF}
.style14 {color: #FFFFFF; font-weight: bold; }
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
<script>
function validate(){
	if(checkNull("ename","Select Staff")&& checkNull("progname","Enter Program Name")&& checkNull("acode","Enter Training Date")){
		document.a.submit();
		return true;
	}
	return false;
	}
	function mainPage()
	{
	    //document.a.action="Payrollmain.jsp";
		//document.a.submit();
		//return true;
		history.back(1);
    }
 
</script>
</head>
<form  AUTOCOMPLETE = "off"   name="a" method="post" action="../SmartLoginAuth">
<body  onpaste="return false;" onLoad="init();">
<%@ include file="index.jsp"%>
<br>
<br>
<br>
<%   
  	String action=request.getParameter("action1");
  //System.out.println("Action:"+action);
	//courseName=""+request.getParameter("courseName");
	//courseId=request.getParameter("TxtCourseId");
	ArrayList trainingList=(ArrayList) session.getAttribute("trainingList");
	if(action.equals("Edit")){
		 actionStu="PAYtrainingEdit";
			//System.out.println("tN:"+actionStu);
		 programId=request.getParameter("training");	
		 for(int i=0;i<trainingList.size();i++)
		 {			
			Training train=(Training)trainingList.get(i);
			 
			if(train.getProgId()==programId){	 	
						programName=train.getProgName();
						//System.out.println("tN:"+programName);
						pgDate=train.getPdate();
						pgTime=train.getPtime();
						venu=train.getVenu();
						subject=train.getSubject();
						trainer=train.getTrainer();						
						break;
				}
			 }
	}			 
	else{
		actionStu="PAYtrainingAdd";
		programName="";
		pgDate="";
		pgTime="";
		venu="";
		trainer="";
		subject="";
			}		
		
%>

<table width="1002" border=0>
	<!--DWLayoutTable-->
	<tr>
		<td width="239" height="51">&nbsp;</td>
		<td width="204">&nbsp;</td>
		<td width="69">&nbsp;</td>
		<td width="233">&nbsp;</td>
		<td width="235">&nbsp;</td>
	</tr>
	<tr>
		<td height="217">&nbsp;</td>
		<td colspan="3" valign="top">
		<table width="507" border="1" cellspacing="2" cellpadding="2"
			 >
			<!--DWLayoutTable-->
			<tr>
				<td width="512" height="54" valign="top"><%@ include
					file="../JavaScript/ajax.jsp"%></td>
			</tr>

		</table>
		<table width="507" border="1" cellspacing="2" cellpadding="2"
			 >
			<tr align="center" valign="middle" class="tablehead">
				<td height="25" colspan="2"  class="tablehead">Employee
				Training Program</td>
			</tr>
			<tr>
				<td width="193" height="32" valign="middle" class="tabledata">Program
				Name <font color="#CC0000">*</font></td>
				<td width="294" valign="middle"><input name="TxtProgramName"
					type="text" class="tabledata" id="progname"
					onkeypress="charOnly('progname','25')" size="40"></td>
			</tr>
			<tr>
				<td width="153" height="30" valign="middle" class="bolddeepblue">Date<font
					color="#CC0000" class="tabledata">*</font></td>
				<td valign="middle"><input name="TxtProgDate" type="text"
					class="tabledata" id="acode" onkeypress="dateOnly('TxtProgDate')">
				<a href="javascript:cal2.popup();"> <img
					src="../JavaScript/img/cal.gif" width="16" height="16" border="0"
					alt="Click here to Pick Up the Date"></a> <script
					language="JavaScript">
			<!--
  			var cal2=new calendar1(document.forms['a'].elements['acode']);
  			cal2.year_scroll=true;
	  		cal2.time_comp=false;
	  		setCurrentDate('acode');
	
	
	  			//--> 
		</script></td>
			</tr>
			<tr>
				<td valign="middle" class="tabledata">Time</td>
				<td valign="middle" class="tabledata"><input name="TxtTime"
					type="text" class="tabledata" id="it" onkeypress="timeOnly('it')"
					size="20"> (HH:MM:SS)</td>
			</tr>
			<tr>
				<td valign="middle" class="tabledata">Venue</td>
				<td valign="middle"><input name="TxtVenu" type="text"
					class="tabledata" onkeypress="charOnly('TxtVenu','20')" size="40"></td>
			</tr>
			<tr>
				<td valign="middle" class="tabledata">Trainer</td>
				<td valign="middle"><input name="TxtTrainer" type="text"
					class="tabledata" onkeypress="charOnly('TxtTrainer','20')"
					size="40"></td>
			</tr>
			<tr>
				<td valign="middle" class="tabledata">Subject</td>
				<td valign="middle"><input name="TxtSubject" type="text"
					class="tabledata" onkeypress="charOnly('TxtSubject','20')"
					size="40"></td>
			</tr>
		</table>
		</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="39">&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
</table>
<input type="HIDDEN" name="filename" value="Training">
<input type="HIDDEN" name="actionS" value="<%=actionStu %>">

<center>
<table>
	<tr>
		<td width="56" align="center" colspan="2"><input
			class="buttonbold" type="submit" name="Submit" value="Submit"   accesskey="s"   
			onclick="return validate()"></td>
		<td width="56" valign="top"><input class="buttonbold"
			type="button" name="Submit"  value="Close"   accesskey="c"  onclick="mainPage()">
		</td>
	</tr>
	<tr>
		<td height="24">&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
</table>
<br>
<% 
String msg=""+request.getParameter("message");
if(!msg.equals("null")){
%>
<CENTER>
<table width="23%" border="1" cellspacing="2" cellpadding="2"
	 >
	<tr>
		<td align="center" class="bolddeepblue"><%=msg%></td>
	</tr>
	<% } %>
</table>
</CENTER>
<%@ include file="../footer.jsp"%>
</body>
</form>
</html>
