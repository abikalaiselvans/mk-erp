 <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<%@ page import="java.util.*"%>
<%
try
{
	%>
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
 <script language="javascript" src="../JavaScript/comfunction.js"></script>
<title> :: COMMON ::</title>


  


  
</head>
<style type="text/css" media="all">
      @import url("../JavaScript/css/maven-base.css");
      @import url("../JavaScript/css/maven-theme.css");
      @import url("../JavaScript/css/site.css");
      @import url("../JavaScript/css/screen.css");
  </style> 
</head>

<body  onpaste='return false;'>
<%
String company= request.getParameter("company");
String branch= request.getParameter("branch");
String Office = request.getParameter("Office");
String dept= request.getParameter("dept");
String sorting = request.getParameter("sorting");
String ss = request.getParameter("ss");
String cpy="";
String bid="";
String off="";
String dep="";
String sql="";
sql = " SELECT a.CHR_EMPID,a.CHR_STAFFNAME,a.CHR_STAFFFNAME,b.CHR_COMPANYNAME,c.CHR_BRANCHNAME,d.CHR_DEPARTNAME,   ";
sql = sql + " e.CHR_DESIGNAME,f.CHR_OFFICENAME,j.CHR_CATEGORYNAME,   ";
sql = sql + " a.CHR_GENDER,g.CHR_GROUPNAME,DATE_FORMAT(a.DT_DOB,'%d-%b-%Y'),   ";
sql = sql + " DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y'),a.CHR_TYPE,a.CHR_MARITALSTATUS,DATE_FORMAT(a.DT_WEDDATE,'%d-%b-%Y'),   ";
sql = sql + " i.CHR_QUALIFICATIONNAME,a.CHR_REPTO,a.CHR_REP,a.CHR_CONVEYANCECLEAR,   ";
sql = sql + " CONCAT(a.CHR_PADD1,',',a.CHR_PADD2,',',n.CHR_CITYNAME,',',m.CHR_DISTRICT,',',l.CHR_STATENAME,',',k.CHR_COUNTRYNAME,',Pincode : ',a.CHR_PPIN,', Phone : ',a.CHR_PPHONE),    ";
sql = sql + " CONCAT(a.CHR_SADD1,',',a.CHR_SADD2,',',n.CHR_CITYNAME,',',m.CHR_DISTRICT,',',l.CHR_STATENAME,',',k.CHR_COUNTRYNAME,',Pincode : ',a.CHR_SPIN,', Phone : ',a.CHR_SPHONE) ,    ";
sql = sql + " a.INT_SALARY,a.INT_GROSSSALARY,   ";
sql = sql + " a.CHR_PFTYPE,a.INT_PFAMT,a.CHR_PF,CONCAT(b.CHR_PFNUMBER,a.CHR_PFNO),DATE_FORMAT(a.DAT_PFESIDATE,'%d-%b-%Y'),   ";
sql = sql + " a.CHR_ESITYPE,a.INT_ESIAMT,a.CHR_ESI,CONCAT(b.CHR_PFNUMBER,a.CHR_ESINO),DATE_FORMAT(a.DAT_PFESIDATE,'%d-%b-%Y'),   ";
sql = sql + " FIND_A_BANKGROUP_NAME(a.CHR_BANK)  ,a.CHR_ACCNO,a.CHR_PAN,a.CHR_PASSPORT,a.CHR_DRIVING,a.CHR_EMAILID,a.CHR_PERMAILID,a.CHR_MOBILE,a.CHR_PREVIOUSDETAILS,   ";
sql = sql + " a.CHR_ADDRESSPROOFSTATUS,a.CHR_PFCLAIMSTATUS,DATE_FORMAT(a.DAT_PFCLIAMDATE,'%d-%b-%Y'),a.CHR_PFCLIAMDESCRIPTION,   ";
sql = sql + " DATE_FORMAT(a.DAT_PFRESIGNDATE,'%d-%b-%Y'),a.CHR_NOMINEE,a.CHR_INTERVIEW,a.CHR_REJOIN    ";
sql = sql + " FROM com_m_staff a, com_m_company b, com_m_branch c,com_m_depart d,com_m_desig e,com_m_office f,   ";
sql = sql + " com_m_bloodgroup g,  com_m_qualification i,com_m_employeecategory j,   ";
sql = sql + " com_m_country k,com_m_state l,com_m_district m,com_m_city n      ";
sql = sql + " WHERE a.INT_COMPANYID =b.INT_COMPANYID    ";
sql = sql + " AND a.INT_BRANCHID =c.INT_BRANCHID    ";
sql = sql + " AND a.INT_DEPARTID = d.INT_DEPARTID    ";
sql = sql + " AND a.INT_DESIGID = e.INT_DESIGID   ";
sql = sql + " AND a.INT_OFFICEID= f.INT_OFFICEID   ";
sql = sql + " AND a.CHR_BG=g.INT_BLOODGROUPID   ";
 
sql = sql + " AND a.CHR_QUALIFICATION =i.INT_QUALIFICATIONID   ";
sql = sql + " AND a.CHR_CATEGORY = j.INT_EMPLOYEECATEGORYID   ";
sql = sql + " AND a.CHR_PCITY = n.INT_CITYID     ";
sql = sql + " AND a.INT_PDISTRICTID=m.INT_DISTRICTID     ";
sql = sql + " AND a.CHR_PSTATE=l.INT_STATEID     ";
sql = sql + " AND a.INT_PCOUNTRYID =k.INT_COUNTRYID     ";
sql = sql + " AND a.CHR_SCITY = n.INT_CITYID     ";
sql = sql + " AND a.INT_CDISTRICTID=m.INT_DISTRICTID     ";
sql = sql + " AND a.CHR_SSTATE=l.INT_STATEID     ";
sql = sql + " AND a.INT_CCOUNTRY =k.INT_COUNTRYID    ";
if(!"0".equals(company))
	sql = sql + " AND a.INT_COMPANYID="+company;
if(!"0".equals(branch))
	sql = sql + " AND a.INT_BRANCHID="+branch;	
if(!"0".equals(Office))
	sql = sql + " AND a.INT_OFFICEID ="+Office;
if(!"0".equals(dept))
	sql = sql + " AND a.INT_DEPARTID ="+dept;
sql = sql + " ORDER BY  "+ sorting +" "+ss;
  
 String data[][] = CommonFunctions.QueryExecute(sql);
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
		child.addElement(data[u][7]);
		child.addElement(data[u][8]);
		child.addElement(data[u][9]);
		child.addElement(data[u][10]);
		child.addElement(data[u][11]);
		child.addElement(data[u][12]);
		child.addElement(data[u][13]);
		if("U".equals(data[u][14]))
			child.addElement("UNMARRIED");
		else
			child.addElement("MARRIED");
		
		 
		child.addElement(data[u][15]);
		child.addElement(data[u][16]);
		child.addElement(data[u][17]);
		if("Y".equals(data[u][18]))
			child.addElement("YES");
		else
			child.addElement("NO");
		if("Y".equals(data[u][19]))
			child.addElement("YES");
		else
			child.addElement("NO");
		
		 
		child.addElement(data[u][20]);
		child.addElement(data[u][21]);
		child.addElement(data[u][22]);
		child.addElement(data[u][23]);
		
		//PF 
		if("C".equals(data[u][26]))
			child.addElement("COMMON");
		else if("Y".equals(data[u][26]))
			child.addElement("YES");
		else
			child.addElement("NO");
			
		//PF TYPE
		if("P".equals(data[u][24]))
			child.addElement("PERCENTAGE");
		else
			child.addElement("NO");
		
		
		//PF NUMBER
		child.addElement(data[u][25]);
		 
		
		
			
		child.addElement(data[u][27]);
		child.addElement(data[u][28]);
		
		//ESI
		if("C".equals(data[u][31]))
			child.addElement("COMMON");
		else if("Y".equals(data[u][31]))
			child.addElement("YES");
		else
			child.addElement("NO");
		//ESI TYPE	
		if("P".equals(data[u][29]))
			child.addElement("PERCENTAGE");
		else
			child.addElement("NO");
		child.addElement(data[u][30]);
		
		
		child.addElement(data[u][32]);
		child.addElement(data[u][33]);
		child.addElement(data[u][34]);
		child.addElement(data[u][35]);
		child.addElement(data[u][36]);
		child.addElement(data[u][37]);
		child.addElement(data[u][38]);
		child.addElement(data[u][39]);
		child.addElement(data[u][40]);
		child.addElement(data[u][41]);
		child.addElement(data[u][42]);
		
		if("Y".equals(data[u][43]))
			child.addElement("YES");
		else
			child.addElement("NO");
		if("Y".equals(data[u][44]))
			child.addElement("YES");
		else
			child.addElement("NO");
			
		 
		child.addElement(data[u][45]);
		child.addElement(data[u][46]);
		child.addElement(data[u][47]);
		child.addElement(data[u][48]);
		 
		if("Y".equals(data[u][49]))
			child.addElement("YES");
		else
			child.addElement("NO");
		if("Y".equals(data[u][50]))
			child.addElement("YES");
		else
			child.addElement("NO");
		mn.add(child);
 } 
 
request.setAttribute("table",mn);
out.println("<br><center><h1>S T A F F &nbsp;&nbsp;&nbsp;    I N FO R M A T I O N S </h1></center><br>");
%>

 

<display:table   id="_table" name="table"    export="true" pagesize='25'>
	 
	 				<display:caption><%="STAFF   INFORMATIONS"%></display:caption>
					<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="ID" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="NAME" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="FATHER" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="COMPANY" sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="BRANCH" sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="DEPARTMENT" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="DESIGNATION" sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="OFFICE" sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="CATEGORY" sortable="true"><%=temp.elementAt(9)%></display:column>
					<display:column title="GENDER " sortable="true"><%=temp.elementAt(10)%></display:column>
					<display:column title="BLOOD GROUP " sortable="true"><%=temp.elementAt(11)%></display:column>
					<display:column title="DOB " sortable="true"><%=temp.elementAt(12)%></display:column>
					<display:column title="DOJ " sortable="true"><%=temp.elementAt(13)%></display:column>
					<display:column title="STAFF TYPE " sortable="true"><%=temp.elementAt(14)%></display:column>
					<display:column title="MARRIED " sortable="true"><%=temp.elementAt(15)%></display:column>
					<display:column title="WEDDING DATE " sortable="true"><%=temp.elementAt(16)%></display:column>
					<display:column title="QUALIFICATION" sortable="true"><%=temp.elementAt(17)%></display:column>
					<display:column title="REPORTING TO" sortable="true"><%=temp.elementAt(18)%></display:column>
					<display:column title="REPORTING HEAD " sortable="true"><%=temp.elementAt(19)%></display:column>
					<display:column title="CONVEYANCE APPROVAL " sortable="true"><%=temp.elementAt(20)%></display:column>
					<display:column title="ADDRESS1 " sortable="true"><%=temp.elementAt(21)%></display:column>
					<display:column title="ADDRESS2 " sortable="true"><%=temp.elementAt(22)%></display:column>
					<display:column title="BASIC" sortable="true"><%=temp.elementAt(23)%></display:column>
					<display:column title="GROSS" sortable="true"><%=temp.elementAt(24)%></display:column>
					<display:column title="PF TYPE " sortable="true"><%=temp.elementAt(25)%></display:column>
					<display:column title="PF AMOUNT " sortable="true"><%=temp.elementAt(26)%></display:column>
					<display:column title="PF" sortable="true"><%=temp.elementAt(27)%></display:column>
					<display:column title="PF NUMBER" sortable="true"><%=temp.elementAt(28)%></display:column>
					<display:column title="PF DATE " sortable="true"><%=temp.elementAt(29)%></display:column>
					<display:column title="ESI TYPE " sortable="true"><%=temp.elementAt(30)%></display:column>
					<display:column title="ESI AMOUNT " sortable="true"><%=temp.elementAt(31)%></display:column>
					<display:column title="ESI " sortable="true"><%=temp.elementAt(32)%></display:column>
					<display:column title="ESI NUMBER " sortable="true"><%=temp.elementAt(33)%></display:column>
					<display:column title="ESI DATE " sortable="true"><%=temp.elementAt(34)%></display:column>
					<display:column title="BANK " sortable="true"><%=temp.elementAt(35)%></display:column>
					<display:column title="ACCOUNT NO " sortable="true"><%=temp.elementAt(36)%></display:column>
					<display:column title="PAN NUMBER " sortable="true"><%=temp.elementAt(37)%></display:column>
					<display:column title="PASSPORT NUMBER " sortable="true"><%=temp.elementAt(38)%></display:column>
					<display:column title="DRIVING LICENSE NUMBER " sortable="true"><%=temp.elementAt(39)%></display:column>
					 <display:column title="MAILID" sortable="true"><%=temp.elementAt(40)%></display:column>
					<display:column title="PERSONL MAILID" sortable="true"><%=temp.elementAt(41)%></display:column>
					
					<display:column title="MOBILE" sortable="true"><%=temp.elementAt(42)%></display:column>
					<display:column title="PREVIOUS DETAILS" sortable="true"><%=temp.elementAt(43)%></display:column>
					<display:column title="ADDRESS PROOF " sortable="true"><%=temp.elementAt(44)%></display:column>
					<display:column title="PF CLAIM STATUS " sortable="true"><%=temp.elementAt(45)%></display:column>
					<display:column title="PF CLAIM DATE " sortable="true"><%=temp.elementAt(46)%></display:column>
					<display:column title="PF CLAIM DESCRIPTION " sortable="true"><%=temp.elementAt(47)%></display:column>
					<display:column title="PF RESIGNDATE " sortable="true"><%=temp.elementAt(48)%></display:column>
					<display:column title="NOMINEE " sortable="true"><%=temp.elementAt(49)%></display:column>
					<display:column title="INTERVIEW HEAD" sortable="true"><%=temp.elementAt(50)%></display:column>
					<display:column title="REJOIN " sortable="true"><%=temp.elementAt(51)%></display:column>
					
					
					 
					 
					
					<display:setProperty name="export.csv.filename" value="Rept_StaffInformations.csv"/>
					<display:setProperty name="export.excel.filename" value="Rept_StaffInformations.xls"/>
					<display:setProperty name="export.xml.filename" value="Rept_StaffInformations.xml"/>
					<display:setProperty name="export.pdf.filename" value="Rept_StaffInformations.pdf"/>
					<display:setProperty name="export.pdf" value="true" />
					 
</display:table> 
	
	
 
<br />
 
									<center>	<a href='Rept_StaffAll.jsp'> CLOSE</a></center>

</body>
</html>

<%
}
catch(Exception e)
{
		out.println(e.getMessage());
}
%>
