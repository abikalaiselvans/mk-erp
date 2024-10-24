<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<%@ page import="java.util.*"%>
 <script language="javascript" src="../JavaScript/comfunction.js"></script>
  
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*,com.my.org.erp.common.*"%><head>
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
  
	<%
try
{
	
 
		 
   	String fromdate=""+request.getParameter("fromdate");
	String todate=""+request.getParameter("todate");
	String empid =""+session.getAttribute("EMPID");
	String fdt=fromdate;
	String tdt = todate;
	fromdate =  DateUtil.FormateDateSQL(fromdate);
	todate =  DateUtil.FormateDateSQL(todate);
	String sql="";
	sql = "SELECT CHR_EMPID,CHR_STAFFNAME FROM com_m_staff WHERE CHR_EMPID='"+empid+"' ";
	String pdata[][] = CommonFunctions.QueryExecute(sql);
	 
   	sql =  " ( ";
	sql = sql+" SELECT INT_CONID,DATE_FORMAT(DAT_CONDATE,'%d-%b-%Y'),CHR_FROM,CHR_TO,DOU_KM,DOU_TRAVEL,DOU_TRAIN,DOU_AUTO,DOU_LUNCH,";
	sql = sql+"	DOU_TELEPHONE,CHR_OTHERDESC, DOU_OTHERAMT,DOU_TOTAL,CHR_STATUS,CHR_DESC,CHR_ACCSTATUS  FROM conveyance_t_conveyance ";
	sql = sql+" WHERE (DAT_CONDATE)>='"+fromdate+"' AND (DAT_CONDATE)<='"+todate+"'   AND CHR_STATUS='Y' AND CHR_ACCEPT='Y'  AND CHR_ACCSTATUS='Y' ";
	sql = sql+" AND CHR_EMPID='"+empid+"'  ORDER BY DAT_CONDATE";
	sql = sql+" ) ";
	sql = sql+" UNION ";
	sql = sql+" ( ";
	sql = sql+" SELECT INT_CONID,DATE_FORMAT(DAT_CONDATE,'%d-%b-%Y'),CHR_FROM,CHR_TO,DOU_KM,DOU_TRAVEL,DOU_TRAIN,DOU_AUTO,DOU_LUNCH,";
	sql = sql+"	DOU_TELEPHONE,CHR_OTHERDESC, DOU_OTHERAMT,DOU_TOTAL,CHR_STATUS,CHR_DESC,CHR_ACCSTATUS  FROM conveyance_t_backup ";
	sql = sql+" WHERE (DAT_CONDATE)>='"+fromdate+"' AND (DAT_CONDATE)<='"+todate+"'   AND CHR_STATUS='Y' AND CHR_ACCEPT='Y'  AND CHR_ACCSTATUS='Y' ";
	sql = sql+" AND CHR_EMPID='"+empid+"'  ORDER BY DAT_CONDATE";
	sql = sql+" ) ";
	
	
	//out.println(sql);
	
	
	String data[][] = CommonFunctions.QueryExecute(sql);
	
	Vector mn = new Vector();
	Vector child= null;
	double sum=0;
	 	for(int u=0;u<data.length;u++)
		{
			child = new Vector();
			child.addElement((u+1));
			child.addElement(empid);
			child.addElement(pdata[0][1]);
			child.addElement(data[u][1].trim());	
			child.addElement(data[u][2].trim());
			child.addElement(data[u][3].trim());
			child.addElement(data[u][4].trim()+" - KM");
			child.addElement(data[u][5].trim());
			child.addElement(data[u][6].trim());
			child.addElement(data[u][7].trim());
			child.addElement(data[u][8].trim());
			child.addElement(data[u][9].trim());
			child.addElement(data[u][10].trim());
			child.addElement(data[u][11].trim());
			child.addElement(data[u][12].trim());
			sum= sum+Double.parseDouble(data[u][12].trim());
			 if("N".equals(data[u][13].trim()))
				child.addElement("Pending");
			else if("Y".equals(data[u][13].trim()))
				child.addElement("Accept");
			else if("R".equals(data[u][13].trim()))
				child.addElement("Reject");
			 
			if("Y".equals(data[u][15].trim()))
				child.addElement("Paid");
			else
				child.addElement("Not Paid");	
				 
				mn.add(child);  
			 
		}
   
   		child = new Vector();
   		for(int u=0;u<13;u++)
			child.addElement("");
			
		 
		child.addElement("Total : ");
		child.addElement( CommonFunctions.Round(sum));
		child.addElement("");
		child.addElement("");
		child.addElement("");
		mn.add(child); 
  		 
	 
	request.setAttribute("table",mn);
	out.println("<br><center><h3>   Name :: "+pdata[0][0]+"/ "+pdata[0][1]+"  From :" +fdt +" To : "+tdt+"   </h3></center><br>");
 
  



	 



%>
<display:table   id="_table" name="table"   export="true" pagesize="25">

	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title=" Sl.No" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="Employee Id" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="Employee Name" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="Date" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="From " sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title=" TO" sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="Vehicle No of Kms" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="Amount" sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="Train/Bus are" sortable="true"><%=temp.elementAt(8)%></display:column>
					
					<display:column title="Auto Fare" sortable="true"><%=temp.elementAt(9)%></display:column>
					<display:column title="Lunch / Dinner" sortable="true"><%=temp.elementAt(10)%></display:column>
					<display:column title="Telephone Charges" sortable="true"><%=temp.elementAt(11)%></display:column>
					<display:column title="Others Desc" sortable="true"><%=temp.elementAt(12)%></display:column>
					<display:column title="Others Amt" sortable="true"><%=temp.elementAt(13)%></display:column>
					<display:column title="Total" sortable="true"><%=temp.elementAt(14)%></display:column>
					<display:column title="Status " sortable="true"><%=temp.elementAt(15)%></display:column>
					<display:column title="Payment" sortable="true"><%=temp.elementAt(16)%></display:column>
					  
					
					<display:setProperty name="export.csv.filename" value="Rept_MyConveyance.csv"/>
					<display:setProperty name="export.excel.filename" value="Rept_MyConveyance.xls"/>
					<display:setProperty name="export.xml.filename" value="Rept_MyConveyance.xml"/>
					<display:setProperty name="export.pdf.filename" value="Rept_MyConveyance.pdf"/>
					<display:setProperty name="export.pdf" value="true" />
					 
</display:table>   



<br />	<center>	<a href='Rept_MyConveyance.jsp'> CLOSE</a>
</center>


<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>
 
</body>
</html>
