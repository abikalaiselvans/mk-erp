<%@ page language="java" import="java.sql.*,java.util.*,java.io.*,java.text.*" errorPage="../error/index.jsp"%>
<%@ page import="com.my.org.erp.common.CommonFunctions" %>
<link rel="icon" type="image/ico" href="images/ERP.ico"></link>
<link rel="shortcut icon" href="images/ERP.ico"></link>
<%
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", -1);
response.setHeader("Cache-Control", "no-store");
%>

 <%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
response.setDateHeader("Expires", 0); // Proxies.
 
%>


<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="0">

<link href="style.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
.style2 {color: #0099FF}
-->
</style>
<title>Mythra</title></head>

 <%
 String update = CommonFunctions.QueryExecute("SELECT CHR_UPDATE FROM m_institution WHERE INT_ID=1")[0][0];
 String updatemsg = CommonFunctions.QueryExecute("SELECT CHR_UPDATE_MESSAGE FROM m_institution WHERE INT_ID=1")[0][0];
 String serverdate = CommonFunctions.QueryExecute("SELECT DATE_FORMAT(NOW(),'%b %d, %Y %H:%i:%s')")[0][0];
 %>




<script language="javascript" src="JavaScript/Servercheck.js"></script>
<script language="javascript" src="JavaScript/comfunction.js"></script>
<script type="text/javascript">

var dt = new Date( "<%=serverdate%>" );
dt.setDate(dt.getDate() + 0);

function startTime()
{
	var today=new Date();
	var h=today.getHours();
	var m=today.getMinutes();
	var s=today.getSeconds();
	var d=new Date()
	var day=d.getDate()
	if(day<10) day="0"+day;
	var month=d.getMonth() + 1
	if(month<10) month="0"+month;
	var year=d.getFullYear()
	
	// add a zero in front of numbers<10
	m=checkTime(m);
	s=checkTime(s);
	document.getElementById('txt').innerHTML="<center><h5> Date is "+day + "-" + month + "-"+year+" Time is "+h+":"+m+":"+s+" </h5></center>";
    t=setTimeout('startTime()',5000);
}

function checkTime(i)
{
	if (i<10)
  	{
  		i="0" + i;
  	}
	return i;
}

var dd ="<%=CommonFunctions.QueryExecute("SELECT (DATE(NOW()) =  '2012-11-05')")[0][0]%>"
function greetings()
{
	 
		var width="800", height="400";
  		var left = (screen.width/2) - width/2;
		var top = (screen.height/2) - height/2;
	 	var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=n0,copyhistory=no,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
		if(dd == "1")
		{
			newWindow = window.open("greetings/1.jpg","subWind",styleStr);
			newWindow.focus( );
		}
}
</script>
<%
    try
	{  
	   
	//FileOutputStream outStr = new FileOutputStream("out.txt", true);
    //PrintStream printStream = new PrintStream(outStr);
	//System.setOut(printStream);
	
	
	
    	String msg=""+request.getParameter("loginmsg");
       	if(msg.equals("null")) {
       		msg=""+request.getAttribute("loginmsg");
       		if(msg.equals("null")) msg="";
			//#F0F8FF
       	}
       		// onLoad="javascript:document.getElementById('username').focus()"
%>

<body  onpaste="return false;"   onload="startTime(),greetings(),document.getElementById('username').focus()">
<div id="topPan">
  <div id="toprightPan">
	<ul>
		<li class="home"><a href="Career.jsp">Career</a></li>
		<li class="about"><a href="Employee Verififcation.jsp">Verification</a></li>
		<li class="contact"><a href="contact.jsp">contact</a></li>
	</ul>
</div>
</div>

<table height="450" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="450" height="460"><img src="images/3.jpg" /></td>
    <td width="260" align="center" valign="middle" background="images/copy1.png" class="b">
	 <form method="post" action="SmartLoginAuth?filename=Login&actionS=COM_Login" onSubmit="return validate()" AUTOCOMPLETE = "on">
 <table width="95%" border="0" align="center" cellpadding="7" cellspacing="5">
  <tr>
    <td colspan=2> </td>
  </tr>
  <tr>
    <td colspan=2><div align="center"><img src="images/icon.gif" width="52" height="38" />Login</div></td>
  </tr>
  <tr>
    <td colspan=2>
	<div id="txt"></div>
	
	<%
			if(!msg.equals(""))
				out.println("<center><font color='red'><b>"+msg+"</b></font></center>");
         	%>	</td>
  </tr>
  <tr>
    <td height="25">User Name</td>
    <td><input name="username" class="user" id="username"   tabindex="1" title="Please fill the Username" size="15" maxlength="6"  required></td>
  </tr>
  <tr>
    <td>password</td>
    <td><input name="password" type="password"  class="pwd" id="password"   tabindex="2" title="Please fill the Password" size="15" maxlength="15" required ></td>
  </tr>
  
  <tr>
    <td height="20" colspan="2" align="center" valign="top"> <div id="Table">
      <input type="image" src=" images/submit_btn.gif"/> </div></td>
  </tr>
   
 
  <tr>
    <td colspan="2"><div align="center"><a title="password will be sent to mailid"	href="javascript:forgetPassword()" class="tv10black"><font color='#000000'><b>Forgot	password</b></font></a></div></td>
    </tr> <tr>
    <td colspan="2">&nbsp;</td>
  </tr>
</table>
 
</form>
</td>
  </tr>
</table>
<div id="footermainPan"> 
  <div align="center">Designed By : <a href="http://www.careind.net">Mythra IT SOLUTION PRIVATE LIMITED</a> @ 2013 </div>
  <br />
</div>
</body>
</html>

 <%
Integer hitsCount = (Integer)application.getAttribute("hitCounter");
if( hitsCount ==null || hitsCount == 0 )
	hitsCount = 1;
else
    hitsCount += 1;
    
application.setAttribute("hitCounter", hitsCount);
//<b>Total number of visits: <%= hitsCount
}
catch(Exception e)
{
	System.out.println(e.getMessage());
}
%>
 <script type="text/javascript" language="javascript">
	
	var update ="<%=update%>";
	var f = true;
	if(update == "Y")
	{
		try
		{
			f = false;
			document.getElementById('Table').innerHTML=" <br><br><center><font color=red><b><%=updatemsg%><b></font></center>";
		}
		catch(err)
   		{
     	 	alert(err);
  		 } 
	}

	function validate()
	{
		 
		if(checkNull('username','Enter UserName!!!') && checkNull('password','Enter password!!!') && (f))
			return true;
		else
			return false;
	}


	function forgetPassword()
	{
			var f ="ForgetPassword.jsp";
			newWindow = window.open(f,"subWind",",,height=400,width=600,top=0,left=0");
			newWindow.focus( );
	}
	
</script>
