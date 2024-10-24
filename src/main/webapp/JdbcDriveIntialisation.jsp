<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<html>
<head>
<link rel="icon" type="image/ico" href="images/ERP.ico"></link>
<link rel="shortcut icon" href="images/ERP.ico"></link>



<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

<title>:: Properties File Intialization :: </title>
 
<script language="javascript" src="JavaScript/comfunction.js"></script>
<script type="text/javascript" language="javascript">
	function validate()
	{
		 
		if( 
			checkNull('driver','Enter Driver Name!!!') 
			&& checkNull('url','Enter URL!!!') 
			&& checkNull('username','Enter User Name!!!') 
		    && checkNull('password','Enter Password!!!')
			&& checkNull('dbname','Enter dbname!!!')
			&& checkNull('exportpath','Enter exportpath!!!')
			&& checkNull('jdkpath','Enter jdkpath!!!')
			&& checkNull('mysqlpath','Enter mysqlpath!!!')
			&& checkNull('exportpath','Enter exportpath!!!')
			&& checkNull('hostname','Enter hostname!!!')
			&& checkNull('code','Enter Secret code!!!')
			&& checkNull('licence','Enter the licence!!!')
			 
			)
			return true;
		else
			return false;
			

	}
</script>
<link href="resources/css/erp_smart.css" rel="stylesheet" type="text/css">
  <%@ include file="JavaScript/dynamicStylesheet.jsp" %>
  <link href="JavaScript/SmartStyles.css" rel="stylesheet" type="text/css">
</head>

<body  onpaste='return false;'>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td> 
<table width="100%" border="0" cellspacing="0" cellpadding="0"  id="header"> 
  <tr  class="headerImgBackground" >
    <td><div align="right"><img src="images/top_banner.png"  height="62" /></div></td>
  </tr>
  <tr>
    <td><table width="100%" height="25" border="0" cellpadding="0" cellspacing="0">
          <tr   class="headerBackground" >
            <td width="183" height="25" align="center" valign="middle"><span class="menu_H">ERP </span></td>
            <td width="287" class="text_0"> </td>
            <td width="360" align="right"   class="headerBackground" ><div align="center"><span class="bold1">
               
           </span> </div></td>
            <td width="170" align="right">
			  </a><strong></strong>&nbsp;
			 <a href="Logout.jsp" target="_parent"><font class="boldEleven"><b>Logout</b></font></a> </td>
        </tr>
        </table></td>
  </tr>
   
</table>
 </td>
  </tr>
  <tr>
    <td >
    <%
	out.println("<center>"); 
out.println("<table width='60%' border='0' align='center' cellpadding='4' cellspacing='4'  bgcolor='#0066CC'>");
out.println("<tr  >");
out.println("<td align='center'><font color='#FFFFFF'>INSTALLED JAVA VERSION</font></td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td><table width='100%' border='0' cellspacing='5' cellpadding='5'  bgcolor='#FFFFFF'>");





out.println("<tr>");
out.println("<td>&nbsp;</td>");
out.println("<td class='boldEleven'><b>java.version</td>");
out.println("<td>"+System.getProperty("java.version")+"</td>");
out.println("<td>&nbsp;</td>");
out.println(" </tr>");

out.println("<tr>");
out.println("<td>&nbsp;</td>");
out.println("<td class='boldEleven'><b>java.specification.version</td>");
out.println("<td>"+System.getProperty("java.specification.version")+"</td>");
out.println("<td>&nbsp;</td>");
out.println("</tr>");


out.println("<tr>");
out.println("<td>&nbsp;</td>");
out.println("<td class='boldEleven'><b>java.version</td>");
out.println("<td>"+System.getProperty("java.version")+"</td>");
out.println("<td>&nbsp;</td>");
out.println("</tr>");

out.println("<tr>");
out.println("<td>&nbsp;</td>");
out.println("<td class='boldEleven'><b>java.vm.version</td>");
out.println("<td>"+System.getProperty("java.vm.version")+"</td>");
out.println("<td>&nbsp;</td>");
out.println("</tr>");

out.println("<tr>");
out.println("<td>&nbsp;</td>");
out.println("<td class='boldEleven'><b>java.runtime.version</td>");
out.println("<td>"+System.getProperty("java.runtime.version")+"</td>");
out.println("<td>&nbsp;</td>");
out.println("</tr>");



out.println("<tr>");
out.println("<td>&nbsp;</td>");
out.println("<td class='boldEleven'><b>Server info:</td>");
out.println("<td>"+application.getServerInfo()+"</td>");
out.println("<td>&nbsp;</td>");
out.println("</tr>");

out.println("<tr>");
out.println("<td>&nbsp;</td>");
out.println("<td class='boldEleven'><b>Servlet version</td>");
out.println("<td>"+application.getMajorVersion()+" / "+application.getMinorVersion()+"</td>");
out.println("<td>&nbsp;</td>");
out.println("</tr>");

out.println("<tr>");
out.println("<td>&nbsp;</td>");
out.println("<td class='boldEleven'><b>JSP version </td>");
out.println("<td>"+JspFactory.getDefaultFactory().getEngineInfo().getSpecificationVersion()+"</td>");
out.println("<td>&nbsp;</td>");
out.println("</tr>");

 out.println("<tr>");
 out.println("<td>&nbsp;</td>");
out.println("<td class='boldEleven'><b>Webserver</td>");
out.println("<td>"+getServletContext().getServerInfo()+"</td>");
out.println("<td>&nbsp;</td>");
out.println("</tr>");


out.println("</table></td>");
out.println("</tr>");
out.println("</table>");
out.println("</center>"); 
    
	%>
    </td>
  </tr>
  <tr>
    <td height="480">
    <form name="frm" AUTOCOMPLETE = "off" method="post" action="DBServletConfigure"  onSubmit="return validate()">
      <table width="600" border="0" align="center" cellpadding="5" cellspacing="5">
        <tr>
          <td width="240" class="menu_H">DRIVER <span class="boldred">*</span></td>
          <td width="325" class="menu_H"><input name="driver" type="text" id="driver" size="50" value="com.mysql.jdbc.Driver"></td>
        </tr>
        <tr>
          <td class="menu_H">DB_URL <span class="boldred">*</span></td>
          <td class="menu_H"><input name="url" type="text" id="url" size="50" value="jdbc:mysql://localhost:3306/smartcampus"></td>
        </tr>
        <tr>
          <td   class="menu_H">DB_USERNAME<span class="boldred"> *</span></td>
          <td   class="menu_H"><input name="username" type="text" id="username" value="root" size="50"></td>
        </tr>
        <tr>
          <td class="menu_H">DB_PASSWORD <span class="boldred">*</span></td>
          <td class="menu_H"><input name="password" type="text" id="password" value="care#1994*" size="50"></td>
        </tr>
        <tr>
          <td class="menu_H">DB_NAME<span class="boldred"> *</span></td>
          <td class="menu_H"><input name="dbname" type="text" id="dbname" value="smartcampus" size="50"></td>
        </tr>
        <tr>
          <td class="menu_H">EXPORT PATH <span class="boldred">*</span></td>
          <td class="menu_H"><input name="exportpath" type="text" id="exportpath" value="c:/kalai" size="50"></td>
        </tr>
        <tr>
          <td class="menu_H">JDK PATH <span class="boldred">*</span></td>
          <td class="menu_H"><input name="jdkpath" type="text" id="jdkpath" value="C:/Program Files/Java/jdk1.5.0" size="50"></td>
        </tr>
        <tr>
          <td class="menu_H">MYSQL PATH <span class="boldred">*</span></td>
          <td class="menu_H"><input name="mysqlpath" type="text" id="mysqlpath" value="c:/Program Files/MySQL/MySQL Server 5.0" size="50"></td>
        </tr>
        <tr>
          <td class="menu_H">HOST NAME <span class="boldred">*</span></td>
          <td class="menu_H"><input name="hostname" type="text" id="hostname" value="localhost" size="50"></td>
        </tr>
        <tr>
          <td class="menu_H">SECRET CODE<span class="boldred"> *</span></td>
          <td class="menu_H"><input name="code" type="password" id="code" value="a"  size="50"></td>
        </tr>
        <tr>
          <td class="menu_H">LICENSE KEY <span class="boldred">*</span></td>
          <td class="menu_H"><input name="licence" type="text" id="licence" value="hfc-jhc-jh"  size="50" maxlength="11"></td>
        </tr>
        <tr>
          <td class="menu_H">&nbsp;</td>
          <td class="menu_H">&nbsp;</td>
        </tr>
        <tr>
          <td colspan="2" class="menu_H"><div align="center">
              <input name="image" type="image" src="images/submit_btn.gif"/>
          </div></td>
        </tr>
        
      </table>
      </form>
    </td>
  </tr>
  <tr>
    <td><%@ include file="footer.jsp"%></td>
  </tr>
</table>

</body>
</html>
