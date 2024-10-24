
<%
String csql="";
String usertypes=""+session.getAttribute("USRTYPE");	


csql="";
csql=csql +"SELECT a.INT_CUSTOMERID,f.CHR_NAME,a.CHR_CONTACTPERSON,e.CHR_CITYNAME,d.CHR_DISTRICT,c.CHR_STATENAME,CONCAT('PIN :',a.INT_PINCODE),";
csql=csql +"CONCAT('MOBILE :',a.INT_MOBILE1),CONCAT('Phone :',a.INT_PHONE1),CONCAT('E-Mail :',a.CHR_EMAIL)  ";
csql=csql +"FROM  mkt_m_customerinfo a, com_m_country b,com_m_state c,com_m_district d,com_m_city e  ,mkt_m_customername f    ";
csql=csql +"WHERE a.INT_CUSTOMERNAMEID = f.INT_CUSTOMERNAMEID   AND a.INT_COUNTRYID = b.INT_COUNTRYID     ";
csql=csql +"AND a.INT_STATEID =c.INT_STATEID AND a.INT_DISTRICTID= d.INT_DISTRICTID   AND a.INT_CITYID =e.INT_CITYID   ";
if("A".equals(usertypes) || "S".equals(usertypes))
	csql = csql + " AND a.CHR_HOLDER='"+session.getAttribute("EMPID")+"' ";
csql=csql +"AND a.CHR_VERIFY ='Y' ORDER BY f.CHR_NAME ";
String custdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(csql);
 
for(int y=0; y<custdata.length;y++)
	out.println("<option  value='"+custdata[y][0]+"'>"+custdata[y][1]+ " ,"+custdata[y][2]+ "  ,"+custdata[y][3]+ "  ,"+custdata[y][4]+ "  ,"+custdata[y][5]+ "  ,"+custdata[y][6]+ "</option>");	
%>
