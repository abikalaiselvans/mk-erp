<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<%@ page import="java.util.*"%>
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



<script Language="javascript">
function toExcel( ) 
{ 


var detailsTable = document.getElementById("myTable"); 

var oExcel = new ActiveXObject("Excel.Application"); 
var oBook = oExcel.Workbooks.Add; 
var oSheet = oBook.Worksheets(1); 
for (var y=0;y<detailsTable.rows.length;y++) 
{ 
for (var x=0;x<detailsTable.rows(y).cells.length;x++) 
{ 
oSheet.Cells(y+1,x+1) =detailsTable.rows(y).cells(x).innerText; 

} 
} 
oExcel.Visible = true; 
oExcel.UserControl = true; 
} 


</script> 
<br />
<%
 
String Office = request.getParameter("Office");
String dept = request.getParameter("dept");
String Basic = request.getParameter("Basic");
String Allowance = request.getParameter("Allowance");
String sorting = request.getParameter("sorting");
String ss = request.getParameter("ss");
String Exp = request.getParameter("Exp");
String sql="";


String allowancefield[][] = CommonFunctions.QueryExecute("SELECT CHR_ACODE,CHR_ANAME,CHR_FLAG FROM  pay_m_allowance ORDER BY INT_ALLOWANCEID");
String sumgrossallowancefield="";
String sumothersallowancefield="";
String allowancefields="";
String  allowancename="";
if(allowancefield.length>0)
{
	for(int u=0;u<allowancefield.length;u++)
	{
		if("Y".equals(allowancefield[u][2]))
		{
			sumgrossallowancefield =sumgrossallowancefield+ " o."+allowancefield[u][0]+"+";
		 	allowancefields =allowancefields+ " o."+allowancefield[u][0]+",";
			allowancename = allowancename+ "  "+allowancefield[u][1]+",";
		}
	}
}

String allData[]=	allowancefields.split(",");
 String allData1[]=	allowancename.split(",");
	 


sql =   " SELECT a.CHR_EMPID,a.CHR_STAFFNAME,a.CHR_STAFFFNAME,g.CHR_COMPANYNAME,f.CHR_BRANCHNAME,c.CHR_DEPARTNAME,i.CHR_DESIGNAME,b.CHR_OFFICENAME ,      round(datediff(now(),a.DT_DOJCOLLEGE)/365) ,a.INT_SALARY,";
sql = sql + allowancefields ;
sql = sql + " ( " +sumgrossallowancefield +" 0 ) , " ;
sql = sql + " ( a.INT_SALARY +" +sumgrossallowancefield +" 0 ) ,FUN_PAY_GET_PF_CALCULATION(a.CHR_EMPID,a.INT_SALARY,a.CHR_PFCALCULATIONTYPE) ," ; 

sql = sql + " FUN_PAY_GET_ESI_CALCULATION('COMPANY',a.CHR_EMPID,a.CHR_ESI)    , ";
//FUN_GET_ESIAMOUNT('company' ,a.CHR_ESI,( a.INT_SALARY +" +sumgrossallowancefield +" 0 ))

sql = sql + "(  ( a.INT_SALARY +" +sumgrossallowancefield +" 0 ) +FUN_PAY_GET_PF_CALCULATION(a.CHR_EMPID,a.INT_SALARY,a.CHR_PFCALCULATIONTYPE) + FUN_PAY_GET_ESI_CALCULATION('COMPANY',a.CHR_EMPID,a.CHR_ESI)     ) ";

//FUN_GET_ESIAMOUNT('company' ,a.CHR_ESI,( a.INT_SALARY +" +sumgrossallowancefield +" 0 ))

sql = sql + " FROM com_m_staff a , com_m_office b ,com_m_depart c ,pay_t_allowance d , ";
sql = sql + " com_m_branch f , com_m_company g, ";
sql = sql + " com_m_desig i, ";
sql = sql + " pay_t_allowance o  ";
sql = sql + " WHERE a.CHR_TYPE != 'T'  AND a.INT_DEPARTID = c.INT_DEPARTID  ";
sql = sql + " AND a.INT_OFFICEID= b.INT_OFFICEID  ";
sql = sql + " AND a.CHR_EMPID =d.CHR_EMPID  ";
sql = sql + " AND a.INT_BRANCHID =f.INT_BRANCHID  ";
sql = sql + " AND a.INT_COMPANYID =g.INT_COMPANYID  ";
sql = sql + " AND a.INT_DESIGID= i.INT_DESIGID  ";
sql = sql + " AND a.CHR_EMPID =o.CHR_EMPID   ";
if(!"0".equals(Office))
	sql = sql + " AND  a.INT_OFFICEID= "+Office;
if(!"0".equals(dept))
	sql = sql + " AND  a.INT_DEPARTID= "+dept;	
sql = sql + " ORDER BY "+sorting+" "+ss;
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
			child.addElement(data[u][7]);
			child.addElement(data[u][8]);
			child.addElement(data[u][9]);
			for(int a=0;a<allData.length;a++)
				child.addElement(data[u][(a+10)]);

			child.addElement(data[u][(10+allData.length)]);
			child.addElement(data[u][(11+allData.length)]);
			child.addElement(data[u][(12+allData.length)]);
			child.addElement(data[u][(13+allData.length)]);
			child.addElement(data[u][(14+allData.length)]);
			mn.add(child);
     } 
   
	 
	request.setAttribute("table",mn);
	out.println("<br><center><h1>GROSS DETAILS</h1></center><br>");
	
	
%>

<display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="ID" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="NAME" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="FATHER NAME" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="COMPANY " sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="BRANCH " sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="DEPARTMENT" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="DESIGNATION" sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="OFFICE  " sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="EXPERIENCE  " sortable="true"><%=temp.elementAt(9)%></display:column>
					<display:column title="BASIC" sortable="true"><%=temp.elementAt(10)%></display:column>
					<%
						 
						for(int a=0;a<allData1.length;a++)
						{
						 %>
							<display:column title="<%=allData1[a]%>" sortable="true"><%=temp.elementAt((a+10))%></display:column>
						<%
						 
						}
						 
					%>
					
		 
					 
					<display:column title="TOTAL ALLOWANCE" sortable="true"><%=temp.elementAt((11+allData.length))%></display:column>
					<display:column title="GROSS" sortable="true"><%=temp.elementAt((12+allData.length))%></display:column>
					 <display:column title="PF CONTRIBUTION" sortable="true"><%=temp.elementAt((13+allData.length))%></display:column>
					 <display:column title="ESI CONTRIBUTION" sortable="true"><%=temp.elementAt((14+allData.length))%></display:column>
					 <display:column title="CTC" sortable="true"><%=temp.elementAt((15+allData.length))%></display:column>
					 
					 
					<display:setProperty name="export.csv.filename" value="Orginalgross.csv"/>
					<display:setProperty name="export.excel.filename" value="Orginalgross.xls"/>
					<display:setProperty name="export.xml.filename" value="Orginalgross.xml"/>
					<display:setProperty name="export.pdf.filename" value="Orginalgross.pdf"/>
					<display:setProperty name="export.pdf" value="true" />
					 
</display:table> 
	
 
     
<br />
 
									<center>	<a href='GrossPay.jsp'> CLOSE</a></center>


 