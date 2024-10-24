<%@ page  language="java" import="java.sql.*" errorPage="" %>
<%@ page  language="java" import="com.my.org.erp.common.*" %>
<link rel="icon" type="image/ico" href="images/ERP.ico"></link>
<link rel="shortcut icon" href="images/ERP.ico"></link>
<link href="JavaScript/SmartStyles.css" rel="stylesheet" type="text/css">
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


<title>:: Employee Verififcation ::</title></head>
<script language="javascript" src="JavaScript/comfunction.js"></script>
<script language="JavaScript" src="JavaScript/EmployeeVerification.js"></script>
<script language="javascript">
function Validate()
{
	if(
		checkNull('name','Enter the Name')
		&& checkNull('cname','Enter the Company Name')
		&& checkNull('address','Enter the Address')
		&& checkNull('emailid','Enter the Email Address')
		&& checkEmail('emailid')
		&& checkNull('mobiles','Enter Mobile Number')
		&& checkNull('empid','Enter empid  ')
		&& eheckempid()
	)
		return true;
		
	else
		return false;
}

function eheckempid()
{
	var empid = document.getElementById('empid').value
	if(empid.length !=16)
	{
		alert("Check your Employee Id...");
		document.getElementById('empid').focus;
		return false;
	}
	else
		return true;
}

 
</script>


<%
try
{  
%>

<script language="javascript" src="comfunction.js"></script><script language="JavaScript" src="EmployeeVerification.js"></script><script language="javascript">
function Validate()
{
	if(
		checkNull('name','Enter the Name')
		&& checkNull('cname','Enter the Company Name')
		&& checkNull('address','Enter the Address')
		&& checkNull('emailid','Enter the Email Address')
		&& checkEmail('emailid')
		&& checkNull('mobiles','Enter Mobile Number')
		&& checkNull('empid','Enter empid  ')
		&& eheckempid()
	)
		return true;
		
	else
		return false;
}

function eheckempid()
{
	var empid = document.getElementById('empid').value
	if(empid.length !=16)
	{
		alert("Check your Employee Id...");
		document.getElementById('empid').focus;
		return false;
	}
	else
		return true;
}

 
</script>
<link rel="stylesheet" href="dist/css/site.min.css">
</head>
<body>

<!--nav-->
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
    
    
	
	
	<div class="container-fluid">
    <!--documents start-->
	
<form name="frm" method="post" action="SmartLoginAuth" onSubmit="return Validate()" autocomplete="OFF">
<br><br>

<div class="container">
    <!--Row with two equal columns-->
		<div class="row">
			<div class="col-md-3"></div>
			<div class="col-md-3">Name</div>
			<div class="col-md-3"><input name="name"id="name" size="30" maxlength="100"></div>
			<div class="col-md-3"></div>
		</div>
		
		
		<div class="row">
			<div class="col-md-3"></div>
			<div class="col-md-3">Company  Name <span class="errormessage">*</span> </div>
			<div class="col-md-3"><input name="cname"  id="cname" size="30" maxlength="100" >
                <input name="filename" type="hidden" id="filename" value="EmployeeVerification">
                <input name="actionS" type="hidden" id="actionS" value="HRMEmployeeVerification">
                <input name="username" type="hidden" id="username" value="MKS"></div>
			<div class="col-md-3"></div>
		</div>
		 
		<div class="row">
			<div class="col-md-3"></div>
			<div class="col-md-3">Address<span class="errormessage">*</span></div>
			<div class="col-md-3"><textarea  name="address" cols="30" rows="5"  id="address" onKeyUp="textArea(&#39;address&#39;,&#39;500&#39;)"></textarea></div>
			<div class="col-md-3"> </div>
		</div>
		 
		<div class="row">
			<div class="col-md-3"></div>
			<div class="col-md-3">Email id <span class="errormessage">*</span></div>
			<div class="col-md-3"><input name="emailid"  id="emailid" size="30" maxlength="100"></div>
			<div class="col-md-3"> </div>
		</div>
		
		<div class="row">
			<div class="col-md-3"></div>
			<div class="col-md-3">Mobile<span class="errormessage">*</span></div>
			<div class="col-md-3"><input name="mobiles"  id="mobiles" size="30" maxlength="25" onKeyPress="return numeric_only(event,&#39;mobiles&#39;,&#39;12&#39;)"></div>
			<div class="col-md-3"> </div>
		</div>
		
		<div class="row">
			<div class="col-md-3"></div>
			<div class="col-md-3"> Phone</div>
			<div class="col-md-3"><input name="phone"  id="phone" size="30" maxlength="25" onKeyPress="return numeric_only(event,&#39;phone&#39;,&#39;12&#39;)"></div>
			<div class="col-md-3"> </div>
		</div>
		
		
		<div class="row">
			<div class="col-md-3"></div>
			<div class="col-md-3">Verification Employee Id </div>
			<div class="col-md-3"><input name="empid"   id="empid" size="30" maxlength="25" onBlur="CheckUnique(this,&#39;divunitname&#39;,&#39;com_m_staff&#39;,&#39;CHR_EMPID&#39;)" onKeyUp="upperMe(this),CheckUnique(this,&#39;divunitname&#39;,&#39;com_m_staff&#39;,&#39;CHR_EMPID&#39;)"><br>
                <span class="errormessage">( Enter 16Digit Character For Resigned People Only)</span>
                <div id="divunitname"></div></div>
			<div class="col-md-3"> </div>
		</div>
		
		<div class="row">
			<div class="col-md-5"></div>
			<div class="col-md-1"><input name="Submit" type="submit" class="ButtonHead" id="Submit" value="Submit"   accesskey="s"   ></div>
			<div class="col-md-1"><input name="Submit1" type="Button" class="ButtonHead" id="Submit1" onClick="redirect(&#39;Login.jsp&#39;)"  value="Close"   accesskey="c" ></div>
			<div class="col-md-5"></div>
		</div>
		
		
		
	</div>

 </form>
		
	 <!--documents end-->
    </div>
   









 <%
}
catch(Exception e)
{
	System.out.println(e.getMessage());
}
%>

</body>
</html>