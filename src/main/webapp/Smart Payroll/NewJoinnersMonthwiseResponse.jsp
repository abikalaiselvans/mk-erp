  
<%
try
{
%>
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<%@ page import="java.util.*"%>
 <script language="javascript" src="../JavaScript/comfunction.js"></script>
   
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

<br>
<br>
<%
 
 String Office= request.getParameter("Office");
 String Dept= request.getParameter("dept");
 String Month= request.getParameter("Month");
 String Day= request.getParameter("Day");
 
 String orderby= request.getParameter("orderby");
 String Resign= request.getParameter("Resign");
 
 	
  
String sql="";
String allowancefield[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_ACODE,CHR_ANAME,CHR_FLAG FROM  pay_m_allowance ORDER BY INT_ALLOWANCEID");
String sumgrossallowancefield="";
String sumothersallowancefield="";
String allowancefields="";
if(allowancefield.length>0)
{
	for(int u=0;u<allowancefield.length;u++)
	{
		if("Y".equals(allowancefield[u][2]))
		{
			sumgrossallowancefield =sumgrossallowancefield+ " o."+allowancefield[u][0]+"+";
		 	allowancefields =allowancefields+ " o."+allowancefield[u][0]+",";
		}
	}
}

String allData[]=	allowancefields.split(",");
 
	 


sql =  " SELECT a.CHR_EMPID,a.CHR_STAFFNAME,a.CHR_STAFFFNAME,g.CHR_COMPANYNAME,f.CHR_BRANCHNAME,c.CHR_DEPARTNAME,i.CHR_DESIGNAME,b.CHR_OFFICENAME         ,DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%m-%Y'),datediff(now(),a.DT_DOJCOLLEGE)  ,a.INT_SALARY,";
sql = sql + allowancefields ;
sql = sql + " ( " +sumgrossallowancefield +" 0 ) , " ;
sql = sql + " ( a.INT_SALARY +" +sumgrossallowancefield +" 0 )  " ; 
sql = sql + " ,a.CHR_TYPE,p.CHR_CATEGORYNAME FROM com_m_staff a , com_m_office b ,com_m_depart c ,  ";
sql = sql + " com_m_branch f , com_m_company g, ";
sql = sql + " com_m_desig i, ";
sql = sql + " pay_t_allowance o ,com_m_employeecategory p ";
sql = sql + " WHERE a.INT_DEPARTID = c.INT_DEPARTID  ";
sql = sql + " AND a.INT_OFFICEID= b.INT_OFFICEID  ";
 
sql = sql + " AND a.INT_BRANCHID =f.INT_BRANCHID  ";
sql = sql + " AND a.INT_COMPANYID =g.INT_COMPANYID  ";
sql = sql + " AND a.INT_DESIGID= i.INT_DESIGID  ";
sql = sql + " AND a.CHR_EMPID =o.CHR_EMPID   AND a.CHR_CATEGORY=p.INT_EMPLOYEECATEGORYID";


if(!"0".equals(Office))
	sql = sql + " AND a.INT_OFFICEID="+Office;
if(!"0".equals(Dept))
	sql = sql + " AND a.INT_DEPARTID= "+Dept;
if("Y".equals(Resign))
	sql = sql+" AND a.CHR_TYPE !='T' ";

sql = sql+" AND MONTH(a.DT_DOJCOLLEGE ) = "+Month+" ";
sql = sql+" AND DAY(a.DT_DOJCOLLEGE ) = "+Day+" ";

sql = sql + " ORDER BY "+orderby ;
//out.println(sql); 
String Data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);




  	 
     Vector mn = new Vector();
	 Vector child= null;
	 
	  for(int u=0;u<Data.length;u++)
		{
			child = new Vector();
			child.addElement((u+1));
			if("T".equals(Data[u][(13+allData.length)]))
				 child.addElement(Data[u][0] +"***");
			else
				child.addElement(Data[u][0]  );
				
			 	
			child.addElement(Data[u][1]  );
			child.addElement(Data[u][2]  );
			child.addElement(Data[u][3]  );
			child.addElement(Data[u][4]  );
			child.addElement(Data[u][5]  );
			child.addElement(Data[u][6]  );
			child.addElement(Data[u][7]  );
			child.addElement(Data[u][8]  );
			child.addElement(Data[u][9]  );
			child.addElement(Data[u][10]  );
			child.addElement(Data[u][(11+allData.length)]  );
			child.addElement(Data[u][(12+allData.length)]  );
			  
			
			 
			 
			if("T".equals(Data[u][(13+allData.length)]))
				child.addElement("RESIGNED");
			else
				child.addElement(Data[u][(13+allData.length)] );
			
		 	child.addElement(Data[u][(14+allData.length)] );
				
			mn.add(child);  
			 
		}  
	 
	 
	 
	 
	 
   
	 
	request.setAttribute("table",mn);
	out.println("<br><center><h3> JOINNER LIST   </h3></center><br>");
 
  
   
%>



<display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.No" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="Employee Id" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="Employee Name" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="Employee Father Name" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="Company" sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="Branch" sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="Department" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="Desigination" sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="Office" sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="Date of Joinning"sortable="true"><%=temp.elementAt(9)%></display:column>
					<display:column title="Days Left" sortable="true"><%=temp.elementAt(10)%></display:column>
					<display:column title="Basic" sortable="true"><%=temp.elementAt(11)%></display:column>
					<display:column title="TOTAL ALLOWANCE" sortable="true"><%=temp.elementAt(12)%></display:column>
					<display:column title="GROSS" sortable="true"><%=temp.elementAt(13)%></display:column>
					<display:column title="STAFF STATUS" sortable="true"><%=temp.elementAt(14)%></display:column>
					<display:column title="CATEGORY" sortable="true"><%=temp.elementAt(15)%></display:column>
				 
					
					  
					
					<display:setProperty name="export.csv.filename" value="NewJoinner.csv"/>
					<display:setProperty name="export.excel.filename" value="NewJoinner.xls"/>
					<display:setProperty name="export.xml.filename" value="NewJoinner.xml"/>
					<display:setProperty name="export.pdf.filename" value="NewJoinner.pdf"/>
					<display:setProperty name="export.pdf" value="true" />
					 
</display:table>     
<br />	<center>	<a href='NewJoinnersMonthwise.jsp'> CLOSE</a>
</center>
 
	 		
			
 
<%
}
catch(Exception e)
{
 out.println(e.getMessage());
}
%>

 