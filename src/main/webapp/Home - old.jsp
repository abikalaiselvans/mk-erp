<%@ page import="java.util.*,java.io.*,java.net.*,com.my.org.erp.common.*" errorPage="error.jsp"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", -1);
response.setHeader("Cache-Control", "no-store");
%>
<%
try
{
%>


<script type="text/javascript" src="Logintermsandconditions/jquery.js"></script>
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
	});		*/
	
});

</script>
<style type="text/css">
body {
	font-family:verdana;
	font-size:15px;
	background-color: #333;
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




<html>
<head>
<title>:: SmartCampus ::</title>

  <%@ include file="JavaScript/dynamicStylesheet.jsp" %>
<script language="javascript" src="JavaScript/comfunction.js"> </script>

<script language="javascript" src="JavaScript/Servercheck.js"></script>
<script language="javascript"> loadServer() </script>




<script language="javascript">
function valid(){
<%
	
	 
	String userid=""+session.getAttribute("USRID"); 
	String userpass=""+session.getAttribute("USRPWD"); 
	String empid=""+session.getAttribute("EMPID"); 
	
	
	if(userid.equals("null") || userpass.equalsIgnoreCase("null")) {
		response.sendRedirect("Login.jsp?loginmsg=Login Expired");
	}
	String userType=""+session.getAttribute("USERTYPE");
	String url="<a href='Utility/Utilitymain.jsp'><img src='images/erp/erp_utility.gif' border='0'></a>";	
	if(userType.equalsIgnoreCase("F") || userType.equalsIgnoreCase("B") || userType.equalsIgnoreCase("A"))
	   url="<a title='U T I L I T Y   M O D U L E' href='Utility/Utilitymain.jsp'><img src='images/erp/utility.png' border='0' name='utility'  id='utility'  width='140' height='130'  onmouseover=\" this.style.border = '2px solid #3fb1a7'; utility.src= 'images/erp/utility.png' \"  onmouseout=\" this.style.border = '2px solid #ffffff';  utility.src= 'images/erp/utility1.png'\"></a>";	
	else
	   url="<img src='images/erp/utility1.png' width='140' height='130'   border='0'  id='utility' name='utility'   onmouseover=\"  this.style.border = '2px solid #3fb1a7'; utility.src= 'images/erp/utility.png' \"  onmouseout=\" this.style.border = '2px solid #ffffff'; utility.src= 'images/erp/utility1.png'\">";		
	
%>
}</script>
<link rel="icon" type="image/ico" href="images/ERP.ico"></link>
<link rel="shortcut icon" href="images/ERP.ico"></link>



<meta name="resource-type" content="document" />
<meta http-equiv="Content-Type" content="text/html; charset=us-ascii" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

 
</head>
<body bgcolor="#000000"  onpaste="return false;"   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="valid()">
<%@ include file="header.jsp"%>

<%
if("N".equals(CommonFunctions.QueryExecute("SELECT CHR_LOGINTERMSANDCONDITIONS from m_user WHERE CHR_USRNAME='"+userid+"'")[0][0]))
{
%>

<div id="boxes">
<div style="top: 100px; left: 551.5px; display: none;" id="dialog" class="window" >
<!--<a href="#close" title="Close" class="close">X</a>-->
<div style="OVERFLOW:auto;width:100%; height:100%; border-color:#000">
      <%@ include file="Logintermsandconditions/termsandconditions.jsp"%>
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

 
<table width="100%"   border="0" cellpadding="1" cellspacing="1" bgcolor="#cccccc">
	 
	<tr>
	  <td  valign="top"><table width="100%" border="0" align="center" cellpadding="1" cellspacing="1" >
         
        <tr>
          <td valign="bottom">&nbsp;</td>
          <td valign="bottom">&nbsp;</td>
          <td valign="bottom">&nbsp;</td>
          <td valign="bottom">&nbsp;</td>
          <td valign="bottom">&nbsp;</td>
        </tr>
        <tr>
          <td valign="bottom"><div align="center"><a href="Smart Common/commonmain.jsp"><img src="images/erp/common1.png" width="140" height="130" border="0"  title='C O M M O N   M O D U L E'  name='common'  id='common'  onmouseover=" this.style.border = '2px solid #3fb1a7'; common.src= 'images/erp/common.png'"  onmouseout=" this.style.border = '2px solid #ffffff'; common.src= 'images/erp/common1.png'"     /></a></div></td>
          <td valign="bottom"><div align="center"><a href="Smart HRM/HRMmain.jsp"><img src="images/erp/HRM1.png" width="140" height="130" border="0" id='HRM' name='HRM'  title='H R M   M O D U L E'   onmouseover=" this.style.border = '2px solid #3fb1a7'; HRM.src= 'images/erp/HRM.png'"  onmouseout="  this.style.border = '2px solid #ffffff'; HRM.src= 'images/erp/HRM1.png'"/></a></div></td>
          <td valign="bottom"><div align="center"><a href="Smart Attendance/AttendanceMain.jsp"><img src="images/erp/Attendance1.png" width="140"  title='A T T E N D A N C E   M O D U L E' height="130" border="0" id='Attendance' name='Attendance'   onmouseover="  this.style.border = '2px solid #3fb1a7'; Attendance.src= 'images/erp/Attendance.png'"  onmouseout="  this.style.border = '2px solid #ffffff'; Attendance.src= 'images/erp/Attendance1.png'"/></a></div></td>
          <td valign="bottom"><div align="center"><a href="Smart Payroll/Payrollmain.jsp"><img src="images/erp/Payroll1.png" width="140" height="130" border="0"  id='Payroll1' name='Payroll1'   title='P A Y  R O L L  M O D U L E'  onmouseover="  this.style.border = '2px solid #3fb1a7'; Payroll1.src= 'images/erp/Payroll.png'"  onmouseout="   this.style.border = '2px solid #ffffff'; Payroll1.src= 'images/erp/Payroll1.png'"/></a></div></td>
          <td valign="bottom"><div align="center"><a href="Smart Inventory/Main.jsp"><img src="images/erp/Inventory1.png" width="140" height="130" border="0"  id='Inventory' name='Inventory'   onmouseover="  this.style.border = '2px solid #3fb1a7'; Inventory.src= 'images/erp/Inventory.png'"  title='I N V E N T O R Y   M O D U L E'  onmouseout=" this.style.border = '2px solid #ffffff';  Inventory.src= 'images/erp/Inventory1.png'"/></a></div></td>
        </tr>
        <tr>
          <td valign="bottom"><div align="center"><a href="Smart Accounts/Main.jsp"><img src="images/erp/Accounts1.png" width="140" height="130" border="0"  id='Accounts' name='Accounts'   onmouseover="  this.style.border = '2px solid #3fb1a7'; Accounts.src= 'images/erp/Accounts.png'"  title='A C C O U N T S   M O D U L E'  onmouseout="  this.style.border = '2px solid #ffffff';  Accounts.src= 'images/erp/Accounts1.png'"/></a></div></td>
          <td valign="bottom"><div align="center"><a href="Smart Asset/Assetmain.jsp"><img src="images/erp/Asset1.png" width="140" height="130" border="0"  id='Asset' name='Asset'  title='A S S E T   M O D U L E'   onmouseover="  this.style.border = '2px solid #3fb1a7'; Asset.src= 'images/erp/Asset.png'"  onmouseout=" this.style.border = '2px solid #ffffff';  Asset.src= 'images/erp/Asset1.png'"/></a></div></td>
          <td valign="bottom"><div align="center"><a href="Smart Conveyance/Conveyancemain.jsp"><img src="images/erp/Conveyance1.png" width="140"  title='C O N V E Y A N C E   M O D U L E'  height="130" border="0"  id='Conveyance' name='Conveyance'   onmouseover="  this.style.border = '2px solid #3fb1a7'; Conveyance.src= 'images/erp/Conveyance.png'"  onmouseout=" this.style.border = '2px solid #ffffff';  Conveyance.src= 'images/erp/Conveyance1.png'"/></a></div></td>
          <td valign="bottom"><div align="center"><a href="Help/frame1.html" target="_blank"><img src="images/erp/Help1.png" width="140" height="130" border="0"  id='Help' name='Help'  title='H E L P   M O D U L E'   onmouseover="  this.style.border = '2px solid #3fb1a7'; Help.src= 'images/erp/Help.png'"  onmouseout="  this.style.border = '2px solid #ffffff'; Help.src= 'images/erp/Help1.png'"/></a></div></td>
          <td valign="bottom"><div align="center"><a href="Smart Marketing/MarketingMain.jsp"><img src="images/erp/Marketing1.png" width="140" height="130" border="0"  id='Marketing' name='Marketing'   title='M A R K E T I N G   M O D U L E'  onmouseover="  this.style.border = '2px solid #3fb1a7'; Marketing.src= 'images/erp/Marketing.png'"  onmouseout=" this.style.border = '2px solid #ffffff';  Marketing.src= 'images/erp/Marketing1.png'"/></a></div></td>
        </tr>
        <tr>
          <td valign="bottom"><div align="center"><a href="Smart Management/ManagementMain.jsp"><img src="images/erp/Management1.png" width="140" height="130" border="0"  id='Management' name='Management'   onmouseover=" this.style.border = '2px solid #3fb1a7'; Management.src= 'images/erp/Management.png'"  onmouseout="  this.style.border = '2px solid #ffffff'; Management.src= 'images/erp/Management1.png'" title='M A N A G E M E N T   M O D U L E' /></a></div></td>
          <td valign="bottom"><div align="center"><a href="Smart AMC/Main.jsp"><img src="images/erp/crm1.png" width="140" height="130" border="0"  id='crm' name='crm'   onmouseover="  this.style.border = '2px solid #3fb1a7'; crm.src= 'images/erp/crm.png'"  onmouseout=" this.style.border = '2px solid #ffffff';  crm.src= 'images/erp/crm1.png'" title='C R M   M O D U L E' /></a></div></td>
          <td valign="bottom"><div align="center"><a href="Smart SMS/Smsmain.jsp"><img src="images/erp/sms1.png" width="140" height="130" border="0" / id='sms' name='sms'   onmouseover="  this.style.border = '2px solid #3fb1a7'; sms.src= 'images/erp/sms.png'"  onmouseout=" this.style.border = '2px solid #ffffff';  sms.src= 'images/erp/sms1.png'" title='S M S   M O D U L E' ></a></div></td>
          <td valign="bottom"><div align="center"><a href="Smart Transport/Transportmain.jsp"><img src="images/erp/Transport1.png" width="140" height="130" border="0"  id='Transport' name='Transport'   onmouseover="  this.style.border = '2px solid #3fb1a7'; Transport.src= 'images/erp/Transport.png'"  onmouseout=" this.style.border = '2px solid #ffffff';  Transport.src= 'images/erp/Transport1.png'" title='T R A N S P O R T   M O D U L E' /></a></div></td>
          <td valign="bottom"><div align="center"><%=url%></div></td>
        </tr>
        <tr>
          <td valign="bottom"><div align="center"><a href="Smart Servicereport/ServiceReportmain.jsp"><img src="images/erp/Sevicereport1.png" width="140" height="130" border="0"  id='Sevicereport' name='Sevicereport'   onmouseover="  this.style.border = '2px solid #3fb1a7'; Sevicereport.src= 'images/erp/Sevicereport.png'"  onmouseout="  this.style.border = '2px solid #ffffff'; Sevicereport.src= 'images/erp/Sevicereport1.png'" title='S E R V I C E   M O D U L E' /></a></div></td>
          <td valign="bottom"><div align="center"><a href="Smart Debug/Debugmain.jsp"><img src="images/erp/debug1.png" width="140" height="130" border="0"  id='debug' name='debug'   onmouseover="  this.style.border = '2px solid #3fb1a7'; debug.src= 'images/erp/debug.png'"  onmouseout=" this.style.border = '2px solid #ffffff';  debug.src= 'images/erp/debug1.png'"  title='D E B U G   M O D U L E' /></a></div></td>
          <td valign="bottom"><div align="center"><a href="Smart UploadDownload/uploadMain.jsp"><img src="images/erp/fileupload1.png" width="140" height="130" border="0" id='fileupload' name='fileupload'   onmouseover="  this.style.border = '2px solid #3fb1a7'; fileupload.src= 'images/erp/fileupload.png'"  onmouseout=" this.style.border = '2px solid #ffffff';  fileupload.src= 'images/erp/fileupload1.png' " title='U P L O A D & D O W N L O A D   M O D U L E' ></a></div></td>
          <td valign="bottom"><div align="center"><a href="Smart Training/TrainingMain.jsp"><img src="images/erp/training1.png" width="140" height="130" border="0" id='trainning' name='trainning'   onmouseover="  this.style.border = '2px solid #3fb1a7'; trainning.src= 'images/erp/training.png'"  onmouseout=" this.style.border = '2px solid #ffffff';  trainning.src= 'images/erp/training1.png'" title='T R A I N I N G & C E R T I F I C A T I O N   M O D U L E' ></a> </div></td>
          <td valign="bottom"><div align="center"><a href="Logout.jsp"><img src="images/erp/Logout1.png" width="140" height="130" border="0"  id='Logout' name='Logout'   onmouseover=" this.style.border = '2px solid #3fb1a7'; Logout.src= 'images/erp/Logout.png'"  onmouseout=" this.style.border = '2px solid #ffffff';  Logout.src= 'images/erp/Logout1.png'" title='L O G O U T   M O D U L E' /></a></div></td>
        </tr>
      </table></td>
	</tr>
	<tr>
	  <td height="21" valign="middle" class="copyright">&nbsp;</td>
  </tr>
	<tr>
		<td height="21" valign="middle" class="copyright">
	  <%
		String message= "";
		message=com.my.org.erp.alert.AlertFuntion.ScrollingMessage();
		double target=com.my.org.erp.alert.MEAlertFuntion.METargetAlert(empid);
		double achieve=com.my.org.erp.alert.MEAlertFuntion.METargetCollection(empid) ;
		//if(target ==0)
		//	out.println("<center><font class='bolddeepred'> Target Not Assigned..</font></center>");
		
		
		if(target >0.0)
		{
		%>
		<script language="javascript">
			alert(" THIS MONTH TARGET -><%=target%>(In Lakhs) AND  ACHIEVE FOR THE MONTH -> <%=achieve%>");
		</script>
		<%
	 		out.println("<center><font class='bolddeepred'>");
			out.println("TARGET FOR THE MONTH  : "+com.my.org.erp.alert.MEAlertFuntion.METargetAlert(empid)+"(In lakhs)");
			out.println("ACHIEVE FOR THE MONTH : "+achieve+"");
			out.println("</font> </center>");
		}	
	%> <%
	  	/*double money = 100550000.1543545;
        NumberFormat formatter = new DecimalFormat("#0.000");
        //System.out.println(formatter.format(money));*/
		////System.out.println(com.my.org.erp.General.General.FixDigitFormat(123.456 ));
 		 	  %>
			  
			  
			  <%
	  /*Enumeration enums = session.getAttributeNames();
      while (enums.hasMoreElements()) 
	  {
      	String attributes = (String) enums.nextElement();
        out.println(""+attributes+"="+
        session.getAttribute(attributes)+"<BR>");
      }
      session.setAttribute("lastVisit",thisVisit);*/
	  
	  
/*	  
	  
if( "B".equals(""+session.getAttribute("USRTYPE")) || "F".equals(""+session.getAttribute("USRTYPE"))) 
{	  
	  
		String sql = "";	 
		sql = " SELECT a.CHR_SALESNO,DATE_FORMAT(a.DAT_SALESDATE,'%e-%M-%Y'),  ";
		sql = sql + " datediff(now(),a.DAT_SALESDATE),a.DOU_TOTALAMOUNT,a.CHR_PAYMENTSTATUS ,FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID) ,c.CHR_STAFFNAME   ";
		sql = sql + " from inv_t_directsales a ,inv_m_customerinfo b ,com_m_staff c    ";
		sql = sql + " WHERE a.CHR_PAYMENTSTATUS !='Y'   ";
		sql = sql + " AND a.CHR_PAYMENTSTATUS !='S'   ";
		sql = sql + " AND a.INT_CUSTOMERID = b.INT_CUSTOMERID   ";
		sql = sql + " AND a.CHR_REF = c.CHR_EMPID   ";
		sql = sql + " AND a.CHR_REF='"+empid+"'   ";
		sql = sql + " ORDER BY a.DAT_SALESDATE  ";
		String custData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		
		sql =   " SELECT a.CHR_SALESNO,DATE_FORMAT(a.DAT_SALESDATE,'%e-%M-%Y'),  ";
		sql = sql + " datediff(now(),a.DAT_SALESDATE),a.DOU_AMOUNT,a.CHR_PAYMENTSTATUS ,FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID) ,c.CHR_STAFFNAME  ";
		sql = sql + " from inv_t_directbilling a , inv_m_customerinfo b ,com_m_staff c   ";
		sql = sql + " WHERE a.CHR_PAYMENTSTATUS !='Y'   ";
		sql = sql + "  AND a.CHR_PAYMENTSTATUS !='S'   ";
		sql = sql + "  AND a.INT_CUSTOMERID = b.INT_CUSTOMERID   ";
		sql = sql + " AND a.CHR_REF = c.CHR_EMPID   ";
		sql = sql + "  AND a.CHR_REF='"+empid+"'   ";
		sql = sql + " ORDER BY a.DAT_SALESDATE  ";
		 String directData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		 
		sql =  " SELECT a.CHR_SALESNO,DATE_FORMAT(a.DAT_SALESDATE,'%e-%M-%Y'),  ";
		sql = sql + " datediff(now(),a.DAT_SALESDATE),a.DOU_NETAMOUNT,a.CHR_PAYMENTSTATUS ,FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID) ,c.CHR_STAFFNAME  ";
		sql = sql + " from inv_t_servicebilling a , inv_m_customerinfo b ,com_m_staff c    ";
		sql = sql + " WHERE a.CHR_PAYMENTSTATUS !='Y'   ";
		sql = sql + " AND a.CHR_PAYMENTSTATUS !='S'   ";
		sql = sql + " AND a.INT_CUSTOMERID = b.INT_CUSTOMERID   ";
		sql = sql + " AND a.CHR_REF = c.CHR_EMPID   ";
		sql = sql + " AND a.CHR_REF='"+empid+"'   ";
		sql = sql + " ORDER BY a.DAT_SALESDATE  ";
		String serviceData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		int row=0;
		double sum =0;
		if((custData.length>0) || (directData.length>0) ||(serviceData.length>0))
		{
			out.println("<br><br><center>");
			out.println("<div id='divscroll' style='OVERFLOW:auto;width:90%;height:350px' class='boldEleven'>");
			out.println("<table width='100%' class='TableDesign'  id='myTable' cellpadding=2 cellspacing=1  bgcolor='#9900CC' >");
			out.println("<tr calss='MRow1'>");
			out.println("<td class='whiteMedium'><b>S.No</b></td>");
			out.println("<td class='whiteMedium'><b>Invoice Number</b></td>");
			out.println("<td class='whiteMedium'><b>Invoice Date</b></td>");
			out.println("<td class='whiteMedium'><b>Days Left</b></td>");
			out.println("<td class='whiteMedium'><b>Invoice Amount</b></td>");
			out.println("<td class='whiteMedium'><b>Payment Status</b></td>");
			out.println("<td class='whiteMedium'><b>Customer Name</b></td>");
			out.println("<td class='whiteMedium'><b>ME Name</b></td>");
			out.println("</tr>");
			if(custData.length>0)
			{
				out.println("<tr class='MRow1'><td class='boldEleven' colspan='8' align='center'><b>CUSTOMER SALES</b></td></tr>");
				for(int u=0;u<custData.length;u++)
				{
					if(row%2==0)
						out.println("<tr class='MRow1'>");
					else
						out.println("<tr class='MRow1'>");
					row=row+1;
					out.println("<td class='boldEleven'>"+row+".</td>");		
					out.println("<td class='boldEleven'>"+custData[u][0]+"</td>");		
					out.println("<td class='boldEleven'>"+custData[u][1]+"</td>");		
					out.println("<td class='boldEleven' align='right'>"+custData[u][2]+"</td>");	
					out.println("<td class='boldEleven' align='right'>"+custData[u][3]+"</td>");	
					sum = sum + Double.parseDouble(custData[u][3])	;
					out.println("<td class='boldEleven'> ");	
					if("P".equals(custData[u][4]))	
						out.println("Patially Paid</td>");
					else if("N".equals(custData[u][4]))	
						out.println("Pending</td>");
					else
						out.println("Paid</td>");
						
					out.println("<td class='boldEleven'>"+custData[u][5]+"</td>");	
					out.println("<td class='boldEleven'>"+custData[u][6]+"</td>");	
					out.println("</tr>");	
				}
			}
			
			
			 if(directData.length>0)
			{
				out.println("<tr class='MRow1'><td class='boldEleven' colspan='8' align='center'><b>DIRECT BILLING </b></td></tr>");
				for(int u=0;u<directData.length;u++)
				{
					if(row%2==0)
						out.println("<tr class='MRow1'>");
					else
						out.println("<tr class='MRow1'>");
					row=row+1;
					out.println("<td class='boldEleven'>"+row+".</td>");		
					out.println("<td class='boldEleven'>"+directData[u][0]+"</td>");		
					out.println("<td class='boldEleven'>"+directData[u][1]+"</td>");		
					out.println("<td class='boldEleven' align='right'>"+directData[u][2]+"</td>");	
					out.println("<td class='boldEleven' align='right'>"+directData[u][3]+"</td>");	
					sum = sum + Double.parseDouble(directData[u][3])	;	
					out.println("<td class='boldEleven'> ");	
					if("P".equals(directData[u][4]))	
						out.println("Patially Paid</td>");
					else if("N".equals(directData[u][4]))	
						out.println("Pending</td>");
					else
						out.println("Paid</td>");		
					out.println("<td class='boldEleven'>"+directData[u][5]+"</td>");	
					out.println("<td class='boldEleven'>"+directData[u][6]+"</td>");	
					out.println("</tr>");	
				}
			}
			if(serviceData.length>0)
			{
				out.println("<tr class='MRow1'><td class='boldEleven' colspan='8' align='center'><b>SERVICE BILLING </b></td></tr>");
				for(int u=0;u<serviceData.length;u++)
				{
					if(row%2==0)
						out.println("<tr class='MRow1'>");
					else
						out.println("<tr class='MRow1'>");
					row=row+1;
					out.println("<td class='boldEleven'>"+row+".</td>");		
					out.println("<td class='boldEleven'>"+serviceData[u][0]+"</td>");		
					out.println("<td class='boldEleven'>"+serviceData[u][1]+"</td>");		
					out.println("<td class='boldEleven' align='right'>"+serviceData[u][2]+"</td>");	
					out.println("<td class='boldEleven' align='right'>"+serviceData[u][3]+"</td>");	
					sum = sum + Double.parseDouble(serviceData[u][3])	;		
					out.println("<td class='boldEleven'> ");	
					if("P".equals(serviceData[u][4]))	
						out.println("Patially Paid</td>");
					else if("N".equals(serviceData[u][4]))	
						out.println("Pending</td>");
					else
						out.println("Paid</td>");		
					out.println("<td class='boldEleven'>"+serviceData[u][5]+"</td>");	
					out.println("<td class='boldEleven'>"+serviceData[u][6]+"</td>");	
					out.println("</tr>");	
				}
			}
			out.println("<tr bgcolor='#ffffff'>");
			out.println("<td class='boldEleven'><b>&nbsp;</b></td>");
			out.println("<td class='boldEleven'><b>&nbsp;</b></td>");
			out.println("<td class='boldEleven'><b>&nbsp;</b></td>");
			out.println("<td class='boldEleven'><b>Total</b></td>");
			out.println("<td class='boldEleven' align='right'><b>"+sum+"</b></td>");
			out.println("<td class='boldEleven'><b>&nbsp;</b></td>");
			out.println("<td class='boldEleven'><b>&nbsp;</b></td>");
			out.println("<td class='boldEleven'><b>&nbsp;</b></td>");
			out.println("</tr>");
			 
			out.println("</table>");
			out.println("</center>");
			out.println("</div>");
		}

}
*/
    %>			  </td>
	</tr>
	 
	<tr>
	  <td height="21" valign="middle" class="copyright">
      
        <div style="width:100%" align="center" >
	  <marquee id="marquee1"> <%=message%> </marquee>  
	  </div>
      
        </td>
  </tr>
	<tr>
	  <td height="21" valign="middle" class="copyright">
	  <%
	  	String sql=" SELECT   b.INT_ONLINELEAVEAPPLYID,a.CHR_EMPID,a.CHR_STAFFNAME,  ";
sql=sql+ " date_format(b.DT_PDATE,'%d-%b-%Y'),b.CHR_LDESC,b.CHR_REASON,b.CHR_TYPE   ";
sql=sql+ " FROM com_m_staff a ,att_m_onlineapplyleave b  ";
sql=sql+ "  WHERE a.CHR_REPTO='"+session.getAttribute("EMPID")+"' AND a.CHR_TYPE!='T' AND a.CHR_HOLD!='Y'   ";
sql=sql+ "  AND   a.CHR_EMPID =b.CHR_EMPID  AND b.CHR_STATUS='P'  "; 
sql=sql+ " order by a.CHR_STAFFNAME  ";
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
	  <td height="21" valign="middle" class="copyright"> </td>
  </tr>
	<tr>
	  <td height="21" valign="middle" class="copyright"><%
	  message=com.my.org.erp.alert.AlertFuntion.YearCompletionList();
	  %>
	   <div style="width:100%" align="center" >
	  <marquee id="marquee2"> <%=message%> </marquee>  
	  </div>	</td>
  </tr>
	<tr>
	  <td height="21" valign="middle" class="copyright">	    </td>
  </tr>
</table>
 
<%
String pdatas[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT  DATEDIFF(now(),DAT_LASTPASSWORDCHANGE),( DATEDIFF(now(),DAT_LASTPASSWORDCHANGE)>180)  FROM m_user WHERE CHR_EMPID='"+session.getAttribute("USRID")+"'");
String  mes="";

if(pdatas.length>0)
	if("1".equals(pdatas[0][1] ))
		{
			mes ="  Your login password "+pdatas[0][0]+"days old...";
			%>
			<script language="javascript">alert('<%=mes%>')</script>
			<%
		}
		 
%>

 <%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>

<script language="javascript">
document.getElementById("marquee1").width=screen.width ;
document.getElementById("marquee2").width=screen.width ;
</script>

<jsp:include page="footer1.jsp" flush="true" />
 
</body>
</html>
 