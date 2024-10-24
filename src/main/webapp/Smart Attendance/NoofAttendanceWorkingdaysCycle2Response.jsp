 <%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
 <%@ page import="java.util.*"%>
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
 
<title> :: ATTENDANCE ::</title>




<style type="text/css" media="all">
      @import url("../JavaScript/css/maven-base.css");
      @import url("../JavaScript/css/maven-theme.css");
      @import url("../JavaScript/css/site.css");
      @import url("../JavaScript/css/screen.css");
  </style> 
  
   
</head>
<%
try
{
%>
 
<body  onpaste='return false;'><br> 
<%
 

 String reportheader="CYCLE-2  / NO OF WORKING DAYS INFORMATION "; 
 
String sql="";

 

	 
sql = " SELECT CHR_DEPARTNAME,CHR_DEPARTDES  FROM  com_m_depart ORDER BY CHR_DEPARTNAME ";
String rofficeid=request.getParameter("Office");
String rdept = ""+request.getParameter("dept");
String rCategory=request.getParameter("Category");
String rmont=request.getParameter("month");
String ryear=request.getParameter("year");
String month = DateUtil.getMonth(Integer.parseInt(rmont));
String OfficeData[][] = CommonFunctions.QueryExecute(" SELECT b.INT_OFFICEID,b.CHR_OFFICENAME FROM  com_m_office  b " +
    		 			"WHERE b.INT_OFFICEID IN("+CommonFunctions.QueryExecute("SELECT a.CHR_OFFICELIST FROM m_user a " +
    		 					"WHERE a.CHR_USRNAME='"+""+session.getAttribute("USRID")+"' ")[0][0]+" )");
String officeids="";
if(OfficeData.length>0)
	for(int u=0;u<OfficeData.length;u++)
		officeids=officeids+OfficeData[u][0]+",";


String catids="";
String empcategoryData[][] =CommonFunctions.QueryExecute(" SELECT b.INT_EMPLOYEECATEGORYID,b.CHR_CATEGORYNAME " +
		" FROM  com_m_employeecategory  b WHERE b.INT_EMPLOYEECATEGORYID IN("+ CommonFunctions.QueryExecute("SELECT a.CHR_GATEGORYLIST " +
				" FROM m_user a WHERE a.CHR_USRNAME='"+session.getAttribute("USRID")+"' ")[0][0]+" )");
 if(empcategoryData.length>0)
	for(int u=0;u<empcategoryData.length;u++)
		catids=catids+empcategoryData[u][0]+",";

sql ="SELECT a.CHR_EMPID,a.CHR_STAFFNAME,a.CHR_STAFFFNAME,b.CHR_COMPANYNAME,c.CHR_BRANCHNAME,d.CHR_OFFICENAME,e.CHR_DEPARTNAME,  ";
sql = sql+ " f.CHR_DESIGNAME,h.CHR_CATEGORYNAME, DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y'),   ";
sql = sql+ " i.DOU_PRESENT,i.DOU_ONDUTY,i.DOU_SUNDAY,i.DOU_HOLIDAY,i.DOU_LEAVE,  ";
sql = sql+ " i.DOU_ABSENT,i.INT_LATE,i.INT_PERMISSION,i.DOU_EXTRADAYS,i.DOU_EXTRAHOURS,i.DOU_TOTALDAYS,IF(i.CHR_FLAG='N','Pending','Completed')  ";
sql = sql+ " FROM com_m_staff a,com_m_company b,com_m_branch c, com_m_office d,com_m_depart e,com_m_desig f,  ";
sql = sql+ " com_m_employeecategory h,att_t_register_cycle2 i   ";
sql = sql+ " WHERE a.CHR_HOLD!='Y' AND a.CHR_TYPE !='T'  ";
sql = sql+ " AND a.INT_COMPANYID = b.INT_COMPANYID   ";
sql = sql+ " AND a.INT_BRANCHID = c.INT_BRANCHID  ";
sql = sql+ " AND a.INT_OFFICEID = d.INT_OFFICEID   ";
sql = sql+ " AND a.INT_DEPARTID = e.INT_DEPARTID   ";
sql = sql+ " AND a.INT_DESIGID = f.INT_DESIGID   ";
sql = sql+ " AND a.CHR_CATEGORY= h.INT_EMPLOYEECATEGORYID  ";
sql = sql+ " AND a.CHR_EMPID = i.CHR_EMPID  ";

if(!"0".equals(rofficeid))
	sql = sql+ " AND a.INT_OFFICEID = "+rofficeid;
else
	sql = sql + " AND a.INT_OFFICEID IN ("+officeids+"0 )";	
	
if(!"0".equals(rdept))
	sql = sql+ " AND a.INT_DEPARTID = "+rdept;
if(!"0".equals(rCategory))
	sql = sql+ " AND a.CHR_CATEGORY="+rCategory;
else
	sql = sql + " AND a.CHR_CATEGORY IN ("+catids+"0 )";

sql = sql+ " AND i.CHR_MONTH  ='"+month+"' ";
sql = sql+ " AND i.INT_YEAR = "+ryear;
sql = sql+ " ORDER BY a.CHR_STAFFNAME  ";
//out.println(sql);
String data[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
Vector mn = new Vector();
Vector child= null;
for(int u=0; u<data.length;u++)
{
	child = new Vector();
	child.addElement((u+1));
	for(int v=0;v<22;v++)
		child.addElement(data[u][v]);
	mn.add(child);
} 
request.setAttribute("table",mn);
	 
  
 
%>



<display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:caption><%=reportheader.toUpperCase()%></display:caption>
					<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="EMP ID" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="NAME" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="FATHER" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="COMPANY " sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="BRANCH" sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="OFFICEMENT" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="DEPART" sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="DESIGNATION" sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="CATEGORY" sortable="true"><%=temp.elementAt(9)%></display:column>
					<display:column title="DOJ" sortable="true"><%=temp.elementAt(10)%></display:column>
					<display:column title="PRESENT" sortable="true"><%=temp.elementAt(11)%></display:column>
					<display:column title="ONDUTY" sortable="true"><%=temp.elementAt(12)%></display:column>
					<display:column title="SUNDAY" sortable="true"><%=temp.elementAt(13)%></display:column>
					<display:column title="HOLIDAY" sortable="true"><%=temp.elementAt(14)%></display:column>
					<display:column title="LEAVE" sortable="true"><%=temp.elementAt(15)%></display:column>
					<display:column title="ABSENT" sortable="true"><%=temp.elementAt(16)%></display:column>
					<display:column title="LATE" sortable="true"><%=temp.elementAt(17)%></display:column>
					<display:column title="PERMISSION" sortable="true"><%=temp.elementAt(18)%></display:column>
					<display:column title="EXTRA DAYS" sortable="true"><%=temp.elementAt(19)%></display:column>
					<display:column title="EXTRA HOURS" sortable="true"><%=temp.elementAt(20)%></display:column>
					<display:column title="NO OF WORKING DAYS" sortable="true"><%=temp.elementAt(21)%></display:column>
					<display:column title="STATUS" sortable="true"><%=temp.elementAt(22)%></display:column>  
					
					<display:setProperty name="export.excel.filename" value="NoofAttendanceWorkingdays.xls"/>
					<display:setProperty name="export.pdf.filename" value="NoofAttendanceWorkingdays.pdf"/>
					<display:setProperty name="export.csv.filename" value="NoofAttendanceWorkingdays.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					 
</display:table>     
<br />	<center>	<a href='NoofAttendanceWorkingdaysCycle2.jsp'> CLOSE</a></center><br /><br />
 
	 		
			
			

 
</body>
<%
}
catch(Exception e)
{
}
%>
</html>
