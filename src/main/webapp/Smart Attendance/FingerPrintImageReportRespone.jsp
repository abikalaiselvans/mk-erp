<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="com.my.org.erp.common.CommonInfo"%>
<%
try
{
%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<script language="javascript" src="../JavaScript/comfunction.js"></script>

<title> :: ATTENDANCE ::</title>




<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<%@ include file="index.jsp"%>
<%

 
	String company=request.getParameter("company");
	String Office=request.getParameter("Office");
	String dept=request.getParameter("dept");
	String sorting=request.getParameter("sorting");
	String ss=request.getParameter("ss");
	String sql ="";
	sql="SELECT f.CHR_COMPANYNAME,g.CHR_BRANCHNAME,d.CHR_OFFICENAME,b.CHR_DEPARTNAME,c.CHR_DESIGNAME,a.CHR_EMPID,a.CHR_STAFFNAME,a.CHR_STAFFFNAME,";
	sql = sql + " e.BLB_F FROM com_m_staff a,com_m_depart b,com_m_desig c, com_m_office  d,com_m_staffimage e, ";
 	sql = sql + " com_m_company f,com_m_branch g  WHERE a.CHR_EMPID=e.CHR_EMPID AND a.INT_DEPARTID=b.INT_DEPARTID ";
 	sql = sql + " AND a.INT_DESIGID=c.INT_DESIGID AND a.INT_OFFICEID=d.INT_OFFICEID  AND a.INT_COMPANYID =f.INT_COMPANYID ";
 	sql = sql + " AND a.INT_BRANCHID=g.INT_BRANCHID ";
 	
	if(!"0".equals(company))
		sql = sql + " AND a.INT_COMPANYID ="+company;
	if(!"0".equals(Office))
		sql = sql + " AND  a.INT_OFFICEID ="+Office;
	if(!"0".equals(dept))
		sql = sql + " AND  a.INT_DEPARTID ="+dept;	
		
	sql = sql + " ORDER BY a."+sorting;	
	sql = sql + ss;
	//out.println("<br><br><br><br>"+sql);
	
String data[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
out.println("<br><br><br>");
out.println("<table width=900  id='myTable' align=center    cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
out.println("<tr  class='MRow2' height='50'><td class='boldEleven' colspan='14' align=center> <center><h1>STAFF FINGERPRINT INFORMATIONS</h1></center> ");
if(data.length>0)
{
	out.println("<tr  class='MRow1'>");
	out.println("<td class='boldEleven'><b>S.No</td>");
	out.println("<td class='boldEleven'><b>Company</td>");
	out.println("<td class='boldEleven'><b>Branch</td>");
	out.println("<td class='boldEleven'><b>Office </td>");
	out.println("<td class='boldEleven'><b>Department</td>");
	out.println("<td class='boldEleven'><b>Designation</td>");
	out.println("<td class='boldEleven'><b>Emp Id </td>");
	out.println("<td class='boldEleven'><b>Name</td>");
	out.println("<td class='boldEleven'><b>FatherName</td>");
	out.println("<td class='boldEleven'><b>Photo</td>");
	out.println("<td class='boldEleven'><b>Finger Print&nbsp;&nbsp; <a href=\"javascript:CreateExcelSheet()\"'>Export</a>");
	out.println("</tr>");
	String defaul = "../StaffPhoto/default.jpg" ;
	String staffphoto="";
	String photo="";
	for(int u=0;u<data.length;u++)
	{
		staffphoto="";
		photo="";
		if(u%2==0)
			out.println("<tr class='MRow2'>");
		else	
			out.println("<tr class='MRow1'>");
		out.println("<td class='boldEleven'>"+(u+1)+"</td>");
		out.println("<td class='boldEleven'>"+data[u][0]+"</td>");
		out.println("<td class='boldEleven'>"+data[u][1]+"</td>");
		out.println("<td class='boldEleven'>"+data[u][2]+"</td>");
		out.println("<td class='boldEleven'>"+data[u][3]+"</td>");
		out.println("<td class='boldEleven'>"+data[u][4]+"</td>");
		out.println("<td class='boldEleven'>"+data[u][5]+"</td>");
		out.println("<td class='boldEleven'>"+data[u][6]+"</td>");
		
		out.println("<td class='boldEleven'>"+data[u][7].trim());
		staffphoto = com.my.org.erp.common.CommonFunctions.ServerPaths(request,response)+"/StaffPhoto/"+data[u][5].trim() +".jpg";
		File f = new File(staffphoto);
		if (f.exists())
			photo = "../StaffPhoto/"+data[u][5].trim() +".jpg";
		else
			photo =defaul;
		out.println("<td class='boldEleven'><img src="+photo+" width='100' height='130' border='1' name='Photo' id='Photo' />");
		
		
		out.println("<td class='boldEleven'>&nbsp;");
		
		staffphoto = com.my.org.erp.common.CommonFunctions.ServerPaths(request,response)+"/StaffPhoto/FP_Photo/"+data[u][5].trim() +".jpg";
		 f = new File(staffphoto);
		if (f.exists())
		{
			photo = "../StaffPhoto/FP_Photo/"+data[u][5].trim() +".jpg";
			out.println("<img src="+photo+" width='100' height='130' border='1' name='Photo' id='Photo' />");
		}	
		out.println("</tr>");
	}
	out.println("");
	
	
}
else
{
	out.println("<tr  class='MRow2'><td class='boldEleven' colspan='14'> DTATA NOT FOUND ...</td></tr>");
}
out.println("</table>");
%>
 
    
<table width="67" border="0" align="center" cellpadding="3"
								cellspacing="3">
								<tr>
									
									<td width="60"><div align="center">
									  <input class="buttonbold" type="button"
										name="Submit"  value="Close"   accesskey="c" 
										onClick="redirect('AttendanceMain.jsp')">
									  </div></td>
								</tr>
</table>	

<%
}
catch(Exception e)
{
}
%>