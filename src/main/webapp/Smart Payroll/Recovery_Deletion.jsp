<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<%!
	Connection con ;
	PreparedStatement pstm;
	ResultSet rsdelete;
	int i=0;
	String description;	
%>
<%	
    //Loading JDBC Connection Information
	String sql_Delete_Query ="DELETE FROM PAY_M_RECOVERY where CHR_RCODE=?";
	try
	{
		String []recoveryname = request.getParameterValues("recovery");
		con=conbean.getConnection();
        for(int i=0;i<recoveryname.length;i++)
		{			
			  //System.out.println(recoveryname[i]);
			  pstm = con.prepareStatement(sql_Delete_Query);
			  pstm.setString(1,recoveryname[i]);
			  pstm.execute();			
		}
        response.sendRedirect("Recovery.jsp?message=Recovery Deleted Successfully");
   	}
	catch(Exception ex)
	{
		//System.out.println(ex);
	}
%>
