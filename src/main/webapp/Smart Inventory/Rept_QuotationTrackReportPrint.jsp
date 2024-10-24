<%@ page import="java.io.*,java.util.*" errorPage="../error/index.jsp"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
%>
<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>



<script language="javascript" src="../JavaScript/comfunction.js"></script>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<title>:: INVENTORY ::</title><style type="text/css">

<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>
<body >
<%@ include file="indexinv.jsp"%> 
<%
String quotation = ""+request.getParameter("quotation");
String sql ="";

sql = " SELECT CHR_QUOTATIONNO ,DATE_FORMAT(DAT_CREATIONTIME,'%d-%b-%Y  %r'), ";
sql = sql +" FUN_GET_BRANCH_NAME(INT_BRANCHID), ";
sql = sql +" FIND_A_CUSTOMER_NAME(INT_CUSTOMERID), ";
sql = sql +" FUN_INV_DIVISION(INT_DIVIID),DOU_TOTALAMOUNT,CHR_CANCEL     ";
sql = sql +" FROM  inv_t_customerquotation WHERE CHR_QUOTATIONNO ='"+quotation+"'";
String data[][] =  CommonFunctions.QueryExecute(sql);
%>
<br><br><br><br>
<table width="80%" border="0" align="center" cellpadding="3" cellspacing="0"  class="TableDesign">
  <tr>
    <td class="boldEleven"><div align="center" class="whiteHead">CUSTOMER QUOTATION </div></td>
  </tr>
  <tr>
    <td>&nbsp;  </td>
  </tr>
  <tr>
    <td>
	<%
	if(data.length>0)
	{
	%>
	
	<table width="100%" border="0"  cellpadding=5 cellspacing=1 bgcolor='#9900CC' >
      <tr bgcolor="#FFFFFF">
        <td class="boldEleven"><strong>Branch</strong></td>
        <td class="boldEleven"><%=data[0][2]%></td>
        <td>&nbsp;</td>
        <td class="boldEleven"><strong>Division</strong></td>
        <td class="boldEleven"><%=data[0][4]%></td>
      </tr>
      <tr bgcolor="#FFFFFF">
        <td class="boldEleven"><strong>Customer</strong></td>
        <td class="boldEleven"><%=data[0][3]%></td>
        <td>&nbsp;</td>
        <td class="boldEleven"><strong>Net Value </strong></td>
        <td class="boldEleven"><%=data[0][5]%></td>
      </tr>
      <tr bgcolor="#FFFFFF">
        <td class="boldEleven"><strong>Quotation</strong></td>
        <td class="boldEleven"><a target="_blank" href=''><font class='boldgreen'><%=data[0][0]%></font></a></td>
        <td>&nbsp;</td>
        <td class="boldEleven"><strong>Create Time </strong></td>
        <td class="boldEleven"><%=data[0][1]%></td>
      </tr>
      <tr bgcolor="#FFFFFF">
        <td class="boldEleven"><strong>CPO Number </strong></td>
        <td class="boldEleven">
<%
sql ="SELECT CHR_SALESORDERNO, DATE_FORMAT(DAT_CREATIONTIME,'%d-%b-%Y  %r') , ";
sql = sql + "  DATE_FORMAT(DAT_VERIFIED_DATE_TIME,'%d-%b-%Y  %r'),CHR_PR_AVAILABLE,CHR_POREQUESTNO, ";
sql = sql + "  DATE_FORMAT(DAT_PR_CREATIONTIME,'%d-%b-%Y  %r'), ";
sql = sql + "  DATE_FORMAT(DAT_SALEORDER_APPROVAL_TIME,'%d-%b-%Y  %r'),  ";
sql = sql + "  FUN_INV_GET_NOOFINVOICE_AGAINST_SPO( CHR_SALESORDERNO), ";
sql = sql + "  FUN_INV_GET_NOOFINVOICE_AGAINST_CPO( CHR_SALESORDERNO), ";
sql = sql + "  IF(CHR_BILLED='Y','BILLED',IF(CHR_BILLED='P','PATIALL BILLED','PENDING')) ";
sql = sql + "FROM inv_t_customersalesorder WHERE CHR_QUOTATIONNO='"+data[0][0]+"' ";
//out.println(sql);
String cdata[][] =  CommonFunctions.QueryExecute(sql);
 
		%><a target="_blank" href=''><font class='boldgreen'><%=cdata[0][0]%></font></a>		</td>
        <td>&nbsp;</td>
        <td class="boldEleven"><strong>Execute Time </strong></td>
        <td class="boldEleven"><%=cdata[0][1]%></td>
      </tr>
      <tr bgcolor="#FFFFFF">
        <td class="boldEleven"><strong>CPO Verification </strong></td>
        <td class="boldEleven"></td>
        <td>&nbsp;</td>
        <td class="boldEleven"><strong>Verified Time </strong></td>
        <td class="boldEleven"><%=cdata[0][2]%></td>
      </tr>
	  <%
	  if("Y".equals(cdata[0][3]))
	  {
	  %>
      <tr bgcolor="#FFFFFF">
        <td class="boldEleven"><strong>Purchase Request </strong></td>
        <td class="boldEleven"><a target="_blank" href=''><font class='boldgreen'><%=cdata[0][4]%></font></a></td>
        <td>&nbsp;</td>
        <td class="boldEleven"><strong>P.Request Creation </strong></td>
        <td class="boldEleven"><%=cdata[0][2]%></td>
      </tr>
      <tr bgcolor="#FFFFFF">
        <td class="boldEleven">
		<%
		sql ="SELECT DATE_FORMAT(DAT_APPROVEDDATE,'%d-%b-%Y  %r') ,DATE_FORMAT(DAT_CLOSEDDATE,'%d-%b-%Y  %r')  FROM inv_t_purchaserequest WHERE CHR_POREQUESTNO='"+cdata[0][4]+"'";
		
		String pdata[][] =  CommonFunctions.QueryExecute(sql);
		%>
		</td>
        <td class="boldEleven">&nbsp;</td>
        <td>&nbsp;</td>
        <td class="boldEleven"><strong>P.Request Approval </strong></td>
        <td class="boldEleven"><%=pdata[0][0]%></td>
      </tr>
      <tr bgcolor="#FFFFFF">
        <td class="boldEleven">&nbsp;</td>
        <td class="boldEleven">&nbsp;</td>
        <td>&nbsp;</td>
        <td class="boldEleven"><strong>P.Request Closed </strong></td>
        <td class="boldEleven"><%=pdata[0][1]%></td>
      </tr>
       
	  <%
	  }
	  %>
      <tr bgcolor="#FFFFFF">
        <td class="boldEleven"><strong>Sale Order Approval </strong></td>
        <td class="boldEleven"><%=cdata[0][6]%></td>
        <td>&nbsp;</td>
        <td class="boldEleven">&nbsp;</td>
        <td class="boldEleven">&nbsp;</td>
      </tr>
      <tr bgcolor="#FFFFFF">
        <td class="boldEleven"><strong>CPO Billing </strong></td>
        <td class="boldEleven"><%=cdata[0][9]%></td>
        <td>&nbsp;</td>
        <td class="boldEleven">&nbsp;</td>
        <td class="boldEleven">&nbsp;</td>
      </tr>
      <tr bgcolor="#FFFFFF">
        <td class="boldEleven"><strong>No.of Invoice </strong></td>
        <td><%//=cdata[0][7]%><br>
		<%
			String invoicearray[] = cdata[0][8].split(",");
			if(invoicearray.length>0)
			{
				for(int u=0;u<invoicearray.length-1;u++)
				{
					out.println((u+1)+"). &nbsp;<a target='_blank' href='SwapSaleSerialView.jsp?salno="+invoicearray[u].trim()+"'><font class='boldgreen'>"+invoicearray[u].trim()+"</font></a> <br>");
				}
			}
			
			%>
        </td>
        <td>&nbsp;</td>
        <td class="boldEleven">&nbsp;</td>
        <td class="boldEleven">&nbsp;</td>
      </tr>
    </table>  </td>
  </tr>
  <tr>
    <td>&nbsp;  </td>
  </tr>
  <%
  }
  else
  {
  	out.println("<center><font class='bolddeepred'>'Data not found</font></center>");
  }
  %>
</table>
 </div>

 <p>
   <%@ include file="../footer.jsp"%>
 </p>
 <p>&nbsp;</p>
 <table width="56" border="0" align="center" cellpadding="0" cellspacing="0">
   <tr>
     <td><input type='button' class='ButtonHead' name='Button' value='Close' onClick="redirect( 'InventoryMains.jsp')" /></td>
   </tr>
 </table>
 <p>&nbsp;</p>
</body>
</html>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>