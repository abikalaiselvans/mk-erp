 
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<%@ page import="java.util.*"%>
 <script language="javascript" src="../JavaScript/comfunction.js"></script>
   
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*,com.my.org.erp.common.*"%>
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
<title> :: PAYROLL ::</title>


 
  


  
 
<style type="text/css" media="all">
      @import url("../JavaScript/css/maven-base.css");
      @import url("../JavaScript/css/maven-theme.css");
      @import url("../JavaScript/css/site.css");
      @import url("../JavaScript/css/screen.css");
  </style> 
</head>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="javascript" src="../JavaScript/Attendance/ReportAjax.js"></script>
<script language="javascript">
	function disableMonthWise()
	{
		document.frm.year.disabled=false;
		document.frm.month.disabled=false;
		document.frm.frmdate.disabled=true;
		document.frm.todate.disabled=true;		
	}
	function disableYearWise()
	{
		document.frm.year.disabled=true;
		document.frm.month.disabled=true;
		document.frm.frmdate.disabled=false;
		document.frm.todate.disabled=false;
	}
	</script>
 
<body  onpaste='return false;'>
  
	  <%
	  	
try
{	
		String  company  = request.getParameter("company");
		String  branch  = request.getParameter("branch");
		String  Office  = request.getParameter("Office");
		String  Dept= request.getParameter("dept");
		String  orderby= request.getParameter("orderby");
		String  Category=request.getParameter("Category");
		String  resigned= request.getParameter("Resign"); 
		String  fmdate= request.getParameter("frmdate");
 		String  todate= request.getParameter("todate");
		String  fdate=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(fmdate);
 		String  tdate=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(todate);
		
		String sql ="";
		
sql = " SELECT a.CHR_EMPID,a.CHR_STAFFNAME,a.CHR_STAFFFNAME,g.CHR_COMPANYNAME,f.CHR_BRANCHNAME,b.CHR_OFFICENAME,c.CHR_DEPARTNAME,  ";
sql = sql + " i.CHR_DESIGNAME , q.CHR_CATEGORYNAME,a.CHR_PF ,CONCAT(g.CHR_PFNUMBER,a.CHR_PFNO),a.CHR_ESI ,a.CHR_ESINO,   ";
sql = sql + " a.CHR_GENDER, DATE_FORMAT(a.DT_DOB,'%d-%m-%Y'),DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%m-%Y'),  ";
sql = sql + " CONCAT(a.CHR_PADD1,',',a.CHR_PADD2,',',n.CHR_CITYNAME,',',m.CHR_DISTRICT,',',l.CHR_STATENAME,',',k.CHR_COUNTRYNAME,',Pincode : ',a.CHR_PPIN,', Phone : ',a.CHR_PPHONE),   ";
//sql = sql + " CONCAT(a.CHR_SADD1,',',a.CHR_SADD2,',',n.CHR_CITYNAME,',',m.CHR_DISTRICT,',',l.CHR_STATENAME,',',k.CHR_COUNTRYNAME,',Pincode : ',a.CHR_SPIN,', Phone : ',a.CHR_SPHONE) ,   ";
sql = sql + " a.CHR_EMAILID, a.CHR_MOBILE,a.CHR_TYPE    ";

sql = sql + " FROM com_m_staff a , com_m_office b ,com_m_depart c ,com_m_branch f , com_m_company g,   ";
sql = sql + " com_m_desig i,com_m_country k,com_m_state l,  ";
sql = sql + " com_m_district m,com_m_city n ,com_m_employeecategory q  ";
sql = sql + " WHERE a.INT_DEPARTID = c.INT_DEPARTID   ";
sql = sql + " AND a.INT_OFFICEID= b.INT_OFFICEID   ";
sql = sql + " AND a.INT_BRANCHID =f.INT_BRANCHID   ";
sql = sql + " AND a.INT_COMPANYID =g.INT_COMPANYID   ";
sql = sql + " AND a.INT_DESIGID= i.INT_DESIGID   ";
sql = sql + " AND a.CHR_PCITY = n.INT_CITYID  "; 
sql = sql + " AND a.INT_PDISTRICTID=m.INT_DISTRICTID   ";
sql = sql + " AND a.CHR_PSTATE=l.INT_STATEID   ";
sql = sql + " AND a.INT_PCOUNTRYID =k.INT_COUNTRYID  "; 

//sql = sql + " AND a.CHR_SCITY = n.INT_CITYID   ";
//sql = sql + " AND a.INT_CDISTRICTID=m.INT_DISTRICTID   ";
//sql = sql + " AND a.CHR_SSTATE=l.INT_STATEID   ";
//sql = sql + " AND a.INT_CCOUNTRY =k.INT_COUNTRYID   ";


sql = sql + " AND a.CHR_CATEGORY= q.INT_EMPLOYEECATEGORYID  ";

if(!"0".equals(company))
	sql = sql + " AND a.INT_COMPANYID="+company;
		
if(!"-1".equals(branch))
	sql = sql + " AND a.INT_BRANCHID="+branch;

 		
if(!"0".equals(Office))
	sql = sql + " AND a.INT_OFFICEID="+Office;
if(!"0".equals(Dept))
	sql = sql + " AND a.INT_DEPARTID= "+Dept;

if(!"0".equals(Category))
	sql = sql + "  AND a.CHR_CATEGORY='"+Category +"' ";
	
//if(!"Y".equals(resigned))
	//sql = sql + "   AND a.CHR_TYPE!='T'";


sql = sql+" AND a.DAT_PFESIDATE >= '"+fdate+"' ";
sql = sql+" AND a.DAT_PFESIDATE <= '"+tdate+"' "; 


sql = sql + " ORDER BY  "+orderby;
//out.println(sql+"<br>");
String Data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
 
  
    	Vector mn = new Vector();
		Vector child= null;
	 
		for(int u=0;u<Data.length;u++)
		{
				child = new Vector();
				child.addElement((u+1));
				
				if(!"T".equals(Data[u][19])) 
					child.addElement(Data[u][0]);
				else
					child.addElement(Data[u][0]+"****");
						
					 
					child.addElement(Data[u][1] );	
					child.addElement(Data[u][2] );
					child.addElement("-");
					
					child.addElement(Data[u][3] );	
					child.addElement(Data[u][4] );	
					child.addElement(Data[u][5] );	
					child.addElement(Data[u][6] );	
					child.addElement(Data[u][7] );	
					child.addElement(Data[u][8] );	
					child.addElement(Data[u][10] );
					child.addElement(Data[u][12] );	
					child.addElement(Data[u][13] );	
					child.addElement(Data[u][14] );	
					child.addElement(Data[u][15] );	
					child.addElement(Data[u][16] );	
					child.addElement("-" );	
					 
					child.addElement(Data[u][18] );	
					child.addElement(Data[u][19] );
				 
						 
				mn.add(child);  
				 
		}  
	 
	 
	 
	 
	 
   
	 
	request.setAttribute("table",mn);
	out.println("<br><center><h3> STAFF INFORMATIONS </h3></center><br>");
 
  

    %>
	  
<display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.No" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="Employee Id" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="Employee Name" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="Father/ Husband Name" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="Nominee Name" sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="Company" sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="Branch " sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title=" Office" sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="Department" sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="Desigination" sortable="true"><%=temp.elementAt(9)%></display:column>
					 <display:column title="Category" sortable="true"><%=temp.elementAt(10)%></display:column>
					<display:column title=" PF NUMBER" sortable="true"><%=temp.elementAt(11)%></display:column>
					<display:column title=" ESI NUMBER " sortable="true"><%=temp.elementAt(12)%></display:column>
					<display:column title="GENDER " sortable="true"><%=temp.elementAt(13)%></display:column>
					<display:column title="DOB " sortable="true"><%=temp.elementAt(14)%></display:column>
					<display:column title="DOJ " sortable="true"><%=temp.elementAt(15)%></display:column>
					<display:column title="Permanent Address " sortable="true"><%=temp.elementAt(16)%></display:column>
					<display:column title="MAIL " sortable="true"><%=temp.elementAt(17)%></display:column>
					 <display:column title="MOBILE " sortable="true"><%=temp.elementAt(18)%></display:column>
			   
					 
					<display:setProperty name="export.csv.filename" value="ESI_FORMS.csv"/>
					<display:setProperty name="export.excel.filename" value="ESI_FORMS.xls"/>
					<display:setProperty name="export.xml.filename" value="ESI_FORMS.xml"/>
					<display:setProperty name="export.pdf.filename" value="ESI_FORMS.pdf"/>
					<display:setProperty name="export.pdf" value="true" />
					 
</display:table>     	
<br />	<center>	<a href='ESI_FORMS.jsp'> CLOSE</a></center>
 <%
 }
 catch(Exception e)
 {
 	out.println(e.getMessage());
 }
 %>
</body>
</html>
