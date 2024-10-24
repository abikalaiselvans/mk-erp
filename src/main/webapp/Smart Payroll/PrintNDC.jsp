<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<title> :: PAYROLL ::</title>




<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>

<body>

 <%
String rowid = request.getParameter("rowid");	
String sql ="    ";

sql = sql +" SELECT a.INT_NDCID,a.CHR_EMPID,b.CHR_STAFFNAME, ";
sql = sql +" c.CHR_OFFICENAME,d.CHR_DEPARTNAME,e.CHR_CATEGORYNAME,DATE_FORMAT(DAT_RESIGNDATE,'%d-%b-%Y'),  ";
sql = sql +" if(a.CHR_STORE='Y','Closed','Pending'), ";
sql = sql +" a.CHR_STORE_DESC,FIND_A_EMPLOYEE_ID_NAME(a.CHR_STORE_EMPID),DATE_FORMAT(a.DAT_STORE_DATE,'%d-%b-%Y'),  ";
sql = sql +" a.DOU_STORE,if(a.CHR_ACCOUNTS='Y','Closed','Pending'),a.CHR_ACCOUNTS_DESC,FIND_A_EMPLOYEE_ID_NAME(a.CHR_ACCOUNTS_EMPID), ";
sql = sql +" DATE_FORMAT(a.DAT_ACCOUNTS_DATE,'%d-%b-%Y'), a.DOU_ACCOUNTS, if(a.CHR_HR='Y','Closed','Pending'), ";
sql = sql +" a.CHR_HR_DESC,FIND_A_EMPLOYEE_ID_NAME(a.CHR_HR_EMPID),DATE_FORMAT(a.DAT_HR_DATE,'%d-%b-%Y'), ";
sql = sql +" DOU_HR, if(a.CHR_GENERAL='Y','Closed','Pending') ,a.CHR_GENERAL_DESC,FIND_A_EMPLOYEE_ID_NAME(a.CHR_GENERAL_EMPID), ";
sql = sql +" DATE_FORMAT(a.DAT_GENERAL_DATE,'%d-%b-%Y'), a.DOU_GENERAL, if(a.CHR_FINAL='Y','Closed','Pending') , ";
sql = sql +" a.CHR_FINAL_DESC,FIND_A_EMPLOYEE_ID_NAME(a.CHR_FINAL_EMPID),DATE_FORMAT(a.DAT_FINAL_DATE,'%d-%b-%Y'), ";
sql = sql +" a.DOU_FINAL, a.CHR_USRNAME,a.DT_UPDATEDATE,a.CHR_UPDATESTATUS  ";
sql = sql +" FROM pay_t_emp_ndc a , com_m_staff b, com_m_office c, com_m_depart d, com_m_employeecategory e ";
sql = sql +" WHERE a.CHR_EMPID =b.CHR_EMPID ";
sql = sql +" AND b.INT_OFFICEID =c.INT_OFFICEID AND a.CHR_FINAL='Y' ";
sql = sql +" AND b.INT_DEPARTID = d.INT_DEPARTID ";
sql = sql +" AND b.CHR_CATEGORY =e.INT_EMPLOYEECATEGORYID ";
sql = sql +" AND a.INT_NDCID = "+rowid;
String ndata[][] =CommonFunctions.QueryExecute(sql);
if(ndata.length>0)
{
%>
	
<table width="600" border="0" align="center" cellpadding="2" cellspacing="2">
  <tr>
    <td colspan="7">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="7"><div align="center" class="boldThirteen">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="29%"><img src="../images/logo.jpg" width="159" height="49"></td>
          <td width="71%" class="boldgre"><div align="center">Mythra IT SOLUTION PVT LTD
           
          </div></td>
        </tr>
      </table>
      </div></td>
  </tr>
  <tr>
    <td colspan="7">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="7" class="boldgre"><div align="center">CLEARANCE CERTIFICATE </div></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;   </td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="7"><table width="540" border="0" align="center" cellpadding="2" cellspacing="2">
      <tr>
        <td width="154" class="bold1">Name of the Employee </td>
        <td width="214" class="boldEleven"><%=ndata[0][2]%></td>
        <td width="108" class="bold1">Employee ID </td>
        <td width="38" class="boldEleven"><%=ndata[0][1]%></td>
      </tr>
      <tr>
        <td class="bold1">Department</td>
        <td class="boldEleven"><%=ndata[0][4]%></td>
        <td class="bold1">Location</td>
        <td class="boldEleven"><%=ndata[0][3]%></td>
      </tr>
      <tr>
        <td class="bold1">Category</td>
        <td class="boldEleven"><%=ndata[0][5]%></td>
        <td class="bold1">Resigned Date </td>
        <td class="boldEleven"><%=ndata[0][6]%></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="7"><table width="600" border="1" align="center" cellpadding="2" cellspacing="2">
      <tr>
        <td class="bold1">DEPARTMENT</td>
        <td class="bold1"><div align="center">Status</div></td>
        <td class="bold1"><div align="center">Description</div></td>
        <td class="bold1"><div align="center">Veified By </div></td>
        <td class="bold1"><div align="center">Verified Date </div></td>
        <td class="bold1"><div align="center">Fine Amount </div></td>
      </tr>
      <tr>
        <td class="bold1">STORE</td>
        <td class="boldEleven"><%=ndata[0][7]%></td>
        <td class="boldEleven"><%=ndata[0][8]%></td>
        <td class="boldEleven"><%=ndata[0][9]%></td>
        <td class="boldEleven"><%=ndata[0][10]%></td>
        <td class="boldEleven"><div align="right"><%=ndata[0][11]%></div></td>
      </tr>
      <tr>
        <td class="bold1">ACCOUNTS</td>
        <td class="boldEleven"><%=ndata[0][12]%></td>
        <td class="boldEleven"><%=ndata[0][13]%></td>
        <td class="boldEleven"><%=ndata[0][14]%></td>
        <td class="boldEleven"><%=ndata[0][15]%></td>
        <td class="boldEleven"><div align="right"><%=ndata[0][16]%></div></td>
      </tr>
      <tr>
        <td class="bold1">HR</td>
        <td class="boldEleven"><%=ndata[0][17]%></td>
        <td class="boldEleven"><%=ndata[0][18]%></td>
        <td class="boldEleven"><%=ndata[0][19]%></td>
        <td class="boldEleven"><%=ndata[0][20]%></td>
        <td class="boldEleven"><div align="right"><%=ndata[0][21]%></div></td>
      </tr>
      <tr>
        <td class="bold1">BUSINESS</td>
        <td class="boldEleven"><%=ndata[0][22]%></td>
        <td class="boldEleven"><%=ndata[0][23]%></td>
        <td class="boldEleven"><%=ndata[0][24]%></td>
        <td class="boldEleven"><%=ndata[0][25]%></td>
        <td class="boldEleven"><div align="right"><%=ndata[0][26]%></div></td>
      </tr>
      <tr>
        <td class="bold1">FINAL</td>
        <td class="boldEleven"><%=ndata[0][27]%></td>
        <td class="boldEleven"><%=ndata[0][28]%></td>
        <td class="boldEleven"><%=ndata[0][29]%></td>
        <td class="boldEleven"><%=ndata[0][30]%></td>
        <td class="boldEleven"><div align="right"><%=ndata[0][31]%></div></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
	<td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
   <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td><div align="center"><a href="Javascript:window.close()">Close</a></div></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
<%
}

%>
</body>
</html>
