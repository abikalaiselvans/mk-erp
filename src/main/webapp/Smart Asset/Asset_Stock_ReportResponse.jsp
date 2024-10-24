<%@ page import="java.io.*,java.util.*"%>
<%-- <%@ page import="sun.net.smtp.SmtpClient"%> --%>
<%@ page import="com.my.org.erp.common.*"%>
<%@ page import="com.my.org.erp.common.*"%> <html>
<head>
 
<title>:: ASSET ::</title>


<html>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../JavaScript/InventoryStyles.css" rel="stylesheet"
	type="text/css">
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js" type="text/javascript"></script>
<body>
<%@ include file="index.jsp"%>

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
		
		<%
		String Branchid = ""+request.getParameter("Branch");
		String division = ""+request.getParameter("division");
		String itype = ""+request.getParameter("itype");
		String item = ""+request.getParameter("item");
		String sql = "";
		sql =  " SELECT e.CHR_COMPANYNAME,d.CHR_BRANCHNAME,f.CHR_DIVICODE,c.CHR_GROUPNAME, ";
		sql = sql + " b.CHR_ITEMNAME,a.CHR_RETURNABLE,COUNT(*)  ";
		sql = sql + " FROM asset_t_assetserilano a,asset_m_item b ,asset_m_itemgroup c,com_m_branch d, ";
		sql = sql + " com_m_company e,inv_m_division f ";
		sql = sql + " WHERE  a.CHR_ITEMID=b.CHR_ITEMID ";
		sql = sql + " AND b.INT_ITEMGROUPID=c.INT_ITEMGROUPID  ";
		sql = sql + " AND a.INT_BRANCHID=d.INT_BRANCHID  ";
		sql = sql + " AND d.INT_COMPANYID=e.INT_COMPANYID ";
		sql = sql + " AND a.INT_DIVIID=f.INT_DIVIID ";
		sql = sql + " AND a.CHR_FLAG='N'   ";
		sql = sql + " AND a.CHR_STATUS ='Y'   ";
		sql = sql + " GROUP BY a.CHR_ITEMID,a.INT_BRANCHID ";
		if(!"0".equals(Branchid))
			sql= sql+" AND a.INT_BRANCHID="+ Branchid;
		if(!"0".equals(division))
			sql= sql+" AND a.INT_DIVIID="+ division;
		if(!"0".equals(item))
			sql= sql+" AND a.CHR_ITEMID="+ item;
		sql= sql+"  ORDER BY a.CHR_RETURNABLE, b.CHR_ITEMNAME desc";
		 
		
		String data[][] =  CommonFunctions.QueryExecute(sql);
		if(data.length>0)
		{ 
			out.println("<center><table width=900  id='myTable' align=center    cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
			out.println("<tr class='MRow1'><td colspan=8 class='boldEleven'><center><h3>CARBOUYS STOCK</h3></center>");
			out.println("<tr class='MRow2'><td class='boldEleven'><b>S.No");
			out.println("<td class='boldEleven'><b>Company");
			out.println("<td class='boldEleven'><b>Branch");
			out.println("<td class='boldEleven'><b>Division");
			out.println("<td class='boldEleven'><b> Item Group");
			out.println("<td class='boldEleven'><b>Item");
			out.println("<td class='boldEleven'><b>Returnable");
			out.println("<td class='boldEleven'><b>Stock");
			for(int u=0;u<data.length;u++)
			{
				if(u%2==0)
					out.println("<tr class='MRow1'>");	
				else
					out.println("<tr class='MRow2'>");		
					
				out.println("<td class='boldEleven'>"+(u+1));
				out.println("<td class='boldEleven'>"+data[u][0]);
				out.println("<td class='boldEleven'>"+data[u][1]);
				out.println("<td class='boldEleven'>"+data[u][2]);
				out.println("<td class='boldEleven'>"+data[u][3]);
				out.println("<td class='boldEleven'>"+data[u][4]);
				out.println("<td class='boldEleven'>");
				if("Y".equals(data[u][5])) 
					out.println("<font color='blue'>Returnable</font>");
				else
					out.println("<font color='red'>Non-Returnable</font>");	
				out.println("<td class='boldEleven'>"+data[u][6]);
			}
			out.println("</table></center>");
		}
		else
		{
			out.println("<center><font color='red'>Data not found...</font></center>");
		}	
		
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
			onClick="windowSave('Sales.txt')"><img
			src="../Image/report/text.gif" width="15" height="14" border="0"></a></a></div></td>
            <td class="boldEleven"><div align="center"><a title="Document" href=javascript:;
			onClick="windowSave('Sales.doc')"><img
			src="../Image/report/MS.GIF" width="15" height="14" border="0"></a></div></td>
            <td class="boldEleven"><div align="center"><a title="HTML" href=javascript:;
			onClick="windowSave('Sales.html')"><img
			src="../Image/report/IE.GIF" width="15" height="14" border="0"></a></div></td>
            <td class="boldEleven"><div align="center"><a
			href="javascript:redirect('AssetRept.jsp')">Close</a></div></td>
          </tr>
        </table></td>
  </tr>
  <tr>
	  <td>&nbsp;</td>
  </tr>
  <tr>
	  <td>&nbsp;</td>
  </tr>
</table>
<%@ include file="../footer.jsp"%>
</body>
</html>
