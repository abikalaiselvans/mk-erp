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
<title> :: ATTENDANCE ::</title>


  


  
 
<style type="text/css" media="all">
      @import url("../JavaScript/css/maven-base.css");
      @import url("../JavaScript/css/maven-theme.css");
      @import url("../JavaScript/css/site.css");
      @import url("../JavaScript/css/screen.css");
  </style> 
</head>

<%
try
{
%>
 
<script language="javascript" src="../JavaScript/comfunction.js"> </script><body  onpaste='return false;'><br><br><br><br>
<%
String company= request.getParameter("company");
String branch= request.getParameter("branch");
String Office = request.getParameter("Office");
String dept= request.getParameter("dept");
String cid = request.getParameter("Certification");
String resigned= request.getParameter("resigned");
String reportheader="CERTIFICATION COMPLETION REPORT";
String cpy="";
String bid="";
String off="";
String dep="";
String sql="";

if(!"-1".equals(company))
	cpy= " AND a.INT_COMPANYID="+company;
	
if(!"-1".equals(branch))
	bid= " AND a.INT_BRANCHID="+branch;	
	
if(!"0".equals(Office))
	off=" AND a.INT_OFFICEID ="+Office;
	
if(!"0".equals(dept))
	dep=" AND a.INT_DEPARTID ="+dept;
	

sql="  SELECT a.CHR_EMPID,a.CHR_STAFFNAME,c.CHR_DEPARTNAME,b.CHR_OFFICENAME , f.CHR_BRANCHNAME,g.CHR_COMPANYNAME,  ";
sql = sql + " a.CHR_MOBILE,a.CHR_EMAILID ,h.CHR_CERTIFICATIONID ";
sql = sql + " FROM com_m_staff a ,  com_m_office  b ,com_m_depart c , com_m_branch f , com_m_company g  , com_t_certification  h ";
sql = sql + " where a.CHR_EMPID= h.CHR_EMPID AND a.CHR_HOLD!='Y'   ";
if(!"0".equals(cid))
   sql = sql + " AND h.CHR_CERTIFICATIONID LIKE '%"+cid+"%' ";
sql = sql + "    AND a.INT_DEPARTID = c.INT_DEPARTID    AND a.INT_OFFICEID= b.INT_OFFICEID   AND a.INT_BRANCHID =f.INT_BRANCHID   ";
sql = sql + " AND a.INT_COMPANYID =g.INT_COMPANYID  " +cpy+bid+off+dep;


if(!"Y".equals(resigned))
	sql = sql + " AND a.CHR_TYPE !='T' ";



sql = sql + " ORDER BY a.CHR_EMPID    ";
 
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
			
			if("0".equals(cid))
				sql = "SELECT CHR_CERTIFICATIONNAME FROM com_m_certification  WHERE INT_CERTIFICATIONID IN ("+data[u][8]+") " ;
			else
				sql =" SELECT CHR_CERTIFICATIONNAME FROM com_m_certification  WHERE INT_CERTIFICATIONID IN ("+cid+") " ;
			String Data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			sql = "";
			if(Data.length>0)
			{
				for(int v=0; v<Data.length;v++)
					sql = sql+Data[v][0] +" ,";
			}
			else
				sql = " ";
			sql = sql.substring(0,sql.length()-1);	
			child.addElement(sql);
			mn.add(child);
     } 
   
	 
	request.setAttribute("table",mn);
	out.println("<br><center><h3> "+reportheader+" </h3></center><br>");
 
  
	 
			%>
			
			
			
			
			
	<display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="ID" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="NAME" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="DEPT" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="OFFICE" sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="BRANCH" sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="COMPANY" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="MOBILE" sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="CERTIFICATION" sortable="true"><%=temp.elementAt(8)%></display:column>
					
					  
					
					
					<display:setProperty name="export.csv.filename" value="Report.csv"/>
					<display:setProperty name="export.excel.filename" value="Report.xls"/>
					<display:setProperty name="export.xml.filename" value="Report.xml"/>
					<display:setProperty name="export.pdf.filename" value="Report.pdf"/>
					<display:setProperty name="export.pdf" value="true" />
					 
</display:table>     
<br />	<center>	<a href='Rept_CertificationCompleted.jsp'> CLOSE</a></center>
 
	 		
			
			
			 
			 
</body>
<%
}
catch(Exception e)
{
}
%>
</html>
