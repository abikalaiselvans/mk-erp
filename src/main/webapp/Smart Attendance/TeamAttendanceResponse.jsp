<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.*"%>
<%@ page import="com.my.org.erp.common.*"%>
<%
try
{
%>
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
		<td align="center">
		<div align="right"></div>		</td>
	</tr>
	<tr>
		<td align="center"> 
		<div>
		<%
		
		
String month =""+request.getParameter("month");
String year = ""+request.getParameter("year");
int daysInMonth = CommonFunctions.daysInMonth(year+"-"+month+"-01");
String umonth=DateUtil.getMonth(Integer.parseInt(month));

String startingdate=request.getParameter("startingdate");
int startingday = Integer.parseInt(startingdate);
String endingdate=request.getParameter("endingdate");
int endingday = Integer.parseInt(endingdate);


if(startingday>daysInMonth)
	startingday =daysInMonth-1;

if(endingday<daysInMonth)
	daysInMonth=endingday;
 
 
   

String link="";
String link1="";
String em="";
 
String tooltip="";

 
String hs="";
for(int x=startingday;x<(daysInMonth+1);x++)//32
	hs = hs+"a.CHR_MORNING"+x+","+"a.CHR_EVENING"+x+",";

hs= hs+"a.DOU_PRESENT,a.DOU_ONDUTY,a.DOU_SUNDAY,a.DOU_HOLIDAY,a.DOU_LEAVE,a.DOU_ABSENT,a.INT_LATE,a.INT_PERMISSION,a.DOU_EXTRADAYS,a.DOU_TOTALDAYS,a.CHR_FLAG";
 

String sql="SELECT  DISTINCT  b.CHR_EMPID,b.CHR_STAFFNAME , "+hs+" FROM att_t_register a , com_m_staff b "; 
sql = sql+" WHERE b.CHR_EMPID=a.CHR_EMPID   AND a.CHR_MONTH = MONTHNAME(NOW())  AND a.INT_YEAR= YEAR(NOW()) "; 
String datad[] = CommonFunctions.getReportingEmployeeIds(""+session.getAttribute("EMPID"));
String ids=" AND a.CHR_EMPID IN ( ";
for(int u=0;u<datad.length;u++)
	ids = ids +"'"+datad[u]+"' , ";
ids = ids + " '0'  )";
sql = sql + ids;
sql = sql + "  ORDER BY b.CHR_STAFFNAME";
 
 
 
String data[][] = CommonFunctions.QueryExecute(sql);

out.println("<center><table id='myTable' cellpadding=5 cellspacing=1 bgcolor='#0099cc' border=0 >");
out.println("<tr class='MRow4'>");
out.println("<td class='newsarticlesmall'colspan=77 class='newsarticlesmall' align='center' valign='bottom'><center><h1>"+umonth+" - "+year+"</h1></td>");
out.println("<tr class='MRow4'>");
out.println("<td class='newsarticlesmall'>&nbsp;</td>");
out.println("<td class='newsarticlesmall'>&nbsp;</td>");
out.println("<td class='newsarticlesmall'>&nbsp;</td>"); 
for(int x=startingday;x<(daysInMonth+1);x++)//32
	out.println("<td colspan=2 class='newsarticlesmall' align='center'><center><b>"+x+"</center></td>"); 
 out.println("</tr>");

if(data.length>0)
{
	out.println("<tr class='MRow4'>");
	out.println("<td class='newsarticlesmall'><b>S.No</td>");
	out.println("<td class='newsarticlesmall'><b>Empid</td>");
	out.println("<td class='newsarticlesmall' ><b>Emp Name</td>"); 
	for(int x=startingday;x<(daysInMonth+1);x++)//32
		out.println("<td class='newsarticlesmall' align=center><b>MOR</td><td class='newsarticlesmall'><b>EVE</b></td>"); 
	 out.println("</tr>");
	
	for(int u=0;u<data.length;u++)
	{
		link="";
		link1="";
		if(u%2==0)
			out.println("<tr class='MRow3'>");
		else
			out.println("<tr class='MRow4'>");	
		out.println("<td class='newsarticlesmall'>"+(u+1)+"</td>");
		out.println("<td class='newsarticlesmall'>"+data[u][0]+"</td>");
		out.println("<td class='newsarticlesmall'>"+data[u][1]+"</td>");
		
		int date=1;
		int x=1;		
		for(int v=startingday;v<=((daysInMonth*2-startingday)+1);v++)//63
		{
			 
			
			em="";
			if("0".equals(data[u][(x+1)]))
				em="&nbsp;";
			else
				em =data[u][(x+1)];
				
			 
			if("0".equals(data[u][(x+1)]))
				out.println("<td class='boldEleven'  bgcolor='#00FFFF' title='"+data[u][1]+"'>&nbsp;"+link +"</td>");
			else if("LEA".equals(data[u][(x+1)]))
				out.println("<td class='boldEleven'  bgcolor='#FAF0E6' title='"+data[u][1]+"'>&nbsp;"+link1 +"</td>");
			else if( "SUN".equals(data[u][(x+1)]))
				out.println("<td class='boldEleven' bgcolor='#8FBC8F' title='"+data[u][1]+"'> "+data[u][(x+1)] +"</td>");
			else if( "HOL".equals(data[u][(x+1)]))
				out.println("<td class='boldEleven' bgcolor='#8FBC8F' title='"+data[u][1]+"'> "+data[u][(x+1)] +"</td>");
			else  if( "PER".equals(data[u][(x+1)]))
				out.println("<td class='boldEleven' bgcolor='#F08080' title='"+data[u][1]+"'> "+data[u][(x+1)] +"</td>");
			else  if( "LAT".equals(data[u][(x+1)]))
				out.println("<td class='newsarticlesmall' bgcolor='#F08080' title='"+data[u][1]+"'> "+data[u][(x+1)] +"</td>");
			else  if( "ABS".equals(data[u][(x+1)]))
				out.println("<td class='boldEleven' bgcolor='#F08080' title='"+data[u][1]+"'> "+data[u][(x+1)] +"</td>");
			else  if( "NA".equals(data[u][(x+1)]))
				out.println("<td class='boldEleven' bgcolor='#F0BB80' title='"+data[u][1]+"'> "+data[u][(x+1)] +"</td>");
			else  //if( "-".equals(data[u][(x+1)]))
				out.println("<td class='boldEleven' bgcolor='#00FFFF' title='"+data[u][1]+"'> "+data[u][(x+1)] +"</td>");
			//else
			//out.println("<td class='boldEleven' bgcolor='#FAF0E6' title='"+data[u][1]+"'> "+data[u][(x+1)] );
			x= x+1;
		}
 			
	}
	
 
}
else
{
	out.println("<tr bgcolor='#ffffff'><td colspan=66 class='newsarticlesmall'  > Data not found...</td>");
}	
out.println("</table>");

%>
		</div>
		 	</td>
	</tr>
	<tr>
	  <td>&nbsp;</td>
  </tr>
	<tr>
	  <td><table width="56" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td width="56"><input class="ButtonHead" type="Button"	name="Button"  	id="Button"  value="Close"   accesskey="c" 
					onClick="redirect('TeamAttendance.jsp')"></td>
        </tr>
      </table></td>
  </tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>

<%@ include file="../footer.jsp"%>
</body>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>