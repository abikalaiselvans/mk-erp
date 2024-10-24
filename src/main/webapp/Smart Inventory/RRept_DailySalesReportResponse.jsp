 <%@ page import="java.io.*,java.util.*"%>
<%
try
{
%>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<body >
<%@ include file="indexinv.jsp"%>

<%
		java.text.NumberFormat formatter = java.text.NumberFormat.getInstance();
		formatter.setMaximumFractionDigits(2);
   		formatter.setMinimumFractionDigits(2); 
		String branchid = session.getAttribute("BRANCHID").toString();
				
		out.print("<br><br><br>");
		String dt = ""+request.getParameter("dt");
		String dt2 = request.getParameter("dt2");
		String sql = ""+request.getParameter("sql");
		String division = ""+request.getParameter("division");
		String ref = ""+request.getParameter("ref");
		 
		String custid=request.getParameter("customer");
		String type=request.getParameter("type");
		String Branch=request.getParameter("Branch");
		 
			
		String refid="";
		String div ="";
		String cust ="";
		
		out.println("<table width=90%  id='myTable' align=center    cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
		out.println("<tr bgcolor='#ffffff'>");
		out.println("<td colspan=11 class='boldEleven' align=center><b>SALES ON  :: ("+dt +" to " +dt2+" )</b></td>");
		 
		out.println("<tr  bgcolor='#ffffff'><td class='boldEleven'><b>S. No </td>");
		out.println("<td class='boldEleven'  ><b>Invoice No</td>");
		out.println("<td class='boldEleven'><b>Company </td>");
		out.println("<td class='boldEleven'><b>Branch </td>");
		out.println("<td class='boldEleven'><b>Division </td>");
		out.println("<td class='boldEleven'><b>Customer </td>");
		out.println("<td class='boldEleven'><b>Marketing Executives </td>");
		out.println("<td class='boldEleven'><b>Payment</td>");
		out.println("<td class='boldEleven' ><b>Sales date</td>");
		out.println("<td class='boldEleven' ><b>Amount </td>");
		out.println("<td class='boldEleven' ><b>Amount with Tax</td>");
		out.println("</tr>");
		
		
		
		//DIRECT BILLING
		
		 		
		sql = " SELECT a.CHR_SALESNO,a.DOU_TOTALAMOUNT,DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y'),FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),a.INT_PAYMENTTERMID,a.CHR_PAYMENTSTATUS,";
		sql = sql + " c.CHR_STAFFNAME,a.DOU_AMOUNT,e.CHR_COMPANYNAME,d.CHR_BRANCHNAME,f.CHR_DIVICODE FROM inv_t_directsales  a ,inv_m_customerinfo b ,com_m_staff c  ,com_m_branch d ,com_m_company e, inv_m_division f";
		sql = sql + "  WHERE a.INT_BRANCHID = d.INT_BRANCHID AND d.INT_COMPANYID=e.INT_COMPANYID AND a.INT_DIVIID=f.INT_DIVIID AND a.DAT_SALESDATE >= '"+dt+"' ";
		sql = sql + " AND a.DAT_SALESDATE<='"+dt2+"' ";
		if(!"0".equals(division))
			sql = sql + " AND a.INT_DIVIID="+division ;
		if(!"0".equals(custid))
			sql = sql + "  AND a.INT_CUSTOMERID="+custid ;
		if(!"0".equals(ref))
			sql = sql + "  AND a.CHR_REF ='"+ref+"' ";
		if(!"0".equals(Branch))
			sql = sql + "  AND a.INT_BRANCHID="+Branch ;
		
		sql = sql + "  AND a.INT_SALESSTATUS=1 AND a.INT_CUSTOMERID = b.INT_CUSTOMERID  ";
		sql = sql + " AND c.CHR_EMPID =a.CHR_REF  ORDER BY a.CHR_SALESNO";
		
		out.println(sql);
		 
		
		
		
		
		
		
		
		
		
		out.println("</table>");
		 
		 
%>




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
			href="javascript:redirect( 'InventoryMains.jsp')">Close</a></div>
		</td>
	</tr>
</table>


<%@ include file="../footer.jsp"%>
</body>
 
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>


