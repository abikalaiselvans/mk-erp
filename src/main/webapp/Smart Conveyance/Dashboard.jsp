<!DOCTYPE html>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<html>
  <head>
    <meta charset="utf-8">
    <title>:: Dash Board ::</title>
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no">
    <link rel="shortcut icon" href="favicon_16.ico"/>
    <link rel="bookmark" href="favicon_16.ico"/>
    <!-- site css -->
    <link rel="stylesheet" href="../dist/css/site.min.css">
    <link href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,800,700,400italic,600italic,700italic,800italic,300italic" rel="stylesheet" type="text/css">
    <!-- <link href='http://fonts.googleapis.com/css?family=Lato:300,400,700' rel='stylesheet' type='text/css'> -->
    <!-- HTML5 shim, for IE6-8 support of HTML5 elements. All other JS at the end of file. -->
    <!--[if lt IE 9]>
      <script src="js/html5shiv.js"></script>
      <script src="js/respond.min.js"></script>
    <![endif]-->
    <script type="text/javascript" src="../dist/js/site.min.js"></script>
  </head>
  <body>
    <!--nav-->
    <nav role="navigation" class="navbar navbar-custom">
        <div class="container-fluid">
          <!-- Brand and toggle get grouped for better mobile display -->
          <div class="navbar-header">
           
            <img src='../images/top_banner.png'/>
          </div>

          <!-- Collect the nav links, forms, and other content for toggling -->
          <div id="bs-content-row-navbar-collapse-5" class="collapse navbar-collapse">
            <ul class="nav navbar-nav navbar-right">
              <li class="active"><a href="../sadmin.jsp">Home</a></li>
              <li class="active"><a href="../Logout.jsp">Signout</a></li>
             
            </ul>

          </div><!-- /.navbar-collapse -->
        </div><!-- /.container-fluid -->
      </nav>
    <!--header-->
    <div class="container-fluid">
    <!--documents-->
	
	
         <!--<div class="row row-offcanvas row-offcanvas-left">-->
          <!--<div class="col-xs-6 col-sm-3 sidebar-offcanvas" role="navigation"></div> -->
		  
		  
          <div class="col-xs-12 col-sm-12 content">
            <div class="panel panel-default">
              <div class="panel-heading">
                <h3 class="panel-title"></h3>
              </div>
              <div class="panel-body">
               



<center>				 <div class="content-row">
                    <h2 class="content-row-title">CONVEYANCE</h2>
                    <div class="row">
					
					<%
					String csql ="";
					csql = csql + " SELECT CONCAT(MONTHNAME(DAT_CONDATE),'-',YEAR(DAT_CONDATE)),COUNT(*),  ";
					csql = csql + " sum(DOU_TRAVEL),sum(DOU_TRAIN),sum(DOU_AUTO),sum(DOU_LUNCH),sum(DOU_TELEPHONE), sum(DOU_OTHERAMT), ";
					csql = csql + " SUM(DOU_TOTAL) from conveyance_t_conveyance WHERE CHR_ACCEPT='Y' AND CHR_STATUS='Y'  ";
					csql = csql + " GROUP BY  MONTH(DAT_CONDATE),YEAR(DAT_CONDATE) ";
					csql = csql + " ORDER BY MONTH(DAT_CONDATE),YEAR(DAT_CONDATE)  ";
					csql = csql + " LIMIT 0,3 ";
					String checkdata[][]= CommonFunctions.QueryExecute(csql);
					if(checkdata.length>0)
					{
						out.println("<div class='col-md-12'>");
						out.println("<div class='pricing'>");
						out.println("<ul>");
						for(int i=0;i<checkdata.length;i++)
						{
							if(i%2==0)
								out.println("<li class='unit price-success active'>");
							else if(i%3==0)
								out.println("<li class='unit price-warning'>");
							else
								out.println("<li class='unit price-primary'>");
							out.println("<div class='price-title'><h3>"+checkdata[i][8]+"</h3><p>"+checkdata[i][0]+"</p></div>");
							out.println("<div class='price-body'><h4>Recrd counts</h4> <p>"+checkdata[i][1]+"nos</p>");
							out.println("<ul>");
							out.println("<li>Travel:"+checkdata[i][2]+"</li>");
							out.println("<li>Train:"+checkdata[i][3]+"</li>");
							out.println("<li>Auto:"+checkdata[i][4]+"</li>");
							out.println("<li>Lunch:"+checkdata[i][5]+"</li>");
							out.println("<li>Telephone:"+checkdata[i][6]+"</li>");
							out.println("<li>Others:"+checkdata[i][7]+"</li>");
							out.println("</ul>");
							out.println("</div>");
							out.println("<div class='price-foot'>");
							out.println("<button type='button' class='btn btn-primary'>View</button>");
							out.println("</div>");
							out.println("</li>");	
							out.println("");
							out.println("");
							out.println("");	
					 
						}
						out.println(" </ul>");
						out.println("</div>");
						out.println("</div>");
					}
					%>

                      
                </div>
                </div>

</center>


<div class="col-md-12"><a href='Conveyancemain.jsp'><button type="button" class="btn btn-info btn-block" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Tooltip on bottom">Getting Stated</button></a>
                                <br>
                              </div>
							  
							  


              </div><!-- panel body -->
            </div>
        </div><!-- content -->
      <!--leftpanel  </div> -->
    </div>
	
    <!--footer-->
    <div class="site-footer">
      <div class="container"></div>
    </div>
	
  </body>
</html>
