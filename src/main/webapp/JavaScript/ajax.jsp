<%@ page import="com.my.org.erp.common.*, com.my.org.erp.ServiceLogin.*"%>

<%
try
{
%>
 

 
<table width="64%" border="0" align="center" cellpadding="2" cellspacing="2"
	 >
	<!--DWLayoutTable-->
	<tr class="tabledata">
		<td width="109" height="33" align="left" valign="middle"
			class="boldEleven">
	  <% 
	   String branchid=""+session.getAttribute("BRANCHID");
	   String oficeid=""+session.getAttribute("OFFICEID");
	   String usertype=""+session.getAttribute("USRTYPE");
	   String userid=""+session.getAttribute("USRID");
	   String category=""+session.getAttribute("CATEGORY");
	   String departmenid=""+session.getAttribute("DEPARTID");
	   
	   String lock="";
	   %> Office</td>
		<td width="90" height="33" align="left" valign="middle"
			class="boldEleven">
		
		 	 
			<select name="office" class="formText135" style="width:150"	id="office" tabindex="6" onchange="init()" <%=lock%>>
			<option value='0' >All</option>
			<%
		 
			
	String OfficeData[][] =  CommonFunctions.QueryExecute(" SELECT b.INT_OFFICEID,b.CHR_OFFICENAME FROM  com_m_office  b WHERE b.INT_OFFICEID IN("+ CommonFunctions.QueryExecute("SELECT a.CHR_OFFICELIST FROM m_user a WHERE a.CHR_USRNAME='"+userid+"' ")[0][0]+" )");
 if(OfficeData.length>0)
 	for(int u=0;u<OfficeData.length;u++)
		out.println("<option value='"+OfficeData[u][0]+"'>"+OfficeData[u][1]+"</option>");
		
 %>
	  </select><script language="javascript">setOptionValue('office','<%=oficeid%>')</script></td>
		<td width="10" rowspan="6" valign="top" class="boldEleven">&nbsp;		 </td>
		<td width="220" rowspan="6" valign="top" class="boldEleven">
		<div class="boldEleven" style="width:100%" id="staffloaddescription"></div>	  </td>
	</tr>
	<tr class="tabledata">
		<td height="33" align="left" valign="middle" class="boldEleven">Department</td>
		<td height="33" align="left" valign="middle" class="boldEleven">
		<select name="dept" id="dept" class="formText135" onchange="init()" style="width:150"	>
			<option value='0' >All</option>
			<%
			//if("F".equals(usertype)  || "B".equals(usertype) ) 
				//out.print("<option value='0' >All</option>");
		
		   %>
			
			<%
		String sq="SELECT INT_DEPARTID,CHR_DEPARTNAME FROM   com_m_depart   ORDER BY  CHR_DEPARTNAME";
		String deptid[][] =  CommonFunctions.QueryExecute(sq);
		
		if("F".equals(usertype)  || "B".equals(usertype) ) 
		{
			for(int u=0;u<deptid.length;u++)
				out.print("<option value='"+deptid[u][0]+"'>"+deptid[u][1]+"</option>"); 
		}
		else
		{
			for(int u=0;u<deptid.length;u++)
				if(departmenid.equals(deptid[u][0]))
					out.print("<option value='"+deptid[u][0]+"'>"+deptid[u][1]+"</option>"); 
		}		
	%>
		</select><script language="javascript">setOptionValue('dept','<%=departmenid%>')</script></td>
	</tr>
	<tr class="tabledata">
	  <td height="33" align="left" valign="middle" class="boldEleven">Category</td>
	  <td height="33" align="left" valign="middle" class="boldEleven">
	  
	  <select name="Category" class="formText135" id="Category"  onchange="init()" style="width:150"	>
	  <option value='0' >All</option>
<%
 
String empcategoryData[][] =  CommonFunctions.QueryExecute(" SELECT b.INT_EMPLOYEECATEGORYID,b.CHR_CATEGORYNAME FROM  com_m_employeecategory  b WHERE b.INT_EMPLOYEECATEGORYID IN("+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT a.CHR_GATEGORYLIST  FROM m_user a WHERE a.CHR_USRNAME='"+userid+"' ")[0][0]+" )");
 if(empcategoryData.length>0)
 	for(int u=0;u<empcategoryData.length;u++)
		out.println("<option value='"+empcategoryData[u][0]+"'>"+empcategoryData[u][1]+"</option>");
 %>

</select>
<script language="javascript">setOptionValue('Category','<%=category%>')</script>
 </td>
  </tr>
	 
	<tr class="tabledata">
		<td height="33" align="left" valign="middle" class="boldEleven">Search By Name/Id       </td>
		<td height="33" align="left" valign="middle" class="boldEleven"><input
			size="15" maxlength="20" type=text name="com-Id" id="com-Id"
			onkeyup="upperMe(this),makeGetRequest(this)" class="formText135" /></td>
	</tr>
	<tr class="tabledata">
		<td height="33" align="left" valign="middle" class="boldEleven">Exclusive of resigned</td>
		<td align="left" valign="middle" class="boldEleven"><input
			name="Resigned" type="checkbox" id="Resigned"
			onclick="init()" value="Y" checked="checked" /></td>
	</tr>
</table>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
	System.out.println(e.getMessage());
}

%>
