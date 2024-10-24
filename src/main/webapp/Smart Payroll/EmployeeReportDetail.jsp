<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ include file="index.jsp"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />

<%!	Connection con;
	PreparedStatement pstm;
	ResultSet rst;
	String sql_Select_Query="select * from m_staff where empcode=?";
%>

<html>
<body  onpaste='return false;'>
<table>
	<tr>
		<td>Office Name</td>
		<%try{
			con=conbean.getConnection();
			//pstm=con.prepareStatement();
		}
		catch(Exception e)
		{
			
		}
		%>
		<td><input type="text" name="TxtOffice"></td>
	</tr>
	<tr>
		<td>Designation</td>
		<td><input type="text" name="TxtDesignation"></td>
	</tr>
	<tr>
		<td>Employee Qualification</td>
		<td><input type="text" name="TxtEmpQualify"></td>
	</tr>
	<tr>
		<td>Particulars</td>
		<td><textarea name="TxtParticulars"></textarea></td>
	</tr>
	<tr>
		<td><input type="submit" value="submit"></td>
	</tr>
</table>
</body>
</html>





