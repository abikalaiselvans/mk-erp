 <%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*,com.my.org.erp.common.*,com.my.org.erp.Math.*"%>
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<%@ page import="java.util.*"%>
<%
try
{
%>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/Attendance/ReportAjax.js"></script>
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*,com.my.org.erp.common.*"%><head>
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


<title> :: PAYROLL ::</title>


  

<br>
<br>


<%
 
 
	String sql ="";
	String  company  = request.getParameter("company");
	String  branch  = request.getParameter("branch");
	String  Office  = request.getParameter("Office");
	String Dept= request.getParameter("Dept");
	String orderby= request.getParameter("orderby");
	String Category=request.getParameter("Category");
	String resigned= request.getParameter("resigned");
	String dojFilter= request.getParameter("dojFilter");
	String doj= request.getParameter("doj");
	String doj2= request.getParameter("doj2");
	
	
	String allowancefield[][] = CommonFunctions.QueryExecute("SELECT CHR_ACODE,CHR_ANAME,CHR_FLAG FROM  pay_m_allowance ORDER BY INT_ALLOWANCEID");
	String sumgrossallowancefield="";
	String sumothersallowancefield="";
	String allowancefields="";
	
	if(allowancefield.length>0)
	{
		for(int u=0;u<allowancefield.length;u++)
		{
			if("Y".equals(allowancefield[u][2]))
				sumgrossallowancefield =sumgrossallowancefield+ " o."+allowancefield[u][0]+"+";
			else
				sumothersallowancefield =sumothersallowancefield+ " o."+allowancefield[u][0]+"+";
				
			allowancefields =allowancefields+ " o."+allowancefield[u][0]+",";
		}
 	}
	
	
	 
	 
	String recoveryfield[][] = CommonFunctions.QueryExecute("SELECT CHR_RCODE,CHR_RNAME  FROM  pay_m_recovery ORDER BY INT_RECOVERYID");
	String sumrecoveryfield="";
	String recoveryfields="";
	if(recoveryfield.length>0)
	{
		for(int u=0;u<recoveryfield.length;u++)
		{
			sumrecoveryfield =sumrecoveryfield+ " p."+recoveryfield[u][0]+"+";
			recoveryfields =recoveryfields+ " p."+recoveryfield[u][0]+",";
			
		}
 	}
	
sql = " SELECT a.CHR_EMPID,UPPER(a.CHR_STAFFNAME),UPPER(a.CHR_STAFFFNAME),UPPER(g.CHR_COMPANYNAME),UPPER(f.CHR_BRANCHNAME),";
sql = sql + " UPPER(c.CHR_DEPARTNAME),UPPER(i.CHR_DESIGNAME),UPPER(b.CHR_OFFICENAME) , ";
sql = sql + " q.CHR_CATEGORYNAME, a.DT_DOJCOLLEGE,";

sql = sql + " CONCAT( ";
	sql = sql + " 		FLOOR(PERIOD_DIFF(DATE_FORMAT(NOW(),'%y%m') , DATE_FORMAT(a.DT_DOJCOLLEGE,'%y%m'))/12 ), ' - Years  / ' , ";
	sql = sql + " 		MOD(PERIOD_DIFF(DATE_FORMAT(NOW(),'%y%m') , DATE_FORMAT(a.DT_DOJCOLLEGE,'%y%m') ), 12) , ' - Months' ";
	sql = sql + " 		) ,";
 
 
sql = sql + "  a.INT_SALARY, ";

sql = sql + allowancefields ;
sql = sql + " ( " +sumgrossallowancefield +" 0 ) grossallowance , " ;
sql = sql + " ( " +sumothersallowancefield +" 0 ) otherallowance , " ;
sql = sql + " ( a.INT_SALARY +" +sumgrossallowancefield +" 0 ) gross , " ; 
sql = sql + recoveryfields;
sql = sql + " ( " +sumrecoveryfield +" 0 ) recovery, " ; 

sql = sql + "  if(a.CHR_PF ='C' ,'COMMON', if(a.CHR_PF ='Y' , 'YES', 'NO') ) pftype , ";
sql = sql + "  IF(a.CHR_PF ='C',CONCAT(g.CHR_PFNUMBER,a.CHR_PFNO),'NIL') pfnumber, ";
sql = sql + "  FUN_GET_PFAMOUNT(a.CHR_PF,a.INT_SALARY) pfamount ,";

sql = sql + "  if(a.CHR_ESI ='C' ,'COMMON', if(a.CHR_ESI ='Y' , 'YES', 'NO') ) esitype ,";
sql = sql + "  IF(a.CHR_ESI ='C' ,a.CHR_ESINO,'NIL') esinumber, ";
sql = sql + "  FUN_GET_ESIAMOUNT('STAFF', a.CHR_ESI,  (a.INT_SALARY +" +sumgrossallowancefield +" 0) ) esiamount,";

sql = sql + "  FUN_GET_PFAMOUNT(a.CHR_PF,a.INT_SALARY) cpypfamount,";
sql = sql + "  FUN_GET_ESIAMOUNT('EMP', a.CHR_ESI,  (a.INT_SALARY +" +sumgrossallowancefield +" 0) )  cpyesiamount ,";

sql = sql + " (   (a.INT_SALARY+"+sumgrossallowancefield +"0)   -(  FUN_GET_PFAMOUNT(a.CHR_PF,a.INT_SALARY)  +    FUN_GET_ESIAMOUNT('STAFF', a.CHR_ESI,(a.INT_SALARY +" +sumgrossallowancefield +" 0)) + (" +sumrecoveryfield +"0) )  ) total," ; 

sql = sql + "(  (a.INT_SALARY+"+sumgrossallowancefield +"0)   +(  FUN_GET_PFAMOUNT(a.CHR_PF,a.INT_SALARY)  +    FUN_GET_ESIAMOUNT('EMP', a.CHR_ESI,(a.INT_SALARY +" +sumgrossallowancefield +" 0))+(" +sumothersallowancefield +" 0 )) ) ctc ," ; 

 
sql = sql + " UPPER(a.CHR_GENDER), DATE_FORMAT(a.DT_DOB,'%d-%b-%Y'), ";
sql = sql + " DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y'),if(a.CHR_MARITALSTATUS='U','UNMARRIED','MARRIED'), ";
sql = sql + " DATE_FORMAT(a.DT_WEDDATE,'%d-%b-%Y'), e.CHR_QUALIFICATIONNAME ,j.CHR_GROUPNAME,  ";
sql = sql + " FUN_GET_ADDRESS(a.CHR_EMPID,'P',','), ";
sql = sql + " FUN_GET_ADDRESS(a.CHR_EMPID,'C',','), ";
sql = sql + " a.CHR_EMAILID, a.CHR_MOBILE,   ";
sql = sql + " h.CHR_BANKGROUPNAME, "; 
sql = sql + " CONCAT('A/c : ',a.CHR_ACCNO)  , UPPER(a.CHR_IFSC), ";
sql = sql +"   FLOOR(PERIOD_DIFF(EXTRACT(YEAR_MONTH FROM NOW()),EXTRACT(YEAR_MONTH FROM a.DT_DOJCOLLEGE))/ 12) experience, ";
sql = sql + " IF(a.CHR_TYPE='T' ,CONCAT( DATE_FORMAT(a.DAT_RESIGNDATE,'%d-%b-%Y') ,'/ RESIGNED'), IF(a.CHR_TYPE ='H' ,'HOLD','LIVE') ) status,a.CHR_EMPID,UPPER(a.CHR_STAFFNAME) ";
sql = sql + " FROM com_m_staff a , com_m_office b ,com_m_depart c ,pay_t_allowance d , ";
sql = sql + " com_m_qualification e , com_m_branch f , com_m_company g, com_m_bankgroup h, ";
sql = sql + " com_m_desig i,com_m_bloodgroup j,  ";
sql = sql + " pay_t_allowance o ,pay_t_recovery p ,com_m_employeecategory q ";
sql = sql + " WHERE a.INT_DEPARTID = c.INT_DEPARTID     ";//AND a.CHR_TYPE!='T'   AND a.CHR_HOLD !='Y' 
sql = sql + " AND a.INT_OFFICEID= b.INT_OFFICEID  ";
sql = sql + " AND a.CHR_EMPID =d.CHR_EMPID  ";
sql = sql + " AND a.CHR_QUALIFICATION =e.INT_QUALIFICATIONID  ";
sql = sql + " AND a.INT_BRANCHID =f.INT_BRANCHID  ";
sql = sql + " AND a.INT_COMPANYID =g.INT_COMPANYID  ";
sql = sql + " AND a.CHR_BANK = h.INT_BANKGROUPID  ";
sql = sql + " AND a.INT_DESIGID= i.INT_DESIGID  ";
sql = sql + " AND a.CHR_BG=j.INT_BLOODGROUPID  ";
sql = sql + " AND a.CHR_EMPID =p.CHR_EMPID  ";
sql = sql + " AND a.CHR_EMPID =o.CHR_EMPID  ";
sql = sql + " AND a.CHR_CATEGORY= q.INT_EMPLOYEECATEGORYID ";
if(!company.equals("0"))
	sql=sql+" AND a.INT_COMPANYID="+company;	
if(!branch.equals("0"))
	sql=sql+" AND a.INT_BRANCHID="+branch;	
		 	
if(!"0".equals(Office))
	sql = sql + " AND a.INT_OFFICEID="+Office;
if(!"0".equals(Dept))
	sql = sql + " AND a.INT_DEPARTID= "+Dept;
if(!"0".equals(Category))
	sql = sql + "  AND a.CHR_CATEGORY="+Category +" ";

if("Y".equals(resigned))
	sql = sql + "   AND a.CHR_TYPE='T'";
 	
if("Y".equals(dojFilter))	
{
	sql = sql + " AND a.DT_DOJCOLLEGE >= '"+DateUtil.FormateDateSQL(doj)	+"' " ;
	sql = sql + " AND a.DT_DOJCOLLEGE <= '"+DateUtil.FormateDateSQL(doj2)	+"' " ;
}
	
sql = sql + " ORDER BY  "+orderby;

//out.println(sql);
String Data[][] =CommonFunctions.QueryExecute(sql);

String repHeaders="";
repHeaders = "S.NO,EMP-ID, STAFF-NAME, STAFF-FATHERNAME, COMPANY, BRANCH, DEPARTMENT, DESIGNATION, OFFICE, CATEGORY,DOJ, EXPERIENCE, BASIC,";
if(allowancefield.length>0)
	for(int u=0;u<allowancefield.length;u++)
		repHeaders = repHeaders + allowancefield[u][1]+",";
repHeaders = repHeaders + "SUM OF GROSS-ALLOWANCE , SUM OF REIMBURSEMENT , GROSS, ";
 
if(recoveryfield.length>0)
	for(int u=0;u<recoveryfield.length;u++)
		repHeaders = repHeaders + recoveryfield[u][1]+",";
		
repHeaders = repHeaders + "SUM OF RECOVERY,";
repHeaders = repHeaders + "PF-TYPE, PF-NUMBER, PF EMPLOYEE-CONTRIBUTION, ";
repHeaders = repHeaders + "ESI-TYPE, ESI-NUMBER, ESI EMPLOYEE-CONTRIBUTION, ";
repHeaders = repHeaders + "PF EMPLOYEER-CONTRIBUTION, ";
repHeaders = repHeaders + "ESI EMPLOYEER-CONTRIBUTION, ";
repHeaders = repHeaders + "TOTAL, CTC,";
repHeaders = repHeaders + " GENEDDER, DOB, DOJ, MARTIAL STATUS, WEDDING DATE, QUALIFICATION, BLOOD GROUP,";
repHeaders = repHeaders + "PERMANENT ADDRESS, COMMUNICATION ADDRESS,  ";
repHeaders = repHeaders + " EMAIL,MOBILE, ";
repHeaders = repHeaders + " ";
repHeaders = repHeaders + " BANK,A/C NUMBER,IFSC CODE,EXPERIENCE,STATUS,EMP-ID, STAFF-NAME";
String col[] =	repHeaders.split(",");

 
Vector mn = new Vector();
Vector child= null;
for(int u=0;u<Data.length;u++)
{		
	
	child = new Vector();
	child.addElement(""+(u+1));
	for(int x=0;x<col.length-1;x++)
		child.addElement(""+Data[u][x]);
	mn.add(child);	
} 

	
request.setAttribute("table",mn);
out.println("<br><center><h3> PERSONAL INFORMATIONS AND GROSS DETAILS </h3></center><br>");
 %>
	
 
					
					
	<display:table   id="_table" name="table"   export="true" pagesize="25">

		<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
		<%
		 for(int a=0;a<col.length-2;a++)
		 {
		 %>
		 <display:column title="<%=col[a]%>" sortable="true"><%=temp.elementAt(a)%></display:column>
		 <%
		 }
		 
		%>
		<display:setProperty name="export.csv.filename" value="Rept_OriginalSalary.csv"/>
		<display:setProperty name="export.excel.filename" value="Rept_OriginalSalary.xls"/>
		<display:setProperty name="export.xml.filename" value="Rept_OriginalSalary.xml"/>
		<display:setProperty name="export.pdf.filename" value="Rept_OriginalSalary.pdf"/>
		<display:setProperty name="export.pdf" value="true" />
					 
</display:table>     
<% 

 
 


}
catch(Exception e)
{
	out.println(e.getMessage());
}
 %>
 
 <br>
 <br />	<center>	<a href='OriginalSalary.jsp'> CLOSE</a></center>
