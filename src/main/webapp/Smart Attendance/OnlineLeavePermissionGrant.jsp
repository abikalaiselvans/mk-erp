<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
%>
<html>
<head>

<title> :: ATTENDANCE ::</title>


 
<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>



<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<style type="text/css">
@import url("../JavaScript/SmartStyles.css");
</style>
</head>
<script language="JavaScript" src="../JavaScript/calendar1.js" type="text/javascript"></script>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
 
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  onLoad="disabletxt()" >
	<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm" onSubmit="return Validate()">

<%@ include file="index.jsp"%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>
	
	<table width="90%" height="177" border="0" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"
			 >
      <!--DWLayoutTable-->
      <tr align="center" valign="middle" >
        <td  height="28" class="whiteHead" >PERMISSION / LEAVE GRANT </td>
      </tr>
       
      <tr>
        <td valign="top" bgcolor="#FFFFFF"> 
          
            <div align="center">
              <%
	  String empid =""+session.getAttribute("EMPID");
				
String sql=" SELECT   b.INT_ONLINELEAVEAPPLYID,a.CHR_EMPID,a.CHR_STAFFNAME,  ";
sql=sql+ " date_format(b.DT_PDATE,'%d-%b-%Y'),b.CHR_LDESC,b.CHR_REASON,b.CHR_TYPE,b.DT_PDATE   ";
sql=sql+ " FROM com_m_staff a ,att_m_onlineapplyleave b  ";
sql=sql+ "  WHERE a.CHR_REPTO='"+empid+"' AND a.CHR_TYPE!='T' AND a.CHR_HOLD!='Y'   ";
sql=sql+ "  AND   a.CHR_EMPID =b.CHR_EMPID  AND b.CHR_STATUS='P'  "; 
sql=sql+ " order by a.CHR_STAFFNAME  ";
//out.println(sql);
String readData[][] =  CommonFunctions.QueryExecute(sql);	
				if(readData.length>0)
				{
					out.println("<center>");
					out.println("<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
					out.println("<tr class='MRow1'>");
					out.println("<td class='boldEleven' align='center' colspan='10'> ");
					
					out.println("<table width='169' height='22' border='0' cellpadding='0' cellspacing='0' align='right'  > ");
					out.println("<tr> ");
					out.println("<td width='20' class='boldEleven'  ><label> "); 
					out.println("<input id='Astatus' name='status' type='checkbox' value='A' onClick=\"Acceptall('Astatus')\" > ");
			  		out.println("</label></td> ");
					out.println("<td width='69' class='boldEleven' id='AstatusDesc'>Accept all</td> ");
					out.println("<td width='20' class='boldEleven' > ");
			  		out.println("<input name='Rstatus' id='Rstatus'type='checkbox' value='R' onClick=\"Rjectall('Rstatus')\" ></td> ");
					out.println("<td width='60' class='boldEleven' id='RstatusDesc'>Reject all</td> ");
					out.println("</tr> ");
					out.println("</table> ");
		
		
					out.println("<tr class='MRow2'>");
					out.println("<td class='boldEleven' align='center'><b>S.No</b></td>");
					out.println("<td class='boldEleven' align='center'><b>Emp ID</b></td>");
					out.println("<td class='boldEleven' align='center'><b>Emp Name</b></td>");
					out.println("<td class='boldEleven' align='center'><b>Date</b></td>");
					out.println("<td class='boldEleven' align='center'><b>Description</b></td>");
					out.println("<td class='boldEleven' align='center'><b>Reason</b></td>");
					out.println("<td class='boldEleven' align='center'><b>Type</b></td>");
					out.println("<td class='boldEleven' align='center'><b>&nbsp;</b></td>");
					String val="";
					 
					 
					for(int u=0;u<readData.length;u++)
					{
						if(u%2==0)
							out.println("<tr class='MRow1'>");
						else
							out.println("<tr class='MRow2'>");
						
						val="";
						 
						out.println("<td class='boldEleven' align='left'>"+(u+1)+".</td>");
						out.println("<td class='boldEleven' align='left'>"+readData[u][1]+"</td>");
						out.println("<td class='boldEleven' align='left'>"+readData[u][2]+"</td>");
						out.println("<td class='boldEleven' align='left'>"+readData[u][3]+"</td>");
						 
						if ( "PERMISSION".equals(readData[u][6]))
						{
							String sh[] = readData[u][4].split("~");
							String sh1= sh[0];
							if(sh1=="PFD")
								val="&nbsp;Full Day&nbsp;";
							if(sh1=="PFN")
								val="&nbsp;Fore Noon&nbsp;";
							if(sh1=="PAN")
								val="&nbsp;After Noon&nbsp;";
							val = val +"&nbsp;In Time   : "+sh[1]+"<br>&nbsp;Out Time : "+sh[2];	
						}
		
						 if ( "LEAVE".equals(readData[u][6]) )
						{
							String sh[] = readData[u][4].split("~");
							String sh1= sh[0];
							 
							String ldata[][] =CommonFunctions.QueryExecute("SELECT CHR_LEAVENAME,INT_LEAVEID FROM att_m_leavetype   WHERE CHR_SYMBOL='"+sh[0]+"'");
							String lname="";
							String lbalance="";
							if(ldata.length>0)  
							{
								lname = ldata[0][0];
								sql = "SELECT (INT_NOD"+ldata[0][1]+" -INT_NOD"+ldata[0][1]+"BALANCE)  FROM att_m_leave WHERE CHR_EMPID='"+readData[u][1]+"' AND INT_YEAR=YEAR('"+readData[u][7]+"')";
								//System.out.println(sql);
								lbalance= CommonFunctions.QueryExecute(sql)[0][0];
								
							}
							
							 				
							val="<table width='100%'  cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
							val=val +"<tr class='MRow1'><td class='boldEleven'>Leave : </td><td class='boldEleven'>"+lname+"</td></tr>";
							val=val +"<tr class='MRow2'><td class='boldEleven'>Day</td><td class='boldEleven'>"+sh[1]+"</td></tr>";
							val=val +"<tr class='MRow2'><td class='boldEleven'>Day</td><td class='boldEleven'>"+sh[1]+"</td></tr>";
							val=val +"<tr class='MRow2'><td class='boldEleven'>Balance</td><td class='boldEleven'>"+lbalance+"</td></tr>";
							val=val +"</table>";
						} 
						 
						out.println("<td class='boldEleven' align='left'>"+val +"</td>");
						out.println("<td class='boldEleven' align='left'>"+readData[u][5]+"</td>");
						out.println("<td class='boldEleven' align='left'>"+readData[u][6]+"</td>");
						out.println("<td class='boldEleven' ><input type='checkbox' id='accept"+u+"' name='accept"+u+"'  onclick=Accept('accept"+u+"')>Accept<input type='checkbox' id='reject"+u+"' name='reject"+u+"' onclick=Reject('reject"+u+"') >Reject");
						out.println("<input type='hidden' name='rowid"+u+"' id='rowid"+u+"' value='"+readData[u][0]+"'>");
						out.println("<input name='dec"+u+"' type='text' class='formText135' id='dec"+u+"' size='15' maxlength='250'>");
						 
						 
						
						
								
					}
					out.println("</table>"); 
					out.println("</center>");
				}
				else
				{
					out.println("<center><font class='bolddeepred'>Data not found...</font></center>");
				}
				%>
               
          <br></td>
      </tr>
      <tr>
        <td valign="top"></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
      <tr>
        <td><input name='dec' type='hidden' class='formText135' id='dec' size='15' maxlength='100' value=<%=readData.length%>></td>
        <td><input name="Submit" type="submit" 	class="ButtonHead" value="Submit"   accesskey="s"   ></td>
        <td><input name="Close" type="button"   class="ButtonHead" id="Close"  value="Close"   accesskey="c"  	onClick="redirect('AttendanceMain.jsp')"></td>
        <td><span class="boldEleven">
          <input name="filename" type="hidden" id="filename" value="StaffPermission">
          <input	name="actionS" type="hidden" id="actionS" value="ATTStaffPermissionleaveGrant">
        </span></td>
      </tr>
    </table>
	
	
	
	</td>
  </tr>
  <tr>
    <td>
	 
	</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>


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
			document.getElementById(fline).style.visibility="visible";
		}
	}

	
	function Acceptall(ctr)
	{
		var len=document.getElementById("dec").value;
		if(document.getElementById(ctr).checked)
		{
			document.getElementById('Rstatus').style.visibility="hidden";
			document.getElementById('RstatusDesc').style.visibility="hidden";
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
			document.getElementById('RstatusDesc').style.visibility="visible";
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
			document.getElementById('AstatusDesc').style.visibility="hidden";
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
			document.getElementById('AstatusDesc').style.visibility="visible";
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
	
function Validate()
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
		alert("Select Atleast One Leave / Permission from Accept or Reject");
		return false;
	}	
	else
	{
		return true;
	}	
}	
	
</script>
<%@ include file="../footer.jsp"%>

<%
	 
}
catch(Exception e)
{
	out.println(e.getMessage());
	System.out.println(e.getMessage());
}
%>

</form>
</body>

</html>
