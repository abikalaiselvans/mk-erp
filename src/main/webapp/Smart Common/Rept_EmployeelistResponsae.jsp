 <%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="com.my.org.erp.common.CommonInfo"%>
   
 <script language="javascript" src="../JavaScript/comfunction.js"></script>
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%><head>
<title><%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='ATT' ")[0][0]%></title>
 
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


  



<style type="text/css" media="all">
      @import url("../JavaScript/css/maven-base.css");
      @import url("../JavaScript/css/maven-theme.css");
      @import url("../JavaScript/css/site.css");
      @import url("../JavaScript/css/screen.css");
  </style> 

<%
 
String cmpy=request.getParameter("company");
String branch=request.getParameter("branch");
String Office = request.getParameter("Office");
String dept = request.getParameter("dept");
String Category=request.getParameter("Category");
String sorting = request.getParameter("sorting");
String Resigned = request.getParameter("Resigned");
String ss = request.getParameter("ss");
String sql="";


String allowancefield="";
String grossallowancefield="";
String otherallowancefield="";	 
String allowancename="";

String aname[][]=CommonFunctions.QueryExecute("SELECT CHR_ACODE,CHR_ANAME,CHR_FLAG FROM pay_m_allowance ORDER BY INT_ALLOWANCEID");
if(aname.length>0)
{
	for(int a=0;a<aname.length;a++)
	{
		allowancefield  = allowancefield +"o."+aname[a][0]+",";
		allowancename  = allowancename +aname[a][1].toUpperCase()+",";
		if("Y".equals(aname[a][2]))
			grossallowancefield  = grossallowancefield +"o."+aname[a][0]+"+";
		else
			otherallowancefield  = otherallowancefield +"o."+aname[a][0]+"+";
		
	}	
}	


//Recovery
String recoveryfield="";
String recoveryname="";
String recoverysum="";
String rname[][] = CommonFunctions.QueryExecute("SELECT CHR_RCODE,CHR_RNAME FROM pay_m_recovery ORDER BY INT_RECOVERYID");;
for(int a=0;a<rname.length;a++)
{
	recoveryfield =recoveryfield+"p."+rname[a][0]+",";
	recoveryname=recoveryname+rname[a][1]+",";
	recoverysum=recoverysum+"p."+rname[a][0]+"+";
}

 
sql = " SELECT a.CHR_EMPID,a.CHR_STAFFNAME,a.CHR_STAFFFNAME,g.CHR_COMPANYNAME,f.CHR_BRANCHNAME,  ";
sql = sql + " c.CHR_DEPARTNAME,i.CHR_DESIGNAME,b.CHR_OFFICENAME , q.CHR_CATEGORYNAME, a.INT_SALARY,  "; 

sql = sql + " "+allowancefield;
sql = sql + " ("+grossallowancefield +" 0) ,";
sql = sql + " ("+otherallowancefield +" 0) ,";
sql = sql + " (a.INT_SALARY +"+grossallowancefield +" 0) ,";

sql = sql + " "+recoveryfield; 
sql = sql + " ("+recoverysum +" 0) ,";
 

sql = sql + " if(a.CHR_PF ='C' ,'COMMON', if(a.CHR_PF ='Y' , 'YES', 'NO') ) , ";
sql = sql + " IF(a.CHR_PF ='C',CONCAT(g.CHR_PFNUMBER,a.CHR_PFNO),'NIL') , ";
sql = sql + " FUN_PAY_GET_PF_CALCULATION(a.CHR_EMPID,a.INT_SALARY,a.CHR_PFCALCULATIONTYPE) ,  ";

sql = sql + " if(a.CHR_ESI ='C' ,'COMMON', if(a.CHR_ESI ='Y' , 'YES', 'NO') ) , ";
sql = sql + " IF(a.CHR_ESI ='C' ,a.CHR_ESINO,'NIL'), ";
sql = sql + " FUN_PAY_GET_ESI_CALCULATION('STAFF',a.CHR_EMPID,a.CHR_ESI) ,  ";
//sql = sql + " FUN_GET_ESIAMOUNT('STAFF', a.CHR_ESI, (a.INT_SALARY + ("+grossallowancefield +" 0)  ) ) ,  ";

 

sql = sql + " FUN_PAY_GET_PF_CALCULATION(a.CHR_EMPID,a.INT_SALARY,a.CHR_PFCALCULATIONTYPE) ,  ";
sql = sql + " FUN_PAY_GET_ESI_CALCULATION('COMPANY',a.CHR_EMPID,a.CHR_ESI) , ";
//sql = sql + " FUN_GET_ESIAMOUNT('EMP', a.CHR_ESI, (a.INT_SALARY +  ("+grossallowancefield +" 0)   ) ) , ";



sql = sql + " (a.INT_SALARY+  ("+grossallowancefield +" 0) ) - ";
sql = sql + " ( FUN_PAY_GET_PF_CALCULATION(a.CHR_EMPID,a.INT_SALARY,a.CHR_PFCALCULATIONTYPE) ";
sql = sql + " +  FUN_PAY_GET_ESI_CALCULATION('STAFF',a.CHR_EMPID,a.CHR_ESI)  ";
sql = sql + " + (("+recoverysum +" 0)) ) , ";
sql = sql + " (a.INT_SALARY+ ("+grossallowancefield +" 0)   ) ";
sql = sql + " +( FUN_PAY_GET_PF_CALCULATION(a.CHR_EMPID,a.INT_SALARY,a.CHR_PFCALCULATIONTYPE)";
sql = sql + " + FUN_PAY_GET_ESI_CALCULATION('COMPANY',a.CHR_EMPID,a.CHR_ESI)  ";
sql = sql + " + (  ("+otherallowancefield +" 0)  ) ) , ";


sql = sql + " a.CHR_GENDER, DATE_FORMAT(a.DT_DOB,'%d-%b-%Y'), ";
sql = sql + " DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y'), ";
sql = sql + " if(a.CHR_MARITALSTATUS='U','UNMARRIED','MARRIED'),  ";
sql = sql + " DATE_FORMAT(a.DT_WEDDATE,'%d-%b-%Y'), e.CHR_QUALIFICATIONNAME , ";
sql = sql + " j.CHR_GROUPNAME, FUN_GET_ADDRESS(a.CHR_EMPID,'P',','),  ";
sql = sql + " FUN_GET_ADDRESS(a.CHR_EMPID,'C',','), a.CHR_EMAILID, a.CHR_MOBILE,  ";
sql = sql + " FIND_A_BANKGROUP_NAME(a.CHR_BANK),CONCAT('A/c : ',a.CHR_ACCNO) , ";
sql = sql + " FLOOR(PERIOD_DIFF(EXTRACT(YEAR_MONTH FROM NOW()),EXTRACT(YEAR_MONTH FROM a.DT_DOJCOLLEGE))/ 12) ,  ";
sql = sql + " IF(a.CHR_TYPE='T' ,'RESIGNED', IF(a.CHR_TYPE ='H' ,'HOLD','LIVE') ) ";
sql = sql + " FROM com_m_staff a , com_m_office b ,com_m_depart c ,pay_t_allowance d , com_m_qualification e ,  ";
sql = sql + " com_m_branch f , com_m_company g,  com_m_desig i,com_m_bloodgroup j, ";
sql = sql + " pay_t_allowance o ,pay_t_recovery p ,com_m_employeecategory q ";
sql = sql + " WHERE a.INT_DEPARTID = c.INT_DEPARTID  ";
sql = sql + " AND a.INT_OFFICEID= b.INT_OFFICEID ";
sql = sql + " AND a.CHR_EMPID =d.CHR_EMPID ";
sql = sql + " AND a.CHR_QUALIFICATION =e.INT_QUALIFICATIONID  ";
sql = sql + " AND a.INT_BRANCHID =f.INT_BRANCHID  ";
sql = sql + " AND a.INT_COMPANYID =g.INT_COMPANYID  ";
 
sql = sql + " AND a.INT_DESIGID= i.INT_DESIGID "; 
sql = sql + " AND a.CHR_BG=j.INT_BLOODGROUPID  ";
sql = sql + " AND a.CHR_EMPID =p.CHR_EMPID ";
sql = sql + " AND a.CHR_EMPID =o.CHR_EMPID ";
sql = sql + " AND a.CHR_CATEGORY= q.INT_EMPLOYEECATEGORYID ";
if(!"0".equals(cmpy))
	sql = sql + " AND  a.INT_COMPANYID= "+cmpy;
if(!"0".equals(branch))
	 	sql = sql +" AND  a.INT_BRANCHID= "+branch;
if(!"0".equals(Office))
	sql = sql + " AND  a.INT_OFFICEID= "+Office;
if(!"0".equals(dept))
	sql = sql + " AND  a.INT_DEPARTID= "+dept;	
if(!"0".equals(Category))
	sql = sql + " AND  a.CHR_CATEGORY= "+Category;		
if("N".equals(Resigned))
	sql = sql + " AND a.CHR_TYPE !='T'  ";
		
sql = sql + " ORDER BY  "+ sorting +" "+ss; 
 //out.println(sql);

 
String data[][] = CommonFunctions.QueryExecute(sql);
Vector mn = new Vector();
Vector child= null;

String Field ="";
Field = "S.No, EMPID, NAME, FATHER,COMPANY,BRANCH,DEPARTMENT, DESIGNATION,OFFICE,CATEGORY, ";	
Field = Field + " BASIC,";
Field = Field + allowancename ;
Field = Field + "SUM OF GROSS ALLOWANCE,";  
Field = Field + "SUM OF REIMBURSEMENT,";  
Field = Field + "GROSS,";  
Field = Field + recoveryname  ;
Field = Field + "SUM OF RECOVERY,"; 
Field = Field + " PF TYPE, PF NUMBER , PF AMOUNT,";   
Field = Field + " ESI TYPE, ESI NUMBER , ESI AMOUNT,";   
Field = Field + " EMPLOYEE PF , EMPLOYEE ESI ,";
Field = Field + " TOTAL, CTC ,";   
Field = Field + " GENDER,DOB,DOJ,  MARITAL STATUS, WEDDING DATE, QUALIFICATION, BLOOD GROUP, ";
Field = Field + " PERMANENT ADDRESS , COMMUNICATION ADDRESS,";
Field = Field + " EMAIL, MOBILE, BANK, A/C NUMBER, EXPERIENCE, STATUS,";

String tt[] = Field.split(",");
for(int u=0; u<data.length;u++)
{
	child = new Vector();
	child.addElement((u+1)+".");
	for(int v=0; v<tt.length-1;v++)
		child.addElement(data[u][v]);
		
	
	mn.add(child);
} 


request.setAttribute("table",mn);



%>
 
 
<display:table   id="_table" name="table"    export="true"  pagesize="25">
<display:caption><%="EMPLOYEE INFORMATIONS"%></display:caption>

	 <display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
	 <%
	for(int j=0;j<=tt.length-1;j++)
	{
	%>
		<display:column title="<%= tt[j]%>" sortable="true"><%=temp.elementAt(j)%></display:column>
	<%
	}

	%>
	<display:setProperty name="export.csv.filename" value="Salary_Report.csv"/>
	<display:setProperty name="export.excel.filename" value="Salary_Report.xls"/>
	<display:setProperty name="export.xml.filename" value="Salary_Report.xml"/>
	<display:setProperty name="export.pdf.filename" value="Salary_Report.pdf"/>
	<display:setProperty name="export.pdf" value="true" />
	 
</display:table> 
	
 

<br />
 
									<center>	<a href='Rept_Employeelist.jsp'> CLOSE</a></center>