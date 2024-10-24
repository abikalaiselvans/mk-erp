 

<% 
try
{
	String r=request.getParameter("id").trim();
	int id = Integer.parseInt(r);
	String queryBranch="SELECT INT_BRANCHID,INT_COMPANYID,CHR_BRANCHNAME FROM  com_m_branch  WHERE INT_COMPANYID="+id;
	
	%>

<select name="branch" id="branch" class="tabledata">
	<%                  
     	if(id >= 0)
		{
	String	branch[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(queryBranch);
	  	for(int i=0;i<=branch.length;i++)
 	 		out.println("<option value='"+branch[i][0]+"'>"+branch[i][2]+"</option>");
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
