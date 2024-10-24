
<select name="stype"   id="stype"  class="formText135" style="width:165">
	<option value="0">Select</option>
	<%
	String stafftypesql=" SELECT INT_STAFFTYPEID,CHR_TYPENAME  FROM  com_m_stafftype  ORDER BY CHR_TYPENAME";
	String stafftypeData[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(stafftypesql);
	if (stafftypeData.length>0)
		for (int i=0; i<stafftypeData.length; i++) 
			out.println("<option value='"+stafftypeData[i][1]+"'>"+stafftypeData[i][1] +"</option>");			
	
						%>

</select>


