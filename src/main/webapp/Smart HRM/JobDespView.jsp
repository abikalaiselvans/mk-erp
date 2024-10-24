<%@ page import="java.sql.*,java.io.*,java.util.*" %>
<%@ page import="com.my.org.erp.common.CommonInfo.*" %>
<%
try
{
%>
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
-->
</style>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<form  AUTOCOMPLETE = "off" name="frm" method="post" >
 <%@ include file="indexhrm.jsp"%>
<%
	String action=request.getParameter("action1");
	String jobCode=request.getParameter("jobCode");
	
	
	String sql = " SELECT a.CHR_JOBGRADE,a.CHR_JOBCODE,a.CHR_JOBTITLE,a.CHR_JOBPURPOSE,a.CHR_JOBDUTY,a.CHR_JOBAUTH, ";
	sql = sql+" a.CHR_JOBPROMOTIONS,a.CHR_JOBHAZ,a.CHR_JOBREPORT,a.CHR_RESPONSE ";
	sql = sql+" FROM hrm_m_jobdesign a ";
	sql = sql+" WHERE a.INT_JOBID>0  AND  a.INT_JOBID="+jobCode ;
	sql = sql+" ORDER BY a.CHR_JOBTITLE ";
    
	String sval[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	 
%>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" >
 
  <tr>
    <td valign="top"><table width="886" border="0" align="center" cellpadding="2" cellspacing="2"  >
      <tr>
        <td width="71" height="343">&nbsp;</td>
        <td width="801"><TABLE width=759 border=0 align=center cellPadding=0 cellSpacing=0    class=BackGround>
          <TBODY>
            <TR>
              <TD colSpan=2 rowSpan=2><IMG height=7 src="../Image/General/Tablelcorner.jpg" width=7></TD>
              <TD class=BorderLine2 height=1><SPACER height="1" 
                        width="1" type="block" /></TD>
              <TD colSpan=2 rowSpan=2><IMG height=7 src="../Image/General/Tablercorner1.jpg" width=7></TD>
            </TR>
            <TR>
              <TD height=6><SPACER height="1" width="1" type="block"/></TD>
            </TR>
            <TR>
              <TD class=BorderLine2 width=1><SPACER height="1" 
                        width="1" type="block" /></TD>
              <TD width=6><SPACER height="1" width="1" type="block" 
                      /></TD>
              <TD width=741 valign="top"><table width="741" border="0" align="center" cellpadding="0" cellspacing="0">
                  <tr>
                    <td colspan="2"><div align="center"><span class="boldThirteen">Job Description </span></div></td>
                  </tr>
                  
                   
                  <tr>
                    <td height="19" colspan="2"> <table width="95%" border="0" align="center" cellpadding="1" cellspacing="2" bordercolor="#D4D0C8" class="boldEleven">
                      <tr>
                        <td colspan="4">&nbsp;</td>
                      </tr>
                      <tr>
                        <td colspan="4"><div align="center"><span class="tabledata"><strong>JOB DETAILS </strong></span></div></td>
                      </tr>
                      <tr>
                        <td width="94" valign="top"><span class="bold1"><strong>Job Code</strong></span></td>
                        <td width="243" valign="top"><%=sval[0][1]%></td>
                        <td width="97" valign="top"><span class="bold1"><strong>Job Grade</strong></span></td>
                        <td width="213" valign="top"><span class="boldThirteen"><%=sval[0][0]+ " Management " %> </span></td>
                      </tr>
                      <tr>
                        <td valign="top" class="bold1"><strong>Job Title</strong></td>
                        <td valign="top" class="boldEleven"><%=sval[0][2] %></td>
                        <td valign="top" class="bold1">Promotion</td>
                        <td valign="top" class="boldEleven"><%=sval[0][6] %></td>
                      </tr>
                      <tr>
                        <td valign="top" class="bold1"><strong>Job Purpose</strong></td>
                        <td valign="top" class="boldEleven"><%=sval[0][3] %></td>
                        <td valign="top" class="bold1">Hazards</td>
                        <td valign="top" class="boldEleven"><%=sval[0][7] %></td>
                      </tr>
                      <tr>
                        <td valign="top" class="bold1"><strong>Duties</strong></td>
                        <td valign="top" class="boldEleven"><%=sval[0][4] %></td>
                        <td valign="top" class="bold1">Reporting To</td>
                        <td valign="top" class="boldEleven"><%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_STAFFNAME FROM com_m_staff WHERE CHR_EMPID='"+sval[0][8]+"'")[0][0] %> </td>
                      </tr>
                      <tr>
                        <td valign="top" class="bold1"><strong>Authority</strong></td>
                        <td valign="top" class="boldEleven"><%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_STAFFNAME FROM com_m_staff WHERE CHR_EMPID='"+sval[0][5]+"'")[0][0] %></td>
                        <td valign="top" class="bold1"><strong>Responsibilities</strong></td>
                        <td valign="top" class="boldEleven"><%=sval[0][9].replaceAll("\n","<br>") %></td>
                      </tr>
                    </table></td>
                  </tr>
                  <tr>
                    <td width="49%" height="19">&nbsp;</td>
                    <td width="51%">&nbsp;</td>
                  </tr>
                  
                  <tr>
                    <td height="34" colspan="2"><table  border="0" align="center" cellpadding="2" cellspacing="2">
                        <tr>
                          
                          <td width="56">
						  <input type="button" name="submit" class="tMLAscreenHead"  value="Close"   accesskey="c"  onClick="redirect('JobDescription.jsp')"/></td>
                        </tr>
                    </table></td>
                  </tr>
              </table></TD>
              <TD noWrap width=10><SPACER height="1" width="1" 
                        type="block" /></TD>
              <TD class=BorderLine2 width=1><SPACER height="1" width="1" type="block" /></TD>
            </TR>
            <TR>
              <TD colSpan=2 rowSpan=2><IMG height=7 src="../Image/General/TableBlcorner.jpg" width=7></TD>
              <TD height=6><SPACER height="1" width="1" type="block"/></TD>
              <TD colSpan=2 rowSpan=2 valign="bottom"><div align="right"><IMG height=7 src="../Image/General/TableBrcorner.jpg" width=7></div></TD>
            </TR>
            <TR>
              <TD class=BorderLine2 height=1><SPACER height="1" width="1" type="block" /></TD>
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
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>