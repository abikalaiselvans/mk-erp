<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
 <%@ page import="com.my.org.erp.common.CommonFunctions"%>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">
function AttendanceUpdate(links)
{
			var f =links;
			newWindow = window.open(f,"subWind",",,height=250,width=360,top=0,left=0");
			newWindow.focus( );
}	
</script>

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
		<div align="right"></div>
		</td>
	</tr>
	<tr>
		<td align="center"><!--<div align="center"    id="divscroll" style="border-color:#993300 ;OVERFLOW: auto;width:900px;height:400px "> -->
		<div>
		<%
		
		
String month =""+request.getParameter("month");
String year = ""+request.getParameter("year");
int daysInMonth = com.my.org.erp.common.CommonFunctions.daysInMonth(year+"-"+month+"-01");
String Office = ""+request.getParameter("Office");
String dept = ""+request.getParameter("dept");
String Category=request.getParameter("Category");

/*String OfficeData[][] = CommonFunctions.QueryExecute(" SELECT b.INT_OFFICEID,b.CHR_OFFICENAME FROM  com_m_office  b " +
    		 			"WHERE b.INT_OFFICEID IN("+CommonFunctions.QueryExecute("SELECT a.CHR_OFFICELIST FROM m_user a " +
    		 					"WHERE a.CHR_USRNAME='"+""+session.getAttribute("USRID")+"' ")[0][0]+" )");
String officeids="";
if(OfficeData.length>0)
	for(int u=0;u<OfficeData.length;u++)
		officeids=officeids+OfficeData[u][0]+",";


String catids="";
String empcategoryData[][] =CommonFunctions.QueryExecute(" SELECT b.INT_EMPLOYEECATEGORYID,b.CHR_CATEGORYNAME " +
		" FROM  com_m_employeecategory  b WHERE b.INT_EMPLOYEECATEGORYID IN("+ CommonFunctions.QueryExecute("SELECT a.CHR_GATEGORYLIST " +
				" FROM m_user a WHERE a.CHR_USRNAME='"+session.getAttribute("USRID")+"' ")[0][0]+" )");
 if(empcategoryData.length>0)
	for(int u=0;u<empcategoryData.length;u++)
		catids=catids+empcategoryData[u][0]+",";*/

String officeids = CommonFunctions.QueryExecute("SELECT a.CHR_OFFICELIST FROM m_user a WHERE a.CHR_USRNAME='"+""+session.getAttribute("USRID")+"' ")[0][0];
String catids = CommonFunctions.QueryExecute("SELECT a.CHR_GATEGORYLIST FROM m_user a WHERE a.CHR_USRNAME='"+session.getAttribute("USRID")+"' ")[0][0] ;
				

String link="";
String link1="";
String em="";
 
String tooltip="";

String umonth=DateUtil.getMonth(Integer.parseInt(month));
 String hs="";
for(int x=1;x<(daysInMonth+1);x++)//32
	hs = hs+"a.CHR_MORNING"+x+","+"a.CHR_EVENING"+x+",";

hs= hs+"a.DOU_PRESENT,a.DOU_ONDUTY,a.DOU_SUNDAY,a.DOU_HOLIDAY,a.DOU_LEAVE,a.DOU_ABSENT,a.INT_LATE,a.INT_PERMISSION,a.DOU_EXTRADAYS,a.DOU_TOTALDAYS,a.CHR_FLAG";
//hs = hs.trim();
//hs = hs.substring(0,hs.length()-1);	

String sql="SELECT  DISTINCT  b.CHR_EMPID,b.CHR_STAFFNAME , "+hs+" FROM att_t_register a , com_m_staff b "; 
sql = sql+" WHERE  b.CHR_EMPID=a.CHR_EMPID AND a.CHR_MONTH ='"+umonth+"'  AND a.INT_YEAR= "+year+"  "; 

if(!"0".equals(Office))
	sql = sql + "  AND b.INT_OFFICEID="+Office;
else
	sql = sql + " AND b.INT_OFFICEID IN ("+officeids+"  )";
	        		
if(!"0".equals(Category))
	sql = sql + "  AND b.CHR_CATEGORY='"+Category +"' ";
else
	sql = sql + " AND b.CHR_CATEGORY IN ("+catids+"  )";

 
	
if(!"0".equals(dept))
	sql = sql+"  AND b.INT_DEPARTID="+dept;
	
sql = sql+"  ORDER BY b.CHR_STAFFNAME";
//out.println(sql);

//AND b.INT_OFFICEID=1";  a.DOU_TOTALDAYS >0  AND AND b.CHR_TYPE!='T' 
 String data[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sql);
out.println("<center><table id='myTable' cellpadding=5 cellspacing=1 bgcolor='#0099cc' border=0 >");
out.println("<tr class='MRow4'>");
out.println("<td class='newsarticlesmall'colspan=77 class='newsarticlesmall' align='center' valign='bottom'><center><h1>"+umonth+" - "+year+"</h1></td>");
out.println("<tr class='MRow4'>");
out.println("<td class='newsarticlesmall'>&nbsp;</td>");
out.println("<td class='newsarticlesmall'>&nbsp;</td>");
out.println("<td class='newsarticlesmall'>&nbsp;</td>"); 
  
for(int x=1;x<(daysInMonth+1);x++)//32
	out.println("<td colspan=2 class='newsarticlesmall' align='center'><center><b>"+x+"</center>"); 

for(int x=1;x<=10;x++)
	out.println("<td class='newsarticlesmall' align=center><b>No of.</td>"); 
out.println("<td class='newsarticlesmall' align=center><b>Reset</td>"); 
out.println("<td class='newsarticlesmall' align=center><b>Status</td>"); 

out.println("</tr>");

if(data.length>0)
{
	out.println("<tr class='MRow4'>");
	out.println("<td class='newsarticlesmall'><b>S.No</td>");
	out.println("<td class='newsarticlesmall'><b>Empid</td>");
	out.println("<td class='newsarticlesmall' ><b>Emp Name</td>"); 
	for(int x=1;x<(daysInMonth+1);x++)//32
		out.println("<td class='newsarticlesmall' align=center><b>MOR</td><td class='newsarticlesmall'><b>EVE</b></td>"); 
	out.println("<td class='newsarticlesmall' align=center><b>Present</td>"); 
	out.println("<td class='newsarticlesmall' align=center><b>Onduty</td>"); 
	out.println("<td class='newsarticlesmall' align=center><b>Sunday</td>"); 
	out.println("<td class='newsarticlesmall' align=center><b>Holiday</td>"); 
	out.println("<td class='newsarticlesmall' align=center><b>Leave</td>"); 
	out.println("<td class='newsarticlesmall' align=center><b>Absent</td>"); 
	out.println("<td class='newsarticlesmall' align=center><b>Late</td>"); 
	out.println("<td class='newsarticlesmall' align=center><b>Permission</td>"); 
	out.println("<td class='newsarticlesmall' align=center><b>Extra Days / Hours</td>"); 
	out.println("<td class='newsarticlesmall' align=center><b>Totals</td>"); 
	out.println("<td class='newsarticlesmall' align=center><b>  Attendance</td>"); 
	out.println("<td class='newsarticlesmall' align=center><b><center>Process <br>Completed (Y) / Pending (N)</center></td>"); 
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
		
for(int x=1;x<((daysInMonth*2)+1);x++)//63
{
	int mm = x%2;
	
	em="";
	if("0".equals(data[u][(x+1)]))
		em="&nbsp;";
	else
		em =data[u][(x+1)];
		
		
	if(x%2==0)
	{
		 
		link = "<a href=\"javascript:AttendanceUpdate('AttendanceRegisterUpdate.jsp?empid="+data[u][0]+"&column=CHR_EVENING"+date;
		link= link+"&name="+data[u][1]+"&month="+month+"&year="+year+"&date="+date+"&s=E')\"><font class='boldEleven' >"+em+"</font></a>";
		
		link1 = "<a href=\"javascript:AttendanceUpdate('LeaveCancel.jsp?empid="+data[u][0]+"&column=CHR_EVENING"+date;
		link1= link1+"&name="+data[u][1]+"&month="+month+"&year="+year+"&date="+date+"&s=E')\"><font class='boldEleven' >L</font></a>";
		date = date+1;
	}	
	else
	{
		link = "<a href=\"javascript:AttendanceUpdate('AttendanceRegisterUpdate.jsp?empid="+data[u][0]+"&column=CHR_MORNING"+date;
		link= link+"&name="+data[u][1]+"&month="+month+"&year="+year+"&date="+date+"&s=M')\"><font class='boldEleven' >"+em+"</font></a>";
		link1 = "<a href=\"javascript:AttendanceUpdate('LeaveCancel.jsp?empid="+data[u][0]+"&column=CHR_MORNING"+date;
		link1= link1+"&name="+data[u][1]+"&month="+month+"&year="+year+"&date="+date+"&s=M')\"><font class='boldEleven' >L</font></a>";
	}	
	
	
	
	
	
	if("0".equals(data[u][(x+1)]))
		out.println("<td class='boldEleven'  bgcolor='#00FFFF' title='"+data[u][1]+"'>&nbsp;"+link +"</td>");
	else if("LEA".equals(data[u][(x+1)]))
		out.println("<td class='boldEleven'  bgcolor='#FAF0E6' title='"+data[u][1]+"'>&nbsp;"+link1 +"</td>");
	else if( "SUN".equals(data[u][(x+1)]))
		out.println("<td class='boldEleven' bgcolor='#8FBC8F' title='"+data[u][1]+"'> <b>S</b> </td>");
	else if( "HOL".equals(data[u][(x+1)]))
		out.println("<td class='boldEleven' bgcolor='#E9967A' title='"+data[u][1]+"'> H</td>");
	else  if( "PER".equals(data[u][(x+1)]))
		out.println("<td class='boldEleven' bgcolor='#FFB6C1' title='"+data[u][1]+"'> P </td>");
	else  if( "LAT".equals(data[u][(x+1)]))
		out.println("<td class='newsarticlesmall' bgcolor='#F08080' title='"+data[u][1]+"'> La </td>");
	else  if( "ABS".equals(data[u][(x+1)]))
		out.println("<td class='boldEleven' bgcolor='#F08080' title='"+data[u][1]+"'> A </td>");
	else  if( "NA".equals(data[u][(x+1)]))
		out.println("<td class='boldEleven' bgcolor='#F0BB80' title='"+data[u][1]+"'> Na </td>");
	else  //if( "-".equals(data[u][(x+1)]))
		out.println("<td class='boldEleven' bgcolor='#FFB6C1' title='"+data[u][1]+"'> X </td>");
	//else
		//out.println("<td class='boldEleven' bgcolor='#FAF0E6' title='"+data[u][1]+"'> +"'> X </td>");
}


		out.println("<td class='newsarticlesmall' align=right title='PRESENT :: "+data[u][1]+"'><div align='right'>"+data[u][((daysInMonth*2)+2)]+"</div></td>");//64
		out.println("<td class='newsarticlesmall' align=right title='ONDUTY ::"+data[u][1]+"'><div align='right'>"+data[u][((daysInMonth*2)+3)]+"</div></td>");//65
		out.println("<td class='newsarticlesmall' align=right title='SUNDAY ::"+data[u][1]+"'><div align='right'>"+data[u][((daysInMonth*2)+4)]+"</div></td>");//66
		out.println("<td class='newsarticlesmall' align=right title='HOLIDAY ::"+data[u][1]+"'><div align='right'>"+data[u][((daysInMonth*2)+5)]+"</div></td>");//67
		out.println("<td class='newsarticlesmall' align=right title='LEAVE ::"+data[u][1]+"'><div align='right'>"+data[u][((daysInMonth*2)+6)]+"</div></td>");//68
		out.println("<td class='newsarticlesmall' align=right title='ABSENT ::"+data[u][1]+"'><div align='right'>"+data[u][((daysInMonth*2)+7)]+"</div></td>");//69
		out.println("<td class='newsarticlesmall' align=right title='LATE ::"+data[u][1]+"'><div align='right'>"+data[u][((daysInMonth*2)+8)]+"</div></td>");//70
		out.println("<td class='newsarticlesmall' align=right title='PERMISSION ::"+data[u][1]+"'><div align='right'>"+data[u][((daysInMonth*2)+9)]+"</div></td>");//71
		out.println("<td class='newsarticlesmall' align=right title='EXTRA DAYS ::"+data[u][1]+"'><div align='right'>"+data[u][((daysInMonth*2)+10)]+"</div></td>");//72
		out.println("<td class='newsarticlesmall' align=right title='TOTAL ::"+data[u][1]+"'><div align='right'>"+data[u][((daysInMonth*2)+11)]+"</div></td>");//73
		 
		
		if("F".equals(""+session.getAttribute("USRTYPE")) )
		{
			out.println("<td class='newsarticlesmall' align=center title='RESET ::"+data[u][1]+"'><div align='center'><a href=\" javascript:attendanceReset('"+data[u][0]+"','"+data[u][1]+"','"+month+"','"+year+"') \">Reset</a></div></td>");
		}
		else
		{
			out.println("<td class='newsarticlesmall' align=center title='RESET ::"+data[u][1]+"'>&nbsp;</td>");
		}
		
		if("Y".equals(data[u][((daysInMonth*2)+12)]))
			out.println("<td class='newsarticlesmall' align=center><b>completed</td>"); 
		else
			out.println("<td class='newsarticlesmall' align=center><b class='bolddeepred'>Pending</td>"); 
		
		
		
	}
	
 
}
else
{
	out.println("<tr bgcolor='#ffffff'><td colspan=66 class='newsarticlesmall'  > Data not found...</td>");
}	
out.println("</table>");

%>
		</div>
		<script language="javascript">
			function attendanceReset(empid,name,month,year)
			{
				var rs=confirm("ARE YOU SURE WANT TO RESET THE  ATTENDANCE FOR  "+empid +"/"+name);
				if (rs==true)
					location = "../SmartLoginAuth?filename=AttendanceProcess&actionS=ATTAttendanceReset&empid="+empid+"&name="+name+"&month="+month+"&year="+year  ; 
			}
		</script>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>

<%@ include file="../footer.jsp"%>
</body>
