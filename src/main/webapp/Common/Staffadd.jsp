
<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon"></jsp:useBean>
<%!
	Connection con ;
	PreparedStatement pstm;
	ResultSet rst;
	String userid;
%>
<script language="javascript">

 

</script>
<%
String staffid=""+request.getParameter("staffid");
String shortsql="SELECT CHR_SHORTNAME FROM com_m_company WHERE CHR_SHORTNAME is not null ORDER BY INT_COMPANYID";
String shortdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(shortsql);
String shortname="";
for(int u=0;u<shortdata.length;u++)
	shortname = shortname+shortdata[u][0]+",";

%>
<%@ page import="com.my.org.erp.common.CommonInfo"%>
<%@ include file="insert.jsp"%>
<html>
<head>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/AJAXFunctionStaff.js"></script>
<script language="JavaScript" src="../JavaScript/commonAJAX.js"></script>
<script language="JavaScript"
	src="../JavaScript/Attendance/AttendanceAjax.js"></script>
<script language="JavaScript" src="../JavaScript/AJAX.js"></script>
<script language="javascript"
	src="../JavaScript/common/PermanentSelectChangesCountry.js"></script>
<script language="javascript"
	src="../JavaScript/common/communicationSelectChangesCountry.js"></script>

<script language="javascript">
<!--
 
function validateDate()
{ 
	if(document.staffaddfrm.dob.value != "" && document.staffaddfrm.wedding.value != "")
	{
		var d1 = document.staffaddfrm.dob.value.split("-");
		var d2 = document.staffaddfrm.wedding.value.split("-");

		var diff = parseInt(d1[2])+parseInt(18);

		if(d2[2]>=diff)
		{
			return true;
		}
		else
		{
			alert("Wedding Age must be over 18 years...");
			document.staffaddfrm.dob.focus();
			return false;
		}	
	}	
}

function validateDateofjoin()
{ 
	if(document.staffaddfrm.dob.value != "" && document.staffaddfrm.doj.value != "")
	{
		var d1 = document.staffaddfrm.dob.value.split("-");
		var d2 = document.staffaddfrm.doj.value.split("-");

		var diff = parseInt(d1[2])+parseInt(15);
		
		if (d2[2]>=diff)
		{
				return true;
		}
		else
		{
			alert("Date of Joining must be above 15 years from Date of Birth...");
			document.staffaddfrm.dob.focus();
			return false;
		}
	}

}



function resoffval()
{
	if(document.staffaddfrm.res[0].checked==true)
	{
		document.staffaddfrm.cadd1.value = document.staffaddfrm.padd1.value;
		document.staffaddfrm.cadd2.value = document.staffaddfrm.padd2.value;
		copyDropdown('pcity','ccity');
		copyDropdown('pstate','cstate');
		copyDropdown('pdistrict','cdistrict');
		
		document.staffaddfrm.ccountry.selectedIndex = document.staffaddfrm.pcountry.selectedIndex;
		document.staffaddfrm.cstate.selectedIndex = document.staffaddfrm.pstate.selectedIndex+1;
		document.staffaddfrm.cdistrict.selectedIndex = document.staffaddfrm.pdistrict.selectedIndex+1;
		document.staffaddfrm.ccity.selectedIndex = document.staffaddfrm.pcity.selectedIndex+1;
		document.staffaddfrm.cpincode.value = document.staffaddfrm.ppincode.value;
		document.staffaddfrm.cphone.value = document.staffaddfrm.pphone.value;
	}         
	else 
	{
		document.staffaddfrm.cadd1.value = "";
		document.staffaddfrm.cadd2.value = "";
		document.staffaddfrm.ccity.selectedIndex = 0;
		document.staffaddfrm.cdistrict.selectedIndex = 0;
		document.staffaddfrm.cstate.selectedIndex = 0;
		document.staffaddfrm.ccountry.selectedIndex = 0;
		document.staffaddfrm.cpincode.value = "";
		document.staffaddfrm.cphone.value = "";
		
	}
	return true;
}//end of resoffval


function disable()
{
		pf0.style.visibility="hidden";
 		pf1.style.visibility="hidden";
		pf2.style.visibility="hidden";
		s1.style.visibility="hidden";
		s2.style.visibility="hidden";
}
function enable()
{
		pf0.style.visibility="Visible";
		pf1.style.visibility="Visible";
		pf2.style.visibility="Visible";
		s1.style.visibility="Visible";
		s2.style.visibility="Visible";
}
function cenable()
{
		pf0.style.visibility="Visible";
		pf1.style.visibility="Visible";
		pf2.style.visibility="hidden";
		s1.style.visibility="hidden";
		s2.style.visibility="hidden";
		
}


function disable1()
{
		ppf0.style.visibility="hidden";
 		ppf1.style.visibility="hidden";
		ppf2.style.visibility="hidden";
		ps1.style.visibility="hidden";
		ps2.style.visibility="hidden";
}
function enable1()
{
		ppf0.style.visibility="Visible";
		ppf1.style.visibility="Visible";
		ppf2.style.visibility="Visible";
		ps1.style.visibility="Visible";
		ps2.style.visibility="Visible";
}
function cenable1()
{
		ppf0.style.visibility="Visible";
		ppf1.style.visibility="Visible";
		ppf2.style.visibility="hidden";
		ps1.style.visibility="hidden";
		ps2.style.visibility="hidden";
		
}
	
function validateFields()
{
   var dval = document.staffaddfrm.dob.value;
	if (dval != "")
	{
		var d1 = document.staffaddfrm.dob.value.split("-");

		if ((d1[0]>31)|| (d1[1]>12) ||  (d1[1]==2 && d1[0]>29))
		{
			alert("Please Check the Date");
			document.staffaddfrm.dob.focus();
			return false;
		}
	}

	if(document.staffaddfrm.dob.value != "" && document.staffaddfrm.wedding.value != "")
	{

		var d1 = document.staffaddfrm.dob.value.split("-");
		var d2 = document.staffaddfrm.wedding.value.split("-");

		var diff = parseInt(d1[2])+parseInt(18);

		if(d2[2]<diff)
		{
			alert("Wedding Age must be over 18 years...");
			document.staffaddfrm.dob.focus();
			return false;
		}	
	}	
	
	if(dval != "" && document.staffaddfrm.doj.value != "")
	{
		var d1 = document.staffaddfrm.dob.value.split("-");
		var d2 = document.staffaddfrm.doj.value.split("-");

		var diff = parseInt(d1[2])+parseInt(15);
		
 
		
		if (d2[2]<diff)
		{
			alert("Date of Joining must be above 15 years from Date of Birth...");
			document.staffaddfrm.dob.focus();
			return false;
		}
	}
		
	
   	
   	if(
	 
	 
	 checkNull('name','Enter Staff Name')
     && checkNull('fname','Enter Father Name...')
	 && checkNullSelect('company','Select Company Name','0')
     && checkNull('branch','Enter Branch Name')
	 && checkNullSelect('branch','Select Branch Name','0')
	 && checkNullSelect('st1','Select State','0')
	 && checkNullSelect('dist','Select District','0')
   	 && checkNullSelect('off','Select Office Name','0')   	
   	 && checkNullSelect('depart','Select Department Name','0')
   	 && checkNullSelect('desig','Select Designation Name','0')
	 && checkNullSelect('type','Select Staff Type','0')
	 && checkNull('dob','Enter Date of Birth')
	 && checkNull('doj','Enter Date of Joining')
	 && checkNull('peremailid','Enter Personal Email')
	 && chkemail('emailid')
	 && chkemail('peremailid')
	 && checkNull('padd1','Enter Permanent  Address1')
	 && checkNull('padd2','Enter Permanent  Address2')
	 && checkNullSelect('pcity','Select Permanent  City Name','0')
	 && checkNullSelect('pdistrict','Select  Permanent  District  Name','0')
	 && checkNullSelect('pstate','Select  Permanent  State  Name','0')
	 && checkNullSelect('pcountry','Select  Permanent  Country  Name','0')
	 && checkNull('ppincode','Enter Permanent Pincode ')
	 && checkNull('cadd1','Enter Communication  Address1')
	 && checkNull('cadd2','Enter Communication  Address2')
	 && checkNullSelect('ccity','Select Communication  City Name','0')
	 && checkNullSelect('cdistrict','Select  Communication  District  Name','0')
	 && checkNullSelect('cstate','Select  Communication  State  Name','0')
	 && checkNullSelect('ccountry','Select  Communication  Country  Name','0')
	 && checkNull('cpincode','Enter Communication Pincode ')
	 && checkNullSelect('cdistrict','Select  Communication  District  Name','0')
	 && checkNullSelect('off','Select Office Name','0')   	
   	 && checkNullSelect('depart','Select Department Name','0')
   	 && checkNullSelect('desig','Select Designation Name','0')
	 && checkNullSelect('company','Select Company Name','0')
      && checkNull('branch','Enter Branch Name')
	 && checkNullSelect('qualification','Select qualification','0')
	 && checkNullSelect('bank','Select Bank','0')
	 && checkNullSelect('bg','Select Blood Group','0')
	 && checkNullSelect('Category','Select Category','0')
	 
	   
	 
	 
	 
	 //&& checkDecimal('basic', '12') 
	 && checkDecimal('gross', '12') 
	 && consolidateCheck()
	 
	 )
	   
   	 {
		return true;
   	 }
   	 else{
   	   	return false;	  
   	 }
    }	
	
	
	function consolidateCheck()
	{
		var f = true;
		if(checkSalaryType())
			f = checkSalaryBand();
		
		return f;	
	}
	
    function changeState1()
    {
       document.staffaddfrm.wedding.disabled=true;
	   cwd.style.visibility="visible";
	   /*var tb=document.getElementById('solutename');
  	   tb.innerHTML="Spouse Name"  ;*/ 
	   
	   
    } 
     function changeState()
    {
		document.staffaddfrm.wedding.value="";
        document.staffaddfrm.wedding.disabled=false;
        cwd.style.visibility="hidden";
		/*var tb=document.getElementById('solutename');
  	    tb.innerHTML="Father Name"  ;    */   		
    } 	
    function  passwordCheck()
	{	 	 
		var f1 = document.staffaddfrm.passWord.value;
		var f2 = document.staffaddfrm.retypePassword.value;
		if(f1 != f2)
		{
			alert("Password and Retypepassword are not equal..."); 
			document.staffaddfrm.passWord.value="";
			document.staffaddfrm.retypePassword.value="";
			document.staffaddfrm.passWord.focus();
		}	
	 }	
 	
function createRequestObject() 
{
    var tmpXmlHttpObject;
    if (window.XMLHttpRequest) 
    { 
        tmpXmlHttpObject = new XMLHttpRequest();
	  }
    else if (window.ActiveXObject) 
    { 
        tmpXmlHttpObject = new ActiveXObject("Microsoft.XMLHTTP");
    }
    return tmpXmlHttpObject;
}


var http = createRequestObject();
function makeGetRequest(wordId) 
{
	var f ='BranchInsert1.jsp?id=' + wordId.value;
	http.open('get', f);
    http.onreadystatechange = processResponse;
    http.send(null);
}

function processResponse() 
{
    if(http.readyState == 4){
        var response = http.responseText;
        document.getElementById('description').innerHTML = response;
    }
}



function checkDecimal(ctr,len)
{
	
	var dot=".";
	var txtval = document.getElementById(ctr).value;
  	
  	if (txtval=="")
  		return true;
  	else {
  		
	  	var keylen = txtval.length;
  		var dotlen= txtval.indexOf(dot);


		if(keylen<=len)	
		{
			if(dotlen==-1)
	  		{
	  			alert("Please follow the format : 00000.00");
	  			document.getElementById(ctr).select();
	  			return false;
	  		}
			else if(dotlen==0)
	  		{
	  			alert("Please follow the format : 00000.00");
	  			document.getElementById(ctr).select();
	  			return false;
	  		}
	  		else if ((dotlen!=-1)&&(((keylen-1)-dotlen)!=2))
			{
	  			alert("Please follow the format : 00000.00");
				document.getElementById(ctr).select();
	  			return false;
			}
		  	
		  	
		  	if(keylen==len)
			{	
				event.keyCode=0;		
				show_popup();
			}
			else
			{
//				alert("OK");
				return true;
			}
		}
	}
}
	
//-->
</script>

<title><%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='COM' ")[0][0]%></title>

<script language="JavaScript" src="../JavaScript/calendar1.js"> </script>
<%@ include file="../JavaScript/dynamicStylesheet.jsp"%>
</head>

<script language="javascript">
	var x = "<%= request.getParameter("addMore")%>"
	var regx = "<%= request.getParameter("regid")%>"
	var regname = "<%= request.getParameter("Name")%>"
	var salarysplitupby = "<%= request.getParameter("salarysplitupby")%>"
	if (x=="Y")
	{
		
		
		if( confirm(regname+" -Registraton number is -"+regx+".  Do You Want to Add One More Record...") )
		{
			if( salarysplitupby== "M")
			{
				if (confirm("Are you sure, Enter the salary split up ... "))
					location="../Smart Payroll/AllowanceRecoveryAdd.jsp";
			}
			else
				location="Staffadd.jsp?path=ATT&qp=ATT";
		}
		else
			location="StaffRegistrationView.jsp?path=ATT&qp=ATT";
		 
				
	}
</script>


<form AUTOCOMPLETE="off" name="staffaddfrm" method="post"
	action="../SmartLoginAuth" onsubmit="return validateFields()">
<body onpaste="return false;" leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0">
<table width="100%" border="0">
	<tr>
		<td><input name="path" type="hidden" value="<%=path%>"></td>
	</tr>
	<tr>
		<td height="59">&nbsp;</td>
	</tr>
	<tr>
		<td valign="top">
		<table width="900" border="0" align="center" cellpadding="2"
			cellspacing="2">
			<tr>
				<td width="119">&nbsp;</td>
				<td width="567">
				<TABLE width=900 border=0 align=center cellPadding=0 cellSpacing=0
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
							<TD valign="top">
							<table width="100%" border="0" align="center" cellpadding="0"
								cellspacing="0">
								<tr>
									<td colspan="2">
									<div align="center"><span class="boldThirteen">Staff
									Registration </span><span class="boldEleven"> <%
									int rowmax=0;
									String sqls = " select (max(INT_ID)+1) from com_m_staffid ";
									rowmax = com.my.org.erp.common.CommonFunction.intMaxCount(sqls);
									String l=""+rowmax;
									if(l.length() ==2)
										l = "00000"+l;
									else if(l.length() ==2)
										l = "0000"+l;
									else if(l.length() ==3)
										l = "000"+l;
									else if(l.length() ==4)
										l = "00"+l;
									else if(l.length() ==5)
										l = "0"+l;
										
									%> </span></div>
									</td>
								</tr>
								<tr>
									<td colspan="2">
									<div align="right"><font class="bolddeepred"
										align="absmiddle">*</font><span class="changePos">Mandatory</span></div>
									</td>
								</tr>

								<tr>
									<td colspan="2">&nbsp;</td>
								</tr>
								<tr>
									<td colspan="2">
									<table width="100%" border="0" cellspacing="2" cellpadding="2">
										<tr>
											<td width="25%" class="boldEleven">Applicant Id from
											Smart HRM<font class="bolddeepred" align="absmiddle">*</font></td>
											<td width="75%"><select name="applicantid"
												class="formText135" id="applicantid"
												onChange="loadApplicantinfofromHRM(this)">
												<option value="0">Select</option>
												<%
	String squery=" SELECT INT_APPID,CHR_APPNAME,CHR_APPCODE FROM  hrm_m_application WHERE CHR_OFFERORDERSTATUS ='Y'  AND CHR_REGISTRATIONRSTATUS='N' ORDER BY CHR_APPNAME";
	String datas1[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(squery);
	if (datas1.length>0)
		for (int i=0; i<datas1.length; i++) 
			out.println("<option value="+datas1[i][0]+">"+datas1[i][1]+" / "+datas1[i][2]+"</option>");			
	
						%>
											</select></td>
										</tr>
									</table>
									</td>
								</tr>
								<tr>
									<td colspan="2"></td>
								</tr>
								<tr>
									<td height="19" colspan="2">
									<table width="100%" border="1" align="center" cellpadding="0"
										cellspacing="0" bordercolor="#FFFF00">
										<tr>
											<td height="290">
											<table width="100%" border="0" align="center" cellpadding="2"
												cellspacing="2">
												<tr>
													<td width="50%">
													<table width="100%" border="0" align="center"
														cellpadding="1" cellspacing="2" bordercolor="#D4D0C8"
														class="boldEleven">
														<tr>
															<td colspan="2">
															<div align="center" class="errormessage">

															<div align="center">
															<%
																String ers = ""+request.getParameter("errM");
																if(!"null".equals(ers))
																	out.println(ers);
															%>
															</div>
															</div>
															</td>
														</tr>
														<tr>
															<td colspan="2">
															<div align="center"><span class="boldEleven"><strong>Personal
															Informations </strong></span></div>
															</td>
														</tr>
														<tr>
															<td width="158"></td>
															<td width="247" class="staffsearch"><input
																type="hidden" name="marry2" /> <input type="hidden"
																name="stype" /> <input name="serverid" type="hidden"
																id="serverid" value="<%=l%>"></td>
														</tr>
														<!--<tr>
															<td class="boldEleven">Staff Id <span  >*</span></td>
															<td>
<input name="id" type="text" class="boldEleven" readonly="readonly"  	id="id" onKeyPress="userNameChk(this,25)" onBlur="TxtTrim(this),CheckUnique(this,'soValid','com_m_staff','CHR_EMPID')"
																onKeyUp="upperMe(this), CheckUnique(this,'soValid','com_m_staff','CHR_EMPID')"
																size="25" maxlength="16" value='<%=l%>' />


															<div id="soValid"></div>															</td>
														</tr>-->
														<tr>
															<td class="boldEleven">Staff Name<font
																class="bolddeepred" align="absmiddle">* </font></td>
															<td><input name="name" type="text"
																class="formText135" id="name"
																onKeyPress="charOnly('name','50')" size="25"
																maxlength="50"
																onKeyUp="upperMe(this),LoadUniqueCheck('name', 'namediv', 'com_m_staff', 'CHR_STAFFNAME', 'submit_btn')" />
															<div id="namediv"></div>
															</td>
														</tr>
														<tr>
															<td class="boldEleven">
															<div id='solutename'>Father's /Spouse Name</div>
															</td>
															<td><input name="fname" id="fname" type="text"
																class="formText135" onKeyPress="charOnly('fname','50')"
																size="25" maxlength="50" /></td>
														</tr>
														<tr>
															<td class="boldEleven">Middle Name</td>
															<td><input name="middlename" type="text"
																class="formText135" id="middlename"
																onKeyPress="charOnly('fname','50')" size="25"
																maxlength="50" /></td>
														</tr>
														<tr>
															<td class="boldEleven">Gender</td>
															<td>
															<table width="152" border="0" cellspacing="0"
																cellpadding="0">
																<tr>
																	<td width="20"><input name="gender" id="gender"
																		type="radio" value="Male" checked="checked"
																		class="formText135" /></td>
																	<td width="47" class="boldEleven">Male</td>
																	<td width="26"><input name="gender" id="gender"
																		type="radio" value="Female" class="formText135" /></td>
																	<td width="59" class="boldEleven">Female</td>
																</tr>
															</table>
															</td>
														</tr>
														<tr>
															<td class="boldEleven">Blood Group<font
																class="bolddeepred" align="absmiddle">*</font></td>
															<td>
															<table width="150" border="0" cellpadding="0"
																cellspacing="0">
																<tr>
																	<td width="150"><%@ include
																		file="../JavaScript/bloodgroup.jsp"%>
																	</td>
																</tr>
															</table>
															</td>
														</tr>
														<tr>
															<td class="boldEleven">Marital Status</td>
															<td>
															<table width="152" border="0" cellpadding="0"
																cellspacing="0" class="boldEleven">
																<tr>
																	<td><input name="marry" type="radio" value="M"
																		id="marry" onClick="changeState1()" checked="checked"
																		class="formText135" /></td>
																	<td class="boldEleven">Married</td>
																	<td><input name="marry" type="radio" value="U"
																		id="marry" onClick="changeState()" class="formText135" /></td>
																	<td class="boldEleven">UnMarried</td>
																</tr>
															</table>
															</td>
														</tr>
														<tr>
															<td class="boldEleven">Date Of Birth<font
																class="bolddeepred" align="absmiddle">*</font></td>
															<td><input title="dd/mm/yyyy"
																onKeyPress="numericHypenOnly('dob','9')" name="dob"
																id="dob" type="text" class="formText135" size="22"
																maxlength="10" /> <a href="javascript:cal3.popup();">
															<img src="../JavaScript/img/cal.gif" width="16"
																border="0" alt="Click here to Pick Up the Date" /></a></td>
														</tr>
														<tr id="cwd">
															<td class="boldEleven">Wedding Date</td>
															<td><input
																onKeyPress="numericHypenOnly('wedding','9')"
																title="dd/mm/yyyy" onBlur="validateDate()"
																name="wedding" type="text" class="formText135" id="wd"
																size="22" maxlength="10" /> <a
																href="javascript:cal1.popup();"> <img
																src="../JavaScript/img/cal.gif" width="16" height="16"
																border="0" alt="Click here to Pick Up the Date" /></a></td>
														</tr>
														<tr>
															<td width="158" class="boldEleven">Date Of Join<font
																class="bolddeepred" align="absmiddle">*</font></td>
															<td class="boldEleven"><input
																onKeyPress="numericHypenOnly('doj','9')" name="doj"
																id="doj" type="text" class="formText135" size="22"
																maxlength="10" onBlur="validateDateofjoin()"
																title="dd/mm/yyyy" /> <a
																href="javascript:cal2.popup();"> <img
																src="../JavaScript/img/cal.gif" width="16" height="16"
																border="0" alt="Click here to Pick Up the Date" /></a></td>
														</tr>
														<tr>
															<td class="boldEleven">Off. E-mail</td>
															<td class="boldEleven"><input name="emailid"
																type="text" class="formText135" id="emailid" size="25"
																onKeyPress="isEmailID('emailid','100')" maxlength="100" /></td>
														</tr>
														<tr>
															<td class="boldEleven">Per. E-mail<font
																class="bolddeepred" align="absmiddle">*</font></td>
															<td class="boldEleven"><input name="peremailid"
																type="text" class="formText135" id="peremailid"
																size="25" onKeyPress="isEmailID('peremailid','100')"
																maxlength="100" />
															<div id='emaildiv'></div>
															<!--onKeyUp="LoadUniqueCheck('peremailid', 'emaildiv', 'com_m_staff', 'CHR_PERMAILID', 'submit_btn')"--></td>
														</tr>
														<tr>
															<td width="50%" class="boldEleven">Mobile</td>
															<td class="boldEleven"><input name="mobile"
																type="text" class="formText135" id="mobile"
																onKeyPress="return numeric_only(event,'mobile','25')"
																size="25" maxlength="12" /></td>
														</tr>
														<tr>
															<td class="boldEleven">Qualifications<font
																class="bolddeepred" align="absmiddle">*</font></td>
															<td class="boldEleven"><!--<input name="qualification" type="text" class="boldEleven" onKeyUp="upperMe(this)" id="qualification"   size="25" maxlength="30"   />-->


															<select name="qualification" size="1" class="formText135"
																id="qualification">
																<option value="0">Select</option>
																<%
										String ssql=" SELECT INT_QUALIFICATIONID,CHR_QUALIFICATIONNAME FROM com_m_qualification ORDER BY CHR_QUALIFICATIONNAME";
										String qualdata[][]=com.my.org.erp.common.CommonInfo.RecordSetArray(ssql);
										for(int c=0;c<qualdata.length;c++)
										{
											out.println("<option value='"+qualdata[c][0]+"'>"+qualdata[c][1]+"</option>");
										}
									%>
															</select></td>
														</tr>
														<tr>
															<td valign="top" class="boldEleven">Reporting to</td>
															<td valign="top" class="boldEleven"><select
																id="repto" name="repto" class="formText135">
																<option value="0">Select</option>
																<%
		   String rptodata[][] =com.my.org.erp.common.CommonFunction.RecordSetArray("select CHR_EMPID,CHR_STAFFNAME from com_m_staff WHERE CHR_TYPE<>'T'  AND CHR_REP='Y' ");
		   for(int c=0;c<rptodata.length;c++)
		   		out.println("<option value='"+rptodata[c][0]+"'>"+rptodata[c][1]+"</option>");
		   %>
															</select></td>
														</tr>
														<tr>
															<td valign="top" class="boldEleven">Dispensary</td>
															<td valign="top" class="boldEleven"><select
																id="Dispensary" name="Dispensary" class="formText135">
																<option value="0">Select</option>
																<%
		   String Disdata[][] =com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_DESPID,CHR_DESPNAME From com_m_dispensary order by INT_DESPID ");
		   for(int c=0;c<Disdata.length;c++)
		   		out.println("<option value='"+Disdata[c][0]+"'>"+Disdata[c][1]+"</option>");
		   %>
															</select></td>
														</tr>
														<tr>
															<td valign="top" class="boldEleven">Category<font
																class="bolddeepred" align="absmiddle">*</font></td>
															<td valign="top"><%@ include
																file="EmployeeCategory.jsp"%></td>
														</tr>
														<tr>
															<td valign="top" class="boldEleven">&nbsp;</td>
															<td valign="top">&nbsp;</td>
														</tr>
														<tr>
															<td valign="top" class="boldEleven">&nbsp;</td>
															<td valign="top">&nbsp;</td>
														</tr>
														<tr>
															<td valign="top" class="boldEleven">&nbsp;</td>
															<td valign="top">&nbsp;</td>
														</tr>
													</table>
													</td>
													<td width="53%">
													<table width="100%" border="0" align="center"
														cellpadding="1" cellspacing="3" bordercolor="#D4D0C8"
														class="boldEleven">
														<tr>
															<td colspan="4">&nbsp;</td>
														</tr>
														<tr>
															<td colspan="4">
															<div align="center"><span class="boldEleven"><strong>Official
															Details</strong></span></div>
															</td>
														</tr>
														<tr>
															<td width="187" class="boldEleven">Company<font
																class="bolddeepred" align="absmiddle">*</font></td>
															<td colspan="3">
															<table width="150" border="0" cellspacing="0"
																cellpadding="0">
																<tr>
																	<!--onchange="loadBDStaff('')"-->
																	<td><select name="company" id="company"
																		onBlur="makeGetRequest(this)" class="formText135">
																		<option value="0">Select</option>
																		<%
                                              String sql1="SELECT INT_COMPANYID,CHR_COMPANYNAME FROM  com_m_company  ORDER BY CHR_COMPANYNAME";
                                              String company[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql1);
                                              for(int i=0;i<company.length;i++){
                                            	  out.println("<option value="+company[i][0]+">"+company[i][1]+"</option>");		
                                              }
                                            %>
																	</select></td>
																</tr>
															</table>
															</td>
														</tr>

														<tr>
															<td width="187" class="boldEleven">Branch<font
																class="bolddeepred" align="absmiddle">*</font></td>
															<td colspan="3">
															<table width="150" border="0" cellspacing="0"
																cellpadding="0">
																<tr>
																	<td><!--<select name="branch" class="boldEleven">
                                           <option value="Select" >Select</option>
			 						<% 
			                
			                        String sql="SELECT * FROM  com_m_branch  ORDER BY CHR_BRANCHNAME";
			         				String branch[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			         				for(int u=0; u<branch.length; u++)
										out.print("<option value ='"+branch[u][0]+"'>" +branch[u][2]+"</option>");
							  		%>	
                                           </select>-->

																	<div id="description"></div>
																	</td>
																</tr>
															</table>
															</td>
														</tr>


														<tr>
															<td width="187" class="boldEleven">State</td>
															<td colspan="3">
															<table width="150" border="0" cellspacing="0"
																cellpadding="0">
																<tr>
																	<td><select name="st1" id="st1"
																		class="formText135"
																		onChange="LoadSelectDistrict(this)">
																		<option value="0">Select</option>
																		<%
String state1data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_STATEID,CHR_STATENAME FROM  com_m_state  ORDER BY CHR_STATENAME");
for(int h=0;h<state1data.length;h++)
	out.print("<option value='"+state1data[h][0]+"'>"+state1data[h][1]+"</option>");

%>
																	</select></td>
																</tr>
															</table>
															</td>
														</tr>
														<tr>
															<td class="boldEleven">District</td>
															<td colspan="3">
															<table width="150" border="0" cellspacing="0"
																cellpadding="0">
																<tr>
																	<td><select name="dist" id="dist"
																		class="formText135">
																		<option value="0">Select</option>
																		<%
          String distdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_DISTRICTID,CHR_DISTRICT FROM  com_m_district  ORDER BY CHR_DISTRICT");
for(int h=0;h<distdata.length;h++)
	out.print("<option value='"+distdata[h][0]+"'>"+distdata[h][1]+"</option>");
	 
		
%>
																	</select></td>
																</tr>
															</table>
															</td>
														</tr>
														<tr>
															<td bordercolor="#FF0000" class="boldEleven">Office<font
																class="bolddeepred" align="absmiddle">*</font></td>
															<td colspan="3">
															<table width="150" border="0" cellspacing="0"
																cellpadding="0">
																<tr>
																	<td><select name="off" class="formText135"
																		id="off">
																		<option value="0">Select</option>
																		<%
        String offdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_OFFICEID,CHR_OFFICENAME FROM   com_m_office   ORDER BY CHR_OFFICENAME");
for(int h=0;h<offdata.length;h++)
	out.print("<option value='"+offdata[h][0]+"'>"+offdata[h][1]+"</option>");

		
%>
																	</select></td>
																</tr>
															</table>
															</td>
														</tr>
														<tr>
															<td class="boldEleven">Department<font
																class="bolddeepred" align="absmiddle">*</font></td>
															<td colspan="3">
															<table width="150" border="0" cellspacing="0"
																cellpadding="0">
																<tr>
																	<td><select name="depart" class="formText135"
																		id="depart">
																		<option value="0">Select</option>
																		<%
      	String depdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_DEPARTID,CHR_DEPARTNAME FROM  com_m_depart  ORDER BY CHR_DEPARTNAME");
	for(int h=0;h<depdata.length;h++)
		out.print("<option value='"+depdata[h][0]+"'>"+depdata[h][1]+"</option>");

		
%>
																	</select></td>
																</tr>
															</table>
															</td>
														</tr>
														<tr>
															<td class="boldEleven">Designation<font
																class="bolddeepred" align="absmiddle">*</font><font
																class="redcol style3" align="absmiddle">&nbsp;</font></td>
															<td colspan="3">
															<table width="150" border="0" cellspacing="0"
																cellpadding="0">
																<tr>
																	<td><select name="desig" class="formText135"
																		id="desig">
																		<option value="0">Select</option>
																		<%
         		String desgdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_DESIGID,CHR_DESIGNAME FROM  com_m_desig  ORDER BY CHR_DESIGNAME");
			for(int h=0;h<desgdata.length;h++)
				out.print("<option value='"+desgdata[h][0]+"'>"+desgdata[h][1]+"</option>");
			

		
%>
																	</select></td>
																</tr>
															</table>
															</td>
														</tr>
														<tr>
															<td class="boldEleven">Type<font class="bolddeepred"
																align="absmiddle">*</font></td>
															<td colspan="3">
															<table width="150" border="0" cellspacing="0"
																cellpadding="0">
																<tr>
																	<td><%@ include file="../JavaScript/stafftype.jsp"%></td>
																</tr>
															</table>
															</td>
														</tr>
														<tr>
															<td class="boldEleven">Basic Salary</td>
															<td colspan="3"><input name="basic" type="text"
																class="formText135" id="basic" value="" size="22"
																maxlength="10" onKeyPress="pricesOnly('basic')" /></td>
														</tr>
														<tr>
															<td class="boldEleven">Gross Salary<font
																class="bolddeepred" align="absmiddle"> *</font></td>
															<td colspan="3"><input name="gross" type="text"
																class="formText135" id="gross"
																onKeyPress="pricesOnly('gray')" value="0" size="22"
																maxlength="15" /> <%
	String salaryData[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(" SELECT INT_STARTINGSALARY,INT_ENDINGSALARY FROM  pay_m_salaryband  ORDER BY INT_SALARYBANDID ");
	String lvalue="";
	for(int x=0; x<salaryData.length;x++)
	{
		for(int y=0; y<2;y++)
		{
			lvalue = lvalue+salaryData[x][y]+",";
		}
		lvalue = lvalue+"~";	
	}
	
	
	
	String stafftypeDatas[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(" SELECT  CHR_TYPENAME,CHR_FLAG FROM com_m_stafftype  ORDER BY CHR_TYPENAME ");
	String svalue="";
	for(int x=0; x<stafftypeDatas.length;x++)
	{
		for(int y=0; y<2;y++)
		{
			svalue = svalue+stafftypeDatas[x][y]+",";
		}
		svalue = svalue+"~";	
	}
	
	
%> <script language="javascript">
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
			 if((gross >=gt) &&(gross <=lt))
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
                                                            </script></td>
														</tr>
														<tr>
															<td class="boldEleven">Salary Split up</td>
															<td colspan="3">
															<table width="100" border="0" cellspacing="0"
																cellpadding="0">
																<tr>
																	<td class="boldEleven"><input
																		name="salarysplitupby" id="salarysplitupby"
																		type="radio" value="A" checked></td>
																	<td class="boldEleven">Automatic</td>
																	<td class="boldEleven"><input
																		name="salarysplitupby" id="salarysplitupby"
																		type="radio" value="M"></td>
																	<td class="boldEleven">Manual</td>
																</tr>
															</table>
															</td>
														</tr>
														<tr>
															<td class="boldEleven">Bank Name<font
																class="bolddeepred" align="absmiddle">*</font></td>
															<td colspan="3"><!-- 	<input name="bank" type="text" class="boldEleven" id="bank"  onKeyPress="charOnly('name','35')" size="22" maxlength="30"  /> -->
															<select name="bank" class="formText135" id="bank">
																<option value="0">Select</option>
																<%
                  out.println("<option value='1'>No Bank</option>");	
						String query="SELECT INT_BANKID, CHR_BANKNAME FROM com_m_bank ORDER BY CHR_BANKNAME";
                  		String datas[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(query);
                  		if (datas.length>0){
                  			for (int i=0; i<datas.length; i++) {
								out.println("<option value="+datas[i][0]+">"+datas[i][1]+"</option>");			
                  			}
                  		}
				%>
															</select></td>
														</tr>
														<tr>
															<td width="50%" class="boldEleven">Account No</td>
															<td colspan="3"><input name="number" type="text"
																class="formText135" id="no"
																onKeyPress="alphaNumeric('no','25')" size="22"
																maxlength="20" onKeyUp="upperMe(this) "
																onBlur="upperMe(this) " value="DD" /> <!--CheckUnique(this,'acc','com_m_staff','CHR_ACCNO')CheckUnique(this,'acc','com_m_staff','CHR_ACCNO')-->
															<div id="acc"></div>
															</td>
														</tr>

														<tr>
															<td class="boldEleven">Leave Carry</td>
															<td><input name="carry" type="checkbox"
																class="formText135" id="carry"></td>
															<td class="boldEleven">Fingerprint Login</td>
															<td><select name="FPlogin" id="FPlogin"
																class="formText135">
																<option value="N" selected="selected">No</option>
																<option value="Y">Yes</option>
															</select></td>
														</tr>
														<tr>
															<td class="boldEleven">Management</td>
															<td><input name="management" type="checkbox"
																class="formText135" id="management"></td>
															<td class="boldEleven">Pay slip hide</td>
															<td><select name="payslip" id="payslip"
																class="formText135">
																<option value="N" selected="selected">No</option>
																<option value="Y">Yes</option>
															</select></td>
														</tr>
														<tr>
															<td class="boldEleven">Reporting Head</td>
															<td width="32"><input name="Reporinghead"
																type="checkbox" class="formText135" id="Reporinghead"></td>
															<td width="140" class="spc">
															<p class="boldEleven">Conveyance clear</p>
															</td>
															<td width="78"><input name="conveyance"
																type="checkbox" class="formText135" id="conveyance"></td>
														</tr>
														<tr>
															<td class="boldEleven"><span class="spc">Staff
															Holding </span></td>
															<td><input name="hold" type="checkbox"
																class="formText135" id="hold" value="Y"></td>
															<td class="spc">Salary Calcualtion</td>
															<td><input name="salarycalculation" type="checkbox"
																class="formText135" id="salarycalculation" value="Y"
																checked></td>
														</tr>
													</table>
													</td>
												</tr>
											</table>
											</td>
										</tr>
									</table>
									</td>
								</tr>
								<tr>
									<td width="49%" height="19">&nbsp;</td>
									<td width="51%">&nbsp;</td>
								</tr>
								<tr>
									<td height="19" colspan="2">
									<table width="100%" border="1" align="center" cellpadding="0"
										cellspacing="0" bordercolor="#FFFF00">
										<tr>
											<td height="210">
											<table width="100%" border="0" align="center" cellpadding="2"
												cellspacing="2">
												<tr>
													<td height="23" colspan="2"><span class="boldEleven">Copy
													Permanent to <span class="boldEleven">Communication</span>
													Address <input name="res" type="radio" class="formText135"
														onClick="return resoffval()" value="yes"> Yes <input
														name="res" type="radio" class="formText135"
														onClick="return resoffval()" value="no"> No </span></td>
												</tr>
												<tr>
													<td width="48%" height="210">
													<table width="100%" border="0" align="center"
														cellpadding="1" cellspacing="2">
														<tr>
															<td height="15" colspan="2" class="boldEleven">
															<div align="center"><strong>Permanent
															Address</strong></div>
															</td>
														</tr>
														<tr>
															<td class="boldEleven">&nbsp;</td>
															<td width="276" class="boldEleven">&nbsp;</td>
														</tr>
														<tr>
															<td width="129" class="boldEleven">&nbsp;</td>
															<td class="boldEleven">&nbsp;</td>
														</tr>
														<tr>
															<td width="129" class="boldEleven">Address1<font
																class="bolddeepred" align="absmiddle">*</font></td>
															<td class="boldEleven"><input name="padd1"
																type="text" class="formText135" id="padd1"
																onKeyPress="isAddress('pad1','50')" size="30"
																maxlength="50" /> <span class="errormessage">(No.8,
															1st Main Road)</span></td>
														</tr>
														<tr>
															<td class="boldEleven">Address2<font
																class="bolddeepred" align="absmiddle">*</font></td>
															<td class="boldEleven"><input name="padd2"
																type="text" class="formText135" id="padd2"
																onKeyPress="isAddress('pad2','50')" size="30"
																maxlength="50" /> <span class="errormessage">(Seethammal
															Extn) </span></td>
														</tr>

														<tr>
															<td class="boldEleven">Location<font
																class="bolddeepred" align="absmiddle">*</font></td>
															<td class="boldEleven"><select name="pcity"
																class="formText135" id="pcity" style="width: 170"
																onChange="PAssignPincode('ppincode')">
																<option value="0" selected="selected">Select
																City</option>
															</select> <span class="errormessage">(Alwarpet) </span></td>
														</tr>
														<tr>
															<td class="boldEleven">District<font
																class="bolddeepred" align="absmiddle">*</font></td>
															<td class="errormessage"><select name="pdistrict"
																class="formText135" id="pdistrict" style="width: 170"
																onChange=" PLoadSelectCity()">
																<option value="0" selected="selected">Select
																District</option>
															</select> (Chennai)</td>
														</tr>
														<tr>
															<td class="boldEleven">State <input type="hidden"
																name="staffid" value="<%="staffid"%>" /> <font
																class="bolddeepred" align="absmiddle">*</font></td>
															<td class="boldEleven">
															<table width="150" border="0" cellspacing="0"
																cellpadding="0">
																<tr>
																	<td><select name="pstate" class="formText135"
																		id="pstate" style="width: 170"
																		onChange="PLoadSelectDistrict()">
																		<option value="0" selected="selected">Select
																		State</option>
																	</select></td>
																</tr>
															</table>
															<span class="errormessage">(Tamilnadu)</span></td>
														</tr>
														<tr>
															<td class="boldEleven">Country<font
																class="bolddeepred" align="absmiddle">*</font></td>
															<td class="boldEleven"><select name="pcountry"
																class="formText135" id="pcountry" style="width: 170"
																onChange="PLoadSelectState()">
																<option value="0">Select Country</option>
																<%
	 		String creadData[][]= com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_COUNTRYID ,CHR_COUNTRYNAME FROM  com_m_country ORDER BY CHR_COUNTRYNAME");
			for(int i=0;i<creadData.length;i++)
				out.println("<option value='"+creadData[i][0]+"'>"+creadData[i][1]+"</option>");
	 %>
															</select> <span class="errormessage"> ( India ) </span></td>
														</tr>
														<tr>
															<td class="boldEleven">Pin Code<font
																class="bolddeepred" align="absmiddle">*</font></td>
															<td class="boldEleven"><input name="ppincode"
																type="text" class="formText135" id="ppincode"
																onKeyPress="return numeric_only(event,'ppincode','6')"
																size="25" maxlength="6" /> <span class="errormessage">(600018)</span></td>
														</tr>
														<tr>
															<td class="boldEleven">Phone No</td>
															<td class="boldEleven"><input name="pphone"
																type="text" class="formText135" id="pphone"
																onKeyPress="return numeric_only(event,'pphone','10')"
																size="25" maxlength="12" /></td>
														</tr>
													</table>
													</td>
													<td width="52%">
													<table width="100%" border="0" align="center"
														cellpadding="1" cellspacing="2">
														<tr>
															<td colspan="2" class="boldEleven">
															<div align="center"><span class="boldEleven"><strong>Communication
															Address</strong></span></div>
															</td>
														</tr>
														<tr>
															<td width="50%" class="boldEleven">&nbsp;</td>
															<td width="262" class="boldEleven">
															<table width="167" align="right">
																<TR>
																	<TD width="56"><script language="javascript">
					 
function cityWindow(query)
	{  
		/*var width="800", height="400";
  		var left = (screen.width/2) - width/2;
		var top = (screen.height/2) - height/2;
	 	var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=yes,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
		newWindow = window.open(query,"subWind",styleStr);
		newWindow.focus( );*/
	}

	
					                                                                                     </script>
																	<input name="cityname"
																		onClick="javascript:cityWindow('../Common/addCity.jsp')"
																		type="button" class="buttonbold13" id="cityname"
																		value="Add City"></td>

																</tr>
															</table>

															</td>
														</tr>
														<tr>
															<td class="boldEleven">&nbsp;</td>
															<td class="boldEleven">&nbsp;</td>
														</tr>
														<tr>
															<td width="180" class="boldEleven">Address1<font
																class="bolddeepred" align="absmiddle">*</font></td>
															<td class="boldEleven"><input name="cadd1"
																type="text" class="formText135" id="cadd1"
																onKeyPress="isAddress('cadd1','50')" size="30"
																maxlength="50" /></td>
														</tr>
														<tr>
															<td class="boldEleven">Address2<font
																class="bolddeepred" align="absmiddle">*</font></td>
															<td class="boldEleven"><input name="cadd2"
																type="text" class="formText135" id="cadd2"
																onKeyPress="isAddress('cadd2','50')" size="30"
																maxlength="50" /></td>
														</tr>
														<tr>
															<td class="boldEleven">Location<font
																class="bolddeepred" align="absmiddle">*</font></td>
															<td class="boldEleven"><select name="ccity"
																class="formText135" id="ccity" style="width: 170"
																onChange="CAssignPincode('cpincode')">
																<option value="0" selected="selected">Select
																City</option>
															</select></td>
														</tr>
														<tr>
															<td class="boldEleven">District<font
																class="bolddeepred" align="absmiddle">*</font></td>
															<td class="boldEleven"><select name="cdistrict"
																class="formText135" id="cdistrict" style="width: 170"
																onChange=" CLoadSelectCity()">
																<option value="0" selected="selected">Select
																District</option>
															</select></td>
														</tr>
														<tr>
															<td class="boldEleven">State <font
																class="bolddeepred" align="absmiddle">*</font></td>
															<td class="boldEleven">
															<table width="150" border="0" cellspacing="0"
																cellpadding="0">
																<tr>
																	<td><select name="cstate" class="formText135"
																		id="cstate" style="width: 170"
																		onChange="CLoadSelectDistrict()">
																		<option value="0" selected="selected">Select
																		State</option>
																	</select></td>
																</tr>
															</table>
															</td>
														</tr>
														<tr>
															<td class="boldEleven">Country<font
																class="bolddeepred" align="absmiddle">*</font></td>
															<td class="boldEleven"><select name="ccountry"
																class="formText135" id="ccountry" style="width: 170"
																onChange="CLoadSelectState()">
																<option value="0">Select Country</option>
																<%
	 		for(int i=0;i<creadData.length;i++)
				out.println("<option value='"+creadData[i][0]+"'>"+creadData[i][1]+"</option>");
	 %>
															</select></td>
														</tr>
														<tr>
															<td class="boldEleven">Pin Code<font
																class="bolddeepred" align="absmiddle">*</font></td>
															<td class="boldEleven"><input name="cpincode"
																type="text" class="formText135" id="cpincode"
																onKeyPress="return numeric_only(event,'cpincode','6')"
																size="25" maxlength="6" /></td>
														</tr>
														<tr>
															<td class="boldEleven">Phone No<font
																class="bolddeepred" align="absmiddle">*</font></td>
															<td class="boldEleven"><input name="cphone"
																type="text" class="formText135" id="cphone"
																onKeyPress="return numeric_only(event,'cphone','10')"
																size="25" maxlength="12" /></td>
														</tr>
													</table>
													</td>
												</tr>
											</table>
											</td>
										</tr>
									</table>
									</td>
								</tr>
								<tr>
									<td height="19">&nbsp;</td>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td height="19" colspan="2">
									<table width="100%" border="1" align="center" cellpadding="0"
										cellspacing="0" bordercolor="#FFFF00">
										<tr>
											<td height="185">
											<table width="100%" border="0" align="center" cellpadding="2"
												cellspacing="2">
												<tr>
													<td width="48%" height="167">
													<table width="100%" border="0" align="center"
														cellpadding="1" cellspacing="2">
														<tr>
															<td colspan="2" class="boldEleven">
															<div align="center"><span class="boldEleven"><strong>PF</strong></span></div>
															</td>
														</tr>
														<tr>
															<td class="boldEleven">&nbsp;</td>
															<td class="boldEleven">&nbsp;</td>
														</tr>
														<tr class="boldEleven">
															<td width="160" class="boldEleven">PF</td>
															<td width="194" class="boldEleven">
															<table width="140" border="0" cellspacing="0"
																cellpadding="0">
																<tr>
																	<td width="20"><input name="pf" type="radio"
																		class="formText135" value="Y" checked
																		onClick="enable()" /></td>
																	<td width="20"><span class="boldEleven">Yes</span></td>
																	<td width="24"><input name="pf" type="radio"
																		class="formText135" value="N" onClick="disable()" />
																	</td>
																	<td width="16"><span class="boldEleven">No</span></td>
																	<td width="22"><input name="pf" type="radio"
																		value="C" class="formText135" onClick="cenable()" />
																	</td>
																	<td width="58" class="boldEleven">Common</td>
																</tr>
															</table>
															</td>
														</tr>
														<tr id="pf0">
															<td class="boldEleven">PF TYPE</td>
															<td class="boldEleven">
															<table width="100" border="0" cellpadding="0"
																cellspacing="0" class="boldEleven">
																<tr>
																	<td id="s1"><span class="bolddeepblue"> <input
																		name='optpf' type='radio' class="formText135"
																		value='A' /> </span></td>
																	<td class="boldEleven" id="s2">Amount</td>
																	<td><span class="bolddeepblue"> <input
																		name='optpf' type='radio' class="formText135"
																		value='P' checked="checked" /> </span></td>
																	<td class="boldEleven">Percentage</td>
																</tr>
															</table>
															</td>
														</tr>
														<tr id="pf1">
															<td class="boldEleven">PF Number</td>
															<td class="boldEleven"><input name="TxtPfNo"
																id="TxtPfNo" type="text" class="formText135" size="25"
																maxlength="10"
																onKeyPress="return numeric_only(event,'TxtPfNo','10');" />
															</td>
														</tr>
														<tr id="pf2">
															<td class="boldEleven">PF Amount</td>
															<td class="boldEleven"><input name="TxtPfValue"
																type="text" class="formText135"
																onKeyPress="doubleValue('TxtPfValue','9')" size="25"
																maxlength="15" /></td>
														</tr>
														<tr>
															<td class="boldEleven">Date of PF &amp; ESI
															Registration</td>
															<td class="boldEleven"><input title="dd/mm/yyyy"
																onKeyPress="numericHypenOnly('pfesidate','9')"
																name="pfesidate" id="pfesidate" type="text"
																class="formText135" size="22" maxlength="10" /> <a
																href="javascript:cal4.popup();"> <img
																src="../JavaScript/img/cal.gif" width="16" border="0"
																alt="Click here to Pick Up the Date" /> </a></td>
														</tr>
													</table>
													</td>
													<td width="52%">
													<table width="100%" border="0" align="center"
														cellpadding="1" cellspacing="2">
														<tr>
															<td height="21" colspan="2" class="boldEleven">
															<div align="center"><span class="boldEleven"><strong>
															ESI</strong></span></div>
															</td>
														</tr>
														<tr>
															<td height="21" class="boldEleven">&nbsp;</td>
															<td width="250" class="boldEleven">&nbsp;</td>
														</tr>
														<tr>
															<td width="120" height="21" class="boldEleven">ESI</td>
															<td class="boldEleven">
															<table width="75" border="0" cellspacing="0"
																cellpadding="0">
																<tr>
																	<td width="20"><input name="ESI" id="ESI"
																		type="radio" class="formText135" onClick="enable1()"
																		value="Y" checked /></td>
																	<td width="20"><span class="boldEleven">Yes</span></td>
																	<td width="20"><input name="ESI" type="radio"
																		class="formText135" value="N" onClick="disable1()" />
																	</td>
																	<td width="7"><span class="boldEleven">No</span></td>
																	<td width="8"><input name="ESI" type="radio"
																		value="C" class="formText135" onClick="cenable1()" />
																	</td>
																	<td width="15" class="boldEleven">Common</td>
																</tr>
															</table>
															</td>
														</tr>
														<tr id="ppf0">
															<td height="21" class="boldEleven">ESI TYPE</td>
															<td class="boldEleven">
															<table width="100" border="0" cellpadding="0"
																cellspacing="0" class="boldEleven">
																<tr>
																	<td id="ps1"><span class="bolddeepblue"> <input
																		name='optesi' type='radio' class="formText135"
																		value='A' /> </span></td>
																	<td class="boldEleven" id="ps2">Amount</td>
																	<td><span class="bolddeepblue"> <input
																		name='optesi' type='radio' class="formText135"
																		value='P' checked="checked" /> </span></td>
																	<td class="boldEleven">Percentage</td>
																</tr>
															</table>
															</td>
														</tr>
														<tr id="ppf1">
															<td class="boldEleven">ESI Number</td>
															<td class="boldEleven"><input name="TxtEsiNo"
																id="TxtEsiNo" type="text" class="formText135"
																onKeyUp="upperMe(this), LoadUniqueCheck('TxtEsiNo', 'ESIDiv', 'com_m_staff', 'CHR_ESINO', 'submit_btn')"
																size="25" maxlength="30" />
															<div id="ESIDiv"></div>
															</td>
														</tr>
														<tr id="ppf2">
															<td class="boldEleven">ESI Amount</td>
															<td class="boldEleven"><input name="TxtEsiValue"
																type="text" class="formText135"
																onKeyPress="doubleValue('TxtEsiValue','9')" size="25"
																maxlength="15" /></td>
														</tr>
														<tr>
															<td class="boldEleven">Date of Resign</td>
															<td class="boldEleven"><input title="dd/mm/yyyy"
																onKeyPress="numericHypenOnly('resigndate','9')"
																name="resigndate" id="resigndate" type="text"
																class="formText135" size="22" maxlength="10" /> <a
																href="javascript:cal5.popup();"> <img
																src="../JavaScript/img/cal.gif" width="16" border="0"
																alt="Click here to Pick Up the Date" /> </a></td>
														</tr>
													</table>
													</td>
												</tr>
												<tr>
													<td>
													<table width="100%" border="0" align="center">
														<tr>
															<td width="46%" class="boldEleven">PAN NO</td>
															<td width="54%"><input name="pannumber" type="text"
																class="formText135" id="pannumber"
																onKeyUp="upperMe(this), LoadUniqueCheck('pannumber', 'pandiv', 'com_m_staff', 'CHR_PAN', 'submit_btn')"
																maxlength="16">
															<div id="pandiv"></div>
															</td>
														</tr>
														<tr>
															<td class="boldEleven">PASS PORT NO</td>
															<td><input name="passportnumber" type="text"
																class="formText135" id="passportnumber"
																onKeyUp="upperMe(this), LoadUniqueCheck('passportnumber', 'passportnumberdiv', 'com_m_staff', 'CHR_PASSPORT', 'submit_btn')"
																maxlength="16">
															<div id="passportnumberdiv"></div>
															</td>
														</tr>
														<tr>
															<td class="boldEleven">DRIVING LICENSE NO</td>
															<td><input name="drivingnumber" type="text"
																class="formText135" id="drivingnumber"
																onKeyUp="upperMe(this), LoadUniqueCheck('drivingnumber', 'drivingdiv', 'com_m_staff', 'CHR_DRIVING', 'submit_btn')"
																maxlength="16">
															<div id="drivingdiv"></div>
															</td>
														</tr>
													</table>
													</td>
													<td>
													<table width="100%" border="0" cellspacing="0"
														cellpadding="0">
														<tr>
															<td width="34%" class="boldEleven">Previous Details
															</td>
															<td width="66%" rowspan="3" align="left" valign="top"><textarea
																name="previousdetails"
																onKeyUp="textArea('previousdetails','2000')" cols="30"
																rows="5" class="formText135" id="previousdetails"></textarea></td>
														</tr>
														<tr>
															<td>&nbsp;</td>
														</tr>
														<tr>
															<td>&nbsp;</td>
														</tr>
													</table>
													</td>
												</tr>
												<tr>
													<td>&nbsp;</td>
													<td>&nbsp;</td>
												</tr>
												<tr>
													<td></td>
													<td>&nbsp;</td>
												</tr>
												<tr>
													<td colspan="2" class="boldEleven"></td>
												</tr>
												<tr>
													<td>&nbsp;</td>
													<td>&nbsp;</td>
												</tr>
											</table>
											</td>
										</tr>
									</table>
									</td>
								</tr>
								<tr>
									<td height="19">&nbsp;</td>
									<td><input name="filename" type="hidden" id="filename"
										value="StaffRegistration"> <input name="actionS"
										type="hidden" id="actionS" value="COM_ATTStaffRegistration"></td>
								</tr>
								<tr>
									<td height="19" colspan="2">
									<table border="0" align="center" cellpadding="2"
										cellspacing="2">
										<tr>
											<td width="56"><input type="submit" name="Submit"
												id="submit_btn" class="buttonbold" value="Submit"
												accesskey="s" /></td>
											<td width="56"><!--   <input type="button" name="submit" class="buttonbold"  value="Close"   accesskey="c"  onClick="redirect('<%=closefile%>')"  /></td>  -->

											<input type="button" name="submit" class="buttonbold"
												value="Close" accesskey="c"
												onClick="redirect('StaffRegistrationView.jsp?path=ATT&qp=ATT')" /></td>
										</tr>
									</table>
									</td>
								</tr>
							</table>
							</TD>
							<TD noWrap width=5><SPACER height="1" width="1" type="block" /></TD>
							<TD class=BorderLine width=2><SPACER height="1" width="1"
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
				<td width="113" valign="top"><!--<table width="113" border="0" align="center" cellpadding="1"
					cellspacing="3" bordercolor="#D4D0C8" class="boldEleven">
					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td>
						<%
			String staffphoto = request.getRealPath("")+"/StaffPhoto/"+staffid.trim() +".jpg";
			String defaul = request.getRealPath("")+"/default.jpg" ;
			String photo="";
			File f = new File(staffphoto);
			if (f.exists())
				photo = request.getRealPath("")+"/StaffPhoto/"+staffid.trim() +".jpg";
			else
				photo =defaul;
			%>
						</td>
					</tr>
					<tr>
						<td width="105">
						<div align="center" class="copyright"><strong>Staff
						Photo </strong></div>
						</td>
					</tr>
					<tr>
						<td rowspan="5"><img src="../StaffPhoto/default.jpg" title="<%=photo%>"
							width="100" height="130" border="1" name="Photo" id="Photo" /></td>
					</tr>
					<tr>
					</tr>
					<tr>
					</tr>
					<tr>
					</tr>
					<tr>
					</tr>
					<tr>
						<td>
						<div align="center"><input name="Button" type="Button"
							class="buttonbold" onClick="return PhotoUpload('<%=staffid%>')"
							value="Upload"></div>
						</td>
					</tr>
				</table>--></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
<script language="JavaScript">
<!--
  var cal1=new calendar1(document.forms['staffaddfrm'].elements['wedding']);
  cal1.year_scroll=true;
  cal1.time_comp=false;
  var cal2=new calendar1(document.forms['staffaddfrm'].elements['doj']);
  cal2.year_scroll=true;
  cal2.time_comp=false;
  var cal3=new calendar1(document.forms['staffaddfrm'].elements['dob']);
  cal3.year_scroll=true;
  cal3.time_comp=false;
  
  var cal4=new calendar1(document.forms['staffaddfrm'].elements['pfesidate']);
  cal4.year_scroll=true;
  cal4.time_comp=false;
  
  var cal4=new calendar1(document.forms['staffaddfrm'].elements['resigndate']);
  cal4.year_scroll=true;
  cal4.time_comp=false;
  
  
  
//-->



function PhotoUpload(staffid)
	{
			var s =document.staffaddfrm.id.value;
		if (s=="")
		{
			alert ("Please enter Staffid....");
			document.staffaddfrm.id.focus();
			return false;
		}
		else
		{
			var f ="StaffPhotoUpload.jsp?staffid="+document.staffaddfrm.id.value;
			newWindow = window.open(f,"subWind",",,height=250,width=325,top=0,left=0");
			newWindow.focus( );
		}
		return true 
		 	
	}	
</script>
<div id="staffTable" style="OVERFLOW: auto; width: 0px; height: 0px"></div>
</body>
</form>
</html>
