<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*,com.my.org.erp.common.*,com.my.org.erp.Math.*"%>
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*,com.my.org.erp.common.*"%>
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<%@ page import="java.util.*"%><head>
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


<br>
<br>


<%
try
{
 	String  company  = request.getParameter("company");
	String  branch  = request.getParameter("branch");
	String  Office  = request.getParameter("Office");
	String  Month  = request.getParameter("Month");
	String  Year  = request.getParameter("Year");
	String  Depart  = request.getParameter("Depart");
	String  Category  = request.getParameter("Category");
	
	String repmon = DateUtil.getMonth(Integer.parseInt( Month));
	String reportheader="PAYROLL CONSOLIDATION";
	String sql="";
	
	
	String AllowanceData[][] =com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT  CHR_ACODE,CHR_ANAME FROM  pay_m_allowance  ORDER BY INT_ALLOWANCEID");
	String allowancefield="";
	String allowancehead="";
	for(int k=0;k<AllowanceData.length;k++)
	{
		allowancefield = allowancefield+" SUM( b."+AllowanceData[k][0]+") ,";
		allowancehead = allowancehead+" "+AllowanceData[k][1]+"  ,";
	}	
	
	String recoveryData[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(" SELECT  CHR_RCODE,CHR_RNAME FROM  pay_m_recovery  ORDER BY  INT_RECOVERYID ");
	String recoveryfield="";
	String recoveryhead="";
	for(int k=0;k<recoveryData.length;k++)
	{
		recoveryfield = recoveryfield+" SUM(b."+recoveryData[k][0]+") ,";
		recoveryhead = recoveryhead+"  "+recoveryData[k][1]+"  ,";
	 }
	
	
	 sql = " SELECT a.CHR_EMPID,a.CHR_STAFFNAME,c.CHR_OFFICENAME,d.CHR_DEPARTNAME,e.CHR_CATEGORYNAME,SUM(b.DOU_BASIC), ";
	 sql = sql + allowancefield ;
	 sql = sql + " SUM(b.DOU_ATOTAL1),SUM(b.DOU_ATOTAL2),SUM(b.DOU_GROSSPAY), ";
	 sql = sql + recoveryfield ;
	 sql = sql + " SUM(RTOTAL),SUM(DOU_PF),SUM(DOU_ESI),SUM(DOU_MESS),SUM(DOU_ADVANCE),SUM(DOU_TOTALRECOVERY),SUM(DOU_NETSAL),SUM(DOU_MONTHSAL),  ";
	 sql = sql + " SUM(b.DOU_CPYPF1),SUM(b.DOU_CPYPF2),SUM(b.DOU_CPYESI),SUM(b.DOU_SUM),SUM(b.DOU_CTC),SUM(b.DOU_ORIGINALCTC),SUM(b.DOU_LOPDAY),SUM(b.DOU_LOP), ";
	 sql = sql + " SUM(b.DOU_PENBASIC),SUM(b.DOU_COMPANYPF),SUM(b.DOU_COMPANYPENSION),SUM(b.DOU_ADMINCHARGE),SUM(b.DOU_EDLI),SUM(b.DOU_ADMINCHARGE1), ";
	 sql = sql + " SUM(b.DOU_PAYTAX) ";
	 sql = sql + " FROM com_m_staff a ,pay_t_salary  b, com_m_office  c,com_m_depart d, com_m_employeecategory  e ";
	 sql = sql + " WHERE a.CHR_EMPID = b.CHR_EMPID  ";
	 sql = sql + " AND a.INT_OFFICEID = c.INT_OFFICEID ";
	 sql = sql + " AND a.INT_DEPARTID = d.INT_DEPARTID ";
	 sql = sql + "  AND a.CHR_CATEGORY=e.INT_EMPLOYEECATEGORYID ";
	 sql = sql + " AND b.CHR_MONTH='"+repmon+"' ";
	 sql = sql + " AND b.INT_YEAR =  "+Year;
	 sql = sql + " AND d.CHR_DEPARTNAME =  '"+Depart+"'";
	 sql = sql + " AND e.CHR_CATEGORYNAME =  '"+Category+"'";
	 if(!"0".equals(Office))
		sql = sql + "  AND a.INT_OFFICEID="+Office;
	
	 
	 if(!"0".equals(company))
		sql = sql + " AND a.INT_COMPANYID="+company;
		
	 
	 if(!"0".equals(branch))
		sql = sql + "  AND a.INT_BRANCHID="+branch;
	 
	 sql = sql + " GROUP BY  a.INT_OFFICEID,a.INT_DEPARTID,a.CHR_EMPID,a.CHR_CATEGORY ";  //
	 sql = sql + " ORDER BY c.CHR_OFFICENAME,d.CHR_DEPARTNAME,e.CHR_CATEGORYNAME ";
	 //out.println(sql);
	 int totalfield = 6+  AllowanceData.length+3+recoveryData.length+23;
	 String data[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
     
	 String headfield="";
	 headfield ="S.NO,EMPID,STAFF NAME,OFFICE,DEPT,CATEGORY,BASIC,";
	 headfield =headfield+allowancehead+"TOTAL-1,TOTAL-2,GROSS,"+recoveryhead;
	 headfield =headfield+"REC TOTAL, PF,ESI,MESS,ADVANCE,TOTALRECOVERY,NETSAL,MONTHSAL,EMPLOYER PF1,EMPLOYER PF2, EMPLOYER ESI, SUM,CTC,ORIGINAL CTC,";
	 headfield =headfield+" LOP DAY,LOP,PENBASIC,COMPANYPF,COMPANYPENSION,ADMINCHARGE,EDLI,ADMINCHARGE1,PAYTAX,";
	 Vector mn = new Vector();
	 Vector child= null;
     if(data.length>0)
	 { 
		 for(int u=0; u<data.length;u++)
		 {
				child = new Vector();
				child.addElement((u+1));
				for(int v=0; v<totalfield;v++)
					child.addElement(data[u][v]);
				
				mn.add(child);
		 } 
		 
		 sql = " SELECT '0','0',c.CHR_OFFICENAME,d.CHR_DEPARTNAME,e.CHR_CATEGORYNAME,SUM(b.DOU_BASIC), ";
		 sql = sql + allowancefield ;
		 sql = sql + " SUM(b.DOU_ATOTAL1),SUM(b.DOU_ATOTAL2),SUM(b.DOU_GROSSPAY), ";
		 sql = sql + recoveryfield ;
		 sql = sql + " SUM(RTOTAL),SUM(DOU_PF),SUM(DOU_ESI),SUM(DOU_MESS),SUM(DOU_ADVANCE),SUM(DOU_TOTALRECOVERY),SUM(DOU_NETSAL),SUM(DOU_MONTHSAL),  ";
		 sql = sql + " SUM(b.DOU_CPYPF1),SUM(b.DOU_CPYPF2),SUM(b.DOU_CPYESI),SUM(b.DOU_SUM),SUM(b.DOU_CTC),SUM(b.DOU_ORIGINALCTC),SUM(b.DOU_LOPDAY),SUM(b.DOU_LOP), ";
		 sql = sql + " SUM(b.DOU_PENBASIC),SUM(b.DOU_COMPANYPF),SUM(b.DOU_COMPANYPENSION),SUM(b.DOU_ADMINCHARGE),SUM(b.DOU_EDLI),SUM(b.DOU_ADMINCHARGE1), ";
		 sql = sql + " SUM(b.DOU_PAYTAX) ";
		 sql = sql + " FROM com_m_staff a ,pay_t_salary  b, com_m_office  c,com_m_depart d, com_m_employeecategory  e ";
		 sql = sql + " WHERE a.CHR_EMPID = b.CHR_EMPID  ";
		 sql = sql + " AND a.INT_OFFICEID = c.INT_OFFICEID ";
		 sql = sql + " AND a.INT_DEPARTID = d.INT_DEPARTID ";
		 sql = sql + "  AND a.CHR_CATEGORY=e.INT_EMPLOYEECATEGORYID ";
		 sql = sql + " AND b.CHR_MONTH='"+repmon+"' ";
		 sql = sql + " AND b.INT_YEAR =  "+Year;
		 sql = sql + " AND d.CHR_DEPARTNAME =  '"+Depart+"'";
		 sql = sql + " AND e.CHR_CATEGORYNAME =  '"+Category+"'";
		 if(!"0".equals(Office))
			sql = sql + "  AND a.INT_OFFICEID="+Office;
		
		 
		 if(!"0".equals(company))
			sql = sql + " AND a.INT_COMPANYID="+company;
			
		 
		 if(!"-1".equals(branch))
			sql = sql + "  AND a.INT_BRANCHID="+branch;
		 
		 sql = sql + " GROUP BY  a.INT_OFFICEID,a.INT_DEPARTID ,a.CHR_CATEGORY ";  //
		 sql = sql + " ORDER BY c.CHR_OFFICENAME,d.CHR_DEPARTNAME,e.CHR_CATEGORYNAME ";
		 String sumdata[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		 if(sumdata.length>0)
		 {
				 	child = new Vector();
					child.addElement("");
					child.addElement("");
					child.addElement("");
					child.addElement("");
					child.addElement("");
					child.addElement("TOTAL :: ");
					for(int v=5; v<totalfield;v++)
						child.addElement(sumdata[0][v]);
					mn.add(child); 
			 		
		 } 
		 
			 
		}
	 
	 request.setAttribute("table",mn);
	 out.println("<br><center><h3> "+reportheader+" </h3></center><br>");
	 String heads[] =headfield.split(",");
	 
	 %>
			
			
			
			
			
	<display:table   id="_table" name="table"   export="true" pagesize="25">

		<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
		<%
			for(int x=0;x<heads.length;x++)
			{
			%>
			<display:column title="<%=heads[x]%>" sortable="true"><%=temp.elementAt(x)%></display:column>
			<%
			}
		%> 
		
		<display:setProperty name="export.csv.filename" value="Rept_payrollconsolidation.csv"/>
					<display:setProperty name="export.excel.filename" value="Rept_payrollconsolidation.xls"/>
					<display:setProperty name="export.xml.filename" value="Rept_payrollconsolidation.xml"/>
					<display:setProperty name="export.pdf.filename" value="Rept_payrollconsolidation.pdf"/>
		<display:setProperty name="export.pdf" value="true" />
					 
</display:table>     
<br />	<center>	<a href='Payrollmain.jsp'> CLOSE</a>
</center><br /><br /><br /><br />
 
	 		
			
			
			 
			 
</body>
<%
	/*String reportdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	if(reportdata.length>0)
	{ 
		
		out.println("<center> <table id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
		out.println("<tr bgcolor='#ffffff'><td colspan=60><h3> </center></h3></td></tr>");
		out.println("<TR bgColor=#ffffff >");
		out.println("<Td bgColor=#ffffff class='boldEleven'><b>S.No</b></Td>");
		out.println("<Td bgColor=#ffffff class='boldEleven'><b>Empid</b></Td>");
		out.println("<Td bgColor=#ffffff class='boldEleven'><b>Name</b></Td>");
		out.println("<Td bgColor=#ffffff class='boldEleven'><b>Office</b></Td>");
		out.println("<Td bgColor=#ffffff class='boldEleven'><b>Depart</b></Td>");
		out.println("<Td bgColor=#ffffff class='boldEleven'><b>Category</b></Td>");
		out.println("<Td bgColor=#ffffff class='boldEleven'><b>Basic</b></Td>");
		for(int k=0;k<AllowanceData.length;k++)
			out.println("<Td bgColor=#ffffff class='boldEleven'><b>"+AllowanceData[k][1]+"</b></Td>");
		
		out.println("<Td bgColor=#ffffff class='boldEleven'><b>Total1</b></Td>");
		out.println("<Td bgColor=#ffffff class='boldEleven'><b>Total2</b></Td>");
		out.println("<Td bgColor=#ffffff class='boldEleven'><b>Gross</b></Td>");
		for(int k=0;k<recoveryData.length;k++)
			out.println("<Td bgColor=#ffffff class='boldEleven'><b>"+recoveryData[k][1]+"</b></Td>");
		
		out.println("<Td bgColor=#ffffff class='boldEleven'><b>RTotal</b></Td>");
		out.println("<Td bgColor=#ffffff class='boldEleven'><b>PF</b></Td>");
		out.println("<Td bgColor=#ffffff class='boldEleven'><b>ESI</b></Td>");
		out.println("<Td bgColor=#ffffff class='boldEleven'><b>MESS</b></Td>");
		out.println("<Td bgColor=#ffffff class='boldEleven'><b>ADVANCE</b></Td>");
		out.println("<Td bgColor=#ffffff class='boldEleven'><b>TOTAL RECOVERY</b></Td>");
		out.println("<Td bgColor=#ffffff class='boldEleven'><b>Net SAL</b></Td>");
		out.println("<Td bgColor=#ffffff class='boldEleven'><b>Month SAL</b></Td>");
		out.println("<Td bgColor=#ffffff class='boldEleven'><b>CPY PF1</b></Td>");
		out.println("<Td bgColor=#ffffff class='boldEleven'><b>CPY PF2</b></Td>");
		out.println("<Td bgColor=#ffffff class='boldEleven'><b>CPY ESI</b></Td>");
		out.println("<Td bgColor=#ffffff class='boldEleven'><b>SUM</b></Td>");
		out.println("<Td bgColor=#ffffff class='boldEleven'><b>CTC</b></Td>");
		out.println("<Td bgColor=#ffffff class='boldEleven'><b>ORIGINAL CTC</b></Td>");
		out.println("<Td bgColor=#ffffff class='boldEleven'><b>LOP DAYS</b></Td>");
		out.println("<Td bgColor=#ffffff class='boldEleven'><b>LOP</b></Td>");
		out.println("<Td bgColor=#ffffff class='boldEleven'><b>Pen Basic</b></Td>");
		out.println("<Td bgColor=#ffffff class='boldEleven'><b>CPY PF</b></Td>");
		out.println("<Td bgColor=#ffffff class='boldEleven'><b>CPY Pension</b></Td>");
		out.println("<Td bgColor=#ffffff class='boldEleven'><b>Admin Charge1</b></Td>");
		out.println("<Td bgColor=#ffffff class='boldEleven'><b>EDLI</b></Td>");
		out.println("<Td bgColor=#ffffff class='boldEleven'><b>Admin Charge1</b></Td>");
		out.println("<Td bgColor=#ffffff class='boldEleven'><b>PAY Tax</b></Td>");
		out.println("</TR>");
		
		int totalcoulmn = AllowanceData.length+recoveryData.length+32;
		for(int x=0;x<reportdata.length;x++)
		{ 
			out.println("<TR>");
			out.println("<Td bgColor=#ffffff class='boldEleven'>"+(x+1) +"</Td>");
			for(int k=0;k<totalcoulmn;k++)
				out.println("<Td bgColor=#ffffff class='boldEleven'>"+reportdata[x][k]+"</Td>");
			
			 
		}
		  
	}
	*/ 
	
}
catch(Exception e)
{
out.println(e.getMessage());
}
 %>
 