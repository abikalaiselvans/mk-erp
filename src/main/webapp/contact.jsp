<%@ page language="java" import="java.sql.*,java.util.*,java.io.*,java.text.*" errorPage="../error/index.jsp"%>
<%@ page import="com.my.org.erp.common.CommonFunctions" %>
<link rel="icon" type="image/ico" href="images/ERP.ico"></link>
<link rel="shortcut icon" href="images/ERP.ico"></link>
<%
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", -1);
response.setHeader("Cache-Control", "no-store");
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
response.setDateHeader("Expires", 0); // Proxies.
try
{  
	String sql ="";
	sql = sql + " SELECT a.CHR_NAME,CONCAT(CHR_ADDRESS1,',' ,CHR_ADDRESS2) , ";
	sql = sql + " CONCAT(e.CHR_CITYNAME,',  ',d.CHR_DISTRICT,'-', DECODE(e.CHR_PINCODE,'9865043008')),  ";
	sql = sql + " c.CHR_STATENAME,b.CHR_COUNTRYNAME, ";
	sql = sql + " IF(LENGTH(a.CHR_PHONE)>4 ,CONCAT('Phone :',a.CHR_PHONE),''), ";
	sql = sql + " IF(LENGTH(a.CHR_FAX)>4 ,CONCAT('Fax :',a.CHR_FAX),''), ";
	sql = sql + " IF(LENGTH(a.CHR_EMAIL)>4 ,CONCAT('Email :',a.CHR_EMAIL),''), ";
	sql = sql + " IF(LENGTH(a.CHR_WEBSITE)>4 ,CONCAT('Website :',a.CHR_WEBSITE),''), a.CHR_GOOGLELOCATION  ";
	sql = sql + " FROM m_company a, com_m_country b, com_m_state c, com_m_district d, com_m_city e ";
	sql = sql + " WHERE a.INT_COUNTRYID = b.INT_COUNTRYID ";
	sql = sql + " AND a.INT_STATEID =c.INT_STATEID ";
	sql = sql + " AND a.INT_DISTRICTID = d.INT_DISTRICTID ";
	sql = sql + " AND a.INT_CITYID = e.INT_CITYID ";
	sql = sql + " AND INT_CPYID=1 ";
	String data[][] =CommonFunctions.QueryExecute(sql);
%>

<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="0">
 <link rel="stylesheet" href="dist/css/site.min.css">
<title><%=data[0][0]%></title></head>
</head>
<body>



<!--nav-->
    <nav role="navigation" class="navbar navbar-custom">
        <div class="container-fluid">
          <!-- Brand and toggle get grouped for better mobile display -->
          <div class="navbar-header"><img src="images/top_banner.png"/></div>

          <div id="bs-content-row-navbar-collapse-5" class="collapse navbar-collapse">
            <ul class="nav navbar-nav navbar-right">
              <li class="active"><a href="index.jsp">Home</a></li>
			  <li class="active"><a href="Career.jsp">Career</a></li>
			  <li class="active"><a href="Employee Verififcation.jsp">Verification</a></li>
			  <li class="active"><a href="contact.jsp">Contact</a></li>
			</ul>
			</div>
			
        </div>
      </nav>
    <!--header-->
	
<br>	
	
	
	
    <div class="container-fluid">
    <!--documents-->
	
		

 <div class="row">
          <div class="panel panel-default">
                <div class="panel-body">
                    
                    <div class="form-group">
                        <div class="col-sm-8">
                            <iframe src="<%=data[0][9]%>" width="100%" height="450" frameborder="0" style="border:0" allowfullscreen></iframe>
                        </div>
						<div class="col-sm-4">
							<img src="Loginimages/icon-contact.png"/><br>
							<%out.println(data[0][0]);%><br>
				<%=data[0][1]%><br>
				<%=data[0][2]%><br>
				<%=data[0][5]%><br>
				<%=data[0][6]%><br>
				
				<%=data[0][8]%>
						</div>
						
						
                    </div>
                    
                  
                </div>
            </div>
        
    </div>
		
		
	 
    </div>





</body>
</html>
 <%
}
catch(Exception e)
{
	System.out.println(e.getMessage());
}
%>