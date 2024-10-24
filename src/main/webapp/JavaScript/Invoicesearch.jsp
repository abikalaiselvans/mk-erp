 <table  border="0" cellpadding="2" cellspacing="2">
  <tr>
    <td valign="top" class="boldred">Branch</td>
    <td height="23" valign="top" class="boldEleven">
<%
		String usertype=""+session.getAttribute("USRTYPE");
		String branchid = ""+session.getAttribute("BRANCHID");
		String dis="";
		if(!"F".equals(usertype))
			dis=" disabled='disabled' ";
%>
<select  class="formText135" id="branch"  name="branch"   <%=dis%> onChange="init()" >
<%
	 
		String ssql= " Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID ";
		String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(ssql);	
		for(int u=0;u<data.length;u++)
			out.print("<option value='"+data[u][0]+"'>"+data[u][2]+" @ "+data[u][1]+"</option>");
%>
</select>

<script language="javascript">
	setOptionValue("branch","<%=branchid%>") 
</script>

	</td>
    <td width="250" rowspan="5" class="boldEleven"><div class="boldEleven" id="description"></div></td>
  </tr>
  <tr>
    <td width="126" valign="top" class="boldred">Filter with Month &amp; Year </td>
    <td width="118" height="23" valign="top" class="boldEleven"><input name="Flag" type="checkbox" id="Flag" value="Y" checked onClick="init()"></td>
  </tr>
  <tr valign="top">
    <td class="boldEleven">Month</td>
    <td height="23" class="boldEleven"><select name="month" id="month" onchange="init()" >
							<%@ include file="../JavaScript/Inventory/month.jsp"%>
	</select></td>
  </tr>
  <tr valign="top">
    <td class="boldEleven">Year</td>
    <td height="23" class="boldEleven"><select name="year" id="year" onchange="init()">
							<%@ include file="../JavaScript/Inventory/year.jsp"%>
	</select> <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						setOptionValue('month',month1);
						setOptionValue('year',year1);							
				//-->
          </script></td>
  </tr>
  <tr valign="top">
    <td class="boldEleven">Search customer name </td>
    <td height="23" class="boldEleven"><input
			size="15" maxlength="20" type=text name="searchstring" id="searchstring"
			onKeyUp="upperMe(this),init()" class="formText135" /></td>
  </tr>
  <tr valign="top">
    <td height="23" colspan="3" class="boldEleven">
						 	  </td>
  </tr>
</table>
 