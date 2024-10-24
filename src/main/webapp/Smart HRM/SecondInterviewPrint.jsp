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
<form  AUTOCOMPLETE = "off" name="frm" method="post"  >
  <p>&nbsp;</p>
  <table width="70%" border="0" align="center" cellpadding="0" cellspacing="0" class="TableDesign">
    <tr>
      <td>SECOND INTERVIEW </td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF"><br>
          <table width="772" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td><div align="center"><img src="../images/logo.jpg" width="159" height="49"></div></td>
            </tr>
            <tr>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td><div align="center"><span class="boldThirteen">INTERVIEW SHEET
                <%
				String rowid = request.getParameter("rowid");
				String sql="";
				sql = " SELECT a.INT_INTERVIEWID,a.INT_APPLICANTID,b.CHR_APPCODE,b.CHR_APPNAME, ";
				sql = sql + "  DATE_FORMAT(a.DAT_DOI,'%d-%m-%Y'),a.CHR_POSITION,  ";
				sql = sql + "   if(a.INT_TOTALEXP > 0,CONCAT(a.INT_TOTALEXP,' -Yrs'),IF(a.INT_TOTALEXP = -1,'Below one year','Fresher') ) , ";
				sql = sql + "  a.INT_QUALIFICATIONID,a.INT_AGE,a.DOU_CSALARY,a.DOU_ESALARY,a.INT_NOTICEPERIOD, ";
				sql = sql + "  a.CHR_VEHICLE,a.CHR_RELOCATION,a.CHR_FIELDWORK,a.CHR_REFERENCE,a.CHR_PREFEREDLOCATION, ";
				sql = sql + "  a.CHR_SKILLIDS,a.CHR_SKILLLEVELS,a.CHR_TECHNICALIDS,a.CHR_TECHNICALLEVELS, ";
				sql = sql + "  a.CHR_FIRSTINTERVIEWBY,  a.DAT_FIRSTINTERVIEWDATE , ";
				sql = sql + "  a.CHR_FIRSTCOMMENTS,a.CHR_ALLOWSECONDINTERVIEW ,";
				sql = sql + "  a.CHR_SECONDINTERVIEWBY , CHR_SECONDCOMMENTS ,CHR_CANDIDATESTATUS ,  CHR_SALARYFIXATION ,DOU_SALARYFIXATION ,CHR_FINALCOMMENTS,a.DAT_SECONDINTERVIEWDATE,a.CHR_ALLOWTHIRDINTERVIEW ";
				sql = sql + "  FROM hrm_t_interview a, hrm_m_application b ";
				sql = sql + "  WHERE a.INT_APPLICANTID = b.INT_APPID ";
				sql = sql + "  AND a.INT_INTERVIEWID="+rowid;
				//out.println(sql);
				String rowdata[][]   =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				%>
              </span></div></td>
            </tr>
            <tr>
              <td><div align="right"><span class="style3"><font color="red"> </font></span></div></td>
            </tr>
            <tr>
              <td></td>
            </tr>
            <tr>
              <td height="19"><table width="90%" border="0" align="center" cellpadding="1" cellspacing="1">
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
                    <td class="boldEleven"><strong>Applicant Name <strong><font color="red"> </font></strong></strong></td>
                    <td><span class="boldEleven"> <%=rowdata[0][2]+"/"+rowdata[0][3]%>
                          <input name="applicantid"  id="applicantid" type="hidden" value="<%=rowdata[0][1]%>">
                          <input name="rowid"  id="rowid" type="hidden" value="<%=rowid%>">
                    </span></td>
                    <td class="boldEleven"><strong>Date of Interview <font color="red"> </font></strong></td>
                    <td><%=rowdata[0][4]%></td>
                  </tr>
                  <tr>
                    <td class="boldEleven"><strong>Position <font color="red"> </font></strong></td>
                    <td>
			 		
<%=CommonFunctions.QueryExecute("SELECT CHR_DESIGNAME FROM com_m_desig WHERE INT_DESIGID= "+rowdata[0][5])[0][0]%>					</td>
                    <td class="boldEleven"><strong>Total Experience <font color="red"></font></strong></td>
                    <td><%=rowdata[0][6]%></td>
                  </tr>
                  <tr>
                    <td valign="top" class="boldEleven"><strong>Qualification <font color="red"></font></strong></td>
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
                    <td class="boldEleven"><strong>Current Salary <font color="red"> </font></strong></td>
                    <td><img src="../Image/report/Rupee.gif" width="10" height="10">.<%=rowdata[0][9]%> </td>
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
                    <td class="boldEleven"><strong>Expected Salary <font color="red"> </font></strong></td>
                    <td><img src="../Image/report/Rupee.gif" width="10" height="10">.<%=rowdata[0][10]%> </td>
                  </tr>
                  <tr>
                    <td valign="top" class="boldEleven"><strong>Prefered Location <font color="red"> </font> </strong></td>
                    <td valign="top">
				 
<%=CommonFunctions.QueryExecute("SELECT CHR_OFFICENAME FROM com_m_office WHERE INT_OFFICEID= "+rowdata[0][16])[0][0]%></td>
                    <td class="boldEleven"><strong>Notice Period <font color="red"> </font></strong></td>
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
            <tr>
              <td height="19"><p>&nbsp;</p></td>
            </tr>
            <tr>
              <td height="19"><table width="100%" border="0" cellspacing="3" cellpadding="2">
                  <tr>
                    <td class="boldEleven"><div align="center">
                        <%
 
  String skilldata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_SKILLID ,CHR_SKILLNAME FROM  hrm_m_skilllevel WHERE INT_SKILLID in("+rowdata[0][17]+"0)  ORDER BY INT_SKILLID ");
 
 
 	out.println("<table width='90%'  class='boldEleven'  id='myTable'    cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
 	out.println("<tr class='MRow1'>");
	out.println("<td class='boldEleven' colspan='7'><div align='center' class='copyright'>SKILL INFORMATION </div></td>");
	out.println("</tr>");
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
		
		out.println("<td class='boldEleven'><b>&nbsp;"+(u+1)+"</b></td>");
		out.println("<td class='boldEleven'><b>&nbsp;"+skilldata[u][1]+"</b></td>");
		s1="";
		if("1".equals(skilldbdata[u]))
			s1="  <img src=\"../Image/report/tick.gif\">  ";
		out.println("<td class='boldEleven'>&nbsp;"+s1+"</td>");
		
		s1="";
		if("2".equals(skilldbdata[u]))
			s1="  <img src=\"../Image/report/tick.gif\"> ";
		out.println("<td class='boldEleven'>&nbsp;"+s1+"</td>");
		
		s1="";
		if("3".equals(skilldbdata[u]))
			s1="  <img src=\"../Image/report/tick.gif\">";
		out.println("<td class='boldEleven'>&nbsp;"+s1+"</td>");
		
		s1="";
		if("4".equals(skilldbdata[u]))
			s1="  <img src=\"../Image/report/tick.gif\"> ";
		out.println("<td class='boldEleven'>&nbsp;"+s1+"</td>");
		
		s1="";
		if("5".equals(skilldbdata[u]))
			s1="  <img src=\"../Image/report/tick.gif\"> ";
		out.println("<td class='boldEleven'>&nbsp;"+s1+"</td>");
		out.println("</tr>");
	} 
 }
 out.println("</table>");
 
 
 
%>
                    </div></td>
                  </tr>
              </table></td>
            </tr>
            <tr>
              <td height="19">&nbsp;</td>
            </tr>
            <tr>
              <td height="19">&nbsp;</td>
            </tr>
            <tr>
              <td height="19"><table width="100%" border="0" cellspacing="3" cellpadding="2">
                  <tr>
                    <td class="boldEleven"></td>
                  </tr>
                  <tr>
                    <td class="boldEleven"><div align="center">
                        <%
 
 
// if("".equals(rowdata[0][32]))
 {
		String echnicalskilldata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(" SELECT INT_TECHNICALCOMPETENCYID,CHR_TECHNICALCOMPETENCYNAME  FROM  hrm_m_technicalcompetencylevel WHERE  INT_TECHNICALCOMPETENCYID in("+rowdata[0][19]+"0) ORDER BY INT_TECHNICALCOMPETENCYID ");
	 
		out.println("<table width='90%'  class='boldEleven'  id='myTable'    cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
		out.println("<tr class='MRow1'>");
		out.println("<td class='boldEleven' colspan='7'><div align='center' class='copyright'>TECHNICAL INFORMATION </div></td>");
		out.println("</tr>");
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
					
					out.println("<td class='boldEleven'><b>&nbsp;"+(u+1)+"</b></td>");
					out.println("<td class='boldEleven'><b>&nbsp;"+echnicalskilldata[u][1]+"</b></td>");
					
					s1="";
					if("1".equals(skilldbdata[u]))
						s1=" <img src=\"../Image/report/tick.gif\">";
					out.println("<td class='boldEleven'> &nbsp;"+s1+" </td>");
					
					s1="";
					if("2".equals(skilldbdata[u]))
						s1=" <img src=\"../Image/report/tick.gif\">";
					out.println("<td class='boldEleven'> &nbsp;"+s1+"  </td>");
					
					s1="";
					if("3".equals(skilldbdata[u]))
						s1=" <img src=\"../Image/report/tick.gif\">";
					out.println("<td class='boldEleven'>&nbsp; "+s1+"  </td>");
					
					s1="";
					if("4".equals(skilldbdata[u]))
						s1=" <img src=\"../Image/report/tick.gif\">";
					out.println("<td class='boldEleven'> &nbsp;"+s1+" </td>");
					
					s1="";
					if("5".equals(skilldbdata[u]))
						s1=" <img src=\"../Image/report/tick.gif\">";
					out.println("<td class='boldEleven'> &nbsp;"+s1+"  </td>");
					out.println("</tr>");
				} 
 		}
 out.println("</table>");
 
 }
 
%>
                    </div></td>
                  </tr>
              </table></td>
            </tr>
            <tr>
              <td height="19">&nbsp;</td>
            </tr>
            <tr>
              <td height="19"><table width='90%' align="center"    cellpadding=2 cellspacing=1 bgcolor='#9900CC'  class='boldEleven'  id='myTable' >
                  <tr class="MRow1">
                    <td colspan="2" class="boldEleven"><div align="center" class="copyright">FIRST INTERVIEW  INFORMATION </div></td>
                    <td colspan="2"><div align="center" class="copyright">SECOND INTERVIEW  INFORMATION </div></td>
                  </tr>
                  <tr class="MRow2">
                    <td width="270" class="boldEleven"><strong>First Interviewed By </strong></td>
                    <td width="379"><%=rowdata[0][21]+" / "+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_EMPID,CHR_STAFFNAME  FROM com_m_staff WHERE CHR_EMPID='"+rowdata[0][21]+"'")[0][1]%> </td>
                    <td width="379"><strong>Second Interviewed By </strong></td>
                    <td width="379"><%=rowdata[0][25]+" / "+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_EMPID,CHR_STAFFNAME  FROM com_m_staff WHERE CHR_EMPID='"+rowdata[0][25]+"'")[0][1]%></td>
                  </tr>
                  <tr class="MRow1">
                    <td class="boldEleven"><strong>First Interviewed Date and Time </strong></td>
                    <td><%=rowdata[0][22]%></td>
                    <td><strong>Second Interviewed Date and Time</strong></td>
                    <td><%=rowdata[0][31]%></td>
                  </tr>
                  <tr class="MRow2">
                    <td class="boldEleven"><strong>First Interview Comments and suggesstions </strong></td>
                    <td><%=rowdata[0][23]%></td>
                    <td><strong>Second Interview Comments and suggesstions </strong></td>
                    <td><%=rowdata[0][26]%></td>
                  </tr>
                  <tr class="MRow2">
                    <td class="boldEleven"><strong>Allow Second Level </strong></td>
                    <td>
					<%
					if("Y".equals(rowdata[0][24]))
						out.println("Allowed 2nd Level...");
					else
						out.println("Cancelled 1st Level...");
					%>
					
					</td>
                    <td><strong>Allow Third Level </strong></td>
                    <td><%
					if("Y".equals(rowdata[0][32]))
						out.println("Allowed 3rd Level...");
					else
						out.println("Cancelled 2rd Level...");
					%></td>
                  </tr>
              </table></td>
            </tr>
            <tr>
              <td height="19">&nbsp;</td>
            </tr>
            <tr>
              <td height="19"><div align="center"></div></td>
            </tr>
            <tr>
              <td height="19"><div align="center">
                <input class="tMLAscreenHead" type="button" name="Button"  value="Close"   accesskey="c"  onClick="redirect('HRMmain.jsp')">
              </div></td>
            </tr>
          </table>
          <br>
        <br></td>
    </tr>
  </table>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
   
</form>
</body>
</html>

<%
}
catch(Exception e)
{
	
}
%>