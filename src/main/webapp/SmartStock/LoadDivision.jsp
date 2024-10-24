
<%
 
 	String divdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVISION from con_inv_m_division ORDER BY CHR_DIVISION ");
 				  for(int y=0; y<divdata.length;y++)
				  	out.println("<option  value='"+divdata[y][0]+"'  >"+divdata[y][1]+ "</option>");	
%>
 