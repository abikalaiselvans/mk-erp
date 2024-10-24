 <%@ page import="java.sql.*,java.io.*,com.my.org.erp.bean.Attendance.StaffRegistration,java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="com.my.org.erp.common.CommonFunction"%>
<%@ page import="com.my.org.erp.common.CommonInfo"%>
<%@ page import="java.sql.*,java.io.*,java.util.*"%>
 <jsp:include page="index.jsp" flush="true" />
<jsp:useBean id="conbean" class="DBConnection.DBCon"></jsp:useBean>
<%!
	Connection con ;
	PreparedStatement pstm;
	ResultSet rst;
	String userid;
%>
<%
try
{

String dojlock =CommonFunctions.QueryExecute("SELECT CHR_DOJLOCK FROM M_INSTITUTION  WHERE INT_ID=1")[0][0];
String staffid=""+request.getParameter("staffid");
boolean rflag=false;
if( CommonFunction.RecordExist("SELECT COUNT(*) FROM com_m_staff WHERE CHR_TYPE='T' AND CHR_EMPID='"+staffid+"'"))
{
	rflag=true;
%>
<script language="javascript">
	alert("This is Resigned Staff details ");

</script>

<%

}


 
 
String dbvalue="";
String value="";
String dbvalue1="";

String staffsql="";
staffsql = " ";
staffsql = staffsql +" ";
staffsql = staffsql +" SELECT FUN_GET_COMPANY_NAME(INT_COMPANYID),FUN_GET_BRANCH_NAME(INT_BRANCHID),  ";
staffsql = staffsql +" CHR_EMPID,CHR_STAFFNAME,CHR_STAFFFNAME,  ";
staffsql = staffsql +" FUN_GET_DEPARTMENT_NAME(INT_DEPARTID), FUN_GET_DESIGNATION_NAME(INT_DESIGID),  ";
staffsql = staffsql +" FUN_GET_OFFICE_NAME(INT_OFFICEID), CHR_GENDER,DATE_FORMAT(DT_DOB,'%d-%m-%Y'),  ";
staffsql = staffsql +" CHR_BG, DATE_FORMAT(DT_DOJCOLLEGE,'%d-%m-%Y'),  INT_BALANCE,CHR_TYPE,  ";
staffsql = staffsql +" INT_SALARY,CHR_PF,CHR_ESI,INT_GROSSSALARY,CHR_MARITALSTATUS,   ";
staffsql = staffsql +" DATE_FORMAT(DT_WEDDATE,'%d-%m-%Y'), CHR_BANK,CHR_ACCNO,  ";
staffsql = staffsql +" CHR_PADD1,CHR_PADD2,CHR_PCITY,CHR_PSTATE,CHR_PPIN,CHR_SADD1,CHR_SADD2,  ";
staffsql = staffsql +" CHR_SCITY, CHR_SSTATE,CHR_SPIN,CHR_PPHONE,CHR_SPHONE,CHR_EMAILID,CHR_MOBILE,  ";
staffsql = staffsql +" CHR_PFTYPE,INT_PFAMT, CHR_PFNO,CHR_ESITYPE,INT_ESIAMT,CHR_ESINO,CHR_LEAVECARRY,  ";
staffsql = staffsql +" CHR_QUALIFICATION,CHR_MANAGEMENT, FIND_A_EMPLOYEE_ID_NAME(CHR_REPTO),CHR_REP,CHR_HOLD,INT_PLACEID,  ";
staffsql = staffsql +" CHR_CONVEYANCECLEAR,CHR_SALARYCALCULATE,CHR_PAYSLIPHIDE, CHR_CATEGORY,CHR_USERID,   ";
staffsql = staffsql +" DATE_FORMAT(DAT_PFESIDATE,'%d-%m-%Y'),DATE_FORMAT(DAT_RESIGNDATE,'%d-%m-%Y'),   ";
staffsql = staffsql +" CHR_PAN,CHR_PASSPORT,CHR_DRIVING, CHR_PERMAILID,CHR_PREVIOUSDETAILS,  ";
staffsql = staffsql +" CHR_MOTHERNAME,CHR_COMPANYPFNO,CHR_ADDRESSSTATUS, CHR_FUTURE10,INT_PDISTRICTID,  ";
staffsql = staffsql +" INT_PCOUNTRYID,INT_CDISTRICTID,INT_CCOUNTRY,CHR_ADDRESSPROOFSTATUS, CHR_PFCLAIMSTATUS,  ";
staffsql = staffsql +" DATE_FORMAT(DAT_PFCLIAMDATE,'%d-%m-%Y'),CHR_PFCLIAMDESCRIPTION,   ";
staffsql = staffsql +" DATE_FORMAT(DAT_PFRESIGNDATE,'%d-%m-%Y'),CHR_INTERVIEW,   ";
staffsql = staffsql +" CHR_REJOIN,CHR_NOMINEE,CHR_SALARYSPLITUP,DATE_FORMAT(DT_CREATION_DATE,'%d-%m-%Y'),  ";
staffsql = staffsql +" CHR_CREATEDBY, DATE_FORMAT(DAT_RIVISION,'%d-%m-%Y'), INT_CTC,INT_GROSS_PERCENT,  ";
staffsql = staffsql +" INT_VARIABLE_PERCENT,CHR_IFSC,INT_ATTENDANCECYCLE,CHR_SALARYTYPE,  ";
staffsql = staffsql +" FUN_GET_LOCATION_NAME(INT_LOCATIONID),CHR_NOMINEE_RELATIONSHIP,CHR_SPOUSENAME ,  ";
staffsql = staffsql +" DATE_FORMAT(DT_ACTUAL_DOB,'%d-%m-%Y'),CHR_AADHARNO ";
staffsql = staffsql +" FROM com_m_staff WHERE CHR_EMPID='"+staffid+"'  ";
//out.println(staffsql);
String staffData[][]= CommonFunctions.QueryExecute(staffsql);
 

%>
<html>
<head>

<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/AJAXFunctionStaff.js"></script>
<script language="JavaScript" src="../JavaScript/Attendance/AttendanceAjax.js"></script>
<script language="javascript" src="../JavaScript/Attendance/ReportAjax.js"></script>
<script language="javascript" src="../JavaScript/AJAX.js"></script>
<script language="JavaScript" src="../JavaScript/commonAJAX.js"></script>
<script language="javascript" src="../JavaScript/common/PermanentSelectChangesCountry.js"></script>
<script language="javascript" src="../JavaScript/common/communicationSelectChangesCountry.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"> </script>

 <script language="JavaScript" src="../JavaScript/jquery/ui/jquery.ui.core.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/jquery/ui/jquery.ui.widget.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js" type="text/javascript"></script>

 	
<script>
		
	var d1=new Date();
	var day1=d1.getDate();	
	var dojlock= "<%=dojlock%>";

	$(function() {
		$( "#dob" ).datepicker({
			changeMonth: true,
			changeYear: true, 
			showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			buttonImageOnly: true
		});
	}); 
	
	$(function() {
		$( "#adob" ).datepicker({
			changeMonth: true,
			changeYear: true, 
			showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			buttonImageOnly: true
		});
	}); 
	
	
	$(function() {
		$( "#revisiondate" ).datepicker({
			changeMonth: true,
			changeYear: true, 
			showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			buttonImageOnly: true
		});
	}); 
	 
	  $(function() {
		$( "#wedding" ).datepicker({
			changeMonth: true,
			changeYear: true, 
			showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			buttonImageOnly: true
		});
	}); 
	 
	 $(function() {
		$( "#pfesidate" ).datepicker({
			changeMonth: true,
			changeYear: true,minDate: -60, maxDate: "+0D" ,
			showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			buttonImageOnly: true
		});
	}); 
	
	$(function() {
		$( "#resigndate" ).datepicker({
			changeMonth: true,
			changeYear: true,minDate: -60, maxDate: "+0D" ,
			showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			buttonImageOnly: true
		});
	}); 
	
</script>
	
	
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
function lookup(inputString) 
{
	if(inputString.length == 0) 
	{
		$('#suggestions').hide();
	} 
	else 
	{
		$.post("pincodes.jsp", {queryString: ""+inputString+""}, function(data)
		{
			if(data.length >0) 
			{
				$('#suggestions').show();
				$('#autoSuggestionsList').html(data);
			}
		});
	}
}



 
function fill(thisValue) 
{
	var listArray = thisValue.split("/");
	setOptionValue('pcountry',listArray[0]);
	
	var _targ=document.getElementsByName('pstate')[0];       
	 _targ.options.length=0;
	 _targ.options[0]=new Option(listArray[3],listArray[2]);  

	var _targ1=document.getElementsByName('pdistrict')[0];       
	 _targ1.options.length=0;
	 _targ1.options[0]=new Option(listArray[5],listArray[4]);  
	 
	 
	var _targ2=document.getElementsByName('pcity')[0];       
	 _targ2.options.length=0;
	 _targ2.options[0]=new Option(listArray[7],listArray[6]);  
	 
	 
	document.getElementById('ppincode').value=listArray[8];
	
	$('#ppincode').val(listArray[8]);
	setTimeout("$('#suggestions').hide();", 200);
}




function cfill(thisValue) 
{
	var listArray = thisValue.split("/");
	setOptionValue('ccountry',listArray[0]);
	
	var _targ=document.getElementsByName('cstate')[0];       
	 _targ.options.length=0;
	 _targ.options[0]=new Option(listArray[3],listArray[2]);  

	var _targ1=document.getElementsByName('cdistrict')[0];       
	 _targ1.options.length=0;
	 _targ1.options[0]=new Option(listArray[5],listArray[4]);  
	 
	 
	var _targ2=document.getElementsByName('ccity')[0];       
	 _targ2.options.length=0;
	 _targ2.options[0]=new Option(listArray[7],listArray[6]);  
	 
	 
	document.getElementById('cpincode').value=listArray[8];
	
	$('#cpincode').val(listArray[8]);
	setTimeout("$('#suggestions1').hide();", 200);
}

function clookup(inputString) 
{
	if(inputString.length == 0) 
	{
		$('#suggestions1').hide();
	} 
	else 
	{
		$.post("cpincodes.jsp", {queryString: ""+inputString+""}, function(data)
		{
			if(data.length >0) 
			{
				$('#suggestions1').show();
				$('#autoSuggestionsList1').html(data);
			}
		});
	}
}
</script>
<style type="text/css">
body {
font-family: Helvetica;
font-size: 13px;
color: #000;
}
h3 {
margin: 0px;
padding: 0px;
}


.suggestionsBox 
{
	position: relative;
	margin: 0px 0px 0px 0px;
	width: 200px;
	background-color: #ffffff;
	-moz-border-radius: 7px;
	-webkit-border-radius: 7px;
	border: 1px solid #000;
	color: #000;
}
.suggestionList 
{
	margin: 0px;
	padding: 0px;
}
.suggestionList li 
{
	margin: 0px 0px 3px 0px;
	padding: 3px;
	cursor: pointer;
}

.suggestionList li:hover {
background-color: #ffffff;
}


.suggestionsBox1 
{
	position: relative;
	margin: 0px 0px 0px 0px;
	width: 200px;
	background-color: #ffffff;
	-moz-border-radius: 7px;
	-webkit-border-radius: 7px;
	border: 1px solid #000;
	color: #000;
}
.suggestionList1 
{
	margin: 0px;
	padding: 0px;
}
.suggestionList1 li 
{
	margin: 0px 0px 3px 0px;
	padding: 3px;
	cursor: pointer;
}

.suggestionList1 li:hover {
background-color: #ffffff;
}
</style>





<script language="javascript">	
 
  	
function changeState1()
{
	cwd.style.visibility="visible";
	cwd1.style.visibility="visible";
	document.getElementById('mtype').value="M";
} 

function changeState()
{
	document.a.wedding.value="";
	cwd.style.visibility="hidden";
	document.getElementById('mtype').value="U";
	
	cwd1.style.visibility="hidden";
	document.getElementById('spousename').value="";
} 	




function resetIFSC()
{
	try
	{
		document.getElementById('ifsccode').value="";
		document.getElementById('ifsccode').focus();
	}
	catch(err)
	{
		alert(err);
	}
}


	 

 
function resoffval()
{
	if(document.a.res[0].checked==true)
	{
		document.a.cadd1.value = document.a.padd1.value;
		document.a.cadd2.value = document.a.padd2.value;
		copyDropdown('pcity','ccity');
		copyDropdown('pstate','cstate');
		copyDropdown('pdistrict','cdistrict');
		document.a.ccountry.selectedIndex = document.a.pcountry.selectedIndex;
		document.a.cstate.selectedIndex = document.a.pstate.selectedIndex+1;
		document.a.cdistrict.selectedIndex = document.a.pdistrict.selectedIndex+1;
		document.a.ccity.selectedIndex = document.a.pcity.selectedIndex+1;
		document.a.cpincode.value = document.a.ppincode.value;
		document.a.cphone.value = document.a.pphone.value;
	}         
	else 
	{
		document.a.cadd1.value = "";
		document.a.cadd2.value = "";
		var _targ1=document.getElementsByName('ccity')[0];       
		_targ1.options.length=0;
		_targ1.options[0]=new Option('Select City','0');  
		
		_targ1=document.getElementsByName('cdistrict')[0];       
		_targ1.options.length=0;
		_targ1.options[0]=new Option('Select District','0');  
		
		
		_targ1=document.getElementsByName('cstate')[0];       
		_targ1.options.length=0;
		_targ1.options[0]=new Option('Select State','0');  
		
		document.a.ccity.selectedIndex = 0;
		document.a.cdistrict.selectedIndex = 0;
		document.a.cstate.selectedIndex = 0;
		document.a.ccountry.selectedIndex = 0;
		document.a.cpincode.value = "";
		document.a.cphone.value = "";
		
	}
	return true;
}//end of resoffval

 
 
 
 function pfchange()
{
	 
	if(document.getElementById('pf').value== "Y" )
	{
		setOptionValue('optpf','A');
		document.getElementById('nominee').value= document.getElementById('fname').value;
		document.getElementById('optpf').disabled;
		pf0.style.visibility="Visible";
		pf1.style.visibility="Visible";
		pf2.style.visibility="Visible";
	}	
	else if (document.getElementById('pf').value== "N" )
	{
		setOptionValue('optpf','o');
		pf0.style.visibility="hidden";
		pf1.style.visibility="hidden";
		pf2.style.visibility="hidden";
		document.getElementById('txtpfvalue').value="0";
	}	
	else if (document.getElementById('pf').value== "C" )
	{
		setOptionValue('optpf','P');
		document.getElementById('nominee').value= document.getElementById('fname').value;
		pf0.style.visibility="Visible";
		pf1.style.visibility="Visible";
		pf2.style.visibility="hidden";
		document.getElementById('txtpfvalue').value="0";
	}
	else if (document.getElementById('pf').value== "0" )
	{
		setOptionValue('optpf','0');
		pf0.style.visibility="Visible";
		pf1.style.visibility="Visible";
		pf2.style.visibility="Visible";
	}		
}


function pftypechange()
{
	 
	if(document.getElementById('optpf').value== "0" )
	{
		setOptionValue('pf','0');
		pf0.style.visibility="Visible";
		pf1.style.visibility="Visible";
		pf2.style.visibility="Visible";
	}	
	else if (document.getElementById('optpf').value== "A" )
	{
		setOptionValue('pf','Y');
		pf0.style.visibility="Visible";
		pf1.style.visibility="Visible";
		pf2.style.visibility="Visible";
		
	}	
	else if (document.getElementById('optpf').value== "P" )
	{
		setOptionValue('pf','C');
		pf0.style.visibility="Visible";
		pf1.style.visibility="Visible";
		pf2.style.visibility="hidden";
		document.getElementById('txtpfvalue').value="0";
	}	
}



 function ESIchange()
{
	 
	if(document.getElementById('esi').value== "Y" )
	{
		setOptionValue('optesi','A');
		ppf0.style.visibility="Visible";
		ppf1.style.visibility="Visible";
		ppf2.style.visibility="Visible";
	}	
	else if (document.getElementById('esi').value== "N" )
	{
		setOptionValue('optesi','o');
		ppf0.style.visibility="hidden";
		ppf1.style.visibility="hidden";
		ppf2.style.visibility="hidden";
		document.getElementById('txtesivalue').value="0";
	}	
	else if (document.getElementById('esi').value== "C" )
	{
		setOptionValue('optesi','P');
		ppf0.style.visibility="Visible";
		ppf1.style.visibility="Visible";
		ppf2.style.visibility="hidden";
		document.getElementById('txtesivalue').value="0";
	}
	else if (document.getElementById('esi').value== "0" )
	{
		setOptionValue('optesi','0');
		ppf0.style.visibility="Visible";
		ppf1.style.visibility="Visible";
		ppf2.style.visibility="Visible";
	}		
}




function esitypechange()
{
	 
	if(document.getElementById('optesi').value== "0" )
	{
		setOptionValue('esi','0');
		ppf0.style.visibility="Visible";
		ppf1.style.visibility="Visible";
		ppf2.style.visibility="Visible";
	}	
	else if (document.getElementById('optesi').value== "A" )
	{
		setOptionValue('esi','Y');
		ppf0.style.visibility="Visible";
		ppf1.style.visibility="Visible";
		ppf2.style.visibility="Visible";
	}	
	else if (document.getElementById('optesi').value== "P" )
	{
		setOptionValue('esi','C');
		ppf0.style.visibility="Visible";
		ppf1.style.visibility="Visible";
		ppf2.style.visibility="Visible";
		ppf2.style.visibility="hidden";
		document.getElementById('txtesivalue').value="0";
	}	
}






</script>

<title> :: COMMON ::</title>


 



<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>
  
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  onselectstart="return false" onpaste="return false;"  onCut="return false" onDrag="return false" onDrop="return false" autocomplete="off">

<form  AUTOCOMPLETE = "off"   name="a" method="post" action="../SmartLoginAuth" 	onsubmit="return validateFields()">


<table width="100%" border="0">
	<tr>
		<td class="boldEleven">
	  </td>
	</tr>
	<tr>
		<td height="59">&nbsp;</td>
	</tr>
	<tr>
		<td valign="top">
		<table width="90%" border="0" align="center" cellpadding="2"
			cellspacing="2">
			<tr>
				 
				<td width="73%"  >
				<TABLE width=563 border=0 align=center cellPadding=0 cellSpacing=0
					bgcolor="#dce4f9" class=BackGround>
					<TBODY>
						<TR>
							<TD colSpan=2 rowSpan=2><IMG height=7
								src="../Image/General/TLCorner.gif" width=7></TD>
							<TD class=BorderLine height=1><SPACER height="1" width="1"
								type="block" /></TD>
							<TD colSpan=2 rowSpan=2><IMG height=7
								src="../Image/General/TRCorner.gif" width=7></TD>
						</TR>
						<TR>
							<TD height=6><SPACER height="1" width="1" type="block" /></TD>
						</TR>
						<TR>
							<TD class=BorderLine width=1><SPACER height="1" width="1"
								type="block" /></TD>
							<TD width=6><SPACER height="1" width="1" type="block" /></TD>
							<TD width=549 valign="top">
							<table width="707" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td colspan="2">
									<div align="center"><span class="boldThirteen">Staff
									Registration </span></div>
									</td>
								</tr>
								<tr>
									<td colspan="2">
									<div align="right"><span class="errormessage"> * </span><span
										class="changePos">Mandatory</span></div>
									</td>
								</tr>
								<tr>
									<td colspan="2">
									<table width="288" border="0" align="center" cellpadding="0"
										cellspacing="0">
										<tr>
											<td width="122" class="boldEleven">
											<div align="right">  
											</div>
											</td>
											 
											<td width="20"><input name="grade"  id="grade" type="hidden"
												value="S"  /></td>
											<td width="37"><span class="boldEleven"> </span></td>
											<td width="15">&nbsp;</td>
										</tr>
									</table>
									</td>
								</tr>

								<tr>
									<td colspan="2">&nbsp;</td>
								</tr>
								<tr>
									<td colspan="2"></td>
								</tr>
								<tr>
									<td height="19" colspan="2">
                                    
                                    
                                      
						<fieldset>
			<legend><strong><img src="../images/icon-misuse.gif">  Official Informations</strong></legend>

 
									<table width="100%"  align="center" cellpadding="0"
										cellspacing="0" >
										<tr>
											<td height="290">
											<table width="100%" border="0" align="center" cellpadding="2"
												cellspacing="2">
												<tr>
													<td valign="top">
													<table width="100%" border="0" align="center"
														cellpadding="1" cellspacing="2"  
														class="boldEleven">
														<tr>
															<td colspan="2">&nbsp;</td>
														</tr>
														<tr>
															<td colspan="2">
															<div align="center"><span class="tabledata"><strong>Personal
															Informations </strong></span></div>															</td>
														</tr>
														<tr>
															<td width="129">&nbsp;</td>
															<td width="170">&nbsp;</td>
														</tr>
														<tr>
															<td class="boldEleven"> Staff Id <font class="errormessage"
																align="absmiddle">&nbsp; </font></td>
															<td class="boldEleven"><b><%=staffData[0][2]%> 
															<input name="id" type="hidden" class="formText135" id="id" value="<%=staffData[0][2]%> " size="25" />
															<div id="userIdMessage"></div>															</td>
														</tr>
														<tr>
															<td class="boldEleven">Staff Name<font class="errormessage" align="absmiddle"> * </font></td>
															<td class="boldEleven"><input name="name" type="text"
																class="formText135" id="name"   onBlur="upperMe(this)" onKeyUp="LoadUniqueCheck('name', 'namediv', 'com_m_staff', 'CHR_STAFFNAME', 'submit_btn')" value="<%=staffData[0][3]%> "
																size="30" maxlength="50"   />
															<div id="namediv"></div></td>
														</tr>
														<tr>
															<td class="boldEleven">Father Name</td>
															<td class="boldEleven"><input name="fname" type="text"
																class="formText135" id="fname"   onBlur="upperMe(this)"    
																onKeyPress="charOnly('fname','50')"
																value="<%=staffData[0][4]%> " size="30" maxlength="50" /></td>
														</tr>
														<tr>
														  <td class="boldEleven">Mother Name<font class="errormessage" align="absmiddle"> *</font></td>
														  <td class="boldEleven"><input name="mothername"    type="text" class="formText135" id="mothername" value="<%=staffData[0][61]%> " size="30"    onBlur="upperMe(this)"    maxlength="50"></td>
													  </tr>
														<tr> 
															<td class="boldEleven">Gender 
															
<%
										
												
									String grd="";
									String grd1="";
									grd="";
									grd1="";
							
									if("Male".equals( staffData[0][8]  ))
										grd ="checked='checked'";
							
									if("Female".equals(staffData[0][8] ))
										grd1 ="checked='checked'";
										 
										 
										   %>															</td>
															<td class="boldEleven">
															<table width="152" border="0" cellspacing="0"
																cellpadding="0">
																<tr>
																	<td width="20"><input name="gender" id="gender" type="radio"
																		class="formText135" value="Male" <%=grd%> /></td>
																	<td width="47" class="boldEleven">Male</td>
																	<td width="26"><input name="gender"  id="gender" type="radio"
																		class="formText135" <%=grd1%> value="Female" /></td>
																	<td width="59" class="boldEleven">Female</td>
																</tr>
															</table>															</td>
														</tr>
														<tr>
															<td class="boldEleven">Blood Group  <font class="errormessage"
																align="absmiddle">*</font></td>
															<td class="boldEleven">
<jsp:include page="../JavaScript/bloodgroup.jsp" flush="true" />	
<script language="javascript">setOptionValue('bg','<%=staffData[0][10]%>')</script> 																	 													</td>
														</tr>
														
														<tr>
															<td class="boldEleven">Date Of Birth 
															
															 
															 <font class="errormessage"
																align="absmiddle">*</font>														   															</td>
															<td class="boldEleven">
<input name="dob" id="dob" type="text" class="formText135" size="22" value="<%=staffData[0][9] %>" title=" dd/mm/yyyy ( For e.g 21-10-1977)" readonly /> </td>
														</tr>
														
														
														<tr>
															<td class="boldEleven">Actual Date Of Birth <font class="errormessage"
																align="absmiddle">*</font> </td>
															<td class="errormessage"><input name="adob" id="adob" type="text" class="formText135" size="22" value="<%=staffData[0][90] %>" title=" dd/mm/yyyy ( For e.g 21-10-1977)" readonly /></td>
														</tr>
														
														<tr>
														  <td class="boldEleven">Date Of Join <font class="errormessage"
																align="absmiddle">*</font></td>
														  <td class="boldEleven"><span class="errormessage">
                                                          <input name="doj" id="doj" type="hidden" value="<%=staffData[0][11] %>">
                                                          <%=staffData[0][11] %> </span></td>
													  </tr>
														<tr>
															
															<td class="boldEleven">Marital  Status 
														  <%
									grd="";
									grd1="";
							 
									if("M".equals(staffData[0][18] ))
										grd ="checked='checked' ";
									
									if("U".equals(staffData[0][18] ))
										grd1 ="checked='checked' ";
												
									
									
										%>	 														</td>
															<td class="boldEleven">
															<table width="152" border="0" cellpadding="0"
																cellspacing="0" class="boldEleven">
																<tr>
																	<td class="boldEleven"> 
<input name="marry" id="marry"  type="radio" value="M" <%=grd%> onClick='changeState1()' class="formText135" /> </td>
																	<td class="boldEleven">Married</td>
																	<td class="boldEleven"> 
<input name="marry" id="marry"  type="radio" class="formText135" onClick='changeState()' value="U" <%=grd1%> /> </td>
																	<td class="boldEleven">UnMarried
																	
																	<input name="card" type="hidden" id="card" value="" />
                                        <input name="mtype"  id="mtype"  type="hidden" value="<%=staffData[0][18]%>" />																	</td>
																</tr>
															</table>															</td>
														</tr>
														
														<tr id="cwd">
															<td class="boldEleven">Wedding Date 															</td>
															<td class="boldEleven">
<input name="wedding" type="text" class="formText135" id="wedding" size="22" value="<%=staffData[0][19] %>" readonly/> </td>
														</tr>
														
														<tr  id="cwd1">
                              <td valign="top" class="boldEleven">Spouse Name <font class="errormessage"
																align="absmiddle">*</font></td>
                              <td valign="top"><input name="spousename" type="text" class="formText135" id="spousename"   onBlur=" upperMe(this)" value="<%=staffData[0][89]%>" size="30"
																maxlength="50"></td>
                            </tr>
														
														 
														
														<tr>
															<td class="boldEleven">Off. E-mail														    									</td>
															<td class="boldEleven"><input name="emailid" type="email"
																class="formText135" id="emailid"
																 
																value="<%=staffData[0][34] %>" size="30" maxlength="100" />															</td>
														</tr>
														<tr>
														  <td class="boldEleven">Per. E-mail
													        <font class="errormessage"
																align="absmiddle">*</font>												           </td>
														  <td class="boldEleven"><input name="peremailid" type="email"
																class="formText135" id="peremailid" 
																 value="<%=staffData[0][59] %>" size="30" maxlength="100" />
													      <div id='emaildiv'></div> </td>
													  </tr>
														<tr>
															<td class="boldEleven">Mobile  										</td>
															<td class="boldEleven"><input name="mobile" type="text"
																class="formText135" id="mobile"   
																 onKeyPress=" return numeric_only(event,'mobile','11')"  size="30"
																maxlength="10" value="<%=staffData[0][35] %>" /> </td>
														</tr>
														<tr>
															<td class="boldEleven">Qualifications   <font class="errormessage"
																align="absmiddle">*</font>														   										</td>
															<td class="boldEleven"> 
															<select name="qualification" size="1" class="formText135"
																id="qualification" style="width:170">
																<option value="0">Select</option>
																<%
										String ssql=" SELECT INT_QUALIFICATIONID,CHR_QUALIFICATIONNAME FROM com_m_qualification ORDER BY CHR_QUALIFICATIONNAME";
										String qualdata[][]=CommonFunctions.QueryExecute(ssql);
										for(int c=0;c<qualdata.length;c++)
										{
											out.println("<option value='"+qualdata[c][0]+"'>"+qualdata[c][1]+"</option>");
										}
									%>
															</select> <script language="javascript">
									setOptionValue("qualification","<%=staffData[0][43]%>") 
									</script></td>
														</tr>
														<tr>
															<td class="boldEleven">Reporting to<font
																class="errormessage" align="absmiddle">&nbsp; </font></td>
															<td class="errormessage">
<%=staffData[0][45]%>														  </td>
														</tr>
														 
														<tr>
														  <td class="boldEleven">Category   <font class="errormessage"
																align="absmiddle">&nbsp; </font></td>
														  <td class="errormessage">
														  
<%= CommonFunctions.QueryExecute(" SELECT CHR_CATEGORYNAME FROM  com_m_employeecategory where INT_EMPLOYEECATEGORYID="+staffData[0][52])[0][0]%>													      </td>
													  </tr>
														<tr>
														  <td class="boldEleven">Attendance Cycle
<%
String cdata[][]=CommonFunctions.QueryExecute("SELECT INT_FROM,INT_TO FROM att_m_basicsettings  WHERE INT_ID=1");
%>
														  
														   <font
																class="errormessage" align="absmiddle">*</font></td>
														  <td class="errormessage">
														  <%="1".equals(staffData[0][85])?" 1-31" : (cdata[0][0] +"th -" +cdata[0][1]+"-th") %>
														  
				<input name="attendancecycle"   id="attendancecycle" type="hidden" value="<%=staffData[0][85]%>">											 </td>
													  </tr>
														<tr>
														  <td class="boldEleven">Salary Type <font
																class="errormessage" align="absmiddle">*</font></td>
														  <td class="boldEleven"><select name="salarytype" id="salarytype"  class="formText135" style="width:170">
												<option value="0">Select Salary Type</option>
												<option value="CTC">CTC - Based</option>
												<option value="MTH">MONTH - Based</option>
												<option value="WRK">Working Days (Daily Wages) - Based</option>
                                            </select><script language="javascript">setOptionValue('salarytype','<%=staffData[0][86]%>')</script> </td>
													  </tr>
													</table>
													</td>
													<td class="boldEleven">
													<table width="100%" border="0" align="center"
														cellpadding="1" cellspacing="3" bordercolor="#D4D0C8"
														class="boldEleven">
														<tr>
															<td colspan="5">&nbsp;</td>
														</tr>
														<tr>
															<td colspan="5">
															<div align="center"><span class="tabledata"><strong>Official
															Details</strong></span></div>															</td>
														</tr>
														<tr>
															<td width="125" class="boldEleven">Company<font
																class="errormessage" align="absmiddle">&nbsp; </font></td>
														    <td colspan="4" class="errormessage">
 <%=staffData[0][0]%> </td>
														</tr>
														<tr>
															<td width="125" class="boldEleven">Branch<font
																class="errormessage" align="absmiddle">&nbsp; </font></td>
															<td colspan="4" class="errormessage">
<%=staffData[0][1]%> 		 												  </td>
														</tr>

														 
														 
														<tr>
															<td   class="boldEleven">Office<font
																class="errormessage" align="absmiddle">&nbsp; </font></td>
															<td colspan="4" class="errormessage">
<%=staffData[0][7]%> 														  </td>
														</tr>
														<tr>
														  <td class="boldEleven">Location</td>
														  <td colspan="4" class="errormessage"><%=staffData[0][87]%> </td>
													  </tr>
														<tr>
															<td class="boldEleven">Department<font class="errormessage"
																align="absmiddle">&nbsp; </font></td>
															<td colspan="4" class="errormessage">
															
<%=staffData[0][5]%> 	 																														</td>
														</tr>
														<tr>
															<td class="boldEleven">Designation<font class="errormessage"
																align="absmiddle">&nbsp; </font><font class="redcol style3"
																align="absmiddle">&nbsp;</font></td>
															<td colspan="4" class="errormessage">
															
<%=staffData[0][6]%>  														</td>
														</tr>
														<tr>
															<td class="boldEleven">Type  <font class="errormessage"
																align="absmiddle">&nbsp; </font></td>
														    <td colspan="4" class="errormessage">
														  
														   
 
															
<%



 out.println("<input type='hidden'  name='stype'   id='stype' value='"+staffData[0][13]+"'><font class='errormessage'> "+staffData[0][13]+"  </font>");
%>														  </td>
														</tr>
														<tr>
														  <td class="boldEleven">Salary Split up
                                                          <script language="javascript">


function basicdisable()
{
	bid.style.visibility="hidden";
	document.getElementById('basic').value="0";
}
	
	 
function basicenable()
{
	document.getElementById('basic').value="0";
	bid.style.visibility="visible";
} 


                                                            </script></td>
														  <td colspan="4" class="errormessage">
														  <%
														  if("A".equals(staffData[0][77]))
														  	out.println("Automatic");
														  else if("M".equals(staffData[0][77]))
														  	out.println("Manual");
														  else 	
														  	out.println("");
														  %>
							 <input name="salarysplitupby" type="hidden" value="<%=staffData[0][77]%>">														  </td>
													  </tr>
														<tr>
															<td class="boldEleven">Basic Salary													       											</td>
															<td colspan="4"><input name="basic" type="text"
																class="formText135" id="basic"
																 value="<%=staffData[0][14]%>"  onKeyPress="return numeric_only(event,'basic','10')" 
																size="30" maxlength="7" /></td>
														</tr>
														<tr>
															<td class="boldEleven">Splitup Gross <font class="errormessage"
																align="absmiddle">*</font>														   										</td>
															<td colspan="4"><input name="gross" type="text"
																class="formText135" id="gross"
																  onKeyPress="return numeric_only(event,'gross','10')" 
																value="<%=staffData[0][17]%>" size="30" maxlength="7" />
																
																<%
String salaryData[][] = CommonFunctions.QueryExecute(" SELECT INT_STARTINGSALARY,INT_ENDINGSALARY FROM  pay_m_salaryband  ORDER BY INT_SALARYBANDID ");
	String lvalue="";
	for(int x=0; x<salaryData.length;x++)
	{
		for(int y=0; y<2;y++)
		{
			lvalue = lvalue+salaryData[x][y]+",";
		}
		lvalue = lvalue+"~";	
	}
	
	
	
	String stafftypeDatas[][] = CommonFunctions.QueryExecute(" SELECT  CHR_TYPENAME,CHR_FLAG FROM com_m_stafftype  ORDER BY CHR_TYPENAME ");
	String svalue="";
	for(int x=0; x<stafftypeDatas.length;x++)
	{
		for(int y=0; y<2;y++)
		{
			svalue = svalue+stafftypeDatas[x][y]+",";
		}
		svalue = svalue+"~";	
	}
	
	
%>
<script language="javascript">
	var salarybandvalue = "<%=lvalue%>";
	var salarybandvalue1 =salarybandvalue.split("~");
	var f= false;
	function checkSalaryBand()
	{
		var gross =document.getElementById("gross").value;
		for(i=0; i<salarybandvalue1.length-1; i++)
 		{
   			 var v = salarybandvalue1[i].split(",")
			 var gt = parseInt(v[0]);
			 var lt = parseInt(v[1]);
			 if((gross >gt) &&(gross <=lt))
			 	f = true; 
			 
   		}
		if(f)
			return true;
		else
		{
			alert("Your gross not in Salary Slab....");
			document.getElementById("gross").focus();
			return false;
		}	
	}
	
	
	var f1 =false;
	function checkSalaryType()
	{
		var salarytypevalue = "<%=svalue%>";
		var salarytypevalue1 =salarytypevalue.split("~");
		var type =document.getElementById("type").value;
		f1 =false;
		for(i=0; i<salarytypevalue1.length-1; i++)
 		{
   			 var v = salarytypevalue1[i].split(",")
			 var name =  (v[0]);
			 var status =  (v[1]);
			 if((type === name) &&(status ==="Y"))
			 	f1 = true; 
		}
		
		return f1;
		
	}
	
	
</script>														  </td>
														</tr>
														<tr>
															<td class="boldEleven">Bank Name  <font class="errormessage"
																align="absmiddle">*</font>														   										</td>
															<td colspan="4"> 
								
												 
									
				 
						
<input name="bank" id="bank" type="hidden" value="<%=staffData[0][20]%>">


<font class='errormessage'><%=CommonFunctions.QueryExecute("SELECT INT_BANKGROUPID, CHR_BANKGROUPNAME  FROM com_m_bankgroup WHERE INT_BANKGROUPID = "+staffData[0][20]+" ORDER BY CHR_BANKGROUPNAME")[0][1]%>	</font></td>
														</tr>
														<tr>
															<td class="boldEleven">Account No  												</td>
															<td colspan="4">
<input name="number"  type="hidden" class="formText135" id="no" value="<%=staffData[0][21]%>"  size="30" maxlength="25"  onkeyup=" checkAccounts(this) "/>
<script language="javascript">
 
function checkAccounts(ctr)
{
	try
	{
		
		document.getElementById('submit_btn').disabled=false;	
		var v = ctr.value;
		v = v.toUpperCase();
		v = v.replace('','');
		var f = ( ( v !="") && (v != "DD") );
		
		if( f)
			LoadUniqueCheck('no', 'acc', 'com_m_staff', 'CHR_ACCNO', 'submit_btn')
		else
		{
			document.getElementById('submit_btn').disabled=false;	
			document.getElementById('acc').innerHTML=""; 
		}
	}
	catch(err)
	{
		alert(err);
	}			
	
}


</script>
<div id="acc"></div><font class='errormessage'><%=staffData[0][21]%>	</font>															</td>
														</tr>
														<tr>
                                                          <td class="boldEleven">IFSC CODE </td>
														  <td colspan="4">
                                                          

<script language="javascript">
 function ifsccodefill(thisValue) 
{
	 document.getElementById('ifsccode').value=thisValue;
	
	 
	setTimeout("$('#ifsccode1').hide();", 200);
}

function ifsccodelookup(inputString) 
{
	if(checkNullSelect('bank','Select Bank','0'))
	{
		var bank = document.getElementById('bank').value;
		if(inputString.length == 0) 
		{
			$('#ifsccode1').hide();
		} 
		else 
		{
			$.post("ifsccode.jsp?bank="+bank, {queryString: ""+inputString+" "  }, function(data)
			{
				if(data.length >0) 
				{
					$('#ifsccode1').show();
					$('#ifsccodeList1').html(data);
				}
			});
		}	
	}
	
	
}
</script>
<style type="text/css">
 

.ifsccodeBox1 
{
	position: relative;
	margin: 0px 0px 0px 0px;
	width: 200px;
	background-color: #ffffff;
	-moz-border-radius: 7px;
	-webkit-border-radius: 7px;
	border: 1px solid #000;
	color: #000;
}
.ifsccodeList1 
{
	margin: 0px;
	padding: 0px;
}
.ifsccodeList1 li 
{
	margin: 0px 0px 3px 0px;
	padding: 3px;
	cursor: pointer;
}

.ifsccodeList1 li:hover {
background-color: #ffffff;
}
</style>

<input name="ifsccode" type="hidden"	class="formText135" id="ifsccode"  size="30"    onBlur="ifsccodefill('0');" 											maxlength="20"  tabindex="29" onKeyUp="ifsccodelookup(this.value);" value="<%=staffData[0][84]%>"/>
 <div class="ifsccodeBox1" id="ifsccode1" style="display: none;width:250%;">
					<div class="ifsccodeList1" id="ifsccodeList1" style="OVERFLOW:auto;width:100%;height:200px" ></div>
</div>	
<font class='errormessage'><%=staffData[0][84]%> </font></td>
													  </tr>
														<tr>
															<td class="boldEleven">Leave Carry <%
									dbvalue=staffData[0][42];
									if ("Y".equals(dbvalue))
										dbvalue=" checked='checked' ";
									else
										dbvalue=" ";
									%>															</td>
															<td><input name="carry"
																type="checkbox" id="carry" value="Y" <%=dbvalue%>></td>
														    <td class="boldEleven">&nbsp;</td>
														    <td class="boldEleven">Interview
                                                            <%
														dbvalue=staffData[0][74];
														if ("Y".equals(dbvalue))
															dbvalue=" checked='checked' ";
														else
															dbvalue=" ";

															%></td>
														    <td class="boldEleven"><input name="interview" type="checkbox" id="interview" value="Y"  <%=dbvalue%>  ></td>
														</tr>
														<tr>
															<td class="boldEleven">Management <%
									dbvalue=staffData[0][44];
									if ("Y".equals(dbvalue))
										dbvalue=" checked='checked' ";
									else
										dbvalue=" ";
									%>															</td>
															<td class="boldEleven"><input
																name="management" type="checkbox" id="management" value="Y" <%=dbvalue%>></td>
														    <td class="boldEleven">&nbsp;</td>
														    <td class="boldEleven">Payslip hide
                                                            <%
														dbvalue=staffData[0][51];
														if ("Y".equals(dbvalue))
															dbvalue=" checked='checked' ";
														else
															dbvalue=" ";

															%></td>
														    <td class="boldEleven"><input name="payslip" type="checkbox" id="payslip" value="Y"  <%=dbvalue%>  ></td>
														</tr>
														<tr>
															<td class="boldEleven">Reporting Head 
															  <%
									dbvalue=staffData[0][46];
									if ("Y".equals(dbvalue))
										dbvalue=" checked='checked' ";
									else
										dbvalue=" ";
									%>															</td>
														  <td width="22"><input
																name="reporinghead" type="checkbox" id="reporinghead" value="Y" <%=dbvalue%>></td>
															<td width="16" class="boldEleven">&nbsp;</td>
															<td width="129" class="boldEleven">Conveyance clear
                                                            <%
														dbvalue=staffData[0][49];
														if ("Y".equals(dbvalue))
															dbvalue=" checked='checked' ";
														else
															dbvalue=" ";

															%></td>
															<td width="66">
														  <input name="conveyance" type="checkbox" id="conveyance" value="Y"  <%=dbvalue%>  ></td>
														</tr>
														<tr>
															<td class="boldEleven"><span class="errormessage">Staff Holding <%
									dbvalue=staffData[0][47];
									if ("Y".equals(dbvalue))
										dbvalue=" checked='checked' ";
									else
										dbvalue=" ";
									%> </span></td>
															<td class="boldEleven"><input <%=dbvalue%> name="hold" type="checkbox"
																id="hold" value="Y"></td>
															<td class="errormessage">&nbsp;</td>
															<td class="errormessage">Salary Calculation
                                                            <%
														dbvalue=staffData[0][50];
														if ("Y".equals(dbvalue))
															dbvalue=" checked='checked' ";
														else
															dbvalue=" ";

															%></td>
															<td class="boldEleven"><input name="salarycalculation" type="checkbox" id="salarycalculation" value="Y" <%=dbvalue%>  ></td>
														</tr>
														<tr>
														  <td class="boldEleven"></td>
														  <td class="boldEleven">&nbsp;</td>
														  <td colspan="2" class="errormessage">&nbsp;</td>
														  <td class="boldEleven">&nbsp;</td>
													  </tr>
														<tr>
														  <td class="boldEleven">														 														  </td>
														  <td class="boldEleven">
														  
														   
														  <input   name="rejoin"  type="hidden"
																id="rejoin" value="<%=staffData[0][75]%>"  ></td>
														  <td colspan="2" class="errormessage">&nbsp;</td>
														  <td class="boldEleven">&nbsp;</td>
													  </tr>
													</table>
													</td>
												</tr>
											</table>
                                            
                                         
											</td>
										</tr>
									</table>
                                    
                                    
                                    
                                   </fieldset> 
                                    
									</td>
								</tr>
								<tr>
									<td height="19" colspan="2">&nbsp;</td>
								</tr>
								<tr>
									<td height="19" colspan="2">
									
									
									
									 <fieldset>
									<legend><strong><img src="../images/icon-misuse.gif">  Contact Informations</strong> </legend>
			 						<br>	
									
									
									
									
									 
											<table width="100%" border="0" align="center" cellpadding="2"
												cellspacing="2">
												<tr>
													<td height="23" colspan="2"><div align="center"><span class="boldEleven">Copy
													  Permanent to Communication Address
												    <input onClick="return resoffval()" type="radio" value="yes" name="res">
												    Yes
												    <input name="res" type="radio" onClick="return resoffval()" value="no">
											      No </span></div></td>
												</tr>
												<tr>
													<td width="50%" height="210">
													<table width="100%" border="0" align="center"
														cellpadding="1" cellspacing="2">
														<tr>
															<td height="15"  colspan="2" class="boldEleven" >
															<div align="center" class="bold1"> Permanent
														  Address</div>															</td>
														</tr>
														<tr>
															<td class="boldEleven">&nbsp;</td>
															<td width="161" class="boldEleven">&nbsp;</td>
														</tr>
														<tr>
															<td width="97" class="boldEleven">Address1<font class="errormessage"
																align="absmiddle"> *</font> 
														      <%
									dbvalue=staffData[0][22];
									if (dbvalue.equalsIgnoreCase("null") ||dbvalue.equalsIgnoreCase(""))
										dbvalue="";
									%>															</td>
															<td class="boldEleven"><input name="padd1"
																type="text" class="formText135" id="padd1"
																  value="<%=dbvalue%>"
																size="30" maxlength="50"   onBlur="upperMe(this)"    /></td>
														</tr>
														<tr>
															<td class="boldEleven">Address2 <font class="errormessage"
																align="absmiddle">*</font> 
														      <%
									dbvalue=staffData[0][23];
									if (dbvalue.equalsIgnoreCase("null") ||dbvalue.equalsIgnoreCase(""))
										dbvalue="";
									%>															</td>
															<td class="boldEleven"><input name="padd2"
																type="text" class="formText135" id="padd2"
																 value="<%=dbvalue%>"
																size="30" maxlength="50"    onBlur="upperMe(this)"   /></td>
														</tr>
														 
														<tr>
                                                          <td class="boldEleven">City
                                                             <font class="errormessage"
																align="absmiddle">*</font></td>
														  <td class="boldEleven">
<select name="pcity" class="formText135" id="pcity" style="width:170" onChange="PAssignPincode('ppincode')">
  <option value="0" selected="selected">Select City</option>
<%


String cityData[][] =  CommonFunctions.QueryExecute("SELECT INT_CITYID,CHR_CITYNAME FROM com_m_city WHERE INT_DISTRICTID=" +staffData[0][65]);
if(cityData.length>0)
for(int u=0;u<cityData.length;u++)
	out.print("<option value='"+cityData[u][0]+"'>"+cityData[u][1]+"</option>");

%>
</select>
						  <script language="javascript">setOptionValue('pcity','<%=staffData[0][24]%>')</script>  
															
															
                                                          </td>
													  </tr>
														<tr>
                                                          <td class="boldEleven">District <font class="errormessage"
																align="absmiddle">*</font></td>
														  <td class="boldEleven"><select name="pdistrict" class="formText135" id="pdistrict" style="width:170" onChange=" PLoadSelectCity()">
                                                              <option value="0" selected="selected">Select District</option>
															  <%
String	districtData[][]= CommonFunctions.QueryExecute("SELECT INT_DISTRICTID,CHR_DISTRICT  FROM com_m_district WHERE  INT_STATEID="+staffData[0][25]+"  ORDER BY CHR_DISTRICT  ");
if(districtData.length>0)
	for(int u=0;u<districtData.length;u++)
		out.println("<option value='"+districtData[u][0]+"'>"+districtData[u][1]+"</option>");
															  %>
                                                            </select>
<script language="javascript">setOptionValue('pdistrict','<%=staffData[0][65]%>')</script> 														
															
                                                          </td>
													  </tr>
														<tr>
                                                          <td class="boldEleven">State                                                          <font class="errormessage"
																align="absmiddle">*</font></td>
														  <td class="boldEleven"> <select name="pstate" class="formText135" id="pstate" style="width:170" onChange="PLoadSelectDistrict()">
                                                                    <option value="0" selected="selected">Select State</option>
																	<%
String	stateData[][]= CommonFunctions.QueryExecute("SELECT INT_STATEID,CHR_STATENAME FROM com_m_state WHERE INT_COUNTRYID ="+staffData[0][66]+" ORDER BY CHR_STATENAME");
if(stateData.length>0)
	for(int u=0;u<stateData.length;u++)
		out.println("<option value='"+stateData[u][0]+"'>"+stateData[u][1]+"</option>");
																	%>
                                                                </select>
																<script language="javascript">setOptionValue('pstate','<%=staffData[0][25]%>')</script> 
														  </td>
													  </tr>
														<tr>
                                                          <td class="boldEleven">Country<font class="errormessage"
																align="absmiddle"> *</font></td>
														  <td class="boldEleven"><select name="pcountry" class="formText135" id="pcountry" style="width:170" onChange="PLoadSelectState()">
                                                              <option value="0">Select Country</option>
                                                              <%
	 		String creadData[][]=  CommonFunctions.QueryExecute("SELECT INT_COUNTRYID ,CHR_COUNTRYNAME FROM  com_m_country ORDER BY CHR_COUNTRYNAME");
			if(creadData.length>0)
				for(int i=0;i<creadData.length;i++)
					out.println("<option value='"+creadData[i][0]+"'>"+creadData[i][1]+"</option>");
	 %>
                                                            </select>
 <script language="javascript">setOptionValue('pcountry','<%=staffData[0][66]%>')</script>                                                          </td>
													  </tr>
														<tr>
															<td class="boldEleven">Pin Code<font class="errormessage"
																align="absmiddle"> *</font> 
														      <%
									dbvalue=staffData[0][26];
									if (dbvalue.equalsIgnoreCase("null") ||dbvalue.equalsIgnoreCase(""))
										dbvalue="";
									%>															</td>
															<td class="boldEleven">
															
 

<input name="ppincode" type="text" class="formText135" id="ppincode" onKeyPress="return numeric_only(event,'ppincode','8')" size="30"  maxlength="7"    onKeyUp="lookup(this.value);"  tabindex="34" value="<%=dbvalue%>" />
	<br />
		<div class="suggestionsBox" id="suggestions" style="display: none;width:150%;">
					<div class="suggestionList" id="autoSuggestionsList" style="OVERFLOW:auto;width:100%;height:200px" ></div>
		</div>														 
											
														  </td>
														</tr>
														<tr>
															<td class="boldEleven">Phone No
														  <%
									dbvalue=staffData[0][32];
									if (dbvalue.equalsIgnoreCase("null") ||dbvalue.equalsIgnoreCase(""))
										dbvalue="";
									%>															</td>
															<td class="boldEleven">
															
															<input name="pphone"
																type="text" class="formText135" id="pphone" value="<%=dbvalue%>" 
																onKeyPress="return numeric_only(event,'pphone','11')" size="30"
																maxlength="10" />	
																
													  </tr>
													</table>
												  </td>
													<td width="50%">
													<table width="100%" border="0" align="center"
														cellpadding="1" cellspacing="2">
														<tr>
															<td colspan="2" class="bold1">
															<div align="center">Communication
														  Address</div>															</td>
														</tr>
														<tr>
															<td class="boldEleven">&nbsp;</td>
															<td width="166" class="boldEleven">&nbsp;</td>
														</tr>
														<tr>
															<td width="101" class="boldEleven">Address1<font class="errormessage"
																align="absmiddle"> *</font> 
														      <%
									dbvalue=staffData[0][27];
									if (dbvalue.equalsIgnoreCase("null") ||dbvalue.equalsIgnoreCase(""))
										dbvalue="";
									%>															</td>
															<td class="boldEleven"><input name="cadd1"
																type="text" class="formText135" id="cadd1"
																 value="<%=dbvalue%>"
																size="30" maxlength="50"    onBlur="upperMe(this)"   /></td>
														</tr>
														<tr>
															<td class="boldEleven">Address2 <font class="errormessage"
																align="absmiddle">*</font>
														  <%
									dbvalue=staffData[0][28];
									if (dbvalue.equalsIgnoreCase("null") ||dbvalue.equalsIgnoreCase(""))
										dbvalue="";
									%>															</td>
															<td class="boldEleven"><input name="cadd2"
																type="text" class="formText135" id="cadd2"
																 value="<%=dbvalue%>"
																size="30" maxlength="50"    onBlur="upperMe(this)"    /></td>
														</tr>
														 
														<tr>
                                                          <td class="boldEleven">City
                                                          <font class="errormessage"
																align="absmiddle">*</font></td>
														  <td class="boldEleven">
<select name="ccity" class="formText135" id="ccity" style="width:170" onChange="CAssignPincode('cpincode')">
  <option value="0" selected="selected">Select City</option>
  <%


String cityData1[][] =  CommonFunctions.QueryExecute("SELECT INT_CITYID,CHR_CITYNAME FROM com_m_city WHERE INT_DISTRICTID=" +staffData[0][67]);
if(cityData1.length>0)
	for(int u=0;u<cityData1.length;u++)
		out.print("<option value='"+cityData1[u][0]+"'>"+cityData1[u][1]+"</option>");

%>
</select>
						  <script language="javascript">setOptionValue('ccity','<%=staffData[0][29]%>')</script>  
 
                                                          </td>
													  </tr>
														<tr>
                                                          <td class="boldEleven">District <font class="errormessage"
																align="absmiddle">*</font></td>
														  <td class="boldEleven">
														  
<select name="cdistrict" class="formText135" id="cdistrict" style="width:170" onChange=" CLoadSelectCity()">
  <option value="0" selected="selected">Select District</option>
<%
String	districtData1[][]= CommonFunctions.QueryExecute("SELECT INT_DISTRICTID,CHR_DISTRICT  FROM com_m_district WHERE  INT_STATEID="+staffData[0][30]+"  ORDER BY CHR_DISTRICT  ");
if(districtData1.length>0)
	for(int u=0;u<districtData1.length;u++)
		out.println("<option value='"+districtData1[u][0]+"'>"+districtData1[u][1]+"</option>");
															  %>
                                                            </select>
<script language="javascript">setOptionValue('cdistrict','<%=staffData[0][67]%>')</script> 	
															
															
                                                          </td>
													  </tr>
														<tr>
                                                          <td class="boldEleven">State  <font class="errormessage"
																align="absmiddle">*</font></td>
														  <td class="boldEleven"> 
																
		<select name="cstate" class="formText135" id="cstate" style="width:170" onChange="CLoadSelectDistrict()">
			<option value="0" selected="selected">Select State</option>
		<%
String	stateData1[][]= CommonFunctions.QueryExecute("SELECT INT_STATEID,CHR_STATENAME FROM com_m_state WHERE INT_COUNTRYID ="+staffData[0][68]+" ORDER BY CHR_STATENAME");
if(stateData1.length>0)
	for(int u=0;u<stateData1.length;u++)
		out.println("<option value='"+stateData1[u][0]+"'>"+stateData1[u][1]+"</option>");
																	%>
                                                            </select>
 <script language="javascript">setOptionValue('cstate','<%=staffData[0][30]%>')</script>
																 
		
														  </td>
													  </tr>
														<tr>
                                                          <td class="boldEleven">Country <font class="errormessage"
																align="absmiddle">*</font></td>
														  <td class="boldEleven"><select name="ccountry" class="formText135" id="ccountry" style="width:170" onChange="CLoadSelectState()">
                                                              <option value="0">Select Country</option>
                                                             <%
			if(creadData.length>0) 												 	
	 			for(int i=0;i<creadData.length;i++)
					out.println("<option value='"+creadData[i][0]+"'>"+creadData[i][1]+"</option>");
	 %>
                                                            </select>
 <script language="javascript">setOptionValue('ccountry','<%=staffData[0][68]%>')</script>                                                          </td>
													  </tr>
														<tr>
															<td class="boldEleven">Pin Code<font class="errormessage"
																align="absmiddle"> *</font> 
														      <%
									dbvalue=staffData[0][31];
									if (dbvalue.equalsIgnoreCase("null") ||dbvalue.equalsIgnoreCase(""))
										dbvalue="";
									%>															</td>
															<td class="boldEleven">
																
																
<input name="cpincode" type="text" class="formText135" id="cpincode" value="<%=dbvalue%>"  onKeyPress="return numeric_only(event,'cpincode','8')" size="30" maxlength="7"  onKeyUp="clookup(this.value);"  tabindex="43"/>

  <div class="suggestionsBox1" id="suggestions1" style="display: none;width:150%;">
					<div class="suggestionList1" id="autoSuggestionsList1" style="OVERFLOW:auto;width:100%;height:200px" ></div>
</div>				

														  </td>
														</tr>
														<tr>
															<td class="boldEleven">Phone No
														  <%
									dbvalue=staffData[0][33];
									if (dbvalue.equalsIgnoreCase("null") ||dbvalue.equalsIgnoreCase(""))
										dbvalue="";
									%>															</td>
															<td class="boldEleven"><input name="cphone"
																type="text" class="formText135" id="cphone"
																onKeyPress="return numeric_only(event,'cphone','11')"
																value="<%=dbvalue%>" size="30" maxlength="10" /></td>
														</tr>
													</table>
												  </td>
												</tr>
											</table>
											 
									
									</fieldset>
									
									
									
									
									
									
									
									
									
									</td>
								</tr>
								<tr>
									<td width="49%" height="19">&nbsp;</td>
									<td width="51%">&nbsp;</td>
								</tr>
								<tr>
									<td height="19" colspan="2">
                                    
                                    <fieldset>
			<legend ><strong><img src="../images/icon-misuse.gif">&nbsp;&nbsp;PF & ESI Informations&nbsp;&nbsp;</strong> </legend>

									<table width="100%"   align="center" cellpadding="0"
										cellspacing="0" >
										<tr>
											<td height="185">
											<table width="100%" border="0" align="center" cellpadding="2"
												cellspacing="2">
												<tr>
													<td width="49%" height="167" colspan="2">
													<table width="100%" border="0" align="center"
														cellpadding="1" cellspacing="2">
														<tr>
															<td colspan="2" class="boldEleven">
															<div align="center"><span class="tabledata"><strong>PF</strong></span></div>															</td>
														</tr>



														<tr>
															<input type="hidden" name="hidpf" id="hidpf"
																value="<%=staffData[0][13]%>">
															<td width="101" class="boldEleven">PF  												<font class="errormessage"
																align="absmiddle">*</font></td>
															<td width="156" class="errormessage">
<%
	if("Y".equals(staffData[0][15]))
		out.println("Yes");
	else if("N".equals(staffData[0][15]))
		out.println("No");
	else if("C".equals(staffData[0][15]))
		out.println("Common");
	else
		out.println("-");	
		
	
%>
<input name="pf" id="pf" type="hidden" value="<%=staffData[0][15]%>">															</td>
														</tr>
														<tr id="pf0">
															<td class="boldEleven">PF TYPE  			</td>
															<td class="errormessage">
															
<%
	if("A".equals(staffData[0][36]))
		out.println("Amount");
	else if("P".equals(staffData[0][36]))
		out.println("Percentage");
	else
		out.println("-");	
		
	
%>
<input name="optpf" id="optpf" type="hidden" value="<%=staffData[0][36]%>"> 													</td>
														</tr>
														<tr id="pf1">
															<td class="boldEleven">PF Number <%
									dbvalue=staffData[0][38];
									if (dbvalue.equalsIgnoreCase("null") ||dbvalue.equalsIgnoreCase(""))
										dbvalue="";
									%>															</td>
															<td class="errormessage">
															
							 
							
<input name="txtpfno" id="txtpfno" type="hidden" value="<%=dbvalue%>"><%=dbvalue%>														  </td>
														</tr>
														

														
														<tr id='pf2'>
															<td class='boldEleven'>PF Amount <%
									dbvalue=staffData[0][37];
									if (dbvalue.equalsIgnoreCase("null") ||dbvalue.equalsIgnoreCase("0.00"))
										dbvalue="";
									%>															</td>
															<td class='errormessage'>
															
<input name="txtpfvalue" id="txtpfvalue" type="hidden" value="<%=dbvalue%>"><%=dbvalue%> </td>
														</tr>
														<tr>
														  <td class="boldEleven">PF Nominee </td>
														  <td class="errormessage"> 
														  
<input name="nominee" id="nominee" type="hidden" value="<%=staffData[0][76] %>"><%=staffData[0][76] %>														  </td>
													  </tr>
														<tr>
														  <td class="boldEleven">Relationship</td>
														  <td class="errormessage">
 
<%
	if("F".equals(staffData[0][88]))
		out.println("Father");
	else if("M".equals(staffData[0][88]))
		out.println("Mother");
	else if("W".equals(staffData[0][88]))
		out.println("wife");
	else if("H".equals(staffData[0][88]))
		out.println("Husband");
	else if("G".equals(staffData[0][88]))
		out.println("Guardian");
	else if("S".equals(staffData[0][88]))
		out.println("Son");
	else if("D".equals(staffData[0][88]))
		out.println("Daugther");
	else
		out.println("-");	
%>
<input name="pfnomineerelationship" id="pfnomineerelationship" type="hidden" value="<%=staffData[0][88]%>">														  </td>
													  </tr>
														<tr>
															<td class="boldEleven">&nbsp;</td>
															<td class="errormessage">&nbsp;</td>
														</tr>
													</table>													</td>
													<td width="51%" colspan="2">
													<table width="100%" border="0" align="center"
														cellpadding="1" cellspacing="2">
														<tr>
															<td height="21" colspan="2" class="boldEleven">
															<div align="center"><span class="tabledata"><strong>
															ESI</strong></span></div>															</td>
														</tr>
														
														<tr>
															<td width="107" height="21" class="boldEleven">ESI <font class="errormessage"
																align="absmiddle">*</font></td>
															<td width="161" class="errormessage">

<%
	if("Y".equals(staffData[0][16]))
		out.println("Yes");
	else if("N".equals(staffData[0][16]))
		out.println("No");
	else if("C".equals(staffData[0][16]))
		out.println("Common");
	else
		out.println("-");	
%>
<input name="esi" id="esi" type="hidden" value="<%=staffData[0][16]%>">															</td>
														</tr>
														<tr id="ppf0">
															<td height="21" class="boldEleven">ESI TYPE  														</td>
															<td class="errormessage">

<%
	if("A".equals(staffData[0][39]))
		out.println("Amount");
	else if("P".equals(staffData[0][39]))
		out.println("Percentage");
	else
		out.println("-");	
		
	
%>
<input name="optesi" id="optesi" type="hidden" value="<%=staffData[0][39]%>"> </td>
														</tr>
														<tr id="ppf1">
															<td class="boldEleven">ESI Number  													</td>
															<td class="errormessage">
<input name="txtesno" id="txtesno" type="hidden" value="<%=staffData[0][41]%>"><%=staffData[0][41]%>																													</td>
														</tr>
														<tr id="ppf2">
															<td class="boldEleven">ESI Amount 
															  <%
									dbvalue=staffData[0][40];
									if (dbvalue.equalsIgnoreCase("null") ||dbvalue.equalsIgnoreCase("0.00"))
										dbvalue="";
									%>															</td>
															<td class="errormessage">
															
<input name="txtesivalue" id="txtesivalue" type="hidden" value="<%=dbvalue%>"><%=dbvalue%>															 </td>
														</tr>
														<tr>
														  <td class="boldEleven">Dispensary</td>
														  <td class="errormessage">
														  
														  
														  
														  
														 
																<%
		   String Disdata[][] =CommonFunctions.QueryExecute("Select INT_DESPID,CHR_DESPNAME From com_m_dispensary WHERE INT_DESPID = "+staffData[0][48]+ " order by INT_DESPID ");
		    if(Disdata.length>0)
				out.println( Disdata[0][1]);
			
		   %>
			   
<input name="dispensary" id="dispensary" type="hidden" value="<%=staffData[0][48]%>">									</td>
													  </tr>
														<tr>
														  <td class="boldEleven">&nbsp;</td>
														  <td class="errormessage">&nbsp;</td>
													  </tr>
														<tr>
														  <td class="boldEleven">&nbsp;</td>
														  <td class="errormessage">&nbsp;</td>
													  </tr>
													</table>													</td>
												</tr>
												
												<tr>
												  <td colspan="2" class="boldEleven">&nbsp;</td>
												  <td colspan="2" class="boldEleven">&nbsp;</td>
											  </tr>
												<tr>
												  <td class="boldEleven">Date of Reivision<font
																class="errormessage" align="absmiddle"> *</font> </td>
												  <td class="boldEleven"><input title="dd/mm/yyyy"  name="revisiondate" id="revisiondate" type="text" class="formText135" size="15" maxlength="10" value="<%=staffData[0][80]%>" readonly  /></td>
												  <td class="boldEleven">Date of PF &amp; ESI Registration </td>
												  <td class="boldEleven"><input title="dd/mm/yyyy" readonly  name="pfesidate" id="pfesidate" type="text" class="formText135" size="15" maxlength="10" value="<%=staffData[0][54]%>" /></td>
											  </tr>
												<tr>
												  <td class="boldEleven">Date of Resign </td>
												  <td class="boldEleven"><input title="dd/mm/yyyy" readonly   name="resigndate" id="resigndate" type="text" class="formText135" size="15" maxlength="10" value="<%=staffData[0][55]%>"  /></td>
												  <td class="boldEleven">&nbsp;</td>
											      <td class="boldEleven">&nbsp;</td>
											  </tr>
												<tr>
												  <td colspan="2" class="boldEleven">&nbsp;</td>
												  <td colspan="2" class="boldEleven">&nbsp;</td>
											  </tr>
												<tr>
												  <td colspan="2" class="boldEleven"><table width="330" border="0" align="center">
                                                    <tr>
                                                      <td class="boldEleven">PAN Number</td>
                                                      <td class="boldEleven"><input name="pannumber" type="text" class="formText135" id="pannumber" onKeyUp=" LoadUniqueCheck('pannumber', 'pandiv', 'com_m_staff', 'CHR_PAN', 'submit_btn')" value="<%=("-".equals(staffData[0][56])? "" :staffData[0][56] ) %>" size="30" maxlength="20"   onBlur="upperMe(this)"   >
                                                          <div id="pandiv"></div></td>
                                                    </tr>
                                                    <tr>
                                                      <td class="boldEleven">PASS PORT Number </td>
                                                      <td class="boldEleven"><input name="passportnumber" type="text" class="formText135" id="passportnumber" onKeyUp=" LoadUniqueCheck('passportnumber', 'passportnumberdiv', 'com_m_staff', 'CHR_PASSPORT', 'submit_btn')" value="<%=("-".equals(staffData[0][57])? "" :staffData[0][57] ) %>" size="30" maxlength="20"    onBlur="upperMe(this)"   >
                                                          <div id="passportnumberdiv"></div></td>
                                                    </tr>
                                                    <tr>
                                                      <td class="boldEleven">DRIVING LICENSE Number </td>
                                                      <td class="boldEleven"><input name="drivingnumber" type="text" class="formText135" id="drivingnumber" onKeyUp=" LoadUniqueCheck('drivingnumber', 'drivingdiv', 'com_m_staff', 'CHR_DRIVING', 'submit_btn')" value="<%=staffData[0][58] %>" size="30" maxlength="20"    onBlur="upperMe(this)"   >
                                                          <div id="drivingdiv"></div></td>
                                                    </tr>
                                                    <tr>
                                                      <td class="boldEleven">AADHAR NO</td>
                                                      <td class="boldEleven"><input name="aadharnumber" type="text" class="formText135" id="aadharnumber"  tabindex="60"   onBlur="upperMe(this)" onKeyUp="upperMe(this), LoadUniqueCheck('aadharnumber', 'aadhardiv', 'com_m_staff', 'CHR_AADHARNO ', 'Submit')" value="<%=("-".equals(staffData[0][91])? "" :staffData[0][91] ) %>" size="30" maxlength="20"   /></td>
                                                    </tr>
                                                  </table></td>
												  <td colspan="2" class="boldEleven"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                      <td class="boldEleven">Previous Details </td>
                                                      <td rowspan="3" align="left" valign="top">
													  <textarea name="previousdetails" cols="30" rows="5" onKeyUp="textArea('previousdetails','2000')" class="formText135" id="previousdetails"    onBlur="upperMe(this)"   ><%=staffData[0][60] %></textarea></td>
                                                    </tr>
                                                    <tr>
                                                      <td class="boldEleven">&nbsp;</td>
                                                    </tr>
                                                    <tr>
                                                      <td class="boldEleven">&nbsp;</td>
                                                    </tr>
                                                  </table></td>
											  </tr>
												<tr>
												  <td colspan="4">												 </td>
												</tr>
												<tr>
												  <td colspan="2" class="boldEleven">&nbsp;</td>
												  <td colspan="2" class="boldEleven">&nbsp;</td>
											  </tr>
											</table>
											</td>
										</tr>
										
										
										
									</table>
                                    
                               </fieldset>     
                                    
                                    
                                    
									</td>
								</tr>
								<tr>
									<td height="19">&nbsp;</td>
									<td class="boldEleven"><input name="filename" type="hidden" id="filename"
										value="StaffRegistration"> <input name="actionS"
										type="hidden" id="actionS"
										value="GENStaffRegistrationUpdate"></td>
								</tr>
								<tr>
									<td height="19" colspan="2">
									<table border="0" align="center" cellpadding="2"
										cellspacing="2">
										<tr>
										  <td width="56"><input type="button" name="submit"
												class="buttonbold"  value="Close"   accesskey="c" 
												onClick="javascript:history.back()" /></td>
										</tr>
									</table>
									</td>
								</tr>
							</table>
							</TD>
							<TD noWrap width=6><SPACER height="1" width="1" type="block" /></TD>
							<TD class=BorderLine width=1><SPACER height="1" width="1"
								type="block" /></TD>
						</TR>
						<TR>
							<TD colSpan=2 rowSpan=2><IMG height=7
								src="../Image/General/BLCorner.gif" width=7></TD>
							<TD height=6><SPACER height="1" width="1" type="block" /></TD>
							<TD colSpan=2 rowSpan=2 valign="bottom">
							<div align="right"><IMG height=7
								src="../Image/General/BRCorner.gif" width=7></div>
							</TD>
						</TR>
						<TR>
							<TD class=BorderLine height=1><SPACER height="1" width="1"
								type="block" /></TD>
						</TR>
					</TBODY>
				</TABLE>
				</td>
			  <td width="27%" valign="top">
				<table width="113" border="0" align="center" cellpadding="1"
					cellspacing="3" bordercolor="#D4D0C8" class="boldEleven">
					<tr>
						<td class="boldEleven">&nbsp;</td>
					</tr>
					<tr>
						<td class="boldEleven">&nbsp;</td>
					</tr>
					<tr>
						<td class="boldEleven">
						<%
			String staffphoto = request.getRealPath("/")+"StaffPhoto/"+staffid.trim() +".jpg";
			String defaul = "../StaffPhoto/default.jpg" ;
			String photo="";
			File f = new File(staffphoto);	 
			%>						</td>
					</tr>
					<tr>
						<td width="105">
						<div align="center" class="copyright"><strong>Staff
						Photo </strong></div>						</td>
					</tr>
					<tr>
						<td rowspan="5"> </td>
					</tr>
					<tr>					</tr>
					<tr>					</tr>
					<tr>					</tr>
					<tr>					</tr>
					<tr>
						<td class="boldEleven">
					  </td>
					</tr>
					<tr>
					  <td class="boldEleven">
					    <div align="center">
					      <%
String staffPhotoData[][] = CommonFunctions.QueryExecute("SELECT IMG_IMAGE FROM com_m_staffaddressproof WHERE CHR_EMPID='"+staffid.trim()+"'");
 
						 if(staffPhotoData.length>0)
						 {
							if(!"-".equals(staffPhotoData[0][0].trim()))
							{
						  %>
					      
					      
					            <!--<a title="Double click for download the image" href="StaffImage.jsp?imgid=<%=staffid%>"><img src="StaffImage.jsp?imgid=<%=staffid%>" width="120" height="150" border="0"></a>-->
					      
					       <iframe src="../DisplayImages?myid=<%=staffid.trim()%>"	name="staffMain" width="120" height="150" frameborder="0"  > </iframe>  
				        </div>
					    <div align="center">
						      <%
						  	}
						}	
						else
						{
									if (f.exists())
										photo ="../StaffPhoto/"+staffid.trim() +".jpg";
									else
										photo =defaul;
				
							%>
						        <img src="<%=photo%>" title="<%=photo%>" width="auto" height="auto" border="1" name="Photo" id="Photo" />
						        <%	
						}
						  %>
			          </div></td>
				  </tr>
					<tr>
					  <td class="boldEleven">
					   
							
					  </td>
				  </tr>
				</table>
				<table width="100%" border="0" align="center" cellpadding="1"
					cellspacing="3" bordercolor="#D4D0C8" class="boldEleven">
                  <tr>
                    <td width="105">				    </td>
                  </tr>
                  <tr>
                    <td class="boldEleven"> </td>
                  </tr>
                  <tr>
                    <td class="boldEleven">&nbsp; </td>
                  </tr>
                  <tr>
                    <td rowspan="5">&nbsp;</td>
                  </tr>
                  <tr> </tr>
                  <tr> </tr>
                  <tr> </tr>
                  <tr> </tr>
                  <tr>
                    <td width="100%">
					 					</td>
                  </tr>
                  <tr>
                    <td class="boldEleven">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="boldEleven">&nbsp; </td>
                  </tr>
                  <tr>
                    <td class="boldEleven">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="boldEleven">&nbsp;
					 
					  </td>
                  </tr>
                  <tr>
                    <td class="boldEleven"></td>
                  </tr>
                  <tr>
                    <td class="boldEleven">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="boldEleven">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="boldEleven">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="boldEleven">&nbsp;
					</td>
                  </tr>
                  <tr>
                    <td class="boldEleven">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="boldEleven">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="boldEleven">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="boldEleven">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="boldEleven" align="center">&nbsp;
					</td>
                  </tr>
                  <tr>
                    <td class="boldEleven" align="center">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="boldEleven" align="center">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="boldEleven" align="center">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="boldEleven" align="center">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="boldEleven" align="center">&nbsp; </td>
                  </tr>
                  <tr>
                    <td class="boldEleven" align="center">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="boldEleven" align="center">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="boldEleven" align="center">&nbsp;</td>
                  </tr>
                 <tr>
                    <td class="boldEleven" align="center">&nbsp; </td>
                  </tr> 
                  <tr>
                    <td class="boldEleven" align="center">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="boldEleven" align="center">&nbsp;
					
					
					  </td>
                  </tr>
                  <tr>
                    <td class="boldEleven" align="center">&nbsp;</td>
                  </tr>
              </table></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="boldEleven">&nbsp;</td>
	</tr>
	<tr>
		<td class="boldEleven">&nbsp;</td>
	</tr>
	<tr>
		<td class="boldEleven"><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
</form>
</body>

</html>



<script language="javascript">
 
   
	
var mm ="<%=staffData[0][18]%>";
if(mm == "M")
	changeState1();
else
	changeState();


 	function mainPage()
	{
	    document.a.action="AttendanceMain.jsp";
		document.a.submit();
		return true;
    } 
	
	function PhotoUpload(staffid)
	{
		var s =document.a.id.value;
		if (s=="")
		{
			alert ("Please enter Staffid....");
			document.a.id.focus();
			return false;
		}
		else
		{
			var f ="StaffPhotoUpload.jsp?staffid="+document.a.id.value;
			newWindow = window.open(f,"subWind",",,height=300,width=450,top=0,left=0");
			newWindow.focus( );
			return false;
		}
		//return true 	
	}	
	
	
	
	function ProfileUpload(staffid)
	{
		var s =document.a.id.value;
		if (s=="")
		{
			alert ("Please enter Staffid....");
			document.a.id.focus();
			return false;
		}
		else
		{
			var f ="StaffProfileUpload.jsp?staffid="+document.a.id.value;
			newWindow = window.open(f,"subWind",",,height=300,width=450,top=0,left=0");
			newWindow.focus( );
			return false;
		}
		 	
	}
	
	
	
	
	function AddressProofUpload(staffid)
	{
		 
		var s =document.a.id.value;
		if (s=="")
		{
			alert ("Please enter Staffid....");
			document.a.id.focus();
			return false;
		}
		else
		{
			var f ="StaffAddressProofUpload.jsp?staffid="+document.a.id.value;
			newWindow = window.open(f,"subWind",",,height=300,width=450,top=0,left=0");
			newWindow.focus( );
			return false;
		}
		//return true ;	
	}




	function fullFileUpload(staffid)
	{
		 
		var s =document.a.id.value;
		if (s=="")
		{
			alert ("Please enter Staffid....");
			document.a.id.focus();
			return false;
		}
		else
		{
			var f ="StafffullFileUpload.jsp?staffid="+document.a.id.value;
			newWindow = window.open(f,"subWind",",,height=300,width=450,top=0,left=0");
			newWindow.focus( );
			return false;
		}
		
	}


	function certificateUpload(staffid)
	{
		 
		var s =document.a.id.value;
		if (s=="")
		{
			alert ("Please enter Staffid....");
			document.a.id.focus();
			return false;
		}
		else
		{
			var f ="certificateUpload.jsp?staffid="+document.a.id.value;
			newWindow = window.open(f,"subWind",",,height=300,width=450,top=0,left=0");
			newWindow.focus( );
			return false;
		}
		 
	}






	function ViewAddressProof(staffid)
	{
		var s =document.a.id.value;
		if (s=="")
		{
			alert ("Please enter Staffid....");
			document.a.id.focus();
			return false;
		}
		else
		{
			var f ="StaffAddressProofView.jsp?staffid="+document.a.id.value;
			newWindow = window.open(f,"subWind",",,height="+(screen.height-200)+",width="+(screen.width-200)+",scrollbars=yes,top=50,left=50");
			newWindow.focus( );
			return false;
		}
		 	
	}


  pfchange();
  ESIchange()










function dobcheck(ctr, msg)
{
	try
	{
		var val=document.getElementById(ctr).value;
		if(val=="")
		{
		   alert(msg);	
		   document.getElementById(ctr).focus();
		   return false;
		}
		else
		{
			var d1 = val.split("-");
			if ((d1[0]>31)|| (d1[1]>12) ||  (d1[1]==2 && d1[0]>29))
			{
				alert(msg);
				document.getElementById(ctr).focus();
				return false;
			}
			else
			   return false;
		}  
	   
		

		
		
	}
	catch(err)
	{
		alert(err);
		return false;
	}
	 
		
	 
	
	
	
	
			
}



 function checkWedding(ctr)
 {
 	try
	{
		var v =document.getElementById(ctr).value;
		if( v == "M")
		{
			if(checkNull('wedding','Enter the wedding date'))
				return true;
			else
				return false;	
		}
		else
		{
			document.getElementById('wedding').value="";
			return true;
		}
		
		 
	}
	catch(err)
	{
		alert(ctr+" -  not found.     error : "+err);
		return false;
	}
 }
 
 

function checkSpouseName()
 {
 	try
	{
		 var mtype = document.getElementById('mtype').value;
		 if(mtype =="M")
		 {
		 	if(checkNull('spousename','Enter Spouse Name') )
				return true;
			else
				return false;	
		 }
		 else
		 {
		 	document.getElementById('spousename').value="";
			return true;
		 }
 	}
	catch(err)
	{
		alert(err);
		return false;
	}
 } 
 
 


function validateFields()
{
	try
	{

		 
			 if(
				 checkNull('id','Enter Staff ID') 
				 && checkNull('name','Enter the name') 
				 && checkNull('fname','Enter the fname') 
				 && checkNull('mothername','Enter Mother Name') 
				 && checkNullSelect('bg','Select Blood Group','0')
				 && checkNull('dob','Enter Date of Birth')
				 && checkNull('doj','Enter Date of Joining')
				 && checkWedding('mtype')
				 && checkSpouseName()
				 && checkNull('basic','Enter the basic')
				 && checkNull('gross','Enter the gross') 
				 
				 && chkemail1("emailid",'Entert the correct Office E-mail Address...')
				 && checkNull('peremailid','Entert the correct E-mail Address...')
				 && chkemail1("peremailid",'Entert the correct E-mail Address...')
				 	
				 && basic_Gross_check()
				 && checkNullSelect('qualification','Select qualification','0')
				  
				 && checkNullSelect('bank','Select Bank','0')
				 && checkNullSelect('attendancecycle','Select Attendance Cycle','0')
				 && checkNullSelect('salarytype','Select Salary Type','0')
				 
				 
				 
				 && checkNull('padd1','Enter Permanent  Address1')
				 && checkNull('padd2','Enter Permanent  Address2')
				 && checkNullSelect('pcountry','Select  Permanent  Country  Name','0')
				 && checkNullSelect('pstate','Select  Permanent  State  Name','0')
				 && checkNullSelect('pdistrict','Select  Permanent  District  Name','0')
				 && checkNullSelect('pcity','Select Permanent  City Name','0')
				 && checkNull('ppincode','Enter Permanent Pincode ')
				 
				 && checkNull('cadd1','Enter Communication  Address1')
				 && checkNull('cadd2','Enter Communication  Address2')
				 && checkNullSelect('ccountry','Select  Communication  Country  Name','0')
				 && checkNullSelect('cstate','Select  Communication  State  Name','0')
				 && checkNullSelect('cdistrict','Select  Communication  District  Name','0')
				 && checkNullSelect('ccity','Select Communication  City Name','0')
				 && checkNull('cpincode','Enter Communication Pincode ')
				 && checkNull('revisiondate','Enter revision date')
				 && checkNullSelect('pf','SELECT PF ','0')
				 && checkNullSelect('esi','SELECT esi','0')
			 
			 
				 )
				
				 {
				 	var rs=confirm("Are you sure update the Staff Registration......");
					if (rs==true)
				   		return true;
				}  
			 else
				   return false;	 
				   
				   
	}
	catch(err)
	{
		alert(err)
		return false;
	}
	    
}	
   
   
  
 

function basic_Gross_check()
{
	try
	{
		var a = parseFloat(document.getElementById('basic').value);
		var b = parseFloat(document.getElementById('gross').value);
		
		if(b<1)
		{
			alert("please check the Gross ");
			document.getElementById('gross').focus();
			return false;
		}
		if(a>40000)
		{
			alert("please check Basic, It is high Amount......")
			document.getElementById('gross').focus();
			return false;
		}
		if(a>b)
		{
			alert("Kindly check the Basic and Gross...");
			document.getElementById('gross').focus();
			return false;
		}
		else
			return true;
	 }
	 catch(err)
	 {
		alert(err);
	 }
		
}

 
  
   
   
</script>


<%
}
catch(Exception e)
{
	e.printStackTrace();
	//System.out.println(e);
}
%>
