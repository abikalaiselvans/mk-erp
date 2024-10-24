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
<title> :: COMMON ::</title>


  


  
 
<style type="text/css" media="all">
      @import url("../JavaScript/css/maven-base.css");
      @import url("../JavaScript/css/maven-theme.css");
      @import url("../JavaScript/css/site.css");
      @import url("../JavaScript/css/screen.css");
  </style> 
</head>
<body  onpaste='return false;'>
 <%@ include file="../PrintHeader.jsp"%>
				<%
          
          	String dept="";
			String deptid="";
          	String mcount="";
          	String fcount="";
          	String tcount="";
			String reportheader = "DEPARTMENT SUMMARY";
         	String sql=" SELECT b.CHR_DEPARTNAME, COUNT(*), a.INT_DEPARTID  FROM  com_m_staff  a,com_m_depart b WHERE "; 
        	 sql=sql+"  a.INT_DEPARTID in (select b.INT_DEPARTID from com_m_staff a, com_m_depart b where b.INT_DEPARTID=a.int_departid)"; 
        	 sql=sql+" and b.INT_DEPARTID=a.int_departid  AND a.CHR_TYPE !='T' group by a.int_departid ";
			
			Vector mn = new Vector();
	 		Vector child= null;
			
          	String count[][]= CommonFunctions.QueryExecute(sql);
			int sum1=0;
			int sum2=0;
			int sum3=0;
          	for(int i=0;i<count.length;i++)
          	{
        	  dept=count[i][0];
        	  mcount=count[i][1];
			  deptid=count[i][2];
			  
        	   
              sql=" SELECT COUNT(*) FROM  com_m_staff  WHERE CHR_GENDER='Male'   and CHR_TYPE !='T'  and INT_DEPARTID ="+deptid; 
              String count1[][]= CommonFunctions.QueryExecute(sql);
               
			  sum1 = sum1+Integer.parseInt(count1[0][0]);
			  	
			  sql=" SELECT COUNT(*) FROM  com_m_staff  WHERE CHR_GENDER='Female'    and CHR_TYPE !='T' and INT_DEPARTID ="+deptid; 
              String count1s[][]= CommonFunctions.QueryExecute(sql);
              
			   sum2 = sum2+Integer.parseInt(count1s[0][0]);
			   
			   
			  
            	sum3 = sum3+Integer.parseInt(mcount);
				
				child = new Vector();
				child.addElement((i+1));
				child.addElement(dept);
				child.addElement(count1[0][0]);
				child.addElement(count1s[0][0]);
				child.addElement(mcount);
				mn.add(child);
            }
				child = new Vector();
				child.addElement(count.length+1);
				child.addElement("TOTAL");
				child.addElement(sum1);
				child.addElement(sum2);
				child.addElement(sum3);
				mn.add(child);
		 
    	 	 
        	  
		request.setAttribute("table",mn);
	     
		 
		%>
 	 	 
 <display:table   id="_table" name="table"   export="true" pagesize="25">
	 				<display:caption><%=reportheader.toUpperCase()%></display:caption>
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="DEPT" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="MALE" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="FEMALE" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="TOTAL" sortable="true"><%=temp.elementAt(4)%></display:column>
					  
					
					<display:setProperty name="export.csv.filename" value="SummaryEmployeereports.csv"/>
					<display:setProperty name="export.excel.filename" value="SummaryEmployeereports.xls"/>
					<display:setProperty name="export.xml.filename" value="SummaryEmployeereports.xml"/>
					<display:setProperty name="export.pdf.filename" value="SummaryEmployeereports.pdf"/>
					<display:setProperty name="export.pdf" value="true" />
					 
</display:table>     
<br />	<center>	<a href='Rept_Staff.jsp'> CLOSE</a></center>
 
	  
   
</body>
</html>


