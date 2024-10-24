<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<title> :: PAYROLL ::</title>


 
 
<style type="text/css">
<!--
.style4 {font-weight: bold}
.style5 {
	font-size: 16px;
	font-weight: bold;
}
.style6 {
	font-size: 14px;
	font-weight: bold;
}
-->
</style>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
</head>
<body  onpaste='return false;'>
<p>

<table width="77%" border="1" align="left" cellpadding="0" cellspacing="0">
    <tr>
      <td><table width="100%" height="683" border="0" align="center" cellpadding="0" cellspacing="0">
        
        <tr>
          <td height="39" colspan="2" class="bolddeepblue"><%
          
          String type=request.getParameter("type");
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
          {basic="0";cpf="0";spf="0";
        	if(i<3)
        	  sql="select  sum(DOU_BASIC),sum(DOU_ESI),sum(DOU_CPYESI) from pay_t_salary where CHR_MONTH='"+month[i]+"' and INT_YEAR="+start;
        	else
        		sql="select  sum(DOU_BASIC),sum(DOU_ESI),sum(DOU_CPYESI) from pay_t_salary where CHR_MONTH='"+month[i]+"' and INT_YEAR="+end;
        	////System.out.println(sql);
        	String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
        	if(data.length>0)
        	{basic="0";cpf="0";spf="0";
        		if(!data[0][0].equals(""))
        		basic=data[0][0].substring(0,data[0][0].length()-3);
        		if(!data[0][2].equals(""))
        		cpf=data[0][2].substring(0,data[0][2].length()-3);
        		if(!data[0][1].equals(""))
        		spf=data[0][1].substring(0,data[0][1].length()-3);
        	}
        	
        	tcpf=tcpf+Integer.parseInt(cpf);
        	tspf=tspf+Integer.parseInt(spf);
        	ttotal=ttotal+(Integer.parseInt(cpf)+Integer.parseInt(spf));
        	
          }
          %></td>
          <td width="10%" height="39" class="bolddeepblue" valign="middle"><span class="style5">FROM 6
          <hr width="90%" noshade="noshade" class="bold1"/>
          </span></td>
          <td height="39" colspan="3" class="bolddeepblue">&nbsp;</td>
        </tr>
        <tr>
          <td height="21" colspan="3" class="bolddeepblue">In Quadruplicate </td>
          <td colspan="3" class="bolddeepblue">Employer's Code No.  </td>
        </tr>
        <tr>
          <td height="19" colspan="3" class="bolddeepblue">&nbsp;</td>
          <td colspan="3" valign="bottom" class="bolddeepblue">&nbsp;</td>
        </tr>
        <tr>
          <td height="19" colspan="3" class="bolddeepblue">&nbsp;</td>
          <td colspan="3" valign="bottom" class="bolddeepblue">Name of the Local Office- </td>
        </tr>
        <tr>
          <td height="38" colspan="6" class="bolddeepblue"><div align="center"><span class="style6">EMPLOYEES' STATE INSURANCE CORPORATION </span><br />
          (Return of Contribution)</div></td>
        </tr>
        <tr>
          <td height="17" colspan="6" class="bolddeepblue"><div align="center">(See Regulation 26 of the Employees' State Insurance (General) Regulations, 1950) </div></td>
        </tr>
        <tr>
          <td height="61" colspan="3" class="bolddeepblue" valign="top">Name and address of the factory or establishment: <br />Name and addressof the Employer </td>
          <td colspan="3"  class="bolddeepblue" valign="bottom"><%= comname %><br />
            <%= comst %><br />
          <%=comcity %>-<%=compin %> </td>
        </tr>
        <tr>
          <td width="28%" height="43" class="bolddeepblue">Period from </td>
          <td colspan="2" class="bold1"><%= from %></td>
          <td colspan="3" class="bolddeepblue">to <b><%= to %></b></td>
        </tr>
        <tr>
          <td colspan="5" class="bolddeepblue"><div align="justify">I furnish below the details of employer&rsquo;s and employees'  share of contributions in respect of the undermentoined insured persons. I  hereby declare that the return includes every employee, employed directly or  through an immediate employer or in connection with the work of the  factory/establishment or any work connected with the administration of the factory/establishment  or purchase of raw materials, sale or distribution of finished products etc, to  whom the contribution period to which this return relates, applies and that the  contributions in respect of Employer's and Employee's share have been correctly  paid in accordance with the provisions of the Act and Regulation relating to  the payment of contributions vide challans detailed below.</div></td>
          <td width="6%" class="bolddeepblue">&nbsp;</td>
        </tr>
        <tr>
          <td height="31" colspan="2" class="bolddeepblue" valign="bottom">Total contribution amounting to Rs <%=ttotal %>/- </td>
          <td colspan="4" class="bolddeepblue" valign="bottom"><div align="center">Comprising of Rs.<%= tcpf %>/- as Employer's share and </div></td>
        </tr>
        <tr>
          <td height="21" class="bolddeepblue">Rs.<%= tspf %>/-  </td>
          <td height="21" colspan="5" class="bolddeepblue">as Employee's share(total of col.6 of the Return) paid as under:</td>
        </tr>
        <tr>
          <td colspan="6" class="bolddeepblue"><hr /></td>
        </tr>
        <tr>
          <td colspan="6" class="bolddeepblue">
          <% 
          
          out.println("<table width='100%' height='22' border='0' cellpadding='0' cellspacing='0'>");
          out.println("<tr>");
          out.println("<td colspan='4'>&nbsp;</td>");
          out.println("<td width='15%'><div align='right'>Employer Cont. </div></td>");
          out.println("<td width='14%'><div align='right'>Employee Cont. </div></td>");
          out.println("<td width='13%'><div align='right'>Total Cont. </div></td>");
          out.println("</tr>");
          basic="0";cpf="0";spf="0";
         tbasic=0;tcpf=0;tspf=0;ttotal=0;
          for(int i=0;i<6;i++)
          {
        	  basic="0";cpf="0";spf="0";
        	if(i<3)
        	  sql="select  sum(DOU_BASIC),sum(DOU_ESI),sum(DOU_CPYESI) from pay_t_salary where CHR_MONTH='"+month[i]+"' and INT_YEAR="+start;
        	else
        		sql="select  sum(DOU_BASIC),sum(DOU_ESI),sum(DOU_CPYESI) from pay_t_salary where CHR_MONTH='"+month[i]+"' and INT_YEAR="+end;
        	////System.out.println(sql);
        	String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
        	if(data.length>0)
        	{
        		basic="0";cpf="0";spf="0";
        		if(!data[0][0].equals(""))
        		basic=data[0][0].substring(0,data[0][0].length()-3);
        		if(!data[0][2].equals(""))
        		cpf=data[0][2].substring(0,data[0][2].length()-3);
        		if(!data[0][1].equals(""))
        		spf=data[0][1].substring(0,data[0][1].length()-3);
        	}
        	tbasic=tbasic+Integer.parseInt(basic);
        	tcpf=tcpf+Integer.parseInt(cpf);
        	tspf=tspf+Integer.parseInt(spf);
        	ttotal=ttotal+(Integer.parseInt(cpf)+Integer.parseInt(spf));
        	out.println("<tr>");
          	out.println("<td width='7%' align='right'>"+(i+1)+"</td>");
          	out.println("<td width='24%' align='center'>Challan dated</td>");
          	out.println("<td width='10%' align='right'>for Rs.</td>");
          	out.println("<td width='17%' align='right'>"+basic+"</td>");
          	out.println("<td align='right'>"+cpf+"</td>");
          	out.println("<td align='right'>"+spf+"</td>");
          	out.println("<td align='right'>"+(Integer.parseInt(cpf)+Integer.parseInt(spf))+"</td>");
          	out.println("</tr>");
          }
          	out.println("<tr>");
        	out.println("<td width='7%' align='right'>&nbsp;</td>");
        	out.println("<td width='24%' align='center'>&nbsp;</td>");
        	out.println("<td width='10%' align='right'>&nbsp;</td>");
        	out.println("<td width='17%' align='right'>"+tbasic+"</td>");
        	out.println("<td align='right'>"+tcpf+"</td>");
        	out.println("<td align='right'>"+tspf+"</td>");
        	out.println("<td align='right'>"+ttotal+"</td>");
        	out.println("</tr>");
          out.println("</table>");
        %>
        </td>
        </tr>
        <tr>
          <td colspan="6" class="bolddeepblue"><hr /></td>
        </tr>
        <tr>
          <td height="28" class="bolddeepblue">Place : </td>
          <td width="16%" class="bolddeepblue">&nbsp;</td>
          <td colspan="2" class="bolddeepblue">&nbsp;</td>
          <td colspan="2" class="bolddeepblue">Signature : </td>
        </tr>
        <tr>
          <td class="bolddeepblue">Date : </td>
          <td class="bolddeepblue">&nbsp;</td>
          <td colspan="2" class="bolddeepblue">&nbsp;</td>
          <td colspan="2" class="bolddeepblue">Designation : </td>
        </tr>
        <tr>
          <td height="165" colspan="6" class="bolddeepblue">Important Instructions:<br /> 
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1. If any I.P is appointed for the first time  and/or leaves services during the contribution period, indicate<br />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&quot;A............................date&quot;  and/or &quot;L........................(date) &quot; in the remarks column (No.9).  <br /> 
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2. Please indicate Insurance Numbers in  chronological (ascending) order.<br /> 
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3. Figures in columns 4,5 &amp; 6 shall be in  respect of wage periods ended during the contribution period. <br /> 
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4. Invariably strike totals of columns 4,5 &amp;  6 of the Return.<br /> 
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;5. No. over writing shall be made. Any  correction should be signed by the employer.<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;6. Every page of this return should bear full  signature and rubber stamp of the employer.<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;7. &quot;Daily Wages &quot; in Col.7 of the  return shall be calculated by dividing in Col.5 by figures in Col.No.4 to two &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;decimal places. </td>
        </tr>
        
      </table></td>
    </tr>
</table>
  <p align="right"><a href="Form6-1Print.jsp?type=<%=type%>&company=<%= company%>&Year=<%= year%>"><font class="bolddeepred">Print</font></a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
  <table width="184" align="center" cellpadding="15" cellspacing="0">
  <tr>
    <td width="100" height="44" class="boldEleven"><strong>Export </strong></td>
    <td class="boldEleven"><div align="center"><a  title="Excel" href="javascript:;" onclick="CreateExcelSheet()"><img src="../Image/report/Excel.png" width="15" height="14" border="0" /></a> </div></td>
    <td class="boldEleven"><div align="center"><a title="Text" href="javascript:;" onclick="windowSave('Form6-1.txt')"><img src="../Image/report/text.gif" width="15" height="14" border="0" /></a></a></div></td>
    <td class="boldEleven"><div align="center"><a title="Document" href="javascript:;" onclick="windowSave('Form6-1.doc')"><img src="../Image/report/MS.GIF" width="15" height="14" border="0" /></a></div></td>
    <td class="boldEleven"><div align="center"><a title="HTML" href="javascript:;" onclick="windowSave('Form6-1.html')"><img src="../Image/report/IE.GIF" width="15" height="14" border="0" /></a></div></td>
  </tr>
</table>
</body>
</html>
