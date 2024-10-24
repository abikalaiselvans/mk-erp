<%@ page import="java.io.*,java.util.*,java.lang.*,java.sql.*"%>
<%@ page import="com.my.org.erp.ServiceLogin.*"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon"></jsp:useBean>
<%
String empId,year,month;
Connection con;
Statement st;
ResultSet rs=null;                                                                                              
%>

<html>
<body  onpaste="return false;" bgcolor="">
<center>
<table>
	<tr>
		<td>
		<%	year=request.getParameter("year");					
		month=request.getParameter("month");
		int year1=Integer.parseInt(year);
        int days=0;
        int wrkDays=0;
        //System.out.println("month:"+month);
        //days=DateUtil.getMonthNumber(month);
        wrkDays=DateUtil.totalDays(days,year1);
							%> <%
								try{
									con=conbean.getConnection();
									st=con.createStatement();
									String sql="Select A.CHR_EMPID,A.CHR_EMPNAME,A.INT_TOTDAYS,A.INT_BASIC,A.INT_ALLOWANCE,A.INT_RECOVERY,A.INT_PF,A.INT_ESI,A.CUR_GROSSPAY,A.INT_TOTADV,";					
									sql=sql+"A.INT_NETSAL,C.CHR_DEPARTNAME,D.CHR_DESIGNAME FROM PAY_T_NSALARYDETAILSPF A, com_m_staff  B,  com_m_depart   C, com_m_desig  D WHERE A.CHR_EMPID=B.CHR_EMPID AND ";
									sql=sql+ "B.INT_DEPARTID=C.INT_DEPARTID AND B.INT_DESIGID=D.INT_DESIGID AND A.CHR_MONTHS='"+month+"' AND A.INT_YEAR="+year;
									rs=st.executeQuery(sql);					
								while(rs.next()){									
							%>
		</td>
	</tr>
</table>

<table border="1" width="70%">
	<tr>
		<td>
		<table>
			<!--DWLayoutTable-->
			<tr>
				<td width="158" height="21" align="left">Staff Name& No:&nbsp;<%=rs.getString("CHR_EMPID")%>&nbsp;&nbsp;&nbsp;<%=rs.getString("CHR_EMPNAME")%></TD>
				<td width="155">&nbsp;</td>
				<td width="91">&nbsp;</td>
				<td width="21">&nbsp;</td>
			<tr>
				<td height="21" valign="top">Department: <%=rs.getString("CHR_DEPARTNAME")%></td>
				<td>&nbsp;</td>
				<td valign="top">Working Days:</td>
				<td><%=wrkDays%></td>
				<td width="57">&nbsp;</td>
			</tr>
			<tr>
				<td height="21" valign="top">Designation: <%=rs.getString("CHR_DESIGNAME")%></td>
				<td>&nbsp;</td>
				<td valign="top">Present Days:</td>
				<td><%=rs.getString("INT_TOTDAYS")%></td>
			</tr>
			<tr>
				<td height="21" valign="top">Pf No.:</td>
				<td>&nbsp;</td>
				<td valign="top">E.S.I No.</td>
				<td>&nbsp;</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

<table border="1" width="70%">
	<tr>
		<td>
		<table>
			<!--DWLayoutTable-->

			<tr>
				<td height="21" align="center" colspan="2">EARNINGS</td>
				<td width="256"></td>
				<td width="136" align="center" valign="top">DEDUCTIONS</td>
				<td width="1">&nbsp;</td>
				<td width="25">&nbsp;</td>
				<td width="2">&nbsp;</td>
				<td width="1">&nbsp;</td>
				<td width="1">&nbsp;</td>
				<td width="1">&nbsp;</td>
				<td width="45">&nbsp;</td>
			</tr>

			<tr>
				<td height="21">Basic</td>
				<td><%=rs.getString("INT_BASIC")%></td>
				<td>&nbsp;</td>
				<td valign="top">Advance</td>
				<td colspan="6" valign="top"><%=rs.getString("INT_TOTADV")%></td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td height="21">Allowance1</td>
				<td><%=rs.getString("INT_ALLOWANCE")%></td>
				<td>&nbsp;</td>
				<td valign="top">Recovery1</td>
				<td colspan="5" valign="top"><%=rs.getString("INT_RECOVERY")%></td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td height="21">Allowance2</td>
				<td><%=rs.getString("INT_ALLOWANCE")%></td>
				<td>&nbsp;</td>
				<td valign="top">Recovery2</td>
				<td colspan="4" valign="top"><%=rs.getString("INT_RECOVERY")%></td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td height="21">Allowance3</td>
				<td><%=rs.getString("INT_ALLOWANCE")%></td>
				<td>&nbsp;</td>
				<td valign="top">Recovery3</td>
				<td colspan="3" valign="top"><%=rs.getString("INT_RECOVERY")%></td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td height="21">Allowance4</td>
				<td><%=rs.getString("INT_ALLOWANCE")%></td>
				<td>&nbsp;</td>
				<td valign="top">Recovery4</td>
				<td colspan="3" valign="top"><%=rs.getString("INT_RECOVERY")%></td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td height="21">Allowance5</td>
				<td><%=rs.getString("INT_ALLOWANCE")%></td>
				<td>&nbsp;</td>
				<td valign="top">Recovery5</td>
				<td>&nbsp;</td>
				<td colspan="2" valign="top"><%=rs.getString("INT_RECOVERY")%></td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td height="21">Allowance6</td>
				<td><%=rs.getString("INT_ALLOWANCE")%></td>
				<td>&nbsp;</td>
				<td valign="top">P.F</td>
				<td>&nbsp;</td>
				<td valign="top"><%=rs.getString("INT_PF")%></td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td height="21">Allowance7</td>
				<td><%=rs.getString("INT_ALLOWANCE")%></td>
				<td>&nbsp;</td>
				<td valign="top">E.S.I</td>
				<td>&nbsp;</td>
				<td valign="top"><%=rs.getString("INT_ESI")%></td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td height="40">Gross Pay</td>
				<td><%=rs.getString("CUR_GROSSPAY")%></td>
				<td>&nbsp;</td>
				<td colspan="2" valign="top">Gross Deduction</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td height="21">Net Payable</td>
				<td><%=rs.getString("INT_NETSAL")%></td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			</td>
			</tr>
		</table>
		<%	}
					}
					catch(Exception e)
					{
					//System.out.println(e);
					}
				%>
		
</table>
</td>
</tr>
</table>
</center>
</body>
<%@ include file="../footer.jsp"%>
</html>




