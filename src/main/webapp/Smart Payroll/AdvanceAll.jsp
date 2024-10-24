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


<body  onpaste='return false;'>

 
<%


		String sql=" SELECT a.CHR_EMPID,a.CHR_STAFFNAME ,d.CHR_OFFICENAME, ";
		sql = sql+" (SELECT sum(b.INT_ADVAMT) from   pay_m_advance  b where b.CHR_EMPID=a.CHR_EMPID),"; 
		sql = sql+" (SELECT sum(c.INT_DUEAMT) FROM  pay_t_advance  c where c.CHR_EMPID=a.CHR_EMPID), ";
		sql = sql+" ((SELECT sum(b.INT_ADVAMT) from   pay_m_advance  b where b.CHR_EMPID=a.CHR_EMPID)- ";
		sql = sql+" (SELECT sum(c.INT_DUEAMT) FROM  pay_t_advance  c where c.CHR_EMPID=a.CHR_EMPID)) ,a.CHR_TYPE";
		sql = sql+" FROM com_m_staff a ,  com_m_office  d WHERE a.CHR_TYPE!='T' AND a.CHR_HOLD!='Y'  ";
		sql = sql+" AND  a.INT_OFFICEID=d.INT_OFFICEID group by a.CHR_EMPID ORDER BY a.CHR_STAFFNAME";
		sql = " SELECT b.CHR_EMPID,a.CHR_STAFFNAME, d.CHR_OFFICENAME, ";
		sql = sql+" (SELECT sum(b.INT_ADVAMT) from   pay_m_advance  b where b.CHR_EMPID=a.CHR_EMPID),a.CHR_TYPE ,a.CHR_MOBILE";
		sql = sql+"  from com_m_staff a ,   pay_m_advance  b  ,  com_m_office  d  ";
		sql = sql+"  WHERE b.CHR_EMPID=a.CHR_EMPID  AND a.INT_OFFICEID=d.INT_OFFICEID    group by  b.CHR_EMPID   order by a.CHR_STAFFNAME";
		
		 String data[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	 		
 
		
		double sum=0.0;
		String link="";
		int u=0;
		double advance=0;
		double deduction=0;
		double balance=0;
				
     Vector mn = new Vector();
	 Vector child= null;
     
		for(int y=0;y<data.length;y++)
		{
				advance=0;
				deduction=0;
				balance=0;
				sql = " SELECT sum(INT_DUEAMT) FROM  pay_t_advance  where CHR_EMPID='"+data[y][0]+"'";
				String balancedata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				if(!"-".equals(balancedata[0][0]))
						deduction= Double.parseDouble(balancedata[0][0]);
				else
					deduction=0;		
				advance=Double.parseDouble(data[y][3]);	
				balance = advance-deduction;
				
				 
				if((int)balance>0)
				{
				    child = new Vector();
					if(!"T".equals(data[y][4].trim()))
						child.addElement("<font color='#FF0000'>"+(u+1)+"</font>");
						 
					else
						child.addElement("<font color='#FF0000'>"+(u+1)+"</font>");
					child.addElement(data[y][0]);	
					 
					child.addElement(data[y][1]);
					child.addElement(data[y][2]);
					child.addElement( advance);
					child.addElement(deduction );
					child.addElement(balance );
					link="AdvanceIndividualview.jsp?ename="+data[y][0];
					child.addElement("<a href='"+link+"' target='_blank' />Details</a>");
					mn.add(child);
					sum= sum+balance;
					u = u+1;	
				}		
		}
		child = new Vector();
		child.addElement("" ); 
		child.addElement("" ); 
		child.addElement("" ); 
		child.addElement("" ); 
		child.addElement("" ); 
		child.addElement("<font class='bolddeepred'>TOTAL  :: </font>" ); 
		child.addElement(sum); 
		child.addElement("" );
		mn.add(child);
	request.setAttribute("table",mn);
	out.println("<br><center><h3> ADVANCE DETAILS </h3></center><br>");
 
  
	
	 
	%>
	  
	 <display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.No" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="Employee Id" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="Employee Name" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="Office" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="Advance" sortable="true"  ><%=temp.elementAt(4)%></display:column>
					<display:column title="Advance Deduction " sortable="true" ><%=temp.elementAt(5)%></display:column>
					<display:column title="Advance Balance" sortable="true"  ><%=temp.elementAt(6)%></display:column>
					 <display:column title="Detail View" sortable="true"  ><%=temp.elementAt(7)%></display:column>
					
				 
					
					<display:setProperty name="export.csv.filename" value="AdvanceAll.csv"/>
					<display:setProperty name="export.excel.filename" value="AdvanceAll.xls"/>
					<display:setProperty name="export.xml.filename" value="AdvanceAll.xml"/>
					<display:setProperty name="export.pdf.filename" value="AdvanceAll.pdf"/>
					<display:setProperty name="export.pdf" value="true" />
					 
</display:table>   
 <br>
 <center>
 <div id="Rupees"><script language="javascript">numberWord("<%=sum%>","Rupees")</script></div></center>
 <br>
 <br />	<center>	<a href='Payrollmain.jsp'> CLOSE</a></center>
 <br><br>
 
 
</body>
</html>
