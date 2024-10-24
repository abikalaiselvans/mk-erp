<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="com.my.org.erp.common.CommonInfo"%>
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>


 
<script language="javascript" src="../JavaScript/comfunction.js"></script>

<html>
<head>

<title>:: HRM ::</title>

 
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


 
</head>
<style type="text/css" media="all">
      @import url("../JavaScript/css/maven-base.css");
      @import url("../JavaScript/css/maven-theme.css");
      @import url("../JavaScript/css/site.css");
      @import url("../JavaScript/css/screen.css");
  </style> 

 
<body  onpaste="return false;" leftmargin="0" topmargin="0">
 	
	<%
	String grade=request.getParameter("grade");
	String sql=" ";

	sql = " SELECT a.CHR_JOBGRADE,a.CHR_JOBCODE,a.CHR_JOBTITLE,d.CHR_DEPARTNAME,a.CHR_JOBPURPOSE,a.CHR_JOBDUTY, "; 
	sql = sql +" (SELECT CHR_STAFFNAME FROM com_m_staff b where b.CHR_EMPID= a.CHR_JOBAUTH), "; 
	sql = sql +" a.CHR_RESPONSE,a.CHR_SKILLSET,  "; 
	sql = sql +" a.CHR_JOBPROMOTIONS, a.CHR_JOBHAZ,a.CHR_JOBREPORT, a.CHR_GENDER,a.INT_AGE,a.INT_AGE_TO, "; 
	sql = sql +" c.CHR_QUALIFICATIONNAME, a.INT_EXPERIENCE, a.INT_HEIGHT, a.INT_WEIGHT, a.INT_SALARY,a.INT_DA,a.INT_HRA, "; 
	sql = sql +" a.CHR_MEMORY, a.CHR_CREATIVITY, a.CHR_TEACHING,a.CHR_EMOTIONAL,a.INT_WORKING     ";                              
	sql = sql +" FROM hrm_m_jobdesign a,com_m_qualification c,com_m_depart d "; 
	sql = sql +" WHERE a.CHR_QUALIFICATIONID =c.INT_QUALIFICATIONID "; 
	sql = sql +" AND a.INT_DEPARTID = d.INT_DEPARTID ";
	if(!"0".equals(grade)) 
		sql = sql +" AND a.CHR_JOBGRADE ='"+grade+"'";
	sql = sql +" ORDER BY 	a.CHR_JOBGRADE,a.CHR_JOBTITLE ";
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
			child.addElement(data[u][10]);
			child.addElement(data[u][11]);
			child.addElement(data[u][12]);
			child.addElement(data[u][13]);
			child.addElement(data[u][14]);
			child.addElement(data[u][15]);
			child.addElement(data[u][16]);
			child.addElement(data[u][17]);
			child.addElement(data[u][18]);
			child.addElement(data[u][19]);
			child.addElement(data[u][20]);
			child.addElement(data[u][21]);
			 
			if("Y".equals(data[u][22]))
				child.addElement("Required..");
			else
				child.addElement("Not Required..");
				
				
			if("Y".equals(data[u][23]))
				child.addElement("Required..");
			else
				child.addElement("Not Required..");
				
			if("Y".equals(data[u][24]))
				child.addElement("Required..");
			else
				child.addElement("Not Required..");
				
			if("Y".equals(data[u][25]))
				child.addElement("Required..");
			else
				child.addElement("Not Required..");
				
				
			 
			
			child.addElement(data[u][26]);
			mn.add(child);
     } 
 
	 
	request.setAttribute("table",mn);
	out.println("<br><center><h1>JOB DESIGN INFORMATION</h1></center><br>");  
	%>
	 
	 <display:table   id="_table" name="table"  export="true">
	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.No" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="Job Grade" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="Job Gode" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="Job Title" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="Deoartment" sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="Job Purpose" sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="Job Duty" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="Authority Person" sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="Response" sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="Skill Set" sortable="true"><%=temp.elementAt(9)%></display:column>
					<display:column title="Promotion" sortable="true"><%=temp.elementAt(10)%></display:column>
					
					<display:column title="Hazards" sortable="true"><%=temp.elementAt(11)%></display:column>
					<display:column title="Reporting To" sortable="true"><%=temp.elementAt(12)%></display:column>
					<display:column title="Gender" sortable="true"><%=temp.elementAt(13)%></display:column>
					<display:column title="Age From" sortable="true"><%=temp.elementAt(14)%></display:column>
					<display:column title="Age TO" sortable="true"><%=temp.elementAt(15)%></display:column>
					<display:column title="Qualification" sortable="true"><%=temp.elementAt(16)%></display:column>
					<display:column title="Experience" sortable="true"><%=temp.elementAt(17)%></display:column>
					<display:column title="Height" sortable="true"><%=temp.elementAt(18)%></display:column>
					<display:column title="Weight" sortable="true"><%=temp.elementAt(19)%></display:column>
					<display:column title="Salary" sortable="true"><%=temp.elementAt(20)%></display:column>
					
					<display:column title="Da" sortable="true"><%=temp.elementAt(21)%></display:column>
					<display:column title="HRA" sortable="true"><%=temp.elementAt(22)%></display:column>
					<display:column title="Memory" sortable="true"><%=temp.elementAt(23)%></display:column>
					<display:column title="Creativity" sortable="true"><%=temp.elementAt(24)%></display:column>
					<display:column title="Teaching" sortable="true"><%=temp.elementAt(25)%></display:column>
					<display:column title="Emotional" sortable="true"><%=temp.elementAt(26)%></display:column>
					<display:column title="Working Hours" sortable="true"><%=temp.elementAt(27)%></display:column>
					
				 
					 					
					<display:setProperty name="export.csv.filename" value="JobDesign.csv"/>
					<display:setProperty name="export.excel.filename" value="JobDesign.xls"/>
					<display:setProperty name="export.xml.filename" value="JobDesign.xml"/>
					<display:setProperty name="export.pdf.filename" value="JobDesign.pdf"/>
					<display:setProperty name="export.pdf" value="true" />
					 
	</display:table> 
    
	
	
<br />
 
									<center>	<a href='JobDesignReport.jsp'> CLOSE</a></center>
          
       

</body>