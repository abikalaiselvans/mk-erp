
<%
 	String query = "SELECT CHR_ITEMID,CHR_ITEMNAME FROM inv_m_item";
	String idata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(query);
	 for(int y=0; y<idata.length;y++)
	 	out.println("<option  value='"+idata[y][0].trim()+"'  >"+idata[y][1] +"</option>");	
		
%>
