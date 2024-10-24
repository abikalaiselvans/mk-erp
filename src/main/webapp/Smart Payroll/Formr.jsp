<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<title> :: PAYROLL ::</title>


 
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<style type="text/css">
<!--
.style4 {font-weight: bold}
.style6 {color: #FFFFFF}
.style7 {color: #CCCCCC}
-->
</style>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>

<body  onpaste='return false;'>
<table width="995" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="1043"><p align="center" class="boldElevenPrint"><strong><b>FORM R<br />
      Register of Wages<br />
      [See sub-rule(5) of rule 11] </strong>
      <p class="bolddeepblue">
        <%    

	  String month=request.getParameter("Month");
	  String company=request.getParameter("company");
      int start=0,end=0;
      int year=Integer.parseInt(request.getParameter("Year"));
      String comname="",comst="",comcity="",compin="",from="",to="";
      String sql="";
      sql="select * from com_m_company where INT_COMPANYID="+company;
      String datacom[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
      if(datacom.length>0)
      {
      comname=datacom[0][1];
      comst=datacom[0][3];
      comcity=datacom[0][4];
      compin=datacom[0][6];
      }
      String mon="'October','November','December'",mon1="'January','February','March'";
      mon=com.my.org.erp.ServiceLogin.DateUtil.getMonth(Integer.parseInt(month));
 %>
        <span class="boldElevenPrint">Name of the Establishment M/s</span></p>
      <span class="bolddeepblue"><br>
      </span><span class="boldElevenPrint">Name of the Employer/Contractor with Address   :</span><span class="bolddeepblue"><br>
      <br>
      </span>
      <table width="995"  border="" cellspacing="0" bordercolor="#000000">
        <tr>
          <td width="22" rowspan="2" class="boldElevenPrint"><div align="center">Sl .No</div></td>
          <td width="41" rowspan="2" class="boldElevenPrint"><div align="center">ECode</div></td>
          <td width="123" rowspan="2" class="boldElevenPrint"><div align="center">Name of the person Employed </div></td>
          <td width="28" rowspan="2" class="boldElevenPrint">Sex</td>
          <td width="40" rowspan="2" class="boldElevenPrint"><div align="center">Desig nation/ Nature of work</div></td>
          <td width="41" rowspan="2" class="boldElevenPrint"><div align="center">Daily rated/ Piece rated/ Monthly rated</div></td>
          <td width="47" rowspan="2" class="boldElevenPrint"><div align="center">Wages period Weekly/ Fortnight / Month</div></td>
          <td width="53" rowspan="2" class="boldElevenPrint"><div align="center">Total Numbers of days worked during the wek/ Fortnight/ Month</div></td>
          <td width="53" rowspan="2" class="boldElevenPrint"><div align="center">Units of work done/ Number of days worked</div></td>
          <td width="57" rowspan="2" class="boldElevenPrint"><div align="center">Daily rate of wages/ Piece rate</div></td>
          <td width="60" rowspan="2" class="boldElevenPrint"><div align="center">Overtime Rate</div></td>
          <td colspan="5" class="boldElevenPrint"><div align="center">Wages Earned </div></td>
          <td colspan="2" class="boldElevenPrint"><div align="right">De</div></td>
        </tr>
        <tr>
          <td width="51" class="boldElevenPrint"><div align="center">Basic Wages</div></td>
          <td width="46" class="boldElevenPrint"><div align="center">Dear ness Allow ance</div></td>
          <td width="56" class="boldElevenPrint"><div align="center">Other Allowance/ Cash Payment nature to be specified</div></td>
          <td width="55" class="boldElevenPrint"><div align="center">Over time Earned</div></td>
          <td width="54" class="boldElevenPrint"><div align="center">Overtime Earned Leave wages including cash in lieu if kinds</div></td>
          <td width="52" class="boldElevenPrint"><div align="center">Gross wages</div></td>
          <td width="90" class="boldElevenPrint"><div align="center">PF</div></td>
        </tr>
        <tr>
          <td height="21" class="bolddeepblue"><div align="center">1</div></td>
          <td class="bolddeepblue"><div align="center">&nbsp;</div></td>
          <td class="bolddeepblue"><div align="center">2</div></td>
          <td class="bolddeepblue"><div align="center">3</div></td>
          <td class="bolddeepblue"><div align="center">4</div></td>
          <td class="bolddeepblue"><div align="center">5</div></td>
          <td class="bolddeepblue"><div align="center">6</div></td>
          <td class="bolddeepblue"><div align="center">7</div></td>
          <td class="bolddeepblue"><div align="center">8</div></td>
          <td class="bolddeepblue"><div align="center">9</div></td>
          <td class="bolddeepblue"><div align="center">10</div></td>
          <td class="bolddeepblue"><div align="center">11</div></td>
          <td class="bolddeepblue"><div align="center">12</div></td>
          <td class="bolddeepblue"><div align="center">13</div></td>
          <td class="bolddeepblue"><div align="center">14</div></td>
          <td class="bolddeepblue"><div align="center">15</div></td>
          <td class="bolddeepblue"><div align="center">16</div></td>
          <td class="bolddeepblue"><div align="center">17</div></td>
        </tr>
        <%
  
  sql="select a.CHR_EMPNAME,sum(a.DOU_WORKDAYS),sum(a.DOU_BASIC),sum(a.DOU_ESI)"+
	",b.CHR_GENDER,c.CHR_DESPNAME,a.CHR_EMPID from pay_t_salary a,com_m_staff b,com_m_dispensary c  where a.CHR_MONTH='"+mon+"' and a.INT_YEAR="+year+""+ 
" and a.CHR_EMPID=b.CHR_EMPID and b.INT_PLACEID=c.INT_DESPID and b.CHR_ESI<>'N' and b.INT_COMPANYID="+company+" group by a.CHR_EMPID";

String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
for(int i=0;i<data.length;i++){

  out.println("<tr>");
    out.println("<td height='23' class='bolddeepblue'><div align='center'>"+(i+1)+"</div></td>");
    out.println("<td class='bolddeepblue'>"+data[i][6]+"</td>");
    out.println("<td class='bolddeepblue'>"+data[i][0]+"</td>");
    out.println("<td class='bolddeepblue'>"+data[i][4]+"</td>");
    out.println("<td class='bolddeepblue'><div align='center'>&nbsp;</div></td>");
    out.println("<td class='bolddeepblue'><div align='center'>Mtly</div></td>");
    out.println("<td class='bolddeepblue'><div align='center'>Mtly</div></td>");
    out.println("<td class='bolddeepblue'><div align='right'>"+data[i][1]+"</div></td>");
    out.println("<td class='bolddeepblue'><div align='right'>0</div></td>");
    out.println("<td class='bolddeepblue'><div align='right'>0</div></td>");
    out.println("<td class='bolddeepblue'><div align='right'>&nbsp;</div></td>");
    out.println("<td class='bolddeepblue'>&nbsp;</td>");
    out.println("<td class='bolddeepblue'>&nbsp;</td>");
    out.println("<td class='bolddeepblue'>&nbsp;</td>");
    out.println("<td class='bolddeepblue'>&nbsp;</td>");
    out.println("<td class='bolddeepblue'>&nbsp;</td>");
    out.println("<td class='bolddeepblue'>&nbsp;</td>");
    out.println("<td class='bolddeepblue'>&nbsp;</td>");
  out.println("</tr>");}
  %>
      </table></td>
  </tr>
</table>
<p align="center" class="boldElevenPrint">

<p></p>
</body>
</html>
