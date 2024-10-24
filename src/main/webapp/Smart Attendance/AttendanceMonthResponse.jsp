 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
  <script language="javascript" src="../JavaScript/comfunction.js"></script>
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*,com.my.org.erp.common.*"%>
<%
 
String reportheader="";

String cmpy=request.getParameter("company");
String cmp="";

if(!"0".equals(cmpy))
{
	cmp= " AND B.INT_COMPANYID= "+cmpy;
	reportheader=" <b>Company ::</b> "+CommonInfo.stringGetAnySelectField("SELECT CHR_COMPANYNAME FROM COM_M_COMPANY WHERE INT_COMPANYID="+cmpy,"CHR_COMPANYNAME");
}
else
{
	reportheader=" <b>Company ::</b> All ";
}
String Office = request.getParameter("Office");
String off="";
if(!"0".equals(Office))
{
	off= " AND B.INT_OFFICEID= "+Office;
	reportheader=reportheader+" <b>Office ::</b> "+CommonInfo.stringGetAnySelectField("SELECT CHR_OFFICENAME FROM  com_m_office  WHERE INT_OFFICEID="+Office,"CHR_OFFICENAME");
}
else
{
	reportheader=reportheader+" <b>Office ::</b> All ";
}

String dept = request.getParameter("dept");
String dep="";

if(!"0".equals(dept))
{
	dep= " AND B.INT_DEPARTID= "+dept;
	reportheader=reportheader+" <b>Department ::</b> "+CommonInfo.stringGetAnySelectField("SELECT CHR_DEPARTNAME FROM COM_M_DEPART WHERE INT_DEPARTID="+dept,"CHR_DEPARTNAME");
}
else
{
	reportheader=reportheader+" <b>Department ::</b> All ";
}
	String month = request.getParameter("month");
	String year = request.getParameter("year");
	String umonth=DateUtil.getMonth(Integer.parseInt(month));
	reportheader=reportheader+" <b> Attendance Report For </b> "+umonth+"-"+year;
	String sorting = request.getParameter("sorting");
	String ss = request.getParameter("ss");
	 
	String sql="SELECT  a.CHR_EMPID ,b.CHR_STAFFNAME, ";
	String header="";
	
	header = header+"Empid,Name,";
	int nodays=DateUtil.totalDays(Integer.parseInt(month),Integer.parseInt(year));
	for(int i=0;i<nodays;i++)
	{
		header = header+(i+1)+",";
		sql=sql+"CHR_MORNING"+(i+1)+",";
		sql=sql+"CHR_EVENING"+(i+1)+",";
	}
	sql=sql.trim();
	sql = sql.substring(0,sql.length()-1);	
					
	 sql = sql+" From att_t_register a, com_m_staff b ";
	 sql = sql+" WHERE a.INT_YEAR="+year+" AND a.CHR_EMPID = b.CHR_EMPID  "+dep+"  "+off+" "+cmp;
	 sql = sql+" AND a.CHR_MONTH ='"+umonth+"' ORDER BY "+ sorting +" "+ss;
	 
	 String data[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	 String head[] = header.split(",");
	 out.println("<table align='center'><tr><td align='center'>"+reportheader+"</td></tr></table>");
	 out.println("<table  id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC'>");
	 out.println("<tr bgcolor='#FFFFFF'><td class='boldEleven'><b>S.No");
	 out.println("<td class='boldEleven'><b>Empid");
	 out.println("<td class='bold1' >Emp Name"); 
	 out.println("<td class='bold1' >Month"); 
	 out.println("<td class='bold1' >Year"); 
	 for(int y=2;y<head.length;y++)
		 out.println("<td colspan=2 class='newsarticlesmall' align='center'><center><b>"+head[y]+"</center>"); 
	 out.println();
	 
	 out.println("<tr  bgcolor='#FFFFFF'>");
	 out.println("<td>&nbsp;");
	 out.println("<td>&nbsp;");
	 out.println("<td>&nbsp;"); 
	 out.println("<td>&nbsp;");
	 out.println("<td>&nbsp;"); 
	 for(int y=2;y<head.length;y++)
			out.println("<td class='newsarticlesmall' align=center><b>MOR<td class='newsarticlesmall'><b>EVE"); 
	 nodays=(nodays*2)+2;	
	 for(int u=0; u<data.length;u++)
	 {
	 	if(u%2==0)
			out.println("<tr  class='MRow1'>");
		else
			out.println("<tr  class='MRow2'>");
		
		out.println(" <td class='boldEleven'>"+(u+1));
	 	out.println("<td class='boldEleven'>"+data[u][0]);
	 	out.println("<td class='boldEleven'>"+data[u][1]);
		out.println("<td class='boldEleven'>"+umonth );
		out.println("<td class='boldEleven'>"+ year);
	 	for(int x=2;x<nodays;x++)
		{
			if(data[u][x].equals("PRE"))
				out.println("<td class='boldEleven' title='"+data[u][1]+"'>P");
			else if(data[u][x].equals("SUN"))
				out.println("<td class='boldEleven' title='"+data[u][1]+"'><font color='red'>S</font>");
			else if(data[u][x].equals("LAT"))
				out.println("<td class='boldEleven' title='"+data[u][1]+"'><font color='red'>L");
			else if(data[u][x].equals("LEA"))
				out.println("<td class='boldEleven' title='"+data[u][1]+"'>L"); 
			else if(data[u][x].equals("ABS"))
				out.println("<td class='boldEleven' title='"+data[u][1]+"'>A");
			else if(data[u][x].equals("PER"))
				out.println("<td class='boldEleven' title='"+data[u][1]+"'><font color='red'>P");
			else if(data[u][x].equals("HOL"))
				out.println("<td class='boldEleven' title='"+data[u][1]+"'>H"); 
			else
				out.println("<td class='boldEleven' title='"+data[u][1]+"'>&nbsp;");//+data[u][x]
		}
		out.println("</tr>");	
	 }	
	 out.println("</table>");
%>


<!--<table width="184" align="center" cellpadding="15" cellspacing="0">
	<tr>
		<td width="100" height="44" class="boldEleven"><strong>Export
		</strong></td>
		<td class="boldEleven">
		<div align="center"><a title="Excel" href=javascript:;
			onClick=" CreateExcelSheet()"><img
			src="../Image/report/Excel.png" width="15" height="14" border="0"></a>
		</div>
		</td>

		<td class="boldEleven">
		<div align="center"><a title="Text" href=javascript:;
			onClick="windowSave('photolist.txt')"><img
			src="../Image/report/text.gif" width="15" height="14" border="0"></a></a></div>
		</td>
		<td class="boldEleven">
		<div align="center"><a title="Document" href=javascript:;
			onClick="windowSave('photolist.doc')"><img
			src="../Image/report/MS.GIF" width="15" height="14" border="0"></a></div>
		</td>
		<td class="boldEleven">
		<div align="center"><a title="HTML" href=javascript:;
			onClick="redirect('AttendanceMain.jsp')">close</a></div>
		</td>

	</tr>
</table>-->