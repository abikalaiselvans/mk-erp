<%@ page import="java.sql.*,java.lang.*,java.io.*,java.util.*,com.my.org.erp.bean.*"%>

<%@include file="Redirect.jsp" %>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<%
		String message;
		ArrayList empdata = new ArrayList();
		
		Connection con1 ;
		PreparedStatement pstm;
		ResultSet rst;	
		String empid;
		con1=conbean.getConnection();
		pstm=con1.prepareStatement("SELECT CHR_EMPID ,CHR_TYPE,DAT_RESIGNDATE  FROM  com_m_staff WHERE  ( DAT_RESIGNDATE is  null OR DAT_RESIGNDATE >= DATE_SUB(DATE(NOW()), INTERVAL 50 DAY) )");
		rst=pstm.executeQuery();
		empid="";
		while(rst.next())
		{
			if(empid.equalsIgnoreCase("")) 
				empid=empid+"('";
			else	
				empid=empid+"','";
			empid=empid+rst.getString(1);			
		}
		if(!empid.equalsIgnoreCase("")) empid=empid+"')";		
		rst.close();
		pstm.close();
		con1.close();
		Connection con=null;
        ResultSet rs=null;
        Statement st=null; 
        String url   = "jdbc:odbc:SmartAttendance";
        String sql=null;	   
        try
        {
    	   Class.forName ("sun.jdbc.odbc.JdbcOdbcDriver");
   	       con = DriverManager.getConnection(url);
           st=con.createStatement(); 
           if(empid.equalsIgnoreCase(""))
		   {
           	  sql="SELECT USERID,NAME FROM USERINFO";
           }
           else
		   {             
        	  sql="SELECT USERID,NAME FROM USERINFO WHERE USERID NOT IN "+empid;  
           }
		  
           rs=st.executeQuery(sql);
           while(rs.next())
		   {
        	   NewEmployee emp=new NewEmployee(rs.getString(1),rs.getString(2));
        	   empdata.add(emp);
           }
           st.close();
 
           if(empdata.size()>0)
        	   message= ""+ empdata.size()+" New Employee Record are Download";
           else
        	   message="There is no new Employee to Download";			
           session.putValue("empdata",empdata);
           session.putValue("message",message);
           response.sendRedirect("ImportEmployees.jsp");
        } 
        catch(Exception e)
        {
        	message="<font color='FF0000'>"+e.getMessage()+"</font>";
            session.putValue("message",message);
            response.sendRedirect("ImportEmployees.jsp");
        	System.out.println(e);
        }
 %>
