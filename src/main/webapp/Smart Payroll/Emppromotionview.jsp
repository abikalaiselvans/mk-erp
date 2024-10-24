<%@ include file="Connection.jsp"%>
<%
      
      String str=null;
      


      str="select * from m_staff";
      rs=st.executeQuery(str);
    
      if(rs.next())
      {
%>
 

<table>
	<tr>
		<td>Employee Name</td>
	</tr>
	<select class="tabledata">
		<%
             do
             {
             
%>
		<option><%=rs.getString("CHR_STAFFNAME")%></option>



		<%

            }while(rs.next());     

%>
	</select>


	<%



      } 
      else
      {

%>
	<table>
		<tr>
			<td></td>
		</tr>
	</table>

	<%
      }  
    
%>
