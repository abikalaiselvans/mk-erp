
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<table width="99%" height="500" border="0" cellpadding="0" cellspacing="0">
  <tbody>
    <tr>
      <td height="416" align="left" class="bolddeepred">
	  
	  
	  <%
	  String empid = ""+session.getAttribute("EMPID");
	  String sql = "";
 sql = " SELECT a.CHR_EMPID,a.CHR_STAFFNAME ,concat(b.CHR_PFNUMBER,a.CHR_PFNO) FROM com_m_staff  a   ,com_m_company b WHERE  a.INT_COMPANYID = b.INT_COMPANYID AND a.CHR_EMPID='"+empid+"' ";
	  String rowdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	 
	  %>
	    <div align="center">
		<%=rowdata[0][0]+ " / "+ rowdata[0][1]%>
		<br />
		RESIGNED STAFF BUT PF CLAIM NOT COMPLETED....<br />
			PF Number : <%=rowdata[0][2]%>
		 </div></td>
    </tr>
  </tbody>
</table>
 