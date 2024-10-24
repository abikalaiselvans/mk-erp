<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*,java.io.*" errorPage=""%>
<html>
<head>
<link rel="icon" type="image/ico" href="images/ERP.ico"></link>
<link rel="shortcut icon" href="images/ERP.ico"></link>



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

<title>Mythra</title>
<%@ include file="JavaScript/dynamicStylesheet.jsp"%>
<style type="text/css">
<!--
body {
	background-color: #BBFFFF;
}
-->
</style>
<%@ include file="JavaScript/dynamicStylesheet.jsp"%>
</head>
<script language="javascript" src="JavaScript/comfunction.js"></script>
<script language="JavaScript" src="calendar1.js"> </script>
<script language="javascript">
function Validate()
{
	if(
		checkNull('name','Enter the Name')
		&& checkNull('fname','Enter the Father naem')
		&& checkNull('dob','Date of Birth')
		&& checkNullSelect('gender','Select Gender','0')
		&& checkNullSelect('marital','Select marital status','0')
		&& checkNull('currentlocation','Enter Current Location')
		&& checkNull('interestedlocation','Enter Interested Location')
		&& checkNullSelect('language1','Select language1  ','0')
		&& checkNullSelect('qualification','Select Qualification','0')
		&& chkemail('emailid')
		&& checkNull('mobile','Entar Mobile Number')
		&&  checkNullSelect('yearofexperience','Select yearofexperience','0')
	)
		return true;
	else
		return false;
}

/*
name,fname,dob,gender,marital,
language1,read1,write1,speak1
language2,read2,write2,speak2
language3,read3,write3,speak3
exemployee,passportno,passdate,
qualification,interestarea,certificates
emailid,Mobile,yearofexperience,
applypost,
referencename,
previousdetails
*/
</script>
<body onpaste='return false;'>
<%
try
{
%>

<form name="frm" method="post" action="SmartLoginAuth"
	onSubmit="return Validate()">
<table width="100%" border="0" cellspacing="2" cellpadding="2">
	<tr>
		<td align="center"><OBJECT
			codeBase=http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,40,0
			height=156 width=974
			classid=clsid:d27cdb6e-ae6d-11cf-96b8-444553540000>
			<PARAM NAME="wmode" VALUE="transparent">
			<PARAM NAME="src" VALUE="Careimages/care_main.swf">
			<PARAM NAME="width" VALUE="974">
			<PARAM NAME="height" VALUE="156">
			<embed src="Careimages/care_main.swf" width="974" height="156"
				type="application/x-shockwave-flash" wmode="transparent"></embed></OBJECT></td>
	</tr>
	<tr>
		<td>
		<div align="right"><a href="index.jsp">Home</a></div>
		</td>
	</tr>
	<tr>
		<td>
		<table width="559" border="0" align="center" cellpadding="2"
			cellspacing="2">
			<tr>
				<td class="boldEleven">&nbsp;</td>
				<td class="boldEleven">
				<div align="right" class="boldred"><span class="errormessage">*</span>
				denotes mandatory</div>
				</td>
			</tr>
			<tr>
				<td colspan="2" class="copyright">
				<div align="center">Please verify your Personal Information's
				and upload your resume <%
		 String id = ""+session.getAttribute("CAREERID");
		 if(id == "null")
		 	response.sendRedirect("Career.jsp");
		String sql="";
		
sql = " SELECT CHR_NAME,CHR_FATHERNAME,DATE_FORMAT(CHR_DOB,'%d-%m-%Y'),CHR_GENDER,CHR_MARITIAL, ";
sql = sql + " CHR_LANGUAGE1,CHR_READ1,CHR_WRITE1,CHR_SPEAK1, ";
sql = sql + " CHR_LANGUAGE2,CHR_READ2,CHR_WRITE2,CHR_SPEAK2, ";
sql = sql + " CHR_LANGUAGE3,CHR_READ3,CHR_WRITE3,CHR_SPEAK3, ";
sql = sql + " CHR_EXSTAFF,CHR_PASSPORT,DATE_FORMAT(DAT_PASSPORTVALIDITY,'%d-%m-%Y'),INT_QUALIFICATIONID,CHR_AREAOFINTEREST, ";
sql = sql + " CHR_CERTIFICATE,CHR_PREVIOUSDETAILS,CHR_EMAIL,INT_MOBILE,INT_EXPERIENCE,CHR_APPLIEDPOST, ";
sql = sql + " CHR_REF,CHR_RESUMESTATUS,CHR_DESCRIPTION,CHR_CURRENTLOCATION,CHR_INTERESTEDLOCATION,CHR_REFNUMBER,CHR_BIKESTATUS ";
sql = sql + " FROM com_m_careers WHERE INT_CAREERID= "+id;
//out.println(sql);
String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		%>
				</div>
				</td>
			</tr>
			<tr>
				<td class="boldEleven">&nbsp;</td>
				<td class="boldEleven">&nbsp;</td>
			</tr>
			<tr>
				<td class="boldEleven">&nbsp;</td>
				<td class="boldEleven">
				<table width="56" border="0" cellspacing="2" cellpadding="2">
					<tr>
						<td><input name="Button2" type="Button" class="buttonbold13"
							onClick="return ProfileUpload('<%=id%>')" value="Upload Resume"></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td class="boldEleven">&nbsp;</td>
				<td class="boldEleven">&nbsp;</td>
			</tr>
			<tr>
				<td width="41%" class="boldEleven">First Name <span
					class="errormessage">*</span></td>
				<td width="59%" class="boldEleven"><input name="name"
					class="formText135" id="name" value="<%=data[0][0]%>" size="30"
					maxlength="100"></td>
			</tr>
			<tr>
				<td class="boldEleven">Father's Name <span class="errormessage">*</span>
				</td>
				<td class="boldEleven"><input name="fname" class="formText135"
					id="fname" value="<%=data[0][1]%>" size="30" maxlength="100"></td>
			</tr>
			<tr>
				<td class="boldEleven">Date of Birth <span class="errormessage">*</span></td>
				<td class="boldEleven"><input name="dob" class="formText135"
					id="dob" value="<%=data[0][2]%>" size="18" maxlength="12">
				<a href="javascript:cal3.popup();"><img
					alt="Click here to Pick Up the Date" src="img/cal.gif" width="16"
					border="0" />&nbsp;&nbsp;</a>(dd-mm-yyyy) <script
					language="JavaScript" type="text/javascript">
																 
  	var cal3=new calendar1(document.forms['frm'].elements['dob']);
  	cal3.year_scroll=true;
  	cal3.time_comp=false;

          </script> <input name="id" type="hidden" id="id" value="<%=id%>">
				<input name="filename" type="hidden" id="filename" value="Career" />
				<input name="actionS" type="hidden" id="actionS"
					value="HRMCareersUpdate" /> <input name="Username" type="hidden"
					id="Username" value="MKS" /></td>
			</tr>
			<tr>
				<td class="boldEleven">Gender <span class="errormessage">*</span>
				&nbsp;&nbsp;&nbsp;</td>
				<td class="boldEleven"><select name="gender"
					class="formText135">
					<option value="0" selected>Select</option>
					<option value="F">Female</option>
					<option value="M">Male</option>
				</select> <script language="javascript">setOptionValue('gender','<%=data[0][3]%>')</script>
				</td>
			</tr>
			<tr>
				<td class="boldEleven">Marital Status <span
					class="errormessage">*</span></td>
				<td class="boldEleven"><select name="marital"
					class="formText135">
					<option value="0" selected>Select</option>
					<option value="D">Divorcee</option>
					<option value="M">Married</option>
					<option value="S">Single</option>
				</select> <script language="javascript">setOptionValue('marital','<%=data[0][4]%>')</script>
				</td>
			</tr>
			<tr>
				<td class="boldEleven">Current Location <span
					class="errormessage">*</span></td>
				<td class="boldEleven"><input name="currentlocation"
					class="formText135" id="currentlocation" value="<%=data[0][31]%>"
					size="30" maxlength="26"></td>
			</tr>
			<tr>
				<td class="boldEleven">Interested Location <span
					class="errormessage">*</span></td>
				<td class="boldEleven"><input name="interestedlocation"
					class="formText135" id="interestedlocation"
					value="<%=data[0][32]%>" size="30" maxlength="26"></td>
			</tr>

			<tr>
				<td class="boldEleven">Language Proficiency Details <span
					class="errormessage">*</span></td>
				<td class="boldEleven">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="boldEleven">(1.)</td>
						<td><select name="language1" class="formText135">
							<option value="0" selected="selected">Select</option>
							<option value="ENGLISH">ENGLISH</option>
							<option value="HINDI">HINDI</option>
							<option value="KANNADA">KANNADA</option>
							<option value="MALAYALAM">MALAYALAM</option>
							<option value="TAMIL">TAMIL</option>
							<option value="TELUGU">TELUGU</option>
							<option value="URDU">URDU</option>
						</select> <script language="javascript">setOptionValue('language1','<%=data[0][5]%>')</script>
						</td>
						<td><input type="checkbox" value="X" name="read1" id="read1"
							class="formText135"> <%
			  
			  	if("X".equals(data[0][6]))
					{
					%> <script language="javascript">
					document.getElementById('read1').checked=true;
					</script> <%
					
					}
			  %>
						</td>
						<td class="boldEleven">Read</td>
						<td class="boldEleven"><input type="checkbox" value="X"
							name="write1" class="formText135"> <%
			  
			  	if("X".equals(data[0][7]))
					{
					%> <script language="javascript">
					document.getElementById('write1').checked=true;
					</script> <%
					
					}
			  %>
						</td>
						<td class="boldEleven">Write</td>
						<td class="boldEleven"><input type="checkbox" value="X"
							name="speak1" class="formText135"> <%
			  
			  	if("X".equals(data[0][8]))
					{
					%> <script language="javascript">
					document.getElementById('speak1').checked=true;
					</script> <%
					
					}
			  %>
						</td>
						<td class="boldEleven">Speak</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td class="boldEleven">&nbsp;</td>
				<td class="boldEleven">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
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
						</select> <script language="javascript">setOptionValue('language2','<%=data[0][9]%>')</script>
						</td>
						<td><input type="checkbox" value="X" name="read2"
							class="formText135"> <%
			  
			  	if("X".equals(data[0][10]))
					{
					%> <script language="javascript">
					document.getElementById('read2').checked=true;
					</script> <%
					
					}
			  %>
						</td>
						<td class="boldEleven">Read</td>
						<td class="boldEleven"><input type="checkbox" value="X"
							name="write2" class="formText135"> <%
			  
			  	if("X".equals(data[0][11]))
					{
					%> <script language="javascript">
					document.getElementById('write2').checked=true;
					</script> <%
					
					}
			  %>
						</td>
						<td class="boldEleven">Write</td>
						<td class="boldEleven"><input type="checkbox" value="X"
							name="speak2" class="formText135"> <%
			  
			  	if("X".equals(data[0][12]))
					{
					%> <script language="javascript">
					document.getElementById('speak2').checked=true;
					</script> <%
					
					}
			  %>
						</td>
						<td class="boldEleven">Speak</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td class="boldEleven">&nbsp;</td>
				<td class="boldEleven">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="boldEleven">(3.)</td>
						<td><select name="language3" class="formText135">
							<option value="0" selected>Select</option>
							<option value="ENGLISH">ENGLISH</option>
							<option value="HINDI">HINDI</option>
							<option value="KANNADA">KANNADA</option>
							<option value="MALAYALAM">MALAYALAM</option>
							<option value="TAMIL">TAMIL</option>
							<option value="TELUGU">TELUGU</option>
							<option value="URDU">URDU</option>
						</select> <script language="javascript">setOptionValue('language3','<%=data[0][13]%>')</script>
						</td>
						<td><input type="checkbox" value="X" name="read3"
							class="formText135"> <%
			  
			  	if("X".equals(data[0][14]))
					{
					%> <script language="javascript">
					document.getElementById('read3').checked=true;
					</script> <%
					
					}
			  %>
						</td>
						<td class="boldEleven">Read</td>
						<td class="boldEleven"><input type="checkbox" value="X"
							name="write3" class="formText135"> <%
			  
			  	if("X".equals(data[0][15]))
					{
					%> <script language="javascript">
					document.getElementById('write3').checked=true;
					</script> <%
					
					}
			  %>
						</td>
						<td class="boldEleven">Write</td>
						<td class="boldEleven"><input type="checkbox" value="X"
							name="speak3" class="formText135"> <%
			  
			  	if("X".equals(data[0][16]))
					{
					%> <script language="javascript">
					document.getElementById('speak3').checked=true;
					</script> <%
					
					}
			  %>
						</td>
						<td class="boldEleven">Speak</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td class="boldEleven">Ex-Employee <%
			String s1= "";
			String s2="";
			if("1".equals(data[0][17]))
				s1=" checked='checked' ";
			if("0".equals(data[0][17]))
				s2=" checked='checked' ";
				
			
		%>
				</td>
				<td class="boldEleven"><input type="radio" <%=s2%> value="1"
					name="exemployee" class="formText135"> Yes <input
					type="radio" <%=s2%> value="0" name="exemployee"
					class="formText135"> No</td>
			</tr>
			<tr>
				<td class="boldEleven">Do you have a bike <%
			s1= "";
			s2="";
			if("1".equals(data[0][34]))
				s1=" checked='checked' ";
			if("0".equals(data[0][34]))
				s2=" checked='checked' ";
				
			
		%>
				</td>
				<td class="boldEleven"><input type="radio" value="1"
					name="bike" class="formText135" <%=s1%>> Yes <input
					type="radio" value="0" name="bike" class="formText135" <%=s2%>>
				No</td>
			</tr>
			<tr>
				<td class="boldEleven">Passport No</td>
				<td class="boldEleven"><input name="passportno"
					class="formText135" value="<%=data[0][18]%>" size="30"
					maxlength="26"></td>
			</tr>
			<tr>
				<td class="boldEleven">Passport Expire Date</td>
				<td class="boldEleven"><input name="passdate"
					class="formText135" maxlength="12" readonly="readonly"> <a
					href="javascript:cal4.popup();"><img
					alt="Click here to Pick Up the Date" src="img/cal.gif" width="16"
					border="0" />&nbsp;&nbsp;</a>(dd-mm-yyyy) <script
					language="JavaScript" type="text/javascript">
																 
  	var cal4=new calendar1(document.forms['frm'].elements['passdate']);
  	cal4.year_scroll=true;
  	cal4.time_comp=false;
setCurrentDate('passdate');
          </script> <%
if(!"-".equals(data[0][19]))
{
	%> <script language="javascript">setOptionValue('passdate','<%=data[0][19]%>')</script>
				<%
}	
%>
				</td>
			</tr>
			<tr>
				<td class="boldEleven">Qualification<span class="errormessage">*</span></td>
				<td class="boldEleven"><select name="qualification" size="1"
					class="formText135" id="qualification">
					<option value="0">Select</option>
					<%
		String ssql=" SELECT INT_QUALIFICATIONID,CHR_QUALIFICATIONNAME FROM com_m_qualification ORDER BY CHR_QUALIFICATIONNAME";
		String qualdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(ssql);
		for(int c=0;c<qualdata.length;c++)
			out.println("<option   value='"+qualdata[c][0].trim()+"'>"+qualdata[c][1]+"</option>");	
	%>
				</select> <script language="javascript">setOptionValue('qualification','<%=data[0][20]%>')</script>
				</td>
			</tr>
			<tr>
				<td align="left" valign="top" class="boldEleven">Area Of
				Interest</td>
				<td align="left" valign="top" class="boldEleven"><textarea
					name="interestarea" cols="30" rows="5" class="formText135"><%=data[0][21]%></textarea></td>
			</tr>
			<tr>
				<td align="left" valign="top" class="boldEleven">Certificates
				(if any)</td>
				<td align="left" valign="top" class="boldEleven"><textarea
					name="certificates" cols="30" rows="5" class="formText135"><%=data[0][22]%></textarea></td>
			</tr>
			<tr>
				<td valign="top" class="boldEleven">Previous company details</td>
				<td valign="top" class="boldEleven"><textarea
					name="previousdetails" cols="30" rows="5" class="formText135"
					id="previousdetails"><%=data[0][23]%></textarea></td>
			</tr>
			<tr>
				<td class="boldEleven">Breif description</td>
				<td class="boldEleven"><textarea name="description" cols="30"
					rows="5" class="formText135" id="description"
					onKeyUp="textArea('description','1900')"><%=data[0][30]%></textarea></td>
			</tr>
			<tr>
				<td class="boldEleven">Email id <span class="errormessage">*</span></td>
				<td class="boldEleven"><input name="emailid"
					class="formText135" id="emailid" value="<%=data[0][24]%>" size="30"
					maxlength="100"></td>
			</tr>
			<tr>
				<td class="boldEleven">Mobile<span class="errormessage">*</span></td>
				<td class="boldEleven"><input name="mobile" class="formText135"
					id="mobile" value="<%=data[0][25]%>" size="30" maxlength="25"
					onKeyPress="phoneValue('mobile','15')"></td>
			</tr>
			<tr>
				<td class="boldEleven">Year of Experience <span
					class="errormessage">*</span></td>
				<td class="boldEleven"><select name="yearofexperience"
					id="yearofexperience">
					<option value="0">Select</option>
					<option value="-1">Below one year</option>
					<option value="-2">Below 6-months</option>
					<option value="-3">Fresher</option>
					<%
			for(int u=1;u<25;u++)
				out.println("<option value=\""+u+"\">"+u+"+</option>");
		%>
				</select> <script language="javascript">setOptionValue('yearofexperience','<%=data[0][26]%>')</script>
				</td>
			</tr>
			<tr>
				<td class="boldEleven">Applied post to</td>
				<td class="boldEleven"><input name="applypost"
					class="formText135" id="applypost" value="<%=data[0][27]%>"
					size="30" maxlength="100"></td>
			</tr>
			<tr>
				<td class="boldEleven">Reference care employee</td>
				<td class="boldEleven"><input name="referencename"
					class="formText135" id="referencename" value="<%=data[0][28]%>"
					size="30" maxlength="100"></td>
			</tr>
			<tr>
				<td class="boldEleven">Reference care employee phone</td>
				<td class="boldEleven"><input name="referencephone"
					class="formText135" id="referencephone" value="<%=data[0][33]%>"
					size="30" maxlength="25"></td>
			</tr>

			<tr>
				<td class="boldEleven">&nbsp;</td>
				<td class="boldEleven">
				<div align="center">
				<%
			String profile = request.getRealPath("")+"/CareersResume/"+id.trim() +".doc";
			File f = new File(profile);
			if (f.exists())
			{
				%> Profile view <a href='<%="CareersResume/"+id.trim()+".doc"%>'><img
					src="Image/report/news_info.gif" width="16" height="16" border="0"></a>
				<%
			}
			%> <script language="javascript">
			
			function ProfileUpload(id)
			{
				var s ='<%=id%>';
				
				if (s != "")
				{
					var f ="ProfileUpload.jsp?staffid="+"<%=id%>";
					newWindow = window.open(f,"subWind",",,height=250,width=325,top=0,left=0");
					newWindow.focus( );
				}
				return true 	
			}
		</script></div>
				</td>
			</tr>
			<tr>
				<td colspan="2" class="boldEleven">
				<table width="223" border="0" align="center" cellpadding="0"
					cellspacing="3">
					<tr>
						<td width="111" align="center"><input class="buttonbold14"
							type="submit" name="Submit2" value="Update"></td>
						<td width="103"><input class="buttonbold14" type="Button"
							name="Submit" value="Close" accesskey="c"
							onClick="redirect('Login.jsp')"></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td class="boldEleven">&nbsp;</td>
				<td class="boldEleven">&nbsp;</td>
			</tr>
		</table>
		</td>
	</tr>

	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<br>
<jsp:include page="footer.jsp" flush="true" /> <br>
</form>

<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>

</body>
</html>
