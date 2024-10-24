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
 <title>:: INVENTORY ::</title>

<style type="text/css" media="all">
      @import url("../JavaScript/css/maven-base.css");
      @import url("../JavaScript/css/maven-theme.css");
      @import url("../JavaScript/css/site.css");
      @import url("../JavaScript/css/screen.css");
  </style> 
  
   
</head>
<body >

<%
try
{
 		
		 
		 
		String type = request.getParameter("type");
		String years = request.getParameter("year");
		int year = Integer.parseInt( years);
		 
	 	 
		String reportheader=" YPC   " +year  +" - " +(year+1); 
		String sql ="  ";
			
		Vector mn = new Vector();
	 	Vector child= null;
		 
		if("1".equals(type)   )
		{
			 
			sql = sql + " SELECT a.CHR_EMPID ,FIND_A_EMPLOYEE_ID_NAME(a.CHR_EMPID),CONCAT(a.INT_YEAR,'-',(a.INT_YEAR+1)) Accountyear, ";
			sql = sql + " a.INT_APR,FUN_INV_GET_TARGET_SALES(a.CHR_EMPID,'April',"+year+") APR_Sales,FUN_INV_GET_TARGET_ACHEIVE(a.CHR_EMPID,'April',"+year+") APR_Acheive, ";
			sql = sql + " FUN_PAY_GET_MONTH_CTC(a.CHR_EMPID,'April',"+year+") APR_CTC, ";
			sql = sql + " FUN_CON_GET_MONTH_CONVEYANCE(a.CHR_EMPID,'April',"+year+") APR_Conveyance, ";

			
			sql = sql + " a.INT_MAY,FUN_INV_GET_TARGET_SALES(a.CHR_EMPID,'May',"+year+") MAY_Sales,FUN_INV_GET_TARGET_ACHEIVE(a.CHR_EMPID,'May',"+year+") MAY_Acheive, ";
			sql = sql + " FUN_PAY_GET_MONTH_CTC(a.CHR_EMPID,'May',"+year+") MAY_CTC, ";
			sql = sql + " FUN_CON_GET_MONTH_CONVEYANCE(a.CHR_EMPID,'May',"+year+") MAY_Conveyance, ";

			
			
			sql = sql + " a.INT_JUN,FUN_INV_GET_TARGET_SALES(a.CHR_EMPID,'June',"+year+") JUN_Sales,FUN_INV_GET_TARGET_ACHEIVE(a.CHR_EMPID,'June',"+year+") JUN_Acheive, ";
			sql = sql + " FUN_PAY_GET_MONTH_CTC(a.CHR_EMPID,'June',"+year+") JUN_CTC, ";
			sql = sql + " FUN_CON_GET_MONTH_CONVEYANCE(a.CHR_EMPID,'June',"+year+") JUN_Conveyance, ";

			
			
			sql = sql + " a.INT_JUL,FUN_INV_GET_TARGET_SALES(a.CHR_EMPID,'July',"+year+") JUL_Sales,FUN_INV_GET_TARGET_ACHEIVE(a.CHR_EMPID,'July',"+year+") JUL_Acheive, ";
			sql = sql + " FUN_PAY_GET_MONTH_CTC(a.CHR_EMPID,'July',"+year+") JUL_CTC, ";
			sql = sql + " FUN_CON_GET_MONTH_CONVEYANCE(a.CHR_EMPID,'July',"+year+") JUL_Conveyance, ";

			
			
			sql = sql + " a.INT_AUG,FUN_INV_GET_TARGET_SALES(a.CHR_EMPID,'August',"+year+") AUG_Sales,FUN_INV_GET_TARGET_ACHEIVE(a.CHR_EMPID,'August',"+year+") AUG_Acheive, ";
			sql = sql + " FUN_PAY_GET_MONTH_CTC(a.CHR_EMPID,'August',"+year+") AUG_CTC, ";
			sql = sql + " FUN_CON_GET_MONTH_CONVEYANCE(a.CHR_EMPID,'August',"+year+") AUG_Conveyance, ";

			
			
			sql = sql + " a.INT_SEP,FUN_INV_GET_TARGET_SALES(a.CHR_EMPID,'September',"+year+") SEP_Sales,FUN_INV_GET_TARGET_ACHEIVE(a.CHR_EMPID,'September',"+year+") SEP_Acheive, ";
			sql = sql + " FUN_PAY_GET_MONTH_CTC(a.CHR_EMPID,'September',"+year+") SEP_CTC, ";
			sql = sql + " FUN_CON_GET_MONTH_CONVEYANCE(a.CHR_EMPID,'September',"+year+") SEP_Conveyance, ";

			
			sql = sql + " a.INT_OCT,FUN_INV_GET_TARGET_SALES(a.CHR_EMPID,'October',"+year+") OCT_Sales,FUN_INV_GET_TARGET_ACHEIVE(a.CHR_EMPID,'October',"+year+") OCT_Acheive, ";
			sql = sql + " FUN_PAY_GET_MONTH_CTC(a.CHR_EMPID,'October',"+year+") OCT_CTC, ";
			sql = sql + " FUN_CON_GET_MONTH_CONVEYANCE(a.CHR_EMPID,'October',"+year+") OCT_Conveyance, ";

			
			sql = sql + " a.INT_NOV,FUN_INV_GET_TARGET_SALES(a.CHR_EMPID,'November',"+year+") NOV_Sales,FUN_INV_GET_TARGET_ACHEIVE(a.CHR_EMPID,'November',"+year+") NOV_Acheive, ";
			sql = sql + " FUN_PAY_GET_MONTH_CTC(a.CHR_EMPID,'November',"+year+") NOV_CTC, ";
			sql = sql + " FUN_CON_GET_MONTH_CONVEYANCE(a.CHR_EMPID,'November',"+year+") NOV_Conveyance, ";

			
			sql = sql + " a.INT_DEC,FUN_INV_GET_TARGET_SALES(a.CHR_EMPID,'December',"+year+") DEC_Sales,FUN_INV_GET_TARGET_ACHEIVE(a.CHR_EMPID,'December',"+year+") DEC_Acheive, ";
			sql = sql + " FUN_PAY_GET_MONTH_CTC(a.CHR_EMPID,'December',"+year+") DEC_CTC, ";
			sql = sql + " FUN_CON_GET_MONTH_CONVEYANCE(a.CHR_EMPID,'December',"+year+") DEC_Conveyance, ";

			
			sql = sql + " a.INT_JAN,FUN_INV_GET_TARGET_SALES(a.CHR_EMPID,'January',"+(year+1)+") JAN_Sales,FUN_INV_GET_TARGET_ACHEIVE(a.CHR_EMPID,'January',"+(year+1)+") JAN_Acheive, ";
			sql = sql + " FUN_PAY_GET_MONTH_CTC(a.CHR_EMPID,'January',"+(year+1)+") JAN_CTC, ";
			sql = sql + " FUN_CON_GET_MONTH_CONVEYANCE(a.CHR_EMPID,'January',"+(year+1)+") JAN_Conveyance, ";

			
			sql = sql + " a.INT_FEB,FUN_INV_GET_TARGET_SALES(a.CHR_EMPID,'February',"+(year+1)+") FEB_Sales,FUN_INV_GET_TARGET_ACHEIVE(a.CHR_EMPID,'February',"+(year+1)+") FEB_Acheive, ";
			sql = sql + " FUN_PAY_GET_MONTH_CTC(a.CHR_EMPID,'February',"+(year+1)+") FEB_CTC, ";
			sql = sql + " FUN_CON_GET_MONTH_CONVEYANCE(a.CHR_EMPID,'February',"+(year+1)+") FEB_Conveyance, ";

			
			
			sql = sql + " a.INT_MAR,FUN_INV_GET_TARGET_SALES(a.CHR_EMPID,'March',"+(year+1)+") MAR_Sales,FUN_INV_GET_TARGET_ACHEIVE(a.CHR_EMPID,'March',"+(year+1)+") MAR_Acheive, ";
			sql = sql + " FUN_PAY_GET_MONTH_CTC(a.CHR_EMPID,'March',"+(year+1)+") MAR_CTC, ";
			sql = sql + " FUN_CON_GET_MONTH_CONVEYANCE(a.CHR_EMPID,'March',"+(year+1)+") MAR_Conveyance, ";

			
			sql = sql + "  (a.INT_APR+a.INT_MAY+a.INT_JUN+a.INT_JUL+a.INT_AUG+a.INT_SEP+a.INT_OCT+a.INT_NOV+a.INT_DEC+a.INT_JAN+a.INT_FEB+a.INT_MAR) APR_MAR, ";
			 
			sql = sql + "FUN_INV_GET_TARGET_FINANCIAL_SALES(a.CHR_EMPID,"+year+") APR_MAR_Sales,";
			sql = sql + "FUN_INV_GET_TARGET_FINANCIAL_ACHEIVE(a.CHR_EMPID,"+year+") APR_MAR_Acheive,";
			
			sql = sql + "FUN_PAY_GET_FINANCIAL_CTC(a.CHR_EMPID,"+year+"),";
			sql = sql + " FUN_CON_GET_FINANCIAL_CONVEYANCE(a.CHR_EMPID,"+year+")";


			sql = sql + " FROM inv_t_targetassign a   ";
			sql = sql + " WHERE a.INT_YEAR = "+year;
			
			
		}
		 //out.println(sql); 
		 
		String data[][] =  CommonFunctions.QueryExecute(sql);
		if(data.length>0)
		{
			 
			 
			
			for(int u=0;u<data.length;u++)
			{
				child = new Vector();
				child.addElement((u+1));
				child.addElement(data[u][1]);
				child.addElement(data[u][2]);
				
				child.addElement(data[u][3]);
				child.addElement(data[u][4]); 
				child.addElement(data[u][5]); 
				child.addElement(data[u][6]); 
				child.addElement(data[u][7]); 
				child.addElement("<a target='_blank' href='Rept_YPCResponseDetails.jsp?empid="+data[u][0]+"&type="+type+"&year="+year+"&month=04'>Details</a>"); 
				 
				child.addElement(data[u][8]);  
				child.addElement(data[u][9]); 
				child.addElement(data[u][10]);
				child.addElement(data[u][11]); 
				child.addElement(data[u][12]); 
				child.addElement("<a target='_blank' href='Rept_YPCResponseDetails.jsp?empid="+data[u][0]+"&type="+type+"&year="+year+"&month=05'>Details</a>"); 
				 
				child.addElement(data[u][13]); 
				child.addElement(data[u][14]);  
				child.addElement(data[u][15]);
				child.addElement(data[u][16]); 
				child.addElement(data[u][17]); 
				child.addElement("<a target='_blank' href='Rept_YPCResponseDetails.jsp?empid="+data[u][0]+"&type="+type+"&year="+year+"&month=06'>Details</a>"); 
				
				child.addElement(data[u][18]);
				child.addElement(data[u][19]);
				child.addElement(data[u][20]); 
				child.addElement(data[u][21]); 
				child.addElement(data[u][22]); 
				child.addElement("<a target='_blank' href='Rept_YPCResponseDetails.jsp?empid="+data[u][0]+"&type="+type+"&year="+year+"&month=07'>Details</a>"); 
				
				child.addElement(data[u][23]);  
				child.addElement(data[u][24]);  
				child.addElement(data[u][25]); 
				child.addElement(data[u][26]); 
				child.addElement(data[u][27]); 
				child.addElement("<a target='_blank' href='Rept_YPCResponseDetails.jsp?empid="+data[u][0]+"&type="+type+"&year="+year+"&month=08'>Details</a>"); 
				
				child.addElement(data[u][28]); 
				child.addElement(data[u][29]); 
				child.addElement(data[u][30]);  
				child.addElement(data[u][31]); 
				child.addElement(data[u][32]); 
				child.addElement("<a target='_blank' href='Rept_YPCResponseDetails.jsp?empid="+data[u][0]+"&type="+type+"&year="+year+"&month=09'>Details</a>"); 
				
				child.addElement(data[u][33]);
				child.addElement(data[u][34]);
				child.addElement(data[u][35]);
				child.addElement(data[u][36]); 
				child.addElement(data[u][37]); 
				child.addElement("<a target='_blank' href='Rept_YPCResponseDetails.jsp?empid="+data[u][0]+"&type="+type+"&year="+year+"&month=10'>Details</a>"); 
				
				child.addElement(data[u][38]); 
				child.addElement(data[u][39]);  
				child.addElement(data[u][40]);  
				child.addElement(data[u][41]); 
				child.addElement(data[u][42]); 
				child.addElement("<a target='_blank' href='Rept_YPCResponseDetails.jsp?empid="+data[u][0]+"&type="+type+"&year="+year+"&month=11'>Details</a>"); 
				
				child.addElement(data[u][43]); 
				child.addElement(data[u][44]); 
				child.addElement(data[u][45]); 
				child.addElement(data[u][46]); 
				child.addElement(data[u][47]); 
				child.addElement("<a target='_blank' href='Rept_YPCResponseDetails.jsp?empid="+data[u][0]+"&type="+type+"&year="+year+"&month=12'>Details</a>"); 
				
				child.addElement(data[u][48]); 
				child.addElement(data[u][49]);
				child.addElement(data[u][50]);
				child.addElement(data[u][51]); 
				child.addElement(data[u][52]); 
				child.addElement("<a target='_blank' href='Rept_YPCResponseDetails.jsp?empid="+data[u][0]+"&type="+type+"&year="+(year+1)+"&month=01'>Details</a>"); 
				
				child.addElement(data[u][53]);
				child.addElement(data[u][54]); 
				child.addElement(data[u][55]);  
				child.addElement(data[u][56]); 
				child.addElement(data[u][57]); 
				child.addElement("<a target='_blank' href='Rept_YPCResponseDetails.jsp?empid="+data[u][0]+"&type="+type+"&year="+(year+1)+"&month=02'>Details</a>"); 
				
				child.addElement(data[u][58]);  
				child.addElement(data[u][59]); 
				child.addElement(data[u][60]); 
				child.addElement(data[u][61]); 
				child.addElement(data[u][62]); 
				child.addElement("<a target='_blank' href='Rept_YPCResponseDetails.jsp?empid="+data[u][0]+"&type="+type+"&year="+(year+1)+"&month=03'>Details</a>"); 
				
				child.addElement(data[u][63]);  
				child.addElement(data[u][64]);
				child.addElement(data[u][65]);
				child.addElement(data[u][66]);
				child.addElement(data[u][67]);
				child.addElement("<a target='_blank' href='Rept_YPCResponseDetails.jsp?empid="+data[u][0]+"&type="+type+"&year="+year+"&month=0'>Details</a>"); 
				mn.add(child); 
			}
 		} 
			
		
		request.setAttribute("table",mn);
%>
<display:table   id="_table" name="table"   export="true" pagesize="25"  style="text-align:center" >
 
	<display:caption><%=reportheader.toUpperCase()%></display:caption>
	<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
	<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
	<display:column title="ME NAME" sortable="true"><%=temp.elementAt(1)%></display:column>
	<display:column title="FINANCIAL YEAR" sortable="true"><%=temp.elementAt(2)%></display:column>
	
	<display:column title="APR TARGET " style="text-align:right"   sortable="true"><%=temp.elementAt(3)%></display:column>
	<display:column title="APR SALES" style="text-align:right"   sortable="true"><%=temp.elementAt(4)%></display:column>
	<display:column title="APR ACHEIVE" style="text-align:right"   sortable="true"><%=temp.elementAt(5)%></display:column>
	<display:column title="APR CTC" style="text-align:right"   sortable="true"><%=temp.elementAt(6)%></display:column>
	<display:column title="APR CONVEYANCE" style="text-align:right"   sortable="true"><%=temp.elementAt(7)%></display:column>
	<display:column title=""  media='html' sortable="true"><%=temp.elementAt(8)%></display:column>
	
	<display:column title="MAY TARGET " style="text-align:right"   sortable="true"><%=temp.elementAt(9)%></display:column>
	<display:column title="MAY SALES" style="text-align:right"   sortable="true"><%=temp.elementAt(10)%></display:column>
	<display:column title="MAY ACHEIVE" style="text-align:right"   sortable="true"><%=temp.elementAt(11)%></display:column>
	<display:column title="MAY CTC" style="text-align:right"   sortable="true"><%=temp.elementAt(12)%></display:column>
	<display:column title="MAY CONVEYANCE" style="text-align:right"   sortable="true"><%=temp.elementAt(13)%></display:column>
	<display:column title=""  media='html' sortable="true"><%=temp.elementAt(14)%></display:column>
	
	<display:column title="JUN TARGET " style="text-align:right"   sortable="true"><%=temp.elementAt(15)%></display:column>
	<display:column title="JUN SALES" style="text-align:right"   sortable="true"><%=temp.elementAt(16)%></display:column>
	<display:column title="JUN ACHEIVE" style="text-align:right"   sortable="true"><%=temp.elementAt(17)%></display:column>
	<display:column title="JUN CTC" style="text-align:right"   sortable="true"><%=temp.elementAt(18)%></display:column>
	<display:column title="JUN CONVEYANCE" style="text-align:right"   sortable="true"><%=temp.elementAt(19)%></display:column>
	<display:column title=""  media='html' sortable="true"><%=temp.elementAt(20)%></display:column>
	
	<display:column title="JUL TARGET " style="text-align:right"   sortable="true"><%=temp.elementAt(21)%></display:column>
	<display:column title="JUL SALES" style="text-align:right"   sortable="true"><%=temp.elementAt(22)%></display:column>
	<display:column title="JUL ACHEIVE" style="text-align:right"   sortable="true"><%=temp.elementAt(23)%></display:column>
	<display:column title="JUL CTC" style="text-align:right"   sortable="true"><%=temp.elementAt(24)%></display:column>
	<display:column title="JUL CONVEYANCE" style="text-align:right"   sortable="true"><%=temp.elementAt(25)%></display:column>
	<display:column title=""  media='html' sortable="true"><%=temp.elementAt(26)%></display:column>
	
	<display:column title="AUG TARGET " style="text-align:right"   sortable="true"><%=temp.elementAt(27)%></display:column>
	<display:column title="AUG SALES" style="text-align:right"   sortable="true"><%=temp.elementAt(28)%></display:column>
	<display:column title="AUG ACHEIVE" style="text-align:right"   sortable="true"><%=temp.elementAt(29)%></display:column>
	<display:column title="AUG CTC" style="text-align:right"   sortable="true"><%=temp.elementAt(30)%></display:column>
	<display:column title="AUG CONVEYANCE" style="text-align:right"   sortable="true"><%=temp.elementAt(31)%></display:column>
	<display:column title=""  media='html' sortable="true"><%=temp.elementAt(32)%></display:column>
	
	<display:column title="SEP TARGET " style="text-align:right"   sortable="true"><%=temp.elementAt(33)%></display:column>
	<display:column title="SEP SALES" style="text-align:right"   sortable="true"><%=temp.elementAt(34)%></display:column>
	<display:column title="SEP ACHEIVE" style="text-align:right"   sortable="true"><%=temp.elementAt(35)%></display:column>
	<display:column title="SEP CTC" style="text-align:right"   sortable="true"><%=temp.elementAt(36)%></display:column>
	<display:column title="SEP CONVEYANCE" style="text-align:right"   sortable="true"><%=temp.elementAt(37)%></display:column>
	<display:column title=""  media='html' sortable="true"><%=temp.elementAt(38)%></display:column>
	
	<display:column title="OCT TARGET " style="text-align:right"   sortable="true"><%=temp.elementAt(39)%></display:column>
	<display:column title="OCT SALES" style="text-align:right"   sortable="true"><%=temp.elementAt(40)%></display:column>
	<display:column title="OCT ACHEIVE" style="text-align:right"   sortable="true"><%=temp.elementAt(41)%></display:column>
	<display:column title="OCT CTC" style="text-align:right"   sortable="true"><%=temp.elementAt(42)%></display:column>
	<display:column title="OCT CONVEYANCE" style="text-align:right"   sortable="true"><%=temp.elementAt(43)%></display:column>
	<display:column title=""  media='html' sortable="true"><%=temp.elementAt(44)%></display:column>
	
	<display:column title="NOV TARGET " style="text-align:right"   sortable="true"><%=temp.elementAt(45)%></display:column>
	<display:column title="NOV SALES" style="text-align:right"   sortable="true"><%=temp.elementAt(46)%></display:column>
	<display:column title="NOV ACHEIVE" style="text-align:right"   sortable="true"><%=temp.elementAt(47)%></display:column>
	<display:column title="NOV CTC" style="text-align:right"   sortable="true"><%=temp.elementAt(48)%></display:column>
	<display:column title="NOV CONVEYANCE" style="text-align:right"   sortable="true"><%=temp.elementAt(49)%></display:column>
	<display:column title=""  media='html' sortable="true"><%=temp.elementAt(50)%></display:column>
	
	<display:column title="DEC TARGET " style="text-align:right"   sortable="true"><%=temp.elementAt(51)%></display:column>
	<display:column title="DEC SALES" style="text-align:right"   sortable="true"><%=temp.elementAt(52)%></display:column>
	<display:column title="DEC ACHEIVE" style="text-align:right"   sortable="true"><%=temp.elementAt(53)%></display:column>
	<display:column title="DEC CTC" style="text-align:right"   sortable="true"><%=temp.elementAt(54)%></display:column>
	<display:column title="DEC CONVEYANCE" style="text-align:right"   sortable="true"><%=temp.elementAt(55)%></display:column>
	<display:column title=""  media='html' sortable="true"><%=temp.elementAt(56)%></display:column>
	
	<display:column title="JAN TARGET " style="text-align:right"   sortable="true"><%=temp.elementAt(57)%></display:column>
	<display:column title="JAN SALES" style="text-align:right"   sortable="true"><%=temp.elementAt(58)%></display:column>
	<display:column title="JAN ACHEIVE" style="text-align:right"   sortable="true"><%=temp.elementAt(59)%></display:column>
	<display:column title="JAN CTC" style="text-align:right"   sortable="true"><%=temp.elementAt(60)%></display:column>
	<display:column title="JAN CONVEYANCE" style="text-align:right"   sortable="true"><%=temp.elementAt(61)%></display:column>
	<display:column title=""  media='html' sortable="true"><%=temp.elementAt(62)%></display:column>
	
	<display:column title="FEB TARGET " style="text-align:right"   sortable="true"><%=temp.elementAt(63)%></display:column>
	<display:column title="FEB SALES" style="text-align:right"   sortable="true"><%=temp.elementAt(64)%></display:column>
	<display:column title="FEB ACHEIVE" style="text-align:right"   sortable="true"><%=temp.elementAt(65)%></display:column>
	<display:column title="FEB CTC" style="text-align:right"   sortable="true"><%=temp.elementAt(66)%></display:column>
	<display:column title="FEB CONVEYANCE" style="text-align:right"   sortable="true"><%=temp.elementAt(67)%></display:column>
	<display:column title=""  media='html' sortable="true"><%=temp.elementAt(68)%></display:column>
	
	<display:column title="MAR TARGET " style="text-align:right"   sortable="true"><%=temp.elementAt(69)%></display:column>
	<display:column title="MAR SALES" style="text-align:right"   sortable="true"><%=temp.elementAt(70)%></display:column>
	<display:column title="MAR ACHEIVE" style="text-align:right"   sortable="true"><%=temp.elementAt(71)%></display:column>
	<display:column title="MAR CTC" style="text-align:right"   sortable="true"><%=temp.elementAt(72)%></display:column>
	<display:column title="MAR CONVEYANCE" style="text-align:right"   sortable="true"><%=temp.elementAt(73)%></display:column>
	<display:column title=""  media='html' sortable="true"><%=temp.elementAt(74)%></display:column>
	
	<display:column title="APR-MAR TARGET " style="text-align:right"   sortable="true"><%=temp.elementAt(75)%></display:column>
	<display:column title="APR-MAR SALES" style="text-align:right"   sortable="true"><%=temp.elementAt(76)%></display:column>
	<display:column title="APR-MAR ACHEIVE" style="text-align:right"   sortable="true"><%=temp.elementAt(77)%></display:column>
 	<display:column title="APR-MAR CTC" style="text-align:right"   sortable="true"><%=temp.elementAt(78)%></display:column>
	<display:column title="APR-MAR CONVEYANCE" style="text-align:right"   sortable="true"><%=temp.elementAt(79)%></display:column>
	<display:column title=""  media='html' sortable="true"><%=temp.elementAt(80)%></display:column>
	
 	<display:setProperty name="export.excel.filename" value="Rept_YPCResponse.xls"/>
	<display:setProperty name="export.pdf.filename" value="Rept_YPCResponse.pdf"/>
	<display:setProperty name="export.csv.filename" value="Rept_YPCResponse.csv"/>
	<display:setProperty name="export.pdf"  value="true" />
	 
	 
</display:table> 
    
<br />	<center>	<a style="text-align:right" href='Rept_YPCResponse.jsp'> CLOSE</a>
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

