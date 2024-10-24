<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*,com.my.org.erp.common.*" errorPage="../error/index.jsp"%>
<%@ page import="com.my.org.erp.SmartInventory.Model"%>
<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<jsp:useBean id="conBean" class="DBConnection.DBCon" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<!-- TemplateBeginEditable name="doctitle" -->
<title><%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='INV' ")[0][0]%></title>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
 </head>
<script src="../JavaScript/AJAXFunction.js"></script>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>

<script language="javascript">

function  Print(links)
{
			
	var width="800", height="400";
	var left = (screen.width/2) - width/2;
	var top = (screen.height/2) - height/2;
	var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=no,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
	newWindow = window.open(links,"subWind",styleStr);
	newWindow.focus( );
}

function validate()
{
	if(checkNull('ename','Select Employee Name'))
		return true;
	else
		return false;
}
</script>
<body  onpaste='return false;'>


<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="ListConveyanceresponse.jsp"
	onSubmit="return validate()">
<table width="900" height="150" border="0" align="center"
	cellpadding="2" cellspacing="2">
	<%!
		Connection con ;
	%>
	<%
try
{
	
	 
 %>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
	<%
	
	String companyid=request.getParameter("company");
		String branch=request.getParameter("branch");
		String officeid=request.getParameter("Office");
		String paiddate=request.getParameter("paiddate");
		String link="ReptConveyanceprint.jsp?company="+companyid+"&branch="+branch+"&Office="+officeid+"&paiddate="+paiddate;
		paiddate = paiddate.split("-")[2]+"-"+paiddate.split("-")[1]+"-"+paiddate.split("-")[0];
		String cname[][] =CommonFunctions.QueryExecute("SELECT CHR_COMPANYNAME FROM com_m_company WHERE INT_COMPANYID="+companyid);
		String branchname = "";
		if("0".equals(branch))
		{
			branchname = "";
		}
		else
		{
			String bname[][] =CommonFunctions.QueryExecute("SELECT CHR_BRANCHNAME FROM com_m_branch WHERE INT_BRANCHID="+branch);
			branchname = " @ " +bname[0][0];
		}
		String sql="";
		String off="";
		String cpy="";
		String bid ="";
		
		sql=" SELECT a.CHR_EMPID,b.CHR_STAFFNAME,sum(a.DOU_TRAVEL),sum(a.DOU_TRAIN),sum(a.DOU_AUTO),sum(a.DOU_LUNCH),sum(a.DOU_TELEPHONE),";
		sql=sql + "  sum(a.DOU_OTHERAMT),";
		sql=sql + "(sum(a.DOU_TRAVEL)+sum(a.DOU_TRAIN)+sum(a.DOU_AUTO)+sum(a.DOU_LUNCH)+sum(a.DOU_TELEPHONE)+sum(a.DOU_OTHERAMT))"; 
		sql = sql + " ,sum(a.DOU_TOTAL),DATE_FORMAT(MIN(DAT_CONDATE),'%e-%M-%Y'), DATE_FORMAT(MAX(DAT_CONDATE),'%e-%M-%Y')  ,FIND_A_BANKGROUP_NAME(b.CHR_BANK),b.CHR_ACCNO, d.CHR_OFFICENAME,e.CHR_DEPARTNAME,f.CHR_CATEGORYNAME ,b.CHR_IFSC  FROM conveyance_t_conveyance a, com_m_staff b,  com_m_office  d ,com_m_depart e, com_m_employeecategory  f ";
		sql = sql + " WHERE a.CHR_EMPID=b.CHR_EMPID	  ";
		sql = sql + " AND a.CHR_STATUS='Y' AND a.CHR_ACCSTATUS='Y'  AND b.INT_OFFICEID =d.INT_OFFICEID AND b.INT_DEPARTID= e.INT_DEPARTID  AND b.CHR_CATEGORY=f.INT_EMPLOYEECATEGORYID ";
		sql = sql + " AND a.DAT_ACCDATE='"+paiddate+"' ";
		sql = sql + " AND b.INT_COMPANYID= "+companyid;		
		if(!"0".equals(officeid))
			sql = sql + " AND b.INT_OFFICEID = " +officeid;
		
		if(!"0".equals(branch))
			sql = sql + " AND b.INT_BRANCHID = " +branch;
			
		sql = sql + " GROUP BY a.CHR_EMPID	 ORDER BY  b.CHR_STAFFNAME";
		
		String cdata[][]= CommonFunctions.QueryExecute(sql);
		String companyname = cname[0][0];
		
		double sum=0;
		double sum1=0;
		double sum2=0;
		double sum3=0;
		double sum4=0;
		double sum5=0;
		double sum6=0;
		if(cdata.length>0)
		{
			out.println("<table  id='myTable' width='100%' border='0' bgcolor='#000000' class='boldEleven' cellpadding=3 cellspacing=1>");
			out.println("<TR bgColor=#ffffff>");
			out.println("<Td colspan=18 class='boldEleven'><center><b>" +companyname.toUpperCase() +" "+branchname); 
			out.println("</TR>");
			out.println("<TR bgColor=#ffffff>");
			out.println("<Th bgColor=#ffffff class='boldEleven'><b>Sl.No</Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'><b>Name</Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'><b>Office</Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'><b>Department</Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'><b>Category</Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'><b>Bank</Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'><b>IFSC</Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'><b>A/C No</Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'><b>From Date</Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'><b>To Date</Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'><b>Vehicle Amount</Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'><b>Train/Bus are</Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'><b>Auto Fare</Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'><b>Lunch / Dinner</Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'><b>Telephone Charges</Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'><b>Others Amt</Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'><b>Total </Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'><b>Signature </Th>");
			out.println(" </TR>");
			
			for(int u=0;u<cdata.length;u++)
			{

				out.println("<Th bgColor=#ffffff class='boldEleven'>"+(u+1)+"</Th>");
				out.println("<Th bgColor=#ffffff class='boldEleven' align='left'>" +cdata[u][1] +" /" +cdata[u][0] );//
				
				out.println("<Th bgColor=#ffffff class='boldEleven'>"+cdata[u][14]+"</Th>");
				out.println("<Th bgColor=#ffffff class='boldEleven'>"+cdata[u][15]+"</Th>");
				out.println("<Th bgColor=#ffffff class='boldEleven'>"+cdata[u][16]+"</Th>");
				
				out.println("<Th bgColor=#ffffff class='boldEleven'>"+cdata[u][12]+"</Th>");
				out.println("<Th bgColor=#ffffff class='boldEleven'>"+cdata[u][17]+"</Th>");
				out.println("<Th bgColor=#ffffff class='boldEleven'>A/c No : "+cdata[u][13]+"</Th>");
				
				out.println("<Th bgColor=#ffffff class='boldEleven'>"+cdata[u][10]+"</Th>");
				out.println("<Th bgColor=#ffffff class='boldEleven'>"+cdata[u][11]+"</Th>");
				
				out.println("<Th bgColor=#ffffff class='boldEleven'>"+cdata[u][2]+"</Th>");
				out.println("<Th bgColor=#ffffff class='boldEleven'>"+cdata[u][3]+"</Th>");
				out.println("<Th bgColor=#ffffff class='boldEleven'>"+cdata[u][4]+"</Th>");
				out.println("<Th bgColor=#ffffff class='boldEleven'>"+cdata[u][5]+"</Th>");
				out.println("<Th bgColor=#ffffff class='boldEleven'>"+cdata[u][6]+"</Th>");
				out.println("<Th bgColor=#ffffff class='boldEleven'>"+cdata[u][7]+"</Th>");
				out.println("<Th bgColor=#ffffff class='boldEleven'>"+cdata[u][8]+"</Th>");
				out.println("<Th bgColor=#ffffff class='boldEleven'>&nbsp;</Th>");
				out.println("</TR>");
				
				sum1= sum1+Double.parseDouble(cdata[u][2]);
				sum2= sum2+Double.parseDouble(cdata[u][3]);
				sum3= sum3+Double.parseDouble(cdata[u][4]);
				sum4= sum4+Double.parseDouble(cdata[u][5]);
				sum5= sum5+Double.parseDouble(cdata[u][6]);
				sum6= sum6+Double.parseDouble(cdata[u][7]);
				 
				sum= sum+Double.parseDouble(cdata[u][9]);
	
			}
			
			out.println("<TR>");
			out.println("<Th bgColor=#ffffff class='boldEleven'>&nbsp; </Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'>&nbsp; </Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'>&nbsp; </Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'>&nbsp; </Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'>&nbsp; </Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'>&nbsp; </Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'>&nbsp; </Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'>&nbsp; </Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'>&nbsp; </Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'>&nbsp; </Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'>&nbsp; </Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'>&nbsp; </Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'>&nbsp; </Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'> &nbsp;</Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'> &nbsp;</Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'>&nbsp; </Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'>&nbsp;</Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'>&nbsp;</Th>");
			out.println("</TR>");
			
			out.println("<TR>");
			out.println("<Th bgColor=#ffffff class='boldEleven'>&nbsp; </Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'>&nbsp; </Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'>&nbsp; </Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'>&nbsp; </Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'>&nbsp; </Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'>&nbsp;</Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'>&nbsp;</Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'>&nbsp; </Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'>&nbsp; </Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'>TOTAL ::  </Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'>"+sum1+" </Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'>"+sum2+" </Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'>"+sum3+" </Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'>"+sum4+" </Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'>"+sum5+" </Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'>"+sum6+" </Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'>"+sum+"</Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'>&nbsp;</Th>");
			out.println(" </TR>"); 
			
			out.println("<TR>");
			out.println("<Th bgColor=#ffffff class='boldEleven'> </Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'>&nbsp; </Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'>&nbsp; </Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'>&nbsp; </Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'>&nbsp; </Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'>&nbsp; </Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'> </Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'> </Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'>&nbsp; </Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'>&nbsp; </Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'> </Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'> </Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'> </Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'> </Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'> </Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'> </Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'>&nbsp;</Th>");
			out.println("<Th bgColor=#ffffff class='boldEleven'><a href=\"javascript:window.print()\">Print</a> </Th>");
			out.println(" </TR>"); 
			out.println("</table>");
		}
		else
		{
			out.println("<center><font class='boldred'>data not found...</font></center>");
		}
		
	%>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<%
}
catch(Exception e)
{
	 
}
%>
</form>
</body>
</html>
