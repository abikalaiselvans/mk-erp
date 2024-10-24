<%@ page import="java.sql.*,java.io.*,java.util.*" %>
<%
try
{
%>
<html>
<head>
 
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/common/PermanentSelectChangesCountry.js"></script>
<script language="javascript" src="../JavaScript/common/communicationSelectChangesCountry.js"></script>
<script language="JavaScript" src="../JavaScript/HRM/Applicant.js"></script>
 
	


<title>:: HRM ::</title>


  
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>

<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>

 
<script>
	$(function() {
		$( "#adate" ).datepicker({
			 
			changeMonth: true,
			minDate: -10, maxDate: "+0D" ,showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			numberOfMonths: 1,
			buttonImageOnly: true,
		});
	});

	
	$(function() {
		$( "#dob" ).datepicker({
			
			 
			changeMonth: true,
			changeYear: true,
			showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			numberOfMonths: 1,
			buttonImageOnly: true,
			
		});
	});

 $(function() {
		$( "#wedding" ).datepicker({
			 
			changeMonth: true,
			changeYear: true,
			showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			numberOfMonths: 1,
			buttonImageOnly: true,
		});
	});

 
	</script>
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">



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

<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   >
<form  AUTOCOMPLETE = "off" name="frm" method="post" action="../SmartLoginAuth" onSubmit="return validateFields()">
<%@ include file="indexhrm.jsp"%>	
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td>
	
	 
	</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td valign="top"> </td>
  </tr>
  <tr>
    <td align="center"><TABLE width=90% border=0 align=center cellPadding=0 cellSpacing=0 bgcolor="#dce4f9" class=BackGround>
      <TBODY>
        <TR>
          <TD colSpan=2 rowSpan=2><IMG height=7 src="../Image/General/TLCorner.gif" width=7></TD>
          <TD class=BorderLine height=1><SPACER height="1" 
                        width="1" type="block" /></TD>
          <TD colSpan=2 rowSpan=2><IMG height=7 src="../Image/General/TRCorner.gif" width=7></TD>
        </TR>
        <TR>
          <TD height=6><SPACER height="1" width="1" type="block"/></TD>
        </TR>
        <TR>
          <TD class=BorderLine width=1><SPACER height="1" 
                        width="1" type="block" /></TD>
          <TD width=6><SPACER height="1" width="1" type="block" 
                      /></TD>
          <TD   valign="top"><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td colspan="2"><div align="center"><span class="boldThirteen">Application Details</span></div></td>
              </tr>
              <tr>
                <td colspan="2"><div align="right"><span class="style3"><font color="red">*</font></span><span class="changePos">Mandatory</span></div></td>
              </tr>
              <tr>
                <td colspan="2"></td>
              </tr>
              <tr>
                <td height="19" colspan="2"><table width="100%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#FFFF00">
                    <tr>
                      <td height="210"><table width="100%" border="0" align="center" cellpadding="2" cellspacing="2">
                          <tr>
                            <td width="50%" height="210" valign="top"><table width="100%" border="0" align="center" cellpadding="1" cellspacing="2">
                                <tr>
                                  <td width="128" class="boldEleven">Applicant Name <span class="style3"><font color="red">*</font></span> </td>
                                  <td width="189" class="boldEleven"><div id="DivAppCode">
                                      <input name="name" type="text" class="formText135" id="name" onKeyUp="upperMe(this)" size="30" maxlength="35"   />
                                  </div></td>
                                  <input type="hidden" name="appCode" value="document.getElementById(TxtAppCode).value">
                                </tr>
                                <tr>
                                  <td width="128" class="boldEleven"><div align="justify">Father's Name <span class="style3"><font color="red">*</font></span></div></td>
                                  <td class="boldEleven"><input name="fname" type="text" class="formText135" id="fname"  onKeyUp="upperMe(this)"  size="30" maxlength="30"   /></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">Office  <font color="red">*</font></td>
                                  <td class="boldEleven"><span class="bold1">
                                    <select name="office" class="formText135" id="office" style="width:150">
                                      <option value="0">Select Office</option>
                                      <%
				   	String offdata[][]=com.my.org.erp.common.CommonInfo.RecordSetArray(" SELECT INT_OFFICEID,CHR_OFFICENAME FROM   com_m_office ORDER BY CHR_OFFICENAME ");
					for(int c=0;c<offdata.length;c++)
						out.println("<option value='"+offdata[c][0]+"'  >"+offdata[c][1]+"</option>");	
					
				
				   %>
                                    </select>
                                  </span></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven"><div align="justify">App. Date <font color="red">*</font></div></td>
                                  <td class="boldEleven"><input  title="dd/mm/yyyy"  name="adate"  id="adate" type="text" class="formText135" size="30" maxlength="10"  readonly="readonly" value=""/>
								  <script language="javascript">setCurrentDate('adate')</script>
                                   </td>
                                </tr>
                                <tr>
                                  <td class="boldEleven"><div align="justify">Job Grade <span class="style3"><font color="red">*</font></span></div></td>
                                  <td><select name="jobgrade" class="formText135" id="jobgrade" onChange="loadComboJobTitle(this)" style="width:150">
                                      <option value="0">Select</option>
                                      <option value="Top">Group-1</option>
                                      <option value="Middle">Group-2</option>
                                      <option value="Bottom">Group-3</option>
                                  </select></td>
                                </tr>
                                <tr >
                                  <td width="128" height="29" valign="middle" class="boldEleven"><div align="justify">
                                      <div align="justify">Job Title <span class="style3"><font color="red">*</font></span></div>
                                  </div></td>
                                  <td><select name="jobtitle" id="jobtitle" class="formText135" style="width:150" >
                                      <option value="0">Select </option>
                                  </select></td>
                                </tr>
                                <tr >
                                  <td width="128" height="29" valign="middle" class="boldEleven">Gender</td>
                                  <td><table width="152" border="0" cellspacing="0" cellpadding="0">
                                      <tr>
                                        <td width="20" class="boldEleven"><input name="gender" type="radio" value="M" checked="checked" class="formText135" />                                        </td>
                                        <td width="47" class="boldEleven">Male</td>
                                        <td width="26" class="boldEleven"><input name="gender" type="radio" value="F" class="formText135" />                                        </td>
                                        <td width="59" class="boldEleven">Female</td>
                                      </tr>
                                  </table></td>
                                </tr>
                                 
                                <tr>
                                  <td class="boldEleven"><div align="justify">Blood Group</div></td>
                                  <td class="boldEleven"><%@ include file="../JavaScript/bloodgroup.jsp" %></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">Language Proficiency Details <span class="errormessage">*</span></td>
                                  <td class="boldEleven"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                      <td class="boldEleven">(1.)</td>
                                      <td><select name="language1"  id="language1" class="formText135">
                                          <option value="0" selected="selected">Select</option>
                                          <option value="ENGLISH">ENGLISH</option>
                                          <option value="HINDI">HINDI</option>
                                          <option value="KANNADA">KANNADA</option>
                                          <option value="MALAYALAM">MALAYALAM</option>
                                          <option value="TAMIL"  >TAMIL</option>
                                          <option value="TELUGU">TELUGU</option>
                                          <option value="URDU">URDU</option>
                                      </select></td>
                                      <td><input type="checkbox" value="X" name="read1"  id="read1" class="formText135"></td>
                                      <td class="boldEleven">Read</td>
                                      <td class="boldEleven"><input type="checkbox" value="X" name="write1" id="write1"  class="formText135"></td>
                                      <td class="boldEleven">Write</td>
                                      <td class="boldEleven"><input type="checkbox" value="X" name="speak1"  ID="speak1" class="formText135"></td>
                                      <td class="boldEleven">Speak</td>
                                    </tr>
                                  </table></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                      <td class="boldEleven">(2.)</td>
                                      <td><select name="language2"  id="language2"  class="formText135">
                                          <option value="0" selected="selected">Select</option>
                                          <option value="ENGLISH">ENGLISH</option>
                                          <option value="HINDI">HINDI</option>
                                          <option value="KANNADA">KANNADA</option>
                                          <option value="MALAYALAM">MALAYALAM</option>
                                          <option value="TAMIL"  >TAMIL</option>
                                          <option value="TELUGU">TELUGU</option>
                                          <option value="URDU">URDU</option>
                                      </select></td>
                                      <td><input type="checkbox" value="X" name="read2" class="formText135"></td>
                                      <td class="boldEleven">Read</td>
                                      <td class="boldEleven"><input type="checkbox" value="X" name="write2" id="write2" class="formText135"></td>
                                      <td class="boldEleven">Write</td>
                                      <td class="boldEleven"><input type="checkbox" value="X" name="speak2"  id="speak2" class="formText135"></td>
                                      <td class="boldEleven">Speak</td>
                                    </tr>
                                  </table></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                      <td class="boldEleven">(3.)</td>
                                      <td><select name="language3"  id="language3" class="formText135">
                                          <option value="0" selected>Select</option>
                                          <option value="ENGLISH">ENGLISH</option>
                                          <option value="HINDI">HINDI</option>
                                          <option value="KANNADA">KANNADA</option>
                                          <option value="MALAYALAM">MALAYALAM</option>
                                          <option value="TAMIL"  >TAMIL</option>
                                          <option value="TELUGU">TELUGU</option>
                                          <option value="URDU">URDU</option>
                                      </select></td>
                                      <td><input type="checkbox" value="X" name="read3" class="formText135"></td>
                                      <td class="boldEleven">Read</td>
                                      <td class="boldEleven"><input type="checkbox" value="X" name="write3"  id="write3" class="formText135"></td>
                                      <td class="boldEleven">Write</td>
                                      <td class="boldEleven"><input type="checkbox" value="X" name="speak3"  id="speak3" class="formText135"></td>
                                      <td class="boldEleven">Speak</td>
                                    </tr>
                                  </table></td>
                                </tr>
                                <tr>
                                  <td align="left" valign="top" class="boldEleven">Key Skills </td>
                                  <td align="left" valign="top" class="boldEleven"><textarea name="keyskill" cols="30" rows="5" class="formText135" id="keyskill" onKeyUp="textArea('keyskill','1900')"></textarea></td>
                                </tr>
                                <tr>
                                  <td align="left" valign="top" class="boldEleven">Certificates (if any)</td>
                                  <td align="left" valign="top" class="boldEleven"><textarea name="certificates" cols="30" rows="5" class="formText135" onKeyUp="textArea('certificates','1900')"></textarea></td>
                                </tr>
                                
                            </table></td>
                            <td width="50%" valign="top"><table width="100%" border="0" align="center" cellpadding="1" cellspacing="2">
                                <tr>
                                  <td width="260" class="boldEleven">Marital Status </td>
                                  <td width="263"><table width="152" border="0" cellpadding="0" cellspacing="0" class="boldEleven">
                                      <tr>
                                        <td class="boldEleven"><input name="married"   type="radio" value="M" onClick="changeState1(this)" class="formText135" />                                        </td>
                                        <td class="boldEleven">Married</td>
                                        <td class="boldEleven"><input name="married"   type="radio" class="formText135" onClick="changeState(this)" value="U" checked />                                        </td>
                                        <td class="boldEleven">UnMarried</td>
                                      </tr>
                                  </table></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">Date Of Birth <font color="red">*</font> </td>
                                  <td><input  title="dd/mm/yyyy"   name="dob"  id="dob" type="text" class="formText135" size="22" maxlength="10"   readonly="readonly"/>
                                     </span></td>
                                </tr>
                                <tr id="cwd">
                                  <td class="boldEleven">Wedding Date </td>
                                  <td ><input   title="dd/mm/yyyy"    name="wedding"    id="wedding" type="text" class="formText135"   size="22" maxlength="10"   readonly="readonly"/>
                                     </span></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven"> Qualifications<font color="red">*</font></td>
                                  <td> 
								  
								  <select name="education"  class="formText135"   id="education" style="width:200px"  >
									<option value="0"  >Select Education</option>
									<%
										String ssql=" SELECT INT_QUALIFICATIONID,CHR_QUALIFICATIONNAME FROM com_m_qualification ORDER BY CHR_QUALIFICATIONNAME";
										String qualdata[][]=com.my.org.erp.common.CommonInfo.RecordSetArray(ssql);
										for(int c=0;c<qualdata.length;c++)
											out.println("<option value='"+qualdata[c][0]+"'  >"+qualdata[c][1]+"</option>");	
										
									
									%>
									</select>                                  </td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">E-mail Id<font color="red">*</font></td>
                                  <td><input name="emailid" type="email" class="formText135" id="emailid" size="25"  maxlength="50"/></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">Mobile <font color="red">*</font></td>
                                  <td><input name="mobilenumber" type="text" class="formText135" id="mobilenumber" onKeyPress="return numeric_only(event,'mobilenumber','12')"  size="25" maxlength="10" /></td>
                                </tr>
                                 
                                <tr>
                                  <td class="boldEleven">Do you have a bike</td>
                                  <td><table width="100" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                      <td class="boldEleven"><input type="radio" value="1" name="bike" class="formText135"></td>
                                      <td class="boldEleven">Yes</td>
                                      <td class="boldEleven"><input type="radio" checked value="0" name="bike" class="formText135"></td>
                                      <td class="boldEleven">No</td>
                                    </tr>
                                  </table></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">Ex-Employee </td>
                                  <td><table width="100" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td><input type="radio" value="Y" name="exemployee" class="formText135"></td>
              <td class="boldEleven">Yes</td>
              <td class="boldEleven"><input type="radio" checked value="N" name="exemployee" class="formText135"></td>
              <td class="boldEleven">No</td>
            </tr>
          </table></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">Passport </td>
                                  <td><input name="passport" type="text" class="formText135" id="passport"   size="25" maxlength="15" /></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">PAN No. </td>
                                  <td><input name="pan" type="text" class="formText135" id="pan"   size="25" maxlength="15" /></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">Driving Liscence No. </td>
                                  <td><input name="dlicence" type="text" class="formText135" id="dlicence"   size="25" maxlength="15" /></td>
                                </tr>
                                <tr>
                                  <td valign="top" class="boldEleven">Previous company details</td>
                                  <td valign="top" class="boldEleven"><textarea name="previousdetails" cols="30" rows="5" class="formText135" id="previousdetails"  onKeyUp="textArea('previousdetails','1900')"></textarea></td>
                                </tr>
                                <tr>
                                  <td valign="top" class="boldEleven">Breif description </td>
                                  <td class="boldEleven"><textarea name="description" cols="30" rows="5" class="formText135" id="description"  onKeyUp="textArea('description','1900')"></textarea></td>
                                </tr>
                                <tr>
                                  <td valign="top" class="boldEleven">Online Test </td>
                                  <td class="boldEleven"><table width="100" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                      <td class="boldEleven"><input name="onlinetest" type="radio" class="formText135" value="1" checked></td>
                                      <td class="boldEleven">Yes</td>
                                      <td class="boldEleven"><input type="radio" value="0" name="onlinetest" class="formText135"></td>
                                      <td class="boldEleven">No</td>
                                    </tr>
                                  </table></td>
                                </tr>
                                
                            </table></td>
                          </tr>
                      </table></td>
                    </tr>
                </table></td>
              </tr>
              <tr>
                <td height="19" colspan="2">&nbsp; </td>
              </tr>
              <tr>
                <td height="19" colspan="2"><table width="100%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#FFFF00">
                    <tr>
                      <td height="210"><table width="100%" border="0" align="center" cellpadding="2"
												cellspacing="2">
                          <tr>
                            <td height="23" colspan="2"><span class="boldEleven">Copy
                              Permanent to Communication
                              Address
                              <input onClick="return resoffval()" type="radio"
														value="yes" name="res">
                              Yes
                              <input name="res"
														type="radio" onClick="return resoffval()" value="no">
                              No </span></td>
                          </tr>
                          <tr>
                            <td width="50%" height="210"><table width="100%" border="0" align="center"
														cellpadding="1" cellspacing="2">
                                <tr>
                                  <td height="15" colspan="2" class="boldEleven"><div align="center"><strong>Permanent
                                    Address</strong></div></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td width="161" class="boldEleven">&nbsp;</td>
                                </tr>
                                <tr>
                                  <td width="50%" class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">&nbsp;</td>
                                </tr>
                                <tr>
                                  <td width="97" class="boldEleven">Address1<font
																class="bolddeepred" align="absmiddle">*</font></td>
                                  <td class="boldEleven">
<input name="padd1" type="text" class="formText135" id="padd1" onKeyUp="upperMe(this)" size="30" maxlength="50" /></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">Address2<font
																class="bolddeepred" align="absmiddle">*</font></td>
                                  <td class="boldEleven"><input name="padd2"
																type="text" class="formText135" id="padd2"
																 onKeyUp="upperMe(this)" size="30"
																maxlength="50" /></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">Country<font
																class="bolddeepred" align="absmiddle">*</font></td>
                                  <td class="boldEleven"><select name="pcountry" id="pcountry" style="width:170" onChange="PLoadSelectState()">
                                      <option value="0">Select Country</option>
                                      <%
	 		String creadData[][]= com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_COUNTRYID ,CHR_COUNTRYNAME FROM  com_m_country ORDER BY CHR_COUNTRYNAME");
			for(int i=0;i<creadData.length;i++)
				out.println("<option value='"+creadData[i][0]+"'>"+creadData[i][1]+"</option>");
	 %>
                                    </select>                                  </td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">State <font
																class="bolddeepred" align="absmiddle">*</font></td>
                                  <td class="boldEleven"><table width="150" border="0" cellspacing="0"
																cellpadding="0">
                                      <tr>
                                        <td><select name="pstate" id="pstate" style="width:170" onChange="PLoadSelectDistrict()">
                                            <option value="0" selected="selected">Select State</option>
                                        </select></td>
                                      </tr>
                                  </table></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">District<font
																class="bolddeepred" align="absmiddle">*</font></td>
                                  <td class="boldEleven"><select name="pdistrict" id="pdistrict" style="width:170" onChange=" PLoadSelectCity()">
                                      <option value="0" selected="selected">Select District</option>
                                    </select>                                  </td>
                                </tr>
                                 
                                <tr>
                                  <td class="boldEleven">Location<font
																class="bolddeepred" align="absmiddle">*</font></td>
                                  <td class="boldEleven"><select name="pcity" id="pcity" style="width:170" onChange="PAssignPincode('ppincode')">
                                      <option value="0" selected="selected">Select City</option>
                                    </select>                                  </td>
                                </tr>
                                
                                
                                
                                <tr>
                                  <td class="boldEleven">Pin Code<font
																class="bolddeepred" align="absmiddle">*</font></td>
                                  <td class="boldEleven"><input name="ppincode"
																type="text" class="formText135" id="ppincode"
																onKeyPress="return numeric_only(event,'ppincode','7')" size="25"
																maxlength="6"   onblur="fill();" onKeyUp="lookup(this.value);"/>
																 
		<div class="suggestionsBox" id="suggestions" style="display: none;width:150%;">
					<div class="suggestionList" id="autoSuggestionsList" style="OVERFLOW:auto;width:100%;height:200px" ></div>
		</div>
									  </td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">Phone No</td>
                                  <td class="boldEleven"><input name="pphone"
																type="text" class="formText135" id="pphone"
																onKeyPress="return numeric_only(event,'pphone','12')" size="25"
																maxlength="10" /></td>
                                </tr>
                            </table></td>
                            <td width="50%"><table width="100%" border="0" align="center"
														cellpadding="1" cellspacing="2">
                                <tr>
                                  <td colspan="2" class="boldEleven"><div align="center"><strong>Communication
                                    Address</strong></div></td>
                                </tr>
                                <tr>
                                  <td width="50%" class="boldEleven">&nbsp;</td>
                                  <td width="262" class="boldEleven"><table width="200" align="right">
                                      <TR>
                                        <TD width="56">
<script language="javascript">
function cityWindow(query)
{  
		var width="800", height="400";
  		var left = (screen.width/2) - width/2;
		var top = (screen.height/2) - height/2;
	 	var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=yes,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
		newWindow = window.open(query,"subWind",styleStr);
		newWindow.focus( );
}
</script>
<%
if("F".equals(""+session.getAttribute("USRTYPE")) || "B".equals(""+session.getAttribute("USRTYPE")) )
	out.println("<input name='cityname' onClick=\"javascript:cityWindow('../Smart Common/addCity.jsp')\" type='button' class='buttonbold13' id='cityname' value='Add City'>");
%>
</td>
                                      </tr>
                                  </table></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">&nbsp;</td>
                                </tr>
                                <tr>
                                  <td width="50%" class="boldEleven">Address1 <span class="style3"><font color="red">*</font></span></td>
                                  <td class="boldEleven"><input name="cadd1"
																type="text" class="formText135" id="cadd1"
																 onKeyUp="upperMe(this)" size="30"
																maxlength="50" /></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">Address2 <span class="style3"><font color="red">*</font></span></td>
                                  <td class="boldEleven"><input name="cadd2"
																type="text" class="formText135" id="cadd2"
																 onKeyUp="upperMe(this)" size="30"
																maxlength="50" /></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">Country <span class="style3"><font color="red">*</font></span></td>
                                  <td class="boldEleven"><select name="ccountry" id="ccountry" style="width:170" onChange="CLoadSelectState()">
                                      <option value="0">Select Country</option>
                                      <%
	 		for(int i=0;i<creadData.length;i++)
				out.println("<option value='"+creadData[i][0]+"'>"+creadData[i][1]+"</option>");
	 %>
                                    </select>                                  </td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">State  <span class="style3"><font color="red">*</font></span></td>
                                  <td class="boldEleven"><table width="150" border="0" cellspacing="0"
																cellpadding="0">
                                      <tr>
                                        <td><select name="cstate" id="cstate" style="width:170" onChange="CLoadSelectDistrict()">
                                            <option value="0" selected="selected">Select State</option>
                                        </select></td>
                                      </tr>
                                  </table></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">District <span class="style3"><font color="red">*</font></span></td>
                                  <td class="boldEleven"><select name="cdistrict" id="cdistrict" style="width:170" onChange=" CLoadSelectCity()">
                                      <option value="0" selected="selected">Select District</option>
                                    </select>                                  </td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">Location <span class="style3"><font color="red">*</font></span></td>
                                  <td class="boldEleven"><select name="ccity" id="ccity" style="width:170" onChange="CAssignPincode('cpincode')">
                                      <option value="0" selected="selected">Select City</option>
                                    </select>                                  </td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">Pin Code <span class="style3"><font color="red">*</font></span></td>
                                  <td class="boldEleven">
<input name="cpincode" 	type="text" class="formText135" id="cpincode"	onKeyPress="return numeric_only(event,'cpincode','7')" size="25" maxlength="6"  onBlur="cfill();" onKeyUp="clookup(this.value);" />
<div class="suggestionsBox1" id="suggestions1" style="display: none;width:150%;">
	<div class="suggestionList1" id="autoSuggestionsList1" style="OVERFLOW:auto;width:100%;height:200px" ></div>
</div>				
</td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">Phone No</td>
                                  <td class="boldEleven"><input name="cphone"
																type="text" class="formText135" id="cphone"
																onKeyPress="return numeric_only(event,'cphone','12')" size="25"
																maxlength="10" /></td>
                                </tr>
                            </table></td>
                          </tr>
                      </table></td>
                    </tr>
                </table></td>
              </tr>
              <tr>
                <td height="19">&nbsp;</td>
                <td><input name="filename" type="hidden" id="filename" value="Application">
                    <input name="actionS" type="hidden" id="actionS" value="HRMapplicationAdd"></td>
              </tr>
              <tr>
                <td height="19" colspan="2"><table  border="0" align="center" cellpadding="2" cellspacing="2">
                    <tr>
                      <td width="56"><input type="submit" name="Submit" id="submit_btn" class="tMLAscreenHead" value="Submit"   accesskey="s"     /></td>
                      <td width="56"><input type="button" name="submit" class="tMLAscreenHead"  value="Close"   accesskey="c"  onClick="redirect('Application.jsp')"  /></td>
                    </tr>
                </table></td>
              </tr>
          </table></TD>
          <TD noWrap width=7><SPACER height="1" width="1" 
                        type="block" /></TD>
          <TD class=BorderLine width=1><SPACER height="1" width="1" type="block" /></TD>
        </TR>
        <TR>
          <TD colSpan=2 rowSpan=2><IMG height=7 src="../Image/General/BLCorner.gif" width=7></TD>
          <TD height=6><SPACER height="1" width="1" type="block"/></TD>
          <TD colSpan=2 rowSpan=2 valign="bottom"><div align="right"><IMG height=7 src="../Image/General/BRCorner.gif" width=7></div></TD>
        </TR>
        <TR>
          <TD class=BorderLine height=1><SPACER height="1" width="1" type="block" /></TD>
        </TR>
      </TBODY>
    </TABLE></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><%@ include file="../footer.jsp"%></td>
  </tr>
</table>


<script language="javascript">
 
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
		document.frm.ccity.selectedIndex = 0;
		document.frm.cdistrict.selectedIndex = 0;
		document.frm.cstate.selectedIndex = 0;
		document.frm.ccountry.selectedIndex = 0;
		document.frm.cpincode.value = "";
		document.frm.cphone.value = "";
		
	}
	return true;
}//end of resoffval







var ComboMar="M";


  
function validateDate()
{ 
	try
	{
	
		if(document.frm.dob.value=="")
		{
			alert("Please Enter the Dob..");
			document.frm.dob.focus();
			return false;
		}	
		else
		{
			var d1 = document.frm.dob.value.split("-");
			var d2 = document.frm.wedding.value.split("-");
			var y1 = d2[2];
			var y2 = d1[2];
			
			if((y1-y2) <18)
			{
				alert("Wedding Age must be minimum 18 years...");
				return false;
			}	
		}	
		return true;
	}
	catch(err)
	{
		alert(err);
		return true;
	}	
}


 
 
 


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
   	 try
	 {
	 	if(
				
			 checkNull('name','Enter Applicant Name')
			 &&	checkNull('fname','Enter Father Name')
			 && checkNullSelect('office','Select office','0')
			 && checkNullSelect('jobgrade','Select Job Grade','0')
			 && checkNullSelect('jobtitle', 'Select Job Title', '0')
			 &&	checkNull('dob','Enter Date of Birth')
			 && validateDoj()
			 && checkNullSelect('education','Select education  ','0')
			 &&	checkNull('emailid','Enter emailid')
			 && chkemail('emailid')
			 &&	checkNull('mobilenumber','Enter mobile')
			 && checkNullSelect('language1','Select language1  ','0')
			 
			 
			 &&	checkNull('padd1','Enter Permanent  Address1')
			 &&	checkNull('padd2','Enter Permanent  Address2')
			 && checkNullSelect('pcountry','Select Permanent  Country','0')
			 && checkNullSelect('pstate','Select Permanent  State','0')
			 && checkNullSelect('pdistrict','Select Permanent  District','0')
			 && checkNullSelect('pcity','Select Permanent  Location','0')
			 &&	checkNull('ppincode','Enter Permanent  Pincode')
			  
			 &&	checkNull('cadd1','Enter Communication  Address1')
			 &&	checkNull('cadd2','Enter Communication  Address2')
			 && checkNullSelect('ccountry','Select Communication  Country','0')
			 && checkNullSelect('cstate','Select Communication  State','0')
			 && checkNullSelect('cdistrict','Select Communication  District','0')
			 && checkNullSelect('ccity','Select Communication  Location','0')
			 &&	checkNull('cpincode','Enter Communication  Pincode')
			  
			 
			 
		 
		 
		 )
		 {
			 
			return true;
		 }
		 else{
			 
			return false;	  
		 }
	}
	catch(err)
	{
		alert(err);
		return false;
		
	}
}	
	
		
	
function validateDoj()
{
	try
	{	
		var wdate = document.frm.wedding.value;
   	    var ddate = document.frm.dob.value;
 		if (ComboMar=="U")
 	    {
 		}
		else if (ComboMar=="M" && wdate != "" && ddate=="")
		{
		  	alert("Enter Date of Birth");
	    	document.frm.dob.focus();
		    return false;
    	}
		else
		{
			var d1 = document.frm.dob.value.split("-");
			var d2 = document.frm.wedding.value.split("-");
			var y1 = d2[2];
			var y2 = d1[2];
			mstat="";		
			if((y1-y2) <18)
			{
				alert("Applicant Age must'nt be minimum 18 years...");
				document.frm.dob.focus();
				return false;
			}
    	}	


		var d1 = document.frm.dob.value.split("-");
		var d2 = document.frm.adate.value.split("-");
		var y1 = d2[2];
		var y2 = d1[2];
		if((y1-y2) <15)
		{
			alert("Age must be over 15 years...");
			document.frm.dob.focus();
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
	
  
function PhotoUpload()
{
		var s =document.frm.TxtAppCode.value;
		if (s=="")
		{
			alert ("Please enter Application Code....");
			document.frm.TxtAppCode.focus();
			return false;
		}
		else
		{
			var f ="AppPhotoUpload.jsp?appCode="+s;
			newWindow = window.open(f,"subWind",",,height=280,width=340,top=0,left=0");
			newWindow.focus();
		}
		return true; 

}	



	
    function changeState1(ctr)
    {
		ComboMar = ctr.value;
       
	   cwd.style.visibility="visible";
    } 
     function changeState(ctr)
    {
    	ComboMar = ctr.value;
        
		 cwd.style.visibility="hidden";       		
    } 	
</script>
 
</form>
</body>
</html>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>