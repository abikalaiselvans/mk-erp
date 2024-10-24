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
 
	 
	 
	
	String sql = "";
	
	 
  	sql = " SELECT IF(CHR_TYPE='T',CONCAT(CHR_EMPID,'***'),CHR_EMPID),DATE_FORMAT(DT_DOB,'%d-%b-%Y') DOB,CHR_STAFFNAME NAME,CHR_STAFFFNAME Father, ";
 	sql = sql + " CHR_PFNO PFNUMBER, CHR_NOMINEE Nominee,CHR_NOMINEE_RELATIONSHIP relationship, IF(CHR_TYPE='T','Resigned',CHR_TYPE) Staff_type, ";
 	sql = sql + " DAT_PFESIDATE PFJoinning, DAT_PFRESIGNDATE PFLeaving ";
 	sql = sql + " FROM com_m_staff ";
	sql = sql + "  WHERE CHR_PF != 'N' ";
 	sql = sql + " ORDER BY CHR_PFNO ";
	//out.println(sql);
	
	 
	  
	  String data[][] = CommonFunctions.QueryExecute(sql);
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
			mn.add(child);
     } 
 
	 
	request.setAttribute("table",mn);
	 
	%>
	
	 			
			
	<display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:caption><%="STAFF PF INFORMATIONS"%></display:caption>
					<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.No" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="Empid" sortable="true"><%=temp.elementAt(1)%></display:column>
                    <display:column title="DOB" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="Name" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="Father Name" sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="PF Number" sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="Nominee" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="Relationship" sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="Stafftype" sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="PF Joinning" sortable="true"><%=temp.elementAt(9)%></display:column>
					<display:column title="PF Leaving" sortable="true"><%=temp.elementAt(10)%></display:column>
					 
					<display:setProperty name="export.csv.filename" value="StaffPfForm-9.csv"/>
					<display:setProperty name="export.excel.filename" value="StaffPfForm-9.xls"/>
					<display:setProperty name="export.xml.filename" value="StaffPfForm-9.xml"/>
					<display:setProperty name="export.pdf.filename" value="StaffPfForm-9.pdf"/>
					<display:setProperty name="export.pdf" value="true" />
				</display:table> 
			
	 
	  
	  
	 
<br />
 
									 
 									
 <%
 }
 catch(Exception e)
 {
 	System.out.println(e.getMessage());
 }
 %>									
											