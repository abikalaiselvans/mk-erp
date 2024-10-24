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
<title> :: CONVEYANCE ::</title>

 


 
 
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
try
{
	
 	
		
   	String fromdate=""+request.getParameter("fromdate");
	String todate=""+request.getParameter("todate");
	String company=""+request.getParameter("company");
	String branch=""+request.getParameter("branch");
	String Office=""+request.getParameter("Office");
	String Dept=""+request.getParameter("Dept");
	String Category=""+request.getParameter("Category");
	String detail=""+request.getParameter("detail");
	String sql="";
	
	String AllowanceData[][] = CommonFunctions.QueryExecute("SELECT CHR_ACODE,CHR_ANAME  FROM pay_m_allowance WHERE CHR_FLAG='Y' ORDER BY INT_ALLOWANCEID");
	String grossband="";
	for(int u=0; u<AllowanceData.length;u++)
		grossband = grossband+"  k."+AllowanceData[u][0]+"+";
	grossband=grossband.trim();
	grossband = grossband.substring(0,grossband.length()-1);
	 
 	String institutionData[][] =  CommonFunctions.QueryExecute("SELECT  INT_PFAMT,INT_ESIAMT,INT_ESILIMIT,INT_PFLIMIT,INT_PFLIMITMINIMUM  FROM m_institution WHERE INT_ID=1");
	double pfpercentage = Double.parseDouble( institutionData[0][0]);
	double esipercentage = Double.parseDouble( institutionData[0][1]);
	double esilimitamount = Double.parseDouble( institutionData[0][2]);
	double pfmaximumlimit = Double.parseDouble( institutionData[0][3]);
	double pfminimumlimit = Double.parseDouble( institutionData[0][4]);
	 
	 
	 sql = " SELECT  a.CHR_EMPID,a.CHR_STAFFNAME,b.CHR_COMPANYNAME,c.CHR_BRANCHNAME,d.CHR_OFFICENAME,e.CHR_DEPARTNAME,f.CHR_DESIGNAME,h.CHR_CATEGORYNAME, ";
	 sql = sql + " FIND_A_BANKGROUP_NAME(a.CHR_BANK) ,a.CHR_ACCNO, DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y'), ";
	 sql = sql + " MONTHNAME(j.DAT_CONDATE),YEAR(j.DAT_CONDATE),SUM(j.DOU_KM), ";
	 sql = sql + " SUM(j.DOU_TRAVEL),SUM(j.DOU_TRAIN),SUM(j.DOU_AUTO),SUM(j.DOU_LUNCH),  ";
	 sql = sql + " SUM(j.DOU_TELEPHONE),SUM(j.DOU_OTHERAMT),SUM(j.DOU_TOTAL),  ";
	 sql = sql + " a.CHR_PF,a.CHR_ESI ,ROUND(a.INT_SALARY),   ";  
 	 sql = sql + " ROUND(a.INT_SALARY+("+grossband+")),  ";
     sql = sql + " ROUND(a.INT_SALARY*12/100) ,ROUND( (a.INT_SALARY+("+grossband+"))  + (a.INT_SALARY*12/100) )   ";
	 
	 
	 
	 sql = sql + " FROM com_m_staff  a,com_m_company b,com_m_branch c, com_m_office  d,com_m_depart e,com_m_desig f, com_m_employeecategory  h,  ";
	 sql = sql + " conveyance_t_conveyance j ,pay_t_allowance k";
	 sql = sql + " WHERE a.CHR_HOLD!='Y' "; 
	 if(!"Y".equals(detail))
	 	sql = sql + " AND a.CHR_TYPE!='T' ";
	 
	 sql = sql + " AND a.INT_COMPANYID = b.INT_COMPANYID ";
	 sql = sql + " AND a.INT_BRANCHID = c.INT_BRANCHID  ";
	 sql = sql + " AND a.INT_OFFICEID = d.INT_OFFICEID ";
	 sql = sql + " AND a.INT_DEPARTID = e.INT_DEPARTID  ";
	 sql = sql + " AND a.INT_DESIGID = f.INT_DESIGID ";
	 sql = sql + " AND a.CHR_CATEGORY= h.INT_EMPLOYEECATEGORYID ";
	 
	 sql = sql + " AND a.CHR_EMPID = j.CHR_EMPID ";
	 sql = sql + " AND a.CHR_EMPID = k.CHR_EMPID  ";
	 sql = sql + "  AND j.CHR_STATUS='Y' ";
	 sql = sql + " AND j.CHR_ACCEPT='Y' ";
	 if(!"0".equals(company))
	 	sql = sql + " AND a.INT_COMPANYID ="+company;
	
	if(!"0".equals(branch))
	 	sql = sql + " AND a.INT_BRANCHID ="+branch;
	
	if(!"0".equals(Office))
	 	sql = sql + " AND a.INT_OFFICEID ="+Office;
	if(!"0".equals(Dept))
	 	sql = sql + " AND a.INT_DEPARTID ="+Dept;
	if(!"0".equals(Category))
	 	sql = sql + " AND a.CHR_CATEGORY ="+Category;
	 
		
	 sql = sql + " AND j.DAT_CONDATE >='"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(fromdate)+"' ";
	 sql = sql + " AND j.DAT_CONDATE <='"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(todate)+"' ";
	 sql = sql + " GROUP BY  a.CHR_EMPID,MONTH(j.DAT_CONDATE),YEAR(j.DAT_CONDATE) ";
	 sql = sql + " ORDER BY  a.CHR_STAFFNAME  ";
	 //out.println(sql);
	 
	 String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	 
	 
Vector mn = new Vector();
Vector child= null;
double monthbasic=0;
double monthgross=0;
double monthpf=0;
double monthesi=0;
double monthctc=0;
double staffpf=0;
double staffesi=0;
double takehome=0;
double nettotal=0;
String pf="";
String esi="";
 
for(int u=0;u<data.length;u++)
{
		
		child = new Vector();
		child.addElement((u+1));

		monthbasic=0;
		monthgross=0;
		monthpf=0;
		monthesi=0;
		monthctc=0;
	
		 nettotal=0;
		
		 
		child.addElement("<a  target='_blank' href='ListConveyanceresponse.jsp?ename="+data[u][0].trim()+"&fromdate="+fromdate+"&todate="+todate+"'>"+data[u][0].trim()+"</a>");
		child.addElement(data[u][1].trim() );
		child.addElement(data[u][2].trim() );
		child.addElement(data[u][3].trim() );
		child.addElement(data[u][4].trim() );
		child.addElement(data[u][5].trim() );
		child.addElement(data[u][6].trim() );
		child.addElement(data[u][7].trim() );
		child.addElement(data[u][8].trim() );
		child.addElement(data[u][9].trim() );
		child.addElement(data[u][10].trim() );
		child.addElement(data[u][11].trim() );
		child.addElement(data[u][12].trim() );
		child.addElement(data[u][13].trim() );
		child.addElement(data[u][14].trim() );
		child.addElement(data[u][15].trim() );
		child.addElement(data[u][16].trim() );
		child.addElement(data[u][17].trim() );
		child.addElement(data[u][18].trim() );
		child.addElement(data[u][19].trim() );
		child.addElement(data[u][20].trim() );
			
		 
		
		pf=data[u][21];
		esi=data[u][22]; 
		monthbasic=Double.parseDouble(data[u][23]);
		monthgross=Double.parseDouble(data[u][24]);
		monthpf=Double.parseDouble(data[u][25]);
		
		
		if("C".equals(pf))
		{
			if(monthbasic < pfminimumlimit)
				monthpf = (pfminimumlimit*pfpercentage/100); 
			else if( (monthbasic>=pfminimumlimit)  && (monthbasic <=pfmaximumlimit))	
				monthpf = (monthbasic*pfpercentage/100); 
			else
				monthpf = (pfmaximumlimit*pfpercentage/100); 
		}	
		else
			monthpf=0;
		
		if("C".equals(esi) && monthgross <=esilimitamount)
			monthesi=(monthgross*esipercentage/100);
		else
			monthesi=0;
			
		 
			
		monthctc=monthgross+monthpf+monthesi;	
		child.addElement("");
		 
		child.addElement(com.my.org.erp.Math.MathFunction.keep2Digit(monthbasic) );
		child.addElement(com.my.org.erp.Math.MathFunction.keep2Digit(monthgross) ); 
		child.addElement(com.my.org.erp.Math.MathFunction.keep2Digit(monthpf) );
		child.addElement(com.my.org.erp.Math.MathFunction.keep2Digit(monthesi) );
		child.addElement(com.my.org.erp.Math.MathFunction.keep2Digit(monthctc) );
		child.addElement("");
		nettotal  = nettotal+nettotal;
		mn.add(child);  

}  
	 
	 
	 
	 
	 
   
	 
	request.setAttribute("table",mn);
	out.println("<br><center><h3> <b> CONVEYANCE EMPLOYEE ONLY  FROM :" +fromdate +" TO : "+todate+"   </h3></center><br>");
 
  

 
	 
	 
	 
	 
	 
	 
	
	 
   %> 
		 

<display:table   id="_table" name="table"   export="true" pagesize="25">

	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title=" Sl.No" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="Employee Id" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="Employee Name" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="Company" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="Branch " sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title=" Office" sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="Department" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="Desigination" sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="Category" sortable="true"><%=temp.elementAt(8)%></display:column>
					
					<display:column title="Bank" sortable="true"><%=temp.elementAt(9)%></display:column>
					<display:column title="A/c No" sortable="true"><%=temp.elementAt(10)%></display:column>
					<display:column title="DOJ" sortable="true"><%=temp.elementAt(11)%></display:column>
					<display:column title="Month" sortable="true"><%=temp.elementAt(12)%></display:column>
					<display:column title="Year" sortable="true"><%=temp.elementAt(13)%></display:column>
					<display:column title="Total KM" sortable="true"><%=temp.elementAt(14)%></display:column>
					<display:column title="Travel Fare" sortable="true"><%=temp.elementAt(15)%></display:column>
					<display:column title="Train Fare" sortable="true"><%=temp.elementAt(16)%></display:column>
					<display:column title="Auto Fare" sortable="true"><%=temp.elementAt(17)%></display:column>
					<display:column title="Lunch / Dinner" sortable="true"><%=temp.elementAt(18)%></display:column>
					<display:column title="Telephone Charges" sortable="true"><%=temp.elementAt(19)%></display:column>
					<display:column title="Others Amt" sortable="true"><%=temp.elementAt(20)%></display:column>
					<display:column title="Total" sortable="true"><%=temp.elementAt(21)%></display:column>
					
					<display:column title=" " sortable="true"><%=temp.elementAt(22)%></display:column>
					
					<display:column title="Basic" sortable="true"><%=temp.elementAt(23)%></display:column>
					<display:column title="Gross" sortable="true"><%=temp.elementAt(24)%></display:column>
					<display:column title="PF" sortable="true"><%=temp.elementAt(25)%></display:column>
					<display:column title="ESI" sortable="true"><%=temp.elementAt(26)%></display:column>
					<display:column title="Total cost To Company (TCTC)" sortable="true"><%=temp.elementAt(27)%></display:column>
					<display:column title="SUM" sortable="true"><%=temp.elementAt(28)%></display:column>
					
					 
				 
		  
					
					
					<display:setProperty name="export.csv.filename" value="ListConveyancee.csv"/>
					<display:setProperty name="export.excel.filename" value="ListConveyancee.xls"/>
					<display:setProperty name="export.xml.filename" value="ListConveyancee.xml"/>
					<display:setProperty name="export.pdf.filename" value="ListConveyancee.pdf"/>
					<display:setProperty name="export.pdf" value="true" />
					 
</display:table>   

<br />	<center>	<a href='ListConveyanceAll.jsp'> CLOSE</a></center>




<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>
 
 </body>
</html>
