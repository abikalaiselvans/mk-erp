
<% 
try
{
	String type=request.getParameter("id").trim();
	String sql = "";
	if(type.equals("C"))
    	sql = "SELECT INT_CUSTOMERID, CHR_CUSTOMERNAME from inv_m_customerinfo  ORDER BY CHR_CUSTOMERNAME";
    if(type.equals("N"))
    	sql = " SELECT INT_CUSTOMERID, CHR_CUSTOMERNAME from inv_m_servicecustomerinfo ORDER BY CHR_CUSTOMERNAME";
    
    String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
%>

<select name="customerid" id="customerid" class="tabledata">
	<%                  
			if(readData.length >= 0)
			{
				for(int i=0;i<readData.length;i++)
					out.println("<option value='"+readData[i][0]+"'>"+readData[i][1]+"</option>");
			}
			else
			{
			out.println("<option>Data not found..</option>");
			}
				
		%>
</select>

<%
}
catch(Exception e)
{
}

%>
