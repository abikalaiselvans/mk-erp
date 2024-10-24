<%@ page import="java.sql.*,java.util.*,java.io.*,com.my.org.erp.common.*"%>
<html>
<head>
<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>
 

<script type="text/javascript" src="../Logintermsandconditions/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function() {	

		var id = '#dialog';
	
		//Get the screen height and width
		var maskHeight = $(document).height();
		var maskWidth = $(window).width();
	
		//Set heigth and width to mask to fill up the whole screen
		$('#mask').css({'width':maskWidth,'height':maskHeight});
		
		//transition effect		
		$('#mask').fadeIn(1000);	
		$('#mask').fadeTo("slow",0.8);	
	
		//Get the window height and width
		var winH = $(window).height();
		var winW = $(window).width();
              
		//Set the popup window to center
		$(id).css('top',  winH/2-$(id).height()/2);
		$(id).css('left', winW/2-$(id).width()/2);
	
		//transition effect
		$(id).fadeIn(2000); 	
	
	//if close button is clicked
	$('.window .close').click(function (e) {
		//Cancel the link behavior
		e.preventDefault();
		
		$('#mask').hide();
		$('.window').hide();
	});		
	
	/*//if mask is clicked
	$('#mask').click(function () {
		$(this).hide();
		$('.window').hide();
	});	*/	
	
});

</script>
<style type="text/css">
body {
font-family:verdana;
font-size:15px;
}
a {color:#333; text-decoration:none}
a:hover {color:#ccc; text-decoration:none}
 
#boxes .window {
	position:absolute;
	left:0;
	top:0;
	width:440px;
	height:200px;
	display:none;
	z-index:9999;
	padding:20px;
	border-radius: 5px;
	background-color: #06F;
  
}

#mask {
  position:absolute;
  left:0;
  top:0;
  z-index:9000;
  background-color:#000;
  display:none;
  
} 

#boxes #dialog {
	width:80%;
	height:80%;
	padding:10px;
	border-top-width: medium;
	border-right-width: medium;
	border-bottom-width: medium;
	border-left-width: medium;
	border-top-style: groove;
	border-right-style: groove;
	border-bottom-style: groove;
	border-left-style: groove;
	border-radius: 4px;
	border-radius: 4px; background-color:#FFFFFF; 
  }

.close {
	background: #606061;
	color: #FFFFFF;
	line-height: 25px;
	position: absolute;
	right: -12px;
	text-align: center;
	top: -10px;
	width: 24px;
	text-decoration: none;
	font-weight: bold;
	-webkit-border-radius: 12px;
	-moz-border-radius: 12px;
	border-radius: 12px;
	-moz-box-shadow: 1px 1px 3px #000;
	-webkit-box-shadow: 1px 1px 3px #000;
	box-shadow: 1px 1px 3px #000;
}

.close:hover { background: #00d9ff; }

</style>


<% 
if("N".equals(CommonFunctions.QueryExecute("SELECT CHR_LOGINTERMSANDCONDITIONS from m_user WHERE CHR_USRNAME='"+session.getAttribute("USRID")+"'")[0][0]))
{
%>

<div id="boxes">
<div style="top: 100px; left: 551.5px; display: none;" id="dialog" class="window" >
<!--<a href="#close" title="Close" class="close">X</a>-->
<div style="OVERFLOW:auto;width:100%; height:100%; border-color:#000">
      <%@ include file="../Logintermsandconditions/stafftermsandconditions.jsp"%>
 </div>
</div>
<!-- Mask to cover the whole screen -->
<div style="width: 1478px; height: 602px; display: none; opacity: 80;" id="mask"></div>
</div>

<%
}
else
{
}
%>
<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />


<title>:: STAFF ::</title>

 
 <style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
<script language="javascript" src="../JavaScript/Servercheck.js"></script>
<script language="javascript">
loadServer()
</script>
 <link href="style.css" rel="stylesheet" type="text/css">
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %> 
</head>

<body  onpaste="return false;"  >
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><%@ include file="header.jsp" %></td>
  </tr>
  <tr>
    <td class="boldred"><div align="right">Last Login Time :: <%=CommonFunctions.QueryExecute("SELECT DATE_FORMAT(DAT_LOGINDATEANDTIME,'%d-%b-%Y %h:%i:%s : %p') FROM m_user WHERE CHR_USRNAME='"+session.getAttribute("USRID")+"'")[0][0]%> &nbsp;&nbsp;&nbsp;&nbsp; </div></td>
  </tr>
   
  <tr>
    <td>
	<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" class="AdminBodyTable">
		<tr>
		  <td  width="10%" height="800" align="left" valign="top" class="UserLeftPanel">
		  
		  
		    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" id="FLoginTable" height="auto">
               
              <tr>
                <td height="200" colspan="2" align="center" valign="middle">
				  <div align="center">
				    <%
			String staffphoto = "../uploadfiles/StaffPhoto/"+session.getAttribute("EMPID") +".jpg";
			String photo="";
			File f = new File(staffphoto);
			if (f.exists())
				photo = "../uploadfiles/StaffPhoto/"+session.getAttribute("EMPID")  +".jpg";
			else 
				photo ="../uploadfiles/StaffPhoto/default.jpg";	
				%><br>
			        <img src="<%=photo%>" width="125" height="125" border="0"><br></div></td>
              </tr>
              <tr>
                <td colspan="2" align="center" valign="middle">
				
				<%
	 String usertype=""+session.getAttribute("USRTYPE");
	  if("S".equals(usertype))
	  {
		%>		<br>
				<jsp:include page="Menu.jsp" flush="true" />
	<%
		}
		 
		 
		 	
	%>				</td>
              </tr>
            </table></td>
			
			
		  <td  width="90%"  class="MiddlePanel"> 
		  <iframe src="Userframe.jsp" width="98%"
					name="UserFrame"  id="UserFrame"  height="100%"   frameborder="0"
					style="border-width: 1px; border-color: #F48442; border-style: dotted;">		  </iframe></td>
		</tr>
</table>	</td>
  </tr>
  
  
  
  <tr>
    <td>
	<%
String sql=" SELECT   b.INT_ONLINELEAVEAPPLYID,a.CHR_EMPID,a.CHR_STAFFNAME,  ";
sql=sql+ " date_format(b.DT_PDATE,'%d-%b-%Y'),b.CHR_LDESC,b.CHR_REASON,b.CHR_TYPE   ";
sql=sql+ " FROM com_m_staff a ,att_m_onlineapplyleave b  ";
sql=sql+ "  WHERE a.CHR_REPTO='"+session.getAttribute("EMPID")+"' AND a.CHR_TYPE!='T' AND a.CHR_HOLD!='Y'   ";
sql=sql+ "  AND   a.CHR_EMPID =b.CHR_EMPID  AND b.CHR_STATUS='P'  "; 
sql=sql+ " order by a.CHR_STAFFNAME  ";
//out.println(sql);
String readData[][] =  CommonFunctions.QueryExecute(sql);	
if(readData.length>0)
{
%> 
<script language="javascript">alert("Kindly grant a Permission/ Leave for <%=readData.length%>  -  Employees")</script>
<%
}
	  %>
	</td>
  </tr>
  <tr>
    <td> <jsp:include page="../footer.jsp" flush="true" /></td>
  </tr>
</table>



 

</html>
