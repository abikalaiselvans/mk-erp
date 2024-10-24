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
<body  onpaste='return false;'>
 
<br>
<br>
<%
try
{
	String sql="";
	String company="";
	String branch="";
	String Office="";
	String cpy="";
	String bra="";
	String off="";
	 
	company = request.getParameter("company");
	branch = request.getParameter("branch");
	Office = request.getParameter("Office");
	 
	 
 
String AllowanceData[][] = CommonFunctions.QueryExecute("SELECT CHR_ACODE,CHR_ANAME  FROM pay_m_allowance WHERE CHR_FLAG='Y' ORDER BY CHR_ACODE");
String salaryband="   ";
for(int u=0; u<AllowanceData.length;u++)
	salaryband = salaryband+"  a."+AllowanceData[u][0]+"+ "; 
salaryband=salaryband.trim();
salaryband = salaryband.substring(0,salaryband.length()-1);			

  
sql = " SELECT   ";
sql = sql + " (SELECT COUNT(*)  FROM pay_t_rivision e WHERE e.CHR_EMPID=a.CHR_EMPID),   ";
sql = sql +  " a.CHR_EMPID,a.CHR_STAFFNAME, b.CHR_OFFICENAME,c.CHR_DEPARTNAME,d.CHR_CATEGORYNAME,   ";
sql = sql +  " (select f.CHR_STAFFNAME  from com_m_staff f WHERE f.CHR_EMPID=a.CHR_REPTO  )  ,a.CHR_TYPE,     "; 
sql = sql +  " DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y'), datediff(now(),a.DT_DOJCOLLEGE)/365     "; 
sql = sql +  " FROM com_m_staff a , com_m_office b,com_m_depart c, com_m_employeecategory d   ";
sql = sql + " WHERE    a.INT_OFFICEID = b.INT_OFFICEID    ";
sql = sql + " AND a.INT_DEPARTID = c.INT_DEPARTID    ";
sql = sql + " AND a.CHR_CATEGORY= d.INT_EMPLOYEECATEGORYID     ";
sql = sql +" AND A.INT_COMPANYID=  "+company;
if(!"0".equals(branch))
		sql = sql +"  AND A.INT_BRANCHID=  "+branch;
if(!"0".equals(Office))
		sql = sql +"  AND A.INT_OFFICEID=  "+Office;
                
sql = sql +" ORDER BY A.CHR_STAFFNAME  ";
//out.println(sql);
String data[][] =  CommonFunctions.QueryExecute(sql);
String cpdata[][] =  CommonFunctions.QueryExecute("SELECT upper(CHR_COMPANYNAME) FROM com_m_company where INT_COMPANYID =" +company);

Vector mn = new Vector();
Vector child= null;
String nexteffective="";
for(int u=0;u<data.length;u++)
{
	
	child = new Vector();
	child.addElement((u+1));
	if("T".equals(data[u][7]))
		child.addElement(data[u][1]+"***");
	else
		child.addElement(data[u][1]);
		
	child.addElement(data[u][2]);
	child.addElement(data[u][0]);
	child.addElement(data[u][3]  );
	child.addElement(data[u][4]  );
	child.addElement(data[u][5]  );
	child.addElement(data[u][6]  );	
	nexteffective=""; 
	 
	 
	 //PREVIOUS INCREMENT
	 
	 if(Integer.parseInt(data[u][0]) >1)
	 {
		
		if((Integer.parseInt(data[u][0])-1)<1)
		{
			child.addElement("" );	
			child.addElement("" );	
			child.addElement("" );	
			child.addElement("" );	
			child.addElement("" );	
		}
		else
		{
			sql = "  SELECT  DATE_FORMAT(a.DAT_EFFECT,'%d-%b-%Y'), a.INT_BASIC,a.INT_INCREMENT,("+salaryband+"), ";
			sql = sql+ "(a.INT_BASIC+a.INT_INCREMENT+"+salaryband+")  FROM pay_t_rivision a ,com_m_staff b  ";
			sql = sql +" WHERE a.CHR_EMPID= b.CHR_EMPID  AND a.CHR_EMPID='"+data[u][1]+"'  AND a.INT_RIVISIONID= "+(Integer.parseInt(data[u][0])-1);
	    	String pdata[][] = CommonFunctions.QueryExecute(sql);
			child.addElement(pdata[0][0]  );	
			child.addElement(pdata[0][1]  );
			child.addElement(pdata[0][2]  );
			child.addElement(pdata[0][3]  );
			child.addElement(pdata[0][4]  );
		}
		 
	 }
	 else
	 {
		child.addElement("" );	
		child.addElement("" );	
		child.addElement("" );	
		child.addElement("" );	
		child.addElement("" );	
	 }
	 
	 
	 //CURRENT INCREMENT
	 
	 if(Integer.parseInt(data[u][0]) >0)
	 {
	 	  nexteffective="";
		  sql = " SELECT   a.INT_RIVISIONID,a.INT_BASIC,a.INT_INCREMENT,(a.A001+ a.A0011+ a.A002+ a.A003+ a.A004+ a.A005+ a.A006),  ";
		  sql = sql +" (a.INT_BASIC+a.INT_INCREMENT+a.A001+ a.A0011+ a.A002+ a.A003+ a.A004+ a.A005+ a.A006),  ";
		  sql = sql +" DATE_FORMAT(a.DAT_EFFECT,'%d-%b-%Y'),a.CHR_MONTH,a.INT_YEAR,  "; 
		  sql = sql +" (select DATE_FORMAT(DATE_ADD(a.DAT_EFFECT, INTERVAL 365 DAY),'%d-%b-%Y'))  ";
		  sql = sql +" FROM pay_t_rivision a   ";
		  sql = sql +"  WHERE a.INT_RIVISIONID =( SELECT MAX(g.INT_RIVISIONID) FROM pay_t_rivision g WHERE g.CHR_EMPID='"+data[u][1]+"')  "; 
		  sql = sql +"  AND  a.CHR_EMPID='"+data[u][1]+"'  ";
		  String pdata[][] =  CommonFunctions.QueryExecute(sql);
		 child.addElement(pdata[0][1]  );
		 child.addElement(pdata[0][2]  );
		 child.addElement(pdata[0][3]  );
		 child.addElement(pdata[0][4]  );	
		 child.addElement(pdata[0][5]  );
		 child.addElement(pdata[0][6]  );
		 child.addElement(pdata[0][7]  );	
		 nexteffective	=pdata[0][8];
			 
   
	 }
	 else
	 {
		nexteffective="";
		child.addElement("" );	
		child.addElement("" );	
		child.addElement("" );	
		child.addElement("" );	
		child.addElement("" );	
		child.addElement("" );	
		child.addElement("" );	
	 }
	 
	 
   
	 
	 
	 
	 if("T".equals(data[u][7]))
		child.addElement("Resigned");	
	 else
		child.addElement("Live");
		
	
	child.addElement(data[u][8]  );	
	child.addElement(data[u][9]  );	
	
	child.addElement(nexteffective  );	
			
	 if(Integer.parseInt(data[u][0]) >0)
	 	child.addElement(" <a href=\"javascript:Rivisionquery('IndividulaRivisionView.jsp?empid="+data[u][1]+"')\"><font class='bolddeepred'>View Detials</font>");
	 else
	   	child.addElement("");	
	 mn.add(child);  
	 
	 
}
	 
	 
	 
	request.setAttribute("table",mn);
	out.println("<br><center><h3> REVISION REPORT FOR ALL EMPLOYEE - "+cpdata[0][0]+" </h3></center><br>");
 
  
 %>
 
 

<display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.No" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="Employee Id" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="Employee Name" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="No of Rivision" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="Office " sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="Depart " sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="Category " sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title=" Reporting To" sortable="true"><%=temp.elementAt(7)%></display:column>
					
					<display:column title="Last Effective Date " sortable="true"><%="<font class='bolddeepred'>"+temp.elementAt(8)+"</font>"%></display:column>
					<display:column title="Last Basic "sortable="true"><%="<font class='bolddeepred'>"+temp.elementAt(9)+"</font>"%></display:column>
					<display:column title="Last Increment " sortable="true"><%="<font class='bolddeepred'>"+temp.elementAt(10)+"</font>"%></display:column>
					<display:column title="Last Allowance " sortable="true"><%="<font class='bolddeepred'>"+temp.elementAt(11)+"</font>"%></display:column>
					<display:column title="Last Gross" sortable="true"><%="<font class='bolddeepred'>"+temp.elementAt(12)+"</font>"%></display:column>

					<display:column title="Basic " sortable="true"><%=temp.elementAt(13)%></display:column>
					<display:column title="Increment " sortable="true"><%=temp.elementAt(14)%></display:column>
					<display:column title=" Allowance" sortable="true"><%=temp.elementAt(15)%></display:column>
					<display:column title=" Gross" sortable="true"><%=temp.elementAt(16)%></display:column>
					<display:column title=" Effective Date" sortable="true"><%=temp.elementAt(17)%></display:column>
					<display:column title=" Month" sortable="true"><%=temp.elementAt(18)%></display:column>
				 	<display:column title=" Year" sortable="true"><%=temp.elementAt(19)%></display:column>
					
					<display:column title="Basic " sortable="true"><%=temp.elementAt(13)%></display:column>
					<display:column title="Increment " sortable="true"><%=temp.elementAt(14)%></display:column>
					<display:column title=" Allowance" sortable="true"><%=temp.elementAt(15)%></display:column>
					<display:column title=" Gross" sortable="true"><%=temp.elementAt(16)%></display:column>
					<display:column title=" Effective Date" sortable="true"><%=temp.elementAt(17)%></display:column>
					<display:column title=" Month" sortable="true"><%=temp.elementAt(18)%></display:column>
				 	<display:column title=" Year" sortable="true"><%=temp.elementAt(19)%></display:column>

		
		
					<display:column title=" Type" sortable="true"><%=temp.elementAt(20)%></display:column>
					<display:column title=" Date of Joinning" sortable="true"><%=temp.elementAt(21)%></display:column>
				 	<display:column title=" Year of Exp" sortable="true"><%=temp.elementAt(22)%></display:column>
		 			<display:column title=" Next Effective Date" sortable="true"><%=temp.elementAt(23)%></display:column>
		
					<display:column title=" View Details" sortable="true"><%=temp.elementAt(24)%></display:column>
		
		
		
					  
					
					<display:setProperty name="export.csv.filename" value="RivisionAllReport.csv"/>
					<display:setProperty name="export.excel.filename" value="RivisionAllReport.xls"/>
					<display:setProperty name="export.xml.filename" value="RivisionAllReport.xml"/>
					<display:setProperty name="export.pdf.filename" value="RivisionAllReport.pdf"/>
					<display:setProperty name="export.pdf" value="true" />
					 
</display:table>     
<br />	<center>	<a href='RivisionAllReport.jsp'> CLOSE</a></center>

 <%
	
}
catch(Exception e)
{
}	
%>
 <script language="javascript">
function Rivisionquery(query)
	{  
		var width="800", height="400";
  		var left = (screen.width/2) - width/2;
		var top = (screen.height/2) - height/2;
	 	var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=yes,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
		newWindow = window.open(query,"subWind",styleStr);
		newWindow.focus( );
	}

	
</script>
</body>
</html>
