 <%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
 <%
 try
 {
 %>
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
		<td align="center"></td>
	</tr>
	<tr>
		<td align="center"><!--<div align="center"    id="divscroll" style="border-color:#993300 ;OVERFLOW: auto;width:900px;height:400px ">-->
		<div>
		<%
String cycledt[][] = CommonFunctions.QueryExecute("SELECT INT_FROM, INT_TO  FROM  att_m_basicsettings WHERE INT_ID=1 ");
int cycle2_fromdt =Integer.parseInt(cycledt[0][0]); //20
int cycle2_todt =Integer.parseInt(cycledt[0][1]);//19
		
String month =""+request.getParameter("month");
String year = ""+request.getParameter("year");
String Office = ""+request.getParameter("office");
String dept = ""+request.getParameter("dept");
String Category=request.getParameter("category");
String umonth=DateUtil.getMonth(Integer.parseInt(month));

String fromdt = cycle2_fromdt+"-"+month+"-"+year;//20
String fromdtsql = DateUtil.FormateDateSQL(fromdt);
String todt = CommonFunctions.QueryExecute("SELECT DATE_FORMAT(DATE_SUB(DATE_ADD('"+fromdtsql+"', INTERVAL 1 MONTH), INTERVAL 1 DAY),'%d-%m-%Y')")[0][0];
String todtsql = DateUtil.FormateDateSQL(todt);
String fromdthead = CommonFunctions.QueryExecute("SELECT DATE_FORMAT('"+fromdtsql+"','%d-%b-%Y')")[0][0];
String todthead = CommonFunctions.QueryExecute("SELECT DATE_FORMAT('"+todtsql+"','%d-%b-%Y')")[0][0];
String sql="";
String hs="";
 
int fromdtend = Integer.parseInt(CommonFunctions.QueryExecute("SELECT DAY(LAST_DAY('"+fromdtsql+"'))")[0][0]);
int todtend =cycle2_todt;//19

 
 
out.println("<center><table id='myTable' cellpadding=5 cellspacing=1 bgcolor='#0099cc' border=0 >");
out.println("<tr class='MRow4'>");
out.println("<td class='newsarticlesmall'colspan=77 class='newsarticlesmall' align='center' valign='bottom' height='50'><center><h1>"+fromdthead+" &nbsp;&nbsp;&nbsp; TO &nbsp;&nbsp;&nbsp; "+todthead+"</h1></td>");
out.println("<tr class='MRow4'>");
out.println("<td class='newsarticlesmall'   rowspan='2' ><b>S.No</b>");
out.println("<td class='newsarticlesmall'   rowspan='2' ><b>EMP ID</b>");
out.println("<td class='newsarticlesmall'   rowspan='2' ><b>EMP NAME</b>"); 

  
for(int x=cycle2_fromdt;x<=fromdtend;x++) //20
	out.println("<td colspan=2 class='newsarticlesmall' align='center'><center><b>"+x+"</b></center></td>"); 
for(int x=1;x<=cycle2_todt;x++) //19
	out.println("<td colspan=2 class='newsarticlesmall' align='center'><center><b>"+x+"</b></center></td>"); 
	
out.println("<td class='newsarticlesmall' align=center rowspan='2' ><b>Present</td>"); 
out.println("<td class='newsarticlesmall' align=center rowspan='2' ><b>Onduty</td>"); 
out.println("<td class='newsarticlesmall' align=center rowspan='2' ><b>Sunday</td>"); 
out.println("<td class='newsarticlesmall' align=center rowspan='2' ><b>Holiday</td>"); 
out.println("<td class='newsarticlesmall' align=center rowspan='2' ><b>Leave</td>"); 
out.println("<td class='newsarticlesmall' align=center rowspan='2' ><b>Absent</td>"); 
out.println("<td class='newsarticlesmall' align=center rowspan='2' ><b>Late</td>"); 
out.println("<td class='newsarticlesmall' align=center rowspan='2' ><b>Permission</td>"); 
out.println("<td class='newsarticlesmall' align=center rowspan='2' ><b>Extra Days / Hours</td>"); 
out.println("<td class='newsarticlesmall' align=center rowspan='2' ><b>Totals</td>"); 
out.println("<td class='newsarticlesmall' align=center rowspan='2' ><b>  Attendance</td>"); 
out.println("<td class='newsarticlesmall' align=center rowspan='2' ><b><center>Process <br>Completed (Y) / Pending (N)</center></td>"); 
out.println("</tr>");
 


out.println("<tr class='MRow4'>");
for(int x=cycle2_fromdt;x<=fromdtend;x++) //20
	out.println("<td class='newsarticlesmall' align=center><b>MOR</b></td><td class='newsarticlesmall'><b>EVE</b></td>"); 
for(int x=1;x<=cycle2_todt;x++) //19	
	out.println("<td class='newsarticlesmall' align=center><b>MOR</b></td><td class='newsarticlesmall'><b>EVE</b></td>"); 
	
 out.println("</tr>");
 
hs="";
for(int x=cycle2_fromdt;x<=fromdtend;x++) //20
	hs = hs+"b.CHR_MORNING"+x+","+"b.CHR_EVENING"+x+",";
for(int x=1;x<=cycle2_todt;x++) //19
	hs = hs+"b.CHR_MORNING"+x+","+"b.CHR_EVENING"+x+",";
	
hs = hs+" b.DOU_PRESENT,b.DOU_ONDUTY,b.DOU_SUNDAY,b.DOU_HOLIDAY,b.DOU_LEAVE,b.DOU_ABSENT,b.INT_LATE,b.INT_PERMISSION,b.DOU_EXTRADAYS,b.DOU_TOTALDAYS,b.CHR_FLAG  ";
sql ="";
sql = " SELECT a.CHR_EMPID,a.CHR_STAFFNAME, " +hs;
sql = sql + " FROM com_m_staff a, att_t_register_cycle2  b";
sql = sql + " WHERE a.CHR_EMPID = b.CHR_EMPID AND  INT_ATTENDANCECYCLE=2";
if(!"0".equals(Office))
	sql = sql + " AND a.INT_OFFICEID ="+Office;
if(!"0".equals(dept))
	sql = sql + " AND a.INT_DEPARTID =" +dept;
if(!"0".equals(Category))
	sql = sql + " AND a.CHR_CATEGORY='"+Category +"' ";
sql = sql + " AND   b.CHR_MONTH = MONTHNAME('"+todtsql+"')  AND b.INT_YEAR = YEAR('"+todtsql+"')  ORDER BY a.CHR_STAFFNAME";

//out.println(sql);

String data[][] = CommonFunctions.QueryExecute(sql);
if(data.length>0)
{
	for(int u=0;u<data.length;u++)
	{
		if(u%2==0)
			out.println("<tr class='MRow3'>");
		else
			out.println("<tr class='MRow4'>");	
		out.println("<td class='newsarticlesmall'>"+(u+1)+"</td>");
		out.println("<td class='newsarticlesmall'>"+data[u][0]+"</td>");
		out.println("<td class='newsarticlesmall'>"+data[u][1]+"</td>");
		int noofdays = (fromdtend-cycle2_fromdt)+cycle2_todt;//20,19
		int column =  1;
		for(int x=0;x<=(noofdays*2)+1;x++) 
		{
			 
			
			if("0".equals(data[u][(x+2)]))
				out.println("<td class='newsarticlesmall' bgcolor='#00FFFF' align='center'>&nbsp;");
			else if( "SUN".equals(data[u][(x+2)]))
				out.println("<td class='newsarticlesmall' bgcolor='#8FBC8F' align='center'><b>S</b> ");
			else if( "HOL".equals(data[u][(x+2)]))
				out.println("<td class='newsarticlesmall' bgcolor='#E9967A' align='center'>H");
			else  if( "PER".equals(data[u][(x+2)]))
				out.println("<td class='newsarticlesmall' bgcolor='#FFB6C1' align='center'>P");
			else  if( "LAT".equals(data[u][(x+2)]))
				out.println("<td class='newsarticlesmall' bgcolor='#F08080' align='center'>La");
			else  if( "ABS".equals(data[u][(x+2)]))
				out.println("<td class='newsarticlesmall' bgcolor='#F08080' align='center'>A");
			else  if( "NA".equals(data[u][(x+2)]))
				out.println("<td class='newsarticlesmall' bgcolor='#F0BB80' align='center'>NA");
			else  if( "LEA".equals(data[u][(x+2)]))
				out.println("<td class='newsarticlesmall' bgcolor='#FFBBAA' align='center'>L");	
			else  if( "PRE".equals(data[u][(x+2)]))
				out.println("<td class='newsarticlesmall' bgcolor='#FFB6C1' align='center'>X");
			else
				out.println("<td class='newsarticlesmall' bgcolor='#FAF0E6' align='center'>&nbsp;"+data[u][(x+1)]);
				column=column+1;
		}
		 
	    out.println("<td class='newsarticlesmall' align='right'><b>"+data[u][(column+1)]+"</b></td>"); 
		out.println("<td class='newsarticlesmall' align='right'><b>"+data[u][(column+2)]+"</b></td>"); 
		out.println("<td class='newsarticlesmall' align='right'><b>"+data[u][(column+3)]+"</b></td>"); 
		out.println("<td class='newsarticlesmall' align='right'><b>"+data[u][(column+4)]+"</b></td>"); 
		out.println("<td class='newsarticlesmall' align='right'><b>"+data[u][(column+5)]+"</b></td>"); 
		out.println("<td class='newsarticlesmall' align='right'><b>"+data[u][(column+6)]+"</b></td>"); 
		out.println("<td class='newsarticlesmall' align='right'><b>"+data[u][(column+7)]+"</b></td>"); 
		out.println("<td class='newsarticlesmall' align='right'><b>"+data[u][(column+8)]+"</b></td>"); 
		out.println("<td class='newsarticlesmall' align='right'><b>"+data[u][(column+9)]+"</b></td>"); 
		out.println("<td class='newsarticlesmall' align='right'><b>"+data[u][(column+10)]+"</b></td>"); 
		out.println("<td class='newsarticlesmall' align='right'><b>&nbsp;</b></td>"); 
		if("Y".equals(data[u][(column+11)]))
			out.println("<td class='newsarticlesmall' align=center><b>completed</td>"); 
		else
			out.println("<td class='newsarticlesmall' align=center><b class='bolddeepred'>Pending</td>"); 
		
 
		 
		 

		out.println("</tr>");
	}		
}	
		
 

 
 
 
out.println("</table></center>");
 
//out.println(sql);

%>
		</div>		</td>
	</tr>
	<tr>
	  <td>&nbsp;</td>
  </tr>
	<tr>
	  <td>&nbsp;</td>
  </tr>
	<tr>
		<td><table width="56" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td width="56">
				<input class="ButtonHead" type="Button"	name="Button"  	id="Button"  value="Close"   accesskey="c" 
					onClick="redirect('AttendanceProcessCycle2.jsp')"></td>
          </tr>
        </table></td>
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