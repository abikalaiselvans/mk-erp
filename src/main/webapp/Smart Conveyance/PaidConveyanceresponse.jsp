 <%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*,com.my.org.erp.common.*"%>
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<%@ page import="java.util.*"%>
 <script language="javascript" src="../JavaScript/comfunction.js"></script>
  
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
<title> :: CONVEYANCE ::</title>

 


 
 
<style type="text/css" media="all">
      @import url("../JavaScript/css/maven-base.css");
      @import url("../JavaScript/css/maven-theme.css");
      @import url("../JavaScript/css/site.css");
      @import url("../JavaScript/css/screen.css");
  </style> 
</head>
 
<script src="../JavaScript/AJAXFunction.js"></script>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>

<body  onpaste='return false;'>
 
	<%
try
{
	
 	 
		String date=request.getParameter("date");
		 
		String sql="";
		 
		sql=" SELECT IF(b.CHR_TYPE = 'T',CONCAT(a.CHR_EMPID,' *** '),a.CHR_EMPID), b.CHR_STAFFNAME,sum(a.DOU_TRAVEL),sum(a.DOU_TRAIN),sum(a.DOU_AUTO),sum(a.DOU_LUNCH),sum(a.DOU_TELEPHONE),";
		sql=sql + "  sum(a.DOU_OTHERAMT),";
		sql=sql + "(sum(a.DOU_TRAVEL)+sum(a.DOU_TRAIN)+sum(a.DOU_AUTO)+sum(a.DOU_LUNCH)+sum(a.DOU_TELEPHONE)+sum(a.DOU_OTHERAMT))"; 
		sql = sql + " ,sum(a.DOU_TOTAL),DATE_FORMAT(MIN(DAT_CONDATE),'%e-%M-%Y'), DATE_FORMAT(MAX(DAT_CONDATE),'%e-%M-%Y')";
		sql = sql + "  ,FIND_A_BANKGROUP_NAME(b.CHR_BANK) ,b.CHR_ACCNO, b.CHR_IFSC, d.CHR_OFFICENAME,e.CHR_DEPARTNAME, f.CHR_CATEGORYNAME, ";
		sql = sql + "  FUN_GET_CONVEYANCE_ADVANCE_DEDUCTION(a.CHR_EMPID,'"+date+"') ,  ";
		sql = sql + "  (SUM(a.DOU_TOTAL) -FUN_GET_CONVEYANCE_ADVANCE_DEDUCTION(a.CHR_EMPID,'"+date+"')   )";
		
		sql = sql + " FROM conveyance_t_conveyance a, com_m_staff b, com_m_office d, com_m_depart e , com_m_employeecategory  f";
		sql = sql + "  WHERE a.CHR_EMPID=b.CHR_EMPID	  ";
		sql = sql + "  AND a.CHR_STATUS='Y' AND a.CHR_ACCSTATUS='Y'  AND b.INT_OFFICEID =d.INT_OFFICEID ";
		sql = sql + "  AND b.INT_DEPARTID= e.INT_DEPARTID ";
		sql = sql + "  AND b.CHR_CATEGORY=f.INT_EMPLOYEECATEGORYID AND a.DAT_ACCDATE='"+date+"' ";
		sql = sql + "  GROUP BY a.CHR_EMPID	 ORDER BY  b.CHR_STAFFNAME";
		out.println(sql);
		String cdata[][]= CommonFunctions.QueryExecute(sql);
		 
		
		double sum=0;
		double sum1=0;
		double sum2=0;
		double sum3=0;
		double sum4=0;
		double sum5=0;
		double sum6=0;
		
		Vector mn = new Vector();
		Vector child= null;
		for(int u=0;u<cdata.length;u++)
		{

				child = new Vector();
				child.addElement((u+1));
				child.addElement(cdata[u][1] +" /" +cdata[u][0] );  //id & name
				
				child.addElement(cdata[u][15]); // office
				child.addElement(cdata[u][16]); //depart
				child.addElement(cdata[u][17]); //cteg
				
				
				child.addElement(cdata[u][12]); //bank
				child.addElement("A/c No : "+cdata[u][13]); //account
				child.addElement(cdata[u][14]);  //ifsc
				
				child.addElement(cdata[u][10]); //totl
				child.addElement(cdata[u][11]);// date
				
				child.addElement(cdata[u][2]); //travel
				child.addElement(cdata[u][3]); //train
				child.addElement(cdata[u][4]); //auto
				child.addElement(cdata[u][5]); //lunch
				child.addElement(cdata[u][6]); //telephone
				child.addElement(cdata[u][7]); //otheramount
				child.addElement(cdata[u][8]); //sum
				child.addElement(cdata[u][18]);//deduction
				child.addElement(cdata[u][19]); //givenamount
				
				child.addElement("------------------");
				 
				
				sum1= sum1+Double.parseDouble(cdata[u][2]);
				sum2= sum2+Double.parseDouble(cdata[u][3]);
				sum3= sum3+Double.parseDouble(cdata[u][4]);
				sum4= sum4+Double.parseDouble(cdata[u][5]);
				sum5= sum5+Double.parseDouble(cdata[u][6]);
				sum6= sum6+Double.parseDouble(cdata[u][7]);
				 
				sum= sum+Double.parseDouble(cdata[u][9]);


				mn.add(child);  

		} 
		
	 
	request.setAttribute("table",mn);
	out.println("<br><center><h3> <b> PAID CONVEYANCE LIST  ( "+date+") </h3></center><br>");
 
  

 
	 
		 
		
	 
%>


<display:table   id="_table" name="table"   export="true" pagesize="25">

	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title=" Sl.No" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title=" Name" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title=" Office" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title=" Department" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title=" Category" sortable="true"><%=temp.elementAt(4)%></display:column>
					
					<display:column title=" Bank" sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title=" A/C No" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title=" IFSC CODE" sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title=" From Date" sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title=" To Date" sortable="true"><%=temp.elementAt(9)%></display:column>
				
					<display:column title=" Vehicle Amount"  style="text-align:right" sortable="true"><%=temp.elementAt(10)%></display:column>
					<display:column title=" Train/Bus are"  style="text-align:right" sortable="true"><%=temp.elementAt(11)%></display:column>
					<display:column title=" Auto Fare"  style="text-align:right" sortable="true"><%=temp.elementAt(12)%></display:column>
					<display:column title=" Lunch / Dinner"  style="text-align:right" sortable="true"><%=temp.elementAt(13)%></display:column>
					<display:column title=" Telephone Charges"  style="text-align:right" sortable="true"><%=temp.elementAt(14)%></display:column>
					<display:column title=" Others Amt"  style="text-align:right" sortable="true"><%=temp.elementAt(15)%></display:column>
					<display:column title=" Total "  style="text-align:right" sortable="true"><%=temp.elementAt(16)%></display:column>
					 <display:column title="Advance Deduction" style="text-align:right" sortable="true"><%=temp.elementAt(17)%></display:column>
					<display:column title=" Balance" style="text-align:right" sortable="true"><%=temp.elementAt(18)%></display:column>	 
					<display:column title=" Signature " sortable="true"><%=temp.elementAt(19)%></display:column>
					 


					 
					
					<display:setProperty name="export.csv.filename" value="PaidConveyance.csv"/>
					<display:setProperty name="export.excel.filename" value="PaidConveyance.xls"/>
					<display:setProperty name="export.xml.filename" value="PaidConveyance.xml"/>
					<display:setProperty name="export.pdf.filename" value="PaidConveyance.pdf"/>
					<display:setProperty name="export.pdf" value="true" />
					 
</display:table>   

<br />	<center >	<a href='PaidConveyance.jsp'> CLOSE</a></center>


<%

}
catch(Exception e)
{
	e.printStackTrace();
	System.out.println(e.getMessage());
}
%>
 
</body>
</html>
