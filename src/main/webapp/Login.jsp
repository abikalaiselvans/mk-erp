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
<title>ERP</title></head>
 <%
 String update = CommonFunctions.QueryExecute("SELECT CHR_UPDATE FROM m_institution WHERE INT_ID=1")[0][0];
 String updatemsg = CommonFunctions.QueryExecute("SELECT CHR_UPDATE_MESSAGE FROM m_institution WHERE INT_ID=1")[0][0];
 String serverdate = CommonFunctions.QueryExecute("SELECT DATE_FORMAT(NOW(),'%b %d, %Y %H:%i:%s')")[0][0];
 String loginby = CommonFunctions.QueryExecute("SELECT CHR_LOGINBY FROM m_institution WHERE INT_ID=1")[0][0];
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


<link rel="stylesheet" href="dist/css/site.min.css">
<style>
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
//background: url(Loginimages/<%=Day.todayDate().jpg) no-repeat center center fixed; 
 
%>
   body { 
  background: url(dist/img/download.jpg) no-repeat center center fixed; 
  -webkit-background-size: cover;
  -moz-background-size: cover;
  -o-background-size: cover;
  background-size: cover;
}

.panel-default {
opacity: 0.9;
margin-top:40%;
}
.form-group.last { margin-bottom:0px; } 
</style>
</head>


<body  onload="startTime() ">



<nav role="navigation" class="navbar navbar-custom">
        <div class="container-fluid">
          <!-- Brand and toggle get grouped for better mobile display -->
          <div class="navbar-header"><img src="images/top_banner.png"/></div>

          <div id="bs-content-row-navbar-collapse-5" class="collapse navbar-collapse">
            <ul class="nav navbar-nav navbar-right">
              <li class="active"><a href="index.jsp">Home</a></li>
			  <li class="active"><a href="Career.jsp">Career</a></li>
			  <li class="active"><a href="Employee Verififcation.jsp">Verification</a></li>
			  <li class="active"><a href="contact.jsp">Contact</a></li>
			</ul>
		  </div>
			
        </div>
</nav>
    <!--header-->
    <div class="container-fluid">
    <!--documents-->
	
		

 <div class="row">
        <div class="col-md-4 col-md-offset-7">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <span class="glyphicon glyphicon-lock"></span> Login</div>
                <div class="panel-body">
               
					<form  class="form-horizontal" role="form" method="post" action="SmartLoginAuth?filename=Login&actionS=COM_Login"   onSubmit="return validate()" AUTOCOMPLETE = "off" >
                    <div class="form-group"><div id="txt"></div></div>
					<div class="form-group">
                        <label for="inputEmail3" class="col-sm-3 control-label">
                            <%=loginby.equals("M")?"Email":"User"%></label> 
                        <div class="col-sm-9">
                            <input name="username" value='' class="form-control" id="username"   onBlur="autoAssign()"  tabindex="1" title="Please fill the Username" size="15" <%=loginby.equals("M")?" ":" maxlength='6' "%>  required autofocus>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputPassword3" class="col-sm-3 control-label">
                            Password</label>
                        <div class="col-sm-9">
                            <input name="password" value='' type="password"  class="form-control" id="password"   tabindex="2" title="Please fill the Password" size="15" maxlength="15" required >
                        </div>
                    </div>
					
					<div class="form-group">
					 	<div id= 'Table'></div>
							<%
								if(!msg.equals(""))
									out.println("<br><center><font color='red'><b>"+msg+"</b></font></center>");
							%>
					</div>			
                    
                    <div class="form-group last">
                        <div class="col-sm-offset-3 col-sm-9">
                            <button type="submit" class="btn btn-success btn-sm">
                                Sign in</button>
                        </div>
                    </div>
                    </form>
                </div>
                <div class="panel-footer"><center> <a href="javascript:forgetPassword()">Forget password</a></center></div>
            </div>
        </div>
    </div>
		
		
	 
    </div>
   

  
   
		<div id="templatemo_footer">
		
          <div align="center"><b>Copyright  &nbsp;&copy;&nbsp; 2017 <%=CommonFunctions.QueryExecute("SELECT CHR_NAME FROM m_company  WHERE INT_CPYID=1")[0][0]%></b></div>
	   </div>
        
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
	
	function autoAssign() {
	var username = document.getElementById('username').value;
	var loginby = "<%=loginby%>";
	if(loginby!="M")
	if(username != "admin"){
		username = "000000"+username;
		username = username.slice(-6);
		document.getElementById('username').value = username;
	}
}


</script>

</body>
</html>