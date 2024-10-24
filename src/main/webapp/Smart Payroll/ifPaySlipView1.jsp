<%@ page import="java.io.*,java.util.*,java.lang.*,java.sql.*"%>
<%@ page import="com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.SmartPayroll.*"%>
<html>
<script language="javascript" src="../JavaScript/comfunction.js"></script>

<title> :: PAYROLL ::</title>


 
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<body  onpaste='return false;'>
<center><br>
<br>
<br>
<table width="700" height="21" border="1" align="center" cellpadding="5"
	cellspacing="0" bordercolor="#999999" background="../images/payslip.jpg">
	<tr>
		<td>
		<%
							
							String staffid=""+session.getAttribute("EMPID");
							String psql= " SELECT count(*) FROM com_m_staff WHERE CHR_EMPID='"+staffid+"' AND CHR_PAYSLIPHIDE='Y'";
						
							boolean f=com.my.org.erp.common.CommonFunction.RecordExist(psql);
						if(f)
						{
						 	response.sendRedirect("Paysliphide.jsp");
						}
							
							String mth = "" + request.getParameter("Month");
							String mont = DateUtil.getMonth(Integer.parseInt(mth));
							String Year = "" + request.getParameter("Year");
							//staffid,mont,Year
							
							
							
							
							String empname="";
							double basic=0.0;
							double earning=0.0;
							double deduction=0.0;
							double aamount=0.0;
							double ramount=0.0;
							double esi=0.0;
							double pf=0.0;
							double adv=0.0;
							double grosspay=0.0;
							String wrkdays="";
							String sql= " SELECT CHR_EMPNAME,ROUND(DOU_BASIC),ROUND(DOU_PF),ROUND(DOU_ESI),ROUND(DOU_ADVANCE),DOU_WORKDAYS  FROM pay_t_salary  ";
							sql = sql+" WHERE CHR_EMPID='"+staffid+"'";
							sql = sql+" AND  INT_YEAR ="+Year;
							sql = sql+" AND CHR_MONTH='"+mont+"'";
							 
							String datas[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sql);
							
							if(datas.length>0)
							{
								empname = datas[0][0];
								wrkdays=datas[0][5];
								basic=Double.parseDouble(datas[0][1]);
								pf=Double.parseDouble(datas[0][2]);
								esi=Double.parseDouble(datas[0][3]);
								adv=Double.parseDouble(datas[0][4]);
								String ssql="SELECT e.CHR_DESIGNAME,d.CHR_OFFICENAME, FIND_A_BANKGROUP_NAME(b.CHR_BANK), b.CHR_ACCNO ,INT_COMPANYID ";
								ssql =ssql+",b.CHR_PFNO, b.CHR_ESINO FROM com_m_staff b, com_m_office  d,com_m_desig e ";
								ssql = ssql+" WHERE b.CHR_EMPID='"+staffid+"'  ";
								 
								ssql = ssql+" AND b.INT_OFFICEID=d.INT_OFFICEID  ";
								ssql = ssql+" AND b.INT_DESIGID=e.INT_DESIGID ";
							 
								String pdatas[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(ssql);
								ssql="SELECT upper(CHR_COMPANYNAME) FROM com_m_company WHERE INT_COMPANYID="+pdatas[0][4];
								String cpy[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(ssql);
							
						%>

		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td rowspan="4" class="boldThirteen">
				<div align="left"><img src="../Image/paylogo.gif" width="100"
					height="65"></div>
				</td>
				<td class="boldThirteen">
				<div align="center"><%=cpy[0][0] %></div>
				</td>
				<td rowspan="4" class="boldThirteen">
				<div align="right"><img src="../Image/report/Wipro logo.gif"
					width="100" height="80"></div>
				</td>
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
						<td colspan="5" class="bolddeeplogin">
						<hr width="100%" size=1>
						</td>
					</tr>
					<tr>
						<td width="21%" class="bolddeeplogin">Employee Number</td>
						<td width="27%" class="boldEleven"><%=staffid%></td>
						<td width="3%" class="boldEleven">&nbsp;</td>
						<td width="17%" class="bolddeeplogin">PF Number</td>
						<td width="32%" class="boldEleven"><%=pdatas[0][5]%></td>
					</tr>
					<tr>
						<td class="bolddeeplogin">Designation</td>
						<td class="boldEleven"><%=pdatas[0][0]%></td>
						<td class="boldEleven">&nbsp;</td>
						<td class="bolddeeplogin">ESI Number</td>
						<td class="boldEleven"><%=pdatas[0][6]%></td>
					</tr>
					<tr>
						<td class="bolddeeplogin">Location</td>
						<td class="boldEleven"><%=pdatas[0][1]%></td>
						<td class="boldEleven">&nbsp;</td>
						<td class="bolddeeplogin">Bank Details</td>
						<td class="boldEleven"><%=pdatas[0][2]+" - "+ pdatas[0][3]%>
						</td>
					</tr>
					<tr>
						<td class="bolddeeplogin"><STRONG>No. of working
						days </STRONG></td>
						<td class="boldEleven"><%=wrkdays%></td>
						<td class="boldEleven">&nbsp;</td>
						<td class="bolddeeplogin">&nbsp;</td>
						<td class="boldEleven">&nbsp;</td>
					</tr>
					<tr>
						<td colspan="5" class="bolddeeplogin">
						<hr width="100%" size=1>
						</td>
					</tr>
					<tr>
						<td colspan="2" valign="top" class="bolddeeplogin">
						<%
									sql = " SELECT CHR_ACODE,CHR_ANAME FROM pay_m_allowance ORDER BY INT_ALLOWANCEID";
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
									//out.println("<table cellpadding=0 cellspacing=0 width='90%'  border=0>");
									//out.print("<tr><td class='boldEleven'><b> Earnings");
									//out.print("<td  class='boldEleven' align='right'><b> Amount");
									//out.print("<tr><td class='boldEleven'>Basic");
									//out.print("<td  class='boldEleven' align='right'>"+(int)basic);
									earning=earning+basic;
									if(aname.length >0)
									{
										for(int u=0;u<aname.length;u++)
										{
										 aamount=0.0;
										 aamount=Double.parseDouble(Adatas[0][u]);	
										 if(aamount>0)
										 {
											//out.print("<tr><td class='boldEleven'>"+aname[u][1]);
											//out.print("<td  class='boldEleven' align='right'>"+Adatas[0][u]);
											earning=earning+aamount;
										 }	
										}
									}
									//out.print("<tr><td class='bolddeeplogin'>Total Earnings ");
									//out.print("<td  class='boldEleven' align='right'>"+(int)earning);
										
									//out.println("</table>");
									
									
String ksql= " Select b.CHR_EMPID,a.INT_SALARY,b.A001,b.A002,b.A003,b.A004,b.A005,b.A006,b.A007,b.A008,b.A009,b.A0010,";
ksql = ksql+" (a.INT_SALARY+b.A001+b.A002+b.A003+b.A004+b.A005+b.A006) ,";
ksql = ksql+" (a.INT_SALARY+b.A001+b.A002+b.A003+b.A004+b.A005+b.A006+b.A007+b.A008+b.A009+b.A0010) ";
ksql = ksql+" FROM pay_t_salarybasic a , pay_t_salaryallowance b ";
ksql = ksql+" where a.CHR_EMPID = b.CHR_EMPID ";
ksql = ksql+" AND a.CHR_MONTH='"+mont+"' ";
ksql = ksql+" AND b.CHR_MONTH='"+mont+"'  ";
ksql = ksql+" AND b.INT_YEAR=  "+Year;
ksql = ksql+" AND a.INT_YEAR=  "+Year;
ksql = ksql+" AND b.CHR_EMPID='"+staffid+"'";

String datass[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(ksql);
out.println("<br>");
out.println("<table cellpadding=0 cellspacing=0 width='90%'  border=0>");
out.print("<tr><td class='boldEleven'><b> Earnings");
out.print("<td  class='boldEleven' align='right'><b> Amount");
if(Double.parseDouble(datass[0][1]) >0)
	out.println("<tr><td  class='boldEleven'>BASIC</td><td  class='boldEleven' align='right'>"+datass[0][1]+"</td>");
if(Double.parseDouble(datass[0][2]) >0)	
	out.println("<tr><td class='boldEleven'>HRA</td><td  class='boldEleven' align='right'>"+datass[0][2]+"</td>");
if(Double.parseDouble(datass[0][3]) >0)
	out.println("<tr><td class='boldEleven'>SPL ALLOWANCE</td><td class='boldEleven' align='right'>"+datass[0][3]+"</td>");
if(Double.parseDouble(datass[0][4]) >0)
	out.println("<tr><td class='boldEleven'>GRADE ALLOWANCE</td><td class='boldEleven' align='right'>"+datass[0][4]+"</td>");
if(Double.parseDouble(datass[0][5]) >0)
	out.println("<tr><td class='boldEleven'>TRANSPORTATION ALLOWANCE</td><td class='boldEleven' align='right'>"+datass[0][5]+"</td>");
if(Double.parseDouble(datass[0][6]) >0)	
	out.println("<tr><td class='boldEleven'>VARIABLE ALLOWANCE</td><td class='boldEleven' align='right'>"+datass[0][6]+"</td>");
if(Double.parseDouble(datass[0][7]) >0)
	out.println("<tr><td class='boldEleven'>LEAVE TRAVEL ALLOWANCE</td><td class='boldEleven' align='right'>"+datass[0][7]+"</td>");
if(Double.parseDouble(datass[0][12]) >0)
	out.println("<tr><td class='boldEleven'><b>Grosspay</b></td><td class='boldEleven' align='right'>"+datass[0][12]+"</td>");
if(Double.parseDouble(datass[0][8]) >0)
	out.println("<tr><td class='boldEleven'>OTHERS</td><td class='boldEleven' align='right'>"+datass[0][8]+"</td>");
if(Double.parseDouble(datass[0][9]) >0)
	out.println("<tr><td class='boldEleven'>SHIFT ALLOWANCE</td><td class='boldEleven' align='right'>"+datass[0][9]+"</td>");
if(Double.parseDouble(datass[0][10]) >0)
	out.println("<tr><td class='boldEleven'>MOBILE CLAIMS</td><td class='boldEleven' align='right'>"+datass[0][10]+"</td>");
if(Double.parseDouble(datass[0][11]) >0)
	out.println("<tr><td class='boldEleven'>ARREARS</td><td class='boldEleven' align='right'>"+datass[0][11]+"</td>");
	
out.println("</table>");
grosspay = Double.parseDouble(datass[0][13]);
%>
						</td>
						<td class="boldEleven">&nbsp;</td>
						<td colspan="2" valign="top" class="bolddeeplogin">
						<%
									sql = " SELECT CHR_RCODE,CHR_RNAME FROM pay_m_recovery ORDER BY INT_RECOVERYID";
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
									if(adv>0)
									{
									out.print("<tr><td class='boldEleven'>Advance");
									out.print("<td  class='boldEleven' align='right'>"+(int)adv);
									deduction=deduction+adv;
									
									}	
									out.print("<tr><td class='boldEleven'>PF");
									out.print("<td  class='boldEleven' align='right'>"+(int)pf);
									deduction=deduction+pf;
									out.print("<tr><td class='boldEleven'>ESI");
									out.print("<td  class='boldEleven' align='right'>"+(int)esi);
									deduction=deduction+esi;
									out.print("<tr><td class='bolddeeplogin'>Loss of pay ");
									out.print("<td  class='boldEleven' align='right'>"+(int)(grosspay-earning));
									
									out.print("<tr><td class='bolddeeplogin'>Total deductions ");
									out.print("<td  class='boldEleven' align='right'>"+(int)(deduction+(grosspay-earning)));
									
									
									out.println("</table>");
									%>
						</td>
					</tr>
					<tr>
						<td class="bolddeeplogin">&nbsp;</td>
						<td class="boldEleven">
						<div align="right"><span class="bolddeeplogin">Net
						Amount </span></div>
						</td>
						<td class="boldEleven">&nbsp;</td>
						<td class="bolddeeplogin"><%=(int)(earning-deduction)%></td>
						<td class="boldEleven">&nbsp;</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td colspan="3" class="boldEleven">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="bolddeeplogin">
						<div align="center" id="Rupees"><script
							language="javascript">
					  	numberWord("<%=(earning-deduction)%>","Rupees") 
					                  </script></div>
						</td>
					</tr>
					<tr>
						<td class="bolddeeplogin">
						<hr size="1" width="100%" color="#999999">
						</td>
					</tr>
					<tr>
						<td class="bolddeeplogin">
						<div align="center" class="bolddeepblue" id="Rupees">H.O.
						: #8, 1st MAIN ROAD, SEETHAMMAL EXTN., ALWARPET, CHENNAI-600018.
						Tel.: 24340906(4 LINES) FAX:24340835</div>
						</td>
					</tr>
					<tr>
						<td class="boldEleven"><strong> * Automatic
						generated payslip by Mythra salary package does not require any
						signature. </strong></td>
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
<p>&nbsp;</p>
<p align="right"><A href="javascript:window.print()">print</A></p>
</center>
</body>

</html>




