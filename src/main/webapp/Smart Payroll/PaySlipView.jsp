<%@ page import="java.io.*,java.util.*,java.lang.*,java.sql.*"%>
<%@ page import="com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.SmartPayroll.*"%>

<jsp:useBean id="conbean" class="DBConnection.DBCon"></jsp:useBean>
<html>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<style type="text/css">
<!--
.style4 {font-size: 18px}
-->
    </style>

<title> :: PAYROLL ::</title>


 
<body  onpaste="return false;" bgcolor="">
<center>
<%
					String empId,year,month;
					String empName,staff,compId,compName,branchId,branchName;
					//out.println("<br><br><br><br><br><br><br>");
					//out.println("<a href='javascript:history.back()'>Back</a>");
					out.println("<br>");
					Connection con;
					Statement st;
					ResultSet rs=null;   
					ResultSet rs1=null; 
					try
					{
						year=request.getParameter("Year");					
						month=request.getParameter("Month");
						compId= ""+request.getParameter("company");
						branchId= ""+request.getParameter("branch");
						String desigId= ""+request.getParameter("Designation");
						String depId= ""+request.getParameter("Department");
						String empid[] = request.getParameterValues("ename");
						//out.println("Month : "+month);
						//out.println("Year  : "+year);						
						int year1=Integer.parseInt(year);
        				int days=0;
						days=Integer.parseInt(month);
						
        				int wrkDays=0;						
        				wrkDays=DateUtil.totalDays(days,year1);
						
						String monName= DateUtil.getMonth(Integer.parseInt(month));

						con=conbean.getConnection();
						st=con.createStatement();
						String sql="SELECT A.CHR_EMPID,B.CHR_STAFFNAME,A.INT_TOTDAYS,A.INT_BASIC,A.INT_ADDEDALLOWANCE,A.INT_ELDAYS,";
						sql = sql +" A.INT_RECOVERY,A.INT_PF,A.INT_ESI,A.CUR_GROSSPAY,A.INT_TOTADV, A.CUR_ELAMT,";
						sql = sql +" A.INT_NETSAL,C.CHR_DEPARTNAME,D.CHR_DESIGNAME FROM PAY_T_NSALARYDETAILSPF A, ";
						sql = sql +"  com_m_staff  B,  com_m_depart   C, com_m_desig  D WHERE A.CHR_EMPID=B.CHR_EMPID AND ";
						sql = sql +" B.INT_DEPARTID=C.INT_DEPARTID AND B.INT_DESIGID=D.INT_DESIGID AND A.CHR_MONTHS='"+monName+"' ";
						sql = sql +" AND A.INT_YEAR="+year;
						if(!compId.equals("null"))				
							sql = sql +" AND B.INT_COMPANYID="+compId;
						if(!branchId.equals("-1") && !branchId.equals("null"))
							sql=sql+" AND B.INT_BRANCHID="+branchId;
						if(empid!=null)
							sql=sql+" AND A.CHR_EMPID='"+empid[0]+"'";
						if(!desigId.equals("null"))
							sql=sql+" AND B.INT_DESIGID="+desigId;							
						if(!depId.equals("null"))
							sql=sql+" AND B.INT_DEPARTID="+depId;							
						
						//out.println(sql);
						rs=st.executeQuery(sql);
						int rcount=0;
						String lossofdays="";
						while(rs.next())
						{
							rcount =rcount+1;
							
						%>
<table width="627" height="502" border="1" align="center"
	cellpadding="0" cellspacing="0" bordercolor="#999999">
	<tr>
		<td height="500">
		<table width="613" height="403" border="0" align="center"
			cellpadding="3" cellspacing="3">
			<!--  <tr>
                                <td colspan="6" class="boldEleven"><div align="center"><img src="../Image/logo.jpg" width="600" height="100"></div></td>
                              </tr>  -->
			<tr>
				<td class="boldEleven">&nbsp;</td>
				<td colspan="4" class="boldThirteen">
				<table width="100%" border="0" cellpadding="2" cellspacing="0">
					<tr>
						<td class="boldgre">
						<div align="center" class="style4"></div>
						</td>
					</tr>
					<tr>
						<td class="boldgre">
						<div align="center"></div>
						</td>
					</tr>
					<tr>
						<td class="boldgre">
						<div align="center"></div>
						</td>
					</tr>
				</table>
				</td>
				<td class="boldEleven">&nbsp;</td>
			</tr>
			<tr>
				<td class="boldEleven">&nbsp;</td>
				<td colspan="4" class="boldThirteen">
				<div align="center">Payslip :: <%=com.my.org.erp.ServiceLogin.DateUtil.getMonth(Integer.parseInt(month))+ " - "+year%></div>
				</td>
				<td class="boldEleven">&nbsp;</td>
			</tr>
			<tr>
				<td colspan="6" class="boldEleven">
				<hr width="100%" size="1">
				</td>
			</tr>
			<tr>
				<td width="11" class="boldEleven">&nbsp;</td>
				<td width="119" class="boldEleven">Emp Id</td>
				<td width="170" class="boldEleven">
				<%
								staff =rs.getString("CHR_EMPID");
								out.println(staff.toUpperCase());
								%>
				</td>
				<td width="132" class="boldEleven">Emp Name</td>
				<td width="162" class="boldEleven"><%=rs.getString("CHR_STAFFNAME")%></td>
				<td width="19" class="boldEleven">&nbsp;</td>
			</tr>
			<tr>
				<td class="boldEleven">&nbsp;</td>
				<td class="boldEleven">Department</td>
				<td class="boldEleven"><%=rs.getString("CHR_DEPARTNAME")%></td>
				<td class="boldEleven">No of working Days</td>
				<td class="boldEleven"><%=wrkDays%></td>
				<td class="boldEleven">&nbsp;</td>
			</tr>
			<tr>
				<td class="boldEleven">&nbsp;</td>
				<td class="boldEleven">Designation</td>
				<td class="boldEleven"><%=rs.getString("CHR_DESIGNAME")%></td>
				<td class="boldEleven">No of presents days</td>
				<td class="boldEleven"><%=rs.getString("INT_TOTDAYS")%></td>
				<td class="boldEleven">&nbsp;</td>
			<tr>
				<td class="boldEleven">&nbsp;</td>
				<td class="boldEleven">PF.Number</td>
				<td class="boldEleven"><%=StaffRegistration.pfandEsiRecordExist(staff,0)%></td>
				<td class="boldEleven">E.S.I. Number</td>
				<td class="boldEleven"><%=StaffRegistration.pfandEsiRecordExist(staff,1)%></td>
				<td class="boldEleven">&nbsp;</td>
			</tr>
			<tr>
				<td class="boldEleven">&nbsp;</td>
				<td colspan="2" valign="top" class="boldEleven">
				<div align="left">
				<%
                                	
		
		
		
					
									String afield= StaffRegistration.collectAllowanceField();
                                	String afieldName= StaffRegistration.collectAllowanceFieldName();
                                	String af[] = afield.split("~");
                                	String afields[] = afieldName.split("~");
									double sal=0.0;
									double extrasal=0.0;
									//double 
									out.println("<table border=1  cellspacing=0 cellpadding=3>");
									out.println("<tr><td class='boldEleven' colspan=2 align=center><b>EARNINGS</b>");
									out.println("<tr><td width=100 class='boldEleven'>Basic");
									out.println("<td width=100 class='boldEleven' align =right>"+rs.getString("INT_BASIC"));
									sal = sal+Double.parseDouble(rs.getString("INT_BASIC"));
									sql = "SELECT CHR_ANAME,CHR_FLAG FROM pay_m_allowance";
									String aname[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sql);
									int noofallowance=com.my.org.erp.common.CommonInfo.intRecordCount("Select count(*) from pay_m_allowance");
									String sqlAllTran = "SELECT * FROM pay_t_salaryallowance ";
									sqlAllTran = sqlAllTran + " WHERE CHR_EMPID='" + staff + "'";
									sqlAllTran = sqlAllTran + " AND CHR_MONTH='" + monName+ "' ";
									sqlAllTran = sqlAllTran + " AND INT_YEAR=" + year;
									String avalue[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sqlAllTran);
									for(int u=0;u<aname.length;u++)
									{
										out.print("<tr><td   class='boldEleven'>"+aname[u][0]+"</td>");
										out.print("<td    class='boldEleven'  align ='right'>"+avalue[0][(u+1)]+"</td>");
										if("Y".equals(aname[u][1]))
											sal = sal+Double.parseDouble(avalue[0][(u+1)]);
										else
											extrasal = extrasal+Double.parseDouble(avalue[0][(u+1)]);
											 
									}							
																
									
									 

									 
									out.println("</table>");
									
                                %>
				</div>
				</td>
				<td colspan="2" valign="top" class="boldEleven">
				<div align="left">
				<% 
                                	String rfield= StaffRegistration.collectRecoveryField();
                                	String rfieldName= StaffRegistration.collectRecoveryFieldName();
									String rf[] = rfield.split("~");
                                	String rfields[] = rfieldName.split("~");
									double sal1=0.0;
									out.println("<table border=1 cellspacing=0 cellpadding=3 align=left>");
									out.println("<tr><td class='boldEleven' colspan=2 align=center><b>DEDUCTIONS</b>");
									
											
									
									
									String ksql = "SELECT INT_DUEAMT FROM pay_t_advance WHERE CHR_EMPID='"+staff+"' AND CHR_MONTH ='"+com.my.org.erp.ServiceLogin.DateUtil.getMonth(Integer.parseInt(month))+"' AND INT_YEAR="+Integer.parseInt(year);
									
									String advdata[][] = com.my.org.erp.common.CommonInfo.doubleRecordSetArray(ksql);
									if(advdata.length>0)
									{
										out.println("<tr><td width=100 class='boldEleven'>Advance");
										sal1 = sal1 +Double.parseDouble(advdata[0][0]);
										out.println("<td width=100 class='boldEleven'>"+advdata[0][0]);
									}
									
									sql = "SELECT CHR_RNAME FROM pay_m_recovery";
									String rname[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sql);
									String sqlRecTran = "SELECT * FROM pay_t_salaryrecovery ";
									sqlRecTran = sqlRecTran + " WHERE CHR_EMPID='" + staff + "'";
									sqlRecTran = sqlRecTran + " AND CHR_MONTH='" + monName+ "' ";
									sqlRecTran = sqlRecTran + " AND INT_YEAR=" + year;
									String rvalue[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sqlRecTran);
									for(int u=0;u<rname.length;u++)
									{
										out.print("<tr><td   class='boldEleven'>"+rname[u][0]+"</td>");
										out.print("<td    class='boldEleven'  align ='right'>"+rvalue[0][(u+1)]+"</td>");
										 
											sal1 = sal1+Double.parseDouble(rvalue[0][(u+1)]);
										 
									}
									
									
									
									
									
									
									
									
									
									ksql = "SELECT INT_CASHAMT FROM pay_m_messbill WHERE CHR_EMPID='"+staff+"' AND CHR_MONTH ='"+com.my.org.erp.ServiceLogin.DateUtil.getMonth(Integer.parseInt(month))+"' AND INT_YEAR="+Integer.parseInt(year);
									String messdata[][] = com.my.org.erp.common.CommonInfo.doubleRecordSetArray(ksql);
									if(messdata.length > 0)
									{
										out.print("<tr><td  width=100 class='boldEleven'>Mess Bill</td>");
										out.print("<td  width=50 class='boldEleven'>"+messdata[0][0]+"</td>");
										sal1 = sal1 +Double.parseDouble(messdata[0][0]);
									}
									out.println("</table>");
								%>
				</div>
				</td>
				<td class="boldEleven">&nbsp;</td>
			</tr>
			<tr>
				<td class="boldEleven">&nbsp;</td>
				<td class="boldEleven">Gross Pay</td>
				<td class="boldEleven"><%=Math.round(sal) %></td>
				<td class="boldEleven">P.F</td>
				<td class="boldEleven"><%=rs.getString("INT_PF")%></td>
				<td class="boldEleven">
				<%
									sal1 = sal1+Double.parseDouble(rs.getString("INT_PF"));
								%>
				</td>
			</tr>
			<tr>
				<td class="boldEleven">&nbsp;</td>
				<td class="boldEleven">Extra Loss of Days</td>
				<td class="boldEleven"><%=rs.getString("INT_ELDAYS")%></td>
				<td class="boldEleven">E.S.I</td>
				<td class="boldEleven"><%=rs.getString("INT_ESI")%></td>
				<td class="boldEleven">
				<%
									sal1 = sal1+Double.parseDouble(rs.getString("INT_ESI"));
								%>
				</td>
			</tr>
			<tr>
				<td class="boldEleven">&nbsp;</td>
				<td class="boldEleven">Extra Amount</td>
				<td class="boldEleven"><%=rs.getString("A.CUR_ELAMT")%></td>
				<td class="boldEleven">Gross Deduction</td>
				<td class="boldEleven"><%=Math.round(sal1)%></td>
				<td class="boldEleven">&nbsp;</td>
			</tr>
			<tr>
				<td class="boldEleven">&nbsp;</td>
				<td class="boldEleven">Extra allowance</td>
				<td class="boldEleven"><%=Math.round(extrasal)%></td>
				<td class="boldEleven">&nbsp;</td>
				<td class="boldEleven">&nbsp;</td>
				<td class="boldEleven">&nbsp;</td>
			</tr>
			<tr>
				<td class="boldEleven">&nbsp;</td>
				<td class="boldEleven"><span class="copyright">Net
				Payable</span></td>
				<td class="boldEleven"><span class="copyright"> <%
								//out.println(sal-sal1);
								double loss =Double.parseDouble(rs.getString("INT_ELDAYS"));
								double amt =Double.parseDouble(rs.getString("A.CUR_ELAMT"));
								double npay=0.0;
								if(loss < 0)
								{
								 	npay=Math.round((sal-sal1)-amt+extrasal);
								  out.println( Math.round((sal-sal1)-amt+extrasal));
								}  
								else
								{
								  npay =Math.round((sal-sal1)+amt+extrasal);
								  out.println(Math.round((sal-sal1)+amt+extrasal));
								 } 
								%> </span></td>
				<td class="boldEleven">&nbsp;</td>
				<td class="boldEleven">&nbsp;</td>
				<td class="boldEleven">&nbsp;</td>
			</tr>
			<tr>
				<td class="boldEleven">&nbsp;</td>
				<td colspan="4" class="boldEleven" align="center">
				<DIV id=Rupees><SCRIPT language=javascript>
					  	numberWord("<%=npay%>","Rupees") 
					  </SCRIPT></DIV>
				</td>
				<td class="boldEleven">&nbsp;</td>
			</tr>
			<tr>
				<td class="boldEleven">&nbsp;</td>
				<td colspan="4" class="boldEleven" align="center">&nbsp;</td>
				<td class="boldEleven">&nbsp;</td>
			</tr>
		</table>
		</td>
	</tr>


</table>
<p>
<%
						//out.println("<br><br><br><br><br><br><br><br><br>");
						out.println("<br>");
						}
						
						if(rcount < 1)
						{
							out.println("<br><br><br><br><br><br><br><br><br><center><font color=red><b>");
							out.println("Salary not calculated for the Month :" +month.toUpperCase() + " Year : "+year);
							out.println("</b></font><br><br>");        
							out.println("</b></font><br><br><br></center>");
						}
					}
					catch(Exception e)
					{
						out.println(e);
						e.printStackTrace();
					}	
					%>
</p>
<p align="right"><A href="javascript:window.print()"></A></p>
</center>
</body>

</html>




