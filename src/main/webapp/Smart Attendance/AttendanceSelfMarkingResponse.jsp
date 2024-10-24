<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.*"%>
<%@ page import="com.my.org.erp.common.*"%>
<%
try
{
%>
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
 
<body  onpaste='return false;'  onLoad="disabletxt()"  >
<%@ include file="index.jsp"%>

<form method="post" name="frm" action="../SmartLoginAuth" 	onSubmit="return valid()"> 
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
int daysInMonth = com.my.org.erp.common.CommonFunctions.daysInMonth(year+"-"+month+"-01");
String Office = ""+request.getParameter("Office");
String dept = ""+request.getParameter("dept");
String Category=request.getParameter("Category");
String startingdate=request.getParameter("startingdate");
int startingday = Integer.parseInt(startingdate);
String endingdate=request.getParameter("endingdate");
int endingday = Integer.parseInt(endingdate);


if(startingday>daysInMonth)
	startingday =daysInMonth-1;

if(endingday<daysInMonth)
	daysInMonth=endingday;
 
 
	
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
 

String link="";
String link1="";
String em="";
 
String tooltip="";

String umonth=DateUtil.getMonth(Integer.parseInt(month));
String hs="";
for(int x=startingday;x<(daysInMonth+1);x++)//32
	hs = hs+"a.CHR_MORNING"+x+","+"a.CHR_EVENING"+x+",";

 
 hs = hs.trim();
 hs = hs.substring(0,hs.length()-1);	

String sql="SELECT  DISTINCT  a.INT_RNO, a.CHR_STATUS,a.CHR_DESCRIPTION,b.CHR_EMPID,b.CHR_STAFFNAME , "+hs+" FROM att_t_registerselfmarking a , com_m_staff b "; 
sql = sql+" WHERE b.CHR_EMPID=a.CHR_EMPID   AND a.CHR_MONTH ='"+umonth+"'  AND a.INT_YEAR= "+year+"  "; 
if(!"0".equals(Office))
	sql = sql + "  AND b.INT_OFFICEID="+Office;
else
	sql = sql + " AND b.INT_OFFICEID IN ("+officeids+"0 )";
	        		
if(!"0".equals(Category))
	sql = sql + "  AND b.CHR_CATEGORY='"+Category +"' ";
else
	sql = sql + " AND b.CHR_CATEGORY IN ("+catids+"0 )";

if(!"0".equals(dept))
	sql = sql+"  AND b.INT_DEPARTID="+dept;
sql = sql+"  ORDER BY b.CHR_STAFFNAME";
//out.println(sql);
String data[][] = CommonFunctions.QueryExecute(sql);

out.println("<center><table id='myTable' cellpadding=5 cellspacing=1 bgcolor='#0099cc' border=0 >");
out.println("<tr class='MRow4'>");
out.println("<td class='newsarticlesmall'colspan=77 class='newsarticlesmall' align='center' valign='bottom'><center><h1>"+umonth+" - "+year+"</h1></td>");
out.println("<tr class='MRow4'>");
out.println("<td class='newsarticlesmall'>&nbsp;</td>");
out.println("<td class='newsarticlesmall'>&nbsp;</td>");
out.println("<td class='newsarticlesmall'>&nbsp;</td>"); 
for(int x=startingday;x<(daysInMonth+1);x++)//32
	out.println("<td colspan=2 class='newsarticlesmall' align='center'><center><b>"+x+"</center>"); 
out.println("<td class='newsarticlesmall'>&nbsp;</td>"); 
out.println("<td class='newsarticlesmall'>&nbsp;</td>"); 
out.println("<td class='newsarticlesmall'>&nbsp;</td>"); 
out.println("</tr>");
boolean buttonflag = false;
if(data.length>0)
{
	out.println("<tr class='MRow4'>");
	out.println("<td class='newsarticlesmall'><b>S.No</td>");
	out.println("<td class='newsarticlesmall'><b>Empid</td>");
	out.println("<td class='newsarticlesmall' ><b>Emp Name</td>"); 
	for(int x=startingday;x<(daysInMonth+1);x++)//32
		out.println("<td class='newsarticlesmall' align=center><b>MOR</td><td class='newsarticlesmall'><b>EVE</b></td>"); 
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
	out.println("<td class='newsarticlesmall'>&nbsp;</td>"); 
	out.println("<td class='newsarticlesmall'>&nbsp;</td>");  
	out.println("</tr>");
	
	for(int u=0;u<data.length;u++)
	{
		link="";
		link1="";
		if(u%2==0)
			out.println("<tr class='MRow3'>");
		else
			out.println("<tr class='MRow4'>");	
		out.println("<td class='newsarticlesmall'>"+(u+1)+".</td>");
		out.println("<td class='newsarticlesmall'>"+data[u][3]+"</td>");
		out.println("<td class='newsarticlesmall'>"+data[u][4]+"</td>");
		
		int date=1;
		int x=4;		
		for(int v=startingday;v<=((daysInMonth*2-startingday)+1);v++)//63
		{
			 
			
			em="";
			if("0".equals(data[u][(x+1)]))
				em="&nbsp;";
			else
				em =data[u][(x+1)];
				
				
			if(x%2==0)
			{
				link = " ";
				link1 = " ";
				date = date+1;
			}	
			else
			{
				link = " ";
				link1 = " ";
			}	
	
 			
			if("0".equals(data[u][(x+1)]))
				out.println("<td class='boldEleven'  bgcolor='#00FFFF' title='"+data[u][1]+"'> </td>");
			else if("LEA".equals(data[u][(x+1)]))
				out.println("<td class='boldEleven'  bgcolor='#FAF0E6' title='"+data[u][1]+"'> </td>");
			else if( "SUN".equals(data[u][(x+1)]))
				out.println("<td class='boldEleven' bgcolor='#8FBC8F' title='"+data[u][1]+"'> "+data[u][(x+1)] +"</td>");
			else if( "HOL".equals(data[u][(x+1)]))
				out.println("<td class='boldEleven' bgcolor='#F08080' title='"+data[u][1]+"'> "+data[u][(x+1)] +"</td>");
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
			 x= x+1;
		}
 		 
		
		out.println("<td class='boldEleven' >");
		if("N".equals(data[u][1]))
		{
			out.println("<input type='checkbox' id='accept"+u+"' name='accept"+u+"'  onclick=Accept('accept"+u+"')>Accept<input type='checkbox' id='reject"+u+"' name='reject"+u+"' onclick=Reject('reject"+u+"') >Reject");
			buttonflag = true;
		}
		else if("Y".equals(data[u][1]))
			out.println("<font class='boldred'>Accept</font>");
		else if("R".equals(data[u][1]))
			out.println("<font class='boldred'>Reject</font>");
			
		out.println("<input type='hidden' name='hiddenField"+u+"' id='hiddenField"+u+"' value='"+data[u][0]+"'>");
		out.println("<input type='hidden' name='empid"+u+"' id='empid"+u+"' value='"+data[u][3]+"'>");
		out.println("</td>");		
		
		out.println("<td class='boldEleven' >");
		if("R".equals(data[u][1]))
			out.println(" Reject Desc :"+	data[u][2]);
		out.println("<input name='dec"+u+"' type='text' class='formText135' id='dec"+u+"' size='15' maxlength='100'>");
		out.println("</td>");
		
		out.println("<td class='newsarticlesmall'> "); 
		if(!"N".equals(data[u][1]))	
			out.println("&nbsp; <a href='../SmartLoginAuth?filename=AttendanceSelfMarking&actionS=ATTAttendanceSelfMarkingReset&rowid="+data[u][0]+"'><font class='boldeleven'>Reset</font></a>");	
		out.println("</td>"); 
		 
	}
	
 
}
else
{
	out.println("<tr bgcolor='#ffffff'><td colspan=68 class='newsarticlesmall'  > Data not found...</td>");
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
	  <td>
<input type="hidden" name="actionS" value="ATTAttendanceSelfMarkingMove">
<input type="hidden" name="filename" value="AttendanceSelfMarking">
<input name='dec' type='hidden' class='formText135' id='dec' size='15' maxlength='100' value=<%= data.length%>>
<input name="month" type="hidden" id="month" value="<%=umonth%>">
<input name="year" type="hidden" id="year" value="<%=year%>">
                            </td>
  </tr>
	<tr>
	  <td><table width="112" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td width="56">
          <%
		  if(buttonflag)
		  		out.println("<input name='Submit' type='submit' class='ButtonHead' value='Submit'   accesskey='s' >");
			else
				out.println("<input name='Submit' type='hidden'  value='Submit' >");
			
		  %>
          </td>
          <td width="56"><input class="ButtonHead" type="Button"	name="Button"  	id="Button"  value="Close"   accesskey="c" 
					onClick="redirect('AttendanceProcess.jsp')"></td>
        </tr>
      </table></td>
  </tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
  </form> 
  
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
	
</script>
<%@ include file="../footer.jsp"%>
</body>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>