<%@ page import="java.sql.*"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<%
	try{ 
	Connection con=conbean.getConnection();
     Statement st=con.createStatement();      
	 ResultSet rs,rs1=null;
	 int count=0;
	 String catid=request.getParameter("catId");
	 String sql="SELECT COUNT(*) FROM INV_M_ITEM WHERE INT_CATEGORYID='"+catid+"'"; 
	 rs=st.executeQuery(sql); 
	 while(rs.next())
	 {
	     count=rs.getInt(1);
	 }
	 // //System.out.println("count ---------------------------"+count );		 
	 if(count!=0)
	 {
	     String str="SELECT CHR_ITEMCODE,CHR_ITEMNAME FROM INV_M_ITEM WHERE INT_CATEGORYID='"+catid+"'";
         rs1=st.executeQuery(str);        
         %>
<select name="itemId">
	<%
		  while(rs1.next())
		     {					  
			  out.println("<option value='"+rs1.getString("CHR_ITEMCODE")+"'>");					
  			  out.println(rs1.getString("CHR_ITEMNAME")+"</option>");		 
		     }
			  out.println("</select>");
		 }
		 else
	 {
	   out.println("<option>Select</option>");	 
	 }	    
	}
	catch(Exception e)
	{
		  out.println("<font color='#FF0000'>Ajax Error</font>");	 
		  e.printStackTrace();
	}
%>
