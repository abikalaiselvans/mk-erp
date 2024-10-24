

<%
try
{
%>
<style type="text/css">
<!--
.style3 {color: #FF0000}
-->
</style>

 
<link href="../DropDown - Image/msdropdown/dd.css" rel="stylesheet" type="text/css">

<script type="text/javascript" src="../DropDown - Image/msdropdown/js/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="../DropDown - Image/msdropdown/js/uncompressed.jquery.dd.js"></script>

 
<link href="SmartStyles.css" rel="stylesheet" type="text/css" />
<table width="70%" height="276" border="0" align="center" cellpadding="2" cellspacing="2"
	 >
	<!--DWLayoutTable-->
	<tr class="tabledata">
		<td width="205" height="33" align="left" valign="middle"
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
		<td width="220" height="33" align="left" valign="middle"
			class="boldEleven">
			
			<select name="office" class="formText135"	id="office" tabindex="6" onchange="init()" <%=lock%>>
			<option value='0' >All</option>
			<%
		 
			
	String OfficeData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(" SELECT b.INT_OFFICEID,b.CHR_OFFICENAME FROM  com_m_office  b WHERE b.INT_OFFICEID IN("+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT a.CHR_OFFICELIST FROM m_user a WHERE a.CHR_USRNAME='"+userid+"' ")[0][0]+" )");
 if(OfficeData.length>0)
 	for(int u=0;u<OfficeData.length;u++)
		out.println("<option value='"+OfficeData[u][0]+"'>"+OfficeData[u][1]+"</option>");
 %>
	  </select><script language="javascript">setOptionValue('office','<%=oficeid%>')</script></td>
		<td width="7" rowspan="7" valign="top" class="boldEleven">&nbsp;		 </td>
		<td width="315" rowspan="7" valign="top" class="boldEleven">
	  <div class="boldEleven" style="width:100%" id="staffloaddescription"></div>	  </td>
	</tr>
	<tr class="tabledata">
		<td height="33" align="left" valign="middle" class="boldEleven">Department</td>
		<td height="33" align="left" valign="middle" class="boldEleven">
		<select name="dept" id="dept" class="formText135" onchange="init()">
			<option value='0' >All</option>
			<%
			//if("F".equals(usertype)  || "B".equals(usertype) ) 
				//out.print("<option value='0' >All</option>");
		
		   %>
			
			<%
		String sq="SELECT INT_DEPARTID,CHR_DEPARTNAME FROM   com_m_depart   ORDER BY  CHR_DEPARTNAME";
		String deptid[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sq);
		
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
	  
	  <select name="Category" class="formText135" id="Category"  onchange="init()">
	  <option value='0' >All</option>
<%
 
String empcategoryData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(" SELECT b.INT_EMPLOYEECATEGORYID,b.CHR_CATEGORYNAME FROM  com_m_employeecategory  b WHERE b.INT_EMPLOYEECATEGORYID IN("+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT a.CHR_GATEGORYLIST  FROM m_user a WHERE a.CHR_USRNAME='"+userid+"' ")[0][0]+" )");
 if(empcategoryData.length>0)
 	for(int u=0;u<empcategoryData.length;u++)
		out.println("<option value='"+empcategoryData[u][0]+"'>"+empcategoryData[u][1]+"</option>");
 %>
</select>
<script language="javascript">setOptionValue('Category','<%=category%>')</script> </td>
  </tr>
	 
	<tr class="tabledata">
		<td height="33" align="left" valign="middle" class="boldEleven">Search By Name/Id       </td>
		<td height="33" align="left" valign="middle" class="boldEleven"><input
			size="15" maxlength="20" type=text name="com-Id" id="com-Id"
			onkeyup="upperMe(this),makeGetRequest(this)" class="formText135" /></td>
	</tr>
	<tr class="tabledata">
		<td height="33" align="left" valign="middle" class="boldEleven">Regined
		not show </td>
		<td align="left" valign="middle" class="boldEleven"><input
			name="Resigned" type="checkbox" id="Resigned"
			onclick="init()" value="Y" checked="checked" /></td>
	</tr>
	<tr class="tabledata">
	  <td height="33" align="left" valign="middle" class="boldEleven">Export Type <span class="bolddeepred">*</span> </td>
	  <td align="left" valign="middle" class="boldEleven"><script language="javascript" type="text/javascript">
	$(document).ready(function() 
	{
		try 
		{
			$("#reportType").msDropDown();
			
		} 
		catch(e) 
		{
				
		}
	}
	)
</script>
  <select name="reportType" id="reportType" style="width:170px;" >
    <option value="0" title="../DropDown - Image/icons/export.jpg" selected="selected">Export Type</option>
    <option value="csv" title="../DropDown - Image/icons/csv.jpg">CSV </option>
    <option value="xls" title="../DropDown - Image/icons/excel.jpg">Excel </option>
    <option value="html" title="../DropDown - Image/icons/html.jpg">Html </option>
    <option value="pdf" title="../DropDown - Image/icons/pdf.jpg">Pdf </option>
    <option value="rtf" title="../DropDown - Image/icons/rtf.jpg">Rtf </option>
    <option value="txt" title="../DropDown - Image/icons/txt.jpg">Txt </option>
    <option value="xml" title="../DropDown - Image/icons/xml.jpg">Xml </option>
  </select></td>
  </tr>
</table>
<%
}
catch(Exception e)
{
}

%>
