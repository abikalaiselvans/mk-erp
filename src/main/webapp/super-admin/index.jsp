<%@ page import="com.my.org.erp.common.CommonFunctions"%> 
<%
try
{
String sql = "";
%>

<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Smart</title>

    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="css/sb-admin.css" rel="stylesheet">

    <!-- Morris Charts CSS -->
    <link href="css/plugins/morris.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="font-awesome-4.1.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body>

    <div id="wrapper">

        <!-- Navigation -->
        <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="index.jsp">Admin</a>
            </div>
            <!-- Top Menu Items -->
            <ul class="nav navbar-right top-nav">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-envelope"></i> <b class="caret"></b></a>
                    <ul class="dropdown-menu message-dropdown">
                        <li class="message-preview">
                            <a href="#">
                                
								<!--
								  Message inserted
								  <div class="media">
                                    <span class="pull-left">
                                        <img class="media-object" src="http://placehold.it/50x50" alt="">
                                    </span>
                                    <div class="media-body">
                                        <h5 class="media-heading"><strong></strong>
                                        </h5>
                                        <p class="small text-muted"><i class="fa fa-clock-o"></i> Yesterday at 4:32 PM</p>
                                        <p>Lorem ipsum dolor sit amet, consectetur...</p>
                                    </div>
                                </div>-->
                            </a>
                        </li>
                        
                        
                        <li class="message-footer">
                            <a href="#">Read All New Messages</a>
                        </li>
                    </ul>
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
					<i class="fa fa-bell"></i> <b class="caret"></b></a>
						<ul class="dropdown-menu alert-dropdown">
							<!--
							
							<li><a href="#">Alert Name <span class="label label-default">Alert Badge</span></a></li>
							<li><a href="#">Alert Name <span class="label label-primary">Alert Badge</span></a></li>
							<li><a href="#">Alert Name <span class="label label-success">Alert Badge</span></a></li>
							<li><a href="#">Alert Name <span class="label label-info">Alert Badge</span></a></li>
							<li><a href="#">Alert Name <span class="label label-warning">Alert Badge</span></a></li>
							-->
							
							<li><a href="#">Quotation <span class="label label-danger"><%=CommonFunctions.QueryExecute("SELECT COUNT(*) FROM inv_t_customerquotation WHERE CHR_STATUS='N'")[0][0]%></span></a></li>
							
							<li><a href="#">CPO Verification <span class="label label-danger"><%=CommonFunctions.QueryExecute("SELECT COUNT(*) FROM inv_t_customersalesorder WHERE CHR_VERIFICATIED='N'")[0][0]%></span></a></li>
							
							<li><a href="#">Un Billed <span class="label label-danger"><%=CommonFunctions.QueryExecute("SELECT COUNT(*) FROM inv_t_customersalesorder WHERE CHR_BILLED !='Y'")[0][0]%></span></a></li>
							
							<li><a href="#">PR Pending <span class="label label-danger"><%=CommonFunctions.QueryExecute("SELECT COUNT(*) FROM inv_t_purchaserequest WHERE CHR_APPROVEDSTATUS ='Y' AND CHR_CLOSEDSTATUS='N'")[0][0]%></span></a></li>
							
							<li class="divider"></li>
							<li><a href="#">View All</a><li>
						</ul>
					</li>
					
					
					
					
					
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i> <%= CommonFunctions.employeeName(""+session.getAttribute("EMPID") )%> <b class="caret"></b></a>
                   
				   
				    <ul class="dropdown-menu">
                        <!--
						<li><a href="#"><i class="fa fa-fw fa-user"></i> Profile</a></li>
                        <li><a href="#"><i class="fa fa-fw fa-envelope"></i> Inbox</a></li>
						-->
                        <li><a href="#"><i class="fa fa-fw fa-gear"></i> Settings</a></li>
                        <li class="divider"></li>
						<li><a href="../Logout.jsp"><i class="fa fa-fw fa-power-off"></i> Log Out</a></li>
                    </ul>
                </li>
            </ul>
			
			
            <!-- Sidebar Menu Items - These collapse to the responsive navigation menu on small screens -->
            <div class="collapse navbar-collapse navbar-ex1-collapse">
                <ul class="nav navbar-nav side-nav">
                    
					<li class="active"><a href="index.jsp"><i class="fa fa-fw fa-dashboard"></i> Dashboard</a></li>
                    <li><a href="charts.jsp"><i class="fa fa-fw fa-bar-chart-o"></i> Charts</a></li>
                    <li><a href="tables.jsp"><i class="fa fa-fw fa-table"></i> Tables</a></li>
                    <li><a href="bootstrap-elements.jsp"><i class="fa fa-fw fa-desktop"></i> Smart Elements</a></li>
                    
                    <li><a href="javascript:;" data-toggle="collapse" data-target="#demo">
						<i class="fa fa-fw fa-arrows-v"></i> HR & Payroll <i class="fa fa-fw fa-caret-down"></i></a>
                        <ul id="demo" class="collapse">
                            <li><a href="#">Staff Verification</a></li>
                            <li><a href="#">Staff Informations</a></li>
							<li><a href="#">Staff Advacne</a></li>
							<li><a href="#">Staff Bank</a></li>
							<li><a href="#">Staff Aset</a></li>
                        </ul>
                    </li>
                    
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </nav>

        <div id="page-wrapper">

            <div class="container-fluid">

                <!-- Page Heading -->
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">
                            Dashboard 
                        </h1>
                        
                    </div>
                </div>
                <!-- /.row -->

                <div class="row">
                     
                </div>
                <!-- /.row -->

                <div class="row">
                    <div class="col-lg-3 col-md-6">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-comments fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <%
										if(!"0".equals(CommonFunctions.QueryExecute("SELECT COUNT(*) FROM inv_t_customerquotation WHERE CHR_STATUS='N'")[0][0]))
										{
											out.println("<div class='huge'>"+CommonFunctions.QueryExecute("SELECT COUNT(*) FROM inv_t_customerquotation WHERE CHR_STATUS='N'")[0][0]+"</div>");
											out.println("<div>Quotations waiting</div>");
										}
										else
										{
											out.println("<div class='huge'>0</div>");
											out.println("<div>&nbsp;</div>");
										}
										%>
										
										 
                                        
                                    </div>
                                </div>
                            </div>
                            <a href="#">
                                <div class="panel-footer">
                                    <span class="pull-left">View Details</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
					
					
					
					
					
                    <div class="col-lg-3 col-md-6">
                        <div class="panel panel-green">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-tasks fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
									
									<%
										if(!"0".equals(CommonFunctions.QueryExecute("SELECT COUNT(*) FROM inv_t_customersalesorder WHERE CHR_VERIFICATIED='N'")[0][0]))
										{
											out.println("<div class='huge'>"+CommonFunctions.QueryExecute("SELECT COUNT(*) FROM inv_t_customersalesorder WHERE CHR_VERIFICATIED='N'")[0][0]+"</div>");
											out.println("<div>CPO Verification Pending</div>");
										}
										else
										{
											out.println("<div class='huge'>0</div>");
											out.println("<div>&nbsp;</div>");
										}
										%>
										
										
									
                                         
                                    </div>
                                </div>
                            </div>
                            <a href="#">
                                <div class="panel-footer">
                                    <span class="pull-left">View Details</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
					
					
					
					
                    <div class="col-lg-3 col-md-6">
                        <div class="panel panel-yellow">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-shopping-cart fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
									<%
										if(!"0".equals(CommonFunctions.QueryExecute("SELECT COUNT(*) FROM inv_t_customersalesorder WHERE CHR_BILLED !='Y'")[0][0]))
										{
											out.println("<div class='huge'>"+CommonFunctions.QueryExecute("SELECT COUNT(*) FROM inv_t_customersalesorder WHERE CHR_BILLED !='Y'")[0][0]+"</div>");
											out.println("<div>CPO Billing Pending</div>");
										}
										else
										{
											out.println("<div class='huge'>0</div>");
											out.println("<div>&nbsp;</div>");
										}
										%>
										
                                         
                                    </div>
                                </div>
                            </div>
                            <a href="#">
                                <div class="panel-footer">
                                    <span class="pull-left">View Details</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
					
					
					
                    <div class="col-lg-3 col-md-6">
                        <div class="panel panel-red">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-support fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <%
										if(!"0".equals(CommonFunctions.QueryExecute("SELECT COUNT(*) FROM inv_t_purchaserequest WHERE CHR_APPROVEDSTATUS ='Y' AND CHR_CLOSEDSTATUS='N'")[0][0]))
										{
											out.println("<div class='huge'>"+CommonFunctions.QueryExecute("SELECT COUNT(*) FROM inv_t_purchaserequest WHERE CHR_APPROVEDSTATUS ='Y' AND CHR_CLOSEDSTATUS='N'")[0][0]+"</div>");
											out.println("<div>PR Finance Pending</div>");
										}
										else
										{
											out.println("<div class='huge'>0</div>");
											out.println("<div>&nbsp;</div>");
										}
										%>
                                    </div>
                                </div>
                            </div>
                            <a href="#">
                                <div class="panel-footer">
                                    <span class="pull-left">View Details</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>
                <!-- /.row -->


 
				
				
				
				
				
				

                <div class="row">
                 	
				   
				   
                    <div class="col-lg-4">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title"><i class="fa fa-clock-o fa-fw"></i> Tasks Panel</h3>
                            </div>
                            <div class="panel-body">
                                <div class="list-group">
                                   
                                    <a href="#" class="list-group-item">
                                        <span class="badge">To day</span>
                                        <i class="fa fa-fw fa-comment"></i> Staff Verification
                                    </a> 
                                    <a href="#" class="list-group-item">
                                        <span class="badge">23 minutes ago</span>
                                        
                                        
                                        <i class="fa fa-fw fa-truck"></i> Permission & Leave grant
                                    </a>
                                    <a href="#" class="list-group-item">
                                        <span class="badge">46 minutes ago</span>
                                        <i class="fa fa-fw fa-money"></i> Employee Advance
                                    </a>
                                    <a href="#" class="list-group-item">
                                        <span class="badge">1 hour ago</span>
                                        <i class="fa fa-fw fa-user"></i> Buy Back Invoice
                                    </a>
                                    <a href="#" class="list-group-item">
                                        <span class="badge">2 hours ago</span>
                                        <i class="fa fa-fw fa-check"></i> Today commitment
                                    </a>
                                    <a href="#" class="list-group-item">
                                        <span class="badge">yesterday</span>
                                        <i class="fa fa-fw fa-globe"></i> Stock Receiving
                                    </a>
                                    <a href="#" class="list-group-item">
                                        <span class="badge">two days ago</span>
                                        <i class="fa fa-fw fa-check"></i> Customer Verification
                                    </a>
									<a href="#" class="list-group-item">
                                        <span class="badge">two days ago</span>
                                        <i class="fa fa-fw fa-check"></i> Payment Pending
                                    </a>
									
									<a href="#" class="list-group-item">
                                        <span class="badge">two days ago</span>
                                        <i class="fa fa-fw fa-check"></i> Account not receive the purchase invoice
                                    </a>
									
									<a href="#" class="list-group-item">
                                        <span class="badge">two days ago</span>
                                        <i class="fa fa-fw fa-check"></i> PR Stock Approval
                                    </a>
									
									<a href="#" class="list-group-item">
                                        <span class="badge">two days ago</span>
                                        <i class="fa fa-fw fa-check"></i> PR Finance Approval
                                    </a>
									
									<a href="#" class="list-group-item">
                                        <span class="badge">two days ago</span>
                                        <i class="fa fa-fw fa-check"></i> Sale order Approval
                                    </a>
									
									<a href="#" class="list-group-item">
                                        <span class="badge">two days ago</span>
                                        <i class="fa fa-fw fa-check"></i> DC not close
                                    </a>
									
                                </div>
                                <div class="text-right">
                                    <a href="#">View All Activity <i class="fa fa-arrow-circle-right"></i></a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title"><i class="fa fa-money fa-fw"></i> Out Standing</h3>
                            </div>
                            <div class="panel-body">
                                <div class="table-responsive">
                                    
<%
sql = "SELECT    ";
sql = sql + " d.CHR_DIVICODE,    ";
sql = sql + " SUM(a.DOU_TOTALAMOUNT- FUN_GET_PAIDAMOUNT(a.CHR_SALESNO)) balance ,   ";
sql = sql + " ROUND((SUM(a.DOU_TOTALAMOUNT- FUN_GET_PAIDAMOUNT(a.CHR_SALESNO))/100000),2) inlakhs    ";
sql = sql + " from inv_t_directsales a ,inv_m_customerinfo b ,com_m_staff c ,inv_m_division d,    ";
sql = sql + " inv_t_paymentcommitment g      ";
sql = sql + " WHERE a.CHR_PAYMENTSTATUS !='Y'    AND a.CHR_CANCEL='N'    ";
sql = sql + " AND a.CHR_SALESNO = g.CHR_SALESNO    ";
sql = sql + " AND g.CHR_INVOICETYPE='C'    ";
sql = sql + " AND a.INT_SALESSTATUS=1    ";
sql = sql + " AND a.CHR_PAYMENTSTATUS !='S'     ";
sql = sql + " AND a.INT_CUSTOMERID = b.INT_CUSTOMERID    ";
sql = sql + " AND a.CHR_REF = c.CHR_EMPID    ";
sql = sql + " AND a.INT_DIVIID=d.INT_DIVIID    ";
sql = sql + " AND datediff(now(),a.DAT_SALESDATE)>=25     ";
sql = sql + " GROUP BY a.INT_DIVIID ORDER BY  d.CHR_DIVICODE  ";
String Adata[][] =CommonFunctions.QueryExecute(sql);
if(Adata.length>0)
{
	out.println("<table class='table table-bordered table-hover table-striped'>");
	out.println("<thead>");
	out.println("<tr>");
	out.println("<th><center>S.No</center></th>");
	out.println("<th><center>Division</center></th>");
	out.println("<th><center>Balance</center></th>");
	out.println("<th><center>In lakhs</center></th>");
	out.println("</tr>");
	out.println("</thead>");
	out.println("<tbody>");
	for(int u=0;u<Adata.length;u++)
	{
		out.println("<tr>");
		out.println("<td>"+(u+1)+".</td>");
		out.println("<td>"+Adata[u][0]+"</td>");
		out.println("<td align='right'>"+Adata[u][1]+"</td>");
		out.println("<td align='right'>"+Adata[u][2]+"</td>");
		out.println("</tr>");
	}
	out.println("</tbody>");	
	out.println("</table>");
}		 		 
		 
									%>
									 
                                </div>
                                <div class="text-right">
                                    <a href="#">View All Transactions <i class="fa fa-arrow-circle-right"></i></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                     
				
				
				 


                
                <!-- /.row -->
				
				
				

            </div>
            <!-- /.container-fluid -->

        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->

    <!-- jQuery Version 1.11.0 -->
    <script src="js/jquery-1.11.0.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>

    <!-- Morris Charts JavaScript -->
    <script src="js/plugins/morris/raphael.min.js"></script>
    <script src="js/plugins/morris/morris.min.js"></script>
  <script src="js/plugins/morris/Area-data.js"></script>
 
</body>

</html>

<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>
