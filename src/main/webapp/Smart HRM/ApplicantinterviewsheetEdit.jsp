<%@ page import="java.sql.*,java.io.*,java.util.*" %>
<%@ page import="com.my.org.erp.common.CommonFunctions" %>
 
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
<table width="100%" border="0">
  <tr>
    <td>
	<%@ include file="indexhrm.jsp"%>	
	 
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
                <td colspan="2"><div align="center"><span class="boldThirteen">APPLICANT INTERVIEW SHEET
				
				<%
				String rowid = request.getParameter("rowid");
				String sql="";
				sql = " SELECT a.INT_INTERVIEWID,a.INT_APPLICANTID,b.CHR_APPCODE,b.CHR_APPNAME, ";
				sql = sql + "  DATE_FORMAT(a.DAT_DOI,'%d-%m-%Y'),a.CHR_POSITION,a.INT_TOTALEXP, ";
				sql = sql + "  a.INT_QUALIFICATIONID,a.INT_AGE,a.DOU_CSALARY,a.DOU_ESALARY,a.INT_NOTICEPERIOD, ";
				sql = sql + "  a.CHR_VEHICLE,a.CHR_RELOCATION,a.CHR_FIELDWORK,a.CHR_REFERENCE,a.CHR_PREFEREDLOCATION, ";
				sql = sql + "  a.CHR_SKILLIDS,a.CHR_SKILLLEVELS,a.CHR_TECHNICALIDS,a.CHR_TECHNICALLEVELS, ";
				sql = sql + "  a.CHR_FIRSTINTERVIEWBY, DATE_FORMAT(a.DAT_FIRSTINTERVIEWDATE,'%d-%m-%Y'), ";
				sql = sql + "  a.CHR_FIRSTCOMMENTS,a.CHR_ALLOWSECONDINTERVIEW ";
				sql = sql + "  FROM hrm_t_interview a, hrm_m_application b ";
				sql = sql + "  WHERE a.INT_APPLICANTID = b.INT_APPID ";
				sql = sql + "  AND a.INT_INTERVIEWID="+rowid;
				String rowdata[][]   =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				%>
				</span></div></td>
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
                            
							<%=rowdata[0][2]+"/"+rowdata[0][3]%>
							<input name="applicantid"  id="applicantid" type="hidden" value="<%=rowdata[0][1]%>">
							<input name="rowid"  id="rowid" type="hidden" value="<%=rowid%>">
							 
                          </span></td>
                          <td class="boldEleven">Date of Interview  <span class="style3"><font color="red">*</font></span></td>
                          <td><input   name="doi" type="text" class="formText135"  id="doi"  title="dd/mm/yyyy" value="<%=rowdata[0][4]%>" size="22" maxlength="10"  readonly="readonly"/>
                                     </td>
                        </tr>
                        <tr>
                          <td class="boldEleven">Position <span class="style3"><font color="red">*</font></span></td>
                          <td>
						  
						  
						  
						  
						  <select name="position" class="formText135" id="position"    >
       		       <option value="0">Select Position</option>
				   <%
				   	String podata[][]=com.my.org.erp.common.CommonInfo.RecordSetArray(" SELECT INT_DESIGID, CHR_DESIGNAME FROM com_m_desig  ORDER BY  CHR_DESIGNAME ");
					for(int c=0;c<podata.length;c++)
						out.println("<option value='"+podata[c][0]+"'  >"+podata[c][1]+"</option>");	
					
				
				   %>
				   </select>
				   
				   <script language="javascript">setOptionValue('position','<%=rowdata[0][5]%>')</script>
						  </td>
                          <td class="boldEleven">Total Experience  <span class="style3"><font color="red">*</font></span></td>
                          <td><select name="experience" id="experience" style="width:200px">
            <option value="0"  >Select Experience</option>
            <option value="-1">Below one year</option>
            <option value="-2">Below 6-months</option>
            <option value="-3">Fresher</option>
            <%
			for(int u=1;u<25;u++)
				out.println("<option value="+u+">"+u+"+</option>");
		%>
        </select></td>
                        </tr>
                        <tr>
                          <td rowspan="4" valign="top" class="boldEleven">Qualification <span class="style3"><font color="red">*</font></span></td>
                          <td rowspan="4" valign="top"><select name="education"  class="formText135" size="6" id="education" style="width:200px" multiple="multiple">
									<option value="0"  >Select Education</option>
									<%
										String ssql=" SELECT INT_QUALIFICATIONID,CHR_QUALIFICATIONNAME FROM com_m_qualification ORDER BY CHR_QUALIFICATIONNAME";
										String qualdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(ssql);
										
										 
										for(int c=0;c<qualdata.length;c++)
										 out.println("<option value='"+qualdata[c][0]+"'  >"+qualdata[c][1]+"</option>");	
														
										 
									
									%>
								</select></td>
                          <td class="boldEleven">Age <span class="style3"><font color="red">*</font></span></td>
                          <td><span class="boldEleven">
                            <select name="age" size="1" class="formText135" id="age" style="width:200px" >
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
                          <td><input name="csalary" type="text" class="formText135" id="csalary"  onKeyPress="return numeric_only(event,'csalary','12')" value="<%=rowdata[0][9]%>" size="30" maxlength="12" ></td>
                        </tr>
                        <tr>
                          <td class="boldEleven">Expected Salary  <span class="style3"><font color="red">*</font></span></td>
                          <td><input name="esalary" type="text" class="formText135" id="esalary"  onKeyPress="return numeric_only(event,'esalary','12')" value="<%=rowdata[0][10]%>" size="30" maxlength="12" ></td>
                        </tr>
                        <tr>
                          <td class="boldEleven">Notice Period  <span class="style3"><font color="red">*</font></span></td>
                          <td><span class="boldEleven">
                            <select name="noticeperiod" size="1" class="formText135" id="noticeperiod" style="width:50px" >
                              <option value="0" selected="selected">Select Age</option>
                              <%
										for(int c=1;c<100;c++)
											out.println("<option value='"+c+"'>"+c+" - days </option>");
										
									%>
                            </select>
                          </span></td>
                        </tr>
                         
                        <tr>
                          <td class="boldEleven">Vehicle
						  <%
						  String s1="";
						  String s2="";
						  if("Y".equals(rowdata[0][12]))
						  	s1= " checked='checked' ";
						else
							s2=" checked='checked'";
						  %>
						  </td>
                          <td><table width="100" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                              <td class="boldEleven"><input name="vehicle" type="radio" value="Y" <%=s1%> ></td>
                              <td class="boldEleven">Yes</td>
                              <td class="boldEleven"><input name="vehicle" type="radio" value="N" <%=s2%>  ></td>
                              <td class="boldEleven">No</td>
                            </tr>
                          </table></td>
                          <td class="boldEleven">Field Work </td>
                          <td><input name="fieldwork" type="text" class="formText135" id="fieldwork" value="<%=rowdata[0][14]%>" size="30" maxlength="100"></td>
                        </tr>
                        <tr>
                          <td class="boldEleven">Re_Location
						  <%
						    s1="";
						    s2="";
						  if("Y".equals(rowdata[0][13]))
						  	s1= " checked='checked' ";
						else
							s2=" checked='checked'";
							%>
						  </td>
                          <td><table width="100" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                              <td class="boldEleven"><input name="relocation" type="radio" value="Y"  <%=s1%>></td>
                              <td class="boldEleven">Yes</td>
                              <td class="boldEleven"><input name="relocation" type="radio" value="N"   <%=s2%>></td>
                              <td class="boldEleven">No</td>
                            </tr>
                          </table></td>
                          <td class="boldEleven">Refered By </td>
                          <td><input name="referedby" type="text" class="formText135" id="referedby" value="<%=rowdata[0][15]%>" size="30" maxlength="100"></td>
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
                </select><script language="javascript">setOptionValue('preferedlocation','<%=rowdata[0][16]%>')</script> 
						  
						  
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
                        <td colspan="4" class="boldEleven"><%
 
 String jobid=com.my.org.erp.common.CommonFunctions.QueryExecute(" SELECT INT_JOBID FROM hrm_m_application WHERE INT_APPID= "+rowdata[0][1])[0][0]; 
 String skilldata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_SKILLID ,CHR_SKILLNAME FROM  hrm_m_skilllevel WHERE  INT_SKILLID in("+rowdata[0][17]+"0)  ORDER BY INT_SKILLID ");
 
   	out.println("<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
 	out.println("<tr class='MRow1'>");
	out.println("<td class='boldEleven'><b>S.No</b></td>");
	out.println("<td class='boldEleven'><b>Skill Name</b></td>");
	out.println("<td class='boldEleven'><b>Level 1</b></td>");
	out.println("<td class='boldEleven'><b>Level 2</b></td>");
	out.println("<td class='boldEleven'><b>Level 3</b></td>");
	out.println("<td class='boldEleven'><b>Level 4</b></td>");
	out.println("<td class='boldEleven'><b>Level 5</b></td>");
	out.println("</tr>");
 if(skilldata.length>0)
 {
	 String skilldbdata[] = rowdata[0][18].split(",");
	 for(int u=0;u<skilldata.length;u++)
	{
		if(u%2==0)
			out.println("<tr class='MRow1'>");
		else
			out.println("<tr class='MRow2'>");
		
		out.println("<td class='boldEleven'><b>"+(u+1)+"</b></td>");
		out.println("<td class='boldEleven'><b>"+skilldata[u][1]+"</b></td>");
		s1="";
		if("1".equals(skilldbdata[u]))
			s1=" checked = 'checked' ";
		out.println("<td class='boldEleven'><input name='skill_"+skilldata[u][0]+"'  id='skill_"+skilldata[u][0]+"'  "+s1+"  type='radio' value='1'></td>");
		
		s1="";
		if("2".equals(skilldbdata[u]))
			s1=" checked = 'checked' ";
		out.println("<td class='boldEleven'><input name='skill_"+skilldata[u][0]+"'  id='skill_"+skilldata[u][0]+"'   "+s1+"   type='radio' value='2'></td>");
		
		s1="";
		if("3".equals(skilldbdata[u]))
			s1=" checked = 'checked' ";
		out.println("<td class='boldEleven'><input name='skill_"+skilldata[u][0]+"'  id='skill_"+skilldata[u][0]+"'   "+s1+"   type='radio' value='3'></td>");
		
		s1="";
		if("4".equals(skilldbdata[u]))
			s1=" checked = 'checked' ";
		out.println("<td class='boldEleven'><input name='skill_"+skilldata[u][0]+"'  id='skill_"+skilldata[u][0]+"'    "+s1+"  type='radio' value='4'></td>");
		
		s1="";
		if("5".equals(skilldbdata[u]))
			s1=" checked = 'checked' ";
		out.println("<td class='boldEleven'><input name='skill_"+skilldata[u][0]+"'  id='skill_"+skilldata[u][0]+"'    "+s1+"  type='radio' value='5'></td>");
		out.println("</tr>");
	} 
 }
 out.println("</table>");
 
 
 
%></td>
                        </tr>

                    </table></td>
                  </tr>
                </table></td>
              </tr>
              <tr>
                <td height="19" colspan="2">&nbsp;</td>
              </tr>
              <tr>
                <td height="19" colspan="2">&nbsp;</td>
              </tr>
              <tr>
                <td height="19" colspan="2"><table width="100%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#FFFF00">
                  
                </table></td>
              </tr>
              <tr>
                <td height="19" colspan="2"><table width="649" border="0" align="center" cellpadding="0" cellspacing="0">
                  <tr>
                    <td class="boldEleven">Interviewed By  <span class="style3"><font color="red">*</font></span> </td>
                    <td>
					<select name="InterviewedBy" id="InterviewedBy" class="formText135" size="5">
					
					<%
 
 String offid= ""+session.getAttribute("OFFICEID");
   
 	String empdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT a.CHR_EMPID,a.CHR_STAFFNAME FROM  com_m_staff a WHERE  a.CHR_TYPE !='T'  AND a.CHR_INTERVIEW='Y' ORDER BY a.CHR_STAFFNAME ");
 

  				  for(int y=0; y<empdata.length;y++)
				  	out.println("<option  value='"+empdata[y][0]+"' title='"+empdata[y][0]+"'>"+empdata[y][1]+" / " +empdata[y][0]+ "</option>");	
%>
</select></td>
                  </tr>
                  <tr>
                    <td class="boldEleven">Comments and suggesstions  <span class="style3"><font color="red">*</font></span> </td>
                    <td><textarea name="comments" cols="50"
										rows="5" class="formText135" id="comments" tabindex="9" onKeyUp="textArea('comments','2000')"><%=rowdata[0][23]%></textarea></td>
                  </tr>
                  <tr>
                    <td class="boldEleven">Next Level </td>
                    <td>
					<%
					s1="";
					if("Y".equals(rowdata[0][24]))
						s1 = " checked ='checked' ";
					 
					%>
					<input name="NextLevel" type="checkbox" id="NextLevel" value="Y" <%=s1%> ></td>
                  </tr>
                </table></td>
              </tr>
              <tr>
                <td height="19">&nbsp;</td>
                <td><input name="filename" type="hidden" id="filename" value="InterviewSheet">
                    <input name="actionS" type="hidden" id="actionS" value="HRMInterViewSheetUpdate">
					
					 <script language="javascript">
							  setOptionValue('education','<%=rowdata[0][7]%>');
							  setOptionValue('experience','<%=rowdata[0][6]%>');
							  setOptionValue('age','<%=rowdata[0][8]%>');
							  setOptionValue('noticeperiod','<%=rowdata[0][11]%>');
							  setOptionValue('InterviewedBy','<%=rowdata[0][21]%>');
						</script> 
					</td>
              </tr>
              <tr>
                <td height="19" colspan="2"><table  border="0" align="center" cellpadding="2" cellspacing="2">
                    <tr>
                      <td width="56"><input type="submit" name="Submit" id="submit_btn" class="tMLAscreenHead" value="Update"  /></td>
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
   
  
 
//-->


function validateFields()
{
			if(
				
				checkNullSelect('applicantid','Select Applicant Id','0')
				&& checkNull('doi','Enter Date of Interview')
				&& checkNullSelect('position','Enter position','0')
				&& checkNullSelect('experience','Select Experience  ','0')
				&& checkNullSelect('education','Select Education  ','0')
				
				&& checkNullSelect('age','Select Age  ','0')
				&& checkNull('csalary','Enter Current salary')
				&& checkNull('esalary','Enter Expected salary')
				&& checkNullSelect('noticeperiod','Select Noticeperiod  ','0')
				&& checkNull('preferedlocation','Enter prefered location')
				&& checkNull('InterviewedBy','Select InterviewedBy')
				&& checkNull('comments','Enter comments')
				 
				
				)
					return true;
			else
					return false;
}

 setOptionValue('doi','');
</script>
  
</form>
</body>
</html>