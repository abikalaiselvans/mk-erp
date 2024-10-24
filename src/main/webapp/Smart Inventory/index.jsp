<%
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", -1);
response.setHeader("Cache-Control", "no-store");
 
String sesUserName=(""+session.getAttribute("USRID")).trim(); 
String EMPID=""+session.getAttribute("EMPID"); 
if("null".equalsIgnoreCase(sesUserName) ||  sesUserName.equals("")) 
{

		response.sendRedirect("../Login.jsp?loginmsg=Login Expired");
		//RequestDispatcher dispatchers = request.getRequestDispatcher("../Login.jsp?loginmsg=Login Expired");
		//dispatchers.forward(request, response); 
}

if( "S".equals(""+session.getAttribute("USRTYPE"))) 
		response.sendRedirect("../Login.jsp?loginmsg=Login Expired");
 %>

<!-- site css -->
    <link rel="stylesheet" href="../dist/css/site.min.css">
     
 
    <!--nav-->
    <nav role="navigation" class="navbar navbar-custom">
        <div class="container-fluid">
          <!-- Brand and toggle get grouped for better mobile display -->
          <div class="navbar-header"><img src="../dist/img/top_banner.png"/></div>

          <div id="bs-content-row-navbar-collapse-5" class="collapse navbar-collapse">
            <ul class="nav navbar-nav navbar-right">
             	
	
			</ul>
			</div>
			
        </div>
      </nav>
    <!--header-->
	 
    <!--documents-->

		<div class="row">
			
			<div class="container">
			<!--Row with two equal columns-->
			<div class="row">
				<div class="col-md-3"><h4>INVENTORY</h4></div>
				<div class="col-md-6"><h4>Welcome :: <%=com.my.org.erp.common.CommonFunctions.employeeName(""+session.getAttribute("EMPID") )%></h4></div>
				<div class="col-md-3"><span class="text-right">
				<a href="../chat/login.jsp" target="_blank" ><font class="boldEleven"><b>Chat</b></font></a>&nbsp;|&nbsp;
				<a href="../Smart Help/helpmain.jsp" target="_blank" ><font class="boldEleven"><b>Help</b></font></a>&nbsp;|&nbsp;
				<a href="mailto:<%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MAILID FROM  m_institution WHERE INT_ID=1")[0][0]%>"><font class="boldEleven"><b>Mail</b></font></a>&nbsp;|&nbsp;
				<a href="../Home.jsp" target="_parent"><font class="boldEleven"><b>Home</b></font></a> &nbsp;|&nbsp;
				<a href="../Logout.jsp" target="_parent"><font class="boldEleven"><b>Logout</b></font></a> </span>
				</div>
			</div>
				 
			</div>
		</div>
 
	
  

 
  