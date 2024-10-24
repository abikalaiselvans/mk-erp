 <%

	 String usertypes=""+session.getAttribute("USRTYPE");
	  if("F".equals(usertypes))
	  {
	
	String bdatas[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_BRANCHID,CHR_BRANCHNAME FROM com_m_branch WHERE INT_COMPANYID="+session.getAttribute("ACCCOMPANY"));
	for(int u=0;u<bdatas.length;u++)	
		out.println("<option value='"+bdatas[u][0]+"'>"+bdatas[u][1]+"</option>");
	}
	else
	{
		String bdatas[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_BRANCHID,CHR_BRANCHNAME FROM com_m_branch WHERE INT_COMPANYID="+session.getAttribute("ACCCOMPANY") +" AND INT_BRANCHID="+session.getAttribute("ACCBRANCH"));
	for(int u=0;u<bdatas.length;u++)	
		out.println("<option value='"+bdatas[u][0]+"'>"+bdatas[u][1]+"</option>");
	
	}
				 
						
 %>