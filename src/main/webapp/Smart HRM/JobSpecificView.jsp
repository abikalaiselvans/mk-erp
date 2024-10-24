<%@ page import="java.sql.*,java.io.*,java.util.*" %>
<%@ page import="com.my.org.erp.common.CommonInfo.*" %>
<html>
<head>

<title>:: HRM ::</title>


 
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>

<style type="text/css">
<!--
a:visited {
	color: #663366;
}
a:hover {
	color: #FF0000;
}
a:active {
	color: #0000FF;
}
.style4 {COLOR: #000000; LINE-HEIGHT: 15px; FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; TEXT-DECORATION: none; font-size: 10px;}
-->
</style>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<form  AUTOCOMPLETE = "off" name="frm" method="post" action="../SmartLoginAuth">
 <%@ include file="indexhrm.jsp"%>
<%
	String action=request.getParameter("action1");
	String jobCode=request.getParameter("jobCode");
	
	
String sql = " SELECT a.CHR_JOBGRADE,a.CHR_JOBCODE,a.CHR_JOBTITLE, ";
sql = sql+" a.CHR_JOBPURPOSE,a.CHR_JOBDUTY,a.CHR_JOBAUTH,a.CHR_QUALIFICATIONID, ";
sql = sql+" a.INT_HEIGHT,a.INT_SALARY,a.INT_WEIGHT,a.INT_DA,a.CHR_GENDER,a.INT_HRA,a.CHR_MEMORY, ";
sql = sql+" a.INT_EXPERIENCE,a.CHR_CREATIVITY,a.INT_AGE,a.INT_AGE_TO, ";
sql = sql+" a.CHR_TEACHING,a.INT_WORKING,a.CHR_EMOTIONAL  , ";
sql = sql+" a.CHR_JOBPROMOTIONS,a.CHR_JOBHAZ,a.CHR_JOBREPORT,a.CHR_RESPONSE ";
sql = sql+" FROM hrm_m_jobdesign a ";
sql = sql+" WHERE a.INT_JOBID>0   AND a.INT_JOBID="+jobCode;
sql = sql+" ORDER BY a.CHR_JOBTITLE ";
String sval[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
 %>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0">
  <tr>
  </tr>
  <tr>
    <td height="25">&nbsp;</td>
  </tr>
  <tr>
    <td valign="top"><table width="886" border="0" align="center" cellpadding="2" cellspacing="2">
      <tr>
        <td width="71">&nbsp;</td>
        <td width="801"><TABLE width=782 border=0 align=center cellPadding=0 cellSpacing=0 bgcolor="#dce4f9" class=BackGround>
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
              <TD width=545 valign="top"><table width="762" border="0" align="center" cellpadding="0" cellspacing="0">
                  <tr>
                    <td width="100%" colspan="2"><div align="center"><span class="boldThirteen">Job Specification </span></div></td>
                  </tr>
                  
                  <tr>
                    <td height="52" colspan="2"><table width="267" border="0" align="center" cellpadding="2" cellspacing="0">
                      <tr>
                        <td width="71" class="boldEleven"><strong>Job Grade</strong></td>
                        <td width="188" class="boldEleven"><%=sval[0][0]+" Management" %></td>
                      </tr>
                      <tr>
                        <td width="71" class="boldEleven"><strong>Job Title</strong></td>
                        <td class="boldEleven"><%=sval[0][1]+"/"+sval[0][2] %></td>
                      </tr>
                    </table></td>
                  </tr>
                 
                  <tr>
                    <td height="19" colspan="2"> <table width="100%" border="0" align="center" cellpadding="1" cellspacing="2">
                      <tr>
                        <td height="15" colspan="4" class="tabledata"><div align="center"><strong>Other Details</strong></div></td>
                      </tr>
                      <tr>
                        <td width="145" class="bold1">Qualification</td>
                        <td width="232" class="boldEleven"><%
							   String eduData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_QUALIFICATIONNAME FROM com_m_qualification   WHERE 	INT_QUALIFICATIONID IN("+sval[0][6]+")");
			     			String ed="";
			     			for(int y=0;y<eduData.length;y++)
			     					ed = ed+eduData[y][0]+" ,"; 
							
							ed = ed.substring(0,ed.length()-1);out.println(ed);
							  %>
                        </td>
                        <td width="154" class="bold1">Height</td>
                        <td width="201"><span class="boldEleven"><%=sval[0][7]%> - Cm </span></td>
                      </tr>
                      <tr>
                        <td class="bold1">Scale</td>
                        <td class="boldEleven"><%=sval[0][8]%> </td>
                        <td class="bold1">Weight</td>
                        <td><span class="boldEleven"><%=sval[0][9]%> - Kg </span></td>
                      </tr>
                      <tr>
                        <td class="bold1">D.A</td>
                        <td class="boldEleven"><%=sval[0][10]%> </td>
                        <td class="bold1"><span class="style4">Gender</span> </td>
                        <td class="boldEleven"><span class="bolddeepblue"><%=sval[0][11]%> </span></td>
                      </tr>
                      <tr>
                        <td class="bold1">H.R.A</td>
                        <td class="boldEleven"><%=sval[0][12]%> </td>
                        <td class="bold1"><span class="style4">Memory</span> </td>
                        <td class="boldEleven"><span class="bolddeepblue">
                          <%
							  if("N".equals(sval[0][13]))
							  	out.println("Not Required");
							  else
							  	out.println("Not Required");
							  %>
                        </span></td>
                      </tr>
                      <tr>
                        <td class="bold1">Experience</td>
                        <td class="boldEleven"><%=sval[0][14]%> </td>
                        <td class="bold1"><span class="style4">Creativity</span> </td>
                        <td class="boldEleven"><span class="bolddeepblue">
                          <%
							  if("N".equals(sval[0][15]))
							  	out.println("Not Required");
							  else
							  	out.println("Not Required");
							  %>
                        </span></td>
                      </tr>
                      <tr>
                        <td class="bold1">Age</td>
                        <td class="boldEleven"><%="From :"+sval[0][16] +" To : " +sval[0][17]%> </td>
                        <td class="bold1"><span class="style4">Teaching Ability </span> </td>
                        <td class="boldEleven"><span class="bolddeepblue">
                          <%
							  if("N".equals(sval[0][18]))
							  	out.println("Not Required");
							  else
							  	out.println("Not Required");
							   %>
                        </span></td>
                      </tr>
                      <tr>
                        <td class="bold1">Working Time</td>
                        <td class="boldEleven"><%=sval[0][19]%> - Hours </td>
                        <td class="bold1"><span class="style4">Emotional Stability </span> </td>
                        <td class="boldEleven"><span class="bolddeepblue">
                          <%
							  if("N".equals(sval[0][20]))
							  	out.println("Not Required");
							  else
							  	out.println("Not Required");
							   %>
                        </span></td>
                      </tr>
                    </table></td>
                  </tr>
                  <tr>
                    <td height="34" colspan="2"><table  border="0" align="center" cellpadding="2" cellspacing="2">
                        <tr>
                          <td width="56">
						  <input type="button" name="submit" class="tMLAscreenHead"  value="Close"   accesskey="c"  onClick="redirect('JobSpecification.jsp')"/></td>
                        </tr>
                    </table></td>
                  </tr>
              </table></TD>
              <TD noWrap width=5><SPACER height="1" width="1" 
                        type="block" /></TD>
              <TD class=BorderLine width=2><SPACER height="1" width="1" type="block" /></TD>
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
    </table>
    </td>
  </tr>
  
  <tr>
    <td><%@ include file="../footer.jsp"%></td>
  </tr>
</table>
</body>
</form>
</html>