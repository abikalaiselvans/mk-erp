<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="com.my.org.erp.common.CommonInfo"%>
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>


 
<script language="javascript" src="../JavaScript/comfunction.js"></script>

<html>
<head>

<title>:: HRM ::</title>

 
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

 
</head>
<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<%@ page import="java.util.*"%>


 
</head>
<style type="text/css" media="all">
      @import url("../JavaScript/css/maven-base.css");
      @import url("../JavaScript/css/maven-theme.css");
      @import url("../JavaScript/css/site.css");
      @import url("../JavaScript/css/screen.css");
  </style> 

 
<body  onpaste='return false;'>
 <%
String jobgrade=request.getParameter("jobgrade");
String jobtitle=request.getParameter("jobtitle");
String Month=request.getParameter("Month");
String Year=request.getParameter("Year");
String office=request.getParameter("office");


String sql = " SELECT a.CHR_APPCODE,a.CHR_APPNAME,a.CHR_APPFATHER,DATE_FORMAT(a.DT_APPLICATIONDATE,'%d-%m-%Y'), ";
sql = sql + " a.CHR_JOBGRADE,f.CHR_JOBCODE,f.CHR_JOBTITLE,a.CHR_GENDER,DATE_FORMAT(a.DT_DOB,'%d-%m-%Y'),g.CHR_GROUPNAME, ";
sql = sql + " a.CHR_MARITALSTATUS,DATE_FORMAT(a.DT_WEDDATE,'%d-%m-%Y'), h.CHR_QUALIFICATIONNAME, ";

sql = sql + " CHR_EMAILID,CHR_MOBILE,CHR_PASSPORT,CHR_PAN,CHR_BIKESTATUS,CHR_DRIVINGLIC, ";
sql = sql + " CONCAT(CHR_PADD1,'\n,',CHR_PADD2,'\n,',e.CHR_CITYNAME,'\n,',d.CHR_DISTRICT,'\n,',c.CHR_STATENAME,'\n,',b.CHR_COUNTRYNAME,'\n, PIN :',INT_PPIN,'\n,',INT_PPHONE), ";
sql = sql + " CONCAT(CHR_CADD1,'\n,',CHR_CADD2,'\n,',e.CHR_CITYNAME,'\n,',d.CHR_DISTRICT,'\n,',c.CHR_STATENAME,'\n,',b.CHR_COUNTRYNAME,'\n, PIN :',INT_CPIN,'\n,',INT_CPHONE) ";

sql = sql + " FROM  hrm_m_application a ,com_m_country b,com_m_state c,com_m_district d,com_m_city e,hrm_m_jobdesign f,com_m_bloodgroup g,com_m_qualification h ";
sql = sql + " WHERE a.INT_PCOUNTRYID =b.INT_COUNTRYID  ";
sql = sql + " AND a.INT_PSTATE=c.INT_STATEID ";
sql = sql + " AND a.INT_PDISTRICTID=d.INT_DISTRICTID ";
sql = sql + " AND a.INT_PCITY=e.INT_CITYID ";
sql = sql + " AND a.INT_CCOUNTRY =b.INT_COUNTRYID  ";
sql = sql + " AND a.INT_CSTATE=c.INT_STATEID ";
sql = sql + " AND a.INT_CDISTRICTID=d.INT_DISTRICTID ";
sql = sql + " AND a.INT_CCITY=e.INT_CITYID  AND a.INT_JOBID =f.INT_JOBID AND a.CHR_BG  =g.INT_BLOODGROUPID  AND  a.CHR_QUALIFICATION = h.INT_QUALIFICATIONID";
if(!"0".equals(office)) 
	sql = sql +" AND a.INT_OFFICEID ='"+office+"'";
if(!"0".equals(Month)) 
	sql = sql +" AND a.CHR_MONTH ='"+Month+"'";
if(!"0".equals(Year)) 
	sql = sql +" AND a.INT_YEAR = "+Year+" ";

if(!"0".equals(jobgrade)) 
	sql = sql +" AND a.CHR_JOBGRADE ='"+jobgrade+"'";
if(!"0".equals(jobtitle)) 
	sql = sql +" AND a.INT_JOBID ='"+jobtitle+"'";
if(!"0".equals(jobtitle)) 
	sql = sql +" AND a.INT_JOBID = "+jobtitle+" ";

sql = sql +" ORDER BY 	a.CHR_APPNAME  ";
//out.println(sql); 

   String data[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	 Vector mn = new Vector();
	 Vector child= null;
      
	 for(int u=0; u<data.length;u++)
	 {
	     	child = new Vector();
			child.addElement((u+1));
			child.addElement(data[u][0]);
			child.addElement(data[u][1]);
			child.addElement(data[u][2]);
			child.addElement(data[u][3]);
			child.addElement(data[u][4]);
			child.addElement(data[u][5]);
			child.addElement(data[u][6]);
			 
			if("M".equals(data[u][7]))
				child.addElement("Male");
			else
				child.addElement("Female");
			child.addElement(data[u][8]);
			child.addElement(data[u][9]);
			 
			
			if("M".equals(data[u][10]))
				child.addElement("Married");
			else
				child.addElement("Unmarried");
				
			child.addElement(data[u][11]);
			child.addElement(data[u][12]);
			child.addElement(data[u][13]);
			child.addElement(data[u][14]);
			child.addElement(data[u][15]);
			child.addElement(data[u][16]);
			child.addElement(data[u][17]);
			child.addElement(data[u][18]);
			child.addElement(data[u][19]);
			child.addElement(data[u][20]);
			mn.add(child);
     } 
 
	 
	request.setAttribute("table",mn); 
	out.println("<br><center><h1>  APPLICATION INFORMATION</h1></center><br>");
	%>
 
	
	
<br />
 <display:table   id="_table" name="table"  export="true">
	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.No" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="Applicant Code" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="Applicant Name" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="Applicant Father Name" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="Application Date" sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="Job Grade" sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="Job Code" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="Job Title" sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="Gender" sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="Date Of Birth" sortable="true"><%=temp.elementAt(9)%></display:column>
					<display:column title="Blood Group" sortable="true"><%=temp.elementAt(10)%></display:column>
					
					<display:column title="Married" sortable="true"><%=temp.elementAt(11)%></display:column>
					<display:column title="Wedding Date To" sortable="true"><%=temp.elementAt(12)%></display:column>
					<display:column title="Qualification" sortable="true"><%=temp.elementAt(13)%></display:column>
					<display:column title="Email" sortable="true"><%=temp.elementAt(14)%></display:column>
					<display:column title="Mobile" sortable="true"><%=temp.elementAt(15)%></display:column>
					<display:column title="Passport" sortable="true"><%=temp.elementAt(16)%></display:column>
					<display:column title="PAN" sortable="true"><%=temp.elementAt(17)%></display:column>
					<display:column title="BIKE" sortable="true"><%=temp.elementAt(18)%></display:column>
					<display:column title="Driving License" sortable="true"><%=temp.elementAt(19)%></display:column>
					<display:column title="Permenant Address" sortable="true"><%=temp.elementAt(20)%></display:column>
					<display:column title="Communincation Address" sortable="true"><%=temp.elementAt(21)%></display:column>
					 
					 
					 
					
					<display:setProperty name="export.csv.filename" value="Applicant.csv"/>
					<display:setProperty name="export.excel.filename" value="Applicant.xls"/>
					<display:setProperty name="export.xml.filename" value="Applicant.xml"/>
					<display:setProperty name="export.pdf.filename" value="Applicant.pdf"/>
					<display:setProperty name="export.pdf" value="true" />
					 
	</display:table> 
    
									<center>	<a href='ApplicationReport.jsp'> CLOSE</a></center>
          
       

</body>
</html>
