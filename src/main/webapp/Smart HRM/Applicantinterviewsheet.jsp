<%@ page import="java.sql.*,java.io.*,java.util.*" %>
<%@ page import="com.my.org.erp.common.CommonFunctions" %>
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
 <script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
<script>
	$(function() {
		$( "#doi" ).datepicker({
			changeMonth: true,
			minDate: -4, maxDate: "+1D" ,
			changeYear: true
		});
	});

	 
 
	</script>
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">


 


<title>:: HRM ::</title>


 
<script language="JavaScript" src="../JavaScript/calendar1.js"> </script>
 
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"><style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style></head>


<body  onpaste="return false;"   >
<form  AUTOCOMPLETE = "off" name="frm" method="post" action="../SmartLoginAuth" onSubmit="return validateFields()">
<%@ include file="indexhrm.jsp"%>	
<table width="100%" border="0">
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
    <td><TABLE width=787 border=0 align=center cellPadding=0 cellSpacing=0 bgcolor="#dce4f9" class=BackGround>
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
          <TD width=772 valign="top"><table width="772" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td colspan="2"><div align="center"><span class="boldThirteen">APPLICANT INTERVIEW SHEET </span></div></td>
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
                      <td height="210"><table width="100%" border="0" cellspacing="1" cellpadding="1">

                        <tr>
                          <td colspan="4" class="boldEleven"><div align="center" class="copyright">GENERAL INFORMATION </div></td>
                          </tr>
                        <tr>
                          <td class="boldEleven">&nbsp;</td>
                          <td>&nbsp;</td>
                          <td class="boldEleven">&nbsp;</td>
                          <td>&nbsp;</td>
                        </tr>
                        <tr>
                          <td class="boldEleven"><span class="boldEleven">Applicant Name <span class="style3"><font color="red">*</font></span></span></td>
                          <td><span class="boldEleven">
                            <select name="applicantid" class="formText135" id="applicantid" onChange="makeGetRequest(this)" >
                             <option value="0">Select Applicant Name</option>
							 <%
					  	 String adata[][]   = CommonFunctions.QueryExecute("select a.INT_APPID,a.CHR_APPCODE, a.CHR_APPNAME from  hrm_m_application a where a.CHR_INTERVIEWSTATUS='N'  AND a.CHR_OFFERORDERSTATUS='N'    AND NOT EXISTS ( SELECT b.INT_APPLICANTID from hrm_t_interview b WHERE b.INT_APPLICANTID= a.INT_APPID) ");//CHR_RESULT='P' and AND a.INT_ONLINETEST=1 
						for(int u=0;u<adata.length;u++)
							out.println("<option value='"+adata[u][0]+"'>"+adata[u][1]+" / "+adata[u][2]+ "</option>"); 
					  %>
                            </select>
                          </span></td>
                          <td class="boldEleven">Date of Interview  <span class="style3"><font color="red">*</font></span></td>
                          <td><input  title="dd/mm/yyyy"   name="doi"  id="doi" type="text" class="formText135" size="22" maxlength="10" readonly />
                                    <!--<a href="javascript:cal2.popup();"> <img src="../JavaScript/img/cal.gif" width="16" border="0" alt="Click here to Pick Up the Date" /></a>--></td>
                        </tr>
                        <tr>
                          <td class="boldEleven">Position <span class="style3"><font color="red">*</font></span></td>
                          <td>
						 <!-- <input name="position" type="text" class="formText135" id="position" size="30" maxlength="100">-->
						   <select name="position" class="formText135" id="position" style="width:200"    >
       		       <option value="0">Select Position</option>
				   <%
				   	String podata[][]=CommonFunctions.QueryExecute(" SELECT INT_DESIGID, CHR_DESIGNAME FROM com_m_desig  ORDER BY  CHR_DESIGNAME ");
					for(int c=0;c<podata.length;c++)
						out.println("<option value='"+podata[c][0]+"'  >"+podata[c][1]+"</option>");	
					
				
				   %>
				   </select>
						  
						  </td>
                          <td class="boldEleven">Total Experience  <span class="style3"><font color="red">*</font></span></td>
                          <td><select name="experience" id="experience" style="width:200px">
            <option value="0"  >Select Experience</option>
            <option value="-1">Below one year</option>
            <option value="-2">Fresher</option>
            <%
			for(int u=1;u<45;u++)
				out.println("<option value="+u+">"+u+"+</option>");
		%>
        </select></td>
                        </tr>
                        <tr>
                          <td rowspan="4" valign="top" class="boldEleven">Qualification <span class="style3"><font color="red">*</font></span></td>
                          <td rowspan="4" valign="top"><select name="education" size="6"  class="formText135" id="education" style="width:200px"  >
									<option value=""  >Select Education</option>
									<%
										 String ssql=" SELECT INT_QUALIFICATIONID,CHR_QUALIFICATIONNAME FROM com_m_qualification ORDER BY CHR_QUALIFICATIONNAME";
										String qualdata[][]= CommonFunctions.QueryExecute(ssql);
										
										 
										for(int c=0;c<qualdata.length;c++)
										 out.println("<option value='"+qualdata[c][0]+"'  >"+qualdata[c][1]+"</option>");	
														 
										 
									
									%>
								</select></td>
                          <td class="boldEleven">Age <span class="style3"><font color="red">*</font></span></td>
                          <td><span class="boldEleven">
                            <select name="age" size="1" class="formText135" id="age" style="width:200px">
                              <option value="0" selected="selected">Select Age</option>
                              <%
										for(int c=15;c<100;c++)
											out.println("<option value='"+c+"'>"+c+"</option>");
										
									%>
                            </select>
                          </span></td>
                        </tr>
                        <tr>
                          <td class="boldEleven">Current Salary  <span class="style3"><font color="red">*</font></span></td>
                          <td><input name="csalary" type="text" class="formText135" id="csalary" size="30" maxlength="12"  onKeyPress="return numeric_only(event,'csalary','12')" ></td>
                        </tr>
                        <tr>
                          <td class="boldEleven">Expected Salary  <span class="style3"><font color="red">*</font></span></td>
                          <td><input name="esalary" type="text" class="formText135" id="esalary" size="30" maxlength="12"  onKeyPress="return numeric_only(event,'esalary','12')" ></td>
                        </tr>
                        <tr>
                          <td class="boldEleven">Notice Period  <span class="style3"><font color="red">*</font></span></td>
                          <td><span class="boldEleven">
                            <select name="noticeperiod" size="1" class="formText135" id="noticeperiod"  style="width:200"  >
                              <option value="0" selected="selected">Select Notice period</option>
                              <%
										for(int c=1;c<100;c++)
											out.println("<option value='"+c+"'>"+c+" - days </option>");
										
									%>
                            </select>
                          </span></td>
                        </tr>
                         
                        <tr>
                          <td class="boldEleven">Vehicle</td>
                          <td><table width="100" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                              <td class="boldEleven"><input name="vehicle" type="radio" value="Y"></td>
                              <td class="boldEleven">Yes</td>
                              <td class="boldEleven"><input name="vehicle" type="radio" value="N" checked></td>
                              <td class="boldEleven">No</td>
                            </tr>
                          </table></td>
                          <td class="boldEleven">Field Work </td>
                          <td><input name="fieldwork" type="text" class="formText135" id="fieldwork" size="30" maxlength="100"></td>
                        </tr>
                        <tr>
                          <td class="boldEleven">Re_Location</td>
                          <td><table width="100" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                              <td class="boldEleven"><input name="relocation" type="radio" value="Y"></td>
                              <td class="boldEleven">Yes</td>
                              <td class="boldEleven"><input name="relocation" type="radio" value="N" checked></td>
                              <td class="boldEleven">No</td>
                            </tr>
                          </table></td>
                          <td class="boldEleven">Refered By </td>
                          <td><input name="referedby" type="text" class="formText135" id="referedby" size="30" maxlength="100"></td>
                        </tr>
                        <tr>
                          <td class="boldEleven">Prefered Location <span class="style3"><font color="red">*</font></span> </td>
                          <td>
						  
						  <select name="preferedlocation" class="formText135" id="preferedlocation">
                  <option value="">Select Prefered Location</option>
                  <%
			String offdata[][]= CommonFunctions.QueryExecute("SELECT INT_OFFICEID,CHR_OFFICENAME FROM   com_m_office   ORDER BY CHR_OFFICENAME");
			for(int h=0;h<offdata.length;h++)
				out.print("<option value='"+offdata[h][0]+"'>"+offdata[h][1]+"</option>");
			
			
			%>
                </select>
						  
						  </td>
                          <td class="boldEleven">&nbsp;</td>
                          <td>&nbsp;</td>
                        </tr>
                      </table></td>
                    </tr>
                </table></td>
              </tr>
              <tr>
                <td height="19" colspan="2"><p>&nbsp;</p>
                  </td>
              </tr>
              <tr>
                <td height="19" colspan="2"><table width="100%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#FFFF00">
                  <tr>
                    <td height="101"><table width="100%" border="0" cellspacing="3" cellpadding="2">
                      <tr>
                        <td class="boldEleven">&nbsp;</td>
                        <td>&nbsp;</td>
                        <td class="boldEleven">&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr>
                        <td colspan="4" class="boldEleven"><div align="center" class="copyright">SKILL INFORMATION </div></td>
                      </tr>
                      <tr>
                        <td colspan="4" class="boldEleven">
						
						
<div id="skilldiv"></div>


<script language="javascript">
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
function makeGetRequest(applicantid) 
{
	try
	{
		if(applicantid.value !=0)
		{
			var url ='SkillInsert.jsp?id=' + applicantid.value;
			http.open('get', url);
			http.onreadystatechange = processResponse;
			http.send(null);
		}
		else
		{	
			alert("Select Applicat Name...");
		}	
	}
	catch(err)
	{
		alert(err);
	}	
}

function processResponse() 
{
	try
	{
		if(http.readyState == 4)
		{
			var response = http.responseText;
			document.getElementById('skilldiv').innerHTML = response;
			var v1 = document.getElementById('deducation').value;
		var v2 = document.getElementById('dage').value;
		setOptionValue('education',v1);
		setOptionValue('age',v2);
		}
		
		
		
		//alert();
	}
	catch(err)
	{	
		alert(err);
	}
}

 

</script>
						
						
		</td>
                        </tr>

                    </table></td>
                  </tr>
                </table></td>
              </tr>
              <tr>
                <td height="19" colspan="2">&nbsp;</td>
              </tr>
               
              <tr>
                <td height="19" colspan="2"><table width="649" border="0" align="center" cellpadding="2" cellspacing="2">
                  <tr>
                    <td class="boldEleven">Interviewed By  <span class="style3"><font color="red">*</font></span></td>
                    <td>
					<select name="InterviewedBy" id="InterviewedBy" class="formText135" size="5">
					
					<%
  
 
						String Data[][] =  CommonFunctions.QueryExecute("SELECT a.CHR_EMPID,a.CHR_STAFFNAME FROM  com_m_staff a WHERE  a.CHR_TYPE !='T'  AND a.CHR_INTERVIEW='Y' ORDER BY a.CHR_STAFFNAME" );
				
						for (int i=0; i<Data.length; i++)
							out.println("<option value= '" +Data[i][0]+ "'>" +Data[i][0]+" /  " +Data[i][1]+ "</option>"); 
%>
</select></td>
                  </tr>
                  <tr>
                    <td class="boldEleven">Comments and suggesstions  <span class="style3"><font color="red">*</font></span></td>
                    <td><textarea name="comments" cols="50"
										rows="5" class="formText135" id="comments" tabindex="9" onKeyUp="textArea('comments','2000')"></textarea></td>
                  </tr>
                  <tr>
                    <td class="boldEleven">Next Level </td>
                    <td><input name="NextLevel" type="checkbox" id="NextLevel" value="Y"></td>
                  </tr>
                </table></td>
              </tr>
              <tr>
                <td height="19">&nbsp;</td>
                <td><input name="filename" type="hidden" id="filename" value="InterviewSheet">
                    <input name="actionS" type="hidden" id="actionS" value="HRMInterViewSheetAdd"></td>
              </tr>
              <tr>
                <td height="19" colspan="2"><table  border="0" align="center" cellpadding="2" cellspacing="2">
                    <tr>
                      <td width="56"><input type="submit" name="Submit" id="submit_btn" class="tMLAscreenHead" value="Submit"   accesskey="s"     /></td>
                      <td width="56"><input type="button" name="submit" class="tMLAscreenHead"  value="Close"   accesskey="c"  onClick="redirect('ApplicantGeneralInformations.jsp')"  /></td>
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
<script language="JavaScript">
<!--
   
  
  var cal2=new calendar1(document.forms['frm'].elements['doi']);
  cal2.year_scroll=true;
  cal2.time_comp=false; 
  setCurrentDate('doi'); 
  
 
//-->


function validateFields()
{
			
			
			 
			if(
				
				checkNullSelect('applicantid','Select Applicant Name','0')
				&& checkNull('doi','Enter Date of Interview')
				&& checkNullSelect('position','Enter position','0')
				&& checkNullSelect('experience','Select Experience  ','0')
				&& checkNull('education','Select Education  ')
				&& checkNullSelect('education','Select Education  ','0')
				
				&& checkNullSelect('age','Select Age  ','0')
				&& checkNull('csalary','Enter Current salary')
				&& checkNull('esalary','Enter Expected salary')
				//&& salaryCheck(document.getElementById('csalary').value, document.getElementById('esalary').value)
				&& checkNullSelect('noticeperiod','Select Noticeperiod  ','0')
				&& checkNull('preferedlocation','Enter prefered location')
				&& checkNull('InterviewedBy','Select InterviewedBy')
				&& checkNull('comments','Enter comments')
				 
				
				)
					return true;
			else
					return false;
}

 
 
 function salaryCheck(cs,es)
 {
 	var cs1 = parseInt(cs);
	var es1 = parseInt(es);
	if(es1>=cs1)
		return true;
	else
	{
		alert("Expected salary should be greater than or equal to current salary....");
		document.getElementById('esalary').focus();
		return false;
	}
	
 }
</script>
  
</form>
</body>
</html>

<%
}
catch(Exception e)
{
}
%>