 <%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*,com.my.org.erp.common.*"%>
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<%@ page import="java.util.*"%>
 <script language="javascript" src="../JavaScript/comfunction.js"></script>
 <%
 try
{
 %> 
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
 
 
  
<script language="javascript">
function  Print(links)
{
	var width="800", height="400";
	var left = (screen.width/2) - width/2;
	var top = (screen.height/2) - height/2;
	var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=no,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
	newWindow = window.open(links,"subWind",styleStr);
	newWindow.focus( );
}

 
</script>   
</head>
<body >

<%
try
{
		String reportheader=" REPORT CONVEYANCE "; 
		String companyid=request.getParameter("company");
		String branch=request.getParameter("branch");
		String officeid=request.getParameter("Office");
		String paiddate=request.getParameter("paiddate");
		String link="ReptConveyanceprint.jsp?company="+companyid+"&branch="+branch+"&Office="+officeid+"&paiddate="+paiddate;
		paiddate = paiddate.split("-")[2]+"-"+paiddate.split("-")[1]+"-"+paiddate.split("-")[0];
		String cname[][] =CommonFunctions.QueryExecute("SELECT CHR_COMPANYNAME FROM com_m_company WHERE INT_COMPANYID="+companyid);
		
		String branchname = "";
		if("0".equals(branch))
		{
			branchname = "";
		}
		else
		{
			String bname[][] =CommonFunctions.QueryExecute("SELECT CHR_BRANCHNAME FROM com_m_branch WHERE INT_BRANCHID="+branch);
			branchname = " @ " +bname[0][0];
		}
		String sql="";
		String off="";
		String cpy="";
		String bid ="";
		
		sql=" SELECT a.CHR_EMPID, if(b.CHR_TYPE='T',CONCAT(b.CHR_STAFFNAME,' ( *** )'),b.CHR_STAFFNAME) ,sum(a.DOU_TRAVEL),sum(a.DOU_TRAIN),sum(a.DOU_AUTO),sum(a.DOU_LUNCH),sum(a.DOU_TELEPHONE),";
		sql=sql + "  sum(a.DOU_OTHERAMT),";
		sql=sql + "(sum(a.DOU_TRAVEL)+sum(a.DOU_TRAIN)+sum(a.DOU_AUTO)+sum(a.DOU_LUNCH)+sum(a.DOU_TELEPHONE)+sum(a.DOU_OTHERAMT))"; 
		sql = sql + " ,sum(a.DOU_TOTAL),DATE_FORMAT(MIN(DAT_CONDATE),'%e-%M-%Y'), DATE_FORMAT(MAX(DAT_CONDATE),'%e-%M-%Y') ,FIND_A_BANKGROUP_NAME(b.CHR_BANK) ,b.CHR_ACCNO, d.CHR_OFFICENAME,e.CHR_DEPARTNAME,f.CHR_CATEGORYNAME,b.CHR_IFSC , ";
		sql = sql + "  FUN_GET_CONVEYANCE_ADVANCE_BEFORE(a.CHR_EMPID,'"+paiddate+"') ,  ";
		sql = sql + "  FUN_GET_CONVEYANCE_ADVANCE_DEDUCTION(a.CHR_EMPID,'"+paiddate+"'),  ";
		//sql = sql + "  (SUM(a.DOU_TOTAL) -FUN_GET_CONVEYANCE_ADVANCE_BEFORE(a.CHR_EMPID,'"+paiddate+"')   ), ";
		sql = sql + "  (SUM(a.DOU_TOTAL) -FUN_GET_CONVEYANCE_ADVANCE_DEDUCTION(a.CHR_EMPID,'"+paiddate+"')   )";
		
		sql = sql + " FROM conveyance_t_conveyance a, com_m_staff b , com_m_office  d ,com_m_depart e, com_m_employeecategory  f";
		sql = sql + "  WHERE a.CHR_EMPID=b.CHR_EMPID	 ";
		sql = sql + "  AND a.CHR_STATUS='Y' AND a.CHR_ACCSTATUS='Y'  AND b.INT_OFFICEID =d.INT_OFFICEID AND b.INT_DEPARTID= e.INT_DEPARTID  AND b.CHR_CATEGORY = f.INT_EMPLOYEECATEGORYID";
		sql = sql + "  AND a.DAT_ACCDATE='"+paiddate+"' ";
		sql = sql + "  AND b.INT_COMPANYID= "+companyid;		
		if(!"0".equals(officeid))
			sql = sql + " AND b.INT_OFFICEID = " +officeid;
		if(!"0".equals(branch))
			sql = sql + "  AND b.INT_BRANCHID = " +branch;
		sql = sql + "  GROUP BY a.CHR_EMPID	 ORDER BY  b.CHR_STAFFNAME";
		out.println(sql);
		String cdata[][]=CommonFunctions.QueryExecute(sql);
		String companyname = cname[0][0];
		
		
		double sum=0;
		double sum1=0;
		double sum2=0;
		double sum3=0;
		double sum4=0;
		double sum5=0;
		double sum6=0;
		
		Vector mn = new Vector();
	 	Vector child= null;
				
		if(cdata.length>0)
		{
			reportheader = companyname.toUpperCase() +" "+branchname;
			for(int u=0;u<cdata.length;u++)
			{
				child = new Vector();
				child.addElement((u+1));
				child.addElement(cdata[u][0]);
				child.addElement(cdata[u][1]);
				
				child.addElement(cdata[u][14]);
				child.addElement(cdata[u][15]);
				child.addElement(cdata[u][16]);
				
				child.addElement(cdata[u][12]);
				child.addElement(cdata[u][17]);
				child.addElement("A/c No : "+cdata[u][13]);
				
				
				child.addElement(cdata[u][10]);
				child.addElement(cdata[u][11]);
				
				child.addElement(cdata[u][2]);
				child.addElement(cdata[u][3]);
				child.addElement(cdata[u][4]);
				child.addElement(cdata[u][5]);
				child.addElement(cdata[u][6]);
				child.addElement(cdata[u][7]);
				child.addElement(cdata[u][8]);
				child.addElement("");
				child.addElement(cdata[u][18]);
				child.addElement(cdata[u][19]);
				child.addElement(cdata[u][20]);
				sum1= sum1+Double.parseDouble(cdata[u][2]);
				sum2= sum2+Double.parseDouble(cdata[u][3]);
				sum3= sum3+Double.parseDouble(cdata[u][4]);
				sum4= sum4+Double.parseDouble(cdata[u][5]);
				sum5= sum5+Double.parseDouble(cdata[u][6]);
				sum6= sum6+Double.parseDouble(cdata[u][7]);
				sum= sum+Double.parseDouble(cdata[u][9]);
				mn.add(child); 
			}
			child = new Vector();
			child.addElement("");
			child.addElement("");
			child.addElement("");
			child.addElement("");
			child.addElement("");
			child.addElement("");
			child.addElement("");
			child.addElement("");
			child.addElement("");
			child.addElement("");
			child.addElement("TOTAL");
			child.addElement(Math.round(sum1));
			child.addElement(Math.round(sum2));
			child.addElement(Math.round(sum3));
			child.addElement(Math.round(sum4));
			child.addElement(Math.round(sum5));
			child.addElement(Math.round(sum6));
			child.addElement(Math.round(sum));
			child.addElement("");
			child.addElement("");
			child.addElement("");
			child.addElement("");
			mn.add(child); 
		} 
		
		request.setAttribute("table",mn);
		 
%>

 
<display:table   id="_table" name="table"   export="true" pagesize="25">
 
	 				<display:caption><%=reportheader.toUpperCase()%></display:caption>
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="EMPID"   sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="EMP NAME"   sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="Office"   sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="Department"   sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="Category"   sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="Bank"   sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="IFSC Code"   sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="A/C No"   sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="From Date"   sortable="true"><%=temp.elementAt(9)%></display:column>
					<display:column title="To Date"   sortable="true"><%=temp.elementAt(10)%></display:column>
					<display:column title="Vehicle Amount"   sortable="true"><%=temp.elementAt(11)%></display:column>
					<display:column title="Train/Bus Fare"   sortable="true"><%=temp.elementAt(12)%></display:column>
					<display:column title="Auto Fare"   sortable="true"><%=temp.elementAt(13)%></display:column>
					<display:column title="Lunch / Dinner"   sortable="true"><%=temp.elementAt(14)%></display:column>
					<display:column title="Telephone Charges"   sortable="true"><%=temp.elementAt(15)%></display:column>
					<display:column title="Others Amt"   sortable="true"><%=temp.elementAt(16)%></display:column>
					<display:column title="Total"   sortable="true"><%=temp.elementAt(17)%></display:column>
					<display:column title="Advance"   sortable="true"><%=temp.elementAt(19)%></display:column>
					<display:column title="Advance Deduction"   sortable="true"><%=temp.elementAt(20)%></display:column>
					<display:column title="Conveyance"   sortable="true"><%=temp.elementAt(21)%></display:column>
					<display:column title="Signature"   sortable="true"><%=temp.elementAt(18)%></display:column>
					 
					<display:setProperty name="export.excel.filename" value="Rept_Conveyance.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_Conveyance.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rept_Conveyance.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					 
					 
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
<%
}
catch(Exception e)
{
	e.printStackTrace();
	System.out.println(e.getMessage());
}
%>	
