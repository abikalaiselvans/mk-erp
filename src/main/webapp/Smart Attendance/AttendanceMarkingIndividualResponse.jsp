<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<html>
<head>
<%
try
{
%>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
 
<title> :: ATTENDANCE ::</title>


 
<style type="text/css">
<!--
.style3 {color: #FF0000}
-->
</style>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad=" disabletxt()">   
<%@ include file="index.jsp"%>
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td width="100"></td>
	</tr>
	<tr>
		<td>
		<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth" 	onSubmit="return valid()">
		 <table width="100%" border="0" cellspacing="0" cellpadding="0">
		   <tr>
		     <td>&nbsp;</td>
	       </tr>
		   <tr>
		     <td><%
         
	String empid = request.getParameter("ename");
	String month = request.getParameter("month");
	String year = request.getParameter("year");
	String sql="";
	String ssql="";
	int tot = DateUtil.totalDays(Integer.parseInt(month), Integer.parseInt(year));
	String monthnamae = DateUtil.getMonth(Integer.parseInt(month));
	
	
	sql = " SELECT FIND_A_EMPLOYEE_ID_NAME(CHR_EMPID),DATE_FORMAT(DT_DATE,'%d-%b-%Y'),CHR_MORNING,CHR_EVENING, ";
	sql = sql + " CHR_STATUS,CHR_DESCRIPTION,INT_ROWID,DAY(DT_DATE) 	FROM  att_m_selfmarking ";
	sql = sql + " WHERE CHR_EMPID ='"+empid+"' ";
	sql = sql + " AND CHR_MONTH='"+monthnamae+"'";
	sql = sql + " AND  INT_YEAR ="+year;
	sql = sql + " ORDER BY DT_DATE ";
	//out.println(sql);
	String data[][] =CommonFunctions.QueryExecute(sql);
	boolean buttonflag = false;
	out.println("<center><br><br><br><table width='80%'   class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC'>");
	if(data.length>0)
	{
		out.println("<tr class='MRow1'><td colspan='10' class='boldEleven' align=center><b>ATTENDACE FOR THE MONTH - "+monthnamae+"&nbsp;"+year+" </b>");
		out.println("<tr class='MRow1'>");
		out.println("<td class='boldEleven' align='center'><b>S.No</b></td>");
		out.println("<td class='boldEleven' align='center'><b>Empid</b></td>");
		out.println("<td class='boldEleven' align='center'><b>Date</b></td>");
		out.println("<td class='boldEleven' align='center'><b>Morning</b></td>");
		out.println("<td class='boldEleven' align='center'><b>Evening</b></td>");
		out.println("<td class='boldEleven' align='center'><b>Status</b></td>");
		out.println("<td class='boldEleven' align='center'><b>Description</b></td>");
		out.println("<td class='newsarticlesmall' > "); 
			out.println("<table width='169' height='22' border='0' cellpadding='0' cellspacing='0' align='center'> "); 
			out.println("<tr> "); 
			out.println("<td width='20' class='boldEleven'><label>  "); 
			out.println("<input id='Astatus' name='status' type='checkbox' value='A' onClick=\"Acceptall('Astatus')\" > "); 
			out.println(" </label></td> "); 
			out.println("<td width='69' class='boldEleven'>Accept all</td> "); 
			out.println("<td width='20' class='boldEleven'> "); 
			out.println("<input name='Rstatus' id='Rstatus' type='checkbox' value='R' onClick=\"Rjectall('Rstatus')\" ></td> "); 
			out.println("<td width='60' class='boldEleven'>Reject all</td> "); 
			out.println("</tr> "); 
			out.println("</table> "); 
		out.println("</td> "); 
		out.println("<td class='newsarticlesmall' >&nbsp;</td>"); 
	 
		out.println("</tr>");
		
		for(int u=0; u<data.length;u++)
		{
			if(u%2 == 0)
				out.println("<tr class='MRow1'>" );
			else
				out.println("<tr class='MRow2'>" );
			
			out.println("<td class='boldEleven' >"+(u+1)+".</td>");
			out.println("<td class='boldEleven' >"+data[u][0]+"</td>");
			out.println("<td class='boldEleven' >"+data[u][1]+"</td>");
			//morning
			if("SUN".equals(data[u][2].trim()))
				out.println("<td class='boldEleven' ><b>Sunday</td>");  
			else if("PRE".equals(data[u][2].trim()))
				out.println("<td class='boldEleven' >Present</td>"); 
			else if("ABS".equals(data[u][2].trim()))
				out.println("<td class='boldEleven' ><font class='boldred'> Absent</font></td>"); 
			else if("PER".equals(data[u][2].trim()))
				out.println("<td class='boldEleven' ><font class='boldred'> Permission</font></td>"); 	
			else if("LEA".equals(data[u][2].trim()))
				out.println("<td class='boldEleven' >Leave</td>"); 
			else if("OND".equals(data[u][2].trim()))
				out.println("<td class='boldEleven' >Onduty</td>"); 	
			else if("LAT".equals(data[u][2].trim()))
				out.println("<td class='boldEleven' ><font class='boldred'>Late</font></td>"); 
			else if("HOL".equals(data[u][2].trim()))
				out.println("<td class='boldEleven' ><b> Holiday</td>"); 
			else	
				out.println("<td class='boldEleven' > -</td>"); 	
				
 			
			//evening
			if("SUN".equals(data[u][3].trim()))
				out.println("<td class='boldEleven' ><b>Sunday</td>"); 
			else if("PRE".equals(data[u][3].trim()))
				out.println("<td class='boldEleven' > Present</td>"); 
			else if("PER".equals(data[u][3].trim()))
				out.println("<td class='boldEleven' > Permission</td>"); 
			else if("ABS".equals(data[u][3].trim()))
				out.println("<td class='boldEleven' ><font class='boldred'> Absent</font></td>"); 
			else if("LEA".equals(data[u][3].trim()))
				out.println("<td class='boldEleven' > Leave</td>"); 	
			else if("OND".equals(data[u][3].trim()))
				out.println("<td class='boldEleven' > Onduty</td>"); 
			else if("LAT".equals(data[u][3].trim()))
				out.println("<td class='boldEleven' > Late</td>"); 
			else if("HOL".equals(data[u][3].trim()))
				out.println("<td class='boldEleven' ><b> Holiday</td>"); 
			else	
				out.println("<td class='boldEleven' > -</td>"); 
			
			//Status
			if("Y".equals(data[u][4].trim()))
				out.println("<td class='boldEleven' align='center'><b>Accept</b></td>");
			else if("R".equals(data[u][4].trim()))
				out.println("<td class='boldEleven' align='center'><b>Reject</b></td>");
			else if("N".equals(data[u][4].trim()))
				out.println("<td class='boldEleven' align='center'><b>Pending</b></td>");
			
			
			
			//Description
			out.println("<td class='boldEleven' align='center'><b>"+data[u][5].trim()+"</b></td>"); 
			
			
			//Status
			out.println("<td class='boldEleven' >");
			if("N".equals(data[u][4]))
			{
				out.println("<input type='checkbox' id='accept"+u+"' name='accept"+u+"'  onclick=Accept('accept"+u+"')>Accept<input type='checkbox' id='reject"+u+"' name='reject"+u+"' onclick=Reject('reject"+u+"') >Reject");
				buttonflag = true;
			}
			else if("Y".equals(data[u][4]))
				out.println("<font class='boldred'>Accept</font>");
			else if("R".equals(data[u][4]))
				out.println("<font class='boldred'>Reject</font>");
				
			out.println("<input type='hidden' name='hiddenField"+u+"' id='hiddenField"+u+"' value='"+data[u][6]+"'>");
			out.println("<input type='hidden' name='entrydate"+u+"' id='entrydate"+u+"' value='"+data[u][7]+"'>");
			out.println("<input type='hidden' name='morning"+u+"' id='morning"+u+"' value='"+data[u][2]+"'>");
			out.println("<input type='hidden' name='evening"+u+"' id='evening"+u+"' value='"+data[u][3]+"'>");
			
			out.println("</td>");	
		
		
			out.println("<td class='boldEleven' >-");
			if("R".equals(data[u][4]))
				out.println(" Reject Desc :"+	data[u][5]);
			out.println("<input name='dec"+u+"' type='text' class='formText135' id='dec"+u+"' size='15' maxlength='100'>");
			out.println("</td>");
			
			
			 
			out.println("</tr>");
		}
	}
	else
	{
		out.println("<tr class='MRow1'><td colspan='7'> <br><br><center><font class='boldred'>Data not found...</font></center>");
	}
	out.println("</table></center>");
	out.println("<br><br>");
	 
 
%>
               <input type="hidden" name="actionS" value="ATTAttendanceMarkingIndividual">
               <input type="hidden" name="filename" value="AttendanceSelfMarking">
               <input name='dec' type='hidden' class='formText135' id='dec' size='15' maxlength='100' value=<%= data.length%>>
               <input name="month" type="hidden" id="month" value="<%=monthnamae%>">
               <input name="year" type="hidden" id="year" value="<%=year%>">
               <input name="empid" type="hidden" id="empid" value="<%=empid%>">
             <script language="javascript" >
	function disabletxt()
	{
	
		var len=document.getElementById("dec").value;
		for(var i=0;i<len;i++)
		{
		  var fline="dec"+i;
		  document.getElementById(fline).style.visibility="hidden";
	    }
	}
	
	function Reject(ctr)
	{
		var len=document.getElementById(ctr).value;
		var l=ctr.substring(6);
		var fline="dec"+l;
		var f ="accept"+l;
		if(document.getElementById(ctr).checked )
		{
			document.getElementById(f).style.visibility="hidden";
			document.getElementById(fline).style.visibility="visible";
		}
		else
		{
			document.getElementById(f).style.visibility="visible";
			document.getElementById(fline).style.visibility="hidden";
		}
	}

	function Accept(ctr)
	{
		var len=document.getElementById(ctr).value;
		var l=ctr.substring(6);
		var fline="dec"+l;
		var f ="reject"+l;
		if(document.getElementById(ctr).checked )
		{
			document.getElementById(f).style.visibility="hidden";
			document.getElementById(fline).style.visibility="hidden";
		}
		else
		{
			document.getElementById(f).style.visibility="visible";
			//document.getElementById(fline).style.visibility="visible";
		}
	}

	
	function Acceptall(ctr)
	{
		var len=document.getElementById("dec").value;
		if(document.getElementById(ctr).checked)
		{
			document.getElementById('Rstatus').style.visibility="hidden";
			for(var i=0;i<len;i++)
			{
		  		var fline="accept"+i;
				var f = "reject"+i;
				var f0 = "dec"+i;
				document.getElementById(fline).style.visibility="visible";
		  		document.getElementById(fline).checked=true;
				document.getElementById(f).style.visibility="hidden";
				document.getElementById(f).checked=false;
				document.getElementById(f0).style.visibility="hidden";
	    	}
		}
		else
		{
			
			document.getElementById('Rstatus').style.visibility="visible";
			for(var i=0;i<len;i++)
			{
		  		var fline="accept"+i;
				var f = "reject"+i;
				var f0 = "dec"+i;
				document.getElementById(fline).style.visibility="visible";
		  		document.getElementById(fline).checked=false;
				document.getElementById(f).style.visibility="visible";
				document.getElementById(f).checked=false;
				document.getElementById(f0).style.visibility="hidden";
	    	}
		}
	}
	
	function Rjectall(ctr)
	{
		var len=document.getElementById("dec").value;
		if(document.getElementById(ctr).checked)
		{
			document.getElementById('Astatus').style.visibility="hidden";
			for(var i=0;i<len;i++)
			{
		  		var fline="accept"+i;
				var f = "reject"+i;
				var f0 = "dec"+i;
				document.getElementById(fline).style.visibility="hidden";
		  		document.getElementById(fline).checked=false;
				document.getElementById(f).style.visibility="visible";
				document.getElementById(f).checked=true;
				document.getElementById(f0).style.visibility="visible";
	    	}
		}
		else
		{
			document.getElementById('Astatus').style.visibility="visible";
			for(var i=0;i<len;i++)
			{
		  		var fline="accept"+i;
				var f = "reject"+i;
				var f0 = "dec"+i;
				document.getElementById(fline).style.visibility="visible";
		  		document.getElementById(fline).checked=false;
				document.getElementById(f).style.visibility="visible";
				document.getElementById(f).checked=false;
				document.getElementById(f0).style.visibility="hidden";
	    	}
		}
	}
	
function valid()
{
	var len=document.getElementById("dec").value;
	var acount=0;
	var rcount=0;
	for(var i=0;i<len;i++)
	 if(document.getElementById("accept"+i).checked)	  	
	 	acount=acount+1;
	
	for(var i=0;i<len;i++)
	 if(document.getElementById("reject"+i).checked)	  	
	 	rcount=rcount+1;
	
	if((acount<=0)&&(rcount<=0))
	{
		alert("Select Accept or Reject for the employee");
		return false;
	}	
	else
	{
		return true;
	}	
}	
	
               </script></td>
	       </tr>
		   <tr>
		     <td><table width="112" border="0" align="center" cellpadding="0" cellspacing="0">
		       <tr>
		         <td width="56"><%
		  if(buttonflag)
		  		out.println("<input name='Submit' type='submit' class='ButtonHead' value='Submit'   accesskey='s' >");
			else
				out.println("<input name='Submit' type='hidden'  value='Submit' >");
			
		  %></td>
		         <td width="56"><input class="ButtonHead" type="Button"	name="Button"  	id="Button"  value="Close"   accesskey="c" 
					onClick="redirect('AttendanceMain.jsp')"></td>
	            </tr>
	         </table></td>
	       </tr>
		   <tr>
		     <td>&nbsp;</td>
	       </tr>
	      </table>
		</form>
		</td>
	</tr>
	<tr>
		<td><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
<%
}
catch(Exception e)
{
}
%>