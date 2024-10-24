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
 

 


<title>:: HRM ::</title>


 
<script language="JavaScript" src="../JavaScript/calendar1.js"> </script>
 
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<style type="text/css">
<!--
.style3 {font-weight: bold}
-->
</style>
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
                <td colspan="2"><div align="center"><span class="boldThirteen">  FINAL INTERVIEW  
				
				      <%
				String rowid = request.getParameter("rowid");
				String sql="";
sql = " SELECT COUNT(*) FROM hrm_t_interview a, hrm_m_application b   WHERE a.INT_APPLICANTID = b.INT_APPID  AND a.CHR_ALLOWTHIRDINTERVIEW  ='Y'   AND a.INT_INTERVIEWID="+rowid;
				//if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
					//response.sendRedirect("HRThirdInterview.jsp");
					
				
				
				sql = " SELECT a.INT_INTERVIEWID,a.INT_APPLICANTID,b.CHR_APPCODE,b.CHR_APPNAME, ";
				sql = sql + "  DATE_FORMAT(a.DAT_DOI,'%d-%m-%Y'),a.CHR_POSITION,a.INT_TOTALEXP, ";
				sql = sql + "  a.INT_QUALIFICATIONID,a.INT_AGE,a.DOU_CSALARY,a.DOU_ESALARY,a.INT_NOTICEPERIOD, ";
				sql = sql + "  a.CHR_VEHICLE,a.CHR_RELOCATION,a.CHR_FIELDWORK,a.CHR_REFERENCE,a.CHR_PREFEREDLOCATION, ";
				sql = sql + "  a.CHR_SKILLIDS,a.CHR_SKILLLEVELS,a.CHR_TECHNICALIDS,a.CHR_TECHNICALLEVELS, ";
				sql = sql + "  a.CHR_FIRSTINTERVIEWBY,  a.DAT_FIRSTINTERVIEWDATE , ";
				sql = sql + "  a.CHR_FIRSTCOMMENTS,a.CHR_ALLOWSECONDINTERVIEW ,a.CHR_SECONDINTERVIEWBY,a.DAT_SECONDINTERVIEWDATE,a.CHR_SECONDCOMMENTS ";
				sql = sql + "  FROM hrm_t_interview a, hrm_m_application b ";
				sql = sql + "  WHERE a.INT_APPLICANTID = b.INT_APPID  ";
				sql = sql + "  AND a.INT_INTERVIEWID="+rowid;
				//out.println(sql);
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
                          <td class="boldEleven"><span class="boldEleven"><strong>Applicant Name <font color="red"> </font></strong></span></td>
                          <td><span class="boldEleven">
                            
							<%=rowdata[0][2]+"/"+rowdata[0][3]%>
							<input name="applicantid"  id="applicantid" type="hidden" value="<%=rowdata[0][1]%>">
							<input name="rowid"  id="rowid" type="hidden" value="<%=rowid%>">
							 
                          </span></td>
                          <td class="boldEleven"><strong>Date of Interview  <font color="red"> </font></strong></td>
                          <td><%=rowdata[0][4]%></td>
                        </tr>
                        <tr>
                          <td class="boldEleven"><strong>Position <font color="red"> </font></strong></td>
                          <td> <%= CommonFunctions.QueryExecute("SELECT CHR_DESIGNAME FROM com_m_desig WHERE INT_DESIGID="+rowdata[0][5])[0][0]%></td>
                          <td class="boldEleven"><strong>Total Experience  <font color="red"> </font></strong></td>
                          <td><%=rowdata[0][6]%> -yrs </td>
                        </tr>
                        <tr>
                          <td valign="top" class="boldEleven"><strong>Qualification <font color="red"> </font></strong></td>
                          <td valign="top"><%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_QUALIFICATIONID,CHR_QUALIFICATIONNAME FROM com_m_qualification WHERE INT_QUALIFICATIONID="+rowdata[0][7])[0][1]%> </td>
                          <td class="boldEleven"><strong>Age <font color="red"> </font></strong></td>
                          <td><%=rowdata[0][8]%> -yrs </td>
                        </tr>
                        <tr>
                          <td valign="top" class="boldEleven"><strong>Vehicle
                              <%
						  String s1="";
						  String s2="";
						  if("Y".equals(rowdata[0][12]))
						  	s1= " checked='checked' ";
						else
							s2=" checked='checked'";
						  %>
                          </strong></td>
                          <td valign="top"><%
						   if("Y".equals(rowdata[0][12]))
						  	out.println("Yes");
						else
							out.println("No");
						  %></td>
                          <td class="boldEleven"><strong>Current Salary  <font color="red"> </font></strong></td>
                          <td> <img src="../Image/report/Rupee.gif" width="10" height="10">.<%=rowdata[0][9]%> </td>
                        </tr>
                        <tr>
                          <td valign="top" class="boldEleven"><strong>Re_Location
                              <%
						    s1="";
						    s2="";
						  if("Y".equals(rowdata[0][13]))
						  	s1= " checked='checked' ";
						else
							s2=" checked='checked'";
							%>
                          </strong></td>
                          <td valign="top"><%
						   if("Y".equals(rowdata[0][13]))
						  	out.println("Yes");
						else
							out.println("No");
						  %></td>
                          <td class="boldEleven"><strong>Expected Salary <font color="red"></font></strong></td>
                          <td> <img src="../Image/report/Rupee.gif" width="10" height="10">.<%=rowdata[0][10]%> </td>
                        </tr>
                        <tr>
                          <td valign="top" class="boldEleven"><strong>Prefered Location <font color="red"> </font> </strong></td>
                          <td valign="top"><%=CommonFunctions.QueryExecute("SELECT CHR_OFFICENAME FROM com_m_office WHERE INT_OFFICEID ="+rowdata[0][16])[0][0]%></td>
                          <td class="boldEleven"><strong>Notice Period  <font color="red"> </font></strong></td>
                          <td><%=rowdata[0][11]%>-days </td>
                        </tr>
                         
                        <tr>
                          <td class="boldEleven">&nbsp;</td>
                          <td>&nbsp;</td>
                          <td class="boldEleven"><strong>Field Work </strong></td>
                          <td><%=rowdata[0][14]%></td>
                        </tr>
                        <tr>
                          <td class="boldEleven">&nbsp;</td>
                          <td>&nbsp;</td>
                          <td class="boldEleven"><strong>Refered By </strong></td>
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
 
 String skilldata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_SKILLID ,CHR_SKILLNAME FROM  hrm_m_skilllevel WHERE INT_SKILLID in("+rowdata[0][17]+"0)  ORDER BY INT_SKILLID ");
 
 
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
                <td height="19" colspan="2"><table width="100%" border="1" cellpadding="2" cellspacing="2"  bordercolor="#FFFF00" >
                  <tr>
                    <td><table width="100%" border="0" cellspacing="3" cellpadding="2">
                      <tr>
                        <td colspan="4" class="boldEleven"><div align="center" class="copyright">FIRST INTERVIEW  INFORMATION </div></td>
                      </tr>
                      <tr>
                        <td colspan="4" class="boldEleven"><table width="649" border="0" align="center" cellpadding="2" cellspacing="2">
                            <tr>
                              <td width="270" class="boldEleven"><strong>First Interviewed By </strong></td>
                              <td width="379"><%=rowdata[0][21]+" / "+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_EMPID,CHR_STAFFNAME  FROM com_m_staff WHERE CHR_EMPID='"+rowdata[0][21]+"'")[0][1]%> </td>
                            </tr>
                            <tr>
                              <td class="boldEleven"><strong>First Interviewed Date and Time </strong></td>
                              <td><%=rowdata[0][22]%></td>
                            </tr>
                            <tr>
                              <td class="boldEleven"><strong>First Interview Comments and suggesstions </strong></td>
                              <td><%=rowdata[0][23]%></td>
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
                <td height="19" colspan="2"><table width="100%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#FFFF00">
                  <tr>
                    <td height="101"><table width="100%" border="0" cellspacing="3" cellpadding="2">

                        <tr>
                          <td colspan="4" class="boldEleven"><div align="center" class="copyright">TECHNICAL INFORMATION </div></td>
                        </tr>
                        <tr>
                          <td colspan="4" class="boldEleven">
						  <%
 
 
 
String echnicalskilldata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(" SELECT INT_TECHNICALCOMPETENCYID,CHR_TECHNICALCOMPETENCYNAME  FROM  hrm_m_technicalcompetencylevel WHERE  INT_TECHNICALCOMPETENCYID in("+rowdata[0][19]+"0) ORDER BY INT_TECHNICALCOMPETENCYID ");
 
 
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
		out.println("<td class='boldEleven'><b>"+echnicalskilldata[u][1]+"</b></td>");
		
		s1="";
		if("1".equals(skilldbdata[u]))
			s1=" <img src=\"../Image/report/tick.gif\">";
		out.println("<td class='boldEleven'> "+s1+" </td>");
		
		s1="";
		if("2".equals(skilldbdata[u]))
			s1=" <img src=\"../Image/report/tick.gif\">";
		out.println("<td class='boldEleven'> "+s1+"  </td>");
		
		s1="";
		if("3".equals(skilldbdata[u]))
			s1=" <img src=\"../Image/report/tick.gif\">";
		out.println("<td class='boldEleven'> "+s1+"  </td>");
		
		s1="";
		if("4".equals(skilldbdata[u]))
			s1=" <img src=\"../Image/report/tick.gif\">";
		out.println("<td class='boldEleven'> "+s1+" </td>");
		
		s1="";
		if("5".equals(skilldbdata[u]))
			s1=" <img src=\"../Image/report/tick.gif\">";
		out.println("<td class='boldEleven'> "+s1+"  </td>");
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
                                <td width="270" class="boldEleven"><strong>Second Interviewed By </strong></td>
                                <td width="379"> 
								
								<%=rowdata[0][25]+" / "+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_EMPID,CHR_STAFFNAME  FROM com_m_staff WHERE CHR_EMPID='"+rowdata[0][25]+"'")[0][1]%>								  </td>
                              </tr>
                              <tr>
                                <td class="boldEleven"><strong>Second Interviewed Date and Time </strong></td>
                                <td><%=rowdata[0][26]%></td>
                              </tr>
                              <tr>
                                <td class="boldEleven"><strong>Second Interview Comments and suggesstions </strong></td>
                                <td><%=rowdata[0][27]%></td>
                              </tr>
                              
                              <tr>                              </tr>
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
                <td height="19" colspan="2"><table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="#FFFF00">
                  <tr>
                    <td><table width="584" border="0" align="center" cellpadding="2" cellspacing="2">
                      <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr>
                        
<td class="boldEleven">Candidate Status <font color="red">*</font></td>
                                <td> <select name="Status" id="Status"   >
                          <option value="0">Select Status</option>
                          <option value="S">SHORTLIST</option>
                          <option value="H">HOLD</option>
						  <option value="R">REJECTED</option>
						   
						   
                        </select></td>
                              </tr>
                              <tr>
                                <td class="boldEleven">Final Salary <font color="red">*</font></td>
                                <td><input name="fsalary" type="text" class="formText135" id="fsalary"  onKeyPress="return numeric_only(event,'fsalary','12')" value="<%= rowdata[0][10] %>" size="30" maxlength="12" ></td>
                              </tr>
                              <tr>
                                <td class="boldEleven">Salary Fixation </td>
                                <td>
								
								<table width="20" border="0" cellspacing="0" cellpadding="0">
                                  <tr>
                                    <td width="20" class="boldEleven"><input name="salary" type="radio" value="G" checked></td>
                                    <td width="32" class="boldEleven">Gross</td>
                                  <!-- <td width="30" class="boldEleven"><input name="salary" type="radio" value="T"></td>
                                    <td width="165" class="boldEleven">Take Home </td> -->
                                  </tr>
                                </table>
								
								</td>
                              </tr>
                              <tr>
                                <td class="boldEleven">Final Comments and suggesstions<font color="red">*</font></td>
                                <td><textarea name="fcomments" cols="50"
										rows="5" class="formText135" id="fcomments" tabindex="9" onKeyUp="textArea('fcomments','2000')"></textarea></td>
					 						
                      </tr>
                      <tr>
                        <td>&nbsp;</td>
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
                <td><input name="filename" type="hidden" id="filename" value="FinalInterview">
                    <input name="actionS" type="hidden" id="actionS" value="HRMFinalInterviewUpdate">					</td>
              </tr>
              <tr>
                <td height="19" colspan="2"><table  border="0" align="center" cellpadding="2" cellspacing="2">
                    <tr>
                      <td width="56"><input type="submit" name="Submit" id="submit_btn" class="tMLAscreenHead" value="Update"  /></td>
                      <td width="56"><input type="button" name="submit" class="tMLAscreenHead"  value="Close"   accesskey="c"  onClick="redirect('HRThirdInterview.jsp')"  /></td>
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
				
				 checkNullSelect('Status','Select Status','0')
				 && checkNull('fsalary','Enter final salary')
				 && checkNull('fcomments','Enter final comments')
				)
					return true;
			else
					return false;
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