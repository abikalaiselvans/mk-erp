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
 <script language="javascript" src="../JavaScript/comfunction.js"></script><title>:: INVENTORY ::</title> 


 
 
<style type="text/css" media="all">
      @import url("../JavaScript/css/maven-base.css");
      @import url("../JavaScript/css/maven-theme.css");
      @import url("../JavaScript/css/site.css");
      @import url("../JavaScript/css/screen.css");
  </style> 
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"
	type="text/javascript"></script>
<body >
 <%
try
	  {
 
	  
	  
	    String  Office = request.getParameter("Office");
	 	String  month = request.getParameter("month");
	 	String year = request.getParameter("year");
	  	String division = request.getParameter("division");
	  	String itype = request.getParameter("itype");
	  	String item = request.getParameter("item");
		String Zero = request.getParameter("Zero");
		
		month = com.my.org.erp.ServiceLogin.DateUtil.getMonth(Integer.parseInt(month));
		String sql=""; 
		
		String ii ="";
		if("1".equals(itype))
			ii="ITEM";
		else
			ii="PRODUCT";	
		 String reportheader="STOCK BOOK IN & OUT ("+ii+") FOR "+month.toUpperCase()+" - "+year+"  )" ;
		 //out.println(com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_OFFICENAME  FROM com_m_office  WHERE INT_OFFICEID="+Office)[0][0]);
		  Vector mn = new Vector();
		 Vector child= null;
		 
		 
		 if("1".equals(itype)) 
		 {
				 
				sql = " select  e.CHR_OFFICENAME,a.CHR_PRODUCTCODE,d.CHR_ITEMNAME,a.CHR_DESC,a.CHR_MONTH,a.INT_YEAR,  ";   
				sql = sql +" SUM(a.INT_OPEN),SUM(a.DOU_OPENVALUE),SUM(a.INT_IN),SUM(a.DOU_INVALUE),SUM(a.INT_OUT), ";
				sql = sql +" SUM(a.DOU_OUTVALUE),SUM(a.INT_BALANCE),SUM(a.DOU_PRICE)    "; 
				sql = sql +" from inv_t_stockbookinandout a,com_m_branch b ,inv_m_item d ,com_m_office e   ";
				sql = sql +" WHERE a.INT_BRANCHID=b.INT_BRANCHID   ";  
				sql = sql +" AND  SOUNDEX(e.CHR_OFFICENAME) =SOUNDEX('"+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_OFFICENAME  FROM com_m_office  WHERE INT_OFFICEID="+Office)[0][0] +"')  "; 
				sql = sql +" AND a.CHR_PRODUCTCODE =d.CHR_ITEMID ";
				sql = sql +" AND a.CHR_TYPE='I'   ";
				sql = sql +" AND  a.CHR_MONTH ='"+month+"' ";
				sql = sql +" AND  a.INT_YEAR = "+year ;
				if("Y".equals(Zero))
						sql = sql +" AND ( (a.INT_OPEN !=0 ) OR (a.INT_IN !=0 ) OR (a.INT_OUT !=0 )) ";
					
				if(!"0".equals(item))
					sql = sql +" AND a.CHR_ITEMID='"+item+"'";
				sql = sql +"  GROUP BY a.CHR_PRODUCTCODE ORDER BY d.CHR_ITEMNAME  ";  
				 
				
				  
				 String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				 if(data.length>0)
				 {
				 	double sum=0.0;
				    for(int u=0;u<data.length;u++)
					{
						child = new Vector();
						child.addElement((u+1));
						child.addElement(data[u][0]);
						child.addElement("Item");
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
						mn.add(child);
			      	}
					
					
					
					
					
					sql = " select  SUM(a.DOU_PRICE)    "; 
				sql = sql +" from inv_t_stockbookinandout a,com_m_branch b ,inv_m_item d ,com_m_office e   ";
				sql = sql +" WHERE a.INT_BRANCHID=b.INT_BRANCHID   ";  
				sql = sql +" AND  SOUNDEX(e.CHR_OFFICENAME) =SOUNDEX('"+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_OFFICENAME  FROM com_m_office  WHERE INT_OFFICEID="+Office)[0][0] +"')  "; 
				sql = sql +" AND a.CHR_PRODUCTCODE =d.CHR_ITEMID ";
				sql = sql +" AND a.CHR_TYPE='I'   ";
				sql = sql +" AND  a.CHR_MONTH ='"+month+"' ";
				sql = sql +" AND  a.INT_YEAR = "+year ;
				if(!"0".equals(item))
					sql = sql +" AND a.CHR_ITEMID='"+item+"'";
				 
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
					child.addElement("");
					child.addElement("");
					child.addElement("");
					child.addElement("Total");
					child.addElement(com.my.org.erp.common.CommonFunctions.QueryExecute(sql)[0][0]);
					mn.add(child);
		
				}
				 	 
				  
				 
		 } 
		 
		 
		 
		 
		 
		  if("2".equals(itype)) 
		 {
				 
				 
				 
				 
				 sql = " select  e.CHR_OFFICENAME,d.CHR_PRODUCTID,d.CHR_PRODUCTCODE,d.CHR_PRODUCTDESC,a.CHR_MONTH,a.INT_YEAR,  ";   
				sql = sql +" SUM(a.INT_OPEN),SUM(a.DOU_OPENVALUE),SUM(a.INT_IN),SUM(a.DOU_INVALUE),SUM(a.INT_OUT), ";
				sql = sql +" SUM(a.DOU_OUTVALUE),SUM(a.INT_BALANCE),SUM(a.DOU_PRICE)    "; 
				sql = sql +" from inv_t_stockbookinandout a,com_m_branch b ,inv_m_produtlist d ,com_m_office e   ";
				sql = sql +" WHERE a.INT_BRANCHID=b.INT_BRANCHID   ";  
				sql = sql +" AND  SOUNDEX(e.CHR_OFFICENAME) =SOUNDEX('"+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_OFFICENAME  FROM com_m_office  WHERE INT_OFFICEID="+Office)[0][0] +"')  "; 
				sql = sql +" AND a.CHR_PRODUCTCODE =d.CHR_PRODUCTID ";
				sql = sql +" AND a.CHR_TYPE='P'   ";
				sql = sql +" AND  a.CHR_MONTH ='"+month+"' ";
				sql = sql +" AND  a.INT_YEAR = "+year ;
				if("Y".equals(Zero))
						sql = sql +" AND ( (a.INT_OPEN !=0 ) OR (a.INT_IN !=0 ) OR (a.INT_OUT !=0 )) ";
					
				if(!"0".equals(item))
					sql = sql +" AND a.CHR_PRODUCTCODE='"+item+"'";
				sql = sql +"  GROUP BY a.CHR_PRODUCTCODE ORDER BY a.CHR_PRODUCTCODE  ";  
				 
				//out.println(sql);
				
				
				  
				  
				 String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				 if(data.length>0)
				 {
				    for(int u=0;u<data.length;u++)
					{
						child = new Vector();
						child.addElement((u+1));
						child.addElement(data[u][0]);
						child.addElement("Product");
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
						mn.add(child);
			      	}
					
						 
					 
					  sql = " select   SUM(a.DOU_PRICE)    "; 
				sql = sql +" from inv_t_stockbookinandout a,com_m_branch b ,inv_m_produtlist d ,com_m_office e   ";
				sql = sql +" WHERE a.INT_BRANCHID=b.INT_BRANCHID   ";  
				sql = sql +" AND  SOUNDEX(e.CHR_OFFICENAME) =SOUNDEX('"+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_OFFICENAME  FROM com_m_office  WHERE INT_OFFICEID="+Office)[0][0] +"')  "; 
				sql = sql +" AND a.CHR_PRODUCTCODE =d.CHR_PRODUCTID ";
				sql = sql +" AND a.CHR_TYPE='P'   ";
				sql = sql +" AND  a.CHR_MONTH ='"+month+"' ";
				sql = sql +" AND  a.INT_YEAR = "+year ;
				if(!"0".equals(item))
					sql = sql +" AND a.CHR_PRODUCTCODE='"+item+"'";
				  
				
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
					child.addElement("");
					child.addElement("");
					child.addElement("");
					child.addElement("Total");
					child.addElement(com.my.org.erp.common.CommonFunctions.QueryExecute(sql)[0][0]);
					mn.add(child); 
				}	 
				  
				 
		 } 
		 
		 
		 
		/*out.println("<center>");
		out.println("<table width=900  id='myTable' align=center    cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
		out.println("<tr bgcolor='#ffffff'>");
		out.println("<td colspan= '15' class='boldEleven' align=center><b>STOCK BOOK VIEW FOR "+month.toUpperCase()+" - "+year+"   </b></td>");
		out.println("<tr  bgcolor='#ffffff'><td class='boldEleven'><b>S. No </td>");
		out.println("<td class='boldEleven'><b>Office</td>");
		out.println("<td class='boldEleven'><b>Type</td>");
		out.println("<td class='boldEleven'><b>Name</td>");
		out.println("<td class='boldEleven'><b>Description</td>");
		out.println("<td class='boldEleven'><b>Month</td>");
		out.println("<td class='boldEleven'><b>Year</td>");
		out.println("<td class='boldEleven'  ><b>Open</td>");
		out.println("<td class='boldEleven'  ><b>Value</td>");
		out.println("<td class='boldEleven'><b>In</td>");
		out.println("<td class='boldEleven'  ><b>Value</td>");
		out.println("<td class='boldEleven'><b>Out</td>");
		out.println("<td class='boldEleven'  ><b>Value</td>");
		out.println("<td class='boldEleven'><b>Balance</td>");
		out.println("<td class='boldEleven'  ><b>Value</td>");
		if("1".equals(itype)) 
		 {
				 
				sql = " select  e.CHR_OFFICENAME,a.CHR_PRODUCTCODE,d.CHR_ITEMNAME,a.CHR_DESC,a.CHR_MONTH,a.INT_YEAR,  ";   
				sql = sql +" SUM(a.INT_OPEN),SUM(a.DOU_OPENVALUE),SUM(a.INT_IN),SUM(a.DOU_INVALUE),SUM(a.INT_OUT), ";
				sql = sql +" SUM(a.DOU_OUTVALUE),SUM(a.INT_BALANCE),SUM(a.DOU_PRICE)    "; 
				sql = sql +" from inv_t_stockbookinandout a,com_m_branch b ,inv_m_item d ,com_m_office e   ";
				sql = sql +" WHERE a.INT_BRANCHID=b.INT_BRANCHID   ";  
				sql = sql +" AND  SOUNDEX(b.CHR_BRANCHNAME) =SOUNDEX('"+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_OFFICENAME  FROM com_m_office  WHERE INT_OFFICEID="+Office)[0][0] +"')  "; 
				sql = sql +" AND a.CHR_PRODUCTCODE =d.CHR_ITEMID ";
				sql = sql +" AND a.CHR_TYPE='I'   ";
				sql = sql +" AND  a.CHR_MONTH ='"+month+"' ";
				sql = sql +" AND  a.INT_YEAR = "+year ;
				if("Y".equals(Zero))
						sql = sql +" AND ( (a.INT_OPEN !=0 ) OR (a.INT_IN !=0 ) OR (a.INT_OUT !=0 )) ";
					
				if(!"0".equals(item))
					sql = sql +" AND a.CHR_ITEMID='"+item+"'";
				sql = sql +"  GROUP BY a.CHR_PRODUCTCODE ORDER BY d.CHR_ITEMNAME  ";  
				 
				
				  
				 String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				 if(data.length>0)
				 {
				 	double sum=0.0;
				    for(int u=0;u<data.length;u++)
					{
						if(u%2==0)
							out.println("<tr class='MRow2'>");
						else
							out.println("<tr class='MRow1'>");	
						out.println("<td class='boldEleven'>"+(u+1)+"</td>");
						out.println("<td class='boldEleven'>"+data[u][0]+"</td>");
						out.println("<td class='boldEleven'>Item</td>");
						out.println("<td class='boldEleven'>"+data[u][2]+"</td>");
						out.println("<td class='boldEleven'>"+data[u][3]+"</td>");
						out.println("<td class='boldEleven'>"+data[u][4]+"</td>");
						out.println("<td class='boldEleven' align='right'>"+data[u][5]+"</td>");
						out.println("<td class='boldEleven' align='right'>"+data[u][6]+"</td>");
						out.println("<td class='boldEleven' align='right'>"+data[u][7]+"</td>");
						out.println("<td class='boldEleven' align='right'>"+data[u][8]+"</td>");
						out.println("<td class='boldEleven' align='right'>"+data[u][9]+"</td>");
						out.println("<td class='boldEleven' align='right'>"+data[u][10]+"</td>");
						out.println("<td class='boldEleven' align='right'>"+data[u][11]+"</td>");
						out.println("<td class='boldEleven' align='right'>"+data[u][12]+"</td>");
						out.println("<td class='boldEleven' align='right'>"+data[u][13]+"</td>");
						 
				
			      	}
					
					
					
					
					
					sql = " select  SUM(a.DOU_PRICE)    "; 
				sql = sql +" from inv_t_stockbookinandout a,com_m_branch b ,inv_m_item d ,com_m_office e   ";
				sql = sql +" WHERE a.INT_BRANCHID=b.INT_BRANCHID   ";  
				sql = sql +" AND  SOUNDEX(b.CHR_BRANCHNAME) =SOUNDEX('"+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_OFFICENAME  FROM com_m_office  WHERE INT_OFFICEID="+Office)[0][0] +"')  "; 
				sql = sql +" AND a.CHR_PRODUCTCODE =d.CHR_ITEMID ";
				sql = sql +" AND a.CHR_TYPE='I'   ";
				sql = sql +" AND  a.CHR_MONTH ='"+month+"' ";
				sql = sql +" AND  a.INT_YEAR = "+year ;
				if(!"0".equals(item))
					sql = sql +" AND a.CHR_ITEMID='"+item+"'";
				 
				
				
				
				 
				 
					out.println("<tr  bgcolor='#ffffff'>");
					out.println("<td class='boldEleven' colspan='14' align='right'><b>Total</td>");
					out.println("<td class='boldEleven'>"+com.my.org.erp.common.CommonFunctions.QueryExecute(sql)[0][0]+"</td>"); 
		
				}
				else
				{
					out.println("<tr class='MRow2'><td colspan=15 class='boldred' align=center><b>Data not found...</b></td></tr>");
				}	 
				  
				 
		 } 
		 
		 
		 
		 
		 
		 if("2".equals(itype)) 
		 {
				 
				 
				 
				 
				 sql = " select  e.CHR_OFFICENAME,d.CHR_PRODUCTID,d.CHR_PRODUCTCODE,d.CHR_PRODUCTDESC,a.CHR_MONTH,a.INT_YEAR,  ";   
				sql = sql +" SUM(a.INT_OPEN),SUM(a.DOU_OPENVALUE),SUM(a.INT_IN),SUM(a.DOU_INVALUE),SUM(a.INT_OUT), ";
				sql = sql +" SUM(a.DOU_OUTVALUE),SUM(a.INT_BALANCE),SUM(a.DOU_PRICE)    "; 
				sql = sql +" from inv_t_stockbookinandout a,com_m_branch b ,inv_m_produtlist d ,com_m_office e   ";
				sql = sql +" WHERE a.INT_BRANCHID=b.INT_BRANCHID   ";  
				sql = sql +" AND  SOUNDEX(b.CHR_BRANCHNAME) =SOUNDEX('"+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_OFFICENAME  FROM com_m_office  WHERE INT_OFFICEID="+Office)[0][0] +"')  "; 
				sql = sql +" AND a.CHR_PRODUCTCODE =d.CHR_PRODUCTID ";
				sql = sql +" AND a.CHR_TYPE='P'   ";
				sql = sql +" AND  a.CHR_MONTH ='"+month+"' ";
				sql = sql +" AND  a.INT_YEAR = "+year ;
				if("Y".equals(Zero))
						sql = sql +" AND ( (a.INT_OPEN !=0 ) OR (a.INT_IN !=0 ) OR (a.INT_OUT !=0 )) ";
					
				if(!"0".equals(item))
					sql = sql +" AND a.CHR_PRODUCTCODE='"+item+"'";
				sql = sql +"  GROUP BY a.CHR_PRODUCTCODE ORDER BY a.CHR_PRODUCTCODE  ";  
				 
				
				
				
				  
				  
				 String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				 if(data.length>0)
				 {
				    for(int u=0;u<data.length;u++)
					{
						if(u%2==0)
							out.println("<tr class='MRow2'>");
						else
							out.println("<tr class='MRow1'>");	
						out.println("<td class='boldEleven'>"+(u+1)+"</td>");
						out.println("<td class='boldEleven'>"+data[u][0]+"</td>");
						out.println("<td class='boldEleven'>Product</td>");
						out.println("<td class='boldEleven'>"+data[u][2]+"</td>");
						out.println("<td class='boldEleven'>"+data[u][3]+"</td>");
						out.println("<td class='boldEleven'>"+data[u][4]+"</td>");
						out.println("<td class='boldEleven' align='right'>"+data[u][5]+"</td>");
						out.println("<td class='boldEleven' align='right'>"+data[u][6]+"</td>");
						out.println("<td class='boldEleven' align='right'>"+data[u][7]+"</td>");
						out.println("<td class='boldEleven' align='right'>"+data[u][8]+"</td>");
						out.println("<td class='boldEleven' align='right'>"+data[u][9]+"</td>");
						out.println("<td class='boldEleven' align='right'>"+data[u][10]+"</td>");
						out.println("<td class='boldEleven' align='right'>"+data[u][11]+"</td>");
						out.println("<td class='boldEleven' align='right'>"+data[u][12]+"</td>");
						out.println("<td class='boldEleven' align='right'>"+data[u][13]+"</td>");
						
				 
			      	}
					
						 
					 
					  sql = " select   SUM(a.DOU_PRICE)    "; 
				sql = sql +" from inv_t_stockbookinandout a,com_m_branch b ,inv_m_produtlist d ,com_m_office e   ";
				sql = sql +" WHERE a.INT_BRANCHID=b.INT_BRANCHID   ";  
				sql = sql +" AND  SOUNDEX(b.CHR_BRANCHNAME) =SOUNDEX('"+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_OFFICENAME  FROM com_m_office  WHERE INT_OFFICEID="+Office)[0][0] +"')  "; 
				sql = sql +" AND a.CHR_PRODUCTCODE =d.CHR_PRODUCTID ";
				sql = sql +" AND a.CHR_TYPE='P'   ";
				sql = sql +" AND  a.CHR_MONTH ='"+month+"' ";
				sql = sql +" AND  a.INT_YEAR = "+year ;
				if(!"0".equals(item))
					sql = sql +" AND a.CHR_PRODUCTCODE='"+item+"'";
				  
				
				
					out.println("<tr  bgcolor='#ffffff'>");
					out.println("<td class='boldEleven' colspan='14' align='right'><b>Total ::  </td>");
					out.println("<td class='boldEleven'>"+com.my.org.erp.common.CommonFunctions.QueryExecute(sql)[0][0]+"</td>"); 
				}
				else
				{
					out.println("<tr class='MRow2'><td colspan=15 class='boldred' align=center><b>Data not found...</b></td></tr>");
				}	 
				  
				 
		 } 
		 
		 
		 
		out.println("</table>");
		out.println("</center>");
		
		 
 */
  
		 

		request.setAttribute("table",mn);
		out.println("<br><center><h3> "+reportheader+" </h3></center><br>");
 %>
 
   <display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S. No " sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="Office" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="Type" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="Name" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="Description" sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="Month" sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="Year" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="Open" sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="Value" sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="In" sortable="true"><%=temp.elementAt(9)%></display:column>
					<display:column title="Value" sortable="true"><%=temp.elementAt(10)%></display:column>
					<display:column title="Out" sortable="true"><%=temp.elementAt(11)%></display:column>
					<display:column title="Value" sortable="true"><%=temp.elementAt(12)%></display:column>
					<display:column title="Balance" sortable="true"><%=temp.elementAt(13)%></display:column>
					<display:column title="Value" sortable="true"><%=temp.elementAt(14)%></display:column>
					
					 
				 
					<display:setProperty name="export.csv.filename" value="StockBookOfficeview.csv"/>
					<display:setProperty name="export.excel.filename" value="StockBookOfficeview.xls"/>
					<display:setProperty name="export.xml.filename" value="StockBookOfficeview.xml"/>
					<display:setProperty name="export.pdf.filename" value="StockBookOfficeview.pdf"/>
					<display:setProperty name="export.pdf" value="true" />
					 
</display:table>    
<br />	<br /><br /><center>	
<a href="Rept_StockBookOfficeview.jsp">Close</a>
 
</center><br /><br /><br />
 <%		 		 

	   
}
catch(Exception e)
{
}
%>
</body>
</html>
