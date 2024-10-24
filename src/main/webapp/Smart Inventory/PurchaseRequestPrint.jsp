<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
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
<script language="JavaScript" src="../JavaScript/calendar1.js"	type="text/javascript"></script>
 
<body      onLoad="javascript:window.print()"><br><br><br>
<table width="800"  align="center"  border="1"     cellpadding=2 cellspacing=1 bordercolor="#000000" >
  <tr>
    <td><table cellspacing="2" cellpadding="2" width="800" align="center"
						border="0">
      <!--DWLayoutTable-->
      <tbody>
        <tr>
          <td height="16" colspan="4" align="center" valign="top"
									class="boldThirteen">PURCHASE REQUEST APPROVAL
            <%
				String Requestno = request.getParameter("Requestno");							
				String sql = " ";
				sql = " SELECT "; 
				sql = sql + " a.INT_POREQUESTID,b.CHR_BRANCHNAME,c.CHR_DIVICODE, a.CHR_POREQUESTNO,DATE_FORMAT(a.DAT_REQUESTDATE,'%d-%m-%Y'), ";
				sql = sql + " FIND_A_CUSTOMER_NAME(d.INT_CUSTOMERID),FIND_A_CUSTOMER_NAME(d.INT_CUSTOMERID), ";
				sql = sql + " f.CHR_PAYMENTNAME, ";
				sql = sql + " a.INT_CUSTOMERCOMMITMENTDAYS,a.CHR_REF,g.CHR_STAFFNAME,a.CHR_DES,a.CHR_APPROVEDSTATUS, ";
				sql = sql + " a.CHR_APPROVEDBY,DATE_FORMAT(a.DAT_APPROVEDDATE,'%d-%m-%Y'),a.CHR_APPROVEDDESCRIPTION ,a.INT_BRANCHID,a.INT_DIVIID,a.INT_CUSTOMERID  ";
				sql = sql + " FROM inv_t_purchaserequest a, com_m_branch b,inv_m_division c,inv_m_customerinfo d,   ";
				sql = sql + " inv_m_paymentterms f,com_m_staff g ";
				sql = sql + " WHERE a.INT_BRANCHID = b.INT_BRANCHID ";
				sql = sql + " AND a.INT_DIVIID =c.INT_DIVIID ";
				sql = sql + " AND a.INT_CUSTOMERID = d.INT_CUSTOMERID ";
				 
				sql = sql + " AND a.INT_PAYMENTTERMID = f.INT_PAYMENTTERMID ";
				sql = sql + " AND a.CHR_REF=g.CHR_EMPID AND 	CHR_POREQUESTNO='"+Requestno+"'";
				
				String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				
									%>          </td>
        </tr>
        <tr>
          <td height="19" colspan="4" align="right" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
        </tr>
        <tr>
          <td width="191" height="17" valign="top" class="bold1">Request Number / Date </td>
          <td width="313" align="left" valign="top"><span class="boldEleven"><%=data[0][3] +"  dated on " +data[0][4]%></span></td>
          <td width="129" class="bold1">Vendor Payment </td>
          <td width="141" class="boldEleven"><%=data[0][7]%>  </td>
        </tr>
        <tr>
          <td height="17" valign="top" class="bold1"><div align="left">CustomerName</div></td>
          <td align="left"><span class="boldEleven"><%=data[0][5]%>
              <input name="customer" type="hidden" id="customer" value="<%=data[0][18]%>">
          </span></td>
          <td class="bold1">Customer Commitment days </td>
          <td class="boldEleven"><%=data[0][8]+"- Days"%></td>
        </tr>
        <tr>
          <td class="bold1">Division</td>
          <td class="boldEleven"><%=data[0][2]%>
            <input name="divis" type="hidden" id="divis" value="<%=data[0][17]%>"></td>
          <td class="bold1">M.E </td>
          <td class="boldEleven"><%=data[0][9]+" / "+data[0][10]%></td>
        </tr>
        <tr>
          <td valign="top" class="bold1">Description </td>
          <td valign="top" class="boldEleven"><%=data[0][11]%> </td>
          <td valign="top" class="bold1"><!--DWLayoutEmptyCell-->&nbsp;</td>
          <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
        </tr>
        <tr>
          <td valign="top" class="bold1"><!--DWLayoutEmptyCell-->&nbsp;</td>
          <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
          <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
          <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
        </tr>
        <tr>
          <td height="17" colspan="4" valign="top" class="boldEleven"><div id="divscroll" style="OVERFLOW:auto;width:100%;height:auto">
            <table width='100%'      cellpadding=2 cellspacing=1   class='boldEleven'  id='myTable' bgcolor="#000000"  >
              <tr bgcolor="#FFFFFF">
                <td class="boldEleven"><b>S.No</b></td>
                <td class="boldEleven"><b>Vendor</b></td>
                <td class="boldEleven"><b>Type</b></td>
                <td class="boldEleven"><b>Item / Product Code</b></td>
                <td class="boldEleven"><b>Description</b></td>
                <td class="boldEleven"><b>Quantity</b></td>
                <td class="boldEleven"><strong><b>Unit PurchasePrice</b></strong></td>
                <td class="boldEleven"><strong><b>Tax</b></strong></td>
                <td class="boldEleven"><strong><b>Tax Amount</b></strong></td>
                <td class="boldEleven"><strong><b>Purchase Price [ Exclusive of Tax ]</b></strong></td>
                
                <td class="boldEleven"><strong><b>Unit Sale Price</b></strong></td>
                <td class="boldEleven"><strong><b>Tax</b></strong></td>
                <td class="boldEleven"><strong><b>Tax Amount</b></strong></td>
                <td class="boldEleven"><strong><b>Sale Price [ Exclusive of Tax ]</b></strong></td>
                
				<td class="boldEleven"><strong><b>Purchase Warranty</b></strong></td>
				<td class="boldEleven"><strong><b>Sale Warranty</b></strong></td>
                <%
					 if("F".equals(""+session.getAttribute("USRTYPE"))  || "B".equals(""+session.getAttribute("USRTYPE") ) )
					  {
							out.println("<td class='boldEleven'><strong><b>Contribution</strong></td>");
							out.println("<td class='boldEleven'><strong><b>Percentage (%) </strong></td>");
					  }
				  %>
                <td class="boldEleven"  bgcolor="#CCCCCC"><strong><b>If Installation /Delivery/Additional Warranty Required: Yes/No</b></strong></td>
                <td class="boldEleven"  bgcolor="#CCCCCC"><strong><b>Installation</b></strong></td>
                <td class="boldEleven"  bgcolor="#CCCCCC"><strong><b>Delivery</b></strong></td>
                <td class="boldEleven"  bgcolor="#CCCCCC"><strong><b>Additional Warranty</b></strong></td>
                <td class="boldEleven"  bgcolor="#CCCCCC"><strong><b>Gross Margin</b></strong></td>
                <td class="boldEleven"  bgcolor="#CCCCCC"><strong><b>Margin (%)</b></strong></td>
              </tr>
              <%
		  
		  
		 sql = " SELECT if(a.CHR_TYPE=\"I\",\"Item\",\"Product\"), ";
		 sql = sql +" if(a.CHR_TYPE=\"I\",(SELECT c.CHR_ITEMNAME FROM inv_m_item c WHERE c.CHR_ITEMID=a.CHR_ITEMID) , ";
		 sql = sql +" (SELECT d.CHR_PRODUCTCODE  FROM inv_m_produtlist d WHERE d.CHR_PRODUCTID=a.CHR_ITEMID) ";
		 sql = sql +"  ), ";
		 sql = sql +" a.CHR_DESC,a.INT_QUANTITY,a.DOU_UNITPRICE,(a.DOU_PURCHASEPRICE-a.DOU_P_TAX_AMOUNT),DOU_UNITSALEPRICE,(a.DOU_SALESPRICE-a.DOU_S_TAX_AMOUNT), ";
		 sql = sql +" if(a.CHR_ADDITIONALWARRANTY=\"Y\",\"Yes\",\"No\"), a.DOU_INSTALLATION, a.DOU_DELIVERY,a.DOU_ADDITIONALWARRANTY, ";
		 sql = sql +" a.DOU_GROSSVALUE,a.DOU_CONTRIBUTION, a.DOU_CONTRIBUTION_PERCENTAGE, a.CHR_ACCEPT,a.INT_ROWID,a.DOU_UNITSALEPRICE, ";
		 sql = sql +" ROUND(a.DOU_SALESPRICE/a.INT_QUANTITY,2)  ,b.CHR_VENDORNAME,DOU_MARGIN ,a.CHR_PURCHASEWARRANTY, a.CHR_SALESWARRANTY,  "; 
		 sql = sql +"  FUN_GET_TAX_NAME(a.INT_S_TAXID),a.DOU_S_TAX_AMOUNT , ";
		 sql = sql +"  FUN_GET_TAX_NAME(a.INT_P_TAXID),a.DOU_P_TAX_AMOUNT  ";
		 sql = sql +"  FROM inv_t_purchaserequestitem  a , inv_m_vendorsinformation  b ";
		 sql = sql +" WHERE a.INT_VENDORID  =b.INT_VENDORID  AND a.CHR_POREQUESTNO='"+Requestno+"' ORDER BY a.CHR_TYPE  ";
		 //out.println(sql);
		 String itemDatas[][] =  CommonFunctions.QueryExecute(sql);
		 double sum=0.0;
		if(itemDatas.length>0)
		{
				for(int u=0;u<itemDatas.length;u++)
				{
				 
					if(u%2==0)
						out.print("<tr class='MRow1'>");
					else
						out.print("<tr class='MRow1'>");
					out.println("<td  class='boldEleven' valign='top'   valign='top'>"+(u+1)+".</td>");
					out.println("<td  class='boldEleven' valign='top'   valign='top'>"+itemDatas[u][19] +"</td>");
					out.println("<td  class='boldEleven' valign='top'   valign='top'>"+itemDatas[u][0] +"</td>");
					out.println("<td  class='boldEleven' valign='top'   valign='top'>"+itemDatas[u][1] +"</td>");
					out.println("<td  class='boldEleven' valign='top'   valign='top'>"+itemDatas[u][2] +"</td>");
					out.println("<td  class='boldEleven' valign='top'   align='right'>"+itemDatas[u][3] +"</td>");
					
					out.println("<td  class='boldEleven' valign='top'   align='right'>"+itemDatas[u][4] +"</td>");//purchase unit price
					out.println("<td  class='boldEleven' valign='top'   align='right'>"+itemDatas[u][25] +"</td>");//purchase tax
					out.println("<td  class='boldEleven' valign='top'   align='right'>"+itemDatas[u][26] +"</td>");//purchase tax amount
					out.println("<td  class='boldEleven' valign='top'   align='right'>"+itemDatas[u][5] +"</td>");//purchase price
					
					out.println("<td  class='boldEleven' valign='top'   align='right'>"+itemDatas[u][6] +"</td>");// sale unit price
					out.println("<td  class='boldEleven' valign='top'   align='right'>"+itemDatas[u][23] +"</td>");//sale tax
					out.println("<td  class='boldEleven' valign='top'   align='right'>"+itemDatas[u][24] +"</td>");//sale tax amount
					out.println("<td  class='boldEleven' valign='top'   align='right'>"+itemDatas[u][7] +"</td>"); //sale price
					
					
					out.println("<td  class='boldEleven' valign='top'   align='center'>"+itemDatas[u][21] +"-Yrs</td>");
					out.println("<td  class='boldEleven' valign='top'   align='center'>"+itemDatas[u][22] +"-Yrs</td>");
					if("F".equals(""+session.getAttribute("USRTYPE"))  || "B".equals(""+session.getAttribute("USRTYPE") ) )
					{
						out.print("<td  class='boldEleven'  valign='top' align='right'> "+itemDatas[u][13]+" </td>");
						out.print("<td  class='boldEleven'  valign='top' align='right'> "+itemDatas[u][14]+" </td>");
						
					}
					out.println("<td  class='boldEleven' valign='top'   align='left'  bgcolor='#CCCCCC' >"+itemDatas[u][8] +"</td>");
					out.println("<td  class='boldEleven' valign='top'   align='right'  bgcolor='#CCCCCC' >"+itemDatas[u][9] +"</td>");
					out.println("<td  class='boldEleven' valign='top'   align='right'  bgcolor='#CCCCCC' >"+itemDatas[u][10] +"</td>");
					out.println("<td  class='boldEleven' valign='top'   align='right'  bgcolor='#CCCCCC' >"+itemDatas[u][11] +"</td>");
					out.println("<td  class='boldEleven' valign='top'   align='right'  bgcolor='#CCCCCC' >"+itemDatas[u][12] +"</td>");
					out.println("<td  class='boldEleven' valign='top'   align='right'  bgcolor='#CCCCCC' >"+itemDatas[u][20] +"</td>");  
					sum= sum+ Double.parseDouble(itemDatas[u][13]);
					
					out.print("</tr>");
			}
			
			
			
			
			sql = " SELECT SUM(INT_QUANTITY),SUM(DOU_UNITPRICE),SUM(DOU_PURCHASEPRICE),SUM(DOU_UNITSALEPRICE), ";
			sql = sql + "SUM(DOU_SALESPRICE), SUM(DOU_GROSSVALUE),SUM(DOU_CONTRIBUTION), SUM(DOU_CONTRIBUTION_PERCENTAGE) ";
			sql = sql + " FROM inv_t_purchaserequestitem WHERE CHR_POREQUESTNO='"+Requestno+"' ORDER BY CHR_TYPE ";
			 
			String sumdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
 			 out.print("<tr class='MRow1'>");
			out.print("<td  class='boldEleven'  valign='top'>&nbsp;</td>");
			out.print("<td  class='boldEleven'  valign='top'>&nbsp;</td>");
			out.print("<td  class='boldEleven'  valign='top'>&nbsp;</td>");
			out.print("<td  class='boldEleven'  valign='top'>&nbsp;</td>");
			out.print("<td  class='boldEleven'  valign='top'>&nbsp;</td>");
			out.print("<td  class='boldEleven'  valign='top'>&nbsp;</td>");
			out.print("<td  class='boldEleven'  valign='top'>&nbsp;</td>");
			out.print("<td  class='boldEleven'  valign='top' align='right'>&nbsp;</td>");
			out.print("<td  class='boldEleven'  valign='top' align='right'>&nbsp;</td>");
			out.print("<td  class='boldEleven'  valign='top' align='right'><img src=\"../Image/report/Rupee.gif\" width='10' height='10'>"+ sumdata[0][2] +"</td>");
			out.print("<td  class='boldEleven'  valign='top'>&nbsp;</td>");
			out.print("<td  class='boldEleven'  valign='top'>&nbsp;</td>");
			out.print("<td  class='boldEleven'  valign='top' align='right'>&nbsp;</td>");
			out.print("<td  class='boldEleven'  valign='top' align='right'><img src=\"../Image/report/Rupee.gif\" width='10' height='10'>"+ sumdata[0][4] +"</td>");
			out.print("<td  class='boldEleven'  valign='top'>&nbsp;</td>");
			out.print("<td  class='boldEleven'  valign='top'>&nbsp;</td>");
			if("F".equals(""+session.getAttribute("USRTYPE"))  || "B".equals(""+session.getAttribute("USRTYPE") ) )
			{
				out.print("<td  class='boldEleven' align='right'><img src=\"../Image/report/Rupee.gif\" width='10' height='10'>"+ sumdata[0][6] +"</td>");
				out.println("<td class='boldEleven'><strong><b>&nbsp; </strong></td>");
			}
			else
			{
				out.println("<td class='boldEleven'><strong><b>&nbsp;</strong></td>");
				out.println("<td class='boldEleven'><strong><b>&nbsp; </strong></td>");
			}	
			out.print("<td  class='boldEleven'  valign='top' align='right'  bgcolor='#CCCCCC' >&nbsp;</td>");
			out.print("<td  class='boldEleven'  valign='top'  bgcolor='#CCCCCC' >&nbsp;</td>");
			out.print("<td  class='boldEleven'  valign='top' align='right'  bgcolor='#CCCCCC' >&nbsp;</td>");
			out.print("<td  class='boldEleven'  valign='top' align='right'  bgcolor='#CCCCCC' >&nbsp;</td>");
			
			out.print("<td  class='boldEleven'  valign='top' align='right'  bgcolor='#CCCCCC' ><img src=\"../Image/report/Rupee.gif\" width='10' height='10'>"+ sumdata[0][5] +"</td>");
			out.print("<td  class='boldEleven'  valign='top' align='right'  bgcolor='#CCCCCC' >&nbsp;</td>");
			out.print("</tr>"); 
		}
		%>
            </table>
          </div></td>
        </tr>
        <tr>
          <td height="22" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
          <td align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
          <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
          <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
        </tr>
        <tr>
          <td height="17" colspan="4" class="boldEleven">
		  <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="22%" align="left" valign="top" class="boldEleven"><strong>&nbsp;Amount in words ::</strong></td>
    <td width="78%" align="left" valign="top" class="boldEleven style11">&nbsp;
      
	
	 
	 <center><div id="Rupees" align="center"><script language="javascript">numberWord("<%=sum%>","Rupees") </script></div></center></td>
  </tr>
</table>		  </td>
          </tr>
        <tr>
          <td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
          <td colspan="3" align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
        </tr>
      </tbody>
      <input type="hidden" name="mobileBookingOption" />
    </table></td>
  </tr>
</table>
<form  AUTOCOMPLETE = "off"   name="frm" method="post"  >
</form>
</body>
</html>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>
