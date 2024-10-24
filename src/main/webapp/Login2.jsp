<%@ page language="java" import="java.sql.*,java.util.*,java.io.*,java.text.*" errorPage="../error/index.jsp"%>
<%@ page import="com.my.org.erp.common.CommonFunctions" %>
<%@ page import="com.my.org.erp.Date.*" %>
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

<link href="Logincss/templatemo_style.css" rel="stylesheet" type="text/css" />
<link href="Logincss/jquery.ennui.contentslider.css" rel="stylesheet" type="text/css" media="screen,projection" />



<style type="text/css">
<!--
 <%

out.println("body {");
out.println("margin: 0px;");
out.println("padding: 0px;");
out.println("color: #aeaeae;");
out.println("font-family: Tahoma, Geneva, sans-serif;");
out.println("font-size: 13px;");
out.println("line-height: 1.5em;");
out.println("background-color: #26163d;");
out.println("background-image:url(Loginimages/"+ Day.todayDate()+".jpg);");// CommonFunctions.QueryExecute("SELECT DAY(NOW())")[0][0] DAYOFWEEK
out.println("background-repeat: repeat-x;");
out.println("background-position: top;");
out.println("}"); 
 
%>
 
.user 
{
	 
	 
	background: url('images/icon-user.gif') no-repeat top left;
	border:1px solid;
	border-radius:5px;
	-moz-border-radius:5px; /* Firefox 3.6 and earlier */
	text-align:center;
	background-color:#CCCCCC;
	height: 30px;

}

.pwd 
{
	 
	background: url('images/icon-pwd.gif') no-repeat #fff center left;
	border:1px solid;
	border-radius:5px;
	-moz-border-radius:5px; /* Firefox 3.6 and earlier */
	text-align:center;
	background-color:#CCCCCC;
	height: 30px;
}


 .loginTable
{
	 
 
	border:1px solid;
	border-color:#0488C9;
	border-radius:5px;
	-moz-border-radius:5px; /* Firefox 3.6 and earlier */
	text-align:center;
	background-color:#0488C9;
	height: 30px;
	box-shadow: 3px 3px 3px #0488C9;
	
}

.whiteHead
{
	font:Arial, Helvetica, sans-serif;
	font-weight:bold;
	margin: 0px 0 0px 0;
	font-size:large;
	font-weight: bold;
	color: #fff;
}

-->
</style>
<title>ERP</title></head>

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
	document.getElementById('txt').innerHTML="<center>  Date is "+day + "-" + month + "-"+year+" Time is "+formatAMPM(d)+" </center>";
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


function formatAMPM(date) {
  var hours = date.getHours();
  var minutes = date.getMinutes();
  var ampm = hours >= 12 ? 'pm' : 'am';
  hours = hours % 12;
  hours = hours ? hours : 12; // the hour '0' should be '12'
  minutes = minutes < 10 ? '0'+minutes : minutes;
  var strTime = hours + ':' + minutes + ' ' + ampm;
  return strTime;
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
			newWindow = window.open("greetings/index.jsp","subWind",styleStr);
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

<link href="Logincss/templatemo_style.css" rel="stylesheet" type="text/css" />
<link href="Logincss/jquery.ennui.contentslider.css" rel="stylesheet" type="text/css" media="screen,projection" />
 
</head>
<body  onload="startTime() ">

<div id="templatemo_wrapper_outer" align="center">
	<div id="templatemo_wrapper" align="center">
    
    	<div id="templatemo_header">
			<div id="site_title">
				<table width="83%" border="0" cellspacing="0" cellpadding="0">
				  <tr>
				    <td class="tmo_list">&nbsp;</td>
			      </tr>
			  </table>
				<h1>&nbsp;</h1>
			</div> <!-- end of site_title -->

				<ul id="social_box">
					<li></li>
					<li></li>
					<li></li>
					<li></li>
					<li></li>                
				</ul>
			
			<div class="cleaner"></div>
		</div>
        
        <div id="templatemo_menu">
          <table width="40%" border="0" cellspacing="0" cellpadding="0" align="right">
  <tr>
    <td width="95%">&nbsp;</td>
  </tr>
  <tr>
    <td class="menu" align="right"><a href="index.jsp">Home</a>&nbsp;&nbsp;| <a href="Career.jsp">Career</a>&nbsp;&nbsp;|<a href="Employee Verififcation.jsp" target="_self"> Verification </a>&nbsp;|<a href="contact.jsp" target="_self">&nbsp;Contact</a></td>
    <td width="0%"></td>
    <td width="5%"></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>
  	
      </div> <!-- end of templatemo_menu -->
        
        <div id="templatemo_slider_wrapper">
          <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="9%">&nbsp;</td>
              <td width="45%"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="8%">&nbsp;</td>
                  <td width="86%" align="center" valign="middle"><img src="Loginimages/121.jpg" width="169" height="54" /></td>
                  <td width="6%">&nbsp;</td>
                </tr>
                <tr>
                  <td>&nbsp;</td>
                  <td> </td>
                  <td>&nbsp;</td>
                </tr>
                <tr>
                  <td>&nbsp;</td>
                  <td align="center" valign="middle"><img src="Loginimages/erpLogo21.jpg" /></td>
                  <td>&nbsp;</td>
                </tr>
                <tr>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
              </table></td>
              <td width="41%" align="center"><div class="d">
<form method="post" action="SmartLoginAuth?filename=Login&actionS=COM_Login"   onSubmit="return validate()" AUTOCOMPLETE = "on" >
<table width="100%" border="0" cellspacing="0" cellpadding="0" >
  <tr>
    <td colspan="2"><img src="Loginimages/Register1.png" /><span class="login">Login </span></td>
    </tr>
  <tr>
    <td class="s">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2" class="s">
    <div id="txt"></div>
	
	<%
			if(!msg.equals(""))
				out.println("<br><center><font color='red'><b>"+msg+"</b></font></center>");
         	%>
    </td>
    </tr>
  <tr>
    <td width="41%" class="s">&nbsp;</td>
    <td width="59%">&nbsp;</td>
  </tr>
  <tr>
    <td class="s">Username </td>
    <td><input name="username" value='admin' class="user" id="username"   tabindex="1" title="Please fill the Username" size="15" maxlength="6"  required autofocus></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td class="s">Password </td>
    <td><input name="password" value='manager' type="password"  class="pwd" id="password"   tabindex="2" title="Please fill the Password" size="15" maxlength="15" required ></td>
  </tr>
  <tr>
    <td colspan="2" align="center" class="underline"> </td>
  </tr>
  <tr>
    <td colspan="2" align="center">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2" align="center"><input type="image" src=" images/submit_btn.gif"/></td>
  </tr>
  <tr>
    <td colspan="2" align="center">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2" align="center"><div align="center"><a title="password will be sent to mailid"	href="javascript:forgetPassword()" class="tv10black"><font color='#000000'><b>Forgot	password</b></font></a></div></td>
  </tr>
</table>
<div></div>
<div id= 'Table'></div>
<div></div>
</form>
</div></td>
              <td width="5%" align="center"></td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
          </table>
        </div>
        <div id="templatemo_content_wrapper_bottm"></div>
   
		<div id="templatemo_footer">
		
       Copyright  &nbsp;&copy;&nbsp; 2006 <%=CommonFunctions.QueryExecute("SELECT CHR_NAME FROM m_company  WHERE INT_CPYID=1")[0][0]%></div>
        
	</div> <!-- end of wrapper -->
</div> <!-- end of wrapper_outer -->
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
<%=request.getRealPath("")%>
</body>
</html>