<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%
try
{
%>
<html>
<head>

<title>:: ACCOUNTS ::</title>

 
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
<script language="javascript" src="../JavaScript/comfunction.js"></script>
 <body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="LoadNarration('0')" >

<%@ include file="indexacct.jsp"%>
<form name="frm" method="get">
<table width="1000" border="0" cellpadding="0" cellspacing="0">
	<!--DWLayoutTable-->
	<tr>
	  <td height="19">&nbsp;</td>
  </tr>
	<tr>
	  <td height="19">&nbsp;</td>
  </tr>
	<tr>
		<td width="1000" height="19">&nbsp;</td>
	</tr>
	<tr>
	  <td height="19"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td>
		  
		  <%
		  		String fdate=request.getParameter("fromdate");
				String tdate=request.getParameter("todate");
				String customerid= request.getParameter("customer");
				String order= request.getParameter("order");
				String Branch= request.getParameter("Branch");

				String sql = "";
				sql = " SELECT b.CHR_CUSTOMERNAME, a.CHR_DESC,DATE_FORMAT(a.DAT_DATE,'%d-%m-%Y'),a.DOU_AMOUNT ";
				sql = sql + " FROM  acc_t_contra a , acc_m_customer b WHERE a.INT_CUSTOMERID=b.INT_CUSTOMERID ";
				sql = sql + " AND a.DAT_DATE >='"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(fdate)+"'";
				sql = sql + " AND a.DAT_DATE <='"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(tdate)+"'";
				sql = sql + " AND a.INT_BRANCHID="+Branch;
				sql = sql + " ORDER BY  " +order;
				String data[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				out.println("<center>");
				out.println("<table width='800' class='boldEleven' id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC'>");
				double sum=0;
				if(data.length>0)
				{
					out.println("<tr bgcolor='#ffffff'><td  colspan='6'  class='boldEleven'><b><center>CONTRA ENTRY  REGISTER FROM : "+ fdate+" TO : "+tdate+"</center></b></td></tr>");
					out.println("<tr bgcolor='#ffffff'>");
					out.println("<td  class='boldEleven'><b>S.No</td>");
					out.println("<td  class='boldEleven'><b>Customer Name</td>");
					out.println("<td  class='boldEleven'><b>Description</td>");
					out.println("<td  class='boldEleven'><b>Date</td>");
					out.println("<td  class='boldEleven'><b>Amount</td>");
					out.println("</tr>");
					for(int u=0;u<data.length;u++)
					{
						if(u%2==0)
							out.println("<tr class='MRow1'>");
						else	
							out.println("<tr class='MRow2'>");
							
						out.println("<td  class='boldEleven'>"+(u+1)+".</td>");
						out.println("<td  class='boldEleven'>"+data[u][0]+"</td>");
						out.println("<td  class='boldEleven'>"+data[u][1]+"</td>");
						out.println("<td  class='boldEleven'>"+data[u][2]+"</td>");
						out.println("<td  class='boldEleven' align='right'>"+data[u][3]+"</td>");
						sum = sum+Double.parseDouble(data[u][3]);
						out.println("</tr>");
						
					}
					out.println("<tr bgcolor='#ffffff'><td  colspan='4'  class='boldEleven' align='right'>Total</td>");
					out.println("<td  class='boldEleven' align='right'>"+sum+"</td></tr>");
					out.println("<tr bgcolor='#ffffff'><td  colspan='5'  class='boldEleven' >");
					%>
					<div align="center" id="Rupees"> 
						<script	language="javascript">numberWord("<%=(sum)%>","Rupees")</script>
					</div>
					<%
					
				}
				else
				{
					out.println("<tr bgcolor='#ffffff'><td  colspan='6'  class='boldEleven'><font color='red'> Data not found...</font> </td></tr>");
				}
				out.println("</table>");
				out.println("</center>");
				
		  %>
		  </td>
        </tr>
        <tr>
          <td><table width="184" align="center" cellpadding="15" cellspacing="0">
            <tr>
              <td width="100" height="44" class="boldEleven"><strong>Export </strong></td>
              <td class="boldEleven"><div align="center"><a title="Excel" href=javascript:;
			onClick=" CreateExcelSheet()"><img
			src="../Image/report/Excel.png" width="15" height="14" border="0"></a> </div></td>
              <td class="boldEleven"><div align="center"><a title="Text" href=javascript:;
			onClick="windowSave('paymentcollection.txt')"><img
			src="../Image/report/text.gif" width="15" height="14" border="0"></a></div></td>
              <td class="boldEleven"><div align="center"><a title="Document" href=javascript:;
			onClick="windowSave('paymentcollection.doc')"><img
			src="../Image/report/MS.GIF" width="15" height="14" border="0"></a></div></td>
              <td class="boldEleven"><div align="center"><a title="HTML" href=javascript:;
			onClick="windowSave('paymentcollection.html')"><img
			src="../Image/report/IE.GIF" width="15" height="14" border="0"></a></div></td>
              <td class="boldEleven"><input name="Close" type="button" class="buttonbold" id="Close"  value="Close"   accesskey="c"  onClick="redirect('ContraRegister.jsp')"></td>
            </tr>
          </table></td>
        </tr>
      </table>
	  <%@ include file="../footer.jsp"%>
</body>
</html>
<%
}
catch(Exception e)
{
}
%>
