<%@ page  language="java" import="java.sql.*"  %>
<%@ page  import="com.my.org.erp.common.CommonFunctions"  %>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<title> :: PAYROLL ::</title>


 
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<style type="text/css">
 
body {
	margin-top: .5in;
}
 </style>
 </head>
<%
try
{
%>
<body  onpaste="return false;" leftmargin="0">
<p align="right">&nbsp;</p>
<table width="600" height="290" border="0" align="center">
  <tr>
    <td height="40"><table width="100%" border="0" align="left" cellpadding="0" cellspacing="0">
      <tr>
        <th width="745" class="boldEleven" scope="col"><div align="center"><span class="style13">FORM-10</span><br />
          Return of the members leaving service during the month - 
          <%
			  	String sql="";
		   		String month=""+request.getParameter("Month");
  				String year=""+request.getParameter("Year");
  				String comid=""+request.getParameter("company");
				String branchid=""+request.getParameter("branch");
				String officeid=""+request.getParameter("Office");
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
		  <%= com.my.org.erp.ServiceLogin.DateUtil.getMonth(Integer.parseInt(month)) %>- <%= year%>
        </div>
        <div align="left"><br/>
          Name & address of the Factory /Establishment : <%=datac[0][0] %>,<%= datac[0][1] %>,<%= datac[0][2]%>-<%= datac[0][3] %></div></th>
        <th width="55" class="boldEleven" scope="col"><a href='<%="../SmartLoginAuth?filename=PF&actionS=PAYForm10&Month="+month+"&Year="+year+"&company="+comid+"&branch="+branchid+"&Office="+officeid%>' target="_blank"><img border="0" src="../images/icon_pdf.gif" width="47" height="49" /></a></th>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="82"><table width='800'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >
      <tr bgcolor='#ffffff'>
        <th width="37"  class="bold1" scope="col">Sl.No</th>
        <th width="53"  class="bold1" scope="col">Account No </th>
        <!--<th width="83" class="bold1" scope="col"><div align="center" >Empid</div></th>-->
        <th width="123" class="bold1" scope="col">Name Of the Employee(in block Capitals) </th>
        <th width="134" class="bold1" scope="col">Father's Name(or husband's name incase married woman) </th>
        <th width="90" class="bold1" scope="col">Date of leaving service </th>
		 
        <th width="108" class="bold1" scope="col">Reason for leaving service </th>
        <th width="89"  class="bold1" scope="col">Remarks</th>
      </tr>
      <tr bgcolor='#ffffff'>
        <th width="37"  class="boldEleven" scope="col" height='23'>1</th>
        <th width="53"  class="boldEleven" scope="col">2</th>
        <th width="123" class="boldEleven" scope="col">3</th>
        <th width="134" class="boldEleven" scope="col">4</th>
        <th width="90" class="boldEleven" scope="col">5</th>
		 
        <th width="108" class="boldEleven" scope="col">6</th>
        <th width="89"  class="boldEleven" scope="col">7</th>
      </tr>
      <%
 
    String cpy  ="";
	String bid  ="";
	String off="";
	String yer="";
	 
   sql="select a.CHR_EMPID,b.CHR_STAFFNAME,DATE_FORMAT(b.DAT_RESIGNDATE,'%d-%m-%Y'),a.CHR_TER_TYPE,b.CHR_STAFFFNAME,b.CHR_PFNO,DATE_FORMAT(b.DAT_RESIGNDATE,'%d-%m-%Y') from pay_m_emp_termination a,com_m_staff b";
  sql=sql+ " where  b.CHR_ESI ='C' AND  b.CHR_PF='C'  AND  a.CHR_EMPID=b.CHR_EMPID";
  
 	
	if(!"0".equals(branchid))
		sql=sql+ " AND b.INT_BRANCHID = "+branchid;
	
	if(!"0".equals(officeid))
		sql=sql+ " AND b.INT_OFFICEID = "+officeid;
		
	 
	sql=sql+" and month(b.DAT_RESIGNDATE)="+month+" and year(b.DAT_RESIGNDATE)="+year+" order by a.CHR_EMPID";
 	 
	
 	 
   String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
   
  for(int i=0;i<data.length;i++)
  {
  	out.println("<tr bgcolor='#ffffff'>");
    out.println("<th scope='row' class='boldEleven' height='23'>"+(i+1)+"</th>");
    out.println("<td class='boldEleven'>&nbsp;"+data[i][5]+"</td>");
	out.println("<td class='boldEleven'>"+data[i][1]+"</td>");
    out.println("<td class='boldEleven'>"+data[i][4]+"</td>");
    out.println("<td class='boldEleven' align='center'>"+data[i][2]+"</td>");
	out.println("<td class='boldEleven' align='left'>RESIGNED</td>");//data[i][3]
    out.println("<td class='boldEleven'>&nbsp;</td>");
  	out.println("</tr>");
} 
  %>
    </table></td>
  </tr>
  <tr>
    <td height="79"> <table width="100%" border="0" align="left" cellpadding="0" cellspacing="0" >
      <tr>
        <th width="775" scope="col" ><div align="left" ><span class="boldEleven">* Please state whether the member is (a) retiring according to para 69 (1) or (b) of the Sheme: (b) leaving India for permenant settlement abroad : &copy; reterenchment: (d) discharge: (e) resigning from or leaving service: (f) taking up employment elsewhere (The Name &amp; address of the Employers shold be stated): (g) Date of Death A member, on attaining the age of 58, is ceased to be a member of EPS-95 Subject to eligibility he may apply for drawal of pension</span></div></th>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="79"><table width="100%" border="0" align="left" cellpadding="0" cellspacing="0">
      <tr>
        <th width="420" height="31" class="boldEleven" scope="col"><div align="left">Date:  <b> </b></div></th>
        <th width="314" scope="col" class="boldEleven" valign="top"><div align="left">Signature of the employer </div></th>
      </tr>
      <tr>
        <th height="41" scope="row">&nbsp;</th>
        <td class="boldEleven" valign="bottom">Stamp of the Factroy/Establishment</td>
      </tr>
    </table></td>
  </tr>
</table>
<p>&nbsp;</p>
<p>&nbsp;</p>



<p>&nbsp;</p>
<p>&nbsp;</p>
<table border="0" align="center" cellpadding="0" cellspacing="3">
								<tr>
									 
									<td width="56"><input class="buttonbold14" type="Button"
										name="Submit"  value="Close"   accesskey="c" 
										onClick="redirect('PF-FORM10.jsp')"></td>
								</tr>
</table>
				
</body>
<%
}
catch(Exception e)
{
}
%>
 