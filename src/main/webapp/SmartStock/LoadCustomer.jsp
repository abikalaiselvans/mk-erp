
<%
 
 	String custdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_CUSTOMERID ,CHR_CUSTOMERNAME FROM con_inv_m_customerinfo WHERE INT_BRANCHID= "+session.getAttribute("STKBRANCH")+"  ORDER BY CHR_CUSTOMERNAME");
 				  for(int y=0; y<custdata.length;y++)
				  	out.println("<option  value='"+custdata[y][0]+"'>"+custdata[y][1]+ "</option>");	
%>
