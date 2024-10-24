<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<jsp:useBean id="conbean1" class="DBConnection.DBCon" />
 
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SB Admin - Bootstrap Admin Template</title>

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

    <div id="wrapper"  style="OVERFLOW:auto;" >

        
        <!-- Navigation -->
        <nav class="navbar navbar-inverse navbar-fixed-top " role="navigation">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <a class="navbar-brand" href="index.html">SB Admin</a>
            </div>
            
            <!-- Top Menu Items -->
            <ul class="nav navbar-right top-nav">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-envelope">kalaiselvan</i> <b class="caret"></b></a>
                   
                        <ul class="dropdown-menu message-dropdown">
                            <li class="message-preview">
                                <a href="#"> <div class="media">
                                        <span class="pull-left">
                                            <img class="media-object" src="http://placehold.it/50x50" alt="">
                                        </span>
                                        <div class="media-body">
                                            <h5 class="media-heading"><strong>John Smith</strong>
                                            </h5>
                                            <p class="small text-muted"><i class="fa fa-clock-o"></i> Yesterday at 4:32 PM</p>
                                            <p>Lorem ipsum dolor sit amet, consectetur...</p>
                                        </div>
                                    </div>
                                </a>
                            </li>
                            <li class="message-preview">
                                <a href="#">
                                    <div class="media">
                                        <span class="pull-left">
                                            <img class="media-object" src="http://placehold.it/50x50" alt="">
                                        </span>
                                        <div class="media-body">
                                            <h5 class="media-heading"><strong>John Smith</strong>
                                            </h5>
                                            <p class="small text-muted"><i class="fa fa-clock-o"></i> Yesterday at 4:32 PM</p>
                                            <p>Lorem ipsum dolor sit amet, consectetur...</p>
                                        </div>
                                    </div>
                                </a>
                            </li>
                            <li class="message-preview">
                                <a href="#">
                                    <div class="media">
                                        <span class="pull-left">
                                            <img class="media-object" src="http://placehold.it/50x50" alt="">
                                        </span>
                                        <div class="media-body">
                                            <h5 class="media-heading"><strong>John Smith</strong>
                                            </h5>
                                            <p class="small text-muted"><i class="fa fa-clock-o"></i> Yesterday at 4:32 PM</p>
                                            <p>Lorem ipsum dolor sit amet, consectetur...</p>
                                        </div>
                                    </div>
                                </a>
                            </li>
                        <li class="message-footer"><a href="#">Read All New Messages</a></li>
                    	</ul>
                    </li>
                    
                   <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-bell"></i> <b class="caret"></b></a>
                        <ul class="dropdown-menu alert-dropdown">
                            <li><a href="#">Alert Name <span class="label label-default">Alert Badge</span></a></li>
                            <li><a href="#">Alert Name <span class="label label-primary">Alert Badge</span></a></li>
                            <li><a href="#">Alert Name <span class="label label-success">Alert Badge</span></a></li>
                            <li><a href="#">Alert Name <span class="label label-info">Alert Badge</span></a></li>
                            <li><a href="#">Alert Name <span class="label label-warning">Alert Badge</span></a></li>
                            <li><a href="#">Alert Name <span class="label label-danger">Alert Badge</span></a></li>
                            <li class="divider"></li>
                            <li><a href="#">View All</a></li>
                        </ul>
                	</li>
                    
                    
                    
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i> John Smith <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="#"><i class="fa fa-fw fa-user"></i> Profile</a></li>
                            <li><a href="#"><i class="fa fa-fw fa-envelope"></i> Inbox</a></li>
                            <li><a href="#"><i class="fa fa-fw fa-gear"></i> Settings</a></li>
                            <li class="divider"></li>
                            <li><a href="#"><i class="fa fa-fw fa-power-off"></i> Log Out</a></li>
                        </ul>
                    </li>
            </ul>
            
            
            
            <!-- Sidebar Menu Items - These collapse to the responsive navigation menu on small screens -->
            <div class="collapse navbar-collapse navbar-ex1-collapse"  >
                <ul class="nav navbar-nav side-nav" style="OVERFLOW:auto;" >
                   
                    
                    
                    <%
		Connection con ;
		Statement st=null; 
		ResultSet rs;
		ResultSet rsMenu;
		String str=null;
		String url=null;
		String mnuList=null;
		boolean closetag=false;
		boolean subclosetag=false;
		String lastmname=null;
		int norootmenu=0;
		int top=0;
		int left=0;
		int dynwidth=0;
 
 		 con =conbean1.getConnection();
 		 st=con.createStatement(); 
		 str="select CHR_MENUINVENTORY from  m_user  where CHR_USRNAME='ADMIN'" ;
	     rs=st.executeQuery(str); 
	     if(rs.next())
	     {		
		 	 boolean currentflag = false;
			 boolean nextflag = false;
			  
		 	  
	    	 mnuList=rs.getString("CHR_MENUINVENTORY");
		     str="Select * from  m_menu_inventory  where  INT_MENUID >0 AND INT_MENUID in ("+mnuList+") order by INT_MENUID";
		     rsMenu=st.executeQuery(str);
			 String s ="";
			 boolean first = true;
			 int h=0;
		     while(rsMenu.next())
			 {		    	 		 
	       		 String mnuType=rsMenu.getString("CHR_MENUDES");
				
	       		 str=(rsMenu.getString("CHR_MENUNAME")).toUpperCase();
	       		 if(mnuType.equals("Root"))
				 {
				 	currentflag = true;
					 h = h+1;
				 }
				 else 
	       		 	currentflag = false;
	       		
				 
				 if(!rsMenu.isLast())
				 {	 
	       		 	rsMenu.next();
				    mnuType=rsMenu.getString("CHR_MENUDES");
				  	if(mnuType.equals("Root"))
				 		nextflag = true;
				 	else 
	       		 		nextflag = false;
 				 }	
 				  
				 if(currentflag && nextflag)  
				 	out.println("\n <li> <a href='javascript:;' data-toggle='collapse' data-target='#demo"+h+"'><i class='fa fa-fw fa-arrows-v'></i> "+str+" <i class='fa fa-fw fa-caret-down'></i></a></li>");
				 else if(currentflag && nextflag == false)  
				 	out.println("\n <li> <a href='javascript:;' data-toggle='collapse' data-target='#demo"+h+"'><i class='fa fa-fw fa-arrows-v'></i> "+str+" <i class='fa fa-fw fa-caret-down'></i></a>");
				 
				 if(currentflag == false && nextflag == false)  
				 	s = s + "\n <li><a href='"+rsMenu.getString("CHR_URL")+"'>"+str+"</a></li> ";
				 
				 
				 
				 
				 
				 if( (currentflag == false && nextflag  )  || rsMenu.isLast() )
				 {
				 	if(!rsMenu.isLast())
					{
						s = s + "\n <li><a href='"+rsMenu.getString("CHR_URL")+"'>"+str+"</a></li> ";
						out.println("\n<ul  id='demo"+h+"' class='collapse'>"+s+"</ul>");
						s="";
					}
					else
					{
						out.println("\n<ul   id='demo"+h+"' class='collapse'>"+s+"</ul>");	
					}
				 }	
				 
				  
				   
				  if(!rsMenu.isLast())
				 	rsMenu.previous();
				  
				  	
		     }
		      
	     }
%> 
                    </li>
                    
                
                  
                    
                    <li><a href="blank-page.html"><i class="fa fa-fw fa-file"></i> Blank Page</a></li>
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
                            Dashboard <small>Statistics Overview</small>
                        </h1>
                        <ol class="breadcrumb">
                            <li class="active">
                                <i class="fa fa-dashboard"></i> Dashboard
                            </li>
                        </ol>
                    </div>
                </div>
                <!-- /.row -->

                <div class="row">
                    <div class="col-lg-12">
                        <div class="alert alert-info alert-dismissable">
                            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                            <i class="fa fa-info-circle"></i>  <strong>Like SB Admin?</strong> Try out <a href="http://startbootstrap.com/template-overviews/sb-admin-2" class="alert-link">SB Admin 2</a> for additional features!
                        
                        <%
						for(int u=0;u<50;u++)
							out.println("<br>");
						%>
                        
                        </div>
                    </div>
                </div>
                <!-- /.row -->
 
              

             

            </div>
            <!-- /.container-fluid -->


 <%
						for(int u=0;u<50;u++)
							out.println("<br>");
						%>
        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->

    <!-- jQuery Version 1.11.0 -->
    <script src="js/jquery-1.11.0.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>

    

</body>

</html>
