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

<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">
function newwindows(staffid,year,staffname)
{
	var f ="Bonusreportindividual.jsp?staffid="+staffid+"&year="+year+"&staffname="+staffname;
	newWindow = window.open(f,"subWind",",,height=400,width=500,top=0,left=0");
	newWindow.focus( );
}	
</script>
<body  onpaste='return false;'>
 
<%
try
{
		String company =request.getParameter("company");
		String branch=request.getParameter("branch");
		String Office=request.getParameter("Office");
		String dept=request.getParameter("dept");
		String year=request.getParameter("year");
		String Category=request.getParameter("Category");
		double amount=0;
		int yr= Integer.parseInt(year);
		String sql ="";
		 
		sql = " SELECT IF(a.CHR_TYPE ='T' , CONCAT(a.CHR_EMPID,'***'),a.CHR_EMPID), a.CHR_EMPID,a.CHR_STAFFNAME ,b.DOU_TOTALBASIC,b.DOU_BONUS,b.DOU_BONUSAMOUNT,a.CHR_TYPE,a.CHR_HOLD  ";
		sql = sql +" ,c.CHR_COMPANYNAME,d.CHR_BRANCHNAME,e.CHR_DEPARTNAME,f.CHR_OFFICENAME,h.CHR_CATEGORYNAME ,b.DOU_APR,b.DOU_MAY";
		sql=sql+",b.DOU_JUN,b.DOU_JUL,b.DOU_AUG,b.DOU_SEP,b.DOU_OCT,b.DOU_NOV,b.DOU_DEC,b.DOU_JAN,b.DOU_FEB,b.DOU_MAR";
		sql = sql +" ,a.CHR_ACCNO ,FIND_A_BANKGROUP_NAME(a.CHR_BANK),b.DOU_WORKDAYS FROM com_m_staff a,pay_t_bonus b,com_m_company c,com_m_branch d ,";
		sql = sql +" com_m_depart e , com_m_office  f ,  com_m_employeecategory  h WHERE  a.CHR_EMPID is not null ";//a.CHR_TYPE !='T' 
		 
		sql = sql +" AND b.CHR_EMPID=a.CHR_EMPID  ";
		sql = sql +" AND a.INT_COMPANYID =c.INT_COMPANYID   ";
		
		sql = sql +" AND a.INT_BRANCHID =d.INT_BRANCHID   AND a.CHR_CATEGORY = h.INT_EMPLOYEECATEGORYID";
		sql = sql +" AND a.INT_DEPARTID = e.INT_DEPARTID  ";
		sql = sql +" AND a.INT_OFFICEID= f.INT_OFFICEID AND b.INT_YEAR="+year; 
		if(!"0".equals(Category))
			sql = sql+" AND a.CHR_CATEGORY ="+ Category;
		
	   if(!"0".equals(company))
			sql = sql+" AND a.INT_COMPANYID ="+ company;
			
		if(!"0".equals(branch))
			sql = sql+" AND a.INT_BRANCHID ="+ branch;
			
		if(!"0".equals(dept))
			sql = sql+" AND a.INT_DEPARTID ="+ dept;
			
		if(!"0".equals(Office))
			sql = sql+" AND a.INT_OFFICEID ="+ Office;
			
		 sql= sql+" ORDER BY a.CHR_STAFFNAME ";
		//out.println(sql);
		 
		String empdata[][] =  CommonFunctions.QueryExecute(sql);
		
		 
     Vector mn = new Vector();
	 Vector child= null;
	 
	  for(int u=0;u<empdata.length;u++)
		{
			child = new Vector();
			child.addElement((u+1));
			 
			 
				 
				if("T".equals(empdata[u][6]))
					child.addElement("<a href=\"javascript:newwindows('"+empdata[u][1]+"',"+year+",'"+empdata[u][2]+"')\"><font class='bolddeepred'>Details</font></a>");
				else if("Y".equals(empdata[u][7]))
					child.addElement("<a href=\"javascript:newwindows('"+empdata[u][1]+"',"+year+",'"+empdata[u][2]+"')\"><font class='bolddeepred'>Details</font></a>");
				else
					child.addElement("<a href=\"javascript:newwindows('"+empdata[u][1]+"',"+year+",'"+empdata[u][2]+"')\"><font class='boldEleven'>Details</font></a>");
				child.addElement(empdata[u][0]);
				child.addElement(empdata[u][2]);
				child.addElement(empdata[u][8]);
				child.addElement(empdata[u][9]);
				child.addElement(empdata[u][10]);
				child.addElement(empdata[u][11]);
				child.addElement(empdata[u][12]);
				
				child.addElement(empdata[u][13]);
				child.addElement(empdata[u][14]);
				child.addElement(empdata[u][15]);
				child.addElement(empdata[u][16]);
				child.addElement(empdata[u][17]);
				child.addElement(empdata[u][18]);
				child.addElement(empdata[u][19]);
				child.addElement(empdata[u][20]);
				child.addElement(empdata[u][21]);
				child.addElement(empdata[u][22]);
				child.addElement(empdata[u][23]);
				child.addElement(empdata[u][24]);
				child.addElement(empdata[u][25]);
				child.addElement(empdata[u][26]);
				child.addElement(empdata[u][27]);
				
				child.addElement(empdata[u][3]);
				child.addElement(empdata[u][4]);
				
				amount=Double.parseDouble(empdata[u][5]);
				if(amount>0)
					child.addElement(empdata[u][5]);
				else
					child.addElement("***");
				
			mn.add(child);  
			 
		}  
	 
	 
	 
	request.setAttribute("table",mn);
	out.println("<br><center><h3>BONUS REPORT FOR THE YEAR "+year +" - "+(Integer.parseInt(year)+1)+"  </h3></center><br>");
 
  
	 
	 
	 
   
    
		
		
		%>
		
		
		
		
<display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.No" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="Details" sortable="true"><%=temp.elementAt(1)%></display:column>
                    <display:column title="Employee Id" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="Employee Name" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="Company" sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="Branch" sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="Department" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="Office" sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="Category"sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="APR" sortable="true"><%=temp.elementAt(9)%></display:column>
					<display:column title="MAY" sortable="true"><%=temp.elementAt(10)%></display:column>
					<display:column title=" JUN" sortable="true"><%=temp.elementAt(11)%></display:column>
					<display:column title=" JUL" sortable="true"><%=temp.elementAt(12)%></display:column>
					<display:column title="AUG " sortable="true"><%=temp.elementAt(13)%></display:column>
					<display:column title=" SEP" sortable="true"><%=temp.elementAt(14)%></display:column>
				    <display:column title="OCT " sortable="true"><%=temp.elementAt(15)%></display:column>
					<display:column title="NOV " sortable="true"><%=temp.elementAt(16)%></display:column>
					<display:column title="DEC " sortable="true"><%=temp.elementAt(17)%></display:column>
					<display:column title="JAN " sortable="true"><%=temp.elementAt(18)%></display:column>
					<display:column title="FEB " sortable="true"><%=temp.elementAt(19)%></display:column>
					<display:column title="MAR " sortable="true"><%=temp.elementAt(20)%></display:column>
					<display:column title="Account No " sortable="true"><%=temp.elementAt(21)%></display:column>
					<display:column title="Bank Name " sortable="true"><%=temp.elementAt(22)%></display:column>
					<display:column title="No of Working Days" sortable="true"><%=temp.elementAt(23)%></display:column>
					<display:column title="Total Basic" sortable="true"><%=temp.elementAt(24)%></display:column>
					<display:column title="Bonus Percentage" sortable="true"><%=temp.elementAt(25)%></display:column>
					<display:column title="Bonus Amount" sortable="true"><%=temp.elementAt(26)%></display:column>
					
					
					
					 
					
					<display:setProperty name="export.csv.filename" value="BonusReport.csv"/>
					<display:setProperty name="export.excel.filename" value="BonusReport.xls"/>
					<display:setProperty name="export.xml.filename" value="BonusReport.xml"/>
					<display:setProperty name="export.pdf.filename" value="BonusReport.pdf"/>
					<display:setProperty name="export.pdf" value="true" />
					
					
					
					
					 
					
					
		 
		
		
		 
</display:table>     
		
		<br />	<center>	<a href='BonusReport.jsp'> CLOSE</a></center>

		
		<%
}
catch(Exception e)
{
}
%>
</body>
</html>
