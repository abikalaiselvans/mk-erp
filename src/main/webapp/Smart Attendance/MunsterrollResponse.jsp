<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.*"%>
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
String Office = ""+request.getParameter("Office");
String dept = ""+request.getParameter("dept");
String Category=request.getParameter("Category");
String umonth=DateUtil.getMonth(Integer.parseInt(month));


String OfficeData[][] = CommonFunctions.QueryExecute(" SELECT b.INT_OFFICEID,b.CHR_OFFICENAME FROM  com_m_office  b " +
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
		catids=catids+empcategoryData[u][0]+",";
 
 

int daysInMonth = com.my.org.erp.common.CommonFunctions.daysInMonth(year+"-"+month+"-01");
String off="";
String dep="";
String cat="";
String tooltip="";

String hs="";
for(int x=1;x<(daysInMonth+1);x++)//32
	hs = hs+"a.CHR_MORNING"+x+","+"a.CHR_EVENING"+x+",";
hs = hs.trim();
hs = hs.substring(0,hs.length()-1);	

String sql="SELECT DISTINCT b.CHR_EMPID,b.CHR_STAFFNAME , "+hs+" FROM att_t_register a , com_m_staff b "; 
sql = sql+" WHERE b.CHR_EMPID=a.CHR_EMPID AND  a.CHR_MONTH ='"+umonth+"'  AND a.INT_YEAR= "+year;

if(!"0".equals(Office))
	sql = sql + "  AND b.INT_OFFICEID="+Office;
else
	sql = sql + " AND b.INT_OFFICEID IN ("+officeids+"0 )";
	        		
if(!"0".equals(Category))
	sql = sql + "  AND b.CHR_CATEGORY='"+Category +"' ";
else
	sql = sql + " AND b.CHR_CATEGORY IN ("+catids+"0 )";

if(!"0".equals(dept))
	sql = sql + " AND b.INT_DEPARTID="+dept;
sql = sql+" ORDER BY b.CHR_STAFFNAME "; 
System.out.println(sql);
//b.CHR_STAFFNAME  AND b.CHR_TYPE!='T' 
//AND b.INT_OFFICEID=1";
//out.println(sql);
String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
 

//com.my.org.erp.common.CommonFunctions.AttAssignNewJoiner(umonth, year, Office, dept);
//com.my.org.erp.common.CommonFunctions.AttAssignResignner(umonth, year, Office, dept);


//com.my.org.erp.common.CommonFunctions.AttAssignZero();
//out.println( "<div id=\"PermissionLeaveTable\" style=\"OVERFLOW: auto;width:900px;height:400px\">");
out.println("<center><table id='myTable' cellpadding=5 cellspacing=1 bgcolor='#0099cc' border=0 >");
out.println("<tr class='MRow4'>");
out.println("<td class='newsarticlesmall'colspan=66 class='newsarticlesmall' align='center' valign='bottom' height='50'><center><h1>"+umonth+" - "+year+"</h1></td>");
out.println("<tr class='MRow4'>");
out.println("<td class='newsarticlesmall'>");
out.println("<td class='newsarticlesmall'>");
out.println("<td class='newsarticlesmall'>"); 
  
for(int x=1;x<(daysInMonth+1);x++)//32
{
	out.println("<td colspan=2 class='newsarticlesmall' align='center'><center><b>"+x+"</center>"); 
}
out.println("<td class='newsarticlesmall' align=center><b>&nbsp;</b></td> "); 
out.println("</tr>");

if(data.length>0)
{
	out.println("<tr class='MRow4'>");
	out.println("<td class='newsarticlesmall'><b>S.No");
	out.println("<td class='newsarticlesmall'><b>EMP ID");
	out.println("<td class='newsarticlesmall' >EMP NAME"); 
	for(int x=1;x<(daysInMonth+1);x++)//32
		out.println("<td class='newsarticlesmall' align=center><b>MOR</b></td><td class='newsarticlesmall'><b>EVE</b></td>"); 
		
	out.println("<td class='newsarticlesmall' align=center><b>RESET </b></td> "); 

	out.println("</tr>");
	double sum1=0;
	double sum2=0;
	double sum3=0;
	double sum4=0;
	double sum5=0;
	double sum6=0;
	double sum7=0;
	double sum8=0;
	double sum9=0;
	double sum10=0;
	double sum11=0;
	double sum12=0;
	double sum13=0;
	double sum14=0;
	double sum15=0;
	double sum16=0;
	double sum17=0;
	double sum18=0;
	double sum19=0;
	double sum20=0;
	double sum21=0;
	double sum22=0;
	double sum23=0;
	double sum24=0;
	double sum25=0;
	double sum26=0;
	double sum27=0;
	double sum28=0;
	double sum29=0;
	double sum30=0;
	double sum31=0;
	for(int u=0;u<data.length;u++)
	{
		if(u%2==0)
			out.println("<tr class='MRow3'>");
		else
			out.println("<tr class='MRow4'>");	
		out.println("<td class='newsarticlesmall'>"+(u+1));
		out.println("<td class='newsarticlesmall'>"+data[u][0]);
		out.println("<td class='newsarticlesmall'>"+data[u][1]);
		int date=1;
		String  s="";
		int day=1;
		for(int x=1;x<((daysInMonth*2)+1);x++)//63
		{
			int mm = x%2;
			
			//s ="onmouseover='javascript:MessageAlert(\" <table><tr class=MRow4><td class=newsarticlesmall>EMPID :: <td class=newsarticlesmall>"+data[u][0]+" <tr><td class=newsarticlesmall>NAME :: <td class=newsarticlesmall>"+data[u][1]+"<tr><td class=newsarticlesmall>Date :: <td class=newsarticlesmall>"+day+"-"+month+"-"+year+"</table>\")'";	
			s="";
			if(x%2==0)
				day= day+1;
			if("0".equals(data[u][(x+1)]))
				out.println("<td class='newsarticlesmall'  "+s+" bgcolor='#00FFFF' align='center'>&nbsp;");
			else if( "SUN".equals(data[u][(x+1)]))
				out.println("<td class='newsarticlesmall'  "+s+"  bgcolor='#8FBC8F' align='center'><b>S</b> ");
			else if( "HOL".equals(data[u][(x+1)]))
				out.println("<td class='newsarticlesmall'  "+s+" bgcolor='#E9967A' align='center'>H");
			else  if( "PER".equals(data[u][(x+1)]))
				out.println("<td class='newsarticlesmall'  "+s+" bgcolor='#FFB6C1' align='center'>P");
			else  if( "LAT".equals(data[u][(x+1)]))
				out.println("<td class='newsarticlesmall'  "+s+" bgcolor='#F08080' align='center'>La");
			else  if( "ABS".equals(data[u][(x+1)]))
				out.println("<td class='newsarticlesmall'  "+s+" bgcolor='#F08080' align='center'>A");
			else  if( "NA".equals(data[u][(x+1)]))
				out.println("<td class='newsarticlesmall'  "+s+" bgcolor='#F0BB80' align='center'>NA");
			else  if( "LEA".equals(data[u][(x+1)]))
				out.println("<td class='newsarticlesmall'  "+s+" bgcolor='#FFBBAA' align='center'>L");	
			else  if( "PRE".equals(data[u][(x+1)]))
				out.println("<td class='newsarticlesmall'  "+s+" bgcolor='#FFB6C1' align='center'>X");
			else  if( "-".equals(data[u][(x+1)]))
				out.println("<td class='newsarticlesmall'  "+s+" bgcolor='#00FFFF' align='center'>&nbsp;"+data[u][(x+1)]);	
			else
				out.println("<td class='newsarticlesmall'  "+s+" bgcolor='#FAF0E6' align='center'>&nbsp;"+data[u][(x+1)]);
			
			
			
		
		}
		
		//out.println("<td class='newsarticlesmall' align=center title='RESET ::"+data[u][1]+"'><div align='center'><a href='../SmartLoginAuth?filename=AttendanceProcess&actionS=ATTAttendanceReset&empid="+data[u][0]+"&month="+month+"&year="+year+"'>Reset</a></div>");//73
		
		if("F".equals(""+session.getAttribute("USRTYPE"))   )
		{
			out.println("<td class='newsarticlesmall' align=center title='RESET ::"+data[u][1]+"'><div align='center'><a  href=\" javascript:attendanceReset('"+data[u][0]+"','"+data[u][1]+"','"+month+"','"+year+"') \">Reset</a></div>");
		}
		else
		{
			out.println("<td class='newsarticlesmall' align=center title='RESET ::"+data[u][1]+"'>&nbsp;");
		}
		
		
	}
	
	  	
	out.println("<tr class='MRow4'>");	
	out.println("<td class='newsarticlesmall' colspan='3'> ");
	for(int x=1;x<((daysInMonth)+1);x++)//63
		out.println("<td class='newsarticlesmall' colspan=2>&nbsp;");	
		
	out.println("<td class='newsarticlesmall' align=center><b>&nbsp; </b></td> "); 
}
else
{
	out.println("<tr bgcolor='#ffffff'><td colspan=66 class='newsarticlesmall'  > Data not found...</td>");
}	
out.println("</table></center>");
//out.println("</div>");

%>
<script language="javascript">
			function attendanceReset(empid,name,month,year)
			{
				
				query = "../SmartLoginAuth?filename=AttendanceCalculate&actionS=ATTAttendanceReset&empid="+empid+"&name="+name+"&month="+month+"&year="+year
				var width="800", height="400";
				var left = (screen.width/2) - width/2;
				var top = (screen.height/2) - height/2;
				var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=yes,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
				var rs=confirm("ARE YOU SURE WANT TO RESET THE  ATTENDANCE FOR  "+empid +"/"+name);
				if (rs==true)
				{
					newWindow = window.open(query,"subWind",styleStr);
					
				}
		
				
					 
			}
		</script>
		</div>		</td>
	</tr>
	<tr>
	  <td>&nbsp;</td>
  </tr>
	<tr>
	  <td><table width="56" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td width="56"><input class="ButtonHead" type="Button"	name="Button"  	id="Button"  value="Close"   accesskey="c" 
					onClick="redirect('MusterRoll.jsp')"></td>
        </tr>
      </table></td>
  </tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>

<%@ include file="../footer.jsp"%>
</body>
