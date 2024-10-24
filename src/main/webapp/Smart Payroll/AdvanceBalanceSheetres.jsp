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


<%
String staffid = "" + request.getParameter("ename");
String sql="";
double sum=0.0;
double sum1=0.0;
double sum2=0.0;
String staffname=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT  CHR_STAFFNAME   FROM com_m_staff WHERE   CHR_EMPID ='"+staffid+"'")[0][0];


%>



 
 		<%
			 sql=" SELECT  INT_ADVAMT,CHR_MONTH,INT_YEAR  FROM   pay_m_advance  WHERE CHR_EMPID='"+staffid+"'";
			 String datas[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sql);
			 Vector mn = new Vector();
			 Vector child= null;
			 int row=0;
			 for(int u=0; u<datas.length;u++)
			 {
					child = new Vector();
					child.addElement((row+1));
					child.addElement(staffid );
					child.addElement(staffname );
					child.addElement(datas[u][1]);
					child.addElement(datas[u][2]);
					child.addElement(" "+datas[u][0] );
					child.addElement("");
					child.addElement("");
					child.addElement("");
					child.addElement("");
					child.addElement("");
					mn.add(child);
					sum1=sum1+Double.parseDouble(datas[u][0]);
					row++;
			 } 
	 
	 
	 
	 
	 
	   
			sql=" SELECT  INT_DUEAMT,CHR_MONTH,INT_YEAR,INT_ID,CHR_TYPE  FROM  pay_t_advance  WHERE CHR_EMPID='"+staffid+"'";
			String Rdatas[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sql);
			String f="";
			
				
			if(Rdatas.length>0)
			{
				 
				for(int v=0;v<Rdatas.length;v++)
				{
					f="";
					
					child = new Vector();
					child.addElement((row+1));
					child.addElement(staffid );
					child.addElement(staffname );
					child.addElement("");
					child.addElement("");
					child.addElement("");
					
					 if((v+1) == Rdatas.length)
					{
						if("Y".equals(Rdatas[v][4]))
							f ="Salary Deduction";
						else
							f = "Cash Return"	;
							
						child.addElement(Rdatas[v][1]);	
						child.addElement(Rdatas[v][2]);	
						child.addElement(Rdatas[v][0]+"  - <a href='AdvanceUpdate.jsp?id="+Rdatas[v][3]+"&sessiid="+session.getId()+"'> Update</a>");	
						child.addElement(f);
						child.addElement("");	
					}
					else 
					{
						if("Y".equals(Rdatas[v][4]))
							f ="Salary Deduction";
						else
							f = "Cash Return"	;
						child.addElement(Rdatas[v][1]);	
						child.addElement(Rdatas[v][2]);	
						child.addElement(" "+Rdatas[v][0] );
						child.addElement(f);
						child.addElement("");	
						row++;
					}	
					mn.add(child);
					sum2=sum2+Double.parseDouble(Rdatas[v][0]);
				}
				
			}	
			child = new Vector();
			child.addElement("");
			child.addElement("TOTAL ::" );
			child.addElement("" );
			child.addElement("");
			child.addElement("");
			child.addElement(" "+sum1 );
			
			child.addElement("");
			child.addElement("");
			child.addElement("");
			child.addElement(" "+sum2 );
			child.addElement(" "+(sum1-sum2) );
			mn.add(child);
			
			request.setAttribute("table",mn);
	out.println("<br><center><h3 COLOR='RED'> ADVANCE DETAILS FOR THE EMPLOYEE ID  ::  "+staffid+"  NAME ::  "+staffname+" </h3></center><br>");
 
  
		%>
          
   
	 <display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.No" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="Employee Id" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="Employee Name" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="Month" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="Year" sortable="true" ><%=temp.elementAt(4)%></display:column>
					<display:column title="Advance   " sortable="true" ><%=temp.elementAt(5)%></display:column>
					<display:column title="Month  " sortable="true"  ><%=temp.elementAt(6)%></display:column>
					<display:column title="Year" sortable="true"  ><%=temp.elementAt(7)%></display:column>
					<display:column title="Deduction" sortable="true"  ><%=temp.elementAt(8)%></display:column>
					<display:column title="Deduction Type" sortable="true"  ><%=temp.elementAt(9)%></display:column>
					<display:column title="Balance" sortable="true"  ><%=temp.elementAt(10)%></display:column> 
					
					 
					 
					<display:setProperty name="export.csv.filename" value="BalanceSheet.csv"/>
					<display:setProperty name="export.excel.filename" value="BalanceSheet.xls"/>
					<display:setProperty name="export.xml.filename" value="BalanceSheet.xml"/>
					<display:setProperty name="export.pdf.filename" value="BalanceSheet.pdf"/>
					<display:setProperty name="export.pdf" value="true" />
					 
</display:table>   
 <br>
 <center>
 <div id="Rupees"><script language="javascript">numberWord("<%=(sum1-sum2)%>","Rupees")</script></div></center>
 <br>
 <br />	<center>	<a href='AdvanceBalanceSheet.jsp'> CLOSE</a></center>
</body>
</html>
