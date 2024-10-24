<%@ page import="java.sql.*,java.io.*,java.util.*"   errorPage="../error/index.jsp"%>
<%@ page import="com.my.org.erp.common.CommonFunctions" %>

 
<html>
<head>

<%
try
{
%>

<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/common/PermanentSelectChangesCountry.js"></script>
<script language="javascript" src="../JavaScript/common/communicationSelectChangesCountry.js"></script>
<script language="JavaScript" src="../JavaScript/HRM/Applicant.js"></script>
 

 


<title>:: HRM ::</title>


 
<script language="JavaScript" src="../JavaScript/calendar1.js"> </script>
 
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>


<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   >
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
                <td colspan="2"><div align="center"><span class="boldThirteen"> SECOND INTERVIEW 
				
				      <%
				String rowid = request.getParameter("rowid");
				String sql="";
				
				sql = " SELECT COUNT(*)  ";
				sql = sql + "  FROM hrm_t_interview a, hrm_m_application b ";
				sql = sql + "  WHERE a.INT_APPLICANTID = b.INT_APPID  AND  a.CHR_CANDIDATESTATUS ='N'  AND a.CHR_FINALSTATUS='N'";
				sql = sql + "  AND a.INT_INTERVIEWID="+rowid;
				if(!com.my.org.erp.common.CommonFunction.RecordExist(sql))
					response.sendRedirect("HRSecondInterview.jsp");
					
					
					
				sql = " SELECT a.INT_INTERVIEWID,a.INT_APPLICANTID,b.CHR_APPCODE,b.CHR_APPNAME, ";
				sql = sql + "  DATE_FORMAT(a.DAT_DOI,'%d-%m-%Y'),a.CHR_POSITION,a.INT_TOTALEXP, ";
				sql = sql + "  a.INT_QUALIFICATIONID,a.INT_AGE,a.DOU_CSALARY,a.DOU_ESALARY,a.INT_NOTICEPERIOD, ";
				sql = sql + "  a.CHR_VEHICLE,a.CHR_RELOCATION,a.CHR_FIELDWORK,a.CHR_REFERENCE,a.CHR_PREFEREDLOCATION, ";
				sql = sql + "  a.CHR_SKILLIDS,a.CHR_SKILLLEVELS,a.CHR_TECHNICALIDS,a.CHR_TECHNICALLEVELS, ";
				sql = sql + "  a.CHR_FIRSTINTERVIEWBY,  a.DAT_FIRSTINTERVIEWDATE , ";
				sql = sql + "  a.CHR_FIRSTCOMMENTS,a.CHR_ALLOWSECONDINTERVIEW ,";
				sql = sql + "  a.CHR_SECONDINTERVIEWBY , a.CHR_SECONDCOMMENTS , a.CHR_ALLOWTHIRDINTERVIEW  ";
				sql = sql + "  FROM hrm_t_interview a, hrm_m_application b ";
				sql = sql + "  WHERE a.INT_APPLICANTID = b.INT_APPID  AND  a.CHR_CANDIDATESTATUS ='N'  AND a.CHR_FINALSTATUS='N'";
				sql = sql + "  AND a.INT_INTERVIEWID="+rowid;
				String rowdata[][]   =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				 
					
				%>  
				</span></div></td>
              </tr>
              <tr>
                <td colspan="2"><div align="right"><span class="style3"><font color="red">*</font></span><span class="changePos">Mandatory </span></div></td>
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
                          <td class="boldEleven"><span class="boldEleven">Applicant Name <span class="style3"><font color="red"></font></span></span></td>
                          <td><span class="boldEleven">
                            
							<%=rowdata[0][2]+"/"+rowdata[0][3]%>
							<input name="applicantid"  id="applicantid" type="hidden" value="<%=rowdata[0][1]%>">
							<input name="rowid"  id="rowid" type="hidden" value="<%=rowid%>">
							 
                          </span></td>
                          <td class="boldEleven">Date of Interview  <span class="style3"><font color="red"> </font></span></td>
                          <td><%=rowdata[0][4]%></td>
                        </tr>
                        <tr>
                          <td class="boldEleven">Position <span class="style3"><font color="red"> </font></span></td>
                          <td> <%= CommonFunctions.QueryExecute("SELECT CHR_DESIGNAME FROM com_m_desig WHERE INT_DESIGID="+rowdata[0][5])[0][0]%></td>
                          <td class="boldEleven">Total Experience  <span class="style3"><font color="red"> </font></span></td>
                          <td><%=rowdata[0][6]%> -yrs </td>
                        </tr>
                        <tr>
                          <td valign="top" class="boldEleven">Qualification <span class="style3"><font color="red"> </font></span></td>
                          <td valign="top"><%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_QUALIFICATIONID,CHR_QUALIFICATIONNAME FROM com_m_qualification WHERE INT_QUALIFICATIONID="+rowdata[0][7])[0][1]%> </td>
                          <td class="boldEleven">Age <span class="style3"><font color="red"> </font></span></td>
                          <td><%=rowdata[0][8]%> -yrs </td>
                        </tr>
                        <tr>
                          <td valign="top" class="boldEleven">Vehicle
                            <%
						  String s1="";
						  String s2="";
						  if("Y".equals(rowdata[0][12]))
						  	s1= " checked='checked' ";
						else
							s2=" checked='checked'";
						  %></td>
                          <td valign="top"><%
						   if("Y".equals(rowdata[0][12]))
						  	out.println("Yes");
						else
							out.println("No");
						  %></td>
                          <td class="boldEleven">Current Salary  <span class="style3"><font color="red"> </font></span></td>
                          <td> <img src="../Image/report/Rupee.gif" width="10" height="10">.<%=rowdata[0][9]%> </td>
                        </tr>
                        <tr>
                          <td valign="top" class="boldEleven">Re_Location
                            <%
						    s1="";
						    s2="";
						  if("Y".equals(rowdata[0][13]))
						  	s1= " checked='checked' ";
						else
							s2=" checked='checked'";
							%></td>
                          <td valign="top"><%
						   if("Y".equals(rowdata[0][13]))
						  	out.println("Yes");
						else
							out.println("No");
						  %></td>
                          <td class="boldEleven">Expected Salary  <span class="style3"><font color="red"> </font></span></td>
                          <td> <img src="../Image/report/Rupee.gif" width="10" height="10">.<%=rowdata[0][10]%> </td>
                        </tr>
                        <tr>
                          <td valign="top" class="boldEleven">Prefered Location <span class="style3"><font color="red"> </font></span> </td>
                          <td valign="top"><%=CommonFunctions.QueryExecute("SELECT CHR_OFFICENAME FROM com_m_office WHERE INT_OFFICEID ="+rowdata[0][16])[0][0]%></td>
                          <td class="boldEleven">Notice Period  <span class="style3"><font color="red"> </font></span></td>
                          <td><%=rowdata[0][11]%>-days </td>
                        </tr>
                         
                        <tr>
                          <td class="boldEleven">&nbsp;</td>
                          <td>&nbsp;</td>
                          <td class="boldEleven">Field Work </td>
                          <td><%=rowdata[0][14]%></td>
                        </tr>
                        <tr>
                          <td class="boldEleven">&nbsp;</td>
                          <td>&nbsp;</td>
                          <td class="boldEleven">Refered By </td>
                          <td><%=rowdata[0][15]%></td>
                        </tr>
                        
                      </table></td>
                    </tr>
                </table></td>
              </tr>
              <tr>
                <td height="19" colspan="2"><p>&nbsp;</p>                  </td>
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
<%
 
 
 String jobid=com.my.org.erp.common.CommonFunctions.QueryExecute(" SELECT INT_JOBID FROM hrm_m_application WHERE INT_APPID= "+rowdata[0][1])[0][0]; 
 String skilldata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_SKILLID ,CHR_SKILLNAME FROM  hrm_m_skilllevel WHERE   INT_SKILLID in("+rowdata[0][17]+"0)  ORDER BY INT_SKILLID ");
  
 	out.println("<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
 	out.println("<tr class='MRow1'>");
	out.println("<td class='boldEleven'><b>S.No</b></td>");
	out.println("<td class='boldEleven'><b>Skill Name</b></td>");
	out.println("<td class='boldEleven' width='100' ><b>Level 1</b></td>");
	out.println("<td class='boldEleven' width='100' ><b>Level 2</b></td>");
	out.println("<td class='boldEleven' width='100' ><b>Level 3</b></td>");
	out.println("<td class='boldEleven' width='100' ><b>Level 4</b></td>");
	out.println("<td class='boldEleven' width='100' ><b>Level 5</b></td>");
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
			s1="  <img src=\"../Image/report/tick.gif\">  ";
		out.println("<td class='boldEleven'>"+s1+"</td>");
		
		s1="";
		if("2".equals(skilldbdata[u]))
			s1="  <img src=\"../Image/report/tick.gif\"> ";
		out.println("<td class='boldEleven'>"+s1+"</td>");
		
		s1="";
		if("3".equals(skilldbdata[u]))
			s1="  <img src=\"../Image/report/tick.gif\">";
		out.println("<td class='boldEleven'>"+s1+"</td>");
		
		s1="";
		if("4".equals(skilldbdata[u]))
			s1="  <img src=\"../Image/report/tick.gif\"> ";
		out.println("<td class='boldEleven'>"+s1+"</td>");
		
		s1="";
		if("5".equals(skilldbdata[u]))
			s1="  <img src=\"../Image/report/tick.gif\"> ";
		out.println("<td class='boldEleven'>"+s1+"</td>");
		out.println("</tr>");
	} 
 }
 out.println("</table>");
  
 
 
%>						</td>
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
                  <tr>
                    <td height="101"><table width="100%" border="0" cellspacing="3" cellpadding="2">

                        <tr>
                          <td colspan="4" class="boldEleven"><div align="center" class="copyright">TECHNICAL INFORMATION </div></td>
                        </tr>
                        <tr>
                          <td colspan="4" class="boldEleven"><%
 
 String echnicalskilldata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(" SELECT INT_TECHNICALCOMPETENCYID,CHR_TECHNICALCOMPETENCYNAME  FROM  hrm_m_technicalcompetencylevel  WHERE     INT_TECHNICALCOMPETENCYID in("+rowdata[0][19]+"0) ORDER BY INT_TECHNICALCOMPETENCYID ");
 
 
 	out.println("<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
 	out.println("<tr class='MRow1'>");
	out.println("<td class='boldEleven'><b>S.No</b></td>");
	out.println("<td class='boldEleven'><b>Skill Name</b></td>");
	out.println("<td class='boldEleven' width='100' ><b>Level 1</b></td>");
	out.println("<td class='boldEleven' width='100' ><b>Level 2</b></td>");
	out.println("<td class='boldEleven' width='100' ><b>Level 3</b></td>");
	out.println("<td class='boldEleven' width='100' ><b>Level 4</b></td>");
	out.println("<td class='boldEleven' width='100' ><b>Level 5</b></td>");
	 
	
	out.println("</tr>");
 if(echnicalskilldata.length>0)
 {
	 String skilldbdata[] = rowdata[0][20].split(",");
	 for(int u=0;u<echnicalskilldata.length;u++)
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
		out.println("<td class='boldEleven'><input name='Tskill_"+echnicalskilldata[u][0]+"'  id='Tskill_"+echnicalskilldata[u][0]+"'  "+s1+"  type='radio' value='1'></td>");
		
		s1="";
		if("2".equals(skilldbdata[u]))
			s1=" checked = 'checked' ";
		out.println("<td class='boldEleven'><input name='Tskill_"+echnicalskilldata[u][0]+"'  id='Tskill_"+echnicalskilldata[u][0]+"'   "+s1+"   type='radio' value='2'></td>");
		
		s1="";
		if("3".equals(skilldbdata[u]))
			s1=" checked = 'checked' ";
		out.println("<td class='boldEleven'><input name='Tskill_"+echnicalskilldata[u][0]+"'  id='Tskill_"+echnicalskilldata[u][0]+"'   "+s1+"   type='radio' value='3'></td>");
		
		s1="";
		if("4".equals(skilldbdata[u]))
			s1=" checked = 'checked' ";
		out.println("<td class='boldEleven'><input name='Tskill_"+echnicalskilldata[u][0]+"'  id='Tskill_"+echnicalskilldata[u][0]+"'    "+s1+"  type='radio' value='4'></td>");
		
		s1="";
		if("5".equals(skilldbdata[u]))
			s1=" checked = 'checked' ";
		out.println("<td class='boldEleven'><input name='Tskill_"+echnicalskilldata[u][0]+"'  id='Tskill_"+echnicalskilldata[u][0]+"'    "+s1+"  type='radio' value='5'></td>");
		out.println("</tr>");
	} 
 }
 out.println("</table>");
 
 
 
%>                          </td>
                        </tr>
                        <tr>
                          <td class="boldEleven">&nbsp;</td>
                          <td>&nbsp;</td>
                          <td class="boldEleven">&nbsp;</td>
                          <td>&nbsp;</td>
                        </tr>
                    </table></td>
                  </tr>
                </table></td>
              </tr>
              <tr>
                <td height="19" colspan="2">&nbsp;</td>
              </tr>
              <tr>
                <td height="19" colspan="2"><table width="100%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#FFFF00">
                  <tr>
                    <td height="101"><table width="100%" border="0" cellspacing="3" cellpadding="2">
                        <tr>
                          <td colspan="4" class="boldEleven"><div align="center" class="copyright">FIRST INTERVIEW  INFORMATION </div></td>
                        </tr>
                        <tr>
                          <td colspan="4" class="boldEleven"><table width="649" border="0" align="center" cellpadding="2" cellspacing="2">
                            <tr>
                              <td width="270" class="boldEleven">First Interviewed By </td>
                              <td width="379"><%=rowdata[0][21]+" / "+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_EMPID,CHR_STAFFNAME  FROM com_m_staff WHERE CHR_EMPID='"+rowdata[0][21]+"'")[0][1]%> </td>
                            </tr>
                            <tr>
                              <td class="boldEleven">First Interviewed Date and Time </td>
                              <td><%=rowdata[0][22]%></td>
                            </tr>
                            <tr>
                              <td class="boldEleven">First Interview Comments and suggesstions </td>
                              <td><%=rowdata[0][23]%></td>
                            </tr>
                          </table>                           </td>
                        </tr>
                        <tr>
                          <td class="boldEleven">&nbsp;</td>
                          <td>&nbsp;</td>
                          <td class="boldEleven">&nbsp;</td>
                          <td>&nbsp;</td>
                        </tr>
                    </table></td>
                  </tr>
                </table></td>
              </tr>
              <tr>
                <td height="19" colspan="2">&nbsp;</td>
              </tr>
              <tr>
                <td height="19" colspan="2"><table width="100%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#FFFF00">
                  <tr>
                    <td height="101"><table width="100%" border="0" cellspacing="3" cellpadding="2">
                        <tr>
                          <td colspan="4" class="boldEleven"><div align="center" class="copyright">SECOND INTERVIEW  INFORMATION </div></td>
                        </tr>
                        <tr>
                          <td colspan="4" class="boldEleven"><table width="649" border="0" align="center" cellpadding="2" cellspacing="2">
                              <tr>
                                <td width="270" class="boldEleven">Second Interviewed By   <span class="style3"><font color="red">*</font></span></td>
                                <td width="379"><select name="InterviewedBy" id="InterviewedBy" class="formText135" size="5">
                                  <%

 
   
 	String empdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT a.CHR_EMPID,a.CHR_STAFFNAME FROM  com_m_staff a WHERE  a.CHR_TYPE !='T'  AND a.CHR_INTERVIEW='Y' ORDER BY a.CHR_STAFFNAME ");
 

  				  for(int y=0; y<empdata.length;y++)
				  	out.println("<option  value='"+empdata[y][0]+"' title='"+empdata[y][0]+"'>"+empdata[y][1]+" / " +empdata[y][0]+ "</option>");	
%>
                                </select>
								
								<script language="javascript">setOptionValue('InterviewedBy','<%=rowdata[0][25]%>')</script>								  </td>
                              </tr>
                              <tr>
                                <td class="boldEleven">Second Interview Comments and suggesstions   <span class="style3"><font color="red">*</font></span></td>
                                <td><textarea name="comments" cols="50"
										rows="5" class="formText135" id="comments" tabindex="9" onKeyUp="textArea('comments','2000')"><%=rowdata[0][26]%></textarea></td>
                              </tr>
                              <tr>
                                <td class="boldEleven">Next Level </td>
                                <td><%
					  s1="";
					if("Y".equals(rowdata[0][27]))
						s1 = " checked ='checked' "; 
					 
					%>
                                  <input name="NextLevel" type="checkbox" id="NextLevel" value="Y" <%=s1%> > </td>
                              </tr>
                              
                          </table></td>
                        </tr>
                        <tr>
                          <td class="boldEleven">&nbsp;</td>
                          <td>&nbsp;</td>
                          <td class="boldEleven">&nbsp;</td>
                          <td>&nbsp;</td>
                        </tr>
                    </table></td>
                  </tr>
                </table></td>
              </tr>
              <tr>
                <td height="19" colspan="2">&nbsp;</td>
              </tr>
              <tr>
                <td height="19">&nbsp;</td>
                <td><input name="filename" type="hidden" id="filename" value="InterviewSheet">
                    <input name="actionS" type="hidden" id="actionS" value="HRMSecondInterViewSheetEditUpdate">					<input name="jobid" type="hidden" id="jobid" value="<%=jobid%>"></td>
              </tr>
              <tr>
                <td height="19" colspan="2"><table  border="0" align="center" cellpadding="2" cellspacing="2">
                    <tr>
                      <td width="56"><input type="submit" name="Submit" id="submit_btn" class="tMLAscreenHead" value="Update"  /></td>
                      <td width="56"><input type="button" name="submit" class="tMLAscreenHead"  value="Close"   accesskey="c"  onClick="redirect('HRSecondInterview.jsp')"  /></td>
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
 
function validateFields()
{
			if(
				
				 
				 checkNull('InterviewedBy','Select InterviewedBy')
				&& checkNull('comments','Enter comments')
				 
				 
				 
				
				)
					return true;
			else
					return false;
}

 </script>
  
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