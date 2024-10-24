<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonInfo"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon"></jsp:useBean>
<%!
	Connection con ;
	PreparedStatement pstm;
	ResultSet rst;
	String userid;
	
%>
<script language="JavaScript" type="text/javascript">

 

</script>
<%
 
String shortdata[][] =CommonFunctions.QueryExecute("SELECT CHR_SHORTNAME FROM com_m_company WHERE CHR_SHORTNAME is not null ORDER BY INT_COMPANYID");
String shortname="";
for(int u=0;u<shortdata.length;u++)
	shortname = shortname+shortdata[u][0]+",";

String dojlock =CommonFunctions.QueryExecute("SELECT CHR_DOJLOCK FROM M_INSTITUTION  WHERE INT_ID=1")[0][0];

%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script language="JavaScript" src="../JavaScript/comfunction.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/AJAXFunctionStaff.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/commonAJAX.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/Attendance/AttendanceAjax.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/AJAX.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/common/PermanentSelectChangesCountry.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/common/communicationSelectChangesCountry.js" type="text/javascript"></script>
<script language="javascript" src="../JavaScript/smartcommon/BranchLoadAjax.js"></script>

<script language="JavaScript" src="../JavaScript/jquery/jquery-1.7.1.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/jquery/ui/jquery.ui.core.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/jquery/ui/jquery.ui.widget.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js" type="text/javascript"></script>

 
	
	
<script>
		
	var d1=new Date();
	var day1=d1.getDate();	
	var dojlock= "<%=dojlock%>";
	 
	
	
	$(function() {
		var dates = $( "#doj, #pfesidate" ).datepicker({
			defaultDate: "+1w",
			changeMonth: true,
			minDate: -dojlock, maxDate: "+0D" ,showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			numberOfMonths: 1,
			buttonImageOnly: true,
			onSelect: function( selectedDate ) 
			{
				var option = this.id == "doj" ? "minDate" : "maxDate",
					instance = $( this ).data( "datepicker" ),
					date = $.datepicker.parseDate(instance.settings.dateFormat || $.datepicker._defaults.dateFormat, selectedDate, instance.settings );
					dates.not( this ).datepicker( "option", option, date );
			}
		});
	}); 
	
	
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
		$( "#wedding" ).datepicker({
			changeMonth: true,
			changeYear: true,
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







<script language="JavaScript" type="text/javascript">
<!--
 
 


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
		var _targ1=document.getElementsByName('ccity')[0];       
		_targ1.options.length=0;
		_targ1.options[0]=new Option('Select City','0');  
		
		_targ1=document.getElementsByName('cdistrict')[0];       
		_targ1.options.length=0;
		_targ1.options[0]=new Option('Select District','0');  
		
		
		_targ1=document.getElementsByName('cstate')[0];       
		_targ1.options.length=0;
		_targ1.options[0]=new Option('Select State','0');  
		
		 
			 
		document.staffaddfrm.ccity.selectedIndex = 0;
		document.staffaddfrm.cdistrict.selectedIndex = 0;
		document.staffaddfrm.cstate.selectedIndex = 0;
		document.staffaddfrm.ccountry.selectedIndex = 0;
		document.staffaddfrm.cpincode.value = "";
		document.staffaddfrm.cphone.value = "";
		
	}
	return true;
}//end of resoffval

 
 
 
 function pfchange()
{
	 
	if(document.getElementById('pf').value== "Y" )
	{
		setOptionValue('optpf','A');
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






 

function basic_Gross_check()
{
	try
	{
		
		 
		var a = parseFloat(document.getElementById('basic').value);
		var b = parseFloat(document.getElementById('gross').value);
		
		if(b<1)
		{
			alert("please check the Gross... ");
			document.getElementById('gross').focus();
			return false;
		}
		if(a>40000)
		{
			alert("please check Basic, It is high Amount...")
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

	
function validateFields()
{
	try
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
	
		var obj = findObj("branch");
		if(obj == null)
		{
			alert("branch not available");
			return false;
		}
		try
		{
			if(
			
				  checkNull('name','Enter Staff Name')
				 && checkNull('fname','Enter Father Name...')
				 && checkNullSelect('bg','Select Blood Group','0')
				 && checkNull('dob','Enter Date of Birth')
				 && checkNull('doj','Enter Date of Joining')
				 && checkNull('peremailid','Enter the personal E-mail id...')
				 && chkemail1("peremailid",'Entert the correct E-mail Address...')
				 && checkNullSelect('repto','Select Reporting to... ','0')
				 && checkNullSelect('category','Select category','0')
				 && checkNullSelect('company','Select Company Name','0')
				 && checkNullSelect('branch','Select Branch Name','0')
				 && checkNullSelect('off','Select Office Name','0')   	
				 && checkNullSelect('depart','Select Department Name','0')
				 && checkNullSelect('desig','Select Designation Name','0')
				 && checkNull('basic','Enter the basic')
				 && checkNullSelect('bank','Select Bank','0')
				 
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
				
			)
				return true;
			else
				return false;	  
		 }
		 catch(err)
		 {
			alert(err.description);
			return false;
		 }
	 }
	 catch(err)
	 {
		alert(err);
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
    } 
     function changeState()
    {
		document.staffaddfrm.wedding.value="";
        document.staffaddfrm.wedding.disabled=false;
        cwd.style.visibility="hidden";
    } 	
 
 
 
//-->
</script>

<title><%= CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='GEN' ")[0][0]%></title>
 
<script language="JavaScript" src="../JavaScript/calendar1.js" type="text/javascript"> </script>

 <link href="../JavaScript/SmartStyles.css" rel="stylesheet" type="text/css" />
 <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
</head>

<script language="JavaScript" type="text/javascript">
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
					location="../Smart Payroll/ManulaAllowanceRecoveryAdd.jsp?ename="+regx;
			}
			else
				location="Staffadd.jsp";
		}
		else
			location="StaffRegistrationView.jsp";
		 
				
	}
	else if (x=="F")
	{
		alert("Staff Registration failed....");
		location="Staffadd.jsp";
	}
</script>


<form  AUTOCOMPLETE = "off"   name="staffaddfrm" method="post"  action="../SmartLoginAuth" onsubmit="return validateFields()">
<jsp:include page="index.jsp" flush="true" />
<body   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onselectstart="return false" onpaste="return false;"  autocomplete="off" onLoad="document.getElementById('applicantid').focus()">
<table width="100%" border="0">
	<tr>
		<td> <%
				String grd="";
				String grd1="";
				String dbvalue="";

			 %></td>
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
			  <td width="567"><table width="800" border="0" align="center" cellpadding="0" cellspacing="0"
					bgcolor="#dce4f9" class="BackGround">
                <tbody>
                  <tr>
                    <td colspan="2" rowspan="2"><img height="7"
								src="../Image/General/TLCorner.gif" width="7" /></td>
                    <td class="BorderLine" height="1"><spacer height="1" width="1"
								type="block" /></td>
                    <td colspan="2" rowspan="2"><img height="7"
								src="../Image/General/TRCorner.gif" width="7" /></td>
                  </tr>
                  <tr>
                    <td height="6"><spacer height="1" width="1" type="block" /></td>
                  </tr>
                  <tr>
                    <td class="BorderLine" width="1"><spacer height="1" width="1"
								type="block" /></td>
                    <td width="6"><spacer height="1" width="1" type="block" /></td>
                    <td valign="top"><table width="100%" border="0" align="center" cellpadding="0"
								cellspacing="0">
                        <tr>
                          <td colspan="2"><div align="center"><span class="boldThirteen">Contract Staff
                            Registration </span><span class="boldEleven">
                            
                            <%
																String ers = ""+request.getParameter("errM");
																if(!"null".equals(ers))
																	out.println(ers);
															%>
                            </span> <%
String staffid = request.getParameter("staffid");
String sql="SELECT ";
sql = sql+" INT_CONTRACTID,CHR_STAFFNAME,CHR_STAFFFNAME,CHR_GENDER, DATE_FORMAT( DT_DOB,'%d-%m-%Y'), DATE_FORMAT( DT_DOJ,'%d-%m-%Y'),CHR_MARITALSTATUS,DATE_FORMAT( DT_WEDDATE,'%d-%m-%Y'), ";
sql = sql+" INT_BLOODGROUPID,INT_COMPANYID,INT_BRANCHID,INT_OFFICEID,INT_DEPARTID,INT_DESIGID,INT_CATEGORY, ";
sql = sql+" INT_SALARY,INT_BANK,CHR_ACCNO,CHR_IFSC,CHR_P_ADD1,CHR_P_ADD2,INT_P_CITYID,INT_P_DISTRICTID, ";
sql = sql+" INT_P_STATEID,INT_P_COUNTRYID,INT_P_PINCODE,CHR_P_PHONE,CHR_C_ADD1,CHR_C_ADD2,INT_C_CITYID, ";
sql = sql+" INT_C_DISTRICTID,INT_C_STATEID,INT_C_COUNTRY,INT_C_PINCODE,CHR_C_PHONE,CHR_REPTO,CHR_PAN, ";
sql = sql+" CHR_PASSPORT,CHR_DRIVING,CHR_PERMAILID,CHR_PREVIOUSDETAILS,CHR_USERNAME,DT_UPDATEDATE,CHR_USERSTATUS ";
sql = sql+" FROM com_m_contractstaff  WHERE  INT_CONTRACTID="+staffid+"";  
String data[][]= CommonFunctions.QueryExecute(sql);
if(data.length>0)
	for(int u=0;u<42;u++)
		if( "-".equals(data[0][u]) )
			data[0][u] ="";

%></div></td>
                        </tr>
                        <tr>
                          <td colspan="2"><div align="right"><font class="bolddeepred" align="absmiddle">*</font><span class="changePos">Mandatory</span></div></td>
                        </tr>
                      <tr></tr>
                        <tr>
                          <td colspan="2">&nbsp;</td>
                        </tr>
                        <tr>
                          <td colspan="2"></td>
                        </tr>
                        <tr>
                          <td height="19" colspan="2">
						  
						  
						<fieldset>
			<legend><strong>&nbsp;&nbsp;&nbsp;<img src="../images/icon-misuse.gif">&nbsp;&nbsp;&nbsp;OFFICIAL INFORMATIONS&nbsp;&nbsp;&nbsp;</strong> </legend>


            <table width="100%" border="0" align="center" cellpadding="2"
												cellspacing="2">
                                    <tr>
                                      <td width="50%" ><table width="100%" border="0" align="center"
														cellpadding="1" cellspacing="2" bordercolor="#D4D0C8"
														class="boldEleven">
														<tr>
                                          <td colspan="2" align="center" height="25"><strong>
                                            </strong></td>
                                        </tr>
                                        <tr>
                                          <td colspan="2" align="center" class="boldEleven"><strong>Personal
                                            Informations </strong></td>
                                        </tr>
                                        <tr>
                                          <td width="41%" class="boldEleven">Staff Name<font class="bolddeepred"
																align="absmiddle">* </font></td>
                                          <td width="59%"><input name="name" type="text" class="formText135" id="name"   onBlur="upperMe(this)"     tabindex="2" onBlur=" LoadUniqueCheck('name', 'namediv', 'com_m_contractstaff', 'CHR_STAFFNAME', 'submit_btn')" onKeyUp=" LoadUniqueCheck('name', 'namediv', 'com_m_contractstaff', 'CHR_STAFFNAME', 'submit_btn')" value="<%=data[0][1]%>"     size="30"
																maxlength="50"/>
                                          <div id="namediv"></div></td>
                                        </tr>
                                        <tr>
                                          <td class="boldEleven"><div id='solutename'>Father's /Spouse Name<font class="bolddeepred"
																align="absmiddle">*</font> </div></td>
                                          <td><input name="fname" type="text"
																class="formText135"  id="fname"   onBlur="upperMe(this)"     tabindex="3" value="<%=data[0][2]%>"  
																 size="30"
																maxlength="50"/></td>
                                        </tr>
                                        <tr>
                                          <td class="boldEleven">Gender</td>
                                          <td><table width="152" border="0" cellspacing="0"
																cellpadding="0"><%
										grd="";
										grd1="";
											if("Male".equals(data[0][3].trim()))
												grd ="checked='checked'";
									
											if("Female".equals(data[0][3].trim()))
											grd1 ="checked='checked'";
												 
										 
										   %>												
                                              <tr>
                                                <td width="20"><input name="gender"  id="gender" type="radio" <%=grd%>
																		value="Male" checked="checked" class="formText135" /></td>
                                                <td width="47" class="boldEleven">Male</td>
                                                <td width="26"><input name="gender"  id="gender" type="radio" <%=grd1%>
																		value="Female" class="formText135" /></td>
                                                <td width="59" class="boldEleven">Female</td>
                                              </tr>
                                          </table></td>
                                        </tr>
                                        <tr>
                                          <td class="boldEleven">Blood Group<font
																class="bolddeepred" align="absmiddle">*</font></td>
                                          <td><jsp:include page="../JavaScript/bloodgroup.jsp" flush="true" />                                            <script language="javascript">setOptionValue("bg","<%=data[0][8].trim()%>") </script>	                                    </td>
                                        </tr>
                                        <tr>
                                          <td class="boldEleven">Marital  Status
										  
										  <%
										grd="";
										grd1="";
											if("M".equals(data[0][6].trim()))
												grd ="checked='checked'";
									
											if("U".equals(data[0][6].trim()))
											grd1 ="checked='checked'";
												 
										 
										   %>										  </td>
                                          <td><table width="152" border="0" cellpadding="0"
																cellspacing="0" class="boldEleven">
                                              <tr>
                                                <td><input
																		name="marry" type="radio" value="M" id="marry" 
																		onClick="changeState1()"  <%=grd%>
																		class="formText135" /></td>
                                                <td class="boldEleven">Married</td>
                                                <td><input  <%=grd1%>
																		name="marry" type="radio" value="U" id="marry" 
																		onClick="changeState()" class="formText135" /></td>
                                                <td class="boldEleven">UnMarried</td>
                                              </tr>
                                          </table></td>
                                        </tr>
                                        <tr>
                                          <td class="boldEleven">Date Of Birth<font
																class="bolddeepred" align="absmiddle">*</font></td>
                                          <td>
										  
										  
										  
										  <input title="dd/mm/yyyy"  name="dob"  id="dob"  type="text" class="formText135" size="30" maxlength="10"  tabindex="5" readonly="readonly" value="<%=data[0][4]%>"/>
                                              <span class="boldred">(dd-mm-yyyy) </span></td>
                                        </tr>
                                        <tr id="cwd">
                                          <td class="boldEleven">Wedding Date										  </td>
                                          <td><input readonly="readonly"
																 
																title="dd/mm/yyyy"  
																name="wedding" type="text" class="formText135" id="wedding"
																size="30" maxlength="8" tabindex="6" value="<%=data[0][7]%>">
                                              <span class="boldred">(dd-mm-yyyy) </span></td>
                                        </tr>
                                        <tr>
                                          <td width="41%" class="boldEleven">Date Of Join
										 
										  <font
																class="bolddeepred" align="absmiddle">*</font></td>
                                          <td class="boldEleven"><input onKeyPress="numericHypenOnly('doj','9')"
																name="doj" id="doj"  type="text" class="formText135" size="30"
																maxlength="10" readonly="true"  
																title="dd/mm/yyyy"  tabindex="7" value="<%=data[0][5]%>"/>
                                              <script language="JavaScript" type="text/javascript">setCurrentDate('doj'); </script>
                                              <span class="boldred">(dd-mm-yyyy) </span></td>
                                        </tr>
                                        <tr>
                                          <td class="boldEleven">Per. E-mail<font
																class="bolddeepred" align="absmiddle">*</font></td>
                                          <td class="boldEleven"><input name="peremailid" type="text" class="formText135" id="peremailid" size="30"  maxlength="90" tabindex="9" value="<%=data[0][39]%>" />
                                              <div id='emaildiv'></div></td>
                                        </tr>
                                        <tr>
                                          <td valign="top" class="boldEleven">category<font
																class="bolddeepred" align="absmiddle">*</font></td>
                                          <td valign="top">
                                          <select id="category" name="category" class="formText135"  style="width:170"  tabindex="12">
                                            <option value="0">Select category</option>
                                           <%
	String empcategorysql=" SELECT INT_EMPLOYEECATEGORYID,CHR_CATEGORYNAME  FROM   com_m_employeecategory   ORDER BY CHR_CATEGORYNAME ";
	String empcategoryData[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(empcategorysql);
	if (empcategoryData.length>0)
		for (int i=0; i<empcategoryData.length; i++) 
			out.println("<option value="+empcategoryData[i][0]+">"+empcategoryData[i][1] +"</option>");			
	
						%>
                                          </select> <script language="javascript">setOptionValue("category","<%=data[0][14]%>") </script>                                          </td>
                                        </tr>
										
										
										
										
										
										
                                        
                                      </table></td>
                                      <td width="53%"><table width="100%" border="0" align="center"
														cellpadding="1" cellspacing="2" bordercolor="#D4D0C8"
														class="boldEleven">
                                          
                                          <tr>
                                            <td colspan="4" class="boldEleven"><div align="center"><strong>Official
                                              Details</strong></div></td>
                                          </tr>
                                          <tr>
                                            <td width="187" class="boldEleven">Company<font
																class="bolddeepred" align="absmiddle">*</font></td>
                                            <td width="250" colspan="3"><table width="150" border="0" cellspacing="0"
																cellpadding="0">
                                                <tr>
                                                  <!--onchange="loadBDStaff('')"-->
                                                  <td>
 <select name="company"  id="company" onBlur="loadBranch() " class="formText135"  style="width:170" tabindex="17">
                                                      <option value="0">Select Company</option>
                                                      <%
                                              String sql1="SELECT INT_COMPANYID,CHR_COMPANYNAME FROM  com_m_company  ORDER BY CHR_COMPANYNAME";
                                              String company[][]= CommonFunctions.QueryExecute(sql1);
                                              for(int i=0;i<company.length;i++){
                                            	  out.println("<option value="+company[i][0]+">"+company[i][1]+"</option>");		
                                              }
                                            %>
                                                    </select> <script language="javascript">setOptionValue("company","<%=data[0][9]%>") </script>	                                      </td>
                                                </tr>
                                            </table></td>
                                          </tr>
                                          <tr>
                                            <td width="187" class="boldEleven">Branch<font
																class="bolddeepred" align="absmiddle">*</font></td>
                                            <td colspan="3"><table width="150" border="0" cellspacing="0"
																cellpadding="0">
                                                <tr>
                                                  <td>
												  
												   <select name="branch"  id="branch" class="boldEleven"  style="width:170" tabindex="18">
                                           <option value="0" >Select Branch</option>
										    <%
	String Branchsql=" SELECT  INT_BRANCHID,CHR_BRANCHNAME FROM com_m_branch ORDER BY CHR_BRANCHNAME ";
	String BranchsqlData[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(Branchsql);
	if (BranchsqlData.length>0)
		for (int i=0; i<empcategoryData.length; i++) 
			out.println("<option value="+BranchsqlData[i][0]+">"+BranchsqlData[i][1] +"</option>");			
	
						%>
										   </select> <script language="javascript">setOptionValue("branch","<%=data[0][10]%>") </script> 
			 						      
                                                      <div id="description"></div></td>
                                                </tr>
                                            </table></td>
                                          </tr>
                                          <tr>
                                            <td bordercolor="#FF0000" class="boldEleven">Office<font
																class="bolddeepred" align="absmiddle">*</font></td>
                                            <td colspan="3"><table width="150" border="0" cellspacing="0"
																cellpadding="0">
                                                <tr>
                                                  <td><select name="off" class="formText135" id="off"  style="width:170" tabindex="21">
                                                      <option value="0">Select Office</option>
                                                      <%
        String offdata[][]= CommonFunctions.QueryExecute("SELECT INT_OFFICEID,CHR_OFFICENAME FROM   com_m_office   ORDER BY CHR_OFFICENAME");
for(int h=0;h<offdata.length;h++)
	out.print("<option value='"+offdata[h][0]+"'>"+offdata[h][1]+"</option>");

		
%>
                                                  </select><script language="javascript">setOptionValue("off","<%=data[0][11]%>") </script></td>
                                                </tr>
                                            </table></td>
                                          </tr>
                                          <tr>
                                            <td class="boldEleven">Department<font
																class="bolddeepred" align="absmiddle">*</font></td>
                                            <td colspan="3"><table width="150" border="0" cellspacing="0"
																cellpadding="0">
                                                <tr>
                                                  <td><select name="depart" class="formText135" id="depart"  style="width:170" tabindex="22">
                                                      <option value="0">Select Department</option>
                                                      <%
      	String depdata[][]= CommonFunctions.QueryExecute("SELECT INT_DEPARTID,CHR_DEPARTNAME FROM  com_m_depart  ORDER BY CHR_DEPARTNAME");
	for(int h=0;h<depdata.length;h++)
		out.print("<option value='"+depdata[h][0]+"'>"+depdata[h][1]+"</option>");

		
%>
                                                  </select><script language="javascript">setOptionValue("depart","<%=data[0][12]%>") </script></td>
                                                </tr>
                                            </table></td>
                                          </tr>
                                          <tr>
                                            <td class="boldEleven">Designation<font
																class="bolddeepred" align="absmiddle">*</font><font
																class="redcol style3" align="absmiddle">&nbsp;</font></td>
                                            <td colspan="3"><table width="150" border="0" cellspacing="0"
																cellpadding="0">
                                                <tr>
                                                  <td><select name="desig" class="formText135" id="desig"  style="width:170" tabindex="23">
                                                      <option value="0">Select Designation</option>
                                                      <%
         		String desgdata[][]= CommonFunctions.QueryExecute("SELECT INT_DESIGID,CHR_DESIGNAME FROM  com_m_desig  ORDER BY CHR_DESIGNAME");
			for(int h=0;h<desgdata.length;h++)
				out.print("<option value='"+desgdata[h][0]+"'>"+desgdata[h][1]+"</option>");
			

		
%>
                                                  </select><script language="javascript">setOptionValue("desig","<%=data[0][13]%>") </script></td>
                                                </tr>
                                            </table></td>
                                          </tr>
                                          <tr id="bid">
                                            <td class="boldEleven">Salary</td>
                                            <td colspan="3">
<input name="basic" type="text" class="formText135" id="basic" tabindex="25" onKeyPress="return numeric_only(event,'basic','13')" value="<%=data[0][15]%>" size="30" 																maxlength="12"  onpaste="return false;"></td>
                                          </tr>
                                           
                                          <tr>
                                            <td class="boldEleven">Bank Name<font
																class="bolddeepred" align="absmiddle">*</font></td>
                                            <td colspan="3"> 
                                                <select name="bank" class="formText135" id="bank"  style="width:170" tabindex="27">
                                                  <option value="0">Select Bank Name</option>
                                                  <%
                  out.println("<option value='1'>No Bank</option>");	
						String query="SELECT a.INT_BANKID, b.CHR_BANKGROUPNAME FROM com_m_bank a, com_m_bankgroup b WHERE a.INT_BANKGROUPID=b.INT_BANKGROUPID  ORDER BY  b.CHR_BANKGROUPNAME";
                  		String datas[][]= CommonFunctions.QueryExecute(query);
                  		if (datas.length>0){
                  			for (int i=0; i<datas.length; i++) {
								out.println("<option value="+datas[i][0]+">"+datas[i][1]+"</option>");			
                  			}
                  		}
				%>
                                              </select><script language="javascript">setOptionValue("bank","<%=data[0][16]%>") </script></td>
                                          </tr>
                                          <tr>
                                            <td width="187" class="boldEleven">Account No </td>
                                            <td colspan="3"><input name="no" type="text" class="formText135" id="no" size="30"  maxlength="20"   value="<%=data[0][17]%>"  onkeyup="checkAccounts(this) "   onBlur="upperMe(this)"    tabindex="28" />
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
			LoadUniqueCheck('no', 'acc', 'com_m_contractstaff', 'CHR_ACCNO', 'submit_btn')
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
                                                <!--CheckUnique(ctr,'acc','com_m_staff','CHR_ACCNO') ;-->
                                                <div id="acc"></div>
                                                <span class="boldred">A/c no does'nt have, Put DD												</span></td>
                                          </tr>
                                          <tr>
                                            <td class="boldEleven">IFSC CODE </td>
                                            <td colspan="3"><input name="ifsccode" type="text"
																class="formText135" id="ifsccode"
																  size="30"   onBlur="upperMe(this)"   
																maxlength="20"  tabindex="29" value="<%=data[0][18]%>"/></td>
                                          </tr>
                                          <tr>
                                            <td height="16" class="boldEleven" valign="top">Reporting to<font
																class="bolddeepred" align="absmiddle">*</font></td>
                                            <td colspan="3" valign="top"><select id="repto" name="repto" class="formText135"  style="width:170"  tabindex="12">
                                              <option value="0">Select Reporting to</option>
                                              <%
		   String rptodata[][] =CommonFunctions.QueryExecute("select CHR_EMPID,CHR_STAFFNAME from com_m_staff WHERE CHR_TYPE<>'T'  AND CHR_REP='Y' ");
		   for(int c=0;c<rptodata.length;c++)
		   		out.println("<option value='"+rptodata[c][0]+"'>"+rptodata[c][1]+"</option>");
		   %>
                                          </select>                                          <script language="javascript">setOptionValue("repto","<%=data[0][35]%>") </script></td>
                                          </tr>  
										  <tr>
                                            <td height="16" class="boldEleven" valign="top">&nbsp;</td>
                                            <td colspan="3" valign="top"></td>
                                          </tr>
										  
                                      </table></td>
                                    </tr>
                          </table>
</fieldset>						  </td>
                        </tr>
                        <tr>
                          <td width="50%" height="19">&nbsp;</td>
                          <td width="50%">&nbsp;</td>
                        </tr>
                        <tr>
                          <td height="19" colspan="2">
						  
						  
						  
						  <fieldset>
			<legend><strong>&nbsp;&nbsp;&nbsp;<img src="../images/icon-misuse.gif">&nbsp;&nbsp;&nbsp;  CONTACT INFORMATIONS&nbsp;&nbsp;&nbsp;</strong> </legend>


            <table width="100%" border="0" align="center" cellpadding="2"
												cellspacing="2">
                                     
                                    <tr>
                                      <td width="50%" height="210"><table width="100%" border="0" align="center"
														cellpadding="1" cellspacing="2">
                                          <tr>
                                            <td height="15" colspan="2" class="boldEleven"><div align="center"><strong>Permanent
                                              Address</strong></div></td>
                                          </tr>
                                           
                                          <tr>
                                            <td width="147" class="boldEleven">Address1<font
																class="bolddeepred" align="absmiddle">*</font></td>
                                            <td width="227" class="boldEleven"><input name="padd1"
																type="text" class="formText135" id="padd1"
																onkeypress="isAddress('pad1','50')" size="30"
																maxlength="50"    onBlur="upperMe(this)"    tabindex="32" value="<%=data[0][19]%>"/></td>
                                          </tr>
                                          <tr>
                                            <td class="boldEleven">Address2<font
																class="bolddeepred" align="absmiddle">*</font></td>
                                            <td class="boldEleven"><input name="padd2"    onBlur="upperMe(this)"   
																type="text" class="formText135" id="padd2"
																onkeypress="isAddress('pad2','50')" size="30"
																maxlength="50"  tabindex="33" value="<%=data[0][20]%>"/></td>
                                          </tr>
                                          <tr>
                                            <td class="boldEleven">Location<font
																class="bolddeepred" align="absmiddle">*</font></td>
                                            <td class="boldEleven"> 											
											<select name="pcity" class="formText135" id="pcity"  style="width:170" onChange="PAssignPincode('ppincode')"  tabindex="38" >
                                                <option value="0" selected="selected">Select City</option>
												<%


String cityData[][] =  CommonFunctions.QueryExecute("SELECT INT_CITYID,CHR_CITYNAME FROM com_m_city WHERE INT_DISTRICTID=" +data[0][22]);
if(cityData.length>0)
	for(int u=0;u<cityData.length;u++)
		out.print("<option value='"+cityData[u][0]+"'>"+cityData[u][1]+"</option>");

%>
                                              </select>
											  <script language="javascript">setOptionValue('pcity','<%=data[0][21]%>') </script>										    </td>
                                          </tr>
                                          <tr>
                                            <td class="boldEleven">District<font
																class="bolddeepred" align="absmiddle">*</font></td>
                                            <td class="errormessage"><select name="pdistrict" class="formText135" id="pdistrict"  style="width:170" onChange=" PLoadSelectCity()" tabindex="37">
                                                <option value="0" selected="selected">Select District</option>
												<%
String	districtData[][]= CommonFunctions.QueryExecute("SELECT INT_DISTRICTID,CHR_DISTRICT  FROM com_m_district WHERE  INT_STATEID="+data[0][23]+"  ORDER BY CHR_DISTRICT  ");
if(districtData.length>0)
	for(int u=0;u<districtData.length;u++)
		out.println("<option value='"+districtData[u][0]+"'>"+districtData[u][1]+"</option>");
															  %>
												
                                              </select><script language="javascript">setOptionValue("pdistrict","<%=data[0][22]%>") </script></td>
                                          </tr>
                                          <tr>
                                            <td class="boldEleven">State
                                                <font
																class="bolddeepred" align="absmiddle">*</font></td>
                                            <td class="boldEleven">
                                            <select name="pstate" class="formText135" id="pstate"  style="width:170" onChange="PLoadSelectDistrict()" tabindex="36">
                                                      <option value="0" selected="selected">Select State</option>
													  
													  <%
String	stateData[][]= CommonFunctions.QueryExecute("SELECT INT_STATEID,CHR_STATENAME FROM com_m_state WHERE INT_COUNTRYID ="+data[0][24]+" ORDER BY CHR_STATENAME");
if(stateData.length>0)
	for(int u=0;u<stateData.length;u++)
		out.println("<option value='"+stateData[u][0]+"'>"+stateData[u][1]+"</option>");
																	%>
                                            </select><script language="javascript">setOptionValue("pstate","<%=data[0][23]%>") </script></td>
                                          </tr>
                                          <tr>
                                            <td class="boldEleven">Country<font
																class="bolddeepred" align="absmiddle">*</font></td>
                                            <td class="boldEleven"><select name="pcountry" class="formText135" id="pcountry"  style="width:170" onChange="PLoadSelectState()" tabindex="35">
                                                <option value="0">Select Country</option>
                                                <%
	 		String creadData[][]=  CommonFunctions.QueryExecute("SELECT INT_COUNTRYID ,CHR_COUNTRYNAME FROM  com_m_country ORDER BY CHR_COUNTRYNAME");
			if(creadData.length>0)
				for(int i=0;i<creadData.length;i++)
					out.println("<option value='"+creadData[i][0]+"'>"+creadData[i][1]+"</option>");
	 %>
                                              </select>
											  <script language="javascript">setOptionValue("pcountry","<%=data[0][24]%>") </script>										    </td>
                                          </tr>
                                          <tr>
                                            <td class="boldEleven">Pin Code<font
																class="bolddeepred" align="absmiddle">*</font></td>
                                            <td class="boldEleven">
	<input name="ppincode" type="text" class="formText135" id="ppincode" onKeyPress="return numeric_only(event,'ppincode','8')" size="30" 									maxlength="7"    onKeyUp="lookup(this.value);"  tabindex="34" value="<%=data[0][25]%>"/>
	<br />
		<div class="suggestionsBox" id="suggestions" style="display: none;width:150%;">
					<div class="suggestionList" id="autoSuggestionsList" style="OVERFLOW:auto;width:100%;height:200px" ></div>
		</div></td>
                                          </tr>
                                          <tr>
                                            <td class="boldEleven">Phone No</td>
                                            <td class="boldEleven"><input name="pphone"
																type="text" class="formText135" id="pphone"
																onkeypress="return numeric_only(event,'pphone','12')" size="30"
																maxlength="10" tabindex="39" value="<%=data[0][26]%>"/></td>
                                          </tr>
                                      </table></td>
                                      <td width="50%"><table width="100%" border="0" align="center"
														cellpadding="1" cellspacing="2">
                                          <tr>
                                            <td colspan="2" class="boldEleven"><div align="center"><strong>Communication
                                              Address</strong></div></td>
                                          </tr>
                                           
                                          <tr>
                                            <td width="180" class="boldEleven">Address1<font class="bolddeepred"
																align="absmiddle">*</font></td>
                                            <td class="boldEleven"><input name="cadd1"
																type="text" class="formText135" id="cadd1"
																onkeypress="isAddress('cadd1','50')" size="30"
																maxlength="50"     onBlur="upperMe(this)"    tabindex="41" value="<%=data[0][27]%>"/></td>
                                          </tr>
                                          <tr>
                                            <td class="boldEleven">Address2<font class="bolddeepred"
																align="absmiddle">*</font></td>
                                            <td class="boldEleven"><input name="cadd2"
																type="text" class="formText135" id="cadd2"
   onBlur="upperMe(this)"   
																onkeypress="isAddress('cadd2','50')" size="30"
																maxlength="50" tabindex="42" value="<%=data[0][28]%>"/></td>
                                          </tr>
                                          <tr>
                                            <td class="boldEleven">Location<font class="bolddeepred"
																align="absmiddle">*</font></td>
                                            <td class="boldEleven"><select name="ccity" class="formText135" id="ccity"  style="width:170" onChange="CAssignPincode('cpincode')" tabindex="47">
                                                <option value="0" selected="selected">Select City</option>
												
												
												<%


String cityData1[][] =  CommonFunctions.QueryExecute("SELECT INT_CITYID,CHR_CITYNAME FROM com_m_city WHERE INT_DISTRICTID=" +data[0][30]);
if(cityData1.length>0)
	for(int u=0;u<cityData1.length;u++)
	out.print("<option value='"+cityData1[u][0]+"'>"+cityData1[u][1]+"</option>");

%>
												
                                              </select>   <script language="javascript">setOptionValue('ccity','<%=data[0][29]%>') </script>                                         </td>
                                          </tr>
                                          <tr>
                                            <td class="boldEleven">District<font class="bolddeepred"
																align="absmiddle">*</font></td>
                                            <td class="boldEleven"><select name="cdistrict" class="formText135" id="cdistrict"  style="width:170" onChange=" CLoadSelectCity()" tabindex="46">
                                                <option value="0" selected="selected">Select District</option>
												<%

String	districtData1[][]= CommonFunctions.QueryExecute("SELECT INT_DISTRICTID,CHR_DISTRICT  FROM com_m_district WHERE  INT_STATEID="+data[0][31]+"  ORDER BY CHR_DISTRICT  ");
if(districtData1.length>0)
	for(int u=0;u<districtData1.length;u++)
		out.println("<option value='"+districtData1[u][0]+"'>"+districtData1[u][1]+"</option>");
															  %>
												
                                              </select>  <script language="javascript">setOptionValue('cdistrict','<%=data[0][30]%>')</script> 	                                          </td>
                                          </tr>
                                          <tr>
                                            <td class="boldEleven">State <font class="bolddeepred"
																align="absmiddle">*</font></td>
                                            <td class="boldEleven">
                                              <select name="cstate" class="formText135" id="cstate"  style="width:170" onChange="CLoadSelectDistrict()" tabindex="45">
                                                <option value="0" selected="selected">Select State</option>
												
												
												<%
String	stateData1[][]= CommonFunctions.QueryExecute("SELECT INT_STATEID,CHR_STATENAME FROM com_m_state WHERE INT_COUNTRYID ="+data[0][32]+" ORDER BY CHR_STATENAME");
if(stateData1.length>0)
	for(int u=0;u<stateData1.length;u++)
		out.println("<option value='"+stateData1[u][0]+"'>"+stateData1[u][1]+"</option>");
																	%>
                                            </select><script language="javascript">setOptionValue('cstate','<%=data[0][31]%>')</script></td>
                                          </tr>
                                          <tr>
                                            <td class="boldEleven">Country<font class="bolddeepred"
																align="absmiddle">*</font></td>
                                            <td class="boldEleven"><select name="ccountry" class="formText135" id="ccountry"  style="width:170" onChange="CLoadSelectState()" tabindex="44">
                                                <option value="0">Select Country</option>
                                                <%
	 		if(creadData.length>0)
				for(int i=0;i<creadData.length;i++)
					out.println("<option value='"+creadData[i][0]+"'>"+creadData[i][1]+"</option>");
	 %>
                                              </select>   <script language="javascript">setOptionValue('ccountry','<%=data[0][32]%>')</script>                                         </td>
                                          </tr>
                                          <tr>
                                            <td class="boldEleven">Pin Code<font class="bolddeepred"
																align="absmiddle">*</font>											</td>
                                            <td class="boldEleven">
											
<input name="cpincode" type="text" class="formText135" id="cpincode" onKeyPress="return numeric_only(event,'cpincode','8')" size="30" maxlength="7"  onKeyUp="clookup(this.value);"  tabindex="43" value="<%=data[0][33]%>"/>

  <div class="suggestionsBox1" id="suggestions1" style="display: none;width:150%;">
					<div class="suggestionList1" id="autoSuggestionsList1" style="OVERFLOW:auto;width:100%;height:200px" ></div>
</div></td>
                                          </tr>
                                          <tr>
                                            <td class="boldEleven">Phone No</td>
                                            <td class="boldEleven"><input name="cphone"
																type="text" class="formText135" id="cphone"
																onkeypress="return numeric_only(event,'cphone','12')" size="30"
																maxlength="10" value="<%=data[0][34]%>"/></td>
                                          </tr>
                                      </table></td>
                                    </tr>
                                    <tr>
                                      <td height="38" colspan="2"><table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
                            <tr>
                                            <td width="660" height="28"><div align="center"><span class="boldEleven">Copy
                                              Permanent to Communication
                                              Address
                                              <input name="res" type="radio" class="formText135" onClick="return resoffval()"
														value="yes"   tabindex="40"/>
                                              Yes
  <input name="res"
														type="radio" class="formText135" onClick="return resoffval()" value="no" />
                                          No </span></div></td>
                                          <td width="114">                                          </td>
                                        </tr>
                                        </table></td>
                                    </tr>
                          </table>
</fieldset>						  </td>
                        </tr>
                        <tr>
                          <td height="19" colspan="2"></td>
                        </tr>
                        <tr>
                          <td height="19" colspan="2">						  </td>
						  </tr>
						<tr>
                          <td height="19" colspan="2">
						  
						  <fieldset>
			<legend><strong>&nbsp;&nbsp;&nbsp;<img src="../images/icon-misuse.gif">&nbsp;&nbsp;&nbsp;ADDRESS PROOF INFORMATIONS&nbsp;&nbsp;&nbsp;</strong> </legend>


            <table width="100%" border="0" align="center" cellpadding="2"
												cellspacing="2">
                                    <tr>
                                      <td width="48%" height="22">&nbsp;</td>
                                      <td width="52%">&nbsp;</td>
                                    </tr>
                                    <tr>
                                      <td><table width="100%" border="0" align="center">
                                          <tr>
                                            <td width="42%" class="boldEleven">PAN Number</td>
                                            <td width="58%"><input name="pannumber" type="text" class="formText135" id="pannumber" onKeyUp=" LoadUniqueCheck('pannumber', 'pandiv', 'com_m_contractstaff', 'CHR_PAN', 'submit_btn')" size="30" maxlength="20"  tabindex="58"    onBlur="upperMe(this)"    value="<%=data[0][36]%>"/>
                                            <div id="pandiv"></div></td>
                                          </tr>
                                          <tr>
                                            <td class="boldEleven">PASS PORT Number</td>
                                            <td><input name="passportnumber" type="text" class="formText135" id="passportnumber" onKeyUp=" LoadUniqueCheck('passportnumber', 'passportnumberdiv', 'com_m_contractstaff', 'CHR_PASSPORT', 'submit_btn')" size="30" maxlength="20"  tabindex="59"   onBlur="upperMe(this)"    value="<%=data[0][37]%>"/>
                                                <div id="passportnumberdiv"></div></td>
                                          </tr>
                                          <tr>
                                            <td class="boldEleven">DRIVING LICENSE Number</td>
                                            <td><input name="drivingnumber" type="text" class="formText135" id="drivingnumber" onKeyUp=" LoadUniqueCheck('drivingnumber', 'drivingdiv', 'com_m_contractstaff', 'CHR_DRIVING', 'submit_btn')" size="30" maxlength="20"  tabindex="60"   onBlur="upperMe(this)"    value="<%=data[0][38]%>"/>
                                                <div id="drivingdiv"></div></td>
                                          </tr>
                                      </table></td>
                                      <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                                          <tr>
                                            <td width="34%" class="boldEleven">Previous Details </td>
                                            <td width="66%" rowspan="3" align="left" valign="top"><textarea name="previousdetails"  onkeyup="textArea('previousdetails','2000')"    onBlur="upperMe(this)"     cols="26" rows="5" class="formText135" id="previousdetails"   tabindex="61"><%=data[0][40]%></textarea></td>
                                          </tr>
                                          <tr>
                                            <td>&nbsp;</td>
                                          </tr>
                                          <tr>
                                            <td>&nbsp;</td>
                                          </tr>
                                      </table></td>
                                    </tr>
                                    
                                    <tr>
                                      <td colspan="2" class="boldEleven"></td>
                                    </tr>
                                    <tr>
                                      <td>&nbsp;</td>
                                      <td>&nbsp;</td>
                                    </tr>
                          </table>
</fieldset>						  </td>
                        </tr>
                        <tr>
                          <td height="19">&nbsp;</td>
                          <td><input name="filename" type="hidden" id="filename" value="ContractStaff" />
                              <input name="actionS" type="hidden" id="actionS" value="MGTContractStaffEdit" />
							  <input type="hidden" name="staffid" id ="staffid" value="<%=staffid%>" />							  </td>
                        </tr>
                        <tr>
                          <td height="19" colspan="2"><table border="0" align="center" cellpadding="2"
										cellspacing="2">
                              <tr>
                                <td width="56"><input type="submit" name="Submit"
												id="submit_btn" class="buttonbold" value="Update" tabindex="62"/></td>
                                <td width="56"> 
                                    <input type="button" name="submit" class="buttonbold"
												 value="Close"   accesskey="c" 
												onclick="redirect('ContractorRegistrationView.jsp')"   tabindex="63"/></td>
                              </tr>
                          </table></td>
                        </tr>
                    </table></td>
                    <td nowrap="nowrap" width="5"><spacer height="1" width="1" type="block" /></td>
                    <td class="BorderLine" width="2"><spacer height="1" width="1"
								type="block" /></td>
                  </tr>
                  <tr>
                    <td colspan="2" rowspan="2"><img height="7"
								src="../Image/General/BLCorner.gif" width="7" /></td>
                    <td height="6"><spacer height="1" width="1" type="block" /></td>
                    <td colspan="2" rowspan="2" valign="bottom"><div align="right"><img height="7"
								src="../Image/General/BRCorner.gif" width="7" /></div></td>
                  </tr>
                  <tr>
                    <td class="BorderLine" height="1"><spacer height="1" width="1"
								type="block" /></td>
                  </tr>
                </tbody>
              </table></td>
				<td width="113" valign="top">
				
				
				
				 
				</td>
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
		<td>
		

		</td>
	</tr>
</table>
<%@ include file="../footer.jsp"%>
 

</body>
</form>
</html>
