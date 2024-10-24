
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@page import="com.my.org.erp.common.CommonFunctions"%>
<html>
<head>
<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>



<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />


<title> :: COMMON ::</title>



  
<link rel="stylesheet" href="../JavaScript/jquery/Treeviewer/jquery.treeview.css" />
 <link rel="stylesheet" href="../JavaScript/jquery/Treeviewer/screen.css" />

<script src="../JavaScript/jquery/Treeviewer/lib/jquery.js"  type="text/javascript"></script>
<script src="../JavaScript/jquery/Treeviewer/lib/jquery.cookie.js" type="text/javascript"></script>
<script src="../JavaScript/jquery/Treeviewer/jquery.treeview.js" type="text/javascript"></script>

<script type="text/javascript">
	$(function() {
	$("#browser").treeview();
	});
</script>
	
</head>

<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">


<p>
  <%
try
{
	String sql=" ";
	String instid=""+session.getAttribute("INSTITUTIONID");
 	sql="  select INT_COMPANYID ,CHR_COMPANYNAME  from com_m_company WHERE INT_COMPANYID=3 order by INT_COMPANYID " ;
	String  company[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);

	sql=" select INT_OFFICEID ,CHR_OFFICENAME  from  com_m_office  order by CHR_OFFICENAME";
	String  office[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);

	sql=" select INT_DEPARTID ,CHR_DEPARTNAME  from com_m_depart order by CHR_DEPARTNAME ";
	String  dept[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	
	 
 %>
</p>
<%@ include file="index.jsp"%>
<table width="101%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="21%">&nbsp;</td>
    <td width="79%">&nbsp;</td>
  </tr>
  <tr>
    <td><TABLE border=0 width="257" height=400>
      <TR>
        <TD width="251" valign="top">
		
		  
		
		
	
		<%
		out.println("<div id='main'>");
		out.println("<ul id='browser' class='filetree'>");
		for(int u=0;u<company.length;u++)
		{
			out.println("<li><img src='../JavaScript/jquery/Treeviewer/images/folder.gif' />"+company[u][1]);
				out.println("<ul>");
				if(office.length>1)
					for(int o=0;o<office.length;o++)
					{
						out.println("<li><img src='../JavaScript/jquery/Treeviewer/images/folder.gif' />"+office[o][1]);
						out.println("<ul id='folder21'>");
						if(dept.length>1)
							for(int p=0;p<dept.length;p++)
							{
								out.println("<li><img src='../JavaScript/jquery/Treeviewer/images/folder.gif' />"+dept[p][1]   );
								out.println("<ul id='folder21'>");
								sql=" select CHR_EMPID ,CHR_STAFFNAME  from com_m_staff  WHERE INT_COMPANYID="+company[u][0]+" AND INT_OFFICEID="+office[o][0]+" AND INT_DEPARTID="+dept[p][0] +" AND CHR_TYPE!='T' ORDER BY CHR_STAFFNAME";
								String  staff[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
								if(staff.length>0)
								for(int q=0;q<staff.length;q++)
								{
									out.println("<li><img src='../JavaScript/jquery/Treeviewer/images/file.gif' />");
									out.println("<a herf='StaffPersonalinfoview.jsp?empid="+staff[q][0]+"'>"+staff[q][1]+"</a></li>"  );
								}
								out.println("</ul>");
								out.println("</li>");
								
							}
						out.println("</ul>");
						out.println("</li>");
					}
				out.println("</ul>");
			out.println("</li>");
		}
		out.println("</ul>");
	out.println("</div>");
		%> 
		 
	
		

		
		
		 </TD>
      </TR>
    </TABLE></td>
    <td align="center" valign="top"><iframe src="" 	name="abikalai" width="95%" height="100%"  frameborder="0"
					style="border-width: 0px; border-color: #F48442; border-style: dotted;"> </iframe></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
 

 <%
 
 }
 catch(Exception e)
 {
 }
 %>  
 
 <%@ include file="../footer.jsp"%>
</body>
</html>
