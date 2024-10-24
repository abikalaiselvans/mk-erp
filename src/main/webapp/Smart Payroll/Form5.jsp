<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<title> :: PAYROLL ::</title>


 
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<%
try
{
%>
<body  onpaste='return false;'>
<table width="800" border="0" align="center" >
  <tr>
    <td height="53"><table width="100%" border="0" align="left" cellpadding="0" cellspacing="0" class="boldEleven">
      <tr>
        <th colspan="2" scope="col">
          <div align="center"><span class="boldEleven"><strong>
<% 
	String comid=request.getParameter("company");
	String branchid=request.getParameter("branch");
	String officeid=request.getParameter("Office");
	String cpy  ="";
	String bid  ="";
	String off="";
	String yer="";
	String month=request.getParameter("Month");
  	String year=request.getParameter("Year");
	String sql="";
	
	sql = " SELECT a.CHR_COMPANYNAME,a.CHR_STREET,f.CHR_CITYNAME,a.INT_PINCODE,a.CHR_PFNUMBER, ";
	sql = sql + " c.CHR_COUNTRYNAME,d.CHR_STATENAME,e.CHR_DISTRICT,f.CHR_CITYNAME  ";
	sql = sql + " FROM com_m_company a, com_m_country c, com_m_state d, com_m_district e, com_m_city f ";
	sql = sql + " WHERE a.INT_COUNTRYID= c.INT_COUNTRYID ";
	sql = sql + " AND a.INT_STATEID = d.INT_STATEID ";
	sql = sql + " AND a.INT_DISTRICTID = e.INT_DISTRICTID ";
	sql = sql + " AND a.INT_CITYID = f.INT_CITYID ";
	sql = sql + " AND a.INT_COMPANYID="+comid;
	
	 if(!"0".equals(branchid))
		sql = sql + "  AND a.INT_BRANCHID="+branchid;
	 
	String datac[][]=CommonFunctions.QueryExecute(sql);
   %>
          FORM-5</strong></span></div></th>
      </tr>
      <tr>
        <th scope="col"> <div align="center"><span class="boldEleven">THE EMPLOYEES' PROVIDENT FUND AND THE EMPLOYEES' PENSION SCHEME,1995 </span></div>
		  <br /><b>Establishment Code : <%=datac[0][4]%></b></th>
        <th scope="col"><a href='<%="../SmartLoginAuth?filename=PF&actionS=PAYForm5&Month="+month+"&Year="+year+"&company="+comid+"&branch="+branchid+"&Office="+officeid%>' target="_blank"><img border="0" src="../images/icon_pdf.gif" width="47" height="49" /></a></th>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><table width="100%" border="0" align="left" cellpadding="0" cellspacing="0">
      <tr>
        <th width="580" scope="col"> <div align="left"><span class="boldEleven">Name &amp; address of the Factory /Establishment : <b><%=datac[0][0] %>, <%=datac[0][1] %>,<%=datac[0][2] %>-<%=datac[0][3] %></b> </span></div></th></tr>
    </table></td>
  </tr>
  <tr>
    <td><table width="100%" border="0" align="left" cellpadding="0" cellspacing="0">
      <tr>
        <th width="649" scope="col"> <span class="boldEleven">
        <div align="left" class="boldEleven"> Month : <b><%= com.my.org.erp.ServiceLogin.DateUtil.getMonth(Integer.parseInt(month)) %> - <%= year%></b><br />
            Return of Employees qualifiying for membership of the Provident Fund, Employees Pension Fund &amp; Employee Deposit Linked Insurance Fund for the First Time during the month ( To be sent to the Commissioner with Form 2(EPF &amp; EPS)) </div></span></th>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><table width='100%' border="0"     cellpadding=0 cellspacing=2 bgcolor='#9900CC'  class='boldEleven'  id='myTable' >
      <tr bgcolor="#FFFFFF">
        <th class="boldEleven" height="25" scope="col">Sl.No</th>
        <th class="boldEleven" scope="col">Account No </th>
        <th class="boldEleven" scope="col">Name of the Employee(in Block Capital ) </th>
        <th class="boldEleven" scope="col">Father's Name</th>
        <th class="boldEleven" scope="col">Nominee </th>
        <th class="boldEleven" scope="col">Date of Birth </th>
		<th class="boldEleven" scope="col">Date of Joinnig</th>
        <th class="boldEleven" scope="col">Sex</th>
        <th class="boldEleven" scope="col">Remarks</th>
      </tr>
      <tr bgcolor="#FFFFFF">
        <th width="38"  class="boldEleven" height="25" scope="col">1</th>
        <th width="54"  class="boldEleven" scope="col">2 </th>
        <th width="154" class="boldEleven" scope="col">3</th>
        <th width="100" class="boldEleven" scope="col">4</th>
        <th width="75"  class="boldEleven" scope="col">5</th>
        <th width="75"  class="boldEleven" scope="col">6</th>
		<th width="74"  class="boldEleven" scope="col">7</th>
        <th width="60"  class="boldEleven" scope="col">8</th>
        <th width="75" class="boldEleven" scope="col">9</th>
      </tr>
      <%

 	sql="select  a.CHR_PFNO,a.CHR_STAFFNAME,a.CHR_STAFFFNAME,DATE_FORMAT(a.DT_DOB,'%d-%b-%Y'),a.CHR_GENDER,a.DT_DOJCOLLEGE,a.CHR_EMPID,DATE_FORMAT(a.DAT_PFESIDATE,'%d-%b-%Y'), a.CHR_NOMINEE from com_m_staff a ";
  	sql=sql+ " where   a.CHR_ESI ='C' AND  a.CHR_PF='C'  AND  month(a.DAT_PFESIDATE)="+month+" ";  //a.CHR_EMPID = b.CHR_EMPID AND 
  	if(!"0".equals(branchid))
		sql=sql+ " AND a.INT_BRANCHID = "+branchid;
	if(!"0".equals(officeid))
		sql=sql+ "  AND a.INT_OFFICEID = "+officeid;
	 
	sql=sql+ " and year(a.DAT_PFESIDATE)="+year+" group by a.CHR_EMPID order by a.CHR_PFNO";
    //out.println(sql);
	 
  String data[][]= CommonFunctions.QueryExecute(sql);
  if(data.length>0)
  {
  	for(int i=0;i<data.length;i++)
  	{
 	 	out.println("<tr  bgcolor='#FFFFFF'>");
    	out.println("<th scope='row' height='25' class='boldEleven'>"+(i+1)+"</th>");
    	out.println("<td class='boldEleven'><font color='white'>`</font>"+datac[0][4]+data[i][0]+"</td>");
		out.println("<td class='boldEleven'>"+data[i][1]+"</td>");
    	out.println("<td class='boldEleven'>"+data[i][2]+"</td>");
    	out.println("<td class='boldEleven' align='left'>"+data[i][8]+"</td>");
		out.println("<td class='boldEleven' align='left'>"+data[i][3]+"</td>"); 
		out.println("<td class='boldEleven' align='left'>"+data[i][7]+"</td>");
    	out.println("<td class='boldEleven' align='left'>"+data[i][4]+"</td>");
	 	out.println("<td class='boldEleven'>&nbsp;</td>");
  		out.println("</tr>");
  	}
  }
  %>
    </table></td>
  </tr>
  <tr>
    <td><table width="100%" border="0" align="left" cellpadding="0" cellspacing="0">
      <tr>
        <th width="741" scope="col"><div align="left" class="boldEleven">
          <div align="justify">1. Previous A/c No. &amp; service particulars with Form-13(revised) 2) The Scheme Certificate Control No., if any, enclosuing the certificate. 3) Details of Pension being drawn, if any under EPS, 95 (Such member shold be enrolled for PF &amp; EDLI only) 4.Enclose form-2(Revised) giving nomination for PF &amp; also for Pension by all members. 5) An employee who has attained the age of 58 will be eligible to become a member of EPS.95 only </div>
        </div></th>
      </tr>
    </table></td>
  </tr>
</table>







<p>&nbsp;</p>
<p>&nbsp;</p>
<table border="0" align="center" cellpadding="0" cellspacing="3">
								<tr>
									 
									<td width="56"><input class="buttonbold14" type="button" name="Submit"  value="Close"   accesskey="c"  onClick="redirect('PF-FORM5.jsp')"></td>
								</tr>
</table>
							
<%
}
catch(Exception e)
{
}
%>
</body>
</html>
