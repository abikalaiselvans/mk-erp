<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<html>
<head> 
<link href="../JavaScript/jquery/fullcalendar/fullcalendar.css" rel="stylesheet" type="text/css" />
<link href="../JavaScript/jquery/fullcalendar/fullcalendar.print.css" rel="stylesheet" type="text/css"  media='print' />

<%
try
{
String sql = "";
sql = " SELECT  a.INT_CUSTOMERID , CONCAT(c.CHR_NAME,'  /  ',a.CHR_TITLE) ,YEAR(a.DAT_START),   ";  
sql = sql + " (MONTH(a.DAT_START)-1),DAY(a.DAT_START), DATE_FORMAT(a.DAT_START,'%H'),DATE_FORMAT(a.DAT_START,'%i'),   "; 
sql = sql + " YEAR(a.DAT_END), (MONTH(a.DAT_END)-1),DAY(a.DAT_END), DATE_FORMAT(a.DAT_END,'%H'),DATE_FORMAT(a.DAT_END,'%i') , ";   
sql = sql + " a.CHR_ALLDAY     ";
sql = sql + " FROM mkt_t_schedule  a  , mkt_m_customerinfo b, mkt_m_customername c   ";
sql = sql + " WHERE a.INT_CUSTOMERID =b.INT_CUSTOMERID AND b.INT_CUSTOMERNAMEID = c.INT_CUSTOMERNAMEID  AND  a.CHR_EMPID='"+session.getAttribute("EMPID")+"' ";
 
String Data[][] =  CommonFunctions.QueryExecute(sql); 
%>


<script type='text/javascript' src="../JavaScript/jquery/jquery-1.7.1.min.js" ></script>
<script type='text/javascript' src="../JavaScript/jquery/jquery-ui-1.8.17.custom.min.js"  ></script>
<script type='text/javascript' src="../JavaScript/jquery/fullcalendar/fullcalendar.min.js" ></script>
<script type='text/javascript'>

	$(document).ready(function() {
	
		var date = new Date();
		var d = date.getDate();
		var m = date.getMonth();
		var y = date.getFullYear();
		
		var calendar = $('#calendar').fullCalendar({
			header: {
				left: 'prev,next today',
				center: 'title',
				right: 'month,agendaWeek,agendaDay'
			},
			selectable: true,
			selectHelper: false,
			
			select: function(start, end, allDay) 
			{
				 	 
					var width="800", height="800";
					var left = (screen.width/2) - width/2;
					var top = (screen.height/2) - height/2;
					var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=yes,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
					newWindow = window.open("ScheduleEntryOnline.jsp?start="+start+"&end="+end+"&allDay="+allDay,"subWind",styleStr);
		newWindow.focus( );
			},
			editable: true,
			events: [
				
				<%
				
				 if(Data.length>0)
				{
					for(int u=0;u<Data.length;u++)
					{
						out.println(" {");
						out.println(" title: '"+Data[u][1]+"' ,");
						 
						out.println(" start: new Date("+Data[u][2]+", "+Data[u][3]+", "+Data[u][4]+","+Data[u][5]+","+Data[u][6]+"),");
						 out.println(" end: new Date("+Data[u][7]+", "+Data[u][8]+", "+Data[u][9]+","+Data[u][10]+","+Data[u][11]+"),");
						if("Y".equals(Data[u][12]))
							out.println("allDay: true");
						else
							out.println("allDay: false"); 
						out.println(" },"); 
						
					}
				} 
				%>
				
				 
				{
					
				}
			]
		});
		
	});

</script>
<style type='text/css'>

	body {
		margin-top: 40px;
		text-align: center;
		font-size: 14px;
		font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
		}

	#calendar {
		width: 900px;
		margin: 0 auto;
		}

</style>
</head>
<body onselectstart="return false" onpaste="return false;" onCopy="return false"   onpaste='return false;'>
<center>
<%
out.println("<span class='boldElevn'><h3>");
out.println( CommonFunctions.QueryExecute("SELECT FIND_A_EMPLOYEE_ID_NAME('"+session.getAttribute("EMPID")+"') FROM com_m_staff   ")[0][0]);
out.println("</h3></span>");
%>
</center>
 <div id='calendar'></div>
</body>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
	System.out.println(e.getMessage());
}
%>
</html>
