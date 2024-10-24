<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonInfo"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
%>

<jsp:useBean id="conbean" class="DBConnection.DBCon"></jsp:useBean>
<%!
	Connection con ;
	PreparedStatement pstm;
	ResultSet rst;
	String userid;
	
%>
<%
 
String shortdata[][] =CommonFunctions.QueryExecute("SELECT CHR_SHORTNAME FROM com_m_company WHERE CHR_SHORTNAME is not null ORDER BY INT_COMPANYID");
String shortname="";
for(int u=0;u<shortdata.length;u++)
	shortname = shortname+shortdata[u][0]+",";

//String dojlock =CommonFunctions.QueryExecute("SELECT CHR_DOJLOCK FROM M_INSTITUTION  WHERE INT_ID=1")[0][0];
//365 * 50 = 18250


String dojlock =CommonFunctions.QueryExecute("SELECT if(CHR_FIRSTTIMEAUTOMATE='Y' ,'18250',CHR_DOJLOCK)  FROM M_INSTITUTION  WHERE INT_ID=1")[0][0];


%>

 
<head>
<script language="JavaScript" src="../JavaScript/comfunction.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/AJAXFunctionStaff.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/commonAJAX.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/Attendance/AttendanceAjax.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/AJAX.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/common/PermanentSelectChangesCountry.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/common/communicationSelectChangesCountry.js" type="text/javascript"></script>
<script language="javascript" src="../JavaScript/smartcommon/BranchLoadAjax.js"></script>
<script language="javascript" src="../JavaScript/smartcommon/StaffRegistrationUniqueAjax.js"></script>
 
<script language="JavaScript" src="../JavaScript/jquery/jquery-1.7.1.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/jquery/ui/jquery.ui.core.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/jquery/ui/jquery.ui.widget.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js" type="text/javascript"></script>

 
	
	
<script>
		
	var d1=new Date();
	var day1=d1.getDate();	
	var dojlock= "<%=dojlock%>";
	 
	dojlock =190;
	
	$(function() {
		var dates = $( "#doj, #pfesidate" ).datepicker({
			defaultDate: "+1w",
			changeMonth: true,
			changeYear: true,
			minDate: -dojlock, maxDate: "+10D" ,showOn: "button",
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
			buttonImageOnly: true,
			onSelect: function(selected,evnt) 
				{
         			StaffRegistrationUnique();
    			}
			 
				});
		
		
	}
	 
	); 
	 
	
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
	//setTimeout("$('#suggestions').hide();", 200);
	$('#suggestions').hide();
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
	//setTimeout("$('#suggestions1').hide();", 200);
	$('#suggestions1').hide();
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
	if(document.frm.res[0].checked==true)
	{
		document.frm.cadd1.value = document.frm.padd1.value;
		document.frm.cadd2.value = document.frm.padd2.value;
		copyDropdown('pcity','ccity');
		copyDropdown('pstate','cstate');
		copyDropdown('pdistrict','cdistrict');
		
		document.frm.ccountry.selectedIndex = document.frm.pcountry.selectedIndex;
		document.frm.cstate.selectedIndex = document.frm.pstate.selectedIndex+1;
		document.frm.cdistrict.selectedIndex = document.frm.pdistrict.selectedIndex+1;
		document.frm.ccity.selectedIndex = document.frm.pcity.selectedIndex+1;
		document.frm.cpincode.value = document.frm.ppincode.value;
		document.frm.cphone.value = document.frm.pphone.value;
	}         
	else 
	{
		document.frm.cadd1.value = "";
		document.frm.cadd2.value = "";
		var _targ1=document.getElementsByName('ccity')[0];       
		_targ1.options.length=0;
		_targ1.options[0]=new Option('Select City','0');  
		
		_targ1=document.getElementsByName('cdistrict')[0];       
		_targ1.options.length=0;
		_targ1.options[0]=new Option('Select District','0');  
		
		
		_targ1=document.getElementsByName('cstate')[0];       
		_targ1.options.length=0;
		_targ1.options[0]=new Option('Select State','0');  
		
		 
			 
		document.frm.ccity.selectedIndex = 0;
		document.frm.cdistrict.selectedIndex = 0;
		document.frm.cstate.selectedIndex = 0;
		document.frm.ccountry.selectedIndex = 0;
		document.frm.cpincode.value = "";
		document.frm.cphone.value = "";
		
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
 
 
 
 
 function checkDobWeddingDifference(ctr ,ctr1)
 {
 	try
	{
		 var v =document.getElementById('mtype').value;
		 var v1 = document.getElementById(ctr).value;
		 var v2 = document.getElementById(ctr1).value;
		 if(v="M" && v1 !="" && v2 !="")
		 {
		 	var d1 = v1.split("-");
			var d2 = v2.split("-");
			var diff = parseInt(d1[2])+parseInt(14);
			if(d2[2]<diff)
			{
				alert("Wedding Age must be over 14 years...");
				document.getElementById(ctr).focus();
				return false;
			}
			else
				return true;	
		 }
		 	return true;
		 
		 
	}
	catch(err)
	{
		alert(ctr+" -  not found.     error : "+err);
		return false;
	}
 }
 
 
function checkDobDojDifference(ctr ,ctr1)
 {
 	try
	{
		 var v1 = document.getElementById(ctr).value;
		 var v2 = document.getElementById(ctr1).value;
		 if(v1 !="" && v2 !="")
		 {
		 	var d1 = v1.split("-");
			var d2 = v2.split("-");
			var diff = parseInt(d1[2])+parseInt(18);
			if (d2[2]<diff)
			{
				alert("Date of Joining must be above 18 years from Date of Birth...");
				document.getElementById(ctr).focus();
				return false;
			}
			else
				return true;	
		 }
		 	return false;
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
 
 
 		

function checkPFNomineeRelationship()
{
	try
	{
		var pf =document.getElementById('pf').value;
		if(pf =="Y" || pf =="C")
		{
			if( checkNull('nominee','Enter the nominee name') 
				&& checkNullSelect('pfnomineerelationship','Select pf nominee relation ship','0')
			  )
			  return true;
			else
				return false;	
		}
		return true;
	}
	catch(err)
	{
		alert( "  error : "+err);
		return false;
	}
}

	
function validateFields()
{
	try
	{
	 
		//StaffRegistrationUnique();
		
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
				 && checkNull('mothername','Enter Mother Name...') 
				 && checkNull('dob','Enter Date of Birth')
				 && duplicateCheck()
				 && checkNullSelect('bg','Select Blood Group','0')
				 && checkNull('dob','Enter Date of Birth')
				 && checkNull('doj','Enter Date of Joining')
				 && checkWedding('mtype')
				 && checkDobWeddingDifference('dob','wedding')
				 && checkDobDojDifference('dob','doj')
				 && checkSpouseName()
				 && checkNullSelect('company','Select Company Name','0')
				 && checkNull('branch','Enter Branch Name')
				 && checkNullSelect('branch','Select Branch Name','0')
				 && checkNullSelect('off','Select Office Name','0')  
				 && checkNullSelect('location','Select location','0')  
				 && checkNullSelect('depart','Select Department Name','0')
				 && checkNullSelect('desig','Select Designation Name','0')
				 && checkNullSelect('stype','Select Staff Type','0')
				 && checkNull('basic','Enter the basic')
				 && checkNull('gross','Enter the gross') 
				
				 && checkNull('peremailid','Enter the personal E-mail id...')
				 && chkemail1("peremailid",'Entert the correct E-mail Address...')
				 && chkemail1("emailid",'Entert the correct Office E-mail Address...')
				 && checkNull('mobile','Enter the mobile number') 
				 
				 && basic_Gross_check()
				 && checkNullSelect('qualification','Select qualification','0')
				 && checkNullSelect('repto','Select Reporting to... ','0')
				 && checkNullSelect('bank','Select Bank','0')
				 
				 //&& staffPhotoCheck()
				 && checkNull('f1','Kindly select the photo Select Staff Photo')
				 
				 
				 && checkNullSelect('category','Select category','0')
				 && checkNullSelect('attendancecycle','Select Attendance cycle','0')
				 && rejoincheckNull()
				 
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
				 && checkNullSelect('cdistrict','Select  Communication  District  Name','0')
				 && checkNullSelect('off','Select Office Name','0')   	
				 && checkNullSelect('depart','Select Department Name','0')
				 && checkNullSelect('desig','Select Designation Name','0')
				 && checkNullSelect('company','Select Company Name','0')
				 && checkNull('branch','Enter Branch Name')
				 && checkNullSelect('qualification','Select qualification','0')
				 && checkNullSelect('repto','Select Reporting to... ','0')
				 && checkNullSelect('bank','Select Bank','0')
				 && checkNullSelect('bg','Select Blood Group','0')
				 && checkNullSelect('category','Select category','0')
				 && checkNullSelect('attendancecycle','Select Attendance cycle','0')
				 && checkNullSelect('stype','Select Salarytype','0')
				 && checkNullSelect('pf','SELECT PF ','0')
				 && checkNullSelect('esi','SELECT esi','0')
				 && checkPFNomineeRelationship()  
				 && checkNull('gross','Enter the gross') 
				 && consolidateCheck()
			)
			{
				  if (confirm("Once again confirm to submit the staff registration "))
					return true;
				 else
				 {
				 	 
				 	return false;
				 }	
				//document.getElementById('Submit').disabled=true;
				//return true;
			}	
			else
			{
				//document.getElementById('Submit').disabled=false;
				 
				return false;	  
			}
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
	
 	
function  staffPhotoSize()
{
	try
	{
		var filesize = document.getElementById('filesize').value ;
		if( filesize <= 40960)
			return true;
		else
		{
			alert("Kindly select file size is 40Kb");
			return false;
		}
	}
	catch(err)
	{
		alert(err);
		return false;
	}
}
	
	
	
function staffPhotoCheck()
{
	try
	{  		 
		if(   checkNull('f1','Select Photo ') &&  findSize('f1','File should be less than 40Kb')  )
  		{
			var file = document.getElementById("f1").value;
			var fileExtn = file.lastIndexOf(".");
			var Extn=file.substring(fileExtn);
			if((Extn == ".GIF") ||(Extn == ".gif") ||(Extn == ".jpeg") ||(Extn == ".JPEG") ||(Extn == ".JPG") ||(Extn == ".jpg") ||(Extn == ".BMP") ||(Extn == ".bmp"))
			{
				return true;
			}
			else
			{
				alert("Only possible JPEG,GIF,BMP only");
				return false;
			}
		}
   		else
		{
   			
			return false;
  		}
	}
	catch(err)
	{
		alert(err);
		return false;
	}	
}  
	
function findSize(ctr,msg) 
{
    var fileInput =  document.getElementById(ctr);
    try
	{
		var s = parseInt(fileInput.files[0].size);
		// 1 MB = 1048579 bytes  20kb = 20480
		if( s <= 40960)
			return true;
		else
		{
			alert(msg);
			return false;
		}	
        //alert(fileInput.files[0].size); // Size returned in bytes.
    }
	catch(e)
	{
        var objFSO = new ActiveXObject("Scripting.FileSystemObject");
        var e = objFSO.getFile( fileInput.value);
        var fileSize = e.size;
        if( parseInt(fileSize)  <= 40960)
			return true;
		else
		{
			alert("Kindly check with photo size " +fileSize);
			return false;
		}	  
		 
    }
}



	
	
	
	function consolidateCheck()
	{
		var f = true;
		if(checkSalaryType())
			f = checkSalaryBand();
		
		return f;	
	}
	
    
 

 
//-->
</script>


<title> :: COMMON ::</title>


 
<script language="JavaScript" src="../JavaScript/calendar1.js" type="text/javascript"> </script>

 <link href="../JavaScript/SmartStyles.css" rel="stylesheet" type="text/css" />
 <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
 <style type="text/css">
<!--
.style1 {color: #ECE9D8}
-->
 </style>
</head>

<script language="javascript">


 
function loadLocations(ctr)
{
   	var url = "../SmartCommonAjax?actionS=loadlocationActive&startLetter=0&officeid="+ctr.value;
	initRequest(url);
	req.onreadystatechange =loadLocationsRequest;
    req.open("GET", url, true);
    req.send(null);
}

function loadLocationsRequest() 
{
    if(req.readyState == 4) 
    {    
        
       var _targ=document.getElementsByName('location')[0];       
	   _targ.options.length=0;	
       _targ.options[0]=new Option('Select location','0');       
        if (req.status == 200) 
        {
        	loadLocationsDetails();
        }
    }
}

function loadLocationsDetails() 
{
	try
	{
		var batchs = req.responseXML.getElementsByTagName("Rowss")[0];      
		var _targ=document.getElementsByName('location')[0];       
		 _targ.options.length=0;
		 _targ.options[0]=new Option('Select location','0');
		 for (loop = 0; loop < batchs.childNodes.length; loop++) 
		 {
			var batch = batchs.childNodes[loop];
			var locationname = batch.getElementsByTagName("locationname")[0];
			var Id = batch.getElementsByTagName("Id")[0];
			_targ.options[loop+1]=new Option(locationname.childNodes[0].nodeValue,Id.childNodes[0].nodeValue);
		  }
		_targ.options.length=loop+1;
		_targ.selectedIndex=0;
	}
	catch(err)
	{
		alert(err);
	}
}  






 
function loadAttendanceCycle(ctr)
{
   	if(ctr.value !="0")
	{
		var url = "../SmartCommonAjax?actionS=loadAttendanceCycle&startLetter=0&categoryid="+ctr.value;
		initRequest(url);
		req.onreadystatechange = loadAttendanceCycleRequest;
    	req.open("GET", url, true);
    	req.send(null);
	}
	else
	{
		alert("Kindly select employeee category");
		ctr.focus();
		
	}
		
}

function loadAttendanceCycleRequest() 
{
    if(req.readyState == 4) 
    {    
        
       var _targ=document.getElementsByName('attendancecycle')[0];       
	   _targ.options.length=0;	
       _targ.options[0]=new Option('Select Attendance Cycle','0');       
        if (req.status == 200) 
        {
        	loadAttendanceCycleDetails();
        }
    }
}


function loadAttendanceCycleDetails() 
{
	try
	{
		var batchs = req.responseXML.getElementsByTagName("Rowss")[0];      
		var _targ=document.getElementsByName('attendancecycle')[0];       
		 _targ.options.length=0;
		 _targ.options[0]=new Option('Select Attendance Cycle','0');
		 for (loop = 0; loop < batchs.childNodes.length; loop++) 
		 {
			var batch = batchs.childNodes[loop];
			var Cycle = batch.getElementsByTagName("Cycle")[0].childNodes[0].nodeValue;
			var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
			_targ.options[loop+1]=new Option(Cycle,Id);
			 
			//setOptionValue('attendancecycle',Id);
		  }
		_targ.options.length=loop+1;
		_targ.selectedIndex=1;
	}
	catch(err)
	{
		alert(err);
	}
}  






</script>

<jsp:include page="index.jsp" flush="true" />
<body   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onselectstart="return false" onpaste="return false;"  autocomplete="off" onLoad="document.getElementById('name').focus(),changeState()">
<table width="100%" border="0">
	<tr>
		<td> </td>
	</tr>
	<tr>
		<td height="60">&nbsp;</td>
	</tr>
	<tr>
	  <td valign="top">&nbsp;</td>
  </tr>
	<tr>
		<td valign="top">
		
		<form  AUTOCOMPLETE = "off"   name="frm" method="post"  action="../StaffRegistration" onSubmit="return validateFields()"    ENCTYPE="multipart/form-data">
		  <table width="90%" border="0" align="center" cellpadding="2" cellspacing="2" class="formTableOuterDesign">
            <tr>
              <td class="whiteHead"><div align="center">STAFF REGISTRATION </div></td>
            </tr>
            <tr bgcolor="#FFFFFF">
              <td bgcolor="#FFFFFF" class="formTableInnerDesign"><table width="95%" border="0" align="center" cellpadding="0"
								cellspacing="0">
                  <tr>
                    <td colspan="2"><div align="center"><span class="boldThirteen"> </span><span class="boldEleven"></span></div></td>
                  </tr>
                  <tr>
                    <td colspan="2"><div align="right"><font
																class="bolddeepred" align="absmiddle">*</font><span class="changePos"> Mandatory</span></div></td>
                  </tr>
                  <tr>
                    <td colspan="2">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="2">
					
					
					<fieldset>
                      <legend><strong><img src="../images/icon-misuse.gif"> Unique Information</strong> </legend>
					<table width="100%" border="0" cellpadding="2" cellspacing="2" class="boldEleven">
                        <tr>
                          <td width="24%" class="boldEleven">Applicant Id from Smart HRM <font class="bolddeepred"
																align="absmiddle">*</font></td>
                          <td width="22%"><!-- onChange="loadApplicantinfofromHRM(this)" -->
                              <select name="applicantid" class="formText135" id="applicantid"  style="width:165" tabindex="1">
                                <option value="0">Select Applicant Id</option>
                                <%
	String squery=" SELECT INT_APPID,CHR_APPNAME,CHR_APPCODE FROM  hrm_m_application WHERE CHR_OFFERORDERSTATUS ='Y'  AND CHR_REGISTRATIONRSTATUS='N' ORDER BY CHR_APPNAME";
	String datas1[][]=CommonFunctions.QueryExecute(squery);
	if (datas1.length>0)
		for (int i=0; i<datas1.length; i++) 
			out.println("<option value="+datas1[i][0]+">"+datas1[i][1]+" / "+datas1[i][2]+"</option>");			
	
						%>
                            </select></td>
                          <td width="24%">&nbsp;</td>
                          <td width="30%">&nbsp;</td>
                        </tr>
						<tr>
                          <td class="boldEleven">Staff Name <font class="bolddeepred"
																align="absmiddle">* </font></td>
                          <td>
<input name="name" type="text" class="formText135" id="name"  tabindex="2"    size="30" maxlength="50" onKeyPress="StaffRegistrationUnique()" onBlur=" upperMe(this),StaffRegistrationUnique()">
																
												<!--onBlur=" upperMe(this),LoadUniqueCheck('name', 'namediv', 'com_m_staff', 'CHR_STAFFNAME', 'Submit')" onKeyUp=" LoadUniqueCheck('name', 'namediv', 'com_m_staff', 'CHR_STAFFNAME', 'Submit')"  -->				
                                  <div id="namediv"></div></td>
                          <td><div id='solutename'>Father's Name<font class="bolddeepred"
																align="absmiddle"> *</font> </div></td>
						  <td><input name="fname" type="text" class="formText135"  id="fname"  tabindex="4"  size="30"   maxlength="50"  onKeyPress="StaffRegistrationUnique()"  onBlur=" upperMe(this),StaffRegistrationUnique()"/></td>
						</tr>
						<tr>
						  <td class="boldEleven">Record Date Of Birth <font
																class="bolddeepred" align="absmiddle">*</font></td>
						  <td><input title="dd-mm-yyyy"   name="dob"  id="dob"  type="text" class="formText135" size="25" maxlength="10" readonly="readonly"  tabindex="3"  /></td>
						  <td>Mother Name <font class="bolddeepred"
																align="absmiddle"> *</font></td>
						  <td><input name="mothername" type="text" class="formText135" id="mothername" size="30"  maxlength="50"  tabindex="5"  onKeyPress="StaffRegistrationUnique()"  onBlur=" upperMe(this),StaffRegistrationUnique()"/></td>
					  </tr>
						 
						<tr>
						  <td colspan="4" class="boldEleven">
						  <div id='StaffRegistrationUniquediv'></div>						  </td>
					  </tr>
						<tr>
                          <td class="boldEleven">&nbsp;</td>
                          <td>&nbsp;</td>
                          <td>&nbsp;</td>
						  <td>&nbsp;</td>
						</tr>
                    </table>
					</fieldset>					</td>
                  </tr>
                  <tr>
                    <td colspan="2">&nbsp;</td>
                  </tr>
                  <tr>
                    <td height="19" colspan="2"><fieldset>
                      <legend><strong><img src="../images/icon-misuse.gif"> Official Information</strong> </legend>
                      <table width="100%" border="0" align="center" cellpadding="2"
												cellspacing="2">
                        <tr>
                          <td width="50%" ><table width="100%" border="0" align="center"
														cellpadding="1" cellspacing="2" bordercolor="#D4D0C8"
														class="boldEleven">
                            <tr>
                              <td colspan="2"><div align="center" class="errormessage">
                                  <div align="center">
                                    <%
																String ers = ""+request.getParameter("errM");
																if(!"null".equals(ers))
																	out.println(ers);
															%>
                                  </div>
                              </div></td>
                            </tr>
                            <tr>
                              <td colspan="2"><div align="center"><strong>Personal
                                Informations </strong></div></td>
                            </tr>
                            <tr>
                              <td width="44%" ></td>
                              <td width="56%"   class="staffsearch"></td>
                            </tr>
                             
                            <tr>
                              <td class="boldEleven">Gender</td>
                              <td><table   border="0" cellspacing="0"
																cellpadding="0">
                                  <tr>
                                    <td width="20"><input name="gender"  id="gender" type="radio"
																		value="Male" checked="checked" class="formText135" /></td>
                                    <td width="47" class="boldEleven">Male</td>
                                    <td width="26"><input name="gender"  id="gender" type="radio"
																		value="Female" class="formText135" /></td>
                                    <td width="59" class="boldEleven">Female</td>
                                  </tr>
                              </table></td>
                            </tr>
                            <tr>
                              <td class="boldEleven">Blood Group<font
																class="bolddeepred" align="absmiddle"> *</font></td>
                              <td><jsp:include page="../JavaScript/bloodgroup.jsp" flush="true" />                              </td>
                            </tr>
                            <tr>
                              <td  class="boldEleven">Date Of Join<font
																class="bolddeepred" align="absmiddle"> *</font></td>
                              <td class="boldEleven"><input  
																name="doj" id="doj"  type="text" class="formText135" size="22"
																maxlength="10"  readonly="readonly"  
																title="dd-mm-yyyy"  tabindex="7"/>
                                  <script language="JavaScript" type="text/javascript">setCurrentDate('doj'); </script></td>
                            </tr>
                             
                            <tr>
                              <td class="boldEleven">Marital  Status
<script language="javascript">
function changeState1()
{
	cwd.style.visibility="visible";
	cwd1.style.visibility="visible";
	document.getElementById('mtype').value="M";
} 

function changeState()
{
	document.frm.wedding.value="";
	cwd.style.visibility="hidden";
	document.getElementById('mtype').value="U";
	
	cwd1.style.visibility="hidden";
	document.getElementById('spousename').value="";
} 	

</script>
							  <font class="bolddeepred"
																align="absmiddle">*</font></td>
                              <td><table width="201" border="0" cellpadding="0"
																cellspacing="0" class="boldEleven">
                                  <tr>
                                    <td>
				<input name="marry" type="radio" value="M" id="marry"  onclick="changeState1()" class="formText135" /></td>
                                    <td class="boldEleven">Married</td>
                                    <td>
				<input name="marry" type="radio" value="U" id="marry" onClick="changeState()"  checked="checked" class="formText135" />				</td>
                                    <td class="boldEleven">UnMarried
                                      <input name="card" type="hidden" id="card" value="" />
                                        <input name="mtype"  id="mtype"  type="hidden" value="U" /></td>
                                  </tr>
                              </table></td>
                            </tr>
                            <tr id="cwd">
                              <td class="boldEleven">Wedding Date</td>
                              <td><input title="dd-mm-yyyy"  readonly="readonly"    value=""
																name="wedding" type="text" class="formText135" id="wedding"
																size="22" maxlength="10" tabindex="6" /></td>
                            </tr>
                            <tr  id="cwd1">
                              <td valign="top" class="boldEleven">Spouse Name <font class="bolddeepred"
																align="absmiddle">*</font></td>
                              <td valign="top"><input name="spousename" type="text" class="formText135" id="spousename"   onBlur=" upperMe(this)" size="30"
																maxlength="50"></td>
                            </tr>
                            <tr>
                              <td class="boldEleven">Off. E-mail</td>
                              <td class="boldEleven"><input name="emailid" type="email"
																class="formText135" id="emailid" size="30"
																  maxlength="90"  tabindex="8"/></td>
                            </tr>
                            <tr>
                              <td class="boldEleven">Per. E-mail <font
																class="bolddeepred" align="absmiddle">*</font></td>
                              <td class="boldEleven"><input name="peremailid" type="email" class="formText135" id="peremailid" size="30"  maxlength="90" tabindex="9">
                                  <div id='emaildiv'></div></td>
                            </tr>
                            <tr>
                              <td   class="boldEleven">Mobile <font
																class="bolddeepred" align="absmiddle">*</font></td>
                              <td class="boldEleven"><input name="mobile" type="text"
																class="formText135" id="mobile" onKeyPress=" return numeric_only(event,'mobile','11')"     
																  size="30"
																maxlength="10"  tabindex="10"/></td>
                            </tr>
                            <tr>
                              <td class="boldEleven">Qualifications <font
																class="bolddeepred" align="absmiddle">*</font></td>
                              <td class="boldEleven"><!--<input name="qualification" type="text" class="boldEleven" onKeyUp="upperMe(this)" id="qualification"   size="30" maxlength="30"   />-->
                                  <select name="qualification" size="1" class="formText135" id="qualification"  style="width:165"  tabindex="11">
                                    <option value="0">Select Qualification </option>
                                    <%
										String ssql=" SELECT INT_QUALIFICATIONID,CHR_QUALIFICATIONNAME FROM com_m_qualification ORDER BY CHR_QUALIFICATIONNAME";
										String qualdata[][]=CommonFunctions.QueryExecute(ssql);
										for(int c=0;c<qualdata.length;c++)
										{
											out.println("<option value='"+qualdata[c][0]+"'>"+qualdata[c][1]+"</option>");
										}
									%>
                                </select></td>
                            </tr>
                            <tr>
                              <td valign="top" class="boldEleven">Reporting to <font
																class="bolddeepred" align="absmiddle">*</font></td>
                              <td valign="top" class="boldEleven"><select id="repto" name="repto" class="formText135"  style="width:165"  tabindex="12">
                                  <option value="0">Select Reporting to</option>
                                  <%
		   String rptodata[][] =CommonFunctions.QueryExecute("select CHR_EMPID,CHR_STAFFNAME from com_m_staff WHERE CHR_TYPE<>'T'  AND CHR_REP='Y' ");
		   for(int c=0;c<rptodata.length;c++)
		   		out.println("<option value='"+rptodata[c][0]+"'>"+rptodata[c][1]+"</option>");
		   %>
                              </select></td>
                            </tr>
                            <tr>
                              <td valign="top" class="boldEleven">Category <font
																class="bolddeepred" align="absmiddle">*</font></td>
                              <td valign="top"><select name="category" class="formText135" id="category"  style="width:165" onChange="loadAttendanceCycle(this)" >
                                  <option value="0">Select</option>
                                  <%
	String empcategorysql=" SELECT INT_EMPLOYEECATEGORYID,CHR_CATEGORYNAME  FROM   com_m_employeecategory WHERE CHR_STATUS='Y'   ORDER BY CHR_CATEGORYNAME ";
	String empcategoryData[][] = CommonFunctions.QueryExecute(empcategorysql);
	if (empcategoryData.length>0)
		for (int i=0; i<empcategoryData.length; i++) 
			out.println("<option value="+empcategoryData[i][0]+">"+empcategoryData[i][1] +"</option>");			
	
						%>
                                </select>                              </td>
                            </tr>
                            <tr>
                              <td valign="top" class="boldEleven">Attendance Cycle
                                <%
String cdata[][]=CommonFunctions.QueryExecute("SELECT INT_FROM,INT_TO FROM att_m_basicsettings  WHERE INT_ID=1");
%>
                                  <font
																class="bolddeepred" align="absmiddle">*</font></td>
                              <td valign="top"><select name="attendancecycle" id="attendancecycle" class="formText135"  style="width:165" tabindex="30">
                                  <option value="0">Select Attendance Cycle</option>
                                  <option value="1" selected="selected">1-31</option>
                                  <option value="2"><%=cdata[0][0]%>th to <%=cdata[0][1]%>th</option>
                              </select></td>
                            </tr>
                            <tr>
                              <td valign="top" class="boldEleven">Salary Type <font
																class="bolddeepred" align="absmiddle">*</font></td>
                              <td valign="top"><select name="salarytype" id="salarytype"  class="formText135"  style="width:165" tabindex="31">
                                  <!--<option value="CTC">CTC - Based</option>-->
                                  <option value="MTH" selected="selected">MONTH - Based</option>
                                  <!--<option value="WRK">Working Days (Daily Wages) - Based</option>-->
                              </select></td>
                            </tr>
                            <tr>
                              <td valign="top" class="boldEleven">CTC</td>
                              <td valign="top"><input name="ctc" type="text" class="formText135" id="ctc"   onkeypress="return numeric_only(event,'ctc','10')" value="0" 	size="30" maxlength="8"  tabindex="14"/></td>
                            </tr>
                            <tr>
                              <td valign="top" class="boldEleven">&nbsp;</td>
                              <td valign="top">&nbsp;</td>
                            </tr>
                            <tr>
                              <td valign="top" class="boldEleven">Staff Photo <font
																class="bolddeepred" align="absmiddle">*
                                  <input name="filesize" type="hidden" id="filesize" value="0">
                              </font></td>
                              <td valign="top"><script language="javascript">
function GetFileSize(fileid) 
{
 try 
 {
 	var fileSize = 0;
 	//if(checkNull('f1','Select Photo') )
	{ 
		var file = document.getElementById("f1").value;
		var fileExtn = file.lastIndexOf(".");
		var Extn=file.substring(fileExtn);
		if((Extn == ".GIF") ||(Extn == ".gif") ||(Extn == ".jpeg") ||(Extn == ".JPEG") ||(Extn == ".JPG") ||(Extn == ".jpg") ||(Extn == ".BMP") ||(Extn == ".bmp"))
		{
		}
		else
		{
			alert("Only possible JPEG,GIF,BMP only");
			document.getElementById('f1').focus();
		}
		//for IE
		if ($.browser.msie) 
		{
			 
			var objFSO = new ActiveXObject("Scripting.FileSystemObject"); var filePath = $("#" + fileid)[0].value;
			var objFile = objFSO.getFile(filePath);
			var fileSize = objFile.size; //size in kb
			if( fileSize > 102400)
			{
				alert("Your file size File > 100k");
				document.getElementById('f1').focus();
			}
			 
		}
		//for FF, Safari, Opeara and Others
		else 
		{
			fileSize = $("#" + fileid)[0].files[0].size //size in kb
			if( fileSize > 102400)
			{
				alert("Your file size File > 100k");
				document.getElementById('f1').focus();
			}
		}
	}
	
 	  
 }
 catch (e) 
 {
 	 
 }
}
</script>
 
 
<!-- This is the code to get the file size from the chosen file through the <input type="file" onChange="checkFileSize(this)" /> html tag.
For IE browsers
 
    <script language="javascript">
     function checkFileSize(fileItem) {
   $('#myImage').attr('src', fileItem.value);
   var img = document.getElementById('myImage');
   img.onload = function() {
  var imgbytes = img.fileSize;
  var imgkbytes = Math.round(parseInt(imgbytes)/1024);
     alert(imgkbytes + ' in KB for IE ');
 };
    }
    </script>
 
For non-IE browsers
 
    <script language="javascript">
    function checkFileSize(fileItem) {
     var fileInput = fileItem;
     var imgbytes = fileInput.files[0].size;
     var imgkbytes = Math.round(parseInt(imgbytes)/1024);
     alert(imgkbytes + ' in KB for non-IE ');
    }
    </script>
 -->
 


								<INPUT NAME="f1" id="f1"  value="" TYPE="file" onBlur="GetFileSize('f1');" ></td>
                            </tr>
                            <tr>
                              <td colspan="2" valign="top"><div align="center" class="boldElevenlink">( file should be  100 X 100 Dimension &amp; size &lt;=100Kb ) </div></td>
                            </tr>
                            <tr>
                              <td valign="top">&nbsp;</td>
                              <td valign="top">&nbsp;</td>
                            </tr>
                            <tr>
                              <td valign="top">&nbsp;</td>
                              <td valign="top">&nbsp;</td>
                            </tr>
                          </table></td>
                          <td width="53%"><table width="100%" border="0" align="center"
														cellpadding="1" cellspacing="2" bordercolor="#D4D0C8"
														class="boldEleven">
                              <tr>
                                <td colspan="4">&nbsp;</td>
                              </tr>
                              <tr>
                                <td colspan="4"><div align="center"><strong>Official
                                  Details</strong></div></td>
                              </tr>
                              <tr>
                                <td width="136" class="boldEleven">Company<font
																class="bolddeepred" align="absmiddle"> *</font></td>
                                <td colspan="3"><table width="150" border="0" cellspacing="0"
																cellpadding="0">
                                    <tr>
                                      <!--onchange="loadBDStaff('')"-->
                                      <td><select name="company"  id="company" onBlur="loadBranch() " class="formText135"  style="width:165" tabindex="17">
                                          <option value="0">Select Company</option>
                                          <%
                                              String sql1="SELECT INT_COMPANYID,CHR_COMPANYNAME FROM  com_m_company  WHERE INT_ACTIVE=1  ORDER BY CHR_COMPANYNAME";
                                              String company[][]= CommonFunctions.QueryExecute(sql1);
                                              for(int i=0;i<company.length;i++){
                                            	  out.println("<option value="+company[i][0]+">"+company[i][1]+"</option>");		
                                              }
                                            %>
                                        </select>                                      </td>
                                    </tr>
                                </table></td>
                              </tr>
                              <tr>
                                <td width="136" class="boldEleven">Branch<font
																class="bolddeepred" align="absmiddle"> *</font></td>
                                <td colspan="3"><table width="150" border="0" cellspacing="0"
																cellpadding="0">
                                    <tr>
                                      <td><select name="branch"  id="branch" class="boldEleven"  style="width:165" tabindex="18">
                                          <option value="0" >Select Branch</option>
                                        </select>
                                          <div id="description"></div></td>
                                    </tr>
                                </table></td>
                              </tr>
                              <tr>
                                <td bordercolor="#FF0000" class="boldEleven">Office <font
																class="bolddeepred" align="absmiddle">*</font></td>
                                <td colspan="3"><table width="150" border="0" cellspacing="0"
																cellpadding="0">
                                    <tr>
                                      <td><select name="off" class="formText135" id="off"  style="width:165" tabindex="21" onChange="loadLocations(this)">
                                          <option value="0">Select Office</option>
                                          <%
        String offdata[][]= CommonFunctions.QueryExecute("SELECT INT_OFFICEID,CHR_OFFICENAME FROM   com_m_office  WHERE CHR_STATUS='Y'  ORDER BY CHR_OFFICENAME");
for(int h=0;h<offdata.length;h++)
	out.print("<option value='"+offdata[h][0]+"'>"+offdata[h][1]+"</option>");

		
%>
                                      </select></td>
                                    </tr>
                                </table></td>
                              </tr>
                              <tr>
                                <td class="boldEleven">Location <font
																class="bolddeepred" align="absmiddle">*</font></td>
                                <td colspan="3"><select name="location" class="formText135" id="location"  style="width:165" tabindex="21" >
                                    <option value="0">Select location</option>
                                </select></td>
                              </tr>
                              <tr>
                                <td class="boldEleven">Department <font
																class="bolddeepred" align="absmiddle">*</font></td>
                                <td colspan="3"><table width="150" border="0" cellspacing="0"
																cellpadding="0">
                                    <tr>
                                      <td><select name="depart" class="formText135" id="depart"  style="width:165"tabindex="22">
                                          <option value="0">Select Department</option>
                                          <%
      	String depdata[][]= CommonFunctions.QueryExecute("SELECT INT_DEPARTID,CHR_DEPARTNAME FROM  com_m_depart WHERE CHR_STATUS='Y'  ORDER BY CHR_DEPARTNAME");
	for(int h=0;h<depdata.length;h++)
		out.print("<option value='"+depdata[h][0]+"'>"+depdata[h][1]+"</option>");

		
%>
                                      </select></td>
                                    </tr>
                                </table></td>
                              </tr>
                              <tr>
                                <td class="boldEleven">Designation<font
																class="bolddeepred" align="absmiddle"> *</font><font
																class="redcol style3" align="absmiddle">&nbsp;</font></td>
                                <td colspan="3"><table width="150" border="0" cellspacing="0"
																cellpadding="0">
                                    <tr>
                                      <td><select name="desig" class="formText135" id="desig"  style="width:165" tabindex="23">
                                          <option value="0">Select Designation</option>
                                          <%
         		String desgdata[][]= CommonFunctions.QueryExecute("SELECT INT_DESIGID,CHR_DESIGNAME FROM  com_m_desig  WHERE CHR_STATUS='Y'  ORDER BY CHR_DESIGNAME");
			for(int h=0;h<desgdata.length;h++)
				out.print("<option value='"+desgdata[h][0]+"'>"+desgdata[h][1]+"</option>");
			

		
%>
                                      </select></td>
                                    </tr>
                                </table></td>
                              </tr>
                              <tr>
                                <td class="boldEleven">Type<font
																class="bolddeepred" align="absmiddle"> *</font></td>
                                <td colspan="3" tabindex="24"><jsp:include page="../JavaScript/stafftype.jsp" flush="true" /></td>
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


            </script>                                </td>
                                <td colspan="3"><table width="100" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                      <td class="boldEleven"><input name="salarysplitupby"  id="salarysplitupby"  type="radio" value="A" onClick="basicdisable()" /></td>
                                      <td class="boldEleven">Automatic</td>
                                      <td class="boldEleven"><input name="salarysplitupby" type="radio"  id="salarysplitupby" onClick="basicenable()" value="M" checked /></td>
                                      <td class="boldEleven">Manual</td>
                                    </tr>
                                </table></td>
                              </tr>
                              <tr id="bid">
                                <td class="boldEleven">Basic Salary</td>
                                <td colspan="3"><input name="basic" type="text" class="formText135" id="basic" tabindex="25" onKeyPress="return numeric_only(event,'basic','12')" value="0" size="30" 																maxlength="7"  onpaste="return false;"></td>
                              </tr>
                              <tr>
                                <td class="boldEleven">Splitup Gross Salary<font
																class="bolddeepred" align="absmiddle"> *</font></td>
                                <td colspan="3"><input name="gross" type="text" class="formText135" id="gross" 	size="30" maxlength="7" onKeyPress="return numeric_only(event,'gross','10')"  onpaste="return false;" tabindex="26">
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
	
	
	
	String stafftypeDatas[][] =CommonFunctions.QueryExecute(" SELECT  CHR_TYPENAME,CHR_FLAG FROM com_m_stafftype  ORDER BY CHR_TYPENAME ");
	String svalue="";
	for(int x=0; x<stafftypeDatas.length;x++)
	{
		for(int y=0; y<2;y++)
			svalue = svalue+stafftypeDatas[x][y]+",";
		svalue = svalue+"~";	
	}
	
	
%>
                                    <script language="JavaScript" type="text/javascript">
	var salarybandvalue = "<%=lvalue%>";
	var salarybandvalue1 =salarybandvalue.split("~");
	var f= false;
	
	
	
	function checkSalaryBand()
	{
		try
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
		catch(err)
		{
			alert(err);
		}
	}
	
	
	
	var f1 =false;
	function checkSalaryType()
	{
		try
		{
			var salarytypevalue = "<%=svalue%>";
			var salarytypevalue1 =salarytypevalue.split("~");
			var type =document.getElementById("stype").value;
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
		catch(err)
		{
			 alert(err.description)
		}		
	}
                                                            </script></td>
                              </tr>
                              <tr>
                                <td class="boldEleven">Bank Name <font
																class="bolddeepred" align="absmiddle">*</font></td>
                                <td colspan="3"><select name="bank" class="formText135" id="bank"  style="width:165" tabindex="27" onChange="resetIFSC()">
                                    <option value="0">Select Bank Name</option>
                                    <%
                   
                  		String datas[][]= CommonFunctions.QueryExecute("SELECT INT_BANKGROUPID, CHR_BANKGROUPNAME  FROM com_m_bankgroup  ORDER BY CHR_BANKGROUPNAME");
                  		if (datas.length>0){
                  			for (int i=0; i<datas.length; i++) {
								out.println("<option value="+datas[i][0]+">"+datas[i][1]+"</option>");			
                  			}
                  		}
				%>
                                </select></td>
                              </tr>
                              <tr>
                                <td width="136" class="boldEleven">Account No </td>
                                <td colspan="3"><input name="number" type="text" class="formText135" id="no" size="30"  maxlength="20"   value="DD"  onkeyup="upperMe(this),checkAccounts(this) " tabindex="28"/>
                                    <script language="javascript">
function checkAccounts(ctr)
{
	try
	{
		
		document.getElementById('Submit').disabled=false;	
		var v = ctr.value;
		v = v.toUpperCase();
		v = v.replace('','');
		var f = ( ( v !="") && (v != "DD") );
		
		if( f)
			LoadUniqueCheck('no', 'acc', 'com_m_staff', 'CHR_ACCNO', 'Submit')
		else
		{
			document.getElementById('Submit').disabled=false;	
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
                                  <span class="boldred">A/c no does'nt have, Put DD </span></td>
                              </tr>
                              <tr>
                                <td class="boldEleven">IFSC CODE </td>
                                <td colspan="3"><script language="javascript">
 function ifsccodefill(thisValue) 
{
	document.getElementById('ifsccode').value=thisValue;
	//setTimeout("$('#ifsccode1').hide();", 30);
	$('#ifsccode1').hide();
}

function ifsccodelookup(inputString) 
{
	try
	{
		if(checkNullSelect('bank','Select Bank','0'))
		{
			var bank = document.getElementById('bank').value;
			
			if(inputString.length == 0 )
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
						$('#ifsccodeListdata').html(data);
					}
				});
			}	
		}
	}
	catch(err)
	{
		alert(err);
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
                                    <input name="ifsccode" type="text"	class="formText135" id="ifsccode"  size="30"     											maxlength="20"  tabindex="29" value=""   onKeyUp="ifsccodelookup(this.value);" title="Please type branch name  or IFSC code wise" />
                                    <div class="ifsccodeBox1" id="ifsccode1" style="display: none;width:250%;">
                                      <div class="ifsccodeList1" id="ifsccodeListdata" style="OVERFLOW:auto;width:100%;height:200px" ></div>
                                    </div>
                                  <br>
                                    <span class="boldred">Search branch name  / IFSC code </span></td>
                              </tr>
                              <tr>
                                <td class="boldEleven">Leave Carry</td>
                                <td><input name="carry" type="checkbox" class="formText135"
																id="carry" value="Y" /></td>
                                <td class="boldEleven">Fingerprint Login </td>
                                <td><select name="fplogin" id="fplogin" class="formText135">
                                    <option value="N" selected="selected"> No</option>
                                    <option value="Y">Yes</option>
                                  </select>                                </td>
                              </tr>
                              <tr>
                                <td class="boldEleven">Management</td>
                                <td><input name="management"
																type="checkbox" class="formText135" id="management" value="Y" /></td>
                                <td class="boldEleven">Pay slip hide </td>
                                <td><select name="payslip" id="payslip" class="formText135">
                                    <option value="N" selected="selected"> No</option>
                                    <option value="Y">Yes</option>
                                </select></td>
                              </tr>
                              <tr>
                                <td class="boldEleven">Reporting Head</td>
                                <td width="47"><input name="reporinghead"
																type="checkbox" class="formText135" id="reporinghead" value="Y" /></td>
                                <td width="127" class="spc"><p class="boldEleven">Conveyance clear</p></td>
                                <td width="73"><input name="conveyance" type="checkbox" class="formText135" id="conveyance" value="Y" /></td>
                              </tr>
                              <tr>
                                <td class="boldEleven"><span class="spc">Staff
                                  Holding </span></td>
                                <td><input name="hold" type="checkbox" class="formText135" id="hold"
																value="Y" /></td>
                                <td class="boldElevenlink">Salary Calculation </td>
                                <td><input name="salarycalculation" type="checkbox" class="formText135" id="salarycalculation" value="Y" checked="checked" /></td>
                              </tr>
                              <tr>
                                <td class="boldEleven">Rejoin</td>
                                <td colspan="3"><table width="99%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                      <td width="8%"><input   name="rejoin" type="checkbox"
																id="rejoin" value="Y"  onClick="rejoincheck()" >                                      </td>
                                      <td width="40%" class="boldEleven" id="r1">Previous employee  id </td>
                                      <td width="52%" id="r2"><script language="javascript">
 function empidfill(thisValue) 
{
	document.getElementById('previousempid').value=thisValue;
	//setTimeout("$('#empidcode1').hide();", 200);
	$('#empidcode1').hide();
}


function empidlookup(inputString) 
{
 		if(inputString.length == 0) 
		{
			$('#empidcode1').hide();
		} 
		else 
		{
			$.post("Resignemployee.jsp" , {queryString: ""+inputString+" "  }, function(data)
			{
				if(data.length >0) 
				{
					$('#empidcode1').show();
					$('#empidList1').html(data);
				}
			});
		}	
 }
          </script>
                                          <style type="text/css">
.empidBox1 
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
.empidList1 
{
	margin: 0px;
	padding: 0px;
}
.empidList1 li 
{
	margin: 0px 0px 3px 0px;
	padding: 3px;
	cursor: pointer;
}

.empidList1 li:hover {
background-color: #ffffff;
}
            </style>
                                          <input name="previousempid" type="text"	class="formText135" id="previousempid"  size="20"   onBlur="upperMe(this)"   											maxlength="16"  tabindex="29" onKeyUp="empidlookup(this.value);" title="Please type previous empid" />
                                          <div class="empidBox1" id="empidcode1" style="display: none;width:250%;">
                                            <div class="empidList1" id="empidList1" style="OVERFLOW:auto;width:100%;height:200px" ></div>
                                          </div>
                                        <script language="javascript">
r1.style.visibility="hidden";
r2.style.visibility="hidden";
			
function rejoincheck()
{
	try
	{
		if(document.getElementById('rejoin').checked)
		{
			r1.style.visibility="Visible";
			r2.style.visibility="Visible";
			
		}
		else
		{
			r1.style.visibility="hidden";
			r2.style.visibility="hidden";
			
		}
	}
	catch(err)
	{
		alert(err);
	}
}

function rejoincheckNull()
{
	try
	{
		if(document.getElementById('rejoin').checked)
		{
			if(checkNull('previousempid','Kindly enter the Previopus employee id'))
				return true;
			else
				return false;
		}
		else
		{
			return true;
		}
			
	}
	catch(err)
	{
		alert(err);
	}
}
            </script></td>
                                    </tr>
                                </table></td>
                              </tr>
                               
                              <tr>
                                <td class="boldEleven">&nbsp;</td>
                                <td colspan="3">&nbsp;</td>
                              </tr>
                          </table></td>
                        </tr>
                      </table>
                    </fieldset></td>
                  </tr>
                  <tr>
                    <td width="50%" height="19">&nbsp;</td>
                    <td width="50%">&nbsp;</td>
                  </tr>
                  <tr>
                    <td height="19" colspan="2"><fieldset>
                      <legend><strong><img src="../images/icon-misuse.gif"> Contact Information</strong> </legend>
                      <table width="100%" border="0" align="center" cellpadding="2"
												cellspacing="2">
                        <tr>
                          <td width="48%" height="210"><table width="100%" border="0" align="center"
														cellpadding="1" cellspacing="2">
                              <tr>
                                <td height="15" colspan="2" class="boldEleven"><div align="center"><strong>Permanent
                                  Address</strong></div></td>
                              </tr>
                              <tr>
                                <td width="129" class="boldEleven">Address1 <font
																class="bolddeepred" align="absmiddle">*</font></td>
                                <td class="boldEleven"><input name="padd1"
																type="text" class="formText135" id="padd1"
																  size="30"
																maxlength="50"    onBlur="upperMe(this)"    tabindex="32"/></td>
                              </tr>
                              <tr>
                                <td class="boldEleven">Address2 <font
																class="bolddeepred" align="absmiddle">*</font></td>
                                <td class="boldEleven"><input name="padd2"    onBlur="upperMe(this)"   
																type="text" class="formText135" id="padd2"
																 size="30"
																maxlength="50"  tabindex="33"/></td>
                              </tr>
                              <tr>
                                <td class="boldEleven">Location <font
																class="bolddeepred" align="absmiddle">*</font></td>
                                <td class="boldEleven"><select name="pcity" class="formText135" id="pcity"  style="width:165" onChange="PAssignPincode('ppincode')"  tabindex="38" >
                                    <option value="0" selected="selected">Select City</option>
                                </select></td>
                              </tr>
                              <tr>
                                <td class="boldEleven">District<font
																class="bolddeepred" align="absmiddle"> *</font></td>
                                <td class="errormessage"><select name="pdistrict" class="formText135" id="pdistrict"  style="width:165" onChange=" PLoadSelectCity()" tabindex="37">
                                    <option value="0" selected="selected">Select District</option>
                                </select></td>
                              </tr>
                              <tr>
                                <td class="boldEleven">State
                                  <input type="hidden"
																name="staffid" value="<%="staffid"%>" />
                                    <font
																class="bolddeepred" align="absmiddle">*</font></td>
                                <td class="boldEleven"><select name="pstate" class="formText135" id="pstate"  style="width:165" onChange="PLoadSelectDistrict()" tabindex="36">
                                    <option value="0" selected="selected">Select State</option>
                                </select></td>
                              </tr>
                              <tr>
                                <td class="boldEleven">Country <font
																class="bolddeepred" align="absmiddle">*</font></td>
                                <td class="boldEleven"><select name="pcountry" class="formText135" id="pcountry"  style="width:165" onChange="PLoadSelectState()" tabindex="35">
                                    <option value="0">Select Country</option>
                                    <%
	 		String creadData[][]=  CommonFunctions.QueryExecute("SELECT INT_COUNTRYID ,CHR_COUNTRYNAME FROM  com_m_country ORDER BY CHR_COUNTRYNAME");
			for(int i=0;i<creadData.length;i++)
				out.println("<option value='"+creadData[i][0]+"'>"+creadData[i][1]+"</option>");
	 %>
                                </select></td>
                              </tr>
                              <tr>
                                <td class="boldEleven">Pin Code<font
																class="bolddeepred" align="absmiddle"> *</font></td>
                                <td class="boldEleven"><input name="ppincode" type="text" class="formText135" id="ppincode" onKeyPress="return numeric_only(event,'ppincode','8') " size="30" 									maxlength="7"    onKeyUp="lookup(this.value);"  tabindex="34"/>
                                    <br />
                                    <div class="suggestionsBox" id="suggestions" style="display: none;width:150%;">
                                      <div class="suggestionList" id="autoSuggestionsList" style="OVERFLOW:auto;width:100%;height:200px" ></div>
                                    </div></td>
                              </tr>
                              <tr>
                                <td class="boldEleven">Phone No</td>
                                <td class="boldEleven"><input name="pphone" value=""
																type="text" class="formText135" id="pphone"
																onkeypress="return numeric_only(event,'pphone','12')" size="30"
																maxlength="10" tabindex="39" /></td>
                              </tr>
                          </table></td>
                          <td width="52%"><table width="100%" border="0" align="center"
														cellpadding="1" cellspacing="2">
                              <tr>
                                <td colspan="2" class="boldEleven"><div align="center"><strong>Communication
                                  Address</strong></div></td>
                              </tr>
                              <tr>
                                <td width="180" class="boldEleven">Address1 <font class="bolddeepred"
																align="absmiddle">*</font></td>
                                <td class="boldEleven"><input name="cadd1"
																type="text" class="formText135" id="cadd1"
																 size="30"
																maxlength="50"     onBlur="upperMe(this)"    tabindex="41"/></td>
                              </tr>
                              <tr>
                                <td class="boldEleven">Address2<font class="bolddeepred"
																align="absmiddle"> *</font></td>
                                <td class="boldEleven"><input name="cadd2"
																type="text" class="formText135" id="cadd2"
   onBlur="upperMe(this)"   
																  size="30"
																maxlength="50" tabindex="42" /></td>
                              </tr>
                              <tr>
                                <td class="boldEleven">Location<font class="bolddeepred"
																align="absmiddle"> *</font></td>
                                <td class="boldEleven"><select name="ccity" class="formText135" id="ccity"  style="width:165" onChange="CAssignPincode('cpincode')" tabindex="47">
                                    <option value="0" selected="selected">Select City</option>
                                  </select>                                </td>
                              </tr>
                              <tr>
                                <td class="boldEleven">District <font class="bolddeepred"
																align="absmiddle">*</font></td>
                                <td class="boldEleven"><select name="cdistrict" class="formText135" id="cdistrict"  style="width:165" onChange=" CLoadSelectCity()" tabindex="46">
                                    <option value="0" selected="selected">Select District</option>
                                  </select>                                </td>
                              </tr>
                              <tr>
                                <td class="boldEleven">State <font class="bolddeepred"
																align="absmiddle">*</font></td>
                                <td class="boldEleven"><select name="cstate" class="formText135" id="cstate"  style="width:165" onChange="CLoadSelectDistrict()" tabindex="45">
                                    <option value="0" selected="selected">Select State</option>
                                </select></td>
                              </tr>
                              <tr>
                                <td class="boldEleven">Country<font class="bolddeepred"
																align="absmiddle"> *</font></td>
                                <td class="boldEleven"><select name="ccountry" class="formText135" id="ccountry"  style="width:165" onChange="CLoadSelectState()" tabindex="44">
                                    <option value="0">Select Country</option>
                                    <%
	 		for(int i=0;i<creadData.length;i++)
				out.println("<option value='"+creadData[i][0]+"'>"+creadData[i][1]+"</option>");
	 %>
                                  </select>                                </td>
                              </tr>
                              <tr>
                                <td class="boldEleven">Pin Code <font class="bolddeepred"
																align="absmiddle">*</font> </td>
                                <td class="boldEleven"><input name="cpincode" type="text" class="formText135" id="cpincode" onKeyPress="return numeric_only(event,'cpincode','8') " size="30" maxlength="7"  onKeyUp="clookup(this.value);"  tabindex="43"/>
                                    <div class="suggestionsBox1" id="suggestions1" style="display: none;width:150%;">
                                      <div class="suggestionList1" id="autoSuggestionsList1" style="OVERFLOW:auto;width:100%;height:200px" ></div>
                                    </div></td>
                              </tr>
                              <tr>
                                <td class="boldEleven">Phone No</td>
                                <td class="boldEleven"><input name="cphone" value=""
																type="text" class="formText135" id="cphone"
																onkeypress="return numeric_only(event,'cphone','12')" size="30"
																maxlength="10" /></td>
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
                                <td width="114"></td>
                              </tr>
                          </table></td>
                        </tr>
                      </table>
                    </fieldset></td>
                  </tr>
                  <tr>
                    <td height="19">&nbsp;</td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td height="19" colspan="2"><fieldset>
                      <legend><strong><img src="../images/icon-misuse.gif"> PF &amp; ESI Information</strong> </legend>
                      <table width="100%" border="0" align="center" cellpadding="2"
												cellspacing="2">
                        <tr>
                          <td width="48%" height="167"><table width="100%" border="0" align="center"
														cellpadding="1" cellspacing="2">
                              <tr>
                                <td colspan="2" class="boldEleven"><div align="center"><strong>PF</strong></div></td>
                              </tr>
                              <tr>
                                <td class="boldEleven">&nbsp;</td>
                                <td class="boldEleven">&nbsp;</td>
                              </tr>
                              <tr class="boldEleven">
                                <td width="160" class="boldEleven">PF<font
																class="bolddeepred" align="absmiddle"> *</font></td>
                                <td width="194" class="boldEleven"><select name="pf" class="formText135" id="pf" onChange="pfchange()"  style="width:165" tabindex="48">
                                    <option value="0">Select PF </option>
                                    <option value="Y">Yes</option>
                                    <option value="N">No</option>
                                    <option value="C">Common</option>
                                </select></td>
                              </tr>
                              <tr id="pf0">
                                <td class="boldEleven">PF TYPE</td>
                                <td class="boldEleven"><select name="optpf" id="optpf" class="formText135" onChange="pftypechange()"  style="width:165" tabindex="49">
                                    <option value="0">Select PF  TYPE</option>
                                    <option value="A">Amount</option>
                                    <option value="P">Percentage</option>
                                </select></td>
                              </tr>
                              <tr id="pf1">
                                <td class="boldEleven">PF Number</td>
                                <td class="boldEleven"><input name="txtpfno" id="txtpfno" type="text" class="formText135" size="30" maxlength="12"  onkeypress="return numeric_only(event,'txtpfno','15');" tabindex="40" onKeyUp="CheckUnique(this,'divpfnumber','com_m_staff','CHR_PFNO')" />
                                    <div id='divpfnumber'></div></td>
                              </tr>
                              <tr id="pf2">
                                <td class="boldEleven">PF Amount</td>
                                <td class="boldEleven"><input name="txtpfvalue"  id="txtpfvalue"  type="text" class="formText135" onKeyPress=" return  numeric_priceonly(event,'txtpfvalue','12' )" size="30"	maxlength="8"  tabindex="51"/></td>
                              </tr>
                              <tr>
                                <td class="boldEleven">PF Nominee <font
																class="bolddeepred" align="absmiddle"> *</font></td>
                                <td class="boldEleven"><input name="nominee" type="text" class="formText135" id="nominee" size="30" maxlength="50"></td>
                              </tr>
                              <tr>
                                <td class="boldEleven">Relationship<font
																class="bolddeepred" align="absmiddle"> *</font></td>
                                <td class="boldEleven">
								<select name="pfnomineerelationship" class="formText135" id="pfnomineerelationship"   style="width:165">
								<option value="0">Select Relationship</option>
								<option value="F" selected="selected"> Father</option>
								<option value="M">Mother</option>
								<option value="W">wife</option>
								<option value="H">Husband</option>
								<option value="G">Guardian</option>
								<option value="S">Son</option>
								<option value="D">Daugther</option>
                                </select>                                </td>
                              </tr>
                          </table></td>
                          <td width="52%"><table width="100%" border="0" align="center"
														cellpadding="1" cellspacing="2">
                              <tr>
                                <td height="21" colspan="2" class="boldEleven"><div align="center"><strong> ESI </strong></div></td>
                              </tr>
                              <tr>
                                <td width="120" height="21" class="boldEleven">ESI<font
																class="bolddeepred" align="absmiddle"> *</font></td>
                                <td class="boldEleven"><select name="esi" class="formText135" id="esi"  onchange="ESIchange()"  style="width:165" tabindex="53">
                                    <option value="0">Select esi </option>
                                    <option value="Y">Yes</option>
                                    <option value="N">No</option>
                                    <option value="C">Common</option>
                                </select></td>
                              </tr>
                              <tr id="ppf0">
                                <td height="21" class="boldEleven">ESI TYPE</td>
                                <td class="boldEleven"><select name="optesi" class="formText135" id="optesi" onChange="esitypechange()"  style="width:165" tabindex="54">
                                    <option value="0">Select esi  TYPE</option>
                                    <option value="A">Amount</option>
                                    <option value="P">Percentage</option>
                                </select></td>
                              </tr>
                              <tr id="ppf1">
                                <td class="boldEleven">ESI Number</td>
                                <td class="boldEleven"><input name="txtesno"
																id="txtesno" type="text" class="formText135"
																 size="30" maxlength="12" value=""  tabindex="55"  onKeyPress="return numeric_only(event,'txtesno','14'); "  onKeyUp="CheckUnique(this,'divesinumber','com_m_staff','CHR_ESINO')" />
                                    <div id='divesinumber'></div>
                                  <div id="ESIDiv"></div></td>
                              </tr>
                              <tr id="ppf2">
                                <td class="boldEleven">ESI Amount</td>
                                <td class="boldEleven"><input name="txtesivalue"  id="txtesivalue" type="text" class="formText135" onKeyPress="return numeric_priceonly(event,'txtesivalue','10'); " size="30" 	maxlength="8"  tabindex="56"/></td>
                              </tr>
                              <tr>
                                <td class="boldEleven">Dispensary</td>
                                <td class="boldEleven"><select id="dispensary" name="dispensary" class="formText135"   style="width:165" tabindex="13">
                                    <option value="0">Select Dispensary</option>
                                    <%
		   String Disdata[][] = CommonFunctions.QueryExecute("Select INT_DESPID,CHR_DESPNAME From com_m_dispensary order by INT_DESPID ");
		   for(int c=0;c<Disdata.length;c++)
		   		out.println("<option value='"+Disdata[c][0]+"'>"+Disdata[c][1]+"</option>");
		   %>
                                </select></td>
                              </tr>
                              <tr>
                                <td class="boldEleven">Date of PF &amp; ESI Registration </td>
                                <td class="boldEleven"><input title="dd/mm/yyyy"   name="pfesidate" id="pfesidate" type="text" class="formText135" size="30" maxlength="10"  readonly="true" tabindex="52"/>
                                  <script language="JavaScript" type="text/javascript">setCurrentDate('pfesidate'); </script>
                                  <span class="boldred">(dd-mm-yyyy) </span></td>
                              </tr>
                              <tr>
                                <td class="boldEleven">&nbsp;</td>
                                <td class="boldEleven"><input name="revisiondate" type="hidden" id="revisiondate">
                                    <input title="dd/mm/yyyy"  name="resigndate" id="resigndate" type="hidden" class="formText135" size="30" maxlength="10"  readonly="true" tabindex="57"/>                                </td>
                              </tr>
                          </table></td>
                        </tr>
                         
                        <tr>
                          <td colspan="2" class="boldEleven"></td>
                        </tr>
						<tr>
                          <td colspan="2" class="boldEleven">						 </td>
                  </tr>
                   
                         
                      </table>
                    </fieldset>					</td>
                  </tr>
				  <tr>
				    <td height="19">&nbsp;</td>
				    <td>&nbsp;</td>
			    </tr>
				  <tr>
                    <td colspan="2">
					<fieldset>
                      <legend><strong><img src="../images/icon-misuse.gif"> Personal Information</strong> </legend>
					  <table width="100%" border="0" cellspacing="2" cellpadding="2">
                        <tr>
                          <td width="48%"><table width="100%" border="0" align="center">
                            <tr>
                              <td width="44%" class="boldEleven">PAN Number</td>
                              <td width="56%"><input name="pannumber" type="text" class="formText135" id="pannumber" onKeyUp="upperMe(this), LoadUniqueCheck('pannumber', 'pandiv', 'com_m_staff', 'CHR_PAN', 'Submit')" size="30" maxlength="20"  tabindex="58"    onBlur="upperMe(this)"   />
                                  <div id="pandiv"></div></td>
                            </tr>
                            <tr>
                              <td class="boldEleven">PASS PORT Number</td>
                              <td><input name="passportnumber" type="text" class="formText135" id="passportnumber" onKeyUp="upperMe(this), LoadUniqueCheck('passportnumber', 'passportnumberdiv', 'com_m_staff', 'CHR_PASSPORT', 'Submit')" size="30" maxlength="20"  tabindex="59"   onBlur="upperMe(this)"   />
                                  <div id="passportnumberdiv"></div></td>
                            </tr>
                            <tr>
                              <td class="boldEleven">DRIVING LICENSE Number</td>
                              <td><input name="drivingnumber" type="text" class="formText135" id="drivingnumber" onKeyUp="upperMe(this), LoadUniqueCheck('drivingnumber', 'drivingdiv', 'com_m_staff', 'CHR_DRIVING', 'Submit')" size="30" maxlength="20"  tabindex="60"   onBlur="upperMe(this)"   />
                                  <div id="drivingdiv"></div></td>
                            </tr>
                          </table></td>
                          <td width="52%" align="left"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                              <td width="32%" class="boldEleven">Previous Details </td>
                              <td width="68%" rowspan="3" align="left" valign="top"><textarea name="previousdetails"  onkeyup="textArea('previousdetails','2000')"    onBlur="upperMe(this)"     cols="26" rows="5" class="formText135" id="previousdetails"   tabindex="61"></textarea></td>
                            </tr>
                            <tr>
                              <td>&nbsp;</td>
                            </tr>
                            <tr>
                              <td>&nbsp;</td>
                            </tr>
                          </table></td>
                        </tr>
                      </table>
					  </fieldset>
					</td>
                  </tr>
                  <tr>
                    <td height="19">&nbsp;</td>
                    <td><input name="filename" type="hidden" id="filename" value="StaffRegistrationWithPhoto" />
                        <input name="actionS" type="hidden" id="actionS" value="GENStaffRegistration" />
                        <input name="duplicatecheck" type="hidden" id="duplicatecheck" value="N"></td>
                  </tr>
                  <tr>
                    <td height="19" colspan="2"><table border="0" align="center" cellpadding="2"
										cellspacing="2">
                        <tr>
                          <td width="56"><input type="submit" name="Submit"
												id="Submit" class="buttonbold"  value="Add"   accesskey="s"     tabindex="62"/></td>
                          <td width="56"><input type="button" name="submit" class="buttonbold"
												 value="Close"   accesskey="c" 
												onclick="redirect('StaffRegistrationView.jsp')"   tabindex="63"/></td>
                        </tr>
                    </table></td>
                  </tr>
                </table>
              <span class="style1"></span></td>
            </tr>
          </table>
		</form>		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>		</td>
	</tr>
</table>
<%@ include file="../footer.jsp"%>
 

</body>

</html>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
	System.out.println(e.getMessage());
}
%>