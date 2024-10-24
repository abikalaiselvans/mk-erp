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
String sallowansql="";
String srecoverysql="";
String addedallowance="";
String extraallowance="";
String addedallowancetitle="";
String extraallowancetitle="";
String recovery="";
String recoverytitle="";
String addedsum="";
String extrasum="";
String recsum="";


	 
	String aname[][] = CommonFunctions.QueryExecute("SELECT CHR_ACODE,CHR_ANAME,CHR_FLAG FROM pay_m_allowance  ORDER BY INT_ALLOWANCEID");
	for(int a=0;a<aname.length;a++)
		if("Y".equals(aname[a][2]))
		{
			addedallowance =addedallowance+"j."+aname[a][0]+",";
			addedallowancetitle=addedallowancetitle+aname[a][1]+",";
			addedsum = addedsum+"j."+aname[a][0]+"+";
		}
		else
		{
			extraallowance =extraallowance+"j."+aname[a][0]+",";
			extraallowancetitle=extraallowancetitle+aname[a][1]+",";
			extrasum = extrasum+"j."+aname[a][0]+"+";
		}
		
		addedallowance = addedallowance.trim();
		addedallowance = addedallowance.substring(0,addedallowance.length()-1);
		addedallowancetitle = addedallowancetitle.trim();
		addedallowancetitle = addedallowancetitle.substring(0,addedallowancetitle.length()-1);
		addedsum = addedsum.trim();
		addedsum = addedsum.substring(0,addedsum.length()-1);
		
		extraallowance = extraallowance.trim();
		extraallowance = extraallowance.substring(0,extraallowance.length()-1);
		extraallowancetitle = extraallowancetitle.trim();
		extraallowancetitle = extraallowancetitle.substring(0,extraallowancetitle.length()-1);
		extrasum = extrasum.trim();
		extrasum = extrasum.substring(0,extrasum.length()-1);
		
		
		
		 
		 
	//Recovery
  
 	String rname[][] = CommonFunctions.QueryExecute("SELECT CHR_RCODE,CHR_RNAME FROM pay_m_recovery ORDER BY INT_RECOVERYID");;
 	for(int a=0;a<rname.length;a++)
	{
		recovery =recovery+"k."+rname[a][0]+",";
		recoverytitle=recoverytitle+rname[a][1]+",";
		recsum=recsum+"k."+rname[a][0]+"+";
	}
 	
	recovery = recovery.trim();
	recovery = recovery.substring(0,recovery.length()-1);
	recoverytitle = recoverytitle.trim();
	recoverytitle = recoverytitle.substring(0,recoverytitle.length()-1);
	recsum = recsum.trim();
	recsum = recsum.substring(0,recsum.length()-1);
	
	 
String Field ="";
Field = "S.No, EMPID, NAME, FATHER,COMPANY,BRANCH,OFFICE,DEPARTMENT,";	
Field = Field + " DESIGNATION, CATEGORY,GENDER,DOB,";
Field = Field + " DOJ,STAFF TYPE,EXPERIENCE, ";
Field = Field + " REPORTING TO,";
Field = Field + " REPORTING HEAD ,";
Field = Field + " PERMANENT ADDRESS , COMMUNICATION ADDRESS,";
Field = Field + " BASIC,";
Field = Field + addedallowancetitle +",";
Field = Field + extraallowancetitle +",";
Field = Field + "SUM OF GROSS ALLOWANCE,";  
Field = Field + "SUM OF REIMBURSEMENT,";  
Field = Field + "GROSS,";  
Field = Field + recoverytitle +",";
Field = Field + "SUM OF RECOVERY,"; 
Field = Field + " PF TYPE, PF NUMBER , PF AMOUNT,";   
Field = Field + " ESI TYPE, ESI NUMBER , ESI AMOUNT,";   
Field = Field + " TOTAL, CTC ,";   
Field = Field + "  BANK , ACCOUNT NUMBER, STATUS ";   
 
sql = sql + " SELECT a.CHR_EMPID,a.CHR_STAFFNAME,a.CHR_STAFFFNAME,b.CHR_COMPANYNAME,c.CHR_BRANCHNAME,d.CHR_OFFICENAME,e.CHR_DEPARTNAME, ";
sql = sql + " f.CHR_DESIGNAME,h.CHR_CATEGORYNAME, a.CHR_GENDER ,DATE_FORMAT(a.DT_DOB,'%d-%b-%Y') , ";
sql = sql + " DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y'),a.CHR_TYPE, ";

sql = sql + " CONCAT( ";
	sql = sql + " 		FLOOR(PERIOD_DIFF(DATE_FORMAT(NOW(),'%y%m') , DATE_FORMAT(a.DT_DOJCOLLEGE,'%y%m'))/12 ), ' - Years  / ' , ";
	sql = sql + " 		MOD(PERIOD_DIFF(DATE_FORMAT(NOW(),'%y%m') , DATE_FORMAT(a.DT_DOJCOLLEGE,'%y%m') ), 12) , ' - Months' ";
	sql = sql + " 		) ,";
	
sql = sql + " a.CHR_REPTO, ";
sql = sql + " if(a.CHR_REP='Y', 'Reporting Head', ' ' ), ";
sql = sql + " FUN_GET_ADDRESS(a.CHR_EMPID,'P',','), ";
sql = sql + " FUN_GET_ADDRESS(a.CHR_EMPID,'C',','), ";
sql = sql + " a.INT_SALARY, ";
sql = sql + addedallowance +","; //gross allowance
sql = sql + extraallowance+","; // extra allowance
sql = sql + "("+addedsum+"),"; // sum of gross allowance
sql = sql + "("+extrasum+"),";// sum of other allowance
sql = sql + "( a.INT_SALARY+ "+addedsum+" ) ,"; //Gross
sql = sql + recovery+","; // recovery
sql = sql + "("+recsum+"),"; // sum of recovery
sql = sql + " if(a.CHR_PF = 'C' , 'Common' , 'No'),CONCAT(b.CHR_PFNUMBER,a.CHR_PFNO),FUN_PAY_GET_PF_CALCULATION(a.CHR_EMPID,a.INT_SALARY,a.CHR_PFCALCULATIONTYPE), ";

sql = sql + " if(a.CHR_ESI = 'C' , 'Common' , 'No'),a.CHR_ESINO,"; 
sql = sql + " FUN_PAY_GET_ESI_CALCULATION('COMPANY',a.CHR_EMPID,a.CHR_ESI) , ";
//  FUN_GET_ESIAMOUNT('COMPANY',a.CHR_ESI,a.INT_SALARY )


sql = sql + "( (a.INT_SALARY+ "+addedsum+")  - ("+recsum+") + FUN_PAY_GET_PF_CALCULATION(a.CHR_EMPID,a.INT_SALARY,a.CHR_PFCALCULATIONTYPE)  +  FUN_PAY_GET_ESI_CALCULATION('COMPANY',a.CHR_EMPID,a.CHR_ESI)  ) ,";
//ESI FUN_GET_ESIAMOUNT('COMPANY',a.CHR_ESI,a.INT_SALARY ) 


sql = sql + "( (a.INT_SALARY+ "+addedsum+")  - ("+recsum+") + FUN_PAY_GET_PF_CALCULATION(a.CHR_EMPID,a.INT_SALARY,a.CHR_PFCALCULATIONTYPE)  + FUN_PAY_GET_ESI_CALCULATION('COMPANY',a.CHR_EMPID,a.CHR_ESI)  +("+extrasum+") ) ,";

//FUN_GET_ESIAMOUNT('COMPANY',a.CHR_ESI,a.INT_SALARY )  
sql = sql + "  FIND_A_BANKGROUP_NAME(a.CHR_BANK) ,a.CHR_ACCNO,IF(a.CHR_TYPE='T' ,'RESIGNED', IF(a.CHR_TYPE ='H' ,'HOLD','LIVE') )      ";
sql = sql + " FROM com_m_staff a,com_m_company b,com_m_branch c, com_m_office d,com_m_depart e,com_m_desig f, ";
sql = sql + " com_m_employeecategory h,  pay_t_allowance j,pay_t_recovery k  ";
sql = sql + " WHERE a.CHR_HOLD!='Y' ";
if("N".equals(Resigned))
	sql = sql + " AND a.CHR_TYPE !='T'  ";
else
	sql = sql + " AND a.CHR_TYPE ='T'  ";
	
sql = sql + " AND a.INT_COMPANYID = b.INT_COMPANYID  ";
sql = sql + " AND a.INT_BRANCHID = c.INT_BRANCHID ";
sql = sql + " AND a.INT_OFFICEID = d.INT_OFFICEID  ";
sql = sql + " AND a.INT_DEPARTID = e.INT_DEPARTID  ";
sql = sql + " AND a.INT_DESIGID = f.INT_DESIGID  ";
sql = sql + " AND a.CHR_CATEGORY= h.INT_EMPLOYEECATEGORYID ";
 
sql = sql + " AND a.CHR_EMPID =j.CHR_EMPID  ";
sql = sql + " AND a.CHR_EMPID =k.CHR_EMPID  ";
 
 
//out.println(sql);



 
if(!"0".equals(cmpy))
	sql = sql + " AND  a.INT_COMPANYID= "+cmpy;
 if(!"0".equals(branch))
	 	sql = sql +" AND  a.INT_BRANCHID= "+branch;
	
if(!"0".equals(Office))
	sql = sql + " AND  a.INT_OFFICEID= "+Office;
if(!"0".equals(dept))
	sql = sql + " AND  a.INT_DEPARTID= "+dept;	
	
sql = sql + " ORDER BY  "+ sorting +" "+ss; 
String data[][] = CommonFunctions.QueryExecute(sql);
Vector mn = new Vector();
Vector child= null;


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
 
 
<display:table   id="_table" name="table"    export="true"   pagesize="25">
<display:caption><%="STAFF CTC INFORMATIONS"%></display:caption>
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
 
									<center>	<a href='Rept_StaffCTCInfo.jsp'> CLOSE</a></center>