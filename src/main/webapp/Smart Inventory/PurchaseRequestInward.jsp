<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%><html>
<%
try
{
%>
<head>
<title>:: INVENTORY ::</title><style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
 </style>
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

 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
 
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
  
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
	  <td>	  </td>
	</tr>
	<tr>
		<td height="291"><table class="BackGround1" cellspacing="0" cellpadding="0" width="90%"
			align="center" border="0">
          <tbody>
            <tr>
              <td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/Smart Inventory/TLCorner.gif" width="7" /></td>
              <td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
              <td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/Smart Inventory/TRCorner.gif" width="7" /></td>
            </tr>
            <tr>
              <td height="6"><spacer height="1" width="1" type="block" /></td>
            </tr>
            <tr>
              <td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
              <td width="6"><spacer height="1" width="1" type="block" /></td>
              <td><table cellspacing="2" cellpadding="2" width="800" align="center"
						border="0">
                <!--DWLayoutTable-->
                <tbody>
                  <tr>
                    <td height="16" colspan="4" align="center" valign="top"
									class="boldThirteen">PURCHASE REQUEST INWARD
                      <%
				String Requestno = request.getParameter("Requestno");							
				String sql = " ";
				sql = " SELECT "; 
				sql = sql + " a.INT_POREQUESTID,b.CHR_BRANCHNAME,c.CHR_DIVICODE, a.CHR_POREQUESTNO,DATE_FORMAT(a.DAT_REQUESTDATE,'%d-%m-%Y'), ";
				sql = sql + " FIND_A_CUSTOMER_NAME(d.INT_CUSTOMERID),FIND_A_CUSTOMER_NAME(d.INT_CUSTOMERID), ";
				sql = sql + " f.CHR_PAYMENTNAME, ";
				sql = sql + " a.INT_CUSTOMERCOMMITMENTDAYS,a.CHR_REF,g.CHR_STAFFNAME,a.CHR_DES,a.CHR_APPROVEDSTATUS, ";
				sql = sql + " a.CHR_APPROVEDBY,DATE_FORMAT(a.DAT_APPROVEDDATE,'%d-%m-%Y'),a.CHR_APPROVEDDESCRIPTION ,a.INT_BRANCHID,a.INT_DIVIID,a.INT_CUSTOMERID ,(DATEDIFF(a.DAT_PURCHASEDATE,now())>=0),DATE_FORMAT(a.DAT_REQUESTDATE,'%d-%b-%Y'),DATE_FORMAT(a.DAT_PURCHASEDATE,'%d-%b-%Y') ";
				sql = sql + " FROM inv_t_purchaserequest a, com_m_branch b,inv_m_division c,inv_m_customerinfo d,   ";
				sql = sql + " inv_m_paymentterms f,com_m_staff g ";
				sql = sql + " WHERE a.INT_BRANCHID = b.INT_BRANCHID ";
				sql = sql + " AND a.INT_DIVIID =c.INT_DIVIID ";
				sql = sql + " AND a.INT_CUSTOMERID = d.INT_CUSTOMERID ";
				 
				sql = sql + " AND a.INT_PAYMENTTERMID = f.INT_PAYMENTTERMID ";
				sql = sql + " AND a.CHR_REF=g.CHR_EMPID AND 	CHR_POREQUESTNO='"+Requestno+"'";
				//out.println(sql);
				String data[][] = CommonFunctions.QueryExecute(sql);
				
									%>                    </td>
                  </tr>
                  <tr>
                    <td height="19" colspan="4" align="right" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="191" height="17" valign="top" class="bold1">Request Number / Date </td>
                    <td width="313" align="left" valign="top"><span class="boldEleven"><%=data[0][3] +"  dated on " +data[0][4]%></span></td>
                    <td width="129" class="bold1">Vendor Payment </td>
                    <td width="141" class="boldEleven"><%=data[0][7]%> </td>
                  </tr>
                  <tr>
                    <td height="17" valign="top" class="bold1"><div align="left">CustomerName</div></td>
                    <td align="left"><span class="boldEleven"><%=data[0][5]%>
                          <input name="customer" type="hidden" id="customer" value="<%=data[0][18]%>" />
                    </span></td>
                    <td class="bold1">Commitment days </td>
                    <td class="boldEleven"><%=data[0][8]+"- Days"%></td>
                  </tr>
                  <tr>
                    <td class="bold1">Division</td>
                    <td class="boldEleven"><%=data[0][2]%>
                        <input name="divis" type="hidden" id="divis" value="<%=data[0][17]%>" /></td>
                    <td class="bold1">M.E Name </td>
                    <td class="boldEleven"><%=data[0][9]+" / "+data[0][10]%></td>
                  </tr>
                  <tr>
                    <td valign="top" class="bold1">Request Date </td>
                    <td valign="top" class="boldEleven"><%=data[0][20]%></td>
                    <td valign="top" class="bold1">Proposed Date </td>
                    <td valign="top" class="boldEleven"><%=data[0][21]%></td>
                  </tr>
                  <tr>
                    <td valign="top" class="bold1">Description </td>
                    <td valign="top" class="boldEleven"><%=data[0][11]%></td>
                    <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                    <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                  </tr>
                  <tr>
                    <td height="17" colspan="4" valign="top" class="boldEleven"><div id="divscroll" style="OVERFLOW:auto;width:100%;height:auto">
                        <table width='100%'      cellpadding="2" cellspacing="1"   class='boldEleven'  id='myTable' bgcolor="#000000"  >
                          <tr bgcolor="#FFFFFF">
                            <td class="boldEleven"><b>S.No</b></td>
                            <td class="boldEleven"><b>Vendor</b></td>
                            <td class="boldEleven"><b>Type</b></td>
                            <td class="boldEleven"><b>Item / Product Code</b></td>
                            <td class="boldEleven"><b>Description</b></td>
                            <td class="boldEleven"><b>Quantity</b></td>
							<td class="boldEleven"><b>Inward Quantity</b></td>
                            <td class="boldEleven"><strong><b>Unit PurchasePrice</b></strong></td>
							<td class="boldEleven"><b>Balance</b></td>
                            <td class="boldEleven"><b>Status</b></td>
							<td class="boldEleven"><b>Inward</b></td>
                          </tr>
                          <%
		  
		  
		 sql = " SELECT if(a.CHR_TYPE=\"I\",\"Item\",\"Product\"), ";
		 sql = sql +" if(a.CHR_TYPE=\"I\",(SELECT c.CHR_ITEMNAME FROM inv_m_item c WHERE c.CHR_ITEMID=a.CHR_ITEMID) , ";
		 sql = sql +" (SELECT d.CHR_PRODUCTCODE  FROM inv_m_produtlist d WHERE d.CHR_PRODUCTID=a.CHR_ITEMID) ";
		 sql = sql +"  ), ";
		 sql = sql +" a.CHR_DESC,a.INT_QUANTITY,a.DOU_UNITPRICE,b.CHR_VENDORNAME, ";
		 sql = sql +"  a.INT_ROWID,a.INT_RECEIVEDQUANTITY,(a.INT_QUANTITY-a.INT_RECEIVEDQUANTITY),a.INT_VENDORID ";
		 sql = sql +"  FROM inv_t_purchaserequestitem  a , inv_m_vendorsinformation  b ";
		 sql = sql +" WHERE a.INT_VENDORID  =b.INT_VENDORID  AND a.CHR_POREQUESTNO='"+Requestno+"' ORDER BY a.CHR_TYPE  ";
		// out.println(sql);
		 String itemDatas[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
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
					out.println("<td  class='boldEleven' valign='top'   valign='top'>"+itemDatas[u][5] +"</td>");
					out.println("<td  class='boldEleven' valign='top'   valign='top'>"+itemDatas[u][0] +"</td>");
					out.println("<td  class='boldEleven' valign='top'   valign='top'>"+itemDatas[u][1] +"</td>");
					out.println("<td  class='boldEleven' valign='top'   valign='top'>"+itemDatas[u][2] +"</td>");
					out.println("<td  class='boldEleven' valign='top'   align='right'>"+itemDatas[u][3] +"</td>");
					out.println("<td  class='boldEleven' valign='top'   align='right'>"+itemDatas[u][7] +"</td>");
					out.println("<td  class='boldEleven' valign='top'   align='right'>"+itemDatas[u][4] +"</td>");
					
					out.println("<td  class='boldEleven' valign='top'   align='right'>"+itemDatas[u][8] +"</td>");
					out.println("<td  class='boldEleven' valign='top'   align='right'></td>");
					String link="";
					//link ="DirectPurchaseAddfromPurchaseRequest.jsp?Requestno="+Requestno+"&rowid="+itemDatas[u][6]+"&vendorid="+itemDatas[u][9];
					
					if("1".equals(data[0][19]))
						out.println("<td  class='boldEleven'><a href='"+link+"'>Inward</a></td>");
					else
						out.println("<td  class='boldEleven'><font class='bolddeepred'>Expired</font></td>");
					out.print("</tr>");
			}
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
                    <td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                    <td colspan="3" align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
                  </tr>
                </tbody>
             
              </table></td>
              <td nowrap="nowrap" width="4"><spacer height="1" width="1"
						type="block" /></td>
              <td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
            </tr>
            <tr>
              <td colspan="2" rowspan="2"><img height="7"
						src="../Image/Smart Inventory/BLCorner.gif" width="7" /></td>
              <td height="6"><spacer height="1" width="1" type="block" /></td>
              <td colspan="2" rowspan="2"><img height="7"
						src="../Image/Smart Inventory/BRCorner.gif" width="7" /></td>
            </tr>
            <tr>
              <td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
            </tr>
          </tbody>
        </table></td>
	</tr>
	<tr>
	  <td>&nbsp;</td>
    </tr>
	<tr>
	  <td>&nbsp;</td>
	</tr>
	 
	<tr>
	  <td height="15">&nbsp;</td>
	</tr>
	<tr>
	  <td>&nbsp;</td>
	</tr>
</table>


<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>
 <%@ include file="../footer.jsp"%></form>
</body>
</html>
