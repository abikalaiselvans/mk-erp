<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ include file="index.jsp"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />

<%!	Connection con;
	PreparedStatement pstm;
	ResultSet rst;
	String sql_Select_Query="select * from m_staff";
%>
<html>
<form  AUTOCOMPLETE = "off"   method="post" action="EmployeeReportDetail.jsp">
<body  onpaste='return false;'>
<center>
<table border="1">
	<tr>
		<td>Employee Details</td>
	</tr>
	<tr>
		<td width="164">Employee Name</td>
		<td width="188"><select name="OptEmpName">
			<%
				try
	{
		con = conbean.getConnection();
		pstm = con.prepareStatement(sql_Select_Query);
		rst = pstm.executeQuery();

		while(rst.next())
		{
			
			%>
			<option value=<%=rst.getString("CHR_EMPCODE")%>><%=rst.getString("CHR_EMPCODE")%>
			/<%=rst.getString("CHR_STAFFNAME")%></option>
			<%
		}
	  rst.close();
	  pstm.close();
	   
	}catch(Exception ex)
	{
		//System.out.println(ex);
	}
           
        %>
		</select></td>
	</tr>
	<tr>
		<td><input type="submit" value="submit"></td>
	</tr>
	</center>
	</form>
</body>
</html>
