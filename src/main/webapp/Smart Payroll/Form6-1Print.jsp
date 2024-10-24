<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*,com.my.org.erp.common.*,com.my.org.erp.Math.*"%>
<%
try
{
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<title> :: PAYROLL ::</title>


 
 
 <script language="javascript" src="../JavaScript/comfunction.js"></script>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<style type="text/css">
<!--
body {
	margin-top: 25px;
}
-->
</style></head>
<body  onpaste="return false;" leftmargin="0">
<table width="100%" height="724" border="0" align="left" cellpadding="0" cellspacing="0">
  <tr>
    <td height="18" colspan="6" class="bolddeepblue"><div align="center">
      <%
          
          String type=request.getParameter("type");
          String company=request.getParameter("company");
          int start=0,end=0;
          int year=Integer.parseInt(request.getParameter("Year"));
          String comname="",comst="",comcity="",compin="",from="",to="";
          String sql="";
          sql="select CHR_COMPANYNAME,CHR_STREET,CHR_STREET,INT_PINCODE from com_m_company where INT_COMPANYID="+company;
          String datacom[][]= CommonFunctions.QueryExecute(sql);
		  
          if(datacom.length>0)
          {
			  comname=datacom[0][0];
			  comst=datacom[0][1];
			  comcity=datacom[0][2];
			  compin=datacom[0][3];
          }
          String mon="";
		  
          if(type.equals("O"))
          {
        	  mon="October,November,December,January,February,March";
              from="OCT,"+(year-1);
        	  to="MAR,"+year;
        	  start=year-1;
        	  end=year;
          }
          else
          {
        	  mon="April,May,June,July,August,September";
        	  from="APRIL,"+year;
        	  to="SEP,"+year;
        	  start=year;
        	  end=year;
          }
		  
          String month[]=mon.split(",");
          String basic="0",cpf="0",spf="0";
          int tbasic=0,tcpf=0,tspf=0,ttotal=0;

          for(int i=0;i<6;i++)
          {
			  	basic="0";cpf="0";spf="0";
        		if(i<3)
        	  		sql="select  ROUND(sum(DOU_BASIC)),ROUND(sum(DOU_ESI)),ROUND(sum(DOU_CPYESI)) from pay_t_salary where CHR_MONTH='"+month[i]+"' and INT_YEAR="+start;
        		else
        			sql="select  ROUND(sum(DOU_BASIC)),ROUND(sum(DOU_ESI)),ROUND(sum(DOU_CPYESI)) from pay_t_salary where CHR_MONTH='"+month[i]+"' and INT_YEAR="+end;
        		 
        		String data[][]= CommonFunctions.QueryExecute(sql);
        		 
				if(data.length>0)
				{
					basic="0";cpf="0";spf="0";
					if(!data[0][0].equals("-"))
						basic=data[0][0];
						//basic=data[0][0].substring(0,data[0][0].length()-3);
					if(!data[0][2].equals("-"))
						cpf=data[0][2];
						//cpf=data[0][2].substring(0,data[0][2].length()-3);
					if(!data[0][1].equals("-"))
						spf=data[0][1];
						//spf=data[0][1].substring(0,data[0][1].length()-3);
				}
        		else
				{
					basic="0";cpf="0";spf="0";
				}
        	tcpf=tcpf+Integer.parseInt(cpf);
        	tspf=tspf+Integer.parseInt(spf);
        	ttotal=ttotal+(Integer.parseInt(cpf)+Integer.parseInt(spf));
        	
			 
          }
          %>
      <span class="boldElevenPrint">Form -6-1<br />
        Return Of Contrubutions <br/>
        In Quadruplicate <br />
        Employees State Insurance Corporation <br />
        Regulation - 26 </span></div></td>
  </tr>
  <tr>
    <td height="21" colspan="3" class="boldElevenPrint">Employers Code : </td>
    <td colspan="3" class="boldElevenPrint">Name of the Local Office : </td>
  </tr>
  <tr>
    <td height="38" colspan="6" class="bolddeepblue"><div align="center" class="boldElevenPrint">EMPLOYEES' STATE INSURANCE CORPORATION <br />
      (Return of Contribution)</div></td>
  </tr>
  <tr>
    <td height="17" colspan="6" class="boldEleven"><div align="center" class="boldElevenPrint">(See Regulation 26 of the Employees' State Insurance (General) Regulations, 1950) </div></td>
  </tr>
  <tr>
    <td height="61" colspan="3" class="boldElevenPrint" valign="top">Name and address of the factory or establishment : </td>
    <td colspan="3"  class="boldElevenPrint" valign="bottom"><%= comname %><br />
        <%= comst %><br />
        <%=comcity %>-<%=compin %> </td>
  </tr>
  <tr>
    <td height="61" colspan="3" class="boldElevenPrint" valign="top">PARTICULARS OF PARINCIPAL EMPLOYER <br />
      NAME &amp; DESIGNATION : <br />
      ADDRESS: </td>
    <td colspan="3"  class="boldElevenPrint" valign="bottom">&nbsp;</td>
  </tr>
  <tr>
    <td height="21" colspan="6" class="boldElevenPrint">Period - From : 01-10-<%= year-1 %> To <b>31-03-<%= year %></b></td>
  </tr>
  <tr>
    <td colspan="5" class="bolddeepblue"><div align="justify" class="boldElevenPrint">I furnish below the details of employer&rsquo;s and employees'  share of contributions in respect of the under mentoined insured persons. I  hereby declare that the return includes each &amp; every employee, employed directly or  through an immediate employer or in connection with the work of the  factory/establishment or any work connected with the administration of the factory/establishment  or purchase of raw materials, sale or distribution of finished products etc, to  whom the ESI Act, 1948 applies, in the contribution period to which this return relates and that the  contributions in respect of Employer's and Employee's share have been correctly  paid in accordance with the provisions of the Act and Regulation.</div></td>
    <td width="6%" class="bolddeepblue">&nbsp;</td>
  </tr>
  <tr>
    <td height="19" colspan="6" valign="bottom" class="boldElevenPrint">&nbsp;</td>
  </tr>
  <tr>
    <td width="20%" valign="middle" class="boldElevenPrint">&nbsp;</td>
    <td valign="middle" class="boldElevenPrint"><div align="center">Employees Share<br />
      Employers Share <br />
      Total Contribution </div></td>
    <td valign="bottom" class="boldElevenPrint"> Rs. <%= tspf %>/-<br />
      Rs. <%= tcpf %>/- <br />
      Rs. <%=ttotal %>/- </td>
    <td valign="bottom" class="boldElevenPrint">&nbsp;</td>
    <td valign="bottom" class="boldElevenPrint">&nbsp;</td>
    <td valign="bottom" class="boldElevenPrint">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="6" class="boldEleven">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="6" class="boldElevenPrint"><% 
          
          out.println("<table width='100%' height='22' bordercolor='#000000' border='1' cellpadding='0' cellspacing='0' >");
          out.println("<tr>");
          out.println("<td width='10%' align='right' class='boldElevenPrint'>Sl.No.</td>");
          	out.println("<td width='10%' align='center' class='boldElevenPrint'>Challan Date</td>");
          out.println("<td width='14%' class='boldElevenPrint'><div align='center'>Employee Contribution </div></td>");
		  out.println("<td width='15%' class='boldElevenPrint'><div align='center'>Employer Contribution </div></td>");
          out.println("<td width='13%' class='boldElevenPrint'><div align='center'>Total Contribution </div></td>");
          out.println("</tr>");
          basic="0";cpf="0";spf="0";
         tbasic=0;tcpf=0;tspf=0;ttotal=0;
          for(int i=0;i<6;i++)
          {
        	  basic="0";cpf="0";spf="0";
        	if(i<3)
        	  sql="select  ROUND(sum(DOU_BASIC)),ROUND(sum(DOU_ESI)),ROUND(sum(DOU_CPYESI)) from pay_t_salary where CHR_MONTH='"+month[i]+"' and INT_YEAR="+start;
        	else
        		sql="select ROUND(sum(DOU_BASIC)),ROUND(sum(DOU_ESI)),ROUND(sum(DOU_CPYESI)) from pay_t_salary where CHR_MONTH='"+month[i]+"' and INT_YEAR="+end;
        	////System.out.println(sql);
        	String data[][]= CommonFunctions.QueryExecute(sql);
        	if(data.length>0)
			{
				basic="0";cpf="0";spf="0";
				if(!data[0][0].equals("-"))
					basic=data[0][0];
					//basic=data[0][0].substring(0,data[0][0].length()-3);
				if(!data[0][2].equals("-"))
					cpf=data[0][2];
					//cpf=data[0][2].substring(0,data[0][2].length()-3);
				if(!data[0][1].equals("-"))
					spf=data[0][1];
					//spf=data[0][1].substring(0,data[0][1].length()-3);
			}
    		else
			{
				basic="0";cpf="0";spf="0";
			}
        	tbasic=tbasic+Integer.parseInt(basic);
        	tcpf=tcpf+Integer.parseInt(cpf);
        	tspf=tspf+Integer.parseInt(spf);
        	ttotal=ttotal+(Integer.parseInt(cpf)+Integer.parseInt(spf));
        	out.println("<tr>");
          	out.println("<td width='7%' align='right' class='boldElevenPrint'>"+(i+1)+"</td>");
          	out.println("<td width='24%' align='center' class='boldElevenPrint'>&nbsp;</td>");
          	out.println("<td align='right' class='boldElevenPrint'>"+spf+"&nbsp;</td>");
          	out.println("<td align='right' class='boldElevenPrint'>"+cpf+"&nbsp;</td>");
          	out.println("<td align='right' class='boldElevenPrint'>"+(Integer.parseInt(cpf)+Integer.parseInt(spf))+"&nbsp;</td>");
          	out.println("</tr>");
          }
          	out.println("<tr>");
        	out.println("<td width='31%' colspan='2' align='center' class='boldElevenPrint'>Total Contribution&nbsp;</td>");
        	out.println("<td align='right' class='boldElevenPrint'>"+tspf+"&nbsp;</td>");
        	out.println("<td align='right' class='boldElevenPrint'>"+tcpf+"&nbsp;</td>");
        	out.println("<td align='right' class='boldElevenPrint'>"+ttotal+"&nbsp;</td>");
        	out.println("</tr>");
          out.println("</table>");
        %>    </td>
  </tr>
  <tr>
    <td class="boldElevenPrint">&nbsp;</td>
    <td class="boldElevenPrint">&nbsp;</td>
    <td class="boldElevenPrint"><div align="center">Total : </div></td>
    <td colspan="3" class="boldElevenPrint"><div align="right"><%= ttotal %>&nbsp;</div></td>
  </tr>
  <tr>
    <td colspan="6" class="boldElevenPrint">I declare that <br />
      (a) All the Records and Registers have been maintained as per provisions contained in ESI Act, Rules &amp; Regulations framed therein.<br />
      (b) During the period of return No. of Declaration forms have been submitted.<br />
      (c) During the above mperiod No. of TICs have been received.<br />
      (d) During the above period ....................... No. of PICs have been recevied.<br />
      (e) During the above period No. of PICS have been distributed amongst the eligible IPs.<br />
      (f) During the above period ....................... accidents have been reported to the concerned Branch Office.<br />
      (g) During the period 44 No. of employees directly employed by us have been covered and a total wages of Rs. /- have been paid to such employees.<br />
      (h) During the period No. of employees directly employed by us have not been coverd and a total wages of Rs. /- have been paid to such employees.<br />
      (i) During the period ....................... No. of employees employed through immediate employer have been covered and a total wages of Rs. /- have been paid to such employees.<br />
      (j) During the period ....................... No. of employees employed through immediate employer have not been covered and a total wages of Rs. /- have been paid to such employees.<br />
      (k) Following components of wages have been taken into consideration for the purpose of payment of contripution -<br />
      1. BASIC<br />
      2. HRA <br />
      3. CON <br />
      4. SPL ALL <br />
      5. GRADE <br />
      (l) Following components of wages have not been taken into consideration for the pirpose of payment of contribution- <br />
      1. <br />
      2. <br />
      3. <br />
      4. <br />
      5. <br />
      The above mentioned information is based on records and any inforations if found incorrect will render me liable for presecutions under provisions of ESI Act and action for recovery of contribution due along-with interest and damages as per provisions of the ESI Act. </td>
  </tr>
  <tr>
    <td height="22" class="boldElevenPrint">Place : </td>
    <td width="27%" class="boldElevenPrint">&nbsp;</td>
    <td colspan="4" class="boldElevenPrint">&nbsp;</td>
  </tr>
  <tr>
    <td height="20" class="boldElevenPrint">Date : </td>
    <td class="boldElevenPrint">&nbsp;</td>
    <td colspan="4" class="boldElevenPrint"><div align="center">Signature Of The Employer / Rubber Stamp </div></td>
  </tr>
  <tr>
    <td class="boldElevenPrint">&nbsp;</td>
    <td class="boldElevenPrint">&nbsp;</td>
    <td colspan="4" class="boldElevenPrint">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="6" class="boldElevenPrint"><div align="center">CERTIFICATE BY CHARTERED ACCOUNTANT <br />
      (To be submitted in case of employers employing 40 or more employees) </div></td>
  </tr>
  <tr>
    <td class="boldElevenPrint">&nbsp;</td>
    <td class="boldElevenPrint">&nbsp;</td>
    <td colspan="4" class="boldElevenPrint">&nbsp;</td>
  </tr>
  <tr>
    <td class="boldElevenPrint">&nbsp;</td>
    <td class="boldElevenPrint">&nbsp;</td>
    <td colspan="4" class="boldElevenPrint">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="6" class="boldElevenPrint">Certified that I have verified the above return form the Record &amp; Registration of M/S. and found it o be correct. </td>
  </tr>
  <tr>
    <td class="boldElevenPrint">&nbsp;</td>
    <td class="boldElevenPrint">&nbsp;</td>
    <td colspan="4" class="boldElevenPrint">&nbsp;</td>
  </tr>
  <tr>
    <td class="boldElevenPrint">&nbsp;</td>
    <td class="boldElevenPrint">&nbsp;</td>
    <td colspan="4" class="boldElevenPrint">&nbsp;</td>
  </tr>
  <tr>
    <td class="boldElevenPrint">&nbsp;</td>
    <td class="boldElevenPrint">&nbsp;</td>
    <td colspan="4" class="boldElevenPrint">&nbsp;</td>
  </tr>
  <tr>
    <td class="boldElevenPrint">&nbsp;</td>
    <td colspan="5" class="boldElevenPrint"><div align="center">Singnature &amp; Seal Of the Chartered Accountant with Membership No. </div></td>
  </tr>
  <tr>
    <td class="boldElevenPrint">&nbsp;</td>
    <td class="boldElevenPrint">&nbsp;</td>
    <td colspan="4" class="boldElevenPrint">&nbsp;</td>
  </tr>
  <tr>
    <td class="boldElevenPrint">&nbsp;</td>
    <td class="boldElevenPrint">&nbsp;</td>
    <td colspan="4" class="boldElevenPrint">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="6" class="boldElevenPrint">Important Instructions:<br />
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1. If any I.P is appointed for the first time  and/or leaves services during the contribution period, indicate &quot;A............................(date)&quot;  and/or &quot;L........................(date) &quot; in the remarks column (No.9). <br />
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2. Please indicate Insurance Numbers in  chronological (ascending) order.<br />
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3. Figures in columns 4,5 &amp; 6 shall be in  respect of wage periods ended during the contribution period. <br />
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4. Invariably strike totals of columns 4,5 &amp;  6 of the Return.<br />
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;5. No. over writing shall be made. Any  correction should be signed by the employer.<br />
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;6. Every page of this return should bear full  signature and rubber stamp of the employer.<br />
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;7. &quot;Daily Wages &quot; in Col.7 of the  return shall be calculated by dividing in Col.5 by figures in Col.No.4 to two decimal places. </td>
  </tr>
  <tr>
    <td colspan="6" class="boldElevenPrint">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="6" class="boldElevenPrint"><table border="0" align="center" cellpadding="0" cellspacing="3">
      <tr>
        <td width="56"><input class="buttonbold14" type="button" name="Submit"  value="Close"   accesskey="c"  onclick="redirect('Payrollmain.jsp')" /></td>
      </tr>
    </table></td>
  </tr>
</table>
<p>&nbsp;</p>
<p><br />
  <br />
</p>
</body>
</html>


<%
}
catch(Exception e)
{
	out.println(e.getMessage());
	System.out.println(e.getMessage());
}
%>