<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />

<%!
	Connection con =null;
	PreparedStatement pstm,pstmall;
	Statement st=null;
	String userid;
	String Sql;
	String empid,Optpf,TxtPfNo,optesi,TxtEsiNo,TxtEsiValue1,fname;
	int TxtPfValue,TxtEsiValue,max;
	String sql_allInsert_Query;
	String all;
	String sqlIns; 
%>
<%
        empid = request.getParameter("ename");
        max=Integer.parseInt(request.getParameter("allsize")); 
        
		con = conbean.getConnection();
	    sqlIns="INSERT INTO PAY_T_RECOVERY VALUES('"+empid +"'";
	    for(int i=1;i<=max;i++)
	    {
	    	all=""+request.getParameter("R00"+i);
   	    	out.println("Allowances are "+all);
   	    	sqlIns=sqlIns+","+all;	      
	    }
	    sqlIns=sqlIns+")";
	    out.println(sqlIns);
		pstm = con.prepareStatement(sqlIns);
		pstm.execute();	    
		pstm.close();
		 
		response.sendRedirect("Recovery Transaction.jsp?message=Recovery Transcation Added Sucessfully");
		%>
