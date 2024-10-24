<!DOCTYPE html>

<%@ page import="java.util.*,java.io.*,java.net.*,com.my.org.erp.common.*" errorPage="error.jsp"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="com.my.org.erp.alert.*"%>
<%
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", -1);
response.setHeader("Cache-Control", "no-store");
String empid=""+session.getAttribute("EMPID"); 
 
try
{
	
	if("1".equals(CommonFunctions.QueryExecute("SELECT FUN_WEDDINGDATE(FIND_WEDDINGDATE())")[0][0]))
		response.sendRedirect("Logout.jsp");


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
        <a href="sadmin.jsp" class="logo"><b>ERP</b></a>
       
       
       
        
          
          
        <!-- Header Navbar: style can be found in header.less -->
        <nav class="navbar navbar-static-top" role="navigation">
         
         
          <!-- Sidebar toggle button-->
          <span  data-toggle="offcanvas"class="icon_pushpin"></span> 
          
          
          
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
                   <li class="user-footer">
                    <div class="pull-left">
                      <a href="#" class="btn btn-default btn-flat">Profile</a>
                    </div>
                    <div class="pull-right">
                      <a href="Logout.jsp" class="btn btn-default btn-flat">Sign out</a>
                    </div>
                  </li>
                  
                </ul>
              </li>
            </ul>
          </div>
        </nav>
      </header>
      
      
      
      
      <!-- Left side column. contains the logo and sidebar -->
      <aside class="main-sidebar">
        <jsp:include page="sscrollmenu.jsp" />
      </aside>






      <!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper">
       <!-- Main content -->
         <section class="content">
             
              <div class="row">
                    <div class="col-lg-12">
                        <h2>CURRENT MONTH CONVEYANCE</h2>
                        <div class="table-responsive"  style="OVERFLOW:auto;width:100%;">
<%
String sql = "";
sql = sql + " ( ";
sql = sql + " SELECT  FIND_A_EMPLOYEE_ID_NAME(a.CHR_EMPID) ME,FUN_GET_OFFICENAME(b.INT_OFFICEID) Office, SUM(a.DOU_TRAVEL), ";
sql = sql + "  SUM(a.DOU_TRAIN),SUM(a.DOU_AUTO),SUM(a.DOU_LUNCH), ";
sql = sql + " SUM(a.DOU_TELEPHONE),SUM(a.DOU_OTHERAMT),SUM(a.DOU_TOTAL) , ";
sql = sql + " ROUND(FUN_PAY_GET_ORIGINAL_CTC(a.CHR_EMPID),0) ctc ";
sql = sql + " FROM conveyance_t_conveyance  a , com_m_staff b  ";
sql = sql + " WHERE a.CHR_EMPID = b.CHR_EMPID AND a.CHR_STATUS ='Y' AND a.CHR_STATUS='Y' ";
sql = sql + " AND MONTHNAME(NOW())= MONTHNAME(a.DAT_CONDATE)   ";
sql = sql + " AND YEAR(NOW()) = YEAR(a.DAT_CONDATE)  ";
sql = sql + " GROUP BY a.CHR_EMPID ";
sql = sql + " ) ";
sql = sql + " UNION ";
sql = sql + " ( ";
sql = sql + " SELECT  CONCAT('TOTAL'), CONCAT(''),SUM(a.DOU_TRAVEL), SUM(a.DOU_TRAIN),SUM(a.DOU_AUTO),SUM(a.DOU_LUNCH), ";
sql = sql + " SUM(a.DOU_TELEPHONE),SUM(a.DOU_OTHERAMT),SUM(a.DOU_TOTAL) , CONCAT('') ";
sql = sql + " FROM conveyance_t_conveyance  a , com_m_staff b  ";
sql = sql + " WHERE a.CHR_EMPID = b.CHR_EMPID  AND a.CHR_STATUS ='Y' AND a.CHR_STATUS='Y' ";
sql = sql + " AND MONTHNAME(NOW())= MONTHNAME(a.DAT_CONDATE)   ";
sql = sql + " AND YEAR(NOW()) = YEAR(a.DAT_CONDATE)  ";
sql = sql + " ) ";
String edata[][] = CommonFunctions.QueryExecute(sql);
if(edata.length>0)
{
	out.println("<table class='table table-bordered table-hover table-striped'>");
	out.println("<thead>");
	out.println("<tr>");
	out.println("<th align='center'>S.NO</th>");
	out.println("<th align='center'>ME</th>");
	out.println("<th align='center'>OFFICE</th>");
	out.println("<th align='center'>TRAVEL</th>");
	out.println("<th align='center'>TRAIN</th>");
	out.println("<th align='center'>AUTO</th>");
	out.println("<th align='center'>LUNCH</th>");
	out.println("<th align='center'>TELEPHONE</th>");
	out.println("<th align='center'>OTHER AMOUNT</th>");
	out.println("<th align='center'>TOTAL</th>");
	out.println("<th align='center'>CTC</th>");
	out.println("</tr>");
	out.println("</thead>");
	
	out.println("<tbody>");
	for(int u=0;u<edata.length;u++)
	{
		if(u%2==0)
			out.println("<tr class='active'>");
		else
			out.println("<tr class='success'>");	
		out.println("<td>"+(u+1)+".</td>");
		out.println("<td>"+edata[u][0]+"</td>");
		out.println("<td>"+edata[u][1]+"</td>");
		out.println("<td align='right'>"+edata[u][2]+"</td>");
		out.println("<td align='right'>"+edata[u][3]+"</td>");
		out.println("<td align='right'>"+edata[u][4]+"</td>");
		out.println("<td align='right'>"+edata[u][5]+"</td>");
		out.println("<td align='right'>"+edata[u][6]+"</td>");
		out.println("<td align='right'>"+edata[u][7]+"</td>");
		out.println("<td align='right'>"+edata[u][8]+"</td>");
		out.println("<td align='right'>"+edata[u][9]+"</td>");
		out.println("</tr>");
	}
	
	out.println("</tbody>");
	out.println("</table>");
	
}
else
	out.println("<center><h1><font color='red'>Funnel not found...</font></h1></center>");

 						%>
                                  
                        </div>
                    </div>
                    
                </div>
                <!-- /.row -->
                
         
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