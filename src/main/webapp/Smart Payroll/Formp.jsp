<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>


<title> :: PAYROLL ::</title>


 

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<style type="text/css">
<!--
.style4 {font-weight: bold}
.style5 {COLOR: #000000; LINE-HEIGHT: 15px; FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; TEXT-DECORATION: none; font-size: 12px;}
.style6 {
	font-size: 10px;
	color: #000000;
	line-height: 15px;
	font-family: Verdana, Arial, Helvetica, Sans-Serif;
	text-decoration: none;
}
-->
</style>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>

<body  onpaste='return false;'>
<table width="95%" height="90" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="95%"><p align="center">
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
        <span class="boldElevenPrint">FORM P<br />
        Register of Advances Paid.Deductions for Damages or Losses and Fines<br />
        [See sub rule(4) of  rule 11]</br>
        </span></p>
    <p><br>
      <span class="boldElevenPrint">Name and Address of the Establishm M/s<br></span></p>
    <table width="117" border="1" align="right" cellpadding="0" cellspacing="0">
      <tr>
        <th width="62" class="boldEleven" scope="col">Month : </th>
        <th width="132" class="boldEleven" scope="col">&nbsp;</th>
      </tr>
      <tr>
        <th class="boldEleven" scope="row">Year : </th>
        <td class="boldEleven">&nbsp;</td>
      </tr>
    </table>
    <br>
    <b><br>
    <br>
    <br></td>
  </tr>
</table>
<table width="1177" border="1" cellspacing="0">
  <tr>
    <td rowspan="2" class="boldElevenPrint"><div align="center">Sl. No</div></td>
    <td rowspan="2" class="boldElevenPrint">Name of the person employed</td>
    <td rowspan="2" class="boldElevenPrint"><div align="center">Father/ Husbond's Name </div></td>
    <td rowspan="2" class="boldElevenPrint"><div align="center">Employee Number </div></td>
    <td rowspan="2" class="boldElevenPrint"><div align="center">Designation</div></td>
    <td colspan="4" class="boldElevenPrint"><div align="center">Advance Paid </div></td>
    <td colspan="5" class="boldElevenPrint"><div align="center">Deduction for Damages/Loses </div></td>
    <td colspan="6" class="boldElevenPrint"><div align="center">Fines</div></td>
  </tr>
  <tr>
    <td class="boldElevenPrint"><div align="center">Date of payment </div></td>
    <td class="boldElevenPrint"><div align="center">Amount paid </div></td>
    <td class="boldElevenPrint"><div align="center">Number of instalments recovered </div></td>
    <td class="boldElevenPrint"><div align="center">Date on which recovery completed </div></td>
    <td class="boldElevenPrint"><div align="center">Damage/ Loss caused </div></td>
    <td class="boldElevenPrint"><div align="center">Date of show cause Notice </div></td>
    <td class="boldElevenPrint"><div align="center">Total amount of deduction imposed </div></td>
    <td class="boldElevenPrint"><div align="center">Number of instalments to be recovered </div></td>
    <td class="boldElevenPrint"><div align="center">Date on which deduction completed </div></td>
    <td class="boldElevenPrint"><div align="center">Act or Omission </div></td>
    <td class="boldElevenPrint"><div align="center">Date of Show Cause Notice </div></td>
    <td class="boldElevenPrint"><div align="center">Amount of fine impossed </div></td>
    <td class="boldElevenPrint"><div align="center">Date of which fine recovery completed </div></td>
    <td class="boldElevenPrint"><div align="center">Signature or Thumb impression of the person employed </div></td>
    <td class="boldElevenPrint"><div align="center">Remarks</div></td>
  </tr>
  <tr>
    <td class="boldElevenPrint"><div align="center">1</div></td>
    <td class="boldElevenPrint"><div align="center">2</div></td>
    <td class="boldElevenPrint"><div align="center">3</div></td>
    <td class="boldElevenPrint"><div align="center">4</div></td>
    <td class="boldElevenPrint"><div align="center">5</div></td>
    <td class="boldElevenPrint"><div align="center">6</div></td>
    <td class="boldElevenPrint"><div align="center">7</div></td>
    <td class="boldElevenPrint"><div align="center">8</div></td>
    <td class="boldElevenPrint"><div align="center">9</div></td>
    <td class="boldElevenPrint"><div align="center">10</div></td>
    <td class="boldElevenPrint"><div align="center">11</div></td>
    <td class="boldElevenPrint"><div align="center">12</div></td>
    <td class="boldElevenPrint"><div align="center">13</div></td>
    <td class="boldElevenPrint"><div align="center">14</div></td>
    <td class="boldElevenPrint"><div align="center">15</div></td>
    <td class="boldElevenPrint"><div align="center">16</div></td>
    <td class="boldElevenPrint"><div align="center">17</div></td>
    <td class="boldElevenPrint"><div align="center">18</div></td>
    <td class="boldElevenPrint"><div align="center">19</div></td>
    <td class="boldElevenPrint"><div align="center">20</div></td>
  </tr>
  <tr>
    <td class="boldElevenPrint"><div align="center">&nbsp;</div></td>
    <td colspan="19" class="boldElevenPrint"><div align="center"> &nbsp;</div></td>
  </tr>
  <% sql="select a.CHR_EMPNAME,sum(a.DOU_WORKDAYS),sum(a.DOU_BASIC),sum(a.DOU_ESI)"+
	",b.CHR_GENDER,b.CHR_STAFFFNAME,a.CHR_EMPID from pay_t_salary a,com_m_staff b,com_m_dispensary c  where a.CHR_MONTH='"+mon+"' and a.INT_YEAR="+year+""+ 
	" and a.CHR_EMPID=b.CHR_EMPID and b.INT_PLACEID=c.INT_DESPID and b.CHR_ESI<>'N' and b.INT_COMPANYID="+company+" group by a.CHR_EMPID";

	String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	for(int i=0;i<data.length;i++){

	  
  	out.println("<tr>");
    out.println("<td class='boldEleven'><div align='left'>"+(i+1)+"</div></td>");
    out.println("<td class='boldEleven'><div align='left'>"+data[i][0]+"</div></td>");
    out.println("<td class='boldEleven'><div align='left'>&nbsp;"+data[i][5]+"</div></td>");
    out.println("<td class='boldEleven'><div align='left'>&nbsp;"+data[i][6]+"</div></td>");
    out.println("<td class='boldEleven'><div align='left'>&nbsp;</div></td>");
    out.println("<td class='boldEleven'><div align='left'>&nbsp;</div></td>");
    out.println("<td class='boldEleven'><div align='left'>&nbsp;</div></td>");
    out.println("<td class='boldEleven'><div align='left'>&nbsp;</div></td>");
    out.println("<td class='boldEleven'><div align='left'>&nbsp;</div></td>");
    out.println("<td class='boldEleven'><div align='left'>&nbsp;</div></td>");
    out.println("<td class='boldEleven'><div align='left'>&nbsp;</div></td>");
    out.println("<td class='boldEleven'><div align='left'>&nbsp;</div></td>");
    out.println("<td class='boldEleven'><div align='left'>&nbsp;</div></td>");
    out.println("<td class='boldEleven'><div align='left'>&nbsp;</div></td>");
    out.println("<td class='boldEleven'><div align='left'>&nbsp;</div></td>");
    out.println("<td class='boldEleven'><div align='left'>&nbsp;</div></td>");
    out.println("<td class='boldEleven'><div align='left'>&nbsp;</div></td>");
    out.println("<td class='boldEleven'><div align='left'>&nbsp;</div></td>");
    out.println("<td class='boldEleven'><div align='left'>&nbsp;</div></td>");
    out.println("<td class='boldEleven'><div align='left'>&nbsp;</div></td>");
  	out.println("</tr>");
  }
  %>
</table>
<p>&nbsp;</p>
</body>
</html>
