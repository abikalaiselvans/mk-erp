<%@include file="Redirect.jsp" %>

<%
 
 
 String custdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT a.INT_CUSTOMERID,f.CHR_NAME,a.CHR_CONTACTPERSON, e.CHR_CITYNAME,d.CHR_DISTRICT,c.CHR_STATENAME,  CONCAT('PIN :',a.INT_PINCODE),CONCAT('MOBILE :',a.CHR_MOBILE),CONCAT('Phone :',a.CHR_PHONE),CONCAT('E-Mail :',a.CHR_EMAIL) FROM  inv_m_customerinfo a, com_m_country b,com_m_state c,com_m_district d,com_m_city e  ,inv_m_customergroup f   WHERE a.INT_CUSTOMERGROUPID = f.INT_CUSTOMERGROUPID   AND a.INT_COUNTRYID = b.INT_COUNTRYID    AND a.INT_STATEID =c.INT_STATEID    AND a.INT_DISTRICTID= d.INT_DISTRICTID   AND a.INT_CITYID =e.INT_CITYID AND   a.INT_ACTIVE =1 AND a.CHR_VERIFIED ='Y' ORDER BY f.CHR_NAME");
for(int y=0; y<custdata.length;y++)
	out.println("<option  value='"+custdata[y][0]+"'>"+custdata[y][1]+ " ,"+custdata[y][2]+ "  ,"+custdata[y][3]+ "  ,"+custdata[y][4]+ "  ,"+custdata[y][5]+ "  ,"+custdata[y][6]+ "</option>");	
%>
