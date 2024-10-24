  <%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
 <%@ page import="java.util.*"%>
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
 
<title>:: HRM ::</title>



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
 
<body  onpaste='return false;'><br> 
<%
 

 	String reportheader=" ONLINE TEST VIEW  "; 
	String month= request.getParameter("month") ;
	 
	String year=request.getParameter("year");
	 
	String jobgrade= request.getParameter("jobgrade") ;    
	String jobtitle= request.getParameter("jobtitle") ;
	String result= request.getParameter("result") ;  
	String sql="";
	
	sql="SELECT  b.CHR_APPCODE,b.CHR_APPNAME,b.CHR_JOBGRADE,c.CHR_JOBTITLE, ";
	sql=sql+" DATE_FORMAT(a.DAT_ATTENDDATE,'%d-%b-%Y'),MONTHNAME(a.DAT_ATTENDDATE),YEAR(a.DAT_ATTENDDATE), ";
	sql=sql+" DATE_FORMAT(b.DT_DOB,'%d-%b-%Y'),b.CHR_EMAILID,b.CHR_MOBILE,b.CHR_ONLINETESTSTATUS,b.CHR_RESULT   ";
	
	sql=sql+" FROM hrm_t_testquestion a,hrm_m_application b ,hrm_m_jobdesign c  ";
	sql=sql+" WHERE a.INT_APPID = b.INT_APPID AND b.INT_JOBID=c.INT_JOBID AND b.INT_ONLINETEST=1 ";
	
	if(!"0".equals(month))
		sql=sql+" AND MONTH(a.DAT_ATTENDDATE)='"+month+"'";
	if(!"0".equals(year))
		sql=sql+" AND YEAR(a.DAT_ATTENDDATE)= "+year+" ";
	if(!"0".equalsIgnoreCase(result))
		sql=sql+" AND a.CHR_RESULT= "+result+" ";
	
	if(!"0".equalsIgnoreCase(jobgrade))
		sql=sql+" AND b.CHR_JOBGRADE='"+jobgrade+"'";
	if(!"0".equalsIgnoreCase(jobtitle))
		sql=sql+" AND b.INT_JOBID= "+jobtitle+" ";
	 
	sql=sql+" GROUP BY a.INT_APPID ";
	sql=sql+" ORDER BY b.CHR_APPNAME ";
		 		
	 
	 String data[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
     Vector mn = new Vector();
	 Vector child= null;
     for(int u=0; u<data.length;u++)
	 {
	     	child = new Vector();
			child.addElement((u+1));
			child.addElement(data[u][0]);
			child.addElement(data[u][1] );
			child.addElement(data[u][2] );
			child.addElement(data[u][3] );
			child.addElement(data[u][4] );
			child.addElement(data[u][5] );
			child.addElement(data[u][6] );
			child.addElement(data[u][7] );
			child.addElement(data[u][8] );
			child.addElement(data[u][9] );
			if("Y".equals(data[u][10]))
				child.addElement("Completed" );
			else
				child.addElement("Not Completed" );
			
			if("P".equals(data[u][11]))
				child.addElement("PASS" );
			else if("F".equals(data[u][11]))
				child.addElement("FAIL" );
			else
				child.addElement("NOT ATTEND" );
			
			
			mn.add(child);
     } 
   
	 
	request.setAttribute("table",mn);
	out.println("<br><center><h3> "+reportheader+" </h3></center> ");
 
  
 
 
%>
	 		
 <display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="Application Code" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="Applicant Name" sortable="true"><%=temp.elementAt(2)%></display:column>   
					<display:column title="Job Grade" sortable="true"><%=temp.elementAt(3)%></display:column>   
					<display:column title="Job Title" sortable="true"><%=temp.elementAt(4)%></display:column>   
					<display:column title="Attended Date" sortable="true"><%=temp.elementAt(5)%></display:column>   
					<display:column title="AttendedMonth" sortable="true"><%=temp.elementAt(6)%></display:column> 
					<display:column title="Attended Year" sortable="true"><%=temp.elementAt(7)%></display:column>  
					<display:column title="DOB" sortable="true"><%=temp.elementAt(8)%></display:column>  
					<display:column title="Email" sortable="true"><%=temp.elementAt(9)%></display:column>  
					<display:column title="Mobile" sortable="true"><%=temp.elementAt(10)%></display:column>  
					<display:column title="Online Test" sortable="true"><%=temp.elementAt(11)%></display:column>  
					<display:column title="Result" sortable="true"><%=temp.elementAt(12)%></display:column>  
					  
					
					
					
					
					<display:setProperty name="export.excel.filename" value="Rept_Question.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_Question.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rept_Question.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					 
</display:table>     

 
<br />	<center>	<a href='HRMmain.jsp'> CLOSE</a>
</center>
 
			

 
</body>
<%
}
catch(Exception e)
{
	out.println(""+e.getMessage());
}
%>
</html>
