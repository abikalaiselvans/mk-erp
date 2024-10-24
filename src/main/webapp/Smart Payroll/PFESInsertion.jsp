<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />

<%!
	Connection con =null;
	PreparedStatement pstm;
	ResultSet rst;
	String userid;
	
	String Sql;
	
	String empid,Optpf,TxtPfNo,optesi,TxtEsiNo,TxtEsiValue1;;
	int TxtPfValue,TxtEsiValue; 
	String sql_Insert_Query ="INSERT INTO PAY_M_PF values(?,?,?,?,?,?,?,?,?,?)";
	%>

<%
        empid = request.getParameter("ename");
		Optpf = request.getParameter("optpf");
		TxtPfNo= request.getParameter("TxtPfNo");
		TxtPfValue = Integer.parseInt(request.getParameter("TxtPfValue"));
		optesi=request.getParameter("optesi");
		TxtEsiNo= request.getParameter("TxtEsiNo");
		TxtEsiValue = Integer.parseInt(request.getParameter("TxtEsiValue"));
		
		con = conbean.getConnection();
		pstm = con.prepareStatement(sql_Insert_Query);
		
	    pstm.setString(1,empid);
		pstm.setString(2,Optpf);
		pstm.setInt(3,TxtPfValue);
		pstm.setString(4,TxtPfNo);
		pstm.setString(5,optesi);
		pstm.setInt(6,TxtEsiValue);
		pstm.setString(7,TxtEsiNo);
		pstm.setString(8,"ADMIN");
		pstm.setString(9,"2006-07-13 00:00:00");
		pstm.setString(10,"Y");
		pstm.executeUpdate();
		
		pstm.close();
		 
		response.sendRedirect("PF_ESI Transaction.jsp?message=PF AND ESI Added Sucessfully");
		%>
