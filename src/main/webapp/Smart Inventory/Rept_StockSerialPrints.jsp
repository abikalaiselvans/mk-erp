<%@ page import="java.io.*,java.util.*,com.my.org.erp.common.*"%>
<%@ page import="sun.net.smtp.SmtpClient"%>
<%
try
{ 

%>
<html>
<head>
<title>:: INVENTORY ::</title><link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>



<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js" type="text/javascript"></script>


<body >
<%@ include file="indexinv.jsp"%>
 <table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<div align="center">
		<%


		String Branch = request.getParameter("Branch");
		String division = request.getParameter("division");
		String itype = request.getParameter("itype");
		String item = request.getParameter("item");
		String sql=""; 
		
		out.println("<center>");
		out.println(com.my.org.erp.common.CommonFunctions.QueryExecute("Select CONCAT(b.CHR_COMPANYNAME,'  @  ',a.CHR_BRANCHNAME   ) from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID AND a.INT_BRANCHID="+Branch)[0][0]+"<br><br>");
		
		
		
		if("I".equals(itype))
		{
				sql = " SELECT b.CHR_ITEMID,b.CHR_ITEMNAME ,b.CHR_DES,  COUNT(*)  ";
				sql = sql+ "  FROM inv_t_vendorgoodsreceived  a , inv_m_item b ";
				sql = sql+ "  WHERE  a.CHR_ITEMID =b.CHR_ITEMID  ";
				sql = sql+ "  AND a.CHR_TYPE='I' ";
				if(!"0".equals(item))
					sql = sql +" AND  a.CHR_ITEMID ='"+item+"' ";
				if(!"0".equals(division))
					sql = sql+" AND b.INT_DIVIID="+division;
				sql = sql+ "  AND  a.INT_BRANCHID = "+Branch;
				sql = sql+ "  GROUP BY a.CHR_ITEMID ";
				sql = sql+ "  ORDER BY b.CHR_ITEMNAME ";
				
				 
				String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				 
				
				out.println("<table width='60%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
				out.println("<tr class='MRow1'>");
				out.println("<td class='boldEleven'><b>S.No</b></td>");
				out.println("<td class='boldEleven'><b>Type</b></td>");
				out.println("<td class='boldEleven'><b>Name</b></td>");
				out.println("<td class='boldEleven'><b>Descritpion</b></td>");
				out.println("<td class='boldEleven'><b>Total Numbers</b></td>");
				out.println("</tr>");
				 if(data.length>0)
				{
					int count=0;
					for(int u=0;u<data.length;u++)
					{
						if(u%2==0)
							out.println("<tr class='MRow1'>");
						else
							out.println("<tr class='MRow2'>");
						out.println("<td class='boldEleven'>"+(u+1)+"</td>");
						out.println("<td class='boldEleven'>Item</td>");
						out.println("<td class='boldEleven'>"+data[u][1]+"</td>");
						out.println("<td class='boldEleven'>"+data[u][2]+"</td>");
						out.println("<td class='boldEleven'>"+data[u][3]+"</td>");
						out.println("</tr>");
						if(!"-".equals(data[u][3]))
							count = Integer.parseInt(data[u][3]);
						
						
						
						if(count>0)
						{
								sql = "";
								sql = sql+ "  SELECT a.CHR_TYPE,a.CHR_ITEMID  ,a.CHR_SERIALNO,a.CHR_QUALITY  ";
								sql = sql+ "  FROM inv_t_vendorgoodsreceived  a , inv_m_item b  ";
								sql = sql+ "  WHERE  a.CHR_ITEMID =b.CHR_ITEMID   ";
								sql = sql+ "  AND a.CHR_TYPE='I'  ";
								sql = sql+ "  AND  a.INT_BRANCHID ="+Branch;
								sql = sql+ "  AND  a.CHR_ITEMID ='"+data[u][0]+"'";
								sql = sql+ "  ORDER BY b.CHR_ITEMNAME  ";
						
								if(u%2==0)
									out.println("<tr class='MRow1'>");
								else
									out.println("<tr class='MRow2'>");
								
								
								
								out.println("<td>&nbsp;<td colspan='4' class='boldEleven'><b>Serial Numbers ::</b><br>");
								out.println("<br><table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#ffffff' >");
								 
								 
								String sdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
								 
								for(int k=0;k<sdata.length;k++)
								{
									
									if(k%5==0)
										out.println("<tr bgcolor='#ffffff'>");
									
									if(!"-".equals(sdata[k][2]))
										if("H".equals(sdata[k][3]))
											out.println("<td class='boldEleven'><font  class='tMLAscreenHead'>"+sdata[k][2]+"</font></td>");
										else
											out.println("<td class='boldEleven'>"+sdata[k][2]+"</td>");	
									
									
									 
									 
								}	
								out.println("</tr></table><br>");
								out.println("</td>");
								out.println("</tr>");
								
								
								
								 
								
						}
						
							
								
					}
					
				} 
				  out.println("</table>");
				 
		}
			
			
			
		
		
		
		
		
		//PRODUCT
		
		if("P".equals(itype))
		{
				sql = " SELECT b.CHR_PRODUCTID,b.CHR_PRODUCTCODE ,b.CHR_PRODUCTDESC,  COUNT(*)  ";
				sql = sql+ "  FROM inv_t_vendorgoodsreceived  a , inv_m_produtlist b ";
				sql = sql+ "  WHERE  a.CHR_ITEMID =b.CHR_PRODUCTID  ";
				sql = sql+ "  AND a.CHR_TYPE='P' ";
				if(!"0".equals(item))
					sql = sql +" AND  a.CHR_ITEMID ='"+item+"' ";
				if(!"0".equals(division))
					sql = sql+" AND b.INT_DIVIID="+division;
				sql = sql+ "  AND  a.INT_BRANCHID = "+Branch;
				sql = sql+ "  GROUP BY a.CHR_ITEMID ";
				sql = sql+ "  ORDER BY b.CHR_PRODUCTCODE ";
				
				 
				String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				 
				
				out.println("<table width='60%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
				out.println("<tr class='MRow1'>");
				out.println("<td class='boldEleven'><b>S.No</b></td>");
				out.println("<td class='boldEleven'><b>Type</b></td>");
				out.println("<td class='boldEleven'><b>Name</b></td>");
				out.println("<td class='boldEleven'><b>Descritpion</b></td>");
				out.println("<td class='boldEleven'><b>Total Numbers</b></td>");
				out.println("</tr>");
				 if(data.length>0)
				{
					int count=0;
					for(int u=0;u<data.length;u++)
					{
						if(u%2==0)
							out.println("<tr class='MRow1'>");
						else
							out.println("<tr class='MRow2'>");
						out.println("<td class='boldEleven'>"+(u+1)+"</td>");
						out.println("<td class='boldEleven'>Product</td>");
						out.println("<td class='boldEleven'>"+data[u][1]+"</td>");
						out.println("<td class='boldEleven'>"+data[u][2]+"</td>");
						out.println("<td class='boldEleven'>"+data[u][3]+"</td>");
						out.println("</tr>");
						if(!"-".equals(data[u][3]))
							count = Integer.parseInt(data[u][3]);
						
						
						
						if(count>0)
						{
								sql = "";
								sql = sql+ "  SELECT a.CHR_TYPE,a.CHR_ITEMID  ,a.CHR_SERIALNO,a.CHR_QUALITY  ";
								sql = sql+ "  FROM inv_t_vendorgoodsreceived  a , inv_m_produtlist b  ";
								sql = sql+ "  WHERE  a.CHR_ITEMID =b.CHR_PRODUCTID   ";
								sql = sql+ "  AND a.CHR_TYPE='P'  ";
								sql = sql+ "  AND  a.INT_BRANCHID ="+Branch;
								sql = sql+ "  AND  a.CHR_ITEMID ='"+data[u][0]+"'";
								sql = sql+ "  ORDER BY b.CHR_PRODUCTCODE  ";
						
						
						
					 
								if(u%2==0)
									out.println("<tr class='MRow1'>");
								else
									out.println("<tr class='MRow2'>");
									
								out.println("<td>&nbsp;<td colspan='4' class='boldEleven'><b>Serial Numbers ::</b><br>");
								out.println("<br><table width='60%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#ffffff' >");
								 
								 
								String sdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
								 
								for(int k=0;k<sdata.length;k++)
								{
									
									if(k%5==0)
										out.println("<tr bgcolor='#ffffff'>");
									
									if(!"-".equals(sdata[k][2]))
										if("H".equals(sdata[k][3]))
											out.println("<td class='boldEleven'><font  class='tMLAscreenHead'>"+sdata[k][2]+"</font></td>");
										else
											out.println("<td class='boldEleven'>"+sdata[k][2]+"</td>");	
									
									
									 
									 
								}	
								out.println("</tr></table><br>");
								out.println("</td>");
								out.println("</tr>");
								
						}
						
							
								
					}
					
				} 
				  out.println("</table>");
				 
		}
		

		 
			 
	%>
		</div>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table width="184" align="center" cellpadding="15" cellspacing="0">
			<tr>
				<td width="100" height="44" class="boldEleven"><strong>Export
				</strong></td>
				<td class="boldEleven">
				<div align="center"><a title="Excel" href=javascript:;
					onClick=" CreateExcelSheet()"><img
					src="../Image/report/Excel.png" width="15" height="14" border="0"></a>
				</div>
				</td>

				<td class="boldEleven">
				<div align="center"><a title="Text" href=javascript:;
					onClick="windowSave('sample.txt')"><img
					src="../Image/report/text.gif" width="15" height="14" border="0"></a></a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a title="Document" href=javascript:;
					onClick="windowSave('sample.doc')"><img
					src="../Image/report/MS.GIF" width="15" height="14" border="0"></a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a title="HTML" href=javascript:;
					onClick="windowSave('sample.html')"><img
					src="../Image/report/IE.GIF" width="15" height="14" border="0"></a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a
					href='javascript:Print("Rept_StockSerialPrintpage.jsp")'><img
					src="../Image/report/print.gif" width="16" height="16" border="0"></a></div>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td valign="top">&nbsp;</td>
	</tr>
</table>
<script language="javascript">
 function Print(query)
	{  
		var width="800", height="400";
  		var left = (screen.width/2) - width/2;
		var top = (screen.height/2) - height/2;
		query=query+"?Branch=<%=Branch%>"+"&itype=<%=itype%>"+"&item=<%=item%>"+"&division=<%=division%>";
		 var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=yes,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
		newWindow = window.open(query,"subWind",styleStr);
		newWindow.focus( );
	}
	 
</script>
 <%@ include file="../footer.jsp"%> 
</body>
</html>


<%

}
catch(Exception e)
{
out.println(e.getMessage());
}	
%>