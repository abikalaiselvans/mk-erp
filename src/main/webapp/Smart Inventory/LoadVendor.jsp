
<%
 
 	String vendata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_VENDORID,CHR_VENDORNAME FROM  inv_m_vendorsinformation   WHERE INT_ACTIVE<>'Y' ORDER BY CHR_VENDORNAME");
 				  for(int y=0; y<vendata.length;y++)
				  	out.println("<option  value='"+vendata[y][0]+"'  >"+vendata[y][1]+ "</option>");	
%>
