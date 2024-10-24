<!DOCTYPE html>

<%@ page import="java.util.*,java.io.*,java.net.*,com.my.org.erp.common.*" errorPage="error.jsp"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="com.my.org.erp.alert.*"%>

<jsp:include page="moduleController.jsp" flush="true" />

<%
//pmcom, pmhrm, pmatt, pmpay, pminv, pmcon, pmhel, pmmkt, ppmmgt, pmamc, pmsms, pmtra, pmssr, pmdeb, pmupd, pmtrs, pmuti
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", -1);
response.setHeader("Cache-Control", "no-store");
String empid=""+session.getAttribute("EMPID"); 


 
try
{
	
	if("1".equals(CommonFunctions.QueryExecute("SELECT FUN_WEDDINGDATE(FIND_WEDDINGDATE())")[0][0]))
		response.sendRedirect("../Logout.jsp");


 	String sesUserName=(""+session.getAttribute("USRID")).trim(); 
	String EMPID=""+session.getAttribute("EMPID"); 
	if("null".equalsIgnoreCase(sesUserName) ||  sesUserName.equals("")) 
			response.sendRedirect("../Login.jsp?loginmsg=Login Expired");
 	         
	if( "S".equals(""+session.getAttribute("USRTYPE"))) 
			response.sendRedirect("../Login.jsp?loginmsg=Login Expired");
	
%>
<html>
  <head>
    <meta charset="UTF-8">
    <title>:: ERP :: </title>
   
   
    <!-- Bootstrap 3.3.2 -->
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- Theme style -->
    <link href="dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
    <!-- AdminLTE Skins. Choose a skin from the css/skins 
         folder instead of downloading all of them to reduce the load. -->
    <link href="dist/css/skins/_all-skins.min.css" rel="stylesheet" type="text/css" />

  
  <!--Custom style -->
  <link rel="stylesheet" href="css/style.css" />
 
 
 
  </head>
  
  
   <!--
  BODY TAG OPTIONS:
  =================
  Apply one or more of the following classes to get the 
  desired effect
  |---------------------------------------------------------|
  | SKINS         | skin-blue                               |
  |               | skin-black                              |
  |               | skin-purple                             |
  |               | skin-yellow                             |
  |               | skin-red                                |
  |               | skin-green                              |
  |---------------------------------------------------------|
  |LAYOUT OPTIONS | fixed                                   |
  |               | layout-boxed                            |
  |               | layout-top-nav                          |
  |               | sidebar-collapse                        |  
  |---------------------------------------------------------|
  
  -->
  <body class="skin-yellow">
  <div class="wrapper">
      
      <header class="main-header">
        <!-- Logo -->
        <a href="sadmin.jsp" class="logo"><b text-right>ERP</b></a>
         
          
          
        <!-- Header Navbar: style can be found in header.less -->
        <nav class="navbar navbar-static-top" role="navigation">
         
         
          
          
          
          <!-- Navbar Right Menu -->
          <div class="navbar-custom-menu">
            <ul class="nav navbar-nav">
              <!-- Messages: style can be found in dropdown.less--><!-- Notifications: style can be found in dropdown.less --><!-- Tasks: style can be found in dropdown.less --><!-- User Account: style can be found in dropdown.less -->
              
                
               <a href="Logout.jsp" > <span class="label label-success">Sign out</span> </a> 
                
              <li class="dropdown user user-menu">
            
               <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                 <img src="<%="uploadfiles/StaffPhoto/"+ (""+session.getAttribute("USRID")).toUpperCase() +".jpg"%>" class="user-image" alt="User Image"/>
                 <span class="hidden-xs"> <%=CommonFunctions.employeeName(""+session.getAttribute("EMPID") )%> / <%=""+session.getAttribute("USRID") %> </span>
                </a>
                <ul class="dropdown-menu">
                  <!-- User image -->
                  <li class="user-header">
                    <img src="<%="uploadfiles/StaffPhoto/"+ (""+session.getAttribute("USRID")).toUpperCase() +".jpg"%>" class="img-circle" alt="User Image" />
                    <p>
                    
                    <%
					String ldata[][] = CommonFunctions.QueryExecute("SELECT DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y'),b.CHR_DESIGNAME, a.CHR_STAFFNAME FROM com_m_staff a, com_m_desig b WHERE a.INT_DESIGID = b.INT_DESIGID AND a.CHR_EMPID = '"+session.getAttribute("EMPID")+"' ");
					if(ldata.length>0)
					{
						out.println(ldata[0][1]);
						out.println("<small>"+ldata[0][0]+"</small>");
					}
					%>
                      
                    </p>
                  </li>
                  <!-- Menu Body -->
                  <!-- <li class="user-footer">
                    <div class="pull-left">
                      <a href="#" class="btn btn-default btn-flat">Profile</a>
                    </div>
                    <div class="pull-right">
                      <a href="Logout.jsp" class="btn btn-default btn-flat">Sign out</a>
                    </div>
                  </li>-->
                  
                </ul>
              </li>
            </ul>
          </div>
        </nav>
    </header>
      
      
      
	  
	  
	   <!-- Left side column. contains the logo and sidebar -->
  <aside class="main-sidebar">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
      <!-- Sidebar user panel -->
     
	 
	  
      <!-- search form -->
      <form action="#" method="get" class="sidebar-form">
        <div class="input-group">
          <input type="text" name="q" class="form-control" placeholder="Search...">
          <span class="input-group-btn">
                <button type="submit" name="search" id="search-btn" class="btn btn-flat"><i class="fa fa-search"></i>
                </button>
              </span>
        </div>
      </form>
	  <!-- /.search form -->
     




	 <!-- sidebar menu: : style can be found in sidebar.less -->
      <ul class="sidebar-menu tree" data-widget="tree">
	  
	   
		  <li class="active treeview menu-open" style="height: auto;">
			  <a href="#">
				<i class="fa fa-dashboard"></i> <span>Dashboard</span>
				<span class="pull-right-container">
				  <i class="fa fa-angle-left pull-right"></i>
				</span>
			  </a>
			  <ul class="treeview-menu" style="">
				<li class="active"><a href="#"><i class="fa fa-circle-o"></i>Common</a></li>
				<li><a href="#"><i class="fa fa-circle-o"></i>HRM</a></li>
				<li><a href="#"><i class="fa fa-circle-o"></i>Attendance</a></li>
				<li><a href="#"><i class="fa fa-circle-o"></i>Payroll</a></li>
				<li><a href="#"><i class="fa fa-circle-o"></i>Inventory</a></li>
				<li><a href="#"><i class="fa fa-circle-o"></i>Conveyance</a></li>
				<li><a href="#"><i class="fa fa-circle-o"></i>Marketing</a></li>
				<li><a href="#"><i class="fa fa-circle-o"></i>User</a></li>
			  </ul>
			</li>
		<%--
        <li><a href="#"><i class="glyphicon glyphicon-home"></i>Dashboard </a></li>
		<li><a href="#"><i class="glyphicon glyphicon-certificate"></i>Master </a></li>
		<li><a href="#"><i class="glyphicon glyphicon-th-list"></i>Attendance </a></li>
		<li><a href="#"><i class="glyphicon glyphicon-list-alt"></i>Forms</a></li>
		<li><a href="#"><i class="glyphicon glyphicon-bell"></i>Payroll</a></li>
		<li><a href="#"><i class="glyphicon glyphicon-indent-left"></i>Inventory</a></li>
		<li><a href="#"><i class="glyphicon glyphicon-calendar"></i>Conveyance</a></li>
		<li><a href="#"><i class="glyphicon glyphicon-font"></i>Marketing</a></li>
		<li><a href="#"><i class="glyphicon glyphicon-minus"></i>Utility</a></li>
		<li><a href="#"><i class="glyphicon glyphicon-list-alt"></i>Service</a></li>
		<li><a href="#"><i class="glyphicon glyphicon-th-list"></i>Upload/Download</a></li>
		<li><a href="#"><i class="glyphicon glyphicon-lock"></i>Logout</a></li>--%>
      </ul>
    </section>
    <!-- /.sidebar -->
  </aside>
      
      


      <!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper">
	  
	  
	  
	  <section class="content-header">
	  <br><br>
	  
	  
	  
		<div class="row" align="center">
          	<center>
            	<div class="col-md-12">
           			<div class="box box-warning box-solid">
                		<div class="box-header with-border">
                  		<h3 class="box-title">Birth Day & Wedding  Wishes</h3>
                  		<div class="box-tools pull-right"><button data-widget="collapse" class="btn btn-box-tool"><i class="icon_minus-06 "></i></button></div><!-- /.box-tools -->
                	</div><!-- /.box-header -->
                    
                <div class="box-body" style="display: block;">
                <%
                String message= "";
				message=AlertFuntion.ScrollingMessage();
				out.println("<br>");
				out.println("<marquee>");
				out.println(message);
				out.println("</marquee>");
				out.println("<br>");
				//
				message= AlertFuntion.YearCompletionList();
				out.println("<br>");
				out.println("<marquee>");
				out.println(message);
				out.println("</marquee>");
				out.println("<br>");
        		%>
               </div><!-- /.box-body -->
              </div>
 			</div>    
			</center> 
          </div>
		   
		   
	<div class="row" align="center"></div>	   
      <br><h1>
        Dashboard
        <small>Control panel</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
        <li class="active">Dashboard</li>
      </ol>
    </section>
	  
	  
       <!-- Main content -->
         <section class="content">
             
           
		   
		   <div class="row">
        <div class="col-lg-3 col-xs-6">
          <!-- small box -->
          <div class="small-box bg-aqua">
            <div class="inner">
              <h3>0</h3>

              <p>New Orders</p>
            </div>
            <div class="icon">
              <i class="ion ion-bag"></i>
            </div>
            <a href="#" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
          </div>
        </div>
        <!-- ./col -->
        <div class="col-lg-3 col-xs-6">
          <!-- small box -->
          <div class="small-box bg-green">
            <div class="inner">
              <h3>0<sup style="font-size: 20px">%</sup></h3>

              <p>Bounce Rate</p>
            </div>
            <div class="icon">
              <i class="ion ion-stats-bars"></i>
            </div>
            <a href="#" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
          </div>
        </div>
        <!-- ./col -->
        <div class="col-lg-3 col-xs-6">
          <!-- small box -->
          <div class="small-box bg-yellow">
            <div class="inner">
              <h3>0</h3>

              <p>User Registrations</p>
            </div>
            <div class="icon">
              <i class="ion ion-person-add"></i>
            </div>
            <a href="#" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
          </div>
        </div>
        <!-- ./col -->
        <div class="col-lg-3 col-xs-6">
          <!-- small box -->
          <div class="small-box bg-red">
            <div class="inner">
              <h3>1</h3>

              <p>Unique Visitors</p>
            </div>
            <div class="icon">
              <i class="ion ion-pie-graph"></i>
            </div>
            <a href="#" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
          </div>
        </div>
        <!-- ./col -->
      </div>
         
         <br><br>
         <div class="row">
         
            <%
			String msql1 = " SELECT CHR_SHORTNAME from m_projectmodule where CHR_VISIBLE='Y' AND CHR_SHORTNAME='COM' ";
			String pmcom=CommonFunctions.QueryExecute(msql1)[0][0];
			if(pmcom.equals("COM"))
			{
			%>
			<div class="col-md-3 col-sm-6 col-xs-12">
              <div class="info-box bg-red">
                <span class="info-box-icon "><i class="ion ion-ios-gear-outline icon_documents_alt " ></i></span>
                <div class="info-box-content">
                 <span class="info-box-number" > <a href="Smart Common/Dashboard.jsp"><br><font color="#FFFFFF">Common</font></a>  </span>
                 </div><!-- /.info-box-content -->
              </div><!-- /.info-box -->
            </div><!-- /.col -->
			 <%
			}
			%>
			
            
			<%
			String msql2 = " SELECT CHR_SHORTNAME from m_projectmodule where CHR_VISIBLE='Y' AND CHR_SHORTNAME='HRM' ";
			String pmhrm =CommonFunctions.QueryExecute(msql2)[0][0];
			if(pmhrm.equals("HRM"))
			{
			%>
            <div class="col-md-3 col-sm-6 col-xs-12">
              <div class="info-box bg-yellow">
                <span class="info-box-icon"><i class="fa fa-google-plus icon_lightbulb_alt "></i></span>
                <div class="info-box-content">
                  <span class="info-box-number"><a href="Smart HRM/Dashboard.jsp"><br><font color="#FFFFFF">HRM</font></a></span>
                    
                </div><!-- /.info-box-content -->
              </div><!-- /.info-box -->
            </div><!-- /.col -->
        	<%
			}
			%>
           
		   
		   <%
		   	String msql3 = " SELECT CHR_SHORTNAME from m_projectmodule where CHR_VISIBLE='Y' AND CHR_SHORTNAME='ATT' ";
			String pmatt =CommonFunctions.QueryExecute(msql3)[0][0];
			if(pmatt.equals("ATT"))
			{
			%>
		   
            <div class="col-md-3 col-sm-6 col-xs-12">
              <div class="info-box bg-aqua"> 
                <span class="info-box-icon"><i class="ion ion-ios-cart-outline icon_clock_alt "></i></span>
                <div class="info-box-content">
                  <span class="info-box-number"><a href="Smart Attendance/Dashboard.jsp"><br><font color="#FFFFFF">Attendance</font></a></span>
                   
                </div><!-- /.info-box-content -->
              </div><!-- /.info-box -->
            </div><!-- /.col -->
            <%
			}
			%>
			
			<%
		   	String msql4 = " SELECT CHR_SHORTNAME from m_projectmodule where CHR_VISIBLE='Y' AND CHR_SHORTNAME='PAY' ";
			String pmpay =CommonFunctions.QueryExecute(msql4)[0][0];
			if(pmpay.equals("PAY"))
			{
			%>
			 <div class="col-md-3 col-sm-6 col-xs-12">
              <div class="info-box bg-blue">
                <span class="info-box-icon"><i class="ion ion-ios-people-outline icon_currency "></i></span>
                <div class="info-box-content">
                  <span class="info-box-number"><a href="Smart Payroll/Dashboard.jsp"><br><font color="#FFFFFF">Payroll</font></a></span>
                </div><!-- /.info-box-content -->
              </div><!-- /.info-box -->
            </div><!-- /.col -->
            <%
			}
			%>
			
			
          </div><!-- /.row -->
          
          <br> 
          
          
          
          
          <div class="row">
           
            <div class="col-md-3 col-sm-6 col-xs-12">
              <div class="info-box bg-light-blue">
                <span class="info-box-icon"><i class="fa fa-google-plus icon_balance "></i></span>
                <div class="info-box-content">
                  <span class="info-box-number"><a href="Smart Inventory/Main.jsp"><br><font color="#FFFFFF">Inventory</font></a></span>
                </div><!-- /.info-box-content -->
              </div><!-- /.info-box -->
            </div><!-- /.col -->
 

            <div class="col-md-3 col-sm-6 col-xs-12">
              <div class="info-box bg-maroon-active">
                <span class="info-box-icon"><i class="ion ion-ios-cart-outline icon_cart_alt "></i></span>
                <div class="info-box-content">
                  <span class="info-box-number"><a href="Smart Conveyance/Dashboard.jsp"><br><font color="#FFFFFF">Conveyance</font></a> </span>
                </div><!-- /.info-box-content -->
              </div><!-- /.info-box -->
            </div><!-- /.col -->
            
            <div class="col-md-3 col-sm-6 col-xs-12">
              <div class="info-box bg-teal">
                <span class="info-box-icon"><i class="ion ion-ios-people-outline icon_globe "></i></span>
                <div class="info-box-content">
                  <span class="info-box-number"><a href="Help/frame1.html"><br><font color="#FFFFFF">Help</font></a></span>
                </div><!-- /.info-box-content -->
              </div><!-- /.info-box -->
            </div><!-- /.col -->
            
             
            <div class="col-md-3 col-sm-6 col-xs-12">
              <div class="info-box bg-olive">
                <span class="info-box-icon"><i class="ion ion-ios-gear-outline icon_group "></i></span>
                <div class="info-box-content">
                  <span class="info-box-number"><a href="Smart Marketing/Dashboard.jsp"><br><font color="#FFFFFF">Marketing</font></a></span>
                </div><!-- /.info-box-content -->
              </div><!-- /.info-box -->
            </div><!-- /.col -->
            
          </div><!-- /.row -->
          
          <br> 
          
          <div class="row">
           
             <div class="col-md-3 col-sm-6 col-xs-12">
              <div class="info-box bg-lime">
                <span class="info-box-icon"><i class="ion ion-ios-cart-outline icon_like_alt "></i></span>
                <div class="info-box-content">
                  <span class="info-box-number"><a href="Smart Management/Dashboard.jsp"><br><font color="#FFFFFF">Management</font></a> </span>
                   
                </div><!-- /.info-box-content -->
              </div><!-- /.info-box -->
            </div><!-- /.col -->
            
            <div class="col-md-3 col-sm-6 col-xs-12">
              <div class="info-box bg-orange">
                <span class="info-box-icon"><i class="ion ion-ios-people-outline icon_grid-2x2 "></i></span>
                <div class="info-box-content">
                  <span class="info-box-number"><a href="Smart AMC/Main.jsp"><br><font color="#FFFFFF">CRM</font></a></span>
                   
                </div><!-- /.info-box-content -->
              </div><!-- /.info-box -->
            </div><!-- /.col -->
            
             
            <div class="col-md-3 col-sm-6 col-xs-12">
              <div class="info-box bg-purple-active">
                <span class="info-box-icon"><i class="ion ion-ios-gear-outline icon_chat "></i></span>
                <div class="info-box-content">
                  <span class="info-box-number"><a href="Smart SMS/Smsmain.jsp"><br><font color="#FFFFFF">SMS</font></a></span>
                  
                </div><!-- /.info-box-content -->
              </div><!-- /.info-box -->
            </div><!-- /.col -->
            
            
             <div class="col-md-3 col-sm-6 col-xs-12">
              <div class="info-box bg-maroon-active">
                <span class="info-box-icon"><i class="fa fa-google-plus fa-truck icon_compass_alt "></i></span>
                <div class="info-box-content">
                  <span class="info-box-number "><a href="Smart Transport/Transportmain.jsp"><br><font color="#FFFFFF">Transport</font></a></span>
                   
                </div><!-- /.info-box-content -->
              </div><!-- /.info-box -->
            </div><!-- /.col -->
 
          </div><!-- /.row -->
          
          <br><br>
          
          
          
           <div class="row">
            <div class="col-md-3 col-sm-6 col-xs-12">
              <div class="info-box">
                <span class="info-box-icon bg-black-active"><i class="ion ion-ios-people-outline icon_check_alt "></i></span>
                <div class="info-box-content">
                  <span class="info-box-number"><a href="Smart Servicereport/ServiceReportmain.jsp"><br><font color="#000000">Service Report</font></a></span>
                   
                </div><!-- /.info-box-content -->
              </div><!-- /.info-box -->
            </div><!-- /.col -->
            
             
            <div class="col-md-3 col-sm-6 col-xs-12">
              <div class="info-box bg-fuchsia-active">
                <span class="info-box-icon"><i class="ion ion-ios-gear-outline icon_blocked "></i></span>
                <div class="info-box-content">
                  <span class="info-box-number"><a href="Smart Debug/Debugmain.jsp"><br><font color="#FFFFFF">Debug</font></a></span>
                   
                </div><!-- /.info-box-content -->
              </div><!-- /.info-box -->
            </div><!-- /.col -->
            
            
             <div class="col-md-3 col-sm-6 col-xs-12">
              <div class="info-box bg-green">
                <span class="info-box-icon"><i class="fa fa-google-plus icon_cloud-upload "></i></span>
                <div class="info-box-content">
                  <span class="info-box-number"><a href="Smart UploadDownload/uploadMain.jsp"><br><font color="#FFFFFF">File upload</font></a></span>
                    
                </div><!-- /.info-box-content -->
              </div><!-- /.info-box -->
            </div><!-- /.col -->
 
 
             <div class="col-md-3 col-sm-6 col-xs-12">
              <div class="info-box bg-yellow-active">
                <span class="info-box-icon"><i class="ion ion-ios-cart-outline icon_lightbulb "></i></span>
                <div class="info-box-content">
                  <span class="info-box-number"><a href="Smart Training/TrainingMain.jsp"><br><font color="#FFFFFF">Training</font></a></span>
                </div><!-- /.info-box-content -->
              </div><!-- /.info-box -->
            </div><!-- /.col -->
            
           
          </div><!-- /.row -->
          
          <br><br>
          
          <div class="row">
            <div class="col-md-3 col-sm-6 col-xs-12">
              <div class="info-box bg-light-blue-active">
                <span class="info-box-icon"><i class="ion ion-ios-people-outline icon_tools "></i></span>
                <div class="info-box-content">
                  <span class="info-box-number"><a href="Utility/Utilitymain.jsp"><br><font color="#FFFFFF">Uitility</font></a></span>
                   
                </div><!-- /.info-box-content -->
              </div><!-- /.info-box -->
            </div><!-- /.col -->
            
           
            
            
            
           
          </div><!-- /.row -->
          
          
          <br><br>
            
           <%
		   	double target= MEAlertFuntion.METargetAlert(empid);
			double achieve= MEAlertFuntion.METargetCollection(empid) ;
			double percentage = (achieve/(target*100000) )*100;
			if(achieve>0)
			{
		   %> 
             
          <div class="row" align="center">
          	<center>
                    <div class="col-md-12 col-sm-12 col-xs-12 text-center">
                      <input type="text" class="knob" value="<%=(int)percentage%>" data-width="200" data-height="200"  data-fgColor="#953040" data-readonly="true"/>
                      <div class="knob-label"><h3>Employee Target : <%=target%>L  /  Acheive : <%=achieve%></h3></div>
                    </div>
            </center> 
           </div>
         
           <br><br>
           
           <%
			}
			%>
            
          


         
         </section>
         
     </div>
     <!-- /.content-wrapper -->












      <footer class="main-footer">
        
        <strong> &copy; &nbsp;2007 <a href="<%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_WEBSITE FROM m_company")[0][0] %>" target="_blank" style="text-decoration:none" class="style2">  <%=CommonFunctions.QueryExecute("SELECT CHR_NAME FROM m_company  WHERE INT_CPYID=1")[0][0]%>  </a>. &nbsp;&nbsp;</strong> All rights reserved.
    </footer>

  </div><!-- ./wrapper -->




    <!-- jQuery 2.1.3 -->
    <script src="plugins/jQuery/jQuery-2.1.3.min.js"></script>
    <!-- Bootstrap 3.3.2 JS -->
    <script src="bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <!-- AdminLTE App -->
    <script src="dist/js/app.min.js" type="text/javascript"></script>
 
     <!-- jQuery Knob -->
    <script src="plugins/knob/jquery.knob.js" type="text/javascript"></script>
  <!-- page script -->
    <script type="text/javascript">
      $(function () {
        /* jQueryKnob */

        $(".knob").knob({
          /*change : function (value) {
           //console.log("change : " + value);
           },
           release : function (value) {
           console.log("release : " + value);
           },
           cancel : function () {
           console.log("cancel : " + this.value);
           },*/
          draw: function () {

            // "tron" case
            if (this.$.data('skin') == 'tron') {

              var a = this.angle(this.cv)  // Angle
                      , sa = this.startAngle          // Previous start angle
                      , sat = this.startAngle         // Start angle
                      , ea                            // Previous end angle
                      , eat = sat + a                 // End angle
                      , r = true;

              this.g.lineWidth = this.lineWidth;

              this.o.cursor
                      && (sat = eat - 0.3)
                      && (eat = eat + 0.3);

              if (this.o.displayPrevious) {
                ea = this.startAngle + this.angle(this.value);
                this.o.cursor
                        && (sa = ea - 0.3)
                        && (ea = ea + 0.3);
                this.g.beginPath();
                this.g.strokeStyle = this.previousColor;
                this.g.arc(this.xy, this.xy, this.radius - this.lineWidth, sa, ea, false);
                this.g.stroke();
              }

              this.g.beginPath();
              this.g.strokeStyle = r ? this.o.fgColor : this.fgColor;
              this.g.arc(this.xy, this.xy, this.radius - this.lineWidth, sat, eat, false);
              this.g.stroke();

              this.g.lineWidth = 2;
              this.g.beginPath();
              this.g.strokeStyle = this.o.fgColor;
              this.g.arc(this.xy, this.xy, this.radius - this.lineWidth + 1 + this.lineWidth * 2 / 3, 0, 2 * Math.PI, false);
              this.g.stroke();

              return false;
            }
          }
        });
        /* END JQUERY KNOB */

        

      });
	  
	  
    </script>


	
  </body>
</html>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
	System.out.println(e.getMessage());
}
%>