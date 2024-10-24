<%@ page language="java" import="java.sql.*" errorPage=""%>
<%@ page language="java" import="com.my.org.erp.common.*"%>
<link rel="icon" type="image/ico" href="images/ERP.ico"></link>
<link rel="shortcut icon" href="images/ERP.ico"></link>
<link href="JavaScript/SmartStyles.css" rel="stylesheet" type="text/css">
<%
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", -1);
response.setHeader("Cache-Control", "no-store");
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
response.setDateHeader("Expires", 0); // Proxies.
 
%>
<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright"
	content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords"
	content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />
<meta http-equiv="Cache-Control"
	content="no-cache, no-store, must-revalidate">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="0">


<script language="javascript" src="JavaScript/comfunction.js"></script>
<script language="JavaScript" src="calendar1.js"> </script>
<script language="javascript">
function Validate()
{
	try
	{
		if(
		checkNull('F1','Select Resume ')
		&& checkNull('name','Enter the Name')
		&& checkNull('fname','Enter the Father naem')
		&& checkNull('dob','Date of Birth')
		&& checkNullSelect('gender','Select Gender','0')
		&& checkNullSelect('marital','Select marital status','0')
		&& checkNull('currentlocation','Enter Current Location')
		&& checkNull('interestedlocation','Enter Interested Location')
		&& checkNull('previousdetails','Enter Previous Details')
		&& checkNullSelect('language1','Select language1  ','0')
		&& checkNullSelect('qualification','Select Qualification','0')
		&& checkNull('emailid','Enter emailid')
		&& checkEmail('emailid')
		&& checkNull('mobile','Entar Mobile Number')
		&& checkNullSelect('yearofexperience','Select year of experience','0')
		&& checkNull('applypost','Entar the Applied post to ')
		
		&& checkNull('F1','Select Resume ')
		&& UploadCheck()
		)
			return true;
		else
			return false;
	}
	catch(err)
	{
		alert(err);
	}		
}


 function UploadCheck()
  	{
  		if( checkNull('F1','Select Resume ') )
  		{
			var file = document.getElementById("F1").value;
			var fileExtn = file.lastIndexOf(".");
			var Extn=file.substring(fileExtn);
			if((Extn == ".DOC") ||(Extn == ".doc"))
			{
				return true;
			}
			else
			{
				alert("Please Upload Document (*.doc) Files only");
				return false;
			}
		}
   		else
		{
   			
			return false;
  		}
		
 	}  
	

 
</script>

<link rel="stylesheet" href="dist/css/site.min.css">

</head>
<body>
<!--nav-->
    <nav role="navigation" class="navbar navbar-custom">
        <div class="container-fluid">
          <!-- Brand and toggle get grouped for better mobile display -->
          <div class="navbar-header"><img src="images/top_banner.png"/></div>

          <div id="bs-content-row-navbar-collapse-5" class="collapse navbar-collapse">
            <ul class="nav navbar-nav navbar-right">
              <li class="active"><a href="index.jsp">Home</a></li>
			  <li class="active"><a href="Career.jsp">Career</a></li>
			  <li class="active"><a href="Employee Verififcation.jsp">Verification</a></li>
			  <li class="active"><a href="contact.jsp">Contact</a></li>
			</ul>
			</div>
			
        </div>
      </nav>
    
    
	
	
	<div class="container-fluid">
    <!--documents start-->
	
<form name="frm" enctype="multipart/form-data" action="CareerRes.jsp" method="post" onSubmit="return Validate()">


<table border="0" align="center" cellpadding="2" cellspacing="2" class="table">
	<tbody>
		<tr>
			<td class="boldEleven">&nbsp;</td>
			<td colspan="3" class="boldEleven">
			  <div class="boldred" align="right"><span class="errormessage">*</span>
			    denotes mandatory</div>
		  </td>
		</tr>
		<tr>
			<td colspan="4" class="copyright">
			<div align="center">Personal Information's</div>
			</td>
		</tr>
		<tr>
			<td class="boldEleven" width="25%">First Name <span
				class="errormessage">*</span></td>
			<td class="boldEleven" width="34%"><input name="name"
				class="formText135" id="name" size="30" maxlength="100"
				style="text-transform: uppercase"></td>
			<td width="18%" class="boldEleven">Email id <span class="errormessage">*</span></td>
			<td class="boldEleven" width="23%"><input name="emailid"
				class="formText135" id="emailid" size="30" maxlength="100"></td>
		</tr>
		<tr>
			<td class="boldEleven">Father's Name <span class="errormessage">*</span>
			</td>
			<td class="boldEleven"><input name="fname" class="formText135"
				id="fname" size="30" maxlength="100"
				style="text-transform: uppercase"></td>
			<td class="boldEleven">Mobile<span class="errormessage">*</span></td>
			<td class="boldEleven"><input name="mobile" class="formText135"
				id="mobile" size="30"
				onKeyPress="return numeric_only(event,'mobile','17')" maxlength="12"></td>
		</tr>
		<tr>
			<td class="boldEleven">Date of Birth <span class="errormessage">*</span></td>
			<td class="boldEleven"><input name="dob" class="formText135"
				id="dob" value="01-01-2009" size="18" maxlength="12"> <a
				href="javascript:cal3.popup();"><img
				alt="Click here to Pick Up the Date" src="Loginimages/cal.gif"
				border="0" width="16">&nbsp;&nbsp;</a>(dd-mm-yyyy) <script
				language="JavaScript" type="text/javascript">
																 
  	var cal3=new calendar1(document.forms['frm'].elements['dob']);
  	cal3.year_scroll=true;
  	cal3.time_comp=false;

            </script></td>
			<td class="boldEleven">Year of Experience <span
				class="errormessage">*</span></td>
			<td class="boldEleven"><select name="yearofexperience"
				id="yearofexperience">
				<option value="0" selected="selected">Select</option>
				<option value="-1">Below one year</option>
				<option value="-2">Below 6-months</option>
				<option value="-3">Fresher</option>
				<option value="1">1+</option>
				<option value="2">2+</option>
				<option value="3">3+</option>
				<option value="4">4+</option>
				<option value="5">5+</option>
				<option value="6">6+</option>
				<option value="7">7+</option>
				<option value="8">8+</option>
				<option value="9">9+</option>
				<option value="10">10+</option>
				<option value="11">11+</option>
				<option value="12">12+</option>
				<option value="13">13+</option>
				<option value="14">14+</option>
				<option value="15">15+</option>
				<option value="16">16+</option>
				<option value="17">17+</option>
				<option value="18">18+</option>
				<option value="19">19+</option>
				<option value="20">20+</option>
				<option value="21">21+</option>
				<option value="22">22+</option>
				<option value="23">23+</option>
				<option value="24">24+</option>

			</select></td>
		</tr>
		<tr>
			<td class="boldEleven">Gender <span class="errormessage">*</span>
			&nbsp;&nbsp;&nbsp;</td>
			<td class="boldEleven"><select name="gender" id="gender"
				class="formText135">
				<option value="0" selected="selected">Select</option>
				<option value="F">Female</option>
				<option value="M">Male</option>
			</select></td>
			<td class="boldEleven">Applied post to <span
				class="errormessage">*</span></td>
			<td class="boldEleven"><input style="text-transform: uppercase"
				name="applypost" class="formText135" id="applypost" size="30"
				maxlength="100"></td>
		</tr>
		<tr>
			<td class="boldEleven">Marital Status <span class="errormessage">*</span></td>
			<td class="boldEleven"><select name="marital" id="marital"
				class="formText135">
				<option value="0" selected="selected">Select</option>
				<option value="D">Divorcee</option>
				<option value="M">Married</option>
				<option value="S">Single</option>
			</select></td>
			<td class="boldEleven">Reference care employee</td>
			<td class="boldEleven"><input name="referencename"
				style="text-transform: uppercase" class="formText135"
				id="referencename" size="30" maxlength="100"></td>
		</tr>
		<tr>
			<td class="boldEleven">Current Location <span
				class="errormessage">*</span></td>
			<td class="boldEleven"><input style="text-transform: uppercase"
				name="currentlocation" class="formText135" id="currentlocation"
				size="30" maxlength="26"></td>
			<td class="boldEleven">Reference care employee phone</td>
			<td class="boldEleven"><input style="text-transform: uppercase"
				name="referencephone" class="formText135" id="referencephone"
				size="30" maxlength="100"></td>
		</tr>
		<tr>
			<td class="boldEleven">Interested Location <span
				class="errormessage">*</span></td>
			<td class="boldEleven"><input style="text-transform: uppercase"
				name="interestedlocation" class="formText135"
				id="interestedlocation" size="30" maxlength="26"></td>
			<td class="boldEleven">Ex-Employee</td>
			<td class="boldEleven"><input value="1" name="exemployee"
				id="exemployee" class="formText135" type="radio"> Yes <input
				checked="checked" value="0" name="exemployee" id="exemployee"
				class="formText135" type="radio"> No</td>
		</tr>
		<tr>
			<td class="boldEleven">Language Proficiency Details <span
				class="errormessage">*</span></td>
			<td class="boldEleven">
			<table border="0" cellpadding="0" cellspacing="0" width="80%">
				<tbody>
					<tr>
						<td class="boldEleven">(1.)</td>
						<td><select name="language1" id="language1"
							class="formText135">
							<option value="0" selected="selected">Select</option>
							<option value="ENGLISH">ENGLISH</option>
							<option value="HINDI">HINDI</option>
							<option value="KANNADA">KANNADA</option>
							<option value="MALAYALAM">MALAYALAM</option>
							<option value="TAMIL">TAMIL</option>
							<option value="TELUGU">TELUGU</option>
							<option value="URDU">URDU</option>
						</select></td>
						<td><input value="X" name="read1" class="formText135"
							type="checkbox"></td>
						<td class="boldEleven">Read</td>
						<td class="boldEleven"><input value="X" name="write1"
							class="formText135" type="checkbox"></td>
						<td class="boldEleven">Write</td>
						<td class="boldEleven"><input value="X" name="speak1"
							class="formText135" type="checkbox"></td>
						<td class="boldEleven">Speak</td>
					</tr>
				</tbody>
			</table>
			</td>
			<td class="boldEleven">Do you have a bike</td>
			<td class="boldEleven"><input value="1" name="bike"
				class="formText135" type="radio"> Yes <input
				checked="checked" value="0" name="bike" class="formText135"
				type="radio"> No</td>
		</tr>
		<tr>
			<td class="boldEleven">&nbsp;</td>
			<td class="boldEleven">
			<table border="0" cellpadding="0" cellspacing="0" width="80%">
				<tbody>
					<tr>
						<td class="boldEleven">(2.)</td>
						<td><select name="language2" class="formText135">
							<option value="0" selected="selected">Select</option>
							<option value="ENGLISH">ENGLISH</option>
							<option value="HINDI">HINDI</option>
							<option value="KANNADA">KANNADA</option>
							<option value="MALAYALAM">MALAYALAM</option>
							<option value="TAMIL">TAMIL</option>
							<option value="TELUGU">TELUGU</option>
							<option value="URDU">URDU</option>
						</select></td>
						<td><input value="X" name="read2" class="formText135"
							type="checkbox"></td>
						<td class="boldEleven">Read</td>
						<td class="boldEleven"><input value="X" name="write2"
							class="formText135" type="checkbox"></td>
						<td class="boldEleven">Write</td>
						<td class="boldEleven"><input value="X" name="speak2"
							class="formText135" type="checkbox"></td>
						<td class="boldEleven">Speak</td>
					</tr>
				</tbody>
			</table>
			</td>
			<td class="boldEleven">Passport No</td>
			<td class="boldEleven"><input name="passportno"
				class="formText135" size="30" maxlength="26"></td>
		</tr>
		<tr>
			<td class="boldEleven">&nbsp;</td>
			<td class="boldEleven">
			<table border="0" cellpadding="0" cellspacing="0" width="80%">
				<tbody>
					<tr>
						<td class="boldEleven">(3.)</td>
						<td><select name="language3" class="formText135">
							<option value="0" selected="selected">Select</option>
							<option value="ENGLISH">ENGLISH</option>
							<option value="HINDI">HINDI</option>
							<option value="KANNADA">KANNADA</option>
							<option value="MALAYALAM">MALAYALAM</option>
							<option value="TAMIL">TAMIL</option>
							<option value="TELUGU">TELUGU</option>
							<option value="URDU">URDU</option>
						</select></td>
						<td><input value="X" name="read3" class="formText135"
							type="checkbox"></td>
						<td class="boldEleven">Read</td>
						<td class="boldEleven"><input value="X" name="write3"
							class="formText135" type="checkbox"></td>
						<td class="boldEleven">Write</td>
						<td class="boldEleven"><input value="X" name="speak3"
							class="formText135" type="checkbox"></td>
						<td class="boldEleven">Speak</td>
					</tr>
				</tbody>
			</table>
			</td>
			<td class="boldEleven">Passport Expire Date</td>
			<td class="boldEleven"><input name="passdate" id="passdate"
				class="formText135" value="11-06-2013" maxlength="12" readonly>
			<a href="javascript:cal4.popup();"><img
				alt="Click here to Pick Up the Date" src="Loginimages/cal.gif"
				border="0" width="16">&nbsp;&nbsp;</a>(dd-mm-yyyy) <script
				language="JavaScript" type="text/javascript">
																 
  	var cal4=new calendar1(document.forms['frm'].elements['passdate']);
  	cal4.year_scroll=true;
  	cal4.time_comp=false;
	setCurrentDate('passdate');
            </script></td>
		</tr>
		<tr>
			<td class="boldEleven">Qualification<span class="errormessage">*</span></td>
			<td class="boldEleven"><select name="qualification" size="1"
				class="formText135" id="qualification">
				<option selected="selected" value="0">Select</option>
				  <%
				 String qdata[][] =  CommonFunctions.QueryExecute( "SELECT INT_QUALIFICATIONID,CHR_QUALIFICATIONNAME   FROM com_m_qualification ORDER BY CHR_QUALIFICATIONNAME");
								for(int u=0; u<qdata.length; u++)
									out.print("<option value='"+qdata[u][0]+"'>"+ qdata[u][1] +"</option>");
							%>


			</select></td>
			<td class="boldEleven">&nbsp;</td>
			<td class="boldEleven">&nbsp;</td>
		</tr>
		<tr>
			<td class="boldEleven" align="left" valign="top">Key Skills</td>
			<td class="boldEleven" align="left" valign="top"><textarea
				name="interestarea" cols="30" rows="5" class="formText135"
				onKeyUp="textArea('interestarea','1900')"></textarea></td>
			<td class="boldEleven" align="left" valign="top">Certificates
			(if any)</td>
			<td class="boldEleven" align="left" valign="top"><textarea
				name="certificates" cols="30" rows="5" class="formText135"
				onKeyUp="textArea('interestarea','1900')"></textarea></td>
		</tr>
		<tr>
			<td class="boldEleven" valign="top">Previous company details <span
				class="errormessage">*</span></td>
			<td class="boldEleven" valign="top"><textarea
				name="previousdetails" cols="30" rows="5" class="formText135"
				id="previousdetails" onKeyUp="textArea('interestarea','1900')"></textarea></td>
			<td class="boldEleven" valign="top">Breif description</td>
			<td class="boldEleven" valign="top"><textarea name="description"
				cols="30" rows="5" class="formText135" id="description"
				onKeyUp="textArea('description','1900')"></textarea></td>
		</tr>
		<tr>
			<td class="boldEleven"><b>Choose the file To Upload  <span
				class="errormessage">*</span></b></td>
			<td class="boldEleven"><input name="F1" id="F1" type="file">
			  <span class="errormessage">			(.doc only)</span></td>
			<td class="boldEleven">&nbsp;</td>
			<td class="boldEleven">&nbsp;</td>
		</tr>
		<tr>
			<td colspan="4" class="boldEleven">
			<table align="center" border="0" cellpadding="0" cellspacing="3" >
				<tbody>
					<tr>
						<td align="center" valign="middle" >
						<div align="center"><input class="btn btn-info" name="Submit2"
							value="Submit" accesskey="s" type="submit"></div>
						</td>
						<td align="center" valign="middle" >&nbsp;</td>
						<td align="center" valign="middle" >
						<div align="center"><input class="btn btn-info" name="Submit"
							value="Close" accesskey="c" onClick="redirect('Login.jsp')"
							type="Button"></div>
						</td>
					</tr>
				</tbody>
			</table>
			</td>
		</tr>
		<tr>
			<td class="boldEleven">&nbsp;</td>
			<td class="boldEleven">&nbsp;</td>
			<td class="boldEleven">&nbsp;</td>
			<td class="boldEleven">&nbsp;</td>
		</tr>
	</tbody>
</table>

</form>
		
	 <!--documents end-->
    </div>
   
   
 
</body>
</html>