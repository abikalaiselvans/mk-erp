<%@ page
	import="java.sql.*,java.io.*,com.my.org.erp.bean.Attendance.StaffRegistration,java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>

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
String staffid=""+request.getParameter("staffid");
boolean rflag=false;
if(com.my.org.erp.common.CommonFunction.RecordExist("SELECT COUNT(*) FROM com_m_staff WHERE CHR_TYPE='T' AND CHR_EMPID='"+staffid+"'"))
{
	rflag=true;
%>
<script language="javascript">
	alert("This is Resigned Staff details ");

</script>

<%

}


String dt[];
boolean flag = StaffRegistration.RecordExist(staffid);
String staffDetails = ""+StaffRegistration.RecordValue(staffid);
if(flag == false)
	response.sendRedirect("Staff Registration.jsp?staff="+staffid);

String staffVal[] = staffDetails.split("~");
String dbvalue="";
String value="";
String dbvalue1="";
%>
<html>
<head>

<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/AJAXFunctionStaff.js"></script>
<script language="JavaScript"
	src="../JavaScript/Attendance/AttendanceAjax.js"></script>
<script language="javascript"
	src="../JavaScript/Attendance/ReportAjax.js"></script>
<script language="javascript" src="../JavaScript/AJAX.js"></script>
<script language="JavaScript" src="../JavaScript/commonAJAX.js"></script>
<script language="javascript"
	src="../JavaScript/common/PermanentSelectChangesCountry.js"></script>
<script language="javascript"
	src="../JavaScript/common/communicationSelectChangesCountry.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"> </script>

<script language="javascript">	
 

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
		document.a.ccity.selectedIndex = 0;
		document.a.cdistrict.selectedIndex = 0;
		document.a.cstate.selectedIndex = 0;
		document.a.ccountry.selectedIndex = 0;
		document.a.cpincode.value = "";
		document.a.cphone.value = "";
		
	}
	return true;
}//end of resoffval

 

function validateFields()
{

    var Email=document.getElementById("emailid");
    if((Email.value.length)!=0)
  	{
  	  if(emailcheck(Email.value)==false)
  		{
  	 		Email.value="";
  	 		Email.focus();
  	 		return false;  	
  		}
  	}  

   	var dval = document.a.dob.value;

	if (dval != "")
	{
		var d1 = document.a.dob.value.split("-");

		if ((d1[0]>31)|| (d1[1]>12) ||  (d1[1]==2 && d1[0]>29))
		{
			alert("Please Check the Date");
			document.a.dob.focus();
			return false;
		}
	}

	if(document.a.dob.value != "" && document.a.wedding.value != "")
	{

		var d1 = document.a.dob.value.split("-");
		var d2 = document.a.wedding.value.split("-");

		var diff = parseInt(d1[2])+parseInt(18);


		if(d2[2]<diff)
		{
			alert("Wedding Age must be over 18 years...");
			document.a.dob.focus();
			return false;
		}	
	}	
	
	if(dval != "" && document.a.doj.value != "")	{

		var d1 = document.a.dob.value.split("-");
		var d2 = document.a.doj.value.split("-");

		var diff = parseInt(d1[2])+parseInt(15);
		
		
		if(d2[2]<diff)		{
			alert("Date of Joining must be above 15 years from Date of Birth...");
			document.a.dob.focus();
			return false;
		}
	}
		

   	 if(
	   	 checkNull('id','Enter Staff ID') 
	   	 && checkNullSelect('company','Select Company Name','0')
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
		&& checkNullSelect('off','Select Office Name','0')   	
		 && checkNullSelect('depart','Select Department Name','0')
		 && checkNullSelect('desig','Select Designation Name','0')
		 && checkNullSelect('company','Select Company Name','0')
		  && checkNull('branch','Enter Branch Name')
		 && checkNullSelect('qualification','Select qualification','0')
		 && checkNullSelect('bank','Select Bank','0')
		 && checkNullSelect('bg','Select Blood Group','0')
		 && checkNullSelect('Category','Select Category','0')

	   	 )
		
   	 	   return true;
   	 else
		   return false;	  
}	
   
   
   
   
	function consolidateCheck()
	{
		var f = true;
		if(checkSalaryType())
			f = checkSalaryBand();
		
		return f;	
	}
   
   
   
   
</script>
<title><%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='COM' ")[0][0]%></title>



</head>
<%@ include file="insert.jsp"%>
<form AUTOCOMPLETE="off" name="a" method="post"
	action="../SmartLoginAuth" onsubmit="return validateFields()">
<body onpaste="return false;" leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0">
<table width="100%" border="0">
	<tr>
		<td class="boldEleven"><input name="path" id="path" type="hidden"
			value="<%=path%>"></td>
	</tr>
	<tr>
		<td height="59">&nbsp;</td>
	</tr>
	<tr>
		<td valign="top">
		<table width="90%" border="0" align="center" cellpadding="2"
			cellspacing="2">
			<tr>

				<td>
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
									<div align="right"><span class="bolddeepred"> * </span><span
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
											<%
						  	String grd="";
							String grd1="";
							
							 
							
						  %>
											</div>
											</td>

											<td width="20"><input name="grade" id="grade"
												type="hidden" value="S" /></td>
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
									<table width="100%" border="1" align="center" cellpadding="0"
										cellspacing="0" bordercolor="#FFFF00">
										<tr>
											<td height="290">
											<table width="100%" border="0" align="center" cellpadding="2"
												cellspacing="2">
												<tr>
													<td valign="top">
													<table width="100%" border="0" align="center"
														cellpadding="1" cellspacing="2" bordercolor="#D4D0C8"
														class="boldEleven">
														<tr>
															<td colspan="2">&nbsp;</td>
														</tr>
														<tr>
															<td colspan="2">
															<div align="center"><span class="tabledata"><strong>Personal
															Informations </strong></span></div>
															</td>
														</tr>
														<tr>
															<td width="106">&nbsp;</td>
															<td width="156"><input type="hidden" name="marry2"
																id="marry2" /> <span class="boldThirteen"> <input
																type="hidden" name="stype" /> </span></td>
														</tr>
														<tr>
															<td class="boldEleven">Staff Id <font
																class="bolddeepred" align="absmiddle">*</font></td>
															<td class="boldEleven"><b><%=staffVal[2].trim()%><b>
															<input name="id" type="hidden" class="formText135"
																id="id" onKeyPress="alphaNumeric('id','25')"
																onKeyUp="upperMe(this), validateUserId()"
																value="<%=staffVal[2].trim()%>" size="25" maxlength="15"
																readonly="readonly" />
															<div id="userIdMessage"></div></td>
														</tr>
														<tr>
															<td class="boldEleven">Staff Name<font
																class="bolddeepred" align="absmiddle">* </font></td>
															<td class="boldEleven"><input name="name"
																type="text" class="formText135" id="name"
																onKeyPress="charOnly('name','50')"
																value="<%=staffVal[3].trim()%>" size="25" maxlength="50"
																onKeyUp="LoadUniqueCheck('name', 'namediv', 'com_m_staff', 'CHR_STAFFNAME', 'submit_btn')" />
															<div id="namediv"></div>
															</td>
														</tr>
														<tr>
															<td class="boldEleven">Father's/Spouse Name</td>
															<td class="boldEleven"><input name="fname"
																type="text" class="formText135" id="fname"
																onKeyPress="charOnly('fname','50')"
																value="<%=staffVal[4].trim()%>" size="25" maxlength="50" /></td>
														</tr>
														<tr>
															<td class="boldEleven">Middlename</td>
															<td class="boldEleven"><input name="middlename"
																type="text" class="formText135" id="middlename"
																value="<%=staffVal[66].trim()%>" size="25"
																maxlength="50"></td>
														</tr>
														<tr>
															<td class="boldEleven">Gender <%
										
												
										grd="";
									grd1="";
							
									if("Male".equals(staffVal[8].trim()))
										grd ="checked='checked'";
							
									if("Female".equals(staffVal[8].trim()))
									grd1 ="checked='checked'";
										 
										 
										   %>
															</td>
															<td class="boldEleven">
															<table width="152" border="0" cellspacing="0"
																cellpadding="0">
																<tr>
																	<td width="20"><input name="gender" id="gender"
																		type="radio" class="formText135" value="Male" <%=grd%> /></td>
																	<td width="47" class="boldEleven">Male</td>
																	<td width="26"><input name="gender" id="gender"
																		type="radio" class="formText135" <%=grd1%>
																		value="Female" /></td>
																	<td width="59" class="boldEleven">Female</td>
																</tr>
															</table>
															</td>
														</tr>
														<tr>
															<td class="boldEleven">Blood Group <font
																class="bolddeepred" align="absmiddle">*</font></td>
															<td class="boldEleven"><%@ include
																file="../JavaScript/bloodgroup.jsp"%>
															<script language="javascript">setOptionValue('bg','<%=staffVal[10].trim()%>')</script>


															</select></td>
														</tr>
														<tr>

															<td class="boldEleven">Marital Status <%
									grd="";
									grd1="";
							
									if("M".equals(staffVal[20].trim()))
										grd ="checked='checked' ";
									
									if("U".equals(staffVal[20].trim()))
										grd1 ="checked='checked' ";
												
									
									
										%>
															</td>
															<td class="boldEleven">
															<table width="152" border="0" cellpadding="0"
																cellspacing="0" class="boldEleven">
																<tr>
																	<td class="boldEleven"><span class="formText135">
																	<input name="marry" id="marry" type="radio" value="M"
																		<%=grd%> onClick='changeState1()' class="formText135" />
																	</span></td>
																	<td class="boldEleven">Married</td>
																	<td class="boldEleven"><span class="formText135">
																	<input name="marry" id="marry" type="radio"
																		class="formText135" onClick='changeState()' value="U"
																		<%=grd1%> /> </span></td>
																	<td class="boldEleven">UnMarried</td>
																</tr>
															</table>
															</td>
														</tr>
														<tr>
															<td class="boldEleven">Date Of Birth <font
																class="bolddeepred" align="absmiddle">*</font> <%
									dbvalue=staffVal[9].trim();
									
									if (dbvalue.equalsIgnoreCase("null") ||dbvalue.equalsIgnoreCase(""))
										dbvalue="";
									else
										{
										 String sdt[] = dbvalue.split("-");	
										 dbvalue = sdt[2]+"-"+sdt[1]+"-"+sdt[0];
										} 
									%>
															</td>
															<td class="boldEleven"><input
																onKeyPress="numericHypenOnly('dob','9')" name="dob"
																id="dob" type="text" class="formText135" size="22"
																value="<%=dbvalue%>"
																title=" dd/mm/yyyy ( For e.g 21-10-1977)" /> <a
																href="javascript:cal3.popup();"> <img
																src="../JavaScript/img/cal.gif" width="16" border="0"
																alt="Click here to Pick Up the Date" /></a></td>
														</tr>



														<tr id="cwd">
															<td class="boldEleven">Wedding Date <%
									dbvalue=staffVal[21].trim();
									if (dbvalue.equalsIgnoreCase("null") ||dbvalue.equalsIgnoreCase(""))
										dbvalue="";
									else
										{
										 String sdt[] = dbvalue.split("-");	
										 dbvalue = sdt[2]+"-"+sdt[1]+"-"+sdt[0];
										} 	
									%>
															</td>
															<td class="boldEleven"><input name="wedding"
																type="text" class="formText135" id="wd"
																onKeyPress="numericHypenOnly('wedding','9')" size="22"
																value="<%=dbvalue%>" /> <a
																href="javascript:cal1.popup();"> <img
																src="../JavaScript/img/cal.gif" width="16" height="16"
																border="0" alt="Click here to Pick Up the Date" /></a></td>
														</tr>


														<tr>
															<td class="boldEleven">Date Of Join <font
																class="bolddeepred" align="absmiddle">*</font> <%
									dbvalue=staffVal[11].trim();
									if (dbvalue.equalsIgnoreCase("null") ||dbvalue.equalsIgnoreCase(""))
										dbvalue="";
									else
										{
										 String sdt[] = dbvalue.split("-");	
										 dbvalue = sdt[2]+"-"+sdt[1]+"-"+sdt[0];
										} 	
									%>
															</td>
															<td class="boldEleven"><input name="doj" id="doj"
																type="text" class="formText135"
																onKeyPress="numericHypenOnly('doj','9')" size="22"
																value="<%=dbvalue%>" /> <a
																href="javascript:cal2.popup();"> <img
																src="../JavaScript/img/cal.gif" width="16" height="16"
																border="0" alt="Click here to Pick Up the Date" /></a></td>
														</tr>
														<tr>
															<td class="boldEleven">Off. E-mail <%
									dbvalue=staffVal[39].trim();
									if (dbvalue.equalsIgnoreCase("null") ||dbvalue.equalsIgnoreCase(""))
										dbvalue="";
										
									%>
															</td>
															<td class="boldEleven"><input name="emailid"
																type="text" class="formText135" id="emailid"
																onKeyPress="isEmailID('emailid','100')"
																value="<%=dbvalue%>" size="25" maxlength="100" /> <script
																language="JavaScript">
											<!--
											  var cal1=new calendar1(document.forms['a'].elements['wedding']);
											  cal1.year_scroll=true;
											  cal1.time_comp=false;
											  var cal2=new calendar1(document.forms['a'].elements['doj']);
											  cal2.year_scroll=true;
											  cal2.time_comp=false;
											  var cal3=new calendar1(document.forms['a'].elements['dob']);
											  cal3.year_scroll=true;
											  cal3.time_comp=false;
											//-->
								</script></td>
														</tr>
														<tr>
															<td class="boldEleven">Per. E-mail <font
																class="bolddeepred" align="absmiddle">*</font> <%
									dbvalue=staffVal[64].trim();
									if (dbvalue.equalsIgnoreCase("null") ||dbvalue.equalsIgnoreCase(""))
										dbvalue="";
										
									%>
															</td>
															<td class="boldEleven"><input name="peremailid"
																type="text" class="formText135" id="peremailid"
																onKeyPress="isEmailID('peremailid','100')"
																value="<%=dbvalue%>" size="25" maxlength="100" />
															<div id='emaildiv'></div>
															<!--onKeyUp="LoadUniqueCheck('peremailid', 'emaildiv', 'com_m_staff', 'CHR_PERMAILID', 'submit_btn')"--></td>
														</tr>
														<tr>
															<td class="boldEleven">Mobile <%
									dbvalue=staffVal[40].trim();
									if (dbvalue.equalsIgnoreCase("null") ||dbvalue.equalsIgnoreCase(""))
										dbvalue="";
										
									%>
															</td>
															<td class="boldEleven"><input name="mobile"
																type="text" class="formText135" id="mobile"
																onKeyPress="numericValue('phno1','30')" size="25"
																maxlength="30" value="<%=dbvalue%>" /></td>
														</tr>
														<tr>
															<td class="boldEleven">Qualifications <font
																class="bolddeepred" align="absmiddle">*</font> <%
									dbvalue=staffVal[48].trim();
									
									%>
															</td>
															<td class="boldEleven"><!--<input name="qualification" value="<%=dbvalue%>" type="text" class="tabledata" onKeyUp="upperMe(this)" id="qualification"   size="25" maxlength="30"   />-->
															<select name="qualification" size="1" class="formText135"
																id="qualification">
																<option value="0">Select</option>
																<%
										String ssql=" SELECT INT_QUALIFICATIONID,CHR_QUALIFICATIONNAME FROM com_m_qualification ORDER BY CHR_QUALIFICATIONNAME";
										String qualdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(ssql);
										for(int c=0;c<qualdata.length;c++)
										{
											out.println("<option value='"+qualdata[c][0]+"'>"+qualdata[c][1]+"</option>");
										}
									%>
															</select> <script language="javascript">
									setOptionValue("qualification","<%=staffVal[48].trim()%>") 
									</script></td>
														</tr>
														<tr>
															<td class="boldEleven">Reporting to</td>
															<td class="boldEleven"><select id="repto"
																name="repto" class="formText135">
																<option value="0">Select</option>
																<%
		   String rptodata[][] =com.my.org.erp.common.CommonFunctions.QueryExecute("select CHR_EMPID,CHR_STAFFNAME from com_m_staff WHERE CHR_TYPE<>'T' AND CHR_REP='Y' ");
		   for(int c=0;c<rptodata.length;c++)
		   		out.println("<option value='"+rptodata[c][0]+"'>"+rptodata[c][1]+"</option>");
		   %>
															</select> <script language="javascript">
									setOptionValue("repto","<%=staffVal[50].trim()%>") 
									</script></td>
														</tr>
														<tr>
															<td class="boldEleven">Dispensary</td>
															<td class="boldEleven"><select id="Dispensary"
																name="Dispensary" class="formText135">
																<option value="0">Select</option>
																<%
		   String Disdata[][] =com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_DESPID,CHR_DESPNAME From com_m_dispensary order by INT_DESPID ");
		   for(int c=0;c<Disdata.length;c++)
		   		out.println("<option value='"+Disdata[c][0]+"'>"+Disdata[c][1]+"</option>");
		   %>
															</select> <script language="javascript">
									setOptionValue("Dispensary","<%=staffVal[53].trim()%>") 
									</script></td>
														</tr>
														<tr>
															<td class="boldEleven">Category <font
																class="bolddeepred" align="absmiddle">*</font></td>
															<td class="boldEleven"><%@ include
																file="EmployeeCategory.jsp"%> <script
																language="javascript">
									setOptionValue("Category","<%=staffVal[57].trim()%>") 
									</script></td>
														</tr>
													</table>
													</td>
													<td class="boldEleven">
													<table width="100%" border="0" align="center"
														cellpadding="1" cellspacing="3" bordercolor="#D4D0C8"
														class="boldEleven">
														<tr>
															<td colspan="4">&nbsp;</td>
														</tr>
														<tr>
															<td colspan="4">
															<div align="center"><span class="tabledata"><strong>Official
															Details</strong></span></div>
															</td>
														</tr>
														<tr>
															<td width="118" class="boldEleven">Company</td>
															<td colspan="3"><select name="company" id="company"
																onChange="loadBranch()" class="formText135"
																style="width: 200px">
																<%                  
			            String branchId1=staffVal[0].trim();
     					String queryBranch1="SELECT * FROM  com_m_company ";
     					String	branch1[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(queryBranch1);
     					for(int i=0;i<branch1.length;i++)
     						out.println("<option value='"+branch1[i][0]+"'>"+branch1[i][1]+"</option>");
 			   %>
															</select> <script language="javascript">setOptionValue("company","<%=staffVal[0].trim()%>") </script>
															</td>
														</tr>
														<tr>
															<td width="118" class="boldEleven">Branch</td>
															<td colspan="3"><select name="branch" id="branch"
																class="formText135" style="width: 200px">
																<% 
									   
                        String branchId=staffVal[1].trim();
 					    String sql="SELECT INT_BRANCHID,CHR_BRANCHNAME FROM  com_m_branch Where INT_COMPANYID="+branchId1;
         				String branch[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
         				for(int u=0; u<branch.length; u++)
				  		if(branch[u][0].trim().equals(branchId))
							out.print("<option selected='selected' value='"+branch[u][0]+"'>"+branch[u][1]+"</option>");
				  		else
							out.print("<option value='"+branch[u][0]+"'>"+branch[u][1]+"</option>");
				  		 			%>
															</select></td>
														</tr>

														<tr>
															<td width="118" class="boldEleven">State</td>
															<td colspan="3"><select name="st1" id="st1"
																class="formText135" onChange="LoadSelectDistrict(this)">
																<option value="0">Select</option>

																<%
String state1data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_STATEID,CHR_STATENAME FROM  com_m_state  ORDER BY CHR_STATENAME");
for(int h=0;h<state1data.length;h++)
	out.print("<option value='"+state1data[h][0]+"'>"+state1data[h][1]+"</option>");
		
  %>
															</select> <script language="javascript">setOptionValue("st1","<%=staffVal[24].trim()%>") </script>
															</td>
														</tr>
														<tr>
															<td class="boldEleven">District</td>
															<td colspan="3"><select name="dist" id="dist"
																class="formText135">
																<option value="0">Select</option>
																<%
	String distdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_DISTRICTID,CHR_DISTRICT FROM  com_m_district  WHERE INT_STATEID="+staffVal[24].trim()+" ORDER BY CHR_DISTRICT");
for(int h=0;h<distdata.length;h++)
	out.print("<option value='"+distdata[h][0]+"'>"+distdata[h][1]+"</option>");
	 
%>
															</select> <script language="javascript">setOptionValue("dist","<%=staffVal[25].trim()%>") </script>
															</td>
														</tr>
														<tr>
															<td class="boldEleven">Office<font
																class="bolddeepred" align="absmiddle">*</font></td>
															<td colspan="3"><select name="off"
																class="formText135" id="off">
																<option value="-1">Select</option>
																<%
String offdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_OFFICEID,CHR_OFFICENAME FROM   com_m_office   ORDER BY CHR_OFFICENAME");
for(int h=0;h<offdata.length;h++)
	out.print("<option value='"+offdata[h][0]+"'>"+offdata[h][1]+"</option>");
%>
															</select> <script language="javascript">setOptionValue("off","<%=staffVal[7].trim()%>") </script>
															</td>
														</tr>
														<tr>
															<td class="boldEleven">Department<font
																class="bolddeepred" align="absmiddle">*</font></td>
															<td colspan="3"><select name="depart"
																class="formText135" id="depart">
																<option value="-1">Select</option>
																<%

	String depdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_DEPARTID,CHR_DEPARTNAME FROM  com_m_depart  ORDER BY CHR_DEPARTNAME");
	for(int h=0;h<depdata.length;h++)
		out.print("<option value='"+depdata[h][0]+"'>"+depdata[h][1]+"</option>");
%>
															</select> <script language="javascript">setOptionValue("depart","<%=staffVal[5].trim()%>") </script>
															</td>
														</tr>
														<tr>
															<td class="boldEleven">Designation<font
																class="bolddeepred" align="absmiddle">*</font><font
																class="redcol style3" align="absmiddle">&nbsp;</font></td>
															<td colspan="3"><select name="desig"
																class="formText135" id="desig">
																<option value="Select">Select</option>
																<%
	
		String desgdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_DESIGID,CHR_DESIGNAME FROM  com_m_desig  ORDER BY CHR_DESIGNAME");
			for(int h=0;h<desgdata.length;h++)
				out.print("<option value='"+desgdata[h][0]+"'>"+desgdata[h][1]+"</option>");
			
		
		%>
															</select> <script language="javascript">setOptionValue("desig","<%=staffVal[6].trim()%>") </script>
															</td>
														</tr>
														<tr>
															<td class="boldEleven">Type <font
																class="bolddeepred" align="absmiddle">*</font></td>
															<td colspan="3">
															<%
														  
														  if("F".equals(""+session.getAttribute("USERTYPE")) )
														  {
															  if(!"T".equals(staffVal[15].trim()))
															  {
															  %> <%@ include file="../JavaScript/stafftype.jsp"%>
															<script language="javascript">
																			var x=document.getElementById("type");
																			x.options[x.selectedIndex].text="<%=staffVal[15].trim()%>";
																	</script> <%
																}
																else
															out.println("<input type='hidden'  name='type'   id='type' value='"+staffVal[15].trim()+"'><font class='bolddeepred'> "+staffVal[15].trim()+"  </font>");
														}
														else
																	out.println("<input type='hidden'  name='type'   id='type' value='"+staffVal[15].trim()+"'><font class='bolddeepred'> "+staffVal[15].trim()+"  </font>");
															%>
															</td>
														</tr>
														<tr>
															<td class="boldEleven">Basic Salary <%
									
									dbvalue=staffVal[16].trim();
									if (dbvalue.equalsIgnoreCase("null") ||dbvalue.equalsIgnoreCase("")||dbvalue.equalsIgnoreCase("0"))
										dbvalue="";
									%>
															</td>
															<td colspan="3"><input name="basic" type="text"
																class="formText135" id="basic"
																onBlur="pricesOnly('basic')" value="<%=dbvalue%>"
																size="22" maxlength="12" /></td>
														</tr>
														<tr>
															<td class="boldEleven">Gross <font
																class="bolddeepred" align="absmiddle">*</font> <%
									dbvalue=staffVal[19].trim();
									if (dbvalue.equalsIgnoreCase("null") ||dbvalue.equalsIgnoreCase(""))
										dbvalue="0";
									%>
															</td>
															<td colspan="3"><input name="gross" type="text"
																class="formText135" id="gross"
																onKeyPress="pricesOnly('gross')" value="<%=dbvalue%>"
																size="22" maxlength="15" /> <%
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
	
	
</script></td>
														</tr>
														<tr>
															<td class="boldEleven">Bank Name <font
																class="bolddeepred" align="absmiddle">*</font> <%
									dbvalue=staffVal[22].trim();
									%>
															</td>
															<td colspan="3"><!--    <input name="bank" type="text" class="formText135" id="bank"   onKeyPress="charOnly('name','35')" value="dbvalue" size="22" maxlength="30" /> -->
															<select name="bank" class="formText135" id="bank">
																<option value="0">Select</option>
																<%
                  out.println("<option value='1'>No Bank</option>");	
						String query="SELECT INT_BANKID, CHR_BANKNAME FROM com_m_bank ORDER BY CHR_BANKNAME";
                  		String datas[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(query);
							for (int i=0; i<datas.length; i++) {
								out.println("<option value="+datas[i][0]+">"+datas[i][1]+"</option>");												

							}

				%>
															</select> <script language="javascript">setOptionValue("bank","<%=staffVal[22].trim()%>") </script>
															</td>
														</tr>
														<tr>
															<td class="boldEleven">Account No <%
									dbvalue=staffVal[23].trim();
									if (dbvalue.equalsIgnoreCase("null") ||dbvalue.equalsIgnoreCase(""))
										dbvalue="";
									%>
															</td>
															<td colspan="3"><input name="number" type="text"
																class="formText135" id="no"
																onKeyPress="alphaNumeric('no','25')"
																value="<%=dbvalue%>" onKeyUp="upperMe(this)"
																onBlur="upperMe(this)" size="22" maxlength="25" /> <!--, CheckUnique(this,'acc','com_m_staff','CHR_ACCNO'), CheckUnique(this,'acc','com_m_staff','CHR_ACCNO')-->
															<div id="acc"></div>
															</td>
														</tr>
														<tr>
															<td class="boldEleven">Leave Carry <%
									dbvalue=staffVal[47].trim();
									if ("Y".equals(dbvalue))
										dbvalue=" checked='checked' ";
									else
										dbvalue=" ";
									%>
															</td>
															<td><input <%=dbvalue%> name="carry" type="checkbox"
																id="carry"></td>
															<td class="boldEleven">Interview</td>
															<td class="boldEleven"><input name="interview"
																type="checkbox" id="interview" value="Y" <%=dbvalue%>></td>
														</tr>
														<tr>
															<td class="boldEleven">Management <%
									dbvalue=staffVal[49].trim();
									if ("Y".equals(dbvalue))
										dbvalue=" checked='checked' ";
									else
										dbvalue=" ";
									%>
															</td>
															<td class="boldEleven"><input <%=dbvalue%>
																name="management" type="checkbox" id="management"></td>
															<td class="boldEleven">Payslip hold <%
														dbvalue=staffVal[56].trim();
														if ("Y".equals(dbvalue))
															dbvalue=" checked='checked' ";
														else
															dbvalue=" ";

															%>
															</td>
															<td class="boldEleven"><input name="payslip"
																type="checkbox" id="payslip" <%=dbvalue%>></td>
														</tr>
														<tr>
															<td class="boldEleven">Reporting Head <%
									dbvalue=staffVal[51].trim();
									if ("Y".equals(dbvalue))
										dbvalue=" checked='checked' ";
									else
										dbvalue=" ";
									%>
															</td>
															<td width="78"><input <%=dbvalue%>
																name="Reporinghead" type="checkbox" id="Reporinghead"></td>
															<td width="115" class="boldEleven">Conveyance clear
															<%
														dbvalue=staffVal[54].trim();
														if ("Y".equals(dbvalue))
															dbvalue=" checked='checked' ";
														else
															dbvalue=" ";

															%>
															</td>
															<td width="52"><input name="conveyance"
																type="checkbox" id="conveyance" <%=dbvalue%>></td>
														</tr>
														<tr>
															<td class="boldEleven"><span class="spc">Staff
															Holding <%
									dbvalue=staffVal[52].trim();
									if ("Y".equals(dbvalue))
										dbvalue=" checked='checked' ";
									else
										dbvalue=" ";
									%> </span></td>
															<td class="boldEleven"><input <%=dbvalue%>
																name="hold" type="checkbox" id="hold" value="Y"></td>
															<td class="spc">Salary Calcualtion <%
														dbvalue=staffVal[55].trim();
														if ("Y".equals(dbvalue))
															dbvalue=" checked='checked' ";
														else
															dbvalue=" ";

															%>
															</td>
															<td class="boldEleven"><input
																name="salarycalculation" type="checkbox"
																id="salarycalculation" value="Y" <%=dbvalue%>></td>
														</tr>
														<tr>
															<td class="boldEleven">Rejoin</td>
															<td class="boldEleven"><input name="rejoin"
																type="checkbox" id="rejoin" value="Y"></td>
															<td class="spc">&nbsp;</td>
															<td class="boldEleven">&nbsp;</td>
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
									<td height="19" colspan="2">&nbsp;</td>
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
													Permanent to Communication Address <input
														onClick="return resoffval()" type="radio" value="yes"
														name="res"> Yes <input name="res" type="radio"
														onClick="return resoffval()" value="no"> No </span></td>
												</tr>
												<tr>
													<td width="50%" height="210">
													<table width="100%" border="0" align="center"
														cellpadding="1" cellspacing="2">
														<tr>
															<td height="15" colspan="2" class="tabledata">
															<div align="center"><strong>Permanent
															Address</strong></div>
															</td>
														</tr>
														<tr>
															<td class="boldEleven">&nbsp;</td>
															<td width="161" class="boldEleven">&nbsp;</td>
														</tr>
														<tr>
															<td width="97" class="boldEleven">Address1<font
																class="bolddeepred" align="absmiddle">*</font> <%
									dbvalue=staffVal[27].trim();
									if (dbvalue.equalsIgnoreCase("null") ||dbvalue.equalsIgnoreCase(""))
										dbvalue="";
									%>
															</td>
															<td class="boldEleven"><input name="padd1"
																type="text" class="formText135" id="padd1"
																onKeyPress="isAddress('padd1','50')"
																value="<%=dbvalue%>" size="30" maxlength="50" /></td>
														</tr>
														<tr>
															<td class="boldEleven">Address2<font
																class="bolddeepred" align="absmiddle">*</font> <%
									dbvalue=staffVal[28].trim();
									if (dbvalue.equalsIgnoreCase("null") ||dbvalue.equalsIgnoreCase(""))
										dbvalue="";
									%>
															</td>
															<td class="boldEleven"><input name="padd2"
																type="text" class="formText135" id="padd2"
																onKeyPress="isAddress('padd2','50')"
																value="<%=dbvalue%>" size="30" maxlength="50" /></td>
														</tr>

														<tr>
															<td class="boldEleven">City <font
																class="bolddeepred" align="absmiddle">*</font></td>
															<td class="boldEleven"><select name="pcity"
																id="pcity" style="width: 170"
																onChange="PAssignPincode('ppincode')">
																<option value="0" selected="selected">Select
																City</option>
																<%


String cityData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_CITYID,CHR_CITYNAME FROM com_m_city WHERE INT_DISTRICTID=" +staffVal[70].trim());
if(cityData.length>0)
for(int u=0;u<cityData.length;u++)
	out.print("<option value='"+cityData[u][0]+"'>"+cityData[u][1]+"</option>");

%>
															</select> <script language="javascript">setOptionValue('pcity','<%=staffVal[29].trim()%>')</script>


															</td>
														</tr>
														<tr>
															<td class="boldEleven">District<font
																class="bolddeepred" align="absmiddle">*</font></td>
															<td class="boldEleven"><select name="pdistrict"
																id="pdistrict" style="width: 170"
																onChange=" PLoadSelectCity()">
																<option value="0" selected="selected">Select
																District</option>
																<%
String	districtData[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_DISTRICTID,CHR_DISTRICT  FROM com_m_district WHERE  INT_STATEID="+staffVal[30].trim()+"  ORDER BY CHR_DISTRICT  ");
for(int u=0;u<districtData.length;u++)
	out.println("<option value='"+districtData[u][0]+"'>"+districtData[u][1]+"</option>");
															  %>
															</select> <script language="javascript">setOptionValue('pdistrict','<%=staffVal[70].trim()%>')</script>

															</td>
														</tr>
														<tr>
															<td class="boldEleven">State <font
																class="bolddeepred" align="absmiddle">*</font></td>
															<td class="boldEleven"><select name="pstate"
																id="pstate" style="width: 170"
																onChange="PLoadSelectDistrict()">
																<option value="0" selected="selected">Select
																State</option>
																<%
String	stateData[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_STATEID,CHR_STATENAME FROM com_m_state WHERE INT_COUNTRYID ="+staffVal[71].trim()+" ORDER BY CHR_STATENAME");
for(int u=0;u<stateData.length;u++)
	out.println("<option value='"+stateData[u][0]+"'>"+stateData[u][1]+"</option>");
																	%>
															</select> <script language="javascript">setOptionValue('pstate','<%=staffVal[30].trim()%>')</script>
															</td>
														</tr>
														<tr>
															<td class="boldEleven">Country<font
																class="bolddeepred" align="absmiddle">*</font></td>
															<td class="boldEleven"><select name="pcountry"
																id="pcountry" style="width: 170"
																onChange="PLoadSelectState()">
																<option value="0">Select Country</option>
																<%
	 		String creadData[][]= com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_COUNTRYID ,CHR_COUNTRYNAME FROM  com_m_country ORDER BY CHR_COUNTRYNAME");
			for(int i=0;i<creadData.length;i++)
				out.println("<option value='"+creadData[i][0]+"'>"+creadData[i][1]+"</option>");
	 %>
															</select> <script language="javascript">setOptionValue('pcountry','<%=staffVal[71].trim()%>')</script>
															</td>
														</tr>
														<tr>
															<td class="boldEleven">Pin Code<font
																class="bolddeepred" align="absmiddle">*</font> <%
									dbvalue=staffVal[31].trim();
									if (dbvalue.equalsIgnoreCase("null") ||dbvalue.equalsIgnoreCase(""))
										dbvalue="";
									%>
															</td>
															<td class="boldEleven"><input name="ppincode"
																value="<%=dbvalue%>" type="text" class="formText135"
																id="ppincode"
																onKeyPress="return numeric_only(event,'ppincode','6')"
																size="25" maxlength="6" /></td>
														</tr>
														<tr>
															<td class="boldEleven">Phone No<font
																class="bolddeepred" align="absmiddle">*</font> <%
									dbvalue=staffVal[37].trim();
									if (dbvalue.equalsIgnoreCase("null") ||dbvalue.equalsIgnoreCase(""))
										dbvalue="";
									%>
															</td>
															<td class="boldEleven"><input name="pphone"
																type="text" class="formText135" id="pphone"
																value="<%=dbvalue%>"
																onKeyPress="return numeric_only(event,'pphone','10')"
																size="25" maxlength="12" /></td>
														</tr>
													</table>
													</td>
													<td width="50%">
													<table width="100%" border="0" align="center"
														cellpadding="1" cellspacing="2">
														<tr>
															<td colspan="2" class="boldEleven">
															<div align="center"><span class="tabledata"><strong>Communication
															Address</strong></span></div>
															</td>
														</tr>
														<tr>
															<td class="boldEleven">&nbsp;</td>
															<td width="166" class="boldEleven">&nbsp;</td>
														</tr>
														<tr>
															<td width="101" class="boldEleven">Address1<font
																class="bolddeepred" align="absmiddle">*</font> <%
									dbvalue=staffVal[32].trim();
									if (dbvalue.equalsIgnoreCase("null") ||dbvalue.equalsIgnoreCase(""))
										dbvalue="";
									%>
															</td>
															<td class="boldEleven"><input name="cadd1"
																type="text" class="formText135" id="cadd1"
																onKeyPress="isAddress('cadd1','50')"
																value="<%=dbvalue%>" size="30" maxlength="50" /></td>
														</tr>
														<tr>
															<td class="boldEleven">Address2 <font
																class="bolddeepred" align="absmiddle">*</font> <%
									dbvalue=staffVal[33].trim();
									if (dbvalue.equalsIgnoreCase("null") ||dbvalue.equalsIgnoreCase(""))
										dbvalue="";
									%>
															</td>
															<td class="boldEleven"><input name="cadd2"
																type="text" class="formText135" id="cadd2"
																onKeyPress="isAddress('cadd2','50')"
																value="<%=dbvalue%>" size="30" maxlength="50" /></td>
														</tr>

														<tr>
															<td class="boldEleven">City <font
																class="bolddeepred" align="absmiddle">*</font></td>
															<td class="boldEleven"><select name="ccity"
																id="ccity" style="width: 170"
																onChange="CAssignPincode('cpincode')">
																<option value="0" selected="selected">Select
																City</option>
																<%


String cityData1[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_CITYID,CHR_CITYNAME FROM com_m_city WHERE INT_DISTRICTID=" +staffVal[72].trim());
if(cityData1.length>0)
for(int u=0;u<cityData1.length;u++)
	out.print("<option value='"+cityData1[u][0]+"'>"+cityData1[u][1]+"</option>");

%>
															</select> <script language="javascript">setOptionValue('ccity','<%=staffVal[34].trim()%>')</script>

															</td>
														</tr>
														<tr>
															<td class="boldEleven">District<font
																class="bolddeepred" align="absmiddle">*</font></td>
															<td class="boldEleven"><select name="cdistrict"
																id="cdistrict" style="width: 170"
																onChange=" CLoadSelectCity()">
																<option value="0" selected="selected">Select
																District</option>
																<%
String	districtData1[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_DISTRICTID,CHR_DISTRICT  FROM com_m_district WHERE  INT_STATEID="+staffVal[35].trim()+"  ORDER BY CHR_DISTRICT  ");
for(int u=0;u<districtData1.length;u++)
	out.println("<option value='"+districtData1[u][0]+"'>"+districtData1[u][1]+"</option>");
															  %>
															</select> <script language="javascript">setOptionValue('cdistrict','<%=staffVal[72].trim()%>')</script>


															</td>
														</tr>
														<tr>
															<td class="boldEleven">State <font
																class="bolddeepred" align="absmiddle">*</font></td>
															<td class="boldEleven"><select name="cstate"
																id="cstate" style="width: 170"
																onChange="CLoadSelectDistrict()">
																<option value="0" selected="selected">Select
																State</option>
																<%
String	stateData1[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_STATEID,CHR_STATENAME FROM com_m_state WHERE INT_COUNTRYID ="+staffVal[73].trim()+" ORDER BY CHR_STATENAME");
for(int u=0;u<stateData1.length;u++)
	out.println("<option value='"+stateData1[u][0]+"'>"+stateData1[u][1]+"</option>");
																	%>
															</select> <script language="javascript">setOptionValue('cstate','<%=staffVal[35].trim()%>')</script>


															</td>
														</tr>
														<tr>
															<td class="boldEleven">Country<font
																class="bolddeepred" align="absmiddle">*</font></td>
															<td class="boldEleven"><select name="ccountry"
																id="ccountry" style="width: 170"
																onChange="CLoadSelectState()">
																<option value="0">Select Country</option>
																<%
	 		for(int i=0;i<creadData.length;i++)
				out.println("<option value='"+creadData[i][0]+"'>"+creadData[i][1]+"</option>");
	 %>
															</select><script language="javascript">setOptionValue('ccountry','<%=staffVal[73].trim()%>')</script>
															</td>
														</tr>
														<tr>
															<td class="boldEleven">Pin Code<font
																class="bolddeepred" align="absmiddle">*</font> <%
									dbvalue=staffVal[36].trim();
									if (dbvalue.equalsIgnoreCase("null") ||dbvalue.equalsIgnoreCase(""))
										dbvalue="";
									%>
															</td>
															<td class="boldEleven"><input name="cpincode"
																type="text" class="formText135" id="cpincode"
																value="<%=dbvalue%>"
																onKeyPress="return numeric_only(event,'cpincode','6')"
																size="25" maxlength="6" /></td>
														</tr>
														<tr>
															<td class="boldEleven">Phone No<font
																class="bolddeepred" align="absmiddle">*</font> <%
									dbvalue=staffVal[38].trim();
									if (dbvalue.equalsIgnoreCase("null") ||dbvalue.equalsIgnoreCase(""))
										dbvalue="";
									%>
															</td>
															<td class="boldEleven"><input name="cphone"
																type="text" class="formText135" id="cphone"
																onKeyPress="return numeric_only(event,'cphone','10')"
																value="<%=dbvalue%>" size="25" maxlength="25" /></td>
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
											<td height="185">
											<table width="100%" border="0" align="center" cellpadding="2"
												cellspacing="2">
												<tr>
													<td width="49%" height="167">
													<table width="100%" border="0" align="center"
														cellpadding="1" cellspacing="2">
														<tr>
															<td colspan="2" class="boldEleven">
															<div align="center"><span class="tabledata"><strong>PF</strong></span></div>
															</td>
														</tr>
														<tr>
															<td class="boldEleven">&nbsp;</td>
															<td class="boldEleven">&nbsp;</td>
														</tr>



														<tr>
															<input type="hidden" name="hidPF" id="hidPF"
																value="<%=staffVal[17]%>">
															<td width="101" class="boldEleven">PF <%
									grd="";
									grd1="";
									String grd2="";
									

									if("Y".equals(staffVal[17].trim()))
										grd ="checked='checked'";
									else if("N".equals(staffVal[17].trim()))
										grd1 ="checked='checked'";
									else if("C".equals(staffVal[17].trim()))
										grd2 ="checked='checked'";
									
										%>
															</td>
															<td width="156" class="boldEleven">
															<table width="140" border="0" cellspacing="0"
																cellpadding="0">
																<tr>
																	<td width="20"><span class="formText135"> <input
																		name="pf" type="radio" class="formText135" value="Y"
																		<%=grd%> onClick="enable()" /> </span></td>
																	<td width="20"><span class="formText135">Yes</span></td>
																	<td width="24"><span class="formText135"> <input
																		name="pf" type="radio" <%=grd1%> class="formText135"
																		value="N" onClick="disable()" /> </span></td>
																	<td width="16"><span class="formText135">No</span></td>
																	<td width="22"><span class="formText135"> <input
																		name="pf" type="radio" class="formText135"
																		onClick="cenable()" value="C" <%=grd2%> /> </span></td>
																	<td width="58" class="boldEleven">Common</td>
																</tr>
															</table>
															</td>
														</tr>
														<tr id="pf0">
															<td class="boldEleven">PF TYPE <%
									grd="";
									grd1="";
									if("A".equals(staffVal[41].trim()))
										grd ="checked='checked'";
							
									if("P".equals(staffVal[41].trim()))
									grd1 ="checked='checked'";
									
									
									
										%>
															</td>
															<td class="boldEleven">
															<table width="100" border="0" cellpadding="0"
																cellspacing="0" class="boldEleven">
																<tr>
																	<td id="s1"><span class="bolddeepblue"> <input
																		name='optpf' type='radio' <%=grd%> value='A' /> </span></td>
																	<td id="s2" class="boldEleven">Amount</td>
																	<td class="boldEleven"><span class="bolddeepblue">
																	<input name='optpf' type='radio' value='P' <%=grd1%> />
																	</span></td>
																	<td class="boldEleven">Percentage</td>
																</tr>
															</table>
															</td>
														</tr>
														<tr id="pf1">
															<td class="boldEleven">PF Number <%
									dbvalue=staffVal[43].trim();
									if (dbvalue.equalsIgnoreCase("null") ||dbvalue.equalsIgnoreCase(""))
										dbvalue="";
									%>
															</td>
															<td class="boldEleven"><input name="TxtPfNo"
																id="TxtPfNo" type="text" class="formText135"
																value="<%=dbvalue%>" size="25" maxlength="30"
																onKeyPress="return numeric_only(event,'TxtPfNo','10');" />
															</td>
														</tr>
														<tr id="pf2">
															<td class="boldEleven">PF Amount <%
									dbvalue=staffVal[42].trim();
									if (dbvalue.equalsIgnoreCase("null") ||dbvalue.equalsIgnoreCase("0.00"))
										dbvalue="";
									%>
															</td>
															<td class="boldEleven"><input name="TxtPfValue"
																type="text" class="formText135"
																onKeyPress="numericValue('TxtPfValue','9')"
																value="<%=dbvalue%>" size="25" maxlength="15" /></td>
														</tr>
														<tr>
															<td class="boldEleven">PF Nominee</td>
															<td class="boldEleven"><input name="nominee"
																type="text" class="formText135" id="nominee" size="25"
																maxlength="50"></td>
														</tr>
														<tr>
															<td class="boldEleven">Date of PF &amp; ESI
															Registration</td>
															<td class="boldEleven">
															<%
									dbvalue=staffVal[59].trim();
									
									if (dbvalue.equalsIgnoreCase("null") ||dbvalue.equalsIgnoreCase(""))
										dbvalue="";
									else
										{
										 String sdt[] = dbvalue.split("-");	
										 dbvalue = sdt[2]+"-"+sdt[1]+"-"+sdt[0];
										} 
									%> <input title="dd/mm/yyyy"
																onKeyPress="numericHypenOnly('pfesidate','9')"
																name="pfesidate" id="pfesidate" type="text"
																class="formText135" size="15" maxlength="10"
																value="<%=dbvalue%>" /> <a
																href="javascript:cal4.popup();"> <img
																src="../JavaScript/img/cal.gif" width="16" border="0"
																alt="Click here to Pick Up the Date" /> </a></td>
														</tr>
														<tr>
															<td class="boldEleven">&nbsp;</td>
															<td class="boldEleven">&nbsp;</td>
														</tr>
													</table>
													</td>
													<td width="51%">
													<table width="100%" border="0" align="center"
														cellpadding="1" cellspacing="2">
														<tr>
															<td height="21" colspan="2" class="boldEleven">
															<div align="center"><span class="tabledata"><strong>
															ESI</strong></span></div>
															</td>
														</tr>
														<tr>
															<td height="21" class="boldEleven">&nbsp;</td>
															<td width="161" class="boldEleven">&nbsp;</td>
														</tr>
														<tr>
															<td width="107" height="21" class="boldEleven">ESI <%
									grd="";
									grd1="";
									grd2="";
							
									if("Y".equals(staffVal[18].trim()))
										grd ="checked='checked'";
							
									if("N".equals(staffVal[18].trim()))
									grd1 ="checked='checked'";
									
									if("C".equals(staffVal[18].trim()))
									grd2 ="checked='checked'";
									
										%>
															</td>
															<td class="boldEleven">
															<table width="75" border="0" cellspacing="0"
																cellpadding="0">
																<tr>
																	<td width="20"><span class="formText135"> <input
																		name="ESI" type="radio" <%=grd%> class="formText135"
																		onClick="enable1()" value="Y" /> </span></td>
																	<td width="20"><span class="formText135">Yes</span></td>
																	<td width="20"><span class="formText135"> <input
																		name="ESI" type="radio" <%=grd1%> class="formText135"
																		value="N" onClick="disable1()" /> </span></td>
																	<td width="7"><span class="formText135">No</span></td>
																	<td width="8"><span class="formText135"> <input
																		name="ESI" type="radio" class="formText135"
																		onClick="cenable1()" value="C" <%=grd2%> /> </span></td>
																	<td width="15" class="boldEleven">Common</td>
																</tr>
															</table>
															</td>
														</tr>
														<tr id="ppf0">
															<td height="21" class="boldEleven">ESI TYPE <%
									grd=" ";
									grd1=" ";
									if("A".equals(staffVal[44].trim()))
										grd ="checked='checked'";
							
									if("P".equals(staffVal[44].trim()))
										grd1 ="checked='checked'";
									
										%>
															</td>
															<td class="boldEleven">
															<table width="100" border="0" cellpadding="0"
																cellspacing="0" class="boldEleven">
																<tr>
																	<td id="ps1"><span class="bolddeepblue"> <input
																		name='optesi' type='radio' <%=grd%> value='A' /> </span></td>
																	<td id="ps2" class="boldEleven">Amount</td>
																	<td class="boldEleven"><span class="bolddeepblue">
																	<input name='optesi' type='radio' value='P' <%=grd1%> />
																	</span></td>
																	<td class="boldEleven">Percentage</td>
																</tr>
															</table>
															</td>
														</tr>
														<tr id="ppf1">
															<td class="boldEleven">ESI Number <%
									dbvalue=staffVal[46].trim();
									if (dbvalue.equalsIgnoreCase("null") ||dbvalue.equalsIgnoreCase(""))
										dbvalue="";
									%>
															</td>
															<td class="boldEleven"><input name="TxtEsiNo"
																id="TxtEsiNo" type="text" class="formText135"
																onKeyUp="upperMe(this), LoadUniqueCheck('TxtEsiNo', 'ESIDiv', 'com_m_staff', 'CHR_ESINO', 'submit_btn')"
																value="<%=dbvalue%>" size="25" maxlength="30" />
															<div id="ESIDiv"></div>
															</td>
														</tr>
														<tr id="ppf2">
															<td class="boldEleven">ESI Amount <%
									dbvalue=staffVal[45].trim();
									if (dbvalue.equalsIgnoreCase("null") ||dbvalue.equalsIgnoreCase("0.00"))
										dbvalue="";
									%>
															</td>
															<td class="boldEleven"><input name="TxtEsiValue"
																type="text" class="formText135"
																onKeyPress="numericValue('TxtEsiValue','9')"
																value="<%=dbvalue%>" size="25" maxlength="15" /></td>
														</tr>
														<tr>
															<td class="boldEleven">&nbsp;</td>
															<td class="boldEleven">&nbsp;</td>
														</tr>
														<tr>
															<td class="boldEleven">Date of Resign</td>
															<td class="boldEleven">
															<%
									dbvalue=staffVal[60].trim();
									
									if (dbvalue.equalsIgnoreCase("null") ||dbvalue.equalsIgnoreCase(""))
										dbvalue="";
									else
										{
										 String sdt[] = dbvalue.split("-");	
										 dbvalue = sdt[2]+"-"+sdt[1]+"-"+sdt[0];
										} 
									%> <input title="dd/mm/yyyy"
																onKeyPress="numericHypenOnly('resigndate','9')"
																name="resigndate" id="resigndate" type="text"
																class="formText135" size="15" maxlength="10"
																value="<%=dbvalue%>" /> <a
																href="javascript:cal5.popup();"> <img
																src="../JavaScript/img/cal.gif" width="16" border="0"
																alt="Click here to Pick Up the Date" /> </a> <script
																language="JavaScript">
<!--
  
  var cal4=new calendar1(document.forms['a'].elements['pfesidate']);
  cal4.year_scroll=true;
  cal4.time_comp=false;
  
  var cal5=new calendar1(document.forms['a'].elements['resigndate']);
  cal5.year_scroll=true;
  cal5.time_comp=false;
  
//-->
                                                            </script></td>
														</tr>
														<tr>
															<td class="boldEleven">&nbsp;</td>
															<td class="boldEleven">&nbsp;</td>
														</tr>
													</table>
													</td>
												</tr>

												<tr>
													<td class="boldEleven">
													<table width="330" border="0" align="center">
														<tr>
															<td class="boldEleven">PAN NO</td>
															<td class="boldEleven"><input name="pannumber"
																type="text" class="formText135" id="pannumber"
																onKeyUp="upperMe(this), LoadUniqueCheck('pannumber', 'pandiv', 'com_m_staff', 'CHR_PAN', 'submit_btn')"
																value="<%=staffVal[61].trim()%>" maxlength="16">
															<div id="pandiv"></div>
															</td>
														</tr>
														<tr>
															<td class="boldEleven">PASS PORT NO</td>
															<td class="boldEleven"><input name="passportnumber"
																type="text" class="formText135" id="passportnumber"
																onKeyUp="upperMe(this), LoadUniqueCheck('passportnumber', 'passportnumberdiv', 'com_m_staff', 'CHR_PASSPORT', 'submit_btn')"
																value="<%=staffVal[62].trim()%>" maxlength="16">
															<div id="passportnumberdiv"></div>
															</td>
														</tr>
														<tr>
															<td class="boldEleven">DRIVING LICENSE NO</td>
															<td class="boldEleven"><input name="drivingnumber"
																type="text" class="formText135" id="drivingnumber"
																onKeyUp="upperMe(this), LoadUniqueCheck('drivingnumber', 'drivingdiv', 'com_m_staff', 'CHR_DRIVING', 'submit_btn')"
																value="<%=staffVal[63].trim()%>" maxlength="16">
															<div id="drivingdiv"></div>
															</td>
														</tr>
													</table>
													</td>
													<td class="boldEleven">
													<table width="100%" border="0" cellspacing="0"
														cellpadding="0">
														<tr>
															<td class="boldEleven">Previous Details</td>
															<td rowspan="3" align="left" valign="top"><textarea
																name="previousdetails" cols="30" rows="5"
																onKeyUp="textArea('previousdetails','2000')"
																class="formText135" id="previousdetails"><%=staffVal[65].trim()%></textarea></td>
														</tr>
														<tr>
															<td class="boldEleven">&nbsp;</td>
														</tr>
														<tr>
															<td class="boldEleven">&nbsp;</td>
														</tr>
													</table>
													</td>
												</tr>
												<tr>
													<td colspan="2"></td>
												</tr>
												<tr>
													<td class="boldEleven">&nbsp;</td>
													<td class="boldEleven">&nbsp;</td>
												</tr>
											</table>
											</td>
										</tr>



									</table>
									</td>
								</tr>
								<tr>
									<td height="19">&nbsp;</td>
									<td class="boldEleven"><input name="filename"
										type="hidden" id="filename" value="StaffRegistration">
									<input name="actionS" type="hidden" id="actionS"
										value="COM_ATTStaffRegistrationUpdate"></td>
								</tr>
								<tr>
									<td height="19" colspan="2">
									<table border="0" align="center" cellpadding="2"
										cellspacing="2">
										<tr>
											<td width="56"><!--|| "B".equals(""+session.getAttribute("USERTYPE"))-->
											<%
 
if(!rflag || "F".equals(""+session.getAttribute("USERTYPE")) )
	out.println("<input type='submit' name='Submit' id='submit_btn' class='buttonbold' value='Submit' />");

%>
											</td>
											<td width="56"><input type="button" name="submit"
												class="buttonbold" value="Close" accesskey="c"
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
				<td valign="top">
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
			%>
						</td>
					</tr>
					<tr>
						<td width="105">
						<div align="center" class="copyright"><strong>Staff
						Photo<%=staffVal[20]%> </strong></div>
						</td>
					</tr>
					<tr>
						<td rowspan="5"></td>
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
						<td class="boldEleven"></td>
					</tr>
					<tr>
						<td class="boldEleven">
						<%
String staffPhotoData[][] =com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT IMG_IMAGE FROM com_m_staffaddressproof WHERE CHR_EMPID='"+staffid.trim()+"'");
 
						//if(staffPhotoData.length>0)
							if(!"-".equals(staffPhotoData[0][0].trim()))
							{
						  %> <iframe src="../DisplayImages?myid=<%=staffid.trim()%>"
							name="staffMain" width="130" height="160" frameborder="0">
						</iframe>
						<div align="center">
						<%
						  	}
							else
							{
									if (f.exists())
										photo ="../StaffPhoto/"+staffid.trim() +".jpg";
									else
										photo =defaul;
				
							%> <img src="<%=photo%>" title="<%=photo%>" width="auto"
							height="auto" border="1" name="Photo" id="Photo" /> <%	
							}
						  %>
						</div>
						</td>
					</tr>
					<tr>
						<td class="boldEleven">
						<table width="120" align="center">
							<tr>
								<td>
								<div align="center"><input name="Button" type="Button"
									class="buttonbold" onClick="return PhotoUpload('<%=staffid%>')"
									value="Upload Photo"></div>
								</td>
							</tr>
						</table>

						</td>
					</tr>
				</table>
				<table width="100%" border="0" align="center" cellpadding="1"
					cellspacing="3" bordercolor="#D4D0C8" class="boldEleven">
					<tr>
						<td width="105"></td>
					</tr>
					<tr>
						<td class="boldEleven">&nbsp;</td>
					</tr>
					<tr>
						<td class="boldEleven">&nbsp;</td>
					</tr>
					<tr>
						<td rowspan="5">&nbsp;</td>
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
						<td width="100%">
						<table width="120" align="center">
							<tr>
								<td>
								<div align="center"><input name="Button2" type="Button"
									class="buttonbold"
									onClick="return ProfileUpload('<%=staffid%>')"
									value="Upload Resume"></div>
								</td>
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
						<td class="boldEleven">

						<div align="center">
						<%
			String profile = request.getRealPath("/")+"Staff Resume/"+staffid.trim() +".doc";
			f = new File(profile);
			if (f.exists())
			{
				%> Profile view <a
							href='<%="../Staff Resume/"+staffid.trim()+".doc"%>'><img
							src="../Image/report/news_info.gif" width="16" height="16"
							border="0"></a> <%
			}
			%>
						</div>
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
						<td class="boldEleven">
						<table width="120" align="center">
							<tr>
								<td>
								<div align="center"><input name="AD" type="Button"
									class="buttonbold" id="AD"
									onClick="return AddressProofUpload('<%=staffid%>')"
									value="Upload Address Proof"></div>
								</td>
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
						<td class="boldEleven">&nbsp;</td>
					</tr>
					<tr>
						<td class="boldEleven">&nbsp;</td>
					</tr>
					<tr>
						<td class="boldEleven" align="center">
						<table width="120" align="center">
							<tr>
								<td><input name="ADv" type="Button" class="buttonbold"
									onClick="return ViewAddressProof('<%=staffid%>')"
									value="View Address Proof"></td>
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
		<td class="boldEleven">&nbsp;</td>
	</tr>
	<tr>
		<td class="boldEleven">&nbsp;</td>
	</tr>
	<tr>
		<td class="boldEleven"><%@ include file="../footer.jsp"%></td>
	</tr>
</table>

</body>
</form>
</html>



<script language="javascript">
 
    	
		function changeState1()
    	{
       		cwd.style.visibility="visible";
     	}
			 
     	function changeState()
    	{
        	document.a.wedding.value=""
		 	cwd.style.visibility="hidden";
    	} 
	
var mm ="<%=staffVal[20]%>";
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
			newWindow = window.open(f,"subWind",",,height=280,width=375,top=0,left=0");
			newWindow.focus( );
		}
		return true 	
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
			newWindow = window.open(f,"subWind",",,height=250,width=325,top=0,left=0");
			newWindow.focus( );
		}
		return true 	
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
			newWindow = window.open(f,"subWind",",,height=250,width=325,top=0,left=0");
			newWindow.focus( );
		}
		return true ;	
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
		}
		return true 	
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
