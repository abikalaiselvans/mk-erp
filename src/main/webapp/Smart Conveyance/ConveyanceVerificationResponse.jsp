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
	sql = sql+"	DOU_TELEPHONE,CHR_OTHERDESC, DOU_OTHERAMT,DOU_TOTAL,CHR_STATUS,CHR_DESC,CHR_CALLID,CHR_REENTRY   FROM conveyance_t_conveyance ";
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
		out.println("<Td  colspan=18 class='boldEleven'><center><b>NAME :: "+pdata[0][0]+"/ "+pdata[0][1]+"</b></center></td></tr>");
		out.println("<TR class='MRow1'  >");
		out.println("<Td colspan=15 class='boldEleven'><center><b> &nbsp; </b></center></td>");
		out.println("<Td  class='boldEleven'>&nbsp;");
		out.println("</td></tr>");
		out.println("<TR>");
		
		
		out.println("<Th bgColor=#ffffff class='boldEleven'><b>Sl.No</Th>");
		out.println("<Th bgColor=#ffffff class='boldEleven' width=75><b>Date</Th>");
		out.println("<Th bgColor=#ffffff class='boldEleven'><b>Call Id</Th>");
		out.println("<Th bgColor=#ffffff class='boldEleven'><b>From</Th>");
		out.println("<Th bgColor=#ffffff class='boldEleven'><b>To</Th>");
        out.println("<Th bgColor=#ffffff class='boldEleven'><b>Vehicle No of Kms</Th>");
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
		out.println(" </TR>");
        double sum=0;
		String employeekm="employeekm";
		String approverkm="approverkm";
		for(int u=0;u<data.length;u++)
		{
			if("Y".equals(data[u][16]))
				out.println("<tr class='MRow4'>");
			else
			{
				
				if(u%2==1)
					out.println("<tr class='MRow1'>");
				else
					out.println("<tr  class='MRow2'>");	
			}
					
			out.println("<td class='boldEleven'>"+(u+1)+"</td>");
			out.println("<td class='boldEleven'>"+data[u][1]+"</td>");
			out.println("<td class='boldEleven'>"+data[u][15]+"</td>");
			out.println("<td class='boldEleven'>"+data[u][2]+"</td>");
			out.println("<td class='boldEleven'>"+data[u][3]+"</td>");
			out.println("<td class='boldEleven' align='right'>"+data[u][4]);
			out.println("<input type='hidden' name='rowid"+u+"' id='rowid"+u+"' value='"+data[u][0]+"'>");
			out.println("</td>");
			
			out.println("<input type='hidden'  name='"+(employeekm+u)+"' id='"+(employeekm+u)+"'  value='"+data[u][4]+"'></td>");
			out.println("<td class='boldEleven' align='right'><input type='text' size='8'  class='formText135'   name='"+(approverkm+u)+"' id='"+(approverkm+u)+"' onkeypress=' return numeric_only(event,'"+(approverkm+u)+"','7')' value='"+data[u][4]+"'></td>");
			
			out.println("<td class='boldEleven' align='right'>"+data[u][5]+"</td>");
			out.println("<td class='boldEleven' align='right'>"+data[u][6]+"</td>");
			out.println("<td class='boldEleven' align='right'>"+data[u][7]+"</td>");
			out.println("<td class='boldEleven' align='right'>"+data[u][8]+"</td>");
			out.println("<td class='boldEleven' align='right'>"+data[u][9]+"</td>");
			out.println("<td class='boldEleven' align='right'>"+data[u][10]+"</td>");
			out.println("<td class='boldEleven' align='right'>"+data[u][11]+"</td>");
			
			out.println("<td class='boldEleven' align='right'>");
			out.println("<a href=\"javascript:Printquery('Citydistance_Calculator.jsp?from="+data[u][2]+","+pdata[0][2] +"&to="+data[u][3]+","+pdata[0][2] +"')\" >Route Map</a>");
			out.println("</td>");
			
			out.println("<td class='boldEleven' align='right'>"+data[u][12]+"</td>");
			sum=sum+Double.parseDouble(data[u][12]);
	 		 
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
		out.println("<Td  class='boldEleven' align='right'>&nbsp;</Td>");
		out.println("<Td  class='boldEleven' align='right'><b>"+sumdata[0][1]+"</Td>");
		out.println("<Td  class='boldEleven' align='right'><b>"+sumdata[0][2]+"</Td>");
		out.println("<Td  class='boldEleven' align='right'><b>"+sumdata[0][3]+"</Td>");
		out.println("<Td  class='boldEleven' align='right'><b>"+sumdata[0][4]+"</Td>");
		out.println("<Td  class='boldEleven' align='right'><b>"+sumdata[0][5]+"</Td>");
		out.println("<Td  class='boldEleven' align='right'>&nbsp;</Td>");
		out.println("<Td  class='boldEleven' align='right'><b>"+sumdata[0][6]+"</Td>");
		out.println("<Td  class='boldEleven' align='right'>&nbsp;</Td>");
		out.println("<Td class='boldEleven'  align='right'><b>"+com.my.org.erp.common.CommonFunctions.Round(sum)+"</Td>");
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
		 <input	name="actionS" type="hidden" id="actionS" value="CONConveyanceVerification">
		<input name='dec' type='hidden'  id='dec' size='15' maxlength='100' value=<%= data.length%>>
		<input name='empid' type='hidden'  id='empid'   value='<%=empid%>'>
		<input name='fromdate' type='hidden'  id='fromdate'   value='<%=fromdate%>'>
		<input name='todate' type='hidden'  id='todate'  value='<%=todate%>'>,,
		
		</span></td>
	</tr>
	<tr>
		<td></td>
	</tr>
	<tr>
		<td ><div id="txt">
		<%
		out.println("<table width='120' border='0' cellspacing='2' cellpadding='3' align='center'>");
 	    out.println("<tr>");
        out.println("<td><input type='submit' name='submit' value='Submit' class='buttonbold13'> </td>");
		out.println("<td><input type='button' name='submit1' value='Close' class='buttonbold13' onclick=\"(redirect('Conveyancemain.jsp'))\"> </td>");
        out.println(" </tr>");
        out.println("</table>"); 
		%>
		</div></td>
	</tr>
	<tr>
		<td></td>
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
