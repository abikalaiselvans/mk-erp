 <%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="com.my.org.erp.common.CommonInfo"%>
  <%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
  

<%
try
{
%>    
<html>
<head>

<title> :: COMMON ::</title>


 
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
<style type="text/css" media="all">
      @import url("../JavaScript/css/maven-base.css");
      @import url("../JavaScript/css/maven-theme.css");
      @import url("../JavaScript/css/site.css");
      @import url("../JavaScript/css/screen.css");
  </style> 

<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<%@ page import="java.util.*"%>
 
<%
 
	 
	String cmpy=request.getParameter("company");
	String branch=request.getParameter("branch");
	String Office = request.getParameter("Office");
	String dept = request.getParameter("dept");
	String sorting = request.getParameter("sorting");
	String ss = request.getParameter("ss");
	String Resigned = request.getParameter("Resigned");
	String pf = request.getParameter("pf");
	String esi = request.getParameter("esi");
	 
	String sql = "";
	
	 



	sql =" SELECT a.CHR_EMPID,a.CHR_STAFFNAME,a.CHR_STAFFFNAME,g.CHR_COMPANYNAME,f.CHR_BRANCHNAME,c.CHR_DEPARTNAME,  ";
	sql = sql +" i.CHR_DESIGNAME,b.CHR_OFFICENAME ,  ";
	sql = sql +" q.CHR_CATEGORYNAME,  ";
    sql = sql +" a.CHR_GENDER, DATE_FORMAT(a.DT_DOB,'%d-%m-%Y'),DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%m-%Y'),IF(a.CHR_MARITALSTATUS='U','Unmarried','Married'),  ";
	sql = sql +" DATE_FORMAT(a.DT_WEDDATE,'%d-%m-%Y'), e.CHR_QUALIFICATIONNAME ,j.CHR_GROUPNAME,   ";
	sql = sql +" a.CHR_EMAILID, a.CHR_MOBILE,   ";
	sql = sql +" a.INT_SALARY,    ";
	sql = sql +" IF(a.CHR_PF='N','',IF(a.CHR_PF='Y','YES','COMMON')) ,CONCAT(g.CHR_PFNUMBER,a.CHR_PFNO),  ";
	sql = sql +" IF(a.CHR_ESI='N','',IF(a.CHR_ESI='Y','YES','COMMON'))  ,a.CHR_ESINO,   ";
   sql = sql +"  FIND_A_BANKGROUP_NAME(a.CHR_BANK) ,CONCAT('A/c : ',a.CHR_ACCNO)    ";
	sql = sql +" FROM com_m_staff a , com_m_office b ,com_m_depart c ,pay_t_allowance d ,  ";
	sql = sql +" com_m_qualification e , com_m_branch f , com_m_company g,    ";
	sql = sql +" com_m_desig i,com_m_bloodgroup j, com_m_employeecategory q  ";
	sql = sql +" WHERE a.INT_DEPARTID = c.INT_DEPARTID   ";
	sql = sql +" AND a.INT_OFFICEID= b.INT_OFFICEID   ";
	sql = sql +" AND a.CHR_EMPID =d.CHR_EMPID   ";
	sql = sql +" AND a.CHR_QUALIFICATION =e.INT_QUALIFICATIONID   ";
	sql = sql +" AND a.INT_BRANCHID =f.INT_BRANCHID   ";
	sql = sql +" AND a.INT_COMPANYID =g.INT_COMPANYID   ";
 
	sql = sql +" AND a.INT_DESIGID= i.INT_DESIGID   ";
	sql = sql +" AND a.CHR_BG=j.INT_BLOODGROUPID   ";
	  
	
	sql = sql +" AND a.CHR_TYPE !='T'  ";
	sql = sql +" AND a.CHR_CATEGORY= q.INT_EMPLOYEECATEGORYID  ";
	

	if(!"Y".equals(Resigned))
	 	sql = sql +" AND  a.CHR_TYPE !='T' " ;
		
		
	if(!"0".equals(cmpy))
	 	sql = sql +" AND  a.INT_COMPANYID= "+cmpy;
	if(!"0".equals(branch))
	 	sql = sql +" AND  a.INT_BRANCHID= "+branch;
		
		
	if(!"0".equals(Office))
	 	sql = sql +" AND  a.INT_OFFICEID= "+Office;
		 
	if(!"0".equals(dept))
		 sql = sql +" AND  a.INT_DEPARTID= "+dept;
	
	if(!"0".equals(pf))
		 sql = sql +" AND  a.CHR_PF ='"+pf+"'" ;
	if(!"0".equals(esi))
		 sql = sql +" AND  a.CHR_ESI ='"+esi+"'" ;
		 
		 
	sql = sql+"  ORDER BY "+ sorting +" "+ss;	 
	
	 
	//out.println(sql);
	
	 
	  
	  String data[][] =com.my.org.erp.common.CommonFunction.RecordSetArray(sql);
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
			child.addElement(data[u][22]);
			child.addElement(data[u][23]);
			child.addElement(data[u][24]);
			mn.add(child);
     } 
 
	 
	request.setAttribute("table",mn);
	 
	%>
	
	 			
			
	<display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:caption><%="STAFF PF INFORMATIONS"%></display:caption>
					<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.No" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="Empid" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="Name" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="Father Name" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="Company" sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="Branch" sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="Department" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="Designation" sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="Office" sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="Category" sortable="true"><%=temp.elementAt(9)%></display:column>
					<display:column title="Gender" sortable="true"><%=temp.elementAt(10)%></display:column>
					<display:column title="DOB" sortable="true"><%=temp.elementAt(11)%></display:column>
					<display:column title="DOJ" sortable="true"><%=temp.elementAt(12)%></display:column>
					<display:column title="Married" sortable="true"><%=temp.elementAt(13)%></display:column>
					<display:column title="Wedding date" sortable="true"><%=temp.elementAt(14)%></display:column>
					<display:column title="Qualification" sortable="true"><%=temp.elementAt(15)%></display:column>
					<display:column title="Blood Group" sortable="true"><%=temp.elementAt(16)%></display:column>
					<display:column title="Email" sortable="true"><%=temp.elementAt(17)%></display:column>
					<display:column title="Mobile" sortable="true"><%=temp.elementAt(18)%></display:column>
					<display:column title="Basic" sortable="true"><%=temp.elementAt(19)%></display:column>
					<display:column title="PF Type" sortable="true"><%=temp.elementAt(20)%></display:column>
					<display:column title="PF Number" sortable="true"><%=temp.elementAt(21)%></display:column>
					<display:column title="ESI Type" sortable="true"><%=temp.elementAt(22)%></display:column>
					<display:column title="ESI Number" sortable="true"><%=temp.elementAt(23)%></display:column>
					<display:column title="Bank Name" sortable="true"><%=temp.elementAt(24)%></display:column>
					<display:column title="Account Number" sortable="true"><%=temp.elementAt(25)%></display:column>
					  
					
					<display:setProperty name="export.csv.filename" value="StaffPfFandESI.csv"/>
					<display:setProperty name="export.excel.filename" value="StaffPfFandESI.xls"/>
					<display:setProperty name="export.xml.filename" value="StaffPfFandESI.xml"/>
					<display:setProperty name="export.pdf.filename" value="StaffPfFandESI.pdf"/>
					<display:setProperty name="export.pdf" value="true" />
				</display:table> 
			
 	 
<br />
 									<center>	<a href='StaffPFFandESI.jsp'> CLOSE</a></center>
  <%
 }
 catch(Exception e)
 {
 	System.out.println(e.getMessage());
 }
 %>									
											