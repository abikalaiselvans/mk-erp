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
 
		String Branch = request.getParameter("Branch");
		String division = request.getParameter("division");
		String itype = request.getParameter("itype");
		String pgroup = request.getParameter("pgroup");
		String item = request.getParameter("item");
		String buyback = request.getParameter("buyback");
		String sql=""; 
		 
		String reportheader =""; 
		if(!"0".equals(Branch))
			reportheader=CommonFunctions.QueryExecute("Select CONCAT(b.CHR_COMPANYNAME,'  @  ',a.CHR_BRANCHNAME   ) from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID AND a.INT_BRANCHID="+Branch)[0][0]; 
		else
			reportheader	 ="";
		Vector mn = new Vector();
	 	Vector child= null;
		 
		 
		
		
		if("I".equals(itype))
		{
				sql = " SELECT b.CHR_ITEMID,b.CHR_ITEMNAME ,b.CHR_DES,  COUNT(*) ,SUM(a.DOU_UNITPRICE), c.CHR_GROUPNAME ,FUN_INV_DIVISION(a.INT_DIVIID) ,a.INT_DIVIID ,FUN_GET_BRANCH_NAME(a.INT_BRANCHID) ";
				sql = sql+ "  FROM inv_t_vendorgoodsreceived  a , inv_m_item b ,inv_m_itemgroup c";
				sql = sql+ "  WHERE  a.CHR_ITEMID =b.CHR_ITEMID  AND b.INT_ITEMGROUPID =c.INT_ITEMGROUPID ";
				sql = sql+ "  AND a.CHR_TYPE='I'  AND a.CHR_FLAG !='Y'  AND  a.CHR_GRTFLAG!='Y'  AND a.CHR_SERIALNO IS NOT NULL ";
				if(!"0".equals(pgroup))
					sql = sql+" AND b.INT_ITEMGROUPID="+pgroup;
				if(!"0".equals(item))
					sql = sql +" AND  a.CHR_ITEMID ='"+item+"' ";
				if(!"0".equals(division))
					sql = sql+" AND a.INT_DIVIID="+division;
				if(!"0".equals(Branch))
					sql = sql+ "  AND  a.INT_BRANCHID = "+Branch;
					
				if(!"0".equals(buyback))
					sql = sql +" AND  a.CHR_BUYBACK_STOCK ='"+buyback+"' ";
				
					
				sql = sql+ "  GROUP BY a.CHR_ITEMID ,a.INT_DIVIID ";
				sql = sql+ "  ORDER BY b.CHR_ITEMNAME ";
				//out.println(sql); 
				String data[][] =  CommonFunctions.QueryExecute(sql);
				 
				if(data.length>0)
				{
					int count=0;
					String serials="";
					for(int u=0;u<data.length;u++)
					{
						
						serials="";
						count=0;
						child = new Vector();
						child.addElement((u+1));
						child.addElement(data[u][6]);
						child.addElement("Item" );
						child.addElement(data[u][5]);
						child.addElement(data[u][1]);
						child.addElement(data[u][2]);
						child.addElement(data[u][3]);
						if(!"-".equals(data[u][3]))
							count = Integer.parseInt(data[u][3]);
						if(count>0)
						{
								sql = "";
								sql = sql+ "  SELECT a.CHR_TYPE,a.CHR_ITEMID  ,a.CHR_SERIALNO,a.CHR_QUALITY ,a.CHR_FLAG,a.CHR_BUYBACK_STOCK ";
								sql = sql+ "  FROM inv_t_vendorgoodsreceived  a , inv_m_item b  ";
								sql = sql+ "  WHERE  a.CHR_ITEMID =b.CHR_ITEMID   ";
								sql = sql+ "  AND a.CHR_TYPE='I'   AND a.CHR_FLAG !='Y' AND  a.CHR_GRTFLAG!='Y'  AND a.CHR_SERIALNO IS NOT NULL";
								if(!"0".equals(Branch))
									sql = sql+ "  AND  a.INT_BRANCHID ="+Branch;
								sql = sql+ "  AND  a.CHR_ITEMID ='"+data[u][0]+"'";
								sql = sql+ "  AND  a.INT_DIVIID ="+data[u][7];
								
								
								sql = sql+ "  ORDER BY b.CHR_ITEMNAME  ";
						 		String sdata[][]= CommonFunctions.QueryExecute(sql);
								 
								for(int k=0;k<sdata.length;k++)
								{
									if(k%5==0)
										serials = serials+"<br>";
									if(!"-".equals(sdata[k][2]))
										if("H".equals(sdata[k][3]) || !"N".equals(sdata[k][4])  || !"N".equals(sdata[k][5]))
											serials = serials+"<font color='red'>"+sdata[k][2] +"</font>,  ";
										else
											serials = serials+sdata[k][2]+",  ";
								}	
								 
						}
						child.addElement(serials);
						child.addElement(data[u][4]);
						child.addElement(data[u][8]);
						serials =serials.replaceAll("<br>","");
						serials =serials.replaceAll("<font color='red'>","");
						serials =serials.replaceAll("</font>","");
						child.addElement(serials);
						mn.add(child);
							
								
					}
					
				} 
				   
		}
			
			
			
		
		
		
		
		
		//PRODUCT
		
		if("P".equals(itype))
		{
				sql = " SELECT b.CHR_PRODUCTID,b.CHR_PRODUCTCODE ,b.CHR_PRODUCTDESC,  COUNT(*),SUM(a.DOU_UNITPRICE) ,c.CHR_NAME, FUN_INV_DIVISION(a.INT_DIVIID),a.INT_DIVIID  ,FUN_GET_BRANCH_NAME(a.INT_BRANCHID)   ";
				sql = sql+ "  FROM inv_t_vendorgoodsreceived  a , inv_m_produtlist b  , inv_m_productgroup c " ;
				sql = sql+ "  WHERE  a.CHR_ITEMID =b.CHR_PRODUCTID AND b.INT_PRODUCTGROUPID =c.INT_PRODUCTGROUPID  ";
				sql = sql+ "  AND a.CHR_TYPE='P'  AND a.CHR_FLAG !='Y'  AND  a.CHR_GRTFLAG!='Y'  AND b.CHR_PTYPE !='S'   AND a.CHR_SERIALNO IS NOT NULL ";
				if(!"0".equals(pgroup))
					sql = sql+" AND b.INT_PRODUCTGROUPID="+pgroup;
				if(!"0".equals(item))
					sql = sql +" AND  a.CHR_ITEMID ='"+item+"' ";
				if(!"0".equals(division))
					sql = sql+" AND a.INT_DIVIID="+division;
				if(!"0".equals(Branch))
					sql = sql+ "  AND  a.INT_BRANCHID = "+Branch;
				if(!"0".equals(buyback))
					sql = sql +" AND  a.CHR_BUYBACK_STOCK ='"+buyback+"' ";
				
				sql = sql+ "  GROUP BY a.CHR_ITEMID ,a.INT_DIVIID ";
				sql = sql+ "  ORDER BY b.CHR_PRODUCTCODE ";
				 
			 	String data[][] =  CommonFunctions.QueryExecute(sql);
				
				if(data.length>0)
				{
					int count=0;
					String serials="";
					for(int u=0;u<data.length;u++)
					{
						
						serials="";
						count=0;
						child = new Vector();
						child.addElement((u+1));
						child.addElement(data[u][6]);
						child.addElement("PRODUCT" );
						child.addElement(data[u][5]);
						child.addElement(data[u][1]);
						child.addElement(data[u][2]);
						child.addElement(data[u][3]);
						if(!"-".equals(data[u][3]))
							count = Integer.parseInt(data[u][3]);
							
						if(count>0)
						{
								sql = "";
								sql = sql+ "  SELECT a.CHR_TYPE,a.CHR_ITEMID  ,a.CHR_SERIALNO,a.CHR_QUALITY,  a.CHR_FLAG ,a.CHR_BUYBACK_STOCK  ";
								sql = sql+ "  FROM inv_t_vendorgoodsreceived  a , inv_m_produtlist b  ";
								sql = sql+ "  WHERE  a.CHR_ITEMID =b.CHR_PRODUCTID   ";
								sql = sql+ "  AND a.CHR_TYPE='P'   AND a.CHR_FLAG !='Y' AND  a.CHR_GRTFLAG!='Y'  AND a.CHR_SERIALNO IS NOT NULL";
								if(!"0".equals(Branch))
									sql = sql+ "  AND  a.INT_BRANCHID ="+Branch;
								sql = sql+ "  AND  a.CHR_ITEMID ='"+data[u][0]+"'";
								sql = sql+ "  AND  a.INT_DIVIID ="+data[u][7];
								
								sql = sql+ "  ORDER BY b.CHR_PRODUCTCODE  ";
								String sdata[][]= CommonFunctions.QueryExecute(sql);
								 
								for(int k=0;k<sdata.length;k++)
								{
									if(k%5==0)
										serials = serials+"<br>";
									if(!"-".equals(sdata[k][2]))
										if("H".equals(sdata[k][3])  || !"N".equals(sdata[k][4])  || !"N".equals(sdata[k][5]) )
											serials = serials+"<font color='red'>"+sdata[k][2]+"</font>,  ";
										else
											serials = serials+sdata[k][2]+",  ";
							    }	
						}
						child.addElement(serials);
						child.addElement(data[u][4]);
						child.addElement(data[u][8]);
						serials =serials.replaceAll("<br>","");
						serials =serials.replaceAll("<font color='red'>","");
						serials =serials.replaceAll("</font>","");
						child.addElement(serials);
						mn.add(child);
					}
					
				} 
		}
		
	request.setAttribute("table",mn);
%>



<display:table   id="_table" name="table"   export="true" pagesize="25" >
	 				<display:caption><%=reportheader.toUpperCase()%></display:caption>
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="DIVISION" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="LOCATION" sortable="true"><%=temp.elementAt(9)%></display:column>
					<display:column title="TYPE"   sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="GROUP"   sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="ITEM/PRODUCT NAME" sortable="true" ><%=temp.elementAt(4)%></display:column>
 					<display:column title="DESCRIPTION" sortable="true" ><%=temp.elementAt(5)%></display:column>
 					<display:column title="NO OF QUANTITY" sortable="true" ><%=temp.elementAt(6)%></display:column>
					<display:column title="SERIAL NUMBERS" media="html"    style="text-align:right" sortable="true" ><%=temp.elementAt(7)%></display:column>
                    <display:column title="TOTAL VALUES"  style="text-align:right" sortable="true" ><%=temp.elementAt(8)%></display:column>
 				    <display:column title="SERIAL" style="text-align:right" sortable="true" ><%=temp.elementAt(10)%></display:column>	
 					
 					
					<display:setProperty name="export.excel.filename"  value="Rept_StockValue.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_StockValue.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rept_StockValue.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					 
					 
</display:table>     
<br />	<center>	<a href='javascript:window.close()'> CLOSE</a>
</center>
 

 
 <%
}
catch(Exception e)
{
}
%>		 
</body>
</html>

 