<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%String actionStu="PAYtravelAdd"; %>
<%!
	String travelName,travelId;
	String actionStu;
	String date,deptTime,fromDept,fromReturn;
	String period,purpose,returnDate,returnTime,ticket;
	String toDept,toReturn;
	String empId;
%>
<%@ page import="com.my.org.erp.SmartPayroll.Travel"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script language="javascript">
function validate(){
	if(checkNull("ename","Select Staff") && checkNull("visit","Enter The Visit Place") && checkNull("period","Enter The Period")
	&& checkNull("purpose","Enter The Purpose")){
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
    function View()
    {
      document.a.action="TravelDates.jsp";
      document.a.submit();
    }
</script>

<title> :: PAYROLL ::</title>


 
 
<script src="../JavaScript/AJAXFunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
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
-->
</style>
</head>
<form  AUTOCOMPLETE = "off"   name="a" method="post" action="../SmartLoginAuth">
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"
	onLoad="init();">
<%@ include file="index.jsp"%>
<%   
  	String action=request.getParameter("action1");
	////System.out.println("hai:"+action);		
	//courseName=""+request.getParameter("courseName");
	//courseId=request.getParameter("TxtCourseId");
	ArrayList travelList=(ArrayList) session.getAttribute("travelList");
	if(action.equals("Edit")){
		actionStu="PAYtravelEdit";
		travelId=request.getParameter("traveling");
		//System.out.println("hai:"+travelId);
		//System.out.println(" Size :"+travelList.size());
		 for(int i=0;i<travelList.size();i++)
		 {
			 Travel travel=(Travel)travelList.get(i);	
					if(travel.getTravelId()==travelId){	 	
					travelName=travel.getVisitPlace();
					//System.out.println("tN"+travelName);
					date=travel.getDeptDate();
					deptTime=travel.getDeptTime();
					fromDept=travel.getFromDept();
					fromReturn=travel.getFromReturn();
					period=travel.getPeriod();
					purpose=travel.getPurpose();
					returnDate=travel.getReturnDate();
					returnTime=travel.getReturnTime();
					ticket=travel.getTicket();
					toDept=travel.getToDept();
					toReturn=travel.getToReturn();					
					break;
			}
		 }
		 
	}else{
		actionStu="PAYtravelAdd";
		travelName="";	
		date="";
		deptTime="";
		empId="";
		fromDept="";
		fromReturn="";
		period="";
		purpose="";
		returnDate="";
		returnTime="";
		ticket="";
		toDept="";
		toReturn="";
	}
		
%>
<br>
<br>
<br>
<table width="1000" border=0>
	<!--DWLayoutTable-->
	<tr>
		<td width="231" height="78">&nbsp;</td>
		<td width="192">&nbsp;</td>
		<td width="60">&nbsp;</td>
		<td width="211">&nbsp;</td>
		<td width="40">&nbsp;</td>
		<td width="240">&nbsp;</td>
	</tr>
	<tr>
		<td height="47">&nbsp;</td>
		<td colspan="4" valign="top">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<!--DWLayoutTable-->
			<tr>
				<td width="512" height="45" valign="top"><%@ include
					file="../JavaScript/ajax.jsp"%></td>
			</tr>
		</table>
		</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="30">&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="479">&nbsp;</td>
		<td colspan="3" valign="top" background="../if">
		<table width="471" border="1" cellspacing="2" cellpadding="2"
			 >
			<!--DWLayoutTable-->
			<tr align="center" valign="middle">
				<td height="28" colspan="2"  class="tablehead">Employee
				Travel Program</td>
			</tr>

			<tr>
				<td width="164" height="28" class="bolddeepblue">Visited Place
				<font color="#CC0000">*</font></td>
				<td width="287"><input name="TxtVisit" type="text"
					class="tabledata" id="visit" onkeypress="charOnly('visit','25')"
					size="40"></td>
			</tr>
			<tr>
				<td height="28" class="bolddeepblue">Period <font
					color="#CC0000">*</font></td>
				<td><input name="TxtPeriod" type="text" class="tabledata"
					id="period" onkeypress="charOnly('period','25')" size="40"></td>
			</tr>
			<tr>
				<td height="28" class="bolddeepblue">Purpose <font
					color="#CC0000">*</font></td>
				<td><input name="TxtPurpose" type="text" class="tabledata"
					id="purpose" onkeypress="charOnly('purpose','15')" size="40"></td>
			</tr>
			<tr>
				<td height="25" class="bolddeepblue">Ticket Requirements</td>
				<td class="bolddeepblue"><input name="ticket" type="radio"
					value="Y" checked> Yes <input name="ticket" type="radio"
					value="N"> No
				</div>
				</td>
			</tr>
			<tr>
				<td height="25" colspan="2" align="center" 
					class="tablehead">Journey Details - Depature Details</td>
			</tr>
			<tr>
				<td height="28" class="tabledata">Form Place</td>
				<td><input name="TxtFromPlace" type="text" class="tabledata"
					id="fromPlace" onkeypress="charOnly('fromPlace','20')" size="40"></td>
			</tr>
			<tr>
				<td height="28" class="tabledata">To Place</td>
				<td><input name="TxtToPlace" type="text" class="tabledata"
					id="toPlace" onkeypress="charOnly('toPlace','20')" size="40"></td>
			</tr>
			<tr>
				<td height="28" class="tabledata">Date</td>
				<td><input name="TxtDate" type="text" class="tabledata"
					onkeypress="dateOnly('TxtDate')"> <a
					href="javascript:cal2.popup();"> <img
					src="../JavaScript/img/cal.gif" width="16" height="16" border="0"
					alt="Click here to Pick Up the Date"></a> <script
					language="JavaScript">
			<!--
  			var cal2=new calendar1(document.forms['a'].elements['TxtDate']);
  			cal2.year_scroll=true;
	  		cal2.time_comp=false;
	  		setCurrentDate('TxtDate');	
	
	  			//--> 
		</script></td>
			</tr>
			<tr>
				<td height="28" class="tabledata">Time</td>
				<td class="bolddeepblue"><input name="TxtTime" type="text"
					class="tabledata" onkeypress="timeOnly('TxtTime')" size="20">
				(HH:MM:SS)</td>
			</tr>
			<tr>
				<td height="25" colspan="2" align="center" 
					class="tablehead">Journey Details - Return Jorney</td>
			</tr>
			<tr>
				<td height="28" class="tabledata">Form Place</td>
				<td><input name="TxtRetFrom" type="text" class="tabledata"
					onkeypress="charOnly('TxtRetFrom','20')" size="40"></td>
			</tr>
			<tr>
				<td height="28" class="tabledata">To Place</td>
				<td><input name="TxtRetTo" type="text" class="tabledata"
					onkeypress="charOnly('TxtRetTo','20')" size="40"></td>
			</tr>
			<tr>
				<td height="28" class="tabledata">Date</td>
				<td><input name="TxtRetDate" type="text" class="tabledata"
					onkeypress="dateOnly('TxtRetDate')"> <a
					href="javascript:cal1.popup();"> <img
					src="../JavaScript/img/cal.gif" width="16" height="16" border="0"
					alt="Click here to Pick Up the Date"></a> <script
					language="JavaScript">
			<!--
  			var cal1=new calendar1(document.forms['a'].elements['TxtRetDate']);
  			cal1.year_scroll=true;
	  		cal1.time_comp=false;
	  		setCurrentDate('TxtRetDate');	
	  			//--> 
		</script></td>
			</tr>
			<tr>
				<td height="28" class="tabledata">Time</td>
				<td class="tabledata"><input name="TxtRetTime" type="text"
					class="tabledata" id="it" onkeypress="timeOnly('it')" size="20">
				(HH:MM:SS)</td>
			</tr>
		</table>
		</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="19">&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
</table>
<input type="HIDDEN" name="filename" value="Travel">
<input type="HIDDEN" name="actionS" value="<%=actionStu %>">
<center>
<table>
	<tr>
		<td width="56" align="center" colspan="2"><input
			class="buttonbold" type="submit" name="Submit" value="Submit"   accesskey="s"   
			onclick="return validate()"></td>

		<td width="56" valign="top"><input class="buttonbold"
			type="submit" name="Submit"  value="Close"   accesskey="c"  onclick="mainPage()">
		</td>
	</tr>
	<tr>
		<td height="21">&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
</table>
</table>
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
