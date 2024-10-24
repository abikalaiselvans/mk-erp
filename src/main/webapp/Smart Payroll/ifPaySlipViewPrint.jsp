<%@ page import="java.io.*,java.util.*,java.lang.*,java.sql.*"%>
<%@ page import="com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.SmartPayroll.*"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon"></jsp:useBean>
<html>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<style type="text/css">
<!--
.style3 {font-size: 36px}
-->
    </style>

<title> :: PAYROLL ::</title>


 
<body  onpaste="return false;" bgcolor="">
<center>
<%
					String empId,year,month;
					String empName,staff,compId,compName,branchId,branchName;
					//out.println("<br><br><br><br><br><br><br>");
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
						
						String userid = ""+session.getAttribute("USRID");
						String sql ="";						
						sql = "SELECT * FROM M_USER WHERE CHR_USRNAME = '"+userid+"'";
						
						String staffID  = com.my.org.erp.bean.Attendance.StaffRegistration.getAnyValue2(sql,"CHR_USRDES" );
						String monName= DateUtil.getMonth(Integer.parseInt(month));
						out.println("Month : "+monName);
						out.println("Year  : "+year);						
						int year1=Integer.parseInt(year);
        				int days=0;
						days=Integer.parseInt(month);
						
        				int wrkDays=0;						
        				wrkDays=DateUtil.totalDays(days,year1);
        				con=conbean.getConnection();
						st=con.createStatement();
						sql="SELECT A.CHR_EMPID,A.CHR_EMPNAME,A.INT_TOTDAYS,A.INT_BASIC,A.INT_ALLOWANCE,A.INT_ELDAYS,";
						sql = sql +" A.INT_RECOVERY,A.INT_PF,A.INT_ESI,A.CUR_GROSSPAY,A.INT_TOTADV, A.CUR_ELAMT,";
						sql = sql +" A.INT_NETSAL,C.CHR_DEPARTNAME,D.CHR_DESIGNAME FROM PAY_T_NSALARYDETAILSPF A, ";
						sql = sql +"  com_m_staff  B,  com_m_depart   C, com_m_desig  D WHERE A.CHR_EMPID=B.CHR_EMPID AND ";
						sql = sql +" B.INT_DEPARTID=C.INT_DEPARTID AND B.INT_DESIGID=D.INT_DESIGID AND A.CHR_MONTHS='"+monName+"' ";
						sql = sql +" AND A.INT_YEAR="+year +" AND A.CHR_EMPID='"+staffID+"'";
						rs=st.executeQuery(sql);
						int rcount=0;
						String lossofdays="";
						while(rs.next())
						{
							rcount =rcount+1;							
						%>
<table width="762" height="502" border="1" cellpadding="0"
	cellspacing="0" bordercolor="#999999">
	<tr>
		<td height="500">
		<table width="613" height="403" border="0" align="center"
			cellpadding="0" cellspacing="0">
			<!--  <tr>
                                <td colspan="6" class="boldEleven"><div align="center"><img src="../Image/logo.jpg" width="600" height="100"></div></td>
                              </tr>  -->
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
				<td width="162" class="boldEleven"><%=rs.getString("CHR_EMPNAME")%></td>
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
				<td colspan="2" class="boldEleven">
				<%
                                	String afield= StaffRegistration.collectAllowanceField();
                                	String afieldName= StaffRegistration.collectAllowanceFieldName();
                                	String af[] = afield.split("~");
                                	String afields[] = afieldName.split("~");
									double sal=0.0;
									out.println("<table border=1  cellspacing=0 cellpadding=0>");
									out.println("<tr><td class='boldEleven' colspan=2 align=center><b>EARNINGS</b>");
									out.println("<tr><td width=100 class='boldEleven'>Basic");
									out.println("<td width=100 class='boldEleven'>"+rs.getString("INT_BASIC"));
									sal = sal+Double.parseDouble(rs.getString("INT_BASIC"));
									
									for(int u=0; u<afields.length; u++)
									{
										out.print("<tr><td width=100 class='boldEleven'>"+afields[u]+"</td>");
										out.print("<td  width=50 class='boldEleven'>"+StaffRegistration.getAllowanceSalaryDetails(staff,af[u])+"</td>");
										sal = sal+Double.parseDouble(StaffRegistration.getAllowanceSalaryDetails(staff,af[u]));
							}
									out.println("</table>");
                                %>
				</td>
				<td colspan="2" class="boldEleven">
				<% 
                                	String rfield= StaffRegistration.collectRecoveryField();
                                	String rfieldName= StaffRegistration.collectRecoveryFieldName();
									String rf[] = rfield.split("~");
                                	String rfields[] = rfieldName.split("~");
									double sal1=0.0;
									out.println("<table border=1 cellspacing=0 cellpadding=0>");
									out.println("<tr><td class='boldEleven' colspan=2 align=center><b>DEDUCTIONS</b>");
									out.println("<tr><td width=100 class='boldEleven'>Advance");
									out.println("<td width=100 class='boldEleven'>"+rs.getString("INT_TOTADV"));
									sal = sal +Double.parseDouble(rs.getString("INT_TOTADV"));
									for(int u=0; u<rfields.length; u++)
									{
										out.print("<tr><td  width=100 class='boldEleven'>"+rfields[u]+"</td>");
										out.print("<td  width=50 class='boldEleven'>"+StaffRegistration.getRecoverySalaryDetails(staff,rf[u])+"</td>");
										sal1 = sal1 +Double.parseDouble(StaffRegistration.getRecoverySalaryDetails(staff,rf[u]));
									}
									out.println("</table>");
								%>
				</td>
				<td class="boldEleven">&nbsp;</td>
			</tr>
			<tr>
				<td class="boldEleven">&nbsp;</td>
				<td class="boldEleven">Gross Pay</td>
				<td class="boldEleven"><%=sal%></td>
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
				<td class="boldEleven"><%=sal1%></td>
				<td class="boldEleven">&nbsp;</td>
			</tr>
			<tr>
				<td class="boldEleven">&nbsp;</td>
				<td class="boldEleven">&nbsp;</td>
				<td class="boldEleven">&nbsp;</td>
				<td class="boldEleven">&nbsp;</td>
				<td class="boldEleven">&nbsp;</td>
				<td class="boldEleven">&nbsp;</td>
			</tr>
			<tr>
				<td class="boldEleven">&nbsp;</td>
				<td class="boldEleven">Net Payable</td>
				<td class="boldEleven">
				<%
								//out.println(sal-sal1);
								double loss =Double.parseDouble(rs.getString("INT_ELDAYS"));
								double amt =Double.parseDouble(rs.getString("A.CUR_ELAMT"));
								if(loss < 0)
								  out.println((sal-sal1)-amt);
								else
								  out.println((sal-sal1)+amt);
								%>
				</td>
				<td class="boldEleven">&nbsp;</td>
				<td class="boldEleven">&nbsp;</td>
				<td class="boldEleven">&nbsp;</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<%
						//out.println("<br><br><br><br><br><br><br><br><br>");
						out.println("<br>");
						}
						
						if(rcount < 1)
						{
							out.println("<br><br><br><br><br><br><br><br><br><center><font color=red><b>");
							out.println("Salary not calculated for the Month :" +month.toUpperCase() + " Year : "+year);
							out.println("</b></font><br><br>");
							out.println("<a href='redirect('Payrollmain.jsp')'>close</a>");
							out.println("</b></font><br><br><br></center>");
						}
					}
					catch(Exception e)
					{
						out.println(e);
						e.printStackTrace();
					}	
					%> <a href="javascript:self.close()">Close</a></center>
</body>
</html>
