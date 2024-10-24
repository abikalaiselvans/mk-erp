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
 

<html>
<head>
<title>:: Smart ::</title>

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
	
	if(userType.equalsIgnoreCase("F") || userType.equalsIgnoreCase("B") || userType.equalsIgnoreCase("A"))
	   url="Utility/Utilitymain.jsp";	
	else
	   url="";
	
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

<!--CSS -->
<link rel="shortcut icon" href="resources/img/care.png">
<link rel="stylesheet" href="resources/css/bootstrap.min.css">
<link href="resources/css/app.min.1.css" rel="stylesheet">

<link href="resources/css/animate.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="resources/css/common.css" />
<link href="resources/css/material-design-iconic-font.min.css" rel="stylesheet">
<link href="resources/css/socicon.min.css" rel="stylesheet">
<!-- CSS -->


</head>
<body bgcolor="#000000"    leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="valid()">
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


  
 <header id="header">
            <ul class="header-inner">
                <li id="menu-trigger" data-trigger="#sidebar">
                    <div class="line-wrap">
                        <div class="line top"></div>
                        <div class="line center"></div>
                        <div class="line bottom"></div>
                    </div>
                </li>
				<li class="logo hidden-xs"><a href="home">Welcome to <%=com.my.org.erp.common.CommonFunctions.employeeName(""+session.getAttribute("EMPID") )%></a></li>
                
                
                <li class="pull-right">
					<ul class="top-menu">
						<li id="toggle-width">
							<div class="toggle-switch">
								<input id="tw-switch" type="checkbox" hidden="hidden">
								<label for="tw-switch" class="ts-helper"></label>
							</div>
						</li>
						
						 
						<li><a href="Logout.jsp"><span class="glyphicon glyphicon-log-out"></span>&nbsp;<font color='#ffffff'>Logout</font></a></li>
					</ul>
					
					
                </li>
                
                
            </ul>
            
            <!-- Top Search Content -->
            <div id="top-search-wrap">
                <input type="text">
                <i id="top-search-close">&times;</i>
            </div>
        </header>
        
        <section id="main">
            <aside id="sidebar">
                <div class="sidebar-inner c-overflow">
                    <div class="profile-menu">
                        <a href="#">
                            <div class="profile-pic">
                                <img src="<%="uploadfiles/StaffPhoto/"+ (""+session.getAttribute("USRID")).toUpperCase() +".jpg"%>" class="user-image" alt="User Image"/>
                            </div>
							
                        </a>

                        <ul class="main-menu">
                            <li>
                                <a href="#"><i class="md md-person"></i> View Profile</a>
                            </li>
                            <li>
                                <a href="#"><i class="md md-settings-input-antenna"></i> Privacy Settings</a>
                            </li>
                            <li>
                                <a href="#"><i class="md md-settings"></i> Settings</a>
                            </li>
                            <li>
                                <a href="Logout.jsp"><i class="md md-history"></i> Logout</a>
                            </li>
                        </ul>
                    </div>

                    
                </div>
            </aside>
            

            
            
            <section id="content">
                <div class="container">
                    
                 <div class="mini-charts">
						<div class="card">                 
							<div class="card-body card-padding">
								<div class="row">
									<div class="col-md-2">
										<div class="ch-grid">
											<a href="Smart Common/commonmain.jsp"><i class="md md-perm-data-setting icon"></i>Common</a>
										</div>
									</div>
									<div class="col-md-2">
										<div class="ch-grid">
											<a href="Smart HRM/HRMmain.jsp"><i class="md md-people icon"></i>HRM</a>
										</div>
									</div>
									<div class="col-md-2">
										<div class="ch-grid">
											<a href="Smart Attendance/AttendanceMain.jsp"><i class="md md-alarm icon"></i>Attendance</a>
										</div>
									</div>
									<div class="col-md-2">
										<div class="ch-grid">
											<a href="Smart Payroll/Payrollmain.jsp"><i class="md md-local-atm icon"></i>Payroll</a>
										</div>
									</div>
									<div class="col-md-2">
										<div class="ch-grid">
											<a href="Smart Inventory/Main.jsp"><i class="md md-now-widgets icon"></i>Inventory</a>
										</div>
									</div>
									<div class="col-md-2">
										<div class="ch-grid">
											<a href="Smart Conveyance/Conveyancemain.jsp"><i class="md md-account-balance-wallet icon"></i>Conveyance</a>	                            
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-2">
										<div class="ch-grid">
											<a href="Help/frame1.html"><i class="md md-live-help icon"></i>Help</a>
										</div>
									</div>
									<div class="col-md-2">
										<div class="ch-grid">
											<a href="Smart Marketing/MarketingMain.jsp"><i class="md md-shopping-cart icon"></i>Marketing</a>
										</div>
									</div>
									<div class="col-md-2">
										<div class="ch-grid">
											<a href="Smart Management/ManagementMain.jsp"><i class="md md-account-balance icon"></i>Managemant</a>
										</div>
									</div>
									<div class="col-md-2">
										<div class="ch-grid">
											<a href="Smart AMC/Main.jsp"><i class="md md-quick-contacts-dialer icon"></i>CRM</a>
										</div>
									</div>
									 
									<div class="col-md-2">
										<div class="ch-grid">
											<a href="Smart Transport/Transportmain.jsp"><i class="md md-directions-bus icon"></i>Transport</a>
										</div>
									</div>
									
									<div class="col-md-2">
										<div class="ch-grid">
											<a href="Smart Servicereport/ServiceReportmain.jsp"><i class="md md-my-library-books icon"></i>Service Report</a>
										</div>
									</div>
								</div>
								
								
								<div class="row">
									
									<div class="col-md-2">
										<div class="ch-grid">
											<a href="Smart Debug/Debugmain.jsp"><i class="md md-error icon"></i>Tickets</a>
										</div>
									</div>
									<div class="col-md-2">
										<div class="ch-grid">
											<a href="Smart UploadDownload/uploadMain.jsp"><i class="md md-cloud-upload icon"></i>File Upload</a>
										</div>
									</div>
									<div class="col-md-2">
										<div class="ch-grid">
											<a href="Smart Training/TrainingMain.jsp"><i class="md md-school icon"></i>Training</a>
										</div>
									</div>
									<div class="col-md-2">
										<div class="ch-grid">
											<a href="<%=url%>"><i class="md md-verified-user icon"></i>Settings</a>
										</div>
									</div>
									<div class="col-md-2">
										<div class="ch-grid">
											<a href="Logout.jsp"><i class="md md-history icon"></i>Logout</a>
										</div>
									</div>
								</div>
							</div>
						</div>
                    </div>
                </div>
            </section>
        </section>
        
       
         <!-- Placeholder for IE9 -->
        <!--[if IE 9 ]>
            <script src="vendors/bower_components/jquery-placeholder/jquery.placeholder.min.js"></script>
        <![endif]-->
        
        <!-- Javascript Libraries -->
      	<script src="resources/js/jquery-1.11.3.min.js"></script>
        <script src="resources/js/bootstrap.min.js"></script>
        <script src="resources/js/jquery.nicescroll.min.js"></script>
		<script src="resources/js/functions.js"></script>			
			
			
		 
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
    %>		
 
 
 <section>
	<marquee><%=message%></marquee>
</section>

 
 	 
					  
				 
	
    
	

<%--<a href="Smart Accounts/Main.jsp"><img src="images/erp/Accounts1.png" width="140" height="130" border="0"  id='Accounts' name='Accounts'   onmouseover="  this.style.border = '2px solid #3fb1a7'; Accounts.src= 'images/erp/Accounts.png'"  title='A C C O U N T S   M O D U L E'  onmouseout="  this.style.border = '2px solid #ffffff';  Accounts.src= 'images/erp/Accounts1.png'"/></a>

<a href="Help/frame1.html" target="_blank"><img src="images/erp/Help1.png" width="140" height="130" border="0"  id='Help' name='Help'  title='H E L P   M O D U L E'   onmouseover="  this.style.border = '2px solid #3fb1a7'; Help.src= 'images/erp/Help.png'"  onmouseout="  this.style.border = '2px solid #ffffff'; Help.src= 'images/erp/Help1.png'"/></a>
	--%>
	
	
	
	
  
	  
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
	  
	  
	  
	  <%
	  message=com.my.org.erp.alert.AlertFuntion.YearCompletionList();
	  %>
	   <br><div style="width:100%" align="center" >
	  <marquee id="marquee2"> <%=message%> </marquee>  
	  </div>	
	  
<%--	  
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
          <td valign="bottom"><div align="center"></div></td>
          <td valign="bottom"><div align="center"></div></td>
          <td valign="bottom"><div align="center"></div></td>
          <td valign="bottom"><div align="center"></div></td>
          <td valign="bottom"><div align="center"></div></td>
        </tr>
        <tr>
          <td valign="bottom"><div align="center"></div></td>
          <td valign="bottom"><div align="center"></div></td>
          <td valign="bottom"><div align="center"></div></td>
          <td valign="bottom"><div align="center"></div></td>
          <td valign="bottom"><div align="center"></div></td>
        </tr>
        <tr>
          <td valign="bottom"><div align="center"></div></td>
          <td valign="bottom"><div align="center"></div></td>
          <td valign="bottom"><div align="center"></div></td>
          <td valign="bottom"><div align="center"></div></td>
          <td valign="bottom"><div align="center"></div></td>
        </tr>
        <tr>
          <td valign="bottom"><div align="center"></div></td>
          <td valign="bottom"><div align="center"></div></td>
          <td valign="bottom"><div align="center"></div></td>
          <td valign="bottom"><div align="center"> </div></td>
          <td valign="bottom"><div align="center"></div></td>
        </tr>
      </table></td>
	</tr>
	<tr>
	  <td height="21" valign="middle" class="copyright">&nbsp;</td>
  </tr>
	<tr>
		<td height="21" valign="middle" class="copyright">
	  	  </td>
	</tr>
	 
	<tr>
	  <td height="21" valign="middle" class="copyright">
      
       
      
        </td>
  </tr>
	<tr>
	  <td height="21" valign="middle" class="copyright">
	 
	  </td>
  </tr>
	<tr>
	  <td height="21" valign="middle" class="copyright"> </td>
  </tr>
	<tr>
	  <td height="21" valign="middle" class="copyright"></td>
  </tr>
	<tr>
	  <td height="21" valign="middle" class="copyright">	    </td>
  </tr>
</table>--%>
 
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
 