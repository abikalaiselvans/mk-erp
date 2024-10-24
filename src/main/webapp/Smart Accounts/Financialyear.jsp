<table width="181" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="84">Financial Year </td>
    <td width="97">
	<select name="Financialyear" id="Financialyear">
	<%
		
		String CurrentFinancialYear = com.my.org.erp.common.CommonFunctions.CurrentFinancialYear();
		String ydata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_FINANCIALYEARID,CHR_FINANCIALYEAR FROM  com_m_financialyear ORDER BY INT_FINANCIALYEARID");
		for(int u=0;u<ydata.length;u++)
			if(CurrentFinancialYear.equals(ydata[u][1]))
				out.println("<option selected='selected' value='"+ydata[u][0]+"'>"+ydata[u][1]+"</option>");
			else
				out.println("<option   value='"+ydata[u][0]+"'>"+ydata[u][1]+"</option>");	
			
	%>
    </select>
    </td>
  </tr>
</table>
 