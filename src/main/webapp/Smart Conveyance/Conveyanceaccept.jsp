<%@ page contentType="text/html; charset=iso-8859-1" language="java" 	import="java.sql.*" errorPage="../error/index.jsp"%>
<%@ page import="com.my.org.erp.SmartInventory.Model"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*,com.my.org.erp.common.*"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<!-- TemplateBeginEditable name="doctitle" -->

<title> :: CONVEYANCE ::</title>

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<style type="text/css">
<!--
.style3 {COLOR: #000000; LINE-HEIGHT: 15px; FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; TEXT-DECORATION: none; font-size: 10px;}
-->
</style>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/Inventory/Conveyance.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="javascript">
function disable1()
{
   		var len=document.getElementById("dec").value;
   		alert(len);
   		if(len>0){
		for(var i=0;i<len;i++)
		{
		var fline="rejectdecs"+i;
		 document.getElementById(fline).style.visibility="hidden";
		}
		}
		
}
function disable()
{
	var val=document.getElementById("all").checked
	 if(val==true)
	 {
	 	var nocheck=document.forms[0].reject
		for(i=0;i<nocheck.length;++ i)
		{
			nocheck[i].checked=false;
		}
		
		assign();
		var len=document.getElementById("dec").value;
		alert(len);
		for(var i=0;i<len;i++)
		{
		var fline="rejectdecs"+i;
		 document.getElementById(fline).style.visibility="hidden";
		}
	}
	
	
		
}	

function enable()
{
	var val=document.getElementById("all").checked
	 if(val==true)
	 { 
			var nocheck=document.forms[0].accept
			for(i=0;i<nocheck.length;++ i)
			{
				nocheck[i].checked=false;
			}
			
	
	    assign();
	    var len=document.getElementById("dec").value;
			for(var i=0;i<len;i++)
			{
				var fline="rejectdecs"+i;
			    document.getElementById(fline).style.visibility="Visible";
		    }
	}
	
}	

function assign()
{
	var status=document.getElementById("status").checked 
	if(status==true)
	{	
		var nocheck=document.forms[0].accept
		var val=document.getElementById("all").checked
		if(val==true)
		{ 
		  var nocheck1=document.forms[0].reject
		for(i=0;i<nocheck1.length;++ i)
		 {
			nocheck1[i].checked=false;
		 }
	    }
	    var len=document.getElementById("dec").value;
		for(var i=0;i<len;i++)
		{
		  var fline="rejectdecs"+i;
		  document.getElementById(fline).style.visibility="hidden";
	    }
	}
	else
	{
		var nocheck=document.forms[0].reject
		var val=document.getElementById("all").checked
		if(val==true)
		{
		 var nocheck1=document.forms[0].accept
		 for(i=0;i<nocheck1.length;++ i)
		 {
			nocheck1[i].checked=false;
		 }
		 var len=document.getElementById("dec").value;
		for(var i=0;i<len;i++)
		{
		  var fline="rejectdecs"+i;
		  document.getElementById(fline).style.visibility="Visible";
	    }
		}
		else
		disable1();
		
	}
	var val=document.getElementById("all").checked
	if(val==false)
	{
		for(i=0;i<nocheck.length;++ i)
		{
			nocheck[i].checked=false;
		}
	}
	else
	{
		for(i=0;i<nocheck.length;++ i)
		{		
			nocheck[i].checked=true;
		}
	}
		
		
		
}

function validate(ctr)
{
	
	var count;
	count=0;
	if(ctr=="accept")
	coffee1=document.forms[0].accept;
	else if(ctr=="reject")
	coffee1=document.forms[0].reject;

	for (i=0;i<coffee1.length;++ i)
	{
		if (coffee1[i].checked)
		{
		count=count+1;
		}
	}
	if(count==0)
 	    { 	       
		   if(document.forms[0].accept.checked)
		    { 
		    	count=1;
		    }   
		    else{	    
		   	   //alert("Select Atleast One Claim from "+ctr);
		   	   return false;
		   	 }
 	    }
	if(count>0)
		return true;
	else
	{
		//alert("Select Atleast One Claim "+ctr);
		return false;
	}
	
	
}
function validation()
{
 	alert(valid());
  var check=validate('accept');
   
   if(check==true)
    return true;
   else
   { 
   		var check1=validate('reject');
   		if(check1==true)
    		return true;
    	else{
    	  alert("Select Atleast One Claim from Accept or Reject");
   			return false;
   			}
   }
   
}
function indisable(ctr)
{
     var len=ctr.substring(6);
	 alert(len);
     var fline="reject"+len;
     document.getElementById(fline).checked=false;
     var fline1="rejectdecs"+len;
     
     var val=document.getElementById("all").checked
     if(val==true)
     {
     var status=document.getElementById("status").checked 
	  if(status==true)
		{
			document.getElementById(fline1).style.visibility="hidden";		
			var nocheck1=document.forms[0].reject
			for(i=0;i<nocheck1.length;++ i)
			{
				nocheck1[i].checked=false;
			}
			nocheck1=document.forms[0].accept
			for(i=0;i<nocheck1.length;++ i)
			{
			  nocheck1[i].checked=true;
			}
		}
		else
		{
		    document.getElementById(fline).checked=true;
		 	var nocheck1=document.forms[0].accept
			for(i=0;i<nocheck1.length;++ i)
			{
			  nocheck1[i].checked=false;
			}
		}
     }
     else
     {
        document.getElementById(fline1).style.visibility="hidden";		
     }
}
function inenable(ctr)
{
     var len=ctr.substring(6);
     var fline="accept"+len;
     document.getElementById(fline).checked=false;
     var fline1="rejectdecs"+len;
	 var rj = "reject"+len;
     var val=document.getElementById("all").checked
     if(val==true)
     {
     	var status=document.getElementById("status").checked 
	  	if(status==true)
		{   
			document.getElementById(fline).checked=true;
			var nocheck1=document.forms[0].reject
			for(i=0;i<nocheck1.length;++ i)
			{
				nocheck1[i].checked=false;
			}
			nocheck1=document.forms[0].accept
			for(i=0;i<nocheck1.length;++ i)
			{
				nocheck1[i].checked=true;
			}
		}
		else
		{
		    document.getElementById(fline1).style.visibility="Visible";
		 	var nocheck1=document.forms[0].accept
			for(i=0;i<nocheck1.length;++ i)
			{
			  nocheck1[i].checked=false;
			}
			nocheck1=document.forms[0].reject
			for(i=0;i<nocheck1.length;++ i)
			{
				nocheck1[i].checked=true;
			}
		}
     }
     else
       document.getElementById(fline1).style.visibility="Visible";
	   
	 //if(document.getElementById("rj").checked)  
	 //onLoad="disable1()"
     
}
</script>
<body  onpaste="return false;" onLoad="disabletxt()"  >

<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth" 	onSubmit="return valid()">
<br><br><br>
<table width="95%" height="150" border="0" align="center"
	cellpadding="2" cellspacing="2">
	<%
try
{
	
	 
 %>
	<tr>
		<td><label> </label> <label></label></td>
	</tr>
	<tr>
		<td>
		<%
   String empid =""+request.getParameter("empid");
   String fromdate =""+request.getParameter("fromdate");
   String todate =""+request.getParameter("todate");
    fromdate = DateUtil.FormateDateSQL(fromdate);
   todate = DateUtil.FormateDateSQL(todate);
	String sql="";
	
 	sql =" SELECT a.CHR_EMPID,a.CHR_STAFFNAME ,b.CHR_OFFICENAME FROM com_m_staff a, com_m_office b WHERE a.INT_OFFICEID =b.INT_OFFICEID AND a.CHR_EMPID ='"+empid+"' ";
	String pdata[][] = CommonFunctions.QueryExecute(sql);
	 
   	sql ="SELECT INT_CONID,DATE_FORMAT(DAT_CONDATE,'%d-%b-%Y'),CHR_FROM,CHR_TO,DOU_KM,DOU_TRAVEL,DOU_TRAIN,DOU_AUTO,DOU_LUNCH,";
	sql = sql+"	DOU_TELEPHONE,CHR_OTHERDESC, DOU_OTHERAMT,DOU_TOTAL,CHR_STATUS,CHR_DESC,CHR_CALLID,CHR_REENTRY,CHR_FLAG   FROM conveyance_t_conveyance ";
	sql = sql+" WHERE CHR_STATUS='N' ";
	sql = sql + " AND DAT_CONDATE >= '"+fromdate+"' ";
	sql = sql + " AND DAT_CONDATE <= '"+todate+"' ";
	
	
	sql = sql+" AND CHR_EMPID='"+empid+"' order by DAT_CONDATE desc"; 
	//out.println(sql);
	out.println("<br><br>");
	String data[][] = CommonFunctions.QueryExecute(sql);
	
	
	
	
	if(data.length>0)
	{
		 
		out.println("<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
		out.println("<TR class='MRow1'  >");
		out.println("<Td  colspan=17 class='boldEleven'><center><b>NAME :: "+pdata[0][0]+"/ "+pdata[0][1]+"</b></center></td></tr>");
		out.println("<TR class='MRow1'  >");
		out.println("<Td colspan=14 class='boldEleven'><center><b> &nbsp; </b></center></td>");
		out.println("<Td colspan=3 class='boldEleven'>&nbsp;");
		%>
		<table width="169" height="22" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td width="20" class="boldEleven"><label> 
				<input id="Astatus" name="status" type="checkbox" value="A" onClick="Acceptall('Astatus')" >
			  </label></td>
				<td width="69" class="boldEleven">Accept all</td>
				<td width="20" class="boldEleven">
			  <input name="Rstatus" id="Rstatus" type="checkbox" value="R" onClick="Rjectall('Rstatus')" ></td>
				<td width="60" class="boldEleven">Reject all</td>
			</tr>
		</table>
		<%
		out.println("</td></tr>");
		out.println("<TR>");
		
		
		out.println("<Th bgColor=#ffffff class='boldEleven'><b>Sl.No</Th>");
		out.println("<Th bgColor=#ffffff class='boldEleven' width=75><b>Date</Th>");
		out.println("<Th bgColor=#ffffff class='boldEleven'><b>Call Id</Th>");
		out.println("<Th bgColor=#ffffff class='boldEleven'><b>From</Th>");
		out.println("<Th bgColor=#ffffff class='boldEleven'><b>To</Th>");
        out.println("<Th bgColor=#ffffff class='boldEleven'><b>Vehicle No of Kms</Th>");
        out.println("<Th bgColor=#ffffff class='boldEleven'><b>Amount</Th>");
        out.println("<Th bgColor=#ffffff class='boldEleven'><b>Train/Bus Fare</Th>");
        out.println("<Th bgColor=#ffffff class='boldEleven'><b>Auto Fare</Th>");
        out.println("<Th bgColor=#ffffff class='boldEleven'><b>Lunch / Dinner</Th>");
        out.println("<Th bgColor=#ffffff class='boldEleven'><b>Telephone Charges</Th>");
        out.println("<Th bgColor=#ffffff class='boldEleven'><b>Others Desc</Th>");
        out.println("<Th bgColor=#ffffff class='boldEleven'><b>Others Amt</Th>");
		
		out.println("<Th bgColor=#ffffff class='boldEleven'><b>Route Map</Th>");
		
        out.println("<Th bgColor=#ffffff class='boldEleven'><b>Total </Th>");
		out.println("<Th bgColor=#ffffff class='boldEleven' width='125'>&nbsp;");
		//<input type='checkbox' id='all' name='all' onClick=totalCheck('all')></Th>");
		out.println("<Th bgColor=#ffffff class='boldEleven'>&nbsp; </Th>");
		//out.println("<Th bgColor=#ffffff class='boldEleven'>&nbsp; </Th>");
		out.println(" </TR>");
        double sum=0;
		for(int u=0;u<data.length;u++)
		{
			if("Y".equals(data[u][16]) || "Y".equals(data[u][17]))
				out.println("<tr class='MRow4'>");
			else
			{
				
				if(u%2==1)
					out.println("<tr class='MRow1'>");
				else
					out.println("<tr  class='MRow2'>");	
			}
					
			out.println("<td class='boldEleven'>"+(u+1));
			out.println("<td class='boldEleven'>"+data[u][1]);
			out.println("<td class='boldEleven'>"+data[u][15]);	
			out.println("<td class='boldEleven'>"+data[u][2]);
			out.println("<td class='boldEleven'>"+data[u][3]);
			out.println("<td class='boldEleven' align='right'>"+data[u][4]);
			out.println("<td class='boldEleven' align='right'>"+data[u][5]);
			out.println("<td class='boldEleven' align='right'>"+data[u][6]);
			out.println("<td class='boldEleven' align='right'>"+data[u][7]);
			out.println("<td class='boldEleven' align='right'>"+data[u][8]);
			out.println("<td class='boldEleven' align='right'>"+data[u][9]);
			out.println("<td class='boldEleven' align='right'>"+data[u][10]);
			out.println("<td class='boldEleven' align='right'>"+data[u][11]);
			
			out.println("<td class='boldEleven' align='right'>");
			out.println("<a href=\"javascript:Printquery('Citydistance_Calculator.jsp?from="+data[u][2]+","+pdata[0][2] +"&to="+data[u][3]+","+pdata[0][2] +"')\" >Route Map</a>");
			out.println("</td>");
			
			out.println("<td class='boldEleven' align='right'>"+data[u][12]);
			sum=sum+Double.parseDouble(data[u][12]);
			
			
			if("N".equals(data[u][13]))
				out.println("<td class='boldEleven' ><input type='checkbox' id='accept"+u+"' name='accept"+u+"'  onclick=Accept('accept"+u+"')>Accept<input type='checkbox' id='reject"+u+"' name='reject"+u+"' onclick=Reject('reject"+u+"') >Reject");
			else if("Y".equals(data[u][13]))
				out.println("<td class='boldEleven'><font class='boldred'>Accept</font>");
			else if("R".equals(data[u][13]))
				out.println("<td class='boldEleven'><font class='boldred'>Reject</font>");
			
			out.println("<input type='hidden' name='hiddenField"+u+"' id='hiddenField"+u+"' value='"+data[u][0]+"'>");
				
			out.println("<td class='boldEleven' >");
			
			 
			if("Y".equals(data[u][16]))
				out.println(" Reject Desc :"+	data[u][14]);
			
			out.println("<input name='dec"+u+"' type='text' class='formText135' id='dec"+u+"' size='15' maxlength='100'>");
			//out.println("<td class='boldEleven'>&nbsp;");
			 
		}
		
		out.println("<TR bgColor=#ffffff >");
		
		sql = " SELECT SUM(DOU_KM),SUM(DOU_TRAVEL),SUM(DOU_TRAIN),SUM(DOU_AUTO),SUM(DOU_LUNCH),  ";
 		sql = sql +" SUM(DOU_TELEPHONE),SUM(DOU_OTHERAMT),SUM(DOU_TOTAL) FROM conveyance_t_conveyance   ";
  		sql = sql +" WHERE CHR_STATUS='N'   ";
 		sql = sql +" AND CHR_EMPID = '"+empid+"'  ";
 		sql = sql +" GROUP BY CHR_EMPID ";
 	    //out.println(sql);
		String sumdata[][] = CommonFunctions.QueryExecute(sql);
	
		out.println("<Td  class='boldEleven' align='right'>&nbsp;</Td>");
		out.println("<Td  class='boldEleven' align='right'>&nbsp;</Td>");
		out.println("<Td  class='boldEleven' align='right'>&nbsp;</Td>");
		out.println("<Td  class='boldEleven' align='right'>&nbsp;</Td>");
		out.println("<Td  class='boldEleven' align='right'>&nbsp;</Td>");
		out.println("<Td  class='boldEleven' align='right'><b>"+sumdata[0][0]+"</Td>");
		out.println("<Td  class='boldEleven' align='right'><b>"+sumdata[0][1]+"</Td>");
		out.println("<Td  class='boldEleven' align='right'><b>"+sumdata[0][2]+"</Td>");
		out.println("<Td  class='boldEleven' align='right'><b>"+sumdata[0][3]+"</Td>");
		out.println("<Td  class='boldEleven' align='right'><b>"+sumdata[0][4]+"</Td>");
		out.println("<Td  class='boldEleven' align='right'><b>"+sumdata[0][5]+"</Td>");
		out.println("<Td  class='boldEleven' align='right'>&nbsp;</Td>");
		out.println("<Td  class='boldEleven' align='right'><b>"+sumdata[0][6]+"</Td>");
		out.println("<Td  class='boldEleven' align='right'>&nbsp;</Td>");
		out.println("<Td class='boldEleven'  align='right'><b>"+com.my.org.erp.common.CommonFunctions.Round(sum)+"</Td>");
         
		
		
		 
		
		out.println("<Td class='boldEleven' colspan='2'>");
		
		out.println("<table width='120' border='0' cellspacing='2' cellpadding='3' align='center'>");
 	    out.println("<tr>");
        out.println("<td><input type='submit' name='submit' value='Submit' class='buttonbold13'> </td>");
		out.println("<td><input type='button' name='submit1' value='Close' class='buttonbold13' onclick=\"(redirect('Conveyancemain.jsp'))\"> </td>");
        out.println(" </tr>");
        out.println("</table>"); 
		
		 
		 
		out.println(" </TR>");
		 
		out.println("</TABLE>");
	}
	else
	{
		out.println("<font  class='bolddeepred' ><center>Data not found</center></font> ");
	}
   %>
		</td>
	</tr>
	<tr>
		<td><span class="boldEleven"> <input name="filename" type="hidden" id="filename" value="Conveyance">
		 <input	name="actionS" type="hidden" id="actionS" value="CONConveyanceAccept">

		</span></td>
	</tr>
	<tr>
		<td></td>
	</tr>
	<tr>
		<td ><div id="txt"></div></td>
	</tr>
	<tr>
		<td><input name='dec' type='hidden' class='formText135' id='dec' size='15' maxlength='100' value=<%= data.length%>></td>
	</tr>
</table>

<%
}
catch(Exception e)
{
	//System.out.println(e.getMessage());
}
%>

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
		alert("Select Atleast One Claim from Accept or Reject");
		return false;
	}	
	else
	{
		return true;
	}	
}	
	
</script>
<br><br><br>
<%@ include file="../footer.jsp"%>
</body>
</html>
