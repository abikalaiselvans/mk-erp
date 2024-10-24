<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<body  onpaste='return false;'>
<%@ include file="index.jsp"%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td valign="bottom">&nbsp;</td>
	</tr>
	<tr>
		<td valign="bottom">&nbsp;</td>
	</tr>
	<tr>
		<td valign="bottom"><a title="Excel" href=javascript:;
			onClick=" CreateExcelSheet()"><img
			src="../Image/report/Excel.png" width="15" height="14" border="0"></a></td>
	</tr>
	<tr>
		<td align="center">&nbsp;</td>
	</tr>
	<tr>
		<td align="center"><!--<div align="center"    id="divscroll" style="border-color:#993300 ;OVERFLOW: auto;width:900px;height:400px ">-->
		<div>
		<%
String month =""+request.getParameter("month");
String year = ""+request.getParameter("year");
String pmonth =""+request.getParameter("pmonth");
String pyear = ""+request.getParameter("pyear");
String days = ""+request.getParameter("d");
 
String Office = ""+request.getParameter("Office");
String dept = ""+request.getParameter("dept");

String off="";
String dep="";
String tooltip="";
String head="";
if(!"0".equals(Office))
	off=" AND b.INT_OFFICEID="+Office;
	
if(!"0".equals(dept))
	dep=" AND b.INT_DEPARTID="+dept;

String stmonth="";
String styear="";
String edmonth="";
String edyear="";
stmonth=DateUtil.getMonth(Integer.parseInt(pmonth));
styear = ""+(Integer.parseInt(pyear));
edmonth=DateUtil.getMonth(Integer.parseInt(month));
edyear = ""+(Integer.parseInt(year)); 
int totaldays = Integer.parseInt(days);
%> <%
 head="21st "+stmonth +"-" +styear+"&nbsp;&nbsp; to &nbsp;&nbsp;  20th"+edmonth +"-" +edyear;

String umonth=DateUtil.getMonth(Integer.parseInt(month));

 String hs="";
for(int x=1;x<32;x++)
	hs = hs+"a.CHR_MORNING"+x+","+"a.CHR_EVENING"+x+",";
hs = hs.trim();
hs = hs.substring(0,hs.length()-1);	

String sql="SELECT b.CHR_EMPID,b.CHR_STAFFNAME , "+hs+" FROM att_t_register a , com_m_staff b "; 
sql = sql+" WHERE a.CHR_MONTH ='"+umonth+"' AND b.CHR_TYPE!='T' AND a.INT_YEAR= "+year+" AND b.CHR_EMPID=a.CHR_EMPID "+off+"  "+dep+" ORDER BY b.CHR_STAFFNAME";
 
out.println("<center><table id='myTable' cellpadding=5 cellspacing=1 bgcolor='#0099cc' border=0 >");
out.println("<tr class='MRow4'>");
out.println("<td class='newsarticlesmall'colspan=70 class='newsarticlesmall' align='center' valign='bottom'><center><h3>"+head+"</h3></td>");
out.println("<tr class='MRow4'>");
out.println("<td class='newsarticlesmall'>");
out.println("<td class='newsarticlesmall'>");
out.println("<td class='newsarticlesmall'>"); 
int r=1;
for(int i=21; i<=totaldays;i++)  
{
	out.println("<td class='newsarticlesmall' colspan=2 >"+r+" ("+i+")");
	r= r+1;
}
for(int i=1; i<21;i++)  
{
out.println("<td class='newsarticlesmall' colspan=2 >"+r+" ("+i+")");
	r= r+1;
}

out.println("</tr>");	

out.println("<tr class='MRow4'>");
out.println("<td class='newsarticlesmall'>S.No");
out.println("<td class='newsarticlesmall'>Emp Name");
out.println("<td class='newsarticlesmall'>Emp Id"); 
for(int i=21; i<=totaldays;i++)  
	out.println("<td class='newsarticlesmall' >MOR<td class='newsarticlesmall' >EVE");

for(int i=1; i<21;i++)  
	out.println("<td class='newsarticlesmall' >MOR<td class='newsarticlesmall' >EVE");
out.println("</tr>");	



%>
		</div>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>

<%@ include file="../footer.jsp"%>
</body>
