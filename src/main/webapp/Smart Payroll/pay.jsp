<%@ page import="java.io.*,java.util.*,java.lang.*,java.sql.*"%>
<%@ page import="com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.SmartPayroll.*"%>

<jsp:useBean id="conbean" class="DBConnection.DBCon"></jsp:useBean>
<html>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<style type="text/css">
<!--
.style4 {font-size: 18px}
-->
    </style>

<title> :: PAYROLL ::</title>


 
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>


<%
		String psql=" SELECT a.CHR_EMPID   ";
						psql = psql+ " FROM pay_t_salary a,com_m_staff b ,com_m_bank c, com_m_office  d,com_m_desig e ";
						psql = psql+ " WHERE c.INT_BANKID =b.CHR_BANK  ";
						psql = psql+ " AND b.INT_OFFICEID=d.INT_OFFICEID ";
						psql = psql+ " AND d.INT_OFFICEID=5 ";
						psql = psql+ " AND b.INT_DESIGID=e.INT_DESIGID "; 
						psql = psql+ " AND a.CHR_EMPID =b.CHR_EMPID ";
						psql = psql+ " AND b.CHR_TYPE!='T' ";
						psql = psql+ " AND b.CHR_HOLD!='Y' ";
						psql = psql+ " AND a.CHR_MONTH='October' ";
						psql = psql+ " AND a.INT_YEAR= 2007 ";
						
						String staffid = "";
						String mth = "10";
						String mont = DateUtil.getMonth(Integer.parseInt(mth));
						String Year = "2007";
						String empname="";
						double basic=0.0;
						double earning=0.0;
						double deduction=0.0;
						double aamount=0.0;
						double ramount=0.0;
						double esi=0.0;
						double pf=0.0;
						String psdatas[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(psql);
						for(int g=0;g<psdatas.length;g++)
						{
							basic=0.0;
							earning=0.0;
							deduction=0.0;
							aamount=0.0;
							ramount=0.0;
							esi=0.0;
							pf=0.0;
	%>
<style type="text/css">
<!--
body {
	margin-left: 1in;
	margin-top: 1in;
	margin-right: 1in;
	margin-bottom: 1in;
}
-->
</style>
<table width="700" height="21" border="1" align="center" cellpadding="5"
	cellspacing="0" bordercolor="#999999">
	<tr>
		<td>
		<%
						staffid = psdatas[g][0];
							String sql= " SELECT CHR_EMPNAME,ROUND(DOU_BASIC),ROUND(DOU_PF),ROUND(DOU_ESI) FROM pay_t_salary  ";
							sql = sql+" WHERE CHR_EMPID='"+staffid+"'";
							sql = sql+" AND  INT_YEAR ="+Year;
							sql = sql+" AND CHR_MONTH='"+mont+"'";
							 
							String datas[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sql);
							
							if(datas.length>0)
							{
								empname = datas[0][0];
								basic=Double.parseDouble(datas[0][1]);
								pf=Double.parseDouble(datas[0][2]);
								esi=Double.parseDouble(datas[0][3]);
								
								String ssql="SELECT e.CHR_DESIGNAME,d.CHR_OFFICENAME,FIND_A_BANKNAME_NAME(c.INT_BANKID) , b.CHR_ACCNO ,INT_COMPANYID  ";
								ssql = ssql+" FROM com_m_staff b ,com_m_bank c, com_m_office  d,com_m_desig e ";
								ssql = ssql+" WHERE b.CHR_EMPID='"+staffid+"'  ";
								ssql = ssql+" AND c.INT_BANKID =b.CHR_BANK  ";
								ssql = ssql+" AND b.INT_OFFICEID=d.INT_OFFICEID  ";
								ssql = ssql+" AND b.INT_DESIGID=e.INT_DESIGID ";
								 
								String pdatas[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(ssql);
								ssql="SELECT upper(CHR_COMPANYNAME) FROM com_m_company WHERE INT_COMPANYID="+pdatas[0][4];
								String cpy[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(ssql);
						%>

		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="15%" rowspan="4" valign="top" class="boldThirteen"><img
					src="../Image/report/Mythra Logo.JPG" width="100" height="50"></td>
				<td width="70%" class="boldThirteen">
				<div align="center"><%=cpy[0][0] %></div>
				</td>
				<td width="15%" rowspan="4" valign="top" class="boldThirteen"><img
					src="../Image/report/Wipro logo.gif" width="100" height="80"></td>
			</tr>
			<tr>
				<td class="boldThirteen">
				<div align="center">PAY SLIP FOR ( <%=mont +" - " +Year%> )</div>
				</td>
			</tr>
			<tr>
				<td class="boldThirteen">
				<div align="center"></div>
				</td>
			</tr>
			<tr>
				<td class="boldThirteen">
				<div align="center"><%=empname%></div>
				</td>
			</tr>
			<tr>
				<td colspan="3" class="boldEleven">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="21%" class="boldEleven">Employee Number</td>
						<td width="27%" class="boldEleven"><%=staffid%></td>
						<td width="3%" class="boldEleven">&nbsp;</td>
						<td width="14%" class="boldEleven">Location</td>
						<td width="35%" class="boldEleven"><%=pdatas[0][1]%></td>
					</tr>
					<tr>
						<td class="boldEleven">Designation</td>
						<td class="boldEleven"><%=pdatas[0][0]%></td>
						<td class="boldEleven">&nbsp;</td>
						<td class="boldEleven">Bank Details</td>
						<td class="boldEleven"><%=pdatas[0][2]+" - "+ pdatas[0][3]%>
						</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td colspan="3" class="boldEleven">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">

					<tr>
						<td colspan="2" valign="top" class="bolddeeplogin">
						<%
									sql = " SELECT CHR_ACODE,CHR_ANAME FROM pay_m_allowance ";
									String aname[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sql);
									String sallowansql="";
									String allowansql="";
 									for(int a=0;a<aname.length;a++)
										sallowansql =sallowansql+aname[a][0]+" , ";
										
									sallowansql=sallowansql.trim();	
									sallowansql = sallowansql.substring(0,sallowansql.length()-1);
									
									
									sql= " SELECT "+sallowansql+" FROM pay_t_salary  ";
									sql = sql+" WHERE CHR_EMPID='"+staffid+"'";
									sql = sql+" AND  INT_YEAR ="+Year;
									sql = sql+" AND CHR_MONTH='"+mont+"'";
									
									String Adatas[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sql);	
									out.println("<table cellpadding=0 cellspacing=0 width='90%'  border=0>");
									out.print("<tr><td class='boldEleven'><b> Earnings");
									out.print("<td  class='boldEleven' align='right'><b> Amount");
									out.print("<tr><td class='boldEleven'>Basic");
									out.print("<td  class='boldEleven' align='right'>"+basic);
									earning=earning+basic;
									if(aname.length >0)
									{
										for(int u=0;u<aname.length;u++)
										{
										 aamount=0.0;
										 aamount=Double.parseDouble(Adatas[0][u]);	
										 if(aamount>0)
										 {
											out.print("<tr><td class='boldEleven'>"+aname[u][1]);
											out.print("<td  class='boldEleven' align='right'>"+Adatas[0][u]);
											earning=earning+aamount;
										 }	
										}
									}	
									out.println("</table>");
									%>
						</td>
						<td colspan="3" valign="top" class="bolddeeplogin">
						<%
									sql = " SELECT CHR_RCODE,CHR_RNAME FROM pay_m_recovery ";
									String rname[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sql);
									String rallowansql="";
									
 									for(int a=0;a<rname.length;a++)
										rallowansql =rallowansql+rname[a][0]+" , ";
										
									rallowansql=rallowansql.trim();	
									rallowansql = rallowansql.substring(0,rallowansql.length()-1);
									
									
									sql= " SELECT "+rallowansql+" FROM pay_t_salary  ";
									sql = sql+" WHERE CHR_EMPID='"+staffid+"'";
									sql = sql+" AND  INT_YEAR ="+Year;
									sql = sql+" AND CHR_MONTH='"+mont+"'";
									
									String Rdatas[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sql);	
									out.println("<table cellpadding=0 cellspacing=0 width='90%' border=0>");
									out.print("<tr><td class='boldEleven'><b> Deductions");
									out.print("<td  class='boldEleven' align='right'><b> Amount");
									if(rname.length>1)
									{
										for(int u=0;u<rname.length;u++)
										{
										
										 ramount=0.0;
										 ramount=Double.parseDouble(Rdatas[0][u]);	
										 if(ramount>0)
										 {
											out.print("<tr><td class='boldEleven'>"+rname[u][1]);
											out.print("<td  class='boldEleven' align='right'>"+Rdatas[0][u]);
											deduction=deduction+ramount;
										 }	
										}
									}	
									out.print("<tr><td class='boldEleven'>PF");
									out.print("<td  class='boldEleven' align='right'>"+pf);
									deduction=deduction+pf;
									out.print("<tr><td class='boldEleven'>ESI");
									out.print("<td  class='boldEleven' align='right'>"+esi);
									deduction=deduction+esi;
									out.println("</table>");
									%>
						</td>
					</tr>
					<tr>
						<td width="30%" class="bolddeeplogin">Total Earnings</td>
						<td width="18%" class="boldEleven" align="right">
						<div align="right"><%=earning%></div>
						</td>
						<td width="17%" class="bolddeeplogin">&nbsp;</td>
						<td width="18%" class="bolddeeplogin">Total deductions</td>
						<td width="17%" class="boldEleven">
						<div align="right"><%=deduction%></div>
						</td>
					</tr>
					<tr>
						<td class="bolddeeplogin">&nbsp;</td>
						<td class="bolddeeplogin">&nbsp;</td>
						<td class="bolddeeplogin">&nbsp;</td>
						<td class="bolddeeplogin">Net Amount</td>
						<td class="bolddeeplogin">
						<div align="center"><%=(earning-deduction)%></div>
						</td>
					</tr>
					<tr>
						<td colspan="5" class="bolddeeplogin">
						<div id="<%=("Rupees"+g)%>" align="center"><script
							language="javascript">
					  	numberWord("<%=(earning-deduction)%>","<%=("Rupees"+g)%>") 
					                  </script></div>
						</td>
					</tr>
					<tr>
						<td colspan="5" class="bolddeeplogin">
						<div align="center" class="bolddeepblue" id="Rupees">H.O.
						: #8, 1st MAIN ROAD, SEETHAMMAL EXTN., ALWARPET, CHENNAI-600018.
						Tel.: 24340906(4 LINES) FAX:24340835</div>
						</td>
					</tr>
					<tr>
						<td colspan="5" class="boldEleven"><strong> *
						Automated generated payslip by Mythra salary package does not
						require any signature. </strong></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>

		<%
							}
							else
							{
								out.println("Data not found...");
							}
							%>
		</td>
	</tr>


</table>
<br>
<br>
<br>
<br>
<%
	  }
	  %>


</html>




